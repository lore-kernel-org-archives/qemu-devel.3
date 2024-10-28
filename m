Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87C8D5B87D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fS7-0002BE-75; Tue, 29 Oct 2024 02:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRd-0001jG-WF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRc-0007IM-JG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso67347415e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182267; x=1730787067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPgvrwRXgs6YdX0wc7Q6CeG9N1eKPyqo915zRFEZ3GE=;
 b=lqv3ocL14BwjRsOjX2yIklz78YxtLjo9+rFdVdNM9by/yjAySdh4d+TMQegx/m/N/Q
 Ea/KlM4Xt99f2Zgjz6/VmPzq89oYQOI3jdE5GgxjmJUxTl/M9oP/nnKD3/HGTLk51zjr
 J00sxupA7Luy/bTGhjLwfT09edNXLnTX2EEoGBRvaY7b19kcLQA5AP9LI1oiahCPQacU
 TWhKCbP2bfd0RAYKY9CTetclekER2Od3CA/l7dPodkynC+sd5aE6eoVN636DKzG91v70
 9yB9Z5wk99zkbPJmQqlmlWvv6CPAl+/h5G7IwzpAMWor/5x/iqGu64/nvSpypR5PYwEr
 1d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182267; x=1730787067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPgvrwRXgs6YdX0wc7Q6CeG9N1eKPyqo915zRFEZ3GE=;
 b=Sr4MOThxd5TEnwFbFHnnMoPAFsPh2hPRGLX+HKI9hc9drBoiyOs4ecFr7Mb4lvrTCM
 kxdRSMaHXs3DCJccP6+vZ1ZYhD+a8QZyS4CSZbIhmRejCFcxijDJr9ViknLtM+kjXpnF
 Oc4gVrzZrJqGWm6Tc3l1iyVv9DsdR5S8ON4zj7pyKLzO1NNLwmjY5nqPnwsy8f3XUOkX
 E4GmKOKPSGEqqLfWpm44IBtBwpmCI24en5GP2uyxEtRfU2i1VLKun9wBdWKWrFFl6c2F
 wKN6TP5waaCFERy322U5HRVsQX9d2Ir8uFmr7Ooy1hzMxdm65wbeQrAAaxj/v5ONJrx1
 w0lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUavVbZZ1tPUsN8GrTRNRE2ErTRc02CDcqdCEFquVUNmF8Gd+iOoQbvEtrx89PGpOXlDDkVG4tQTVgX@nongnu.org
X-Gm-Message-State: AOJu0YwonTMZUfG7UdBYidp9eorITG5QppTff898z5QNLXx/jf6rlNNq
 B1ffcHRM716iotZmklwsxoNHm22Z1edUk5JQgc51Fcw2l374XhGwMsysStEZ8Bs=
X-Google-Smtp-Source: AGHT+IGfHNy5H0Hd0IC6l1qPeffkj1tdJUwywBIv8CIOw2z0yrIjr9ELO5TbkU3saiQoQujsHIRRWA==
X-Received: by 2002:a05:600c:4ecb:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-4319ab8cbfbmr113599395e9.0.1730182267250; 
 Mon, 28 Oct 2024 23:11:07 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b45aa058sm12150405e9.1.2024.10.28.23.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:06 -0700 (PDT)
Message-ID: <1b1973d8-a04e-41f1-9b12-f265b523655a@linaro.org>
Date: Mon, 28 Oct 2024 12:25:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] target/alpha: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-17-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in this target.
> 
> This is a no-behaviour-change commit, so we retain the existing
> behaviour of x87-style pick-largest-significand NaN propagation.
> This is however not the architecturally correct handling, so we leave
> a TODO note to that effect.
> 
> We also leave a TODO note pointing out that all this code in the cpu
> initfn (including the existing setting up of env->flags and the FPCR)
> should be in a currently non-existent CPU reset function.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.c             | 11 +++++++++++
>   fpu/softfloat-specialize.c.inc |  2 +-
>   2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

