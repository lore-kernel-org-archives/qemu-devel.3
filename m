Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993FCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5T-0000nI-MI; Tue, 03 Sep 2024 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5P-0000UG-7k
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5M-0002uW-Bm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so46256375e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379731; x=1725984531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UBzlCb7RRPjVLBJHnDbcvnTn6N5F9W9Gb8kEyuiORpw=;
 b=VoTTviFQzXA0YY9udNTSO3NegGy61AV1fMePZP2uGAdMc7e8NUe96Ruu3b2RkX/ths
 wJSFhIxIuqclyYBwLI5r+vRZFYzmPKfsWmvE0nzgQvy6eW0xURvmPrWKmk+xU6Is1SH0
 hRw+/iA0W9rb94cR+82drgKJ8DWem4JRMEDLoD88SfTzHhE/OIglpjFw9JTaRrhcTi/0
 v39Gyh30aspOjrb1V+TQG4AwBaY/43GAaoALb9xBOLxzR8USP4nsYahStLKfiTR8Le7P
 zcc86UqMjQt69fOr7htg4Mn/PG2U3j/awSC2P8rNtsxhpsNWcZplEzJNZI5e+z32U0Hd
 /wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379731; x=1725984531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBzlCb7RRPjVLBJHnDbcvnTn6N5F9W9Gb8kEyuiORpw=;
 b=V+xXfz1YY0/lzh8E8ZIP/qmjutgJ3lgT23Xeo6cutMQYIOLJzfPiZs0nPlKzfbej1v
 oGG/9NnQKKakIPQRjj27I5Z3kkssNXz2uhgLKRHRoawYlUVpuNSfM/3JCMAI1hjbRdU7
 KCv5HeKskV+ClalWkb0+rTsF7KNF7UVVvHxL7ekyTFmwL00VDdB7pdQrhpHIX091gN0u
 F8/dNs3m60xaO33hcBJ8WxUjMvYdyL39mwQAHvbRMunDX/Jthx55AUJBCvmH1ug8rJ6X
 6cbnvZzHOU55nZ3TQrd1cebyuSzUl0kGqel8xh5T7/+MfnBzGTjdU9gG5sDmD5+aoVjc
 9MOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEl4jw9jA021xiip2ZMu1FU80+Irs55PiL2bR36UJDEg0k8kzftMYNft3FP7H0TjYE05itWLriHlN0@nongnu.org
X-Gm-Message-State: AOJu0Yy9/OltOUxAh2HJLWTklV5O9Dd7N8zqObi4+zoj9fw+B6qy70Gk
 5V/e+JY3z0/KYUdL6aVOuuatEuaET09kw1l+SQlfHqDfHUuv4xy/B7bk1BYd2rA=
X-Google-Smtp-Source: AGHT+IGRHvvaqmg/h3YQmAJsNywrFCHoo6G7aZe/YGlrU+D1BDpIWowybMN63iIj8V50r8LSPTt1Ag==
X-Received: by 2002:a05:600c:190f:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-42c7b5b3ed4mr68767465e9.17.1725379730764; 
 Tue, 03 Sep 2024 09:08:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 36/53] docs: Document removal of old Arm boards
Date: Tue,  3 Sep 2024 17:07:34 +0100
Message-Id: <20240903160751.4100218-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now we have removed all the board types that it covers, we can move
the text about old Arm boards from deprecated.rst to
removed-features.rst, tweaking it appropriately.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst       | 15 ---------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88f0f037865..bb04daa52b3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -246,21 +246,6 @@ to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
 read and maintain. Use versions 3.0 and above as a replacement.
 
-Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (since 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-QEMU includes models of some machine types where the QEMU code that
-emulates their SoCs is very old and unmaintained. This code is now
-blocking our ability to move forward with various changes across
-the codebase, and over many years nobody has been interested in
-trying to modernise it. We don't expect any of these machines to have
-a large number of users, because they're all modelling hardware that
-has now passed away into history. We are therefore dropping support
-for all machine types using the PXA2xx and OMAP2 SoCs. We are also
-dropping the ``cheetah`` OMAP1 board, because we don't have any
-test images for it and don't know of anybody who does; the ``sx1``
-and ``sx1-v1`` OMAP1 machines remain supported for now.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fc7b28e6373..815d63f5941 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -978,6 +978,21 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (removed in 9.1)
 
 The Nios II architecture was orphan.
 
+Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU included models of some machine types where the QEMU code that
+emulates their SoCs was very old and unmaintained. This code was
+blocking our ability to move forward with various changes across
+the codebase, and over many years nobody has been interested in
+trying to modernise it. We don't expect any of these machines to have
+a large number of users, because they're all modelling hardware that
+has now passed away into history. We are therefore dropping support
+for all machine types using the PXA2xx and OMAP2 SoCs. We are also
+dropping the ``cheetah`` OMAP1 board, because we don't have any
+test images for it and don't know of anybody who does; the ``sx1``
+and ``sx1-v1`` OMAP1 machines remain supported for now.
+
 linux-user mode CPUs
 --------------------
 
-- 
2.34.1


