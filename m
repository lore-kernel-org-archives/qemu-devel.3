Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDB3CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mh-0001rD-Fi; Mon, 12 Oct 2026 02:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9md-0001pn-1P; Mon, 12 Oct 2026 02:45:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mb-0006Ms-Gc; Mon, 12 Oct 2026 02:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EI0dI2na2avLHBTlOuvpTjRgypdtNf7KO9IznjUGJAwYQQZh1agqNmaq0op4YH5VUulTgV5DUQCHBQIP5ojdV/oRsCVHAuhi9+r4iXU6DfynG4RYwg48PKSpQCSfZOcNQf1YfAvRsImUPyFPLJ0yqppYOCNW/l9HjkuXJKWCui/1hcWaImuGJUH5P4jySeZrvRoC4LjTYENbYMuahODzAF9z4iU5+wB1cOruFaieOBV8/dJO62JvMYUE7yqzCl7cKhJEGwezjq2gCggy7r149znam+kASc70nkq+N6LJjLv2W5Cwuz0JbP025z3Wr10lYbA+/Z/VwWUnafljEJn66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smeNMQ3+Or9a+GPIwQu7lRYbrnPnzjwRKoH0n2KDERw=;
 b=C/cnwV4/QCPERPNyXcuBK7hvaoYBhEuNQ15613ZxVRfdWQhnS96KnxSoUYziWdZPBkSiRAjbHN1gwafnMWIIpipL76JQrFO9FW/UULQnsgU1hQ7x9fERSnsJJWMyW7GrtKMA6yWTAi+qlop8eLIEyrw0AAXfYxpJQesj1cCkpzMD+2cX0HLnbOyAFhFCXxosXHwBXqZ9Sm4+v7+yTpGvVuBac5097jehUKyFf3HpchVks7De87R9Cfdz6AQ/Inw+V2u+ixZT6IxIrBgj+lf/nuyKfEO5C6NZlTlRCr/gSfe/6S+v5Jzb9CWZ7kIxY4gvO9v5XmSCMdyzGSOLfrIwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smeNMQ3+Or9a+GPIwQu7lRYbrnPnzjwRKoH0n2KDERw=;
 b=QUCVxfnFh1hEjskL8RUn4f6MMQm//yjv+yirfS5hNHSX3MSsfvnddGB21jPpjeN5+Xzv6rutcx34bdmyk6V9mW0hm3Tx1lzDo/DiI0ZYG8OuGDjmMIj65p3ITddQiZklK1YiVSnbgEmb+NiGC5kfHChGoDNlRIhdlYMCaoe+hyzXu6N4OuWEVwGwbR3jQFjH32C19IWA1Q5ex+aFwO2ExtdD1C3NdHezWiK/BdEtDUdWWgs90NSbxbpq7TkcARxYHtQEOTRghUS0FMfwelnJMCOaBM8krcW1PY5n2bDbBEzEshW8xQ7vXd/a5xGvVSLV6PuY96XTVhUjlOGqssH0Kg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 11/12] hw/arm/aspeed_ast1700: Remove unused unimplemented
 device field
Thread-Topic: [PATCH v2 11/12] hw/arm/aspeed_ast1700: Remove unused
 unimplemented device field
Thread-Index: AQHdWhUyH7u+tI9C602apCCBPvLLaQ==
Date: Mon, 12 Oct 2026 06:44:58 +0000
Message-ID: <20261012064445.2571633-12-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: f8a642a8-5f10-4b60-102a-08df282c5560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: xNf0YZIq7jz6rQ8sghD9q4K4OyukjLrxUhoCrkgclKtiJk1XNBrGyf8Ntlxac1TloRep5TPsNRZJUXjgvSREbA2o0jMPlVpLFFBCYYLt0j3grZ1ZRp2+AI2Vhw7eP58hd1obyNU9zfLD/hXo8SqY7VsYi/o8Tje/hH1jUqFxDXxmGEwXbZkTbHHsrkAZ+R6Rc2h82qzpnXD3sOGdCt2DuKIGPJUcvvEk3QlMIN3RpTi+Rjq1P1pgUdxXTkrOqJ+hLdT4Xsz9pMsv0bACCsQHQxERBUqzLoyatCKf5fkIp1RBhFqDkbc5F5jkyKEbbH4wJOivSNH1EVY9HSdj/Cdrl4JzXcVtGiB0dhFYFOiFhmXByKZmnKow8ssjxqx4wC9Q1kTirVKDSFh7nXEqvShnwUuZ26srE0/48gOT0qqzhTiqOzU6nd1tvZPDMvoYQXmj01ZrIyHDz1l/Uml2h+KJljl9ZHwc8gfl6zhakoEmDfIskWivd8bH7YRSuhFeZl/oTaDS/0IVgQBW9DVPqPoETstvpKHtrNfFp9uT2OrC1onn3wQdK4VTgrXogzpre2BgClIdqcoH7S/WlWZKWVG2ZDwqbgYcz3GUF7EmNC1nh+7VpaTDsnkSxXGTTMnHjhoJgT+WJaXJxN6kP9abMi3HNq+G50X6hwjDXp2hU+DoBTt92Iyn3UsT4TT09wquVTLEuUN7XHAa/t5mUfRS684UsC6iyLrKq0a8dEdSF9rlAQ4IueUEVv1AF91abKwHPJUY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TMGrBNxzgO1cdjsyyvk88NEsVTp44YjqYHVjb73vDfzxcnsdfuON3qWtqR?=
 =?iso-8859-1?Q?lv0YngXIVKkaBIXRFSdB58rmRDPfDJ44DzS3RfWb8KdXrJJrBKtmzdtC49?=
 =?iso-8859-1?Q?kiX+0WfuHiRWm3hVxxXYhf7JM8k5p+VWoJKMmUck6ckldwu25awTLz50IU?=
 =?iso-8859-1?Q?fRIbIunJuBa8ryrgXhWqL25Kfjn2s2Dm38csTaU9vxgrqvxgCf/8uEuM7P?=
 =?iso-8859-1?Q?eFvatMihDP2uQlJVTqLtJk3JivvUXY6nIkOYGGNmQvpYpaw2q5ricXlw6F?=
 =?iso-8859-1?Q?MuZE5n3zS3JzDmrEzQV0Y1kVJ0STizlySBYMaAUgUqVdnYU5/VQe/1Q6V3?=
 =?iso-8859-1?Q?HDZO8Pg/f6n5HdiIzHW9E2Q8FQ/8DRzHr16UPgEap4gxshl41YQUqYPxKn?=
 =?iso-8859-1?Q?pkFxbDID0Pi3sp6jvrm8ez4F9GvJS2eJt1V9SOnKlrCKiGSnXYtcqdvrOE?=
 =?iso-8859-1?Q?MhUTx/ajzMdK2LPYosbUxKsM+t1ujHCW8Id+vtuuob4/CXUy7Hz6fXNsVP?=
 =?iso-8859-1?Q?1i5U2CDBp33Hnj+hKprNYnzXIwS2WxfRd2xjYoN1ayxfOsNYTXXpBnol8z?=
 =?iso-8859-1?Q?Tt/TH5b9ib7S4mWowSwil97pZagSSHdQnOwqY+LeYkvWuknSvc1BXqkwQr?=
 =?iso-8859-1?Q?Wyq7NeYMWNzJZh4kC3lUF/2aurSHmYAtp1C4i0yf7yr4OgqyY9RKFZT2Mv?=
 =?iso-8859-1?Q?whMVUZCzhlf5OShk3RvbwOvfrYdCUIYItnJymy/O2d8ZxSSFgb0eIyZYTM?=
 =?iso-8859-1?Q?gwqdC6cw7EnC1fOW7H8ITJjmxGQDYHn5MEhRr+1yt39BwavRS9kkS1kIzn?=
 =?iso-8859-1?Q?CnIV76OMA+KAyHcOrfUzfcnaTy12QiDeMzECF2rnexdTSAZzV85EBtLDB8?=
 =?iso-8859-1?Q?8ONDW4fCTvE6Tl8hC30T3VE0bI7+nYX9+4chedCyW+fdgSmhC0rTpwLg5K?=
 =?iso-8859-1?Q?DLMK7CsJwO8GWWeDbWKhiy/edXFdnxfeJEyA7HLqUQnxnKWR0s6zeIeo7K?=
 =?iso-8859-1?Q?sUc93B0F4/eAeXqJ47V4Bl3n6un8av3bwbmq0uXHlV2I8fLwQs/hqDdvjK?=
 =?iso-8859-1?Q?5nhZ6ZU7Sr1qff+st8zv/VMnTm4euiNXo9VSa1ns9ecASFPeoqKOCUSExa?=
 =?iso-8859-1?Q?cD8R3nUSlrpCr4xkzwWviAPKD9wtHnMl/0DYiC64hfEEErViz3TH9+B2r1?=
 =?iso-8859-1?Q?0XQP7hELcn1mUA4Qw7mjvqw1CrMSkMh9vKxQzmUnDFynRvkuVRTjBaiYrs?=
 =?iso-8859-1?Q?CKfcaOKHPKednUNXPU21Lcle0FR+jCqhLGGjr2HeLFIAjPCAafIY82YKhB?=
 =?iso-8859-1?Q?HIJfjajSiWFDixsKwXVXu53L1/3cwlHaXf5eI45pVB/N4q3syhbnl2mnCU?=
 =?iso-8859-1?Q?sLdbw9EcSnkVeAftcocjTNfaOq19upzshUPArTSlL8Ft/pPjwZGIJXr+O/?=
 =?iso-8859-1?Q?eGMqIQp5KvisSMg/r9R+efeUKQvoQ/TXlhQKSlzdf2G4/Csl1OP/DxzACs?=
 =?iso-8859-1?Q?Q+vkYShTqcfogJg9VSa7uTV7cBY081WqPa2wkiWxQHlpzvzGxo48sSwU1+?=
 =?iso-8859-1?Q?rkTqcDX+UGh95OiouPDGbilz+W2NK/Ih3UvlqI29JSd07RzAvHG0z4XOKK?=
 =?iso-8859-1?Q?uHOfqShfXXhvVoMgvibpvJDteDSGFgoczSk4doqE9VOKaYXmGYYf2/gNLR?=
 =?iso-8859-1?Q?sfypCen++k7qenix1XaMzhdP/ckgjQ/8Fh684Xy0Yy3Qfh42WKJRA5ZQ4I?=
 =?iso-8859-1?Q?aEnvXpeDJ78vlNrEsHkrhlyfX+nQpUnKUQPCjQsfZyuasX711Cv04aPhsb?=
 =?iso-8859-1?Q?ty5gHzetKA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: blMuz229iy3ySJz1RWDCQz+n6zvmeuurMgqXen/Yuwvl9B8WWM5quYIMWtmL3twOZSJCfZfBFmLFx2d0D0xYyuVYE0U3kDSOkbv6168i2O1FzGC9p7b2cEKq4SDFmTpKjde/m+R0cugzisocm577C+WWcH3GFFMDtI55dz4a7Q41b1lNZjOWB8kDQM+iEJAC8o/KcYYmeRsMSaWlEfrzmZdKZDwbF4/FMI//Qls2ZFOYFIfcu3agYFc+y7IJkjh9YGYHmcInzEXT/PKQ/+7NvQI+iwGWKzwZk7qwCVzRu6PluRISrbfN7gwvy43cP7PyIZcW4ZhXV2dZRyCJNTK8+g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a642a8-5f10-4b60-102a-08df282c5560
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:58.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvrV+7VbDZREzehjUh8QPxD5Z8rOFupJXriBPaAiYgTqZflYvfbot4z5/o9fVQBVyrQCFuposqXz5PZMWgaQBnH6NCpMzTanOqa8vPeA8Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

AST1700 now uses create_unimplemented_devices() for its unimplemented=0A=
devices. Remove the old "i3c" field in AspeedAST1700SoCState, which is=0A=
not used anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h | 2 --=0A=
 1 file changed, 2 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 39c5977cf1..d30483c88a 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -47,8 +47,6 @@ struct AspeedAST1700SoCState {=0A=
     AspeedI2CState i2c;=0A=
     AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
-=0A=
-    UnimplementedDeviceState i3c;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
-- =0A=
2.53.0=0A=

