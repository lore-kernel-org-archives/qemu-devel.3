Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049B1FA1FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFa1z-0005MY-0U; Wed, 22 Apr 2026 12:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFa1a-00056V-SR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:02:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFa1I-00013q-3C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:01:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfI2X2956039
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 16:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4V8QV4/guBse53q6P7uoQ2TomQSQi7gmIhTqqYC2NnA=; b=OikZXIyg8q1oek6f
 K2ZDZ//cFNGtD+DNZaqxCZ54DWOuwXDvfW/yKpHTnk8cmq93SsMkSnAtmalFhV2T
 vsGnnnKwdBY1MzA40BxZTSqbZCcUuU34++UvviyVkfTHthCrtaFS2FVAfVhlzma8
 pvSHeI9fpU3aoXWxaibpkngnw2Vc46tyew6xMI6DZhY4XX88WsnCc/GsDYHn3HyL
 8cm8cajWMVqwCDdjVXuuhluASn5iTrLBzvLJh8SUgN/OHNffa3vkyFVkcjlqhWmt
 r9an4A2WzIX8MAN2SEAf030Ae+85yrvDNWImU5uxXuOuDpHwp2p0CeBj468HJjEA
 8MZlPA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q02d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 16:01:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c87ba0890so12424791c88.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776873687; x=1777478487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4V8QV4/guBse53q6P7uoQ2TomQSQi7gmIhTqqYC2NnA=;
 b=QaIoMLSzKEHGOApC/4vcP8+q5I7zFcMJAixZYyG4nV27f1TrG4R+K7yPGSUM8/73+6
 3jU1qFpwu1tkMb0Ns8Kr8mUMNqMpyU7RbMQtu596wmbSFUqO9YTjfN4JyoQ+Gj/fOSFU
 gHvIAG1ZRD0vtsUX0uXTmYqLWdEw8GAQe6COe0EFsG2jX5dBPXYltxjTTuAuIaqRS6QS
 kCvdF7+oVENQYzsuFU86MaGoUwr6qtKVS1N98t/Vhip9FlTptPMFvDzvpwCfn4tybtLl
 MmwMSfuWSrmltHjQYMNUBl//YD0mhCg3J6cLlOt+Y2yHlJLPmOIkuz6ccHpS2lHHOc2v
 1d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776873687; x=1777478487;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4V8QV4/guBse53q6P7uoQ2TomQSQi7gmIhTqqYC2NnA=;
 b=ichL6WlB6TiGfzw6X0/JLwoDFE4XzQZCjgZC2XbiLADYN6zG66iWN7UCMXBGa0+U5h
 qIPu7FN0ZHUyr60Uk9kXllyr5mnxton3mAB0Rg739243ta01Ao7sDB902BqHsUOoxLAe
 XX4YHzFQ7y1igSRyvbPfwQlDKBELg5+VoJ2DQmRxtabdoMr59Ue07+tD6WiY6EgKbhUz
 RcOSM2jwnKgps0K3OOXLBHbz9rZLeQ2eKPDZHwFPrOw/4Pdm+ZbkwMlbhixeiuQiJek1
 LSocC6q04DA679XWvbUrVu0Hi+0/R0P6vgDcXJ0BEV1fwIfRko289ucA14zCOV5JywrA
 kzJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X5svnB/aEB/GdsSr85pPGUJIWgJcKlkxM/cUTY/d97MIttDq3euV3+nUbIou1wrV87Pd4y8UurNe3@nongnu.org
X-Gm-Message-State: AOJu0YzBy7CmfV/4U8UyRUakotJgWxU4AVi7q5E/nGxDM7j+V+htNEa4
 hPc0gToHad2h03jOwsImH6R6qUEiKklb9EAfxCC4XXBjI6BZjHRFeVc8LHxeG4916SPI5/WVfxK
 XkffIb1oujirgGaRh6ybBWxpcSEiovD0XQSkQCpsLyGzFjnkQNn7YXhdBhw==
X-Gm-Gg: AeBDieuwQQdfySbC2+3KwZWwaYdPC1AYa9rpVBRp9QNmeR6/Lct7dsP9S40yXBST0eT
 y+YXeCiDx3PePXlPfpdbo/6iw4YMKz5nC96G5fuYB4fPkgLBJ1ExpWhN+gKEPB9VTBDCq9S76LR
 RwlXrp4JgA+ULxDbxkPaGwiB6yhpA81VzTDB1qRKsG9ajwWDcyG7tIheRyoiAQdq6A1aeSXOiZe
 cERqi1/POugi+ThMUtuhiGRW0akITOFJF1KQzPnlRWH0AYN/4uQOqtiErsntA7y7C1Ov4ukmtcq
 uETsv/OyPWEaya2/SN9axsXeHk6sv8G10/5CXvATQosayMGs8Fja7AY1eVcji4Hd1nY5yDAGlL9
 yrV5qCGGdfWtrc6kW1AmRDjJG5NWuZH/nQCGlsIAw9IdsbAQMZVJ5Ty46SqkgnNPgdSli41Ek3y
 duEoZzu+zBRExOhVXr4avYFl2o
X-Received: by 2002:a05:7022:11c:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-12c73f726eamr11584009c88.9.1776873686685; 
 Wed, 22 Apr 2026 09:01:26 -0700 (PDT)
X-Received: by 2002:a05:7022:11c:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-12c73f726eamr11583939c88.9.1776873685595; 
 Wed, 22 Apr 2026 09:01:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbe78e12fsm942857c88.15.2026.04.22.09.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:01:24 -0700 (PDT)
Message-ID: <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 09:01:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e8f0d8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=DBCRKptLi7xDAoE2dXIA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=oJz5jJLG1JtSoe7EL652:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-GUID: F0AUhZIGVE7B98IMuVHx5sOG5dHpzVx-
X-Proofpoint-ORIG-GUID: F0AUhZIGVE7B98IMuVHx5sOG5dHpzVx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1NSBTYWx0ZWRfXzkV9+J71eCvQ
 4RmhkpeHjMtLl0mIi3w/+1lXXJw5SPFd5COuvh5mpoLhunSnwZ/B+7H94PLA7FLi7eflO6BFqUy
 tE509wNtSSpSJqw9idfccE8FW7DeM50ahC6Ud8DDHDqZTJAwDyTpXM0k+25zTUl52atMj5AFMzX
 6AAd4nvcyjz/P2aifAaYvpWGedhfvGiO61vsFHjewuIVay48l8vPg62u3IiNHt9YxbNyuDErVT6
 RBY3GgbfaggJs0juawXyqdrlvmMBcPHfupthbwdrXsINN02RoMQbflKmnRyNf+gqGl+gnf2i5an
 qxEzGhsP3neG+18X3HqWBC9AIhovsZGq8Nf1djOiO2S2Wp6DxpEJaMAwhFB0gth2++fz9oovqWI
 Bd+jzg88KsqwJ1FIrSSxn+27BmgS1Zc+ylm1YgW8IpKQE02KDLSlBdXdQ+uX+p2ZJpflH9xOQcm
 ipHWn8sYiCu38shk4mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jim,

On 4/21/2026 9:29 AM, Jim Shu wrote:
> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
> 
> Incoming security protection devices feature more complex IOMMUMemoryRegion
> implementation in the CPU path than ARM MPC device. For example,
> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> Consequently, the IOMMUMemoryRegion could return different sections for
> read & write access.
>

The consequence is not directly implied for me.

Why having a single translation and page protection handle read/write 
access is not enough here?

What is the (real world) use case to return different physical memory 
locations depending on read/write access for a given virtual address?

I'm not against the goal of this series, but trying to understand why it 
went in this direction, which complexify this already complex code path.

> To support such IOMMUMemoryRegion behavior in the CPU path, the design
> of IOMMU translation must be updated:
> 
> 1. address_space_translate*() must now pass the access_type to
>     IOMMUMemoryRegion.
> 2. Since IOMMU translation results are too complex to be fully stored
>     in the CPU TLB. we will defer the translation until the actual access
>     occurs. Also, TLB is allowed to store the untranslated IOMMU region.
> 
> To implement deferred IOMMU translation, this patchset introduces the
> following changes:
> 
> 1. tlb_set_page_full() no longer translates the IOMMU region
>     immediately. Instead, it stores the untranslated region directly in
>     the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>     access into the slow path when a region has not yet been translated
>     in the TLB entry.
> 
> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>     the lazy IOMMU translation of the access_type first. The resulting
>     translated region and access type are stored in CPUTLBEntryFull.
>     Since the slow path always performs lazy translation first, we can
>     switch the CPUTLBEntryFull content to the correct access type before
>     use.
> 
> 3. To accelerate memory access in the fast path, lazy translation can
>     update the addend of the CPUTLBEntry when translating the region to a
>     host memory region. We restrict the IOMMU region to have a single
>     non-zero 'addend' across all permissions. If a second 'addend' is
>     present for a CPUTLBEntry, QEMU will trigger an assertion. This
>     limitation is sufficient for security devices, as their "secondary"
>     region is typically an IO region used to emulate device error
>     handling when access is rejected.
> 
> 4. To support non-slow TLB flags, lazy translation can update the TLB
>     flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>     updates the flags for the permissions specified in @prot. This
>     ensures that each access_type of a translated region to maintains
>     independent TLB flags. For example, TLB_DIRTY of memory region will
>     not be "polluted" from other permission that translated to different
>     region.
> 
> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> feature.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Changed since v1:
> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>    translation until actual access in the CPU path. Provide a IOMMU
>    lazy translation function with the special handling of 'addend'
>    and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
> 
> 
> Jim Shu (5):
>    accel/tcg: Pass access_type as an argument of tlb_set_page*()
>    accel/tcg: address_space_translate*() will pass the correct
>      iommu_flags
>    accel/tcg: Provide early AS translate function
>    accel/tcg: Add IOMMU lazy translation function
>    accel/tcg: Support IOMMU lazy translation in CPU TLB
> 
>   accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>   include/accel/tcg/iommu.h            |  17 +-
>   include/exec/cputlb.h                |  11 +-
>   include/exec/tlb-flags.h             |   4 +-
>   include/hw/core/cpu.h                |  15 ++
>   system/physmem.c                     |  60 ++++++-
>   target/alpha/helper.c                |   2 +-
>   target/avr/helper.c                  |   3 +-
>   target/hppa/mem_helper.c             |   1 -
>   target/i386/tcg/system/excp_helper.c |   3 +-
>   target/loongarch/tcg/tlb_helper.c    |   2 +-
>   target/m68k/helper.c                 |  10 +-
>   target/microblaze/helper.c           |   8 +-
>   target/mips/tcg/system/tlb_helper.c  |   4 +-
>   target/or1k/mmu.c                    |   2 +-
>   target/ppc/mmu_helper.c              |   2 +-
>   target/riscv/cpu_helper.c            |   2 +-
>   target/rx/cpu.c                      |   3 +-
>   target/s390x/tcg/excp_helper.c       |   2 +-
>   target/sh4/helper.c                  |   3 +-
>   target/sparc/mmu_helper.c            |   6 +-
>   target/tricore/helper.c              |   2 +-
>   target/xtensa/helper.c               |   3 +-
>   23 files changed, 354 insertions(+), 58 deletions(-)
> 


