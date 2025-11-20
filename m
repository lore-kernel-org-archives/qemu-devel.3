Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E5CCF649C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLtoM-0007vE-Oi; Wed, 19 Nov 2025 20:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1vLtoF-0007tW-12
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1vLtoC-0004pG-2S
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763603402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6adCIe9skg9CXAcWIM0LAxJDuLCJHFR+Xa2JTU7UExQ=;
 b=h2EMpglS6PFHoRc8FFZvVm7b0KpmCytRZTdtaU2rOdRMCwDuoUUnZ1VHxhYNuBMhyWux20
 mftd0WLCBT/wwukB4nxe1YhRF/VNEIpulhvov8stDJrScLB/yNqoMzojLwVuWEPlyw4UtW
 EQMrnTiC+Skh2FQvX3s3qjQm3XiJmug=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-F66yVNXMOT6279JDenCGnA-1; Wed,
 19 Nov 2025 20:50:00 -0500
X-MC-Unique: F66yVNXMOT6279JDenCGnA-1
X-Mimecast-MFC-AGG-ID: F66yVNXMOT6279JDenCGnA_1763603400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB9DA180049F
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 01:49:59 +0000 (UTC)
Received: from nanliu-thinkpadp16vgen1.raycom.csb (unknown [10.72.116.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D6B19560B0; Thu, 20 Nov 2025 01:49:57 +0000 (UTC)
From: nanliu <nanliu@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	nanliu <nanliu@redhat.com>
Subject: [PATCH] docs/system: Clarify local filename escaping in device URLs
Date: Thu, 20 Nov 2025 09:49:36 +0800
Message-ID: <20251120014936.414413-1-nanliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=nanliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The documentation currently lacks explicit information on how to escape
a local filename if it contains characters that cause it to be parsed
as a protocol (e.g., containing a ':').

Use two methods to avoid this:
1. use the explicit prefix ``file:`` (e.g. ``-cdrom file:foo:bar.iso``).
2. use a path with ``./`` in it (e.g. ``-cdrom ./foo:bar.iso``)

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3072

Signed-off-by: nanliu <nanliu@redhat.com>
---
 docs/system/device-url-syntax.rst.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 43b5c2596b..e7aa2be721 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -43,6 +43,14 @@ These are specified using a special URL syntax.
       LIBISCSI_CHAP_PASSWORD="password" \\
       |qemu_system| -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
 
+   Note on path parsing: If a local filename used with a device
+   option (e.g., ``-cdrom``) contains a colon (``:``), QEMU may
+   interpret it as a URL protocol; use the explicit prefix ``file:``
+   (e.g. ``-cdrom file:foo:bar.iso``) or a path with ``./`` in it
+   (e.g. ``-cdrom ./foo:bar.iso``) to ensure correct local file
+   resolution, and avoid using ``file://`` which may lead to
+   incorrect path resolution.
+
 ``NBD``
    QEMU supports NBD (Network Block Devices) both using TCP protocol as
    well as Unix Domain Sockets. With TCP, the default port is 10809.
-- 
2.51.1


