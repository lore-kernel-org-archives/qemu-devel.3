Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE63CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdP9-0001po-JZ; Mon, 11 May 2026 23:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdP8-0001pU-32
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:03:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdP6-0005OT-4s
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:03:29 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6mCG2519102
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z+XsWQ7nko0Af8QGLq9Mlr5ixuicRmUTn5hD6akSd6Y=; b=Oet3SJuK1pMK4//7
 lzu2D37kK1AgXoNaXIaHGcEkdVXKObL4sdYsVK+ynEVGal9Bm9M8/F57Z8WRd5wl
 1goLuW+/k9IybnGZkxCh56SncBx/NBQlD9FXWwvuxwQXkmo0gzjF256m5eIMBsEG
 BrYtftc4414xA0Vy+8M0eLkGAaN1feWOWdkE0vLkOxoOPPqxcpD+8dKeJ45hd9fV
 HNw1/8i9a+ZhVkoS7HVv9wnC+2a5gC/g5cJ4VAArjXPthXxvYR9bWffVmTP0cfNh
 bec14E6XIr+XH7aDeN2JseNckWVjGMqNC/2ZW/SIYk47piPV3P9q0k2RXFvZ+dW3
 d/eBFw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h6te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:03:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f485961555so9131615eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778555005; x=1779159805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z+XsWQ7nko0Af8QGLq9Mlr5ixuicRmUTn5hD6akSd6Y=;
 b=gStEZjrWZav2k22BQBOy5mOV/Rt3F42XXgZ0wLuAFsaWx8RxGbLL5uH4gf6vkcxfE4
 Z4vQbzR9J946pazDBtpv7+JpeJUHOiEH+qjSgvC/Dk0xj0eVHDX7XLDz2x1WTCp6a1ng
 CM9HFUkHuAQWDJAZFQEbHGaC9cNh+WT+U0Dk8dL16vXGlWDINUwJUoNsigt9AgftMf8D
 NRTI8OccOJv2yJq+j303yjGx2QwOSCAs+VYbuhmIWS8vJz1Ab1khIL/jUNDZwVCrzkS3
 Mb3BqZEP3rE9eifnLQmqqGZ0LENyzc2B7h0XvQd6LkuBa3WNNR/3ZS6+F6aOCb7Fsjqe
 ySsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778555005; x=1779159805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+XsWQ7nko0Af8QGLq9Mlr5ixuicRmUTn5hD6akSd6Y=;
 b=NxlDpL6oGQcI6GvLs5X+pBBEvHb0fSYhncIXE6ayGUqO4CXQfsCUgUkApTE0enoE/h
 BHFVPUqAKMPfi6h1L8hBM5UT8iEagaia2mZBX9SVHHyRcveHWctdwb4TFJ+yziYn0Ar6
 JKFwIWPAy2JwolG+KeZi50IPSkOFanFVO5Vk3TruJIl/2tt5puoxZTkVEdbAAWR9VjU/
 r2qMU3LIGMIeTLr8Vnr8WlYp2OuGCj/kBt2P1y6Hiy4sQat/L7Vz1ixdU6lms914O/SU
 p+WaR29srnq+hLvN2b+Lchd73VrWjArXq/jl5TvIkUlCBPn5nO4bevZ9WMz84SW8oyLz
 sXZw==
X-Gm-Message-State: AOJu0YwY/kI/wUAMx7JHx3ecq54adbHqMciVU9VP61ifP6z0F+uzqSUf
 fQQh4CotLActhsl0UAS9SsUOmtPJPw0mdkrwkeYkiOmbW+Pa9lAt2n89wZrEbWaPS1T4RcGhWEG
 wUoBV8pkeodB4cXee3VQaU9rVqXdiefZi83MV22V+UJtdQgIsYkwZHRKfKg==
X-Gm-Gg: Acq92OGjoieOUVBMmaEU3o8rZAabfWUvtxfpTsvqf2ho8o7MnA0Yirx+wOVdg/zCyKU
 +nMCemb5ZXTD6xEgZxrrXLZiyQ45VR/Hm8gsXfSDp7Yh/gWHRNLQEp4077IcUNl8i5lm62rYmaO
 FZ3UqtcyriKZxxkC95GmukOSLWQSuw8g4vcE527FbayWwtVkRknoVGaIrZCDOCylRouu1ANt5Bw
 04htf80U1Zr1qR4xyGl3l7RJWcUnzFULIzctFRZWyJndxEbD2rRhlm6uRsPy1R/r1lP8pDDpBE2
 Tb4ifCH7VjYoPNsQCU0nvfd1xUwGRoc4O+WqNwI3Nv8BpEA+VtmSB7mKC2MKUekQjV/Jz8l6Abw
 XrVb9rrGERSPTggo8bp7ntaJ+ahbf8dVObCRtPS9KT+seBGG20sJfD6BlQKA=
X-Received: by 2002:a05:7300:724b:b0:2e2:a64b:63b5 with SMTP id
 5a478bee46e88-2fb4b733e77mr5738205eec.18.1778555004653; 
 Mon, 11 May 2026 20:03:24 -0700 (PDT)
X-Received: by 2002:a05:7300:724b:b0:2e2:a64b:63b5 with SMTP id
 5a478bee46e88-2fb4b733e77mr5738190eec.18.1778555004065; 
 Mon, 11 May 2026 20:03:24 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8893441absm21571258eec.31.2026.05.11.20.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 20:03:23 -0700 (PDT)
Message-ID: <652e680f-d623-47dc-9964-4e258213f571@oss.qualcomm.com>
Date: Tue, 12 May 2026 00:03:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] target/riscv: remove riscv_cpu_* arrays
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
 <agKIuzJdhI6P4dmt@ZEVORN-PC.localdomain>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agKIuzJdhI6P4dmt@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OYgLboCy9YnelQv46y9UwZXIqTSCUcbE
X-Proofpoint-ORIG-GUID: OYgLboCy9YnelQv46y9UwZXIqTSCUcbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyNiBTYWx0ZWRfXwX5OdE8eeaGy
 oDNfPreo+wg5cac3fo0pIhCiLWyxhKEiwk2pWmAcUwCgU9pOapeDPNLCcVpm3z8b5+cgRRWTtqG
 wshrcFUFvfxlUH+UbY/FCdFBDelNR13C0A01Q9rFSx18w3x0EE2tAtUyLeY+68+DSq8PWd+qHXK
 pCajV7X35UST2xoFczCnv0qVJokzk0ldOoSoNGguvsvbcsz/9JlGJwTA8geaIqXOavNliBbK8v+
 zSEJ4HLfQGlzr/p6nO4iCspJlt35N5y4UX68z3TwIO1iX+FDj4CAyF70t3UAdWQrANcd/tGXusu
 oouqi7YrUs9+s2OjRqXQEF1CE9K7nmkV2SqI/+BT3p1+sG5WsuJkVj9UZ8mdqJdiJCrS9XrETa2
 QeebtypyMv2+7uHa/SvtgvJnSE+rbge4V0yqy5jNKTSmuLndsnz3ViezAgIc81/sJAgyRBS97LM
 LX4pyQ51jyyJBspF7gQ==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a02987e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Ab8Id7SuDGbAHyMYYi8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120026
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



On 5/11/2026 11:07 PM, Chao Liu wrote:
> Hi Daniel,
> On Mon, May 11, 2026 at 10:28:57AM -0300, Daniel Henrique Barboza wrote:
>> Hi everyone,
>>
>> We have been dealing with two sources of extensions information in
>> target/riscv/cpu.c:
>>
>> - isa_edata_arr[]: an array that we must keep in riscv,isa ordering that
>>    also has priv_spec info;
>> - riscv_cpu_* arrays: used to set user properties and set defaults for
>>    rv32/rv64, among other users across the code.
>>
>> The main issue here is the info being duplicated across arrays.  When
>> adding new extensions we go through a ritual of adding basically the
>> same stuff in both isa_edata_arr[] and riscv_cpu_extensions[].  We can
>> eventually forget to do all steps of that dance, resulting in patch 1.
>>
>> The second issue is a desire for less abstractions.  An extension is
>> something that we report in riscv,isa, that might be exposed to users or
>> not, that might be a vendor or an experimental ext.  All these
>> distinctions don't require multiple distinct arrays.
>>
>> I also made an effort to start moving away from the 'named features'
>> stuff we have going on.  A 'named feature' is just an extension that
>> most of the time isn't exposed to users, most of the time represents
>> innate TCG behavior, and sometimes have a different enable mechanism
>> aside from setting a flag to 'true'.  None of that is exclusive to this
>> class of extensions therefore I believe we should move away from it
>> over time.
>>
>> There are more design simplifications I want to do in cpu.c and with CPUs
>> in general, but for now we can enjoy less lines to maintain.
>>
>> Patches based on alistair/riscv-to-apply.next.
>>
> I’m seeing some compile errors after applying these patches on top of commit
> 0844c21f24ca (target/riscv: Update MISA.X for non-standard extensions) from
> alistair/riscv-to-apply.next.
> 
> ---
> ../target/riscv/tcg/tcg-cpu.c: In function ‘riscv_cpu_update_misa_x’:
> ../target/riscv/tcg/tcg-cpu.c:1158:11: error: unknown type name ‘RISCVCPUMultiExtConfig’; did you mean ‘RISCVCPUConfig’?
>   1158 |     const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
>        |           ^~~~~~~~~~~~~~~~~~~~~~
>        |           RISCVCPUConfig
> ../target/riscv/tcg/tcg-cpu.c:1158:41: error: ‘riscv_cpu_vendor_exts’ undeclared (first use in this function)
>   1158 |     const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
>        |                                         ^~~~~~~~~~~~~~~~~~~~~
> ../target/riscv/tcg/tcg-cpu.c:1158:41: note: each undeclared identifier is reported only once for each function it appears in
> ../target/riscv/tcg/tcg-cpu.c:1160:27: error: request for member ‘name’ in something not a structure or union
>   1160 |     for (int i = 0; arr[i].name != NULL; i++) {
>        |                           ^
> ../target/riscv/tcg/tcg-cpu.c:1161:43: error: request for member ‘offset’ in something not a structure or union
>   1161 |         if (isa_ext_is_enabled(cpu, arr[i].offset)) {
>        |                                           ^
> [1658/2250] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_vector_helper.c.o
> ninja: build stopped: subcommand failed.
> ---
> 
> Maybe try rebasing again and fixing it.

Thanks for catching this up!  Guess I somehow missed this change from
Alistair's branch.

I'll send a v2.  Thanks,
Daniel

> 
> Thanks,
> Chao
>> Daniel Henrique Barboza (13):
>>    target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
>>    target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
>>    target/riscv: make riscv-qmp-cmds use isa_data_arr[]
>>    target/riscv/tcg: treat all exts equally in
>>      cpu_disable_priv_spec_isa_exts
>>    target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
>>    target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
>>    target/riscv: remove riscv_cpu_named_features[]
>>    target/riscv/kvm: use isa_edata_arr[] for unavailable props
>>    target/riscv/tcg: use isa_edata_arr[] to enable max exts
>>    target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
>>    target/riscv: do not set defaults in cpu prop callback
>>    target/riscv/tcg: use isa_edata_arr[] to create user props
>>    target/riscv/cpu: remove riscv_cpu_* arrays
>>
>>   target/riscv/cpu.c            | 315 ++++++++++++----------------------
>>   target/riscv/cpu.h            |  12 +-
>>   target/riscv/kvm/kvm-cpu.c    |  25 ++-
>>   target/riscv/riscv-qmp-cmds.c |  30 +---
>>   target/riscv/tcg/tcg-cpu.c    | 137 ++++-----------
>>   5 files changed, 153 insertions(+), 366 deletions(-)
>>
>> -- 
>> 2.43.0
>>


