Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C7C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23GS-0007Mz-48; Tue, 08 Apr 2025 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fp-0007DI-2r
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fk-0001Yl-Eb
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCokgCtdCSnKMwZ2vqwV6LFA5eyIRyN3DJwSie4RNi8=;
 b=NnIewAJReKqFnNvBw+K5KS1XYaMPIaH2LhI097jCncZ1w1oSv0zP+q8DyEX5ssa5LavT1G
 LUi/axiSe4LHkLkwaN1KJzMZLvMD+6CTnEm84aHypLkK828Yjt4grXlXy130h7RkVc/oEp
 tpOk5QIxFFL4Yd4WeKsdsZB+a+Jg+Ac=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-3DDjnS99P22Die8MUunhkg-1; Tue,
 08 Apr 2025 03:20:06 -0400
X-MC-Unique: 3DDjnS99P22Die8MUunhkg-1
X-Mimecast-MFC-AGG-ID: 3DDjnS99P22Die8MUunhkg_1744096805
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D0419560B6
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492F219560AD
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0005921E65DA; Tue, 08 Apr 2025 09:20:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 04/11] docs/interop: Sanitize QMP reference manuals TOC
Date: Tue,  8 Apr 2025 09:19:54 +0200
Message-ID: <20250408072001.2518323-5-armbru@redhat.com>
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

The "QEMU QMP Reference Manual" and the "QEMU Storage Daemon QMP
Reference Manual" start with a table of contents that looks like this:

    Contents

    * Title of the manual
      * Title of first first-level section
        * Title of its first second-level section
        * Title of its second second-level section
        ...
      * Title of second first-level section
      ...

The first level is useless.  Drop it.

While there, delete the option that limits the TOC to depth 3.  Its
actual depth was 3 before the patch, and is now 2.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250404121413.1743790-5-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qemu-qmp-ref.rst                | 2 +-
 docs/interop/qemu-storage-daemon-qmp-ref.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index ef8792b53f..3bc1ca12b1 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -4,7 +4,7 @@ QEMU QMP Reference Manual
 =========================
 
 .. contents::
-   :depth: 3
+   :local:
 
 .. qapi-doc:: qapi/qapi-schema.json
    :transmogrify:
diff --git a/docs/interop/qemu-storage-daemon-qmp-ref.rst b/docs/interop/qemu-storage-daemon-qmp-ref.rst
index d0228d63b8..dc7bde262a 100644
--- a/docs/interop/qemu-storage-daemon-qmp-ref.rst
+++ b/docs/interop/qemu-storage-daemon-qmp-ref.rst
@@ -2,7 +2,7 @@ QEMU Storage Daemon QMP Reference Manual
 ========================================
 
 .. contents::
-   :depth: 3
+   :local:
 
 .. qapi-doc:: storage-daemon/qapi/qapi-schema.json
    :transmogrify:
-- 
2.48.1


