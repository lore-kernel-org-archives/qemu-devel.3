Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734F3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsXi-0003so-7p; Mon, 18 May 2026 03:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wOsWt-0003Bz-80; Mon, 18 May 2026 03:36:49 -0400
Received: from mx07-0090a401.pphosted.com ([66.159.244.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1wOsWq-0001gq-QA; Mon, 18 May 2026 03:36:46 -0400
Received: from pps.filterd (m0463074.ppops.net [127.0.0.1])
 by mx07-0090a401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I5m7ws2203215; Mon, 18 May 2026 07:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beckhoff.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=mail2022r; bh=NXF3O1V7i0KJ8OrHyjw685/0
 H/6/Ky+sF/XADbpg4RQ=; b=bOxybrldpYSNpirkttDfVhhkUe1VRum04gy3ORd3
 kBFbEhGyHkCO+zmd9FA0ldb/R5ZsPtNyJXHA22zUO9tqSkxYKXUinA9Uiil+b2pn
 P1EBYYl+ah3f5NrakoqdUkt85ebRBzVP91Eyhv+8+PoJiCAT/VoQuwoc/ZoItsDL
 QrMg6BbhdEvK8SyhuvoKv6WYn1uJinlM7SK3HPFJjYW0LRRB/4/DrNnHIlcyEWAR
 wE9kQrPzsEw76ZwXM/oaVyUW6dZQGCC2yTXkANL2mHgOPMD42Al4g6V5pAiBvrA9
 cH7/lALUjk0uudungrhKmqDhDwVB6hRasZb9aY5X/VEOXA==
Received: from ex09.beckhoff.com ([62.159.14.12])
 by mx07-0090a401.pphosted.com (PPS) with ESMTPS id 4e760rsgh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 07:36:33 +0000 (GMT)
Received: from ex10.beckhoff.com (172.17.2.111) by ex09.beckhoff.com
 (172.17.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 09:36:33 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.2562.035; Mon, 18 May 2026 09:36:33 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?utf-8?B?WWFubmljayBWb8OfZW4=?= <Y.Vossen@beckhoff.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>
Subject: Re: [PATCH v6 15/15] docs/system/arm: Add support for Beckhoff CX7200
Thread-Topic: [PATCH v6 15/15] docs/system/arm: Add support for Beckhoff CX7200
Thread-Index: AQHc4scJQKrjf3Iwc0OYGlSYpEachrYOnV4AgAStpAA=
Date: Mon, 18 May 2026 07:36:33 +0000
Message-ID: <c14139567e6d7db69816d86cd193083658ef684b.camel@beckhoff.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-16-corvin.koehne@gmail.com>
 <CAFEAcA8aLT4LQZ1HaQtduZeWm9w+62bDaXmLetbnJQHN3xq3jg@mail.gmail.com>
In-Reply-To: <CAFEAcA8aLT4LQZ1HaQtduZeWm9w+62bDaXmLetbnJQHN3xq3jg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.129.38]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-aDc/qhe+YnBEi8+FDx+2"
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3MiBTYWx0ZWRfX/0Vk8fjleNSO
 HULUIus2aWFHhzc+uFDO+orEsI/bA80YA8bSaaIFHOamPLGgfltjd9PPMFA7e6qGjxkbXgs/RGd
 x9U8Cz9W8XMGtRYD+MhdMLSWZ10j2ET/W/JExKg4PKeeP7U6utiINhCtNxEo7ygKb+0DVxNKwvW
 MJfG0i9ocHpPO91/QD29TqTD55DTHsdhdnxk1NgYARXIsLshS70WZod19P+eD7MKXfrkErDsj52
 N+pk4XI9btlVeBxZ4o28qkdL5YKZthlbS5QIglCeMvArRXhlmQ+o8MR49geOTEXUdg0RhmGEp04
 /Rzgx3zdbpNh6EtfsXqPGH934qdL/2Sq8Mym1JgPTM6x4nHR8nlyMm5AH/HZStEQvNf4Go8cN+/
 yscNHGWWAPRrp09oKGVxyks6WNxa1WEnHwGEtJ8C1E4IkLL2zx+v6hZqMt2rdPb0tRQqncDA/zG
 RgTY0P89s8gkqf4rkGQ==
X-Authority-Analysis: v=2.4 cv=XIUAjwhE c=1 sm=1 tr=0 ts=6a0ac181 cx=c_pps
 a=ZkhbYXbYXnnsONUOWLo3Bg==:117 a=ZkhbYXbYXnnsONUOWLo3Bg==:17
 a=xqWC_Br6kY4A:10 a=zoJHxBl5aBcA:10 a=NGcC8JguVDcA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=a9bgyBvlNMQzFU9Z5g25:22 a=PpDwSNkculO1Pa3iPHCZ:22
 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=Cmw_MBCVAAAA:8 a=ghdlahQueheaTJ4_ZG0A:9
 a=QEXdDO2ut3YA:10 a=s2Jy__7ezXR0vfk6w2IA:9 a=FfaGCDsud1wA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=ZJSrCmYe3mwGoKZA4Vko:22
X-Proofpoint-GUID: yY33sRuaIOdRW8L-xX6KBmd9TnfB8MnV
X-Proofpoint-ORIG-GUID: yY33sRuaIOdRW8L-xX6KBmd9TnfB8MnV
Received-SPF: pass client-ip=66.159.244.62; envelope-from=C.Koehne@beckhoff.com;
 helo=mx07-0090a401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-aDc/qhe+YnBEi8+FDx+2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Fri, 2026-05-15 at 09:10 +0100, Peter Maydell wrote:
> On Wed, 13 May 2026 at 11:=E2=80=8A55, Corvin K=C3=B6hne <corvin.=E2=80=
=8Akoehne@=E2=80=8Agmail.=E2=80=8Acom>
> wrote: > > From: YannickV <Y.=E2=80=8AVossen@=E2=80=8Abeckhoff.=E2=80=8Ac=
om> > > This commit offers
> some documentation on the Beckhoff CX7200 > qemu emulation. > > Signed-of=
f-
> by:=E2=80=8A
> =C2=A0
> On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com>=
 wrote:
> >=20
> > From: YannickV <Y.Vossen@beckhoff.com>
> >=20
> > This commit offers some documentation on the Beckhoff CX7200
> > qemu emulation.
> >=20
> > Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
>=20
> I had review comments on this patch too:
> https://urldefense.com/v3/__https://patchew.org/QEMU/20251204093502.50582=
-1-corvin.koehne@gmail.com/20251204093502.50582-16-corvin.koehne@gmail.com/=
__;!!PlYMe_wG1g!gcagXIjFAwYeOUzFGLkUDNWeXWrymvnQXZphDz_zZ_0Epx0dqTmMXFlDLjw=
-CJhr3EZpHTwKBKRG4qgsBzyTxsBswg$
>=20
> Please don't just ignore code review and repost a series.
> If you disagree with the review or have a reason why you
> don't want to address it, that's fine -- we can have that
> discussion. But ignoring review silently is not a good idea.
>=20
> thanks
> -- PMM

Hi Peter,

sry, I somehow ended up pushing the old version again by accident. I've pos=
ted
v7 and it should address all open comments.


--=20
Best regards,
Corvin



This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments.
If you have received the e-mail in error, please inform me immediately by r=
eply e-mail and then delete this e-mail from your system. Thank you

Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben.
Sollten Sie die Mail versehentlich erhalten haben, teilen Sie mir dies bitt=
e umgehend per Antwort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann au=
s Ihrem System. Vielen Dank

Beckhoff Automation GmbH & Co. KG=20
Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany=20
Register court: Guetersloh HRA 7075

DisclaimerID:x9d5u140


--=-aDc/qhe+YnBEi8+FDx+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmoKwYAACgkQ2FTaVjFe
AmpJ1Q//dbk/z0QzD3tNx5PziIl5ug0qMQsCIpmtinNFI/StiGB1aCSob71P46V7
DBomfzhXsrVy3WFVFlFIV8/CqXIJhysZBDFEba/1VV9nWxRW9qufIueY5eyapT7p
ep2nl7kYBm4QytdJP4b49GA5oVnuEzKQIFm3y2D+cVj6O6aOifBu/y72Qiknryol
irzdJZQxUj4kNNoUQbAdPGig1v5juFnSnu6RpQWJCFoiG3BvxIUrfvxDFAs9NjPM
7cnvvhJXeSImdBsZCzdHbOT8gF0/REOORKIIRoUA5px4d9Lv+fO1uuCEEf5us/zk
xd0dPdOeqsvqd/5OT8Hq7F6A113UQyNWvBZ4eeq0hlnyoWnKl7et1D1uWRl5mSvW
xn7rAT0xIaxfG4d50Vc2aDkiuPp52GJHp9veNMt1Wd5WRZMb0/gbbTcUQy80qxj0
3ETewcRfk3t/BZ9VhkqPVoYCtXenEQYwlsI+ORZrhcwhFcPpBmiiKYFuxVfe98Ic
39BFNTrMlpS1c/WHS2Z63JrcSUf97a00GvXfXOpQwkQPztoDhErxR/v2YCWI/41r
PSMQris2UsiyhIBCbKSkXxwrsS08AkW9uq11B6ZgWeYxX9zLDRcz9p8hgLdv7FZS
AgVOIycEI56fr1q3/zzl0wi4XM4vT5itdlScew13+mnQ84rSmDg=
=cCro
-----END PGP SIGNATURE-----

--=-aDc/qhe+YnBEi8+FDx+2--

