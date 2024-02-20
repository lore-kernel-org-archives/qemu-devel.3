Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D691EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSGt-0003SG-8x; Tue, 20 Feb 2024 10:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcSGr-0003Rv-C5
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:43:01 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcSGp-0001Hv-Ts
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:43:01 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so5142421a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708443777; x=1709048577; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZL3Sgj9rdKWGcfR1+vK6TRJqxclsMAS0sII131lN4c=;
 b=hNBlhNbtCGtTdASVXAIh3lVauJozM/rQTyoDjiv5NZM0ZMVxXuAhF6SXZkwEMnYlpo
 I/+GlBNVXY40toqm+asrUAXKEGNYEZuahpavrOjpyihsL2VtdHzQXD1AIe6NHfjaNIc/
 RywKQ4/HbAKqCkOe2iZXN6FoQrB1pT4Kvfk6IlM2iEdhYW3I0iszp8JdH5+sQantPuLz
 mwLUrPEhfTEIK32QImt9oVVF4KC06oOJHiw6zjJPPm7wWa/3mrSAYOX7qggLo5VLaHYI
 aKmJB30UKDrn1hwPasl1vLaeUQf4M2OjAyV4K6N6BoCsnztNVlLqnXQn83iv2yD5EiIY
 LgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708443777; x=1709048577;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZL3Sgj9rdKWGcfR1+vK6TRJqxclsMAS0sII131lN4c=;
 b=fGDNePby+UKJxHt9eHZP0wye4MzAJft2zBMf6CPCZcF1dIQks5woWmmvQ+qrXKdxZa
 W5gplZHKFh391JoA2c4iJy6v+Xl7/J4YMsSFdDaShpnDG/i/eoxYFqBR1AaA/OETbwyZ
 ue0exo7pxGm2FjNLB9yQfkZxpC1hyakX19NX3qJ2NT2zs2V+upb+gbGPe4+/FgudqvvP
 3lUo9b1FYvC6HOjJI+6LnJu9iKppkibaM3TvjlMzEuzm8uA3H7lr/7ZvBWG9kT4jik4+
 T7wxEBIw2MbM5qQvy1rADu+tKhxkLTSRBfx9lnpHYRTExE4NTHqLxa2pGrKSd+9ozjHg
 B+ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCURCANlsxbZqjdazoCjnUfwhec878T4oNodK0gBi9js7nbRdl1P3y3PDjAyYV/8ZYMujU4iEH/cZcnBV2/N9oTOD1ZKG8k=
X-Gm-Message-State: AOJu0YyU+ZjsvLicy9xG/GRGSuQ4uBv33/cgRmtvZqmWfH/+3+5wfqJP
 /eF3xxk7QhLoD9PQ9hnMxMHk9QZdApVwEEHiBVlV8Vt/SuksEf6as1Y/0o+gvB9Zpb1t9CAFiSV
 a
X-Google-Smtp-Source: AGHT+IHCJmwrV67EBkqxRAX80+SfKr0oFeKJROYa9BpJb8ZO3wXAq6ch8CpAz3Ep5SH+1Cx3YwA7lw==
X-Received: by 2002:a05:6a21:9102:b0:1a0:a1cb:d96c with SMTP id
 tn2-20020a056a21910200b001a0a1cbd96cmr5511174pzb.25.1708443777578; 
 Tue, 20 Feb 2024 07:42:57 -0800 (PST)
Received: from ?IPv6:2804:7f0:b400:1b59:1a6a:7944:fbd6:3f71?
 ([2804:7f0:b400:1b59:1a6a:7944:fbd6:3f71])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a62e912000000b006da96503d9fsm7032405pfh.109.2024.02.20.07.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 07:42:57 -0800 (PST)
Subject: Re: [PATCH v2 0/6] Add ivshmem-flat device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216144456.34992-1-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <1a92633c-8673-e0cb-0c0d-40f6d5450ab0@linaro.org>
Date: Tue, 20 Feb 2024 12:42:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.297,
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

Hi Phil,

On 2/16/24 11:44 AM, Philippe Mathieu-Daudé wrote:
> This is a respin of Gustavo's v1 [3].
> 
> Since v1:
> - Respin splitting controversial code in another patch
> - For minor changes see notes in patch #1
> 

Thanks for the respin/split!

I don't know if I should review it and you would send a v3; or
if I can take it and address the fixes needed myself and then
I post the v3. Please advise :)

Anyways, I have some comments about it, which I'll write
inline, per patch.


Cheers,
Gustavo
  


