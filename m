Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0202ED35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rqv-0000sN-Kw; Wed, 01 Apr 2026 05:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rqu-0000sA-EF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:27:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rqs-0005qd-VW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:27:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so1346679f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035625; x=1775640425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyPXAyOP8byoK4rjCGDImTaG3nqLzOfTVHtTaI2LhZo=;
 b=zmUMT25Xind1ry5fyhmCDjDeAcV+pHrvlsL3kE5GgMI6pQTCw6nMSC7LpIgxMCoQ95
 lDViXIOpL92dW0KWUFEZ57n8kO+yECqWzI4Jn1YidbJcvCRbwjPIqXHY1s9bldeekzhT
 SctO89NReAefbUfSnW4qCzRIArYMxrSIC9AnZoQOzIHxjndy71nmeonbvq9OHp6xICrS
 MJ4xpbKND/2AHrpZ5oJDjyQsFvRnpgErOGAfiK6A3RGLvgqpQdEGdd4/KTW6Hf5Y/tDZ
 eJh4QpGgvwX1zStLuB8JWxxM1bkT7hByprTyZbVwlTMbIJrufbMNS+F/d5HN01KVwV9n
 Zfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035625; x=1775640425;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyPXAyOP8byoK4rjCGDImTaG3nqLzOfTVHtTaI2LhZo=;
 b=NF2a8AT3pEdDrUkVEvtu20emGAJmnMd0P8oFMdA4fWK8/2ZRN2agEE5I/SQ+84PxRd
 xmBMhYJyMv0CUuAXRuYmz/bPzqvvauqJTv0N8+4dZcxN6IA1hxzoldQi/ARuWJzqErPm
 f/UV00El0CT9Eu5lZYqoDfzR+R7BsC9N6tcHToPFatjzdtDqgC7P4QAfSH+azJbkzF7R
 q2oP6YeMI3T6SY9m6b6jgYMr0Oq3F2OV5FL5d00ajB9PQ+dG0H0Om7ZpuMX0/w7cP/x2
 HveXCCV6paOBCpzuA12QY46w18+wA9QPhjSzN1F8/YlWCRvRuJ+ss4PKqgJw7HUMTdmO
 DVsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUljIBOWp2rbCakTRI6Xs6SkGDkPUXWh/E3cdmawjHw3SnQUlENsghoQUIa37JS9OPGDU8nm855C0rk@nongnu.org
X-Gm-Message-State: AOJu0YzSazG3dUII8gT+EgZicGPRHbxuMfFr8wGKIxnj9aYZnFDF6vpP
 cpIwsW/yq/tiq26OuRXxoOhV3lNZ32BAGJMpYOhdOjzOkMDsvbJoWLNvFapfcYBt628=
X-Gm-Gg: ATEYQzwhQQEFY+VuGCCduQov5WLZdR3eI0LK0DItjBn/2BK5lE1IXFKKobJ+20gjB3H
 5vea4F6euojU8W9RA8k562nujC2okc1vUes/Mkm8M3ok2f9UA1BqobuzZGD5hyussKfNqM40GAa
 paqPI4MEzBQrC5ovc1riwMl0vOObKwFBsRCo+olmGSqploXccWzphRkfUlX6265NiztWu/EKxRJ
 z3G2fSnGuVTHKhtKpYQ8yPDfkWDlwfnex4hr6GnJwQZV2oXFu4p+F0it7SsDpAuqFFxx7HHCMJz
 CV1XqchwR2oseNmuVv/h5n4e0SIL/E59RgLZDfBpLudshBEsLdaqqhKhJp9bAbe5x5VGZyKlgJW
 BvYcUVRexk8z/xWbBxz4FakE2GHTl0JoeDGAhsPnA0l99/1JTqK6/LjCI4qK9+SGgw+A+ruWwzX
 7o+Fiu34pcFUGUuiIGt4tPHDCU8N4oH+pn4DiKbwWD0Dbzz8RrJmD1QfX6UKy4J55iLg==
X-Received: by 2002:a5d:5e01:0:b0:43c:fb6b:b7f with SMTP id
 ffacd0b85a97d-43d150f6ff2mr5192811f8f.40.1775035625146; 
 Wed, 01 Apr 2026 02:27:05 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2463dc2sm34876237f8f.23.2026.04.01.02.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:27:04 -0700 (PDT)
Message-ID: <a6592861-ffa8-4dcc-98c9-f2adfead92de@linaro.org>
Date: Wed, 1 Apr 2026 11:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/60] ui: avoid duplicating vgafont16 in each translation
 unit
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-32-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-32-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> vgafont.h defined vgafont16 as a static const array, so every .c file
> that included it (via console-priv.h) got its own 4 KiB copy, that
> the linker may or not deduplicate?
> 
> Move the array definition into a new vgafont.c compilation unit and
> turn the header into a proper extern declaration with an include guard.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vgafont.h   | 4613 +-------------------------------------------------------
>   ui/vgafont.c   | 4613 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   ui/meson.build |    1 +
>   3 files changed, 4619 insertions(+), 4608 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

