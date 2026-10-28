Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2959606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9bUFetE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oYUpgIn2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzRB-0005iG-Py; Wed, 28 Oct 2026 04:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzR4-0005bH-4u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLzR1-00023c-KB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793177701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9VnWCclnb6AAAncN69L9Q1S3HR/4ad6/hhk5wJd4/fY=;
 b=I9bUFetEj3EjPO2lbG10eU47MR8AIpu36SPIhtSOQT/qULtRMNuBbfnvbOZ/sZBewgSAsY
 O5g2USQtKFxWkiKQfPaqXUhZnycyWYkqEvMLoMV5nSqVup1zhJ4n94x/GOhr75WspaXNwE
 /k4oUIGWTv2ZfjEmRNBxrdHp62Q9NQc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-l5wv_jsKO9umEs0btGAOrQ-1; Wed, 28 Oct 2026 04:54:59 -0400
X-MC-Unique: l5wv_jsKO9umEs0btGAOrQ-1
X-Mimecast-MFC-AGG-ID: l5wv_jsKO9umEs0btGAOrQ_1793177699
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c84eef313so2986366d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177699; cv=none;
 d=google.com; s=arc-20260327;
 b=pugo3eCSRB5FgXFvtaYJSzqtPu6hYVEDBbNCRuF35GUEzQTcpFUhEqBVetXUsRhWYw
 1z0qbg9YQQDeO+Hoy+QKZZhSatNgTXfap1anCZNQghL2JDSTiaf+x8EaZe7EjWM+Hq4D
 30MV0alX600oZ3TXnU/bUwv5KjpOnmGxb80Rho9HPY64RT5JQk2btaZjqfepbLjCusnp
 1CbYKLevCO/FQ7GKCVTpuaCougisVhYLmXxqUW3CV+2xGteSDK9IyuNyEFK/OkG4MJiQ
 tIUwhO/hoKPfsZACyIcCqytc9aqYGxtL9xcBRAjVX6oN5qRajGRJKlWwK4ubUqbN+PhK
 L7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9VnWCclnb6AAAncN69L9Q1S3HR/4ad6/hhk5wJd4/fY=;
 fh=uxOq6OFcVUmI/wjnSV/xzto6IFsCeglNUkZMHeb6cCc=;
 b=OBtuXRTE0FLiz2teK8MlLUIBZTpL3qBW7w3/HUlRG1Y9mv2L3ioOszmiIjVp0LwiS0
 vbIX90zQYhLFTHm7TVXDMlIuKhPDAhqoJ3RRie7q1NkSrRHfN055DpztWed5AbSrptE/
 Fwi7LLZ5+BbB1kDobvnSBiluFMbLBDlMIXHrhN5vsZ9u+n8PrpjzodkzW3RkYtDeHW5N
 XDveffuR818lCnWc+n+nNHsv5/0RzD99EDL7W2coC8mIOYAf/LusVDuTTdtes4c7OcY0
 EqcqybWlRIBrCJGCI6R2Rm2W3ZpRf6Of2Vd+nFuXaQx3qEOX5fiwBv6/mK98PbwED0N/
 0gdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793177699; x=1793782499; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9VnWCclnb6AAAncN69L9Q1S3HR/4ad6/hhk5wJd4/fY=;
 b=oYUpgIn2GaJJ86epWUFlj5MBAx/YWQlJk/ml0Nddh+4xGdjnj9PItdLYAmbA6gfuDN
 vvcqp98gZRFZ1BIKx3/jVAdUQF81N5SKrRFQjAzeRRiiw+wkDQrZsZMgmMlzGISM/OyD
 Wc5jjzP6J7X+tp59dTC0i3TQFxaVjWUSdf+Fu1bhhRzk6N9msAZ0lQWF5dxLaKsxDXeo
 DedhQI3Mi6fE01vXjXQrFsLXQB9v7LPaCKwzfJ9kGSutcl/d47gLueqcG4zgNR1KNTCw
 HvRFDZNfQ8KZbt0l4Gmi4aFSzhZkk2aOCHXWaguM/R7Po0UiOZvL0RlNjyxmo2+GXL5i
 Kq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177699; x=1793782499;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9VnWCclnb6AAAncN69L9Q1S3HR/4ad6/hhk5wJd4/fY=;
 b=ZrgwaSzuoa0/3Kb/kB3oiPWflTJSFxyQa4FhgF3asL71RQQrI9qPqifn39wIvoJJgc
 GNWhVDMk68iSnNLB7Y/dqCP6r/ZgkPQPCH53yNfmK4m1idqtW5j/4tW9YF9Qn1ajriIX
 8JEqJmB33XOM9E3SsPQwKpIo12EC0Tuncx+Z67qxCvNG6y+mvSMnmWsSawcQhpgvJ/Ge
 rcmgt5mxj66WP/964gYptdSqKDntvu2QlPcRF//fKwUkYRc+U/+sUc3bIpaqB2maypRe
 nR5t976b+EAQngPov08bQ2I2GfeDOUmbwkuWg39x6Tou1+Gca8u2yuV/twQkqu523wB0
 Nu6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByWvt7vPvtVcSwQlAS40MRbr2WxF8zvjgG0gXYWqGUo4nlVWSAS0wRI6sj9577SwClQqPbRevcEDPIL@nongnu.org
X-Gm-Message-State: AFq9FYKNwCjPOwhm1yR9K9KVN4mmhSYA5+7GeQC/5YrC3yc8AaFI6q5x
 44gfTuamb4Q9O6jLX+rKFWBqu+WnQd/t1oka0vI4bR+lJzG6Ay7ozCkD8scVWvh2irPe0mJb8uj
 5wDqlc4WGt0aRqf5eRqYDm/SR2Kw1wGWbbvYh8+pk/VtUh6PKLgTMCyN/8qiw2yWB/nFJ+15msd
 WGeBp29K8ICC9LgKa9g/FuGb0xIit33Uc=
X-Gm-Gg: AYBFou0SfOvo+OJNnBjIxu2PJXXLkklLghOlHTY1tGgEetboXz+pJEv0PKlQsy+bru7
 Y/jGfxjLAuWuc3e0vExfbGN1Ef9k8cIvTHBg7wapCSYyJOC4cf0srVWZGw/QZko187cGSbC6qEH
 mGVCXSz/+7Bni2PZoPZmTgfg+92RpfZ9caQgvWCqxHX2zFuJiEXZe5zbzwZ0GufhjiFPHQlE/GN
 l+RTGoZew3dLhS7We8=
X-Received: by 2002:a05:6214:627:b0:91c:7a0d:4fe6 with SMTP id
 6a1803df08f44-91c7cf822e7mr23205816d6.25.1793177698887; 
 Wed, 28 Oct 2026 01:54:58 -0700 (PDT)
X-Received: by 2002:a05:6214:627:b0:91c:7a0d:4fe6 with SMTP id
 6a1803df08f44-91c7cf822e7mr23205626d6.25.1793177698418; Wed, 28 Oct 2026
 01:54:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026190352.14293-1-bogorodskiy@gmail.com>
 <auCGGddC5ebCF9iU@redhat.com>
In-Reply-To: <auCGGddC5ebCF9iU@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 10:54:47 +0200
X-Gm-Features: AclHuK8BbL91XxcqumphC7wJMfVethJT4qBKpLRlwry1qVBXhI8h9g3stMcy0sM
Message-ID: <CAPMcbCoh9=Q9apfCVL6xmRj9qSX+4iMGomJgYtJqQ7AswyQmPA@mail.gmail.com>
Subject: Re: [PATCH v3] qga: implement 'guest-network-get-route' for FreeBSD
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bbdb7f065ee2b761"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000bbdb7f065ee2b761
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Tue, Oct 27, 2026 at 1:08=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Oct 26, 2026 at 08:03:52PM +0100, Roman Bogorodskiy wrote:
> > Implement 'guest-network-get-route' for FreeBSD. This
> > implementation uses the sysctl(3) interface to get
> > the routing table.
> >
> > Limitations:
> >
> >  - This implementation does not populate irtt, refcnt, use,
> >    window, source, and srcprefixlen fields.
> >  - The implementation uses the default FIB (routing table) 0.
> >    Selecting QGA's active FIB is left for the follow-up patch.
> >
> > While here, spell Windows correctly in @GuestNetworkRoute documentation
> > in qapi-schema.json.
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > ---
> > Changes since v1:
> >
> >  - qga/qapi-schema.json spelling: windows -> Windows, freebsd -> FreeBS=
D
> >    in the "@GuestNetworkRoute" documentation.
> >  - meson.build: check that the 'struct rt_metrics' has 'rmx_metric'
> >    member which is available only on FreeBSD 16.
> >
> > Changes since v2:
> >
> >  - If interface name cannot be obtained, default it to "if<index>"
> >    instead of "?", similarly to the Windows implementation.
> >  - Use getnameinfo() for both AF_INET and AF_INET6 formatting.
> >
> >  meson.build          |   6 ++
> >  qga/commands-bsd.c   | 173 +++++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json |  31 ++++----
> >  3 files changed, 195 insertions(+), 15 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000bbdb7f065ee2b761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, O=
ct 27, 2026 at 1:08=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailt=
o:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On Mon, Oct 26, 2026 at 08:03:52P=
M +0100, Roman Bogorodskiy wrote:<br>
&gt; Implement &#39;guest-network-get-route&#39; for FreeBSD. This<br>
&gt; implementation uses the sysctl(3) interface to get<br>
&gt; the routing table.<br>
&gt; <br>
&gt; Limitations:<br>
&gt; <br>
&gt;=C2=A0 - This implementation does not populate irtt, refcnt, use,<br>
&gt;=C2=A0 =C2=A0 window, source, and srcprefixlen fields.<br>
&gt;=C2=A0 - The implementation uses the default FIB (routing table) 0.<br>
&gt;=C2=A0 =C2=A0 Selecting QGA&#39;s active FIB is left for the follow-up =
patch.<br>
&gt; <br>
&gt; While here, spell Windows correctly in @GuestNetworkRoute documentatio=
n<br>
&gt; in qapi-schema.json.<br>
&gt; <br>
&gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gma=
il.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v1:<br>
&gt; <br>
&gt;=C2=A0 - qga/qapi-schema.json spelling: windows -&gt; Windows, freebsd =
-&gt; FreeBSD<br>
&gt;=C2=A0 =C2=A0 in the &quot;@GuestNetworkRoute&quot; documentation.<br>
&gt;=C2=A0 - meson.build: check that the &#39;struct rt_metrics&#39; has &#=
39;rmx_metric&#39;<br>
&gt;=C2=A0 =C2=A0 member which is available only on FreeBSD 16.<br>
&gt; <br>
&gt; Changes since v2:<br>
&gt; <br>
&gt;=C2=A0 - If interface name cannot be obtained, default it to &quot;if&l=
t;index&gt;&quot;<br>
&gt;=C2=A0 =C2=A0 instead of &quot;?&quot;, similarly to the Windows implem=
entation.<br>
&gt;=C2=A0 - Use getnameinfo() for both AF_INET and AF_INET6 formatting.<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 ++=
<br>
&gt;=C2=A0 qga/commands-bsd.c=C2=A0 =C2=A0| 173 +++++++++++++++++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 qga/qapi-schema.json |=C2=A0 31 ++++----<br>
&gt;=C2=A0 3 files changed, 195 insertions(+), 15 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div>

--000000000000bbdb7f065ee2b761--


