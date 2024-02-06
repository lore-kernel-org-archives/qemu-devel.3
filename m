Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9ff-0008Au-E1; Mon, 05 Feb 2024 19:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fc-0008AM-V2
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:40 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rX9fb-0000Le-EK
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:50:40 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-363cdbd584eso3354755ab.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 16:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707180638; x=1707785438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM3kEimAZ8RmJFomVzINHAkYspMcJtgmOD3pmftJlXs=;
 b=NqHnRgHiheNQEqCSx8WhVtdrw2ELsoB0Uk6NkQsHlBMwRZq0gPeYTOcpyH3DhOQg+t
 AUy2cZE8yPKLUC1ejc+I61S6jaQiaqQpvx96Q6Ci/W20eBJ5+6k8DLIs3ZY5FhwRALq+
 /0Alpc6bhGPVCmdiEQytwyh3UMlVAM5Z63X2Y+AGjXle1VU/00ii/9cicJwfOGwgEafi
 7R/yGvamIzuEe0XE0dKZ+mxNoGHT0RrzBgOKW4hCD00nq3hmlsJ9W3e6QezYsprD8v7T
 Z8YyYsyipJ3XNIuroacKpoTiS+PqHy79UL1hFV3FDLI97oARaBPavmDIAD/AyRrO17bm
 P0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707180638; x=1707785438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gM3kEimAZ8RmJFomVzINHAkYspMcJtgmOD3pmftJlXs=;
 b=idPwuuxcsOPZNJaR/lBsodgWO9EnW/fbBiW0+OGMHVvu56x5kCoaAJ5tmUYyiwOIwI
 wV14tv+JZnPsPJdfkGGEngLBpNbMmxQOKMfFhLZWaW8faDkbzQQrcyu27XpTuSRFfUr7
 JkzUfYTOxINrjEpXqsvLlsIL+9iCjCSNX0uJAE4TdcaN+rqGHzO6TTLaZK5QyFq2D2Ot
 tOEqxUkloYH1RO/lV+SK74gjXvUzbm2iMdv+xvAiMWQflLZaTMSDIEq2NsIf039yI6ZG
 Sc3Zd/tNVU9UAQrtPbTPmS8xUAmDKWZp+P51qRUlW9t3G+4Mx73eOre1Tg88e8CHD0Do
 RORA==
X-Gm-Message-State: AOJu0Ywzk+MWPdEszYvDpkgT0TQs4OkixSFAIRFtGO4Yb/9HZkzpIqP2
 Ms0ozyWfccdi6Z74TBqfYCYeM06ae9eK1SBFeOaF8V2rKK5wmEUJdTGvUeyKcZo=
X-Google-Smtp-Source: AGHT+IH4LTtaphClGWWtV91PUayvQ1Zpc7y+FrJqvMY28IZoWkaWkYKkmpkV12cS3xtvj2O7qJ57sQ==
X-Received: by 2002:a05:6e02:144c:b0:363:bdb9:72af with SMTP id
 p12-20020a056e02144c00b00363bdb972afmr1806032ilo.23.1707180637868; 
 Mon, 05 Feb 2024 16:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX9g1UHHh99vV/DXwFmYgn1ZQOHquetQN2g8z3ihtgEHIU9ljfK/dFY0gyXQtoCE4663o5wnOWRDGZSjHIejkGUm5aGX7Dpso3vwwj3eUcBv1oYLW8RiSAoCmpK8Y7fMUN9iNpiB94Gdwpco/YSlwsk0/p1YGG3pe21Nq7TeFnMDN/qQBfYBWDG6thsNRFERlw+pw+3td6DR0oqj/4h2ov3ECx7YB496y7Zr9WOKXpMGeXc61c5KCfC6Q+8N1AL3lj8g6kEx/Pix2zQYigS8TdBeDGfWgkiA8Plm1k6
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a02a408000000b0046e2ce45dafsm245840jal.165.2024.02.05.16.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 16:50:37 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/3] Hexagon (target/hexagon) Pass P0 explicitly to helpers
 that need it
Date: Mon,  5 Feb 2024 17:50:32 -0700
Message-Id: <20240206005034.267283-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
References: <20240206005034.267283-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12b.google.com
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

Rather than reading P0 from the env, pass it explicitly

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/macros.h      |  2 +-
 target/hexagon/hex_common.py | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 1376d6ccc1..9c700ce8ef 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -358,7 +358,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #endif
 #define fREAD_PC() (PC)
 
-#define fREAD_P0() (env->pred[0])
+#define fREAD_P0() (P0)
 
 #define fCHECK_PCALIGN(A)
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..2dbd0ea737 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -197,6 +197,10 @@ def get_tagimms():
     return dict(zip(tags, list(map(compute_tag_immediates, tags))))
 
 
+def need_p0(tag):
+    return "A_IMPLICIT_READS_P0" in attribdict[tag]
+
+
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -1118,6 +1122,12 @@ def helper_args(tag, regs, imms):
             "tcg_constant_tl(ctx->next_PC)",
             "target_ulong next_PC"
         ))
+    if need_p0(tag):
+        args.append(HelperArg(
+            "i32",
+            "hex_pred[0]",
+            "uint32_t P0"
+        ))
     if need_slot(tag):
         args.append(HelperArg(
             "i32",
-- 
2.34.1


