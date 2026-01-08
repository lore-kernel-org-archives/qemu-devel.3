Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533BED1D486
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 18:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdv5Y-00032M-HK; Thu, 08 Jan 2026 13:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vdv5W-00031Y-Uq
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vdv5U-0006NQ-SH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 13:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767898221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lP7ihcr6aZ3utvZ9KKYMZlEgraKclEcRb2YSlpfSS9M=;
 b=VONFqIQYOXeUIk5//t8Z2JrjpgO3y84Xo5RrtEsHO6mSiK50Kmw2H3DbpfLAMlUiuUFlbi
 xR6FySQymdUVZlLOhCDQ65xkVR0BtenR1QiIGFUaMXbkCBxwpjWu6QJ/33w78um2shvRN4
 kdjEmi0qSm9IDZUOdnGuNT8ArbQclhQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423--uBx2xNrOZaFgQLm6uX74g-1; Thu,
 08 Jan 2026 13:50:18 -0500
X-MC-Unique: -uBx2xNrOZaFgQLm6uX74g-1
X-Mimecast-MFC-AGG-ID: -uBx2xNrOZaFgQLm6uX74g_1767898217
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273A3195609F; Thu,  8 Jan 2026 18:50:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.61])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 017531801A46; Thu,  8 Jan 2026 18:50:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] include/hw/hyperv: Remove unused 'struct mshv_vp_registers'
 definition
Date: Thu,  8 Jan 2026 19:50:12 +0100
Message-ID: <20260108185012.2568277-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

The 'struct mshv_vp_registers' definition in hvgdk_mini.h is unused in
QEMU and conflicts with the canonical definition in
linux-headers/linux/mshv.h.

Remove the duplicate definition to avoid build conflicts when the Linux
headers are updated.

Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index d89315f5452fd565469bbfc98cacb226b71da13f..cb52cc9de283bbe4201357127c2eb1b0b37e4cab 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -450,13 +450,6 @@ typedef struct hv_input_set_vp_registers {
     struct hv_register_assoc elements[];
 } hv_input_set_vp_registers;
 
-#define MSHV_VP_MAX_REGISTERS   128
-
-struct mshv_vp_registers {
-    int count; /* at most MSHV_VP_MAX_REGISTERS */
-    struct hv_register_assoc *regs;
-};
-
 union hv_interrupt_control {
     uint64_t as_uint64;
     struct {
-- 
2.52.0


