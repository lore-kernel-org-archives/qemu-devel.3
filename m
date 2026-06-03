Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE72CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUezy-0004pz-DG; Wed, 03 Jun 2026 02:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wUezu-0004pq-7l
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:22:38 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wUezm-0003Lw-HZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:22:37 -0400
X-UUID: 8d476a005f1411f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f3735dd8-8d09-4e2f-9002-8ad57a438a8b, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:f3735dd8-8d09-4e2f-9002-8ad57a438a8b, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:01ecc9d48a74067439a6091bb5b18d5d,
 BulkI
 D:260603142212VO55XLKP,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
 |850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
 k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
 ,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8d476a005f1411f1aa26b74ffac11d73-20260603
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 586920824; Wed, 03 Jun 2026 14:22:09 +0800
From: zhaoguohan@kylinos.cn
To: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] vfio-user: validate VERSION replies
Date: Wed,  3 Jun 2026 14:21:38 +0800
Message-ID: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The vfio-user protocol makes the VERSION payload optional, so a
reply may legally stop after the major and minor fields.

vfio_user_validate_version() currently assumes a capabilities string is
always present and NUL-terminated. When the server replies without
version data, QEMU ends up reusing the request-side capabilities buffer
and the terminating-NUL check underflows. Replies shorter than the fixed
VERSION header are also accessed before they are validated.

Reject replies shorter than the fixed VERSION header and only parse
capabilities when the reply actually carries version data.

Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/vfio-user/proxy.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0f7d8425d614..197aee07bf7a 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -1292,7 +1292,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
 {
     g_autofree VFIOUserVersion *msgp = NULL;
     GString *caps;
-    char *reply;
+    const char *reply = "";
     int size, caplen;
 
     caps = caps_json();
@@ -1322,17 +1322,24 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
         return false;
     }
 
-    reply = msgp->capabilities;
-    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
-        error_setg(errp, "corrupt version reply");
+    if (msgp->hdr.size < sizeof(*msgp)) {
+        error_setg(errp, "short version reply");
         return false;
     }
 
-    if (!caps_check(proxy, msgp->minor, reply, errp)) {
-        return false;
+    if (msgp->hdr.size > sizeof(*msgp)) {
+        reply = msgp->capabilities;
+        if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+            error_setg(errp, "corrupt version reply");
+            return false;
+        }
+
+        if (!caps_check(proxy, msgp->minor, reply, errp)) {
+            return false;
+        }
     }
 
-    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    trace_vfio_user_version(msgp->major, msgp->minor, reply);
     return true;
 }
 
-- 
2.43.0


