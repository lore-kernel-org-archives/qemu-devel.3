Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A90C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAH9-0001PB-VU; Wed, 14 May 2025 07:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH7-0001Od-1B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH5-00028Q-4h
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07nOEpguW3GXoG/tPJqxE2PwwSI+/QZ101/bNuxMAXM=;
 b=egD80lrKJGDF2ub7BRjGOsmlpwWE/4uC91Q2CweWpr3mEjUOmB9DRTub8LRjynv1jYhcOp
 kAGa1D4/CfVycx5d4hing+RzMG13TowXHg239YYPc1QN8mVfSqlewf7N4hfGQX1p+yyF/V
 gBiw9hOL+xz2HTe1O26/g8PJqnVrJ/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-CQ4gpicNMdyA5T8cBozoVw-1; Wed,
 14 May 2025 07:27:40 -0400
X-MC-Unique: CQ4gpicNMdyA5T8cBozoVw-1
X-Mimecast-MFC-AGG-ID: CQ4gpicNMdyA5T8cBozoVw_1747222059
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A97E195DB9C; Wed, 14 May 2025 11:27:39 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C71E419560B3; Wed, 14 May 2025 11:27:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/13] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.11
 machine type
Date: Wed, 14 May 2025 13:27:22 +0200
Message-ID: <20250514112733.456644-3-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The s390-ccw-virtio-2.11 machine is older than 6 years, so according
to our machine support policy, it can be removed now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250506062148.306084-3-thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 206124f7a46..104a24ee002 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1252,31 +1252,6 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
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


