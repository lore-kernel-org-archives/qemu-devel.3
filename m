Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66641C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 08:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTeN6-0006AN-CC; Sat, 27 Jan 2024 03:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeN5-0006AF-4O
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:49:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeN3-0005TR-Kj
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:49:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso12593765ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706345339; x=1706950139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KP+auXGousriKv9OmgxJ+55g+vh0nJcLe3ophV5I028=;
 b=nip1vtJDEXO+XueIl17LcxkN/OzZ2yQ6zgBMxtd3c/7Y7+fIJvszLarlCxSm/fdciu
 FWgt60BX2jghBPbGzvbXLvA7qX6En7WAkp13XlIrMbWNV89mYnrsfvMEgt0AqaHDvbRk
 3Fj4V3ZQbCTwIYi9FmePEKhYJNnPQeuKdvxjqFK4JliOoUtdbBNsy9tBoM2FGaUnLPt7
 5j+wv8QdsuqKgol59luneEhQtcuj0vJTLsVzPjuyTnJJauYTwI+uBkTV6sFsg+w+pbOq
 PagyfLvsTtlhcSPLm/gvi12NZ/Ne2moeS57WxfbKDwEvhyHgRYOkmwmkLR5Tf6LvKP/1
 ovHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706345339; x=1706950139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KP+auXGousriKv9OmgxJ+55g+vh0nJcLe3ophV5I028=;
 b=mYcm9N8T0YsKfyJPxQMEHg4xdhe0ureuyjsHPKmE2S6NtVkiubCN6nc1puCY1hSIvx
 H4ZXTJp48+JabxVL1OckhubK5A6RXJmOm0RaGlEycRFZEQ4tQ11btY00wXEz1dDuhCYW
 NFxfx5F2hSy4oMgmaWbExshOZ5OZ4b1J4KMl4LH9Is33vsR5BWBF0/LfiMb5KCBnIuaU
 P6O00M86mR3MnFkSOx8f5LsjqzFMDdTn8VpWDMmvLcwyaXXCrWoETt9NC2RdKd0ZHFmG
 7LUJY34vmEI4qxqKBJBXJb9eHvlXWM41me1SQaSxvM3KkZymFD78Cf7ndZJnhXqt7MDo
 H0uw==
X-Gm-Message-State: AOJu0Yxf4AJLfScWFk744svlFbON+RU0EsK1CJhVJVj14B63hNNKi5fZ
 mCaREoZr5f4LMGZcQeOkicuJ+kmjKQXkxvIHuRD3JlJeKE1RO/vQyJW7AqmHwEU=
X-Google-Smtp-Source: AGHT+IEvfKL0sWvfC7gN+FVOstxDMp3MyQzZsIK8Jzq9gLXQH1xhUqDbk7W2fZouCbUgCV1U8KMQqA==
X-Received: by 2002:a17:902:dad1:b0:1d8:8aee:e53c with SMTP id
 q17-20020a170902dad100b001d88aeee53cmr1229883plx.32.1706345339691; 
 Sat, 27 Jan 2024 00:48:59 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170903244600b001d78813c8a5sm2051755pls.49.2024.01.27.00.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 00:48:59 -0800 (PST)
Message-ID: <98b5a940-1288-404e-8ea8-044188a9cb2b@linaro.org>
Date: Sat, 27 Jan 2024 18:48:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/34] hw/core: [VADDR] Include vaddr.h from cpu.h
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-8-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-8-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> cpu-common.h is only needed for vaddr
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks.


r~


