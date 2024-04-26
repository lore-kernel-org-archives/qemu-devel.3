Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BA2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Jfu-0005FX-DH; Fri, 26 Apr 2024 07:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s0Jfs-0005Eo-JP
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s0Jfq-0005YS-P0
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714130605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TP8Ff1HVPvL5F/ZjOCxsiRS6QKAfj2a7dTRJ0HUx544=;
 b=RkBbIQ+Q44q5qGZI4MJXWDsZa1wdKqGjCuKH+2ijLLUvuQJJ/Jla+NvShXwknhkUdO3Kl8
 C589VaIo/thUq/O8U7fSs0X8GQSkTkD076JaQ71RWq0HpArt+0nq/F7y09WhMX6fZf3uTF
 wBifj0EinzP4eAHbxmPyOdWrw3WQmPc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4c7834jDMNOl-YoFQzfC7A-1; Fri, 26 Apr 2024 07:23:23 -0400
X-MC-Unique: 4c7834jDMNOl-YoFQzfC7A-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-61b6f415d0fso38112327b3.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 04:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714130603; x=1714735403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TP8Ff1HVPvL5F/ZjOCxsiRS6QKAfj2a7dTRJ0HUx544=;
 b=f3B6yLWQy5KWbCrwCrSxMvs5O2UMaY13rZ0k44flBq3P7hN0bf4lgFYgt97nVLW0ai
 qO0tg3BN/RZ6Jb157wx0nHU+7+pZuNZR2z/4RAWAS8+QPydYtsUNbPLuvS66O7rlPkbS
 ZF8BSk5NVjP5cw5pxyaf0uvXyrRgUuE/RA4gb3HzK+g3uT8MNs/8jpuVxtSYkMF/vTlL
 Uc+F1AmRk9ehFulKn2Arxdyx+LAFXN+U4NOUUSgf6e2nCwmL9Dx79/wPZir6CtsQ0iz0
 C43Rb1LHALTGCJgTxVw5A0xM315jJQpWUu8sQ9TSSDx4scFWXn4qtGwfxPGwVjPnpKPG
 7z5w==
X-Gm-Message-State: AOJu0Yx/Z/Ujjck3xI/S4tzA3idyDPg0bht8g/S+WKXXlhi114Zj/xja
 ba+L686zXjp1WSCNHwo+sRwi/PnTMe/fa7VVdhshWKqol3BmcW7qJi2p9D+Bpw4OxnNMvF9JQRO
 yypJBLNKRHpt2hoJC68Zm0wwdsmtZ075HmipIn+ZgnPE/MJGDXFb3JLK0E7JzqftOUkg3DS7hCi
 ooSKeX3mIMHHky6OBwhgI6hErtBXo=
X-Received: by 2002:a05:690c:6305:b0:618:ce10:2fcd with SMTP id
 ho5-20020a05690c630500b00618ce102fcdmr2382677ywb.26.1714130603159; 
 Fri, 26 Apr 2024 04:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTSn5Q9jI5zlxU4MCPH+7aRzbtnBmq36BYyr5Da0dKqW9NeQJMhYk0tfkDv/ftlvj0oJJEqkxkj+jUKty3J/A=
X-Received: by 2002:a05:690c:6305:b0:618:ce10:2fcd with SMTP id
 ho5-20020a05690c630500b00618ce102fcdmr2382659ywb.26.1714130602840; Fri, 26
 Apr 2024 04:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240425110414.36977-1-kkostiuk@redhat.com>
 <3fb94fa3-a20c-4eda-b7a5-44e99baa48d4@linaro.org>
In-Reply-To: <3fb94fa3-a20c-4eda-b7a5-44e99baa48d4@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 26 Apr 2024 14:23:12 +0300
Message-ID: <CAPMcbCo2+CKv9w28u2CVyJ9_7u2+bk1g_L4sJCgJ=wTqENZfWg@mail.gmail.com>
Subject: Re: [PATCH] stubs: Add missing qga stubs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ae6f9d0616fe2114"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000ae6f9d0616fe2114
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 25/4/24 13:04, Konstantin Kostiuk wrote:
> > Compilation QGA without system and user fails
> > ./configure --disable-system --disable-user --enable-guest-agent
>
> So this config isn't tested on CI.
>
> Maybe worth enabling QGA in the build-tools-and-docs-debian job?
>

I am not sure that this is very often use case. I used it only during qga
cross-compilation for Windows to speed up build.


>
>
> Please include the link failure:
>
>    /usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function
> `os_host_main_loop_wait':
>    ../util/main-loop.c:303: undefined reference to `replay_mutex_unlock'
>    /usr/bin/ld: ../util/main-loop.c:307: undefined reference to
> `replay_mutex_lock'
>    /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
> `error_printf':
>    ../util/error-report.c:38: undefined reference to `error_vprintf'
>    /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function
> `vreport':
>    ../util/error-report.c:225: undefined reference to `error_vprintf'
>    /usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function
> `timerlist_run_timers':
>    ../util/qemu-timer.c:562: undefined reference to `replay_checkpoint'
>    /usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to
> `replay_checkpoint'
>    /usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to
> `replay_checkpoint'
>    ninja: build stopped: subcommand failed.
>
> > Fixes: 3a15604900c4f433c970cc6294520a98f201287e
>
> Fixes: 3a15604900 ("stubs: include stubs only if needed")
>
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >   stubs/meson.build | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/stubs/meson.build b/stubs/meson.build
> > index 8ee1fd5753..3b9d42023c 100644
> > --- a/stubs/meson.build
> > +++ b/stubs/meson.build
> > @@ -21,12 +21,12 @@ if have_block
> >     stub_ss.add(files('migr-blocker.c'))
> >     stub_ss.add(files('physmem.c'))
> >     stub_ss.add(files('ram-block.c'))
> > -  stub_ss.add(files('replay-tools.c'))
> >     stub_ss.add(files('runstate-check.c'))
> >     stub_ss.add(files('uuid.c'))
> >   endif
> >
> >   if have_block or have_ga
> > +  stub_ss.add(files('replay-tools.c'))
> >     # stubs for hooks in util/main-loop.c, util/async.c etc.
> >     stub_ss.add(files('cpus-get-virtual-clock.c'))
> >     stub_ss.add(files('icount.c'))
> > @@ -45,6 +45,10 @@ if have_block or have_ga
> >     stub_ss.add(files('qmp-quit.c'))
> >   endif
> >
> > +if have_ga
> > +  stub_ss.add(files('error-printf.c'))
>
> So now included twice, not a big deal.
>

we can fix this only with more if
split `if have_block or have_user` into 2 blocks
should I do this?


>
> > +endif
> > +
> >   if have_block or have_user
> >     stub_ss.add(files('qtest.c'))
> >     stub_ss.add(files('vm-stop.c'))
>
>        # more symbols provided by the monitor
>        stub_ss.add(files('error-printf.c'))
>    endif
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> With updated description:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--000000000000ae6f9d0616fe2114
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Fri, Apr 26, 2024 at 2:08=E2=80=AFPM Philippe =
Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 25/4/24 13:04, Konstantin Kostiuk wrote:<br>
&gt; Compilation QGA without system and user fails<br>
&gt; ./configure --disable-system --disable-user --enable-guest-agent<br>
<br>
So this config isn&#39;t tested on CI.<br>
<br>
Maybe worth enabling QGA in the build-tools-and-docs-debian job?<br></block=
quote><div><br></div><div>I am not sure that this is very often use case. I=
 used it only during qga=C2=A0</div><div>cross-compilation for Windows to s=
peed up build.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
<br>
Please include the link failure:<br>
<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_main-loop.c.o: in function <=
br>
`os_host_main_loop_wait&#39;:<br>
=C2=A0 =C2=A0../util/main-loop.c:303: undefined reference to `replay_mutex_=
unlock&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/main-loop.c:307: undefined reference to <=
br>
`replay_mutex_lock&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in functio=
n <br>
`error_printf&#39;:<br>
=C2=A0 =C2=A0../util/error-report.c:38: undefined reference to `error_vprin=
tf&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in functio=
n <br>
`vreport&#39;:<br>
=C2=A0 =C2=A0../util/error-report.c:225: undefined reference to `error_vpri=
ntf&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: libqemuutil.a.p/util_qemu-timer.c.o: in function =
<br>
`timerlist_run_timers&#39;:<br>
=C2=A0 =C2=A0../util/qemu-timer.c:562: undefined reference to `replay_check=
point&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/qemu-timer.c:530: undefined reference to =
<br>
`replay_checkpoint&#39;<br>
=C2=A0 =C2=A0/usr/bin/ld: ../util/qemu-timer.c:525: undefined reference to =
<br>
`replay_checkpoint&#39;<br>
=C2=A0 =C2=A0ninja: build stopped: subcommand failed.<br>
<br>
&gt; Fixes: 3a15604900c4f433c970cc6294520a98f201287e<br>
<br>
Fixes: 3a15604900 (&quot;stubs: include stubs only if needed&quot;)<br>
<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0stubs/meson.build | 6 +++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/stubs/meson.build b/stubs/meson.build<br>
&gt; index 8ee1fd5753..3b9d42023c 100644<br>
&gt; --- a/stubs/meson.build<br>
&gt; +++ b/stubs/meson.build<br>
&gt; @@ -21,12 +21,12 @@ if have_block<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;migr-blocker.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;physmem.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;ram-block.c&#39;))<br>
&gt; -=C2=A0 stub_ss.add(files(&#39;replay-tools.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;runstate-check.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;uuid.c&#39;))<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if have_block or have_ga<br>
&gt; +=C2=A0 stub_ss.add(files(&#39;replay-tools.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0# stubs for hooks in util/main-loop.c, util/async.c=
 etc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;cpus-get-virtual-clock.c&#39=
;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;icount.c&#39;))<br>
&gt; @@ -45,6 +45,10 @@ if have_block or have_ga<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;qmp-quit.c&#39;))<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +if have_ga<br>
&gt; +=C2=A0 stub_ss.add(files(&#39;error-printf.c&#39;))<br>
<br>
So now included twice, not a big deal.<br></blockquote><div><br></div><div>=
we can fix this only with more if<br></div><div>split `if have_block or hav=
e_user` into 2 blocks <br></div><div>should I do this? <br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +endif<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0if have_block or have_user<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;qtest.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;vm-stop.c&#39;))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# more symbols provided by the monitor<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0stub_ss.add(files(&#39;error-printf.c&#39;))<br>
=C2=A0 =C2=A0endif<br>
<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.=
org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
With updated description:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000ae6f9d0616fe2114--


