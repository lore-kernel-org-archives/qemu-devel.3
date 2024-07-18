Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A73C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZmD-0004Pv-U5; Thu, 18 Jul 2024 18:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZmC-0004KE-DY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:39:04 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZmA-0004hG-TG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:39:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-75c5bdab7faso884110a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342341; x=1721947141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PP4aAiF6UTn/j56XZBX9ZWpfiikHyYoytNHdkBml6xA=;
 b=a3++WO89pbAKytKZnDm6uihWpnwifQrHJOBjbxCUVzBqWzq0BeqOB9b67ivFrPfO47
 jR1TlpCa7Ud1r0waSelOVx62ifVpVa+qGpEDZGWiJAk3K35ELXwtc1DGJX+4OcCLt3Wg
 SUZeHppztmpEK8r18tZ3KGtPdBPU/Qi/U2zhrnh62XTOjvcrGC+Xg7aWTvYpvXWDe+bf
 QRuMfddklEkm3iCoSGiEn7nerseR2JWfLSJNf5Nciy2x5Mnr4OE/EhBymD8WyjxSeKhV
 BF4vf50a1YMLyoRe6rr/0XqMuqiDA6/JsphXJRlbCKGLnZvgABKFRhkYzz8NeHDphZtO
 GaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342341; x=1721947141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PP4aAiF6UTn/j56XZBX9ZWpfiikHyYoytNHdkBml6xA=;
 b=OSq1AXL4eVtFtwsncc2WdAs42oQ6RvQcU+Aj+CH1QBgfW9KVlCKJVrKX6CaPkiE8e9
 LeTfiipWNkArcjjdUTxvBDsn376t7asfQZ+l/fl35ua8eeKFF9JJOitZgJ5dZmQTPZHe
 JdtfWqXXfjPLzjOlx08j5xa5VvJ2h3Ei83R2yImEosKnBCYtn5DlBuCaZUiFlJpdpzny
 le058XPnw7L59PIHwEBldthhAHr18Syv3lLQ0OBD34dvFFgBz5XMHEPR5p1c2PkxzbXt
 CUhPZ7y8B6fpEM3lSVlTJEQrmSFwcnkB8K3jKogc27IJ93s7p4CZ6fWIzPyZA2A6y91z
 2JTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZSz2YQvBc0jwQy0CbWJ7uj/SiRui2wVgVmQS/FAePIRtVZxows2VKrYqFLw2g07XNJvWSRp0Cs+6q8XGUG0q+UK0a25g=
X-Gm-Message-State: AOJu0YyxKTkM9hXU6+DjrK7E8aDUJb6NZGMfSMobRqpzfqDOYb2FFBD7
 cX3iEXZiHac74VoJKyVCtkmE0RwDecQp8H4czG6XhdTYEVFUtxe+qESyFnuylbk=
X-Google-Smtp-Source: AGHT+IHduSuLDFjy3dbp6rSTcN7RdPyn7/Z7ZRstEWBtqqkwSz8FNuxKIrru49BiqdD6VvnoIap6fA==
X-Received: by 2002:a05:6a20:7f97:b0:1c3:ff33:246b with SMTP id
 adf61e73a8af0-1c3ff3326ffmr6598188637.40.1721342341360; 
 Thu, 18 Jul 2024 15:39:01 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d6c8basm809855ad.294.2024.07.18.15.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:39:00 -0700 (PDT)
Message-ID: <3a0ae5fb-c604-40a8-b374-5b8cca259769@linaro.org>
Date: Fri, 19 Jul 2024 08:38:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] hw/intc/loongson_ipi: Move common definitions to
 loongson_ipi_common.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao<maobibo@loongson.cn>
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Extracted from bigger commit, added commit description]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/intc/loongson_ipi.h        | 18 ------------------
>   include/hw/intc/loongson_ipi_common.h | 19 +++++++++++++++++++
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

