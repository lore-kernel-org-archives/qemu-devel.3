Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E49C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFnc-00022v-LC; Wed, 11 Jun 2025 03:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPFnC-0001cF-BV
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPFnA-0000wq-3I
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749626554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQTEqYlMxLG8wqAfiZT4anaA2vw0/TPAbsekROmqg4w=;
 b=OY/YfXTZX+aoksjjACJ82JsYFVeFMdz/fwrXkvSW04UmUPlZKkcrJB/G5U0EnJSG01tYgc
 YWXaLsITaPU/2elITo/cH3DDMSLWxDst5hPNyrqA+oOxLD99GfTZniWONQ+o6VDVrssNv/
 dupYODQ9LSoAykaN2n+4jfMxkCUBZyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-6PCZV0ABPYCg9NrfG8kQdw-1; Wed, 11 Jun 2025 03:22:32 -0400
X-MC-Unique: 6PCZV0ABPYCg9NrfG8kQdw-1
X-Mimecast-MFC-AGG-ID: 6PCZV0ABPYCg9NrfG8kQdw_1749626552
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450df53d461so54575935e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749626551; x=1750231351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQTEqYlMxLG8wqAfiZT4anaA2vw0/TPAbsekROmqg4w=;
 b=BcjNAAV7jhU8/yJqplLOy3ES4nk+BsjZC66I1ivPHUv9w65o66yaGyLqCQmdqT7koq
 BSsUrclBCNfdSOplhrF15cUCCgtNRijhDJY/97hc/zy2g7eAe/pGXo7rjop0ZsbgCKWL
 DeIrDV3fIL1+64va8AANzpWImC5PyNN4SDHSicHrwDiKutRNuWEOaaH0xW6aKfez8Gze
 jnF688Gh65kfPbjiddxcJwDgTmjgorfkO7CvowK9hqBWpXmP89bEK7y2HRPaIiBa1WXW
 atisJq60wA+6gJGKgIDZaVeEUtb4XMzDnBGAZtAiuMIA2B56MG7mKp26UDFr9k1OwSSY
 p4ow==
X-Gm-Message-State: AOJu0Yy6pjO0xl7lLmdZNReyVnUJo1j0lhr8ojW2UyvXr4XooshHUOG0
 Tp3wHTNA2ChiTw1TtVnKPKXwxjW2wjFomdMuXj/V9vD4eVgVoQYrcdJlw4RygLQECMV03tWuAL0
 hUxKCCUz74XW+AjfEtA7K+aXqnApgSKGIxUuj4VrcUo0iHF/0CRyAi/hil+h2slSRZ9slh7SOIl
 lBGoW8RjazXtfWpKKoq0K9fFJP7Ok/XRPFPav8L9E=
X-Gm-Gg: ASbGncviwnWZP9uYbq11WLPO8ami6LswxxQmFF60E+3eA98dlP/wtegrDcBoVAvDNCb
 F0llq5kGkJy0g3mtTc2/KUX5eD6Pnyz9QuxKOtKS8W1tUERVHExgN+VfFQHgePxTrQjHwE1YbIe
 xDDA==
X-Received: by 2002:a05:600c:8219:b0:453:9b3:5b67 with SMTP id
 5b1f17b1804b1-45324f4019amr12369575e9.24.1749626548441; 
 Wed, 11 Jun 2025 00:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERhw6lIxH5y/cZAHk8x3X4Kx0klHDYzunIs312fbiQFLUX+dbkFuZSYE2NTAfXbyzmjmA4lmpZR+wKJgmDQHc=
X-Received: by 2002:a05:600c:1e27:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-45324f331f1mr14584315e9.17.1749626536568; Wed, 11 Jun 2025
 00:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
 <20250610212829.2818792-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20250610212829.2818792-2-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 09:22:05 +0200
X-Gm-Features: AX0GCFvHVL0riE0SUERCx1yHglaKAxm5hVjQGAW6wKis8rJBTAYTL0SZV6MvxVc
Message-ID: <CABgObfaNGO+hJtGWf=eBvurQqi4u3GmLUFsoa4dWVwk0iiA3PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] qemu/timer: introduce time dilation factor
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "P. Berrange, Daniel" <berrange@redhat.com>, "Maydell,
 Peter" <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000033b594063746ac5e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000033b594063746ac5e
Content-Type: text/plain; charset="UTF-8"

Il mar 10 giu 2025, 23:28 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> This factor is applied to time spent since we read clock for the first
> time. It impacts value returned by get_clock() and get_clock_realtime().
>

Sounds like a good idea, however it needs a couple changes:

1) different clocks have different starts, so the clock_start must be
stored per clock type

2) dilation must be applied to timers too.

As to the option, it's not immediately clear is <1 is a speed up or a slow
down. Maybe speed-factor=N is more clearly speeding up things if N>1?

+    g_assert(now >= clock_start);
>

The assertion is not needed, and can even fail in cases involving daylight
savings time; perhaps you can assert that the result is positive instead?

+    if (!clock_time_dilation) {
> +        return now;
> +    }
>

Just initialize it to 1?

+    return clock_start + (now - clock_start) * clock_time_dilation;
>

Please cast back to integer after multiplying. Adding back clock_start in
floating point format loses precision (doubles have only 53 bits of
precision; seconds use 32 of them if the base is 1970, and nanoseconds
don't have the 30 bits they need).

+}
> +
>  /*
>   * Low level clock functions
>   */
> @@ -811,11 +823,9 @@ static inline int64_t get_clock_realtime(void)
>      struct timeval tv;
>
>      gettimeofday(&tv, NULL);
> -    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
> +    return dilate_time(tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000));
>  }
>
> -extern int64_t clock_start;
> -
>  /* Warning: don't insert tracepoints into these functions, they are
>     also used by simpletrace backend and tracepoints would cause
>     an infinite recursion! */
> @@ -826,7 +836,7 @@ static inline int64_t get_clock(void)
>  {
>      LARGE_INTEGER ti;
>      QueryPerformanceCounter(&ti);
> -    return muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq);
> +    dilate_time(muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND,
> clock_freq));
>

Missing "return".

Paolo

 }
>
>  #else
> @@ -838,10 +848,10 @@ static inline int64_t get_clock(void)
>      if (use_rt_clock) {
>          struct timespec ts;
>          clock_gettime(CLOCK_MONOTONIC, &ts);
> -        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
> +        return dilate_time(ts.tv_sec * 1000000000LL + ts.tv_nsec);
>      } else {
>          /* XXX: using gettimeofday leads to problems if the date
> -           changes, so it should be avoided. */
> +           changes, so it should be avoided. Time is already dilated. */
>          return get_clock_realtime();
>      }
>  }
> diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
> index cc1326f7264..d8895aaccad 100644
> --- a/util/qemu-timer-common.c
> +++ b/util/qemu-timer-common.c
> @@ -28,6 +28,7 @@
>  /* real time host monotonic timer */
>
>  int64_t clock_start;
> +double clock_time_dilation;
>
>  #ifdef _WIN32
>
> --
> 2.47.2
>
>

--00000000000033b594063746ac5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 10 giu 2025, 23:28 Pierri=
ck Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouv=
ier@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This factor is applied to time spent since we read clock=
 for the first<br>
time. It impacts value returned by get_clock() and get_clock_realtime().<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sou=
nds like a good idea, however it needs a couple changes:=C2=A0</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">1) different clocks have different s=
tarts, so the clock_start must be stored per clock type</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">2) dilation must be applied to timers too.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">As to the option, it&#39=
;s not immediately clear is &lt;1 is a speed up or a slow down. Maybe speed=
-factor=3DN is more clearly speeding up things if N&gt;1?</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 g_assert(now &gt;=3D clock_start);<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">The assertion is not neede=
d, and can even fail in cases involving daylight savings time; perhaps you =
can assert that the result is positive instead?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 if (!clock_time_dilation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return now;<br>
+=C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Just initialize it to 1?</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 return clock_start + (now - clock_start) * clock_time_dilati=
on;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Please cast back to integer after multiplying. Adding back clock_start i=
n floating point format loses precision (doubles have only 53 bits of preci=
sion; seconds use 32 of them if the base is 1970, and nanoseconds don&#39;t=
 have the 30 bits they need).</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Low level clock functions<br>
=C2=A0 */<br>
@@ -811,11 +823,9 @@ static inline int64_t get_clock_realtime(void)<br>
=C2=A0 =C2=A0 =C2=A0struct timeval tv;<br>
<br>
=C2=A0 =C2=A0 =C2=A0gettimeofday(&amp;tv, NULL);<br>
-=C2=A0 =C2=A0 return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);<br>
+=C2=A0 =C2=A0 return dilate_time(tv.tv_sec * 1000000000LL + (tv.tv_usec * =
1000));<br>
=C2=A0}<br>
<br>
-extern int64_t clock_start;<br>
-<br>
=C2=A0/* Warning: don&#39;t insert tracepoints into these functions, they a=
re<br>
=C2=A0 =C2=A0 also used by simpletrace backend and tracepoints would cause<=
br>
=C2=A0 =C2=A0 an infinite recursion! */<br>
@@ -826,7 +836,7 @@ static inline int64_t get_clock(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0LARGE_INTEGER ti;<br>
=C2=A0 =C2=A0 =C2=A0QueryPerformanceCounter(&amp;ti);<br>
-=C2=A0 =C2=A0 return muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_f=
req);<br>
+=C2=A0 =C2=A0 dilate_time(muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, cl=
ock_freq));<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Missing &quot;return&quot;.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0#else<br>
@@ -838,10 +848,10 @@ static inline int64_t get_clock(void)<br>
=C2=A0 =C2=A0 =C2=A0if (use_rt_clock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec ts;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clock_gettime(CLOCK_MONOTONIC, &amp;ts);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ts.tv_sec * 1000000000LL + ts.tv_nsec;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return dilate_time(ts.tv_sec * 1000000000LL + =
ts.tv_nsec);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* XXX: using gettimeofday leads to probl=
ems if the date<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changes, so it should be avoided.=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changes, so it should be avoided.=
 Time is already dilated. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_clock_realtime();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c<br>
index cc1326f7264..d8895aaccad 100644<br>
--- a/util/qemu-timer-common.c<br>
+++ b/util/qemu-timer-common.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0/* real time host monotonic timer */<br>
<br>
=C2=A0int64_t clock_start;<br>
+double clock_time_dilation;<br>
<br>
=C2=A0#ifdef _WIN32<br>
<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div></div></div>

--00000000000033b594063746ac5e--


