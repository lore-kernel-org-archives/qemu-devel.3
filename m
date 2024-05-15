Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C2C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B7Z-0004TN-BQ; Wed, 15 May 2024 05:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7B7X-0004Rn-Rg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:23 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7B7W-0001Os-6a
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:23 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51fc01b6fe7so7192025e87.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766019; x=1716370819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YM3ewHa7Fo4NePz33KHws2CHBa5FWfTq47qMZgR+Yug=;
 b=jPJRbXQpIRX81j2I3j2kwF+1dO4X9nda6tvmZtmb4z4Y/dciA4si8hdgP6qFH7d66I
 NCC8QvQ2uGnNnyq8ZuN6PsGrg5J4rUBtKmrA3aOaywWFnTtf8DWkssIFITIkGn2GrGfA
 k0cUxDtID8sXIhujc7pBE3+zrSmykdbgBu+tsjNrhLIKNFRNobG1lMzVFEISfUCd/e6J
 WKFX8VXXE0ik05/BrQb9pXobUYpZ9dJ9t4v6qmmqxqW9wbc4Y1rMFIvnF+nexJLIIPw2
 63yriXwv3DwxpXi8ZZ7OIccaW0Hkvczj6TxM9Wz6eckqCfgWYfIys7RuMPVaLv1tHonl
 YFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766020; x=1716370820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YM3ewHa7Fo4NePz33KHws2CHBa5FWfTq47qMZgR+Yug=;
 b=u5SkQRZtEbSgTrhUTKvw7VVBUWtOcouI6jGKPznbI8njr9T5R5iBOycJpbMprWaq9X
 Cx+buGbG49a3Q+A7e/ym6YsK6/5ToNZoB+9b4yd2n8ejAoQhhyLfi7r6639ck0tsOIco
 VjzGVevFXHE3cKYhr1o60JQPOASE0+n4ZLKEJdKPpnIWCooAp7oXpcqIKRMmeDleV7W4
 e279xzTT4mhivbeIwr2txJ9Ai/dZS65wChfZUKQXa7ahlmnltCEffO3dw4DxmHa5zXw5
 u2sIJod9fVstD/kvFQJ0+kwzEOxXY2zoQs3UP+5ObDeWR9Oz0LcFRUjk9t+MiBxuNe9S
 LOIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTRyYm1Iomg1bchLTdgL6DnEWNhWQWiuIZf7e13z5o48cF6WN08QnFFHEGNSJ4x1/RDUFQJcLG8dmfcBdvcCn3aPbe2hM=
X-Gm-Message-State: AOJu0YxONz7ScklXhxprqdIHeMsC4V+gRSS5nuLnCzGr8OTDeAGqm8PH
 6hWanbNEgB1RtjECQU9ix7HW8s7zZLL5QSaAzlB5StL6TYH1CNtxgk90HLsOS0o=
X-Google-Smtp-Source: AGHT+IHWkyOL39owYG20oFHEXII8PUN4InS1607VsRC8tUg7SuODybrpn6C8L82nYpUm2TBmNyagqQ==
X-Received: by 2002:a05:6512:3d0c:b0:523:8e17:444f with SMTP id
 2adb3069b0e04-5238e17451emr1513515e87.29.1715766019636; 
 Wed, 15 May 2024 02:40:19 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad0a0sm16152410f8f.74.2024.05.15.02.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:40:19 -0700 (PDT)
Message-ID: <25c2a681-1705-46f6-9dcb-cf2d1b15881d@linaro.org>
Date: Wed, 15 May 2024 11:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] plugins: prepare introduction of new inline ops
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
 <20240514174253.694591-4-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514174253.694591-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 14/5/24 19:42, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Until now, only add_u64 was available, and all functions assumed this or
> were named uniquely.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240502211522.346467-2-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/plugin.h  |  2 +-
>   accel/tcg/plugin-gen.c |  6 +++---
>   plugins/core.c         | 14 ++++++++++++--
>   3 files changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


