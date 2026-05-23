Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4D1CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQl9h-0007sc-Lq; Sat, 23 May 2026 08:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl9f-0007sM-Vx
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:08:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQl9e-0003Qr-FZ
 for qemu-devel@nongnu.org; Sat, 23 May 2026 08:08:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so7830836f8f.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779538112; x=1780142912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HgeB1sVK1hGoZt+y/dgm7PUxj3bktAgARGILc58Myn0=;
 b=hxzMI4MNwPuUdIJ/4w4dqixI+kfSAWMk0hVdBHxsFlb8gPTWFzkA0E7mR6UYW32jGl
 Niv2v66KtsTwn5E1UQWMdHHbdo2DJAPmuHgYKOKYJ/VwfNu72di6+FEPe/dTaWRLSY0/
 jmL+i7pK7okOl1z2LMAnDGTOM9miopVvf8QQC1YIISF6P54QnrB2PNrlz99noxRRBerN
 ppcqmSlZrQWEPyW8tYWX+7wVFhbCtky8PkEJZDaodCSkmHUwbem7pwvhtukwGAJU2nMK
 0XE87/b7rAHVYhuGIJ8fxpCRoZfwPV4G3UDyIkA30ddRd5HPbEiQnFBU5t639WY1Fn02
 u1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779538112; x=1780142912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgeB1sVK1hGoZt+y/dgm7PUxj3bktAgARGILc58Myn0=;
 b=czjN5uiz1NqMBEjux6xhWD7ZMVezdw/PdUJnfw0Ayr/llEIMNpdn8asLyfO2s0xayn
 +nCmPYYTedaqBlguUo1L7Tb9Up/meNRplqxy4O6yRM+L00HAPAaBhn/vbZ70G7gHLJId
 5JAWPqW/LwsOZXKGrBBhvmCqajgxn8sbh26gHoeqeNcZbjXZFe+xJklOGWwCf34UwsmG
 M/Hj+SN7tH0JyfWqIJHAXdOkpIan6d2bi85fT9UuqZ6qmXx6UiUkWFlQhgoewKaqXl7N
 yWm/Wj/d4KlmNCLOQnqvSH8gOdTzuQqb16noFmgECXHCyy5EfhZ/v8hxaSSoAX7/Eyww
 lcPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/j1PIeZ3HriuJ5mEFPtMJ7L2E8jO1bs5qW/N0dwSR4c1ZSaTKv7/vJLWUBEX0LrBMTz44whiV03Z+l@nongnu.org
X-Gm-Message-State: AOJu0Yy/Md5lAKl5i7FeIIRPggzJNvAQXTM8Ieu66BQf3NCF5hW/Gfm+
 BuBsXkVeYdLRaYkG+sktGgO8tDzlYCuFlG5nzasdXHHXx5NeD7CtmZmj+dfUgEezCPw=
X-Gm-Gg: Acq92OH5sRRb5MfyY+ZePIY0NZ6FvHCLe7eumePezzRfmL3CIPz3zPU3Oc46/CBDPcO
 o+5V8nYpUjfJ9ugy092FDWpndSrfOzMSSfMRGaM6lyyuhQloXAlRCD1YuCAw4bK6beSYyCC62ra
 69W0Jr8i4z/S7e0sElueC/52LsLduTcItdnBY/zD2GtBuAm+T43hNlHrhMwLtHMO7o8utDrimYz
 vrshHYi4RPyudyxHIauCJhG/V2blqFgRFb/CHZnCPZhOS3g8ERPzaztYzIbTEklmEwVBWiOjmmG
 hzNKSIXjRZ6YX1gD+LN7BgYV9PMusDTPC76hEq9shf1+S0KHC96V3/TEDQzSYgBZkGcs+bR9f2t
 A586z+dmR6hKl2d06hF0842n+MIQR34+3FiTSsR7qoi1LpQ8vHREkNsTt3YCGpM4r5NN8tvEdsP
 5KLlETd2H3fSjMJ4+rNvHlX+U9u9k5tR3OiJyP9Hi8TtAHAcvvjvPF/6vRZ0lRXmOwmqj0r6Uoa
 tw=
X-Received: by 2002:a05:6000:2688:b0:452:712a:91e with SMTP id
 ffacd0b85a97d-45eb3670343mr13617107f8f.2.1779538111809; 
 Sat, 23 May 2026 05:08:31 -0700 (PDT)
Received: from [192.168.1.117] (88-180-58-130.subs.proxad.net. [88.180.58.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5ed84sm11509390f8f.31.2026.05.23.05.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 05:08:31 -0700 (PDT)
Message-ID: <a8afacb0-e7d0-41c0-bc68-c86cf9401af2@linaro.org>
Date: Sat, 23 May 2026 14:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/39] MAINTAINERS: Fix F: typo in "pcf8574"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-27-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521080511.999266-27-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 21/5/26 10:04, Markus Armbruster wrote:
> Fixes: 4cbb1513a2 (hw/gpio: introduce pcf8574 driver, 2024-03-11)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

