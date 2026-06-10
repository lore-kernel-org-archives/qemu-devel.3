Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A470CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXU07-0006zm-Ce; Wed, 10 Jun 2026 21:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXU05-0006ze-FZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:14:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXU04-0005M8-04
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:14:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8423efad617so4245538b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1781140464; x=1781745264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUWHKuHaOiEQMQWoEi+YsZJzu+zFq0unpWL7PaWlfcg=;
 b=m8FV2wPz9Ob3Q1vA1clH+vNf53EQLPY56X5flhZ8Dn+IDvAAWyR+WvDv24pUjRcCvr
 xmglfYmofqgRwPXdmEb/Wu8i3qa0VFNaGYUhbq4tO9DxdM0lEp/k0LljjWGOV2uhphnm
 UbTCtxpcasR1Gjey22QoY3oL/loUqs/69+hcVOg8Vc7Ba40ufCBl4f/eV9QvTV+02I31
 JFRW7Mm1lJYXLgUvr2G35rLb4fDqJgfSoAuHC3g3Gahnu8wq3fgrxTYnvFmtCDckJiwP
 qv+J/Yt2D7SM40oGqgcN+BHWBQyhbcmcDxSgjbBuPWpgPENpiCQPaHQPLLBQ6aYNybw1
 x9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781140464; x=1781745264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUWHKuHaOiEQMQWoEi+YsZJzu+zFq0unpWL7PaWlfcg=;
 b=BRO4HpM+Ljsh9IlxwvAjNjBdZTKGtfKozPVcLNR9u/yBmZgSjkvyK7ODisVhHOfSrX
 I2R1OxCf1RLL5gMsbwJjppuLkC128GVNkZyPCG9CMxBn13SnrYd2dwSNHODIXQaPqSnO
 RY1JiQk6szJcc0zAFWvbhmxMoXsA/tEi8rtxd9vsXFn6eKSo0Zd2Y39RyznzYCFc39ju
 HbKi3+WScSIFzSK4eGMTnwLJVBw2X2ylTXsLNzbvAK0uQte/GOWUmM3p/W9o/AjHSWyY
 e9de1ZOxw+4FYvDA0lgK3N86R2I5agMlBVKqllk6Hw+cmgUa1O1zto1wOyHGtQEiCRb0
 vZVw==
X-Gm-Message-State: AOJu0YwlUgH4Xj0djvtnU3JiGOscWD+jQwV6lOGxUtygK1SIa1wLNxww
 71aduySuZITzzGVxjGaB1h1JcYREpLnERy1gTXpJH8iz1SxCegPfbL8KLW7oA7jX6/GoFOqmhFq
 T9bAqf2I=
X-Gm-Gg: Acq92OEB7xRDDgxalA9/jIzyZussTEnW5wiYNRTlZBaZjI4yy4kc5B8Rgf2jq9o6I/N
 UUN7jWr5DamZfuHC2D/CfSqVfq7H6KyEl3OdOgRDnv731h1CSevTkcX+xdIRJJtrI57RqDDpNEt
 G+2cFLqca8c+Yei5VLGnkbyHqixpmjfa01DNbEyAJlp30otn8eQuwMtqphbRTOh520MdDVZxLJz
 De0sScc21mqEkz5/2e51dGACCXEKIhPEP7YlQVKObTq7HZ7f5d9pHNL6GjXAdM44GcS/l+4Anfu
 u4YHj/NLlwD+/iWMn8sDNThwJsqi6YEJSjvi6irv8jqqBOqMsK1AbM53lBU4i1BYVtE6LVmK3Lv
 bPWo2CTKVzleN0TZfVZKE38ne6Gu3U1uqIoKPSu0FzGr+JXFdHknfM+f3YlNgdezFCPoY56JmGC
 RFT6yAt4YqGWwdODASzk5DBO985AJgFaXunCp+Gm6YVrS9VM2PzotiTVTDnrxtA3/XuEe47rUZ
X-Received: by 2002:a05:6a00:1818:b0:835:3949:3c22 with SMTP id
 d2e1a72fcca58-84336bc644bmr425918b3a.27.1781140464122; 
 Wed, 10 Jun 2026 18:14:24 -0700 (PDT)
Received: from localhost.localdomain ([103.114.192.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337b916cesm98217b3a.8.2026.06.10.18.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 18:14:23 -0700 (PDT)
From: infra.ai.cloud@bitdeer.com
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@bitdeer.com>
Subject: [PULL 0/1] dirtylimit improvement
Date: Wed, 10 Jun 2026 21:01:51 +0800
Message-ID: <cover.1781095539.git.yong.huang@bitdeer.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hyman Huang <yong.huang@bitdeer.com>

The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d1506:

  Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/qemu into staging (2026-06-09 14:00:28 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20260611

for you to fetch changes up to 3b224b1c7df1ddefd6bca34f201264d72846c397:

  accel/kvm: event-driven wakeup for dirty ring reaper thread (2026-06-11 08:22:50 +0800)

----------------------------------------------------------------
dirtylimit: refactor dirty ring reaper thread with event-driven wakeup

----------------------------------------------------------------
Bin Guo (1):
      accel/kvm: event-driven wakeup for dirty ring reaper thread

 accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
 accel/stubs/kvm-stub.c   |  4 ++++
 include/system/kvm.h     |  7 +++++++
 include/system/kvm_int.h |  3 +++
 system/dirtylimit.c      |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.43.0


