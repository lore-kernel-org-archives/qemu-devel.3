Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2510CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3UgL-0000QP-Ui; Tue, 30 Sep 2025 03:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v3UgI-0000PK-V1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v3UgB-0005TQ-U4
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759216898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AD9dpKMBG627AfVhXFMzkbtZ8FVc1kWYKYGJ3Vrt7L4=;
 b=N0Udig7X/hovV9tY/M1g5vs5r5SG8YG0udQaw0McTFX6ClrSaiid61Q0ZvmfmtiwL1pjkN
 PcaCTPuPWWPIUk3RZsFC2Bm8DUrcD+y4+Q8dUjV2JO2YaDeUZx0P2P1fZrFxJPfRtbeELE
 8rcew/9WHOR6SoCebhPQocW+bt5A8H0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-ajekJHImMF-NUtTOhPSmfw-1; Tue, 30 Sep 2025 03:21:36 -0400
X-MC-Unique: ajekJHImMF-NUtTOhPSmfw-1
X-Mimecast-MFC-AGG-ID: ajekJHImMF-NUtTOhPSmfw_1759216895
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32df881dce2so5906685a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 00:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759216895; x=1759821695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AD9dpKMBG627AfVhXFMzkbtZ8FVc1kWYKYGJ3Vrt7L4=;
 b=eyhkZuQ0sstEuSG4otyj5wyz5H3SP+z6SNNTGKxj1ggi5sMTHhP9++aZv6vIUJbhvA
 5yxmmqwo7BOljeh97bCpuMo7vurEMi4ni+2pVPss1D5yPbFqKtYwh4pmlcrT4PtPrtIy
 BFYWV18tNlzVWdldZsllgzKHde7bQlknRcY5PKXDv43huA6MVaZ8sMt4YsGVAPTq+XxG
 FyXdYo4FU9PAtBsKgsbVv03bedk5J7dIcIvm849W0l44udffnT8HmLJRkV4zeM/MB8hG
 8PZoSzlAmE+LKbJCGZQZYttZtjUjZzeyUvLEx+aDDiakyqfV41HGNYe8h/tZO7+ghF4l
 hvfg==
X-Gm-Message-State: AOJu0YwvjAC/GFgtCCwvHsMtpM0pPvbgfJTcTqNesdNCcxsp9QMiWo9S
 g++jFyn0OMm50i/5/A5QdyPTfdoJY/pD4A3NO/i8EHnXwZqGDi0k+SOuE32HQKlnY3hsVdQ0nZD
 IDUNA2eNGwEXq4NH/+0vqWjIZ+wDKXwEwf0+nCiBLrgqu9C7yChseBEQc/5VTajZIkAboVYnYBl
 rsL5QQVykg37c0EPLunmUsIkNPP6q25I8=
X-Gm-Gg: ASbGnctj1sLQfU2GQ+P7Bfv9EMEEIquHwY1EC/PRahY1SaBHgwYznhUYmYM2xVWudEC
 dHIiIjDy8yhkkG0MeriflO+1wu/dYg8v4lxqYCPM4x1BbzdAIzYmoQDWdXoguDCdMDR/ZAozZUA
 9gwPApBpTsD04VbOKi6kc0kyfoSM/NILWuOMkgIejGxNfLaOQrWFyvT85UF2g=
X-Received: by 2002:a17:90b:1647:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-3342a3471ccmr22758504a91.37.1759216895426; 
 Tue, 30 Sep 2025 00:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQfSQZj3ar8v38+tKLzJDKivHUqgRzCRYqMwpzJlnjxqGZBojdkauY5QpqVIbaqGoc4tsEYxNEbJK747Wb61s=
X-Received: by 2002:a17:90b:1647:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-3342a3471ccmr22758484a91.37.1759216894917; Tue, 30 Sep 2025
 00:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250930071419.117592-1-thuth@redhat.com>
In-Reply-To: <20250930071419.117592-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Sep 2025 11:21:23 +0400
X-Gm-Features: AS18NWDVszFkr7CjcqTPdkxOvT8_wNmAXVJV4zeYxTN3mktGGhjCpwhmts7ahAk
Message-ID: <CAMxuvax4qzyDQcKf6Fan_hJTggwa4fcMjaQH6Qhz=NWxvbwp4A@mail.gmail.com>
Subject: Re: [PATCH] ui/icons/qemu.svg: Add metadata information (author,
 license) to the logo
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001ae188063fff9a84"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000001ae188063fff9a84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 30, 2025 at 11:14=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:

> From: Thomas Huth <thuth@redhat.com>
>
> We've got two versions of the QEMU logo in the repository, one with
> the whole word "QEMU" (pc-bios/qemu_logo.svg) and one that only contains
> the letter "Q" (ui/icons/qemu.svg). While qemu_logo.svg contains the
> proper metadata with license and author information, this is missing
> from the ui/icons/qemu.svg file. Copy the meta data there so that
> people have a chance to know the license of the file if they only
> look at the qemu.svg file.
>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3139
> Signed-off-by: Thomas Huth <thuth@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/icons/qemu.svg | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/ui/icons/qemu.svg b/ui/icons/qemu.svg
> index 24ca23a1e95..f2500de3391 100644
> --- a/ui/icons/qemu.svg
> +++ b/ui/icons/qemu.svg
> @@ -918,7 +918,26 @@
>          <dc:format>image/svg+xml</dc:format>
>          <dc:type
>             rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
> -        <dc:title />
> +        <dc:title>Kew the Angry Emu</dc:title>
> +        <dc:creator>
> +          <cc:Agent>
> +            <dc:title>Beno=C3=AEt Canet</dc:title>
> +          </cc:Agent>
> +        </dc:creator>
> +        <dc:rights>
> +          <cc:Agent>
> +            <dc:title>CC BY 3.0</dc:title>
> +          </cc:Agent>
> +        </dc:rights>
> +        <dc:publisher>
> +          <cc:Agent>
> +            <dc:title>QEMU Community</dc:title>
> +          </cc:Agent>
> +        </dc:publisher>
> +        <dc:date>2012-02-15</dc:date>
> +        <cc:license
> +           rdf:resource=3D"http://creativecommons.org/licenses/by/3.0/" =
/>
> +        <dc:source>
> https://lists.gnu.org/archive/html/qemu-devel/2012-02/msg02865.html
> </dc:source>
>        </cc:Work>
>      </rdf:RDF>
>    </metadata>
> --
> 2.51.0
>
>

--0000000000001ae188063fff9a84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 30, 2=
025 at 11:14=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com"=
>thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" =
target=3D"_blank">thuth@redhat.com</a>&gt;<br>
<br>
We&#39;ve got two versions of the QEMU logo in the repository, one with<br>
the whole word &quot;QEMU&quot; (pc-bios/qemu_logo.svg) and one that only c=
ontains<br>
the letter &quot;Q&quot; (ui/icons/qemu.svg). While qemu_logo.svg contains =
the<br>
proper metadata with license and author information, this is missing<br>
from the ui/icons/qemu.svg file. Copy the meta data there so that<br>
people have a chance to know the license of the file if they only<br>
look at the qemu.svg file.<br>
<br>
Closes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3139" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/3139</a><br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/icons/qemu.svg | 21 ++++++++++++++++++++-<br>
=C2=A01 file changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/ui/icons/qemu.svg b/ui/icons/qemu.svg<br>
index 24ca23a1e95..f2500de3391 100644<br>
--- a/ui/icons/qemu.svg<br>
+++ b/ui/icons/qemu.svg<br>
@@ -918,7 +918,26 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;dc:format&gt;image/svg+xml&lt;/dc:for=
mat&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;dc:type<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rdf:resource=3D&quot;<a href=3D"h=
ttp://purl.org/dc/dcmitype/StillImage" rel=3D"noreferrer" target=3D"_blank"=
>http://purl.org/dc/dcmitype/StillImage</a>&quot; /&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:title /&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:title&gt;Kew the Angry Emu&lt;/dc:title=
&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:creator&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:title&gt;Beno=C3=AEt Cane=
t&lt;/dc:title&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/dc:creator&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:rights&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:title&gt;CC BY 3.0&lt;/dc=
:title&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/dc:rights&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:publisher&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:title&gt;QEMU Community&l=
t;/dc:title&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/cc:Agent&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;/dc:publisher&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:date&gt;2012-02-15&lt;/dc:date&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;cc:license<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdf:resource=3D&quot;<a href=3D"h=
ttp://creativecommons.org/licenses/by/3.0/" rel=3D"noreferrer" target=3D"_b=
lank">http://creativecommons.org/licenses/by/3.0/</a>&quot; /&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;dc:source&gt;<a href=3D"https://lists.gnu.=
org/archive/html/qemu-devel/2012-02/msg02865.html" rel=3D"noreferrer" targe=
t=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2012-02/msg02865=
.html</a>&lt;/dc:source&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/cc:Work&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/rdf:RDF&gt;<br>
=C2=A0 =C2=A0&lt;/metadata&gt;<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000001ae188063fff9a84--


