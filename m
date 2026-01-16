Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC4ED4A60A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgei7-0000kw-G1; Fri, 16 Jan 2026 02:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgehf-0000dt-Hm
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgehc-00044O-2C
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768550223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KW2wUi75Bxov1Sph6vKG8yHs4rhyMVY3GnvvDalDvhU=;
 b=VgGP2g2ee6gROx9XMbeB3LnXLYKmlz9AO/oB28nihTGgl2Pphbr5pFaP0iizlconACu1tO
 k64ImWOgv25tXV0iZFDlRO+ZKHYWkofvsSU2c4167xzdT2sHHVkYiXvNZKvI8IGkY2wkl4
 DAbr+8HDeHbq1RUjzZ7y9hgLBws1PpU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-oKVENrIHPdGwQiVnp7o7fw-1; Fri, 16 Jan 2026 02:57:00 -0500
X-MC-Unique: oKVENrIHPdGwQiVnp7o7fw-1
X-Mimecast-MFC-AGG-ID: oKVENrIHPdGwQiVnp7o7fw_1768550219
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d5bd981c8so11041205e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768550219; x=1769155019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KW2wUi75Bxov1Sph6vKG8yHs4rhyMVY3GnvvDalDvhU=;
 b=Gb5x0UVNjY8mn4EmyE5ufrmaOSEllpXTJXHy1xsMBbsqZULwmtLTBR1/GX5eP/WACS
 akHUv7+UORDdHTFaJ/pFNj5yf20L5bQcC+JWR1u36wsUo6riDx6s1RFZntvyZnz7eV4n
 LsJl0lnIxbdTj/KgyJB9dFwcBApkW0AsuoYJaHqTUQfPTYN7mHPCLX8UKt3fQiqOSoda
 +LIxq9FLktz0IDoYw/N4eFn5QkTzlDaO7iuDVgdp3hF/2ixQv1jkT7A+aUf413LW10fI
 aQJ8bQQTCIXgTMvYhCOcg0R6YDIsW7OoZzDRRG5jqT2fRLok2BExDnlA55TVgDuF5LXZ
 9qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550219; x=1769155019;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KW2wUi75Bxov1Sph6vKG8yHs4rhyMVY3GnvvDalDvhU=;
 b=vd6yLdp794NDKtKBnbWl3Sa9xVm8Ai8728ZWv9B2/ueNKHvE9c259FepkUkcq1VYnu
 BgxhY9F8jM+cXX9Q2g76d/C1i0cUZJAFEOCo1E72hg70MXrPTcISYYxRdAPhLd4Vaina
 g9EgSZKIuLTCeV+hq9KMcOASd6VgbyWNIATNWF+ZPFPmTqROLoAAT1KVD/TYEHO9RJsp
 2GnVcajSr2WuN0tZpUdql4e/jwSHS+evNAmu8CUeiN5b5mmDADnBrlG6rFISx0qT7OZa
 HHUD/lyUfB5NxtH5kiyuEXJRnUGLAzuCAVA7snxWwWmQ27f8LxfWq6cerlHm6IQPdgQD
 Wk6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkOUMCvjzIWOUgwkZfPGBgrbn0NFWg9S7/BGyJH9eKfimEoEs2tF0Td7MSjlfsG62se1KkLmsiKQJD@nongnu.org
X-Gm-Message-State: AOJu0YxfT9X+aZil0c9BHLG3bhaEjn65C7tQHh/m/LIKxVeu67MGZNjo
 ekkwQ37IjKQt+6RdJOaRvJMZ2H5tb64mS2pjtYVQP1H3sVv23a8HaHV3JznWFK66tEf6VilsHjs
 WhjCN3S5rhZdKBuImdKdcmaX8mGl9v6jMBdMSvsAOXUPf2imjv40E050Q
X-Gm-Gg: AY/fxX66eehUfuENb9pcf6GpBPQigE5kBLOfYAMfmX6W5Vw8I+NeGTo/ZfUpCkUIOSh
 LGHhp4tnIoVn0dXenePZJ9hRNm1fWPda1OvSVLvqM7JEDnJ+/gh+zseuVd6kNOJERm/vIKzZ5Gn
 aGSb/yLzUTa6wm5T7sP5FrWH6vZz5O5PDGcdHHHuKKSj+q8sO+TC4rUv1dQfXg5EjCKtgst5iML
 BJd5jRLwH0emHUqHrdefLJm6BljZWwW5ZhuJ8cmiiCjBX51205CjYElI9QTGHLHp1LMXXdZLIoK
 j7FC/mZ+e10w+4ZjresMH25Td6/9cDSZy7iHH7ssZSFIgUS6zadB3nlw0XYoIvTbpEakESS9KQO
 YvhJZ9vQ+d70rjxqbfU4uK+eXwIDn8ldZ1fOAynhOcrm4Xh0K
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4801eb0efe0mr18165315e9.31.1768550219509; 
 Thu, 15 Jan 2026 23:56:59 -0800 (PST)
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4801eb0efe0mr18165075e9.31.1768550219070; 
 Thu, 15 Jan 2026 23:56:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm29386865e9.3.2026.01.15.23.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:56:58 -0800 (PST)
Message-ID: <b747f454-58f4-4f21-9e43-db3b7a43c1b5@redhat.com>
Date: Fri, 16 Jan 2026 08:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/3] MAINTAINERS: Update ASPEED entry
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Hao Wu <wuhaotsh@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com,
 nabihestefan@google.com, komlodi@google.com
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <20260116073024.3485812-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116073024.3485812-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/16/26 08:30, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f0..28046b457a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1248,11 +1248,13 @@ F: hw/net/ftgmac100.c
>   F: include/hw/net/ftgmac100.h
>   F: docs/system/arm/aspeed.rst
>   F: docs/system/arm/fby35.rst
> +F: docs/specs/aspeed*
>   F: tests/functional/*/*aspeed*
>   F: tests/*/*aspeed*
>   F: tests/*/*ast2700*
>   F: hw/arm/fby35.c
>   F: pc-bios/ast27x0_bootrom.bin
> +F: roms/vbootrom

roms/vbootrom is under "Nuvoton NPCM7xx" already. I guess it is fine
to have duplicated entries. Did you check with ./scripts/get_maintainer.pl ?

Thanks,

C.


