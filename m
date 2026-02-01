Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06771D172A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgbT-000191-BO; Sun, 01 Feb 2026 18:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgbQ-00016b-3R
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:36 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgbN-0007TW-MU
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43601e96f72so495444f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769987492; x=1770592292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IhT57lbT1XrzWbazZxkEnTkfOo+NYSNCrXJcD2VLp54=;
 b=JdQVNlfLAvI3lueIQnpqhN2JmmPtL4Xbtzkd4lOLil0e8737/MrhaJQOkwB4T71BnI
 0yXa/cuT+ZnTwtb9d6iNQ1EcczBMPcpusRBxCU9Vr5u6018W4Jq22+oHxrwrsNcHm3ls
 wM8iSoA+RzfwvkfJ9dA0FKQ+yVJGP9glInqtr7aM/yocy3vKJ/qn6rtGYNh88OjkM+x1
 HQJoW54FxPq6EWyQGCy/fAJ2hfPTEoGKJI0tsFbronbjY3pepJvC8Df46rPm6R+hGkXh
 w+ybCVfP4MOaEuBLB01qkdQ0lTeTwuceVxq/LB/wTb/9xBMcu5oSHZKoywXVKHFCnh/6
 3pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769987492; x=1770592292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IhT57lbT1XrzWbazZxkEnTkfOo+NYSNCrXJcD2VLp54=;
 b=NqBxRdyObvFzcXeHsQN7jNPl1nTvfnHOBCkglOrKqbv7giscKOi5CDSD3wuaHWaOmK
 oxSAhjfG19LCzbrYlUzBIZbvGjolC8TRxoCFqHDkx3xmw5leb51X2uLWmJdBvQh8z36b
 rx4zWQjZkvGgvNlgisWCLfP4I50zGzw+MH1T9Uc2aaYo+cOujr+JwoehgxjwUVYUWVsd
 Aioe8lwNcrQNVjr0wKOoCrKcbxjoNdsY5AbQJQoV2TYVQV7zJ10pY9K4a2xm280zf+W9
 6AD958Ss5sdwl/jYP5wOYmwPKMp9bG0KJPi7ErIUhske1zKmCcrfftPefbfeo5+f9VDD
 t0Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXg0U2XSn+gWbIQb7cY2Ci/QQRpSFVnAgccC3E62pMx3YQkOkTPUz2+JRJ5d6H1HvQt3wABNWGABd9@nongnu.org
X-Gm-Message-State: AOJu0YwniMPYK6RcpoNohbQv2q0pXZgU8gmM1BqVMcU2rrn+zJpY4bHZ
 S06uRG9jeAt6s4vV1m0KE37yJoYDFYBFkjxmpFYVQLB4ZMhtz6ZYoxyxzP5MKaWCYz0=
X-Gm-Gg: AZuq6aJBOmyNAar3bxBxcrwJ5QQqer6JfU5XKIFHZyW7AOER8gAZF3XVmmbBIM7cOa0
 o+ieW+JIEtSHRp2atQZGUzqTcZWTIrCwgz5p22gSmlFu7dYUtUas9ZKo5K/mmI/t6GLceKHw3UQ
 dqmaYRsok9tNjwB3cnX7ONiG/xBM5JHW1ZAL/WGiIxr3VV5zeMsc/X5+vQwCI1n0eEnEPWBaXtn
 B78iRQ02JwFbI9VyTOO1+kg5y/pELFMN0u1Ye5F6wGM1F7v9mPj2ilJQsEypUD47gc0NLQHfEM/
 GfruAZ82z32vily8zWR4D+N8+RkKWgSfe5voArZ2sktJQgIQ1QmpNWCaIG85gf02Nel1Ltl4j9P
 uevsVgF1iqSXdZOOGtO/rhO8mJ+be5V4wdOmI+qG0suz5YpzO0xIp8OIS7r375GSZirWbjOExwS
 /fUSHRz/Hx6kSFXrlRi/9gZfotzmGZBeNBheJWQLvVi7hM12s7IGGmhw==
X-Received: by 2002:a05:6000:1acc:b0:435:e451:2f93 with SMTP id
 ffacd0b85a97d-435f3ab4f75mr13383401f8f.60.1769987492103; 
 Sun, 01 Feb 2026 15:11:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm41333353f8f.40.2026.02.01.15.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:11:31 -0800 (PST)
Message-ID: <f6f43ce1-7a29-4a28-a4cb-0358b485fcd7@linaro.org>
Date: Mon, 2 Feb 2026 00:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/virtio/vhost-user: make compilation unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131020100.1115203-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 31/1/26 03:00, Pierrick Bouvier wrote:
> PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
> instead of 512).
> 
> vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
> define stack allocated buffers. To avoid changing all functions to use
> heap allocated buffers, we keep this max, and simply add a
> target_base_ppc() conditional for the single place where size really
> matters.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/virtio/vhost-user.c | 11 ++++-------
>   hw/virtio/meson.build  |  3 +--
>   2 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

