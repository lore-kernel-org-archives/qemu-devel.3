Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCDCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCVk-0005RN-31; Tue, 21 Oct 2025 09:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBCVV-0005MN-DJ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBCV1-0003pI-0o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761053522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5y/GnC80SKUEVH59583YdA84D/SBV/A4Z+WRHJ8NJ8=;
 b=RmPonM7sy1p8OJ8WG1yywvSMN5bUiC3P4ZKLH/TyGX0Vdwob3BjfSlkEvb+VyAgsjuq7x/
 IU9PJN8ffwTJj0H5eh9N8DjKSVUaDXMlm3GGFu1TQrMqejE9BpK4cEVYxXiR+EC9kVPb2H
 XTDTUztkPAlXia4NPfKeC65PypBFYEA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-gJrG8e2qNOWJ31bC9Uqbng-1; Tue, 21 Oct 2025 09:26:39 -0400
X-MC-Unique: gJrG8e2qNOWJ31bC9Uqbng-1
X-Mimecast-MFC-AGG-ID: gJrG8e2qNOWJ31bC9Uqbng_1761053198
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33bb4d11f5eso5564198a91.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761053198; x=1761657998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5y/GnC80SKUEVH59583YdA84D/SBV/A4Z+WRHJ8NJ8=;
 b=s53zNA+QywH0fcD2drDuXczV4zEUfeCBLZZf+6gJhnZ6OSFNfPNQ/MheTdvDs75n1k
 QCk3H/1Tk3qE+4l8ojxnP3B+nxf4ai2Z+o3TlIYxCEVQxBamqC1E+woUSBoKynjBUJ9z
 urxiVERgvEsGnZap0jnBQ1sW8kUfyoOfAoPqA3OVKqNoJRERmQINfn6yfylEifqhUu/6
 OMVkNHF/aRTOPsv0moMwdyIlKKbqitcEuUr40IOYzaEQpqiGWG4zruWcT1iqQhBedCRL
 7Gm78iC7zOlaSZ4Uix3qV5lk/ilgOCRZ1oHUpR8uUz9l1dYokW1ImBcyiPriuv5ZR2Zs
 EEgw==
X-Gm-Message-State: AOJu0YwLAP8CdjCCXFjerxbfIieCBD8tAatjAxXRVZBkQWnMR9LBCbwN
 vy9D7bdiUm1ePoyw9nMtukdqrLwq0j8YMk8pXh8lnyCwoKjQ0XCHZnU/RJdF8wnx9hLn3XCNnJr
 3bJFbuZziR+PpsradETXdPIGFVFGdYkWRK4/mXz6ZhcTTBT4sFqCDWbQVc+xSjLELZpZzw0JmZY
 euqux90VCqsPbTIXKH+5bzSIhVjKUTM1U=
X-Gm-Gg: ASbGncsKHuovEeBngWEJ3hLaZXfSPWL+RHUH9YrdIVk5vlhgpsgFEA15JqeAh5k71Q8
 KUt8Ymp7YjULn+d9VNcLzduw4zVVWURCzxSaKn+augaXtGVQFm3UUdYOg6d1QAV0V95/2EXGDa2
 BOPmi3MAhnHR7onkJjCZk6kLxGTf2CV0IqA33rHNln+jg9YaHi8e4Bd1DkESoswQhgrY52AejrI
 RwsVup9B1LsHrI=
X-Received: by 2002:a17:90b:3dcb:b0:32e:b87e:a961 with SMTP id
 98e67ed59e1d1-33bcf85b526mr19777882a91.5.1761053198155; 
 Tue, 21 Oct 2025 06:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETc+c72iGZ19cYxSxuP/2eBxRFGBvbEG0AizmKTtuuQ6JerQXKD9GOe+dKQNHIhYqcPKTBAMuM006t3JmQB0=
X-Received: by 2002:a17:90b:3dcb:b0:32e:b87e:a961 with SMTP id
 98e67ed59e1d1-33bcf85b526mr19777846a91.5.1761053197727; Tue, 21 Oct 2025
 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251021131825.99390-1-philmd@linaro.org>
 <20251021131825.99390-2-philmd@linaro.org>
In-Reply-To: <20251021131825.99390-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Oct 2025 17:26:26 +0400
X-Gm-Features: AS18NWDmfPudKdR3UdCPZN--l59qGQ97ATbLk-6lxVSdbtOryCmr5I300xnY96k
Message-ID: <CAMxuvazc2voX7SqFAP7YkvmgVE+bbmqE3uJa+evs3gq+wUUT8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: Update mentions of removed '-soundhw' command
 line option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000482cb90641ab2689"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000482cb90641ab2689
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 21, 2025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> The `-soundhw` CLI was removed in commit 039a68373c4 ("introduce
> -audio as a replacement for -soundhw"). Remove outdated comments
> and update the document mentioning the old usage.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
I'll take it in my v2.


> ---
>  docs/qdev-device-use.txt | 4 ++--
>  system/qdev-monitor.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
> index 043ae461140..fb420da2a9e 100644
> --- a/docs/qdev-device-use.txt
> +++ b/docs/qdev-device-use.txt
> @@ -311,9 +311,9 @@ constraints.
>
>  Host and guest part of audio devices have always been separate.
>
> -The old way to define guest audio devices is -soundhw C1,...
> +The old way to define guest audio devices was -soundhw C1,...
>
> -The new way is to define each guest audio device separately with
> +The current way is to define each guest audio device separately with
>  -device.
>
>  Map from -soundhw sound card name to -device:
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 4b732f579ad..5c95926aadd 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -73,9 +73,9 @@ typedef struct QDevAlias
>
>  /* Please keep this table sorted by typename. */
>  static const QDevAlias qdev_alias_table[] =3D {
> -    { "AC97", "ac97" }, /* -soundhw name */
> +    { "AC97", "ac97" },
>      { "e1000", "e1000-82540em" },
> -    { "ES1370", "es1370" }, /* -soundhw name */
> +    { "ES1370", "es1370" },
>      { "ich9-ahci", "ahci" },
>      { "lsi53c895a", "lsi" },
>      { "virtio-9p-device", "virtio-9p", QEMU_ARCH_VIRTIO_MMIO },
> --
> 2.51.0
>
>

--000000000000482cb90641ab2689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 21, 2=
025 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">The `-soundhw` CLI was removed in commit =
039a68373c4 (&quot;introduce<br>
-audio as a replacement for -soundhw&quot;). Remove outdated comments<br>
and update the document mentioning the old usage.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>I&#=
39;ll take it in my v2.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
---<br>
=C2=A0docs/qdev-device-use.txt | 4 ++--<br>
=C2=A0system/qdev-monitor.c=C2=A0 =C2=A0 | 4 ++--<br>
=C2=A02 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt<br>
index 043ae461140..fb420da2a9e 100644<br>
--- a/docs/qdev-device-use.txt<br>
+++ b/docs/qdev-device-use.txt<br>
@@ -311,9 +311,9 @@ constraints.<br>
<br>
=C2=A0Host and guest part of audio devices have always been separate.<br>
<br>
-The old way to define guest audio devices is -soundhw C1,...<br>
+The old way to define guest audio devices was -soundhw C1,...<br>
<br>
-The new way is to define each guest audio device separately with<br>
+The current way is to define each guest audio device separately with<br>
=C2=A0-device.<br>
<br>
=C2=A0Map from -soundhw sound card name to -device:<br>
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c<br>
index 4b732f579ad..5c95926aadd 100644<br>
--- a/system/qdev-monitor.c<br>
+++ b/system/qdev-monitor.c<br>
@@ -73,9 +73,9 @@ typedef struct QDevAlias<br>
<br>
=C2=A0/* Please keep this table sorted by typename. */<br>
=C2=A0static const QDevAlias qdev_alias_table[] =3D {<br>
-=C2=A0 =C2=A0 { &quot;AC97&quot;, &quot;ac97&quot; }, /* -soundhw name */<=
br>
+=C2=A0 =C2=A0 { &quot;AC97&quot;, &quot;ac97&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;e1000&quot;, &quot;e1000-82540em&quot; },<br>
-=C2=A0 =C2=A0 { &quot;ES1370&quot;, &quot;es1370&quot; }, /* -soundhw name=
 */<br>
+=C2=A0 =C2=A0 { &quot;ES1370&quot;, &quot;es1370&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;ich9-ahci&quot;, &quot;ahci&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;lsi53c895a&quot;, &quot;lsi&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;virtio-9p-device&quot;, &quot;virtio-9p&quot;, =
QEMU_ARCH_VIRTIO_MMIO },<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000482cb90641ab2689--


