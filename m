Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE52D1A45D
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 09:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szYXj-0002d1-UJ; Sat, 12 Oct 2024 05:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1szYXh-0002cs-SE
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:36:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1szYXd-0000R0-LZ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 05:36:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71dec1cf48fso2482779b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728725764; x=1729330564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3lLqCYDHvM5V+9sKirBSH/hOX9eu6JdVML0bFl2Trc=;
 b=gHRAZrHDON/oYKLYQUBAvgk7iXya2KlLz1/wL1ah22bFv6Ltc3c8sVpq4vOF6pOoGC
 z558juehBFSaqxDeoC7Y4FI1QZMcmNT1mQ9azgjuwGBHJdcAVeRJ1IiBGW9nQkmUVR+U
 /1lRnGfVp8tBrW7p1IEmARCzesRDoU1Vn8zhv/76bowk7J/rwUd8r04yYJGBe0S2e41B
 flTnFm5G4cnlo99Qcg4AfrFWD2yxW1HrPE8FJQLH+F8K/UsxMTE8CYsItWz8MpmuIxVr
 gu3IyWsQiF+2bv21jgCwS3SBy23zonwGuphKs/OEsxyaRNm9lAfSCvIhpJFezv2CIdco
 WtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728725764; x=1729330564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F3lLqCYDHvM5V+9sKirBSH/hOX9eu6JdVML0bFl2Trc=;
 b=wOOm3H5555t11eeFNgdqqINUBL1SLZnRJcwJYWW1bgbt3W0m9KbgQnqUz7IpIgL3J0
 DhploKYNgDTb2MYIgxkbG3H34gsX2zSEntKnvUko5obHg45M0xu5RsG6qoEpCRXD8+Rp
 pB+55OTgOm8tXJDjOFec9eSps1xgicLmvaqKu+tn386HS2YildgkyVZ7gRkDq6Hoq3ie
 0bcCZHqbIbXhUTz88N81NrphbFve8M9rVov+0CKDtORqtexCP7SGlmeDndlL62l5n7yE
 a+YdeAtWfrSkSPAHfTDUsKHNij2ycpd6O12hU5T8BT7To5jN0bXFbtw5ENekuxdvkWz3
 GnkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG7bNMq1Iy9KO52xnD2UoLBwXwXg3pVIuf+wAJAdkowC8mubmvQ1bC/k0Hn1cx+qmxsf9LCgnDRw+r@nongnu.org
X-Gm-Message-State: AOJu0YwpVU7HTqSkedPZiK8vhxm3RtfunIqor/06EQIjz1Qy81QgMSmq
 5oxqbLIBTN9PgCnKWFJhhow7joYCdUFLrrCWkv5GAJZt15QGDsqcTPaSiC3SK3M=
X-Google-Smtp-Source: AGHT+IHgf09xtqKxqEajh31jH1PATZOwp4/EeFSv9ACZT9OiupHIxq+fNdTgHPCcjZhkv/CLdB74gw==
X-Received: by 2002:a05:6a21:1643:b0:1d8:acec:f5c4 with SMTP id
 adf61e73a8af0-1d8bcfa7be6mr7974014637.38.1728725763943; 
 Sat, 12 Oct 2024 02:36:03 -0700 (PDT)
Received: from [10.84.144.194] ([203.208.167.148])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aab5e20sm3970395b3a.141.2024.10.12.02.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 02:36:03 -0700 (PDT)
Message-ID: <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
Date: Sat, 12 Oct 2024 17:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.649,
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


On 10/12/24 下午4:21, Xiaoyao Li wrote:
> On 10/9/2024 11:56 AM, Chuang Xu wrote:
>> When QEMU is started with:
>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>
>> On Intel platform:
>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>> logical processors in the physical package".
>>
>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 
>> 90 for
>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>> CPUID.04H.EAX[31:26], which matches the expected result.
>>
>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>> integer too. Otherwise we may encounter unexpected results in guest.
>>
>> For example, when QEMU is started with CLI above and xtopology is 
>> disabled,
>> guest kernel 5.15.120 uses 
>> CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
>> calculate threads-per-core in detect_ht(). Then guest will get 
>> "90/(1+63)=1"
>> as the result, even though threads-per-core should actually be 2.
>
> It's kernel's bug instead.
>
> In 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of "Intel 
> 64 Architecture Processor Topology Enumeration" [1], it is
>
>   - SMT_Mask_Width = Log2(RoundToNearestPof2(CPUID.1:EBX[23:16])/ 
> (CPUID.(EAX=4,ECX=0):EAX[31:26]) + 1))
>
> The value of CPUID.1:EBX[23:16] needs to be *rounded* to the neartest 
> power-of-two integer instead of itself being the power-of-two.
>
> This also is consistency with the SDM, where the comment for bit 23-16 
> of CPUID.1:EBX is:
>
>   The nearest power-of-2 integer that is not smaller than EBX[23:16] is
>   the number of unique initial APIC IDs reserved for addressing
>   different logical processors in a physical package.
>
> What I read from this is, the nearest power-of-2 integer that is not 
> smaller than EBX[23:16] is a different thing than EBX[23:16]. i.e.,

Yes, when I read sdm, I also thought it was a kernel bug. But on my 
192ht spr host, the value of CPUID.1:EBX[23:16] was indeed rounded up

to the nearest power of 2 by the hardware. After communicating with 
Intel technical support staff, we thought that perhaps the description 
in sdm

is not so accurate, and rounding up CPUID.1:EBX[23:16] to the power of 2 
in qemu may be more in line with the hardware behavior.

>
> - EBX[23:16]: Maximum number of addressable IDs for logical processors
>   in this physical package
>
> - pow2ceil(EBX[23:16]): the number of unique initial APIC IDs reserved
>   for addressing different logical processors in a physical package.
>
> [1] 
> https://cdrdv2-public.intel.com/759067/intel-64-architecture-processor-topology-enumeration.pdf
>
>> And on AMD platform:
>> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
>> result meets our expectation.
>>
>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 
>> integer
>> only for Intel platform to solve the unexpected result.
>>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>> ---
>>   target/i386/cpu.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ff227a8c5c..641d4577b0 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>           }
>>           *edx = env->features[FEAT_1_EDX];
>>           if (threads_per_pkg > 1) {
>> -            *ebx |= threads_per_pkg << 16;
>> +            /*
>> +             * AMD requires logical processor count, but Intel needs 
>> maximum
>> +             * number of addressable IDs for logical processors per 
>> package.
>> +             */
>> +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>> +                *ebx |= threads_per_pkg << 16;
>> +            } else {
>> +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
>> +            }
>>               *edx |= CPUID_HT;
>>           }
>>           if (!cpu->enable_pmu) {
>

