Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD9BE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDOl-0006No-5b; Mon, 16 Dec 2024 10:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNDOd-0006NQ-G7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNDOb-0004W2-LI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734364352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wY7m5KJEx+mJVrr/xdg/XqSAp9CUq7jh7mCQVabVOuw=;
 b=TcyHWatytqy7T4spb6JZqtSgZddbBp+3V0NweWNGDsyNgTWPXU3uEaDbTBz6fo4fUOBSI/
 MEu4viZfz0QPKHnqC2UQw+NfpbwJaaxpOBr7xKnSrxsZ77ZiWm+uBUYBIM1xkzMjWZiDKJ
 Wbum4g+prXfT1YO5qnvSasGH/10cpI8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-c4mvtRuiPcG_U3s-WneMaQ-1; Mon, 16 Dec 2024 10:52:31 -0500
X-MC-Unique: c4mvtRuiPcG_U3s-WneMaQ-1
X-Mimecast-MFC-AGG-ID: c4mvtRuiPcG_U3s-WneMaQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d87ee5fb22so69078386d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734364350; x=1734969150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wY7m5KJEx+mJVrr/xdg/XqSAp9CUq7jh7mCQVabVOuw=;
 b=uGPjqagXGMxYFkcm+LTFyofDl8MmyEh7M4JNSmMdEkFh4I30ZS2j1w1VvaFiCp0J+V
 wjjL4ZVIoQHvCTyvwtZSHuNIbMp6drzjalHwb74Neab7zFEHtE5p012gwgeLjteOYRw/
 r9NZc9Yy2G9BBcVdwxnSFSa1RUaWqIo0LHjZgO9jiy83in1DgPSOaDF518TcO9F+48kY
 jEoA0fME1dnSMkk2O+D/IgMjA+RbH0ZilNPczQgEw2SiZcJqllCVJIsxf+hAhgv33Er6
 WBlK9bIzrTGi3tH3klZhi71c8FqOsY+pf0QDrFw3f9hg4qp4FR5hSXU3qL+ZEsnv/U1K
 wd3Q==
X-Gm-Message-State: AOJu0YzS70guYcRkjFOYrr1uJN/Q9d4WRuzxuaPghCpvUCwE1WKN33IT
 7Mm/XkzSpzg5apeIe8UwIN2cTTU2086NTQPzGcVsgMIAzo6rG9KYfqOYdbwMpLYgqczy+wxDvjC
 tC8/I1WlSuj7gJv94u/G9rGhheeVDlqsA5sDPEzMhYHfJbdU9NPaRakkifu8cr1qFasjyR9TmbQ
 gi6g7/lBhc7N9GWsqCDYpstUG54zE=
X-Gm-Gg: ASbGncvdDnT2z4ePt7ItNswPS/fZ2v+oV9iu21PH8zs6EiKTgJk1pf5wXOBCdDQ4Eym
 bc3c2gExumujSkk+QntXT0tqiiIQsaqw/5u1JSzKV
X-Received: by 2002:a05:6214:202c:b0:6da:dc79:a3cd with SMTP id
 6a1803df08f44-6dc70f92c6amr248917316d6.0.1734364350675; 
 Mon, 16 Dec 2024 07:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhILnfEKY2MBxGOkI6d/QUXydpPvq8cg7OGCnx1njdCV+Fot99RVvtUVEXkftltnSWyf4a67h/D3f+L6+j+O4=
X-Received: by 2002:a05:6214:202c:b0:6da:dc79:a3cd with SMTP id
 6a1803df08f44-6dc70f92c6amr248917116d6.0.1734364350446; Mon, 16 Dec 2024
 07:52:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733414906.git.mprivozn@redhat.com>
 <8f4469febaaf5c48afdf13a6c88e959956c0f204.1733414906.git.mprivozn@redhat.com>
In-Reply-To: <8f4469febaaf5c48afdf13a6c88e959956c0f204.1733414906.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 16 Dec 2024 17:52:19 +0200
Message-ID: <CAPMcbCrLq5Q=1uVwhRDO8MgUekzcUXzbOvcg-CuibGNYyjceHw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] qga: Make run_agent() and run_agent_once() return
 no value
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jtomko@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000514e30629652b00"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000000514e30629652b00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:19=E2=80=AFPM Michal Privoznik <mprivozn@redhat.co=
m> wrote:

> After previous commits, run_agent_once() can't return anything
> else but EXIT_SUCCESS. Transitionally, run_agent() can't return
> anything else but EXIT_SUCCESS too. There's not much value in
> having these function return an integer. Make them return void.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> ---
>  qga/main.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 35f061b5ea..346274f114 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -145,7 +145,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD
> type, LPVOID data,
>  DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
>  VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
>  #endif
> -static int run_agent(GAState *s);
> +static void run_agent(GAState *s);
>  static void stop_agent(GAState *s, bool requested);
>
>  static void
> @@ -1521,7 +1521,7 @@ static void cleanup_agent(GAState *s)
>      ga_state =3D NULL;
>  }
>
> -static int run_agent_once(GAState *s)
> +static void run_agent_once(GAState *s)
>  {
>      if (!s->channel &&
>          channel_init(s, s->config->method, s->config->channel_path,
> @@ -1536,8 +1536,6 @@ static int run_agent_once(GAState *s)
>

run_agent_once return EXIT_FAILURE when channel_init fails, so we have
compilation issue

../qga/main.c: In function =E2=80=98run_agent_once=E2=80=99:
../qga/main.c:1530:16: error: =E2=80=98return=E2=80=99 with a value, in fun=
ction returning
void [-Wreturn-mismatch]
 1530 |         return EXIT_FAILURE;
      |                ^~~~~~~~~~~~
../qga/main.c:1524:13: note: declared here
 1524 | static void run_agent_once(GAState *s)
      |             ^~~~~~~~~~~~~~
ninja: build stopped: subcommand failed.

As on Windows, we will really reinitialize the channel, I think, we need to
get the real exit code.
If initialization fails and the service gets a stop request we will see in
Windows Events information that the service crashed.


>          ga_channel_free(s->channel);
>          s->channel =3D NULL;
>      }
> -
> -    return EXIT_SUCCESS;
>  }
>
>  static void wait_for_channel_availability(GAState *s)
> @@ -1561,21 +1559,17 @@ static void wait_for_channel_availability(GAState
> *s)
>  #endif
>  }
>
> -static int run_agent(GAState *s)
> +static void run_agent(GAState *s)
>  {
> -    int ret =3D EXIT_SUCCESS;
> -
>      s->force_exit =3D false;
>
>      do {
> -        ret =3D run_agent_once(s);
> +        run_agent_once(s);
>          if (s->config->retry_path && !s->force_exit) {
>              g_warning("agent stopped unexpectedly, restarting...");
>              wait_for_channel_availability(s);
>          }
>      } while (s->config->retry_path && !s->force_exit);
> -
> -    return ret;
>  }
>
>  static void stop_agent(GAState *s, bool requested)
> @@ -1674,14 +1668,15 @@ int main(int argc, char **argv)
>          SERVICE_TABLE_ENTRY service_table[] =3D {
>              { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } }=
;
>          StartServiceCtrlDispatcher(service_table);
> -        ret =3D EXIT_SUCCESS;
>      } else {
> -        ret =3D run_agent(s);
> +        run_agent(s);
>      }
>  #else
> -    ret =3D run_agent(s);
> +    run_agent(s);
>  #endif
>
> +    ret =3D EXIT_SUCCESS;
> +
>      cleanup_agent(s);
>
>  end:
> --
> 2.45.2
>
>

--0000000000000514e30629652b00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 5, =
2024 at 6:19=E2=80=AFPM Michal Privoznik &lt;<a href=3D"mailto:mprivozn@red=
hat.com">mprivozn@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">After previous commits, run_agent_once() can&#3=
9;t return anything<br>
else but EXIT_SUCCESS. Transitionally, run_agent() can&#39;t return<br>
anything else but EXIT_SUCCESS too. There&#39;s not much value in<br>
having these function return an integer. Make them return void.<br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
Reviewed-by: J=C3=A1n Tomko &lt;<a href=3D"mailto:jtomko@redhat.com" target=
=3D"_blank">jtomko@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 21 ++++++++-------------<br>
=C2=A01 file changed, 8 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 35f061b5ea..346274f114 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -145,7 +145,7 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD typ=
e, LPVOID data,<br>
=C2=A0DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);<br=
>
=C2=A0VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);<br>
=C2=A0#endif<br>
-static int run_agent(GAState *s);<br>
+static void run_agent(GAState *s);<br>
=C2=A0static void stop_agent(GAState *s, bool requested);<br>
<br>
=C2=A0static void<br>
@@ -1521,7 +1521,7 @@ static void cleanup_agent(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0ga_state =3D NULL;<br>
=C2=A0}<br>
<br>
-static int run_agent_once(GAState *s)<br>
+static void run_agent_once(GAState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;channel &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0channel_init(s, s-&gt;config-&gt;method, =
s-&gt;config-&gt;channel_path,<br>
@@ -1536,8 +1536,6 @@ static int run_agent_once(GAState *s)<br></blockquote=
><div><br></div><div>run_agent_once return EXIT_FAILURE when channel_init f=
ails, so we have compilation issue</div><div><br></div><div>../qga/main.c: =
In function =E2=80=98run_agent_once=E2=80=99:<br>../qga/main.c:1530:16: err=
or: =E2=80=98return=E2=80=99 with a value, in function returning void [-Wre=
turn-mismatch]<br>=C2=A01530 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 return EXIT_FAIL=
URE;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~<br>../qga/main.c:1524:13: note: declared here<br>=
=C2=A01524 | static void run_agent_once(GAState *s)<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~<br>ninja: build=
 stopped: subcommand failed.</div><div><br></div><div>As on Windows, we wil=
l really reinitialize the channel, I think, we need to get the real exit co=
de.</div><div>If initialization fails and the service gets a stop request w=
e will see in Windows Events information that the service crashed. <br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_channel_free(s-&gt;channel);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;channel =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 return EXIT_SUCCESS;<br>
=C2=A0}<br>
<br>
=C2=A0static void wait_for_channel_availability(GAState *s)<br>
@@ -1561,21 +1559,17 @@ static void wait_for_channel_availability(GAState *=
s)<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
-static int run_agent(GAState *s)<br>
+static void run_agent(GAState *s)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int ret =3D EXIT_SUCCESS;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;force_exit =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D run_agent_once(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run_agent_once(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;config-&gt;retry_path &amp;&amp=
; !s-&gt;force_exit) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;agent stopp=
ed unexpectedly, restarting...&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_for_channel_availabili=
ty(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} while (s-&gt;config-&gt;retry_path &amp;&amp; !s-&gt;=
force_exit);<br>
-<br>
-=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static void stop_agent(GAState *s, bool requested)<br>
@@ -1674,14 +1668,15 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SERVICE_TABLE_ENTRY service_table[] =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ (char *)QGA_SERVICE_NAME,=
 service_main }, { NULL, NULL } };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StartServiceCtrlDispatcher(service_table)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D run_agent(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run_agent(s);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 ret =3D run_agent(s);<br>
+=C2=A0 =C2=A0 run_agent(s);<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 ret =3D EXIT_SUCCESS;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0cleanup_agent(s);<br>
<br>
=C2=A0end:<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>

--0000000000000514e30629652b00--


