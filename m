Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70913E78D73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOM-0004qR-Cb; Mon, 09 Feb 2026 04:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOK-0004oi-Ld; Mon, 09 Feb 2026 04:17:12 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOJ-0007K1-5m; Mon, 09 Feb 2026 04:17:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ0NLL+MdU8THoWMfeSLzOi87d1LvQczouiNNqzxdFlnulm7NqvHI8qjY8Sl6Nnj4CpEoDHUJKKWmbytWw0y3p4Y5FYzEj3IeiTd/ADrrgXa1S021NwlMmftMXPEgk8EOBoO0/qqRBD/uwunUDWyc8IPEhqNCPyQubb1/7QsYrNigJhyvGIZHWeC5qDpbOCOU4QDlSdC/ePPRRn9obHNgMQjuK8+i5DtseUGP5vkx0CLo9Cjh0lUMAujmG6pS8g+1HKROKhW5fbu01RShStdlwCwlQqargmPqsOpE2js3CL4LYlbmy+uomydSMyVLxmanyUl6sXYkNkyh8cK8w9jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=SjIsqEsqrp5SE8Put8KBmXixpCPTXpnxN09nzYzMtT295b1RfNYgOh5inTgv3ewN5uQL7/hBKPFUakgAUL9l4FQg6qrbovUZIUsXvZZIEXjJkgSk13Efg0OckCCbWPTKG1IXYPlb/LAt4AJzwru/H38KJmKVpsw6cXKeECRAIlT+fSJMnABpn1rW1qYXMWljhH9u1D5Ys84u08LVlDAkZ6meGhUouZ8Bo1SzwSkPLvX7quh/7HocjL72W1jLhz66a9MlBkX0gPbedbJBEwQPUSLrzdP9mPDwIApferDTHgSlZg+Ge/t/QHyxtvML7VlBbeY6Mn73SDiUvIUy+zRV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=km1GbBah7KHaezZ9+lV2CNlDZ/btTt9D8R+8eVeHcOG4/RKnGcUVFAgwazXT/b50uToI62uZF83vr8c6RQqII9PemKjdQMVYIxO7gnVp2smwQwiIqGlIQsO1v0EAfxELFf09oWKv3BodiAcgdg7ZMPGm337QFn8CLH8LGcQ1wXxTs80cmonfbRDIuv23DTpzkZJTid3OVylFl+N3dBXo3jf4IrJ2GzXMzts14OnjU+z8LHv2pihF44+iYc2Cq5W+sk5GQwCWSr2Z9Qlz+iNtJUHBO25B9kUl1lOiHKRKBSuxorX+T2vGA7RfWdS/7HS3oOcov0RgHyNdxBAPP6WDww==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:17:00 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:17:00 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v4 20/20] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Thread-Topic: [PATCH v4 20/20] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHcmaTYQ2xB5NEqRkOexMqiTEPXZA==
Date: Mon, 9 Feb 2026 09:16:59 +0000
Message-ID: <20260209091629.823457-21-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: 04ba69bf-b00e-4fa4-2e4e-08de67bbfafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PPTcYLl69HzYzH8GK1aoi2TELMeHSOjwgo06G3ivwD4irRD2p40Civ6lGo?=
 =?iso-8859-1?Q?sh/+j6+NdsoCfClfa6uxkKPWHlxNQoy1I1IFv/SzGgYw30vz/TuANm7i3c?=
 =?iso-8859-1?Q?c9MZ8viuvlwjChy6sXZrYGud0u1jCndR+H/ZC88imWXKRWZ4tOTvAXHENs?=
 =?iso-8859-1?Q?z5wapkNgK4i5ZaLT3mgJiTdzo9nuNX2mfW+G9QWm0doQntlj+ETtPz3msR?=
 =?iso-8859-1?Q?7KdCsPTmVXcRDQBiwLVMxGn61sIkb27ntuEVaOWCi+dfH8PDgV6QPRdIA8?=
 =?iso-8859-1?Q?Alawty1YC/pAYgXRjkVGhQcIl9JLRyslMf4mKVGltyl+Nws4OdtNhROq3e?=
 =?iso-8859-1?Q?SXaq4To6QJko7ZR8gWoEwDBRxOLdQ4eKJjDq9odQfgZAQIFbgMdcXfgI17?=
 =?iso-8859-1?Q?c1Ey0Gq0WkdIQqRwTXCFOZ1Df2hJHpeup6ezDqjvz9Af5vd5eAeka9ftoT?=
 =?iso-8859-1?Q?nBPbc7LxUVUR/zBFFive7fCmFOsqj+XRp8o6M5aY44E/IZnOe6Bs8juCwO?=
 =?iso-8859-1?Q?IDbw/H8IR9VBNU+DcELXukzF4/OVdK1O6sDIlheNDLeQlfA02b/bzTS/b/?=
 =?iso-8859-1?Q?3yJ6yMU6I6Yb2u9ytQcwqahj7mWo8m0V0hGlFbJ4iej0hgDOeufVXVH5aw?=
 =?iso-8859-1?Q?p75WWBS2ACOCqlah6WXPGVXFro2jM22BugCCwyumfl880vYKZ6+RIbcbaY?=
 =?iso-8859-1?Q?d1bX4LVyvyw0lTd6y/RUWSJbWJ1S92edmoguRnHwNT+Foq+TqN+sK0VZsF?=
 =?iso-8859-1?Q?iFpVId5fx7dkSGOFIcq9xwnT+Sm4lRWH2Lu0Zilfrn5tbYWqqbzDY5oyKP?=
 =?iso-8859-1?Q?lWb6tRBqef8VpW7ckQGx0X0QklRSJM01Sm4BQsUiijHb5UsbVQBQqWxx9Q?=
 =?iso-8859-1?Q?qmp5Mh3g4hyHhvwRfvuxOnTNZKqM1hKnzer8Kfuys6bo2GtS5ddr/OUgxW?=
 =?iso-8859-1?Q?eIl6ZcFfI1UfhELwog/KXLPzvrEupMhV3o9z3hiJpquZmTLt4793vsfWz4?=
 =?iso-8859-1?Q?S1sVy7Q1jUAgVjyT8j4IBnGmXhx7gCdKAxSQ1ZPliEZqklro8eR5cB9Pj+?=
 =?iso-8859-1?Q?Y0brl/qBVq5KZFcOjhgVYxLPNjMdUlGWEvC7rPH0tRxnah4ZrIwVud5iSE?=
 =?iso-8859-1?Q?xhL+elZgTqW4o4Z/LmqiZIz4dVpHWDjW/2mDADj2J//bGJHtKWDGB3pyyc?=
 =?iso-8859-1?Q?jaf2WaW2mTkHBuzH4oGP5wvf6ztW+h1hNCv96ziUPfEhzTs7pVkCnwPY1F?=
 =?iso-8859-1?Q?HvzvgiVAR5i/HlOFxPXmmtwSFRI9YzKHmkZhfZVbptP5BnsnctyQlGwkHF?=
 =?iso-8859-1?Q?CHXttr/u/LFF8mlbD5UJbuguIQgXAoU8N6jailG7fyO2R2p7IxI4wyKYu/?=
 =?iso-8859-1?Q?5HoIf2Gj5FBnQmPs4Nrr60tF3cCjCjiKeMukNX6JE2Bp5thkO6/RVgEXzc?=
 =?iso-8859-1?Q?2TMrHvhBZxX6hmxF8OfHD8ACkfkYLf1+3PXheDQUa3pbj6GsMDpdR2g1Bt?=
 =?iso-8859-1?Q?dUX2cKKb+Akf7PLlv78oFZq+4qy25M3j7o1e1kJBx22mMXfs+/L/VUmP4R?=
 =?iso-8859-1?Q?4xNgoCo1sCtixB/0OrcsaJ5363LTf+OgdizyGeWuePX4IJbif5t2ewAmQ6?=
 =?iso-8859-1?Q?dtxFmmp5daVr/3zmZ9pwfiMKA22E7cresWXzUGid3Siu7YQbHDquK4uQnU?=
 =?iso-8859-1?Q?q9Ta/a9974HAc8tRVWiRcNz1pGCT+iIpZfsaN3Np?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EzHixRJJEMTeh18ZIEFPRPfQ9ersJe52bhUQ3r7YHequgpCz3JLTETK0Vf?=
 =?iso-8859-1?Q?6LTlKgQeI3mPGZ6kH5r1ts6sc3CXn5dkTmyAE7S62qCpRWz0OXwVgn3D4S?=
 =?iso-8859-1?Q?Uq6DyW3Vr9wCfEwJCzDYStC4TWUAGUUoR3zx3PV5tyXHk4F1nu7zSKqcdu?=
 =?iso-8859-1?Q?SYtw99RawCxXZDocsugSmKL8sl2G3BaUfj+hTZ5HmFFae8BEfMTxOgybT+?=
 =?iso-8859-1?Q?0XMn15tp4DuSl+9pIchvUA7//MThB3ma0a3wI2LEkB57akT+CGaaqfns+D?=
 =?iso-8859-1?Q?oleEgPX6dOvPcVhrUcK+AixJLPr4AgSSALlRnNcqoB3q+tsA7oCPH/1c/K?=
 =?iso-8859-1?Q?Eu4pawFnQTIPbqqNglHl90KWQpmAnXq3E0YZk1TupJOFTyKBocnW9dQcue?=
 =?iso-8859-1?Q?aBp/RsAA8RusGplSak6CYk2l4N2Z2iwEEzWsiempRgg5Q8kQ1rKHKPZnT4?=
 =?iso-8859-1?Q?XIPEvYGlas26TVoCWfFltRJ4nM2hHpKh8z529seaYC8Vl8Urx5lC3jVG/8?=
 =?iso-8859-1?Q?aeQ2qea767jftreBxyYhAsJ6dusjOphLPyV6FiOOZzqhu1H/xK4utvKMHC?=
 =?iso-8859-1?Q?i+drm13Gz6UsnsqZc9uPQML7VSn4+CDgURrJjfsPDuBJSZCdvK8+A7oyZG?=
 =?iso-8859-1?Q?pIywsnXZBm92yN2HnodElyJM06GYUB4bVTsZDmgInr6QsIbvq/et3VASyW?=
 =?iso-8859-1?Q?jKQjW2CDGPH/aGoUV4rTzgKnnLHe+ok1xB9A8PKV3x8Y12BmnMizFZUMEd?=
 =?iso-8859-1?Q?SZzWx7SXilSPX+Q003lQ8FljK3HVWj8NRR2MRQFdZ/WD+0GVa/UUwWnFtZ?=
 =?iso-8859-1?Q?dALCKxKjCxgkeloqVEHzVcKjiddiPh64b3FKNnDvckFWqICQp8QEa1lnD4?=
 =?iso-8859-1?Q?FBKIBnWFjDgOV6RurjqAjVFC6DSb2f1TyBP3GwCHfUR4PDP3OYIiuuikwc?=
 =?iso-8859-1?Q?HeDUcRu5+sqjJ1EWHM94pJDVexEFXJ7mDaj34AASwVZ997tp0jrme1N3bx?=
 =?iso-8859-1?Q?D0syFaJ6vHZA8j+lLkxj5+7TNgpBMHF1re4t1SNGaogkJjybJcZN3pJI2v?=
 =?iso-8859-1?Q?GKMVh/xIpJcC/zveQjlabZUBdCI5n45r9EW5I32ZXetOekutJGn4OJE5uz?=
 =?iso-8859-1?Q?NOoKLYCgoXK2WiaIqqBG7H+lMNzA4gSqas0bCUdWTkXTE06hQh95b98lpM?=
 =?iso-8859-1?Q?dqVBBS8MoFiQY2PGmHGyeI21em0T9EwWTC2ecjhZUQiTwFneLSV18zVSy5?=
 =?iso-8859-1?Q?3mkeYMw8/oGX+hNBExqxVzhY9SWJGxksRFI0Nw9zjaIj2iPO4RXznA2GFz?=
 =?iso-8859-1?Q?QrcO5Q0SkEBmd9pM4yDRxDcQv4a3+FnWeMGE/DEd4cSgVJ70NOl/0aYhal?=
 =?iso-8859-1?Q?xxk4A//I4txEls77NKrha6uTxtHWrcoUrSPaYzVXpHJ3j3VmYg1RwAqbjM?=
 =?iso-8859-1?Q?TKTm9tgA+qkNR2VZu5e2V9iAILJSj0zqaI4sLGoLoY36eG8S6F3blCjXog?=
 =?iso-8859-1?Q?ZdmA5IbRsKsr9WtdfQDnkfcQbSgdsIKZ40BPIL01cfd9rZIKEdOsukfewR?=
 =?iso-8859-1?Q?zbOJ3ejAMJ8EuasktIxr8gme6zv5+IqrLAbjrne3JnzL6JqfMjVbZVl0FI?=
 =?iso-8859-1?Q?FsXQAvbqWyWqLm8vBMFy6hw4xZSAZkwo0dpDVPG4j5rm3+4+HqorkqzIiK?=
 =?iso-8859-1?Q?lSHdBho9w7+kQxVHkecf8fAyHgPVG5fiZjfH0glgGwf5+BoktJWlnT8fFW?=
 =?iso-8859-1?Q?5cgJa7CCszKpwiiOLWVZYvoDLUFM2T5fUDBQvL2iVoAEsdRyJyvYEKbZZC?=
 =?iso-8859-1?Q?/GTeWt+C6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba69bf-b00e-4fa4-2e4e-08de67bbfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:59.9803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjQ9/I6PujBJ2543ATzdW1cpV+H09LP8qaQQm02E+/V7DUSVd2W4Q02moYf97BD2L7hc6YIsTs3Q0tB53HRoi0r83dhYmVU3rxr3k9GJsfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 6236aeb11c..3485feaf2c 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):=0A=
             'ip addr show dev eth4',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2600_i3c_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'=0A=
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',=0A=
+            'Success on message 0')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):=0A=
             'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.0')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device',=0A=
+            'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default", "image-bmc"))=0A=
 =0A=
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
+        self.do_ast2600_i3c_test()=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
-- =0A=
2.43.0=0A=

