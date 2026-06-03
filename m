Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74067CD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF1-00006l-JH; Wed, 03 Jun 2026 02:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEz-000069-Hv; Wed, 03 Jun 2026 02:38:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEx-0008HM-7i; Wed, 03 Jun 2026 02:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHdGrw3uXXcC7KQKN3QcY/h4ddxSIY61wRPwEw1ChRP+as6snCjsiGCSuCbD6gXkYH2ggNfxBKEOwv+qSzsOD7Lg8QFeatjGf1/wqq2Fk3vzs6+9wbwyjOGp9j4yxDIio3nNE+/Z0AM1iCUTS1drLQQlipamO5f8nndGUBIQl9h6AbDMquhAdivf0yvm3ZqCpJ6BNlfjTSbvMAVfn6m8CV/VfkxdbCCOrJRMNHrV1sIpBnv1B03FKeSj9UbrzJs44Pmda0hOle9yHSx1UuksI1uyOquOLwQBgtPht/ZRX1umiZgrdD3lATdpiH94xP3iERwsXQUIIaI3nLRTc0o+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GzQITYdSQ4PHvEFsqv3NmxgB55AenqB8H6OKIA9d80=;
 b=wSj4OkJ3eVANmk0mlsL8GfFm2AhBGct4WbKIXNsj7x4Ukm+bSruNMxIYPIHdBwCweEps0CTjeqhSSJMOmu9FzbOve5neJPCkP1bl7witabidgtg6u9Ki0aJmeOreXrU1zqjGreIEyVvsA9JiupjdT6zvcI2z6y9sqeRB1nkKWT6o1wNxw+1WHlh2K+tNotkPAVn8qAKz6eRipiGBGJx3luCKF52s3e9/ibZgdjERsJIeDulceP+Xn68pZSRUcOr3qx9cpNLzKcwjpr6UZuJsZhu0j2Glyw+b1FLRQGahNKtx7QQQ40yeE4xRGsIpHwx2R/shOQfQnC/qLjgKTa2IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GzQITYdSQ4PHvEFsqv3NmxgB55AenqB8H6OKIA9d80=;
 b=knH64CXodu9Iam92hszB3tOuwIpCfJMfWJqRyms2KrevnKHPswWdqrzDNotgLGPBV8T9Cy4s2v1paRB29OdPjz8L3lJ+tphxjXxnBnB1t9+6mubA1W8YXrTqJN1XcK1Vjqg7fjpBvL/VygoBI+bcDRrZAKcb+NPH+RI+ErvttyxBOOw6/5XHk53FUdD9dTWnR51HgZzfZOeAVMBXrIFqTSypfVnw6ZCM3aJDjjnaYyPa0+q9LFKAHNdzrA8WuzeWGVeUzHCOuYRf9F2yleckg34nBY2nX8JlFNkwNLYijChMVmoEksMFkN8feP0Ht+IEJWLQHpHEVEaHX8M8zg8SJg==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by SEYPR06MB5859.apcprd06.prod.outlook.com (2603:1096:101:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:37:59 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:37:59 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 1/6] hw/misc/aspeed_scu: Add AST1040 SCU model
Thread-Topic: [RESEND PATCH 1/6] hw/misc/aspeed_scu: Add AST1040 SCU model
Thread-Index: AQHc8yOEJotrwQ0ri0q1fUaX2ZNe6Q==
Date: Wed, 3 Jun 2026 06:37:59 +0000
Message-ID: <20260603063756.1481524-2-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|SEYPR06MB5859:EE_
x-ms-office365-filtering-correlation-id: 0149c426-6f34-4c27-fe87-08dec13aa772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: yyiHvfnVdBvLXPQnuOKO3/nsRpxDzZpRF+FPAxqT2j7UzDAFsoRYOod+s8vYVH8DIdHCs5JOmSzVevcn9xe5QkRJnPz9XGC8h8ZnYKZg0qyDXCMKUP81aQfD9jqPTAnLuON+CikLnNqdvQpZXAyiT1novJHbSxRI3weVWrExmfJmRAIQ/0putwnyA4I2nln+7m9eNcCzZEUHMQ76lg0oipweyAX0dGZU2oVW8jAE7PT5MZjdNC6V3FQX/OZLIoO1ogaHdLrBRknWGULtaVk0ru1THnsQAQhAI6eiw0MOd0zasfjCd4FmtzP/4jDJTv474hPYcpYzOuQhE/9CL0PxcDKGmq4wnaNX2bWGOsKS43wqRa0Dh0oskcvvoNYG7lcuywJio5zTTzp8NJOZ9teaSK4KMfBoUDvSNG/Xznxh2BleFnNHNjFjsRqz+Qs9MpBAbwpjAb9f7ngTMuuNAf1tZ0CXSlHp6HPFR4AqQY/pAAFXGyhTb/n7t9d0RvP3vZr3XzeEce2BT4PcIKCHCdKcc5FVE1ThSqQuN86Gzk4254Et0mZfzgTk1lc7EmOsuJDFsWaic1Y0aSGX/BJVvFHZPKfCUqHiTLE6TZ+eIjRh6MIv3V+TQQGwvNMTYvsb3HKaPwyh4K/c7lRSTZT3xcWEMBCcq2s0VRq/9KOuGsbc0Lm5lQ9+xYVYx5C3ROeuNo/ya5cGyjIdDSj6PYbSPM3toIk35u4Ko/vMZXqGfl8RcL8BY/t/1lB+QmCJ9dv4OjrDZa7zXG0zfiqtS4jLNTHpfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rpgjyTwppcSfahNEcPJHnFYcQbtrdsC7aEsr35aIil2FE7x8jK5Q0Bc3t8?=
 =?iso-8859-1?Q?kwYoFsjaE9zPYD9vJvI3Px1FvvwCRDKeyzZ4JxkzLxC1pEH8ItAc7+fbSJ?=
 =?iso-8859-1?Q?qItzAeWcBAQ0H3nYXbbA7YPuLEvgc17lcqf2lrgvcsd0iUFVYe6RcF41h1?=
 =?iso-8859-1?Q?i/UJN67G0LQi+nhXHoSOfoL/oEz9f9HZKkHLEBkCTsknimgRzSY3qSgxaX?=
 =?iso-8859-1?Q?v8Kwn8JKXBbSivWV5KDNwEf6ivXAOoZIiwOrlcznXmIKc8dTdS9wTGUD/s?=
 =?iso-8859-1?Q?Y2FiGnseCO2C7b4LmMKSQjIS14JUyXj9nE90ggJENBkhbuuc0dFwjDzep8?=
 =?iso-8859-1?Q?rMWqX+rZ9qGRoiebvi0wxgoy1OLTGljy73xjUA9yaJ4c+1AfGXzx35rxJ1?=
 =?iso-8859-1?Q?Blfurl7m6/az4tJLveFTpfXPo16fsz+wURjz6rmA/69fmTfphWEJyXlOoU?=
 =?iso-8859-1?Q?Y5uKW2EHn/we+GCYqUbzLm2+/MsAkyl93Z2oGuK3lif2qEwCEeuKANbcyD?=
 =?iso-8859-1?Q?ibd4elwllfl47Liwrrhu/4u6KdML6dOIu5wmZOlFkLEcaL8mCzPEF9S1Qp?=
 =?iso-8859-1?Q?RLgS1sdPwo/oBjiLqMELVQagMSS2me7WP2CXi4vq//08Z/7EYAsCavfW0r?=
 =?iso-8859-1?Q?vndvgEnZhjF0UwlOUxbK4puL/Qac7kQCgbgm1t3f5VNWXwT54sKar2Q3SH?=
 =?iso-8859-1?Q?rMoWUFwrfQHW4WTzLyg3TyckJS/XjK1/GHAV6BTnnJwsKc7GQ+CShyokwI?=
 =?iso-8859-1?Q?sRwZ7wCpJyyow20D0Vx1Z30mXxrTFUTodhls+dLMo4Q9uNZxPQHsqk++lS?=
 =?iso-8859-1?Q?6Hr9eHXu4mIYr7NcED0o7gPfPuopkt+Yzky78z0u5pYhL/p3qhaokku2Ag?=
 =?iso-8859-1?Q?Ch4ttNXyXpS9yO/qEaSFkb/KP8DECveDKp8VHXO6Xk/ET1GoC54WzG2iUQ?=
 =?iso-8859-1?Q?vnCIzrR1pwDeV+h4ZNjG7FJn77KwOwB/oUiLeaNY30jt50k9p3W1xe6sso?=
 =?iso-8859-1?Q?6QKLgKnokHou0AfU0+D7UKLkHXoMkOGOeNWaWs1QziATQNWMHXbjuhA4YI?=
 =?iso-8859-1?Q?Z+1UwR69plxNLmXKvtTzaoJhRil5kbFFk7MTJ/v/x3yW2Yj9m+09eM3DOi?=
 =?iso-8859-1?Q?OXfI3zgFeFeIBysj+gjgM9Nvhz6zW6qUBS1TER6uVw5Vbc+24PTGQfD/Oi?=
 =?iso-8859-1?Q?JJHlHsENOI0R4XbId6ztGeFDnmPaPRuQY04EwCJ4AcevazTXRoT5tmNwQV?=
 =?iso-8859-1?Q?PJGSf7DlPjfRaLVFsirtLuyg+8pSHKVkFfFERbzgektA8yKTp5xeGDydGb?=
 =?iso-8859-1?Q?F/9bK558rnhhBizhOyxgTT70OGHYxRFzvVBxHkiYsiqQ6niEzbWhXCv5FI?=
 =?iso-8859-1?Q?7n94swG6oRIp0yH5yjx9guGFUGHVdCithUGlNxjdIT/Qw1UrocHTFzWwe2?=
 =?iso-8859-1?Q?5XE162zJ8cFoHHl+k9ncLZHTpd6cUKrsZg3LYTVzKmmMp1ppXc+nocSW8f?=
 =?iso-8859-1?Q?bYb5Z/gy2G7/Be/670QsP7Oy7mvJa4Ak+8bqAAOKowq3/CN0Q5Zl/1tYYY?=
 =?iso-8859-1?Q?ZVqzFA2M33NIIpIii3MKWcwgBuEazBHi0/GT+MhiHn3oS8KyRPmHuXRoOF?=
 =?iso-8859-1?Q?pmk0QjsHNkRz0Au1LmTydFN/NY78pA0Sd4d9lZtQj1VbYedB69Pz3jLhqx?=
 =?iso-8859-1?Q?2syczkl/lQsgcqLad3/spK1ZSeoiwXMITUQ2Hv1pcQJxfLbMnX6RLzld0K?=
 =?iso-8859-1?Q?cHCbJjte65c1LumuNe1SfnnYmXKm75UAy/dogFVKf2KLU4xgE5jiTK2E8y?=
 =?iso-8859-1?Q?4CTj9/deYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qpVYv4JkwBq0frSMefLVssxbXzsUP1ifQG+h99hW8XaBgT/fChataiopnAfSZpY/7mMqNnPK6JY5adO+kLw4ED/zBsHgEtsKILgz9it0Fcx+OOs2AiWp0gqPCdMhwEiCvn26OkROEHz8sC9OnvgKyQhTHQifh70oDPGVDnt5e12I5wdzkveSSfx+fNnW8s2IGI6J00HOVxAifiGhp6nIUfhD0v9wDJNGHdWpND/b1L08s31mLq+B2oR/jvPNIPwrYTnB1eachzMklalUByy69qIZJ5owKt4EQiQ7vcs+xcBFqkeWeoPNnnPHww26XhDbQbsAkqVrf869LCyDzS0ZDw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0149c426-6f34-4c27-fe87-08dec13aa772
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:37:59.4251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WE0LYihy180sopmegy9meClOFza7EPgYkrvigc8KCDCbsFE3d+p3Ddo/OpQkcsEAqlRgqbRojpP++R2aZdkSfRDiDpfftBkSjNijSoToIMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5859
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=steven_lee@aspeedtech.com;
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

Add an AST1040 variant of the ASPEED SCU with reset values, APB clock calcu=
lation, clock-stop handling, and CPTRA page-select registers.=0A=
=0A=
Expose the Caliptra page aperture as a QOM link so the SoC model can wire t=
he remap window without callbacks.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  10 ++=0A=
 hw/misc/aspeed_scu.c         | 251 +++++++++++++++++++++++++++++++++++=0A=
 hw/misc/trace-events         |   2 +=0A=
 3 files changed, 263 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index c30940ab76..6445ae5cf4 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -22,6 +22,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEE=
D_SCU)=0A=
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"=0A=
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"=0A=
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"=0A=
+#define TYPE_ASPEED_1040_SCU TYPE_ASPEED_SCU "-ast1040"=0A=
 =0A=
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)=0A=
 #define ASPEED_AST2600_SCU_NR_REGS (0xE20 >> 2)=0A=
@@ -39,6 +40,15 @@ struct AspeedSCUState {=0A=
     uint32_t hw_strap1;=0A=
     uint32_t hw_strap2;=0A=
     uint32_t hw_prot_key;=0A=
+=0A=
+    /*=0A=
+     * AST1040 only: alias region (the Caliptra MCI page aperture) whose=
=0A=
+     * target offset is selected by SCU_CPTRA_PAGE_REG0, linked in by the =
SoC.=0A=
+     * cptra_page_window_base is its base in the address map, used to reje=
ct a=0A=
+     * self-referential remap.=0A=
+     */=0A=
+    MemoryRegion *cptra_page_window;=0A=
+    uint64_t cptra_page_window_base;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 19da6c075f..028677880f 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/visitor.h"=0A=
 #include "qemu/bitops.h"=0A=
 #include "qemu/log.h"=0A=
+#include "qemu/range.h"=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
@@ -179,6 +180,41 @@=0A=
 #define AST2700_SCUIO_CLK_DUTY_MEAS_RST TO_REG(0x388)=0A=
 #define AST2700_SCUIO_FREQ_CNT_CTL      TO_REG(0x3A0)=0A=
 =0A=
+/* AST1040 SCU */=0A=
+#define AST1040_SILICON_REV              TO_REG(0x00)=0A=
+#define AST1040_HW_STRAP1                TO_REG(0x10)=0A=
+#define AST1040_HW_STRAP1_CLR            TO_REG(0x14)=0A=
+#define AST1040_HW_STRAP1_LOCK           TO_REG(0x20)=0A=
+#define AST1040_HW_STRAP1_SEC1           TO_REG(0x24)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG0      TO_REG(0x120)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG1      TO_REG(0x124)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG2      TO_REG(0x128)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG3      TO_REG(0x12C)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG4      TO_REG(0x130)=0A=
+#define AST1040_SCU_CPTRA_PAGE_REG5      TO_REG(0x134)=0A=
+#define AST1040_SCU_CLK_STOP_CTL_1       TO_REG(0x240)=0A=
+#define AST1040_SCU_CLK_STOP_CLR_1       TO_REG(0x244)=0A=
+#define AST1040_SCU_CLK_STOP_CTL_2       TO_REG(0x260)=0A=
+#define AST1040_SCU_CLK_STOP_CLR_2       TO_REG(0x264)=0A=
+#define AST1040_SCU_CLK_SEL_1            TO_REG(0x280)=0A=
+#define AST1040_SCU_CLK_SEL_2            TO_REG(0x284)=0A=
+#define AST1040_SCU_HPLL_PARAM           TO_REG(0x300)=0A=
+#define AST1040_SCU_HPLL_EXT_PARAM       TO_REG(0x304)=0A=
+#define AST1040_SCU_APLL_PARAM           TO_REG(0x310)=0A=
+#define AST1040_SCU_APLL_EXT_PARAM       TO_REG(0x314)=0A=
+#define AST1040_SCU_DPLL_PARAM           TO_REG(0x320)=0A=
+#define AST1040_SCU_DPLL_EXT_PARAM       TO_REG(0x324)=0A=
+#define AST1040_SCU_DPLL_PARAM_READ      TO_REG(0x328)=0A=
+#define AST1040_SCU_DPLL_EXT_PARAM_READ  TO_REG(0x32c)=0A=
+#define AST1040_SCU_UARTCLK_GEN          TO_REG(0x330)=0A=
+#define AST1040_SCU_HUARTCLK_GEN         TO_REG(0x334)=0A=
+#define AST1040_SCU_CLK_DUTY_MEAS_RST    TO_REG(0x388)=0A=
+#define AST1040_SCU_FREQ_CNT_CTL         TO_REG(0x3A0)=0A=
+#define AST1040_SCU_CLK_GET_PCLK_DIV(x) (((x) >> 18) & 0x7)=0A=
+=0A=
+#define ASPEED_AST1040_SCU_NR_REGS       (0xE20 >> 2)=0A=
+#define AST1040_SCU_CPTRA_PAGE_SIZE      0x1000=0A=
+=0A=
 #define SCU_IO_REGION_SIZE 0x1000=0A=
 =0A=
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] =3D {=0A=
@@ -1165,6 +1201,220 @@ static const TypeInfo aspeed_1030_scu_info =3D {=0A=
     .class_init =3D aspeed_1030_scu_class_init,=0A=
 };=0A=
 =0A=
+/* AST1040 SCU */=0A=
+=0A=
+static void aspeed_ast1040_scu_update_cptra_page(AspeedSCUState *s)=0A=
+{=0A=
+    hwaddr page_base =3D s->regs[AST1040_SCU_CPTRA_PAGE_REG0] &=0A=
+                       ~(hwaddr)(AST1040_SCU_CPTRA_PAGE_SIZE - 1);=0A=
+=0A=
+    if (!s->cptra_page_window) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (ranges_overlap(page_base, AST1040_SCU_CPTRA_PAGE_SIZE,=0A=
+                       s->cptra_page_window_base,=0A=
+                       AST1040_SCU_CPTRA_PAGE_SIZE)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: refusing self-referential remap to 0x%" HWADDR_=
PRIx=0A=
+                      "\n", __func__, page_base);=0A=
+        memory_region_set_enabled(s->cptra_page_window, false);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    memory_region_set_alias_offset(s->cptra_page_window, page_base);=0A=
+    memory_region_set_enabled(s->cptra_page_window, true);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_ast1040_scu_read(void *opaque, hwaddr offset,=0A=
+                                        unsigned size)=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    int reg =3D TO_REG(offset);=0A=
+=0A=
+    if (reg >=3D ASPEED_AST1040_SCU_NR_REGS) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "=
\n",=0A=
+                      __func__, offset);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_ast1040_scu_read(offset, size, s->regs[reg]);=0A=
+    return s->regs[reg];=0A=
+}=0A=
+=0A=
+static void aspeed_ast1040_scu_write(void *opaque, hwaddr offset,=0A=
+                                     uint64_t data64, unsigned size)=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
+    int reg =3D TO_REG(offset);=0A=
+    uint32_t data =3D data64;=0A=
+    bool updated =3D false;=0A=
+=0A=
+    if (reg >=3D ASPEED_AST1040_SCU_NR_REGS) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx =
"\n",=0A=
+                      __func__, offset);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_ast1040_scu_write(offset, size, data);=0A=
+=0A=
+    switch (reg) {=0A=
+    case AST1040_SCU_CLK_STOP_CTL_1:=0A=
+    case AST1040_SCU_CLK_STOP_CTL_2:=0A=
+        s->regs[reg] |=3D data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
+    case AST1040_SCU_CLK_STOP_CLR_1:=0A=
+    case AST1040_SCU_CLK_STOP_CLR_2:=0A=
+        s->regs[reg - 1] &=3D ~data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
+    case AST1040_SCU_FREQ_CNT_CTL:=0A=
+        s->regs[reg] =3D deposit32(s->regs[reg], 6, 1, !!(data & BIT(1)));=
=0A=
+        updated =3D true;=0A=
+        break;=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG0:=0A=
+        s->regs[reg] =3D data;=0A=
+        aspeed_ast1040_scu_update_cptra_page(s);=0A=
+        updated =3D true;=0A=
+        break;=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG1:=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG2:=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG3:=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG4:=0A=
+    case AST1040_SCU_CPTRA_PAGE_REG5:=0A=
+        s->regs[reg] =3D data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
+                      __func__, offset);=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (!updated) {=0A=
+        s->regs[reg] =3D data;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_ast1040_scu_ops =3D {=0A=
+    .read       =3D aspeed_ast1040_scu_read,=0A=
+    .write      =3D aspeed_ast1040_scu_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .impl.min_access_size =3D 4,=0A=
+    .impl.max_access_size =3D 4,=0A=
+    .valid.min_access_size =3D 1,=0A=
+    .valid.max_access_size =3D 8,=0A=
+    .valid.unaligned =3D false,=0A=
+};=0A=
+=0A=
+static uint32_t aspeed_1040_scu_calc_hpll(AspeedSCUState *s, uint32_t hpll=
_reg)=0A=
+{=0A=
+    uint32_t multiplier =3D 1;=0A=
+    uint32_t clkin =3D aspeed_scu_get_clkin(s);=0A=
+=0A=
+    if (hpll_reg & SCU_AST2600_H_PLL_OFF) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    if (!(hpll_reg & SCU_AST2600_H_PLL_BYPASS_EN)) {=0A=
+        uint32_t p =3D (hpll_reg >> 19) & 0xf;=0A=
+        uint32_t n =3D (hpll_reg >> 13) & 0x3f;=0A=
+        uint32_t m =3D hpll_reg & 0x1fff;=0A=
+=0A=
+        multiplier =3D ((m + 1) / (n + 1)) / (p + 1);=0A=
+    }=0A=
+=0A=
+    return clkin * multiplier;=0A=
+}=0A=
+=0A=
+static uint32_t aspeed_1040_scu_get_apb_freq(AspeedSCUState *s)=0A=
+{=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(s);=0A=
+    uint32_t hpll =3D asc->calc_hpll(s, s->regs[AST1040_SCU_HPLL_PARAM]);=
=0A=
+=0A=
+    return hpll /=0A=
+        (AST1040_SCU_CLK_GET_PCLK_DIV(s->regs[AST1040_SCU_CLK_SEL_1]) + 1)=
=0A=
+        / asc->apb_divider;=0A=
+}=0A=
+=0A=
+static void aspeed_ast1040_scu_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
+=0A=
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
+    s->regs[AST1040_SILICON_REV] =3D s->silicon_rev;=0A=
+    s->regs[AST1040_HW_STRAP1]   =3D s->hw_strap1;=0A=
+    aspeed_ast1040_scu_update_cptra_page(s);=0A=
+}=0A=
+=0A=
+static const uint32_t ast1040_a0_scu_resets[ASPEED_AST1040_SCU_NR_REGS] =
=3D {=0A=
+    [AST1040_HW_STRAP1_CLR]             =3D 0xFFF0FFF0,=0A=
+    [AST1040_HW_STRAP1_LOCK]            =3D 0x00000FFF,=0A=
+    [AST1040_HW_STRAP1_SEC1]            =3D 0x000000FF,=0A=
+    [AST1040_SCU_CLK_STOP_CTL_1]        =3D 0xffff8400,=0A=
+    [AST1040_SCU_CLK_STOP_CTL_2]        =3D 0x00005f30,=0A=
+    [AST1040_SCU_CLK_SEL_1]             =3D 0x86900000,=0A=
+    [AST1040_SCU_CLK_SEL_2]             =3D 0x00400000,=0A=
+    [AST1040_SCU_HPLL_PARAM]            =3D 0x10000027,=0A=
+    [AST1040_SCU_HPLL_EXT_PARAM]        =3D 0x80000014,=0A=
+    [AST1040_SCU_APLL_PARAM]            =3D 0x1000001f,=0A=
+    [AST1040_SCU_APLL_EXT_PARAM]        =3D 0x8000000f,=0A=
+    [AST1040_SCU_DPLL_PARAM]            =3D 0x106e42ce,=0A=
+    [AST1040_SCU_DPLL_EXT_PARAM]        =3D 0x80000167,=0A=
+    [AST1040_SCU_DPLL_PARAM_READ]       =3D 0x106e42ce,=0A=
+    [AST1040_SCU_DPLL_EXT_PARAM_READ]   =3D 0x80000167,=0A=
+    [AST1040_SCU_UARTCLK_GEN]           =3D 0x00014506,=0A=
+    [AST1040_SCU_HUARTCLK_GEN]          =3D 0x000145c0,=0A=
+    [AST1040_SCU_CLK_DUTY_MEAS_RST]     =3D 0x0c9100d2,=0A=
+    [AST1040_SCU_FREQ_CNT_CTL]          =3D 0x00000080,=0A=
+};=0A=
+=0A=
+static const Property aspeed_1040_scu_props[] =3D {=0A=
+    DEFINE_PROP_UINT64("cptra-page-window-base", AspeedSCUState,=0A=
+                       cptra_page_window_base, 0),=0A=
+};=0A=
+=0A=
+static void aspeed_1040_scu_init(Object *obj)=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+=0A=
+    object_property_add_link(obj, "cptra-page-window", TYPE_MEMORY_REGION,=
=0A=
+                             (Object **)&s->cptra_page_window,=0A=
+                             qdev_prop_allow_set_link_before_realize,=0A=
+                             OBJ_PROP_LINK_STRONG);=0A=
+}=0A=
+=0A=
+static void aspeed_1040_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 1040 System Control Unit";=0A=
+    rc->phases.hold =3D aspeed_ast1040_scu_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_1040_scu_props);=0A=
+    asc->resets =3D ast1040_a0_scu_resets;=0A=
+    asc->calc_hpll =3D aspeed_1040_scu_calc_hpll;=0A=
+    asc->get_apb =3D aspeed_1040_scu_get_apb_freq;=0A=
+    asc->apb_divider =3D 2;=0A=
+    asc->nr_regs =3D ASPEED_AST1040_SCU_NR_REGS;=0A=
+    asc->clkin_25Mhz =3D true;=0A=
+    asc->ops =3D &aspeed_ast1040_scu_ops;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_1040_scu_info =3D {=0A=
+    .name =3D TYPE_ASPEED_1040_SCU,=0A=
+    .parent =3D TYPE_ASPEED_SCU,=0A=
+    .instance_size =3D sizeof(AspeedSCUState),=0A=
+    .instance_init =3D aspeed_1040_scu_init,=0A=
+    .class_init =3D aspeed_1040_scu_class_init,=0A=
+};=0A=
+=0A=
 static void aspeed_scu_register_types(void)=0A=
 {=0A=
     type_register_static(&aspeed_scu_info);=0A=
@@ -1174,6 +1424,7 @@ static void aspeed_scu_register_types(void)=0A=
     type_register_static(&aspeed_1030_scu_info);=0A=
     type_register_static(&aspeed_2700_scu_info);=0A=
     type_register_static(&aspeed_2700_scuio_info);=0A=
+    type_register_static(&aspeed_1040_scu_info);=0A=
 }=0A=
 =0A=
 type_init(aspeed_scu_register_types);=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index b88accc437..82ddbf4d15 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -103,6 +103,8 @@ aspeed_ast2700_scu_write(uint64_t offset, unsigned size=
, uint32_t data) "To 0x%"=0A=
 aspeed_ast2700_scu_read(uint64_t offset, unsigned size, uint32_t data) "To=
 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
 aspeed_ast2700_scuio_write(uint64_t offset, unsigned size, uint32_t data) =
"To 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
 aspeed_ast2700_scuio_read(uint64_t offset, unsigned size, uint32_t data) "=
To 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
+aspeed_ast1040_scu_write(uint64_t offset, unsigned size, uint32_t data) "T=
o 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
+aspeed_ast1040_scu_read(uint64_t offset, unsigned size, uint32_t data) "To=
 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
 =0A=
 # mps2-scc.c=0A=
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC rea=
d: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"=0A=
-- =0A=
2.43.0=

