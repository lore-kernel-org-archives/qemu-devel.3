Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901AAC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 21:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttYdc-0005wO-9e; Sat, 15 Mar 2025 17:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttYdY-0005w7-1Q
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 17:01:40 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ttYdS-0007Td-7m
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 17:01:38 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-727388e8f6cso1926835a34.0
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742072487; x=1742677287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/sZB5clN3G1COnf7er11pj81o09OrCXF+Y4pIH+/To=;
 b=JMFmdEj/ONJQ6Zbz+Fi/wrJNG7bCp4xozOC8SBFES+GfFIVluQGv3kG6JlW5XDy5gb
 WCHZveDrZjUk7z7aZOmyAv97HngfFlZZjrh5bC5eB87/pv7UueybFgCf68HsizCNCUdL
 j88IKz9ZCzD9UHS6/Er+7qgb5n/7T1eUYXjPeFSM7vh5juJrMvsmIqHo/fP8UZjxXZ0L
 UK1ju3BxEOqDYuwNA1DOceQc6mYQwEtN8NuhiSREKE4Vqes2elIeiKrlAVqo/gWbbYAF
 y5mA/iOkNWqwjncGfwQKzABzlXVJE/NSpRR7Q9PvraLZtzsjvIP970rvWOBzuQEOQMig
 TSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742072487; x=1742677287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/sZB5clN3G1COnf7er11pj81o09OrCXF+Y4pIH+/To=;
 b=CSQIl1Y+14dLP1787Oqt6RvB1BCN5j+cYFv7BNOlrPmnt0gQnGrppoN68fBYGKe68K
 v6P+0HJtjZHtIueAKS22Uv83+zQ2w4TnDWEZnMW8phsg66jzQkXefvmZ2S+OK8CsVkNw
 WE9gNO/uQ92f2xbl4VNycCTMk+fuLXsrFPTxL8Cp7/RJ+esax44U3ytvntGneTi3MUZJ
 XZ3UPI+FTj8IM7DPm/QXwKQZ9FgX3nYeCcvsqCoJYFQ4Es/72eSXyKDOdaE/q6j6qj1p
 f9yulyWEFunsY9vNG9LPlvmsQTDwcI7Wpzj4dfzdWzuD01wLMWXCvZuktnXrOQkEAT34
 gg3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLcQIPNuXGXHPmF3J0WDWbLaelUCgdFQj2AAo8H2hG+CbvaqoQ/gQR0/ofBfYWq2QjYM4EtBySZbnb@nongnu.org
X-Gm-Message-State: AOJu0YwHSwO/D9TKgr7ty8y78dwdN+ac39QV+eOv3jmtAAyfl+hS0UN+
 c6ffcRYHCTjw07nbVQdCJg45gs03PaIBjIdH2PqaBVOqXwJ4Qwr5jBOrwpjlM++xNOZt1z3qWwI
 KxWfLGRaQ322U8dI0upX5FZMNDuI=
X-Gm-Gg: ASbGncunSWXypwSjeC6h9FYQnTyp2UsvCWChIkUUeXiHT12OKqVK3l8rVOlxzwDSFZ7
 TdskHUkt9SDw67yZ/pl0zQE+2zjV1J6TSitl3wW4kdr6TqCEsgUnmV76NS4Ch+VfmOFlIEVRY8T
 K6Ujt7T2noUynp0X6nTy+oMSJ4KNlkNUOQmgF/oVTuPwkEIdQS9yg2Siii
X-Google-Smtp-Source: AGHT+IE7qQx7DL0UOyD7cRXWJzpxYrMvKaoV/S8gfVYnqLEyBYZ6JhKmCg7MD0hY08+yzJQU0HeoZS94L2/8DXFsjkI=
X-Received: by 2002:a05:6808:158e:b0:3f8:91d1:d950 with SMTP id
 5614622812f47-3fdf073dc59mr3546154b6e.38.1742072487263; Sat, 15 Mar 2025
 14:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
 <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
 <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
 <CAPan3Wozs=BX2pYxgBR3R_TtV75Pk8T=TNXZjgRHajzYw47Y-A@mail.gmail.com>
In-Reply-To: <CAPan3Wozs=BX2pYxgBR3R_TtV75Pk8T=TNXZjgRHajzYw47Y-A@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 15 Mar 2025 22:01:15 +0100
X-Gm-Features: AQ5f1Jp8Ttff7YWnm4JU2zRpWwkXT-D3p6KRcvLvwZVqTkjfJYugQvHaFIDawJc
Message-ID: <CAPan3WqR_UmrJMtYEe02K6vKy4joNE5frGDMW1KWFH-so24nbw@mail.gmail.com>
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: multipart/alternative; boundary="000000000000c6c7be063067db06"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-ot1-x334.google.com
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

--000000000000c6c7be063067db06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Stefan,

As of today, it seems the URL is working properly again. I've done a few
downloads without any error.
What I did notice is that NetBSD provides a 'cdn.netbsd.org' also, but I
can't see any noticable difference yet.

Tests are also running OK now, at least on my local system:

$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 pyvenv/bin/python3
../tests/functional/test_arm_orangepi.py
TAP version 13
ok 1 test_arm_orangepi.BananaPiMachine.test_arm_orangepi
ok 2 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_armbian
ok 3 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_initrd
ok 4 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_sd
ok 5 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_uboot_netbsd9
1..5

Can you confirm the URL is working again properly on CI also?

Regards
Niek

On Thu, Mar 13, 2025 at 10:22=E2=80=AFPM Niek Linnenbank <nieklinnenbank@gm=
ail.com>
wrote:

> Hello Stefan, Thomas,
>
> Thanks for reporting this. I'll try to spend some time to figure out the
> issue and perhaps propose a new image for this test, if needed.
>
> Regards,
> Niek
>
> On Thu, Mar 13, 2025 at 8:39=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om>
> wrote:
>
>> On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas Huth <thuth@redhat.com> w=
rote:
>> >
>> > On 13/03/2025 03.22, Stefan Hajnoczi wrote:
>> > > Hi,
>> > > CI jobs that run test_arm_orangepi.py are failing:
>> > > https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138
>> > >
>> > > Please consider how to resolve this so the CI job passes again. If y=
ou
>> > > are in contact with the archive.netbsd.org administrators, maybe
>> > > contacting them will lead to a fix. Otherwise please update the QEMU
>> > > test to use a URL that works or remove the test.
>> > >
>> > > The NetBSD Orange Pi image fails to download cleanly:
>> > >
>> > > $ curl -O '
>> https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf=
/binary/gzimg/armv7.img.gz
>> '
>> > >    % Total    % Received % Xferd  Average Speed   Time    Time
>>  Time  Current
>> > >                                   Dload  Upload   Total   Spent
>> Left  Speed
>> > >    0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01
>> 0:04:41 1098k
>> > > curl: (18) end of response with 315646186 bytes missing
>> >
>> > FYI, Nicholas already provided a nice patch series to skip the test in
>> case
>> > of such incomplete downloads:
>> >
>> >
>> https://lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@gmail=
.com/
>> >
>> > I'll try to assemble a pull request with these patches today.
>>
>> Thank you!
>>
>> Stefan
>>
>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--000000000000c6c7be063067db06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Stefan,</div><div><br></div><div>As of today, i=
t seems the URL is working properly again. I&#39;ve done a few downloads wi=
thout any error.</div><div>What I did notice is that NetBSD provides a &#39=
;<a href=3D"http://cdn.netbsd.org">cdn.netbsd.org</a>&#39; also, but I can&=
#39;t see any noticable difference yet.</div><div><br></div><div>Tests are =
also running OK now, at least on my local system:</div><div><br></div><div>=
$ QEMU_TEST_ALLOW_LARGE_STORAGE=3D1 pyvenv/bin/python3 ../tests/functional/=
test_arm_orangepi.py <br>TAP version 13<br>ok 1 test_arm_orangepi.BananaPiM=
achine.test_arm_orangepi<br>ok 2 test_arm_orangepi.BananaPiMachine.test_arm=
_orangepi_armbian<br>ok 3 test_arm_orangepi.BananaPiMachine.test_arm_orange=
pi_initrd<br>ok 4 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_sd<br=
>ok 5 test_arm_orangepi.BananaPiMachine.test_arm_orangepi_uboot_netbsd9<br>=
1..5</div><div><br></div><div>Can you confirm the URL is working again prop=
erly on CI also?</div><div><br></div><div>Regards</div><div>Niek</div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Thu, Mar 13, 2025 at 10:22=E2=80=AFPM Niek Linnenbank &=
lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div>Hello Stefan, Thomas,</div><div><br></div><div>Thanks for=
 reporting this. I&#39;ll try to spend some time to figure out the issue an=
d perhaps propose a new image for this test, if needed.</div><div><br></div=
><div>Regards,</div><div>Niek</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13, 2025 at 8:39=E2=80=AFAM =
Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"_blank"=
>stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas Huth &lt;=
<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&=
gt; wrote:<br>
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
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div>

--000000000000c6c7be063067db06--

