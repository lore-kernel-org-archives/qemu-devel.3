Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99A6EF8FEE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxo2u-0007tz-11; Wed, 04 Mar 2026 10:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo2j-0007pG-V8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:21:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo2c-00050N-MH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:21:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so59872085e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772637697; x=1773242497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QlRN3GtoWoriKA/xgEvwpTDc9i0Ng4RtW+yCde57ww8=;
 b=RtVWGW8WnYZeE8mJIJogiTaTrY9DI1Mz6MDfVrJYepknY/Gb4Vlf4ee3J+4JwuGG4u
 yv3xTM53/8ENhyavowEMVptQahOALBpZIHpOHeIucSIuqqcYlIM718feQPruIwidIalj
 lmaeWZN+1aFg7B4kHoXKmUS0zW6Hvo5PwbIN+bT88MLqfsWhI1Aq2Zy6EhDZGuA1IWur
 oyf23I4aplveiQGKrvAYlabqS7+TM/U5TwQZe3gpK55ymhKaJ5UXHe0SD8y1Z7NT2WW+
 +8WcIQxLaPcGq/O6sFg4ToPBesZMG2o9bQMuidyW1sJQoTuCCHXap9JGXEFGjozSOSBq
 iSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637697; x=1773242497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QlRN3GtoWoriKA/xgEvwpTDc9i0Ng4RtW+yCde57ww8=;
 b=J0PrbO5/9IiLsdK+Cw+obnXUapVTnIZh8qKwCYVDk4437bjIC+k2gW6hAWMVZ1PS7W
 kI+NUc59PRdnr9IR2T9jJ9F/wLG37TckHog53gNc/wNDmhAHzACQJZSwp7Hst/rFiRI+
 qd5Ok/I9VzZmsHdxZ1YE6r8LS4wXuwNSsYsykEuj0Oj8ppkazhVJ+7xfU23NV7W8An9m
 kRPG64kH0YbDl6z2/Re1h2m2pEE2BsFiNZ9u2Nub346cHVTmGpQKvDNGz8dFzSVtxBAy
 11Gbd2Jj3zeYZbXo/LBj6UscKFIomHleyJ7yvHk5vKrR1V5MN9Co5TKl6SDZ0KIFbMNc
 ICNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT4/r8NyrPouuzm4DST91/wg8nzjo3P9VNgN7MfWD0q6HO6OriBzQcrL2MyUi/IfnapAxecQkJnlvI@nongnu.org
X-Gm-Message-State: AOJu0YyG0ohNITsUd6kZZN0wop4cbQYs3x/kQ807tKRAAnlSeCAT/Qt2
 py+qkDevPjH3XUmHyjFcYBO4APjBxevOLbU0cX3qbQsTnMr4tGtrzRuaKnYttN6dLDg=
X-Gm-Gg: ATEYQzyJULK9NhHpgGlsf9/8b5jHyRBewVnS54ynir9w64bSo4GK4GXkwUhd6dVBgyC
 NVe4+BHwyjdL0pHvXIZHzqJaIt5wYkBtcy6DgwCe2Jj6TzBB6iv47o2nMtWjFf+/aF2EVcJqfc4
 PnIUDc2IfTpFT/v5d2QQw3ozU1VEnVckHsDOK24SPV3JWX8FQOeFNRqDjD6NHrHzE6ZY8/atejk
 619iOTYOXSFKE8Md50FKJnqNzQJiapv9bffS02kYdKQNhNolQrTW6PdlgidfQNxeUtlnnzRMPsr
 9oMFGBx/WOlU0kHkm+FnRXQ60DCcd37OLtry23szOu1odA3JLwHtZ/kTHK/lM912p/tiQ12aamC
 TcMta6/YTM9SsDcsttyAD1p0T6Yv15c/1YW+VNhtN3vB3yVCjqZ/3v8am0Obguwvah8UIqtUaGN
 YlGw9jkzrb3UosicZSRbjv4zD6JsnlfO41dgubObjxYzEWqGVK01WSMPrP6P2S3dR/WgEdgD5UO
 5h0
X-Received: by 2002:a05:600c:46cf:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-485198cb8d3mr36710915e9.34.1772637696864; 
 Wed, 04 Mar 2026 07:21:36 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851aceb94dsm21466615e9.4.2026.03.04.07.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:21:36 -0800 (PST)
Message-ID: <397483a7-0c58-4573-b3ef-908894b570cc@linaro.org>
Date: Wed, 4 Mar 2026 16:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] hw/char/serial: Avoid implicit conversion when
 tracing
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-11-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303222143.142741-11-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 3/3/26 23:21, Bernhard Beschow wrote:
> On 64 bit targets, the MemoryRegion API passes an address and a value as
> uint64_t, so use that for tracing. Keep the uint8_t for reading since
> this is what the device model produces. On targets with less than 64
> bits, uint64_t is wide enough to avoid narrowing.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/char/trace-events | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

