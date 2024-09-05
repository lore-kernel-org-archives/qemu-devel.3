Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355F3CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm9yA-0006Mu-5h; Thu, 05 Sep 2024 06:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9y4-000677-95
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:44:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9y2-0002Xb-IN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:43:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42c7856ed66so4511785e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725533037; x=1726137837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrbQqfUY48kCO6crhKAl4HYo3Clzej3RS2nXxen4eb8=;
 b=aXM1JEJcNdNDG3mDGd1dOkpfVmpw+ZzLhuXe0SnhR5ikkGf8f89bXqPY+nzFWClcoD
 dEjp58J6f6MJXBxqKVBdHwXqIt4GGu8BiEPApc2GTyCrtL0w5OFkvLqZUiAe3xnDdBLi
 IrfB2vE8nD08C7bDvesup1irY5fHwlxdqkBz/2stwjfzaYuv7VLOkBYRB59uxylEW1H/
 +BrM95z4D9G3VlqUyM6hm4FCXE78VhmCE197r+1zX/0Mk5obr0zHx0IUM8nUnLQLH/xu
 ntz7y4nVPMojdCg0BpxDqMypm1STpomHwE7yf1lSGLUPoB3J0WZxv6FK9es63c67lqyY
 dpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725533037; x=1726137837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrbQqfUY48kCO6crhKAl4HYo3Clzej3RS2nXxen4eb8=;
 b=pDdIoMAtek07jy/wCu/TMjn04+vlAYVzidOWa5NUPhnL2XX0c7Ik8Vq0iQYkHFGaFu
 IEfEO0WDebRj7J9LVOaw45g0puM+cpevdFYxlPL76vON7KfzXwCxItXfXGH1MoxIgKno
 VY5VTi/n6RCP04sgJtb2lP764KR3j5nNg4dSXcJjjs7AEaJgHSr+yzZmP7Mu45PqLVtS
 X7nwmbPdG/D8CjSYMY4Jzlly1ouw2oQ8PbrHscy9NueYGMVqapHGJEGAf9coeHLJCPT7
 fSfWffRvLp9GB3gqF6tpv4SPTvs7ouTdVY59WM2vQ6CTMFpcgjAdLBYiFXJKg55MjyhZ
 rPVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ+RVbOpVYYNeKOsv861hD2OSMaOGDOYCVTU6BOKjoYZja/O0MKpIDJ3vYw0G1y0EGsFyVy6MG8sr1@nongnu.org
X-Gm-Message-State: AOJu0Yx0QAUv7NOzed9kybrIh9DBU4d+88H30StX+e71a93unR1Y9fyM
 n4pBLWRDOpIm9f0c12Lrz0VQfsgEIknwp03tT2cpkX+pJ0ZnaF7A6/nEFW3N/3I=
X-Google-Smtp-Source: AGHT+IGGz6f3sv6y5YyJ0jOk1jDJSOGkuNdHh5x7ql5M78ncuftSceqpxH1uPI3aXH6xiHEnyBiuzw==
X-Received: by 2002:a05:600c:3145:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-42bb27a9c67mr157945585e9.26.1725533036761; 
 Thu, 05 Sep 2024 03:43:56 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a4dsm227837155e9.12.2024.09.05.03.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:43:56 -0700 (PDT)
Message-ID: <ef8680d6-3a74-46e0-9bc9-d5d12c9ee88c@linaro.org>
Date: Thu, 5 Sep 2024 12:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] seccomp: Remove check for CRIS host
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-16-philmd@linaro.org>
 <c254b667-2a47-4e6d-9a3e-79318ffa6792@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c254b667-2a47-4e6d-9a3e-79318ffa6792@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/9/24 09:48, Paolo Bonzini wrote:
> On 9/4/24 16:36, Philippe Mathieu-Daudé wrote:
>> As per the deprecation notice in commit c7bbef4023:
>>
>>    The CRIS architecture was pulled from Linux in 4.17 and
>>    the compiler is no longer packaged in any distro [...].
>>
>> It is now unlikely QEMU is build on CRIS host.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   system/qemu-seccomp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
>> index 98ffce075c..a14a0c0635 100644
>> --- a/system/qemu-seccomp.c
>> +++ b/system/qemu-seccomp.c
>> @@ -50,7 +50,7 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
>>    * See 'NOTES' in 'man 2 clone' - s390 & cross have 'flags' in
>>    *  different position to other architectures
> 
> Small nit, "cross" is a misspelling of "cris" so
> 
> s/& cross //

Funny :)

> 
> No need to repost, of course.

I'll correct, thanks.

> 
> Paolo


