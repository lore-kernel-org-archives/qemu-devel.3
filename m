Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D30C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 16:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5SyQ-0002wh-S2; Fri, 10 May 2024 12:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5SyP-0002wX-5a
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:19:53 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5SyN-0004wG-Mi
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:19:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5a1054cf61so571379666b.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715357989; x=1715962789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWaINDpkj9pDg9A0o1hNILdV5O6L6QJA5CUGOsQQC5g=;
 b=rBhKaINB1aT6EoHUG8prwnKMizi4fASOCjMtlNqYJZZnLHMskkTifp8n4UAL0gDP3c
 U72pLjIp4hCFM0cBfhdDQJ712sI/mnLSen+dq6r5mAonks9+KFNoqNBJhieLCgqlSgJe
 EaVhrsUh/pfRCXwq/GFQArl1+dnymTui5q18k38PmghOuKVH2FkxuqVveXATx6SPPIX2
 e+7PWQd+ZncYskF4TQpFWNoVxDNVAztm+I+fKnDOUb0Yrdr43T38SQtMP59NMwYAoAW5
 wJA86Q2DFJ9ncdugzhjhRkWLj6HZrdPGXgwngOQZ+xHUz68WEP7cp/wCBo9H8jURu/QU
 2xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715357989; x=1715962789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWaINDpkj9pDg9A0o1hNILdV5O6L6QJA5CUGOsQQC5g=;
 b=wvQO/L9crAJmqmvequaMr0K7EfTDJVSImb3ln/UI7ba4Op3Bq3phUC1nk2pTp+1Ems
 RUzXmyykyrII1w0ax/7jWTa94mYZfATR1fwdKs8Iuty8eLszA4q48GOXeg+bOUlPC0ub
 pwyhwRoYlf2f3JWPCrOebLGgfUpWriJWXvfeNcSgyhEjD/igzSu8wfqNOPphLv4HRkcd
 H+MIaUSrCz77A3I6fchi7YTtnh6Gjjvb/pfRtDcNDiMsqU+tXkLEki9dTMRYBjlcQUDW
 +5uAUe8rozZvf79pURevjb7++1ym7cVFGc2XnaT/CX6a4q5OQH8ANgXlbaA8d3UW4fWL
 Y53w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTPZN+TZimGXxP2nUwPqR7eNWHJFX0J7X4n/o0pY6V8ORWULFDU6kdSEOH5lXgGo2bg0b/YZvG5rxdFeplvFUKCrcDSZE=
X-Gm-Message-State: AOJu0Yw89Q8TSxoFdMU8y1OHylhJ9jVvyHWLinyXC9m0vaFR8a83I7M9
 MfgyuHWP3+t/93LLMuooD00DANXTtu2tB8N2lOLNvWr08OSdQEzyyj15kE+zrN8=
X-Google-Smtp-Source: AGHT+IGKOGdvmOKvxSzAMEXE7XtCA28JCfDpRHToyXogDAzSF2cI8m88daXBbiyKy3qP2FEaeu5IVQ==
X-Received: by 2002:a50:8ad5:0:b0:568:9b13:77fe with SMTP id
 4fb4d7f45d1cf-5734d705aa5mr2986398a12.37.1715357989254; 
 Fri, 10 May 2024 09:19:49 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bebb172sm1944657a12.27.2024.05.10.09.19.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 09:19:48 -0700 (PDT)
Message-ID: <6c4f3d95-2c0f-4d23-a739-40a14445d4e4@linaro.org>
Date: Fri, 10 May 2024 18:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/41] target/sparc: Implement FPADD64 FPSUB64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 3 +++
>   target/sparc/insns.decode | 2 ++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


