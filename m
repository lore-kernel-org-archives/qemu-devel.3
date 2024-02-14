Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E78AC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6rw-0007nT-Mx; Tue, 13 Feb 2024 23:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6ru-0007mj-Pn
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:34 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rt-0004PZ-AL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:34 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7bb5fda069bso244916839f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707884851; x=1708489651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPvX2LKtyesviXI/k03yDzEPeDwJWxB5cSBazGc5msw=;
 b=fAPVNepZWbyeJOkQzqWXNCVTHAvrTUelk7tnq7xGqtte9TDZwLou+koawj5GHFV0k4
 kSxT3+Jc9W4RMEWJ/dH4a5UZHx1+7x0OlHUsFGa68CaHBOOWM/9zMlASqeGx6+3FSQBv
 2YsQCrtmNJmdeWPbAywrcllkBL8c9EvqVgHzberD/cxFxcOeLdG3cDNPZNGzS9Xap9Lb
 D+aKlhKmWT+MMX3Sjid7txepb6wxbV/bO9DLS1YAy7g5v6WgYirY+PV/4qPa90QaKvX1
 e0pWYiheptbz0bSCbbNHrYFh5KCkKvWVShpxlbL9UCaPxK4fpXQKluWJ6aW40m5pXKIo
 AwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707884851; x=1708489651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPvX2LKtyesviXI/k03yDzEPeDwJWxB5cSBazGc5msw=;
 b=ObipmmCZXM8pmkJX5haFmGDtCG2A8JmuR7LmLvhmldo5SMMvcLE0DejesFOmC8JzLC
 5AbLU+gqruU1PgXxWkfXYifAnLZkOyPCOHgbBpDuxc9RD5GqyV9bY5jxOWh3+A2nmePi
 hf1hbQNmq32R6N6xUotYNo52cDFdOHrZ1FIZ4TFVJpnWLHkRZvPA8I05JS9Dz9Jlvphu
 Bm8yH7wcitpdrq0WLPRcSPYtkDWUzUeDbeQVNTcMF6j0VhF1mK+GN4PN2EgNsW/B2Pjl
 hsMr/2xrJFDiv1Ev2xbnhf2OTeCSIRqRrjVWp889xrbUCVXH7Kxm8RneKO7AN5IYVG2W
 P/jg==
X-Gm-Message-State: AOJu0YxUalEUF4+Cjc63P+qT+qwOavZfsR5FkzZpYfBIUMjqzXqGypFT
 blmYsT0XRyBq2n6RLdci/UQhUDi97ZS9X+u765TC9nLeIB8r1XtN6SbYu34NYZ8=
X-Google-Smtp-Source: AGHT+IEMOpqHoa1lQzsx1/PXzjjQzEhsMsO2AtwcbcsF7dQcP+dey90atb+OyWoM6D0cgvDpZrOD1A==
X-Received: by 2002:a6b:db06:0:b0:7c4:602a:10a0 with SMTP id
 t6-20020a6bdb06000000b007c4602a10a0mr1870777ioc.18.1707884851406; 
 Tue, 13 Feb 2024 20:27:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVBUDMD++07WUlvIj14tnf+AlGfmsp8dZhGJwja1/QZMXc0Fbc+rZKOToK05hdivDJH9Gd7+NNRNUvb/hBmP+FVsq8LWkjyzEqQympXik3ekXSZ9yIr54dpsCtvCT+UorqFekQTyU7sUbLxsBWtOWacbG1i4QurQnVZJMC3SE2NQ2uFuJ4n3W//AqcV/eX9eqcwL8Gu+/oWKu8KpgPFuNrItwepc5hY8Jm3f8Hye3whWVRw014aT+zAiO4duTp7qW3UCPJTPbzZodKzkYmyuUnEorKVtIXvVTmG8X7l
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a02c9c2000000b004713170def2sm2312305jap.93.2024.02.13.20.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 20:27:30 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 2/3] Hexagon (target/hexagon) Pass SP explicitly to helpers
 that need it
Date: Tue, 13 Feb 2024 21:27:25 -0700
Message-Id: <20240214042726.19290-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2d.google.com
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
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/macros.h          |  2 +-
 target/hexagon/attribs_def.h.inc |  3 ++-
 target/hexagon/hex_common.py     | 11 +++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index aedc863fab..feb798c6c0 100644
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
index 87942d46f4..9e3a05f882 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -117,6 +117,7 @@ DEF_ATTRIB(IMPLICIT_READS_P1, "Reads the P1 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P2, "Reads the P2 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P3, "Reads the P3 register", "", "")
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
+DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the SP register", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 14dcf261b4..b96f67972d 100755
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


