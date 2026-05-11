Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BC5CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ9q-0003XM-6e; Mon, 11 May 2026 08:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wMNET-0006rs-6W; Mon, 11 May 2026 05:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wMNDu-0002tN-Jk; Mon, 11 May 2026 05:47:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B3KmHH2971544; Mon, 11 May 2026 08:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DtX9Z+
 n8tmC9AGbEF45RaMWrzAE+YFssGdOOKs9RU+I=; b=JNvZ495wvgYceWYkLVmku+
 gTibSs8AMkdLg/TGgkM5pF7RMGLYtQvVS1axnVDKHfrBJvXJ8S6UFwClbOogFWcN
 vWvIyIsJGWy0ffIHVeLcl5li8+Ld6kyUS0I3MBlHzYFk4xM3bkm1fjnrVuUMBndT
 adnW2tXRhMQDJne1b0SLd8Hq/L8K4vbTW7Fh2OrKRQHhcdd3pp6DCLcoKOw2Op8/
 8u6UQDMbuhmLI6KOEaJu3owv0B+/Slemy6wF95721qh6TABq4OJ/5zYgrFKLd2uK
 /KAKyTcMOHMhttPgHHS+ESXENYdGURvk5yTg0mQZy0rrfXn9621+6UGpnba182RA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhq4hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 08:46:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B8dQKQ028824;
 Mon, 11 May 2026 08:46:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvvj71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 08:46:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B8kWsa13959546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 08:46:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FD0320040;
 Mon, 11 May 2026 08:46:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC06A20043;
 Mon, 11 May 2026 08:46:28 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com (unknown
 [9.123.4.46]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 May 2026 08:46:28 +0000 (GMT)
Date: Mon, 11 May 2026 14:16:04 +0530
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
Subject: Re: [PATCH v4 9/9] pnv/phb4: Mask off LSI Source-ID based on number
 of interrupts
Message-ID: <auxjiykky33cggvrgi7jbeaaje3qo6szmtiilpgfs6dnbbolc5@zejcua7lpp5x>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01976d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kUKHeS9f1dJEPYFD:21 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=uR97zm7AlWmegDsLJL8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: Nzo_qIA_mR3nyropNkOfp1IlGjoFmsTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5NCBTYWx0ZWRfX9xNjGkCwMmb/
 bbVWLfGDF0XqPLZ92EdL/wzr9v8lVuU9eKp9G8E6aPay8UnwJOphIF1zpLSzfmsocCn9chArMLD
 t5NYtVsQnUEmhvIgG2X+omujQF5IjqAH+V+IBbkt2jHmnCqx51MeZZ7K6cZ/bBvG6bK2rE0tMVG
 T4cW1rRrIrF6z18CAJhettQWLty1YkTkb5Sn5wu4Dza8Jzt9UelscjBFZ9jzS4zQ7gIDdT+8Crw
 kFloX3yu8V5bb7T8YV6m3NieB66VyinzICENvYWJsLR3VjMcz6P5E+Iv0kYuaDTxt4M+1SNXAZd
 My0Mekb+7axTRmfqhLje7oQLuPExP9Yyi7yiuVaVZjosAFbN4HWX+gQdneIVjf9QZGlp3QKmb5M
 N+EraGQ07fiFAJ9yeWSSe9KpVD7XlmfyC396NDHubwatJHU+aiB86JJF84N14jyyY8wbdwabCav
 +eLeGPj9UWj3rCspahQ==
X-Proofpoint-GUID: ebwgWl7pOmutu74KESqBB5vo5ZyGgmXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 08:54:08 -0400
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

On Thu, Mar 05, 2026 at 12:09:11AM -0600, Saif Abrar wrote:
> Add a method to reset the value of LSI Source-ID.
> Mask off LSI source-id based on number of interrupts in the big/small PHB.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v3: Updates for coding guidelines.
> v2: Introduced method pnv_phb4_xsrc_reset().
> 
>  hw/pci-host/pnv_phb4.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 254bbe4089..5e885cb89d 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -490,6 +490,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>  
>      lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>      lsi_base <<= 3;
> +    lsi_base &= (xsrc->nr_irqs - 1);
>  
>      /* TODO: handle reset values of PHB_LSI_SRC_ID */
>      if (!lsi_base) {
> @@ -1944,6 +1945,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
>      /* TODO: Add more RO-masks as regs are implemented in the model */
>  }
>  
> +static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
> +{
> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);

If I am not wrong, according to PHB5 spec page 104, the LSI Source ID field should be bits 3-15:
    PPC_BITMASK(3, 15)  // 0x1FF8000000000000ULL
03:12 LSI Source ID(00:09)
RW

13:15 LSI Source ID(10:12)
R0

> +    pnv_phb4_update_xsrc(phb);
> +}
> +
>  static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>  {
>      STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> @@ -2000,10 +2007,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>      PnvPHB4 *phb = PNV_PHB4(obj);
>  
>      pnv_phb4_pbl_core_reset(phb);
> +
> +    pnv_phb4_xsrc_reset(phb);
>      pnv_phb4_err_reg_reset(phb);
>      pnv_phb4_pcie_stack_reg_reset(phb);
>      pnv_phb4_regb_err_reg_reset(phb);
> -    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
>  }
>  
>  static void pnv_phb4_instance_init(Object *obj)
> @@ -2080,8 +2088,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pnv_phb4_update_xsrc(phb);
> -
>      phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>  
>      pnv_phb4_xscom_realize(phb);
> -- 
> 2.47.3
> 
> 

