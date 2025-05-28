Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C7AC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgj-0006Sh-5K; Wed, 28 May 2025 06:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg0-0004CD-BG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfh-0007Eb-88
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDA/okgTdwBkuJfM2akfszXR3E9almYZhidqyI4nBwI=;
 b=GD5xh+/SDriuwfKJugCHOyHt0XFr1t2R/IsVno1BNJVMOHQXSy1SSlMPI/9byozK4YfakM
 ZVzQQpW6+A3hUrzYfXfNro1muTaeE47ibaIpgM9SU08J2n7fZ4KfejuA9g9/SLH6vfmbDO
 bgWRvkmqKu1lmjb6x/gWFS+KRHOuxK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-ZGw3g00AO3eoj7bgJVbMUw-1; Wed,
 28 May 2025 06:05:57 -0400
X-MC-Unique: ZGw3g00AO3eoj7bgJVbMUw-1
X-Mimecast-MFC-AGG-ID: ZGw3g00AO3eoj7bgJVbMUw_1748426756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC16195608A; Wed, 28 May 2025 10:05:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ECA3180049D; Wed, 28 May 2025 10:05:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/27] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
Date: Wed, 28 May 2025 12:04:54 +0200
Message-ID: <20250528100507.313906-15-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
via the 'extra_mac_registers=off' property. We removed all
machines using that array, lets remove all the code around
E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
similarly to commit fa4ec9ffda7 ("e1000: remove old
compatibility code").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20250512083948.39294-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/e1000.c | 95 ++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index cba4999e6d0..a80a7b0cdb4 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,10 +127,8 @@ struct E1000State_st {
     QEMUTimer *flush_queue_timer;
 
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
-#define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_VET_BIT 4
-#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
 #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
 #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
 
@@ -1212,52 +1210,51 @@ enum { NWRITEOPS = ARRAY_SIZE(macreg_writeops) };
 
 enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
 
-#define markflag(x)    ((E1000_FLAG_##x << 2) | MAC_ACCESS_FLAG_NEEDED)
 /* In the array below the meaning of the bits is: [f|f|f|f|f|f|n|p]
  * f - flag bits (up to 6 possible flags)
  * n - flag needed
- * p - partially implenented */
+ * p - partially implemented */
 static const uint8_t mac_reg_access[0x8000] = {
-    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
-    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
-    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
-    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
-    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
-    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
-    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
-    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
-    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
-    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
-    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
-    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
-    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
-    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
-    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
-    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
-    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
-    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
-    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
-    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
-    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
-    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
-    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
-    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
-    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
-    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
-    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
-    [BPTC]    = markflag(MAC),
-
-    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
-    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
+    [IPAV]    = MAC_ACCESS_FLAG_NEEDED,    [WUC]     = MAC_ACCESS_FLAG_NEEDED,
+    [IP6AT]   = MAC_ACCESS_FLAG_NEEDED,    [IP4AT]   = MAC_ACCESS_FLAG_NEEDED,
+    [FFVT]    = MAC_ACCESS_FLAG_NEEDED,    [WUPM]    = MAC_ACCESS_FLAG_NEEDED,
+    [ECOL]    = MAC_ACCESS_FLAG_NEEDED,    [MCC]     = MAC_ACCESS_FLAG_NEEDED,
+    [DC]      = MAC_ACCESS_FLAG_NEEDED,    [TNCRS]   = MAC_ACCESS_FLAG_NEEDED,
+    [RLEC]    = MAC_ACCESS_FLAG_NEEDED,    [XONRXC]  = MAC_ACCESS_FLAG_NEEDED,
+    [XOFFTXC] = MAC_ACCESS_FLAG_NEEDED,    [RFC]     = MAC_ACCESS_FLAG_NEEDED,
+    [TSCTFC]  = MAC_ACCESS_FLAG_NEEDED,    [MGTPRC]  = MAC_ACCESS_FLAG_NEEDED,
+    [WUS]     = MAC_ACCESS_FLAG_NEEDED,    [AIT]     = MAC_ACCESS_FLAG_NEEDED,
+    [FFLT]    = MAC_ACCESS_FLAG_NEEDED,    [FFMT]    = MAC_ACCESS_FLAG_NEEDED,
+    [SCC]     = MAC_ACCESS_FLAG_NEEDED,    [FCRUC]   = MAC_ACCESS_FLAG_NEEDED,
+    [LATECOL] = MAC_ACCESS_FLAG_NEEDED,    [COLC]    = MAC_ACCESS_FLAG_NEEDED,
+    [SEQEC]   = MAC_ACCESS_FLAG_NEEDED,    [CEXTERR] = MAC_ACCESS_FLAG_NEEDED,
+    [XONTXC]  = MAC_ACCESS_FLAG_NEEDED,    [XOFFRXC] = MAC_ACCESS_FLAG_NEEDED,
+    [RJC]     = MAC_ACCESS_FLAG_NEEDED,    [RNBC]    = MAC_ACCESS_FLAG_NEEDED,
+    [MGTPDC]  = MAC_ACCESS_FLAG_NEEDED,    [MGTPTC]  = MAC_ACCESS_FLAG_NEEDED,
+    [RUC]     = MAC_ACCESS_FLAG_NEEDED,    [ROC]     = MAC_ACCESS_FLAG_NEEDED,
+    [GORCL]   = MAC_ACCESS_FLAG_NEEDED,    [GORCH]   = MAC_ACCESS_FLAG_NEEDED,
+    [GOTCL]   = MAC_ACCESS_FLAG_NEEDED,    [GOTCH]   = MAC_ACCESS_FLAG_NEEDED,
+    [BPRC]    = MAC_ACCESS_FLAG_NEEDED,    [MPRC]    = MAC_ACCESS_FLAG_NEEDED,
+    [TSCTC]   = MAC_ACCESS_FLAG_NEEDED,    [PRC64]   = MAC_ACCESS_FLAG_NEEDED,
+    [PRC127]  = MAC_ACCESS_FLAG_NEEDED,    [PRC255]  = MAC_ACCESS_FLAG_NEEDED,
+    [PRC511]  = MAC_ACCESS_FLAG_NEEDED,    [PRC1023] = MAC_ACCESS_FLAG_NEEDED,
+    [PRC1522] = MAC_ACCESS_FLAG_NEEDED,    [PTC64]   = MAC_ACCESS_FLAG_NEEDED,
+    [PTC127]  = MAC_ACCESS_FLAG_NEEDED,    [PTC255]  = MAC_ACCESS_FLAG_NEEDED,
+    [PTC511]  = MAC_ACCESS_FLAG_NEEDED,    [PTC1023] = MAC_ACCESS_FLAG_NEEDED,
+    [PTC1522] = MAC_ACCESS_FLAG_NEEDED,    [MPTC]    = MAC_ACCESS_FLAG_NEEDED,
+    [BPTC]    = MAC_ACCESS_FLAG_NEEDED,
+
+    [TDFH]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFT]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFHS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFTS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [TDFPC]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFH]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFT]    = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFHS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFTS]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [RDFPC]   = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
+    [PBM]     = MAC_ACCESS_FLAG_NEEDED | MAC_ACCESS_PARTIAL,
 };
 
 static void
@@ -1419,13 +1416,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool e1000_full_mac_needed(void *opaque)
-{
-    E1000State *s = opaque;
-
-    return chkflag(MAC);
-}
-
 static bool e1000_tso_state_needed(void *opaque)
 {
     E1000State *s = opaque;
@@ -1451,7 +1441,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     .name = "e1000/full_mac_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = e1000_full_mac_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mac_reg, E1000State, 0x8000),
         VMSTATE_END_OF_LIST()
@@ -1679,8 +1668,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static const Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("extra_mac_registers", E1000State,
-                    compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
                     compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_BIT("init-vet", E1000State,
-- 
2.49.0


