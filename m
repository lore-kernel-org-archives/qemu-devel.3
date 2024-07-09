Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C3C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4BL-0001Je-BZ; Tue, 09 Jul 2024 02:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BG-00012v-Tg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:26 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sR4BF-00080Y-4a
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720505903; x=1752041903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=A3BCthzvdCG/mtTL7uANeJ6zQF59Z1kvbEhkW21BjgqqfYtZ2CAig3f+
 SZhT34fvlu6dyrooK4YvTY3DJ0dqT7ScWWhujYsJBhqDuaKr2hEtax8+G
 6j3Cfk/HxMhAcSd2z7+l44Op5/Ja+OcNVdAnbtxj+H76ZEfmNCAQKNZcI
 UbDZHq1fQsEvonqu5QQQKMfcAVwiakOSBSyB39WdD7QKLouZ6HuytQQRd
 aoewIzry36AH8rnu18LCZ3xGuCevfnaQO7gezPXHvPohjLmPeWTUU2RIQ
 wGwheL03igXWvqfWaomLQljZhrEddaMxvTX/i7KkEjdp8awOxk+nsUhc7 A==;
X-IronPort-AV: E=Sophos;i="6.09,194,1716242400"; d="scan'208";a="16131809"
X-MGA-submission: =?us-ascii?q?MDFPZS5j2/q+i0Z6tBPGe6dM047gGEYsauk+J7?=
 =?us-ascii?q?SOTqw/NvwQbwUNzdyFOIYyhLWf1gP0slLarfvlG6e2nZxAJm/kiTRs2g?=
 =?us-ascii?q?Q99JW78/X8EjQf9Vl7csZj6Yv6PxDzHqhCLvfxT+1Ai2lbxSI28HMFn3?=
 =?us-ascii?q?75z0HI1tsWNdSsUP+QZICWug=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 08:18:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoaAnCsJAc1ijvhu0vedsf6bnw8M1WeMx8Ny1odvho+FnklAfqjKUUY89wU/TnMWUDkXm+7uZwRyeGM2KudVufpDMX9EXGiL5RRLbgqTn4vqso5fl0PfgO2DC3Zq/bev9udrdT8yZNSjR67mc89cwN7uxafzv2TP3iO3a2kUkY5t0XGzksGeLskUU2YCmRw6u7CwumJPLtfsrWhMMm+n5gI8VkTlfxyJunvx7IF8CNhFvcugNG3iM9Zsb/7M1xH3NrSXZvVRyw2JkeZVy16HBIsEDrEV0lxlHZSiEjkN8rEydi11bqmn2ua9aJ+jAy0E6DUsRfkH52G2/cXV4LiMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=CQRAwL7BErkAgM1Val4m7HlAVwfwEJ+O6DVXegGpUD+dVcyuAQsrS94IV0fKEhaP2NUgXCw8iQbQ50xxfMcJ3DiaxqmpptQLnSBrVcnfDPLrq13fcL2nnB5d3XElCOo5D2K1y2ua/Oa5X8Ztc95Ld4bqdbGSI+ZYymE1eBeYFJdzJ6w79Zo+iR+y8K/oh8vgQZSG9I+ja0uYsemreuFzUwS1OcZznLD87X3FWwDzYYXAUTp0MjrdLHPPD9CAxb+JbQPAvfxlVdiSbsR1o1XkiJI7J7EBafyyOuSHk65undO8tmog8EyQ0i4TAUA/TjVNoOIY+DGHFVX854hnHRc4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1nSNC+fM1pwokpWi9++/4rNMhNj9V1sCadInCpIzU=;
 b=Zq7z9rHYulOPP1zJVJxfq7l4JqhmgBnH+M6iPgJ3ptsdHy/JpyCo+1Fb26GR2scEGIsOXMMyOYQoOSDFqAULeWAvrhPHftOSTiPSgfn+wyLu15mKfmd8spJlnXn45jSY2WGPAY47vwd8xG88/8CGXZlpiomWwqS/n7ESw1fY5k9mt6TgBgXluXvEF84atXHEtksFQItPVOrcIrzdyWVgA+Zvo1UjVbl4/XrzprmkS2bJ9+CHk3ZZ/Kc8yGg5UnxdiYIgidpA8wlcYu7wQV6shPMX1UwTxrB4pOVPFhsTuDoChTknqv240lpBZ95ru6znKemKlMBm/64AZUbh/vKiXw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9289.eurprd07.prod.outlook.com (2603:10a6:10:44f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 06:18:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:18:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v6 4/4] intel_iommu: make type match
Thread-Topic: [PATCH v6 4/4] intel_iommu: make type match
Thread-Index: AQHa0cfF5MXBfjhIO0OC3hgSPePY0A==
Date: Tue, 9 Jul 2024 06:18:10 +0000
Message-ID: <20240709061756.56347-5-clement.mathieu--drif@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9289:EE_
x-ms-office365-filtering-correlation-id: 27cd22fb-811e-4793-cad5-08dc9fdee7d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmQxWC8vUzF4bVBHQkJMUjNaNXRPWXVtTGZYQU9VbnlDdzB2SUp6RmN2bnBh?=
 =?utf-8?B?REVUa1d6R0pWdmswVGU5L0p5REFUN1Y0ckR3cG5ZSGlDUFRtWWp5V2JVcEVJ?=
 =?utf-8?B?SFlqakZmMjJUVFlzaStDelpteWhGaVNLS1ZCZU1aU3lzQmVZS3c3cjRVUFdn?=
 =?utf-8?B?d0l1YVlDTE9GZUx4a3h3UmE3M1dMSEJlajhaWXRoZ1g4NXROTGpYVHZsOHE3?=
 =?utf-8?B?RUhWUzl4S1pUdHh3QTJkREFZL1JqWGJpZFpBMXFMZWhJdjJEOE9IUnk2SGt3?=
 =?utf-8?B?YlRKREd4UFB0aDZuMlZub2Jrc1Q4RTZlZXhTSlQ0RjlCZjd3MTlsVVpESWhr?=
 =?utf-8?B?QnRTSlNHRmVDSkxMK01abDJIazhrNEdnL2cyM0dlaDJaTHVBYkhZRU5wTnN1?=
 =?utf-8?B?M3QrSTcwOTRVeTN0YW5abXJ1bC9zSTZNRDc3SEE5ekFVeVNONVVsUEhqcU5W?=
 =?utf-8?B?NHhOVjlSZ1pBZ2MzazZ5MkpRNGdYMTdYbXhFOHQ0SFJBRHN3dCsydnNDcXVK?=
 =?utf-8?B?YmNpUDZjQk14WmQ4b3UzMXNmdGRXZDVsSEx2Q1B3UVM0SVhXVUErK2d2ZVpO?=
 =?utf-8?B?bnpGaTZFOWFnejZUTUZKVzltWTRyRDY4ZWlSRUpIYjZIOFMwOGdhTW82b1RF?=
 =?utf-8?B?VS9CWWJWamRiNmpwS3lRbERTbFdzR1RrQkRsRVI0NDc0ZXkvUWhGa3JTaStN?=
 =?utf-8?B?c0ZmdUQxSXdKMGRGZnVnTWxCdXcyWGJQK1BNOXpkL0UveVZUejBENTZ6Wk1D?=
 =?utf-8?B?eUNXVW5MOEF4SUJ6VGVvbUcwcTR3QzVvVGxvcTZQd0ppWmsxZHBvd1kxZnZU?=
 =?utf-8?B?RWpndEVSZmFOOGxsalp5bGcvblF6bGU3RVpsU2t6c2FUYW5HQTVXT2dob1l5?=
 =?utf-8?B?OEtyazBPQUhxcWtTT21sWFFXdHliRDcyZStwUmZScy9wVkJVdEV3bTBLMUtF?=
 =?utf-8?B?QzJDNElsSTI0ZXFyTVB1ZVgwQU1KUGtObHU5T3IrbVRGV0dvdlgzQ0JaUUkr?=
 =?utf-8?B?OURaNFJkaGZ2ekorSGgrRkpSTkx2Yi9SaHg4bGdzS1FQakFFVTZuR2Q3N3l4?=
 =?utf-8?B?MzI1eDJ5YVJCcStKa0RQOU5jbjBaODR0eW9ibEtMV0RXUFRqUUorMytmSHFh?=
 =?utf-8?B?TDRjSkU3WHJhT3FYNWRrSUJGZVpVdHI5RkoxL2UvQ3hkN2lDU0hIbkduai9U?=
 =?utf-8?B?OERzNUNNaXpmb0U5TWkrdi9GWktTSERpL2M2MFdZV25jNEQ4aFBYQmFRZUox?=
 =?utf-8?B?MXJQWDhia2VKdVVtTjZsRnlWK3p5OWpqOVNXOFJ4R2VCMzRXOFZkVUVwRi9V?=
 =?utf-8?B?M1UrREwyL0oyQWRuc21KSGllbnZPM1pPQWVVTUpCQk1RY1dYUjhqT1lHMm1j?=
 =?utf-8?B?QmZLdVk5VEM0L1kzeHJzaDB0aWZlY1hHNUVkWllLRGluaTBndGxjRzNzNCtu?=
 =?utf-8?B?WG92M21NUmE3WkszdWE5WlQwVldUZzROZFpDdkZHWkFRNURheWo1OWh1TWRs?=
 =?utf-8?B?NlR4MkFIOGNtNzgvejFoM0JFRk1kTXlXQTh4R0dZYW5vQlNuQ0pqUUp0WFJL?=
 =?utf-8?B?WTFUUE9yTmFnSzUzejc3ZjBBSWVjaG4wV2UwaTdYT0taVDlDUnR3ajFsYlNP?=
 =?utf-8?B?UlRLYUVMV09LYkZYUU5CS2FFVXlORmt3TkRjWmRkMmNmSEZndVV6RUpnblU4?=
 =?utf-8?B?Z1RCYzdjY2lVREtlcE5OR0RFajFOcXFURW1LL0dXaVJSa0ZHM09ndFFTNlVP?=
 =?utf-8?B?N3NRSnRpNUpwUzFrRnJxRWpyUTI5NndLeTVCODJiQ1RNU3FLYmdxQndXVjc1?=
 =?utf-8?B?K29SWUV3UlNxM1VOQkc5Y0ZpNzc2UGRheFE1RThGZDNqK0VHWDVDTEE1cDdF?=
 =?utf-8?B?UUY2bmU0amRDc0JXQkptVTFIY0JGNGtEYlhjVGlMaGVjd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZ5R1hUdHY0RUgrdnQwTzlGTW9BdzBid3l2cStiODBQcE55aThKdzdTUVhl?=
 =?utf-8?B?VC9BSGlUSjNGaG9yN0l3YUN1YXJQcHR3M2hlKzFZNGNvTHhROUtRY1RpWk5i?=
 =?utf-8?B?S0dvMm5tRW9Weno1dzY0cmVUdTJWdVhPbWFCd0E1Ty9kckFiRk04dWtwUHdW?=
 =?utf-8?B?TDRxSWZwdGUyQnZ0ZThNS1N1L29nWnlIVU0wUUdhU2xpM1BuNlM4eEpxOTNE?=
 =?utf-8?B?QVVlaFJZWWYvSGJEckpiSzR6NEQxYlZOand0S05heDJyY1Viazg5MGRuQzF0?=
 =?utf-8?B?RUR0cEhkS2tUYkEzNnA3bU1HdU9CQ0pRQThkMjh0Vi94YjcvVXBicFJseGhJ?=
 =?utf-8?B?NEttTjdhUUNTc001OTgwamRlVjBYcUdGb3lwVzZ0YTNHcWY3RmtMY0FGbmh0?=
 =?utf-8?B?VnkvOXFZa05RWGRibC9HWFFUeHdqaFpsb0ZRZEVBZ1JXMzUrdnY0TEdSRmtn?=
 =?utf-8?B?ZVhoNnVGYjZqbEF6Y2c4eG9IZVNZVTJsZDFQZXIwRXpRZDdZU2hMTHBJUWxz?=
 =?utf-8?B?dmVZTDhGNTBLWkxOOFdlL0JKTVJxTFpyZHZuK0RqWm9WOGNRNlFDc2RJOGJm?=
 =?utf-8?B?Z2MwcEU0Wnp4N2szVTljZUhtKzNqM0VTd0IrVXgvVWJGWnNRQk9rOUROVkFy?=
 =?utf-8?B?TGdJZjdaeXgyKzUreXlrYXl1VWZMU1ozUGEyd3RmckpaamlLUXl4cUdrVlRZ?=
 =?utf-8?B?c0o5NGEwWXhxTDFqWHZnK1hWYUZwZzkrWDZsQnJ3TFlJV2kyVlNsN0xwcnBW?=
 =?utf-8?B?NFU0THExQjdJeVBqcHZlNEFsMnZYTFhuRTVhZmFkeUhQTVo0UUVRYjNSaUli?=
 =?utf-8?B?L2JkV2daNmdHZndEcklueW11U1VUR3pwaDczakpmczRsb2JadnNNMmx5NjF4?=
 =?utf-8?B?WlhNZ2tTTW5IM0QzK1pneWMzekw2aGY0KzJaUlhySXBzYVREQkJKSmVWN0R3?=
 =?utf-8?B?TGdjZ3ZhMXpEcHlVUFZlWHpVMlV1aWJGellYUjZXTndUYU55eTdkZGFEcSth?=
 =?utf-8?B?ekRrNm95RVVySDE0L08xdFRDNjhyNWhwa3VkN2t3NkxyZDZkbEk2SUI2dDFS?=
 =?utf-8?B?aThFcVF0Q1ZCSUxsd1J6cmRmdjNkVFMzOU5CWmFYdjN3RFRaenVuY084djhC?=
 =?utf-8?B?YmNBU0RSTUZ0Rk9wdjVwbHhHandnSm9WMWNkelN2NG5sOVFSVG5tY3oxdkpp?=
 =?utf-8?B?Y2dPWnV2M2QzdDJ0WG9XN00yYitFbWY0Qjhwd0hBMGgrMkR4SW1pd25BVXA4?=
 =?utf-8?B?cktrWXF4NTFMbmFSOC9PTldGT3R4M1o2ZGJSTTM4VnQ3MUREYXBvVnE4Nm80?=
 =?utf-8?B?d2dDT2JFUTJWeGNaT21KRzdkNnlSYU9FSUJsMlJIWmM3Z1I4WGpHSTEwTUt6?=
 =?utf-8?B?NTUzUDh0d3ZhQ1FKSDk5Zi9IT29vQ0JNTkVhTkxrUlZHNjB5elRLQzdmdHgr?=
 =?utf-8?B?OVBSMkJqalpPcy9Yb08rZFplNWlRR3lYTkMxeFR5YXh6STgvOWpVb1VlbHVm?=
 =?utf-8?B?Z0lLUjJ2YXl4bnV5TlVEazd1emUveXBiSmE5NCt0VUVhY0NJN1M4TGZnV0kx?=
 =?utf-8?B?Ni90QlVWMHBWa0svbFJkQ2puTW9hekp1QmprdHMvWGh3cE96V0ZuS1BYQk5t?=
 =?utf-8?B?NVJqTzVoVXd1d0FMWWJrOVVYTVcvNlFrd0xzY1krQmM4Y09OMlA0VEFJeFdN?=
 =?utf-8?B?Y0xEeUJxODhUY0RtS0FJZUdpQ3EvcGx4QnlGOFViRTNhUU5hb2Y5TFRpNUQ5?=
 =?utf-8?B?dk1nNHBjVGZBRmdFQTdsNW9uSWxHcmpFU1BueWxGalpxbmlTN2RkbUpVbmJF?=
 =?utf-8?B?K24rOFRsREZDK0dTeThhQ1pSaFRDVGRkcjJabk1ZL1M4NUxRQWkyNGpscFk3?=
 =?utf-8?B?ZzEzaS9odjBNM3RZc2FrU0lhSEorTzVFZjVqQmdHMU9PRGM2ZmRiQTRsNTAw?=
 =?utf-8?B?bStyb2NlMUtrUWZCZjFud2YwczJYSFpueGR5dzNJRHJ6TmpQYzY5bXpsNGdQ?=
 =?utf-8?B?cldrTXA3dzlabHhzSUs2bG1ta0RvVDVJODhNZkl3M1AzNmV6U1Vrc3h0ckR0?=
 =?utf-8?B?ZDFtb0c0OSt6eXdISlZJT2dtSkVvODd6L0o2S3hYeC9QV3JMUGRFMG1uYnQ0?=
 =?utf-8?B?Y2szMG5KVElrTUcrU1hOelpjejVrdnBidTVXMEowYkx3V0trQ3NhVXdRODB5?=
 =?utf-8?Q?gE5NpsrQylNgAK52DaXpznU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5FCB4A853F2414B986CC273FC744977@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cd22fb-811e-4793-cad5-08dc9fdee7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:18:10.0764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPcv0/PFd4XEMh0678dBJwmGAT7kEkY9M2WPek0roMrINYT85jjAPA2clr9Ed8Oe48BfYI2HIMvBECgIERh5Go/qt0U4SBkOYgqwMDcZHlybQmZ3enco7mK121Vd4auH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9289
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

