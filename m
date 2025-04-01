Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45AC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaIt-0002wb-32; Tue, 01 Apr 2025 08:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+bb0b217e6e9234f3bed2+7891+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tzaIV-0002u6-BO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:00:54 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+bb0b217e6e9234f3bed2+7891+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tzaIL-0006I3-H8
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DXaPS2BBwzmh20GmCAon9PzhHrCpt4/kEDpy2lCTnq4=; b=JjIlFlSRKENRJdj2TBBLRIQfxP
 OOHRY3R1iz+KARr+vBsqVxL1/1/7U9vucL7ua3BQ/WZeI6uSAfKleTzgkErVisQhEVhCyAq5QAXuX
 NCfrNwvh953JMxLM4Ztp16kh5hpipAdA/LBk8rCZz6gcJBtae2vD2cpwfxe+ZX9bfhOS47qQoJM5F
 T7C9rqV9HBbb/GWkd9dEfqI8LUWluD5rLWBglUyKmsgoAkl2cG3Ct+5QJF0npDoaXbX04ElCcFpGg
 61xA8kAv9NPCkHruI7gwOW6f3zh1Fjk76pD8leH7OakvtDSgNLjICvtk7hlsU2Fcarb80ynAkqL3A
 oYxGffWg==;
Received: from [172.31.31.145] (helo=u09cd745991455d.lumleys.internal)
 by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
 id 1tzaIG-00000006oNW-1hpk; Tue, 01 Apr 2025 12:00:36 +0000
Message-ID: <676b2700e47058b2221d4bc821ad0cde0433e7b9.camel@infradead.org>
Subject: Re: [PULL 23/29] ui & main loop: Redesign of system-specific main
 thread event handling
From: David Woodhouse <dwmw2@infradead.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Akihiko Odaki
 <akihiko.odaki@daynix.com>
Date: Tue, 01 Apr 2025 13:00:36 +0100
In-Reply-To: <9ae8882b-35d1-489a-9f5c-579bd9ae89df@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-24-philmd@linaro.org>
 <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
 <3e8e7649-2ee3-4e72-9cd6-17db0551ea66@linaro.org>
 <24a30054-eef8-4ce0-971d-0b50d28154f1@linaro.org>
 <aedc72a0e5dabe190427dd536b2882f0ca8713c4.camel@infradead.org>
 <9ae8882b-35d1-489a-9f5c-579bd9ae89df@linaro.org>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-hAi3CBKs1C6URhPRo9O2"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+bb0b217e6e9234f3bed2+7891+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--=-hAi3CBKs1C6URhPRo9O2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-04-01 at 13:58 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/4/25 13:43, David Woodhouse wrote:
> > On Tue, 2025-04-01 at 13:30 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 1/4/25 13:18, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > Hi David,
> > > >=20
> > > > On 8/1/25 14:51, David Woodhouse wrote:
> > > > > On Tue, 2024-12-31 at 21:22 +0100, Philippe Mathieu-Daud=C3=A9
> > > > > wrote:
> > > > > >=20
> > > > > > This change tidies up main thread management to be more
> > > > > > flexible.
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0* The qemu_main global function pointer is a =
custom
> > > > > > function
> > > > > > for the
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 main thread, and it may now be NULL. W=
hen it is, the
> > > > > > main
> > > > > > thread
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 runs the main Qemu loop. This represen=
ts the
> > > > > > traditional
> > > > > > setup.
> > > > > > =C2=A0=C2=A0=C2=A0* When non-null, spawning the main Qemu event=
 loop on a
> > > > > > separate
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 thread is now done centrally rather th=
an inside the
> > > > > > Cocoa
> > > > > > UI code.
> > > > > > =C2=A0=C2=A0=C2=A0* For most platforms, qemu_main is indeed NUL=
L by
> > > > > > default,
> > > > > > but on
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 Darwin, it defaults to a function that=
 runs the
> > > > > > CFRunLoop.
> > > > > > =C2=A0=C2=A0=C2=A0* The Cocoa UI sets qemu_main to a function w=
hich runs
> > > > > > the
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 NSApplication event handling runloop, =
as is usual for
> > > > > > a
> > > > > > Cocoa app.
> > > > > > =C2=A0=C2=A0=C2=A0* The SDL UI overrides the qemu_main function=
 to NULL,
> > > > > > thus
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 specifying that Qemu's main loop must =
run on the main
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 thread.
> > > > > > =C2=A0=C2=A0=C2=A0* The GTK UI also overrides the qemu_main fun=
ction to
> > > > > > NULL.
> > > > > > =C2=A0=C2=A0=C2=A0* For other UIs, or in the absence of UIs, th=
e
> > > > > > platform's
> > > > > > default
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 behaviour is followed.
> > > > >=20
> > > > > When exiting an emulated Xen guest with <Ctrl-a x> on the
> > > > > console, I
> > > > > now see:
> > > > >=20
> > > > > (gdb) run
> > > > > Starting program: /home/dwmw2/git/qemu/ball/qemu-system-
> > > > > x86_64 -
> > > > > display none -vga none -serial mon:stdio -machine q35 -accel
> > > > > kvm,xen-
> > > > > version=3D0x4000a,kernel-irqchip=3Dsplit -smp 2 -kernel
> > > > > /home/dwmw2/
> > > > > avocado/data/cache/by_name/bzImage -append printk.time=3D0\
> > > > > root=3D/dev/
> > > > > xvda\ console=3DttyS0\ xen_emul_unplug=3Dide-disks\
> > > > > xen_no_vector_callback\ noapic\ loglevel=3D0 -drive
> > > > > file=3D/home/dwmw2/
> > > > > avocado/data/cache/by_name/
> > > > > rootfs.ext4,if=3Dnone,snapshot=3Don,format=3Draw,id=3Ddrv0 -devic=
e
> > > > > xen-
> > > > > disk,drive=3Ddrv0,vdev=3Dxvda -device virtio-net-pci,netdev=3Dune=
t
> > > > > -
> > > > > netdev
> > > > > user,id=3Dunet,hostfwd=3D:127.0.0.1:0-:22
> > > > >=20
> > > > > Starting syslogd: OK
> > > > > Starting klogd: OK
> > > > > Running sysctl: OK
> > > > > Saving 256 bits of non-creditable seed for next boot
> > > > > Starting network: OK
> > > > > Starting dhcpcd...
> > > > > no such user dhcpcd
> > > > > dhcpcd-9.4.1 starting
> > > > > no interfaces have a carrier
> > > > > forked to background, child pid 111
> > > > > Starting dropbear sshd: OK
> > > > > #
> > > > > QEMU: Terminated
> > > > > qemu-system-x86_64: ../block/block-backend.c:1290:
> > > > > blk_in_drain:
> > > > > Assertion `qemu_in_main_thread()' failed.
> > > > >=20
> > > > > Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
> > > > > 0x00007ffff5ffc724 in __pthread_kill_implementation () from
> > > > > /lib64/
> > > > > libc.so.6
> > > > > (gdb) bt
> > > > > #0=C2=A0 0x00007ffff5ffc724 in __pthread_kill_implementation () a=
t
> > > > > /lib64/
> > > > > libc.so.6
> > > > > #1=C2=A0 0x00007ffff5fa3d1e in raise () at /lib64/libc.so.6
> > > > > #2=C2=A0 0x00007ffff5f8b942 in abort () at /lib64/libc.so.6
> > > > > #3=C2=A0 0x00007ffff5f8b85e in __assert_fail_base.cold () at
> > > > > /lib64/libc.so.6
> > > > > #4=C2=A0 0x00007ffff5f9be47 in __assert_fail () at
> > > > > /lib64/libc.so.6
> > > > > #5=C2=A0 0x0000555555abf911 in blk_in_drain (blk=3D0x555557ca6680=
)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../block/block-backend.c:1290
> > > > > #6=C2=A0 0x000055555593410c in xen_block_dataplane_stop
> > > > > (dataplane=3D0x555558982950)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../hw/block/dataplane/xen-block=
.c:695
> > > > > #7=C2=A0 0x000055555593441a in xen_block_dataplane_stop
> > > > > (dataplane=3D<optimized out>)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../hw/block/dataplane/xen-block=
.c:689
> > > > > #8=C2=A0 0x00005555555dfd5e in xen_block_disconnect
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (xendev=3Dxendev@entry=3D0x5555588=
0aa60, errp=3D<optimized
> > > > > out>)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../hw/block/xen-block.c:172
> > > > > #9=C2=A0 0x00005555555dfeca in xen_block_unrealize
> > > > > (xendev=3D0x55555880aa60)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../hw/block/xen-block.c:282
> > > > > #10 0x000055555578ef71 in xen_device_unrealize
> > > > > (dev=3D<optimized
> > > > > out>)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../hw/xen/xen-bus.c:978
> > > > > #11 0x0000555555bfe65f in notifier_list_notify
> > > > > (list=3D<optimized
> > > > > out>,
> > > > > data=3D0x0)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at ../util/notify.c:39
> > > > > #12 0x00007ffff5fa6461 in __run_exit_handlers () at
> > > > > /lib64/libc.so.6
> > > > > #13 0x00007ffff5fa652e in exit () at /lib64/libc.so.6
> > > > > #14 0x0000555555b523dc in qemu_default_main
> > > > > (opaque=3Dopaque@entry=3D0x0)
> > > > > #15 0x00005555555609c0 in main (argc=3D<optimized out>,
> > > > > argv=3D<optimized
> > > > > out>) at ../system/main.c:76
> > > > >=20
> > > >=20
> > > > Is this still an issue?
> > >=20
> > > Likely fixed by commit e7bc0204 ("system/runstate:
> > > Fix regression, clarify BQL status of exit notifiers"), so
> > > I'm closing https://gitlab.com/qemu-project/qemu/-/issues/2771.
> >=20
> > Indeed. I think I was assuming the explicit Resolves: tag in that
> > commit was going to magically close the issue when it was merged.
> > Should I have closed it manually?
>=20
> It should have been closed automatically. Maybe some transient
> problem on GitLab side =C2=AF\_(=E3=83=84)_/=C2=AF

Ack. Thanks for confirming.


--=-hAi3CBKs1C6URhPRo9O2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwMTEyMDAz
NlowLwYJKoZIhvcNAQkEMSIEIPyrnw16L6dSecefxy+lDO5XjCg3WHfBkogoWAqEZaMQMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAyk1iddBfq6fF
We/rqGUFTAcDiNvBuvWJOgEFiPj3sEFx53ig+h2QR5M98YIS9AlX1HirFtQ+uBAvVLSJ5x1Agkdh
WjbiQo31HtobBOkKnhv50StSoksXtQt0ZKU5CnwfjRYum4crlv+k0uz4ZcMG77WV0xCHfSsjb7wR
9OfJan8DZo/9u93tWGxo4gxoR44wZH7SFBAUargYeJ6+dEAl4QdYGz3MMqq7CwL2+U/krOZ6eiuZ
1Y676xl0rju1KXnfQF9YgY90FigqSRO6L7vkHOMNQymMJeL15go2byTfx5s+79+dFM8SzXZgePfM
6M4V1EdrJJyRfZwYXZL3f4dvjwI3qf2CGm9N7a38GT8IXL+fhAjWcCypt525mzRy95E3dfSXkd+z
+W4/urNf4TX26yyvgqtgltUJ2kdnweU0HuqlrNLZZHpL5qVnsvD9GGIAXnOHOdp3ID8BLwAU7sYe
7MnjbHnejuNcmFbMrI0CcEYbvHigR4RbvWsZ9KqAW9m8vLcejbBbH0tQftzbgNVemklBdfuquefE
Iy9Jr+jDhxGlG+oiB62gP0YGN0q4Ckthpbr8DbvSYuhfuEzhV31GPLFrYwcrgYb7jAy0PF4BZd8J
GF3NswERA+0onTSwgMDpmOztnrExLwocLfBaoR+ozqb0wyVRm8XCwp+BsSuA0asAAAAAAAA=


--=-hAi3CBKs1C6URhPRo9O2--

