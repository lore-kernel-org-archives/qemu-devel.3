Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F36C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWc2-0000re-QI; Tue, 18 Jun 2024 07:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWc1-0000rV-Oc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:02:53 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWc0-00030R-5l
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:02:53 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6e349c0f2bso689010466b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708570; x=1719313370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xcgha9EMwGFy4GfTwIT+dAmK/I6ZbD/6U8eKBQbvJxE=;
 b=yHBxIdZWCCpAcWvRaHd7Wh49eseV6a8G1dSdUiN7sI86UpT+Q9gm4NHKUrL0ecbRYO
 yIK7VQhHizLWeSkXKoBhQVbFDSdriqm4bFNlY2L/jXQijik0Y0P/N9N7F5NcFXlwtIeD
 aZ2QZpjCUEI/8DeSeeOHKdUNPpfEBT2xjsRxr+K2bYL15mBenJ0s+2B3VNuB3NDKZsNp
 hiT+11yYZO7EaThnRw5sVIs+fCVZ37+2pNVplXfD4Cw298Ztx59wBrJIwG7BTHmAw8a8
 UhC9zh31vMiQOhlVnpz1xFS4QXJChwnak/UV4aFVL2jhxqLzhaHsflhG3rNwebLFXjZr
 yiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708570; x=1719313370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcgha9EMwGFy4GfTwIT+dAmK/I6ZbD/6U8eKBQbvJxE=;
 b=bKOMs1WanUYW6Ns6Ie68OVIhQjmrjqwSO2a0SAFuDyCPpAl3q2yKnff6J0NouNffjD
 K9vwMh+kP7KOa0hME30ergEQtg/P2ecqgntiCkL0XvGOLvcLf1Hq+Yg792yYL6zwC6Qx
 rQ0sInReCS/8rVEAOFoff0MF2RAK468Jri36V1l+5TQRBbktMKO9tBOCPqzB+DS5edcP
 9pL/1klkM4w5vxZlemhKJ2BoWS9UZcQgL3SOzY55j5vq8W10pVvvZ66BcEL0yRZ2EmhC
 onhcV9ZhtwHVgJj8FkWyp9yPJdkop1z8JjkQhgwNjZhCnMKhssbgBZpmlcfMV5umL0bD
 r74w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8JCSxCWBE7UV4jY+/kpfK0AOnPr1Zdb+wOiy8m2DMY5LqcLffGxTRbPsO7E+LoaDDcP+YgyywrFGTwq6dKqbia8mi9+4=
X-Gm-Message-State: AOJu0YxLKJ4N7SZVORgIC4uhHSVw6r631tPr6CqSbJ00Nw8wVccKkWW9
 ZRLScOvYbsD1nzvcphguhDBIu5rRhpk8V8OoOHKBHTWmiAihi6p23fybLnNQgyoNzX6gQKzfTZt
 wukM=
X-Google-Smtp-Source: AGHT+IGZiB4TOusLWVX3ERf9zLJVoY4WNAK84tTxY7ZKm/36Wvr4gkTfJHbEnLonioHVYesTa7/8zw==
X-Received: by 2002:a17:907:c283:b0:a6f:815f:16d8 with SMTP id
 a640c23a62f3a-a6f815f17ccmr459067366b.7.1718708570402; 
 Tue, 18 Jun 2024 04:02:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed357asm610564366b.125.2024.06.18.04.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:02:49 -0700 (PDT)
Message-ID: <aba83790-fec2-498d-a0b6-4ea01a1893fb@linaro.org>
Date: Tue, 18 Jun 2024 13:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ui+display: rename is_placeholder() ->
 surface_is_placeholder()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>
References: <20240605131444.797896-1-kraxel@redhat.com>
 <20240605131444.797896-3-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605131444.797896-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 5/6/24 15:14, Gerd Hoffmann wrote:
> No functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/ui/surface.h | 2 +-
>   ui/console.c         | 2 +-
>   ui/sdl2-2d.c         | 2 +-
>   ui/sdl2-gl.c         | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


