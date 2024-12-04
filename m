Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10FAE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlmE-0006j3-J3; Wed, 04 Dec 2024 04:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlmB-0006if-He
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlm9-0006lo-L1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733304867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/1SplKXJNRRJY8Jh+DYhXVfVHKRhSeFLNpoY8aFMis=;
 b=TVxfcRUoF8j7Ehesv81Khyg3sfP3IR6GhVAkQHO8XyrmB3aT+NfyvMwI4henZPWyU/YxKo
 gofOtvCG1ZOqM3iuOhdUbjRydmh5Ok77bnXIBAUzCxNjN9H9rotZxZSxDEHS89aszTRI4I
 mZNNIA1Ivh51tLfn1tGtVtUSu5P+CWE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-0X5WKhVaMiSg__R9eS3Tuw-1; Wed, 04 Dec 2024 04:34:24 -0500
X-MC-Unique: 0X5WKhVaMiSg__R9eS3Tuw-1
X-Mimecast-MFC-AGG-ID: 0X5WKhVaMiSg__R9eS3Tuw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8829edb92so16955476d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733304864; x=1733909664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/1SplKXJNRRJY8Jh+DYhXVfVHKRhSeFLNpoY8aFMis=;
 b=nkSsJljeiWC5YmAwa0TnIw/i6OYT666smiAqD/Yo9O+1GZlytRM0syu9obgEDDCNHi
 KxrpauqdxMNiO0IKuwGZ6en0BOQRyENUWOlcCB0y+zvGR5d+y9SGfRT3ngYT+tmZNL1f
 4JjxlsrmPjAemujikiZw/h3KqrgaxkvLc8hJeXJqgd8ghnkjRZviQEd60ErtUA1pjq2/
 yVUA+IxmtuitJZMfKTGrSupANPhelj7gyxb/MgmY1FY4yPehyuxjrldDcECMBcqLIwwI
 03uqD5Jao3KRL5uXplhE/D+96j3fukttouM8OT7oufTmFIgu5vf4UH6wj3tXQNnnWhdM
 w/Vg==
X-Gm-Message-State: AOJu0YxX1wPsmTDKn2MKdyY/KdpB8oC1aE4AKiJcKcncXbMJIPq64bO9
 1zEpeBGYU69xEzrbQyvaGU7R/OrGLsu9YXdaEi04/ZfKaiFWOFyT4kAPguBiN+kplDbN1OsuCYl
 ZMPhSbbLjUWAGXx9k8o+lPBndhfEpyDs2kBBAZafFaBU69d3ez+6SWTwzQCN0RPJX9fRoVdAQiW
 pMSLbKiK5kHuD52lrjvwTGGBJik8w=
X-Gm-Gg: ASbGncsCICFV1T1vuW2En9QGhThTbp5O89Jtk1Bo6QNqeIR5eMEouUkLlelqHAdPXtm
 sd3ULRb31pznNEGnLOS8ML87bnbLFQqxRXg==
X-Received: by 2002:a05:6214:2527:b0:6d8:95c9:af39 with SMTP id
 6a1803df08f44-6d895c9b249mr263020026d6.0.1733304864372; 
 Wed, 04 Dec 2024 01:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeOqUhmGjiY1TBF00lmMydxwjQgmKhosgBKX8mP6k1g5aAJtMDUuF6+TtNewvUGIin/pQ6hWvXCCot646RKls=
X-Received: by 2002:a05:6214:2527:b0:6d8:95c9:af39 with SMTP id
 6a1803df08f44-6d895c9b249mr263019856d6.0.1733304864149; Wed, 04 Dec 2024
 01:34:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730713917.git.mprivozn@redhat.com>
 <5182ceb139a43aacaab2c8b833bf52b13279dcf0.1730713917.git.mprivozn@redhat.com>
 <ZyuUH9SJzvJo72kC@fedora>
In-Reply-To: <ZyuUH9SJzvJo72kC@fedora>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 4 Dec 2024 11:34:13 +0200
Message-ID: <CAPMcbCo-y5aLvPYgDd6F3V_z-RwnQj-Prazyu9mRGX9V7+L8fg@mail.gmail.com>
Subject: Re: [PATCH 2/4] qga: Invert logic on return value in main()
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, 
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b724b206286e7c7f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000b724b206286e7c7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Please fix the issue that Jan mentioned.
All commits should be logically correct even if it part of one series.
Applying this will cause regression.

Best Regards,
Konstantin Kostiuk.


On Wed, Nov 6, 2024 at 6:07=E2=80=AFPM J=C3=A1n Tomko <jtomko@redhat.com> w=
rote:

> On a Monday in 2024, Michal Privoznik wrote:
> >Current logic on return value ('ret' variable) in main() is error
> >prone. The variable is initialized to EXIT_SUCCESS and then set
> >to EXIT_FAILURE on error paths. This makes it very easy to forget
> >to set the variable to indicate error when adding new error path,
> >as is demonstrated by handling of initialize_agent() failure.
> >It's simply lacking setting of the variable.
> >
> >There's just one case where success should be indicated: when
> >dumping the config ('-D' cmd line argument).
> >
> >To resolve this, initialize the variable to failure value and set
> >it explicitly to success value in that one specific case.
> >
> >Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> >---
> > qga/main.c | 6 ++----
> > 1 file changed, 2 insertions(+), 4 deletions(-)
> >
> >diff --git a/qga/main.c b/qga/main.c
> >index 4a695235f0..c003aacbe0 100644
> >--- a/qga/main.c
> >+++ b/qga/main.c
> >@@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested)
> >
> > int main(int argc, char **argv)
> > {
> >-    int ret =3D EXIT_SUCCESS;
> >+    int ret =3D EXIT_FAILURE;
> >     GAState *s;
> >     GAConfig *config =3D g_new0(GAConfig, 1);
> >     int socket_activation;
> >@@ -1607,7 +1607,6 @@ int main(int argc, char **argv)
> >     socket_activation =3D check_socket_activation();
> >     if (socket_activation > 1) {
> >         g_critical("qemu-ga only supports listening on one socket");
> >-        ret =3D EXIT_FAILURE;
> >         goto end;
> >     }
> >     if (socket_activation) {
> >@@ -1631,7 +1630,6 @@ int main(int argc, char **argv)
> >
> >         if (!config->method) {
> >             g_critical("unsupported listen fd type");
> >-            ret =3D EXIT_FAILURE;
> >             goto end;
> >         }
> >     } else if (config->channel_path =3D=3D NULL) {
> >@@ -1643,13 +1641,13 @@ int main(int argc, char **argv)
> >             config->channel_path =3D g_strdup(QGA_SERIAL_PATH_DEFAULT);
> >         } else {
> >             g_critical("must specify a path for this channel");
> >-            ret =3D EXIT_FAILURE;
> >             goto end;
> >         }
> >     }
> >
> >     if (config->dumpconf) {
> >         config_dump(config);
> >+        ret =3D EXIT_SUCCESS;
> >         goto end;
> >     }
> >
>
> Below this there's another place that misses an EXIT_SUCCESS, on _WIN32
> when config->daemonize is set:
>
>   #ifdef _WIN32
>       if (config->daemonize) {
>           SERVICE_TABLE_ENTRY service_table[] =3D {
>               { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } =
};
>           StartServiceCtrlDispatcher(service_table);
>       } else {
>           ret =3D run_agent(s);
>       }
>   #else
>       ret =3D run_agent(s);
>   #endif
>
> But after patch 4/4 ret is set to EXIT_SUCCESS in all the cases.
>
> Jano
>

--000000000000b724b206286e7c7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michal,</div><div><br></div><div>Please fix the is=
sue that Jan mentioned. <br></div><div>All commits should be logically corr=
ect even if it part of one series. <br></div><div>Applying this will cause =
regression. <br></div><div><br clear=3D"all"></div><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"=
><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></div></div><b=
r></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Nov 6, 2024 at 6:07=E2=80=AFPM J=C3=A1n Tom=
ko &lt;<a href=3D"mailto:jtomko@redhat.com">jtomko@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On a Monday in=
 2024, Michal Privoznik wrote:<br>
&gt;Current logic on return value (&#39;ret&#39; variable) in main() is err=
or<br>
&gt;prone. The variable is initialized to EXIT_SUCCESS and then set<br>
&gt;to EXIT_FAILURE on error paths. This makes it very easy to forget<br>
&gt;to set the variable to indicate error when adding new error path,<br>
&gt;as is demonstrated by handling of initialize_agent() failure.<br>
&gt;It&#39;s simply lacking setting of the variable.<br>
&gt;<br>
&gt;There&#39;s just one case where success should be indicated: when<br>
&gt;dumping the config (&#39;-D&#39; cmd line argument).<br>
&gt;<br>
&gt;To resolve this, initialize the variable to failure value and set<br>
&gt;it explicitly to success value in that one specific case.<br>
&gt;<br>
&gt;Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.c=
om" target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
&gt;---<br>
&gt; qga/main.c | 6 ++----<br>
&gt; 1 file changed, 2 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt;diff --git a/qga/main.c b/qga/main.c<br>
&gt;index 4a695235f0..c003aacbe0 100644<br>
&gt;--- a/qga/main.c<br>
&gt;+++ b/qga/main.c<br>
&gt;@@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested=
)<br>
&gt;<br>
&gt; int main(int argc, char **argv)<br>
&gt; {<br>
&gt;-=C2=A0 =C2=A0 int ret =3D EXIT_SUCCESS;<br>
&gt;+=C2=A0 =C2=A0 int ret =3D EXIT_FAILURE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0GAState *s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0GAConfig *config =3D g_new0(GAConfig, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0int socket_activation;<br>
&gt;@@ -1607,7 +1607,6 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket_activation =3D check_socket_activation();<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0if (socket_activation &gt; 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;qemu-ga only support=
s listening on one socket&quot;);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (socket_activation) {<br>
&gt;@@ -1631,7 +1630,6 @@ int main(int argc, char **argv)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!config-&gt;method) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;unsupp=
orted listen fd type&quot;);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else if (config-&gt;channel_path =3D=3D NULL) {<b=
r>
&gt;@@ -1643,13 +1641,13 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;channel_path=
 =3D g_strdup(QGA_SERIAL_PATH_DEFAULT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;must s=
pecify a path for this channel&quot;);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (config-&gt;dumpconf) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_dump(config);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_SUCCESS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
<br>
Below this there&#39;s another place that misses an EXIT_SUCCESS, on _WIN32=
<br>
when config-&gt;daemonize is set:<br>
<br>
=C2=A0 #ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 if (config-&gt;daemonize) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SERVICE_TABLE_ENTRY service_table[] =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { (char *)QGA_SERVICE_NAME=
, service_main }, { NULL, NULL } };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 StartServiceCtrlDispatcher(service_table=
);<br>
=C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D run_agent(s);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 #else<br>
=C2=A0 =C2=A0 =C2=A0 ret =3D run_agent(s);<br>
=C2=A0 #endif<br>
<br>
But after patch 4/4 ret is set to EXIT_SUCCESS in all the cases.<br>
<br>
Jano<br>
</blockquote></div>

--000000000000b724b206286e7c7f--


