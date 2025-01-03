Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B52EE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTitR-0002Tk-4F; Fri, 03 Jan 2025 09:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitP-0002TL-7c
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitI-0007Fs-6b
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8Aa0b3rOVMy5V8jG0M8kqDhzoWhD5WPVCsgoA7B98w=;
 b=YjyvST1j4OUvtm11U4qVQRMCw9wzyEWAkxgA39X84S827xXmZ4/2UXItPNnOAlo63292qx
 ZCemCwu0Aw3Zn1V+MSBiCHmDAtk7u0xDyqoqdBFMboeUGfpZUY8BcxxXCZNuVxDQfFbYUu
 g0I7Qmyfw6L4Sl87MKrDf5tDuKgv9H8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-b2ylNJBdMtWh2kwZ-HQqYA-1; Fri,
 03 Jan 2025 09:43:03 -0500
X-MC-Unique: b2ylNJBdMtWh2kwZ-HQqYA-1
X-Mimecast-MFC-AGG-ID: b2ylNJBdMtWh2kwZ-HQqYA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A15219560AD; Fri,  3 Jan 2025 14:43:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF4C83000197; Fri,  3 Jan 2025 14:42:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 07/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.7
 machine type
Date: Fri,  3 Jan 2025 15:42:29 +0100
Message-ID: <20250103144232.520383-8-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The s390-ccw-virtio-2.7 machine is older than 6 years, so according to
our machine support policy, it can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ffeee2da48..a1e9c1f6e8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1284,21 +1284,6 @@ static void ccw_machine_2_8_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2, 8);
 
-static void ccw_machine_2_7_instance_options(MachineState *machine)
-{
-    ccw_machine_2_8_instance_options(machine);
-}
-
-static void ccw_machine_2_7_class_options(MachineClass *mc)
-{
-    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
-
-    s390mc->cpu_model_allowed = false;
-    ccw_machine_2_8_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-}
-DEFINE_CCW_MACHINE(2, 7);
-
 #endif
 
 static void ccw_machine_register_types(void)
-- 
2.47.1


