Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCA5C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukIJs-0006ke-98; Fri, 08 Aug 2025 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIJI-0006UH-Sp
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ukIJF-0007yx-KC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754641120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9vYFAu1kUyOVMhI08f9XXMNOmpN66Ge3kiIBY53K9o=;
 b=PmJqnOkfWL6e/dRWsSPufeJM1jpl3u/coKKCB/C9aI8DlGCbGxsj2DHDp1n8XFANGW62h4
 9tb5pOwLYlZQ70vEJL2wMiGNIr3i1rSN/1+2ZU7u+MNg10Wz1GuGAVjNww9f+RETS3qgwV
 jEDk1oJsFMq7M9i2g/fIWPG7RlaU6BM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-O-4n7SHAOUy6VfDG86TQwQ-1; Fri, 08 Aug 2025 04:18:39 -0400
X-MC-Unique: O-4n7SHAOUy6VfDG86TQwQ-1
X-Mimecast-MFC-AGG-ID: O-4n7SHAOUy6VfDG86TQwQ_1754641118
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b3f76a5ba7fso1596738a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 01:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754641118; x=1755245918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9vYFAu1kUyOVMhI08f9XXMNOmpN66Ge3kiIBY53K9o=;
 b=FsD584xOv14rdRm/eM8SXVItx2TNDYr4Wz/KmcAzsW2HWlcSAYuOtnN8BSFb69fz90
 cR3lez9VPHo2WpNgoVMQv1tX+b5c5S96ViNBkfktVrwUet6SoOWzpmckOMMyBskuJ2tx
 OfuaJIUOB79QLqqmdtvMz9fAGhZymaeVwJ74sfTQjIP/PxlTlMVd5GP6ekCKnbAIXyyz
 Eh4zQYjv/IDmP7/n8W+0rArqs9EPEp3vq+IgzpZzulhAYpg4zH4Vld/E8BL2UWxMg53a
 PLQ8DELKVyAXPrGEwZylpP0Qu/S6+fczjLviM5Fpg0FYgKTOtAC6/NszJl4OE0q61vuH
 FzWQ==
X-Gm-Message-State: AOJu0Yx9rURegnyeMz8nJ5LBEaT/+7gW6bp48UGU8A1GVsehZ1JikHpM
 PcmxWNfNrTaNHtERUnIwpJk+x10DWqed4LhP4I4Sv9eFFWiazoknGHlE8WGZbjaj8sDHc7biCOi
 PRaEBOkmDrenOm+7LIgBTLJOSpgjX7APeyYi3mZ5nA7xg8RKVkp3gre+CHqTSWNNFKVHKAUITuD
 Cep96pHxPPqcTKWJxeDjxr630VK31lrCQ=
X-Gm-Gg: ASbGncuY5lgZrjtFJkAyidy7dwXU9Fa81LofA5sh/d08SQS76U1rYrzQ0LCJq6+e0We
 uN1ombcxcLAVRGT7YcEByCxtKszEtk0vYUDmIKtxcuOrA70qoDq5VOqpkQkBe5py2k42tHqMk7t
 w8IaKcUsjMrl5U8MrCcsNoPQ==
X-Received: by 2002:a17:90b:48c4:b0:31e:fe18:c6df with SMTP id
 98e67ed59e1d1-32183e32f54mr3599294a91.16.1754641117804; 
 Fri, 08 Aug 2025 01:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE67m7o0tc9tvvvf66WZ02P3HGjHHU13VJeLnMOnFS8cFStYpeD8kI+PjvPLwjkXKFHGXDzzThz9d5mseebrnI=
X-Received: by 2002:a17:90b:48c4:b0:31e:fe18:c6df with SMTP id
 98e67ed59e1d1-32183e32f54mr3599263a91.16.1754641117386; Fri, 08 Aug 2025
 01:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-7-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-7-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 8 Aug 2025 12:18:25 +0400
X-Gm-Features: Ac12FXy9T-441wT04PVB87h1aDi3AJ_urlwZ3Ev5WCwz8AZGV5QGzK_tM5EAE88
Message-ID: <CAMxuvawHmyKityYCzu6yTXRdFkS26ja8o1xtkQE5QFENm9DD-g@mail.gmail.com>
Subject: Re: [PATCH 06/12] net/slirp: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="00000000000082bb00063bd63862"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--00000000000082bb00063bd63862
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 8, 2025 at 12:08=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
> report WSAEventSelect() failure with error_setg(&error_warn, ...).
>
> I'm not familiar with liblirp, so I can't say whether the network
> backend will work after such a failure.  If it doesn't, then this
> should be an error.  If it does, then why bother the user with a
> warning that isn't actionable, and likely confusing?
>

I don't know if this is recoverable either. It's probably not if the handle
is invalid. I guess you could turn it into a non-fatal error.


>
> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> ...)  are.  Replace by warn_report().
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

lgtm, thanks

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  net/slirp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/slirp.c b/net/slirp.c
> index 9657e86a84..d75b09f16b 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -262,7 +262,8 @@ static void
> net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
>      if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
>                         FD_READ | FD_ACCEPT | FD_CLOSE |
>                         FD_CONNECT | FD_WRITE | FD_OOB) !=3D 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to
> WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect(): %s",
> +                    g_win32_error_message(WSAGetLastError()));
>      }
>  #endif
>  }
> @@ -271,7 +272,8 @@ static void
> net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      if (WSAEventSelect(fd, NULL, 0) !=3D 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to
> WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect()",
> +                    g_win32_error_message(WSAGetLastError()));
>      }
>  #endif
>  }
> --
> 2.49.0
>
>

--00000000000082bb00063bd63862
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 20=
25 at 12:08=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">net_slirp_register_poll_sock() and net_slirp_unregi=
ster_poll_sock()<br>
report WSAEventSelect() failure with error_setg(&amp;error_warn, ...).<br>
<br>
I&#39;m not familiar with liblirp, so I can&#39;t say whether the network<b=
r>
backend will work after such a failure.=C2=A0 If it doesn&#39;t, then this<=
br>
should be an error.=C2=A0 If it does, then why bother the user with a<br>
warning that isn&#39;t actionable, and likely confusing?<br></blockquote><d=
iv><br></div><div>I don&#39;t know if this is recoverable either. It&#39;s =
probably not if the handle is invalid. I guess you could turn it into a non=
-fatal error.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Regardless of that, error_setg_win32(&amp;error_warn, ...) is undesirable<b=
r>
just like error_setg(&amp;error_fatal, ...) and error_setg(&amp;error_abort=
,<br>
...)=C2=A0 are.=C2=A0 Replace by warn_report().<br>
<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><div>lgtm, thanks</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9=
 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau=
@redhat.com</a>&gt;</div><div><br></div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0net/slirp.c | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/net/slirp.c b/net/slirp.c<br>
index 9657e86a84..d75b09f16b 100644<br>
--- a/net/slirp.c<br>
+++ b/net/slirp.c<br>
@@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_socke=
t fd, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0if (WSAEventSelect(fd, event_notifier_get_handle(&amp;c=
txt-&gt;notifier),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 FD_READ | FD_ACCEPT | FD_CLOSE |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 FD_CONNECT | FD_WRITE | FD_OOB) !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(&amp;error_warn, WSAGetLastEr=
ror(), &quot;failed to WSAEventSelect()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;failed to WSAEventSelect(): =
%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_wi=
n32_error_message(WSAGetLastError()));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0}<br>
@@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_soc=
ket fd, void *opaque)<br>
=C2=A0{<br>
=C2=A0#ifdef WIN32<br>
=C2=A0 =C2=A0 =C2=A0if (WSAEventSelect(fd, NULL, 0) !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(&amp;error_warn, WSAGetLastEr=
ror(), &quot;failed to WSAEventSelect()&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;failed to WSAEventSelect()&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_wi=
n32_error_message(WSAGetLastError()));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0}<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--00000000000082bb00063bd63862--


