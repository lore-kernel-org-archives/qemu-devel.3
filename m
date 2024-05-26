Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8844C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfu-000822-KQ; Sun, 26 May 2024 15:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfr-00080G-Tf
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006VD-V9
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2be00b445c2so2095070a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752209; x=1717357009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Xai2dJ7NIiywU5ZF+ip85hjqEz8wylB31BnzX8bi+0=;
 b=nWRHgUnbFjzbI9OLKDjCcR5YedLUtjE8MKMWQWM5C0VVgSIKFs8rDMvj0orMhpewKL
 hQOyaHtwJEXI4Vo1oeaf7kbulxkjH4vem6VOGnfEoQ4ekKmHaOt+UoDyVM0PEZlRNpQl
 qd9L2j3KqJzyji9VZZqhSoKwMvVAJG0JqkXSi8pjvvFUkLanqM7cGXewuODZf2PvQT7M
 mLjN8/RD8l54hgNzidKO8mgUD7DMF5RpXTNOxQESk1lrTV0ntU3oYsApfHP0PrsGrjeZ
 NbRoF5j+K0m0O/mYe/48X7tnA2JqAKjs5EiqBc9QiT+EjhryvQ+E17buLFO3YsxMvvFR
 PFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752209; x=1717357009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Xai2dJ7NIiywU5ZF+ip85hjqEz8wylB31BnzX8bi+0=;
 b=SkDGN4QgNUS5Il71ldA0Sg66roaNHsCuvLNO+AVWHcK0dDekqnoT2NoemOt/+mZpmu
 niwP8jX+goNe7NxKgkEIGp3wzibpS92Tn4wK6g3mNtFoiYL55RbzM3GoAPSrdde+Z1dm
 pR2zomguYruXNI/4QoThEiw/r8rjqvMUbM9Sj/L6xup3lXZ8JRq769hUZwNCk8kHRMkJ
 4C6oGWvlONmK2mXdIVD95Bz0FKreWNFgyj6lflPD5jnruO5EdLuWSJir/DN5Hq+p3UI6
 KIhsCpujOWJ6N0TbyzqicQgsEMi3g2FsqJjaR8FzgOCE2wb5cpEa7XnaRK4ogZ53wqrF
 PD8Q==
X-Gm-Message-State: AOJu0YyopNb4y3Ueq9NgGErCcAHHEvREn8H1VyptGFigv4URezmIHegs
 tgUdJz+3SQY2k1TwouV1A8mQjXgylcJp+GHuXlRFfC9VccgbLyN5U1d1HBpnKvIRdviOXwcsqAs
 n
X-Google-Smtp-Source: AGHT+IGym4tVqERWgdedJ9r4/oCMaT3YE3gouQ+JQmjhxRGN5vieiuArEvaHcusynjjibduyRLblVQ==
X-Received: by 2002:a17:90a:cb0e:b0:2a7:455d:82db with SMTP id
 98e67ed59e1d1-2bf5f74e103mr6874718a91.36.1716752209338; 
 Sun, 26 May 2024 12:36:49 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 13/13] sparc64: Add VIS4 instructions
Date: Sun, 26 May 2024 12:36:37 -0700
Message-Id: <20240526193637.459064-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 sparc64.risu | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sparc64.risu b/sparc64.risu
index 271fee0..1022a62 100644
--- a/sparc64.risu
+++ b/sparc64.risu
@@ -250,3 +250,49 @@ MOVxTOd         VIS3 10 rd:5 110110 00000 1 0001 1000 rs2:5 \
 
 FPMADDX         IMA 10 rd:5 110111 rs1:5 rs3:5 0000 rs2:5
 FPMADDXHI       IMA 10 rd:5 110111 rs1:5 rs3:5 0100 rs2:5
+
+#
+# VIS4
+#
+
+SUBXC           VIS4 10 rd:5 110110 rs1:5 0 0100 00 cc 1 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+FPADD8          VIS4 10 rd:5 110110 rs1:5 1 0010 0100 rs2:5
+FPADDS8         VIS4 10 rd:5 110110 rs1:5 1 0010 0110 rs2:5
+FPADDUS8        VIS4 10 rd:5 110110 rs1:5 1 0010 0111 rs2:5
+FPADDUS16       VIS4 10 rd:5 110110 rs1:5 1 0010 0011 rs2:5
+FPSUB8          VIS4 10 rd:5 110110 rs1:5 1 0101 0100 rs2:5
+FPSUBS8         VIS4 10 rd:5 110110 rs1:5 1 0101 0110 rs2:5
+FPSUBUS8        VIS4 10 rd:5 110110 rs1:5 1 0101 0111 rs2:5
+FPSUBUS16       VIS4 10 rd:5 110110 rs1:5 1 0101 0011 rs2:5
+
+FPMIN8          VIS4 10 rd:5 110110 rs1:5 1 0001 1010 rs2:5
+FPMIN16         VIS4 10 rd:5 110110 rs1:5 1 0001 1011 rs2:5
+FPMIN32         VIS4 10 rd:5 110110 rs1:5 1 0001 1100 rs2:5
+FPMINU8         VIS4 10 rd:5 110110 rs1:5 1 0101 1010 rs2:5
+FPMINU16        VIS4 10 rd:5 110110 rs1:5 1 0101 1011 rs2:5
+FPMINU32        VIS4 10 rd:5 110110 rs1:5 1 0101 1100 rs2:5
+
+FPMAX8          VIS4 10 rd:5 110110 rs1:5 1 0001 1101 rs2:5
+FPMAX16         VIS4 10 rd:5 110110 rs1:5 1 0001 1110 rs2:5
+FPMAX32         VIS4 10 rd:5 110110 rs1:5 1 0001 1111 rs2:5
+FPMAXU8         VIS4 10 rd:5 110110 rs1:5 1 0101 1101 rs2:5
+FPMAXU16        VIS4 10 rd:5 110110 rs1:5 1 0101 1110 rs2:5
+FPMAXU32        VIS4 10 rd:5 110110 rs1:5 1 0101 1111 rs2:5
+
+FPCMPLE8        VIS4 10 rd:5 110110 rs1:5 0 0011 0100 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPGT8        VIS4 10 rd:5 110110 rs1:5 0 0011 1100 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPULE16      VIS4 10 rd:5 110110 rs1:5 1 0010 1110 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPUGT16      VIS4 10 rd:5 110110 rs1:5 1 0010 1011 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPULE32      VIS4 10 rd:5 110110 rs1:5 1 0010 1111 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPUGT32      VIS4 10 rd:5 110110 rs1:5 1 0010 1100 rs2:5 \
+    !constraints { reg_ok($rd) }
+
+FALIGNDATAi     VIS4 10 rd:5 110110 rs1:5 0 0100 1001 rs2:5 \
+    !constraints { reg_ok($rs1); }
-- 
2.34.1


