Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10101E63CA4
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 19:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk5nr-0001q8-6C; Sun, 25 Jan 2026 14:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk5nq-0001pR-2k
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 14:29:42 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk5no-000417-5n
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 14:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769369367; x=1769974167; i=lukasstraub2@web.de;
 bh=LdVmkfWlIIBBqS+W4w6X/BveT229RuwL+5QGoTNIUkY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=o8zDq0Qpt1d99+mMO1t5g0/YJn+GVXaCgR7Ywm3rsgln59N+HIH1yQ7iGEErSGnX
 voGVfD2KYzdqN7dIov2ugzyBnaPmHYKq4KHw/0/coXSHD3TyzCdLsWzoJbxYMNpF1
 NPbPpK+YjOKFYFUbfkgRzxW5NQ+kkeFl1IiOSNP+IZaYm/rLF2Wdy9JhABpkqlGDo
 fME89k/zizMxtX6PPRq6yjdISh+NqPHCfi7sQNTNMbUUTP5k7XfaY+RAxkTYE9aou
 WZB+0dlsnNv6esJxNn1oG3ZCxbGHxV329HA2XK5TG8SO44Hrr4hnFeb3pE62PN5Xp
 aaXx8j3HHE531TkFIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nii-1vgnTX04w0-007lUh; Sun, 25
 Jan 2026 20:29:27 +0100
Date: Sun, 25 Jan 2026 20:29:15 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/10] migration/colo: small cleanup series
Message-ID: <20260125202915.09bcae76@penguin>
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5RM0WwIAsT0/5+09yfS1SKH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:xhDkRXJkCuA4HRqmh79n5nbIY7MO0JtLZaJfW3+nTUzeOWQ1mRx
 E3o5JaUSpttoAQsUM4YX7ASpIc1N1r6Fn2NxAK+ImLNaNbiwEvsZXlt0mpWbH/E1SMa0u7D
 Y80jjUNAsVzpmolDqGweSkupXBmoqFJ73pbMXsBLDmPjT2lBwg17nHmDQXn8hCHsNZVF8bG
 5yUbZfutDeDc/7AKICEmg==
UI-OutboundReport: notjunk:1;M01:P0:RQTbs7LUJWU=;6atBQVPfLJa9QfgO0ydQBYUVFFN
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/5RM0WwIAsT0/5+09yfS1SKH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jan 2026 17:33:25 -0500
Peter Xu <peterx@redhat.com> wrote:

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2277445319
>=20
> While reading COLO in the past two days, I got a few small patches to cle=
an
> up here and there.  I also ran this with the COLO qtests [*] and it ran a=
ll fine.
>=20
> Comments welcomed, thanks.
>=20
> [*] https://lore.kernel.org/r/20260117-colo_unit_test_multifd-v2-0-ab5217=
77fa51@web.de

Hmm,
It fails for me on top of current master, but works fine wthout this patchs=
et:
# Running /x86_64/migration/colo/plain/primary_failover
# Using machine type: pc-i440fx-11.0
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3157.sock=
 -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3157.qmp,id=3Dchar0=
 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with ex=
it-with-parent=3Don -accel kvm -accel tcg -machine pc-i440fx-11.0, -name so=
urce,debug-threads=3Don -machine memory-backend=3Dmig.mem -object memory-ba=
ckend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial file:/tmp/migration-=
test-OZFSJ3/src_serial -drive if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-=
OZFSJ3/bootsect,format=3Draw -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,he=
ads=3D1 -snapshot  -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3157.sock=
 -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3157.qmp,id=3Dchar0=
 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -run-with ex=
it-with-parent=3Don -accel kvm -accel tcg -machine pc-i440fx-11.0, -name ta=
rget,debug-threads=3Don -machine memory-backend=3Dmig.mem -object memory-ba=
ckend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial file:/tmp/migration-=
test-OZFSJ3/dest_serial -incoming tcp:127.0.0.1:0  -drive if=3Dnone,id=3Dd0=
,file=3D/tmp/migration-test-OZFSJ3/bootsect,format=3Draw -device ide-hd,dri=
ve=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot  -accel qtest
qemu-system-x86_64: error while loading state for instance 0x0 of device '0=
000:00:03.0/e1000': Loading VM subsection 'e1000/full_mac_state' in 'e1000'=
 failed: -5: Failed to load e1000/full_mac_state state: stream error: -5

>=20
> Peter Xu (10):
>   migration: Introduce qemu_savevm_send_* helpers
>   migration: Use qemu_savevm_send_header() in qemu_save_device_state()
>   migration: Remove one migration_in_colo_state() occurance
>   migration/savevm: Remove SaveStateEntry.is_ram
>   migration/colo: Unwrap qemu_savevm_live_state()
>   migration/colo: Remove call to send switchover start event
>   colo: Forbid VM resume during checkpointing
>   migration/colo: Use the RAM iterable helper directly
>   migration/colo: Move qemu_fflush() closer to its user for fb
>   migration: Drop iterable_only in qemu_savevm_state_complete_precopy
>=20
>  migration/savevm.h    |  4 +-
>  migration/colo.c      |  9 ++---
>  migration/migration.c |  2 +-
>  migration/savevm.c    | 91 +++++++++++++++++++++----------------------
>  monitor/qmp-cmds.c    |  3 ++
>  5 files changed, 55 insertions(+), 54 deletions(-)
>=20


--Sig_/5RM0WwIAsT0/5+09yfS1SKH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml2bwsACgkQNasLKJxd
sli/Pw/+MnVmGe8UZEO57QRkjcRvUBk6LRqTy/m3Q7zqQIo0F1dEwxVwx0f3c7kq
eAyfGQ7RoxzD0JztoRWVherCiwz/m7RXJOxisIpgKsOm2FlZcGuqA5n3BguHp4PH
/InPqb6nyVEIKntdGEmbwYhDvOxdAa/6JDs3fFB2q0WFSibiTk61nGANtKmQQr9i
aVBNN3TmPHWUOqWiVg/jQS6zp3xWz6TiHe+jXUEx1mBVYYZJau/uMAonjnrZ5UEj
l4nB8U+JBIZG+O+9UH/ZuTaAXzs1HxrbvHplvFWPr6o55wEu3GrrttMgGgOBdJhR
wywRaPjZZxOgP10co4aYj4R+oXazq+hIORD0qLkXqfV1smTnRJSE3iyguLE/jeMA
IeEIWSUP/dJAIsSZ0Ukdj1no7yP+/EyFDwgPiRn0GwESiTEMJMvIdXjFpG7WHKO0
y8D9chMACK6eV/LtGaGIArnSrOQ2c5e/01wAP1hU6aGfHyIJEfYhJ1zrVnDAR/w6
9lRL5YR9bbdNo40YJ76xRRAHEluFzFdZWouSV2Jr/96ml/zMPYPSatMAB1X6vpR+
X0mxdo0BktHl0N6HoYuWoSFy2VavH0pUByIelSrzYXyZ9yjnAbRoNjzLWmkXe6Rp
7Lj7UBSO21j2TEfYhC3QyXMNQ+FOsPw25mMd9c1Vxft1ILTVWLU=
=73Po
-----END PGP SIGNATURE-----

--Sig_/5RM0WwIAsT0/5+09yfS1SKH--

