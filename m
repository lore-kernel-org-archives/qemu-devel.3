Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCBDC79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpzT-0004pm-38; Mon, 05 Jan 2026 14:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vcpzM-0004UG-LD
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:11:36 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vcpzK-0006OW-6a
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:11:36 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c708702dfso276922a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767640290; x=1768245090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FhSHiaUAmchznQpwn/zLomPV++UqAw2HPkNHjU5ciQk=;
 b=e1FKKSDGFTVinc/kLyElFd07GxIbh9gW50raP9VVVGTHlEZpdxvsMz5oIMyuDtLK9g
 OP5E8M3/dZBhpIjMaKfD4n4CvmxQmSUZ5uv56Exbi47WrWqyS2GRisdUIkPhRld+rK6n
 T297uN2Bl0ZJJaHDaVya17JWoVzHR4lMIKu/fJQZSgqJAsvA4LThcdCs6RrOG81xhLh4
 TWZL5nhNuZpXLrqmUTLzNzvLSX2UIMZCKW75WxctZ8Xh0JPwftCHViCGqHnVk4TX+Vk+
 LBaIC0ZyuXgU6TAOYP/8Y1plDCoBZDY8jLHWc3h+aJGom2G47tbXCHCTDJR+fa/jpX9B
 ZC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767640290; x=1768245090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FhSHiaUAmchznQpwn/zLomPV++UqAw2HPkNHjU5ciQk=;
 b=qXNdSDK4kN9iBEMdj3fu4u1qN809/z3ATVJBMX6Zwj9vYDKYrHw2yaq8ySva9WmHht
 nbdrmp8rIWvrKRrxdu5NgH79raUawcC0k9M5GxasJJeSBPeQ5Rj4l5CcT3jt3S27ej93
 DfzBt0zffJpmndktqn3beGLm/dmvVz2cmkuwto8H4DmP9WJ8gNI5+7dBJWnVs+D6LodV
 EyUVvKnx0eHLsbPyLmMNasXwzmtLHZRdF1GaE4PEiuRc8kUKYV9eC77ybe5/dLoSnDmi
 1YmqcSl787rWYDGDntDEh6scWY9iGRHjB7X8nEMKWm/+o8XEW1bWHQKvV+GboQoxR9P+
 c/jg==
X-Gm-Message-State: AOJu0YzEIkWkkT4WKwh9hbHc+XwIynEDeJ8wBY8vu7RM8U+W4YVgU3iw
 P1BQdIY7VGnE926QTkunHOgs5H+KUPBzkWEtoU4gtIIe7mNUcV7IusnrCrNev0Z5sgjvsB/EjKN
 tt7NLecY=
X-Gm-Gg: AY/fxX46bNJe2mbUpDnD5WPjI5FmQeF7b7Z0exmOm801q3AT4kQx6eeD8PIdKaC42Jt
 B2QY0ijDU6a5+mN9QasAsNW6/GG1WtO8bWuo21r2sYb5iFieFlxlTUD6H7P6e3EFAjIoYVMU1t1
 fdywZxxyK9RFhGtYwVMpvOv310jlETxvnmxPuhqQIBK/UiHQKNlhXLu0kW0egqutOFva2GTCW8M
 Zcacw/SIJyf3TOOu3HNza39swQXb/JE3WjAoXV3TJF95uXbdDHWmbYvhZXtwQZcawW+vPJW+fwi
 V9ZNcuLLOmS6fm4sn7dqUR6xt7n63wmbDw6wzNr81Ndy6t0e15VTUxffSkPtij8tbi7AoIcq5ko
 b6gXZQU1qIDBSzGRWgqhZ8Pb/zNLWWWeaNRy2x1vLK7HPbVdHxWRjrt/1UOrJkBhrqH0O9WoYAm
 Y+f81EoiOKJY0CNzg/W6C7HAuZ7nGFXl2YZn26ejS0XR1SD/Q/38CGYL/9
X-Google-Smtp-Source: AGHT+IFAa/xJ33Kf7LBFZnR4htuVhvTIbaoMejmPyEziTeQ5F8S0JcJg4efLuA3GUddWuvOfqO7jWA==
X-Received: by 2002:a17:90b:1c07:b0:341:2b78:61b8 with SMTP id
 98e67ed59e1d1-34f5f301a25mr232360a91.20.1767640290054; 
 Mon, 05 Jan 2026 11:11:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa78f4asm92364a91.3.2026.01.05.11.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 11:11:29 -0800 (PST)
Message-ID: <5cab6793-7bb5-4272-83e0-9dd7a73188b3@linaro.org>
Date: Mon, 5 Jan 2026 11:11:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 tangtao1634@phytium.com.cn, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 12/16/25 3:57 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> User creatable SMMU are handled as well for virt machine,
> by setting the memory properties when device is plugged in.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   include/hw/arm/virt.h        |  2 ++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 25 +++++++++++++++++++++++++
>   hw/arm/virt.c                | 13 +++++++++++--
>   5 files changed, 54 insertions(+), 6 deletions(-)
Gentle ping on this patch that was not yet reviewed.

Regards,
Pierrick

