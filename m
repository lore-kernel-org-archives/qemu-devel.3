Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6384109C038
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5fMo-0001Kl-Ds; Thu, 26 Mar 2026 03:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMn-0001KO-Fe
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5fMl-0003OO-SY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774510975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1mwljVK1D6GcfyWNch6EEXcYWHmKTjvQ9fIcqs5RxY=;
 b=ODCw3mhHE09L1KngftL03OvhLutSMdQIyhgQs55R8lVli3bXKz7zvb9IeCMnDrv5NhpAR/
 ejmD31wTdrHLipAv4hz1JB6rzSpShbt5QVY350XI6sV+i0tUyo4kP1aUrNY8SfsaTnkgP7
 vUOGKBEVyO/VEKrzxQJF22gk+waJC9c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-9rOfpeLsMj-m49V7xw9XSA-1; Thu,
 26 Mar 2026 03:42:51 -0400
X-MC-Unique: 9rOfpeLsMj-m49V7xw9XSA-1
X-Mimecast-MFC-AGG-ID: 9rOfpeLsMj-m49V7xw9XSA_1774510970
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A9919560B6; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800C01800673; Thu, 26 Mar 2026 07:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E468321E66CB; Thu, 26 Mar 2026 08:42:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 3/3] migration: Tweak description of migration property
 multifd-compression
Date: Thu, 26 Mar 2026 08:42:47 +0100
Message-ID: <20260326074247.188674-4-armbru@redhat.com>
In-Reply-To: <20260326074247.188674-1-armbru@redhat.com>
References: <20260326074247.188674-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Help for the migration pseudo-device shows property
"multifd-compression" like this:

  multifd-compression=<MultiFDCompression> - multifd_compression values (none/zlib/zstd/qpl/uadk/qatzip) (default: none)

Change it to

  multifd-compression=<MultiFDCompression> - multifd compression method (none/zlib/zstd/qpl/uadk/qatzip) (default: none)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a805ee2e1f..5bfdfe1ab9 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -681,7 +681,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 
 const PropertyInfo qdev_prop_multifd_compression = {
     .type = "MultiFDCompression",
-    .description = "multifd_compression values"
+    .description = "multifd compression method"
                    " (none/zlib/zstd/qpl/uadk/qatzip)",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
-- 
2.53.0


