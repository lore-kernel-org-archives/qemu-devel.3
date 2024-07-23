Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D78C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 12:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWEng-0008M3-KE; Tue, 23 Jul 2024 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sWEnf-0008KL-A9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 08:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sWEnc-0000WQ-TH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 08:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721738362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyj+SjRC+xai/hCiaIYcUU5asoCXnVFwo+h7pf6eV0M=;
 b=HlGjLJrc6TRMyzk0qmNZ0nKyVjQaohvPTbW69u9suDDLoHX3v3k4L3JQPbJDnokDyOVCR2
 RFr3r3jCpAZSWG//l6F/UTt5KZzBizoG4fhRSmzryb8CZSeIJfZRUMVHDpGK3DuzOhouHR
 eDb5FC21bQXV7Yq8Gmw9GRK4p6++TP0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Gq-LtjWbPMquLi7g9rFglw-1; Tue, 23 Jul 2024 08:39:20 -0400
X-MC-Unique: Gq-LtjWbPMquLi7g9rFglw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b7a6d56e53so106429966d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 05:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721738360; x=1722343160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyj+SjRC+xai/hCiaIYcUU5asoCXnVFwo+h7pf6eV0M=;
 b=SigRryWVsOmd8wAmNmUJ61wgJshxN0PARNP6Ev02riV1f30NZ72Rla95m0yPYvzJlw
 azNCJh4QssqYwmXK0u1M6PHXWCx0sbC0kVmJ0lfi0cmfeLiHfLxfoJoM6xO0pRaFDUgh
 5ugSKfrjtuDstb8Iz+IBrOQnwAc01STVFf0ohQYbgLz3i+I2r3SLnkFZ9U/D9WEhkK0v
 UQQqzK/VKgODgMiEyJqkSiwEyvRnnA1D7e7Dg+61kUjmG8F93o4MitfByWxM1qtFhZQ5
 I4fDyaItjH7TOpFzMcUucXP0DbkWTKahmYRobqVK5MrIBKDF+H+XYsS5jMnPVSYgCFWT
 r0xQ==
X-Gm-Message-State: AOJu0Yzf1xjEKmKYU1m9vsLIEKWLwnnGiChZQQQnmPP2D5Y3ObDbLMWT
 wN5zxFJjWMV7L/hWkizduosAjVPgfZMW7eim0Wj2PzOX9Dg+xkQ/sHx/UcCofMlXeOcdiAU10rG
 JhsnOhBY5TtxmderHpmPpOkDK8g+DH4l6incFNNQIwLB9pYG3iKlfTieWygTnaO6MLR41zM9Dxa
 zeJlYyv/rkCdzuFC5TnygbTGnE1IE=
X-Received: by 2002:ad4:5f4f:0:b0:6b5:8913:d63a with SMTP id
 6a1803df08f44-6b984330bc3mr31953466d6.12.1721738360439; 
 Tue, 23 Jul 2024 05:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEum9BqgCoy0kPjf6ENDt2OOHXt0/t4DmR2IT0slpRcxNMnGTerfS7DPMWjkEGmEcMqQFIZOTphSSU5+YKfAuQ=
X-Received: by 2002:ad4:5f4f:0:b0:6b5:8913:d63a with SMTP id
 6a1803df08f44-6b984330bc3mr31953286d6.12.1721738360048; Tue, 23 Jul 2024
 05:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240723103542.2998235-1-berrange@redhat.com>
In-Reply-To: <20240723103542.2998235-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jul 2024 16:39:09 +0400
Message-ID: <CAMxuvawXVSJq82BCBH0+MvA2b0wQcSH1pgUTF-DAuH713sWquw@mail.gmail.com>
Subject: Re: [PATCH] meson: build chardev trace files when have_block
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000058e84f061de97399"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--00000000000058e84f061de97399
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 2:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The QSD depends on chardev code, and is built when have_tools is
> true. This means conditionalizing chardev trace on have_system
> is wrong, we need have_block which is set have_system || have_tools.
>
> This latent bug was historically harmless because only the spice
> chardev included tracing, which wasn't built in a !have_system
> scenario.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This is an add-on needed for:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05068.html
>
> since I discovered a tools-only build fails
>
> diff --git a/meson.build b/meson.build
> index a1e51277b0..d3850a8c0f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3327,6 +3327,7 @@ if have_block
>    trace_events_subdirs +=3D [
>      'authz',
>      'block',
> +    'chardev',
>      'io',
>      'nbd',
>      'scsi',
> @@ -3338,7 +3339,6 @@ if have_system
>      'audio',
>      'backends',
>      'backends/tpm',
> -    'chardev',
>      'ebpf',
>      'hw/9pfs',
>      'hw/acpi',
> --
> 2.45.2
>
>

--00000000000058e84f061de97399
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 23, 2024 at 2:35=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">The QSD depends on chardev code, and is built when have_tools=
 is<br>
true. This means conditionalizing chardev trace on have_system<br>
is wrong, we need have_block which is set have_system || have_tools.<br>
<br>
This latent bug was historically harmless because only the spice<br>
chardev included tracing, which wasn&#39;t built in a !have_system<br>
scenario.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
This is an add-on needed for:<br>
<br>
=C2=A0 <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2024-07/=
msg05068.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.or=
g/archive/html/qemu-devel/2024-07/msg05068.html</a><br>
<br>
since I discovered a tools-only build fails<br>
<br>
diff --git a/meson.build b/meson.build<br>
index a1e51277b0..d3850a8c0f 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3327,6 +3327,7 @@ if have_block<br>
=C2=A0 =C2=A0trace_events_subdirs +=3D [<br>
=C2=A0 =C2=A0 =C2=A0&#39;authz&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;block&#39;,<br>
+=C2=A0 =C2=A0 &#39;chardev&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;io&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;nbd&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;scsi&#39;,<br>
@@ -3338,7 +3339,6 @@ if have_system<br>
=C2=A0 =C2=A0 =C2=A0&#39;audio&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;backends&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;backends/tpm&#39;,<br>
-=C2=A0 =C2=A0 &#39;chardev&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;ebpf&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/9pfs&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/acpi&#39;,<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>

--00000000000058e84f061de97399--


