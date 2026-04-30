Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7120FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF7N-0005EU-MW; Wed, 29 Apr 2026 20:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIF7C-0005DH-J6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:18:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIF78-0005RC-Lm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:18:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbTgb2856007
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 00:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C8k6u7hbXWWBvyXM3wkEDpzMkulxrTvSnuXmVyhMkMA=; b=AvzL4RypYV9+I6sr
 BjVCff2HYWz2vao8kkC/BQtMzPX6iEPPnCtt4YvlqQs0DUdnSoGwoODrL62qfXHP
 /5lI55CSwzN5i7Ku+x3ElMGPLZ1DoT/PIqUuthIhsvZwKn2OF4ylCz+J9HMGp4PY
 hYUibkdcNnSj1g/O3w4sVWTixcvh9K+OU5+YwYArsXGciHV9cK7EVt2qDo2cTDMf
 QV4rrbnHCM09CxnP8KJIP7lCAk2V9uz0XPLdfxZCCYGpvzuO0oq334V0ABNDa3J6
 Tlck1evcBfyFRHR8L8HbtY3UdH4u1kYQ2veD/caCQOgH94jKRBndmiDyhTkjUoNQ
 YbQXxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dukrp20r3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 00:18:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so402901eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777508323; x=1778113123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8k6u7hbXWWBvyXM3wkEDpzMkulxrTvSnuXmVyhMkMA=;
 b=kZNfj2r0+gn6DJqyIVSQIV67A0Scr2hy1vvH5EHi19687tVbex+Dk+6NBKxReE+Goi
 tamWjl43YrhRZ6LpzOe9fkYmU5UOYB6I3Ko+YbjdvUG09E6EJZqTFKHMLFAZcBecblXN
 kqO2rSoEWhtXGp21T5qPb2S4yz0LVuS0gRqJuK+VG8CSl4VNx5qqz2ht8Jvku9WcsEMV
 4bwNZd2btAuJawUENOSm5yHStqqfzPkFEwTDBo2YHaZg75Dv5lvD8xxAd8BrZFycLSah
 4svoFFvz3Jsun95gML2J1hujft1wX2ujH15y2E01n4Cg2Q/UbW4BDA4ffyZEYXbgxHZY
 4qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508323; x=1778113123;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8k6u7hbXWWBvyXM3wkEDpzMkulxrTvSnuXmVyhMkMA=;
 b=HTXgNYspZVzDXwjqFWm+SkS3vI7OQVN/EJZ+oSq4tQeAsbIHvYxi8Ng2C5K0+o+dkn
 VUZOQBr++gTgjgUruU1r831792XdvO+8ScRFtk0tCaEdIJeeDnfmyuAnassfBaQyXAVp
 E0sAngsMokLcEzL4jiraYGynoAEHtfnSwu6T/tzOIfvfhr62sh2ZRWbkmIWtzgsF1soN
 vxNQNoT/Sa8om4MwoXbY5ZT5m1L2j1fp0MFg6EVlz9Bbc6cA9OVBqcu1Q60T+oGHpMBW
 SWFTwpQ/AsIWAZvi9mRlXTexQl4yUbw04m8FEohYC5bwKrWeR3nCMK36XRyWOV327uUR
 3VIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CSwAZJGagYSqIe5RVkCZX7bYbvjFGLh/O9gzVxc4rBbDlbRJvSEWVyKvDEW0Zwkehsg8PNfW/YtNb@nongnu.org
X-Gm-Message-State: AOJu0YwanvZZ9F5YhfGe1bPen2rwnDlYDlDDnxFaWUryU2c3wDAqXcqN
 yDUZYT+X8plImi7Q9EjQ2/K/dJueatphcI8ieK1QzAkoByOBLQt/BNiB3m8hd3BbMqPpR7y2sU/
 MaAat7jQRHSTDd1tUNWwn5Yn38kHO7kZ8zDfCz7/XFhrgw62kCKqlgnLWPA==
X-Gm-Gg: AeBDieuqs3uczytynttjw3xap4e28IRdrRZgSE1YAZPrSgHkOctiQb7QMnwfXiJz6BB
 msYQ9BNmn6BcixmCsmSjkWgyuX8zNtCuxyovnEUz3JXJlmc8RKV04ut3/w3ZyLyjqwkpxw4KjbN
 HqKAIPUesOYiKXJzR4Olm5akNfb3aL1EC2ZdwxwfSbic+TvjATH0I/2HHAyi9sfTYzzKrNLjJD8
 /yrVuEdODGZl2WD3Zf+OGLc+IXTX/pv0URtQbGg0TJ3BBiTBiW3Lbfp7LhPJHRNe5yI3SIa/FEz
 pfb1myL5te4Ve28QHVBgn00F53FbMyiOxX8woSpRzV2I53R9zQeipVeMhnhPqJyqGpuZtuLtI+i
 AiKT8Wii9AG9xfqGrRcaYhMdM7cWr2xGLU1lXw3Rf1ZD53zNxGfAmpYWFPnckDWU/9gHR4QFm0u
 4k84e2RJQg0AxEe4PRKqGaIXiE
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-2ed4e7f58e8mr130573eec.12.1777508323515; 
 Wed, 29 Apr 2026 17:18:43 -0700 (PDT)
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-2ed4e7f58e8mr130539eec.12.1777508322791; 
 Wed, 29 Apr 2026 17:18:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c06eba9sm5332072eec.17.2026.04.29.17.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:18:41 -0700 (PDT)
Message-ID: <7c46ed3a-3db8-4a10-a736-3008de0d7d2f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 17:18:39 -0700
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: anESPdPzSyT4rEgkiHZJmxt4jsgtqfMo
X-Proofpoint-GUID: anESPdPzSyT4rEgkiHZJmxt4jsgtqfMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAwMSBTYWx0ZWRfXwSfvXyl5SllA
 0h0Wnp0LuorJhsCuxkKlcOMZ4uvAHfZaB542ErnuRzqLpSrXNYjRxT9rJkLcP6RaWFOFw49+0+q
 Fikw8pGs2tTn1ekUQAOTBwEAEbmayLoCqaJmFDKCf8xPag6IK2hMN2CtxTogiLIqA2yGGJh68sw
 KwZ+f3l/K1/YM30iVvdYMWA7kstrvPl7wbQ6ItXZAw5iRNOtZ/B8iqxytFiwR1EUfCEdm2xrmEY
 XRDA7R3SGNU3naZprSbVeB9wyPAUZJNBkliA2tYwW+UflbSsgOUX0H2rncEyEtu1E/HR//VHh++
 xIv4+4+nx1VOLV8Ez+om2Orp0wlitsppCRrb+C13+n0jDoXKUvuvm286fMqsjfSKaZEy4L5fNhD
 dkgj9zrxDhlYviWdDB6I+8b8AW30aUzD0Jg7iY/s/MAURczOjKaZS4s7rKRdpUOJsQ0jYjBuW6I
 fenUSY6k5Bs/kZxFCuQ==
X-Authority-Analysis: v=2.4 cv=WoQb99fv c=1 sm=1 tr=0 ts=69f29fe4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=EUspDBNiAAAA:8
 a=aWiQaqnJvEPcc7PUmSQA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=xF5q_uoM5gZT5J3czcBi:22 a=oJz5jJLG1JtSoe7EL652:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/21/2026 9:29 AM, Jim Shu wrote:
> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
> 
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
>    IOMMUMemoryRegion.
> 2. Since IOMMU translation results are too complex to be fully stored
>    in the CPU TLB. we will defer the translation until the actual access
>    occurs. Also, TLB is allowed to store the untranslated IOMMU region.
> 
> To implement deferred IOMMU translation, this patchset introduces the
> following changes:
> 
> 1. tlb_set_page_full() no longer translates the IOMMU region
>    immediately. Instead, it stores the untranslated region directly in
>    the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>    access into the slow path when a region has not yet been translated
>    in the TLB entry.
> 
> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>    the lazy IOMMU translation of the access_type first. The resulting
>    translated region and access type are stored in CPUTLBEntryFull.
>    Since the slow path always performs lazy translation first, we can
>    switch the CPUTLBEntryFull content to the correct access type before
>    use.
> 
> 3. To accelerate memory access in the fast path, lazy translation can
>    update the addend of the CPUTLBEntry when translating the region to a
>    host memory region. We restrict the IOMMU region to have a single
>    non-zero 'addend' across all permissions. If a second 'addend' is
>    present for a CPUTLBEntry, QEMU will trigger an assertion. This
>    limitation is sufficient for security devices, as their "secondary"
>    region is typically an IO region used to emulate device error
>    handling when access is rejected.
> 
> 4. To support non-slow TLB flags, lazy translation can update the TLB
>    flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>    updates the flags for the permissions specified in @prot. This
>    ensures that each access_type of a translated region to maintains
>    independent TLB flags. For example, TLB_DIRTY of memory region will
>    not be "polluted" from other permission that translated to different
>    region.
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
>   translation until actual access in the CPU path. Provide a IOMMU
>   lazy translation function with the special handling of 'addend'
>   and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
> 
> 
> Jim Shu (5):
>   accel/tcg: Pass access_type as an argument of tlb_set_page*()
>   accel/tcg: address_space_translate*() will pass the correct
>     iommu_flags
>   accel/tcg: Provide early AS translate function
>   accel/tcg: Add IOMMU lazy translation function
>   accel/tcg: Support IOMMU lazy translation in CPU TLB
> 
>  accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>  include/accel/tcg/iommu.h            |  17 +-
>  include/exec/cputlb.h                |  11 +-
>  include/exec/tlb-flags.h             |   4 +-
>  include/hw/core/cpu.h                |  15 ++
>  system/physmem.c                     |  60 ++++++-
>  target/alpha/helper.c                |   2 +-
>  target/avr/helper.c                  |   3 +-
>  target/hppa/mem_helper.c             |   1 -
>  target/i386/tcg/system/excp_helper.c |   3 +-
>  target/loongarch/tcg/tlb_helper.c    |   2 +-
>  target/m68k/helper.c                 |  10 +-
>  target/microblaze/helper.c           |   8 +-
>  target/mips/tcg/system/tlb_helper.c  |   4 +-
>  target/or1k/mmu.c                    |   2 +-
>  target/ppc/mmu_helper.c              |   2 +-
>  target/riscv/cpu_helper.c            |   2 +-
>  target/rx/cpu.c                      |   3 +-
>  target/s390x/tcg/excp_helper.c       |   2 +-
>  target/sh4/helper.c                  |   3 +-
>  target/sparc/mmu_helper.c            |   6 +-
>  target/tricore/helper.c              |   2 +-
>  target/xtensa/helper.c               |   3 +-
>  23 files changed, 354 insertions(+), 58 deletions(-)
> 

For the series:
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


