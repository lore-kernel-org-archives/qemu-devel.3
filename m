Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8502DCA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYZH-0005QN-S6; Mon, 25 Aug 2025 10:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYZ9-0005Nt-VL
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqYZ6-0003xr-SL
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756133575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTU3PtkS0EZAw8enzY+8i+AJSlBDuS9lUlQPowU+ChA=;
 b=D/GQkQQnU5vEVZV9i0uLPXhVem29gGOc80z2zGAH/9bowmT6lpLQ90Je8DKwwbEg26DNx8
 ouvlv5caEI4u9dLZkAKI/chaz7cUTOCAqc52aG/qDM0nvCnDGpBhJyOh/HaCac+Kwv0KTf
 MzPku0keBnGbtcDn38SaiAoXJ3z0RX8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-XDdUT057PbCWRKS4sJ3LJw-1; Mon,
 25 Aug 2025 10:52:52 -0400
X-MC-Unique: XDdUT057PbCWRKS4sJ3LJw-1
X-Mimecast-MFC-AGG-ID: XDdUT057PbCWRKS4sJ3LJw_1756133571
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 042B919560B1; Mon, 25 Aug 2025 14:52:51 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75D5919560AB; Mon, 25 Aug 2025 14:52:49 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 2/2] qga-vss: Remove unused dependencies
Date: Mon, 25 Aug 2025 17:52:41 +0300
Message-ID: <20250825145241.170717-3-kkostiuk@redhat.com>
In-Reply-To: <20250825145241.170717-1-kkostiuk@redhat.com>
References: <20250825145241.170717-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 0ac918910b..a6b810f12a 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -13,13 +13,11 @@ qga_vss = shared_module(
   link_args: link_args,
   vs_module_defs: 'qga-vss.def',
   dependencies: [
-    glib,
     socket,
     cc.find_library('ole32'),
     cc.find_library('oleaut32'),
     cc.find_library('shlwapi'),
-    cc.find_library('uuid'),
-    cc.find_library('intl')
+    cc.find_library('uuid')
   ]
 )
 
-- 
2.50.1


