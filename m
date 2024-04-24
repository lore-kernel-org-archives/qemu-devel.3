Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9796C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbOB-0005jP-5A; Wed, 24 Apr 2024 08:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbO2-0005ga-Oj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:06:06 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzbNz-0007ni-Lr
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:06:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso69129041fa.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713960361; x=1714565161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=32OruVyMEETlnr+WqAK9GtUb7luKkD4iuTcnACcSEj8=;
 b=Z5rmXxOtSFQmNN12jx1S8l5FS1vQ/qxDkmJ0UVVdqgIiutvhq4eKpOs4gtBcbmvUmT
 /ao+81Vdlghox5i4nzDALKHCHfuLviU8tPkckG8WyCMres1zSD+j19X5OeMMOlEpxKI2
 rpgmGsr5xQwYKUffIHQMsYKiiGaFb3rQG1irn+MCb4mcimlpQ6w7FVOKHjG+DIaQXd8w
 FgEg79uh1j66BADViiZ1yJk/3W0dILZ4qgxhMfezoC4p3Swn5EjL/jP7wxZZ1i4GWAPC
 IJyFBJ4NzrM5tKB8mQtNNGl05ZSploaFsYQJeYy7X5nH3JzgiVE14xsY15khy6f6iFOw
 l1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713960361; x=1714565161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=32OruVyMEETlnr+WqAK9GtUb7luKkD4iuTcnACcSEj8=;
 b=X5Ko6E/78Lg0ueSY7Os3xsfZNXFWMUBH1SEIfEr2624fVWdyuw00e07WHzeHqVmoOu
 ymebIwbKXwwGGfH9cw/dngqWQt9Kq4ONnQiJ+pZlDIMl8gNydTebNp1DJ/TY7N65FNTc
 xpRJ+QdeAyWphoHkgeC7YgO1/Tdh9YPoMDjjMY5hK3d2AMyETHOPQ+6kdzab+gk8V7ty
 UtoEa5hc245UlD7b0LYnDpVHrlO7PufQsU8fKl47Zkc1j9oW7w9dVz5tBHaAOlFBXao/
 /l9wLoW3sXDpJHf+1rt60/w+ckAVSzq3Aj0GMeSVLVZwCExnN7MEcyt8Ki8N8/5kU9Dy
 Wphw==
X-Gm-Message-State: AOJu0YwvtNYmiATQfsOyb+cDNPNq0dgjOUGAPOgFwDbJ19WgpdITHdLj
 xILz+m/kurti0myNw/h5ZRtx7LUor/gNTgjqP9VW/XjJojEc5W49sE83KZR0APE=
X-Google-Smtp-Source: AGHT+IGmmc9aaahY1qtddTzlvw9VNMKuof9sHlQT2Bnitb0bNSxIWUoyI0neUZ+iZ5qov94Jl+6R5A==
X-Received: by 2002:a2e:80d0:0:b0:2da:46ca:25ad with SMTP id
 r16-20020a2e80d0000000b002da46ca25admr1445777ljg.44.1713960361279; 
 Wed, 24 Apr 2024 05:06:01 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 m25-20020a05600c3b1900b0041816c3049csm23744395wms.11.2024.04.24.05.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 05:06:00 -0700 (PDT)
Message-ID: <203b7099-9eff-481a-a287-575de4515549@linaro.org>
Date: Wed, 24 Apr 2024 14:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
 cpu-apic.c
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, "Dr . David Alan Gilbert"
 <dave@treblig.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-4-philmd@linaro.org> <ZijCLxqNPFqXSycf@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZijCLxqNPFqXSycf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/4/24 10:26, Zhao Liu wrote:
> On Thu, Mar 21, 2024 at 04:48:19PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Thu, 21 Mar 2024 16:48:19 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
>>   cpu-apic.c
>> X-Mailer: git-send-email 2.41.0
>>
>> Move APIC related code split in cpu-sysemu.c and
>> monitor.c to cpu-apic.c.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/cpu-apic.c   | 112 +++++++++++++++++++++++++++++++++++++++
>>   target/i386/cpu-sysemu.c |  77 ---------------------------
>>   target/i386/monitor.c    |  25 ---------
>>   target/i386/meson.build  |   1 +
>>   4 files changed, 113 insertions(+), 102 deletions(-)
>>   create mode 100644 target/i386/cpu-apic.c
>>
>> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
>> new file mode 100644
>> index 0000000000..d397ec94dc
>> --- /dev/null
>> +++ b/target/i386/cpu-apic.c
> 
> Nit: New file needs a MAINTAINER entry ;-).

Already covered here:

X86 general architecture support
M: Paolo Bonzini <pbonzini@redhat.com>
S: Maintained
F: configs/devices/i386-softmmu/default.mak
F: configs/targets/i386-softmmu.mak
F: configs/targets/x86_64-softmmu.mak
F: docs/system/target-i386*
F: target/i386/*.[ch]
                ^^^^^^
$ ./scripts/get_maintainer.pl -f target/i386/cpu-apic.c
Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 general archi...)
qemu-devel@nongnu.org (open list:All patches CC here)

> Others LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!


