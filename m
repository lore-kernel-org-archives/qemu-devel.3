Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80749CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xmr-00047K-Ux; Wed, 15 Oct 2025 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1v8xmp-00046l-RC; Wed, 15 Oct 2025 05:27:12 -0400
Received: from mx08-0090a401.pphosted.com ([66.159.246.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1v8xmj-0000tv-DG; Wed, 15 Oct 2025 05:27:11 -0400
Received: from pps.filterd (m0463075.ppops.net [127.0.0.1])
 by mx08-0090a401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59F69Yb31694218; Wed, 15 Oct 2025 09:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beckhoff.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=mail2022r; bh=lCfGpgWQMQf/cHREgZrXPLL5
 89Dm7tevk+CJBBXtMkk=; b=UBSXJAcHL1lV0c0RUeSXxWYgZ8q65bHxi1bIdp5y
 HBTrpaf0afYLgHcBE0vAtQGnnLURRe8yYXk129+zCX2jP+LraH9FwN0G/DF83hQ8
 zwKpjGu+j1QfaJxktOe6yyG0IZZQJCWT10RRavaaLITkzqrAEGsoCjWBakCjgNxc
 RhzLzHJv9nyF3IT7W8y55oleX3hNAqt5EfvHWbF0FeYi4MNYjL2GeQAYtvTPi20R
 yMV+LwzhdfHTjCWC3fLB0VG5668kTKF4tqh1mOYlEPPN+YEoQyw0YfPmetkCyh6B
 ffY3ho9tK6ngXtsvTztYL6I1fPRx+ETna0ccHi85d+19Uw==
Received: from ex14.beckhoff.com ([62.159.14.12])
 by mx08-0090a401.pphosted.com (PPS) with ESMTPS id 49t2x68qv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 09:26:56 +0000 (GMT)
Received: from ex10.beckhoff.com (172.17.2.111) by ex14.beckhoff.com
 (172.17.3.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 11:26:54 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.2562.017; Wed, 15 Oct 2025 11:26:54 +0200
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>,
 =?utf-8?B?WWFubmljayBWb8OfZW4=?= <Y.Vossen@beckhoff.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 00/14] hw/arm: add Beckhoff CX7200 board
Thread-Topic: [PATCH v2 00/14] hw/arm: add Beckhoff CX7200 board
Thread-Index: AQHcDcMp+xUfgo4QkkKp5EpDCdpuJLRj4bEAgF9M8gA=
Date: Wed, 15 Oct 2025 09:26:54 +0000
Message-ID: <7851b91e797bfd2b4171fe32662f2c3c26902bb7.camel@beckhoff.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <CAFEAcA9y-0-Oe5beVObe+SZqmByRSOYkCaKM1FDjeo0jdxjjCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9y-0-Oe5beVObe+SZqmByRSOYkCaKM1FDjeo0jdxjjCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.128.174]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-Lw3VBhkrVBNiH2CrjPJQ"
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: S7rIG3LOyFr7CxRKuaTybodSyrd6LKPh
X-Proofpoint-GUID: S7rIG3LOyFr7CxRKuaTybodSyrd6LKPh
X-Authority-Analysis: v=2.4 cv=WfABqkhX c=1 sm=1 tr=0 ts=68ef68e1 cx=c_pps
 a=ZkhbYXbYXnnsONUOWLo3Bg==:117 a=ZkhbYXbYXnnsONUOWLo3Bg==:17
 a=xqWC_Br6kY4A:10 a=ErxAllwcpegA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=elej7QgOwMPcv-EOkUgA:9 a=QEXdDO2ut3YA:10
 a=10j73BITz0fXYFs0uoEA:9 a=FfaGCDsud1wA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MiBTYWx0ZWRfX+LJ+1DumgJ25
 a91cZrWr8BdSxGTSsPtk8o1kFqvgSVaChjOeZeFJStU18PwArbU8rwFRQk5aejZTtErG8IxketF
 /sQvTK5hsBJ5fQ4ojGEdPbt2xQazZzOgDM3W8vU4Sj9bsgaoHWleawSmLumONlVXp0sjHuebzUc
 YCSaJ8SDYq92UlZ+nLMm1yQBGgznLCpanB49oDl6nEx0g7lMSifKzK168/nh7RUwM4iktLKxbhc
 3NIVvnjIClUYNpE67Nj3kJRbJs99bZyD+DQp61Ho3FWoNKKDuEddLLS1VXME+Fq12DshsaK05z/
 odDO/VLX1bt3160x1u95J/Lv6EAEoh2kVEmCdyd0FFrJ1wElAj0OGMmoIR+su4HpvSrKoMDR8bu
 mjq2t/eQFEw+3yTWJEL7BdauahKNFg==
Received-SPF: pass client-ip=66.159.246.175;
 envelope-from=C.Koehne@beckhoff.com; helo=mx08-0090a401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--=-Lw3VBhkrVBNiH2CrjPJQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-15 at 19:06 +0100, Peter Maydell wrote:
> This patchset is on my list to review. As an initial request,
> for a new board could we have a test in tests/functional/
> please? This is basically a simple test that downloads
> a guest image from some public stable URL, runs it on QEMU,
> and checks for some output on the UART that indicates
> that it succeeded. (You can do more complex things like
> sending commands to the guest if you want/need to, but
> "does it basically boot" is the minimum bar here.)
> The other files in tests/functional/ should hopefully
> serve as examples you can pattern your test on.
>=20
> thanks
> -- PMM

At the moment, there's no image for this device publicly available. However=
,
we're working on it. We're going to add such a patch when there's a public
stable URL.


Best regards,
Corvin

--=-Lw3VBhkrVBNiH2CrjPJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmjvaN4ACgkQ2FTaVjFe
AmrYTw/+Lkg39YidNRblygTQ8Jiw9ezzMBIaWYe74W0n0kv+oOqaP5Y+hWgxHJnf
9rI3p9Hdex6YlWqSlqcjY9FUJcJUjL1yLb11G3DoGsWk14pCVnNgKZg6t/6OglZQ
c1MxO+WTKkar4Fkp2xSxbEjkoue4AjyVUCrDJWYOCkxKn4hZI+19muFOqBtpI7e7
AJ5I/PXobOry/FILe4eavLrj6BUTz1lzCl2Dndb/6haGrf7Ic2Fg76rgV4z60yvE
uvk+ORRfD0sHMcY26fVylElH7yHqnRXMgXQw8QOTetLG+CMxMadXEc/78592GOKO
kfx8ubInOXD4Dya7TuWU5ayanogYL/Y9pUKN+dDGspSsQGgF3sPWkuR+rjjYQ4PA
jL/R4Q6IcZOWN5xNQFLNGKvbp1Qe9C54uLp1k5up3/cmR5IDNf0CaBxbskz5j69X
xyPkHOvGGpw5Y4qYTgFFc8RL41800Er/+PS2Bi+IpswxAcCCrMHpnL+8DIPucVhg
uHK2Dak/8wFiOc3tPWJSjOWWyLhmoVhEx/Gn+Ft3daCjl0Oge17LxQvTPxVzRnw2
7ovX/UuMYzkEKxthG42cYYBgeLTWgPN8DvruXMjvbzfYinlGxs/V97bgN7hNcu9A
foX6M3c38GoXx6zj5bFGIR/TtkyJ2SAutip/k65LjcABleCLNIM=
=akyR
-----END PGP SIGNATURE-----

--=-Lw3VBhkrVBNiH2CrjPJQ--

