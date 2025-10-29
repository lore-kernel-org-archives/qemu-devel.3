Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA996CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3mi-0007V8-UY; Wed, 29 Oct 2025 06:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mg-0007Uh-Aw
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:06 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vE3mT-00020L-67
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1761735113; x=1793271113;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=2ogMOX+4F/WbfGBPJMZGxiXat5h+o7Afe2y/iWadBX8=;
 b=DNh9/RtfOSJ/17vhpeKJsX1zhYBMT+gpieTpSUpli1drtrB/nQ081slG
 c6c41z4Y9tdVUr5ETfN5NqKVPIrtuEEUT6o2rFTLzX4xe2cfVrOF0SPUu
 ajyb09jT7xAhX4cz2HBXdIPVTflp8nbgbJ4ocKIPUMfYNWuKyN45WicjF
 depMGSjpzRvREEYJ1o5jfzs1DzETRCoquncGJ//+P2aotjVsOhcRs3FGY
 xSaT3p5SWxElGQOrBDPLBXm3OLV09vdPzyfHnFzYKuBk67ngMWjzoA3aF
 iTNl4q2c6VV4bt5XI05RL6cxrCTw9ihEpMdHa592vbyNk2oT49406nc25 g==;
X-CSE-ConnectionGUID: ATv4aZzgRDmAUwzH9hL3SA==
X-CSE-MsgGUID: wiXSwWldSK2rjWvy61or9w==
X-IronPort-AV: E=Sophos;i="6.19,263,1754949600"; d="scan'208";a="44193189"
X-MGA-submission: =?us-ascii?q?MDHDylnP8/gHsgisGPPMOQRJzqKRrGd35frDcy?=
 =?us-ascii?q?xXcRtCNmHDXC9rlKtA1IcFIH14K449Iqbhp1SGfIZSrVo1KMtninpdwk?=
 =?us-ascii?q?La/bhRXylsmoWBPyGU9HsR5loXuz0+ynznlsHqXaog3lifQhQ5mu7WPl?=
 =?us-ascii?q?JYfTGfrZ/8Zo/kFCfbzpglhw=3D=3D?=
Received: from mail-northeuropeazon11011056.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.56])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 29 Oct 2025 11:51:43 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgZJH9iB3UJHt5EV8AnBr3+R0zVZHDynjRBY7WwQ6LsPnEgikCjomS9Af4nOSP1RwkxOtKecKRi4S8Gv6NH4yfWQOoMPUhFiUiwECLDEFBLa+8aYwUQ48D9hhXq0YgCVxWk8CS8rzt3azXaLqJUA95B/kMRtLRsVbZCU7tkQ75PjQ09Ghea6T57U0QHHp1mT8rVgyX/jEovLe/N73AS7q4TlzAKbwF2dkdPlBVrpR3PVzkOCNPF/xEZu3XevBu44xFFADSWIX286lntAWGW4x4d1W79tfb7QRV+meb7LtS8uD/qSmC6R0CQEX7F4O2UWzIIHv7YWYZ+Li4ajN+apXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ogMOX+4F/WbfGBPJMZGxiXat5h+o7Afe2y/iWadBX8=;
 b=ccfp1djJMoEh8HOfFpq8CoaMngxzcj5QKYh0EzgSVts1zOskpNwHaENN/SI2UNZE8tjpw3Ne2k/grRzEs8/4MP1HY6QctPR966Slf+IKZHIo/r9xsYGIs1DazyKwUJKFVXw6hlRidT7phaTRw9TCOP+IsbIORhAuhd79AuxMOqA7RsmJUCRyQExuYLk1oUzqdwqMwuc8HahLS+fwTC8mX65JgRaanxxM9HZW2t5Obl3YD3yBqUuqCSWjLP3AWw4GtRu+bOV1wUOHdoHI7igwaWQtvfCcQzQpKAslam3bapGSaCn2OcRfpgBSe/HwrI4ABZE1jllRNHAyjcgLbfp7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ogMOX+4F/WbfGBPJMZGxiXat5h+o7Afe2y/iWadBX8=;
 b=SN+xXF2drB7QTVBFqe+6Sj2eCFUc+Ti6USDZhZun+2Jh10AizaMhVnfTekTphg0Xe0lr9OQS2NxUbKNQX6gEHM/xz4SW8T2q8HFFCTgnHyK5G9tDxCQyq5MJswbk7Ho3C4QyTl+uvsa5aUznC1m+nxsNpNe7CYYFehMyiY/VPIti+34wLUY5Y7mHzlBCVCN8iLf9JAaJ4Q5EqXu/CWz2wqj0Bx5QIk7w21JFf9fVi2MFvn3UQD+CpfbBIJRH9yIkzWRP47I2LdBCa59zTCUQFud7jNGBeY2YdOZRi3wXWy9YfCkU5PFZfHiu8fqGsQqoDGMqSfJt32Yz2UJjQHuFXw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI0PR07MB10962.eurprd07.prod.outlook.com (2603:10a6:800:2d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:51:40 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9228.010; Wed, 29 Oct 2025
 10:51:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 0/7] intel_iommu: Add SVM support
Thread-Topic: [PATCH 0/7] intel_iommu: Add SVM support
Thread-Index: AQHcSMIB51nqrKdcBkae6np7FCSvXw==
Date: Wed, 29 Oct 2025 10:51:40 +0000
Message-ID: <20251029105137.1097933-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI0PR07MB10962:EE_
x-ms-office365-filtering-correlation-id: 369f2936-1caf-4b43-c9bc-08de16d92425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VkpXb2xxZGpzUlgzZWkwTURYZkhac0dCU21KYXE5b0NlY0tXZkQ4SFg3K1lI?=
 =?utf-8?B?QnZhYUJ1ek5LbFVKMS9jTkJlSTlJTGIrbTduTjl6SFdFSVFUM3JWMTE3YjBs?=
 =?utf-8?B?U3k5OHhyK0RpdmpEbm9Fcnlja3h3eGw0ZTRkaGlYMnhxdXRiLzdpRENxR090?=
 =?utf-8?B?ZUpodFZSc1F2dzMxTlhoOEx1TSt5aGpIb2VsbHdlV1dsaG11OHhMT1djeTh2?=
 =?utf-8?B?WGpxb0RFbzg4WWlxSXhVcWdNMTFzaENRRTZIaExpaG5WTEpBRHhNc1BMVVhL?=
 =?utf-8?B?NkxLUGJKM3Zqb2h0NWZ1SnZzSGhieDl1VDJ0SFU0MzVyQzBNUVRKeFh6L3h2?=
 =?utf-8?B?aUNHdGY2T0ZSYnI1U2JCdFU2VndHaGo4Vjg0Y3EzdkdGV3Nkb0FjN1dVMmZF?=
 =?utf-8?B?clR1QUNxRmFDeFhya2hzcnB4SHBWR3pRTk1jMWMxclZTRDMxeXNic2piUTQz?=
 =?utf-8?B?blRaM2NWMnFvOUQxbXNMRS8ybnUvSnR5UGFYbUY2WmJOQ0JlWjNwTHZ6dEJr?=
 =?utf-8?B?SDNJSE9pR0NyUkc0eTYvbG9QWXR0MlBWUmFxUzZiZGF6cStpQTIwVUN2Q3R0?=
 =?utf-8?B?Z3Fkdnl2U21oSEN3VjZyWEx3WXN0a0lPRkJ2T3hiSjg4RWJzZXlmU01CeE9R?=
 =?utf-8?B?bkpCeVpNY1Z4Y0VuVlROMUhaMTBEaHhzRGxRUDZRUVdXcjkweU1xMlNoWEdi?=
 =?utf-8?B?K2ZxaC9Pc2NCLzVQbVlYelFFYU55MVZ0VGNMUExqRTA4Y2VVK2JxVDBsV0lM?=
 =?utf-8?B?aGhoVVNINkhyNE92bHFoZUluRzJKWGFZejYxZWJsV2xZOWMwOHMzdnYraklh?=
 =?utf-8?B?RG1xek1yNjRNeE9TbGFpWG1FV1BBZnhGNlM0V3V3UmFldkphRzNjaXpoTXBX?=
 =?utf-8?B?azByY3h6Nk50WUJUYXJGcjhOcGg5czAwL1JuWHVQSkpMa1dLdDAyR2lwbzAx?=
 =?utf-8?B?VnQ3bWQ1Nlh6NnY1dlQ1TWVXUnZKdktzSUFHcVlFWFl3UnovaEI5TG9RdkMw?=
 =?utf-8?B?SnlRSWt6VXhsd2pDbnVwRmtlUDZSVFAwT3VyZnBtWnpaNmFWREdhemY4VzlB?=
 =?utf-8?B?OThMSFJwcWp1WDJpdnpkdnFraCtQSnUrY3RjUzY5bUdyWUZiNXpyakIxQTQw?=
 =?utf-8?B?QTR0WE1LQmh6S3padXQzRGRkbko5V01wdGpuZjd4VEM3dUFxQXh4cTlOQUxz?=
 =?utf-8?B?WHRoRVNjelJzTzU3dWlNRDhMWnRINHpzTm1CeFRzU2l2Vi9Ka2hTcnY1OGZY?=
 =?utf-8?B?VDZSZUlKMXkrQmdwVTRCT0ljN1VWelVvOXMzOHZEdTB2TVVCcmIxVFpmTTRN?=
 =?utf-8?B?YW1VZTkxN3FCZVVqZVZLUXF4aU5iRFdnRUozckZRUG5mSThGNHN3a2hJNlRo?=
 =?utf-8?B?WUhvUzltV3ZNS0ZEVXpxRWkvRCtNdk5hWS9KL0FrY3hNa3JKbGE3QWh3dW9X?=
 =?utf-8?B?V0lnampsWHNwZmtRbXU0T0lCV0hMa29qUmxhdnB2U3dwNHR6YTZ0NzRLckFi?=
 =?utf-8?B?N2g1ZzFMcFd3RnZGTGZIUFhUbHRMZ0ZqSTN4ZTVORi9qU0Z3SnNiTWRGV2dR?=
 =?utf-8?B?clJyMExnc2NXdXVTVkNrRTYwL0wzeUp6Qkh2VS9PczRCNEo0cnV4OUptWE9y?=
 =?utf-8?B?Tmt6ZVJ5ZUUxSGRaYVRnRjc1ek9yd2N4ODZYSjFldU9IemVHYUQyWEdQeFdL?=
 =?utf-8?B?NXlsNlBUYlhyQU1FcEdtY1dpL2VYUEN5V0RXWVB3MHdrWWgrVUxuQ0FoMk5W?=
 =?utf-8?B?Y2E0MkhNZWw2eVdWRjJFbitxWkFteW1tcERmdEQzRWUrVVlQZ3c4Q2pOSU5i?=
 =?utf-8?B?dDB0ODVhOFpLM0pRbDJ6WERYNDdPYlpFT2VETEJPNWV0VUhyUk52SmZnUldC?=
 =?utf-8?B?ckFTMU5UNG9PMTczbVV2VzdVWVFLT3RHSzFGd1R4b2JFTFRsK3pzU3VuU3hn?=
 =?utf-8?B?NC90N2ZxVU4rMFZqSTNvMXgySEFuU1UveUtGeiswajI3UVN4MkJSNHdtZ0Z5?=
 =?utf-8?B?Vkl5SXR4K3FGOEFOTWtmMU1FOVN1TktVSXZQNm80QkcxYlNRWmxWNGVKdE9x?=
 =?utf-8?Q?Spq0fw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnBmYldpK3NhNDk3bXFhZ1hieGpvK1NaeGtGL3kveCtVK2VrQURneWpyNTdv?=
 =?utf-8?B?SHRrS3BYRHFLcjV5ckVmaGJDcWVlNHFic1VsMGQ1RTZXNHp0M0lYZnR3YjM2?=
 =?utf-8?B?bkJWZFNFL1ZPYVZzTDNjR1RLNzNoQk1QK05pMzJyRW40ZUZZQkxRWmdYaVVS?=
 =?utf-8?B?TXZOZDBkVDh5amk0UHZEU05MQXdVZUZvOUZMb2kxb3NPOVlnSlIvL2NYUkFM?=
 =?utf-8?B?N2xRNmkxQUp5cytQNVhtSDNGY1VPam5XcTdORncwMVV1YXBUMSs5UEZxTFRq?=
 =?utf-8?B?YjNNN0NScms2MWJ6TEt4ZXhqbThPQWVEcHVjeUEva1lFTEdrYTNFTk1IS3o4?=
 =?utf-8?B?bFBFZ2hBellzOSt6U3IxUWZ0dERWTk1sajcvS29rTTZGMkgrZmxnQmlwdXNU?=
 =?utf-8?B?WnR2RVAyYW1TWGRIVUZoUzhheXdxVUI0Vk40bnROTnFOK3Q5Vit1cVVHdWZT?=
 =?utf-8?B?NTlTeTZIK0Z6cU9BZVVPeENnak5VaERvczg4QUR6WWVjc1RzV0Y1NmpmalFC?=
 =?utf-8?B?Q2JEeXlVMTViSE1OcjRnMXpLMG1EY3NxUVE4NTQ4eGVWQzFxS0w3UDBsUWI3?=
 =?utf-8?B?bExVOXNSWnRjMkVrYnQ3ckYzUmlhK0VHZERaakRjakpWaTIyaktCWFZ1R2ox?=
 =?utf-8?B?bnRyRG00ZFU3bW1ocmtqbUgzWDZ1YjFjVTdwVm5HUFBkQ2VVaDcvZGloSXJV?=
 =?utf-8?B?dS9SS21PeE9VRlRNYVFCcnVZMXFSUUVnbjB5SWdZdDJpUjNrdmtRcEVUOTN3?=
 =?utf-8?B?ckJTY2FvRjZYS0tPVG8yYk9uSVY2Q1EvOGVkRWJzUFQvTWNVcmJKck9yNWF0?=
 =?utf-8?B?THBQTmlVd2U2UENPVnE3dDFSR1pvanpRQThreXRpdVF5ZU5vSy9HdUpTcTNT?=
 =?utf-8?B?Tk14eUxqaWJKUFhVUXFUNStVcDhPMXRTK3FDbVZTWUpEdURtWlZtWGwrd2FI?=
 =?utf-8?B?TWdqcDBPOTNjdHgzQVkxakNxajBtdUg5aHl4dEw0VVRzUVFUU3hvdzM1cnBt?=
 =?utf-8?B?cDBGeHcydTY1Wk93UzdoWFpBSDV4QkVpc2Y2MGR5UnFiRXlEMkhwaVJqMEM2?=
 =?utf-8?B?b1gwazYyUHQwTGxaNGdmdTI1ekRLUzJseFBRWGhnZFUyWEZ2b3lNbmNWRW1w?=
 =?utf-8?B?YkFPVVdYWXRYK0I5VU5wZWZVNE01Qi9rVlBxdW4vQjFKVEg0VGVBVHFpQkE5?=
 =?utf-8?B?VzRZZCt2cXRPZFdHRmsvdkJ4am15Rkt6QTZRSmxod05Qekl1TGZjME5nUmhr?=
 =?utf-8?B?ZkdaRWR0OEtnQ3dTNWxWbStKVGY2WWNuU3VsRVNYTnlFTGFKczZEWDlBTzg2?=
 =?utf-8?B?ZkV0SHZVWHJxUEc4Q2dYOVNGcXF5VE84VGNyYzhBOFp4MmFKNHY5MVZidys1?=
 =?utf-8?B?TjNLUXc5ZGQ2QmUrcFc2SUMyN0J4cnh3QUF0UFRpVk4zM1E4SUE5dmJKSlhK?=
 =?utf-8?B?V0dGUlJ0UEMrY3RCTzRZblovQzFMazVLeE1qUEVLeXlUTExPOXhMSFF5UmQ3?=
 =?utf-8?B?Z01TQWN5SkNFNW5yUFQ2YXlzMjZxMWVBOGtqa0Q4Tnk5YXd0d2w4cDRhRFZt?=
 =?utf-8?B?MVM0eDFPMzViSzllREpIZHBIMUdCZXdla3d0NDNmTkhIWHNVekE5TXdVZTIx?=
 =?utf-8?B?NnMyMmhnMmRZcXU5SU9nRjJ2a3ZFeDNQalEwbzl6RG9FVy96UzNSR3dKUVJD?=
 =?utf-8?B?ZGd2OHU4Y21CeUIwV1phUk1acU1jMXJRS2dyMytEY2JpK0FQTzc1V01sMGN4?=
 =?utf-8?B?THVqVnFBdnNYVlBDWnBNeW1acVhPWWpGc2ZWYUlzYkgwSHR5VTc3SkN4dFc2?=
 =?utf-8?B?b2hsKzhRajRYNnQ5dUFmOTRINTZSS21zS2ViamVUVGJoZHMxWCtzSlRHT253?=
 =?utf-8?B?UzNaRGIvSjY2Nk8xQUVLUlhXUDRnSnp0bnkwZk5NQllKWHFua2ErMWdPSTJS?=
 =?utf-8?B?emRzSDJ4SGhibm1yMC9qVDRST003V1RINmJnYlFEaFh5dFNkcGU2Lys1dmxq?=
 =?utf-8?B?YmpHbGtVTlBhWllzZFZGL0Z1UWwrZmwxaDZaTDA0SXlPcnN5MkVmU0lsYmlC?=
 =?utf-8?B?bTF1MG1oM2MxclJEaGF3WTlOUEZjUHRkakZlb29GenlvSkxtU2s5a1Z6VXRN?=
 =?utf-8?B?cmFaa0dMOU13MVV0R0dGS0wzZTJNL1h2UE5XbzNpNCtBNUtpODRBekF0RldV?=
 =?utf-8?Q?q0EPLJRkkv0rc9XnuvV4xso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8762CB98E4474944B2DDAAE957FA01F3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369f2936-1caf-4b43-c9bc-08de16d92425
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:51:40.2532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wg0eKCOmX7AJAWo+rwr6X742eRskyTMfEj4PrrE/Yx2PIFG2WMIteARKuR2Sd/vrMO4Z1b6cmTVy198FCmA+li8NhGg+uz1oxTipCu0/nMBCujkGnh9xux8WXTQ/mhaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10962
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhpcyBwYXRjaCBzZXQgYmVsb25ncyB0byBhIGxpc3Qgb2Ygc2VyaWVzIHRoYXQgYWRkIFNWTSBz
dXBwb3J0IGZvciBWVC1kLg0KUHJldmlvdXMgc2VyaWVzIGludHJvZHVjZWQgdGhlIHN1cHBvcnQg
b2YgdGhlIEFUUyBhbmQgUFJJIFBDSWUgY2FwYWJpbGl0aWVzLg0KSGVyZSwgd2UgZm9jdXMgb24g
ZXhwb3NpbmcgU1ZNIHRvIFFlbXUgY2FsbGVycyB0aHJvdWdoIGEgZGV2aWNlDQpwcm9wZXJ0eS4N
Cg0KVGhpcyB3b3JrIGlzIGJhc2VkIG9uIHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0
LjEgKE1hcmNoIDIwMjMpLg0KDQpXaGF0IGFyZSBBVFMsIFBSSSBhbmQgU1ZNPw0KJycnJycnJycn
JycnJycnJycnJycnJycnJycNCg0KQVRTIChBZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2UpIGlz
IGEgUENJZS1sZXZlbCBwcm90b2NvbCB0aGF0DQplbmFibGVzIFBDSWUgZGV2aWNlcyB0byBxdWVy
eSBhbiBJT01NVSBmb3IgdmlydHVhbCB0byBwaHlzaWNhbA0KYWRkcmVzcyB0cmFuc2xhdGlvbnMg
aW4gYSBzcGVjaWZpYyBhZGRyZXNzIHNwYWNlIChwb3RlbnRpYWxseSBpZGVudGlmaWVkIGJ5DQph
IFBBU0lEKS4gV2hlbiBhIGRldmljZSByZWNlaXZlcyBhIHRyYW5zbGF0aW9uIHJlc3BvbnNlIGZy
b20gYW4gSU9NTVUsIGl0DQptYXkgZGVjaWRlIHRvIHN0b3JlIGl0IGluIGFuIGludGVybmFsIGNh
Y2hlLCBvZnRlbiBrbm93biBhcyAiQVRDIg0KKEFkZHJlc3MgVHJhbnNsYXRpb24gQ2FjaGUpIG9y
ICJEZXZpY2UgSU9UTEIiLiBXaGVuIHRyaWdnZXJpbmcgYSBtZW1vcnkNCm9wZXJhdGlvbiB1c2lu
ZyBhIHBoeXNpY2FsIGFkZHJlc3Mgb2J0YWluZWQgdmlhIEFUUywgdGhlIGRldmljZSBtdXN0IHNl
dA0KdGhlIEFUIGZpZWxkIG9mIHRoZSBQQ0llIG1lc3NhZ2UgdG8gInRyYW5zbGF0ZWQiIHRvIHBy
ZXZlbnQgdGhlIElPTU1VDQpmcm9tIHRyYW5zbGF0aW5nIHRoZSBhZGRyZXNzIGFnYWluLiBUbyBr
ZWVwIHBhZ2UgdGFibGVzIGFuZCBjYWNoZXMNCmNvbnNpc3RlbnQsIHRoZSBob3N0IHN5c3RlbSBj
YW4gYXNrIHRoZSBJT01NVSB0byBzZW5kIGludmFsaWRhdGlvbiByZXF1ZXN0cw0KdG8gdGhlIGRl
dmljZXMuDQpQUkkgKFBhZ2UgUmVxdWVzdCBJbnRlcmZhY2UpIGlzIGEgUENJZS1sZXZlbCBwcm90
b2NvbCB0aGF0IGVuYWJsZXMgUENJZSBkZXZpY2VzDQp0byByZXF1ZXN0IHBhZ2UgZmF1bHQgcmVz
b2x1dGlvbnMgdG8gdGhlIGtlcm5lbCB0aHJvdWdoIGFuIElPTU1VLiBQUkkgY29tYmluZWQNCndp
dGggQVRTIGFyZSB0aGUgMiBjb3JuZXJzdG9uZXMgb2YgYSB0ZWNobm9sb2d5IGNhbGxlZCBTVk0g
KFNoYXJlZCBWaXJ0dWFsDQpNZW1vcnkpIG9yIFNWQSAoU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2lu
Zykgd2hpY2ggYWxsb3dzIFBDSWUgZGV2aWNlcyB0byByZWFkDQpmcm9tIGFuZCB3cml0ZSB0byB0
aGUgbWVtb3J5IG9mIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgd2l0aG91dCByZXF1aXJpbmcgcGFn
ZQ0KcGlubmluZy4NCg0KUmVzb3VyY2VzDQonJycnJycnJycNCg0KSGVyZSBpcyBhIGxpbmsgdG8g
b3VyIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4gZmluZDoNCiAgICAtIFFlbXUgd2l0
aCBhbGwgdGhlIHBhdGNoZXMgZm9yIFNWTQ0KICAgICAgICAtIEFUUw0KICAgICAgICAtIFBSSQ0K
ICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQogICAgICAgIC0gUmVxdWVzdHMg
d2l0aCBhbHJlYWR5IHByZS10cmFuc2xhdGVkIGFkZHJlc3Nlcw0KICAgIC0gQSBkZW1vIGRldmlj
ZQ0KICAgIC0gQSBzaW1wbGUgZHJpdmVyIGZvciB0aGUgZGVtbyBkZXZpY2UNCiAgICAtIEEgdXNl
cnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0K
DQpodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0K
DQpDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToNCiAgaW50ZWxfaW9tbXU6IEFkZCBhbiBJT01N
VSBpbmRleCBmb3IgcHJlLXRyYW5zbGF0ZWQgYWRkcmVzc2VzDQogIGludGVsX2lvbW11OiBTdXBw
b3J0IG1lbW9yeSBvcGVyYXRpb25zIHdpdGggcHJlLXRyYW5zbGF0ZWQgYWRkcmVzc2VzDQogIHBj
aWU6IEFkZCBhIGZ1bmN0aW9uIHRvIGNoZWNrIGlmIHBhc2lkIHByaXZpbGVnZWQgbW9kZSBpcyBl
bmFibGVkDQogIHBjaTogQmxvY2sgQVRTIHJlcXVlc3RzIHdoZW4gcHJpdmlsZWdlZCBtb2RlIGlz
IGRpc2FibGVkDQogIGludGVsX2lvbW11OiBIYW5kbGUgaW5zdWZmaWNpZW50IHBlcm1pc3Npb25z
IGR1cmluZyB0cmFuc2xhdGlvbg0KICAgIHJlcXVlc3RzDQogIGludGVsX2lvbW11OiBNaW5pbWFs
IGhhbmRsaW5nIG9mIHByaXZpbGVnZWQgQVRTIHJlcXVlc3QNCiAgaW50ZWxfaW9tbXU6IEFkZCBh
IENMSSBvcHRpb24gdG8gZW5hYmxlIFNWTQ0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAg
ICAgIHwgMjA0ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAxNCArKy0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKw0KIGh3L3BjaS9wY2llLmMgICAgICAgICAgICAgICAgICB8ICAyMSArKyst
DQogaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgICAxICsNCiBpbmNsdWRlL2h3L3Bj
aS9wY2llLmggICAgICAgICAgfCAgIDEgKw0KIDYgZmlsZXMgY2hhbmdlZCwgMTgzIGluc2VydGlv
bnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNTEuMA0K

