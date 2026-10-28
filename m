Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6811606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tTYOSnYy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5l-0003UG-AA; Wed, 28 Oct 2026 01:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5k-0003U6-5d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5i-0005xr-8C
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4iEdA2858230; Wed, 28 Oct 2026 05:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=e9+lVc7cjPyc2HDTU
 4KO5G1jTXwM+ujBDzdsXTJKkic=; b=tTYOSnYywS05bLXyuHmLbd8G6muZjaMxz
 RycZzkVHa6s5atgtVEezZV7J9SlxKj8cZc0sgTayn94p58rbf/a5+nmzFcO2bJJa
 bqYs9g5ZTUeZduxZlwd4qyPiQBygmGoYrGnb2K4+tVivmPlhqSX0ReYshUaUVSbz
 V2rcWBlavM++LDsMZovV5f0K2DCqaVl02d9Io7XW+x9ViAbWIAN4bXxqk2sDYpI7
 naRRAYsllnQWnME6yVyTJi7AeDS1ePNqR1GbHHmFLehq4gM2Xeqhp1EfdhzNb+0x
 p+3vbtbEqLZx5IRbVhi5RByO7XdYrC3jMbrAXiM0yUCA30BY+GN9g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt33qh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YxUn1074257; Wed, 28 Oct 2026 05:20:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1u988-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5KhJ415532330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 206282004B;
 Wed, 28 Oct 2026 05:20:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0877C20040;
 Wed, 28 Oct 2026 05:20:42 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Lazymio <mio@lazym.io>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PULL 4/6] hw/net/spapr_llan: validate RxBufPool fields on migration
 load
Date: Wed, 28 Oct 2026 10:50:22 +0530
Message-ID: <20261028052024.38377-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX3ypM5rdVvhQ4
 QytOEYxCEU63UBmtxaUs+sQX8UgzhxhdWMVWTfXsrUogUh18tQue30tsDeVBcILOe17HloI3LuX
 v0ueSHuPI1U2i0ZXOLV/E6WjPFvCvStdNReAy8LPW1sUML9tSE1EIF61Etfgo/jjSM6FY5i09fv
 1Zo9YGpC0ZM2zXSUYYe2scib8XGZtCBOJaEbXtU+JmIzTXQuY4X1SPsaa2VSL+o2SpQLZ45Nx22
 KPjxnGeMJW3J9j5DxZux/+PwQS58PD0k/LvTlL5GgGiMlodKyHnfQzqXH8/om6kdHzm9bf1ntZ6
 tKfvKTg1Kr18ipJIYfd2g7lvYAsbPcFlIKyBhE0HECceKXHx2uRMsaCeuez4aPga/vbbZUtJRbh
 9jpJTCujncJ1gTzHhrcBsIrfyJD/FMlUhYj/6bl/dcw0F3w2kmCiBVFXLIImZ1/1dMoEXmD91XD
 0k8yJejoZn/6RaKOhSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX6yULOlj7BDu1
 RtOgFQFL7nXLJIDob5g3hkGVsCmY071i1k/zi4Bqz3bxLtCvrl5xRV1Me6uuBKQQSufEMuFGVKB
 l9/3p709bSSHU4QdQqhIqvy8sFSiV94=
X-Proofpoint-ORIG-GUID: wujf0XRjxxl4eWDuqItMKHtphaHZjoyB
X-Proofpoint-GUID: wujf0XRjxxl4eWDuqItMKHtphaHZjoyB
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae1862f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=X-KEfNhN3815lkfU2ToA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chinmay Rath <rathc@linux.ibm.com>

vmstate_rx_buffer_pool restores count and bufsize as raw int32 values
with no bounds checking.  A crafted migration stream can set count to
any int32 value.  spapr_vlan_get_rx_bd_from_pool() then passes the
count > 0 guard, decrements count, and uses the result as an array
index into bds[], a 4096-entry fixed heap allocation:

    dev->rx_pool[pool]->count--;
    bd  = dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count];  /* OOB read  */
    dev->rx_pool[pool]->bds[dev->rx_pool[pool]->count] = 0;    /* OOB write */

With count == INT32_MAX this lands ~17 GiB past the start of a 32 KiB
heap object.  Additionally, a negative bufsize silently compares as a
huge value when widened to size_t, defeating the bufsize >= size + 8
pool-selection guard.

The hypercall path (spapr_vlan_add_rxbuf_to_pool) already enforces
0 <= count < RX_POOL_MAX_BDS; add a post_load hook to
vmstate_rx_buffer_pool that rejects any stream violating the same
invariant, failing the incoming migration.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4147
Reported-by: Lazymio <mio@lazym.io>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260917202854.288439-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/net/spapr_llan.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 550848307d..a5b8906849 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -800,11 +800,29 @@ static bool spapr_vlan_rx_buffer_pools_needed(void *opaque)
     return (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) != 0;
 }
 
+static int spapr_vlan_rx_buffer_pool_post_load(void *opaque, int version_id)
+{
+    RxBufPool *rxp = opaque;
+
+    if (rxp->count < 0 || rxp->count > RX_POOL_MAX_BDS) {
+        return -EINVAL;
+    }
+    /*
+     * bufsize is compared against a size_t in spapr_vlan_get_rx_bd_from_pool(),
+     * so a negative value would compare as huge.
+     */
+    if (rxp->bufsize < 0) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_rx_buffer_pool = {
     .name = "spapr_llan/rx_buffer_pool",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = spapr_vlan_rx_buffer_pools_needed,
+    .post_load = spapr_vlan_rx_buffer_pool_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(bufsize, RxBufPool),
         VMSTATE_INT32(count, RxBufPool),
-- 
2.52.0


