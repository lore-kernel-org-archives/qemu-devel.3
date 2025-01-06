Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAFFE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 09:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUjYw-0001Lz-Si; Mon, 06 Jan 2025 04:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUjYv-0001LG-UM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUjYt-0001Ny-W8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736156293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBiMSAvDs8oyUKqUMfcqS2w9/gcB9FvrLUtPwnZ9hJQ=;
 b=F0DhipwYfU/ernpw9rncFgdkdGDe7TnlEgr8hXyUE//epX+vJcTnwh9z9cJnuGpvso1VFv
 PjX5b4m/vfCwVkinsJkna6jrsZfo/Gv5yQb5AVbN5QipKnpI2vGunWv/Ie9MC9sqMNX2zM
 QB+wrbX6LRXXPIzkDSCcG2CaoFvDZvM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-UckbSN5vNr-AaqbPrEUozQ-1; Mon, 06 Jan 2025 04:38:10 -0500
X-MC-Unique: UckbSN5vNr-AaqbPrEUozQ-1
X-Mimecast-MFC-AGG-ID: UckbSN5vNr-AaqbPrEUozQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f14fc179so407386736d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736156290; x=1736761090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kBiMSAvDs8oyUKqUMfcqS2w9/gcB9FvrLUtPwnZ9hJQ=;
 b=Qutp9ye1ejpCz3ka8bDOX4mRqbmDvYyjJjrmXIyxtW+sNZDKe7ul8qnUk9NNT4LOo4
 polHpbvTeA44lAzw7ku1cjQStOTuXveNNc53eVrqmhPUKg/AWccEK8p/3L61JPqrToqf
 AJCmLXRxBlL/HT1BffethSI83x00+LcrFWVOhBSouafK2ziti7kkI4G7PkpTzaS25Vv9
 q3NQJwgnCJxcinJEZ0S44xpRYfHgi5bucjbDBOoLF2YmfMDcjkb4EsIHdSOkROCy/4pQ
 WNs+JoO/X3SQ26gnYjh+YYyMjslgsmfPVrL3Uf1sUQnKnisBRa/17NVK5pOP7fXICsf/
 YYKQ==
X-Gm-Message-State: AOJu0YzGiSoFIzeUpNdPOq7221UJC4qWoQWOfw2uq5Wn+jTcJpzHmCW+
 sGHOWP8HVFS7F8mjHz1IkCBw6geaodtmpCaQOiLkGAUHGsz0WS6dpGr8qPJOlcIy+1gzB4k32mR
 7A/IAO2oE0AuDO/rgMoc+3J1LQmKlsGNt2JXJfeBVGw5v6xKkKEV96GNmJ8pABngwdk+FOhhXzP
 RVPF90zFoDhVeyLirOuIRxN7mB7qLOZ7Gn86s=
X-Gm-Gg: ASbGncuBDYUCkirqJyx1PcPIAHqTtPui2SVeHZy3qZZhw+5KZ4/MbazBCGeMfeDovLi
 N85rp2N+VEX+/yaeoSOqRmrA3s0E0/+ha/7SC8NgP
X-Received: by 2002:a05:6214:3291:b0:6d8:899e:c3be with SMTP id
 6a1803df08f44-6dd233afa69mr992641506d6.49.1736156290287; 
 Mon, 06 Jan 2025 01:38:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvdtCYCY7rTPXSvAuTysbbJfEpJfqkIKivFsJD0DQFHbw5Lk30V15C7I/T5SpgsQNLHoofsuu8eOFSoSNxThI=
X-Received: by 2002:a05:6214:3291:b0:6d8:899e:c3be with SMTP id
 6a1803df08f44-6dd233afa69mr992641356d6.49.1736156290075; Mon, 06 Jan 2025
 01:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20241216154552.213961-1-kkostiuk@redhat.com>
 <20241216154552.213961-2-kkostiuk@redhat.com>
In-Reply-To: <20241216154552.213961-2-kkostiuk@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 6 Jan 2025 11:37:59 +0200
Message-ID: <CAPMcbCrP4Y3uXYWzEQ3FpD_0Tm-Of6HJs7L8SEfwVxz1omO82g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] qga: Add log to guest-fsfreeze-thaw command
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f1de58062b06623c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000f1de58062b06623c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-posix.c | 2 ++
>  qga/commands-win32.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 636307bedf..359a56be81 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>      int ret;
>
>      ret =3D qmp_guest_fsfreeze_do_thaw(errp);
> +
>      if (ret >=3D 0) {
>          ga_unset_frozen(ga_state);
> +        slog("guest-fsthaw called");
>          execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
>      } else {
>          ret =3D 0;
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 038beb8cfa..7d8e260e1f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>      qga_vss_fsfreeze(&i, false, NULL, errp);
>
>      ga_unset_frozen(ga_state);
> +
> +    slog("guest-fsthaw called");
> +
>      return i;
>  }
>
> --
> 2.47.1
>
>
>

--000000000000f1de58062b06623c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping<br></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16, 2024 at 5:47=
=E2=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">k=
kostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:k=
kostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 2 ++<br>
=C2=A0qga/commands-win32.c | 3 +++<br>
=C2=A02 files changed, 5 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 636307bedf..359a56be81 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qmp_guest_fsfreeze_do_thaw(errp);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_THAW,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 038beb8cfa..7d8e260e1f 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0qga_vss_fsfreeze(&amp;i, false, NULL, errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
+<br>
+=C2=A0 =C2=A0 slog(&quot;guest-fsthaw called&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return i;<br>
=C2=A0}<br>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div>

--000000000000f1de58062b06623c--


