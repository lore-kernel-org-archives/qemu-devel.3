Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C6EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nkh-0007Sx-Ax; Tue, 29 Apr 2025 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u9nkf-0007Qv-5X
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:24:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u9nkc-0002Qh-Fe
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:24:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TEOrni028303;
 Tue, 29 Apr 2025 16:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zekSs1
 tEMG04AL8a5eNRlC7bMVWFZaswI9NBeWmwukY=; b=cfqf6y/R2VZ0tl0lF9UOsH
 DWX4B3UFZo6wP7/BMfteW3ZxE21YB08CPh5gs3UTkW5CpP3kouorhPcvhtiLE79P
 VsOAhvPaaP0n1SMUTVmBFiFSc/2RbCQx0+RiMuZYgZ2BwMkam77Bl6byWuBnnNHZ
 KZH+7GneQ1+nBNZhr+lap33ytmS4Xu/ymuoRQ20b7yTnToidATx9FKSdEkUqsxhX
 uriStgx2ochHwUYKz08HBb/K+0MkyYas9+xzJZtTQCNgsuxkPCqx3TDKYEKNQC31
 SJXH319pOXYBeErrsVxMJod7ghGzpY25mkwnQYiiSl7rdRukxHCw9xA7tTLTWkAQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8mc9xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 16:19:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDYSLr016095;
 Tue, 29 Apr 2025 16:19:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70c4w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 16:19:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TGJqXT31785686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 16:19:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2835C58045;
 Tue, 29 Apr 2025 16:19:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43F5758052;
 Tue, 29 Apr 2025 16:19:51 +0000 (GMT)
Received: from [9.61.250.102] (unknown [9.61.250.102])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 16:19:51 +0000 (GMT)
Message-ID: <d695b9da-3136-4599-ab03-427fcb14e91c@linux.ibm.com>
Date: Tue, 29 Apr 2025 12:19:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH QEMU] x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__
 in UAPI headers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
References: <20250429001705.2734439-1-aik@amd.com>
 <9f72389e-7adb-425d-8ab4-5770c8b89e9c@redhat.com>
 <0f279822-8f24-4b00-92ab-847ef88c5207@kaod.org>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <0f279822-8f24-4b00-92ab-847ef88c5207@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KxWBFvPgSulflcAqhkv2yCyqyxzDCtYh
X-Proofpoint-GUID: KxWBFvPgSulflcAqhkv2yCyqyxzDCtYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMCBTYWx0ZWRfXzvXzp5ynqS3Q
 4GxpTxLzTPfiv8rdfsjImC9+/Ty7cehE3rsiWhMISvLY2ElO6LhDWE0AEipwPUcJ0paALStE3mP
 NItGy5IWVxLtdVBqcNeGTa12+bzjNEr7w/6OVtqohhriAYIVIvJQdNOsnR4B7O61icyL6xPtjhU
 fBzn2+RwOFb9VN4sqsc2iulQpEbim4rjQkvIhYbPhp6tUumyVV8Nita+1hPf2PTEhNE8lwSnk/V
 ATZc8hcvur351p3Lmz94Pr0Km8ugc3OBitIQZpeDp8fuRaquXImBxoymK4w+C5UZI6VGSrSAvg1
 5Sjk2o6SH1JwO5ugnlnXG2F52vSCITq7A16k81EzC+MewY1NHWBcWNu4kCNt3S/3tfZzeVyq7Aq
 50Hot2gK181JK89AnTJA6y0Kk75JTPLPlhWMRAqE59iPR/syTgrBANBY2KAEsLHl7lVsS+7g
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=6810fc2a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cKuHB-N4JTawYMGt0BEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 mlxlogscore=605 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/29/25 3:30 AM, Cédric Le Goater wrote:

> On 4/29/25 07:22, Thomas Huth wrote:
>> On 29/04/2025 02.17, Alexey Kardashevskiy wrote:
>>> The recent kernel update 8a141be3233af7d broke the headers update,
>>> fix it in the script.
>>
>> Thanks, but the same patch is already on the list:
>>
>> https://lore.kernel.org/qemu-devel/20250425052401.8287-2-rreyes@linux.ibm.com/ 
>>
>
> yeah. I grabbed the whole series which includes a linux-headers update
> in vfio-next. I plan to send a PR in a couple of weeks.
>
>
> Thanks,
>
> C.
>
Is there anything on my end that you need from me?

