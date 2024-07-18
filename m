Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFD7C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULFg-0006BH-JU; Thu, 18 Jul 2024 03:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sULFe-00064i-SG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sULFc-0003B2-AZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721286506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgQFGN5FbTjg4AcA020xtib6FIYbdQcRg9s1XZVYD6U=;
 b=LPDIaeiJDz1pZXmeDc0M3uMllZSLyVGzLygmWczxiH0ePIu7IE+4mwejywdlw8OPWMvfpo
 a0Yhn2oRG65toSpftsi5EpH4nLCxvyqLPM6RpcVbPbM6A9uX/C3f5xqs0YtSVAyDTxwQCP
 +8tyfvs/csGU7yBL9SJjgLjFDjeKtcw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-cA3Z-tAfNyS9xS0BBBLpgg-1; Thu, 18 Jul 2024 03:08:23 -0400
X-MC-Unique: cA3Z-tAfNyS9xS0BBBLpgg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-64a5503e253so14328507b3.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 00:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721286502; x=1721891302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgQFGN5FbTjg4AcA020xtib6FIYbdQcRg9s1XZVYD6U=;
 b=ULa2fXfBOo2Hdy7TyYLU2pZEW1J/7o91FnUQYzF75r/h0wCXH97Hixuc+77F4YV81/
 87ChEgFO2xSwurzJIxMDo+mxf4LerlhUHPOXYkyyct8z4FiHTf/4LHTnTeTDcTsu12WA
 46jEYqVCiggtnhAkVwsgyaWEJrmXEig25aIFDsuTmu5o5PQ42DOY3smcBeIp9fAiVePr
 EmNc6EwJDwl/hRGxa8mMpRnHuKQbqZ1Pw0RNJczETt1I3W3leXcU9KTlnV4PKMI9HwBv
 fAqVzTmyZxUH2cy80T6HX5XT1+m3tDvf87l997O1HAETA3i0IeQcL7J8uoN2QqknPfiG
 91Eg==
X-Gm-Message-State: AOJu0YzQ+rBPBG0Nho+b7Lzzfr1w7q9Gy2SNlu2Be+mrbDF96+Xe1IPI
 +AJcTmBnRVI3giCELD4WTfkOHWob4D7OPDoJIyV2ZBBlxawu9oBlTarGHpxBK1WE6+9KsZXBXoS
 2VOvb0w2bXL2hQPH6Uf37QELhgZW/h1cJN+1F4dTl8SjKBUoJL9zJ9IoRrRMxOb/5hylNfuDMet
 PXKyko0s8LMwQgNm2RIDsZdIYIuco=
X-Received: by 2002:a05:6902:2b08:b0:e03:41c8:4fbf with SMTP id
 3f1490d57ef6-e05feae1051mr2275340276.15.1721286502488; 
 Thu, 18 Jul 2024 00:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBqznHaEAF/8Z+3JWKuznA/wuqZKVsCC/6N8FzqzNX5g6axX8yC4Og/XaZevGDOgENQK1pAj5Q9aSzR/UcaWk=
X-Received: by 2002:a05:6902:2b08:b0:e03:41c8:4fbf with SMTP id
 3f1490d57ef6-e05feae1051mr2275327276.15.1721286502150; Thu, 18 Jul 2024
 00:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240717140025.66397-1-philmd@linaro.org>
In-Reply-To: <20240717140025.66397-1-philmd@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 18 Jul 2024 10:08:11 +0300
Message-ID: <CAPMcbCrX6Xyz+UNqENmTDCt8aLdyQ4rMNzEVRJqHjZY1DTeTbA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Cover guest-agent in QAPI schema
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Dehan Meng <demeng@redhat.com>,
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000848a60061d803e38"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000848a60061d803e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Jul 17, 2024 at 5:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d9811458c..af4db698de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3219,6 +3219,7 @@ M: Eric Blake <eblake@redhat.com>
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: qapi/*.json
> +F: qga/qapi-schema.json
>  T: git https://repo.or.cz/qemu/armbru.git qapi-next
>
>  QObject
> --
> 2.41.0
>
>

--000000000000848a60061d803e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 1=
7, 2024 at 5:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Signed-off-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@li=
naro.org</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 7d9811458c..af4db698de 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3219,6 +3219,7 @@ M: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com=
" target=3D"_blank">eblake@redhat.com</a>&gt;<br>
=C2=A0M: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
=C2=A0S: Supported<br>
=C2=A0F: qapi/*.json<br>
+F: qga/qapi-schema.json<br>
=C2=A0T: git <a href=3D"https://repo.or.cz/qemu/armbru.git" rel=3D"noreferr=
er" target=3D"_blank">https://repo.or.cz/qemu/armbru.git</a> qapi-next<br>
<br>
=C2=A0QObject<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--000000000000848a60061d803e38--


