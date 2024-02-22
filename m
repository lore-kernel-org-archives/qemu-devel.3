Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FBEC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8MG-0004tN-2Z; Thu, 22 Feb 2024 07:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8M3-0004pi-FM
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:39:12 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8M1-0002RD-8B
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:39:10 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-512a65cd2c7so6390812e87.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708605547; x=1709210347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRJfDPXqdyiEqooCZK6y2objTKV3aGRbT3NUK6art34=;
 b=U9v1wl0TO4o/p/Kh15fnK1BVL5zX6/bK8huZ9s0ab1ZAs6/Ex3AQmaXDl703FntWEm
 zJFsPRxadDdh6T5XRMz/ftki3MJUYVT75utr04BBCJSjBls0IafTgWgbJ4Vf5lB6CHiq
 TgdnWtJgBQC4st+xwGO7ppT23ZzhT5q6FsTBlTi/rVjditQ9JBmTKxN8vRNNJ+Ybmhfo
 MTNGQUqzYelhedc/pacl+LnGHrnLNzqFZNOYD+aITlhl0rwg63WSPGQEBDwwURgbNpvP
 oNea1xmo/auT3SSys6VWUS08uTfbf4q+krek6du/YOtWHqRVnF5XFBN1gfcCChiWzm4f
 UL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708605547; x=1709210347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRJfDPXqdyiEqooCZK6y2objTKV3aGRbT3NUK6art34=;
 b=lT7oZRkhP4iavf1tQE2e5ExbbeIFYZOqwCFyRwXPN3QQjKnmwzhCXJYxSKM5fRV91h
 UsDfiNYzL0c4IdcQTClLhG6bjKabFekAOujiiAxg4Xsf5Qgf4PG2WPz9JGNBpiQfFE2/
 LY7q8uWoTriuPsgBake7fhk9JM7nXY6LqJdxnHVh1E5a2Bm02WMPBXFR1QgVeg3PiIqm
 ll5o8E1PNChnHURPnegiIy9qcJWj9MXZ2zTkXr8BR+rp95h+zIjqJVtr3TemmZZdNNsM
 X2eZ5zMBdnC53dOz6hEpbIwfJR8OBaH42bNxPkzFJZJVr+XsaB3Ts0HgTHvWll7eMqun
 Qc7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ap58RBwcQpG2gFGoDQrrrc+VDwhx9bQ41K+xFq/E9tTgFiq1WZfl5qbxIUlcc/jcqa+dTTgswZmcuY6aYpBg6rEXYRU=
X-Gm-Message-State: AOJu0YwVHq4pTKhLW9mKtn/KV6mZ4nTo/hzPaIGpY0OvuigWtq9taS9P
 MHtV17azpeS7smuZkaYiOv4jRTDqqoNVKtOe9ii4u1IG53zbWcf7IIwivd6llmw=
X-Google-Smtp-Source: AGHT+IFDjbzBj1tyShgtwQIAN+l5GE+0jiif1LRCPzIVn/vkkgfjGmsAyWcsxQw87A1lRqtgYKw6yQ==
X-Received: by 2002:a05:6512:ba1:b0:512:bda4:bf47 with SMTP id
 b33-20020a0565120ba100b00512bda4bf47mr8104889lfv.4.1708605547106; 
 Thu, 22 Feb 2024 04:39:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 fj21-20020a1709069c9500b00a3e5adf11c7sm4812091ejc.157.2024.02.22.04.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 04:39:06 -0800 (PST)
Message-ID: <885a8c0a-0dce-4580-8b4b-b72800e5387f@linaro.org>
Date: Thu, 22 Feb 2024 13:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: force allow use of pip in Cirrus jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240222114038.2348718-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240222114038.2348718-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 22/2/24 12:40, Daniel P. Berrangé wrote:
> Python is transitioning to a world where you're not allowed to use 'pip
> install' outside of a virutal env by default. The rationale is to stop
> use of pip clashing with distro provided python packages, which creates
> a major headache on distro upgrades.
> 
> All our CI environments, however, are 100% disposable so the upgrade
> headaches don't exist. Thus we can undo the python defaults to allow
> pip to work.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/build.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


