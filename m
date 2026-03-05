Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AABDF47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCy6-0000EF-VV; Thu, 05 Mar 2026 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxI-0007Wu-Gl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxG-0003Yk-T7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZriXSDkdZigDJADNcwGe94lquzgrzOaXXxTMiRK0n8=;
 b=LAHrRsHUzI8fNjpMKNEdcaZxuc/ZpcIGwxLoLrlTI9NRuXjdXyCteme9Ofe+MnLs/pe4gp
 zS3LVFrzvN2kUooHpq9jsuhJGmgyiImvAbGZEXwMlKVCwmSM3Fbm/8ZP8uD78saQEl1t1Y
 mzO+JAehhwzSKfImODp8GPgG6FxDC2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-9uR78Xl6NbuFFEReZs8CYw-1; Thu,
 05 Mar 2026 12:57:39 -0500
X-MC-Unique: 9uR78Xl6NbuFFEReZs8CYw-1
X-Mimecast-MFC-AGG-ID: 9uR78Xl6NbuFFEReZs8CYw_1772733456
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFBDE195608D; Thu,  5 Mar 2026 17:57:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F1DF3003E9E; Thu,  5 Mar 2026 17:57:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/38] hw/i3c/dw-i3c: Add more reset values
Date: Thu,  5 Mar 2026 18:56:41 +0100
Message-ID: <20260305175711.1119025-9-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Adds reset values for the new registers added.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 48dde008decf..28da6016a1ea 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)
 
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
-    [R_HW_CAPABILITY]               = 0x000e00bf,
+    /* Target mode is not supported, don't advertise it for now. */
+    [R_HW_CAPABILITY]               = 0x000e00b9,
     [R_QUEUE_THLD_CTRL]             = 0x01000101,
+    [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
+    [R_SLV_EVENT_CTRL]              = 0x0000000b,
+    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
+    [R_PRESENT_STATE]               = 0x00000003,
     [R_I3C_VER_ID]                  = 0x3130302a,
     [R_I3C_VER_TYPE]                = 0x6c633033,
     [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
     [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
+    [R_SLV_CHAR_CTRL]               = 0x00010000,
     [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
     [R_SLV_MAX_LEN]                 = 0x00ff00ff,
+    [R_SLV_TSX_SYMBL_TIMING]        = 0x0000003f,
+    [R_SCL_I3C_OD_TIMING]           = 0x000a0010,
+    [R_SCL_I3C_PP_TIMING]           = 0x000a000a,
+    [R_SCL_I2C_FM_TIMING]           = 0x00100010,
+    [R_SCL_I2C_FMP_TIMING]          = 0x00100010,
+    [R_SCL_EXT_LCNT_TIMING]         = 0x20202020,
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   = 0x00300000,
+    [R_BUS_FREE_TIMING]             = 0x00200020,
+    [R_BUS_IDLE_TIMING]             = 0x00000020,
+    [R_EXTENDED_CAPABILITY]         = 0x00000239,
+    [R_SLAVE_CONFIG]                = 0x00000023,
 };
 
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
-- 
2.53.0


