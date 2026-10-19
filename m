Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B868606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GeHUY8LT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqCT-0002GM-U3; Mon, 19 Oct 2026 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCA-00021y-SR; Mon, 19 Oct 2026 12:26:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqBu-0001Tn-Ov; Mon, 19 Oct 2026 12:26:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiXb4123280; Mon, 19 Oct 2026 16:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SYthdHRl4BKS5rjNc
 MD1xIptLcBF/00aeZ4kph6MpLA=; b=GeHUY8LT4aXDN7YcDrWj9evnWR7nWTfLj
 GW9CvIC0AhS549+FArmuyGhIGKQasjP3eCeDObtibZ3FJ8kdObt8u+k7doO52s2w
 9gSvOnP1K2PdRrQmRVE0TclAstTTc1KETsWcbSIJDaiXu195iHEXIA8XGprTUDMA
 IVXb65iiP6LU0Kw5/Kxp3X3LOW38IG83ws+S2VgfwCXjFzN3At/KxHXfpZdzEoWh
 flhHmu+iFRdNaJXtw0NGsNTAzUUD1+54MWpjyvvtGklXTbwQ74sgjPQR2+Fnfd5a
 QAgxD7dD5Y3Fww2N+tpj+BQRyv7iEnirA92RvRwYBssKsZ1Q7ApWg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h5ccrh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ5ct081542; Mon, 19 Oct 2026 16:26:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjxgcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQDqd39911750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCB6220043;
 Mon, 19 Oct 2026 16:26:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10E5B20040;
 Mon, 19 Oct 2026 16:26:09 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:26:08 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
Date: Mon, 19 Oct 2026 21:55:36 +0530
Message-ID: <20261019162541.68440-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfXw4rBBu3a283/
 MFRsHy89ooy9voTl5nTNisHc7TRU1QD4paG//dxHkBDOYKK6ig2dvhRftnjBCDzodrcgew2uIP3
 kBilaMW1vgkxQOt2QY/8utTPmDhZTDw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX6WRhPMB8/oGu
 x5P0YQYUnFkkKSpeqVOzm4tbZaXLTGaw87dJbkh5CAaEh4ms8G3tOq+afuWdnWzGtu4Wp9v99kt
 u8L3nlyXCKEhT4B0AzgRQoXdsS1dg+WR7eZ1YsQWlpoqVO6AJxA/6HCqDBVZCo54hUBKw2LkPHz
 l+Id+7PuU5iYErrbRjzlRagwjIcmF2bKaraB3qY12t8WXPUoFTpi0iBIKAaGqshdlqof+iUX+jU
 +P/97dnCbN1dWTl3xGDmFAvVZGezIGSeiGtT4wTU9RYAGC+cRSPu1YUDxaCSEB6+vn7v4GJZoST
 AwCffjoNiNwRuOaHOHixRGQxSmLz4NrHo9aUPfQmmW5P7rsjq2l76CeRfuvcF5GM2Bkyvo65c4A
 8+X/Tlq3UJtmVDEeJJSw0PFsjI6wjLkxuflZBT0F0+m+y/A1LW0/p6DRJrWaOL8fttBeZch4fl9
 DhjKEaT51QAJfd+aqoA==
X-Proofpoint-ORIG-GUID: hORIlvMbFKtpO5WykDpOkVhvI6dJ2JiM
X-Proofpoint-GUID: z-Z5zI7zvkb7vLynEgfwHmVHNAyneqhF
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad644b1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ckvBqbd_4HPzd86GAI0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the 'ibm,errinjct' RTAS call for PHB-level PCI error injection
via firmware.  The handler decodes the RTAS parameter buffer, validates
arguments, selects the target PHB by BUID, and delegates the injection
to the VFIO EEH backend.

IOA bus-error injection (types 0x7 and 0xF) is fully supported:
  - The BUID field in the RTAS parameter block selects the target PHB
    via spapr_pci_find_phb();
  - For addr != 0 or mask != 0 the guest BAR address is translated to
    the corresponding host resource base address before calling the VFIO
    backend.  Translation matches the guest BAR layout under the
    selected PHB, computes offset = guest_addr - guest_bar, reads the
    host sysfs resource file for the matching BAR, and yields
    host_addr = host_bar + offset.
  - For addr == 0 and mask == 0 translation is skipped and zero
    addr/mask are forwarded directly (powerpc-utils errinjct -a 0 -m 0).

Non-IOA error types (corrupted-page, dcache, icache, tlb,
recovered-special-event) are decoded and validated, then rejected with
RTAS_OUT_NOT_SUPPORTED because their RTAS work buffers do not carry a
BUID, making safe VFIO PHB/PE selection impossible.

The translation helpers added to spapr_pci_vfio.c:
  - spapr_phb_vfio_translate_errinjct_addr() - public entry point
  - spapr_vfio_errinjct_find_bar_cb()        - per-device BAR scan
  - spapr_vfio_errinjct_get_host_bar()       - host sysfs BAR reader

config_addr is retained as a logging/debug parameter only; PHB
selection relies on BUID.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
 include/hw/pci-host/spapr.h |  11 ++
 include/hw/ppc/spapr.h      |   3 +
 hw/ppc/spapr_pci.c          | 135 ++++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c     | 203 ++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 24109409f4..492f66e1ef 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -127,6 +127,10 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
 int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
                             uint32_t func, uint64_t addr, uint64_t mask);
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr);
 #else
 static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
@@ -159,6 +163,13 @@ static inline int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
 {
     return RTAS_OUT_NOT_SUPPORTED;
 }
+static inline int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                                         uint32_t config_addr,
+                                                         uint64_t guest_addr,
+                                                         uint64_t *host_addr)
+{
+    return -ENOTSUP;
+}
 #endif
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 253dc0e862..47791c71bd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -274,6 +274,9 @@ struct SpaprMachineState {
     bool fadump_registered;
     bool fadump_dump_active;
     FadumpMemStruct registered_fdm;
+
+    /* ibm,errinjct session token (0 = no session open) */
+    uint32_t errinjct_token;
 };
 
 #define H_SUCCESS         0
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f7fc544d35..fa555f1092 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -704,6 +704,138 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static int spapr_errinjct_parse_ioa_bus_error(target_ulong param_buf,
+                                              bool is_64bit,
+                                              uint64_t *addr, uint64_t *mask,
+                                              uint32_t *config_addr,
+                                              uint64_t *buid, uint32_t *func)
+{
+    if (is_64bit) {
+        *addr        = ((uint64_t)rtas_ld(param_buf, 0) << 32) |
+                       rtas_ld(param_buf, 1);
+        *mask        = ((uint64_t)rtas_ld(param_buf, 2) << 32) |
+                       rtas_ld(param_buf, 3);
+        *config_addr = rtas_ld(param_buf, 4);
+        *buid        = ((uint64_t)rtas_ld(param_buf, 5) << 32) |
+                       rtas_ld(param_buf, 6);
+        *func        = rtas_ld(param_buf, 7);
+    } else {
+        *addr        = rtas_ld(param_buf, 0);
+        *mask        = rtas_ld(param_buf, 1);
+        *config_addr = rtas_ld(param_buf, 2);
+        *buid        = ((uint64_t)rtas_ld(param_buf, 3) << 32) |
+                       rtas_ld(param_buf, 4);
+        *func        = rtas_ld(param_buf, 5);
+    }
+    return RTAS_OUT_SUCCESS;
+}
+
+/*
+ * Non-IOA RTAS error types (page corrupt, dcache, icache, tlb, special
+ * event) are validated but not supported for VFIO injection.  VFIO EEH
+ * is PE/PHB-scoped and those work buffers do not carry a BUID, so QEMU
+ * cannot select the right VFIO container safely.
+ */
+static void spapr_errinjct_return_non_ioa_unsupported(target_ulong rets)
+{
+    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+}
+
+static void rtas_ibm_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                              uint32_t token, uint32_t nargs,
+                              target_ulong args, uint32_t nret,
+                              target_ulong rets)
+{
+    SpaprPhbState *sphb = NULL;
+    target_ulong param_buf;
+    uint64_t addr = 0, mask = 0, buid = 0;
+    uint64_t inject_addr = 0;
+    uint32_t config_addr = 0;
+    uint32_t func = 0;
+    uint32_t type, o_token;
+    bool is_64bit;
+    int ret;
+
+    if (nargs != 3 || nret != 1) {
+        goto param_error_exit;
+    }
+
+    type    = rtas_ld(args, 0);
+    o_token = rtas_ld(args, 1);
+    param_buf = rtas_ld(args, 2);
+
+    if (!param_buf) {
+        goto param_error_exit;
+    }
+
+    if (!spapr->errinjct_token || o_token != spapr->errinjct_token) {
+        goto param_error_exit;
+    }
+
+    switch (type) {
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+        is_64bit = (type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64);
+        ret = spapr_errinjct_parse_ioa_bus_error(param_buf, is_64bit,
+                                                 &addr, &mask,
+                                                 &config_addr, &buid, &func);
+        if (ret != RTAS_OUT_SUCCESS) {
+            goto param_error_exit;
+        }
+        break;
+
+    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
+        spapr_errinjct_return_non_ioa_unsupported(rets);
+        return;
+
+    default:
+        goto param_error_exit;
+    }
+
+    /* IOA path: BUID selects the target PHB */
+    if (!buid) {
+        goto param_error_exit;
+    }
+
+    sphb = spapr_pci_find_phb(spapr, buid);
+    if (!sphb) {
+        error_report("ibm,errinjct: no PHB for BUID=0x%016" PRIx64, buid);
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    inject_addr = addr;
+
+    /*
+     * addr=0, mask=0 means a non-address-scoped IOA injection.  This
+     * matches powerpc-utils errinjct -a 0 -m 0 behaviour; skip translation
+     * and forward addr/mask as zero.
+     */
+    if (addr || mask) {
+        ret = spapr_phb_vfio_translate_errinjct_addr(sphb, config_addr,
+                                                     addr, &inject_addr);
+        if (ret) {
+            rtas_st(rets, 0, ret == -EOPNOTSUPP ? RTAS_OUT_NOT_SUPPORTED
+                                                 : RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+    }
+
+    ret = spapr_phb_vfio_errinjct(sphb, type, func, inject_addr, mask);
+    rtas_st(rets, 0, ret);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2380,6 +2512,9 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_SLOT_ERROR_DETAIL,
                         "ibm,slot-error-detail",
                         rtas_ibm_slot_error_detail);
+    spapr_rtas_register(RTAS_IBM_ERRINJCT,
+                        "ibm,errinjct",
+                        rtas_ibm_errinjct);
 }
 
 static void spapr_pci_register_types(void)
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index b151e9138c..fe89fb4ca3 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -318,6 +318,201 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_SUCCESS;
 }
 
+typedef struct SpaprVFIOErrinjctBarMatch {
+    uint64_t guest_addr;
+
+    PCIDevice *pdev;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    uint64_t guest_bar_start;
+    uint64_t bar_size;
+    uint64_t offset;
+} SpaprVFIOErrinjctBarMatch;
+
+static VFIOPCIDevice *spapr_vfio_errinjct_pci_to_vfio(PCIDevice *pdev)
+{
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI)) {
+        return NULL;
+    }
+
+    return container_of(pdev, VFIOPCIDevice, parent_obj);
+}
+
+static void spapr_vfio_errinjct_find_bar_cb(PCIBus *bus,
+                                            PCIDevice *pdev,
+                                            void *opaque)
+{
+    SpaprVFIOErrinjctBarMatch *ctx = opaque;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    if (ctx->pdev) {
+        return;
+    }
+
+    vdev = spapr_vfio_errinjct_pci_to_vfio(pdev);
+    if (!vdev) {
+        return;
+    }
+
+    for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+        pcibus_t guest_bar_start;
+        uint64_t bar_size;
+        uint64_t offset;
+
+        bar_size = vdev->bars[bar].region.size;
+        if (!bar_size) {
+            continue;
+        }
+
+        guest_bar_start = pci_get_bar_addr(pdev, bar);
+        if (guest_bar_start == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+
+        if (ctx->guest_addr < guest_bar_start ||
+            ctx->guest_addr - guest_bar_start >= bar_size) {
+            if (vdev->bars[bar].mem64) {
+                bar++;
+            }
+            continue;
+        }
+
+        offset = ctx->guest_addr - guest_bar_start;
+
+        ctx->pdev = pdev;
+        ctx->vdev = vdev;
+        ctx->bar = bar;
+        ctx->guest_bar_start = guest_bar_start;
+        ctx->bar_size = bar_size;
+        ctx->offset = offset;
+
+        return;
+    }
+}
+
+static int spapr_vfio_errinjct_get_host_bar(VFIOPCIDevice *vdev,
+                                            int bar,
+                                            uint64_t *host_bar_start)
+{
+    g_autofree char *path = NULL;
+    g_autofree char *contents = NULL;
+    char *line;
+    char *saveptr = NULL;
+    unsigned long long start;
+    unsigned long long end;
+    unsigned long long flags;
+    int i;
+
+    if (!vdev || !host_bar_start || bar < 0 || bar >= PCI_STD_NUM_BARS) {
+        return -EINVAL;
+    }
+
+    /*
+     * Read the host Linux sysfs resource file for the BAR.  Do not use a
+     * VFIO PCI config-space read because that may return the
+     * guest-programmed BAR value rather than the host resource address.
+     */
+    path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%u/resource",
+                           vdev->host.domain,
+                           vdev->host.bus,
+                           vdev->host.slot,
+                           vdev->host.function);
+
+    if (!g_file_get_contents(path, &contents, NULL, NULL)) {
+        error_report("vfio/eeh errinjct: failed to read %s", path);
+        return -ENOENT;
+    }
+
+    line = strtok_r(contents, "\n", &saveptr);
+
+    for (i = 0; line; i++, line = strtok_r(NULL, "\n", &saveptr)) {
+        if (i != bar) {
+            continue;
+        }
+
+        if (sscanf(line, "%llx %llx %llx", &start, &end, &flags) != 3) {
+            error_report("vfio/eeh errinjct: malformed %s BAR%d",
+                         path, bar);
+            return -EINVAL;
+        }
+
+        if (!start || end < start) {
+            error_report("vfio/eeh errinjct: invalid host resource BAR%d "
+                         "start=0x%llx end=0x%llx flags=0x%llx",
+                         bar, start, end, flags);
+            return -EINVAL;
+        }
+
+        *host_bar_start = start;
+        return 0;
+    }
+
+    return -EINVAL;
+}
+
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    PCIHostState *phb;
+    SpaprVFIOErrinjctBarMatch ctx = {
+        .guest_addr = guest_addr,
+        .pdev       = NULL,
+        .vdev       = NULL,
+        .bar        = -1,
+    };
+    uint64_t host_bar_start;
+    int rc;
+
+    if (!sphb || !host_pci_bus_addr) {
+        return -EINVAL;
+    }
+
+    phb = PCI_HOST_BRIDGE(sphb);
+
+    /*
+     * BUID has already selected @sphb before this helper is called.
+     * config_addr is retained for logging/debug only.  Do not rely on it
+     * to find the target device; some RTAS IOA buffers may not carry a
+     * valid guest BDF-style config address.  Scan VFIO BARs under this
+     * PHB and match guest_addr against the guest BAR layout instead.
+     */
+    pci_for_each_device_under_bus(phb->bus,
+                                  spapr_vfio_errinjct_find_bar_cb,
+                                  &ctx);
+
+    if (!ctx.pdev) {
+        error_report("vfio/eeh errinjct: guest addr 0x%" PRIx64
+                     " not within any VFIO BAR under BUID=0x%016" PRIx64
+                     " config_addr=0x%08x",
+                     guest_addr, sphb->buid, config_addr);
+        return -ENODEV;
+    }
+
+    rc = spapr_vfio_errinjct_get_host_bar(ctx.vdev, ctx.bar, &host_bar_start);
+    if (rc) {
+        error_report("vfio/eeh errinjct: failed to get host BAR%d for "
+                     "dev=%s BUID=0x%016" PRIx64 " config_addr=0x%08x rc=%d",
+                     ctx.bar, ctx.pdev->name, sphb->buid, config_addr, rc);
+        return rc;
+    }
+
+    if (host_bar_start == ctx.guest_bar_start) {
+        error_report("vfio/eeh errinjct: refusing guest BAR as host BAR: "
+                     "dev=%s BAR%d guest_bar=0x%" PRIx64
+                     " host_bar=0x%" PRIx64,
+                     ctx.pdev->name, ctx.bar,
+                     ctx.guest_bar_start, host_bar_start);
+        return -EOPNOTSUPP;
+    }
+
+    *host_pci_bus_addr = host_bar_start + ctx.offset;
+    return 0;
+}
+
 static int spapr_vfio_errinjct_rtas_type_to_vfio(uint32_t rtas_type)
 {
     switch (rtas_type) {
@@ -430,4 +625,12 @@ int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
     return RTAS_OUT_NOT_SUPPORTED;
 }
 
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    return -ENOTSUP;
+}
+
 #endif /* CONFIG_VFIO_PCI */
-- 
2.51.1


