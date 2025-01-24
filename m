Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27C1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMQv-000552-EN; Fri, 24 Jan 2025 11:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMQs-00050g-MI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:21:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMQr-0004ds-0C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:21:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso1240595f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735679; x=1738340479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8L9e8RjJX6AUipajI0Gu0rivtd/9VW5/OrxI9Ba11s=;
 b=tCHp+YTaXNeoAAJCfVo605kCh7PdPuotVAWkMU460iSRGBcL1AbS+VkjNtEWB3Ywv6
 FGm9+RCZHoX6TYVhyvayWxq9DmMxbIXZImbxO2vOQ4YZorteid0O9/J5e4fybHVX7W7z
 SFfkoCP6MA3EI+BJf9/KqJiZmOraNoXvvnkKHeGiZ28KkMX9B1qSePdT6DZ6G7/7Weyt
 eHH76BhE/yAhWasXDupzLN1fsC1X6ZrLnj95i/Qwa4HO0gL6e3b3R3ym5cPRv9UkpB3y
 IyUrk4v7zrLLXzmhKF4QUpgrQDE6QoVPmCPtgmp9Lk/SRa8RwCKouk9eKfajal3B6X0j
 fAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735679; x=1738340479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8L9e8RjJX6AUipajI0Gu0rivtd/9VW5/OrxI9Ba11s=;
 b=ir4XQkzGci+LDZHIUph3oop8Gb2GcYPEp8A3QHvGbgX2SVU0uDbQUupV+xKOc07BcH
 u3JVSL0tFUGspb57IX4esbbzh2rJO7hH29TEyr+6JGIz61TfZHWgOtTIQNJsWf+vQOBD
 92xcQOue55ZacoQgoKmGkCoVIUrxJ7emWe0Fn613WEt6W68N+CAMzt6r7GXFcUwCMX6z
 Q/xMDk+HMGjuobrZDetXokLeFsUFPO8E1cxyGwIun5MScaHmAKEPYxPrJcakbDbYhO73
 BApCPzvI5y2IXYVgbT9qzgv3LAQfMqp0MmKV3w3AdswjQyz2SKk+n/Mu3iGh1aVmnRWV
 LJzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYpjDsWYF3XlFAfDjuWOZlgRNLB2WusXnfuMPvPYG3Igi1nAzuB4VxAjvYIfM0IQAto4s8f7FX3gyd@nongnu.org
X-Gm-Message-State: AOJu0YyfcLTbc8UzFDXiuPgmVQ8TbAKkkBDLjaJj5eCFBaBfssghZWqc
 Eq2ZgAg+f+98nmZGgvw774jKUfcclwGwAPrf/BiyIAU4m5UaIA1Q6GYLHimdaV8=
X-Gm-Gg: ASbGncvRyT6ME8XAKi8eFcUx7Tp07MIQG7w/jvektiXysFhZdATDVz4qUt7oGeh3LEE
 HvTiZlGctf97VJFZVcrypU7svh2evM7n349VxgO/nBanqlADAcTB9NPUeRGnxfrozHCHSINikxp
 2+o7jOsEGMZABduBkhI3HAEniFtHwZjnqSBaamVmS7S3abCJSSL4bSojBijloaM0id7BXo9G+JS
 NXFseBKGUeJ6O8vnOMegdrU8n5tp8GapxO9Q4YjgRJJrDnX8oPYEhLDTbBWdr82e4aIYMpROoKU
 KEio5WLSo3LQBnrx7C/ZaV2UtbkS+/GpxVwzwWM3D9iWoHrsZJZtmD0EYAI=
X-Google-Smtp-Source: AGHT+IGyVC9FLT40iF6gLFUBaCR2/EJz7t2UZTjgJwiiTjIrcvcsn5mOFuQFo/rKqHxjcJ2rlFMLrw==
X-Received: by 2002:a5d:5986:0:b0:38a:a083:9200 with SMTP id
 ffacd0b85a97d-38bf59eb93dmr32850349f8f.44.1737735678723; 
 Fri, 24 Jan 2025 08:21:18 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb040sm3126357f8f.67.2025.01.24.08.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:21:18 -0800 (PST)
Message-ID: <ae127f4d-e244-42e2-8103-95cd1eea2efe@linaro.org>
Date: Fri, 24 Jan 2025 17:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/usb/hcd-ehci: Fix debug printf format string
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20250124124713.64F8C4E6031@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124124713.64F8C4E6031@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/1/25 13:47, BALATON Zoltan wrote:
> The variable is uint64_t so needs %PRIu64 instead of %d.
> 
> Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v3: Fixed commit message to match what the patch actually does
> 
>   hw/usb/hcd-ehci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!



