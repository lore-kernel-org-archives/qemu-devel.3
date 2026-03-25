Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F146C106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VcZ-0001PC-Cx; Wed, 25 Mar 2026 17:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcN-0001JZ-PJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VcF-0001Zy-J2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so2787425e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473494; x=1775078294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAfGwk5iQFxUtFp9tEuDqdstwJOUxCbrpEqefh8vUSI=;
 b=gpn/yO3x0nuCMVjW/94IJ/ZafvhAOpPV19SRnZd11NUzAsaTd0exC8SoGhbdCzyGM/
 IFG+iPWQLAYZvnm1ZOeLQRggalrdUUAtsOJVA7xWuhHVUP6uX8/niBQzhF4Bn779cRAr
 5ETrs1aFQCsIREDqy2OVRfwTVidVn7dthXTkMqlKCES/Zw9I7pvRg2Oq5DDwfRJy0TI+
 pdELB5AFfS5Tp/72BYkQPVrESKKzQyw/inRCZ5K8mTczO8DrlHsArNMb3pAyjCOIKb8U
 2tp9nvX511eZxFy0jLnY9oTvX3zvcx9xL3BOsDLTVpq9fqvnkwCV2kBo10NkEl1TwC/k
 jfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473494; x=1775078294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fAfGwk5iQFxUtFp9tEuDqdstwJOUxCbrpEqefh8vUSI=;
 b=E+VDJ7SE1BNGj9GYUnizbAUO8wcWtQnkAVVXS5ZMMta7IKw6JRXyw+zlsZFJEIh6i3
 dCLWR2fet+T7gAUtbDqg3F7qYaKu9sCTYZZjBcm7szEaYz4ZRKtYmy7IAj3Lgi4ka+IY
 688uXUYs32OUL88tMC0/VEgjs+SVXwD4RpYseQ5S2Ot+4WkDF/l9M07hvOUu0HJxr9yq
 iwVBr+zXP9ST4pNJ4BInUNn5hgT5UgPcRbmhy2/t7x6sU5+RyRSIs/72PLpOdoRvHuKK
 OEDieXlOIHl17VDd9tgxp+emY86JPI3/2yFVF7KxzBeMQihoT4evn2eFUAkjOV0FO9aq
 qrHA==
X-Gm-Message-State: AOJu0Yw0Ttxkb23gnsokGTZUOHxw5UmCThErEkga4K4XVpSoZ8/pBmc3
 UJOXwqegJfS6Nl6oj7/WTED+eM0J9Mkb4HoA4yWWR+91eBzaFt6Y1dratMqD0Pep7UiUEUDDS9d
 ItdaCI7M=
X-Gm-Gg: ATEYQzw47AssiX67LCb+FhEDXGW9b/aRZrJ3/fpw66F2IicaPg2E7fKr/dlAV/rZ+SY
 j23MoArM20r4RfltwftkZOhRFA26axNWYa3yQxOO4Cj8eRUR8Vm3OuN8Wxs5CEdIJyZGR7x0KCN
 z5l9rx7WgaYPk/Eh8zPqqlMtN3jW+kyfsazS76W0Ypn7Wx94Vg/EKRTaN2HwjaVanqI48K9RC5+
 LBvgGOgj5r2QKCyG2m4NuxnfGCls0/weJH+ckRdjRQCItz2CsD3QumVIKZAsb2b8EDxwUa9nAYu
 E21TE0qOzK4xZk9BHEeXf0gku7Z7H5hsk5YhZxZ/h8ZWJTMAKW3moc7KVjndFbcjw9ZKX5VfBZg
 5kM5n6j1qkmxDjWkjscjEuW81YIJFvnWx8VkgdhJFlI9LY6IxR1qsYuttxbrf1KJ6MJ1tD1MkVn
 kxZsCU+Nq2/GWoLr12xMfF6rOxRhUwQ9/2pEa/LzwrtSb6KMwEiu0/0RUMYcczuh6LCxVwW2sm
X-Received: by 2002:a05:600c:c086:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-48716056385mr53086605e9.26.1774473493770; 
 Wed, 25 Mar 2026 14:18:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711709b48sm150514935e9.7.2026.03.25.14.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:18:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.1 06/10] target/mips: Inline qemu_get/put_betls()
Date: Wed, 25 Mar 2026 22:17:24 +0100
Message-ID: <20260325211728.89204-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Use TargetInfo target_long_bits() helper at runtime to migrate
the VPN register as 32 or 64-bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h      |  6 ------
 target/mips/system/machine.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 87ca977a3fd..82a81b5d895 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -8,9 +8,6 @@
 #include "migration/vmstate.h"
 
 #if TARGET_LONG_BITS == 64
-#define qemu_put_betls qemu_put_be64s
-#define qemu_get_betls qemu_get_be64s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
@@ -19,9 +16,6 @@
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
-#define qemu_put_betls qemu_put_be32s
-#define qemu_get_betls qemu_get_be32s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 8af11fd896b..20de322385b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -1,7 +1,9 @@
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "cpu.h"
 #include "internal.h"
 #include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 #include "fpu_helper.h"
 
 static int cpu_post_load(void *opaque, int version_id)
@@ -139,7 +141,11 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     r4k_tlb_t *v = pv;
     uint16_t flags;
 
-    qemu_get_betls(f, &v->VPN);
+    if (target_long_bits() == 64) {
+        v->VPN = qemu_get_be64(f);
+    } else {
+        v->VPN = qemu_get_be32(f);
+    }
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
     qemu_get_be32s(f, &v->MMID);
@@ -182,7 +188,11 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
                       (v->D0 << 1) |
                       (v->D1 << 0));
 
-    qemu_put_betls(f, &v->VPN);
+    if (target_long_bits() == 64) {
+        qemu_put_be64(f, v->VPN);
+    } else {
+        qemu_put_be32(f, v->VPN);
+    }
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
     qemu_put_be32s(f, &mmid);
-- 
2.53.0


