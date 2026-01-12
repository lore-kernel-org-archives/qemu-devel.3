Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013BDD25051
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDrS-0005aE-EB; Mon, 12 Jan 2026 04:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrM-0005Yf-Lt; Mon, 12 Jan 2026 04:05:12 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrK-0004wl-Rk; Mon, 12 Jan 2026 04:05:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzfBeWw7YGyBisUpzSuAXS04Khb21G4rr3xXzL/sb25pV/DZc4UML+lBWsrgjzrMD/Uhe5mztlH1jDxzWCX59ffEY9prJEC0IFHBthyc+VTf87ytN1qRHLZp8+PZn7WKSrhHN5U2TvOGwRh20me3KR/9JFd/adhTTsly+YO0P2uAIQg6lMMJWnGpOwCVAdbtouDwQ3iDf/v3+tm8Kdbj1atAv1NC8Nt+TVdJQ8wb1EBnPdzVCLkxvZo1a+tfu8a6xGgJkZigAyATjrIqLD/Pyi0123YHvPj/96PCjgY0X6Tceqm1jsLV89zI4MkvMjcf3BU0vWrr46wgDGUDlbNY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3FcV1OYIP5L7tELKdg0/y38lTsVXhF6DwCkTisv1Us=;
 b=h7cqYxDqQZaD3QdcZrJVL6PJgqzLX0f6fdXn3WxiKsL4VkO5WdrDoHoU5oelQRldhT29niPmcI60Jo3wCc7wmN6wNRN59//LIpfd4D9Ttm7LljDUc8OsRCjhjA1lr2S71y1L/ZenHO5KEjVIQnBvxr8m9R40JdvHntldlz8GekBRijyEngVjbiTp/W0Px57fB6brdHcJYrKWJ1woS191AxeOmj1AGZdAxokK3Nv2AXxpv4+QXIQCVOlC1O6pGFKCIZ6LugipYk/9KtLggGsNZU52GH1xY58ejePDuqnAz7C4u4OKi7K4RorvSNHzN64sbgN2TOKWlnhtcTuRfMVQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3FcV1OYIP5L7tELKdg0/y38lTsVXhF6DwCkTisv1Us=;
 b=E4AgTkwSrKtMdaGgQnHoIy7TRqoVrQ7QXcXp06vaFEQ+Xdr1dmRwYzcGM4Wj8CDBS0EL0n1BvgeC+VNFnwsElQxYftqlsvdfZp94Jbvo+opBvIOUkfSvcagCulBhU779YpcSnfeiVZ8TXvfBw4035dfPAiLjSWE2Q4RCFeR/1LLGzXbtZUVFWqYHRLqZL6pwhyx7mA+tD6JDAbWoREwvdnKxrhXcovp4b/sQg1RRgXDPBy1yP8ZmEpZZJdW3pTxiLDY9kAYI/Vm2DuMNbKAAmGuSwPI6CXFP+f3tQSk9G9Uom2O+zmCciJ9UvoXrBpkCVQtJBRdK8jSW0tXU5YzRyQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by MI3PR09MB8569.eurprd09.prod.outlook.com (2603:10a6:290:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:05:03 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:05:03 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v1 0/2] [riscv] Fix issues found by Coverity
Thread-Topic: [PATCH v1 0/2] [riscv] Fix issues found by Coverity
Thread-Index: AQHcg6KJrwXqDeSAsUG+uAu1//ONEg==
Date: Mon, 12 Jan 2026 09:05:03 +0000
Message-ID: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|MI3PR09MB8569:EE_
x-ms-office365-filtering-correlation-id: c6635afa-3a86-42ac-3a6d-08de51b9ac53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+UgUM0lHZJ55sOi8SgbtuHtCvBJDEHk0sUhT+D7N+yspLl6+B6KIgfQ+NO?=
 =?iso-8859-1?Q?DgHAzpiMq3/zAysGvuXFjrnoh1DX37KU37Hk2vN9Ri5cuG2iTD4CmGM1EG?=
 =?iso-8859-1?Q?T5gUtge3wof49XCmViHlgdzSqwu6LZBo/WFuWo0SLTa3Q1UTstOjcgrPbw?=
 =?iso-8859-1?Q?jzGARe9LRjuqkJZc9M2DJo6s/HaK/nFFR7BwTGImhZ8s01oOOM/yCbwUUL?=
 =?iso-8859-1?Q?2r/Q/Kz8otgB0dtXerteED5iGlzbFjuuiLaMmC2Ns0bpfK83F1U96bhQ04?=
 =?iso-8859-1?Q?o8Pn0y/iMzIRXbpws4bzrKVpENeBgtHY3ChLTcdaQXlM/kVyA9LwxHOdIE?=
 =?iso-8859-1?Q?js7+1+yC+6ETeWsmPB9wywaF29njxlhRSzzmLwNQF7DPt7Dk/rgq5hQEfa?=
 =?iso-8859-1?Q?Os7ba+1BBflxuhEvtMZqYFSWFZGhZCRAojNpCA4KQ3RbwMMo1wKCWBaZp8?=
 =?iso-8859-1?Q?T5MpP/gmt8/7kBdBuBlUec+dBlbKLuUAkT1bqZjMlWaj8qeamjUaijrEVD?=
 =?iso-8859-1?Q?sMDsD62lGxmmEIW0XARWZ1JcrcUuG861WYZ4beHeqfhJlDvOnht2ZAJSGJ?=
 =?iso-8859-1?Q?eAYgi5wY3zxQBlFyQJ6yyeikqQdY+JWu7lObyQAh+Q1N/a1O7G0v8hLnOf?=
 =?iso-8859-1?Q?0ejIVZzcR37AooSFGPfPjDi14FcCHyX4VawNOxk7ZzLG1Vhf9eS4MTUncW?=
 =?iso-8859-1?Q?RjvpiV5vgMY4eDQ5iOGLOfIuXnpo06Xua5nbpVn/JoY/TOVl8URRHHgaBZ?=
 =?iso-8859-1?Q?uRS0KzPuLmt1AJPD04yvybh0JPQaK2xs+GzKZUWD4XDjZqlY6i4SqAO2Hx?=
 =?iso-8859-1?Q?/iTecWFmTbV/cW1Xa7etZxaffOstvHwO+2cz50I0x1mekSgg5KMddWtokg?=
 =?iso-8859-1?Q?IS8RaJTISMmv0zxop5e76MfyXCgRIQNZLcOZxUT8mgdywSSzqTQo7AhTxu?=
 =?iso-8859-1?Q?b6Uv0k/xTbnlgnSyJ/GFh8exICoxF/kO7vvqCY7mhwd8PVKuj2oCA+J1RH?=
 =?iso-8859-1?Q?hTZsSLLWKKJiwdyvMsu5fzrI3+Mst7PhZkJXzgUASXdk2SZDD2h9863ZOn?=
 =?iso-8859-1?Q?fl65Yf13EvdC4mRIF7FzR4QZN8T+m9qR9tUrnyH3X02C1+vV3Aq9GbrmA6?=
 =?iso-8859-1?Q?h38dYDV22snV6/f6UBNEJX3HvReyIp/fQIXuEFOF8tiSfQsx/BXmo4VTOr?=
 =?iso-8859-1?Q?zNOd/4sAZPRMnciG5+9FffVp3lySdvp8KXGMEW/fCA5y9CxXbhXZLd4BvC?=
 =?iso-8859-1?Q?eH5QqAWK5BRvre4dbO75dL36PO4qBY1NLlNoyNYp2ogIxu4wuu5i0y7l0G?=
 =?iso-8859-1?Q?CfarzNR6dHaVWmtCPNTcsIqbs7kkZY5vteNdZsKRGzdDxRpzTHf+Rudgy9?=
 =?iso-8859-1?Q?otrkWAcgv08DsACkOdA6JFjRVtLXYJbRdsnTl3VpcdUGzpkjgzvxTHzmqz?=
 =?iso-8859-1?Q?XYb66fCxPsbrANYx/qMHV7yrrNQPHsDhg4PiQP8qAKVBXVXVCPP9vLeqbA?=
 =?iso-8859-1?Q?ij7FGvIupmCTZiu5be4qbpUsDD31UsVyaY+F7MpQLgEY9vQ5jkKrokRhMv?=
 =?iso-8859-1?Q?hMUl+1sbNj6QNoIbS1JqQJ/DtKoW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NRliC5xh6r/2myGb0OJSwfOwVYHFBDYKvQYvXc70ZNFoDkv4jNaMxyA7X3?=
 =?iso-8859-1?Q?JaHt3DU1eo6OIQuiLbda/7cArVQu5De+sJWJH26fTsV2DRlOIshOOWAIdb?=
 =?iso-8859-1?Q?gOijHm/dOTSt6PaC/tOcCD09/8+FVtJxirCT1cdIYv/OOc2B9w8mB4Me1V?=
 =?iso-8859-1?Q?RIkdbFjOhFUD24pgO12foBkcrgnnWLu4Cwkt+X1oOC2fB5FqQIa96QYLVK?=
 =?iso-8859-1?Q?aw4wHInxDkDl0s6j7knoVyCajOKirAUwAiu9PjFoY7qYgc/i/RIEc6Ocmk?=
 =?iso-8859-1?Q?gwaMgmzqUE3yjxPltCI67hRQj6K7mAk+aI/Errhvgh2ZootPnoL9WK0/IX?=
 =?iso-8859-1?Q?esHlrZMTcEcDxg1kUOoMa1bX2qYAwVASVL9K/a1JthbRBWr8KF7Vaoba1G?=
 =?iso-8859-1?Q?VFF2WiEg4yuju2vJ0NN5AOPglJTu4v/yr9daOkqiiPp9Zo4K+FVPt2ewRB?=
 =?iso-8859-1?Q?TywVArjf3AxusV6XriCMYX/89maSt8LcV+KTc8aKU/AF3q2drswVJ97F4W?=
 =?iso-8859-1?Q?S8PEt5D9J9Mr9BKbyOynIc2thhSmflEA2xZfdyW637eM7SMwLkOrT42UXT?=
 =?iso-8859-1?Q?eSUSK2SkJ1cdxJS0DDxtw6Ojx9bCrOEhJ80FeN2NmavGhfHeDAPcTyCsQN?=
 =?iso-8859-1?Q?hHLkQrVghmz4ELO7JUMVVhUZKLxuYTKW7mwP1R5DMEUxnYlU5TXd0AFSdp?=
 =?iso-8859-1?Q?onKwqoCZvmxuluG1WLfdf6lpoEsvzMEg/kZMPpwUoktBp0tGdDS+uuezEO?=
 =?iso-8859-1?Q?6NuetzeL7tSryNqH74sdg64fX6wAuiDaiBipFSxDzBqhVpW0Bp0QsdD7eF?=
 =?iso-8859-1?Q?M6N3HkL3M5B/jLN8OxCdEYDITWCczKTyOKe8ASnbaquvRGU0Uqv3/Q4bva?=
 =?iso-8859-1?Q?ku6dTZiQrFBMMUXCtGk7O5xRZF4culQ14SpWLuxNmRawKHE+gajLr0BdKi?=
 =?iso-8859-1?Q?P9xGpARfGh0NEUewZupyXpo/jKjGaDny4c/og7zM8GXOSobttSHS6HST8s?=
 =?iso-8859-1?Q?/7NgOx4UYOwNB41LWBO2iSSqniHuFfnz6jfLpGAADMC2SGDSvMWZ3NNN3E?=
 =?iso-8859-1?Q?BQTVaGHhjIfwvGcp5ALo/7vAiJOYNG6XwX/VHreazbPLoN7JNuKcX6FgnM?=
 =?iso-8859-1?Q?9pSV/Pv6V8Oe5v72aKAA8qui57m9pt+NAd/PM5Ahwmnw862ePdDf5tSjEM?=
 =?iso-8859-1?Q?5a8rjgV5h6kNK4L8lDORMbJDmYCBwXZpbWTatXogy0uwWuJRU9GGvrm+H+?=
 =?iso-8859-1?Q?AhSY0YlTAMpOTLPTcj7jL0fVwKbsi08hzO+UQKEaOA64KOZ9DTb12JQYCG?=
 =?iso-8859-1?Q?+tJsrteg8aUYv1OOsGe/GbQp1kzeKdthIMVuTCciKf8rRpKEEP3R3PdyWv?=
 =?iso-8859-1?Q?x4BIuqz1OS8NKIxPKQLPFxaz74wIPei1UbfuBGyxd6mB4/cylgbneYnvFT?=
 =?iso-8859-1?Q?HsMVXk8vENr5YvgPgC+I0E8B3QO4c8UT62rDvPHKvoV0fewZUwk5NMYbus?=
 =?iso-8859-1?Q?I2YdW3uONBzXObTU4crVbSvgCRMYFEhzVc6b2iPKykJmhAnV82HRdmDpfw?=
 =?iso-8859-1?Q?43+Gw537o6ez8283IWci5C3o+Y0eBBvp4fskQ4zv+6tsXhlGYR4VIAfngT?=
 =?iso-8859-1?Q?334fUEzIDuJs+utk0ItLDvG2y1wkXsOZ7k/b91muc6P7YlkgmwoQC3m7cZ?=
 =?iso-8859-1?Q?griCiYh7xN0aOGRA76EabHYsALaYUKR8GXuioue3MM1CEgd93an2NwUmKc?=
 =?iso-8859-1?Q?Gh2gRe+r4i3//uGuK9k2n6k1VIfAQF4cJAWU2RqitlvkQBn1pIyuLFTiIu?=
 =?iso-8859-1?Q?hmOriomc3Eph/n0b8hA1JrXBOcjV+pU3EvEAP266ifISd1h5AqUS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6635afa-3a86-42ac-3a6d-08de51b9ac53
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 09:05:03.5020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10lGdVrpO96sj3bfRuzjz+XOW+aUNqDWca9Q5WGAx4A1zrUeINhgJgWyKMWcu9MBvVLLUymCjORXmJbUJ5tedItI/dn33vt7URuM85m84Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR09MB8569
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

These 2 patches fix the issues detected by Coverity after
merging the patches for MIPS p8700.

Djordje Todorovic (2):
  hw/riscv: Fix integer overflow in cm_base calculation
  target/riscv: Fix null pointer dereference in cpu_set_exception_base

 hw/riscv/cps.c     | 2 +-
 target/riscv/cpu.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.34.1

