Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0970C531E1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgg-0007Wi-2V; Thu, 19 Feb 2026 16:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgH-0006x4-HZ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:31 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgA-0002VI-Aq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8230f2140beso1396335b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536921; x=1772141721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+UeQKSi2chgbDvFBfMkxear3KPCxDO6PGyTyAjXgZ9o=;
 b=Yl8r+1RBTvOxIaikNMBemuQYWpD41MLmv1dQgiZOHSZw3flfuEQWuLdZxeVqm14HX2
 n70902q1KrSi8NUW1kmaxEEGH7/ykVTpn4xvhK52f3Spw8vD0F60otMOTBsoJszs3wYw
 9K5RnIcJbGdqG+9PpOkiwtKJo8E1ZAOZK8KS6QIbP4/ptMufkJofwV4LiXogCIWdP8Jg
 qhcOBw/N1hZMyzbHA/ERC5YgwWCy9f3lPIUVXrO/4oYFtKk3GK4BOaCs4NCb063iU6+2
 NQalKHqHF4pVDAwGoCNnlAYASRA+YeX0y4ZhQSyilBPSwDioEIqQSUF3hKiXGweY+bpd
 zp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536921; x=1772141721;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UeQKSi2chgbDvFBfMkxear3KPCxDO6PGyTyAjXgZ9o=;
 b=aDIzqKKtTTf0tQXasSwN5JdEtu1DjKB4uFVGfCfUGKnm+DU6MpG010zgLQf2KXj+IG
 FSYGe32eIRa28qAiqf70v03vnoBAZKZtPxP5C2NSppI457RLRBKbM8iNEXjkL7YD5+Dp
 QuCUf56gsxYn5obBlD1rfCXh7Yg5U87nDp/a047t/trQn73KF6U1QRKFMFADNVYxVXQK
 nlJSsR2MUFxK/NZbhmBOYgxURTeUXIPi3F6O3yuY+DaxMezulTj6K9JO8RvslU3quECJ
 DkMllSBL4WUn5JKN/5PL6j6ODRdZJqGxVogWxpM+XE6ZZ4J/eTVH+RfPe0JFJxs9viN+
 ++Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/U8/wfB+coC4+GJ8KCRpr9AxlM/CcZAXeAli9bno9SzZSzx4icjWQ0PDvkxK2Wxy3I7vbSllQFt9w@nongnu.org
X-Gm-Message-State: AOJu0YxMDfdFtc0c9AAghB7UvWKSHfuGCAmnhnAfEcfxEdgvLIKJ05ur
 C02QMgbtGv9gunCgmc89lKv9n87R0O6ISJo9vRyT8GkOykNwHZf9WzW3vzkJKXhoc/0=
X-Gm-Gg: AZuq6aIQBt1XwW7sxe5/6oKN3ogqXMnI4ZJJAfvTbaPXMK44hsg9SrqG8RlLPs9834Z
 m+G8ur+wxhOi4agpi3o57s1B3xrjd6nxuBosXFfBZM01nirL2x3Jbwsgr8dydq4IEQszoDhOyi6
 OMP50c2rQnVU9JkRHIFSUng9NZy91KS04lkjyzfleHZyDyO4DnRyRgkQliYoHQz+1ioSAP9jcbn
 dQhxwOnjaR04p5KnXPMYb8gdKZyDloH0KDfgPIiPWduUzktqMbuxfnC/fEAdfpiL7LiYhJb7yhr
 E6iuECLfDoHO5kJEU0hQKTdKsnwmd6Vp55oEwZXoMPYEfYrrVDABVbZTrmuyrtDtM9/f4ph5zWy
 yjTe6rsPHcuzCr4yLPZLyK73NzVfFTCdPAFfvf71cAAMKfWn7I7+0yh9hkZdI2gJmyiDHtnMdMt
 JmYgc/KH9A05XtNDLh4YeE1OVtwzjMSZ4Pb4hjaeYHLAJoWopjJEVEvRwYCnBCDpBPrLgR
X-Received: by 2002:a17:90b:4cc7:b0:34c:718c:5448 with SMTP id
 98e67ed59e1d1-358984ea764mr2232906a91.4.1771536920717; 
 Thu, 19 Feb 2026 13:35:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358a19b242csm157049a91.0.2026.02.19.13.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:20 -0800 (PST)
Message-ID: <7404e03d-e88e-45e9-a0b6-4b18df0484ac@linaro.org>
Date: Thu, 19 Feb 2026 13:34:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/50] target/or1k: Rename 'openrisc' -> 'or1k' in
 meson.build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-42-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-42-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Follow commit 62822fc7e0f ("target/or1k: Rename from openrisc").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/or1k/meson.build | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

