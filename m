Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBA0C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkR5w-0003n3-Ux; Thu, 16 Jul 2026 14:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkR5p-0003mW-5u
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:45:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkR5n-00082p-7v
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:45:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSm9V3395807
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mmZxylGgR4VBT+W0L9gDebXQzAn7Oer8v5uC/gz439I=; b=gJETXO3KAR+5eHap
 uaeHeDmkR/oPVyOqmVHke/8d6w+DOaQ3BXMW3HHookYHPHWu2/ppMcF4A522dlNi
 s9WyLtO6OFRxeT8k0PCW71pL88GHkgPhhtITmvqyyi9+QHAtkOGKDfuzd86mmPxn
 2jmDSCRZPAfFT0Po0cc3rG76X5MuRamYzI14pSbMy4qB80HzgY6QV+uxv4Avrffq
 tWuDAxtDKqKIxZkYNldLJY9GOo3wP3HytlOMMl3fPPa0rDIjNAVYZygDDRMFeSeU
 nyKWSsMT53daf7nAHAbEwjRB5jOrEz7HE9f2BgVSbkM4dkl16USD+12ICu5C7JlQ
 T+TQSw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19m21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:45:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e934385db1so132746986d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784227553; x=1784832353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mmZxylGgR4VBT+W0L9gDebXQzAn7Oer8v5uC/gz439I=;
 b=Rm2nXJIvBANSXJZaSyZxIOnBF5kslKfLZix6N3ZQmUg3qNi91SLXTvlEDUva6dNkxf
 vWIkvMvQzuWeoNhWoCVwlxsNeYWh+GXfLUGuceROq45VixVFxu2PRdFdhdUjftctzpb1
 wCwy3PS1R5rntNIed3pxEm3ljnoh8MJXCksxAMiU9EmnICrh3KfZNlnz/g1mPvRcRD5d
 FghEZTSjGpdnRAgziEZG2EXYPhpDLytIGc9bNBPWTTSPuPAU5UZmXyZwEhyA+A/17VWM
 ZDmkC7V9w9CAEZG48/toCAxoYPqULtzvzYIgd7y4Pev9mgfUOkB7O7bJxff34whXcBTH
 LK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784227553; x=1784832353;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmZxylGgR4VBT+W0L9gDebXQzAn7Oer8v5uC/gz439I=;
 b=QBlr+AHwA4Aii73dHXVERf5tzeBSF7WypENiKj4tYa1mZl40BZWeDXdJiGBqLIMjVD
 L4hOZiTW6Xqfr+f2AahqFhP8TUonMaKI3Tz023HdkCCViomqlAuhqjsHywQTjflcyjRc
 lb2ll7esMixbUEp6zHC4IQO4PYapcRsBgg/6rZDlx3dVSoHuk+7ro6QQT/XPy8kaWFmE
 VPCKv1EYH9DhgtItLDY0mK9z8QesvWHouEM9DFZKl1eayiMKcS5HkFbnwIb6w0h5VNX4
 3U9NuFqTUjAF89uaOoM/5bMQqvyDJdfO7+YJI9ukUIbQEx83ZroJQolA47u89QT/9d5J
 mY5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4Yp/gPZ53l4oMH5oXJINPVFCXGlT3k6Vu618SVU4xTq1URy7a9Vb5pDeP8b+9I1VRWxwVBlX952oS@nongnu.org
X-Gm-Message-State: AOJu0YxcYFdhiVQeo2oBTsZx2clhrCRJm54U9bn9Gct7KDJAq4rx9akp
 QGB7gWdNE0t2piBoyfpifw+75sY80dZSASrDBdfE/r3iM1FNoislQ2R2kFBh+Tn9XbqRMC/rZqJ
 CavEp2LADz/oh3jhjHWJR3r6BbPDmfvQYfjDrDYGisoEpuTYG/ddkbY5Wwg==
X-Gm-Gg: AfdE7cktkRYYtSlf9yON6ft76NfMQilOdo/8p9FP2v9N0loYgUxtlBUr78WpzzuKRbc
 Dl5nqeWfSUo8Xq1nPBBpoFRRuScyUORTmi/inW0mBhhCXMar96Ck/xaks+0SFTXoZL4sNPjGrTK
 BaKUBNBVKPhZAxGftiISn2KoemjXrU20y4LsoW1O2Qkw9fKq20jXlVRLWKyEt7qhf+zrpGWS/lh
 fZ641uAPerI007UKmDd7P4X0TCjrSQUHb5gU3TvuTD1NgRMvgRUdpbUixrhyS/ME0ERjEWA7+DU
 VQZZzgizgTww/qadxe/zqQUC5pDzBrdTfO2avtM3bH0CbiB5lMeXQCa3k76hnVuJZqrqMkybFmm
 1LjCwzdjh9+9wpD7obxxq6mXCmPzIRg7My4oiSQ==
X-Received: by 2002:a05:6214:4292:b0:8f4:8950:37ce with SMTP id
 6a1803df08f44-90747b5f834mr156227976d6.0.1784227552649; 
 Thu, 16 Jul 2026 11:45:52 -0700 (PDT)
X-Received: by 2002:a05:6214:4292:b0:8f4:8950:37ce with SMTP id
 6a1803df08f44-90747b5f834mr156227616d6.0.1784227552216; 
 Thu, 16 Jul 2026 11:45:52 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.123.183])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e081dsm225174586d6.9.2026.07.16.11.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 11:45:51 -0700 (PDT)
Message-ID: <3b172ec2-1506-406f-96ad-763380023788@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:45:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] target/riscv: Support the true Zicclsm extension
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "frank.chang@sifive.com" <frank.chang@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
 <6c50f31be3a11f34f9cf9f507cb7a7d1fdea1532.camel@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6c50f31be3a11f34f9cf9f507cb7a7d1fdea1532.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a5926e1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=szoPuAicwqWYzOEwwuIrwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ID6ng7r3AAAA:8 a=xvfqbYfxAAAA:20 a=pFyQfRViAAAA:8 a=2OcK-xkllQftIlSRpdIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AkheI1RvQwOzcTXhi5f4:22 a=oJz5jJLG1JtSoe7EL652:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5MiBTYWx0ZWRfX3xBl4U3hoVEo
 edb4LvEdmI7YDtBCG7kO0A5J1lLNXQqdOGKlYYWxfVzzry1DvKDV8CDO4/+Kf5EhE6YQU+++kZw
 tuAEMV4J/Op66DVo3HLVJ0RVjlkyo5JwLLewDqkvyVQsA221jxjpqJiSAfrBPV8cmRKGglxMCEg
 brZt5MxvHYZx0yRwLTtj1XtROGDHjmkkPWqHQA3jDZ2lLkYZD+4m5Y6vcKI8Ap1GXNlyGCjgeFM
 b9qO0kA3nbWP8uKslT2aSVDv0fAyk3W2VHHbf05bbE3a1RHSIJ1vRHsyCLRbSmcDPf9XY3pL3WI
 /0PThLfirrumVDwWhLR/34BwGCUAwUSp90TVCXL2qkXUz3R4WtPNgoZURZ1fIIAWMVtSVfHfvzP
 VUI/EsrIZ7LA1tS/xm4xRYlLdPpvxQ14bEaq3a1B0s5/xc5de9s7zhNRvS15OmRZCHwjCzwsydS
 WQeZ8t9oeOH80G+kt9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5MiBTYWx0ZWRfX9q3gEZS1ArMI
 SnGmzvjnu/QJJP4DVVo0/XXtikJs2IwH57nS7EyPVQzsnQIjawWlFPqxqc86fivxlkLXwON8O/d
 G5U6Kqrb9PyNMi37jAU3Hu3t5tO9yac=
X-Proofpoint-GUID: WJrglAV7nO-cwioojBBzKgcfxk4krRTs
X-Proofpoint-ORIG-GUID: WJrglAV7nO-cwioojBBzKgcfxk4krRTs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160192
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



On 7/13/2026 1:01 AM, Alistair Francis wrote:
> On Mon, 2026-07-13 at 11:51 +0800, frank.chang@sifive.com wrote:
>> From: Frank Chang <frank.chang@sifive.com>
>>
>> Support the true Zicclsm extension so that we can trap misaligned
>> accesses
>> when Zicclsm is disabled.
>>
>> To enable/disable Zicclsm, simply set zicclsm=[true|false], e.g.:
>>    -cpu rv64,zicclsm=[true|false]
>>
>> QEMU will raise a misaligned load/store exception when executing
>> misaligned
>> load/store instructions if Zicclsm is disabled.
>>
>> Changelog:
>>    v6:
>>      * Reorder and squash Zicclsm CPU property and RVA22U64 profile
>> patches to
>>        make every single commit to pass `make check`.
>>    v5:
>>      * Add Zicclsm to RVA22U64 profile explicitly.
>>      * Rebase to the latest riscv-to-apply.next.
>>    v4:
>>      * Align ROM reset vector data at 8-byte aligned offsets.
>>    v3:
>>      * Enable Zicclsm for the compatible CPUs.
>>      * Rebase to the latest riscv-to-apply.next.
>>    v2:
>>      * Use (size_memop(size) | mo_endian_env(env)) to calculate MemOp.
>>      * Use (log2_esz << MO_ASHIFT) to calculate aligment MemOp for
>>        vector load/store whole register instructions.
>>
>> Frank Chang (6):
>>    target/riscv: Add Zicclsm CPU option
>>    target/riscv: Enable Zicclsm for the compatible CPUs
>>    hw/riscv: sifive_u: Align ROM reset vector data
>>    target/riscv: Support raising misaligned exceptions for scalar
>>      loads/stores
>>    target/riscv: Support raising misaligned exceptions for vector
>>      loads/stores
>>    target/riscv: Expose Zicclsm as a CPU property and update RVA22U64
>>      profile
> 
> This has missed the 11.1 release window [1]. So it will now need to
> include unit tests and a user of the extension (submitted toolchain
> support patches) according to [2].
> 
> 1: https://wiki.qemu.org/Planning/11.1
> 2:
> https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_Extensions

zicclsm is supported by GCC since

-----------
commit 5c18df44fd1387653595869c9145c63fffb8cfac
Author: Monk Chiang <monk.chiang@sifive.com>
Date:   Thu Feb 1 17:14:18 2024 +0800

     RISC-V: Add minimal support for 7 new unprivileged extensions

     The RISC-V Profiles specification here:
     https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#7-new-isa-extensions

     These extensions don't add any new features but
     describe existing features. So this patch only adds parsing.

     Za64rs: Reservation set size of 64 bytes
     Za128rs: Reservation set size of 128 bytes
     Ziccif: Main memory supports instruction fetch with atomicity requirement
     Ziccrse: Main memory supports forward progress on LR/SC sequences
     Ziccamoa: Main memory supports all atomics in A
     Zicclsm: Main memory supports misaligned loads/stores
     Zic64b: Cache block size isf 64 bytes
-----------


I think we're good w.r.t a user/use for it.  Thanks,

Daniel



> 
> Alistair
> 
>>
>>   hw/riscv/sifive_u.c                         | 11 ++--
>>   target/riscv/cpu.c                          | 10 +++-
>>   target/riscv/cpu_cfg_fields.h.inc           |  2 +
>>   target/riscv/tcg/insn_trans/trans_rvi.c.inc |  6 ++
>>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 18 +++++-
>>   target/riscv/tcg/vector_helper.c            | 65 ++++++++++++++++---
>> --
>>   6 files changed, 88 insertions(+), 24 deletions(-)
>>
>> --
>> 2.43.0
>>


