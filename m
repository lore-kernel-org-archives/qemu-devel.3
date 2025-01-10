Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA87E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 22:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWNf1-0000Xh-Ac; Fri, 10 Jan 2025 17:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWNf0-0000XZ-89
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 17:39:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWNey-0003t7-Oj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 17:39:22 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1337787f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736548758; x=1737153558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LQWdR3Vo6mOzRVAsCrK7anjNxS9xSoc/aFefj2w9tcU=;
 b=NnjLEyf/iBCHv1zqjCqxftw6qgHnsFvx3//x1nHCGKHO+M0b80o5oLPc4i2eQJmDPJ
 DDt1KbeCws+v6/KIzmExTnQGPjHK0aJebzyVK19TAQegIO3AGsWiSCyd4gOsrgzDfOvX
 TW4+JcaP0E+JeQkzmaGehBdEi9fPZFxDiyTh58ItGe+48xpXxPj0Uqm+VbrwOIJ2eNQ6
 5hcCNXEf5yoAMt6/ADEx7iHZnt3ktC+2xkRPAAGvVVwwVyo7m3l5FF9zkDcb1QMjP3BH
 Lv/VMCk35MFbUi+qDb1t4LFqCklVKRlZzadt0naSfk9VIKeLIGlOCueaXWq5tJko4urG
 8aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736548758; x=1737153558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LQWdR3Vo6mOzRVAsCrK7anjNxS9xSoc/aFefj2w9tcU=;
 b=sxNNmV3yoYg68tcNmiaSUJF+cjj+UZfY77NIJey7i//+DCn2KgluTnxqIPzvx2ZaPX
 LSBkV6ox6iwlqJZ5sIBX95qzx3vrt0A5J+2sEqOI7eGbOAyVs/qUOeuClSO0UyvlkoFK
 evvc42o9Pt273YQprpVK7GxEqPgmozYOAMYiSp2BW3uSUMzQpsRUBGYqMog6Fu27sNCE
 1IXYhxZd3uY0GT6Tw4gjr7dg2BhuQZKHCNK8pfpwGGc1GdxOeLuTABsmbQETHL188GXf
 MifU/eeCQAxZcuAvyn46CV+HKbcLIJSpYUaebwDXU/2AXOkAYetAChJoFdAIP7zz4Ccz
 5Jag==
X-Gm-Message-State: AOJu0Yxkqab8JBTYVux1xATm2GYiwJRKdLRUGjzkJ13N+zs2uZsjlK5k
 gf9MrO6OGUBgEE09Q1ROZYLTrpy6m6MD889eKY2Tt9Ql974TrFf8jQk1gCsvfT0a594b9IVjM1R
 pKAc=
X-Gm-Gg: ASbGncswOe5nFTEYjtSf6Gl0PBkJ16uhEw4Sn79aBd2bys/ZptLZhvnFuab/X3lA+O1
 CBJf+MuEA+Obszdkxerje5gnZfvjnHuFdHBkAr6Hzi8r5Xs0b0RpQ+/Z5KG3KWg2E3XqqxtR9w7
 vQixwtpk4efnFNRi+hKEUl/RnexhtYbcGCO1/qVoDEM49Uexxez4fi3wkDnKT2M0atMZ14Qo4yK
 Z82BENVcrQbVy0AnuqCpJTgAFMax2VcG27vUHHIwELaZJDMKw6OqtRhwALZJ8DpI9vOy3ZlnqMd
 akVIwupYSzu2JsBSCZMkjRhl0mAUwA==
X-Google-Smtp-Source: AGHT+IEAjXfAFF1mQbUyBfHKlRVJU6FeFpiR9tYQ2vMuEX2n79PniqkcgMNgMD0tmMA0bHaHzc7U3w==
X-Received: by 2002:a05:6000:481b:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-38a87313a6dmr11856807f8f.35.1736548758443; 
 Fri, 10 Jan 2025 14:39:18 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80d4sm5477097f8f.85.2025.01.10.14.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 14:39:17 -0800 (PST)
Message-ID: <42324d00-5e1b-4f19-bb85-5c01e35ef35c@linaro.org>
Date: Fri, 10 Jan 2025 23:39:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/char/serial: Convert to three-phase reset
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
 <20250110182759.84071-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110182759.84071-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 10/1/25 19:27, Philippe Mathieu-Daudé wrote:
> Convert the TYPE_SERIAL (16550A UART) to three-phase reset.
> 
> Only local states are reset so use the ResetHold handler,
> like other legacy devices.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/serial.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Since this object is not on a bus, this patch is crap, sorry.

