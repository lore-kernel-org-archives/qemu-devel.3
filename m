Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1A0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyXo-0001eU-KI; Tue, 30 Jul 2024 21:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyXm-0001dJ-Uu
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:54:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyXl-0001Zu-BI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:54:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so3254824b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722390859; x=1722995659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0gAdli0Cj6MUdZc2HqpMRDIV6jZ9ikCRcSUpGYpt6NA=;
 b=R/Cu+4QKbpIFTK1iZxPzgRurmNs5r7dzyD/hiLacPZ7hIgcEuKshSMxETwa4CywV1d
 eRTYEqX7uTZ3Yu9RMyaQTRgjLY42u18J7C1SmkT9zTlvqiMh6CMLubbO2Mmrk0iyW82g
 M/qhgP/BHYlOUCXiZUQu8QpscBTDcCtiYRxdQuvKbaWxm3tmVF91PnJB7NYJMgrPMuws
 XFcskq1TXoKCVpGN/WzhZ9ym53IT/J5p3ZjO910KrvPzP96tdokM9PJIkGBZFZa0pW69
 CVbUxmnFgJXqSmBOX3ety4G19lOnk+44Nj7HmbnaXxlzJKKljhu1PVxjQcgsjEBLcw/3
 2muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722390859; x=1722995659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0gAdli0Cj6MUdZc2HqpMRDIV6jZ9ikCRcSUpGYpt6NA=;
 b=IsPjo5qKJsZoYVgCBosgfQ61DqVyZ/OBGP16yCoyoTyN8TXAdvAdXJYSSZ2mkVgMrH
 TMeg0n6bnmtFOtc+8xH7otqsiXRa0a6qT4bzooRkOt4sNfE/QAKCLmKw2eArW+0fPYXM
 eL7PSPGyC24Oeu3ytM0UmQFu3gBqdWTdgKKxrVFtUakP0aezmY/Gj2/MuE0exu+VfXTF
 dB+DgKtz10cdwt5FIR4RvYLt6MHxcb2bE3LW3lL+9M9Gc/61sIJ95kNekFzpbeEIF3HT
 tQIBXTSs4elWn5UI2qO8UeCqteeoEg+iCg9s4dRFwkVrcEcnpM2vzqWpjAAPl5HxFN8k
 f7QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVin2bH19NtZGdMQ7Gpogk51a6pvfFugs5e2/rual4BjbCLZk8mZ/IJfnY0V4orn3QW60AEpKJO//Qr4weUtwXlM+LVAzE=
X-Gm-Message-State: AOJu0YypMdgpPKRUywqGun6IS9khbDHFTe+ObPaH/G2L3urEnv2a2duq
 m8a7S6YBXwdge4C9Nyek7auDcSAFHs4lk1SYJyTNcPdGG2GOqDAt9JuZskez1sg=
X-Google-Smtp-Source: AGHT+IEGApD9wy09kEYKOyEFNafB8lgVMQTd8q9cALWOWORweMDTNO86xdu4k9dfEK1WqEPjua4kEw==
X-Received: by 2002:a05:6a20:3049:b0:1c4:8690:9862 with SMTP id
 adf61e73a8af0-1c4a14eefb7mr9309657637.43.1722390859060; 
 Tue, 30 Jul 2024 18:54:19 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc453f38sm100696a91.24.2024.07.30.18.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:54:18 -0700 (PDT)
Message-ID: <ee2865fb-e0be-417c-be28-c44ab04ddea1@linaro.org>
Date: Wed, 31 Jul 2024 11:54:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] qemu/osdep: Move close_all_open_fds() to
 oslib-posix
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
 <20240730122437.1749603-2-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730122437.1749603-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
> Move close_all_open_fds() in oslib-posix, rename it
> qemu_close_all_open_fds() and export it.
> 
> Signed-off-by: Clément Léger<cleger@rivosinc.com>
> ---
>   include/qemu/osdep.h    |  7 +++++++
>   system/async-teardown.c | 37 +------------------------------------
>   util/oslib-posix.c      | 34 ++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

