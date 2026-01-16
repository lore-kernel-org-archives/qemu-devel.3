Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ECFC79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkUx-00049v-7P; Fri, 16 Jan 2026 09:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkUv-00049Q-Ks
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgkUs-0005jG-O3
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so19924165e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768572496; x=1769177296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MlVhHj2fazwXQUvFAwPS57eaA6wBdf4bc+MmU9XWzyA=;
 b=x9G04d1+RyPUSoVhOoHSuOwHnZwN+7fVTYgPGEm5SYwZaby1ywZvzn1ArSUYXuH1f1
 Fs4/NYHrtsup+jKJahfyFcCVnY2KfboqsKz9ZeP999hvy4K3oDL693B66nb9VPbQbaO3
 7Ii8zxuRDg6lF8YMgQ2stxeex96eB/pyoJk1AE9ITMtQ46z1i8Cu/mCoiWgVzmn47bHs
 rnLPqH7itgtv1JhVC1Y7uPqPuH4hxCYzgvIBlbynzcfx8x9JnHYvQvoKnZlr5sMPHXc7
 HLOaLr5lpw94xgt57RrR23ivojz4ZJQ+1OpfEiiI6o5FzVc7iDWWT2wXEZ6es27QWlyf
 BGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768572496; x=1769177296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlVhHj2fazwXQUvFAwPS57eaA6wBdf4bc+MmU9XWzyA=;
 b=FyfMCviYIfCp8cVsSRi5Ry6LKZQnORmY7g0T+u4OoORmgEUcib3U0pMR8nQHn3JcB7
 llWMjOqhFvxKO2oELG2hAUgaUtz2hwujrF0iXssUEjETAqBXaBFHbSO1ZjVZBX47+Ca9
 qAThJ5W3YgwtavbJtH1ZxqepRAqLCy1katdKaEu0sijm0aK4a8j86+8slUbKeUKy5ZOO
 gIAoO1wXfI7K3QAzSa4waj7ubAP27pd14lkemQD3z2RPPDfFrUYQopoOzVF4GWgD6NHn
 zVnZp8GtotoWaU2YDnhYvMpeEJhOzp98S8ILRQE03fJB5bOYbqdre9w5+9w9ne4INyaf
 K2dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzauSmvk+5t8XmuALyw2QTfJDdG+mWQjS4w8L8emUocwZEzfIN63RuBT4l/p7qj3dijzhIAxlt1qOS@nongnu.org
X-Gm-Message-State: AOJu0YxF/+JyB6eQR+lkonUwdl2tO+8AgZ3RtcrOucTf3dpUc9XUNIOV
 cv7rYqbQd4D3/u6SwUYLq9QHf8rnaN+pG7wPBO67aS0g3JPNkL5aTtTLr81v0/TW4f0=
X-Gm-Gg: AY/fxX4Nszb1bN1Wc8RO0Z9uNUlvO8u2C4FORuZ7elVemLQUhVBmjmx0y6/XJqicsCT
 6VkMcMyZFrD3KC8d0wNfIAuXQ0VTaLwo9UzL5gNUEbMTSDoRFCO5ioYCTm2aoLLDIT2w36WUOV/
 BhZ3F2V7iMk/71dSGFr4hDLBPVoBvyzaN8FM7FLO/dRsA7HyCaqE5EA0VCsuP6s3LlAyISmCz/t
 wCvNh0PpBF7896ok4VNybongECiSDcljXpUniwCjzFKTUzxA9lOBEkybD0nWohZbYX/zeixaqF/
 yrERI+smcmJESD6Q7MDDTZfxte2JTYW3KwNgu1j9qMpNT3ezy2zL+T4aNIROl0VOh8mX10EgbHg
 fTvHY5ZDL7wUOpaNggxF9Vgq/3PSAj1a0vul46pi/X5yFrTltNz0a5PwD1/ndcxGqqpTPvIojla
 0lxl2KqAIwqFoLpIPM8dnw/m7OwDdYNJjZzuWiTf6NjJiPdLxYL0LBVkPwbfBJKp/R
X-Received: by 2002:a05:600c:4ed3:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-4801e3397d6mr38910535e9.19.1768572496131; 
 Fri, 16 Jan 2026 06:08:16 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48020312253sm16187565e9.14.2026.01.16.06.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 06:08:15 -0800 (PST)
Message-ID: <c84ed056-6ba6-4a00-a493-94fa9f13170a@linaro.org>
Date: Fri, 16 Jan 2026 15:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/26] whpx: Move around files before introducing
 AArch64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-10-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Mohamed,

On 16/1/26 14:52, Mohamed Mediouni wrote:
> Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS                                           | 2 ++
>   accel/meson.build                                     | 1 +
>   accel/whpx/meson.build                                | 6 ++++++
>   {target/i386 => accel}/whpx/whpx-accel-ops.c          | 4 ++--
>   {target/i386/whpx => include/system}/whpx-accel-ops.h | 4 ++--
>   {target/i386/whpx => include/system}/whpx-internal.h  | 6 ++++--
>   target/i386/whpx/meson.build                          | 1 -
>   target/i386/whpx/whpx-all.c                           | 4 ++--
>   target/i386/whpx/whpx-apic.c                          | 2 +-
>   9 files changed, 20 insertions(+), 10 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
>   rename {target/i386/whpx => include/system}/whpx-internal.h (97%)

Just wondering, could we have target/i386/whpx/whpx-internal.h moved
to accel/whpx/whpx-internal.h? (can be done on top in another patch)

