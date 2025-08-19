Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F4CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOxk-0007k0-61; Tue, 19 Aug 2025 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ebc60eecb9e2d34fc5cb+8031+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1uoOxh-0007f8-6V
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:13:25 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ebc60eecb9e2d34fc5cb+8031+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1uoOxd-0008KV-S2
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IAH8DQbQ+jNbYhPQRxI3pxazLXRL6ChIfbmHzraSObU=; b=R9qw9EPV1Vl6Tk6YmbVDMwsGlJ
 TOwifrNchztbj0/ZqWx93pyqIBkWXCAr8RJG0ZL/zqpvQJ0GjdxM/JRA67ojV+l03eVWcu1otbMSl
 E0D6rQqkhmBf5yG9IxVYtdvmd3j+tXeklejyIQcJLlZa0A83bQH5ga92Gh3JkRoxQfaIF9ayDPE8C
 1bGUCNpCXdAv8H+ho4VE0PL6uoQI7rkDyzivdxu5QUmNTJO8JAJuiqqPCSFQ9SiEfXnz59HWXwbVl
 ODuIieqnAWHIflw+RUdzZ6N3/BFYfO8lYeKGQ75gpYy9b6aVoBIunO5kbGwCyZcw/yHwsRALccOJH
 Vblob0KA==;
Received: from 54-240-197-232.amazon.com ([54.240.197.232]
 helo=freeip.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1uoOxW-00000008BCs-1Vly; Tue, 19 Aug 2025 16:13:15 +0000
Message-ID: <29e31b2d06036441ede4ccb2d2bd22a6c1ba33ae.camel@infradead.org>
Subject: Re: [PULL 2/5] net: move backend cleanup to NIC cleanup
From: David Woodhouse <dwmw2@infradead.org>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Lei Yang
 <leiyang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>
Date: Tue, 19 Aug 2025 17:13:14 +0100
In-Reply-To: <20250310122240.2908-3-jasowang@redhat.com>
References: <20250310122240.2908-1-jasowang@redhat.com>
 <20250310122240.2908-3-jasowang@redhat.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-cv1BhCTCrtWIlRQxidga"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+ebc60eecb9e2d34fc5cb+8031+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-cv1BhCTCrtWIlRQxidga
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-03-10 at 20:22 +0800, Jason Wang wrote:
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>=20
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend is still visible to the guest.
>=20
> However it does not clean up the resources until the qemu process is
> over.=C2=A0 This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.=C2=A0 This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>=20
> Move the cleanup from qemu_cleanup to the NIC deletion and to
> net_cleanup.
>=20
> Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structu=
res if peer nic is present")
> Reported-by: Lei Yang <leiyang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This crashes QEMU when I launch an emulated Xen guest with a Xen PV
NIC, and quit (using Ctrl-A x on the monitor).

$ gdb --args  ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel=
-irqchip=3Dsplit -serial mon:stdio     -display none  -m 1G  -kernel /boot/=
vmlinuz-6.13.8-200.fc41.x86_64/boot/vmlinuz-6.13.8-200.fc41.x86_64 -append =
"console=3DttyS0"=20
(gdb) handle SIGUSR1 pass nostop noprint
(gdb) run
[    0.000000] Linux version 6.13.8-200.fc41.x86_64 (mockbuild@cdcecfee8b71=
420eb7f55566b7811804) (gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7), GNU ld=
 version 2.43.1-5.fc41) #1 SMP PREEMPT_DYNAMIC Sun Mar 23 05:03:09 UTC 2025=
[    0.000000] Linux version 6.13.8-200.fc41.x86_64 (mockbuild@cdcecfee8b71=
420eb7f55566b7811804) (gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7), GNU ld=
 version 2.43.1-5.fc41) #1 SMP PREEMPT_DYNAMIC Sun Mar 23 05:03:09 UTC 2025
[    0.000000] Command line: console=3DttyS0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feff8000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3=
-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] Hypervisor detected: Xen HVM
=E2=80=A6
<Ctrl-A x>
Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x000055555584821c in net_hub_port_cleanup (nc=3D0x555557ce23d0) at ../net/=
hub.c:132
132	    QLIST_REMOVE(port, next);
(gdb) bt
#0  0x000055555584821c in net_hub_port_cleanup (nc=3D0x555557ce23d0) at ../=
net/hub.c:132
#1  0x000055555584a8c9 in qemu_cleanup_net_client (nc=3D<optimized out>, re=
move_from_net_clients=3Dfalse)
    at ../net/net.c:392
#2  qemu_del_nic (nic=3D0x555558866400) at ../net/net.c:476
#3  0x00005555557cae41 in xen_device_unrealize (dev=3D<optimized out>) at .=
./hw/xen/xen-bus.c:988
#4  0x0000555555c414ff in notifier_list_notify
    (list=3Dlist@entry=3D0x5555570671f0 <exit_notifiers>, data=3Ddata@entry=
=3D0x0) at ../util/notify.c:39
#5  0x00005555557efd2c in qemu_run_exit_notifiers () at ../system/runstate.=
c:854
#6  0x00007ffff52996c1 in __run_exit_handlers () at /lib64/libc.so.6
#7  0x00007ffff529978e in exit () at /lib64/libc.so.6
#8  0x0000555555b90a5c in qemu_default_main (opaque=3Dopaque@entry=3D0x0) a=
t ../system/main.c:52
#9  0x00005555555622d0 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at ../system/main.c:76


--=-cv1BhCTCrtWIlRQxidga
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxOTE2MTMx
NFowLwYJKoZIhvcNAQkEMSIEIHFZV5IUXG2WHTxA5yEOM/44Wz0pzaWM5N0ZvVnuwjISMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIArqll0CBXAx97
setkE23Jjm3mlDq2WhX7AaS3MSOu0E2A2HNnhhDmRzbpYC9KX7zLoMiXQlFlF+JkDKq3NiyxOgFu
0mOIqgLbP/swtZ3KdGo7N34X/Ch0bDBRtQyvnDoATe+n/mfgJBjuCtRCV132rEGnLkpGpufviNN0
l5hihYrFXzS0ji88BdZa6cyo0CF3oUKDH15jbLTR73oE8RPaiQlX0HLZkfRWjjNzW3RmEnOqqh8Q
yyMOyz3XogVH4gmXRe15JUuozE2G0UuXyVjaWQ4zU8PNzHKh58mX+v2WBz3D1RcoxZvZ88EPtht9
BMDltPjn07dvzCDLIbHhiLsIA2PGtWr+MoaWb8pfSRd3msO9ouRsWudLmOVadK+A9juH4QOgxgD+
pRnW3slYbA/eAVhC/0y8Dob7QpLURN6h4RBHf0MS6vH4Bx4ZwghqAya4g3gv48OE+UKNJEVKMk9a
ZcnDJp+QT4tvRO5+Q+e3Fe+ftFJOgZZ0AnKA7Vf0yU8tuWviaspagZSEdkKqV0rANFD/S1Wn6LP+
hqBAw1OmwFgTVmX5OHeWCxHLAiEnPF6J0w3wHxhUiryjw9SKXNk/Re6i2AsMRKMoYDKkZWAr8psF
RcfvVLb9mOpGvQw4d6WTePN3GpsGVwcw0zCRWjIBbB/c+72RLrTEkJKWTFOdop0AAAAAAAA=


--=-cv1BhCTCrtWIlRQxidga--

