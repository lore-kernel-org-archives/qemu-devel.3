Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB20DE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWTO-0004we-12; Wed, 08 Jan 2025 08:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVWTL-0004wP-WA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:51:48 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tVWTI-0003yG-Q6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Fhv5NLrmYVajvmxZ7Ygdnea4erncPcUwOiQSowS7pMs=; b=jSt5d1Y3ilOFwxlCcTfPdhdD4c
 HItKPmRJyoC8wdpHMEEvfgGVVU6slfAMaQHeAmzqV6sKWZz+gUcbM3H0fkudFP2rtanJvCrNUS73p
 oa9Rf4ddcRCfGZbryyMTLFry/01KPhoNABynjIGZdzw2Aam9YE8qjEZ+gefFd/BBiDa/g8+oeTSdH
 mm2c26NmmbtbiPzNfSJkPwKX77s+C8nOYhth2aiAm8BCiWxHtoYt1zFfIc3LN3HidxWji0WPU1yDV
 p+AO2Bx9NwtXuV9IgyzpRidUyB2ljFuzCft19t2/XtZecXQKPDcmgyq7ZbNE7pMyUkuN3ocv8WYeR
 MF4ZTSlA==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238]
 helo=u09cd745991455d.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tVWTF-00000000I0t-1dT2; Wed, 08 Jan 2025 13:51:41 +0000
Message-ID: <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
Subject: Re: [PULL 23/29] ui & main loop: Redesign of system-specific main
 thread event handling
From: David Woodhouse <dwmw2@infradead.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Akihiko Odaki
 <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 13:51:40 +0000
In-Reply-To: <20241231202228.28819-24-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-24-philmd@linaro.org>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-gbMJlvFmZByACS+Z6mdt"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+b94846bdbc75b454f255+7808+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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


--=-gbMJlvFmZByACS+Z6mdt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-31 at 21:22 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> This change tidies up main thread management to be more flexible.
>=20
> =C2=A0* The qemu_main global function pointer is a custom function for th=
e
> =C2=A0=C2=A0 main thread, and it may now be NULL. When it is, the main th=
read
> =C2=A0=C2=A0 runs the main Qemu loop. This represents the traditional set=
up.
> =C2=A0* When non-null, spawning the main Qemu event loop on a separate
> =C2=A0=C2=A0 thread is now done centrally rather than inside the Cocoa UI=
 code.
> =C2=A0* For most platforms, qemu_main is indeed NULL by default, but on
> =C2=A0=C2=A0 Darwin, it defaults to a function that runs the CFRunLoop.
> =C2=A0* The Cocoa UI sets qemu_main to a function which runs the
> =C2=A0=C2=A0 NSApplication event handling runloop, as is usual for a Coco=
a app.
> =C2=A0* The SDL UI overrides the qemu_main function to NULL, thus
> =C2=A0=C2=A0 specifying that Qemu's main loop must run on the main
> =C2=A0=C2=A0 thread.
> =C2=A0* The GTK UI also overrides the qemu_main function to NULL.
> =C2=A0* For other UIs, or in the absence of UIs, the platform's default
> =C2=A0=C2=A0 behaviour is followed.

When exiting an emulated Xen guest with <Ctrl-a x> on the console, I
now see:

(gdb) run
Starting program: /home/dwmw2/git/qemu/ball/qemu-system-x86_64 -display non=
e -vga none -serial mon:stdio -machine q35 -accel kvm,xen-version=3D0x4000a=
,kernel-irqchip=3Dsplit -smp 2 -kernel /home/dwmw2/avocado/data/cache/by_na=
me/bzImage -append printk.time=3D0\ root=3D/dev/xvda\ console=3DttyS0\ xen_=
emul_unplug=3Dide-disks\ xen_no_vector_callback\ noapic\ loglevel=3D0 -driv=
e file=3D/home/dwmw2/avocado/data/cache/by_name/rootfs.ext4,if=3Dnone,snaps=
hot=3Don,format=3Draw,id=3Ddrv0 -device xen-disk,drive=3Ddrv0,vdev=3Dxvda -=
device virtio-net-pci,netdev=3Dunet -netdev user,id=3Dunet,hostfwd=3D:127.0=
.0.1:0-:22

Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving 256 bits of non-creditable seed for next boot
Starting network: OK
Starting dhcpcd...
no such user dhcpcd
dhcpcd-9.4.1 starting
no interfaces have a carrier
forked to background, child pid 111
Starting dropbear sshd: OK
#=20
QEMU: Terminated
qemu-system-x86_64: ../block/block-backend.c:1290: blk_in_drain: Assertion =
`qemu_in_main_thread()' failed.

Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
0x00007ffff5ffc724 in __pthread_kill_implementation () from /lib64/libc.so.=
6
(gdb) bt
#0  0x00007ffff5ffc724 in __pthread_kill_implementation () at /lib64/libc.s=
o.6
#1  0x00007ffff5fa3d1e in raise () at /lib64/libc.so.6
#2  0x00007ffff5f8b942 in abort () at /lib64/libc.so.6
#3  0x00007ffff5f8b85e in __assert_fail_base.cold () at /lib64/libc.so.6
#4  0x00007ffff5f9be47 in __assert_fail () at /lib64/libc.so.6
#5  0x0000555555abf911 in blk_in_drain (blk=3D0x555557ca6680)
    at ../block/block-backend.c:1290
#6  0x000055555593410c in xen_block_dataplane_stop (dataplane=3D0x555558982=
950)
    at ../hw/block/dataplane/xen-block.c:695
#7  0x000055555593441a in xen_block_dataplane_stop (dataplane=3D<optimized =
out>)
    at ../hw/block/dataplane/xen-block.c:689
#8  0x00005555555dfd5e in xen_block_disconnect
    (xendev=3Dxendev@entry=3D0x55555880aa60, errp=3D<optimized out>)
    at ../hw/block/xen-block.c:172
#9  0x00005555555dfeca in xen_block_unrealize (xendev=3D0x55555880aa60)
    at ../hw/block/xen-block.c:282
#10 0x000055555578ef71 in xen_device_unrealize (dev=3D<optimized out>)
    at ../hw/xen/xen-bus.c:978
#11 0x0000555555bfe65f in notifier_list_notify (list=3D<optimized out>, dat=
a=3D0x0)
    at ../util/notify.c:39
#12 0x00007ffff5fa6461 in __run_exit_handlers () at /lib64/libc.so.6
#13 0x00007ffff5fa652e in exit () at /lib64/libc.so.6
#14 0x0000555555b523dc in qemu_default_main (opaque=3Dopaque@entry=3D0x0)
#15 0x00005555555609c0 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at ../system/main.c:76


--=-gbMJlvFmZByACS+Z6mdt
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEwODEzNTE0
MFowLwYJKoZIhvcNAQkEMSIEIPvJgkKWcRb2DpDFA+9aU5gg+7ZupghDhDqFJkCR/4+fMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAV1s1NP5MRVS0
FawRhEz5qOtZo/RXjnHEHS0sixMzGR/M+wn4kFNrGPfMC4YZGe7qRFX4mf8gJvq++M5oNOyRxxxf
45nDCv2YAXLwvGhImOc6ghnbVmISZYVIYahg5f4VIG67PJpJDb+/RaSMYZLJjIlbJWNExxp6ME0o
/z33BWpqaSDNUPDTpbseQZHg2ZCRMgNuEhaO6bOWc0C+kFAW81kSVh1UCbqY73IJto5Nmmfc0B4o
0OTgrLpUvwlw93SQXoGouJxtQ6OpGFbfalrqeXfysJ0Ae0F1yCIZWNUYEzC7s2Y/wdmxRMKNfYcc
ioRE7Y2LhERYnuz9IA2tiWL5gYBbUHDBn6/T4N9JDRsPl0McHXAQ4NgO+1Klxpegpkg6EMW2agot
YE2Frr3c7HljQWPgYa/or3lYNR3qxOEIgrv2HRn8xN64daUzyeRUdakySiJ9lrqhBOa3oWgb2YXZ
M2zj82GTcMQBCtVKgLDdI+XcWfin6p6ikJZ2rXFnm28dbYpqwlWp2H6zlrJjXCr7TjbAS2Yi5Op5
IQM0Un3jKt0vTiTy8esjHQl9qliThNZmcdFwjlFOM+fOScd6uP2XOxuCFTL2zUFyqFEmHmZeM1PI
gdAdgSiFcMKH6AD9VQROc0RhYGqzeKwD8tSlJ7l4jD0Pij7VlRwxUAFpF7zCFxAAAAAAAAA=


--=-gbMJlvFmZByACS+Z6mdt--

