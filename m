Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3X-0001kp-7Z; Mon, 06 Jul 2026 18:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wgs3V-0001ds-5G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:49 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wgs3T-0000vT-2U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:48 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 47AED7A01DB;
 Mon,  6 Jul 2026 18:44:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 18:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1783377884; x=1783464284; bh=yeBC7FIMRe
 hpqrkuC16VlFlySy7lL9rLahK+B23Gv6U=; b=BzspeR19MPHp5pYwyVcEJJx2Td
 d+uu6ZfOHZexhKo9FcxlWX1q/tHBUe1yj/SVFkDCRtsQQljiLahstmz4GrcMNJW2
 RimtG343CvD8EbxzjEnRu68gl4+WA4oQEGzgPt2mVoX48pJfHLAKK2ZdC0DRNZdb
 2izr/9EnbnXkg/E8O4/UuPUTsSoWKnYW2Je3wsTVdBgMPhDD4Q9VZN6sk6py3tRv
 U+dcLtVqPZsnFCUXj518mvNcXUaAGgJTE9i4BDP8hOcZOgMYhDWEv0VklSYPO+Tk
 laQd13QTFvQ1r+uppp3m1KM6PJSCMvv2Ekrx63LJF9diRTh4zUp1acAsOyzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783377884; x=1783464284; bh=yeBC7FIMRehpqrkuC16VlFlySy7lL9rLahK
 +B23Gv6U=; b=pyiCMBG748CxqpFKW2o5vNNncbzhkmTHdWlfWslLGYvff6t7YQU
 K+ObBsI2XkGkekj2h95HhdAFqc/NodbU8vJNb8Sefn/K2/L0b1anHLQSBU3w9iI1
 +KP3ltEzjdgqdnsM0xrGfestvAwUhVNJGlEB6Vlrrx+NJhSaZxWWBiTRHz5AtrF2
 o+4VCSrT0Lcj7TxTNPn+BqMC2GgHdO9QSvgq+eyJAfAdRFs+uTSQbmgLSs1N+4Pk
 X6f1pVQr2hgb2wssYN0/LkmGyULebU5nBw4RY9qb3ADgT78iaujKPqoiRy1T9++p
 UkQMGTYh3RFeajbuxH5COcbUxmlhImuprsA==
X-ME-Sender: <xms:2i9Maj9pOAEYKhaCucN8hYgcbtGIHE1BlwtDESoOkxKAK2z3SowF4A>
 <xme:2i9MakBVP3miRs3PO0zubu3MwHUA7nDRFQ7xf8jrrHGu5JVxTD7HaXK83dLd7OHQS
 o9Q3A2fszuNUNh7oqNPqDeQnL05JwHO9f_uT86kzcenJWbKy3r4aL4>
X-ME-Received: <xmr:2i9MagJ_I3n7SV5_glFLSu2nlQ2OYec4EvaX2BfrpuOBLVicqEKaEUKGyvRH8fOy-rAkbwcsZqUSkgj1lXG-67AqyWJPlRqdc3dhEbUuCfHIfm3yLI32yGmrFQ>
X-ME-Proxy-Cause: dmFkZTEO5hwNQoOH/0f5WnSkyBa9t1/w/yqxfQMgHL36qSwzHETqiXsQBP5WH1VMWa1nA5
 wMpRJ9FNCdTNaIWXMSd9CZOFY6YNpb/s4w0wa2COlAHJzIg9dN4ea19puM5FYhqJ0PqUmf
 odz5xkACWFQeej3vgdhIsu24Z6S2G/LNvqUh+XFcaxFeR9gQ50XSRu7cg/Rf8qvlee49AB
 SIJXQStdzZEvcRoFYDVQZcHNoF1Ghr7bMLBUHyBHjW/3bvYSiuOyEvg0GVC0ekTtQEztqs
 tDCjB+DGfq5ATEqRrLu2dqrZg5ay7dDrpdvLNLQoVbTla2YUpfM2lG41zRqN8ftBSS2lmK
 QKoQFx20HIt2j0Et6nx4t3jMTqMWcQRTjYZoA1MF/dyqPTpI9z1bcNaWDFOgDLYk4Sl/PO
 m+cgmfPlnhUejNGgPSc9C2hpQEuxJh2kp3DS9ieT7zi61pep5G1KH5NbwVCABoCLRkGeAJ
 r7kFKVgpSei7qOqQ5CfSTh+9waKk063MbdZnpYYMKFQCFNEYRHDG3V42D6r7tF3xUZeTqG
 rO+1OpzLaH1Kf2ytso1dzH7kRx8J9Mb+M4jy1o5uSGpm3KnVF2Y63WIzbEyYcxJDHWuaVx
 o7ieAXl20VM0bVs0L/I45xHXce2+lVA61Tw2UF1THcMCG/xh/rCoOxVZlafg
X-ME-Proxy: <xmx:2i9MannX4vuij318Z7hvw4b-HlIRRRmEwsYyoE_ixG8GYBBb7jNXdQ>
 <xmx:2i9MauF8NtMsjqzkhHu9A0TV8rE3T8zTJdcb5iXhsokVwoxU5huJJA>
 <xmx:2i9ManHVmwgNldCtVljrKmmTbl0hDeD8PNMlKWvDuFYHFrnE8ZVfXg>
 <xmx:2i9MarPiqtim7ccy_8ILOBOZvJ05-MS6xQc_tnwoFCqkXQNY-hqKhw>
 <xmx:3C9MagRIVxPt8FBtii_3QJpJx9BfW0TyBlE6jHyigUW2219w61I67gqm>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:42 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 00/11] hw/nvme queue
Date: Tue,  7 Jul 2026 00:44:12 +0200
Message-ID: <20260706224426.14156-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf:

  Merge tag 'firmware-20260704-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-05 08:42:47 +0200)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260707

for you to fetch changes up to cfb6c95706998be9a6606d80e03f088c0f5b7b42:

  hw/nvme: add namespace hotplug support (2026-07-07 00:39:42 +0200)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Alexander Mikhalitsyn (8):
      tests/functional/migration: add VM launch/configure hooks
      hw/nvme: add migration blockers for non-supported cases
      hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
      hw/nvme: set CQE.sq_id earlier in nvme_process_sq
      hw/nvme: unmap req->sg earlier in nvme_enqueue_req_completion
      hw/nvme: add basic live migration support
      tests/functional/x86_64: add migration test for NVMe device
      tests/qtest/nvme-test: add migration test with full CQ

Jesper Wendel Devantier (1):
      hw/nvme: fix FDP set FDP events

Keith Busch (1):
      hw/nvme: ensure sgl forward progress

mr-083 (1):
      hw/nvme: add namespace hotplug support

 MAINTAINERS                                    |    1 +
 hw/nvme/ctrl.c                                 | 1240 ++++++++++++++++++++++--
 hw/nvme/ns.c                                   |  172 ++++
 hw/nvme/nvme.h                                 |   21 +-
 hw/nvme/subsys.c                               |    2 +
 hw/nvme/trace-events                           |   10 +
 include/block/nvme.h                           |   12 +
 tests/functional/migration.py                  |   23 +-
 tests/functional/x86_64/meson.build            |    1 +
 tests/functional/x86_64/test_nvme_migration.py |  172 ++++
 tests/qtest/nvme-test.c                        |  419 ++++++++
 11 files changed, 1989 insertions(+), 84 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

