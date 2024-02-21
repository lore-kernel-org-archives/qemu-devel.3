Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E7C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoe5-0003Wy-TW; Wed, 21 Feb 2024 10:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcocE-0005ln-4C
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:34:42 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoc1-0006z9-Mx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:34:31 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d208d0b282so90183021fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708529657; x=1709134457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJicVomqJWqUlt+x/Pps7oEzJ5tHMf/y9OG5tcXzKWM=;
 b=F0qM7L39YWAHF8AQ+ejctBrBVPdZ5yEPfc8z2AM81lIROYUzW/ZAOCzDZ46Uq8KM3w
 TIwtn+LebV7IxD0cOJBhsgRhZ+lHm+ARtm/ox6GADg88iqN3Z4e/S+vj3oH4di8hAoke
 VWaIaRoxR2bZ+BUXl4B/27EnL6S5esIlXpCDS4LclloEIgGFq4/TSWw0Rv5tKknuYbGP
 6C9M/epNUVQxYH4KgCVBY8iKhf7QTK1c8/LbiD7a4BffB6TUORJBMBntuaRMMBQ/cgTm
 Z1P4/JblGbPmgMohyGYDPbWQuabCdGKyKE3XrF3m80kl8KAQWilORq3rTPtXNXAZj8Xw
 tJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708529657; x=1709134457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJicVomqJWqUlt+x/Pps7oEzJ5tHMf/y9OG5tcXzKWM=;
 b=YROb2BYjzRlybLZ/1Mx4IbCQnPbnqs8CmSNEBnPXyaZ5YuYJN+i7RFw0caCzVOP58d
 nU6dLjiDSSgkFck84bGw5KBsU1zJzgBKplccQ/+s55lbuqmxFaPU1Dono3u+/w1qyClN
 RE6h4fJiJ5Ag7J5Ypil18RMBTWnIdpCrLdmP+cBRjq/UHyKRpugA0fBTBW6jOWhWTiyK
 7Cz3T/+5I9rsePg+b/6iXOzmxbcisnDNzMhhzM7F3/jg/MFkdsdbzDUw0hAQJqivr4qb
 v90MF7ZMy1tOZUYYR0PC02zAVmHSoIDdWPpSiZ7ZKvhSzSe2eAKHBjD1a12NRl28tbYv
 hoWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcVEtekmcZg9DLivUB9j1okA/21TKiRIeg30lvyXOlm6aAV/i5Kf0Ob4CYGWYzqnReBEcw3dQKIOgGP5fF0p492jFCgLo=
X-Gm-Message-State: AOJu0YwHjAbgEnUPaxl3DB4IkiHFhSSwJ2mDS0OWbep26TsYdp0Ir1Sw
 hIAuDMU4DehYk7k8JAq8YTrKT1p+uSUKqdQvBnYK5wMND0rTFpwWbYIFwjrZh7o=
X-Google-Smtp-Source: AGHT+IELC9hszz5wbXH5VwuTgsuKsztwZ2zBbv6apftDbUNWeGCNcJOxbj6C3oGOFjmtMZSLVX5Ylw==
X-Received: by 2002:a2e:870a:0:b0:2d2:35af:e8a5 with SMTP id
 m10-20020a2e870a000000b002d235afe8a5mr6964421lji.24.1708529657211; 
 Wed, 21 Feb 2024 07:34:17 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c0b5900b00410dd253008sm2862767wmr.42.2024.02.21.07.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:34:16 -0800 (PST)
Message-ID: <55058f62-b59b-43ee-812c-628b8df9745e@linaro.org>
Date: Wed, 21 Feb 2024 16:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220160622.114437-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 20/2/24 17:06, Peter Maydell wrote:
> Implement a ResetContainer.  This is a subclass of Object, and it
> implements the Resettable interface.  The container holds a list of
> arbitrary other objects which implement Resettable, and when the
> container is reset, all the objects it contains are also reset.
> 
> This will allow us to have a 3-phase-reset equivalent of the old
> qemu_register_reset() API: we will have a single "simulation reset"
> top level ResetContainer, and objects in it are the equivalent of the
> old QEMUResetHandler functions.
> 
> The qemu_register_reset() API manages its list of callbacks using a
> QTAILQ, but here we use a GPtrArray for our list of Resettable
> children: we expect the "remove" operation (which will need to do an
> iteration through the list) to be fairly uncommon, and we get simpler
> code with fewer memory allocations.
> 
> Since there is currently no listed owner in MAINTAINERS for the
> existing reset-related source files, create a new section for
> them, and add these new files there also.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                      | 10 +++++
>   include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
>   hw/core/resetcontainer.c         | 76 ++++++++++++++++++++++++++++++++
>   hw/core/meson.build              |  1 +
>   4 files changed, 135 insertions(+)
>   create mode 100644 include/hw/core/resetcontainer.h
>   create mode 100644 hw/core/resetcontainer.c


> +static void resettable_container_child_foreach(Object *obj,
> +                                               ResettableChildCallback cb,
> +                                               void *opaque, ResetType type)
> +{
> +    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
> +    unsigned int len = rc->children->len;
> +
> +    for (unsigned int i = 0; i < len; i++) {

Worth a pair of trace events around the callback call.

> +        cb(g_ptr_array_index(rc->children, i), opaque, type);

> +        /* Detect callbacks trying to unregister themselves */
> +        assert(len == rc->children->len);
> +    }
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


