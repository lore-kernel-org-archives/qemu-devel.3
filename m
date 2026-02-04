Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0611E95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncTH-0004JS-HD; Wed, 04 Feb 2026 07:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncTF-0004IK-2W; Wed, 04 Feb 2026 07:59:01 -0500
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncTD-0004mN-Gs; Wed, 04 Feb 2026 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1770209936; x=1770814736; i=laurent@vivier.eu;
 bh=hhrJ5M/5x5wjTnQpCDgzYnQB6gAro4YmDfJIHh1t6Dg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OAgyxg6HR6CAZGc+TMhfzGt9W0QDondqBvY04veU3+Qs1c5ExLZtrMD4IzKO4ONr
 tYYCSNKupXoZDs4a5zCeZp9VZCdvVh67I4sQSojgAtEZMcoY42qYXY27wEftAF2jl
 jTv3MpPuUU+snikrXNsqQnNuPF0psqV3nf2y7s+8/y15Y5HrxCcySLUzxkL8wd84Z
 UkgKh5gi5gvHQzYzgvmGpLRAIZhc2WCRQ278TO4JJUZrOD3ExJnGw017cewfG50IC
 mZWxH+5E03W0KB6u1vkM9dC4wL8+LcInDbZPdZeV39MBW4hggk9pOCHNpeAte0iOW
 llz3B/okY9vgcqtGhw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MWBC8-1wK3b80Nfm-00SFqX; Wed, 04 Feb 2026 13:58:56 +0100
Message-ID: <1ce3095c-977e-4157-bd69-6f8da387946c@vivier.eu>
Date: Wed, 4 Feb 2026 13:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/usb/core.c: reorder usage and assertion of p->ep
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-5-heifetz@yandex-team.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260204075754.21078-5-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8QcoAJ/rzJDOZY48fWfdUhQqZp8RnSF8zB/xjrm2d5b7zpyDi/g
 tAJx1Gd3NXLOOn2iIviHLMtaOIU1zlPDnTW+Y4YNt9tD57vf6+6ynDxs+AKRngLBDWg5+hm
 XwAdfqVRlz6Ienwgje20XW07mnkP6WWinlE/h0pp4Ubm6aiISQL5Bz16Jsji5Kf8c3iJg8H
 vuED3ciekVWy1MOFwAqQQ==
UI-OutboundReport: notjunk:1;M01:P0:ezxFrIX18r4=;2Pf+O2eon+mIhLEOrLzEj1yVmGH
 lH3DT5/AtV8MtV29oN31kBfzCUJgm4CI8cAAn1H7Yp8tf0hYh2ez92HOvlJyAdH/B6pttNJ3F
 BA/5+ERtq0hGN521CNQfBRMngqGh8KDWPrQoGL383cSAEvrS2htvX3o/1hGfiIVO2cTnvXjQK
 BXUcWD7vF80xid0y+J6jLBoA+rVZQPQ1/tfsQig3VE5+oycA/rmecFoYLk2pHb+30v4nTwZaA
 RGu3gVGF0rmn2KeQcaIctnjuOSKM9vXv6JaWC/iCadUjkdEiWgj4gkYc17SVWyfWQpR2r3eHY
 F/t0KG43PSG5jj7lJJ7SskJ+Q4zAN6CGUsNtGfa44um74fSeEw4r3i/lJOVcwHnX8VI+ZszKn
 4FCGWfCvbuyIcByJpIlEci4eRbASXKuC6AYp/rwtxW+esQn7mbO8e2v1UI4QlJBDw6+BGJ967
 VG8Cf3H5OfJy8u5BYBhwjNP9tOkNdhd12mgNVxdyXZxZFDCp7c/tQ35gjZW/saFrubk61sybQ
 e1MupQL8mq4mHyLmSopwIorcfklm3mGnBEReYNviC6xVlC4AXRwWGP7ycnu+Ln9RogLYwHcv1
 eRWuD55/bJCpO+wq8qFFkFUT86npdOqbi26S/in6C3tE8s0uv7nNSzPdThOVFdH8oW4A2VjkI
 uLFknFAFZ/6HreIuwNA229kzbEQZY3r3EGw+9bGM0G6Ycwchv+JnmTfgD+T0Ttu4B0jTjSSxZ
 SXbD/+clATSNstmntk/W0kAbjvh+OtSzYPs9Oxe/ReVpqlAYrIMdp84umvZIdnt0ybWN0J18W
 IehwyzYnZix72VA/HCrH9iMvh1nxf/Hz9g7V4Ll81TbWi3SOqVv5gNncGNMUPKLKyOsH9LPyX
 bwVk9pWvIUDVLxOYaqRGnR6g/MXd+RhvoP1VPBbrhGiePL5tTt79w0lVnoW5xH3Vvfpl9KAS2
 fXi8WNZ5d82193xP0l1oxpYBp2jvb7smqNGUVfWN1tu5GqRDTD0/fHoTxiwITZXBX/bI3iB1G
 vTpSuE+ULd3OgJR6aB0EDgxeXse4r4DnmBBHwJutQaHGbMpEx8VQQLvFK22qVoT9nOQdzjlyo
 nc4MOcReRHlKMhk5/p9GtnpSWTDope+VHWRGxEbRxjIH4E+2kard+NA8ZPnh0FDbj8RLCDfZP
 dat1bTn1k8hMFZYP9mMe1fWVB5zgqr0kc9I24XMy+sGZhIsGh4dwXzPVUNYk+xm7sk1/7Qn8Q
 ftVVnkZ5fC2OZ38tBjg+88VYxPz4cxmxrjO3Upvb3f2QMPOF9Wq9ctw1cs0zT7CfTTpPDCd75
 7+jZ86Aq1K5/xAcQJXYEKlntAjC1ukRHNi4D9oSQVnpbovzF1G4qO8ygd6+JdhSmpof2gWn89
 RYWhfwvMSdM9FnuR5B8ES3oSPujn3/qpEzEfLenSmHbbBezThGJ38zy56kw47HemBC5xGX9lF
 2R9reoSIp+r1VjSOFjVh6oZfJ+y3u6qkItzqyT+cljywZ2gSogF0j+GY9aWQmmPbdofDcu5co
 xso42pkDTm+TcvbmHrZmSqt+PIsuOu5YkSrBpHy0jf+nVFaedh+RNiyMzqu16YBKlc0aC/il2
 NWeODVr7gdFv+LfEaq8QZ9ktIfpv6VNV2OlNh+S+BgLPFQLhLSb5IZf3iBVq6qnDPV5aVj5RO
 c31lDYSnF1B9Hvd1zSqRwUKxr5eP0kZSKQ9qA4gmPpZDNrinMOCP85FCm4tOJjcbpb65Jlzwz
 gfMvhUpG5M5igCcV6/HjRkq6RbDinKAb5iYQ2TsT1P8FDZYv9L3p/d+IE4lZyiUVh6NcZM+r0
 vuwv
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 04/02/2026 =C3=A0 08:57, Sergei Heifetz a =C3=A9crit=C2=A0:
> Reorder the code so the assertion of p->ep occurs before it is
> used in the subsequent lines.
>=20
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   hw/usb/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/core.c b/hw/usb/core.c
> index b3f811c513..9572a870cc 100644
> --- a/hw/usb/core.c
> +++ b/hw/usb/core.c
> @@ -423,10 +423,10 @@ void usb_handle_packet(USBDevice *dev, USBPacket *=
p)
>           p->status =3D USB_RET_NODEV;
>           return;
>       }
> +    assert(p->ep);
>       assert(dev =3D=3D p->ep->dev);
>       assert(dev->state =3D=3D USB_STATE_DEFAULT);
>       usb_packet_check_state(p, USB_PACKET_SETUP);
> -    assert(p->ep !=3D NULL);
>  =20
>       /* Submitting a new packet clears halt */
>       if (p->ep->halted) {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

