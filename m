Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F7EB48E6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSP5-0002Dr-DU; Thu, 12 Feb 2026 03:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSP1-00020I-67
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOz-0001bN-E3
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqdDXNaeqeryB4xkdT9NDKEckIvbzE9szTH2oYYLCcw=;
 b=M3K5Fe00VUNaZczYRvXuqv9x9C8gGcZY3nXRowvDr71LPLs0yjmYIxylm+PPh2GqmHWoHb
 mxB3grQuh152407iQL81Q6xgQ4UGLzUVML3lX5nt377G005KFpIs7flRFnsGifaCbLgMo8
 eJ3vPDdjtkVIQfzMjqpP5WeWfnBlpSc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-n_vBAfQSORedRp675Ek-mw-1; Thu,
 12 Feb 2026 03:50:16 -0500
X-MC-Unique: n_vBAfQSORedRp675Ek-mw-1
X-Mimecast-MFC-AGG-ID: n_vBAfQSORedRp675Ek-mw_1770886216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D60011800464; Thu, 12 Feb 2026 08:50:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C62AB3000225; Thu, 12 Feb 2026 08:50:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Choon Keong <ckeong.teo17@gmail.com>
Subject: [PULL 14/14] hw/i386/pc.c: add description for fd-bootchk option
Date: Thu, 12 Feb 2026 09:49:27 +0100
Message-ID: <20260212084927.258642-15-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Choon Keong <ckeong.teo17@gmail.com>

The 'fd-bootchk' option for pc and q35 machines currently lacks of
description in the help output. This makes it difficult for users
to understand the purpose of the command.

This commit solve this issue by adding description using
object_class_property_set_description() in hw/i386/pc.c,
adding the the description message for the option 'fd-bootchk'.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3193
Signed-off-by: Choon Keong <ckeong.teo17@gmail.com>
Message-ID: <20260211162909.6550-1-ckeong.teo17@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cb074c0a08..46877197662 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1822,6 +1822,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+    object_class_property_set_description(oc, "fd-bootchk",
+        "Enable/disable boot signature checking for floppy disks in BIOS");
 
 #if defined(CONFIG_IGVM)
     object_class_property_add_link(oc, "igvm-cfg",
-- 
2.53.0


