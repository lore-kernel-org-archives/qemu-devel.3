Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7D7C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0Uc-0005jA-DF; Tue, 27 Feb 2024 11:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf0UX-0005hW-E4
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:39:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf0UV-0001Sf-Ms
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:39:41 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so2888561f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709051978; x=1709656778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmzEvvshvLP1GDs9Jpw2VNaIlVcbtq/GQDHmkM1hTWA=;
 b=Z791G7T8XdZZt3P4bHt4SK2y84GTKO3B+jS4UaQ9WXgXwbgAsn9y5snM1X8YpQZTU5
 HIskSjs++aLnzqcm3KX03lvrOHYsg2ibg2pKodW64LIg7ORxDrmD5ORodl5/+bhxAu9A
 yIhfJtQBc+dklFF6J6cv+y4YgPZeKKbTxKIsBQOuj9GkCVoTcJ/Sl3CDU07iIVcwLeZz
 uYxGtr7HJmID+rVIdC+yaf7dTIJqRNcsPfv+EjG5AdZVhyNvtyNjgL1m9n4dAUJ5ll0s
 yk1fEIld8S/sSkFQO+rUUK3pyTZz9MEh8FPqDpoD9ubR+8iqUoafXHYXgIMepKSwsqZ5
 OEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709051978; x=1709656778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmzEvvshvLP1GDs9Jpw2VNaIlVcbtq/GQDHmkM1hTWA=;
 b=h8ozinWvgyP5k5lUZjwbpbN5zyGQOvYhIKsQBW6CxaSsFh2EZkfkMpRui+OcbFMrgl
 hGcvsRwDW2UPMX317e+EVHUviUVQIKCRF/HMv2i2g1YcASMnuFgOguWcgEq8774dBLYc
 b48I4ZH9cBiNVhY5Lu1tJ9gK73AI+uaj9vXEoltfOM69wdhlt2Woqtyx0KzaQMPNxNoX
 QSzZDb0HpZDI87rC+/tWMoiHv55ED30S0YzyZoIsFRUQTPxlJ0Qwnq+ND8R0OB+r0dbI
 ntgCRuuXpDJv6BEj62IQq7Y4EiI6o5u1wXHY1KEOG6j4URMvTE/vBjIxtDbCtL8cOXNN
 aTzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW20RMolK0LTzHOuLUqoixu+c91GXz6DunPOsRW1fT95ahdjaWs7XcO+y4M8r5Z0P+hFQkXayOl8MEb6LYsl2HIFwKdJiQ=
X-Gm-Message-State: AOJu0YzFVsLngpEbcoZDiVwBXeLi0TkIZsMxJmp6MfRPBRkkewuZY/Uz
 Al0pKZb13AvDT/BxVXLrhrc79NC3Yx6gWnLgCErJtH8ZU0P366x33hBIeYgp5bo=
X-Google-Smtp-Source: AGHT+IFgAIDoS02I9wnMtE/LJsG74/7e8jY3O1FTsCcxF31calgLoDT+SASTlnJF0pnto8vMz9H0eQ==
X-Received: by 2002:a5d:6502:0:b0:33d:e74b:e41 with SMTP id
 x2-20020a5d6502000000b0033de74b0e41mr2049039wru.66.1709051977999; 
 Tue, 27 Feb 2024 08:39:37 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfce8f000000b0033db2d6bf83sm11734801wrn.34.2024.02.27.08.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 08:39:37 -0800 (PST)
Message-ID: <00a87926-49bf-4945-94fd-99f5c3a73bb0@linaro.org>
Date: Tue, 27 Feb 2024 17:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 27/2/24 14:13, BALATON Zoltan wrote:
> Other headers now use dash instead of underscore. Rename
> ahci_internal.h accordingly for consistency.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/{ahci_internal.h => ahci-internal.h} | 0
>   hw/ide/ahci.c                               | 2 +-
>   hw/ide/ich.c                                | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

