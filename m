Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96560D1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t39C1-0006tp-Cc; Tue, 22 Oct 2024 03:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t39Bz-0006tU-Mc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t39Bx-0001E2-Pc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729581631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHFdsND5lkcKNrK5LtDCU3jhqjrx1JsS5DecLTqjxdg=;
 b=imDh8ws2H0EnrvKbgnKeveHtTGVdTCRpbx0E7aJioNRwkeYNsriYQ9ATOYuMWfc/dng+pR
 qVMOfDi/3VBSQIb6LOuAKydFNIYkpQ5A+p9mhSaGUyKSRf1vixjycFuHMob3noZO+72Ahq
 bPKvvdKyyduPrnGZj+SbYJ+MGtXpke0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-mH99OfrANuSrDz0nJnJi_A-1; Tue, 22 Oct 2024 03:20:29 -0400
X-MC-Unique: mH99OfrANuSrDz0nJnJi_A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so36613165e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 00:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729581628; x=1730186428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHFdsND5lkcKNrK5LtDCU3jhqjrx1JsS5DecLTqjxdg=;
 b=sXOFNXkkvaAGoZJ3NRk51MneidWuDY8b8v9Ji/s3nN5qvX9fKI97qK/kr0hplI3NV2
 vXh8pXO58bm2i+YJ9p3rDHwTIZxvj8Xcjo65ruB7Cuj1zMEAlamiJQmEryiuI6QNLJO3
 jSIHi9QhbYRqtoQBOEAw4j5hg8emkLSGJLGFylT3nbXabbrOA0SgCpG64qzAdTEzQ8w/
 WFLZGjY13O0OHBKHpMwcC7zjc1+9DVzUcC3yvkUP5qCirxOEgrby9UvgOD2ixEWMsmyo
 /Vbw+ruS5EFz8tORL7tFuOsZfYCtrGvf3NbLFUGWzaFn+/8dVd498zwzsuuMqCtSw/UW
 2LmA==
X-Gm-Message-State: AOJu0Yxf8OpRz1zdt4Gumhhm3Jssucu9Rw0Ro1MSNRWO/wNncVEaaY71
 +KJnT1G1PtQUV3kArXA/o0Ck84kHgir8T+JUeEEa7C4ABsujLzPxDSY+hra/VPI8vfHEW69HECV
 +Yr4xjBQohVoCyXAZojFzmgZFDoK1agL0coQji1ZLIHxNkHEbQ/dFslcCTfDnNoHWj1IDBy3+tI
 0rAInK0pkxkQh3SPUKsGa332DS5Gg=
X-Received: by 2002:a05:600c:3592:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-43161634f28mr113828465e9.1.1729581627980; 
 Tue, 22 Oct 2024 00:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKIXbencr13C6AfQc23QPQr53Di7qtbT/AcNKKLj4iFIt8RQk87lBr0e4I+5/PiYpFnAtJeV2RwrrTbCo+0B8=
X-Received: by 2002:a05:600c:3592:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-43161634f28mr113828185e9.1.1729581627615; Tue, 22 Oct 2024
 00:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
 <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
 <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Oct 2024 09:20:15 +0200
Message-ID: <CABgObfb1reS81AvA08kXcBRF+yRuqH6rSZd4nf-6ZZ6nkVnSNw@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!,
 use it from #[derive(Object)]
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 22, 2024 at 9:12=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
> My understanding is that:
>
>   1. init_fn() is called by QEMU QOM subsystem with certain timing
>      (e.g., called after main()) and concurrency (e.g., all init_fn()
>      are called sequentially) preconditions.
>
>   2. The caller of module_init! is responsible for justifying the safety
>      of their $body under the preconditions established in #1.
>
> "unsafe fn" in Rust is designed to mark functions with safety
> preconditions so that the compiler can raise an error if the caller
> forgets that it has those preconditions to uphold [1].
>
> Under that interpretation, a safe "fn init_fn()" reads that init_fn() is
> safe to call without the preconditions mentioned in #1. That is rarely
> the case to me.
>
> Using "unsafe" to mark the responsibility of device backends in #2 looks
> like repurposing the keyword. That may make more sense in this specific
> context because:
>
>   1. the callers of init_fn() are in C, so Rust compiler cannot really
>      check them,
>
>   2. the caller will by design upholds the safety preconditions
>      regardless of whether a specific callback needs it or not, and

Or at least will try.

>   3. without unsafe_op_in_unsafe_fn an unsafe fn hides unsafe operation
>      in its body from the compiler.

4. In this specific case, init_fn is only used from ctor_fn and even
there only as a function pointer; it is not visible from outside. So
the "unsafe" marker's only purpose is documentation (and in fact, as
you point out in (3), it would even be harmful without
unsafe_op_in_unsafe_fn).

> If that's what we prefer, I would suggest add the considerations above
> to the code as comments, so that future readers are not confused by the
> usage of "unsafe" here.

Yes, I agree that since we're talking about a macro (not a function
which can itself be annotated with "unsafe") that lies at the C<->Rust
boundary, this is mostly a documentation issue.

In general the documentation of qemu-api and qemu-api-macros leaves
something to be desired. This is okay, but it is also the kind of
technical debt that we need to look at as soon as we can actually get
the thing to compile. :)

I'll add it shortly to https://wiki.qemu.org/Features/Rust.

Paolo


