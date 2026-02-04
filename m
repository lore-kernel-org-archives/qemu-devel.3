Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F123E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8d-0002IY-Gt; Wed, 04 Feb 2026 03:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8b-0002E2-8h; Wed, 04 Feb 2026 03:21:25 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8X-0003UH-WE; Wed, 04 Feb 2026 03:21:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk+GnXODHNXd+aKJJ8KQAQeH93paVCWkcfsYnHF9SHr7NY6OpXL4iLGwugVmDoGu+MnFooftoX+Ieh0jWgJ8kQU9gcU/iQtAIDBmmzPEJRVqnbnEi8IBpsvD51d60krQdlnVa0SKwoqJSOiY5FWIDjEsHnErkGAieFt3zZG/nXJMxkJacDnmwydtWJMDrlpPRG9Ac/Z8d1gFOfdv4mGCF2zUoY0qh2sc/1us5yKpHa7MoYSPW7OERuixq0PZaM0P4vmFTMHRanTzu0615bu+ISYW0/AyzJUAYduaC0YYjqwYe/ek/TtS+4OpQYOOUQnDJKwhCkoFmr2wMIw3Dx/POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfyqhpmH+uYU0qaKTfpp/7usdbl8922GcAmRi2f9vwc=;
 b=eN7h2QtHUMvdE3O3kLGOsSfJYWx4oRDGNvJY75Dn6bcEH4GG7Ni3xxE3Z5yfskehl7YOETf2sqBarl0zskXYccbtJskrsDhzsk3QDEGyYhDthTxS/gQapgGMUhD11T9WnQpzkAamo/hmIg4gsBWzBPSgOSeH17C2rY6oh82jZlRrGDlqBGTSK61jDR9HtPoB2ptRznRj5ERD7pnm2/HlaW3dCCKX5UjmXC/Hg43X5uIIUAuyUG23deIqdWSnFj/VCKaz5ep3TPAtXEgde6x96mR1MPrVZHsYJNqnuX+BlLJgITb5koZ3OArgS3o+8FuqsnR2P4wSfpzPpANDAOLOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfyqhpmH+uYU0qaKTfpp/7usdbl8922GcAmRi2f9vwc=;
 b=g9eJWNQfMnqrxFeukdlDwVB/FXqROBtkRMxLIIPdmszATmKl8zR4vzBDdkmII/wDDAHIIB5J5aezFx0ptnsuE7yZR14+TJ3sn3wz2a3nWWXgafROw0qWMWakGy4pYm2AZ9LJKpMf7r1/ggeSWWgAUFXdunLQg5dzm8oB/Qd9Fge7OqbWlfSpFEo8i0zpJxBvdwncgOs5Vjrs59ACD1Ohtyvv9CQqFGwXYGKs8v4C20ftN1QIFVU0iNFtx5ltDUs1b9c94p2DRu8BET4IWEYgO9YYD5NdK/ybAV4TJv9jDxb2ZicX3IaF6O5kDht8sZ21yTvtZuvZk8NVe8wXrcc8VQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:16 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:16 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 01/22] hw/misc: Add LTPI controller
Thread-Topic: [PATCH v7 01/22] hw/misc: Add LTPI controller
Thread-Index: AQHcla87Uxe7Rr5k9EiQ6ids57Se8g==
Date: Wed, 4 Feb 2026 08:21:15 +0000
Message-ID: <20260204082113.3955407-2-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: b3f0734f-4eb2-457f-240d-08de63c65dba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?s8XwAygUUWVn+enPbt4LZLvGVBEzgP4B505b2EN9BgWJOthWbnIoUkV62S?=
 =?iso-8859-1?Q?BI7aTWpqwuggO/rG0iBa9AISm3RDZ7YJ3gYBAx/X7aFZkspcTxegjyGzvr?=
 =?iso-8859-1?Q?r08H9l6FELgYeWWhERFseTF4cYB2gp3d/WSe+y7driU8+yJIj/xGY5f9YT?=
 =?iso-8859-1?Q?p4AoQ6enra9U2oyjsMDVe7ASII7Q3vsvlWv+2BW0F3TLbezQjSbJ+UBe27?=
 =?iso-8859-1?Q?nsSRYDJId0RRUXItrdwbqGb9k8Q6eLN7Skf0YW44nWPIiFJkEgha8nS6xD?=
 =?iso-8859-1?Q?ae349M+7h7m3ODzvMVUHnF7X7vfoKl5umh86P388BLAZK8Pc5FFTLY3n4L?=
 =?iso-8859-1?Q?ko44eNUWT4BVUXNoETeeO9u0Fovly4i53F99YukQhTrHDeB2r+wEPzRUDF?=
 =?iso-8859-1?Q?tvghOe9XIaSgDJouoS1o8tc6i9IHTlbvKvKV+AQ5xkhThBQWwhFKc0jBpI?=
 =?iso-8859-1?Q?/bBqAFCgXzHt3drbthhjKWNA6AMDFN9XZzHtUIOqAWh0Q2OTopdY7G/Ccn?=
 =?iso-8859-1?Q?LWvd0P8mONCiclWxw7PC3Z83aKkO4lvaFIl0xpWnf9gIAzgmlspwWj1993?=
 =?iso-8859-1?Q?/Qxn5ySlZyGym9gZstW3JLundT2LXm56KNLi7z8oyzJTTKRqv9YbRpaVsG?=
 =?iso-8859-1?Q?+QFK7itcTPR0Tx/m9XBF4dA8IiaxUaMfvKMycMC/6l4TYIFOjByuBHiEnz?=
 =?iso-8859-1?Q?ycXjeYhaAWitInvm92PHKtvI8kOroVTQsYYh8fdFMPZ+Xihe3iUvJQRmqM?=
 =?iso-8859-1?Q?BRJTo9T0Vx1RJD4SNHyMJKslPKIJY+xgTLCDkEB5/s3kIRv65AiPAduC1l?=
 =?iso-8859-1?Q?dQt/yBAvIZNZHtmCbG3+9MiQTehr1/tlqV5GsIldMjIFBCs3PDHlgtX83B?=
 =?iso-8859-1?Q?ga0Au4yXCD65K8wySfINUnVHKk8mzLJ5yHGEHHLi20yu9fSqKk4HsrXHnf?=
 =?iso-8859-1?Q?u3Dpnp7hOKbIn5Tc+cdionJd+n3DQL7obQuRxK4cqoYHXekxacBpbLbZxw?=
 =?iso-8859-1?Q?dLEs/kivTgbl2b46REXwEUID9ucLjZYY3TITSlB8IeEs6gDh8lPiwE/K4f?=
 =?iso-8859-1?Q?FhDXyFE50PWMG/GugbI77orYFXLrcy+YQ7K9M68qEAsZipOvn9keMq9JGu?=
 =?iso-8859-1?Q?4PmL5ATZsAGLOYmAASQ1l3r1k+kBbUV8MMVipNp6isqlcnLvN0yKWZeOgv?=
 =?iso-8859-1?Q?x5BzNCnpz50mzUJONTT4g8E/oRKC9SE1CQTH79LnhqJZ/JuLYkXQhWSKXu?=
 =?iso-8859-1?Q?u2crWxXm/TGFac7yVcrDHngpO935Yxx70fgu0y1P4T+c4OG5UbzMQjwyNx?=
 =?iso-8859-1?Q?N77p2VS4oiArlhxYzN1/mRtUM5g20L3/CCP5FOhNYeEI9iG49cVVPZxI88?=
 =?iso-8859-1?Q?D6xwPUdIQTUAiaB3Ho1iCdt8DiQNMTeHkWvuopDPgIbxqX50/B56FOlTNb?=
 =?iso-8859-1?Q?VzyCvz1t+FpPeIUlP1kHs0vTnq3HLk9MJFwit0/jKMIwbAwiq8DwJhi4/L?=
 =?iso-8859-1?Q?/hNkFGovcrTIOUCetShodk2y1oT4zyRqT72gH8d0y/ulqu4vAol5rnC5pL?=
 =?iso-8859-1?Q?EUk4wmEi8Guoy5H9beT64Tig8ZT42xVbbvGvHCkRtWwmh1YEwzNOq2J1Bq?=
 =?iso-8859-1?Q?JwVpRMf62TCvYQeEFgSsA9FgQOSA476HtjJZH8Il5pVw8w7PWwp/5myi7j?=
 =?iso-8859-1?Q?MaM+CE5DQIPcUgchBrs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uB48PlKx8lrFbyHPShKMPo2Nf3RSwXFJ9W2JOqFU8fCx4LqXByfLjAKDuw?=
 =?iso-8859-1?Q?lbTzmXGzZH3NIoZ51ZrlcRSEYLX3Ts9aIkdoRD9vwtcmDvVZIWkhQdcJSf?=
 =?iso-8859-1?Q?uX8icGppo9m7lS+CTm0Jzvsy3fB5yUH63tiqGjGKojVImp7Td+eJJAPGl8?=
 =?iso-8859-1?Q?yS13f8lqpGthJILSy3DCEB+X0xUpe4+gmTUL6WjoRwEoTr/tlytxV0ZwrB?=
 =?iso-8859-1?Q?eozG2caxTJTfPWifWjlxTz03hdT4RL6HeYIxACzCi6yPIroPkysiVXCNcj?=
 =?iso-8859-1?Q?TC99QrWhc9B8sIK3UmfqwvyuNnm6yXyVltriRu9tAb5RcHrRPZ8kQUUoUl?=
 =?iso-8859-1?Q?pbMlXIOmnkhxUlRTPx3qFX+FnP6LF3wHAhFdzyi0QESPv3FdI/CKhwaMUB?=
 =?iso-8859-1?Q?rxy1E7COgaWp1vvokAkBnFxHWBvAg1los/XQbkFWQOxIetaqFysh/DlgbJ?=
 =?iso-8859-1?Q?fl/qzAKvXpDrTzNIfZtHLBhpcsNUUIeGbvNWFUMdLdxj+QdD18W90lMTYA?=
 =?iso-8859-1?Q?yvEAIMOKwwWpcJ5SvGFaSpNbpHnBbVXI682spE+BQzpdTGFLvb10hvoxkc?=
 =?iso-8859-1?Q?FvBWFkwGzo2LI3IxdHOCzAiFyrlrjo5OZGM6XsWXG2LwN7P//6/RzynUPz?=
 =?iso-8859-1?Q?iRUFtV9QoWGgHXt7tpj/10Ac4bV3b5x+kV8cVKMMFWTQFF0D6Xgd1mBn07?=
 =?iso-8859-1?Q?6pP67QjExI3bGKTWTFJYIcBN/TufJu+TsWsKDOypDeNh0InoXD0W1ugFiD?=
 =?iso-8859-1?Q?Nd41YpowdYG63DxE+Rl90+FqyF8SZS4rmSA10HsGHi7chZe8WD3O4FzEzR?=
 =?iso-8859-1?Q?EQbUZYfMj5pOZrGNYRWso5m58D9YEoTTHZrfBeNwcYBmA53fCGKCTttQ+z?=
 =?iso-8859-1?Q?UZaO69LsLhHRgVOzYTTPrhp2Oh9JMuZ3edDJNeVx2BkHxArel/Os7CCaz7?=
 =?iso-8859-1?Q?i0apmq0Vl9DQTtbSYNvHiD1gPSlYmizZkQnLyM2VpXpZCxNQJLB5DE894g?=
 =?iso-8859-1?Q?8Yqu06jCbRkCZon7pi2jfB+MYNLCqYBa3ALLnwdpjGFN+8gspmTZjDGsjP?=
 =?iso-8859-1?Q?HmhJBjpkYcUSPykAzS6qmeAUA1fs3C2FRg3THBm0gwXsOFilThr5bT+ZBF?=
 =?iso-8859-1?Q?/BKfjrcDuaESrXvdp9/GjR2hD90ElH1Z+yMlzWt8VD+MBAOcjc4Mc5q7dM?=
 =?iso-8859-1?Q?jRtvYkTyX8C6cc5CkApC+Aa+rTaY9TGC4L8sBvudmdOeeeNKMy6Lc0RteA?=
 =?iso-8859-1?Q?5u4h51M2AwXDCdAf+TMiN6l5ONW+oOCGZTY0RaqM8dkj027sXa3j4PdQ6p?=
 =?iso-8859-1?Q?5fpYSIS5MxsJvJ+aaBmIj6eyNd5h1/KtqmsfCXvs9is8hO3L7loFjN5Euj?=
 =?iso-8859-1?Q?8WAH4x9NiHf2nKaVPQb44JtMMhcb6fBWW6D6P7UCvLXuB5ygaLe4wNFG23?=
 =?iso-8859-1?Q?n+mK9LJMcP9E8nupbCyYydypnDu+4oyu38Gzy0RqBzIHe8ZTp1Mglwzuto?=
 =?iso-8859-1?Q?cHQD+SJ2dFQpG1M59jEjVroCvADP04PT/0niQ3lyWz6hVO7JLGpfLy5e62?=
 =?iso-8859-1?Q?OifXQaykfdM1xcS1WLxQ7sNMzmH4+tFeLb9A1iPgCOo/RfFbqH9YaO4hLX?=
 =?iso-8859-1?Q?Fee64a7N2sHOb16G9XRnnWgEB6o9J+mkdifg5JyqY9gBZ65wuAYsSX9VVJ?=
 =?iso-8859-1?Q?+a3h9FDCAGCCGf1e+AaGsNbSdy2Qt+fKav/HAqX1pw95IswnBS19SXlSDX?=
 =?iso-8859-1?Q?1wbydNdyImzOHR+mdsNkEa25wtk3Lzk/qB/MGUF2FuGHIQzVRlO0jB6lCb?=
 =?iso-8859-1?Q?ZDhxBQTzAw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f0734f-4eb2-457f-240d-08de63c65dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:15.9929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcG/YeZp1ftKm0bpQNXfCqbR0e11wMQbZ8yVSTXqm6qNJGHuxJDwRut2UHx5UhzXxGQnWxC+6KO2sJtY1NUlbPHZbjVXo++0ARIcaV/bFTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM=0A=
2.0 specification:=0A=
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf=0A=
=0A=
LTPI is a protocol and physical interface for tunneling various low-speed=
=0A=
signals between the HPM and SCM. As shown in Figure 2, the AST27x0 (left)=
=0A=
integrates two LTPI controllers, allowing it to connect to up to two=0A=
extended boards.=0A=
=0A=
This commit introduces a simple device model for the ASPEED LTPI=0A=
controller in QEMU.=0A=
=0A=
The model includes basic MMIO read/write operations and sets default=0A=
register values during reset to emulate a link-up state.=0A=
=0A=
Implements register space with read/write callbacks.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/misc/aspeed_ltpi.h |  33 ++++++=0A=
 hw/misc/aspeed_ltpi.c         | 193 ++++++++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build           |   1 +=0A=
 3 files changed, 227 insertions(+)=0A=
 create mode 100644 include/hw/misc/aspeed_ltpi.h=0A=
 create mode 100644 hw/misc/aspeed_ltpi.c=0A=
=0A=
diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltpi.h=
=0A=
new file mode 100644=0A=
index 0000000000..3330a49b05=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_ltpi.h=0A=
@@ -0,0 +1,33 @@=0A=
+/*=0A=
+ * ASPEED LTPI Controller=0A=
+ *=0A=
+ * Copyright (C) 2025 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+#ifndef ASPEED_LTPI_H=0A=
+#define ASPEED_LTPI_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)=0A=
+=0A=
+#define ASPEED_LTPI_TOTAL_SIZE  0x900=0A=
+#define ASPEED_LTPI_CTRL_SIZE   0x200=0A=
+#define ASPEED_LTPI_PHY_SIZE    0x100=0A=
+#define ASPEED_LTPI_TOP_SIZE    0x100=0A=
+=0A=
+struct AspeedLTPIState {=0A=
+    SysBusDevice parent;=0A=
+    MemoryRegion mmio;=0A=
+    MemoryRegion mmio_ctrl;=0A=
+    MemoryRegion mmio_phy;=0A=
+    MemoryRegion mmio_top;=0A=
+=0A=
+    uint32_t ctrl_regs[ASPEED_LTPI_CTRL_SIZE >> 2];=0A=
+    uint32_t phy_regs[ASPEED_LTPI_PHY_SIZE >> 2];=0A=
+    uint32_t top_regs[ASPEED_LTPI_TOP_SIZE >> 2];=0A=
+};=0A=
+=0A=
+#endif /* ASPEED_LTPI_H */=0A=
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c=0A=
new file mode 100644=0A=
index 0000000000..131cea9c6b=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_ltpi.c=0A=
@@ -0,0 +1,193 @@=0A=
+/*=0A=
+ * ASPEED LTPI Controller=0A=
+ *=0A=
+ * Copyright (C) 2025 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/misc/aspeed_ltpi.h"=0A=
+=0A=
+#define ASPEED_LTPI_CTRL_BASE   0x000=0A=
+#define ASPEED_LTPI_PHY_BASE    0x200=0A=
+#define ASPEED_LTPI_TOP_BASE    0x800=0A=
+=0A=
+#define LTPI_CTRL_LINK_MNG 0x42=0A=
+#define LTPI_PHY_MODE 0x0=0A=
+=0A=
+static uint64_t aspeed_ltpi_top_read(void *opaque, hwaddr offset, unsigned=
 size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    return s->top_regs[idx];=0A=
+}=0A=
+=0A=
+static void aspeed_ltpi_top_write(void *opaque, hwaddr offset,=0A=
+                              uint64_t val, unsigned size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    switch (offset) {=0A=
+    default:=0A=
+        s->top_regs[idx] =3D (uint32_t)val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_ltpi_top_ops =3D {=0A=
+    .read =3D aspeed_ltpi_top_read,=0A=
+    .write =3D aspeed_ltpi_top_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint64_t aspeed_ltpi_phy_read(void *opaque, hwaddr offset, unsigned=
 size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    return s->phy_regs[idx];=0A=
+}=0A=
+=0A=
+static void aspeed_ltpi_phy_write(void *opaque, hwaddr offset,=0A=
+                              uint64_t val, unsigned size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    switch (offset) {=0A=
+    default:=0A=
+        s->phy_regs[idx] =3D (uint32_t)val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_ltpi_phy_ops =3D {=0A=
+    .read =3D aspeed_ltpi_phy_read,=0A=
+    .write =3D aspeed_ltpi_phy_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint64_t aspeed_ltpi_ctrl_read(void *opaque,=0A=
+                                      hwaddr offset, unsigned size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    return s->ctrl_regs[idx];=0A=
+}=0A=
+=0A=
+static void aspeed_ltpi_ctrl_write(void *opaque, hwaddr offset,=0A=
+                              uint64_t val, unsigned size)=0A=
+{=0A=
+    AspeedLTPIState *s =3D opaque;=0A=
+    uint32_t idx =3D offset >> 2;=0A=
+=0A=
+    switch (offset) {=0A=
+    default:=0A=
+        s->ctrl_regs[idx] =3D (uint32_t)val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_ltpi_ctrl_ops =3D {=0A=
+    .read =3D aspeed_ltpi_ctrl_read,=0A=
+    .write =3D aspeed_ltpi_ctrl_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_ltpi_reset(DeviceState *dev)=0A=
+{=0A=
+    AspeedLTPIState *s =3D ASPEED_LTPI(dev);=0A=
+=0A=
+    memset(s->ctrl_regs, 0, sizeof(s->ctrl_regs));=0A=
+    memset(s->phy_regs, 0, sizeof(s->phy_regs));=0A=
+    memset(s->top_regs, 0, sizeof(s->top_regs));=0A=
+    /* set default values */=0A=
+    s->ctrl_regs[LTPI_CTRL_LINK_MNG] =3D 0x11900007;=0A=
+    s->phy_regs[LTPI_PHY_MODE] =3D 0x2;=0A=
+}=0A=
+=0A=
+=0A=
+static const VMStateDescription vmstate_aspeed_ltpi =3D {=0A=
+    .name =3D TYPE_ASPEED_LTPI,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]) {=0A=
+        VMSTATE_UINT32_ARRAY(ctrl_regs, AspeedLTPIState,=0A=
+                             ASPEED_LTPI_CTRL_SIZE >> 2),=0A=
+        VMSTATE_UINT32_ARRAY(phy_regs, AspeedLTPIState,=0A=
+                             ASPEED_LTPI_PHY_SIZE >> 2),=0A=
+        VMSTATE_UINT32_ARRAY(top_regs, AspeedLTPIState,=0A=
+                             ASPEED_LTPI_TOP_SIZE >> 2),=0A=
+=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static void aspeed_ltpi_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    AspeedLTPIState *s =3D ASPEED_LTPI(dev);=0A=
+=0A=
+    memory_region_init(&s->mmio, OBJECT(s), TYPE_ASPEED_LTPI,=0A=
+                       ASPEED_LTPI_TOTAL_SIZE);=0A=
+=0A=
+    memory_region_init_io(&s->mmio_ctrl, OBJECT(s),=0A=
+                          &aspeed_ltpi_ctrl_ops, s,=0A=
+                          "aspeed-ltpi-ctrl", ASPEED_LTPI_CTRL_SIZE);=0A=
+=0A=
+    memory_region_init_io(&s->mmio_phy, OBJECT(s),=0A=
+                          &aspeed_ltpi_phy_ops, s,=0A=
+                          "aspeed-ltpi-phy", ASPEED_LTPI_PHY_SIZE);=0A=
+=0A=
+    memory_region_init_io(&s->mmio_top, OBJECT(s),=0A=
+                          &aspeed_ltpi_top_ops, s,=0A=
+                          "aspeed-ltpi-top", ASPEED_LTPI_TOP_SIZE);=0A=
+=0A=
+    memory_region_add_subregion(&s->mmio,=0A=
+                                ASPEED_LTPI_CTRL_BASE, &s->mmio_ctrl);=0A=
+    memory_region_add_subregion(&s->mmio,=0A=
+                                ASPEED_LTPI_PHY_BASE, &s->mmio_phy);=0A=
+    memory_region_add_subregion(&s->mmio,=0A=
+                                ASPEED_LTPI_TOP_BASE, &s->mmio_top);=0A=
+=0A=
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);=0A=
+}=0A=
+=0A=
+static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)=
=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    dc->realize =3D aspeed_ltpi_realize;=0A=
+    dc->vmsd =3D &vmstate_aspeed_ltpi;=0A=
+    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_ltpi_info =3D {=0A=
+    .name          =3D TYPE_ASPEED_LTPI,=0A=
+    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+    .instance_size =3D sizeof(AspeedLTPIState),=0A=
+    .class_init    =3D aspeed_ltpi_class_init,=0A=
+};=0A=
+=0A=
+static void aspeed_ltpi_register_types(void)=0A=
+{=0A=
+    type_register_static(&aspeed_ltpi_info);=0A=
+}=0A=
+=0A=
+type_init(aspeed_ltpi_register_types);=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index c444e030ec..f7f1b0da75 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files=
(=0A=
   'aspeed_hace.c',=0A=
   'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
+  'aspeed_ltpi.c',=0A=
   'aspeed_scu.c',=0A=
   'aspeed_sbc.c',=0A=
   'aspeed_sdmc.c',=0A=
-- =0A=
2.43.0=0A=

