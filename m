Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A9ED35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rZT-0005GK-4K; Wed, 01 Apr 2026 05:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rZQ-0005Fb-Ue
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:09:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rZP-0003LX-Fg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:09:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso21397815e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034542; x=1775639342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zECXBi0HsWkl+EY8PYn358TxyJ/DCUNY+5o4yADkgqQ=;
 b=SFIFXqyfY5z4TCeiYGHcUbd+SHeCaqOBkulFbRZdVUijAhB7rILps+W0YrXI+yVk6d
 5eeUgpm+mCx8NC9dGxD9C5mVGneiboZoycz0lpR3tpS/sEcAvNQ7oKl9xJaWiByn8uJc
 hgxznxsS091cXPCcnm606TpmVxEV7/uFhtMxQbJgPLPvzY3iWaZCgt7imNa3ly2b50gN
 S5k2JOsQ4Awj++cQnG/ceuFfNCzM1yyPFpQnm7Sy1jjcLOPZ8Pai0JFx9FiL0elyVr9I
 dVpUtXwCNazKD9YckWgeaV/ud49ok4PrUviTW0YdmzNregd2X4wY4wRyIKVsGk73oZSL
 oA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034542; x=1775639342;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zECXBi0HsWkl+EY8PYn358TxyJ/DCUNY+5o4yADkgqQ=;
 b=U1/pJqdNOZKai+BRAieX8Pq++Oc+vS4Ff6x12VfX6zQzrIywhEtThAiJLXkgFmKCVP
 kJqbw9iqU30C2pCdDTTgUho+OjwMrTLqZgnIsVN8ij/l9Gs7v2LXV4M8Cubm69aq0Y0Z
 T6TpC6n26E5K+w0qVJXHoVWygXDnTbc8vO4Shan1BCMxlFFULR5P+9h+F4MB/7ty6Ilk
 tXtrJfkKzLo+dGjZx5WXbdpyG8G73MrOvjgWK6cw9O9pvpskmXXXTXdyO+Q4WK+WEDFt
 PSyiYUgkwHaXcd0ISUnj2o4RgXYQtf2Xg09j5Ixd5eLPi+uRCRAJ3DgQVyqgPpIug0TQ
 sPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX92E+HByYOB6bmotu4Q5lK1pslv+Y/eAGc8VrKH0IIv+1KLuJhefJTecN2nE0AKRVGybHWC9PBg4b3@nongnu.org
X-Gm-Message-State: AOJu0YzLzmQ1TusdtGvNN8yJ4yrXTF39C4oq9k5W7ekpu3OXXYjQivze
 NpykxSiyr05oNCazovD3N5QF4OVTYkf3BnR7SfeOZ0pb2H2RQp8xX//LWfTc8WJPhDpQCTgUXBz
 IXEDJO4c=
X-Gm-Gg: ATEYQzx+PAzn2NL35+o1SB2in+ZrinxC6FEo1LWdB/zTkdTPvzqxJxoFaEELsC5AKLh
 2Fo+hqxaCCHY9rxzTeyC3hrOc0LFw+6N5jbSvyeeI1MENEX5QuXYnl1vWFYOeB5V2g+8g5mI1iO
 RswxKSPTAbXosAUsDQXB+ND0p/Kl4bqmPmfzfTJF1ybHSzsReePE/nQcmvDCeJviOPbjzgZkknn
 vCdLV520byJJbYG53QrGf9JofRTUXdwQ0ywIlXHNIgFXg6QRk+V63LY8xpwXukSLwO78aY3/K3a
 l0G2sahvvBY/+I5oApVzJqyBtc64qS/FF8MFzLDSZbnbTgJeFNNduOBeGGZugB6Ll7rBkyVo4Ao
 afdjUzUe9y+Qe4h0VIT6tFP9VxyyjRuqkkcuEkS2V593rO1dE6DETJ3mLkMr7uqF2nxHyK8NW4T
 4JHijbB409zqxKBQwMUzI9aqInfrcmMst7zrIsyQXZvppKxgpMxNBU1YQlyVmQKcdakw==
X-Received: by 2002:a05:600c:34d0:b0:485:3c66:e21d with SMTP id
 5b1f17b1804b1-4888355e6d5mr49820015e9.2.1775034541554; 
 Wed, 01 Apr 2026 02:09:01 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e81a2cesm104655445e9.8.2026.04.01.02.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:09:00 -0700 (PDT)
Message-ID: <48f8a294-8dc1-4a44-9f4e-016e960f3f5b@linaro.org>
Date: Wed, 1 Apr 2026 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/60] ui/console-vc: introduce QemuVT100
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-15-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-15-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/3/26 09:50, Marc-André Lureau wrote:
> Start moving VT100 emulation specific code in a different structure.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 381 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 192 insertions(+), 189 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

