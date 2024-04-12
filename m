Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF130C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDhy-0001mp-I3; Fri, 12 Apr 2024 06:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDho-0001mD-Ro
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:00:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDhi-00012x-2Q
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:00:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-346b96f1483so371628f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712916015; x=1713520815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lrhE71LSgkGFtR5fBLCZ3ZIpkZ0j4N9kUQY21X4yfug=;
 b=oMQN+hzfxboDsPZaks8yIUi9yzvFrDsEHZ/UspPCEs5GivwzvZex0JA/IV+bSJJgJA
 dEp5cUrxl7xfZJgiLwUTQspeM0RpZo8hLxKyIZ0nrcW0SqumY0t8DI1ZZLjYYllstjqU
 2Jl6eYUziv6nezoOfv1qcKSw9i9rSOcVrW3bvMbNz2UZ79NgCu4CLqMi5V1HJuPXoQ/H
 /XSR/NhRZIanmrFnXliJTkYfRs21/EEDqfO3P3uG740BOTGUk6Jq4hINdEyCdIhj+fyD
 yp6Lq6KLExM+rywASD2mYvLNB86g8B7JSO1tGvymgxF3AoJABRxFwtY5FUviWsM/kQUb
 Kizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916015; x=1713520815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lrhE71LSgkGFtR5fBLCZ3ZIpkZ0j4N9kUQY21X4yfug=;
 b=GqC78GuihRwgOquXrkO5CC3io/bLIZQf4shB9fSCEh+TtfyUsD1JMsr2Bu7S5Ub0OT
 djPP2w+Lvtt4qnDfm7lMeziu+kEYeMzeol6xmE9y5g1UFidRBn3LLWw8lZ9OKEFUQBgX
 NKfETM3M8cFT1XCvf9nTaNJ5PSA5zgMo0bhiXr9m26nq2P6diff+neOyNeM1I4q2nq9r
 7IyffMagjd9oP6j/RYuosuKSm+MQgV6KLfUZHH0h1dqStlCZi5DJ85pRuARbg667ay49
 H1cMqwEvghSoNkAZxBH/4yDfhv6kE074QOTZNndDBdOuqqe5UUvzSInvxT1GV6Zdtxax
 WrMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0O06M4yWeddoDy6H0Y0nCw6UHSrQnQQHFtzlY4NBhuibGCRPeOMCl0l6WG7QW46QzyLGZZBswlbQF2EEYNVSMJFSMvw=
X-Gm-Message-State: AOJu0Yxus10EbeDNUOe/U0MQCJiH8hXm8hjsvRqwPfx9J4RSago8mwj5
 LBsk4ar0YS1iS02Uyw0EKlwysQaEIK+S+taVRRW8yU4Lw987hJNd7Q+h5pyLy/gQgnPWA2uRU2X
 MXYs=
X-Google-Smtp-Source: AGHT+IGfTiLsv64s3BiDYn102wSMBKrhLlaBzcLcZZTtTE/8G+1RbKKwAMznFi+H0xzurSgbL9sqPg==
X-Received: by 2002:adf:cd8f:0:b0:346:a9b3:f0f6 with SMTP id
 q15-20020adfcd8f000000b00346a9b3f0f6mr1701127wrj.18.1712916015282; 
 Fri, 12 Apr 2024 03:00:15 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm348461wrq.19.2024.04.12.03.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 03:00:14 -0700 (PDT)
Message-ID: <8f9dad3b-7105-4820-9c29-170aadd51e1a@linaro.org>
Date: Fri, 12 Apr 2024 12:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/27] util/hexdump: Remove b parameter from
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Require that the caller output the offset and increment bufptr.
> Use QEMU_HEXDUMP_LINE_BYTES in vhost_vdpa_dump_config instead
> of raw integer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  |  2 +-
>   hw/virtio/vhost-vdpa.c |  4 ++--
>   util/hexdump.c         | 13 ++++++-------
>   hw/virtio/trace-events |  2 +-
>   4 files changed, 10 insertions(+), 11 deletions(-)


> @@ -58,8 +57,8 @@ void qemu_hexdump(FILE *fp, const char *prefix,
>   
>       for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
>           len = size - b;
> -        qemu_hexdump_line(line, b, bufptr, len, true);
> -        fprintf(fp, "%s: %s\n", prefix, line);
> +        qemu_hexdump_line(line, bufptr + b, len, true);
> +        fprintf(fp, "%s: %04x: %s\n", prefix, b, line);

Clever :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


