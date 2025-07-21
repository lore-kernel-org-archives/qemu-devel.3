Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4668C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnW1-00072E-85; Mon, 21 Jul 2025 06:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1udnVy-0006zd-Ms
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1udnVu-0005tY-JF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753092771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4jaPhSqQDw5lSLuUKWyL3A1tZQ1zUb8Y90XRaTRuscA=;
 b=h2fqDnLyNHH0dsQIPV/3O7IoCHNPKCPDG5oTxHXJa4CwDEuuQMzHqujsCwkIu/8eEKuQP8
 TjqiBuBE3EaKiHof0Eb2flE+cnxBlI6GjD07QgthbSbl7ygAfjIsB3aMwxLGRXOOzfrz2v
 EhWPjo4WoRQQJSuf6+SDmKjpkvm/EIw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-oi2OMkWjP7iFsdaKFvZXNA-1; Mon, 21 Jul 2025 06:12:47 -0400
X-MC-Unique: oi2OMkWjP7iFsdaKFvZXNA-1
X-Mimecast-MFC-AGG-ID: oi2OMkWjP7iFsdaKFvZXNA_1753092767
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fad8b4c92cso119175816d6.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 03:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753092767; x=1753697567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jaPhSqQDw5lSLuUKWyL3A1tZQ1zUb8Y90XRaTRuscA=;
 b=I9qWNmhNDHPj8ckHKtVLmZ/TaD56lLbQyYXavGGzEe7uu0ZKzzvackDNoICX/JJr1H
 FZmAtE8pbeQN7ty8vXnL+6C6nFdxUBXEi645enZK0dFm0wXT83D4ig3dV43wlxvTsVza
 bmmIK81AIKtnqR9jRumANKVkYrc7/q2TN1pWWDxdOubkeqAAUCncJQ2ZRYswu6nsFpig
 tL0GcE709vFaoHNFPlHS3Z4EfBvW5raXSPOa664E/3GpmgIR2g13srcGIaoarbufQueG
 zEj5x7UpZCHzPAqZ5xVsRgDP6Tc+rWFPavX7gT5nfOCdoGkPFvNMx4IlipJKUTptwdZG
 +dnQ==
X-Gm-Message-State: AOJu0YwTp+PdFXwnX/S/ycegmWyClF1g2NW2z5FacaXZ6yiggAiGBnZB
 81UT4oLoXLPmqqPw/wHfoMda69A8zpco4VUNdx1RxaqG14HKnCSW8XvMrks2TX1jlM+FPn5CDVM
 f5wpOlHT/3YWmSEKrLtDtUD2ecGqfVvlqo2rLbU8x1W9Rt5ZP09AAHqLTZSgf5Hdi/Lz6NKd4nh
 82KDSKr6pe7N2M3gT4jBczy9eDaebHbpIo/m0+h1NHjQ==
X-Gm-Gg: ASbGncuzfOG+KfWHWNTOKU/PZ5xAjGiC+YAWd1oFLQ2ul0Stir/55/e3XrJXtezChbR
 FifMOvzrreHwqdRvXNkYfvnoekZQCYIv++LzkJebk5q3KZCBiNRd+uclo8fC8EVKFS29pXlQR42
 CRTiq5CksbULbQC0mdjRiEOls=
X-Received: by 2002:a05:6214:5287:b0:704:9871:495c with SMTP id
 6a1803df08f44-70519fca230mr169466046d6.2.1753092767059; 
 Mon, 21 Jul 2025 03:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zQdHxpLt1/AtCRBlVGmV4/r9v6D3VKqX4KhN+42safiSRzxSSPW9iPZzA9oIipDKs8SrgcYA7scxAy+1szs=
X-Received: by 2002:a05:6214:5287:b0:704:9871:495c with SMTP id
 6a1803df08f44-70519fca230mr169465386d6.2.1753092765840; Mon, 21 Jul 2025
 03:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
In-Reply-To: <87seipkif5.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 21 Jul 2025 13:12:34 +0300
X-Gm-Features: Ac12FXzigt4O_9gqW1QrVydGHN1xoQQtxt_4RUchuSHm9zCw0VpGJv3gkFwq8y0
Message-ID: <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000091148e063a6db730"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--00000000000091148e063a6db730
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 12:22=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
>
> > On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
> >>
> >> > g_win32_error_message - translate a Win32 error code
> >> > (as returned by GetLastError()) into the corresponding message.
> >> >
> >> > In the same time, we call error_setg_win32_internal with
> >> > error codes from different Windows componets like VSS or
> >> > Performance monitor that provides different codes and
> >> > can't be converted with g_win32_error_message.
> >>
> >> Are these error codes from GetLastError()?
> >>
> >
> > No.
> > VSS functions directly return an error code.
> > Section: Return value -
> >
> https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-=
ivssbackupcomponents-addtosnapshotset
> >
> > Performance Counters API can return a system error code or a PDH error
> code.
> > Section: Return value -
> >
> https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-pdhopenque=
ryw
> > System error code =3D GetLastError, PDH error code, something else.
> >
> > https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-code=
s
> > FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.
>
> The error code error_setg_win32() takes is passed to
> g_win32_error_message().  Contract:
>
>     g_win32_error_message ()
>
>     gchar *
>     g_win32_error_message (gint error);
>
>     Translate a Win32 error code (as returned by GetLastError() or
>     WSAGetLastError()) into the corresponding message.  The message is
>     either language neutral, or in the thread's language, or the user's
>     language, the system's language, or US English (see docs for
>     FormatMessage()).  The returned string is in UTF-8.  It should be
>     deallocated with g_free().
>
>     Parameters
>
>         error error code.
>
>     Returns
>
>         newly-allocated error message
>
>
> https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibility=
-Functions.php#g-win32-error-message
>
> Passing error codes from sources other than GetLastError() or
> WSAGetLastError() violates this contract.
>
> Apparently, g_win32_error_message() returns NULL then.  This is not
> documented behavior.
>

It returns an empty string, not NULL.
https://gitlab.gnome.org/GNOME/glib/-/blob/a205d01adc3fbc4f243e0b0fb52a3a0a=
8a0d9ae7/glib/gwin32.c#L216


> Your fix relies on this undocumented behavior.
>

As for me, this behaviour is almost expected (I expected NULL instead of an
empty string) because
g_win32_error_message uses FormatMessage, and FormatMessage returns NULL if
an unknown error code
is provided. And I know this, because FormatMessage is the only way on
Windows to get a human-readable
string from the error code.


>
> I believe we should instead fix the misuses of error_setg_win32().
>

This will be more complicated.
1. I don't know what code was returned by the Performance Counters API
(system or PDH)
2. QGA call error_setg_win32_internal as part of error propagation with
different error codes,
 fix the misuses in this case means have a different error propagator for
different error codes (back to 1)
3. Also, this means that I need to reimplement error_setg_win32_internal
for non-system errors with only
one difference: "unknown Windows error 0x%x" instead of
g_win32_error_message, because anyway
I need the full error propagation part.


> [...]
>
>

--00000000000091148e063a6db730
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 21,=
 2025 at 12:22=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@re=
dhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiu=
k@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" targ=
et=3D"_blank">kkostiuk@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; g_win32_error_message - translate a Win32 error code<br>
&gt;&gt; &gt; (as returned by GetLastError()) into the corresponding messag=
e.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; In the same time, we call error_setg_win32_internal with<br>
&gt;&gt; &gt; error codes from different Windows componets like VSS or<br>
&gt;&gt; &gt; Performance monitor that provides different codes and<br>
&gt;&gt; &gt; can&#39;t be converted with g_win32_error_message.<br>
&gt;&gt;<br>
&gt;&gt; Are these error codes from GetLastError()?<br>
&gt;&gt;<br>
&gt;<br>
&gt; No.<br>
&gt; VSS functions directly return an error code.<br>
&gt; Section: Return value -<br>
&gt; <a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/vsbacku=
p/nf-vsbackup-ivssbackupcomponents-addtosnapshotset" rel=3D"noreferrer" tar=
get=3D"_blank">https://learn.microsoft.com/en-us/windows/win32/api/vsbackup=
/nf-vsbackup-ivssbackupcomponents-addtosnapshotset</a><br>
&gt;<br>
&gt; Performance Counters API can return a system error code or a PDH error=
 code.<br>
&gt; Section: Return value -<br>
&gt; <a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-=
pdh-pdhopenqueryw" rel=3D"noreferrer" target=3D"_blank">https://learn.micro=
soft.com/en-us/windows/win32/api/pdh/nf-pdh-pdhopenqueryw</a><br>
&gt; System error code =3D GetLastError, PDH error code, something else.<br=
>
&gt;<br>
&gt; <a href=3D"https://learn.microsoft.com/en-us/windows/win32/perfctrs/pd=
h-error-codes" rel=3D"noreferrer" target=3D"_blank">https://learn.microsoft=
.com/en-us/windows/win32/perfctrs/pdh-error-codes</a><br>
&gt; FormatMessage requires LoadLibrary(L&quot;pdh.dll&quot;) to work prope=
rly.<br>
<br>
The error code error_setg_win32() takes is passed to<br>
g_win32_error_message().=C2=A0 Contract:<br>
<br>
=C2=A0 =C2=A0 g_win32_error_message ()<br>
<br>
=C2=A0 =C2=A0 gchar *<br>
=C2=A0 =C2=A0 g_win32_error_message (gint error);<br>
<br>
=C2=A0 =C2=A0 Translate a Win32 error code (as returned by GetLastError() o=
r<br>
=C2=A0 =C2=A0 WSAGetLastError()) into the corresponding message.=C2=A0 The =
message is<br>
=C2=A0 =C2=A0 either language neutral, or in the thread&#39;s language, or =
the user&#39;s<br>
=C2=A0 =C2=A0 language, the system&#39;s language, or US English (see docs =
for<br>
=C2=A0 =C2=A0 FormatMessage()).=C2=A0 The returned string is in UTF-8.=C2=
=A0 It should be<br>
=C2=A0 =C2=A0 deallocated with g_free().<br>
<br>
=C2=A0 =C2=A0 Parameters<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error error code.<br>
<br>
=C2=A0 =C2=A0 Returns<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 newly-allocated error message<br>
<br>
<a href=3D"https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Comp=
atibility-Functions.php#g-win32-error-message" rel=3D"noreferrer" target=3D=
"_blank">https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compat=
ibility-Functions.php#g-win32-error-message</a><br>
<br>
Passing error codes from sources other than GetLastError() or<br>
WSAGetLastError() violates this contract.<br>
<br>
Apparently, g_win32_error_message() returns NULL then.=C2=A0 This is not<br=
>
documented behavior.<br></blockquote><div><br></div><div>It returns an empt=
y string, not NULL.</div><div><a href=3D"https://gitlab.gnome.org/GNOME/gli=
b/-/blob/a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216">https=
://gitlab.gnome.org/GNOME/glib/-/blob/a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9=
ae7/glib/gwin32.c#L216</a></div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Your fix relies on this undocumented behavior.<br></blockquote><div><br></d=
iv><div>As for me, this behaviour is almost expected (I expected NULL inste=
ad of an empty string) because</div><div>g_win32_error_message uses FormatM=
essage, and FormatMessage returns NULL if an unknown error code</div><div>i=
s provided. And I know this, because FormatMessage is the only way on Windo=
ws to get a human-readable</div><div>string from the error code.<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I believe we should instead fix the misuses of error_setg_win32().<br></blo=
ckquote><div><br></div><div>This will be more complicated.</div><div>1. I d=
on&#39;t know what code was returned by the Performance Counters API (syste=
m or PDH)</div><div>2. QGA call error_setg_win32_internal as part of error =
propagation with different error codes, <br></div><div>=C2=A0fix the misuse=
s in this case means have a different error propagator for different error =
codes (back to 1)</div><div>3. Also, this means that I need to reimplement =
error_setg_win32_internal for non-system errors with only</div><div>one dif=
ference: &quot;unknown Windows error 0x%x&quot; instead of g_win32_error_me=
ssage, because anyway</div><div>I need the full error propagation part. <br=
></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div>

--00000000000091148e063a6db730--


