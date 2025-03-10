Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94750C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trf5H-0004PW-Cn; Mon, 10 Mar 2025 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1trf4o-00043p-Sg; Mon, 10 Mar 2025 11:29:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1trf4m-0001z2-Gy; Mon, 10 Mar 2025 11:29:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AAQKVS028700;
 Mon, 10 Mar 2025 15:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ooh+vt
 IFnsbCgyWvUN8pRKDGVol8NjtGjaNHMOx+I7I=; b=hfL8BTXljAsSvDvwdeMJz9
 +Zo6JZLgOAAKuhLqF5vbk9iU4xAad+2H63+mXqr0NGZtfzyy3GCpRu6qbRrsNyNt
 B5C/KVzDoG5bzrmiCAt6T8yq4diya1QAqcG5jvRuG7c78L4JOULVikHp220RMWwW
 D/7YxIhKLxQ5GvFbDR+JYL1MqT1k3idkM+Y/TJCMaSpDrRjXa1p4N1L5qiIElcWy
 BOMKtWJXeSoD5RC9vy92ZxfPL1+xe0TnbLDwzp53yfj3xxz5HdmejD26dlh3V7Ur
 hvBxiGG9xLO6MOSZhRleFOPftqyyvOdFDKDhZl/9PCoQYhqGR+sAPiJYkAPYLFgQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459j5p46x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:29:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AEjK1H022265;
 Mon, 10 Mar 2025 15:29:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917n7925-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:29:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AFTp4F64487772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 15:29:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4291B58065;
 Mon, 10 Mar 2025 15:29:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D17C258059;
 Mon, 10 Mar 2025 15:29:50 +0000 (GMT)
Received: from [9.61.250.189] (unknown [9.61.250.189])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 15:29:50 +0000 (GMT)
Message-ID: <8b4aec2a-7ae4-4784-a0d9-aa081531ef3f@linux.ibm.com>
Date: Mon, 10 Mar 2025 11:29:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, pbonzini@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-2-rreyes@linux.ibm.com>
 <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
 <27ccfad0-99d1-47a5-8370-2b16ea924ac9@linux.ibm.com>
 <your-ad-here.call-01741618023-ext-3477@work.hours>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <your-ad-here.call-01741618023-ext-3477@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RXVj5BjdssrNmtH2yQFEQPIhQxKxQkjx
X-Proofpoint-ORIG-GUID: RXVj5BjdssrNmtH2yQFEQPIhQxKxQkjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=969 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/10/25 10:47 AM, Vasily Gorbik wrote:
> On Mon, Mar 10, 2025 at 10:20:05AM -0400, Rorie Reyes wrote:
>> On 2/5/25 3:38 AM, Cédric Le Goater wrote:
>>
>>> Are the kernel changes planned for 6.14 ?
>>>
>>>
>>>
>>> FYI, QEMU 10.0 hard freeze is scheduled for 2025-03-18 which is
>>> approximately when 6.14-rc7 will be released.
>>>
>>> Thanks,
>>>
>>> C.
>> Vasily - Since you applied my kernel patches already ([RFC PATCH v2]
>> s390/vfio-ap: Notify userspace that guest's AP config changed when mdev
>> removed), would you be able to answer Cedric's
> We are at v6.14-rc6. The changes are queued for the 6.15 merge window.
>
> https://lore.kernel.org/r/20250107183645.90082-1-rreyes@linux.ibm.com
> https://lore.kernel.org/r/20250304200812.54556-1-rreyes@linux.ibm.com
Thanks Vasily!

