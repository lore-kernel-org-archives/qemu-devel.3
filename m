Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99226D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJVH-00032n-BU; Fri, 11 Oct 2024 13:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szJVD-0002n1-PU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:32:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szJVB-0006nd-MW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:32:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cb47387ceso3779435ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728667952; x=1729272752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5UB0IS8EtRnVbRF1ECxgjtk2pBnzhjPLZ/sGzwq3sY=;
 b=gEUu7IOJS8sbNcdI/E5dRVkKzdQpAmhaDTa5gxlxg8HRuY5VnOtyNDsWPVBsQjtUtl
 c+kP4RaLwv1eKE2VyIo3Z6KzM45K7kZJUey8ORGRd2gFZTfW3ftEr5QNikh7QnqpAbGg
 Z5O3OKI3b/21w03Lzx2j0UIxguT7LOqZ7IUrWIGYQPFwISNtjGNhqRqX8rY6kgTtqX3Y
 pxqTRCAIp21RDYFwgL5KaNtQsmKKErardhW+WxJyjsciOJx10byBO0afMDykZfAvcqTq
 lGExQlN/09eljynjBVnrwG7DOxte4pmn5gl5fU5IvtQFhz9nqDelSrJIuvZOacMoL+fo
 4BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728667952; x=1729272752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5UB0IS8EtRnVbRF1ECxgjtk2pBnzhjPLZ/sGzwq3sY=;
 b=rg83pb/IZyhQNPtBB20j4WWU+OKKb2bGC+YhMGqzqhbx8Bdl7LFS5VdhFbooNSUbDx
 MG1pBlpcpsw6B1GUzWJgm88bko8w8JIROSMJ15ffsJMgyEDqVKx7yUNw3PBJi/EqjP0r
 +AE0jeTM9ZOj0rVcuEWdbIfTypXXrwzxT81sw7Boe8KBx2bDmUkv9U//rLmJHU/xK5yo
 ug553byj9r+syPXSxYpgA/Qs3Ry76jrNSPOZA2UhkoV3XZFT8Xzo290fItpq5hRDMf25
 xwMvlFoKSD8jqBmAV8GFyubvD0xIm3CCCywgzvfiHnHKt7oRiOQBeHFzbCgtQP+VLoAZ
 WK6w==
X-Gm-Message-State: AOJu0YxvaQZfVDCfjwqRrDOOxpxvANZACWLFHOOG927JVLjGv7IX2vBo
 X0NzQ/Cgf3Isjzpnmbt0fwKu4bvaJX2DZqBSkBcvKRQ7u4ey5uuNfLw571ZDqJU=
X-Google-Smtp-Source: AGHT+IH9lD1GXhvGNI0bfHyuoYYmfMIqaFoKR69JF+K3MNogqsvJnXbI2KRKtwnLSIaPt88IuBDnQA==
X-Received: by 2002:a17:902:d544:b0:20c:5e86:9b5e with SMTP id
 d9443c01a7336-20ca14253f7mr47605955ad.3.1728667951956; 
 Fri, 11 Oct 2024 10:32:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8badc3b2sm25679375ad.12.2024.10.11.10.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 10:32:31 -0700 (PDT)
Message-ID: <596073dd-3d02-41b2-a03a-3041d2d01057@linaro.org>
Date: Fri, 11 Oct 2024 10:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: drop --enable-avx* options
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241010091322.1790604-1-pbonzini@redhat.com>
 <ZwedYPrdBaOz0n2U@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZwedYPrdBaOz0n2U@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/24 02:24, Daniel P. Berrangé wrote:
> On Thu, Oct 10, 2024 at 11:13:22AM +0200, Paolo Bonzini wrote:
>> Just detect compiler support and always enable the optimizations if
>> it is avilable; warn if the user did request AVX2/AVX512 use via
>> -Dx86_version= but the intrinsics are not available.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   meson.build                   | 30 +++++++++++++++++++-----------
>>   meson_options.txt             |  4 ----
>>   scripts/meson-buildoptions.sh |  6 ------
>>   3 files changed, 19 insertions(+), 21 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index e4b2af138da..b4418d54e0a 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2955,22 +2955,16 @@ config_host_data.set('CONFIG_ASM_HWPROBE_H',
>>                        cc.has_header_symbol('asm/hwprobe.h',
>>                                             'RISCV_HWPROBE_EXT_ZBA'))
>>   
>> -config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>> -  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
>> -  .require(cc.links('''
>> -    #include <cpuid.h>
>> +if have_cpuid_h
>> +  have_avx2 = cc.links('''
>>       #include <immintrin.h>
>>       static int __attribute__((target("avx2"))) bar(void *a) {
>>         __m256i x = *(__m256i *)a;
>>         return _mm256_testz_si256(x, x);
>>       }
>>       int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
>> -  '''), error_message: 'AVX2 not available').allowed())
>> -
>> -config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>> -  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
>> -  .require(cc.links('''
>> -    #include <cpuid.h>
>> +  ''')
>> +  have_avx512bw = cc.links('''
>>       #include <immintrin.h>
>>       static int __attribute__((target("avx512bw"))) bar(void *a) {
>>         __m512i *x = a;
>> @@ -2978,7 +2972,21 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>>         return res[1];
>>       }
>>       int main(int argc, char *argv[]) { return bar(argv[0]); }
>> -  '''), error_message: 'AVX512BW not available').allowed())
>> +  ''')
>> +  if get_option('x86_version') >= '3' and not have_avx2
>> +    warning('Cannot enable AVX optimizations due to missing intrinsics')
>> +  elif get_option('x86_version') >= '4' and not have_avx512bw
>> +    warning('Cannot enable AVX512 optimizations due to missing intrinsics')
>> +  endif
> 
> Should these perhaps be error() rather than warning() ?
> 
> We only support GCC & CLang. If both GCC 7.4.0 and CLang 10.0 (our
> min versions) have the intrinsics, then I'd say this is an impossible
> scenario if x86_version is large, and thus would deserve error()
Agreed.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

