Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1920C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFjx-0005ya-7B; Wed, 28 May 2025 08:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFji-0005xO-Pj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFjg-0004G5-Jt
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748434698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNuSBB0XraEWSQxV+ug97HcFpXcJ0HipQ+tXza15LqA=;
 b=DBM4eLWl38GPZwAu8Esc2RkFxEY1gM5kYYl91VybDPYVOP0dCiWYkB7oFHy3Ey2XR10UYG
 D4PTS0G0QAXgycMaUIMnhOq803ptoPUPo3KZGCBNX2tDxbDpI8FY2N3k443tbcS93VJK8U
 skiHd88azkN2Fu9BUXyly03bDvmS8gs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-uLVWvuzeP7Ctfn4nkOHGnA-1; Wed,
 28 May 2025 08:18:16 -0400
X-MC-Unique: uLVWvuzeP7Ctfn4nkOHGnA-1
X-Mimecast-MFC-AGG-ID: uLVWvuzeP7Ctfn4nkOHGnA_1748434696
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BD691800263
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:18:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D58180047F
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:18:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E419521E66BC; Wed, 28 May 2025 14:11:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 3/4] docs/about/deprecated: Move deprecation notes to tidy up
 order
Date: Wed, 28 May 2025 14:11:42 +0200
Message-ID: <20250528121143.2208075-4-armbru@redhat.com>
In-Reply-To: <20250528121143.2208075-1-armbru@redhat.com>
References: <20250528121143.2208075-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

The deprecation notes within a section are mostly in version order.
Move the few that aren't so they are.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250521063711.29840-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/about/deprecated.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ef4ea84e69..4715d1ede5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,6 +148,14 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``query-migrationthreads`` (since 9.2)
+''''''''''''''''''''''''''''''''''''''
+
+To be removed with no replacement, as it reports only a limited set of
+threads (for example, it only reports source side of multifd threads,
+without reporting any destination threads, or non-multifd source threads).
+For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
+
 ``block-job-pause`` (since 10.1)
 ''''''''''''''''''''''''''''''''
 
@@ -184,14 +192,6 @@ Use ``job-finalize`` instead.
 
 This argument has always been ignored.
 
-``query-migrationthreads`` (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-To be removed with no replacement, as it reports only a limited set of
-threads (for example, it only reports source side of multifd threads,
-without reporting any destination threads, or non-multifd source threads).
-For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
-
 Host Architectures
 ------------------
 
@@ -522,14 +522,6 @@ PCIe passthrough shall be the mainline solution.
 CPU device properties
 '''''''''''''''''''''
 
-``pcommit`` on x86 (since 9.1)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The PCOMMIT instruction was never included in any physical processor.
-It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
-only with ``-cpu max`` (which does not guarantee migration compatibility
-across versions).
-
 ``pmu-num=n`` on RISC-V CPUs (since 8.2)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -539,6 +531,14 @@ be calculated with ``((2 ^ n) - 1) << 3``. The least significant three bits
 must be left clear.
 
 
+``pcommit`` on x86 (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The PCOMMIT instruction was never included in any physical processor.
+It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
+only with ``-cpu max`` (which does not guarantee migration compatibility
+across versions).
+
 Backwards compatibility
 -----------------------
 
-- 
2.48.1


