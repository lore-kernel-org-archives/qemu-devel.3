Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3644C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBRk-0006Zt-9i; Thu, 19 Feb 2026 16:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRY-0006On-Ts
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:18 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRW-0006fW-91
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:16 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso1024900b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536013; x=1772140813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fXX94G1tIoTZ+ejx2XFCx/yNOtYTN3u6M84mKcTzssI=;
 b=YoryWiY9FW6xs+P0lWp3s1ZvRyWo5jmrI5l53CibR3+nBM9YJACWrT51VbXQp7so61
 CcPQRIWXp9CYYelHY722YOhwjqPwaslaZvrRplBkuJvtniS8+2hOkuQnDAAR0Hi6dLY5
 dvB/9h0sqbp0v9uUWEa2fLIzq+n2yc0C8NTvqcvNvSfsq+2614AMKYS20ZL25IsrSDbS
 7C999NpriqGNJ7a6Sf/8hFgghc1L26fvZqfrLBFNrU/un9FqZKfNv5G1vkOiCYGgLxXu
 tUipSDmnGYL/Y67e89L6Hk4HWCpagPUMUH989hsf8SclyAQ364scrUO+B8J89u7bNhOu
 2Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536013; x=1772140813;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXX94G1tIoTZ+ejx2XFCx/yNOtYTN3u6M84mKcTzssI=;
 b=ZOqZVtcB2aTmiuF51qRNCxy9x3kSjKEG7UMO/st1Er423k7ZRTPVS5DrC+8+9h021o
 kyPbnpHsOaBAbaMYEnfxENCZeWFZYDPPEKE7lmCkhRaqgqxxyjg52ozjybwY/cqF2TxU
 A7dur1IvnrijuS94L0OxyP2HUfrebamUL19zMONdIbqDExcB/J6pWtWKlSs0e5IuyRsK
 95b1XMoYyHWPXkzbhWi4kCuTXVskXbm9SEiKf8dfiXcyj18W9s6c/SbIgNFIa8B/vV6t
 K6XJH6qhhP8enFJNFTHvyyYXAcHWO4QJdCr19ARQgRPD3ysXyv2jgSXUupgDnCEgt8fk
 BY3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9IKMD6NF9hf4Q2RF6vTfTuYrEi3euKcuWKkHuNDxvwKmI7AqHq0FFnY4XKWJUG8N6SJCW/eoh8aof@nongnu.org
X-Gm-Message-State: AOJu0YwK6XSyXvuVp4cfyO6A5o5DpsYab8pXKNLo46bMVGk67y5skO+h
 3UEaekXi7wLdnQ/8r+k1PxtfYDb16CPvzT5Ym4qzUY2f9nVIJFIptXJNK8oecoWq8R8=
X-Gm-Gg: AZuq6aJV4yRuAvWisZCDVgODLD5AWODhWAhRnswuTSLqJyA+x7eCec7prO6LN7ZBcb+
 nvZtcYSkD8pz2QLfkIimIfw54PwjuNRi7y7vj579LPHzzzrnHKlQt/v67PIAgIsx/kf7OP4iK3M
 ofHh/KfOCzLjGvxDSuO+RuP3FBBhyLXddoLW1C6MJMM6cxFqT6F6hSZrzIh83X7rWowVNHX8G2A
 +DzhB4rJE5Vvq+5mnehiUe3eACnifaz2MQX5uXVSbpZDVT1uhdI/Z0Q0fJj8KD3HAlqo3yLJT+U
 6B3Njh/dFP5DMPR0UUaX/bTU+WvVQ/SdjgZ1mUB6N+qgEfe7OX8FipvQhSutQOL+honRml1Yb/D
 yGASNDXYLV2xFyQfDudJYpL7ZqFVeVsUVARRo0+5SXt/ob+DxEcUk5Fqz+6xP+gGAAqhiY3bqNP
 8pZ02rp8NmFazr0w5g0kTg0BIy+DnAlPKKhtge6o6d8lIVP+ehskIqiUxKgPfyvTqfcPaG
X-Received: by 2002:a05:6a00:27ac:b0:821:8629:ef70 with SMTP id
 d2e1a72fcca58-826ba5fa962mr2997867b3a.0.1771536012408; 
 Thu, 19 Feb 2026 13:20:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19782746b3a.6.2026.02.19.13.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:20:12 -0800 (PST)
Message-ID: <dbf87008-31a9-43cb-91b9-42f9a3047da5@linaro.org>
Date: Thu, 19 Feb 2026 13:18:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/50] target/m68k: Remove MonitorDef register entries
 available via gdbstub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
>   target/m68k/monitor.c | 18 ------------------
>   1 file changed, 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

