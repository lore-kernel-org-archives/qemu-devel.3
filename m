Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E40CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVOB-0001Sj-54; Mon, 11 May 2026 14:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMVO3-0001S2-Ib
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:29:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMVO1-0004iA-Pl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:29:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7AHmk2780021; Mon, 11 May 2026 18:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EkxKMh
 rNSArpU4hhrSsd6JWtatQ0p/xOvdTM3aHPs5A=; b=N92vSEcRMR+c5ZxEJDJO9t
 I6cu8Vi7kYxmAX6A6hNu12i5GsacEeI5ha2aGlKluBM9+s62h6lw8hOWYGbcMKvp
 8B8A0BHTaueaiV0a0f+JjuwUFsviXsN0BXYa6pKvcTjhtz/b/FFVDTWp2vYsmtdb
 w9WAxP1QoD6WgZ6qSB57QZfksSsk43qYJDOhpgWUmCgHqqYtF6TC3YFteh2ZjDbd
 fhVeDbOUSG84wbRgojoFkPE9zyiiYFH5IfaCJ+hlpzClGB2fX8PyJtjn45zrL8m8
 SJQzV6zcuA96HdtSNAygQe789hNeUrCdexciKrU0zlAoV+X3Mf7/S7QyIy3El/5A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve71p7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 18:29:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BIOZc7002181;
 Mon, 11 May 2026 18:29:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jxgs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 18:29:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BITGos17367620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 18:29:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0766058059;
 Mon, 11 May 2026 18:29:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C76A58058;
 Mon, 11 May 2026 18:29:43 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 18:29:42 +0000 (GMT)
Message-ID: <9ec245d8-4a3f-4896-b633-c17c45b328f8@linux.ibm.com>
Date: Mon, 11 May 2026 14:29:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
 <40f3f863-04fe-4eb5-9672-a21ae4fca950@redhat.com>
 <3b5ff524-75d6-41d0-949d-39bbff0558bb@linaro.org>
 <2a4981de-da3f-44a9-b422-3ba9c24b7dab@oss.qualcomm.com>
 <4d0a80a8-396d-4ce5-ae8c-ec5581f5e90f@oss.qualcomm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <4d0a80a8-396d-4ce5-ae8c-ec5581f5e90f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5MyBTYWx0ZWRfX2+ias1u6Zkd2
 GV1XQ37JTozuHrLasq+vxvymQ7vGwaSa6z5kst6GXndhO7x/OHz6LorH+hunf8gmrQv0/bFExRS
 qRrb8t3DsA3eDNnGr6FYXg/MhmpS4S0AxhIiCevvpDR1bnPKjva0kv4jH35sQnpSUGOoZtsyxzy
 CRq82dIQBUGQc0FZpBVmkCHqh2PPM7nnqnVzRphYxvfoWRB9MBEqAT+aGoOjzas/WR7wtKV72oz
 sIeFK+yjPKYR0tXWYqbrBl2msAzZ9wWDY6x7ex0piHs9svLBWwzntgLfxpEhyiiIjkquWWaAbFU
 LZ+a3eZThOM8berYaG4Jhvi+aRd9TKZP60meMer1LZF4TUUxjn9idxJT/6c+B+gJRPigU7IXISs
 KF5yASxXw/dqIu6/HXq4uJI4RpGmhbpsQYuNdOvNGwQeQaCTeBeHX6rHTANf182lhbuYMkaHEwp
 Ns1zckGqTfo7js25nTw==
X-Proofpoint-GUID: icyZDPqASXdVbFjtlKWCahR0-cJ4SnXY
X-Proofpoint-ORIG-GUID: icyZDPqASXdVbFjtlKWCahR0-cJ4SnXY
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a02201a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ne7t-IwvNW_vuAxhOb8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110193
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 5/11/26 2:16 PM, Pierrick Bouvier wrote:
> On 5/11/2026 11:01 AM, Pierrick Bouvier wrote:

[...]

>>
>> The only possible thing is that code becoming common skipped some ifdef
>> that were here before per target.
>> So, something that should have been poisoned has not been, and we
>> definitely need to identify what it is to prevent other regressions like
>> this.
>>
>> Regards,
>> Pierrick
> 
> Fortunately, it was a much simpler bug, where we incorrectly removed
> cpu_models_system.c completely, and used user stubs for all versions.
> 
> Attached patch should fix it. Can you please test and confirm?
> 
> Regards,
> Pierrick

FYI Eric already posted a very similar patch:

https://lore.kernel.org/qemu-devel/20260511163541.192533-1-farman@linux.ibm.com/



