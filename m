Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5C1C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhqi-0004o6-Hg; Mon, 09 Jun 2025 15:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uOhqe-0004jE-NB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:07:56 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uOhqb-0000Jd-SD
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:07:56 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60780d74bbaso4772083a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749496070; x=1750100870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t21bvGf4H94FB6zPREklA6T9O4YNkducOlCBGUgMQJs=;
 b=P3b97XA3isPgQl1wgvJIJtNIKCaAs0Ph5gTnaH4RnXAqwqJ4EB87c8UkQNgtWs1cDt
 1/0ry04KRi4r68vYo3NtfwydBOhGbhs3dNSAE/M7LeSlwrT5CZFTC8q9708w/GFTVBjE
 Fu3YH8lvWKJsJSnz9yxY8OcEAImHPnEB//5PvCj6JaGq2ZWJzWve1z3pla/PoZR4ts5M
 pgPOQ2IF7PmQh22z/T5PRsPLfili5JOo22t7Ax5jYL196XqsprHRkYH9XOkGHj5l6BgS
 RJlSA/vS0l5sXNUNUgUkeHwH5cE1UJSGdfWxybX0Yfr6LTIAl439UNa6EVDORU1L6u2T
 tSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496070; x=1750100870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t21bvGf4H94FB6zPREklA6T9O4YNkducOlCBGUgMQJs=;
 b=BuIvGltYB/CLrTEhtAtBuUbCjL5/GxQUmCkviaI8KjBQWQ3BVzK4ktHrBBMsJ2Eg5i
 bWcqCCXzpoCbQt0YALtzVqAujv1FILdm8ZLT/5KpRVq4siP8RyA9H9ChHJ43egCMIWTv
 VhS7MUWEqDqARbXUOegxFA71mnVFqOYcsL3806Hg6MEdOBzU3UwoEwIK/LzUZ0v29VrP
 lUpTSxMVDpfG7BE2HH2tJPgSerY9ZaU1w/J5AV3osOzM8jcZLWt4+DtI6qwIQF71/0lz
 96jmKvDHL1QUJ6hQwP3/G9wsjEq7yUhfim6U2JDzNB8Acvxg02ApgF2PbbYMzeKAiO0L
 Pubw==
X-Gm-Message-State: AOJu0YzjZB9+UnUOSaMa9rdgaBe+iwFJ/coC/kBZnbPyTy5RiFOBEj+Z
 3Rt7aeIsLlPjrrbem2b5FOPR1v+vryNMTVXKwdbg/kvxnhr1pVr1IqNIb4wXQQwpnAZFWyNiK3h
 9IsV/jST6Jq9jCZy9C961E9gDYWT92dY=
X-Gm-Gg: ASbGnctaVemq4fAnQNZSsPhnh5Cicq6bcB4ZIz+IEjAWL0necDYjv3zXLHwFMMHaWWH
 CHvyv+bv88eWH3jYUkfyFMBEMeYkSTf/Ki6VyE6WhP3SSee45RpMlwTpQTIU8nlRRC4q3FRXJRA
 xyYBmvQ1H1DGVzezIOi6p/+zPa68FZGmEpVWUIjqynvw==
X-Google-Smtp-Source: AGHT+IGWH8oHw0etQfKSBq1daD4rxHYt+lOqvPjmHKAeMeV0J6vfSnzioz2OE2tmu/ywB/V1NevnTmWQPn5b8kfheLo=
X-Received: by 2002:a50:c350:0:b0:608:199e:df25 with SMTP id
 4fb4d7f45d1cf-608199ee164mr341159a12.2.1749496070271; Mon, 09 Jun 2025
 12:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250609182044.21703-1-tanishdesai37@gmail.com>
In-Reply-To: <20250609182044.21703-1-tanishdesai37@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 9 Jun 2025 15:07:38 -0400
X-Gm-Features: AX0GCFsoV9MiKKSsTXxhr9URgiajdp34GnJun9qrr8ZXbndStTfDa05XktVFUdc
Message-ID: <CAJSP0QXRPcTBHsCPnFfUAKGRa7aqJ+nsiR4buawAeXXh_3p8Ng@mail.gmail.com>
Subject: Re: [PATCH] utils/log: add qemu_log_timestamp() to encapsulate
 timestamp logging
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mads@ynddal.dk, 
 balaton@eik.bme.hu, philmd@linaro.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 9, 2025 at 2:21=E2=80=AFPM Tanish Desai <tanishdesai37@gmail.co=
m> wrote:
>
> Moved the logic for timestamped logging (~6 lines) from a_nocheck__trace_=
foo(header) into a new qemu_log_timestamp() function in util/log.c. This av=
oids code duplication across binaries and enables reuse as a standalone uti=
lity.
> Encapsulation helps reduce build size significantly, particularly when ma=
ny trace points are present. On Ubuntu 22 with
> ./configure --target-list=3Daarch64-softmmu --enable-kvm --enable-trace-b=
ackends=3Dlog,
> this change reduced the build directory size from ~1435.27 MB to ~1412 MB=
 (~23 MB saved).
> Notable reductions include:
>     trace/: ~2.6 MB
>     libqemuutil.a.p: ~3 MB
> A detailed report of size changes (in bytes) for relevant folders and sub=
folders will follow in a trailing mail.

Nice, the output of size(1) on qemu-system-x86_64 is reduced by 3%
(839 KB) when built with gcc 15.1.1 on x86_64:

   text    data     bss     dec     hex filename
14712231        13652904         149496 28514631        1b31947 before
13852879        13652904         149496 27655279        1a5fc6f after

That is in the same ballpark as the change in build directory size you meas=
ured.

> diff --git a/util/log.c b/util/log.c
> index b87d399e4c..996530fe7e 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -143,6 +143,24 @@ void qemu_log_unlock(FILE *logfile)
>      }
>  }
>
> +
> +void qemu_log_timestamp(const char *fmt, ...)
> +{
> +    FILE *f =3D qemu_log_trylock();
> +    if (f) {
> +        va_list ap;
> +        if(message_with_timestamp){
> +            struct timeval _now;
> +            gettimeofday(&_now, NULL);
> +            fprintf(f,"%d@%zu.%06zu:",qemu_get_thread_id(),(size_t)_now.=
tv_sec, (size_t)_now.tv_usec);
> +        }
> +        va_start(ap, fmt);
> +        vfprintf(f, fmt, ap);
> +        va_end(ap);
> +    }
> +    qemu_log_unlock(f);

Although calling qemu_log_unlock(NULL) is safe, existing callers
invoke this function inside the if (f) { ... } body. Please follow
that approach for consistency.

Looks good aside from that.

