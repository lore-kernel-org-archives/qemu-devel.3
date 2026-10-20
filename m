Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF4606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZpKoeE8r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJEsr-00052y-3C; Tue, 20 Oct 2026 14:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xJEso-00052O-LO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:48:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xJEsk-0004LO-6K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:48:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2424046f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792522096; x=1793126896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FwV03BnljHvrYkJf+lErNTezJD62CanPfxXQ6NNZ5U=;
 b=ZpKoeE8r6ZxqrGgeC00NaFLbF3ux7jO75aA8+tpS/OIHarHAj9yIs+FDTq6n85q6LR
 zPIooGX/Ojx+CR2I1EKaIt0U30zpCGz6zxDTe0jHk1XotFFWzOQcdDE8Bfgx/yUAoMjN
 PoPblTL2OeNEwJcNLfIga5tPka5+aWqtJfI/62478V9F50qoHfkMeL+jRsYz5xJ+yiPq
 CfULQXqY4xdzPKravMcMk+HD5ggnw6cU1dRR+GlJvljadlmmB1GZyv+z9CPiAVjW3PNe
 RwbeAKwvBDN78rUPQieNqGOzKFxnkVc9KHrphJ/G9h620CC2fUmc3Nn0TcuZNSuvS96h
 MWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792522096; x=1793126896;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6FwV03BnljHvrYkJf+lErNTezJD62CanPfxXQ6NNZ5U=;
 b=IrM/ob0FfggPNLSFmasnEPzfebflIRZSWKQ+1RkVn2eJnXxnNtzrlVHMKGldS1Cq1j
 P7zubOJJ44mo5HVFqRBiZUowbJjLxPDPyx6NRUlUA7AUOivQTUSTFGb22Uk/sSx+qbxb
 nh3vBvQKiTP7x1afQQL8S40B60f5nF/7CJNHIzeGrfO9qzAER2JSi77Dm6mJlgyt/+Fj
 rIty+ioxC9guZ2/gBeOpD0f7f0MCS5lXXK/yywUuOx/Dp1CcDJHq1MLRwjf3gKwRL7N0
 ZRHWG7mTVZ5QRRbNFW4X1+17YDw1hNuH2PkBsqcICOYlisaVVlw0xjYb+0drtyyMs0Tq
 o7FA==
X-Gm-Message-State: AFq9FYK6O0HGrwHNSWe1BtkCie661gzqcNJ2ZDl4vQEynaj6kX87OuRf
 q1nUY6l4xTkCV0ARprH8fxJDvbW2Wr2JAp7FrBPctmO18jj2hjXhN4721AOtqQ==
X-Gm-Gg: AYBFou2oqodEVfJvcleSxvgT60c602YR+1viwNEzrPSTz7x8pOzBD2dSWMO5MIq7IUx
 OjOnSqxZPpGQS15+R9rMPyyqrH6Oiqmbdfj559/sopUEzG3qzr/gu1xTKfkwNoGLBzzCRq4rOzi
 0xrO+953NI2wi9HYThPE6ovMQ6cVmaUFHSDT4ufKjaOJY56+s4U/E6AmMODPLhcNQ6IGSigLrgK
 aVj1Y53WEeL3Bu1PM0JQD5M6yPUnW972oi1N2lgroIAFVw9IuY7HuE+P8GO2CT7U09ftmEiddJE
 b4bhx3fP34Z7H87+cHswJjBLLsWubqlBaX+b5Z/qWl5H+hjpOrbvvgoNy6Pyrdip+UAVfFWQ0nq
 sjTydiE5KwYNN7dVvRn5eTHvgA4PaD+SL2oZ1f5iNxGYZ0xFEczNpJTL47Z6ZtutFj20vfsxp2G
 7v8gm8lLFPDJIneZ8tddg8b3ILnvgTlVT5JVlmcNgp9JtFI2MH5pUMhyyL2hnfPEjJACIGFjZ9E
 xZuX3PIirEWJ6hKutOOTw4pk4AoNWQS5Lk+nusiEMdSIsQ8OOKd4rgwpslpnH/umTa+ONJMHq0o
 KOiJP7fT0lYr+pyZP+A=
X-Received: by 2002:a05:6000:4a0a:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e07bbc619mr25855899f8f.15.1792522095942; 
 Tue, 20 Oct 2026 11:48:15 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-18af-d500-ec6b-a832-f355-434e.310.pool.telefonica.de.
 [2a02:3100:18af:d500:ec6b:a832:f355:434e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584afe1sm183030f8f.56.2026.10.20.11.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 11:48:15 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:39:39 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com,
 xen-devel@lists.xenproject.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_22/28=5D_xen-hvm=2Ec=3A_rename_xen=5Fin?=
 =?US-ASCII?Q?terrupt=5Fcontroller=5Fini?=
 =?US-ASCII?Q?t=28=29_to_xen=5Fi8259=5Finit=28=29?=
In-Reply-To: <20261019120517.1448687-23-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-23-mark.caveayland@nutanix.com>
Message-ID: <22FB9414-4D72-4699-9FB4-107D9DF10F28@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 19=2E Oktober 2026 12:04:54 UTC schrieb Mark Cave-Ayland <mark=2Ecaveay=
land@nutanix=2Ecom>:
>This clarifies that the interrupt controller being modelled is an emulate=
d
>i8259 implementation, and brings the naming convention in line with the
>in-built i8259 and KVM i8259 implementations=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecaveayland@nutanix=2Ecom>
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>---
> include/hw/xen/xen=2Eh  | 2 +-
> hw/i386/pc=2Ec          | 2 +-
> hw/i386/xen/xen-hvm=2Ec | 2 +-
> stubs/xen-hw-stub=2Ec   | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/hw/xen/xen=2Eh b/include/hw/xen/xen=2Eh
>index e94c6e5a31=2E=2Eee4ed4f11b 100644
>--- a/include/hw/xen/xen=2Eh
>+++ b/include/hw/xen/xen=2Eh
>@@ -42,7 +42,7 @@ void xen_intx_set_irq(void *opaque, int irq_num, int le=
vel);
> void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
> int xen_is_pirq_msi(uint32_t msi_data);
>=20
>-qemu_irq *xen_interrupt_controller_init(void);
>+qemu_irq *xen_i8259_init(void);
>=20
> void xen_register_framebuffer(struct MemoryRegion *mr);
>=20
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index 2d8c87b0e3=2E=2Edbfd55de30 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -1167,7 +1167,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i82=
59_irqs)
>     if (kvm_pic_in_kernel()) {
>         i8259 =3D kvm_i8259_init(isa_bus);
>     } else if (xen_enabled()) {
>-        i8259 =3D xen_interrupt_controller_init();
>+        i8259 =3D xen_i8259_init();
>     } else {
>         i8259 =3D i8259_init(isa_bus, x86_allocate_cpu_irq());
>     }
>diff --git a/hw/i386/xen/xen-hvm=2Ec b/hw/i386/xen/xen-hvm=2Ec
>index d3ce082e07=2E=2Eaf3a90987c 100644
>--- a/hw/i386/xen/xen-hvm=2Ec
>+++ b/hw/i386/xen/xen-hvm=2Ec
>@@ -112,7 +112,7 @@ static void xen_set_irq(void *opaque, int irq, int le=
vel)
>     xen_set_isa_irq_level(xen_domid, irq, level);
> }
>=20
>-qemu_irq *xen_interrupt_controller_init(void)
>+qemu_irq *xen_i8259_init(void)
> {
>     return qemu_allocate_irqs(xen_set_irq, NULL, 16);

Since this function allocates 16 IRQs, the convention according to this se=
ries would be xen_i8259_pic_init(), no?

Otherwise, much appreciated clarification of the terminology=2E

Best regards,
Bernhard

> }
>diff --git a/stubs/xen-hw-stub=2Ec b/stubs/xen-hw-stub=2Ec
>index 6cf0e9a4c1=2E=2Eb3e27f0292 100644
>--- a/stubs/xen-hw-stub=2Ec
>+++ b/stubs/xen-hw-stub=2Ec
>@@ -29,7 +29,7 @@ int xen_is_pirq_msi(uint32_t msi_data)
>     return 0;
> }
>=20
>-qemu_irq *xen_interrupt_controller_init(void)
>+qemu_irq *xen_i8259_init(void)
> {
>     return NULL;
> }

