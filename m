Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNxZ-0002TZ-AZ; Wed, 29 May 2024 14:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCNxX-0002Sn-D6
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:23:35 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCNxL-0000Eu-41
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:23:34 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6303e13ffeso277077566b.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717007001; x=1717611801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jI0W/RaXScI929ZXj8iGCbMlZvYmvHRfJYcJDyl3+zk=;
 b=r6v3UfTrSPJAyfni93QRpUe9QOsv96n4G/bc3K5aR2uoArHmrxeTbezsy7rj/CMHvK
 5El9sYPQWi+64lsm4gjRbeCJ5NmLbImUI4Qo+s5rVTSE8nCt6DfzUuSKAi0CpVb8NL0r
 cgrjL7mXep/Bh1qjSa2gJw91iQnvWe/ZukXf6CatEVM5BIQzvfbtlfacrlsnO1P7YduX
 ZOZ02wcnmNOpaco5D/GcNMNiPdSb7yiVVBP+k+tlUEq2hFQCVL8mfwifGUQ7Mr+K8mmu
 t2eY8KeV0n7i94q2tMOBoibB6aHtPrdhrOgIMhWHDE6BXZ1raO4DFclagdycTtRnQrA1
 hitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717007001; x=1717611801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jI0W/RaXScI929ZXj8iGCbMlZvYmvHRfJYcJDyl3+zk=;
 b=aLvOs+TsFl5G35ABW3i/wG1lEOx2uI1vK/fvoSSRAEPL2spiUJfyZcQbkVNiwZunIn
 8PVi6zOY8v7TO2ucjjYu9KUrp7TzfQ6m+M5r4XwB5lCnGnC8kWx/+rd2NeWnkjBq1bO7
 r8v+Xc6fDOcZuUwkX4luJevFH8Pv8jco0mXtIbq7uLsG4/kCTGFXLGdo64KYtAfcJSWu
 rX8SsN+fVBpJhnoKXZMSauvgCvp3mF5W5bjLQrLz5oQKxxi9O37SGCpwg87+LVhXcfCc
 OwumsGnwuPtmy1cTQRujh/XjAk/+QalzDSLN5U/ohhyj+Q6/7GJq5zWFTq7RitWsG6r4
 o3yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+2H0DqV7SCzTwPw4lWhhhxKyVmGvHzp0BNwurz8NUprF0cGtk3hnyRhK/dP4pE/nfTmh0gfXtz3VlikIicjjiQ5OH1nY=
X-Gm-Message-State: AOJu0Yw0K7yG7LKadsJKOeyWfzOy9qIAyeS9JSWk3QSGa+nOhjKL0NNk
 a2KZ0Y2F0bULXf8nKnm/gfqzXDQ3qezeOWjCwYo+IcQvB+2sFQB2VcveB8f35Ps=
X-Google-Smtp-Source: AGHT+IHu/8MBWTy1CJpGsCsLePgdnpElwMjNV0i43EX5GhjEKkUgNBi69kAVstfEoRnWq9qPweLd0A==
X-Received: by 2002:a17:907:971e:b0:a59:c090:777d with SMTP id
 a640c23a62f3a-a65e8e4da2amr2515666b.21.1717007000667; 
 Wed, 29 May 2024 11:23:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda8bb3sm740080766b.223.2024.05.29.11.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 11:23:20 -0700 (PDT)
Message-ID: <f03128b1-4752-4fc0-b7c5-e374f67994f5@linaro.org>
Date: Wed, 29 May 2024 20:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] MAINTAINERS: drop usb maintainership
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240528083858.836262-1-kraxel@redhat.com>
 <20240528083858.836262-3-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240528083858.836262-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 28/5/24 10:38, Gerd Hoffmann wrote:
> Remove myself from usb entries.
> Flip status to "Orphan" for entries which have nobody else listed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Thanks Gerd for your contributions in USB! You taught me a lot
there, unfortunately this is still a tech & subsystem I don't
feel comfortable hacking around...

I'll queue this patch via my hw-misc tree.

Regards,

Phil.

