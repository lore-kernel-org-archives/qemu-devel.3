Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1F0E8B37E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 00:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnQRP-00075C-JH; Tue, 03 Feb 2026 19:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b21bdf676bd9b8c1e570+8200+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1vnQRF-000713-Gh
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 19:08:09 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b21bdf676bd9b8c1e570+8200+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1vnQRC-0001oI-5i
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 19:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CQL6JUD2C+XGyBqORF3aEUFfsSEgMGR05HlmZe2r6WI=; b=bdONa+KCOllBIphtXEJO9WlLOq
 s67pyprRJL4zrAd05RfQs4AAu5XrTe6Wqq2MaoSkpKat8oSJQ74SnzbvHPr4fxCxQ6AKs4avgNV1v
 EyuEk9/xjs/e5b9hWzgrfLmU+q8fq6pcejze8vKeHQNZeKkmmRlsYsesbMNaMDTVvIqQLz7I3jEoJ
 avzo8U4zeLLueF0naNfyDxjN1jNdUYeWmRFSqoGMzEMcYahBjHpUsVhxtY7GVBuIKln977F1sMn+D
 3rwfIG5SknOEwLO9/0Q4viLTlYiim4i7z29ZFpPeYSBomrMkYTBCdB7aTGaX7lphiVCeciqnt0FhA
 D44dZODw==;
Received: from [2001:8b0:10b:5:f5e2:c207:68b5:f3f]
 (helo=u09cd745991455d.ant.amazon.com)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vnQQz-0000000HFGJ-2dtM; Wed, 04 Feb 2026 00:07:56 +0000
Message-ID: <da2e8ba94bfa5ff9d018ad83c962bc5316038545.camel@infradead.org>
Subject: Re: [RFC PATCH 1/4] acpi: fix acpi_send_gpe_event() to handle more
 events
From: David Woodhouse <dwmw2@infradead.org>
To: "Chalios, Babis" <mail@chalios.io>, "mst@redhat.com" <mst@redhat.com>, 
 "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>
Date: Wed, 04 Feb 2026 00:07:53 +0000
In-Reply-To: <20251201125023.18344-3-bchalios@amazon.es>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-3-bchalios@amazon.es>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-We0NWAUD/JJ82QCFfPfJ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b21bdf676bd9b8c1e570+8200+infradead.org+dwmw2@desiato.srs.infradead.org;
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


--=-We0NWAUD/JJ82QCFfPfJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-01 at 12:50 +0000, Chalios, Babis wrote:
> acpi_send_gpe_events() sends events encoded in the AcpiEventStatusBits
> enum. The maximum bit used so far in the latter was 128, hence a single
> byte (ACPIGPE.sts[0]) is currently enough to hold the set bits.
>=20
> When we add an extra one, we will need a second byte to encode the state
> and casting from AcpiEventStatusBits to uint8_t will silently ignore the
> higher bits.
>=20
> Fix this, by taking into account the length value inside ACPIGPE.
>=20
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
> =C2=A0hw/acpi/core.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index ff16582803..48694eca54 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -730,7 +730,13 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_=
t addr)
> =C2=A0void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AcpiEventStatusBits status)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 ar->gpe.sts[0] |=3D status;
> +=C2=A0=C2=A0=C2=A0 int i;
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ar->gpe.len; i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ar->gpe.sts[i] |=3D (status &=
 0xff);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status >>=3D 8;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 acpi_update_sci(ar, irq);
> =C2=A0}
> =C2=A0

Testing with the guest code that's now merged into net-next, I see that
still doesn't actually raise the SCI. It needs this in
acpi_update_sci():

--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -741,13 +741,16 @@ void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
=20
 void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
 {
-    int sci_level, pm1a_sts;
+    int i, sci_level, pm1a_sts;
=20
     pm1a_sts =3D acpi_pm1_evt_get_sts(regs);
=20
     sci_level =3D ((pm1a_sts &
-                  regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) !=3D=
 0) ||
-                ((regs->gpe.sts[0] & regs->gpe.en[0]) !=3D 0);
+                  regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) !=3D=
 0);
+
+    for (i =3D 0; !sci_level && i < regs->gpe.len; i++) {
+        sci_level =3D ((regs->gpe.sts[i] & regs->gpe.en[i]) !=3D 0);
+    }
=20
     qemu_set_irq(irq, sci_level);
=20

I'll send a new series with that fixed, and with an independent local
vmclock-abi.h header instead of using the one from Linux. And maybe
some QMP/HMP commands for the toolstack to bump the disruption and
generation counters.

--=-We0NWAUD/JJ82QCFfPfJ
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIwNDAwMDc1
M1owLwYJKoZIhvcNAQkEMSIEICXACJWmg52Ex68ONs9LMmmvMbk/6WpacGklFruLSMI9MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAM6ZK/2tpdvCh
hgqx8jvY25etXic4iUxI/QBbus4spZtb77UkFxEapceurQiJO/cj/TmLJKb8y+6AjC2MyvVSaX6r
4n4ptc0pLIL/FK2uvehr6QeJcRyquMM23BzEvxaA92qT6XxoOgdrz7ayCjzcHJgnljTJ4fsU8saD
iJNxhw1U+tzgxpW1LnicqS/tlA0XCWI6Zn1rObOFWdf8yhA2t5Nu2iigOsbr4Ziv3qfhr82QjXs/
NbWZb/HweWk9HgQ8keYkFLPD5mQQYntQBTwpPapX+OoyHYHOdvZL454aU0joyGzZjWbXReRrzo03
qL7SHyFG64QrqwHzfMXGhRllRd7wwfz8OiVsUrSXIVF9kwG4+IGsDVLU4uLd3h7I8d6gd1lKGJ5x
5k9s4bo0JlmIPxDMOiF2Pw/w5/CRFkyqctVTaD9llZ0mALvzQQE4dAo9XbYjWGNkhDtpLlMUCQTe
Yqm5golpNV4e9NOpiJTVOg5dy1YehinF1PbWJDFQtpiOrNmYbHDHu9YxWUDBoOJ1Lt6z9MQExhm4
msQEEpCRdqRud02etJGP3bTfabx28DKDDVk3aIOR0aGBn9OgDLnTj3BNjr5xFxFphJIisoKadckf
zTTV1iWisyDunEHEjSBW70Iz9TqIYfwXSz8VF1Ace0gASzONCmmCZYQM0Wh79VoAAAAAAAA=


--=-We0NWAUD/JJ82QCFfPfJ--

