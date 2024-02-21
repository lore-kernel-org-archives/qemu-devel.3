Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B60CC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPj-00062J-VQ; Wed, 21 Feb 2024 10:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoM5-0001tO-5f
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:17:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcnEW-000610-RN
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:06:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d26da3e15so2884894f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708524357; x=1709129157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jToOqvLtcQbxy76UxGoAKsmsuFkgoQ92P/MuKUVl25M=;
 b=ueSzMcVAT/FxB4u99AdVIFC+kc1lXOtEGucCYJiYXkgz1DyD/HASPi7kNXU3XmwcON
 W45whsxBNJ4DbwOe3bm6df0WGggQG6S09g4hrjfqEdJ2fiEygFysnOkJ75cR4ZXraepE
 kQYno/nhiOzSEVNYpHiXsLKKd614NzRysFqqrQs50b4dzLwZ1L+8iAzmklUjrM5AoFad
 04j2GejVBYqllVhfpHzpVWzSnpvDmw7hVBVjRJJrS9XkgIZvSmiS5WRruwj9Ua13QquL
 Euf4X5+sN/hoLEb0lt8a5FCUWZn1yj4QkqrXSVMXA1vxHMix0U/qLghmPaFn0KxkAxN6
 d4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708524357; x=1709129157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jToOqvLtcQbxy76UxGoAKsmsuFkgoQ92P/MuKUVl25M=;
 b=cpF3cgwb+ZqBGG8CXL7Q3uDWqBo/MftAVUfEja3KRXSHoc/OdYh6x0h/ioD5ufnDVJ
 nFPupjeEV1IP9FMjK+jR9bIyKPouFNGr8FA0SVRtimZm1aaqRkft7Z4/eJzwt4jD2VeR
 8OuSxQiZO9RvZeAZ0DfjcLmvzGeuhX0oryGv7TKkwRXRL3XTg2cfu6+k4kgtcRovPHN8
 9l3PHjj8iSG7myyp0K2rJetKjnDl9FshiKpmbycHX18uLtPwosCI1ZUoxHrT4cDr2Wh9
 vUn0Fd70aZV8NSXRaGkfKPx3oW2ahGK2em093KVrBtMigX5QoBN9jiEhOBI6zotfQSBa
 ZvHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVteZWwzEgUyZ2cExqM5XZ2KRVNkUPE68i6UkGmQS5Byb1tfk5YhlF6xUIHxKcjKnCHrD5wiMhb1j8WbpMryupb90YFTCQ=
X-Gm-Message-State: AOJu0YxyODDjfaB0abmuB3fPz9ULaDA9raC9ISkxac8StCha2VP44P/x
 NQnFRPaSEHFrmx7Cc5b2itrLcONlsI7NF5c2mIYrPJxfQerj3JvJR72KMOAGxcY=
X-Google-Smtp-Source: AGHT+IFIi9jZw1PN13M2gmLjp+mpIEcwqXL/v17iqUxcJ5Id9WH64Mbpa/5e/uG27pb251Icki6FRw==
X-Received: by 2002:adf:f144:0:b0:33d:3cea:8484 with SMTP id
 y4-20020adff144000000b0033d3cea8484mr9666150wro.1.1708524357572; 
 Wed, 21 Feb 2024 06:05:57 -0800 (PST)
Received: from [192.168.245.175] ([81.185.169.168])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a5d6784000000b0033d39626c27sm12603630wru.76.2024.02.21.06.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 06:05:56 -0800 (PST)
Message-ID: <5a8a7625-16ea-4ed4-8c50-72474423e228@linaro.org>
Date: Wed, 21 Feb 2024 15:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] hw/i386/pc_piix: Share pc_cmos_init() invocation
 between pc and isapc machines
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> Both invocations are the same and either one is always executed. Avoid this
> redundancy.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


