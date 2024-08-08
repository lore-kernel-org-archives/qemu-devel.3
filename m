Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38623C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 20:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scA3o-00083n-4o; Thu, 08 Aug 2024 16:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scA3m-00082b-8y
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 16:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scA3k-0004bM-BU
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 16:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723150104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdtO46zvNHLIUw/gVdWXp5jidy/cIm+KbnibXipUe6I=;
 b=E2XSrq/qFsSRUxe4qeywG+KE8Fxq7ouY8LJi6OpJP+IDbvZGKpezx1Y+iKHHYW1SRpV0S8
 8KWQw+mQzC2Pr0HMEeB5m+mfKdXsZqrndzruZuztmnByZtam6n5aPPWewSa3337ZGib/EM
 5EnCf9eisw8Sijnp+rLKKR/4GXh5DrQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Jh4zIcZBNzSRdsLH2BsZPg-1; Thu, 08 Aug 2024 16:48:22 -0400
X-MC-Unique: Jh4zIcZBNzSRdsLH2BsZPg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36873ed688dso642556f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 13:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723150101; x=1723754901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdtO46zvNHLIUw/gVdWXp5jidy/cIm+KbnibXipUe6I=;
 b=H0f5F92QEiuSaSjCO32G4QSxotVSAeWoDKfXHHxZT4t5jKp7iTLQscCVGQDhKePnHR
 wObgiyY2AIDk6UIFjaS5gBXsyoku/hLF/CR8UUi7NfE9G2EOCv82hTNVu+yJgkV5J1mt
 IEOUwrP9Hqinp7XevMP2JVgPwnW+5xMSsucQyaGPXeBscbUvyQpw3jKIMWf1LNf4YYpq
 jOh0JtoxKJZEC544JszzWegLR7Gn3bow1g7MaGYeHQYvjPljZPLtMq89bQ/k1d95bekD
 7IbEV1lJ9SAVm0gmI9YQx/u1YJsBMmgeM967ZnLlcdVE00SGWzHTssWeMKRcR3PLWbAw
 CI0g==
X-Gm-Message-State: AOJu0Yw8GlzkoTHCk5IYKce3BS+TynNvhETZxCUo/hS4MQmmA1oATrBH
 7gRXECUc+BhY3fZzHuFuD4F7Bp4KYxurjuhJRYqFaz44BcAiI4Boonps5W/m7fupAxF4cXeF+sC
 yMLVJneG05hQ4Ev4Mg8hvnZgSTq/AweHdR7Lj9UCbfunksiZCRTQidoaA1vGEBjdjOv6ZclbKyN
 T2W6gCBmVilS9MgvxGwQ6iXb7sBrw=
X-Received: by 2002:adf:cd0f:0:b0:368:3198:5ac4 with SMTP id
 ffacd0b85a97d-36d27568175mr1953007f8f.39.1723150101515; 
 Thu, 08 Aug 2024 13:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBos0jqJx8/zk1oOD/9kNNz9aOnZfI3q9pu4YY79GUUD7XGMsef3GdpjqV9TFRgM6eeBArQpdBuvoi4Qs5Gg4=
X-Received: by 2002:adf:cd0f:0:b0:368:3198:5ac4 with SMTP id
 ffacd0b85a97d-36d27568175mr1952998f8f.39.1723150101040; Thu, 08 Aug 2024
 13:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-2-armbru@redhat.com>
In-Reply-To: <20240808182636.3657537-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Aug 2024 16:48:08 -0400
Message-ID: <CAFn=p-Yk1J2UUFDULdoF-kbpYN61NB7dDFtA5wsY9h1BSzfLvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] qapi/char: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, jiri@resnulli.us
Content-Type: multipart/alternative; boundary="000000000000aaf25a061f3225cc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000aaf25a061f3225cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> Since we neglect to document several members of ChardevBackendKind,
> their description in the QEMU QMP Reference manual is "Not
> documented".  Fix that, and improve the existing member documentation.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
>  qapi/pragma.json |  1 -
>  2 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index ef58445cee..8a4a87c95c 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -434,37 +434,49 @@
>  ##
>  # @ChardevBackendKind:
>  #
> -# @pipe: Since 1.5
> +# @file: regular files
>  #
> -# @udp: Since 1.5
> +# @serial: serial host device
>  #
> -# @mux: Since 1.5
> +# @parallel: parallel host device
>  #
> -# @msmouse: Since 1.5
> +# @pipe: pipes (since 1.5)
>  #
> -# @wctablet: Since 2.9
> +# @socket: stream socket
>  #
> -# @braille: Since 1.5
> +# @udp: datagram socket (since 1.5)
>  #
> -# @testdev: Since 2.2
> +# @pty: pseudo-terminal
>  #
> -# @stdio: Since 1.5
> +# @null: provides no input, throws away output
>  #
> -# @console: Since 1.5
> +# @mux: (since 1.5)
>  #
> -# @spicevmc: Since 1.5
> +# @msmouse: emulated Microsoft serial mouse (since 1.5)
>  #
> -# @spiceport: Since 1.5
> +# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
>  #
> -# @qemu-vdagent: Since 6.1
> +# @braille: Baum Braille device (since 1.5)
>  #
> -# @dbus: Since 7.0
> +# @testdev: device for test-suite control (since 2.2)
>  #
> -# @vc: v1.5
> +# @stdio: standard I/O (since 1.5)
>  #
> -# @ringbuf: Since 1.6
> +# @console: Windows console (since 1.5)
>  #
> -# @memory: Since 1.5
> +# @spicevmc: spice vm channel (since 1.5)
> +#
> +# @spiceport: Spice port channel (since 1.5)
> +#
> +# @qemu-vdagent: Spice vdagent (since 6.1)
> +#
> +# @dbus: D-Bus channel (since 7.0)
> +#
> +# @vc: virtual console (since v1.5)
>

Remove the "v"?


> +#
> +# @ringbuf: memory ring buffer (since 1.6)
> +#
> +# @memory: synonym for @ringbuf (since 1.5)
>  #
>  # Features:
>  #
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 59fbe74b8c..39a424303b 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -46,7 +46,6 @@
>          'BlockdevSnapshotSyncWrapper',
>          'BlockdevSnapshotWrapper',
>          'BlockdevVmdkAdapterType',
> -        'ChardevBackendKind',
>          'CpuS390Entitlement',
>          'CpuS390Polarization',
>          'CpuS390State',
> --
> 2.45.0
>

It'd be nice if these included some kind of cross-reference to
documentation for the backends in question, but this is better than "(Not
documented)", so it's not time to be picky.

ACK

--js

--000000000000aaf25a061f3225cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 8, 2024 at 2:26=E2=80=AFP=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Since we neglect to document several members of ChardevBackendKind,<br>
their description in the QEMU QMP Reference manual is &quot;Not<br>
documented&quot;.=C2=A0 Fix that, and improve the existing member documenta=
tion.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0| 44 ++++++++++++++++++++++++++++---------=
-------<br>
=C2=A0qapi/pragma.json |=C2=A0 1 -<br>
=C2=A02 files changed, 28 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index ef58445cee..8a4a87c95c 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -434,37 +434,49 @@<br>
=C2=A0##<br>
=C2=A0# @ChardevBackendKind:<br>
=C2=A0#<br>
-# @pipe: Since 1.5<br>
+# @file: regular files<br>
=C2=A0#<br>
-# @udp: Since 1.5<br>
+# @serial: serial host device<br>
=C2=A0#<br>
-# @mux: Since 1.5<br>
+# @parallel: parallel host device<br>
=C2=A0#<br>
-# @msmouse: Since 1.5<br>
+# @pipe: pipes (since 1.5)<br>
=C2=A0#<br>
-# @wctablet: Since 2.9<br>
+# @socket: stream socket<br>
=C2=A0#<br>
-# @braille: Since 1.5<br>
+# @udp: datagram socket (since 1.5)<br>
=C2=A0#<br>
-# @testdev: Since 2.2<br>
+# @pty: pseudo-terminal<br>
=C2=A0#<br>
-# @stdio: Since 1.5<br>
+# @null: provides no input, throws away output<br>
=C2=A0#<br>
-# @console: Since 1.5<br>
+# @mux: (since 1.5)<br>
=C2=A0#<br>
-# @spicevmc: Since 1.5<br>
+# @msmouse: emulated Microsoft serial mouse (since 1.5)<br>
=C2=A0#<br>
-# @spiceport: Since 1.5<br>
+# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)<br>
=C2=A0#<br>
-# @qemu-vdagent: Since 6.1<br>
+# @braille: Baum Braille device (since 1.5)<br>
=C2=A0#<br>
-# @dbus: Since 7.0<br>
+# @testdev: device for test-suite control (since 2.2)<br>
=C2=A0#<br>
-# @vc: v1.5<br>
+# @stdio: standard I/O (since 1.5)<br>
=C2=A0#<br>
-# @ringbuf: Since 1.6<br>
+# @console: Windows console (since 1.5)<br>
=C2=A0#<br>
-# @memory: Since 1.5<br>
+# @spicevmc: spice vm channel (since 1.5)<br>
+#<br>
+# @spiceport: Spice port channel (since 1.5)<br>
+#<br>
+# @qemu-vdagent: Spice vdagent (since 6.1)<br>
+#<br>
+# @dbus: D-Bus channel (since 7.0)<br>
+#<br>
+# @vc: virtual console (since v1.5)<br></blockquote><div><br></div><div>Re=
move the &quot;v&quot;?<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+#<br>
+# @ringbuf: memory ring buffer (since 1.6)<br>
+#<br>
+# @memory: synonym for @ringbuf (since 1.5)<br>
=C2=A0#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
diff --git a/qapi/pragma.json b/qapi/pragma.json<br>
index 59fbe74b8c..39a424303b 100644<br>
--- a/qapi/pragma.json<br>
+++ b/qapi/pragma.json<br>
@@ -46,7 +46,6 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevSnapshotSyncWrapper&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevSnapshotWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevVmdkAdapterType&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ChardevBackendKind&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;CpuS390Entitlement&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;CpuS390Polarization&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;CpuS390State&#39;,<br>
-- <br>
2.45.0<br></blockquote><div><br></div><div>It&#39;d be nice if these includ=
ed some kind of cross-reference to documentation for the backends in questi=
on, but this is better than &quot;(Not documented)&quot;, so it&#39;s not t=
ime to be picky.</div><div><br></div><div>ACK</div><div><br></div><div>--js=
 <br></div></div></div>

--000000000000aaf25a061f3225cc--


