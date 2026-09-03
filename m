Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C03C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x292n-0002bD-1y; Thu, 03 Sep 2026 11:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292l-0002ap-Q5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:07:59 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292j-0005t7-Fe
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1788448077; x=1819984077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VrPFW1OBcqu03VNpdsg1e+ft10UfU/1Mz1vhvADF5to=;
 b=K/uBid5TrOngrCvdqCIxNepWxL0RoK53GUwn8zB3uTTWDsE36V/iPFtQ
 pVvDRc7dzvOFWgWzhNqfcFEgwy0VpI85mucqw7Bf45zHUTsoxU/diOl50
 W7lIkdRRIjKJprEP++DxCNd1r8mHkfXyaAaa71CwbUaMmBz1DKZsPAVas
 1B34VgGseRSxeZVl5iybSWSL6uPnuDOqx+9fzaOX+YDyaKtu8NcwCV9Nn
 2VrzdgpFX7Ci8ZXXWS6vJZFLfMmLs422B1Sk92kWoG5nm+QajCdNnD4+d
 68xEW2UraK6xeogVs+nRv3IBRBOBYfh0ldvvwKiYa1fDbxGDOS8cr5EW2 g==;
X-CSE-ConnectionGUID: D6e1xNrKTMqeEPIW2OPWLw==
X-CSE-MsgGUID: QC5/oVLpSDaCHs7/GVasgQ==
IronPort-SDR: 6a998d49_9/tIviVAt+uRfiQxCdTJPtZp+CH5mRmOMRTD/SbN8NS+xDo
 RsK9M39CpvtKEWhW0dOHk0yxMT4KOeHHefVu3yw==
X-IronPort-AV: E=Sophos;i="6.25,260,1779141600"; d="scan'208";a="48705325"
X-MGA-submission: =?us-ascii?q?MDFsB8S9uoHx71xytiUSMPtw70kR5Bml7hDF2q?=
 =?us-ascii?q?i8O9AtyisHKz/u8mLlKmjOcWRKdbrhwPeKtghywRfiUF4IqmEawxRz05?=
 =?us-ascii?q?jPvkoykM9Udw/G81pQyM/x0RxrCH9TTqDRSqZu5nt0WEbaMOpOLiBc18?=
 =?us-ascii?q?xpLJuT3DFnmEriFVg4F8+qxw=3D=3D?=
Received: from mail-francesouthazon11011029.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.29])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Sep 2026 17:07:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiyRjOZYdZLEq4X9rs8sBXPbTUCAr2TkyRsPWmCbA5K41q6gUGiyW3WYUEusPRnUNG1PGWC+lDAxW9iF8x26TOwrlaBeKLW+eItZHiY90KMtaIwkZKG1OnnUV01fjz9faUALZS4peRPV8gTj+sXCdfGk9W3Qfdbmg4R+hi9RRV10lrR+OjrGy00Tk3apqXhaarWeYH3+E6T5QhYe2CzN6ULwnwBwF1IaYqk70UcQ+qRFrlA4G64zZZv+wTvo17U2R+GKQP/FZvtDpC3CiCs+h9lyVlk985QmxyENVcw8z/C5h/qNV1/U9gvdABmev1qTHUUbo/6jxdpYsWQGfJYgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9k1WZcS03zjpXPxuUeQ58Td4369S2sq3r51BdriWaM=;
 b=ahd0I4n15x+ogBfwG80MGsCC92piz8dcTOC7LNbUjY1HpSG+rkiDworcuTchv+Xo+a96bqerAz0WZfqzTUIw5B8SL3B2igA5u89ZWZGBzN3ittNRUboMfWmGu9xMRgrR7QJHLBY0HGKPu82R5brit02Rxqn8dLfI/QRZAE3cFygHAEB/ojlyaVSFaCCyS7mh/SrLKMiLutm1hVN2C7vSv+SPq/jV/JBwtB6GOx5YeS91qe51q06RNksG+vGW+Z63ot1IxOxWiTtb4usLtQ1VXS5ddF+OI6qaUcpUBR9TsFbdeW+rCggY7zXz8dIQbquTbmB4FSRS91EcBtQ+kf5GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR0701MB7038.eurprd07.prod.outlook.com (2603:10a6:800:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:07:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:07:49 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH RESEND 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Topic: [PATCH RESEND 1/2] intel_iommu: Only set dirty bit when PTE
 exposes write permission
Thread-Index: AQHdO7X8+tWsyajzrEKp2mK79Wo3QQ==
Date: Thu, 3 Sep 2026 15:07:49 +0000
Message-ID: <20260903150649.2281104-2-clement.mathieu--drif@bull.com>
References: <20260903150649.2281104-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260903150649.2281104-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR0701MB7038:EE_
x-ms-office365-filtering-correlation-id: 3e57fb7a-7159-4583-08ba-08df09cd1e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: JCr9NsH6X49V5c0L/Jewi9MiiIlWwTdeHSuWWsVU4HPOxc0HWeXYR6IPiuaRyGXsyw1FvctLChcBfljsxbj4GMGTgQDKe0E1Tbl6oCVNUOB62xjFqfgZGUVL66qnr/AD61GZZK8K60XI5GYWrHDUWF2ApwlNa7yLfDMmRpWXriuyLOt3a1MvpwI8Pv3+aDdAw7VMB/Uhku9ecxbtSdQ+tRNEIFDaHQPyS7+6HRXoULGecBOl5nxNWNjEZBisFfjRlipt0kzdObb/Uh258cC5/8lO93Sao8bILf0ocHpCF9gTWWJF/6ukjA9/KQ/bhWB9lqUn94js9vxaitq8GyDlyAA0Ttq2kN1jLvnM7LLa9wJ2H7q2/JD6eT+UZq5Oo38E+dU8t3OxWM6Q20Xa477klmGSc8EGTwtGWd95/1ihmSdwGVRVQSdsd04NcU8JTKbwvp793TrOYkzhcBUtIUTtNt+dvu2IQ8l9m5R7HIML/BnLMfIafOi/CluTX/UckSLAIhzmxwsRS8zLlqn/Xibu/H4odlgo8TE65uosgK0AlXPtd9+Bf6eMfAH2R8VVzabKMxmK9N2Te+7P2C9gIdwjD1T8bkwrDfKGTBhtV6L2rJWiii9RCfyQeNBk2V6AmZ5gMD9dJGh3WPPiuyj7XvlZRUL2S//rHsy7aeypzmeP5X6rlasFaZVPIW1Sc2UznnnfR1yz20txr+ZdgeGYVXGlhOieb1Jh1q0/IFqy3FHm/yw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/6GdMqS2/zAghrllF7FEk8zJlqO4LOAFPNpS5dZP4CrSsJvA/w19/on2Ur?=
 =?iso-8859-1?Q?XROj85LyWL3QakChcCch0IYmDXYDIbuhjX0ePxC/AXxj9PyqvoqnsH+F4E?=
 =?iso-8859-1?Q?Nqicyo25stzg7PLhP/R1bUVR9l4kyJGJ0djusbEOHqneWBi0vrxXXazfKu?=
 =?iso-8859-1?Q?vT5O0Ky1Opt+aGpPbXUBXfETbkx4RFVDRB+HEagN8SmRNe4R23N/NYqlMD?=
 =?iso-8859-1?Q?NDWwtx1X8h3RSXz+MWzBn8SPYNynCgB+ekZgod1orIaM+PpSaO/KHbHEQB?=
 =?iso-8859-1?Q?njV+Zje7C35WE4CuONlA9YRgvJlPsLnvksd0ECq3BduFltsncY5JnP68lv?=
 =?iso-8859-1?Q?XBF7o+FhbI0ir9l3nyjD4isQKhNN+5K7W8iuNyX+3vnm32WDzh8+/pvk27?=
 =?iso-8859-1?Q?ksyFJtcscD//DkHgXuhFV7k9aM4odRLg9O379oxcbzs+PqAdYEnzlVtJlQ?=
 =?iso-8859-1?Q?DDAhG2kiq0E6atvL6Mc2MbLm6kXTt26yfzWMFcl4AfcJjBLHPfFQVKT3fS?=
 =?iso-8859-1?Q?Lrhl6JKdWzgUyuNgqBb4R3GGpF41rxFN1b0SA7Gqnzi69BAm6Ix3aaomqA?=
 =?iso-8859-1?Q?umv+unviDqKHnIGYOSzQix3EOEU6/3u6VyNA/Ke09NRbjFRChuBKU6GAoT?=
 =?iso-8859-1?Q?QNqQIKERHDFev+DOpy+bLH5KtdyVVuGtEZGQ0ys6+kwBuDlnHQlQGicaPR?=
 =?iso-8859-1?Q?74fV7mfNk1u099HLiWd/st7VXREq3yy1h4BQAi3Wg7q4IypgLtQN5oTjN5?=
 =?iso-8859-1?Q?aDPglj+IildhG/PABXARZ1V7NcrOiJ/LyEPfSHaMN8u1Ioi9mDCYVfWbRY?=
 =?iso-8859-1?Q?4vVBWcvMTaPZ2SG9XDLZVWh/ZAS1+1erfa3QExpJkc0kLFHa+aG9NmXQfh?=
 =?iso-8859-1?Q?rlPXNLfusqvZ+wqyaqrFSzZBNSnzApyYY0yDZBtz2qFsC7e1qNGLReynU2?=
 =?iso-8859-1?Q?D/zh6qcDQpeksm6NZfkXanzlrIhjUJZ9ukacRz7IwAaeDhJ14852sWRYmZ?=
 =?iso-8859-1?Q?uDrgSEaFCwqRbZFbycuJ6zmN+MQ5c7Ws2uk088bxWDKwzcalSou1MjtMzN?=
 =?iso-8859-1?Q?Vh2RBP6DXm2kjVbBnEeIko9sXms+ySPXADPZboeIOwakSWPXqgWGW8MPBI?=
 =?iso-8859-1?Q?cA00pxgXqieReb3fEXrPl2nJel28e9HaxGUBAhsjEytcZX7UiyFjaMO3ma?=
 =?iso-8859-1?Q?aKD8c1FnUYBb2RTstIBctbpUjVwNSGGk5a1uISL+VnK5evRRcASSPnrZTE?=
 =?iso-8859-1?Q?Ck4P9AWCnlqHqT09GcQfmcmHQUYVKD3s9bxVSM67AMsGEMvZ568ZrY+cnw?=
 =?iso-8859-1?Q?uX7pcyLc1prE3ZRolHzepfDNPwEODvTs3im2ZghvFWGAxbowskTB0Zned2?=
 =?iso-8859-1?Q?BJH9NLkJbX6gjhIKKDjuVNIBcRKIytDGzyZKfZgTlNdAiA/7+tM0haQ5ZH?=
 =?iso-8859-1?Q?kHYoO+IkE+UC/5Hk1c8InBcQNfh5WgpPasrAt+bGFtcAXIt+Ik8ISNvFHq?=
 =?iso-8859-1?Q?pjuxVfuTzaD5XmXCAg8OSbTu9Dgv50aW9/TerXavRQNDK/V7JIpdQYBoQP?=
 =?iso-8859-1?Q?5FzoMIlwROBOQxEhT0TrzrxznX44n/neJhzduz5lKApIb61o2tHNdVZBhr?=
 =?iso-8859-1?Q?781DG4wsiLIK36tpJEFHewQ6/8uVYG3HvX4MQCYm1sw2Bwn9sWf0j3tgO8?=
 =?iso-8859-1?Q?FZD3YqWQcrTcjC5KSMTScjSaTxdm1sp4tZwvypl5Vb4i74WBeKSftI+N0W?=
 =?iso-8859-1?Q?3PsHGnTMq1GewDIMlWgleSONZkQJkfFClh9ndCNVZhJSxdYd7cxhT5gh0p?=
 =?iso-8859-1?Q?BX6VS9lx9tuxwHJ6HrrMXw4jBYA8ThKADyV8HqNWPwrcqYIoAyQN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NZqOcF/93sFskjR1KRsbn+H7kxwHn7MXTrLg7YB+tW8+E2cju71pE99j0BTKc7ZCd7m4gunRPpZpo8o3W0eKAHFfh2gCvbnzgakZtGUjEQX9V2TJyeaUfIvnxC00W7ZGqk4KpiPCPw7SrrWIqoaJtupBzG0QzxBozHPaR6AEdiHGlL5RV4WInq5fUxg3VA7d82aMGWntXdBXHwC8IwKZbcRfrrsSuTGda55YcJvu2sR/jtytIvoylKxHWtY3hyRElqkhVVbS/K23yv3lVpfX9fGU05ffFA5e8RUO1IMwuPhBBOoYqtkTIQxVqqoPlvvWmWRpKfjNVDoacTi1AYp9OA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e57fb7a-7159-4583-08ba-08df09cd1e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:07:49.5948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRWeaX+OoJVe7qILWpgyyKHgUfdOrKe1xuXDj2WGDUmzywb3r9R2UJndgvZ9b4f2EIC06TffKdFv2DeHGBK2X9UjUNMKtI9KCJWhkZ8/+XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7038
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

Setting the dirty bit without the write bit in vIOMMU creates a spoofed
shadow stack PTE that misleads the guest OS. This results in infinite
PRI requests from the device, as no actual write permission is ever
granted - the guest OS treats the PTE as a legitimate shadow stack entry
and considers the permissions already correct.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 921a258b52..114b1d7cac 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2039,7 +2039,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
=20
-        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
+        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
             flag_ad |=3D VTD_FS_D;
         }
=20
--=20
2.54.0

