Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45797C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UYD-0004sF-3c; Tue, 01 Sep 2026 15:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UYB-0004rq-Bq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UY9-0004Jo-HM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788292419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6rKpy3+5OqVmQEnx4MsznxfBDa64s62VfjKsPXXppcw=;
 b=Q6RQQxuLWYK3svCyMqyJkLyc3I7U98mCENQlVnVRc8SuSHy9iGIB0DNqMHgMtJ41GLz6a/
 knklEthGxVzOYEv8ygjQBdp6NP6qG3vBSV+o7RmLQFEkyh8v70QLpweIBjxxGUJ97qF3Jo
 zMXiCaQYJE8hceQRu8yE5m9/BwWEQuU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-KbzMRizXPv6gRNd8YnkOLg-1; Tue,
 01 Sept 2026 15:53:38 -0400
X-MC-Unique: KbzMRizXPv6gRNd8YnkOLg-1
X-Mimecast-MFC-AGG-ID: KbzMRizXPv6gRNd8YnkOLg_1788292417
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F264F19541AA
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2026 19:53:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20B6D30001A2; Tue,  1 Sep 2026 19:53:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
Date: Tue,  1 Sep 2026 15:53:34 -0400
Message-ID: <20260901195334.463267-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I was unable to get in touch with Stefan and I am not currently sure
if this module is maintained or not. To prevent an avalanche of
bounced emails, remove his contact information.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0ee348c4e..69803afe995 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3839,8 +3839,7 @@ S: Maintained
 F: scripts/simpletrace.py
 
 TPM
-M: Stefan Berger <stefanb@linux.ibm.com>
-S: Maintained
+S: Orphan
 F: system/tpm*
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
@@ -3849,7 +3848,6 @@ F: qapi/tpm.json
 F: backends/tpm/
 F: tests/qtest/*tpm*
 F: docs/specs/tpm.rst
-T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
 SPDM, PCIe DOE
 M: Alistair Francis <alistair.francis@wdc.com>
-- 
2.55.0


