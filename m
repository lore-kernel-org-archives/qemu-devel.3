Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E4C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 18:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL5oV-0003k8-Q9; Sat, 22 Jun 2024 14:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5oU-0003ju-1G
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:50:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5oS-0007kO-1C
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:50:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c7dbdc83bfso2458841a91.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719082209; x=1719687009;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4NTQrAWCgds4TH/RNuC+w4tcmLMWQsai/6wnvIoYyo=;
 b=Xl7KcuCjSbrnx+Ur8dsjASJKSPfJYYLoNdaPtjGxTfALjOyhjc0FgVMhVV0+f1JhSu
 ebvUH3B3wSsNjQPcYSqsjGSr2GY587CmxSmr0ooK21kJI8sQFIMHHbsCC6r7XeOZlvDL
 xNelRlLBZMHTv/dpZKJ20rUzseGFn3CvIla0jFna78+6u06TLZdJx5wg5SFwfqjeQUkG
 dmAj85PlUgSnJasNOqWxbchLjh0aEKeRJ7vlWHIvu7LQvm9SBb7Ulze7GTmKa2YxxCe8
 N1fAVFNZx2q3I/an6y4Dp+02DHIUpoJLlUifEfmIrUq6pfWhJkZOwHd1CnaHDyW/B8C8
 AqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719082209; x=1719687009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4NTQrAWCgds4TH/RNuC+w4tcmLMWQsai/6wnvIoYyo=;
 b=ii9AKew+YjlC5I/yTZyVnYx9frKQ/cVjEmE9aGSO+o1v5lYVe3xvHgQbiSRKUYfPaS
 2EJXpCBS95kiLXdPfWAlQfWR67F0ItUlRDbL3MuVHGuUszWrswVyO2prAqhLCN5LLc+m
 uiFloUVN5qktYFSwsnu6QfmMtUQ6niBEtntB1HU4uKyifC3JNW7yDeVlbvZAEaI2R8+N
 5MRKrLaDdgVcAnN+RVg30C9S1hbRRMDywSEznhgbmIyhq7rPYw/5ekoweijvQHtDZ2dn
 MhVk2JoiVYdcBtpQeBhUDZmBBhmyAG6VwmigX9ThOhstkaWQ5rZ+CyPCcrF2ifX3MPu3
 KrpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9wm8nsHaXJrAYr94WJcBIpVpJxrdz7dvcqnLoMgdnc9hH2D7YKmOXgMMdiY2lY07pn4EdIn0fQapaB4AAavpPUHwjnEY=
X-Gm-Message-State: AOJu0YxHs5SZ0QVnIqLvorH1sJUv9qXAt0Jn/gVqqwDKQx+qmSAl4CC4
 w+bndBzqS/9TS12iSguXbf09eLZhCjq5/cOBGWJKJ7KUc74kzzjCDe3onysu+D0Ws1AhYxuzfAm
 xcIUeFGeio0Bn/8JeQ7sQdVj1QlePC/eD11g5Rw==
X-Google-Smtp-Source: AGHT+IEzHOrzf1Idj8W/oVXqIpl6I4d6FeITSJLcV+1HUAHhhbiEzipz/C4fQe4r3fhA3004MBmSdAa8b5+cL3oNxd0=
X-Received: by 2002:a17:90b:374b:b0:2c3:e99:614f with SMTP id
 98e67ed59e1d1-2c86147bd5fmr408409a91.37.1719082209428; Sat, 22 Jun 2024
 11:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-3-itachis@FreeBSD.org>
 <3eed856e-51bf-4dd5-8665-60132adf01a3@linaro.org>
In-Reply-To: <3eed856e-51bf-4dd5-8665-60132adf01a3@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 22 Jun 2024 12:49:58 -0600
Message-ID: <CANCZdfpQ0TmCU-9OAMkJo2_4UDFpRVVRPc5qzLgmo75wVXkQew@mail.gmail.com>
Subject: Re: [PATCH 02/23] Added CPU loop function
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>,
 Kyle Evans <kevans@freebsd.org>, 
 Sean Bruno <sbruno@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: multipart/alternative; boundary="0000000000006ee95b061b7f0425"
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000006ee95b061b7f0425
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:24=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:57, Ajeet Singh wrote:
> > +            /*
> > +             * The carry bit is cleared for no error; set for error.
> > +             * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
> > +             */
> > +            pstate =3D pstate_read(env);
> > +            if (ret >=3D 0) {
> > +                pstate &=3D ~PSTATE_C;
> > +                env->xregs[0] =3D ret;
> > +            } else if (ret =3D=3D -TARGET_ERESTART) {
> > +                env->pc -=3D 4;
> > +                break;
> > +            } else if (ret !=3D -TARGET_EJUSTRETURN) {
> > +                pstate |=3D PSTATE_C;
> > +                env->xregs[0] =3D -ret;
> > +            }
> > +            pstate_write(env, pstate);
>
> No need for full pstate read/write:
>
>      env->CF =3D {0,1};
>

If I understand what you're suggesting, the quoted code can be replaced
by the following, faster construct:

            /*
             * The carry bit is cleared for no error; set for error.
             * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
             */
            if (ret >=3D 0) {
                env->CF =3D 0;
                env->xregs[0] =3D ret;
            } else if (ret =3D=3D -TARGET_ERESTART) {
                env->pc -=3D 4;
                break;
            } else if (ret !=3D -TARGET_EJUSTRETURN) {
                env->CF =3D 1;
                env->xregs[0] =3D -ret;
            }
            break;

Is that what you're saying?


> > +            break;
> > +
> > +        case EXCP_INTERRUPT:
> > +            /* Just indicate that signals should be handle ASAP. */
> > +            break;
> > +
> > +        case EXCP_UDEF:
> > +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc)=
;
> > +            break;
> > +
> > +
> > +        case EXCP_PREFETCH_ABORT:
> > +        case EXCP_DATA_ABORT:
> > +            /* We should only arrive here with EC in {DATAABORT,
> INSNABORT}. */
> > +            ec =3D syn_get_ec(env->exception.syndrome);
>
> Nevermind about my question about syndrome.h vs patch 1.
>

Ah, Since we have to re-roll this patch anyway, maybe moving it is a good
idea?
Honestly, I'm good either way.

Warner


> r~
>

--0000000000006ee95b061b7f0425
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 17, 2024 at 10:24=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 6/17/24 11:57, Ajeet Singh wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The carry bit is cl=
eared for no error; set for error.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* See arm64/arm64/vm_=
machdep.c cpu_set_syscall_retval()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pstate =3D pstate_read(env)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pstate &amp;=
=3D ~PSTATE_C;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;xregs=
[0] =3D ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret =3D=3D -TARG=
ET_ERESTART) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pc -=
=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret !=3D -TARGET=
_EJUSTRETURN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pstate |=3D P=
STATE_C;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;xregs=
[0] =3D -ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pstate_write(env, pstate);<=
br>
<br>
No need for full pstate read/write:<br>
<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;CF =3D {0,1};<br></blockquote><div><br></div><d=
iv>If I understand what you&#39;re suggesting, the quoted code can be repla=
ced</div><div>by the following, faster construct:</div><div><br></div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* The carry bit is cleared for no error; set for error=
.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* See arm64/arm64/vm_m=
achdep.c cpu_set_syscall_retval()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0=
) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CF =
=3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;x=
regs[0] =3D ret;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (re=
t =3D=3D -TARGET_ERESTART) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;pc -=3D 4;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } els=
e if (ret !=3D -TARGET_EJUSTRETURN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 env-&gt;CF =3D 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;xregs[0] =3D -ret;<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;=
<br></div><div><br></div><div>Is that what you&#39;re saying?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EXCP_INTERRUPT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Just indicate that signa=
ls should be handle ASAP. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EXCP_UDEF:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 force_sig_fault(TARGET_SIGI=
LL, TARGET_ILL_ILLOPN, env-&gt;pc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EXCP_PREFETCH_ABORT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EXCP_DATA_ABORT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We should only arrive he=
re with EC in {DATAABORT, INSNABORT}. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ec =3D syn_get_ec(env-&gt;e=
xception.syndrome);<br>
<br>
Nevermind about my question about syndrome.h vs patch 1.<br></blockquote><d=
iv><br></div><div>Ah, Since we have to re-roll this patch anyway, maybe mov=
ing it is a good idea?</div><div>Honestly, I&#39;m good either way.</div><d=
iv><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
r~<br>
</blockquote></div></div>

--0000000000006ee95b061b7f0425--

