Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700ACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xiY-0008CD-Az; Wed, 15 Oct 2025 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1v8xiW-00089T-Nd; Wed, 15 Oct 2025 05:22:45 -0400
Received: from mx07-0090a401.pphosted.com ([66.159.244.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1v8xiM-0008Op-63; Wed, 15 Oct 2025 05:22:43 -0400
Received: from pps.filterd (m0463074.ppops.net [127.0.0.1])
 by mx07-0090a401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59F5mTBx3187626; Wed, 15 Oct 2025 09:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beckhoff.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=mail2022r; bh=23mQ5+KHilvkrloqgFyXRmee
 nufwLxpzXQnLdHKAPxA=; b=RDFgvCuLeEprAr3giXRU0L+XaIv2uQNSVUfuJZes
 zvAwz82XQs1Lgflccz2ySpdhqs7QEgYpjpAgZq2dxQh4/lQQ35JoTDcihwBJTxwC
 39OVakL1uDCI5bYp9Fb3IMvYIz0jiTTro4ZMYhgTAJRPQ+ada1XzA7wMDjaCbA1i
 uZJD1YxoVj+3MDF2g7CEY7ZVKq6GCeSMxciK4+XTWkdCKyQgb7bBoBLvU+BltfNI
 nyX77bu8ZlG0JjBpwNxDxIJnjRGwB9d0qPpnjRdlTDxyodJ9g4gI/lb93qMGWsBF
 xhQ+oUhLalY3CDmZAztudEaaprWh1hduh5+17quQUOsUsA==
Received: from ex13.beckhoff.com ([62.159.14.12])
 by mx07-0090a401.pphosted.com (PPS) with ESMTPS id 49sscv1c3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 09:22:16 +0000 (GMT)
Received: from ex10.beckhoff.com (172.17.2.111) by ex13.beckhoff.com
 (172.17.6.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 11:22:15 +0200
Received: from ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b]) by
 ex10.beckhoff.com ([fe80::ab7f:9a91:d220:441b%12]) with mapi id
 15.02.2562.017; Wed, 15 Oct 2025 11:22:15 +0200
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
Subject: Re: [PATCH v2 11/14] hw/misc: Add Beckhoff CCAT device
Thread-Topic: [PATCH v2 11/14] hw/misc: Add Beckhoff CCAT device
Thread-Index: AQHcDcMwea5IHvjMZUi/2YBy7YDE9rRqCH4AgFkk1wA=
Date: Wed, 15 Oct 2025 09:22:15 +0000
Message-ID: <b7a7ef984e81a2fb0ce2793f25d660caca67ab4f.camel@beckhoff.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-12-corvin.koehne@gmail.com>
 <CAFEAcA_VQgoym1_Nmw8iXyBS-ZQTvc+3FYQBTR7W0_Pxb3u=RQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_VQgoym1_Nmw8iXyBS-ZQTvc+3FYQBTR7W0_Pxb3u=RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.128.174]
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="=-mdoOgExWiFK4oLb+eFoy"
MIME-Version: 1.0
X-Proofpoint-GUID: jd67gIwbN8xcj7W04ekRgYEmJB0lfQRf
X-Authority-Analysis: v=2.4 cv=MMVtWcZl c=1 sm=1 tr=0 ts=68ef67c9 cx=c_pps
 a=ZkhbYXbYXnnsONUOWLo3Bg==:117 a=ZkhbYXbYXnnsONUOWLo3Bg==:17
 a=xqWC_Br6kY4A:10 a=ErxAllwcpegA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3dN-dAOnzxXYxHM_xGQA:9 a=QEXdDO2ut3YA:10
 a=g_xI4TjUgyBJa0J3FfUA:9 a=FfaGCDsud1wA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfX3C+UBcIH+FGE
 dlFmFwt7U6a9dUaqO2QJqvTrpEazbnWQnjuFIIYtS7E30FrzXLP69mmDhFu19ivtcYLKiGtraSW
 QghhGo8fI3QCCmnZlMS2BfxRPHpvuZ20WKP39k1XOcP25TWfdzbj0qyPzMpqigld02gAJdQaMuu
 XGEe0mV78JyJN8pyDGz61+4tP78vZvCo2p9eDoCgzbtaweTIoavDxaeic1uGVio+QylTJ6i+wzk
 C3iBTagyCyWtm/GBow7ZvJOtMMRUGVp8R+JEozLumqG7q/PjSaITJB40x5M9JdN0uyu37ANEQ6H
 rMAm+tDPwUsuwXKoQdWkHrPcJA2H2H+DtZXplKhref+46R6JmrDiZAQSc4+4H7vuEIT5zZZI8qY
 Dud425kIWj8HLfW5/YDF1e25ylZ57Q==
X-Proofpoint-ORIG-GUID: jd67gIwbN8xcj7W04ekRgYEmJB0lfQRf
Received-SPF: pass client-ip=66.159.244.62; envelope-from=C.Koehne@beckhoff.com;
 helo=mx07-0090a401.pphosted.com
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

--=-mdoOgExWiFK4oLb+eFoy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-19 at 17:03 +0100, Peter Maydell wrote:
> Is there a datasheet/manual for this device? The comment
> at the top of the file is a good place to put the URL to it.

Unfortunately, there's no publicly available manual so far. We're currently
trying to convince people to publish one. We're going to add the URL to the
comment when on is available.


Best regards,
Corvin

--=-mdoOgExWiFK4oLb+eFoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmjvZ8YACgkQ2FTaVjFe
AmpLgg//W5eC3qt/yguDkM6V9f9KE4thnud8WH0AINJlywJdWyRKaSezodEmp0nE
QaLgvE24gZvVsqZfc0YTF+ssSUQN4cqYbSgfYWM3eAZ5TxPP/7tDHdJbE4+3AGmQ
YYxDYIDjtBt8XhX0Gyo2kfWfv06Iowt5TCKQowW7pN48Yz5DFZJytGnviTR3nUmv
jSULePuriH9evHCOfL/y9m0+hZcew9IFVfkyigLRXZ+spdBvzx8KfzVd+neU1SR/
1zqgEnQbiBxTvXsLWo0TYsiUlT1e8Wukc5E6/FFnnVON2Cs0/vLdraBhSG1NZNgD
pB1no8uPcIFTb1u5o4Zgk0yWb94OXM+ZGhTZQAc4nwjjiy0cC+DgC2XLTiR1guWh
l/2/WtD+VHKgtd9oHw57j1s2jj7gya3TMJXQ7J05EQGXsnhHF2y6pJqNDP7umudV
nnwKKtMP6M+clEBjPhTdiQ3BIpxSLSO3ViG/02enHR4yRFDeqXIGGPIWtCYm7K5c
+ztVgvKOZZmxfMf/ibVnNXVCxsWEhhsQAUI7yIri+nkYLkvqDhiQTAHiSnfVIair
WOOGF8goNaCvF2VjN3w1zsXNRV+loITGWUdiY77LHo6sBiochHI51/GY1oyTKESi
IFqdnxzg+KimouYuJSSKI7OGMdrpmaHMqSJuSHCnkX9rBk6avFU=
=Sf0p
-----END PGP SIGNATURE-----

--=-mdoOgExWiFK4oLb+eFoy--

