Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B908AC4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzds-0001Gq-LF; Wed, 15 Jul 2026 09:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wjzdq-0001GQ-D1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:27:14 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wjzdo-0005iP-2l
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1784122032; x=1815658032;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=WyPUrRr6NUdV0Ci4cIRCJykC0Zkr9JEsVIo/ohuwp8Q=;
 b=scju5HvcGnQ4X0aWxo1XfyOonOqzuK+33W4LS/8NSzFLi4hxkgWbzzos
 7TtRV8qXM4I8IaJt5ctJj+3mckeSEplSaaJGuZMFmchxoPbct4kGX9GR4
 ta3Ki4gUpi39jT1ju/8G3rbHlMYpuHNY+YKALmF+63HbPXjVigLvEn8WP
 Md+WkiWDxF39qI92ykFHskkgG+rhvMPQiz5VgNKfIp4nrpodGpc45Xn0m
 siASM6wSE3peKf0v41pLY9Oi6jsfwUimYNgN74uREaEa5U+0frMb/95wZ
 UgXiznPmmMjS95lOTOW3qJGCS00ml95rG+AtdPW9C0OCs9bzbC/t5SRLa Q==;
X-CSE-ConnectionGUID: jGYwDhQ1TkqnkG0TOMODxQ==
X-CSE-MsgGUID: eyZtJ7oRSSK/0WOu88FLgw==
IronPort-SDR: 6a578aad_iUVp9NQ9Dq+KwelwrH7qIwB1qchiVx6uc9A9UP5Xy9xkg+t
 OF8t5RvqRKN7Jl7e/KSRA44S4yKZ4wC/xo8np1g==
X-IronPort-AV: E=Sophos;i="6.25,165,1779141600"; d="scan'208";a="48429466"
X-MGA-submission: =?us-ascii?q?MDF2JBHx2VPhRYcOqMoPVLpk/QctfDrm1pCqrY?=
 =?us-ascii?q?9x1MqfIo0+X64c+XDHJnEryUblF0+9CkCvo9rVKbNgWvLrVkexjtKDaU?=
 =?us-ascii?q?MifXL2vIPxQt2ZX0idqNLppCAp7BUCzeZFcwnGmANXl5kYo07GS70BYe?=
 =?us-ascii?q?aEzYY4j8PMGwCLCDyEs91qCw=3D=3D?=
Received: from mail-northeuropeazon11012011.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.11])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Jul 2026 15:27:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZuj9/L2YCPb5CrYnHn5HGMoz3XEtgHd+bEIukEr2Nt2PwTDg90S49GgnHyvpIHpsUWYum/2yhUugeUov+/6Q2E85A6wfI9JYgktnNLEUwCUCdH+GXnt3lEPqvP87f50gr0aBXJvXn3OXCAXqnvQAbsOI6IcS4RXdo6erxEGfNdvKTtBTBo//3PjueKq+5hzod8EJBTm0iLgZ44fZryV3sc0tq1aE/mdrXvk15+C738HhRkHUv0LJBmGzbcuBCWyA81HMqizaWg7tMCOr8r384aaf1XftqIFyGF5+OqDHzbxyVFr/G4kFPDqdXsCOOj5fLvMtjHGRtqeOx2kweXn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMdiEXpv+OK4sigVCywem5aZPjaVokj8qfDU21x+IJw=;
 b=C946WIdevYgZcNBT9wGsYl/2TKC3PWxW30JqYOROPSQA0p080tdRj7a+Ina6pjNzi+xG4quJ0pMZGxRaB4cI4uKn+rHzFdgDqoC967t8LoR7H2q24wRsx/sXqB2rPZUgM+1wqxiSD7Rm1cG12a1fJe3XivWeVb5B9QeuIegUAFSUr1uH6X4i9/u6Umwx8RIUz7Zur+Flk70yb7WTofZOXftSpH+Uvi244P2ZlzlMDRn2fCdgwvV/Z5wLC5FQs4X4x1rpnHCmC7sPxHxOvC/KCt21MJehF52lcHDY/Rs11UJ+6tPDfQx4qRTpEsmNO1uBCSQxQojr8BvnuXmgs3ayOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by FRWPR07MB11447.eurprd07.prod.outlook.com (2603:10a6:d10:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:27:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0245.002; Wed, 15 Jul 2026
 13:27:04 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Topic: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Index: AQHdFF2gaOr43gDnOkeknlmRP+LdPA==
Date: Wed, 15 Jul 2026 13:27:04 +0000
Message-ID: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|FRWPR07MB11447:EE_
x-ms-office365-filtering-correlation-id: 2b36586f-2a36-4522-061f-08dee274c2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|38070700021|10067099003|6133799003|18002099003;
x-microsoft-antispam-message-info: FerALWrJPYg9yU+S9wtKfp8uiR64YTkbhg5JoJNEZKeiT/wAcdtel8wqnxbcwACDCaXxrA5Tm3YwnL63Z0D8D++avBQBkYxhWcJIyBl19lQUszpxg7KKdXSgHEV5YiHCKuOOAnMqAEiV+bQSBoo8ojzjCXFF99MpqZx8j7/tRJvUFSQmArCwaET8jgoFibpiODXW+VSDUvd7Lmv9pS0dN3WoZ5Cry1wtMlPrZ1qLOTHTBZImVQlN8VDJk/G5e4m8oXTF8zErdqyH/nGiFEN1XjaRjuYDD3h8rf8DK3KFEbtc0gQDkZWk2musiZwEuP8umUgWjyFnWk1l29Hd3ACl5Wla7cWOW3qvO111hZxeyy7elTRRUeI2BP52XgoTlQHb3Wj9n5uMmeWWQ65p7uKoAUbL/IDwrtp+e0WMuDYWofz66SlF5o64U/U5QyMXmn1QKH2YPLUOUHEvflqQcUcD4RGvaa7aRLlqHqy2nskyqLscQf5IdT+oT4vHP0eLMMEIn/tpZhQTHUe+pkx10XPcBa2rTGrLaQtymR8PuydblgH2kKx93+7ndJ+mDc4H4wNkToxmXCeTFXr1gKxsSKwH8XEM66f2CmeecxB4GpIOBBUKySDr6ZFvar59fyVr88DtcJDzWjawlChWsLII9nanutSHxSpchlLcY2koUsq1pkb5yrClYsWPsFFhEIeDfWFAsMrXGBhI0fMjAveCWMwF23o/HKj+3P8ph10D8+2r454=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(38070700021)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IyLYLbdh7yiJQ7HW/FM0lUH/X7gpeijdlnyWjW5HHIxP17AH2JTJ8OHcoL?=
 =?iso-8859-1?Q?j0Qw7DUDj97Z98SsUz/Fc9VxyNy/rDTyha1x4IcE+nQOoPLUKjRzCsQoUl?=
 =?iso-8859-1?Q?ZY+S+d3zwSsAxfCgYpcUUm+1UxOoGXDIW7yIEoVtsrwn3mSNM5xIcRPb4h?=
 =?iso-8859-1?Q?cQyGtKKYDU4tuNzCJf3F+R68JUKP22wdTv1DMochnXdPAC/aOgVYwLa1v5?=
 =?iso-8859-1?Q?uSso4H2dyTrVYv4y5Y2DaRCItqgmCJaHsrm8PEqUgDdurPVXEGDFcYdSRZ?=
 =?iso-8859-1?Q?v5a2vxJHW4Ug1Be5kMgEQxghT4AuQnGYCVfxR8LkSaKKyMfZpf4rj2TjTe?=
 =?iso-8859-1?Q?m7P1xsupJgrrJ7eA5Z8KHaCrrPQHl0Zd9wrqaujoob7JQKn2kKYFamPkRx?=
 =?iso-8859-1?Q?vFvqcOkNchwA0qtHEDu3iVGPbnkE4faP8D6LU8Q0Tf+0Kk9DZ95RMSOT+S?=
 =?iso-8859-1?Q?s/ct+4QXDgE+q/M9EfM0i5kNBtwy+8lgZDmqZ48dEWHJc55Mw6VjdTfn6R?=
 =?iso-8859-1?Q?ZtPTtwXc5gD3xVWSOgGKMIEPI9PPD6Cs3XkiwVZd5EYWuM1/0EGoh+5W0N?=
 =?iso-8859-1?Q?gv9Rt5+do2VyycktHaFjDkgILmzfdesWDe9Q8DGvHDHV6J7aOReRiaFZxm?=
 =?iso-8859-1?Q?JIoQ0jc1GbhF4WBDHe/tf8pDEdPbsfZ9sWNUdPt0R7vaYo83LvBQthqQhH?=
 =?iso-8859-1?Q?O17C0WRA6TvbSf8dN/Tfj9ETwxWXkhMYKcA1N5qH6DHGLrGusoTVoRPPQL?=
 =?iso-8859-1?Q?162OKfKV59EXRwpK/47DEqrLEqY/xTK0+faSX2vkQ+ww9cM57UwOsTSd+W?=
 =?iso-8859-1?Q?B+kejNz64CLYmof2Qvvzw0iEWzu4iGhFQVK+IFsVgnxwAUPIsMtVZ0AqDM?=
 =?iso-8859-1?Q?lXnoUioORF6S6JPlS9QM5ItNGCly+9V0Z+b0PfkDNBSyR04oEgya/wnQui?=
 =?iso-8859-1?Q?I2H/kPbzvzF5hYCoNmQbVQeCumn5Ux77B7kez39WrjCamEYmDA4iVVgwel?=
 =?iso-8859-1?Q?L+syzdczJRigl0BSR8Eg++8xE6a7JOOQy1PMTwtmTcaEfNbIug41WwRlr4?=
 =?iso-8859-1?Q?B0jkhmz3NnZScM++PTnQv3B2MpGyXkfdJ8+VHpPxXd7Tvv7enO8ONz745y?=
 =?iso-8859-1?Q?zfdSEz+jxMxUHxcDSDEaJ/OPMyBXxO1zcF23qiGNN1kiZy3umOO+fk1SzZ?=
 =?iso-8859-1?Q?IJRsBfuGdjgHdwTwiUtGquPw4FLxc4A85TQoggua9Gyf44CqF7w+cW5PfC?=
 =?iso-8859-1?Q?2j5XbAlj5sCNlFzdng/Z9J686UB1PZz/d+GtX18iS4zI5QHUVD28+2fxIi?=
 =?iso-8859-1?Q?zKV9A4kg0G06Cr/PH1n4XYYppxyhaFLcOi+0wyAZ/Hu89qqSX3FEVE4DNU?=
 =?iso-8859-1?Q?J6UbKM8xU7hOvcu/G6jjjTg9hC64kbMl0qg8D1tgmM42dKFELXhA+pPpeM?=
 =?iso-8859-1?Q?Qj80O1/HCTVqKPN+WY8OStw2G1Lj5kC+6j9OxBq2LdkWQB5/h7s32Kbg9R?=
 =?iso-8859-1?Q?o0y5exkkV3Nf/7zxIYkXhdw/AbXNKMsZqD6iBjx7QHLJZQMpLd37A3nJAs?=
 =?iso-8859-1?Q?pRWF99xNkugcrO+zveDeYADGItkEQeZHN6258E4417i5qADKQolxmHCmse?=
 =?iso-8859-1?Q?2BVjauXlXHVKXFKeUGHb/Iq2fsvAFPVYTh26dpFYWqYh0M1+eW9lMsjm+1?=
 =?iso-8859-1?Q?WFRINKBLtKKx+S2fVe/n2Rv6UEUDtMuZnTw5FbtuyJPYX141vG1DqFolP1?=
 =?iso-8859-1?Q?faktg371Xd4U1j2zIRrdpSdem+QsU79Cm2OplsUsksBQwEXe7i6XnoMM9V?=
 =?iso-8859-1?Q?sTlO7HQy1zmHzR2rHPls0XxnHG5xVUiszlY2nMtDBOtUTeh+RRaW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A6SD/QJns3AkW/wDLHibHStuD5A7uEstcOovDZi9uppLZQoctc4LY05EJK8gqVD2WqhoP9rcXDUFAdkbpXWDNhcOYW6UEHJrc+E7tIr+FNA7ApXgkYPSXL8jFKclyOY9ZoE1AKCRotiNO2db6X5FQIMgEO2SkWwyJa7RQZuelU133mvBzeh3T1HWhWPJMopVM3rccr/0iXKAWHZmEGmmtUhH38cuibt8LPu1cnC2PntjVm+RgplNkvDh2Ul7hMQKKpf7O5iTarzKqni7/Qqc8r7zflFv7BSP4g5ibivnkTZrZOk3iYnK/ALMQvjq3Cqi1bPXqgaS7wogjgskfqnXxg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b36586f-2a36-4522-061f-08dee274c2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 13:27:04.5223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yx6aMkIkimCfNoKboA/XEHMcnEFJ980pOjP50f6G3gF2n77JkSHX5nlDDxZAGHU/WMhqxCgflstu+ZsKmN7hnuck15EC19ARx9uqKOSpHM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB11447
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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

Prevent a buggy driver to execute malformed invalidation operations.

Add the same assert as in vtd_iotlb_page_invalidate.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bf4f0f2f6b..c591d1db3f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUStat=
e *s, uint16_t domain_id,
 {
     VTDIOTLBPageInvInfo info;
=20
+    assert(am <=3D VTD_MAMV);
+
     info.domain_id =3D domain_id;
     info.pasid =3D pasid;
     info.addr =3D addr;
@@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState =
*s,
=20
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am =3D VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        if (am > VTD_MAMV) {
+            error_report_once("%s: invalid piotlb inv desc: hi=3D0x%"PRIx6=
4
+                              ", lo=3D0x%"PRIx64" (am=3D%u > VTD_MAMV=3D%u=
)",
+                              __func__, inv_desc->val[1], inv_desc->val[0]=
,
+                              am, (unsigned)VTD_MAMV);
+            return false;
+        }
         addr =3D (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
         vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
                                    VTD_INV_DESC_PIOTLB_IH(inv_desc));
--=20
2.54.0

