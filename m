Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61027CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkTA-0003UH-HW; Wed, 17 Jun 2026 03:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkT5-0003Tt-DQ; Wed, 17 Jun 2026 03:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkT3-000600-KE; Wed, 17 Jun 2026 03:13:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmfBu2746770; Wed, 17 Jun 2026 07:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YPOkva
 kNnFpbhL5tfEV2NAqN7efM3ebQ2v16CDO+ly8=; b=i52fCwceaRCx4sAeE8iqR4
 7wuYuQagnZpDc4m/TW4DVrHhZOqsaEXxvoDKdnVN4BU514M17gsbFQwOg64VWyyZ
 NC+mPBqeX2CEBCVQZ/ZJWaR/5vlJxY/FfXk0rw2h6KQ8Bu2+Z6BuFEMtNZhMfmXG
 y66dR/vyM7cTp+0A7koJjXzCyl5VZulPDao7N30v979LhKpb2HNXVEqI/JtjMOsX
 YRrcb4ko3Jlvbesj2XoYmdTrPwckMx+zSlpIl48inythWLb88Wx+S1ww3BiJiWjj
 9+/+AvA0w7LYt3EtLxNHWiM1Sspk3c9m9HOoJRszorYfW2yZdAsrKOKP10O8pSzg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqthpqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:13:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74drS012583;
 Wed, 17 Jun 2026 07:13:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva20je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:13:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7DXDi56885542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:13:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55C315803F;
 Wed, 17 Jun 2026 07:13:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6294E5805A;
 Wed, 17 Jun 2026 07:13:28 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:13:28 +0000 (GMT)
Message-ID: <4fd22724-a0d7-441f-bb41-4adbfeac74ba@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:43:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] pnv/phb4: Implement IODA PCT table
To: Jishnu Warrier <jishnuvw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-9-saif.abrar@linux.vnet.ibm.com>
 <wphhqba6a5d73fcvxsfk47gonvxobpn2ba6v4zj7xshhlp3msi@zvm2luq7gv2g>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <wphhqba6a5d73fcvxsfk47gonvxobpn2ba6v4zj7xshhlp3msi@zvm2luq7gv2g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uc84JY_XItSgCemuKqcVnC-far1zP5yR
X-Proofpoint-GUID: -CPezphM2reppwzxOeFD8T6XmPZTuSMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX/2G3x9vEs7Ay
 CkVMKcBqVyQjcgxmJsnvpU2aulm8iDZtxWBtewm8zi/dqS+vmAS14CNK9C3eOfL0UXX3LmrXH4x
 dFfFsIa2SLVGzTYSeLPJALPC63gUKoRgn8CSb0u77zfpiXg2dqvU/7+pdMYx2YKzI1+xGiWywfg
 hCIiD/MSkADzMYTs+e5aDKu0flzr2RhtKifWtrPyMHStQYjv13lxDjr+522pYIjL1HwwwTwCup0
 8cTAJ5NGm6k94vywKJL0R/0cGymfQmoGFWcB/aA/Eg+qLHUuHh0lcTRbEghd5cBq7bXljhWBtYm
 iCqs6kSwv6irlwqLAjm/Gkv9lNY3YWxHcEGOVX7kSogPKKfY7F5Dhx+fS/GjsXX6xgoLb5eM3cf
 xztEta9D+sY7YYE0YdV1zFGMinhHtRDYoJIZXjLUe0J8e2HAJSOorIIQgbUyVi8tzPYSWjEj72U
 l9W/s1Ajglqm0+CxCcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXwqeOQ20DQnRn
 bUhlKT0opOhcxNjL3hQ4dqC91x28NYBGMoSYq/oG0TK+gZaiLEY6Xv+9zeG4R8endNRPXcwIdG3
 NKo/Om2UN04vsRYDw1MStV/npACzqwM=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a32491f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=oaL83f0BrliydTA493kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 11-05-2026 12:54, Jishnu Warrier wrote:
> On Thu, Mar 05, 2026 at 12:09:10AM -0600, Saif Abrar wrote:
>> IODA PCT table (#3) is implemented
>> without any functionality, being a debug table.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> v3: Updates for coding guidelines.
>>
>>   hw/pci-host/pnv_phb4.c              | 6 ++++++
>>   include/hw/pci-host/pnv_phb4.h      | 2 ++
>>   include/hw/pci-host/pnv_phb4_regs.h | 1 +
>>   3 files changed, 9 insertions(+)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index a6fa578e85..254bbe4089 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -264,6 +264,10 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>>           mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>>           mask -= 1;
>>           break;
>> +    case IODA3_TBL_PCT:
>> +        tptr = phb->ioda_PCT;
>> +        mask = 7;
> According to PHB5 spec (lines 13568-13580):
> - Small PHB: 64 entries (mask should be 63)
> - Big PHB: 128 entries (mask should be 127)
> - Each entry has 2 parts, so total is 128/256


Updated.


>
>> +        break;
>>       case IODA3_TBL_RCAM:
>>           mask = phb->big_phb ? 127 : 63;
>>           break;
>> @@ -362,6 +366,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>>       /* Handle side effects */
>>       switch (table) {
>>       case IODA3_TBL_LIST:
>> +    case IODA3_TBL_PCT:
>> +        /* No action for debug tables */
>>           break;
>>       case IODA3_TBL_MIST: {
>>           /* Special mask for MIST partial write */
>> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
>> index bea0684724..6bb75edeef 100644
>> --- a/include/hw/pci-host/pnv_phb4.h
>> +++ b/include/hw/pci-host/pnv_phb4.h
>> @@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
>>   #define PNV_PHB4_MAX_LSIs          8
>>   #define PNV_PHB4_MAX_INTs          4096
>>   #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
>> +#define PNV_PHB4_MAX_PCT           128
> Question: Is PCT table 8 or 128 entries? Check PHB5 spec.
> - If 8 entries: mask=7 is correct
> - If 128 entries: mask should be 127


Updated.


>
> Thanks,
> Jishnu
>
>>   #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>>   #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>>   #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
>> @@ -138,6 +139,7 @@ struct PnvPHB4 {
>>       /* On-chip IODA tables */
>>       uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>>       uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
>> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>>       uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>>       uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>>       uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
>> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
>> index c1d5a83271..e30adff7b2 100644
>> --- a/include/hw/pci-host/pnv_phb4_regs.h
>> +++ b/include/hw/pci-host/pnv_phb4_regs.h
>> @@ -486,6 +486,7 @@
>>   
>>   #define IODA3_TBL_LIST          1
>>   #define IODA3_TBL_MIST          2
>> +#define IODA3_TBL_PCT           3
>>   #define IODA3_TBL_RCAM          5
>>   #define IODA3_TBL_MRT           6
>>   #define IODA3_TBL_PESTA         7
>> -- 
>> 2.47.3
>>
>>

Thanks,

Saif



