Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C353D0E6C3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqoc-0006uM-4F; Tue, 25 Nov 2025 06:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqob-0006tt-5V
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1vNqoY-0002YN-KQ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:02:32 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AP9rvpp2364376; Tue, 25 Nov 2025 11:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=HO+WT
 uvCri9hO5thS45yM5xtiIGClRLeUhdqeo+0stA=; b=KBPE07k+ZUljhlKvFC/N6
 DCQUOy2g67oi1yIEEigqWK0rjLm8KTkEkvrE1V6z3gp6b9ox/vCKF/XsmrDNkg3M
 zmyFSBK6jW/ZJ+akbJvB/FQYpqhi9715Y3Rk9JMLmi1EETqqPRR5fjvVIVBdijuO
 o2NcXYkex9Z3+Rcu4IHeOwUIFonrRwwdLfKezMF1YRgLgNEIv7JgWR/LxAAGE80t
 KxbBaL4RCx9g1lYq8ijcsRwP+7dtp+CvwHtZYweklZ5rTXWnLrMciqPfpKpG52xI
 aY48FZkR9RqM0pRZNlEfx1Md0EGDSXy/cOVMlRFPS8BDZ8chcu6PLsuIVbRwMP+v
 Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8d2vd5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AP9T5Ov022724; Tue, 25 Nov 2025 11:02:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3mkbqj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 11:02:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5APB2C36034162;
 Tue, 25 Nov 2025 11:02:13 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ak3mkbqd7-3; Tue, 25 Nov 2025 11:02:13 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/2] virtio-scsi: Make max_lun value configurable
Date: Tue, 25 Nov 2025 11:01:51 +0000
Message-ID: <3e54627d9a6639d2d1d9ce3674852f174ad4be71.1763999544.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1763999544.git.karolina.stolarek@oracle.com>
References: <cover.1763999544.git.karolina.stolarek@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250090
X-Authority-Analysis: v=2.4 cv=QPJlhwLL c=1 sm=1 tr=0 ts=69258cb7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=qKCWRbS_UU7gRvXGpWkA:9 cc=ntf awl=host:13642
X-Proofpoint-GUID: F_NHe9kAFvZmaKa7pUvUKQlv7QHo46rt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA5MCBTYWx0ZWRfXwsSOFwpL0ozH
 JDAUMTCioTUhEf++MAH774Qw58RQBkX9O26knFvH54vo5srwVquxE1aR66VmXykYbRGYYo6y0N/
 kzgbuA4CIurh8D7I3WCwTdfZAD9D6pYXXhGfTlY1XLdNb2s2BuR2pl2L6QxhuLZ/fMxGYQS1deQ
 0n2+aDfyGkGyegDB3CHlCF5psjLw39YNm1MqpTzGRzCWg5ukcQo0tRhQp2S89bxTigSpS3Ev+Dv
 0j+o7sPTuI3Q+VBx13lkGtekR77433rR0nGU+3ZCChHjltTvcS471tZxH5z0Vnwb7T8R2ISpugq
 pMDj9KpxvqVYgwjSyD6/u889UXpQqL05WqCE4HziLuoBZxNpAhYt58GNYUURRotrpvT+PtpdmDh
 mqku0/CSDvGzTX7Fok03SS5IcAC8iNxuzH9wOaT4J2oIkiuxNxA=
X-Proofpoint-ORIG-GUID: F_NHe9kAFvZmaKa7pUvUKQlv7QHo46rt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By default, the host adapter instance expects the maximum
of 8 LUNs. The virtio-scsi driver doesn't override this value,
as it queries for the actual number of the Logical Units during
virtscsi_probe(). Still, some drivers do not perform such scan
and assume the virtio_scsi_scsi_info.max_lun value to be definite
and correct, which might not be true. This can result in the driver
queuing up SCSI commands referring to LUNs that do not exist.

Add "max_lun" option to virtio-scsi and vhost-scsi devices to
specify the maximum number of LUNs to prevent sending commands
to Logical Units that do not exist.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/vhost-scsi.c            | 2 ++
 hw/scsi/virtio-scsi.c           | 6 ++++--
 include/hw/virtio/virtio-scsi.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 1a4860a72f..6883629170 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -355,6 +355,8 @@ static const Property vhost_scsi_properties[] = {
                       true),
     DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
                         VIRTIO_SCSI_MAX_TARGET),
+    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
+                        VIRTIO_SCSI_MAX_LUN),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 091f68090e..9e7eebd835 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -972,7 +972,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
     virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
     virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
-    virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
+    virtio_stl_p(vdev, &scsiconf->max_lun, s->conf.max_lun);
 }
 
 static void virtio_scsi_set_config(VirtIODevice *vdev,
@@ -1266,7 +1266,7 @@ static void virtio_scsi_init_scsi_info(struct VirtIOSCSIConf *conf)
 {
     virtio_scsi_scsi_info.tcq = true;
     virtio_scsi_scsi_info.max_channel = VIRTIO_SCSI_MAX_CHANNEL;
-    virtio_scsi_scsi_info.max_lun = VIRTIO_SCSI_MAX_LUN;
+    virtio_scsi_scsi_info.max_lun = conf->max_lun;
     virtio_scsi_scsi_info.max_target = conf->max_target;
 
     virtio_scsi_scsi_info.complete = virtio_scsi_command_complete;
@@ -1385,6 +1385,8 @@ static const Property virtio_scsi_properties[] = {
                       parent_obj.conf.seg_max_adjust, true),
     DEFINE_PROP_UINT16("max_target", VirtIOSCSICommon, conf.max_target,
                         VIRTIO_SCSI_MAX_TARGET),
+    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
+                        VIRTIO_SCSI_MAX_LUN),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 3998b241f6..61fe5cae34 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -55,6 +55,7 @@ struct VirtIOSCSIConf {
     bool worker_per_virtqueue;
     bool seg_max_adjust;
     uint16_t max_target;
+    uint32_t max_lun;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
     char *vhostfd;
-- 
2.47.1


