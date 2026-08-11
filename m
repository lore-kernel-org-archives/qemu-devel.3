Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8893CC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtb9y-0006zW-Ex; Mon, 10 Aug 2026 21:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtb9v-0006yh-N4; Mon, 10 Aug 2026 21:20:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtb9s-000772-0u; Mon, 10 Aug 2026 21:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK3fMVezaki08TvWbf1nVtdQUl2E/cKirZwCLnxxupY38s05sZr7o6kuSgJTuH0VSPynVO4YU8PlJCupXJ5CZoPTEBXtZqMlru7jtqYAlAU3Q2jpSX+FnmvDOUX9ZmnN9ypsr/1pgqQjbJDipMyfdUQt2D/5ZU/rD/t6dRA9Dd5pWO2Pwqe+uiLNYlLToHOBq/j7EHiSnezyZFrcy0bCqgk8K2QuP+osCBTkiMRWSZHLVM/T4xdpHq+ih0e9T3fiOKiE72FxQEH/IXWlAQhhW1YSI48J4o5iQZV+kWR1SGWzjS/+/mhAfB4QxG0qavkKC4OI4b0ISf71IffTL6N4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W/1EpKcdZ77qo2d5I0vAhGd5nXcjP+SgLb4567JUzY=;
 b=KKr0bHXFWWzbJ//4QZ7nzvINV9iJwy6p/SCftrHaNnGDQ7Yv9Q8j9CQg/ucDzBqY4BYpQ0ir3QhirPG4sb4P5WzS6ZtqKOD8nPBWKIFFzeP4bNhmMsV3jywFp105/xdP/6H6Iw2TIi2Jmkl6Wh/5KKT48dN3MrttfALkV6dcS02MYqk3kN7aynxpP+TlBsjR8legYX30xOYxoQs/eZZMZhPIZpKRxxbZn5AtPO97SG80UmEVHg89i72PTI4PYy081mJFL4XeHFWAdiuQBtqfivwQWSZEJZXSnV76uVym/terY2xlastKextF1qmGXdJF9rfJ2vtLj6AFsiggIa7CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W/1EpKcdZ77qo2d5I0vAhGd5nXcjP+SgLb4567JUzY=;
 b=b3dbXzzJX8LmcecOvaLgLTriZMOa1Dmec/vi0Fz08XE+ogbbOeOhxizjEbAqGzHEyQROW2hiB3xr/tdvu9vAEn9MeVhE28l3v94v7afowD9Dw1XzA4QOPmZt0TXtzADG7fS+feOxDw+F6jHGng5lkiXSgUWNtKq2bPlreDhkm1cDJJSWZx7+K7I/9poRwUP/WYz68CYgIlso3u52jWFWTLAV0sH+/Ndsxcr0fl3tUiVwrwQGgoCLXlza/b/+1YSWi4Y7jPTPIMZ1fWWEugYVp/+7aZiUI1Y6liDb0nZIuUOQEHpPJqVhVGwH/XSVwX4iM3yLe5Mrwsal/XPHQEsDzA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF2BE5BD2CD.apcprd06.prod.outlook.com (2603:1096:108:1::7ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 01:19:49 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 01:19:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Topic: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdFAqrltXLJE5RlUerH8FfKXx9/7aXA3gAgAEvl+A=
Date: Tue, 11 Aug 2026 01:19:48 +0000
Message-ID: <TYZPR06MB49804F19F3CD19D3D7D48AA8FCDD2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-2-jamin_lin@aspeedtech.com>
 <SI6PR06MB7631D594BB6D342FEC137AD4F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
In-Reply-To: <SI6PR06MB7631D594BB6D342FEC137AD4F7DE2@SI6PR06MB7631.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF2BE5BD2CD:EE_
x-ms-office365-filtering-correlation-id: 961d7534-af2b-488d-5c16-08def746a300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: 1o6IC0CP5w7HgGjFK12LzW6NIikBEsbM4PRtP5EyMoyM086xGqJTAyh+Pih7G9gd6F0OaX6jZkjgsn4n+1oXuXzRB7IHP7MMeu9DtmuKxnqgw2wYS09uKTxJMTdgMVelIouYYHMdjKrUwLlr3+bSNXBnO+WQEJVTnuVPcKMJDpW1TIi04eBRq8Fzmma65DyzQzuQg8hnu1d7WF0WFju+jCtntU4epowR1FxZocbItvvYGJHy9Yd6OF/EiUu7TigWWXbX3rvgEt4vLewn2YkVBkEH4L989iQUsJek0y522xDr0r8MCWoL2wSQXPKQapqkyJhFApeMhHuvPK3fwcCNQLE0zJkPtgYolZapRntVd8L3zEaS75mJuulJQa2To4PE9qP8e1TB/m9KEh3BQaQsU5m/6witb/du0kVK2Fyybyxadztx1GTOxjjKe+UBaEFbF4SiJN097lQHKPxs5Mf5ODqAe4IWHGtpte+P9CO+qUw2pxBQbwb0AHaRdEl58k4+nfoLmVjfqPtBwUCz8kfct51gyBk/GYDt1yMcEa2Fe+vZ3Un2EdTK7hl774tuNN142oCyVz6+z0Zbw7sQ13+HUwsZva2aEsXll33xVbm1tpUVVlIac+Y+0OUt8cjtL1nuVYqqnWgiLo/y/P3Vhw2enSNjGHtAwT5cUu4zyMRF/rX+wTVyJsqzd475nlhlkDSLQ8gJUcXfZwokvXgFAj0sBX1EY5deokz3/Pu35HmOXi6nixlAUiN6qChf4GRJEgFg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DK4ZwJybii8w0WC055ekFtgj23X9Q4yvO+pHLAi5QmQx9b/pZdbMCYeIil?=
 =?iso-8859-1?Q?ZO3wGvXd7xd9O96CyzaRwpcNhBG1+TSRQN04wmVisLjHSHLECc6GSJ8K/P?=
 =?iso-8859-1?Q?5yYpESBjBNKmJiO22zDqv3SwSvfL3U6cR5UOf5UMznkDlt0JVYgdAxDDvS?=
 =?iso-8859-1?Q?VmP0lRNNav2udmxIUgnYVl3jd26ObJ5eSncVFGu1gbSGWMQxZ8Z3u95XWy?=
 =?iso-8859-1?Q?K38dWTo7X1NCPM87EPf7286/5p+SmY+GEpxyNCzmNJwCfRDrUJCgWDjOym?=
 =?iso-8859-1?Q?4gv6C6fr9rEDwAO3tNQRxJ+EqWm89552FGqHonS3Wj9PxTBQ+I9lrdFfNU?=
 =?iso-8859-1?Q?J9eHyz61TW7Q8g32xB+xxzWDj+AgHyVLX2cKt8THv6BmIYOLA4wTTqpSKD?=
 =?iso-8859-1?Q?4So9lNuVXeWchD6t+lWTULFlmSbTTntPrzjMTyWQ2N0Ai1vbQYlbnM80hz?=
 =?iso-8859-1?Q?ACyO0wu8O3vXXjrWBeh3hqGykn1SrU6pvy1+DjatTPMovMoEbmiV6ivITf?=
 =?iso-8859-1?Q?7bPSTiEISNBpIbJGJEXQBe+GJVDV1TcLNBZmEccQyzR5EocUn9VgGSMskc?=
 =?iso-8859-1?Q?9yc+25P9JZTY9/BMPWFjGtlXor94rJFds5Ezq1rpyZO/kS3z0gw76o+y4y?=
 =?iso-8859-1?Q?a6KYBQICCE4DPlMpXjmKF2jllpDEYHhQXx/DarHfYWMGPwlh7eb8FAhBHt?=
 =?iso-8859-1?Q?VvC6m3TsZkRtrrysd242mGNGcFu0IRBJnOZyL3fCh3CPs+1FQFfm15HKBl?=
 =?iso-8859-1?Q?HhkJS0k4g1o8ZUZkBsy3h32gt6y9Dcukz8UFAlIkvZ/nN7ri6qdSr2ImC4?=
 =?iso-8859-1?Q?sHdw97/m5om0uuGO75Vfyym9zZYjgJEfyeiBxZyH3+T8rHXgIyQxI47bP7?=
 =?iso-8859-1?Q?T59Z5bOfYMcWUHQLcM51Ocrq8dL3GOvKCrB0BMf+UiHkDzLrcM1Ub9UT0g?=
 =?iso-8859-1?Q?WkweazMWOySeyzr04LwHvwbizi6LgomMaxwtlanxFqenr9BWFLzIu8dhn7?=
 =?iso-8859-1?Q?XpKO7fLbaaSsMnR5Zs8uWEemlNkl/rNdJ3aV54DP8iym5OFeGwqeB3MaF5?=
 =?iso-8859-1?Q?W5ncLAN9d0UlJlhl1VpsjzukQfDdFuMUY6vvKWBX/Buwv8AHNJx2utMlg6?=
 =?iso-8859-1?Q?qvyxLYngC/fptzc6lpE6wvU5MaJ0M9gJL9icjqKs2lJn9j2s7v/6Bm5PPa?=
 =?iso-8859-1?Q?DNqHzBv3/1PYj1AcYRbxdf/KInNsxIFvOqx0LSa+iGvFhSnf/9WXQNZehF?=
 =?iso-8859-1?Q?/A8TsVzhVHrStiBfWvWza1yBhgTafYaizBuHla+ELAlwqLQYkTrSPdZf/U?=
 =?iso-8859-1?Q?psl7+lvkVHqHnNo/CccSnxVXOryw8RbhI43jw316WD5cFHfK9iwQBN45so?=
 =?iso-8859-1?Q?YPmONrgX90eEyKgUp6joU37fKPqKHpt2p06QGZGGqAs3kcPhj39Cah4Oom?=
 =?iso-8859-1?Q?2Abk4Qtxz/CYiXg3NU8d3Or3a/G2Hy3GU+PEFqxpYzQ9ClGvLmYaHLFlqV?=
 =?iso-8859-1?Q?wNhF844UPAVkKZfHopif1mC+d5zFmE5VB6sr+u/7NcWkFacJ7Y+4Km0ZDu?=
 =?iso-8859-1?Q?APgXj94L6f+Ws4MFHyRMUxuu+UaKO2AGf1jDPN2QhCKxGxqsy5Clu2KwPR?=
 =?iso-8859-1?Q?BnN/lealGIoZvFIkhD0R5Dv3wdjrtrMm7Bf+Mdhf9cnz0Z2lm68GPGNcES?=
 =?iso-8859-1?Q?OMiF4PSw8qIph0b1FZpxSyHbEHfmgc96taVvMumNfFk7Svn/b1sME8wK6M?=
 =?iso-8859-1?Q?SDuZjpTWN+T38tCyDHrDQSYwgsHDDwAx94UtpdNGz/NpObH4q2byB9z9KH?=
 =?iso-8859-1?Q?DGoz/2qqKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iFirtwRq1ht/wQAI2WoPZ4Ao++woC6gGWh8PJaoELOfYiBl2zWpGp65IoTqqfiIwB5pj8cciFv4JXWBMFXWNx64cSOm8NZc44C1Oog40P+PfA9VT3zmwAiRGvvqPgSDg4IKlwqitidZH7ifPVYPKl6ISfLtfKHTD9ffjgDwbeceCkwi87ldCg/E+WiDEYKlWwdyz6hBWiW7VgrV+9QCLtqdvQXb30G+ZPMytn0RWuh+IjGxgebXKH4Lh4lvvsq9ulqy4aIXzwBqwLqm21tVCzRVOof+WVShtFuuPSl/WuhONzZFj/Nz1D0HK1qJB0fCj6Sr9PupbQDVG0Jg67d0x0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961d7534-af2b-488d-5c16-08def746a300
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 01:19:48.7212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJxcMC896qO5d89ToaaUQF/Sml+1T+KvxkgxLAEr025CHOIKEahE9Pq3Mc/6P5XLPrg97VDt7am80GxcnnFLtbN1TwSnfpSGCGYIiWjGfHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF2BE5BD2CD
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

Hi Kane,

> Subject: RE: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto
> command in direct access mode
>=20
> > -----Original Message-----
> > From: Jamin Lin <jamin_lin@aspeedtech.com>
> > Sent: Wednesday, July 15, 2026 11:33 AM
> > To: Daniel P. Berrang=E9 <berrange@redhat.com>; C=E9dric Le Goater
> > <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.org>; Steven Lee
> > <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Kane Chen
> > <kane_chen@aspeedtech.com>; Andrew Jeffery
> > <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Eric
> > Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> > Fabiano Rosas <farosas@suse.de>; Laurent Vivier <lvivier@redhat.com>;
> > Paolo Bonzini <pbonzini@redhat.com>; open list:All patches CC here
> > <qemu-devel@nongnu.org>; open list:ASPEED BMCs
> <qemu-arm@nongnu.org>
> > Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
> > <troy_lee@aspeedtech.com>
> > Subject: [PATCH v2 01/17] hw/misc/aspeed_hace: Support the crypto
> > command in direct access mode
> >
> > The crypt command register was previously stubbed out. Implement it
> > for the direct access mode, where HACE00/HACE04 point directly at
> > contiguous source and destination buffers. AES-128/192/256, DES and
> > 3DES are supported in ECB and CBC modes via the qcrypto cipher API;
> > the IV and key are read from the context buffer (HACE08) and, for CBC,
> > the resulting chaining IV is written back to the context.
> >
> > The completion interrupt is now raised for every HACE variant as the
> > hardware does, which fixes the crypt command hang on the AST2500,
> > AST2600 and AST1030. The AST2700 crypto engine still needs 64-bit DMA
> > and AES-GCM, which are added later, so it keeps its temporary
> > interrupt-only workaround until then.
> >
> > For debugging, the context, source and destination buffers are dumped
> > through the existing aspeed_hace_hexdump trace event (disabled by
> > default). CTR mode, scatter-gather mode and AES-GCM are added
> separately.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  hw/misc/aspeed_hace.c | 283
> > +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 269 insertions(+), 14 deletions(-)
> >
> > diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> > c61efe50c4..de4399f322 100644
> > --- a/hw/misc/aspeed_hace.c
> > +++ b/hw/misc/aspeed_hace.c
> > @@ -18,11 +18,44 @@
> >  #include "qapi/error.h"
> >  #include "migration/vmstate.h"
> >  #include "crypto/hash.h"
> > +#include "crypto/cipher.h"
> >  #include "hw/core/qdev-properties.h"
> >  #include "hw/core/irq.h"
> >  #include "trace.h"
> >
> > -#define R_CRYPT_CMD     (0x10 / 4)
> > +/* Crypto engine registers */
> > +#define R_CRYPT_SRC         (0x00 / 4)
> > +#define R_CRYPT_DEST        (0x04 / 4)
> > +#define R_CRYPT_CONTEXT     (0x08 / 4)
> > +#define R_CRYPT_DATA_LEN    (0x0c / 4)
> > +/* HACE0C[27:0] holds the crypto data length */
> > +#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
> > +#define R_CRYPT_CMD         (0x10 / 4)
> > +/* Crypto engine command register (HACE10) bits */
> > +#define  CRYPT_CMD_ENCRYPT          BIT(7)
> > +#define  CRYPT_CMD_ISR_EN           BIT(12)
>=20
> Regarding CRYPT_CMD_ISR_EN, the current code already has similar
> definitions, such as CRYPT_IRQ and CRYPT_IRQ_EN. Would it make sense to
> migrate these definitions together for consistency?
>=20
Thanks for the review and suggestion.

CRYPT_IRQ is used to indicate the CRYPT ISR status in the HAC Engine Status=
 Register (0x1C).
Both CRYPT_CMD_ISR_EN and CRYPT_IRQ_EN are used to enable the CRYPT IRQ in =
the Crypto Engine Command Register (0x10).
I will remove the duplicate CRYPT_IRQ_EN definition.

> > +#define  CRYPT_CMD_DES_SELECT       BIT(16)
> > +#define  CRYPT_CMD_TRIPLE_DES       BIT(17)
> > +#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)
> > +#define  CRYPT_CMD_DST_SG_CTRL      BIT(19)
>=20
> CRYPT_CMD_DST_SG_CTRL is currently defined but not used anywhere. Could
> we defer adding this definition until it is actually needed?
>=20

Will remove it

Thanks,
Jamin

> > +/* Operation mode HACE10[6:4] */
> > +#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)
> > +#define  CRYPT_CMD_ECB              (0x0 << 4)
> > +#define  CRYPT_CMD_CBC              (0x1 << 4)
> > +/* AES key length HACE10[3:2] */
> > +#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
> > +#define  CRYPT_CMD_AES256           (0x2 << 2)
> > +#define  CRYPT_CMD_AES192           (0x1 << 2)
> > +#define  CRYPT_CMD_AES128           (0x0 << 2)
> > +
> > +/*
> > + * Crypto context buffer layout (HACE08). The IV is at the start of
> > +the buffer
> > + * (DES places its 8 byte IV at offset 8) and the cipher key at offset=
 0x10.
> > + */
> > +#define CRYPT_CTX_IV_OFFSET         0x00
> > +#define CRYPT_CTX_DES_IV_OFFSET     0x08
> > +#define CRYPT_CTX_KEY_OFFSET        0x10
> > +#define CRYPT_CTX_SIZE              0x30
> >
> >  #define R_STATUS        (0x1c / 4)
> >  #define HASH_IRQ        BIT(9)
> > @@ -501,6 +534,216 @@ static void do_hash_operation(AspeedHACEState
> > *s, int algo, bool sg_mode,
> >      }
> >  }
> >
> > +static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg,
> > +size_t
> > +*keylen) {
> > +    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {
> > +    case CRYPT_CMD_AES128:
> > +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;
> > +        *keylen =3D 16;
> > +        break;
> > +    case CRYPT_CMD_AES192:
> > +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;
> > +        *keylen =3D 24;
> > +        break;
> > +    case CRYPT_CMD_AES256:
> > +        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;
> > +        *keylen =3D 32;
> > +        break;
> > +    default:
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +/*
> > + * Decode the crypto command register into a libqcrypto
> > +algorithm/mode pair
> > + * and the block/IV geometry. Returns false for unsupported selections=
.
> > + */
> > +static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
> > +                             QCryptoCipherMode *mode, size_t
> > *keylen,
> > +                             size_t *blocklen, size_t *iv_offset) {
> > +    if (cmd & CRYPT_CMD_DES_SELECT) {
> > +        *blocklen =3D 8;
> > +        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;
> > +        if (cmd & CRYPT_CMD_TRIPLE_DES) {
> > +            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;
> > +            *keylen =3D 24;
> > +        } else {
> > +            *alg =3D QCRYPTO_CIPHER_ALGO_DES;
> > +            *keylen =3D 8;
> > +        }
> > +    } else {
> > +        *blocklen =3D 16;
> > +        *iv_offset =3D CRYPT_CTX_IV_OFFSET;
> > +        if (!crypt_aes_alg(cmd, alg, keylen)) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {
> > +    case CRYPT_CMD_ECB:
> > +        *mode =3D QCRYPTO_CIPHER_MODE_ECB;
> > +        break;
> > +    case CRYPT_CMD_CBC:
> > +        *mode =3D QCRYPTO_CIPHER_MODE_CBC;
> > +        break;
> > +    default:
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +/*
> > + * Direct access mode: the source/destination register
> > +(HACE00/HACE04) points
> > + * at a single contiguous buffer in DRAM. Copy @len bytes between it
> > +and the
> > + * bounce buffer @buf; when @to_dram is true @buf is written out,
> > +otherwise it
> > + * is read in. Returns true on success.
> > + */
> > +static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,
> > +                                 uint8_t *buf, uint32_t len, bool
> > +to_dram) {
> > +    return !address_space_rw(&s->dram_as, addr,
> > MEMTXATTRS_UNSPECIFIED,
> > +                             buf, len, to_dram); }
> > +
> > +/*
> > + * Perform an AES/DES/3DES ECB/CBC operation in direct access mode:
> > +the source
> > + * and destination are single contiguous buffers (HACE00/HACE04) and
> > +the IV/key
> > + * come from the context buffer (HACE08). For CBC the resulting
> > +chaining IV is
> > + * written back to the context buffer so the driver can continue the c=
hain.
> > + */
> > +static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd) {
> > +    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];
> > +    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;
> > +    g_autoptr(QCryptoCipher) cipher =3D NULL;
> > +    g_autofree uint8_t *src_buf =3D NULL;
> > +    g_autofree uint8_t *dst_buf =3D NULL;
> > +    uint8_t ctx[CRYPT_CTX_SIZE];
> > +    Error *local_err =3D NULL;
> > +    QCryptoCipherMode mode;
> > +    QCryptoCipherAlgo alg;
> > +    const uint8_t *next_iv;
> > +    uint64_t ctx_addr;
> > +    uint64_t src_addr;
> > +    uint64_t dst_addr;
> > +    size_t iv_offset;
> > +    size_t blocklen;
> > +    size_t keylen;
> > +
> > +    if (len =3D=3D 0) {
> > +        return;
> > +    }
> > +
> > +    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen,
> > &iv_offset)) {
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: Unsupported crypt command 0x%x\n",
> > __func__, cmd);
> > +        return;
> > +    }
> > +
> > +    if (!qcrypto_cipher_supports(alg, mode)) {
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: cipher mode not supported by the crypto
> > backend\n",
> > +                      __func__);
> > +        return;
> > +    }
> > +
> > +    /* Fetch the IV and key from the context buffer in DRAM. */
> > +    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];
> > +    if (address_space_read(&s->dram_as, ctx_addr,
> > MEMTXATTRS_UNSPECIFIED,
> > +                           ctx, sizeof(ctx))) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Failed to read context, addr=3D0x%"
> > HWADDR_PRIx "\n",
> > +                      __func__, ctx_addr);
> > +        return;
> > +    }
> > +
> > +    if
> (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> > {
> > +        hace_hexdump("context", (char *)ctx, sizeof(ctx));
> > +    }
> > +
> > +    cipher =3D qcrypto_cipher_new(alg, mode, ctx +
> > + CRYPT_CTX_KEY_OFFSET,
> > keylen,
> > +                                &local_err);
> > +    if (cipher =3D=3D NULL) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new
> > failed: %s\n",
> > +                      __func__, error_get_pretty(local_err));
> > +        error_free(local_err);
> > +        return;
> > +    }
> > +
> > +    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&
> > +        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
> > +                             &local_err) < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv
> > failed: %s\n",
> > +                      __func__, error_get_pretty(local_err));
> > +        error_free(local_err);
> > +        return;
> > +    }
> > +
> > +    src_buf =3D g_malloc0(len);
> > +    dst_buf =3D g_malloc0(len);
> > +
> > +    src_addr =3D s->regs[R_CRYPT_SRC];
> > +    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Failed to read src, addr=3D0x%"
> HWADDR_PRIx
> > "\n",
> > +                      __func__, src_addr);
> > +        return;
> > +    }
> > +
> > +    if
> (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> > {
> > +        hace_hexdump("src", (char *)src_buf, len);
> > +    }
> > +
> > +    if (encrypt) {
> > +        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,
> > +                                   &local_err) < 0) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed:
> > %s\n",
> > +                          __func__, error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            return;
> > +        }
> > +    } else {
> > +        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,
> > +                                   &local_err) < 0) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed:
> > %s\n",
> > +                          __func__, error_get_pretty(local_err));
> > +            error_free(local_err);
> > +            return;
> > +        }
> > +    }
> > +
> > +    dst_addr =3D s->regs[R_CRYPT_DEST];
> > +    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Failed to write dst, addr=3D0x%"
> HWADDR_PRIx
> > "\n",
> > +                      __func__, dst_addr);
> > +        return;
> > +    }
> > +
> > +    if
> (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP))
> > {
> > +        hace_hexdump("dst", (char *)dst_buf, len);
> > +    }
> > +
> > +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {
> > +        /*
> > +         * CBC chains on the last ciphertext block: the final block of=
 the
> > +         * output when encrypting, or of the input when decrypting.
> > + Write
> > it
> > +         * back as the IV for the next request.
> > +         */
> > +        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;
> > +        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,
> > +                                MEMTXATTRS_UNSPECIFIED,
> next_iv,
> > blocklen)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Failed to write IV, addr=3D0x%"
> > HWADDR_PRIx "\n",
> > +                          __func__, ctx_addr + iv_offset);
> > +        }
> > +    }
> > +}
> > +
> >  static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned
> > int
> > size)  {
> >      AspeedHACEState *s =3D ASPEED_HACE(opaque); @@ -531,16 +774,22
> @@
> > static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
> >                  qemu_irq_lower(s->irq);
> >              }
> >          }
> > -        if (ahc->raise_crypt_interrupt_workaround) {
> > -            if (data & CRYPT_IRQ) {
> > -                data &=3D ~CRYPT_IRQ;
> > +        if (data & CRYPT_IRQ) {
> > +            data &=3D ~CRYPT_IRQ;
> >
> > -                if (s->regs[addr] & CRYPT_IRQ) {
> > -                    qemu_irq_lower(s->irq);
> > -                }
> > +            if (s->regs[addr] & CRYPT_IRQ) {
> > +                qemu_irq_lower(s->irq);
> >              }
> >          }
> >          break;
> > +    case R_CRYPT_SRC:
> > +    case R_CRYPT_DEST:
> > +    case R_CRYPT_CONTEXT:
> > +        data &=3D ahc->src_mask;
> > +        break;
> > +    case R_CRYPT_DATA_LEN:
> > +        data &=3D CRYPT_DATA_LEN_MASK;
> > +        break;
> >      case R_HASH_SRC:
> >          data &=3D ahc->src_mask;
> >          break;
> > @@ -589,13 +838,19 @@ static void aspeed_hace_write(void *opaque,
> > hwaddr addr, uint64_t data,
> >          break;
> >      }
> >      case R_CRYPT_CMD:
> > -        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not
> > implemented\n",
> > -                       __func__);
> > -        if (ahc->raise_crypt_interrupt_workaround) {
> > -            s->regs[R_STATUS] |=3D CRYPT_IRQ;
> > -            if (data & CRYPT_IRQ_EN) {
> > -                qemu_irq_raise(s->irq);
> > -            }
> > +        /*
> > +         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM,
> > which are
> > +         * added later; until then it keeps the temporary workaround
> > + of
> > only
> > +         * raising the completion interrupt without running the
> command.
> > +         */
> > +        if (!ahc->raise_crypt_interrupt_workaround) {
> > +            do_crypt_operation(s, data);
> > +        }
> > +
> > +        /* Hardware raises the crypt interrupt once the command
> finishes.
> > */
> > +        s->regs[R_STATUS] |=3D CRYPT_IRQ;
> > +        if (data & CRYPT_CMD_ISR_EN) {
> > +            qemu_irq_raise(s->irq);
> >          }
> >          break;
> >      case R_HASH_SRC_HI:
> > --
> > 2.43.0

