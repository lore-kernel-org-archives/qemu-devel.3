Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E9FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuXJn-0001kd-7S; Tue, 18 Mar 2025 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1tuXJl-0001jV-Bb
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1tuXJi-0006gh-Tf
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742305752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GISt53YRMSkCJ+okMqTpMizolCB9apwWpePnofOObM=;
 b=NZX+fTNP/cJ5Saf10CPWkkfWa7+uLDBsyfEopHWHL1VeZ45WmZ6jSkMtl+eNSBILLhXYCJ
 0xfudGWCprvZ9AYYoRP8bGaZpBcYdv8SBScRiIYcdhM1oGLAXBJgvnUH6jpu5IEgcz/G0L
 BUGVs73/uXzMbSr0q295rBwvxN2jzjo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-WhWXFeJqOlyLybplSHfcZw-1; Tue, 18 Mar 2025 09:47:55 -0400
X-MC-Unique: WhWXFeJqOlyLybplSHfcZw-1
X-Mimecast-MFC-AGG-ID: WhWXFeJqOlyLybplSHfcZw_1742305674
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac286ad635bso651516766b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 06:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742305674; x=1742910474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GISt53YRMSkCJ+okMqTpMizolCB9apwWpePnofOObM=;
 b=ZmapgjhdjMxqRNwgGxSdbnZDteJwq8+JFPnEks1xAOY/pC2i5lBP5B8hKcghjS48oK
 d192vEUg5sZmXzslzyu130HP7UMiTI5cqI/EaHlA6rzuiPasVdtPZeTV6F+YiEk0CM4R
 bbjkG8nOGuM4g319qqSfJFZ+RbDaAER2XTB+nmo6zpdycFWPZI9O5Q2DCrFNATcwv8K7
 fI4IACsqumpfHiYYenBU5KTpOQwI41TrfnPtxOKCaz5XnA+jIltpZjSmrtYTJpkUwXj/
 lFVm4LiBmbcFAMnbguQYUHqSkGxJkG/S9NT1FOzezTK25XnIpfcJIoJDcu5RRCTF8ym3
 UswQ==
X-Gm-Message-State: AOJu0YycGsd73s06FKjl/mCcwkyTHt/Mwe8ZMd3udo+zS0jsYnKHbWXh
 76aripmT6jVMqvjeELnRYyV63jhwwFjhjO+Vng1+j5gxwVOsjoaQkSztw6C+DrJzakIFeTmVVhk
 tezOOL+Lx31F9oHl07wFUQg4Y0Gd/cejXUDJk1yuMU2VjGUk3YFVLuoyCrtS+Mdg+YTv6pG2B0R
 QQ2qS/MMDLxkdKgMGeoRJy/Q6WMLU=
X-Gm-Gg: ASbGnctcoAJ5EtTUxAQQac6UNf9sNr/ixEih3XKIdSUUgDDIG2CTxgkRP8JgM/CUGWQ
 taGQeMPPd5PSCpFemtmMW55i75cpJEy4Dxx4c04f0hUE4E6t/ITkxqIPekNQOPd1IwNYaaF4GcA
 ==
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id
 a640c23a62f3a-ac38d405ac4mr409927566b.17.1742305673859; 
 Tue, 18 Mar 2025 06:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+18ZByXzMwD4ntlc6UL8iK2gf7awq6SRUjosmqPtfAcaXlfJ2Rl1zlTKUklqZBYWnH/WorRjF1KCqFJnlKUc=
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id
 a640c23a62f3a-ac38d405ac4mr409925766b.17.1742305673433; Tue, 18 Mar 2025
 06:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250314113847.109460-1-kkostiuk@redhat.com>
In-Reply-To: <20250314113847.109460-1-kkostiuk@redhat.com>
From: Dehan Meng <demeng@redhat.com>
Date: Tue, 18 Mar 2025 21:47:40 +0800
X-Gm-Features: AQ5f1Jpve-OyZTTWSOyUOkWDsXVVMU55kTSTlzqunmvMYepC7NJgUGF5lzFhPMU
Message-ID: <CA+kPPJyuzwsXd1WRJTV5je13tWuogX_0OKxeia+9=Bf4KTYE3g@mail.gmail.com>
Subject: Re: [PATCH 0/2] qga: Add 'guest-get-load' command
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c16f8806309e2630"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000c16f8806309e2630
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series's patches. cpu load will be captured by the new api
'guest-get-load'.

Tested-by: Dehan Meng <demeng@redhat.com>

On Fri, Mar 14, 2025 at 7:39=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Konstantin Kostiuk (2):
>   qga-win: implement a 'guest-get-load' command
>   qga: Add tests for guest-get-load command
>
>  qga/commands-win32.c   | 140 +++++++++++++++++++++++++++++++++++++++++
>  qga/guest-agent-core.h |  10 +++
>  qga/main.c             |  39 ++++++++++++
>  qga/meson.build        |   2 +-
>  qga/qapi-schema.json   |   4 +-
>  tests/unit/test-qga.c  |  17 +++++
>  6 files changed, 209 insertions(+), 3 deletions(-)
>
> --
> 2.48.1
>
>
>

--000000000000c16f8806309e2630
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">QE=C2=A0<span class=3D"gmail-il">tested</span>=C2=A0this s=
eries&#39;s patches. cpu load will be captured by the new api &#39;guest-ge=
t-load&#39;.<div><div><br></div><div><span class=3D"gmail-il">Tested</span>=
-<span class=3D"gmail-il">by</span>: Dehan Meng &lt;<a href=3D"mailto:demen=
g@redhat.com" target=3D"_blank">demeng@redhat.com</a>&gt;</div></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Mar 14, 2025 at 7:39=E2=80=AFPM Konstantin Kostiuk =
&lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Konstantin Ko=
stiuk (2):<br>
=C2=A0 qga-win: implement a &#39;guest-get-load&#39; command<br>
=C2=A0 qga: Add tests for guest-get-load command<br>
<br>
=C2=A0qga/commands-win32.c=C2=A0 =C2=A0| 140 ++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0qga/guest-agent-core.h |=C2=A0 10 +++<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 39 =
++++++++++++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0tests/unit/test-qga.c=C2=A0 |=C2=A0 17 +++++<br>
=C2=A06 files changed, 209 insertions(+), 3 deletions(-)<br>
<br>
--<br>
2.48.1<br>
<br>
<br>
</blockquote></div>

--000000000000c16f8806309e2630--


