Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFDC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s46tz-000335-L6; Mon, 06 May 2024 18:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46ty-00032q-0Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:33:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46tu-0007gB-MX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:33:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso2766375f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715034817; x=1715639617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H7ZJustMiW7nPUhItgoQuxYxEP3+MgCQY5iJTzlGbgQ=;
 b=hOg/fywDe4BEAtu8OzY/V/WtyMg3aD+dml5VBPXNF63gxUeuN+yoRtjAQ0GDnACk1D
 M1/sPEZKbmlRcZwqsXhseCaIF4Y7tmGK7rh8lkJdv34myrJpYmhdRTRBja/VPa8W8wXN
 SdS2v9TRR/5tzb/NyKUQ72h32t4lKqxE7BPPZkEXk33ipAdcNF3LNPhiFeXXqzg+KJ0s
 bkFzYnLBBeQbySEITtT9rKshSASXimZ0pVfUg/mn3vaRVys4I+g/kBCoYx8PKFPGyFQb
 kwqMO6SCRtIFEt5wgF5MtvDn7XnD0PLfREEiBIg8Pq3gthx0zJiDTNmukaUyAVuiPno+
 D3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715034817; x=1715639617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H7ZJustMiW7nPUhItgoQuxYxEP3+MgCQY5iJTzlGbgQ=;
 b=L76QR1s1OnUiUsRCGbcyz9+8t4WQe+Coqno/qFWibt59k7Zys8hg29RJBJ/uveMnML
 p6gvIrmTNhylPzSnnQ6I/llla7F3UdviRfzBrsJLFixkXBdqq0pX9Li2dBHdY4O9TQpj
 zqyeaOHK62r5er3w8MzYAUNr8xd6vout7MIaaFcJFwZWkokIRDZdzzNVyf4eB2XdKnF6
 ljiw7epfjvFZC1vSBJcEkb4A4AJ25A2rhGz6m2NbhbrhSiepJRAQIe7iUQbp3svqJVs0
 4Vsiq8mfICgyYjkt51A+3tja4P/u9Y/naYCV5C/sxds8dmu9LnGmskRbQdoFeYc57Duc
 wTVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEq6smtU7NK20jJvbmO7HnLCLgeTba+q3Yof0V+JjJwja1Z6srkt83cYyleMpCSl5PzL5luAwiUbeLiuTkRU3uR/AFrCo=
X-Gm-Message-State: AOJu0Yy83poX4y62f5dJtXC2CuBRWuRVRgt1qfbGy5PpuH24hFln4pGD
 qhhvrxYJQ25MquxI0EvZ9mGwcpQPTDIn32jd1vHx/+UeceElZxgTQj1zcxP+LOc=
X-Google-Smtp-Source: AGHT+IGVSBA19t2NutuW1U5s2o0my4FwmVuUFuJnSH/CwD00IBTDOUwDwZ8NcqJreqOMrYwpzcQoUA==
X-Received: by 2002:adf:f04c:0:b0:34d:a19b:56b2 with SMTP id
 t12-20020adff04c000000b0034da19b56b2mr840269wro.3.1715034816899; 
 Mon, 06 May 2024 15:33:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 z18-20020adff752000000b0034e19861891sm11555047wrp.33.2024.05.06.15.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:33:36 -0700 (PDT)
Message-ID: <b7367d66-f4be-463c-87cf-105235a04c68@linaro.org>
Date: Tue, 7 May 2024 00:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/57] target/arm: Split out gengvec.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506010403.6204-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/5/24 03:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h |    5 +
>   target/arm/tcg/gengvec.c   | 1612 ++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c | 1588 -----------------------------------
>   target/arm/tcg/meson.build |    1 +
>   4 files changed, 1618 insertions(+), 1588 deletions(-)
>   create mode 100644 target/arm/tcg/gengvec.c

Reviewed using git-diff --color-moved=dimmed-zebra

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


