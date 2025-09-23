Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41381CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10Oh-0008Rs-Qz; Tue, 23 Sep 2025 06:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Oe-0008R4-Gu
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:37:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10OY-00052b-BU
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:37:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so2751940f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623826; x=1759228626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbggQ/t50loqSyhKfMwshBp/xAJcylVBqXvVk63BPhU=;
 b=cDeF+DA7CRb8THaxb9VEhdYa4+tTnKFsDTTjHUsoCSeA1r9yM2/NGsBoCuwNfMCp3S
 Dbde4j9OJsOIXMAKyHfjE0r1GbAGfRYuTcg0pLE8QBY9A7nd9wBFCr8OjIjFPNJhr2/z
 0T/s+HbqxIleE8P8jnv7NnYuoN8Q5L1YIvfOqPKDZqkcnJuL6q+VAJoPgSIqvpipZWj0
 FpwqPnqVI5wMFjilsIHVwhBffxcWPT8wObr93zzTB4pCdyUE6uLokdCfGWS6e+Tq+Xq5
 v2M5Kxok1KAsqY19fh5mFLdURM7WzwZnACyn03QID9dbNnQM9bx4f9OZebJfKgFo12Vr
 kwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623826; x=1759228626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbggQ/t50loqSyhKfMwshBp/xAJcylVBqXvVk63BPhU=;
 b=EL0Qc5bR6eDSzYQft7JNYjOR+VAQ3o99QSfp9jO5wigYAilkP/s8ZvidoUC8s36Rgp
 4N6IEoYEAf2qcilAqBtAQ/oL99C6yS/ZY9TR1so9tsyRs9oiiEMZLS26XnItGsdMq+h1
 mX6nSA8Dw7i7tNpasqG42J6reBKKGLn47qQQSEYAphuR5eLBnC3l7ASx4eYc+qX80fqr
 lXIdDlCVNJ6INcJG3+PQ1OAxUGl7+z6pZdNDshXh7m2aadqEFOY36+lGcJQ4CcOhTm+2
 Rs2ay/XeyQHfod9bdGs7unpgcut5jJEBNC8qpUXWhdH0IR1rtA31usmuOYKB68UGsFEw
 gaew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHYTFOI64yNL3lM30geDZiwrQ8n/fzXN4hXA2hV0IirfZYrFf7re95/P5d8aO7wzCgZajppjIRrFwO@nongnu.org
X-Gm-Message-State: AOJu0YwYa+g+9rFaHHi1WKo80zKNuSMogVih1bLqDwMz08IYIXqrkbhJ
 wG4QkevuAc64qvgTFlmZ0Xsuhkpr4bzABfYQ88LMNrJ0G//yPNxEJwXNmTsCb0bt/OQ=
X-Gm-Gg: ASbGnct6rppaIMmN7CiyN/DxXSDQzmP1TxQ6mtZCAZSHWf8QHPDTtN10jZ9yDTd/HmF
 v4io2fYe/BpotDdyfGJUOsjvXpQrw/smBOubX3MqYhJEsWlmESyJoj8mROAjES8+9ccXPqznJpR
 08VxA7YiqnIDUNoL/ibrsKJo6785xoWEhkKsY3uORIPuDoo44mcD9xvuTV/sCxgEqZt3lO1G0YF
 6weeQF3QOsrqytH2ZLXW8RbFJjP0z7Ke6kVxoNP6Wewauo658pHaNWfuqu8bG/BEk/+mz9YK5Z1
 ng2Ule2fs6fJkJvI27ci9YvHpsInoDDGeIKDZLzTPyxkICkCXLsWCQGDZlngFl8asVT7h36LavM
 yjUYDEipUPatFhrPTbJVoAByvd6ZbBvBfNlizrvv42nZVbD0fwVHdv12+LtznspQ/bQ==
X-Google-Smtp-Source: AGHT+IGlvq8ISKz95LervAwRn/h+6DXDml1rF8BRJ8cn8z6LTYU24uOTtQDVS7Quzv/2yYwN7K3X/w==
X-Received: by 2002:a05:6000:2406:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-405caa5057cmr1393907f8f.47.1758623826167; 
 Tue, 23 Sep 2025 03:37:06 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7107sm24492206f8f.30.2025.09.23.03.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:37:05 -0700 (PDT)
Message-ID: <233261d8-9496-4157-8062-32048fae2d46@linaro.org>
Date: Tue, 23 Sep 2025 12:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/36] target/arm: Restrict the scope of CPREG_FIELD32, 
 CPREG_FIELD64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h |  9 ---------
>   target/arm/helper.c | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


