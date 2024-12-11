Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA772E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIba-0007Hi-O7; Wed, 11 Dec 2024 04:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIb3-00069T-4Y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIat-0007ta-Ou
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmmwqMHbohvqNIvYNdGryPTBvMgVYgwQtrkWciaRtzk=;
 b=YFim3pgTkJliWTQqmLsFCD/glcCNC7DKxaQ/pO0C5LFnZuggDo+zBAh7D10qy9P3RWhkS1
 GgyUQ/WOnHosNoK7J3VCgAGjzm9yX7INowCRehRBGKQoYQeJHAy4TgwSeADOuNQJIJtDyI
 ZT7f2dZVEE5rcdR4jZbgBkTvCNDgr3U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-OjWIuJ40NDeXE_-Jwn-M1Q-1; Wed,
 11 Dec 2024 04:01:15 -0500
X-MC-Unique: OjWIuJ40NDeXE_-Jwn-M1Q-1
X-Mimecast-MFC-AGG-ID: OjWIuJ40NDeXE_-Jwn-M1Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21CD21955EB1; Wed, 11 Dec 2024 09:01:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C1961956089; Wed, 11 Dec 2024 09:01:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 16/26] s390x/cpumodel: correct PLO feature wording
Date: Wed, 11 Dec 2024 10:00:00 +0100
Message-ID: <20241211090014.619351-17-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hendrik Brueckner <brueckner@linux.ibm.com>

The PLO functions 0, 4, 8, 12, 16, and 20 use 32-bit registers
values.  The plo-*gr variants use 64-bit instead and, thus, correct
the wording.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-14-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 09a80844a7..fe7e1bd19c 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -158,27 +158,27 @@ DEF_FEAT(AP, "ap", MISC, 0, "AP instructions installed")
 /* Features exposed via the PLO instruction. */
 DEF_FEAT(PLO_CL, "plo-cl", PLO, 0, "PLO Compare and load (32 bit in general registers)")
 DEF_FEAT(PLO_CLG, "plo-clg", PLO, 1, "PLO Compare and load (64 bit in parameter list)")
-DEF_FEAT(PLO_CLGR, "plo-clgr", PLO, 2, "PLO Compare and load (32 bit in general registers)")
+DEF_FEAT(PLO_CLGR, "plo-clgr", PLO, 2, "PLO Compare and load (64 bit in general registers)")
 DEF_FEAT(PLO_CLX, "plo-clx", PLO, 3, "PLO Compare and load (128 bit in parameter list)")
 DEF_FEAT(PLO_CS, "plo-cs", PLO, 4, "PLO Compare and swap (32 bit in general registers)")
 DEF_FEAT(PLO_CSG, "plo-csg", PLO, 5, "PLO Compare and swap (64 bit in parameter list)")
-DEF_FEAT(PLO_CSGR, "plo-csgr", PLO, 6, "PLO Compare and swap (32 bit in general registers)")
+DEF_FEAT(PLO_CSGR, "plo-csgr", PLO, 6, "PLO Compare and swap (64 bit in general registers)")
 DEF_FEAT(PLO_CSX, "plo-csx", PLO, 7, "PLO Compare and swap (128 bit in parameter list)")
 DEF_FEAT(PLO_DCS, "plo-dcs", PLO, 8, "PLO Double compare and swap (32 bit in general registers)")
 DEF_FEAT(PLO_DCSG, "plo-dcsg", PLO, 9, "PLO Double compare and swap (64 bit in parameter list)")
-DEF_FEAT(PLO_DCSGR, "plo-dcsgr", PLO, 10, "PLO Double compare and swap (32 bit in general registers)")
+DEF_FEAT(PLO_DCSGR, "plo-dcsgr", PLO, 10, "PLO Double compare and swap (64 bit in general registers)")
 DEF_FEAT(PLO_DCSX, "plo-dcsx", PLO, 11, "PLO Double compare and swap (128 bit in parameter list)")
 DEF_FEAT(PLO_CSST, "plo-csst", PLO, 12, "PLO Compare and swap and store (32 bit in general registers)")
 DEF_FEAT(PLO_CSSTG, "plo-csstg", PLO, 13, "PLO Compare and swap and store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSSTGR, "plo-csstgr", PLO, 14, "PLO Compare and swap and store (32 bit in general registers)")
+DEF_FEAT(PLO_CSSTGR, "plo-csstgr", PLO, 14, "PLO Compare and swap and store (64 bit in general registers)")
 DEF_FEAT(PLO_CSSTX, "plo-csstx", PLO, 15, "PLO Compare and swap and store (128 bit in parameter list)")
 DEF_FEAT(PLO_CSDST, "plo-csdst", PLO, 16, "PLO Compare and swap and double store (32 bit in general registers)")
 DEF_FEAT(PLO_CSDSTG, "plo-csdstg", PLO, 17, "PLO Compare and swap and double store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSDSTGR, "plo-csdstgr", PLO, 18, "PLO Compare and swap and double store (32 bit in general registers)")
+DEF_FEAT(PLO_CSDSTGR, "plo-csdstgr", PLO, 18, "PLO Compare and swap and double store (64 bit in general registers)")
 DEF_FEAT(PLO_CSDSTX, "plo-csdstx", PLO, 19, "PLO Compare and swap and double store (128 bit in parameter list)")
 DEF_FEAT(PLO_CSTST, "plo-cstst", PLO, 20, "PLO Compare and swap and triple store (32 bit in general registers)")
 DEF_FEAT(PLO_CSTSTG, "plo-cststg", PLO, 21, "PLO Compare and swap and triple store (64 bit in parameter list)")
-DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (32 bit in general registers)")
+DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (64 bit in general registers)")
 DEF_FEAT(PLO_CSTSTX, "plo-cststx", PLO, 23, "PLO Compare and swap and triple store (128 bit in parameter list)")
 
 /* Features exposed via the PTFF instruction. */
-- 
2.47.1


