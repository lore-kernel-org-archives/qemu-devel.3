Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC12AC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhu3p-0003sD-A3; Wed, 06 Mar 2024 11:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu3n-0003pX-Bh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:24:03 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu3j-0004sF-7q
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:24:03 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5133d26632fso5310744e87.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709742237; x=1710347037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTErBd8I9f7/XJKbmaLUllvFuZtnC33DbAOv1RVpPJE=;
 b=xI2DGFKDTbdbuuahvQReJg4RqHvQrebcIjvfRHK2S3INaUXAOJJOYFAwBTIBel/WvH
 eblHmUE01R5PXz/rFvfp3TAeh2w+T9kArCtBFDiSuzWteayT/R+54mMYHIazuLo8aH/2
 tQ3eNM73kLUaCJZdrbklMoBTU8YQXLNwYZiUuvpqCqxYRhdv4cUhUGseTEJo6l8C7Hpb
 H55UMrZUcT40XI1J2GX26Yjk5QVAfZYOrRZF+US7qhJOz7YItfH7O612KZTdgenXx78w
 evKEq4NhfJpnVE9WIrW7HpLo30BOCz+NMhvfOD1aUQcK8mUEf8d+M2LHAwkaOg3q89a5
 I2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742237; x=1710347037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTErBd8I9f7/XJKbmaLUllvFuZtnC33DbAOv1RVpPJE=;
 b=R/N+hccaReYVpk/J1FEU15OkS2X/ujFN/s9nttR66kJ3LXno4YhJehH+ma9UcfZWDe
 9xzNMBU7QYg3Awb2aPgCdzd3FUcnXB5Xb8awXzltsefR/gWI10WnwHLPUexYXkBIsfoC
 Iu+XjKFcXQ2Zn5ZTC7r2rMp/c5Tbh2yl36zLiz9YGuSQmHUiddk0pf7aPAgfTd/iOXHV
 +xqd9A54ligzV1MLL9I0iCBJkOeKb7qZy//jAWeohTSwQct/EUEaQDLvqdHInhauGTDE
 26FFUDLTiycQSzxoAbGrq4s3kL5BGnb0zRCehcs7VzrJHNVs7bCtsYI/ppHtuO6Iujn3
 xk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWpKREIH8sTdz2cx/PEOpRnBQcQ6n+3gFVTiV+sIpvKFKSjm6TXCpUoWx+4EGs+hAaUy/xfme9CbHcEKdkcvDPeUFeWbY=
X-Gm-Message-State: AOJu0Yxp5nGcBfsFG/pMyy4/+Y7BJCk0AWBhEJb9Kv5ClIAiGpVB/zi3
 YHvoRwkTpV9XUJTJOOjEDI0m0J5F4TupUeY8MP0VFiJfTEYnDMUWaIKC9dct4v4=
X-Google-Smtp-Source: AGHT+IHa9w/sBjJvWWfRZ5puUSsIWsfZdMoJAIHOjFTkIT7K72Otee9z2VYMTMWUYC+Qb5pnaW6RHA==
X-Received: by 2002:a05:6512:3e28:b0:513:2323:1ceb with SMTP id
 i40-20020a0565123e2800b0051323231cebmr4962209lfv.5.1709742236618; 
 Wed, 06 Mar 2024 08:23:56 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170906094c00b00a3e5adf11c7sm7253127ejd.157.2024.03.06.08.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:23:56 -0800 (PST)
Message-ID: <858b7623-3c50-4db3-99c6-f96846af8c7f@linaro.org>
Date: Wed, 6 Mar 2024 17:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qerror: QERR_DEVICE_IN_USE is no longer used, drop
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240306131055.2460378-1-armbru@redhat.com>
 <20240306131055.2460378-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306131055.2460378-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 6/3/24 14:10, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index 8dd9fcb071..0c2689cf8a 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -23,9 +23,6 @@
>   #define QERR_DEVICE_HAS_NO_MEDIUM \
>       "Device '%s' has no medium"
>   
> -#define QERR_DEVICE_IN_USE \
> -    "Device '%s' is in use"

\o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


