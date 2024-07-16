Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkqu-0004Gr-Fz; Tue, 16 Jul 2024 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkqj-0003Xj-PQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkqe-0004D2-WB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llUEcp3/mBKf7v1I8YRblH3j8G4ZCN2F4ZWAIdjkhOU=;
 b=IaWXpqWGtck5Ou8CoBqTQ1bRNTp6YuDgR0S/mwwLvf+V+SlOEMdfO0ghsIXfYdNfHZEKCx
 A+5d8rX7fDpVNaOat9gG0tOufzefUN84KbBWBPMuw8Q5WFwLV1opgMyjqv5k9RKrEMEAQy
 J6u19twoQiIqqOW56o2DARadFfpP7kM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-hnivro37O1ifSsEdU7PKIw-1; Tue, 16 Jul 2024 12:16:10 -0400
X-MC-Unique: hnivro37O1ifSsEdU7PKIw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367a058fa21so3287213f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146569; x=1721751369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llUEcp3/mBKf7v1I8YRblH3j8G4ZCN2F4ZWAIdjkhOU=;
 b=kLNbARGL7EU4OJMGa/Iug6lnhb2urFQfbous3vw2cFj7BnLo5GegOjz+oXY1mwaL3H
 CeDxepAJGW6P2l48jwvy+fRfTZDLWAKBdqISsJCan/ikNr2toV/+/Nukl73Wi45CLmOx
 lLCDhyiWNZoZAXJrHsdTQz6GKqTUZhVxwnD59O0HIrU5mSU0rWeWBiHvWzlaMCXzYwC5
 /uCSS85cSGQK+IyKz+FJT8Vaxi3EUrA2XpbJPQOhjYfdQASJNHJCQIjrFSUGtLosOSNe
 KrmhKLLV2uftx9v1xs6CdnnjN8M67D2U+0RYqfuhp70Ow5p2wTrTBsn4z4J/A2WNvvM7
 mxlw==
X-Gm-Message-State: AOJu0YwQSlgdw4tS5U1aOLfjkqeuTKhxcvjIU1N8OfnsrZlm2m+ecBPU
 Gsz3vePQe8+yXcF8YTzBhftHZPGELI5GbFvYrJqo78dDv2dFBZWJScm2H8Elf1G9H1ukc2u+7x+
 LMYB7n3Yw71F0qYCOkmmMquNRZuRNn14VhT5oWPS8JWP8zxQP1DgdKkJmPuG9sg2GiMd2htiSYt
 1Y/32lORKh1I/MSOW2n4LkB2mKS3Y=
X-Received: by 2002:a5d:6585:0:b0:368:5d0:5c2c with SMTP id
 ffacd0b85a97d-36827592ce5mr1832163f8f.29.1721146569101; 
 Tue, 16 Jul 2024 09:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzxYlNnInBoVVkhj949TlIgR2LHR0URy8BwvhirV3vVxdw/AP7/oBw0BaYn6/pzySeHCuRt4GkH3jbZ2CbkuI=
X-Received: by 2002:a5d:6585:0:b0:368:5d0:5c2c with SMTP id
 ffacd0b85a97d-36827592ce5mr1832142f8f.29.1721146568738; Tue, 16 Jul 2024
 09:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-5-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-5-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:15:55 -0400
Message-ID: <CAFn=p-ZCPyK11HVpvRy7Xw7g5bZN8P3i-899SYYx01WOZ+HU0A@mail.gmail.com>
Subject: Re: [PATCH 4/5] qapi/sockets: Move deprecation note out of
 SocketAddress doc comment
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d62523061d5fa9bf"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--000000000000d62523061d5fa9bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Doc comments are reference documentation for users of QMP.
> SocketAddress's doc comment contains a deprecation note advising
> developers to use SocketAddress for new code.  Irrelevant for users of
> QMP.  Move the note out of the doc comment.
>

Sure.


> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>


---
>  qapi/sockets.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 4d78d2ccb7..e76fdb9925 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -179,10 +179,6 @@
>  #
>  # @type: Transport type
>  #
> -# .. note:: This type is deprecated in favor of SocketAddress.  The
> -#    difference between SocketAddressLegacy and SocketAddress is that
> -#    the latter has fewer ``{}`` on the wire.
> -#
>  # Since: 1.3
>  ##
>  { 'union': 'SocketAddressLegacy',
> @@ -193,6 +189,9 @@
>      'unix': 'UnixSocketAddressWrapper',
>      'vsock': 'VsockSocketAddressWrapper',
>      'fd': 'FdSocketAddressWrapper' } }
> +# Note: This type is deprecated in favor of SocketAddress.  The
> +# difference between SocketAddressLegacy and SocketAddress is that the
> +# latter has fewer ``{}`` on the wire.
>
>  ##
>  # @SocketAddressType:
> --
> 2.45.0
>
>

--000000000000d62523061d5fa9bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Doc comments are reference documen=
tation for users of QMP.<br>
SocketAddress&#39;s doc comment contains a deprecation note advising<br>
developers to use SocketAddress for new code.=C2=A0 Irrelevant for users of=
<br>
QMP.=C2=A0 Move the note out of the doc comment.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Sure.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/sockets.json | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qapi/sockets.json b/qapi/sockets.json<br>
index 4d78d2ccb7..e76fdb9925 100644<br>
--- a/qapi/sockets.json<br>
+++ b/qapi/sockets.json<br>
@@ -179,10 +179,6 @@<br>
=C2=A0#<br>
=C2=A0# @type: Transport type<br>
=C2=A0#<br>
-# .. note:: This type is deprecated in favor of SocketAddress.=C2=A0 The<b=
r>
-#=C2=A0 =C2=A0 difference between SocketAddressLegacy and SocketAddress is=
 that<br>
-#=C2=A0 =C2=A0 the latter has fewer ``{}`` on the wire.<br>
-#<br>
=C2=A0# Since: 1.3<br>
=C2=A0##<br>
=C2=A0{ &#39;union&#39;: &#39;SocketAddressLegacy&#39;,<br>
@@ -193,6 +189,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&#39;unix&#39;: &#39;UnixSocketAddressWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;vsock&#39;: &#39;VsockSocketAddressWrapper&#39;,<b=
r>
=C2=A0 =C2=A0 =C2=A0&#39;fd&#39;: &#39;FdSocketAddressWrapper&#39; } }<br>
+# Note: This type is deprecated in favor of SocketAddress.=C2=A0 The<br>
+# difference between SocketAddressLegacy and SocketAddress is that the<br>
+# latter has fewer ``{}`` on the wire.<br>
<br>
=C2=A0##<br>
=C2=A0# @SocketAddressType:<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--000000000000d62523061d5fa9bf--


