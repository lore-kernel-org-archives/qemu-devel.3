Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58E4E64018
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 21:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEExk-0005i8-P5; Thu, 21 Nov 2024 16:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jansene@google.com>)
 id 1tEExd-0005hX-Gi
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:43:38 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jansene@google.com>)
 id 1tEExb-0008WF-HJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:43:37 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cfb81a0af9so3303a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1732225412; x=1732830212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lsl1aw4xK6+bDK3HHYwkajyUG3MYR8BrpVKpoFgtI2k=;
 b=GcuU8joMDwJt+v7HP4Aw65v9Q0dpSnPqdfRruRZCJGVQQmG7aiOwAQv2KFup72cBav
 OzqLX75tXXUc2hWTJyWrf2TUnF9Odo8z8zk//qj9Mb810kIt1OXe8dlBV515ZcoPrhTt
 xGGnjgAJlXHmE7siiM1zCNGa7Nbobd7WPcTzCToFV8rlSnq6462ckVbSlndnNolgF8t7
 CNpTX2hpqqx91F3TF6XB8C7/gpvXQuOX3koURps98EZgL4VlnjOrdSXDJXEvWpy/KThi
 1L1NChqM3POa+WsqoQ7kWiH8KaRYXWSCDgN+V6CyNCbehAJIoqa8fK9Jx04kquQZ4ede
 5oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732225412; x=1732830212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lsl1aw4xK6+bDK3HHYwkajyUG3MYR8BrpVKpoFgtI2k=;
 b=Qc1RkMNiyQ06reKKImBL6Mhz9xMmruYzQXDJ0jnJmAHpsARS4MBf4NCBOIZKTl4dgq
 yGENDLUs7/DoEFrzowgXMy+A96+w43z4sO4gImrmxZB6LjpQekLEAVaHoCjbWnF36Cs8
 vY7kkArSQtIUIxbFFU2eWZCEhNsCSpC/8cFYy4CnkJV6hkJ2CU/Eb9ysHr5ka/M+R9P8
 EYkdgC5YCuUclFQZG1fCGxFxO04zSu49TudbWs8xBinM2x9PI9igTudblyd3QQdQkI/v
 i05FMLAOxxGmGTHEnsL/mL5f0J64XdUM7AwLFWkF3SDhfU9gw95JyvpQfNAdSA7LGQ1h
 i26g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6i81TSBxv169AWSMo2gQLzZX2ekvycbzFLiZhaFLguiiB8+ebKV5Jr/N+uEA/abXoX7r1P6VdB3zF@nongnu.org
X-Gm-Message-State: AOJu0YwCJC0uqkN0K9hu791/3QZPchlxqldyibuOQzZJrIRVuB9CDPDM
 ySnMmir2EHyhRKhbSbqYNSAuBPMC4fdV0OsWPW1zcLBNqlWwWoA7dh7bZcViCzj1+cZHf63jvrv
 HsOBjbCcQVCxFXb2PzW64GrnN8aQcGCU/O6kT
X-Gm-Gg: ASbGncvhYqGku4j2l0uXG02wOB6qOCF8n+srUsxej1YU1RC0In0t8YDYkTM58Kk4McI
 VpC8ChtrQrFhjdqN/1ys2b8NE7YU8/vm9eA1SG8LuUFRJtq+X338mhlDtnQOorg==
X-Google-Smtp-Source: AGHT+IEH9u7tJ9jc/eRETSG7ze5k3Y8ndlnXT6KeUSdgREPrnx0rX3lJgpqfiyeEl6N254qN4GzEDyao6e5qHR0RRFU=
X-Received: by 2002:a50:d755:0:b0:5d0:eb1:d430 with SMTP id
 4fb4d7f45d1cf-5d021786998mr1285a12.5.1732225411838; Thu, 21 Nov 2024 13:43:31
 -0800 (PST)
MIME-Version: 1.0
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
 <Zz99VtNtZCx-P5Mx@redhat.com>
 <CABgObfY8fmSjQBU34NVhn-de5iWeWTBJr18u_GgFZpJXjL3NzQ@mail.gmail.com>
In-Reply-To: <CABgObfY8fmSjQBU34NVhn-de5iWeWTBJr18u_GgFZpJXjL3NzQ@mail.gmail.com>
From: Erwin Jansen <jansene@google.com>
Date: Thu, 21 Nov 2024 13:42:55 -0800
Message-ID: <CAP52u7ZdRxATBfopYB90fgWheuqnxJ1R6p-WK0CX0Nrk7Z4jeQ@mail.gmail.com>
Subject: Re: QEMU patches for native windows support through clang-cl
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 sw@weilnetz.de, lvivier@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Patrick Leis <venture@google.com>, 
 Nabih Estefan <nabihestefan@google.com>, Danny Rosen <dannyrosen@google.com>, 
 JP Cottin <jpcottin@google.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000058bc9906277328d7"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jansene@google.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000058bc9906277328d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would a good next step be to work out some more details in a document that
outlines what process we are using, what we are planning to do and include
a set of suggestions as a starting point to see if we can upstream some of
the changes to the larger community?

We currently don't have a proper solution for packing. We are tracking the
issue here https://issuetracker.google.com/issues/380295845. All our code
is public and development is happening on the emu-dev repository:
https://android.googlesource.com/platform/external/qemu/+/emu-dev

Greetings,
Erwin.





On Thu, Nov 21, 2024 at 10:47=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:

> > NB As a general point, we actively block use of clang with Windows
> > builds (more strictly in 9.2 now), because it lacks support for the
> > 'gcc_struct' annotation that we rely on to guarantee correct ABI for
> > structs exposed to guests in particular.
>
> Ah, good point. This is
> https://github.com/llvm/llvm-project/issues/24757 for the general
> tracking issue, and https://github.com/llvm/llvm-project/pull/71148
> for a recent PR that attempts to implement this.
>
> Using -mno-ms-bitfields globally is unsafe because there are probably
> Windows API structs that implement it.
>
> One solution is to add `QEMU_BUILD_BUG_ON(sizeof(...) =3D=3D ...)` to all
> structs in QEMU that use bitfields. That will prove very quickly if
> there are issues or not.
>
> Paolo
>
> > Many people try to simply remove that #ifdef, mistakenly assuming that
> > because the code compiles without warnings, it must be correct. Did
> > you have solution for this, as it would be a blocker for enabling
> > clang on Windows currently ?
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
> >
>
>

--00000000000058bc9906277328d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Would a good next step be to work out some more detai=
ls in a document that outlines what process we are using, what we are plann=
ing to do and include a set of suggestions as a starting point to see if we=
 can upstream some of the changes to the larger community?</div><div><div><=
br></div><div>We currently don&#39;t have a proper solution for packing. We=
 are tracking the issue here <a href=3D"https://issuetracker.google.com/iss=
ues/380295845">https://issuetracker.google.com/issues/380295845</a>. All ou=
r code is public and development is happening on the emu-dev repository:=C2=
=A0<a href=3D"https://android.googlesource.com/platform/external/qemu/+/emu=
-dev">https://android.googlesource.com/platform/external/qemu/+/emu-dev</a>=
=C2=A0</div><div><br></div><div>Greetings,</div><div>Erwin.=C2=A0<br><div><=
br></div><br class=3D"gmail-Apple-interchange-newline"></div><div><div><br>=
</div><div><br></div></div></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 21, 2024 at 10:47=E2=80=AFAM P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&gt; NB As a general point, we actively block use of clang with Windows<br>
&gt; builds (more strictly in 9.2 now), because it lacks support for the<br=
>
&gt; &#39;gcc_struct&#39; annotation that we rely on to guarantee correct A=
BI for<br>
&gt; structs exposed to guests in particular.<br>
<br>
Ah, good point. This is<br>
<a href=3D"https://github.com/llvm/llvm-project/issues/24757" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/llvm/llvm-project/issues/24757</=
a> for the general<br>
tracking issue, and <a href=3D"https://github.com/llvm/llvm-project/pull/71=
148" rel=3D"noreferrer" target=3D"_blank">https://github.com/llvm/llvm-proj=
ect/pull/71148</a><br>
for a recent PR that attempts to implement this.<br>
<br>
Using -mno-ms-bitfields globally is unsafe because there are probably<br>
Windows API structs that implement it.<br>
<br>
One solution is to add `QEMU_BUILD_BUG_ON(sizeof(...) =3D=3D ...)` to all<b=
r>
structs in QEMU that use bitfields. That will prove very quickly if<br>
there are issues or not.<br>
<br>
Paolo<br>
<br>
&gt; Many people try to simply remove that #ifdef, mistakenly assuming that=
<br>
&gt; because the code compiles without warnings, it must be correct. Did<br=
>
&gt; you have solution for this, as it would be a blocker for enabling<br>
&gt; clang on Windows currently ?<br>
&gt;<br>
&gt; With regards,<br>
&gt; Daniel<br>
&gt; --<br>
&gt; |: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blan=
k">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_bla=
nk">https://www.flickr.com/photos/dberrange</a> :|<br>
&gt; |: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank=
">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=
=3D"noreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
&gt; |: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D=
"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a hr=
ef=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_bl=
ank">https://www.instagram.com/dberrange</a> :|<br>
&gt;<br>
<br>
</blockquote></div>

--00000000000058bc9906277328d7--

