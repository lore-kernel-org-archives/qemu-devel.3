Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E2CCD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 06:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTvmQ-0007wl-2M; Mon, 01 Jun 2026 02:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wTvm6-0007jV-Pg; Mon, 01 Jun 2026 02:05:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wTvm4-0001Rv-16; Mon, 01 Jun 2026 02:05:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VBj1Kk3166613; Mon, 1 Jun 2026 06:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BgBb9g
 sNUMFQhY8blUcNRUJnR5d3FCRzXzvRFfBVYzI=; b=JgKz08KfzK4cHb1nblncNf
 3IxLGPGRxl9Iyo2+xWuUkrnI70k12zJgkvknPhARy8PIQvooOhjB4s5+vMk+Egdv
 wNDtwhW6egSK9liMsIeBu8Ppx4uOtfmZxUGWFOfW+mJjoS0IJz3pdNBZ3HZXaFlm
 L/rbXnBIoeOLoZasVBKzkioGWu4Z8pMwXcqiAVFEjs5Zf0RlTMD3C1DFQtAJErc+
 53PMzRDAit2dpAbHoLyd4niFyygwQI2MQPA9LOI8EikL+xPIg/i6zPldTSbhRzDI
 ppEBXzThNyON3Nl8K4jlIctuX802C8KRCI/Bt9OprSYr4AnIdrAWTW2D06pe48UA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpadxy8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 06:05:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6515s8ls013535;
 Mon, 1 Jun 2026 06:05:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy4bs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 06:05:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651658Oq52625676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 06:05:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D579120043;
 Mon,  1 Jun 2026 06:05:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E9C420040;
 Mon,  1 Jun 2026 06:05:06 +0000 (GMT)
Received: from [9.123.0.29] (unknown [9.123.0.29])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 06:05:06 +0000 (GMT)
Message-ID: <3e5fbe36-a0ac-40ae-8b0a-e557d18ab50a@linux.ibm.com>
Date: Mon, 1 Jun 2026 11:35:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] ppc/spapr: Advertise RTAS error injection call
 support via FDT property
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-5-nnmlinux@linux.ibm.com>
 <23c8cf1d-dfe9-4273-868d-1c4e41a59fcd@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <23c8cf1d-dfe9-4273-868d-1c4e41a59fcd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1d2119 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4OSCywFdi6JTqcutriUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lhKbDoG4a5_IillyXB_zm0nxl13M3enp
X-Proofpoint-ORIG-GUID: LBvbbDbgm5-9Ja7rl4-6qaGEr-J_lorm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1NCBTYWx0ZWRfX/KazKSfbyz8v
 oX8jaLRrPSqbYHQdGuYHLQVZXX2Cfo4am6vMrOwIRFv6/gO98MW7ftWZUm5arCn7SSbtLvJERYW
 he6m+Ih9qEDvfBHxD9XSsXciP5uferMM8kNQnD/f2d8QNlbFPyAvBrWGyjrTmwVVd+EVs2s+vQY
 mdcAooCPRXFnTMcndEJ+zxdmEy88fA6a7KgRfkHdKD8G/0HzwGjuX91a6gH0ySG+fGMwxXU6VeO
 uTFYtv9VPJZUX5jtnvFmioz7UoxFN4AvsJvsJkDmrewHsWheKPCZTME+Zk869IlD4WC9KnNOPHT
 qvpYJJxoVkUpldb68/kZLOEXLtpDrHV2zfin+NPdNS6sMPingvHhmfgLJq8lOglC4sXQXIk/7od
 AQwCfM8PrmKBizGPWNbrFT08QiJOhzp3wbC/zZ5BW8aTAuyPc8xe95hufY3ywxJc5ZOJGPJYFQL
 ovMpEmsO9NZOufWncwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010054
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 22/05/26 2:37 PM, Shivaprasad G Bhat wrote:
> Hi Narayana,
>
>
> On 5/20/26 3:24 PM, Narayana Murty N wrote:
>> Advertise RTAS error injection call support to guests through a new
>> "ibm,errinjct-tokens" property under the RTAS node in the device tree.
>>
>> This patch introduces:
>>    - spapr_get_errinject_tokens(), which retrieves or constructs a blob
>>      of supported error injection tokens from the host or fallback data.
>>    - Integration of "ibm,errinjct-tokens" into the RTAS FDT node.
>>    - Addition of "ibm,open-errinjct" and "ibm,close-errinjct" properties
>>      to advertise open/close handlers for error injection sessions.
>>
>> The ibm,errinjct-tokens property allows guests to programmatically
>> discover supported RTAS error injection facilities, enabling safe and
>> dynamic usage. The helper routine allocates memory for the token blob,
>> which the caller must free once it has been added to the FDT.
>>
>> If the device-tree file (/proc/device-tree/rtas/ibm,errinjct-tokens)
>> is not available, a static fallback blob is generated internally.
>
> Do we really need to probe the procfs ? This path wont exist when on 
> baremetal.
>
> When on L1, the host compatibility may not be assured 
> between different L1s
>
> and I see no specific handling of compatibilities between L1s.
>
> Why not advertise all tokens and let the errinjct return invalid argument
>
> if the host doesn't have support the given function? The use case is 
> anyway
>
> an error injection which is mostly for development and testing.
>
Hi Shiva,
Thanks for reviewing my patches.
On pseries procfs entries missing indicates the error injection facility
is locked on fsp, but on powernv opal error injection is always allowed.
So is there any different way to know the underlying platform?

If we advertise all tokens the error messages will confuse the user
by returning parameter error even for facility not available.

Regards,
Narayana.
> Thanks,
>
> Shivaprasad
>
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
> <snip/>


