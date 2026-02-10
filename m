Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB77EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuq0-0004tX-LO; Tue, 10 Feb 2026 16:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpupy-0004tM-Gf
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:59:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpupx-0008SU-3g
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:59:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so142884f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770757195; x=1771361995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zpSTHxd1H85yF4Dv2JmjW2GgJJ7Yl2e3dyFWw8oA2T8=;
 b=WGyRiRhCUXfM6Rq8EHhCsCgeQ0rmeIDD5/ge6nBy0d0oz0zStokfJGeiGw7LA1W6wF
 b5BmCpzUHmRsX68Shqcjw3tm2xyyGebQ0MySAtGKwGhQaLQHiLFZLJ4Ex0A9T//O3R1+
 NqvlGlt5JMkQxB0IDYMrwXz+zjJjoEkKACgviGSkZb9VFTNJfNYfTQWDgQH6m+tY3DZi
 Z/KsiEViAvCkDsrIVGLOBoG6jsIMhrOQP2eEEeBPQVaHydn9XqpWhUmk7iTjgWJl12Cq
 33CplaMXD+GEPpqH3NoCfWA2zoY2Vyf66OEyMHzm4m3mByEzdTH3jZ8OugA4FpHUk8hb
 d7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757195; x=1771361995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpSTHxd1H85yF4Dv2JmjW2GgJJ7Yl2e3dyFWw8oA2T8=;
 b=Cqk3A777a9S7rAhvQo8Nf+OjIWefyOmNtkD2IDQ3t2GbNsBe+MauPiq1J7+DO3Q6JM
 P4BxWQPm/WMEL7NSjx/Xs42OnVaM9GEPjMoOjg7dhF7GTj91MFekg90lMULLMkOSxv9v
 7QopfOa43KGtByKh6DMdW0K3rHp9JNt1RA4tkkWSqu2tTGt8R/slpt2nY/VzYy7aWb/o
 CEVsIVQd2Rdkj8UK6LBM077XzOQP3BKtsa20qEHc69gT8wUhXRW0NrKxPewfstfCd2bs
 ptRJ8D3XHHIR9j/6RmZB/xDjpB7YRfuUMHb62dSFbUFWQW5vFXBE2KwG3benYvrcESRW
 UULg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5fz2f/8ekev+CjxUmh9LTrxUdMOnPfzVjE1NEhO4RBKJmY3At+/ZuNY081fjk0ScEhl+LgScbmYuC@nongnu.org
X-Gm-Message-State: AOJu0YxKqMEe8Q9A8yUAXN7lR+4pR62JXbUS8luO2yN3iFWw56T08iBs
 yKw3U+3c8foTYm0kJwJGFA/GCW6HD6xwmY6UgDsl0qPq5qaJwRXhF1sUowCU/rTKuJiKqxlYoGz
 P4p4ulYU=
X-Gm-Gg: AZuq6aIfHfHcHV8CoMwWEZjbape7Q70mwK80LJXFCtVHKmZ9OV6EFRU6H/vklWyo53c
 toSKmrPXFIxM32FIGA8XOSkmvxXY36QmzUxgZ3++xKmUupYgXL2Nb1PtGlXvKxwEyLS+ad6lhDx
 yb4iOc3ZEp4TJKp4f2dVh45iIAsIJwjmOqj3XE+qDpfQh6Z8n3n/AS2Dm0MQSjh6lEa47jpIrvh
 9A5T6ddKFF2RLT4/XVEmtgtQhNJ7hyZmmxp0hJhefFxbUqwU3H5i10oMx+ghVCxigdtq1xDwimy
 +Fc0k0kWbA0umAjzy0szOWdoDPQUMp+ywyL41Wn7YeQARhCcuJpMD0cEoqhSn39XvI4fxo1zU+b
 g7+wlgtGzVSgMziytltvcMlnDKn8GjCajUZ5HUp3JWACMlfX8hmoowjThk8GlXbv7MDDg3yRmbg
 Wco55KSGavaicJAJODAK9d1MScwINCPihHsOMg3joOXrZeRYZ/TRSpbd5q1cTPguo=
X-Received: by 2002:a05:6000:220b:b0:436:4ba:59a8 with SMTP id
 ffacd0b85a97d-43779e3c22fmr6014160f8f.3.1770757195519; 
 Tue, 10 Feb 2026 12:59:55 -0800 (PST)
Received: from [10.123.89.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376d3a32basm20266442f8f.14.2026.02.10.12.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:59:54 -0800 (PST)
Message-ID: <7629c45d-7247-459a-a181-200d8b2ea469@linaro.org>
Date: Tue, 10 Feb 2026 21:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] contrib/plugins/uftrace: add ops for walking frame
 pointers chain
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210201344.1403613-3-pierrick.bouvier@linaro.org>
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

On 10/2/26 21:13, Pierrick Bouvier wrote:
> x86_64 and aarch64 use same stack layout. However, other architectures
> might use different offset for return address and next frame pointer.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 38 ++++++++++++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

