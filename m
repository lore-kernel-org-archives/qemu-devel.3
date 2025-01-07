Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2121E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFGB-0004bw-AW; Tue, 07 Jan 2025 14:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFG8-0004az-Oa
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVFG7-00083U-9b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:29:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so7607027f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736278138; x=1736882938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0JTBG8DEE9pSJJctN6IsBh2WG7ETth1gvgAg+/wJPaw=;
 b=Qs+51WzIkcaUArs/pqCG+ycVtNuNTk2J3tuLpgdKN/fre7XcsauYN67gD0QHYdxyC5
 vweoQ90YSSZne/IWpGVhV5Y+hFRM63WhzgAlizpGmbMAvR8KMcEOZI8A5cnsWuK1MVbe
 NoLyCmK/S5TGD1FKC9DUyGMYaW3HLc5A9qUFTYopxgI2H/G635F1WC4zrEjePdKSOXsx
 kwM5O3/NW+imKZJUzrhtL0gglmsebUgfdBRFQ1S2Uwvrt0H3UuqBQQc6LIINkgv0n70G
 F7VJwUdWYqC07oE7tF0COwpFdaVaO6uO4L75MzKDZ6vCCU/EVz3J+9LHiRev3ULccyRI
 H/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736278138; x=1736882938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0JTBG8DEE9pSJJctN6IsBh2WG7ETth1gvgAg+/wJPaw=;
 b=uxV4+1CpmOYoDlMgmlKf72gCyDOnpYxFzwcW7LbNdOA0F02Id8dYwSezvneG63kP2v
 8HV4sEOAzEATfGvOSw03/2Jiw8VrSZh2F2Qdbq6iTS8eTWTq7AW0NV4RDQt0he1Q9a9J
 DHgrXlQrF3O9WsDGeyR8aBLXHbFriG+npNWJdpDgsAbhshOMVkOizmS5SsqxoCaS+WiY
 1jOuFOPTcK7nZ+UwNoat5LBXjNYCCuF+3mNlaHASPT45lwOdAKTO/NvrGeJArJocYIdH
 L4/yaZKkPu/Y2KctM/UeiWQs7f8STU4lGoFTnmVKXY6DPxhPx+Ma0hKoJ6mVIV8Hywqv
 o9DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSSdByxVLqhm7YgdUaWVGEWMCpCki/ymNNosc641MnEfsFfT599YlWRtrwpkP8hdMTqCdZwNbFweu@nongnu.org
X-Gm-Message-State: AOJu0YzrEN4AMngAQJRLLVwOJI+1uR9TOyNWG0j7f6pG8pXE36AYv518
 JKdtO/JjeEgBXagAPeLFvWWDRDjTwwxapE96C9FF4A26+lCcX/uDkytzZ+G40ms=
X-Gm-Gg: ASbGnctk7YVPwDUs8T/cPjRttyObOumQTdHP9YT7jS/OuQkF/BCAD14jJLQcgR2kxSK
 HuEYdKlk0KXJ5DRuwR2+8Jc+XPA68gaRyOsi5WsykYplf+5JWdEr2dDg3OtffDQ7XMaY57Kf0L2
 /F/dHadEKm0TJ55fBqI3JLLWH58/Z4Y6oMRDyvsTY36NT2DQCC9LbNxt1Vjqzz6EcIE7q/U53U9
 OMcRmHePWn751/jeO4Gn1B8DvQT0tJw1QBwyrztA+cDN68brcS/56mMHxfQ2CtvhqWuPyPyEUKh
 34Efhn8BPUHXWU+eOvn+pfEy
X-Google-Smtp-Source: AGHT+IEs/hNR9cBW4mX15SjVSS+wlMZPtjZUD17GBmZVUzu4zBQNO2PGwx+5a3hsCWFxxEdYH39f4w==
X-Received: by 2002:a5d:598f:0:b0:386:424e:32d5 with SMTP id
 ffacd0b85a97d-38a221ea939mr54805325f8f.14.1736278136393; 
 Tue, 07 Jan 2025 11:28:56 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acadcsm50576763f8f.105.2025.01.07.11.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 11:28:55 -0800 (PST)
Message-ID: <52b6eb4d-b863-4938-ad27-03f6978c84b9@linaro.org>
Date: Tue, 7 Jan 2025 20:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/sd/sdhci: Fix coding style
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
 <20241114094839.4128404-2-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114094839.4128404-2-jamin_lin@aspeedtech.com>
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
> Fix coding style issues from checkpatch.pl
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/sd/sdhci.c | 64 +++++++++++++++++++++++++++++++++------------------
>   1 file changed, 42 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


