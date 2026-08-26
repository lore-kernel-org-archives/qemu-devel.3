Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A8C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKZ8-0006e0-PY; Wed, 26 Aug 2026 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzKZ6-0006cr-P9; Wed, 26 Aug 2026 16:49:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzKZ5-0004ps-54; Wed, 26 Aug 2026 16:49:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1iRE314106; Wed, 26 Aug 2026 20:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3dxBK9
 SsNwe+tZz8r/7kJxM8nEcK4Fp+eM6MlUnmbqc=; b=S9Qr/WlsFFXFcYO6/7eM6A
 SEIG8MgVSCOZGSfQCMw85KfS8zecIYxOp7cuXt9cslxvQhiONv2sokk83FdSwUH+
 jxsEikzca3r34C0UTGGkkMhEwwqR0d+X1dEVG8g61MOFEayg1Z/mRuA3ZXkk2jsk
 p8eutaIYfx5smEIJk92TrsC6kIOJLYBZra9ONa3LBpAFgUmfAY55xonzNKPLIMh5
 4tCIIrXl81SU/4vkbsGMBXENPC4nJeN/asRUQ/SGQ6w+NwdGO9sT/93tPJI26xmB
 7xIhA+dNuQ2ZFa+W6v4UbbQIT7Rc8JDkrgoKltkPTimvLyy65IyL5jTxRl01gMAg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j1892-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:49:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKffPj016728;
 Wed, 26 Aug 2026 20:49:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwc7yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 20:49:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QKndZr53543392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 20:49:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41BF058063;
 Wed, 26 Aug 2026 20:49:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC5AF5804B;
 Wed, 26 Aug 2026 20:49:37 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 20:49:37 +0000 (GMT)
Message-ID: <b7a5f123-3da8-4d3a-b011-1f431c4bf1d9@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:49:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
 <b9dafa7d-d3d0-46c7-8ef1-c800811181dc@linux.ibm.com>
 <3b52a781-ea4c-4fec-b059-bebecc27ad3f@linux.ibm.com>
 <91c8fb44-fcc0-4c94-8494-084d6eaa6504@linux.ibm.com>
 <59fcd3e6-e0aa-4078-b36d-e7d51a4f4558@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <59fcd3e6-e0aa-4078-b36d-e7d51a4f4558@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3MiBTYWx0ZWRfX1j0a3XmtWiXS
 /BEvN8Xd8PhMmd4Lf6HV4BpvtGk4u4iMGjrJGLEY2I0GdQ6Vs6cuQ2AULuIvNstj3UXjLAlLLFs
 expyJvQZwtknWh7DgV5dEvzQUxyaMAQ=
X-Proofpoint-GUID: whSEJNEs9iTbZNPYr8pGgNBaSFDcQQDn
X-Proofpoint-ORIG-GUID: whSEJNEs9iTbZNPYr8pGgNBaSFDcQQDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3MiBTYWx0ZWRfX4kQn4IQrP2QF
 0ls/VzqGolHWMRaHJwnyqItiUhnKd+Y4ohEEGoJ7NpCB/kSkdPO1g30cbCae2dh6y6Cp1Plv5GO
 pJSiD1AVMNNkKBxpk0ae2WQhRmLLv/eAfGWknltbUDaVaM9sBIFjftvrZtut1KW/6QbK2a4wX6V
 ZiZAchkZu11R1xv3xmj2sasIKDcJsWZYnnLc+CDWevk3Cv2ZnbheabeoP4EhGmpRNSym/z51jp2
 BpMfmfLLVsiC+fZLB/GiznT495BA4od0zOJALkcEsvWpdCQu6uCaZLmqcPKyzYyOlrVdI0OU+8h
 US6BsXPTz4Hs9eY6X89b8Cj/B0l5s3uddvkFhwN5W/BatjLYyLElAHGaq9HWcNJF5IQ6D14+Qvr
 ETgLN4v2sCS9lbzRLiY54Ar2JRSaCx1F8d7YbiEW7T2flM5DBF0GmvOBA1MxoJOR8ZG9+B9/hzk
 8MiL2ANWh3yKfafKsKQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f5165 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=jOqbC_jMK-9XrsKtnDsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260172
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/26/26 4:23 PM, Jared Rossi wrote:
> 
> 
> On 8/26/26 3:41 PM, Matthew Rosato wrote:
>> On 8/26/26 3:30 PM, Jared Rossi wrote:
>>>
>>> On 8/26/26 1:33 PM, Matthew Rosato wrote:
>>>>> +bool virtio_net_setup(void)
>>>>> +{
>>>>> +    switch (virtio_get_device()->ipl_type) {
>>>>> +    case S390_IPL_TYPE_CCW:
>>>>> +        return virtio_ccw_net_setup();
>>>>> +    default:
>>>>> +        return false;
>>>>> +    }
>>>>> +}
>>>> This patch is largely renaming, but this does seem to have a subtle
>>>> functional change right here.
>>>>
>>>> AFAICT before this patch attempting to netboot with anything other than
>>>> a ccw device would hit
>>>> IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
>>>>
>>>> Now, we will never call virtio_ccw_net_setup(), return false and
>>>> instead
>>>> bail out with
>>>> "No virtio net device found."
>>>>
>>>> That is new behavior for !IPL_TYPE_CCW after this patch.  For
>>>> IPL_TYPE_PCI, patch 4 will change the behavior again.
>>>>
>>>> That's not a deal-breaker, but I do think it's worth a mention in the
>>>> commit message.  I then also wonder if the message
>>>> "No virtio net device found"
>>>> would be more accurate if it instead read something like:
>>>> "No supported virtio net device found"
>>>>
>>>> Thanks,
>>>> Matt
>>>>
>>> I’m not sure this is a valid concern.  A non-ccw net device would be
>>> rejected before getting to virtio_net_setup() earlier at the
>>> find_boot_device() step either way.  In the case of virtio-net-pci
>>> specifically, it would fail because VIRTIO_ID_NET is not a supported PCI
>>> type yet.  For some sort of non-ccw non-pci netboot device, I believe
>>> there
>>> wouldn't ever be an IPLB built for it, so it wouldn’t be recognized as
>>> boot eligible at all.  I don’t think this patch affects any of that.
>>>
>>
>> Based on that description it sounds like we don't even ever to expect to
>> reach the new default: case then, as prior checks should have already
>> weeded out all but the supported IPL_TYPE_* values.
>>
>> Should the default: case have an IPL_assert with its own message then?
>
> Right, we shouldn’t ever hit the default case, but I don’t follow your
> suggestion about an IPL_assert.  What condition might be asserted there?

Since it's a switch statement looking at the type value would be
redundant, but something like
IPL_assert(false, "unexpected IPL type");
should work

> 
> In my opinion simply returning false is appropriate, which will just print
> the error and move on to the next boot device if there one.  A full panic
> could be justified since something weird would need to happen to get into
> the default case at all, but I don’t think it’s really necessary.

Yeah, my line of thinking was that if we shouldn't reach this code but
somehow do, then something unexpected happened but we would kind of mask
that by simply moving onto the next device.

> 
> If virtio_net_setup() does fail though, regardless of why, I do agree the
> subsequent error message needs to be updated to clarify that no “valid” or
> “supported” virtio network device was found rather than stating none was
> found at all.
> 
I leave it up to you and Joy to decide if you feel it makes sense to
assert or update the message to be more accurate, but please do at least
one of those.

Outside of that, this patch LGTM.

Thanks,
Matt

