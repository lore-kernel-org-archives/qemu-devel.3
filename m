Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F1CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRs6-0006YA-Lt; Wed, 24 Jun 2026 13:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcRs0-0006Xp-8G
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:58:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcRrx-0007rk-VG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:58:39 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OHiuq34057349
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oKQbLkiJR/LkK0dSvpibFxs/XrBkPxdyEtQWUJTtCEQ=; b=VrHyrqrimrwmQu0y
 /yPpHTSI9hM6MMpJyseueAPHokN9BdSg4WANph0SoLqzIuYpWRI7xRWFd3Hcafv/
 bVoOB/QwlEIyoy/zbpx+dZnhRgLZB9QFZsmiHpV0wLvyimmUjWmE0TSjg62FMaIt
 yMe9QqB8F7DmhQuaQNx9igKpmaLr7MKIGvmSEE4QY19cJAJtPQnx+SpHxSu33+P5
 gr898qtkohqt/miqrKNQZpk+m6LK4YnANfsFjcel/7Lh5PZzZw9M79bdbZHYCmsT
 WjLT/+TcTNGGDjm8EAql/Xnp2oqKQE6Ey8acpR6mijbtLAVV0Q94w+tcLmqIwIxa
 FxESYg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d5g1vx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 17:58:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1416911eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782323911; x=1782928711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oKQbLkiJR/LkK0dSvpibFxs/XrBkPxdyEtQWUJTtCEQ=;
 b=MEwRzLOHCAVh+d85Hy0plDb4NptU89osdx4lPH9kMZjD65Wl7IatP+RPJPSOmZMela
 EWEjuKkYEVWVnEM60ed5OoaYiVD3NptlhdZ4v3+kqLSQJml1zpyS3VIWdNOw64A25XPv
 XBMznakqxOiv+4VTkQDN9wV9Pu7HC/wmue1dfJogWxf598szOlAN3wWlj8SdVCf0Kznv
 3F0Oe05Lm/ZmxnxCIeLi5JBaLgii1mLvwAswY0Xa2SYC0dhsoWA48ryTsIY71ogwJawF
 mWgiwTecapi0Lr9s+VlPcgRFVgL7o0OKgQcm1QsIKVFmfplUPrRrEvLj0KTC7QpogWSj
 7rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323911; x=1782928711;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKQbLkiJR/LkK0dSvpibFxs/XrBkPxdyEtQWUJTtCEQ=;
 b=QdHlTKf+pd5UPi43nChUy5pACd61dKevvZDZowmZ+4NYrHGO5QFFHxQSeLKYFEtIka
 WkV4TSOmm4yhXUBfbQsrRczonnpIm0kVr3EdPUmhs4WvidDeWju2E3jD17Wy+VFiNqSU
 ikalVlrq0tO+ty07l6rdLBL6+dYnkJX0+DutdKURJSgZDtbEM748oz2dv7qxGP06EkJE
 fVFVOGq+qJoMuz2RY+ELVfC3I0+NnS8zBpnk53bnzHtfTYJtq94hXtTBPL9AothPvMmG
 zBQN29qpiDg7QLZDS1SYs8s3pzzSER+5S6s3duA5yeWTCefzZLOfPkuGpo4aJyqYpnXc
 EAAA==
X-Gm-Message-State: AOJu0YxZel4gxguqYvDYz83Rm/O7YtKj+px1/ywaSe+8RR8H/9C2kI5I
 b+M9eBiBWeWeujenXYHdJptLKPSQ4junO0jVEG4y4By5JxQZA/sJzGzxc+N+wJoAvUUa/+mBSbj
 /S4EkV9NbL0VZDIrSjqip8qoBHMYcYBBazQpC8q8TgBy8YrIuxvLEKGvSDg==
X-Gm-Gg: AfdE7clrcLc125PToaJs640aFRzK+L9kNSzaROaVAsxsZzgitnMa2gd3t15Rdmzgn4e
 kUHLSZC5iYJQZXug+uLw/0EvyGyLPeeqgmVdYacKSvv1cp/+sKszp4QvWnAOsuaZfm/OH48eRQe
 68yXlYG/RdXqJ5jz60ZAqxa7dUxGB/VBn1iyoNecKPSnpXtRO6czAdmUZyvVbfDGUa7AMe87p1m
 G8vb7VikHuafdMrD7lr9KB8nkCapYimLIYJ5A8pf0iVCDIz+6ovW8s+Dxgla79MfYfKtnDJx+JA
 yoo2FfrOyI1HSnw+5LScLMLc8p03s0AytyC8X45BEMA0WkfaU36L5xzsHRfx6Wq9nN9ilpcoU3I
 oBd8VMxSyTm8UPQ6EKeoCc/3XFS23kpran9uxsCLfsBkB
X-Received: by 2002:a05:7300:ca7:b0:30b:8893:8788 with SMTP id
 5a478bee46e88-30c58ae0f2fmr7587538eec.13.1782323911121; 
 Wed, 24 Jun 2026 10:58:31 -0700 (PDT)
X-Received: by 2002:a05:7300:ca7:b0:30b:8893:8788 with SMTP id
 5a478bee46e88-30c58ae0f2fmr7587500eec.13.1782323910403; 
 Wed, 24 Jun 2026 10:58:30 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm763385eec.8.2026.06.24.10.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:58:29 -0700 (PDT)
Message-ID: <027db807-7aa7-469e-8cf6-5985b64f6054@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:58:26 -0300
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
 <be7ea7b6-4e6c-4ab4-94d3-2c82f225c1ad@oss.qualcomm.com>
 <CAFEAcA8OdLtjbBRK9QWjwy0mCFPbYsA2Yztp4o6C+jam7aonNQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8OdLtjbBRK9QWjwy0mCFPbYsA2Yztp4o6C+jam7aonNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdMMLDfi c=1 sm=1 tr=0 ts=6a3c1ac8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=HwFc7jivAAAA:8 a=EUspDBNiAAAA:8 a=tr7wYxBkRpXcleRFeMUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: lQzNNDpPJuteBZxXB4g1McdICkuMaVcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE1MCBTYWx0ZWRfXwcaE2lGhO0JO
 Xjk4IjJF5HjJ9Ko4yfyp5IQQ3FBBQyWoboTZ/eAAysAG8egEAnhgeJDFRt+/aFpbkt0Px6dYlaU
 eBfe3uUbNnfYZoDpGDdvqxx//Pm3dTFmVcG4Q5kkKBkgcUvAe17OppG0RLxgKumXhC3LxJf4Dm9
 jMyv5QbuOz+ooJmUq7ncHiMDYLXW+GUYjhMr2mgvw1wXBOVKbkI8y3BH5/h1e3OJNK+dPJxHYS6
 +GbCcPL4Bkvpzr1MYf8VcpS4UuBOWw7T98F2AC5C/+QznskpVzZPWxX352pHAh90+QVhVlRaNRw
 xxWe239XtBicePvZ9k3VNlUGPYHOnwnx4szAgq9/YHaDNUd/HH8ITl4HTp5Ad7zJCBjE+w4tsSO
 UlgO6hHw03Er9UpbqqI7+sMdCeM7JA==
X-Proofpoint-GUID: lQzNNDpPJuteBZxXB4g1McdICkuMaVcL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE1MCBTYWx0ZWRfXwR4KMOtC+0RS
 KaZb+/phEdvMNh1vWQNCz3ElDsEPy5qif5Nn2XcCYxvcE/+g0nglrVo4/IiijLFOyacZH8s4dDp
 cO9FPsYXfYOwxj3O2Yd6V2jiU1f62g0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240150
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

Hi Peter,

On 6/8/2026 9:52 AM, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 13:16, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>> On 6/8/2026 7:08 AM, Peter Maydell wrote:
>>> On Mon, 8 Jun 2026 at 10:47, Daniel Henrique Barboza
>>> <daniel.barboza@oss.qualcomm.com> wrote:
>>> Do you have a reference in the architecture spec for the check that
>>> you're trying to implement here ?
>>
>> Sure.  It's on the RISC-V Privileged ISA, chapter 12, section
>> 12.3.2 "Virtual Address Translation Process":
>>
>> https://docs.riscv.org/reference/isa/_attachments/riscv-privileged.pdf
>>
>> 9. If pte.a=0, or if the original memory access is a store and pte.d=0:
>> - If the Svade extension is implemented, stop and raise a page-fault
>>     exception corresponding to the original access type
>> - If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
>>     PMA or PMP check, raise an access-fault exception corresponding to
>>     the original access type.
>>
>> At this moment we're throwing a page-fault exception for both cases.  We
>> want the second case to throw an access-fault exception.  PMA stands for
>> "Physical Memory Access", i.e. the read/write/execute bits of the PTE.
>> PMP is an optional physical-memory protection scheme.  Both are related
>> to a PTE permission to be read/write/executed, regardless of other
>> failures like address misaligned/wrong operation size.
> 
> Are you sure that's what a PMA check is ? Section 3.6 seems to me
> to be describing something else, where the hardware uses some
> combination of hardwired info and unspecified platform-specific
> registers to determine whether the physical address is to somewhere
> that supports particular access widths, atomic insns, cacheability,
> and ability to read, write or exec.
> 
> I can't see where in the spec it defines what's supposed to happen
> if the page-table-entry read fails because it's to an invalid
> physical address, so presumably that's just a subtype of "failed
> a PMA check". (3.6.1 has a note that supports that reading, where
> it says that previous spec versions had a "vacant region" concept,
> presumably corresponding to our "decode error", but that these are
> now treated as I/O regions that have none of r/w/x access permissions.)

Sorry taking this long to answer.  Yeah, "PMA check" as far as the RISC-V
seems to understand is a combination of a lot of things that includes not
just read/write/exec permissions but also alignment, atomicity, caching
and so on.

All memory accesses failures we're able to detect in the code, aside from the
usual "address not found" error that we can interpret safely as an page fault
(... I think ...), can be considered a PMA error.  Which is something that we're
*not* doing at this moment, and this might be an alternative for what I'm
proposing here.

It might come to what you said below: an extra layer of checks that we would
call "PMA".  I'll have to think more about it ...


Cheers,
Daniel


> 
> In that case the riscv page table walk code should:
>   - fail with page-fault exception for "pte.a field is zero"
>     (and do not attempt a load from physaddr 0)
>   - otherwise, do the load, and report any kind of failure of the
>     load as an access-fault exception
> 
> Do you implement emulation of these platform-specific PMA registers?
> If so, those sound to me like they should be some extra level of
> checks that your page-table-walk code does before it does the
> real physical-address load, similar to how you do the PMP checks.
> It doesn't sound to me quite the same as the return value from
> QEMU's address_space_ld* functions, which is more the case of
> "the guest misconfigured the PMA registers and did an access
> that passed the PMA checks but which the actual device rejected".
> 
> thanks
> -- PMM


