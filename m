Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF39CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRJ-0008I1-1j; Mon, 30 Sep 2024 05:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1svCRH-0008BM-1s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1svCRE-0004Uc-HG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1727687488; x=1759223488;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XHCsloiQ3ehiuiAT2ZOZB4HPX+dSxwTkgZgNISLOFFU=;
 b=a3W4PxilDmtqzCnRXMTfZqTL0G5cIufe29eBZnK3ZJ4qiGOj+0HaFCiy
 Czy0GzdFDJ23Ia5h6KKO5s/ubfFVP11ENbiy7RVfJgLMcevr0RRVQcbFz
 f3lahO/PLQ6edrFoNtIWjZftoKabM+95civ0118/0pnwB+wHHujvSoSOl
 fqqhuHVZYUsgjsVVEycyhnp/i1epMg3UgWjrqeR2d0kJkeV+0rhMDgW+3
 NhOfWkUt64d9EKEP8iMyhBAfj2KpqvmZXNy8PIzHBfA8Ww2AabQPh8qXo
 d/4QSUOKoVuoTTJ3lQ7ou2qC4MbrzWznmUaV1QZgglZLYx/zZjE8fMgSj A==;
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; d="scan'208";a="21276986"
X-MGA-submission: =?us-ascii?q?MDECq1SlOAn66OHcbJDedu+0sfXNj6r6Qy1nYh?=
 =?us-ascii?q?vVQUcEDtW7MbAqOr9BXIgMiAXOd0GpBYri20s+XV+S8OkdXqwf237KUw?=
 =?us-ascii?q?oxGfSuWIZWOyhI+cncl66a40murzym4WhDwBkNlYtjk1DrnFiMfuXzj5?=
 =?us-ascii?q?iWq4tndXjdC35vQ8D8osWMTw=3D=3D?=
Received: from mail-vi1eur02lp2048.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.48])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 11:11:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxKiHBiQ/zrfCIlVDb/J+48j+9O7IHN2xmA5h2PwGcaImXFFCMlrEWsGzA4RHp7gl68r3rXrFUhvsbLCLLXN0Fpn2nfndtb3UWzwdodag9w6HwFHDeflm8clOcWG7WXpPRPEOMOz6bfs2SH2Lwe0t1PwDeboMxUf798lJFNBz1q8BgsYehUwTQE/59BOO8B85SxO3BXb8cLs2cUHy7S88c99O6+6ZCCmu38GMqWH1vEqKK28FCB2qj0ux0F2QBUSY8HfeAxbOpDxAY1/pQRY1fVtlQk4SjXLghASRs1BvmBzXd2SWYbn8pndSBLgcfoKdcolH9/RgUfNwl2rmc7qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHCsloiQ3ehiuiAT2ZOZB4HPX+dSxwTkgZgNISLOFFU=;
 b=G1i1/1sU+KGtGzdyjuXSzKEzkxcrM/z0B7wZx3g0ycDJ7yWWdEU9eOfxHmEB/a/4gki0FFK/hSgcH766c53AF+uv40aRyl+tcewpuCJRUfa+VGtIotBr1pgYXKKEa4YpHT0w71ojiF1eYC3mXVH/xsiPn7F+E6LAD3qy3+hDBfJqKN0aPj0hTwD7m89mMOB9CSWte5sHNC9cxu6eDyhC4WPrDrHuRFjw5PDQgg8hXYOabKQcP2BRkL7XVEwIjEfyFIv2g0BpQlgFh1V7Z29x9mLuwlyAHwEr8uG4sx0NH172Pp7ZZdYFhK54o6PB8UXIxv9KBbtjo7dk/4kbexjUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHCsloiQ3ehiuiAT2ZOZB4HPX+dSxwTkgZgNISLOFFU=;
 b=bbsE9rLgJJ1hOOOPcjwWUqQPVtgq7Y0BjKTJydwtZxbQZarOHKik/od+IJSMsiP5o4QY4Slbfys6IxaQiZm4XlzMOQc21lXUl9JEV137r/CVey7GIwMKribMEYKontgT8STfzaXOwVszWieZWWgGE26AcXRMXuVFCFr+/Rlo15eRZw/fxBqJfZZ0tZHKzbrs5NqoXx1iBv/JwCV8DrzUjKO27eNGaPChrVkNbWxlmaaDioZZ5VoBTH977BkDocliu5ZcTPru3psqEhyAU1Jrg5mpqblZCX9vNmYhVRJkb0+o/k3NslpcpfYOmdrd0GaqVC0zT175G0vaqfKD9twbxQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB10118.eurprd07.prod.outlook.com (2603:10a6:102:382::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 09:11:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:11:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
Thread-Topic: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
Thread-Index: AQHbEwXP+H9hhJvOCUSx8Zf89c/0BbJwC0GA
Date: Mon, 30 Sep 2024 09:11:20 +0000
Message-ID: <bef71c42-f66c-42cc-a654-7dfecd866b41@eviden.com>
References: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB10118:EE_
x-ms-office365-filtering-correlation-id: 817ad3cc-ad7e-4bd7-896d-08dce12fd97d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ajlaS0RBQVpyNFBxbnA0V2N5WEQwV1h1ZllwVmNnL1hxTmdoN1Y1WWpZanFl?=
 =?utf-8?B?KzBnMjl4UjYrOXFiUjhFRGZJOXM2a3d3VzlYOVVxRmZLSjlUMmpzU0t1cDBh?=
 =?utf-8?B?ZW5aeW5MeDh1Zk13c3R3bWNmVWs3UjZtYkFxOGxIWVhiNWJReWdyOUVHQnNq?=
 =?utf-8?B?SjMvY0tsdEwrR29GSS9rQU1GVzQ3b2s4bksrc0NoSGN6WGhnQUowMHc5M24x?=
 =?utf-8?B?cWhoTi9za0pkMXJad3hseXdmc3g3dW1LbVNCNGQ4VzJuSlBMZHVsalZjSEM4?=
 =?utf-8?B?WlRQTWlDczRSMGRFUkpNQ2ZCemViVnpYZWw4TDRMcnZYR2FFOWpldmpsb1l4?=
 =?utf-8?B?VlZNZVpjMGI1VExRdkxvTEJ3ZU5aQWRCVXp0M3htKzV2U3ZiYUJiZm1SZEtL?=
 =?utf-8?B?ZGxTeTR6bFZvTnZieHdSaXZqK2F3aHQ3cGJjL0pBNFRRZTEvQzlHMVBzMXhj?=
 =?utf-8?B?eWhXRXVwYUQ0TzBXdklrSnZHRlhPalRRN3V3NEVxelpPSDJZcWhzeG5Ub3pk?=
 =?utf-8?B?MitzY1JkVnlmODljUTh0OVVwcisvWFBjNWxBMENkNmhNR2ZWb0ZlNklNbjlM?=
 =?utf-8?B?cWtTQy9sYjlCYTE2cVRldjYyaGdxRE5qU0oxbTVObU9BTEhxUmdyZFgzV1hN?=
 =?utf-8?B?SUR5dzc5dHJQRDEvV3I1ckhWNSszVk5VSGNITXJkVDROOU1Ta0JRMGswaTlF?=
 =?utf-8?B?Qmo3MVllOEdtNUluV2dCK3ZsYU93YWEzTEF4VUtRN2JHejY1VHZGTmIzS3gw?=
 =?utf-8?B?TEtVaVZMVHJNQVh3MGRPcmtqekNMNzJaUnp5bjdpS29LczZQamx6RnAvNm5Q?=
 =?utf-8?B?YmVYcWdEWXBrT2FYREcyenVHbkNNRkg5QXp2NWFwWEZqMVVsbnU1Q0REemFH?=
 =?utf-8?B?eC9UNnFLL2pudmQwR0ljYm9oeWo2WXBIV3BSTXFka2dBaVVQVVVyQ3ZSVE91?=
 =?utf-8?B?N0c1ZkRTU2NHa2daTmZSUDVKMXNVZmNyTVpMeXIwRG9PVThmVW4yS2R1N3R5?=
 =?utf-8?B?cjdvdkxqd1hHQ2FreHJTb204RmJTT1lES1pzL2FRNG5rRjNEbXBZRWthc09x?=
 =?utf-8?B?VXIxeXRhY2hZRUIyOEpBWm5kSEFmS3hCaDB1eFU2bjc4em5wK2dXbzFBaC9S?=
 =?utf-8?B?TVJlSzVHNVBodjllZGtsQXovNWlEaUhpaHdXbFBjblVneklFYUVaUy82MFFQ?=
 =?utf-8?B?V29IYk5XdEpRU0tQRmZQSWh1SjlwWU9xL0N6ZGJGTStmRGxzaEdNRnZMVjdU?=
 =?utf-8?B?eXRDWEJ2Sk00cjBKUFBXS0xmUmJMOXdHbmFDK2NTbG1NZTNKZzJvei9EUmlH?=
 =?utf-8?B?aTVCdTV4dEwydHZNdG9KNkhXOVBJRTliK055YUcrOFl3UFJIVXJHZmtWbldp?=
 =?utf-8?B?T3ZQOExXeEI0TW8yYjJGRkliejl2UHVvd3VYZFVUTzdmRGkvMXY5dlk0eTFO?=
 =?utf-8?B?VENDTlJRTEkweStNMHh5bTZETHZXN05UR3ZJbHl4WlM0Zkp1ZXZzZHlWRjlH?=
 =?utf-8?B?Uk1oVHFoRC9nQ1NYNi9JSms0eVdpWEVJS0tOd3owUmpjMG9Sb2RTbmtFNVlu?=
 =?utf-8?B?ZmJpODlIWnhQWjd3ZUh5Q3JnYUU1bXBuK3M1STEwZjc3TThuVFRlZXZvYlF4?=
 =?utf-8?B?dnptU2xMc2p6aHZ4U0xoZVlGck1Rem10UDdtRnNJSDhIanlsc05tTEJKck1F?=
 =?utf-8?B?WUtyY0h3SmkvM01zK0hUelZOVEpmTHJOOVdpRHNYdTFsUXNXZENTWnNva29X?=
 =?utf-8?B?Y25yMW9KWE0yK3JRcU1lcmVTOUdYY1h4N3hpVVczQlZwNk1IelBod1IzVHFJ?=
 =?utf-8?B?UTM2cS9GS0h1ZHZKQUt1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anNHNmhLWi9uUWFmVTJ5bTA1RU1zaEswaW9OUjhKNm9CcmFYMWF5Wm9GU0ty?=
 =?utf-8?B?amYrTmZPM1pqZElHV1YvQlQ4VFBveHlOaDJ6M1ZMSkIyOEVlMDdrQnFvUWI1?=
 =?utf-8?B?a3FpQmdzaHNVSUtxWjRBWjNQQXpkQ3IxV2RsOEtEbmZ4Y3VCMnNIK3RZbjBG?=
 =?utf-8?B?MHZra3JrKzBJM25LaCtZZnUxdW9pMEVGejJzeXRWZ3ZiNGkyQ2V5Yjk2RDFn?=
 =?utf-8?B?OVMxZ1cxazhUYjFhNCszOWQwb2tPSEdvQzFtSzlqOVdSeCtocDk3OTQrU1Br?=
 =?utf-8?B?VVZOVzRmbnhyVW91Z1lrdmZaQytRVFFEUTJjZm9mOG1yS21FL04vU08zdStY?=
 =?utf-8?B?ZTZJandZSEpld1Q3dmNPVnozV0phU1RTVTBXY01LWjA2cTlrR2pHdUxhcmpK?=
 =?utf-8?B?dDJHUFRhcE5mVnl5ZDRjME1QRUViQjlBRWlldXJqQ0JKUk4vVi9tVXdXSzI2?=
 =?utf-8?B?alMrSzAyU1lmS0hKd2JpaVRaT3BuSmdkSFJpeGQrMnFRaGh5Y2VvR3ZGTThH?=
 =?utf-8?B?MGZweHVVM1BybmNmTXVtMDM4SzFRVzNyTGNrRlpKTE9LdnRYeEo3aTJHV1RX?=
 =?utf-8?B?NWlHMzI2dmV3S210cUgxS2d3Mk1sODVXazFQNzdEMGlVNGhNZys5cHJTZnVs?=
 =?utf-8?B?V2xxNDZ4d3VRY0Jtc3hpTHFydHczVWNuVE5DYmdVL0ZHc3M4RW5VT3RBSEJX?=
 =?utf-8?B?Mm9DUUdwNjRIU3l5SysrUHFTTEtQS2JuTkZldDhEbXhNN0ZzVmUvKzc3R0pK?=
 =?utf-8?B?b0RBQk1xUklPUVBrMUVTbHg3Z2k1U3lZQXphaFRMaVBLMkh2Z0tFV1AxRTNq?=
 =?utf-8?B?MmdEWjVtRzVJQ3lKVHh3Sys0Mi91UHEweXQ4VFZaQ1lrdUgxVGtsUENocEZJ?=
 =?utf-8?B?L0tmV0ZHWnhhYVIweGE0SHdHSnpscHFTZmdLZEJCNUdRamhUYlEvLy90MzM0?=
 =?utf-8?B?TjhnWUdpRWdzbnREUGhtcWV3aFBKTTJCRi82RytpL3drd3NrUlU4R2pTZ2R2?=
 =?utf-8?B?QXJLVjJhUzhLdjl6aHRsMDZ0enpDQ2ZzY05hb2xzSktFSzVDQTl2RExOYjIw?=
 =?utf-8?B?VGlvTWZCaDlOREF0U1VKMGI2QjdNUmlKNFpTcjlWNnZ6Q0svaEo4Y0hYVUN2?=
 =?utf-8?B?aCs5Zkl4ZEcwSE44NFJRdVI1SFlpZWxIVVhQSFBYbUxGZ3pxTHFCWTYvVk5C?=
 =?utf-8?B?cy9YYjl4UU8rV0l1bVdyVldrUlBBWWFkK2s1U1g5TmptZkg0bXpHOFFmZTBJ?=
 =?utf-8?B?V0NPNStYdmdhb3FvcER3RC96WWNrS1k1dnhkM1dYV2ZYeC83S0VsTVlWK3hG?=
 =?utf-8?B?R212aTU1Q2JML2tqWFFjSVY3c0piNEdYZWVrWG9NZDZjSy90NmN4cW9FdGdz?=
 =?utf-8?B?dWtMR0NWUzlkbUFraGQ1aHRueGxjcHV0djhiM1NVZUI3VnpBNkxka2crQktu?=
 =?utf-8?B?ZnRxeWxER2VOc1p5dElySTVaVCtaUzg2bzM5aEVpMTR0VWtxWlpGdGZDN2w1?=
 =?utf-8?B?UXZDRTFRRmtZWlhyRDhjQlZ3dlNPSStmNXlZMHlzL0d5QlNyM2ZmTjdRUE9y?=
 =?utf-8?B?SlU2N1gzejRtanNDWFZuSDZHY0xCZG1hZ2F0c0pFb3BRWHRVWWR4MzBNWjF1?=
 =?utf-8?B?T0hPK2x2c3QvbVNmdzZYY0FPdndHNWRCTThWQXVGVkdxOXBYc2FacUovTy83?=
 =?utf-8?B?OXFOOHBpUGovRUJrbmdKdDFPcnlYL3VKOG1JUXB5QS9aSFlGNzNtd2JES2xk?=
 =?utf-8?B?TjZsUmovR3VieFowZEVpYmJJNGdMWG8wRnRBTkJyRTdyRHVVSU1JdTlMY3E4?=
 =?utf-8?B?N04xUXowQkVTc3cwMUxpVE5RUjFLY0hUVlpOSklVQXlPc2I1ZzVNV3E0cTlN?=
 =?utf-8?B?azRqNTNvaWZYcElxMGVoZFFHYmxhOVZmMytpRmJBbGxCWXYyQ01NWnVjQVlp?=
 =?utf-8?B?dFpCaHMwUlZtdWJORnRjR1N0Rm9HSVJkbUc1cGJ3ZkREbzhUZjI0N3preEd5?=
 =?utf-8?B?UVEwWUljbVd3ZXh4cC9iaXhwOFM0N0JRVkZmTVlERjhPeS9YZzd6bDZWWU9V?=
 =?utf-8?B?eDhhcDIwNU1TNjNPMWFOYTZSZWxma0UreUgrTkN1M0ZGc25yUFdYUzRxTXFo?=
 =?utf-8?B?d01mMno2czRlNEVUWGJCMVBxQzBIb2V2Z3hYbHNNaFEyTlZxVEhMVjMrcVh2?=
 =?utf-8?Q?ys9L19jzWqhPM6ApNFvWYxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC7896394165DF4B877A2C569CF0E20C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817ad3cc-ad7e-4bd7-896d-08dce12fd97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 09:11:20.7942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjcU81tw/tSBizqc8V4ZvmszHwWTGTsZ/drBQ2fZbSciiMzvx0GRy26S1aiYi/FPs0ujmpIbzl8GQTlXx50Qbypnj6/A/cEJK32LOoPObLyqG2C1dxmFDZhlrSKMHdWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10118
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

TEdUTQ0KDQpUaGFua3MNCmNtZA0KDQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qg
b3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMg
ZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiBWVC1kIHNwZWMgcmVtb3ZlZCBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkIGZy
b20gc2Vjb25kLWxldmVsIHBhZ2UtdGFibGVzDQo+IGFuZCB0cmVhdCB0aGUgZmllbGQgYXMgUmVz
ZXJ2ZWQoMCkgc2luY2UgcmV2aXNpb24gMy4yLiBVcGRhdGUgY29kZSB0byBtYXRjaA0KPiBzcGVj
Lg0KPiANCj4gVGhpcyBkb2Vzbid0IGltcGFjdCBmdW5jdGlvbiBvZiB2SU9NTVUgYXMgdGhlcmUg
d2FzIG5vIGxvZ2ljIHRvIGVtdWxhdGUNCj4gVHJhbnNpZW50IE1hcHBpbmcuDQo+IA0KPiBTdWdn
ZXN0ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiAtLS0NCj4gIGh3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEzICsrKy0tLS0tLS0tLS0NCj4gIGh3L2kzODYv
aW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDExICsrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+IGluZGV4IDEzZDVkMTI5YWUuLmM4MThjODE5ZmUgMTAwNjQ0DQo+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4gQEAgLTQxMiw5ICs0MTIsNyBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRl
c2MgVlRESW52RGVzYzsNCj4gIC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUgKi8NCj4gICNk
ZWZpbmUgVlREX1NQVEVfU05QIDB4ODAwVUxMDQo+IA0KPiAtI2RlZmluZSBWVERfU1BURV9QQUdF
X0wxX1JTVkRfTUFTSyhhdywgZHRfc3VwcG9ydGVkKSBcDQo+IC0gICAgICAgIGR0X3N1cHBvcnRl
ZCA/IFwNCj4gLSAgICAgICAgKDB4ODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NM
X0lHTl9DT00gfCBWVERfU0xfVE0pKSA6IFwNCj4gKyNkZWZpbmUgVlREX1NQVEVfUEFHRV9MMV9S
U1ZEX01BU0soYXcpIFwNCj4gICAgICAgICAgKDB4ODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcp
IHwgVlREX1NMX0lHTl9DT00pKQ0KPiAgI2RlZmluZSBWVERfU1BURV9QQUdFX0wyX1JTVkRfTUFT
SyhhdykgXA0KPiAgICAgICAgICAoMHg4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERf
U0xfSUdOX0NPTSkpDQo+IEBAIC00MjMsMTMgKzQyMSw5IEBAIHR5cGVkZWYgdW5pb24gVlRESW52
RGVzYyBWVERJbnZEZXNjOw0KPiAgI2RlZmluZSBWVERfU1BURV9QQUdFX0w0X1JTVkRfTUFTSyhh
dykgXA0KPiAgICAgICAgICAoMHg4ODBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xf
SUdOX0NPTSkpDQo+IA0KPiAtI2RlZmluZSBWVERfU1BURV9MUEFHRV9MMl9SU1ZEX01BU0soYXcs
IGR0X3N1cHBvcnRlZCkgXA0KPiAtICAgICAgICBkdF9zdXBwb3J0ZWQgPyBcDQo+IC0gICAgICAg
ICgweDFmZjgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NIHwgVlRE
X1NMX1RNKSkgOiBcDQo+ICsjZGVmaW5lIFZURF9TUFRFX0xQQUdFX0wyX1JTVkRfTUFTSyhhdykg
XA0KPiAgICAgICAgICAoMHgxZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xf
SUdOX0NPTSkpDQo+IC0jZGVmaW5lIFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFTSyhhdywgZHRf
c3VwcG9ydGVkKSBcDQo+IC0gICAgICAgIGR0X3N1cHBvcnRlZCA/IFwNCj4gLSAgICAgICAgKDB4
M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8IFZURF9T
TF9UTSkpIDogXA0KPiArI2RlZmluZSBWVERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0soYXcpIFwN
Cj4gICAgICAgICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xf
SUdOX0NPTSkpDQo+IA0KPiAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9U
TEIgaW52YWxpZGF0ZSAqLw0KPiBAQCAtNTM2LDYgKzUzMCw1IEBAIHR5cGVkZWYgc3RydWN0IFZU
RFJvb3RFbnRyeSBWVERSb290RW50cnk7DQo+ICAjZGVmaW5lIFZURF9TTF9XICAgICAgICAgICAg
ICAgICAgICAoMVVMTCA8PCAxKQ0KPiAgI2RlZmluZSBWVERfU0xfUFRfQkFTRV9BRERSX01BU0so
YXcpICh+KFZURF9QQUdFX1NJWkUgLSAxKSAmIFZURF9IQVdfTUFTSyhhdykpDQo+ICAjZGVmaW5l
IFZURF9TTF9JR05fQ09NICAgICAgICAgICAgICAweGJmZjAwMDAwMDAwMDAwMDBVTEwNCj4gLSNk
ZWZpbmUgVlREX1NMX1RNICAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYyKQ0KPiANCj4gICNl
bmRpZg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+IGluZGV4IDA4ZmUyMTg5MzUuLmViNWFhMmIyZDUgMTAwNjQ0DQo+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4g
QEAgLTQxMTEsOCArNDExMSw2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1V
U3RhdGUgKnMpDQo+ICAgKi8NCj4gIHN0YXRpYyB2b2lkIHZ0ZF9pbml0KEludGVsSU9NTVVTdGF0
ZSAqcykNCj4gIHsNCj4gLSAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVf
REVWSUNFKHMpOw0KPiAtDQo+ICAgICAgbWVtc2V0KHMtPmNzciwgMCwgRE1BUl9SRUdfU0laRSk7
DQo+ICAgICAgbWVtc2V0KHMtPndtYXNrLCAwLCBETUFSX1JFR19TSVpFKTsNCj4gICAgICBtZW1z
ZXQocy0+dzFjbWFzaywgMCwgRE1BUl9SRUdfU0laRSk7DQo+IEBAIC00MTM3LDE2ICs0MTM1LDEz
IEBAIHN0YXRpYyB2b2lkIHZ0ZF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4gICAgICAgKiBS
c3ZkIGZpZWxkIG1hc2tzIGZvciBzcHRlDQo+ICAgICAgICovDQo+ICAgICAgdnRkX3NwdGVfcnN2
ZFswXSA9IH4wVUxMOw0KPiAtICAgIHZ0ZF9zcHRlX3JzdmRbMV0gPSBWVERfU1BURV9QQUdFX0wx
X1JTVkRfTUFTSyhzLT5hd19iaXRzLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7DQo+ICsgICAgdnRk
X3NwdGVfcnN2ZFsxXSA9IFZURF9TUFRFX1BBR0VfTDFfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0K
PiAgICAgIHZ0ZF9zcHRlX3JzdmRbMl0gPSBWVERfU1BURV9QQUdFX0wyX1JTVkRfTUFTSyhzLT5h
d19iaXRzKTsNCj4gICAgICB2dGRfc3B0ZV9yc3ZkWzNdID0gVlREX1NQVEVfUEFHRV9MM19SU1ZE
X01BU0socy0+YXdfYml0cyk7DQo+ICAgICAgdnRkX3NwdGVfcnN2ZFs0XSA9IFZURF9TUFRFX1BB
R0VfTDRfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPiANCj4gLSAgICB2dGRfc3B0ZV9yc3ZkX2xh
cmdlWzJdID0gVlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKHMtPmF3X2JpdHMsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeDg2X2lvbW11
LT5kdF9zdXBwb3J0ZWQpOw0KPiAtICAgIHZ0ZF9zcHRlX3JzdmRfbGFyZ2VbM10gPSBWVERfU1BU
RV9MUEFHRV9MM19SU1ZEX01BU0socy0+YXdfYml0cywNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7
DQo+ICsgICAgdnRkX3NwdGVfcnN2ZF9sYXJnZVsyXSA9IFZURF9TUFRFX0xQQUdFX0wyX1JTVkRf
TUFTSyhzLT5hd19iaXRzKTsNCj4gKyAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzNdID0gVlREX1NQ
VEVfTFBBR0VfTDNfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPiANCj4gICAgICBpZiAocy0+c2Nh
bGFibGVfbW9kZSB8fCBzLT5zbm9vcF9jb250cm9sKSB7DQo+ICAgICAgICAgIHZ0ZF9zcHRlX3Jz
dmRbMV0gJj0gflZURF9TUFRFX1NOUDsNCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiANCj4gDQo=

