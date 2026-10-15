Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1C0CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKUG-00089W-PP; Thu, 15 Oct 2026 08:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTk-0006TJ-Pi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTh-0005fK-1U
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+pCCnEgPhvPJWxC46aYdxnrRJxhBOMIDhPY1Ys9Vx0=;
 b=YxkS5gmE1YnHUhsD6EBeGr3+Fxa275mP+uvRnPMHRYAY4a9m2i2nKbDJaxNV9VfMPtDnBF
 zD7a6n8+gcpHGHFAIHfcq/7PInrCOjOCC+qLFUDpyifzHqGGza738pPSICuu29xd+P+4p4
 Q+e/Dp3K4vhGXc/RsxhGhOOBZ530jg0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-neM_GwiTOBSi3Pqf3MxiKg-1; Thu,
 15 Oct 2026 12:22:30 +0000
X-MC-Unique: neM_GwiTOBSi3Pqf3MxiKg-1
X-Mimecast-MFC-AGG-ID: neM_GwiTOBSi3Pqf3MxiKg_1792066950
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36BD1800BCC; Thu, 15 Oct 2026 12:22:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 469707D9; Thu, 15 Oct 2026 12:22:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 17/21] hw/arm/aspeed_coprocessor: Remove unused unimplemented
 device fields
Date: Thu, 15 Oct 2026 14:21:47 +0200
Message-ID: <20261015122151.889017-18-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AST2700 SSP and TSP now use the unimp_devs table and
create_unimplemented_devices() for their unimplemented devices. Remove
the old "ipc", "pric" and "otp" fields in Aspeed27x0CoprocessorState
and the "timerctrl" field in AspeedCoprocessorState, which are not used
anymore.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 39209d2579f7..b0d72f916383 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {
     MemoryRegion uart_alias;
     Clock *sysclk;
 
-    AspeedTimerCtrlState timerctrl;
     SerialMM *uart;
     int uart_dev;
 };
@@ -44,9 +43,6 @@ struct AspeedCoprocessorClass {
 struct Aspeed27x0CoprocessorState {
     AspeedCoprocessorState parent;
     AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState pric[2];
-    UnimplementedDeviceState otp;
 
     ARMv7MState armv7m;
 
-- 
2.56.0


