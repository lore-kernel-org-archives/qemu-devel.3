Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC81D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCoU-0008Ax-Ag; Tue, 20 Jan 2026 09:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viCoJ-0007pv-Ss
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:34:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viCoH-0005Ph-Gl
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:34:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43591b55727so479193f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768919660; x=1769524460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8lELPTCmDPTukwPWPop6bWIYoAZEgubt8IpIxt/kG7A=;
 b=J7fWhSLUYkWOJ07DB+pcwalesX7cIXTmnYrA75j3g839CQB2gxs2KoKRcOGPSlcVOI
 dcNZbU2FMdnXnL5vcDYt2kNrzznWqYEXX4MKuhvEj3meJbCJQ743dOkl5XcBI7baBQkf
 DAucudXATD4FScXsKmnpsyiFVj56WtxOCtoqSdIIhgASQWXcsEfgmgAl5nbc7C1x8sLb
 FGhjfCLywJNXguUDh3UAufSJodg0g85ekp0e73m9tfOY+68vm5UKs1jD3UzQ/n/0wXO9
 zbiZSVgqTHiJsI3HFqbLGHDydTetWZ2XdflazSMVtjMRWKEd2o+P7TJ9f6tSpPptqP9J
 cv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919660; x=1769524460;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lELPTCmDPTukwPWPop6bWIYoAZEgubt8IpIxt/kG7A=;
 b=FH87SosFUk09eIqPyoiu+kyIEodkAts2S/fkCUpRRcRVZuRvpTml99tbOSQp9ZivmA
 WT5nhgunO6qxOFXKaw6IBO3lqlFQayVnPogrUEFlnE1yZzxRkp8HQCY+seqMEiZj93mN
 YB6j22DtSwQlkHJ3fzmDtcSG3oXirxk/qucVyGNtKDCgWzDKLGPRsFxbbQFcTjRk3CE8
 NPWkp/9lzlUsiOEFFRf8vXO2kpQZf2m4gzUpf85NZRNioN03yc8JsXlFSGLHXkt3fgrx
 xjByAKKH/X7OOYNxRbbq7MtfkX5e0BCqWrCglRzLyapn4ODMwGE5s2Mm1ZAiGR4+5nRc
 c9nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgPGuamgWSJrXTY8Cl+eaImrMD64IT1IIbxTNGXa1XQZjkOA8kJvTnk0eviDtUxgqaZCsncRHIEO2z@nongnu.org
X-Gm-Message-State: AOJu0Yza4xsQ8RHTMMluEE80hDPw5sHbTWXJu4EsSCgkaMpkPhm04RWy
 sPnWF9chngBQGeACQwtE9CyUt2AL+rGVa71giCiB6p5W6xgGWUFIt/PHKy+jUheGLmQ=
X-Gm-Gg: AZuq6aLu9jJF7R0yjFFvUk3YTS5DbeGFNk/v/YhmvdvIxOrgMi/I7Q7wAcNZTnhO1bI
 I6U9+kkQ4HtDvC103yOPj5cIXbRewmbRj/YSSG/8RihLreSLuyDkK80v8nWTJI1/Sn1mdzSazMn
 UNNTIWQUihg3Y+adYZop8Fv5SXF855kn7EZwEskF//ylRKicGxGAFrh/9O0gg4+tnhR8zU0xfa5
 8XFqbq6krqHsKi99aFqyZPDgVA52e+EtcZ5r5aX9i42IXWPIka1jggNmldQFAS3wJxiIZq+u2zC
 r43y3w92cDuih+TWZ9jv1xA15dS9vRaydGE66FWRRBwy47Hz+2i3KtJGI20jfcMZDr3GZxKeg6L
 ZzbxSdF3Y4hW0kndTsuvNM8jldR468S2lQ+UBqyaSKdbB5SMqAIKVT67zh5QWbCBZHUabFJHiXp
 U7vZO8sum0EJRMh0VMiguqpCQPOGoRqNTqxAOy5OE7bNKfxCkmIBck3A==
X-Received: by 2002:a05:6000:1a88:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-4356a082ee3mr20510545f8f.45.1768919659797; 
 Tue, 20 Jan 2026 06:34:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435924ae723sm3098956f8f.41.2026.01.20.06.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 06:34:19 -0800 (PST)
Message-ID: <e0488d99-0a4c-4902-b53a-d56981aae52b@linaro.org>
Date: Tue, 20 Jan 2026 15:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] system/physmem: Enhance the Address Space API
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116185814.108560-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 16/1/26 19:58, Gustavo Romero wrote:

> Gustavo Romero (3):
>    target/arm: Initialize AS 0 first
>    target/i386: Add a _MAX sentinel to X86ASIdx enum
>    target/arm: Add a _MAX sentinel to ARMASIdx enum

Series queued, thanks!

