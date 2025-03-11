Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD94FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxxp-0000xh-HX; Tue, 11 Mar 2025 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trxxn-0000ru-10
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:39:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trxxa-0007nT-El
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:39:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32857945e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741693179; x=1742297979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=thg6OV1i38O3zO5fYsgxFU2kAPWUsE6O8clbjSSChsE=;
 b=N4/z7cMIvehwqDUz7csnWqubpDC+xMYwGhFcM+U8P2PKBc2iaQWLVgVIb8Fc7hGcBc
 sAHdIhhXwuDEhrgC7HOgGJbtV5W9J8zdB7szxTfpSmRclrNuhFfVn2mCzAhvOjiGnZhT
 8LR557MhvuXG0MLWLeC4B19Ehoyyv54hYsmZ6wOPVVavnU+KsxOnr33CH2qdKovL0oZZ
 4WGNauUCXQEdZWfclZP43OpSbeIMZKIlH8E+2uDDiDqFDbyLqyOrF48Z6MVMPM0kzRci
 2LoWZTL38DNrHziVQcNnY1KT46svW26RvtwUXbxF+zrn7ofDQtOr7oBZfFtydNIpkjrv
 HR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741693179; x=1742297979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thg6OV1i38O3zO5fYsgxFU2kAPWUsE6O8clbjSSChsE=;
 b=U2wcDv9f0joIHSzaIq+d5uTx5G54A64Yjxprqfsjtu6dtbp8bz+eIUI8WZsF+bTL87
 jc4WJFlYgidESt4M2/xEXsDQ0FDcpvCDnlcqW6KZ/HHZAELb3F8juf1hcAyvL61D0q57
 bshsHbtHUaajtXdpvurXZtT+T0It0aUuqNCcqAcWmX7E/kX5szXXrQpR6JgXBb28h5im
 ZZRGGj+RzbN+c6HJVTokxA+wcDaKlEbO6xAetBc6x9WpywukCf2b10fUDlEduP6dnR0U
 OkU+2vV/FshpGF/UaWJ45/RwPfEIdNOKsmnhAlaDvgKOK6G0ZJ5p0BjA0/MR5AmxlCuU
 erQw==
X-Gm-Message-State: AOJu0Yyb8VVGM7UdRXOqBttpqa8gGEdCbEi4lS1bRHYAm2GJSsU2PQWb
 MeQrj8Ue189Md9B/ApyIfKV4JvlrwMcz7xrTfptONSSZEWelKQhXHnRXt117rpVKIU7NCs66zR9
 NN6s=
X-Gm-Gg: ASbGncso9ng7Ymu4j7DAgsW49C/ZC0NzIFFu+QdLbD7av3hUn7XwDw2ufSAwp/HT6dV
 oKyFL4bj30ZSqsRVc/GmQZZhuEu/iusTySVeT/70slK1txCsM9QGXl+F8KeNaE/OXKpbWAmUWp8
 3AkaSBgd4RG1x845Yebex0nTP1EKYF/PCXxeSGkTdBIervVATHyVfjYVMysVAMQCOLwMh8PT04Y
 IEus5RhLVCvvbj9DtUVyHDytsBjMMqgZZJQh1K2OLq3+DE3BjrVfSeMACmUOhwXTZGDA8X9xbJO
 QJNpyHzda4Yww57xXv1UuTNhcrkW83MLvrJmqqdCP6Wi01P6jIuXdUhWHDtAzVuCDxKXpIbt4fO
 JoHEZbHml/L7+
X-Google-Smtp-Source: AGHT+IGJO05ghk+Ny/AxAzGp0uVwm7HaKuERP/zrofaDB3PiPCqTOXrU8tPbCNTkk/sNUuxDuoaE3Q==
X-Received: by 2002:a05:600c:3b21:b0:43c:fe85:e4a0 with SMTP id
 5b1f17b1804b1-43cfe85e60bmr63940435e9.7.1741693179412; 
 Tue, 11 Mar 2025 04:39:39 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d031d0e41sm16578245e9.0.2025.03.11.04.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 04:39:38 -0700 (PDT)
Message-ID: <98083575-c052-457c-8732-0b3dbe33089f@linaro.org>
Date: Tue, 11 Mar 2025 12:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 0/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806141940.22095-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

+Pierrick for historical context

On 6/8/24 16:19, Philippe Mathieu-Daudé wrote:
> Attempt to clarify confuse output from the
> 'query-gic-capabilities' QMP command when
> no GIC devices are built in.
> 
> Philippe Mathieu-Daudé (2):
>    target/arm: Move qmp_query_gic_capabilities() to hw/intc/
>    hw/intc/arm_gic: Only provide query-gic-capabilities when GIC built-in
> 
>   qapi/misc-target.json     |  4 +--
>   hw/intc/arm_gic_qmp.c     | 61 +++++++++++++++++++++++++++++++++++++++
>   target/arm/arm-qmp-cmds.c | 52 +--------------------------------
>   hw/intc/meson.build       |  1 +
>   4 files changed, 65 insertions(+), 53 deletions(-)
>   create mode 100644 hw/intc/arm_gic_qmp.c
> 


