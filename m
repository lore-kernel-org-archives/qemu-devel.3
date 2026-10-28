Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B57606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbOIX8Vb;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QoQfC3W1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzZn-0001NB-TL; Wed, 28 Oct 2026 05:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzZj-0001Kd-Qy
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzZh-0003fF-Li
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793178240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CsFQjtW5LYaemcg6vwHio0sZ4xOC2EVPBz46SD8lv6w=;
 b=QbOIX8Vb0d7gyx1FcS/Ddp19x0qz/3Bqs7H7t7tHM7fGHCqSJRJxepKLpDzbhvZM9ovcTK
 vgRYN3VJh3SL+CxN0AsYJ3R2hOZhRNI0F3H3lR3PNMyU1Ap0NCsfT3Ar5HH8LSYTp4UYPt
 6NM1Xia72IlxoIF4JEtC2pBUQmqU1Fk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-FOVAdT9yO_C4kwy1u8TuZg-1; Wed, 28 Oct 2026 05:03:58 -0400
X-MC-Unique: FOVAdT9yO_C4kwy1u8TuZg-1
X-Mimecast-MFC-AGG-ID: FOVAdT9yO_C4kwy1u8TuZg_1793178238
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535066512b0so10947001cf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178238; cv=none;
 d=google.com; s=arc-20260327;
 b=X4MWP1xRZUl+R09xStImDLKr4RMNvBewH8RY75RdVQ9tswHiU+vc+/g2wHm/1Nda5q
 765emLccnXilCuwhZlnp6tOf+36qLCHiHLWCq0C+0UkrDaRgPUvRCnwAWgwLRiFxkv+O
 opZ4ms1X6Kr3gfBQ63rB8RwKivbs24gowFMhJgkHT8aT+gaqSXRJMLnjzGGpT4/wAe8F
 yPUqr1DR5w35P7DlJ/qhQcVmrCR2OeDh0IcugjVg+se4X9hxjCz0zSdaff0TMZp/KPC6
 gmtK4onmsa224sGmyo49rw6sjdfD2oNZYqggJksG7+AL+hETcmaEb15g+qCuxpQPqxZk
 lpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CsFQjtW5LYaemcg6vwHio0sZ4xOC2EVPBz46SD8lv6w=;
 fh=imijeT+aVG2r2Xt8VOah32Rs98N2YS7U/06n20RFiqo=;
 b=HNMMmlb1PQxUc55QsnsxD53Z9S6rSM3+BEWbLIE+Mn7CkdqMnCn72Oyii7RjfgW/Mt
 6B99z63RtWxu3NwpH6Ri9CHWeFBqt+OtKhdQLac0c9M9dR3xYvo0Y81eTO+4NUp9dqeM
 POY7O3tyRUE07k0uqoPY39QAFFkrWUTFCParCBbm/mhaEXQnndjPlOcWcz2BftxKGMrb
 RwFz6fjRBsyKK2SfUZeZNa7BXYkA9jr80f+QnFm+fBJ069h8f+/feqFU66NRFv7pFydq
 UWB/2q34rTqKvKEhVxKuzW4xZqoJk4EI0d9rhQ8qSjTFkAVZgZxNNr3shqnAw3i9ECyK
 piYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793178238; x=1793783038; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CsFQjtW5LYaemcg6vwHio0sZ4xOC2EVPBz46SD8lv6w=;
 b=QoQfC3W1XAS/TvpPwNcKC9VyvWGowZFDxdeoJ8njd38pzrg6YA2FctXv6/12jZJpTZ
 pV5R8OmOdkX8MvhuU2mdPEMUEpieXeYLd2ADUJz3NV77HXpuC4+augzE883psSJ/9Wwl
 +Jy9cFI8EzEY3EdDN1fs/EfeH25KV7gaBqfsTgIKWr4BNhiJDdtwrvlOpdzqcfEMHcW7
 HFbPp1KKdTDT9wfu0fN0lb5R7tc05B7IaES7kchnW1IKAkw7MoSQDeQ0GHPtKstPZM9W
 KHZn/LClu4RGP0K4rjUiait6snvD0zilXuqe8GrEHbfb2A/ij78/K4gh2T8G45qNhJXn
 p4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793178238; x=1793783038;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CsFQjtW5LYaemcg6vwHio0sZ4xOC2EVPBz46SD8lv6w=;
 b=Kirgb09XplC8UZmpZPNMAR/iX8gnJa938qRsXfmRJUxFiLAx0Alq61D6CPkrDzVR/r
 GRYkclPDuUace9EV40B+lzNkfP9KT0WtLN5RCgS4Cd+nE0OLGRPx1ZPbJjVsYd8v74Yp
 3XVT/sCZvmoJUT59y5pYE1WXS/PRjIPnvSQ6gudofdCrpTfSLOrLSoWed3MBKfKBSMg+
 /ZfcVrjDG5+HeJaWPf8maYTmJCCnBq6r6E3diQuzFK2t6n10Qfq/62hZEkMCits02X1O
 XaB7QcdGxVC7GtjK3lTq9u9QsfqTki6alT/eMKGTD3GQdi/E4M5GpLpo582hXaNcbWTp
 1sHw==
X-Gm-Message-State: AFq9FYIDnSyo4CTzBGN+EbPdnY5xShv4IgRawN3uzvp3BfvNJCRd6wYU
 21wpN6ZTxKM+oYzj2HTC4Rqo+VuxbUxymHKf6b3YrLdbWPH9+Sf7KMq480lwZSrHt3T7QB79Jdu
 URnvukc94FJAYqYxQTqUZYX9TIWQqrsvtEmX8Elfjxi8ZKITSdrvi9mYwacvJ5AyKAT127mKwiB
 L1Q6geZXWd7NpNPf3P6z+fwwg9vzfTFUU=
X-Gm-Gg: AYBFou1/FnnGCDZxaznwLLhUDcFxMmMDOZroObb/Q/Yk+lz9VHGLyN1iFankpBij5WA
 x1o/DtP5yHIuSCdlJwFDQSThK95lTYBY8cGhm83IiybMFdBWH7+9Ld3eYhMK2dfsmdgFYUEcqea
 5GOs7fBsgFOPuPGJkmFyvJ2U3h8qPxwWvld8XtXDjgS1tmAPmgsmQNWY99q0JMCDPOUckIDAgRq
 NfYz44CxG5smO8vrVc=
X-Received: by 2002:a05:622a:342:b0:536:5f01:7016 with SMTP id
 d75a77b69052e-53fcb8f2ebcmr31589791cf.38.1793178237436; 
 Wed, 28 Oct 2026 02:03:57 -0700 (PDT)
X-Received: by 2002:a05:622a:342:b0:536:5f01:7016 with SMTP id
 d75a77b69052e-53fcb8f2ebcmr31589361cf.38.1793178236833; Wed, 28 Oct 2026
 02:03:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142342.50436-1-bogorodskiy@gmail.com>
In-Reply-To: <20261015142342.50436-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 11:03:45 +0200
X-Gm-Features: AclHuK80sj4VqgePRwD7Q28S3QzpsIW8h1AC3OZXiTNuErE-opI_IvJJM5xprRQ
Message-ID: <CAPMcbCpMtRgkWkEPj5xns7xMVCzDOjBcwp8m944q+tTtEPj1Tg@mail.gmail.com>
Subject: Re: [PATCH v2] qga: do not run hwclock(8) on non-Linux POSIX OSes
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000d362d9065ee2d732"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000d362d9065ee2d732
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

> Currently, qmp_guest_set_time() sets system time using
> the settimeofday(2) system call and then runs the hwclock(8)
> util to set hardware time.
>
> hwclock(8) is Linux only, so current implementation
> always fails while trying to run it on non-Linux POSIX OSes,
> such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.
>
> Update the code not to run it on non-Linux. The settimeofday(2)
> call sets both system and hardware time on these systems.
> For example, on FreeBSD settimeofday() calls settime()
> which calls resettodr() [1] which updates RTC clock [2].
> It is similar on OpenBSD and NetBSD, though implementations
> differ a bit.
>
> Additional detail: on FreeBSD RTC clock setting can be
> disabled with the `machdep.disable_rtc_set` sysctl.
> As we cannot do anything about it, do not handle that
> case separately.
>
> Non-Linux POSIX OSes do not provide a common utility
> equivalent to hwclock -s, so report an unsupported operation
> when no time is supplied.
>
> 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
> 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
> Changes since v1:
>
> Replace "#if defined(CONFIG_BSD)" condition with
> "#if !defined(CONFIG_LINUX)" as hwclock(8) is Linux only.
>
>  qga/commands-posix.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837e285b6d..ffd1744b74 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t
> time_ns, Error **errp)
>          }
>      }
>
> +#if !defined(CONFIG_LINUX)
> +    /*
> +     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
> +     * hwclock(8) tool. These systems update hardware clock when
> +     * settimeofday() sets system time, so no additional actions
> +     * are needed. Setting system time from RTC is not supported.
> +     */
> +    if (!has_time) {
> +        error_setg(errp, "Setting system time from RTC is not supported"=
);
> +    }
> +
> +    return;
> +#endif
> +
>

As only Linux (not POSIX) and Windows support this function
lets move qmp_guest_set_time to commands-linux and update QAPI with
'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }


Best Regards,
Kostiantyn Kostiuk.



>      /* Now, if user has passed a time to set and the system time is set,
> we
>       * just need to synchronize the hardware clock. However, if no time
> was
>       * passed, user is requesting the opposite: set the system time from
> the
> --
> 2.55.0
>
>

--000000000000d362d9065ee2d732
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15,=
 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodski=
y@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Currently, qmp_guest_set_time() sets syst=
em time using<br>
the settimeofday(2) system call and then runs the hwclock(8)<br>
util to set hardware time.<br>
<br>
hwclock(8) is Linux only, so current implementation<br>
always fails while trying to run it on non-Linux POSIX OSes,<br>
such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.<br>
<br>
Update the code not to run it on non-Linux. The settimeofday(2)<br>
call sets both system and hardware time on these systems.<br>
For example, on FreeBSD settimeofday() calls settime()<br>
which calls resettodr() [1] which updates RTC clock [2].<br>
It is similar on OpenBSD and NetBSD, though implementations<br>
differ a bit.<br>
<br>
Additional detail: on FreeBSD RTC clock setting can be<br>
disabled with the `machdep.disable_rtc_set` sysctl.<br>
As we cannot do anything about it, do not handle that<br>
case separately.<br>
<br>
Non-Linux POSIX OSes do not provide a common utility<br>
equivalent to hwclock -s, so report an unsupported operation<br>
when no time is supplied.<br>
<br>
1: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c" rel=
=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree/sys/ker=
n/kern_time.c</a><br>
2: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c" rel=3D=
"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree/sys/kern/s=
ubr_rtc.c</a><br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
---<br>
Changes since v1:<br>
<br>
Replace &quot;#if defined(CONFIG_BSD)&quot; condition with<br>
&quot;#if !defined(CONFIG_LINUX)&quot; as hwclock(8) is Linux only.<br>
<br>
=C2=A0qga/commands-posix.c | 14 ++++++++++++++<br>
=C2=A01 file changed, 14 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 837e285b6d..ffd1744b74 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns=
, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#if !defined(CONFIG_LINUX)<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not h=
ave the<br>
+=C2=A0 =C2=A0 =C2=A0* hwclock(8) tool. These systems update hardware clock=
 when<br>
+=C2=A0 =C2=A0 =C2=A0* settimeofday() sets system time, so no additional ac=
tions<br>
+=C2=A0 =C2=A0 =C2=A0* are needed. Setting system time from RTC is not supp=
orted.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!has_time) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Setting system time fro=
m RTC is not supported&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return;<br>
+#endif<br>
+<br></blockquote><div><br></div><div>As only Linux (not POSIX) and Windows=
 support this function</div><div>lets move=C2=A0qmp_guest_set_time to=C2=A0=
commands-linux and update QAPI with</div><div><div>&#39;if&#39;: { &#39;any=
&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG_WIN32&#39;] }</div><div><br></d=
iv><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div>=
</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
=C2=A0 =C2=A0 =C2=A0/* Now, if user has passed a time to set and the system=
 time is set, we<br>
=C2=A0 =C2=A0 =C2=A0 * just need to synchronize the hardware clock. However=
, if no time was<br>
=C2=A0 =C2=A0 =C2=A0 * passed, user is requesting the opposite: set the sys=
tem time from the<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000d362d9065ee2d732--


