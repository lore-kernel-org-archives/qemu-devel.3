Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3675CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KZA-0000cl-7f; Wed, 24 Sep 2025 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1v1KZ7-0000cc-Cv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1v1KZ0-0002Dh-UW
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758701356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGhzHjNIONN+YBvZ5riEu/H0o9GnjG4UMAzyKb+BwQs=;
 b=YKOt90Sc7GCcPJUv9xkvni+2/CE7aE3N1OYOvyG5zhNmv7QaJ+sL8l0n6/z4abj7GzWbYv
 VIWyj7Bkr3F09M+v+VOgIcTEwr/fXgLM5sURaOW1jsrrXi4fgfrHmHkPN79zJZwQcir2Do
 8s6Q6eBMtzoOxpYeQcCK2ehaH5S6PpM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-qbJzhiYHMCev_rN2W4sflw-1; Wed, 24 Sep 2025 04:09:14 -0400
X-MC-Unique: qbJzhiYHMCev_rN2W4sflw-1
X-Mimecast-MFC-AGG-ID: qbJzhiYHMCev_rN2W4sflw_1758701353
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4d602229d20so20357151cf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 01:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758701353; x=1759306153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGhzHjNIONN+YBvZ5riEu/H0o9GnjG4UMAzyKb+BwQs=;
 b=Yb31JJf3mEfZRbmCNqWFOWaZ+tL2oar6qJNkm9TseiwJoODX9BfS4i4g6XM4wAbKT1
 ytEHWPkSPIrFLIx+27QA38PdC42XglIMy4b6XMWki1HsJLVgqPG7k1lJnvmYVG/cK8tb
 lJwnn428xg7BhkyUBYPt4TAzp54nJmgWym/4kd/5yt5oDpuj8QI59x9EfgRFLiQaUsqv
 8iC4i3/PDFgNqNbQus4OO2BNN9lBouPA06tbgdYfJxLlc7yVjCkM+Gz2Pvh0QQcMbXEd
 pdVEb7rRb9rn4btXwyBCin/rE292K8yAiEa0AdlVFgqpcSKIsxVGwQuUULjarrj3pxiJ
 UVKw==
X-Gm-Message-State: AOJu0Yzxdw8FnXb3P4bZKtHHwFL8/SM5uywv3dOMVtM72H2IRfgV9Iuv
 5xH6PoHL3+roAvfruzzRzXq+ntqFc/monwCSBDdAFaiXrFpMT1Fae6l0JVbqG5MpQ11M/pgNPlZ
 MZ1x+7U+m9MXZ3nL1c7r40lMLiAe3TRsXclrisQ7mGB+6RrM1hpOtTkL3LESgV5X865bESlcGQJ
 qVCqnb8Kws4M2kYY6Tn0YcCTOib26QaR0=
X-Gm-Gg: ASbGncuvQRaoCVfIztH9wZmStEbxNX54LRqqe0U5O/WQEODrD/hejfAoBicuIh1rNhg
 7qSq3Xc8pbG+6iiHOyLje8PhOKTiEznuPNKMtb7L7lh53769XGBqdW9MIJAlipCG2g7B8pg9iU+
 /c0WX7tHzWy1VfW9eL6kQmp7Q=
X-Received: by 2002:a05:622a:1b88:b0:4c0:769e:7ae3 with SMTP id
 d75a77b69052e-4d36b7a2e03mr59678651cf.37.1758701353052; 
 Wed, 24 Sep 2025 01:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKkWnZJUbrBWrRBcEbrMgLdRvaG1wSWJUY1UFs4ZetZUKeNOxTPfbT4jtnjrvuJz40yjNzNho5HCJyZYvTJQU=
X-Received: by 2002:a05:622a:1b88:b0:4c0:769e:7ae3 with SMTP id
 d75a77b69052e-4d36b7a2e03mr59678481cf.37.1758701352675; Wed, 24 Sep 2025
 01:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250923113243.78244-1-minglei.liu@smartx.com>
In-Reply-To: <20250923113243.78244-1-minglei.liu@smartx.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 24 Sep 2025 11:09:01 +0300
X-Gm-Features: AS18NWA9fwPShgiHG4q9xQ9kaKDFc3ztsqWTo6L-WgcWMsz6KFnWrG0RdNsXt8U
Message-ID: <CAPMcbCoR++5+eCLCVe9r8kRH7oJqJ39o962kmZSTnCdZgqB9dQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Improve Windows filesystem space info retrieval logic
To: Minglei Liu <minglei.liu@smartx.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000064941d063f879111"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--00000000000064941d063f879111
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Best Regards,
Kostiantyn Kostiuk.


On Tue, Sep 23, 2025 at 2:33=E2=80=AFPM Minglei Liu <minglei.liu@smartx.com=
> wrote:

> From: "minglei.liu" <minglei.liu@smartx.com>
>
> Previously, disk space reporting only worked for volumes with drive
> letters,
> skipping those without (e.g. System Reserved).
>
> This change always calls GetDiskFreeSpaceEx with fs->name, which is a
> volume GUID path. Windows APIs accept both drive letters (e.g. "C:\")
> and volume GUIDs (e.g. "\\?\Volume{GUID}\") as valid lpDirectoryName
> parameters, so space reporting is now consistent across all volumes.
>
> Reference:
> https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file
>
> Signed-off-by: minglei.liu <minglei.liu@smartx.com>
> ---
>  qga/commands-win32.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 8227480810..acc2c11589 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1164,15 +1164,15 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(char *guid, Error **errp)
>          fs->mountpoint =3D g_strdup("System Reserved");
>      } else {
>          fs->mountpoint =3D g_strndup(mnt_point, len);
> -        if (GetDiskFreeSpaceEx(fs->mountpoint,
> -                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
> -                               (PULARGE_INTEGER) & i64TotalBytes,
> -                               (PULARGE_INTEGER) & i64FreeBytes)) {
> -            fs->used_bytes =3D i64TotalBytes - i64FreeBytes;
> -            fs->total_bytes =3D i64TotalBytes;
> -            fs->has_total_bytes =3D true;
> -            fs->has_used_bytes =3D true;
> -        }
> +    }
> +    if (GetDiskFreeSpaceEx(fs->name,
> +                            (PULARGE_INTEGER) & i64FreeBytesToCaller,
> +                            (PULARGE_INTEGER) & i64TotalBytes,
> +                            (PULARGE_INTEGER) & i64FreeBytes)) {
> +        fs->used_bytes =3D i64TotalBytes - i64FreeBytes;
> +        fs->total_bytes =3D i64TotalBytes;
> +        fs->has_total_bytes =3D true;
> +        fs->has_used_bytes =3D true;
>      }
>      wcstombs(fs_name, wfs_name, sizeof(wfs_name));
>      fs->type =3D g_strdup(fs_name);
> --
> 2.39.5 (Apple Git-154)
>
>

--00000000000064941d063f879111
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><div><br></div><div>=
<div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div><=
/div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 23, 2025 at 2:33=E2=
=80=AFPM Minglei Liu &lt;<a href=3D"mailto:minglei.liu@smartx.com">minglei.=
liu@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: &quot;minglei.liu&quot; &lt;<a href=3D"mailto:minglei.l=
iu@smartx.com" target=3D"_blank">minglei.liu@smartx.com</a>&gt;<br>
<br>
Previously, disk space reporting only worked for volumes with drive letters=
,<br>
skipping those without (e.g. System Reserved).<br>
<br>
This change always calls GetDiskFreeSpaceEx with fs-&gt;name, which is a<br=
>
volume GUID path. Windows APIs accept both drive letters (e.g. &quot;C:\&qu=
ot;)<br>
and volume GUIDs (e.g. &quot;\\?\Volume{GUID}\&quot;) as valid lpDirectoryN=
ame<br>
parameters, so space reporting is now consistent across all volumes.<br>
<br>
Reference:<br>
<a href=3D"https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-=
file" rel=3D"noreferrer" target=3D"_blank">https://learn.microsoft.com/en-u=
s/windows/win32/fileio/naming-a-file</a><br>
<br>
Signed-off-by: minglei.liu &lt;<a href=3D"mailto:minglei.liu@smartx.com" ta=
rget=3D"_blank">minglei.liu@smartx.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 18 +++++++++---------<br>
=C2=A01 file changed, 9 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 8227480810..acc2c11589 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1164,15 +1164,15 @@ static GuestFilesystemInfo *build_guest_fsinfo(char=
 *guid, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs-&gt;mountpoint =3D g_strdup(&quot;Syst=
em Reserved&quot;);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs-&gt;mountpoint =3D g_strndup(mnt_point=
, len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetDiskFreeSpaceEx(fs-&gt;mountpoint,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(PULARGE_INTEGER) &amp; i64FreeBytesT=
oCaller,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(PULARGE_INTEGER) &amp; i64TotalBytes=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(PULARGE_INTEGER) &amp; i64FreeBytes)=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D i64TotalBy=
tes - i64FreeBytes;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D i64TotalB=
ytes;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D true;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (GetDiskFreeSpaceEx(fs-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (PULARGE_INTEGER) &amp; i64FreeBytesToCaller,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (PULARGE_INTEGER) &amp; i64TotalBytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (PULARGE_INTEGER) &amp; i64FreeBytes)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D i64TotalBytes - i64FreeB=
ytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D i64TotalBytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0wcstombs(fs_name, wfs_name, sizeof(wfs_name));<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;type =3D g_strdup(fs_name);<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div>

--00000000000064941d063f879111--


