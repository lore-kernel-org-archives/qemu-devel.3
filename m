Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6173D59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8j8T-0003Eo-UU; Wed, 06 Nov 2024 11:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8j8R-0003EM-H3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8j8P-0007EH-GV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730911430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/hWVPrwnWBd0v3Qd3Hqqaui166w8LXGRrbV48fJYt0=;
 b=Au203wvaMGi7ti4kGpNgb16wWRh3qXEZaz5F5OgdPYb9N0tfMShDfaIvrhwt47w9fauGnj
 bAnAKywkDs09ZcSLt6iSY2HgWpo+j/e4HK1A4URcTxE0UKRbF3btlSPQBeVSJlpmiPfaK+
 lnlIG7YoWnI9YuICQIb5IQHKqHwzUnw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Kp2zUmRSPyiCXe6GoqS0tg-1; Wed, 06 Nov 2024 11:43:46 -0500
X-MC-Unique: Kp2zUmRSPyiCXe6GoqS0tg-1
X-Mimecast-MFC-AGG-ID: Kp2zUmRSPyiCXe6GoqS0tg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbf054c552so49716d6.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730911425; x=1731516225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/hWVPrwnWBd0v3Qd3Hqqaui166w8LXGRrbV48fJYt0=;
 b=VdVWaT5x8kCGoMyD+LyPxS4yWlyAip95/sIQu0c0c78kMLnrwvDxiTtfQCUQyrgr0x
 L/4KGZvljuXItonI5Y3IhMXeiJjP3iMmhGQ8OdAS5wbKa/WtxHE0qQQI8zQiq/qns7UU
 KR1tKCxkuHFJeWrGdvbQcuue9izVwfwG8wpsezvh6KE5kRCjxN0n5M4dgfqylP+Lf+D8
 sPrpschSM0dTXoopfwKVIg4d9JL0aBuXdEMqru8q1HZHjJmKDL78+bR69Vu0gxhv80K3
 vtkAo9MfFylET+ZuIm9haRffCDkY70CANG7re4Fqsa8Q2Zk5rgl+gJ5StBzAJWXkcG/f
 O7YA==
X-Gm-Message-State: AOJu0YxGehfTdB0cRlD6MY3EzyznWre5FY4bCAf5/lq03paAiKY7HAhe
 eEiHNeRXlREGx2UUEClEDaLCDrhRnnnkZN7TFCZcfLY9YI3wrTCG44+ErOq+SVs+ZPdzyRIFrxv
 ovVnebo4VHvYMi7vMUGJGVRn33vQnD2qLVi2BV5EYTDsQWxZv6oChpb+rR5O8tRXYjTv9xg0o9l
 Lmpwb/FQBYG4c+9Dg7rxQKxSrTGGMrXjUw4ESI+g==
X-Received: by 2002:a05:6214:3186:b0:6cc:3a:a7f0 with SMTP id
 6a1803df08f44-6d185857230mr614680086d6.44.1730911424823; 
 Wed, 06 Nov 2024 08:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBq5B24Re2z3OINdmC2brOYKoMmGYzohWGKzAVB49k45e/tqq4Y6UeeuB6vS83mER3FV5NmbiP1b8QmexLGDM=
X-Received: by 2002:a05:6214:3186:b0:6cc:3a:a7f0 with SMTP id
 6a1803df08f44-6d185857230mr614679826d6.44.1730911424556; Wed, 06 Nov 2024
 08:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20241106084134.1133061-1-demeng@redhat.com>
 <20241106084134.1133061-2-demeng@redhat.com>
 <ZytwrvtfR6AxpkYZ@redhat.com>
In-Reply-To: <ZytwrvtfR6AxpkYZ@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 6 Nov 2024 18:43:33 +0200
Message-ID: <CAPMcbCo6d_8Lw3qY_vFcDWK98L6wg1dKHYRVmwf_rs_AGtOTkA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] qemu-ga: Add 'Null' check and Redefine 'route'
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>, michael.roth@amd.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="0000000000009945eb0626413864"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--0000000000009945eb0626413864
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Nov 6, 2024 at 3:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Wed, Nov 06, 2024 at 04:41:32PM +0800, Dehan Meng wrote:
> > sscanf return values are checked and add 'Null' check for
> > mandatory parameters. And merged redundant route and
> > networkroute variables.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 86 +++++++++++++++++++++++---------------------
> >  1 file changed, 45 insertions(+), 41 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000009945eb0626413864
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 6=
, 2024 at 3:35=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, Nov 06, 2024 at 04:41:32PM +08=
00, Dehan Meng wrote:<br>
&gt; sscanf return values are checked and add &#39;Null&#39; check for<br>
&gt; mandatory parameters. And merged redundant route and<br>
&gt; networkroute variables.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 86 +++++++++++++++++++++++---------------=
------<br>
&gt;=C2=A0 1 file changed, 45 insertions(+), 41 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--0000000000009945eb0626413864--


