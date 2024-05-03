Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE26C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nRB-0006O4-23; Fri, 03 May 2024 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2nR9-0006NG-3B
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s2nR7-0003cq-AY
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714721668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rk9NwLqhptBbs5LMCM6Dvey2qy8q9kcKuH9uUONcBAM=;
 b=CMV8j2yy9Sdmb+VD/81t2q5EipO1a2yuOmwK61HVQudHGs8aCA1x7qT36KYxDCR5pSowTc
 nDW2U55ru4KPkkQRo75ZwyPAlaUXaL4l6y6WtuMcTIwIJL3VHW6FElgeywsk0I/8oYDmt0
 prJwK81JJTTw3TE6NMRrbtNRiYyxF/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-0EMol64EOja7ARGopow78g-1; Fri, 03 May 2024 03:34:27 -0400
X-MC-Unique: 0EMol64EOja7ARGopow78g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0e7d77b41so43682856d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721666; x=1715326466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk9NwLqhptBbs5LMCM6Dvey2qy8q9kcKuH9uUONcBAM=;
 b=rAKZMoILGpY76iC/CyeNrE+XVXTLh1nGdiyrkvURuvcOh2DIKC9FACFxlQXfljRvIS
 vXa/m5KAbCG9j9VT02DBxIrv1WI8Pe5Q9dviT07xPsQjgN0A2zre/hJZnsbZA5FW5O3d
 BSwpfxsTBdp07wkSE3GVfUpkEZhtxUKLRDUWgrGNDSiZi6VHRfZ1u+q2EIhISpN3LhmW
 qomfBdAgiDDTiqgnQLFIcROujHZjM0XL5qVHmoOasOE3MuV+8rGkzyTP0M1i1HaBQOZ9
 I2bxxb8C1+eQGnXocXfJfJmbgi8wW7Pb0eqOhrB6X1N6fQNL9qav+ABrRjVqLq/cs5rr
 EhIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeczf1CmD1YnoyKqxSDvBsMVW6j1HJXyUGol0w0D+k1ObAd4JPf665340ByyWx/dVpmFH519yXYauD4Hok8BWa8fm2aq8=
X-Gm-Message-State: AOJu0YxPS6G4eOYxQLl0lXMjrm7SCL5ARh8rMmTQswMWe+YIZUS1JH7N
 JEc9HtvJVt02ndchZDHF3Ht/81Vz6wGabXQaWebT3jnrw3ExxmoJSj6sc9IIDiWuCjB8WvCtshY
 BBnUINU7dgzxBBJCNdUs8KWcEY1QKIoE27Sokg11RFvuLHo3uoRPr
X-Received: by 2002:a05:6214:da8:b0:6a0:cd1b:9f9f with SMTP id
 h8-20020a0562140da800b006a0cd1b9f9fmr1797551qvh.38.1714721666358; 
 Fri, 03 May 2024 00:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+aZCtBujiigFa5MmzKUnngGtivyDghsbV0zHSpSYil3kIzKsMXJY+ldpkFwuAKih//0SvQ==
X-Received: by 2002:a05:6214:da8:b0:6a0:cd1b:9f9f with SMTP id
 h8-20020a0562140da800b006a0cd1b9f9fmr1797538qvh.38.1714721665986; 
 Fri, 03 May 2024 00:34:25 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 mm21-20020a0562145e9500b006a0f3704be0sm999989qvb.49.2024.05.03.00.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:34:25 -0700 (PDT)
Message-ID: <b5763eba-a713-4857-b1ff-7901589bf443@redhat.com>
Date: Fri, 3 May 2024 09:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Re-enable riscv64-debian-cross-container (debian
 riscv64 is finally usable again!)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240503071634.841103-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240503071634.841103-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/05/2024 09.16, Michael Tokarev wrote:
> Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
> This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
> 
> riscv64 in debian has been non-functioning for almost a year, after the
> architecture has been promoted to release architecture and all binary
> packages started to be re-built, making the port not multi-arch-co-installable
> for a long time (in debian, multi-arch packages must be of the same version,
> but when a package is rebuilt on one architecture it gets a version bump too).
> Later on, debiah had a long time64_t transition which made sid unusable for
> quite some time too.  Both such events happens in debian very rarely (like,
> once in 10 years or so - for example, previous big transition like that was
> libc5 => libc6 transition).  Now both of these are finished (where qemu is
> concerned anyway).
> 
> Hopefully debian unstable wont be very unstable.  At the very least it is
> better to have sporadic CI failures here than no riscv64 coverage at all.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v2: drop a TODO comment which turned out to be confused, replacing it
>   with the description why debian riscv64 were unusable.
> 
>   .gitlab-ci.d/container-cross.yml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index e3103940a0..dbffed3f21 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -77,7 +77,6 @@ riscv64-debian-cross-container:
>     allow_failure: true
>     variables:
>       NAME: debian-riscv64-cross
> -    QEMU_JOB_OPTIONAL: 1

Reviewed-by: Thomas Huth <thuth@redhat.com>



