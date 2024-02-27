Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7190AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1resvu-0002kH-GQ; Tue, 27 Feb 2024 03:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1resvh-0002hs-Or
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:35:17 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1resvc-0006Hf-Aw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:35:11 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3e550ef31cso444639266b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709022905; x=1709627705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7A2N/cn8tcziVfpedH/RKKGfL+dxT5FGgBXITiVvAUs=;
 b=rfaqXUXx3NrmvGEiMkZ8NMdwbsQ9gHb8ULR7QwvhMh2fH0JNVqsjqzM3rO2VOxEmdX
 VrCa1HL190kWYDFJXEzdt8VnAESakk5cx1W1bJIHsILH/iBKCffCGrwZpBymQrdoDNmR
 E1GYOkPquvUY754kYpklDb2z6QpXq/DRlonEsZtw0aEZV+0wDNJV74+ogFsLEIOjPBAx
 ljH+4UWExqS7MhHIlsxnv9P9idYy3AhEMgpGOR6UCQoub4b6556j3Qy81CCRG/awPEdq
 /gcBv7VDOYyKyY+RcC/5ALFW3O55UqegV7eU9aGfGeh1w8K6l/YuxUQGM7BtLyj8CFKD
 R9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709022905; x=1709627705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7A2N/cn8tcziVfpedH/RKKGfL+dxT5FGgBXITiVvAUs=;
 b=Q9gjReJcWB/77ZgHXeIq3s3seBpINLhkOfrS7ADoDE8PEBjFb09qaOfyVQeUyEpSF4
 W8Ax5Tab3HcQN5cjEhBUr7UgbtOqA0QJUAifQ/qysACVLUIay8vACJGH9eJuZJSx6Bv8
 q579yPjVvPEh03lFhnOcelKzLJxMJxcOhqLAKtYBoVACVfinEdUA4aZoPSH5pU56ZuH6
 HMhwu0pmZJQrjyBMBrfX1SimRu7i0MtKvtV4WG+OFbRAOhts7mEHme680XN9favp+Wbk
 TVJj+IKM7DKuIMMuqqtFN/FgBI2d+Q4AjANuAgwkHg+V6y/Yrr5xN6tnhcfXWoDeLuMi
 hD3Q==
X-Gm-Message-State: AOJu0Yxtc/wQaKMuo27rzusmcwx2TvHgy4fKDxGk+PyMadzrHiNSYspD
 mR2nT7yBB1viYFdvxUG10DF++98+D9PJOQElpiYb7wyblqtditZnR5ebZ4tajPQ+bSX17xp0jCw
 v
X-Google-Smtp-Source: AGHT+IHP4J0y0PVENENdEi0YnPCznC2GxT/BbvRh9vUZIjBvBzbvbcWoMax82HNDc6hQIGMHP/IXdg==
X-Received: by 2002:a17:906:6c8a:b0:a43:a566:c188 with SMTP id
 s10-20020a1709066c8a00b00a43a566c188mr886562ejr.57.1709022905549; 
 Tue, 27 Feb 2024 00:35:05 -0800 (PST)
Received: from [192.168.69.100] (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 m16-20020a170906235000b00a3d153fba90sm524141eja.220.2024.02.27.00.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:35:05 -0800 (PST)
Message-ID: <68f05bef-62ce-44c1-bf6d-343dc87b338e@linaro.org>
Date: Tue, 27 Feb 2024 09:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] hw: Remove sysbus_address_space()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240226173805.289-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226173805.289-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 26/2/24 18:37, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    hw/arm: Inline sysbus_create_simple(PL110 / PL111)
>    hw/display/pl110: Pass frame buffer memory region as link property
>    hw/arm/exynos4210: Inline sysbus_create_varargs(EXYNOS4210_FIMD)
>    hw/display/exynos4210_fimd: Pass frame buffer memory region as link
>    hw/i386/kvmvapic: Inline sysbus_address_space()
>    hw/sysbus: Remove now unused sysbus_address_space()

Series queued.

