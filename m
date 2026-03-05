Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A696FF47CD8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFuY-0000n2-BM; Thu, 05 Mar 2026 16:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuV-0000mG-PI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:07 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuU-0008Nr-7K
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:07 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c738d1fa6f1so716181a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744825; x=1773349625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cmkUQQpektDZg6nYSXqC35IjYsPjaAqaJ86eq5VZV9w=;
 b=qG/hYAJV6dZCluhn46E+KgTn4M261jKecfD1HVkJyYd/SdV0u4hA/er5FcaWDbtnm5
 u+ePKvJwPIEoSp8HwWEVOE2KRVo9JOUiHgCu9nmnkrEcVI/6hgEccKy/+pgdd09M8z7M
 86wSWlJthIZjlxoz0nd3vwbKBvRi3oiOXHzCHTQxwgUQeOY3oVasux8xlTvTptoH7RJy
 KdIBz25JqR4fP9DPuqHMiiaeDI/FCBcNBfhwDbzzgrC3lkmi3jZHqnrTv9cnqm32sCIP
 L+K13MOCK9kENOe10tKoEflIiO7XtGMpnbkcJZcCnPHW93seFVAY0Q4T5XfLJhVXnBrm
 ZTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744825; x=1773349625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmkUQQpektDZg6nYSXqC35IjYsPjaAqaJ86eq5VZV9w=;
 b=OZWdiT2l0tQU3K52E5vK27jt8OFMHcWe1l8athpGCWdOH/sBJ/twNxXW1z7E17H1Bl
 I/T4uMCTYXIOh5BlljxFyBCclKJSjTZqBk31/R8DNOddJ8RJyEbV9IX9gCvapeqHmTLV
 MKUHzrrAnUTLSjCCabwYZ6TGAQbV9+s6wlE3+bXOfd+ezVRd3WkfR2iuVHKmTJ/g6AyJ
 bkW7bRGhc8p1WALcj2HwlDo9vYRueOo7K4RrpRosnGfIngxh4vrUi61UyCY/sDOUwaVY
 ZROg/OxqbsGghWsw3RA4coXxac0tAkDWjp83A/qj3HBcBVICHneczuFEjSfQoEFj3vtC
 VPow==
X-Gm-Message-State: AOJu0Yx65H/ngyECBlAZMUBg5SKoBsrgCDe/yNkvCTtcwyMZzKjZ1QCW
 k+zMNA9/VdZRjhSWBLdgjQ/mFJ4act7VqwjRJ6juq918QXeLPzpPmdUTkaXsmGaSPygdpaMD9IC
 WAbS5
X-Gm-Gg: ATEYQzyMgkgLBmIXkBycAVQgrsx30ksBVMzOXybVS+rszYwARPfqJDEbqyywqmcsTux
 hUnUp18nJVHe+Un73bgHtCtyDWh3gfXlaBMOwe6gbJ2ajkYYUtHVkhGPUMS0Esc4SiW8n+/4UVg
 1+h3z1nLlDOmcQthK0WmZ7Tr/7Lq1wXP+Va8Ji5BhonEnkbVCAbxy/hhadWMN4Hn7qmzmDq1qYr
 GQA5DeBg6sLsC4L3d3W+h1AwI58aAbU7lm1CD8AFTpG/lLiqUVnSn+BPt5hCwNxViB+yeMX8ytr
 EIWJHgQJjlt51AsRubqcyhPRK6JROwGzdxsJb+jYoBkaEsTjX2RDmiFZ6lvzgD4jXVfEOB6egJW
 9OBlhkgUZrBeRRWSP18eqd96Xka9ID/NkFzJI1CYOtlofnatLvIzbqAlgWMU5RnEh3rmO6uOrhe
 9LnhEfyZmKBlB6ts27UZ6XcTwAIEWbyxwg22dAxKzcdq/fiNddO/Siorul58ePu7e0/9GtKps+0
 xBC
X-Received: by 2002:a17:903:32c9:b0:2ae:4e20:9d05 with SMTP id
 d9443c01a7336-2ae6aab2d0cmr67823535ad.35.1772744824679; 
 Thu, 05 Mar 2026 13:07:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/6] hw/virtio: single-binary
Date: Thu,  5 Mar 2026 13:06:50 -0800
Message-ID: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:

  Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-hw_virtio_single_binary-20260305

for you to fetch changes up to 187adb4ac6493fdbe4404ef1e35b2629a9564d79:

  hw/virtio/: make all compilation units common (2026-03-05 11:11:01 -0800)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/6] hw/virtio/virtio-access.h: remove target specific code (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-1-philmd@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (6):
      hw/virtio: Add virtio_vdev_is_legacy()
      hw/virtio: Simplify virtio_access_is_big_endian()
      hw/virtio: Inline virtio_access_is_big_endian()
      hw/virtio/vhost-user: make compilation unit common
      hw/virtio/virtio-qmp: make compilation unit common
      hw/virtio/: make all compilation units common

 include/hw/virtio/virtio-access.h | 43 +++++++-----------------
 include/hw/virtio/virtio.h        |  7 +++-
 hw/virtio/vhost-user.c            | 11 +++---
 hw/virtio/vhost.c                 | 12 +++----
 hw/virtio/virtio-pci.c            |  6 ++--
 hw/virtio/virtio-qmp.c            | 70 ---------------------------------------
 hw/virtio/virtio.c                | 12 +++----
 hw/9pfs/meson.build               |  2 +-
 hw/block/meson.build              |  4 +--
 hw/char/meson.build               |  2 +-
 hw/net/meson.build                |  2 +-
 hw/scsi/meson.build               |  6 ++--
 hw/virtio/meson.build             | 17 ++++------
 13 files changed, 50 insertions(+), 144 deletions(-)

