Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B04BE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSJA-00009i-MC; Tue, 17 Feb 2026 16:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vsSJ5-00008H-Kc
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:08:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vsSJ4-00041n-4v
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:08:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso37616235e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771362508; x=1771967308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYhMRYHEkus5Vnp4myfoo273KT7fzWxarZWFB8zJFeQ=;
 b=aB+YmapVIh5AsBdmLbEZrx5+0osR4T5QQzhhW1GP4g1CRKgCY+EVWXgQeVLijzAD20
 cCqlF8yj7pnbkNMElvUP6D5oGwEqDnKBdiiT+K2oAcBTCV3dJcrxezBD0CNBhPF3gLG+
 QCZGaMv55escGxz0GIdFEKZ4aI+uMNruiWR8+8LMclmtRHQu7x256NAB2rgfI0gGpOio
 t9RqPSNq25e948EspszrtH8Q0lMWNVoh9MiopFkFDE1wqCa4vXTGq1saVltfu5OT5dOF
 8Oz2noWgVauasc7223hh81b22S4bTR5Z4LWYLUHmIDOeoXttssL5SJMx5nMzhwdG3anT
 aWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771362508; x=1771967308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYhMRYHEkus5Vnp4myfoo273KT7fzWxarZWFB8zJFeQ=;
 b=dfMxMA0Fu9v0mn01ypkhMSAPAyKh0Win+3lZj2kfOW/uPO2vxSBBEhsWBkAVG0SXRQ
 82TxFINf3GU3qi2c9t756n47uIlFRqwwJwAXdf773bLN9bBcoYeshXN86ljt75W+ZgPK
 iThaX4RU3m1glupeBddyL+ssJs5WVsfB9g23BwYIaFG1Wd/zKXw/mlJkNo+cC4p9npm7
 QaQWDnVlZCIuAVA93ygrLQj0EYK2wYAfwJTq+GoHVPXF7+sp9FT1wkYV0DYZiT87/pnk
 Y6ma/typEtndg2ZEvQdsYL94YfoV3jYC2+qu8rQGQDqIJtI+3gw8g1cXXiyIlTXvElAz
 imVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+bWS9A8k1DqAAkCxMGzFXbpGQrz9UsDhTk1kOR1kxWmFwPHXDKgbktKw09hg3aDKIhi1xDULNu5ZI@nongnu.org
X-Gm-Message-State: AOJu0YwzX8fhPOhqNQPVd0gGHLmrKto2HakEEgtNfj6rsLe4Iu1W/GgV
 keOs9xnr12t/FOMfoFtCn4wQech6x4l0kWH9uyYyC4S0/DHpiytd+bJH
X-Gm-Gg: AZuq6aI0qXcV1Q6hO4fXlKrutlDmPTCXwgxZMTKjYM7vz/MEhcArp2WrepGmXF8uHaQ
 gZt4W+g+8h0KEIKpRDqnn4DGBBgaUKh0iG6WTRwlMmesgVK0SxNC5ay+7RcnxdkS7mDeUnu4MRb
 Jlq3Xc/WpJEeJgrbMurADhjANKvPFK4RTxBUwZ9xHFFjsjRllKRdSzCg/BTgj6X46Y2wtSShYxZ
 5/asjpMSAL994wC5Sgj8bRvfhpqQXlhbbUfQyz2TH9BqFoRZPccinUFFAcZFTYVzHwhAM/v2VnP
 k++vxu8qxpIzVBRfxJ9S8i1CopvXudoz6kc5tvb5Pf2Ikal0ylSBSYag2XHsQN2MK+DsBRuvjDp
 OyMD2yhptZDKMqjtbcVFtm1vx3OwK78gw6jjRzwXJN8Sp13z1iulzMUNjPEeyXo1VtxpVtFwvsE
 oHnOfZOZX0OcwnlornKYyhVge6BTm69oWih7mMnKwOiB8b2815drfDxLg=
X-Received: by 2002:a05:600c:a10d:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483778355e0mr194749525e9.27.1771362508215; 
 Tue, 17 Feb 2026 13:08:28 -0800 (PST)
Received: from osama.. ([41.46.249.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfafcdsm828454955e9.9.2026.02.17.13.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:08:27 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] whpx: fix FP register loop
Date: Tue, 17 Feb 2026 22:08:04 +0100
Message-ID: <20260217210805.104427-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In whpx_get_registers and whpx_set_registers the loops over FP registers
were using whpx_reg_match[i].reg instead of whpx_fpreg_match[i].reg

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 target/arm/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index b0602266af..40ada2d5b6 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -554,7 +554,7 @@ void whpx_get_registers(CPUState *cpu)
     }
 
     for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
-        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
+        whpx_get_reg(cpu, whpx_fpreg_match[i].reg, &val);
         memcpy((char *)env + whpx_fpreg_match[i].offset, &val, sizeof(val.Reg128));
     }
 
@@ -605,7 +605,7 @@ void whpx_set_registers(CPUState *cpu, int level)
 
     for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
         memcpy(&val.Reg128, (char *)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));
-        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
+        whpx_set_reg(cpu, whpx_fpreg_match[i].reg, val);
     }
 
     clean_whv_register_value(&val);
-- 
2.43.0


