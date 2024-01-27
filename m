Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3C2C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 07:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTdMX-00078m-R0; Sat, 27 Jan 2024 02:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTdMV-00078b-CI
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 02:44:23 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTdMT-0002q4-Pf
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 02:44:23 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bd884146e9so1163225b6e.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 23:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706341460; x=1706946260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9tjdtIyVkA3JUWN2Inf1x3Gv+tBCx69AsE58Mh4GDgE=;
 b=UhMtOuoTvYmun3Q5cNilKFLEISL7pxVKP0v9NmchOHBEWx6nipfe/FIYMhfzfm131h
 Nt+21DHd/eshIjGA2DGx3jRWuY07EcMAGLfgtqxBk9tcD/fGw2+mZTqkOb+2feSuwwLG
 YSHlxO0issJNQMwtVNRgamUFSKetXVcVsKzpf491GRXbAEoPGkfdLjfOMA/xvOkaEGso
 eDAHv0gjx6xnGNTz0fJbiUmlTKUV0/XEsa0x8Fly9WifrC49pauLWP3KFDhAAS/cMeUA
 r2AQmYSd5nAkZMZms9dgkYPSkCV9u9lxHLI6U2+kdgIZDmnRPkSv5uHVTyk6a/a5dxFq
 sVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706341460; x=1706946260;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tjdtIyVkA3JUWN2Inf1x3Gv+tBCx69AsE58Mh4GDgE=;
 b=oYIKi4wmkQAICWcgsOZ6Fl3zvPX2MtbiYzyfwukMynJ720yd4xr7xa1cIRinm5y9iH
 WYG4KnZ7bjU+T/RD/kM59opoooffyCSNNhGPmYI0c7flz/i6NrYpMEIX7fW60yNFO17J
 NnJdibO8+CWo2fiItShSQ+ZcxettA1vFWNupy9/BtkHl8ptdvjpPr/436izG7Y+VZReb
 hbLttcoNhkWVbK0VTRS0YYnuSQOZlcIy57jUNwlXudhy5J1uXB5Y1b5r9nuE48NyVRJF
 kYD5hzy9Y+B3BkXZjryCLyldRnSmR3pbZ9S6psGkus/7C4PpUY9vkz2CLvYjEIh05gf5
 t7zg==
X-Gm-Message-State: AOJu0Yxbdzx6fQClfoXwzwd1dVpKYH9gdp7sekIMiNiOwLTGHEx/uAiE
 WaG8xljzHPkRu4KZU8AQRwIN92Mdyf/PBBXlA1CkFYQZac0rGYtwc3v/UbJbTTQ=
X-Google-Smtp-Source: AGHT+IFcSRksM5epc10wkkkZQtGjYroRSmKvEDeeGm7r6VEMfPvgZBbuXCAiDB63GJ2M3VaadqbD8Q==
X-Received: by 2002:a05:6808:16a4:b0:3bd:e2c1:a49b with SMTP id
 bb36-20020a05680816a400b003bde2c1a49bmr1464407oib.3.1706341460387; 
 Fri, 26 Jan 2024 23:44:20 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:f4e4:75ba:818d:188a?
 ([2001:8003:c96c:3c00:f4e4:75ba:818d:188a])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a63de43000000b005cf9e59477esm2281878pgi.26.2024.01.26.23.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 23:44:19 -0800 (PST)
Message-ID: <8f1461c7-f378-4121-8176-2a7601f0a996@linaro.org>
Date: Sat, 27 Jan 2024 17:43:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpu-exec: simplify jump cache management
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240122153409.351959-1-pbonzini@redhat.com>
 <d569042e-2c27-47f6-8636-f708b11814b4@linaro.org>
In-Reply-To: <d569042e-2c27-47f6-8636-f708b11814b4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 1/23/24 07:57, Richard Henderson wrote:
> On 1/23/24 01:34, Paolo Bonzini wrote:
>> Unless I'm missing something egregious, the jmp cache is only every
>> populated with a valid entry by the same thread that reads the cache.
>> Therefore, the contents of any valid entry are always consistent and
>> there is no need for any acquire/release magic.
> 
> I think you're right, and I over-complicated this thinking about invalidations.
> 
>> Because of this, there is really nothing to win in splitting the CF_PCREL
>> and !CF_PCREL paths.  It is easier to just always use the ->pc field in
>> the jump cache.
> 
> Once upon a time, PCREL was an ifdef, and the jump cache pc did not exist for !PCREL.  The 
> split has not been addressed since then.
> 
> 
> The cleanup looks good.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~


