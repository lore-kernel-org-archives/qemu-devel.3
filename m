Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E3C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41SE-0000oJ-0F; Tue, 08 Sep 2026 15:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x41SC-0000jh-A6; Tue, 08 Sep 2026 15:26:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x41SA-0003WU-4z; Tue, 08 Sep 2026 15:26:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1Trb1232924; Tue, 8 Sep 2026 19:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f4pB8v
 ZAvIROSqPjV965hDOEURe6VjsmHMPTHiCZ754=; b=HbOCyQ9xyZJ09uhPSqs3Q3
 TJwbbqaz+kh0cgmwZGUj8LWLAp4sfCQXmPynjOAYJrRRL4PFlWsGXp3IXOWu4Yqg
 3I+NHbJMz9fp6dBSuo/3Nhhx/NQux5h8yDbqJv3ex5Vhrbw1TK535PiBwxQ/Z/KG
 bB7+hlQhkTh8TNaADxOJrjM4pv3+j6A+8VOi3XjdqiYDQdDGJDz0ZNAH70lwgyjJ
 5JEDQGInpOs1kB+nTckEx6yMSB6Dz1sqihbV1gtMdIZAYUXo7K1XjvYpAR2KF7W2
 9pCYYATSGoFR1tzCANzzn8r51tMuMABd1GVfUr9bBLoJOjzh4AVf7A9KR2kLIJxg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf41e1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 19:25:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688JBIW6030279;
 Tue, 8 Sep 2026 19:25:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw622b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 19:25:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688JPpHk34079344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 19:25:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE55D58059;
 Tue,  8 Sep 2026 19:25:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F72B58058;
 Tue,  8 Sep 2026 19:25:51 +0000 (GMT)
Received: from [9.61.245.52] (unknown [9.61.245.52])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 19:25:50 +0000 (GMT)
Message-ID: <f7a362b5-fd79-4ccb-a2af-29e802ca8ddc@linux.ibm.com>
Date: Tue, 8 Sep 2026 12:25:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Error recovery for zPCI passthrough devices
From: Farhan Ali <alifm@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 armbru@redhat.com, Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <a5dea766-1131-49cb-bd26-6a09673b176e@redhat.com>
 <e6dfaf88-e1af-4744-baa2-ef1d760e0bd0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e6dfaf88-e1af-4744-baa2-ef1d760e0bd0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8tpMhWV9gxAPl4K8HNsroS_YJxZsJBq7
X-Proofpoint-GUID: 8tpMhWV9gxAPl4K8HNsroS_YJxZsJBq7
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa06142 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=NEAV23lmAAAA:8 a=gO1p6hVbrQ49QzXqqX0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX/OTFrKYZPNFQ
 /tSBifa1qEEbOyH4wFhPBCTEG356C62x8IAI2GebVuRgpTBUqzsoFOKsv//vnlZ24YsjBu1XnRH
 VAU9KaLutCsthWbVth5T3m+ofZqMMkAZCSgDeITAFvHaK+2YPayvPKtjwMugGvuo9MbS56iNKdD
 B4ChaQ5DtlJyYLYHulfxloiUVZixr6XWSTlw91XJpmaliJ6Bm8o91HLAxXpxK/3+YDD5cJ18Qsk
 +Q0OHfvVgEGt1Kj5QCYmi/VB8Z1iaO0XkW9GvwlARIaDuJkwPi2mf8sh+cabdSxDcfmp28qDDOA
 fP5zueAepseNPioygw3kN8wmYTjsvAI+HmwRAMYdV7K3QgDUl69O8K8Ig3YBBxJWgbbaW/w1lZ+
 YPA8pku7nTjvvOroKfmYUQ5j2iP161Ahvif0NrFP7Q2UVezkcjrroxDxAdszoT4zMZhkoxUWWwu
 PpFlYLkf6AuCIavvFTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX6UZcQWXDUqcA
 fwfD9ZRo0ngeDA00N3v/6fhfjqtBnxgQqB+cREesV5tQXXllT91WnHZkwW9ObMYpOgiq3M+8OJQ
 SfhWxADvJIO/NikRxsQGkntQ8BApIro=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080207
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/3/2026 10:55 AM, Farhan Ali wrote:
>
> On 9/3/2026 2:19 AM, Cédric Le Goater wrote:
>> On 8/31/26 20:31, Farhan Ali wrote:
>>> Hi,
>>>
>>> This patch series introduces support for error recovery for 
>>> passthrough PCI
>>> devices on System Z (s390x). This is the user space component for 
>>> the Linux
>>> kernel patches [1]. The kernel patches were merged for 7.3 and it 
>>> had some
>>> significant changes in VFIO API since the last QEMU series was 
>>> posted. But the
>>> design for QEMU component is still the same.
>>>
>>> For QEMU on eventfd notification for PCI error from vfio-pci driver 
>>> we call the
>>> vfio error handler. We can use a per device error handler callback 
>>> to override
>>> the default vfio error handler.  For s390x specific error handler, 
>>> we retrieve
>>> the architecture specific PCI error information and inject the 
>>> information into
>>> the guest. Once the guest receives the error information, the guest 
>>> drivers will
>>> drive the error recovery.  Typically recovery involves a device 
>>> reset which
>>> translate to CLP disable/enable cycle for the device.
>>>
>>> I would appreciate some feedback on this patch series.
>>
> Hi Cedric,
>
>> Hi Farhan,
>>
>> Have you seen Shameer's kernel series for PCI error recovery [1] ?
>> It uses a dedicated eventfd registered via VFIO_DEVICE_FEATURE_SET,
>> with a self-contained handler independent of the legacy err_notifier.
>>
>> The QEMU side [2] just probes the feature, installs the eventfd, and
>> suppresses the legacy vm_stop path with a bool flag : no callback in
>> generic VFIO PCI code, which is cleaner.
>>
>> This is also the pattern used by the other s390 VFIO devices: vfio-ccw
>> has three dedicated eventfds (io_notifier, crw_notifier, req_notifier)
>> and vfio-ap has two (req_notifier, cfg_notifier).
>
> My thought process was to use the existing legacy err_notifier and let 
> each vfio-pci device handle the error. I thought the callback would 
> also provide some flexibility on each device handling the error.
>
> I can take a look at Shameer's approach and see if its something we 
> can do. Just briefly looking at the QEMU code, it looks like it it 
> ties the eventfd to the generic vfio-pci code (of course this is in 
> flux). This would become problematic for s390x as unfortunately AER 
> recovery will not work for zPCI devices due to platform firmware being 
> involved in the recovery process.
>
>> For zPCI, it would mean extending VFIO_DEVICE_FEATURE_ZPCI_ERROR to
>> support SET with an eventfd field. The ABI is still new so the struct
>> can be extended, keeping the s390 error recovery code self-contained,
>> with no changes to generic VFIO  PCI code. I think this approach is
>> preferable.
>>
> I would like to get some feedback from Alex to see if we could extend 
> the ABI.
>
>
I had been thinking about this a bit more, and I think having a another 
eventfd for s390 to just notify on error would just be unnecessary 
duplication. Because now we will have the legacy err_notifier + s390 
error notifer eventfds for the same purpose but with different handlers. 
Can we replace fd handler for the legacy err_notifier from 
vfio_err_notifier_handler() to an s390 specific handler for s390 
devices? This would also avoid any callback in the vfio core common code.

Thanks

Farhan

>
>
>> Thanks,
>>
>> C.
>>
>> [1] 
>> https://lore.kernel.org/all/20260901093217.8539-1-skolothumtho@nvidia.com/
>> [2] 
>> https://github.com/shamiali2008/qemu-master/commit/e45458710cd8509fa5bd81f4376126b77b6f40be
>>
>>
>

