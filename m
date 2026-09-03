Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DC8C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AfL-00046g-4a; Thu, 03 Sep 2026 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AfJ-00046B-Hx; Thu, 03 Sep 2026 12:51:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AfH-0007Qz-EA; Thu, 03 Sep 2026 12:51:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2TIU1549988; Thu, 3 Sep 2026 16:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=C0l3z/TnnTADgChAlfb4WCI+PoHhSV
 3ADRkSVhJLSZs=; b=e4iouZhJMeC951G5t8ZjZ700qbVDwMVVHgeIKnf4Kla+ej
 gDuhkABFnP62gqK/savZbxo8NA/O2yjw7NzFo29Ei/VC713RJaIhV6yBXuBzXKyj
 Mak+o8AjX+ClLCVqVZNML/2GOOSpo7zuIjQ16FZcivUk8ZO2HgWZKy0t0GSTxSE/
 ewK4P/qZtssLuhzg97SJJZJKFDyfvSiy3UbcIyys5uyyxVv+5t5fvDTf80m+7v5O
 gKEHE2VANFPXfk0wNsyPd4/i6CB3WOV07WYmTak9/1BK2GjWr0hjU7Xe+LqgFYTy
 wDZA3WKiJtXzyqPMpLaY1qVWVDUMN95/XCADQPaQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rnyrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:51:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfHir005089;
 Thu, 3 Sep 2026 16:51:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceygbnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:51:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Gphxb47513884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:51:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1F7E58052;
 Thu,  3 Sep 2026 16:51:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 516C958050;
 Thu,  3 Sep 2026 16:51:42 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:51:42 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ZXkN0onic7dXj9F9w2h5WXX0"
Message-ID: <cc44fa7d-1baa-4caf-b8a4-af6fe6f09930@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:51:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] pnv/phb5: Mask off LSI Source-ID based on number
 of interrupts
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-10-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-10-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99a5a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kUKHeS9f1dJEPYFD:21 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=BvYNoI8taEZLuYY2VggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-uQQ_z-csOHJncX4BtYA:9 a=6XvxXP7SyXwrUGsH:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX3tNkEA4DL72+
 /YUEkOb8WKt3nw1A84rkxMEWg+N+yMHTmzs2L4YzU0h88En++nOM5FlBb6TzO3rOPoXpSLW+O4f
 Oyx37PSGgFMr4OiFawViPYdPcRNi0eKgp06RPYssOTMSj0KWMP6u2yZ+AunPMO/u9kv8WarRUsR
 Rtv7Fo3mLoU7bu9bkg0JqEPQGr2udneu3qPExnPpNw3oFxqjJb9pkz7O29RZNCJokR5uZcgqoN/
 c9UUFpyClxVSlrsm5513oooGP0719rbirk2nIuHCwdSonLE3NTy5aN+zlhwFNHa9hAW4UeueQhO
 oMfmXFcJ07u6xSmwx1kiyj0M3jXlYpxEbPAUs93acMrWrxw9Ytos4i0wVJPblHxgm09R7ySqLcz
 tZOE029Bq5aaUsOJyzc5cbwxZU9nONatBLWxmoio1ll8R+/c28ldFwmxD5deq6JwdUv4E2G11eH
 gBrOLvIvbyFRbToV3wg==
X-Proofpoint-GUID: lGNk6G-RuQgeGNEf3jsd49bVqm7Cqacy
X-Proofpoint-ORIG-GUID: Lc6xaDtY1HMBGC40WSur_FCixtOtrLfp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX1qi3FdU25art
 t4PZJHVJbBmDzMXddUlCwNvYpun2eh8hEzigEWNdE8/FFjhXkuWluVL3Ac1EV6X6Dp3G48I6ALG
 oMxl0mGSVr0u1nK00HhVGblZ56WtjVg=
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
--------------ZXkN0onic7dXj9F9w2h5WXX0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> Add a method to reset the value of LSI Source-ID.
> Mask off LSI source-id based on number of interrupts in the big/small PHB.
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater<clg@kaod.org>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c         | 12 +++++++++---
>   hw/pci-host/pnv_phb5.c         | 17 -----------------
>   include/hw/pci-host/pnv_phb5.h | 10 ++++------
>   3 files changed, 13 insertions(+), 26 deletions(-)
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 5f84550a7c..362c9a039b 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -491,6 +491,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>   
>       lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>       lsi_base <<= 3;
> +    lsi_base &= (xsrc->nr_irqs - 1);
>   
>       /* TODO: handle reset values of PHB_LSI_SRC_ID */
>       if (!lsi_base) {
> @@ -1908,6 +1909,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
>       /* TODO: Add more RO-masks as regs are implemented in the model */
>   }
>   
> +static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
> +{
> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
> +    pnv_phb4_update_xsrc(phb);
> +}
> +
>   static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>   {
>       STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> @@ -1964,10 +1971,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>       PnvPHB4 *phb = PNV_PHB4(obj);
>   
>       pnv_phb4_pbl_core_reset(phb);
> +
> +    pnv_phb4_xsrc_reset(phb);
>       pnv_phb4_err_reg_reset(phb);
>       pnv_phb4_pcie_stack_reg_reset(phb);
>       pnv_phb4_regb_err_reg_reset(phb);
> -    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
>   }
>   
>   static void pnv_phb4_instance_init(Object *obj)
> @@ -2041,8 +2049,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    pnv_phb4_update_xsrc(phb);
> -
>       phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>   
>       pnv_phb4_xscom_realize(phb);
> diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
> index b09351f69f..ec6dfbe2b2 100644
> --- a/hw/pci-host/pnv_phb5.c
> +++ b/hw/pci-host/pnv_phb5.c
> @@ -6,24 +6,7 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> -#include "qemu/osdep.h"
> -#include "qemu/log.h"
> -#include "qemu/bswap.h"
> -#include "qapi/visitor.h"
> -#include "qapi/error.h"
> -#include "target/ppc/cpu.h"
> -#include "hw/pci-host/pnv_phb4_regs.h"
> -#include "hw/pci-host/pnv_phb4.h"
>   #include "hw/pci-host/pnv_phb5.h"
> -#include "hw/pci/pcie_host.h"
> -#include "hw/pci/pcie_port.h"
> -#include "hw/ppc/pnv.h"
> -#include "hw/ppc/pnv_xscom.h"
> -#include "hw/core/irq.h"
> -#include "hw/core/qdev-properties.h"
> -#include "qom/object.h"
> -#include "trace.h"
> -#include "system/reset.h"
>   
>   void pnv_phb5_cfg_core_reset(PCIDevice *d)
>   {
> diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
> index 4534083fd5..8f1df4892f 100644
> --- a/include/hw/pci-host/pnv_phb5.h
> +++ b/include/hw/pci-host/pnv_phb5.h
> @@ -9,12 +9,10 @@
>   #ifndef PCI_HOST_PNV_PHB5_H
>   #define PCI_HOST_PNV_PHB5_H
>   
> -#include "hw/pci-host/pnv_phb.h"
> -#include "hw/pci/pci_bus.h"
> -#include "hw/ppc/pnv.h"
> -#include "hw/ppc/pnv_nest_pervasive.h"
> -#include "hw/ppc/xive.h"
> -#include "qom/object.h"
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "hw/pci-host/pnv_phb4.h"
>   
>   void pnv_phb5_cfg_core_reset(PCIDevice *d);
>   
--------------ZXkN0onic7dXj9F9w2h5WXX0
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
      cite="mid:20260831123005.1485518-10-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

Add a method to reset the value of LSI Source-ID.
Mask off LSI source-id based on number of interrupts in the big/small PHB.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
Reviewed-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 hw/pci-host/pnv_phb4.c         | 12 +++++++++---
 hw/pci-host/pnv_phb5.c         | 17 -----------------
 include/hw/pci-host/pnv_phb5.h | 10 ++++------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 5f84550a7c..362c9a039b 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -491,6 +491,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb-&gt;regs[PHB_LSI_SOURCE_ID &gt;&gt; 3]);
     lsi_base &lt;&lt;= 3;
+    lsi_base &amp;= (xsrc-&gt;nr_irqs - 1);
 
     /* TODO: handle reset values of PHB_LSI_SRC_ID */
     if (!lsi_base) {
@@ -1908,6 +1909,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
     /* TODO: Add more RO-masks as regs are implemented in the model */
 }
 
+static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
+{
+    phb-&gt;regs[PHB_LSI_SOURCE_ID &gt;&gt; 3] = PPC_BITMASK(4, 12);
+    pnv_phb4_update_xsrc(phb);
+}
+
 static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
 {
     STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
@@ -1964,10 +1971,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
     PnvPHB4 *phb = PNV_PHB4(obj);
 
     pnv_phb4_pbl_core_reset(phb);
+
+    pnv_phb4_xsrc_reset(phb);
     pnv_phb4_err_reg_reset(phb);
     pnv_phb4_pcie_stack_reg_reset(phb);
     pnv_phb4_regb_err_reg_reset(phb);
-    phb-&gt;regs[PHB_PCIE_CRESET &gt;&gt; 3] = 0xE000000000000000;
 }
 
 static void pnv_phb4_instance_init(Object *obj)
@@ -2041,8 +2049,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pnv_phb4_update_xsrc(phb);
-
     phb-&gt;qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc-&gt;nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index b09351f69f..ec6dfbe2b2 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -6,24 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qemu/bswap.h"
-#include "qapi/visitor.h"
-#include "qapi/error.h"
-#include "target/ppc/cpu.h"
-#include "hw/pci-host/pnv_phb4_regs.h"
-#include "hw/pci-host/pnv_phb4.h"
 #include "hw/pci-host/pnv_phb5.h"
-#include "hw/pci/pcie_host.h"
-#include "hw/pci/pcie_port.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_xscom.h"
-#include "hw/core/irq.h"
-#include "hw/core/qdev-properties.h"
-#include "qom/object.h"
-#include "trace.h"
-#include "system/reset.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d)
 {
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
index 4534083fd5..8f1df4892f 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -9,12 +9,10 @@
 #ifndef PCI_HOST_PNV_PHB5_H
 #define PCI_HOST_PNV_PHB5_H
 
-#include "hw/pci-host/pnv_phb.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_nest_pervasive.h"
-#include "hw/ppc/xive.h"
-#include "qom/object.h"
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d);
 
</pre>
    </blockquote>
  </body>
</html>

--------------ZXkN0onic7dXj9F9w2h5WXX0--


