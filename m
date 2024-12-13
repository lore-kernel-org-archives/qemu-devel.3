Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4015EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB6m-0005sh-QH; Fri, 13 Dec 2024 14:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6k-0005fz-2F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:50 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6h-0007Sy-IX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:49 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb7f3b1342so910410b6e.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117226; x=1734722026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I71WCIZYeQ5yV8uCldLsOTnUpTDKGYy0sk8GaKQTI8=;
 b=Cp97yayDM4zb9c9kRp16YDDMfoZLMRp6QXyG0Z2dgm+1SREITx+uUauiHPi2rNoby6
 lRSc5RncSifJ2Au8JiHt1d5zotJYrCrXFIaaCa3sWeYlmgMwOGdpXaiNjteFQUx/Zv9h
 j4GojxcE4lPPsWVQDzVAQ2dei5OPWTE/vFPQQiQfqN6epy4btllB5+08/BePd48Dmmu2
 xWON4gq45nEqfA3f5T0B8RwqWg6q1g5DInmnWw2WuBCfBAu45gooS79mW96t0JYJ1w7S
 JO9EX2IHXHYGnh76ymPl44/TOi4ZmvD+WjXojl0+mQozACSwjmS+eqFEw15TZwMGFK+b
 mxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117226; x=1734722026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6I71WCIZYeQ5yV8uCldLsOTnUpTDKGYy0sk8GaKQTI8=;
 b=H7bm7jtoU48FqrZwCKw23bm87+RZEEBNC1HLxaEYpnU2gmjt8OWoXmlpMpmpxLH9Vm
 FunbFxK+y+1D7fl8Fia689YBihbuw2CXc5wN4LoX9LfdBe31Po50Fltw2IFVMbVkRaFW
 PKbdaAuz1efHIRaXzzh1+3l0q2nxB9Ea4UwGYYzkBfLdQ1hXcQ4CdafsmG7LJ4Snranr
 JlRyJg3byyhfgFJYe/3bLK6+k6lYpwJRScm/7O/fpC/U+UvumFRxv3a7k/ODG8SoXLye
 UIwHBJU+jKgTKeznJqSakkdCBU/2eZp21s+f2SP+yh0zFQxiebNbtstJnzy4Z+pXnOwA
 Sb2A==
X-Gm-Message-State: AOJu0YyiaiCnT6xnIDwtG4P2XAzMgWT2uHsmhcrrJfn+7g+LjzFWBkYg
 fUUEb+Agrc5SeChwnfD8XknCw3mD+xpXk0sjoJUxxP0CX3equ/RGwPRyhnwMUmGIO9WjXZdp3pn
 P4oRfK8yt
X-Gm-Gg: ASbGnctgPrXcBlHkQagXzzDqXzm+TJ2St2DKu6+dMm9u0xAXFaV8OLT+Z8SuZ0Wwl+Z
 62BPxHbRP3kKo92ClGVVjizZ5yAha9d2f9y7M5eEWXnSiv82O5xDiE8DlnSWBNf1qHMKFyBh1hl
 mhHZezGks7W7c931D5JXV6CYwCuQfW5By1/+9C9lyD/9eZg2Y/H7jgFzgcwNoZDbPq4T3sKv2uf
 sIvo/R2tw2+R71Qs5CDwlRO2Sj8vhHVZ4np1A5YbwOq6rEGYI/CifFpm+esT7XW
X-Google-Smtp-Source: AGHT+IG00GnozzUOWoDNKsIC8Bt4iAeF/clMgZ0ktCIKKzUbT5Lx2a2RqPw+0UW9rrSl7ySGbRisww==
X-Received: by 2002:a05:6808:2208:b0:3eb:4b4c:80d8 with SMTP id
 5614622812f47-3eba65ba0admr1866208b6e.0.1734117226116; 
 Fri, 13 Dec 2024 11:13:46 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PATCH 39/71] hw/misc/xlnx-versal-trng: Constify trng_props
Date: Fri, 13 Dec 2024 13:07:13 -0600
Message-ID: <20241213190750.2513964-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use DEFINE_PROP_UNSIGNED instead of DEFINE_PROP_UINT64
so that we can set the PropertyInfo during initialization,
instead of updating within trng_class_init.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/xlnx-versal-trng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 86905479b8..2f6af4f680 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -660,8 +660,9 @@ static const PropertyInfo trng_prop_fault_events = {
 
 static PropertyInfo trng_prop_uint64; /* to extend qdev_prop_uint64 */
 
-static Property trng_props[] = {
-    DEFINE_PROP_UINT64("forced-prng", XlnxVersalTRng, forced_prng_seed, 0),
+static const Property trng_props[] = {
+    DEFINE_PROP_UNSIGNED("forced-prng", XlnxVersalTRng, forced_prng_seed,
+                         0, trng_prop_uint64, uint64_t),
     DEFINE_PROP_UINT32("hw-version", XlnxVersalTRng, hw_version, 0x0200),
     DEFINE_PROP("fips-fault-events", XlnxVersalTRng, forced_faults,
                 trng_prop_fault_events, uint32_t),
@@ -694,7 +695,6 @@ static void trng_class_init(ObjectClass *klass, void *data)
     /* Clone uint64 property with set allowed after realized */
     trng_prop_uint64 = qdev_prop_uint64;
     trng_prop_uint64.realized_set_allowed = true;
-    trng_props[0].info = &trng_prop_uint64;
 
     device_class_set_props(dc, trng_props);
 }
-- 
2.43.0


