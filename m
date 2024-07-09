Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD6C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBnc-000708-M9; Tue, 09 Jul 2024 10:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnX-0006ZL-Jx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:27 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnW-0002pg-0B
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535186; x=1752071186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=eWdNAUM88XqvMpsRLDG9atT5/42R87yjT57v3Lh1T010Ksicp2CREGWg
 ZAtWzIG+iFdcSSr6fdYhz67p+pz+xTLq9GP2NMY1sjtCW5oFa3hdfRiJS
 NTmLB7YzTfXGNtX00MDhLZbZsc7tlof3TvgYICjDJfso0zs3b/YE1cA5E
 b1WFxF1PK5KGrIFv6GxFNIY0QCldRC0K1Gg3OKHkZ9cUqEpOj4XiWMOlj
 RXXJvBy2e5A9Yz58acPYwLQOY2zKrUkwrX6ZE7ojyL0JXazTRPVMlF2/G
 vbMK1q4KdgEeizdt7KQIyFSShrNva397Pztjg9wKrgssLFBqSp9msXcTl A==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172664"
X-MGA-submission: =?us-ascii?q?MDG+5ntEpwAgC68QuJnMBPpC3A7wgmGE4UYMjn?=
 =?us-ascii?q?gDd2aBHajF+cxgk7i6RU5VlAJZyxgQUMAScoKkr3l6BRt4CSwrQXdFMg?=
 =?us-ascii?q?p9fTekcghx07uZnADruegqJkU37mPehSJWJ3A3i8lR3R/ZF30PxLJq8b?=
 =?us-ascii?q?wlc4vsM5V37wd6NPiOQL25dQ=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:26:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZSYJf4FQS41HC6VAMZaLcIMXCXe4YnJ0BYwOYNpo4kiEuciLpuhl4a49fyg+EwwxLd5RF6Lj+KhY2UmZLF1hBmAL/W4gKDQPuvbWO/cP9LNEdQyjm2XvOWy5J2ocmp9gLKrA7zJypBqK6KvVlPO5zJrx01qJtduTacYzbsOAUKTDN6ejluAgjUSzYJv7UTPjF8bhyJOtm6xgMme4oU5AC7CEAuFJFen92kaD9RChA5kToaU9sPOvFrPioOETFeWdhUcHmFvCRsRVLGbHFhAbzU9vNM38t7KNzr5sfP++tNKbgFAC4+j3iShysrInlqToaV0BuYTLrhKVcU3R5nz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=Drhw/A2CQVxykPG/XF7Z7D21UfdGP6FvuHZEnmzvMcibU4NLrTasxHkedrbdloZMi0Booec6wfcK0QNhysH9puKrUlfrTCFoMmKfVcSAeOUrJoDyerma4zRvwSCj4U0vQx33XMB64O4RnA0ljvgI3riPuFGf0a/wmQfX5ee839Dy1GTXpXWHlbpEc/+kU76zq9otubW02gQbzMsW++AFW0LrkfXEvbcmT2R34wQQlRYUKKkFcUDJVxAOU5rlibM0owtJfcQ8CfV4VW54k0KxHgXs51LbwBQlc87pKyL5JQG4V9j4Msdf/shoicWQDq/jFY8cCUnsb6QAGYH01pjIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=FMPHHDrF/PG6Ng4hJ78dLsBV0RUEFKGdQBub/FFe89mAQg1c+/sirizPJmQZfG678I+A9Adzh14shkWwDaL37gPkgpj/NQ/MfdBsmE17dkCdfOM3T3cYTjVWgxqlNgBM6xRecRP8xWlwTEjCmAtF++b7DM7Yr3DwgjtvBy29BWJoyYEUelNM/5Ra3MB7W9y7NAqdtj5G2lrS9BV6NZobBexENf90bWSK/LBr7FL8k+CFdzIGi1/z86SIpGYYVU1OyAnDn/Nr0S0ccJ1VTAKQi/5XgHkqE4nSnGkxKUaWUwEHcSJD/uFGStiV+ipT2jEOQy+Ci+VYxPUOMBMYjc78VQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:26:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:26:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v7 4/4] intel_iommu: make type match
Thread-Topic: [PATCH v7 4/4] intel_iommu: make type match
Thread-Index: AQHa0gvxRjyKfg1NiUKh789rILHFuQ==
Date: Tue, 9 Jul 2024 14:26:10 +0000
Message-ID: <20240709142557.317271-5-clement.mathieu--drif@eviden.com>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: bb01d6a3-ddfa-4816-904a-08dca0231478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YjlDdDZQSENTSjVaTk14TlcycmtVakJUTjN6VVZKVGJMRzlVUkoyQVhpZVU5?=
 =?utf-8?B?d2lBTUh6N0p0dThQL3NMSGw4Zld5QzlYd1RBOFYraGxybDRGWmkybm56czRK?=
 =?utf-8?B?QUlTWVVhZXVCS0gvMEFBb2pLdVh2ZVRtRUxZUTJyajBKeW00U2hxTXFjaHdq?=
 =?utf-8?B?ZUxTS1NQNktLZkV2SXJHcUlva0Vsdm9ldVVDNWdhY1Qydi9mOG5SK0JydHlO?=
 =?utf-8?B?Tnd5Y0s5VEY3aGRTdGpacitQK0JFZTFrTHk5WHcwYnBzdlNncW9wOEdndjZ0?=
 =?utf-8?B?cUpZNU4wZzhadWorYnY1dEdMeS9LdHlLUU9PamFZQU5EOHJMNmpwZG1XQjdY?=
 =?utf-8?B?bHJ4T253cEt5Y2NUTS9uRmpZNWMvQ2JLTTQ1VDIwZ2xuKytnU0t6VlN0YzRQ?=
 =?utf-8?B?bTNNN2JUSUZjUG1CZjM0aEFuYmpsa2JhMlo1MU9mZkJ3UDJ1cCthbGp4bVlr?=
 =?utf-8?B?WXA1UHZoTWNLaHdOVjBoZWd1cURSVG04cmRsZFJ3Nk9KaCt0YVR2N3FOV2Jl?=
 =?utf-8?B?N2NXOG9PRkhhTzNrdVFZSE9qbHVxajBwdXBjdW52WGZ0Wk05c3VSVFF0ME16?=
 =?utf-8?B?azM1WG9ib09Gc1Q3K0RjQmU2eDloUEh0NEtpa3dpMDFTT2hqM1lzZEhPSEVZ?=
 =?utf-8?B?SWRYVkJuSG9LNUpXeitXQ2o2QmNSSGg3eUVHd3o3Q1FmVUIrSi91YSt4TGdX?=
 =?utf-8?B?M25kVTRqeFRFSEp4TDNVbjNvV1dkMFYxV25nSUF6U3V5NEFxa3oyazZWQjho?=
 =?utf-8?B?NVlUblZldmExSDFzUklpa2duRW1GMkc0bDNnbDgyQWxNV3N4YkhYOFFQaDVj?=
 =?utf-8?B?dzFTb0dwOUpDY2YwTVhJQ1RWblR6KzVXdm54NXN4L2l5aVh4MkVZamVkN2lH?=
 =?utf-8?B?NW9TNHFCMWJtdWlCN0d5d1poZkZUZjlMbUV5TjQ2NG1yc2lqYng3R2JyTUx1?=
 =?utf-8?B?NnYza09iTitFTHhjREh2SDR0Szl0R2FYVWNyWWJnZlcrU09SNExkTVYzYm5K?=
 =?utf-8?B?ZUxRYVZrRUpqOVlld0ptVTNQTVY1SGNCT2ZmUysreEhtSEJGMVJjSVJBaUZz?=
 =?utf-8?B?b0tMdlRsckNWZ29YN055L2FnM1VxaXNpWk9XQy84QitTZnd0cnNacG5wQnlO?=
 =?utf-8?B?RmpWaGpDaGJhQzA3Zy9DVDNvYUx5d1YzSjN3NWRyVVdLS0NvR2dTSUtvR2x3?=
 =?utf-8?B?RE5KUUtZVWhMaEozV1BIdy95YzV6b281Q0lVWEcyYnpCbzVQYWhma25UeDlT?=
 =?utf-8?B?aktsQ1dkU1BnaGZiR1g4cDZQT3FGOEVXL2s0alRONzhERTF6Rk5jaHJuK24x?=
 =?utf-8?B?b1AwdW5CZVpKRlMvZ0dMYm14eGxVaXU0bnpXKzY2NGVSUWg3Z2kzUWdaUzRM?=
 =?utf-8?B?QmtpUVQ2Ly9KTEQybXduVFkrcFNodUR4c0w4b0EwNkhIa2VzYXdnWHRmT3RN?=
 =?utf-8?B?bXZBVnVSZ2MzaXVhREFFZlY5TXBCYU10Q201bzNPUTlKQmZFZzlhbDcvdU1v?=
 =?utf-8?B?RGhYZ1MxaGFocHZ5MnpzMEJWOGpIUE0vWm94K2NLb0JuVTFka0hDOE5RT0h0?=
 =?utf-8?B?d0ZtS2JVaG0vbnUzaEo0Tk81V0I3eTdkTlplMi9vdXJzL0NobFhzcWYyY0hn?=
 =?utf-8?B?cHVvN1JKUDNMRVhTSmx6VGtQLzVZNmRPaUcwdnFuUDhaRllpQnowak5NakUz?=
 =?utf-8?B?RGZwSzErMUkxNU1Oc3VIQ29zWjJISU1ZTjZGaVMzU3AwNWdIMnFGaGxuMVFC?=
 =?utf-8?B?MEVkUGdjVzVic1pSOHVmcE9OeWYvWUxtQXZEMkZvSGVtbHFUMyt2QkdyeHJi?=
 =?utf-8?B?NVJ1ZjgxVEh0K2dwWlRKc0ZPOWIrejhTS0oyMklPaFZIWFh6TmFaSjJXVnJF?=
 =?utf-8?B?aEdBZHlacWZad0NxTDAvMkl3S1lVSitEMSt3VVY4aDlHZnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cllVNWtlMFNDam1xQkdpWGthR3dTa0hndm5mR1ZLYzVPK0RGYmJUWDc2bi9m?=
 =?utf-8?B?czZTYzVleHpNWVVNRWtwNXFMUVE5VTcrZlBscGtUZjZoTEducFFLQW9qVnhM?=
 =?utf-8?B?SUlHaFJsbTdEczI5Rnp2SHo1QnUranA2UjQ1Ynhmd3lNdmtFeXd6QVFzRkk5?=
 =?utf-8?B?Y3dpeVJpSzJGVWhxaXZ1NUZYNUQ2Y0hKeVA3NVpBODJLbnkwbmRaY1FPa05o?=
 =?utf-8?B?TkJjNWMxc3V0Tzg4VUF3aWZoTkM5VlhKYkdJc3RNcHd5REdUWVl3ZnpYdjZG?=
 =?utf-8?B?UktkVmVHMzZDcjdCb2hKbDVGOUNGRmhhT0IrWEJiLzBaVitBejVoVmpEU01w?=
 =?utf-8?B?QWt5dWUxa1Q0RUl5VjhGWXA3REZQaHBBWFJDdktqWlJRREhveTFDa2w2K29l?=
 =?utf-8?B?UTdlSFFjN3lIaENHTGNXOXFEb2pkVEVCNHJ6Mm4zRWd4cEZKM3hkc0VpS20w?=
 =?utf-8?B?YTdmNm0wVFlmeS91dEhvSmFLVFU0cGwrODh4OXAzaGFUR1V2SDhRaG9vUGU2?=
 =?utf-8?B?dkprcGxwSzhnZzV1REMxc25XZVZ5dmhvMDBNSDBWd01ucTRZQVRxZ1hiN1ZW?=
 =?utf-8?B?MkgwVjlmUTN5VzJycW5iZWFQMnIrbnUxK3NrY2hiYVoxSForK3NRVWszbzVU?=
 =?utf-8?B?TmdrN2VrdHlYcUc2aUZ5Y2FzazVRZFJkZHVuTVk5S2Z4RGlLaitETm5UVEhp?=
 =?utf-8?B?UzJOS29uT1VxNzRGdDhYMlhoWTdpTE82aWhoUTkrNHNJYWxVVTZ3WDdkYXZr?=
 =?utf-8?B?UWc5WUg1SUwzZkxnajZTaTY0ZGh6d1RKL3BZOGFzajlWNEdNZUxTU0FpbElC?=
 =?utf-8?B?S1E3OVM0ZE00aU8xdlBMdEloRVNPSVd2TVZkYkFyM25NeWxpbytoOStLbVhM?=
 =?utf-8?B?QTdWWUZuOVFCdng4SVJuNHJ6T0ZmcEFCd2VsbVg0bDBEc1ZDWWhneXlDVGR4?=
 =?utf-8?B?UHNrYk1ROGhCc21XVUoyZXR1QlZPL3Q3N3FyRlFtUDNQYlEyOE90d2xQUUNw?=
 =?utf-8?B?QmgxZlB3WlVHY0g4WC9hZ1YyWWxudm1zM2ZrYm14bTZsVGN4R1NzaG1aazVV?=
 =?utf-8?B?SnVmSGFhNC9lU2tLaGRIdklsbGJ3dUxUYVlyanlaMDlPRVNDdE9qLytTdEJD?=
 =?utf-8?B?ZnpLQnkyWU4ySjBhcVVGODZBWlZXRlBVNXE1cE81dEF3U0VDMDcxS2JRSHps?=
 =?utf-8?B?cnRoSi8xb0R5RStVR2QzRDArNUJXVDZhUXZob3VHRTE3ZTkwZFp2VDBaYlhU?=
 =?utf-8?B?YlpDVU5hSzBzREY4QzFFL1ViUlE2RURveEhqV0dhTUVwbHNqWS9DRURjQU8v?=
 =?utf-8?B?YU4vOEJEbkdyaFhzSmVWeWV5Z3h2Q1d4dlNPd3FWSVFRVmFvdHBlVmtoYjJm?=
 =?utf-8?B?V1dvUk1lR2RKSEIrUmgyVmNVVWZsam1WVG5jaVovbk50ZWNmenY0YU52VGFq?=
 =?utf-8?B?VVdUenU3dkt3TDZqM2loVy8rOTNkNzRaQWpGOGtaUEVMVGhPdXI0b2tyMXBZ?=
 =?utf-8?B?cjZiUnY3MUVrM3VaaDVrSDJydHMxL1lDbXFQMk44YzNKS01PRVVBNnZaeG5J?=
 =?utf-8?B?VGVwcTk0RjBRYm9JY3Joc1JDcy9Bc1FreTdmc1pzajBNam91SEU1dUdTanF5?=
 =?utf-8?B?ZXU3ejVXZ3pzQXlrbU42Y0RnMjVSQ3FKV3YzM1hSQnJ2VW4yTmtWT3cvVjB3?=
 =?utf-8?B?WjdKOE0wMkJYNzQyRm1BSm9XOWtVcFd5bDNEQnJFZm5pek8wL25lMzBOSUow?=
 =?utf-8?B?d25qTmRBV1R0c1RNa1NDQi9vdGhGNGFLVmZtRCtJaUtDZ041K0loWXJML2R6?=
 =?utf-8?B?a0FGY2FPVG8rR3QxdXF0Ykd0bWZZWkxTUjhyVVZabTNXL09Pa1BLTlVNQXE2?=
 =?utf-8?B?RXk0YVdtRFNYUjA4NDhhYnI5MW00RTFsRUNHK2V3TXVYNG5lZkRlU0ltMFU2?=
 =?utf-8?B?cE91TzhjRjZEMmhENGtyZnE4ZXNqSVptYWsrUTZsTEUyUk8va1ZHMkFyUHlS?=
 =?utf-8?B?MS80OXd2UTJjL2I3UGJwN2xhQzF6R2tDWFFRbFB6T21oendhRGUyb0JnTk9D?=
 =?utf-8?B?S09LWWUyalFzbmN4MGZiWngvc1Uya0hNYjduQnV5Q2FwTnVYdUsyT3I0RGVx?=
 =?utf-8?B?bFlMdnYzQnM0cjBodURpN09YMnY4Q3FaaXJvS2M5REt5aE40OUcxVjJ5eFdN?=
 =?utf-8?Q?dYmgbF+2ppC79a1Df8HKe1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A237FF0AC58C24F933878A4935EAC3E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb01d6a3-ddfa-4816-904a-08dca0231478
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:26:10.7457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTm6I7nO5AC27XoljQ38+g216WPplaeNMdO7BptIn92LshGN8EARdxSBnM/rsXwqD367dtKoPYD308dQ3nFSs7rBJOuCL8rL6Qdc4JJ6ricV7Ut2cYn8VS2TzrdHimbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClRoaXMgaXMgbm90IGFuIGlzc3VlIGJ5IGl0c2VsZiwgYnV0IHVz
aW5nIHVuc2lnbmVkIGhlcmUgc2VlbXMgY2xlYW5lci4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1l
bnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQpSZXZp
ZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQotLS0NCiBody9pMzg2L2ludGVs
X2lvbW11LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCmluZGV4IDM3YzIxYTBhZWMuLmJlMGNiMzliNWMgMTAwNjQ0DQotLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTM1
OCw3ICszNTgsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xvb2t1cF9pb3RsYihJbnRl
bElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQogICAgIHN0cnVjdCB2dGRf
aW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7DQotICAgIGludCBsZXZl
bDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2ZWwgPSBWVERfU0xfUFRf
TEVWRUw7IGxldmVsIDwgVlREX1NMX1BNTDRfTEVWRUw7IGxldmVsKyspIHsNCiAgICAgICAgIGtl
eS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQotLSANCjIuNDUuMg0K

