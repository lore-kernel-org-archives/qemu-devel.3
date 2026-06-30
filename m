Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67BEC44500
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegdT-0007Ld-BF; Tue, 30 Jun 2026 18:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcr-000772-Uo
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcp-0005tJ-Pf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:17 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UKtnZf1055221; Tue, 30 Jun 2026 22:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=4d9ph
 tuSiy9cr7Hlr7x+DeJ4Kq+shjQENhQ0hoB2EPI=; b=V/PScL/CgjoqYIqM3NgUi
 U7MO1lDqyk+8OMMFpNeF5LsToPeRtO6HsBg+rB9pTNT4cwdJkF1pqJwB6xvgMlxd
 r3o51zloe90WU8m0zPvdJ7PCSUqAMVtfCtxp21bARWa8iQj/T3mYtoGV9t+k4OzT
 vIdPFBVrEDoNqUwTdUJ/XOT+ohW4cltUVTFic7yzRzDg7uEvDcIWspSEhbpfaEB3
 tKDJ13iTF/2r7aUsG7GAo8yw0n640R60W+GBqBkoyaUc6y+ooLfCk9ZH8bs1BKrA
 klsnZ9h71pnrbEP6+77b4+7zpM7uE4l5rlfNrQlDqiWiAft9SOTh/LLvuVapEDpi
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p454h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UM3UqG033975; Tue, 30 Jun 2026 22:08:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f3u1w75x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:09 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UM87gN008507;
 Tue, 30 Jun 2026 22:08:08 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f3u1w75vm-6; Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 5/5] amd_iommu: Fix endianness handling for command buffer
 entries
Date: Tue, 30 Jun 2026 22:08:06 +0000
Message-ID: <20260630220806.1758748-6-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=817 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300215
X-Proofpoint-ORIG-GUID: lXjG9s6S18Ll2KfEoWwzCVdkHXQJH5cG
X-Proofpoint-GUID: lXjG9s6S18Ll2KfEoWwzCVdkHXQJH5cG
X-Authority-Analysis: v=2.4 cv=DK6/JSNb c=1 sm=1 tr=0 ts=6a443e4a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=raE-tf0XYUPIjkF9jFQA:9 a=O8hF6Hzn-FEA:10 a=cvBusfyB2V15izCimMoJ:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX3juqYEhur99y
 IUA8FoGRo0DG9kmwHpb32tbuVUmC0CINsg2gRsB0M+pMgoAzQJN5gmjSQEZkH8PayUfhS54DAQE
 BK2tCLA2xaBeKgjkF5Pu20l2+OojzVEyViBYfQiFpKGH8yfnNsq7VOMKF1/9qlafXdT4QFm+e9p
 6lXHeVS8YhqzQgpfF3uMiplOPK08mCavhyhrlegPb5eHUXpuFW8Bh8XorFJ3wUO5R891FLlDnKD
 jMOnm8otHvFQ4CFwf29TSF82V04K0Puk0HisfYc8l9vLYTtXb9gwtuuXndHInCwnCwx2Ugz5v/u
 vAeogvWD12AWtbFay1hwxpAb/jE5vggCGVWYnS+ANeyDOYUsz31jzyFfCz68kKsNE+sSsGAzyPy
 MYNf0aZdWN8WLVbCQGrzL1D3C1Ms1cd5YSiF0rK8ygV5h9/Vl/RERQ34kVdBf0v4BLmAmiFSkAW
 7jOG4RWrJJM77bmMLAK2cDWyVv3lUvY4nHqeVQmI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXzoCLLEdJCM3j
 SBkjaa22l9kVLUUQEj3xND6LLNJbVJzqLoiyQxeSnNaHSMDC/ROc1jPejuzRfprD/LIS3LsRDnb
 jB1958upklEA4JGOxqEf050oJvjwKCfsMcvE4Kgk7FQnGhXTR5fo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AMD IOMMU command buffer entries are stored in guest memory in little-endian
format. Convert command buffer with le64_to_cpu() after dma_memory_read(),
so that command handlers can all operate using host native endianness.

Remove the cpu_to_le*() conversions from command handlers, since the values
are used internally by device emulation and do not need translation.
Conversion is only necessary when reading or writing to guest memory e.g.
writing completion-wait data and event log entries.

The flow for command buffer handling is:

- Retrieve command buffer (cmd[]) from guest memory (via dma_memory_read())
- Convert command buffer to host endianness (via le64_to_cpu())
- All handlers decode fields from cmd[] in host-endian format
- All emulation code uses decoded values in host-endian format
- Use cpu_to_le*() when writing back data to guest memory

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/amd_iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c7bf21b762..90252c52af 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -278,6 +278,7 @@ static uint32_t get_next_eventlog_entry(AMDVIState *s)
 
 static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 {
+    uint64_t le_evt[2];
     uint32_t evtlog_tail_next;
 
     /* event logging not enabled */
@@ -298,8 +299,14 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         return;
     }
 
+    /*
+     * Convert event buffer to little-endian before writing it to guest memory.
+     */
+    le_evt[0] = cpu_to_le64(evt[0]);
+    le_evt[1] = cpu_to_le64(evt[1]);
+
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail,
-                         evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
+                         le_evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
@@ -545,15 +552,18 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
 static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
 {
     /* pad the last 3 bits */
-    hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
-    uint64_t data = cpu_to_le64(cmd[1]);
+    hwaddr addr = extract64(cmd[0], 3, 49) << 3;
+    uint64_t data = cmd[1];
+
+    /* Format the data to be written to guest memory as little-endian */
+    uint64_t le_data = cpu_to_le64(data);
 
     if (extract64(cmd[0], 52, 8)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
     if (extract64(cmd[0], 0, 1)) {
-        if (dma_memory_write(&address_space_memory, addr, &data,
+        if (dma_memory_write(&address_space_memory, addr, &le_data,
                              AMDVI_COMPLETION_DATA_SIZE,
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_amdvi_completion_wait_fail(addr);
@@ -1281,7 +1291,7 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
 
     trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
                              PCI_FUNC(devid));
@@ -1448,9 +1458,9 @@ static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
-    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
-    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
+    uint16_t domid = extract64(cmd[0], 32, 16);
+    uint64_t addr = extract64(cmd[1], 12, 52) << 12;
+    uint16_t flags = extract64(cmd[1], 0, 3);
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -1497,7 +1507,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -1509,7 +1519,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
         g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_devid,
                                     &devid);
     } else {
-        amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
+        amdvi_iotlb_remove_page(s, extract64(cmd[1], 12, 52) << 12,
                                 devid);
     }
     trace_amdvi_iotlb_inval();
@@ -1527,6 +1537,15 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         return;
     }
 
+    /*
+     * Commands in guest memory are little-endian. Convert once after reading
+     * so that command handlers can decode values in host native endianness.
+     * Convert back to little-endian only when writing data to guest memory via
+     * dma_memory_write().
+     */
+    cmd[0] = le64_to_cpu(cmd[0]);
+    cmd[1] = le64_to_cpu(cmd[1]);
+
     switch (extract64(cmd[0], 60, 4)) {
     case AMDVI_CMD_COMPLETION_WAIT:
         amdvi_completion_wait(s, cmd);
-- 
2.47.3


