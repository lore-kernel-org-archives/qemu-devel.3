Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57438606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UKtD75Ig
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUJgO-0008I1-64; Fri, 20 Nov 2026 03:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xUJgM-0008Hj-M2; Fri, 20 Nov 2026 03:09:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xUJgK-0008JG-Hl; Fri, 20 Nov 2026 03:09:18 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uP3D866230; Fri, 20 Nov 2026 08:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Lx6QsQyIncKAF0gmfBPK06erXYeM4GUb797gT722o
 kA=; b=UKtD75IgcWDNyT4KCu8R8PCYC1h4smUb04b8BhT+pQ7dL4OlliCxdoyja
 RrKfNvl4cZWqMa4cD7KLb90qldlonbKPgMVZpGIe6kwff7NixGeCNsBnKxEU1KT1
 ibA4DrbRUmjhD580WfsO4gAF1i6z56s/lCoYkDfLEpSZMUMqq+BrIa/tzGOAdnUH
 56sdDy8mMrV+5AaGDEVMJqHebRPOCAFeSSpCVc8r5+OSHW2wVEc+S5cZI5O4xS4H
 Zj2rfAIfwzRitUS7FVh+0EcHVO9OLWUZqcSetW9enTB346iQN8I0RahSSIukxxhB
 jRs4TrXmkC/lWXJo44/tMWvhLHZlw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ry1qn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 08:09:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7o5EH2242255; Fri, 20 Nov 2026 08:09:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd71kk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 08:09:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK899Oc29295358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 08:09:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BEA658055;
 Fri, 20 Nov 2026 08:09:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F6DB5804B;
 Fri, 20 Nov 2026 08:09:05 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.99.15]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 08:09:05 +0000 (GMT)
From: Utkarsh Verma <uverma@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH] spapr: nested: Check guest state buffer len in H_GUEST_{GET,
 SET}_STATE
Date: Fri, 20 Nov 2026 13:38:29 +0530
Message-ID: <20261120080829.195131-1-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ui35ym3_F5tA-Ht1DU6bpn3WUw4a9YTm
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6b000028 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=SRXESuUPhoGB5Ax0YtUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX+NebX7bEnWkP
 YbqX35TZWeB/Z8cVynKtlTVMBZX0qjkBJmlQsx6xIj5mAlxi3mHBCqYaKRemj2YJhPdo0VtkKL8
 Na5uuAQDlUfFvQqoDZy2s8Rhcp1xsYc=
X-Proofpoint-ORIG-GUID: wGbrJ9LuJWwsybBN9dtCKfKg0WeGqlBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfXyIvBwnSSpdYb
 NDl0GdFnnLiOqppnsjQyaHrAvmJdqxnDjVXz6zCuQRX5Kvn8PryGqg3vNH5tjKrU9CeGGU0f2ae
 wM2MbhMJ0gu++s6Q4fgxHrN3DhNADr+OK9EUxxZjruX+pSBW6faJR0agtXrEKuP7DVrW3UlEmvy
 Yvzr8KQ6+6+7a0bL7b9Zix8+NpCzFgqNKNnqOh2pBS+AqW7dxvoe8vfzouxm+YQ/8G9UldunTYC
 68QtsefzuI4GvI9HOW2xTE/xm+YJSAvlaPYD79QvfcXXYjVuUEk5JOF3VTUSSD79EUazlXagNg6
 uUjuIw4pekw5DB6++E3yEGLrPPgtTFnqXVnd08EneKrFZsuMzh0jhWgl9/i3JfMJYfWN19cuLx8
 U0agx1o5P75ULl1qfAGWWs50I30n3p+RAaHmu9jPbBs3VHudLbP4nLyDgsEgoE0HcPZwoyJ40k+
 yx6KYW7kCVUvkAGitdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add validations to check for guest state buffer length before accessing
the fields to avoid out of bound memory reads.

Also, replace the assertions for invalid arguments with proper return
error codes and fix the return error codes at other places as well
(return code H_P4 for buf and H_P5 for buflen)

Fixes: 64c43909b297 ("spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4741
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/spapr_nested.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 10cf634da1..8b981fff14 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1117,7 +1117,9 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
     uint16_t id, size;
 
     /* gsb->num_elements = 0 == 32 bits long */
-    assert(len >= 4);
+    if (len < sizeof(gsb->num_elements)) {
+        return false;
+    }
 
     num_elements = be32_to_cpu(gsb->num_elements);
     element = gsb->elements;
@@ -1126,6 +1128,9 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
     /* Walk the buffer to validate the length */
     while (num_elements) {
 
+        if (len < offsetof(struct guest_state_element, value)) {
+            return false;
+        }
         id = be16_to_cpu(element->id);
         size = be16_to_cpu(element->size);
 
@@ -1133,7 +1138,7 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
             log_element(element, gsr);
         }
         /* buffer size too small */
-        if (len < 0) {
+        if (len < offsetof(struct guest_state_element, value) + size) {
             return false;
         }
 
@@ -1464,7 +1469,7 @@ static target_ulong getset_state(SpaprMachineState *spapr,
     lenleft = gsr->len;
 
     if (!guest_state_request_check(gsr)) {
-        return H_P3;
+        return H_P4;
     }
 
     num_elements = be32_to_cpu(gsr->gsb->num_elements);
@@ -1516,12 +1521,12 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
     gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
                                  is_write, MEMTXATTRS_UNSPECIFIED);
     if (!gsr->gsb) {
-        rc = H_P3;
+        rc = H_P4;
         goto out1;
     }
 
     if (len != gsr->len) {
-        rc = H_P3;
+        rc = H_P4;
         goto out1;
     }
 
@@ -1546,7 +1551,9 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
     SpaprMachineStateNestedGuest *guest = NULL;
 
     gsr.buf = buf;
-    assert(buflen <= GSB_MAX_BUF_SIZE);
+    if (buflen > GSB_MAX_BUF_SIZE) {
+        return H_P5;
+    }
     gsr.len = buflen;
     gsr.flags = 0;
 
-- 
2.55.0


