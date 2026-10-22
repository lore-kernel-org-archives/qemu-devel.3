Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB9606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctNUXwK9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=alyGe/k9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtCv-0004cK-7w; Thu, 22 Oct 2026 09:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJtCc-0004T0-Ut
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:51:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJtCa-0005fs-9c
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:51:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA0BTu2918772
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F6ugSkrTyB4VSLvZzycjUH3/bjtPy5sFe4cSV07XyOI=; b=ctNUXwK9dUQykuMi
 zzVDPZWCs2+3sCHDz0mlmM0Ii4dzYI/eSjW+910dMOgLr0e0Ut1ZSlGSsihSpE0W
 ISW8b6nP+iV6hBOxLTh0GM0PUmnTsJPgjLj31GYh6SF7zVDeA40K6i5j6QCyXb8b
 kPhZVtRgaEhW4fxdBhD4swg+cUiz0C41e+HCnZYRR/A/8rKcsYSIZVhGgiSXtTAf
 GGXhjepop7GneteJvopARze9jNpJQIDaOBg7bLvDtsvdG8rr7j8SZoCp1ifDBJkf
 cQ++HtnMeghm3XEOVMtZUBD8tYtrNFBA7qoK4Do94Ja98z5GuWmLKVBhPeHtQhe1
 fPO7Fg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93absg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:51:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so213613285a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792677085; x=1793281885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F6ugSkrTyB4VSLvZzycjUH3/bjtPy5sFe4cSV07XyOI=;
 b=alyGe/k9XYqcXw732uhYBk7nrv9JtPLoMJBUxPJFP+u7/9ON9EscWWUjAgWEUt3OGh
 avx5KsZv6eELLHPCrTGh6i/xlsRf5cwRlGdN3SNn4UpO2s7e8A4JLScvp1BAw/j6LRiA
 sZqPOKXWjWpyqVrzH+xpKgXnrC1BxuWe7yvwT45M5WDNqam+ps0er4DQX+aNVrufQC8e
 MpnBJKa0uzhSZfj8P1kE1P4nTpuMDgRuCLvJfTA3XNcXcwycWLf1zL8g5yMH+FxLH2lN
 pq2qkV6gY31CAhudM7cwmVEF0s32JG84jH+qXG5OxhOFv28oamfpV/VT0IPW78jrMmHP
 RajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677085; x=1793281885;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F6ugSkrTyB4VSLvZzycjUH3/bjtPy5sFe4cSV07XyOI=;
 b=S4HfHSFq9uG68Pscv/e0FUnlMfaPSvl+G6iC2MBD8EDugyOCZPDjLe0oKTxgUXjdxQ
 MifxJew4FO5q9dh3cxEpXrhh8K+Eoymg6tU+GCzjv/v/b1QKrm45dMa6QRQA0xdCz+Zb
 nXsz2IjkVlOsW21QibbVL/GxJ97wnk/wI2QaVX1UCZP/cfucqlerjCGkKVcgGjE4fIWD
 dKCeTOlB3+64OZ4npJCBuyEj2x3f45u+1bkLty7lNUrALqnS5RFf6prU5KF3juip42kw
 XGZpJRq8x0xBwQ20BQw24fbEGvdgWb+tAMFnx7Yn5uiylsplIPeIXzMw7t8/lfSMf2er
 M3aA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxufKthF7JM2nobXwIN2ya2DAdOtuDM/J52bjtUiB9hURlDdOsufDZ0NQRJfqIEfB6gUkuT4aWcPzWt@nongnu.org
X-Gm-Message-State: AFq9FYIoF5ETst5F6LAJTWO4fEp55z1opVb7Ak/yWNVERSBt9YCjB5Ba
 zISLbO9hWtdTFGcunmccCGCV7pxkDQBbcuJgi/VauXp0wuqHmZ3S7sMyqyVxs9UHo5ii/DLe9aa
 6E9phsYVd9He9MzL0kSEisS/6kSPqmy7Cz/BbpHe4TMANeXVM6BLyspo4hg==
X-Gm-Gg: AYBFou12lTgSsw/SBHRZljT49E+IMT+xGzA6JF+8E374tTk1oGtxMw+9N8bzWolLZnp
 URbyxWciw9Jpvq/cGuFccK4qayoxNiBULwmHds7wxfa1sa97LnZHkWjgOhGPdrLktXrWSSCWzir
 GlOA/UG5TiaG6H42ewIgLSMak9v/GM3zTwcSBOD4aCN0QQATemXwQcStc7ozzcWtOSR/anttnvN
 BN+SUrjpwEGUW8uQJPeumzzjvloBZ9g53goqkMJO1tNJLo950YuWRgu/iJQiNAEnK6LxPKZ97i8
 KaF9SBdWupixuCbqv1bZrmSEhS5xFSj40Bb5VeAElc+uSyfE37KL+HSoEuupAHY2kHNdMVixn5K
 dr9UgjSnkyy4O2+QHJWJIRqDg4NEOVzBX5FKzf+gPfw==
X-Received: by 2002:a05:620a:1a26:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93f62720fabmr389328685a.17.1792677085247; 
 Thu, 22 Oct 2026 06:51:25 -0700 (PDT)
X-Received: by 2002:a05:620a:1a26:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93f62720fabmr389325185a.17.1792677084731; 
 Thu, 22 Oct 2026 06:51:24 -0700 (PDT)
Received: from [10.240.148.132] (69.170.88.92.rev.sfr.net. [92.88.170.69])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b403132037sm1658893a12.26.2026.10.22.06.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 06:51:24 -0700 (PDT)
Message-ID: <1d630026-0e0c-4803-9a06-71a6ed54905d@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:51:21 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: preferred tlb_fill mechanism for non-legacy code?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA-E1Kuvegq2PeafG0of=TTRJfGX_yvbV-UibJ0tNhUM6Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-E1Kuvegq2PeafG0of=TTRJfGX_yvbV-UibJ0tNhUM6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ada14de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uEwMM6BgJgmBAUn+b7zTnA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Tx3r-06fbKo-xehpURsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: qKgIp8OGvK70ght_n8EbIHWGRUiomnPS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1NSBTYWx0ZWRfX3xyCSp/OUQ8I
 JWaVOInQcaRw+HxTnQxPAw2knDZoMBQgtgCryOKwDchJPE4UfFjyiBMDpVMVPT0igtPvj7+ogv5
 Hgt2UOC9RYy6WP3tEWw5jLk5izYsw6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1NSBTYWx0ZWRfX/w1C0wY3+Rm0
 /Hl1jqhAmvJBu0McPOOcfeIn8ZWKsyiXpkIhEU/s+xT8oXNgqmnOYp3NNbphrArFvbU8g8U9Vh3
 eElr8DVTjZ2nXsgW+ZYhlNtVB9vaLXBYkY/OoWeahWfkqWOGF4il47OdPWmMD0Afd+atvh3zwuX
 6RLhLgOgjVo0Y+h8Swul0VhOS3TWprtcpp/A1a3CMsxqZazT/S1gMdAc/+jSL0LCMCWQE7ev0yx
 0c8lsiM3mVbjy8CbHNIqvSNcRslCpKfBpoavdy0/gpmZkR42LKwfHkfCklahG0a2/lfi91cmxIY
 LJisRDvX6KE00/4eQNpKSjh4NcQzN0pvih4UitSJJMBYIcZB7KgrEFWk9hooOoi+h0w9gJvO/AV
 b3C3mawFUnYuKUqTfFQqlB4JXWgcjMSsbIEfJmXSIlWWu98ixzUcyLhzfJj+KY0FOdaSy93PFif
 MEyLzjZFvAtodhs7eBA==
X-Proofpoint-GUID: qKgIp8OGvK70ght_n8EbIHWGRUiomnPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 22/10/26 15:21, Peter Maydell wrote:
> Currently we provide multiple different ways that targets can implement
> the basic "deal with a softmmu TLB miss" functionality:
> 
> (1) Implement TCGCPUOps::tlb_fill_align, which passes an argument
>      CPUTLBEntryFull *out which the target code must fill in with the
>      info about the TLB entry to add
> (2) Implement TCGCPUOps::tlb_fill, and in your implementation call
>      tlb_set_page_full, passing it a CPUTLBEntryFull *full with the
>      info about the TLB entry
> (3) Like 2, but call tlb_set_page_with_attrs(), which is a trivial
>      wrapper round tlb_set_page_full()
> (4) Like 2, but call tlb_set_page(), which is a trivial wrapper
>      round tlb_set_page_attrs()
> 
> Currently Arm and hppa do (1). sparc does (2). i386 and microblaze
> do (3). Other targets all do (4).
> 
> If we wanted to try to reduce the number of ways we're providing
> to do this, what is our preferred destination?

IMHO (1), for all targets. I'd like our APIs to take MemOp and
MemTxAttrs, and (1) already does: MemOp as input, MemTxAttrs as
output in CPUTLBEntryFull::attrs, along with tlb_fill_flags.

(2) is like how ARM handle TLB_CHECK_ALIGNED, but for SPARC
TLB_BSWAP, via out->tlb_fill_flags.

(3) is out->attrs.

> Moving i386 and
> microblaze from tlb_set_page_with_attrs() to tlb_set_page_full()
> would be easy, for instance, but should we move them directly to
> tlb_fill_align instead? Or is the idea that you only implement
> tlb_fill_align if you need to care about the priority of alignment
> vs other faults, and implementing tlb_fill is fine if you're OK
> with the default "check alignment fault before page fault" ?

Add a core "alignment before paging" check and convert to
tlb_fill_align()?

> (Updating all the "type (4)" architectures might not be worth
> the effort, but I feel like we could at least rationalize the
> type (3) cases and maybe type (2).)

Then (4) is the last user of "legacy" TCGCPUOps::tlb_fill. Conversion
to (1) seems mechanical and can be done slowly one target at a time
to finish the whole API cleanup.

Anyhow let's see what Richard / Paolo rather ;)

Regards,

Phil.

