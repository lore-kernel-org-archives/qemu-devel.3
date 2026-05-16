Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3F6CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 09:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOBjz-00020T-Tk; Sat, 16 May 2026 05:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOBjf-0001t3-Ck
 for qemu-devel@nongnu.org; Sat, 16 May 2026 05:55:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOBjd-0003G8-C4
 for qemu-devel@nongnu.org; Sat, 16 May 2026 05:55:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso4023635e9.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778925302; x=1779530102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxNJhiQMcg7arUM+FqlXp1bg5lbqPVyHjkb/vQT3h+I=;
 b=mpwsq1R6zr31BW50Xv6Yt2d6x+TNw5gZWqt/qcF8hx8tv8ONj3ViBucsw8m8eYJEVg
 eke7FNV0bsV05uMwPLPgKZIxXIiF7mJq9FgV95zHTN9BhSDzXCXJIhwsXNd8epvN5pwm
 NN7itQmiY3NDnBUCWL5lN1xbKj/YGbpq82GWMOLIlpRYyqSj5Gx4DAEtKfAgnf6cpYHX
 mBeGo0pdK6FLcx1fHCKjlKTQzEN1KUSQort213ttW5GBnonBZyRFEr4yg9f0cI4ISP7T
 pUjaIXQQVIBjIPKmmTA7qYYTJrRmsLMK6v8lPXgOhlXKf5UWw6RuZz7Ko25DwG64rPiU
 7CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778925302; x=1779530102;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxNJhiQMcg7arUM+FqlXp1bg5lbqPVyHjkb/vQT3h+I=;
 b=qWG6uVLFAN9bsFMcr1ERWwScOd54t2wBGlF4GT/X/YJAQK9LhR7kd3XTYzqqBZPDfz
 E4RCANA148VgXGdAXP57vpIQbPRozbzDpGgQ0me/MOhqhPAUIK6zffwsTY+ZYpBTkHra
 lDkZUSmA/iKrqriPK/CooyE5y9hVfzRff+I7r5K09rlh+TJRg/CA7MPMkuttZf8wGWb1
 W481V/vMMuhnE8VB8Zr4kj+3E5s7c55ncGc/Fo5EcqXpSclRO4kRy5Z/Pbp2Kp0fDpZk
 +j4vZD/aEG8r8wR9v2c2E/UqqPgSPH4+rzqy/bU/tDcTWFrU70OR5jfX3ruRPl6/tCog
 voRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WPRWIl7HkJq2rQez4TJF+Qd0WwN1d+1m86dWxxUBI1cCZZLPOkMrdtDy+/5kdEl6x6sR4jZaRrdXY@nongnu.org
X-Gm-Message-State: AOJu0YxUXsS+iLOVH+G8dwQskscfzET0PkwE+jcnctXgTJh1lWHyKDlX
 40YeSDgCicn81F7oY+ms03IHkdZCMVHQ1l+GG3UI3FwSeo5FZYVDj+hiKAR70yzjbww=
X-Gm-Gg: Acq92OGhmA2sQIXOws882RSvzc4fYQQjrJrt/0e/NyNBMRuNxBRy6J2V0kJ6hAVOBnu
 4g+dhK6fzG2CtPUyqyLPt/y1/OMJVBBXWHn6FE6u7GpA9seFwUGcrXmodAZXu5mciAZ5hdgHD3S
 iO+DsrD7geI1B9/gkVruqPWLMeLkhHh47MpBEiaWejtZ1Z9Cwr4TlunBLE2WnqkKlvopF9G+HsN
 Ds4KAiWvMLZIGwTmm4qQVscJ9DrikSq1GhXCM5KunyV/4PuMsQjRTZW+n4S4orxkjBT/RRWIQrp
 AaqNq/qFDQxT5OwVsoMlg7ku9rFf9GLBKX267zScI2mOZeoeSypqlRAEW8/DUiHJMhqXexNaToT
 DlfvgRIDe3kzuIjJsRBjuu6mGNdpDhppQTkXFZNDHT1CF2BHNm+GmG/biDhHKLpkqnAP0vWGo7Y
 V9J2+3ARME/7RBm5+nLH0MVA00WI/H8sMhVclQw3IjWVzdAntoKtwqmFACU8BUMiEiSg==
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id
 5b1f17b1804b1-48fe632374fmr112059745e9.20.1778925302005; 
 Sat, 16 May 2026 02:55:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537720esm134149845e9.9.2026.05.16.02.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 02:55:01 -0700 (PDT)
Message-ID: <96eb5cd8-c932-4f65-ab64-8a836f7ddbeb@linaro.org>
Date: Sat, 16 May 2026 11:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix doubled-word typos in user documentation
To: Clinton Phillips <clintdotphillips@gmail.com>, qemu-devel@nongnu.org
References: <20260516005558.92136-1-clintdotphillips@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260516005558.92136-1-clintdotphillips@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/5/26 02:55, Clinton Phillips wrote:
> - docs/devel/style.rst: "assume that that type" -> "assume that type"
> - docs/system/arm/aspeed.rst: "how to to boot" -> "how to boot"
> - docs/system/devices/can.rst: "supported by by drivers" -> "supported by drivers"
> 
> Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
> ---
>   docs/devel/style.rst        | 2 +-
>   docs/system/arm/aspeed.rst  | 2 +-
>   docs/system/devices/can.rst | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

