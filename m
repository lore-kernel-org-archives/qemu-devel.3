Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF3CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5J-0004fR-Ky; Thu, 15 Oct 2026 02:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0004cq-E4; Thu, 15 Oct 2026 02:36:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF4x-0006Xz-UK; Thu, 15 Oct 2026 02:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTUyGMx4dcl4F/QfSgz7PrqECR5wa7/T8yc2kkO6xa6d/Bbkc4Au1FDCRxEE1kB52PpH6WWTSdjcnAa3fII3TLGsBGUzNq+2QVzs4LsoB6r/nu+GMzaI+Ttj/wXkE/0IX9wgpmJMhcnMsziE5QWi8UMbepv5X5DTE9A/kUjInGqqqH1rlfM8dWYqj6THJc7IagRBq/HoXLj63wNW+i0plXNYP8cqxBAG1SBT9PkTH7FisIjNLdQwe5gleQwSiTNNNv8EYEcWIFT1Jg26tSK8Qcu8riYrHf0/GfJAcb86dt5/CiguspfmoM3095haivqsIz/xNvEtOOxzuDfYa3A8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtvAcnJLdth1XtKe7Kv/0zrEjJHUJia2YrLKACPVntI=;
 b=oRyUcL2UukAJW3Un59i0IqzXG4fogUWIFyTyVHWEF3Zlgx2Z5CiL9Xye5iClK0QueaBNs0bWX+O4kJyxSUStC+EBtWcszU20+bcSHp1M/7Lu0v0oo4DlJGYyBciCMUvFkPaiivFihro2mlx7T9lVnivW49lKcSKMYue7D31e8Br0YQIvgckxmZYHx1Eu+VIYSTMUEoxsrz1h63dg2BVrxlnbCzlirX0HsQNStjrAclfe7D4HUhV5ql+tzTbWdi1XrA0USBMGv882w0qiuIKgxXjkgRncwBH52HbYFX73qlJCtNQEKEbaLtkoq8dDnhH+iYycCTFDqKNqEYxFAYxHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtvAcnJLdth1XtKe7Kv/0zrEjJHUJia2YrLKACPVntI=;
 b=f14zH4SHSsU0+lOe69NkwJA1rAuctckHsiCFdxamYbPEgGNzgDmzy6Iine6CnVZRfbLffK4Bm/w8II4LUVMj+sAEmKBXYLKq01ny6ICcgA0JJUrvPSYq/UKbiZ/+V6dNcFED0YlRzHfpEu8dfkhbnESSe3KPC8c55OFt0J29obxsnIWxcmO7TMuuF55BvsA9POWrfpJY2u6pqwPWfxMyQqt+5POBUrSLSaWpY68tr/gb0oY6nDpjrI0VUVY3aflxS6A8TGFDMg2J9X+hjnBRy5pvLolKi9KVod7PKhBS7TnpXC846SDI9LQ0L3cfNHXxiClStkfgAd+Z6qOroWyZ+Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB5902.apcprd06.prod.outlook.com (2603:1096:301:119::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 06:36:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/9] hw/misc/aspeed_scu: Add AST1080 A0 silicon revision
 definition
Thread-Topic: [PATCH v1 3/9] hw/misc/aspeed_scu: Add AST1080 A0 silicon
 revision definition
Thread-Index: AQHdXG+Cp+8+4plab0624wFiN0jp8Q==
Date: Thu, 15 Oct 2026 06:36:29 +0000
Message-ID: <20261015063625.186708-4-jamin_lin@aspeedtech.com>
References: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB5902:EE_
x-ms-office365-filtering-correlation-id: 894d822f-e8b3-49e8-63b4-08df2a86a5e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|10067099003|18002099003|38070700021|261009223027099003|921020|56012099006;
x-microsoft-antispam-message-info: 0vScZp1xmVPLKR6m5PkpUymzqyBbFoAT3mAIYpn/Fwhyc7wU46FeBWK/e/kNOYWoXvdKWvz5PLvbqi9/NJmhCPFQmmlLhTcSsqrLkdHIeTroDQLOU/6Wd9EWmzflKHGC/SAkmUd8KiqsxRn08Mn1/BhjR1As5FEG9puxO8PmxB/jmDblcG78oU4TkWA7OV1gEAUqOoIsFCMAIuTV+DYiBkUxraD3qO8GIQ3rGwABuFhZ1w0dEmOwoe/65sg9+JLBNKbCYYxwlc2DSZ19B4mXNZ1d1XIWgNLgsWRiSi/gJS6dCx87c3vPE2MTcDTtk3pZ5tAB71aur63QkQ3GGZcR9NGZqKwqTOmK3QPe7KvnqOSSLlU0a7p6mwG6N0zT5+OswxBVFbrPv7Ry0MYqn3NTGRLDfAT9T/ooW0n3tQH0k/NtT37IU4tHSoydgTwE4V1LGbkPHNw39ONZtQFvDQaOZzZV5yx5A5mGWYdEDS5Mpx8P5jlXHuj2j6c6/Jd0GtCru1afI/MGi4Jrc+wR3wcKVSl9kFv2pUD/EK+747+uQtDCXxYXU77rUomKOMGgPBvd4KG87PFqEQUVajGGpEJCHOooThqHdfXgbKHxJkY7TjRy+Vfg0xc8ewyT+fnSmcwfU5WQKdCSDxH4T3ph1xSSoEcyHeHO85bqYXkCJBFW2SOCkZys5OJEZfbhODi7IgEEbU4V1HXv5eqmlpIkmELIRnFyTFUftXimo9J9fRYyQ0+gRdQEaJwREVWPyDGXh+gi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(38070700021)(261009223027099003)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l8oAZpnB1bB2aoXjAboGg2lsxjJUv36o0xdbEZznxRr7WmzGdYCm7g2sZf?=
 =?iso-8859-1?Q?9gDFdoYnmOMYpnA43HFbIOvBEnK7zrkolMryBAI+L/U14ZHxRuejW3MEq8?=
 =?iso-8859-1?Q?8VP8cDlaPLLGAjPwlTMYBeUNDhqonvY11yBTdoNHy0kLe2/nR60GpQJgoB?=
 =?iso-8859-1?Q?8j41I3suTinzNgfbizET5ieREVpApvJPsVcAQ8trrA8NLdMD5oc+w4A6/B?=
 =?iso-8859-1?Q?IDPoM0DphYjkPxf1QihZHQ59Q7JlgbCaihblidteMMYd9Lgsamx2Le+Yfj?=
 =?iso-8859-1?Q?PgSGTpluVKo0saxvUHGrKSrxzrCb0iYK4bE4q5LUGZl9lfKMTB+gDetW0M?=
 =?iso-8859-1?Q?UVRq5GM63/I5GNKwjv6t56rMvkQyUdmgt+CErADXBWpK4UMKqQ9a/vay5P?=
 =?iso-8859-1?Q?YFxxPmoR1ybzucAOfu28KVsgfSGaNQMOFOPztqMxOxHk/oo0Zw1k6YJpf3?=
 =?iso-8859-1?Q?s8/WkgbKqi7fnc0AW6yRBwS9o8TEIYkaQxCkynPoYK/dCC+AOu0Br182Wt?=
 =?iso-8859-1?Q?a5epK2cv1GlgCG2XwHxcRg3OcIMLQOJ+9OqI88MdvtPMLV0kHEEuLdPcMs?=
 =?iso-8859-1?Q?AHvQi2sfqMdCxQEJHS8x/2ub+pObon+uFS/AjpjalrvCRlESrs6kRjx4RM?=
 =?iso-8859-1?Q?cdUGbcOdb44t+ugonOpx+XL67sLX669/jUVlRZtuYHkTeT+ed2FFaC0vwl?=
 =?iso-8859-1?Q?ENOFBFxnWLr1UjMpmyEv5cU/N9+o+nfgkBwyxDgBpoCTdrDI0PqVYPPdpi?=
 =?iso-8859-1?Q?c/6s9kgV58bFY6legx1QZwZm0LzEa4q7MYOVEw6O4ICWqvmxuccxicTked?=
 =?iso-8859-1?Q?8rHUt1RXTUQxwxXPoKjpqSQXnLcRXbUgWgPrSr/CHhg+hND5LLbfaPWqK+?=
 =?iso-8859-1?Q?zg+wgOC5Zm5gS6MQ1l3c+FiNAB++ZK5DKPWBAsMTLq16NKHz5mTEOLX2dh?=
 =?iso-8859-1?Q?VeQnDxrYj4C+AhM1QwLGXrLPsLMALdwPJVfZNMpNGZsg3evqhC78ubFyUY?=
 =?iso-8859-1?Q?SnymbAw7tpkNcFM7UsH9EAp2YGYseYFLMCXTbr53K6F0z8n+m99IWicEkc?=
 =?iso-8859-1?Q?aB3r7Rz3WhoHe52k8MSeW2eVReXuirdEMOMfj81xFlh0zd6CiVpZHvUwr0?=
 =?iso-8859-1?Q?Zzk47wOM84mRLFcg9iztGrHopN55Ukg6CYJzyP/VAg7Iu4nmz0e4Ss45aZ?=
 =?iso-8859-1?Q?j7VJAiIEjAQL47wUr6FupdIVX3aSPVRnwKTUrXDEdLobZ1CNrTrNFHDmEB?=
 =?iso-8859-1?Q?O4W+00D9I987c5MuysXsBvl5A5B6HH1pFQmd5tkb0dkjjkUK7xvheTSeBY?=
 =?iso-8859-1?Q?KtVrXj2ApGznLsWnL1c2/uiEyN7p0JkdECE9BZz0nuz6WfXzLikEoptaWz?=
 =?iso-8859-1?Q?nJCBZRlfifKmMO+qExzxpkqEySR4NdoXZ0tT/Mf2M3HcX7AFNM5S0NFJyP?=
 =?iso-8859-1?Q?BbwR6bgnhYo0olTdNkvmt/6eTMTgspvFcqg1mkXV+HIf/Qj5NzFOlzRY0x?=
 =?iso-8859-1?Q?o071Ih/G1rCz//OVqw35Eb0U+3LcFos/JbUW2+v0QEyPB6dWqLRoe7k19s?=
 =?iso-8859-1?Q?Op8lt5OujMlKfR+TgQQylXAJdzPPCZUGXYizCncXWC/71KAplPM7q+Wu+J?=
 =?iso-8859-1?Q?9kwUhjOmTpRS2SAd8bq3yU0QJPw3PrzH0tHk4sLtifbew5SrhjQ+wgsc5u?=
 =?iso-8859-1?Q?Z+N5LbbvcBi6AFVhAyNP5MCHbL7OFtN4XI6XaVrGwjbA7u8bgpEPbp35K0?=
 =?iso-8859-1?Q?MKPuxWQHWkrpa5LA1y/LYv5GXtGnjkFed5fHvjHLicFBFJwW9buT7WnObY?=
 =?iso-8859-1?Q?LKKMiwjtyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dHrex68/uONAg7m7SDJ/feuZjL49G87H8VD+QU9jqra6e1tRaWiSyt7ZGXKhgGbC2MkVB5oom5QSWJrKmvU249+Sdq4gAksFtShdvndGVWp27+c0MPz0Naq9On3O6N3DYlWANNtwA/d3KPxtxDES8qmYqOvpQo1XPOO15P/ptPf24CuqnNHHzTGR1IySgWpGXITAm54iE/Cw5u4AHTm+RSPqJTTWLhN3m1JZ4KBnuyNRn/6P+ePAbs6ED5cYXZYP5Of5Pb9tpFng/3n3wGyQzq1tXp6BpBVpJ8VKcr2Teq1RZptMmk/mTUWXFav/JQABtOQW9P+NbUWXkKYZqW11vw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894d822f-e8b3-49e8-63b4-08df2a86a5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:29.5490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpg7cxSha+AhbN7SZ6HFa8+VFczt2j6/zrzoaD+uWhVhstIsCTdRWOqJ+9f2kqunN1ffH1ZhUVcqbwMl9l9WsQxpr+ii3sqR4WFyTL7U3pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5902
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

Add a new silicon revision constant AST1080_A0_SILICON_REV for the=0A=
AST1080 SoC. This allows the SCU model and related SoC layers to=0A=
identify and handle AST1080 A0 revision properly in the same way as=0A=
other Aspeed SoC families.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 6482038f12..a7014e43f2 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -52,6 +52,7 @@ struct Aspeed2700SCUState {=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
 #define AST1040_A0_SILICON_REV   0x80000000U=0A=
+#define AST1080_A0_SILICON_REV   0xA0000100U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
 #define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 77f9af2ae5..df26dd0ef4 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -572,6 +572,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST2700_A1_SILICON_REV,=0A=
     AST2700_A2_SILICON_REV,=0A=
     AST1040_A0_SILICON_REV,=0A=
+    AST1080_A0_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.53.0=0A=

