Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B70CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZLJ-0007BW-7b; Thu, 30 May 2024 02:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCZLI-0007B5-Bh
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCZLC-0006Rf-DG
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717050765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5JzUAVkAE3H6FYS3rcCx0c9+aisMvj5H1gy8EFZpKc=;
 b=HsaFYDMnY2p63lfed+p+oNq5Y+rsXmtDQhJIOit7eBCUi8M2ib/t6u6Jn2/rTz0uHWAX1J
 QCLL/DntD0vclKuwbdq9FrKK6GUpHVuzmj8J/zs4DR62LrvkrO6j371jxXjKh3V+rDtMog
 TvcP2mPmwB/WRhWBJ2Yp5VaGLxqz+04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-0F2XzYHsO5Sntv7ou108bQ-1; Thu, 30 May 2024 02:32:42 -0400
X-MC-Unique: 0F2XzYHsO5Sntv7ou108bQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212976bcd2so671335e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 23:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717050761; x=1717655561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5JzUAVkAE3H6FYS3rcCx0c9+aisMvj5H1gy8EFZpKc=;
 b=kpfPmmg2foYg0iHtSUxf9rwnJPhHdzYnC/AX2eqy9WwybDxAQqPOYxdVjGRTzrIcV1
 Fgot0xBi2GCz+fbyBz345afXIBvKrIgNLL/1JHS8/3oC1Uq1Hj5bUTwpQHou0OyTs+Kx
 2jyn7JHpw98FU4kBS+3F/RWbEKRQ+FHd+0IhF6QFM0SmqxWmrQPrOzfzwGAPbIwl7oIA
 ZGWD+RV0ToXWL8MnKsSVfd8n3DJ7gqUZlvGKT3lSPkIzfajfpD4M9M/eGPMGPvMGD8iN
 ddJ0mjPQTMn3qzjG22PROvtHNw88bg0ivqfuvWWQSjHhUOq+8Kp19sfHH/5f4YnNTSYX
 USlw==
X-Gm-Message-State: AOJu0YysiWxzggwwUlCW39VOj6sKdwXBreb18JzqvMPQ97b7TkP8PDsr
 gi824zlbHFrT3dkUgiWObRC5Yy9OT3MXm3LXejq5nR1Xw+63sXoo7Srz0gkNZaUK404o1Ffk+DV
 8UqMOqGp80BdWx6Rh5wzYqp3DyxjRspwE0+1jlBgDaor2QMGzt0ekrXFk2i7to98tnD5lTsL2L6
 bFQPP0f1wF54gNhArBtHKxJR4o+Ek=
X-Received: by 2002:a05:600c:3d0e:b0:420:e88b:6fb3 with SMTP id
 5b1f17b1804b1-4212777eee0mr15220455e9.0.1717050761038; 
 Wed, 29 May 2024 23:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlPX2PIHhtsVDnp2C8qqeOOVE7RPMpBbeEL/0vvi8SEyozFpvgYLvUJMCStJXOUqecbUfTcAcZ8M9388jNrVw=
X-Received: by 2002:a05:600c:3d0e:b0:420:e88b:6fb3 with SMTP id
 5b1f17b1804b1-4212777eee0mr15220265e9.0.1717050760644; Wed, 29 May 2024
 23:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20240516222047.1853459-3-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 May 2024 08:32:29 +0200
Message-ID: <CABgObfY-6KewmkYEPgucbJnyggNKV8XbG8chvW5OsTV_GLr=gA@mail.gmail.com>
Subject: Re: [PATCH 2/5] qtest: use cpu interface in qtest_clock_warp
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 17, 2024 at 12:21=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This generalises the qtest_clock_warp code to use the AccelOps
> handlers for updating its own sense of time. This will make the next
> patch which moves the warp code closer to pure code motion.
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/sysemu/qtest.h | 1 +
>  accel/qtest/qtest.c    | 1 +
>  system/qtest.c         | 6 +++---
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index b5d5fd34637..45f3b7e1df5 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -36,6 +36,7 @@ void qtest_server_set_send_handler(void (*send)(void *,=
 const char *),
>  void qtest_server_inproc_recv(void *opaque, const char *buf);
>
>  int64_t qtest_get_virtual_clock(void);
> +void qtest_set_virtual_clock(int64_t count);

You can move qtest_get_virtual_clock/qtest_set_virtual_clock to
accel/qtest/qtest.c instead, and make them static.

They are not used anymore in system/qtest.c, and it actually makes a
lot more sense that they aren't.

Paolo

>  #endif
>
>  #endif
> diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
> index f6056ac8361..53182e6c2ae 100644
> --- a/accel/qtest/qtest.c
> +++ b/accel/qtest/qtest.c
> @@ -52,6 +52,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc,=
 void *data)
>
>      ops->create_vcpu_thread =3D dummy_start_vcpu_thread;
>      ops->get_virtual_clock =3D qtest_get_virtual_clock;
> +    ops->set_virtual_clock =3D qtest_set_virtual_clock;
>  };
>
>  static const TypeInfo qtest_accel_ops_type =3D {
> diff --git a/system/qtest.c b/system/qtest.c
> index 6da58b3874e..ee8b139e982 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -332,14 +332,14 @@ int64_t qtest_get_virtual_clock(void)
>      return qatomic_read_i64(&qtest_clock_counter);
>  }
>
> -static void qtest_set_virtual_clock(int64_t count)
> +void qtest_set_virtual_clock(int64_t count)
>  {
>      qatomic_set_i64(&qtest_clock_counter, count);
>  }
>
>  static void qtest_clock_warp(int64_t dest)
>  {
> -    int64_t clock =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    int64_t clock =3D cpus_get_virtual_clock();
>      AioContext *aio_context;
>      assert(qtest_enabled());
>      aio_context =3D qemu_get_aio_context();
> @@ -348,7 +348,7 @@ static void qtest_clock_warp(int64_t dest)
>                                                        QEMU_TIMER_ATTR_AL=
L);
>          int64_t warp =3D qemu_soonest_timeout(dest - clock, deadline);
>
> -        qtest_set_virtual_clock(qtest_get_virtual_clock() + warp);
> +        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
>
>          qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
>          timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
> --
> 2.39.2
>


