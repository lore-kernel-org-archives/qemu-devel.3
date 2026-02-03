Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C1AE73165
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e7-0003Vi-HO; Mon, 02 Feb 2026 20:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dw-0003Nq-VL; Mon, 02 Feb 2026 20:55:53 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5du-0007rl-Qk; Mon, 02 Feb 2026 20:55:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds7JW4YSrwrKsEUP8U2cX9UgLvxGDSMBbQSfEE5DUUOXYwuOpI4yeohyuw7/ZNpj7mGZrDdkHIrMCOi4yKi7T2+gIB9Jt16Pk8G4oJWXQUjZH03xwSIGK8Uyrj2P43bEdVSLUcrgBshWvQ0ZCmHVZNsqfPQ5Z8ne4+PEXxV/wNbYzxaQjM4kqTAnYYMUdVyKgUSpfS7PUn0szVJ07Cg8X6NYFeGNDgb967dbU7W5k2lTyaYY9eS77G5/6o2h7GXH6Eor1z8lXqARJyPGHHeBC8Pzfq0/niFzOeAljF+iRTAn2SS/QH5lHRCuVq5yBimXU33Xt0UYXQvUxWYkg4WbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/l+sMJisKN4qT8gE2EGyiL8d34bsEG8Ub86pDvTHsk=;
 b=OwxqS6hU7xsgjcsOTqabj77kLdYECOfMnXa/o/E7mh3LrtkxcdxtTCcyiqhiE4ClVnhyfu11eiamm96bPD8QQvh88KP27qKZdoyYIFVxF+pFwBFymymcAb9Jv3s3B8P4IH3J6uRu4wnzjNPA4TF4J2HvmMk4mPpxYkWgFNLV9POJqhGxXgo/QeisJreWmvYXk+tveehNUqZ8kzQvqX+xJdbW7VnILJFWUvbMpgy38RxqxzKny+vstQdQW1+imTgJtIdHC4bLkC4cMJDM3BiTeUTnVPzENmc7CiBRPJwFbgBJag6Ps02ON6PpFga+94+jZ/l8gyQ2hF1DeLwggtVdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/l+sMJisKN4qT8gE2EGyiL8d34bsEG8Ub86pDvTHsk=;
 b=Siuoe3jz07qFqejolL3Syu3WvJMiflguntYfiFTF+T9nDqKmB33TqAo6KUpubgjqrzK5dH3LIaR6CoDFNdZd3THJnfii99Mr5MHp2PZhTYrg7kbU149rJcDJBVKOUzOKZHofJWF8oBW7pj9BOaHY55YuzN8eRpj8cfduHWtRLxmfrcuRIerzaSCr4tkAsN8AUESSZ20PwMZxhpEfkh78unTacau1HkxhtruBwlTzU0TUIZZJgDIvCxkOWOOsdYeS3mohoHNVKczsE4YF8a6LJ89a4t8YHP3PSZRd5MX/J8eSUxzzh26RJ2Re2hQh42IYlJQvgWSSh3RlvaJLcZS05A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 8/8] docs/system/arm/aspeed: Load raw U-Boot image in
 AST2700 boot example
Thread-Topic: [PATCH v2 8/8] docs/system/arm/aspeed: Load raw U-Boot image in
 AST2700 boot example
Thread-Index: AQHclLAxcXPppL3ykEOCzHMJrDd1oQ==
Date: Tue, 3 Feb 2026 01:55:37 +0000
Message-ID: <TYPPR06MB82066553EFFA88182689036BFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: dd2d3141-f9de-445b-fc7a-08de62c753ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?C4GWa8s7k431EoDG33qbg1wP/1SyOJKyOFVEo+SnSQP5P9yp38KGzpmWv9RA?=
 =?us-ascii?Q?yUYeaJfBBLA6Xl5R/Act4a44GlKR1kYZ44mxAzgCxaU2Vh1lI0zTbzwY/7oS?=
 =?us-ascii?Q?k6uvv8GMaixCmUvW/TMiPVaXMpQbGYPyuHY+XmQDK4N26olfL56YI9pQ7Ofb?=
 =?us-ascii?Q?5EHbGaLtQQu/OicxKPPjPZdCZ+be+Nvb9iz/KZ09lc+bkJUYGK2bTyZYqYzW?=
 =?us-ascii?Q?fTEzsht5KOwu8Om3UXTDBXCRNAZ5nNMoWCqWCO5LWnHhudxuLjxDQYrB+YUG?=
 =?us-ascii?Q?uHDwmj22KOgo/1Xp76gQ+QYSx9tRhIgCY4xy0TxI91rQvBxOgpUlCLKTSSkI?=
 =?us-ascii?Q?YeSb3rje9UMkqFTkpOoo5m/F5FeNMwF9iWxsvBbs/acwiuc7/HESeI6TWBQu?=
 =?us-ascii?Q?0+7puoy4iotAs6gRJF7a01x9/FhqqSE5SVxL1Rzm+dUJVH/Uv/xK9hbzM6QW?=
 =?us-ascii?Q?juHnP1vsHAAii+iW0mMtTUesrO9BjM2fw4r7Ccbat8++zqatYCsiHTNiTrkW?=
 =?us-ascii?Q?k1Esuna4vQGKft64pBLuFh+iwlxllW1ik9a7w6NieJQKpSIsNZkMwirXhur1?=
 =?us-ascii?Q?mD/LiKZoS5o5weky1vPeGhkwuiwRm9U+LrN/vydI7lacngA6A41g/4Yd5nGs?=
 =?us-ascii?Q?vRbDUZrZQ6u9y+hD41a10gEJ1Ca1kzNdaq3sdXEzs837QroCQIebifZCZmMt?=
 =?us-ascii?Q?mWNlXx1KgYRqXUg9Ib45ObrpYd30DdBMyq0QzVtMUy3H2nox5BAEXc/b6aTt?=
 =?us-ascii?Q?w+0J6oymIKUoZlngskrYFji/ODr9TFcXx6YCfJLXGJhlE3fNu0aBsFo3EwqS?=
 =?us-ascii?Q?ZP1IQF7kIADML6EctOYf/rUvh9G6o3w/FotrjrvICrj2wP7VI2HcM2C25GVX?=
 =?us-ascii?Q?igIl9VTX8D6VXxbkwtV724dNApVAtI0MmcysCHyOMi6PXYdEoFK4ONMk+656?=
 =?us-ascii?Q?RlgTS+awNB6j7oYkTHbzzgD4l315ysJscX8bC/Y7EYIKsQzbfcZhqbcukyX6?=
 =?us-ascii?Q?RA72+VMdd4fq+B/ZvkUpP1jFgohXkCySgAVP0buItqODAKKVldy+1NOuSuaZ?=
 =?us-ascii?Q?mr6MgEq5bqzxJEGxsqM403Jq0lCDBzMSnP59+wdfNToahyTtrULlQr5T9egJ?=
 =?us-ascii?Q?lcaKehqRL+5kVJ/nLJIzXYRt2Z/DZm+vlXhNLro7ne4zBj4Z5d02RkLN8WDQ?=
 =?us-ascii?Q?szJSe5CDIUU89Gy+MKo8ggkcJuFfusV+H14Y7xXQHkGphINDGsezxarHNytQ?=
 =?us-ascii?Q?RKAwDp83F00e0HssiDob0jkTi2lS8FkdxyRqWywdVNM/h9GQVG+0cFFHs3Y0?=
 =?us-ascii?Q?pLgABPAJqFniBTdPwL6OpnIV8a0FaU/hV+QVZTIlD2eIDcLmFJJAS5OF/pws?=
 =?us-ascii?Q?9EjGBKnlkv0ofV0hORpWXcQbw7xDo8Bu0klqScWMSFnyWzsplCH9ddmh4hIM?=
 =?us-ascii?Q?3m2NCmLSn3KIqM1Iohbozw/0v6rJ6En3O2SAsgv9vIrtTx25SOnrNRPGks6W?=
 =?us-ascii?Q?HNd8847oJ10WvsoRkBQcTdvJ5QqnxznRjl49QUL1IFgfi0ioycqB8Lz95tKX?=
 =?us-ascii?Q?uorqR06Wi0VkF/uKVHP7s+7LS6f0nWllk5VbrnswMu0xFd7gCx8chIqO1ICa?=
 =?us-ascii?Q?Ich7TzFwv2pChcR/p8c1USA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xkxkb7Hj5CN1oJ8P6V6rJLtWRASpOb9Gx3Vwww9kbkUCT3+matRx8Ye0dn61?=
 =?us-ascii?Q?gv72ls7Vo+ZGR3taP7rCzc0AAhaaC6/2xUgcA/cyKCMng9rhVsGZDKeYbptV?=
 =?us-ascii?Q?JsQ4SMm6VVrIcg0WoiMYzDb8eSeWQgXsriVvWEPzH4P8aFDdyqjC49skN2DS?=
 =?us-ascii?Q?MPXCEQuwMTSWSUY4PCb1/4X8obXf+awgBEyGEovTQ87ECjvQ5XJ+5trGfmhC?=
 =?us-ascii?Q?WU5hVCvyN9pOD/vB16V17FEPRyfVOe5HfDOq/ZbDXp0wrHJbdkd3N0ErMGjP?=
 =?us-ascii?Q?61qXb/9URfc+VnErPMJnxO0Zu7tC1IXXNn6W2QpwevBKckLyGNvaH3CGepFF?=
 =?us-ascii?Q?rhNkk7POmLpLBupnfEBkZb0t566fIw6YsV0UK3drwK5t8mTBmyhxHChTb89C?=
 =?us-ascii?Q?FF4zR8cNiJS2HIqFfYwUEoqyanYQ1kS/kcqqVnYesxd6JSEXQ0ofHniSf++d?=
 =?us-ascii?Q?0hyWsmmqnloE6RT8fUlKJuTUCNMy0VtA1gKKS8WTVF+OD2aGWb6C9kCfgViJ?=
 =?us-ascii?Q?PglLHdqeNerp8P5bFgXmv8cjR/x/AgQ7XQ/OmirBtWRa2qjgA7fou/l6VBty?=
 =?us-ascii?Q?ZXqPXGZocfDIe9JaZaM+BBZ0Wl+WVE/hLg+eFMQjB20ap/X797CIZ9k0gtQn?=
 =?us-ascii?Q?y7i9+4vJH4h8ttgVLoT/HPvZs8TYzlEeLgK1RHae1yXDI6rANFQI0mkOvoKb?=
 =?us-ascii?Q?GHsIwKaAolAMpNhx/KFE8v3nbhW3NgVFS3vcYqNeFKARrSv4Amt8FhvBsPwU?=
 =?us-ascii?Q?LZ2lGWuK4R0PaSSZuLVwfDxCkQMU43daDjHYavataRpRhUW64jYG807Dze20?=
 =?us-ascii?Q?P5ofErzzHnXkLtntA3TmR9gN1GB/pwErE9gYHak/91H5xEC/omdGdtoz+Pxo?=
 =?us-ascii?Q?Mo1KZQ3dXc9xLPzZkfkhPEeP2VaU0rVWakinfbN3KyRbQBRQwsQkH403JPlX?=
 =?us-ascii?Q?K3Vl4g9OvD8miuswgsG2NfWRJAN0RArc7Si8hyAb45YR0XQCHfMy4HvF+Nl1?=
 =?us-ascii?Q?JQ1X3ChcqcmbSqs9Al/tgOzosCtrQo0nw0hnnc4hJOw4sjqYco6cn5ymaVQX?=
 =?us-ascii?Q?sLATk/ep5fzxUYAzC0tWkgc62i/5Y5gR7kLTZw4Ct2lZAkcwnXNQ23nZaHd2?=
 =?us-ascii?Q?gTTtjpfSQ1wQzS/vCPSvZgwwR1VsY42vZgG7f16xBnIlL+omBk3Q2jSGDYa7?=
 =?us-ascii?Q?/4+fVL8PgolBCSibLSH92RXGqErpWK6ni+wqHe+tMvyfILhAACjjAk9Q4EuC?=
 =?us-ascii?Q?FYp5qjiDiiqPWt4435LeMm08GnJ6/kmktV/v2GVVNCH/MscrxuDzYp65KgXf?=
 =?us-ascii?Q?a/Rbb/R+QOZ6iyUaLoNshPQnJCaXIT2lyIFT54ruM9rgeRczVL07a4/q5JXz?=
 =?us-ascii?Q?xaeHHwhEt6AIEgghmJnAx2nfiRmy4PFuJi330s8oM28O8i0T2a7Jnz21Ly5N?=
 =?us-ascii?Q?MZYpLJA03HFpiww3+8PEKZJQBYxuopqNQH9KT6Zh83XDyUeeTUXiEQVgfqIt?=
 =?us-ascii?Q?7jV73+38vhOTcQIggh4MXBUYnHyz1ih3+5l4WKialQfeoO/3O6bgPSokLhKN?=
 =?us-ascii?Q?14DTdhXectIw4bfP8s+PXvP4Wq3jysS56/jGry9W5UC0IY8UlMOlXJ+IFQJq?=
 =?us-ascii?Q?nRP6/wMMnZlFdTQ+12OyqiomhLlUOR2lSSPG+W11DIb9Tb5RA689yorkKFRw?=
 =?us-ascii?Q?fCpqPs/SrFiSQnGRQuo4+ZFjXl3pmvkog5hASNSKkCqWHak5wzS/SWw3fUCM?=
 =?us-ascii?Q?SQzeEM1APg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2d3141-f9de-445b-fc7a-08de62c753ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:37.8811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ullMXEnaFFiWdVr8ARM2smY1IUNwQRB5TKYD0Ub9bJF8GWWZKrJbmTL0MSHS1okSCG5+lr84zdW6WOlRV5ISMuC2avkXAODVRmbX3lI/lMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
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

Recent SDK versions no longer provide a U-Boot FIT image, and U-Boot is=0A=
now built as a single raw binary. Update the documentation to load the=0A=
raw u-boot.bin image directly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 97e14b7d33..d0054a7dbb 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -350,11 +350,9 @@ corresponds to the BL31 image load address.=0A=
 .. code-block:: bash=0A=
 =0A=
   IMGDIR=3Dast2700-default=0A=
-  UBOOT_SIZE=3D$(stat --format=3D%s -L ${IMGDIR}/u-boot-nodtb.bin)=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700-evb \=0A=
-       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot-nodtb.bin \=0A=
-       -device loader,force-raw=3Don,addr=3D$((0x400000000 + ${UBOOT_SIZE}=
)),file=3D${IMGDIR}/u-boot.dtb \=0A=
+       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -409,11 +407,9 @@ Steps to boot the AST2700fc machine:=0A=
 .. code-block:: bash=0A=
 =0A=
   IMGDIR=3Dast2700-default=0A=
-  UBOOT_SIZE=3D$(stat --format=3D%s -L ${IMGDIR}/u-boot-nodtb.bin)=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
-       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot-nodtb.bin \=0A=
-       -device loader,force-raw=3Don,addr=3D$((0x400000000 + ${UBOOT_SIZE}=
)),file=3D${IMGDIR}/u-boot.dtb \=0A=
+       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
-- =0A=
2.43.0=0A=

