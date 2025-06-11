Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB06C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL2y-0003Ld-NY; Wed, 11 Jun 2025 08:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2l-0003J8-46
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPL2j-0004NB-3O
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749646739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DaQPeOTGsopw4+xA5vbwo50sUhSL9MBD7zUxFIsibM=;
 b=DrpfRkU7SS7uKq1Btx3SA0fzNefBHMUht3xHwVxi4P09pZJTnrJDHGcgvjf8wbQ/7dCsVC
 od1hCXziUHHdOnVwPv4b8WTBZZSMENf4ytf33oR/jIuhM4aEix1rr7Bz1z5H633wP+vSMs
 FmVjwAjDji7nIpHSJAm6/Dhzct/MyHA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-D0S-ihJwPj-3vlX3TGuMlw-1; Wed,
 11 Jun 2025 08:58:57 -0400
X-MC-Unique: D0S-ihJwPj-3vlX3TGuMlw-1
X-Mimecast-MFC-AGG-ID: D0S-ihJwPj-3vlX3TGuMlw_1749646737
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA876180AE02
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 12:58:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D2F119560A3; Wed, 11 Jun 2025 12:58:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 02/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 4.1
 machine type
Date: Wed, 11 Jun 2025 14:58:38 +0200
Message-ID: <20250611125846.125918-3-thuth@redhat.com>
In-Reply-To: <20250611125846.125918-1-thuth@redhat.com>
References: <20250611125846.125918-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

With the upcoming release of QEMU 10.1, the s390-ccw-virtio-4.1 machine
will be older than 6 years, so according to our machine support policy,
it can be removed now. The V4_1 CPU feature group gets merged into the
minimum CPU feature group now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250519054744.36715-1-thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 14 --------------
 target/s390x/gen-features.c |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f69a4d8ed31..ce3c13defb5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1145,20 +1145,6 @@ static void ccw_machine_4_2_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(4, 2);
 
-static void ccw_machine_4_1_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V4_1 };
-    ccw_machine_4_2_instance_options(machine);
-    s390_set_qemu_cpu_model(0x2964, 13, 2, qemu_cpu_feat);
-}
-
-static void ccw_machine_4_1_class_options(MachineClass *mc)
-{
-    ccw_machine_4_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-}
-DEFINE_CCW_MACHINE(4, 1);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a814ece82f2..8218e6470ec 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -884,9 +884,6 @@ static uint16_t qemu_MIN[] = {
      */
     S390_FEAT_FLOATING_POINT_EXT,
     S390_FEAT_ZPCI,
-};
-
-static uint16_t qemu_V4_1[] = {
     S390_FEAT_STFLE_53,
     S390_FEAT_VECTOR,
 };
@@ -1049,7 +1046,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
     QEMU_FEAT_INITIALIZER(MIN),
-    QEMU_FEAT_INITIALIZER(V4_1),
     QEMU_FEAT_INITIALIZER(V6_0),
     QEMU_FEAT_INITIALIZER(V6_2),
     QEMU_FEAT_INITIALIZER(V7_0),
-- 
2.49.0


