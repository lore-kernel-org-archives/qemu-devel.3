Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4E1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWB5U-0005Ql-BT; Tue, 23 Jul 2024 04:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWB5S-0005OT-E6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:41:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWB5Q-0003sP-Me
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:41:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso3632535f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721724091; x=1722328891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+mrZ4wwnuIv0zgTJwExcDq91Th3ZzIIk21mNfO8wzSo=;
 b=UW7yP9OXN13Oj7lN85q+0K5rYVd0bXVE5fBKkFtcakQj8GTPgtcCjyxkVCGbAAHyZm
 QsMSQqCg686BcBog9C6mmiPOaKHnjZPoYC30aeAtMpzf2uwPgRpPENcVhq30+czI1G/1
 QVY27NK55J1IBsUb6sWD7xWfX7KMpOte7lI7RDQRFXwOJkr9W9WhWUo6V4OMC2MBcgbX
 u75SnYX70N895UbvBH4xFCQSDIgyDfOhuOX2bpxWIiQ9DKu4kbq51U81u1H22sZjKjsr
 miPtslAxyQWYBZA2GyYwtBSjiztsEokV9xi84nMk77nguS3nLC4zFGHkM++atcWIEZ4k
 +rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721724091; x=1722328891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+mrZ4wwnuIv0zgTJwExcDq91Th3ZzIIk21mNfO8wzSo=;
 b=uHR5jfD9f3BCA4uOigXG8igB8+DNOnWikY/Keih0Izgc59S+1QX5ntNxehiHxfMcT5
 Ua/4IBvgtWs4UtCTCCOY+j2eRsbRzNPE1ggOpG4PI3Bm8M0WHfdCJzSnmSu7s0XLpnBm
 v9Xa6mS8evQijDUR3eoUA5otvOGh7CVO+EGBcWy/LKPwidi/tY+DJTdWA1OgVOFfHzCQ
 2N45SCkV4Zxuh5ia9Oe7IZEx5mxXbVwoa5/fGxfdn7HN/Isd33L7NIiYGX7NL8kFCvCx
 /4Uo4Hd4O/juRElDtA6LCceNFjjtYvnlDhaH9Fe9Q//95b/q5FYgPP2HK5s9gUN5ytpM
 4tcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtZgg6oDzM/S3f39GN2Lb8Gd9unmLG9M/+ypULy3+3tVSJ1aMM6r3CDc+bddADYJNMGxMpluQ8tE61/B1GoBSg8WI3/+M=
X-Gm-Message-State: AOJu0YxH8bQ77aJSpxkNnHoiUKF7EdvBJLn7P9+KrQs5tSo0CQ0ffozp
 bRxUghGfFmekcT1yFQgFdQEQQMKFMC/r23FXwfKq0/ShMDkQkmKvv9/tDbNO11Dn9MHJmmYAz1N
 CjVs=
X-Google-Smtp-Source: AGHT+IFO8+YJUpOioos/iSe79v7+CWFNZoq8+YaV5Yt0KJ0sE2u7gowrF5GO9Jjxzc7H+MD55Iwp1w==
X-Received: by 2002:a05:6000:1e8c:b0:367:9114:4693 with SMTP id
 ffacd0b85a97d-369bae65cd8mr6746384f8f.31.1721724090836; 
 Tue, 23 Jul 2024 01:41:30 -0700 (PDT)
Received: from [192.168.18.115] ([178.239.250.121])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ecf92sm10699024f8f.101.2024.07.23.01.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:41:30 -0700 (PDT)
Message-ID: <492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org>
Date: Tue, 23 Jul 2024 10:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/19] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <20240718133312.10324-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240718133312.10324-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 18/7/24 15:32, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao <maobibo@loongson.cn>
> 
> In preparation to extract common IPI code in few commits,
> extract loongson_ipi_common_finalize().
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Tested-by: Bibo Mao <maobibo@loongson.cn>
> Acked-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
> index d870af39c1..960d1e604f 100644
> --- a/hw/intc/loongson_ipi.c
> +++ b/hw/intc/loongson_ipi.c
> @@ -357,13 +357,18 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_loongson_ipi;
>   }
>   
> -static void loongson_ipi_finalize(Object *obj)
> +static void loongson_ipi_common_finalize(Object *obj)
>   {
>       LoongsonIPIState *s = LOONGSON_IPI(obj);
>   
>       g_free(s->cpu);

Unfortunately the current code is bogus, @cpu is allocated in
loongson_ipi_realize(), a DeviceRealize handler, so must be
de-allocated in a DeviceUnrealize equivalent. Not at the instance
finalize cleanup which is too late because we could leak after
UNREALIZE -> REALIZE sequences.

>   }
>   
> +static void loongson_ipi_finalize(Object *obj)
> +{
> +    loongson_ipi_common_finalize(obj);
> +}
> +
>   static const TypeInfo loongson_ipi_types[] = {
>       {
>           .name               = TYPE_LOONGSON_IPI,


