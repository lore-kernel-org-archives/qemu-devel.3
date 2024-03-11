Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjjq-0000NS-Vk; Mon, 11 Mar 2024 13:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjjjo-0000AK-Hz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:47:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjjjm-0008CG-I7
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:47:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41330a62bf7so2435885e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710179216; x=1710784016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P94mp/Nb4ucHV343Y/FMYqLBRS0gkHikA9l9AmQ9xAU=;
 b=NjYzZU+G+5vJYYpfaaFALbFcQitXUsgJYoF/oEqnMw31eq4mbjw/BL66W+JkRzPzQo
 1nx7+P6QdcWv0OBo4Y4EEhbWhIJnDjk5saTCho7/0Qh+qxkOdKi7AUDtqazYYDbwd8Yc
 bfyOFtUZ6djoD9CFd2ZqZqi1L3a+Q2yxqsDM6G5ZACdeWlYLY0fYf8mPAWbwzVSSu2CY
 YVsV8ragKwdV+mDS4mPZnXAKPRsNpxSWnDXSA2LDEdaEnFVlL8/hRndIL7RBhkYw5DJn
 y4sij1Fw+0szByjFD63RSYzY5ZhU8Yzk402++qQgHFRTR7fDV3D2Exku/7pZWY8CZRXg
 NINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710179216; x=1710784016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P94mp/Nb4ucHV343Y/FMYqLBRS0gkHikA9l9AmQ9xAU=;
 b=Gt2P9eyUrPi9jI9mYeb8mMYFV/9QFpVItrR1H5AFFbKe+w7qurO79IVPC+nbqk4Fjk
 7I/KuR0ycF/+NaFR4ChFG3v+3UE6P8E1cKHAbrHXRa1QfsOBDkAGdN6Nbzozthi+Jszd
 tsiSzpvMSoVSIEsxMF7PgLoTp2n1bAtscyLLU5gCZCnH3/h/4UarMQ3217wQ9mLVlQXf
 RpX5fvXb1W2NP5+u2sexlJjoIHLMf9GhHCqGRPUP8m0oxQ1dX6QD2tklRUub7C/pexZ5
 U08T3ecDRZHJ+A5h0XRzjGSlfxPWg3n9p9mqKPgy5udBIaWDdaU4KUNDtyvhcOsQYSxH
 m7aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaXSp10PcpF40umyup5CrOppHuUlFJR8I1gHmL+PSoMZoZoF8brR5eo5BooyVhIUQb4e9Ff+iBEA2SidOgTOMVotjia8o=
X-Gm-Message-State: AOJu0Yzo1253OJMTiOTyCxYinaeEJuO0jZ5EtdgzHHxCYJ/FqHfJFovM
 2YP++xvQmQy30ACBoMSsvwT8gSiZRbQrWQR8r8yLaK/MzSvLQBPOBjpyFuwgtiE=
X-Google-Smtp-Source: AGHT+IHX8xsUK9pPrZ5EnewxvgqZZqABTtW9DDerb/e17+fkvakSFIdqYI/qsmRuziL8cvRHmSxOiA==
X-Received: by 2002:a05:600c:45c9:b0:413:1f65:ec19 with SMTP id
 s9-20020a05600c45c900b004131f65ec19mr5250885wmo.37.1710179215983; 
 Mon, 11 Mar 2024 10:46:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a056000137b00b0033e72e104c5sm6945438wrz.34.2024.03.11.10.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 10:46:55 -0700 (PDT)
Message-ID: <f3e1fefc-0df3-4339-8373-7648597a78d0@linaro.org>
Date: Mon, 11 Mar 2024 18:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20231214181723.1520854-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231214181723.1520854-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

On 14/12/23 19:17, Cédric Le Goater wrote:
> pseries machines before version 2.11 have undergone many changes to
> correct issues, mostly regarding migration compatibility. This is
> obfuscating the code uselessly and makes maintenance more difficult.
> Remove them and only keep the last version of the 2.x series, 2.12,
> still in use by old distros.

By the time we get to QEMU v9.2, will pseries-2.12 still be used
by old distros? (which ones btw?)

What about also deprecating pseries-2.12 and pseries-2.12-sxxm
which both set pre_3_0_migration, and suggest to use pseries-3.0
instead?

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   hw/ppc/spapr.c            | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e1504024658..c0e22b2b568f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,13 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   
>   The Nios II architecture is orphan.
>   
> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Older pseries machines before version 2.12 have undergone many changes
> +to correct issues, mostly regarding migration compatibility. These are
> +no longer maintained and removing them will make the code easier to
> +read and maintain. Use versions 2.12 and above as a replacement.


