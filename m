Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A475AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zNG-0000W5-8s; Thu, 24 Apr 2025 12:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u7zND-0000Vf-P9
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:24:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u7zNB-0000kM-M2
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:24:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBUJ0C006267;
 Thu, 24 Apr 2025 16:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dhdAAM
 bJFnfX9w1cTIYkr3yQwvyWmZCmZZ8zH9YK+P8=; b=hC4rWD688CD8er7PGZj0OK
 ciEp5PDVe0h3DJQzOZpY+48AmeGbuO11JLKesi37h/6n7qrGHjpO2pMCvpBg4e7R
 zHY8/Wcl6Mi4ADxk8LC9jh7PJA2V9QJ7EgrUlP5a5ayluAQNRd+TDRAONiU+DIXJ
 HjPn7i/Mh1gNpYvFaIcx7Q/XvIIC0+gTnwUXXS9Ygk/gkMxHLR4PfCeFyw3RztOi
 iOCBQGFU0EsYBQdFznotoHRFGg09ssk2vNHmqv+PEePEvNbAVOyb8lXueY0mjpQv
 GpgaSPWScnH+F2cGMzmRA1myLoF7lsvtqtv44BjWM3L8zFPv12jJVQApa3GuXZ/g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467a60v42x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 16:24:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFikkD005820;
 Thu, 24 Apr 2025 16:24:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxh0dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 16:24:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53OGODij29950638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 16:24:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB35E5805E;
 Thu, 24 Apr 2025 16:24:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BABD5805C;
 Thu, 24 Apr 2025 16:24:13 +0000 (GMT)
Received: from [9.61.240.13] (unknown [9.61.240.13])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Apr 2025 16:24:13 +0000 (GMT)
Message-ID: <15457df6-11fd-41d4-9cb1-14e4473c1866@linux.ibm.com>
Date: Thu, 24 Apr 2025 09:24:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Enable QEMU NVMe userspace driver on s390x
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: stefanha@redhat.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250417173801.827-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q47S452a c=1 sm=1 tr=0 ts=680a65af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mDV3o1hIAAAA:8 a=uFoJi0_FfnmJBMnm0LgA:9
 a=QEXdDO2ut3YA:10 a=WQTGfJf2NMsA:10 a=ZPqX8Ogbq0EA:10
X-Proofpoint-GUID: PqNAqmapk-nnLU1jXejo_IN9JUNmt2iA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExMCBTYWx0ZWRfX86HtkUQY2xV8
 eoapKzeM5SlCFTBnDHaaSZzquDPsLnMWtJgxGqY2VSgOgCcq3f+djcQmp+7gpwCoYfr8r0idPT1
 uEieJ+DSqfytochUO4d7fWQHGB8+bWJ5F53xEEVrqpM6b5jnMm5mtSo47U8eInsNO1eZggaP9fW
 wrgYcgcU4g5YoF/+tpZiA9oNLZMjscc/6Pjr3WfZEcTY6Czjc34Lb9N3xwlm2sjrWAAtHiLO98w
 dHls9bEBjoZUJjVaIU+gQImacnAjIWEAof3udrmgO+n497rA9iV30/kXDQ1FpqDN+CEvFLJx+kP
 Z/AnPNE+FINnbMNAw9Q4g83DKsUjeTF2rjUUNBm5a/L4ME7ZoQkNKVxPTdEcl9SJhyVAEup0iDP
 t19T7oNR0ldrtJ5vCiKoVW4pHu6mE0wqqdvmFCxu0Nb9cwolo0Bu2ULb/UOhEm3GfLGuBg2T
X-Proofpoint-ORIG-GUID: PqNAqmapk-nnLU1jXejo_IN9JUNmt2iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Alex,

Polite ping. Please let me know if there are any concerns with this 
version of the patches.

Thanks

Farhan

On 4/17/2025 10:37 AM, Farhan Ali wrote:
> Hi,
>
> Recently on s390x we have enabled mmap support for vfio-pci devices [1].
> This allows us to take advantage and use userspace drivers on s390x. However,
> on s390x we have special instructions for MMIO access. Starting with z15
> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
> operate on virtually mapped PCI memory spaces, and can be used from userspace.
> On older platforms we would fallback to using existing system calls for MMIO access.
>
> This patch series introduces support the PCI MIO instructions, and enables s390x
> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
> on the patches.
>
> Thanks
> Farhan
>
> [1] https://lore.kernel.org/linux-s390/20250226-vfio_pci_mmap-v7-0-c5c0f1d26efd@linux.ibm.com/
>
> ChangeLog
> ---------
> v4 series https://lore.kernel.org/qemu-devel/20250414213616.2675-1-alifm@linux.ibm.com/
> v4 -> v5
>      - Fixup typo in PCI MMIO API (patch 2).
>
> v3 series https://lore.kernel.org/qemu-devel/20250401172246.2688-1-alifm@linux.ibm.com/
> v3 -> v4
>      - Use generic ld/st functions for non s390x PCI access suggested by Alex (patch 2).
>      - Removed R-b for patch 2 as the host PCI MMIO access API changed for non-s390x.
>      Would appreciate review on this again.
>
> v2 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06847.html
> v2 -> v3
>      - Update the PCI MMIO APIs to reflect that its PCI MMIO access on host
> as suggested by Stefan(patch 2)
>      - Move s390x ifdef check to s390x_pci_mmio.h as suggested by Philippe (patch 1)
>      - Add R-bs for the respective patches.
>
> v1 series https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06596.html
> v1 -> v2
>      - Add 8 and 16 bit reads/writes for completeness (patch 1)
>      - Introduce new QEMU PCI MMIO read/write API as suggested by Stefan (patch 2)
>      - Update NVMe userspace driver to use QEMU PCI MMIO functions (patch 3)
>
>
> Farhan Ali (3):
>    util: Add functions for s390x mmio read/write
>    include: Add a header to define host PCI MMIO functions
>    block/nvme: Use host PCI MMIO API
>
>   block/nvme.c                  |  41 +++++-----
>   include/qemu/host-pci-mmio.h  | 141 ++++++++++++++++++++++++++++++++
>   include/qemu/s390x_pci_mmio.h |  24 ++++++
>   util/meson.build              |   2 +
>   util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
>   5 files changed, 338 insertions(+), 18 deletions(-)
>   create mode 100644 include/qemu/host-pci-mmio.h
>   create mode 100644 include/qemu/s390x_pci_mmio.h
>   create mode 100644 util/s390x_pci_mmio.c
>

