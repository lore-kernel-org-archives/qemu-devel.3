Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626C6C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3X-0007h7-6f; Fri, 04 Jul 2025 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3N-0007fm-KU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3M-00007o-01
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJupBfJ20LYtHzmzBW/M1PjMcCcMFvlC5aq9CPTQ+jg=;
 b=PNbdYyd6CQhcXnv0PbY+cE4Yx03u0SBZYs2l8Qno2VSCc+5/bBN43lEYGJfYq4T6uwwX9B
 FrXFBJftSt9q5L2ES3jp79cstGCKxyCvHRX4Syiv44iEXxFg1uwvhY4aBDERQr3lC+y+M8
 ZVipcXGZTVHf5LHWVLtrAOf/n7sjQro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-zEDr_iL1MVGti1rQGhDUhg-1; Fri,
 04 Jul 2025 04:45:48 -0400
X-MC-Unique: zEDr_iL1MVGti1rQGhDUhg-1
X-Mimecast-MFC-AGG-ID: zEDr_iL1MVGti1rQGhDUhg_1751618747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E3BE180034E; Fri,  4 Jul 2025 08:45:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F0A419560A7; Fri,  4 Jul 2025 08:45:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 05/27] b4: Drop linktrailermask
Date: Fri,  4 Jul 2025 10:45:06 +0200
Message-ID: <20250704084528.1412959-6-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When grabbing a patch series, the link trailer is replaced with a
Message-ID, which is not useful compared to an URL. Fix that by
dropping the linktrailermask config.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Fixes: 838cf72b5d2c ("Add a b4 configuration file")
Link: https://lore.kernel.org/qemu-devel/20250630172301.519848-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .b4-config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.b4-config b/.b4-config
index 4b9b2fe290f92f784cd3229616e2cbf0e8550e02..126f503ded743473a3218bcbedf0721942b58585 100644
--- a/.b4-config
+++ b/.b4-config
@@ -11,4 +11,3 @@
     prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
     searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
     linkmask = https://lore.kernel.org/qemu-devel/%s
-    linktrailermask = Message-ID: <%s>
-- 
2.50.0


