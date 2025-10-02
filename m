Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F2FCCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JS6-0005PK-RV; Thu, 02 Oct 2025 09:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v4JS1-0005Ia-1T; Thu, 02 Oct 2025 09:34:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v4JRf-0004JK-TA; Thu, 02 Oct 2025 09:34:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5926uaCd006470;
 Thu, 2 Oct 2025 13:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ovOEfM
 7o16m2W8NXvLc2lmWvR/n1jmSCwIbRGtjT1BE=; b=B6Guzp04vDEgG5mKBXO1i4
 emJ4XzmWxgTJIvdrhuVfHR+9wKF/TW4b5cLl2fZmSujv149duegbDr7lq+VZv9xE
 7YIV20uu2rBUDTEqz7UFq6uh0Lgeji4cRPlajey6ASfrUCWPYuxoRrIl0uEuw4P+
 snhOf0H5A9hGaXtmV8bw4oEcEybOL1BFaBqfe2WRqwRyZR7lRWNP/jiBGOZrVkzl
 i/GP4qlGlrF7TwW8V2zVyIpRQd/Bk5PfTCNo6anw7UjCv/AeMG45ntu5lJQ7b4x+
 SgCjH9Xf1Tvjc9VL0g7PrHWlRuyPD12XhLPfB7UYXmCyqEAeKU+b6gYBnZDmlH6w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n85myg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:33:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592AGNJI001543;
 Thu, 2 Oct 2025 13:33:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfjdv6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:33:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592DXsMq18285098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 13:33:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF50158053;
 Thu,  2 Oct 2025 13:33:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1A8258043;
 Thu,  2 Oct 2025 13:33:53 +0000 (GMT)
Received: from [9.61.10.212] (unknown [9.61.10.212])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 13:33:53 +0000 (GMT)
Message-ID: <51dcc8e5-3ab4-4416-96f0-55daef22dcbb@linux.ibm.com>
Date: Thu, 2 Oct 2025 09:33:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/pci: set kvm_msi_via_irqfd_allowed
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, qemu-devel@nongnu.org
References: <20251001200511.325815-1-mjrosato@linux.ibm.com>
 <8182adea-f81a-4652-9fdd-132dc43ae690@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <8182adea-f81a-4652-9fdd-132dc43ae690@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A--VTwDXG33bZHqLrsBPkEayU7kZitrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX4AB/RL1uZj2P
 fPWjet1iedvbxQXEkZk0tK7FkeSuwSUb0oMwx5n6oSfACJ6VronaTmZkvaFJISLnh2XhDA58NsH
 D33396WX0ZYIB4bHzyOCcoxOBWmFh5sUrscgfhk1LwJc9waOUfakUIPP8CmeVLvicxc7u5jNJM4
 8/PaeWzfeXpuhWOFiHMY3cqJRHY0b6iikuriwfCfPpyY7cttcrSiL0U16ZdPedq1dZzcTnYmivx
 8O9YKPfz8UrOSlbn6x7aWiUbaNdZbFPlcP6LpWQ488/CnpNlk4/9iaehpr9GbRkzygjF6hdCTxU
 6+YPT+KOJZqSwA29ogE/t0kJGjDDBHlA+CZf5VPm/cjL5utw4YtkiGaYEreVrB5vFn5EUkfEAA7
 d9cjmaHxDT0JNs590V2d7LMU7PVmAg==
X-Proofpoint-GUID: A--VTwDXG33bZHqLrsBPkEayU7kZitrW
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68de7f45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=TKW_Ob0L0fbEmujZKtQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/2/25 3:27 AM, David Hildenbrand wrote:
> On 01.10.25 22:05, Matthew Rosato wrote:
>> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
>> it.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index e8e41c8a9a..88852acf45 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>>       s390_pci_init_default_group();
>>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>>                                S390_ADAPTER_SUPPRESSIBLE, errp);
>> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
> 
> Just wondering, what's the net result of this patch?
> 

It allows the virtio-pci core code on s390x to ever decide using irqfd is OK (e.g. without this change we would always reach virtio_queue_set_guest_notifier_fd_handler(..., with_irqfd=false) because kvm_msi_via_irqfd_enabled() was guaranteed to be false.

> I assume better performance. Might be worth adding that "why" to the patch description.
> 

And yes, in a nutshell it means better performance.

How about something like...

Allow irqfd to be used for virtio-pci on s390x if the kernel supports
it.  This improves s390x virtio-pci performance when using kvm
acceleration by allowing kvm to deliver interrupts instead of QEMU.

