Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A94E64008
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCAVC-0007vZ-No; Mon, 13 Apr 2026 02:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wCAVB-0007vH-2I
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:10:29 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wCAV8-00028h-F5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1776060626; x=1807596626;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=y2vDER4/HfCfTshdpDrqmZNAkRuYo1gGQ8mUGq+Ud9k=;
 b=a2d0pcvVsuxtwZpuoaAIgSas6XC0IGiNF8oQu1dEgeCjEY3hJNA0q8w8
 28L85yZIhV2HdCVqLBpLCXkuJFgXzU/zCrs9LE1eEPcYCNO+/nrhvZRQ+
 5HofJQNxF1vrE3TFRVar4SrCpB9szmNZSBnt/k5++UtAxWV8UouFRh4bn
 OcW9Of0ctEzhKpsJH9grIMrDpo0pjjVWVyQ46MFclPjUWDr/AhncRoHua
 dH3TaknfhObMTqwIkZKuaEu+5ie5TkKGCjy/Zur9piXttbgnJ6rzDE4mo
 Fh7eU+EFzoW1ftFuk60hFsvSi2Y0Dm5yp0Kwzaprtc2W1c4cjHYWW+Ee5 Q==;
X-CSE-ConnectionGUID: lexgvF1kTWSiZAcks0kIUg==
X-CSE-MsgGUID: aHq7f1CaQ8Sq87NtViqBRg==
IronPort-SDR: 69dc88cd_ur01uRBGf1VaYV0xWeiAdNjIpgw931IAtEmHf9rmRdsUvRz
 XtXhczO+BX8WOt5NTqwz8SZWrST1cC52aUXln7Q==
X-IronPort-AV: E=Sophos;i="6.23,176,1770591600"; d="scan'208";a="49595454"
X-MGA-submission: =?us-ascii?q?MDHX4q3D1z02pGmLlHF7t6dfJ41Qs+QgNwRv5z?=
 =?us-ascii?q?48syCE11ZTHd78mvRcVlxyQy0UwVll3c7+TxIXbGuOcvbrTDDWdXPf8K?=
 =?us-ascii?q?XdaE/20bbhW30nBY9OKpsqPmKFDctk8Cfe9mxkrdSSXGbcTePE8tSAiX?=
 =?us-ascii?q?XWgnD154fwipqPUvq80VgxBw=3D=3D?=
Received: from mail-norwayeastazon11013038.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.38])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Apr 2026 08:10:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mim6Lp6Z9NZLQJBKYX7asNVZXbmBEPx7QbFdbMqGpS9U0kdaCTH9U/l3cXYzXAkMMNkgB2CI/Kjp2pwBzo+t+H/rzq8vGng78zeEZjfvZN6My0SQI9W1kqFbMyXq2laH7IyNr3wncSE+6tcO/wN1ytl93HSDmEwzhZhtjbfZQnpPfyS7tY/w9P5QB1j8iOoWOS0QOg5UlJIJs3vklr+lFkZ/jHIajtYtLzLC9VLCyjKKTCLRxQAMgoeyvbV/d1cAcSBx2/n//OX1rckNAp+UDYX7/rWFMSXQCHeTBcrWeo/0P1MNLDb1ExoU20ZqbnRVp8bIo/KGvYtkJq0qbfnFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2vDER4/HfCfTshdpDrqmZNAkRuYo1gGQ8mUGq+Ud9k=;
 b=ekijh4xiI5yS8MfzMHRPT9kYxRjGxv21q/IBIPXPdsc7kBqM3Fvm3UpLdNRb8p6SqE+HsugR1oRqsyCjvZUXq8oqBXqAN06es3Of0PaTlY9JbY0XIYqzoLqHxSuvtLh81zc93/mJ4yulctFjOUkpD+gPIEiTafBCRuIbRF7Hbl1TeS2FP1oMETuSuxLTtt5DD7EYCYYniMguZb+LHGnMCKt7QfA+FWbg5XQys7rqG2XejvE2GFkHPauKOiLa3VBCava9ZKG8d46MikesQkBvwPLatu9q8awqUegVTUe/BiOwQVtxUvOXejV411pmjj8GilJ7F85/lz7Zj/An87Lq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB10401.eurprd07.prod.outlook.com (2603:10a6:20b:6c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 06:10:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 06:10:16 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v3 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v3 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcwx3hQnIUfkA3wEKuuudWklQUdLXckfyA
Date: Mon, 13 Apr 2026 06:10:16 +0000
Message-ID: <98b5d756f1bcfc9d206d91dfb2818bc8fe440f54.camel@bull.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-14-zhenzhong.duan@intel.com>
In-Reply-To: <20260403035541.18355-14-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB10401:EE_
x-ms-office365-filtering-correlation-id: 775351c8-80e6-42c9-6942-08de99235566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: P1Ed+gn7Hf7rHSWCOSUUSO5ef+7nLg8zh794B9v4QYMk1YaPpCAEtmRfVK7xqIMYcPnKSTU/brF5hybrDPM7jglXEw6o7ogsRERc1ak0rF/cdf3OBitTO8XNJweN7PO9BYYzIl7+KrtLHO5kAUe1Qml9r2+YU8ysZtOtp/Tz7UQpEW+GM/uhUC8fcnw+R3wPd9/764tIYXBp8d9VP0Ez3LzPFdTL1KA7sBgstBY0z53xSpfA//d/mWl/kY4zLBwKrJRa7LM3duraMq7/EpMHbuBxh4MjEHSwjG1V3WbYo+61b3L7XNxJHszTmBo1+0TOdfsFd9LX7uwzoFfIKQ0AELmyN+Df65CMLg6E8+Q/isSh9vhD1YFatM+rwNFwnuBphAKOA7faYUb31NDsUpjj01Jb9F2oAcbctgpViz/2J6/sHx9T+Wmw8rjoK6ITgxLGOMHKAzeOqbftxKZexgB+EqpUspv9ralQ3fj8+QpqOCW+YqdHgjDcz00wexFeY4IjAHAeqzmZVH+3l4zjZEH872ddX0BXop5gmqg5jhhfxSeh27ktqx9kVkxfvIEDhXqAyrEXb5Yr4jJZn/D2Dl/MEorqHANnf9MYzfiQn8m4U4XsONr5qiFCcN004FNNhg35VpatY0frAX43gVZ7XEBVqgc9G6P8cZMLoPDECqEUiuyyy63Qq+TnknXn393qdgA5EXOO+1zv/LYmzn/ZahcHRLJTa6g4yfO26wgno/ECyASFLmT9yGQl0DHfoXzEmEfE2Fs1MgJKD0W25Iok4pZGDZHddVc+0bQfSCSzYYdW9AU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXNZQW1BZDR2aHNWWWJ1ZUQyT2JJZGFKZy82Mk5XZTc5WTQyZFhvV1NOOE96?=
 =?utf-8?B?V01RTUcyOEZTL2FDK09GZFhDQzdTQ2FoWnlhSUhNQ1l0YlBjc3hWZ1VEdzhs?=
 =?utf-8?B?ZzExRm1Ha2MwdzdWQW9jMmxQbmlzby9SZ2tqSEdqcXAzZGhXSVU4blZoeFc3?=
 =?utf-8?B?SnprSzc1ckZhV1dCZnE5TEtkZWRONkdIS0d6S3A3SXloaGFFTTRMbEZHYmlm?=
 =?utf-8?B?NnprRFRkOGxEZTFnWDM2K3psLy9nOEw5ZUQ2U1krdGhGTjEwbUhmajNpK1Uz?=
 =?utf-8?B?VjRlMmJ2QWhRb2RFbWRGcVZtbU5CTGJrNlA3VmVrVGxXOUt2dm11VVVhME9M?=
 =?utf-8?B?ZUcxUG9wS21UTENrVHE3MTNsc2Z4V3kwTGtGZnRmbUhrQTM4ejROYVkyOUs4?=
 =?utf-8?B?UytJNmFLMzNYMFZrQVY5R1Q3OVVEbWlWZGR1NTV5RnVUckkyOUFSdjROWmxY?=
 =?utf-8?B?ZjloRlhIYVFjek1OUXBQMjRRVjBtNXNRaVZhbVRiNnN1UFFCWnVjOTRNQUJ4?=
 =?utf-8?B?SW50U0lIaDlNd2tBZFlPUjhwR1BmalVlb1JYYTB5RFBPckowQk5vWGE0b0tx?=
 =?utf-8?B?R285ZXBoMGhpaUFvdEREajZmc3VEbnZucXk4VlBvMDNYbnplNzFKOVdKbWJF?=
 =?utf-8?B?SFQwUk1tdVovcUZLdkJrdVpTVzkwd2JGU3Y4amUzZ1RINnMxd25Cc285dGVV?=
 =?utf-8?B?YVVJSmxjQXVPNkVpUkE0YkZ4amVGQ3U4czVNblBLRmROUzgzQU5MZ0xmblhB?=
 =?utf-8?B?bUdJOExCZWkvZjBiN0JraXpIK2NLRFRabXZad0FEd0U0R0FaV21PZ2dyRHN4?=
 =?utf-8?B?N1I1STh1UC8wUzZnbXpEc1c0WXV0ZEkycGlWbUVMZ0dGTlBaYXpFNkMvdTdx?=
 =?utf-8?B?MEx2QVFrdnBhc1JQOG5YUHpwcVg2RlkwdDJJRkpkYVUxMmlMUHFBRVlVK0VP?=
 =?utf-8?B?Z01odXA3dWlsd2ZLZTU3K2hnejY2aTlHYzBFWTJKSkFGbDhEMEF5cXpqbFJT?=
 =?utf-8?B?SWYrUmFhK1NJODUzbUVvUUlXVU1SYTA0dlpjSldrc3oyVUpubFl3aG1CYnls?=
 =?utf-8?B?M2w2cThZWGNoWlorSElBekkzblhScFQwUkZrTU1lbjR1U01vNCtHTXRzOHl0?=
 =?utf-8?B?NlZoMUxTT1luaVBMdGd1Z1c4VU5KcllybGZCdEk1T2ZlWmRTS1lKTkhsYm94?=
 =?utf-8?B?cm8wQW55bGh4K1dFVkZCV0VENDhXOUJhU1diYW9SSFR5VWZsTkxWM3o3cFg5?=
 =?utf-8?B?eHc1QnVMbDFiTjM4SlZUNk9IemhFZHJ6NXd4SHpKNzkzT1JjZjhZQnF4UU5u?=
 =?utf-8?B?dWZNR2Q0dDhRRkZ6R3Y1Y3Y0WHRvUkxtOUYrRlVIZFd3VHN3MmlueFovMndE?=
 =?utf-8?B?bTEvQVdxMkY0WGpMWDZGY1lac20yTG0zenVQVkd1YXhSanpYdGc1aWJ3SVRZ?=
 =?utf-8?B?cnk2U1FkeUZyeFZ3YUdpRjEwNnBPUWxvT2U5QUVpb1Z5VzlxSXROQVgxa0lU?=
 =?utf-8?B?Y0FWNDFRWjRLUHF3Q1Z5QURKM0I3UjR6WnN5ekFhZzUrZzJQOE1ST2NxajJ3?=
 =?utf-8?B?ZHM1eStXdzVkeGtxMmVhTGdUVVpqN3grd0xqdjZTNG5iSjJQUDkyZ3lha3I3?=
 =?utf-8?B?MTJuczZJNktQR0xLKzh6WEZ6K29RR2N5eitPa1duSW84clpRYzduOUtncmRm?=
 =?utf-8?B?bDVQVkRucHNTR0l0QU9UTEc0YnRmc2Y3Qmd2SGRNa3VqaVlCVDA4VzdEUEFl?=
 =?utf-8?B?NDkrVFRsdWkyUnRGcDhTUDhNQnpSYmdaOG15REU1a0lLMG1pK1RRbmVSQTBq?=
 =?utf-8?B?eUQyblYxZzdyQXh4Q3NYSWVrZFVya3RWUThzR2VLZUd5R3EwUjdjaGI4K0x6?=
 =?utf-8?B?VmN1cXBzSFU4Y3dDZldIMnJqRW9QbGxWV1NhODhtOXlKOUtTVXhNQmphWml5?=
 =?utf-8?B?dUhMOVJTcCs0aUxEeFV1cTE2MTFJdkhPWnZ3bGNHWGJZS3BZY0x0elppMlpX?=
 =?utf-8?B?RnZVaDZuZTlPR09hT2dvQlVoeGRHZE1CejhDamVkaklpMjM2RGZEd1B2R21q?=
 =?utf-8?B?S0o5ZGdIT3F2K2RTaFVnRjVLYkdMZnFIN3Z1a2xMZGtvL3lFSG95cG1TNHpl?=
 =?utf-8?B?WVF0RWd1bElzUjBmQ0xRWTJCdHdSYnA4UW43c0ZPUnJxVHRMU040blFnSWJq?=
 =?utf-8?B?a2RQRVhoVk5RdWloOVhCdzlOSTJpa0l0RThEdzhOeFhlcFJGakxqNFZQUFBn?=
 =?utf-8?B?K2pYdEd4ZkhKaHF3M2hZWGJWV0pEZ1BTbjVvOUlJRWtNUHhGNzRxWEYycWh2?=
 =?utf-8?B?ZU9STjVRNFJIRTBVa0cyTkJ4eXhnUlh0T1RuQ3EySnhFTmtyZW9GVUd3blNG?=
 =?utf-8?Q?7gEtWbe/R5nAOWG9WETNKPE4Vpcy4oNzyKu0w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C497104A6139A848ACAD77859D19452F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FzjIFBnSKlpopmwmO2dPTOeuxpc7qbXcc2OsNhmOmNbiCVboJDGmkMLcAEQmClM5zaAVLApou78pNPFEYE8KlEYAShH/7iHyWkKgfqpUlyC71XByGdr+1jkJ9OnPmSaRapi0Ltl4SQjC5JHb5dm9H+O4GRTbdRU4DVxN552kKRhWnXc/WmshPMuxRrrlwQbMDeHVZrOdjitm+D33KBJgJdVmX4Ku3F4QrZBpmjSImSEABPJMdEAvojZ79Q6CQfUk3uLqbu/Ex6hktV1ebJt8mc0vAFoogc8PmOTah/lQHhlKKhoUi/4yaFdcb4GnzVYKMkZxKF4e1ErSFTGMTTYVqw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775351c8-80e6-42c9-6942-08de99235566
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:10:16.8676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgGDa94iXokLueuu4uuKXX373M5k+Ki7ucyonut4DI7uVP/nSNJoRLWoTzNrpq7Kkk2ZWdOs491FLu6roqoEm32ScT5M82WyPufOuXFDSs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10401
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost4.eviden.com
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

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGJ1bGwuY29tPg0KDQpPbiBUaHUsIDIwMjYtMDQtMDIgYXQgMjM6NTUgLTA0MDAsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPiBJZiBwYXNpZCBiaXRzIHNpemUgaXMgYmlnZ2VyIHRoYW4gaG9zdCBz
aWRlLCBob3N0IGNvdWxkIGZhaWwgdG8gZW11bGF0ZSAgDQo+IGFsbCBiaW5kaW5ncyBpbiBndWVz
dC4gQWRkIGEgY2hlY2sgdG8gZmFpbCBkZXZpY2UgcGx1ZyBlYXJseS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86
emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4gIA0KPiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8gPFt4
dWRvbmcuaGFvQGludGVsLmNvbV0obWFpbHRvOnh1ZG9uZy5oYW9AaW50ZWwuY29tKT4gIA0KPiAt
LS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEgKyAgDQo+IMKgaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHwgOCArKysrKysrKyAgDQo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggIA0K
PiBpbmRleCAyYzcxNmM1Mjk3Li41MTlhZjNmYTkwIDEwMDY0NCAgDQo+IC0tLSBhL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaCAgDQo+IEBAIC0xOTYsNiArMTk2LDcgQEAgIA0KPiDCoCNkZWZpbmUgVlREX0VDQVBf
U1JTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDMxKSAgDQo+IMKgI2Rl
ZmluZSBWVERfRUNBUF9OV0ZTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCAz
MykgIA0KPiDCoCNkZWZpbmUgVlREX0VDQVBfU0VUX1BTUyh4LCB2KcKgwqDCoMKgwqAgKCh4KS0+
ZWNhcCA9IGRlcG9zaXQ2NCgoeCktPmVjYXAsIDM1LCA1LCB2KSkgIA0KPiArI2RlZmluZSBWVERf
RUNBUF9HRVRfUFNTKGVjYXApwqDCoMKgwqDCoCBleHRyYWN0NjQoZWNhcCwgMzUsIDUpICANCj4g
wqAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwg
PDwgNDApICANCj4gwqAjZGVmaW5lIFZURF9FQ0FQX1BEU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCA0MikgIA0KPiDCoCNkZWZpbmUgVlREX0VDQVBfU01UU8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDMpICANCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgDQo+
IGluZGV4IDYzNzdkYjFmYjkuLjMyZTJjNDYzM2YgMTAwNjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9hY2NlbC5jICANCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5j
ICANCj4gQEAgLTQ0LDYgKzQ0LDcgQEAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElP
TU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsICANCj4gwqDCoMKgwqAg
SG9zdElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hpb2QtPmhpb2Q7ICANCj4gwqDCoMKgwqAgc3Ry
dWN0IEhvc3RJT01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2FwczsgIA0KPiDCoMKgwqDC
oCBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgKnZ0ZCA9ICZjYXBzLT52ZW5kb3JfY2Fwcy52dGQ7
ICANCj4gK8KgwqDCoCB1aW50OF90IGhwYXNpZCA9IFZURF9FQ0FQX0dFVF9QU1ModnRkLT5lY2Fw
X3JlZykgKyAxOyAgDQo+IMKgwqDCoMKgIFBDSUJ1cyAqYnVzID0gdnRkX2hpb2QtPmJ1czsgIA0K
PiDCoMKgwqDCoCBQQ0lEZXZpY2UgKnBkZXYgPSBidXMtPmRldmljZXNbdnRkX2hpb2QtPmRldmZu
XTsgIA0KPiDCoCAgDQo+IEBAIC02NCw2ICs2NSwxMyBAQCBib29sIHZ0ZF9jaGVja19oaW9kX2Fj
Y2VsKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCwgIA0K
PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsgIA0KPiDCoMKgwqDCoCB9ICANCj4gwqAg
IA0KPiArwqDCoMKgIC8qIE9ubHkgZG8gdGhlIGNoZWNrIHdoZW4gaG9zdCBkZXZpY2Ugc3VwcG9y
dCBQQVNJRHMgKi8gIA0KPiArwqDCoMKgIGlmIChjYXBzLT5tYXhfcGFzaWRfbG9nMiAmJiBzLT5w
YXNpZCA+IGhwYXNpZCkgeyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJQ
QVNJRCBiaXRzIHNpemUgJWQgPiBob3N0IElPTU1VIFBBU0lEIGJpdHMgc2l6ZSAlZCIsICANCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5wYXNpZCwgaHBhc2lkKTsg
IA0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgDQo+ICvCoMKgwqAgfSAgDQo+ICsg
IA0KPiDCoMKgwqDCoCBpZiAocGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKHBkZXYsICZi
dXMsIE5VTEwsIE5VTEwpKSB7ICANCj4gwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAs
ICJIb3N0IGRldmljZSBkb3duc3RyZWFtIHRvIGEgUENJIGJyaWRnZSBpcyAiICANCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInVuc3VwcG9ydGVkIHdoZW4geC1mbHRz
PW9uIik7

