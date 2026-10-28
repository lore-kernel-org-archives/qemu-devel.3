Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AX6lYuA5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5f-0003Sp-Ee; Wed, 28 Oct 2026 01:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5d-0003Sg-MV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5c-0005xI-1N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4iKJm307023
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VxTQIr6/v8p/1XNjk
 q/JDTf7kIDF6NXQERFVJ7N0oWk=; b=AX6lYuA5lElJdJg7R5bHh7zmbN7N/vS7Q
 hHFrksNi6jD3+wOQsFL8aQ+Y81PaJRv6WCDUiHAgl1SuA4nKwF3luliAJktunPdO
 fDLSvGZx4vqmksCfaiSiNBDpgv4TYrEHGbby2HZm//8S5pkwXYARf75jx5iHtgGi
 6llaMKRLfS5AKDJediiT4Ns7I2yZYEzoQukS4otan/LbbzFBrfQ5NYeWAVkNmG8k
 fvot1I2iQn/g8EWoDr46ucOV47rpayFPnVUleXU/3XUEZ5T6Z/JLAARo1mFnbewq
 WUkkdsGPrqwwvP8qE8MughyN2tHycR5yQyYMS+3ytsumBbNQsIQbA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavjkte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4Yvsq1030468
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7uuy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5Kcmi52167044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0A8120040;
 Wed, 28 Oct 2026 05:20:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0AEE2004B;
 Wed, 28 Oct 2026 05:20:37 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:37 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 1/6] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
Date: Wed, 28 Oct 2026 10:50:19 +0530
Message-ID: <20261028052024.38377-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae1862b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=cZ2jSh9J2h8rrMqNVj0A:9
X-Proofpoint-GUID: C9hq_dZqK1U7zkHAPWAdsFy6m0xZ9Jul
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX7lI0GNAOoBxb
 mTE07nH8c0V2KMz1/BXMs+Emxk6E58W1j2xBT4JV5dsjOn6mqWD1Izv1Kw4yBgLHyzslYiDgKHT
 zBQvke0+xwRs+v703glLqhg8uOwvPnY=
X-Proofpoint-ORIG-GUID: C9hq_dZqK1U7zkHAPWAdsFy6m0xZ9Jul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX3bUM9/s83ckp
 K3+4r4RBtWpZ/lJndrkuz1lnfkXy9HvnQVUXPfai8K4CsDTvrJszFulvoC3+aq7AJNENkDB5LC1
 QQNgex/goweFYt5rK0+dYV9l9jGPA/d0LZfHxFERZbxN7US7mDkxKz/ur8daaMeyulgbUs5juDr
 JYx2ZWAypbZZ1Qjg0rb0Ji2M5S5bjIVf2Y2OQjx3pgE2ZXKj4VAcF9vrAHiXB67wmQXWMFcC5wm
 N4vM7zcy2L/0EkpdSPA0GIp/L+Yj306WFP1lPGdiT5ujlDboQQSfxATotS/t83Bk1BOcyCOCbc3
 5wBmfHrESFN+SutEAPeAL9CM3kuu7AZoLifju03+yZrwsjgroV5ViYJMFQKvvTFyIxcuIce/LJr
 LYTPcsY41YYCDjmLas76KZAxGxJjHXx73k/lyHC29VWXhX9Icq/iq2JMh67dgzBkc1XJAls+RO7
 TkpEvoDzXkM2ANDD1gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

A guest-triggerable assertion crash (DoS) exists in pnv_phb4_config_write()
and pnv_phb4_config_read(). When a guest performs an 8-byte access to
PHB_CONFIG_DATA (offset 0x130), QEMU aborts because the switch(size)
statement in the config accessors only handles 1, 2, and 4-byte accesses,
hitting g_assert_not_reached() in the default case.

Since guest input is untrusted, an invalid access size should not crash
the host. Fix this by adding a size > 4 guard in pnv_phb4_reg_write() and
pnv_phb4_reg_read() before the config accessor calls, and by replacing
the g_assert_not_reached() in pnv_phb4_config_write() and
pnv_phb4_config_read() with phb_error() to cover any other callers.
Invalid reads now return ~0ull, maintaining PCI conventions.

Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3591
Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260805090530.1333997-1-nikhilks@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9acaf4c0c2..ac09a0b034 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -84,7 +84,9 @@ static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
         val = bswap32(val);
         break;
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config write size %u at offset 0x%x\n",
+                  size, off);
+        return;
     }
     pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
 }
@@ -119,7 +121,9 @@ static uint64_t pnv_phb4_config_read(PnvPHB4 *phb, unsigned off,
     case 4:
         return bswap32(val);
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config read size %u at offset 0x%x\n",
+                  size, off);
+        return ~0ull;
     }
 }
 
@@ -507,6 +511,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 
     /* Special case outbound configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config write size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return;
+        }
         pnv_phb4_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -644,6 +653,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config read size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return ~0ull;
+        }
         return pnv_phb4_config_read(phb, off & 0x3, size);
     }
 
-- 
2.52.0


