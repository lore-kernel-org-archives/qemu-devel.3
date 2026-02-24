Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03824EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6J-0001iT-7G; Tue, 24 Feb 2026 00:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6C-0001eY-14; Tue, 24 Feb 2026 00:36:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul69-0001Hd-JR; Tue, 24 Feb 2026 00:36:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxEMLpYgVpm4nCQosfqS56qjUOJsSV+DiUNTjlMHabEK5NXqyOJa+HcpDcIztDQKf8QiYNUDvaIHttEz/jriF1dMlwKHd8LHb9nufTpN0BN8eCTGAzi2bkX/aGfqmpbvJw0w74a6q1jLssRD7mXFaNQUrj322xvAtlHl69OOGbT17B73ukvHNoSai0Of5cYjfJzA+RcyYheLUYpeLz9z+NP/cPbDr+Ai2pUqzpy49YGVp9doXIpy/XV6KzZ1yLlRlbWqj4f7rFKhAS1tW0Cmql5keWdq3pTrkqrrNbQtSphCIS0d4nAXgBqx0Vz9jG4vnso0QXPQK6/XWDFD2Zqxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=hkKP9KIWeF2Tv/OJLneCEoD+a6KYbAzm/sSRC4sBWzpAJKYfvJzUaVGxrFRdQiJBbcUtWoBQFJYc26hvijxrm1N0R7GkXGzOWcGpINvbaCsNaJZXoJBVg45CVp52YGmgoGZUsXPCk8hDSTI8qXVrMtRfxP4NpdNo02vvaQFjCw7IMhdL1g0VVgQBtP8S1FB29F2yaIcyNKnq5SP6uNVWQaLyPh5zPoR/lZCIG2cU7hyWg3iiNIbMm5PkE+2gH6oaq1m5y1VArxUjjxzenrjfVCk0MA/qEDuxvW4mC7uBTFuhJggCZw+wOXKAVwgPvO4yqqLJOujrF0t2W8jYybID/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=LvgWKL0WkMycSSJoZ3GW3If/ZSZjMAlXRmbpDWDEMXNgAfaEsDKU2R+Lwemb79fATysnip03c3fzgSLKpMX8Z6V4UZ2LwSdGvEwZimUkC3LW8lmwjjYfgRUTg+8uQKb7l8BlYyUa5r0qytGng2+6deaanPgjR66ANjHHKz65/rhAfoPBh7ZMOoNS6UWQ0VhM+eKqjcfwo7RIKrGQEquskCRwCqnHZGSjyt+othMSzCYUqAasX0cami/s09qCdrkdH8HyWNHXxNnWn2yWLoFpqgyjaSn/QRuzjWsK0+bNGyMN/1dG8CBxQRB3ykJRDTF7wbWSTTnT1CpO18GOnh+8Qg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v6 07/22] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH v6 07/22] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHcpU+EN1X6Z7SKgkyAFC+f5kaGKQ==
Date: Tue, 24 Feb 2026 05:36:25 +0000
Message-ID: <20260224053613.589102-8-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: d8dcb6da-94df-47d9-baca-08de7366a688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?u38hJwFxrBz963wX0pNParZN/O4fgTJ3uSz0B4Ro0CXRdDv9718wW6thcF?=
 =?iso-8859-1?Q?bOoKNDT09wNVKzEaSBvdXbxYFd7AkiVxsJo3LIr80sHXRqmUuvIgcPThZT?=
 =?iso-8859-1?Q?4WDcT7icKZZ8iSkeD7cJAIB2SfOsOtoXOVrAqhiBu0+/2Ib7M3iA0Ubt8p?=
 =?iso-8859-1?Q?iUYKrTR0ADbgVHDTGA176VuXU44Fiu2JEnOeQNQ+F9E3bWn42RQT6gVOP+?=
 =?iso-8859-1?Q?OSPDSOxyY79TzqJmIz8rsF/jM4sy0N7plTlDsH9Sde85Hi3195LfeCgbG0?=
 =?iso-8859-1?Q?sKEGwrLUcYSvyvkuYB/hZ8D9dzpi76U0JyS27LqU5YQOs18Xh1mb2bXEFd?=
 =?iso-8859-1?Q?7ShfL/OY8yt+ldZwqpFjocn/TLXcVq4LQvCSL1eig1d2HuZaJHri+wmS0F?=
 =?iso-8859-1?Q?GRVjLACTth7P3ISEnzOt43rNVujLMMbcSDtAakv3qt3iNOgOvaYpFYzJs4?=
 =?iso-8859-1?Q?wcExkK1R43aDccDIohhoNB43wyYSdlZ5XW40KauTzknWdja4fRMh4IJb92?=
 =?iso-8859-1?Q?bAJtr1G8ovRJoLAlnHFFUf6PHALPzM2+TqUkymfRfrzFbVfX3nSnA06iX3?=
 =?iso-8859-1?Q?SsclcP1zKFsHPnR2A8FlzRfYhP8+nP/LsIWbknEuAIP8qSxcHOUOcQBe+Q?=
 =?iso-8859-1?Q?maSQGe/PU1nN7QF6UQQ2xiUV8JvJ5BJ0Dv/456AkA0fV1hQ4PCOxlx24+s?=
 =?iso-8859-1?Q?DNKqRPwiRkntMZ93lnOFKwkfZcjmUSh9DXX42p1wK/UYW1ls3F4vY75+5S?=
 =?iso-8859-1?Q?jMoIWbk+kKTqXDDZmvqelNSyigfKHd0mpz3eY9lXuZavYXMc9X1t32XXVR?=
 =?iso-8859-1?Q?LHKuuNJMoNi3rA9XaBCiRd1uowP41PyNct2/LuBZJnO0jYw4PGUIk2hRAz?=
 =?iso-8859-1?Q?p3llDS5k0DUxnAgX7uLaCjcp5UUpYOx4RVBJm6U1zCLfatEjvbiuDgqArj?=
 =?iso-8859-1?Q?OFpjjcZ5fMJh3Uy1kTs8nBwbUP0y0xRJepLiqoOiY150l2v7yHS5nplR5X?=
 =?iso-8859-1?Q?d3+IZDoivWBd2HpdZX0kKaRmlAk4CxkHYG1KhAK8+U7lQ0JTvSh+mHLNpg?=
 =?iso-8859-1?Q?Bwc6Dl3dDDmQgERDVKYlpxJJnN9E8H2xSdUaRi1r845NegwrIAcK/csYRx?=
 =?iso-8859-1?Q?oNxjqY5IfrHCz2cxlUOyVsgU12ZBm+bbMRL0vbFrHjRVzo3lg+e7ZigePp?=
 =?iso-8859-1?Q?8zIM4heA2Gr+xe/sRCv+X/j6/1aj4SjwVZPCq5pEPGcdrltZwJLgQsSVcZ?=
 =?iso-8859-1?Q?Z+YgABtxtY67PriP9PsYua89OMXH51Vy1dOFvTJKo4sfzoo3/NCHUcSFmk?=
 =?iso-8859-1?Q?zBSaBlTLJNayA99nRKU9OVFa/9iG4hyus/TkOVrnJ3HdzhiU8I2SkX7LN6?=
 =?iso-8859-1?Q?cNiTPooU5pbORDYfvo7vntDZvdYpwXH8zJRsOdTW3NSTNq1Kphh9EydtbX?=
 =?iso-8859-1?Q?KgfE6BwnAa0uO75VaAo/uUP9doSx7KM7C0MnTTJ62yQswvz30AHWdLmTqt?=
 =?iso-8859-1?Q?ai/z+4H6tzneM7FOxxkkxGUBHtNgnKF56yyeE9c7r9sQifJpE+6+yCeD8L?=
 =?iso-8859-1?Q?SvhWfxdAilZh1SqHwVm3RftpyLdckOtVuLA6tTIsorA3jM1QEBTtV2PaN2?=
 =?iso-8859-1?Q?oaXAcLVdw22Z9ZZvEDKfa73Jg+l5dFJz+PT2uORNmFXW9Zi0JpBRpmN9or?=
 =?iso-8859-1?Q?Q81w8v4y81Mk8kgneKIoaGLCnAQ3AnDLDW7ZkVXM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kG6/QIQ1fA8IxF1d7HFVhDGDw7KQAPOlU2lXlYG0KqNuQv/sXTJFn0IORe?=
 =?iso-8859-1?Q?TkvCiXryRfg8nlYK9cONFmQUBiddQFh8qwNjxlnprerfv75jEHzW+KjqLb?=
 =?iso-8859-1?Q?1orvX4aPYZnEvbrtF9zr2gmP6bgjSGKH+ydAcbg0lFvXLOgamrHXrdZWQ3?=
 =?iso-8859-1?Q?qVYxvA9yM7QpIQ8i17x36ojWwNbKLidZxCqe8GpthWhLdTU61ypvUmb10n?=
 =?iso-8859-1?Q?4lOgd0L9n5TbHBfexDZ0lvDgcKG6pMU2on4UWNIT4Mo7/Dta3J+3avaSJ+?=
 =?iso-8859-1?Q?bh3OP3OWtDZry8N3pM9oksNOxn0h2iH+4lXgaNKDytlDml352CMagl2P/z?=
 =?iso-8859-1?Q?FBmsbCg5c6dN9J4woqEpmvRieFcsvVbbNzC0B76FxLF3h88e+bl+g8uwOk?=
 =?iso-8859-1?Q?aTOcqoh9r0wvX/s+qS8bTP1dzfVC0O7tOozHzv7UlnDw9SKiA8uhmXXbUz?=
 =?iso-8859-1?Q?UU7/4G62VzQ2lYaU55VjThPm95r2fmwcx/NvNEDsU6t49V3xxkUBU3ddna?=
 =?iso-8859-1?Q?EjOPzUjjXuXJ4Ud7EdDn/umbb9NFKPCZGTGz+I1UuR3W33lsSZKPrsBUxi?=
 =?iso-8859-1?Q?87cMP2RVczdm/vQc8cLtOBuayJpW0AGduYO5EM6tY2bvBNEkEOnaEVnSjx?=
 =?iso-8859-1?Q?zeKrWNgNywK3L0DVyND/FQLCU8USGsyMqNoab6eO610QtqPRxwpokjIOa2?=
 =?iso-8859-1?Q?n/istOm/hbaoLKT5vjZhrviDsD3MBRonY2619mxwL5IioliOcSNUIbFj0y?=
 =?iso-8859-1?Q?aPtttEQ6rvBzLZaoeX2Zr6rWWMmWD+9lTWnDqMP+iDLVPDtRRxxOUqFUD3?=
 =?iso-8859-1?Q?nRJ/426yxTU7Tnpk23lvm0aidCH/yJkPKZxrS81MYEGTpdAiIsYtBFCKG/?=
 =?iso-8859-1?Q?rH9htXbA5/HdU8arLt+/ur5GHV3k51XtiWX90sYJnIo27hW+078Nm2hRJ3?=
 =?iso-8859-1?Q?nrqaPksazOsZGEvTHiDa4DFn+oUQ+mBw6eqtDAdZCQ2jiELtt4yzusFguG?=
 =?iso-8859-1?Q?aU36ws/B1iW6slVvUUBcG6wabbTTua7+UFU6gN/k8TXDoCc2jWQuwPeYvs?=
 =?iso-8859-1?Q?uTIuk2/LskGVX1vPGE676zAJeEhihD4UhAikkWLy9gu21lXZqy9u6stAII?=
 =?iso-8859-1?Q?LRIpy91+MKBVJJEwTzv5hhlfRszR7dHbSX1HXz7i1uDN1JX8h0mWOBbVeA?=
 =?iso-8859-1?Q?2yF6WeCIKxRJXd4k/4SF+Vv0HiLN2DGrhW9nHAxFDmItpRgUSyR0kaAv8g?=
 =?iso-8859-1?Q?rdiep0pvzyRcxiNfrsBsm2ITO6RCbACdnGpyMQ1K5llcLAM/ATpXjwuOjd?=
 =?iso-8859-1?Q?f4QV/dnTYtIreEAwMxETgTwUYzaKiH1JZCcRKD3mv+ZJHbHjiL7RvXZyCK?=
 =?iso-8859-1?Q?4/YJ9vQIZIc/5WzhZ+kJ1mq4buunypkdEz07Jns3E9Jv5MGCivPUcW6gDN?=
 =?iso-8859-1?Q?MT3ETloVn30GWjF16IuVrQq82iIEy5sErGyLJEATmGE7IATMOGON1/JYS+?=
 =?iso-8859-1?Q?hbsqXJO4Vn73nqkIzCkDZKKn48EV8bQ6DdyraQTwswnNU2Ac8YppObaZFm?=
 =?iso-8859-1?Q?c9SszeOF+/xpG2Y4yPRMI+dAB8zuCn4qMcDjA2G6hGjV7Cps3nTBoXru+U?=
 =?iso-8859-1?Q?H1ZPc6AVy2XBlfYSKWXi3arOeoBLnsXxIVYz6N/gg3b9f22/TpX52Tt5sO?=
 =?iso-8859-1?Q?N3Kd/fAELG0vMjChHqeUCNz2mEx3yosKoWEORZnjdbQ0aLrBDTVdOx8D6A?=
 =?iso-8859-1?Q?pt6CSLm8JeLP/uyBltOeA6s5dMitC/J3ORsQDvfeQv5p1RjobXAiycUp7L?=
 =?iso-8859-1?Q?0QMt1mmdRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dcb6da-94df-47d9-baca-08de7366a688
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:25.0441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXbvq4wkACNfQVnIX5pr3vmDV1BppFccFa/VvBd2ivCuDM697oz5QNGbfJYT/fUgz9DatGXKVUBkWP1uuPgIBjP0nFZ9zqmrp3ZDf3jjUGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Adds reset values for the new registers added.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-=0A=
 1 file changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 48dde008de..28da6016a1 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    /* Target mode is not supported, don't advertise it for now. */=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00b9,=0A=
     [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0x01010100,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0x0000000b,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0x00000002,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0x00000010,=0A=
+    [R_PRESENT_STATE]               =3D 0x00000003,=0A=
     [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
     [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
     [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
     [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0x00010000,=0A=
     [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
     [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0x0000003f,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0x000a0010,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0x000a000a,=0A=
+    [R_SCL_I2C_FM_TIMING]           =3D 0x00100010,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0x00100010,=0A=
+    [R_SCL_EXT_LCNT_TIMING]         =3D 0x20202020,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x00300000,=0A=
+    [R_BUS_FREE_TIMING]             =3D 0x00200020,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0x00000020,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0x00000239,=0A=
+    [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
-- =0A=
2.43.0=0A=

