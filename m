Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B202C9EC69
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDM-00025I-Dk; Mon, 12 Jan 2026 05:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDA-0001Tc-HA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFD8-0001mI-St
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso43728745e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213905; x=1768818705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk+GlBfd4MnMnSNPuwPicByGCHTQSdU/sy3BPUcATpE=;
 b=ukJSNDeY7CMN7aoyxOEImP3spMmfn6l83KnLnutvN5svpMel7RdR2v9kanL4lWTqK+
 0GM7AsxzE0EPMYJf9GA2+EgnL51x7qKzU60gUACpZ250XT2VI+KpYrqJ5dY6mfA6T6R1
 eb5VFoG63X1IhS9mpitsMVQohS5ignAJ9FEfvmiyO+Ta9ZKo4FXP9LP+MMvrqvXDgY7k
 dV2eV7qKhJaX3jKF0j19vihD0csAsf+DVBC8h7ROCcaOUxEVSHypnrI4b7W8uZaIOxL0
 d3JQUuVgH1LQ426D4FneRvmOD2ptIKmto0IZP9OT+kq41kxtGBDyGfSElqLdjmlIXb14
 IhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213905; x=1768818705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jk+GlBfd4MnMnSNPuwPicByGCHTQSdU/sy3BPUcATpE=;
 b=ncdTAr4IYqi9mqKCB4pk8MzXJ4zxoYCT7H5isbldcOjTgmtzAfXINvFjAJL5qkDqFY
 ZGbLsZdbG3x8PWGgamiysr87OHZ6J3EIJQyugGqnrDzpi32kd7+/kEq02fldJ91L5/qp
 wpwaJ0LuQCsFneck4BOfdDzK1eCPs7W/BIrpo9c/pTtKkEOMyP/Fycymlg9nTxgaZkn+
 PAt1Y6l3it2+bKzSg7hw8GxAAAteYLSqlylJxBs8V9dA0ZsowCB3bHGhXargCFZao4JT
 Tbn4SB98drIWQe2cEOWEE3kUoPRYnINNUG7TQEhBoGs28cQ+VR6yIah3UmlmE13Zun+i
 abBg==
X-Gm-Message-State: AOJu0YydVKIEwdHpBJCHfIUztNFX5s0UDXGBXnUWFvxV002QCEMOXYKJ
 GUep893imfe+j6JHZW0hlBysz9rxw2txRXTqXFLzlVgQii7YBS/5WpdyxZLW5wAxAQqjD+Zvdz+
 91bfrXZ0=
X-Gm-Gg: AY/fxX7dP8XiZoj9dfyomaQJ9WwVGTckuluFlVXJHuDypRNAG3V8axE9DhsDwk0BjcC
 zw308Ad8lZDDZL/iE91GuaMBy+m2b2QnZTB0KIeN3U4B5gM+P2RsxbxAGr6cUAUoHglk0t/RPvX
 7LI12zUOKYy3IOZcmsFs1QAqLPypphBodl2HkUF2xIBRBXe8YVepY/aD/ZT7tp7lgiRNhhaGzYv
 JdRLB32CSphGogXeRL7djjoEBvNbT8/6Gc5Wu9178CEKhhjYsnMdFtGyj0ozXr+AMKpj6HtvfIa
 7PY/au/YNQ1Jkue+F50NQ6rlvhQvjv69ru23X3aXoFKkP3IUYsKsrl4rf42phfZfZt9TlHQjAVe
 d2xLvxrQpL3KjEITQBFO4LfElP0xiWLz9CIRTHcN22ty0cvRMjh6ixCUfhY3GGHHa/CYotqHSho
 yPpKQjeLeENvZXUnoW2ECH26klldVnaBM5LvcVpxQd21EstSJ24agpxTxPetZIZ4+QZlKj474=
X-Google-Smtp-Source: AGHT+IHizxSyKMy535RWVIsej9xSU97E5QPdXR7pyxDK29UWY3XaC/0ccXP7hOmpNCgyvRi2Jl5k5w==
X-Received: by 2002:a05:600c:681b:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47d8486d5e6mr179002385e9.12.1768213905078; 
 Mon, 12 Jan 2026 02:31:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm37617534f8f.33.2026.01.12.02.31.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 10/19] accel/hvf: Remove mac_slots
Date: Mon, 12 Jan 2026 11:30:24 +0100
Message-ID: <20260112103034.65310-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This data structure is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/hvf/hvf-all.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index dd9ea641ea5..0fbe27dfa26 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -22,15 +22,6 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
-- 
2.52.0


