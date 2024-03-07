Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49BCC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riL4A-0002Hn-Cm; Thu, 07 Mar 2024 16:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL42-0002H5-4K
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:14:08 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL40-0002k3-KW
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:14:05 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so10601035ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709846041; x=1710450841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OhVW7G2xyj65zUqR8hboFxkIAwOIB1jwL99RPEVZsec=;
 b=sdiwsyD+dlQWwRvVjWHjVmhipFO7z+ZsVM5libKDtrMcXhG0k7pXOR4LoHo/UPX2WT
 15XIvT2e1i9AKOKmadEmzD63pqW4S4rGhhM2nYKQEVFsw65ROqS0U83PklSpNVm3hfTM
 gz0lFSW8ubAEInfmEdSFh53c+wBWHlUjTNVeHJcF593fgdMWCz+HG2qanbYvGI6GG0dy
 8XgMg1rAgYA2buTpTuO/dmfAKldrZNTaX83M2VZUNxk6MJMoaBgUhwD95a4A/hI5eySJ
 Cn87KwyJvtUyRiYij11BrquAMr/uxZUtjc7zJiZwxBG6JH605UIHP762N0ZyY4eN4cTb
 giXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846041; x=1710450841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhVW7G2xyj65zUqR8hboFxkIAwOIB1jwL99RPEVZsec=;
 b=wW9Nd5cIziTmkrEGNqi+041p5mDCQed918RbAbt9EcR+cRTMxsEGUqf315dXqdE6Gx
 UcJ457hyXG6WfOU2YQN7e6ejtZn6igaPOQkdHWE6VZYfFZ+AFnfFKomkzGj8ZOrruEw4
 8L1EtP5jhVCP3AlJJf8IwyyJfu8ty4rvdNW5MGWGuV2uFcrV8a9sfNdj/QPE0xr4cayo
 HqQMmnRW1ONYvpiZTVSbWKd/CujFmIETYeeEWKybiZc2wgmXWok0dtkrNDX/D0cgMh0L
 t3x0ymyHwVj6Elav+/nzA63/jlQImpHMRo1zaX7X8hC9/WkB6mwKeBb9eEAkVI4dW5kf
 mkMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wg0mX7DtTjY8pZBxQzL3H7SOK8B+XElZ/kBN7eopb4uxujmw8/GBDqWfwjjG2rWtS+O9M1ar/968RvnqJ0TuZKPGKjA=
X-Gm-Message-State: AOJu0YygbFN0WeK2cgP/Qidq3VWfiyCxxyzqBVZ5mlleMibc9lQhuA1W
 0FeHukS7wNP/uab6ZPzoQyiegS1gini6F1Ymnfgm56bFMoZEMHfTJ5dYqxv1xlo=
X-Google-Smtp-Source: AGHT+IHlqwVJtRXhnvf++XzOEqym0hvOtw9f8Ty+btMrkKosYSQSaaoHiQPRdJFvuneRM5UJ60zBuA==
X-Received: by 2002:a17:902:d4d1:b0:1dc:fae0:1c85 with SMTP id
 o17-20020a170902d4d100b001dcfae01c85mr11274541plg.4.1709846041252; 
 Thu, 07 Mar 2024 13:14:01 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 y22-20020a17090264d600b001dd61bc14f2sm730825pli.8.2024.03.07.13.13.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:14:00 -0800 (PST)
Message-ID: <68dc0d72-ae67-4e7e-8c1f-670aa59e92c9@linaro.org>
Date: Thu, 7 Mar 2024 11:13:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] gdbstub: Add Xfer:siginfo:read stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-4-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307182623.1450717-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/7/24 08:26, Gustavo Romero wrote:
> +void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
> +{
> +    unsigned long offset, len;
> +    uint8_t *siginfo_offset;
> +
> +    offset = get_param(params, 0)->val_ul;
> +    len = get_param(params, 1)->val_ul;
> +
> +    if (offset + len > sizeof(target_siginfo_t)) {

If you save the siginfo_len from gdb_handlesig, you can place this in user.c.

Is it really correct to reject (offset == 0) + (len == large), rather than truncate len?

> +    /* Reply */
> +    g_string_assign(gdbserver_state.str_buf, "l");
> +    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);

It seems easy enough to reply with the exact length remaining...


r~

