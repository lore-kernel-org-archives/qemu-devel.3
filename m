Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EA606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovY-0003Yp-Uw; Fri, 27 Nov 2026 00:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1xWovP-0003N7-MK
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:55:12 -0500
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1xWovM-0007X9-H7
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:55:11 -0500
X-UUID: 0ed814aaea2711f19a56ed5b684f684d-20261127
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B,
 HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_SJ_LANG, HR_SJ_LEN
 HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
 HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
 SA_TRUSTED, SA_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:3497c572-d7dc-4fa8-88b6-a2ce6d5056d1, IP:15,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:3497c572-d7dc-4fa8-88b6-a2ce6d5056d1, IP:15,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:1c61cfa7ccd9f1f9d0f98e0d5f9cb703,
 BulkI
 D:2611271354534P0EL1QI,BulkQuantity:0,SF:10|66|78|102|123|127|136|865|898,
 TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
 ,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
 0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ed814aaea2711f19a56ed5b684f684d-20261127
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1217894549; Fri, 27 Nov 2026 13:54:49 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Khan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] hw/virtio/vhost-user-scmi: propagate startup errors
Date: Fri, 27 Nov 2026 13:54:24 +0800
Message-ID: <20261127055424.79483-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Khan Zhao <zhaoguohan@kylinos.cn>

Return errors from vu_scmi_start() through vu_scmi_set_status() so
device startup failures reach the caller.

Remove the duplicate error message after vhost_dev_init(), which
already reports initialization errors through errp.

Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-scmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index ad5c176c1e2..1dd29ff0008 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -125,7 +125,7 @@ static int vu_scmi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 
     if (should_start) {
-        vu_scmi_start(vdev);
+        return vu_scmi_start(vdev);
     } else {
         int ret;
         ret = vu_scmi_stop(vdev);
@@ -260,8 +260,6 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
     ret = vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "vhost-user-scmi: vhost_dev_init() failed");
         do_vhost_user_cleanup(vdev, scmi, vhost_vqs);
         return;
     }
-- 
2.43.0


