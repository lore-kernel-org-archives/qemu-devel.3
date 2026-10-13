Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EFFCC6B13
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3a-0007S7-8b; Tue, 13 Oct 2026 04:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3I-0006yF-Qx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY36-0007bd-On
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so18410715e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880791; x=1792485591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hqqeZR9hh82Ok/85fIviXaUdYKynKCQ8FaCgEa2tPAY=;
 b=hfEgI4i84v2Q8MTSOgTZOxJ1qYYyZyulrQ0fL/fdQFbo0U8aPMsvT4QE8mzZeHju48
 sOJCKoQBqTWBKzX5JqTDzY4lfNIynUKcabN7NL0MoqCCWv4AWANdsfmSshQnzvpy+MiW
 r7lJE/L/XoabVobDI780VDsIdvWRNAfahfcA45wFJHz3lsIZPwaf7+LPFf2L+XCqefZE
 5OyaLXDpa3IzWhU4/2DlEk04tSXrCvKNQ32CuBAQBEMxNDd5fEfBTkQo2akvYpdiNODo
 syBSTkSBTGaLMuqt35Xxd2gtrPiJvAQr4kyf3NIEI1fcSbaeEwtsjc+NMQ/9QXLYS/pk
 2GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880791; x=1792485591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hqqeZR9hh82Ok/85fIviXaUdYKynKCQ8FaCgEa2tPAY=;
 b=1NbPZuUylkKlwXn3xlEUX3F+jkEFa7OAw5QaHL3XK0y3F8+X215Cp4gZgW+TKpoZm8
 IDKGmc+JcioKFb+OZsmaASucbbw3kSxnYh4Qa7PNcW3N36cTwuDXNMz7bXCyA1LKEvsf
 0In43KycIyCu+U5/ILP83U0uhRx/m/1kRrL8a/ZOue6sGkITuevQnXNp+0EgRe+MDnMt
 iG101AIUtNqx82EAdB8IbTODY60dX0+kK6+sNGuRKBh6BqMgbX6AzrqCjv2rXImRiPSV
 +0nHY5LP0gZ/9RchbwAdd9CFLwIlN18Xf7ksrStTT1z0UhXj+79cXJzhX3rqDzR+lpYS
 2MHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWuXljO+uPDHE/TN4uT+n+YJ5sEzX6u35Lo6suwBk9U6S/37cjCf/1aZolCb2hA45Fm70vZd54cFIC@nongnu.org
X-Gm-Message-State: AFq9FYJB30dGMtLdh8vuEkaycQ+8IsoMZb4rFQqfINkjqCUqcO0Ml3nf
 x7Q6O2Fjfkqa9SZnf1CznlxNoXjKnh6kxe3nMU6nc7a4qWK6DyslSvPBYAgI7Uo+abE=
X-Gm-Gg: AYBFou0anDV6hnjrDmPMATvqwQ47/S64dBZgmAY5zxvnxVYQmo4akg5r5V1tcT5ZTYX
 uLVnuKaRXz8h2ubk+vs9OdmsmABPAUzDmalI3cdF6JGdPn17l2ZjEdNjd/uhw8sVg6antLZz6Ld
 8zB8UVZH3Ag295KqqqVHJKXDV7JILa8yZvnLefzy34b/JcbOzEHiwkvoGb4eYIk3paXt3zH+Fbx
 M4iiRn5ddZVNI/7iOSbm8Lsh+hbDeW3qkSUsnDhBP3odB3wc8fsfzZ8coPlmqhhU4bv4nAyqPqu
 CZXfKdZtRNolJXkBAW61BcVSP5ugZDk9KMSzigJgmVYeVGPoRv+TBcakrWSjwnea3614ZkCp6cK
 jA3PTfxyKxO6Bdo8HFfhbR3ek9Gx0vh7sdzct/lY93Gf8sZctzEPaMiYhxGL7uEXE6kpapVkSBa
 5RnV3Gl/NBVBpXFlY42xUd934r4S/axp1xnuotMM/GxHItPfl7xzWS2cb91IhytoXLMjPihrdXi
 k+aaauZe6QQ/wC12p7xw1LE/vAb6x2aDq8rFXwlc5RTpzVI+cTPpRQtTEWAN9sKUxpbGIFXEoKh
 sjXT
X-Received: by 2002:a05:600c:6388:b0:4a1:ac66:5ffe with SMTP id
 5b1f17b1804b1-4a1ac666396mr23882515e9.15.1791880791184; 
 Tue, 13 Oct 2026 01:39:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/86] hw/intc/arm_gicv5: Use correct type for value in
 lpi_cache_get_hppi()
Date: Tue, 13 Oct 2026 09:38:18 +0100
Message-ID: <20261013083933.1024405-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
to iterate over the LPI cache hashtable.  This hash table has keys
which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
value, allocated as "hashvalue = g_new(uint32_t, 1)".

The function is passed the key and value as type 'gpointer' and has
to cast them to the real types itself, but it incorrectly casts the
value pointer to a uint64_t*.  This works on little-endian hosts
(since we only read specific fields of the L2 ISTE using bitmasking),
but won't work on big-endian, and trips the clang sanitizer.

Fix the pointer type.

Cc: qemu-stable@nongnu.org
Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index fd6456cd8aa..a362349e5ed 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
 static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
 {
     uint64_t id = GPOINTER_TO_INT(key);
-    uint64_t l2_iste = *(uint64_t *)value;
+    uint64_t l2_iste = *(uint32_t *)value;
     uint32_t prio, iaffid;
     GetHPPIUserData *ud = user_data;
 
-- 
2.43.0


