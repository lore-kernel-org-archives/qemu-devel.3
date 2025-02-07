Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE9C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPRH-0000AB-8W; Fri, 07 Feb 2025 09:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tgPRF-00009L-1N
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:34:37 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tgPRB-0003B5-Iv
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KsJHKxDHuvghxCrCBP8FS4KOaHx66s/HjPvNG85AHEo=; b=komzWrBN+ho1CDV2waUI6XON3s
 tSFth5SUKbYehFn3AAg/1KmNW1qU5lIAlqjae7ilWtVrCvM+oIdtGP1j2oyDKmYoXDpO1q0TR9A6I
 Qjq/5pE/LRbh+WEsb7/sxwtOLwWKNwmfdLUxQ0YUsPG4mg+mv/qp5DNqMMPNzo0DirUmOWpC1XwsJ
 p1WgKTa3qFJgGQ76WAJF0fk37TiPraM0v12kbCfmDXFlCy/gh06+mDwdAqfPY2VF0IFymHyNu0A1L
 Fq1C4gIWO6QrWiU7yRknrmmqLInvsRtrS5JMJByBCMGASJxwb5kFTEN6IS6mzYf98CIIBqW8KNwKV
 33Eo+ayw==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238]
 helo=freeip.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tgPR2-00000007xuv-0hs2; Fri, 07 Feb 2025 14:34:24 +0000
Message-ID: <3d1b617f001b4ee989101748d120992c81a63a63.camel@infradead.org>
Subject: [PATCH] hw/acpi: Remove legacy reset handling from vmclock
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>, Peter Hilber
 <quic_philber@quicinc.com>, "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>,  paul <paul@xen.org>
Date: Fri, 07 Feb 2025 14:34:22 +0000
In-Reply-To: <9097119d6e4c6a1f0a9c8fd3516b02008a1d8ffd.camel@infradead.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
 <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
 <9097119d6e4c6a1f0a9c8fd3516b02008a1d8ffd.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-TTqitWoKtRlpSL1saCyh"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+d214d3087cba0d0cd96e+7838+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-TTqitWoKtRlpSL1saCyh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device only has a reset method in order to plug its memory
region into the system memory. It was originally done this way in order
to defer the memory_region_add_subregion_overlap() from vmclock_realize(),
but that doesn't seem to be necessary (any longer?).

Still, allowing the platform code to do this is cleaner because it lets
the address be specified by the platform, easing the port to Arm and
other platforms in future. And the platform has to be involved anyway
because of the need to include the device in the ACPI tables (or DT).

So drop the reset method and provide a vmclock_mmio_map() function
instead, called from pc_machine_done().

Shift the ACPI table build into #ifdef CONFIG_ACPI_VMCLOCK too while
we're at it, since it looks like that wouldn't have built when vmclock
wasn't enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/acpi/vmclock.c         | 18 ++++++------------
 hw/i386/acpi-build.c      | 16 ++++++++++------
 hw/i386/pc.c              | 10 ++++++++++
 include/hw/acpi/vmclock.h |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)

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
--=20
2.48.1



--=-TTqitWoKtRlpSL1saCyh
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNzE0MzQy
MlowLwYJKoZIhvcNAQkEMSIEIC7BNp00i4PIVX5dgSA35UxMFChPK0KlSbJxhX4TKDhSMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAhyLQnBbdSYBV
9kzXOOrVBGMdVyol90cFYBjf6voBNBHilK2I5kw6sFCE2X7rkrAPlmI0y5qvDQTXmR1z1hkON9sJ
7Zze5ZUHKUA7QkidRb0wes1NnYpF0sEy8YjYSRrx71lHX0FlaeKplhf93pAhokAkDQUDN+cOmxF3
JJ0WsTfHSGckcMJS2lzfqBxVpmIdP9unIHzXCCwAI+Cms6v22VZwzjTLCm8A+PfajnzviJ0LpfIZ
r+83D9AnDWPcY7qRF2fkLmL7qG3/ksxWjrD9vYQmKeXVzXSpY0tR/xSUWFcyqbUBMHViHzB62fNw
1vPTMTplb5fA8lJ/kweRTuOtebKvFMhIjJZh82Dg+gIEgCHpyV9MFfg15l2kExPED6lqrNhtY5RQ
DquGnNsrA7CiFJOtecz/ycBCSJVDZnofFjUdm5L8n3GoRKCnQNIwxEe8K1p3UupK6n48nq5xTl1O
jteNXDTk0/Iz0Tm/Rl8wuRXtp8uQXJll1ygWqlb4AiWIlmstVuVxC16D+UidfWYhbPHbvpwDVZ+p
se4dtSe3N2j4HZaBTO7dWHdmWekuOqdOENLO4+6ULQdfMnp/vcvYmNOvWcY459vbW/rN0JbyHUJU
n/f6WVAgyqpYc/pDuWjDuB77Owof/Rekx28gGQkJQSxB3OQdlDh1zg34G/gxPxAAAAAAAAA=


--=-TTqitWoKtRlpSL1saCyh--

