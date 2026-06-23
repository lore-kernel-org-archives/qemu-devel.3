Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCACDB480
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7yq-0003Au-7b; Tue, 23 Jun 2026 16:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7yj-000370-WA; Tue, 23 Jun 2026 16:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7yi-0005dd-CD; Tue, 23 Jun 2026 16:44:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NKJMXl2997122; Tue, 23 Jun 2026 20:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V1t3eO
 lcu74M5q8jvnijZmNEFLe3ycCrkMJKKN51eBg=; b=DDhhbgSDxiqIoWvHkBTXYk
 WSES7EG5hD5MNIUaM5shW70X3WEr3wbEvvaRXWbKIdqTgxRT2YA9MpDa96l8sRk8
 c72k2qSCDcuBLw+AVWpBSpUTWCUYHE+rDx+Ejid/tByz/itdJgwFTz74sGPBWlNh
 ab3/Cqto8LHZwy7BfaLJWXG0qAiWcOmBq5CqsE5A9kw6qcBfuKlXrMafQsRJtBZt
 kW63Yq5+HvsY6btgO3y1Ym+rAuU/9vw92PjyCvVrWkf/UYhqWiSCrzpJ8xXYfx7Z
 +AxRi+E8t5nnX5uy/DFr1RfDyNU/mtfHG9D5HSXsqe0fMx6kMVSIMWFHfvavONlw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hs2fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:44:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NKYe0U028340;
 Tue, 23 Jun 2026 20:44:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k5ch4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:44:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NKiACX51315124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 20:44:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A39F5805A;
 Tue, 23 Jun 2026 20:44:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87D4458054;
 Tue, 23 Jun 2026 20:44:08 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 20:44:08 +0000 (GMT)
Message-ID: <cde69365-631c-4e60-a5df-bd82f470415b@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:44:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] pnv/phb5: Implement IODA PCT table
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-9-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-9-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8wXWmVTNhpE_LjsUonvgQ4QprazXe_Yw
X-Proofpoint-GUID: Q5t0z0HUyY0bx-Sr-YYfSdSbmVkxsYHO
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3af01d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=ZHIH-Mn1CJ9f4S4TJ0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfX0BiEOOzZjreu
 wPy4pcWQTgQfelQpzIdNGfWYk0JsO8lyd2n4b0lTGzbhDoHHaTNK3HTjBkaTleyyXhLyTocTg4g
 CYwQ+KxCaUkCdeDr1iwU11hiecKyKNfFxI5+veuupDRKFm0Cc5XI0zXTDUGBBYHOkgmwCUV3ZnX
 MfYtBt07IfLobqqFfcsE/Cf1skfh6qIrXntx2TTwDmonsGb9Uz1nZSLqzwN8NViBnuwE5tayT0l
 BYofj21kq65RjNDbyuWLenD2zHqmtB7m8hQdoVoWAaALm+Wi0E9C7HHjQpi6dseWudT7cghKsLh
 jELD285ff+tKO1n0KnGKi3shnWnwmkV3tg4VrxJV5Phb4LmELePNYXix/bSICKWjOe1Z2MgUbFM
 mseuJMRv3C4XYgSzCr0Zy6PJE88A4Dh5EmSzlw6sUFSxk1outrE8b58vUwXnXtQnT1RuLIKf3o3
 U5BMKgHEnMGwcNXlvPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfX/9KRX5bPiQeE
 to/g2Ioc5rbrFodQI13WZgzhhS3xVluI/EigxRIfq7GMfPjEma5/TeS39fBumVtekPk2ANmPjd5
 iJE3HI+cvYGzcm0iUdj6YmQukBuBhTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230167
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 6/17/26 4:50 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> IODA PCT table is implemented
> without any functionality, being a debug table.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5: Updated IODA3 PCT table max size to 128 * 2 entries each.
> v3: Updates for coding guidelines.
> 
> 
>  hw/pci-host/pnv_phb4.c              | 7 +++++++
>  include/hw/pci-host/pnv_phb4.h      | 2 ++
>  include/hw/pci-host/pnv_phb4_regs.h | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index e9d9323dba..91b2064113 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -264,6 +264,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>          mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>          mask -= 1;
>          break;
> +    case IODA3_TBL_PCT:
> +        tptr = phb->ioda_PCT;
> +        mask = phb->big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT >> 1);
> +        mask -= 1;
> +        break;
>      case IODA3_TBL_RCAM:
>          mask = phb->big_phb ? 127 : 63;
>          break;
> @@ -362,6 +367,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>      /* Handle side effects */
>      switch (table) {
>      case IODA3_TBL_LIST:
> +    case IODA3_TBL_PCT:
> +        /* No action for debug tables */
>          break;
>      case IODA3_TBL_MIST: {
>          /* Special mask for MIST partial write */
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index bea0684724..b7e15b87d1 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
>  #define PNV_PHB4_MAX_LSIs          8
>  #define PNV_PHB4_MAX_INTs          4096
>  #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
> +#define PNV_PHB4_MAX_PCT           (128 * 2)
>  #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>  #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>  #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
> @@ -138,6 +139,7 @@ struct PnvPHB4 {
>      /* On-chip IODA tables */
>      uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>      uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>      uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>      uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>      uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index c1d5a83271..e30adff7b2 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -486,6 +486,7 @@
>  
>  #define IODA3_TBL_LIST          1
>  #define IODA3_TBL_MIST          2
> +#define IODA3_TBL_PCT           3
>  #define IODA3_TBL_RCAM          5
>  #define IODA3_TBL_MRT           6
>  #define IODA3_TBL_PESTA         7


