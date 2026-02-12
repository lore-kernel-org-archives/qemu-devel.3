Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F174DEEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQA-0008CB-U9; Thu, 12 Feb 2026 16:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ9-0008Ar-BW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQ7-00067W-Mv
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsxntieXxGCUkYSUMbIBq/yDMG4KsTlaZeEQq1+cBUo=;
 b=f2ToVU4PTLHPa3ebZkh8STih+hJ/SIImgMCB5DAgZ6osdU9Ki+CI/+cOgC0ADTG986F9K1
 Ilns8AN80GUKSkk1B4nFEzR7OkPtPTrdoFRPQMIlmA+jf5U/SAkZtmKOSWYCOYQZuFxYNg
 8In/MJHly4ikTHZg880ishRtNEWFQw8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-6maRRSpuOtqfZFTclINqtg-1; Thu,
 12 Feb 2026 16:40:13 -0500
X-MC-Unique: 6maRRSpuOtqfZFTclINqtg-1
X-Mimecast-MFC-AGG-ID: 6maRRSpuOtqfZFTclINqtg_1770932412
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C9E21955D88; Thu, 12 Feb 2026 21:40:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D4181800668; Thu, 12 Feb 2026 21:40:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/16] hw/misc/aspeed_scu: Remove unused SoC silicon revision
 definitions
Date: Thu, 12 Feb 2026 22:39:45 +0100
Message-ID: <20260212213955.2225662-7-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Several legacy Aspeed SoC silicon revision definitions are no longer
used by any machine models or runtime logic.

Remove unused silicon revision macros and corresponding entries from
the silicon revision table to reduce dead code and improve
maintainability.

No functional change intended.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_scu.h | 10 ----------
 hw/misc/aspeed_scu.c         | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 9e28bd4d2e1a..313a79f2f76b 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -41,22 +41,12 @@ struct AspeedSCUState {
     uint32_t hw_prot_key;
 };
 
-#define AST2400_A0_SILICON_REV   0x02000303U
 #define AST2400_A1_SILICON_REV   0x02010303U
-#define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
-#define AST2600_A0_SILICON_REV   0x05000303U
-#define AST2600_A1_SILICON_REV   0x05010303U
-#define AST2600_A2_SILICON_REV   0x05020303U
 #define AST2600_A3_SILICON_REV   0x05030303U
-#define AST1030_A0_SILICON_REV   0x80000000U
 #define AST1030_A1_SILICON_REV   0x80010000U
 #define AST1060_A2_SILICON_REV   0xA0030000U
-#define AST2700_A0_SILICON_REV   0x06000103U
-#define AST2720_A0_SILICON_REV   0x06000203U
-#define AST2750_A0_SILICON_REV   0x06000003U
 #define AST2700_A1_SILICON_REV   0x06010103U
-#define AST2750_A1_SILICON_REV   0x06010003U
 
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
 
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 6829efa2dcd4..0edf9c1b1646 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -555,22 +555,12 @@ static void aspeed_scu_reset(DeviceState *dev)
 }
 
 static uint32_t aspeed_silicon_revs[] = {
-    AST2400_A0_SILICON_REV,
     AST2400_A1_SILICON_REV,
-    AST2500_A0_SILICON_REV,
     AST2500_A1_SILICON_REV,
-    AST2600_A0_SILICON_REV,
-    AST2600_A1_SILICON_REV,
-    AST2600_A2_SILICON_REV,
     AST2600_A3_SILICON_REV,
-    AST1030_A0_SILICON_REV,
     AST1030_A1_SILICON_REV,
     AST1060_A2_SILICON_REV,
-    AST2700_A0_SILICON_REV,
-    AST2720_A0_SILICON_REV,
-    AST2750_A0_SILICON_REV,
     AST2700_A1_SILICON_REV,
-    AST2750_A1_SILICON_REV,
 };
 
 bool is_supported_silicon_rev(uint32_t silicon_rev)
-- 
2.53.0


