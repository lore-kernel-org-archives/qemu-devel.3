Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB23E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFGR-0004jx-5K; Tue, 07 Jan 2025 14:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFGM-0004fx-3H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:14 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFGK-00085q-IX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:13 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso12108563f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736278151; x=1736882951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vyFFLRSOZZ/LjLvhBoGESjhVRbOb173bsmDRFnpcbhw=;
 b=huqhosXhy0Jow+rkVAKyfpl0NzMNFLEXHHWrL5g9LxaZ5c/c9EvmpTjlxW0IMZKuDp
 LeBH/Adtd+eAu4aqrUfRIrthyrFIjJYg1bBw/yaR9+DTKbHfNUsLNwzcDW8FKUgXOdUF
 RtaYKjJSES4IG/RA4G6P01XJTucRe9p3LuJj0yDWniA78Sn3DZIDXN18yVVmNYdzae62
 kwcQoVa29wXzWPghu44V5feXQ5IRCJl4u32Xn5qEewW5rIR6xkDyBngBKINkzFGn2MCc
 JvuhrTvqFDCGV0lloRYjCOIx/9tg7dqPafqZz9GPDFVwLnH50eNeJf2LawKdLTftQgGm
 9cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736278151; x=1736882951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyFFLRSOZZ/LjLvhBoGESjhVRbOb173bsmDRFnpcbhw=;
 b=Jwxvw+4N6exGH5X3NiRluCyXIV0GCd1xL3J9dLa287pdLCBkotoZTXCCMCVP8l6hlO
 47xfMiJMke1GpKP4BqQU1izkqQ3jDQI5rMYhji7wZNDPHbJdUOWMCgf3pyFpe3Df36W9
 KsDETclwB9FaKmOZKY252WBVJzfeLk663V1irsMxWVcEurui7c6N/oe+V417FnvBO9Wc
 677Pyj6t2QbJG4MOoEsdVxoUV75puOCgDnn+VKSPnn2nbfAy32V5SkB5h82pa6hytZ3P
 gNfXcesBnB1amwBXKgfrtMqqyqQkQDXKATrdy+knnQ6m8wz6HbGshXhaAMVSySgRypa5
 wcLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW84atNgdCr4d25AVosHlxzUNOE3zkGMdUtbckaE36TLm44/iRk+VUd1wShmiujHQ4e/s2c2UNcafZQ@nongnu.org
X-Gm-Message-State: AOJu0YzPFLuIVEInaoFE1RE8ghny0lYrJsQmIdJlqLhAo+k7RaFiv/vZ
 YKw/SnwZaubK8rdLtE72muW7fh1ia4nA3bNPPxalx8Mo0qgdQ0AdoNvAVmxpR6A=
X-Gm-Gg: ASbGncuz2rA18QJL4zUy4lDaAseGRkR4fctKaUmIGOaN62YyDYZBNQUrbPjvGrO2vJv
 1a0qA0A4m/0PITwyXuiF3wLxm5sF9g39Mj8VqgXLPOgwywqZ4St5PuGU0RWI9ttEF4UDUxAMApj
 AhgMRHukWS8Gqph+3+gjdjZGD93Oq85ZVwu0EnjwXlBlckip0d81JMpJAt4WnvHI2W+NH8zUU+d
 fO+f9tKN1dF1C9jUEQAGV5vAaqGhuyXT3R54XZrtW9P7kdbV+AP23zeZ4TozL2wSEoaEu6XBp6F
 05hu4lkV5lCGJCh2qo8h0grT
X-Google-Smtp-Source: AGHT+IFleEJm8m4XCtGbbNulXuLBQqJlFdJQsA03IGb0hmn9d/izoV3fR+n2BCcI35dG/OSlICKWyQ==
X-Received: by 2002:a5d:6d06:0:b0:386:605:77e with SMTP id
 ffacd0b85a97d-38a223ff609mr52959353f8f.49.1736278151057; 
 Tue, 07 Jan 2025 11:29:11 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e3fsm51734282f8f.5.2025.01.07.11.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 11:29:10 -0800 (PST)
Message-ID: <a0fd5f28-42e9-43dc-9b0d-d4022fe51cee@linaro.org>
Date: Tue, 7 Jan 2025 20:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/sd/sdhci: Introduce a new Write Protected pin
 inverted property
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <20241114094839.4128404-3-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114094839.4128404-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 14/11/24 10:48, Jamin Lin wrote:
> The Write Protect pin of SDHCI model is default active low to match the SDHCI
> spec. So, write enable the bit 19 should be 1 and write protected the bit 19
> should be 0 at the Present State Register (0x24). However, some boards are
> design Write Protected pin active high. In other words, write enable the bit 19
> should be 0 and write protected the bit 19 should be 1 at the
> Present State Register (0x24). To support it, introduces a new "wp-inverted"
> property and set it false by default.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Acked-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/sd/sdhci.c         | 6 ++++++
>   include/hw/sd/sdhci.h | 5 +++++
>   2 files changed, 11 insertions(+)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


