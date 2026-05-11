Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA2CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNpk-0000Za-QO; Mon, 11 May 2026 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNpf-0000ZG-Rm
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:25:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNpd-0006Qf-47
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:25:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so48386735e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495147; x=1779099947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwh6RR2xmgbyF9jZrkLMkhH7J5G23yhANwIz3X8uA4o=;
 b=P09lN70HV2kalOm7JdbubeIOYGmcw3oICZaQwW4yEbBjm1zuR3MBRwEcAX434p0pfd
 hUtrbDl6I/js5Mn2HZpC4JUMqlIJfjw5uF9kPWRLmAj6a422VBnMeQh8aJX/jlOqYMx1
 GIssvw6eh1ozrsUX0OxiMSUb8H2/IoED7cetDhHVQ1yzWgVhKLd67ht0/9VjEUJ4Sw6Y
 FcCTzMVirmxK3UZbpX62yk3U9aPokMxt2SD9LVRlq1pSoDq+89LIWok6Y+wVprNTVHM9
 YqnX9CBbRskx4dOgE1L6lwC0TNLANMM/O1ZFQrW/irjwbF30JIzf4xB6NbNf2RWIumbP
 sv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495147; x=1779099947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwh6RR2xmgbyF9jZrkLMkhH7J5G23yhANwIz3X8uA4o=;
 b=jgaOt4fxEOAIbTYyIHXhYPl7n4FGLX2YXEQ/E2FmzAb4fjvRz/dtM+ncPDyHtXU3F+
 LCr9hxl1R+meYTk0jIZ0IlIgtUPlpwHtnq3gsnn5qNvmcCHBGJEu9DiZQSGns0/acQpM
 Wpa8cg2Gtv7A1pR+te2iwkPWi10cAhvIW+nn7qcdeOTI8YHvNKXly8FDmQ535z3b1Qs+
 e13RgZs2fIud4xOe1O86sbKzl9u27q5TKZ9RKspwRGmGoSI3xsuMyGk10u0OJCxeNKJw
 fkQyFLVTfAJ64CveZJ/UxrmbGwHMkf0z49nryeJszqaSpmaXGkxh/yC9Wf86IYEucCub
 UaaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d7BnoFgkeJfaYtvjXIKj5n/dtcGLQdk/DYGjCwXOiDO6foFcyb7qvvYH08UBJ5QBNTcby3rYDbC0k@nongnu.org
X-Gm-Message-State: AOJu0YwcQBylyGApMwoT/iv1Nr2y6hRaDhF+2gfirFuef3M5JhyzeTd/
 +YTF+LYcziLE1h8yi4BI4FfwIq7A9I4fMWuBQz2Zdl4HirZxHhnqbc8vXOEizNDwU6g=
X-Gm-Gg: Acq92OENRuTiRqSIjSze1sR1v0aHPAdZ7XJ0ZC7B1zwa3Zw7eLvoPXpAKfgcAcIQS4f
 oCZM1Nuggx1b0DZjvxQ7aERFOdFxjchjYUooZrbGbERwiYUS4+ut9LfHlGwcuepLNKvU57moRli
 FGlt71x7Uxv26be07BrjV5oBzi1smSga97cycjm3ESmr469/3X+RPwDVfrZtZQLpOOxx/zcoOZV
 czO0tqk6q06zlo9VfoIDFD3IPB1+f4Rz8fiZ4yiakgn+60niBBBOaJqJTVRuRKkDcmuc2A8qLS+
 4SA3v+kvLBaSksahPUimBdsOL4uAz2QPGOFiWlAht4m33eXnSH5ck14zO+6ffeqlFMN0LuQEjAE
 6RNVlBfhgXBEOjy4gPxirAXySrGSbzjVAfL0rgWuQMCrEwt4g5MkMyqE8AhRfGNGzudyfYsXvI2
 fjADb05c2x8zDrgblii+jOEXYsndsA3E+Y3ATROPL6c2pINq8cy8gxSIcoSMAPReJ30A==
X-Received: by 2002:a05:600c:8286:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48e706ad01emr149093675e9.2.1778495146858; 
 Mon, 11 May 2026 03:25:46 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6963sm60290305e9.4.2026.05.11.03.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:25:46 -0700 (PDT)
Message-ID: <f675c45b-c80d-409b-abc8-0f38c9217696@linaro.org>
Date: Mon, 11 May 2026 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] qom/object: initialize type_table in static ctor
 with fundamental QOM types
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260509005453.3984184-3-pierrick.bouvier@oss.qualcomm.com>
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

On 9/5/26 02:54, Pierrick Bouvier wrote:
> This saves us having to check if it's initialized everytime we have to
> access it. No other QOM type should be initialized or accessed during
> static ctor calls, so we don't depend on their ordering.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   qom/object.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

