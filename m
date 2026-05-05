Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A4ACD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEIZ-0000I3-G8; Tue, 05 May 2026 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIX-0000H5-LS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIV-0001Vk-LA
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+uTLmmlgVjXjb6TNX2fhiVu4D8fhI2wjN3mkKTnLkdg=;
 b=YLv6WU0PmexHNGXNJNwx4FsKqrvxLyZx4U5BsKvN+TSf89nG6okEDaY0bMgRTsddvp1oI8
 +8Jy5Fy/+yajOoiGntCfAwhpuO0lhRoVMcyZCOQDpHHsyGoN3IobQH5621cJs3i1Y5AJVc
 BbgkZVwApgL0b7GkkKbYLni+hnBDtWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-XINbrlZSPXiNQJEtAnLs3g-1; Tue,
 05 May 2026 07:50:40 -0400
X-MC-Unique: XINbrlZSPXiNQJEtAnLs3g-1
X-Mimecast-MFC-AGG-ID: XINbrlZSPXiNQJEtAnLs3g_1777981839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC74F18004A9
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C2F1944CED
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C06EA21E6A01; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/5] Miscellaneous patches for 2026-05-05
Date: Tue,  5 May 2026 13:50:31 +0200
Message-ID: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-05-05

for you to fetch changes up to 8dc8f7b5bc755227c72eb74aa332e7a6bbb90066:

  qdev-monitor: Fix qdev ID validation regression (2026-05-05 12:52:26 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2026-05-05

----------------------------------------------------------------
Markus Armbruster (5):
      hw/core: Deprecate query-kvm
      error: Fix "to current monitor if we have one" comments
      error: Restore error_printf()'s function comment
      qemu-print: Document qemu_fprintf(), qemu_vfprintf() failure
      qdev-monitor: Fix qdev ID validation regression

 docs/about/deprecated.rst |  5 +++++
 qapi/accelerator.json     |  8 +++++++-
 include/qapi/error.h      |  3 ++-
 system/qdev-monitor.c     | 12 ++++++++++--
 util/error-report.c       | 32 ++++++++++++++++++++++----------
 util/qemu-print.c         | 14 ++++++++++----
 6 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.54.0


