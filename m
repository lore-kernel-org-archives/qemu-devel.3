Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BCC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmVc-0002QH-P6; Wed, 24 Jan 2024 18:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmVb-0002P9-4J
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:18:15 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmVZ-0005iK-Ep
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:18:14 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6daa89a6452so4361109b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706138292; x=1706743092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6hHELT1Cs1XXl8oCVlrvXMDWO1i4PgfYwTjGwgOarM=;
 b=sgV9aA2e65H9rKm1ERYGDHBDXgJ6fW97+NR7Z39PzXVZss6se/C/givabwpfVQl1Iy
 rDJE4FlvILNg3uUj/xUHDGnY88AAPUVBYsKH0LG/00GBGyqrB71NT0VT/+Yyjc3NlxMB
 zqX51QMCO1XnJ5KK9GllZG9vWu5LAhBfSOUOK+ZNzuOTIugKGiBlDmjq27pbV1D8CgUQ
 LWv+Oaf88NUJtFLqTbs1OjPfhAgowruCTlYkrwYwrBpV2UElVS3GC7pPB++Hb0NbhbdN
 fPE6XakSbtA3Y0TGRY8rxCEdrOEkoP9o1pxoOcWKfO2ICnT+nNp0l6NIJRnhvoX/0MTb
 utZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706138292; x=1706743092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6hHELT1Cs1XXl8oCVlrvXMDWO1i4PgfYwTjGwgOarM=;
 b=wQMsA7T7xKwI4B2rLYUlMvrabE0SVvfo57fKkN0+HU2roIIhGHbeJDrT5o5fnM2REr
 lgr67AMoHHApvjt3TrWolICeIaNFj9fnxpFh9uPpPQkXbYnIkgfPJoXJwbMu+hosmzzA
 9Ga1PUNZdvy0n/1xlcAmThdZ0wZy7T7Oi3tOkAgpNZYM5xIXmrghjWSjUU+ZLiSvsmbF
 tqT6MqId4uQsjKxmwUYfHDIudtwspjBYxX1jKFZMZpmSXcihaVyPcCeBSpF4PeajM+t3
 7gcyOgCtAKy6unYoaUBPddh75yppUXMEewdZtu13hNMXOZ+eeTLo0hHaXuf9C1ERzud2
 9oSA==
X-Gm-Message-State: AOJu0Yz6UU+8/HIg+jKQcYcgPJdVL0gkCLN0rrmgiwlicx38AqOmCANo
 0SxOOHZr3T2QbMjeky62sR1jDVLaPFr/rGJBZxkNL+VFeRtSv1RTBo8N7NFvhs0=
X-Google-Smtp-Source: AGHT+IFimQXr76un10rOZUdwv9ZPjriLjA2eZt2p/4UyW6cEBacbwGhVBb3KTYWo7QTVeuncVSijdQ==
X-Received: by 2002:a05:6a00:2285:b0:6d9:d71c:d1a3 with SMTP id
 f5-20020a056a00228500b006d9d71cd1a3mr278597pfe.66.1706138292138; 
 Wed, 24 Jan 2024 15:18:12 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 ks11-20020a056a004b8b00b006d6b91c6eb6sm14657150pfb.13.2024.01.24.15.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:18:11 -0800 (PST)
Message-ID: <64b7a417-35a1-4674-ba74-cf7149363358@linaro.org>
Date: Thu, 25 Jan 2024 09:18:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123224842.18485-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> Aspeed SoCs use a single CPU type (set as AspeedSoCClass::cpu_type).
> Convert it to a NULL-terminated array (of a single non-NULL element).
> 
> Set MachineClass::valid_cpu_types[] to use the common machine code
> to provide hints when the requested CPU is invalid (see commit
> e702cbc19e ("machine: Improve is_cpu_type_supported()").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/arm/aspeed_soc.h |  3 ++-
>   hw/arm/aspeed.c             |  1 +
>   hw/arm/aspeed_ast10x0.c     |  6 +++++-
>   hw/arm/aspeed_ast2400.c     | 12 ++++++++++--
>   hw/arm/aspeed_ast2600.c     |  6 +++++-
>   hw/arm/aspeed_soc_common.c  |  5 ++++-
>   6 files changed, 27 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

