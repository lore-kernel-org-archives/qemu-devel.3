Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A7EC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT35T-00056k-JH; Thu, 25 Jan 2024 12:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT35A-0004yO-MB
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:00:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT358-0001mC-NR
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:00:04 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3392b15ca41so641996f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706202001; x=1706806801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cr9JpdXU3GbCm6fwA2ztxGaC1b4yyAlZq+7euk6iCHg=;
 b=Ch1vbQpehsXiS5friEmWB3ADyZ1HyfB/dFXBpbwJvHnXcNFpd2/Y499S0YANJYfewN
 yRzPtfmoAqV0i7nH7ale6/Ei8BfgsOe6xHQPonkaBv7HfODXYAT60hN62rLrECa1zRv/
 o1uLuZ2eEJepDX9OcZy/3ShYQ206L8ldgj3kzimPXLjkJUI8my+iYbH8cEwBtE1hqsmN
 nPAtdNTHuSwJ+tCBeJZrWEjzDLfRYqTY0gDD9QjrlCyVVFrUEgzYWytIupp1E8WNoElk
 1PetBgud67DXfkgIk/1ynkcdPRXR9G9NCp4RX32zG4k0wEiCWl+Tu3l2/uwWIHuDxKG8
 Wd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706202001; x=1706806801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cr9JpdXU3GbCm6fwA2ztxGaC1b4yyAlZq+7euk6iCHg=;
 b=q94ueH+N+ksIOmjVTYGfNXe65p5dnJgwjNwNu7Coi3jMx9XUwvWSKG1DNbt/73aXnE
 PS4WJs5b8dU0SJilP+TnVJgRSeVGd3m+Py07Wi/5/iiZdPdyRY0WKWnzs0b82/OxeIgB
 tsYz57f1EUIACE/PQ/oBnj0G8aQCYprlSRalyMAu+aEHXJjjukdoRrv0vukHe4vG/eC0
 aFnh9i57q82q/4i9bJQRGfs+dDBwlT3+y3kvwdyfcu0UOUJjoLnto3xNQXCXhgGLDu9V
 OsGur1JQR2RoCIgyEpQKQ9X7t5Q5Ztw+k/cfcH8zvMdwlUQ7cNfsuOGpUYqsYNI2WX51
 5T2g==
X-Gm-Message-State: AOJu0YzfO5OMCpZ0q9Xqxuv1nYcSjLwkx/BjMoZakckoByvMecwVAF0e
 zQd9DUGmF/rAjn9R6YgLKDjFjqeikP5+qcjTvaPwCrM1dP8Fg6KvzYyrpvALdnU232UCoXWKbe3
 H
X-Google-Smtp-Source: AGHT+IHS2nU/Hq61hgpg0vZhykkkrbdBlvMdxKedfwpe5PVK/sAWstY6jAzMltFjGZuSLGy+0Is5iA==
X-Received: by 2002:a5d:684a:0:b0:337:507a:5c59 with SMTP id
 o10-20020a5d684a000000b00337507a5c59mr60840wrw.12.1706202001063; 
 Thu, 25 Jan 2024 09:00:01 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.09.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 09:00:00 -0800 (PST)
Message-ID: <494f1d72-661a-4ba6-8e90-13b2d4043fc2@linaro.org>
Date: Thu, 25 Jan 2024 18:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] m68k: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
> ./scripts/clean-includes --git m68k include/hw/audio/asc.h include/hw/m68k/*.h
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/audio/asc.h      | 1 -
>   include/hw/m68k/q800-glue.h | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


