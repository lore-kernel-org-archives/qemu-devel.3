Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969C7C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpH3-0003P2-KZ; Wed, 24 Jan 2024 21:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpGt-0003O9-B1
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpGp-00067y-C7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706148910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nsGKiE/26dbOEmT/BF8aavsJR7YqnYus6s0DDRko9E=;
 b=gH/tEKafPtelE/34U85dewgLiJ9k8qOAoGvmIIg3NlXSzYjl+F+L3Xk71Gx61FtrnaSjOg
 vaughwPApvvcx1TlxoRspG6AotttExs0cTtRo/JU7MypYxZimDksEt7FylrxB+hgNIXEh4
 JfEsAFRaPVwvkeFPK/IhZyA0lSzv0Ds=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-cUJoiLBLM02K973Y1KqfYg-1; Wed, 24 Jan 2024 21:15:07 -0500
X-MC-Unique: cUJoiLBLM02K973Y1KqfYg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9b082bb80so9561849b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706148906; x=1706753706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/nsGKiE/26dbOEmT/BF8aavsJR7YqnYus6s0DDRko9E=;
 b=hRktCXBdJqqS4da6xRaIb6fe3inVK11hPeeSTauZpaJ1rWJ+rQLP6voOM2iMi3J/ks
 UWAsvZFc9Y+F3UYTB3BX5KZy5Ey3EXxGQ5mLc8YbYOjaYyj7coOETylOUDSB3SaNq0nF
 iZr1C3Q+5dR+oV4yIl6KLI1a5moIiBEf/1CEE25Fn8ilwm8S0HK5IcwaGY3l6NitWms8
 BCTRnnmVYaSOjNz98t9pEnLkuKdHckFd6y+enk/ogFVRPZa8XvWTfX1C5ItRZu6UAPRP
 fdQkmWKZTV80x8Aoh0lm/p07Io+Fz8Eox/+XQ0S/1YafoT1HAnKLzB0I9J/K2HqOoHEk
 r8wg==
X-Gm-Message-State: AOJu0YxsHDBamNyn4AbLv4kMKrtKaLYRYN/eWrPodTVe1GcNZGoHUng+
 oR5sXKyE5fBII4Rh0kosopbUTIg5f0qFuhAEjeRCo1ZE7T+NXKRPwfaAqb2sSQXZXyEqQK4VaaE
 islguHXjh7PDbFf3Z+V5BeqVrFxPQlOZt0JyL9oBdpeHIZMplrgM7
X-Received: by 2002:a05:6a00:3c88:b0:6db:d978:9047 with SMTP id
 lm8-20020a056a003c8800b006dbd9789047mr187403pfb.1.1706148906683; 
 Wed, 24 Jan 2024 18:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5tZEZQixO9eeautw9+wLM82UGynwU8TQ0ZdDEGz6RKVdyx/mEaZ3NvikNVQSbLqmRDVsU3g==
X-Received: by 2002:a05:6a00:3c88:b0:6db:d978:9047 with SMTP id
 lm8-20020a056a003c8800b006dbd9789047mr187386pfb.1.1706148906398; 
 Wed, 24 Jan 2024 18:15:06 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa78713000000b006ddc661a619sm423036pfo.7.2024.01.24.18.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:15:06 -0800 (PST)
Message-ID: <047f3ce7-c200-4014-b3dc-8b24331fb44e@redhat.com>
Date: Thu, 25 Jan 2024 12:15:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-5-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123222508.13826-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU types.
> 
> Instead of ignoring invalid CPU type requested by the user:
> 
>    $ qemu-system-arm -M midway -cpu cortex-a7 -S -monitor stdio
>    QEMU 8.2.50 monitor - type 'help' for more information
>    (qemu) info qom-tree
>    /machine (midway-machine)
>      /cpu[0] (cortex-a15-arm-cpu)
>      ...
> 
> we now display an error:
> 
>    $ qemu-system-arm -M midway -cpu cortex-a7
>    qemu-system-arm: Invalid CPU model: cortex-a7
>    The only valid type is: cortex-a15
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/highbank.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


