Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF4D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRlX-00056r-Va; Mon, 26 Jan 2026 13:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkRlW-000515-ES
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:56:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkRlV-0005u8-17
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:56:46 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so27474005ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769453803; x=1770058603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Qnak2elRa7p1nzTWNhnafzE7HR/2E7vDM6fxhERF5fk=;
 b=szwojgaPgIe+0hezi7NGmD6ByEn4fC+pg/Q5cLw01Km8A6+44XPKbHFsd9w6vx/0IZ
 LT0YxTCEH/urGn5Gh24ceKrrnMNcH/m7UBFWWV85/TB8DZkJxWmFukAqk3tqNbPNMAp+
 G15E5ReUJfSghdndibTGditvKifj7de8elEoJdyFZ40JFuHotS7iPx7larPUdFrXS1qe
 lS8PZhWDQmOm2nsUIoiZ7Q+Vzg0UBTl7tHEibvYltePo7V5zB1LEMMpm6u+iL5KaJJP+
 S6vkcyAAJdO9h5KyIXu7z7q6v6ZeCWwD6lk/5y+B92zRE+2qfZFZy+/0VnqsZBaDxAIg
 jw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769453803; x=1770058603;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qnak2elRa7p1nzTWNhnafzE7HR/2E7vDM6fxhERF5fk=;
 b=C/WQ2SA/SBaC9O02+oJFUSLK9KdYWSqTgqxvX3wH7TiJJEr5UHIbktlVLIBgInFD81
 XvUEPu3yJgQz8IJajHCCeR2gEEjCQ/9ogq6ecgOmJxUHiXTQONToIimqblxtNPABHSgj
 5A3y6MJRXBKtagDgjAvgUwfztuy52E7dgOLIHzvc0HnEu2Ie1XC3pb58jHW4qpGqhq3v
 RT5jweOm1Kf6ZgxJ8w+CjqLAStVufACAFUxrc9ssVlas6hlVafA1OMXP7R8sbRz9IQMJ
 wDUam8kVsjYMXBeC1FEYHH6lsvRuXalHxbAV/if5JC+58qMLuwW9SoBb6Qqa6sJqm4uk
 NyHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZEzsuuoM5cKtoC7Au+VtqpFAaRwijceVIE4wHdY/UzCZkdlKm0nmqQd2wNPpIzVba0zaCKxPRTYMG@nongnu.org
X-Gm-Message-State: AOJu0YzxU8p+8jdrUuVxicHDQog2pANh2wMJB04+muc6NpCQA/5yMY66
 wG/hX9M6bNd+9iwZ6mp2hTXWbd7ov+/5GB7gGIKEWl3DqTfDl0R02E6F5X7zPh74l1o=
X-Gm-Gg: AZuq6aJY6t1jCm7plAFhwV6AYiQQ/Hk3B6iba9W+923fR7PmP6Dx+hjc/IaAFt4scAd
 14KdRuvtpyG5xOMtx3bUVamDdrLk+S6+EHegy9a7KIz+4w2OZz1y+HxcCmoHXO8bFpc4LexR1ju
 pmcbPuuSEn3q/7GFrYE8UXGPTb6NBbXqdjVnKAA4tAhTqx4fsvSVgNyj1xZyKbk0UCTUi3zsIE7
 a+xU6PxZXeA57bjPlcBT0NWzeEX1PGoshcLJ7x0JIlNTVpzkM+fHP2Rqz1PBWcyiZS0nywmDeuo
 R/CEV03rQPMancPyoqlbhf+2BDHJq+vbIfDpQWYkJRq8jjSzHjfbJPLf/LafKrQTbN1vKayy7Gg
 K54/1qW280eUuw8TuIzx5jFO4LD6VSsTD0k0vab9x3JPT4CKsE/0vDERHnZRGPc/RbYBJRKv7Hh
 TSQ9lUN/+kdBkOvKrtFTr+3EtDTYJ1FFI/w803KqRaN72+ftiQS2Xvt08p
X-Received: by 2002:a17:903:1a85:b0:2a1:35df:2513 with SMTP id
 d9443c01a7336-2a8452254cemr59188975ad.17.1769453802742; 
 Mon, 26 Jan 2026 10:56:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fae502sm95532335ad.78.2026.01.26.10.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 10:56:42 -0800 (PST)
Message-ID: <bb30b2fb-6b74-4f46-8b6e-0e94622af2ea@linaro.org>
Date: Mon, 26 Jan 2026 10:56:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/16] MAINTAINERS: fix missing names
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260123145750.1200879-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/23/26 6:57 AM, Alex Bennée wrote:
> The form is Name <email> so lets fix that up before we enforce it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

