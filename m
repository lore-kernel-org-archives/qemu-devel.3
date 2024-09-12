Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F06EE6454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodoo-0001h4-VC; Thu, 12 Sep 2024 03:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sodon-0001dS-Ui
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:00:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sodom-0004LH-AQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:00:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so545199b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726124438; x=1726729238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkmTzubpfXWhOndmnlWoFaXYzXRHYYUSg1UDMNDwHU0=;
 b=nt7tWcBwTylEo6reXiyf32iBvDd9+JLhXG7ndTxfYGr6cPc7q3Ybfhaeld/FUuHZ3j
 OVZbJxZPTZ4lJWbvHMpB8Xi/U2uhsVCHpSi0Ni9PlNIhJiWgagUSNegvIHk4XAmpRiE9
 5CINU7QYQdCT7H7jBDbOh7oFwbCbrh56XzH5MWbfwHlDUyKmWhA4x5AjGdfNxdH0Vah9
 0RP4PtSorkDE4K5dJwa1f5FMbxGpJJa6uKxTPQF4IEvO0QTT3FpZgKrgCShmvm9rDxex
 348nZxJ+pSBlHhKoZ+gh9a0nRkvWTTFlOKsW39c1sVK7TKOigAfdmX87yZhk4d1JL/Qs
 gGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124438; x=1726729238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkmTzubpfXWhOndmnlWoFaXYzXRHYYUSg1UDMNDwHU0=;
 b=PCjLmwqbx5fe/SoPLJdFiYwR8q+Uj2luIbX3nh0YgaLmAIp3lXXZ5nuC+A/4tfc7Cv
 yWQyKx8IHsUjDs2seGi+eTAqOKQz087le5jlhhukvVwvbC55vPvPvg6wyLciZF2og6by
 ofdGpsK9a5G2EhKewbn85b+sLbhezYolWKIl4e/DB37NwaKPIRc2Ff6+SjNLD+oMsdMC
 mOykWE991sCnHXZVrzUF8Lxo5xXR62rE4kvVeMyr0PRZ9GkJjMRmT54TutyuhqVORMFg
 Hhjt+nXCQPwJrC93DyPi//4HkUK0ztVfm0BBrjZlWe6PLN3r+pJQc14VRWAysm5BgPDb
 Ledg==
X-Gm-Message-State: AOJu0Yxcc7s+FFaOcgtaQmzzfhaZjhF4ZfrW/zR9PDXcAPobH/7yyoE0
 4JIgp5S8PILIWITRnxy4bsdcICJPoGHfgr1J8NO7p8DKI8yqwXkmWps9DoB1yW9rD6cdhpaV6Tx
 BzmvOn3LIb23eqOVfJFFei0JDLaR0ZhjtPXRiKuTGYcKhp7MegmDRdz72O0m64VFVwOu/aQIj8L
 Rw+cM7Dcf9Ww0sHibRhwHM3D0xcwz79KIsniA=
X-Google-Smtp-Source: AGHT+IE7YwfdSbwkgECmNrglp+39irURHKgvc0yTYl89/G5bju5A8IfA7CFEkuvDDpndZQZ4caOL9w==
X-Received: by 2002:a05:6a00:1790:b0:706:a931:20da with SMTP id
 d2e1a72fcca58-719260654f6mr3520676b3a.3.1726124438332; 
 Thu, 12 Sep 2024 00:00:38 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe5309sm4001479b3a.84.2024.09.12.00.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:00:37 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH 1/1] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
Date: Thu, 12 Sep 2024 15:04:04 +0800
Message-Id: <20240912070404.2993976-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912070404.2993976-1-fea.wang@sifive.com>
References: <20240912070404.2993976-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The follow-up transactions may use the data in the attribution, so keep
the value of attribution from the function parameter just as
flatview_translate() above.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index d71a2b1bbd..dc1db3a384 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3274,7 +3274,7 @@ void *address_space_map(AddressSpace *as,
         bounce->len = l;
 
         if (!is_write) {
-            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
+            flatview_read(fv, addr, attrs,
                           bounce->buffer, l);
         }
 
-- 
2.34.1


