Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF92C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMuu-0003YB-4g; Wed, 08 Jul 2026 03:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whMup-0003V4-69; Wed, 08 Jul 2026 03:41:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whMuh-0003sM-QB; Wed, 08 Jul 2026 03:41:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmDhm920448; Wed, 8 Jul 2026 07:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U6S+RJ
 VrFqiNdeijUMdVlHeyYLwuNKvbpRdy1hQSgFU=; b=JIrN7HLe+tgZL7IffZN+ne
 ZPb24byEDUxlu4QQGpvV1JtHWDeGmPOdCtRu6En6hLLZJtwEYFt4WrfTo8wwr3x+
 UZZzQ/P1p9uijobSCPJFoYg7/35EphZr5iIY3TIW1Ll5qEEAWUvVoaq+nybS3/TP
 6b2f/ogGRvsfDjRsyyMFIbGjrsVXw90968GC7GKZbsKHz/CSVGGmzkvypKf2pjHb
 29cplpSXU2VGgNFevuFX5YX7UBrKajUKkM8K7uek48uBUmSR35qQGJhHg2lJSqKy
 sSSJtR5gWt+OTATX50twegw5KSJxgLxiQUCPmwRh1Oq7+ZjL8ZpNX/jkN0N0lSfQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3ub7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 07:41:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6687YfSa001856;
 Wed, 8 Jul 2026 07:41:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hegnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 07:41:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6687fZYb28508694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 07:41:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D9D558059;
 Wed,  8 Jul 2026 07:41:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B50475805D;
 Wed,  8 Jul 2026 07:41:32 +0000 (GMT)
Received: from [9.39.26.49] (unknown [9.39.26.49])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 07:41:32 +0000 (GMT)
Message-ID: <642080ce-c950-4746-895f-216115c82ceb@linux.ibm.com>
Date: Wed, 8 Jul 2026 13:11:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
To: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: milesg@linux.ibm.com, harshpb@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
 <85806173-0fb8-46d2-a69b-6743de12b2c5@linux.ibm.com>
 <593b59c90b8f0351ff992cc087dcf44ebd06d114.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <593b59c90b8f0351ff992cc087dcf44ebd06d114.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4dff32 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mklDNNd_xkPFudRSu6gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2OSBTYWx0ZWRfX+QfPuBfeloc+
 vVBcBtjL/SDGzD46143vw3/Zb2xDOggR6UWhh0dbGc+XJygz3LrRCglo1FuY+AGxQmPFtkom49C
 A+WK9k2cG14vpS3KYy8SFme+5cfhunE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2OSBTYWx0ZWRfX1ThoH2CovWuE
 K07jiL+WWEAT330UhszUzPVeGGIODw6KMsJJF+K7OHHmRxRc+JpyZrVTXP/EkS+EXFabwsyzTtO
 iYKo6+l2Wb7fBi3vYAsWwIZrTYsPAFsszIsNrExWlmi3NLcz75DM6O4DtCJXESoeulMauEJCTCW
 OMH98TZ6oxcAn6ICMBvu3Hl/x8FecPYxH6s4N1JW9g3o+tYzc1U6L9ZTI9lfBG5KZQ7SDMJpdpW
 iukDw9QPptXaOsP6pD0+MaRaJjAAweqMZixD8MptSZlp9gcRnv4CyhEwxSUmPf4b4HCTYaRou87
 jcB7cu65Ce/dsTIpZsQGOkdnG4mT+L+QndSS6oIcJowrLwuXF37LX4pmYOBLFLrTwJQkHemcXz/
 f6UUfR4b5IrzTNBBmQ7D9A92zBQUZTX+fzzxT/1ISzEieSAKCMBNHmP1TBV7mHIS8Bs2+ZO/j/L
 rX4PnUAA0gXtZhvmAcA==
X-Proofpoint-ORIG-GUID: hPYyJ80i49pV8bytAYLC_iPTVZd17_9n
X-Proofpoint-GUID: hPYyJ80i49pV8bytAYLC_iPTVZd17_9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080069
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 7/7/26 16:06, Shivang Upadhyay wrote:
> On Mon, 2026-07-06 at 23:39 +0530, Nikhil Kumar Singh wrote:
>>> +
>>> +    return true;
>>> +}
>>> +
>> You are using gen_addr_register and gen_addr_reg_index, do_ea_calc
>> instead.
>>
> Hi,
>   Seems like these functions are refactor-able. I can send in another
> patch to clean it across all usages.
I agree with Nikhil. This should be done as part of the original 
movement patch.
Thanks for catching this Nikhil.

Please take care to use the appropriate method, do_ea_calc or 
do_ea_calc_ra, as needed.

Regards,
Chinmay
> ~Shivang.

