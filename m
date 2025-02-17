Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06EFC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvzI-0008E8-0x; Mon, 17 Feb 2025 02:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvz9-0008Da-1i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:56:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvz7-0007Oa-Cd
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:56:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso818525e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778967; x=1740383767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HGlTR9e6Oa6UuUmUFq3Qf+m44fB51I8DXP09neM2M+s=;
 b=YGWa6UaL7ncgwS/CS1/dm1DdTvLUdz22SKptTNWFu6Wm3wK0RTnx2YmR3Mr+opxk9B
 GTgi8b3QLdM7ZczhorSX3QkKg7+Um8snzfWtctOBYYuFU+Mmml8wLuNjxOS8+YUgB+LK
 GcjTJl9uYwTyLWqG3xVoUW1Xck7+U2N+aRapCzS90747HGSYdqcvKjjQu3BUHtNBJx0g
 u9z9b7Td8evYM4/uusbN6Prd1v8I9TEWD9Y8vXIC1L0zhSU0fPm2KIDNCt1yEsW0gZaA
 y0eFjiQ7ejrxLSnS9PnJkd2bPQZBhQWcwisXMcYmFbfShVA78STi9wpiaAoVAltbN1Bu
 8BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778967; x=1740383767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HGlTR9e6Oa6UuUmUFq3Qf+m44fB51I8DXP09neM2M+s=;
 b=FVK5pO/frTInR1Dl29qFG5mHQDDl6VaTM+WcR7LO+P2sTx6qLtspQZZ5nm/imS9nuC
 hXGIyute/Vt/TKboek3LMp8epefHPx7Ui3ZnTxDIhgwl9vdDPmzf6W0CVvwTOfKjU4MF
 g9l0u2s/gSE/QiOM8dQ+PfUkX49o94vX3kRLl2W3gnTEk11FJYLZWQSCSj2gAY1HJ2Zo
 cLdyW66s3Wj4KgYe/Xtas7PquW0hpRqp9hrkMrpl/9Dvi9KFQHTlPvMaUr8LwkQ67RCy
 T9VpmLl8ODVGik6IGqcq07XEkd+OZEnDFSrllCqLECBa+AsUHXbtfvStwlCzG4qNTPr8
 D/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW//Z8CVsueYmKFr2BTXlrxWq/T36DgDbi4ylKgHQ7+HV02dJCC6G9loBkezjkhZmXUl/nrrkL1jQ6@nongnu.org
X-Gm-Message-State: AOJu0Yx4ccD9RNYahE48ELDcchKYQNjPORgPbuBCbcF70xoSv3jL8rb4
 Mtla2SPUcITF1FsgKnldyy0HJ1Ye5Wunxi7vNxGADUISmHHC82HvuaDmugjXfvNKngxJo6w2FPv
 t
X-Gm-Gg: ASbGncu8AnUlU1rL3J2Ns51P86uM+DcmlpsQV92wclF3Bz6fYKlJwGKOB0/JPiYLZFY
 QugKhslPJrKWf3sV4Sa3iQSAbGbaqR4wGM77wwvuyjId4Ows+IvjyWwuh3LNCl2p9opCLYpj8GC
 YiWLVbv9QeE9xW8BJN0ehyCMS+iKnsDBApg+/Ge345h8OUQm6s35d8RosMdTaNbKEAcMiAulT35
 THwZFHCA1UKXi2WgUxZ1NeRfU0JZZNo9Km8bwBY754vZUj87tbX7L5nDTZ606tJyUhakcSdPR8x
 6GDtxGbAarDZO4Nico2xRQ5b4Z4kfbYRmlA=
X-Google-Smtp-Source: AGHT+IEoLt8hI6To2KlrT37d2SAYUb04RDO66AU+Rh4NsJiQ0rhCxgw3DNG/M3+z1DzLh8O0WwKuNg==
X-Received: by 2002:a05:600c:1d1a:b0:439:5756:ad4c with SMTP id
 5b1f17b1804b1-4396e6c1885mr84469135e9.14.1739778967545; 
 Sun, 16 Feb 2025 23:56:07 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7e8sm146156405e9.26.2025.02.16.23.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:56:07 -0800 (PST)
Message-ID: <1cc670e9-5f48-4e3f-bf1a-ce6c21c7cca6@linaro.org>
Date: Mon, 17 Feb 2025 08:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 057/162] tcg: Merge INDEX_op_sar_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-58-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 12 ++++++------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 12 ++++--------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  3 +--
>   7 files changed, 18 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


