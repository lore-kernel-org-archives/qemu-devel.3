Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC48C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 04:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ10a-0000c3-Fl; Wed, 31 Jul 2024 00:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ10Y-0000UV-JZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:32:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ10W-0002vJ-85
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 00:32:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso3844154b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722400330; x=1723005130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZOoSHLA7lVu2mqoZ4Jte5mmuIervAc+1t+sLBvcQmc=;
 b=sVSIuKNXYdM+VbELInHcwORM0U9gGF7W0mnzjJlvII4+d7XPh7WB3xkr2gfCBXO9O/
 UkqlM0LVVCs8OzHGV8yrL/Z2IXhFn427cIhupGhbE9PdWBZ6hceoNxlxib2UlNk8Hwua
 l9IYhBDatcPwCRGozgLyehdMF75YIo4XljJFr70BV+XWzPc8tvMPgKfQuqOisR33vvJz
 V+QWaWSeX12bzx40X3LNVHcMKS157Dec/WjN4sIPteCIgeRt0pJjXaxX+TsGWAcRJVF/
 H5OGibnGR8Ux/wt4kvkJ5uzpZl4PX+Wpj2wNmMN5JHOS8k6N5hlwXoK61no2E9P0kKbk
 fQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722400330; x=1723005130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZOoSHLA7lVu2mqoZ4Jte5mmuIervAc+1t+sLBvcQmc=;
 b=UMT+6WzlusLZDZHpre2GfuiYeZPP4lWYFt5jbG/R9eNVPJCxanJz/MLW6lnO8kI62E
 QAdqHKHfesPJlFnivWr4r77rybagRKze8/zh2WQ6ODlmV4agnDFPm8F2vpBrfYaQGAyV
 dcqk48htHiWD1KaB8+Tw81eNSmLKIdqWcVOGFDgH0fWLoWTDWJjlCscIQC6MPytk0o0v
 ZzJdtwIXqyBeuKk8xg66b3oTjR+GMpVdgJZXrA0IoQUAbmFtw+dpYcexscfn9PqwEWWC
 25GtYpdg76PeLzSxKbt+ozIZ94nqgibqi5wZj+WCQZbjBoPmCFXq8dxDM3oswt7QYRTA
 RZ7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPpGlOXnj4JzkEadOXHgn/qfFJMRLye6dhAvfaPquvmFsvpPB0WWcdBuDPLAmL0W3q7TuiMZHmOSMEsDbdj/N7Pdx+cRM=
X-Gm-Message-State: AOJu0YwmtpDUNzndAZ7yVM7FeXFkrmmNAMJTaQMiYUFS72A7nk7+9qyT
 BN6sknvzSLxiEc62Kjdvq31PleHTP7B1obZncbuEGHdOlH4D4Gywj1nvyqeDtag=
X-Google-Smtp-Source: AGHT+IFdswvRX3l1pm223PnHuq7v3c14DYX6bbeCTsMA1bfPLb4iMHQ6bElTbceKgeD/ZmLqNgu3Tw==
X-Received: by 2002:a05:6a20:9190:b0:1c4:87f5:995d with SMTP id
 adf61e73a8af0-1c4a1532eacmr12073919637.54.1722400330448; 
 Tue, 30 Jul 2024 21:32:10 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead874c6fsm9159822b3a.165.2024.07.30.21.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 21:32:10 -0700 (PDT)
Message-ID: <54aa7d13-8193-46a5-b3d7-5b31c15f34a7@linaro.org>
Date: Wed, 31 Jul 2024 14:32:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 4/5] hw/sd/sdhci: Trace ADMA descriptors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
 <20240730092138.32443-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730092138.32443-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/30/24 19:21, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sd/sdhci.c      | 8 ++++++++
>   hw/sd/trace-events | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 8293d83556..66b9364e9e 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -693,6 +693,11 @@ typedef struct ADMADescr {
>       uint8_t incr;
>   } ADMADescr;
>   
> +static void trace_adma_description(const char *type, const ADMADescr *dscr)
> +{
> +    trace_sdhci_adma_desc(type, dscr->addr, dscr->length, dscr->attr, dscr->incr);
> +}
> +

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

