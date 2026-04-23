Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D973FDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyji-0001nz-ON; Thu, 23 Apr 2026 14:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyjc-0001mF-LZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:25:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyjZ-0007Ly-JX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:25:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NGAH7w4012117
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 huD/asRC8SWLAMxKvL+bXp+1VM0fZzF66Xn1sYYxKkM=; b=ZoleWkmDcsIs7s7p
 kfDOFJ1u+sPit0tHMHargm3k+D5/sWJqn6PM5COJPebWt9dBT6OpBSFu61+6iAXG
 SJBZrjNIAOebQF5b5DgWUHedFuDULMOoXHIsoiKoiOO6ppSfIZPtTPqz/tPVnkMo
 iYPpPKsQXgErQD60KKaCOxDMXdPF3JsShACJFCbUV3yLiY/Qfh22LFPP0ExwDIaG
 dLJS17NlHS/bM02J3RKE6JdRuBVuhGkyQuvWgB8b6NeSPdFS2t6mFAPb2Yo43zl7
 IyvPWQdfq1nEp42z5talqJJXqKCExYhSN80SvgQT4HSDJWr/izB1IPC5ynMG6Qy+
 7rt2zA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9rm91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:25:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so17549588eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776968703; x=1777573503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=huD/asRC8SWLAMxKvL+bXp+1VM0fZzF66Xn1sYYxKkM=;
 b=N1/PD5wGkHoAyeYSRaw/011pdSnZGynGMlBUTnp6mDhDUmz0hqU9lEtZPY2ft4B7TF
 Y1tJGlckh7CFoS0ZiPyd9LSKWSVZTqhKwiiiVKM3JVLltzUmivCIgYi6T+gokgFvqxaN
 CbOs/3hRfzKqadi7EDl5UI8EL9p7C58KPly6VEIvcrGzQaqFogC6jjtlmnftZXkqGi7I
 4WKQBZl/ea39hRRMRqU8nM3yQfF3sK7VGqnhXGkkHJJhEM7gl24JAIwePU2gCN5zeLt0
 4THYTfTvuCOzJtKGSwJlsL3veDfGlbnBgnWUJK+D0pmevxEHRh9d+mp41YyiLFSvhIeo
 Mp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776968703; x=1777573503;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=huD/asRC8SWLAMxKvL+bXp+1VM0fZzF66Xn1sYYxKkM=;
 b=POCGjxErSWj+M3XANQFZEJig+agxyXMJ0HYKoiqSVhNtaKJD61YfVM0rjGJVPt+Gat
 uZXzlTIKiQ3ijZyQI72BSGG9zdiZtB0ia0onJ/3OzwfM8g76MQqMe1j3WTpGKT+9K4n/
 KOhP+J0w7dJ1bR+WLp+JK6/vNVrGZkIMgh3U29ZbfLzxLSQptF/Y1mQ9235xBtce7b12
 avR+/hta8AnLdEeNgzP4dBR898G0LWeTDpGw8+0HXgK/0rOs/F5x/JJhl1CaPsiAuqSv
 2I4uYJHu2SNuap+ZdksNCqoNPtxCgrIB6w919vOXWKXKeEiSvdCJvoGCgpTFcJ5eE3Xk
 v5Zw==
X-Gm-Message-State: AOJu0YzqoL+Grhi+5uQzsxe5hleZeYecRISLr9Ao5QpmrAUAmFzjDDDC
 7HFIpRR78Q9PRc0+EesFh+ChX4/cui4fgqm0eYq41bPQnBHO2wQGWDWA6PHTK4g7LYxX96GtgNE
 joxZWJNxHWxvP7cjn3c4QBTO4k/mlupw+Bp1b5xBSBGiftcCu37jd21a5oQ==
X-Gm-Gg: AeBDietru8pzNhDVi6vz6OBo4T/ezJ0+dar3+GpyI6xtGG/peTMjR+8quULloFARM0i
 KKBmC+DglNjs6/wHg4a07Qux/xPniHCDEpnmZIf8CAq+QAH2/uwvt5q1G482QF2RQa55QYofZhY
 gBfqFRkKSuhCqStfGQ6iqte5slDN5tCuZUJPly8cMiF7hd55RjBUXnFVIyo/WGhJtJSQK5PXbxI
 z5k5UTrWaNEZgCU/gxJ6srggYQZ/Lz7frAm2ibRCAx1Jt8ANLt14ULDySlfTAM5ZPXjW2H2eLqF
 XEssQK4NtW22fGuK3aezvft9VGxFuDxBARmKPZShG9QX/9BsoFDo/X3jR/mJLFrD1TOWYS9kxT9
 zIoMtWsMQQA3LnaO42uSYmHHzWQWK2PcLBjWxqIASxKh7lbgU4TP6HvTZzq7W2Yie/cGoYHsDVb
 LBy5lnu5ourzFdjAb/ej8gXFxW
X-Received: by 2002:a05:7300:c011:10b0:2e6:e504:5431 with SMTP id
 5a478bee46e88-2e6e5045e19mr10040525eec.22.1776968702356; 
 Thu, 23 Apr 2026 11:25:02 -0700 (PDT)
X-Received: by 2002:a05:7300:c011:10b0:2e6:e504:5431 with SMTP id
 5a478bee46e88-2e6e5045e19mr10040464eec.22.1776968701545; 
 Thu, 23 Apr 2026 11:25:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccce426sm29086819eec.16.2026.04.23.11.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 11:25:01 -0700 (PDT)
Message-ID: <bc5d23b6-1d2e-4509-a148-be39114213b7@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
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
 <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
 <CALw707ow5D9nSmNARckozOmKOTBpOATFFNPMski9Y-yjD6RiWg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CALw707ow5D9nSmNARckozOmKOTBpOATFFNPMski9Y-yjD6RiWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3OCBTYWx0ZWRfX86nVQX0BXoor
 kcJQZv/f3YT1UKUYtP8GkKh2/EdHZW6g5Oi6KzAKjaKcVyVFe0lpHMUmTZ1ZIRMAKmuHGQfUR1+
 a715C7DXYbxfD1vJ6OHX8NeFwfGnNyBEyvAVCXWuRLBsl2glYpH7ICdAYuZ9WXCuB7XYhhx8aQm
 tQDFganQOdpn69RMEbzcuwIbzBZ1xC4Q27Z94tDKvv0LS1vy8YDHBvVigfjCj6tZxxxhd5CgRHI
 lhSkviR65Mnz60lF1V9IqtvT9Vp0M8XwF2rFMfAUsnU5I3Uc2o9kRAedNID30C0PVOeIqC0FzX9
 S1M9qlW/oU3KO55IuJamOwIwSQp6THFXcfh9NdK/57k8Uvdhe1hm1sJu2zwiVvHjzBhGQjYufCn
 YyuvFq9yNw1QCBmzZs1IXhMle61/Zc+iRza+d6FDW4qVulpg+MK1T8lGixOXyx6OxEmN7MBJPz1
 Rq7S2HNDuzEB6IxklKw==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69ea63ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=EUspDBNiAAAA:8
 a=f2ChSaaU0flOsa3QFQ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=xF5q_uoM5gZT5J3czcBi:22 a=oJz5jJLG1JtSoe7EL652:22
 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-GUID: eW-RefQiaXNgS-EJU-Qa924oBAkgFyTT
X-Proofpoint-ORIG-GUID: eW-RefQiaXNgS-EJU-Qa924oBAkgFyTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 4/22/2026 11:16 PM, Jim Shu wrote:
> On Thu, Apr 23, 2026 at 12:01 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> 
> Hi Pierrick,
> 
> Thanks for discussing the design!
> 
>>
>> Hi Jim,
>>
>> On 4/21/2026 9:29 AM, Jim Shu wrote:
>>> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
>>>
>>> Incoming security protection devices feature more complex IOMMUMemoryRegion
>>> implementation in the CPU path than ARM MPC device. For example,
>>> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
>>> Consequently, the IOMMUMemoryRegion could return different sections for
>>> read & write access.
>>>
>>
>> The consequence is not directly implied for me.
>>
>> Why having a single translation and page protection handle read/write
>> access is not enough here?
>>
>> What is the (real world) use case to return different physical memory
>> locations depending on read/write access for a given virtual address?
> 
> When permission is granted, the wgChecker device returns the original
> region of the address, called the downstream region
> When permission is denied, the wgChecker device returns a special
> MemoryRegion for error handling, called the blocked_io region).
> This region may trigger an IRQ and a bus error. Additionally, memory
> accesses to this region will result in 'read 0, write ignored' rather
> than triggering exceptions from the MMU or MPU.
> 
> Consequently, implementing RWX permission checks on security
> protection devices may return different regions (either downstream or
> blocked_io) depending on the access type.
> This design is similar to the existing ARM MPC device
> (hw/misc/tz-mpc.c). The primary difference is that the MPC only checks
> the physical address rather than RWX permissions, meaning it returns
> either the downstream or blocked_io region for a single address
> regardless of the access type.
>

It is indeed, a big difference. Translation with MPC device still 
results in a single address space being chosen.

> I also considered an alternative design where CPUTLBEntryFull stores
> both the successful permission and the blocked_io region of the IOMMU
> region.
> In this scenario, the slow-path code utilizing CPUTLBEntryFull would
> check permissions and return the blocked_io region if access is denied
> 
> However, the address_space_translate_iommu() implementation supports
> recursive IOMMU region translation.
> if multiple IOMMU regions are encountered during a single address
> translation, storing only the first region's permissions is
> insufficient.
> Ultimately, we still face a situation where RWX permissions might
> return different regions separately (e.g., downstream,
> blocked_io_iommu1, and blocked_io_iommu2).
>

The "blocked_io_iommu_X" is a consequence of the current choice of 
implementation, but I still don't see why it's an absolute necessity.

An alternative would be to treat all accesses as MMIO, but I guess your 
goal here is to optimize the code path where we access RAM?

Why can't you reuse existing page protection mechanism for this, 
authorizing read or write? WorldChecker just seems to be an additional 
check on top of existing translation. The fact it's an "additional" 
device is a design/implementation details, and could simply be part of 
page protection mechanism. It might require some additional plumbing 
when an interrupt is raised though, to redirect this correctly instead 
of signaling CPU like it would normally do.

The fact is does different action based on read/write attribute does not 
really fit very well with existing implementation, as you noticed. And I 
wonder if it's worth changing the global design just to optimize this 
(optional) use case for RISC-V.

>>
>> I'm not against the goal of this series, but trying to understand why it
>> went in this direction, which complexify this already complex code path.
>>
>>> To support such IOMMUMemoryRegion behavior in the CPU path, the design
>>> of IOMMU translation must be updated:
>>>
>>> 1. address_space_translate*() must now pass the access_type to
>>>      IOMMUMemoryRegion.
>>> 2. Since IOMMU translation results are too complex to be fully stored
>>>      in the CPU TLB. we will defer the translation until the actual access
>>>      occurs. Also, TLB is allowed to store the untranslated IOMMU region.
>>>
>>> To implement deferred IOMMU translation, this patchset introduces the
>>> following changes:
>>>
>>> 1. tlb_set_page_full() no longer translates the IOMMU region
>>>      immediately. Instead, it stores the untranslated region directly in
>>>      the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>>>      access into the slow path when a region has not yet been translated
>>>      in the TLB entry.
>>>
>>> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>>>      the lazy IOMMU translation of the access_type first. The resulting
>>>      translated region and access type are stored in CPUTLBEntryFull.
>>>      Since the slow path always performs lazy translation first, we can
>>>      switch the CPUTLBEntryFull content to the correct access type before
>>>      use.
>>>
>>> 3. To accelerate memory access in the fast path, lazy translation can
>>>      update the addend of the CPUTLBEntry when translating the region to a
>>>      host memory region. We restrict the IOMMU region to have a single
>>>      non-zero 'addend' across all permissions. If a second 'addend' is
>>>      present for a CPUTLBEntry, QEMU will trigger an assertion. This
>>>      limitation is sufficient for security devices, as their "secondary"
>>>      region is typically an IO region used to emulate device error
>>>      handling when access is rejected.
>>>
>>> 4. To support non-slow TLB flags, lazy translation can update the TLB
>>>      flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>>>      updates the flags for the permissions specified in @prot. This
>>>      ensures that each access_type of a translated region to maintains
>>>      independent TLB flags. For example, TLB_DIRTY of memory region will
>>>      not be "polluted" from other permission that translated to different
>>>      region.
>>>
>>> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
>>> feature.
>>>
>>> [1] RISC-V WG:
>>> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
>>> [2] RISC-V IOPMP:
>>> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
>>>
>>> Changed since v1:
>>> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>>>     translation until actual access in the CPU path. Provide a IOMMU
>>>     lazy translation function with the special handling of 'addend'
>>>     and 'addr_idx' fields of CPUTLBEntry.
>>> - Fix the checkpatch warning.
>>>
>>>
>>> Jim Shu (5):
>>>     accel/tcg: Pass access_type as an argument of tlb_set_page*()
>>>     accel/tcg: address_space_translate*() will pass the correct
>>>       iommu_flags
>>>     accel/tcg: Provide early AS translate function
>>>     accel/tcg: Add IOMMU lazy translation function
>>>     accel/tcg: Support IOMMU lazy translation in CPU TLB
>>>
>>>    accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>>>    include/accel/tcg/iommu.h            |  17 +-
>>>    include/exec/cputlb.h                |  11 +-
>>>    include/exec/tlb-flags.h             |   4 +-
>>>    include/hw/core/cpu.h                |  15 ++
>>>    system/physmem.c                     |  60 ++++++-
>>>    target/alpha/helper.c                |   2 +-
>>>    target/avr/helper.c                  |   3 +-
>>>    target/hppa/mem_helper.c             |   1 -
>>>    target/i386/tcg/system/excp_helper.c |   3 +-
>>>    target/loongarch/tcg/tlb_helper.c    |   2 +-
>>>    target/m68k/helper.c                 |  10 +-
>>>    target/microblaze/helper.c           |   8 +-
>>>    target/mips/tcg/system/tlb_helper.c  |   4 +-
>>>    target/or1k/mmu.c                    |   2 +-
>>>    target/ppc/mmu_helper.c              |   2 +-
>>>    target/riscv/cpu_helper.c            |   2 +-
>>>    target/rx/cpu.c                      |   3 +-
>>>    target/s390x/tcg/excp_helper.c       |   2 +-
>>>    target/sh4/helper.c                  |   3 +-
>>>    target/sparc/mmu_helper.c            |   6 +-
>>>    target/tricore/helper.c              |   2 +-
>>>    target/xtensa/helper.c               |   3 +-
>>>    23 files changed, 354 insertions(+), 58 deletions(-)
>>>
>>
> 
> Regards,
> Jim


