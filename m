Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2091E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFg-0001q7-OK; Thu, 19 Dec 2024 11:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tOG5M-0006R7-Pe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:57:01 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tOG5K-0008Ng-7j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MGPCrK/sCnjBhJckHmorAcUJvZgLl6NCm2Xjrt9767A=; b=ffMdSdfqCa/S2fHIc3Es7luXY9
 0fW2rnjTVY/9ND8L9beOzcKYZhB7CwWNA4PJS5ixQ1Pigg881OQzFwEy2Bzrzbtwkc9A+pOmCeJUF
 C97+U0QohOfz2h3jvcSF0I2x/7YbhFIVH4EahnBLiusXZ5ZdSe5N3FXkP7FyXKCMnABzaN0aEQiVw
 1/vz/Hnw/ovhl20KQLNn2Vl2atr12g8xhEwnATq/GgDbdFP/ph18NNii71f93yxB/L2YnmZ0HmLRb
 KS0Q0qjxjWPpeMacMFKFUG6a2pDUemd6kbG7GojLtEhLhyVMK4Nchue9daugVW5hecVLR0DC+uUIX
 wI8V/DdQ==;
Received: from [54.239.6.189] (helo=edge-m3-r3-213.e-iad51.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tOG5B-00000003YnL-1xHn; Thu, 19 Dec 2024 12:56:50 +0000
Message-ID: <a10f5e97da4d5d15f9d13a1a1341132419c01510.camel@infradead.org>
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
Date: Thu, 19 Dec 2024 13:56:49 +0100
In-Reply-To: <6b1e4f73-b53f-4929-8be4-4c07115af626@redhat.com>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <1d4faf8e-b2cd-42b8-a6a7-9034b9512b86@redhat.com>
 <8cef1bf9ffde6779ad322534c4469e6687b9c9d7.camel@infradead.org>
 <7e6fd4ed-ee93-48eb-ab12-fd9aa30e6898@redhat.com>
 <72B07F94-036B-4789-B5DF-103CA913278C@infradead.org>
 <6b1e4f73-b53f-4929-8be4-4c07115af626@redhat.com>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-vZKdrevNumBGW3j8l5KX"
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+a3c588bc637104075bf4+7788+infradead.org+dwmw2@casper.srs.infradead.org;
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


--=-vZKdrevNumBGW3j8l5KX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-12-19 at 13:24 +0100, Thomas Huth wrote:
> On 19/12/2024 09.49, David Woodhouse wrote:
> > On 19 December 2024 09:35:13 CET, Thomas Huth <thuth@redhat.com> wrote:
> > > On 18/12/2024 23.14, David Woodhouse wrote:
> > > > On Wed, 2024-12-18 at 16:54 +0100, Thomas Huth wrote:
> > > > > On 18/12/2024 12.48, David Woodhouse wrote:
> > > > > > On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com=
> wrote:
> > > > > > > Use the serial console to execute the commands in the guest i=
nstead
> > > > > > > of using ssh since we don't have ssh support in the functiona=
l
> > > > > > > framework yet.
> > > > > > >=20
> > > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > >=20
> > > > > > Hm, but serial is lossy and experience shows that it leads to f=
laky tests if the guest (or host) misses bytes. While SSH would just go slo=
wer.
> > > > >=20
> > > > > I now noticed some issue with the serial console in this test, to=
o.
> > > > > Looks like the "Starting dropbear sshd: OK" is not print in an at=
omic way by
> > > > > the guest, sometimes there are other kernel messages between the =
":" and the
> > > > > "OK". It works reliable when removing the "OK" from the string.
> > > >=20
> > > > Nah, that still isn't atomic; you just got lucky because the race
> > > > window is smaller. It's not like serial ports are at a premium; can=
't
> > > > you have a separate port for kernel vs. userspace messages?
> > >=20
> > > Maybe easiest solution: Simply add "quiet" to the kernel command line=
, then it does not write the kernel messages to the serial console anymore.
> >=20
> > Want to resend the bug report about that test failing again? But withou=
t the kernel messages this time... :)
>=20
> With "quiet", the output just looks like this when it hangs:
>=20
> =C2=A0 Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
> =C2=A0 Spectre V2 : Kernel not compiled with retpoline; no mitigation ava=
ilable!
> =C2=A0 kvm_intel: VMX not supported by CPU 0
> =C2=A0 Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!
> =C2=A0 fail to initialize ptp_kvm

Yeah, that request was rhetorical. That output is useless for
understanding anything about what happened.

> Anyway, to properly track this, I've now created a ticket with the full l=
og:
>=20
> =C2=A0 https://gitlab.com/qemu-project/qemu/-/issues/2731

The patch below should fix it. I don't like it very much; it's very
much papering over a much bigger generic problem with QEMU's handling
of shared interrupts.

Basically, *nothing* should just directly set the system GSIs to
"their" desired level with qemu_set_irq(). Each device should feed into
a multiplexer which is essentially an OR gate, and the *output* of that
mux goes into the actual GSI.

Alternatively, when the interrupt line is acked at the interrupt
controller, we should do a callback to query whether that line should
still be asserted (which is exactly how VFIO's resampler should work,
but we can't use it correctly from QEMU and currently just invoke it
for *every* MMIO access to a VFIO device!).

This just implements the logical OR for the Xen event channel callback
GSI, since the Xen code *already* has a hook in the x86 gsi_handler()
function to capture external interrupts being routed to event channel
PIRQs. So we just shuffle that a little and let it 'adjust' the level
that's being set.


diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 07bd0c9ab8..e3bd48d954 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -140,6 +140,8 @@ struct XenEvtchnState {
=20
     uint64_t callback_param;
     bool evtchn_in_kernel;
+    bool setting_callback_gsi;
+    int extern_gsi_level;
     uint32_t callback_gsi;
=20
     QEMUBH *gsi_bh;
@@ -431,7 +433,9 @@ void xen_evtchn_set_callback_level(int level)
     }
=20
     if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
-        qemu_set_irq(s->callback_gsis[s->callback_gsi], level);
+        s->setting_callback_gsi =3D true;
+        qemu_set_irq(s->callback_gsis[s->callback_gsi], level || s->extern=
_gsi_level);
+        s->setting_callback_gsi =3D false;
         if (level) {
             /* Ensure the vCPU polls for deassertion */
             kvm_xen_set_callback_asserted();
@@ -1596,7 +1600,7 @@ static int allocate_pirq(XenEvtchnState *s, int type,=
 int gsi)
     return pirq;
 }
=20
-bool xen_evtchn_set_gsi(int gsi, int level)
+bool xen_evtchn_set_gsi(int gsi, int *level)
 {
     XenEvtchnState *s =3D xen_evtchn_singleton;
     int pirq;
@@ -1608,16 +1612,29 @@ bool xen_evtchn_set_gsi(int gsi, int level)
     }
=20
     /*
-     * Check that that it *isn't* the event channel GSI, and thus
-     * that we are not recursing and it's safe to take s->port_lock.
+     * For the callback_gsi we need to implement a logical OR of the event
+     * channel GSI and the external input (e.g. from PCI INTx), because
+     * QEMU itself doesn't support shared level interrupts via demux or
+     * resamplers.
      *
-     * Locking aside, it's perfectly sane to bail out early for that
-     * special case, as it would make no sense for the event channel
-     * GSI to be routed back to event channels, when the delivery
-     * method is to raise the GSI... that recursion wouldn't *just*
-     * be a locking issue.
+     * Remember the level which is being set by *other* callers.
+     *
+     * The event channel GSI cannot be routed to PIRQ, as that would make
+     * no sense. It would also be a locking problem so bail out early and
+     * don't potentially deadlock on s->port_lock.
      */
     if (gsi && gsi =3D=3D s->callback_gsi) {
+        /* Remember the external state of the GSI pin (e.g. from PCI INTx)=
 */
+        if (!s->setting_callback_gsi) {
+            s->extern_gsi_level =3D *level;
+            if (!s->extern_gsi_level) {
+                struct vcpu_info *vi =3D kvm_xen_get_vcpu_info_hva(0);
+                if (vi && vi->evtchn_upcall_pending) {
+                    *level =3D 1;
+                }
+            }
+        }
+
         return false;
     }
=20
diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index b740acfc0d..0521ebc092 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -23,7 +23,7 @@ void xen_evtchn_set_callback_level(int level);
=20
 int xen_evtchn_set_port(uint16_t port);
=20
-bool xen_evtchn_set_gsi(int gsi, int level);
+bool xen_evtchn_set_gsi(int gsi, int *level);
 void xen_evtchn_snoop_msi(PCIDevice *dev, bool is_msix, unsigned int vecto=
r,
                           uint64_t addr, uint32_t data, bool is_masked);
 void xen_evtchn_remove_pci_device(PCIDevice *dev);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dc031af662..77acd331ee 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -450,28 +450,36 @@ static long get_file_size(FILE *f)
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
+    bool bypass_ioapic =3D false;
=20
     trace_x86_gsi_interrupt(n, level);
-    switch (n) {
-    case 0 ... ISA_NUM_IRQS - 1:
-        if (s->i8259_irq[n]) {
-            /* Under KVM, Kernel will forward to both PIC and IOAPIC */
-            qemu_set_irq(s->i8259_irq[n], level);
-        }
-        /* fall through */
-    case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
+
 #ifdef CONFIG_XEN_EMU
         /*
          * Xen delivers the GSI to the Legacy PIC (not that Legacy PIC
          * routing actually works properly under Xen). And then to
          * *either* the PIRQ handling or the I/OAPIC depending on
          * whether the former wants it.
+         *
+         * Additionally, this hook allows the Xen event channel GSI to
+         * work around QEMU's lack of support for shared level interrupts,
+         * by keeping track of the externally driven state of the pin and
+         * implementing a logical OR with the state of the evtchn GSI.
          */
-        if (xen_mode =3D=3D XEN_EMULATE && xen_evtchn_set_gsi(n, level)) {
-            break;
-        }
+    if (xen_mode =3D=3D XEN_EMULATE)
+        bypass_ioapic =3D xen_evtchn_set_gsi(n, &level);
 #endif
-        qemu_set_irq(s->ioapic_irq[n], level);
+
+    switch (n) {
+    case 0 ... ISA_NUM_IRQS - 1:
+        if (s->i8259_irq[n]) {
+            /* Under KVM, Kernel will forward to both PIC and IOAPIC */
+            qemu_set_irq(s->i8259_irq[n], level);
+        }
+        /* fall through */
+    case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
+        if (!bypass_ioapic)
+            qemu_set_irq(s->ioapic_irq[n], level);
         break;
     case IO_APIC_SECONDARY_IRQBASE
         ... IO_APIC_SECONDARY_IRQBASE + IOAPIC_NUM_PINS - 1:

--=-vZKdrevNumBGW3j8l5KX
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjE5MTI1NjQ5WjAvBgkqhkiG9w0BCQQxIgQg/pK4b/Qp
7KQq4ma/S6T7Jrf/J0ZNLiw1roLSRtCafj4wgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAO8Btz3p74FuGdSw+IuiqlIeGNxZf19IfR
NlN60JtzYoq3VhXNUQMDvvepslM95XXtZ28LBnlKv6oxEXtAWPJm4GGhWLoxvAUtxuTS41mwdyuu
YBVinFWjfir2D3z9sKRfrPhLuvXxHePR4Om1hHy6w0jpIfANYkO57xcGzDVeHfJE66zCWnhGRPhq
EeGXtstUN2BuCJ0ObqzJnuFM7395gqjhRa7YFg/glUrePBj2P1NYozqv8kVQ9r7IX7TJtW7mctCb
jjDBnPY95yjvPRW6IuW/Gnl+ZbRIjPyeAPqg4K5XiNdNzFVcspLVS9C+R8N4zsDvzT3i6mS4KNxs
rMsmFV499inDLHjTeXzj3s8fVwAefgAKr+V6sIoUrfZVZhgACOPeMG+m0544d/CStGEiIWOPp0xo
7yhwWZD52x1X85iQsybwyTZ0pAIvKysmMI1x5hoRgxIFQERFcrjb02QagWfsTq1BgQh+z2pWjoUl
dU8A3tYnVsS3UiqTEsuByalYOgzjb4Q0MBSLaVq0DQ5zFQzFMG/RvL5rZO3W/vMPXtq0R3UoBBpY
5Y5TdB8/qY+Fda5D2WADbLY/xjLQKGb+xLxxl67x6uIn9LFO7ZGk2JTKQl33KsmIY29qpmTFRN6u
4720qV8P0QLkjy/pmm8jVkFA8Ygsr+OvNnpWD6N85wAAAAAAAA==


--=-vZKdrevNumBGW3j8l5KX--

