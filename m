Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403F3CA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEuI8-0006K8-AE; Thu, 08 Oct 2026 16:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEuI6-0006JB-Jz; Thu, 08 Oct 2026 16:00:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEuI5-0003hU-5g; Thu, 08 Oct 2026 16:00:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HZUhE1857059; Thu, 8 Oct 2026 20:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WNCk65
 ugBvJMXL0O7cKJIJI4djXsEjb4to/EKMXaeDE=; b=EWgaKhLM6woqpx5FP6TTL8
 5+Cy8a857b5tsHHnSR7AmmveaejsFXXwF4yfdg7FQtI/mlwopAKE0JEMWLzgo0PV
 RtqHDbNLxg8FyTo4rLw38xGdNl7IFwh82nVnoHArv/n0GXGeKnbbsM8hMIL0k+3S
 Dm0tQGw/NE2XS/9TTm6RQ1ZjipK3M45+e9hrSEzXu+n8wqm7QPtXAd0U2ZEnjW4x
 FZAxEkukHLubTmD3eFVNZQiShRl1JCzVowdquh26rkoTkvSTTd7B40nGaQEawvuc
 Glbw9GSIBaKJ/yrVXVdQFj/GPm0EXX2bXoewVMH5jBYRYzz3Y7WquFd5eYu8NFRQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw5v9t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 20:00:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HWieC3841882; Thu, 8 Oct 2026 20:00:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6drv3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 20:00:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698K0R6F2819064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 20:00:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7B5C58052;
 Thu,  8 Oct 2026 20:00:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 480AA58065;
 Thu,  8 Oct 2026 20:00:27 +0000 (GMT)
Received: from [9.61.85.144] (unknown [9.61.85.144])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 20:00:27 +0000 (GMT)
Message-ID: <c63d1003-1966-45d2-87af-06cfbddd9547@linux.ibm.com>
Date: Thu, 8 Oct 2026 16:00:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] test/qtest: Remove s390x boot device support check in
 pxe-test.c
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, shentey@gmail.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
References: <20261008153435.207538-1-zycai@linux.ibm.com>
 <ase6pruX6UM-umNQ@redhat.com>
 <CAE2XoE9Dg2CQGF9uQvM2=LEaXdGR+1Djt0DnYxntfASP-uD5OQ@mail.gmail.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <CAE2XoE9Dg2CQGF9uQvM2=LEaXdGR+1Djt0DnYxntfASP-uD5OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX7JnMew4B9VMY
 YouleT0VqcTuJbwND3YgfK/q4OmGZm5F3dgJMDtcRdWKlkqadAuC/X1kpai4tUc/WNJteqsHv3M
 w2zPtW5CdeRxAgMR+Ua+FkSBrMgZ/sI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX6Dc6UCkIbeDa
 BxmTvWK9v9Tk+n7YkCsTUSY9Jqq61lnfRS96rUqWYAe0CKKiNuSpyvN8X0VGO7xIztQSy8AqGeM
 nZaM/qapwZxuIGb8GbgPiaURNp2d4EUt7DGawLtVHARYgu2DuWt5L7ax4gQC/I1YuCYU/aB+Wd+
 s07jtdAX4QIDJupMGgNXEzxcwuH2UqIemL1cuLeiUg634XQqYLj1LU+9QPGH+XfRCoOB1XhkWUF
 CR7MGyZzY8yxUWomDR2gr1X4PYXjwDg1uNv5JQ+z2j34qevzXipKA0MRRWSd9rjBPZPhtwYkb1/
 ++eneDyOXUJxSPWuMTq7d4WxTCKCeNkzUQCl7mtQiFDVJQ9k0CeZ6SIv/0qw7vTBQ+6yZejWZWW
 IsjBQgTMqo9cEatg34oKShHPSfhCr7ElusukFb5UqdQquFFe2TAlGGbuukGZlWYSzeLV25AgfQD
 aO0RO5UvpUOujML57hw==
X-Proofpoint-GUID: sPb4yDYEW_OeJ01iL2a538R0BrQMtZMu
X-Proofpoint-ORIG-GUID: kn9TelvSaX1GD7ockWiPnAPkyr7PAUaS
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac7f65e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=LtXPuHPjjCLWEIdP9kEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 10/8/26 2:46 PM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 11:47 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Oct 08, 2026 at 11:34:35AM -0400, Zhuoying Cai wrote:
>>> The s390x PXE tests used `memmem` to probe the s390-ccw.img firmware
>>> for device support strings before running each test. MinGW-w64 does
>>> not provide `memmem`, breaking the MSYS2/GCC build.
>>>
>>> Remove the check as a workaround.
>>
>> Removing the testing on every platform due to a Windows limitation
>> is rather a big hammer. Why not wrap the code in  #ifndef WIN32   ?
> 
> I did it in another way:
> [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW
> https://lore.kernel.org/qemu-devel/20261008184119.142-1-luoyonggang@gmail.com/T/#t
> 
> 

Thanks for the suggestion and for the fix!

Since I had already sent v1, I went ahead and sent a v2 with the
suggested WIN32 guard as another option:

https://lore.kernel.org/qemu-devel/20261008195158.289711-1-zycai@linux.ibm.com/

[...]


