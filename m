Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8319F8A16F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDMJn-0000Bf-Kd; Thu, 16 Apr 2026 08:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDMJb-00009c-NS; Thu, 16 Apr 2026 08:59:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDMJX-0003Bm-Sn; Thu, 16 Apr 2026 08:59:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8GKgF1734194; Thu, 16 Apr 2026 12:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AlyoXe
 YpTHsc04TnHYcqY9O+phcolzSLo+ifQP0GdSg=; b=JzE4KyjvsSubsZmlFwStqa
 bWhSjSQz70vyCktk200RDWlZaucSrNdol5qdnO6QMFUytL13pOeMYG35IRVH/Ikk
 fMGrknFGxdtjv+zEJDe53q9ItcfMJdM7oP6W9SP699zLUtTJbcWCSScQJPCfiiy8
 /08RJxVCCuRzuJadnCRNNuhQB1isNN908f9M3KPZqkdWDapv1q8Z10LE8X23TLO+
 r8uT3nCYWp3hyV2Y7ZbX1F6L9YsHxKgoI5xDPn9Rnj7mCQL37OqFx/rIcXwUULBO
 BLVCToyDI3vpywPpLP0JtsRWodv7hgAlPK9/me40YejiVnxBnQob7X+urvs7oS3A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mcjew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:59:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G8ZkqF026284;
 Thu, 16 Apr 2026 12:59:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujtpxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:59:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCwpLi31457806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 12:58:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB45B5804E;
 Thu, 16 Apr 2026 12:59:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ECAE5803F;
 Thu, 16 Apr 2026 12:59:15 +0000 (GMT)
Received: from [9.61.14.120] (unknown [9.61.14.120])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 12:59:15 +0000 (GMT)
Message-ID: <e0fba17b-08f2-4b97-b79a-385c967ac23b@linux.ibm.com>
Date: Thu, 16 Apr 2026 08:59:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
To: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>
References: <20260319185203.11799-1-philmd@linaro.org>
 <f0965bf8-b736-4e53-b809-374945f0f48e@linux.ibm.com>
 <63ddd321-067b-4c44-99e1-9c6c0ac60003@linaro.org>
 <640ddcc2-f373-4738-8e66-50effe56de4e@linaro.org> <87tstdbwu4.fsf@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <87tstdbwu4.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69e0dd27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=B64LVIAMxX8YIRYdwhAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4sqA-m1nz1j2PtmhC2TnVqDPLix3qZbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyMiBTYWx0ZWRfX7Ce6Z3VF7jpc
 THSsYzTNXTpvNti7nhLow54vApLtfS5zrbnoe4ytqga15mOY/TE5iEIwH4MRC1uHox65KuVaiLm
 ODVn3nntYjBUwgGIqYyaYOHFb8TaHyKp/VC9TpLNrQp4943v7eG2hDEKmWjcY/3MFVIcd/46VXz
 mgd0FFViRRX2GRPlOtESRY4l5hO4gwBl2MP00H9w+cKU5GEhacavNy7STAgVXY3S7GMMfTHkTCl
 I0uPsvAhVwwQ7nHHNS3b6m4DMQCyTXHxnJeHw1zjBWIuOy5ytRJWTese3uNFBd3jR/ttOF95rnd
 vYeYKvvHRia13GQraxauEH9ObZaij2EQuwVXf19qqh/gP50XJcwkVjVQm4JpRQSTurKG1hc6bXE
 +frPusEMiesSSvF/w4665lk29aFQmKWcSt5RM0G7bFv8HsqyP8aAVMicVhEGhj+Lkh10sBqgETp
 qB711l5z4IlrhfkBtiA==
X-Proofpoint-ORIG-GUID: 4sqA-m1nz1j2PtmhC2TnVqDPLix3qZbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160122
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/14/26 7:33 AM, Cornelia Huck wrote:
> On Tue, Apr 14 2026, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 21/3/26 16:26, Philippe Mathieu-Daudé wrote:
>>> On 20/3/26 20:28, Matthew Rosato wrote:
>>>> On 3/19/26 2:51 PM, Philippe Mathieu-Daudé wrote:
>>>>> Replace legacy ld/st_phys() by address_space_ld/st()
>>>>> then lock the target again further legacy API uses.
>>>>>
>>>>> Philippe Mathieu-Daudé (5):
>>>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>>>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>>>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>>>>>    target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>>>>>    configs/targets: Restrict the legacy ldst_phys() API on s390x target
>>>>
>>>> For the series:
>>>>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>>
>>>> For good measure I also ran some s390x kvm regression tests, took a 
>>>> less comprehensive spin with a tcg s390x guest (on s390 host), and 
>>>> forced a few of these codepaths as a sanity check.
>>
>> Does that mean we can also add:
>>
>>    Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> ?
> 
> I was planning to pick this via s390-next, I can add T-b if desired.
> 

Sorry I missed this question earlier - Sure, feel free to add my T-b.

Thanks,
Matt

