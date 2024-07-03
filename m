Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A47EC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1uJ-0007Ek-H1; Wed, 03 Jul 2024 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP1uH-0007Dm-RE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP1uG-0006yP-9I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 11:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720020507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3lmAG+HWZl52bLJ9r1BoJ8Mj94xanU1FlSI8jZcHU5Y=;
 b=f9PgM7r/AskAa6GdU1VEFf1npTJBeOHSU/4otpfTVGmsAf1tkfOgm8PhtNWyMgLSgOU58d
 v7q8F/KWvNTSBfbYN69bfpnYSHoaqW6z2Jox4clJv16qF1LbLRNmMMRCHQXIc5CdC4jBie
 f9yeFQS+PLCePOITrbpDXahr6+qrDuo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2hvzHZ9XO4GGK3k2K2Y1og-1; Wed, 03 Jul 2024 11:28:25 -0400
X-MC-Unique: 2hvzHZ9XO4GGK3k2K2Y1og-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c7316658ccso3771055a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720020505; x=1720625305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lmAG+HWZl52bLJ9r1BoJ8Mj94xanU1FlSI8jZcHU5Y=;
 b=MEruVroVkFOGneymdzu/k9KqqlSR04+aEe8LnUNAQkvsE+ZwpVvrVzqHNmLhuFgzo/
 kYO0Ptgjo9XuA+inwfluiJWps6vLNpCamVP6PyCKVmyFHqhzby8QqECmP7wFsccAFcKe
 4ZHyQhKfKa7yRJesV/kbUCF20Q+2NYalyJeakZoU1uwQZldXOUDtjBbOMNP6x6O1aYL1
 pzewGGCCNH/HJErENkO+SSiLZDw7JbxTjTiKHkClj3nvZc8XhHDlU+BiKeREyMZMBytn
 KWftzhM+UYiFXaPSLByzpdflymzFFseGBztLL7dfndYP0G4WbmgW3lmCsUAdFsbBbZZ0
 hFOQ==
X-Gm-Message-State: AOJu0YxH9FMEFnay86ChBv9RX66Nln88m7lzPTkWERw7hwi50sBH+3T8
 UGvwPcYX671t+THUHaSQyRAAnPUzK5klCPksYhVELj9lttxYpeX+r2hXTjt6wxJCQE6SDmEzvv8
 9Ed6GWMCoTxvmAJ2LjT7lrkbjsDSinpZCjsrHtTn9n4Zt1nadCOO12FdJjxNCjf4YTKmhbzJwrb
 YOD+gxGdJWIryi3ENT6t4zdSD9/vY=
X-Received: by 2002:a17:90a:2ecb:b0:2c9:6928:ac9b with SMTP id
 98e67ed59e1d1-2c96928aeeamr3141916a91.15.1720020504624; 
 Wed, 03 Jul 2024 08:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRtH8YH27mkkgUEFdWTDnpNSI/m3+Wrz7e7wZ+fwdBVhMjpvDE5mVyElQxYil/lVmENjP7+LUt/jxWoEM8GbQ=
X-Received: by 2002:a17:90a:2ecb:b0:2c9:6928:ac9b with SMTP id
 98e67ed59e1d1-2c96928aeeamr3141900a91.15.1720020504276; Wed, 03 Jul 2024
 08:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240703095310.1242102-1-armbru@redhat.com>
In-Reply-To: <20240703095310.1242102-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Jul 2024 11:28:12 -0400
Message-ID: <CAFn=p-YBuDMGFPMT6NTXHq5LhNT6++x49wD2qkg4WhmYR=T__Q@mail.gmail.com>
Subject: Re: [PATCH] qapi/qom: Document feature unstable of @x-vfio-user-server
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002a1987061c597b8e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--0000000000002a1987061c597b8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:53=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Commit 8f9a9259d32c added ObjectType member @x-vfio-user-server with
> feature unstable, but neglected to explain why it is unstable.  Do
> that now.
>
> Fixes: 8f9a9259d32c (vfio-user: define vfio-user-server object)
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: John G Johnson <john.g.johnson@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: qemu-stable@nongnu.org


Reported-by: John Snow <jsnow@redhat.com>

(... This is a joke, to be extremely clear)


>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>


> ---
>  qapi/qom.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..3c0f8c633d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1012,7 +1012,8 @@
>  #
>  # Features:
>  #
> -# @unstable: Member @x-remote-object is experimental.
> +# @unstable: Members @x-remote-object and @x-vfio-user-server are
> +# experimental.
>  #
>  # Since: 6.0
>  ##
> --
> 2.45.0
>
>

--0000000000002a1987061c597b8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, 2024 at 5:53=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Commit 8f9a9259d32c added ObjectType member @x-vfio-user-server with<br>
feature unstable, but neglected to explain why it is unstable.=C2=A0 Do<br>
that now.<br>
<br>
Fixes: 8f9a9259d32c (vfio-user: define vfio-user-server object)<br>
Cc: Elena Ufimtseva &lt;<a href=3D"mailto:elena.ufimtseva@oracle.com" targe=
t=3D"_blank">elena.ufimtseva@oracle.com</a>&gt;<br>
Cc: John G Johnson &lt;<a href=3D"mailto:john.g.johnson@oracle.com" target=
=3D"_blank">john.g.johnson@oracle.com</a>&gt;<br>
Cc: Jagannathan Raman &lt;<a href=3D"mailto:jag.raman@oracle.com" target=3D=
"_blank">jag.raman@oracle.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a></blockquote><div><br></div><div>Reported-by: John Snow &lt;=
<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</div><div><br>=
</div><div>(... This is a joke, to be extremely clear)<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@re=
dhat.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
---<br>
=C2=A0qapi/qom.json | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qapi/qom.json b/qapi/qom.json<br>
index 8bd299265e..3c0f8c633d 100644<br>
--- a/qapi/qom.json<br>
+++ b/qapi/qom.json<br>
@@ -1012,7 +1012,8 @@<br>
=C2=A0#<br>
=C2=A0# Features:<br>
=C2=A0#<br>
-# @unstable: Member @x-remote-object is experimental.<br>
+# @unstable: Members @x-remote-object and @x-vfio-user-server are<br>
+# experimental.<br>
=C2=A0#<br>
=C2=A0# Since: 6.0<br>
=C2=A0##<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div>

--0000000000002a1987061c597b8e--


