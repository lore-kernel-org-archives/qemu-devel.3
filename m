Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D3C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdLP-0004Ws-Mb; Thu, 12 Jun 2025 04:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdLN-0004Tg-QV
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:31:29 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdLL-0004la-NX
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1749717088; x=1781253088;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=MnW5eyfcmK6OuNZJsih9auuauW0pV/riUayCa7neWzs=;
 b=NOchQjWfTP8zpZkz29d3cQuehjpbWc7l0c0tXYPiZ2p9XW9n9fetYWtS
 QgTnPv6ZLAbfZUkxPfNBpBtCRjj27doIOxelC+4GH7MAM3pq+uW7nweNI
 lz5JBdwq3iZJw3aKg/fL4cy1vMe63QASHmio6xlYjzbLpjVhTYLgcozYq
 PZDadbqw1BJOGHQTM63K9cToFs8AwBSXhiTwSLrt42/sgRhjRYqlFpMb5
 hyCEW6o8s2OW1MriDQbu5C6hvQoAHDriThzkXAUSR1XU3A3gRuy5wysEl
 477Ck0vKtP7HngVa7gvrpXrDPhOEkrvD4+2EJZXNG9AVmlaKeTrWftJDi A==;
X-CSE-ConnectionGUID: z5P3XuxtRuq4YHO9GKx06A==
X-CSE-MsgGUID: b2XCGfwiQbaBrm83H3V+YQ==
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; d="scan'208";a="38601329"
X-MGA-submission: =?us-ascii?q?MDFykowPfXiM9WN/bQ3rj9Uu+d9WwgsMCNtZwV?=
 =?us-ascii?q?BI9oNqO6cB1YGMYyQAm1NFC3CxhBsJKwNQ8uAwMnLmCGN0RNhvkdNEOz?=
 =?us-ascii?q?MKQ6MZ3aeW+GFTvVlfZm2INV4ePLnAk6zqlJftN7Mh/YsmxI7fLfy3xx?=
 =?us-ascii?q?QlpS9ZZrbh9X2dUdNwZQfgPA=3D=3D?=
Received: from mail-westeuropeazon11012015.outbound.protection.outlook.com
 (HELO AS8PR03CU001.outbound.protection.outlook.com) ([52.101.71.15])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Jun 2025 10:31:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXcfKCMzouaAq/5aLzUlO7Pd2m0/2ZVqx2u+zd6S+AZrNnoCxmaHw6VJ/AAY8mxQl95/xjlo2UY8DWLqj7ZfgqQwKWXhnodsDhsnXMJhLeuE7P36dqGHDxGif3AUzzpCWvObratpZlVUUyY2EImaXDi53m2lVbWRY2ATouVaFOuJj2yDmaMVT3h3mUlTgnJJBUkH2QI0wQa2tt3HAcb58Mmm1M415hqxxaZAaDE16jxpQqcU+sqvLQSWkw8IUVed8nYS2tPqzbf84I+qLrzsTvLZuskYQKYuBWm1D5EsJWBSxm4e4ba07Sr0pLEHJyPSrFMhnO8gJN7xtJ1yUf9UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnW5eyfcmK6OuNZJsih9auuauW0pV/riUayCa7neWzs=;
 b=ZDsvJ3nXpY+gxSkhGZf4XVjuR7SErT+qU3p5zqP0+NBctfquc47JVQPxa0qc7ez6QaK2TR5YuQCdURxkeaBo7AAg/9Kn2Zy2isCPb3eah0IP07Woa1GKIJ14uUcrKhbyTHa4MtdxZGuLC7W0kKz4lGI3asGr88tBNy0ZI/utxBFvdYLoaM+PqKu9rEnaXhkfyH6W5KRUblPbeSqLEv9zNEXzyLHrHan8KnB6IcMO+J4nHOR6XJ6v2X5/z4YMOkTAZpgDASzAKUqAoDIa0hD99GNkM3Yd/zf0oYm5gKuzY/1SDChot6sH+GM0dpKhbWJVlpEC7NWjaUVx0YagczZ2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnW5eyfcmK6OuNZJsih9auuauW0pV/riUayCa7neWzs=;
 b=R1Ge2isy5VZ5MLqz72P94kxaVq7B6goEOjBrk4QqiXmk5cESaJjr8N11CcXMTnpPfw8ppnLlaDDI6+I4qQBJFw0Hv1yKe1eG3/2oosHA8dd5PbMb9OGGgeltX9rsclzX4Ju3lxnDdEfKXc84GbZmGk1xxnup0QppsQGwrmmM+G/n9NbcfvoMVRF0xZp8dt5orcRA9DXHLmgUFJbv4PokmvrjoIKP9a61t2jPP9W0096GWtkMlW+lMFmizciAVJFwo13dPp9sJ2ssLT2GeCsrhZL3wvlV6NV9uZT2phapA7JdJp4fJY7npKx54sy9qnHVzdLrXqQpWjycOITOOXDdlw==
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 (2603:10a6:800:190::13) by AM7PR07MB6216.eurprd07.prod.outlook.com
 (2603:10a6:20b:132::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 08:31:24 +0000
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e]) by VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:31:24 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
Thread-Topic: [PATCH v2 05/20] amd_iommu: Add helper function to extract the
 DTE
Thread-Index: AQHbuwgx15evNiCIBkSORm+O8LSnhLPbaoYAgAHepoCAIil4AA==
Date: Thu, 12 Jun 2025 08:31:24 +0000
Message-ID: <ea483ab5-6cd1-455a-8dfd-ced8122a7237@eviden.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
 <8e6cdfc0-2c6d-4785-ae49-d0b108e48923@eviden.com>
 <fe4c0209-ae9f-4353-8ebd-8e0d6d251b2f@oracle.com>
In-Reply-To: <fe4c0209-ae9f-4353-8ebd-8e0d6d251b2f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0701MB6847:EE_|AM7PR07MB6216:EE_
x-ms-office365-filtering-correlation-id: df68a46b-5610-4ff1-db92-08dda98b843c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTFxQTNLd0tpb2tPM0d3TFNIbTNocFRydnZNcTJhZUhCcWdDbmorWUdDZEFa?=
 =?utf-8?B?UFk1NVVzSFN2TjNZYTJGQmRtcjlrbDNLTnVEd2ttcmZqaEJ2ck1UQzhHOEhC?=
 =?utf-8?B?NUFFOXVha1VMR3YyeWtmZ25vTi9BV296TVp2RThsQm54UjIyNXlKazBWU21s?=
 =?utf-8?B?WnFSa2ltdFJWUmN2UkNpQVFFc1NzV0hLZEtoZUFhSlNQeFZjd3diTEZnbVJa?=
 =?utf-8?B?V1Bka3FkcTRHclZ1YW9Hd3NCYzNkNFo5R1lCT3VLN205NXNQbzVMMWhJRnhM?=
 =?utf-8?B?NXJnZG5NR01LR2xuN3JtU3RjRVo1WVFSQ3VKY0d0dHlpZi9oL1F2akdUYU50?=
 =?utf-8?B?c1VSbC83bDNENXJka2RkRnZrTnR1dTh1aGN5RjNEUWswbzlHUWhmNng0NkQ4?=
 =?utf-8?B?TzVkZkpFdXgyYU9UUWFpM0diWXZHNDNyUFdxTVRhbk1MN1IwVlhUWUV0WWlk?=
 =?utf-8?B?ZlZ2SmxyWk9kcGs1eWhhcmY3dE1CZkIxbTdjbzhxenlLdDlkWHBjbnNtMGZL?=
 =?utf-8?B?WXlBSjhlSWNYbzRzZlpuTVY2SU5ISERsbWg5dEk1czUrVmVERFVKSTVOTXNh?=
 =?utf-8?B?UXFiS05vYjBJa29udUUxMjVmWXVvSlgvZnNVbGZnajZjUWV1a2h4eWhYSllP?=
 =?utf-8?B?eTdoT1BxNmJJc2VlTVVVcldpMkRRN252VUJDdkZzaXdURHpVdThXUGsyL3pz?=
 =?utf-8?B?cWYrSDFtMHZCbFc3MUhkSmlGK1YvVzFZYjBWMk5zMUJNOXM1OGovZk9sKys2?=
 =?utf-8?B?MXkyTDZNcEJ2YXlKQXcyckF1VjZ2WWF4c21IVkw0SHVCOE5pclNwdkwzendi?=
 =?utf-8?B?clVDbTdUU0Jid0NzTDBySEJEejdjSG9uYXNoZ2N4QmpDRm9tdFVsczJ2aVE1?=
 =?utf-8?B?ZUdsVkxqWWZra1pRaVVmTDlKeWxtemkwbmgwY0NJMlRNcFlCTENreWY5SGVK?=
 =?utf-8?B?aFl4YjR0VmNmRE5leExoVGpMcndRZjJyWGk0RVNYYlBncFFLTDlOVmkrNFIy?=
 =?utf-8?B?dG1xbXY5L0loWlRxU2dyZmkySkQrdmNtQlE2STdnSkRWL21jczlKdlZla0J0?=
 =?utf-8?B?QW1kYW5TRjlDK2syUzBjTE5pQlM3SC9jZGxsM0g4TzN6ZXFEY1RUU3BFZ0dn?=
 =?utf-8?B?b0RpQ3c2OHQ0bU03ZUk3d0Y2YWdHdGlOSlhOY1JrMW1ma09zTnJwdGJYTllz?=
 =?utf-8?B?U2xsaDN0ZGREMkZualZsZEVhejBIUnlPeGdjUWNac0xZZ0poSmppcEg0RUVD?=
 =?utf-8?B?VndzejJ6Si9wQmpWMXRJV3BJZG1XUlIzcTBCMVNMWFN1Snc5UGdCeG5Yello?=
 =?utf-8?B?ckRQNmV3M1ZHNkpxRzJCOWYvbDA1T1l6Q2Z6Z2xHUXNHcUNuWDZhaHVkQ0Z3?=
 =?utf-8?B?bHlkcHdib1RQOUdiTlRObUdJcTBjUTY2OXFiSWY5UVBuNi92bW1lWGM0Ykdt?=
 =?utf-8?B?ZFFWTnMzMnZ5U21QVnc5Y2NkaHpJNTFKOE95cUdySWlpNldPUFBJSlRkNlp3?=
 =?utf-8?B?dkcwZGV4T2FvRmpIcHRVOUtCd0pWT2hzSDlWazJMUEIwVllTSFVlSnIyYjZa?=
 =?utf-8?B?RUswaFlDRm1QZ3J2TmFxUG9UbXRxUGRhT1E5eFcwaWpkNjRlWjhxbU1rOUFm?=
 =?utf-8?B?ZnlTbUlPcHMvOE5HSDBFampMT28rSzZRV3hiUHBPT0J4MFNQalo2NDlJaXZk?=
 =?utf-8?B?NGxXTlZuZTRKc3RKWmhNRU1qUEJockJseDdKdThZOUN1N0ZuTlVuYVpHSlFB?=
 =?utf-8?B?RS8rYjVXRU84RXMyN0dPRklNelFBL2ptaXc3dytQaElIRzFDK01TSlBGdWdB?=
 =?utf-8?B?V2Q3QWliTFBER2hkcmcxV21LSzNGWVdjT0dqdHlndWFEWXVQVWI1NUNEREpm?=
 =?utf-8?B?TG1zbGRmNEtJaFNzL1F0N0ROL2xmeEhaMmNPYzRHbnZMckpoVTRKL3RncmlN?=
 =?utf-8?B?RTdZdmZQSHE0YWRDemdXK05QcUJJaTN3b3ZBRFpOMG1ybC9WbjdpVGVBYXVW?=
 =?utf-8?B?UEhCQTNncFpnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0701MB6847.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjNMVE10TXozdmxQd0NsMHNlMmNQNHVoeUZpV2ZUbVNQdFF1UEY1dXZrd3B4?=
 =?utf-8?B?K3BDcVRRdXFzK1RlM3FXWFVSOFlKMjlnSWlraFBoL1NpQTNTTVBUczJPbXZ5?=
 =?utf-8?B?aUxaWXlZZkJRUTFIMkFqMDR6VXN6OUwvOXZpSGtRcjg0ckJBR0xOMHJCTGNN?=
 =?utf-8?B?ZW5hRHFIMjBvcEZ2TmEyMVp3eUxGSXNMenZIQUpkVWsxYzlybjVjaUxzMjJI?=
 =?utf-8?B?bFN1aEEraERXK1RsMlJtMW04Tld1cHQ2cmcrOFVmaDEvMFh5SFREaWRiVlVZ?=
 =?utf-8?B?Y1lFdmNCV1FMQWlOT01WU2liVVJER1FmZ2FNSUpjTWVtZkZXbEIrMlUvSnVK?=
 =?utf-8?B?SDFUVlpsbjhUSDhCL3ZzWHljNE5BYmMxRzViWEhXZnQzMFI5QVRlT1ZHaHhR?=
 =?utf-8?B?UlhaQTJhR0pHVFRtZEVCVHVaSEhmZkdCbVcrVTN4M09QUHFZazY2U1ZmeUtu?=
 =?utf-8?B?SFFiN2tuaG4xaENnb0NKV1R3bUZmN0JITmR4eXZJUmtjaUQ3US9vNzZUN2hY?=
 =?utf-8?B?aXFwMnBNbEZaK2IzTGhJWG9JeCtTYmY3T3ZQb1poaCt2S3pMTVRaQWxGenFj?=
 =?utf-8?B?MlBTV0FwK1NaWHo4cjZydDJ3VmZrcUdrdU8rdU9IYVcrZURmKzYxWTZSUG12?=
 =?utf-8?B?NUtzMkgxYnNRQ3BpL0prWlI0aWk1NDVmeFJxMXdoeTk0S2dPaWVBT2FYWkNR?=
 =?utf-8?B?dDdlRnBoTDlINlBRWk14S3ZXNEk3Vi9YdFNjNXU2Q3l1OWRiV0VMVTRiU0N0?=
 =?utf-8?B?MFF0ZmM3dVFsUjV3SDk1NnBtYTBrQ1V4YUNpQnhyZ2hTVzRIU2tqL1lOQzhh?=
 =?utf-8?B?RG94NzljeENWNWpRQlNBNFdZdWcxTjQ2UnFubWFpZlh3cWNqUmJCUEYveGgv?=
 =?utf-8?B?LzBoUWwzZ1BvWFhVMkczclJya0lzZk8zcG9YeFFQU01aMzMrZ015RllUTUQr?=
 =?utf-8?B?eTdVRnhTUjFXcDJ4TmVrb21Db0dXOXJTYWhkcVgreHNVdWhtcFBNbmltS1NG?=
 =?utf-8?B?QkNMaDZ6QytMd0hKR1ViU09CNjQwdWxBMnRvWXJWYTR1S2lTaU41eTE2eFd4?=
 =?utf-8?B?VzMvNThOV1BtUmJva0ZQcDFFbThYVExMSFE4Z2dwVEwzcnM0bWJna3FQQ0g1?=
 =?utf-8?B?LzNGUU1zcFcyWkdXeTV4bVMwLzBDYk9yVTZ6UFd5OWJHWG9kUDlOZ0NIdllz?=
 =?utf-8?B?OGY2OWFYNEUxUGRTVktxaVJmM2VyMk9Rb05HMEVPQStDaG9PaFpoTXBJY2J4?=
 =?utf-8?B?K3ZZb2N5SkV6aVZGMzRpdDNBSmhqa2wxT1ZtOGZaM1RNU1lTNHBrZWFpbXkz?=
 =?utf-8?B?KzAzTzBsZWpmd0g0TEZPV3NrcmEya0hZNkFLUW0rWjlXdU1QYnFzaFBVRUdF?=
 =?utf-8?B?VHBrMHdvZXc4dlcvWW1semlCaTlpYkN0NlJmeXUvVFlFNzJHT3p1MWpnZEVU?=
 =?utf-8?B?QWM2azNka2lsRzF3L3FVUktaV09xWWR0M3BKZnlZNjhia0RSMjhScjhHZkgy?=
 =?utf-8?B?b1ZWeTR4UFpibWtKY1FLeDdwVDNuMVlyQnFBQ3E4a3RQaFAxMEZLaVNYck1B?=
 =?utf-8?B?TVA1MENqRkV5RlQvYW1UR3h2MFdtTjBjbml3MFN3ZHFKK1o5S0taUEdLMVdr?=
 =?utf-8?B?WUp5YTRnYzdYcTltRDMwS1lRWFl4cVBvb01WSXlDYUl5OWlCbEppSk0yYmY2?=
 =?utf-8?B?RzUxdXdpSjFab0xZa2d1QTJ1NW03ejJwTHExYTk4WVRTRGJoMThGdjRnbXNW?=
 =?utf-8?B?SHIveDE3NmMzQUpSNUZzcjEwNjBHeUlHQUt6RHQwVVBMTkh1U3dWcHJXbDh5?=
 =?utf-8?B?OWdYODI2eHJrcFpTZFd6YU53czMrTjVhZk00cEs4Rzdvby9Ia09sTVQzcFRR?=
 =?utf-8?B?TU54WGtFRUsyRFdIRVROSnkydUREa2hiUDgrc2RWeW52ZjBBcU03ZTR4NDM0?=
 =?utf-8?B?OG1PelNXdm41bURVZnlDc1RZUDV4ckp1d25rNjA1SENNS292b0JCMit1RlJn?=
 =?utf-8?B?RW1ld1ZBdnI1bWpoL2JTQkpmdm9jenBUdTN6RlU5cDYvODNYT2o0akNKWHZL?=
 =?utf-8?B?LzFvRi9scnVwaGgrQWNmaGt6eXZHYU5vTm01RjZUUXJSUGJVampPTHJtUEs3?=
 =?utf-8?B?dHFRa1k2citoNFV2Z21uTGxFSWZTZWtnQVpLWVJ4cXRIZlc3cnU5TVpWVWJO?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42FC2D924C2F104CA4A4085BE80AC54D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB6847.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df68a46b-5610-4ff1-db92-08dda98b843c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:31:24.0305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OWWZMEcEoeAYq04Q3OBU0KRlwWkDXNIQhb5ve5cCxyWPVbGUeLc2gFiLjAYowk6M6JlTeVB6i6TA/A5qQqGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6216
Received-SPF: pass client-ip=80.78.11.84; envelope-from=ethan.milon@eviden.com;
 helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGksDQoNCk9uIDUvMjEvMjUgNDo0OSBQTSwgQWxlamFuZHJvIEppbWVuZXogd3JvdGU6DQo+IENh
dXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBs
aW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBIaSBFdGhhbiwNCj4gDQo+IE9u
IDUvMjAvMjUgNjoxOCBBTSwgRXRoYW4gTUlMT04gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiA1
LzIvMjUgNDoxNSBBTSwgQWxlamFuZHJvIEppbWVuZXogd3JvdGU6DQo+IA0KPj4+IEV4dHJhY3Rp
bmcgdGhlIERURSBmcm9tIGEgZ2l2ZW4gQU1EVklBZGRyZXNzU3BhY2UgcG9pbnRlciBzdHJ1Y3R1
cmUgaXMgYQ0KPj4+IGNvbW1vbiBvcGVyYXRpb24gcmVxdWlyZWQgZm9yIHN5bmNpbmcgdGhlIHNo
YWRvdyBwYWdlIHRhYmxlcy4gSW1wbGVtZW50IGENCj4+PiBoZWxwZXIgdG8gZG8gaXQgYW5kIGNo
ZWNrIGZvciBjb21tb24gZXJyb3IgY29uZGl0aW9ucy4NCj4+Pg0KPiANCj4+PiArLyoNCj4+PiAr
ICogVGhlc2UgJ2ZhdWx0JyByZWFzb25zIGhhdmUgYW4gb3ZlcmxvYWRlZCBtZWFuaW5nIHNpbmNl
IHRoZXkgYXJlIG5vdCBvbmx5DQo+Pj4gKyAqIGludGVuZGVkIGZvciBkZXNjcmliaW5nIHJlYXNv
bnMgdGhhdCBnZW5lcmF0ZSBhbiBJT19QQUdFX0ZBVUxUIGFzIHBlciB0aGUgQU1EDQo+Pj4gKyAq
IElPTU1VIHNwZWNpZmljYXRpb24sIGJ1dCBhcmUgYWxzbyB1c2VkIHRvIHNpZ25hbCBpbnRlcm5h
bCBlcnJvcnMgaW4gdGhlDQo+Pj4gKyAqIGVtdWxhdGlvbiBjb2RlLg0KPj4+ICsgKi8NCj4+PiAr
dHlwZWRlZiBlbnVtIEFNRFZJRmF1bHRSZWFzb24gew0KPj4+ICsgICAgQU1EVklfRlJfRFRFX1JU
Ul9FUlIgPSAxLCAgIC8qIEZhaWx1cmUgdG8gcmV0cmlldmUgRFRFICovDQo+Pj4gKyAgICBBTURW
SV9GUl9EVEVfViwgICAgICAgICAgICAgLyogRFRFW1ZdID0gMCAqLw0KPj4+ICsgICAgQU1EVklf
RlJfRFRFX1RWLCAgICAgICAgICAgIC8qIERURVtUVl0gPSAwICovDQo+Pj4gK30gQU1EVklGYXVs
dFJlYXNvbjsNCj4+PiArDQo+IA0KPj4+DQo+Pj4gK3N0YXRpYyBpbnQgYW1kdmlfYXNfdG9fZHRl
KEFNRFZJQWRkcmVzc1NwYWNlICphcywgdWludDY0X3QgKmR0ZSkNCj4+PiArew0KPj4+ICsgICAg
dWludDE2X3QgZGV2aWQgPSBQQ0lfQlVJTERfQkRGKGFzLT5idXNfbnVtLCBhcy0+ZGV2Zm4pOw0K
Pj4+ICsgICAgQU1EVklTdGF0ZSAqcyA9IGFzLT5pb21tdV9zdGF0ZTsNCj4+PiArDQo+Pj4gKyAg
ICBpZiAoIWFtZHZpX2dldF9kdGUocywgZGV2aWQsIGR0ZSkpIHsNCj4+PiArICAgICAgICAvKiBV
bmFibGUgdG8gcmV0cmlldmUgRFRFIGZvciBkZXZpZCAqLw0KPj4+ICsgICAgICAgIHJldHVybiAt
QU1EVklfRlJfRFRFX1JUUl9FUlI7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCEo
ZHRlWzBdICYgQU1EVklfREVWX1ZBTElEKSkgew0KPj4+ICsgICAgICAgIC8qIERURVtWXSBub3Qg
c2V0LCBhZGRyZXNzIGlzIHBhc3NlZCB1bnRyYW5zbGF0ZWQgZm9yIGRldmlkICovDQo+Pj4gKyAg
ICAgICAgcmV0dXJuIC1BTURWSV9GUl9EVEVfVjsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAg
ICBpZiAoIShkdGVbMF0gJiBBTURWSV9ERVZfVFJBTlNMQVRJT05fVkFMSUQpKSB7DQo+Pj4gKyAg
ICAgICAgLyogRFRFW1RWXSBub3Qgc2V0LCBob3N0IHBhZ2UgdGFibGUgbm90IHZhbGlkIGZvciBk
ZXZpZCAqLw0KPj4+ICsgICAgICAgIHJldHVybiAtQU1EVklfRlJfRFRFX1RWOw0KPj4+ICsgICAg
fQ0KPj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4gK30NCj4+PiArDQo+Pg0KPj4gSSdtIG5vdCBzdXJl
IHRoZSBuZXcgYW1kdmlfYXNfdG9fZHRlKCkgaGVscGVyIGFkZHMgbXVjaC4gSXQganVzdCB3cmFw
cyBhDQo+PiBmZXcgY2hlY2tzIGFuZCBtYWtlcyBpdCBoYXJkZXIgdG8gcmVwb3J0IGZhdWx0cyBw
cm9wZXJseSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gSSBhbSBhZnJhaWQgSSBkb24ndCB1bmRlcnN0
YW5kIHRoaXMgYXJndW1lbnQuIEhvdyBkb2VzIGl0IG1ha2UgaXQNCj4gaGFyZGVyPyBJdCByZXR1
cm5zIDAgb24gc3VjY2VzcywgYW5kIGEgbmVnYXRpdmUgdmFsdWUgaW4gY2FzZSBvZiBlcnJvciwN
Cj4gYW5kIHRoZSBlcnJvciB0eXBlIGNhbiBiZSBjaGVja2VkIGFuZCBoYW5kbGVkIGFzIG5lZWRl
ZCBieSB0aGUgY2FsbGVyLg0KPiANCg0KWW91J3JlIHJpZ2h0LCBJIGluaXRpYWxseSB0aG91Z2h0
IHRoZSBhbWR2aV9hc190b19kdGUoKSBoZWxwZXIgbWlnaHQNCm1ha2UgcHJvcGVyIGZhdWx0IHJl
cG9ydGluZyBoYXJkZXIsIGJ1dCBvbiBzZWNvbmQgbG9vaywgaXQgc2hvdWxkbid0IGJlDQphIHBy
b2JsZW0uDQoNCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2hlY2tzIGZvciAzIGJhc2lj
IHBvc3NpYmxlIGZhaWx1cmVzIGFuZCBtYXBzDQo+IHRoZW0gdG8gZXJyb3JzOg0KPiANCj4gQU1E
VklfRlJfRFRFX1JUUl9FUlIgLS0+IFRoaXMgZ2VuZXJhbGx5IG1lYW5zIHNvbWV0aGluZyBpcyB2
ZXJ5IHdyb25nDQo+IA0KDQpGb3IgQU1EVklfRlJfRFRFX1JUUl9FUlIsIHdvdWxkIGl0IG1ha2Ug
c2Vuc2UgdG8gYmUgbW9yZSBzcGVjaWZpYz8gUmlnaHQNCm5vdywgaXQgY291bGQgbWVhbiBlaXRo
ZXIgYSBoYXJkd2FyZSBpc3N1ZSBvciBhIG1hbGZvcm1lZCBEVEUuIE9yIHNob3VsZA0KaXQgYmUg
c3BsaXQgdXAgaW4gYSBmdXR1cmUgcGF0Y2ggd2l0aCBwcm9wZXIgZmF1bHQgcmVwb3J0aW5nIGlt
cGxlbWVudGVkPw0KDQo+IEFNRFZJX0ZSX0RURV9WIGFuZC9vciBBTURWSV9GUl9EVEVfVFYgaS5l
LiBWPTEsIFRWPTEgLS0+IFRoaXMgaXMgYSBiYXNpYw0KPiBjb25kaXRpb24gdGhhdCBtdWx0aXBs
ZSBEVEUgZmllbGRzIHJlcXVpcmUgdG8gYmUgY29uc2lkZXJlZCB2YWxpZC4NCj4gDQo+IEV2ZXJ5
IHRpbWUgd2UgbmVlZCB0byByZXRyaWV2ZSBhIERURSAoZm9yIGN1cnJlbnQgYW5kIGZ1dHVyZSBm
ZWF0dXJlcykNCj4gd2UgbmVlZCB0byBtaW5pbWFsbHkgY2hlY2sgZm9yIHRob3NlIGNvbmRpdGlv
bnMuDQo+IA0KPj4gSXMgdGhlcmUgYSByZWFzb24gdGhpcyBjb3VsZG4ndCBiZSBoYW5kbGVkIGlu
bGluZT8NCj4gDQo+IERpc2NvdW50aW5nIGZ1dHVyZSB1c2VzLCBqdXN0IGJ5IHRoZSBlbmQgb2Yg
dGhlIHNlcmllcyB5b3UgaGF2ZSA1DQo+IGRpZmZlcmVudCBjYWxsZXJzIG9mIHRoaXMgZnVuY3Rp
b24sIHRoYXQgaXMgYSBsb3Qgb2YgY29kZSBkdXBsaWNhdGlvbi4uLg0KPiANCg0KQWgsIG15IG1p
c3Rha2UsIEkgZGlkbuKAmXQgbm90aWNlIGFsbCB0aGUgY2FsbGVycy4NCg0KVGhhbmssDQpFdGhh
bg0KDQo+IFRoYW5rIHlvdSwNCj4gQWxlamFuZHJvDQo+IA0KPiANCj4gDQo+IA0K

