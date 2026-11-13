Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD42606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhCyz4Us
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmmv-0005SH-Vr; Fri, 13 Nov 2026 03:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cmdetu@gmail.com>) id 1xRmmt-0005Rq-K8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:37:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cmdetu@gmail.com>) id 1xRmmr-00014F-8T
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:37:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-491971ac844so786433f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794559051; x=1795163851; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rEyrqUx/xxxQ5lo07gSbgAGBIjnLNn3NtT1HW+ucFPQ=;
 b=OhCyz4UsaYzSs0Qh2UcNBTLXIy59SzXkdLgtsBq69OTqAYY7AB/la4C3axP1f9DQdu
 2ZWzoLpIrDwFQGkpC65HVXNn7q7X8eIYfLeScz+JwpFz2DIA3q6a0hK3vTC+DYLXBfQ0
 pVfi1jzNiPT+vbcqlIUO6uBieUU1BTYCXeDrI5Eoj9MVWTpTsR/xW07Lt3HfYdGNFp/c
 Xc5poIhoKtitM7bi0fRNzZ5vNq01wPABNTGWmGg9fK37j19YS2bIrPWLJn0o1W709IYE
 o3o61pbqtLlHhVu1NXPSB3hV6gnu1q/EUVfa0ZzXQxwYcF7wjizQb7WROQ7fJG002soF
 +2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559051; x=1795163851;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rEyrqUx/xxxQ5lo07gSbgAGBIjnLNn3NtT1HW+ucFPQ=;
 b=1qFuZWbG/JVhwH6iQLo/rPZoFku5Oq7ayKnE9LH1EKNAU+WlJYmiJK4vgp3wLwijLY
 OHZZlTPvunXdc2zfR89HLU8ok9yoJmrmYgMeEqaH0rEb7F3VcGxO8vYPSA8ZbIwgnK9T
 w3DQj2VB9xlcPB62TmYpzjKIMgBln7+HVQrs1dBbyDJ74vnQcJ3cMDXw65hTuQcDrhn5
 X5KSr0kLNrar2JS9xk+9PkA0hcTzXSWfsO/8W7aWKsgll25Uk+2+zBHoRujgSOdm3x5e
 KbYAc1a/8XyC8OV2FGL0M9bBDsx2alTYKmkdrLLxfk/uyxZCjzI6qRmh18/7vvYvOdC9
 MElQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH6vFN5UyLyBrGTmF2wWibYiJ/c1HCuydUWfqkl0kA3NHfjDcRI50DWq8S+1Cr18sjJWAO2CYPwrjdo@nongnu.org
X-Gm-Message-State: APuU4Z8KeJZ6HocGS3/xvOnUw6WqN+6OMJM1bWW9czvt9kZY6KrB9YX5
 lO07gYMqoYjiUzOh+z+p63rrE5holKnKCJ/pmcjBrXK6WTEwOdVK3WKj
X-Gm-Gg: AYBFou1gR/AF8I0FbcS2rH7I3yzTVBx+xzCaGMjzn8GiP6V1y80IHj0t2KlVLRuU3E7
 d1OI0nqcp0Gn9x5CfnzLr5pMuN/Iy3tB1FDqo/QfhW4+eU73CKjyYVGQyOzdqpXVJWvI3d0HK4D
 dwjoLD7rFXDaYSRQ09/iwY0QCP+XMlcMFXZdlAlGdVyDyGjs4v5CJ4+lqPLlOMRJRfCuxQC6p1d
 ux301C5mBIlo8XilWZnb0xMPM2cNWCj2WsnCUyKAZ8nwwHgYZfxOdHsOkk1V6ALNXSrFCPXrSEO
 gozWMGIKLhbl82KiEXjzmBH9mqncr4dRnUtLI6z4+Jc6mUX3kQekjCatyf7kVQVP2cOD/eVU86v
 zGCFdIL+OgBaxax4zpx9jHoYRDAkFqkLijFnRlq+wWRPnD/ZjdKvIioBSRGXXRAMqM4Rro0WGAI
 OF+2Bgvpawh9M8d5wc5PFYDjmr4gdigms5/3qxfIhgoXAIcbceEbL1yWh1SDuVTf31YYKxJ/dFh
 PtUfzRQpjfPUHVGuWSv38jqhxrUDWQTRy4kcGbTzbErC2z/V5g6W7NG2If6shZHMEgPAXu1wbfV
 WqUsq2sF9PFzkyVbrIZKw2pjYw==
X-Received: by 2002:a5d:5d88:0:b0:48b:1296:52ec with SMTP id
 ffacd0b85a97d-49c70ed8eaamr4421261f8f.18.1794559050553; 
 Fri, 13 Nov 2026 00:37:30 -0800 (PST)
Received: from [100.64.0.1] ([165.225.20.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm4413957f8f.11.2026.11.13.00.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:37:30 -0800 (PST)
Message-ID: <5b0b2f06aa2bd98f8284c3a3a45ccd0a9654d205.camel@gmail.com>
Subject: Re: [PATCH v3] intel_iommu: Keep PASID cache consistent with PT
 fast path
From: Clement Mathieu--Drif <cmdetu@gmail.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowangio@gmail.com, yi.l.liu@intel.com
Date: Fri, 13 Nov 2026 09:37:29 +0100
In-Reply-To: <20261112081509.442872-1-zhenzhong.duan@intel.com>
References: <20261112081509.442872-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cmdetu@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhenzhong,

Sending this from another address because of microsoft's outage.

Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Thanks

On Thu, 2026-11-12 at 16:15 +0800, Zhenzhong Duan wrote:
> Caution: External email. Do not open attachments or click links, unless t=
his email comes from a known sender and you know the content is safe.
>=20
>=20
> With caching mode disabled, a guest can install a scalable-mode =20
> pass-through PASID entry without issuing a PASID-cache invalidation. The =
=20
> first DMA enables the PT fast path, but leaves QEMU's PASID cache invalid=
.
>=20
> When the guest tears down that entry to switch back to a DMA domain, the =
=20
> invalidation handler sees both a non-present guest entry and an invalid =
=20
> cached entry and returns without re-enabling the IOMMU memory region. =
=20
> Subsequent DMA therefore continues to bypass translation.
>=20
> The issue can be reproduced with an emulated device in scalable mode =20
> with caching-mode=3Doff:
>=20
> 1. Unbind the guest device driver and change the group's type to =20
> =C2=A0=C2=A0 identity through /sys/kernel/iommu_groups/<group>/type. =20
> 2. Rebind the driver and issue a DMA write. =20
> 3. Unbind the driver, change the group's type back to DMA-FQ, and =20
> =C2=A0=C2=A0 rebind the driver. =20
> 4. Issue another DMA write using an IOVA mapped to a different GPA.
>=20
> The second write incorrectly bypasses translation instead of reaching =
=20
> the mapped GPA.
>=20
> Save the PASID entry when enabling the scalable-mode PT fast path so =20
> teardown invalidation can restore the IOMMU address space. Return after =
=20
> handling a non-present entry, and refresh the cached entry when a present=
 =20
> entry changes, pass vtd_as to vtd_try_enable_pt_fast_path() instead of =
=20
> pick it from PASID 0.
>=20
> Opportunistically clarify the invalidation modes in the fast-path comment=
 =20
> and merge trace event vtd_translate_pt and vtd_pt_enable_fast_path into =
=20
> vtd_fast_path_translate_pt.
>=20
> Fixes: c9cf33075a4c ("intel_iommu: Fix DMA failure when guest switches IO=
MMU domain") =20
> Reported-by: Clement Mathieu--Drif <[clement.mathieu--drif@bull.com](mail=
to:clement.mathieu--drif@bull.com)> =20
> Signed-off-by: Zhenzhong Duan <[zhenzhong.duan@intel.com](mailto:zhenzhon=
g.duan@intel.com)> =20
> Tested-by: Clement Mathieu--Drif <[clement.mathieu--drif@bull.com](mailto=
:clement.mathieu--drif@bull.com)> =20
> --- =20
> v3: =20
> - introduce a new helper vtd_try_enable_pt_fast_path (Clement) =20
> v2: =20
> - move "VTDPASIDCacheEntry *pc_entry" in the branch it is used (Clement)
>=20
> =C2=A0hw/i386/intel_iommu.c | 62 ++++++++++++++++++++++++----------------=
--- =20
> =C2=A0hw/i386/trace-events=C2=A0 |=C2=A0 3 +-- =20
> =C2=A02 files changed, 35 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c =20
> index b7da5d086d..a5ff89a11a 100644 =20
> --- a/hw/i386/intel_iommu.c =20
> +++ b/hw/i386/intel_iommu.c =20
> @@ -1649,7 +1649,7 @@ static int vtd_address_space_sync(VTDAddressSpace *=
vtd_as) =20
> =C2=A0 * or second stage translation, it depends on PGTT setting. =20
> =C2=A0 */ =20
> =C2=A0static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry =
*ce, =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pasid) =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pasid, VTDPASIDEntry *pasid_entr=
y) =20
> =C2=A0{ =20
> =C2=A0=C2=A0=C2=A0=C2=A0 VTDPASIDEntry pe; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
> @@ -1663,6 +1663,11 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s,=
 VTDContextEntry *ce, =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */ =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return false; =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> + =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pasid_entry) { =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pasi=
d_entry =3D pe; =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> + =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vtd_pe_pgtt_is_pt=
(&pe); =20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> @@ -1689,7 +1694,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as) =
=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0 return vtd_dev_pt_enabled(s, &ce, as->pasid); =20
> +=C2=A0=C2=A0=C2=A0 return vtd_dev_pt_enabled(s, &ce, as->pasid, NULL); =
=20
> =C2=A0}
>=20
> =C2=A0/* Return whether the device is using IOMMU translation. */ =20
> @@ -1701,8 +1706,8 @@ static bool vtd_switch_address_space(VTDAddressSpac=
e *as) =20
> =C2=A0=C2=A0=C2=A0=C2=A0 assert(as);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 s =3D as->iommu_state; =20
> -=C2=A0=C2=A0=C2=A0 use_iommu =3D s->dmar_enabled && !vtd_as_pt_enabled(a=
s); =20
> =C2=A0=C2=A0=C2=A0=C2=A0 pt =3D s->dmar_enabled && vtd_as_pt_enabled(as);=
 =20
> +=C2=A0=C2=A0=C2=A0 use_iommu =3D s->dmar_enabled && !pt;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When guest enables scalable mode and set=
s up first stage page table, =20
> @@ -1887,23 +1892,34 @@ VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUStat=
e *s, uint16_t sid) =20
> =C2=A0=C2=A0=C2=A0=C2=A0 return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU=
_NO_PASID); =20
> =C2=A0}
>=20
> -static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_=
id) =20
> +static bool vtd_try_enable_pt_fast_path(IntelIOMMUState *s, =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 VTDAddressSpace *vtd_as, =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 VTDContextEntry *ce, uint32_t pasid) =20
> =C2=A0{ =20
> -=C2=A0=C2=A0=C2=A0 VTDAddressSpace *vtd_as; =20
> -=C2=A0=C2=A0=C2=A0 bool success =3D false; =20
> +=C2=A0=C2=A0=C2=A0 VTDPASIDEntry pe;
>=20
> -=C2=A0=C2=A0=C2=A0 vtd_as =3D vtd_get_as_by_sid(s, source_id); =20
> -=C2=A0=C2=A0=C2=A0 if (!vtd_as) { =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out; =20
> +=C2=A0=C2=A0=C2=A0 if (!vtd_dev_pt_enabled(s, ce, pasid, &pe)) { =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0 if (vtd_switch_address_space(vtd_as) =3D=3D false) { =
=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We switched off IOMMU regi=
on successfully. */ =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 success =3D true; =20
> +=C2=A0=C2=A0=C2=A0 /* =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * When this happens, it means firstly caching-m=
ode is not =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * enabled, and this is the first passthrough tr=
anslation for =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * the device. Let's enable the fast path for pa=
ssthrough. =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * When passthrough is disabled again for the de=
vice, we can =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * capture it via context-cache invalidation in =
legacy mode or =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * PASID-cache invalidation in scalable mode, th=
en the IOMMU =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 * region can be swapped back. =20
> +=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
> +=C2=A0=C2=A0=C2=A0 if (!vtd_switch_address_space(vtd_as) && s->root_scal=
able) { =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VTDPASIDCacheEntry *pc_entry =
=3D &vtd_as->pasid_cache_entry; =20
> + =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_entry->pasid_entry =3D pe;=
 =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_entry->valid =3D true; =
=20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -out: =20
> -=C2=A0=C2=A0=C2=A0 trace_vtd_pt_enable_fast_path(source_id, success); =
=20
> +=C2=A0=C2=A0=C2=A0 return true; =20
> =C2=A0}
>=20
> =C2=A0/* =20
> @@ -2167,23 +2183,12 @@ static bool vtd_do_iommu_translate(VTDAddressSpac=
e *vtd_as, PCIBus *bus, =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We don't need to translate for pass-thro=
ugh context entries. =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Also, let's ignore IOTLB caching as well=
 for PT devices. =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
> -=C2=A0=C2=A0=C2=A0 if (vtd_dev_pt_enabled(s, &ce, pasid)) { =20
> +=C2=A0=C2=A0=C2=A0 if (vtd_try_enable_pt_fast_path(s, vtd_as, &ce, pasid=
)) { =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->iova =3D addr & V=
TD_PAGE_MASK_4K; =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->translated_addr =
=3D entry->iova; =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->addr_mask =3D ~VT=
D_PAGE_MASK_4K; =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->perm =3D IOMMU_RW=
; =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vtd_translate_pt(source=
_id, entry->iova); =20
> - =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When this happens, it=
 means firstly caching-mode is not =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enabled, and this is =
the first passthrough translation for =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the device. Let's ena=
ble the fast path for passthrough. =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When passthrough is d=
isabled again for the device, we can =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * capture it via the co=
ntext entry invalidation, then the =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * IOMMU region can be s=
wapped back. =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vtd_pt_enable_fast_path(s, so=
urce_id); =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vtd_fast_path_translate=
_pt(source_id, entry->iova); =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vtd_iommu_unlock(s); =
=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 } =20
> @@ -3133,6 +3138,7 @@ static void vtd_pasid_cache_sync_locked(gpointer ke=
y, gpointer value, =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
vtd_address_space_unmap(vtd_as, n); =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vtd_switch_address_space=
(vtd_as); =20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* =20
> @@ -3158,11 +3164,11 @@ static void vtd_pasid_cache_sync_locked(gpointer =
key, gpointer value, =20
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!pc_entry->valid) { =20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_entry->pasid_entry =3D pe;=
 =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_entry->valid =3D true=
; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 } else if (!vtd_pasid_entry_compare(&pe, &pc_ent=
ry->pasid_entry)) { =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return; =20
> =C2=A0=C2=A0=C2=A0=C2=A0 } =20
> +=C2=A0=C2=A0=C2=A0 pc_entry->pasid_entry =3D pe;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 vtd_switch_address_space(vtd_as); =20
> =C2=A0=C2=A0=C2=A0=C2=A0 vtd_address_space_sync(vtd_as); =20
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events =20
> index 7bf4cddd38..3337a7e19c 100644 =20
> --- a/hw/i386/trace-events =20
> +++ b/hw/i386/trace-events =20
> @@ -47,8 +47,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "=
Page walk skip iova 0x%"P =20
> =C2=A0vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk=
 skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set" =20
> =C2=A0vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, boo=
l on) "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)" =
=20
> =C2=A0vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t =
iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64=
 =20
> -vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", io=
va 0x%"PRIx64 =20
> -vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIx16" %d"=
 =20
> +vtd_fast_path_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"P=
RIx16", iova 0x%"PRIx64 =20
> =C2=A0vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" da=
ta 0x%"PRIx64 =20
> =C2=A0vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0=
x%"PRIx64 =20
> =C2=A0vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%=
"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64 =20
> -- =20
> 2.52.0
>=20

