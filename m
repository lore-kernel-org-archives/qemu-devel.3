Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88806C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQkc-0005ew-27; Fri, 26 Jan 2024 13:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rTQka-0005dd-IH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rTQkZ-0003TS-6H
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706292982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNG6H+3tybJ100+FQ7ifNQULqIkXKOGQRCmck6q+baY=;
 b=EN5YMU4liAN0i06vXq3uft96OSSZ1f7fvKe4ikSKYGQMh/aSP4ekZ5ndeS0wx4tv6pQu9s
 EVXnKgJuOqAVrMoNgTShqXBaSM3fIvQ4PlTi3+/9EcMb95oxTQpJ5uAja9U9IfxYdB8/gu
 x8MlqSLi2xJjfpZIapXtWWDamMggR6g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-X8AChXT7NZO0_ZBjLfyFaA-1; Fri, 26 Jan 2024 13:16:18 -0500
X-MC-Unique: X8AChXT7NZO0_ZBjLfyFaA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bbaf0ee0d9so1113172b6e.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706292977; x=1706897777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNG6H+3tybJ100+FQ7ifNQULqIkXKOGQRCmck6q+baY=;
 b=Ub5KVR2lpALyoeXNhLPo+EP6T3M5+B+fnUsLFfYHqGJppde0GZJl5kcvaNJR1/IoZb
 4WG8foL9EN5iwYpxYzSOezlcWniZQzvC5Dt+oiPYswnwSuGMDABeTbsWyOGPJNd8qeYf
 ufTIwOFJK1JwbxBHkovvO+jk7qlUevadbqgtiNEjNWbki+Bqry0aJSP7H66llFJUvas/
 dY3HGjsVWF/8U+XplwXfhTeC63wRjA+OFASdQ65kFCGLCRVQmXXdCGZxWEfOP+OMF/us
 1REBXvpKfOlqLksDRBPmy0gGzDXb3Jq+j4rUZ3OSMKBIQsg+EwqD/EIEG2JN7yHV5qvQ
 mYlA==
X-Gm-Message-State: AOJu0YygJP1uM/ZCLH74exbeiGO9ZPWVD//2k9M6CqM1VviR0kj/Pz1M
 VOW3BkLeI4/bX7vENRaSgXziaNHFhUEp4Ga5iTgbYEQfK91LiQpsWwU/78swfJp466YADSTxSXr
 B+50jHho7VSvXRBzO2xv0dhGl/7eRaz2IhKwJsUDh/Q/c+pzDYTrJjhKHfQLLJkf13VxBIebJTP
 XfOICGSGW8nySUrq+BHegyyOLoRnw=
X-Received: by 2002:a05:6808:d4b:b0:3bd:f41f:f9a6 with SMTP id
 w11-20020a0568080d4b00b003bdf41ff9a6mr168935oik.25.1706292977729; 
 Fri, 26 Jan 2024 10:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxGYME3uEkFpYZdF0yuGNjBmdCuRZUGKjm+7ziR8gEBrV71tk/J3Re8/gUBge6UdSLwQtE2ayJ0S4PUmkNJQ4=
X-Received: by 2002:a05:6808:d4b:b0:3bd:f41f:f9a6 with SMTP id
 w11-20020a0568080d4b00b003bdf41ff9a6mr168928oik.25.1706292977542; Fri, 26 Jan
 2024 10:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20240124155425.73195-1-philmd@linaro.org>
In-Reply-To: <20240124155425.73195-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:16:06 +0100
Message-ID: <CABgObfb8pKdf=Q7JPDQ9j=Zanbk9gYOC8ufxprGA88zAPaoO5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] accel/kvm: Sanitize KVM_HAVE_MCE_INJECTION definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 24, 2024 at 4:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Trivial replacement of KVM_HAVE_MCE_INJECTION by
> KVM_ARCH_HAVE_MCE_INJECTION (not the "ARCH_" difference).

I am confused, why can't you just rename the symbol and instead you go
through this change?

Paolo

> Philippe Mathieu-Daud=C3=A9 (2):
>   accel/kvm: Define KVM_ARCH_HAVE_MCE_INJECTION in each target
>   accel/kvm: Directly check KVM_ARCH_HAVE_MCE_INJECTION value in place
>
>  include/sysemu/kvm.h         |  7 ++++++-
>  target/arm/cpu-param.h       |  5 +++++
>  target/arm/cpu.h             |  4 ----
>  target/i386/cpu-param.h      |  2 ++
>  target/i386/cpu.h            |  2 --
>  target/loongarch/cpu-param.h |  2 ++
>  target/mips/cpu-param.h      |  2 ++
>  target/ppc/cpu-param.h       |  2 ++
>  target/riscv/cpu-param.h     |  2 ++
>  target/s390x/cpu-param.h     |  2 ++
>  accel/kvm/kvm-all.c          | 10 +++++-----
>  11 files changed, 28 insertions(+), 12 deletions(-)
>
> --
> 2.41.0
>


