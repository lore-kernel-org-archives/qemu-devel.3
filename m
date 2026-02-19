Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B12C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBRg-0006YC-7Y; Thu, 19 Feb 2026 16:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRZ-0006Ox-5Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:18 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRW-0006k5-QN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:16 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso852167b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536013; x=1772140813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qQxc/I4T7a020uM+A4PQOP6D/SkyUdalSDRNUC7x4o=;
 b=YZDQWedtpV9lMmhhc+ocvC7Zf3ZD8iVpOdg2HHybsmyo/uymOV4woUcYYYhiVGaifI
 5vIZz8eIq9/1bqRcLqulmWcDMB2hRBr4FjiWWdeWPqY1flhTRTTgwQ0ONlNWiDSPYpWP
 w8E6BNxLnIt0osa33wxZdpfyNBVlIY5O2Zy3m9tcEhETtub0a0yW0LNiFZjSnDRIwNKs
 gZuYfGfA+4MLdoNqTyiImjGXoJs8UFrqEg59pRmb5uDD8sq4sgY2shlwxIgmDXXUQ9Kz
 o3fpfwc+rciRjR+QfmCq/WL4H3V1Pzk5oaabMApCiPHzT/1nUb34EMlf+HFNgOyq2buv
 1KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536013; x=1772140813;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qQxc/I4T7a020uM+A4PQOP6D/SkyUdalSDRNUC7x4o=;
 b=EarpjO1VbvoC/bId2OuVPJHpDTPHSznAn+7bLqW9q/8Ax0oUT13rKHHcX00iLABWNw
 mTFOIGDBIELYjSFEiGT6PEcuqojy5vmInk52wbD5VI0H1rwXSDKlEdvK7jpU4ykR4zZ2
 +HPZMTAAUbmoFHbzfxzvagvcuel3rAiPMqw7WDbRyjtI13nTPtIqUMQRJB7HqYvyzpUr
 ZB+k7iOMCBP8EcqSMKMghVXIEOJC0LF9mRLfZiSPrdsgMelbJ8qw3iKhgURUc+vsGh/f
 MS8g8m6cfx9Q3tRhkcmf3XkguV2JY8WijEya2u3ZI1x1ZOGxQ/mWFUlmLMkLDnGXl/Lg
 cGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWov5gq8HDlUBxeRByQfHnlmOyDQ0ALn1l2Jxeym0vLh90hTgh/6BkpYtUcpeMLmIhr7gsyaMYQ/wtr@nongnu.org
X-Gm-Message-State: AOJu0YxMKsJKBaPxwDYEQ6vwi050d9ui1Up79hDPIT5xoZKo1XjO/I99
 vulBC+sz18AEz39nPQJGXthAgSLClYqSLNcOgfDp3YfTS79SfY4Zicf/hBMgR4HkeNtCdory2Dt
 srVPw
X-Gm-Gg: AZuq6aL7rKlBmSCmlDOfYsKZJX0IFh901IRhTU6QE4+EG1Pb/BSRZ08YM7mQ6p7Bgrd
 ucvyAJuzooyZBVJTipS4WxdI1nyN1ap1Ip8REJaSiHpbg/d3LvNT4a6cMqrepExBzUgRRLuleNo
 hxAAL1aumZ+0Gi1hcFip+nGqNEJnEoOaNWm7QDMd4VwQxiX8K6E0eY0Fix96cygO2GbISRImvGh
 oigKaAxdcpRv62Xzm/4kySsiXx96J/QTrAsX0AOhYMfm+Mzfa8HY6sIHbeah0yckvSWWErdHhFr
 pkGOTgfS+keqPnCIrXPMKfBOl5SEIRXlgjijis9slnkCgOSz2bHE2pTMftmA3FYnC4xmxjd/W73
 P9GCHuc+ooKcmbCB9ATAvHZ9R5EatULlvBJAO+OJH6HoADFAOVnhFNyuDxUP1nrAcGo2F02uy9M
 aqXL8KJZn4oh+WwK9hcrvqs7Q4dh1QP0X0hDwgiHmnLKjkFIuSd3usCclmsSXvF6YcmqM5
X-Received: by 2002:a05:6a00:4f81:b0:81f:528b:c091 with SMTP id
 d2e1a72fcca58-824d9526c2cmr18608768b3a.22.1771536013276; 
 Thu, 19 Feb 2026 13:20:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19782746b3a.6.2026.02.19.13.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:20:12 -0800 (PST)
Message-ID: <f10f944e-9020-42c2-b985-71cdf63859dd@linaro.org>
Date: Thu, 19 Feb 2026 13:18:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/50] target/ppc: Remove MonitorDef register entries
 available via gdbstub
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-21-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> All these registers are already provided by via gdbstub parsed XML
> and handler by the gdb_get_register() helper in the monitor/hmp.c
> file. Remove as now unreachable code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/ppc-qmp-cmds.c | 132 --------------------------------------
>   1 file changed, 132 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

