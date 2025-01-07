Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019F8E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFGo-00051A-Kc; Tue, 07 Jan 2025 14:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFGm-0004xI-4y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:40 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFGf-00087C-5f
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3863703258fso65549f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 11:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736278169; x=1736882969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysQYbhPDsvLVcWrywrFmBXdnchnAM++f6Ua+X7FCYiE=;
 b=rwZ7bDOmULjmBeRDf8Xg6WB6vDeTE/8hUdXSC38a/vWkGaFeaRXYMABvFd2LIif9da
 LHZjcz6QE4Wx6qRKYhNARsHSWJzVEPWH7CNB7bW/5YuzYltg6Qid0tEWWwP9PW/kqTb4
 PPePHauMzLGYyH+wGOhr1Um0K7KMNZxfFzaUNDg4bDx2K+mcagXHZ57FNaDDQlPuw8Ex
 9Z7UhiLHoE4g8ceYVbffttA/mi1Kg1bIvayfsYJzMPGNVTL/LkbXJfs77UcWLsF8LV/j
 nlEnKsTUz5y9EX0nWKpCTTNFc+79VpVJkFSM0WYiPIrXEzzHaMe1J8CQkgkXWbs5tC3W
 xnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736278169; x=1736882969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysQYbhPDsvLVcWrywrFmBXdnchnAM++f6Ua+X7FCYiE=;
 b=US78fh/0BlVu9gGDRMaVe8zJ0qWAe9DFgWdCvAZxhEz+CpUb3gY7FBJS2a5Mpoou0H
 q1W2DZfXsAoBT277yD4UupwKmoZoEgilI37VMTXtvEr5HmeFsbIQNQ6w1uIafdYUSHWj
 5XszDL+gtE4j6RgZQgeWgOF9COskVmS04UlXFVuIc+Z6RFr64DLBxOCQ42K6j9XoCKSw
 GHJ/oJqi5dOUGUe+rnsqrWVAlfcv/OGLjgMZVnULRM5z9MDJK06RBIW6Dcq2pArxJj0d
 fdV8/xvy/e+lKHDrQRzL8VYOeQXgnNMgDZJatd/vsFSfuYmW9pDlGO/LBRCkKWl9y6QY
 Yu1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+uLk8ryRc2eLFTtpV1IMG/WeRTQBBGZETzEwPlahru2RX7ve/nWtPIVgq6mf2JFpPPk7qbL1AuxCV@nongnu.org
X-Gm-Message-State: AOJu0YxQEM+fmynPv96VgEIaT07hMnfqLJ/34QhcFIZsK1rwNdZNDTGo
 8uchnpm0mNbRUkCBfOEOUPJaMAJ3c3rTtW04dVOg5ApYngUnhf8x7oJVnmECw78=
X-Gm-Gg: ASbGncvY2f3a00AYX5IcLd+6/Zlgtw84hxIfeqJ2tI9qG5IRw1EnY2xXZscEoqvzRd/
 AduOV/OP9aS5yNutb86oietbAvSNIkaPJ6AVUWgR35+yGb7WJOxbFMCbE3ybthj9SpBud44hl0v
 N9B3sHvoQQTIcUjkVADuErvVrPcLUHfCQhZQAm0an363DSmHSKlIW17IkGHUE5bzrJO1Aob++AM
 B9i7VO/MUIWGKrWCzvaUGJznyxfSO4D4zNpkImBLtEqbhizCK8SMgqSh/6c4YVCutDnkIGhsQ6H
 9EPEKXPGfo7NFPnssD2cnsA/
X-Google-Smtp-Source: AGHT+IGioO7qyGqe2mxvRC3xijre/nhY/Bl8nTvIuh/8wtxr90K3Tsd7pN2WsQUQgbXSU77VuIxGaA==
X-Received: by 2002:a5d:64ac:0:b0:385:ef14:3b55 with SMTP id
 ffacd0b85a97d-38a85f4eecdmr325383f8f.19.1736278168728; 
 Tue, 07 Jan 2025 11:29:28 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84ca21sm51404403f8f.63.2025.01.07.11.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 11:29:28 -0800 (PST)
Message-ID: <628776e4-bd9f-4823-a2c5-b8ddf79afc70@linaro.org>
Date: Tue, 7 Jan 2025 20:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/arm/aspeed: Invert sdhci write protected pin
 for AST2600 EVB
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <20241114094839.4128404-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114094839.4128404-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 14/11/24 10:48, Jamin Lin wrote:
> The Write Protect pin of SDHCI model is default active low to match the SDHCI
> spec. So, write enable the bit 19 should be 1 and write protected the bit 19
> should be 0 at the Present State Register (0x24).
> 
> According to the design of AST2600 EVB, the Write Protected pin is active
> high by default. To support it, introduces a new "sdhci_wp_inverted"
> property in ASPEED MACHINE State and set it true for AST2600 EVB
> and set "wp_inverted" property true of sdhci-generic model.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>   hw/arm/aspeed.c         | 7 +++++++
>   include/hw/arm/aspeed.h | 1 +
>   2 files changed, 8 insertions(+)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


