Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8B2C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xPh-0003pU-5G; Tue, 08 Sep 2026 11:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPf-0003os-N8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xPd-0007Q8-9h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Au1SjmhnM/LHiSwRfJMICYmFCvPd/iNDl42Vi/gpYuo=;
 b=Z+f7Phf7AsLwzgJykcxJwDf5aRg0bpIfwuKKItWU/8OXUNHMh2NcPRuuSxV+woQCt8wJdJ
 Rdl9BRRvC0X0eR9zBSdHhx8fcebZ8EVcGMpBh60ijFxxawuQcnn1FcK4ZD1QoZRStoj/qg
 aPJf/KFORb1LEP8xgEPFlAiBOkVL0mk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-vaUFBD_0M6eXA1-espIG6Q-1; Tue,
 08 Sep 2026 11:07:00 -0400
X-MC-Unique: vaUFBD_0M6eXA1-espIG6Q-1
X-Mimecast-MFC-AGG-ID: vaUFBD_0M6eXA1-espIG6Q_1788880019
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CDA1195DE5A; Tue,  8 Sep 2026 15:06:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 502AC180049F; Tue,  8 Sep 2026 15:06:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/15] Preliminary fixes from "qom/qdev: associate
 properties with QAPI"
Message-Id: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
Date: Tue, 08 Sep 2026 19:06:43 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dENJSraK2jhkthwLXphsvQlo9NAJhOflLUaY/CZ6T/w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPSulSm2uADFLxueXitG9Q4ZdBO8jx1vPPE
 pOPV6OEPRqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5WPMD/9yPpyh02thb0yorctd3H8z2IeIgDxw+m8soWTGjRH8c1rLGiIZFKdhj7PDLGEDyQIO6QS
 uSwww/zsGtjC4p6RPNAkVFShwPljduH1GtUoXRSQ2UZNPfiHM5G+sQU8dHZGaZB+iXwBStr95zX
 zlV5lW8d0wRneiOfl3/O/B5xumJDtL71MeEeXTcPKTk0nrnFOi5VUFXTOWCmF2br7lWV5pRcZvH
 dOtHTD+VtVWvMI2Jdil88dXGZX8WWACSoMp8RzW4s4LbCVJmU9IHXC2GPrdhbIXpdCZmGLU76yf
 wPjyop1ROnDptYcjscc1yo/5r3tK2R3nIS8lg1ENDJ/YQi6Y+mp6SmPEvE4qV1km84mo40Nd8rf
 PwCVxF/vx5CxeMefFBcVrAi0qSRwk/WQRJsD8BoYeL5jX9uyJx3ugkCvgXGSAESxbqsqjpjOX2w
 IkOucjKcld8A/tpxsPsxGseUiDO2YB68SuDQ1oYSXAJE4Oi8pd0RVnkWcHLqXumFjZwlHoXSCko
 PWBZ2hjQrijKaBF0p9bSa96Dw07ALVW2XPi1qVPbrm1PGkKHqvT+RW7txX+imvCLMBOPKg6FV2o
 se5YLrIYudiMlPRWfTqEXNWgSBEfFssv8jhFEgehx+H5kH/EkgLt98Yh42nFxq920wzzTJD29Qs
 YmaiOnejZfk+ISQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 55347990687e7bc5b6b0d624f290025726e8fbfa:

  Merge tag 'nohmp-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 10:57:00 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/qom-qapi-pr-pr-v1

for you to fetch changes up to 554a1f83c6118df74b2cb1e4da2271152857b5ad:

  memory: use object_property_add_link for container property (2026-09-08 19:06:36 +0400)

----------------------------------------------------------------
Preliminary fixes from "qom/qdev: associate properties with QAPI"

Mostly typenames fixes and minor refactoring that were reviewed and will
make the series slightly smaller on next rebase.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Marc-André Lureau (15):
      system/memory: fix "priority" property typename
      backends/hostmem: fix property typenames
      backends/hostmem-file: fix "align" property typename
      accel/tcg: fix "tb-size" property typename
      block/throttle-groups: fix throttle properties typename
      event-loop-base: fix property typenames
      iothread: fix poll properties typename
      util/thread-context: fix property typenames
      target/i386: fix CPUID version properties typename
      ppc/pnv: fix phb-id and chip-id properties typename
      backends/hostmem-memfd: fix "hugetlbsize" property typename
      hw/acpi: fix "node" properties typename
      spdm-socket: convert SpdmTransportType to QAPI enum
      target/riscv: fix incorrect QAPI types and u8 casting
      memory: use object_property_add_link for container property

 accel/tcg/tcg-all.c          |  2 +-
 backends/hostmem-file.c      |  6 +++---
 backends/hostmem-memfd.c     |  6 +++---
 backends/hostmem.c           |  4 ++--
 backends/spdm-socket.c       | 23 +++++++----------------
 block/throttle-groups.c      |  2 +-
 event-loop-base.c            |  6 +++---
 hw/acpi/pci.c                |  4 ++--
 hw/nvme/ctrl.c               | 26 +++++++++++++-------------
 hw/pci-host/pnv_phb3.c       | 12 ++++++------
 hw/pci-host/pnv_phb4.c       | 12 ++++++------
 include/system/spdm-socket.h | 28 +++++++++++-----------------
 iothread.c                   |  8 ++++----
 qapi/sockets.json            | 20 ++++++++++++++++++++
 system/memory.c              | 37 ++++++-------------------------------
 target/i386/cpu.c            |  6 +++---
 target/riscv/cpu.c           |  9 +++++----
 util/thread-context.c        |  6 +++---
 18 files changed, 99 insertions(+), 118 deletions(-)


