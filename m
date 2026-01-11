Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28217D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej3A-0003oM-4g; Sat, 10 Jan 2026 19:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej30-0003kj-VF
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:10 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej2z-0008M9-J9
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:11:10 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c3259da34so3255228a91.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090268; x=1768695068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wq33Xm46Evb5FZy6ttQxo+QNYhDTn0yUStdEKL6Lab8=;
 b=Ll+o30XkhlHiVoIeN+6YWMmW7XSQpNWM9iYeN+Hl00V+5S3kmTScnYA3tUwaXt+JFg
 EHc32dqkw5kWSgIjXSjvIWyVZdjioga3dg2C+xyxid9LPn9wgSNo9YuyOlq8/L8/FBBe
 861ssbZZlru+wUqwH4MXsS9sJS1RNQIm2j54ngrXQWe5ozXPLG3GestOJChA8BAY29o3
 0iNNMVZQNbH+ATRVZJQejwmNZmv21vn0jcXda0+a1yt53FVVGQIv2ei79HYv6cV6CpWD
 wWgKSFqUKJGPFwNrnrsGRFO4MLaVccrzRoC/RO6JOlMkFZQiAkDRd18fHJSNFd2YLd3E
 nCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090268; x=1768695068;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wq33Xm46Evb5FZy6ttQxo+QNYhDTn0yUStdEKL6Lab8=;
 b=GAK1AdG+m8rmBeGWy2P60tGDQ6kYIUb76hhrPOw39d4LtXYKIh1qKYs+kZF/vkFIeh
 9QsIMub2QlH5T6O1Rs80VY7ssSwq6tX1zayWHRYOKXfvzxKCkq52Y5WAULG9RFkoTvLE
 7CTZoiEhmCjy9sUmnoYFprFYRSnPxm6VdibeGPVq4JwSyLRkg6NsrAG/0Jcjb5lBMEDf
 ULwpzxkHONamR8bbUHFOKE49FXoTQUE7N45Ai38rl4VgiqAMnK8wcqOJD1bPiHx6uRXW
 0807F8meGkI/OmbLld54z7rdtlqcFWG93pkxFjmM/ITK+Tvip2hJfDMO1n4uMdd16K3i
 8HpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnkUXOeBlNRBPprPwmdUDsegh+U4BJAH6kvh9EZ8lnRlSNfnNO1x1jHLATzM/r5onok9qfrFYz5sgt@nongnu.org
X-Gm-Message-State: AOJu0YzCFkvAXkYTDUjw7ge9oQP+3s7U9hBRlL0xzFop2bxd1TIpt7Jm
 XXjFE4+v6xJNI8gTIEnpEaZ/iewMJfmwLv2fntMD9jlQaeEz4//Y2EdqCVbc/CXM+XQ=
X-Gm-Gg: AY/fxX4lsDDnXHu+GDDiMsD3Xr8XYSvSCTCT7jqnx78K4dU+fr1l5ohmRwWFY844IH8
 LvJ6rZO+3UAAN0uf31kR33Fj4u1BJfr72roPvOMtIAaPIfB1pqEtYu37GvK/21KBV3KLWo/HEN1
 MvuV0JhLb7HS2lzMczyIPKiBokyAlnc9aAwPHe6M+qTanKZ5isxV1b+3gmuBAJ2MEaxtP+6NANX
 jusdhdAuP9kDYUdPtTihc92EyqLQLGqModMr67OXn3k0ZmWhXfYkgirc9MCaOazP6JPbnp4Itgc
 XxO1zIabba57mzXaiUQbJ5r7JKfbqqt36Toc5mp7IUmSPD3EX7unTvAteUrWiFs+eCAkBrKGJBL
 AQfgbh5Xq0L5A5fWEp2tcAHF60pveasX0ooS+hZOYdYd/VjDLSCmelSnPBQZEGQijSmbjcQ+4nW
 mpmt2FVe9e9wu4WUNKDKlC8m3nasCU3C/wpjjv
X-Google-Smtp-Source: AGHT+IF9AsgFSHabaJw4gNUKmmFoZOJgWeIviRyPsOuxV4xydlFHxtEzoeKanj4223gCcwolT+apwg==
X-Received: by 2002:a17:90b:3ec8:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-34f68cc250emr12192121a91.34.1768090268011; 
 Sat, 10 Jan 2026 16:11:08 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa78f71sm13624737a91.1.2026.01.10.16.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:11:07 -0800 (PST)
Message-ID: <5c5f8e4a-d8ba-4ad2-9566-cdbfcf833d53@linaro.org>
Date: Sun, 11 Jan 2026 11:11:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/hppa: Avoid target-specific migration headers
 in machine.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/8/26 07:07, Philippe Mathieu-Daudé wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header requiered:
> "migration/qemu-file-types.h" and "migration/vmstate.h", which
> are not target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

