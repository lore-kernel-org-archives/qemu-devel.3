Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A53E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 16:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSIqN-0002Qz-GZ; Mon, 30 Dec 2024 11:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSIqL-0002Qn-7x
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 11:42:14 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSIqJ-0000pC-7V
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 11:42:12 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso4366524f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735576929; x=1736181729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xeKnEKsR0+uOT+NFBKBAtZvitld2Kqz+mQfzQ7jeZOk=;
 b=JYXWiZ6tUM3g68X9KVCtS4etVUN+SBZaKCI8oXvmb7Iu5BI1I57ZkKm3lJVMxsUy/P
 pli6Nu7ghDHwdS8br3+LZmunxqnoaF3RYlGaSx24mmHCX4Ep77G8NRCxvBM7DwAiEkqQ
 wKBDkjO8MqIJ68k621nuze/XEKifzCf3K4QK1+VzJVRcZkWTC/3bRNEQKMLCixZGumt+
 eQLsbb6P4P/uDVF12kKyWAzOSYxnEnwmPe08WhFa7DLtQGUV3wumsfvLLZnehJlbbb09
 5SO2K+Y3MkARhZAabnSKPf4pT+mAzf2qLS8fjNsuFQJNIwsz8te6ef5bRQp2lpFqOMaZ
 mU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735576929; x=1736181729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xeKnEKsR0+uOT+NFBKBAtZvitld2Kqz+mQfzQ7jeZOk=;
 b=ZDOXP+AuphPZurvwAX7qBf4CxMyECfPrjTU465zorkmD2MbLPLsJRG6oWi7I8LDVlh
 53Zuu+pqpIJhtCFqDcbr+HXQGAgn2/EyHPrwszW4KkLDdnhvjxMvUTjppilUKNRRxgBG
 WFpJl50v5sXZGk9Hs3P93Zg0LTsubiRIiMIMv7NyIkZFXZISeaBZQN+wNiTw9ct8rqyv
 pABsNcGaWGgT3A7s6QEpSH0J08UOPdXdrZiNgIXG7vBUpC2dyx74nfZwhvJnjw5s6ahn
 0FZpRa4MrNEjnSgpsszswBIQjbAqF+Of34qhHWgmWrcCzGf/OEIjh2r06/J+pY/ZUOO6
 4BIw==
X-Gm-Message-State: AOJu0YwHNNNHqzokU9fs3c2+zCIDxGEkLQ5Cf2Hl5flHQoByuQPuDfz0
 0Vit7rUrwfTmdXX790zn+wFT16HZdL74JmbWEU/9j+A/KRjKcwaeZrpBZubv8sznmNsSdI8ou3u
 6
X-Gm-Gg: ASbGncsl25TP5F2y1SG9gssm+9cwOD5cJ21i9FRAUgpJRYRtTjfAycMeGoJBMymxBs3
 9SFtJjciYqwNbA6YROG7/FR9A9ajVAxQp/UJVKQ0zC+xAOB64H7v0H1NUQUOr5Wx7H7SgNCipdS
 8WvaFZ3Qt7Eb3T88oE72Oqebxnw/7tHcbH0lm1hjIg7UrFXptR+KpwFJgU54erYAKh8d0za4XBk
 atXQ7zfZPdgjXSUCnQ4k1m7ETtCAuWtq2fHfms2qKAqKOSAlDq8A0pommYNcnPSqp3jDAa+rD1L
 9/pi1UDGoZcUWygv/MLRr0vC
X-Google-Smtp-Source: AGHT+IFSOfue9OZ0StQtjpEHd7pGzqC744lEPd6nwbKJP91hf+X3OX90JKPSuYktgpgVYlnNiexKGg==
X-Received: by 2002:a5d:47cf:0:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-38a221fa9ffmr30615491f8f.33.1735576929176; 
 Mon, 30 Dec 2024 08:42:09 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a457584bcsm12989464f8f.89.2024.12.30.08.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 08:42:08 -0800 (PST)
Message-ID: <20fbbcc8-bf6d-44c2-b904-be52debc1f8a@linaro.org>
Date: Mon, 30 Dec 2024 17:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw: Mark architecture specific devices with specific
 endianness
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241106184612.71897-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 6/11/24 19:46, Philippe Mathieu-Daudé wrote:
> When a device is only built for an architecture built for
> a particular endianness, we can simplify the device to not
> use the "target native endianness" definition and directly
> use the proper target endianness.
> 
> Philippe Mathieu-Daudé (5):
>    hw/i386: Mark devices as little-endian
>    hw/tricore: Mark devices as little-endian
>    hw/m68k: Mark devices as big-endian
>    hw/openrisc: Mark devices as big-endian
>    hw/sparc: Mark devices as big-endian

I'm queuing this series, better to test it early in the dev cycle.

