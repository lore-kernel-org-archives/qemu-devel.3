Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD98C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVn0-0004Pd-4e; Thu, 15 May 2025 06:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmx-0004Og-Jj
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmv-00088Z-IZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so5010035e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304764; x=1747909564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CEFPr6cyWXqfoeIE3F4AoQQqrdnfTceL/5vMmBbgJT4=;
 b=Nqrp2efDTgsLTiFHqLZe5cKN+FDHNvXNTAQpyZljW6+t30mRPNNP3Zhtu5k0Kwfqq5
 4wZfHzh26Cf7inGTB1TCsPN4DgdhhBu6B+AIF9sHU77SY1iZw3/shn+e84+VCkvsBtK+
 wzJZINsNpgFkKV4ci5XegeaRrcYo+evOWVC1Wddw7S57avNt7Gb5JHkzKB1Vo4U3ILiK
 sVLEwUx6UUk05f5dQGhxCrWFl06+Of5VErn4b1m/FTSm2qys+RZZfctfdTSYIvMPHhbw
 iGngC1dCe/t+T+Qt3j2ecEXxkSIO/m0dob9xE/xu9pBsn1oZBQrC7CuHM6PwUZZIsZG2
 Pxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304764; x=1747909564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEFPr6cyWXqfoeIE3F4AoQQqrdnfTceL/5vMmBbgJT4=;
 b=KSJxY0g3+beG5n4E8l+k/y67l3C7WdkN1AWJdHkn75QDXpu3dLfd4a+tlobjnGvgUz
 XA/FGpQtP5DJYbTbzWMImf1WyLys5UAkeev+L5iD+sk5Vk7coRUzSjGbCgZlOb3c8Pil
 hP73qvidS+FrKa1oURZdZTuIJcj9y1uSjbt2Dtasj2aJwgJvRX/HKSjtLag3kTeN0Ea9
 LKe/Ew1fzWNIOqnY1AkEn1VkWBTvTEVWcKD0HVPyAtn0+O/HdvYGSSq6LQcTnq0o8O1l
 OSn+nfhg6e/1Ea2CDngtr2+AizQiz4Gnb0pdG/P2+SYr88kjxnmPIqlYomhs/0rZ3dlV
 SjQg==
X-Gm-Message-State: AOJu0YzT4PRGZC9j28GyHfQcTWpaWiG+qjz0VaJllLxGsbEvEi61Ygra
 Pes1owTHnbsyKc3giQT64dn5xWg+qpTtFRkXftP/QV+Fg8Kf0jj0afLHr2gAbPRntzZLfomPN4Z
 QEdM=
X-Gm-Gg: ASbGncsX+ABY3gtNXWfuYu/jOI2ymRI7NQWN7lP3IgF5GqgJov62me+yggBP6x57xI1
 32RGrQJXpOciqhmvNgcA07LksWnTC8FRLBjbU342eyU8CvYlOwuNGsxtCDauf9UH4VfWpgrfz/q
 gGnM3iNeZ48B51iZpVFeY/iZp6z7AC6v0qxfd3CBzGGSdPxAAqGxMs+LavPn0rBoOgXKgF8rq0L
 7xITHM/HRlBAHEMVtgXxKN+VjIzj5I7petXw/dP0cSGZaIzO0D1e66hL+n5/mATjcTwflyswmel
 Pnm3LDLo+CFQrwEBOvnExM63arGo6pEkLxgaeIMM1tJYWuDeq9Se8WYGPQ==
X-Google-Smtp-Source: AGHT+IHzFiNDe0GOFzQDGvtqDXuCYMjfffNSQC2wVlL47O70U0WdZveSFY2+QtxaK3Pm9fZPA/H8sw==
X-Received: by 2002:a05:600c:4508:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-442f84f8ec2mr26475245e9.12.1747304764095; 
 Thu, 15 May 2025 03:26:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/58] MAINTAINERS: Add an entry for the Bananapi machine
Date: Thu, 15 May 2025 11:24:58 +0100
Message-ID: <20250515102546.2149601-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Thomas Huth <thuth@redhat.com>

This machine was still missing from the MAINTAINERS file. Since there
is likely no active maintainer around for this machine (I didn't spot
any contributions from Qianfan Zhao in the git log after 2023), I'm
suggesting Peter as maintainer with status set to "Odd fixes".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250508072706.114278-1-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dacd6d004d..ca0ffc02d4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -732,6 +732,16 @@ F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
 F: tests/qtest/test-arm-mptimer.c
 
+Bananapi M2U
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: docs/system/arm/bananapi_m2u.rst
+F: hw/*/allwinner-r40*.c
+F: hw/arm/bananapi_m2u.c
+F: include/hw/*/allwinner-r40*.h
+F: tests/functional/test_arm_bpim2u.py
+
 B-L475E-IOT01A IoT Node
 M: Samuel Tardieu <sam@rfc1149.net>
 L: qemu-arm@nongnu.org
-- 
2.43.0


