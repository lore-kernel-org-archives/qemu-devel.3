Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352C8C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsj6U-0002mB-JF; Sat, 08 Aug 2026 11:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wsj6T-0002m1-1K
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 11:36:53 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wsj6Q-0006uu-Kv
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 11:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786203411; x=1817739411;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=bQkQNORml1w2HOgKYM5A0taQJTXcnpGEQWfc9xVpqoU=;
 b=SWOUiuChW9iLJ8hoe89ebLNg6e6cnBKS9Epp4k1LsdV7TbsqZvPn9hwe
 CqvAj2205XXoAZrRvLqHuyIpdM/+wxvyQ3XBwf2B9HAA5IsnLfeRVirQ9
 5Wdl8qCC2/n2O0qjmGo50W1f1IgRtekdr9Z1W4tEODWb+HFfgkRoL5ki/
 bMpds9KEJdNLH7EldWDintFDvId2V5VPVXBUYvM8Sk2HWVgEUxltL/Et1
 e1I+mmKpFjsGSI6T+4jz2pC+Gfto+haqjjNqFPnranrqGzN5h7piLlr1s
 0a/E8SUK3PfPlTcthiYoxEXzLFPpkfvpXghZvk8E8hjk3V6Inq4rcg0eC g==;
X-CSE-ConnectionGUID: eDEdpf/CSbSQf9Wqwe/4LA==
X-CSE-MsgGUID: oYqzWtmQS4G9ir8vg8K+9g==
IronPort-SDR: 6a774d0c_J8V/8mgTAVL2KJg2ATo2t7sLpzz2/V8T5gmUd0xFQkQCKrM
 4tqvvZbLj4Q/17NdH5ANkxfpi9NsgCJWlD1yLFg==
X-IronPort-AV: E=Sophos;i="6.25,212,1779141600"; d="scan'208";a="48578579"
X-MGA-submission: =?us-ascii?q?MDFp9SgWP2ZxAJaTPs3GVuxbglz6SEilIinn21?=
 =?us-ascii?q?1ixiCf0fkwh5+eLf2BKkvkShiAWoSOPk30iNzQY9IN1BzzWvTZwMee/O?=
 =?us-ascii?q?DE8cHs0yhX4KsPXxdW4fuB0579kzjK5bWrHEQb4ziTPwTIix5EdZwZDd?=
 =?us-ascii?q?txsw/NYY62G0aXFHbjYy/Lmg=3D=3D?=
Received: from mail-swedencentralazon11013002.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.2])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 08 Aug 2026 17:36:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/+fcIsBx4BfoN0zb/A7r/h5JaiJspGSn7ms1Xx9ruMjJRqbyh5FnfVnDos5j1j1xh7R/2FgvwGxiaZdAQ4HT5iD7j9v4omjz+A0uWqizSFaNkZ3r4B8KFYB34wRm7PgXAVE34ZQVSukngaSx/jTscWKpIAJ4LnCar/eRy3pOuOXzo5GyueA75mCXcLnKa1FpWOc57fDP44PglrS1+tkHNV9riT0X3hLgBnu4PckYx+6LyERPbVtWC6PFzvNQfSVl2aQC5z7AQesdNQa5c6G01rVXwV5VvgmxFJJJ5knylukqnSLcalj/zMkPGA2gWrBR305OO++GoGfNA5k5sc85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIEH3PbZIHESgnztFKR8f7atY7XUnWw3uZPL1JvORnI=;
 b=AhD6caGBTd+ify8L5r5qpXMIH2hx/KVf5uoo844RVycrjhVfBsRX/p7qupL0tP1+PN8yArGIRTcS/u2uxCTX1dgOMoic3nIM5W/n/TJ2l+/yFCJv5xlkyfaXQJed+4MImqTlEmtwx9hRUTIAWBMuy4sTFWcH8WUcuLVFXIsNhsqvuHf0A2Lh3HC3tgwOcFiHdnoqFzG+KPOfYJn/J1Lg5nr89qgbkfBqVHj1Ey6TkyA8xoXj/4oGN91uwMNF6cKfN+olDJwD2WwPXF40vzwU46xPA1luhGtSiznS/6IstllTLkX8IpbSgjbpo3FOdCULHPnXzRB6egpcVUH13tK4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by ZR6PR07MB095149.eurprd07.prod.outlook.com (2603:10a6:910:db::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.10; Sat, 8 Aug
 2026 15:36:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.008; Sat, 8 Aug 2026
 15:36:40 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH v2] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v2] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdJ0u05hBgRFNdVEyKKLViqh+TGw==
Date: Sat, 8 Aug 2026 15:36:39 +0000
Message-ID: <20260808153626.873965-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|ZR6PR07MB095149:EE_
x-ms-office365-filtering-correlation-id: 457834bf-4b10-4cce-3a4b-08def562d73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: xCHpHIJxYN4/CfqndvJe8fYI9RkiRJDSP50YTnNt51oh1rUKg3ukMhcPIKZK9X4zZCv4DqSwTn4XnpO0GlOk4dd5kk995cfFodPl4zjJXjHrJ4i9yr9Vn0hvjANAy1hDGz++YE2vG+lvL90ftgF/4YneALzxn7OHukMB608N2Ud39gsrFSx4WM32Vc+TzeyLMvmtJFa9UQF5rF0M0l7tu5coik5xFgv8z3Vr79FvN0U58u4YAMVQsIqMwqX8foeLqEiUTF/C8WNgUh4QgSGBRoWJwcN5FvhoAkC/f97Vy1nr2gT9bztcf/s5ezW0rJr0ep7407u10kWpu7Yo0zwK4P3KT0wD/JJmIiZLJUT8UQHLiPOB42dKoV/RXpWkRm0o6dPbNYoMwsTSuDU9geE0GIc1T5Kt52MVcYueIghP+/E5vuA7jAb1C+4DumBOenUVOjLsjDY549cbl8AeNDc/NeyufjJO0s3lVuZapQTkOmn5UzvHxEHRkKSgJR0EutwaR4qhhiXh/TJcHL3UxcgzaxJNId2rOZ1r5keHCZ8r+WzHWScAuo4xK+5SQSjVAOewtvqw7T4o4V9V1/v1eoBFE6GQ9QGMEPpS4V1zlXtBjTkRHQWntyM9OZlnBOvM+mh1+jJKrgnOl2EKRgvHaVh80qXcbyUyIzdL2ML2m9WUWU8OWFaZ8PwhvVuk2pxy8u54KC86mChQ5OyLSyTCOC6+wbhQpwRvKLfikwlV/SsP2P0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZaYg+VpjfcBfqGDWkbpkyRZMdFcHtR4vNoznQhSOvSs0M8zcgu3IL/3Ss0?=
 =?iso-8859-1?Q?iWx2J5NqihUb8UefNsjtPM//gBPecGi03z4vpskfcjnpsz6ks5oVlh/o7H?=
 =?iso-8859-1?Q?wUHv1hwYqX3f2blUeT5Te2F5Fgocze8dVeHhJxfCQJ8UxQ08OAp8ccbW5I?=
 =?iso-8859-1?Q?8RisRyOGjOqyjNdt2TRRWAJkwxDnBh2IHGQqgnyLVIUIorrNhkOXSHzsBj?=
 =?iso-8859-1?Q?Ef8oOTCbBCoYwmp3ENX6EaYpKtsfq9wJURlqJ1X7eQSZ9XbH51AG6/bHip?=
 =?iso-8859-1?Q?PP5GBRbjs1nhegdekpAzT2k7+JVSgek3Du8RpBClhtFg6SB32wZCBJjggl?=
 =?iso-8859-1?Q?IkMQhLHhDEO731ygIwkGCWTsFCO8UJD83rX9OD8myGWc0XyVnhse1XpFT+?=
 =?iso-8859-1?Q?s52D7G+Rk8BKcY/WdyMH129AV6w/bH1HnmUQ1pJ1uabvC3cNAzKsykytaf?=
 =?iso-8859-1?Q?WSRmll+aGfdLf+f6VZaQvdXcBzm0zJo2aHZM2duzm31ZE+tyFoKV1dZMKU?=
 =?iso-8859-1?Q?mYMuyaQHtcrVHkakHXKgevJeI9ev7ziBHhSXnVsr0m4C2YY1xY721qcgl9?=
 =?iso-8859-1?Q?Cad95V6CuWgFlmRk4LNNkwaA9MhkDqL/z/Vd30h5m6WmTtr7VNVSPI3c2w?=
 =?iso-8859-1?Q?sOzgYoa+va35zFlecJ/tjJ5cyleiGbNy3xSNKYZ6CyIWwuN2r8M5kxV/xI?=
 =?iso-8859-1?Q?lwVUscNf5gkz2tW0TBSrUricKKGcwFc1sFCiBPWUXc/QlJYMMJ1PUyI3vt?=
 =?iso-8859-1?Q?yaUfwJOYsHV8wbnxxYWM6mt2g9wk533cvit1hISrdFDCyxfIM+Ck3f8gWT?=
 =?iso-8859-1?Q?SFCeKkewMFo1UsHyrbbFP9rldYbwu6YDrVxBkG/We4MGoWyBhA6bPPSGUh?=
 =?iso-8859-1?Q?hw6ye8+2d44MnJtmD49vnSTIdwuTPZPpdCFg4kdd09TErJO4SLt4jtcyDN?=
 =?iso-8859-1?Q?rd8GaXvdOSl8ZtX7KsZ4HEMDwM01QnPjlAw1iD9tROkSW1IgVj83k4P7qB?=
 =?iso-8859-1?Q?YrVC3li/faZpWx/aE7iTY/79588UDLLpyXivFTpSDYrlbxsdoZ07VkORnC?=
 =?iso-8859-1?Q?ftEsTfIO3q2A6/3tIT1B9LJcptawwdhRcDl8qkxz+c7ufcm/K7KAIFTJev?=
 =?iso-8859-1?Q?iWRRm6VbHNPHmZoch933GzwEOYgb3/J+viepByLGEYDRrlb9UmlGTknVFC?=
 =?iso-8859-1?Q?PyATS8z62g25xACsWVUYdlNMuZBxgNCnK/Va34IHkAzzbVH4Fo+6jCMLgC?=
 =?iso-8859-1?Q?ilvZfkAJziNwOodXpXlx9li4cg3v/Qz2hUcrGqA+fGzLEBoCJKA8kLx2Jr?=
 =?iso-8859-1?Q?ieG7l1sqhjVvCjoHE1KyPKGZlrOKVYRaiM+XDven0lcP1aA8pCVIKpCWnF?=
 =?iso-8859-1?Q?fSW7GvIbBx6UI7q1i+Bsbfmus6NWYHRrIDD26iUlALujpIPn/11kBvVL+g?=
 =?iso-8859-1?Q?jvzOStp+c84OKcjZ68uIp0v2W7dADjC/VV3BAK/dkV9UrAkGr++cexHrON?=
 =?iso-8859-1?Q?s3l4eOADBLlXcgffj2G7pJ8Pi40y2G5akYD8VV8omMPP/n3tbFAk0e7EbE?=
 =?iso-8859-1?Q?siMGm/QvXL/F6fGd2e79ZXfIxQehA9onaKa5t1XEeJ923Nkvu8OcGf+rLA?=
 =?iso-8859-1?Q?eULfbpQPxjFOWKY4ynv0beXNYlhr/B2TuOxjE8SU5daGMdcxkNwRBbuPw/?=
 =?iso-8859-1?Q?DSiqk8WskOy6K4NXYu/NSnAD1vT673+TUqjVeDPdLKS+6HOlhK6+08tDq2?=
 =?iso-8859-1?Q?RZCF//2ID0vuWZEhtGrdURrO307LuT41qvpnkew4nB8n3bjIClmfqmvG69?=
 =?iso-8859-1?Q?l3jCaLrKiRYFZmk1YvFKmMsODo3ygqY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M/4AGBSm6lqvDtlsiQWSIMsveOVwbNyrcKNWvql/Fof/0euI18ONJMxELGX4WvcRWXG3WWww9YfpupPI+emxYeB6zdngAvsa4HGuvb/b/BGDsBrP81Xg3S0k/4F/O2f4ABQuMjy/28/QDjPEFGAO1fioESWRjU9HCWla+qoZgpN/PidxdZ8IbjiEca1873AzpnhS8s5mw/Obsg+GHCToY2YfrikUxia0tus7oO3tPr2a4nqwuqh/HkY2b6COzEec7qkLA7ctrwDBjL8/yzf0yNoWtBvMfhgBJiWgCHjnw4XJNds6ttM52vp9gap6OjXID6pLM2+c3KUoaEROd7OL0g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457834bf-4b10-4cce-3a4b-08def562d73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 15:36:39.9822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfajd3ygn4OCSNuGnZaMwYTavd0eO96EytQ+S91rUr5WNzMhMYB3kT+jl0gVljsSXO3Ivvo+LUwYLAnpktoxEGVQxovn2KsX29vY9U30NxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR07MB095149
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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

SVM in Linux requires SMPWC. This is free in the current implementation
as it is already in line with the expected behaviour.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D780dfed68862
Fixes: 952e1a6e90eb ("intel_iommu: Add a CLI option to enable SVM")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
Changes v1 -> v2:
    - Check that host IOMMU also has the capability when accel is enabled
    - Add link to the kernel commit that makes SMPWC mandatory
    - Add a fix tag
---
 hw/i386/intel_iommu.c          | 3 ++-
 hw/i386/intel_iommu_accel.c    | 6 ++++++
 hw/i386/intel_iommu_internal.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8245452d89..9f21622a4f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
     }
=20
     if (s->svm) {
-        s->ecap |=3D VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
+        s->ecap |=3D VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
+                   VTD_ECAP_SMPWCS;
     }
=20
     vtd_reset_caches(s);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index c03435f8a2..c3677775e9 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -37,6 +37,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }
=20
+    if ((s->ecap & VTD_ECAP_SMPWCS) && !(vtd->ecap_reg & VTD_ECAP_SMPWCS))=
 {
+        error_setg(errp,
+                   "Scalable-mode coherent walk is unsupported by host IOM=
MU");
+        return false;
+    }
+
     if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
         error_setg(errp,
                    "First stage 1GB large page is unsupported by host IOMM=
U");
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 924e91cb8a..df7a0efa6e 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -202,6 +202,7 @@
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SSTS               (1ULL << 46)
 #define VTD_ECAP_FSTS               (1ULL << 47)
+#define VTD_ECAP_SMPWCS             (1ULL << 48)
=20
 /* CAP_REG */
 /* (offset >> 4) << 24 */
--=20
2.54.0

