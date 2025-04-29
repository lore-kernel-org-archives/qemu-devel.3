Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B264C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mmW-0002ha-Sd; Tue, 29 Apr 2025 11:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mmU-0002fD-Iq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mmS-00047X-UT
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745940116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXD5RptCFN/NmwHF4nX2NRG+LM4wk3ZKg95X7FdtS+s=;
 b=fiL5IhE3x+1QoAUF0diIuMTezob+/W27KmWar+II14GAjaKsbQDid8GDbiIE0QdGIL1xXe
 rh7Lh9oQZSmQbZgPNK1g4ur86qlhgmo7+z6xZYRlWCV9q4P9B6QvZtH08smvwVXa44v/ap
 ya+wL7Oa9Vsh6P0yAemXZEOHsYUe5xA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-QYYpDQuDPOKOQNAFesQmrQ-1; Tue,
 29 Apr 2025 11:21:54 -0400
X-MC-Unique: QYYpDQuDPOKOQNAFesQmrQ-1
X-Mimecast-MFC-AGG-ID: QYYpDQuDPOKOQNAFesQmrQ_1745940113
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AE9C1956089; Tue, 29 Apr 2025 15:21:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.241])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A0B31800362; Tue, 29 Apr 2025 15:21:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 2/4] scripts/vmstate-static-checker.py: Allow new name for
 ghes_addr_le field
Date: Tue, 29 Apr 2025 17:21:39 +0200
Message-ID: <20250429152141.294380-3-thuth@redhat.com>
In-Reply-To: <20250429152141.294380-1-thuth@redhat.com>
References: <20250429152141.294380-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

From: Thomas Huth <thuth@redhat.com>

ghes_addr_le has been renamed to hw_error_le in commit 652f6d86cbb
("acpi/ghes: better name the offset of the hardware error firmware").
Adjust the checker script to allow that changed field name.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/vmstate-static-checker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 9c0e6b81f21..25aca839a03 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -42,6 +42,7 @@ def check_fields_match(name, s_field, d_field):
     # Some fields changed names between qemu versions.  This list
     # is used to allow such changes in each section / description.
     changed_names = {
+        'acpi-ghes': ['ghes_addr_le', 'hw_error_le'],
         'apic': ['timer', 'timer_expiry'],
         'e1000': ['dev', 'parent_obj'],
         'ehci': ['dev', 'pcidev'],
-- 
2.49.0


