Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96548D12D49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVpw-0004je-4J; Mon, 11 Nov 2024 09:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ybendito@redhat.com>)
 id 1tAVps-0004fI-IY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ybendito@redhat.com>)
 id 1tAVpo-0002YM-An
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731336966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ITOCkEXgCq5wQNZapL+KIGuLjziiJyvla5aBRSeARto=;
 b=jSaVZnEM7aXwEvTqE9P12ouJ0EKywiBAkNSFEz9Rk3sEH2P55rIqpSVhlOMotC/DoZkQ5+
 TRoPWGuLbJdli4mfplLTBEGKGu0B14tbA+UgoOIcR6Nldjx/lrPBXaxP3CkZR10IyrPiVB
 It4NwPIO3UsnplhG9M5xqBfRRbfcxow=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ZFWKWom9POakkAjUUzMthA-1; Mon, 11 Nov 2024 09:54:56 -0500
X-MC-Unique: ZFWKWom9POakkAjUUzMthA-1
X-Mimecast-MFC-AGG-ID: ZFWKWom9POakkAjUUzMthA
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6ea90b6ee2fso77330417b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731336891; x=1731941691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ITOCkEXgCq5wQNZapL+KIGuLjziiJyvla5aBRSeARto=;
 b=RScYmNlRIbwlgZauDCxPEJaQrZeRgXQyOzfrP8HC1ujsvcba/dercvWhFvEbuHYOmL
 AEoFcNyVXWkPCbsxYrPM7buS+c6H2Oz2JN+ZT/HizhJnubRdXWNI29byaPYfPGXcmeLM
 69C34kRzf+0TEPRzmCfDH75uF4RS5Hv6Aiwd7Yox3euKJLD81iMxi7UE+Epf0y4zYic7
 D/wfS9//dkeJvGEospDLpEb4Pkg4j3FjgwiQmzFypW+7OIdqmb2ALAsd7qN+LhNNvMMh
 cTgd13pkDC8MAIVCVSJmMymmCGMwhsyX0scuCH+rGiZt6G+xghXdbuLg1lZmrMa8TWM6
 VfsQ==
X-Gm-Message-State: AOJu0Yzkhqxu7d07hMJzRJ2DD/BNftH4c6SVtph0GpJKFxUXqdsbLC/k
 mCXfVqJgMjA1VSPWu00UZECWV09Vn2CpT9RMuH7EAzFt/wzXmLj1YnPWAhn4IhCG7o1x8jfTrE0
 U/OSmNeo78MCd0Ie1KKKfZjrhmRF2NMa8BwQT0KaUkBbFDy/tjTjKJx/gGXpyvNG/Q0EM8usNfT
 KElGH0kIWc/lpQojE/BRyD0KA/dEIWIMQLYpsTAw==
X-Received: by 2002:a05:690c:6885:b0:6e3:4190:ab45 with SMTP id
 00721157ae682-6eaddd9874bmr130281287b3.15.1731336891018; 
 Mon, 11 Nov 2024 06:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgN/Fa3GWIz8kpPP2/8qd2u4e2tV3OtujMTPzI2iB4aknZ2jR3/zXJ4byvKjABdyRhbSYYangRrGc0W0H3eVM=
X-Received: by 2002:a05:690c:6885:b0:6e3:4190:ab45 with SMTP id
 00721157ae682-6eaddd9874bmr130280987b3.15.1731336890715; Mon, 11 Nov 2024
 06:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20241107163210.3620697-1-peter.maydell@linaro.org>
 <20241107163210.3620697-2-peter.maydell@linaro.org>
 <CAGoVJZyPiwoxFuo0UM9cRLh0PUunL9Tzq=2jhsSE3tao2W5pCg@mail.gmail.com>
In-Reply-To: <CAGoVJZyPiwoxFuo0UM9cRLh0PUunL9Tzq=2jhsSE3tao2W5pCg@mail.gmail.com>
From: Yuri Benditovich <ybendito@redhat.com>
Date: Mon, 11 Nov 2024 16:54:39 +0200
Message-ID: <CAK9d7mx+7da5noq3RH5k1hR+ROZc6Mep3USjK2tUNtPWQjEz+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
To: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="0000000000005bb54e0626a448d7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ybendito@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

--0000000000005bb54e0626a448d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 1:10=E2=80=AFPM Yan Vugenfirer <yvugenfi@redhat.com=
> wrote:

> Please take a look is this is host\guest common struct
>
> ---------- Forwarded message ---------
> From: Peter Maydell <peter.maydell@linaro.org>
> Date: Thu, Nov 7, 2024 at 6:33=E2=80=AFPM
> Subject: [PATCH 1/2] hw/net/virtio-net.c: Don't assume IP length field is
> aligned
> To: <qemu-devel@nongnu.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>=
,
> Dmitry Fleytman <dmitry.fleytman@gmail.com>, Akihiko Odaki <
> akihiko.odaki@daynix.com>
>
>
> In virtio-net.c we assume that the IP length field in the packet is
> aligned, and we copy its address into a uint16_t* in the
> VirtioNetRscUnit struct which we then dereference later.  This isn't
> a safe assumption; it will also result in compilation failures if we
> mark the ip_header struct as QEMU_PACKED because the compiler will
> not let you take the address of an unaligned struct field.
>
> Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
> places where we read or write through that pointer instead use some
> new accessor functions read_unit_ip_len() and write_unit_ip_len()
> which account for the pointer being potentially unaligned and also do
> the network-byte-order conversion we were previously using htons() to
> perform.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/virtio/virtio-net.h |  2 +-
>  hw/net/virtio-net.c            | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-net.h
> b/include/hw/virtio/virtio-net.h
> index 060c23c04d2..b9ea9e824e3 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {
>  /* Rsc unit general info used to checking if can coalescing */
>  typedef struct VirtioNetRscUnit {
>      void *ip;   /* ip header */
> -    uint16_t *ip_plen;      /* data len pointer in ip header field */
> +    void *ip_plen; /* pointer to unaligned uint16_t data len in ip heade=
r
> */
>      struct tcp_header *tcp; /* tcp header */
>      uint16_t tcp_hdrlen;    /* tcp header len */
>      uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f2104ed364a..11cf462180d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientStat=
e
> *nc, const uint8_t *buf,
>      return virtio_net_receive_rcu(nc, buf, size, false);
>  }
>
> +/*
> + * Accessors to read and write the IP packet data length field. This
> + * is a potentially unaligned network-byte-order 16 bit unsigned integer
> + * pointed to by unit->ip_len.
> + */
> +static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)
> +{
> +    return ldl_be_p(unit->ip_plen);
>

shouldn't it be lduw_be_p?


> +}
> +
> +static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
> +{
> +    stl_be_p(unit->ip_plen, l);
>

shouldn't it be stw_be_p?


> +}
> +
>  static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
>                                           const uint8_t *buf,
>                                           VirtioNetRscUnit *unit)
> @@ -2063,7 +2078,7 @@ static void
> virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
>      unit->ip_plen =3D &ip->ip_len;
>      unit->tcp =3D (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrle=
n);
>      unit->tcp_hdrlen =3D (htons(unit->tcp->th_offset_flags) & 0xF000) >>=
 10;
> -    unit->payload =3D htons(*unit->ip_plen) - ip_hdrlen - unit->tcp_hdrl=
en;
> +    unit->payload =3D read_unit_ip_len(unit) - ip_hdrlen - unit->tcp_hdr=
len;
>  }
>
>  static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
> @@ -2082,7 +2097,7 @@ static void
> virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
>
>      /* There is a difference between payload length in ipv4 and v6,
>         ip header is excluded in ipv6 */
> -    unit->payload =3D htons(*unit->ip_plen) - unit->tcp_hdrlen;
> +    unit->payload =3D read_unit_ip_len(unit) - unit->tcp_hdrlen;
>  }
>
>  static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,
> @@ -2231,7 +2246,7 @@ static int32_t
> virtio_net_rsc_coalesce_data(VirtioNetRscChain *chain,
>      VirtioNetRscUnit *o_unit;
>
>      o_unit =3D &seg->unit;
> -    o_ip_len =3D htons(*o_unit->ip_plen);
> +    o_ip_len =3D read_unit_ip_len(o_unit);
>      nseq =3D htonl(n_unit->tcp->th_seq);
>      oseq =3D htonl(o_unit->tcp->th_seq);
>
> @@ -2267,7 +2282,7 @@ coalesce:
>          o_unit->payload +=3D n_unit->payload; /* update new data len */
>
>          /* update field in ip header */
> -        *o_unit->ip_plen =3D htons(o_ip_len + n_unit->payload);
> +        write_unit_ip_len(o_unit, o_ip_len + n_unit->payload);
>
>          /* Bring 'PUSH' big, the whql test guide says 'PUSH' can be
> coalesced
>             for windows guest, while this may change the behavior for lin=
ux
> --
> 2.34.1
>
>
>

--0000000000005bb54e0626a448d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 10, 2024 at 1:10=E2=80=AF=
PM Yan Vugenfirer &lt;<a href=3D"mailto:yvugenfi@redhat.com">yvugenfi@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr">Please take a look is this is host\guest common struc=
t<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">-=
--------- Forwarded message ---------<br>From: <strong class=3D"gmail_sende=
rname" dir=3D"auto">Peter Maydell</strong> <span dir=3D"auto">&lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt;</span><br>Date: Thu, Nov 7, 2024 at 6:33=E2=80=AFPM<br>Subject=
: [PATCH 1/2] hw/net/virtio-net.c: Don&#39;t assume IP length field is alig=
ned<br>To:  &lt;<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">=
qemu-devel@nongnu.org</a>&gt;<br>Cc: Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;, Jason Wang &lt=
;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.c=
om</a>&gt;, Dmitry Fleytman &lt;<a href=3D"mailto:dmitry.fleytman@gmail.com=
" target=3D"_blank">dmitry.fleytman@gmail.com</a>&gt;, Akihiko Odaki &lt;<a=
 href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@d=
aynix.com</a>&gt;<br></div><br><br>In virtio-net.c we assume that the IP le=
ngth field in the packet is<br>
aligned, and we copy its address into a uint16_t* in the<br>
VirtioNetRscUnit struct which we then dereference later.=C2=A0 This isn&#39=
;t<br>
a safe assumption; it will also result in compilation failures if we<br>
mark the ip_header struct as QEMU_PACKED because the compiler will<br>
not let you take the address of an unaligned struct field.<br>
<br>
Make the ip_plen field in VirtioNetRscUnit a void*, and make all the<br>
places where we read or write through that pointer instead use some<br>
new accessor functions read_unit_ip_len() and write_unit_ip_len()<br>
which account for the pointer being potentially unaligned and also do<br>
the network-byte-order conversion we were previously using htons() to<br>
perform.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/hw/virtio/virtio-net.h |=C2=A0 2 +-<br>
=C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 +++=
++++++++++++++++----<br>
=C2=A02 files changed, 20 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.=
h<br>
index 060c23c04d2..b9ea9e824e3 100644<br>
--- a/include/hw/virtio/virtio-net.h<br>
+++ b/include/hw/virtio/virtio-net.h<br>
@@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {<br>
=C2=A0/* Rsc unit general info used to checking if can coalescing */<br>
=C2=A0typedef struct VirtioNetRscUnit {<br>
=C2=A0 =C2=A0 =C2=A0void *ip;=C2=A0 =C2=A0/* ip header */<br>
-=C2=A0 =C2=A0 uint16_t *ip_plen;=C2=A0 =C2=A0 =C2=A0 /* data len pointer i=
n ip header field */<br>
+=C2=A0 =C2=A0 void *ip_plen; /* pointer to unaligned uint16_t data len in =
ip header */<br>
=C2=A0 =C2=A0 =C2=A0struct tcp_header *tcp; /* tcp header */<br>
=C2=A0 =C2=A0 =C2=A0uint16_t tcp_hdrlen;=C2=A0 =C2=A0 /* tcp header len */<=
br>
=C2=A0 =C2=A0 =C2=A0uint16_t payload;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* pure pay=
load without virtio/eth/ip/tcp */<br>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
index f2104ed364a..11cf462180d 100644<br>
--- a/hw/net/virtio-net.c<br>
+++ b/hw/net/virtio-net.c<br>
@@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientState =
*nc, const uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0return virtio_net_receive_rcu(nc, buf, size, false);<br=
>
=C2=A0}<br>
<br>
+/*<br>
+ * Accessors to read and write the IP packet data length field. This<br>
+ * is a potentially unaligned network-byte-order 16 bit unsigned integer<b=
r>
+ * pointed to by unit-&gt;ip_len.<br>
+ */<br>
+static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)<br>
+{<br>
+=C2=A0 =C2=A0 return ldl_be_p(unit-&gt;ip_plen);<br></div></div></blockquo=
te><div><br></div><div>shouldn&#39;t it be lduw_be_p?</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_quote">
+}<br>
+<br>
+static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)<br>
+{<br>
+=C2=A0 =C2=A0 stl_be_p(unit-&gt;ip_plen, l);<br></div></div></blockquote><=
div><br></div><div>shouldn&#39;t it be stw_be_p?</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote">
+}<br>
+<br>
=C2=A0static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
onst uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 V=
irtioNetRscUnit *unit)<br>
@@ -2063,7 +2078,7 @@ static void virtio_net_rsc_extract_unit4(VirtioNetRsc=
Chain *chain,<br>
=C2=A0 =C2=A0 =C2=A0unit-&gt;ip_plen =3D &amp;ip-&gt;ip_len;<br>
=C2=A0 =C2=A0 =C2=A0unit-&gt;tcp =3D (struct tcp_header *)(((uint8_t *)unit=
-&gt;ip) + ip_hdrlen);<br>
=C2=A0 =C2=A0 =C2=A0unit-&gt;tcp_hdrlen =3D (htons(unit-&gt;tcp-&gt;th_offs=
et_flags) &amp; 0xF000) &gt;&gt; 10;<br>
-=C2=A0 =C2=A0 unit-&gt;payload =3D htons(*unit-&gt;ip_plen) - ip_hdrlen - =
unit-&gt;tcp_hdrlen;<br>
+=C2=A0 =C2=A0 unit-&gt;payload =3D read_unit_ip_len(unit) - ip_hdrlen - un=
it-&gt;tcp_hdrlen;<br>
=C2=A0}<br>
<br>
=C2=A0static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,<br=
>
@@ -2082,7 +2097,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRsc=
Chain *chain,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* There is a difference between payload length in ipv4=
 and v6,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ip header is excluded in ipv6 */<br>
-=C2=A0 =C2=A0 unit-&gt;payload =3D htons(*unit-&gt;ip_plen) - unit-&gt;tcp=
_hdrlen;<br>
+=C2=A0 =C2=A0 unit-&gt;payload =3D read_unit_ip_len(unit) - unit-&gt;tcp_h=
drlen;<br>
=C2=A0}<br>
<br>
=C2=A0static size_t virtio_net_rsc_drain_seg(VirtioNetRscChain *chain,<br>
@@ -2231,7 +2246,7 @@ static int32_t virtio_net_rsc_coalesce_data(VirtioNet=
RscChain *chain,<br>
=C2=A0 =C2=A0 =C2=A0VirtioNetRscUnit *o_unit;<br>
<br>
=C2=A0 =C2=A0 =C2=A0o_unit =3D &amp;seg-&gt;unit;<br>
-=C2=A0 =C2=A0 o_ip_len =3D htons(*o_unit-&gt;ip_plen);<br>
+=C2=A0 =C2=A0 o_ip_len =3D read_unit_ip_len(o_unit);<br>
=C2=A0 =C2=A0 =C2=A0nseq =3D htonl(n_unit-&gt;tcp-&gt;th_seq);<br>
=C2=A0 =C2=A0 =C2=A0oseq =3D htonl(o_unit-&gt;tcp-&gt;th_seq);<br>
<br>
@@ -2267,7 +2282,7 @@ coalesce:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o_unit-&gt;payload +=3D n_unit-&gt;payloa=
d; /* update new data len */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* update field in ip header */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *o_unit-&gt;ip_plen =3D htons(o_ip_len + n_uni=
t-&gt;payload);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 write_unit_ip_len(o_unit, o_ip_len + n_unit-&g=
t;payload);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Bring &#39;PUSH&#39; big, the whql tes=
t guide says &#39;PUSH&#39; can be coalesced<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for windows guest, while this may=
 change the behavior for linux<br>
-- <br>
2.34.1<br>
<br>
<br>
</div></div>
</blockquote></div></div>

--0000000000005bb54e0626a448d7--


