Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DF3FD4F19
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01oU-0000xc-Nk; Tue, 10 Mar 2026 14:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01oT-0000vM-6c
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:28:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w01oR-00049d-Fv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:28:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2addb31945aso95381015ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773167289; x=1773772089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e4Q2dkkI0mk2vsvJY3N19Lw1PUlH/8eA9sGDCLUaGHk=;
 b=SDNRJqDHYwWaZenzuqbT8AQept91psKMUmsOQ5npvErwhjcCU154KArScFFfKGoAWG
 KDRPPd7PHbkCqKpHBV853O/ZSN22qRtwnqQEeCkhvaSeOUMtEl9uOkuh6Vj9JoqcBvZ/
 GXX70R8wHiSctTKt6HZCpS3LMmhrcYRwOPgrCPTPQeon2YM/Rdp9ltCMfdrWj3egCAg3
 OB5G/AaSJ3F/nFkSv5VjYa5w3F15RH9HFHG9myDDbCCDYTevI5SXMggYlUzg2LG4rSoa
 9O5rdHvzUAnupQkmzakoAq/h7clAfcwmr+w3LCTkyg1paCa2ZaO1mgWEsHUdrsQoL2OV
 FtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773167289; x=1773772089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4Q2dkkI0mk2vsvJY3N19Lw1PUlH/8eA9sGDCLUaGHk=;
 b=H0UA+bTA21KXYsJCKwe65huRcsC8O/i/p1yAIbC9TfdpZQNvKSegG/jv5Qkd++L8wh
 JgxUhiG7Dwe0Em5K34YjaoKULNNVtr9toxMPhKm5Ox5yb4tJSIwxnZjzPti/35WDegbE
 dt09HhIHfhJkpORYbSgduT6NJBRs0N1uCzyvwCf42VPWguorPJcXwfWw+4kMBs4Qsnfr
 wIdK8lSMlHHkJC7vfGtVNJD5oVy2m8ezwPauMl2dcdF1Vy9kG0NReLsP6ZTSTuQ4EDs2
 4F/K1pBYBzzpQIepr17Ipu0x/t3gYNMAsG5/Wm+8ckoDfM/HV+Mvt3g82gGCi0YLaaBC
 JS5g==
X-Gm-Message-State: AOJu0Yy3DAUknPvRqZ4Md1QtoCDql/YcpIExPzr1uzqZxfFM8lHUd7e+
 mkDtY72vmrR629aeD6humvlV/Jx3IHYm6MMqb6eyePAjFdE48t9FLo030yuRmtHWWi0=
X-Gm-Gg: ATEYQzw4Vi70oLSHeRboL3SRBIoPNbOZADFM+Mj5plXAu3AOuPlLBpQXPPZKbtfZQex
 W8VACaS2AVkgfShye1P9GRtp14th3awAyU0hW7uwwmbelIpAGYmOf2OSCFKnXNI41OT/fnG/vKk
 cSEtHODw3Flzws001u/5tslOYg4/BgmB8GLElkl/eRz91P+x3qEPMnOqlaPZ+xeaWnlZno6KI1L
 yHXop/oe/IUaY3v8MmcQQeospwR5GkSzl8saQQobUY2jiNviPB3FJjoH7o9xmQARc6WN+f5uzr+
 FpduU6IOYBTx3umKrkOBdUl8bBFCyHnvqHb1PeQZOQV48nzkVPPWYGZQtRjpKMwOSj3JYWXklEK
 z6WcPamgH1ol4XoAweCHVNiwCx52ekauPpFthwQPF2ZheapEVLdgs/duhXwLIMDiMXxz+D1n55W
 Wk3R7eUqnhetsT+vxFscg4Gm0PY7J4azy0I8e530BXQmhbKE6G5eC7Qzvn
X-Received: by 2002:a17:902:f541:b0:2aa:d65f:47a2 with SMTP id
 d9443c01a7336-2ae824671c6mr162337625ad.41.1773167288826; 
 Tue, 10 Mar 2026 11:28:08 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840b2e9dsm209437015ad.85.2026.03.10.11.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 11:28:08 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH 0/4] Fix error handling for callers of
Date: Wed, 11 Mar 2026 01:27:56 +0700
Message-ID: <20260310182801.196443-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Trieu Huynh <vikingtc4@gmail.com>

This series audits callers of load_image_targphys(), get_image_size(),
event_notifier_init(), and msix_init() as discussed in issue #413.
The callers are updated to cover negative return value instead of
continuing with invalid state or failure.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413

Trieu Huynh (4):
  hw/core/loader: fix error handling for load_image_targphys callers
  hw/core/loader: fix error handling for get_image_size callers
  util/event_notifier: fix error handling for event_notifier_init
    callers
  hw/pci/msix: fix error handling for msix_init callers

 hw/alpha/dp264.c       |  8 ++++++--
 hw/hppa/machine.c      |  7 +++++--
 hw/hyperv/hyperv.c     |  4 ++--
 hw/hyperv/vmbus.c      |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c |  2 ++
 hw/m68k/next-cube.c    |  9 ++++++++-
 hw/m68k/q800.c         |  7 +++++--
 hw/m68k/virt.c         |  7 +++++--
 hw/microblaze/boot.c   |  4 ++++
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/ppc/amigaone.c      |  9 +++++++++
 hw/ppc/e500.c          | 10 ++++++++++
 hw/ppc/mac_newworld.c  | 10 ++++++++++
 hw/ppc/mac_oldworld.c  | 10 ++++++++++
 hw/ppc/pegasos.c       |  5 +++++
 hw/ppc/pnv.c           | 20 ++++++++++++++++----
 hw/ppc/ppc440_bamboo.c |  4 ++++
 hw/ppc/prep.c          | 10 ++++++++++
 hw/ppc/sam460ex.c      |  5 +++++
 hw/ppc/spapr.c         |  8 ++++++++
 hw/ppc/virtex_ml507.c  |  9 +++++++++
 hw/remote/proxy.c      | 15 +++++++++++++--
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/sparc/leon3.c       |  5 +++++
 hw/usb/hcd-xhci-pci.c  | 17 ++++++++++++-----
 hw/vfio/ap.c           |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/vfio/pci-quirks.c   |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 32 files changed, 185 insertions(+), 38 deletions(-)

-- 
2.43.0


