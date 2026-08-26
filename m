Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796E5C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzK9O-0007qs-LP; Wed, 26 Aug 2026 16:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzK9M-0007q9-Cz; Wed, 26 Aug 2026 16:23:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzK9K-00073U-Nu; Wed, 26 Aug 2026 16:23:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH2Cu3315411; Wed, 26 Aug 2026 20:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bY0xV1
 AKP5GrHGqc4919qgq2mFpHodLGKyQhmpjzg58=; b=nmQWNKLlcFQA8es6HmstWK
 nQ7VulgrATOKGlKT3cMo8KWauNG2NSE3rys14b6gFgdGP2mOTtryhiVrvQPTsrJI
 ZiJxRE6KQaN0hJe95juy4cOKmysgISoNGcen9cMUNU/VC6Rp4JXBFZUOoLzrG91g
 4mXJYq2zacYSQRkmbLJnbLU1K4MObmz7Zqd4GTEe7m3inN+TQ9okMSucYCrNUUjv
 rWswTBePs8c1VyMMuzdS4zvVMlxEAUlxRrEUiPW1uvbqFHHhIdUrotTZDnXRZTEq
 kRhKD7vy0UTz3zst+1jBRE1GiVe58tKwJD9GQQ1QspK7ssvclM521leH2tjB1kpw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j142f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:23:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKBJTW019876;
 Wed, 26 Aug 2026 20:23:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsybr01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:23:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QKN2Tg3670728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 20:23:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2A7658055;
 Wed, 26 Aug 2026 20:23:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F401D58043;
 Wed, 26 Aug 2026 20:23:01 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 20:23:01 +0000 (GMT)
Message-ID: <59fcd3e6-e0aa-4078-b36d-e7d51a4f4558@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:23:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
 <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
 <3b52a781-ea4c-4fec-b059-bebecc27ad3f@linux.ibm.com>
 <91c8fb44-fcc0-4c94-8494-084d6eaa6504@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <91c8fb44-fcc0-4c94-8494-084d6eaa6504@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE2OCBTYWx0ZWRfX375yuP59ArBW
 8oGGXd9ik4U/7lMxJ+XM7LgB+uDThgJqNP8CQWQTsBS0vcYWCGLs5+Oh+fPiZniBNKuKNt1vOQK
 qd98FXxmRj8QpveoR7Kd7sOIRYnIAUM=
X-Proofpoint-GUID: BqMVVwq6GNds5KKeSgVnGMptX_o3bgIU
X-Proofpoint-ORIG-GUID: BqMVVwq6GNds5KKeSgVnGMptX_o3bgIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE2OCBTYWx0ZWRfX6hOm99+KcgVN
 H0FSq0MztujFi0vxUzyRq3GJukXHrmAwDupG3/eD/C/8lXQVdrnqOjmQG8SZJEoJg2mnnIgGWxR
 UAiOH4XrR4tIeFFmmhyWlqIvRzLHXlLVHi3SqxDduhecSlE9cq4e7G48a90+cWd6W2cB6U8tfsv
 4Tmjf/ObF3JtYv/HBzFs0Bb1EH67u4rstZPXatTCgl/28vQ+Lsb+gsLtdqy0lTg6vfsMG1lY+h9
 LLyCVlvuV5PIcqXkx7PK0l3drKksFq7HcR3+xZ9FnjS6KGPYw/NqqfwZtKXFCLDU3N/euZulRcp
 T+JHktdOxQ0Jnetko5QKgLhhO2b4bsAKuVkCmkc49X4QSgEdkpN18mBZOqJcghvnfBtuS9BoNIv
 EYThfrjX/Neuzxf8iB9xAeegSjwr3ZHmIb0gHl7AeWU+hyp7MPGOvzyULIXDm1zQwwpD8+5ajil
 Kx2bRbvqg32yBoFqCBQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f4b28 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=MqwOBbq6WWZUD7j1rucA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260168
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 8/26/26 3:41 PM, Matthew Rosato wrote:
> On 8/26/26 3:30 PM, Jared Rossi wrote:
>>
>> On 8/26/26 1:33 PM, Matthew Rosato wrote:
>>>> +bool virtio_net_setup(void)
>>>> +{
>>>> +    switch (virtio_get_device()->ipl_type) {
>>>> +    case S390_IPL_TYPE_CCW:
>>>> +        return virtio_ccw_net_setup();
>>>> +    default:
>>>> +        return false;
>>>> +    }
>>>> +}
>>> This patch is largely renaming, but this does seem to have a subtle
>>> functional change right here.
>>>
>>> AFAICT before this patch attempting to netboot with anything other than
>>> a ccw device would hit
>>> IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
>>>
>>> Now, we will never call virtio_ccw_net_setup(), return false and instead
>>> bail out with
>>> "No virtio net device found."
>>>
>>> That is new behavior for !IPL_TYPE_CCW after this patch.  For
>>> IPL_TYPE_PCI, patch 4 will change the behavior again.
>>>
>>> That's not a deal-breaker, but I do think it's worth a mention in the
>>> commit message.  I then also wonder if the message
>>> "No virtio net device found"
>>> would be more accurate if it instead read something like:
>>> "No supported virtio net device found"
>>>
>>> Thanks,
>>> Matt
>>>
>> I’m not sure this is a valid concern.  A non-ccw net device would be
>> rejected before getting to virtio_net_setup() earlier at the
>> find_boot_device() step either way.  In the case of virtio-net-pci
>> specifically, it would fail because VIRTIO_ID_NET is not a supported PCI
>> type yet.  For some sort of non-ccw non-pci netboot device, I believe there
>> wouldn't ever be an IPLB built for it, so it wouldn’t be recognized as
>> boot eligible at all.  I don’t think this patch affects any of that.
>>
>
> Based on that description it sounds like we don't even ever to expect to
> reach the new default: case then, as prior checks should have already
> weeded out all but the supported IPL_TYPE_* values.
>
> Should the default: case have an IPL_assert with its own message then?

Right, we shouldn’t ever hit the default case, but I don’t follow your
suggestion about an IPL_assert.  What condition might be asserted there?

In my opinion simply returning false is appropriate, which will just print
the error and move on to the next boot device if there one.  A full panic
could be justified since something weird would need to happen to get into
the default case at all, but I don’t think it’s really necessary.

If virtio_net_setup() does fail though, regardless of why, I do agree the
subsequent error message needs to be updated to clarify that no “valid” or
“supported” virtio network device was found rather than stating none was
found at all.

Regards,
Jared Rossi

