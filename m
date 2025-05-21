Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B36C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 06:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHdCw-00084q-NQ; Wed, 21 May 2025 02:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCn-000828-Cy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHdCi-0002uj-1x
 for qemu-devel@nongnu.org; Wed, 21 May 2025 02:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747809926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vt8CiTl/LbfWeCuUs7h2pX+We3luhDHWY/tcqJD6c18=;
 b=RUUK19P4K3ST3e6swApd4iM2wHy3UVUICa08Utpv+NMSqmNBKTVbK2fdcwuJjy+C0GXeJa
 NgeTdVIjKQWu9UdacoV1ScTfnceodiAMiqaO2f93QdgBbEAJpuGsBlLp7DMh6mhkEJsgKa
 3Yme/NO6+FFsVM0HDuzZogFg86VK5Gw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-UraIybdVPYSJ_OCTKB8VQw-1; Wed,
 21 May 2025 02:45:14 -0400
X-MC-Unique: UraIybdVPYSJ_OCTKB8VQw-1
X-Mimecast-MFC-AGG-ID: UraIybdVPYSJ_OCTKB8VQw_1747809913
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E5211800A44; Wed, 21 May 2025 06:45:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFBE119560AD; Wed, 21 May 2025 06:45:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EB5921E65D4; Wed, 21 May 2025 08:37:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org
Subject: [PATCH 3/4] docs/about/deprecated: Move deprecation notes to tidy up
 order
Date: Wed, 21 May 2025 08:37:10 +0200
Message-ID: <20250521063711.29840-4-armbru@redhat.com>
In-Reply-To: <20250521063711.29840-1-armbru@redhat.com>
References: <20250521063711.29840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


