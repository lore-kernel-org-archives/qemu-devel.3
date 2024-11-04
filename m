Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF9D132A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uJz-0003GW-D5; Mon, 04 Nov 2024 05:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uJx-0003G8-N5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:28:29 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uJv-0000Mr-V7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:28:29 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so3737534e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730716105; x=1731320905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HL1wmtLlw10jUIRW5AvDG7H4j+TXTlub5SE0NycX1iU=;
 b=g7citQF3Rdaib8BRZz/ooKaV8lSQjnzcdYtJ4w+STT+j43jcrM+W5uClkB5RfrUmJy
 IdtvkZmUbHEykxLL9vQJOCQdAsKACP+a9hoWh1IkLMmfrOoTDnqOiRm2TEfM5Flc05Pr
 I54KcBNN1jYiXqInqoIwWY8Wl4nk611e+9iyQ8xJ75WwkHNkaRNGNs6WgemMZcSW4w9f
 Sw9Ptw1/YEIavc9f9JOeaEkhPvHqh7qN6vPYLg+KCPzgR9yapFC5ScUc1O3gp74Lsz2P
 0sd9g1B49cvJrd+achNa76bUUkzNJ5rWqXGVMNrh9g5tAs/nX+I+0hAtQ4s7u8guSVa9
 PRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730716105; x=1731320905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HL1wmtLlw10jUIRW5AvDG7H4j+TXTlub5SE0NycX1iU=;
 b=Rt56OgplrvJw5/CAv/o+oi+jTsT5sLbjEt8zdIIVqq4SmyNFBMgtnnKBSA54BH+zQO
 eAc/RdWSsro8eSjMsJy4HtX8D8PMbA6v2WnC3wlqRph6M2Bjv4P1KEt7zuBzEsO4veM8
 JgJh9K9crS3sic9ttSVBYXfvDk/e6Lr0Q/qWZLm4XsHXdtqYTnyhunY736ch8qO1Yx4a
 gD54aH2FQo+9Dlqa/dnh+ueDLv0zRAPC1TxpM3pY1/4ej3TzMoEzioy/8c9Y3PwVnPmv
 ZEF7TrxDQrJFSbLG0mHHMDfnZ/g6+gMlJ36ulXtjIU413bDUAXnVdOjO+1v29J3nmLWn
 Oc9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcLUfrP8CVHK7XLlxcS//xJPFX15k1VFq6/pfYgHqanZe9d0/V4iuzREwYXE/GiPVnPYuKl2Kn/3o@nongnu.org
X-Gm-Message-State: AOJu0Yx2TqPZ3W2FTWka2qaZZHJd9GnWQw5rnDH1UGz/9d49wbg0dSUo
 cBTPPhuEAgRwElES5jL1zGXSXYhPEv0V2lsfaMGFWNgRK0hYfMb3/564Xc92ps0=
X-Google-Smtp-Source: AGHT+IFZM2TK+Qonu0pE1kY3K8JYOWziuFv6povuyP5r3IapzNbt8fqnKfOObcaSwmbtfySzQN3goA==
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18098991e87.41.1730716105100; 
 Mon, 04 Nov 2024 02:28:25 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852e4sm147290475e9.29.2024.11.04.02.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:28:24 -0800 (PST)
Message-ID: <11a071cf-1006-4945-ab2e-38a18ff8ab19@linaro.org>
Date: Mon, 4 Nov 2024 11:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] hw/sd/aspeed_sdhci: Introduce Capabilities
 Register 2 for SD slot 0 and 1
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-7-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241029091729.3317512-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 29/10/24 06:17, Jamin Lin wrote:
> The size of SDHCI capabilities register is 64bits, so introduces new
> Capabilities Register 2 for SD slot 0 (0x144) and SD slot1 (0x244).
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/sd/aspeed_sdhci.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


