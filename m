Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFDEF4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdEm-0005nw-Qp; Mon, 09 Mar 2026 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdEY-0005hJ-PV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:13:35 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzdEU-0003E8-Q0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:13:29 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cd78a4ce8dso284092185a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773072804; x=1773677604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7O1YmVBKQSbKuye85PKpFrzki5GX1cfaXcqqCjfRgQc=;
 b=e4NRdPHksazy+fcsDwc0NcVZg44bgc5SvnHzTLrMUW4DCq5Nf5yy380hjbLPGJKtli
 o7NBGwqnOh9dYeaTyUtyEwmz/We7QbMIF8d1UDJu/ut6cWpRAC72jInGGHoCieSiX1gH
 fDVTtiMztNSouPZNMvMePbozEmWbR+D5/MgmncSsRhfa6FuGgP6zYX/ewtpa95dPuC1v
 2tUOEWPcvrPnXewii3zzb7WhzB8vUNo3fzL1SJCmD5iXSKqLDggJDs3X3gREs9T7qSIR
 NBUxJi/IBDXRby7iXRDNW68d5qtdgdhgFmQE48SaAlozLGHINzQXleLP73/hUjnuQjSJ
 LAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072804; x=1773677604;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7O1YmVBKQSbKuye85PKpFrzki5GX1cfaXcqqCjfRgQc=;
 b=TYLcUUbcJ7r+2/WpTIbLdJPAT3BWrwrL2KzrvG04Tm1N92MycCma096tkUVTcTPqpE
 z1fwU3U56c10MMEBSy7dDYifk5fTpX0vz9E8fVXKdAWFOL3/q71r1AFDazAAY7uKDH+z
 MCMUIFHtLscfGHfIipV+Q3izuT9YTOlzKHM5XwQRr6NNWx3gE4VNY096SSCAvY3n0GqY
 tV+lcE4A7ZykRl1OUjZEiJ5ELmACEqEhZwsQxlQgTFVETlXn69+66h0knUoTr4Y1BLKA
 EWHXZ6Xgf24uGh+B/QOwwvJifzPjUp137pxOlTYbh7kTpBtkNIpS6q4BVOmL9hPb6ES/
 ckCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNkLI1BHsVu+I3X97K+Wc4Cedyeo0UUz2MkfG3oJxIS9NLZrF6rBq0YapvTETm8KsBlzq11I3Xq/0p@nongnu.org
X-Gm-Message-State: AOJu0Yxk2gSGuuK68sRNJC5nm0YLjGpsrGNk8lAu7IiBHVa+F2/wO9xH
 RE6wwx8N6SK72HcaJH5psVgVqhHn1Nc17Lqaj2yVmjZFhyljD5ikqR4UufBn0Bi6tVLFNVmGLV3
 IArW1
X-Gm-Gg: ATEYQzysU9i+62bQx/fufq9nVMJavnEaq15ch73G6l5kpUWf7OAdIAOFe73pNgzm6gz
 wo7tgvqMKT2G67uLWZiSaDk039ylHrvyeol169CtzllZRRNbXkdNtNCvacZ1CcNh3jweoOHhSc+
 V4yCvOAJc4Vn6OclFeaE5yhl68jIO5Do8GrTcEonsCF+uO9iDmMl4tF3bCBE5J5kY/exvXufePA
 12pTJ+MydwKkoN2bfeOWyo7coxpR8fuiFQ9K79iyLYiFYqtYoA/Blzt9E/sYlns8BJRvxPDoL1S
 EjZ2/0gsU94qMmMK8gJjlKb/b3DR0QKHeMYzPqKyaN5yjzL3icyViMlMS8PhUlvMtq0Z3FJfMWX
 GISroonY0kyCZ2C8IF4HW+bQMXYwthOTv3OQhv7LeqbIjWcO+AFeXwLb47l7tQmOpZ+hIpt5cH3
 mx9U0r3mCY60cXfAszQJtbcscxOOFpzgyYX0r44gt1+7Z5y+YDagHavu/Q4yhe3NubnZJi
X-Received: by 2002:a05:620a:4093:b0:8cb:3505:443c with SMTP id
 af79cd13be357-8cd6d4b4e32mr1564705385a.44.1773072804254; 
 Mon, 09 Mar 2026 09:13:24 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd7ea02664sm393044385a.5.2026.03.09.09.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 09:13:23 -0700 (PDT)
Message-ID: <3fadb61d-1a70-4bff-b019-d2c47573fa68@linaro.org>
Date: Mon, 9 Mar 2026 09:13:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Check if file is NULL
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x729.google.com
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

On 3/6/26 7:22 PM, Akihiko Odaki wrote:
> The file pointer can be NULL when e.g., opening the file failed.
> vcpu_interval_exec() already implements a NULL-pointer check, but
> plugin_exit() misses it. Handle the condition by adding the missing
> check to plugin_exit().
> 
> Fixes: 0d279bec0f14 ("contrib/plugins: Add a plugin to generate basic block vectors")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   contrib/plugins/bbv.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

This was merged into master (a8ff516c2f5ec05fb8b8bf4bceb88f49701f80d6).
Thank you for your contribution!

Regards,
Pierrick

