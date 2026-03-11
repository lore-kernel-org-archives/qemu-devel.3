Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD91125863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OOK-0004Of-74; Wed, 11 Mar 2026 14:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOI-0004OW-Iy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:34:42 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0OOH-0000VF-1e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:34:42 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c7384f5a9cdso67034a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773254079; x=1773858879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrPnx4TE/249DH/6+ivRlHOe7XZAi9rhm/k579I4fmk=;
 b=TsE6pMyAUmiFZhh2qSzr2G1FsrUoqD9y7XrITwMQZfG4mHPdlDxTgoSo1TvBR5nfIY
 MiwP5tnSK0mkiZmWoX7uySaq1kmyZO98MnGrTJtyoDEV6y27v9H+QdF7QLsaXbgGnHDw
 HoBy9UnYL1dmUDQEblqrip+oCbh0IEBn3fXFd02m7ssyEd2BSfxeXhbV8JNvhEg5KxWF
 sgOpo0l7n7/1niRe8nS3eRSlR4IlA7gR9WbElikLBnSdsRO5vatnIfMVSiP3inQ6p1nq
 B6ZoBpz5flbX3KrSMqacmRm//ZGVE+vsKZ2bF9Vc7HQVzMSX6iGxYo5zgMCQULPdCcBW
 +Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773254079; x=1773858879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrPnx4TE/249DH/6+ivRlHOe7XZAi9rhm/k579I4fmk=;
 b=vuoIqG9gjFKVXMGiqeAWVbv14PQsvM2CGoAlElallD1gp0BzvF/whs6NdjbrFuJYau
 V+QDp7TRcoPPXSit9WmumviPQwkxiICwPDrvBpH0C/BHK16IGghvtW/QmMPtpQV0JFEa
 6DkCTSNWVoSk4XEq+kxmSpFJwCS1PuM8i0u0O7Tc7OBR2m87y8vl3rvZodOXMyVbAaX8
 FiiZuCQeO66qeE+nCnkoBN3R6UkOBfcSqxnY3wSjj1zlmWr57dHg+lSCWgOfpiY74gW7
 0vadiymVJVLG/gxUEGFMVnUp6zj3+DU6HkGDqs2R+eYtnVYbd4mekddPQ8tW1WceRXbU
 ILoQ==
X-Gm-Message-State: AOJu0Yy9hmQXXPSg/KTusNt6dbWep4lYh4mhkkf0Rbyqyo+FOdom6Rl4
 mQzdJefy3kQ/pydT9UL4YBmALMBetiovzWpvS9MqHAtwh7AVrCTIeP7wb1VM+65i1yR6Cw==
X-Gm-Gg: ATEYQzxUYsKLyHo30VhLMIxPM92rAo2NJVjV8WKe7I1tiD0AqNOT+Bs/WRPJX1yIL9f
 kl3htJmO2RhTqYazKsY+BPvxskrjkwm0r0iD9r0tzVscRNev/+yNe368K7qc2nKlv0Xr/W1dVfj
 lHY3jxrQ/AB0skCxo6TbpIZYRphkLTCbJnoLPqW7DOlLQtVZ+GmKNxUK21XYy5qsmuQ5dzFSp1+
 2hK/y003muR+9l095q9NkyrgERGat08HTlObSRPbSljnyICq1EIGYpNtmrs8WRQOW9kPrcQfaWh
 XYiLbaaQZ1+NxMbkhR2zLii1QdV1xdBtX+NuDAc89qs+5L7VyvA3MYAIprpz3xYDxFVDlGZclBT
 gVPXGeGpozw6n9qzn/+o6w/TdnFH32zkAkP0lj4MRj1a1upgKHNLuqnh4BqGLGFtQlsjoc99gPg
 mCfLmRMAj5RYt0GgRNRYXF+58sQi1IHS0SeM82VaBYWNEP5w==
X-Received: by 2002:a17:903:2a88:b0:2ae:7f70:b2aa with SMTP id
 d9443c01a7336-2aeae892fadmr40712365ad.29.1773254079215; 
 Wed, 11 Mar 2026 11:34:39 -0700 (PDT)
Received: from localhost.localdomain ([123.19.166.13])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222e2fsm42124115ad.2.2026.03.11.11.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 11:34:38 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v2 0/4] Fix error handling for callers of load_image_targphys,
 get_image_size, event_notifier_init, msix_init
Date: Thu, 12 Mar 2026 01:34:26 +0700
Message-ID: <20260311183432.214960-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=vikingtc4@gmail.com; helo=mail-pg1-x532.google.com
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

Changes in v2:
- Patch 1: Remove redundant if (ret < 0) checks added after calls that
already use &error_fatal (dead code, pointed out by BALATON Zoltan
and Aditya Gupta). Use &error_fatal directly for NULL callers where
failure is fatal.
- Patch 2: Fix to only exit when size < 0 since it is not mandatory,
either BIOS or FRU (pointed out by Clément Chigot).
- Patch 3: No code changes. Add Acked-by and Reviewed-by tags.
- Patch 4: Use errp param instead of passing NULL as default to handle
failure (pointed out by Akihiko Odaki).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413

Trieu Huynh (4):
  hw/core/loader: fix error handling for load_image_targphys callers
  hw/core/loader: fix error handling for get_image_size callers
  util/event_notifier: fix error handling for event_notifier_init
    callers
  hw/pci/msix: fix error handling for msix_init callers

 hw/alpha/dp264.c       |  2 +-
 hw/hppa/machine.c      |  2 +-
 hw/hyperv/hyperv.c     |  4 ++--
 hw/hyperv/vmbus.c      |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c |  2 ++
 hw/m68k/next-cube.c    |  2 +-
 hw/m68k/q800.c         |  2 +-
 hw/m68k/virt.c         |  2 +-
 hw/microblaze/boot.c   |  3 ++-
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/remote/proxy.c      | 15 +++++++++++++--
 hw/scsi/megasas.c      | 18 +++++++++++++-----
 hw/sparc/leon3.c       |  4 ++++
 hw/usb/hcd-xhci-pci.c  | 19 ++++++++++++++-----
 hw/vfio/ap.c           |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/vfio/pci-quirks.c   |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 21 files changed, 66 insertions(+), 31 deletions(-)

-- 
2.43.0


