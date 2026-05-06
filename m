Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF04CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZqU-0005Re-Go; Wed, 06 May 2026 06:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZqQ-0005NU-R1
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:51:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZqP-00013O-DD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:51:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso3917924f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778064668; x=1778669468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/UjSI5vuYiaHQb+Pi15RhrwHdbWwUruD2NMsA8uwOPM=;
 b=or5RhwGBxQOXIRJ3QGb2ypgZbb3nFqYtXRJwK5R6ct1G6E8n/ny7yFNF3i+UaPMbzy
 hIuEJPZP9SuUiLR2f4Uf9V3tjaRMbvES1F7U0tbj/qaYyaEpWpiJYwefZHWKzv8hkd7I
 dq5upOwmRRhUhIVYfKNFzsaeZ493FLRlB85BYUxrAaFbTEq8T3Y1QiBo3YgZRJ9loB9I
 cwDhDZ0AjJcHSmdq2rUK5tTKSk/28H3bY+K4rKR6+dgJv2EyP7hvkb2xVWVxxUmUvOkJ
 084EPGu+Lcjk6F1H9lmwrTjq9bjQeF6++OwiEnJcNfyDzYDpi3Rp2bQuokOu+3OaDuk2
 kxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064668; x=1778669468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/UjSI5vuYiaHQb+Pi15RhrwHdbWwUruD2NMsA8uwOPM=;
 b=Of2YRzbcRTdbKLo4vuksDW8KRy9yeYmeJWXwXBEbCoyKD2lsVb60FI2xV4lofXEb6s
 OFRa9bsGp/dVIr8Z+CFOLZI6W8xynnBsDR9CKWRDxKr0goTdnNr6l0ssKcvKRQURqWOy
 ErdZDhBiwTt06Uo3WZt1/V5Oz8X1e+5b7Da5Q+5aqOxQClAQCHMml+JGzQync97cx4LB
 hzkjBwA7eneQuL0+DOzHeqPsv5QY9GCtdMNKWqfTbVrhdR0Z79s7WqUGWBSPP7UWSqQb
 wAn3PpLgQATsQlSZcOJiS1B7+W7DomopIIfv+JWxp7KunBWXGy6+yNM/n0wZ6wYEmRrv
 xzcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EJw21dH82uDQfTO5iC4tvQuKqoCSIr9Ig3LbqdTf4Z3n47guCxnQQQKtmmPHFHxEMoSem5Q0Z4Ovr@nongnu.org
X-Gm-Message-State: AOJu0Yy/cH/eaOrO3dRE+3bdajPk4TKjlsmpfJYgVn+W9hdV5I9bRoWn
 4C2zKs5khrmGlBesihMpz4PE/Oe5PIrd+fxP9OHf2Ow16fUcn4r13aUjSEyWZQBvj+I=
X-Gm-Gg: AeBDievFt/OQMxnuMjv3z38eHsJNLSaaGynireuvfTTPKIj84R+2H1Mq71obJYN5yxG
 CWyJlhz3z1gzLoKuvGIb6YB5E7v3BHyH8DDLQDTLr8RHz5ucuyPYNESBxEEhUCi70Du/FsBrMq0
 aySt05Lcz0xBIefc0Cg9e3wpS8zcF5AHrK53+HB4yFQo8lgugzf0O51WVy8HzRUuReT8pYaVjKu
 D7iiymWWf96DfEUpTkXQ1kH5W5zUr+F9HsNUtbgyzz2UBJICkTs8N/l9WiAMAa67Nxo8yl5CQjv
 SrOBVSCvec90GB8leIwFi2/VNYucntNra/+qupONb/vV1O+A1gaEhlnNsNaGLKmWJh7Es8TK2yy
 x75cfF5DVJNrfNqsiqqTEQHFpBrxdvhAw604KC2JtruJb1VqJUoyWNg1/5WlJq/wwnaMd4INNiZ
 p/5qF08Qp6ZyGAfWJ//6SC6PUdGmNsaz+IZeuPJPpgL6/eWoFSZ8YAW47iZnJxD8Fq9j0x0Psbx
 rx57UtqNPTRGHY=
X-Received: by 2002:a05:6000:2509:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-4515aa98164mr5386542f8f.10.1778064667834; 
 Wed, 06 May 2026 03:51:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960aa2sm11184572f8f.29.2026.05.06.03.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 03:51:07 -0700 (PDT)
Message-ID: <44fc92b9-3790-4e00-b71e-2fcc89f88821@linaro.org>
Date: Wed, 6 May 2026 12:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/mips: Move non-shallow-copy fields out of env
 to fix leaks
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317175031.3035740-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 17/3/26 18:50, Peter Maydell wrote:

> Peter Maydell (3):
>    target/mips: Move 'mvp' field from CPUMIPSState to MIPSCPU
>    target/mips: Free mvp in unrealize
>    target/mips: Move count_clock to MIPSCPU struct

Series queued, thanks.

