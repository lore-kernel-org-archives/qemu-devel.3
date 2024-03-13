Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22527C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVq1-0008Dd-6E; Wed, 13 Mar 2024 17:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVpz-0008Cy-Vf
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:35 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVpx-0003D6-Si
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so217687a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710364112; x=1710968912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+T1OJ8n2AkxrRONxqmgCn/m1nsvJmxIrQyvQ43FDrw=;
 b=j6bMwuWgGbxWJyZcNDXhCUAW8s3dgPoxwSfZg1GXFhtmT21t5QsrMn7f5AuvHkf8Kg
 iVDBnOMUpRjwmAMcozM9H8oWoJt+3/9D6229Z7XQBp2uOAunZyg7wkeo3KYs3VpPayvy
 Az8BWBcnvOfRmgNL2OXOuKPVtKVXXsPFrqQAplBJJu6QO9u/9pGS28jQzeEL4dFt3jnf
 iPcuREWwgfhjT/faPC38d7gI2Yqw42KSq4XBOdtDrhMoFvKonScRp0tdo1mXhf3kdTuY
 mE4ljLoDu37UICBFJpQ4doTwrqz3GEibAm6ANsuIchQvoaMgEJ7EW7MSBuzcm3ownoMu
 K5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364112; x=1710968912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+T1OJ8n2AkxrRONxqmgCn/m1nsvJmxIrQyvQ43FDrw=;
 b=N1meqAfsfy8hjpqLqtW+HQVqY2O+RcA6XNlYpUxsR0tBMwMU0PEvGLXrEgEfa9AIDs
 XFH4wGafvWSsc3zi9x2YWVziuZovm6hi089Pq9SZwYx8cvC2v2YXoTbrpSwCUoE6EIP7
 k3vB5O97ovMjVF3MH30t4c0du4b9tw0RuqsV4KwisDbMt7MdtOCNmqulfEg9Z6YRH7Ff
 A1on7m10AFz2/xXS2IkfeMlepihUdNUJVWnMbfDmXjdh0WpR48Pye4CDVfBihm1/iSyj
 FT+GpNhP1CE3qT/xI1en1HA5mjnVHTfeojjo4pMCBXJNwjcd57z4K9L/yFSutuJXtifx
 h1Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4cAKVlN8wyetk1jA3JmSaspgXNzjOvG/wGb0H3PvLgMlcuV9ShFvdcZvLxiwH8ja3IylwbiRrPwogZ+SoW+p+2jHxZvg=
X-Gm-Message-State: AOJu0YwMb+xOdnfHSMR/8XkhznMg2+ZWbB2E+bBEVmu4pTZICLJQ2pIA
 H8Hqt5cl1V/N4VMt8JwR/uCUWx/S8MwVE0LBbuCiGeVOalodzJW1rzgZ5dCO+ww=
X-Google-Smtp-Source: AGHT+IGFTBVwrbvSN6BGFJwef/0KzeoNriwLjz3Eg1R+9P+6x6hlRJxzj217tyqWBCedYxeq6eYP+A==
X-Received: by 2002:a17:90a:b305:b0:29b:8821:624d with SMTP id
 d5-20020a17090ab30500b0029b8821624dmr11656430pjr.15.1710364112043; 
 Wed, 13 Mar 2024 14:08:32 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 qc12-20020a17090b288c00b0029bad32fe5csm81470pjb.16.2024.03.13.14.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:08:31 -0700 (PDT)
Message-ID: <f6d379cc-3466-4ceb-a42d-a84afe1ec501@linaro.org>
Date: Wed, 13 Mar 2024 11:08:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 2/4] accel/hvf: Un-inline
 hvf_arch_supports_guest_debug()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313184954.42513-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/13/24 08:49, Philippe Mathieu-Daudé wrote:
> See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
> functions with external linkage") for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c  | 2 +-
>   target/i386/hvf/hvf.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

