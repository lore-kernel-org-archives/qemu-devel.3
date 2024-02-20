Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD91C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVuR-0000eG-QA; Tue, 20 Feb 2024 14:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVuQ-0000ds-11
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:36:06 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVuN-0008Gy-RD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:36:05 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso3277011a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457762; x=1709062562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zkKt7D7GH6pVL0Qn3TZi0jnWR8nK96PdBDRPxNEAKyg=;
 b=CknCaFsdnrI6sSlbK3KfGc/OjZ+l5OV5JDQS4tg/GmYN1RTF1zSVKCruBOu6gZ25Vi
 SpGdmikDUf0aRgwHOo6TJK76y8/7UAwpzHh1/om0PqTnBIW3xU3niEceEZbwfle0zrB2
 HXoEsXaidEjQ/tzjsS972gT+nGHhLmRKjP6aPo2QmSciG9Lbiuouu265VBPsf/rOiyCh
 w/8VdPihihP4Zi18XJlU8yR2nHNkONKqT3Cw8EXUv/48ojqNdNHxCDeJgXCjkRsQGcOu
 avidO7u4XH3aZrFQpXzbBRAyQ+HKbhXyGYh2Z2r6p5KmBmVVYvs0gfcuHmkIL0oFHC02
 zzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457762; x=1709062562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zkKt7D7GH6pVL0Qn3TZi0jnWR8nK96PdBDRPxNEAKyg=;
 b=QGOqP5ItdXHRK2XGZOy6uTs4NeiWhH1HkObppIHjh6EJATLm7Ls7wCbwxKh0I2xwiq
 S4R5meDj6gO3RKz4uRF9jXdygiWzFgtPq4hDLrIFSQHjRe0+tBNk7YfZpH/wcv+99wnW
 KYCMFNpZDKzAGPiQFpaMlNiKVu2SmI5rQRaIap9+EQAZYs9oRzsrKhdqgscDQOaBheqG
 2gWOB619r8RBoIskvk/lwydx2xsEGzZ3hs3bhYSJWvUhEdrzWuNT+bat86oTptGzV1R9
 s2M5nmUnf8h3Y+91ElAsfZVJbfbnuDNs0lDDEt35/FXvGEUwe8TTYqfLZzWRJOV4s9QU
 3jTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKOiumdDpvOL2L16e0PvsW/P4FCm8e/U3DC2CHJ3U3fcLI8t/nDykYpSOqKgpvjFgTEv7SDzeujp+K3EVOQzFkx7Dk7E=
X-Gm-Message-State: AOJu0YxhuJK4uHMjlJVjZD1hkAOLbCx+2FKBvexlS+Jyd2z/+ZLnP5e/
 JJsWIy4PMWnRXjeNREBxOeziTC2tUbTsQqEB7+U2ZCIqQkCKEWbEStnWu1FNXmA=
X-Google-Smtp-Source: AGHT+IG16uGwmcPUMLdgtx/iIA1A/raMj0t0E85dh2xQoYrXAUH0koqXh3nBzHXqi3fs87EE2dg3wg==
X-Received: by 2002:a05:6a20:2156:b0:19a:508a:7f70 with SMTP id
 z22-20020a056a20215600b0019a508a7f70mr11330157pzz.30.1708457762289; 
 Tue, 20 Feb 2024 11:36:02 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa79d02000000b006e37814cb11sm6403216pfp.4.2024.02.20.11.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:36:01 -0800 (PST)
Message-ID: <b4c87865-5017-4e98-9df3-366df0ff6352@linaro.org>
Date: Tue, 20 Feb 2024 09:35:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] system/bootdevice: Don't unregister reset handler
 in restore_boot_order()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/24 06:06, Peter Maydell wrote:
> Currently the qemu_register_reset() API permits the reset handler functions
> registered with it to remove themselves from within the callback function.
> This is fine with our current implementation, but is a bit odd, because
> generally reset is supposed to be idempotent, and doesn't fit well in a
> three-phase-reset world where a resettable object will get multiple
> callbacks as the system is reset.
> 
> We now have only one user of qemu_register_reset() which makes use of
> the ability to unregister itself within the callback:
> restore_boot_order().  We want to change our implementation of
> qemu_register_reset() to something where it would be awkward to
> maintain the "can self-unregister" feature.  Rather than making that
> reimplementation complicated, change restore_boot_order() so that it
> doesn't unregister itself but instead returns doing nothing for any
> calls after it has done the "restore the boot order" work.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> It would be nicer not to use reset at all, especially since I'm not
> a fan of conflating "system is reset" with "system boots", but I
> didn't have a good idea for how to do that.
> ---
>   system/bootdevice.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

