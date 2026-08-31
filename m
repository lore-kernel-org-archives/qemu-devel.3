Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F54C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suS-000658-JK; Sun, 30 Aug 2026 23:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suR-00063z-3M; Sun, 30 Aug 2026 23:42:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suP-0006yv-Ec; Sun, 30 Aug 2026 23:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIbj8DygMTowepz9Ie+TRygdKtyty91CLTrwhbNjYoD0FJrzioe/jQicl9chxrfFdAKcTGUm1lFoG/X6JJ2urXjVQ7kluX8o+NLyHzEXvY/zMbOL3DbVboIE78HcZo6jrVjxZatFKjNgqre74vJKcGSOY9s148Nhgn/tCCy2wZfmhbwxb5lxMyHQUbQcYQBHrbDL+ZlQaZjv1cQcDkccqBnu0EaVAXk3Vsib1A4LOV53DoBh9sX+C1jkR/ezeXXGtp8A3hO7F1zoh5OXZ/j8rHiw9KCqNMU8M6syXkYxqeOaoyJtY+siRY1bYL/FWV++AGjeUkr7P7TwUKqnCuKn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjUUOMCdxGcTuWVXZRhnlb/uFNe3929r2V2k+mSHhcY=;
 b=jCTEeWXOE1WJP7/RpUUnGWXhyynJXWeq4Qm7c3URBzLZBq+Pjb9jHlc1T0MIWlHAMW+bkddwg1Wqyu997JWH0T8bil4PPANhvu+UsMAK1teM3TRlRJSa8kew6HcQJ7qM2tfrnAmbg//P2V9r2H6TyCmwzUol+4ipnFdksf4noIIoATqj+4hmU/YgRE2MdEJVCIgO6tFUTH45AMDH6tofs5RtpEMTqOuVC98RqvkJC69BCsmJ0HVo92mNn7izRCfqrshwkT0AjgqZllSsmGe14iI3E7rHLOaRoqCiB7i08chTcgGfGUseASPJeSbCONbDOsO45qcdvmOgL9Eahe+Wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjUUOMCdxGcTuWVXZRhnlb/uFNe3929r2V2k+mSHhcY=;
 b=NTOGMNtVN6exctgiOpFTMFwQbVsRUUdnMlxYtmCDLJhDD8mjv0IOjc3gVMY/Ws2Fn9xTLll8Igio5000SKzNaP92RKi0Aj9RPNM3lTChaSfV9iDFYIEreeU5OPgX9LBmtXS9fYSCz1hQpWr3UkvstK4fsWsZu4K93GzXrh+I2/M8sxFeIExHbAKPUF3bNz83UkvYwtTWNkStY3WPbzPQyHovsTeYaP3AupkSCCQkRGA/eAqO/WBKOvscgmDB6+S27aOQRLVi2RjdFTUP4vx5rYmqbbiULiqVk/KN6brCDASB/GU38e0+63ai2gfZ3DMv+QCvRFI29WJXQOEWvUd+GQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:42:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:42:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 7/9] hw/misc/aspeed_sbc: Increase register space to 0x1000
Thread-Topic: [PATCH v3 7/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Index: AQHdOPqvyqrPi6wUq0Stxgg+Cfv1ag==
Date: Mon, 31 Aug 2026 03:42:03 +0000
Message-ID: <20260831034153.192916-8-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8096:EE_
x-ms-office365-filtering-correlation-id: e0ed58b5-e71f-4f84-3082-08df0711d22f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: CAInOAO0Pr/DOAvEx0GwawJOUPnzX27dXFm1fgSxElnpGg9AeyxRd4FPZcTKAYvBByVYg4rprX/Gt9XXrdS2pjR5Mba4WgsVdn2mYjcQ3XxhpzFJcUmrDk9Mw+LncmmjZeVEqh3rVE3v9aBmHBXbj8Fm0j1thvvP5jaRk8gfAFfB/NhEQQBODQ+TM2NbSDHqX7KKpbGrQ7L92lf+CcARdoBMB1dVKxLyj1BsqdXbdAcqqqb4xya+eiVk4nna2C6RJRYL8jvj4l30acEBsp/FxBzBAe76skBPktP0lfiVkwr7uI6f/rof35E34fkzcpX7rLXuL8Z9Lkcvu7S5BxXNXHujgTixCpQIR8o2LhH7QqZrH8FoWW7ae95Ur2oujawhrcB9xLCVtBPJmBgqtGD5Mcd/k89Q6f8J450xj3pAHQF8xOu6oZ9LcXeqM9xIuutPEqUfN3AEyhdx8Fb1jxeqpXbeUXTeiM66+gWz4k5vHBu9+breqHvC+Eg9G0yM/80CmulAXojDek75Jy27m2rRC+FHa7oZg28b0pdL995DvoHY7PxlKniABvFpz2FVCHmZyYRboaV1EeW4cxIdhphoV39hCaI0d4IIgl2dhR57doFpzO6Q/gFWQ0sR28/l/yrlFwJEHXAmGLHzu0Q8978zWw+JlZrT58DFe7Mf1oGzb0VhNf6esDectG6K5D0L+7dLTYD3dlLPcrIKCHFMgqZ+Tge+9nXUn5t6Th7nEsKY6fP3dGpKoEMFIYFlGKaX5nyL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XH+WFhxOOg/PA0lBr7I5K9LpZ0Af4JOovZqd+e1TPTM0Uma9G14ll8n/LC?=
 =?iso-8859-1?Q?UV2JCtezbWu+qwUPm1o1UYKIW3yZjArTWlpP229Bnm62g1iMl1R6OQNTTO?=
 =?iso-8859-1?Q?EnUvCqa9LNkqJZCky0RvdhfbCRsRoew30/lBTHHpFZX5Bv8ZKLgLNQfQUj?=
 =?iso-8859-1?Q?kKLCuJW/KeX5D39dErA71v2rCX5N4Vu1028FsjIB2DpMjkxzAd1Es5r2Tk?=
 =?iso-8859-1?Q?OZ+YVtpKDusQdaiCBu8A7UahG6bNYFcuANtS+gp+EcYtTF2gzAOq4im/gh?=
 =?iso-8859-1?Q?N4pyQCyj4NWE0FFnb//yha3OkgBmayZRs6w//NkTjIQNe+ID0gQZP7OwVd?=
 =?iso-8859-1?Q?4YmqF6lotKOGA3Jfyya6T4uV9+vLbF7pnDSYS9u9qwfqSsDiFQ6wLVa8Nx?=
 =?iso-8859-1?Q?1+eP//ICdO8EDoXlAiuJOF3rI6wsN2G5I9s540qczIB1aZI+kRP7L+Nn24?=
 =?iso-8859-1?Q?3QyE67qbaKn/Vv56grPCe/LuO+VvYtiSGQfoc0Dwz4g38Mg80nAMV7dQIo?=
 =?iso-8859-1?Q?Zo6u6/mFqUi4YV6bg/WE/My7d0vBmjmY4rpupAFX633x8to65MaKZ5JuBs?=
 =?iso-8859-1?Q?WeeEKdq61fDJxU7St0qnD13dGulpasT4gSS3Q1qDgqsPIg/29mtShQJeMU?=
 =?iso-8859-1?Q?VhhzmU9Ud6Sl+JL6Qhy4IF2LPW5C1igq8B+N712KBkt5Tua2RebNniBEYi?=
 =?iso-8859-1?Q?ua/1PH2IIZgdV5GSKjKq50gBf6EdHaR4Lf1ewtU1O4nR3KbnLqrIXLDqEp?=
 =?iso-8859-1?Q?cXqFNYrXqeGKTtzA99pqIkpC9ojWRKPl6IHaBnURH80dPXjV+DoNMmHfUH?=
 =?iso-8859-1?Q?wbtM5xN5mYhej2ilXrebFJDwU/Kv62yFKp57JpThROdpaxflxxY8hHipiR?=
 =?iso-8859-1?Q?MHdqlQkU8NkXU4XJFmCIye6Bvs0tJLA5zjom/Az3N3iJRFCQ71a0UZeBjL?=
 =?iso-8859-1?Q?M5SjNvsvu6nF2raEd3cZWP9OITu4lKMOgizyjISQSQobDgyZrToQEAml3t?=
 =?iso-8859-1?Q?kb7K9lD1UlcgZ82vIPrLCmsRXdI1iyr1U+SD1Lqrh0B/EK/X5c5wdwP9aJ?=
 =?iso-8859-1?Q?jw5/5ntsSiGCuPNBg8HxKHbovBSVq7EoIw4xN9uxVj8W3vvwAC8KV+eKZS?=
 =?iso-8859-1?Q?V6FcjB5x8XUolEv0hLr5fJjJGF0R2NYKWbZ2LHquC76Fzh0tskP9+CW15Q?=
 =?iso-8859-1?Q?uzbTy9TF8HvFO9g7oygzoTbsMlR5uUr9D8oV1Y9c6YZ2zqgClTksv19vdz?=
 =?iso-8859-1?Q?Wzgp2js3necWiNOtAhw1GBX9p1khff2alq3nvWOzvZPYjdVcLOZVVRGd72?=
 =?iso-8859-1?Q?bR3vom7C2tCACA3ii7UJgT458dnJVIkeFiuuCCM+eYSW5JLqnKjyujjbiX?=
 =?iso-8859-1?Q?voHP6s058kIt5rUET9Y0sUCyH1B2lXlPK4scyy3H9ofaZFb/6r0OKjxRd9?=
 =?iso-8859-1?Q?79GI49CG1jkgIj71cz+nHor68hmQUC5szyL3gd/xlylpG84NSP74MCMzVB?=
 =?iso-8859-1?Q?rPHLKrYIFXxlJFQCX6L1As8quWHfUoC/1Dm/dHAz5JHNkq36LwEwsj6oZi?=
 =?iso-8859-1?Q?POGBSG2EW4l7rFGG6J0nw94aEKOBnBmsjq3W8kqXibNIbr+/pRGfdDapnc?=
 =?iso-8859-1?Q?vxDoAdtwYbjABKpCuHT2vECZKKBhF30kAZBjaNwOTi+JMmpH37SuDozXji?=
 =?iso-8859-1?Q?Fk7Wb5uYqYFPt7Z+5FOhZI6BMwvyiNdDMe7n5DVOaxZrS0ICBZmpPs8rLa?=
 =?iso-8859-1?Q?o3tZ5TH7R+FoswrNibSMB/EvmQ3R+wnyxZEI/Z38oSEtegqHZZKKFBtyid?=
 =?iso-8859-1?Q?PuWqEER4Ew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HYfsglgWtXha3OGIJroIWZgFFIeASAk7ak0TqyFjEEX8u70+xcw548hb4omlc/SxDtmfP234jy/xpBtK19PxsZsa0UlPJEPz8kaQlmSlZ+Hh3Am9BHtYJGQvjtGAbuHAWEI/o7KByKCiyTjAxRrVBgLqVk0CQ8D6+PjcbUIjLc0c/yfiq1LMxDa0PgZ3YSvk0fCZWqE16jhNmAQbRfKjRAZ2dTbRqUxkAN+wGFLr1O+ZjtjhkZLHxC8vHVNl+ivcZXwJsPQ8zDkf4tP+04erwDrqe4l/VjPsT/WSv+mPCDstkDuAlni1U8IT2aTSwhVRvqQ41qbcWtZdVhZRKSEMkg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ed58b5-e71f-4f84-3082-08df0711d22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:42:03.1436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtTf70cp+EEgRRJaHNRaYaJseer1UWKTPI9ZWlABU3oMoC7Gh1VNU98avhgthOEpgGdIFpbRXETMrd7NHQJdbTb2soL7GgLMXhdfWtod52g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The SBC controller register space is 0x1000.=0A=
Increase ASPEED_SBC_NR_REGS accordingly to cover the=0A=
full register space.=0A=
=0A=
Bump the VMState version to 2.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h | 2 +-=0A=
 hw/misc/aspeed_sbc.c         | 6 +++---=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 8d3f9207fc..756c612356 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -17,7 +17,7 @@=0A=
 #define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"=0A=
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)=0A=
 =0A=
-#define ASPEED_SBC_NR_REGS (0x93c >> 2)=0A=
+#define ASPEED_SBC_NR_REGS (0x1000 >> 2)=0A=
 =0A=
 #define QSR_AES                     BIT(27)=0A=
 #define QSR_RSA1024                 (0x0 << 12)=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index aa167be4c0..5c193d9086 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -456,15 +456,15 @@ static void aspeed_sbc_realize(DeviceState *dev, Erro=
r **errp)=0A=
     }=0A=
 =0A=
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,=0A=
-            TYPE_ASPEED_SBC, 0x1000);=0A=
+            TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);=0A=
 =0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
 }=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_sbc =3D {=0A=
     .name =3D TYPE_ASPEED_SBC,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 2,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),=0A=
         VMSTATE_END_OF_LIST(),=0A=
-- =0A=
2.53.0=0A=

