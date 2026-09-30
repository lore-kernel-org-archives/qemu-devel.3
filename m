Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BFACA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBv2f-00018p-E7; Wed, 30 Sep 2026 10:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2b-0000sR-MX; Wed, 30 Sep 2026 10:12:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2Z-0002EP-Vr; Wed, 30 Sep 2026 10:12:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5lCH3166832; Wed, 30 Sep 2026 14:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vB+xK7
 Ba5WiVGN6EqhU8fAPmW7/hxR48cE9gNyJBKpo=; b=jZyeYjL/DYBq8CPhNRAk66
 6YCztAMTom5W3fsswMvTaJOFnDHyteblyM00G5d4YT0SvqPueKOM23lvO4d6ILB9
 S3MJpMhmxoMhz1FIPMnEzf0kxUyGIg8gkLoAwecU3w/TqfaxUnjv95k8TVx50fUN
 YXK/ioL1gsZY8kGr9Obl4BoEbNucG6hjHmdJ3rffRZAlPA6eitdaDMos2vW1lWQm
 +LDoGLo0o2R8iaRyHPLcq7ECq4vT3bKmZPz5yGVZbknb7Kjb9l2Nz0Q7Lj5V24bg
 +8iKXlkfZqxP6bh/5LlWS8f/9XNNU5jxUMZBJ3Q2zUdysxfE//0Y829BuFUJUiRg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptcf84-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:11:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE354B3583582; Wed, 30 Sep 2026 14:11:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e4f5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:11:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEBqam25166586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:11:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3A4D58054;
 Wed, 30 Sep 2026 14:11:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 304635803F;
 Wed, 30 Sep 2026 14:11:51 +0000 (GMT)
Received: from [9.40.186.87] (unknown [9.40.186.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:11:51 +0000 (GMT)
Message-ID: <243c9dd9-3f14-4f2b-b3d5-29e4e2f1976e@linux.ibm.com>
Date: Wed, 30 Sep 2026 09:11:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] pnv/phb5: Set link speed and width in the DLP
 training control register
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-8-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-8-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qE7fABAWF3zClyGlUc9auH7DB7y-zeSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX9qyLVtxqSYEc
 VzV4y1aNiz8evUDx/DPT4rHu+yXl0/qqNAv23P6ThgtaZ0W12Xo+IpY58urQJa+nfn94veAGfTi
 t0uFjSG4ZtFsZ5RwYlGBh+8yeO/1+3iKurpgdNsfWF/iMcdLEMogXkyms/t2htdLVFB0FtVYLwE
 BROhB+Jm6fGPagPMN4lmhU/wv7QEdXmt/0xUJDNyMZVc5f5XeLmMD5gLdKCkNFCaWBz1vHnbjE2
 XrAlZXRgpY9HdQ9jh1vi6suKkwkoLT82JhiujYS/KTSx8UoEEbSlvybBLCoGSkrDQybFJ+Q7OYB
 Hm1/cJxnO8Cm8WqtHBYrgGweUrSfW68Gr3A/Kc8QE88quMZpJlmWoBLqT/gTv6tRw+4b0rPMH+I
 1IXBl3gm5RSJkPRpZy3omnQI0oSBMFEGnLqvAYP2pYWd73iHRMDsaCqG14C9J7yabc+0t2p/2xS
 rAsPE6PGM+0yAdoVQGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX+57d7hgp9BBV
 Qm6TyYXzM4VVin3wK4B6ENeghQSqCAFS0tPAJPnTkU27JIbtn1R/3o+ex3PVO85IsOBON0w9ciy
 jDQYPvaktaod7OA6xzUnIppiBD8/+Ug=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd18ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=02HBNwNuGvCHycWd1hMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: uerjFIAtsXbGHtm3lqu9VgGK7cFdGcZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300056
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

On 8/31/26 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> Get the current link-status from PCIE macro.
> Extract link-speed and link-width from the link-status
> and set in the DLP training control (PCIE_DLP_TCR) register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/pci-host/pnv_phb4.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 87446aedc8..56952a6200 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -518,7 +518,7 @@ static uint32_t is_link_active(PnvPHB4 *phb)
>      PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>      uint32_t exp_offset = get_exp_offset(pdev);
>  
> -    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
> +    return (be32_to_cpu(pnv_phb4_rc_config_read(phb,
>                          exp_offset + PCI_EXP_LNKSTA, 4)) &
>                          PCI_EXP_LNKSTA_DLLLA);
>  }
> @@ -865,6 +865,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>      uint32_t exp_base = get_exp_offset(pdev);
>      uint64_t val;
> +    uint32_t v, lnkstatus;
>  
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>          return pnv_phb4_config_read(phb, off & 0x3, size);
> @@ -926,10 +927,27 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>          val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>          break;
>  
> -    /* Link training always appears trained */
>      case PHB_PCIE_DLP_TRAIN_CTL:
> -        /* TODO: Do something sensible with speed ? */
> +        /* Get the current link-status from PCIE */
> +        lnkstatus = be32_to_cpu(pnv_phb4_rc_config_read(phb,
> +                                exp_base + PCI_EXP_LNKSTA, 4));
> +
> +        /* Extract link-speed from the link-status */
> +        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
> +
> +        /* Link training always appears trained */
>          val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
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
>          return val;
>  
>      /*
> @@ -952,7 +970,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           * convert the value back to host format.
>           * Clear the Presence-status active low bit.
>           */
> -        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
> +        if (be32_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
>                                                  4))
>                      & PCI_EXP_SLTSTA_PDS) {
>              val &= ~PHB_PCIE_HPSTAT_PRESENCE;


