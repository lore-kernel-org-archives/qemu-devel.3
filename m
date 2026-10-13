Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E5CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYTo-0004x9-FF; Tue, 13 Oct 2026 05:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGYTn-0004wr-JO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:07:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGYTl-0002lr-95
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:07:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D6YsaG3208372
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HnhHh2q40F/pYXLwsoEn7F3HhkIZrVH/+TKkpJanqpI=; b=VmGHwf2VKdGuDZzi
 pp7NsLfW/Ppxxmdr6RhQcw2egdNPiV6oYLev2pzMOXwi5Zg8TWd7M48fVIRXmFMz
 nEn08EfIQYrOUuX+hD6wZk3cU36KtwGpfufovrS+E2DVDxhLLGiLSnHC9Sv/iLw4
 QparaPLPQX9Qfs0Uen47GiI3ihA7qjRkMz50H4TMSRPyeuMA4M7ri7GAvDha0Hgg
 +8dViO9wYElRR5WSjXKPqjMuBcCzT2A3BE2mB0jReU8okK/rJhKqfO50nHFaeMc7
 VZMUJPIsvsMjsLRTR1hTBL/ODikjeJIZpS9AIih2TBrixeIUfZ22BNxzgXoHyyVt
 Ye9PJQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjgkry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:07:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b89614300so34717496d6.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791882442; x=1792487242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HnhHh2q40F/pYXLwsoEn7F3HhkIZrVH/+TKkpJanqpI=;
 b=G47hsEutcnV74X+ZAhMyCn+Pi/dCNr/7wEP8qRzdjp2HxJnRsYBmoiZVyip95/ZMdS
 v9UDC6BlYxraDZq9dKywfWOr9B9Gk7tzxMqGkbR5sACF+OBCGBiiUAdAgbpnh/vFyWk3
 TygeLGjqPkO3Gi82KiRsTSNcQ1pouGgik1Z4jZk53nWJH8MvU1sFMrnubp+2P6o3qj/d
 msci7/1Y2V5VL8IUayGUEKWWZbhlOXQUl+GSaqryLkXQBxAn6bT/ud5Fh+b984hUU5Jq
 N5tpyP5X9ZafXIvncD/iPuvhmcpE8OxO/a3nAD4P6yASmgKHq/LiYGjIp0Limng5Omnc
 nxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791882442; x=1792487242;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnhHh2q40F/pYXLwsoEn7F3HhkIZrVH/+TKkpJanqpI=;
 b=Gb8Ada+9tYwVffnMgujpEKpaQRxxDJ1Lz4kW9zpgSOszKYdS8m9tq2w13mK3LQ/FGQ
 K54YKQXfkrAXOlP/3C0FIbTfaIFDJ4QR6x/SajIRVvBNx1eFzdtWGtvLCZ+qBZYwzV1e
 AG5VfRcM5CRPSufF3OH7VYL9l6etOqsfDDIPrl3/i0f5QDzabMWYOWhBd4qyK85k9+Bk
 JqWbyE20LOAo69PPuriVfb1sKOpsznNlNvBzZ2sYky71Yk3D2RhP+BbvmdLNkkwM3Clb
 28yfQLS4d7s8gj4BcS1E9s3gkDVFoSCOkjPqb1XD7FnraaPYXCQcFKeV/5l2rIHJenqU
 JwiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt92gP9hhMhBZvVYPuQtjEuRJ4PQtuJn7cVFGriksfnhyiBb3KCZUueZCflb61+Y6MJHmL/2j/bn2B@nongnu.org
X-Gm-Message-State: AFq9FYIhPjj3T8ncy+4UqnBIboHiztluHtpETL2+5nY5rLb4p4s/1nY4
 vgZZP7Mf8LRcSrZnDpLlars1y1D6FnOuRHWIxSuRr0ne0aZ3fMI3YzbwQEHjySf9wxv3gJQnzUJ
 QOi7l+tZjrUbc1XoWTz06FnMkktD2fdg6m9zIutv1kFsZBtKikGaR4qCFhA==
X-Gm-Gg: AYBFou39+sIZhTtownfNsRc9XYnHlrAbW3YYL2jjpe0ipS8RAHiBFDrG62P4Mv3rCyf
 ps9CPwwXYAlnAaXjBLGs9uFWDLm+GclhMhECYr8kjzZ7OhPJzAk/3GCOneiSEv0u5QdmA/VTW4W
 lz+Hu5gJUTGVnkvJ+iIeegYsO8ZG7PPT2No0nLYmsB3WhB25QK3U5puF5RVw5cad+qEKm+8L8Rc
 0LjA+Z4MynSUNoo0hUgvxQMvhTzyr06faguQZ6viffaGeX+kKbuQbq0BgxwbjIGkDKcJ6ptCb+Q
 zoUuFgCuSxZl10fuzNuqJTkcb+cOfAIOr2Owa8d9CLt/v/cycDIyM7rl0hgENeFSFNHjUCd3AS9
 i/M1qXrH1FYyb9gKbTRMo2zAnzDivH9q+Rpo=
X-Received: by 2002:a05:6214:3111:b0:91b:81d5:f8f6 with SMTP id
 6a1803df08f44-91b81d5fa0fmr76021746d6.10.1791882441639; 
 Tue, 13 Oct 2026 02:07:21 -0700 (PDT)
X-Received: by 2002:a05:6214:3111:b0:91b:81d5:f8f6 with SMTP id
 6a1803df08f44-91b81d5fa0fmr76021046d6.10.1791882440934; 
 Tue, 13 Oct 2026 02:07:20 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97178de2sm20900406d6.0.2026.10.13.02.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 02:07:20 -0700 (PDT)
Message-ID: <28f20f77-077e-4cfc-8b42-62c894a5fcec@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 06:07:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Defer the IOMMU translation in the CPU path and
 support access_type
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mUVWjozByn1JqNfr5BrETN3pGnyrDu8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX4AQoITCpgN9o
 oiKzm5kRD23O/nFH6XBB3/fdqEEOMp/wCfXTfM3ldzFohlruZgck165hNz/djOBL+fj9HeqaHM9
 UVkNAB7FPmrsyZhnKOF5KR/Qhkxhtfpou1611jTk6wExuHeS4CdfDrcXZ8HAK2Hs/82uoCAPwu/
 yPfHpyNf5fn0lN7c2XLqidC7Vkz9sk2qhhzyOBMrHKSrAbN8JygkevZ7Jey183nafFiLgYkW9sm
 zzL+ZfO9aeYF+8xr/kP2WL8lNQX5oOQ8sUwwuhPDCbMqgoaYnRtsXk2lorAgSjpEjsQz5hKceWk
 NMLusFdC4cHE1YaliTcygqTHolD6XkK2tnw7yZ9eoxMEl4BkLEI2CAFxdAUd0r1yOEfTcyuHB+z
 DucdeKufg6sgkwhIDuVdleHRYZYEXlgz+q19tGfwnffkrRWFER55ZrVbFbeB8EwFAEqO4uSOl+o
 ZpUPyQFxCvHVI5pBLDw==
X-Proofpoint-ORIG-GUID: mUVWjozByn1JqNfr5BrETN3pGnyrDu8i
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6acdf4ca cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=skmqWCM_iL4kibtHDDcA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=oJz5jJLG1JtSoe7EL652:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX+bUiO2fNQ809
 JaCjGlRNcBD+Pup0ilcH4EAxKYWOOymv94zdzvgoMm2ga++EKvBQedLnrV944xUg+O3MkbTyYKA
 xrS6fRdSd2aR41g2iEOcxBk/FHFIxw4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=unavailable autolearn_force=no
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

Hi everyone,

Seems like this series is fully acked, so ... can someone queue this up?  This work
is a prerequisite for a qemu-riscv feature (WorldGuard support) that we want to
get merged.  We have some reviews on the RISC-V bits already but without these
accel/tcg bits merged we can't do much progress since any change here will
affect the RV parts too.


Thanks,
Daniel


On 5/6/2026 12:36 AM, Jim Shu wrote:
> Incoming security protection devices feature more complex IOMMUMemoryRegion
> implementation in the CPU path than ARM MPC device. For example,
> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> Consequently, the IOMMUMemoryRegion could return different sections for
> read & write access.
> 
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
> Changed since v2:
> - Fix unused initialized memory error
> 
> Changed since v1:
> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>    translation until actual access in the CPU path. Provide a IOMMU
>    lazy translation function with the special handling of 'addend'
>    and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
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
>   22 files changed, 354 insertions(+), 57 deletions(-)
> 


