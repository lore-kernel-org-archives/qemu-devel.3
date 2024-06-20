Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF55C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLU2-0000u4-Ky; Thu, 20 Jun 2024 13:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLU1-0000ts-C8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:22:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLTx-0005Ud-IL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:22:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7062bf6d9a1so925142b3a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718904115; x=1719508915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwCtGLShmjvfARCO2fv1B/Nm7Yc6RbwQ1+YPoZ1aXXM=;
 b=f5RXMXx0YwTpxnFw15B/smVMPTbQkGjAHwqLCz6J9T60HXDa39Fo1eu+dMKeQ6+Hpc
 0mFmmafuOfoB/ve8sahqfbTchVb7RgDv7HeJ3T+9K9BR/OXlYaqLI4AO5AYOXoyhxifB
 HXGcF//1Ktk1D0a6orTaGVJIOoSlDCKsNKhYuWQTscZmw37osLZIj3icskOvOPcT7Cwc
 4ONFxIlyfHs5SZ+1T4SvWGYydmARWfUw7/a0kChsCJuS+Wp+gEXMruj7N/l1E9d/lAKz
 ghpfmcasHFqKUUvgPH5hgKvzgWR6p+ot9UpDOTSS0auI87xF4pnttsSsR8bHf5QqLxwW
 g0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718904115; x=1719508915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwCtGLShmjvfARCO2fv1B/Nm7Yc6RbwQ1+YPoZ1aXXM=;
 b=ZRsdgQ6zj5NKXcvDOXZxKIMGN0xEd7WUWbRQoMsGIkuyIFo1h1d1dxBAhsshpAgCN6
 emW4uYKbz/JZ6y60EHQt6u/Xnq4QkeN8azB0XfwqF1TeXESUJv6veYbAj6AwpuC/aBf0
 tLz63ZUzygCZ039v2DUV5RjcekXkPiyWnk3KcOK/sZ+eJRlolPSTAKS4Uilrotu/SUrL
 Mfh/0L+O7UkXxun1NMt0tp+n7VYJpFVg8wPFZekEcZi13cwt5srHU054ZIs0qRcjfHoz
 gkTiAvlfbKPodMYkI7Jdzxu1NpchmoDBQBoh0eVVKQbKjIW/w3N0o8w9X2H4sfZjrl6M
 hqaw==
X-Gm-Message-State: AOJu0YxkhJgLJt0tTo5J5bEO+qQiOV5d/EJK5beuIJjhntY6FlsIMsRP
 W0r2OrBBJeLHFFr0Ci9G6DL79nLZ5VI8tNvMwPslD6v5FXrtcHPYB1e+yatt9sthOsjsm479Qo/
 O
X-Google-Smtp-Source: AGHT+IHgJqlVDwyNE82gcH1dwfyQAd2tYttd1lEiLLq+ld/qt2MzqaNoNLvcSJ6nM5H6j0YdEbxg0w==
X-Received: by 2002:a62:971a:0:b0:705:c431:74fd with SMTP id
 d2e1a72fcca58-70629cf3ea8mr5743136b3a.28.1718904114892; 
 Thu, 20 Jun 2024 10:21:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc91e149sm12605096b3a.8.2024.06.20.10.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:21:54 -0700 (PDT)
Message-ID: <068d20cb-62c2-47ca-bf56-eea5f53ff51a@linaro.org>
Date: Thu, 20 Jun 2024 10:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] meson: require compiler support for chosen x86-64
 instructions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amonakov@ispras.ru
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-7-pbonzini@redhat.com> <ZnRETaWTb57K0VO3@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZnRETaWTb57K0VO3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/20/24 08:01, Daniel P. Berrangé wrote:
> On Thu, Jun 20, 2024 at 03:02:54PM +0200, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   meson.build | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 54e6b09f4fb..c5360fbd299 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2863,6 +2863,7 @@ have_cpuid_h = cc.links('''
>>   config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
>>   
>>   config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>> +  .enable_auto_if(get_option('x86_version') >= '3') \
>>     .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
>>     .require(cc.links('''
>>       #include <cpuid.h>
>> @@ -2875,6 +2876,7 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>>     '''), error_message: 'AVX2 not available').allowed())
>>   
>>   config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>> +  .enable_auto_if(get_option('x86_version') >= '4') \
>>     .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
>>     .require(cc.links('''
>>       #include <cpuid.h>
> 
> I'm not sure this makes sense. The CONFIG_AVX* options are used only
> to validate whether the toolchain has support for this. The QEMU
> code then has a runtime, so it automagically uses AVX2/AVX512
> if-and-only-if running on a suitably new CPU.  IOW, we want this
> enabled always when the toolchain supports it, regardless of what
> x86_version is set.

Indeed.  To me this means they should not be configure options at all.
We should simply detect compiler support, end of.


r~


