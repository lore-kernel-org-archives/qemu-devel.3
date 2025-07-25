Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FFFC87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufFDA-0000ap-4r; Fri, 25 Jul 2025 05:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ufFD2-0000TY-Se
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ufFCx-0001r8-48
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753437555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07e8GqMSMwUqCTgqlqzBntBEnHTNY1nfJdmK7DnZNqk=;
 b=ME53YdBktU1EqRP16FZd98lG3+ZVVvB2ShCNvGEQogJ1L7iloKLJPA9v+5sLFu2UZU954v
 DSjMeKxWLNrQAZTfbixGxwoXYQxJ9sZ2IfQIlwO/RzEr2mDTNpfKavfbTeBnpGCXGk3397
 X5Gj2rIUm0hraP+faI6P5HI3dQ1m6vM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-bImsJrVFM9OQHnIs2cl3cQ-1; Fri, 25 Jul 2025 05:59:13 -0400
X-MC-Unique: bImsJrVFM9OQHnIs2cl3cQ-1
X-Mimecast-MFC-AGG-ID: bImsJrVFM9OQHnIs2cl3cQ_1753437553
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fab979413fso35520856d6.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753437553; x=1754042353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07e8GqMSMwUqCTgqlqzBntBEnHTNY1nfJdmK7DnZNqk=;
 b=aZWN6v8V+Bw5X4CTmHBput1KJeeuhiRopsaxO3oZ5rqH6Loy6BhFzDQS272MVOhZ5S
 05VSGY1McXxHsJb7Zziy8puh7zljhLG93KiHnFYU9vhXixG6srIVI6cy1cVWht5X5KoP
 j92o4kNr52/EJyFzFexDZK+w4xktZgQNGt2YY77juOY4d5T+imehxZ140j7wSKpo9ZtI
 BQmcMCPyKLrM+F8ynjPYw9AIv167jAER14Iyk2O27+4+qJ8wYsOIZlTgwWFP28nPwp4m
 7JlZJ0DJCF+itb4TJ+i41CDECJkxZ/DKetFRWblay1/YkndQG5Dubd/YLE+RXAnnwvN+
 d1dg==
X-Gm-Message-State: AOJu0YyM8pxUX1secob95PdzGzH34cSYkc894dk/q1NoqRom4vMfpCMO
 kKu6ufOWquWPFeoXV/Jp1tIeu8q/IuncH7Vc+43MJjv5s3lI1MkKOSoh6SQ1t16CgIy4yl3lrx7
 9pQ0963U7q8FiGXOpFHptLsnNhOYf9XDQDHyIJzSwEc9i8LVSTFFjf75+TnKK6rARljEiaSptVM
 k5NRPfieckZcBozNm613hbd28Pu/TMn5s=
X-Gm-Gg: ASbGncuLLUmj4qfWDWLlAVFBZ9dvARXshIbJ3fvCMHi4tAOXL3rV97ns75UYM90JxZu
 pshXSH27/hPlBkWFfnVZgQfLsjWVw9omawe1+t/lnMuzL8uv9bUdB4YXw1iYxvf02AU9DBSzh5r
 itOCZP3W8NV2GSTQNsBB04tI8=
X-Received: by 2002:ad4:5cec:0:b0:700:c39c:9d12 with SMTP id
 6a1803df08f44-707205ea7d6mr12961346d6.43.1753437553093; 
 Fri, 25 Jul 2025 02:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxaxOCZ0/Ta1ZD2W+nH3+Z65QNOggZG1+y0BiO/z/AbKu7tXxSZGyyjMoMHUkj7fOouoCVGvxmngVJgcb6BYk=
X-Received: by 2002:ad4:5cec:0:b0:700:c39c:9d12 with SMTP id
 6a1803df08f44-707205ea7d6mr12961116d6.43.1753437552645; Fri, 25 Jul 2025
 02:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
 <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
In-Reply-To: <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 25 Jul 2025 12:59:00 +0300
X-Gm-Features: Ac12FXwxlgs9sMv1uVM36RpblRpq_bKnnDtj-orbtlJ3Se2FBXuDpQ99uPIIh-M
Message-ID: <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000762d08063abdfe9d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--000000000000762d08063abdfe9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Issue reported to GLib https://gitlab.gnome.org/GNOME/glib/-/issues/3740
PR with fix https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716

@Markus Armbruster <armbru@redhat.com>
Based on the documentation from this PR, do you have any other objections
to this patch?

Best Regards,
Konstantin Kostiuk.


On Mon, Jul 21, 2025 at 2:53=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 21/7/25 12:12, Kostiantyn Kostiuk wrote:
> >
> >
> > On Mon, Jul 21, 2025 at 12:22=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com
> > <mailto:armbru@redhat.com>> wrote:
> >
> >     Kostiantyn Kostiuk <kkostiuk@redhat.com
> >     <mailto:kkostiuk@redhat.com>> writes:
> >
> >      > On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster
> >     <armbru@redhat.com <mailto:armbru@redhat.com>> wrote:
> >      >
> >      >> Kostiantyn Kostiuk <kkostiuk@redhat.com
> >     <mailto:kkostiuk@redhat.com>> writes:
> >      >>
> >      >> > g_win32_error_message - translate a Win32 error code
> >      >> > (as returned by GetLastError()) into the corresponding messag=
e.
> >      >> >
> >      >> > In the same time, we call error_setg_win32_internal with
> >      >> > error codes from different Windows componets like VSS or
> >      >> > Performance monitor that provides different codes and
> >      >> > can't be converted with g_win32_error_message.
> >      >>
> >      >> Are these error codes from GetLastError()?
> >      >>
> >      >
> >      > No.
> >      > VSS functions directly return an error code.
> >      > Section: Return value -
> >      > https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-
> >     vsbackup-ivssbackupcomponents-addtosnapshotset <https://
> >     learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-
> >     ivssbackupcomponents-addtosnapshotset>
> >      >
> >      > Performance Counters API can return a system error code or a PDH
> >     error code.
> >      > Section: Return value -
> >      > https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-
> >     pdhopenqueryw <https://learn.microsoft.com/en-us/windows/win32/api/
> >     pdh/nf-pdh-pdhopenqueryw>
> >      > System error code =3D GetLastError, PDH error code, something el=
se.
> >      >
> >      > https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-
> >     error-codes <https://learn.microsoft.com/en-us/windows/win32/
> >     perfctrs/pdh-error-codes>
> >      > FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.
> >
> >     The error code error_setg_win32() takes is passed to
> >     g_win32_error_message().  Contract:
> >
> >          g_win32_error_message ()
> >
> >          gchar *
> >          g_win32_error_message (gint error);
> >
> >          Translate a Win32 error code (as returned by GetLastError() or
> >          WSAGetLastError()) into the corresponding message.  The messag=
e
> is
> >          either language neutral, or in the thread's language, or the
> user's
> >          language, the system's language, or US English (see docs for
> >          FormatMessage()).  The returned string is in UTF-8.  It should
> be
> >          deallocated with g_free().
> >
> >          Parameters
> >
> >              error error code.
> >
> >          Returns
> >
> >              newly-allocated error message
> >
> >     https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-
> >     Compatibility-Functions.php#g-win32-error-message <https://
> >     www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibility-
> >     Functions.php#g-win32-error-message>
> >
> >     Passing error codes from sources other than GetLastError() or
> >     WSAGetLastError() violates this contract.
> >
> >     Apparently, g_win32_error_message() returns NULL then.  This is not
> >     documented behavior.
> >
> >
> > It returns an empty string, not NULL.
> > https://gitlab.gnome.org/GNOME/glib/-/blob/
> > a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216 <https://
> > gitlab.gnome.org/GNOME/glib/-/blob/
> > a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216>
>
> Worth reporting to GLib IMHO.
>
>

--000000000000762d08063abdfe9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Issue reported to GLib <a href=3D"https://gitlab.gnom=
e.org/GNOME/glib/-/issues/3740">https://gitlab.gnome.org/GNOME/glib/-/issue=
s/3740</a></div><div>PR with fix <a href=3D"https://gitlab.gnome.org/GNOME/=
glib/-/merge_requests/4716">https://gitlab.gnome.org/GNOME/glib/-/merge_req=
uests/4716</a></div><div><br></div><div><a class=3D"gmail_plusreply" id=3D"=
plusReplyChip-0" href=3D"mailto:armbru@redhat.com" tabindex=3D"-1">@Markus =
Armbruster</a>=C2=A0<br></div><div>Based on the documentation from this PR,=
 do you have any other objections to this patch?<br></div><div><br></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</di=
v></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 21, 2025 at 2:53=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 21/7/25 12:12, Kostiantyn Kostiuk wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, Jul 21, 2025 at 12:22=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armb=
ru@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@r=
edhat.com" target=3D"_blank">kkostiuk@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" t=
arget=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt; writes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Marku=
s Armbruster<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:armbru@redhat.com" target=3D"=
_blank">armbru@redhat.com</a> &lt;mailto:<a href=3D"mailto:armbru@redhat.co=
m" target=3D"_blank">armbru@redhat.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Kostiantyn Kostiuk &lt;<a href=3D"mailto:=
kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:kkostiuk@redhat.com" t=
arget=3D"_blank">kkostiuk@redhat.com</a>&gt;&gt; writes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; g_win32_error_message - translate a =
Win32 error code<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; (as returned by GetLastError()) into=
 the corresponding message.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; In the same time, we call error_setg=
_win32_internal with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; error codes from different Windows c=
omponets like VSS or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; Performance monitor that provides di=
fferent codes and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &gt; can&#39;t be converted with g_win32_=
error_message.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Are these error codes from GetLastError()=
?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; No.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; VSS functions directly return an error code.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Section: Return value -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://learn.microsoft.com/en-us/=
windows/win32/api/vsbackup/nf-" rel=3D"noreferrer" target=3D"_blank">https:=
//learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0vsbackup-ivssbackupcomponents-addtosnapshotset &lt;=
https://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://learn.microsoft.com/en-us/windows=
/win32/api/vsbackup/nf-vsbackup-" rel=3D"noreferrer" target=3D"_blank">lear=
n.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0ivssbackupcomponents-addtosnapshotset&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Performance Counters API can return a system =
error code or a PDH<br>
&gt;=C2=A0 =C2=A0 =C2=A0error code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Section: Return value -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://learn.microsoft.com/en-us/=
windows/win32/api/pdh/nf-pdh-" rel=3D"noreferrer" target=3D"_blank">https:/=
/learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0pdhopenqueryw &lt;<a href=3D"https://learn.microsof=
t.com/en-us/windows/win32/api/" rel=3D"noreferrer" target=3D"_blank">https:=
//learn.microsoft.com/en-us/windows/win32/api/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0pdh/nf-pdh-pdhopenqueryw&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; System error code =3D GetLastError, PDH error=
 code, something else.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://learn.microsoft.com/en-us/=
windows/win32/perfctrs/pdh-" rel=3D"noreferrer" target=3D"_blank">https://l=
earn.microsoft.com/en-us/windows/win32/perfctrs/pdh-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0error-codes &lt;<a href=3D"https://learn.microsoft.=
com/en-us/windows/win32/" rel=3D"noreferrer" target=3D"_blank">https://lear=
n.microsoft.com/en-us/windows/win32/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0perfctrs/pdh-error-codes&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; FormatMessage requires LoadLibrary(L&quot;pdh=
.dll&quot;) to work properly.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The error code error_setg_win32() takes is passed t=
o<br>
&gt;=C2=A0 =C2=A0 =C2=A0g_win32_error_message().=C2=A0 Contract:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_win32_error_message ()<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_win32_error_message (gint error);<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Translate a Win32 error code (as ret=
urned by GetLastError() or<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WSAGetLastError()) into the correspo=
nding message.=C2=A0 The message is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 either language neutral, or in the t=
hread&#39;s language, or the user&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 language, the system&#39;s language,=
 or US English (see docs for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FormatMessage()).=C2=A0 The returned=
 string is in UTF-8.=C2=A0 It should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deallocated with g_free().<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Parameters<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error error code.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newly-allocated error =
message<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.manpagez.com/html/glib/glib-=
2.46.0/glib-Windows-" rel=3D"noreferrer" target=3D"_blank">https://www.manp=
agez.com/html/glib/glib-2.46.0/glib-Windows-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Compatibility-Functions.php#g-win32-error-message &=
lt;https://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.manpagez.com/html/glib/glib-2=
.46.0/glib-Windows-Compatibility-" rel=3D"noreferrer" target=3D"_blank">www=
.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibility-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Functions.php#g-win32-error-message&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Passing error codes from sources other than GetLast=
Error() or<br>
&gt;=C2=A0 =C2=A0 =C2=A0WSAGetLastError() violates this contract.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Apparently, g_win32_error_message() returns NULL th=
en.=C2=A0 This is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0documented behavior.<br>
&gt; <br>
&gt; <br>
&gt; It returns an empty string, not NULL.<br>
&gt; <a href=3D"https://gitlab.gnome.org/GNOME/glib/-/blob/" rel=3D"norefer=
rer" target=3D"_blank">https://gitlab.gnome.org/GNOME/glib/-/blob/</a> <br>
&gt; a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216 &lt;https:=
// <br>
&gt; <a href=3D"http://gitlab.gnome.org/GNOME/glib/-/blob/" rel=3D"noreferr=
er" target=3D"_blank">gitlab.gnome.org/GNOME/glib/-/blob/</a> <br>
&gt; a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216&gt;<br>
<br>
Worth reporting to GLib IMHO.<br>
<br>
</blockquote></div>

--000000000000762d08063abdfe9d--


