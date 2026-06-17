Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF3ECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjit-0005jr-N2; Wed, 17 Jun 2026 02:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjip-0005it-79; Wed, 17 Jun 2026 02:25:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjin-0004k7-O2; Wed, 17 Jun 2026 02:25:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnbqP2619764; Wed, 17 Jun 2026 06:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/PUoow
 iZnqjp79sRONRh8aKn36y5mVf79U4RaHJKO6k=; b=LOJtWW4ffWFt+KFGZ87tWs
 3YC1EqgfjqSB4OauanhEkw57paCv57fnZmlTi+KJ0hbHg/Fuvoemc3oY+hEWxKX9
 bhfXWZtW5TziwjXGhXm3IVkCRXWefuZEqEqBwWN5MRZ7x+kKdNHQkvPDJr24Zofa
 SkiPmRWmly6ajEfKfj7Tz7ZPkdWLosmm882S32XG2t67J3PG8GvSTwK5VkgTSPeS
 C2JsSFQHdwwbGB0pVf/m/+zIGwdQwWiJvD7GilRD2MAxC01rhrPT01dX7D4eGoJz
 Zx5EtoCqYBwA4tdS0EtW7EHAEvSTlAmIIzfIHL6Y3/cIRHGy3bFuiTvFQgCxnqYw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx1gje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:25:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6Jbse010099;
 Wed, 17 Jun 2026 06:25:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva1u12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:25:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6Pk9222807268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:25:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBFA15805A;
 Wed, 17 Jun 2026 06:25:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22CA25803F;
 Wed, 17 Jun 2026 06:25:41 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:25:40 +0000 (GMT)
Message-ID: <c0373fa4-a055-4a24-b342-262da461e722@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:55:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pnv/phb4: Implement read-only and write-only bits
 of registers
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-5-saif.abrar@linux.vnet.ibm.com>
 <af9JzTz4HyuPBSnH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9JzTz4HyuPBSnH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mISG-qq51a4xP5sVizy3HY3UaJ2n18pU
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a323ded cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Wnv0t7zpA1xbfcmHcygA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX60Ry3WgP+oSp
 +3ecVQ1fdR8j2vdC2enE4JtukQORaPSAct7UaWnnIEEf2uMV1Wc5mzfD4tZ/WJPeCPfFiAeYAI1
 +O/y9Vh656Uv3SCNjolRVP8qsN7NdMM=
X-Proofpoint-ORIG-GUID: ZPT3ECje5jGKKzOhfefercYbeepwtSMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfXyP4Zfvbzmz+r
 ozVV5R4XQCWrzPfa58Edm+8+6soKJ83yn9lHo2Ik4uqgFoHlfpLZxrKO6AmiBQCVBb5ylrh+U8u
 uTRjhuvOr9ra+HhCyhlTTefhT0Q0XcfXjeNyQmZvPyYp9xZTDEYQ0fQblYbZGu0jY9oMu+wMJtY
 NydC71PemwMgEX8eQ0Xd2J8RwbwQnVFnWmTOglscdyQUVY35FhqT9+QCSohceYMuowvCnpw4ZQD
 KFj1Sz5GVTF7+pf+1kB8NDNEsdVs65jIdaP0DIHDHH4P3UIGSadO4v6wQekn/AduwqnHnCEUVOB
 C6tcfLzICwhfkdn16qsevcM2albSmDcMHUfNK6JEmBGcU0vsK25sPsuhDmnjl/Jvl7MK0hRBpFY
 spULwR4a1XdtL1CpYUDGM/uPGJtFXUeMr5mNMr0mNDC7C+Wlu48HHy2AVBW0KMiOYHQc2vpmgtl
 ddlAPPVzXI3hdAkc6XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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


On 09-05-2026 20:24, Aditya Gupta wrote:
> nice functionality !


Thanks -)


>
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>> +    /*
>> +     * DMA sync: make it look like it's complete,
>> +     *           clear write-only read/write start sync bits.
>> +     */
>> +    case PHB_DMA_SYNC:
>> +        val = PHB_DMA_SYNC_RD_COMPLETE |
>> +            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
>> +        return val;
>> +
>> +    /*
>> +     * PCI-E Stack registers
> nit: s/Stack registers/System Config Register/ ?


This is meant to be a heading for the various sets of registers that follow.


>
>> +     */
>> +    case PHB_PCIE_SCR:
>> +        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>> +        break;
>> +
>>       /* Link training always appears trained */
>> <...snip...>
>> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
>> index 419f34987a..2078fab9a9 100644
>> --- a/tests/qtest/pnv-phb4-test.c
>> +++ b/tests/qtest/pnv-phb4-test.c
>> @@ -73,7 +73,8 @@ static void phb4_sticky_rst_test(QTestState *qts)
>>        * Sticky reset test of PHB_PBL_ERR_STATUS.
>>        *
>>        * Write all 1's to reg PHB_PBL_ERR_INJECT.
>> -     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
>> +     * RO-only bits will not be written and
>> +     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
>>        *
>>        * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
>>        * Verify the sticky bits are still set.
>> @@ -81,7 +82,59 @@ static void phb4_sticky_rst_test(QTestState *qts)
>>       PHB4_XSCOM_WRITE(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
>>       PHB4_XSCOM_WRITE(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
>>       val = PHB4_XSCOM_READ(PHB_PBL_ERR_STATUS);
>> -    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
>> +    g_assert_cmpuint(val, ==, 0xF00DFD8E00);
> instead of this hardcoded value, can it be PPC_BITMASKs as previously
> used ?


Using PPC_BITMASK now.


>
> - Aditya G


Thanks,

Saif



