Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E20ACA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnvK-0002eU-8H; Thu, 08 Oct 2026 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvG-0002e4-Bw
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvC-0002Nz-TL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnnQ+x6ke5J4C/UZeNYoriCiAxRaxfgHTzEfrp90foM=;
 b=PfXVn/lP3pGDsHrSO/Wg2gHjBJVCfu7DnvFi3tJZkISk07ilpMDkzE9ADHyN2bOqqFHKsB
 gHnKN7swbm1dRvLN7/SIMFhE4b5wWZk+iSA+TSaSxA5SRfajH6xu7YUFztRJB0yJy7Kji0
 +dQ8nHd4AcnXp9/iDNLAMc4LxYj8Hbo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-tHB4fjqWMLekxP4rSBKTZg-1; Thu,
 08 Oct 2026 09:12:28 -0400
X-MC-Unique: tHB4fjqWMLekxP4rSBKTZg-1
X-Mimecast-MFC-AGG-ID: tHB4fjqWMLekxP4rSBKTZg_1791465147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDA3E1809C9E
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2026 13:12:26 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D5F830001BB; Thu,  8 Oct 2026 13:12:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/15] maint: Update eblake's staging repo
Date: Thu,  8 Oct 2026 08:11:40 -0500
Message-ID: <20261008131216.2437896-18-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

repo.or.cz is struggling with geofencing restrictions and frequent
service degredation from AI bot overloads; time to update my staging
repo to something with a bit more accessibility and uptime.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261007122951.1935165-2-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd8..518f5ee6115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3365,7 +3365,7 @@ F: migration/block-dirty-bitmap.c
 F: util/hbitmap.c
 F: tests/unit/test-hbitmap.c
 F: docs/interop/bitmaps.rst
-T: git https://repo.or.cz/qemu/ericb.git bitmaps
+T: git https://gitlab.com/ebblake/qemu.git bitmaps
 T: git https://gitlab.com/vsementsov/qemu.git block

 Character device backends
@@ -4364,7 +4364,7 @@ F: blockdev-nbd.c
 F: docs/interop/nbd.rst
 F: docs/tools/qemu-nbd.rst
 F: tests/qemu-iotests/tests/*nbd*
-T: git https://repo.or.cz/qemu/ericb.git nbd
+T: git https://gitlab.com/ebblake/qemu.git nbd
 T: git https://gitlab.com/vsementsov/qemu.git block

 NFS
-- 
2.56.0


