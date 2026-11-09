Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AA606A339
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jo9Txjz+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVv-0002Oy-St; Mon, 09 Nov 2026 11:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVC-00028i-8k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSV6-0000xE-4M
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WFWEEIKg3ssSaVUEwrbumopShvY96UUkY/cpZ+IohOU=;
 b=Jo9Txjz+Y53bsoiHJ3zxO5b5cGQFKjMdgnJzbGT2jHVhjfdAnkKxNcK4rxepl0T++g/YtO
 jU8TlQlRW29D0bhu5vaXaYNEH3vFQiyTQUx48uM3UqtC961XJFVWBhpRB20oKmkPGqncd7
 oUQv9zhLesdKLlsfK/OtG+8hhKR7xYQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-871zWOi6ONWujjxysWy4eg-1; Mon,
 09 Nov 2026 11:45:39 -0500
X-MC-Unique: 871zWOi6ONWujjxysWy4eg-1
X-Mimecast-MFC-AGG-ID: 871zWOi6ONWujjxysWy4eg_1794242738
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B67C1955F23; Mon,  9 Nov 2026 16:45:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC4AC30001A2; Mon,  9 Nov 2026 16:45:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/11] Block layer patches
Date: Mon,  9 Nov 2026 17:45:22 +0100
Message-ID: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:

  Merge tag 'pbouvier/pr/multi_target-20261106' of https://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 67198583a1ef3432c784f2802c5cda914bc14ca8:

  block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files (2026-11-09 16:32:35 +0100)

----------------------------------------------------------------
Block layer patches

- qcow2: fix snapshot data corruption with discard-no-unref=on
- vmdk: Fix various bugs in handling malicious image files
- vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files
- iotests: add --quiet arg to hide env variable dump

----------------------------------------------------------------
Andrey Drobyshev (3):
      iotests/290: add test case to check 'discard-no-unref' option behavior
      qcow2: fix snapshot data corruption with discard-no-unref=on
      iotests/290: add 'discard' and 'write -z -u' case with a snapshot

Daniel P. Berrangé (1):
      iotests: add --quiet arg to hide env variable dump

Marc-André Lureau (1):
      block: add missing coroutine_fn annotations

Peter Maydell (5):
      block/vmdk: Avoid assertion if image file has no extents
      block/vmdk: Avoid reading off the end of descriptor memory
      block/vmdk: Use larger types for byte counts in vmdk_read_extent()
      block/vmdk: Reject a zero cluster_sectors parameter
      block/vmdk: Avoid overflowing multiplication in vmdk_open_vmdk4()

Thomas Huth (1):
      block/vhdx: Prevent out-of-bounds BAT accesses with malicious vhdx files

 include/block/blockjob_int.h     |  2 +-
 block/crypto.c                   | 13 +++++-----
 block/io.c                       |  8 +++---
 block/qcow2-cluster.c            |  6 +++--
 block/qcow2.c                    |  9 ++++---
 block/vhdx.c                     |  6 +++++
 block/vmdk.c                     | 26 +++++++++++++++++--
 blockjob.c                       |  3 ++-
 tests/qemu-iotests/testrunner.py |  8 +++---
 tests/qemu-iotests/290           | 54 ++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out       | 33 ++++++++++++++++++++++++
 tests/qemu-iotests/check         |  4 ++-
 12 files changed, 150 insertions(+), 22 deletions(-)


