Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6A0C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 01:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trol1-0007dv-8b; Mon, 10 Mar 2025 21:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1trokx-0007cx-6N
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 21:50:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1trokt-0001yR-Ev
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 21:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202502; t=1741657789;
 bh=x19C2xxcbB6IvbVC37z5ty7q8+SB3EVJkp1kTGRNApk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e993JwD9sJ6UBMKoaTk2rBxXSG1A0oM7AgaqNC7lhOimW4MN41oK23oSSYL9UfREb
 ArHPzFCTmKZwVof3QVvQChLjJudUkeBjd6E0nq8Xpxdq2R2eyLFpoyT6uHo2LuT5o0
 lQEGv/MCpOcAxerSopYgDmb6oDZiiUgti7CcW1aA4AJ1aXSD5/FDT3PSaCbnYa7DvG
 OSJATnRzUU4yIPeZ9d+fm2Qq5cT2pClIGpVsSI9LHbUxyCqDZJsLDgdaE1j8rEk8tp
 UPM4ap33cwmfXgOIf/sd6hCXKV3JyY3hrEZB5vMZpAkWmal2v/+SZksBva/FvnSaGB
 1Q74qYrgSRFKQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4ZBcC15LCtz4x8h; Tue, 11 Mar 2025 12:49:49 +1100 (AEDT)
Date: Tue, 11 Mar 2025 12:49:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH] docs: Explain how to use passt
Message-ID: <Z8-WuAhqfHACwPTS@zatzit>
References: <20250310180050.112682-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dnvquyuhoalownJb"
Content-Disposition: inline
In-Reply-To: <20250310180050.112682-1-lvivier@redhat.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 PDS_OTHER_BAD_TLD=0.47, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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


--dnvquyuhoalownJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 07:00:50PM +0100, Laurent Vivier wrote:
> Add a chapter to explain how to use passt(1) instead of '-net user'.
> passt(1) can be connected to QEMU using UNIX socket or vhost-user.
> With vhost-user, migration of the VM is allowed and internal state of
> passt(1) is transfered from one side to the other
>=20
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  docs/system/devices/net.rst | 93 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>=20
> diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
> index 2ab516d4b097..5f70b1039198 100644
> --- a/docs/system/devices/net.rst
> +++ b/docs/system/devices/net.rst
> @@ -77,6 +77,99 @@ When using the ``'-netdev user,hostfwd=3D...'`` option=
, TCP or UDP
>  connections can be redirected from the host to the guest. It allows for
>  example to redirect X11, telnet or SSH connections.
> =20
> +Using passt as the user mode network stack
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +`passt(1)`_ can be used as a simple replacement for SLIRP (``-net user``=
).
> +`passt(1)`_ doesn't require any capability or privilege. `passt(1)`_ has
> +better performance than ``-net user``, full IPv6 support and better secu=
rity
> +as it's a daemon that is not executed in QEMU context.
> +
> +`passt(1)`_ can be connected to QEMU either by using a socket
> +(``-netdev stream``) or using the vhost-user interface (``-netdev vhost-=
user``).
> +See `passt web site`_ and `passt(1)`_ for more details on passt.
> +
> +.. _passt web site: https://passt.top/
> +.. _passt(1): https://passt.top/builds/latest/web/passt.1.html
> +
> +To use socket based passt interface:
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Start `passt(1)`_ as a daemon::
> +
> +   passt
> +
> +It will print the path of the UNIX domain socket QEMU can connect to.
> +Then you can connect your QEMU instance to `passt(1)`_:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -device virtio-net-pci,netdev=3Dnetdev0=
 -netdev stream,id=3Dnetdev0,server=3Doff,addr.type=3Dunix,addr.path=3D/tmp=
/passt_1.socket
> +
> +Where ``/tmp/passt_1.socket`` is the UNIX socket created by `passt(1)`_ =
to
> +communicate with QEMU.

Using the default socket path in /tmp makes me slightly nervous in
terms of other users managing to intercept the network somehow - or
simply in terms of getting different passt instances confused by
accident.  I therefore wonder if it might be better to suggest
explicitly choosing the socket path on both sides.


> +To use vhost-based interface:
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Start passt with ``--vhost-user``::
> +
> +   passt --vhost-user
> +
> +Then to connect QEMU:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] -m $RAMSIZE -chardev socket,id=3Dchr0,p=
ath=3D/tmp/passt_1.socket -netdev vhost-user,id=3Dnetdev0,chardev=3Dchr0 -d=
evice virtio-net,netdev=3Dnetdev0 -object memory-backend-memfd,id=3Dmemfd0,=
share=3Don,size=3D$RAMSIZE -numa node,memdev=3Dmemfd0
> +
> +Where ``$RAMSIZE`` is the memory size of your VM ``-m`` and ``-object me=
mory-backend-memfd,size=3D`` must match.

Same consideration with the path here.

> +Migration of passt:
> +^^^^^^^^^^^^^^^^^^^
> +
> +When `passt(1)`_ is connected to QEMU using the vhost-user interface it =
can
> +be migrated with QEMU and the network connections are not interrupted.
> +
> +As `passt(1)`_ runs with no privileges, it relies on passt-repair to sav=
e and
> +load TCP connections state, using the TCP_REPAIR socket option.
> +The passt-repair helper needs to have the CAP_NET_ADMIN capability, or r=
un as root. If passt-repair is not available, TCP connections will not be p=
reserved.

I'm slightly nervous about using a socket in /tmp for passt proper.
I'm much more nervous about using a socket in /tmp for passt-repair.

> +Example of migration of a guest on the same host
> +________________________________________________
> +
> +Before being able to run passt-repair, the CAP_NET_ADMIN capability must=
 be set
> +on the file, run as root::
> +
> +   setcat cap_net_admin+eip ./passt-repair
> +
> +Start `passt(1)`_ for the source side::
> +
> +   passt
> +
> +Start passt-repair::
> +
> +   passt-repair /tmp/passt_1.socket.repair
> +
> +Start source side QEMU with a monitor to be able to send the migrate com=
mand:
> +
> +.. parsed-literal::
> +   |qemu_system| [...OPTIONS...] [...VHOST USER OPTIONS...] -monitor std=
io

It might be worth pointing out explicitly that a separate passt-repair
instance must be started for every migration.  In some cases, I think
passt-repair will also need to be restarted in the case of a failed
migration, before trying again.

> +Start `passt(1)`_ for the destination side::
> +
> +   passt
> +
> +Start passt-repair::
> +
> +   passt-repair /tmp/passt_2.socket.repair
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
>  Hubs
>  ~~~~
> =20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--dnvquyuhoalownJb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmfPlrcACgkQzQJF27ox
2GeIzA/8CA2NPmxaev4X1bkrViYRfbaQTqkknbWX7DBXvhAb46OGTHyWAd7YBUSk
ifJiqNLiLrCZvtk0VR1ZMPlPFUjYXwDQroEwbc8IjtGh+BTpIlKxVFx5BjGxp/HB
8/ba+v4q/t0SPI9CBbVFaO2tCUL5OFCo7UwD4NXsAejx/9n1yousQ0ksZJvY/Bk4
HEBA1B6AF6X3wBeCwp2z/ECtKCJWl4bCZEMQ2pP7lmLHe9vCZplm0sCXw5lnniv9
+B8/ei1m1EQVCNjLb2zRRQOE/fol04XqBIYxnPJDUNk0vVl0xc+vhI4M+3ea7Ggv
qCGWVf5/Loh/oRq9uzJUipLcy+XPFJph+hIWiXB6U4r+nStsa0muPrS1URyvWzK3
0HhHQ7wadIpYYNsBpKGV5Uutj130dcZOXRWLW8cm/Xlh54J5x4smyGjSZ1yReoN4
Vpic1CZwJkByEyKj5ACmCK1WYxSUudXdUXVI7BEcW0CyKEAYD5VCRGoQrG+SWQt5
E731jwWIFvtM5iRJrYy7ZB6NxjifkrWDSDYVHhqR5IYGJC0JUG/4A0lFlBJ4HhaU
qZ/oe5mHLcyedsTGI1yGQK0re9OwP6fBN4/EzXRVXBENSnsl3BPCaGAwp+3AQ60y
s/BYXXQ6epleueXrOA3Yvt6ctnPNiKjfvTeJrVa88YI1f93oGbM=
=2WIM
-----END PGP SIGNATURE-----

--dnvquyuhoalownJb--

