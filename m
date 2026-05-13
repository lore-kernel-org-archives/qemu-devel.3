Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41628CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDkd-0005RP-3z; Wed, 13 May 2026 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDkb-0005Os-IQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDkZ-0002mm-QJ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778694722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZDVsmuh7jJda8jne/OCtDj0mMfpkGAK3uyESxUmjXOI=;
 b=Q3la5RIvE1fUOZ8PhX7NC1lKjvnCKIq32C9lQXS037UUsN8o0OHx5T/Kle57a6S5BC5Spg
 IQcuqPVcDXhgNKm7wDoVeGeEEb7eyPnOFfITLh3nyxkR5xHyCAd+I3f69ThbtyFewtWJfN
 li6UxR2WqCGaS4fp87QLKBwv2GSKeqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-cBnZeMZoP7mTiHYF4MPECQ-1; Wed,
 13 May 2026 13:52:01 -0400
X-MC-Unique: cBnZeMZoP7mTiHYF4MPECQ-1
X-Mimecast-MFC-AGG-ID: cBnZeMZoP7mTiHYF4MPECQ_1778694720
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9039E1800603
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:52:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EED119560A6
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:52:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB3BB21E6A01; Wed, 13 May 2026 19:51:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/6] MAINTAINERS patches for 2026-05-13
Date: Wed, 13 May 2026 19:51:51 +0200
Message-ID: <20260513175157.3765935-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2026-05-13

for you to fetch changes up to 6a1a6a691c53a13c04d392ca91ed4a1ec56d2001:

  MAINTAINERS: Add myself as a reviewer for Checkpatch (2026-05-13 19:47:00 +0200)

----------------------------------------------------------------
MAINTAINERS patches for 2026-05-13

----------------------------------------------------------------
Chao Liu (1):
      MAINTAINERS: Add myself as a reviewer for Checkpatch

Glenn Miles (1):
      MAINTAINERS: Add self as maintainer for XIVE

Harsh Prateek Bora (1):
      MAINTAINERS: add self as reviewer for PowerNV and PPC TCG

Magnus Kulke (1):
      MAINTAINERS: Add Doru Blânzeanu as MSHV reviewer

Mauro Carvalho Chehab (1):
      MAINTAINERS: update HEST maintainership entries

Peter Xu (1):
      MAINTAINERS: Update RDMA migration entry with M:

 MAINTAINERS | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.54.0


