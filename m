Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C07EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 06:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCBh1-0007ze-78; Tue, 06 May 2025 02:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBgw-0007xy-Qs
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCBgt-0005rA-Ts
 for qemu-devel@nongnu.org; Tue, 06 May 2025 02:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746512524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lsvq2l8fpqfDzQRtjnUzgpQNaIbBs7LgzXEwVT8Akk=;
 b=esnXf2LlIomYXyVDMqtdalF+Tz2+3BEhOf03a/1yRpgtEpdBJCs3gCABfYYOVplVVkwQyf
 Xu94VPF090qqDLBcDAiKky9SfvSWKa8NDhPAEGtXlP0JvwyRXLhlc6d/0VcgNtYE0KgC1g
 IDGcya7qJaKdL3oQRKC8qX8AlrI6xXg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-9QuMce4bMACwOwxtMfSVNA-1; Tue,
 06 May 2025 02:22:01 -0400
X-MC-Unique: 9QuMce4bMACwOwxtMfSVNA-1
X-Mimecast-MFC-AGG-ID: 9QuMce4bMACwOwxtMfSVNA_1746512520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 552291955DCC; Tue,  6 May 2025 06:22:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.237])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94ED318001D7; Tue,  6 May 2025 06:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/9] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.11
 machine type
Date: Tue,  6 May 2025 08:21:41 +0200
Message-ID: <20250506062148.306084-3-thuth@redhat.com>
In-Reply-To: <20250506062148.306084-1-thuth@redhat.com>
References: <20250506062148.306084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

The s390-ccw-virtio-2.11 machine is older than 6 years, so according
to our machine support policy, it can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0813eb4ea47..2c90702d834 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1250,31 +1250,6 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2, 12);
 
-#ifdef CONFIG_S390X_LEGACY_CPUS
-
-static void ccw_machine_2_11_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_11 };
-    ccw_machine_2_12_instance_options(machine);
-
-    /* before 2.12 we emulated the very first z900 */
-    s390_set_qemu_cpu_model(0x2064, 7, 1, qemu_cpu_feat);
-}
-
-static void ccw_machine_2_11_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SCLP_EVENT_FACILITY, "allow_all_mask_sizes", "off", },
-    };
-
-    ccw_machine_2_12_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_CCW_MACHINE(2, 11);
-
-#endif
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.49.0


