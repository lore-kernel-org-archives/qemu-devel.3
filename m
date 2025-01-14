Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3557FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm14-0004CU-Uc; Tue, 14 Jan 2025 13:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tXm12-0004Be-Tx; Tue, 14 Jan 2025 13:51:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tXm10-00028P-BP; Tue, 14 Jan 2025 13:51:52 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ED2Qp9029408;
 Tue, 14 Jan 2025 18:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+W+DEJ
 nFdKcDXYOIjkkyRdAu4PCLgLs9c3Jflpa6v8c=; b=U7iS5/cERoyWbmO+eeFfG6
 TUmCZYbvux/dwekbli9Ja5ehXcbUaOyORpEzWmPlqtmonZEQXLGc7PSkZBX06gPJ
 Bd8CuHGChpc+hNqL2HfKBR3sVlM0doxLenpv4iwRF70jOU/cwZsXYr98d44E5+nL
 ebWVmaDqs5UvflcxB2xAq73SLOcBm0EHY29zYgT7Tv2EG8NerLK1ll7/nU6lXXly
 EmRgGQb5JxUbpWJ7Xw3kKGZQcF39myW34tWRy7EjJ0ElivgXxvEhvg/WXfytWRxT
 gqSXvvE94iqlMT7hGKrdopMbbYs6E2eDlxg11bU+Ecr40LmslFUqG5jNMqi6hCNw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb48f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 18:51:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EHWxu4007994;
 Tue, 14 Jan 2025 18:51:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yn4kc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 18:51:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50EIpjGk23134964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 18:51:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6528F5805E;
 Tue, 14 Jan 2025 18:51:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5EF858051;
 Tue, 14 Jan 2025 18:51:44 +0000 (GMT)
Received: from [9.61.252.26] (unknown [9.61.252.26])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2025 18:51:44 +0000 (GMT)
Message-ID: <dd1b07c4-1b72-4051-acbb-d679d0a0f534@linux.ibm.com>
Date: Tue, 14 Jan 2025 13:51:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-2-rreyes@linux.ibm.com>
 <f0213486-c0f5-4415-869a-99a851c8a4cb@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <f0213486-c0f5-4415-869a-99a851c8a4cb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8TzYd02Q9ZMbv66vYt3O6l9ztkzaM9RC
X-Proofpoint-GUID: 8TzYd02Q9ZMbv66vYt3O6l9ztkzaM9RC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.794, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 1/8/25 2:29 AM, Cédric Le Goater wrote:
> Hello Rorie,
>
> On 1/7/25 19:43, Rorie Reyes wrote:
>> This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to 
>> specify
>> an IRQ index for signaling that a change has been made to the guest's AP
>> configuration. This is a placeholder for QEMU patches that use this 
>> value
>> since it is a linux-headers update which includes changes that aren't
>> merged into the kernel.
>
> Is there an upstream proposal for this change that we could look at ?
> It is nice to mention related series in the cover letter.
>
> Thanks,
>
> C.
>
>
Hey Cedric,

There is no upstream proposal for this. It is an s390 internal line item.

Thanks,

Rorie


