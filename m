Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F5CC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 04:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUf87-0005BK-5F; Fri, 19 Jul 2024 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUf85-0005AC-Bs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:22:01 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUf80-0000I7-Me
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721362916; x=1752898916;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UA3eBAaXZYTYFwFsf1g2QbXlGgfNaE5TOC3r2xi7iO4=;
 b=IGOegm2MHF58yPZox5WWNbJvqEHAy4c2saDHeZSAK0YfqIgQ3OWNqgUW
 VyaU+88C/RL3VnzI3Qv2ZwUbZeMPGTPxuSaPgaRmpOzgCUXFxkcVW9IrY
 ceG4OpTbCGcQdhBEh4BdQuJSezp5K9vcu875Suw11T8oftjVkiAHNR2+7
 RtFgfyY8kgYvwxBGPzr7PJmz3gHSuWhozie8PqUCdYmLlx784YVmN/vfu
 b5ksZZTeux3+FpsGUFlt895msRXUjlSWbhMXM8u7JMYibRk0rRhzAfCEV
 mDSpNAoPTNhvg+tF4NVraJcAezy/pB3UIP73HC8jMQ8PwVGtZVE7pBMT6 g==;
X-IronPort-AV: E=Sophos;i="6.09,219,1716242400"; d="scan'208";a="16789399"
X-MGA-submission: =?us-ascii?q?MDGVKrDCV0RgtkhL1C1CYiWn8Bx0NL1c3CD2OT?=
 =?us-ascii?q?mZJymE+PnqDrpy8VaW4WdM9k/Fy/523m2ROGN05PzBVlzZys37LK2K3J?=
 =?us-ascii?q?X62t3hVC8zSZ/cwivuCdxz+oczmrIYFvXE1fszq3d6y9acqDCIpGfz0s?=
 =?us-ascii?q?kJOmEetdZfxthtdwpMrY4jtQ=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 06:21:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0vYZxCvLttY72yLLkVaZf0hMIdROHk7bl8WasZ53l+7u/grihWplAgeYEjnlV75S9abbuognHQJpqfoaV6A0W1b9OgI0CCnHiz4kWsd/rnfLjT9awn2nM0bLMQsBQ+QWi5OfKbR9OD3xrb75AC5bIdYXWTNilkdGOQlueDNUPyZGIQbGmTmgKv6o33/U8G45igb8AezrBa641I4OlT5IZF+51ROB56JVhJLjApz6jmYsjnUvfGE34MFFxvKuDXXtNkd4PCKSWI0yaVVkB03tbAheGjlW+51mgJn4LSLcO/XQWnhk7GJvel65cUIyttOK1Y3Ei2Bbe8Q9tqwaPZ7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA3eBAaXZYTYFwFsf1g2QbXlGgfNaE5TOC3r2xi7iO4=;
 b=XcyCGqrDau5f/ApS2zMN3rHRq3G5+sRj0NJJClU9VAqEZfzlGtxYHMxdOJ5SZJcasZRUm30z8g5yJpVI7PzXv4xQkTehK2Ozcm5+QSp7MEmSYYo84gjQGr3V8clKSQ1ObfO0SFoWbK1BorA336g9QYzjYhWi2eHhKZNmWUnfEhGVADQHrGtEk3V+dvyAk2Fo5PHDoh5aQTpVMHnq7VLOn3a1TQFsZ7FB2cEggdA4YpaJrDb2VJB+lqXseKJj2L0ZM7Dt9LdCUqvymmUCmIq2jp4f/Cm8yx1ysFE3dPEpDCPrFULUQnPLfLdTJI/kYQWIFaK4N9uclSkMsxETcwIUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA3eBAaXZYTYFwFsf1g2QbXlGgfNaE5TOC3r2xi7iO4=;
 b=SBg0N06a10RBiGbG3F/Kfw2zZmQ7A1DgUmtmdEp2HrEYtuQjTnGzO2eclvBCaRjD1MhZLtiMF2Ys6CoEW5Ob9MRsZiLtxPLH4QEUSEKCVrXjhBqWAucTsJLwqLxBgqqhtZ3juPoRe21XLWhrTbVm/FTIayusurKCTFNvI2nQXZ//6rnlHQceEqib/ojuvymQNjX288VW/7dovxLCqWXDQCK0VE+HmeTulo/KmKPJX0/Xu0+ZJ31JGdSgTQiPeKu/NRwtbUxWSTbPdgpQOcPR6TWL/XCW2PalmHe9XRFslILs6l1FsDAXcsyc4cme7RCOp/5RUyECLSEhzN6GqQk7AQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB10161.eurprd07.prod.outlook.com (2603:10a6:102:480::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 04:21:50 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 04:21:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2Os6jI53vxLunUO9e0sZTiatjrH8MI6AgAEpkACAABpjAA==
Date: Fri, 19 Jul 2024 04:21:49 +0000
Message-ID: <5ccdc1b5-8d77-4aa7-b1fc-3f03320e57d7@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB10161:EE_
x-ms-office365-filtering-correlation-id: f0249bcb-2049-4ad7-65ef-08dca7aa4f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bzc0VGphTTlPZVJ1ZWV5QzgzeHdpZjJrb0ZKU1hTdEtubzN4NjRESS8vWXdS?=
 =?utf-8?B?YnM3WldwSFdGdHJWdXUzVGpvQ1JLQXFQdi81RXVpSVk1UStnb3VqcDQySmky?=
 =?utf-8?B?Y2RTK0t1eDRGQzVHelNNdmVXMUtJNE5weHNRcVJpMU1uQkJHRXNKa25KTjZ4?=
 =?utf-8?B?UVF0Tmx0Ykd3Y0w4UnB0c0dzS0NtZFFNZ0RGTWpXSkVrMlNucFEyUmw0bWZK?=
 =?utf-8?B?bXUxUzBQV1JmTHNjaVR1Z3FnRUJBQ0RuK1RKMUxHN29UUVlYOVVPbG5MQ25O?=
 =?utf-8?B?dFdFK3RoMVBjZnFVenhOT3R6ZVU1cjdPNUJiQUp4RU1QN0M3d0xFKzRFZUk2?=
 =?utf-8?B?VFZVUFQrKzEzVDBqWWlBVjRXc2tZNE1aeXJTM2pvQXNVaDFzeDF4S3JzWXpQ?=
 =?utf-8?B?VG05RE5SNDREMHVhY3ltSjRTdzBxRlowbU9vdEJHdzNTbXRVTnpIbEYwMHYr?=
 =?utf-8?B?dVZ0azRYUkNobjE2YW9odWJ4cHVUOW41WWVZd2lUb1VxQkZBeThWQzZZNE1F?=
 =?utf-8?B?NkNyaUUwNGYyZG0vSHkyOXA2RXpRVW1CZ21VRnRjVmVGait5eEpNeXpTMzRP?=
 =?utf-8?B?bksxUFNjTlkraEdZYVFvR2tSc0hqa2RqRkZVak9meUw4d1h5Mms5YWswcXRr?=
 =?utf-8?B?UzcySW53T2M0V3lTR3VqRE9hNnZ1NHFrRjRFQ1RSWm1rM3QwU1NrZ3NMR1gr?=
 =?utf-8?B?SW9nZGJsM1NEL1dUNjF0czBaUm9WZTFEc2MySmczTFZIQ1JObVVjYTQzd3BF?=
 =?utf-8?B?eGp4K0NuUjd6WHpSME9aWFo5ZE8vc3c4eU85QXFrWGpLL3Z3QUM2SHkwVVJw?=
 =?utf-8?B?UmR5bC9LYkYvWnJ2cHV1SGxlTHJmMWZuMWkraVMzSS8rYVMyRVVYOFMyNTFj?=
 =?utf-8?B?UTJBTXQ0TE5DMWFUbkIvWFVUS2gwaWo0LzJUMHR0L1lRZ09EdVlxakdMOFRC?=
 =?utf-8?B?UnJoZCt6clNIWWtHUVo5Sk52dkJLK2swa0d6UEJHbmFUb2JiYldBUHZ0MHVp?=
 =?utf-8?B?MDY5MzlrQ3BvOFVmSWpaMFJjTlFRQ0Q3YkltSXJKbE5JcWJFQjY4N1BFMk4v?=
 =?utf-8?B?ajdlZG1YQWlUSnAvWWZYeWx0ZG5rQWVxSjBvWkwzWWdUQjh4SENwMDNDTFVO?=
 =?utf-8?B?dWJMZGh5dFIxSkZSaHN1dUFsSWpDT0EyUjR3dmNkWnBITkxzWW14MkJiVjVs?=
 =?utf-8?B?YUJnZnRlK0xHSWE5ZEt0ZjZ6dnpoOW0zL1dtelVIdXdUY25BcWY5L1lIUzVB?=
 =?utf-8?B?RVBVcStRekdsTzl5MkZ6OU9tTmN6Vm1oQWxpdzNzNHh6cTdWaTJSVXk5cktS?=
 =?utf-8?B?ckhGeXowUG5ZTzlWRC9iWG5uSEhHcG5kS2dEMVpzQW1pOUVBUVRYa0FnRTBR?=
 =?utf-8?B?WG5kU1lXSlZURDFmTGhZN2FSY0Mra2VtcmxjNW1mTmp3Ui9UM1VxUFZXVkpk?=
 =?utf-8?B?OUV2dU41RWlHclVrK216Mm00ZHFXMlpySlFvcW1qQXJNMXg0YWxyQk1zbVVz?=
 =?utf-8?B?OWZYdVRqZmxiS3RHTHZuN1FxTHVOVEtoUHNBb2NNTU01QjhDRVlDb0Q0ZTZH?=
 =?utf-8?B?bGt5UU9iTG9TNm9xeWhpTUFEQ2RYeVdMR2ZVbTdYb3REcGozUkg5MFN4VFZG?=
 =?utf-8?B?TkthV1N3eitrWk9NYWF1Y25ENUhweWxYY3lueUlNbGZmYjJQYXBQOUkvODU1?=
 =?utf-8?B?ZzFwTURSd1NyaWV0OGE2MWk2dnRjcml5TVQ0MWpHZGRUREFxdjZXQy9QQlNJ?=
 =?utf-8?B?M210REF0clhQdnNzd0s2K2hKOHUxYzJmTVlESUtGVk1lK0gzaUtqZ0RreUcx?=
 =?utf-8?B?Zm12WStTb3hxY1B5ZkpIZ2JRQys5UGpTeCtGQ1lGOTRGeTNoTnBQOC9ZQUsx?=
 =?utf-8?B?eWNuSlRMQ0YwY0tyN0ZlcW5WaGhPR3FVRmF0NHBoT242L3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDk2S2hjenRTZU1pSzBTbnl3a2cvSXFNTmpjR0twdDBhNE1za2UwZk5zeW5i?=
 =?utf-8?B?QW1pcmtrNnJlSlZkOUhJYXoyMGdNYVgvS3FTT1FiZFVjWUlmL014Q0prV1M4?=
 =?utf-8?B?STd6WjlYb1FvVURHU25qUWxmYkZjYnpuWkV3VUpxTU1MUGkrMkwzZXE3ZDVM?=
 =?utf-8?B?cTcwUW5BQXk0cTdNMWFqWVhwaERiM0M0R2hXUmNvRmluZXVzK0l0L2xXemJy?=
 =?utf-8?B?RFl2bFJRb1J0M1ExdzVYTUVqaHpBR3QrV1pOTHdFaVl5SmlxaGFXaEtYOVVF?=
 =?utf-8?B?cG9URTkzb2FKSVV2eFlMRFlzVzNEWmpVeUJMVjJDbnNEVGE2SkhEK3hOay9u?=
 =?utf-8?B?LzFjR0NOck9GNjM0VTI0THA0NksvY0RQb29uV0hBdm8vWnNwdi9ISWdodTlz?=
 =?utf-8?B?Q2ZsSG5kTS95SlFXUFd4WnNFdk5MbEVoYTE3K3ZUa0d4eEpiSzByUVlVRnpZ?=
 =?utf-8?B?Rk14SjNLWEZPbzd0dzZrZ1MzaTBOZ25DUE9KNTZkaGRoTG1tL2IvdWNwalZs?=
 =?utf-8?B?L2pIL1YzWmZub1BBQ3hGaTgyMEhFTGlCSTd1RnVvU2tVMFlIYmZaaHR6Q1VJ?=
 =?utf-8?B?U1FOT1JsZXh0SW0ybjFwdHg2S2hJUlNKYXllZU1uS0s0OXovenlEcFhyVWYw?=
 =?utf-8?B?WkhDTDArZmpYVVhLMXU1WTI5K2ZPa0RIM0NmVzlIWVpZTFEyNFZOMjFadGFJ?=
 =?utf-8?B?N242aW9Zd1dJa1J0V20xUStWY1pJRVVqc0RiL2ROWTlQSUFYV2k4MmZ5TTNE?=
 =?utf-8?B?YWVIZFFONllIZHhzbzQ2aFNkY3pnbVlqaWVrdjRJeXJDTXNaWmZCd2g3N0Q3?=
 =?utf-8?B?U0hOSi9nV3RwYytpcDUrZm1HVUh3Z0R6WTdCempkYXI4YzgwY09tUXY1NVV5?=
 =?utf-8?B?THhIOVZkOG1IVHRwTWovNnM1MTh4amFZbm5IYUlPQndlakppbzhsVEw1T0Ju?=
 =?utf-8?B?ZysrQ2tFaEpKdUJUU3hmaWwrRTM5RjFjN1dlR3hPSmhFeC8rR3JiZFBDQkd5?=
 =?utf-8?B?Sys4SkZ3ZHJMQmlNMnd5SVB0QzFJd1Axd290S1RrUU1jZWlhZEtqZlNNSE11?=
 =?utf-8?B?blhFUDMrUmRCQ29MYXRCOC9td0NxeDd6L0o0ckpjbGNKVVRQcm1VM0NaeEJz?=
 =?utf-8?B?WGNkR1JOWHBMMWVtY0ltZ3U2cWFTVzNrZXZhcXpMZk9RcTk0T3NoZjNyNktH?=
 =?utf-8?B?Qmo3Mzc4eEI5NkloOGhGVGxpQTBRYjl2ODJqL0VpeEU2YVo2UE8xZmNUR1Ny?=
 =?utf-8?B?bmk4cXpCVGxWZjJReUVWNXU1NWFFZFE5ZzBkMTgxL296TmlOK2FmdWd6c0dN?=
 =?utf-8?B?QzdYM091dHAwekZWcEE0NGFERUxPWWQ2TGJDQVFXU1h5emQva29oTlBqbVdj?=
 =?utf-8?B?aG9lNTFPbnp0YzJPaE5GRS9Da25ZZjRwaXN3YkovUEJHNzJrSk4vcUpGWTZ5?=
 =?utf-8?B?S0c4cGZnNS9EbCtSeTdBd3pNOFdiUjBNMXlyekdBUU1xQ2QrU2dadDFMdVdr?=
 =?utf-8?B?TFByOTdZczdEMk5UTXY1dDZXNTdJSzg5MFVGRkJ4Tjc1S285Y1pwLzNRS29M?=
 =?utf-8?B?aFdmbStDY0YzMkpoVjFpWHpCa3FXVTlHSTNQN2FqcTc3TnVZTCtDVXBpNWto?=
 =?utf-8?B?NjJDRFVOVWU2QTM4TTVZSEt5KzZZYnRRS0lEa3FsNFIvR2dCbms2WndzOGdm?=
 =?utf-8?B?SDVhMzg5OC85NmNlSytTWG1TZ0pQTkNGMWhHeHM3aU9EQ0JIalBjeEZjeG9J?=
 =?utf-8?B?ZndHT3Zwa1ZxUHliUVFQUWZNdURGeUI0UCs5cDQvUzJEa0lkSlV0TzRFNkF4?=
 =?utf-8?B?ZkRmS0dJSEl0ZUVNV0dKejJLU2Jtd2JHSDQ1Mm5mY2creHI0c3htTnQyb1o0?=
 =?utf-8?B?ZVIyWjMrYlQvQTQyUjFIMitMOGVLc2wzb1ZPeUY3ZElFM2tXSDJmMnNNZDBL?=
 =?utf-8?B?Y2l3SEhib2JHbEFIV1ltbzNualNvYUNaSmVteUJXWFkvbHg4d3NEQ2locVAx?=
 =?utf-8?B?bG9NUjk3cDd3UURkUC95VDFMdm1DWlBPT0FXdFM1aElrTXI4c3ZuK1lLN0ps?=
 =?utf-8?B?dDNSSmVLbndxU1QwUlprcGxxL3JHcnpqNHFKTmVETGtGUjRudGJ3UUdhWGxG?=
 =?utf-8?B?RTZDZGtqYS9NcUI2bjdXY3NsVnZLbkloVUk1dmVSdDdDT2I4TjRweHpNREZr?=
 =?utf-8?Q?/WFh3Wz9moSm4p0ANoeM+mQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D914FDA10AA54D80ABFCBA089C2609@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0249bcb-2049-4ad7-65ef-08dca7aa4f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 04:21:49.8576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9UjzCKaPwWRqm3CiF+JRKXuHH9+xY6GpLt2kIGmMHSbPuUyqzttDvRCiSbJxkAI1TEGAc+kP3xuVWoJK8lPpB5kjYjH5yKG0V/1Lx74Eba5oYlwRJTGZB7iKnRMaTBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10161
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

DQoNCk9uIDE5LzA3LzIwMjQgMDQ6NDcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAzLzE3XSBpbnRlbF9pb21t
dTogQWRkIGEgcGxhY2Vob2xkZXIgdmFyaWFibGUgZm9yDQo+PiBzY2FsYWJsZSBtb2Rlcm4gbW9k
ZQ0KPj4NCj4+DQo+Pg0KPj4gT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPj4gZW1haWwgY29tZXMgZnJvbSBhIGtub3du
IHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pg0KPj4+IEFkZCBh
biBuZXcgZWxlbWVudCBzY2FsYWJsZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrIHNj
YWxhYmxlDQo+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4cG9zZWQgYXMg
YW4gaW50ZWxfaW9tbXUgcHJvcGVydHkNCj4+PiBmaW5hbGx5Lg0KPj4+DQo+Pj4gRm9yIG5vdywg
aXQncyBvbmx5IGEgcGxhY2VoaG9sZGVyIGFuZCB1c2VkIGZvciBjYXAvZWNhcCBpbml0aWFsaXph
dGlvbiwNCj4+PiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBibG9jayBob3N0IGRldmljZSBwYXNz
dGhyb3VnaCB1bnRpbCBuZXN0aW5nDQo+Pj4gaXMgc3VwcG9ydGVkLg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+PiAtLS0NCj4+PiAg
ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMiArKw0KPj4+ICAgIGluY2x1ZGUv
aHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAxICsNCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11
LmMgICAgICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+Pj4g
ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gaW5kZXggYzBjYTdiMzcyZi4uNGUw
MzMxY2FiYSAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+PiBAQCAtMTk1LDYg
KzE5NSw3IEBADQo+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFV
TEwgPDwgNDApDQo+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDMpDQo+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDYpDQo+Pj4gKyNkZWZpbmUgVlREX0VDQVBfRkxUUyAgICAgICAgICAgICAgICgxVUxM
IDw8IDQ3KQ0KPj4+DQo+Pj4gICAgLyogQ0FQX1JFRyAqLw0KPj4+ICAgIC8qIChvZmZzZXQgPj4g
NCkgPDwgMjQgKi8NCj4+PiBAQCAtMjExLDYgKzIxMiw3IEBADQo+Pj4gICAgI2RlZmluZSBWVERf
Q0FQX1NMTFBTICAgICAgICAgICAgICAgKCgxVUxMIDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkNCj4+
PiAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fV1JJVEUgICAgICAgICAoMVVMTCA8PCA1NCkNCj4+
PiAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVBRCAgICAgICAgICAoMVVMTCA8PCA1NSkNCj4+
PiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAgICAgICAgICAgICAgKDFVTEwgPDwgNTYpDQo+Pj4g
ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOICAgICAgICAgICAgICAgKFZURF9DQVBfRFJBSU5fUkVB
RCB8DQo+PiBWVERfQ0FQX0RSQUlOX1dSSVRFKQ0KPj4+ICAgICNkZWZpbmUgVlREX0NBUF9DTSAg
ICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQo+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfSURf
U0hJRlQgICAgICAgICAgMjANCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVs
X2lvbW11LmgNCj4+IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+PiBpbmRleCAx
ZWIwNWMyOWZjLi43ODhlZDQyNDc3IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oDQo+Pj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+
PiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4+DQo+Pj4g
ICAgICAgIGJvb2wgY2FjaGluZ19tb2RlOyAgICAgICAgICAgICAgLyogUk8gLSBpcyBjYXAgQ00g
ZW5hYmxlZD8gKi8NCj4+PiAgICAgICAgYm9vbCBzY2FsYWJsZV9tb2RlOyAgICAgICAgICAgICAv
KiBSTyAtIGlzIFNjYWxhYmxlIE1vZGUgc3VwcG9ydGVkPyAqLw0KPj4+ICsgICAgYm9vbCBzY2Fs
YWJsZV9tb2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBzdXBwb3J0ZWQ/ICov
DQo+Pj4gICAgICAgIGJvb2wgc25vb3BfY29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBT
TlAgZmlsZWQgc3VwcG9ydGVkPyAqLw0KPj4+DQo+Pj4gICAgICAgIGRtYV9hZGRyX3Qgcm9vdDsg
ICAgICAgICAgICAgICAgLyogQ3VycmVudCByb290IHRhYmxlIHBvaW50ZXIgKi8NCj4+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
Pj4gaW5kZXggMWNmZjhiMDBhZS4uNDBjYmQ0YTBmNCAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAt
NzU1LDE2ICs3NTUsMjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+PiB2dGRfaXNfbGV2ZWxfc3Vw
cG9ydGVkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDMyX3QgbGV2ZWwpDQo+Pj4gICAgfQ0KPj4+
DQo+Pj4gICAgLyogUmV0dXJuIHRydWUgaWYgY2hlY2sgcGFzc2VkLCBvdGhlcndpc2UgZmFsc2Ug
Ki8NCj4+PiAtc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBlX2NoZWNrKFg4NklPTU1VU3Rh
dGUgKng4Nl9pb21tdSwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZURFBBU0lERW50cnkgKnBlKQ0KPj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BlX3R5cGVf
Y2hlY2soSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gVlREUEFTSURFbnRyeSAqcGUpDQo+Pj4gICAg
ew0KPj4gV2hhdCBhYm91dCB1c2luZyB0aGUgY2FwL2VjYXAgcmVnaXN0ZXJzIHRvIGtub3cgaWYg
dGhlIHRyYW5zbGF0aW9uIHR5cGVzDQo+PiBhcmUgc3VwcG9ydGVkIG9yIG5vdC4NCj4+IE90aGVy
d2lzZSwgd2UgY291bGQgYWRkIGEgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBleHBlY3QNCj4+
IHMtPnNjYWxhYmxlX21vZGVybiB0byBnaXZlIHVzIGVub3VnaCBpbmZvcm1hdGlvbi4NCj4gV2hh
dCBhYm91dCBiZWxvdzoNCj4NCj4gLyoNCj4gICAqVlREX0VDQVBfRkxUUyBpbiBlY2FwIGlzIHNl
dCBpZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaXMgdHJ1ZSwgb3IgZWxzZSBWVERfRUNBUF9TTFRTIGNh
biBiZSBzZXQgb3Igbm90IGRlcGVuZGluZyBvbiBzLT5zY2FsYWJsZV9tb2RlLg0KPiAgICpTbyBp
dCdzIHNpbXBsZXIgdG8gY2hlY2sgcy0+c2NhbGFibGVfbW9kZXJuIGRpcmVjdGx5IGZvciBhIFBB
U0lEIGVudHJ5IHR5cGUgaW5zdGVhZCBlY2FwIGJpdHMuDQo+ICAgKi8NCkZpbmUgOykNCj4NCj4g
VGhhbmtzDQo+IFpoZW56aG9uZw0KPg0KPj4+ICsgICAgWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11
ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4+PiArDQo+Pj4gICAgICAgIHN3aXRjaCAoVlREX1BF
X0dFVF9UWVBFKHBlKSkgew0KPj4+ICsgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0K
Pj4+ICsgICAgICAgIHJldHVybiBzLT5zY2FsYWJsZV9tb2Rlcm47DQo+Pj4gICAgICAgIGNhc2Ug
VlREX1NNX1BBU0lEX0VOVFJZX1NMVDoNCj4+PiAtICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+PiAr
ICAgICAgICByZXR1cm4gIXMtPnNjYWxhYmxlX21vZGVybjsNCj4+PiArICAgIGNhc2UgVlREX1NN
X1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+PiArICAgICAgICAvKiBOb3Qgc3VwcG9ydCBORVNURUQg
cGFnZSB0YWJsZSB0eXBlIHlldCAqLw0KPj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiAg
ICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfUFQ6DQo+Pj4gICAgICAgICAgICByZXR1cm4g
eDg2X2lvbW11LT5wdF9zdXBwb3J0ZWQ7DQo+Pj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRS
WV9GTFQ6DQo+Pj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9ORVNURUQ6DQo+Pj4gICAg
ICAgIGRlZmF1bHQ6DQo+Pj4gICAgICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8NCj4+PiAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiBAQCAtODEzLDcgKzgxNyw2IEBAIHN0YXRpYyBpbnQN
Cj4+IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+
Pj4gICAgICAgIHVpbnQ4X3QgcGd0dDsNCj4+PiAgICAgICAgdWludDMyX3QgaW5kZXg7DQo+Pj4g
ICAgICAgIGRtYV9hZGRyX3QgZW50cnlfc2l6ZTsNCj4+PiAtICAgIFg4NklPTU1VU3RhdGUgKng4
Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7DQo+Pj4NCj4+PiAgICAgICAgaW5kZXggPSBW
VERfUEFTSURfVEFCTEVfSU5ERVgocGFzaWQpOw0KPj4+ICAgICAgICBlbnRyeV9zaXplID0gVlRE
X1BBU0lEX0VOVFJZX1NJWkU7DQo+Pj4gQEAgLTgyNyw3ICs4MzAsNyBAQCBzdGF0aWMgaW50DQo+
PiB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+
ICAgICAgICB9DQo+Pj4NCj4+PiAgICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBjaGVjayAq
Lw0KPj4+IC0gICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayh4ODZfaW9tbXUsIHBlKSkgew0KPj4+
ICsgICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayhzLCBwZSkpIHsNCj4+PiAgICAgICAgICAgIHJl
dHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVjsNCj4+PiAgICAgICAgfQ0KPj4+DQo+
Pj4gQEAgLTM4NjEsNyArMzg2NCwxMyBAQCBzdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRl
bElPTU1VU3RhdGUNCj4+ICpzLCBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+Pj4gICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+Pj4gICAgICAgIH0NCj4+Pg0KPj4+IC0gICAgcmV0dXJuIHRydWU7
DQo+Pj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+ICsgICAgICAgIC8qIEFs
bCBjaGVja3MgcmVxdWVzdGVkIGJ5IFZURCBub24tbW9kZXJuIG1vZGUgcGFzcyAqLw0KPj4+ICsg
ICAgICAgIHJldHVybiB0cnVlOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIGVycm9yX3Nl
dGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVuc3VwcG9ydGVkIGluIHNjYWxhYmxlIG1vZGVybiBt
b2RlDQo+PiB5ZXQiKTsNCj4+PiArICAgIHJldHVybiBmYWxzZTsNCj4+PiAgICB9DQo+Pj4NCj4+
PiAgICBzdGF0aWMgYm9vbCB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZv
aWQgKm9wYXF1ZSwgaW50DQo+PiBkZXZmbiwNCj4+PiBAQCAtNDA4NCw3ICs0MDkzLDEwIEBAIHN0
YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+Pj4gICAgICAgIH0N
Cj4+Pg0KPj4+ICAgICAgICAvKiBUT0RPOiByZWFkIGNhcC9lY2FwIGZyb20gaG9zdCB0byBkZWNp
ZGUgd2hpY2ggY2FwIHRvIGJlIGV4cG9zZWQuDQo+PiAqLw0KPj4+IC0gICAgaWYgKHMtPnNjYWxh
YmxlX21vZGUpIHsNCj4+PiArICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiArICAg
ICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9GTFRTOw0KPj4+ICsgICAg
ICAgIHMtPmNhcCB8PSBWVERfQ0FQX0ZTMUdQOw0KPj4+ICsgICAgfSBlbHNlIGlmIChzLT5zY2Fs
YWJsZV9tb2RlKSB7DQo+Pj4gICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBW
VERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPj4+ICAgICAgICB9DQo+Pj4NCj4+PiBAQCAt
NDI1MSw5ICs0MjYzLDkgQEAgc3RhdGljIGJvb2wgdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01N
VVN0YXRlDQo+PiAqcywgRXJyb3IgKiplcnJwKQ0KPj4+ICAgICAgICAgICAgfQ0KPj4+ICAgICAg
ICB9DQo+Pj4NCj4+PiAtICAgIC8qIEN1cnJlbnRseSBvbmx5IGFkZHJlc3Mgd2lkdGhzIHN1cHBv
cnRlZCBhcmUgMzkgYW5kIDQ4IGJpdHMgKi8NCj4+PiAgICAgICAgaWYgKChzLT5hd19iaXRzICE9
IFZURF9IT1NUX0FXXzM5QklUKSAmJg0KPj4+IC0gICAgICAgIChzLT5hd19iaXRzICE9IFZURF9I
T1NUX0FXXzQ4QklUKSkgew0KPj4+ICsgICAgICAgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FX
XzQ4QklUKSAmJg0KPj4+ICsgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgIlN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJl
OiAlZCwgJWQiLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BV18zOUJJVCwg
VlREX0hPU1RfQVdfNDhCSVQpOw0KPj4+ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+IC0t
DQo+Pj4gMi4zNC4xDQo+Pj4NCg==

