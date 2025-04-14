Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F60C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4JtI-0008VF-Ar; Mon, 14 Apr 2025 09:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4JsW-0008Cs-H5
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4JsS-0005I5-8b
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744637371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4tKVdxWEdTDAPlaY/QuniG4/A/ZTMHNq8UPwtvqjkM=;
 b=GNHyDBfe5I0biZmukNCb4mHn0KxA4srX6WCCun0K0hRQlAUFdUIcfHhgJA+EkuFCzyS9ez
 UxvRdz6igVn4w7KJCLaQ/tr0n/jSUVK48zXOFYVn9lGQvXlit4fA1Ef0MAtWHVC0DNs/Qe
 hUrvfDfkcI8aoNvERep+lIQ6ZnHAnp4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-W1Q7__H_PX-MtAtORoBVhA-1; Mon,
 14 Apr 2025 09:29:27 -0400
X-MC-Unique: W1Q7__H_PX-MtAtORoBVhA-1
X-Mimecast-MFC-AGG-ID: W1Q7__H_PX-MtAtORoBVhA_1744637366
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 054AB1800349; Mon, 14 Apr 2025 13:29:26 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FCE319560AD; Mon, 14 Apr 2025 13:29:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 3/4] hw/s390x/s390-virtio-ccw: Remove the deprecated 3.1
 machine type
Date: Mon, 14 Apr 2025 15:29:13 +0200
Message-ID: <20250414132914.250423-4-thuth@redhat.com>
In-Reply-To: <20250414132914.250423-1-thuth@redhat.com>
References: <20250414132914.250423-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The s390-ccw-virtio-3.1 machine is older than 6 years, so according to
our machine support policy, it can be removed now. The corresponding
v3.1 CPU feature group can now be removed, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 16 ----------------
 target/s390x/gen-features.c | 33 ---------------------------------
 2 files changed, 49 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a4fe1e47150..3e346749a06 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1155,22 +1155,6 @@ static void ccw_machine_4_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(4, 0);
 
-static void ccw_machine_3_1_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V3_1 };
-    ccw_machine_4_0_instance_options(machine);
-    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
-    s390_cpudef_group_featoff_greater(14, 1, S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF);
-    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
-}
-
-static void ccw_machine_3_1_class_options(MachineClass *mc)
-{
-    ccw_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-}
-DEFINE_CCW_MACHINE(3, 1);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 150e4d18438..0dbc5e181fb 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -844,38 +844,6 @@ static uint16_t default_GEN17_GA1[] = {
 
 /* QEMU (CPU model) features */
 
-static uint16_t qemu_V3_1[] = {
-    S390_FEAT_DAT_ENH,
-    S390_FEAT_IDTE_SEGMENT,
-    S390_FEAT_STFLE,
-    S390_FEAT_SENSE_RUNNING_STATUS,
-    S390_FEAT_EXTENDED_TRANSLATION_2,
-    S390_FEAT_MSA,
-    S390_FEAT_LONG_DISPLACEMENT,
-    S390_FEAT_LONG_DISPLACEMENT_FAST,
-    S390_FEAT_EXTENDED_IMMEDIATE,
-    S390_FEAT_EXTENDED_TRANSLATION_3,
-    S390_FEAT_ETF2_ENH,
-    S390_FEAT_STORE_CLOCK_FAST,
-    S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
-    S390_FEAT_ETF3_ENH,
-    S390_FEAT_EXTRACT_CPU_TIME,
-    S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
-    S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
-    S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
-    S390_FEAT_EXECUTE_EXT,
-    S390_FEAT_SET_PROGRAM_PARAMETERS,
-    S390_FEAT_FLOATING_POINT_SUPPORT_ENH,
-    S390_FEAT_STFLE_45,
-    S390_FEAT_STFLE_49,
-    S390_FEAT_LOCAL_TLB_CLEARING,
-    S390_FEAT_INTERLOCKED_ACCESS_2,
-    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
-    S390_FEAT_ADAPTER_INT_SUPPRESSION,
-    S390_FEAT_MSA_EXT_3,
-    S390_FEAT_MSA_EXT_4,
-};
-
 static uint16_t qemu_V4_0[] = {
     /*
      * Only BFP bits are implemented (HFP, DFP, PFPO and DIVIDE TO INTEGER not
@@ -1047,7 +1015,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  * QEMU (CPU model) features
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
-    QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(V4_0),
     QEMU_FEAT_INITIALIZER(V4_1),
     QEMU_FEAT_INITIALIZER(V6_0),
-- 
2.49.0


