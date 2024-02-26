Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA75AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPr-0001cX-P4; Mon, 26 Feb 2024 15:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPp-0001bT-Mg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:33 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPm-0007zH-IF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:33 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c1a172e158so250906b6e.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978647; x=1709583447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRjb46WdqEPMqkZSAvVdtRTJCtj+kvcnkZkQaWAfooI=;
 b=D2OvewPWCe+Rb9nKXFr2V75ffzC0apR0vheuwh0WQhdTktfMMQOiYt5F4A9gR9aTMF
 dm5a58uwg/Jz6V3G49/AoVfDNHTK9MDYzOh5dDngLmm0LwZq2ctuMIhyrIgs5aPA+jGd
 bDZRQp/EN5LlzRLhIQIgDAxPqhZYh405lVThRtM5Tfoywm2LN+ftoerPGoJusXHw6YaG
 wuwlLjgI6p9rP5nDOYpi+yBkaZz4sWeysmnwoIzBXjPsuO9xCEmXOJJfK1YJxYYEC6zl
 ZnsZ1ilDcONNx6CFcJpDht2RdDG6V2JuDtjWlUD2TuTfDomtxLGaVgtwrXiRh1VMRE+P
 CBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978647; x=1709583447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRjb46WdqEPMqkZSAvVdtRTJCtj+kvcnkZkQaWAfooI=;
 b=TtiPDvWvHiISQ+VxfO1Kh37/hv3PISzjJwkMyHL9w8niGBGhFlhzyp+ULvF28nndw9
 KlbxJSAiXUn/Un/gqHCIMONclmVpgTS++LJsUOWbwz2OQ9nsab13zj/OcM93ZiKS3Kh8
 C4bW/9PWbiu3EbHrWG5/1/9KXacSAJoAB4JNtz/ivnHumiulAISY8KN3YxIN2UIIRs3c
 5cNSgrsZ3++Me8pw0PNCDZWvU0ajd64WBMHwrIwnPC46lo88fHOFmXmOyRdQePYPCZgD
 9CjymPTuX12IJ+l7R3FqfvWVljlh5ShUERI3ZG5Yy3b2ZWR3jkn/+AE0+gX7kDUW9FWZ
 /Hww==
X-Gm-Message-State: AOJu0YyIUVw6JQ4Rd3OjTUMjq2FEyAuPsG4bv1jHDWIz2RXTE2a9IgaV
 cz4+ACkWbyKEr0hS+e/5w8/uNym1OoW6tTiczUgKA6bctu/uniJKPV7CZXL/70Q=
X-Google-Smtp-Source: AGHT+IEiY2QoZhU/f1IY5AVw5xH2J8iMPXwY4ylnxBnPExap4nLqI8CQnThVm2npQTws8Sb9L+rlfA==
X-Received: by 2002:a05:6808:14c7:b0:3c1:7ebb:e24f with SMTP id
 f7-20020a05680814c700b003c17ebbe24fmr98056oiw.16.1708978646972; 
 Mon, 26 Feb 2024 12:17:26 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:26 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 1/9] Hexagon (target/hexagon) Add is_old/is_new to Register
 class
Date: Mon, 26 Feb 2024 13:17:14 -0700
Message-Id: <20240226201722.391879-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22a.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/hex_common.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..4bacef223f 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -397,10 +397,18 @@ def is_readwrite(self):
 class OldSource(Source):
     def reg_tcg(self):
         return f"{self.regtype}{self.regid}V"
+    def is_old(self):
+        return True
+    def is_new(self):
+        return False
 
 class NewSource(Source):
     def reg_tcg(self):
         return f"{self.regtype}{self.regid}N"
+    def is_old(self):
+        return False
+    def is_new(self):
+        return True
 
 class ReadWrite:
     def reg_tcg(self):
@@ -413,6 +421,10 @@ def is_read(self):
         return True
     def is_readwrite(self):
         return True
+    def is_old(self):
+        return True
+    def is_new(self):
+        return False
 
 class GprDest(Register, Single, Dest):
     def decl_tcg(self, f, tag, regno):
-- 
2.34.1


