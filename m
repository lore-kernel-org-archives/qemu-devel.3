Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD6606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kLoptXId
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAKv-0001tb-DF; Tue, 20 Oct 2026 09:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xJAKt-0001tH-9A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:57:03 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xJAKp-00067g-Qy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:57:02 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-70059e4dab6so2146371eaf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 06:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792504617; cv=none;
 d=google.com; s=arc-20260327;
 b=a62+SLFiiAUG7OTh6gB/VOXfdwVR9+DK6aBiY1Z1Voa1g8kvO6lFiIIgdMIeUn+0RD
 BPKdPgPFQmoe1G7BZLBjTJDAZvg6NCYrc+XCKtlMbb1zFTrrLeO+itWmnUA5Y9F3wR1S
 8FBd/x37Gs6hXts+wbEnDI5q9ctUpPL+McSacFYQlZcnlvUAc0nYG91itJpcDHlWoeSC
 tqQkLcHipW+EjqajgOEZaRBW9UoHpun0gbUrLs6/GMuqpskUEURaY+CK6r4PLOskjVeJ
 RlBcDCilDDCV7hUi6l7vYPlTBu47qU71RIX0khmF9+pmgngo9Nn2+9D7DxIv+ceaX5I4
 zvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=PYrVIC/FurzBuxniUjuP52UXuymUgdhcpGxmiAYpqow=;
 fh=uHsInzl9zV3RMtTep5HATHFWXDawVrBpmXDlZsDBuQY=;
 b=A2RnXUd+RI9fymDK7jFYVgcCEZaF2cyRygfL3dviWFwO+2uQ3SvYgaNjkt/IdE4H8R
 NrtwqlcxVWPkgED30yIRKzvfyRbKiS3xohMC2FQLow0eDqUKFsxB+KRK03qOFE82i5KV
 Qggr0afjus5c18KcYILAXZSf0MiFOccsRXcWEH0CMDE2+GyR+c99y7XayDWGJxjoDh5p
 xdwhGwg1whNoYDYHfb6W02xeK+1oTTh+4ueZOIMhqQm7FxG2O4InyOo/I/ujullPY8+L
 7eAOk9wAYuhnrffxrHnlMICQ+tMMwrK1KEjuOdJLvpftC+AOZsxYf2X9c1oVps1A7qbm
 G1Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792504617; x=1793109417; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PYrVIC/FurzBuxniUjuP52UXuymUgdhcpGxmiAYpqow=;
 b=kLoptXIdx8efPV21/DMIxlEr/bAVN7ikbXuTWKgcWrYgveJMERK80yVPUeOLhxlkAo
 5zeOS+hUwZztB09FiDztvRsDY7+Uzo5yC7VpQEC+IOcDStcpa+UB/Z9BmUbEMzSXdBBK
 RtF5WTiPLAznU9by9zSayPajK8zMm+bO7n35RBHwb8XB4nSBJEJF6T4YWB0mTkXgUW0o
 c5Qt5aUgT42haMsO1r7C2R05/9+GL7QOcDZjSwUBJbI2sqvRX/S6LVMDARt3CWUnuIb5
 U8e0LkcpmweRKVcaW3kpbgZhxzT0ffsxwMAB+NuyrL4gpdWSK4zG9lte63SajTrwhayi
 PhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504617; x=1793109417;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PYrVIC/FurzBuxniUjuP52UXuymUgdhcpGxmiAYpqow=;
 b=u3MHwxEHwOZGKS+EItyAXUpsF9zJdcRSYwYqK3HpQqvaGxJMJOBItBAgujO0Cyah5Z
 wXzlxIspoJpm+wGpEwtr/aymp16HKaUQT9fkeKaUJH04+WEz+MnsHwEaLVbj7X7zPMu/
 zo9LpC5G1PevmHzPr8Z3x4HHS+7JS52QWRIPT9E0B29pKC42sEd8f0NWEOaWqCHgIvvY
 54RQ3EFJBZiOC0cCCcBI+N2Z7EnvFxsVNDO0Z3EQ8OBoWUd4+jtjX7sn1Y+UwT7k5cAP
 D/05evHuRnT+RE0Maf7aTpCh25/Eg2/ncsRkhtjKR0j2IVE9uidEkdkhYskcMvyydYs8
 opbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSw3Bd8CNGhbrdGnhyMpXRneGR1GF1aDCF/kS9WESVW1uOAL8hKZXCFuGbK9IapaNhQd3qPN11YDz3@nongnu.org
X-Gm-Message-State: AFq9FYKveMFO31NlhYCKFSGLcc4YYJyEZsMvOtPOQR1jRyeuBizSdAHx
 v5l/VzzTag8YIoihIaobZedKfqlQK54e+oqnH4dIMhvspzGKC4lpktpdgfCvQ0sHs8+oTUPZ878
 vKCyoA88yXC6hMwGG16JUmGlTcra2So8=
X-Gm-Gg: AYBFou0wCeb9R/qQi8jIqnhCEoWOcfU6XwGIB1HB35JeFiPNUiRfD8cN/5FlZ+T5u3q
 KOMwBYs4tb3Cqm7W5jT2lN27cF6ZcPPaIl6g/PwU8YQBctgYabevzl+lM9uDZqjbSoEhw03LtRG
 34YexWQzuAEaFxsow3cvulm3GPaODl7qXTlKWZgVxNTY21oEpmwJ3vbWLfPhRGF8edlcGw1NimZ
 qqRooDbmmH0OXYXWEQomaZZIeQTSHVWcqgHuHLVeAL2/H8jt8GEmWnlqZJqbmiumdQ0F5mi73tv
 VimXxpazPHt0NZEXVTHfdjYAfBiNOl19Z6BJFz/9xNySJN8vUxK+mRbtKV9VAj85Ob7sbJZaU+y
 HDcJpLPmH5wor1ArxKGpbcye3RJZrSvmfKrlKJVo=
X-Received: by 2002:a05:6820:1c87:b0:708:95ad:6777 with SMTP id
 006d021491bc7-70895ad691cmr430196eaf.21.1792504617181; Tue, 20 Oct 2026
 06:56:57 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 08:56:56 -0500
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 06:56:55 -0700
From: Marcelo Manzo <marcelomanzo@gmail.com>
In-Reply-To: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
References: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 08:56:56 -0500
X-Gm-Features: AclHuK_NWJ12iseKrcoe_wWJEXmro4aWS5iA0HX6lYcjnre-Ar8fIXuDwNKs504
Message-ID: <CAGaQod+sDwsjEYt54U-ac7vEcdKEtSdvqy4SxUx01xe4DA9Jiw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
To: jamin_lin@aspeedtech.com
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, clg@kaod.org, 
 kane_chen@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 troy_lee@aspeedtech.com, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f7251f065e460012"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=marcelomanzo@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f7251f065e460012
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marcelo Manzo <marcelomanzo@gmail.com>
Tested-by: Marcelo Manzo <marcelomanzo@gmail.com>

Looks right to me: it sets the flag where designware.c does, once an
Aspeed RC is actually realized.

I tested it. On raspi4b a qemu-xhci on pcie.1 now ends up with
msix=3Doff, so it falls back to INTx; without the patch it is msix=3Dauto
and MSI-X is wrongly enabled. On ast2700-evb a qemu-xhci on each of its
PCIe buses (pcie.0-2, pcie.rc0-2) still gets msix=3Dauto, so MSI-X is
still available where an Aspeed RC is present. I have not run the
ast2700 functional tests.

Thanks for the quick fix.

On Mon, Oct 19, 2026 11:38 PM, Jamin Lin <jamin_lin@aspeedtech.com> wrote:

> The ASPEED PCIe class may be registered for machines that do not
> instantiate a PCIe root complex. Updating the global msi_nonbroken
> flag from class_init() therefore affects unrelated machines.
>
> Defer the update to the per-device realize handler, so the flag
> changes only when an ASPEED PCIe root complex is actually
> instantiated.
>
> Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
> Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space
> and host bridge")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/pci-host/aspeed_pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index b46eb74234..ceb010f213 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev,
> Error **errp)
>      g_autofree char *dram_alias_name =3D NULL;
>      g_autofree char *root_bus_name =3D NULL;
>
> +    msi_nonbroken =3D true;
> +
>      /* PCI configuration space */
>      pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
>      sysbus_init_mmio(sbd, &pex->mmio);
> @@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass
> *klass, const void *data)
>
>      hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;
>      device_class_set_props(dc, aspeed_pcie_rc_props);
> -
> -    msi_nonbroken =3D true;
>  }
>
>  /*
> --
> 2.43.0
>

--000000000000f7251f065e460012
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Reviewed-by: Marcelo Manzo &lt;<a href=3D"mai=
lto:marcelomanzo@gmail.com">marcelomanzo@gmail.com</a>&gt;<br>Tested-by: Ma=
rcelo Manzo &lt;<a href=3D"mailto:marcelomanzo@gmail.com">marcelomanzo@gmai=
l.com</a>&gt;<br><br>Looks right to me: it sets the flag where designware.c=
 does, once an<br>Aspeed RC is actually realized.<br><br>I tested it. On ra=
spi4b a qemu-xhci on pcie.1 now ends up with<br>msix=3Doff, so it falls bac=
k to INTx; without the patch it is msix=3Dauto<br>and MSI-X is wrongly enab=
led. On ast2700-evb a qemu-xhci on each of its<br>PCIe buses (pcie.0-2, pci=
e.rc0-2) still gets msix=3Dauto, so MSI-X is<br>still available where an As=
peed RC is present. I have not run the<br>ast2700 functional tests.<br><br>=
Thanks for the quick fix.<br></div></body></html><br><div class=3D"gmail_ex=
tra"><div>On Mon, Oct 19, 2026 11:38 PM, Jamin Lin &lt;<a href=3D"mailto:ja=
min_lin@aspeedtech.com">jamin_lin@aspeedtech.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">The ASPEED PCIe class may be registered for machines=
 that do not<br>
instantiate a PCIe root complex. Updating the global msi_nonbroken<br>
flag from class_init() therefore affects unrelated machines.<br>
<br>
Defer the update to the per-device realize handler, so the flag<br>
changes only when an ASPEED PCIe root complex is actually<br>
instantiated.<br>
<br>
Reported-by: Marcelo Manzo &lt;<a href=3D"mailto:marcelomanzo@gmail.com" ta=
rget=3D"_blank">marcelomanzo@gmail.com</a>&gt;<br>
Fixes: f002aa35f320 (&quot;hw/pci-host/aspeed: Add AST2600 PCIe config spac=
e and host bridge&quot;)<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.q=
ualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Jamin Lin &lt;<a href=3D"mailto:jamin_lin@aspeedtech.com" ta=
rget=3D"_blank">jamin_lin@aspeedtech.com</a>&gt;<br>
---<br>
=C2=A0hw/pci-host/aspeed_pcie.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c<br>
index b46eb74234..ceb010f213 100644<br>
--- a/hw/pci-host/aspeed_pcie.c<br>
+++ b/hw/pci-host/aspeed_pcie.c<br>
@@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceS<wbr>tate *de=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *dram_alias_name =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *root_bus_name =3D NULL;<br>
<br>
+=C2=A0 =C2=A0 msi_nonbroken =3D true;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* PCI configuration space */<br>
=C2=A0 =C2=A0 =C2=A0pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_mmio(sbd, &amp;pex-&gt;mmio);<br>
@@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(Obje<wbr>ctClass =
*klass, const void *data)<br>
<br>
=C2=A0 =C2=A0 =C2=A0hc-&gt;root_bus_path =3D aspeed_pcie_rc_root_bus_path;<=
br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, aspeed_pcie_rc_props);<br>
-<br>
-=C2=A0 =C2=A0 msi_nonbroken =3D true;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
-- <br>
2.43.0<br>
</blockquote></div></div>

--000000000000f7251f065e460012--

