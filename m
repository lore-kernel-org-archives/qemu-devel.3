Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF4C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdzQG-0003yN-Cp; Tue, 13 Aug 2024 17:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzQD-0003xu-HD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:51:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdzQB-0002J1-Qx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:51:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso4372759b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723585874; x=1724190674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkFnesJx9HNLerUgP0VIPXzcCNi4Q2up6H08aey+PcE=;
 b=IwPtNQxInChW2mRstuVPQfldVgRi6V2mpruPUxbCLUsF9A3k0Qcn/2wUyrgumLHwE+
 mEO6qn9VNMkzscc4ZGmGMhRwlU/iAbMs+Qf8iw+CG4DbTbtReTd5dx1D45Z1iR2hvv4R
 1WG72eOFC0/r6b6CJMTy9aWuPIXQ7akmF8/J3M6a8ceTpr1ge+Hc3v+wJzmy0ULZ5bS9
 /nGNQHV0dybwdLYiE1NI2ubxPjkIdBg1BaYJGoLoOlX1Mf2H/kBDWLb2f8UbFIeRPgtD
 YYZbvDL7KtHRoZ0yADcLlcFoi2FfgIaqJVHGTu5xqoAIc29rfilGTCKUuRyvXnpUcvja
 vpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723585874; x=1724190674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkFnesJx9HNLerUgP0VIPXzcCNi4Q2up6H08aey+PcE=;
 b=qEKb5owV3HEVLCFQegUDncMZU8x+PGS55SRRsQALjA6a9l4UDqj1VO2TLkKIIdH3F6
 o8HvQbgGeh0JFsjOELNkP6V3MQzYIT/3/Wdhvrj7Lw6wJbDTWFvSLDn7H6NKqloOtA9i
 M4bWtmNzAIa4YoeTMyMKanvjoQgyQXwnVHaHbxq8KlSn6Zc/9VKSX+E3fV+mmWklcTgI
 Scgb2dx5XV7n0EwzBhpsKrLjxdyfcpPq/U4qbV6IkuGFk/4ME4n4e3WGapjHa8XjZA/V
 N91GmlhQif/jvLIQTqC05pniC3Hne77OnbrRx7SedjJN7J67E1L4mI0vNO0v74GIZD5P
 rIFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUaaPnMs8t894g8SW8PcTOXji0Pw3HYB0tlGGdLPgSnopFDcScTqg1f/qYC6UAU/IeNNiEK7wNrMnOvWtfx1yj7q7F3Eg=
X-Gm-Message-State: AOJu0YzdIE83sGL6yWUfzkl3FkJYcA0TbwBlN9PwBjhk1P5BAaJeELR+
 ctUmNZy9kh72M012lw6j87JQwIjqAo6nUuLADsIWBqTBI9L3aKqsm1vv93oARpy2Q7VjhOuiiPG
 rICA=
X-Google-Smtp-Source: AGHT+IHriU2WlBhsOoQ8X6QcMPn/CkFrr8lyFzhyUYYpA4b8ZMwMr/VE4U0c4OWaf0wJD/De/A44dg==
X-Received: by 2002:a05:6a20:d49b:b0:1c4:c93e:a57b with SMTP id
 adf61e73a8af0-1c8eaed131cmr1264286637.23.1723585873967; 
 Tue, 13 Aug 2024 14:51:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c697a536c0sm1943996a12.57.2024.08.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 14:51:13 -0700 (PDT)
Message-ID: <6df614be-4225-4747-9c1c-721e5a40ba38@linaro.org>
Date: Wed, 14 Aug 2024 07:51:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] plugins: fix race condition with scoreboards
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20240812220748.95167-1-pierrick.bouvier@linaro.org>
 <20240812220748.95167-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812220748.95167-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/13/24 08:07, Pierrick Bouvier wrote:
> A deadlock can be created if a new vcpu (a) triggers a scoreboard
> reallocation, and another vcpu (b) wants to create a new scoreboard at
> the same time.
> 
> In this case, (a) holds the plugin lock, and starts an exclusive
> section, waiting for (b). But at the same time, (b) is waiting for
> plugin lock.
> 
> The solution is to drop the lock before entering the exclusive section.
> 
> This bug can be easily reproduced by creating a callback for any tb
> exec, that allocates a new scoreboard. In this case, as soon as we reach
> more than 16 vcpus, the deadlock occurs.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2344
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

