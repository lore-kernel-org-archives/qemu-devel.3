Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD3FFF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGPFp-0005ik-5Z; Fri, 24 Apr 2026 18:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPFn-0005i0-Lx
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:44:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPFk-0007Rj-Ce
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:44:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLqPj41878730
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 22:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KdVuCZtWLuihDAqugpLUS5Oub+M5mmrQSdZskvzALlI=; b=bW2qnutB6ytHE1R6
 oIFNab5HWYydAnAXn7fZ5cFeNbYBpqtVXFxpBzczE6utm6CNNhdgsaVzxI2KLDzE
 b/SA00UvzPqiPoEL7hQj5r52WNYp10fv68PcrCl+pvR6zQ3pb2gJSYqgvXyhfZts
 JjxkMk18dVkIYFspYaQlmhaIdGIBWdgHrb8Jxli4ik3sYq8uqUb4mUEZQxSrkDRy
 UbOMmDHNa3/7MVuE5br/flFT3Jirr9CjT5GX6cHVdkTnHu/Sgla7zZ6Qcjd6C98p
 c+nML2xYRAUjWWgjuiKFMn3sbSfEtNbn+/xII34j3jq6PW5ezLWZQX2489dU9DuP
 i776Lw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n3f7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 22:44:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c8ccc7593so9547676c88.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777070641; x=1777675441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdVuCZtWLuihDAqugpLUS5Oub+M5mmrQSdZskvzALlI=;
 b=bWNenjH15sCtnRDzlqPO8iTkr6vSpn4EhJe0GYGR+Axjkqfyxb0FmUSAR7yUxLxMWP
 XtIuGUfONKhk00wUT0o2InQAfQnizetYzg4duj6gkVJNWoqQAkVf56d8V26v6+lrY7sI
 8L3GtIK74npZv9kkzWFZl1/xOEfyArIibTfOEXA4gNANNno+ciU5g6TQFTuECWWhfY9o
 U/CpcX6vYtXW3nxpNaFdcURS7cgNE/wh/QIWbT2nq8AbO3geTZsNYpeieH/1+iIcxGJF
 qohlOzCAIGVn8E/1ZeAWK2MFMe8TdreDYb1osk+hmLGenUYgWGv6BeyXydpoMkhgYBye
 1NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777070641; x=1777675441;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdVuCZtWLuihDAqugpLUS5Oub+M5mmrQSdZskvzALlI=;
 b=SN5FYyPM26xRiki8Fow8EUFDeO8W1XWRbBJuphXGy0GEaVoLgWK5G7/0185yz3/xth
 q6TisOx5uLvK7DE5CczYpVBxKhZV9x4TAEHou8ToF8pJBU1TzkjJTZ3oB5DZWlV6evt5
 zR3BW1zSFQcMNMOrAALj+pW9g+Cx+Y5JBs1lNSmkljbV+HRoG4Gw8wJSp79dzcpKga51
 v2mhXGtw6C4MXu5QZrVGtkwowdqifJyBHmt2ZQmf02fexOXIL/mRu4INJ9LJV0vWKZxe
 qA1NP7tFCUlzWaeCM4UVHMk/5DHrghkgZ2xvRiOCB9/FTYHa4s+TyJ8zYIL7HQ0NRYBH
 fI5g==
X-Gm-Message-State: AOJu0YxAx0zShelJk1RF5cb2hUIT3vVtIcbv4bXZr71KLupwuYCkpgbT
 L9NqGrd1FD+ULcYW64oVBhHLKE+Wp+6RAMgxu3ayztmUtzSglODhs4Sh3sVFSVZC3LWI5X3tDKR
 IXUStTSY8rr3Z3HZbZwx82zXFz8zHAG4FL92t8FuQiFu3OWy/nb/Lr0V8MA==
X-Gm-Gg: AeBDieuy2rpUsTO9W0g8umKH8N7bSQ7r+/mbsp/V7DALQ70MJDbaak9U18yvHhzuZRR
 Xd9xOcC0n/gXXdWWjeMrOjTaBi7XGInAgLOyeiXAw+Aqor5yfVCzlXqFNgiUhp+2fHFv80uMCWJ
 vrzYneM0mMnFrR72NKK46OLJzIGisjSp/C7kZ2pmKahYdHbv2s1BiM7ZN/pWGcNJW/26V9IH77h
 lOJnjdn30Ja0h7PnHz1h+kHqrhw4inDoyh1/oI5VSJm8ZedLfWoPCY5xuz6gUdeXWnh/JPXib6I
 0dZeQQUVwTUDOPz1AC3rhVzXytpdJvYZC/Qp/tD1+VDXe6T7hpJbiOKsu8jR9ljQvTiPDJSANDA
 BfGWiJdBWcVbwMNmPp95XNC0gFhQc54xHYFAU7wcYOW8YEScsKJ42X40jxnnKOAeLXK4tJCIcfM
 7AXHZxMA0Aefo1D1WqH7BJ5g/I
X-Received: by 2002:a05:7023:b13:b0:128:e693:b61c with SMTP id
 a92af1059eb24-12c73fa713emr17928674c88.27.1777070640885; 
 Fri, 24 Apr 2026 15:44:00 -0700 (PDT)
X-Received: by 2002:a05:7023:b13:b0:128:e693:b61c with SMTP id
 a92af1059eb24-12c73fa713emr17928640c88.27.1777070640101; 
 Fri, 24 Apr 2026 15:44:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a18a2bsm51176357c88.10.2026.04.24.15.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 15:43:59 -0700 (PDT)
Message-ID: <df045780-3766-4439-9868-11d6c120187d@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 15:43:56 -0700
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
 <bc5d23b6-1d2e-4509-a148-be39114213b7@oss.qualcomm.com>
 <CALw707qmq813FDueR2e-Sh_MiD8gtoHFxR9nn9N-Mt5rKFXamw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CALw707qmq813FDueR2e-Sh_MiD8gtoHFxR9nn9N-Mt5rKFXamw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p6IXZ7ZMQjaJ2hIbmu5fTNOQavYqpICf
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69ebf232 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=EUspDBNiAAAA:8
 a=bVDCAMX-JvUz-fkPVbsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=oJz5jJLG1JtSoe7EL652:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-ORIG-GUID: p6IXZ7ZMQjaJ2hIbmu5fTNOQavYqpICf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIyMSBTYWx0ZWRfX+sD0cKiKWbHy
 twzoQ3ys9nyGueslhbxXIBKcwzGBUdttmUPHFWX3ywUpMvF5bUhuodXul9DAkXqTs0+yIevO0Ba
 AYCMkDIcgnzsT7Hs1ny/gHQFhF0klw68srr3FOsGdqetTZeI/+I69unNDLB2ctXlpu2hu1rLAn5
 GDLADcgN59fR3Z7AYIxzgAfZlrRi46tOHeWfIC4OLZnSpUBMjXIK51OUqzclraptXdA5hWpZAO+
 spzAPmrVeLkcCEmZO6Unpx5RZllZlq5KJQ82jALk3ds3U+UGMN0UCmQ3g9+pz81MdyFNifoG4QR
 osp6LFdoN6aIGL7HrJUtDtaNMjN2HVBo9vBBLH2xnXoiXdTCIp4ytsYstFbo/gQulqkq3ZN3AKR
 mzemwPxDLXTQOsodmMTg3xWpZTK5luO4Cttz9vgkwSXVxgRQX8wLNgdItKOWEeGnjBAH5EWer4m
 KhfvhumKz8HA9faB3Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/24/2026 8:15 AM, Jim Shu wrote:
> On Fri, Apr 24, 2026 at 2:25 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 4/22/2026 11:16 PM, Jim Shu wrote:
>>> On Thu, Apr 23, 2026 at 12:01 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> Hi Pierrick,
>>>
>>> Thanks for discussing the design!
>>>
>>>>
>>>> Hi Jim,
>>>>
>>>> On 4/21/2026 9:29 AM, Jim Shu wrote:
>>>>> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
>>>>>
>>>>> Incoming security protection devices feature more complex IOMMUMemoryRegion
>>>>> implementation in the CPU path than ARM MPC device. For example,
>>>>> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
>>>>> Consequently, the IOMMUMemoryRegion could return different sections for
>>>>> read & write access.
>>>>>
>>>>
>>>> The consequence is not directly implied for me.
>>>>
>>>> Why having a single translation and page protection handle read/write
>>>> access is not enough here?
>>>>
>>>> What is the (real world) use case to return different physical memory
>>>> locations depending on read/write access for a given virtual address?
>>>
>>> When permission is granted, the wgChecker device returns the original
>>> region of the address, called the downstream region
>>> When permission is denied, the wgChecker device returns a special
>>> MemoryRegion for error handling, called the blocked_io region).
>>> This region may trigger an IRQ and a bus error. Additionally, memory
>>> accesses to this region will result in 'read 0, write ignored' rather
>>> than triggering exceptions from the MMU or MPU.
>>>
>>> Consequently, implementing RWX permission checks on security
>>> protection devices may return different regions (either downstream or
>>> blocked_io) depending on the access type.
>>> This design is similar to the existing ARM MPC device
>>> (hw/misc/tz-mpc.c). The primary difference is that the MPC only checks
>>> the physical address rather than RWX permissions, meaning it returns
>>> either the downstream or blocked_io region for a single address
>>> regardless of the access type.
>>>
>>
>> It is indeed, a big difference. Translation with MPC device still
>> results in a single address space being chosen.
>>
>>> I also considered an alternative design where CPUTLBEntryFull stores
>>> both the successful permission and the blocked_io region of the IOMMU
>>> region.
>>> In this scenario, the slow-path code utilizing CPUTLBEntryFull would
>>> check permissions and return the blocked_io region if access is denied
>>>
>>> However, the address_space_translate_iommu() implementation supports
>>> recursive IOMMU region translation.
>>> if multiple IOMMU regions are encountered during a single address
>>> translation, storing only the first region's permissions is
>>> insufficient.
>>> Ultimately, we still face a situation where RWX permissions might
>>> return different regions separately (e.g., downstream,
>>> blocked_io_iommu1, and blocked_io_iommu2).
>>>
>>
>> The "blocked_io_iommu_X" is a consequence of the current choice of
>> implementation, but I still don't see why it's an absolute necessity.
>>
> 
> I am open to removing it if the community agrees. I believe platforms
> with the ARM MPC do not use multiple IOMMU regions when translating a
> single address.
>

I am not expert on the topic, but it seems MPC is mostly used with 
microcontrollers with trustzone and is much more limited in scope than 
WorldChecker. WorldChecker seems to be a mix of MMU + IOMMU + something 
like Arm Granule Protection Table in a single external component.

I am probably biased by Arm "World" implementation of this (out of MPC), 
where CPU and SMMU play this role, instead of an external component.

Going back to MPC, the translation is still deterministic and not based 
on type of access. From what I understand, MPC can statically forbid 
accesses to specific blocks, simply based on original address.

>> An alternative would be to treat all accesses as MMIO, but I guess your
>> goal here is to optimize the code path where we access RAM?
>>
> 
> If the downstream region is a memory region, it will update the TLB
> flags and vaddr in addr_idx for the successful permissions of IOMMU
> region.
> To explain further: In the alternative approach, we would obtain the
> downstream region, IOMMU permissions, and the blocked_io region from
> the IOMMU translation function (which would require an additional
> return value or API to get the blocked_io region). The TLB entry will
> handle the downstream region as a non-IOMMU region but will only
> update the TLB flags for the IOMMU permissions; it will also store the
> permissions and the blocked_io region. The slow-path code checks the
> IOMMU permissions. If permission is denied, it will perform the
> transaction on the blocked_io region instead.
> We can remove the lazy IOMMU translation if using an alternative approach.
>

What I was suggesting in my question was to force any access to a 
MemoryRegion handled by a wgChecker to go through a read or write 
callback, and to do the actual check there.

For instance, MPC redirects blocked calls to:
static const MemoryRegionOps tz_mpc_mem_blocked_ops = {
   .read_with_attrs = tz_mpc_mem_blocked_read,
   .write_with_attrs = tz_mpc_mem_blocked_write,

So I was suggesting something like:
static const MemoryRegionOps wgchecker_ops = {
   .read_with_attrs = wgchecker_mem_read,
   .write_with_attrs = wgchecker_mem_write,

And redirect all read/write to those callbacks, thus turning the whole 
range into an MMIO range. Thus my original question to understand if 
your main concern is runtime performance or not.
  >> Why can't you reuse existing page protection mechanism for this,
>> authorizing read or write? WorldChecker just seems to be an additional
>> check on top of existing translation. The fact it's an "additional"
>> device is a design/implementation details, and could simply be part of
>> page protection mechanism. It might require some additional plumbing
>> when an interrupt is raised though, to redirect this correctly instead
>> of signaling CPU like it would normally do.
>>
>> The fact is does different action based on read/write attribute does not
>> really fit very well with existing implementation, as you noticed. And I
>> wonder if it's worth changing the global design just to optimize this
>> (optional) use case for RISC-V.
>>
> 
> In the SoC architecture, the wgCheckers are positioned in front of
> devices (either memory or MMIO). When the CPU or DMA sends
> transactions to the device, the device's wgChecker first performs a
> permission check to determine if the transaction should be forwarded.
> If we move this check to the architecture's tlb_fill() function, how
> would the CPU code determine if transactions were sent to the device
> (or to the upstream region of the wgChecker)? The CPU code would need
> to be aware of the memory tree hierarchy to do that, which I believe
> is more difficult to implement.
>

The memory hierarchy has to be known anyway by the component dealing 
with that. Currently, TLB is responsible for it, iterating through the 
different regions. However, it could be wgChecker code that does that, 
or tlb_fill() for RISC-V.

My only concern with existing design is that it pushes all that on 
generic TLB code, for a feature that is optional and only used by 
RISC-V, but still impacting all architectures.

It's not a no, I don't have any authority on this part of codebase, but 
just a question to understand why it can't be solved another way that 
would be RISC-V specific.

> In the current QEMU architecture, when a security protection device
> sits in front of a device, placing it within the memory tree seems to
> be the most suitable approach, similar to the ARM MPC device. The
> address_space*() API can check if a transaction will be forwarded to
> the device and perform the permission check via the IOMMU region. Both
> the CPU-side address_space_translate_for_iotlb() and the DMA-side
> address_space_translate_iommu() handle this. The only missing
> component is that the CPU TLB cannot handle RWX permission checks for
> IOMMU regions within the memory tree.
>

I understand this and what you want.
I'm really open to it if anyone else has feedback on this, and help 
decide if it's worth changing generic TLB code for this use case.

> 
> 
> 
>>>>
>>>> I'm not against the goal of this series, but trying to understand why it
>>>> went in this direction, which complexify this already complex code path.
>>>>
>>>>> To support such IOMMUMemoryRegion behavior in the CPU path, the design
>>>>> of IOMMU translation must be updated:
>>>>>
>>>>> 1. address_space_translate*() must now pass the access_type to
>>>>>       IOMMUMemoryRegion.
>>>>> 2. Since IOMMU translation results are too complex to be fully stored
>>>>>       in the CPU TLB. we will defer the translation until the actual access
>>>>>       occurs. Also, TLB is allowed to store the untranslated IOMMU region.
>>>>>
>>>>> To implement deferred IOMMU translation, this patchset introduces the
>>>>> following changes:
>>>>>
>>>>> 1. tlb_set_page_full() no longer translates the IOMMU region
>>>>>       immediately. Instead, it stores the untranslated region directly in
>>>>>       the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>>>>>       access into the slow path when a region has not yet been translated
>>>>>       in the TLB entry.
>>>>>
>>>>> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>>>>>       the lazy IOMMU translation of the access_type first. The resulting
>>>>>       translated region and access type are stored in CPUTLBEntryFull.
>>>>>       Since the slow path always performs lazy translation first, we can
>>>>>       switch the CPUTLBEntryFull content to the correct access type before
>>>>>       use.
>>>>>
>>>>> 3. To accelerate memory access in the fast path, lazy translation can
>>>>>       update the addend of the CPUTLBEntry when translating the region to a
>>>>>       host memory region. We restrict the IOMMU region to have a single
>>>>>       non-zero 'addend' across all permissions. If a second 'addend' is
>>>>>       present for a CPUTLBEntry, QEMU will trigger an assertion. This
>>>>>       limitation is sufficient for security devices, as their "secondary"
>>>>>       region is typically an IO region used to emulate device error
>>>>>       handling when access is rejected.
>>>>>
>>>>> 4. To support non-slow TLB flags, lazy translation can update the TLB
>>>>>       flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>>>>>       updates the flags for the permissions specified in @prot. This
>>>>>       ensures that each access_type of a translated region to maintains
>>>>>       independent TLB flags. For example, TLB_DIRTY of memory region will
>>>>>       not be "polluted" from other permission that translated to different
>>>>>       region.
>>>>>
>>>>> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
>>>>> feature.
>>>>>
>>>>> [1] RISC-V WG:
>>>>> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
>>>>> [2] RISC-V IOPMP:
>>>>> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
>>>>>
>>>>> Changed since v1:
>>>>> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>>>>>      translation until actual access in the CPU path. Provide a IOMMU
>>>>>      lazy translation function with the special handling of 'addend'
>>>>>      and 'addr_idx' fields of CPUTLBEntry.
>>>>> - Fix the checkpatch warning.
>>>>>
>>>>>
>>>>> Jim Shu (5):
>>>>>      accel/tcg: Pass access_type as an argument of tlb_set_page*()
>>>>>      accel/tcg: address_space_translate*() will pass the correct
>>>>>        iommu_flags
>>>>>      accel/tcg: Provide early AS translate function
>>>>>      accel/tcg: Add IOMMU lazy translation function
>>>>>      accel/tcg: Support IOMMU lazy translation in CPU TLB
>>>>>
>>>>>     accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>>>>>     include/accel/tcg/iommu.h            |  17 +-
>>>>>     include/exec/cputlb.h                |  11 +-
>>>>>     include/exec/tlb-flags.h             |   4 +-
>>>>>     include/hw/core/cpu.h                |  15 ++
>>>>>     system/physmem.c                     |  60 ++++++-
>>>>>     target/alpha/helper.c                |   2 +-
>>>>>     target/avr/helper.c                  |   3 +-
>>>>>     target/hppa/mem_helper.c             |   1 -
>>>>>     target/i386/tcg/system/excp_helper.c |   3 +-
>>>>>     target/loongarch/tcg/tlb_helper.c    |   2 +-
>>>>>     target/m68k/helper.c                 |  10 +-
>>>>>     target/microblaze/helper.c           |   8 +-
>>>>>     target/mips/tcg/system/tlb_helper.c  |   4 +-
>>>>>     target/or1k/mmu.c                    |   2 +-
>>>>>     target/ppc/mmu_helper.c              |   2 +-
>>>>>     target/riscv/cpu_helper.c            |   2 +-
>>>>>     target/rx/cpu.c                      |   3 +-
>>>>>     target/s390x/tcg/excp_helper.c       |   2 +-
>>>>>     target/sh4/helper.c                  |   3 +-
>>>>>     target/sparc/mmu_helper.c            |   6 +-
>>>>>     target/tricore/helper.c              |   2 +-
>>>>>     target/xtensa/helper.c               |   3 +-
>>>>>     23 files changed, 354 insertions(+), 58 deletions(-)
>>>>>
>>>>
>>>
>>> Regards,
>>> Jim
>>

Regards,
Pierrick

