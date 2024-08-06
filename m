Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5624C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 19:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPtC-0003Ku-LC; Tue, 06 Aug 2024 15:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPtA-0003HL-L7
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:30:32 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPt8-0006dq-S8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:30:32 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f136e23229so11034801fa.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722972628; x=1723577428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P76gTOzFzXU4EN8b7uHbluQmlo5oYvuNAX6IWkFa11Q=;
 b=rBoqQ5wKKlZojwpIzyuo4TVCVj7GaX65/X1WlZ92ALhnmLft4LAlLk63vejTI9NGsU
 S5g4dAHCNwNZiYlZCCr8/7gGGDD42s4q/WFwwrNqah2RI6hMEam4eRD+MCend6tP0o8e
 xWHGBcV0r0VBnSdVTLUeyGNHpXs02OPZK0yVUf+/vI6ZIkABp7jz/nBYGHfjOwU1t9AO
 JgmCq3D3CfoqyR64QQIkjovYmTPIQwuicxTx7xC8jLK7hpgbmIgQgsMxz09QjqlEMDra
 3SV1l0l/Jj6vrbGLipx7ZCIe+LOKq71RVGSsUDE+5dZcGIoSD+vjrcDizMl0jy3lVYgK
 53qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722972628; x=1723577428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P76gTOzFzXU4EN8b7uHbluQmlo5oYvuNAX6IWkFa11Q=;
 b=bqOovvztKLlJnSR0FgAbMnAH7wJJ/tRNHPzLlzK3jFYuUi3tMttr9pNyiHvkrId/O/
 6lufp/e7MmN4xymO9VfZTZjjtrgOjQTUqcOfFPuTSM24Yz+Nm5Tkyee2XXeMKxwwuhrO
 wnlr6X9K6ys6ehDdp+7TCVPMtnmCIkYkZXUbzQUeOe1c0WdYvXPHbERNRX28lGCJsUkL
 LXpyE2rv2qW+IJBodNUKYKX8jYn2G2G3wCxTqKy+QjRKPo4zH+esBywnY23ZTQAmz+NE
 1OLqWdukMAO2AHhlex02+BGyYHtTzRV51ao7QkLBl2ReP4HXxsz5+PQMdLuh4AKeDXn0
 ZN+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXq9lD3JXpejuONtrpHwmRvAYNXELHkb/hRHHZ1vgPpDRmJYUv10cVfcRoaMbh6tigKzQ/nQ14cwxppaqBDA4uZbRiKbE=
X-Gm-Message-State: AOJu0YztWBJawTPd21b8DyOvC2j05YrBGuU01dlwm0s+syjyS9KXLHeC
 4S5p+5EnCUyuGqI+WkqVxPWLzXI3xggm+pKcbGv4l2dftl4qYfhOIhFUFxA4w/Y=
X-Google-Smtp-Source: AGHT+IEr8TsGyQqAdDFzXKk6b+H4wmROdXIZsZxEzGySz0nVAFbPsUXyNA9aBvNixrGUipAd/jr1vQ==
X-Received: by 2002:a2e:96d1:0:b0:2ef:208f:9ec0 with SMTP id
 38308e7fff4ca-2f15aa92e12mr116284951fa.14.1722972628189; 
 Tue, 06 Aug 2024 12:30:28 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-141.dsl.sta.abo.bbox.fr.
 [176.184.43.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm188941585e9.16.2024.08.06.12.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 12:30:27 -0700 (PDT)
Message-ID: <fff8c0f4-881a-4317-857a-0d20a72484eb@linaro.org>
Date: Tue, 6 Aug 2024 21:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] tests/avocado/machine_aarch64_sbsaref.py: allow
 for rw usage of image
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-9-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806173119.582857-9-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 6/8/24 19:31, Cleber Rosa wrote:
> When the OpenBSD based tests are run in parallel, the previously
> single instance of the image would become corrupt.  Let's give each
> test its own snapshot.
>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 756f316ac9..f8bf40c192 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -190,7 +190,7 @@ def boot_openbsd73(self, cpu):
>               "-cpu",
>               cpu,
>               "-drive",
> -            f"file={img_path},format=raw",
> +            f"file={img_path},format=raw,snapshot=on",
>           )
>   
>           self.vm.launch()


