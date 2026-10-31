Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B82606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ep6OngRw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN34w-00045O-LK; Sat, 31 Oct 2026 03:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33c-00030v-65
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33X-0002pI-UL
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DN+d977M4YromzCylLAH5bSec3UEYbnk9XDI4griFy0=;
 b=ep6OngRw6+r4MsP6buEEQ/PFHH4by47BFpI7I5PH1iWRhIzcvLbrcOFkzqxx+g0O26QrrJ
 fShzRzgjx7+tWkT7BERBG4vRWJ8+10M6kRSZo9jzszKMWWwtAYrnK/WfIN+EftXM3OVJ7K
 tp+p7SxLrs4GzIu110r8bJbZvRY1mRY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-YfmNdr1MOYSR8AtyEVALnA-1; Sat,
 31 Oct 2026 02:59:09 -0400
X-MC-Unique: YfmNdr1MOYSR8AtyEVALnA-1
X-Mimecast-MFC-AGG-ID: YfmNdr1MOYSR8AtyEVALnA_1793429948
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BF21956062; Sat, 31 Oct 2026 06:59:07 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E16911803A40; Sat, 31 Oct 2026 06:59:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/34] hw/misc/aspeed_scu: Add AST1080 A0 silicon revision
 definition
Date: Sat, 31 Oct 2026 07:58:05 +0100
Message-ID: <20261031065823.191966-17-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a new silicon revision constant AST1080_A0_SILICON_REV for the
AST1080 SoC. This allows the SCU model and related SoC layers to
identify and handle AST1080 A0 revision properly in the same way as
other Aspeed SoC families.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015063625.186708-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_scu.h | 1 +
 hw/misc/aspeed_scu.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 6482038f123a..a7014e43f21e 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -52,6 +52,7 @@ struct Aspeed2700SCUState {
 #define AST1030_A1_SILICON_REV   0x80010000U
 #define AST1060_A2_SILICON_REV   0xA0030000U
 #define AST1040_A0_SILICON_REV   0x80000000U
+#define AST1080_A0_SILICON_REV   0xA0000100U
 #define AST2700_A1_SILICON_REV   0x06010103U
 #define AST2700_A2_SILICON_REV   0x06020103U
 
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 77f9af2ae50e..df26dd0ef427 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -572,6 +572,7 @@ static uint32_t aspeed_silicon_revs[] = {
     AST2700_A1_SILICON_REV,
     AST2700_A2_SILICON_REV,
     AST1040_A0_SILICON_REV,
+    AST1080_A0_SILICON_REV,
 };
 
 bool is_supported_silicon_rev(uint32_t silicon_rev)
-- 
2.56.0


