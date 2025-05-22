Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ABEC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAhW-0005jm-8f; Thu, 22 May 2025 14:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhU-0005jM-Hs
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhR-0000MQ-HV
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747938684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9v7nmLiIwjkQCoYBdCC8Q+4YR0GRLr20HeszimJGv/Y=;
 b=eupGesbqrJIqrOZutGWJ1c4l0D5N20LIgB9Crcv2TMADISRMhXCcpI5gt4TgImMdMzY+TY
 rsy6xqGhD2jDhEfEI49xUlVm6z9VilMN+SKZrO6qmNtAfMoKVBIsOD2zQrHMOO1hs897sM
 kUq2tfY3w2OZqYRJY817qt618ecVkJQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-DNXJG9TNOemoDTP6pAxPKA-1; Thu,
 22 May 2025 14:31:20 -0400
X-MC-Unique: DNXJG9TNOemoDTP6pAxPKA-1
X-Mimecast-MFC-AGG-ID: DNXJG9TNOemoDTP6pAxPKA_1747938679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7145F19560AA; Thu, 22 May 2025 18:31:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FCEA1944DFF; Thu, 22 May 2025 18:31:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/5] Block layer patches
Date: Thu, 22 May 2025 20:31:10 +0200
Message-ID: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f0737158b483e7ec2b2512145aeab888b85cc1f7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-05-20 10:26:30 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to bf627788ef17721955bfcfba84209a07ae5f54ea:

  file-posix: Probe paths and retry SG_IO on potential path errors (2025-05-22 17:56:50 +0200)

----------------------------------------------------------------
Block layer patches

- scsi-disk: Add native FUA write support, enable FUA by default
- qemu-img: fix offset calculation in bench
- file-posix: allow BLKZEROOUT with -t writeback
- file-posix: Probe paths and retry SG_IO on potential path errors

----------------------------------------------------------------
Alberto Faria (2):
      scsi-disk: Add native FUA write support
      scsi-disk: Advertise FUA support by default

Denis Rastyogin (1):
      qemu-img: fix offset calculation in bench

Kevin Wolf (1):
      file-posix: Probe paths and retry SG_IO on potential path errors

Stefan Hajnoczi (1):
      file-posix: allow BLKZEROOUT with -t writeback

 block/file-posix.c  | 126 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/core/machine.c   |   4 +-
 hw/scsi/scsi-disk.c |  55 +++++++----------------
 qemu-img.c          |   4 +-
 4 files changed, 135 insertions(+), 54 deletions(-)


