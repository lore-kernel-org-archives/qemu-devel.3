Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D4606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RECQqRwv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XGzVxrqj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQQq-0000dE-VX; Fri, 06 Nov 2026 15:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPQQj-0000TX-TN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:20:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xPQQh-0006eY-Av
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:20:57 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JLIo63254857
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 20:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aXBni1gmfYSsAQGyl8W0hOLEjjM986k5Se03Y+5HAE0=; b=RECQqRwvUuzBUt/e
 XpsFH3RYwbO5JDwNufhMNrBfm+FGy0v7Y8s4jcZ52RBFG1CnrUkWrYWSUzCVlObC
 eri3EU5C2VU9OqHs6UrC6CeSlw0U2RitX3Ri9NW1Jb8l94SVZ8vrL0fIMKln2mUN
 5sojOhD8zJHH3Xa9i9KbqK5rKyr5XNdrycGc8cRzwjsiUVKLazETGy+UyR4n84yT
 jg7KrXo1wJ/owmtGsGLM0uuWdD2Ni63/9jYeZ3QPRw+ifnnRogY5kM/FB9KvOuUw
 I3EPhcBAFSCAIRPcmRd6P7PtPZUMKGemGaYPUhgyQxj19qQk7oJb2ivJ+WG+mAIt
 +xSx2w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqr6x3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 20:20:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-542fc619afaso12934351cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793996447; x=1794601247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aXBni1gmfYSsAQGyl8W0hOLEjjM986k5Se03Y+5HAE0=;
 b=XGzVxrqjf13cgcRX6NJhUYPtT571tbVRrt96ffb7A+r+fYXJ3k4fZh0QPATjJiNjcb
 aaD+kKHR0QtpkCu3kZaMtwmm2nio5rIZ+WkfyHmeXDIuF+QmlBP6vX60WyTJWZsQkX1Z
 b1KeDlFXf32EhzbNoLSRjexx2WRa9x01z0ZHrlSudLuagJ2gUIK0yKqfNHMg9KFDcG/7
 lV6NSpaC8L+gEPOWxV0ZzSNHHh3UwS0wpNiDohylWrkg3YppQ18IKWwFVa4sLG4DcXKi
 hB2R5Jtqa9rCK54USprdBz6UgG2WMozD+nlSJb53522CRb8AO9JtXl8zAG32GMgSaBi6
 vAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996447; x=1794601247;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aXBni1gmfYSsAQGyl8W0hOLEjjM986k5Se03Y+5HAE0=;
 b=Ks6vtqBbXTPIIdBqIhSw+FCat3J/AbhCqr9xrL83iv+sR+tfvtdTnLEbdvP7Jz8bRy
 dh7RkwqLhce20O+fVuyDs4acXsZU0cnh2G2VLjKvxC09PsZv3up754xPv6xbm5HqN5dI
 Emq7t2AH3lUAU6gn/BCOYShkZOpkvTir2JfxozLS+AUuwCcxIZT8VGkQwgZE/x3Uh2H9
 +1U8UBHHjrBjhXywrUXmUN5/Pmes4DQ9beHIN/+fKEdkMyQlKDEbeZ5Pcy7S3bIw+osW
 RO6THgnusy9RaiqN2vjcsJOPY8KGbzGy5N4WPY9sHTZhQ0OcfjJBv01zJYfRdHFJ3pwq
 Cnnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeaDwpDGlbOfGkczOCFi48sgQzjpcgX/86gAGCyjxouzA13kwOY+knXPil+NJhSkF4W8QmpBJe09hE@nongnu.org
X-Gm-Message-State: APuU4Z/H/Ulqo6OwaknPn2zRGWgdENO3aa0xHNzM4jIbQ8r7kp5XhfIL
 rGdKea7bCeWh4kjTnNj77Z5fwcoLi9hwsDmIRNbCWURoUyzVPnWvJXGQjrj80kIxSvCvBJttMvK
 8fYyld13ClVF8s7GxfvyzjzJhxjmGYNF7bQakx92mmk3O7YKSYnjjIUOW7Bfj4TFoJg==
X-Gm-Gg: AYBFou35b5w44d5wuNlEVkFdI/0ogFbzDzj/j4hTAK2qqnmXv9tne9dm8Ya0OgWRah9
 ChHmyE9r9iWvxOWRxr1O5l4e+nDZFQnfCUembNpWNMrTL7Vmp6gLeYYyfW41n2orTjHcyR3IvvK
 sIMZcuvGwoZwNnX1LltEaRcq8ntSignsywEHge7PPzCnutooUfdC6HVVYbdwjqd7IZB211k+JHu
 losWGPTqT9YcQmYPd524zjZSWc+Om6d0ZF+L96MHf5keQqqkaIdHO8bTnGu9Wgmo1GC9nq82eq5
 htHi5WKe6nEjGekPaz7/7h0JqWExJImyZFsEJcYZXipGLrWDsTvEIiRDh7N7nAKsXEM8IBK5GjU
 u3PWHl4YWPXC+o1qcKBLXVbIqf9Upq/EnFytcLjm58II4wTOTc9XO09nbfANaB/QKuoe+rTxfhW
 i6dUf9/GgR
X-Received: by 2002:a05:622a:1920:b0:533:8a63:1c52 with SMTP id
 d75a77b69052e-54e15267f5cmr57896891cf.49.1793996446585; 
 Fri, 06 Nov 2026 12:20:46 -0800 (PST)
X-Received: by 2002:a05:622a:1920:b0:533:8a63:1c52 with SMTP id
 d75a77b69052e-54e15267f5cmr57896451cf.49.1793996445806; 
 Fri, 06 Nov 2026 12:20:45 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54f86ce2b24sm2978751cf.3.2026.11.06.12.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 12:20:45 -0800 (PST)
Message-ID: <e80b7ca5-39b4-424d-be45-44ade42af3da@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 17:20:41 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] target/riscv: Add support for RISC-V P extension
To: MOLLY CHEN <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
 <28033024-7e39-4a29-8e59-82150130954e@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <28033024-7e39-4a29-8e59-82150130954e@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1lSs4rM4O-JhC--Keu5Kj8QceyRSyMY-
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee36a0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=69wJf7TsAAAA:8 a=NEAV23lmAAAA:8 a=H5BWENXdsabB2_aDcNsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA4MSBTYWx0ZWRfX/MwaNIjCujyj
 bZvpahga43ybgh4s3tfERDAOhn/b1L21AagCfhFwCZocTF+kM9eV1AONl+kOvVSstqzXuySINuF
 TSCgT/edlfwL8chk42ot9yC3HhJt+L0=
X-Proofpoint-GUID: 1lSs4rM4O-JhC--Keu5Kj8QceyRSyMY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA4MSBTYWx0ZWRfX/VTupgsUElNG
 cDL0DucmL7DRSRBP07Pnnr06u4VhHdnsCTHBOZUwgQ54NJhZshHExZ4jJ8jcilPFY+Dmrqc4ald
 2Q7UJoMYJWMIRgdyKfCgK4dLjD5zJlWHznnRpcNwO6GA/+ei40+1iLKEGSeIv5IPmW5GDofzHNN
 dnacbAa1zWOIZqzbTGiLqFbANYQpzgAG2pPDbN3T/jyR7A8zsr3uVVqeb3BGnZk9HxXSR3Scq3U
 Mo5ge6HdhhEvnxtyEld9nDWdcMRhWi7aHm3TNQCTHSsFGGV4F3Gj5GP/+O55E1tnI025gvCf7o6
 3F6NuKx7upRRnr1eBNwnMkCpl6zAIS4vbrugGhifHAY+BW7iRXF5SsRV0imfI7YfYKYAmxRwpHz
 sCED/cZWdO1zz73aTq+9Go0VNaJFl7/AFbotNjnUcHXxXfK4XMu+iM/e2/LeC+hJ4VgaYMIQFEC
 ln7izn+k1fmmjb79Mog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Molly,

Can you please re-send the patches based with current master?  In particular
due to changes in the meson framework for tcg tests.  Basically you'll need
to change tests/tcg/riscv32/meson.build and tests/tcg/riscv64/meson.build
instead of Makefile files.

You can then incorporate any changes to update the patches to the latest spec
version available.

Thanks,
Daniel

On 10/23/2026 6:10 AM, MOLLY CHEN wrote:
> Hi all,
> 
> Gentle ping on the v3 series. Any review or feedback would be much
> appreciated.
> 
> A quick update on the P extension: the Task Group approved the
> Development Milestone on September 28, 2026, and the specification
> version has been updated to v0.6. This version includes a minor change
> to the semantics of psshlr.*, which I will incorporate into the next
> revision of this series.
> 
> In the meantime, feedback on the current v3 would be very helpful.
> 
> v3: https://lists.nongnu.org/archive/html/qemu-riscv/2026-09/msg00523.html
> 
> Thanks!
> 
> On 2026/9/16 15:07, Molly Chen wrote:
>> This series adds support for the RISC-V Packed SIMD (P) extension for
>> RV32 and RV64.
>>
>> The P extension defines packed-SIMD fixed-point operations intended for
>> DSP workloads such as multimedia and signal processing. These
>> instructions operate on packed subword elements in general-purpose
>> registers, with register-pair forms for wider operands on RV32.
>>
>> The implementation targets the V0.21 development draft of the RISC-V P
>> extension specification:
>>
>>    https://github.com/riscv/riscv-p-spec
>>
>> The local riscv-p-spec reference checkout is at commit:
>>
>>    71b78d2c8d1d41cc01a036d75dc001920b8ac22e
>>
>> P support is enabled with the experimental x-p CPU property. The series
>> includes instruction decoding and translation, helpers, extension-state
>> handling, and the specification-defined control of vxsat. The focus
>> remains functional correctness and instruction coverage; performance
>> optimization is left for future work.
>>
>> This revision adds in-tree TCG tests for RV32 and RV64 and addresses the
>> review feedback on helper reuse, register overlap, shift semantics, and
>> code readability. It also fixes additional issues found while testing,
>> including zero register-pair handling and RV64 SHLR rounding.
>>
>> Thanks to Daniel Henrique Barboza, Nutty Liu, Chao Liu, and Max Chou for
>> their reviews and suggestions.
>>
>> Changes in v3:
>>
>>    - Add descriptive commit messages explaining the purpose and behavior
>>      of the patches, and document helper macro definitions, including
>>      their interfaces and arithmetic semantics.
>>
>>    - Add RV32 and RV64 assembly tests under tests/tcg/riscv, with shared
>>      test macros and integration into the TCG test Makefiles. Cover
>>      arithmetic, shifts, multiplication, narrowing, saturation, register
>>      overlap, and zero register-pair operands. The tests are freestanding
>>      Linux-user programs and do not require a target libc. Set PSIMD_CC
>>      to a P-capable Clang to build them; the assembler options use
>>      rv32gp0p21 and rv64gp0p21. Enable previously disabled tests using the
>>      P v0.21 mnemonics and update signed saturation immediate operands.
>>
>>    - Correct register-controlled packed byte and halfword shifts to use
>>      the low five bits of rs2. Share the signed saturating/rounding shift
>>      implementation between scalar and packed forms: psshar_hs,
>>      psshar_ws, and sshar are all generated by GEN_PSIMD_VAR_SSHAR.
>>      Return zero for oversized SSHAR/SHAR right shifts, and widen
>>      rounding arithmetic before adding the rounding bit.
>>
>>    - Clamp unsigned rounding right shifts to the element width so that
>>      the source MSB still participates in rounding for oversized shifts.
>>      Apply this to PSSHLR/SSHLR and RV64 SHLR. Use a wider intermediate
>>      for SHLR to preserve the carry when rounding UINT64_MAX right by
>>      one bit, and add regression tests for these cases.
>>
>>    - Fix RV32 register-pair operations when the destination overlaps
>>      the scalar source by completing both results before writeback.
>>      Treat a zero register-pair selector as {x0, x0}, suppress both
>>      destination writes for a zero pair, and preserve vxsat side effects.
>>      Use tcg_gen_movi_i64() to initialize a zero source in narrowing
>>      translations, with a dedicated regression test.
>>
>>    - Avoid undefined behavior in helper arithmetic by using unsigned
>>      operations where wraparound is intended and wider intermediates
>>      where needed. Handle oversized left shifts explicitly and handle
>>      zero shifts in SLX/SRX without shifting by the operand width.
>>
>>    - Correct the RV32 REV encoding, reject unavailable translations
>>      instead of accepting them without an operation, and fix lane
>>      selection in PMQWACC.H and PMQRWACC.H.
>>
>>    - Reuse qemu/bitops.h extract64() for lane extraction, correct
>>      misleading helper comments, and align macro continuation characters.
>>
>> Testing:
>>
>>    The P extension TCG tests were built with LLVM/Clang 24.0.0git
>>    (/opt/llvm/bin/clang), llvm-project commit:
>>
>>      96295a1412f9afbee9d4a3c2701e83f5a529a9cc
>>
>>    Built qemu-riscv32, qemu-riscv64, qemu-system-riscv32, and
>>    qemu-system-riscv64 successfully. Both P extension TCG suites pass
>>    with the new regression cases:
>>
>>      make -C build/tests/tcg/riscv32-linux-user \
>>          PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv32
>>      make -C build/tests/tcg/riscv64-linux-user \
>>          PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv64
>>
>>    The test targets enable x-p, zmmul, zba, and zbb on the corresponding
>>    rv32 or rv64 CPU. The P-aware compiler path is configurable through
>>    PSIMD_CC.
>>
>> Changes in v2:
>>
>>    - Refactored translation and helper code using macros for common
>>      implementation patterns.
>>    - Consolidated P extension prerequisite checks in
>>      riscv_cpu_validate_p().
>>    - Removed the Zbkb dependency to match the specification.
>>    - Added the specification-defined vxsat control mechanism.
>>
>> Previous versions:
>>
>>    v2: https://lists.nongnu.org/archive/html/qemu-riscv/2026-07/msg00697.html
>>    v1: https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
>>
>> Feedback on the implementation and tests would be appreciated.
>>
>> Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
>> Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
>> Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
>>
>> Molly Chen (19):
>>    target/riscv: Add packed SIMD extension state
>>    target/riscv: Add packed SIMD helper framework
>>    target/riscv: Add packed SIMD arithmetic instructions
>>    target/riscv: Add packed SIMD averaging and rounding instructions
>>    target/riscv: Add packed SIMD absolute, difference, compare and mask
>>      instructions
>>    target/riscv: Add packed SIMD shift instructions
>>    target/riscv: Add packed SIMD exchange instructions
>>    target/riscv: Add packed SIMD horizontal reduction instructions
>>    target/riscv: Add packed SIMD pack, merge and count-leading
>>      instructions
>>    target/riscv: Add packed SIMD pure multiplication instructions
>>    target/riscv: Add packed SIMD multiply-accumulate instructions
>>    target/riscv: Add packed SIMD Q-format multiplication instructions
>>    target/riscv: Add packed SIMD Q-format MAC instructions
>>    target/riscv: Add packed SIMD two-way multiply-add/subtract
>>      instructions
>>    target/riscv: Add packed SIMD four-way multiply-add instructions
>>    target/riscv: Add packed SIMD load-replicate instructions
>>    target/riscv: Add packed SIMD RV32 only instructions
>>    target/riscv: Remove Zbkb dependency from P extension to align with
>>      the spec
>>    tests/tcg/riscv: Add tests for the P extension
>>
>>   target/riscv/cpu.c                          |    5 +-
>>   target/riscv/cpu.h                          |    8 +
>>   target/riscv/cpu_bits.h                     |    2 +
>>   target/riscv/helper.h                       |  529 +++
>>   target/riscv/insn32.decode                  |  830 +++++
>>   target/riscv/machine.c                      |   19 +
>>   target/riscv/tcg/csr.c                      |   39 +-
>>   target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1439 ++++++++
>>   target/riscv/tcg/meson.build                |    3 +-
>>   target/riscv/tcg/psimd_helper.c             | 3536 +++++++++++++++++++
>>   target/riscv/tcg/tcg-cpu.c                  |   46 +
>>   target/riscv/tcg/translate.c                |    6 +
>>   tests/tcg/riscv/psimd-common.S              | 1105 ++++++
>>   tests/tcg/riscv/psimd-rv32.S                | 1256 +++++++
>>   tests/tcg/riscv/psimd-rv64.S                |  578 +++
>>   tests/tcg/riscv/psimd-test-macros.inc       |  952 +++++
>>   tests/tcg/riscv32/Makefile.target           |   30 +
>>   tests/tcg/riscv64/Makefile.target           |   25 +
>>   19 files changed, 10406 insertions(+), 6 deletions(-)
>>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>>   create mode 100644 target/riscv/tcg/psimd_helper.c
>>   create mode 100644 tests/tcg/riscv/psimd-common.S
>>   create mode 100644 tests/tcg/riscv/psimd-rv32.S
>>   create mode 100644 tests/tcg/riscv/psimd-rv64.S
>>   create mode 100644 tests/tcg/riscv/psimd-test-macros.inc
>>   create mode 100644 tests/tcg/riscv32/Makefile.target
>>
>>
>> base-commit: b23a62773a7856299cbb3782e64968b6a92c792f
> 


