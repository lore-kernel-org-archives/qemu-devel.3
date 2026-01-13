Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9CD2D10A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffa7-0000bv-RK; Tue, 13 Jan 2026 09:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vffa5-0000XK-Cs; Tue, 13 Jan 2026 09:41:13 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vffa3-0007dw-Aw; Tue, 13 Jan 2026 09:41:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9zv+OpXvZ+9dZ2kT+tm5gowwnVYzdlWriA6Ymrizysaj+2aVOb7LI2xCCgT317ozrLmU0owkLNZlh8CZ0MOdGZ/MZvUW19GV/9epFmMhC5V0l0d3v6/2i/j9fZfY/gmaJnCuaO0Olwez9Z0v+DJPCqR6l0SwNILjeJ4Z+uFo40pmHY8mnUR5QektXxm+6IqRJ8hHW73Q2otre0xdWlLHJtTKiqHLfAjZPuMMsdWHEQfwHPOQQ1dYdnW+jYrMdjl6nTaUvKdU0biM2yBHf98Uzu6h5Bo4/FYR1E0PDanEpi9h0/Pr/28imnehnrR2Z6xmGI/c1iAzzd9mEb+xvPRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoGwn2FoHRnS0dYYp+wo8z2xrjyIH8SkEPNk5JoXtjQ=;
 b=ONtYpSOjftIClayxNQL8Cs27Zkx5WueM+1oj0Ep1gC/S09Y/pPVLCJ0/ldL5n4SzEKZCIXWP1YFAxOiaOQpB/5AD76Inn5ONY9nP8o/Z3Hr6W8EjVrBCKUSoiR9MFsSQe3Y7lFFDGlJWTJQnopjIxumYLcxVYvVEaBwLQQRTzOrOCJd7IMvi29U4RjybVn6k6KdEiomIX62m38d79QB60ntcuRxlhbJq3vzyYkjnGdQa+qNup2KKv2bt4P41qF6adG5orQvd8vL26lYs+Segx++Mhekxmdu/mLwx3Vk6X1c+WEUh2alS73qF2akHX1h8z/fvSjTYw4k2ta7yJRTjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoGwn2FoHRnS0dYYp+wo8z2xrjyIH8SkEPNk5JoXtjQ=;
 b=ECX+vXZYA+ZrFGH5L0faKkadpCUyn0RtblMDRM61CDuh+YPt07hIU3LwndHznyhDVPKcIGmM+plDH75qq7/bX3iSf7P9avCw01KS6X5GDFttigkuJWNjScbIWFiBnTcyRmkda+hePCHjL1Mx1fvdVo8xLPxkZOSOzcLrQBEj0nyImqOYaI2rOakzXTeVZXB1rj5gszSWk0++pQO/YH2SIlC4XT7SSTNO93Arld8ie/3tcbsyaUz386+CRMCYXijcjRggHfvU7T8fEyajFoJO9ZtFXON2qfqUe+vg6jUy/px1hIT2qi4XYGypYLZ1pkJfw+PvUeEj3z1bgFZ3xijaVg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:41:03 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 14:41:03 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Thread-Topic: [RFC PATCH 05/16] hw/arm/tegra241-cmdqv: Add initial Tegra241
 CMDQ-Virtualisation support
Thread-Index: AQHcadqP71vRjdLaMEyQWnaXahlP+7VO3I2AgAF1lTA=
Date: Tue, 13 Jan 2026 14:41:03 +0000
Message-ID: <CH3PR12MB7548CCE21D0E447A18E190BAAB8EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-6-skolothumtho@nvidia.com>
 <309bce2f-be34-4d3b-83e3-2a115f1ace80@redhat.com>
In-Reply-To: <309bce2f-be34-4d3b-83e3-2a115f1ace80@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL1PR12MB5923:EE_
x-ms-office365-filtering-correlation-id: 7af5de24-f2a8-4095-af00-08de52b1c703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RFg0NlZWVnBXZjdsUzNSOU8wcGVUSXdZelJTdDlJYUQzS21qL0FwS0IvTW9m?=
 =?utf-8?B?WEJyUU9BVFZWZmVWeXRiYVArU2thNCtsZUZqc3JWcG5ZMUdXTTRsa0N3QlZF?=
 =?utf-8?B?d3MrZHBSVjVReXQ0M1ZUOWJMZ0VyQVV5ajZwNkk0TU9Hb2tkZ2h6OWN0MlBQ?=
 =?utf-8?B?RWtGOEJHNEVQb1RENTNmSGhMYWo5ZUNZa0lrV1dZbWpPbkhDNnlrYmRoM2xN?=
 =?utf-8?B?V1paSk5FenNBczhLc0tDUFZSc0tLMlVRbEM3TFp6MzQ4dHJMMHRwempaczFs?=
 =?utf-8?B?M2tCZWlVRUp1WEI0aDBtNXRwVXhVNjMrTHVtSE5BT081M2ZtMm1VWGh6RDdX?=
 =?utf-8?B?SGtTL1RWeFQ4ay9ZVndQbEZEN0pDSGdOVUxzdGRxT2cyUC9xYlBGSTk5L0xO?=
 =?utf-8?B?eEM2Sml3RExxZmRJeDd6cXVsQVEvQUpvcG9KOTV1RzJNVlZqQUQvbStOWDNm?=
 =?utf-8?B?YWhEWjJIOER3ajRBU3BqakcrMzBIVjhnV0JKVWtMZ1NMeXRnOUg0SmJqRVVY?=
 =?utf-8?B?QmRGSWlqUWt4NStyU3h6UUxXUSt5S3NyV2MvajZES2xkMUllclZlc3Nqekoz?=
 =?utf-8?B?ZVZ0bzhYaGFPYWxZMWNWc2txNUhMcFF4dDEyTThuTWxBMkRiRjNrQXU3TWpw?=
 =?utf-8?B?L1dUL095Q1A4S2tYMm93L1g1ekZIUWNvczlDWFNMY0VQdGJybVNhMlVGb3J6?=
 =?utf-8?B?YXhlcllITG9FWkowTUZZUmFhdkhDdzNESnF3Q3JwcysyY1lsbFEza1YrZWdX?=
 =?utf-8?B?QVN0QThHdGVjL2p2STMxdTJ0cU9JaHZUeFZ1QUc2ekJWdzVCVitzUUxsNVdh?=
 =?utf-8?B?QU14eEZWY0pRSSt6dFRNMlRaRUlxaHZLMjRCY1hoVWR4S0RjS2c4UnZkYmpu?=
 =?utf-8?B?T0trMTNWM2hWaFk5Yk9jSWpnN0pxL0M5QzAxMXNvYWdpUVVzTFpvalR4N2E4?=
 =?utf-8?B?ZnF0RVhqL2NxVHJyYVNid0NuZEUySmFrcTgweHh5R0hDVXg5RldsTXVNZmhE?=
 =?utf-8?B?eUF1RktLdGxzME5nSUZrWFhqTDRBSUt4YVY0WjY4WGpXM3llcVlwV3MwVDhL?=
 =?utf-8?B?Wi9rNDFYZFJldUJkbVVxa0NTeWFiUFphQklZUy9hUUkrWEVkRnJQSVlHY0NO?=
 =?utf-8?B?NC93TGJjT3ZEejhNR241cXI5aUZ6ZlFwb2RKK0VuTXFld1hQK3NZV1NRa2xI?=
 =?utf-8?B?MnIwTmJpOEZVT3pjVGlmWVF5NkRsVmNLNGdUMFFVM0JJaEQ1WVNLQlV1UWtj?=
 =?utf-8?B?eHVGVXdzWTFVMFRIYlU4RzNjODNkaWI4a2lrRmFBY0VKMldGVGk5YUg3SWkz?=
 =?utf-8?B?WWJ2K3dZcUo1emJpOEVvQkxTeFJubXZaQ3BRR3RuRlptUWw1b21lZXV3VVpx?=
 =?utf-8?B?WXhkV1lpMEEyTkFEUTFGR1h4dUo2TzBMb0tSUXVEQTBoUXBlVjBkdkRZbEV5?=
 =?utf-8?B?RUxTRVRWMGFvd3BYcjN3RDJYQUhTYi9CUTdPUERtS3BsY2FMbmMwNUlXMXNx?=
 =?utf-8?B?aHJ1OWpQaisxOWlxY294c0doNFV2OVA2T1pIQUMyTkJMMHh6RS8xSnlIeXNV?=
 =?utf-8?B?S0d1RWh6TWxYY3cwT016T25mZGtYb2REejU3UEczaGFwVHUvY0hUZVMvcDZy?=
 =?utf-8?B?WFFEWXY5Y0FaT0UvODg1MHdVQ0V0bkpSWEZmQWlIOXVvSWhyNG1aek42RCs1?=
 =?utf-8?B?Ry9hUU4yQzhKbzJrUUd0T3pHaU16VXdzaWg3MkFhcE8rZmszOW1HdDlEVGFo?=
 =?utf-8?B?YzlIeUVmVU5MSGFwd1c4SjV1TjR6dzFWY0FkWE9GbWVHcWJOb01VdVN6Mnh0?=
 =?utf-8?B?MEFZM3FpYkZXZUZVM0E2QmFTUFdNR1FkeU1xZDNMS1JOTC9NSFlKVDZScUVj?=
 =?utf-8?B?N3FTVlRtUXFzeW1pY1dGVU1wOWlGa2ErQk1QcjR5d3dPdzdubnFqMCs1bk0z?=
 =?utf-8?B?MU5xcDNqSk5UOWYxMUlhckIxemJnbnZ3bFo3L2YxakY2VGFmZThuTFkyNlRy?=
 =?utf-8?B?RzFuak9YZkRTT0xabzNXeVNDdGsxM3dtWTlUenZnNDlDbk5WYXY1cHN1bEZo?=
 =?utf-8?Q?jd3BZh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajBuQ3lJZE5zTytYTDBZaDJrMks4S2RhUnkzS0hUeWJTUDFSVzUrL3IwQ0Rs?=
 =?utf-8?B?ME4zWXRscjA3QjM2WkhjaFhnYVkrNEVjdGkzZVZQZ0dTNkxSME1JWEFJMkE3?=
 =?utf-8?B?dzRsN1RmYmwvbE1KUTZscmVpS2JzOThxemVNRUw2cXkwZE03c2VlSWFsTHNI?=
 =?utf-8?B?eExoNlk4bFJKRlo5WTFsd0ZRNkdmN2lZdU9JVWxETGpNZTN1Y3RDdjIzbXVL?=
 =?utf-8?B?TXYvZW5ONzd3bUFTcjBqN0s3RzhSelBpSDA0NTVKN2JFSURBSENYd3lVV1ly?=
 =?utf-8?B?NVlaZ3dwd1BtVkppdFRqRHQrTUpDWFZhc0RrNjFTdVpUNmFmUFZ2djBhSVBE?=
 =?utf-8?B?VHV2eDh4UFArYmJFTThwczlzSW5yMzZkT3lNUmZuT2ttd0xEcnNiOUc4MWxE?=
 =?utf-8?B?WW9MZDl3K1BoZTkyWjJwY003TS9sNm5VSzQ0TDRkQVIzMGZvanlBTGg3OHhH?=
 =?utf-8?B?S0RqQURYdWlLbHhNRFhjVEx2b2VCRjZFYjZSbXF0VGlrWTFCTy9jeFN1REkw?=
 =?utf-8?B?WDRHMEluSnRGNCtZNWlIeXhtZStoTUtsTlpCZ2E0MzFoVW44T3M3cWFrS0VP?=
 =?utf-8?B?VzJicjJXSG9SUHZxL2p5U1lSakhoSVRQMTlSZS9XYUFLZmh3RERmSjR2c3dw?=
 =?utf-8?B?NEp3Y05rU1ZDcnFxNGNtZmh1NHFPUkdvV0RlcmhNQkZLRDg4OUxPS0JDcU05?=
 =?utf-8?B?V09aM0I0SXo5clU5VUNkeXAvdFRrSGNzUG1LQzU3RXZrb09RcnAxalBwWG1E?=
 =?utf-8?B?QkFpT2hPVFo3M2pnamZjMHk0VWxBOFdodFRZVUN4SmVEVlBXODZHSFM4R21x?=
 =?utf-8?B?SC9VZEFFbnQ1b0FqM2pZKzVQbG54WDZ1dU9ubldlSzRxL1NsZVpRVXB1OFlx?=
 =?utf-8?B?RWZxQXA0bGVndzdLbk5XaHBWZ0JaVXJ5dklYWDNWbWphYjJ1REVzeWxlWVM3?=
 =?utf-8?B?QVo3QnI1eTZEM3dzeG90a0ZoOUwxeXBGU3UzbVd6V0tDU01sd2lqVFRJaENC?=
 =?utf-8?B?OXhRR3pGMlJnY3hyN1FqWTJiSitqeDRwZXZyb0lyYmYvZnNJOUlCVWYzeFds?=
 =?utf-8?B?cis0VHVKcFNxUVBVazJtR05id2lZUUVuTEV3S2tDUGZDa0JLdElpVXp6T0cz?=
 =?utf-8?B?M3QyaHJWb0J3bjdsWUpKSG9uM3NtRHpVdFUwTFR3cmVZREF1RVFjYVoxcWZo?=
 =?utf-8?B?WEdSLzM5N2JSTkNJU0F4SG1lMXhiTXpsOWdrSThaSC9hWkx6am1QaGlqRXVC?=
 =?utf-8?B?UXFXYjFGQnhYZUJoS2FZaHNVVGN2TUd4K1hQSDdrKytmSTZldjJTcDNlcFEr?=
 =?utf-8?B?Z0RkWVBtVkVzamYzUzRwU1RXRVlVcWQ4VmxNZUtyR0EyWFo2NzVtT28yMjg4?=
 =?utf-8?B?MlgzZlV5Wk5SZTVPeHFaNnJ0dDlqalhvWWxKYXd6a1doU0xGMDlXNkhuWThF?=
 =?utf-8?B?V1p4Sjdka25wejhXVEgwdGllN25zMlRhVmwxUkk3TEIvNnlCYUUxWXQ1bW56?=
 =?utf-8?B?a0RKRE9wWE1teFBnbE1TMXNYVUJtWnRQcDB2VXUwaStwMForamZFNE0yS0Zi?=
 =?utf-8?B?RW1uaVJlRkhBQmlDMkQ2TldycDRpL2NqTks2WmFTeDlNK1VDNmtZU1RVZXFh?=
 =?utf-8?B?RHlIK0krczZDM2xpVU5NT0FPRXA5Z0o1Q2FtQXJIRnppN3FzRFJVM25SZEta?=
 =?utf-8?B?dFlOWVJieGxTVXlDQ3dzdVhGWk94UlBmd014ZTN6WWJiRUo2R2huaDI4bStO?=
 =?utf-8?B?dmRjbHZjbGc5QlBKSCt0cGl3RUJMSDFwaDlYOGNGMGlCSGxwaFFnWHVGeVlS?=
 =?utf-8?B?V2xUdVg0WW5NeFhGU2M1cHZac2dKd1RpYVE4OWg5OFhUcGg4d3gvK25FVWlL?=
 =?utf-8?B?MzFFQ0Z3STVtTTJKL04vVFRjbmh0SWVxSVowY3ZyOUZ1cUdIeDJIUnJ6YWp1?=
 =?utf-8?B?bFV3WDRlbFR2SU82OGk4QkoxOVQ2bnN3UUxPVzRLQ1JxQ2RNWTBpblpkWmJY?=
 =?utf-8?B?QTZpeUdXNzJ0NFY1M1BVd3pBRFNIUnZ6WFJINHNydisrUjdSdVZqaGRiNmJn?=
 =?utf-8?B?UUpJR2p3UHFPYlA2b2k5VVZrOGpMUWpUdUZGWnNxQ3grSTlTUFVUcVB3dGsv?=
 =?utf-8?B?U1dGU1RLdmVxL3FDazJYRCtNYVN3eTFIUDdJeUt6eG12ak1ZL1djNDVBWmpj?=
 =?utf-8?B?K2ZwSHA2SEs2VzU2WWRMOGhnbWlRcWNxQTlnSVBoaVlOSGNOSVFjOTcxNVB4?=
 =?utf-8?B?MVlscWxYcThneUlNblA4NDBSRnk5MSt2SEx6NExUV3poeHFYVjlyRExXUTdD?=
 =?utf-8?B?L3M5ZG11YVJObS84RWNYMUZ3Rk1GMXBxSXUxWmZLc2xzV2tGREJRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af5de24-f2a8-4095-af00-08de52b1c703
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 14:41:03.4299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBgHk3DddyVOg1xMq07obO0Xuc8ilAO9y/PuGDHgIELt5jJTGhK9NZK9yNzRkRZ+kke7aCzPlZKa2x+7bgaEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDEyIEphbnVhcnkgMjAyNiAxNToy
OQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5h
dGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+OyBKYXNvbg0KPiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgam9uYXRoYW4uY2Ft
ZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1
YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwNS8xNl0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2OiBBZGQg
aW5pdGlhbA0KPiBUZWdyYTI0MSBDTURRLVZpcnR1YWxpc2F0aW9uIHN1cHBvcnQNCj4gDQo+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiANCj4gT24gMTIvMTAvMjUgMjozNyBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4g
PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4NCj4gPiBJbnRy
b2R1Y2UgaW5pdGlhbCBzdXBwb3J0IGZvciBOVklESUEgVGVncmEyNDEgQ01EUS1WaXJ0dWFsaXNh
dGlvbg0KPiAoQ01EUVYpLA0KPiA+IGFuIGV4dGVuc2lvbiB0byBTTU1VdjMgcHJvdmlkaW5nIHZp
cnR1YWxpemFibGUgaGFyZHdhcmUgY29tbWFuZA0KPiBxdWV1ZXMuDQo+ID4gVGhpcyBhZGRzIHRo
ZSBiYXNpYyBNTUlPIGhhbmRsaW5nLCBhbmQgaW50ZWdyYXRpb24gaG9va3MgaW4gdGhlIFNNTVV2
Mw0KPiA+IGFjY2VsZXJhdGVkIHBhdGguIFdoZW4gZW5hYmxlZCwgdGhlIFNNTVV2MyBiYWNrZW5k
IGFsbG9jYXRlcyBhIFRlZ3JhMjQxDQo+ID4gc3BlY2lmaWMgdklPTU1VIG9iamVjdCB2aWEgSU9N
TVVGRCBhbmQgZXhwb3NlcyBhIENNRFFWIE1NSU8gcmVnaW9uDQo+IGFuZA0KPiA+IElSUSB0byB0
aGUgZ3Vlc3QuDQo+ID4NCj4gPiBUaGUgInRlZ3JhMjQxLWNtZHF2IiBwcm9wZXJ0eSBpc24ndCB1
c2VyIHZpc2libGUgeWV0IGFuZCBpdCB3aWxsIGJlDQo+ID4gaW50cm9kdWNlZCBpbiBhIGxhdGVy
IHBhdGNoIG9uY2UgYWxsIHRoZSBzdXBwb3J0aW5nIHBpZWNlcyBhcmUgcmVhZHkuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9LY29uZmlnICAgICAgICAgIHwgIDUgKysrKw0KPiA+ICBo
dy9hcm0vbWVzb24uYnVpbGQgICAgICB8ICAxICsNCj4gPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5j
ICAgfCAxMCArKysrKy0tDQo+ID4gIGh3L2FybS9zbW11djMuYyAgICAgICAgIHwgIDQgKysrDQo+
ID4gIGh3L2FybS90ZWdyYTI0MS1jbWRxdi5jIHwgNjUNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmggfCA0MCAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvaHcvYXJtL3NtbXV2My5oIHwg
IDMgKysNCj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L2FybS9LY29uZmlnIGIvaHcvYXJtL0tjb25maWcNCj4gPiBpbmRleCA3
MDJiNzlhMDJiLi40MmI2Yjk1Mjg1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9LY29uZmlnDQo+
ID4gKysrIGIvaHcvYXJtL0tjb25maWcNCj4gPiBAQCAtMzcsNiArMzcsNyBAQCBjb25maWcgQVJN
X1ZJUlQNCj4gPiAgICAgIHNlbGVjdCBWSVJUSU9fTUVNX1NVUFBPUlRFRA0KPiA+ICAgICAgc2Vs
ZWN0IEFDUElfQ1hMDQo+ID4gICAgICBzZWxlY3QgQUNQSV9ITUFUDQo+ID4gKyAgICBzZWxlY3Qg
VEVHUkEyNDFfQ01EUVYNCj4gPg0KPiA+ICBjb25maWcgQ1VCSUVCT0FSRA0KPiA+ICAgICAgYm9v
bA0KPiA+IEBAIC02MzQsNiArNjM1LDEwIEBAIGNvbmZpZyBBUk1fU01NVVYzX0FDQ0VMDQo+ID4g
ICAgICBib29sDQo+ID4gICAgICBkZXBlbmRzIG9uIEFSTV9TTU1VVjMgJiYgSU9NTVVGRA0KPiA+
DQo+ID4gK2NvbmZpZyBURUdSQTI0MV9DTURRVg0KPiA+ICsgICAgYm9vbA0KPiA+ICsgICAgZGVw
ZW5kcyBvbiBBUk1fU01NVVYzX0FDQ0VMDQo+ID4gKw0KPiA+ICBjb25maWcgRlNMX0lNWDZVTA0K
PiA+ICAgICAgYm9vbA0KPiA+ICAgICAgZGVmYXVsdCB5DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Fy
bS9tZXNvbi5idWlsZCBiL2h3L2FybS9tZXNvbi5idWlsZA0KPiA+IGluZGV4IGMyNTA0ODdlNjQu
LjRlYzkxZGI1MGEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL21lc29uLmJ1aWxkDQo+ID4gKysr
IGIvaHcvYXJtL21lc29uLmJ1aWxkDQo+ID4gQEAgLTg2LDYgKzg2LDcgQEAgYXJtX2NvbW1vbl9z
cy5hZGQod2hlbjogJ0NPTkZJR19GU0xfSU1YOE1QJywNCj4gaWZfdHJ1ZTogZmlsZXMoJ2ZzbC1p
bXg4bXAuYycpKQ0KPiA+ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0ZTTF9JTVg4
TVBfRVZLJywgaWZfdHJ1ZToNCj4gZmlsZXMoJ2lteDhtcC1ldmsuYycpKQ0KPiA+ICBhcm1fc3Mu
YWRkKHdoZW46ICdDT05GSUdfQVJNX1NNTVVWMycsIGlmX3RydWU6IGZpbGVzKCdzbW11djMuYycp
KQ0KPiA+ICBhcm1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVJNX1NNTVVWM19BQ0NFTCcsIGlmX3Ry
dWU6DQo+IGZpbGVzKCdzbW11djMtYWNjZWwuYycpKQ0KPiA+ICthcm1fc3MuYWRkKHdoZW46ICdD
T05GSUdfVEVHUkEyNDFfQ01EUVYnLCBpZl90cnVlOiBmaWxlcygndGVncmEyNDEtDQo+IGNtZHF2
LmMnKSkNCj4gPiAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19GU0xfSU1YNlVMJywg
aWZfdHJ1ZTogZmlsZXMoJ2ZzbC0NCj4gaW14NnVsLmMnLCAnbWNpbXg2dWwtZXZrLmMnKSkNCj4g
PiAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19OUkY1MV9TT0MnLCBpZl90cnVlOg0K
PiBmaWxlcygnbnJmNTFfc29jLmMnKSkNCj4gPiAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NP
TkZJR19YRU4nLCBpZl90cnVlOiBmaWxlcygNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gaW5kZXggOTM5ODk4YzliMC4u
ZTUwYzRiM2JiNyAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiAr
KysgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBAQCAtMTgsNiArMTgsNyBAQA0KPiA+DQo+
ID4gICNpbmNsdWRlICJzbW11djMtaW50ZXJuYWwuaCINCj4gPiAgI2luY2x1ZGUgInNtbXV2My1h
Y2NlbC5oIg0KPiA+ICsjaW5jbHVkZSAidGVncmEyNDEtY21kcXYuaCINCj4gPg0KPiA+ICAvKg0K
PiA+ICAgKiBUaGUgcm9vdCByZWdpb24gYWxpYXNlcyB0aGUgZ2xvYmFsIHN5c3RlbSBtZW1vcnks
IGFuZA0KPiBzaGFyZWRfYXNfc3lzbWVtDQo+ID4gQEAgLTQ5OSwxMCArNTAwLDE1IEBAIHNtbXV2
M19hY2NlbF9hbGxvY192aW9tbXUoU01NVXYzU3RhdGUgKnMsDQo+IEhvc3RJT01NVURldmljZUlP
TU1VRkQgKmlkZXYsDQo+ID4gICAgICAgICAgLnN0ZSA9IHsgU01NVV9TVEVfVkFMSUQsIDB4MFVM
TCB9LA0KPiA+ICAgICAgfTsNCj4gPiAgICAgIHVpbnQzMl90IHMyX2h3cHRfaWQgPSBpZGV2LT5o
d3B0X2lkOw0KPiA+IC0gICAgdWludDMyX3QgdmlvbW11X2lkLCBod3B0X2lkOw0KPiA+ICsgICAg
dWludDMyX3QgdmlvbW11X2lkID0gMCwgaHdwdF9pZDsNCj4gPiAgICAgIFNNTVV2M0FjY2VsU3Rh
dGUgKmFjY2VsOw0KPiA+DQo+ID4gLSAgICBpZiAoIWlvbW11ZmRfYmFja2VuZF9hbGxvY192aW9t
bXUoaWRldi0+aW9tbXVmZCwgaWRldi0+ZGV2aWQsDQo+ID4gKyAgICBpZiAocy0+dGVncmEyNDFf
Y21kcXYgJiYgIXRlZ3JhMjQxX2NtZHF2X2FsbG9jX3Zpb21tdShzLCBpZGV2LA0KPiAmdmlvbW11
X2lkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+IEkgYW0g
Y29uZnVzZWQuIEluIHRlZ3JhMjQxX2NtZHF2X2FsbG9jX3Zpb21tdSgpIGl0IHJldHVybnMgZmFs
c2UgaWYNCj4gYWxsb2NfdmlvbW11IGZhaWxzLiBidXQgeW91IHNlZW0gdG8gcmVzZXQgcy0+dGVn
cmEyNDFfY21kcXYgYXMgaWYgeW91DQo+IHdvdWxkIGZhbGwgYmFjayB0byBub24gY21kcXYgc2V0
dXAuIFdoYXQgZG8geW91IHRyeSBkbywgZmFsbGJhY2sgb3INCj4gZXhlY3V0ZSBlaXRoZXIgdGVn
cmEyNDEgY29kZSBvciBkZWZhdWx0IGNvZGUuIE9yIG1heWJlIEkgbWlzdW5kZXJzdGFuZA0KPiB0
aGUgdWFwaSBjYWxsIHNlcXVlbmNlPw0KDQpObyBmYWxsYmFjayBpbnRlbmRlZC4gQ3VycmVudGx5
LCBpZiB0aGUgdXNlciBoYXMgZW5hYmxlZCB0ZWdyYTI0MV9jbWRxdiBhbmQNCnRlZ3JhMjQxX2Nt
ZHF2X2FsbG9jX3Zpb21tdSgpIGZhaWxzLCB3ZSBmYWlsIHRoZSBkZXZpY2UgaW5pdC4gU29ycnkg
YWJvdXQNCnRoYXQgdG8gcmVzZXQgcy0+dGVncmEyNDFfY21kcXYgYW5kICF2aW9tbXVfaWQgbG9n
aWMsICwgdGhhdCB3YXMgYSBsZWZ0DQpvdmVyIGxvZ2ljIGZyb20gcHJldmlvdXMgaW50ZXJuYWwg
YnJhbmNoIEkgaGFkLg0KDQpATmljb2xpbiwgaXMgdGhlcmUgYW55IHN1Y2ggcmVxdWlyZW1lbnQg
Zm9yIGEgZmFsbGJhY2sgaW4gdGhpcyBjYXNlPw0KDQo+IEkgd291bGQgbm90IHJlc2V0IGEgcHJv
cGVydHkgdmFsdWUgaW4gZ2VuZXJhbCB1bmRlciB0aGUgaG9vZC4gSWYgdGhlIGVuZA0KPiB1c2Vy
IGhhcyBzZXQgdXAgdGhpcyBvcHRpb24sIEkgZ3Vlc3MgaGUgZXhwZWN0cyBpdCB0byBiZSBlbmFi
bGVkIHdoZW4gaGUNCj4gcXVlcmllcyBpdCBiYWNrLCBubz8NCg0KWWVzLCB0aGF04oCZcyB0aGUg
aWRlYS4NCg0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmICghdmlvbW11X2lkICYmICFp
b21tdWZkX2JhY2tlbmRfYWxsb2NfdmlvbW11KGlkZXYtPmlvbW11ZmQsDQo+IGlkZXYtPmRldmlk
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VX1ZJT01N
VV9UWVBFX0FSTV9TTU1VVjMsIHMyX2h3cHRfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlVMTCwgMCwgJnZpb21tdV9pZCwgZXJycCkpIHsNCj4gDQo+IElm
IHRoaXMgaXMgYSBzcGVjaWFsaXphdGlvbiBvZiBhbGxvY192aW9tbXUgY29kZSwgaXQgZ2VuZXJh
bGx5IHBvaW50cyB0bw0KPiBhIGNsYXNzIG9yIG9wcyBpbnRlcmZhY2UuIFlvdSBtYXkgZmFjZSBz
dWNoIGtpbmQgb2YgY29tbWVudHMgbGF0ZXIgb24gc28NCj4gYmV0dGVyIHRvIGp1c3RpZnkgdGhh
dCBjaG9pY2Ugb3IgYWRvcHQgYSBuZXcgb25lIDstKQ0KPiBzYW1lIGZvciBpbml0IHdoaWNoIGlz
IG92ZXJsb2FkZWQgY29tcGFyZWQgdG8gb3JpZ2luYWwgaW1wbGVtZW50YXRpb24uDQoNCkkgYWdy
ZWUuIEkgd2lsbCB0YWtlIGFub3RoZXIgbG9vayBhdCB0aGlzLiBBbHNvLCB0aGlzIGlzIHdoZXJl
IGFueSBoZWxwIHdvdWxkDQpiZSByZWFsbHkgYXBwcmVjaWF0ZWQg8J+Yii4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSBoYXZlIHNvbWUgaWRlYXMgb24NCmhvdyB3ZSBjYW4gaW1wcm92ZSB0aGlz
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

