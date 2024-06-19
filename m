Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C461C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJuyD-0002TC-R4; Wed, 19 Jun 2024 09:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d14b5a2fac9ee6d76cac+7605+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sJuyB-0002SX-99
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:03:23 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+d14b5a2fac9ee6d76cac+7605+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sJuy7-0002er-BZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=CV8mZvHokXHp/JygCMiR0xzpKFq/Z5GTwivMNvlRBsI=; b=grZHHZEgLokY7esZqhhaI9UD67
 DvwX19OLKoWU7NywhUm3N4sr7ePiwgNppRBN0IiErd8pXnl3by0rnTnSTvK72IvnwIhCUN1rknkqN
 uZY7oJ6wRvumFzLLAWd74UI5mV44i5k4YboeLGukBFgc3cAnwgRLP1ENKLZI0gO6Xi+SKDIROWnOZ
 91LEg3wcYRIVRz76IhZaio9+7QhjFUdBP42KL8R2Gn91Q4wkqvR5rnVu8kwK9lnYAJpCON6Hb+oEX
 vmDPDyIeUxpxKr+QvkOFMQS0KKZY4CQzLuUXI0mVj9CofgqjrkompQ/WRDcgYmteC3XroWmyn5/O7
 bSC5oFJQ==;
Received: from [2001:8b0:10b:5:840e:4165:415:3944]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sJuy0-00000004khj-0sqV; Wed, 19 Jun 2024 13:03:12 +0000
Message-ID: <a2708734f004b224f33d3b4824e9a5a262431568.camel@infradead.org>
Subject: [PATCH v2] hw/i386/fw_cfg: Add etc/e820 to fw_cfg late
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>
Date: Wed, 19 Jun 2024 14:03:08 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-eueMOYgaq5/aKVAYeeZL"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+d14b5a2fac9ee6d76cac+7605+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--=-eueMOYgaq5/aKVAYeeZL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In e820_add_entry() the e820_table is reallocated with g_renew() to make
space for a new entry. However, fw_cfg_arch_create() just uses the
existing e820_table pointer. This leads to a use-after-free if anything
adds a new entry after fw_cfg is set up.

Shift the addition of the etc/e820 file to the machine done notifier, via
a new fw_cfg_add_e820() function.

Also make e820_table private and use an e820_get_table() accessor function
for it, which sets a flag that will trigger an assert() for any *later*
attempts to add to the table.

Make e820_add_entry() return void, as most callers don't check for error
anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
v2: Make the table static and introduce e820_get_table(), use assert()

 hw/i386/e820_memory_layout.c | 16 +++++++++++-----
 hw/i386/e820_memory_layout.h |  8 ++------
 hw/i386/fw_cfg.c             | 18 +++++++++++++-----
 hw/i386/fw_cfg.h             |  1 +
 hw/i386/microvm.c            |  4 ++--
 hw/i386/pc.c                 |  1 +
 target/i386/kvm/kvm.c        |  6 +-----
 target/i386/kvm/xen-emu.c    |  7 +------
 8 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
index 06970ac44a..0d549accbf 100644
--- a/hw/i386/e820_memory_layout.c
+++ b/hw/i386/e820_memory_layout.c
@@ -11,22 +11,28 @@
 #include "e820_memory_layout.h"
=20
 static size_t e820_entries;
-struct e820_entry *e820_table;
+static struct e820_entry *e820_table;
+static gboolean e820_done;
=20
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
+void e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
 {
+    assert(!e820_done);
+
     /* new "etc/e820" file -- include ram and reserved entries */
     e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries + 1=
);
     e820_table[e820_entries].address =3D cpu_to_le64(address);
     e820_table[e820_entries].length =3D cpu_to_le64(length);
     e820_table[e820_entries].type =3D cpu_to_le32(type);
     e820_entries++;
-
-    return e820_entries;
 }
=20
-int e820_get_num_entries(void)
+int e820_get_table(struct e820_entry **table)
 {
+    e820_done =3D true;
+
+    if (table)
+        *table =3D e820_table;
+
     return e820_entries;
 }
=20
diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index 7c239aa033..b50acfa201 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -22,13 +22,9 @@ struct e820_entry {
     uint32_t type;
 } QEMU_PACKED __attribute((__aligned__(4)));
=20
-extern struct e820_entry *e820_table;
-
-int e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
-int e820_get_num_entries(void);
+void e820_add_entry(uint64_t address, uint64_t length, uint32_t type);
 bool e820_get_entry(int index, uint32_t type,
                     uint64_t *address, uint64_t *length);
-
-
+int e820_get_table(struct e820_entry **table);
=20
 #endif
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 6e0d9945d0..1eb6729b9c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -48,6 +48,15 @@ const char *fw_cfg_arch_key_name(uint16_t key)
     return NULL;
 }
=20
+/* Add etc/e820 late, once all regions should be present */
+void fw_cfg_add_e820(FWCfgState *fw_cfg)
+{
+    struct e820_entry *table;
+    int nr_e820 =3D e820_get_table(&table);
+
+    fw_cfg_add_file(fw_cfg, "etc/e820", table, nr_e820 * sizeof(*table));
+}
+
 void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          SmbiosEntryPointType ep_type)
 {
@@ -60,6 +69,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState=
 *fw_cfg,
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
     X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
+    int nr_e820;
=20
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
@@ -79,8 +89,9 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState=
 *fw_cfg,
     }
=20
     /* build the array of physical mem area from e820 table */
-    mem_array =3D g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
-    for (i =3D 0, array_count =3D 0; i < e820_get_num_entries(); i++) {
+    nr_e820 =3D e820_get_table(NULL);
+    mem_array =3D g_malloc0(sizeof(*mem_array) * nr_e820);
+    for (i =3D 0, array_count =3D 0; i < nr_e820; i++) {
         uint64_t addr, len;
=20
         if (e820_get_entry(i, E820_RAM, &addr, &len)) {
@@ -139,9 +150,6 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
=20
-    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_get_num_entries());
-
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
     /* allocate memory for the NUMA channel: one (64bit) word for the numb=
er
      * of nodes, one word for each VCPU->node and one word for each node t=
o
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index 92e310f5fd..e560fd7be8 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -27,5 +27,6 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState=
 *fw_cfg,
                          SmbiosEntryPointType ep_type);
 void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
 void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
+void fw_cfg_add_e820(FWCfgState *fw_cfg);
=20
 #endif
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index fec63cacfa..40edcee7af 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -324,8 +324,6 @@ static void microvm_memory_init(MicrovmMachineState *mm=
s)
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
-    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_get_num_entries());
=20
     rom_set_fw(fw_cfg);
=20
@@ -586,9 +584,11 @@ static void microvm_machine_done(Notifier *notifier, v=
oid *data)
 {
     MicrovmMachineState *mms =3D container_of(notifier, MicrovmMachineStat=
e,
                                             machine_done);
+    X86MachineState *x86ms =3D X86_MACHINE(mms);
=20
     acpi_setup_microvm(mms);
     dt_setup_microvm(mms);
+    fw_cfg_add_e820(x86ms->fw_cfg);
 }
=20
 static void microvm_powerdown_req(Notifier *notifier, void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0469af00a7..2ebfcc112b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -685,6 +685,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     acpi_setup();
     if (x86ms->fw_cfg) {
         fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_=
type);
+        fw_cfg_add_e820(x86ms->fw_cfg);
         fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus)=
;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 912f5d5a6b..3e8ba00e8d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2706,11 +2706,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
=20
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    ret =3D e820_add_entry(identity_base, 0x4000, E820_RESERVED);
-    if (ret < 0) {
-        fprintf(stderr, "e820_add_entry() table is full\n");
-        return ret;
-    }
+    e820_add_entry(identity_base, 0x4000, E820_RESERVED);
=20
     shadow_mem =3D object_property_get_int(OBJECT(s), "kvm-shadow-mem", &e=
rror_abort);
     if (shadow_mem !=3D -1) {
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index fc2c2321ac..2f89dc628e 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -176,12 +176,7 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
     s->xen_caps =3D xen_caps;
=20
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
-    ret =3D e820_add_entry(XEN_SPECIAL_AREA_ADDR, XEN_SPECIAL_AREA_SIZE,
-                         E820_RESERVED);
-    if (ret < 0) {
-        fprintf(stderr, "e820_add_entry() table is full\n");
-        return ret;
-    }
+    e820_add_entry(XEN_SPECIAL_AREA_ADDR, XEN_SPECIAL_AREA_SIZE, E820_RESE=
RVED);
=20
     /* The pages couldn't be overlaid until KVM was initialized */
     xen_primary_console_reset();
--=20
2.44.0



--=-eueMOYgaq5/aKVAYeeZL
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNjE5MTMwMzA4WjAvBgkqhkiG9w0BCQQxIgQgGP1Wp1ed
wbWRtUImcMrXANbTEcx5bbzQWGdumj0yc/kwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAeBBVLpnc/Ez+9NxLwqq2cObGGIfhe/M9R
ssk4V5LCQ/kfR4MmQFAFD1zqnA5MkxCOD0nIiyBVPRHWgfX3N9WIkwXsUGI8atv6eLpuCTXUjgYQ
yKfBP7alSbS43ZOKKVGwAJ5KHlC0WJvb+dVdnajldRCKb+5hdT/2OLt/nmQls+d0Cu+ZyqNaVuJg
/oJ2vH/CSgTF3AtibTy1sCdJKw4RRERLw3Ox68x7TGJ3xQCsKECEqM/9xjn8AlfTZmROqoE0KAdx
RKkoEVp4OenMOD4f9kx9GS2yQZdvcMCLf0SRvfvUgtbfNPjJVlFjOPltG38xcwKcsr2iQ7IbYZya
e4hkriKS9AI44XdfkQbenYTjaPSQ7fPoEbJOC6byeDbYHxPGg/oxZI0ziEAd7EkHOe3PM+HitBgH
QAPmwFjGa137ANnWWeKOsTcWk0L4gz4do9yGSH0xvSlVaNy1VuJ+FOIGqLYnlncKii5EyKBr5KFR
VbKjhtaDlxiYx7Gh/XqsuBO7ggGJy104zqu5vvN5SCHD6nPNX4nrFOTJG++ZHP+ItERfDXn0m4XL
cFI9SekXuUQNrnhLvzjpVf1cD5A50M4KptgOBMJiXYZ7eT/AOfm4GYTo+hjnVU6GBR2cEuv/Yj38
td+moKq1CdQVm3GIdxCUoy+5qZbhjf9xt+BWz/RciwAAAAAAAA==


--=-eueMOYgaq5/aKVAYeeZL--

