Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38841C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq07l-0008OF-Po; Wed, 05 Mar 2025 20:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq07i-0008O1-C6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:34:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq07g-00071O-PU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:34:06 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224100e9a5cso1419605ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741224843; x=1741829643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RblFHSCqjHMP/WjqJeF6vZiBPgSR/TJFwijUWZfnJ60=;
 b=xcRrU3X7vOAyp+BvOrPdNqllXHwhg1XY2meKGDRdfCcZW6Vy6bFFCQefUKqEjwkGuq
 5cBf7rXuH+hUUL4bHJB3XElw8rwklsBITAk4ThSom8FmxEmnHz5SRK8uUmq8mgOKTdCC
 PKUVF40gayw/dYGf27jT1sF8jdIiumzghCq2/IPKHKDxg8iKePPDMcyXAxzzljSgC+Y5
 KdIIKOWA2DclcXSPhlA1z2nKiwlmRcAnKeJpoRW2ViOB9t/imwNlGglSsgcxAhcxWDUC
 nJ0JwmlfF74k5gM3X2WaoIkDTfIsJ4qHHAengW8quoYEYSJO7v8chgJ/gT5ertlaMoGl
 QUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741224843; x=1741829643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RblFHSCqjHMP/WjqJeF6vZiBPgSR/TJFwijUWZfnJ60=;
 b=bzR57iUrXi7T1hlfRmX7UEEQoyNv6jHbmjAcU9fwWKogjSY+gHXagTMsE3jDYDxg/q
 S9TMGQopMW60ZyVrs1zdFd+DqMZPaEutW0hqoZvQNxlQpFjR/XNl8bYyTu9EaNf9s8Nc
 xYdjyiRHQ4BFb1S9AJjM/+/gVMSPAh+7LpkZIqAxr7Z5ZD9n4DP0XYl+eOykuDYtt4nt
 kHcVeaj/q66jqqRxxvjOa5JhYWCxQEZY4V0dPEcvpE3BEMYYj/izjSrTLJqTqvVRt5YK
 fMYrZNhafCZajWemzZTEZKpzNwVG2nKjwrSMzeJLnyJ7Lm38kxnd2jMpEXkVO/+xjBv9
 9x1Q==
X-Gm-Message-State: AOJu0Yzqgm28zJcwB/CPojnCN2yVskTo1lQzatqdiwu++qLAFlGv3kA/
 PgPes3GdUnkLtMwTRd40SgKpU1nziLZ9rQUFwE7k1TawISp1smBmYkUpjlvCLzQ0ftUh/DsHvnM
 R
X-Gm-Gg: ASbGncsk3M0LTbLXI4k5DE7bL3LMz4dhNasshpKvP8E5uV6M4WSXlcU1hjb6GLJ4fFX
 08vTv8l9cqdKqKlTjHxXdT1RFgYL+0yBjD1z3lsYD+IIK0gnRM4dcVP/tvdbPq/PsB+tVBDAGJ4
 msVRaPC3r1skYe+G0eqUQ+VvKoTIBOALfJaZQv9OWfoF6DlUvq/3NTJ6ylcuE8DWPWC0g/ACKV2
 Ju/foeMEziIvlZq4yCpAbHUmg5A6UO+rLJ/zkFtlB9YGWUre8zR9hwnbMwbRGBcXYw+xg+6clf6
 pPvU15i0hNuayfK83a9dImZ6v7yEOyw6yLycBBouaWXhPGPYiMNGjM+v1+SHssxzqLvHKu7dVvK
 HxoQK15rv
X-Google-Smtp-Source: AGHT+IFCy/9TDl0C+oxxu1GFJ8jVXunlQfHAA96DQXZP2wyfD0UfbOUF05VL4aca6hGBhoHrBcxQig==
X-Received: by 2002:a17:903:8c4:b0:220:f91a:4650 with SMTP id
 d9443c01a7336-223f1c95712mr85895955ad.19.1741224843068; 
 Wed, 05 Mar 2025 17:34:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28109676esm111783a12.28.2025.03.05.17.34.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:34:02 -0800 (PST)
Message-ID: <5bcfffef-d125-4392-9825-81edb3a5acc8@linaro.org>
Date: Wed, 5 Mar 2025 17:34:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] qom: Introduce TypeInfo::registerable() callback
To: qemu-devel@nongnu.org
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305161248.54901-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/5/25 08:12, Philippe Mathieu-Daudé wrote:
> Introduce theTypeInfo::registerable() callback to allow
> runtime decision on whether register a QOM type or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qom/object.h | 1 +
>   qom/object.c         | 4 ++++
>   qom/trace-events     | 1 +
>   3 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

