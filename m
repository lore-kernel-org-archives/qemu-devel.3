Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7A2C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cfS-0001I2-L6; Wed, 08 May 2024 04:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cfR-0001HY-D2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:28:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4cfP-0008Iw-RC
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:28:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso950526166b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715156926; x=1715761726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M94vkI2hkuWd/G/kVs8MZ8OVGfLH9cw8gYLc4eTSCcE=;
 b=ZD5g7a7YvlpUAne5ZXM0W8Mkj7BEsAjUrzWTphFd1n6ItuHw5U+PBEXMVojMlwGIRU
 TUbUZ7DrKSdczoNK8iTssvtmGg56ZrBk6TuSzSKlaApnkWW2TpUkYAzfdvAZN8vsnIKy
 gdzZKfABMfQ2JgL7BQLeQNfjMslA3JkmuYV8EY0YbzHaaXzSmwTONUwWndM7K62BlCys
 6DryrsE2sosjvq3NxOwjuRi/VvwN6xnr0Ks5/6fyhOAduzBBoDSxRYxpAubmM7Y7wmi8
 iASd0lUxNTmrWN/avO0b7HgDKGeh728kBnXe88riUsT0n40/NKSmty6mOX5SnLSZlOIj
 FQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156926; x=1715761726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M94vkI2hkuWd/G/kVs8MZ8OVGfLH9cw8gYLc4eTSCcE=;
 b=IX/sYhCCaa3G7ZHtB1ba+V1X8xwUS1K/yZGOPFrAKR2o4gyrXV89W5PZsIi8tAyhKl
 4EhCSNM55Gz+nBKE6iiZtJD3oVozgMQP3brcbqCxbLcuL1Ctbm5KfyjzcIvxoRdhm8CL
 VmeF0W0ZUdEPtNdzwP9ThUWEGPmSjJvCTs48HPUQE6i1IaUYC3tDPVv290wacFfjTzJ7
 DBfdWwla9Qg08DgRWnii0z+mOBwsnBWJKazV/TgNzT7QzA3fOBJA8XzSjwI1S2WbUtT0
 nKBcK9iKGD2fdEgxxUcoB4ws4UWVH33H2lZnlCEbXhOqSyVyoQ6DJbVBWuSaxrDY8/Oj
 +K0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlW8rJ4BzIFt2VwkCHZoRMaX73ge5EEbnkkiW2pemRYiftMqoyL9MBcyJG+hY54cuhtrozahg2wrTfb8SDK1cZqu87r6w=
X-Gm-Message-State: AOJu0YwyVyqNWj/sUAFXzxN2T2zy5acEXuMvfr4ggZCQXSlsnazE73lD
 zQok2VfIAdpwDG8jLDdj9jFVnadu/h94NEUjRj0BJOztlEkzRBXPOgbKVZdEF/VyDS6UO0Vkg+E
 2
X-Google-Smtp-Source: AGHT+IFTvN2oR3xiwA6C/nZAv8fh5pUXDulcyY0RC7qBnovxqeK5aRi0g3psGN+MDVZzFR0HELAa/A==
X-Received: by 2002:a50:c008:0:b0:572:9fe9:1d7f with SMTP id
 4fb4d7f45d1cf-5731d9ce401mr1358807a12.18.1715156926220; 
 Wed, 08 May 2024 01:28:46 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 p5-20020a50cd85000000b0057259943ba2sm7578775edi.12.2024.05.08.01.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 01:28:45 -0700 (PDT)
Message-ID: <f754d4a9-f481-4da7-ae7c-edbb013f55d9@linaro.org>
Date: Wed, 8 May 2024 10:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: Update msys2-64bit runner tags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com
References: <20240507175356.281618-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507175356.281618-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 7/5/24 19:53, Richard Henderson wrote:
> Gitlab has deprecated and removed support for windows-1809
> and shared-windows.  Update to saas-windows-medium-amd64 per
> 
> https://about.gitlab.com/blog/2024/01/22/windows-2022-support-for-gitlab-saas-runners/
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/windows.yml | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



