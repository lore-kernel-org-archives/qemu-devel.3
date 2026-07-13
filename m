Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7KX-0000BD-7e; Sun, 12 Jul 2026 23:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KM-00009I-Pr; Sun, 12 Jul 2026 23:27:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KL-0006VO-Dk; Sun, 12 Jul 2026 23:27:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFEoS20FSbwNlbXLHOcD1TP1BnB3SYG0CQLrnjamQmTj/m3ahLZ6ehRhKEou+G1LooaENmoJ74ojd5YRScnhJuAqv9MGF9uMLPWJxtrAw10pU+If7y2UKZ8aOw5O7i2P2Xkj5+qafwP5k/Kj5+PtMCNUqdvkN+drCOpLZlJRQK07kUUd7RDVvwJBod5ZO+TVNpRAtQEtyLkh7QRAyIf2PiHlO37SQPYDGatGpvEl3oq60qFqkB0szat+pudVjrCTDoxfdslHBzaFFDMhGvmVotYW3dNRUut2dUtUkLQCXeoNIbGoPhSAMWwJSwOxaU3x576WkgLxaA0/b+BjyinndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjffjqeoczuI6jQuz0ExTiQ6AGOTaSnweOVtsaBU3lw=;
 b=tX9H2pih0M6gGKXALZ5dMRft0uVgejNmTXsvk0KWioGIxUNYB8LFOLXQ/scPEjhK03RrIzM9VjtkMBF3E34qDiqOQ0FhWknD3piCVP0QUStN/BydNV/75NRlfe/XPMV77PMYL52IHJn4nB89nywVGXSjrLJsMS+Tqmw0YiQXEi9w42hl71NFFzeMCt7ru0/nPGDlLYhodYFcJFqvOBg36p2+DH/kRWUUal5WQDMs8ypsz0wuUthBWE961cwFU8ceQlksb/c6wTxMvssUF+1EpC1BjkfAOvj/pQYPbeLzqU6h5CRmpIBg26uxSYVWv1+vNqHHOKK/h/Uh+2ypaOSgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjffjqeoczuI6jQuz0ExTiQ6AGOTaSnweOVtsaBU3lw=;
 b=Y19CkEFC90/HFIFCwu/vqaf2PzON/N0G2WQ/y2aC/nhlG3I5lN2mcHyFmRrSmBrHoAdouijSokT3B1N0lZeBA4FlixJL9DmjRsrIkcZj+Y7KKHfqXcbSwCxTeU2SBE4vbmhlXV/9XqYpq9bnkMXrDNS0NYIzqBpN0+Dx//md9WwtSaXB64nPGvsDbGV8tgfRKaCYT1u1wO41GHhGdk/eJk8mrsLaJblViGuWjKgb/dTJSJigoDn1D+OlmX9I9SsEo4f31Btv8JJWyPWgSZ7sIxtJ2koGGq0pog7U0fNLP4VPTZso/8t8A5wWX+yoVXOZ5F2+RNmVoAmHfUeBZWn/bQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:15 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 06/10] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v7 06/10] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHdEnd/3jocfLF5jEeNIQuRY3ATZA==
Date: Mon, 13 Jul 2026 03:27:14 +0000
Message-ID: <20260713032704.3583103-7-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: c3c4db9f-0207-4f51-ffa2-08dee08ea285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: xpD1Fh8sO3bERnuEafQcsMCv59jZjF9cv/vHi4XpMVHDFSPq1EZN68djRKKRH3rxk4/hcs48S1xpEF793pEsws/FNTGbipr29QmUAagyxw95xwwntLkGc+8kdAFY3uzexQcnuE9v25x72MkxdMMQHyF0DOKljEHIrLwjF8h2KICT6tTG/cceUSZPLN+J0ZD8Y7KG9Xhcp+nWi/fgpGvtlV9EYmTRRhLvo4X9gG9h3v29y4Cbt9LoPtxm6TO2JmG0HYxhsB48+z5gz179gN+vEs2iPDRLIboEHwxpigrtwJuQRNu9ZBWoOqvUXHEluqcYXIsoDD1IX/i+k2c6XM2Prb4FQt2vTldN9gtjnoCCxTJqazjNPF4zZGvyQHFf9qKKKsxezgiY/tFfh5UTKcy0y6PJjyBHuPhztrlVW92Zx4Ur/LbUh8MXj59cWBow1o4HaUzMmPsnOH/X/VgbYUYvCFQ0docB8n0v+fRr3mbGHYfqRTFEJwPPtPgfi8uydbX/Us1TMg5YByrgH8o8iMtRofcChkTvWI8zT2QmRC2yQEdpe/EyUJtRJZXd8m6jyebnGHCMsnlrCSY2R2r8Z8BHv9mNG5Rvn0S7AL3P4+pgba4XccjRTToP3aDmnRjvcVeDmDeKXsGK0ndMBGcpB78LyP2dZQFdrIFztJJ702CbgEtKYT4w8a81rMWbd6RZRX7CU1EIMS/yUpr37WFQotZwVgtdLBHhE96Dq+q6oefrQePO1+VcjKbPjBsJPur+JQWC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jyiP8kEMqCZqrSc0Gin8JCUGoVJ0MvlVWYYjVcEy5KPfobU2B5uhMgD5gW?=
 =?iso-8859-1?Q?6YfEhPy7CpJEhxpd0UMGfhGGSwUB3UOYTY7mfGtC4yYaVf8X2pP/O+Xgao?=
 =?iso-8859-1?Q?Fr4jgc2M3rk49LEwxLglUy7fbOeFo/qOPP8bycu/Ezkf5U4yQ+9kP3hrho?=
 =?iso-8859-1?Q?SwrxbECvK6tMHPpzb30wrQhGMoWqY8msDFBDuJS6Yu1AK7Qn+9lOKS4DVR?=
 =?iso-8859-1?Q?0nut3KkgGPc0/cN9kH+ffq5z8MQKcHGFLVQbXmgQKgxx8tToNIRTmWdju1?=
 =?iso-8859-1?Q?WCLXZcYoLX3kVdg3gDg4Y78GgvWMR/84ORngGL/1/gTtTL5AH5sX1OuO5Q?=
 =?iso-8859-1?Q?BKermSj3fs16sgNeLE9l5lwwtx/BDftYF2Lji1/9v91VvrlCQCbaQW6okg?=
 =?iso-8859-1?Q?husL9DWnVmgC6rZ5ZIscAa/S4CFpJndrwbZD8rvMwTHlFAOK/0p/gG60x9?=
 =?iso-8859-1?Q?jPuVdJK1svrjATI5Tk7GjifV3ZPGY6ESQ6O4l4viuyywzXis37+oqT/wWU?=
 =?iso-8859-1?Q?KUYuLBoJcGOEjCoNGDibinIbEzJ3bl/PRwQo8DJHCkGIjOBvRWeL5hT+mY?=
 =?iso-8859-1?Q?gZEqR19l+qC6kkNNehgEksz8anLaWlTbImPBGSuJxb0pYE+XhulJPy7fDJ?=
 =?iso-8859-1?Q?ZLBXrnUY8qAy41PpwwPFlH3tgyGHUJm9a3KJscJRkZR2nY4d3tXGJJVEVD?=
 =?iso-8859-1?Q?mmmDiGknNGn5WNIFO3sjevyLukbLJ7Bxr4LwgCpK+TicTLQa1LsN1tFLq2?=
 =?iso-8859-1?Q?Gbj8C1l9B37gi6oDpuN2utS8Fxi2FAX/g7Ng64pm3Dw/qdl4y6OADnnIxx?=
 =?iso-8859-1?Q?Nzehq0FOvW1rJ0JuJtY2R9aae1diAwQu9Ii3Vl1mOcfhSyvkTn2dFqZ5U3?=
 =?iso-8859-1?Q?drWr8gXbFKSig0BZBkt8/3XbUu7SeIzrCqaWGSh9WWEKR3aOJdFOLoI6cr?=
 =?iso-8859-1?Q?KAqJBK4XBWgzLHy2o/LUnaC+/a1QUcJyioef1y9J04qMid4p2ez7iZwkV+?=
 =?iso-8859-1?Q?wGlYPh7JC69A0Va6ObIOIk5Nl3y7PGieqVnjwKCOty0wZOeL9mQNI+KoCg?=
 =?iso-8859-1?Q?basXU214qKzltj5gpa7cptht5J3kgDsTh1dtXqMXtW9HvlmWxlDR2LZOud?=
 =?iso-8859-1?Q?QC4nJLliYGkNHGDNQ6BpsRWoohG/QNGBu4uvj44TgL3J8mjfWWkIenwQM2?=
 =?iso-8859-1?Q?LmMfKBpoLAALP/7xe7PRJubL31q3AWt9DerswTGWB0dCTWtiaVzsyrb+kf?=
 =?iso-8859-1?Q?Cs2AUVMFyUU3XTUhGlmMqWWhE0zIewo9VOWAhGeJQvYvRE652W9HIYXhas?=
 =?iso-8859-1?Q?QfW9B2IGB53pBsEcz+2JnRCe5DbcB33AxJScGqXGj3cfUuMHKrf960qNpG?=
 =?iso-8859-1?Q?Ec9kBnuj6lP7BGyOfBjJjbbpn+ydURZhnXt2OY8c42MqdmoWYHVcG+J3k+?=
 =?iso-8859-1?Q?8f5lSds2YjXfBXw+tG7ut+40ZSqr3vV1QmriihmxYfqzHzmreydZvEIuV0?=
 =?iso-8859-1?Q?IUaRMt+4V6F1BxFIpQwaoQGlGgXyVR0SvULRNInU5X1yVnvAAO20kaq160?=
 =?iso-8859-1?Q?zwXIG5yDfnBA1qqaV5ymAqm9PUwnDyHEj5yKryS1LjU0ClsajDx1F8oviz?=
 =?iso-8859-1?Q?m9duoRspLOTxoCRJkC39sL0XFmJdvijMmh17MIsCsQU3hxY4yfF2WtgXit?=
 =?iso-8859-1?Q?AeOjaVMt4BynlywIpU9n57Txrp9JaeDQULYoIaijaIWCFxqqi9dpMz6TpT?=
 =?iso-8859-1?Q?RADsk99glGgkr5U9EKkKUJlrB7+5BUYbNu7cZrq20JQumsVzFyCRRBU3kD?=
 =?iso-8859-1?Q?xVrUFRDNeA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IWwevABhbYjZo/hbfcKw7QBXNk2EUXi7qzFNpsLwQnyLWthp8DV4ieqHBAA8tu/BmJ7P8CO/GkDmAlOO0exRG/5+QjkmC4IcJFaHBuodyrjMxXiYpnTu2DoqJT/qA5R8UwkF7LqpZRHLQyocDBqZh1onALvLIF9EwYQQMYAxFPhZAlEkh5YJa/Yg988/V2jIvYEmFROV3g9PtywhGf5Z0qIqR4NhFNz2Xs2IonlaniGlwUlNBYMatD4Lxuw23vO1zBr6RVG5Onrvj12Vp73crrvZ3NXRYRlClpq7rsAX4UeVemGdTyrLMzfOIJqf0RVvqzgx2jbyTG2n5MtzzyddLQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c4db9f-0207-4f51-ffa2-08dee08ea285
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:14.9291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zx5uLX4x9MG+Dlrl6pzGT+ma6wixQ6ewscKEZqxZ7Ra9yRX3VHqCIOOGxagAqifYvtt9+D7LDEMraa/E36In3XB4oOwo0wTwLrRfitZoPk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 1a286c32e6..9a80c74972 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1823,7 +1823,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

