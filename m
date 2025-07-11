Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996EAC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBaQ-0002It-Re; Fri, 11 Jul 2025 07:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaK-00029C-A9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:32 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaBaI-0004N2-O2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:06:32 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so22335031cf.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752231989; x=1752836789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2XzdzMP0KbYZdU4dBnsHpBD3h23r3MkZ3uzzncjXPI=;
 b=lecTWSIfcY+0GsgPoCa/gyft+pobbrasyx+E3g+f0voDKPfc/MXMsqn8iPO7xzbbby
 ee+NCyo3BJLiBpoNMjzIC1eU90m1eSU0Chog7FBpGRnoavp5hUFBnlX83pAEqz/u3ZxE
 JsKstFUNpLUeywi0zhtmdttie6yUQpRzI0N1oJqwJI2sVrkSpNyOHOOktWOBLZWYGCFM
 oPp5E7/sRv/4u84U41jRrJtqUvlRP14eKMTnASADwvR9lYfT/hwuEGc2xwESCWKkvUxA
 /JNidJ8VsVaJNQaTRnzoAxDu6nhGbU47eYa7l/cBOSQA+k6YfrNGBslXOSaNXRtBVftS
 yHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752231989; x=1752836789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2XzdzMP0KbYZdU4dBnsHpBD3h23r3MkZ3uzzncjXPI=;
 b=pvMZqGZgYYZ6A/4fCHAA+eQtDGly1iTrjx3ipYrTnFEMQzmP1GgR/31dBs7tH3Gwwm
 np/Ta95HrmR4Y2cCNk/+PS6DwrZDxYhN3Zkp1nO/cCecQkumXaXYQz+P71Nvx6frpTl5
 XLoPNlhr46Y/QEcklIE1G3DBuW098W99wnFO3XOZVTp9q3LhxTwm4tcbhwXJ4Y9Ht6ga
 bxyhVvT6xJzneM1QG9/RwOYuq6IAjhL2CL9rLvOfzfs6LKwewVhD+hW2H0UUEXw+bJ3A
 iJ8lJ6EAf/nTF81bU4JflEN/AT7B5YYO95jaOBS9wWcuhqKUKiVM/Hb0yshe0nT19bCX
 w33g==
X-Gm-Message-State: AOJu0YwkcSl3fsqynAWH2J1k3XoEDQ+hg2L8vUW6y6R6fBEW2VyuFcJD
 WkwyWI3d4i3l/SE7wk+spq1M7DsyBY8PHFkYPmpy/B7rFsRxbtttPiABnaOVlg==
X-Gm-Gg: ASbGncsoNB4DoesaaY8xNBLuDnV3qjEK8LUMg++mWODFCMQYl3S+Us3Itwfx/aL7wJL
 MgCwV2aM1yGVbxhuHTFM9WuU/pf+UoAlT7SffaaRfHSO2sV1DMgLNmmKEHFMVsMrk8loGP7vjGJ
 0k3T/GaiZ5B7cxAzTgnIAqnbO3TucZ8I9cj+JjSNufecQSHkOy8m1DuwkQEf6nL5hcEIVu54TCv
 4Kh0/76Xqu4QYNrO7kpFC5y3L4hXcHeRgyhjUeypE/SFQwdaS91PoBnrSryvfd0VENYYI53Wunf
 9dg2h3hSlf494M3k/HiMANKbZbUOgoNV0E6ELPhQn9Gtedu1RtLjGlCP4/EWygUV3+KDET5p4I5
 3nn8eezD9V1lLrtXT+UzXmWWVmER/QYEaxmRguTz/5rXda9g=
X-Google-Smtp-Source: AGHT+IGd1Cg2OvI40ggqAm57sY9dJPW3iTefNnNecwFu0xyJgYpTRFMCnGfImYL3+LUvPfNiSmtyiA==
X-Received: by 2002:a05:622a:4e94:b0:4a9:ace0:b24e with SMTP id
 d75a77b69052e-4aa35e9ebadmr43262951cf.37.1752231988884; 
 Fri, 11 Jul 2025 04:06:28 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:9684:12c5:c8ed:6d59])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9edcafb3csm20238471cf.34.2025.07.11.04.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 04:06:28 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 0/2] MAX78000: documentation and test
Date: Fri, 11 Jul 2025 07:06:24 -0400
Message-Id: <20250711110626.624534-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

v2:
Docs now build. Sorry about that

v1:
Adds .rST documentation and a functional test for the MAX78000FTHR machine
as requested by Peter Maydell.

Jackson Donaldson (2):
  docs/system: arm: Add max78000 board description
  tests/functional: Add a test for the MAX78000 arm machine

 docs/system/arm/max78000.rst              | 35 +++++++++++++++++
 docs/system/target-arm.rst                |  1 +
 tests/functional/meson.build              |  1 +
 tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 docs/system/arm/max78000.rst
 create mode 100755 tests/functional/test_arm_max78000fthr.py

-- 
2.34.1


