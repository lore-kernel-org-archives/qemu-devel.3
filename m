Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA9CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbjx-0007Qu-5d; Tue, 19 Mar 2024 11:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbjj-0007Bd-M6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:50:51 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbjh-0006h5-NK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:50:47 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d687da75c4so7951591fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863429; x=1711468229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNVA0EplqCfRRQZvEl5ZxCaAA+iQDrqu4L3CqXyV03w=;
 b=YtiS486ODAcmv/ibjgqmyfiFVCwkKR3S6uYZF7Y74Con6kUJnL5QY5GCkIDehUPRXX
 O7OmK7eYkaejezEflp+eApNC/EVzTjg+w2+g2cZfMU4tk0c1v+uGC8gdDSrE3EZ9t857
 9F1DRj0x5KDYdeLOwNwW4w6UrvwO2rMCUBt+nU0+x91Ulfxmf7WdOc3Kg0rRYKaCA1Tl
 O2nq10wau80otHmZF5zb7LOUzNTvD7M/XC0lgWcAdy6WSs8dI21EVD0elv+yuPvFy4HC
 O+hNCnRJPeRSAx0dQuQw+6vLYtzZt/2Nav5wXWAvj+v9cyn6JXekw5JRiyEHjKYD9vyc
 dZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863429; x=1711468229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNVA0EplqCfRRQZvEl5ZxCaAA+iQDrqu4L3CqXyV03w=;
 b=BN6naeYJI3zzmlioaZe8ALvhoSTycmnc38Z/2nsr/eLULqFfgecrOPCDx2PbvA0T6e
 y1dYJYCkaofFH+YVF2MfFBVGMJ8xLfWiSzyNQiSONIJ8jzHXIGMtAI7snKCOwBCOTj31
 qs9/l27zvwXXPv0YdjXpqRAw1TOe15GJOzDQXJt4B8Rgm/A6s8585u3LEQMVLsL9FlvD
 ND/FwBvAnvCIV18V5YqDCZL+meFzdCHKB3U6XvbgMnkoM0Own6Kmczm9Z+4+VldbOBiv
 QgyWUmXUwmMvG0X1ehuDIvlZanVkR5DrJqz1ywaaEjym2j1CxTj6ExgEFyy6n+zfLrCA
 AyUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP1rPgtGHGoVUNBiL+oroImSEZwF4pjKDDllH9Zb/R2CuFc+YdeKk94gM03+jaRCRPMPIawv21B3mDKFoJb7VlppfbhAc=
X-Gm-Message-State: AOJu0YwB3fojQeLe1BO+0UW+Rpq8x1fGmxJNmKeo8LFZcGIZ7WY6uL8D
 q7khvUT+twXZH8aH4fTsxnVZwqDoYXiamxmVNkPhLMBhzry5areg3eR9JVEQfRYghPw6cFDLbIC
 H
X-Google-Smtp-Source: AGHT+IHxAFdL1hMXKfarqu6tEV0OC1WnQBMsHYceW7YFZaS/cOG9jEslnGXWSWGnT2gfcDMYbHrTog==
X-Received: by 2002:a2e:8505:0:b0:2d3:e954:221d with SMTP id
 j5-20020a2e8505000000b002d3e954221dmr10053031lji.34.1710863429483; 
 Tue, 19 Mar 2024 08:50:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0041413546e5bsm5711005wmq.0.2024.03.19.08.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 08:50:29 -0700 (PDT)
Message-ID: <e14b6749-b10a-4e9e-98f0-33e78904b1f5@linaro.org>
Date: Tue, 19 Mar 2024 16:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] aspeed: Make the ast2600-a3 SoC not user creatable
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240319150903.413662-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319150903.413662-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 19/3/24 16:09, Cédric Le Goater wrote:
> Aspeed SoCs are complex devices that can not be specified on the
> command line. Fix that to avoid QEMU aborts.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2227
> Fixes: f25c0ae1079d ("aspeed/soc: Add AST2600 support")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed_ast2600.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


