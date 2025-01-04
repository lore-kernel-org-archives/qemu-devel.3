Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A10E77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU6IX-000341-Aw; Sat, 04 Jan 2025 10:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IL-00033A-IZ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IH-0000s0-31
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:32 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21675fd60feso243314075ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736005347; x=1736610147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V9YD6cRbEfH87g47PyhWhsxF+xtxwtwFSlu32bHIG9M=;
 b=lad/wlCKwwcLw+33udas2TYdqmJwdJkqe+/vYEHGHn3I1uydeb5VqXSqyADM9C7xIb
 oZQiRLHP0waSsBfR/MwxiQ8PMGY1NDT/IbPrUC1qW/vFq9NSae+LV4G2+VD9bllqUt9d
 57cdM/bo5dkPOKWECeuC2izGDzLckarmIMKmwU4HrRtmoQMHMHNmP2b7Bvq6r9eUhXok
 anpdgv/QTZfoTadRrs8aZGd7GM5VT10wkr+7JozDLaurdN7eITXQC3j2BjrJRxsl7HhU
 PLO5vW+9/ZR/8wC2Bw1mgNsJPaeDPvVEMXpQcZVq03Xw1XhTqUuOLcDaORdipz4ipp9J
 j0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736005347; x=1736610147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V9YD6cRbEfH87g47PyhWhsxF+xtxwtwFSlu32bHIG9M=;
 b=gtRy3YgOMJf2X4F40/FaH/IJLBFN44+V0NnMP0ijRd7nasTM12JjRC+N1yIA2t+MIn
 +JzruC07Jeplf+4ZPB8QjwFwlF9pdgObIajxjCBdgvSuOk2i9tvrwIcrcHgSssKhnX/q
 pvV5Ur2z4kxAJ6OwORTkWeR4BB8VOGAPVFBnWAsbwTzFvXLZz9Mufm7WDtv9VwMn9o1F
 fncx/tAIMUNoP5wg43H51rVdq0MJh83p0glEPpTHeta9JmQx61ZM3MNzho2zPiBR1l6I
 KFf2tQWtUWAQV/qlQ+RZ03syq3/S/x0QEUUbnsh/Tjlndt2HhUVtt1mbE/hNBu0U9ihd
 WWuQ==
X-Gm-Message-State: AOJu0YwrqA7zwCmAzrohk3a5THyDfoFoBMXzUAWM/S62ZhdkIGIfFfzj
 7AcQ8e6oLVQhgY7yC6H3JaiLt92BBnunb2Zg4Ng8OyQENM2Guws=
X-Gm-Gg: ASbGncuuvfMRR+QsblPVXOWyo6ORdbvuhF6ZGrjIbtFFV4iO21hsmyQy+BLki1I39mE
 o87LL2D8Mg5TckCqFSLf0pQMjcGlUbI4jeZcSdXYHDHu8uKCrGFFrmjFww+iKWHwcAnP6jpCUDO
 fZvtYbXU+LLhQWrVv1yZ+3qm37parIGCX+YhJmnEuRu3NF57VH+SiSImgl5Qp8pPJtadubVpvxO
 YkdG18usaN9RL6WPo12cQWvtQXlN1WkI6k4OcUvBd50GAkHY0ldYbTAS/vMkabjyfXOyA==
X-Google-Smtp-Source: AGHT+IECIhI4cxsLFl752mJ+EAX0ec5qFyj2cL6ZbWWM83iQI1yQ9dIhGQkFzKjBUgF4so+pT6Z2xA==
X-Received: by 2002:a05:6a00:2d0b:b0:72a:83ec:b1c9 with SMTP id
 d2e1a72fcca58-72abdd7bdb6mr70816919b3a.6.1736005347271; 
 Sat, 04 Jan 2025 07:42:27 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8162d0sm28113388b3a.12.2025.01.04.07.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 07:42:26 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 0/3] vfio/igd: VFIOConfigMirrorQuirk for igd mirrored
 registers
Date: Sat,  4 Jan 2025 23:42:15 +0800
Message-ID: <20250104154219.7209-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
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

In commit 1a2623b5c9e7 ("vfio/igd: add macro for declaring mirrored
registers"), I introduced a macro to handle mirrored registers in igd
bar0. However, using the existing VFIOConfigMirrorQuirk should be a
better approach I think after going through the vfio code.

This patch set introduces a new header file, pci-quirks.h, to hold
generic quirk declarations, and extends VFIOConfigMirrorQuirk to
support offsets in PCI config space. This eliminates the need for
the previously introduced macro.

Changelog:
v2:
* Removed 'const Property' change, it was a mistake in rebasing.
* Removed unnecessary initializing config_offset explicitly.
* Separated GGC and BDSM mirror into 2 quirks.
Link: https://lore.kernel.org/all/20241231151953.59992-1-tomitamoeko@gmail.com/

Tomita Moeko (3):
  vfio/pci: declare generic quirks in a new header file
  vfio/pci: introduce config_offset field in VFIOConfigMirrorQuirk
  vfio/igd: use VFIOConfigMirrorQuirk for mirrored registers

 hw/vfio/igd.c        | 125 +++++++++++--------------------------------
 hw/vfio/pci-quirks.c |  57 +++-----------------
 hw/vfio/pci-quirks.h |  72 +++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 145 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h

-- 
2.45.2


