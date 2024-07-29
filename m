Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594A5C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYP4w-0003Yr-OH; Mon, 29 Jul 2024 08:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYP4t-0003Uq-F2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:02:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYP4o-0004cJ-DV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:02:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so10093555e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722254525; x=1722859325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qvSCEYggbJA531byaEkDr9vmqqh4tVOMW6xdeku0Eo=;
 b=aeeZ6LPj90giWwagvZV8KVaRbCFJ0ykb7zMqoA73/QxU5stZ3sL8Y1Lhz5ykRXlYlY
 jq7cAa9kMQsCjSL5k/X2AwMpzI6JN32mFHXmHXNtsjqfzJkcGTp+2WFn0mrj3bvfsXvS
 zg+mWt2AWaV3yO86Mp0wiYWV9/g9jRWYxcSdreGx6e2I3clHq01DuZvCkpEcD3SehGNe
 oAdw44zV3DgPsdwylgcXoKxtzP4pfBKmd5WJiXKCetJ2X7qnh+RSe+BZGicVEw6HFvZP
 DZTK577ZwHODNiT5o/HiTXTk0/OfknofnA4lTgSFY6LoMYaABEGihEledTvfBhbZ2EQA
 bDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254525; x=1722859325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qvSCEYggbJA531byaEkDr9vmqqh4tVOMW6xdeku0Eo=;
 b=SvdsXd/dDWbxXa8u9xdGegA+b3bz5ti35aYIz6y2Y0d1y9oafBrbDa3bTlaf2/Isac
 7SfUn8U8YaTKE+k++riXz4UEjia3JWNBixD/RHtAB5/99aafMzND1MqQ/AGkOtq+VYOD
 Hm5ZtAevzxlcxypzV44xY9tA7E2MjeyxMIn6UVDOaQzre63tg5GYR0L7O6OBRb8nn9U6
 7zHTOjA5/UAgsEukMbJhBX0m0Hc4DlJ5bVLLLfE1wNhvwL1sOmqJV9FABm4ul6Y1Rhkw
 LqLUOCuyL5h0O6Dag9fxFMRcd9A/92pO5tsBKTil4o6oT5yeEPiVEVhVd2VHXBfdfao9
 FZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDC0UkDAGf+IJTIAXykq4eMujZsbS6hhn7YstJohjlUJmtdnXgH3ATA1OE4e8lWI/mPXclA1jQvk8k4ACBXGebObiXy4U=
X-Gm-Message-State: AOJu0YyjhcvVOXW7R6432CY3xK/gdpG/386+gIx5aMShAOJBNYVkGO8R
 KsllTKe0nJ36uUneGD6AoP2L6np1s6Uuhh3OcKDeh/D+4UTsjG6zh51QwLyhDzc=
X-Google-Smtp-Source: AGHT+IFD+mPLCP16wqONM0xiaWZbeizYtEHeoTpsypYl3tjtLRKpY7ZoR1jjLZznwWE1Gxi4xvUPLQ==
X-Received: by 2002:a05:600c:a4b:b0:424:8dbe:817d with SMTP id
 5b1f17b1804b1-42811e6ab12mr51422695e9.10.1722254524621; 
 Mon, 29 Jul 2024 05:02:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280f9e3721sm108545485e9.29.2024.07.29.05.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:02:04 -0700 (PDT)
Message-ID: <2d85304c-ccec-43d1-8806-bdf7b861543d@linaro.org>
Date: Mon, 29 Jul 2024 14:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] Bump avocado to 103.0
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-13-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726134438.14720-13-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/7/24 15:44, Cleber Rosa wrote:
> This bumps Avocado to latest the LTS release.
> 
> An LTS release is one that can receive bugfixes and guarantees
> stability for a much longer period and has incremental minor releases
> made.
> 
> Even though the 103.0 LTS release is pretty a rewrite of Avocado when
> compared to 88.1, the behavior of all existing tests under
> tests/avocado has been extensively tested no regression in behavior
> was found.

Does that restore feature parity for macOS developers? Because this
community has been left behind ignored for over 2 years and already
looked at alternatives for functional testing.

> Reference: https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   pythondeps.toml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index f6e590fdd8..175cf99241 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -30,5 +30,5 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
>   # Note that qemu.git/python/ is always implicitly installed.
>   # Prefer an LTS version when updating the accepted versions of
>   # avocado-framework, for example right now the limit is 92.x.
> -avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
> +avocado-framework = { accepted = "(>=103.0, <104.0)", installed = "103.0", canary = "avocado" }
>   pycdlib = { accepted = ">=1.11.0" }


