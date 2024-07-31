Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B65C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyb9-000257-RP; Tue, 30 Jul 2024 21:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyb7-00024W-J0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:57:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyb6-0002LF-4D
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:57:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ff3d5c6e9eso9153705ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722391066; x=1722995866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuXk4v8igvIw8LfMfQldEe3enIk0QS4H+I4sndueI8s=;
 b=KPrfoMBoA1rDDc/6075kOF1bBg/3yWgMOWfyKUvRQ/FRk9TsscaTAWphgJi4LDBpM5
 a/TF6hsXJYJAm/s56rhvEe3onvj6a5YPXgJaXVGWRN2Q4Fs+01R2Ryw5yOHNLGoUOjLj
 kv4CWkVJh+RtdvJQYhLqzX2t7xWFF9+7w/FgQsa4adbue5dARZ8mq43FnD8NpXDeXvn8
 NKygBdcnbbNclAR0W/ygXcalBjc9d8wVuKEf9jSMcc/TSItbvb42dRga6fP4y/1xpXFy
 Tn8pzGxz6z3ubVbKVbT1WW/3vxAy/hNZDq7HpEX9iY/5Ss12o8WokV8oytXSwAoS97KL
 tZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722391066; x=1722995866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuXk4v8igvIw8LfMfQldEe3enIk0QS4H+I4sndueI8s=;
 b=wlep5oDKBKt13e5Bj5/+jQpWPMvqVSxZMjtSIYTHCAzkp1GRXR/Mz7bDdbKe/Tl2Dd
 POK76S1XTCc0kZytq45NjHIEbfNopRaJzqY/26+fRGHm2srxqG7ryE5cozenmvQ7JXUK
 CMnforFRT58RaIXIx7A9ecwBrHjJhdQ1d3sS7bT8vQhgKQzsGD3wrvOPDpeW/bF2CWWh
 dr4a9G3B9+6+vm4R4VSK/saStxK/Do+XuEAiqnzyVqzQF7qDKCuHGFW63VmKjOhX3X/G
 XQf/dGEpe9TWVIDToF75TkEU8nBRPgBGXgAFX0yhlRpqHXqFEbTb88gcN+mCnN13ydXr
 Qrgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkoNFR3LYCworLsWP9tXtkH9qXn7U39fS7LBvXVKrDywhoEwT3QisgAZm2+ddzhwX8S2XklRk6nDDVkANeNJaaUU1p6H0=
X-Gm-Message-State: AOJu0YzAkIuSxDMu1hnrdi76WFTmN7EwM49bpwOE+U9DtIwzmggLyEda
 GWo1WtScd5OoNd2+ylA8/CyaLo2ZolZxPIWav0xT96TplN4XHoMD+R1bd138jY0=
X-Google-Smtp-Source: AGHT+IG8r2pe2Suqi30BguR6I3wiknmnDA5a5nLrCc5k8qM28XalzyRKceaZM8T95J/dOrhQIlcxUw==
X-Received: by 2002:a17:903:190:b0:1fb:3474:9500 with SMTP id
 d9443c01a7336-1ff04842406mr95685355ad.27.1722391066239; 
 Tue, 30 Jul 2024 18:57:46 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7f62fsm108945785ad.19.2024.07.30.18.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:57:45 -0700 (PDT)
Message-ID: <bf7e501c-fac0-4b76-8633-1536a9268867@linaro.org>
Date: Wed, 31 Jul 2024 11:57:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] net/tap: Factorize fd closing after forking
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-4-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730122437.1749603-4-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/30/24 22:24, Clément Léger wrote:
> The same code is used twice to actually close all open file descriptors
> after forking. Factorize it in a single place.
> 
> Signed-off-by: Clément Léger<cleger@rivosinc.com>
> ---
>   net/tap.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

