Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJhW-0008WG-3q; Fri, 10 Jan 2025 13:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWJhU-0008W0-Rj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:25:40 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWJhT-0006ox-Cl
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:25:40 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso40897465ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533537; x=1737138337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruNVyzuzW8jO54zcQ0q3DqYEHSeL8e7cCjwMhhtReSM=;
 b=so+nI0X6q6h1jPsrlTD/aIUWpFxZpErQcf+nsI9s8klstmgthHt2chjpwVlc8PeGPG
 ooblnnKA5nWKPe4q2oAeaeX48G11cU7I04lK3ri0Efnt7506tFEUIQPPGBUy9XS8G0tv
 4GEs+HpUcYPZK59GNKwnBuenazDnnZ80SE9nwdb02wUOaF1g6L/oF5l3WJgB3VvnSkAT
 b0PWmyco/y6ALC5tPAuZO85pqbg2nxPDx9NRoJdvHNO5DkODnl5gboukLG0rxB5xl2rN
 BiYfC41NOC70TMn4weRLTWYCA4GiVDzKUzw16jEdTFSGMs9gDCELt00R1ebMjidDatB4
 Wt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533537; x=1737138337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ruNVyzuzW8jO54zcQ0q3DqYEHSeL8e7cCjwMhhtReSM=;
 b=YoiTlDJl3h5zFgWz1mBPRp7Wsmw7hcDw4EADhrbuTZ+agEl7dbXZRwhwZYFWEYBnEu
 otSgJFLRCZq0dnv8GyIsmcz+r8VDLl7Cw4lIdVJiQtHNBfLI9xAbCmZ8rexCjUm4B9wE
 pbsk8phP9k4FgsWmA8/GRyuLhXUSwFOpJajAK6hTH7uAgyE0GuQVmFvSnmY3FvauIYkL
 cnkZXaSI2M121FwhqwZQlpqD2PNdANgHqTSp7aY/bbAceALLFgMOqOFaRqAnwvm84waD
 t2EsRDWHrJlIQl0rhg4jCiYmbILNtW2nz1ASoXc4lXPFY61TtzMKjWXUuvda/uzELUn0
 8JIw==
X-Gm-Message-State: AOJu0YyjY2XmNZIauAp5IpyMP5w2J0zFEulPC/+XhFv9UxbyRfJAvU5O
 gNNoIAcFrBGGtpWINvVe8vhiJhoNRyrVbsbiZZvM1bZBH0AUczVdXPDXeZLHM85GjUEPk6Ozo4U
 8
X-Gm-Gg: ASbGncvabwjd1aiJ0CJKFlxzGslmhULaDKAYMPqyp9TqVEDmt1J0E4g7xJ5pqDKagT5
 Q/iBVDjAUzHtVTi7AuvGiVzMcOmNC/Hw4CmTq9Q/lkIZDtUiv8PA3CLVbGUSEEwdE7DJHkR0+6Q
 f7GsL22YiApLK0t4F8u5svkZO3SaH6WfNSIEW/XqEUVZ1FT13wGdfHj1jxtNsZWAJVxp7Vu2VV0
 ir3Vmt3T/uOBMvQEVyHPGHjjUPVciAyfNfa4wDnRbmHCbAQZ1+FSHdxWncM0ChFQtPQ3y6J6VS/
 BP1iYHaCPHD7cfeL57B6rNHznVauDrI=
X-Google-Smtp-Source: AGHT+IFnjeZqydgow10KJoWoEN4EKqHiwpgvxz3P0PFkxjL4ljmoIl5Vm6d5l8Oqcp0SLZyy488hmQ==
X-Received: by 2002:a05:6a20:7f99:b0:1e1:ab51:f531 with SMTP id
 adf61e73a8af0-1e88cfdc107mr22374349637.22.1736533537546; 
 Fri, 10 Jan 2025 10:25:37 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31d5047e01sm3124398a12.54.2025.01.10.10.25.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 10:25:37 -0800 (PST)
Message-ID: <3e15ecc1-45cc-4375-876a-d72866a386c0@linaro.org>
Date: Fri, 10 Jan 2025 10:25:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/tricore/triboard: Remove use of &first_cpu
To: qemu-devel@nongnu.org
References: <20250110180909.83165-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250110180909.83165-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/10/25 10:09, Philippe Mathieu-Daudé wrote:
> triboard_machine_init() has access to the single CPU via:
> 
>    TriBoardMachineState {
>      TC27XSoCState {
>        TriCoreCPU cpu;
>        ...
>      } tc27x_soc;
>    } ms;
> 
> Pass it as argument to tricore_load_kernel() so we can
> remove the &first_cpu global use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/tricore/triboard.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

