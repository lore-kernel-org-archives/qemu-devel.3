Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353E4C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MfS-0005tL-KV; Wed, 23 Sep 2026 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x9Meg-0005nI-Bd; Wed, 23 Sep 2026 09:05:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x9Mec-0005Wk-Pt; Wed, 23 Sep 2026 09:04:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Zgk81030882; Wed, 23 Sep 2026 13:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eeEEl+
 OoE958u1OuA/uzMpfqeLsNVfPcY3tMBdx8Q1o=; b=E1rmZxvS7QyGPcf8EBYfiU
 TUS5Nn+rKV1OJrNClX8nQDJVYX/LpG2rj8HPxP4evk+mx5+9nKGiE3IYWS49gWv2
 rTQygcBn0XVTo6ZnGmK7OwviIZQIfOZB8ZV+9K64s/fLdLPl8i4Sl8HoYsqQlcIy
 D6BHOOCdFnERzA5wmcCDVYmHOhrQyJfkTjwS77UtJieCe+Go9npUNJUeun19/93h
 B/e4ilOcx83I0yuujoV00sf/+mAdqamqOZgQ9hL38icEj09KZtQkw5IWhXf/w5zS
 ry2MedkfJlPzVP+uEleD/sLkK9WBAQFBKIElZ3umI//3fwtb2EmEnICKzAcWYGRA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ucm6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 13:04:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCLOxV008015; Wed, 23 Sep 2026 13:04:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qh2uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 13:04:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ND4m7f29819400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 13:04:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9A7558068;
 Wed, 23 Sep 2026 13:04:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 715D958059;
 Wed, 23 Sep 2026 13:04:47 +0000 (GMT)
Received: from [9.61.148.101] (unknown [9.61.148.101])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 23 Sep 2026 13:04:47 +0000 (GMT)
Message-ID: <05adb95a-cde9-4375-a905-536a85b31981@linux.ibm.com>
Date: Wed, 23 Sep 2026 09:04:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-5-zycai@linux.ibm.com>
 <165b19bf-cc35-4727-b117-53174a8ae58b@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <165b19bf-cc35-4727-b117-53174a8ae58b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HYmNfw74Jxh1uNJYxiEoLGIzzNeoSSSk
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab3ce72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=1IbQ5jq56SphWmOCr9MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfXyix+yhHQL3gm
 34BZqdYVT+wFMZIdrxq2u0RUWK9GuvBe0UFyCXXYdRlefLb2B8bXqWBhLPByOnp+iKwmA5OIXAn
 2rlF0rXwQFfgw39ganrLBv7oVbZMIWk=
X-Proofpoint-GUID: HYmNfw74Jxh1uNJYxiEoLGIzzNeoSSSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX+8c/pUlCa69G
 E7SPOCorqfVdveAKJ9ltvDfHXiSVwVNE2leYb2i3WJzFYys3szk+2LM8B3sacFKs7nvq3UDNKy7
 ncVVx1yFiFofLdPgtU8gPC6SLNlnqUrZMAR28mDII7vXzv+F2LpNGeYYJixnud0s6gEtG0KGK9U
 6wyCMCkeyXlWIoDDMayRh1QzL2ZD/tGLJ3UbzYXtLUpHgFbCh44HL7jjkaDm39AoVSBqB6ntNYQ
 mbae5daM3KHAHdJzMFzM03qbVS01y/AQzJmymKOwPO4/xvdU0uUJUNxTVEan7wc2suYmHu2k2oh
 q55NWfWg+jUo5nqT+AXoCiPT/IB+5/JsUZMwSb4589xF9KlMjYfDCdRE8zKIgWgzsx8oSQDhPLO
 ET1Ox7yoX+kcME4nUms+aq34Jk/Tcv6t0hRKK/E7/IUCwCzRKFIwkDtkG+ublBVsNYVfBQZtY4q
 xTIprjzixOO6uS8gSIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 9/22/26 5:35 PM, Matthew Rosato wrote:
> On 9/14/26 3:34 PM, Zhuoying Cai wrote:
>> Enable network booting via virtio-net-pci by implementing PCI transport
>> support for virtio-net.
>>
>> This patch also extends endianness handling for virtio PCI ring operations in
>> little-endian to ensure correct behavior on s390x.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c       |  1 +
>>   pc-bios/s390-ccw/netmain.c    |  9 +++++++-
>>   pc-bios/s390-ccw/virtio-net.c | 41 ++++++++++++++++++++++++++++-------
>>   pc-bios/s390-ccw/virtio-pci.c | 20 +++++++++++++++++
>>   4 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 8fc1cbf653..28cab3b411 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -332,6 +332,7 @@ static void ipl_pci_device(void)
>>       }
>>   
>>       switch (vdev->dev_type) {
>> +    case VIRTIO_ID_NET:
> block, scsi (when you rebase on top of Jared's series) and now net will
> all use the exact same code here by falling through.
>
> How about a comment block above the switch statement explaining they all
> intentionally fall through / use the same shared setup
>
>>       case VIRTIO_ID_BLOCK:
>>           if (virtio_setup() == 0) {
>>               zipl_load(); /* only return on error */
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index bcb62bf6ca..e42e049063 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -498,7 +498,14 @@ int netmain(void)
>>       sclp_setup();
>>       puts("Network boot starting...");
>>   
>> -    if (!virtio_ccw_net_setup()) {
>> +    /*
>> +     * CCW devices require subchannel enumeration here.
>> +     * PCI devices don't require specific setup: the transport is already
>> +     * initialized by ipl_pci_device(), and virtio_is_supported() is checked
>> +     * later in virtio_net_init().
>> +     */
> This comment seems not quite accurate?
>
> AFAICT ipl_pci_device() is just going to enable the PCI device, the
> transport isn't setup until
> virtio_net_init()->virtio_pci_setup()

To clarify this, please state that PCI devices do not need any specific
**net** setup.  The virtio-net-pci devices themselves still follow the
regular Virtio and PCI setup steps, plus generic network setup.

For Matt and anyone who might want more context, the virtio-net-ccw code
path contains some legacy code (relics of when the network and main BIOS
were built in separate binaries), which we were able to bypass for PCI, so
that is why virtio_ccw_net_setup() must be called here, but there is no
analogous virtio_pci_net_setup() needed.

Regards,
Jared Rossi


