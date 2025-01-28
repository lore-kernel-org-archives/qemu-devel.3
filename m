Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A1BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 12:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tckjv-0006UT-H7; Tue, 28 Jan 2025 07:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tckjp-0006TF-OE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:30:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tckjo-0002HH-8F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 07:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738067437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mwEdGeYwCVEf3va0CRehsDI0IO9aha2vG+WbTqnfbXg=;
 b=Rpi3mBV/2V5e9rzdM6qvfHx0JhJtB1+vmfTmzbFJYr8XYXHSDpuly5zrdyl3cHGj3m5cQF
 BUOBocDq2KV/uRGk5BLu+WgApcwabM8qlV7U+Xlg4FCoK0BgRC9dqA/Ant/To7PeqfJciT
 Rwk6TdptuJazJ5vPAMm5gceHIkE8ptM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-kXAxBOEbMoO89QYqq6etlA-1; Tue, 28 Jan 2025 07:30:34 -0500
X-MC-Unique: kXAxBOEbMoO89QYqq6etlA-1
X-Mimecast-MFC-AGG-ID: kXAxBOEbMoO89QYqq6etlA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dbe8a4165eso6475764a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 04:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738067433; x=1738672233;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwEdGeYwCVEf3va0CRehsDI0IO9aha2vG+WbTqnfbXg=;
 b=VKH28jcewNngaoO1pHjcuOYE0D071nMu0AGOd9xDVTFtQvNbONES2LVTT90pzd9eJH
 S0HJ0ACVQpVGp+X3IXgQqMTmGOVCbebUgB1rF/4pa0MJZIvkoeFKyNqN/qhnvowLJNnq
 PTw7f50fsf1RE3jLXBtDl3V6/uCw3rrGGz2TNDm/2UtXbdleOStTEjQZ4e/P95V1D9el
 liU32zzEAR5XcWLBG/B4KM31bdP93jF42E4QtmVq6GHUqWk8SzL8UA0qYKbZpi8AQxws
 2cHfm1Eb1fjVpZyzEL/HpgfByQA+m/Y5tYsgwwGmS3ImZ92fgNX6GhrjHCejxWyPSF7V
 slPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh9MDRWFL8D1JSin3TFLjvt5wVJpc0DOA212172DgkvPUtZR0W+LP2+xuPO2SttDbvXhIunlDPjSx9@nongnu.org
X-Gm-Message-State: AOJu0YxdHyQxi5in8hGXb+5JP8IkbUiR2J+2PzY29I8V7im/QjZuvye5
 xluj/WNoejXqiQDbye0Cywt+GFI1v+6lsPqHeYG+ew0UmALk/YDekgAulJ4ys//+zg8z+To0DQ2
 5q5wJyEUSoYvKTncO9Cw8ix9RkOPzvKOii4ZF401gEd2RCg5jWwTl
X-Gm-Gg: ASbGncspRp+gcls6l4t3KZD7UrgyaChLBUKuKybz3cQpmNsJvwP/dtTaOsLZALRWX9c
 uyCzmusnO3tYgmtoxbUVaqa9uzLb+1AsDM42dsXy15YQ8q/P6L7yS9G22oEVF+GuyY653YAvXFX
 476J2BgmMz5C/L+1IQfbvlNH6Kw2GqNn9Wks+d+f9mGAxwgr5sots69YHdIIeuS9cJY6u2qbUxx
 x6twoe1EwJx5dmImhTTWKgBQOL8VfyNKETGeWUWo0myl0fP2+grF9wDP/LuzJrKnJgBiEDNPvg4
 FNOfOm55Pqw+wFngfLMHMUq+gg01ovZS3NlU
X-Received: by 2002:a05:6402:1e8f:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5dc4fd1153emr4070529a12.2.1738067430202; 
 Tue, 28 Jan 2025 04:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE5zcsdFqOnxwXJMHoRt5avby+/62eopuGkbdjyfNCDtaIa+EgX1nN8lJkWB9mowl6EBIMVA==
X-Received: by 2002:a05:6402:1e8f:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5dc4fd1153emr4070158a12.2.1738067424760; 
 Tue, 28 Jan 2025 04:30:24 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc2ea16e7asm4661486a12.42.2025.01.28.04.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 04:30:24 -0800 (PST)
Message-ID: <8da6ca8d-9819-4f4c-9131-f9fcf498d86d@redhat.com>
Date: Tue, 28 Jan 2025 13:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest: Make qtest_has_accel() generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Bernhard Beschow
 <shentey@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128111821.93767-1-philmd@linaro.org>
 <20250128111821.93767-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250128111821.93767-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/01/2025 12.18, Philippe Mathieu-Daudé wrote:
> Since commit b14a0b7469f ("accel: Use QOM classes for accel types")
> accelerators are registered as QOM objects. Use QOM as a generic
> API to query for available accelerators. This is in particular
> useful to query hardware accelerators such HFV, Xen or WHPX which
> otherwise have their definitions poisoned in "exec/poison.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 7e9366ad6d5..3071dedeff6 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -30,6 +30,7 @@
>   
>   #include "libqtest.h"
>   #include "libqmp.h"
> +#include "qemu/accel.h"
>   #include "qemu/ctype.h"
>   #include "qemu/cutils.h"
>   #include "qemu/sockets.h"
> @@ -1030,13 +1031,10 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
>   
>   bool qtest_has_accel(const char *accel_name)
>   {
> -    if (g_str_equal(accel_name, "tcg")) {
> -#if defined(CONFIG_TCG)
> -        return true;
> -#else
> -        return false;
> -#endif
> -    } else if (g_str_equal(accel_name, "kvm")) {
> +    static QList *list;
> +    g_autofree char *accel_type = NULL;
> +
> +    if (g_str_equal(accel_name, "kvm")) {
>           int i;
>           const char *arch = qtest_get_arch();
>           const char *targets[] = { CONFIG_KVM_TARGETS };
> @@ -1048,11 +1046,12 @@ bool qtest_has_accel(const char *accel_name)
>                   }
>               }
>           }
> -    } else {
> -        /* not implemented */
> -        g_assert_not_reached();
> +        return false;
>       }
> -    return false;
> +
> +    accel_type = g_strdup_printf("%s%s", accel_name, ACCEL_CLASS_SUFFIX);
> +
> +    return qtest_qom_has_concrete_type("accel", accel_type, &list);
>   }

Nice!

Reviewed-by: Thomas Huth <thuth@redhat.com>


