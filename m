Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DEAC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 05:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSUkH-0008At-Ie; Fri, 20 Jun 2025 01:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkG-0008AW-DG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:00 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uSUkE-0005cT-2O
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1750399018; x=1781935018;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=i35fE2WutqNt2glzCKfqhsdbXNbFTNTcQVK3guxA8Ao=;
 b=JSZ6v0mVo5epzi7BBHE1qyD+OF0z+IxvSEb5cAArOFx2GD+eBf7nPl5J
 A5gM+07r1s9b9F/gxFHjuiCnhmMKjmzJ+nvM4X2bKwgVP3ywqrzWQxDix
 wiMRFLggfcQp1eA4QGq5+X353/Kiix1M+hx1FnsJYPvO2vV64daWNlGAZ
 G+CDERWIRXSD/HyvdyDGP2jG0eCaf8kkJd7G7+c3gn6BPRSi1dt5pGRLX
 CLQxvYt6tZtTRDrGu6wRcPyB+HAXXxIU1lRhRc/Ng/GybR+3c18fbl0iP
 mf3oFOz6E6vNk22qzRVwXn7oeicAXzgm3PulRXYldcaBuHMBMRLSSjSAC A==;
X-CSE-ConnectionGUID: YHt/HZazR7WYpS67HQ6SlA==
X-CSE-MsgGUID: aCR/qJWLTGGZ5Chn4yeL6g==
X-IronPort-AV: E=Sophos;i="6.16,250,1744063200"; d="scan'208";a="41190333"
X-MGA-submission: =?us-ascii?q?MDFsGwbfh+Z8sEZc+qCrkpV8syUKuRnRdPeO+R?=
 =?us-ascii?q?G85MZH8ZbqiS8iuprF2pdoBVlWOiagIdbVftLTzmUHKX60gt7RtIVInf?=
 =?us-ascii?q?vc/r1/cnl6ukpJDRt+myyzvmBMrwZ8JYxjfOmbTTnci0JmieZU7cqQGG?=
 =?us-ascii?q?uc60hqSOigdQxHQFuXDeDgrA=3D=3D?=
Received: from mail-francesouthazon11011042.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.42])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jun 2025 07:56:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua/zq0arggq2FctrngWZzNTrN8qHFXdL7yH05FqcY+v8NqV8LayjruOlKS7Nvm09cOvIUEha9RhPeGZgiXhdKcpTUC9QZFRtubTba9Y0N4wjIKeQVCS9YgpAmatvzVSXtrVtkBkNDGsKaMgOUm8khmCLHvsib2yIxmp03ae1o+hzkwfB96jCV8ynaJ2HBomV1g/RvSVUE0QkJf4u+XpYVM0JMGc6DFTwZqwvHs1VvUus/OW7+OyOXFrjNCjOTP61STGXkiPTqMKBvdkLvqdDz1XewLt6TmHYwcyodjDObYuFBIudFOnzfiLHfQ5TknPsUKLEoqWoPbOjRrL2A8VueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ucnt8tgdcaCBqV9Yz1sgCztiMr578Ephv7nyzCZpJ3Y=;
 b=myrM5pdrHu0I5wkC+5DEXIzd0rlkf110fHxWR1jTde/kKVAwQgpY3Iu/OGagigqZmHYU5IcK6VwEikUh3KxYBP05IgZaJToadIBvH2y6QOnqtOMjZQ9A1u8xOAeAooMjpOKDwXgcYvjqxSxZ53E4jUTE8PN/GKB9urGEP2vR6z+atSCnqB1HEORBAhQwTK2KFy0Jg3fVUT9B7ynI0gB7c7z2cKtasomEWZyjASpvwnIG5SJFjMcQfmILvt4N55W1g4ZaDAgmBrLrNRzaczyDi/EGDzWnRE4ByLBOzH0/dD4gDAYMzC/a47QU1vMsTW9bxBXWqcrNvqU6Wb+/6SOd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucnt8tgdcaCBqV9Yz1sgCztiMr578Ephv7nyzCZpJ3Y=;
 b=BDTkQLjXgjK5l7/qiHIJMMF5w309PTO9rNWdVTsNPkljd/ZXGXYxnPV3e362mwBBfFjRKwEOvtkgxQezAYVR4KFWqzDfzin4YS+wU7y8Woc2ATHNqmWGIijeUcDvdIci4XbpJn7o/DcNPLWAYplJO4o3xbvWQJKBgtnRQm0fFapXVbqTQzGnpjPNc9FSTaK7WJvdozJp8i1y/5hNrH2t3PxoRzdZ/dc+nouLaWxP+YSBmz4izKV8uOG2YIz8EaPK6tLWz+bsu/yRe3ZGaKxzOrmzk9HuogYcFJuyrpxMiUmbrGO52jqyYY9zqWV74ybhWfkvzYShtQ8QXuQ83l8VnQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9853.eurprd07.prod.outlook.com (2603:10a6:102:38d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 05:56:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 05:56:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Ethan MILON
 <ethan.milon@eviden.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Topic: [PATCH 0/2] Memory and PCI definitions for emulated ATS
Thread-Index: AQHb4agdcjvbOfmLQ0WiEyuqDfW1lA==
Date: Fri, 20 Jun 2025 05:56:49 +0000
Message-ID: <20250620055620.133027-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9853:EE_
x-ms-office365-filtering-correlation-id: 94037c37-fc7d-4a3f-ec50-08ddafbf3f98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?U6eIiPEvNfchi/mbvxFZNGOLb7ZZzANRYqnnXxRpAOM8Itepcr3t0D0XR0?=
 =?iso-8859-1?Q?rEfEy7VC8D6Na0wL1TfFspCVnzrSBe7qZLWWgfnk3KFRAKIb4HS949zPo7?=
 =?iso-8859-1?Q?BXE9Ns/Vo6fNgBIxhOAyESmVD2xSCReO1dFhDzjwu2+PHQm7KYXFPqAKJx?=
 =?iso-8859-1?Q?S8YvkbhjCY5JYF2hnIwD+svk/qc5UShGq1RM8GBr/tCVKbJF1YBZAqJ1FB?=
 =?iso-8859-1?Q?w4jbABz+KDjYdwTI9YFWiRDF8X8bKdmUIH1bRzgje5tZDr/oLQicGcXOvb?=
 =?iso-8859-1?Q?CWPQdiU5TvtymsLVIhZjjnCppFz1OtLwxCPrFmQxaNqv+G1xx/KvEZytU2?=
 =?iso-8859-1?Q?ZRfNCo4Zuuww/CDAaGt1IkBb/zrJtIXUpn3bVmWtZgD7LFLwk/ANNyt8Xh?=
 =?iso-8859-1?Q?eq4WSo1maiEW+nNv9V0nJU75WCJDFsNliifv+ev6y0s6U2kklEwrtYlstF?=
 =?iso-8859-1?Q?jpUanHAhvNJBsAv3FZgRigmp4yMHhUSqvMlJu+vKZpmdBxA0EyUCGmYWXD?=
 =?iso-8859-1?Q?N4N4lWFU9Ik8kghY3EvH5fjUNN04nANXGu+2WONEklhi+B+dzq5jPYUn8C?=
 =?iso-8859-1?Q?Npr4ObeNJeHHLwY8kFG9+sdZDmfKW2rdHuIZhw3rsG3gipDUBOKLuUid8P?=
 =?iso-8859-1?Q?+IVgLCikPa+jPs6dvol7DLphGrCQct55p6awyhkr7wh+NnIIf6smivxYrV?=
 =?iso-8859-1?Q?J2lcf4hGc19BKBkdjm2T9jXNjUUB5WyYzB2u0NzISptNn+llUZ056Rj3Ni?=
 =?iso-8859-1?Q?EitWuiVNdAp5QRdBCUAlvRGm2GEdrIya9rSvX6J7i2jEIDWRVt3nLkeBNk?=
 =?iso-8859-1?Q?yx8n0wyuI6XmVb0PQa1DktosMZNm2VtsicgNMMwpIu9SBeypUHzHKtf6gf?=
 =?iso-8859-1?Q?pk82/xKLe64N5As+S4svXk7OL/9cnZ7FD24BIvN7FzjfgZwWZXas6CcYmJ?=
 =?iso-8859-1?Q?BmpCS7C23uBEHg5zkvZKKsLizgiXalDSla2XptEvJw/5IMbYaR1oO/BpMJ?=
 =?iso-8859-1?Q?clRIHzJnrhtoz2bmcJVqM+uyBOFGqfNBg6mcXKTK/Y+nprClW5GW+WDzny?=
 =?iso-8859-1?Q?KNWLyx0PsduJXbv1GTOF1CVwd5iZn9RCC/Afv6cv+t3SvIwh+APlM37pH5?=
 =?iso-8859-1?Q?c/EZ/yqABDTqj2u+1MX4XHtoLjBQ5iKRIpcog5aadL/UbYhFI7zRCbDEXv?=
 =?iso-8859-1?Q?FS/fuKSAIXS9uzSyT2INDeWaTu8DAMlawk8WYJOf2WVNyenmaddN0Dagvf?=
 =?iso-8859-1?Q?IkbT2LjzCmwsjcRSIEomZsuyvxCyZDcj9p+vkIddX3bzAOj184ipru8Da0?=
 =?iso-8859-1?Q?aBEL+m1fH1qyIjmZWbVF1hnriWknXkwl/oJiTfi4t9+owUnIMoh9OGQQkN?=
 =?iso-8859-1?Q?m22VvUgcDOay0fn0Jih945tih7guD3CjFYUqoAXz2y5pXKj2eFSeVaRk4X?=
 =?iso-8859-1?Q?eRF6nmEVu8hMfoZhkaxIF1J1gJazsjLAvvbErjiW+XAdRC1ZnuIJt8Q6K2?=
 =?iso-8859-1?Q?OprVFJBoVVXTqIpiNZrCi3p46+GtSOjATbcURyia2aWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EhU984TPaeMts+HYSR5ZTt4v+9xrStYEAPf2iG0YivCbBfO/Xfn847TQhN?=
 =?iso-8859-1?Q?iT7ijPKjuDA5C+5QDOtgCBQQrEaEs9R4m72sfkf115SA8HmuweND9vmgGR?=
 =?iso-8859-1?Q?ud6hWezjFMd0vxU3wdU/oIJ7OXO+PWWaUvZVg1xM5EJlhfMDevSPZqYu4Q?=
 =?iso-8859-1?Q?IOEpD2qvUkGKsH+vD/hsEs7ra8m5EGk5UD9TIoWu4QLaR9D2GcRnXxw29J?=
 =?iso-8859-1?Q?EnIPXzvlHq6WYD43pZA7+53XvorxQzn2CZazPD2MPxU36i5Gk2mXTTk1Zq?=
 =?iso-8859-1?Q?F/fmVtlc6VRAJXCfFek847XZA7s4Tihl4L2tlpikx0cwBikuaS9TE2ID2N?=
 =?iso-8859-1?Q?GtZ3o7W/YxB7PckD6GjtwLm4z1LMDvCQrvgeGcR2f9o4Iy4iWi2qqjER+t?=
 =?iso-8859-1?Q?6rMInQXx7tEFiaHpe7i1eg1POzw31zaYZ0uexdUvZJzhIitfYbaAI7n99G?=
 =?iso-8859-1?Q?1yciOCSvbnGs2AFfrXlMsyGmKx+fylFtK7tkkq2QVxHEzi7PQBazIHLcsi?=
 =?iso-8859-1?Q?3ENflzXU1m9H4/tB41A5GOAhwG2770qE3D7uOLmoXQVqEiqZ/NaZZqp5mR?=
 =?iso-8859-1?Q?NpSok5Kw4GzFAdqWgTqJpEuBSQXjnlQj8PWd3l/kNIwJJQcgtrt8XVfrhn?=
 =?iso-8859-1?Q?4HkGi2qyRnypDtcBKCOhZxe0jx7eRVRCHrVsIrYgimQAD5zsQrYiCQC0ci?=
 =?iso-8859-1?Q?w5rDWd161TIpISLuf4AsaHZpy5sUcYIj4Uo40QqyOEinIOVp3UhG7DWgxa?=
 =?iso-8859-1?Q?iOpqj29QuhqQ+49ka5+AF3Id3MqEYxCmXGPq8GQWvAOMI/wHz9PbN84lKU?=
 =?iso-8859-1?Q?+bOO68k7rrA05wa8qi1JYkUzdOC/rVJNR3QZv6TAesStDPPNu19DfXBsM0?=
 =?iso-8859-1?Q?hyRv7rzBFdyNPMgoCWlGt9qxNurlP0aQRze3mYt5rxldnKJ3RT3LHpHN/L?=
 =?iso-8859-1?Q?8L/fUANelNqnYugEQh52jS582QAfHjYJ+moNaGpJJMXXAne3QmDu2E+hlz?=
 =?iso-8859-1?Q?FYgSpqOB5yH4NyhOa2FJMlSjm5e3XQNBfLCYaJ5qDAzngHsvTRBisoGR+C?=
 =?iso-8859-1?Q?CiIbzPXV3DGx5Ur/eeaK4iVY3xzwGLHgQ7ef/0XQt6L4TM0o5Z/CfxBMON?=
 =?iso-8859-1?Q?WFb4OPBL491KFugCT66abbfS6/T28VGscW0s4yKHfRIRenk7GeE9fbMu5a?=
 =?iso-8859-1?Q?/pR9H4J+NioJ8yDsdOwaE7vlFmeTb0hO45YdSssqucYVtaOLgbczmaLpCe?=
 =?iso-8859-1?Q?NsKopkXWE8vPltYkxiBn/vV+3YsWa80Y2aB0zLplMRGPuRlOOHG1Dlvkjx?=
 =?iso-8859-1?Q?q83mbmvn9ajUOenK3M224nG1aGzMFZaRj9ENgCqqV5CL3E/31YKObzKYKE?=
 =?iso-8859-1?Q?+cg2UHVhGpkD6Syvwi/rOoLAAfhH2rvtiRr5qMZP3T6fCOjxxfByu/njer?=
 =?iso-8859-1?Q?MA8CW2X00GBx0El/zYv2LDU0ACVet9dOHN6MtVWfIGIk97ApXChhTN3ati?=
 =?iso-8859-1?Q?X6gvS7ahRh5X6NFd4nDw82+xjMKx8DpsOOC1t9GcbHActRlmfjtlqlpvHd?=
 =?iso-8859-1?Q?5D4SMpFgp9DfToYbUg+rbC4zu2HXLi1kZaDGg9k07OXRkaqsMjFkpKv+6W?=
 =?iso-8859-1?Q?rQ4Kxt7k0rF85EWe5J5ETuxjwoOUvhk1GNaKp9tAcU68YTxDqL78yLqUGP?=
 =?iso-8859-1?Q?ucX7Smq9my/b7OiT4/o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94037c37-fc7d-4a3f-ec50-08ddafbf3f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:56:49.6729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzkJjnJhxdfkpnnfq4ZJhFD2qa98tCZir36ojNHrCBLvSIKo0DSx2exNRluqe8l7h6fbBgzhtzY2WcpW/g3/sx20Uag2stOPJx9VhGlEPmxNgPjywOY4wtWJ6lnVxj/d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9853
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This short series adds the 'address type' bit (concept from PCIe) to the
memory attributes and extends the IOMMUAccessFlags enum. This
will be required to implement ATS support for the virtual IOMMUs.

Address type: Field present in the PCIe R/W requests, it allows devices to
tell the IOMMU if the address provided in the request is physical or not.
In other words, it allows the devices to use a physical address obtained
via ATS and to prevent the IOMMU from trying to remap it on the fly.

Additional IOMMU access flags:
    - Execute Requested
    - Privileged Mode Requested
    - Global
    - Untranslated Only (cannot be used with 'Address type =3D translated')

Clement Mathieu--Drif (2):
  pci: Add a memory attribute for pre-translated DMA operations
  memory: Add permissions in IOMMUAccessFlags

 include/exec/memattrs.h |  3 +++
 include/hw/pci/pci.h    |  9 +++++++++
 include/system/memory.h | 23 +++++++++++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

--=20
2.49.0

