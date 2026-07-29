Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A5DC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5ty-00030D-UX; Wed, 29 Jul 2026 11:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wp5tx-0002zv-0z
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:08:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wp5tv-0004xS-Dp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:08:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso7303345e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785337732; x=1785942532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TOVI9vlBg/Zwpl99CvORjZtAh+wjDdgsFc5ikvIlBvY=;
 b=oXb24QD/Aghh2wkWb0djRJURqTgI2uHan+EBYp+cRVnFbKu6B82NDbbLWYP2QDR9po
 RWXEI/shH5Vo0ScdDjwuLYGyaGWnG5Ds5cpLJp8O72FCuMJOFydGUc3eusrRqgVTRh41
 40OXt1py50rTOQhsgyJFobSoN2y0Mh8tNHwodRLt9ZQNyc3VTeouptx2SCpG4iBdnNbc
 BLnF11Y+aeZkb7R74EHoleZzutHn9fcYIG7XrsaKOSJjYQQQirHdGD6D/j6M71b3dVZr
 xK10LyIT+ATjsYKLc3TM4/n7RviRyUXjcPPmBKN2Swj3d9K0erYtf4PxOP7UDrMls4BZ
 ywLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785337732; x=1785942532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TOVI9vlBg/Zwpl99CvORjZtAh+wjDdgsFc5ikvIlBvY=;
 b=JJlPnz3tCZ/Zg7zn03VtFkE19ib8oscEeQFlw50H4H4Vb+yEHJbWmIRKj7+5N7dDLb
 6vXzAU01XgILCeadmC6p4ym1SEoKIb3gS5Ghwvg7xTotZ9Y/VYjnCY6DhLM87yYpWcrw
 URP0puM8LOUCz+hjUFTzp3y4atwqPQb/Uteu4fOzbnRLQ616zU6ugrPdFXdw8s87duia
 bHIxefm+jNU0Z/xX/2usz+VZWenEUnji8v+AKdb6eiYWJzNB4lhIKctazQeLODHmEF44
 njDsc6T94W6NyLEJTmV9w4yiNOZY1RHrwLSgaYNbUvZ2EDpO0Lk+fEM8obZRdJxSecSr
 Ax9A==
X-Gm-Message-State: AOJu0Ywl3DP6zcuvn6J3sC+974+2s6c+M9pFB8L6oBJ6+ie9kCzZTBQu
 vTjBlWcuB6/lWG8WHUG/h7x55Wt8K6hWjO3ih5foc+Pah85+M4XuD/+4P75PqQKBZ6M=
X-Gm-Gg: AR+sD138TWzYww9YiBE1uftcRq3nIOYVO9Oj9BYeJocYmSUjm+MIuszty2qp0wvIbqc
 Ul0MGUoWJnM0MzF8Z5EdXq7Uk3uB6JrqLIkOCh0pctt/SX+fXSNfGEKujEmIP0IOyIawq7SHCcf
 MiJGOpsgogOUSzS2aFETp9M8OdW/my+AEpGw9TFwOXMsdNqxy6+yNXPbW/xrxaNYmx3LcVHdZwG
 qDJbjGDc3pHF0zO+VVkUof4nqhSNTlciUcLJe1teUyMw8+yuFUHx7C2I81eUB+XSqd7ntEKzl5O
 hyBr0P7+c7FUlceJbmtWUp4L0TbdgHE+rrQnfNOzFmjMmEaW/W7t2edDHgX38Zh55n23WZPkr1G
 gdGwny59Jt8V0jygHDjsZDkFJMTPjYB0MgXcLaJnD2dIc1iYiSULl2WZ2IZyVJOMgRr0dnwdLz7
 a0R3nNmnp60vSURjq7e59eqcHz3u13yOcLIyytv0yEhTpfpOtgmcgGm7N7RpTo4dbLbMkKi+MHV
 xV98l05jU6aEK5eYpCibsEw9DpEIN4zqMCqFddsJ6bHE9wAaIu8cGt2I+R0ehGAn3F2lELXmMat
 548WovBAwyTO07G4qrMs8qNuRYKRoNsNpQ==
X-Received: by 2002:a05:600c:4755:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-496c6440c93mr83633195e9.15.1785337731860; 
 Wed, 29 Jul 2026 08:08:51 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4615681sm165353515e9.11.2026.07.29.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:08:51 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH] meson: do not emit modules with no enabled sources
Date: Wed, 29 Jul 2026 15:04:21 +0000
Message-ID: <20260729150420.632747-2-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x331.google.com
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

From: Rohitashv Kumar <roohiit@amazon.de>

With modular builds, the system/block module loop adds the common
boilerplate (modulecommon) to every registered module and emits a
shared_module unconditionally.  A module whose device sources are all
disabled by the configuration then still produces a shared object
containing nothing but the boilerplate: an empty stub that provides no
devices and only complicates packaging.

This happens when a module is registered under a broader condition than
the one gating its sources, e.g. hw-display-virtio-gpu-pci (registered on
CONFIG_VIRTIO_PCI, sources need CONFIG_VIRTIO_GPU) in a build without
virtio-gpu, or hw-s390x-virtio-gpu-ccw (registered unconditionally,
source needs CONFIG_VIRTIO_CCW) in a build without an s390x target.

The target_modules loop already skips modules whose applied source set is
empty; make the system/block loop consistent and do the same.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index 49a5baf5..557edd71 100644
--- a/meson.build
+++ b/meson.build
@@ -3903,6 +3903,9 @@ foreach d, list : modules
     if enable_modules
       module_ss.add(modulecommon)
       module_ss = module_ss.apply(config_all_devices, strict: false)
+      if module_ss.sources() == []
+        continue
+      endif
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
                           dependencies: module_ss.dependencies(), pic: true)
       if d == 'block'
-- 
2.47.3


