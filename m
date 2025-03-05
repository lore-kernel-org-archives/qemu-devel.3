Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E764C282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpxoO-0007Gk-Bl; Wed, 05 Mar 2025 18:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoN-0007Gb-CD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpxoL-00009q-Du
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741215954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I2QYj+AgOh7rGCHvSYzxSdrB1czTDzMp13HA1MoSKM4=;
 b=YmRMa8w+kB9h58vLNJoYjiSEuKuvw6NCE5cBjZMlVZAKBme2uKvvv8Pvg5rchWcl4xRl2B
 ieBbs89+EgdFluo/QSdJ2aObbq5MwwOgRHcOEF9Sg+fnOVUxuAcinA3CSrMPD6r3fTU64i
 anBdq5EujIoYoFSAGkz9eaRnmx2+jSo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-pqc1t1z6MZqf5YOJ2MhTBw-1; Wed,
 05 Mar 2025 18:05:47 -0500
X-MC-Unique: pqc1t1z6MZqf5YOJ2MhTBw-1
X-Mimecast-MFC-AGG-ID: pqc1t1z6MZqf5YOJ2MhTBw_1741215946
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C12E01801A03
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 23:05:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 333BA1955DCE
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 23:05:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] NBD patches through 2025-03-05
Date: Wed,  5 Mar 2025 17:05:20 -0600
Message-ID: <20250305230542.2225013-6-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-03-05

for you to fetch changes up to 3e1683485656c095860a8dfbe39ab2d0664b84d9:

  nbd: Defer trace init until after daemonization (2025-03-05 13:00:22 -0600)

----------------------------------------------------------------
NBD patches for 2025-03-05

- Several iotest fixes
- Refactor QMP for NbdServerOptions for less repetition
- Avoid a hang in 'qemu-nbd --fork' when simple trace backend is enabled

----------------------------------------------------------------
Eric Blake (1):
      nbd: Defer trace init until after daemonization

Nir Soffer (1):
      iotest: Unbreak 302 with python 3.13

Thomas Huth (1):
      iotests: Stop NBD server in test 162 before starting the next one

Vladimir Sementsov-Ogievskiy (1):
      qapi: merge common parts of NbdServerOptions and nbd-server-start data

 qapi/block-export.json | 94 ++++++++++++++++++++++----------------------------
 blockdev-nbd.c         |  4 +--
 qemu-nbd.c             | 16 ++++++---
 tests/qemu-iotests/162 |  1 +
 tests/qemu-iotests/302 | 19 +++++++---
 5 files changed, 71 insertions(+), 63 deletions(-)

-- 
2.48.1


