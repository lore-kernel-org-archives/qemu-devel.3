Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC18EED610
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solGt-0003ID-O4; Thu, 12 Sep 2024 10:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solGs-0003Cd-CX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solGq-0000fn-0s
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726153086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yiaF6YbBEEYgEPOkC10G125/ABbORWnXTlGjCulEEH4=;
 b=SU8d78I1EpUPqc66x51BzefqNSjKs+2WwCeQaiZm0O3E0MFtE4yWlo/HtbpIo7h0Ak503F
 NaU/2EaFVsfRvgiKGTo+JuIf5enRUsJIIamRDGzSBK6nzfalJo6OnT+IwQv+zZvNtPcOgs
 5oYvm2SfWemS6gTK5PGV2cwKLZMS1mw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-UukOprS9Ouyz2IwRUOJKAQ-1; Thu, 12 Sep 2024 10:58:05 -0400
X-MC-Unique: UukOprS9Ouyz2IwRUOJKAQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7d4fc1a2bb7so1184689a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 07:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726153083; x=1726757883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yiaF6YbBEEYgEPOkC10G125/ABbORWnXTlGjCulEEH4=;
 b=WOul5eXnopVtsTKHI75u3XHsM89FT5Lu5N0+OCyWgSCtvTyybUn2sBFofOCPtk6hBs
 sSVgFPxFMX+v2RMMJzC4I5HGNhtLxkTt6ZMg5/Xz6m9Sx59OftGuyrTCrAIeS8L3VV54
 hm11P0ii58zzWWebRBkKAngcs/TKKNU/KjAAKm0pPI2c37+2TPJhKCIpsBUxvTJL+lQ4
 NxCsbK0MJYomZI8Zbm1844Po7UgxlEreFCqonqk7xTRc9MTG3/aPd4IVoImNXIUqnhNO
 q67nDvVFH1gu74mO7bxPQIpDTcqCOANPwTFiYE5M3BEr5k/XYGZHGYeC33sZiaTqSVlm
 Gl4Q==
X-Gm-Message-State: AOJu0YwkBL1sd0/kkD6GYTEpkpnzcRmT++RdJZYH5V7Gb7wiwltMOkFh
 MF2g6Qq+DgVByL5rWEzpi2tod2i6zuZLJVE1GaFIdeGbLXgyp3/r+jK/1vDW+d6PjLfCDzAUjW0
 k0ZrviRZJtvUahHD/JIkjPiW0DPpGC0jKtye3+9kit5dgFPDNjO/RPBRZD11UVa1G/QdNHaFgDY
 DimRvy69RfCtW8igPfg0Hrnz0TzcnriA+5AORB5g==
X-Received: by 2002:a17:90a:684a:b0:2d3:babf:f9a3 with SMTP id
 98e67ed59e1d1-2db9ff79c75mr3031981a91.2.1726153083323; 
 Thu, 12 Sep 2024 07:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1m6DzFvyoyn7JI5aZOHibTnOUbW2h39QLW2DsOPNhTEYkDAE0JOhdHAr466EVCMSOkuzklKjWsJbZW8ToeSs=
X-Received: by 2002:a17:90a:684a:b0:2d3:babf:f9a3 with SMTP id
 98e67ed59e1d1-2db9ff79c75mr3031966a91.2.1726153082939; Thu, 12 Sep 2024
 07:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240912144432.126717-1-aesteve@redhat.com>
In-Reply-To: <20240912144432.126717-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 12 Sep 2024 16:57:51 +0200
Message-ID: <CADSE00LDwjaifs_Wc9Q-6MH2932BPKny=NeKkiSuBycZVwxg4w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Document SHMEM vhost-user requests
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, hi@alyssa.is, mst@redhat.com, stefanha@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, david@redhat.com,
 stevensd@chromium.org, jasowang@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005662910621ed552a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000005662910621ed552a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Link to the implementation:
https://lore.kernel.org/all/20240912145335.129447-1-aesteve@redhat.com/T/#t


On Thu, Sep 12, 2024 at 4:44=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> As a continuation of the
> "Add SHMEM_MAP/UNMAP requests" patch [1],
> I wanted to split vhost-user spec
> parts into a separate patch, so that
> it could be reviewed and integrated
> separately. Having the specs upstreamed
> would help others to add support for
> these new vhost-user requests on
> their systems.
>
> This is such documentation-only patch.
>
> [1] -
> https://lore.kernel.org/all/20240628145710.1516121-1-aesteve@redhat.com/T=
/
>
> Albert Esteve (3):
>   vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
>   vhost_user.rst: Align VhostUserMsg excerpt members
>   vhost_user.rst: Add GET_SHMEM_CONFIG message
>
>  docs/interop/vhost-user.rst | 72 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> --
> 2.45.2
>
>

--0000000000005662910621ed552a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div>Link to the implementation:=C2=A0<a href=3D"h=
ttps://lore.kernel.org/all/20240912145335.129447-1-aesteve@redhat.com/T/#t"=
>https://lore.kernel.org/all/20240912145335.129447-1-aesteve@redhat.com/T/#=
t</a></div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, Sep 12, 2024 at 4:44=E2=80=AFPM Albert E=
steve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">As a cont=
inuation of the<br>
&quot;Add SHMEM_MAP/UNMAP requests&quot; patch [1],<br>
I wanted to split vhost-user spec<br>
parts into a separate patch, so that<br>
it could be reviewed and integrated<br>
separately. Having the specs upstreamed<br>
would help others to add support for<br>
these new vhost-user requests on<br>
their systems.<br>
<br>
This is such documentation-only patch.<br>
<br>
[1] - <a href=3D"https://lore.kernel.org/all/20240628145710.1516121-1-aeste=
ve@redhat.com/T/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.=
org/all/20240628145710.1516121-1-aesteve@redhat.com/T/</a><br>
<br>
Albert Esteve (3):<br>
=C2=A0 vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec<br>
=C2=A0 vhost_user.rst: Align VhostUserMsg excerpt members<br>
=C2=A0 vhost_user.rst: Add GET_SHMEM_CONFIG message<br>
<br>
=C2=A0docs/interop/vhost-user.rst | 72 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 72 insertions(+)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--0000000000005662910621ed552a--


