Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48793E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTit7-0002PL-FV; Fri, 03 Jan 2025 09:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTit5-0002Ou-Ny
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTit4-0007E9-Gw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0f0JsOowMhs3GaSBPu74TOKaOj5Fij+cbYE60LuiHk=;
 b=CVcxdz7kTocKAc8a37nladmvWpKFFX+6fAywf1hhi2JZB3ASKxHUoUD4cCsmimmqV7903n
 9nDRYzutBtla895n0MBQJwj7Fbcb/p0E4oYht2lrtg2cPscvqbKcN03vACHfkstid3dZL6
 VvjgN+dteGmzXU2Kfv7jbVuItQ+SZLQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-LNOE1tg1O26Y_diq31a8Bw-1; Fri,
 03 Jan 2025 09:42:48 -0500
X-MC-Unique: LNOE1tg1O26Y_diq31a8Bw-1
X-Mimecast-MFC-AGG-ID: LNOE1tg1O26Y_diq31a8Bw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EC521955F3C; Fri,  3 Jan 2025 14:42:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7309B3000197; Fri,  3 Jan 2025 14:42:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 03/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.6
 machine type
Date: Fri,  3 Jan 2025 15:42:25 +0100
Message-ID: <20250103144232.520383-4-thuth@redhat.com>
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

The s390-ccw-virtio-2.6 machine is older than 6 years, so according to
our machine support policy, it can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index bca61488cc..341430a101 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1305,26 +1305,6 @@ static void ccw_machine_2_7_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2, 7);
 
-static void ccw_machine_2_6_instance_options(MachineState *machine)
-{
-    ccw_machine_2_7_instance_options(machine);
-}
-
-static void ccw_machine_2_6_class_options(MachineClass *mc)
-{
-    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] = {
-        { TYPE_S390_IPL, "iplbext_migration", "off", },
-         { TYPE_VIRTUAL_CSS_BRIDGE, "css_dev_path", "off", },
-    };
-
-    s390mc->ri_allowed = false;
-    ccw_machine_2_7_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_CCW_MACHINE(2, 6);
-
 #endif
 
 static void ccw_machine_register_types(void)
-- 
2.47.1


