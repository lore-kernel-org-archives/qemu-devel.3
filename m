Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfBdx-0000Wc-Pz; Thu, 02 Jul 2026 03:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfBdv-0000SR-LY; Thu, 02 Jul 2026 03:15:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfBdu-0003zB-7l; Thu, 02 Jul 2026 03:15:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KIRi2450354; Thu, 2 Jul 2026 07:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oqMQPX
 LLp60o+IOkyeCMdVkLfJGOAT235ke6g8qevuA=; b=Ci7XXGjBnTBLf7CrLMGVhK
 WWlYQ8UqPhMnbXXBhgfvPAMuzbvPqk9mYrTwS5J2P++GUuidU8ANs3ZSNk67UOI3
 REmmnRDa04woeCU9RTte3Kt/WFJ7A0EBAPJtWCaa7p6GaM2p2S/bEmXNI2SmlNqA
 2VJ1jdIQHE79WwJ5yjH67Egk7bp0D7Bb7mcqLi48PoH828xR2Z11IUShtVdVWiG8
 YD2xs6WBjSvZH5y5b1VOf4UQuQp/Yty4C71FpzaYl9stKhpQBFkx0qAAq6Lkaz1n
 dQ55HR8nmuzhv6TIE9NYykGpLi0G4oL2YL/wpYdFw9aXynqHdNg4XfjgY4jIlfZQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n60nm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 07:15:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66274mf2006768;
 Thu, 2 Jul 2026 07:15:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gjs75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 07:15:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6627FJ1048169468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 07:15:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 785D220043;
 Thu,  2 Jul 2026 07:15:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AED820040;
 Thu,  2 Jul 2026 07:15:18 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 07:15:18 +0000 (GMT)
Message-ID: <3cd01daf-2d18-4d37-a869-3e4186cd2e96@linux.ibm.com>
Date: Thu, 2 Jul 2026 12:44:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] tests/functional: Use default powernv machine
 instead of power10
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
 <20260624195924.1422821-5-adityag@linux.ibm.com>
 <ajznoPrHDJEtVGCX@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ajznoPrHDJEtVGCX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfXxdO1TFQ2ZJ+7
 mFd0PD0M0LcvBYnnb9jOc2AbjcD2sHfCQw9PtHVBxHRcc7FVX147Qr2y2qSWx71r31AtJl3bSzF
 OVxE8XfWwGiqeES4I8C5wPyrq2QBLWsknQ4rEM+MbE2nV7b9yshsacC4EzQIpyxak410moWUnlh
 jb+j/UNczuKyXes9vZ/wzuuWHLTPapI4uxEDXZtv7YIDlmA7MOptUQyMnaG5vycflrqgMIArei6
 N1QvhITr60b3/jOUV/ljf8zTnflMoFmxbcRgFia29V33iqFhDTYCkLERTaJYgNd/c3lZhVv5+eh
 WxaRiKfgmWTEPACzYEf4uJSyETJtX0S/JyEw7xZ7SdjLFzt/rNMgJOwmbLsnJcI+PzVwDuaC/QQ
 7rYUbHY79rMNn9zvpRYSn5N2iodVgUz/f3LHRx3A6TnfrPHtLJeFaXfEqJ2H5NqKlFZFPRrfvEz
 paYTdgvtjWWJ/G6PqiQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a46100c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Fi5sFzxREgzQPsTXhocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ERfvoPfpgGnx2m9igknjxFLOV79mgW6F
X-Proofpoint-GUID: ERfvoPfpgGnx2m9igknjxFLOV79mgW6F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfX/W+eLDG2Upvn
 u5XHLBZMYSOHeW6DChBjyFsGfc5ReyebzEdO7FNXGxGL9VuPLjzHyqfiz70L8tFxaW2rV4TmHO9
 w95gwnuqqSaVGdLD5La63UgEdDviXg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020068
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

On 25/06/26 14:02, Daniel P. Berrangé wrote:

> On Thu, Jun 25, 2026 at 01:29:20AM +0530, Aditya Gupta wrote:
>> The default powernv machine has been recently changed to powernv11,
>> though fadump functional test used powernv10
>>
>> Change it to use default 'powernv' machine for the tests instead of
>> being fixed to powernv10
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   tests/functional/ppc64/test_fadump.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thank you for the review Daniel !

- Aditya G



