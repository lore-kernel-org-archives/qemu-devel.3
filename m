Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C1C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 16:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqYgk-0005t1-8j; Sun, 02 Aug 2026 12:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wqYgi-0005sr-CU
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 12:05:20 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wqYgf-0004HV-MW
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1785686717; x=1817222717;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=vGTQF8UaZrpFgZj3g7FmJoXIgpY0jjdj6yNvQj3da+4=;
 b=v0vJX5bzkoj97a7h4C7MG7V+Dm+oDSuuXqmDoYeXG/mHMMwJc2gt7xGh
 TgiGkTLQ5zghRtru1zN/+s98guIiFdgEQVWYFnljTzytpLPn10zzlNf83
 TtYUE3hKqwyvIgxEp02jUO1j5VmFqJbkxkPEAsa8m/cgegwciwNqTZuRu
 fcCffd2l8XkrYoBXSWv4FNlK0y56SUUCe3bQ29aBu70jCicEOjCmSRde4
 1ir7a0YntnkopsDZrtOAvxUDN2CfrinNMAWSGQKHE2qgcr3ByLQ8qM+mz
 KfHCFMmufEgO1TY/wfqkJqQ0XMElOKuVkUXFiVZrhMTdUgJBnU1xt1qai A==;
X-CSE-ConnectionGUID: +kCcRbsiRLKg9sEriE4tjA==
X-CSE-MsgGUID: Umpj5tpDQr+CCNf034Ek2g==
IronPort-SDR: 6a6f6ab8_pZ8arsuScpPT9lXsu0xgbM9/I4LaoYyeRk+UVumLZ7rJz71
 3+GDgh5E0iXEOmel7JC7HVdWyXfIoY5V74/TbNw==
X-IronPort-AV: E=Sophos;i="6.25,200,1779141600"; d="scan'208";a="48538356"
X-MGA-submission: =?us-ascii?q?MDGc+nMrU8034EOyQvJhbBywivqi5h8M97NrKs?=
 =?us-ascii?q?7ZT6M6QqBgd4azp7Bbm2pi5uwDJvIgemFcSvHwEkVDVHdlEy8XOUBCJ0?=
 =?us-ascii?q?4PqGdbb82i7LLA3f0H7lTnKpyjPZuMHv/jZ0bIpFlX/yPpbYQ/0RE7Bq?=
 =?us-ascii?q?zPCU8Di1eaX8/WwjfqjBT3dg=3D=3D?=
Received: from mail-francesouthazon11011005.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.5])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 02 Aug 2026 18:05:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0/0TEiKcTG43U6CHNQsaPZPMhNbZu/UEwWT5gDicsqq5u03UtYHSRyH6dliNh1BzTG0IWFDxnZqLuG1JIgTQbj/jXbHJDATdjFhBkXCpAscsC3EG6HODOdOznqSPvy9swBXiRAocdo+WUZNDrNLEtFQydbMioXgDNGS9O0UsIxoZo/avJ35DIuWOp+KqObmauZf4zWxIlaW7SgeM8Lz3iI4MPSkibiIwuf7UdJx1CSAKMJj0qoUAeG7WDH2OrXTSwcjm7ots/L+wnLRA8XWNBSC7uIOWTgsQy8cYfsCz6q601xmYxBq4N3Pa0hmRPLe+jHl+3cFyZXH9vJ0CJstrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GTU8YGrFMieKaMa347FGNNnawB6WOXlU3VXvvIhiLM=;
 b=uQk/9e9YSlQG4C1qEYSNuQfd656A+dq5Gn0+HUcIrfyNSH6oMETwSbe6AD7S1/HrCocy/ckMKKypxgb7EfJ7x4AERWa0qcAJzzfIoCPlM10CnapKxuBhNJT5kcUe/HClfhxjRazMpJv8IciKaVIxasT7aUhBqHV/wxMdw/+U2I0ZHljiJBbTrUn76SISle4Byt6RxBX5B55Xj9Vh+cDFG/AcjgrpFjPV8BJysYlKWHJQPx3WSBNqQtg+adB13Tv39MkXeMrTf4mSyZtYVEJky6WnTzDDOtnm9fsZl+AQbidp5tA3p57GUQnUwconrAvyFGID2qe+pwZZdRoxqdxFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6885.eurprd07.prod.outlook.com (2603:10a6:10:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.13; Sun, 2 Aug
 2026 16:05:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0292.012; Sun, 2 Aug 2026
 16:05:08 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Yw==
Date: Sun, 2 Aug 2026 16:05:08 +0000
Message-ID: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6885:EE_
x-ms-office365-filtering-correlation-id: 2d20fd77-96a7-4063-5caa-08def0afd2fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: C+4y0jX/b9WEl8TrU40S8DlYFDyznGa805JJRD0LoDRDwo9dKyQFWJpNceQOgU+AR9c2MdRTWPU9B9oXsEj64Xlwor4eTwdvXD8qGBxdAnth2A4WZAYgSEZL1o91KqqRzvzaCJmknogUIuY764gNQp9IJU1cijCpU2OQ2tnSjT75BMaKjbG0lYdr4fKILcyGXLAVdWUxdWvetYQFYqobbe3IDoIFQ+0WJslurqJN6yW+BwxsH4EE2siQIix1RFyJRMNYzxW6xifawo3u5VgWY2zs8qBIAZSmhXq0H6g1kCd8C49UW5nLQAEqQDRaj4beXp4j2r9AZIiqRMqCoIiiHw4tslW7xzpnGypd2nJOl1s0QcBlIBR+ka+DXLZZJOyhat1nDoSrdYq0Kxm0qoQh79jUIvCtEs8wKu4i/pfM28yEmGfrRNc/jkd+FQe6ifsUBhdSXp2SAlBXHWgEo6ilqm6TV4Fowws5mnPgeFTXhN2F9jXf8DF9ReYcQ0O6cdw2aOmUI1sUZgxvCyESQ1arKN6g79hfoPGnPM9N2XP2WEq0bsXe/+S5AtbP8FeLutPJ6oDoyoy4h7EAOTObh1AZL+s8QLNAX9W7SBofViFyjzmPM6NC0boIsIpVChFUzDl8dhPh3x8zGUvi9y9G3EYaN/uagzTAyFf4c5aSR5YNXw64nSCIPOBoCDNh2LrI+QOz1pugAoHO56VHU8nkcbo9fwjVHV3mPCUo+nXIQPuNYMI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xPXYbS4vw7e1wmpE6woj65dOOGMl0589FHcJpFMP/k2birAksrgmeJEQCV?=
 =?iso-8859-1?Q?DvE2VBevsWJdohL8UCBO/Rjghobp6FLdn27yAhP+lVH1WTFuD3YMUBX1Xy?=
 =?iso-8859-1?Q?OKLSyCRa3j8KEiViZFVii16fgA/WeOCsbvyMQwD3ELFMbjLCwJxKYpKS2Y?=
 =?iso-8859-1?Q?MVg0FH0wrok5bcLu6ZgfodQ1E9wQ7cPl1xaATMSD71OfNfM3xPs12wHCGB?=
 =?iso-8859-1?Q?grxE/3cuXJjy8hnmAinrBeLfD59F3+XFM528OsfYwTrvIhxdCyGU9bag5s?=
 =?iso-8859-1?Q?RVDyI4WKaRudUVpwrgEHcEPR1h0NtYMxVKSDbrLG3yws+Nq+eOZesKWOqe?=
 =?iso-8859-1?Q?I7ytzjQ1WjuwGWRJ2HoTYPt3OT3dSzOrY8cKF/3wyv0FbNMq8UN/Qef6hr?=
 =?iso-8859-1?Q?UIXD1NEhidvBliIy5kfLMZHGvV8KSxeMLSjyJyLySuEtQCcdTHwHPi+eRn?=
 =?iso-8859-1?Q?+/KEMYarTsyMCq8aWfKBuy+3BFHULyBHYoyG5Ehwz2LQHfsSyjbmfGIVFz?=
 =?iso-8859-1?Q?dEH/ZxMU3A96KcA8tgMHaIHxh8dKV95DuEZClHJvWbI2W5kLwHKzWekFbD?=
 =?iso-8859-1?Q?wDOKJYCZoZjDgGsy/jkcnLHJ4IqmO4IsQM6x5+Y1y6M+tfgjvZkRamC2KB?=
 =?iso-8859-1?Q?WbCAmGrUODxe+DemtbBWWgSgCEEZ/31w0ztiRz/Xe0aOG+rH9F0Hk/qbUg?=
 =?iso-8859-1?Q?BPb0ov58UI8eoBtUu06MZEXvY8Rk3dUypPAzbkVezw6GW/y4Cgbx9RCTsH?=
 =?iso-8859-1?Q?01QPsGcNMfGwCU+mOzMrHxwgv9qslFLBR4CToBkW80gR6JHetRNArR7XjA?=
 =?iso-8859-1?Q?JvX1n9fNjsPcJebeErqOWoo3uJ/f1jR1ne4QFixdtniGOuhNCLt4CSS0J1?=
 =?iso-8859-1?Q?5eCrmVbGbRna3m9AH6Wuh/EAiSbOJYrWOpM6RFVDwMpvrPGkXKzjMqjyF/?=
 =?iso-8859-1?Q?5YmJf/FhpFne71dFWPoak/T40Ge396X9/TdWe0WVhGIo5BsjglI3KBjjAK?=
 =?iso-8859-1?Q?unSY7Se8Wwf6Xhs46+0Cv4clq0LiUOtYbvCKscHYhYp+D1+hOISmP80D+6?=
 =?iso-8859-1?Q?tVIFD8wTBSIji8EX5SVBmtY+W/FKkEJ7PioHHnWr8GhnR45i4Pr6kkLemu?=
 =?iso-8859-1?Q?qP8hMIvf5jyG7uNfBkD665Zzaz+vrIuhsCAvvaopFUG+0TfnftZcZCbHVa?=
 =?iso-8859-1?Q?chGzxlGTSTD95CPzro8sq4tvtmjupHWbefmDJB93uEAPn16o0o744VsIyJ?=
 =?iso-8859-1?Q?TZRO8LFkGX5aubSOJ3MXji+eaFWgGGkWQIG77G11FYlYtlEjbyrTEOHrzq?=
 =?iso-8859-1?Q?1URzLksMOHO3m+HQxR+1lx1oCMsix8sEgzrkIdI/IH8wsYBauXWrZT4tjc?=
 =?iso-8859-1?Q?8IgQJlDVHjMaQAmXww4HI+8joMT5qm0SOly5VQFsykVsyEREmany2k5ame?=
 =?iso-8859-1?Q?HXRbZaj3bHoEG6tqm2nYTzUozG0PLDkA4/au1Zklrd9OWavrNtEujQkbIa?=
 =?iso-8859-1?Q?r8O0CYjSyNF9ynxxMkq6ABAYFgdXwBbS2lE8NI9OuEfXqkg+IIe6e9/Jb8?=
 =?iso-8859-1?Q?Rcax2IIUuOaf/wIVxpAVqWgzBovahSRtqsO/IP+RlyLPr81ic41fkw39hA?=
 =?iso-8859-1?Q?V2/0x/AVkkS0X/D9L1R+2fnzOb+Vc7gqjS58fMohkDfXXNAU5uOs3eTpxh?=
 =?iso-8859-1?Q?pZ3sf0xe808WbVDE59UYqo/8gamMiRq93R7Zb48M1PU7+CXQ+SOAjmXqIy?=
 =?iso-8859-1?Q?v0JkqqO8W3RYVMF6AGfu901md7tVgjzU8cWykSQ96YckvpKxGj+EGFNREp?=
 =?iso-8859-1?Q?khq6BeCP1lr8WEgWRTJPYitw2SheF4fZIhI8BfO1kkSFNwwZC9ds?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kli6s6BQ73KAUYNaJZ0BurFjXTwALIHDLZnxrVdvulb7aRS7eZbgwP3ynv/FUS2r2GZwJDqnvx753ipVONnbJmXzWsZO7s6z0UYHNpyDueEFB5KYXk39fPwQd7hUB4dkbuHhu6lLBRWpvShcbgnEDoHo4WPFVIrc8kGqoBPEmrLE5XQdiVc3ELfrxqnITk4JsoRumd0F4erXwriAZsErgpq7wB62voiqk2XTSYvLquOT3XZOX/VFgm9L882fEguH29m/s/CvgFKgr8UrO8xvHM0vCk3StuiyBVBsMUMrO/GM25kIos2ISWEA0LB8+udEwNM2KvQRdwvVOGFrcGCxlA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d20fd77-96a7-4063-5caa-08def0afd2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 16:05:08.2667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBR8G4u7KOGrEwcHXg0I00d3h3foPozkYjbhfUtQ0yTIS0nYyv13HORbYfWw6NCPEmQ3EvKfvskQqSM4pd6j57qyuJURKEwnLn+KVdcJuzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6885
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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

SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
current implementation as it is already in line with the expected
behaviour.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c          | 3 ++-
 hw/i386/intel_iommu_internal.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

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

