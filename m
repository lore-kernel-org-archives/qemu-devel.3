Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF981C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 07:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOY6k-000893-Rw; Tue, 02 Jul 2024 03:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOY6j-00088m-E2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:39:21 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOY6g-0007At-K8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 03:39:21 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4450187d3d4so29873451cf.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719905957; x=1720510757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zIvfAwQISPGWgDRfsIpuhukllE7d/F23MBFnkRFEud8=;
 b=Hi7G+Y/6Q9Oxkb7YOFYubNyNqfAF7dAZkjgY8ijgRYMpebcsHDeDt/0Xv5Sdfk7tbX
 57PO0x4TQ2j94m/Rcv7ryCkti3NhBjMtemzIh9QY40YtXDiZ6MQgc/OckwgI/Yy0r4MI
 qtpDgWwsw0phXDK9cpPnIZ71NeteRt4vS8ph33qb6Se7Q7ESE6bw67WYPuQJX4oEzREe
 PibJQ/vNJEJs6lQU5XogPOLUtyREznJPD+AeNz0fkkME8B5VylWzSbrJ64VFb2eU7qpM
 rRY/j+YX+eqJjTxQ4iu+iY747l9cuahMmfxltIjPxr/docxDcmu5c4Ta7/kALMrBPMpz
 Kkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719905957; x=1720510757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIvfAwQISPGWgDRfsIpuhukllE7d/F23MBFnkRFEud8=;
 b=tTYJlKCQDNLUV67EQoIWI0ORWsMaBPhQkPdx6B+MpNN0lbasUy9HV+QljCSabiV6JX
 VBbbBsgrdwHVWEoQAXCY0if8NKzOBQBRPL5+6QcFgRfKgWGuUobtsmo/Rz+Dk9KRSaj5
 n5hKDgSlq5y3YDG7fhuXD3slVqHsUu4ocT3Cqk7vR+HsN1f7QhNcvPzwDynY6ATIUfWI
 XRjlgr0zJ43EbIEiXzryhonEtaTx6i/GnJwfOIdvpdfFK57YP4Hgm+fFmmnZycqls9Lv
 9mZzPbqkFhXiND43A0uAcMDlRYtJTAm3RaXACJaHHJtUpg8w/ZS0jbimSMS6ZbgxGSj5
 LRXQ==
X-Gm-Message-State: AOJu0YxdUpfPc+ELGtKNa/7vI69ZgamCrmHAnu01r1NPnjQWHTaggTwV
 u8wQktgx78+rVAx3ozBAMJZ1P9jZhvxV3UnBGgjk5Gvov3VxfB4z3ZC2p9cEsVZE4ReZsc99i2k
 Na8E+LEISXN30fov3e19JoGAAU2k=
X-Google-Smtp-Source: AGHT+IH1NowX3wWXdb4VEtD58aD2z1KxqRBX8or7EOL06wOtOD7D0+KVJXK47mWliP0/43yPyNDo/cmOvX4hL3H2G5I=
X-Received: by 2002:ac8:7f8c:0:b0:441:785:a90b with SMTP id
 d75a77b69052e-44662dff010mr124253921cf.1.1719905957573; Tue, 02 Jul 2024
 00:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240626155140.74752-1-lvivier@redhat.com>
In-Reply-To: <20240626155140.74752-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 11:39:05 +0400
Message-ID: <CAJ+F1CLsKpd=wNccJ3+eNQbA12OWE7iFnFDh8kjaJpPXFmtXsg@mail.gmail.com>
Subject: Re: [PATCH] net: update netdev stream/dgram man page
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a5fb14061c3ecf39"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000a5fb14061c3ecf39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 26, 2024 at 7:53=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:

> Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
> manpage.
>
> Add some examples on how to use them, including a way to use
> "-netdev stream" and "passt" in place of "-netdev user".
> ("passt" is a non privileged translation proxy between layer-2,
> like "-netdev stream", and layer-4 on host, like TCP, UDP,
> ICMP/ICMPv6 echo)
>
> Fixes: 5166fe0ae46d ("qapi: net: add stream and dgram netdevs")
> Fixes: 13c6be96618c ("net: stream: add unix socket")
> Fixes: 784e7a253104 ("net: dgram: add unix socket")
> Fixes: 148fbf0d58a6 ("net: stream: add a new option to automatically
> reconnect"
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>

Could be easier to review if this documentation addition is splitted in
various patches.


> ---
>  qemu-options.hx | 189 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0c8..b8a1a65f05e7 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3353,6 +3353,195 @@ SRST
>                           -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:=
56 \\
>                           -netdev socket,id=3Dn1,mcast=3D239.192.168.1:11=
02
> ,localaddr=3D1.2.3.4
>
> +``-netdev
> stream,id=3Dstr[,server=3Don|off],addr.type=3Dinet,addr.host=3Dhost,addr.=
port=3Dport[,to=3Dmaxport][,numeric=3Don|off][,keep-alive=3Don|off][,mptcp=
=3Don|off][,addr.ipv4=3Don|off][,addr.ipv6=3Don|off][,reconnect=3Dseconds]`=
`
> +    Configure a network backend to connect to another QEMU virtual
> machine or a proxy using a TCP/IP socket.
> +
> +    ``server=3Don|off``
> +        if ``on`` create a server socket
> +
> +    ``addr.host=3Dhost,addr.port=3Dport``
> +        socket address to listen on (server=3Don) or connect to (server=
=3Doff)
> +
> +    ``to=3Dmaxport``
> +        if present, this is range of possible addresses, with port
> between ``port`` and ``maxport``.
> +
> +    ``numeric=3Don|off``
> +        if ``on`` ``host`` and ``port`` are guaranteed to be numeric,
> otherwise a name resolution should be attempted (default: ``off``)
> +
> +    ``keep-alive=3Don|off``
> +        enable keep-alive when connecting to this socket.  Not supported
> for passive sockets.
> +
> +    ``mptcp=3Don|off``
> +        enable multipath TCP
> +
> +    ``ipv4=3Don|off``
> +        whether to accept IPv4 addresses, default to try both IPv4 and
> IPv6
> +
> +    ``ipv6=3Don|off``
> +        whether to accept IPv6 addresses, default to try both IPv4 and
> IPv6
> +
> +    ``reconnect=3Dseconds``
> +        for a client socket, if a socket is disconnected, then attempt a
> reconnect after the given number of seconds.
> +        Setting this to zero disables this function.  (default: 0)
> +
> +    Example (two guests connected using a TCP/IP socket):
> +
> +    .. parsed-literal::
> +
> +        # first VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      -netdev
> stream,id=3Dnet0,server=3Don,addr.type=3Dinet,addr.host=3Dlocalhost,addr.=
port=3D1234
> +        # second VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\
> +                      -netdev
> stream,id=3Dnet0,server=3Doff,addr.type=3Dinet,addr.host=3Dlocalhost,addr=
.port=3D1234,reconnect=3D5
> +
> +``-netdev
> stream,id=3Dstr[,server=3Don|off],addr.type=3Dunix,addr.path=3Dpath[,abst=
ract=3Don|off][,tight=3Don|off][,reconnect=3Dseconds]``
> +    Configure a network backend to connect to another QEMU virtual
> machine or a proxy using a TCP/UNIX socket.
>

 "TCP/UNIX": just UNIX instead?

+
> +    ``server=3Don|off``
> +        if ``on`` create a server socket
> +
> +    ``addr.path=3Dpath``
> +        filesystem path to use
> +
> +    ``abstract=3Don|off``
> +        if ``on``, this is a Linux abstract socket address.
> +
> +    ``tight=3Don|off``
> +        if false, pad an abstract socket address with enough null bytes
> to make it fill struct sockaddr_un member sun_path.
> +
> +    ``reconnect=3Dseconds``
> +        for a client socket, if a socket is disconnected, then attempt a
> reconnect after the given number of seconds.
> +        Setting this to zero disables this function.  (default: 0)
> +
> +    Example (using passt as a replacement of -netdev user):
> +
> +    .. parsed-literal::
> +
> +        # start passt server as a non privileged user
> +        passt
> +        UNIX domain socket bound at /tmp/passt_1.socket
> +        # start QEMU to connect to passt
> +        |qemu_system| linux.img \\
> +                      -device virtio-net,netdev=3Dnet0 \\
> +                      -netdev
> stream,id=3Dnet0,server=3Doff,addr.type=3Dunix,addr.path=3D/tmp/passt_1.s=
ocket
> +
> +    Example (two guests connected using a TCP/UNIX socket):
> +
>

same


> +    .. parsed-literal::
> +
> +        # first VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      netdev
> stream,id=3Dnet0,server=3Don,addr.type=3Dunix,addr.path=3D/tmp/qemu0
> +        # second VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\
> +                      -netdev
> stream,id=3Dnet0,server=3Doff,addr.type=3Dunix,addr.path=3D/tmp/qemu0,rec=
onnect=3D5
> +
> +``-netdev
> stream,id=3Dstr[,server=3Don|off],addr.type=3Dfd,addr.str=3Dfile-descript=
or[,reconnect=3Dseconds]``
> +    Configure a network backend to connect to another  QEMU  virtual
> machine or a proxy using a TCP socket file descriptor.
> +
>

I guess it would work with either a TCP or UNIX socket. Perhaps just say "a
socket file descriptor" ?


> +    ``server=3Don|off``
> +        if ``on`` create a server socket
> +
> +    ``addr.str=3Dfile-descriptor``
> +        file descriptor number to use as a socket
> +
> +    ``reconnect=3Dseconds``
> +        for a client socket, if a socket is disconnected, then attempt a
> reconnect after the given number of seconds.
> +        Setting this to zero disables this function.  (default: 0)
> +
> +``-netdev
> dgram,id=3Dstr,remote.type=3Dinet,remote.host=3Dmaddr,remote.port=3Dport[=
,local.type=3Dinet,local.host=3Daddr]``
> +    Configure a network backend to connect to a multicast address.
> +
> +    ``remote.host=3Dmaddr,remote.port=3Dport``
> +        multicast address
> +
> +    ``local.host=3Daddr``
> +        specify the host address to send packets from
> +
> +    Example:
> +
> +    .. parsed-literal::
> +
> +        # launch one QEMU instance
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      -netdev
> dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remote.port=3D=
1234
> +        # launch another QEMU instance on same "bus"
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\
> +                      -netdev
> dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remote.port=3D=
1234
> +        # launch yet another QEMU instance on same "bus"
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:58 \\
> +                      -netdev
> dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remote.port=3D=
1234
> +
> +``-netdev
> dgram,id=3Dstr,remote.type=3Dinet,remote.host=3Dmaddr,remote.port=3Dport[=
,local.type=3Dfd,local.str=3Dfile-descriptor]``
> +    Configure a network backend to connect to a multicast address using =
a
> UDP socket file descriptor.
> +
> +    ``remote.host=3Dmaddr,remote.port=3Dport``
> +        multicast address
> +
> +    ``local.str=3Dfile-descriptor``
> +        File descriptor to use to send packets
> +
> +``-netdev
> dgram,id=3Dstr,local.type=3Dinet,local.host=3Daddr,local.port=3Dport[,rem=
ote.type=3Dinet,remote.host=3Daddr,remote.port=3Dport]``
> +    Configure a network backend to connect to another QEMU virtual
> +    machine or a proxy using an UDP/IP socket.
> +
> +    ``local.host=3Daddr,local.port=3Dport``
> +        IP address to use to send the packets from
> +
> +    ``remote.host=3Daddr,remote.port=3Dport``
> +        Destination IP address
> +
> +    Example (two guests connected using an UDP/IP socket):
> +
> +    .. parsed-literal::
> +
> +        # first VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      -netdev
> dgram,id=3Dnet0,local.type=3Dinet,local.host=3Dlocalhost,local.port=3D123=
4,remote.type=3Dinet,remote.host=3Dlocalhost,remote.port=3D1235
> +        # second VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      -netdev
> dgram,id=3Dnet0,local.type=3Dinet,local.host=3Dlocalhost,local.port=3D123=
5,remote.type=3Dinet,remote.host=3Dlocalhost,remote.port=3D1234
> +
> +``-netdev
> dgram,id=3Dstr,local.type=3Dunix,local.path=3Dpath[,remote.type=3Dunix,re=
mote.path=3Dpath]``
> +    Configure a network backend to connect to another QEMU virtual
> +    machine or a proxy using an UDP/UNIX socket.
>

Here also, that kind of notation is confusing. What's the use case, since
afaik there is no multicast with UNIX socket? Perhaps this shouldn't be
allowed at all.

+
> +    ``local.path=3Dpath``
> +        filesystem path to use to bind the socket
> +
> +    ``remote.path=3Dpath``
> +        filesystem path to use as a destination (see sendto(2))
> +
> +    Example (two guests connected using an UDP/UNIX socket):
> +
> +    .. parsed-literal::
> +
> +        # first VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\
> +                      -netdev
> dgram,id=3Dnet0,local.type=3Dunix,local.path=3D/tmp/qemu0,remote.type=3Du=
nix,remote.path=3D/tmp/qemu1
> +        # second VM
> +        |qemu_system| linux.img \\
> +                      -device
> virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\
> +                      -netdev
> dgram,id=3Dnet0,local.type=3Dunix,local.path=3D/tmp/qemu1,remote.type=3Du=
nix,remote.path=3D/tmp/qemu0
> +
> +``-netdev dgram,id=3Dstr,local.type=3Dfd,local.str=3Dfile-descriptor``
> +    Configure a network backend to connect to another QEMU virtual
> +    machine or a proxy using an UDP socket file descriptor.
> +
> +    ``local.str=3Dfile-descriptor``
> +        File descriptor to use to send packets
> +
>  ``-netdev
> l2tpv3,id=3Did,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Dsrcport][,dstport=
=3Ddstport],txsession=3Dtxsession[,rxsession=3Drxsession][,ipv6=3Don|off][,=
udp=3Don|off][,cookie64][,counter][,pincounter][,txcookie=3Dtxcookie][,rxco=
okie=3Drxcookie][,offset=3Doffset]``
>      Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
>      is a popular protocol to transport Ethernet (and other Layer 2) data
> --
> 2.45.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a5fb14061c3ecf39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 26, 2024 at 7:53=E2=80=
=AFPM Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com">lvivier@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Add the description of &quot;-netdev stream&quot; and &quot;-netdev d=
gram&quot; in the QEMU<br>
manpage.<br>
<br>
Add some examples on how to use them, including a way to use<br>
&quot;-netdev stream&quot; and &quot;passt&quot; in place of &quot;-netdev =
user&quot;.<br>
(&quot;passt&quot; is a non privileged translation proxy between layer-2,<b=
r>
like &quot;-netdev stream&quot;, and layer-4 on host, like TCP, UDP,<br>
ICMP/ICMPv6 echo)<br>
<br>
Fixes: 5166fe0ae46d (&quot;qapi: net: add stream and dgram netdevs&quot;)<b=
r>
Fixes: 13c6be96618c (&quot;net: stream: add unix socket&quot;)<br>
Fixes: 784e7a253104 (&quot;net: dgram: add unix socket&quot;)<br>
Fixes: 148fbf0d58a6 (&quot;net: stream: add a new option to automatically r=
econnect&quot;<br>
Signed-off-by: Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com" tar=
get=3D"_blank">lvivier@redhat.com</a>&gt;<br></blockquote><div><br></div><d=
iv>Could be easier to review if this documentation addition is splitted in =
various patches.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
---<br>
=C2=A0qemu-options.hx | 189 +++++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 189 insertions(+)<br>
<br>
diff --git a/qemu-options.hx b/qemu-options.hx<br>
index 8ca7f34ef0c8..b8a1a65f05e7 100644<br>
--- a/qemu-options.hx<br>
+++ b/qemu-options.hx<br>
@@ -3353,6 +3353,195 @@ SRST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -device e1000,netdev=3Dn1,mac=3D52:54:00:12:34:56 \\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -netdev socket,id=3Dn1,mcast=3D<a href=3D"http://239.192.=
168.1:1102" rel=3D"noreferrer" target=3D"_blank">239.192.168.1:1102</a>,loc=
aladdr=3D1.2.3.4<br>
<br>
+``-netdev stream,id=3Dstr[,server=3Don|off],addr.type=3Dinet,addr.host=3Dh=
ost,addr.port=3Dport[,to=3Dmaxport][,numeric=3Don|off][,keep-alive=3Don|off=
][,mptcp=3Don|off][,addr.ipv4=3Don|off][,addr.ipv6=3Don|off][,reconnect=3Ds=
econds]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another QEMU virtu=
al machine or a proxy using a TCP/IP socket.<br>
+<br>
+=C2=A0 =C2=A0 ``server=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ``on`` create a server socket<br>
+<br>
+=C2=A0 =C2=A0 ``addr.host=3Dhost,addr.port=3Dport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 socket address to listen on (server=3Don) or c=
onnect to (server=3Doff)<br>
+<br>
+=C2=A0 =C2=A0 ``to=3Dmaxport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if present, this is range of possible addresse=
s, with port between ``port`` and ``maxport``.<br>
+<br>
+=C2=A0 =C2=A0 ``numeric=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ``on`` ``host`` and ``port`` are guaranteed=
 to be numeric, otherwise a name resolution should be attempted (default: `=
`off``)<br>
+<br>
+=C2=A0 =C2=A0 ``keep-alive=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable keep-alive when connecting to this sock=
et.=C2=A0 Not supported for passive sockets.<br>
+<br>
+=C2=A0 =C2=A0 ``mptcp=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable multipath TCP<br>
+<br>
+=C2=A0 =C2=A0 ``ipv4=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 whether to accept IPv4 addresses, default to t=
ry both IPv4 and IPv6<br>
+<br>
+=C2=A0 =C2=A0 ``ipv6=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 whether to accept IPv6 addresses, default to t=
ry both IPv4 and IPv6<br>
+<br>
+=C2=A0 =C2=A0 ``reconnect=3Dseconds``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for a client socket, if a socket is disconnect=
ed, then attempt a reconnect after the given number of seconds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setting this to zero disables this function.=
=C2=A0 (default: 0)<br>
+<br>
+=C2=A0 =C2=A0 Example (two guests connected using a TCP/IP socket):<br>
+<br>
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # first VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev stream,id=3Dnet0,server=3Don,addr.type=3Dinet,addr.host=3Dlocal=
host,addr.port=3D1234<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # second VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev stream,id=3Dnet0,server=3Doff,addr.type=3Dinet,addr.host=3Dloca=
lhost,addr.port=3D1234,reconnect=3D5<br>
+<br>
+``-netdev stream,id=3Dstr[,server=3Don|off],addr.type=3Dunix,addr.path=3Dp=
ath[,abstract=3Don|off][,tight=3Don|off][,reconnect=3Dseconds]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another QEMU virtu=
al machine or a proxy using a TCP/UNIX socket.<br></blockquote><div><br></d=
iv><div>=C2=A0&quot;TCP/UNIX&quot;: just UNIX instead?</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 ``server=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ``on`` create a server socket<br>
+<br>
+=C2=A0 =C2=A0 ``addr.path=3Dpath``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filesystem path to use<br>
+<br>
+=C2=A0 =C2=A0 ``abstract=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ``on``, this is a Linux abstract socket add=
ress.<br>
+<br>
+=C2=A0 =C2=A0 ``tight=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if false, pad an abstract socket address with =
enough null bytes to make it fill struct sockaddr_un member sun_path.<br>
+<br>
+=C2=A0 =C2=A0 ``reconnect=3Dseconds``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for a client socket, if a socket is disconnect=
ed, then attempt a reconnect after the given number of seconds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setting this to zero disables this function.=
=C2=A0 (default: 0)<br>
+<br>
+=C2=A0 =C2=A0 Example (using passt as a replacement of -netdev user):<br>
+<br>
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # start passt server as a non privileged user<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 passt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 UNIX domain socket bound at /tmp/passt_1.socke=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # start QEMU to connect to passt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev stream,id=3Dnet0,server=3Doff,addr.type=3Dunix,addr.path=3D/tmp=
/passt_1.socket<br>
+<br>
+=C2=A0 =C2=A0 Example (two guests connected using a TCP/UNIX socket):<br>
+<br></blockquote><div><br></div><div>same</div><div>=C2=A0<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # first VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 netdev stream,id=3Dnet0,server=3Don,addr.type=3Dunix,addr.path=3D/tmp/q=
emu0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # second VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev stream,id=3Dnet0,server=3Doff,addr.type=3Dunix,addr.path=3D/tmp=
/qemu0,reconnect=3D5<br>
+<br>
+``-netdev stream,id=3Dstr[,server=3Don|off],addr.type=3Dfd,addr.str=3Dfile=
-descriptor[,reconnect=3Dseconds]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another=C2=A0 QEMU=
=C2=A0 virtual machine or a proxy using a TCP socket file descriptor.<br>
+<br></blockquote><div><br></div><div>I guess it would work with either a T=
CP or UNIX socket. Perhaps just say &quot;a socket file descriptor&quot; ?<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+=C2=A0 =C2=A0 ``server=3Don|off``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ``on`` create a server socket<br>
+<br>
+=C2=A0 =C2=A0 ``addr.str=3Dfile-descriptor``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 file descriptor number to use as a socket<br>
+<br>
+=C2=A0 =C2=A0 ``reconnect=3Dseconds``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for a client socket, if a socket is disconnect=
ed, then attempt a reconnect after the given number of seconds.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setting this to zero disables this function.=
=C2=A0 (default: 0)<br>
+<br>
+``-netdev dgram,id=3Dstr,remote.type=3Dinet,remote.host=3Dmaddr,remote.por=
t=3Dport[,local.type=3Dinet,local.host=3Daddr]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to a multicast addres=
s.<br>
+<br>
+=C2=A0 =C2=A0 ``remote.host=3Dmaddr,remote.port=3Dport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 multicast address<br>
+<br>
+=C2=A0 =C2=A0 ``local.host=3Daddr``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 specify the host address to send packets from<=
br>
+<br>
+=C2=A0 =C2=A0 Example:<br>
+<br>
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # launch one QEMU instance<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remo=
te.port=3D1234<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # launch another QEMU instance on same &quot;b=
us&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remo=
te.port=3D1234<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # launch yet another QEMU instance on same &qu=
ot;bus&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:58 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,remote.type=3Dinet,remote.host=3D224.0.0.1,remo=
te.port=3D1234<br>
+<br>
+``-netdev dgram,id=3Dstr,remote.type=3Dinet,remote.host=3Dmaddr,remote.por=
t=3Dport[,local.type=3Dfd,local.str=3Dfile-descriptor]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to a multicast addres=
s using a UDP socket file descriptor.<br>
+<br>
+=C2=A0 =C2=A0 ``remote.host=3Dmaddr,remote.port=3Dport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 multicast address<br>
+<br>
+=C2=A0 =C2=A0 ``local.str=3Dfile-descriptor``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 File descriptor to use to send packets<br>
+<br>
+``-netdev dgram,id=3Dstr,local.type=3Dinet,local.host=3Daddr,local.port=3D=
port[,remote.type=3Dinet,remote.host=3Daddr,remote.port=3Dport]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another QEMU virtu=
al<br>
+=C2=A0 =C2=A0 machine or a proxy using an UDP/IP socket.<br>
+<br>
+=C2=A0 =C2=A0 ``local.host=3Daddr,local.port=3Dport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 IP address to use to send the packets from<br>
+<br>
+=C2=A0 =C2=A0 ``remote.host=3Daddr,remote.port=3Dport``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Destination IP address<br>
+<br>
+=C2=A0 =C2=A0 Example (two guests connected using an UDP/IP socket):<br>
+<br>
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # first VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,local.type=3Dinet,local.host=3Dlocalhost,local.=
port=3D1234,remote.type=3Dinet,remote.host=3Dlocalhost,remote.port=3D1235<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # second VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,local.type=3Dinet,local.host=3Dlocalhost,local.=
port=3D1235,remote.type=3Dinet,remote.host=3Dlocalhost,remote.port=3D1234<b=
r>
+<br>
+``-netdev dgram,id=3Dstr,local.type=3Dunix,local.path=3Dpath[,remote.type=
=3Dunix,remote.path=3Dpath]``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another QEMU virtu=
al<br>
+=C2=A0 =C2=A0 machine or a proxy using an UDP/UNIX socket.<br></blockquote=
><div><br></div><div>Here also, that kind of notation is confusing. What&#3=
9;s the use case, since afaik there is no multicast with UNIX socket? Perha=
ps this shouldn&#39;t be allowed at all.<br></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 ``local.path=3Dpath``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filesystem path to use to bind the socket<br>
+<br>
+=C2=A0 =C2=A0 ``remote.path=3Dpath``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filesystem path to use as a destination (see s=
endto(2))<br>
+<br>
+=C2=A0 =C2=A0 Example (two guests connected using an UDP/UNIX socket):<br>
+<br>
+=C2=A0 =C2=A0 .. parsed-literal::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # first VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:56 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,local.type=3Dunix,local.path=3D/tmp/qemu0,remot=
e.type=3Dunix,remote.path=3D/tmp/qemu1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # second VM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 |qemu_system| linux.img \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -device virtio-net,netdev=3Dnet0,mac=3D52:54:00:12:34:57 \\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -netdev dgram,id=3Dnet0,local.type=3Dunix,local.path=3D/tmp/qemu1,remot=
e.type=3Dunix,remote.path=3D/tmp/qemu0<br>
+<br>
+``-netdev dgram,id=3Dstr,local.type=3Dfd,local.str=3Dfile-descriptor``<br>
+=C2=A0 =C2=A0 Configure a network backend to connect to another QEMU virtu=
al<br>
+=C2=A0 =C2=A0 machine or a proxy using an UDP socket file descriptor.<br>
+<br>
+=C2=A0 =C2=A0 ``local.str=3Dfile-descriptor``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 File descriptor to use to send packets<br>
+<br>
=C2=A0``-netdev l2tpv3,id=3Did,src=3Dsrcaddr,dst=3Ddstaddr[,srcport=3Dsrcpo=
rt][,dstport=3Ddstport],txsession=3Dtxsession[,rxsession=3Drxsession][,ipv6=
=3Don|off][,udp=3Don|off][,cookie64][,counter][,pincounter][,txcookie=3Dtxc=
ookie][,rxcookie=3Drxcookie][,offset=3Doffset]``<br>
=C2=A0 =C2=A0 =C2=A0Configure a L2TPv3 pseudowire host network backend. L2T=
Pv3 (RFC3931)<br>
=C2=A0 =C2=A0 =C2=A0is a popular protocol to transport Ethernet (and other =
Layer 2) data<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000a5fb14061c3ecf39--

