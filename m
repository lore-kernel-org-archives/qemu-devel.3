Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C846C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJUm-0007Wg-LL; Wed, 26 Aug 2026 15:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzJUk-0007Kw-H2; Wed, 26 Aug 2026 15:41:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wzJUi-0006Eg-Mm; Wed, 26 Aug 2026 15:41:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QH1qC32743328; Wed, 26 Aug 2026 19:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mZOgRs
 TZFic1nRQURC9FAXxTJAz+8KIxtpBvFx9zoTk=; b=jM/RmQZQv7/BmZ2Cn7ymxb
 mkExcpMet48U8s6awzhGr8WDvSSOrIXP/mUkFbpGbKJSI0W/VEiRjNq0+kgzP8sN
 qhzBTCQQ+O4OzC94bf780CG42GUkxUcAApHGPIx1jKUDULNcHKc6JYt1GVtP9hV5
 C3MQUfJZucDeWclsCvJLgX7Tauu1h9RU7lYkmgIbjyraIN1CmMbaLY+lPHnVid7T
 4vN+fbq6h34FfIpta9gwdbKxmEl9P4FDOMw60HBIGe/jLEWO0jMafFYB2ymG2GEY
 UEwubB+sNTnbRv32C032c5s6M4YM6pQATIIyYJnFiqRJSHT+pD/N317ucrQsvwOA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er0rd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 19:41:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QJQHmJ025825;
 Wed, 26 Aug 2026 19:41:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsybhj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 19:41:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QJf2dm30802442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 19:41:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E6D95805D;
 Wed, 26 Aug 2026 19:41:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6869158057;
 Wed, 26 Aug 2026 19:41:01 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 19:41:01 +0000 (GMT)
Message-ID: <91c8fb44-fcc0-4c94-8494-084d6eaa6504@linux.ibm.com>
Date: Wed, 26 Aug 2026 15:41:00 -0400
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
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <3b52a781-ea4c-4fec-b059-bebecc27ad3f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a6Uit-bRpJo_oYiLiRLg9sIZQ0Li4pxp
X-Proofpoint-ORIG-GUID: a6Uit-bRpJo_oYiLiRLg9sIZQ0Li4pxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE2NCBTYWx0ZWRfX7FwtOt7pfPDq
 muIalXlQXI7e/if8YoUqNe+IIA773K+yA6fEaqJFJawRIl3E7+1DBXsDU0y8G3TDcz7S+qi7mzt
 IGwAQFr2WpdqcdWmGNOF6TY/IHyI+61onzhS5u30nORtATStYqkQ9Iotmjh7OG3JVpsCnT5hnCW
 2Zwg3IoRVhYsVLrYkArY6D/zg1CIj+yavng5MbejrosMwLY/kd1tLJ3/pBohY64XWYr9y45DO+g
 hoPUPYJGpIpYZTc5Bxt0bmzQncl9w8plFQE0HNJl3pGVio2C4w63IAZV6IFUxnkXnfHWB0VgJEn
 YjwumdcALYEI7VvYeei15mpZN+jDoxZOvqhi/F7Mhdn6oseN5XqWqNveWEA99epP8NucuYW3yhl
 JrIWZzqpBo8cpLNFy5JcSlPRTpVtuOIw2wDdsASPcBq7iHk+iEYct4vNKVQM7aFWF+b/NkaYPBB
 mZkBISTXsPIjrHGWVbg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f4151 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=_hCw1mCnnE6vsVbhuAAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE2NCBTYWx0ZWRfXzbUfiwM1jqC/
 0/2TOR8bWAw5jV3cFe/LWdEnCBxcWgiMA3hDmHaokukJtg2J+olHZu2IMwLGn7Ec/A7Uu/lrfDw
 hcz7jhIm70dBhEkn6UNsWuXr+do77Q4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260164
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

On 8/26/26 3:30 PM, Jared Rossi wrote:
> 
> 
> On 8/26/26 1:33 PM, Matthew Rosato wrote:
>>> +bool virtio_net_setup(void)
>>> +{
>>> +    switch (virtio_get_device()->ipl_type) {
>>> +    case S390_IPL_TYPE_CCW:
>>> +        return virtio_ccw_net_setup();
>>> +    default:
>>> +        return false;
>>> +    }
>>> +}
>> This patch is largely renaming, but this does seem to have a subtle
>> functional change right here.
>>
>> AFAICT before this patch attempting to netboot with anything other than
>> a ccw device would hit
>> IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW expected");
>>
>> Now, we will never call virtio_ccw_net_setup(), return false and instead
>> bail out with
>> "No virtio net device found."
>>
>> That is new behavior for !IPL_TYPE_CCW after this patch.  For
>> IPL_TYPE_PCI, patch 4 will change the behavior again.
>>
>> That's not a deal-breaker, but I do think it's worth a mention in the
>> commit message.  I then also wonder if the message
>> "No virtio net device found"
>> would be more accurate if it instead read something like:
>> "No supported virtio net device found"
>>
>> Thanks,
>> Matt
>>
> 
> I’m not sure this is a valid concern.  A non-ccw net device would be
> rejected before getting to virtio_net_setup() earlier at the
> find_boot_device() step either way.  In the case of virtio-net-pci
> specifically, it would fail because VIRTIO_ID_NET is not a supported PCI
> type yet.  For some sort of non-ccw non-pci netboot device, I believe there
> wouldn't ever be an IPLB built for it, so it wouldn’t be recognized as
> boot eligible at all.  I don’t think this patch affects any of that.
>


Based on that description it sounds like we don't even ever to expect to
reach the new default: case then, as prior checks should have already
weeded out all but the supported IPL_TYPE_* values.

Should the default: case have an IPL_assert with its own message then?

Thanks,
Matt


