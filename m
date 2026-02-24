Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5138AEFB810
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLO-0002HN-3Q; Tue, 24 Feb 2026 01:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLE-0002G8-Cb; Tue, 24 Feb 2026 01:56:21 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLB-0005Lc-79; Tue, 24 Feb 2026 01:56:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAEHaDI8kpm4/HGd+RDHZ7XyW9XM6htT3kwGdOfwBcpWlnQoTxng/8xiidwzAN4nc9tRINvGTCm6N+DSYLhJP1Tw/xoImHJ5ni83TjYP07eK2dS7c91iWE+l7liYPqvjoJXvvRj15hmmVABPChMOK455J+Bm2u9HLW/a19th0MhuImLDdC3xikX4V8aZMIyr50qLmgxfgW/potAoiv3MfxyxeNXCQQmuINODZ6pjuEaejiblfPwBwG+YrpF6fZLInD2q0aar5pp4Slbcmw33N8LGKAvTteK2+X9QF5rM3D8TUbyZf7H7gHsT9s1z22Bf70ViVjdwHtDr4SicRMONCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqmJ5BhUNtDJOp4SSHbwMcipFI+5P65C4O9OgFToG9I=;
 b=R0qxSFFLF0nMY9YqnB3Sqiy6D2uxwXaPN7CIJHBp/d5jMCEgtgc/YTel9KJ+KuGbbLieoO2TbqNxZz6f6B7ajrr6MAseCwqnRO1CzQz+oueliPfUN8aC51njzihJnV2MD7yY7xa3/m8VUPk/AW1O6+hYRWUHIROzqTdoVIPWOnSaF5Ctu51Ct8RezaOlQSYn7RH+hX+IV0AYybuUe3ZW7MrdUHCTCpC6s7nspzSu7q55N5c916kDAdUQUs823zcFMm6REnCb6MrPC5Yps0mGRRAfJxISvHL/ImVDt0boK9Ixm8qoMrdSMQM8YFGXxLhT6Cso83h1vpuwcJq5t+AOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqmJ5BhUNtDJOp4SSHbwMcipFI+5P65C4O9OgFToG9I=;
 b=maGvMXuI3p9XHrW39g2jGHdmDSGSGTuQYX3ic50wdSGqINxGMpSTo9EvqwcavWDSIJjY48WRacRb5EqKd44RSq/APoYFhEozBf0hGj+9FiKn3UEMEEmkotODePfO2zMmlOgcz5gM/uT3lZ7hw+ixyoMwi7Gw0YhR6HHL7WmAunWde5UMMC60Kih99TCVDhlBA3t7SoFrXOuFWBzGiVb/e2H/J1Jqe611HuZVlgP8VsHEgqcYtnBRPvgwiDWPiB5/fkUj94i4BWihtGwDytLXOB6n2jwg0+g6hoELi0qko/RDL70yYibEKeCs1LdJet6YOv7TLweebWpmLO+OUCv2CA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:02 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 02/15] hw/arm/ast27x0: Start TSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v3 02/15] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
Thread-Index: AQHcpVqiVLYSkdVNSkSnId75G/vUww==
Date: Tue, 24 Feb 2026 06:56:00 +0000
Message-ID: <20260224065556.3847942-3-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: b13b72ba-b58c-40d1-f741-08de7371c617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eWbafFJTWAOFNG6sry1rQwrtjJqZdxVgXOUzjYbYR4js6sCDnOptcr8/54?=
 =?iso-8859-1?Q?4NlPXhjytWp5RqAHkkli8j+FcC1zLJBSkwlr/D+5/rvB2FfW7it0ZpFFVQ?=
 =?iso-8859-1?Q?HKEzFIXnWm1nnEwExIswWMnsvIFk4C9g6vKpt2L1xqNaP1rJjamVX++TVC?=
 =?iso-8859-1?Q?wbkMnTUgzNijtHZjIOfTksnVqfbw6PsuLpM7xAdbx7CVKZKvC4a60gw6/G?=
 =?iso-8859-1?Q?WJuPRuTIxKxwvrPML9V/YiVMVbW/eFEnG/Uktc/aePzrB1S0TEYSQyTNGT?=
 =?iso-8859-1?Q?7a5qSI4dIVyyhopkACYDrDTDuEtA6wz93v7ndaa1MEOFC1vnTaXWoyMkTm?=
 =?iso-8859-1?Q?oO3U3+Nhub6SX7nBuRQa3Wfb7sfpsHg7gk7NMFoD1BUxRe1b1rUt61jM8L?=
 =?iso-8859-1?Q?j5qIi49BdDHD6qrgIpI3yj7ORl8J+DFE4HNXMz67wklOoDpRT3cRAOdOM4?=
 =?iso-8859-1?Q?jAX3dRjDZkR9b13T5QQ63YbkeDOlLauI1rZkiYWlXmkCpNpkRy7nUIcY8L?=
 =?iso-8859-1?Q?undMewijPbEtupyB511huQspE8jN+0E78zqO320FG4lA7pDbbzIAFigf+c?=
 =?iso-8859-1?Q?jbRp9TUcVDlVHfA0O2PgeV9G7P/grc1CHZAw7jn5XtsGMaTrQcYTlvRcM6?=
 =?iso-8859-1?Q?INXmzjN2+W1zz26vVXYOCaCwa7JfGZlmUrR6Nlh+a3Q9tiASRXGI/+mUcK?=
 =?iso-8859-1?Q?cOeyxN4x3V3fuxfY1lpkXs98m41b4sLxRbM0R+EsiwuGZEI7eGRUMNkbTW?=
 =?iso-8859-1?Q?w09DGgGjS/Qs11ASzHIT8zY7LPo2E+YMPB1ItkKoFrDLjXakHeIM5T3GF2?=
 =?iso-8859-1?Q?3GrUz97yPHd2JgMbCK7YnPezbLhaWEA3lehb6rFp6ep+vHuJoev+7QvQZg?=
 =?iso-8859-1?Q?LPpr6w82woRAGIDBXpF23FmeLeizUFiP4KZQBgfFiHy9X9M9Mf0cgt3HtR?=
 =?iso-8859-1?Q?3CA4QO8kcNPlSRxrWFRFI0I0cXn8+IgoBcR4REX57vFILlXmZU9hubQPQ3?=
 =?iso-8859-1?Q?tGg7MFEziBgGYzxP5ri71761zXAAtBHeVB6qnqgaTAVjKo/SqYeJdkZDGI?=
 =?iso-8859-1?Q?wN7nPkShTGK6hrRQbVVim4ANEvFsIZYr7tIb1YQJGws5tP2uVbdB9eMfq2?=
 =?iso-8859-1?Q?YXmBMg6wcul5X4W4hihojPAAbzLGlHbFqzLz74vnPVGwYDrizXxB0+sZPh?=
 =?iso-8859-1?Q?/Qxu66VGscyr4yZTgZpF9jgy8ydx5Ogu/OXGW72a0mjvDMTSmZ2OZAPt9u?=
 =?iso-8859-1?Q?M1ODgk/qJeUhL782Q/+lJ7GqWevLJPLx4B7ccl7do3e/KdIo0XUwye/Nx4?=
 =?iso-8859-1?Q?askLFhWkqr7a3EzcmrUlMQ6zuB44CY44rjCKb8ffbtiZRaInsiWhiNPn1/?=
 =?iso-8859-1?Q?vEf8AolbXDq9F5efyTRoSJF0Mrz/DGnwnaUehTVu4el5okSIlTY6MXDLtk?=
 =?iso-8859-1?Q?Y4Jj6qjnlvTIaP0FaXBospYCLf1Ifzpe6wglrQsSDNn0XS+3//QWleC6XO?=
 =?iso-8859-1?Q?9B0gVRsdrOUQydMcDsivgZ+tcWft8A40NM2EGi5G9mW+p/X0XoR8m/xMLr?=
 =?iso-8859-1?Q?DNfIfOy/LUq855lVpGKcbvnR99dygWlTrS+mUkdGJ9OHtFQxFxclZ8mQho?=
 =?iso-8859-1?Q?jiZ2mWiTlFKOezCjfwNw3uGAb05+LJDnK/NtkqB2udKVP0ZUwNdvWT89Y7?=
 =?iso-8859-1?Q?f+cV6phK/stROyVfx//MEz2BAvwidF07jDJcq70J?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ju1XA3S044Gn+uv+1ExhkNceKhSJ2hCBA1eHwp4CwZ0xD6abmsVjmGAv6O?=
 =?iso-8859-1?Q?S8u6iS2hwuDKoiak78IMSczOVWTl68ASlkFMyxXeJZGE0XLNG4gb64cKOo?=
 =?iso-8859-1?Q?8/hDsd4dQhbsWIRfqfIOySF9Bvy3G2eNNFAuIp8x2Wq/Nfs+g0GtvmqFUb?=
 =?iso-8859-1?Q?3D575ei/d56pLv2s81z8Idd27Um7m6t4AyrMjRvPPE2GML8EI2h6x1+hqt?=
 =?iso-8859-1?Q?Z3LEtRRXwzpTP0VazvKR+dE2TRnQFv8e6AvyAOC1IPAQEfeotM7eCGsGSQ?=
 =?iso-8859-1?Q?TiAqWyuWO3i/a69M6lWiyZ+6GO2NXdiQRfpuQ+L50bTc+Gxd5FDW72P3G2?=
 =?iso-8859-1?Q?W0C8cdFnQfU+BJ0ntCFKeWCswd8UkZ9eFTeki6nduX2ZIocCS2skadxXWu?=
 =?iso-8859-1?Q?HLiHqmGw+EsCndhx7lyhklK+ZNUzoVoi74+TDTI//9vbU7XuR3353UrQ71?=
 =?iso-8859-1?Q?IPAykpc+DIWcWEo+QuMUgR9DVGEB49YRBLIuCiJ/bTiNi8xTv+U6/kQnoW?=
 =?iso-8859-1?Q?o9sy8e2zIY7VfMZ2+NajUoWahS9ZlcmPG6ztakgid+2LGEJ5oht7UrKCns?=
 =?iso-8859-1?Q?ZvRQRp8e2+AUEjps/nm6edqzQixDrhs875OKZp6NFNUkBsvvt4zlGltwDH?=
 =?iso-8859-1?Q?qUf70AFIeso7yUBHKtpztPVT24FcxnCZv9eF0W1s2cPyIvXIz3d5V1OKbS?=
 =?iso-8859-1?Q?F8kAZa6bxJZLbHlMeXqY+zN0MHDDXIgskDhhcD5ACEv2bJ9JoHgn4oyEjn?=
 =?iso-8859-1?Q?Knhupoo+w/Pv5Hdr7KajZko13TkziDPmT+Ql6QPL1RPBXk84GAwQ6KBTEw?=
 =?iso-8859-1?Q?Dvg1H86uKmz7Q1MkNX4d2rTfiobYtdV3rUyI5BJlGSYIibVDbvReLE6XEM?=
 =?iso-8859-1?Q?8Vkb9sQVMxY90Wkq+1+eZGkpwlUy6JJWN1CoUb6gFwFALMJkk/g4lbW181?=
 =?iso-8859-1?Q?LDFSWZci+bLb97tVKnUTIb/Je7MmyRenmnu9mqFXtSQlUC5NmdLYHvU+DE?=
 =?iso-8859-1?Q?drQ7QJpjyB/zlSZesJ3JcJ1flbVE1za2PVEdGxlAdo3WZMvUg/TS9hIOOv?=
 =?iso-8859-1?Q?kJR+RZ9IMtqPjj7/HA7FDDP3WyCx7HQ/TqcFYixGlwdN1myeEFGTHCXPLz?=
 =?iso-8859-1?Q?AyQu17xxU4HZd3WDWderSwGMzytmaMnBHfdj56UlLWmAS9yHJrzscyeTui?=
 =?iso-8859-1?Q?EZsR9G2SNT6v6ts6Ww3PUluR0mUP3ecz+RZpbTuiYiQjaRNMqb3UKAvUBe?=
 =?iso-8859-1?Q?1ZMYJ71O9cs6OqZfX4iEgkyo1L9JHKzGhDSc8UMCcMMuWXYr0HRE7r4k4X?=
 =?iso-8859-1?Q?6OGHVxZeZ/0irtWWg8EH83t0Pi1Z6q+10E7f0KH36fCxG0SGQ/xYI8Kkdb?=
 =?iso-8859-1?Q?2Usk6SSHP4YFAwJsNjeoAW0/+A3JApbLLpMbu/wW2UnK69FXxjeDqZe0be?=
 =?iso-8859-1?Q?UUyqJopzxN3qK2L2xwzAreECabCWlKtvko0olG3nmz1tk0JBvbLj2+W3WP?=
 =?iso-8859-1?Q?0lbxqFiV2ZO/qEUpdKJq6kYCg9mZ+KKnbuf/OU11oYlYuLVV8w6UEKdRp/?=
 =?iso-8859-1?Q?PxdJFQlkeDxgxFVpACGytt38fBuj4UnKNWWdSwSr3e/Qa8SnR4SGecWiK7?=
 =?iso-8859-1?Q?RGn0DSSYzhxEsGidzUGIN9aufF2IHdLkX7DINZXhN6lcXv6nsKyGDRYX8F?=
 =?iso-8859-1?Q?IGSIqBq52rdv8KZLFY4dFMh8PTA9zIej0SkuFUV4O1PUu9E+7Vahtqrbw1?=
 =?iso-8859-1?Q?3z0c3k1cKkQiTf+NN/go60Zty6k7Q3/YU87AsniWsmfbLMgQFsrRAp0pgM?=
 =?iso-8859-1?Q?2PTfVN8cNw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13b72ba-b58c-40d1-f741-08de7371c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:00.2700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRtCmRYMzYMlxk11K8HM1jr0xAu79+ARRWY3uYv5ir0kve60dQqZJUFDePlFTY6IWRTNRSiEH01PXveMRp1H7Be++SaRbPbAp4QPc5u2SkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

In the previous design, both the PSP and TSP were started together during=
=0A=
SoC initialization. However, on real hardware, the TSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the TSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the TSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the TSP's ARMv7M core. This change ensures=
=0A=
the TSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls TSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index e39d1dc171..b99b18bc6e 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -165,6 +165,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The TSP starts in a powered-down state and can be powered up=0A=
+     * by setting the TSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

