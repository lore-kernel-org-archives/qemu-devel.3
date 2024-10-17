Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C12D3C523
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TQn-00009x-Lw; Thu, 17 Oct 2024 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TQl-00008x-4c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:32:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1TQg-0001pi-PU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:32:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so12478715e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182769; x=1729787569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HsByr2/F9yb8R61V/RxanFmNShqqfc0i/+wi/KtFNd0=;
 b=AHDrErLvai/XZPaIXPua77LCAck8v6y7ffqL3vuOC1k6Ox1WOECi0lbXHZUGB12dmO
 1HOxdIG/JEyO/9lSfo//9UA2DXowuQhMkVBVjEm7vYTpIzSJItglSR14DUatEAIuwNAH
 I8XXcTON7qx4AMkqvYU+kdlnTMZbo5aeI68cYOAjLxSOzYnH2hgyc2F/7NbfTXDHcAJt
 bSsrqoqG8rw9gep6wdqtqnkKM2i6V3RZv50EoWh9SYwiDPa4I1spTy4j3R4irl4aJto/
 IyU5jHTcc4777pNJgPr9vjpAsYougWULp1S7w1AoZFiEGJbAEE7FXUUt/Ex8hvLlyWk+
 29RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182769; x=1729787569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsByr2/F9yb8R61V/RxanFmNShqqfc0i/+wi/KtFNd0=;
 b=efi8DsIT094YGdIluRoRy4ZUNsxIGAaioWQTcM7XayzcNTGuU2ox1E/6KXzK+iKKXt
 EVIedEa4L6hAdch24Mr0qAcPUR7n1JdiwYfZVAGDGTjZZQnbL7SHMZxQcSWttonrg/73
 sfr3wTuxuLyTnYDs2jyQW3ez8QybKYbqQix3UxtOH5Q22VkRjRMHjfqvdCzxX6xTHoLK
 wwIccZunkN0NNPovUjCin/nd11/hEw64uhh8zAF7CyK5CgRjpv+a5S6LxDzGNz1ZjMry
 r4ihJp/KtyboHGKNunhHuJpXi3GeUBpI2cb6rLdmgd6W9B9tjUVUBb0RIspGyrT/s6j8
 rTpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf8g8TFfGJZEi/6OZ4rRhjztZHWPtgQifOC1kDij3TCcu8ad1dH042j30K5hMsbzSuz8/K3IBjPw36@nongnu.org
X-Gm-Message-State: AOJu0YzRn8CoEFxkWP3L4X3ncKfwM7CrNYf44/JSe5TsjD+Pn5vYzk9M
 MMUqJDus5YRWGAbpYCZ6b3D6g5hZTcm2RejIJs5MXd6hp737mLsQFV12kXZFSHg=
X-Google-Smtp-Source: AGHT+IGgrrl26I9EWYTAQmdhEJoJ/ZPM0RwXUGPjojeSOV3jVFn8gANqOjVxPiKrodTqf9XJySUHcQ==
X-Received: by 2002:a05:600c:4e10:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-4314a2cc3a3mr69365415e9.13.1729182769128; 
 Thu, 17 Oct 2024 09:32:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316067dc56sm545165e9.3.2024.10.17.09.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:32:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] arm: Add collie and sx functional tests
Date: Thu, 17 Oct 2024 17:32:45 +0100
Message-Id: <20241017163247.711244-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This patchset adds new functional tests for the collie and sx1
boards, which are the only remaining ones that survived the
culling of the OMAP/PXA2xx/strongarm machines.

For these tests I'm indebted to Guenter Roeck, who has kindly
built and made available the kernel images, rootfs, etc and
documented the commands needed to boot them. All I've done
here is wrap those up into test cases in our testcase
framework by cribbing from some of our existing test code.

Based-on: 20241017162755.710698-1-peter.maydell@linaro.org
("hw/sd/omap_mmc: Don't use sd_cmd_type_t")
 -- the sd card test for the sx1 board will not pass without
    that bugfix

thanks
-- PMM

Peter Maydell (2):
  tests/functional: Add a functional test for the collie board
  tests/functional: Add a functional test for the sx1 board

 MAINTAINERS                         |  1 +
 tests/functional/meson.build        |  3 ++
 tests/functional/test_arm_collie.py | 31 +++++++++++++
 tests/functional/test_arm_sx1.py    | 72 +++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100755 tests/functional/test_arm_collie.py
 create mode 100755 tests/functional/test_arm_sx1.py

-- 
2.34.1


