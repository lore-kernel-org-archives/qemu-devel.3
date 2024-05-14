Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A112EC25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rhy-0003jp-AN; Tue, 14 May 2024 08:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s6rht-0003j7-Nu
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:56:38 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s6rhj-00063u-El
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:56:36 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so4057337eaf.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715691385; x=1716296185; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bB5zKXl3Wv7XIoM1XS61oewsHj9VW0gE37ee88ziWA=;
 b=mWjtl/0CGMHzsOvMOSXDtJJHznv9Wvz2q4W5euaptLDlQto8DZrYqmy53oaoc06wuq
 AnvxF+YGCXcCT09/EFcMRmgA0q37csf1yHQHnai/g2e3qyRp7o2uxv/GwAUYZb/HG3es
 lsQnMgh3W3kziZTRncYeXb0dF6Ujn/bqp72rNemRHjrvDLnjqMES5GtcqAEPhqbammem
 AhUCsoX4Ke1jCpi3vQwyfyw1yUY2qVatLL1d31KpOxUVWvI1nVpR1UnH/25P2TJr/h3f
 DMz7sDKdGolIBQX+skcKDH+DNCMoLPyMpqkSaJT0hZZqFFru9re3EdidgC95oE8VxmLp
 ohIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691385; x=1716296185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bB5zKXl3Wv7XIoM1XS61oewsHj9VW0gE37ee88ziWA=;
 b=ZwX/ZxYM3OkiBjbc/xGk1lK/KBO9ZO3+P8ka8A8CP0jweWpsMWc0aU9pf8u47dI92M
 PQ10Jc3vrefutnjUmiWuljciGQG1ourQYOL73IKPxz/AjyLg6eIT6/M7SPgzyqn0ivaN
 Ffl+0M2LV9WRzwjTtpIkUuo5r2u49dVnkI5gfDwrsGWORmY08pF99Cd57WcfZo+qE6Ad
 i2fm9qhu80Abf0hNQJb1xp1DROnkB8bIjmAuNguIJayI/9zBk1eWdk9OZueerFYjPm7V
 8etoTZRwFoXgb8XHSBWyoGNiDOKitKadEhbiVIltF4YNhoad2mTNjPzEbSl0ZmqTKXC2
 vc5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7oA8bHhgYzYtcb087TFtpHTkgrzLJLqZ6wr/3u9/XBCeaMRY+aDTSYVFFMZcuENvnaFKygleIcT0T14ZkceGyquf+hW8=
X-Gm-Message-State: AOJu0Yx4F+v1ZKCXDlwTaPf0iEEtt5chL3/vrX784F58UF0kCTLAQMrG
 VqdlnZ6dGrTMxW21pCzHDWgI+ur5Z4TrmxfbZ0qgY0jgCZZf9kuM5ZfnxNpVht8SDSRwNA10QXK
 1HhWaujenA5Y3VOhoQNjWfxLUBeE=
X-Google-Smtp-Source: AGHT+IHyCWNTMs58q2lEQKO7UiJbU7aJX3F8NSIXg9iSalGfawIZ7UB3TcEbviSMVw+w5vFJOZcFOAda2KDWPB1PfM0=
X-Received: by 2002:a4a:988f:0:b0:5b2:565b:b6de with SMTP id
 006d021491bc7-5b28189a701mr11533468eaf.3.1715691385673; Tue, 14 May 2024
 05:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
 <ZjxKDkZjAitxCasH@intel.com> <20240509134712.GA515599@fedora.redhat.com>
 <ZkMc5Y5DGhDlfB8J@intel.com>
In-Reply-To: <ZkMc5Y5DGhDlfB8J@intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 May 2024 08:56:15 -0400
Message-ID: <CAJSP0QWDMM7_8Q2jC_4VoW9Uaz+7K_GzuFrxtwh1C5FwH_ho+w@mail.gmail.com>
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000965f7a061869876d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000965f7a061869876d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024, 03:57 Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Stefan,
>
> > QEMU uses clock_gettime(CLOCK_MONOTONIC) on Linux hosts. The man page
> > says:
> >
> >   All CLOCK_MONOTONIC variants guarantee that the time returned by
> >   consecutive  calls  will  not go backwards, but successive calls
> >   may=E2=80=94depending  on  the  architecture=E2=80=94return  identica=
l  (not-in=E2=80=90
> >   creased) time values.
> >
> > trace_record_start() calls clock_gettime(CLOCK_MONOTONIC) so trace even=
ts
> > should have monotonically increasing timestamps.
> >
> > I don't see a scenario where trace record A's timestamp is greater than
> > trace record B's timestamp unless the clock is non-monotonic.
> >
> > Which host CPU architecture and operating system are you running?
>
> I tested on these 2 machines:
> * CML (intel 10th) with Ubuntu 22.04 + kernel v6.5.0-28
> * MTL (intel 14th) with Ubuntu 22.04.2 + kernel v6.9.0
>
> > Please attach to the QEMU process with gdb and print out the value of
> > the use_rt_clock variable or add a printf in init_get_clock(). The valu=
e
> > should be 1.
>
> Thanks, on both above machines, use_rt_clock is 1 and there're both
> timestamp reversal issues with the following debug print:
>
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9a366e551fb3..7657785c27dc 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -831,10 +831,17 @@ extern int use_rt_clock;
>
>  static inline int64_t get_clock(void)
>  {
> +    static int64_t clock =3D 0;
>

Please try with a thread local variable (__thread) to check whether this
happens within a single thread.

If it only happens with a global variable then we'd need to look more
closely at race conditions in the patch below. I don't think the patch is a
reliable way to detect non-monotonic timestamps in a multi-threaded program=
.

     if (use_rt_clock) {
>          struct timespec ts;
>          clock_gettime(CLOCK_MONOTONIC, &ts);
> -        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
> +        int64_t tmp =3D ts.tv_sec * 1000000000LL + ts.tv_nsec;
> +        if (tmp <=3D clock) {
> +            printf("get_clock: strange, clock: %ld, tmp: %ld\n", clock,
> tmp);
> +        }
> +        assert(tmp > clock);
> +        clock =3D tmp;
> +        return clock;
>      } else {
>          /* XXX: using gettimeofday leads to problems if the date
>             changes, so it should be avoided. */
> diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
> index cc1326f72646..3bf06eb4a4ce 100644
> --- a/util/qemu-timer-common.c
> +++ b/util/qemu-timer-common.c
> @@ -59,5 +59,6 @@ static void __attribute__((constructor))
> init_get_clock(void)
>          use_rt_clock =3D 1;
>      }
>      clock_start =3D get_clock();
> +    printf("init_get_clock: use_rt_clock: %d\n", use_rt_clock);
>  }
>  #endif
>
> ---
> The timestamp interval is very small, for example:
> get_clock: strange, clock: 3302130503505, tmp: 3302130503503
>
> or
>
> get_clock: strange, clock: 2761577819846455, tmp: 2761577819846395
>
> I also tried to use CLOCK_MONOTONIC_RAW, but there's still the reversal
> issue.
>
> Thanks,
> Zhao
>
>

--000000000000965f7a061869876d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, May 14, 2024, 03:57 Zhao Liu &lt;<a href=3D"ma=
ilto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Hi Stefan,<br>
<br>
&gt; QEMU uses clock_gettime(CLOCK_MONOTONIC) on Linux hosts. The man page<=
br>
&gt; says:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0All CLOCK_MONOTONIC variants guarantee that the time retur=
ned by<br>
&gt;=C2=A0 =C2=A0consecutive=C2=A0 calls=C2=A0 will=C2=A0 not go backwards,=
 but successive calls<br>
&gt;=C2=A0 =C2=A0may=E2=80=94depending=C2=A0 on=C2=A0 the=C2=A0 architectur=
e=E2=80=94return=C2=A0 identical=C2=A0 (not-in=E2=80=90<br>
&gt;=C2=A0 =C2=A0creased) time values.<br>
&gt; <br>
&gt; trace_record_start() calls clock_gettime(CLOCK_MONOTONIC) so trace eve=
nts<br>
&gt; should have monotonically increasing timestamps.<br>
&gt; <br>
&gt; I don&#39;t see a scenario where trace record A&#39;s timestamp is gre=
ater than<br>
&gt; trace record B&#39;s timestamp unless the clock is non-monotonic.<br>
&gt; <br>
&gt; Which host CPU architecture and operating system are you running?<br>
<br>
I tested on these 2 machines:<br>
* CML (intel 10th) with Ubuntu 22.04 + kernel v6.5.0-28<br>
* MTL (intel 14th) with Ubuntu 22.04.2 + kernel v6.9.0<br>
<br>
&gt; Please attach to the QEMU process with gdb and print out the value of<=
br>
&gt; the use_rt_clock variable or add a printf in init_get_clock(). The val=
ue<br>
&gt; should be 1.<br>
<br>
Thanks, on both above machines, use_rt_clock is 1 and there&#39;re both<br>
timestamp reversal issues with the following debug print:<br>
<br>
diff --git a/include/qemu/timer.h b/include/qemu/timer.h<br>
index 9a366e551fb3..7657785c27dc 100644<br>
--- a/include/qemu/timer.h<br>
+++ b/include/qemu/timer.h<br>
@@ -831,10 +831,17 @@ extern int use_rt_clock;<br>
<br>
=C2=A0static inline int64_t get_clock(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 static int64_t clock =3D 0;<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Please try with a thread local va=
riable (__thread) to check whether this happens within a single thread.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">If it only happens with a g=
lobal variable then we&#39;d need to look more closely at race conditions i=
n the patch below. I don&#39;t think the patch is a reliable way to detect =
non-monotonic timestamps in a multi-threaded program.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (use_rt_clock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec ts;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clock_gettime(CLOCK_MONOTONIC, &amp;ts);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ts.tv_sec * 1000000000LL + ts.tv_nsec;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t tmp =3D ts.tv_sec * 1000000000LL + ts.=
tv_nsec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tmp &lt;=3D clock) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;get_clock: strange,=
 clock: %ld, tmp: %ld\n&quot;, clock, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(tmp &gt; clock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 clock =3D tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return clock;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* XXX: using gettimeofday leads to probl=
ems if the date<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changes, so it should be avoided.=
 */<br>
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c<br>
index cc1326f72646..3bf06eb4a4ce 100644<br>
--- a/util/qemu-timer-common.c<br>
+++ b/util/qemu-timer-common.c<br>
@@ -59,5 +59,6 @@ static void __attribute__((constructor)) init_get_clock(v=
oid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_rt_clock =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0clock_start =3D get_clock();<br>
+=C2=A0 =C2=A0 printf(&quot;init_get_clock: use_rt_clock: %d\n&quot;, use_r=
t_clock);<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
---<br>
The timestamp interval is very small, for example:<br>
get_clock: strange, clock: 3302130503505, tmp: 3302130503503<br>
<br>
or<br>
<br>
get_clock: strange, clock: 2761577819846455, tmp: 2761577819846395<br>
<br>
I also tried to use CLOCK_MONOTONIC_RAW, but there&#39;s still the reversal=
<br>
issue.<br>
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--000000000000965f7a061869876d--

