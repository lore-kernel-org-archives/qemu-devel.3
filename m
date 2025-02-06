Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE93AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3XU-0007T3-IR; Thu, 06 Feb 2025 10:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d8297753e4f83f12c4e7+7837+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tg3XR-0007RE-V6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:11:34 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d8297753e4f83f12c4e7+7837+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tg3XO-0000rI-RZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZrSFxEk7MX/uQs/JdX7DrAdegievwldTbadI7h0lNDk=; b=tw/s9LTfoQL8i5SW70T35YsSGR
 h41MK2sdpzBlU3m0Alzsw6SED9NIjTMXJLZ3nmCM9Iawk5To3m+OchNiYYp7ixfqSjLramCLOJ2LF
 8xmL3b835SbNW39s5VbuGalxtH77ppvNtYZgAqaBN4+WmkWMv+BZKW3AI+H3oFQ+vh73wONJbJH13
 M7SYLEPtpRz0Guk3Hzsa4nV5g8n5VVe0CKpSMQf4Nh+172SGXCR46rdZXckFBSRGc7+Q8WtGWeLPZ
 t/asowDs+abo/0w0U0fOg+M/D/aVhlipRhb8n52FxP7VmKOmhFOo0eIpb8/QPnEmi1SOkQqjlgqyJ
 SSgRLK6g==;
Received: from [54.239.6.187] (helo=freeip.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tg3XH-00000006Aio-2EDB; Thu, 06 Feb 2025 15:11:23 +0000
Message-ID: <9097119d6e4c6a1f0a9c8fd3516b02008a1d8ffd.camel@infradead.org>
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>, Peter Hilber
 <quic_philber@quicinc.com>, "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>,  paul <paul@xen.org>
Date: Thu, 06 Feb 2025 15:11:22 +0000
In-Reply-To: <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
 <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-S95JZg20J78vyEeqI1mW"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+d8297753e4f83f12c4e7+7837+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-S95JZg20J78vyEeqI1mW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-02-04 at 14:52 +0000, Peter Maydell wrote:
> On Tue, 4 Feb 2025 at 14:17, David Woodhouse <dwmw2@infradead.org> wrote:
> >=20
> > On Tue, 2025-02-04 at 13:49 +0000, Peter Maydell wrote:
> > > On Thu, 16 Jan 2025 at 14:05, David Woodhouse <dwmw2@infradead.org>
> > > wrote:
> > > > +=C2=A0=C2=A0=C2=A0 qemu_register_reset(vmclock_handle_reset, vms);
> > >=20
> > > No new calls to qemu_register_reset(), please. This is
> > > a device, use the device reset API.
> >=20
> > Ack. This was cargo-culted from vmgenid; should I fix that too?
>=20
> Yes, please.
>=20
> > Is commit c009a311e93 the right example to follow?
>=20
> I guess so, but I don't understand why that code is
> adding its own ResettableState and overriding rc->get_state.
> Devices all already have a ResettableState.
>=20
> This is annoyingly complicated because your device
> is directly inheriting from TYPE_DEVICE, and not from
> TYPE_SYSBUS_DEVICE. TYPE_DEVICE devices are not plugged into
> any bus, so they don't get automatically reset on system
> reset. TYPE_SYSBUS_DEVICE devices plug into the sysbus,
> so they get reset when system reset walks the bus tree to
> reset everything.
>=20
> I would ideally like to figure out a more sensible design
> for reset that doesn't require that either everything plugs
> into a bus or else grotty hacks to arrange for it to get
> reset manually, but that's a design problem that's been
> on my todo list for some years now. My interim stance has
> basically been "don't directly inherit from TYPE_DEVICE,
> because then you won't get reset; prefer TYPE_SYSBUS_DEVICE
> instead"...

Hm, I'll have to look at vmgenid separately but for vmclock I don't
need the reset at all if I just get the board code to map the memory
region...

diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
index 7387e5c9ca..36edfae0ed 100644
--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -20,7 +20,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
-#include "system/reset.h"
=20
 #include "standard-headers/linux/vmclock-abi.h"
=20
@@ -107,15 +106,14 @@ static const VMStateDescription vmstate_vmclock =3D {
     },
 };
=20
-static void vmclock_handle_reset(void *opaque)
+void vmclock_mmio_map(Object *dev, hwaddr addr)
 {
-    VmclockState *vms =3D VMCLOCK(opaque);
+    VmclockState *vms =3D VMCLOCK(dev);
=20
-    if (!memory_region_is_mapped(&vms->clk_page)) {
-        memory_region_add_subregion_overlap(get_system_memory(),
-                                            vms->physaddr,
-                                            &vms->clk_page, 0);
-    }
+    vms->physaddr =3D addr;
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        vms->physaddr,
+                                        &vms->clk_page, 0);
 }
=20
 static void vmclock_realize(DeviceState *dev, Error **errp)
@@ -131,8 +129,6 @@ static void vmclock_realize(DeviceState *dev, Error **e=
rrp)
         return;
     }
=20
-    vms->physaddr =3D VMCLOCK_ADDR;
-
     e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
=20
     memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
@@ -149,8 +145,6 @@ static void vmclock_realize(DeviceState *dev, Error **e=
rrp)
     vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;
     vms->clk->counter_id =3D VMCLOCK_COUNTER_INVALID;
=20
-    qemu_register_reset(vmclock_handle_reset, vms);
-
     vmclock_update_guest(vms);
 }
=20
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53b7306b43..9db7b1f94e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2446,7 +2446,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
     uint8_t *u;
     GArray *tables_blob =3D tables->table_data;
     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
-    Object *vmgenid_dev, *vmclock_dev;
+    Object *vmgenid_dev;
     char *oem_id;
     char *oem_table_id;
=20
@@ -2519,12 +2519,16 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
                            tables->vmgenid, tables->linker, x86ms->oem_id)=
;
     }
=20
-    vmclock_dev =3D find_vmclock_dev();
-    if (vmclock_dev) {
-        acpi_add_table(table_offsets, tables_blob);
-        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->link=
er,
-                           x86ms->oem_id);
+#ifdef CONFIG_ACPI_VMCLOCK
+    {
+        Object *vmclock_dev =3D find_vmclock_dev();
+        if (vmclock_dev) {
+            acpi_add_table(table_offsets, tables_blob);
+            vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->=
linker,
+                               x86ms->oem_id);
+        }
     }
+#endif
=20
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b46975c8a4..776c2c8a37 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -60,6 +60,7 @@
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
 #include "hw/mem/memory-device.h"
+#include "hw/acpi/vmclock.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include "sev.h"
@@ -635,6 +636,15 @@ void pc_machine_done(Notifier *notifier, void *data)
     pci_bus_add_fw_cfg_extra_pci_roots(x86ms->fw_cfg, pcms->pcibus,
                                        &error_abort);
=20
+#ifdef CONFIG_ACPI_VMCLOCK
+    {
+        Object *vmclock =3D find_vmclock_dev();
+        if (vmclock) {
+            vmclock_mmio_map(vmclock, VMCLOCK_ADDR);
+        }
+    }
+#endif
+
     acpi_setup();
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_=
type);
diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
index 5605605812..97f8a30c0e 100644
--- a/include/hw/acpi/vmclock.h
+++ b/include/hw/acpi/vmclock.h
@@ -30,5 +30,6 @@ static inline Object *find_vmclock_dev(void)
=20
 void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
                         BIOSLinker *linker, const char *oem_id);
+void vmclock_mmio_map(Object *dev, hwaddr addr);
=20
 #endif


--=-S95JZg20J78vyEeqI1mW
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNjE1MTEy
MlowLwYJKoZIhvcNAQkEMSIEIBP4wu/+ylWFlSGOnuQQwOrwe+2eY20Mh7peGJ1w/lGCMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAeWGwYKtZ2Xst
WxCzDxUoLGrB8CevHr6PyiyuvMqHUQPUeO+y4dROGxFbWF7KlTzQuNFK4BJsxLfP2N2kcyIofI3k
xgCNib84p82icjDMdaE+MTPlQNd0F1ThNf8NatcQ+GCxSMhh+aQ6IicK7S6UNIamrL4XOOlnKNIH
QaJtYI/NacH7jW+H4WOe/qxyaStHYQCKawcowhbtohXXIOwapA+VTt7H5AE7W8ldhz+2HuAlElj8
Vjl+Jdmp3Z++rX1gfE0BtQWUFAs7cEwekKDvxvgxrfVYGfY6nK1gxzbCHIltgNY0g7JiwHVMMAiC
1gL9mtCE5xOmcxwKgtDAfg11xAbX5wADA7Kg3diDPFrqc/WQ9xiNWdydWMOhl6iIuZj1itLtKCpP
unQkRqmeboDd5sPQSNJ8x++BEeCUGY3BXSuoww4NUghb82iPBN+YYgy8vEldQG7YtFzXJ559/HBR
cJBasd4r4Lp4GNUgYl1z9W/0zb5XxMT6FDnVzwYBQ/O/uMaFc4yEjTE2mNqFdEgxeOvzS+Z/tyDE
OeHlKUC0UnlZNz/eHvcYzQwcPYYLw10bkopRRVDVM/3JBQZYQ5aaperXYAl/Y0zUbts2JhI1O+to
onuVxZ128WLye5aRSCMauEZ9wbdbDVtijkfs04aPuG2azPEtKGJxAIW9Fmm1yagAAAAAAAA=


--=-S95JZg20J78vyEeqI1mW--

