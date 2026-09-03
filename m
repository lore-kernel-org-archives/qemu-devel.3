Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48FCC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Aj3-0006w6-5C; Thu, 03 Sep 2026 12:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Aj1-0006vl-LM; Thu, 03 Sep 2026 12:55:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Aiz-0000i2-9d; Thu, 03 Sep 2026 12:55:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2RT53425633; Thu, 3 Sep 2026 16:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Pj6cI73SdgcCvvOrnHpcV2qjTR5MdX
 r+YfbquU7WBnM=; b=iapabOHmeO7wO8A9+IxHHpffY4rSsxXScH51jGZf6LTi1Z
 N6wP8ufZOSx8bhrjgONosdHLcpIQFmNCWNlkJ0fvW3hPltF0D3DUCRuf1ex5xZso
 b7US0qPGtNCcTwd38jCF/0kKc7njPg2QAInDIJz9979AebbjOVPlbC98l6FDQvsT
 yJbZAafZsQeYB1AqbWUZ6llJGCNIcYSiBiwzr3bvZaEkbsgL6icoppEOCaa79qkM
 Cu6AKNXBtaWMd23YpXh8hXyrT+3oSXLQhNzsCCD4l6I289gkcy6kN0TxJk7rntZW
 Vuit0oIfcbOXkcVKUIrXQDNuQ2EpH5oSaeMwIBYQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq5562tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:55:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfRvJ009727;
 Thu, 3 Sep 2026 16:55:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjarxyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:55:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GtSIh22020654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:55:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EFBD58052;
 Thu,  3 Sep 2026 16:55:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C21D358045;
 Thu,  3 Sep 2026 16:55:26 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:55:26 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------6WlApM1jo3ZeqRQPRPNhVNon"
Message-ID: <631db855-f13e-4dce-85cd-f5d06992e234@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:55:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX5/MQNMmMBcXi
 jkm7bWm9dKWXe/5ezzXS5gekWWftCDD2tPNj/p2VnQDOA6BW3lbc4fRSIEI07t76m8Qwpp0DCKs
 nTKRIj4H8GJaD1YEKYqcwuLubhFI4tTzYJuKclLZ0vhS4XKqZWr0hrr0YcZM97Y53YS4Fkg34+E
 pQZ7xz4WIfK4marfhAdsY3QFFsMCfNdRuYZXm80D/z7F7sKNR2FJyPUlnZ3G5HfgMkatHIUXSjf
 zzDXvnc0o1y4jr9+VnA4RbioHiM6CvXfpgbUX0zN+rOXr6SpqAsLmjy1aKKFkMOdv2TUtuveJ7H
 haHzAGcjRmaNm8fuQtbT8O5yM6QtqC21ZoRunUZweeNSXCVZFUqxi+EUbehvjQtFyKlIY0DKxO6
 UWID24SjQt69+US0Ty3ED2HluDsLdvrw4NYXfmZFzMcXuoiVp2L3fBlTLHepAiigxSxv0IREbWc
 7FkSJN0xtaP56b6LfCQ==
X-Proofpoint-ORIG-GUID: jYUxG8fZle4G6yrCgeBwAj368QZkqS97
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99a683 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=4oHMkCvJoxaUTQewvasA:9 a=QEXdDO2ut3YA:10
 a=0d8h__MqJP2C2wASEJEA:9 a=MUOrzm19kOOhfgvR:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: PZit26jtzFzLz71TtX7ydtewYhBlUDvQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX5Cs2+L5Of+Rp
 j2A7YeWkh1AsDZEMFP60Pomt1GLBDgpfIBs7aD/UAAhp2LBdb1DZClJO8EMzUzr1oVWiyxNk6/O
 2kYHJ4YPgDKqcfGy5DaO4Ga50KXyQ/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------6WlApM1jo3ZeqRQPRPNhVNon
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> Config-read the link-status register in the PCI-E macro,
> Depending on the link-active bit, set the link-active status
> in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
> Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
> after config-reading the slot-status in the PCI-E macro.
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c | 74 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index b13165f84d..87446aedc8 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -508,6 +508,34 @@ uint32_t get_exp_offset(PCIDevice *pdev)
>       return rpc->exp_offset;
>   }
>   
> +/*
> + * Config-read the link-status register in the PCI-E macro,
> + * convert to LE and check the link-active bit.
> + */
> +static uint32_t is_link_active(PnvPHB4 *phb)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_offset = get_exp_offset(pdev);
> +
> +    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
> +                        exp_offset + PCI_EXP_LNKSTA, 4)) &
> +                        PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +/*
> + * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
> + * RC-config space values and masks are LE.
> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
> + * Compute new value in LE domain.
> + * New value computation using sticky-mask is in LE.
> + * Convert the computed value from LE to BE before writing back.
> + */
> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
> +    (pci_set_word(conf + (a), be16_to_cpu( \
> +                     (be16_to_cpu(pci_get_word(conf + (a))) & (s)) | \
> +                     ((v) & ~(s)))))
> +
>   void pnv_phb4_cfg_core_reset(PCIDevice *d)
>   {
>       uint8_t *conf = d->config;
> @@ -680,6 +708,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           val = 0;
>           break;
>   
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* For normal operations, Simspeed diagnostic bit is always zero */
> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
> +        break;
> +
>       /* Read only registers */
>       case PHB_CPU_LOADSTORE_STATUS:
>       case PHB_ETU_ERR_SUMMARY:
> @@ -827,6 +860,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>   uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>   {
>       PnvPHB4 *phb = PNV_PHB4(opaque);
> +    /* Get the PCI-E capability offset from the root-port */
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_base = get_exp_offset(pdev);
>       uint64_t val;
>   
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> @@ -895,8 +932,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
>           return val;
>   
> +    /*
> +     * Read PCI-E registers and set status for:
> +     * - Card present (active low bit 10)
> +     * - Link active  (bit 12)
> +     */
>       case PHB_PCIE_HOTPLUG_STATUS:
> -        /* Clear write-only bit */
> +        /*
> +         * Presence-status bit hpi_present_n is active-low, with reset value 1.
> +         * Start by setting this bit to 1, indicating the card is not present.
> +         * Then check the PCI-E register and clear the bit if card is present.
> +         */
> +        val |= PHB_PCIE_HPSTAT_PRESENCE;
> +
> +        /*
> +         * Config-read the PCI-E macro register for slot-status.
> +         * Method for config-read converts to BE value.
> +         * To check actual bit in the PCI-E register,
> +         * convert the value back to host format.
> +         * Clear the Presence-status active low bit.
> +         */
> +        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
> +                                                4))
> +                    & PCI_EXP_SLTSTA_PDS) {
> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
> +        }
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
> +        }
> +
> +        /* Clear write-only resample-bit */
>           val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
>           return val;
>   
> @@ -904,6 +971,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       case PHB_PCIE_LMR:
>           /* These write-only bits always read as 0 */
>           val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_LMR_LINKACTIVE;
> +        }
>           return val;
>   
>       /* Silent simple reads */
--------------6WlApM1jo3ZeqRQPRPNhVNon
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK
</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/31/2026 7:30 AM, Saif Abrar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260831123005.1485518-7-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

Config-read the link-status register in the PCI-E macro,
Depending on the link-active bit, set the link-active status
in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
after config-reading the slot-status in the PCI-E macro.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a>
Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
Reviewed-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/pci-host/pnv_phb4.c | 74 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index b13165f84d..87446aedc8 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -508,6 +508,34 @@ uint32_t get_exp_offset(PCIDevice *pdev)
     return rpc-&gt;exp_offset;
 }
 
+/*
+ * Config-read the link-status register in the PCI-E macro,
+ * convert to LE and check the link-active bit.
+ */
+static uint32_t is_link_active(PnvPHB4 *phb)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb-&gt;phb_base);
+    PCIDevice *pdev = pci_find_device(pci-&gt;bus, 0, 0);
+    uint32_t exp_offset = get_exp_offset(pdev);
+
+    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+                        exp_offset + PCI_EXP_LNKSTA, 4)) &amp;
+                        PCI_EXP_LNKSTA_DLLLA);
+}
+
+/*
+ * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
+ * RC-config space values and masks are LE.
+ * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
+ * Compute new value in LE domain.
+ * New value computation using sticky-mask is in LE.
+ * Convert the computed value from LE to BE before writing back.
+ */
+#define RC_CONFIG_STICKY_RESET(a, v, s) \
+    (pci_set_word(conf + (a), be16_to_cpu( \
+                     (be16_to_cpu(pci_get_word(conf + (a))) &amp; (s)) | \
+                     ((v) &amp; ~(s)))))
+
 void pnv_phb4_cfg_core_reset(PCIDevice *d)
 {
     uint8_t *conf = d-&gt;config;
@@ -680,6 +708,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         val = 0;
         break;
 
+    case PHB_PCIE_HOTPLUG_STATUS:
+        /* For normal operations, Simspeed diagnostic bit is always zero */
+        val &amp;= PHB_PCIE_HPSTAT_SIMDIAG;
+        break;
+
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
     case PHB_ETU_ERR_SUMMARY:
@@ -827,6 +860,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    /* Get the PCI-E capability offset from the root-port */
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb-&gt;phb_base);
+    PCIDevice *pdev = pci_find_device(pci-&gt;bus, 0, 0);
+    uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
 
     if ((off &amp; 0xfffc) == PHB_CONFIG_DATA) {
@@ -895,8 +932,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
         return val;
 
+    /*
+     * Read PCI-E registers and set status for:
+     * - Card present (active low bit 10)
+     * - Link active  (bit 12)
+     */
     case PHB_PCIE_HOTPLUG_STATUS:
-        /* Clear write-only bit */
+        /*
+         * Presence-status bit hpi_present_n is active-low, with reset value 1.
+         * Start by setting this bit to 1, indicating the card is not present.
+         * Then check the PCI-E register and clear the bit if card is present.
+         */
+        val |= PHB_PCIE_HPSTAT_PRESENCE;
+
+        /*
+         * Config-read the PCI-E macro register for slot-status.
+         * Method for config-read converts to BE value.
+         * To check actual bit in the PCI-E register,
+         * convert the value back to host format.
+         * Clear the Presence-status active low bit.
+         */
+        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+                                                4))
+                    &amp; PCI_EXP_SLTSTA_PDS) {
+            val &amp;= ~PHB_PCIE_HPSTAT_PRESENCE;
+        }
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
+        }
+
+        /* Clear write-only resample-bit */
         val &amp;= ~PHB_PCIE_HPSTAT_RESAMPLE;
         return val;
 
@@ -904,6 +971,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     case PHB_PCIE_LMR:
         /* These write-only bits always read as 0 */
         val &amp;= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_LMR_LINKACTIVE;
+        }
         return val;
 
     /* Silent simple reads */
</pre>
    </blockquote>
  </body>
</html>

--------------6WlApM1jo3ZeqRQPRPNhVNon--


