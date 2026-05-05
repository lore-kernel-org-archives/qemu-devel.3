Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1109FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEzk-0002pS-K8; Tue, 05 May 2026 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEza-0002gD-JL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzX-0006xb-Nd
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777984510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CtQnXurUARbCe3iRDuvPeKIVV/NaYKrUyMWygVIyb4o=;
 b=NT3EdQRpPt1l6jn1gytXwebRt+Cy4thGC3k4oH5/azoMvsfeITY5ZMZ0d3kzrvQ8ow/O1Z
 JErEVaqXJtt2v5H+WYyRBkWC5jl0aya7H7RZP6v2DwsiPpewxb5k6h2c1P7dnlmrAnERKb
 E8uPvEhriU6qePd02u0UpKBIg49yLWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-ljk2woTON6Cq3_z4PWqXmA-1; Tue,
 05 May 2026 08:35:06 -0400
X-MC-Unique: ljk2woTON6Cq3_z4PWqXmA-1
X-Mimecast-MFC-AGG-ID: ljk2woTON6Cq3_z4PWqXmA_1777984505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B01C1800576
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 12:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158B51944CED
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 12:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69E9621E6A01; Tue, 05 May 2026 14:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/4] Monitor patches for 2026-05-05
Date: Tue,  5 May 2026 14:34:58 +0200
Message-ID: <20260505123502.1316554-1-armbru@redhat.com>
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

  https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05

for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37ac:

  monitor: Add `clear` command (2026-05-05 13:53:03 +0200)

----------------------------------------------------------------
Monitor patches for 2026-05-05

----------------------------------------------------------------
AlanoSong@163.com (1):
      monitor: Add `clear` command

Dr. David Alan Gilbert (3):
      hmp*hx: Move info docs
      hxtool: Split srst/erst add checks
      hxtool: Error on missing docs

 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 hmp-commands-info.hx  |  9 +--------
 hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
 scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 80 insertions(+), 21 deletions(-)

-- 
2.54.0


