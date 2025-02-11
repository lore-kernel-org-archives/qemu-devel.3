Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94DDC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 20:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwpB-0005zg-SW; Tue, 11 Feb 2025 15:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thwpA-0005yj-5S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thwp7-0001bd-Qf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739305535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TBuT9zgIxAh+Yywt+bJew30eA/A1wg27U3OIlVyQbf8=;
 b=Os9MSfoylULcywIxc+c8fvRxOdDlcZ5F3H4Um7s3vmbvOleHZSmkKG2iWIe/oxP1Gzj1fG
 IR7AyqNVD/gd5tnoUL8bI0o3SerfmjVacrLQACj3rOLsVWJp7JSpnuA/2d7aJshK9HLAP0
 Qe25I3vX8jCzcv8qxqdQh4GgE5tpRio=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-PT7HHSGWNNqUUVXsN6ldeg-1; Tue,
 11 Feb 2025 15:25:32 -0500
X-MC-Unique: PT7HHSGWNNqUUVXsN6ldeg-1
X-Mimecast-MFC-AGG-ID: PT7HHSGWNNqUUVXsN6ldeg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063CF195608B
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 20:25:31 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 662D31800873
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 20:25:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] NBD patches through 2025-02-11
Date: Tue, 11 Feb 2025 14:25:08 -0600
Message-ID: <20250211202527.574723-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-02-11

for you to fetch changes up to ff12e6a5ff904e68e222b0ba567938943e0f4b68:

  nbd/server: Allow users to adjust handshake limit in QMP (2025-02-11 13:45:47 -0600)

----------------------------------------------------------------
NBD patches for 2025-02-11

- Add --handshake-limit option to qemu-nbd

----------------------------------------------------------------
Eric Blake (2):
      qemu-nbd: Allow users to adjust handshake limit
      nbd/server: Allow users to adjust handshake limit in QMP

 docs/tools/qemu-nbd.rst        |  5 +++++
 qapi/block-export.json         | 10 ++++++++++
 include/block/nbd.h            |  6 +++---
 block/monitor/block-hmp-cmds.c |  4 ++--
 blockdev-nbd.c                 | 26 ++++++++++++++++++--------
 qemu-nbd.c                     | 41 ++++++++++++++++++++++++++---------------
 6 files changed, 64 insertions(+), 28 deletions(-)

-- 
2.48.1


