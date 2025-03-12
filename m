Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B1C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 03:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsCRI-0001wh-VK; Tue, 11 Mar 2025 23:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1tsCRA-0001wN-Lh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 23:07:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1tsCR5-00008n-Pr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 23:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202502; t=1741748820;
 bh=BON3SlQl/MBULel0pVEvk8ISu7gTiQENyw2FFLvgvDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QzRCMZZBR0GRO2X1FXu6VxPVDihB7b98erZgk+5g8Opl/lgypQWXsX5RZZYVYE4o9
 aB2PwztEkISPuLhmFBQEuD6E6YuQbkWD3zjZ0AgiLFr0Kb2oV8hbdzo8yatZ0ZWYpn
 Sv0LnPzzv6KwmJpx4A95i0ecyP4vOPmky/3MnliDEJ4HXE80NP8qDU9BFscT/9hLL/
 /kQniru2aiGFnSsmR9z9CiMniWJQyv2//okGWcmxniGLrYFhNfv2vlNvY57h2ayvbr
 COHwwYlhofN0jN3IWOCxeG8CS+SNOXgtSezliZqTZn9PAxhCI4AWL1ex/xRFPv17OT
 LeDt1NSztm52A==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4ZCFsc4gsGz4xCW; Wed, 12 Mar 2025 14:07:00 +1100 (AEDT)
Date: Wed, 12 Mar 2025 12:38:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] docs: Explain how to use passt
Message-ID: <Z9DloC__TeZOZ9OK@zatzit>
References: <20250311132714.166189-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1T9eMvjKakp/xd0F"
Content-Disposition: inline
In-Reply-To: <20250311132714.166189-1-lvivier@redhat.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 PDS_OTHER_BAD_TLD=0.413, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--1T9eMvjKakp/xd0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 02:27:14PM +0100, Laurent Vivier wrote:
> Add a chapter to explain how to use passt(1) instead of '-net user'.
> passt(1) can be connected to QEMU using UNIX socket or vhost-user.
> With vhost-user, migration of the VM is allowed and internal state of
> passt(1) is transfered from one side to the other
>=20
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  docs/system/devices/net.rst | 100 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>=20
> diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
> index 2ab516d4b097..a3efbdcabd1a 100644
> --- a/docs/system/devices/net.rst
> +++ b/docs/system/devices/net.rst
> @@ -77,6 +77,106 @@ When using the ``'-netdev user,hostfwd=3D...'`` optio=
n, TCP or UDP
>  connections can be redirected from the host to the guest. It allows for
>  example to redirect X11, telnet or SSH connections.
> =20
> +Using passt as the user mode network stack
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +passt_ can be used as a simple replacement for SLIRP (``-net user``).
> +passt doesn't require any capability or privilege. passt has
> +better performance than ``-net user``, full IPv6 support and better secu=
rity
> +as it's a daemon that is not executed in QEMU context.
> +
> +passt can be connected to QEMU either by using a socket
> +(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-=
user``).
> +See `passt(1)`_ for more details on passt.
> +
> +.. _passt: https://passt.top/
> +.. _passt(1): https://passt.top/builds/latest/web/passt.1.html
> +
> +To use socket based passt interface:
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Start passt as a daemon::
> +
> +   passt --socket ~/passt.socket
> +
> +If ``--socket`` is not provided, passt will print the path of the UNIX d=
omain socket QEMU can connect to (``/tmp/passt_1.socket``, ``/tmp/passt_2.s=
ocket``,
> +...). Then you can connect your QEMU instance to passt:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -device virtio-net-pci,netdev=3Dnetdev0=
 -netdev stream,id=3Dnetdev0,server=3Doff,addr.type=3Dunix,addr.path=3D~/pa=
sst.socket
> +
> +Where ``~/passt.socket`` is the UNIX socket created by passt to
> +communicate with QEMU.
> +
> +To use vhost-based interface:
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Start passt with ``--vhost-user``::
> +
> +   passt --vhost-user --socket ~/passt.socket
> +
> +Then to connect QEMU:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -m $RAMSIZE -chardev socket,id=3Dchr0,p=
ath=3D~/passt.socket -netdev vhost-user,id=3Dnetdev0,chardev=3Dchr0 -device=
 virtio-net,netdev=3Dnetdev0 -object memory-backend-memfd,id=3Dmemfd0,share=
=3Don,size=3D$RAMSIZE -numa node,memdev=3Dmemfd0
> +
> +Where ``$RAMSIZE`` is the memory size of your VM ``-m`` and ``-object me=
mory-backend-memfd,size=3D`` must match.
> +
> +Migration of passt:
> +^^^^^^^^^^^^^^^^^^^
> +
> +When passt is connected to QEMU using the vhost-user interface it can
> +be migrated with QEMU and the network connections are not interrupted.
> +
> +As passt runs with no privileges, it relies on passt-repair to save and
> +load the TCP connections state, using the TCP_REPAIR socket option.
> +The passt-repair helper needs to have the CAP_NET_ADMIN capability, or r=
un as root. If passt-repair is not available, TCP connections will not be p=
reserved.
> +
> +Example of migration of a guest on the same host
> +________________________________________________
> +
> +Before being able to run passt-repair, the CAP_NET_ADMIN capability must=
 be set
> +on the file, run as root::
> +
> +   setcap cap_net_admin+eip ./passt-repair
> +
> +Start passt for the source side::
> +
> +   passt --vhost-user --socket ~/passt_src.socket --repair-path ~/passt-=
repair_src.socket
> +
> +Where ``~/passt-repair_src.socket`` is the UNIX socket created by passt =
to
> +communicate with passt-repair. The default value is the ``--socket`` path
> +appended with ``.repair``.
> +
> +Start passt-repair::
> +
> +   passt-repair ~/passt-repair_src.socket
> +
> +Start source side QEMU with a monitor to be able to send the migrate com=
mand:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -monitor std=
io
> +
> +Start passt for the destination side::
> +
> +   passt --vhost-user --socket ~/passt_dst.socket --repair-path ~/passt-=
repair_dst.socket
> +
> +Start passt-repair::
> +
> +   passt-repair ~/passt-repair_dst.socket
> +
> +Start QEMU with the ``-incoming`` parameter:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -incoming tc=
p:localhost:4444
> +
> +Then in the source guest monitor the migration can be started::
> +
> +   (qemu) migrate tcp:localhost:4444
> +
> +A separate passt-repair instance must be started for every migration. In=
 the case of a failed migration, passt-repair also needs to be restarted be=
fore trying
> +again.
> +
>  Hubs
>  ~~~~
> =20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--1T9eMvjKakp/xd0F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmfQ5Z8ACgkQzQJF27ox
2GfpGw//UTBJ3sPqC1XrXMyhTUQbXkJPB/Rro8qa5Z1AdcyYBNin3IrdFkd3W1RJ
XwyCvGI6zHE2Y5dnoHjvMM+OKdWmz1lTcQ08BxWgPnQNruMbNrAFUd1eorW0HCG3
nnIlS6899zsmUUjEXFivaXrPFhaMdGNBoqw+wKPrbGwt+1rjHZcvkmi1vCr3Yrrb
wVNJ17T6i38bBA6vaGnL9egfCnLEuK4ueAe4fxwfvwGyDU1nPxL6ldRKcLbB6bot
LB17dCQmW2txf3gesgb/ZSozVANbaX2LMIufwz+5Uzj2IeOOZaX2FvyWk3E0+9OB
2IwZYs+NoiNi8kaQD29286kMuu9hMctda45/ln/XdLlYqjsTjXs8jTT0dvtuZthS
sugaMcFXPOFSMD6+LF5cP0NMzcNT6dwbJQdSC8ShWt2dS4mYtgc3fqEVBqyWLEJ9
B3HHjMWsEKDQrV3McFIn67i9a/5nPBjVFa4MAA8IPYXaMCn14oRrKxAN4bct0r0j
2m3VIfSYZJyEnWWYDllBGrkrZKyTBiqva6c73c3Xxqzi4KXsDaTnqvmrgecrLkP2
6dQN8zhkHIMywNX1I6aoOgmin6lqusRWS++j2cV4ikUqb4Zs7EJ6BkHoSV9tw78O
9+quq/LsASqSW+KNB7PIXJ0I5BwHtn21mYpkjtBW9O5K0j1o3to=
=RMpj
-----END PGP SIGNATURE-----

--1T9eMvjKakp/xd0F--

