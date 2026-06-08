Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC10CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYu4-0005sB-FK; Mon, 08 Jun 2026 08:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWYtj-0005rd-F9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:16:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWYtf-0004xN-Fx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:16:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658BBFZi3417303
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 12:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7DvVeShl7xjUO/MtaA0R2/qznezTekNxJDlFS+AqW/w=; b=j3v/jGsjc42w7cMq
 hLcKeXou0AlpYaFLtmKxrwG9e4PJY9N6mJuSDBEzeJJ1o/fiuHDFkmxx19kE0ESP
 ZfUr88HQz4rLebVB6jK//MRHIc+3/44AGXOa8i668h9HZHsEW5ekJu6FdpiyQuPk
 qea5KlHIrQjA7hfJlje4MtF0XczXyUc7v7RzCCItfKctT+7No69mLY2yHO9wLrHi
 1fdFE840pT/EDcoMmopkA1IyT+LmWq6+YKsFExfa2AayrC0T8Hpvf0rt7DNbJYSC
 vhAHngVD+AQ+/3DCZ8nYJk7HzWBKPU+uxJlKpAeg08uWlh9C+EeH5m32jGCZq2Bt
 Cr7rZQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptghny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:15:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5178bcab15bso89059571cf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780920959; x=1781525759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DvVeShl7xjUO/MtaA0R2/qznezTekNxJDlFS+AqW/w=;
 b=LSPUk4qyWOxgxNLxjYjN5Bo+hPSzwOl4f6f4wZHo20gCJ18PqspVoFaG0eTenAayGo
 vQch616PVIK1bAG1sGVsLKm2CORGuIXwZKIe0EazvkXagQme7JifnWcB4awyx4Eg1tSZ
 LqZddSN8Q3oxL/riVnMvMfqqBM1ncaglJMZcfx833/2GiQyfo4cAbCRfqJ8ZzHnR18tz
 BmEAQmXBp3ae5q9QXnZOtr6SmniFvmLMJ4QaWmhg3qIc5PKQ1aClJmw0Hz9DRIf1e1UN
 LCnJmrFDvVfraP99PAC5Gbt2xnq939xr66gkESvAOssWMdSkBvFUDLGoDGw9Miopo2Hm
 Ch7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780920959; x=1781525759;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DvVeShl7xjUO/MtaA0R2/qznezTekNxJDlFS+AqW/w=;
 b=IHGodX+OO4NMiLVfgu8FIHI0rQ/NqqNMsoQ4TLTf8QIcYajocQ/odf4WW/0pjk8xB8
 aFfvJDSSgwzGw0oK1J5s7NKKfqB7QFIssmNCuzj+AXlWTVGBlWhZ4VfYIKNvRZnoeCC4
 rKhznTawhx+C2RXfK/+YZQ9dC5cFYnaVfO6aovsfuqN7wgRrD3Kiis2kqrVl7TRpIuwS
 04Ei7H9d/0e2PnSZXl3Lmkg9e1tPov0VGZpsWBIw52J7UrBsWxSL4xpdW4JXyllJdEpW
 9YMRQEWLSuMxP8qUNutSzyvFYWBNW3Y4abXYu3j7o5B9k6lX4K4gZvmJhOwCRLkptckJ
 wXmQ==
X-Gm-Message-State: AOJu0YwM4/RkayPJ+dKMWLKZjEa3r+FtQInZtaLEZVlLhz7NS6nKxkSv
 CkK7xurhWMy742z+FLyVyhUeT2z263VNAht792CynpgwbPiTiSkDglphf9IiYSPUMp1BICwfqTT
 nDmMY2cDauy3rmYvK7c+sz6yiCQLzsjznpQEVVkiUkqGWpLiiOz+taLfWMA==
X-Gm-Gg: Acq92OFb6yid89cVq2ucC2Gi8vCV6DmW5QwoINYMx1Q+kPcrGzq1PjDZFdA7mwwKUsQ
 c0clMVakcKGplris4TLE3yAJmQSszYYEDkSUkKB/r+jOsBxM8zcb6ZPMCYmGM8aT/aVZsqsCtk6
 WVdeeJYp3tgVP5muiseWwiEZmRD3AzlE1FfpHkQC0Nv+m0j19yo/Hsjswacr3om06kC3WbwSYiA
 vD9iR8fQGbtZUtm/wtFstR3qeCLMkipZMODNxwaM3BumLXtNEQpQXVq0BRCWeizcCsBLS80YaHn
 vjnvyhZqOO8bI2wFF2eRh6slN2g8Bwh4z6v9WI6nSYTr0Dzix4Zz53WHHPIvz+g+IbAYLdXMQp8
 VJhVWDl5uLpcn5HI0MpZH4fMQUKaQ3IBTAqu96WautrCBzgiFsShbZ5IY1zd0sWYil4hH
X-Received: by 2002:a05:622a:230f:b0:517:9d71:4155 with SMTP id
 d75a77b69052e-5179d714cf5mr190560951cf.46.1780920958744; 
 Mon, 08 Jun 2026 05:15:58 -0700 (PDT)
X-Received: by 2002:a05:622a:230f:b0:517:9d71:4155 with SMTP id
 d75a77b69052e-5179d714cf5mr190560401cf.46.1780920958276; 
 Mon, 08 Jun 2026 05:15:58 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517940762fbsm96947551cf.18.2026.06.08.05.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 05:15:57 -0700 (PDT)
Message-ID: <be7ea7b6-4e6c-4ab4-94d3-2c82f225c1ad@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:15:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@mailo.com
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
 <98b5f348-aac4-4be9-a897-95da11c19aa5@oss.qualcomm.com>
 <CAFEAcA-P4OySVHDziG59Ln7CuqLFArHjc5v8NsAQafD9HxsuyA@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA-P4OySVHDziG59Ln7CuqLFArHjc5v8NsAQafD9HxsuyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cDSD-nswJ68QqU7tCsgV97YEuSqzUpk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNSBTYWx0ZWRfX5dVSeSS5Xc5S
 iAox1XG7nprWxNqp3djp+IA4sjl/X/JGOnbmir2THyYtKC2e9+zV79svFGCcfm3WS7GV1V/bZ4P
 xXP7sHhNTFN6OZWzEv4yigXf5lILzAdI8NBlk4ZjWE5YjghYV3VbEyGWVM38PGHgsrIeYnGSLw+
 WYM3T6LDrnjVqrO8o40tYBxfaLU69iUPvwNNSI1nwlLL7cpTDRGCY8jSzag/CSVRBUvA4PecSro
 4fEVGHFJHAWD7+9OudktE9Yd5EkfMM3i3Xm6l8A6nO/Mz//Hv3eZWk4poImmkuRDAGZ8/eMZngx
 EJyOkIun62cWcGPtmZFkVvqKUObnPqo0wLNpcZL3q2Dx11EknJsBGSlGeCe1M2ZaK/L43tj5PL4
 JiXpa2LAHfwz7vRnneLNsaLxnzLJQ4OOe1yXKR0TQVkYlI+PER75OXLu8xGMmZu6dCniyotWsMJ
 1JX637qRxLQONK3rD/w==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a26b27f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=HwFc7jivAAAA:8 a=EUspDBNiAAAA:8 a=PnJWYD0x070Nr_Fov_EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-GUID: cDSD-nswJ68QqU7tCsgV97YEuSqzUpk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080115
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/8/2026 7:08 AM, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 10:47, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 6/8/2026 6:09 AM, Peter Maydell wrote:
>>> On Tue, 2 Jun 2026 at 20:09, Daniel Henrique Barboza
>>> <daniel.barboza@oss.qualcomm.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I decided to propose this change after working in a RISC-V gitlab bug
>>>> [1].  In my proposed fix [2] I had to make assumptions about
>>>> address_space_ld* error return, which is always MEMTX_DECODE_ERROR, to
>>>> identify that in that particular scenario this is a permission error.
>>>> In RISC-V (and from what I can see other archs like x86) an ACCESS_ERROR
>>>> due to mem page permission issues will fire a different fault than other
>>>> errors like page not found.
>>>>
>>>> The core logic is on memory_region_access_valid(), which already makes a
>>>> distinction between error reasons when we look at the qemu_log_mask()
>>>> errors, e.g. this is being characterized as a 'rejected':
>>>>
>>>> if (mr->ops->valid.accepts
>>>>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
>>>>           qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
>>>>                         ", size %u, region '%s', reason: rejected\n",
>>>>                         is_write ? "write" : "read",
>>>>                         addr, size, memory_region_name(mr));
>>>
>>> valid.accepts returning false isn't a  permissions error, though.
>>> It's for cases like "you tried to do a byte access to this device
>>> that requires 32-bit accesses only". Permissions errors are entirely
>>> in the MMU, and don't appear in the MemTx APIs, which are about
>>> transactions in the fabric outside the MMU. The CPU emulation
>>> catches permissions errors early before it even does the
>>> address_space_ld* call.
>>>
>>> What is the equivalent of this in the underlying hardware?
>>> The current error codes are intended to roughly match the AXI
>>> bus SLVERR and DECERR error responses (which are "we were
>>> able to pass this memory transaction to a device, but it
>>> rejected it" and "we weren't able to find the device for
>>> this memory transaction at all").
>>>
>>> The valid.accepts callback failing is always "we know the memory
>>> region but it doesn't like this", which is true for all
>>> memory_region_access_valid() failures, so maybe the problem
>>> here is that we return DECODE_ERROR for that case when
>>> we should be returning ACCESS_ERROR ?
>>
>> This is the end result I'm going for.  In patch 1 I changed memory_region_access_valid()
>> to return ACCESS_ERROR when the valid.accepts fails, keeping all the
>> other exit code as DECODE_ERROR.  The ACCESS_ERROR will then be propagated
>> as an error in target/riscv/cpu_helper.c, get_physical_address():
>>
>>           if (riscv_cpu_mxl(env) == MXL_RV32) {
>>               pte = be ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
>>                        : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>>           } else {
>>               pte = be ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
>>                        : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>>           }
>>
>>           if (res != MEMTX_OK) {
>>               return TRANSLATE_FAIL;
>>           }
>>
>> In this particular case 'res' will fail as ACCESS_ERROR if the pte does not have
>> the right permissions and we can throw the right exception.
> 
> But what's the "right exception" here? This is, I think, the code
> for "the MMU is loading the page table entry from external memory".
> I'm not clear what this has to do with permissions. Generally
> "permissions" is a concept that applies to virtual addresses, i.e.
> "does the page table for this vaddr say we can access it?", and there's
> no concept of permissions for physical addresses. The exception to
> that is that you might have something like Arm's "granule protection
> table" which does apply permissions to physical accesses, so an
> in-guest-memory data structure defines what physical addresses can be
> accessed in particular ways. In QEMU we model this as effectively
> another level of page tables, so again the check happens before we
> do the address_space_ld* call. For risc-v a quick look at the architecture
> spec suggests that the Smepmp extension is a bit like this (but
> handled via registers rather than guest-memory data structures).
> 
> The other kind of check that might need to be done in the MMU before
> the load call is "is this physaddr out of range?" (e.g. CPU has
> 48 bit physaddrs and the L1 PTE specifies a physaddr for the L2 PTE
> that is outside the 48 bit range).
> 
> Do you have a reference in the architecture spec for the check that
> you're trying to implement here ?

Sure.  It's on the RISC-V Privileged ISA, chapter 12, section
12.3.2 "Virtual Address Translation Process":

https://docs.riscv.org/reference/isa/_attachments/riscv-privileged.pdf

9. If pte.a=0, or if the original memory access is a store and pte.d=0:
- If the Svade extension is implemented, stop and raise a page-fault
   exception corresponding to the original access type
- If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
   PMA or PMP check, raise an access-fault exception corresponding to
   the original access type.

At this moment we're throwing a page-fault exception for both cases.  We
want the second case to throw an access-fault exception.  PMA stands for
"Physical Memory Access", i.e. the read/write/execute bits of the PTE.
PMP is an optional physical-memory protection scheme.  Both are related
to a PTE permission to be read/write/executed, regardless of other
failures like address misaligned/wrong operation size.


Thanks,
Daniel

> 
> I would be a bit surprised if the riscv architecture mandated different
> MMU errors for "page table entry load failed because the physaddr is not
> pointing at any device" vs "page table entry load failed because the
> physaddr points at a device and the device rejected it", because it's
> really up to the bus specification how clearly it distinguishes these
> various kinds of external abort (or even whether it distinguishes them
> synchronously vs asynchronously, given the existence of caches), and
> usually architecture specifications try not to impose too much on
> the implementation.
> 
> thanks
> -- PMM


