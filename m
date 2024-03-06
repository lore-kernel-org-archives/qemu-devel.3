Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BD3C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtvk-0000Ma-MX; Wed, 06 Mar 2024 11:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhtvh-0000MA-Hy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:15:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhtve-0000l6-Sc
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:15:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412e68b8594so8890785e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709741737; x=1710346537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lylpHiC2EbHYYqOnJqHoOQ8YWNQzZIzbkk55keITdqc=;
 b=DlIGHBQq42P/qg9K2KZh7paj2z6GIY4fBayB6hLu1jmANvY0EBH/gWYrXmGRj1KnBk
 whsXssKGfcIaLefuIcTBb3oiiB9BawCejvctlMelgbMl6uXAJJcLCxzTD4x6NXWX4jTQ
 eyz7/lEEfqVvv/gXtRF8VCf/Nn5QFSVgMEHnWG6CVSwsWQ98tmY0jsRBnMnzh853v/lT
 qMKxJ98ilpCZ26K8KNKb3FjKXSM5SgS+pY1p02tUn09R6wi/nnry2u1jaVfgtx0Zx+lU
 p7u50ZjpfaCQ8Lq7ozB5U0aRgNoKmWjp8Zn/X8Gn30+FIe05kSo5Y6OKhZKPcyfpruMl
 mAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709741737; x=1710346537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lylpHiC2EbHYYqOnJqHoOQ8YWNQzZIzbkk55keITdqc=;
 b=fuPvX+zt1BO62Rnj1g1/siH6ioliLCiKrz/5yuW81pb22FujBHpX3WW0E1nUbWNqoH
 /Cr49VqDMveUZI5cjq4tVz2T+iSY8qsCVVlOyH+TSRXzb78l8o1M6Axp/+Fz8+d2q5sl
 l0ZenOHE/ud6GGe2+PbopuWMJ+g6ri8jmyj9x/BujXw7NFa37GS0FbqKEdvaGsG2zLel
 mcXxZ9to/WopB4jPvENf50ans7imJf8faZn4hVYiuURFu15oRWAyhusmpNNazWtQvmxg
 eGdKmUHE6erIFlv2ChALIzMNOUMnffD4/5+gQrom5LwRZJ3DThs7rYG+c/QRz2ov49nB
 G+4w==
X-Gm-Message-State: AOJu0YyxUm38/leN6WpkYo+ZMBRH9pR89QIj0ejOKSgNxUjsrYhe/j31
 HiQPvke0ORnWksCPWHam0FraUmdmosu8GxGa8a57T5YPLsDUPUE1wfsa4QoYYjo=
X-Google-Smtp-Source: AGHT+IHjzqSkzS5j3D1KMBCqume+i/E8SH4y+eyQjK6mtLWKUBX/qIE6uQrVXUcb9Tf4j+zzl6TdJA==
X-Received: by 2002:a05:600c:1c84:b0:412:e555:818c with SMTP id
 k4-20020a05600c1c8400b00412e555818cmr6193881wms.26.1709741736917; 
 Wed, 06 Mar 2024 08:15:36 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 bu28-20020a056000079c00b0033dc7e50488sm18410911wrb.96.2024.03.06.08.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:15:36 -0800 (PST)
Message-ID: <d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org>
Date: Wed, 6 Mar 2024 17:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/3/24 11:31, Thomas Weißschuh wrote:
> docs/interop/firmware.json is currently not usable with qapi-gen.py due
> to various non-functional issues.
> Fix those issue to provide compatibility.

Could we add some lines in docs/meson.build to cover this files
during our CI tests?

> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weißschuh (4):
>        docs/interop/firmware.json: Align examples
>        docs/interop/firmware.json: Fix doc for FirmwareFlashMode
>        docs/interop/firmware.json: Use full include paths
>        docs/interop/firmware.json: Include pragma.json
> 
>   docs/interop/firmware.json | 392 +++++++++++++++++++++++----------------------
>   1 file changed, 197 insertions(+), 195 deletions(-)
> ---
> base-commit: db596ae19040574e41d086e78469014191d7d7fc
> change-id: 20240306-qapi-firmware-json-6fb1213936dd
> 
> Best regards,


