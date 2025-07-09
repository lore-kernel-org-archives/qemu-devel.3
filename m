Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD44C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSge-0004Eo-UI; Wed, 09 Jul 2025 07:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSgW-00049y-Nh
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:09:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSgV-0001Nn-6k
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:09:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so2917222f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059393; x=1752664193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lnlJawJwiBBsPD2/oQefZofP2zkXa3ZiCl249NTSBtc=;
 b=RZlLaIChB6ku1fyTYHYMfRrCokplSV255v1+iafZ6AEW+UHXhdrbtG8AZMtGsqPwPr
 id+cdQWqmIk+RMZU77ksYeoFJno/6ALaQHfY4VgXU/fmxqgfllkVIHEAB8CsN5rm5KZ8
 xpmSUNr6yCG6ny+B0svYlbktkA4+Q5PCE5pcHdpGXCrDqrfnXq/nPjygH5HDMEbg2C90
 THk0rHfYtt7gZXjfRpQucGwywrPP+35oeNeKAV0fcpWdzPe4/kKzQpk6jfC0CxzuqY+U
 5bTL8Q7rWdNruI/Y/CQo+v6bU4Gnn95mhkmfaDLoWgMI1RIasZjGR2z6exT7RghA5Mt+
 9XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059393; x=1752664193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lnlJawJwiBBsPD2/oQefZofP2zkXa3ZiCl249NTSBtc=;
 b=fUjoH64C2nmTv44eKKgzcf/holbPWW1tRTiBFIhD9t0IbASuAzGBeELCIiHU/30ofP
 XjrNPfxJD11K5twqDWUk/tQv97KKXwI2JBvv6q8RH+I8EKPaoMfS1ihgBoL4plMI4/ft
 y8FoGPAlvhHj7evcPwwpRe3DhBRq6Pnx6D637GgweSX8X2c4NPX33HkTNc4Pmoxq6q5s
 XSzWFye2tYWUDCiJ1fGUkLeRDOdJScOdkNfzgfJ70txHmhkXaQe5DC6ydF2dq10DVcOB
 L3L2DLb1GkN4RA9NFccrwUkTT107kwbCOQgEMwY8R7SqNRK7HVjhHIqRMDAkMqmg+7iE
 YGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLf24gYo/pOpz4ploatKKE0LtvN2SIU0P3PWQYbIKxWQdQV8WGvZsIZIBHdTE9sz6Jna/1LqJoyVC9@nongnu.org
X-Gm-Message-State: AOJu0YxO8UUXKGC0jiNyesvAvzcA6tu+z4Vp0RZeEpfNlhW6j4oSbAY9
 a02j39Iba4MIH6amVXC/dMGz//McacC7Bg/P9fG0hkumPTEWf+ZOVdfjM7oynaBy2y0=
X-Gm-Gg: ASbGncsP7yPCeaJR2JKQnG+/iq5NzScfNTJUR/dHRUVMfWBTgAjuelLGxQlxxnifCB8
 3DVx7W43t6bTiMj58ryDciWtovMC8fbdZud0XwB50VquO/+P3vlSSr73v0u/j1W4AvqewdBhCWf
 n/WnLtgGrX1I78yUwmMliMWFMn5GXOiN0thBy3Po0kV1luXNNVXxMfMHyAV6yEHg364D1EvT8TX
 PYLF70/yfP8O6kP0SoJaBOmDp9N1rDSQXn232cy9DB3pnX6DgKEED18Gtc0IE7qm0prW3HSdWQh
 s7wsXDue/DAnuf83f6qYUHQP1EypP2OntaBOVYbrROS6hG09eKZnuD3EilxYqr0oX4wgi4shKO7
 jZz80Hrv3V7zNDfZE11F0Js0uwIzgmQ==
X-Google-Smtp-Source: AGHT+IGWy79WQTgAuNRNfgSzinGQftQSx7t7bXSM1jBLGTzLsKztU2cFpBehnMKdH/fGLLVkS1J0jg==
X-Received: by 2002:a5d:5d12:0:b0:3b2:ef53:5818 with SMTP id
 ffacd0b85a97d-3b5e44e2010mr1454296f8f.5.1752059393498; 
 Wed, 09 Jul 2025 04:09:53 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b472446fddsm15709316f8f.66.2025.07.09.04.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:09:53 -0700 (PDT)
Message-ID: <b0bb942e-477b-4050-8cf8-3af1795e00c4@linaro.org>
Date: Wed, 9 Jul 2025 13:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] esp.h: remove separate ESPState typedef
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-4-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618061249.743897-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 18/6/25 08:12, Mark Cave-Ayland wrote:
> This is not needed as it is now handled by the OBJECT_DECLARE_SIMPLE_TYPE() macro.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   include/hw/scsi/esp.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


