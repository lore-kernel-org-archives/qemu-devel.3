Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B106CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPj9T-0002m5-J5; Wed, 20 May 2026 11:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPj9L-0002kX-PI; Wed, 20 May 2026 11:47:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPj9F-0002yt-Jj; Wed, 20 May 2026 11:47:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDW9Ht3919898; Wed, 20 May 2026 15:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K+YGIC
 l6Vs7u1ykyaZFy0iZKZOav8upOxbifYNYUIf0=; b=kRDqQO1jsqsaJwdhMi3WOS
 3pQxDVkwf9I/Hi9FoqCaYK/0+WT7CDIN7X3YBWK9b301VohDLzvjPV8q/wOA00rv
 itEXCMtAkbEUC1XZ/qgOjcQCjFY+chz5OaCtWrYuWdSvdOszJucQaKmNlkwS3+lp
 8EwHIvGjcGHamHg9kLVzAiumIJXOWprlCRSNE8LaiEahCHE95lnCDvs2ByyiClne
 G2/I0AnP0OjfuPkad6MSE0pnJZ0VEyqo6borYet5cvhA6HeH/DQLQiTj44Stkz9z
 gME6U9I3dgvyu5o0XMFP176kgyYcKUUyScF2xVKnojWS4Nl5gLP3IzhRC6uyKr2Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mttjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 15:47:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd5BR031965;
 Wed, 20 May 2026 15:47:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk80t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 15:47:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KFlgAq52101434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 15:47:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E0A920043;
 Wed, 20 May 2026 15:47:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A15920040;
 Wed, 20 May 2026 15:47:39 +0000 (GMT)
Received: from [9.124.216.248] (unknown [9.124.216.248])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 15:47:39 +0000 (GMT)
Message-ID: <8954ec65-b1d8-4ae5-b191-4ef24a101a66@linux.ibm.com>
Date: Wed, 20 May 2026 21:17:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ppc/spapr: Split VFIO code and refactor EEH
 interface
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com, philmd@linaro.org
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
 <20260519103325.8056-6-nnmlinux@linux.ibm.com>
 <60d9c0da-cf4b-4210-8a54-743bb4e767be@oss.qualcomm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <60d9c0da-cf4b-4210-8a54-743bb4e767be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ufM16nQbdxaoCJeKcaajQuLHeJtG1-ga
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dd7a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qI3XOwHeH03Sa9HlmeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BQRthXUa1Icyr-ajyETemwgMp5_bPbKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXxNoIqEanzn32
 AkTQ/3S6PSq9WO2K5+/yfPCWafslRKcGxo9lWFZ3P47eNo9uElE4szReu9w4oK44dnq0LwEwQO6
 EoOo0oqe18qHCdjJvzMp273c75FhRMREWBw8gSLe1tCDEirmkOZqDO0wAhUveaMpX4UdQy1cNr2
 nYdN3gdkMjpqHFPW0i1dy0tkX0tH8FXIApISGAjnXEeCUBOyoKQxLnN4TbrIiJ8DV3atl/2IysP
 5h67f24+LxBObZRmv9yAxw/xT4snsvuNq30E7/fRCePF/ySqO0jfQuHO9vZQajhtKlYks65hdqO
 OHZRRFaGeZBqkg8/AIuOo7KFh4+3Ul+xxw2qkhbDAgPoXIr1yJJUFZFANprMdnFNQ4HL8noIhr+
 O2XT8wEjSh2fSlvkutnRH6XpvDdLI45ZvU1YqnXhuGt5SeXTZMrZ5AoOOBhZ6bAyt6G8PFEXZhm
 D7oUExtwclk2H2dXF4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 19/05/26 8:17 PM, Pierrick Bouvier wrote:
> On 5/19/2026 5:33 AM, Narayana Murty N wrote:
>> Split spapr_pci_vfio.c into two files to separate concerns:
>> - spapr_pci_vfio.c: Contains general VFIO routines
>> - spapr_pci_vfio_eeh.c: Contains EEH-specific routines
>>
>> Additionally, consolidate VFIO EEH function declarations into a new
>> header file (spapr_vfio.h) to improve modularity and reduce header
>> dependencies.
>>
>> Changes:
>> - Split VFIO functionality: keep general VFIO routines in
>>    spapr_pci_vfio.c and move EEH routines to spapr_pci_vfio_eeh.c
>> - Created include/hw/ppc/spapr_vfio.h with forward declarations
>>    to avoid pulling in full spapr headers and libfdt dependencies
>> - Introduced stubs/spapr_pci_vfio-stubs.c to consolidate all VFIO,
>>    VFIO EEH stub functions in one place
>> - Updated hw/ppc/spapr_pci.c to include new spapr_vfio.h header
>> - Updated stubs/meson.build to reference new stub file
>>
>> This improves code organization by separating VFIO and EEH concerns,
>> and enhances build system modularity by making it easier to maintain
>> VFIO-related code separately from core sPAPR PCI code.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   hw/ppc/Kconfig               |   2 +-
>>   hw/ppc/meson.build           |   1 +
>>   hw/ppc/spapr_pci.c           |   3 +-
>>   hw/ppc/spapr_pci_vfio.c      | 367 +----------------------------------
>>   hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++
>>   include/hw/pci-host/spapr.h  |  44 +----
>>   include/hw/ppc/spapr_vfio.h  |  28 +++
>>   stubs/meson.build            |   1 +
>>   stubs/spapr_phb_vfio-stubs.c |  52 +++++
>>   9 files changed, 433 insertions(+), 411 deletions(-)
>>   create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
>>   create mode 100644 include/hw/ppc/spapr_vfio.h
>>   create mode 100644 stubs/spapr_phb_vfio-stubs.c
>>
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 347dcce690..1fb191fe83 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -6,7 +6,7 @@ config PSERIES
>>       imply PCI_DEVICES
>>       imply TEST_DEVICES
>>       imply VIRTIO_VGA
>> -    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
>> +    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c and spapr_pci_vfio_eeh.c
>>       select NVDIMM
>>       select DIMM
>>       select PCI
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index 37aa535db2..97e4be0dc9 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -36,6 +36,7 @@ ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>>   if host_os == 'linux'
>>     ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>>       'spapr_pci_vfio.c',
>> +    'spapr_pci_vfio_eeh.c',
>>     ))
>>   endif
>>   
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index b00f71d92a..221d05e5c5 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -33,6 +33,7 @@
>>   #include "hw/pci/msix.h"
>>   #include "hw/pci/pci_host.h"
>>   #include "hw/ppc/spapr.h"
>> +#include "hw/ppc/spapr_vfio.h"
>>   #include "hw/pci-host/spapr.h"
>>   #include <libfdt.h>
>>   #include "trace.h"
>> @@ -718,7 +719,7 @@ static int parse_and_verify_recovered_special_event(target_ulong param_buf,
>>   static int parse_and_verify_corrupted_page(target_ulong param_buf,
>>                                              uint64_t *addr) {
>>       *addr = ((uint64_t)rtas_ld(param_buf, 0) << 32) | rtas_ld(param_buf, 1);
>> -    qemu_log("RTAS: corrupted-page: addr=0x%lx\n", *addr);
>> +    qemu_log("RTAS: corrupted-page: addr=0x%llx\n", *addr);
>>       return (*addr) ? RTAS_OUT_SUCCESS : RTAS_OUT_PARAM_ERROR;
>>   }
> See build failures for this change:
> https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
> If we want to change something, the proper way is %"PRIx64".
>
> ...
>
> Rest of the patch looks ok to me.
Thanks reviewing. I have corrected the gitlab CI build failure issue in 
patch and
another test case failure on gitlab. corrected V3 patches are posted at
https://lore.kernel.org/all/20260520095446.64206-1-nnmlinux@linux.ibm.com/
Please take a look and let me know if any further review comments.

Thanks
Narayana Murty
> Regards,
> Pierrick



