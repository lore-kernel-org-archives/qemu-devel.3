Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E5FC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEm-0003lk-38; Tue, 01 Sep 2026 04:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEj-0003kq-4s; Tue, 01 Sep 2026 04:52:58 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEh-0007J9-0X; Tue, 01 Sep 2026 04:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFPXk1qvpSrQmUBfvLIUhSgzJibKycTrn12h0/Nxjoxtw8xALa3esuky9eJuaGK4MywusUZRQgmXZxNahrV2dfATjjJa6RgSwEvpspt6QfeU3jS0UdjHef5up/vZL4RVo+DOMVsnn+2QA4CPtNFnrKjjO0qTwb/5ux07b30CTzpuGf7Y+u1pm63Y0uRGIK1t14+Y+bhJVpOjMqoLZXOBY+xKa73BpNET+gFzd4ZKAsVsYe5Vd1Iu5W8bgesBawJ1f+GltD/2AiaiQ0LhmfkwAk3ObFCCLKNpB6tMk0Bs1AIu42mPb8cZt8MSe4KrfL+M6gDpAtErFldxwuPZBL0Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsrtTsHp8Unc03aAkdxBPuobxigWnr2gEOyUZMnTfsU=;
 b=OxTWkxkhq7ctN45Q/MvQV3i0snUm+lpFLI7whEk+IJwfrVXutodrq8YOP7gSmMKhDHcAsxAuz/fF+b50gqVB4AiCm14kPSW7DcaZIJzteTGR2GsHY32dM+zeWFXqRpt/syRneEOoi8tjY3Gpw6jKWSwD7xC//yXi4Ivb9UtK7bJxOpBQDISyhY+Wm1DbMOAmuEeHM+JBdH8aSpN+THhnwFqLz+pztQbKvWObMsCKvfsGMN6ZB7I571Zb640YbD4DnA1PKqCLyofv4orV5phsgeWg44V42rRiMvO08T+Pqg/cT1/2GluId+rqptf2bkRR37i3J6U7YfCejY9GOKkiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsrtTsHp8Unc03aAkdxBPuobxigWnr2gEOyUZMnTfsU=;
 b=dOFAeHXLLEmjBehJk5BW+DsjnoDXa1LeEh5OMzqj3iJEY0eWT1HYmBngoPGBoV7ms2aOP69HxOE7F7/L6kq5eZaul/3oaE3q5aEh3oJmFFXXS7xcsB/egnhF+AzJTPoq9yj7aaxL/dbxsbidzhSgCzbXufRc6MI8Pu6rm3oUoc3JGsVsJXUASlPvxZ5niqo/nXxLanpqqLN2CpZW5GETt8l2kk0evt2kFOHmL2RPHCWKAd+TvYHSB5VIuwTcIwp7VmNyz8DDEZgmr3Tv4RVWIp5u2LpYZ4LigcKlW3bofaP42xzQaVawSrTgo/k1zvQpUQ6/R4qFjTS6WL/hSzcUoA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:46 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:46 +0000
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
Subject: [PATCH v4 6/9] hw/misc/aspeed_sbc: Increase register space to 0x1000
Thread-Topic: [PATCH v4 6/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Index: AQHdOe9COoxFzIgG0UevbnhuMIP5SQ==
Date: Tue, 1 Sep 2026 08:52:46 +0000
Message-ID: <20260901085238.995968-7-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: 2235c88d-80b8-4783-5f10-08df080664cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: DvN9he1d/QRBF017bD9btKHXZ80frwTsO1izrajrFm4zo/wjUjdpdcyWvrPIdr1X7E6nkKLb3MNoKfTX6c1HZVvF3lxPYNUdck0vHtr6XLRw++mI+j4hNw5EBFyxXh+hdRw4Mdtt1xrwa55GN8YpKxKISZb10AgvxFH3BnNPuMSlLjUfBu3x1cFZN40ITEwjPu9mfmLXFEmOSyPgqrTGI+KKsWLn3YTrbDgxEB3E5lVN/ZC9StxgoSu76baT+4hq5U9e/+u6fFSAFlwvUWpGN51M7ijTTnGfIBFDmwUjbQG+da0LMheDIwsZuI4IQqhD1EjhiQ/zqm4drIZrYYg6X5o/Yxf3r/536iOa8bUrva5H4LjiwCPwuiyET6Jd8lHQgQd4AwOnFOyDS6zxaRXw5LV5eoQ4S9rQSDHjug5oE8CjQ5+j/lmUzo56tbnUltowqsHhil0oCZ2MCu3/SQ5kHY261ESadwn+irHSqPzLT8MH/z6HPh8XFxaEyVZi0RhEHBDnF4jGTNx1HSRWl+F10eWXt4v8ONc6mwKDA9A+WYAhI4gFXHWhZ57I+ZVkiEVjdGwgaryVl4eZlsz3e2FFBU/1lCoqDxCfl182G+iVVjaaMygxGFi0OixIkFqTrsWpfNEZojyxiWCU2eu7dI6ZBMW9LumkvUq6iKZMrJTa7TW7qFVpz5QI4rxjoe2rOjl++qhc3z4DQzA/mLWQpHfp7JSFQjIDqBBBYYYNpiwT/fE1xmlom/E5XCxHaJbkqPvt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BXBmIIBC98gGKGTA57P1VN1GuXGSA4JKpBPpAjV0pCUw/ZfJOP0wzCqTVW?=
 =?iso-8859-1?Q?d+Si19YGdsWWeBWKrrKrd3gDc/ag8feKdmoKDp5c3dTsrRUXX4sKqXx5Cc?=
 =?iso-8859-1?Q?JiS4qOPxtS9NQu7XT4XRXzhIMmldosH4Aq3HQF/bkE1qNzqTHlzfqRy9UU?=
 =?iso-8859-1?Q?IYLTHpEIf4zhDi74Cko3VSgt2d644iVPiplbZ5R6uVdjXZCbrQgxZ6orxN?=
 =?iso-8859-1?Q?atLxTEoVfzdRdms4SceBzFY9f5gQP4++GIw0NJzngLuwHJ8OQefVtRnlxC?=
 =?iso-8859-1?Q?B5DGsmCu3MUQmP5H8I9GDrbQIL/QI4A4oI95dbx3untG8L9nQA9+hA0hoJ?=
 =?iso-8859-1?Q?pP51ba1p2tiFI7T7oAPEXKouCrBtMMywz6LdTvtIWsH7Bh1Q7bLewGALSx?=
 =?iso-8859-1?Q?+fKefMiqOKNhTTKtLcoCAkseNItVbsI/DZHksYsMBWvdIDfvgpE5IeTNht?=
 =?iso-8859-1?Q?gbjD/YPGaob4/4ffduOrhrCgq+OLTArslLgBI9idUnIStstvU3zK6XRqEe?=
 =?iso-8859-1?Q?GpEfcL4YTVz6w6q19hYKowA2aHRzpUskxehptMVT0cezSZNyRqb5u4PlGN?=
 =?iso-8859-1?Q?Zt/6DmNrhURPrwi2uieA4CkPJUDn2Jlw3aM7+bZE2S9TMNNLae4Zh1vFBG?=
 =?iso-8859-1?Q?yryX7BBJ1ro21rMF/UdmNCZVew1onYA68knELydjiq2YuwFEPVuqsI79zU?=
 =?iso-8859-1?Q?+9BvJIH256uFGKRpL5Vs4BdHmnGgq2QHRQ9cCCS7zyveYUJFoqmlFda4fQ?=
 =?iso-8859-1?Q?rBgl/mX+lI8PajFleDCznrPWxj1wfkhBLPCPnO+NlZTze4dGalUnTeYrI7?=
 =?iso-8859-1?Q?vdX+YaRQu9LMRZFUtd0FTclhFCX16AJsjmPjOFVGmjw3n3MR8e0kLr+FDf?=
 =?iso-8859-1?Q?MqrFZxCxmlMmqo9W+mHCCzd72AFHCVuBBdlMgcsDJbzzn5eG9PeS5kMtXN?=
 =?iso-8859-1?Q?n7iNDhDJpJX7gl7fqvI9NSFqW6hjCEXwlgnQxJCtbNkQKczma4GkV1Jsal?=
 =?iso-8859-1?Q?upGHYhYIVooJDd76SjKJdZK54H1hBdJifnVRolRQw7Dxf4zoWnS+nloFY+?=
 =?iso-8859-1?Q?LSbwnfRZwznp+0fGvOKdDI0H1+sl7adMwh75SPXcnTAk32eOlVT4TfqaPU?=
 =?iso-8859-1?Q?vFic5jgwX2td4BqjU+IfSm21IpWsZ4SVmHY/80n5oXWVn7Ox4XsN+ihRvR?=
 =?iso-8859-1?Q?Ew2VVdXTGfJB31WZzUrqubMVHVcwTWspBUXf5UjVQpTmlCbPLWJu8Xf8wz?=
 =?iso-8859-1?Q?BAsYzK9iFc695P9qOffPY1jYPlK56sw++hyAZW9vpZ5/8XT5+x3FI9b0EY?=
 =?iso-8859-1?Q?YTLpwBqb+7RSJCZIRKWEabZPMrgSRvuux029d6b4NqizNN7dvAa5F3xLfG?=
 =?iso-8859-1?Q?c9iwdm6O22xEmtxCHUi9MepZlrxTFByrn/5WGF07XE3v+7J6o22I8xKbmT?=
 =?iso-8859-1?Q?1LuiUj01k9BAXlAtg7jErH8BvmCFBUiJPX4lxPWhwW0X8yJVYirdIQlUgU?=
 =?iso-8859-1?Q?7oNUPRQb/YA2tILh5DDFgducj+nOeumPDEiDyq7It8aRuUOWf/NV0U4CwH?=
 =?iso-8859-1?Q?+dmKPL/iixfFe/TzxPuAehwqfNvKTysv8DJMWI04M36i/cKU1VDqn35Lzs?=
 =?iso-8859-1?Q?4bD662pOrA4o+U6Nc9+cG2+zgX00pkHybEHNtpy/XApILwxfU+u0JMZj8n?=
 =?iso-8859-1?Q?Xu8uj51xIoLPfSzMtFHiDRpt9fSeTgUfh7HzZeGrBQvMelvIRQURNjhdoR?=
 =?iso-8859-1?Q?25XCkD2LquE3GP4aYHIGJumS52KbgCdMsfJr0xXx5Wtpt++/HdsERKnCQS?=
 =?iso-8859-1?Q?2vXAlVndIg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BMA0DmsrP+5cAudurDoubApxGB5s9tCjK0hkXrlUTbh/DX4LWcH9v4pnaIZU/jeLtRDHJidzqDupx9SwMJ6jG+3qAj6Q91klEpcq6J1a0JE0GzgqKIGxe24IDrZT3ag/h6zUjd7Ed6gvhegvFk6w99fEJ0GWNAUrUX/0oTTuX+je3EEvtdXFx9+izQHHIcgFnotKNmKBvEV9yWMe9O9Cq11aKsMb9Fg9L/gWYnDMgCKPYU9fN/Alfn72abzNp/omzSc15fHB9C4ntgknJbTQW/OgDX4DoQ9U049LBrQEAi+6ZMjynpR++D6kR11Hx54b60YXoaxlfoUEAawVw0pYFA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2235c88d-80b8-4783-5f10-08df080664cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:46.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +s/Vluxk2ADm1glbZibX1l1y1jsucAzerZEyHVRwzz/n+Ei665Jwo4Ns8wtYErwKCXc1f3wshJeBgGXWWkkr3vtY+k9k6zYwJiGUpZoZ/1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

The SBC controller register space is 0x1000.=0A=
Increase ASPEED_SBC_NR_REGS accordingly to cover the=0A=
full register space.=0A=
=0A=
This changes the size of the VMState register array and=0A=
therefore breaks migration compatibility with older QEMU=0A=
versions. Simply bump the VMState version to 2,=0A=
as Aspeed machines are not intended for=0A=
virtualization use cases.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h | 2 +-=0A=
 hw/misc/aspeed_sbc.c         | 6 +++---=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 07c7c22a86..eea6e2b27f 100644=0A=
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
index 1dfcf14e5b..7397d9bbf0 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -307,15 +307,15 @@ static void aspeed_sbc_realize(DeviceState *dev, Erro=
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

