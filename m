Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9995CD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzRg-0005Yj-OZ; Fri, 15 Nov 2024 11:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBzRQ-0005TM-EP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:45:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBzRO-0002jg-Q2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:45:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431688d5127so16065495e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689100; x=1732293900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hFU7kOYJMVilip8ZdoiHac8UNrl92jgQtD0aQrrMrmY=;
 b=ifhbf9+JO0MhCwwx+Uoh3V72gHf2rHYMYR7XqtyTIe3x2IopiSi3zVBZr4spQ8Ox7F
 5w4ewuGNaabSrb+I7qGnvSyDXhPmFGzCka003bnm40D/eDGkYbhrIQCfDMLebCEDURy3
 S4ZRGrEE5IqGS5Kbe/bkF7pvv94xodKxiGqABAPor5QnuPpESBYOBUhvT0tqtIR51pUu
 pSuF9YiWYocfeQtaZYu4B6qBJakOhX/gLUeKwyDMYk9kJoM4VwA8iQTCfy1ub3lxv3mM
 aVRfyGe6qNKbkF9vlpuKeLs0wX9NaSaB1XqrKp634lhcLCaU4l7mueklZnKxLKpj0jco
 a0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689100; x=1732293900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hFU7kOYJMVilip8ZdoiHac8UNrl92jgQtD0aQrrMrmY=;
 b=Ved548Nfe7IxOFwlo46QbJDeHPdpEKkLFnlVIfpXr4+doj9FP/+KkP/KniAG4cYBsX
 X4DI0ZtuS5vmLYhEvBt7xsgL5Y3VJ0aVekhOK9uMkyawivJzwQhGFBbRflhzMbv7wnFK
 Xxz7esarMlr+cgdKwNV/4IPOM+KhqYw6cb+k+UajNUv2pOT5MamID/HBhMOm9ILqF5Bs
 EIyEOv6pQ/TajHAoVANBXBHT/ohY8lxuN13bqn0R8WX673kOVWiKLnpkx6TuGV8Blv2W
 jEiiS9y4srdw9j4FLP1OdHoH8Q1lb16cFQAdDQTR2nXRgpn2FgKlWxo5E9bEmmQAf2GJ
 o8rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYn8xZGUuu5Vcx66CWXAU6ZLpFXHBLIqK+bwT/fZawAmZ76w2oyhR7O4Hk0QC11ZKKEdrMfo3T95uO@nongnu.org
X-Gm-Message-State: AOJu0Yx3VjHRNslp6j5cBmTmx1HYXqJIyy9zV8tmezm9Y5TE6ffn0v30
 ravQF1oysPFTMNebipBqjTzYgwU1ugDbt/4FKmZtJx4GkwCGdmh8IZg4BEzXxXY=
X-Google-Smtp-Source: AGHT+IGyqc14rLuNcpUhrRoEPqDV5RaCEWOH5ykyDgS3E0nMfXZw9suY/fRIE4+VO8OTJ7wsi6EY/g==
X-Received: by 2002:a05:600c:a4c:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-432df78f0f9mr31287555e9.30.1731689100556; 
 Fri, 15 Nov 2024 08:45:00 -0800 (PST)
Received: from [192.168.69.174] ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721b7sm59326015e9.8.2024.11.15.08.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 08:44:59 -0800 (PST)
Message-ID: <601872ec-ac92-45e5-9ee7-a876a496b27a@linaro.org>
Date: Fri, 15 Nov 2024 17:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] hw/block:m25p80: Fix coding style
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-3-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241022094110.1574011-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/10/24 10:40, Jamin Lin via wrote:
> Fix coding style issues from checkpatch.pl
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/block/m25p80.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)


> @@ -1843,7 +1849,7 @@ static void m25p80_register_types(void)
>   
>       type_register_static(&m25p80_info);
>       for (i = 0; i < ARRAY_SIZE(known_devices); ++i) {
> -        TypeInfo ti = {
> +        const TypeInfo ti = {

This is a bit more than style change.

>               .name       = known_devices[i].part_name,
>               .parent     = TYPE_M25P80,
>               .class_init = m25p80_class_init,


