Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A2BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb6tn-0005P5-Bc; Mon, 05 Aug 2024 19:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb6tl-0005Nr-O7
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:13:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb6tj-0007pD-TR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 19:13:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7104f939aa7so12725b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722899630; x=1723504430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMb9KjC5cw1v9OoHEOgssFCHjdcMDRQkne9h9BtTv0A=;
 b=D8/+KybI9gPC1I7qtjk5BaKsz+SE5XDgEMKMqoG/qfjJjX14ft7jCXtniIiFl0f6+J
 K4G36xXKA6mbPfkjHAL27CCnZUiB9GO6hfm2MTxoD2ZKJTmRloUjvEx8JiD92KidG9Ce
 jMMTc9XVc4NdN8ymXawe7AtedXBP0Ibjk5HZJj5Utwu5UlEEXll+rZ73vYdq9b7l5TTp
 d87bKSRsvaBSR+zdwELF6zf4CCV/KNyfOeOIrcdS+pj27Cq9n1TrflvY2cnELBmKsTBk
 Ge4hx4BWkVBkfQMUCwqle5XZ5mrQH+6xnK5QpvaTq3wmfWDQaBvgf4gyulVumlCpll77
 zEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722899630; x=1723504430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMb9KjC5cw1v9OoHEOgssFCHjdcMDRQkne9h9BtTv0A=;
 b=Oi5BFm2KzmSuUWhUV8mHlvoLyTZJwUXKWiCz4Xt3qezvXxCoeThBpI1S1rWhrCRtP9
 d3/jieFQhBQItXBbdKTH48WGXDDp7QbmgdJIccfCZE5JKdygj7PWegM6RSPn8NI9MZxd
 1kVKZISM3NnUdHwuqCwC8b5ThOLuHbTfJpsd1TgHgTCMZV9b0p4AdfxqEg0BwUxo8OhQ
 FoloN6z0AGAbUvVP558APX14lwfYWk3E2AUrk4Fo0WW5oaJmvKRhxIqi7GUR06h5fByn
 G6hxCwdVpDlLT3f3aI+G5x4+/XzNa2/OhdpzuC5JJp4xwbfw+h7umyA3tNqSx1Z1gtre
 92ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTAGiCgHDstOqyrnlp88Ce+awWeM8ISmAfobEKL0WQlVbq7e7z1VzbDga6tEyCirE4fpOTlOLPtw4y1GSs+OPXQl6h1Eo=
X-Gm-Message-State: AOJu0Yw8nS8kAKKkqJGDTEBKwZrtrSRsxfXmHH/k9wTza+7wwMqNqVIv
 QZ7RznZtpGMWXkD9wMYZ/D+Kb6BYEbBAOzUEIYifUjo5LfEJ9hhgr3kRVWxxN1s=
X-Google-Smtp-Source: AGHT+IEg2xY9D7E9INzyyCzJP3jXRvE17V42+ryHbyEa7Ox6V7Hnk8baulD7RNWtNSBE/kbt3v0zuw==
X-Received: by 2002:a05:6a00:9481:b0:70b:aa7:3232 with SMTP id
 d2e1a72fcca58-7106d046169mr14258541b3a.27.1722899629435; 
 Mon, 05 Aug 2024 16:13:49 -0700 (PDT)
Received: from [192.168.0.152] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed30840sm5888079b3a.210.2024.08.05.16.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 16:13:49 -0700 (PDT)
Message-ID: <eab1058d-7451-4283-afe1-4423f590750f@linaro.org>
Date: Tue, 6 Aug 2024 09:13:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2] hw/ide/pci.c: Remove dead code from
 bmdma_prepare_buf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20240805182419.22239-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240805182419.22239-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/6/24 04:24, Philippe Mathieu-Daudé wrote:
> From: Peter Maydell<peter.maydell@linaro.org>
> 
> Coverity notes that the code at the end of the loop in
> bmdma_prepare_buf() is unreachable.  This is because in commit
> 9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
> we removed the only codepath in the loop which could "break" out of
> it, but didn't notice that this meant we should also remove the code
> at the end of the loop.
> 
> Remove the dead code.
> 
> Resolves: Coverity CID 1547772
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Kevin Wolf<kwolf@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> v2: Break and return once at EOF
> ---
>   hw/ide/pci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

