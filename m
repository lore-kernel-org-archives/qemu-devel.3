Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D6DC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wmR-0001lA-8s; Mon, 06 May 2024 07:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmP-0001kk-VD
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmJ-0001sh-LQ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LfeUNHCUlXdUgrM1iqoBXdGRDuj1orIgD/TwK4KQqss=; b=DOSoeXazQ4Q2YvpuJWrpQ646MB
 y0Su0CLwitQLrxi2Z9QE0puwazeDtRKnZekJqbLz3MXRyhchUPF+eJqaLtQuTmgLdlWZ5SDJoF6aO
 gGvZlgWFQmPmge1aTDe9ZAQhC840+IvQKFwPZiFFa6um6n8erJ17aoDywjDEOhFvQ7zdnvZd3abLl
 olZ5xecB8HMOSdytE06YNw/1rPCnQz7ovBTcWfdfJYpIvSs3NIzHe8Pj5osWdHrLGzcAnMeE8GVFP
 81ZFAPlDxVwwY0XQyNnAWpWOqLzoghnnU5TViEYlBgf3gx9wathfH3Lbt6NOoVeVwfuSdOoSbRWmG
 Y7NML8tcwIhDucVgIK3A/3vbFcXGFTaF7Dz5e3o+2tOIYGQmRA2km8QWzaUQpylVAyIwsDPDM6kRT
 arkML2pPws+Zljv/nML5qWyeAuhysYp0XPPCqFEt/8lnKAGJdHU7/g01kCMFsJfdZE5aKKRxP4+TV
 K+sKDVdsfgR/Tyh/GhQdTRemY8mujfDvRZqgzq2N+GexlkBb6H/8aJSSdw8ct41jVrZopUzPETSGm
 8RU1r0UAt6qiILJ+TBA1rPZsRi6lSKhrvSEyKp7uLfCMCOqJpAg8QLao9sPBqju76+YX0oOdNy0uy
 QUKRsxxm2mxWRkRJoF+AYuN+SPahiiOfOiK3Lfzx8=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wl8-0005pA-7G; Mon, 06 May 2024 12:43:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:39 +0100
Message-Id: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/12] qemu-sparc queue 20240506
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:

  Merge tag 'pull-axp-20240504' of https://gitlab.com/rth7680/qemu into staging (2024-05-04 08:39:46 -0700)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20240506

for you to fetch changes up to d6f898cf85c92389182d22f0bcc3a11d7194fc94:

  target/sparc: Split out do_ms16b (2024-05-05 21:02:48 +0100)

----------------------------------------------------------------
qemu-sparc queue
- Default to modern virtio with iommu_platform enabled for sun4u
- Fixes for various VIS instructions from Richard
- CPU name updates from Thomas

----------------------------------------------------------------
Mark Cave-Ayland (1):
      hw/sparc64: set iommu_platform=on for virtio devices attached to the sun4u machine

Richard Henderson (7):
      linux-user/sparc: Add more hwcap bits for sparc64
      target/sparc: Fix FEXPAND
      target/sparc: Fix FMUL8x16
      target/sparc: Fix FMUL8x16A{U,L}
      target/sparc: Fix FMULD8*X16
      target/sparc: Fix FPMERGE
      target/sparc: Split out do_ms16b

Thomas Huth (4):
      target/sparc/cpu: Rename the CPU models with a "+" in their names
      target/sparc/cpu: Avoid spaces by default in the CPU names
      docs/system/target-sparc: Improve the Sparc documentation
      docs/about: Deprecate the old "UltraSparc" CPU names that contain a "+"

 docs/about/deprecated.rst    |   9 +++
 docs/system/target-sparc.rst |  12 +--
 hw/sparc64/sun4u.c           |   7 ++
 linux-user/elfload.c         |  48 +++++++----
 qom/object.c                 |   8 --
 target/sparc/cpu.c           |  66 ++++++++-------
 target/sparc/helper.h        |  11 +--
 target/sparc/insns.decode    |   2 +-
 target/sparc/translate.c     | 129 ++++++++++++++++++++++++++---
 target/sparc/vis_helper.c    | 189 +++++++++++--------------------------------
 10 files changed, 265 insertions(+), 216 deletions(-)

