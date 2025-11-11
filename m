Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FEBCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 20:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIuoK-0007Bg-8D; Tue, 11 Nov 2025 15:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vIuo7-00079i-MT; Tue, 11 Nov 2025 15:17:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vIunz-0007vx-5k; Tue, 11 Nov 2025 15:17:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABDhtEo005450;
 Tue, 11 Nov 2025 20:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dcuues
 IDpeFzit+/CL8uBX4evemBeJj/7pCcA2Hb/pU=; b=ZCDXIekRmDbUOt9TsYXeO0
 jye6XELKZJiL5fBqwuj4YqM4GhwJ2CdhYFzynU8h9XSQcubg1TcQl3og1aV8rGMg
 dI9KIR5HBXQPrkAsYxS1X/Sa1AXLlPC3hhlGSFWRk/69cr9NdW0pDZryxQFveU14
 bMKodKsd3L/yIX85fc2jo+jzmfskUBD28Br74bzdANY97QDi7vMNfOtg3359uYwm
 svvy9JILkvtW3Iew1m2Ljb/gvpEjI299DzFxcL6ivyr7BHTh8iaSuxUmad1lDsAg
 d7PrL4jr5efme3k1d0jqYwIm11BjWJfDroeMYNOp7FDmleBkdAQ/i7qKZokXvPfQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc777tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 20:17:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABHQ8uV008239;
 Tue, 11 Nov 2025 20:17:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mvn5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Nov 2025 20:17:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ABKHJjB61014466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 20:17:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 212CA58055;
 Tue, 11 Nov 2025 20:17:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2912458043;
 Tue, 11 Nov 2025 20:17:18 +0000 (GMT)
Received: from [9.61.37.77] (unknown [9.61.37.77])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 11 Nov 2025 20:17:18 +0000 (GMT)
Message-ID: <9b157225-ebf1-417f-aa54-3968589b262e@linux.ibm.com>
Date: Tue, 11 Nov 2025 15:17:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <09faff84-3245-4704-aab6-e7cbb76e1130@redhat.com>
 <89a7f911-4d50-4e03-a64e-b11e866f3bd0@linux.ibm.com>
 <2657323b-6172-4795-a3b4-f98f26262daf@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <2657323b-6172-4795-a3b4-f98f26262daf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXxhVtYzGg/ZTo
 MPJB7EGbY+vDFy+NwG1JjYEAxKeIZE0wCBLLUuMWQTmCpfIN2/7wZq89MB6FcE8QjrmJe1D/JG1
 pgD8Cs4OiUBg40juV8RCnSYoy85iKS8FGpfkThmlQMGsL9zomopRTgB/Q6yRgkzWOE83VkUCNmN
 GyAM0Q6jW1cAuCKcO0twH/z0DZyFvy5TsfyXfW80o65oiD9xsHWqt0tjLEe6ZBJDn4Tg7hDNQKh
 6lfzG/5abZ5M08FPq+3Fo8Ke3Kan+2Y+FJBSwuxaFckVDSsba0hmCWOvM9NlqRGjE+LO6qb4Nmu
 buInXNdmdITK0FbFYQ8Mjg0OzuGLULkmdlpaqGjE4opAmMKHfNwUWABLBdM5plxEBk4RucZvhBs
 RD6eZ+EB3ydL94M0sDK5TgL3T3Jceg==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=691399d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YRHvXXt1AAAA:8 a=2PPi8XF69M-sME1U0VQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9bw_jnHfPby8klRCszyn:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: sQddz3X9La06IDNqpyXdCcfs_P3mBaGI
X-Proofpoint-ORIG-GUID: sQddz3X9La06IDNqpyXdCcfs_P3mBaGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 11/10/25 6:01 AM, Thomas Huth wrote:
> On 05/11/2025 20.21, Zhuoying Cai wrote:
>> On 9/26/25 8:38 AM, Thomas Huth wrote:
>>> On 18/09/2025 01.21, Zhuoying Cai wrote:
>>> ...
>>>>    crypto/meson.build                  |   5 +-
>>>>    crypto/x509-utils.c                 | 423 +++++++++++++++
>>>>    docs/specs/s390x-secure-ipl.rst     | 165 ++++++
>>>>    docs/system/s390x/secure-ipl.rst    | 181 +++++++
>>>>    hw/s390x/cert-store.c               | 213 ++++++++
>>>>    hw/s390x/cert-store.h               |  39 ++
>>>>    hw/s390x/ipl.c                      |  62 +++
>>>>    hw/s390x/ipl.h                      |  27 +-
>>>>    hw/s390x/meson.build                |   1 +
>>>>    hw/s390x/s390-virtio-ccw.c          |  52 ++
>>>>    hw/s390x/sclp.c                     |   2 +
>>>>    include/crypto/x509-utils.h         | 131 +++++
>>>>    include/hw/s390x/ipl/diag308.h      |  34 ++
>>>>    include/hw/s390x/ipl/diag320.h      |  91 ++++
>>>>    include/hw/s390x/ipl/diag508.h      |  38 ++
>>>>    include/hw/s390x/ipl/qipl.h         |   7 +-
>>>>    include/hw/s390x/s390-virtio-ccw.h  |   3 +
>>>>    include/hw/s390x/sclp.h             |   4 +-
>>>>    pc-bios/s390-ccw/Makefile           |   3 +-
>>>>    pc-bios/s390-ccw/bootmap.c          | 107 +++-
>>>>    pc-bios/s390-ccw/bootmap.h          |  11 +
>>>>    pc-bios/s390-ccw/iplb.h             |  96 +++-
>>>>    pc-bios/s390-ccw/jump2ipl.c         |   6 +-
>>>>    pc-bios/s390-ccw/main.c             | 111 +++-
>>>>    pc-bios/s390-ccw/netmain.c          |   8 +-
>>>>    pc-bios/s390-ccw/s390-ccw.h         |  19 +
>>>>    pc-bios/s390-ccw/sclp.c             |  52 ++
>>>>    pc-bios/s390-ccw/sclp.h             |   7 +
>>>>    pc-bios/s390-ccw/secure-ipl.c       | 781 ++++++++++++++++++++++++++++
>>>>    pc-bios/s390-ccw/secure-ipl.h       | 212 ++++++++
>>>>    qapi/machine-s390x.json             |  22 +
>>>>    qapi/pragma.json                    |   1 +
>>>>    qemu-options.hx                     |  10 +-
>>>>    target/s390x/cpu_features.c         |   7 +
>>>>    target/s390x/cpu_features.h         |   1 +
>>>>    target/s390x/cpu_features_def.h.inc |   5 +
>>>>    target/s390x/cpu_models.c           |   7 +
>>>>    target/s390x/diag.c                 | 555 +++++++++++++++++++-
>>>>    target/s390x/gen-features.c         |   7 +
>>>>    target/s390x/kvm/kvm.c              |  34 ++
>>>>    target/s390x/s390x-internal.h       |   4 +
>>>>    target/s390x/tcg/misc_helper.c      |  14 +
>>>>    42 files changed, 3488 insertions(+), 70 deletions(-)
>>>>    create mode 100644 docs/specs/s390x-secure-ipl.rst
>>>>    create mode 100644 docs/system/s390x/secure-ipl.rst
>>>>    create mode 100644 hw/s390x/cert-store.c
>>>>    create mode 100644 hw/s390x/cert-store.h
>>>>    create mode 100644 include/hw/s390x/ipl/diag308.h
>>>>    create mode 100644 include/hw/s390x/ipl/diag320.h
>>>>    create mode 100644 include/hw/s390x/ipl/diag508.h
>>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>>
>>>    Hi,
>>>
>>> looking at the file list, there does not seem to be any test in this series
>>> ... could you please add some functional tests to make sure that the feature
>>> is working as expected?
>>
>> I’m currently working on the functional tests for secure IPL and have
>> encountered a few blockers, so I wanted to reach out for some guidance.
>>
>> The main challenge is determining how to provide signed components and
>> signatures within the tests. In a manual secure IPL setup, we would
>> generate certificates, use the sign-file script to sign the components
>> (stage3 binary and kernel), and prepare zipl inside the guest.
>> Additionally, the signed components would include Secure Code Loading
>> Attribute Blocks (SCLABs) appended for further validation. These steps
>> are difficult to reproduce in a functional test environment.
>>
>> Our current idea is to create a bootable image using the SCSI scheme
>> with a minimal boot map that includes fake signed components with
>> hard-coded signatures (and SCLABs if feasible), similar to the approach
>> used in prepare_image() in tests/qtest/cdrom-test.c. However, this
>> approach is more complex than expected, and we are unsure how viable it is.
>>
>> Do you have any suggestions on our current plan or other recommendations
>> for how we might approach testing secure IPL? I’d appreciate your guidance.
> 
>   Hi,
> 
> would it be possible that you create a real small qcow2 image (e.g. with 
> buildroot.org), make sure that it gets the right signatures, upload the 
> image to your github account (or somewhere else), and then add a functional 
> test to tests/functional/s390x that downloads the image and tests the boot 
> process with it? I think that would likely be the best solution...?
> 
>   HTH,
>    Thomas
> 

I'll look into this approach. Thank you for the suggestion!


