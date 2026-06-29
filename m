Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3208AC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9rV-0000kD-0K; Mon, 29 Jun 2026 07:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1we9rT-0000jo-F5; Mon, 29 Jun 2026 07:09:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1we9rR-0004Su-Ps; Mon, 29 Jun 2026 07:09:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmEp33030063; Mon, 29 Jun 2026 11:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Rk9Ey5
 Cfrt1ATPxVRuqIpf/Y+XGEbSyTbtEfMs8Z8gI=; b=A4+fF633CCBepFgaktqv7H
 0k+xr1Px01KO3Qan96U5BpMftDGbJp9ILzOqKMSEsQgKxUCAV4pYJjx5w8P4lhrp
 EULrM4Xufity07kGfbdR5CN1y2JnIxii3KT4nBucUn7OWD3Hf3LCy0zwg0TedlYd
 qdzbNFDAoa2ug+H0LgIjGUKGZgDOZcri14mxSXcghwncqGqX+FAuITSP9r1SVl00
 j8TdCsIjuSAy/uvdfIF2cr1s0JeVDzXKLg8TvOEoWp9H3NEr+jZCaBiyZPIbiY0Z
 BHWqMSziCrkBxb1hvhbw33e/jC0msdSpxxSBraEm5bd/IMFJ/Rf7sxm6nhWsvrqg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdrxt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:08:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TAnbfP001344;
 Mon, 29 Jun 2026 11:08:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq58sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:08:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TB8sj736438470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 11:08:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D540120049;
 Mon, 29 Jun 2026 11:08:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCC552004D;
 Mon, 29 Jun 2026 11:08:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jun 2026 11:08:50 +0000 (GMT)
Date: Mon, 29 Jun 2026 16:38:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 8/9] pnv/phb5: Implement IODA PCT table
Message-ID: <akIUewEy9NggkqKM@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-9-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617095058.652789-9-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 69oRHZOA4xMBDBOaxaGsVhsgXn2MnVJV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX0zWkW8Px+Okx
 gPmfRtt8oumng7zPginRSdLxc3Wkb0gDJd9kmDHmsVNHZTQpyZXa1VGzAU48gcdb2PWGHgRrhpq
 b2LwTNUXUdY2xXIyS1CEhl50hSTtQes=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a42524b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=ZHIH-Mn1CJ9f4S4TJ0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX5iQFK30K+U4j
 5oDJWDDiE2IOhhkfJe4BtFFOkMhMl9cFGsz2kbzxvxtvC46xrr6NZcLZSIY8MrFhxu586hXC05t
 cjU8fABCUJ1hmvcV+i3ZkBvSRIATRc8PA4+nEWOw6iXOin1xpN7Red4XzzYDDfFksMhdMlReRKQ
 h6oNYLwvYGWBMPxz8qhoMJOrZ71tx0QP97dCYRfQkI6IcnjtwbehDUSzH5tJbmkEWtySgPHktn3
 9Xq+EEL/6gOJaQ5v8VgmwDI1+gjsVMB6kDz593EIa6zNwbLn7yQgSw2o0mdsqMdRiNXEuRWy4oH
 6MHCnybYtjRJBzmyZcgsmvhfwm614yFDAqfhXBJl8xHSGdTGo0hLWIOWxlZDyXssQ1RQU1O4fhi
 PZ3ieBze/1XVbXSskdVavHwDk8EMVzloVWaHtXj8TsKhLOiVGeBg9VYjaE+bSwQEgursy3CY62m
 /8IMS8purYEFZYkROSg==
X-Proofpoint-ORIG-GUID: m1tgAblGo_jZL6rsemADWXUU5gOijeNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/06/17 04:50AM, Saif Abrar wrote:
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

PCT is a feature of PHB4, so looks okay in pnv_phb4.c

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G

> -- 
> 2.52.0
> 

