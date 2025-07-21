Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C078C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkcu-0000WQ-Nu; Mon, 21 Jul 2025 03:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1udkcr-0000UK-TM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1udkck-0006I1-WB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753081663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPBPm6xDdXRorQWjtgeO81vXABcmaHV1y4MseQU4eDQ=;
 b=Mu5SiInkO6zOetGwpxB3bbAY6jN6TkDJ2MHG+ECy6LDVGRIkyOVANFaQdyAew3SysgYf2W
 fVrJ7jqaKAaOe7qKlzTX2pfOXI8zXJpoY9Hhsnp7e5jmf7r3DRUgX1nKYOkzKnCGh9hzWz
 OmJYPnSFTOCdtmeBn7QSmyTOwByoTdQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-CfiWAcbENGeFevIPGfLURA-1; Mon, 21 Jul 2025 03:07:39 -0400
X-MC-Unique: CfiWAcbENGeFevIPGfLURA-1
X-Mimecast-MFC-AGG-ID: CfiWAcbENGeFevIPGfLURA_1753081659
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e32df3ace0so324480085a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753081659; x=1753686459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPBPm6xDdXRorQWjtgeO81vXABcmaHV1y4MseQU4eDQ=;
 b=w8z5BOi/BJwspDJBLrgSo3fvbNB2hMsRIPKCWdU3lw+gFMI4+IeYcsIdMsaJCS53nG
 yTpOq7rIKaT0awtZfkfbZuzYQKhDhcw8vuipojpNWiqy4PdvNmJSYPkv2cH5lMgFejYw
 KzCiwp0UKAoSXFAXQ501DL4mQWdOblk58zqx4qfa+ec/ymIRzItH+K+X9j3ITR3KVtG3
 e64ex3Dkl2C+jReIjjaeQZZa/OiGMVQXNG0ykYxGUoIk3/A9gpVg03Z2b++RvWmtNG68
 GtVjCc3uBuCZvth/RVCBo1C8b7Kz0forQkzQQiEejJhowxZfV5OM61PQK1KCwHZywRXh
 7VYw==
X-Gm-Message-State: AOJu0YyfAJx76fgJiJYWM9och2DFQMT8o7qeQ07JZTXuxvIIwMgAtuF3
 I1ccwTE1WbdIdU49ub4hG72HxbT3N9tyIsTcSsR/AYLGBHw0bHfs/nJoxnR55xQE0fTKjlj4zqh
 LMjpjWHnCdKwgvcWvjXgXIcSWaCWezuP+MY2fO1yeZf7IPZ4dJ8hGPXjCwGcnFe5vnRFfdGTmrG
 eVwqv3PlA4TOL837xagFOsROJ8a+kQsGc=
X-Gm-Gg: ASbGncvVxttwuJKlfzxC9ygsVN7ZxfBFmU03eKcxQPEj1tnTuaebqltH+CrQ4QxnP0P
 lWU0kLNzbC2AzjJYzkiRA47vEEdhQnGJuBTzNivD+vNlZq0/Vjb2nSVP8j3UrJ1ht1CjlRyo3Vu
 uuzTyhTcMrqbxDTvXELUUIHGU=
X-Received: by 2002:a05:620a:1aa2:b0:7d3:e868:a684 with SMTP id
 af79cd13be357-7e343635982mr2222253685a.51.1753081658582; 
 Mon, 21 Jul 2025 00:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjO/N8FnpuyCSdQ6a6g7phYkV1mYx6eX3e1SG8zp0O27wI+4BSZsKBUGqe8I2cVY1yqEW7YulX93hrCSoAaY=
X-Received: by 2002:a05:620a:1aa2:b0:7d3:e868:a684 with SMTP id
 af79cd13be357-7e343635982mr2222251885a.51.1753081658212; Mon, 21 Jul 2025
 00:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
In-Reply-To: <87pldwbspt.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 21 Jul 2025 10:07:27 +0300
X-Gm-Features: Ac12FXxeVR327bGBwYDq2CF9D2QWtKbnsIg3Ogp07lOzOYOjWmqmmr_TaeOlq44
Message-ID: <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000801ceb063a6b215d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000801ceb063a6b215d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
>
> > g_win32_error_message - translate a Win32 error code
> > (as returned by GetLastError()) into the corresponding message.
> >
> > In the same time, we call error_setg_win32_internal with
> > error codes from different Windows componets like VSS or
> > Performance monitor that provides different codes and
> > can't be converted with g_win32_error_message.
>
> Are these error codes from GetLastError()?
>

No.
VSS functions directly return an error code.
Section: Return value -
https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-iv=
ssbackupcomponents-addtosnapshotset

Performance Counters API can return a system error code or a PDH error code=
.
Section: Return value -
https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-pdhopenquery=
w
System error code =3D GetLastError, PDH error code, something else.

https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-codes
FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.


> >                                                In this
> > case, the empty suffix will be returned so error will be
> > masked.
> >
> > QGA error example:
> >  - before changes:
> >   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to
> snapshot set: "}}
> >  - after changes:
> >   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to
> snapshot set: unknown Windows error 0x8004230e"}}
>
> Exact reproducer?
>

Yes, for example, with VSS.
Execute: {"execute": "guest-fsfreeze-freeze-list", "arguments":
{"mountpoints": ["C:"]}}
After this commit, you will get {"error": {"class": "GenericError", "desc":
"failed to add C: to snapshot set: unknown Windows error 0x80042308"}}


>
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  util/error.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/util/error.c b/util/error.c
> > index daea2142f3..b1342558ae 100644
> > --- a/util/error.c
> > +++ b/util/error.c
> > @@ -188,6 +188,11 @@ void error_setg_win32_internal(Error **errp,
> >
> >      if (win32_err !=3D 0) {
> >          suffix =3D g_win32_error_message(win32_err);
> > +        // g_win32_error_message() failed
> > +        if (!suffix[0]) {
> > +            g_free(suffix);
> > +            suffix =3D g_strdup_printf("unknown Windows error 0x%x",
> win32_err);
> > +        }
> >      }
> >
> >      va_start(ap, fmt);
>
>

--000000000000801ceb063a6b215d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Ar=
mbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Kostiant=
yn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kko=
stiuk@redhat.com</a>&gt; writes:<br>
<br>
&gt; g_win32_error_message - translate a Win32 error code<br>
&gt; (as returned by GetLastError()) into the corresponding message.<br>
&gt;<br>
&gt; In the same time, we call error_setg_win32_internal with<br>
&gt; error codes from different Windows componets like VSS or<br>
&gt; Performance monitor that provides different codes and<br>
&gt; can&#39;t be converted with g_win32_error_message.<br>
<br>
Are these error codes from GetLastError()?<br></blockquote><div><br></div><=
div>No.<br> VSS functions directly return an error code. <br></div><div>Sec=
tion: Return value - <a href=3D"https://learn.microsoft.com/en-us/windows/w=
in32/api/vsbackup/nf-vsbackup-ivssbackupcomponents-addtosnapshotset">https:=
//learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-ivssback=
upcomponents-addtosnapshotset</a></div><div><br></div><div>Performance Coun=
ters API can return a system error code or a PDH error code.</div><div>Sect=
ion: Return value - <a href=3D"https://learn.microsoft.com/en-us/windows/wi=
n32/api/pdh/nf-pdh-pdhopenqueryw">https://learn.microsoft.com/en-us/windows=
/win32/api/pdh/nf-pdh-pdhopenqueryw</a></div><div>System error code =3D Get=
LastError, PDH error code, something else.<br></div><div><br></div><div><a =
href=3D"https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-=
codes">https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-c=
odes</a></div><div>FormatMessage requires LoadLibrary(L&quot;pdh.dll&quot;)=
 to work properly.<br></div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 In this<br>
&gt; case, the empty suffix will be returned so error will be<br>
&gt; masked.<br>
&gt;<br>
&gt; QGA error example:<br>
&gt;=C2=A0 - before changes:<br>
&gt;=C2=A0 =C2=A0{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError=
&quot;, &quot;desc&quot;: &quot;failed to add D:\\ to snapshot set: &quot;}=
}<br>
&gt;=C2=A0 - after changes:<br>
&gt;=C2=A0 =C2=A0{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError=
&quot;, &quot;desc&quot;: &quot;failed to add D:\\ to snapshot set: unknown=
 Windows error 0x8004230e&quot;}}<br>
<br>
Exact reproducer?<br></blockquote><div><br></div>Yes, for example, with VSS=
. <br></div><div class=3D"gmail_quote gmail_quote_container">Execute: {&quo=
t;execute&quot;: &quot;guest-fsfreeze-freeze-list&quot;, &quot;arguments&qu=
ot;: {&quot;mountpoints&quot;: [&quot;C:&quot;]}}<br></div><div class=3D"gm=
ail_quote gmail_quote_container">After this commit, you will get {&quot;err=
or&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &quot;desc&quot;: &=
quot;failed to add C: to snapshot set: unknown Windows error 0x80042308&quo=
t;}}</div><div class=3D"gmail_quote gmail_quote_container"><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 util/error.c | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/util/error.c b/util/error.c<br>
&gt; index daea2142f3..b1342558ae 100644<br>
&gt; --- a/util/error.c<br>
&gt; +++ b/util/error.c<br>
&gt; @@ -188,6 +188,11 @@ void error_setg_win32_internal(Error **errp,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (win32_err !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffix =3D g_win32_error_message(win=
32_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 // g_win32_error_message() failed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!suffix[0]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(suffix);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 suffix =3D g_strdup_printf(=
&quot;unknown Windows error 0x%x&quot;, win32_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);<br>
<br>
</blockquote></div></div>

--000000000000801ceb063a6b215d--


