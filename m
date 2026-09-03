Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366CDC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AjY-0007G9-PZ; Thu, 03 Sep 2026 12:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AjX-0007FX-BD; Thu, 03 Sep 2026 12:56:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AjV-00010K-Ab; Thu, 03 Sep 2026 12:56:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2U8L1550086; Thu, 3 Sep 2026 16:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aGT32xZE0k6peeQXQHR/3nXBShSCKd
 an56GEE73uRIk=; b=G0tICn9V9D2A4uYsrouxrhtlyyI8qn99FQoo5D+XjpLSW4
 EpoINDGAmKofl/F8qJ/xt8CNM9DaVAT9qQR569int3X31BTlra7tjGCNU4WMoHzN
 7t69S7DZD3zbN2jHu7fSOM+QLlOL2SoxRrv4mniNPDs4hu0fgfV0KKt5QXYybEFs
 9wLz2vs4Qg+5t1osJ/5SPsrgAdmqCwh+3w/3vWfiGic7o/hb/vx7/5y8q4H6Oux/
 RKONtSXlDpM3II8bKQwLQdYDb36p0gSXLuYYGJNEKXS40Q8if6Sd9FGNZ3rC/45J
 ppt5Qsp01UkBFPSFRX6PhlYGWBfLU8xIyStl2PTQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rp0mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:56:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfFdm005065;
 Thu, 3 Sep 2026 16:56:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceygceg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:56:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Gu6oM29164232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:56:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9395758045;
 Thu,  3 Sep 2026 16:56:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2856358050;
 Thu,  3 Sep 2026 16:56:05 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:56:05 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------nidNI5ciQc9MUkjksZQ0ffFk"
Message-ID: <5dfae470-ef39-4da9-9b9a-8f234778f243@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:56:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] pnv/phb5: Set link speed and width in the DLP
 training control register
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-8-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-8-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99a6a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=8JQTLegwssLe5hOjMUwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-b7IsxyX4n235a3dhHEA:9 a=KLHU48CUfVdxmT04:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfXx8Rmu0zz52+K
 7KNKcGUFgZ3CVX+6ynjGhyYi2euifjhDCJnhC3uT67ezE32P4Rd9OK+zzXIBHnB7T9I/PEsM3DR
 xrt/LAi7GVYfVyAYL7WS+szp2SwcTQTJ0Mip5cMl7VgzRT8HWgXCAwBYOB4OERFfALiK4vttKxW
 rIiJwsagGhFkFocPfWAZon8CCY0MLDEpU6UJcqsOzY9df5ugeUyQgWGx15n/a34EgnJcNB3wcn6
 DF5gF6aBFkUncNaMK5vEmk2ln1czIyBluqhY86PXp0UDZ08lrRCN7kw5myuj4SSynUq19KakXkX
 PZf96hpEYBBroOhEVmo2+2Q+1hlphEL8qD5fb4JXeAif3nwWhoRnotf1cfbNQXZG1EnbS2/zRE3
 fkvCiirbs1ffWr48sNYJKf61ucvSKiPl1dYPljXl5R80O4sG6w2T/l7INiRqYjjShbgSsNXjHrE
 cCb9nWPun3hXX6qoYSw==
X-Proofpoint-GUID: Td_8sMqRfS_FXeZ915nWB6DxgXoiZQie
X-Proofpoint-ORIG-GUID: KqSmQtH6Y98SoG23o1MM9_oPXJfItpz2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX8m6BpfbgQPv2
 pmUMbIJYGQJXr3ry4TFV7UIEP6HYG9Kly2Mr+I6HEF9PDYqiWRm1EwmLqHMsCuIAILxWLkNegqn
 u93TRYwTBCdHvQQ+7LZ9fHB2pEnpL48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
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
--------------nidNI5ciQc9MUkjksZQ0ffFk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> Get the current link-status from PCIE macro.
> Extract link-speed and link-width from the link-status
> and set in the DLP training control (PCIE_DLP_TCR) register.
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater<clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 87446aedc8..56952a6200 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -518,7 +518,7 @@ static uint32_t is_link_active(PnvPHB4 *phb)
>       PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>       uint32_t exp_offset = get_exp_offset(pdev);
>   
> -    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
> +    return (be32_to_cpu(pnv_phb4_rc_config_read(phb,
>                           exp_offset + PCI_EXP_LNKSTA, 4)) &
>                           PCI_EXP_LNKSTA_DLLLA);
>   }
> @@ -865,6 +865,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>       uint32_t exp_base = get_exp_offset(pdev);
>       uint64_t val;
> +    uint32_t v, lnkstatus;
>   
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>           return pnv_phb4_config_read(phb, off & 0x3, size);
> @@ -926,10 +927,27 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>           break;
>   
> -    /* Link training always appears trained */
>       case PHB_PCIE_DLP_TRAIN_CTL:
> -        /* TODO: Do something sensible with speed ? */
> +        /* Get the current link-status from PCIE */
> +        lnkstatus = be32_to_cpu(pnv_phb4_rc_config_read(phb,
> +                                exp_base + PCI_EXP_LNKSTA, 4));
> +
> +        /* Extract link-speed from the link-status */
> +        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
> +
> +        /* Link training always appears trained */
>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +
> +        /* Set the current link-speed at the LINK_SPEED position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
> +
> +        /*
> +         * Extract link-width from the link-status,
> +         * after shifting the required bitfields.
> +         */
> +        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +        /* Set the current link-width at the LINK_WIDTH position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
>           return val;
>   
>       /*
> @@ -952,7 +970,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>            * convert the value back to host format.
>            * Clear the Presence-status active low bit.
>            */
> -        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
> +        if (be32_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
>                                                   4))
>                       & PCI_EXP_SLTSTA_PDS) {
>               val &= ~PHB_PCIE_HPSTAT_PRESENCE;
--------------nidNI5ciQc9MUkjksZQ0ffFk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
      cite="mid:20260831123005.1485518-8-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a>
Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
Reviewed-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/pci-host/pnv_phb4.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 87446aedc8..56952a6200 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -518,7 +518,7 @@ static uint32_t is_link_active(PnvPHB4 *phb)
     PCIDevice *pdev = pci_find_device(pci-&gt;bus, 0, 0);
     uint32_t exp_offset = get_exp_offset(pdev);
 
-    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+    return (be32_to_cpu(pnv_phb4_rc_config_read(phb,
                         exp_offset + PCI_EXP_LNKSTA, 4)) &amp;
                         PCI_EXP_LNKSTA_DLLLA);
 }
@@ -865,6 +865,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     PCIDevice *pdev = pci_find_device(pci-&gt;bus, 0, 0);
     uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
+    uint32_t v, lnkstatus;
 
     if ((off &amp; 0xfffc) == PHB_CONFIG_DATA) {
         return pnv_phb4_config_read(phb, off &amp; 0x3, size);
@@ -926,10 +927,27 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        lnkstatus = be32_to_cpu(pnv_phb4_rc_config_read(phb,
+                                exp_base + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        v = lnkstatus &amp; PCI_EXP_LNKSTA_CLS;
+
+        /* Link training always appears trained */
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+        /* Set the current link-speed at the LINK_SPEED position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
+
+        /*
+         * Extract link-width from the link-status,
+         * after shifting the required bitfields.
+         */
+        v = (lnkstatus &amp; PCI_EXP_LNKSTA_NLW) &gt;&gt; PCI_EXP_LNKSTA_NLW_SHIFT;
+        /* Set the current link-width at the LINK_WIDTH position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
         return val;
 
     /*
@@ -952,7 +970,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
          * convert the value back to host format.
          * Clear the Presence-status active low bit.
          */
-        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+        if (be32_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
                                                 4))
                     &amp; PCI_EXP_SLTSTA_PDS) {
             val &amp;= ~PHB_PCIE_HPSTAT_PRESENCE;
</pre>
    </blockquote>
  </body>
</html>

--------------nidNI5ciQc9MUkjksZQ0ffFk--


