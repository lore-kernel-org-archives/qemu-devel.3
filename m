Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12898C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIIT-0006k3-N2; Mon, 15 Jul 2024 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIIS-0006aF-2w
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:47:04 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIIP-00068J-6k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:47:03 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e96d4986bso4114258e87.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036819; x=1721641619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uulBVX8O/AUeMJQW3OKnrM6R1QlmsYJxs0bjHqe8AIc=;
 b=azDjVkvCxHtfvVoRfXPv+Uim8zv232Mu1JyMbeM6AnoirkavhHvnqnXlyArnX2oyDV
 MFe56MwhQo3T2ioNUD2+cN08gqRo3NaDCxw503Orc69vD4+cqnm65st+IWVS+4oMlC3f
 bhmGdKfmgOu52vOaZjCt3RwHT0V0Y5iCOf8zXA4ebEpfRsNXnC9+JDnDW0A7DT7LqYkU
 gVrRtTqXRed2X773ovVoOcLq1kDoB9lFctcbbkQHjC2L1OMdaWsO2q6nHSER5LYwLA8N
 J7Ta4SCV64C7qaFHQDBQBFRsnrzgL7J3qgw9CTqtQLNqX8af4M834/Nmxzlm3yyqC3B+
 B/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036819; x=1721641619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uulBVX8O/AUeMJQW3OKnrM6R1QlmsYJxs0bjHqe8AIc=;
 b=YDz6SOjxC12NMAAmcG6ol7v9XUuDP8PJpVsI9S2FUud8rSRMBpR5CnsplqpNvOPyDG
 cUCS7Xrux28YwLYkGJD7rppNJzuOW3cG3idzGA4/7Co+eg5meeMYUTuxNFBXGDP7KFAo
 9Uqd6sfyRDSbS42CK/YHFamZ65MVMn630F2mRGEQGLTs1gulITFNYxt9mlcNCaWRVXU2
 Rh0ZKOQO6w2u/vGS7VzZHNjbz4FR7nEPQtme7rW3JTc67Mq66VDyLaAB7zKdg+qag9tE
 g1vGHG02kG9kusp37cd03lpx2jbM7P7CkUa+EcCIYZ7gqFgxdriJwfQiTBb4yAsIu7X1
 DNmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YOFLPX8aRLBYF3cyxZ8awHhxyxkDy8gp7kCdO8jT6Py21qKZw+J9YJZuuXxoWPMynC346SDNB0bG7ZppPxoVLXlCsJY=
X-Gm-Message-State: AOJu0YzVyxoSTN+ZJw+zI2mbJD+fG31EHTger+NtsKNUpKlA+u5qXght
 0vtUOojnx+vCX9gHAmfUbXIH/nrwx5lw/Ncwqg8Bo9ucF131ingLjIQSBifJKdc=
X-Google-Smtp-Source: AGHT+IGK4tAWObWmg2ypjdvaS2tRjqRmGzxEtHM2/Ygze/8RgqfTqqA2xW4uu7K0RDDeS8/lp2C/RA==
X-Received: by 2002:a05:6512:1248:b0:52c:caa6:13b4 with SMTP id
 2adb3069b0e04-52eb9991010mr12015220e87.3.1721036818652; 
 Mon, 15 Jul 2024 02:46:58 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ed24e29a9sm797385e87.26.2024.07.15.02.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:46:58 -0700 (PDT)
Message-ID: <01245850-b5df-4bf6-9a22-775d12fc07a0@linaro.org>
Date: Mon, 15 Jul 2024 11:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-8-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open(). And considering
> rng_random_opened() will lose its obvious error handling case after
> removing error_setg_file_open(), add comment to remind here.
> 
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   backends/rng-random.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/backends/rng-random.c b/backends/rng-random.c
> index 80eb5be138ce..3cdb982533b5 100644
> --- a/backends/rng-random.c
> +++ b/backends/rng-random.c
> @@ -75,10 +75,11 @@ static void rng_random_opened(RngBackend *b, Error **errp)
>           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                      "filename", "a valid filename");
>       } else {
> -        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
> -        if (s->fd == -1) {
> -            error_setg_file_open(errp, errno, s->filename);
> -        }
> +        /*
> +         * Once the open fails, the error message is integrated into
> +         * the *errp object by qemu_open().
> +         */

IMHO this comment is superfluous, I'd drop it, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        s->fd = qemu_open(s->filename, O_RDONLY | O_NONBLOCK, errp);
>       }
>   }
>   


