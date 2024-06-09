Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AFAC27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 08:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEHo-00030k-Jy; Sun, 09 Jun 2024 04:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEHn-00030c-EU
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:52:23 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEHl-0007vM-LC
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:52:23 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so2994110a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717923139; x=1718527939;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d70sB/N+M+bStshnDRlDMCr2vmsamFSMXxkqYGOFpRY=;
 b=HDu0G8bY01qAA589oXotFaNkBK0MDVwiF8jN3K7/rAjsuh6E+igzO1HqBpdRj7hIE1
 5GidJPwfOWLkMZG8Nsw1aq1Jqy8b624QYmn7sQ3eKGCy2lyiqrqW3U2hDGXV2NxnZTt1
 VVsFVUxiCoB2PERvWoSSHl1g2LOowXO0cRi51LiTnryVRjQowh80FnkRbbkQxPk69w/B
 A4VuirEmskSbnV1cdYMUvDHsVjgduzNcSZUCAdOyFLx9vjX4vpfwMKqYUlM+T7XXMigp
 8TmD5SrEQO5y+lIyv1OZIpW7gBU7TeDpK1EXPCio0m72FrjbV3t9szzHp4z3M6YUkRUa
 n4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717923139; x=1718527939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d70sB/N+M+bStshnDRlDMCr2vmsamFSMXxkqYGOFpRY=;
 b=quUsaKomexPek7Pi17TuyUOkOAE/0DzQuIcECcxhOarfCVnFzvKGToKklbfGqrsJ5v
 Une8LT4svjdfEa6mDKA9cvTRRSKY1MVUw/904Ttz9QmPD6A0yPcZc71QYHNGel2Jua43
 Bcqel3FRV0emngKYvkhbn7d82A9Sqgfnrv1yLm3GKMULu8KwkCWSaqwWZv0tBhIHXx7U
 z/jFRhU6HaoK0am8t7NPqx7FbTLGaOJD0RH6klGWDs1sUopC+zt9dM8+IclLbx0qYTyu
 1VPbT1zWZFEFl8X+Ufzc3jhAJFryIdGOpkJ/60ycsWxpToQiuiDuMnsKO6G9IywqbFi7
 K6sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaz3X0RRmOAvsxVC8GGQgL3zItxWOgz3zpAY/jL0QwSUU180QDseEfnuQumG4PBmP3t65auGU3UK9EuZJu3SyBX2v49lo=
X-Gm-Message-State: AOJu0YwJxkr1q/Cs5hJZ7Dr0JDYsOsHtEvoIeAFP8XEvpFAQJUxcp7Mu
 AX4kipGk+6w67iheCbv1/C7239ZEQUgMwDAR/kU8HteliX8iJU6U8sfK8nUC5DY=
X-Google-Smtp-Source: AGHT+IHZk7GmbaBVYmmF6c8mQa9DB5NCNsw0jU6mFWSvZp7MdmTqoyOTA+K21kepWlgFmbZKcPepcQ==
X-Received: by 2002:a17:90a:9382:b0:2c2:97c2:1426 with SMTP id
 98e67ed59e1d1-2c2bcac30cdmr6033642a91.10.1717923138910; 
 Sun, 09 Jun 2024 01:52:18 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2ee465711sm1613750a91.45.2024.06.09.01.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 01:52:18 -0700 (PDT)
Message-ID: <82079561-20e0-41de-85fa-d0a4c9256621@daynix.com>
Date: Sun, 9 Jun 2024 17:52:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Cursor: 8 -> 1 bit alpha downsampling improvement
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240608202045.2815-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/09 5:20, Phil Dennis-Jordan wrote:
> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
> turning alpha values of 255 into 1 and everything else into 0. This
> means that mostly-opaque pixels ended up completely invisible.
> 
> This patch changes the behaviour so that only pixels with less than 50%
> alpha (0-127) are treated as transparent when converted to 1-bit alpha.
> 
> This greatly improves the subjective appearance of anti-aliased mouse
> cursors, such as those used by macOS, when using a front-end UI without
> support for alpha-blended cursors, such as some VNC clients.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   ui/cursor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 29717b3ecb..4c05e5555c 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
>       for (y = 0; y < c->height; y++) {
>           bit = 0x80;
>           for (x = 0; x < c->width; x++, data++) {
> -            if ((*data & 0xff000000) != 0xff000000) {
> +            if ((*data & 0xff000000) < 0x80000000) {

You can just evaluate: !(*data & 0x80000000)

