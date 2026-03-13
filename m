Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC6105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13tT-0000s8-Hi; Fri, 13 Mar 2026 10:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13tQ-0000ro-FL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:53:36 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w13tO-00084W-BF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773413614; x=1804949614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hIOqZEgjO49qN2u8r1btxAdyGp1FynHbgk91dYwjvXw=;
 b=iqb+CiqfnP2BIjhWmxW1POPt7CbMVsZhZISWowPwlwFdNyQbYx3UTEVF
 nNdpTjHywV371rf+SrcLxH8eb/VEwDeGY46FBwYVxDlxEK7SHDPXbq6mY
 Ak2cFsABmT9X/1VjbbzkqQXH6WKb6arpu0vaxPEipSKNw36FJeeTgGHNi
 RiqT7HijSAIwUeG3/lav3p/nM+rvtSAN3erIkscpnszPIVZd1C4Xp5ihY
 DLHnB8aT+z8TSnfE4Gox2mRlYGbnRg3ltulpyxQ9WCh8i0Gr2+PSn2ff3
 QxqgeIfB13hJbofDJ1m8nOslajb3pOlgTIo7dgpRUfNRGHXjV/FohBpXH g==;
X-CSE-ConnectionGUID: Kbl89HZZT/aXTHasRsWuBg==
X-CSE-MsgGUID: Fs3q1f0nS9SPHKZl+l5nsQ==
IronPort-SDR: 69b424eb_z3AjXdIU74iIiLoyepQ8nbk9QC3FH9jhbZRmSuvfpziMtQ1
 2jD/ANRJfE+/OqTZAVkcYnvwuthPYQXD38Y8Ikw==
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; d="scan'208";a="49105960"
X-MGA-submission: =?us-ascii?q?MDGJeUFWXdZEsj0JU4OIw6wbV6OIETAu1Kk3Y0?=
 =?us-ascii?q?RFgbgVwzSTgT5sdE2CUNa4TYf6f+UEwB8es0lgNQGOHaFwcwsOCsgZLd?=
 =?us-ascii?q?ZXvEJn15YsVcArRCT6yrkwbnRJ6temyb4vLHspk4KgyGZd5UHdzq2ufN?=
 =?us-ascii?q?pjNQahmDX6ciubiPBuXdEShw=3D=3D?=
Received: from mail-norwayeastazon11013052.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.52])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Mar 2026 15:53:30 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPtr8wdH211emJ7TKyYcmiAYcWcGfp98S6JKY0nC10n7jyqQeyjh7ws4ntcE+YW0cWDqTkS0lit5T90kWdkbRZf6ss6r3cpMLv/0X9aVkShj8NqN4fR5Syb5C1TDuR0rKYHjq81BzC/QL33MKpt6gnIqfZAf1e3xj5D56JdJLMypNh8A25f8gk9mtyXtZ3m4kdGIktmhqS1uZoT9HiSZZa3dIaeLNWqbrvHZUh/4A0Haq6ekCIvUh4qJent/T1rRe377e0adnfHn+dHTe/DFeY0QdikU1SZSKH91Od0NGALqNCUrbQ5dwcbDd7FbPLno0d6H5J96iToEZfi1WxaTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLA7WMyQQ2RprX13+PiRrcbzbo8NjK7QPIcoa03+6Zg=;
 b=K//xmUJO6l+66kFurKwXH+ZQ+fgPORZ1OYng/mmc5/6ktP5JnE+6l1eN3HV4l+jgxpuACg3DyQpk2XR+fBjib6xbsS3KekFDEk+axJED+rqGMJAEdIF12A1Qdrfal4SlWi5sF6aT67Rw5hv+kj6sZRZE7eBchsbClFSi/8yt/1t8hwLExga5AU0zi+TMS4HltDmVcQ/Qads7KqhZUj6OPWcpjiuXF8hdrtk/eV5v08m5sJ0EwkDlEJpz327U70jVvWAk2ZE0mcFkuphwn8Ja07jFu4FELezWGIBHt25pgau+OAyJtbqZCIOll7EebAB8onzpIrfxjFWqSlUStfuT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA6PR07MB11644.eurprd07.prod.outlook.com (2603:10a6:102:51b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 14:53:27 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 14:53:27 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "thuth@redhat.com"
 <thuth@redhat.com>, "pierrick.bouvier@linaro.org"
 <pierrick.bouvier@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@bull.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Topic: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Index: AQHcsvkmhwNH0bvgLE6pyvcWhn2ETw==
Date: Fri, 13 Mar 2026 14:53:27 +0000
Message-ID: <20260313145244.1063405-2-clement.mathieu--drif@bull.com>
References: <20260313145244.1063405-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260313145244.1063405-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA6PR07MB11644:EE_
x-ms-office365-filtering-correlation-id: 525ff75d-dcb4-45ec-2b2b-08de811048e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: EiUBVlMEKIJccyO8iHjRy/FiYLUYTXcqwwuS5xs5CvDZm/gvVGAlkvjtCpdKaF53oy16R/wQVmPbF0cqQ8vmEhm+u6QvGmmSP4vcjFGOr6WWdVgUJOUbJAPYr+zgosNVkJN40zlNtgGv7BcklTyDcG0mCTy9saw0NWhphZD0slui7ieCrs81NA+DTg1JCzcbzu+fyhnZCcid3uJS42qRXCIvEHNcMVteORgi5lP2Usl2VMM4FzkIk+vQcSe1AQea+pDEN6j7JvKhZwVb4GaWdMuuZFtUYNwvhvbeGj05942/Vgi0Gge5w8JTOKMmsYqGiMmEuGLfA1Lpi5Muu4xQ1WXB+1GRnoChVgSkW4Wm4euTP4f+BkreZzBkKBaRWK0xzMM0alXTDVA7o6K+P9K4M6OgFrmpMsUIta/+1eRDB08JRorV3HpZGySc/tO3fi8zIOk5DnRAR/pbbibY7LNSqQ1iTnYCkWNKoB9zP0/f13R33kk07O0rtMSey+vJR1nYdBaHLQlwnwzZUKXmtJz9LkpLmOIOHZ75QJuVvNTB8rpZ6qMEDlgKu6gwtffo5iVdqsB243kiLMqBe3UV4da37cVroFXbT/VIt+K+NGyXjovsya+DKtFxZyq5a6HG1aRGbx6h6q9CwrpFqMs8m0iloBXJUjzBfDEYqgAeH6ftZ4gfbw+c4FDMrLpc+vAbj6ytFEwudCdLcGHOFxUc3PMwjVtIpFgZjD4EBpJFNunIGlD/54iuU639PUlWux7G6/DX/A3RIQ/2IoA3tvkbFVsN/WQvIlOuJkGaXhnXKRm7U24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q5dMPYLQYd4H3EmbLwOEpRH55fptPojbnzZPsUy/SEOy4EetddJXINauFB?=
 =?iso-8859-1?Q?+vX0391o3x2/HiTM2TumczmXEkiTM7uNPcF6oTLcRIgjijfsXC14RwPom/?=
 =?iso-8859-1?Q?kakTzZBXyoHI+SNBbyAXttAwIpPa9bDkDfWg4Ce647zd8Akh4hLRty9D63?=
 =?iso-8859-1?Q?ZMIGK7ZJqiDOGW9fC0GHoZdxfnJTebu2m0L7opCn5IxdqcAOMT8iEo0dlC?=
 =?iso-8859-1?Q?dXnOB++K0PpIjj6lc+pd6VDJmlsL+BFiRQ4+bP5GBIDGF2MyOHk19QYR6+?=
 =?iso-8859-1?Q?N5CiGvpEnQvfSSoKQxIGxAbOBXD6V58IvaMCr00tgOvsQcLxJ7O0nwePWE?=
 =?iso-8859-1?Q?+xgUleLr6rOeaecntNUarkUgfRsRamz/6rm7RnacPHc+ppkNaLIK0oYiGC?=
 =?iso-8859-1?Q?XUZeX0tFxE0/77JO3XMby4ycaseEKq1mKcMkey97zV1qfFcMhzHB/SeviD?=
 =?iso-8859-1?Q?qfkcolxu9eRHgOrq9cg3LYE6CBbbHUFIUvth0W35/v7723/44fsSAzOZDa?=
 =?iso-8859-1?Q?nI/jGL/auMsyqJKR1eQRapuM9EmGsfbohj5HKkUB9UD2Ktr+4wTfcaMSup?=
 =?iso-8859-1?Q?oq+Oo5ZhnABRlj0CrDMJOlqxYzI/uLbj0RBdB4d6+YR3HEfU2zXd/z7i28?=
 =?iso-8859-1?Q?jJxBXp9Si1LuY0+RoekzKq5+0KZJt8hzULkrD0M+GPmsZh3Pl0WUi9+/go?=
 =?iso-8859-1?Q?KFNQnOIbqM7fEsKuXYNejLb2p7XM34jte38KaMmItD4qgMZblWGA0Sc/BK?=
 =?iso-8859-1?Q?Mrrklaw3nYwwYnwIn4Q/69Ai0YGuU6HoGIHe0INYgbt11wq+JlK2uFTKYK?=
 =?iso-8859-1?Q?SeYuN5QrEcUSo2FIw+LD2Tz7jzMf1R2gw7rweibdq2rSEQ+dj8UQy/kCqt?=
 =?iso-8859-1?Q?Rr1QCT7T8HFuOeJ1AEeRynpGHGMj1p+euQzhPb5LBMS7YH4SSMUODem+JM?=
 =?iso-8859-1?Q?W81iYrF+DAAKL9aVAkugOMXxwzE4TT91OIAwloA1CELc+svT46dt0owKIc?=
 =?iso-8859-1?Q?c2Xw2eRWwejtWtjnJm83K6BIhmFS+4pcyALBAPN0jFIGgKn92dxaM1dfXK?=
 =?iso-8859-1?Q?EE9xHnQSFtO4/+u7f4ksed92NiQRN6LY32+5OhtZbokeL7/gN2EJYIqYRY?=
 =?iso-8859-1?Q?iN/dXVbZUKRGuCthGD2fVEogq1RV8w1ZEE25SR6srkAh2Av3aBtU0vkw5/?=
 =?iso-8859-1?Q?Z8B6wQBFMeW9ORsmt5NaMaya8wGIl1kGkxfYUkhHlTUYDGUx3W/4onKD9j?=
 =?iso-8859-1?Q?mPXu23LNDvAFR1K/bLxQObWbW6pOmsDAwk2COqevc3LEZUIs4eei+yi4kM?=
 =?iso-8859-1?Q?32k66BSlpfRBbe93JHweOOk9OIXo2I2x0IK2v0RKptpvP4qU2gdTzA1aBW?=
 =?iso-8859-1?Q?04X+LgewoD0zVxtS/Nz+pEM98ToZ0x9g2PJnnnTeq/yJrJfIiYEOkwxBTe?=
 =?iso-8859-1?Q?m4/MOtZE4cU3k/ZNt6al5aGFlOYs0s0g2Kpx7qSt/e9pBG459dK3eNpjCG?=
 =?iso-8859-1?Q?mebPTM/WsjMJahG70tzGy3x+nYKwiT7OmlVkRu6i19kMIvC5cm6J5EGytY?=
 =?iso-8859-1?Q?4UlSZBTix1UJ/SW+8Vx6obfSaohJn8Ubn8KbPZFM3mVTuOqPOQg338//zx?=
 =?iso-8859-1?Q?xLVrY4FE2gpQQMr5FwUiXxD9FN+kOgaExjnpbc4npV+k76moO0MqZ97QvG?=
 =?iso-8859-1?Q?7j9bNSIi7gZp5KqckDeGBhbYWNlFcPwmDbkU2an53r37WSuf4EGkiFSmV2?=
 =?iso-8859-1?Q?CsBG40hrBWP+UuS3mnwLtrIyNhfZ7SioC34TvBN2RD8M8c8J8bKKDtpM07?=
 =?iso-8859-1?Q?27G6RQp9PEVdJxE/ySXeiGPSclFswGUFnJBWn28bOZmq/96wYdMx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ESL8e2yrcUEAX3R3NrSAVUrPyZHS821WqADKI2epuSwQl64sE3PDkRDdZs6pRW+fy/76CQr+MRbbaK6F68/e2F7v8MiKhuSeWlU9gg/Tn4UwjSFl8N4IawgqDY1EyaK3PNbTwOcmK+XiYVxMQMSTClC+lSJrpqCqnV8pnGDGlNTp8L3e3Ctg//Jb2SHSUF635d9bQr1d/5hQq3174PDQo3pmiZP7TQ58ahgI2uJuawIbg7rN9pySZq14s780W0UnTvnyASBAGqoW7caJDwrYV4tPZ4aI632iGwOc36VIEWu6B3Fq4bA+P06meOG+Q6lPEXuLW/5Q6LWJV9Jkcuep3Q==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ff75d-dcb4-45ec-2b2b-08de811048e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:53:27.5200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLJg0MrXbmC1sqqet2NirxRbZioyHQrpAqEcbcR+wYtT5tpMyy+AFyQbRcFJEn6nDO+sBF/AFDKqGqX46Ot1AELaWPcT2WJnUA0VepJihp2V4YbEe6Dd6LlMJejx2Uy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11644
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This function was initially designed to write a single flag in a pte.
The current implementation expects it to set several flags.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 56146aafc1..441c96125b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1991,13 +1991,13 @@ static bool vtd_iova_fs_check_canonical(IntelIOMMUS=
tate *s, uint64_t iova,
     }
 }
=20
-static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t inde=
x,
-                                       uint64_t pte, uint64_t flag)
+static MemTxResult vtd_set_flags_in_pte(dma_addr_t base_addr, uint32_t ind=
ex,
+                                       uint64_t pte, uint64_t flags)
 {
-    if (pte & flag) {
+    if ((pte & flags) =3D=3D flags) {
         return MEMTX_OK;
     }
-    pte |=3D flag;
+    pte |=3D flags;
     pte =3D cpu_to_le64(pte);
     return dma_memory_write(&address_space_memory,
                             base_addr + index * sizeof(pte),
@@ -2070,7 +2070,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
             flag_ad |=3D VTD_FS_D;
         }
=20
-        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_O=
K) {
+        if (vtd_set_flags_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_=
OK) {
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
--=20
2.53.0

