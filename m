Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FCA103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5cm-0001nn-LB; Fri, 27 Feb 2026 16:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5cl-0001n7-2g
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:43:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5cj-0001qE-ME
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:43:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483487335c2so22355655e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228628; x=1772833428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4GElUo7cPe0zOvjD7MJREDBXlXeS9zIXimVpHPttlg=;
 b=TyIVvHmXiXiVoSYSkTZeNZ03uh3oj1gi3IM0dFUOOUooGPnb90cRkdfy3zan8aRxQr
 f0HwuA1dVTpuPxJMlPftiCHX5voGQ17iev/9lz5Az9yprsUCL38YXC3EmVfWGAG+wrni
 fNgQQlSNAMLWjPx2vu559UGjtk/gODKuO8hD4J8s3U8jO0p99BfUdIkzn94/qcfGddbp
 UZrMlWd9B3WhKImPseXv/IoAaXgL4fg7iCE25CY7rNZkU34zc6fUAQZRSmNri/9IbrFS
 5rBbnaAjll2dvgOzBTan9q4vFOJWHe+h6AekYqDWa/crK0o7AcPT6eFuJSrGKzmRqCgr
 g1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228628; x=1772833428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4GElUo7cPe0zOvjD7MJREDBXlXeS9zIXimVpHPttlg=;
 b=q4faMBbqY5zv948sj8kLxAKkouons+wZXnc4QDs8q2Hm4mX6xl5i8q+KjyalCIXxpQ
 z0HrnPoVePp5sUqpqZd/wY08tJTs3pjae22DhmXGK1iiCHF1aj2pFrjwes4Q0IZFBYym
 56SEW3tPcfJppPCXhunUCp4DwSvQsDMFWSQTtO+TI9PeMajV5V9x4PxncsumfXBKxzLY
 ZNK+UouArMUQL8dk6wEQav6fWMYFaZnDIgIPZRGUgO/er+KZu0Nlh2aQhKXmXrzBrohg
 DhKJIkkjeFTBpLYjVhyxWeJXbl2NCgDYOQ2feUcFMz3N5ggsC9dIOzOVF0cc4OnbQhL1
 UFcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvigE7aNKzExhG1TO2Tf+aNkxq9qUFFajZz0BubD5VRVmF/dTezHtiW5Ta9UaN419O3Qown9yUohfM@nongnu.org
X-Gm-Message-State: AOJu0Yyz/f+ntEbOo8rVQS9PHrcAKSXpUq83pmeqNPrkJuAy8MxQlShr
 CvvRH2drfmHX6u6gP6VSix/yPKkDOY71l4ErHyMSjBugHCvg7D2UUUR39qdHnCx310jBBUSasyT
 gInbwP7s=
X-Gm-Gg: ATEYQzwcVjppt9Mc3u6UxRUF3yvBMDE1NclSeAUwQu1Iq4QTH8veblZdaYnjlpqTnx/
 4oZ16GR2vnwhVMj89VOaqBg6Um2TeeDfyGyDyO3dAq6AMbVUqY1BYj0xR8LTZ9QclmHbL4KbPCD
 +V/UyMspkxAEAU2lqFaucXDFhwLI9Y1X/bg48ZYVI4mBHmDn2u+HcySw1zUimvRj05CpftaQjFP
 /IoiOh27XZP4JxB9sepsRUXE3nT9xo0Vyj8ytmFs5W+QhOEWU3V3Yr9xltizJZQUtKrTeHooGVs
 ROinmzu9iovT9YfK78BORpUcIwgJeBl/uFk1gvLe2Ol6i0IycS6Q6OtNWSInyOD2Ogg+TFuxW4S
 utC6coPo8wUf4OjVeLEF0pZD1QwEZ5p7KU/VoF54adk2zkDZR8GbsGQbXm9L0mU0MIxTvvPByTF
 /9r1llgHp5L1fFuAw9rwvmy+ufX0nMCWcDhQCbEmh3FJ+jLG0mdFQDr/AV99W5pTshOg==
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr69320105e9.2.1772228628183; 
 Fri, 27 Feb 2026 13:43:48 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f2f88sm235352515e9.2.2026.02.27.13.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:43:47 -0800 (PST)
Message-ID: <9eda6372-48c7-4a2e-a02a-66e13e6eca96@linaro.org>
Date: Fri, 27 Feb 2026 22:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/37] target/hexagon: Fix badva reference, delete CAUSE
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/2/26 21:35, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> The BADVA reg is referred to with the wrong identifier.  The
> CAUSE reg field of SSR is not yet modeled, we will dump
> the SSR in a subsequent commit.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 58a22ee41f2..82c726139f7 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -117,6 +117,14 @@ static void print_reg(FILE *f, CPUHexagonState *env, int regnum)
>                    hexagon_regnames[regnum], value);
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void print_sreg(FILE *f, CPUHexagonState *env, int regnum)

Kinda nitpicking, @env could be const. Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +{
> +    qemu_fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
> +                 hexagon_sregnames[regnum], env->t_sreg[regnum]);
> +}

