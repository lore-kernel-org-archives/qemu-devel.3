Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E7AE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlhj-0005Fk-3m; Wed, 04 Dec 2024 04:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlhh-0005CJ-QA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlhg-0006IH-52
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733304591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dicWub2SQBAtsK8i16eRhXFVuTql6558Wl7544FMwRs=;
 b=FvwmCZrtn99yqQY7OU2CiCukJmlxYwujF8BmasPR1dpVzzqATV3ssMRrDYz/oxepg/fi/n
 ch0WpGmN1V1h2Md1uLrv1Tti+f07SCQthnG++LBzem+g+UIhPkckNXPtz4O2zgoe4EsnYi
 vHhxTuB96XOvN9vVpBs2+8ZVUJdeMRk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-DsCcYoV7NFi1uxtRXrfidA-1; Wed, 04 Dec 2024 04:29:49 -0500
X-MC-Unique: DsCcYoV7NFi1uxtRXrfidA-1
X-Mimecast-MFC-AGG-ID: DsCcYoV7NFi1uxtRXrfidA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d884e46548so76938356d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733304589; x=1733909389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dicWub2SQBAtsK8i16eRhXFVuTql6558Wl7544FMwRs=;
 b=c8npX9N55IfNQlUtF2zXCUWr+5XMgY3SrJ1pBOZ6cBlkZz1AIbOIFw6p6WOiCLBGi2
 eK6w1xwq6ScZXibbz1lyFAEMlhv7z6r5Z4QiIxude8nTN0VfoA8NTa9sXsjvWK2TjHlx
 mKc/DZxFg3vajX6eaQCRjAC5aYSdOB85EE932CqWMDuCkwFFy41MWUReUlE0P2APlMgx
 +Wy6N+qdX+oM2GaR3kB5iJ1OJ9lHV9Adh+Y7w9Nge0zKBJmoYOkYr8GhMWqS5WPtKwkh
 Aug+SVZZi9UMksHhu6Qyc6A/zMCIJOgckNwwxt/+IuHD5+kUBiDm62tO3Di6d+o5sunC
 FWJg==
X-Gm-Message-State: AOJu0Yxdl8nZjy/yD/y225prScBoopqnI+CzLCuxH6VyAlm4Z+/v3OMy
 ekb7SUUP+cPsSyZuZ0+NVoaqQWb1KURiS2e+TZMgtVIRShPagoc6wu7RmP+YAJUzSILErR52kKU
 vCIxoeJ6sQRPvKkH6qYNCaam3hYzA3YSqF65ZMUIZ+vLjTKJrEtSdbExfzLGCcLziuFen7ctlH7
 kx7JfJnAYcv8vTZsysUFkheyj2pbA=
X-Gm-Gg: ASbGnctCl6n72qY8Rw68L0n/8MjnTPmrT/z0dAhx3IEm/vDre55tb7njPZKDGaXXwAf
 QDWAHmEAAuBRKNl6cM7La8c+1ylzHwNND5A==
X-Received: by 2002:a05:6214:d44:b0:6d8:a48e:a027 with SMTP id
 6a1803df08f44-6d8b72e377dmr97575676d6.2.1733304589159; 
 Wed, 04 Dec 2024 01:29:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq3BY7QGltLJUUCwQzlja2B0XdfGAPVFzQSASwb4dy/HQ61Gz/tnfaf5/ngah5rIhVGrWIGlP3AlsDCqI4LqE=
X-Received: by 2002:a05:6214:d44:b0:6d8:a48e:a027 with SMTP id
 6a1803df08f44-6d8b72e377dmr97575546d6.2.1733304588909; Wed, 04 Dec 2024
 01:29:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730713917.git.mprivozn@redhat.com>
 <780bf01dec69fa68b8fe5a9c09187b124e0a56ec.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <780bf01dec69fa68b8fe5a9c09187b124e0a56ec.1730713917.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 4 Dec 2024 11:29:38 +0200
Message-ID: <CAPMcbCrLTp=G_bzt+Li82DQnWXBGEs0Kw00z8gSv9XWjan1aYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] qga: Don't access global variable in run_agent_once()
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000004f517f06286e6c68"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000004f517f06286e6c68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Nov 4, 2024 at 11:54=E2=80=AFAM Michal Privoznik <mprivozn@redhat.c=
om>
wrote:

> The run_agent_once() function is already given GAState via an
> argument. There's no need to access the global ga_state variable
> which points to the argument anyways (thanks to
> initialize_agent()). Worse, some parts of the function use the
> argument and the other use the global variable.  Stick with the
> function argument.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qga/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 50186760bf..4a695235f0 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1519,7 +1519,7 @@ static int run_agent_once(GAState *s)
>          return EXIT_FAILURE;
>      }
>
> -    g_main_loop_run(ga_state->main_loop);
> +    g_main_loop_run(s->main_loop);
>
>      if (s->channel) {
>          ga_channel_free(s->channel);
> --
> 2.45.2
>
>

--0000000000004f517f06286e6c68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Nov 4, 2024 at 11:54=E2=80=AFAM Michal Privoznik &lt;<a hr=
ef=3D"mailto:mprivozn@redhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">The run_agent_once() f=
unction is already given GAState via an<br>
argument. There&#39;s no need to access the global ga_state variable<br>
which points to the argument anyways (thanks to<br>
initialize_agent()). Worse, some parts of the function use the<br>
argument and the other use the global variable.=C2=A0 Stick with the<br>
function argument.<br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 50186760bf..4a695235f0 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1519,7 +1519,7 @@ static int run_agent_once(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_main_loop_run(ga_state-&gt;main_loop);<br>
+=C2=A0 =C2=A0 g_main_loop_run(s-&gt;main_loop);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;channel) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_channel_free(s-&gt;channel);<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--0000000000004f517f06286e6c68--


