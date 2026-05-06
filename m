Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A5CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdCn-0004yN-4k; Wed, 06 May 2026 10:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKdCk-0004xX-V4; Wed, 06 May 2026 10:26:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKdCj-0005o8-BY; Wed, 06 May 2026 10:26:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6463IS5A1381065; Wed, 6 May 2026 14:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EZF7b5
 2RqzL5RgkRerVoMlCYHHwR4H3Jc3UXQvjITpc=; b=qPvUXSGMSZlyo4MlS/cOCN
 AJKPOdBbe7BuW1BOzzDIlqFmlHYPwsdjHMhB9iz8pIx3YKxXn3Prt6Ih/TTSt+Wb
 Z1qYr074NkdTwpFjHpkbNf02iiRsCaRDhPeQvhr9fVYOQMS+ZlIcwZqO9uIk19Ge
 +YaJp0Xi9ITUAih26E+Qf8JBAhJphgCLnxvPzapuB0Pnkg6Togzsna01pcT81Syp
 Z52lrg6aRHPUYXTIKcaQlDP3B407wYRCnihpCIRj4jgu6lc0c8rBC/pUhwQmC4cO
 Kckz57MwZYLXia3DwJaYcwwImyN9J4X/ngFzqwNQLZPXQn3ryaErG0xlkWk106Mg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4s390-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 14:26:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646EOger009995;
 Wed, 6 May 2026 14:26:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yebep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 14:26:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646EQ96j62325244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 14:26:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04B9958043;
 Wed,  6 May 2026 14:26:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60FAF58059;
 Wed,  6 May 2026 14:25:56 +0000 (GMT)
Received: from [9.39.21.176] (unknown [9.39.21.176])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 14:25:55 +0000 (GMT)
Message-ID: <28b3774a-6185-4f28-9c1c-05de8253ee6e@linux.ibm.com>
Date: Wed, 6 May 2026 19:55:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Content-Language: en-GB
To: Caleb Schlossin <calebs@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <36fa4cb0-5795-4007-b668-c3e9365d47e0@redhat.com>
 <1fa40ad0-0ad1-4d01-9660-48b2f7f78b62@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <1fa40ad0-0ad1-4d01-9660-48b2f7f78b62@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfX/7ft5t1PiFQm
 mjt/XDVQm0+bN0DmT5T4YoVC++3VggXwqmsMUKlHAgSLa2X03loKCxIYZmbj5q9xhzRKbQZFnvU
 3vLQ3WMQxkfvYtdZ1K1ba6ZL5py8u+fqW4CWPXfR90hd3Yr7vPxFM26Vvr0xJ2yxPwnkhglP8Yr
 VbxOdbZikkfMXID4x8LKvNWk8nP3Kioq3BH7LQ9tAQsRGd2vGKBteOp1Z/RUZ/bgvaNWIwrknQ1
 tdKXx/k20YYNAMQLGVkaDeeqEw6tVA+W2U0YoZLO8TntLE3gzC/nNATAzabEOoyt99SKHF5+bvL
 YjlOstRFx9cG49Osu98FqqyFtbaAijo7uUCTtCLLUUEkFdxLYNwHNrCy8zZYOP9tkxLdOT9AGXq
 6pTeNGGqs0AR7TQNkR2hmUp7D28ZubCjlDy+6zsTUsvrri12Io/H4zfEAIQbZrqzWZfshP8v69w
 MsHechRKDPaBHHS1eBg==
X-Proofpoint-ORIG-GUID: D2aZnRkctG_Cq7Dazn91sMyvwLi1rFB4
X-Proofpoint-GUID: jDtSAGesnGNXrqUBdWoxp_IJYNAn0fEp
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb4f84 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=M98VLt0xmqTDZtsn:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=ag1hQMmocu1VWVFvKG4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 06/05/26 7:24 pm, Caleb Schlossin wrote:
>>>       MAINTAINERS:2862: XIVE
>>>       R: Gautam Menghani<gautam@linux.ibm.com>
>>>       R: Glenn Miles<milesg@linux.ibm.com>
>>>       L:qemu-ppc@nongnu.org
>>>       S: Odd Fixes
>>
>> Harsh, Glenn, Caleb, Gautam,
>>
>> Could you please propose a maintainer for XIVE ? I can still act
>> as backup as a last resort but I'd rather not.
> Cedric,
> 
> I spoke to Glenn and he'll take on the role of maintainer of XIVE. He'll be submitting a patch set shortly.

Thanks to Glenn for taking care of it!

> 
> Thanks,
> Caleb


