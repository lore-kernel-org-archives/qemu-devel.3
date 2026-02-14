Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD1EF584B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 16:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrIFJ-0000Uq-T1; Sat, 14 Feb 2026 11:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vrIFI-0000Ui-3f
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 11:11:48 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vrIFF-0000Sv-Rz
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 11:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771085502; x=1771690302; i=lukasstraub2@web.de;
 bh=jxwSnm1sPqAlsChGDg4Aim6imVMcu8h+gFJIPta5azE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ltuCdZfY6N9j9NubM2meUuIR6wvsE+nK39WulIFtKKAlbzRNJz3E6/BEaTv0S1Bp
 JmWxCuOxoZ20OijVL03oIvmtxTcgjyBh2f9LoPLu8bRR/OopE9Wv6PZeYZsUes4GD
 SwwhBEmTFVVqsn/7Q+BDkqhoTDjG0NqYfMy9z/hnqEzc7Zl+aFbbHON1aN26lqQNX
 wpov6FRjj3DyvRDcswfNkasiDqlXV0jxtw0LLwvu6RfjvFe5IaSTsHEOP4DpePFf4
 id+0/B4FD6FbBWv7FTc/12c8LRaHfN664cesE2A5HkubWQqF4TVKHoOFkP/I68pOD
 aFkU4WlFmJcYqFPUBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.107.31]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1vptKQ3VBD-00A962; Sat, 14
 Feb 2026 17:11:41 +0100
Date: Sat, 14 Feb 2026 17:11:29 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Li
 Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, stefanha@redhat.com
Subject: Re: COLO concurrency issues
Message-ID: <20260214171129.29b35bd9@penguin>
In-Reply-To: <87ms1cn8n6.fsf@suse.de>
References: <87ms1cn8n6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f4iOBFQbbqd4DuEk=f_bz=+";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KuPoXqx4FSSNYsJPmfYIFSACtcPh1+0zmZuVb3rFyFJklsWIMGn
 vCjssoM7KNTDcH1FB9rE5FZsqSV84PKL6SzhGhr+SLkUEvPq+ck0ywKHx4m4O9AvloAlt8a
 WT6Sagi4a083GslpGCqKYIDnGjTWPpFqr0Qf6utBGGf33oEiY1E8uphkD3tqOm8e1dHM4YD
 mgK7HVz3zXGCsFUN3qI/Q==
UI-OutboundReport: notjunk:1;M01:P0:48FwdLGHDaQ=;t8v5UQpbMKyCwCJe2UBVMrQC5Jx
 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
 +aXuphHFQevEDZ92kBDgPhAmQkoqn
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/f4iOBFQbbqd4DuEk=f_bz=+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2026 09:13:49 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Hi, I've been following the qemu-colo.rst steps to test COLO and
> encountered a couple of issues. Unfortunately, I don't have cycles to
> investigate further. Happens with QEMU master (also tested some versions
> back until the COLO fix 0b5bf4ea76).
>=20
> 1) Deadlock at fdmon_io_uring_wait:
>=20
> (steps from qemu-colo.rst)
> - Secondary Failover
> - Secondary resume replication
> - Start the new Secondary
> - Sync
> - Wait until disk is synced, then:
>=20
>     {"execute": "stop"}
>     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
>=20
> The above results in the old secondary hanging indefinitely at:
>=20
>     do {
>         ret =3D io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
>     } while (ret =3D=3D -EINTR);

I tried and I can not reproduce this at all with my patchset on top of
0b91040d23dc8820724a60c811223b777f3bc6b7

How often does this happen for you?

The only colo-specific culprint at this step could be the replication
block driver. It feels like this should be reproducible without colo,
can you try the following:

1. start secondary

./build/qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -sm=
p 1 -qmp stdio    -device piix3-usb-uhci -device usb-tablet -name secondary=
    -netdev user,id=3Dhn0    -device rtl8139,id=3De0,netdev=3Dhn0 -drive if=
=3Dide,id=3Dparent0,file.filename=3D$imagefolder/primary.qcow2,driver=3Dqco=
w2 -incoming tcp:0.0.0.0:9998

2. qmp commands on secondary

{"execute":"qmp_capabilities"}
{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"c=
apability": "x-colo", "state": true } ] } }
{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "dat=
a": {"host": "0.0.0.0", "port": "9999"} } } }
{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable"=
: true } }

3. start primary

./build/qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -sm=
p 1 -qmp stdio    -device piix3-usb-uhci -device usb-tablet -name secondary=
    -netdev user,id=3Dhn0    -device rtl8139,id=3De0,netdev=3Dhn0 -drive if=
=3Dide,id=3Dparent0,file.filename=3D$imagefolder/primary.qcow2,driver=3Dqco=
w2

4. qmp commands on primary
{"execute":"qmp_capabilities"}
{"execute": "drive-mirror", "arguments":{ "device": "parent0", "job-id": "r=
esync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existing", "form=
at": "raw", "sync": "full"} }

5. wait for resync, then on primary
{"execute": "stop"}
{"execute": "block-job-cancel", "arguments":{ "device": "resync" } }

>=20
> (gdb) bt                                                                 =
                                                                           =
                         =20
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x00007f5519e0204e in ??? () at //usr/lib64/liburing.so.2
> #2  0x00007f5519e01b00 in ??? () at //usr/lib64/liburing.so.2
> #3  0x0000563c2dc06cc9 in fdmon_io_uring_wait (ctx=3D0x563c30411b00, read=
y_list=3D0x7ffd0bad8f58, timeout=3D575708467831) at ../util/fdmon-io_uring.=
c:416
> #4  0x0000563c2dc00976 in aio_poll (ctx=3D0x563c30411b00, blocking=3Dtrue=
) at ../util/aio-posix.c:699
> #5  0x0000563c2daa01c6 in bdrv_drain_all_begin () at ../block/io.c:529
> #6  0x0000563c2daa03d8 in bdrv_drain_all () at ../block/io.c:574
> #7  0x0000563c2d764aae in do_vm_stop (state=3DRUN_STATE_PAUSED, send_stop=
=3Dtrue) at ../system/cpus.c:312
> #8  0x0000563c2d765964 in vm_stop (state=3DRUN_STATE_PAUSED) at ../system=
/cpus.c:754
> #9  0x0000563c2d7f3378 in qmp_stop (errp=3D0x7ffd0bad9080) at ../monitor/=
qmp-cmds.c:62
> #10 0x0000563c2dba7a72 in qmp_marshal_stop (args=3D0x563c306ac070, ret=3D=
0x7f5518dffda8, errp=3D0x7f5518dffda0) at qapi/qapi-commands-misc.c:197
> #11 0x0000563c2dbf1316 in do_qmp_dispatch_bh (opaque=3D0x7f5518dffe40) at=
 ../qapi/qmp-dispatch.c:128
> #12 0x0000563c2dc1de48 in aio_bh_call (bh=3D0x563c3040fef0) at ../util/as=
ync.c:173
> #13 0x0000563c2dc1df64 in aio_bh_poll (ctx=3D0x563c3040c070) at ../util/a=
sync.c:220
> #14 0x0000563c2dbffff0 in aio_dispatch (ctx=3D0x563c3040c070) at ../util/=
aio-posix.c:389
> #15 0x0000563c2dc1e3cd in aio_ctx_dispatch (source=3D0x563c3040c070, call=
back=3D0x0, user_data=3D0x0) at ../util/async.c:365
> #16 0x00007f551b114f4c in g_main_dispatch (context=3D0x563c304120f0) at .=
./glib/gmain.c:3476
> #17 g_main_context_dispatch_unlocked (context=3Dcontext@entry=3D0x563c304=
120f0) at ../glib/gmain.c:4284
> #18 0x00007f551b1170c9 in g_main_context_dispatch (context=3D0x563c304120=
f0) at ../glib/gmain.c:4272
> #19 0x0000563c2dc1fa0b in glib_pollfds_poll () at ../util/main-loop.c:290
> #20 0x0000563c2dc1fa85 in os_host_main_loop_wait (timeout=3D0) at ../util=
/main-loop.c:313
> #21 0x0000563c2dc1fb8a in main_loop_wait (nonblocking=3D0) at ../util/mai=
n-loop.c:592
> #22 0x0000563c2d78eb60 in qemu_main_loop () at ../system/runstate.c:903
> #23 0x0000563c2db412fc in qemu_default_main (opaque=3D0x0) at ../system/m=
ain.c:50
> #24 0x0000563c2db413ab in main (argc=3D40, argv=3D0x7ffd0bad94d8) at ../s=
ystem/main.c:93
>=20
> ---
>=20
> 2) Race at colo_process_checkpoint
>=20
> The following pattern seems to be inherently racy, whether the switch
> statement sees the state as COMPLETED or not varies:
>=20
> colo_process_checkpoint()
> {
>     ...
> out:
>     ...
>     /*
>      * There are only two reasons we can get here, some error happened
>      * or the user triggered failover.
>      */
> --> switch (failover_get_state()) { =20
>     case FAILOVER_STATUS_COMPLETED:
>         qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                   COLO_EXIT_REASON_REQUEST);
>         break;
>     default:
>         qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                   COLO_EXIT_REASON_ERROR);
>     }
>=20
>     /* Hope this not to be too long to wait here */
> --> qemu_event_wait(&s->colo_exit_event); =20
>     ...
> }
>=20
> This results in what seems like a spurious:
>=20
> {"timestamp": {"seconds": 1770984655, "microseconds": 216464}, "event":
> "COLO_EXIT", "data": {"mode": "primary", "reason": "error"}}
>=20
> I'm not sure if the intention is to just ignore it, but it seems moving
> the qemu_event_wait before checking the state would eliminate the race.
>=20

The issue is, if the connection breaks without triggering failover we
want to be notified of that.

I want to rework this anyway, I think I can simplify failover and remove
colo-failover.c.

--Sig_/f4iOBFQbbqd4DuEk=f_bz=+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmQnrEACgkQNasLKJxd
slie3g//XeeiR3ypz94xNYp1B0L/FC28Xy2rcOsXoLSWK5xCASKyo4O+3nHOYK5r
YyAtlXYoroBaWzXOihTsyLnAAzgjFkMv0JQpKLgd55HMPnn5iklJJRCibn40MxI3
lHQR1Ba7TlWi8nmpMRTE91HmEG1QFcpwn5OeUySO25qDBhxDjnjo3Q9Zyv2GlDoz
iKl26Tvy9eLRM4LwHVW5eyPTVK1pW6oi8Qz5fu9TJLfD9Q8Jd1W/vXQNkmXqYglN
UJB3gjpTwvM47Ou4v1wEh7Z3ZtUHBAY8ve/zxgRti5/eumYpYJ5+LXApHxCGLiNf
air9vsczhcO5xXlKuTSTO7nrWqmgL/3DSH7wlmVDnAPg9MF5iey5PfXeROGMtxWF
+ZsgzhE6z2B5ljQ55ocZzKfn2O+xfOxIh35YRh5bJNHjAjIfmIG37z6Tdos+TQlf
KwxoYgEVjZdnK1T65aQYXkwhWC63l9qAhALPpxhHWx53UQrEOIY7UsoJBHG8lSgp
szVi0uuBAGrl7LqKAfjv5LSf15FvTH2RqRHCV/2ZbTfHnoYxAhEnNxPdWs8s27qr
pGqk3It0EDAuD5dLEIaq8ddtwmxu5MNnuvoxkCdKUGMaovfQFJslRh+CMBIOIcCh
ZJTiaogd/R3crxs+Vqfn1SEvxnotDkK1Xii6o3dwE1nWxsZ55oE=
=Quu/
-----END PGP SIGNATURE-----

--Sig_/f4iOBFQbbqd4DuEk=f_bz=+--

