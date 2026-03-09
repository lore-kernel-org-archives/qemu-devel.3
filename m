Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C4F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcpC-000633-Si; Mon, 09 Mar 2026 11:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcpA-00062E-UF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:47:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcp9-0006sq-G4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:47:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo5594749f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071234; x=1773676034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzVZ+EBKDfQXom479dPxa1J6uckbj+fNA3wvmh2l7kQ=;
 b=Xr1cF/idigRuaLQytGQteBPT7P75CpOlMGJ485oOCPOGlK6dWI9ktb1C2/KUKQYD0U
 Ut5w9CTFei5RyLGsHwhId/H69OWv/baQ6Yf0CqINdE0/J5oS9qu6ezYgZOtcutXby8I3
 GK8/2VJKEC1JyHetVOeRWr7Xy5FUOJUIits/atOiCU7kocJZRU0zw66RrUV309Hmzogr
 nKZzhZ7yEde2VgdxsKK0zTNvT0XOGgnrlevhZZ0fH7YQXaqm2C366a5z8YfV0cOV4s1p
 tjhTRBxnb5Wf4ydgVdSxRSIS3MqafNWNQEgbSYgT8Mp3NV/p9M+Pq4Q4chi970gNmAgB
 EZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071234; x=1773676034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzVZ+EBKDfQXom479dPxa1J6uckbj+fNA3wvmh2l7kQ=;
 b=ILVpR5iDyo9w6XtRif57Ph/R/aG/yjEdj5RgopnUNIKnK+qMNuztwFupzLkLyczt5N
 +glXIDGXh5hs8xWGHUCVBsgmRewK9rF/+/fIlx/uwxifgCgQQTeKz3KiRW9QacygMzUu
 xlhFqehcek4QmUEsq3qy16wUP2y9eYYhDOhyHrFIgjZ9aNQhLZeiB3AI9LMNuPpUXDvX
 1cTANCA1LiwIqDkOkq0MAN5C4EAEsLw+pqWcVjwwDVosEDHuFpdjwN0IMZ2gf8KD+6X0
 NBNATRzlb7cBUeqTzzX+fUTB3behG3H8jThxpSI7nEWWvfs1msQHLp80TihoJHK1FyDV
 3kGA==
X-Gm-Message-State: AOJu0YwvXysOoQ2GQHCOmoPEtwknjus6mg6KXAc/rpzWs/BT84vWdV8I
 I8o5fGBDwKcFXvF9yNFplg0DjPU2bXCzBvBkuf/YIZyjShNrrhKdN511oaEzqURNEsE=
X-Gm-Gg: ATEYQzwg5etD2YS/Pfu9fxo5/fvpW61I67BsiX/rmpmMEPmNZwld26N5cOc5rC/vag9
 n1FUnWiUacpF8zNIbcYZJkGU78bm3M0GEiP3HsUhRz7w3/O6f47FbxXYKv7JWF8qAp6xVuC/ZnU
 GlAOScYE9Y6q0TbYScAjbzOm2OTpVcXp++23nh+FmS5PeX42aDBv5fj6699Twd68IU7zMhH8ugi
 POeBBQHo7Soy0x8D40guh36ezID9RtTtXphKwc4pA/4BX8sFob4uWXtTCIAHBwM34lsTGJhlKVk
 rK+VXj75qsykD69NKxEiltYHPLcC3UwoDgzFPzJgO9JIHw8gc4aW3jJaiv4Gr74n7FAZZhHW9Q/
 s0eyqPe16okmFHQqTlWcYzYh07fejuPw0Os0wsS93aUjVnf6csy+a8WViVA5uceICEMZcOjK2e4
 pPJkj03itpJZQupi1FKC7iKh7IGROgWBzOgNr2psm/aof4nt4JEGkdiVUyts9qsp96Ng==
X-Received: by 2002:a5d:5f82:0:b0:439:bc2b:cb57 with SMTP id
 ffacd0b85a97d-439da3483bcmr20349773f8f.6.1773071233796; 
 Mon, 09 Mar 2026 08:47:13 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada9116sm24929540f8f.14.2026.03.09.08.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:47:13 -0700 (PDT)
Message-ID: <3c738768-cf47-45a9-b91e-eb130ad6e571@linaro.org>
Date: Mon, 9 Mar 2026 16:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-snd: remove a redundant memory allocation
Content-Language: en-US
To: Roman Kiryanov <rkir@google.com>, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com
References: <20260305042523.335493-1-rkir@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305042523.335493-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/3/26 05:25, Roman Kiryanov wrote:
> This change also makes its lifetime explicit and
> prevents NULL dereferences.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/audio/virtio-snd.c         | 53 ++++++++++++++++-------------------
>   include/hw/audio/virtio-snd.h |  2 +-
>   2 files changed, 25 insertions(+), 30 deletions(-)

This patch and next one queued via hw-misc. When posting multiple
patches, please add a cover letter to help maintainers grabbing
the series as a whole.

Regards,

Phil.

