Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C60C47BE1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGsU-0003Sx-DY; Tue, 06 Jan 2026 18:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsS-0003Sf-FK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGsR-00044U-1l
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:54:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso10730215e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767743653; x=1768348453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gC8s3v5Yfls5rstnKT7boH33TFwx903/gwURhAnqZDY=;
 b=xJLTHhbNZ+Oyec7Au5Op/SZJc7q6Pv/Ncp4zMpXuwXvgKwm3ZGfH4vq7uTDKmjI6Zv
 weV3fYES7lBvBn5JZFOnL9gyFt+khXo/HuTTd+I88BS/GWN95xPwtaIY7sHLlQd8xXcO
 B/yEBAXhazbSql8W0OdrHoZ9rtSNC2xKFDv0jt7v+bSTyMOhlguqWFaW8XSOOjjiC6Rs
 ziQQ+awEFSe0tewlX3syPwO7285k0REVeq/uGEO9/MdFR/+lGERR+9hCfUGPZ8FxU4h3
 DOu4SK6FMoNOkNej1fCeZPvryAXWPD2TdU2hwtUIzAQfpi/72VAxpCTg+emb9hh6L1gG
 D01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767743653; x=1768348453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gC8s3v5Yfls5rstnKT7boH33TFwx903/gwURhAnqZDY=;
 b=vCr4nbFMgwB4FbzyoQYcgWip0YzSQtM5rEY+QH295BX2rOUvMfqaZG/5DywK/JXgGW
 qzRhYVxcEPR1b9aY6Xf0ZEnw7m7W9YahjtYmZr/AB1n725oYEk86IPyTK+0VEMXzZm5y
 OOS8dw//TNwh2hQPhI4FPP5j/1uar0qnjMsnC3eTdZAG6/NsELPJmW2nJ8X3O5gA2OOn
 6HNT2XJffjmPKzkJAGNK9ZLiHn4mJ/bZR89gC8lwiCLcCPVeH6v7AD6Om8KhigU7nCqH
 JweV4rk3zBVoBpzB+xoHBNkaFBY7XVGsByjNWCSSXshB0G1xlkjhuKFG4ph1G93eKNcA
 2z/w==
X-Gm-Message-State: AOJu0YwXvcgiB+EGxD3vO+4uTH6WkwDxeqeXKJ8Ez/V8/FrupUNE8a/P
 +oX0nXxVfXhRQ3u2xqeG01ABZyvkGFSknTlGA6XKIr1vdvoFGyeGK/N0S/Z/PcPwRHhFVEJfOGh
 QvA61dEg=
X-Gm-Gg: AY/fxX7DfXuiFCT0daMuhpPHuFdxHyCwM6UcqDuJ6GRm390FzKgCyI9mmM9bqBe3dAV
 7FfGTUHZ7YGB2iqLulF+skns8OooHL7Vlv9FU1dL6tfQjmIkilRuH2ocvWQRWOkdrMRwpk+CHGT
 F61Q3urquvRKLLaWJdVHrfjVJxdCbi+tdYIJXU2qoObgfXQ5BtVLerZsIhWY9ojNh4u9gLmiL48
 +fzPbcDbLSVeBC1j1/Rc0NUG09ofTs9FN0cEDpp4r2P/5aPxRB34KhOWKE/UII9RHQSonK/62oK
 R53a2MOgkDipsWzec/HCY4EqBAmpbnetbyPNZUlgodwsVzzg9Yo2dV7JhGU2aYOrX1KX9vJW4aX
 HJyUODLAWHIKoIqM9dSVxmdr181JuAP1A6A758Cnaj9oP+4g7iaddiTDKBaayd23nJQNhDfaJ0d
 /E7IJBOUDkStjDhgDvPVj5z4jN0wtM4nBxtYoQ1RdsaL+EW776kHsL0tn7OFLe
X-Google-Smtp-Source: AGHT+IFNWZm7OMwcLboSTg5veB9jYS39hr8hs64muzUCxaxmsTZdJsg2HRzQ4uJo1JA0eHJKcgjY2Q==
X-Received: by 2002:a05:600c:3556:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47d84b3b3d7mr5538035e9.25.1767743653239; 
 Tue, 06 Jan 2026 15:54:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm7475974f8f.41.2026.01.06.15.54.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:54:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/microblaze: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Date: Wed,  7 Jan 2026 00:53:31 +0100
Message-ID: <20260106235333.22752-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106235333.22752-1-philmd@linaro.org>
References: <20260106235333.22752-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Check endianness at runtime to remove the target-specific
TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2a853a7fa5f..0c9a6bf2529 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -177,7 +178,8 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_lookup,
                                           machine_get_endianness,
                                           machine_set_endianness);
-    object_property_set_default_str(prop, TARGET_BIG_ENDIAN ? "big" : "little");
+    object_property_set_default_str(prop, target_big_endian() ? "big"
+                                                              : "little");
     object_class_property_set_description(oc, "endianness",
             "Defines whether the machine runs in big or little endian mode");
 }
-- 
2.52.0


