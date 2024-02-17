Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4023C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 17:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbOTo-0008P3-Qr; Sat, 17 Feb 2024 12:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbOTn-0008Om-Jo
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 12:27:59 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbOTl-0001Kx-7z
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 12:27:59 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2997c5fe6abso23219a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708190876; x=1708795676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YZ7fOpUHNbJKvjI94vWeCJeJ6Gt6HFQtT5Uk1QodXSc=;
 b=cXjhZNk8qcBSQB+oaMQM6ghJ17bQiaAIQ+KC+lXY+3smdmlv8RlGqzd8K648Jst3lC
 3fDhHdBEl2DwKNOGX85tyrtbjds9Lnu9GJYgT8wbEM5MTSPvcNoQOVuFy/3zMhXT0QtD
 VcqfSLQ59zd/XbwVerp7q9JDMf4ie0OGmu/nsdjFb8gxWygqhXR3OaZHj+XQsVNQDNm6
 n5XgGDGEJ+PwAB1hUOIRA7D8/VLco37ZX6SWfpwS7YexiJRfJ6+NLrQ+sVZt/40aSKR9
 RZ1+l2Hf4UTWZrjXObzrA64wSxCJxHgVUqWZd/2XAfd2uTHv0EruS+5xTeaRLy08QYqC
 t5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708190876; x=1708795676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZ7fOpUHNbJKvjI94vWeCJeJ6Gt6HFQtT5Uk1QodXSc=;
 b=lq2TQ0CIRfv5Set8JVi2mm26hSCYJuJm7o7f075T6vAHrA5u92KjML0LA/KQi9Oo0r
 2stHiPNypBbQg6dRZ0jU6OMTH8w0Re3LwBzoRb+ZpKGBMKpb2yBnOvIbUr//kuooLajP
 +QJDFHF7Xq1TjdGwYvSt6lJhOJe3gnPfXE94jSguu4IlH4/Q06rWELfrNTgbw1St6WTP
 V5rvitS3xbP4CyTeL4MuX98JpYUgCm/NKJUUEZW9MZmwOTw5iOFnz6g0CEyrc558KLCm
 UVEi3fbeMy35IZ2UIZ8iNatkLuEss6xRQAUvnusntiR5DYnwnS/fac+Tfrz/6MrCYBKF
 9C0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULihsKmomuh9X2tQL+aU4qvldK0YseQV9ZEPHPvYpIEgp9laWfSw/oN463A/sfL20TR3TG+IzLLxJOjPyeyzHj8T3qsKw=
X-Gm-Message-State: AOJu0YxMYWe3ZSxEKgM2qbGm01N4ehjDUo3YT30ljquJp5fhEttLZTfx
 NB15+748fiLH+9dzCM9Zou5SV3C08kubl/MocvkBJCOpbrwIpNu7GFurRWEShXw=
X-Google-Smtp-Source: AGHT+IEZUZsm5r0AusWrz/jMFABl/7vkvFyDDC08uvqkpYema6yfDysh32fBFMe4rfRhZ26XazM3xQ==
X-Received: by 2002:a17:90a:4ce1:b0:298:d301:db69 with SMTP id
 k88-20020a17090a4ce100b00298d301db69mr7528402pjh.33.1708190875590; 
 Sat, 17 Feb 2024 09:27:55 -0800 (PST)
Received: from [100.64.0.1] ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 li13-20020a17090b48cd00b00297317e5e04sm2088476pjb.52.2024.02.17.09.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 09:27:55 -0800 (PST)
Message-ID: <79830f29-485c-4755-1ba7-57aa76ccc9d7@sifive.com>
Date: Sun, 18 Feb 2024 01:27:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 4/6] accel/tcg: Inline cpu_mmu_lookup function
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-5-max.chou@sifive.com>
 <4a2b1c91-0f25-4474-ad5c-13d9993a16f5@linaro.org>
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <4a2b1c91-0f25-4474-ad5c-13d9993a16f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.405,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Richard,

After I tried to reduce the overhead of unnecessary segment flow and 
memory plugin callbacks, I observed that there several functions consume 
most of runtime from perf report.
So these three inline patches and previous patch were created to reduce 
the overhead without modifying the functions.

The following are the experiment results.
The benchmark target is the bench-memcpy executable generated from the 
glibc repository (release 2.38 with RVV support patch [1]).

- Execution command

`qemu-riscv64 -E TIMEOUTFACTOR=10 -R 1G -L {glibc build folder}/rootfs 
-cpu 
rv64,zba=true,zbb=true,v=true,vlen=256,vext_spec=v1.0,rvv_ta_all_1s=true,rvv_ma_all_1s=true 
bench-memcpy`


- Total  runtime

0. Original riscv-to-apply.next branch (commit ID: deb0ff0)
     - Total execution time: ~383 sec.
1. Cherry pick PATCH 4 to riscv-to-apply.next branch (commit ID: deb0ff0)
     - Total execution time: ~375 sec.
2. Cherry pick PATCH 4+5+6 to riscv-to-apply.next branch (commit ID: 
deb0ff0)
     - Total execution time: ~342 sec.


- Perf report (cycles)

0. Original riscv-to-apply.next branch (commit ID: deb0ff0)

# Samples: 385K of event 'cycles:u'
# Event count (approx.): 1411574690539
#
# Children      Self  Command       Shared Object Symbol
# ........  ........  ............  ....................... 
............................................
#
     47.54%    31.35%  qemu-riscv64  qemu-riscv64             [.] 
vext_ldst_us
     25.60%     0.03%  qemu-riscv64  qemu-riscv64             [.] 
helper_vse8_v
     18.87%    13.29%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldb_mmu
     17.40%     0.04%  qemu-riscv64  qemu-riscv64             [.] 
helper_vle8_v
     17.39%    15.71%  qemu-riscv64  qemu-riscv64             [.] 
cpu_stb_mmu
     17.17%    17.17%  qemu-riscv64  qemu-riscv64             [.] 
qemu_plugin_vcpu_mem_cb
     12.25%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
helper_stb_mmu (inlined)
      8.18%     4.08%  qemu-riscv64  qemu-riscv64             [.] lde_b
      8.17%     8.17%  qemu-riscv64  qemu-riscv64             [.] 
cpu_mmu_lookup
      7.45%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_load_cb (inlined)
      7.32%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
do_st1_mmu (inlined)
      6.79%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000000000ff
      5.91%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
adjust_addr (inlined)
      5.70%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
do_ld1_mmu (inlined)
      5.58%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000000001fe
      5.23%     4.25%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldsb_data_ra
      4.93%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_memop (inlined)
      4.11%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_data_ra (inlined)
      4.11%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_mmuidx_ra (inlined)
      2.88%     2.88%  qemu-riscv64  qemu-riscv64             [.] 
cpu_stb_data_ra
      2.88%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_stb_mmuidx_ra (inlined)
      2.75%     0.00%  qemu-riscv64  qemu-riscv64             [.] stb_p 
(inlined)
      2.66%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_alignment_bits (inlined)
      1.79%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000e40203bf
      1.68%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_store_cb (inlined)
      1.60%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000e403733f
      1.13%     0.00%  qemu-riscv64  qemu-riscv64             [.] ldub_p 
(inlined)
      0.73%     0.73%  qemu-riscv64  qemu-riscv64             [.] ste_b
      0.53%     0.21%  qemu-riscv64  qemu-riscv64             [.] 
helper_lookup_tb_ptr

1. Cherry pick PATCH 4 to riscv-to-apply.next branch (commit ID: deb0ff0)

# Samples: 378K of event 'cycles:u'
# Event count (approx.): 1381912775966
#
# Children      Self  Command       Shared Object Symbol
# ........  ........  ............  ....................... 
.......................................
#
     63.30%    29.62%  qemu-riscv64  qemu-riscv64             [.] 
vext_ldst_us
     30.77%     0.04%  qemu-riscv64  qemu-riscv64             [.] 
helper_vle8_v
     28.59%     0.02%  qemu-riscv64  qemu-riscv64             [.] 
helper_vse8_v
     22.78%    22.78%  qemu-riscv64  qemu-riscv64             [.] 
qemu_plugin_vcpu_mem_cb
     21.40%     5.26%  qemu-riscv64  qemu-riscv64             [.] lde_b
     20.69%    10.40%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldb_mmu
     20.06%     3.91%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldsb_data_ra
     19.16%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_data_ra (inlined)
     19.16%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_mmuidx_ra (inlined)
     12.65%     9.36%  qemu-riscv64  qemu-riscv64             [.] 
cpu_stb_mmu
      8.60%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_load_cb (inlined)
      6.73%     6.73%  qemu-riscv64  qemu-riscv64             [.] 
do_ld1_mmu.constprop.23
      6.73%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
do_ld1_mmu (inlined)
      6.31%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
helper_stb_mmu (inlined)
      6.20%     6.20%  qemu-riscv64  qemu-riscv64             [.] do_st1_mmu
      6.20%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
adjust_addr (inlined)
      5.49%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000000001fe
      3.82%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_store_cb (inlined)
      3.01%     0.00%  qemu-riscv64  qemu-riscv64             [.] ldub_p 
(inlined)
      2.94%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_mmu_lookup (inlined)
      2.94%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_alignment_bits (inlined)
      2.91%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
clear_helper_retaddr (inlined)
      2.91%     2.91%  qemu-riscv64  qemu-riscv64             [.] ste_b
      2.90%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_mmu_lookup (inlined)
      2.90%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_alignment_bits (inlined)
      0.59%     0.24%  qemu-riscv64  qemu-riscv64             [.] 
helper_lookup_tb_ptr

2. Cherry pick PATCH 4+5+6 to riscv-to-apply.next branch (commit ID: 
deb0ff0)

# Samples: 343K of event 'cycles:u'
# Event count (approx.): 1259748868940
#
# Children      Self  Command       Shared Object Symbol
# ........  ........  ............  ....................... 
.......................................
#
     64.16%    35.81%  qemu-riscv64  qemu-riscv64             [.] 
vext_ldst_us
     30.96%     0.02%  qemu-riscv64  qemu-riscv64             [.] 
helper_vse8_v
     27.44%     0.05%  qemu-riscv64  qemu-riscv64             [.] 
helper_vle8_v
     18.37%    18.37%  qemu-riscv64  qemu-riscv64             [.] 
qemu_plugin_vcpu_mem_cb
     17.33%     7.45%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldsb_data_ra
     14.90%     5.02%  qemu-riscv64  qemu-riscv64             [.] lde_b
     14.83%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_data_ra (inlined)
     14.83%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldub_mmuidx_ra (inlined)
     14.15%    10.33%  qemu-riscv64  qemu-riscv64             [.] 
cpu_stb_mmu
     11.25%     9.62%  qemu-riscv64  qemu-riscv64             [.] 
cpu_ldb_mmu
      7.22%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
adjust_addr (inlined)
      6.99%     6.99%  qemu-riscv64  qemu-riscv64             [.] 
helper_stb_mmu
      6.99%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
do_st1_mmu (inlined)
      5.96%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
do_ld1_mmu (inlined)
      5.95%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_mmu_lookup (inlined)
      5.30%     0.00%  qemu-riscv64  [unknown]                [.] 
0x00000000000001fe
      4.18%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_store_cb (inlined)
      3.22%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
cpu_mmu_lookup (inlined)
      3.22%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_alignment_bits (inlined)
      3.22%     3.22%  qemu-riscv64  qemu-riscv64             [.] ste_b
      3.19%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
get_alignment_bits (inlined)
      3.16%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
clear_helper_retaddr (inlined)
      2.76%     0.00%  qemu-riscv64  qemu-riscv64             [.] g2h 
(inlined)
      2.76%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
g2h_untagged (inlined)
      2.30%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
env_cpu (inlined)
      2.21%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
plugin_load_cb (inlined)
      0.99%     0.00%  qemu-riscv64  qemu-riscv64             [.] 
env_cpu (inlined)


I agree that these functions are large functions to inline and I didn't 
test these patches on all combinations (different guest architecture + 
different host architecture).
So I think that we can drop these three patches until we can make sure 
that these patches can get benefit on all combinations without side effect.
I'll focus on avoiding over-use of the full out-of-line load/store 
routines for the next version.


Thanks for the suggestion and question,

Max

[1] 
https://inbox.sourceware.org/libc-alpha/20230504074851.38763-1-hau.hsu@sifive.com

On 2024/2/16 4:10 AM, Richard Henderson wrote:
> On 2/15/24 09:28, Max Chou wrote:
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   accel/tcg/user-exec.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index 68b252cb8e8..c5453810eee 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -942,8 +942,11 @@ void page_reset_target_data(target_ulong start, 
>> target_ulong last) { }
>>     /* The system-mode versions of these helpers are in cputlb.c.  */
>>   -static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
>> -                            MemOp mop, uintptr_t ra, MMUAccessType 
>> type)
>> +static inline QEMU_ALWAYS_INLINE void *cpu_mmu_lookup(CPUState *cpu,
>> +                                                      vaddr addr,
>> +                                                      MemOp mop,
>> +                                                      uintptr_t ra,
>> + MMUAccessType type)
>>   {
>>       int a_bits = get_alignment_bits(mop);
>>       void *ret;
>
> This is a large function.  Why does it need to be inlined?
> For this and the next two patches I require evidence, because I don't 
> believe you are attacking the problem correctly.
>
>
> r~

