Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A1C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngl0-0003ei-0k; Fri, 22 Mar 2024 11:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rngky-0003ds-OO
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rngkw-0004N8-NN
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711121069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQD+A/PUn9SIj6wMoIbT++1G6yiiPyyQH/giOB5Psao=;
 b=LRXDEeHlszpiW5q6xj5GJNtxvNcYzTiAeAJsxDpBf2VCdX53r9jaG9xyVzlbhSrf83NgjS
 EqaouW98lq3LFXhQMUiE2B2JrgasC1ze3RfFMzJcqwaeDmImOfbmQrJ3mBzdy2wQfsIzd3
 Kwy8c61jUg9qqQpZhxNOFzl05bwvSU4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-CwNZQuYhO_WxB1Hq-tV0dw-1; Fri, 22 Mar 2024 11:24:26 -0400
X-MC-Unique: CwNZQuYhO_WxB1Hq-tV0dw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29ff65bbd63so1610345a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711121066; x=1711725866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sQD+A/PUn9SIj6wMoIbT++1G6yiiPyyQH/giOB5Psao=;
 b=pKjonz2CbLZq5N9EzxuHEfYQOJRhutRU8VB9D/mrhexiFgIN/+vW2TvMtFq6Ujjirk
 UdDz6ZPUq2GyneGhaSd/AzaAEdDT5H0MqkVwi2AZz0tztXMvYb9a1UcEtO+IbrWkv3cN
 M3u3kSu1yFKKZIOWuT2XOpRNGLxAP81NU0xC6oiBWq4sHI+x0snfB+y8ArU2nbQDy3i+
 ZkyE7t0dEXfFR/T6WZu/t/q8Tw5CWb9l0b4nHLd0vv50UHYOFe4jqKuvJLSMUn7q7fef
 h5xFOwPokSeFN48nT1Y34JVoueCuK6Wtvp3ZhlKgG9px/w8mWPYlVslDmWWEcWUbRZ1O
 mAOg==
X-Gm-Message-State: AOJu0YwhVIkoVToGZIQ0bHKhapslZsyLBsmxXPN5QSbHhJOLj31FjzsO
 KzW5bNZFHLkDiddyMUEFV2PFJczUoDh69Mo7LHBEbXTmGwz28XVBWKGDS2DGlRfI5uA3zhdBq+c
 geBD0ala0uc5eaSVLKHy6hDWpV4kolq8C2GpcvE/wZmQkdiVneIAF/n9BZPek8EVZFh0HMHrF4o
 1tG72UHHdU7PZHKSxPwEw7g2q9MhA=
X-Received: by 2002:a17:90a:fe88:b0:2a0:215f:dc9c with SMTP id
 co8-20020a17090afe8800b002a0215fdc9cmr2613443pjb.35.1711121065899; 
 Fri, 22 Mar 2024 08:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJdvocOCY7b1UMW68MhhcpWbfu/A3eaANnS5pmeALlmQ5NS43pFuVtjNhp41AYI6TmB6p2azwdDHiW025wj8=
X-Received: by 2002:a17:90a:fe88:b0:2a0:215f:dc9c with SMTP id
 co8-20020a17090afe8800b002a0215fdc9cmr2613417pjb.35.1711121065587; Fri, 22
 Mar 2024 08:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240322140910.328840-1-armbru@redhat.com>
 <20240322140910.328840-2-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Mar 2024 11:24:13 -0400
Message-ID: <CAFn=p-axf_Vy7aBPMBycY4ymOWLq6bgg06yy97GVgp3shAyBFA@mail.gmail.com>
Subject: Re: [PATCH 01/12] qapi: Drop stray Arguments: line from
 qmp_capabilities docs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000484e080614416bd6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

--000000000000484e080614416bd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, 10:09=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Reported-by: John Snow <jsnow@redhat.com>
> Fixes: 119ebac1feb2 (qapi-schema: use generated marshaller for
> 'qmp_capabilities')
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/control.json | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/qapi/control.json b/qapi/control.json
> index f404daef60..6bdbf077c2 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -11,8 +11,6 @@
>  #
>  # Enable QMP capabilities.
>  #
> -# Arguments:
> -#
>  # @enable: An optional list of QMPCapability values to enable.  The
>  #     client must not enable any capability that is not mentioned in
>  #     the QMP greeting message.  If the field is not provided, it
> --
> 2.44.0
>
>

--000000000000484e080614416bd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 22, 2024, 10:09=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Reported-by: John Snow &lt;<a hre=
f=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@re=
dhat.com</a>&gt;<br>
Fixes: 119ebac1feb2 (qapi-schema: use generated marshaller for &#39;qmp_cap=
abilities&#39;)<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/control.json | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/qapi/control.json b/qapi/control.json<br>
index f404daef60..6bdbf077c2 100644<br>
--- a/qapi/control.json<br>
+++ b/qapi/control.json<br>
@@ -11,8 +11,6 @@<br>
=C2=A0#<br>
=C2=A0# Enable QMP capabilities.<br>
=C2=A0#<br>
-# Arguments:<br>
-#<br>
=C2=A0# @enable: An optional list of QMPCapability values to enable.=C2=A0 =
The<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0client must not enable any capability that is no=
t mentioned in<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0the QMP greeting message.=C2=A0 If the field is =
not provided, it<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div></div></div>

--000000000000484e080614416bd6--


