Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5918C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 12:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPh4h-0003H4-S4; Thu, 12 Jun 2025 08:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uPh4K-0003A0-FF
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:30:10 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uPh4G-00079W-7E
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:30:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-addfe17ec0bso396320666b.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749731401; x=1750336201; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LAthCIUL4GjwIULRaLaRtPoxL1oy917bqw20hsx5dQg=;
 b=Kspc4rEDolHiNqjJIwWZMf88/RstueBLdQgje7bb0AR/G2RieK8/rGANMhja/xJc8U
 6wqpoNN1NXnjlUzLW0Lzva6THOKDrYy5rtqgATfLFkJFVoOVM7WTaAFmlD0EN3u+T1k1
 cUyWHp9D9epWKa//y7pYRCxPltZ5TwFHD3kjRe6/XNI/7A7hIfVdRFA0rnHw+jwPNbP4
 lZGUfk9mNe5Yy7BGgus1zOwtxnrii7Zf7hntDZGhXwai/F5jBKZ4+1wkljcPl4LFdOJ3
 kgtAaAKdPxvAdOssIG9R681m0rw2b5S5ZRqLhxv6MK5QWJ5rk1YkfedcynpALoWut1yP
 VZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749731402; x=1750336202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAthCIUL4GjwIULRaLaRtPoxL1oy917bqw20hsx5dQg=;
 b=ry/iVzNiX5IWKL+vmcdv14kyBrsoVAmm2whG9BbETorqpZXQ+PZgv7OoYJNJro82hV
 bkrlENG8IseivTs/EkrAZI5sIN2jA/6sJCupt0dwPhpQmS+sSeraLLgfnZY6Lld5bMfT
 TcTLGpoKy1TWRXtr0Oqx1yl28YD5WYAhz+itu1+sRrioimP7TmuhO2pKIRTNcYsmEDlY
 8PVq4g8lTGI92Y8Zey848JWpFhOCusGHLgU40AtIdJc/6ONtNwMXYvq9bsUoZBUj+RF/
 Fp9Tq/vv8E7o8yuM86f4+vW/8thzPnfFqWNCkSjqJzf2b1SKCoDHdJA5dVEIksccGbAK
 cRDA==
X-Gm-Message-State: AOJu0YwbRbAM9zfk21zV2cRvlsbYbE3GgnrgPx0M9oD+E0j94387TK35
 6bFPTcXyipnIgLXaHPJbFmQ/ZhgYOZNJ4J9crSpciK3ft6XNua9UTa5CYKuy31hhUY/nxbetI8M
 rnSoaonZDvd7GJp4pdX01/uelwfPC02noHMmqKpt7BQ==
X-Gm-Gg: ASbGncudVFhtHfALB4K1mHBdPPOihlPDUOOF8vh32RVgW+sO8dtP/8ZSskZ/vFhgL4t
 QeM6JIafjkuNw1Q2SMHbNvM8QRXhlreDfpsLUyHQv2QDu4WzUyxw/URXmqxGWZ9XX2urnGOsHNc
 v86bTW15hsS2LfH/b0joT2n374h0FHHUnPP0sykwk9aIM=
X-Google-Smtp-Source: AGHT+IHR8lwEEXgxlEGc9I0gPi7lREDMQ+VTK8Q3ilPhuTWvan/0ElV4PH4zU2nlyIlQRo9GbQdhBM40WYPyX+H0VrQ=
X-Received: by 2002:a17:907:7245:b0:ad8:942b:1d53 with SMTP id
 a640c23a62f3a-adea5b3c4b5mr302506666b.27.1749731401278; Thu, 12 Jun 2025
 05:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250609182044.21703-1-tanishdesai37@gmail.com>
 <CAJSP0QXRPcTBHsCPnFfUAKGRa7aqJ+nsiR4buawAeXXh_3p8Ng@mail.gmail.com>
In-Reply-To: <CAJSP0QXRPcTBHsCPnFfUAKGRa7aqJ+nsiR4buawAeXXh_3p8Ng@mail.gmail.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Thu, 12 Jun 2025 17:59:50 +0530
X-Gm-Features: AX0GCFvspKPJG58D9BZBQx5SRlVE-sZMcL9OqvCa1-gzo5Yh2w5tEX86e5uJ9Cc
Message-ID: <CAH_Y1jdGT0iAkKneH_7NimesqchcNpnMJs-zkL4bjGrQZkv0Ug@mail.gmail.com>
Subject: Re: [PATCH] utils/log: add qemu_log_timestamp() to encapsulate
 timestamp logging
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mads@ynddal.dk, 
 balaton@eik.bme.hu, philmd@linaro.org, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000a0297d06375f1681"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000a0297d06375f1681
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you everyone for the review I have shared
[PATCH v2] utils/log: add qemu_log_timestamp()
in a separate mail thread with the suggested changes.

On Tue, 10 Jun 2025 at 12:37=E2=80=AFAM, Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

> On Mon, Jun 9, 2025 at 2:21=E2=80=AFPM Tanish Desai <tanishdesai37@gmail.=
com>
> wrote:
> >
> > Moved the logic for timestamped logging (~6 lines) from
> a_nocheck__trace_foo(header) into a new qemu_log_timestamp() function in
> util/log.c. This avoids code duplication across binaries and enables reus=
e
> as a standalone utility.
> > Encapsulation helps reduce build size significantly, particularly when
> many trace points are present. On Ubuntu 22 with
> > ./configure --target-list=3Daarch64-softmmu --enable-kvm
> --enable-trace-backends=3Dlog,
> > this change reduced the build directory size from ~1435.27 MB to ~1412
> MB (~23 MB saved).
> > Notable reductions include:
> >     trace/: ~2.6 MB
> >     libqemuutil.a.p: ~3 MB
> > A detailed report of size changes (in bytes) for relevant folders and
> subfolders will follow in a trailing mail.
>
> Nice, the output of size(1) on qemu-system-x86_64 is reduced by 3%
> (839 KB) when built with gcc 15.1.1 on x86_64:
>
>    text    data     bss     dec     hex filename
> 14712231        13652904         149496 28514631        1b31947 before
> 13852879        13652904         149496 27655279        1a5fc6f after
>
> That is in the same ballpark as the change in build directory size you
> measured.
>
> > diff --git a/util/log.c b/util/log.c
> > index b87d399e4c..996530fe7e 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -143,6 +143,24 @@ void qemu_log_unlock(FILE *logfile)
> >      }
> >  }
> >
> > +
> > +void qemu_log_timestamp(const char *fmt, ...)
> > +{
> > +    FILE *f =3D qemu_log_trylock();
> > +    if (f) {
> > +        va_list ap;
> > +        if(message_with_timestamp){
> > +            struct timeval _now;
> > +            gettimeofday(&_now, NULL);
> > +            fprintf(f,"%d@%zu.%06zu:",qemu_get_thread_id(),(size_t)_no=
w.tv_sec,
> (size_t)_now.tv_usec);
> > +        }
> > +        va_start(ap, fmt);
> > +        vfprintf(f, fmt, ap);
> > +        va_end(ap);
> > +    }
> > +    qemu_log_unlock(f);
>
> Although calling qemu_log_unlock(NULL) is safe, existing callers
> invoke this function inside the if (f) { ... } body. Please follow
> that approach for consistency.
>
> Looks good aside from that.
>

--000000000000a0297d06375f1681
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you everyone for the review I have shared=C2=A0<div=
>[PATCH v2] utils/log: add qemu_log_timestamp()</div>in a separate mail thr=
ead with the suggested changes.</div><div dir=3D"auto"><span style=3D"font-=
family:-apple-system,sans-serif"><br></span></div><div dir=3D"auto"><span s=
tyle=3D"font-family:-apple-system,sans-serif">On Tue, 10 Jun 2025 at 12:37=
=E2=80=AFAM, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stef=
anha@gmail.com</a>&gt; wrote:</span><br></div><div><div class=3D"gmail_quot=
e gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, Jun 9, 2025=
 at 2:21=E2=80=AFPM Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.=
com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Moved the logic for timestamped logging (~6 lines) from a_nocheck__tra=
ce_foo(header) into a new qemu_log_timestamp() function in util/log.c. This=
 avoids code duplication across binaries and enables reuse as a standalone =
utility.<br>
&gt; Encapsulation helps reduce build size significantly, particularly when=
 many trace points are present. On Ubuntu 22 with<br>
&gt; ./configure --target-list=3Daarch64-softmmu --enable-kvm --enable-trac=
e-backends=3Dlog,<br>
&gt; this change reduced the build directory size from ~1435.27 MB to ~1412=
 MB (~23 MB saved).<br>
&gt; Notable reductions include:<br>
&gt;=C2=A0 =C2=A0 =C2=A0trace/: ~2.6 MB<br>
&gt;=C2=A0 =C2=A0 =C2=A0libqemuutil.a.p: ~3 MB<br>
&gt; A detailed report of size changes (in bytes) for relevant folders and =
subfolders will follow in a trailing mail.<br>
<br>
Nice, the output of size(1) on qemu-system-x86_64 is reduced by 3%<br>
(839 KB) when built with gcc 15.1.1 on x86_64:<br>
<br>
=C2=A0 =C2=A0text=C2=A0 =C2=A0 data=C2=A0 =C2=A0 =C2=A0bss=C2=A0 =C2=A0 =C2=
=A0dec=C2=A0 =C2=A0 =C2=A0hex filename<br>
14712231=C2=A0 =C2=A0 =C2=A0 =C2=A0 13652904=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0149496 28514631=C2=A0 =C2=A0 =C2=A0 =C2=A0 1b31947 before<br>
13852879=C2=A0 =C2=A0 =C2=A0 =C2=A0 13652904=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0149496 27655279=C2=A0 =C2=A0 =C2=A0 =C2=A0 1a5fc6f after<br>
<br>
That is in the same ballpark as the change in build directory size you meas=
ured.<br>
<br>
&gt; diff --git a/util/log.c b/util/log.c<br>
&gt; index b87d399e4c..996530fe7e 100644<br>
&gt; --- a/util/log.c<br>
&gt; +++ b/util/log.c<br>
&gt; @@ -143,6 +143,24 @@ void qemu_log_unlock(FILE *logfile)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +<br>
&gt; +void qemu_log_timestamp(const char *fmt, ...)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 FILE *f =3D qemu_log_trylock();<br>
&gt; +=C2=A0 =C2=A0 if (f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_list ap;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(message_with_timestamp){<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timeval _now;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gettimeofday(&amp;_now, NUL=
L);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f,&quot;%d@%zu.%06z=
u:&quot;,qemu_get_thread_id(),(size_t)_now.tv_sec, (size_t)_now.tv_usec);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfprintf(f, fmt, ap);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_end(ap);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_log_unlock(f);<br>
<br>
Although calling qemu_log_unlock(NULL) is safe, existing callers<br>
invoke this function inside the if (f) { ... } body. Please follow<br>
that approach for consistency.<br>
<br>
Looks good aside from that.<br>
</blockquote></div></div>

--000000000000a0297d06375f1681--

