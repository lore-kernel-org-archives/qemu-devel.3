Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D392410D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7As1-0000QV-E5; Mon, 30 Mar 2026 07:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7Arq-0000PA-ID
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:33:19 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7Arn-0001LU-S3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:33:14 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260330112750epoutp0218d91b2501e0ab79e2df27b3bd59b487~hmuzpoqnl0575905759epoutp02Y
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:27:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260330112750epoutp0218d91b2501e0ab79e2df27b3bd59b487~hmuzpoqnl0575905759epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774870070;
 bh=8dYO0Cal7JKXgkw8r1t4deNnsMpfLjmSTju1/M+pZ2Q=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=EjlCLc6kKrJIgsBKyCZsRhaeJO+mb09skTiHwao17vXgFjB/e1qzNXRJDkgzG05d1
 Gor2jNIy3hzBMHed3lsxY58x+qaqXswK7XXGbNR8QTQz0iE3TvuTqyuBNNknOrvcQ4
 e26wyRjETX+kkjXx4YYTdKBuICD5ZnAPf3a06zfk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20260330112750epcas2p4a1bc95f515e2377745f01da47afe00df~hmuzPEZ5G1453514535epcas2p4f;
 Mon, 30 Mar 2026 11:27:50 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.211]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4fkprj4wW4z6B9m7; Mon, 30 Mar
 2026 11:27:49 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 0/5] hw/ufs: Add Write Booster Support on UFS
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p1>
Date: Mon, 30 Mar 2026 20:27:48 +0900
X-CMS-MailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p1>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the QEMU-UFS emulation is implemented based on the JEDEC UFS
4.0 Specification and does not support the operation related to UFS Extended
Features which is defined with latest UFS Specifications.

This series modifies the UFS core implementation to align with the JEDEC
UFS 4.1 Specification[1], and adds a Write Booster UFS Extended Feature
supportability.

Tested: x86-64 KVM, upstream QEMU with Debian GNU/Linux 10

[1]
https://jedec.org/standards-documents/focus/flash/universal-flash-storage-ufs

Jaemyung Lee (5):
  hw/ufs: Apply UFS 4.1 Specification
  hw/ufs: Modify flag handling operation
  hw/ufs: Add IDLE operation
  hw/ufs: Add UFS Write Booster Support
  tests/qtest: Add UFS Write Booster QTest

 hw/ufs/lu.c            |  85 ++++++
 hw/ufs/ufs.c           | 569 ++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h           |  42 +++
 include/block/ufs.h    | 110 +++++++-
 tests/qtest/ufs-test.c | 176 +++++++++++++
 5 files changed, 938 insertions(+), 44 deletions(-)

--
2.34.1

