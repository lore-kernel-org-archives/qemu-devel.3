Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B862FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzevN-0007gT-M8; Mon, 09 Mar 2026 14:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzev9-0007bf-Im; Mon, 09 Mar 2026 14:01:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzev3-0005YU-Nj; Mon, 09 Mar 2026 14:01:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629FulYK1671245; Mon, 9 Mar 2026 18:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aIJDo0
 36S2VKW/vOB+dcnelOYQs4x1RDp5BTbAr/ELg=; b=pMH9p1M8W9eZRxGvOMWtI2
 zCWZ5xzfPtjn+vumDJqtapRiuzBs+1fGzL3oqk3xAQTm8P6sNSs+nQeETFuIUrtw
 vdCp+XshBBVQ1NylLt9VWXrUBtF0suGEq6slnjlS22q66NiTJPImCXoo7ZI7vlvC
 5p7YSVezS5bcHjJhqGwvrZJAT9lCJLnVx4RNSofOIXiHmyIqYV/5Dwa1/kwvareD
 mwuZAERQEpoX3kZLddWLMS/i/0eqiGi/bTFX6Lv5u4xh/e0Iu4h6OGQeOfASBYwv
 rkQ/Uh2XwRsxnAmSrDVyhnaOJol7We/i6EYdFwSN5pLSiM60ainOXjNNfT4fbvdA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm7u5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 18:01:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629Dn96o009535;
 Mon, 9 Mar 2026 18:01:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy640k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 18:01:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629I1OGY29426186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 18:01:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AED8958056;
 Mon,  9 Mar 2026 18:01:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E52B5803F;
 Mon,  9 Mar 2026 18:01:24 +0000 (GMT)
Received: from [9.61.180.105] (unknown [9.61.180.105])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  9 Mar 2026 18:01:23 +0000 (GMT)
Message-ID: <9823f42f-f3d8-4642-bec7-b224d564b283@linux.ibm.com>
Date: Mon, 9 Mar 2026 14:01:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/15] tests/qtest: Add s390x PCI boot test to
 cdrom-test.c
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-16-jrossi@linux.ibm.com>
 <e844e819-9000-47c5-bbc1-b163e7255870@redhat.com>
 <bd10a0b8-2116-4785-9069-a0f3c622c0f9@redhat.com>
 <cd84ed2d-9ed3-4a0f-8c1c-0092eca84cf8@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <cd84ed2d-9ed3-4a0f-8c1c-0092eca84cf8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZI81t5CRevh0qIpYTnQ7ed2D-ZVIPvR
X-Proofpoint-ORIG-GUID: 4ZI81t5CRevh0qIpYTnQ7ed2D-ZVIPvR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1OCBTYWx0ZWRfX8R/v9edqo+dJ
 gdexDN2XP7z/M5jY1dTX8wfbuVDroWXer2s7oyOzVyJ4oFdQyq7WcNfbWH1bojECH3Mg0vFMOT7
 +8759S5lmcVD8YwhJ7uFQh2L0IlG6TRvNvs4cQgUuQ0ZHnJMauxn63moAf0Ua/TDvGNhAO8DVks
 N1EZpRiJQbSxCWQzoGv+uLJN26Y/g6VMo7104uXyXhg9qqxtZ/uEphhVDEeUJHtLOe+6yqdpHoz
 z6AZJ0xkHMRkS9QKP2AFnz2Wac4YpUyp5+8bkfpPAmncPHM75AV/epbHeFGHmAEBz5f5TY8Mxof
 xwTE0a0YuZ9PNJSfD30pPuoJnVkq5aUjrTlHZ4sAbGEvTevs7nSAT1LWzfQRj8dQDVECgWqKCA3
 FG6EtXT5VhICd63pPMCDfNk6f0CVGp5aMTJGvW3YBa9TvbTNGHfZLlT8wQXSToB3LdrwA1ysAJ3
 z0iEdJ9s5LkMuJAgfew==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69af0af7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=n9gWB4Ex54Z63oAJn1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/9/26 1:11 PM, Thomas Huth wrote:
> On 09/03/2026 17.53, Thomas Huth wrote:
>> On 09/03/2026 17.49, Thomas Huth wrote:
>>> On 09/03/2026 01.36, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> Add a rudimentary test for s390x IPL to verify that a guest may 
>>>> boot using
>>>> virtio-blk-pci device.
>>>>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>> ---
>>>>   tests/qtest/cdrom-test.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>>>> index 56e2d283a9..a65854d2bc 100644
>>>> --- a/tests/qtest/cdrom-test.c
>>>> +++ b/tests/qtest/cdrom-test.c
>>>> @@ -246,6 +246,13 @@ static void add_s390x_tests(void)
>>>>                               "-drive 
>>>> if=none,id=d2,media=cdrom,file=",
>>>>                               test_cdboot);
>>>>       }
>>>> +    if (qtest_has_device("virtio-blk-pci")) {
>>>> + qtest_add_data_func("cdrom/boot/pci-bus-with-bootindex",
>>>> +                            "-device virtio-scsi -device 
>>>> virtio-serial "
>>>> +                            "-device 
>>>> virtio-blk-pci,drive=d1,bootindex=1 "
>>>> +                            "-drive if=none,id=d1,media=cdrom,file=",
>>>> +                            test_cdboot);
>>>> +    }
>>>>   }
>>>
>>>   Hi Jared!
>>>
>>> While testing your series, it seems like the cdrom-test is now 
>>> triggering a segmentation fault in QEMU here ... not sure whether I 
>>> did something wrong on my side while building the bios, or whether 
>>> there is a bug somewhere? Does this qtest work for you with this v5 
>>> series?
>>
>> Ah, it's working on my s390x LPAR, but it's failing on my x86 laptop 
>> ... maybe there is some endianness issue left somewhere?
>
> Yes, it's a missing swap of endianness data, this patch fixes it:
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -524,9 +524,9 @@ static bool s390_build_iplb(DeviceState *dev_st, 
> IplParameterBlock *iplb)
>
>          switch (devtype) {
>          case PCI_DEVTYPE_VIRTIO:
> -            iplb->len = S390_IPLB_MIN_PCI_LEN;
> +            iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
>              iplb->pbt = S390_IPL_TYPE_PCI;
> -            iplb->pci.fid = pbdev->fid;
> +            iplb->pci.fid = cpu_to_be32(pbdev->fid);
>              break;
>          default:
>              return false;
>
> If you agree, I can squash this into patch 13.
>

Hi Thomas,

Thanks for identifying the problem.  Yes, please do squash it into patch 13.

Regards,
Jared Rossi

