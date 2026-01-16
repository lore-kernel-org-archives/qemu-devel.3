Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991F5D47CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggyB-0005oZ-2F; Fri, 16 Jan 2026 05:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggxR-0005jL-AE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:21:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggxP-0004qM-1A
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:21:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so18001215e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768558889; x=1769163689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRCzJ1T/ii3BQ4yYHUykbzhUcAB2CL1japuElVPuk5U=;
 b=fa35RRk0bYIt0oOn2jA7U1JbntIYV53FxOpq0FY/EwBGwVkF5DS/YokKfYwNektDc/
 /EQrxaADHQZj/KJWzZeqpbSXUrKtxjKxD9IakOxvqDlcvkvcsAoyocgYZ/kfaf/2ykqT
 /O+cwxqedBfol/Ov8ACe2vdDFErjC6Qts3qbLAAFukqZ9tYWl4e4fULks5PkUBT78fb7
 d9e4Ewg7UbXi2Mr/Z9Bdth5FWa/qPF3U9ZDb2QjbOuwjg+3RW6bYOYYThVT1EC9hqK6n
 +X3rX68nifxg7dRGdkueOwUVWMPo5y+qVlKy0fEwWm+ca1svK/Vw9gjvHAfRynZRUgFx
 vmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558889; x=1769163689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRCzJ1T/ii3BQ4yYHUykbzhUcAB2CL1japuElVPuk5U=;
 b=RItOFpO1Cl67SPffLxsJ/Y/XVZXMziyTMHlV/FO253q6qBnVmh7UWu3sD1oyQe5Pf4
 N5gMmfIdERkc+EreXNqSNqpQWa1Xo+ZnPw0fuj9U6AAbLX8TVk2QutR38vWtsORUQtNZ
 NiXy3MM33l8FQnu6onLKFvWlhBrtm53bTdjslIP8R4E9jhOUDuh641ROv1x+QXa3g/bY
 IRLgAenTtNMtz4q/+tqujjifyPZk09I3zC5YIm117LOBFt++RB4CZrbOg5+qVvYsXgl5
 AvTlNuJno/PpnsB1f0aSz4mvMJp6k+jQMtf8Hgco6PTolPFN8FPnkC2ksQto21EVGbf6
 Amtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwVIvjB4AMHhC19gBjTIWsX37IYZm5u/MRAKZ/fgHyAHEO/XnC4068O0ycfIWUOwpq3BqxETLQZCxN@nongnu.org
X-Gm-Message-State: AOJu0YyHVNAoJdMvwBr34ljKJ0e2B8CBy0gZ+tUe7/j31NN24obCY6Ng
 5nOMjdRr84FtS6OAyTvI9rn9kkAtUxx6iLFH7rOTXm3H4hPMjkpr6OPFLXq7viSJgHU=
X-Gm-Gg: AY/fxX5UG4gkafWAb1RK0C2uPRYS/zUdM4moG3mxUHLwwt/01bg/8BeJYCsjsHf3Tjk
 Tr6jOv+wmeaVFYl9d7q9TWStoKV6girdhs+3Cp5Wq2uCQC8smgH/Bfij4byGPi5lUFVKOWLKqXX
 14JSCkisuHuudd8aPVGT/R7Q92JglfYtmPGd8GB71uNjftGSAcCnylYR6FCQyMmDzqC69XJGVQA
 q8qFuFXwJFdD9ZAsaYHR9/mQknD+pjAuAepNFXGtOFHufJBiJqprKS0FMPSBhBtfqEqW59DTN24
 bAenqgyowtxAIekZ5yKLtO8LSaO32PrwM2LtlJdiHj85mZrhtyBF41GVEiGk9DprBV15t3rPgut
 LzlZhRwAFpV05zYmhbnUhfgB5CiQW6He7B+9bk+OrCHBcEMfFDcl3p4zc+Mn62DuAN+00QEsT+C
 +RmuODPm6Ketle7vlokdM9NSoZxo6g/jDovAPW7gUHRRxQbertQ93+Mw==
X-Received: by 2002:a05:600c:548d:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-4801e2a4c3bmr33809425e9.0.1768558889126; 
 Fri, 16 Jan 2026 02:21:29 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dadbsm4338360f8f.21.2026.01.16.02.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:21:28 -0800 (PST)
Message-ID: <902e0196-b5f0-4222-a8b7-b98b8fc0a66f@linaro.org>
Date: Fri, 16 Jan 2026 11:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add docs/system/i386/ to the general x86
 architecture section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
References: <20260116101139.269906-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116101139.269906-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/1/26 11:11, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got a section for generic x86 architecture support in our
> MAINTAINERS file - this should cover the docs/system/i386/ folder, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

