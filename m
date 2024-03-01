Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19997C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8Je-0008Aq-FB; Fri, 01 Mar 2024 14:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rg8JV-00087D-Rn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rg8JU-0006sY-BA
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709320374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PIsUyFN4xwH/5id5+SBMr2eHJBtzf9Fc7n9haEC66sE=;
 b=ImT/uykvmeYysE4dE6MF4SeJrh9D2bXaSg1GpYOGsJ9hNyojdADMI9nbWMlWnJlyBV1YCU
 Dnqs6W9HNyG9Ec+NHgK09soTWvWS/P+21RO4Z1BadpD0LjgzFgrQNIg/TD1jo+v1LffCVx
 SYC3hTxjYGzFUs6hGD34vjZCRJMEQpA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-TuyMtOZ8MRiH0v2VCrsX4g-1; Fri, 01 Mar 2024 14:12:52 -0500
X-MC-Unique: TuyMtOZ8MRiH0v2VCrsX4g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-787ac304610so256477085a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709320372; x=1709925172;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PIsUyFN4xwH/5id5+SBMr2eHJBtzf9Fc7n9haEC66sE=;
 b=Ci6gTF3qZmn/TvdLvL6W6O0f+1dZvmtVV6vQ2IwbAvYPFGLldfQp7XekFPYfyBTeS8
 J82nqG4b+ZS+cFbCnTq5uZV39ad0tPmUsf2A8PMagPyfhIb1g39fRkBXWDFuLVyxiJ63
 HJJqDtqKvV3BwZju9uaLjmppxNUMpIXqIwjZIlkQhtFkwKpjA8OJ2sMyMHvY8wESkXCm
 s2kPgFx4Xl6VeEoEOlI5DN4++shjBkgm3/+diT6rc5BqL0b2OtliacyrdhmVhNRK2FO2
 3yTF9NX21fnIP3Ma14nC68sfj77GnpgQnLTF1ibIXUKVbLdfVSQMGa2PPJ4WZ+MIek6e
 XZOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWijk6bsXAk2SW3KFft5rUSNHL7d1PeaUnVlAdRwk3jVk8hFfk/bYdngw5vme6D9+rTU5/3Na4tZ/XEkXfxRAYJn4fz6g4=
X-Gm-Message-State: AOJu0YwDJ9DmPPIZa45RsQNNb5D6iMPq96FhuKDmFWISSiHqlWVHruOf
 YE/GrSb270OdgvwVndLBrRE/x61qqpvXBKSRjP72/DqBQ2MIZi+VOUtjFJO0aOyqNqocvbbUvST
 NWAIVIBLMj0JCpGkhz3eZwOlk2aYI4D9mrT71eY0OeZ2dNqKx0+vR
X-Received: by 2002:a05:620a:478c:b0:787:d984:774b with SMTP id
 dt12-20020a05620a478c00b00787d984774bmr2564696qkb.3.1709320372057; 
 Fri, 01 Mar 2024 11:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE527U1KDoe6S3Hd2qrZykSvhq07PmNNIrizFzuGplhXVsAUhWsJUNTErXOhfwbYw3NUAVhKw==
X-Received: by 2002:a05:620a:478c:b0:787:d984:774b with SMTP id
 dt12-20020a05620a478c00b00787d984774bmr2564684qkb.3.1709320371833; 
 Fri, 01 Mar 2024 11:12:51 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 h24-20020ae9ec18000000b00787d6a14d0bsm1910758qkg.10.2024.03.01.11.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:12:51 -0800 (PST)
Message-ID: <b2585806-d05c-4eef-9a2b-15bf2c68e2c0@redhat.com>
Date: Fri, 1 Mar 2024 20:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] target/arm: Allow compilation without
 CONFIG_ARM_V7M
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240129081835.137726-1-thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240129081835.137726-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 29/01/2024 09.18, Thomas Huth wrote:
> We've got a switch to disable v7m code since a long time - but it
> currently cannot be disabled since linking then fails due to missing
> functions. But thanks to the clean-ups that have been done during the
> past years, it's not that difficult anymore to finally make it possible
> to disable CONFIG_ARM_V7M: We just have to move some v7m-related code
> out of cpu32.c to a separate file (that we only compile if the switch
> CONFIG_ARM_V7M is enabled) and make sure to use the stub functions in
> m_helper.c if it is disabled. Then we can finally remove the hard-coded
> "select ARM_V7M" from the Kconfig file.
> 
> v2:
> - Updated a comment
> - Avoid #ifdef in cpu-v7m.c, handle it via meson.build instead
> 
> Thomas Huth (3):
>    target/arm: Move v7m-related code from cpu32.c into a separate file
>    target/arm/tcg/m_helper.c: Include the full helpers only with
>      CONFIG_ARM_V7M
>    target/arm/Kconfig: Stop requiring CONFIG_ARM_V7M
> 
>   target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/cpu32.c     | 261 ---------------------------------
>   target/arm/tcg/m_helper.c  |   3 +-
>   target/arm/Kconfig         |   4 -
>   target/arm/meson.build     |   3 +
>   target/arm/tcg/meson.build |   3 +
>   6 files changed, 298 insertions(+), 266 deletions(-)
>   create mode 100644 target/arm/tcg/cpu-v7m.c

*ping*

Any hints how to continue here? Or is the series fine as it is?

  Thomas


