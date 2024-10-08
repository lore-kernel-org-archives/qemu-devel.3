Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B7CEF172
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAA0-0000S3-FZ; Tue, 08 Oct 2024 09:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syA9y-0000Rg-1F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:21:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1syA9v-0006zY-9H
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:21:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e0d9b70455so4318994a91.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728393706; x=1728998506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbX1unSQ2Vs088oDBVPkZC/yDHJZsiarhjCxYs2wQoI=;
 b=YPhBcL1L2wjHe7BCA3ARDPQzv+/1IuqBy8lJ03xguUBnfVHS253XxAv/zHmVH7NyV0
 bAt3dSQzpXxjRQuRyWlfR2Jtfy+q4+Uc002TGDHvweL0Qq4MhaRXSh68Ayq9Z6W2F1jL
 AT10hcZnsMcxr5cyq29UmJi4rI4+/081wkQd5ZXbeuUt3m+80USoMn3VjPx98/yCEkuX
 EfCqDY1KLjflBXxCIeQTfOh+w0Rihk+vETkcoHrLX/3DbMeFU2vBD0mZBsq0Qgflj9mE
 jyI9AtA/FVw/xuxvH6Dj3FwRTmuqTbDHgmWF6h81IBp+z4HQpHGDthp6JF+s40PZk0pY
 vEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393706; x=1728998506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AbX1unSQ2Vs088oDBVPkZC/yDHJZsiarhjCxYs2wQoI=;
 b=pOsv4e9zn1jyEVQtyIc9kcd4TXsCshn3C/YkxQ9tt3mfUhoHBujnX2MJhuMg1kl89r
 w8WiNTxhsdoJjCv6BKed9s4ABYLj5I3JGjtQhnQOkVjCGHQw8aO7cGNJFKe6NfQsJI1U
 R8Ow/5RKEHAGhyfpMrhiPeZHdwAWwwiaZLAUG5niCvDzdd1hJWkoz3tz/RirvMn7mm/i
 9HzlFa1elea4SZM235vO7ZQslyWjV1D4j1ywCz2sDEwrpEAqsOvuBukpibnoBJVueykD
 0Zmc15fLcvCdaXnVIyV/IiGWHa0Ik/5Nn/7U8OPUSDulzcEoCmvOkmb0WPWy9KLWY/wA
 /Wsg==
X-Gm-Message-State: AOJu0YxHOHMX7cgIWgc3EJnB2A/k1O0xSY705PlKIdhszmAJBIVBtuPz
 VFPtdBI/3risV20Uls9M6/TiEEuhaPwRBbY+kD1s/ltxqtpG0gfI+q3dWwFu4ao=
X-Google-Smtp-Source: AGHT+IGuZLNdCvfacOtsHnp4NUyIVN9kt2nFsvvICCHqQ++zF+p4Q2qJcz2OTiuSvekbydEmVhFsvQ==
X-Received: by 2002:a17:90b:4b12:b0:2e0:b65b:6b4d with SMTP id
 98e67ed59e1d1-2e1e63b4286mr14501643a91.41.1728393706447; 
 Tue, 08 Oct 2024 06:21:46 -0700 (PDT)
Received: from [10.84.144.194] ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e83cab87sm9435653a91.5.2024.10.08.06.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 06:21:46 -0700 (PDT)
Message-ID: <2bc89f23-9162-4668-b3a9-066c30df8e13@bytedance.com>
Date: Tue, 8 Oct 2024 21:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
 <ZwSfFNUYQNs/X74u@intel.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <ZwSfFNUYQNs/X74u@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.66,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Zhao.

On 10/8/24 上午10:55, Zhao Liu wrote:
> Hi Chuang.
>
> Look fine for me, and only some minor nits:
>
> On Mon, Oct 07, 2024 at 04:13:44PM +0800, Chuang Xu wrote:
>> Date: Mon,  7 Oct 2024 16:13:44 +0800
>> From: Chuang Xu <xuchuangxclwt@bytedance.com>
>> Subject: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
>>   processors in the physical package
>> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
>>
>> When QEMU is started with:
>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>
>> Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
>> CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
>> execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
>> CPUID.04H.EAX[31:26] as expected.
> I polished the sentences a bit:
>
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
>
>> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> s/round/rounds/
>
>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>> integer too. Otherwise we may encounter unexpected results in guest.
>>
>> For example, when QEMU is started with CLI above and xtopology is disabled,
> What's xtopology?
What I want to express here is Extended Topology Enumeration Leaf.
>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
>> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
>> as the result, even though theads-per-core should actually be 2.
> s/theads-per-core/threads-per-core/
>   
>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
>> to solve the unexpected result.
>>
>> In addition, we introduce max_thread_number_in_package() instead of
>> using pow2ceil() to be compatible with smp and hybrid.
>>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>> ---
>>   target/i386/cpu.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 85ef7452c0..1b4e3b6931 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
>>       return num_ids - 1;
>>   }
>>   
>> +static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
>> +{
>> +    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
>> +    return num_threads;
>> +}
>> +
>>   static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>>   {
>>       uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
>> @@ -6462,7 +6468,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>           }
>>           *edx = env->features[FEAT_1_EDX];
>>           if (threads_per_pkg > 1) {
>> -            *ebx |= threads_per_pkg << 16;
>> +            *ebx |= max_thread_number_in_package(&topo_info) << 16;
> This helper has only 1 caller and its name doesn't distinguish the
> addressable ID, so it's not necessary. I feel it's better to shift
> the bits directly here:
>
> *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
>
>>               *edx |= CPUID_HT;
>>           }
>>           if (!cpu->enable_pmu) {
>> -- 
>> 2.20.1
>>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Thanks, Later I'll send patch v5.

