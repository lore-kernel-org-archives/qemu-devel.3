Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E3C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropjg-0001eb-Eo; Mon, 25 Mar 2024 15:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropjY-0001YT-UV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:11:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropjX-00066o-CI
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:11:48 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1def59b537cso29645965ad.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711393906; x=1711998706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tcrioghJDZ7IxX6/gCftw21QrcqXKg2D5dsSOrfB7vA=;
 b=hf/3HCGb9rOpl0uXuwbspIoZEjeT7NOcULiWkbxaVgJ9QI8pvA3BTDk3bIUkBHvBoi
 5TJR8jUv7G+/QwehS1v9CYW6sM0RN1FSTE+B0xLVF4rAfKTPDGZlFqkwLB+caX5Ijq6U
 PcEUJ6ZqLe3fUOHxKNiCvVmdhJT+1JaRj0lf38w7vuI9nMD4tplBWkNdYE7Sk++GFP9w
 GprYhmpK1bIZt7ceXe/WWG+ZwHNWB7PlIkVFe1DQQJ2+9I7gmMgHqYLEhmkvJGnBsB4k
 Lq9qaR4cVKaBVLJh/ppZmmniMsHIvdw16FTmMjiKEtHemMLl9JN9NHMGcjZUKqDISkm6
 wWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393906; x=1711998706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tcrioghJDZ7IxX6/gCftw21QrcqXKg2D5dsSOrfB7vA=;
 b=JfyzDzqte7P4mITT3yIIj6b72AfaxB0Tfp46lsieIQJY2zuAuITu7IidUTh9dAFZS7
 GX9k1g9/DaWqqi4bIeE26Hb3C+n9TLu0k38ZhXxjt1vCWRwdqFXOqcjVLNaVOsLXRV17
 NDxKdeP9DHScJyvk/PECEpJMwek+bXsvm3GZySWEMlv+uDgg/NGI4hBpkzUWCshBvz6M
 PxovlCb9wGPK0WyNn0MnyZDosxsZF1j+BAZeUVcwjoiKhQS3+dCql0uRXyj9rP/BnLIc
 QD+umchMN5vmEjhiCToi7D3yHz1J2j1V+ZUgb0gfgiha1oVFYhtj1ZO2gAvJXoRBZ/LC
 FtEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMvIWOTGd4LeR60qJUbJyKhLwYC7MIJ5XSbrvTOe7q3D1s9f6zyzjPyOXzrl9eHHFVOqQSmzepO1iSgSicRGBiW4izx6Q=
X-Gm-Message-State: AOJu0YwcLnxgOqX42FycGlouj+5Bj00SbH5SGh6BF8x840ucaOwajCAm
 UwI+zY7Ida1IYKklEusKpqQIAxDHqrodYRFe5oMuQatzpc0tch2eihxn612O41kILvMf6veZs8r
 e
X-Google-Smtp-Source: AGHT+IGvpryqtIodstzHmD+KSTODkCH0eXBYmlt1GDIzwwzRdrR4hd6p/CU7sg3T9Z+krFEIY8rpyQ==
X-Received: by 2002:a17:902:e5c9:b0:1e0:98e1:a3b8 with SMTP id
 u9-20020a170902e5c900b001e098e1a3b8mr8956123plf.64.1711393905972; 
 Mon, 25 Mar 2024 12:11:45 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 q14-20020a170902a3ce00b001d8edfec673sm5175268plb.214.2024.03.25.12.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:11:45 -0700 (PDT)
Message-ID: <273567f9-9fe6-4df4-89db-5a607a01183a@linaro.org>
Date: Mon, 25 Mar 2024 09:11:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] tests/plugin/inline: add test for STORE_U64 inline
 op
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/inline.c | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

