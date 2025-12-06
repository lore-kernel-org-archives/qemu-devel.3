Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43575D3ABF4
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 09:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRoh0-0003gM-1L; Sat, 06 Dec 2025 04:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ybendito@redhat.com>)
 id 1vRogy-0003fw-Qd
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 04:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ybendito@redhat.com>)
 id 1vRogx-0004fw-DB
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765013702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q2cXg4wg38MDGOuxaW+D4kSIGAhUDyQ4r5dqTCOgpMw=;
 b=D50JVJVv2lyE667DlcsbfC+Sou5mKVjri0xEczP+MPDjU4lQxUNhxp/WYbAJngbwSzrxAO
 WV1DSBQIW1Hp0ZPIoSQA9OIV653908BQ/GOIVKsysjGt/exBeeW60e0O75niUuMRSeNoJY
 wGDclAcsvJaRtkUziDGgKpaWp6t9htg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-BNoMtl_hOVS2m4ptG1QrVA-1; Sat,
 06 Dec 2025 04:33:50 -0500
X-MC-Unique: BNoMtl_hOVS2m4ptG1QrVA-1
X-Mimecast-MFC-AGG-ID: BNoMtl_hOVS2m4ptG1QrVA_1765013629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B31BB1800342
 for <qemu-devel@nongnu.org>; Sat,  6 Dec 2025 09:33:49 +0000 (UTC)
Received: from rhel9.redhat.com (unknown [10.47.238.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FC6C1953986; Sat,  6 Dec 2025 09:33:48 +0000 (UTC)
From: ybendito@redhat.com
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com
Subject: [PATCH] MAINTAINERS: update ebpf reviewers
Date: Sat,  6 Dec 2025 11:33:45 +0200
Message-ID: <20251206093345.71031-1-ybendito@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ybendito@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yuri Benditovich <ybendito@redhat.com>

Signed-off-by: Yuri Benditovich <ybendito@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..1a4a698d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4385,8 +4385,7 @@ F: tests/functional/x86_64/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
-R: Andrew Melnychenko <andrew@daynix.com>
-R: Yuri Benditovich <yuri.benditovich@daynix.com>
+R: Yuri Benditovich <ybendito@redhat.com>
 S: Maintained
 F: docs/devel/ebpf_rss.rst
 F: ebpf/*
-- 
2.43.5


