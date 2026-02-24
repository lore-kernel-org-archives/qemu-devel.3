Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3622EFB811
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLQ-0002Ht-5F; Tue, 24 Feb 2026 01:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLE-0002G9-Cj; Tue, 24 Feb 2026 01:56:21 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLB-0005Ll-7J; Tue, 24 Feb 2026 01:56:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+vHfCwyl3ZcmWG3cZezp4yI+a86+aMZNpEVl1+xQ46NHYCEmu/Dco2CGvcJgFADWGc61MWNQJvX5usGSZcGRQbqTN8Df/TL95e4I8mZ1CBNN068XZpdDiKcbAtGfWIW6W8C42uRAlihwBNhVDOpFdL3rT32w1V9OYZ1t2X1HFUCuXvI9M4gZWp5hO/1lNyYVKrkT87Rzntg60fOkjkiPEQAo/puORZhFcHkRWoPuDOie5P4QrQ1e9QxSBE9QzqNOgHfd2rSsXz7L4hSO9VZGpqJ7W/OYHc16KZbhDV9o1qxSnlJh4lS1etu035N68eje8wGhS813in3mRx8zNB/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUThPKLeEk2SduZ96cfpZzQEtc1opoilxpVzXx1Z8ZU=;
 b=rPefxHbbd955EFkHCbSbeBctWlEV/jycD16w8G2A2AZwe/SMhh2ld8ulswOgBigUlDtB6DTDM1Z6WqibnYF0kerryqz7d8UG0iJou8ECgKER2WJRboJTxe8MGoxVlZbyCSx89Bfp6k4SpwOitTZIs6SXWrlXtdank84TMN1JLyVsx83A/4qY4P3R7+CEdNlOg7bS9zo5G0tzMacJMa0hOZ5fxmxOItnUXoB8QIbQDOxu6Aij1UqYad/Eq6ExLwx+v6wLORewXK88gpG4nviC1daXh9LC2O80Z9BGuWFequUy0k39pEM/Tc3rmQvM4j53RqP+jwoRRUe7gmBW3KixzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUThPKLeEk2SduZ96cfpZzQEtc1opoilxpVzXx1Z8ZU=;
 b=Q3eIP27FgZo8UtFTs2/H/ermzdvFH7h0x94u5D8+8FU3SgVJhKXvwwL2VxEaBjmR8qh9cm2/EtpmBZa4LvrZB11JdeKIgre4QkA8XQu7tR1O67eqTDVNkps+h/ZF2+ScNh1J52R+TfRWUB7F339bIHr8+DG0h7wQTCq0QdekBOlEa6kZdSn6SH6AT+BPu0j3J8JWto/qkeDeBCPhARYvGW5UEsl/5/xLgTJCroWUalBvhqY9eOZi+uDl2HVFMk3RvXiULjT+ZUdErcPiKH837vUKlQltdpco74Vl5yWyDnyYpQIWyNqh/6CUZ/zJ0V24SiwP/BV/DZO/YcZkUrMHZA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:01 +0000
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
Subject: [PATCH v3 01/15] hw/arm/ast27x0: Start SSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v3 01/15] hw/arm/ast27x0: Start SSP in powered-off state
 to match hardware behavior
Thread-Index: AQHcpVqh2WqhyrWo80yQ1R5bJHHuZw==
Date: Tue, 24 Feb 2026 06:55:59 +0000
Message-ID: <20260224065556.3847942-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 16df7865-cac8-4074-2ecc-08de7371c592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?oASCcnEN1ask1WUrMpuLh0antzarZVmq2P/YhRbmGlqXOCh+vmzxz5gtwH?=
 =?iso-8859-1?Q?C1LByH3YQMqz4W9cFxJUbKSrQhUqsi4xcpq3TsPrX1VPzo/AHXQpxAL9XA?=
 =?iso-8859-1?Q?VuMt8erJjse6cPggqcGfD8wfT2lvDYLa7gD4Qa9MSNL0bE9KaFhu0BFgId?=
 =?iso-8859-1?Q?Ni270C77DSlzAlaSeUke8JJDz9gAg4bq8EnmYjpUMshkc+V5ZcjE5BI+sn?=
 =?iso-8859-1?Q?faog5nZ1X5MxNrIIXpHU+q62Av2neLlh2jH3l88okSVCdsA8KUW6eQ8t7u?=
 =?iso-8859-1?Q?bYkq3DRJ0d7ZggacYdu0wF9XLiYrSJs8KhMmIuO7CiN1x8EIIAoLbOmbnO?=
 =?iso-8859-1?Q?dewczmZcHx6oa/79sVjp8d7G7QPeeGhuJlX+CkoV1FchgLpp2U4oy6I8T1?=
 =?iso-8859-1?Q?GIMHn+6+81fELAti/q3sfbu/rCIp4pmEkN/LALCE/SAepfJcX3WDAnbtb0?=
 =?iso-8859-1?Q?au+7s3sRwHzFLkoL6YhRF8YVxI5JQTN7yU65S2bcj0LTyXiUNTjT8MmBnc?=
 =?iso-8859-1?Q?glbEpfNGHdCavgSoIrfoZHrw9nzFENRkmk7kEvJyekAWt658i3xS+ylNzI?=
 =?iso-8859-1?Q?psvtKsgL5WIS6bjEyXVxXWdDCJh4JGNKX3aJLlDyU0Bn3wnwLJypmvq4Ci?=
 =?iso-8859-1?Q?UfCP4/dkF4YnJHg6bO8A4YRW8leKRCfEOtr6XN+jdVsyuDpB9OUM4glXWK?=
 =?iso-8859-1?Q?hbogCHE12DDV+7EQbWK0s/cIHjt27sDJAGow1soDFj4oy40bFsAMPZYs/z?=
 =?iso-8859-1?Q?uS2EPZPOuCu4ocnOIhrQ4mhjfKAz3az505Stl+65v2suh8KyHL5wsxq4n9?=
 =?iso-8859-1?Q?hg6DabqVuwidzNK5KgDOKufSUZi4NS9B3I+JMe63uNFiF8vvkrWYzF65Pc?=
 =?iso-8859-1?Q?L/UN+Z+rfhjVvgL5hz4nHenHaAHjwCvlBxrPlHolezficz3sG9cE5IdugY?=
 =?iso-8859-1?Q?/eoRZqNdaJhTEs8tKAIxpY2oVbciFbavxZHr7+Ly52DMGRFaQO9Z5U2jZ9?=
 =?iso-8859-1?Q?Jk0LnE2OUYCXsFr2vITcNvXnt3ujOZ+i088CQbE+xkXhFV4AtADwPyfj3t?=
 =?iso-8859-1?Q?gLJF++tybzdYHH68DzwnG6wQFpg4HlcX9ekH2C+INApPVKyFBovWn3HhTJ?=
 =?iso-8859-1?Q?4yI7juojLyiCkMNdh9CzDY5UxVWoB2XdcCuAL2uxhcLuhoJ/LoXKZyJ24A?=
 =?iso-8859-1?Q?6s7CgLvJZO4iUNNTE/79iLnplBMc1c3wHjmcfPMB9cPyTsj2R9s5PaG56K?=
 =?iso-8859-1?Q?cg6ZuqDTB1EqG5peAg8HlXQbe8SKCtRDGZmu+7DdrtbTdJu+R80D9gWfj2?=
 =?iso-8859-1?Q?o5oEdCTMk4XCQ+azpriUoCiw8XNGbyNcWp/QpIMoJvvfKvlFGHu13xU7Bm?=
 =?iso-8859-1?Q?+zlPgYXBB4mlKDjJrZhwZ6lpkMxXK3uHDFkBW7Qry/n+zGeuDGYI1lrlhH?=
 =?iso-8859-1?Q?VM3v4uTOG++FOQnyWcXRrC+e2qNMK4NECQ5PgOJXE8pf54QuAmS8hkgcjy?=
 =?iso-8859-1?Q?Q0fvYluNG3FH9L94qkTGiu6EbEs5SE7oAJ2C03UFHcGLiE5jq/o8tWHplt?=
 =?iso-8859-1?Q?npYOmADJcR77xA8nXGYarBHjMW1zpW1+cINzvBF6NAZ6jFEAn0spgF6XTQ?=
 =?iso-8859-1?Q?lFHoKB9DQBC10MTVlqHpdpB9DGrCXfZaJp7qWiJ/4AH4nRfqWh/3TY6T1d?=
 =?iso-8859-1?Q?OlwHArnvw4tcU3AzH2ZSSsBKZAkv961JyJYwG0mk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NNoJvr3OHGvpz3iLPH0mmZNKxYTr6AQHJSjbeIk8pJu6juvqRtC9zxT6EB?=
 =?iso-8859-1?Q?prI7gOXliYkWSiysidvYTdR0JiUyUGFgu2sFvRhODPICbDj/wfFbLPNnZG?=
 =?iso-8859-1?Q?/Q3ldIZ4/TpACVqrNOIAax6MPLYgfwB1f2okIKHzFTOOkFSK0WDjnZ65zw?=
 =?iso-8859-1?Q?4txvcQq6NCWMCOqeZwF1WvBDoYQo1dbP37VX0OXcCE8zxlIazOi6ukAJLZ?=
 =?iso-8859-1?Q?80XNM5BRQYlQJwxMPjLJug10hiUMmIJDInZmJBHSzuVBFGLAn734x8KfjT?=
 =?iso-8859-1?Q?cPHK+MiMaAWyXaXdXUe7USuYZl29h1wcDVji5E2PdQ2SbhRkm9Cmyy+m8Q?=
 =?iso-8859-1?Q?YfbD49Z4GJlEJZU2rHIglNq6iYtPCCc53s1Djf/rH41MZGTn5FlIabNaAn?=
 =?iso-8859-1?Q?+z2Pq/EV9dbg+F9NbCMmM8mapp4cFC1uzqgNIXAT0isc0+jqvV62csWW+0?=
 =?iso-8859-1?Q?pty1hm3qleSyz8x5xbVMsr3pZclmFlxZKtXJnb9RZYWXd25oZqKvpmZxC0?=
 =?iso-8859-1?Q?WFHXqRWaB2wp7Ln4dQLdIRddsOgXArNFWZL4WhFcDKclF90dNJZOPBroBY?=
 =?iso-8859-1?Q?QiFOYydedeUu10wGcoHq3NG3HlImYS87ue0D4DC6aYp400+sHMQs1IMPsv?=
 =?iso-8859-1?Q?VEjQ3camcSKzbQ6Um3uNdAHvpwSQ1xWHYJKI4vzOGBUd2oQpqtiuI+KlMc?=
 =?iso-8859-1?Q?78p4Bkt48P69O7QC1HooD0MI1Hw86fShVlcPA4vDuAoKjoMgI40p27PGd4?=
 =?iso-8859-1?Q?qw1biC4Eqm/uuXw4OxkL8RGLTWAMkSXRyXaT3+Nd1h5UOUNy7iC6ScF5g3?=
 =?iso-8859-1?Q?YdzgRjjsVXiI1emyarqrugIqX/snh1X4lajeZrfyZeHg8Gc4NmyOX+5F8+?=
 =?iso-8859-1?Q?F2oaes63CqqGZCrktvaP3aQ2foWqfrVS77FElYIMCo0SCehi9UqVZXQmDB?=
 =?iso-8859-1?Q?1UyhD03JZKs+p00qsBDVTK5fntP25VLlu7ZXqzzNmYu2ZVDbNJTN7KFM2w?=
 =?iso-8859-1?Q?O7K39PVIYXNR+VFHfIMgwrwX8nBXsE8ENdvqFmm74tcQPdD8MYo4jV73oo?=
 =?iso-8859-1?Q?uee4KYEsXur2i38a0knDa5atqbq4yvpf3Tg4qIBrWvgf9lporsHYqkSWF9?=
 =?iso-8859-1?Q?r11Oy+rj12oIX23UVU6THAG6fyTkIJo/IFNxGWAqWT+bCXtsKuha6bDhMc?=
 =?iso-8859-1?Q?buwPDwz74q2iVCJLr+b5lxsJH+VDHGJcx30pTYs/wH4YRYZsXNtZhLK/T1?=
 =?iso-8859-1?Q?oUo6Fs6ZMEf0ihvvbfaeDjzS72hcHhvrphG9ufHtPCGV0JFCK9dhnSA7mN?=
 =?iso-8859-1?Q?5iKzGPz2H2ok+EJJtjApsrmCHmcdRULOqYIj7FI83z06olQU/YCIE3vYrC?=
 =?iso-8859-1?Q?DgGCFFICFh9HcGftEH+36jGKELFXkMWk6qit4fBVOAAlUGJDVdgDZNvKTs?=
 =?iso-8859-1?Q?nmsG9UZUvv3qHEFuOc/AZyZnLOiqTSBnaFoOOzjbHv7P2z2yXfp9AYT5By?=
 =?iso-8859-1?Q?iX341XFj7Bd0q7I7DMujQTR2nkusAz7/Qx/EzJjWYmcy5SXVdyfL4lXb/C?=
 =?iso-8859-1?Q?FWch9CjYlzPZ/ynxCkXxP/6UeCJSpN9myKvgKW2gLZ+S98vEdjCm46/ytE?=
 =?iso-8859-1?Q?IGdSjTSMkDfjjncd1i08MFoYk4Kj50M3fvZBf5EOR8E3LapnJzHC0WGK5T?=
 =?iso-8859-1?Q?uXn2nI59KOl2H681nUrtNP3GXXkZ7tptt9NJDfbEg+RO0MuB5oeRkOmtsP?=
 =?iso-8859-1?Q?RaG4PeujGCcYikCjZBSusYPqv0q4XiymI/6Ihmmc+sgXx03TVI+r4UNagP?=
 =?iso-8859-1?Q?55tWo4C6Jw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16df7865-cac8-4074-2ecc-08de7371c592
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:55:59.0992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxPPHvtMURt0+QU4pTxHRjB0IpCoXwiXpWRbHi5gDKX5EJM6pWYNkQScG5AxsCm6V9ICzOCGJn+nwXQCoOnKvdqlLRbjlmKtZ2hCV6YPJC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

In the previous design, both the PSP and SSP were started together during=
=0A=
SoC initialization. However, on real hardware, the SSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the SSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the SSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the SSP's ARMv7M core. This change ensures=
=0A=
the SSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls SSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 9b12ba6743..437fff3311 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -165,6 +165,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The SSP starts in a powered-down state and can be powered up=0A=
+     * by setting the SSP Control Register through the SCU=0A=
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

