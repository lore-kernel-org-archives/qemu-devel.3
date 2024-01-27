Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D46C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaQ8-0001ST-Kj; Fri, 26 Jan 2024 23:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaQ7-0001SL-EP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:35:55 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaQ5-0007Ce-VK
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:35:55 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ddfb0dac4dso854145b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330152; x=1706934952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=shTdkC4W3Gdz3eYDZQR+AiYpDt8tUgheNJridnlUqZ8=;
 b=GoDNli1yJnEk2ogGK7x7epiRZ0Xf7yAlkgrju1hxr56uveX/6kanG1LYQICZ1XJyqO
 DYmKQG6vKhQqyknichB/JcXj9Ogc7zfWaWo0vBvGna+UrbYGulnTPNwJ/jlhcDQfRqIt
 YhAQbRaklr+3JMmJ4PUA1wWqjRtac/0DhFi5qekeo+3QJ1rUfyJ/rUDvMmwqK6fPBUD9
 fUyOqJ28sTT/2jfEBEaka4H9Ld9N029KqJfLp3tx6w626ZD6DeRTu2v+0B3ZjcPShPIO
 d2zTtmhH3dn56TXQ/VP2xRoFUySExNCHgEiJP+1Usjm0+34nKA81ovcCc7Ubv5n1iHHd
 5hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330152; x=1706934952;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shTdkC4W3Gdz3eYDZQR+AiYpDt8tUgheNJridnlUqZ8=;
 b=IDBiCJBmSe6gYCkUpNJ88Pg4TuEMHQrKBeY9E520JpK5U4wLzGdHyoWHURApXVorLJ
 iDEW66qv0wYdLzgThdCyvCrDhmOPiWF0BghwxomiJcB5OMBZQgoWtgJGKZ79it4ZytZq
 qnP/DttV2EgS+QI9q6T7Y7JF6Spjxr3WjlR3Hmx2v0+AS1lL0pYewq6dypxwdAb7qZaN
 wdvZmKLCAJvPCzymNWmrqWOUmcdkB6D/+pqRVaLqSGntsrT/GQVQWHZQe3RyAiP+4iqA
 j48J3ZrpOpSWaI+amWzfQ+U53OKasHkUwatUVISorV8CptBCYThyoA5uK4Hm/mWRJ81S
 Hw/g==
X-Gm-Message-State: AOJu0YxcRqk3LmeBC+MZdvEfTumzHWLAQjs1ScKsJ0+PuainjB8Wki50
 ToD62twAQifthtB/bKjR9WVC1WieQ1s1dRKNZRze6i7UE6nzusWzOUogy++S19o=
X-Google-Smtp-Source: AGHT+IG8QUQDQ4bziEP2khX1YCm1uoivwmFNgxpVwFSQe3h7jZojiGPnc8m4xaMvkBvt8BElE8e0PA==
X-Received: by 2002:a05:6a00:23cd:b0:6db:e165:56ea with SMTP id
 g13-20020a056a0023cd00b006dbe16556eamr1077218pfc.36.1706330152380; 
 Fri, 26 Jan 2024 20:35:52 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p30-20020aa79e9e000000b006ddd13c09c7sm1924769pfq.172.2024.01.26.20.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:35:52 -0800 (PST)
Message-ID: <d71a5956-a61b-4382-97f0-32f0af8e1254@linaro.org>
Date: Sat, 27 Jan 2024 14:35:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/23] target/mips: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/cpu.c                       | 11 +++-------
>   target/mips/gdbstub.c                   |  6 ++----
>   target/mips/kvm.c                       | 27 +++++++++----------------
>   target/mips/sysemu/physaddr.c           |  3 +--
>   target/mips/tcg/exception.c             |  3 +--
>   target/mips/tcg/op_helper.c             |  3 +--
>   target/mips/tcg/sysemu/special_helper.c |  3 +--
>   target/mips/tcg/sysemu/tlb_helper.c     |  6 ++----
>   target/mips/tcg/translate.c             |  3 +--
>   9 files changed, 21 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

