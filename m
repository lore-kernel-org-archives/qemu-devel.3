Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7456C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRxi-0004o1-R2; Fri, 07 Mar 2025 02:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tqRxY-0004g6-1S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:17:31 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tqRxV-0006Wc-VK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:17:27 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so930207a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741331844; x=1741936644; darn=nongnu.org;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QTjcFwXHc6bsybZYknv5TTqnf5tePZK1WicldArMe3Q=;
 b=Syzww8sGm4B2ao8PbsXwn7IdiwNdedAWDpdd/9Hf2fydVO4l+i2lUtmzBnxxuSstmg
 XxjXnY15JMfcQt0IOoqPndaJFk9ujZKbxcgNYOG6g1CClCVFjnZBLK4Rbdp5chtEr9Te
 +UxOrRK9qJ7oGPzo5yn0Y3KJ7Nn0XGS5oOdXi6d6iGLoXyHNfIC10DZCXysavZKM8TBj
 DipiTfAMhRy+MIGYlGrY6QR6vVX+U7DhTPR1GOol6wiUZEcB7n302APKjPFBKbs43UUR
 pRKfA6eRp0S75+w8ijcaWeh4alq+5OM4tbZcw8ZnAVJnhz2BxgWWHuu/4WNqYGYE5Jgo
 QFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741331844; x=1741936644;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTjcFwXHc6bsybZYknv5TTqnf5tePZK1WicldArMe3Q=;
 b=ZsUgbAgM1vjqlBTV/TeavYX9luP2RIxchsqWBtokOipuqmwkpq8IpPyHpZSXwXong4
 SUl1EPeBjZ21O2+7jqtnoU6XUnAc1XmdORIDG2zL0kJmSYCyodVb7BnZvlNwztKpQOPh
 rD/NJQJ4sVi0T2MoCj1+a9WlgJ46RMXRRzT0RTaOombCshtKeggoTZssVMa3C0JmuZyD
 VM4icHx4u8oY0cCTl+aoil9nRwdz3u/M3/YBMaUK6UAKv9WMXWS/fcEo9yA3IYpyaahz
 QijNq0N9sXpyF5sBnHk0IMYfawhUsLvZdBZvkwu3m+Ml/tP8Ol8Ozclte7g7zZ+3ela+
 r8Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfpnB9RHlD0mKVgIUcOX7LPLGKuJCfgsfJaIaVIR/HGPkBgZ4gcux1qeYhjrzhLf3a8lHavIsd7C/U@nongnu.org
X-Gm-Message-State: AOJu0Yz9yJVmBJ5ANSbY0/7zxr5lhwjUclR2UN3sfJGj4h44bRDTuTJc
 aK+5ZhDc7wwEDrCzGcjt9SXlbzxa88p9OXwRuA7ygIQ2N9BagOop
X-Gm-Gg: ASbGncuruqI37MAj4c81RXiBq2wG35mxBsXGPT8TGw+5jpiZMfo+dNvNYHJcoR8sejr
 1Nis5xr+kfCeNRzJuwpHldIz2goiJ77vgkjyZQ+pb1IrDMR16PscMAq5K8Dt2wnthB2NWEHIAne
 Y5vydME25Fj16BmQDtMV+jbZVZSHxAtZ5XW06P6KrL0kEWfuGAT68968pP86vWL31jTlDFAI9p9
 t16h/FIbjL7xGsrkinJ2AoHEW95mfAOvPDYI/eAX5ItJgR5aiKDoQEB8H2cCNdkZ5cXzBBLu4aE
 JupQWQ3tTAMnw+CbKLTPKdUJ746pu9HoytYxwrlNjf+doI4xuP2TR3S37rPjIPaYOjdTq+5YU0y
 LoE9tfhmCdEWJiBhP5Z2TJA==
X-Google-Smtp-Source: AGHT+IHl8Nyp4/yvgdigzK4PqE+PjNTTwsqaYwZpa4ThN+h7R+WHtk0tzSxqm2sHGmrVN/TFCS8fcA==
X-Received: by 2002:a17:907:7d8f:b0:ac1:fe23:7d43 with SMTP id
 a640c23a62f3a-ac2530200d3mr211129466b.51.1741331843370; 
 Thu, 06 Mar 2025 23:17:23 -0800 (PST)
Received: from ?IPv6:2001:9e8:dc11:d900:1aa3:f6d0:ad52:289c?
 ([2001:9e8:dc11:d900:1aa3:f6d0:ad52:289c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239482f46sm225948566b.39.2025.03.06.23.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 23:17:22 -0800 (PST)
Message-ID: <7d79db1f22cd9090bae75d6a155cd8849b86e4e4.camel@gmail.com>
Subject: Re: [PATCH v3 00/10] vfio/igd: Decoupling quirks with legacy mode
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>, Tomita Moeko
 <tomitamoeko@gmail.com>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org
Date: Fri, 07 Mar 2025 08:17:21 +0100
In-Reply-To: <20250306154930.7a3b1c16.alex.williamson@redhat.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
 <20250306154930.7a3b1c16.alex.williamson@redhat.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-rMMxl+T2FPY8gpap+ozs"
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x532.google.com
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


--=-rMMxl+T2FPY8gpap+ozs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-03-06 at 15:49 -0700, Alex Williamson wrote:
> On Fri,=C2=A0 7 Mar 2025 02:01:20 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>=20
> > This patchset intends to decouple existing quirks from legacy mode.
> > Currently all quirks depends on legacy mode (except x-igd-opregion),
> > which includes following conditions:
> > * Machine type is i440fx
> > * IGD device is at guest BDF 00:02.0
> > * VBIOS in ROM BAR or file
> > * VGA IO/MMIO ranges are claimed by IGD
> > * OpRegion
> > * Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
> >=20
> > If one of the condition is not met, the quirks will not be applied.
> > However, for recent generations, espcially Gen 11+ devices that removed
> > VBIOS support, not all the conditions are required. For example, on EFI=
-
> > based systems, VBIOS ROM is unnecessary, and VGA ranges are not used.
> >=20
> > To have better support on newer UEFI-based VMs, this patchset makes the
> > quirks independent of legacy mode. The BDSM and GGC register quirks are
> > applied to all supported IGD devices, new x-igd-lpc option for the LPC
> > bridge / Host bridge ID quirk is introduced for possible Q35 support.
> > It also prepares for supporting IGD passthrough when it is not primary
> > display later (kernel change will be merged in 6.15).
> >=20
> > To maintain backward compatbility with exising configuration, legacy
> > mode will automatically be enabled when:
> > * Machine type is i440fx
> > * IGD device is at guest BDF 00:02.0
> > If the legacy mode behavior is unwanted, option x-igd-legacy-mode=3Doff
> > is provided for users to disable it. Setting x-igd-legacy-mode=3Don che=
cks
> > if the condition above are met, and set up all the required quirks.
> >=20
> > The default value is x-igd-legacy-mode=3Dauto. When the above condition=
s
> > are all met, it acts as before and continues on any error. Otherwise it
> > is equivalent to x-igd-legacy-mode=3Doff.
> >=20
> > When x-igd-legacy-mode is set to on or off, QEMU will fail immediately
> > on error.
> >=20
> > The first 2 patches of this patchset was taken from a previous one,
> > details can be found at:
> > https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.co=
m/
> >=20
> > This patchest was mainly tested on Alder Lake UHD770, with Debian 12
> > (kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
> > 17.0.1081.
> >=20
> > Due to I caught COVID these days, I am unable to deliver the proposed
> > documentation update before QEMU 10.0 soft-freeze next week. Please hel=
p
> > decide whether to make this patch series in 10.0 or next release.
> >=20
> > Changelog:
> > v3:
> > * Use OnOffAuto for x-igd-legacy-mode option, default is auto, to keep
> > =C2=A0 current behavior.
> > * Added a new patch to solve the possible KVMGT/GVT-g fail.
> > Link:
> > https://lore.kernel.org/all/20250303175220.74917-1-tomitamoeko@gmail.co=
m/
>=20
> See comment on 07/ but otherwise works for me with GVT-d and GVT-g on
> my i7-7700:
>=20
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
>=20

Reviewed-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>


--=-rMMxl+T2FPY8gpap+ozs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmfKnYEACgkQ2FTaVjFe
Amo6DA//YBtof5TPc5KTAaZdmZbTjZFVgAI+rJXXKcT/MWkkVRo6M9taKwN/bHaN
cQ8NttWaAhMlW3vrQG2ffqVIJkKfsIJN0bZwBXBy1DMbJAzwCrwDkhZcjKTbtKSd
fbXC1xZsN+CVluXLppBgYNWwRNcELSUOH/8sQ4PUPOaPC1ud/DcKidi4kBgC+Ysv
rOPv+F7ouLClxH5+ttlj0Cv++uwvWVMGdemuLIyuO45Bdn9ES11WZaznUXfXgAPJ
Lzw71z8tvn4VGQfp/kxVgKxBulgBffxokNT78tXx+/f9RBszKazf5Fe3dpFQ4Wdd
5BkXiyvG1KKkPF9SyHXS6VOYJMMPpEH9Ag5w7wR5vU8OY+6tTv7U/BpvamBJzVMl
7eueOPHKk5dVhwnll/yWucWO8RgdAJG+rbdd8RBu2rZdkro93IPXtSL+wQKwwJx3
LXIH2lwUbDor+cA8vT4iBrPohLEYeVkzNYWDbzcHmPvWROB8NPP9EA6Tqtsge4b+
FRzMgjAPRbQ7vi8Z1f5PfXCyFnW+qh+pMdrryOHflSgR1NcuoidqmFRLvWfMiMn+
EZGMacCyoWgt6qkJK+JRq7cHUzTZ+lrvqpd0QAoDjklR2JnrP4i3APLuj1NdeLYD
km5aG3z5XK/hS0HlbqnimqOba39cWx7QlyyxdxAmqQpilklIx+g=
=Co4k
-----END PGP SIGNATURE-----

--=-rMMxl+T2FPY8gpap+ozs--

