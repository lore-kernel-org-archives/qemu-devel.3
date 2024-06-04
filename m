Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFABC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUMm-0007LJ-ON; Tue, 04 Jun 2024 09:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUMk-0007Kj-Ky
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:38:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUMj-0007Tn-1N
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:38:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dc0472b7eso4835293f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508295; x=1718113095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZuLyAK0QjLriwHoSfq2NRGaCZ0bPvi5zKnd/9VlnnHc=;
 b=jilOhVUE5oKVzRAYLcXZvXXkQqzO4MQqdegZKveiAniBgDIa+Mo2NmRZpaniHDRivb
 drwrvoW/OZjSkYh1+C+Uqh78VNPLEIB+lpQXpShkpirNvQl2kvQeSoiMbvw08gLVYtj4
 Ua5Ql/V8cHhsv9FgeYoKyEWELl3y/qol1bj8T7MQrg3lboPYObNaLV4RhKHjpnKv4bjc
 vBJBYOX1DRF4lnDVcCS8uxZf1ckDQH4kxlWHEgNeB1mwBpXANRVe9qOog9C1935wUOEp
 W6W+ZhR2dBV8KLaZGgWAk3J4yh1ZDGVNOSMSv0RyDKZPmdM9KKRPqAUA+roomg8LKeDD
 mIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508295; x=1718113095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuLyAK0QjLriwHoSfq2NRGaCZ0bPvi5zKnd/9VlnnHc=;
 b=hjr033/ayIaczbbQAnFZyKKssWNFut9oGhaqiXS4SS3f6vfZMYJwtNy95NzAsDQwHD
 N7E0e3Z+HNRRUwk8fdS104kgpcIfV4A6BwcZHPH7GZwpYoG6JnqeLNB+zwPre2peIjkq
 ufIax2Y832c1I89BJpwTeSSF3xvXXlWei2FpYf82L258aspI/k+y4BGr9a9hFJbDt42W
 IywbHax7yxhsrGtHVT4CfHPPJju25n5lXVb/p//kKLu/V/x6T9oNujapJ2PZcatO5fAI
 29wbAZgcXmMjT/mFdsdMostJ5NEC9v5EHyXWV9GizjCruWTMSMw2SeyW+37PBbp+UXhJ
 ETEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCu983BgKmBktjhxWA14Cemk9RrQKuye0YFPwVJIvtql1ixxS7DvS2ZAHyIJYtBmEqgbXKKD638LGHjx3FpVDgWttmJzI=
X-Gm-Message-State: AOJu0YzOCbhgWVlM/ne6niBBPqqVd1FIq8cREmnhNRVpx0FYld5DSKwy
 2DGPbycxZ/kD+lXyC7rszOwpPvXADhYRV6arX6ZdrZU0fUoo0SuJXMlp7Tso9z4=
X-Google-Smtp-Source: AGHT+IFKlmtCUKSrYAKtyBesIacIeFcvGjKRznlhbqtye9kmpyftFTbIzTQR+M0ZLsfvQ9beJbTYcw==
X-Received: by 2002:adf:ce91:0:b0:354:e243:ccc with SMTP id
 ffacd0b85a97d-35e0f3181fcmr8464644f8f.48.1717508295404; 
 Tue, 04 Jun 2024 06:38:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064aa6csm11576045f8f.93.2024.06.04.06.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:38:15 -0700 (PDT)
Message-ID: <4dbdfabb-86f0-4e94-8918-b01668ebbb3c@linaro.org>
Date: Tue, 4 Jun 2024 15:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/37] target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  2 ++
>   target/sparc/insns.decode |  9 +++++++++
>   target/sparc/translate.c  | 11 +++++++++++
>   target/sparc/vis_helper.c | 36 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 58 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


