Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbrU-0003H3-EF; Mon, 06 Jul 2026 01:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrR-0003Fi-8J; Mon, 06 Jul 2026 01:27:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrP-0007PL-HM; Mon, 06 Jul 2026 01:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvYCqxCCiyWO7bBBH+Z4W1Nz+o1lXwX+aj5xruGnj4FrmfJX1EEE6SEi4+5d8dF69GL5Cjty8O/O7dDMXolLj4fRE6C5YH5q55IPnBmW8YFhl16m26nxHYo8q9DnAnYh4Qal6QXGoB7XrEMTlDNJh92OSw5Qbth2XX/0Jhj0f+8McApV0tZP8v0EpHrHxBNpmTElfBXgIKrkSNk78CpI6l1FegjxmXp7J8eb467CBe+2ToRScjph0D4w1AMEwwl0Q+YNKMUWGZ5GK0eAM8N2gTrx+8ihNtWAk0PndPu4MjHp0JQ7IqoZMtmHtx/t86KBouzFnGqZZRIrb/3yhMS+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94vbNOGCks2vjHSJcEK5yetyR54oySMUHGy2QBg7Mbk=;
 b=WUQRHShqiKRjffogZtT0J2t7u7zb0VygKylDvsiNyYrL9RPDPTe36KTbW2PrgJOAcTjAarim1iPASqikbx7UN98CJZsz42ZaoUrDCutqlRZEbzHw0Qz+mbQh2XgN2zAnt6et3ADGw54204GdZpTBvn0I6lM3EnGzogOGgqKlIni3i12pMDvgyFyk9A/YDi24M4eoBbxpNYWmFhZPb9E7pepw6seXH1n/Aw6pVR+sJKUNUSfu/8wXrAqGiiWXV8iMHM3KTFwyu1GVzFD0h1MQtpk0NH8yBH4wBSuO+wEagmXIAG4GnLIFsY7K9id5XvCHZb7C3fP6arO24Eu5mFm2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94vbNOGCks2vjHSJcEK5yetyR54oySMUHGy2QBg7Mbk=;
 b=p46bxkynoRGHlT+fE5gJF2LZM1qIA6PJU5ggrRamlODzymaxT2Ntm8UlGF5ukPg+SQU2ZtwHllhvlUIq33RMAUPsV9p/1hHhpM1ulqSqYiHoaZn5j7LvFEROg8S2xSJFomBjUfyZJQ7CGTin26S4chLtC8WPnYCWu8dIDGvVNuOcnF59ubob/ArKhT0pST6i6Pf5lrT4b0Jot/x2I/lGRIfKiOCwbDjsz42z0mzilZupuMuBxAc1Eayh28c+strK6CGKPspWN6lC1F1JZhaLmPUXohhevig3c+6WA6Ynn82OFWQoS79gXa2qYrFj10h0kjo8a6yNSEB0olRQnO0vUA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/5] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
Thread-Topic: [PATCH v2 1/5] hw/arm/aspeed_ast27x0-fc: Fix hardware strap
 settings
Thread-Index: AQHdDQgT0WcNCgpo0Ei4T9tLv1nHtA==
Date: Mon, 6 Jul 2026 05:27:03 +0000
Message-ID: <20260706052701.1141740-2-jamin_lin@aspeedtech.com>
References: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: b7159e0c-0989-4c4f-a7b6-08dedb1f3665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: w3hl0twYemslei3+NAAUW18cvjrYe/i6O2CoEzNFKiFmT/It6VXeTVQuTYZedtmSh9gPwDdei4a+K2r7yEwJZO67D19HbZljoRCCD60/SBwy9nwdWgchpSMomKGPTGoBxDFuj8Ewpbmm/VwsenxYKo74IRmuSfauLyYjpySKGJv9hQIPGQMylf7n1Anfqk33SuuShW0fbfdsEItLP9VwWgEroG5MdpOJfP6ZyBT8SAsZZwl5v0AWyxhy+vf+f2k1RbjiHtNY4j2b1w6K6qlPnifQie9fG7t8TEz5Su+ONayZhGXhJoPLInH8MOlCz2CYCulb0H68uoDOEZlx/2w7kH+O7eMEzyApCzb3LGRT5rk3Bg+t2sFkUdUQB3FOMGmOXKhFktYtNCbv56ifl4uHScq+xg52cp0qK+Zu08j/0hRgXhc6vD35gHADUR2z6vwBBhZkJK9/Qq23Y9h9zgFUoPteR6rP5QeREXA77QAPoc8o8j6mq2OwiuYnd13DTxAtmyBv9AN675oJAkLhD09RestBhh+a0/lEZQerdFEyP67EZlHFqiKBlFMSWBxIag7t2zdvzSD5C1q74CWuCHIP2XC8EGuQVEFYRH863SQGU1QRZoCY8SiDZCIZBxu0JV9K9MtTgTUOv35AuP2gJglag7Cq6Z7QM/Rz1WGzs3ku/dPuxNII/b328DZu3fgOvKAq+mhAbEnWFU3ezilK/SdBwiuPleU/90/MVUVjB14EBLw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RvlDz+NMW0X1uzRepxaY0agOCPJgoBQjGMnWnWwVdy/33uXzoiHb2yQ2ci?=
 =?iso-8859-1?Q?EYhMAn8RKGAZsrUmOJZaRGlhffwf0oLeK1Z60e3/GA8w396+z2KwTodbaK?=
 =?iso-8859-1?Q?k66ONlb97GK5Ro1FGSctAxZR0n2spg6aMz98wD6oqJEdX+QGTybktuqWXs?=
 =?iso-8859-1?Q?gu2eFRmRNOx8mxGlwXkWnAAbmoeuu1lmINeZg1In9gpKpm4nAv9qahZDdE?=
 =?iso-8859-1?Q?UYTbbq7JBC9dsgonsFM0vREqmPCLvucn6/9nModdYMQkr1Jg3UE3dINUCz?=
 =?iso-8859-1?Q?9mM3UjH1G8L7m0V5Z8AQjPM3aLmfLbSHgf1M4EMR+XHsRC9sTypDxDZ7Dr?=
 =?iso-8859-1?Q?XanDOYU2vNlA+kmcGJ3CmPYXgxTKe+OlphZdad3+AXBVNLIX6MjpBmyupc?=
 =?iso-8859-1?Q?AL1/EfW0tFWrYUVJwPypTUGdVkxEtcj1Rq1o6vINbyDuCFq336pzG8CWHw?=
 =?iso-8859-1?Q?AH+/+7euYeSpsE7I9yQJ+Hco8amZU/rGCPNVkIr+ztbIiPKujOtXrq8ePR?=
 =?iso-8859-1?Q?dFUihD2km1jntMN09Z8o+MMg3nR0kmU2VmjmAAC9AIZ+BneZouXElyF23U?=
 =?iso-8859-1?Q?BqgAXATnC5xhwyQ1DM1fV7g6Ro9lZs/9/Y3JQWfFJv4PCn+Jks9aVascWC?=
 =?iso-8859-1?Q?RzIc/uzwiMYgzYCz+kDr4E0V4burFaADOIEJbkX7u/L3wBOsFcRfe2mRkC?=
 =?iso-8859-1?Q?zfk8tVoJQKLdUae22ItR2Mi2CTu6yga1avMv0Fyz+ypNY9nVszqtAStZ0L?=
 =?iso-8859-1?Q?E1u2RT+iWVwiPmaV/pz5/9MYiHzzMI7gyyMspgdYIii5kw5j+BuxhDBBXF?=
 =?iso-8859-1?Q?W1A7/L91yXc5tW4buhxZJeslsPO2ZkEAMDpZmLVuHybcx2GEpRs5lZPDPR?=
 =?iso-8859-1?Q?SyerF3zSUwp0DZ2AAo+P/A40pC8ccSYudo8T7wo43lzwP+zfO0DFYJ1yyQ?=
 =?iso-8859-1?Q?mMLrm+8cCdkj6WoaT/gRaKYkq6VJuDcrsCuhWvnMg5iP2PjJQIyIxGfVf8?=
 =?iso-8859-1?Q?I8z78NZP5nM5WmBsX6fscOK0KFRP6U/EmsZUjIeUHQk52UyrwkLmTcLO1w?=
 =?iso-8859-1?Q?D4jhRd3X8r9YOnS0lz4A5rN6VQniTNczfQSnJbILimiuja4KpHxJREwILm?=
 =?iso-8859-1?Q?1KFaMbwdy5i7ATE5Swp22VrNiDofmmLN4Ezcephg7MpOPsCxOzzqK84ByW?=
 =?iso-8859-1?Q?iZMAxx771xec000NbOnDLrsxchTR+G2UbmERdEOvILyF0IeRJvhuQB4B4C?=
 =?iso-8859-1?Q?tQq+CC1yY5ypX8tYjXWyguy613I14yxmlXkNfHu4nGCv359uzo0N54ZkK0?=
 =?iso-8859-1?Q?US+9omvM7IxsQjbuXDtfAVFNG+wn48cY47Dnu8EsggSdNJf1scysptCyyg?=
 =?iso-8859-1?Q?tE8HvBno2m07k9R45ayJbnFnCVLaWiguITdOMLPdTNo7vwfupIvqVb1Ii2?=
 =?iso-8859-1?Q?YSbDst7w1rtLVk5sPPV/EhIEA8x3gPyWm8Ku3PDWWo+hBlMwKDigg9PlCN?=
 =?iso-8859-1?Q?VY4yf+8NOXjjQBIy0Wy6V3RWmvr9rDcpmW+Tya2hJkBD2S2PkGKssZuqOQ?=
 =?iso-8859-1?Q?hYi+h/3H0E50F8avJBzSX46GmjAdEu/QyFWWAj4+PGkeKyW5LpMVPkTRAr?=
 =?iso-8859-1?Q?EGQQ9VO9a+9g3FhKyJ6evVMnsIi2AVefi0DZLkOWwbYko0X5QDuAPnOzKp?=
 =?iso-8859-1?Q?E8rHgnUdZ6qaTwltjUTdqVp9kCrS23NX8OWYIrl9sB47u3wl0zPuMg8Gq5?=
 =?iso-8859-1?Q?rwuQJGD4uUwNcd1wbt5HpQza+HXGegaO2qMlW/EMMKNTdhG/EqFcjb4b1+?=
 =?iso-8859-1?Q?QjPxWrKnFQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QXxvHM2D4ZjQCkVPbpcvnzMb7K0QN7g+zoIVGkQpkfWaHdZC476ZYrQI+fEXbOgoPAMBjjEnsYZgwbLTIuprwh+nTgr2oenfbgaqJFnxxPGvORRMj/Ew7kC2XY3spQndXp28tIw/bxhaDf+cfBaK8A7fIJ9eqeMZ7SE8kpxgAlVetIwdU2U+c19pj4LYIMWE7+Rs+lSU5xWtGCNZRrsMNvkFkG8KeV6etA+zHXaDQYg9ejRq9C45gfgEHbbQfSTN3oWbXFx791RknrWI7Lvf5cFqh88sPCbSuobvUs9LhRHiBioHZ7/kLy4HSY8rbSsmOikweQ1FEBnEYqi07otKdg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7159e0c-0989-4c4f-a7b6-08dedb1f3665
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:03.5781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3MAWWn4rvjfZuzLykJmzzKeGcbHF5tgW5ZjtPHNdY8aY7r82OHxememCR7os3aTKJWSHcZ2KEFH6f/CQIAtr6j6dJeV48T9/VTuHdVjzrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
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

The hardware strap settings in the AST2700 FC machine model were incorrect.=
=0A=
=0A=
Update HW_STRAP1 and HW_STRAP2 to match the values observed from the=0A=
real EVB dump. These values are also consistent with the current=0A=
aspeed_ast27x0_evb.c machine setup.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 5eb6680da9..7d9fade68d 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -50,8 +50,10 @@ struct Ast2700FCState {=0A=
 =0A=
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)=0A=
 =0A=
-#define AST2700FC_HW_STRAP1 0x000000C0=0A=
-#define AST2700FC_HW_STRAP2 0x00000003=0A=
+/* SCU HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP1 0x00000800=0A=
+/* SCUIO HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP2 0x00000700=0A=
 #define AST2700FC_FMC_MODEL "w25q01jvq"=0A=
 #define AST2700FC_SPI_MODEL "w25q512jv"=0A=
 =0A=
-- =0A=
2.43.0=0A=

