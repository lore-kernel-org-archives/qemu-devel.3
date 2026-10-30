Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6E606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZK+3vP3O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F5uqwWbG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtl4-0005Cu-Fi; Fri, 30 Oct 2026 17:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMtl2-0005Ca-IR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:03:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMtkx-0006qx-1o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 17:03:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIhiw34084431
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 21:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E389OvanxkbEKREiax+LCcqV56xCVly/DdRl0k84hQk=; b=ZK+3vP3OSlLI53o0
 bkOHiX6Y095q1tNpoZ84ATvKPdKo2A+EPXMDv1NRpRyLM3nEFnfBABm9uNlc0q9s
 2Gv6k3rvEuRM8eyngMz+YcgSPqxJeg0qXWs7FbMHRbq6PfkfMIjYgs0z1Xqf1gUY
 4IxI9a28sXVIUkMzaVghpV89Dq8+22tQ1hmG87M58tlfs/kZQLxiqOOuQ+gpatwN
 dBJ/lW24zgNbJrZOeLdLSozsc813X+apxq6luwV5c/MQKb1kyggYnMLFC17M7eZP
 8IClor7++JfkNujcQNC5niyuLzrnOBz1+EbJI2RwcUx4kek/7bm5sHj5iefIfja7
 mxroyQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0s60c2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 21:03:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so227715385a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793394198; x=1793998998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E389OvanxkbEKREiax+LCcqV56xCVly/DdRl0k84hQk=;
 b=F5uqwWbGsFNJHcjpPgwq1AsvhpBie4T1oZEwEmXKEP5ia+UJ956gQ1jFOv3fh8NU5B
 ev59yLP9EXCEkj7FNZgRjNoC30EJflxkWS0u9fYpLfFYVP2fmKv3d8tM6PGJ0C2McP30
 FGTpLEZ5XRVpph12x06XtgoGGNkYyB0KK9Pg0Hb6Fi08yVT8Zqb9GICOtpfIYM0UIENH
 f5NuyxPBVyJsaAKNww00YeDxsrdGCjYyztY1BRHGJgNjdAf//QUJZS+1BfUOdwKEKKzT
 iTZGTOVelvpKU1qjexmXLoj1M5jA2B1I5A2PgpUhxEzruh2RTeQNDKAwu81WuAcQkWVl
 JduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793394198; x=1793998998;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E389OvanxkbEKREiax+LCcqV56xCVly/DdRl0k84hQk=;
 b=uOXRWjlu7ML6KmAb9y0GaSBYzVmUwES/v+tp1NUw5SpX3bzUQ9YxzLbW0K/vEzmrGV
 EupqYmg73jk//D2EcezXaSXSdD6w+6M2ajBBpNZTmCriDL+YP+0B4lokKz05qdnbTBKn
 TnrRvY+oNQTGYMZt2Szgz8z6CFgwnoJddghi7NOplZkVEAIC8K3pz2tsx3qqVnlQCsjB
 PHad9dX/bHCQg1FhHnulT8jZMwSmEE4QiiLXGfmFOsPR0ZtJpRUaAH4skmVwLh/hEmUT
 IJ6hw6bFTquLBfGtQVuIhR64FLOiRszbu8oPy1rkNYa7oRlTQM5IpmTYvVpLPOihRJhs
 iyEQ==
X-Gm-Message-State: AFq9FYJaz2adHPDELBf0PhoY0dWdv0YahH86BAS+E8TgOZuNjNv8IlMJ
 t3DCZVqNLJ0wwq8W8Ssqo2XgBFBrtV9h4u62B6s8lq88AuS+OARFXo2rwGy+j9tcplvkYISH4Lm
 2ZvvMAsA3CFQ2mL4od2b4aMioJAMQYyobebzh901o39h6quIruLgCl4ZWCA==
X-Gm-Gg: AYBFou0SLsU0oVzJGOCt9Wghgm/QiqGsOXK9RPPYXhnlttIbmRZ2kR+4d2PIJHGur+J
 CJ9hUNrePm+LAPe6y6FNuM1weSqz+hHBlxrZfoL6GwNdxWJHBmLZokuTORPvpT48vG+CRSVrVgR
 VU4CqAQEK8k/CL8j1laBa/IizZu9P0Qv6WyzK6pqr7394no51VRiS3iGDioKvwcN/2Hqv+FRGTF
 pUU+NBk0woNwNg+ZG0J2h//RHHNi4a8Zql2g0+jv9VpVP1n0lzMXBAEeI5V/lGYVJI+/tB8jppD
 8/uONljsYCX8mX9IsXm3vA6lp/DNP2AZMUMbITywnVDe9XsczoGtAOfP0w3qwaIMydGYFA1ibxF
 c5fDcl4ObDQxmx/N1iwGdqXe8mChhG3HtfYfnDVOZYX/Ghf5tvqOFPKzFMt+3desnzD13MU6Eu7
 0bUK8c2lj0ig==
X-Received: by 2002:a05:620a:880c:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-944217ee856mr576878785a.68.1793394197925; 
 Fri, 30 Oct 2026 14:03:17 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-944217ee856mr576868685a.68.1793394197135; 
 Fri, 30 Oct 2026 14:03:17 -0700 (PDT)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425a6d72esm232826385a.28.2026.10.30.14.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 14:03:16 -0700 (PDT)
Message-ID: <7b4dc9d4-554e-47c6-8f92-40c79b31388c@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 18:03:12 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/iommu-sys: honor MSI vector masks
To: Zephyr Li <fritchleybohrer@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20261028031042.1496-1-fritchleybohrer@gmail.com>
 <49ae69e6-aab4-4f7d-8a12-db28cf513a62@oss.qualcomm.com>
 <CAN4PorXMM1uR3PjQZK7vp-pnaOaZ7Sgm4hHrqhO+G92FfsnCtw@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAN4PorXMM1uR3PjQZK7vp-pnaOaZ7Sgm4hHrqhO+G92FfsnCtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E72F9fCdGBVhdydD5iCkHlu1uX2rR6yy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MyBTYWx0ZWRfX5Z3BTmGRvbE0
 D/svchjWsqqB0JmCMh3QFWSruiidhZ8NZSLdnY7FKfY3sbdPjLpFu3ns1O1WpuEY9Xa4p1w7NhT
 eesi5XH0EhN7Wgb1I5T8Xs/L2DB4THjBa9Yq6SmXetIKCSL6Gif57xTJIoTxgoNP+rusbh315ST
 Xhdvv7xXo0NckTvL0l8h6bDFzOe2cK6zZv8C004Z/W3AUk8xZHO+9Yde+qTNYHDPCbD2uYJfshb
 p9R5HlnZcYutxNaAeAywiFd9gxkmndDm9saGQ+/zfJZokTKIWUwylsAEo1Z6NR0pX7PWUzS91EE
 VAglB/aK+f9fFDnqFOwbl55hxqRF9SyIhqslE93T3VmW0sLwm6HzlCsSXM42e6V0VaA5MdIyhzo
 BUPA33y/j2GxSLHqMVh+yGbdDL5vImYwvFX19NgZ9VE4YBdDK/cz3fgSHudywc4XL8bcjNdcbs3
 pmzRhR5r16iO4Las+TQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MyBTYWx0ZWRfX8fW9Ydq2Z7ws
 EjT9AHs0U1xkE+nNiqNzM4K3y4l/KpmTJQVOXx6IZZmBUaDcDWYMGlxX1Lr+yKCSOg+mNLViIR4
 Hf8Oo7gsGrb63LI/vusxHsYBfFCc1fI=
X-Authority-Analysis: v=2.4 cv=NaxzRGD4 c=1 sm=1 tr=0 ts=6ae50617 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=HwFc7jivAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=K_GX1-khK5uJNKVDR14A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-GUID: E72F9fCdGBVhdydD5iCkHlu1uX2rR6yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/2026 11:28 PM, Zephyr Li wrote:
> Hi Daniel,
> 
> Thanks for the review!
> 
> I agree that reusing msix_pba as the pending bitmap would avoid maintaining
> redundant state.
> 
> My concern is that the existing msix_pba_mmio region is mapped at offset
> 0x400, while the RISC-V IOMMU specification defines 0x400-0xfff as reserved
> for future standard use, which must read as zero.
> 
> The specification discusses the MSI-X PBA in the context of PCIe IOMMU
> integration, whereas riscv-iommu-sys is a SysBus device.
> 
> References:
> 
>     -
> 
>     https://docs.riscv.org/reference/iommu/v20260222/iommu_registers.html
>     -
> 
>     https://docs.riscv.org/reference/iommu/v20260222/iommu_hw_guidelines.html
> 
> If we reuse msix_pba directly, the current MMIO read handler would expose
> non-zero pending bits through the reserved region.

Thanks for the detailed explanation.  I wasn't aware that we were mapping a zero
only region as msix_pba.  Seems like I didn't add enough context back when I
implemented these bits 2 years ago, and unfortunately I can't recall if this
mapping was done by design or by accident.

I believe for v2 we can keep the code as is and add this explanation, with the
links you provided, as in-code comment to explain why we're not touching msix_pba
and using s->msi_pending instead.  There's a good chance that we'll revisit this
feature when Linux support starts to catch up and we'll want as much context as
possible in QEMU code.


Thanks,
Daniel

> 
> Would it make sense to reuse msix_pba as the internal pending bitmap while
> keeping reads from the reserved MMIO region returning zero?
> 
> I can update the implementation and tests accordingly in v2.
> 
> Thanks,
> Zephyr
> 
> On Fri, Oct 30, 2026 at 5:28 AM Daniel Henrique Barboza <
> daniel.barboza@oss.qualcomm.com> wrote:
> 
>>
>>
>> On 10/28/2026 12:10 AM, Zephyr Li wrote:
>>> The system IOMMU currently sends MSIs without checking the corresponding
>>> vector mask bit in the MSI configuration table.
>>>
>>> Honor the mask bit and maintain one pending flag per vector.
>> Notifications
>>> generated while masked are deferred and coalesced. Unmasking a vector
>>> delivers one pending MSI, if any, and reset clears all pending flags.
>>>
>>> Do not release deferred MSIs while FCTL.WSI selects wired interrupt mode.
>>> When switching back to MSI mode, release unmasked pending vectors and
>>> retain masked ones until unmask.
>>>
>>> Add qtests covering masked and unmasked delivery, vector isolation, MSI
>>> configuration updates, wired interrupt delivery, mode transitions, and
>>> reset.
>>>
>>> Fixes: 01c1caa9d1b4 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx
>> support")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4444
>>> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
>>> ---
>>
>> This is less of a bug fix and more of a new feature.  I was ducking it for
>> awhile because the Linux kernel support for masked MSIs with the RISC-V
>> IOMMU
>> isn't there yet, but I'm glad you went ahead and implemented it anyway.
>>
>> One comment:
>>
>>>    hw/riscv/riscv-iommu-sys.c     |  67 ++++-
>>>    hw/riscv/riscv-iommu.c         |  12 +
>>>    hw/riscv/riscv-iommu.h         |   3 +
>>>    tests/qtest/iommu-riscv-test.c | 461 +++++++++++++++++++++++++++++++++
>>>    4 files changed, 541 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
>>> index 258c171efd..96d2bdff7a 100644
>>> --- a/hw/riscv/riscv-iommu-sys.c
>>> +++ b/hw/riscv/riscv-iommu-sys.c
>>> @@ -52,8 +52,50 @@ struct RISCVIOMMUStateSys {
>>>        MemoryRegion msix_pba_mmio;
>>>        uint8_t *msix_table;
>>>        uint8_t *msix_pba;
>>> +    /* Platform MSI state; the reserved PBA region does not expose it.
>> */
>>
>> Can you add the riscv-iommu/riscv-aia citation that says that the PBA
>> region doesn't
>> need update for this kind of masking?  As far as I'm aware we would need
>> to update
>> msix_pba too, along with the msi_pending array you created.  Basically
>> every time
>> you set s->msi_pending[vector] = true you would write '1' in
>> msix_pba[vector],
>> and likewise when you're seeting s->msi_pending[vector] = false.
>>
>> In fact, do we need s->msi_pending?  Can't we just use msix_pba directly?
>>
>>
>> Thanks,
>> Daniel
>>
>>
>>
>>> +    bool msi_pending[RISCV_IOMMU_PCI_MSIX_VECTORS];
>>>    };
>>>
>>> +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
>>> +                                                 uint32_t vector);
>>> +
>>> +static bool riscv_iommu_sysdev_msi_masked(RISCVIOMMUStateSys *s,
>>> +                                          uint32_t vector)
>>> +{
>>> +    uint8_t *table_entry;
>>> +
>>> +    g_assert(vector < RISCV_IOMMU_PCI_MSIX_VECTORS);
>>> +    table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
>>> +
>>> +    return pci_get_long(table_entry + PCI_MSIX_ENTRY_VECTOR_CTRL) &
>>> +           PCI_MSIX_ENTRY_CTRL_MASKBIT;
>>> +}
>>> +
>>> +static void riscv_iommu_sysdev_release_pending(RISCVIOMMUStateSys *s,
>>> +                                              uint32_t vector)
>>> +{
>>> +    /* Retain deferred MSI messages until MSI mode is restored. */
>>> +    if (riscv_iommu_reg_get32(&s->iommu, RISCV_IOMMU_REG_FCTL) &
>>> +        RISCV_IOMMU_FCTL_WSI) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (s->msi_pending[vector] &&
>>> +        !riscv_iommu_sysdev_msi_masked(s, vector)) {
>>> +        s->msi_pending[vector] = false;
>>> +        riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
>>> +    }
>>> +}
>>> +
>>> +static void riscv_iommu_sysdev_msi_enabled(RISCVIOMMUState *iommu)
>>> +{
>>> +    RISCVIOMMUStateSys *s = container_of(iommu, RISCVIOMMUStateSys,
>> iommu);
>>> +
>>> +    for (unsigned vector = 0; vector < ARRAY_SIZE(s->msi_pending);
>> vector++) {
>>> +        riscv_iommu_sysdev_release_pending(s, vector);
>>> +    }
>>> +}
>>> +
>>>    static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
>>>                                         unsigned size)
>>>    {
>>> @@ -67,9 +109,17 @@ static void msix_table_mmio_write(void *opaque,
>> hwaddr addr,
>>>                                      uint64_t val, unsigned size)
>>>    {
>>>        RISCVIOMMUStateSys *s = opaque;
>>> +    uint32_t vector = addr / PCI_MSIX_ENTRY_SIZE;
>>> +    bool was_masked;
>>>
>>>        g_assert(addr + size <= RISCV_IOMMU_PCI_MSIX_VECTORS *
>> PCI_MSIX_ENTRY_SIZE);
>>> +
>>> +    was_masked = riscv_iommu_sysdev_msi_masked(s, vector);
>>>        pci_set_long(s->msix_table + addr, val);
>>> +
>>> +    if (was_masked && !riscv_iommu_sysdev_msi_masked(s, vector)) {
>>> +        riscv_iommu_sysdev_release_pending(s, vector);
>>> +    }
>>>    }
>>>
>>>    static const MemoryRegionOps msix_table_mmio_ops = {
>>> @@ -134,8 +184,8 @@ static void
>> riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
>>>                                    &s->msix_pba_mmio);
>>>    }
>>>
>>> -static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
>>> -                                        uint32_t vector)
>>> +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
>>> +                                                 uint32_t vector)
>>>    {
>>>        uint8_t *table_entry = s->msix_table + vector *
>> PCI_MSIX_ENTRY_SIZE;
>>>        uint64_t msi_addr = pci_get_quad(table_entry +
>> PCI_MSIX_ENTRY_LOWER_ADDR);
>>> @@ -160,6 +210,17 @@ static void
>> riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
>>>        }
>>>    }
>>>
>>> +static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
>>> +                                        uint32_t vector)
>>> +{
>>> +    if (riscv_iommu_sysdev_msi_masked(s, vector)) {
>>> +        s->msi_pending[vector] = true;
>>> +        return;
>>> +    }
>>> +
>>> +    riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
>>> +}
>>> +
>>>    static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
>>>                                          unsigned vector)
>>>    {
>>> @@ -194,6 +255,7 @@ static void riscv_iommu_sys_realize(DeviceState
>> *dev, Error **errp)
>>>        }
>>>
>>>        s->iommu.notify = riscv_iommu_sysdev_notify;
>>> +    s->iommu.msi_enabled = riscv_iommu_sysdev_msi_enabled;
>>>
>>>        /* 4 IRQs are defined starting from s->base_irq */
>>>        for (int i = 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
>>> @@ -255,6 +317,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj,
>> ResetType type)
>>>        RISCVIOMMUState *iommu = &sys->iommu;
>>>
>>>        riscv_iommu_reset(iommu);
>>> +    memset(sys->msi_pending, 0, sizeof(sys->msi_pending));
>>>
>>>        trace_riscv_iommu_sys_reset_hold(type);
>>>    }
>>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>>> index 323a041b4a..23b6f8da86 100644
>>> --- a/hw/riscv/riscv-iommu.c
>>> +++ b/hw/riscv/riscv-iommu.c
>>> @@ -2419,6 +2419,7 @@ static MemTxResult riscv_iommu_mmio_write(void
>> *opaque, hwaddr addr,
>>>        RISCVIOMMUState *s = opaque;
>>>        uint32_t regb = addr & ~3;
>>>        uint32_t busy = 0;
>>> +    uint32_t old_fctl = 0;
>>>        uint64_t val = 0;
>>>        bool cy_inh = false;
>>>
>>> @@ -2434,6 +2435,10 @@ static MemTxResult riscv_iommu_mmio_write(void
>> *opaque, hwaddr addr,
>>>
>>>        /* Track actionable MMIO write. */
>>>        switch (regb) {
>>> +    case RISCV_IOMMU_REG_FCTL:
>>> +        old_fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
>>> +        break;
>>> +
>>>        case RISCV_IOMMU_REG_DDTP:
>>>        case RISCV_IOMMU_REG_DDTP + 4:
>>>            process_fn = riscv_iommu_process_ddtp;
>>> @@ -2510,6 +2515,13 @@ static MemTxResult riscv_iommu_mmio_write(void
>> *opaque, hwaddr addr,
>>>         */
>>>        riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
>>>
>>> +    if (regb == RISCV_IOMMU_REG_FCTL && s->msi_enabled &&
>>> +        (old_fctl & RISCV_IOMMU_FCTL_WSI) &&
>>> +        !(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL) &
>>> +          RISCV_IOMMU_FCTL_WSI)) {
>>> +        s->msi_enabled(s);
>>> +    }
>>> +
>>>        /* Busy flag update, MSB 4-byte register. */
>>>        if (busy) {
>>>            uint32_t rw = ldl_le_p(&s->regs[regb]);
>>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>>> index 7c470ba084..ea1b53e732 100644
>>> --- a/hw/riscv/riscv-iommu.h
>>> +++ b/hw/riscv/riscv-iommu.h
>>> @@ -61,6 +61,9 @@ struct RISCVIOMMUState {
>>>        /* interrupt notifier */
>>>        void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>>>
>>> +    /* Optional platform callback when FCTL switches from WSI to MSI. */
>>> +    void (*msi_enabled)(RISCVIOMMUState *iommu);
>>> +
>>>        /* IOMMU target address space */
>>>        AddressSpace *target_as;
>>>        MemoryRegion *target_mr;
>>> diff --git a/tests/qtest/iommu-riscv-test.c
>> b/tests/qtest/iommu-riscv-test.c
>>> index 2638024891 <(263)%20802-4891>..979a976e4f 100644
>>> --- a/tests/qtest/iommu-riscv-test.c
>>> +++ b/tests/qtest/iommu-riscv-test.c
>>> @@ -19,6 +19,28 @@
>>>
>>>    #define DMA_LEN           4
>>>
>>> +#define RISCV_IOMMU_SYS_MSI_TARGET0  (QRIOMMU_SPACE_OFFS +
>> 0x03000000ull)
>>> +#define RISCV_IOMMU_SYS_MSI_TARGET1  (RISCV_IOMMU_SYS_MSI_TARGET0 + 4)
>>> +#define RISCV_IOMMU_SYS_CQ_BASE      \
>>> +    (QRIOMMU_SPACE_OFFS + QRIOMMU_CQ_BASE_ADDR)
>>> +#define RISCV_IOMMU_SYS_MSI_DATA0    0x12345678
>>> +#define RISCV_IOMMU_SYS_MSI_DATA1    0xa5a55a5a
>>> +
>>> +/* RISC-V virt machine PLIC, hart 0 M-mode context. */
>>> +#define RISCV_PLIC_BASE             0x0c000000
>>> +#define RISCV_PLIC_PENDING          (RISCV_PLIC_BASE + 0x1000)
>>> +#define RISCV_PLIC_ENABLE           (RISCV_PLIC_BASE + 0x2000)
>>> +#define RISCV_PLIC_THRESHOLD        (RISCV_PLIC_BASE + 0x200000)
>>> +#define RISCV_PLIC_CLAIM            (RISCV_PLIC_THRESHOLD + 4)
>>> +#define RISCV_IOMMU_SYS_IRQ_BASE    36
>>> +
>>> +#define PCI_TESTDEV_TEST             0
>>> +#define PCI_TESTDEV_WIDTH            1
>>> +#define PCI_TESTDEV_OFFSET           4
>>> +#define PCI_TESTDEV_DATA             8
>>> +#define PCI_TESTDEV_COUNT            12
>>> +#define PCI_TESTDEV_NO_EVENTFD       0
>>> +
>>>    /* RISC-V virt machine PCI configuration */
>>>    #define RISCV_GPEX_PIO_BASE        0x3000000
>>>    #define RISCV_BUS_PIO_LIMIT        0x10000
>>> @@ -264,6 +286,425 @@ static void test_riscv_iommu_nested(void)
>>>        run_riscv_iommu_translation(&cfg);
>>>    }
>>>
>>> +static void riscv_iommu_sys_set_wsi(QTestState *qts, bool wsi)
>>> +{
>>> +    uint64_t base = VIRT_RISCV_IOMMU_BASE;
>>> +    uint32_t fctl;
>>> +
>>> +    /* Feature changes require Off mode and all in-memory queues
>> disabled. */
>>> +    g_assert_cmphex(qtest_readq(qts, base + RISCV_IOMMU_REG_DDTP) &
>>> +                    (RISCV_IOMMU_DDTP_MODE | RISCV_IOMMU_DDTP_BUSY),
>>> +                    ==, RISCV_IOMMU_DDTP_MODE_OFF);
>>> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_CQCSR) &
>>> +                    (RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CQON |
>>> +                     RISCV_IOMMU_CQCSR_BUSY), ==, 0);
>>> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FQCSR) &
>>> +                    (RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FQON |
>>> +                     RISCV_IOMMU_FQCSR_BUSY), ==, 0);
>>> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_PQCSR) &
>>> +                    (RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PQON |
>>> +                     RISCV_IOMMU_PQCSR_BUSY), ==, 0);
>>> +
>>> +    fctl = qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL);
>>> +    fctl = (fctl & ~RISCV_IOMMU_FCTL_WSI) |
>>> +           (wsi ? RISCV_IOMMU_FCTL_WSI : 0);
>>> +    qtest_writel(qts, base + RISCV_IOMMU_REG_FCTL, fctl);
>>> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL) &
>>> +                    RISCV_IOMMU_FCTL_WSI, ==, fctl &
>> RISCV_IOMMU_FCTL_WSI);
>>> +}
>>> +
>>> +static QTestState *riscv_iommu_sys_test_init(const char *extra_args)
>>> +{
>>> +    QTestState *qts;
>>> +    uint64_t cap;
>>> +    uint32_t igs;
>>> +
>>> +    if (!qtest_has_machine("virt")) {
>>> +        g_test_skip("virt machine not available");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    qts = qtest_initf("-machine virt,aia=none,acpi=off,iommu-sys=on "
>>> +                      "-cpu max -smp 1 -m 512 -net none -nodefaults %s",
>>> +                      extra_args ? extra_args : "");
>>> +
>>> +    cap = qtest_readq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CAP);
>>> +    igs = (cap & RISCV_IOMMU_CAP_IGS) >> 28;
>>> +    g_assert_cmpuint(igs, <=, RISCV_IOMMU_CAP_IGS_BOTH);
>>> +    g_assert_cmpuint(igs, !=, RISCV_IOMMU_CAP_IGS_WSI);
>>> +
>>> +    riscv_iommu_sys_set_wsi(qts, false);
>>> +
>>> +    return qts;
>>> +}
>>> +
>>> +static QPCIDevice *riscv_iommu_sys_init_msi_sink(QTestState *qts,
>>> +                                                  QGenericPCIBus *gbus,
>>> +                                                  QPCIBar *bar,
>>> +                                                  uint64_t *target,
>>> +                                                  uint32_t *data)
>>> +{
>>> +    QPCIDevice *dev = NULL;
>>> +    uint32_t offset;
>>> +
>>> +    qpci_init_generic(gbus, qts, NULL, false);
>>> +    riscv_config_qpci_bus(gbus);
>>> +    qpci_device_foreach(&gbus->bus, PCI_VENDOR_ID_REDHAT,
>>> +                        PCI_DEVICE_ID_REDHAT_TEST, save_fn, &dev);
>>> +    g_assert(dev);
>>> +
>>> +    qpci_device_enable(dev);
>>> +    *bar = qpci_iomap(dev, 0, NULL);
>>> +    g_assert_false(bar->is_io);
>>> +
>>> +    qpci_io_writeb(dev, *bar, PCI_TESTDEV_TEST, PCI_TESTDEV_NO_EVENTFD);
>>> +    g_assert_cmpuint(qpci_io_readb(dev, *bar, PCI_TESTDEV_WIDTH), ==,
>> 1);
>>> +    offset = qpci_io_readl(dev, *bar, PCI_TESTDEV_OFFSET);
>>> +    *data = qpci_io_readl(dev, *bar, PCI_TESTDEV_DATA);
>>> +    *target = bar->addr + offset;
>>> +    g_assert_cmpuint(qpci_io_readl(dev, *bar, PCI_TESTDEV_COUNT), ==,
>> 0);
>>> +
>>> +    return dev;
>>> +}
>>> +
>>> +static void riscv_iommu_sys_program_msi(QTestState *qts, unsigned
>> vector,
>>> +                                        uint64_t target, uint32_t data,
>>> +                                        bool masked)
>>> +{
>>> +    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG
>> +
>>> +                     vector * PCI_MSIX_ENTRY_SIZE;
>>> +
>>> +    qtest_writeq(qts, entry + PCI_MSIX_ENTRY_LOWER_ADDR, target);
>>> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_DATA, data);
>>> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
>>> +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
>>> +}
>>> +
>>> +static void riscv_iommu_sys_set_mask(QTestState *qts, unsigned vector,
>>> +                                     bool masked)
>>> +{
>>> +    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG
>> +
>>> +                     vector * PCI_MSIX_ENTRY_SIZE;
>>> +
>>> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
>>> +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
>>> +}
>>> +
>>> +static void riscv_iommu_sys_setup_cq(QTestState *qts)
>>> +{
>>> +    uint64_t cqb = (RISCV_IOMMU_SYS_CQ_BASE >> 12) << 10;
>>> +    uint32_t cqcsr;
>>> +
>>> +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE, UINT64_MAX);
>>> +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE + 8, 0);
>>> +    qtest_writeq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQB, cqb);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
>>> +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE);
>>> +
>>> +    cqcsr = qtest_readl(qts,
>>> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
>>> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CQON,
>>> +                    ==, RISCV_IOMMU_CQCSR_CQON);
>>> +}
>>> +
>>> +static void riscv_iommu_sys_trigger_cq_irq(QTestState *qts)
>>> +{
>>> +    uint32_t cqcsr;
>>> +
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 1);
>>> +    cqcsr = qtest_readl(qts,
>>> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
>>> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL,
>>> +                    ==, RISCV_IOMMU_CQCSR_CMD_ILL);
>>> +}
>>> +
>>> +static void riscv_iommu_sys_rearm_cq_irq(QTestState *qts)
>>> +{
>>> +    uint32_t cqcsr;
>>> +
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
>>> +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
>>> +                 RISCV_IOMMU_CQCSR_CMD_ILL);
>>> +    cqcsr = qtest_readl(qts,
>>> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
>>> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL, ==, 0);
>>> +
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_IPSR,
>>> +                 RISCV_IOMMU_IPSR_CIP);
>>> +    g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE +
>>> +                               RISCV_IOMMU_REG_IPSR) &
>> RISCV_IOMMU_IPSR_CIP,
>>> +                    ==, 0);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_unmasked(void)
>>> +{
>>> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA0, false);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
>>> +                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_masked(void)
>>> +{
>>> +    QGenericPCIBus gbus;
>>> +    QPCIBar sink_bar;
>>> +    QPCIDevice *sink;
>>> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
>>> +    uint64_t sink_target;
>>> +    uint32_t sink_data;
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
>>> +                                         &sink_target, &sink_data);
>>> +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +
>>> +    riscv_iommu_sys_rearm_cq_irq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 1);
>>> +
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 1);
>>> +    g_free(sink);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_config_update(void)
>>> +{
>>> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +
>>> +    /* Updating a masked entry must not release the deferred message. */
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET1,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA1, true);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==,
>> 0);
>>> +
>>> +    /* Release uses the current address and data, rather than a
>> snapshot. */
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
>>> +                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==,
>> 0);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_vector_isolation(void)
>>> +{
>>> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
>>> +    riscv_iommu_sys_program_msi(qts, 1, RISCV_IOMMU_SYS_MSI_TARGET1,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==,
>> 0);
>>> +
>>> +    riscv_iommu_sys_rearm_cq_irq(qts);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, 1);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
>>> +                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
>>> +
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
>>> +                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_wsi_switch(const void *opaque)
>>> +{
>>> +    bool unmask_in_wsi = GPOINTER_TO_INT(opaque);
>>> +    QGenericPCIBus gbus;
>>> +    QPCIBar sink_bar;
>>> +    QPCIDevice *sink;
>>> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
>>> +    uint64_t sink_target;
>>> +    uint32_t sink_data;
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    g_assert_cmpuint((qtest_readq(qts, VIRT_RISCV_IOMMU_BASE +
>>> +                                 RISCV_IOMMU_REG_CAP) &
>>> +                      RISCV_IOMMU_CAP_IGS) >> 28,
>>> +                     ==, RISCV_IOMMU_CAP_IGS_BOTH);
>>> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
>>> +                                         &sink_target, &sink_data);
>>> +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +
>>> +    /* Stop the CQ before changing FCTL, preserving the deferred
>> message. */
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
>>> +    riscv_iommu_sys_set_wsi(qts, true);
>>> +    if (unmask_in_wsi) {
>>> +        riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    }
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +
>>> +    riscv_iommu_sys_set_wsi(qts, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>>> +                     ==, unmask_in_wsi ? 1 : 0);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 1);
>>> +
>>> +    /* Repeated mode changes and unmask writes must not replay the MSI.
>> */
>>> +    riscv_iommu_sys_set_wsi(qts, true);
>>> +    riscv_iommu_sys_set_wsi(qts, false);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 1);
>>> +    g_free(sink);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_wsi_delivery(void)
>>> +{
>>> +    const unsigned vector = 1;
>>> +    const unsigned irq = RISCV_IOMMU_SYS_IRQ_BASE + vector;
>>> +    const uint32_t irq_bit = 1U << (irq % 32);
>>> +    const unsigned irq_word = (irq / 32) * 4;
>>> +    QGenericPCIBus gbus;
>>> +    QPCIBar sink_bar;
>>> +    QPCIDevice *sink;
>>> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
>>> +    uint64_t sink_target;
>>> +    uint32_t sink_data;
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
>>> +                                         &sink_target, &sink_data);
>>> +    riscv_iommu_sys_set_wsi(qts, true);
>>> +    /* The MSI vector mask must not suppress delivery through the wire.
>> */
>>> +    riscv_iommu_sys_program_msi(qts, vector, sink_target, sink_data,
>> true);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC,
>> vector);
>>> +
>>> +    qtest_writel(qts, RISCV_PLIC_BASE + irq * 4, 1);
>>> +    qtest_writel(qts, RISCV_PLIC_ENABLE + irq_word, irq_bit);
>>> +    qtest_writel(qts, RISCV_PLIC_THRESHOLD, 0);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
>> ==, 0);
>>> +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, 0);
>>> +
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    /* The PLIC latches the pulse after the device's wire returns low.
>> */
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
>>> +                    ==, irq_bit);
>>> +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, irq);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
>> ==, 0);
>>> +    qtest_writel(qts, RISCV_PLIC_CLAIM, irq);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +
>>> +    /* A WSI event must not become a deferred MSI after switching
>> modes. */
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
>>> +    riscv_iommu_sys_set_wsi(qts, false);
>>> +    riscv_iommu_sys_set_mask(qts, vector, false);
>>> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
>> ==, 0);
>>> +    g_free(sink);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_wsi_reset(void)
>>> +{
>>> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
>>> +    riscv_iommu_sys_set_wsi(qts, true);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +
>>> +    qtest_system_reset(qts);
>>> +    /* Reprogram valid MSI state without depending on table reset
>> values. */
>>> +    riscv_iommu_sys_set_wsi(qts, true);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
>>> +    riscv_iommu_sys_set_wsi(qts, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    riscv_iommu_sys_set_mask(qts, 0, true);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>> +static void test_riscv_iommu_sys_msi_reset(void)
>>> +{
>>> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
>>> +
>>> +    if (!qts) {
>>> +        return;
>>> +    }
>>> +
>>> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
>>> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
>>> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
>>> +    riscv_iommu_sys_setup_cq(qts);
>>> +    riscv_iommu_sys_trigger_cq_irq(qts);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +
>>> +    qtest_system_reset(qts);
>>> +    riscv_iommu_sys_set_mask(qts, 0, false);
>>> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==,
>> 0);
>>> +    qtest_quit(qts);
>>> +}
>>> +
>>>    int main(int argc, char **argv)
>>>    {
>>>        g_test_init(&argc, &argv, NULL);
>>> @@ -275,5 +716,25 @@ int main(int argc, char **argv)
>>>                       test_riscv_iommu_g_stage_only);
>>>        qtest_add_func("/iommu-testdev/translation/ns-nested",
>>>                       test_riscv_iommu_nested);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/unmasked",
>>> +                   test_riscv_iommu_sys_msi_unmasked);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/masked",
>>> +                   test_riscv_iommu_sys_msi_masked);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/config-update",
>>> +                   test_riscv_iommu_sys_msi_config_update);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/vector-isolation",
>>> +                   test_riscv_iommu_sys_msi_vector_isolation);
>>> +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-unmasked",
>>> +                        GINT_TO_POINTER(true),
>>> +                        test_riscv_iommu_sys_msi_wsi_switch);
>>> +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-masked",
>>> +                        GINT_TO_POINTER(false),
>>> +                        test_riscv_iommu_sys_msi_wsi_switch);
>>> +    qtest_add_func("/riscv-iommu-sys/wsi/delivery",
>>> +                   test_riscv_iommu_sys_wsi_delivery);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/wsi-reset",
>>> +                   test_riscv_iommu_sys_msi_wsi_reset);
>>> +    qtest_add_func("/riscv-iommu-sys/msi/reset",
>>> +                   test_riscv_iommu_sys_msi_reset);
>>>        return g_test_run();
>>>    }
>>
>>
> 


