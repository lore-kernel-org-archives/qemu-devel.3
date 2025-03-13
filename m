Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216FFC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsq0w-00045U-L5; Thu, 13 Mar 2025 17:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tsq0v-00044y-0T
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:22:49 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tsq0s-0000jt-Mp
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:22:48 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5fea43da18aso367737eaf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741900965; x=1742505765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=THbcrXaPrNGeunnT+LQ9mcz/uyMw5N2OtBkjf1VNk7E=;
 b=Pc5KK/jvc+jyWw3bXzQlTeZiDdnjIwbUE8gTnNpbn3qBo7/r06aS5n+q+Hu8Gm7K2I
 a5TkCzdeFrjo5CypYAXkKs7NtvwMLFVjSI59jE38aZBsUffbxgevzTALP1dTBLAGiveF
 hxHPUGxLCdQVv9PU2q7asu6gWxoBb/Evfd4kLqVTg2AVKzy2t55G5O/2OKYVT/PYitSX
 NMEZT+dgohrGMKrjpYayNSLb7FiLz1GHmdx/iAg949Ju+ZpHN2LDLzVbR3Zp8foRK07N
 Shk5o9lM3lxqzIMIg5tX+iFf4zETBO2MKsKKFJBHO1Q04GSE78yFlRz5mhozjc1MP/aN
 lu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741900965; x=1742505765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=THbcrXaPrNGeunnT+LQ9mcz/uyMw5N2OtBkjf1VNk7E=;
 b=VFZ4SPkhBSvE8QMRr1KG1a/gxSOWOBey2zE4r+ia7T9ItJ0/01fSnG2+n9Owt9xPB8
 cbBNzsNBLvqgNAehpAD5ZbXv/UJYtHwmpgxUh7wW0k8Nwkfwz9TgNhBtKVmuquosgvcN
 Ulw93Tcs260/QYl56+SGDHDtnikYhPENGP9ExtVhSTpOPnc4qIX/W0+b4MO3xxa94SVI
 1Xh6aY2fG9GbrsO5s2/HdxIWgAQmc1v1wUgqn8xm9BtefYwne5KZxaYwnOKjcGSbELju
 HD2gcw5WhmYmiS6e6Y2Gde8xztUK6qq0zuuIG+hxgdpyjmKxkZwkr3rMqDw80OS9oNE6
 NBrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuHmMjmdWMukD0IjhILJMUw27L13pypxmAi7iFJwZlmi8qWv0ttW1vS1KY9DB3TNfXymGneqCtlMzh@nongnu.org
X-Gm-Message-State: AOJu0Yzl1edslbCupdAS1PBuGV/sk6PrK5LqCrIQ21npgFjbxK4cY7e2
 YPjIKYvBx4iMa/QXAH4uL0kcBeyBDzCcDUfqpYNw9OjP1Hub9vA3fAYb53G89PUGRR+dg+rQLDy
 iYI8WfSq48g0POcMQAmgWvzZIMkk=
X-Gm-Gg: ASbGncuZXGKapViUEcN2f1VHJ2Pz28iETe6x8HN1vc6Tu35YdueQZU1gicxrecHB/dR
 Rn8A8d4jSkoVPVRIeZ4OBRQNViHHoi7fc3tI89otVDZ0daGT0FL+8UghW9Oe1l5NmdtiRbWOmWk
 0h+zpSk/HcRPUjIOmp6onMDZHz80QWZ0uzo3b/93xtu0knQugEUndigdP+
X-Google-Smtp-Source: AGHT+IHBhVLSMJczsh2RMfv9uIAiS+NpePVia89GFI57JZ70UFno/SLu9JwtWRPiz+n7fCZrS7SqHrGv4Gza84W0LZw=
X-Received: by 2002:a05:6808:2516:b0:3f8:debb:7683 with SMTP id
 5614622812f47-3fda2b2d653mr749274b6e.23.1741900965078; Thu, 13 Mar 2025
 14:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
 <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
 <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
In-Reply-To: <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 13 Mar 2025 22:22:33 +0100
X-Gm-Features: AQ5f1Jrn561gd2aAUrc4DnFzvnIS8IX8I3_PAcDmCsZJA6zon00E6Up3Q6c1ELQ
Message-ID: <CAPan3Wozs=BX2pYxgBR3R_TtV75Pk8T=TNXZjgRHajzYw47Y-A@mail.gmail.com>
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: multipart/alternative; boundary="00000000000041fb1006303fec83"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-oo1-xc2c.google.com
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

--00000000000041fb1006303fec83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Stefan, Thomas,

Thanks for reporting this. I'll try to spend some time to figure out the
issue and perhaps propose a new image for this test, if needed.

Regards,
Niek

On Thu, Mar 13, 2025 at 8:39=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas Huth <thuth@redhat.com> wr=
ote:
> >
> > On 13/03/2025 03.22, Stefan Hajnoczi wrote:
> > > Hi,
> > > CI jobs that run test_arm_orangepi.py are failing:
> > > https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138
> > >
> > > Please consider how to resolve this so the CI job passes again. If yo=
u
> > > are in contact with the archive.netbsd.org administrators, maybe
> > > contacting them will lead to a fix. Otherwise please update the QEMU
> > > test to use a URL that works or remove the test.
> > >
> > > The NetBSD Orange Pi image fails to download cleanly:
> > >
> > > $ curl -O '
> https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/=
binary/gzimg/armv7.img.gz
> '
> > >    % Total    % Received % Xferd  Average Speed   Time    Time
>  Time  Current
> > >                                   Dload  Upload   Total   Spent
> Left  Speed
> > >    0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01
> 0:04:41 1098k
> > > curl: (18) end of response with 315646186 bytes missing
> >
> > FYI, Nicholas already provided a nice patch series to skip the test in
> case
> > of such incomplete downloads:
> >
> >
> https://lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@gmail.=
com/
> >
> > I'll try to assemble a pull request with these patches today.
>
> Thank you!
>
> Stefan
>


--=20
Niek Linnenbank

--00000000000041fb1006303fec83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Stefan, Thomas,</div><div><br></div><div>Thanks=
 for reporting this. I&#39;ll try to spend some time to figure out the issu=
e and perhaps propose a new image for this test, if needed.</div><div><br><=
/div><div>Regards,</div><div>Niek</div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13=
, 2025 at 8:39=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gm=
ail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas H=
uth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@redhat.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 13/03/2025 03.22, Stefan Hajnoczi wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt; CI jobs that run test_arm_orangepi.py are failing:<br>
&gt; &gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/9390048284=
#L1138" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/jobs/9390048284#L1138</a><br>
&gt; &gt;<br>
&gt; &gt; Please consider how to resolve this so the CI job passes again. I=
f you<br>
&gt; &gt; are in contact with the <a href=3D"http://archive.netbsd.org" rel=
=3D"noreferrer" target=3D"_blank">archive.netbsd.org</a> administrators, ma=
ybe<br>
&gt; &gt; contacting them will lead to a fix. Otherwise please update the Q=
EMU<br>
&gt; &gt; test to use a URL that works or remove the test.<br>
&gt; &gt;<br>
&gt; &gt; The NetBSD Orange Pi image fails to download cleanly:<br>
&gt; &gt;<br>
&gt; &gt; $ curl -O &#39;<a href=3D"https://archive.netbsd.org/pub/NetBSD-a=
rchive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz" rel=3D"norefer=
rer" target=3D"_blank">https://archive.netbsd.org/pub/NetBSD-archive/NetBSD=
-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz</a>&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 % Total=C2=A0 =C2=A0 % Received % Xferd=C2=A0 Averag=
e Speed=C2=A0 =C2=A0Time=C2=A0 =C2=A0 Time=C2=A0 =C2=A0 =C2=A0Time=C2=A0 Cu=
rrent<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Dload=C2=A0 Uplo=
ad=C2=A0 =C2=A0Total=C2=A0 =C2=A0Spent=C2=A0 =C2=A0 Left=C2=A0 Speed<br>
&gt; &gt;=C2=A0 =C2=A0 0=C2=A0 303M=C2=A0 =C2=A0 0 2048k=C2=A0 =C2=A0 0=C2=
=A0 =C2=A0 =C2=A00=C2=A0 1098k=C2=A0 =C2=A0 =C2=A0 0=C2=A0 0:04:42=C2=A0 0:=
00:01=C2=A0 0:04:41 1098k<br>
&gt; &gt; curl: (18) end of response with 315646186 bytes missing<br>
&gt;<br>
&gt; FYI, Nicholas already provided a nice patch series to skip the test in=
 case<br>
&gt; of such incomplete downloads:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/202503121300=
02.945508-1-npiggin@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@gmail.com/</a>=
<br>
&gt;<br>
&gt; I&#39;ll try to assemble a pull request with these patches today.<br>
<br>
Thank you!<br>
<br>
Stefan<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div>

--00000000000041fb1006303fec83--

