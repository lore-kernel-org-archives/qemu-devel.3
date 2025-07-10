Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA1DC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqXt-0005jW-4S; Thu, 10 Jul 2025 08:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZqXl-0005ip-Lo
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZqXe-0002DF-9P
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752151095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBbqLVbb4mMQBkscVz7ffuFQui58Mhk166fIk0k9BIs=;
 b=IswUxA6x3GGafaWMmjKT2aRpuA/XKt5m44p0H9sQkKR0FnnFWNlvC/FFwmq4vrcjaNM9nF
 iBLGagckqPb8Sw91yeLp8Y7z7uZ5oH1HyQ9rWVAWOZ2I7/7pQFp9l7qWcEZD5JGdOlge9d
 Zm/Y7JwzeonlgVwGXSkW0Iz/uw2z1iQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-BwMm9nAkPVumLcASeH4qVA-1; Thu, 10 Jul 2025 08:38:09 -0400
X-MC-Unique: BwMm9nAkPVumLcASeH4qVA-1
X-Mimecast-MFC-AGG-ID: BwMm9nAkPVumLcASeH4qVA_1752151088
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so7194325e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752151088; x=1752755888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WBbqLVbb4mMQBkscVz7ffuFQui58Mhk166fIk0k9BIs=;
 b=Vf4xu9+p+sOVys9l+BBQwAvD2c3E1iz7Ofyk4cBl7N/PvlrAJP85wgyMLzqZu0H2ZW
 UpY2smoqijnh5nuo58UM9PiXd9qyeiUt0fhVCSWc8ZJQGleVyZYdcLWr5Z9elk0rsG3z
 J7cgCZiKUXBaxaSmW1tgvJklF4IaWYfOW6+v/1dAlyDz6Evz5aU9n7LxZM4fHY+mkKWz
 NIFZI6MzEE/Jn8aXpQZAcABgYG3hR6fNjwKJoMKu/Q2Xv7LSTcjRqxueAwJOQiv+0hfM
 DVd+m2dGLkeZ7QDAMoZz0W+rTFqP0Gc4Z6OwpSzdMDAqysPPvQUMPputi+UJj6u8Rdak
 XrOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXaCj9pdgiShD/aU/MwF0KIbosAgB0nIEeSIm7ZWlctQMLjTVv1XwnXMN0ad7Xw0E15WvvQ5f33ssD@nongnu.org
X-Gm-Message-State: AOJu0YzZCUyFojRHnaueP0OnACxSUXl09NKUjVpeWjbEdM2g89Su8fti
 qKrT6CJBnQQZ6+sUH6uy2ilSlBMe+QbqtsnGJp+d1fQvcgWDcrTL8aEYnVubvVh1Do3oUtif9cN
 CNIHKIprJqjVbuKgwOfKBKImxo9Tbj8gImSXSXko7lmXvIeJU3v/wtdtr
X-Gm-Gg: ASbGnct8wlX1YFYgZw+Amr56nHFdNlYRuF3f54bS/FsswqHmcA2QNyhD5zNy1BCjOU9
 hrBk8N5GphD4nFX3DUZqIgMFVSVCQnKUST4Uxyl7t4KeEfDyG1heyva1NTfh/9yxDFXaV+SffxP
 FN/wdSLBpqeUIsAohbtRp3s2pw98+mcO8Si/EZUH9yMDrTXt7YMrzINTxGy1cONKV1N7X4cAkr5
 vi6t14F6QE+SnVcShfUdGtWyjQXzQkls3/lyZIIFinsVYipR4MY2EaUMZuUGrVcTPr9dWI9n9Qv
 hfnCS9tGeQtRaamRIBcAslVGaLU9W4vABSGi+sRanVZ9R7sj1RuCs9n+sSFayozluk4Czw==
X-Received: by 2002:a05:600c:3589:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-454dbeefab3mr30633005e9.3.1752151087794; 
 Thu, 10 Jul 2025 05:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/00WZJXz/sRbHElftGoi2dIKiBrkzchsACWbEj9ZL+4jUDNYpiDM0zrBC4MXTflKwEcnfUw==
X-Received: by 2002:a05:600c:3589:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-454dbeefab3mr30632595e9.3.1752151087343; 
 Thu, 10 Jul 2025 05:38:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43906dsm19204495e9.3.2025.07.10.05.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 05:38:06 -0700 (PDT)
Message-ID: <06350d07-7c4f-4ed9-abc1-a3d447a814f8@redhat.com>
Date: Thu, 10 Jul 2025 14:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com,
 hi@alyssa.is
References: <20250707164129.1167837-1-eric.auger@redhat.com>
 <CAFEAcA8UGHWLY-OpSZ2CP=LY7AynO_YxS27BzLadegL40VgNYA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8UGHWLY-OpSZ2CP=LY7AynO_YxS27BzLadegL40VgNYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/10/25 12:42 PM, Peter Maydell wrote:
> On Mon, 7 Jul 2025 at 17:41, Eric Auger <eric.auger@redhat.com> wrote:
>> This is candidate for 10.1.
>>
>> For gaining virt functionality in KVM accelerated L1, The host needs to
>> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
>> with: -machine virt,virtualization=on.
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v10.0.0-nv-v9
>> previous:
>> https://github.com/eauger/qemu/tree/v10.0.0-nv-v8
>
> Applied to target-arm.next, thanks. I'm going to squash in
> this change
>
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2248,8 +2248,13 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->virt && !(kvm_enabled() && kvm_arm_el2_supported()) &&
> -                     !tcg_enabled() && !qtest_enabled()) {
> +    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> +        error_report("mach-virt: host kernel KVM does not support providing "
> +                     "Virtualization extensions to the guest CPU");
> +        exit(1);
> +    }
> +
> +    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
>          error_report("mach-virt: %s does not support providing "
>                       "Virtualization extensions to the guest CPU",
>                       current_accel_name());
>
> so we can distinguish "QEMU doesn't support KVM EL2" from
> "QEMU supports it but the kernel does not".

Sure.

Thanks!

Eric
>
> -- PMM
>


