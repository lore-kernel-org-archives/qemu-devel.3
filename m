Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233BEC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdHM-0002x1-Td; Mon, 24 Feb 2025 13:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDC-0005f6-6o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:50 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdD5-0003Iv-Kq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:49 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2210d92292eso143254995ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421779; x=1741026579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b7ZpKNKV2lhTLpMg6c3MCxEe2mJkFJIwCBfBpYs8QpY=;
 b=HIJeKEc17HP3rILBHcbyU1QlHAEJah/5BsjX5tO9sCz45rhsQEh3ZVIv0j3vWYfdfL
 O1hpYdeInes/ZhpYtk5h/1gEQ58zWSZGDX+m1jH35Ct//2xNQCiKjDgrugVov7SNaYdp
 rC6S+1LqxtBjT9FaKpAhZg38nRLluVvcXWCdaYa5RqzinEIF18RBfJjvV71+1YyDhSZG
 q8SBnddr0gYcNrcOg+mHNKpkg1DGIl7ESTpaakvITv6mmpVEVeXQDxsdCePCURD/GrYV
 q0qS4zDVeXG8TVtnCwN/cOxKTM51OvhZRgC7lV1xyfTGDU7vXFZzW7Kpyn3FkzbIHD2q
 lfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421779; x=1741026579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7ZpKNKV2lhTLpMg6c3MCxEe2mJkFJIwCBfBpYs8QpY=;
 b=q+Jw64hwuFJTQGW96Ul3nmcwy8tjaMrCmDXSjKcQdjbfLTnSi+8M7tTO2K9xkIMDhd
 C65Pwgw/vu1urcRAOaAzjtWYV8/y/GLIy2XkSGJfAZfNI56tCQdS6y7CsACdCt1zIVeY
 +sCk6S8oyqyMkUR3oKFGbkQXlL7oB7kABE3kse1WDcndrLwjAVxU3FMX4+ec9ZDb3lwi
 kCLAHwxxKwclSmBnnn0v3op32Ti05sav0/Xq4bnizpXmdgkFPh1wegONWQR24Y6VZJLt
 GkHJ2Ud1G3k/w2v7/LmLVahZMDqwGdhRmFXYRXpFHKOy9pcv1V6bxunbcfTUB/qSK5yZ
 Vfrg==
X-Gm-Message-State: AOJu0YwH4NMj0lHar3IWnrfu0YZ2ljlEJ6mk5+kO2E3qpORtHdykv4Nv
 bDUrOjnbvZsinrO7VDjhbqhhJuOA+Qdr4iSKD9xpupBP63rP8j4=
X-Gm-Gg: ASbGncvo8tv6WdKmT1yKhL76aOxlsCwXBKDS/VtIys5cHeIfZXkGSJfni2qCzZWJodl
 7dC0DKHL0gvVhbRWlDNT+wOU5GwJuibfYWrUDfkBTNAzx5AwB3s1flWBw3fsGEiq8fijzreTenx
 B7PjyyLumOyZTbBEpmCDNU6flRGbKPAo2UZEmDCJJIOuW5btqhh6lGcRBmyYshWe3hyge3r5lai
 CaEQ9WJvvYhOytpsWhGBDrHjfzEIIcKAp4GYxAGvCa0LxuYjGupEn74tsN1z/zpvvOyyLIss7hG
 Ab/bD/erZkk4tFCf2aKtJMuxUtn4OnFTEGlXg9g=
X-Google-Smtp-Source: AGHT+IFP2RTDZHRpdj0fwVyUP2FuFd0Cx82WQyta0jzUFvXWt/+ibSuIhkiUs3SLmRY68s2dJ47hVw==
X-Received: by 2002:a17:903:2a8d:b0:21f:6584:2085 with SMTP id
 d9443c01a7336-2219ffc4928mr256406105ad.42.1740421779263; 
 Mon, 24 Feb 2025 10:29:39 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:38 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 00/10] vfio/igd: Remove legacy mode
Date: Tue, 25 Feb 2025 02:29:17 +0800
Message-ID: <20250224182927.31519-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patchset removes some legacy checks and converts the legacy mode
implicitly enabled by BDF 00:02.0 into x-igd-* options, including:
* Removing PCI ROM BAR and VGA IO/MMIO range check before applying quirk
* Using unified x-igd-opregion option for OpRegion access.
* Introducing new x-igd-lpc option for the LPC bridge / Host bridge ID
  quirk. Currently this is only supported on i440fx.
* Extending quirk support when IGD is not assigned to BDF 00:02.0

The first 2 patches of this patchset was taken from a previous one,
details can be found at:
https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/

This patchest was mainly tested on Alder Lake UHD770, with Debian 12
(kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
17.0.1081.

If the design is good to go, I will update the documentation also.

A open question is whether the old legacy mode behavior should be kept
or not. Checking if all the condition of legacy mode were met and
toggling correspoding options is more complicated then I expected :(
Any ideas would be appreciated.


Tomita Moeko (10):
  vfio/igd: Remove GTT write quirk in IO BAR 4
  vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
  vfio/igd: Remove rombar check for legacy mode
  vfio/igd: Remove implicit VGA access enabled by legacy mode
  vfio/pci: Make vfio_populate_vga static
  vfio/igd: Consolidate OpRegion initialization into a single function
  vfio/igd: Move LPC bridge initialization to a separate function
  vfio/pci: Add placeholder for device-specific config space quirks
  vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
  vfio/igd: Replace legacy mode with options

 hw/vfio/igd.c        | 476 ++++++++++++++-----------------------------
 hw/vfio/pci-quirks.c |  51 +----
 hw/vfio/pci.c        |  33 +--
 hw/vfio/pci.h        |  12 +-
 4 files changed, 166 insertions(+), 406 deletions(-)

-- 
2.47.2


