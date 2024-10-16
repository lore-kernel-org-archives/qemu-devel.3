Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880AD1AD48
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 11:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t12CS-0001oJ-OG; Wed, 16 Oct 2024 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t12CR-0001nv-5q
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t12CP-0003DS-0G
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729078095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibFCA1jLUKHnuuKwGDTvNwlsQGvuD1sTPI0UTQoFd4U=;
 b=S6XuyTnOfj5+6xc8/VuKs6gRp/ytQ/xOmWQ1yuYPvrKB+27/KF5HtZcVa2VTgkinncJ1oL
 rRXpitUCS5Plc5wDTIQE5g4VJQs0sqVYZOxdyRKcRsHbLjpGQIe/gj8GltUVsoRNNFkLPc
 1B7rGyUl3dMXGw3upb1EYKpz7uEI10Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-VkvC_djQNFiP5canWxRE8w-1; Wed, 16 Oct 2024 07:28:13 -0400
X-MC-Unique: VkvC_djQNFiP5canWxRE8w-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so4786844a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 04:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729078093; x=1729682893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibFCA1jLUKHnuuKwGDTvNwlsQGvuD1sTPI0UTQoFd4U=;
 b=Gl08F1gPwdRt3C8XS8t2SENXciq594stsluVoB77ziaJbEieQuuZb6+B6NDURrVM6C
 Q9q+DjyjsEJhNd/SFxYV6vL7vnD1hkdm2AHSMQYnWHoizoN7USzydrp37pBJIdCYDWnh
 vhdYySeIYE75ZG+LMMpZWjyjqYie3h4ME23LiWWh82zcNrlbsIVuz45y28rCOLzHgyPv
 PmXqa0KgfQLa+4SupD2N2wzl/MTDeTCxaGfR70fTQzzc7qhOKh/Vx0yNLVZGCZpuwQoU
 F3eX8mK36smn3iVhqslGH93KOmJuUk8gE9QLAy+tqEwOiOund8RDkn8CoeMJacChFTBh
 UNdQ==
X-Gm-Message-State: AOJu0YzLdeotrJgSmtD/DVZ8WMO0TJuLD2Qwqkmv/OYTufXtGRXj961J
 jBWKc0fizsCZty4KdhCHbidJ6Y28fFzqrMSGznYbLAXEZH9VO5iudiQy1UvaUSPCdKViyMGhzMx
 eCZGiLJ7AwCCNWAIBEsyZYvyadsyZDJbKDh++sHrjdYgKPciRCW6hCxJ6RTJdejYO9giYAgcVlW
 ORK1QyNoomXfuvI/7IsOkGenoD1U8=
X-Received: by 2002:a17:90b:4a46:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e3ab7c7935mr4057361a91.5.1729078092490; 
 Wed, 16 Oct 2024 04:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY87LHvDIijAoBFZXmRenUl9Ye1bIzdtCYph/j5Vfrh9R2RyZzNRgXwXTLVHxDhhsN0WaJkQMpnSh0MgrdOhI=
X-Received: by 2002:a17:90b:4a46:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e3ab7c7935mr4057327a91.5.1729078092035; Wed, 16 Oct 2024
 04:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-9-r.peniaev@gmail.com>
In-Reply-To: <20241016102605.459395-9-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Oct 2024 15:27:59 +0400
Message-ID: <CAMxuvayHTYDsXAp=8pwixa15g+oDWC-CSGYhg=RB5RpWdtB0_w@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] qemu-options.hx: describe multiplexing of several
 backend devices
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Wed, Oct 16, 2024 at 2:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> This adds a few lines describing `mux-be` multiplexer configuration
> for multiplexing several backend devices with a single frontend
> device.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  qemu-options.hx | 78 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 20 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index daae49414740..dd5dfe8596f0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3677,37 +3677,37 @@ DEFHEADING(Character device options:)
>
>  DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev help\n"
> -    "-chardev null,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3D=
on|off]\n"
> +    "-chardev null,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,logfile=3DPA=
TH][,logappend=3Don|off]\n"
>      "-chardev socket,id=3Did[,host=3Dhost],port=3Dport[,to=3Dto][,ipv4=
=3Don|off][,ipv6=3Don|off][,nodelay=3Don|off]\n"
> -    "         [,server=3Don|off][,wait=3Don|off][,telnet=3Don|off][,webs=
ocket=3Don|off][,reconnect=3Dseconds][,mux=3Don|off]\n"
> +    "         [,server=3Don|off][,wait=3Don|off][,telnet=3Don|off][,webs=
ocket=3Don|off][,reconnect=3Dseconds][,mux=3Don|off][,mux-be-id=3Did]\n"
>      "         [,logfile=3DPATH][,logappend=3Don|off][,tls-creds=3DID][,t=
ls-authz=3DID] (tcp)\n"
>      "-chardev socket,id=3Did,path=3Dpath[,server=3Don|off][,wait=3Don|of=
f][,telnet=3Don|off][,websocket=3Don|off][,reconnect=3Dseconds]\n"
> -    "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off][,abs=
tract=3Don|off][,tight=3Don|off] (unix)\n"
> +    "         [,mux=3Don|off][,mux-be-id=3Did][,logfile=3DPATH][,logappe=
nd=3Don|off][,abstract=3Don|off][,tight=3Don|off] (unix)\n"
>      "-chardev udp,id=3Did[,host=3Dhost],port=3Dport[,localaddr=3Dlocalad=
dr]\n"
> -    "         [,localport=3Dlocalport][,ipv4=3Don|off][,ipv6=3Don|off][,=
mux=3Don|off]\n"
> +    "         [,localport=3Dlocalport][,ipv4=3Don|off][,ipv6=3Don|off][,=
mux=3Don|off][,mux-be-id=3Did]\n"
>      "         [,logfile=3DPATH][,logappend=3Don|off]\n"
> -    "-chardev msmouse,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> +    "-chardev msmouse,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,logfile=
=3DPATH][,logappend=3Don|off]\n"
>      "-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dco=
ls][,rows=3Drows]]\n"
> -    "         [,mux=3Don|off][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "         [,mux=3Don|off][,mux-be-id=3Did][,logfile=3DPATH][,logappe=
nd=3Don|off]\n"
>      "-chardev ringbuf,id=3Did[,size=3Dsize][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> -    "-chardev file,id=3Did,path=3Dpath[,input-path=3Dinput-file][,mux=3D=
on|off][,logfile=3DPATH][,logappend=3Don|off]\n"
> -    "-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH][,=
logappend=3Don|off]\n"
> +    "-chardev file,id=3Did,path=3Dpath[,input-path=3Dinput-file][,mux=3D=
on|off][,mux-be-id=3Did][,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "-chardev pipe,id=3Did,path=3Dpath[,mux=3Don|off][,mux-be-id=3Did][,=
logfile=3DPATH][,logappend=3Don|off]\n"
>  #ifdef _WIN32
> -    "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> -    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
> +    "-chardev console,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,logfile=
=3DPATH][,logappend=3Don|off]\n"
> +    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,mux-be-id=3Did]=
[,logfile=3DPATH][,logappend=3Don|off]\n"
>  #else
> -    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH][=
,logappend=3Don|off]\n"
> -    "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3D=
PATH][,logappend=3Don|off]\n"
> +    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,mux-be-id=3Did][=
,logfile=3DPATH][,logappend=3Don|off]\n"
> +    "-chardev stdio,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,signal=3Don=
|off][,logfile=3DPATH][,logappend=3Don|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
> -    "-chardev braille,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
> +    "-chardev braille,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,logfile=
=3DPATH][,logappend=3Don|off]\n"
>  #endif
>  #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
>          || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__Drag=
onFly__)
> -    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
> +    "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,mux-be-id=3Did]=
[,logfile=3DPATH][,logappend=3Don|off]\n"
>  #endif
>  #if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
> -    "-chardev parallel,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPAT=
H][,logappend=3Don|off]\n"
> +    "-chardev parallel,id=3Did,path=3Dpath[,mux=3Don|off][,mux-be-id=3Di=
d][,logfile=3DPATH][,logappend=3Don|off]\n"
>  #endif
>  #if defined(CONFIG_SPICE)
>      "-chardev spicevmc,id=3Did,name=3Dname[,debug=3Ddebug][,logfile=3DPA=
TH][,logappend=3Don|off]\n"
> @@ -3719,8 +3719,8 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>  SRST
>  The general form of a character device option is:
>
> -``-chardev backend,id=3Did[,mux=3Don|off][,options]``
> -    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
> +``-chardev backend,id=3Did[,mux=3Don|off][,mux-be-id=3Did][,options]``
> +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``mux=
-be``,
>      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
>      ``pty``, ``stdio``, ``braille``, ``parallel``,
>      ``spicevmc``, ``spiceport``. The specific backend will determine the
> @@ -3777,9 +3777,10 @@ The general form of a character device option is:
>      the QEMU monitor, and ``-nographic`` also multiplexes the console
>      and the monitor to stdio.
>
> -    There is currently no support for multiplexing in the other
> -    direction (where a single QEMU front end takes input and output from
> -    multiple chardevs).
> +    If you need to multiplex in the opposite direction (where one QEMU
> +    interface receives input and output from multiple chardev devices),
> +    each character device needs ``mux-be-id=3Did`` option. Please refer
> +    to the paragraph below regarding chardev ``mux-be`` configuration.
>
>      Every backend supports the ``logfile`` option, which supplies the
>      path to a file to record all data transmitted via the backend. The
> @@ -3879,6 +3880,43 @@ The available backends are:
>      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
>      does not take any options.
>
> +``-chardev mux-be,id=3Did``
> +    Explicitly create chardev backend multiplexer with possibility to
> +    multiplex in the opposite direction, where one QEMU interface
> +    (frontend device) receives input and output from multiple chardev
> +    backend devices.

We are not very good at documenting the version, but you could add (Since 9=
.2)

> +
> +    For example the following is a use case of 2 backend devices: text
> +    virtual console ``vc0`` and a socket ``sock0`` connected
> +    to a single virtio hvc console frontend device with multiplexer
> +    ``mux0`` help. Virtual console renders text to an image, which
> +    can be shared over the VNC protocol, in turn socket backend provides
> +    biderectional communication to the virtio hvc console over socket.

bidirectional

> +    The example configuration can be the following:
> +
> +    ::
> +
> +       -chardev mux-be,id=3Dmux0 \
> +       -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock=
0,mux-be-id=3Dmux0 \
> +       -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
> +       -device virtconsole,chardev=3Dmux0 \
> +       -vnc 0.0.0.0:0
> +
> +    Once QEMU starts VNC client and any TTY emulator can be used to
> +    control a single hvc console:
> +
> +    ::
> +
> +       # VNC client
> +       vncviewer :0
> +
> +       # TTY emulator
> +       socat unix-connect:/tmp/sock pty,link=3D/tmp/pty & \
> +       tio /tmp/pty
> +
> +    Multiplexing of several backend devices with serveral frontend devic=
es

several

> +    is not supported.
> +
>  ``-chardev vc,id=3Did[[,width=3Dwidth][,height=3Dheight]][[,cols=3Dcols]=
[,rows=3Drows]]``
>      Connect to a QEMU text console. ``vc`` may optionally be given a
>      specific size.
> --
> 2.34.1
>


