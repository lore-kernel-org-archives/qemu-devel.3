Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54437C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0r8-0003gV-IE; Wed, 02 Jul 2025 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qs-0003ek-9C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0ql-0003Yn-9h
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTcoaEsLzXUXHcMJjyLrsF8zQKMNSpUMpK0Z1hQhJyk=;
 b=fOSI3g1I+0ONwqDpoUvBPBucazqxQnedkRxsTp4o8tkYCv0mqhWYBUT76LKClO8liDdZZC
 0qHYBSA/WRiJIRnK0MbcGt0oIKOEFcyrt3HP/BZnvgD94peMhVBmmaZ+Es2UyHViVPu23p
 O27LX4nFjZOsrGz//eYyTUa6Wsazfo8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-cI8peRmfMgGd9_MxUxVx3g-1; Wed,
 02 Jul 2025 13:02:20 -0400
X-MC-Unique: cI8peRmfMgGd9_MxUxVx3g-1
X-Mimecast-MFC-AGG-ID: cI8peRmfMgGd9_MxUxVx3g_1751475739
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E99190D170; Wed,  2 Jul 2025 17:02:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B80A1195608F; Wed,  2 Jul 2025 17:02:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 1/9] MAINTAINERS: update docs file extensions (.txt -> .rst)
Date: Wed,  2 Jul 2025 19:01:56 +0200
Message-ID: <20250702170206.212303-2-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sean Wei <me@sean.taipei>

The documentation tree has been converted to reStructuredText, but
two entries in MAINTAINERS still point to the removed *.txt files.

This prevents scripts/get_maintainer.pl from matching the documents.

Update those entries to *.rst so the maintainer script works again.

Related commits:
  8472cc5dbe6 (Sep 2023): docs/specs/vmw_pvscsi-spec: Convert to rST
  8e72ceee5cd (Jun 2022): Rename docs/specs/fw_cfg.txt to .rst

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <20250616.qemu.relocated.01@sean.taipei>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7128e0bc98e..749799b0f84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2541,7 +2541,7 @@ F: hw/net/net_tx_pkt*
 Vmware
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
 S: Maintained
-F: docs/specs/vmw_pvscsi-spec.txt
+F: docs/specs/vmw_pvscsi-spec.rst
 F: hw/display/vmware_vga.c
 F: hw/net/vmxnet*
 F: hw/scsi/vmw_pvscsi*
@@ -2746,7 +2746,7 @@ Firmware configuration (fw_cfg)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
-F: docs/specs/fw_cfg.txt
+F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
-- 
2.50.0


