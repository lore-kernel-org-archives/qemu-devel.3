Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162B2EF06FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGaz-000729-IT; Sun, 08 Feb 2026 21:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGay-000721-B9
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGav-0004PM-7H
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a7d98c1879so22258045ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770602504; x=1771207304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uD65VxmQWfUIsfuVlKDtGMUX6kZqrnFjyoHCWiQmth8=;
 b=kFeEteWu6R2F4lE0qMuU7yT5G6DNywVA8MB81uYRZ20sQ+iV5Agymu6ypKyndE7AXl
 4/GevcD+pJvJYQrEsn7et7EnO8gUbEhN2vzabfvO+m1piTT5/Veo7RZ/Ra5bAeg6GHTy
 OqJYrOdG1NdPl+TRpbzyRBHF+VKlv3x4D6E3Erg50cTAfZy02JhLBnKfexHpeySC0q4B
 ENh+L6ShJfhw4AeNZiJqHREKuupRtoFp+fLUFB1HjPoPIYhN8NEWbmCibDMhXo/V01C0
 uqWkGYfGGoPIfDCF5KcQ05cZuDHvQOo5t65fvNspNJ6yJjkqCdyoz6439s0BBbrsM4TN
 7mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770602504; x=1771207304;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uD65VxmQWfUIsfuVlKDtGMUX6kZqrnFjyoHCWiQmth8=;
 b=FHPmeEvys6mJddW0M86wtMCuO1Zqth1W5IOJ4c6n9Uwlmq7sgqb5pNdbpa75R+gj19
 bTadVFsu+XQqPpxTbpEzf8dn+SoHg0/BlPuE8Q+R7RANtONnH3/iMdt7hH0fNTABVqmW
 WWEdRqQ7bZgSdQaS2f5iYIE94xWGUejhCLlFTVll1Tu6cF3nck5BFn/wAK6h4pmv1kOq
 6RxdS4jn7jLyVYTVPitUe48idRvVZnJEo5rd9yAub5aSJQoPXJhtPwqU4vToMfAwhpED
 eSPN0rYOOALLG/MtdU8JHvuRkwnLn3qFuZkbrUZGn59XSjYV6CJhWPwQ6IIAaQME5AvU
 aukg==
X-Gm-Message-State: AOJu0YxBpRmK8RDkl3Y2cFa0H5z9LLgoUpOByJWv7jRXQ+dDmUDvpBda
 vy5TPWjNg03XAC8SY5qdUA+LZRxKXIzwJjrSCwIvB5nN6i4Y+VnJt+TGBgOYKMj/aZ8tfax6qmL
 AOygE8kY=
X-Gm-Gg: AZuq6aKf/0HwqvmryPrSTyugIEw7wWFOsdxGZTg7xFG/EkzAryBYYmJUtjr5a+MUSGF
 V0BDEYL8jova3TmUWPa29AYbdJyb+SU8z53AsW9eQruV4WMYnTkz90r7GQotd1e43WOht+h+n/J
 d/JTt1V4ky8B5FORJUKdH8o1wIIXx4akA7dTSqg5glu5s8q5s/TS5G3u9MI1mTgNX3sKVCv7qY1
 +VYursFvBSlCPDRYMNysmUV7M0p+KbRCMi/ugpaBGxtD2duJpUZZ0P+Tbj5dpl9+0Vw/RgIWVKG
 HHhARO7rWUKMlJXWtB6cyRC3HDefCTnWTRMAXZTiXajnBk+CXpkeCnvrl4XTyjy80IX9pi6sAgX
 lI3lPNQ/RwCN+2aYZBKdiLANNe7REpotQ17F8xts5qyyvEq0xWhLR+fyZsYyd7DMAf3OBx/4djY
 Ot6AY7jlfZfgQPxQPRhFQS1N8nSk4HdUv43BLX2ltQwIZSbtLXJf1MgnNBgbzBJTg=
X-Received: by 2002:a17:902:d547:b0:2a9:5c0b:e5f4 with SMTP id
 d9443c01a7336-2a95c1b2e9cmr81304045ad.28.1770602503520; 
 Sun, 08 Feb 2026 18:01:43 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521f8cb6sm91159785ad.79.2026.02.08.18.01.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:01:43 -0800 (PST)
Message-ID: <3da2f187-797c-4a03-a303-e005b6fd44f2@linaro.org>
Date: Mon, 9 Feb 2026 12:01:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/24] bsd-user: Add host_to_target_msqid_ds for
 msgctl(2)
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-12-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-12-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
> format for msgctl(2) IPC_STAT operations.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Brooks Davis<brooks@one-eyed-alien.net>
> Signed-off-by: Sean Bruno<sbruno@FreeBSD.org>
> Signed-off-by: Mikael Urankar<mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

