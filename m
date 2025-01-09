Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C7CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqxn-000630-HB; Thu, 09 Jan 2025 06:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqxb-00060e-Si
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:44:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqxa-0000Zs-16
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:44:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361c705434so6461775e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423060; x=1737027860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dPTeGJrbX9baIFiTLk3WzwlPQ1HlrZdbxq7RBAH93g=;
 b=CTy7MYShEhZyJ+p2mrqr2rIW8v7Pmj4Av9ixJ9VstcOXTbJVe6GSlzxLSS5E8dAdgJ
 +Rr9Y5qs/3SCEiE2haGxaf/uAxzyxbZc/vXoO7N5CLbGbunW5nmuvoOROTlWd1mELppv
 VPScD+pTdV1vspzPS5eUMnCrINtspfcWhMKbxRe7m8T9EpAlU2D+3gsVCcTgoSAyIptQ
 lprec1S9YmEIg8K5Dluq3BS+TQqY8nRjILWLKX2QqzVTrdxe28Yfx2UQJhYlyA0DMQ07
 hz/0rtmaUTv5ppOE9TQ+xHbtBLgB+BafqkjDDsLi214F9rr2JHRG1L4XQg+T8kfOsrQt
 GfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423060; x=1737027860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dPTeGJrbX9baIFiTLk3WzwlPQ1HlrZdbxq7RBAH93g=;
 b=YAth3F3DAwxncdb9BewpdauSmKXWj7rVRjtCOH1MB2mdraENmpCBz/h3NVs+u3dVCM
 5IgopHqf3Z9BcD9E5gH3U35/LIpUtHYkI1uZBFq6iFQo5Q6bYiOapjilhLS+W68YXcPs
 BXhZf9GgB67CqZ4dVJrhcls6Gfbn1OxD+GMorYoiFbz/lgLh1EM1NUNrOsANdLUkqJuO
 JUlRQu5cKaf6h6v/VfAC987k5oTJONbJHocvQrK+6nHEdFrCgOXgzsfATv17K8OCOt/M
 +5NIv7Yg8ng4CE60s/bv8PJBYzAmoIhT2QvpiRJeshfkcE5g84RWaWkVyVkIjQsy1XHn
 PXXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgy7VanGQCl7KpuKTtPtUHHbU3QENowzzlWtP9jxkx2JpNbLpzPeKmxsHPpbcN7W+L2v4/p6e0qMAS@nongnu.org
X-Gm-Message-State: AOJu0YxIBIwQetaZH3NZ+QC4rjP7VCSN9UyxrOMjsne0EIPYkMY2v5oL
 51CyiBZT3hsJ2Y0YrBflab2dem9Ko4W+9piLKC44XSRlxioykWTPTnsAq1xlngs=
X-Gm-Gg: ASbGncu4e/D94l26zriBJuOR8Ag7akjSUzb+WrGsnzIy9MQNGcsHzjLstRI2HVEqBSj
 1IPbSmmF2IQRQzLu8Gm+VvFW6xFR4f5vfJwHH/ISrKK26RpUYk0H8dLECTka5O8tKhK02+cAC7X
 yLyPY3uToGIwLAfnaYXxfJt5i8VWBAaFzJlmNFX4xmncJ6EuwC6FaVOaSrUorD+6W3mHZWbautW
 +6J8YlYw8IhW/IBty+xt7B1ntlPF5+pEJCqkijwg2FmMJa6/HGD1RYamTBApqoIyPOiLv3Z7M97
 TEk0nWQYkqL3RG8waJOwP38y
X-Google-Smtp-Source: AGHT+IGA1ymTS47jrnmdnBPh4xO/ob6V1OKlaCqB3/0jI5LzAjMg5LP2VOj/VHx1pexFDwUiXV1Tig==
X-Received: by 2002:a05:6000:156b:b0:38a:8d4c:aad3 with SMTP id
 ffacd0b85a97d-38a8d4cac18mr1575841f8f.18.1736423060288; 
 Thu, 09 Jan 2025 03:44:20 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f49sm18017905e9.19.2025.01.09.03.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:44:19 -0800 (PST)
Message-ID: <5af52807-4e08-419e-bc61-93c5823c3297@linaro.org>
Date: Thu, 9 Jan 2025 12:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/misc/imx6_src: Convert DPRINTF() to trace events
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-14-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-14-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 8/1/25 10:25, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/misc/imx6_src.c   | 23 +++++------------------
>   hw/misc/trace-events |  6 ++++++
>   2 files changed, 11 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

