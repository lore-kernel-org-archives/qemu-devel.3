Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7F0C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmPM-0006j1-QC; Wed, 24 Jan 2024 18:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPL-0006iG-A6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:11:47 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmPJ-0003wi-Rb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:11:47 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dd80d3d419so1871899b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137904; x=1706742704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ooNjC5URG4Lz86seiX3R4uiDgkFfNlSMcOQI4mNAUj4=;
 b=nHyYmjHa9lAWZbwQ3LnGmUvXG/G24oWnjPpRXzDKzWmWuNvFcW8gPUZxM9Cf7NboBv
 9qszf3ORlaOotqLKlV95QwMrRxv9s+rCzFdwEGXjWKmAidh+xhh3ruhm8gJzor0cHcLb
 XjZe4zUbp4Usq/1nkgrWiYPPGO5ZCnPDZGu5rj33KT8hkRvPAopkB5pP4N4Sp1LfXQIb
 8SKHeP3xbu4oNfb56eqE1c8I2tY9gFDjXyMJMlEhluSSg1EIHzPq/kZufdrsVv2q2uTM
 eq+gv4WvOiBOAuCz7Hj4Dmj040dA2nDA5oW/edgVmNrmRywUq6c0PEao1h+ZlCV6o5z+
 U1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137904; x=1706742704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ooNjC5URG4Lz86seiX3R4uiDgkFfNlSMcOQI4mNAUj4=;
 b=sAW7gIgs+p580tMT96cmnurux5mQkHvRGZwoQrwFooCrkxcarJ41UkFfosmrnqdsM/
 +CjkefXWhY3D6D2/AHzKsDz9ECS/3hjuMap3CacjfnAWqPEUyvDeXNPMJw9UggB9vaIQ
 mBwHLHzySfupPRCPv0rYCNd5TIyT6rzpnP5edFxS91d/XA07ErTm2u1hbSHs/HljdRe4
 IB4cZrwVeBMKFDddyVXNeNd8m4qXSuO04ivjHyN5y1zPLNmmRALBgYNRSw4/JAamROts
 zKUnlGqKzbh4oEGpjugtLZQXTpOAYJIqp/iI864GdP/WjKuAf1WyD/IJNj7Z4yfuqxUZ
 LQow==
X-Gm-Message-State: AOJu0YwImF+v5TzTs1QyT6hzNpn0o3tPZZXI0rHs/X5dNfWqLCuL6iZQ
 0FTDZ0BcJc8xGL1BPzmMlgqJ2nPvY27KyUvISRDyHcApWwSm4BrOClrHPVKzF4nMqvSmOyBqAmQ
 j
X-Google-Smtp-Source: AGHT+IH3WsLdt/BiUPFU2xBxgSSGl4vblS9mQOn4djUNUmb35vecmD9JfJ5nmnz5oO1wSeKkXhzmGg==
X-Received: by 2002:a05:6a00:18a2:b0:6d9:cb27:e47 with SMTP id
 x34-20020a056a0018a200b006d9cb270e47mr302674pfh.18.1706137904441; 
 Wed, 24 Jan 2024 15:11:44 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006dbc750ea5asm9684090pfu.196.2024.01.24.15.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:11:44 -0800 (PST)
Message-ID: <2f66bba4-992c-4af7-a09f-42bbf2540dde@linaro.org>
Date: Thu, 25 Jan 2024 09:11:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/arm/highbank: Add missing QOM parent for CPU
 cores
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/highbank.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

