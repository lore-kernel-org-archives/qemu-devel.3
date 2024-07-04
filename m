Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B20C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHB2-0002Md-Fs; Thu, 04 Jul 2024 03:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPHAg-0002IJ-B3
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPHAW-0006Vh-CM
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720079172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IVEQ9RocVi/c9uTxGYMIldsukyfX8lVpDl9Us1kMi6o=;
 b=EnZ34MasIfCcmxEPb8iTEh93xTlsmr7qoz597mZ5nbiwWXOBN2j06Jfld0VJUjgFB5LUgZ
 Pa9E4JLD1+GFizqog2WNmA8sL8gf8bp3G1IHrBT6Ar6R+hPjcKPprZrQWILcaLp7EurfFs
 gTxseg1IPkd2dFjx2DZP/EGLNoKjCrc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-pKiHhV1_O6SDC7zVd10eag-1; Thu, 04 Jul 2024 03:46:09 -0400
X-MC-Unique: pKiHhV1_O6SDC7zVd10eag-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4466b3b06fbso5349981cf.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 00:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079169; x=1720683969;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVEQ9RocVi/c9uTxGYMIldsukyfX8lVpDl9Us1kMi6o=;
 b=f+iRLx2uaCh3TOJ0WSsakT9VDwvs8E3GF+eRCZeaHju4MEKeFj4HbnEQMQc9lSBhr7
 EjoY0QGGYh53qJ7GX8YX3W1NhbeIpitMbHfFxn+6BUX3w6gOnjUW2tDoyRbmiGIHZFBN
 30Rrt7hkQMe5wU5Bv715ULiyqIwwoPuqKxj65Mn7DeTNNaLTsnVSKide2nNsDxNi9Bkb
 4PG3Hoe0/x1siETjepu4mWO74UOi0KXX32AXDZ4Q1tNiVWQJM9frRREp8oThhbQPxLis
 itP3pC1SBKk4OG6y2C+I2StvbNSX/EDF/hIhYGT42h24PUJsLJCcBnG0nY/e8akxxivm
 ROxw==
X-Gm-Message-State: AOJu0YzNYWy6JJuuqLoNLP64d3RtOa6wL9T/NSORPqTSJ64wK6nQqeJz
 ykWNfBOfCBRd/tvHU+I6aohG5FrkQDKGlxUi2+1GbRHkXnQvABTe06TMBY1s8G/M4sTRicrSU1A
 Dej2haWPqVbbkkjNlHXaLJQQiJW93vbCGwxsa87DAkH/DfXElvy8X
X-Received: by 2002:a05:622a:409:b0:446:59bf:eaff with SMTP id
 d75a77b69052e-447cbf945ddmr9591001cf.65.1720079169175; 
 Thu, 04 Jul 2024 00:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy5o7s4dUGfIs9sirTlCxSe8F5sl+GdToYlbh0j1scE+9zo3q3if6sKhdUHMyKrHLXFc12nQ==
X-Received: by 2002:a05:622a:409:b0:446:59bf:eaff with SMTP id
 d75a77b69052e-447cbf945ddmr9590841cf.65.1720079168786; 
 Thu, 04 Jul 2024 00:46:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:8e19:3414:44f0:befd?
 ([2a01:e0a:e10:ef90:8e19:3414:44f0:befd])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446513db848sm58342921cf.1.2024.07.04.00.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:46:08 -0700 (PDT)
Message-ID: <caf8a980-c4a3-4009-8765-ad4e26354d7d@redhat.com>
Date: Thu, 4 Jul 2024 09:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: update netdev stream/dgram man page
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20240626155140.74752-1-lvivier@redhat.com>
 <CAJ+F1CLsKpd=wNccJ3+eNQbA12OWE7iFnFDh8kjaJpPXFmtXsg@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CAJ+F1CLsKpd=wNccJ3+eNQbA12OWE7iFnFDh8kjaJpPXFmtXsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Hi Marc-André,

thank you for your comments, you're right I should not mix TCP/UDP and unix socket.  I'm 
going to fix that.

Thanks,
Laurent

On 02/07/2024 09:39, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jun 26, 2024 at 7:53 PM Laurent Vivier <lvivier@redhat.com 
> <mailto:lvivier@redhat.com>> wrote:
> 
>     Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
>     manpage.
> 
>     Add some examples on how to use them, including a way to use
>     "-netdev stream" and "passt" in place of "-netdev user".
>     ("passt" is a non privileged translation proxy between layer-2,
>     like "-netdev stream", and layer-4 on host, like TCP, UDP,
>     ICMP/ICMPv6 echo)
> 
>     Fixes: 5166fe0ae46d ("qapi: net: add stream and dgram netdevs")
>     Fixes: 13c6be96618c ("net: stream: add unix socket")
>     Fixes: 784e7a253104 ("net: dgram: add unix socket")
>     Fixes: 148fbf0d58a6 ("net: stream: add a new option to automatically reconnect"
>     Signed-off-by: Laurent Vivier <lvivier@redhat.com <mailto:lvivier@redhat.com>>
> 
> 
> Could be easier to review if this documentation addition is splitted in various patches.
> 
>     ---
>       qemu-options.hx | 189 ++++++++++++++++++++++++++++++++++++++++++++++++
>       1 file changed, 189 insertions(+)
> 
>     diff --git a/qemu-options.hx b/qemu-options.hx
>     index 8ca7f34ef0c8..b8a1a65f05e7 100644
>     --- a/qemu-options.hx
>     +++ b/qemu-options.hx
>     @@ -3353,6 +3353,195 @@ SRST
>                                -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                                -netdev socket,id=n1,mcast=239.192.168.1:1102
>     <http://239.192.168.1:1102>,localaddr=1.2.3.4
> 
>     +``-netdev
>     stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect=seconds]``
>     +    Configure a network backend to connect to another QEMU virtual machine or a proxy
>     using a TCP/IP socket.
>     +
>     +    ``server=on|off``
>     +        if ``on`` create a server socket
>     +
>     +    ``addr.host=host,addr.port=port``
>     +        socket address to listen on (server=on) or connect to (server=off)
>     +
>     +    ``to=maxport``
>     +        if present, this is range of possible addresses, with port between ``port``
>     and ``maxport``.
>     +
>     +    ``numeric=on|off``
>     +        if ``on`` ``host`` and ``port`` are guaranteed to be numeric, otherwise a
>     name resolution should be attempted (default: ``off``)
>     +
>     +    ``keep-alive=on|off``
>     +        enable keep-alive when connecting to this socket.  Not supported for passive
>     sockets.
>     +
>     +    ``mptcp=on|off``
>     +        enable multipath TCP
>     +
>     +    ``ipv4=on|off``
>     +        whether to accept IPv4 addresses, default to try both IPv4 and IPv6
>     +
>     +    ``ipv6=on|off``
>     +        whether to accept IPv6 addresses, default to try both IPv4 and IPv6
>     +
>     +    ``reconnect=seconds``
>     +        for a client socket, if a socket is disconnected, then attempt a reconnect
>     after the given number of seconds.
>     +        Setting this to zero disables this function.  (default: 0)
>     +
>     +    Example (two guests connected using a TCP/IP socket):
>     +
>     +    .. parsed-literal::
>     +
>     +        # first VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      -netdev
>     stream,id=net0,server=on,addr.type=inet,addr.host=localhost,addr.port=1234
>     +        # second VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
>     +                      -netdev
>     stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect=5
>     +
>     +``-netdev
>     stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect=seconds]``
>     +    Configure a network backend to connect to another QEMU virtual machine or a proxy
>     using a TCP/UNIX socket.
> 
> 
>   "TCP/UNIX": just UNIX instead?
> 
>     +
>     +    ``server=on|off``
>     +        if ``on`` create a server socket
>     +
>     +    ``addr.path=path``
>     +        filesystem path to use
>     +
>     +    ``abstract=on|off``
>     +        if ``on``, this is a Linux abstract socket address.
>     +
>     +    ``tight=on|off``
>     +        if false, pad an abstract socket address with enough null bytes to make it
>     fill struct sockaddr_un member sun_path.
>     +
>     +    ``reconnect=seconds``
>     +        for a client socket, if a socket is disconnected, then attempt a reconnect
>     after the given number of seconds.
>     +        Setting this to zero disables this function.  (default: 0)
>     +
>     +    Example (using passt as a replacement of -netdev user):
>     +
>     +    .. parsed-literal::
>     +
>     +        # start passt server as a non privileged user
>     +        passt
>     +        UNIX domain socket bound at /tmp/passt_1.socket
>     +        # start QEMU to connect to passt
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0 \\
>     +                      -netdev
>     stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/passt_1.socket
>     +
>     +    Example (two guests connected using a TCP/UNIX socket):
>     +
> 
> 
> same
> 
>     +    .. parsed-literal::
>     +
>     +        # first VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      netdev stream,id=net0,server=on,addr.type=unix,addr.path=/tmp/qemu0
>     +        # second VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
>     +                      -netdev
>     stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0,reconnect=5
>     +
>     +``-netdev
>     stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect=seconds]``
>     +    Configure a network backend to connect to another  QEMU  virtual machine or a
>     proxy using a TCP socket file descriptor.
>     +
> 
> 
> I guess it would work with either a TCP or UNIX socket. Perhaps just say "a socket file 
> descriptor" ?
> 
>     +    ``server=on|off``
>     +        if ``on`` create a server socket
>     +
>     +    ``addr.str=file-descriptor``
>     +        file descriptor number to use as a socket
>     +
>     +    ``reconnect=seconds``
>     +        for a client socket, if a socket is disconnected, then attempt a reconnect
>     after the given number of seconds.
>     +        Setting this to zero disables this function.  (default: 0)
>     +
>     +``-netdev
>     dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=inet,local.host=addr]``
>     +    Configure a network backend to connect to a multicast address.
>     +
>     +    ``remote.host=maddr,remote.port=port``
>     +        multicast address
>     +
>     +    ``local.host=addr``
>     +        specify the host address to send packets from
>     +
>     +    Example:
>     +
>     +    .. parsed-literal::
>     +
>     +        # launch one QEMU instance
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      -netdev
>     dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
>     +        # launch another QEMU instance on same "bus"
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
>     +                      -netdev
>     dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
>     +        # launch yet another QEMU instance on same "bus"
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:58 \\
>     +                      -netdev
>     dgram,id=net0,remote.type=inet,remote.host=224.0.0.1,remote.port=1234
>     +
>     +``-netdev
>     dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=fd,local.str=file-descriptor]``
>     +    Configure a network backend to connect to a multicast address using a UDP socket
>     file descriptor.
>     +
>     +    ``remote.host=maddr,remote.port=port``
>     +        multicast address
>     +
>     +    ``local.str=file-descriptor``
>     +        File descriptor to use to send packets
>     +
>     +``-netdev
>     dgram,id=str,local.type=inet,local.host=addr,local.port=port[,remote.type=inet,remote.host=addr,remote.port=port]``
>     +    Configure a network backend to connect to another QEMU virtual
>     +    machine or a proxy using an UDP/IP socket.
>     +
>     +    ``local.host=addr,local.port=port``
>     +        IP address to use to send the packets from
>     +
>     +    ``remote.host=addr,remote.port=port``
>     +        Destination IP address
>     +
>     +    Example (two guests connected using an UDP/IP socket):
>     +
>     +    .. parsed-literal::
>     +
>     +        # first VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      -netdev
>     dgram,id=net0,local.type=inet,local.host=localhost,local.port=1234,remote.type=inet,remote.host=localhost,remote.port=1235
>     +        # second VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      -netdev
>     dgram,id=net0,local.type=inet,local.host=localhost,local.port=1235,remote.type=inet,remote.host=localhost,remote.port=1234
>     +
>     +``-netdev
>     dgram,id=str,local.type=unix,local.path=path[,remote.type=unix,remote.path=path]``
>     +    Configure a network backend to connect to another QEMU virtual
>     +    machine or a proxy using an UDP/UNIX socket.
> 
> 
> Here also, that kind of notation is confusing. What's the use case, since afaik there is 
> no multicast with UNIX socket? Perhaps this shouldn't be allowed at all.
> 
>     +
>     +    ``local.path=path``
>     +        filesystem path to use to bind the socket
>     +
>     +    ``remote.path=path``
>     +        filesystem path to use as a destination (see sendto(2))
>     +
>     +    Example (two guests connected using an UDP/UNIX socket):
>     +
>     +    .. parsed-literal::
>     +
>     +        # first VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:56 \\
>     +                      -netdev
>     dgram,id=net0,local.type=unix,local.path=/tmp/qemu0,remote.type=unix,remote.path=/tmp/qemu1
>     +        # second VM
>     +        |qemu_system| linux.img \\
>     +                      -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
>     +                      -netdev
>     dgram,id=net0,local.type=unix,local.path=/tmp/qemu1,remote.type=unix,remote.path=/tmp/qemu0
>     +
>     +``-netdev dgram,id=str,local.type=fd,local.str=file-descriptor``
>     +    Configure a network backend to connect to another QEMU virtual
>     +    machine or a proxy using an UDP socket file descriptor.
>     +
>     +    ``local.str=file-descriptor``
>     +        File descriptor to use to send packets
>     +
>       ``-netdev
>     l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6=on|off][,udp=on|off][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
>           Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931)
>           is a popular protocol to transport Ethernet (and other Layer 2) data
>     -- 
>     2.45.2
> 
> 
> 
> 
> -- 
> Marc-André Lureau


