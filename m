Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3236BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 07:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHIQp-0007FH-9q; Wed, 12 Jun 2024 03:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHIQn-0007Er-SM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 03:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHIQl-0006qU-1Z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718177398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jvT/odhMWtbgl/SPIvBGt6Iuy/JiqEAVPWJ0G7e/HkQ=;
 b=VkeXUUFRkptkaf8uPAnyVhUzLiclQKkzEz3xoU81g3tPJpR1O9W38pdblIolgUz/ge3DAQ
 n0cCth2rDwFBH1NuM8VQVjYIFdNsA6nTg3vr0out1d9PR/J/XjohqsVGLG70/yNrLJjYqs
 Y+XLbP6hgeEbBnrN4YnZbKK7ibS7yaA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-JQldN7JkNCi3q4J6aiMcBQ-1; Wed, 12 Jun 2024 03:29:53 -0400
X-MC-Unique: JQldN7JkNCi3q4J6aiMcBQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-62fb36d7f5fso9113567b3.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 00:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718177393; x=1718782193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvT/odhMWtbgl/SPIvBGt6Iuy/JiqEAVPWJ0G7e/HkQ=;
 b=LZSQ6k92FHvJL9a6HNF0lv305xPRFt8v5bUsOePGC5RX3IMPbXCvc5wWQCftj68KW6
 bv6CAWEY79ZMxEHtrNwIDlyTgHidh8nEc3UcacUv43znKpqaT8jqhHNpmjWByIq+oYsG
 x6KnNiDKVVYOD5ATZ9k3iTRAYW53+suCADmNUONsKhShwR1BzEUTxpSNLB4qXZX93K/x
 ehDWUgfNCGugd8l/boBQt7PAbQv+9B1a6GHwZjzSQuPkjXhkX71yQE880chBitUKYP42
 YkHRerKCp16HVuRCUpIQy2AgRnbPPgR01EqX38Pjbh21NiI9SJQJVPz65m058Ce7I5QH
 E7BA==
X-Gm-Message-State: AOJu0Yxsr2WGye8+rpA+v/RpVvVnEDmRxAd3ecM+HZsY7J6xpkhbx+Bb
 ATrJCWXFXFoj7sTE+HEwDW4gxJ8xYMT1In3vdLPnmnyU0XIL0CxKp9TNybNbkd/7B/8p4G8jx1G
 84e+G7SUP5NAtFgYrmzWv08HLja3+mG1TJiUfOzuWflutWpkPWZr1L8bnXbxRqktyb7lPQ77rGC
 +hNTvMtQfEJnR0keo8RbO4xYGdl7c=
X-Received: by 2002:a81:a54c:0:b0:62f:2c3e:73a2 with SMTP id
 00721157ae682-62fb828846bmr10324887b3.1.1718177392747; 
 Wed, 12 Jun 2024 00:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+sbQ4TxwxpUDnIZoNrGqE32HtQW+A928MNNbJHWcePKvZ56rOG7RWd98Pf2yd81JFMmgFuXpE3dVWdxmuJg8=
X-Received: by 2002:a81:a54c:0:b0:62f:2c3e:73a2 with SMTP id
 00721157ae682-62fb828846bmr10324737b3.1.1718177392438; Wed, 12 Jun 2024
 00:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240612043547.282552-1-demeng@redhat.com>
In-Reply-To: <20240612043547.282552-1-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Jun 2024 10:29:41 +0300
Message-ID: <CAPMcbCqh_9FKk2RKV2_Syh2xONUsk8Y6h49PNrm61R+r1r==Kg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] qga/linux: Add new api 'guest-network-get-route'
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000234a46061aac598a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000234a46061aac598a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:36=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> v3 -> v4
> - Fix some indentation issues
> - Update 'Since 8.2' to 'Since 9.1'
> - Remove useless enum and adjust this change.
>
> v2 -> v3
> - Remove this declaration and make the function 'hexToIPAddress' as stati=
c.
> - Define 'IFNAMSIZ' from kernel instead of a hardcode
> - Remove 'GUEST_NETWORK_ROUTE_TYPE_LINUX'
> - Set flags 'has_xxx' for checking if a field exists or has a value set
>
> v1 -> v2
> - Replace snprintf() to g_strdup_printf() to avoid memory problems.
> - Remove the parameter 'char ipAddress[16]' in function 'char
> *hexToIPAddress()'.
> - Add a piece of logic to skip traversing the first line of the file
>
>
Looks like the old version was sent. There are no changes in v1 -> v2 and
v2 -> v3 in this patch.



> Dehan Meng (1):
>   qga/linux: Add new api 'guest-network-get-route'
>
>  qga/commands-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c |  6 ++++
>  qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>
> --
> 2.40.1
>
>

--000000000000234a46061aac598a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div><br></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Jun 12, 2024 at 7:36=E2=80=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@re=
dhat.com">demeng@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">v3 -&gt; v4<br>
- Fix some indentation issues<br>
- Update &#39;Since 8.2&#39; to &#39;Since 9.1&#39;<br>
- Remove useless enum and adjust this change.<br>
<br>
v2 -&gt; v3<br>
- Remove this declaration and make the function &#39;hexToIPAddress&#39; as=
 static.<br>
- Define &#39;IFNAMSIZ&#39; from kernel instead of a hardcode<br>
- Remove &#39;GUEST_NETWORK_ROUTE_TYPE_LINUX&#39;<br>
- Set flags &#39;has_xxx&#39; for checking if a field exists or has a value=
 set<br>
<br>
v1 -&gt; v2<br>
- Replace snprintf() to g_strdup_printf() to avoid memory problems.<br>
- Remove the parameter &#39;char ipAddress[16]&#39; in function &#39;char *=
hexToIPAddress()&#39;.<br>
- Add a piece of logic to skip traversing the first line of the file<br>
<br></blockquote><div><br></div><div>Looks like the old version was sent. T=
here are no changes in v1 -&gt; v2 and v2 -&gt; v3 in this patch.<br><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Dehan Meng (1):<br>
=C2=A0 qga/linux: Add new api &#39;guest-network-get-route&#39;<br>
<br>
=C2=A0qga/commands-posix.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-win32.c |=C2=A0 6 ++++<br>
=C2=A0qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++<b=
r>
=C2=A03 files changed, 147 insertions(+)<br>
<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>

--000000000000234a46061aac598a--


