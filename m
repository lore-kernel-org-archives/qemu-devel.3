Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C3DC98302
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgsdQ-0004GK-FN; Fri, 16 Jan 2026 17:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsdK-0004EW-6G
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:35 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsdH-0007sj-Mu
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:33 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso1504101b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768603770; x=1769208570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FdpCekvKZL83qWf+bMVR8A5GN7sZrhO6Z8RZXKo7LBU=;
 b=JW60uIVGKSsp98wzfuWEwRKTbrjAVnkk4XWrncvG8BMWEyNypGuoeoU4ezPWXmN/2f
 l4BnS5r3jcz2r28g6imCeJPEo++H0BwstB0Hk4BNLEDQVhDjdLt6Fr+QS1BePiM/KHwC
 pSvTUhLv4hzk3kwUfnJz76zLUfCWOkUcWoPta6aYsq95/BztumQm9cy3DoLVN7sodwBd
 ewSa8IGbN1Mj4g0Yx2wBAfxU5nZYOYZbKAIz+k56q6qWnfd/VNjExjNmNNze803Vi33D
 /zOrRGuZg/cTS9+vz50sP1LbjFdS2QDvOSckp5ZuFPubZsgJifca1ywxZ2sopJ20Y3ry
 UHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603770; x=1769208570;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FdpCekvKZL83qWf+bMVR8A5GN7sZrhO6Z8RZXKo7LBU=;
 b=GPPkmEPlchRoq1sFfUo+QNYJ4Jb8oguzz0WNkvMY/2lOaoRE12hYk4y1l9ffhpXwoM
 SiS72wcYKqajqkghyU00exeEqJuSti37RMxsjMg1WsvxF8HY9VoHrgYna6rMvVROUL+T
 Pk338kD07cTa6OEO566Gd1HHAm0FMSax/PdQHGouGyXBwc79/U5DkJPEjn2Z7i6vvbjL
 wReHPXJyoC5jp0fsPy59mmQgf0/C8mg5spsIHFCzW02oYgTJFgOj31Gdki34/Dq7Kzqi
 8+n++7vUk4klOfcUxfP+7DDUvWVQGTC5J2Zrj5vym+baKInV400MwgkEZd+8+0Eo7Wp0
 MGjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtcX7dk/Ghugeiq4Kj5X/3/TxaaMFJvbuxiEyJSQHPngg6CfEuX8K3P1RvNIFO82bMRX3u8DNvquhv@nongnu.org
X-Gm-Message-State: AOJu0Yx0R2ViIW9reY0JRn9A/rebn87YaaasXphyM9HEBWanH47S6Iq4
 jWLSI2sMMYTqJuXuymjEVsuB1aloY/m9d1Qe6UR8Wxz4LmMdpnzK3aAEVWeC9VIF+gU=
X-Gm-Gg: AY/fxX56MpJljM2I0bXp4sXE/I/d9m95kBs8pxX+gR5GC92sFHMjVwgyDLuKcx7Se+k
 x9+e/bDovruHAkR0sdqFYxQNMAdYMKcWNiBtR6j8AJQM0uLTv64B5LdMsu+w00Vz+bip3/rGb0L
 hepJrD4oRXfeUcWhlvhWOvlgDNLBfPu70XKn4GTZJjk9sOKUaLjc9jjkxMJ99xSAGLZqt6/tbvS
 xcu6SKyZYjUhKegim7sFPuXW4wBBlbmf5vkMiS5bVB76O1oUK+44mcOLlD7y07fguBg6qkBh7cW
 UPOIIUd9flSThUgBJikFGdyCPK7kCETxv3zSQtryZdQ49vddmwb2XblwrxIgBZtMO8MBZqLy8sQ
 jQNmukXkuMoJK1th5CPJoYN3IAW/uaMW6UsUB+oSZIyHRWuu9LHkzF90jUchPXmfVS7nIqjXT/P
 Dtk80oCjt4IeUC98uracy4TKE2fcAdulsbc/yR3w0CBphUVR4cy9WHn1Zl
X-Received: by 2002:a05:6a21:a34a:b0:35d:53dc:cb57 with SMTP id
 adf61e73a8af0-38dfe76d344mr4583788637.49.1768603770211; 
 Fri, 16 Jan 2026 14:49:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf354b3asm2836870a12.24.2026.01.16.14.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:49:29 -0800 (PST)
Message-ID: <7e8d19cb-723d-4d5c-821e-6ad25649c867@linaro.org>
Date: Fri, 16 Jan 2026 14:49:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/arm: Initialize AS 0 first
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
 <20260116185814.108560-2-gustavo.romero@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116185814.108560-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/16/26 10:58 AM, Gustavo Romero wrote:
> Move the initialization of AS of index 0 (ARMASIdx_NS) so it happens
> before the initialization of the other address spaces. This is purely a
> code organization change with no effect on behavior.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

