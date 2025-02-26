Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423EDC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDi5-0007Wl-DD; Wed, 26 Feb 2025 04:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnDi3-0007WW-NL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnDhz-0003si-57
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740562080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cUnf35jt5zKX4LqhksLjRF2A34WojRcXe2NA78e9grY=;
 b=B9IH59U7S/4CU6m2ZM5fbJKYGTY04fR+Ogi19+7l29gwAqEwitrsF61JcwRgcEgvJWqhdc
 PnF/zxBRKCkKb6ek0PnezuurY3OcecTBIB0NR3wuNhtSnMMvRxNBXFG+jsnG9KZXbuhVE3
 gle+x4gd6egGxSFYfdoAb4NZsvvWuc0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-e7Vr-rC2PVy1pxddN8OTzg-1; Wed, 26 Feb 2025 04:26:25 -0500
X-MC-Unique: e7Vr-rC2PVy1pxddN8OTzg-1
X-Mimecast-MFC-AGG-ID: e7Vr-rC2PVy1pxddN8OTzg_1740561984
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e66c51e5d2so176632496d6.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740561984; x=1741166784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cUnf35jt5zKX4LqhksLjRF2A34WojRcXe2NA78e9grY=;
 b=rx2GdUdgZEL5pw7Lo3kzlkWjH6x0M9tAyU9ObJNPFaAuZ642XgD6RWtWTyjcEsg5HR
 lz5oNKzFStC5yOFzgXO8FwRzZXLhVCD5EpW3OESi2ZjHaIyknDF6eYfKGb2ck6NyrpkL
 JwOKNAxAOd1T23olhb6TvboiKQifQ8A7NOU5+BfaLwgdwUB9LWQ1c7irq3FAnx4m4rfv
 fDMkQFjibIlRQGmduUecgJjbpQOLtkVf9JqkaFYew9GLm0pyqfIOYqbxaPDP68N14G+n
 i1JYOIavBUf8A0Z19Tllvrrn41GzTpuBWTYneRQ8HR/CNutQq00fYxCAa8APPGLx4ORM
 WSKw==
X-Gm-Message-State: AOJu0YyqLUJZyqsTZrsekROEth+Mmo+vRhaUpxWiy1IZaiqVa1xx/1/8
 N/hKuLp/6AbzZCxkdOEMdIKCL0DgY8F1wGeMBzvyT0kBNC4x+pFpEMKxEhBHyMaEQRq2VH6Csb1
 Odgv6qaiZMJq7ah6xLBG4cSWG/aQQdDU1WMMU77PYyUBkjspS6Ehw3N0jT7VxPnoqPuoTHBF9N/
 ZbT2jUZwy8cLUcI7iuAbGaA/hZVEw=
X-Gm-Gg: ASbGnctfbjNdtRWl0ZBa5fe/xKf1H2zoHlRlCDAs7Tl6uKmDopwmkK9DsY5Vvk89Kzq
 XUw7BRyMXDs1nd0yeMVcBn1Fn1ovUHlZ5h0CRGXiarDpN3SkbgH0mhC/pSJmyHa89cRSQy9Ivvu
 w=
X-Received: by 2002:ad4:5dea:0:b0:6e4:4393:de7 with SMTP id
 6a1803df08f44-6e87ab066e8mr88761216d6.2.1740561984664; 
 Wed, 26 Feb 2025 01:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8wJsYjK1tKPta8I3e8+5BUkyIlcKNNjEFqS2kYo3iLvL43WLV/IOkjk1OwlaSgqDdBgPNV1aWRs5zi9WC7vs=
X-Received: by 2002:ad4:5dea:0:b0:6e4:4393:de7 with SMTP id
 6a1803df08f44-6e87ab066e8mr88761086d6.2.1740561984442; Wed, 26 Feb 2025
 01:26:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736261360.git.mprivozn@redhat.com>
 <8a28265f50177a8dc4c10fcf4146e85a7fd748ee.1736261360.git.mprivozn@redhat.com>
In-Reply-To: <8a28265f50177a8dc4c10fcf4146e85a7fd748ee.1736261360.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 26 Feb 2025 11:26:13 +0200
X-Gm-Features: AQ5f1JoPR4PTtEHgCfDYDlWCoDlguVrXqLMYQmI_2h5QJbizNtifUy5aA70XBKo
Message-ID: <CAPMcbCp2OUenxS=nR8Tcx3fLkS=anJgu2HkUC+v_gqqxf_KQLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] qga: Invert logic on return value in main()
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jtomko@redhat.com
Content-Type: multipart/alternative; boundary="000000000000cae951062f082ac6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000cae951062f082ac6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Jan 7, 2025 at 4:52=E2=80=AFPM Michal Privoznik <mprivozn@redhat.co=
m> wrote:

> Current logic on return value ('ret' variable) in main() is error
> prone. The variable is initialized to EXIT_SUCCESS and then set
> to EXIT_FAILURE on error paths. This makes it very easy to forget
> to set the variable to indicate error when adding new error path,
> as is demonstrated by handling of initialize_agent() failure.
> It's simply lacking setting of the variable.
>
> There's just one case where success should be indicated: when
> dumping the config ('-D' cmd line argument).
>
> To resolve this, initialize the variable to failure value and set
> it explicitly to success value in that one specific case.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> ---
>  qga/main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 4a695235f0..68ea7f275a 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested)
>
>  int main(int argc, char **argv)
>  {
> -    int ret =3D EXIT_SUCCESS;
> +    int ret =3D EXIT_FAILURE;
>      GAState *s;
>      GAConfig *config =3D g_new0(GAConfig, 1);
>      int socket_activation;
> @@ -1607,7 +1607,6 @@ int main(int argc, char **argv)
>      socket_activation =3D check_socket_activation();
>      if (socket_activation > 1) {
>          g_critical("qemu-ga only supports listening on one socket");
> -        ret =3D EXIT_FAILURE;
>          goto end;
>      }
>      if (socket_activation) {
> @@ -1631,7 +1630,6 @@ int main(int argc, char **argv)
>
>          if (!config->method) {
>              g_critical("unsupported listen fd type");
> -            ret =3D EXIT_FAILURE;
>              goto end;
>          }
>      } else if (config->channel_path =3D=3D NULL) {
> @@ -1643,13 +1641,13 @@ int main(int argc, char **argv)
>              config->channel_path =3D g_strdup(QGA_SERIAL_PATH_DEFAULT);
>          } else {
>              g_critical("must specify a path for this channel");
> -            ret =3D EXIT_FAILURE;
>              goto end;
>          }
>      }
>
>      if (config->dumpconf) {
>          config_dump(config);
> +        ret =3D EXIT_SUCCESS;
>          goto end;
>      }
>
> @@ -1664,6 +1662,7 @@ int main(int argc, char **argv)
>          SERVICE_TABLE_ENTRY service_table[] =3D {
>              { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } }=
;
>          StartServiceCtrlDispatcher(service_table);
> +        ret =3D EXIT_SUCCESS;
>      } else {
>          ret =3D run_agent(s);
>      }
> --
> 2.45.2
>
>

--000000000000cae951062f082ac6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Jan 7, 2025 at 4:52=E2=80=AFPM Michal Privoznik &lt;<a hre=
f=3D"mailto:mprivozn@redhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Current logic on return=
 value (&#39;ret&#39; variable) in main() is error<br>
prone. The variable is initialized to EXIT_SUCCESS and then set<br>
to EXIT_FAILURE on error paths. This makes it very easy to forget<br>
to set the variable to indicate error when adding new error path,<br>
as is demonstrated by handling of initialize_agent() failure.<br>
It&#39;s simply lacking setting of the variable.<br>
<br>
There&#39;s just one case where success should be indicated: when<br>
dumping the config (&#39;-D&#39; cmd line argument).<br>
<br>
To resolve this, initialize the variable to failure value and set<br>
it explicitly to success value in that one specific case.<br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
Reviewed-by: J=C3=A1n Tomko &lt;<a href=3D"mailto:jtomko@redhat.com" target=
=3D"_blank">jtomko@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 4a695235f0..68ea7f275a 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1579,7 +1579,7 @@ static void stop_agent(GAState *s, bool requested)<br=
>
<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int ret =3D EXIT_SUCCESS;<br>
+=C2=A0 =C2=A0 int ret =3D EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0GAState *s;<br>
=C2=A0 =C2=A0 =C2=A0GAConfig *config =3D g_new0(GAConfig, 1);<br>
=C2=A0 =C2=A0 =C2=A0int socket_activation;<br>
@@ -1607,7 +1607,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0socket_activation =3D check_socket_activation();<br>
=C2=A0 =C2=A0 =C2=A0if (socket_activation &gt; 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;qemu-ga only supports li=
stening on one socket&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (socket_activation) {<br>
@@ -1631,7 +1630,6 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!config-&gt;method) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;unsupporte=
d listen fd type&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else if (config-&gt;channel_path =3D=3D NULL) {<br>
@@ -1643,13 +1641,13 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;channel_path =3D=
 g_strdup(QGA_SERIAL_PATH_DEFAULT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;must speci=
fy a path for this channel&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;dumpconf) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_dump(config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1664,6 +1662,7 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SERVICE_TABLE_ENTRY service_table[] =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ (char *)QGA_SERVICE_NAME,=
 service_main }, { NULL, NULL } };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StartServiceCtrlDispatcher(service_table)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D run_agent(s);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--000000000000cae951062f082ac6--


