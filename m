Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B26606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GJuj5ULS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r/ASxhJL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Ct-0002KW-Og; Wed, 28 Oct 2026 07:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2Cr-0002K4-Kc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2Cp-0005jq-5X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WpIIqb48FzmpYlUW1qSJaJzUna+YNKH/Y+sjpM4N+k=;
 b=GJuj5ULSrJ5hpJ+QzEwSPbjGA9la7zMAZgx/0cEGvTts4CBnj+KiChB/i0iY+28SEIc+0m
 A7x4Bqc6NUFVbkOg5Zm5s6VG74kleqYhqwhxTi28xNcIxp3Tq+4wsXaZCIeaEBVe04ixr4
 zxrv0AeI7hefJO27n9nnIYvU8vGLefY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Gkb4B3cWOl-FRKdiBcQOHw-1; Wed, 28 Oct 2026 07:52:02 -0400
X-MC-Unique: Gkb4B3cWOl-FRKdiBcQOHw-1
X-Mimecast-MFC-AGG-ID: Gkb4B3cWOl-FRKdiBcQOHw_1793188322
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c7cb9e267so8647316d6.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188322; cv=none;
 d=google.com; s=arc-20260327;
 b=VOPnuSKIPkRbSWyOLbAZaBYyzio/zrtjpBAoJKFBOpEzcOeERvk/56gfdjsYwClIGH
 GPke57BK5c/A5EGYZCEX5+9T/bkGHnq09YOA7zaqjguGfSNUhUiHvPGYZXeJ6vBCJC3j
 XMElR0fgXijLBzUhmLwDGxUREeBAUM02McJBDr+XcUUFYxggsm5H7tWShrnhQVeM+tRf
 CpwoYClXZjEC9ZnsD1xY0oOmS3dsyfRjzfPf31Ws+M5MmLhfRESkEsbbM68FVQygmWYI
 2RKMA5fTIuDQ3SxPlTWKp5VMlDdoKpTIOAc/zxs6OjbVM/0RZVRFNyswfrGHimQcsjoo
 FHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/WpIIqb48FzmpYlUW1qSJaJzUna+YNKH/Y+sjpM4N+k=;
 fh=imijeT+aVG2r2Xt8VOah32Rs98N2YS7U/06n20RFiqo=;
 b=UIviA6glgHx4fpvXHq9knfuRwC6FDWPvsl22Lme+x6Eg1iyHMyKcLcaFw8IcI8cuDJ
 2kUgBIAnx05CpY9uz1SsIhu0eMB+nOBbDp3+tqv3u4PHgJJSlFz6okZnyLecsPG2RgoN
 ShN0M1/Hq0XhQLTgw0tOuRNL7y8J+/ZnLBQF3YdsZfSxO32noBvs00Upjsrv6TPGz1Bx
 1NrKzntiAsPobpddYa5rEWgkoUmrTc0v6+8xfUNqvHBlUeB80Kq13Q06G1j5tXooOzgA
 tLRxGhrx+k1LqQ0JviHZNLNr0iV18Ep7SJL2Et7cyqEAbfF0F8dX1L3QLrFDvPciv4iZ
 zy3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188322; x=1793793122; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/WpIIqb48FzmpYlUW1qSJaJzUna+YNKH/Y+sjpM4N+k=;
 b=r/ASxhJLhjXCETq4lmGa1RS96sv9r0OKGq+yyOHdqqB/f53rLGhRG2rSN8tWRSAw4S
 GLanTeza8a9UxzbW/dKgbmrrPO2Bk0cMfKxgctLKyX1eDPeeSnn/6u6rp40FDtb2gXL9
 Wab0PP807eqc45VHwYp88DRUByw27VuyNLrCYLzURN1lHA1nwUZPIcLDvX18pDQ5x5W2
 TlvWtapnnZmefQQOkYyWvmZ6LgQUdN7ock7odynbIEpmamzDYXeUi17tYV/Zwjtzyaya
 RlGL2BVpkWw+9zgKkCB6NvmDhG/lRjWl8vYCGYQEbs3OlGWE3YDUnbuF0qljTGs0GTHB
 Gjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188322; x=1793793122;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/WpIIqb48FzmpYlUW1qSJaJzUna+YNKH/Y+sjpM4N+k=;
 b=z7EYDUclmBrq3PhtcDq8NaL3Ib3MSdCgi3SBI03E5B+I3pB1KjtdwRSJHhfIOKzz7j
 yHtJb5g9jQ9wuHTGxIoK/bTCxMb+cFLOEY2OFMZmv8TV11EiWEHNRrCApL2j0oE7N/A/
 C2PMjYrrNmFO/9XX0JhqzgsjEs7gFMNnYNhrrDjKzFOdLF/Xnt+MN838WE6pTKOYr2YF
 y1oKjy2Dt92ITNG9XfmQCw18fj/Eeht/Ok/2HtKLpRUKID5mblw7+Rq2GUntI+tmM7ma
 kAeO17PCBZQrxpCG8uv09vBYWZ97UBwuSnzR3Q7/EXSuF92uXVz3jGzlKdDt8lNn8giv
 xWAA==
X-Gm-Message-State: AFq9FYKFniYIPkP1c/xsiIRkNgtu2CxoIGx5/TguJc7JzPzU/hhgp7Qw
 sjSNt7qq5xKCf8pDx08qpMX6SkYcqaW30+N3CgHMXRN35QTxA2/aVeJgRTuTNjiu0NKSCadrb/N
 rXIGyddPBAVIKFPzJiyaUmiHOsoUn4ltgEKuh7uSeiBF3cvyaAG1JvfXounwEgRgnYemwtdwIDX
 TRNHBWskO9FUSxxZBoyFVtdM0Yc8sRnok=
X-Gm-Gg: AYBFou0MiTrTEwaNOLlTYDgLdnFwojRwRJ6rhY/5puZl64yjjSfewj+kIDUsgN9eKPv
 VdqeihtAbjVTqQQJEU0Nl2Lct7DMZ5Jh0FAgC7afMtcT5uKon6urd30gWuhGmJfMl+rt/AjNL2e
 vvrCnbS6Q7/ABAq7+s2lwbRODhviHaED2rBDDMMBWmqqgR2uxkvSmlxdo00tIIGB897q14uU7Bw
 Gjw19GwSDriGnsKUkQVcOB434ff+MlU61umRLmsBZ8VHBjdE269GVxsfCjrXdBGdHLVoXHXjWbO
X-Received: by 2002:ad4:5ccc:0:b0:914:43b1:d4e8 with SMTP id
 6a1803df08f44-91c7cf28521mr33505676d6.10.1793188322100; 
 Wed, 28 Oct 2026 04:52:02 -0700 (PDT)
X-Received: by 2002:ad4:5ccc:0:b0:914:43b1:d4e8 with SMTP id
 6a1803df08f44-91c7cf28521mr33505276d6.10.1793188321436; Wed, 28 Oct 2026
 04:52:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142342.50436-1-bogorodskiy@gmail.com>
 <CAPMcbCpMtRgkWkEPj5xns7xMVCzDOjBcwp8m944q+tTtEPj1Tg@mail.gmail.com>
 <auHU4RuV_XTSV0Vn@tulp>
In-Reply-To: <auHU4RuV_XTSV0Vn@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 13:51:50 +0200
X-Gm-Features: AclHuK-H2Jvegg-CIv-YhXkY_9Y3dba9ieHrK_vKtBZOOFXl1k8IyMkKa4AKl74
Message-ID: <CAPMcbCpCJU=960Jj97nC9uZe+ihAZHe=Goj47YvT-Kde2=mTnw@mail.gmail.com>
Subject: Re: [PATCH v2] qga: do not run hwclock(8) on non-Linux POSIX OSes
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ea38ee065ee5303e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ea38ee065ee5303e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Make sense
Thanks for explanation



Best Regards,
Kostiantyn Kostiuk.


On Wed, Oct 28, 2026 at 12:57=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gma=
il.com>
wrote:

>   Kostiantyn Kostiuk wrote:
>
> > On Thu, Oct 15, 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@=
gmail.com
> >
> > wrote:
> >
> > > Currently, qmp_guest_set_time() sets system time using
> > > the settimeofday(2) system call and then runs the hwclock(8)
> > > util to set hardware time.
> > >
> > > hwclock(8) is Linux only, so current implementation
> > > always fails while trying to run it on non-Linux POSIX OSes,
> > > such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.
> > >
> > > Update the code not to run it on non-Linux. The settimeofday(2)
> > > call sets both system and hardware time on these systems.
> > > For example, on FreeBSD settimeofday() calls settime()
> > > which calls resettodr() [1] which updates RTC clock [2].
> > > It is similar on OpenBSD and NetBSD, though implementations
> > > differ a bit.
> > >
> > > Additional detail: on FreeBSD RTC clock setting can be
> > > disabled with the `machdep.disable_rtc_set` sysctl.
> > > As we cannot do anything about it, do not handle that
> > > case separately.
> > >
> > > Non-Linux POSIX OSes do not provide a common utility
> > > equivalent to hwclock -s, so report an unsupported operation
> > > when no time is supplied.
> > >
> > > 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
> > > 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
> > >
> > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > > ---
> > > Changes since v1:
> > >
> > > Replace "#if defined(CONFIG_BSD)" condition with
> > > "#if !defined(CONFIG_LINUX)" as hwclock(8) is Linux only.
> > >
> > >  qga/commands-posix.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index 837e285b6d..ffd1744b74 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t
> > > time_ns, Error **errp)
> > >          }
> > >      }
> > >
> > > +#if !defined(CONFIG_LINUX)
> > > +    /*
> > > +     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
> > > +     * hwclock(8) tool. These systems update hardware clock when
> > > +     * settimeofday() sets system time, so no additional actions
> > > +     * are needed. Setting system time from RTC is not supported.
> > > +     */
> > > +    if (!has_time) {
> > > +        error_setg(errp, "Setting system time from RTC is not
> supported");
> > > +    }
> > > +
> > > +    return;
> > > +#endif
> > > +
> > >
> >
> > As only Linux (not POSIX) and Windows support this function
> > lets move qmp_guest_set_time to commands-linux and update QAPI with
> > 'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>
> Hi Kostiantyn,
>
> Sorry if my commit message does not explain the situation clearly enough.
>
> BSDs and illumos do support "guest-set-time" with "time" specified.
> On these systems, calling settimeofday() is enough for that, it sets
> both system time and hardware clock, so lack of the hwclock(8) does not
> prevent it from working as intended.
>
> Only "guest-set-time" without the "time" argument (i.e. setting system ti=
me
> from the hardware clock) is not supported indeed, which we indicate with
> an error message.
>
> Therefore I think keeping qmp_guest_set_time() in commands-posix.c and
> keeping the proposed conditional behavior is appropriate.
>
> >
> > Best Regards,
> > Kostiantyn Kostiuk.
>
>

--000000000000ea38ee065ee5303e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Make sense=C2=A0<br></div><div>Thanks for explanation=
<br><br></div><div><br><br></div><div><div dir=3D"ltr" class=3D"gmail_signa=
ture" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards=
,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, Oct 28, 2026 at 12:57=E2=80=AFPM Roman Bogorodskiy &lt;<a hre=
f=3D"mailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Kostiantyn K=
ostiuk wrote:<br>
<br>
&gt; On Thu, Oct 15, 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy &lt;<a href=
=3D"mailto:bogorodskiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Currently, qmp_guest_set_time() sets system time using<br>
&gt; &gt; the settimeofday(2) system call and then runs the hwclock(8)<br>
&gt; &gt; util to set hardware time.<br>
&gt; &gt;<br>
&gt; &gt; hwclock(8) is Linux only, so current implementation<br>
&gt; &gt; always fails while trying to run it on non-Linux POSIX OSes,<br>
&gt; &gt; such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.<br>
&gt; &gt;<br>
&gt; &gt; Update the code not to run it on non-Linux. The settimeofday(2)<b=
r>
&gt; &gt; call sets both system and hardware time on these systems.<br>
&gt; &gt; For example, on FreeBSD settimeofday() calls settime()<br>
&gt; &gt; which calls resettodr() [1] which updates RTC clock [2].<br>
&gt; &gt; It is similar on OpenBSD and NetBSD, though implementations<br>
&gt; &gt; differ a bit.<br>
&gt; &gt;<br>
&gt; &gt; Additional detail: on FreeBSD RTC clock setting can be<br>
&gt; &gt; disabled with the `machdep.disable_rtc_set` sysctl.<br>
&gt; &gt; As we cannot do anything about it, do not handle that<br>
&gt; &gt; case separately.<br>
&gt; &gt;<br>
&gt; &gt; Non-Linux POSIX OSes do not provide a common utility<br>
&gt; &gt; equivalent to hwclock -s, so report an unsupported operation<br>
&gt; &gt; when no time is supplied.<br>
&gt; &gt;<br>
&gt; &gt; 1: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/kern_tim=
e.c" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree=
/sys/kern/kern_time.c</a><br>
&gt; &gt; 2: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc=
.c" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree/=
sys/kern/subr_rtc.c</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodski=
y@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Changes since v1:<br>
&gt; &gt;<br>
&gt; &gt; Replace &quot;#if defined(CONFIG_BSD)&quot; condition with<br>
&gt; &gt; &quot;#if !defined(CONFIG_LINUX)&quot; as hwclock(8) is Linux onl=
y.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 qga/commands-posix.c | 14 ++++++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 14 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; &gt; index 837e285b6d..ffd1744b74 100644<br>
&gt; &gt; --- a/qga/commands-posix.c<br>
&gt; &gt; +++ b/qga/commands-posix.c<br>
&gt; &gt; @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64=
_t<br>
&gt; &gt; time_ns, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +#if !defined(CONFIG_LINUX)<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* BSDs (FreeBSD, OpenBSD, NetBSD) and illumo=
s do not have the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* hwclock(8) tool. These systems update hard=
ware clock when<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* settimeofday() sets system time, so no add=
itional actions<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* are needed. Setting system time from RTC i=
s not supported.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!has_time) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Setting syste=
m time from RTC is not supported&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return;<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt;<br>
&gt; <br>
&gt; As only Linux (not POSIX) and Windows support this function<br>
&gt; lets move qmp_guest_set_time to commands-linux and update QAPI with<br=
>
&gt; &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG_WI=
N32&#39;] }<br>
<br>
Hi Kostiantyn,<br>
<br>
Sorry if my commit message does not explain the situation clearly enough.<b=
r>
<br>
BSDs and illumos do support &quot;guest-set-time&quot; with &quot;time&quot=
; specified.<br>
On these systems, calling settimeofday() is enough for that, it sets<br>
both system time and hardware clock, so lack of the hwclock(8) does not<br>
prevent it from working as intended.<br>
<br>
Only &quot;guest-set-time&quot; without the &quot;time&quot; argument (i.e.=
 setting system time<br>
from the hardware clock) is not supported indeed, which we indicate with<br=
>
an error message.<br>
<br>
Therefore I think keeping qmp_guest_set_time() in commands-posix.c and<br>
keeping the proposed conditional behavior is appropriate.<br>
<br>
&gt; <br>
&gt; Best Regards,<br>
&gt; Kostiantyn Kostiuk.<br>
<br>
</blockquote></div>

--000000000000ea38ee065ee5303e--


