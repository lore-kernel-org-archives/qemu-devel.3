Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrBD-0002Zg-NS; Thu, 09 Jan 2025 06:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrB4-0002IM-EG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:58:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVrB1-0002iX-Rf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:58:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso8600205e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423890; x=1737028690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vkn8meHqj9uHYU4FyrKSESvarrmpdT2op10jKNSIb7A=;
 b=HItu42Snj4XHcW1YpdOXxw/ycyuqenacDXm5XiKeJvK45RLDlEdqivpSszoQttfchU
 ctlJVS+et0tccTMKiDcxwOBYnT1N07LXM/1vtPqy1jmJ9XgeHGLs/ain+O5tiqc7GgO1
 Gm62AcNPTPQ/1rln3XE8EymTNTX2w2QrJ8kVyd+d60wgnl46cO3gf5Ho7xdWFpDs22wa
 etlRmUlF2ozlkpCPjpdrnvVH7K2SzQJJBSbhCbZ1uh9sfzIHK0vmcrxCXmqaeLt9K9J4
 0U6eit3egPZU8MciUABbQm4diACIYtknIxkGp+IkHYZtn26ioYeZw2LrxDEtDV4hKWAp
 kWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423890; x=1737028690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vkn8meHqj9uHYU4FyrKSESvarrmpdT2op10jKNSIb7A=;
 b=Hi4GSSDWj6GAe57y+Hw9BVi26PHLsjsTUsQnLBQCsbBvoB0ee1HDgqQrXHZfVx+UxW
 wjuCN5rcfN26Pswbs6nY5PJhr17/b076vGw/p67/oQNm9B8Ml57D3Bzt18EpJRVjPDxH
 y9H/kQHAqkRs3FB3ZIFXU0FEby8w0jZprfGAY4cg472/fXJpmSG2R/GTcfu3pwj53TUD
 5QVnUwhJQelY2Gv0XoCM/rS+dNnobguUgdq7gqAhYRL98mmQ/PKJjdNmS8nq5b40/Omr
 vPBWzCVnzHYtddhffOAKYy/YeUVAOECYhuySteQxolDcz1oarWBwJe+oes11E5aqos7Y
 YPCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXKe032/bAOsrP2OpWmXqiAelvD03hNahaUlgSHvpddN8x7MU3nuT39WRKm9wGmmvhm/RVwU24MdJ@nongnu.org
X-Gm-Message-State: AOJu0YxlhgWZYPqE+ZrZKVsxg8pC4w1v0RlkfKJsds9E0h9ZXCeIRAfC
 ZuS+h4MoLvBPqAwqyEsaD5z9WYRxETty/Opr/P9dBE/ad2i5ARUH7+wEOWaZiGF5UQSrTWTbtdF
 0Yp4=
X-Gm-Gg: ASbGncsK4Y3f2rKjxUYcXmWsKk4flmPgkz+pXk2tvOG6jVj1f4GNF5ztrtEiQRyfuNa
 AVzjbiJS0TtVvwIQ1KcqYEqbshbgs/cUGbTTaMag9Kwi3zvg/N+HLIIfBgtz2VSY+QtTDH7gtuJ
 us5dRtVfLbjUn3JK/mbYQVd49DlwAx8/dvRJfpw7VkJeFa7WcFn04jcftVfIMVaaj0qhsv6XZH+
 FUlPwixE0CXjXxuELnbFQPhyJlHXGiL/UPXjhqlmfXjaml5B/1Y8ywllyy2gFazBo9Qy8d1eMkc
 4LWH2NpXyL+8CwT+FGdzgayg
X-Google-Smtp-Source: AGHT+IHz6Kb+DYm31eXUJa13mMMxtCmo3FM364BohACL7qGAPwxCkAt5AxBiXRCjtTXxSHcRokoDLQ==
X-Received: by 2002:a05:600c:6c0b:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-436e2707f07mr51274265e9.26.1736423890528; 
 Thu, 09 Jan 2025 03:58:10 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d447sm1625751f8f.4.2025.01.09.03.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:58:10 -0800 (PST)
Message-ID: <6c9107c9-e901-43e6-b737-a4152542846b@linaro.org>
Date: Thu, 9 Jan 2025 12:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] tests/qtest/libqos: Reuse TYPE_IMX_I2C define
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-12-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108092538.11474-12-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
>   tests/qtest/libqos/arm-imx25-pdk-machine.c | 5 +++--
>   tests/qtest/libqos/i2c-imx.c               | 4 ++--
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

