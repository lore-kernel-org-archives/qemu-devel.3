Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABB1C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9fg-0008BE-V5; Mon, 05 Feb 2024 19:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fe-0008Ai-Do
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:42 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fc-0000Ln-Qh
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:42 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-363c9e3f814so5175615ab.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 16:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707180639; x=1707785439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYLiDCFABC1lp2MV8V62ONedvtOy+ShpcqL/t5bf5Qc=;
 b=a07bHP7Ddj/m0u9KfoYAf1sNxwlBR3n9POJbHaNIT9qb6QJ/CTZksHwK98rt6v0ok6
 IwW8IMv5jfrjCMAU2J+s6Hzbce+0IxzxhNziMILyPIHdVryJyFWXDqiipGzLZm0hKnUH
 SQVmZ/IyAc0g0NAE3GSENyUrBlcf/9YWO3J2xRWYh/s8O7yl10hxqd6nU7DeHZiWZdGU
 WMO+tx962vcFZVno/LeJDuSJwOr7Smh0AtSaN5MOuBcQP/+D1dN4N0BR8mLn4H+DNHgj
 K65+qCmVl44ieDMxZosMKW5bZATWHzl8mxS9ZxrfDRhUYpgcmzrsfb7Jd8rY94yIkHVK
 sQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707180639; x=1707785439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYLiDCFABC1lp2MV8V62ONedvtOy+ShpcqL/t5bf5Qc=;
 b=pgPbl0MaXF2Hy8YHJ5Ii3nWlETLW1SaX7v9JrHaNnRl65gwBiPCXLeHBAcIx2gy8UR
 Gq8YaN59Awo4QH5rNxW2PDjOsi4T541LqJDt20cdXWp60jRAiVWwcVSv2CdxSdXxPEKi
 b+26xy1pQkW0TBLTP4ZjoHGZ/cNUbrpHsM8b9PK675aOpvJUNW1Z6zufJGKMCvxZJIE1
 XCIPI0EtqgemIDmBxdozAnzDPrY0PnYfXsz725Gr94ZnwlfKd937jHu/WMvKbybdtong
 /y6XxYPrqRexQH2RC1y1sRtAE86AcZMUNhLLiBubC5hyFXe5F281SqovvKy0WVH5qw1f
 a46w==
X-Gm-Message-State: AOJu0YyJR4yNyFuQDxTVb0sI5acsh1ysCERf1VXD555pG0mcssKjBm9C
 YhDSQnhoXczWx64ebQYPsSOXhFvnSttHy09G1/0fbHlQD2Im6rtT9wiACFH/88g=
X-Google-Smtp-Source: AGHT+IGO6ndZVr7SfiN7mLBTfBOkNW71ETvxgtxiIcIjtLmO+qV3vqWZzz3mTCUXymSEEMQ46UVl4A==
X-Received: by 2002:a92:4a0f:0:b0:363:c1f9:16f4 with SMTP id
 m15-20020a924a0f000000b00363c1f916f4mr1606149ilf.28.1707180638873; 
 Mon, 05 Feb 2024 16:50:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXvrgA/Rt2c69jve9mgs4WVyRjvjV9QsWKSkoc1gjJRDSQWD2kOMIIMHbLD03dcrYv4Ih5X+p25AHErRlMVogVC6/SnDhndq+qTErat6dwpXLs2Qu9/I4P7Rucs9FHWvxhURFJZ7lHc+yFU6ZMAR71QCD2CrCyaSy9YO9cHednG1u+Dm7eXzLdLdnUWGuahmk8DTI0tbC/6rIGmbPp6szOYml0B4AmOSfLb0Jqa2Sx/LJL0sXZEkD8u2sUVn4C6vQ2jAJMSI+RMh4DRpU4Dhowatvi2RxSz8G+8uc0F
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a02a408000000b0046e2ce45dafsm245840jal.165.2024.02.05.16.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 16:50:38 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 2/3] Hexagon (target/hexagon) Pass SP explicitly to helpers
 that need it
Date: Mon,  5 Feb 2024 17:50:33 -0700
Message-Id: <20240206005034.267283-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
References: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rather than reading SP from the env, pass it explicitly

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/macros.h          |  2 +-
 target/hexagon/attribs_def.h.inc |  1 +
 target/hexagon/hex_common.py     | 11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 9c700ce8ef..4b8665a9da 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -343,7 +343,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 
 #define fREAD_LR() (env->gpr[HEX_REG_LR])
 
-#define fREAD_SP() (env->gpr[HEX_REG_SP])
+#define fREAD_SP() (SP)
 #define fREAD_LC0 (env->gpr[HEX_REG_LC0])
 #define fREAD_LC1 (env->gpr[HEX_REG_LC1])
 #define fREAD_SA0 (env->gpr[HEX_REG_SA0])
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 87942d46f4..8949ee09cf 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -117,6 +117,7 @@ DEF_ATTRIB(IMPLICIT_READS_P1, "Reads the P1 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P2, "Reads the P2 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P3, "Reads the P3 register", "", "")
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
+DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the SP register", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 2dbd0ea737..eb28aa98fe 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -101,6 +101,7 @@ def calculate_attribs():
     add_qemu_macro_attrib('fLSBNEW1', 'A_IMPLICIT_READS_P1')
     add_qemu_macro_attrib('fLSBNEW1NOT', 'A_IMPLICIT_READS_P1')
     add_qemu_macro_attrib('fREAD_P3', 'A_IMPLICIT_READS_P3')
+    add_qemu_macro_attrib('fREAD_SP', 'A_IMPLICIT_READS_SP')
 
     # Recurse down macros, find attributes from sub-macros
     macroValues = list(macros.values())
@@ -201,6 +202,10 @@ def need_p0(tag):
     return "A_IMPLICIT_READS_P0" in attribdict[tag]
 
 
+def need_sp(tag):
+    return "A_IMPLICIT_READS_SP" in attribdict[tag]
+
+
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -1128,6 +1133,12 @@ def helper_args(tag, regs, imms):
             "hex_pred[0]",
             "uint32_t P0"
         ))
+    if need_sp(tag):
+        args.append(HelperArg(
+            "i32",
+            "hex_gpr[HEX_REG_SP]",
+            "uint32_t SP"
+        ))
     if need_slot(tag):
         args.append(HelperArg(
             "i32",
-- 
2.34.1


