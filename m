Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 15:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruwNg-0000z0-8l; Thu, 11 Apr 2024 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruwNS-0000wm-I5
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:30:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruwNP-00038t-0D
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:30:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-416f04059beso13014805e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712849407; x=1713454207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3mQDA1lVhn33mVR2p37ICZPVVf5Pe6RXSuChnMJ9zg=;
 b=LYc6aY/7zuJ5xb/E0dzg47hXh1PCQyDw+popzA/BD2Z8Em+HFZR4vWT+/CWZ1tT0cF
 Ts/En76tQABdczHuT0Mtor1WelbW220EeLUN/TeNs/Bwj8gCfXzb4rHm8TxKB23pq3V8
 nylFREjBgYmdVg0uwU05bYPqNu5my3T8c/WGuK4LlyQyJSzjaqKR9I5L18Skh8pYQVRi
 6TWTEK1shVy4y6219xCa2HuF3UHxBY1+YjAli3zqv9RwHO+idHsyb9YCKo133Z2ZKKoJ
 Hgr9osHGMD//rUKhYFz+6uVDgaREVfEnNvzYg3YEsPC8CAvjP9ncxfPa2oshIhusmJDq
 VlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712849407; x=1713454207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3mQDA1lVhn33mVR2p37ICZPVVf5Pe6RXSuChnMJ9zg=;
 b=GwJBzEcDcXEhxxKrcXyxcDVLF5sPe3+oe0ewiHOwDMDxoOlb/9JjFvz6k9VlDmleiR
 NEK58WSaet7NcL1Vulc1M3iIolRIgvjLPVS1plkjW5ySdZUMLzuoIu7J3x6fbEVlaxyz
 9u3b/hw8Jbxn19l/WNhODPssC61WKC2jHpuDguO5GImY5Jpym3F7KjUNblATpwBgo9DA
 woJ1HfPFw64SwlVtfIdIGpUy/xdUc91Hk4jUWb3svB7tA5zb7io6lNcCw2hMTWSDlVyi
 KfF51UmmxSzUC1zFeaResSZjmcMCzu3VGG88abyZeVh5/x1bmTWJ/OISv40xhwHKDuQ9
 t5Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUErCY+HYHWU2g/QSqCJ6yHdqA6AtjbOApF3CRh+pxT1taah25ZeQVjTTf2ms4sgK9kkazTs/VYwHP5GK/kZnL77/9b34U=
X-Gm-Message-State: AOJu0YyFuSOSYVAC3qFcIq8P8Ui08lRLkUi0maAtfIRM9GcNDpbEtLmd
 YtFY9aoKzsVXXTYO/iiVEwgonxesZQfhBnpe+WUI6w0yOUQZ+de//XFCiwN6cCk=
X-Google-Smtp-Source: AGHT+IFWufK52yqFdFLWNuFm9dDJ6tgkRpQE93IVuUX2CsDbXcmxVUNW80FOvP2UcwLwR5JDtVmMIQ==
X-Received: by 2002:a05:600c:524c:b0:416:902e:51ae with SMTP id
 fc12-20020a05600c524c00b00416902e51aemr98773wmb.17.1712849407460; 
 Thu, 11 Apr 2024 08:30:07 -0700 (PDT)
Received: from [192.168.120.175] ([92.88.171.159])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c458700b00417e5b71188sm1174199wmo.34.2024.04.11.08.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 08:30:07 -0700 (PDT)
Message-ID: <fb8c5aa0-d412-4ac0-b77b-64816d72a996@linaro.org>
Date: Thu, 11 Apr 2024 17:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: fix use of -j without an argument
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, martin@geanix.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Martin_Hundeb=C3=B8ll?=
 <martin@geanix.com>
References: <99185cfa61404dfa019a5e2c292b928791e85af5.1712848167.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <99185cfa61404dfa019a5e2c292b928791e85af5.1712848167.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Matheus,

On 11/4/24 17:09, Matheus Tavares Bernardino wrote:
> Our Makefile massages the given make arguments to invoke ninja
> accordingly. One key difference is that ninja will parallelize by
> default, whereas make only does so with -j<n> or -j. The make man page
> says that "if the -j option is given without an argument, make will not
> limit the number of jobs that can run simultaneously". We use to support
> that by replacing -j with "" (empty string) when calling ninja, so that
> it would do its auto-parallelization based on the number of CPU cores.
> 
> This was accidentally broken at d1ce2cc95b (Makefile: preserve
> --jobserver-auth argument when calling ninja, 2024-04-02),
> causing `make -j` to fail:
> 
> $ make -j V=1
>    /usr/bin/ninja -v   -j -d keepdepfile all | cat
>    make  -C contrib/plugins/ V="1" TARGET_DIR="contrib/plugins/" all
>    ninja: fatal: invalid -j parameter
>    make: *** [Makefile:161: run-ninja] Error
> 
> Let's fix that and indent the touched code for better readability.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>   Makefile | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 183756018f..d299c14dab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -142,8 +142,12 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
>   MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
>   MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
>   NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
> -        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
> -        -d keepdepfile
> +        $(if $(filter -j, $(MAKEFLAGS)) \
> +	     ,, \
> +	     $(or \
> +	          $(filter -l% -j%, $(MAKEFLAGS)), \
> +	          $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
> +        ) -d keepdepfile
>   ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
>   ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
>   

Apparently Martin sent the same patch (although not as nicely
indented) and Paolo queued it:
https://lore.kernel.org/qemu-devel/20240402081738.1051560-1-martin@geanix.com/

