Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867B606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pfKthc82
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQbG-0003FA-96; Mon, 09 Nov 2026 09:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xQQbD-0003Ch-8x; Mon, 09 Nov 2026 09:43:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xQQbB-0005lx-He; Mon, 09 Nov 2026 09:43:55 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEpXv3508105; Mon, 9 Nov 2026 14:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CT92/eBU32027OSYa
 2zdHya9JDzOg0e2RGxcBTgyxIU=; b=pfKthc827khUP1oDkprCKwwEbHqXY2DEb
 6Q5MmWAPVZTNT2S/z/3UgrNAYO+Odw3uNKUb2A7bh7rJfnvmOtQsMzXdgJ+2mb8v
 z3zHuVc+tW22tYlW4iXqstnN25K5iiUTvxqcBtDmLlTJoycuNDEkwu+jnC5I+Xs7
 zfaE/DRRM/8TbBstescsu3jmB6bkRBzZwB+NVSSfGTu8eaXVySQd+Au8BDLKz/rv
 379Y3Dtyzey0LEr/FZ70WfXSIgZBECXJ4Aslzz0INp8/uHU5ncJE6eHgttEJkaIT
 YuLb7LJRMVCovvUTVYgAF2/lX2U5Hc41h6jpnM1xv6Nu9O4LaCrsA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumundk3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 14:43:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DJxpa037093; Mon, 9 Nov 2026 14:43:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak0dkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 14:43:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9Ehmen20906702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 14:43:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C408958058;
 Mon,  9 Nov 2026 14:43:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DC2958017;
 Mon,  9 Nov 2026 14:43:47 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8058-b2c04f424b34.ibm.com.com (unknown
 [9.61.139.143]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 14:43:47 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PULL for v11.2 1/1] vhost: only use config notifier when
 exists/initialized
Date: Mon,  9 Nov 2026 09:43:43 -0500
Message-ID: <20261109144344.847531-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109144344.847531-1-farman@linux.ibm.com>
References: <20261109144344.847531-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX4KW7MJ50OCN+
 mLtzZ3X4SH6DEM0oL0VuUSYAnNV7sdv9bKIfhGGBD439Z0OwGGiTUyHd66+p3cCu/T8kYiL6B9C
 +uj7mKZ4+XBdlcOdX/VepJPEZeOji5s=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af1dc26 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=6R7veym_AAAA:8
 a=imYxtfgo-3jAVhZrOLEA:9 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: _UI_1n4A0PgHA_xJoWqVvXr5bqZcLLSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX/9JbjNUtmb4C
 Pr0p9QcXNyLez7G2p4f+MSFZ/WEiLBWii0/CNAqi9g+fW6MeZU6/rY5zG9dVQWhM8gpmhituYZg
 GIEp2mrphAgMpeHBpImPI+zwyaWhpAWvStTfIX6EqIz/0xEqIi15ddQ7n57P/2skWwEwXBJbB+g
 Q8zDDfAShOun662t2hFSlTIG6sDZB6Qx1ghtwILOWdsK9vJFJYArHmin+IJOojJEd4g8E+O06nh
 b/SjO0egGhCuojeMWU2KY1f9Ptz+W/VbDBKjWU+PL7wWXwCaM4rCdJA1+Si1LfRkUO5Wu9ZPnrA
 2aRpuq/Bh+Boi3eEVnet9WFqaRAiG3h+IXie2ySUbbdcRSvYzhd6u7JyQluCdHp4XcCoOlFe0U9
 RSKzQULWZODmoEgIb6KXFwJwYbQq8c26UOxVwWwRFPK2F0wkUHH9ftNPJlZNQpuplbrP+frfzED
 ylZVDrL3U2RXTU7uLtA==
X-Proofpoint-ORIG-GUID: _UI_1n4A0PgHA_xJoWqVvXr5bqZcLLSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added an
assert for an uninitialized file descriptor in event_notifier_get_fd(),
but it presumes that such a thing always exists.

On s390x, where a config notifier does not exist, this is a breaking
change for any vhost-backed device such as virtio-net. To remedy this,
move the acquisition of the file descriptor within the guard against
vhost_set_config_call and expand the guard to ensure the notifier is
initialized before being used.

Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261103172732.837511-1-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b25919c5c7..189ac54117 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2119,8 +2119,9 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
         virtio_config_get_guest_notifier(dev->vdev);
 
     assert(dev->vhost_ops);
-    int fd = event_notifier_get_fd(config_notifier);
-    if (dev->vhost_ops->vhost_set_config_call) {
+    if (dev->vhost_ops->vhost_set_config_call &&
+        event_notifier_initialized(config_notifier)) {
+        int fd = event_notifier_get_fd(config_notifier);
         r = dev->vhost_ops->vhost_set_config_call(dev, fd);
         if (!r) {
             event_notifier_set(config_notifier);
-- 
2.56.0


