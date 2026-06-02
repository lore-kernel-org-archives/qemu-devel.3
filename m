Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7AC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUGtc-0006Wq-CA; Tue, 02 Jun 2026 00:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUGtb-0006WN-6k
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUGtZ-0005ep-My
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780375108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K27ZwbfvQ+bUUKesY1uvEaabt9ItKQH+6jACALfjNLU=;
 b=Sn5nsxXEYxUrXkQFLBNtUodzKxAriz3BIj2nIHINgRsSYYXe0PAN4VQuSAGrojJ8mAYMoi
 brjcKDnbrtPfJuFXBV26v1DUg9obWhz5fhIUgWsX2weFI9uiMgPgpbfedoSR1BJiGKksb2
 /hlZMuyCtfHRoH5MvCGZMcwGfosiCYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-RQj2KckfNsiyKQwwm5SkLA-1; Tue,
 02 Jun 2026 00:38:27 -0400
X-MC-Unique: RQj2KckfNsiyKQwwm5SkLA-1
X-Mimecast-MFC-AGG-ID: RQj2KckfNsiyKQwwm5SkLA_1780375106
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0A4C1956095; Tue,  2 Jun 2026 04:38:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007C21800347; Tue,  2 Jun 2026 04:38:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F0C021E6A01; Tue, 02 Jun 2026 06:38:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] qemu-options: document
 keep-alive-count/idle/interval for -netdev stream
In-Reply-To: <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com> (Mitsuru
 Kariya's message of "Sun, 24 May 2026 16:34:39 +0900")
References: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
 <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com>
Date: Tue, 02 Jun 2026 06:38:22 +0200
Message-ID: <87y0gx8sld.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com> writes:

> The keep-alive-count, keep-alive-idle and keep-alive-interval members of
> InetSocketAddress have been available for -netdev stream (and every
> other QAPI SocketAddress consumer) since the qemu-sockets keep-alive
> options were extended in 10.1, but were never documented in
> qemu-options.hx.
>
> Add their descriptions, and drop the "Not supported for passive sockets"
> remark from addr.keep-alive=on|off: as of 10.1 keep-alive on listening
> sockets is also supported (see the SocketAddress @keep-alive QAPI doc
> comment, which records "(Since 4.2, not supported for listening sockets
> until 10.1)").
>
> Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
> ---
>  qemu-options.hx | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 527fc12494..7432b77571 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3034,7 +3034,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
>      "                configure a network backend to connect to another network\n"
>      "                using an UDP tunnel\n"
> -    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
> +    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
>      "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]\n"
>      "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
>      "                configure a network backend to connect to another network\n"
> @@ -3640,7 +3640,7 @@ SRST
>                           -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
>                           -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
>  
> -``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
> +``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
>      Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
>  
>      ``server=on|off``
> @@ -3656,7 +3656,19 @@ SRST
>          if ``on`` ``host`` and ``port`` are guaranteed to be numeric, otherwise a name resolution should be attempted (default: ``off``)
>  
>      ``addr.keep-alive=on|off``
> -        enable keep-alive when connecting to this socket.  Not supported for passive sockets.
> +        enable keep-alive when connecting to this socket.
> +
> +    ``addr.keep-alive-count=count``
> +        number of keep-alive packets to send before dropping the connection.
> +        Set to 0 to use the system default.  (default: 0)
> +
> +    ``addr.keep-alive-idle=idle``
> +        time in seconds the connection needs to be idle before sending keep-alive packets.
> +        Set to 0 to use the system default.  (default: 0)
> +
> +    ``addr.keep-alive-interval=interval``
> +        time in seconds between individual keep-alive packets.
> +        Set to 0 to use the system default.  (default: 0)
>  
>      ``addr.mptcp=on|off``
>          enable multipath TCP

You document these options only for -netdev stream.  They also work for
-netdev dgram, possibly more (didn't check).  Shouldn't we document them
every where they work?


