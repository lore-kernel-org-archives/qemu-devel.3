Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B4CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg89L-0002i7-SB; Fri, 01 Mar 2024 14:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg89K-0002hb-CS
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:02:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg89I-0004ut-Nn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:02:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412ce4f62f8so2313285e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319743; x=1709924543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ik6Udu+u0V0AoG4sCCvEopHF/0Mkf9lDdZ3id+cEG1M=;
 b=Uy3S1TQ05h6J1+78PfQaQ8Ezkd1ulFy7z+6hrc4IJfxB3sdyptelEUC+QgMakhTCyF
 FyO7EuuFQNjfLLk4pVwY0Zbyc4H8ygwvELr+sF2RyVVrdgtO9xRp7AX4VZSVPccBkg9r
 AxKhZMkeDGLbBEga91/1Nelomc1wkytD737KclYJbthAWhEdGhcr32GJC6oH5GsrInGB
 gDJz2FPaRziPsd1Xng00XlZjmXWmPPV0SJRmYhXCXTtEBDrSS3eeGeHvaFTRfXE0lWhS
 8esL/7dBEwdZImYmo4vma2Svj2EC7rZRii+43ZVMjYfCSvTad0UmqtU/HDNEvMsc6bBW
 nOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319743; x=1709924543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ik6Udu+u0V0AoG4sCCvEopHF/0Mkf9lDdZ3id+cEG1M=;
 b=LEdYYWF+EWaItg87uV5VAjBHq/Gz7wWxins71zPczX3FUcEa2A/rAd+BfU69iZUCOW
 RfOCrBE/ofa5twW4JwF8ndTVXKBgMCnM7l7SC/EnEiJR5k0UcJz/yDSqhkdS0/1j+61N
 uSaFm7PIUvD8rU1fV8zMYQshNqEWIIZgyQU/bP95b0OqgDTfaJ0vnT7W/kcl64lbHANQ
 Fx7V6xJQsyzoQRJ04AKDow0beqocWuClgGiHfSJi2V+/iDg5S+7besHyiZonDpauMlzG
 leRFqAS0HykTV4MsE0gl+nvMcsNxb2CitAZiqv2XlGwCplHI1fQUUu7F3+XEI/ks0Lr6
 xVQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVktZ1/YZJwtmhZ2gE6an2yyakOGZ9D0Rzyef6E0QTNtTSH4m6KcoBRzV/9JtJnutDXEC6n6wf68EM4o0irw9l5tTyqHi8=
X-Gm-Message-State: AOJu0YxjoaXLjrTV7n7/iEy9IkV2qa+peSlZFFzM5adFPjZqt1IvZvPE
 Xn5ONKv7zaLU+Ek24oUjFwZe7DpTSCUG57yQHgJi3r8Yc66N4MI/RoJZCblv9CQ=
X-Google-Smtp-Source: AGHT+IHq6DME2Du4SJz1rWBWv+3MVSCEQ7Et6R5HpEjWIwGUc2iXO/EQOeqjCt11lYFhCM9dppMdVQ==
X-Received: by 2002:a05:600c:3581:b0:412:c29d:a3d7 with SMTP id
 p1-20020a05600c358100b00412c29da3d7mr2153330wmq.16.1709319743128; 
 Fri, 01 Mar 2024 11:02:23 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm8572229wmo.6.2024.03.01.11.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:02:21 -0800 (PST)
Message-ID: <b7da1f46-d4cf-466b-86e4-1bbcb7d66f71@linaro.org>
Date: Fri, 1 Mar 2024 20:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make some structure static
Content-Language: en-US
To: Frediano Ziglio <freddy77@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAHt6W4cH+=pyxNZ9F_8Yed4K_pYfO-qP6iNHQHEYLvWUk+aGUw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAHt6W4cH+=pyxNZ9F_8Yed4K_pYfO-qP6iNHQHEYLvWUk+aGUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/3/24 19:56, Frediano Ziglio wrote:
> Not used outside C module.
> 
> Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


