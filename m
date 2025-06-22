Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7EBC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8f2-0004he-9f; Sat, 21 Jun 2025 20:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8f0-0004h1-La
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:34:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8ez-0005vb-4m
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:34:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso2303546b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552452; x=1751157252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQKq9VPzQu2m/paj8efF0ht9BTQlnBGHLNhyyPz0tU0=;
 b=rQIgLtf9DWUowHtUEi6KQq5XQHhOAmRaLxKF8yVAruH7e4cyaZ0WRZJ03jBqWc4Sux
 ncsKLrpG8wfU0xMnfEuH7WyGNcfzEbVFXX8WyFiZyrxH1qQm3Id8qCDIVX2ncjleSm3g
 R/pPAAn9yO2i1JLvATFFWSyHh40ivwR4Fn4PgeeCkYNJq4glSLj55m63dQUqVwVg7lht
 71wslylLSUu37ntdME5bDLxkaq2XlMNPk4hhVxdAKHmThTdGbzGPJXDh9ssulUJ9Q2uT
 pTWGnoUsq5nWsrCZPq99Y10C9E/EUolTIaovxGiJt86yfqWjNx4uh7CbDdYyC+d9keFA
 +/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552452; x=1751157252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQKq9VPzQu2m/paj8efF0ht9BTQlnBGHLNhyyPz0tU0=;
 b=XNmCAQ1H4QZ3mRMVr1D2bqOC0DUZeBFaa8z3p0Uz9SC3qvDF6j4mXgXeUkq3qYN01x
 SBniOoAHMnMdYJSRWP9G0IExqDhW1c2z4DlvrOF/q9rXrPEQ67vPa5is9duqWs2/DLgH
 dCR3tcN7Wo24NIOHITGBx0d1YGeQDFCcET2yZKoXfeUS734HoDnbaZ3Lr53Idgaby9cC
 YUqW92yfaPSZAHVVBRYt02DSoVV4yBtGymDaIo18HHrDCDunJoPnmd8Qndk8n7PTeREV
 DS7NeL1mfdHuoFNw13Tduevr5iE/mWo3Jta7yCGQMIkIo1IJ0+qb6JXLv+uqxluk6Si3
 7dCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBC4M7vRhHyGYAGJFHRrbpF5Q+gPfu/6YQDMIa5yonRsCqdQO5UTvihCMMpkwM5w80hdZ7OAsowRB@nongnu.org
X-Gm-Message-State: AOJu0YzF5XNt3pCg+4JT1FDix/ExsX58D3imEm9+4g/6S3FDDmgr5Muh
 uho1AAirA3tGFK/4NxZzJLwQRHrOj10HwAJVIBUW51Iz5auYHgRC2BtVVEg2VxkfaY0=
X-Gm-Gg: ASbGncsmwOdCmgzDqDaKI0zOfU/Euukn8CcDJfDsqeDzC95eFQGvKobOq2wWR01GhKS
 eXlXuK2pue87uZ6WuQKwPu6B470LEH62J7X946BCouf+Asl0+Hd4PO1pc+669ECQp319W6fiQjG
 ZOWshVyQmKiTeh5IBi5g41EatMBCM/EMQi15uBo5S310qnBiirQxrDOYqBwL6zvX38JPHRMEC7j
 Q5viK9bxLn/BiFhUwGqvu/+OfPNAEgc0tmS0cA4cRWh03FH2deA3WFPG1NAJN0zbFyhV3AM+9Tr
 IyWpZUAvAhorh5gZz1x69IRfBqoCKDcNWysn+EBNVGjA+QA5crAhhKd4d8WOuZEPtg9JnptcePu
 0ydCuvYIEoaEvJgQUwe2TptoyCiGl
X-Google-Smtp-Source: AGHT+IE9ZIuXLJEu7AWPd+Sc/mHQkW/SCq5II3XmQewc9+ZNt/tbdvyhY7AYKtITLwaLNN8urQV2zw==
X-Received: by 2002:a05:6a00:22c4:b0:749:112:c172 with SMTP id
 d2e1a72fcca58-7490d691208mr10318918b3a.16.1750552451700; 
 Sat, 21 Jun 2025 17:34:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64c203sm4946969b3a.112.2025.06.21.17.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:34:11 -0700 (PDT)
Message-ID: <9105ea2d-1f18-4977-8ca0-dcbe6c89b166@linaro.org>
Date: Sat, 21 Jun 2025 17:34:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/26] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-23-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> Define RAMLIMIT_BYTES using the TiB definition and display
> the error parsed with size_to_str():
> 
>    $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
>    qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of RAM
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

