Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3570E7E36C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c01-0003xn-Ty; Fri, 03 Apr 2026 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8bzz-0003x6-4M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8bzw-0005XS-I8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212970; bh=wlRH3YJtaehWaKgcqk/9sPVzkl1yjKIuaay4R9DBiew=;
 h=From:To:Cc:Subject:Date;
 b=e+gIxzRwWh22BfW0HZ1h1zda3AtiM49Hxq/KCGL5rFyTx1qRF32OwOxNnszMziVyM
 MtRGqSTG4EjIUYP1v1Wo0IO+NGzFDWZeLYevhc2CLJ29KojOBDVMtwh93k8ttjLev+
 Wrr59j7hliu/X/fmNTsuA8AvQurDm/3T6KyI52mtf00bUiudTRZjvIBll0TEf2kMef
 BhRSOWn+Fw5exJNlRkbhONSj8+ZRn6Pr1ngfmnB21IqyiyvTcOEoXDdYKPq0xpUlCb
 CbtW6lIPFExeZt39I0JObjIzgEHsr+QXpm6liBHwoNWrVcUbQiGK65HkrxTRAwW937
 pk5gM4pmc+DGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E099B19A63A;
 Fri, 03 Apr 2026 13:42:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C03238DB6A;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent on
 32bit hosts
Date: Fri,  3 Apr 2026 13:43:20 +0300
Message-ID: <20260403104327.1163942-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
buildable on 32bit hosts again.  The patches are simple enough to be
picked up for 11.0.  The one from Helge is marked as RFC still, but
I'd love for it to be accepted the way it is.

All patches has been on qemu-devel previously, I just collected them
into a single batch.

Helge Deller (1):
  RFC: Allow building qemu tools on 32-bit hosts

Michael Tokarev (1):
  util/meson.build: do not add cpuinfo-$arch to util_ss for 32bit CPUs

Philippe Mathieu-Daudé (4):
  hw/core: Move compat_props_add() to 'hw/core/boards.h'
  qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
  qom: Declare compat properties API in 'qom/compat-properties.h'
  qom: Restrict compat properties API to system emulation

 accel/accel-system.c              |   1 +
 backends/hostmem.c                |   1 +
 hw/core/machine.c                 |   1 +
 hw/core/qdev-properties.c         |   1 +
 hw/core/qdev.c                    |   1 +
 hw/i386/pc_q35.c                  |   1 +
 include/hw/core/boards.h          |  11 +++
 include/hw/core/qdev-properties.h |   1 +
 include/hw/core/qdev.h            |  27 -------
 include/qemu/atomic.h             |  16 -----
 include/qom/compat-properties.h   |  40 +++++++++++
 include/qom/object.h              |   8 ---
 meson.build                       |   4 +-
 qom/compat-properties.c           | 116 ++++++++++++++++++++++++++++++
 qom/meson.build                   |   3 +
 qom/object.c                      | 102 +-------------------------
 system/rtc.c                      |   1 +
 system/vl.c                       |   1 +
 target/i386/sev.c                 |   1 +
 ui/vdagent.c                      |   1 +
 util/meson.build                  |   6 +-
 21 files changed, 187 insertions(+), 157 deletions(-)
 create mode 100644 include/qom/compat-properties.h
 create mode 100644 qom/compat-properties.c

-- 
2.47.3


