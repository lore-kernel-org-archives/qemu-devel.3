Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905BCC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Xsm-0007VV-BK; Mon, 21 Sep 2026 02:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8Xsk-0007VN-G9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:52:06 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x8Xsi-0000gq-8q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1789973524; x=1821509524;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q7LpHo7FgWR6AnIFsY4bp4lJA0O3pD+9ttnksDslBsc=;
 b=XFtd8mreUTf/880KaQXKyT1WXfD+u7xRgdRl9EMn2sQznBaMktOP+M19
 WKGDDBzThv8GTO0OlMhzXNqRE2oBhQ74tc9zmB6MCJglF5/5JfR0BWM73
 i08wD0iVy8mmQmYXKrVlszW4/yWzBsl+v3fP0tl9424RmnjOhm75x9+P0
 1SmdITyLx3rkbjqhU2NOYJi8bgiuSaqL9JRR9d/np4EHAxoReOd6mw7YH
 dfGWWNJ6WVzWWgWnyggpLARSGy/2wd72uYLxFhj/4cPto/A83pOzaZzhT
 WPHIz6Nd4sagPCEsYrVBethA2ag0dvsMAzIjkYIEOrd1lB1C+7UZUL/vg g==;
X-CSE-ConnectionGUID: wX2bw4qFRPyvzCU/pS6dEg==
X-CSE-MsgGUID: kc7sGlSeSx61EN+veaMpiA==
IronPort-SDR: 6ab0d410_sKyCvz3vXBfO4GHXbVpVEV4AWJEdmfUHBukTFkNDB03glrw
 +3zvKZQrxXbZ4iWCVPVdMytOpC6bDdD4k0KoFQg==
X-IronPort-AV: E=Sophos;i="6.27,114,1787004000"; d="scan'208";a="48790794"
X-MGA-submission: =?us-ascii?q?MDGvttizg+49BsF3myHIGB3CYNq9rLo1s4xl/k?=
 =?us-ascii?q?EaZu9v1xY9OmZ071yt2OECXLnwbAYedl1eWPsTFeTW+oL0EtC/7P7B7C?=
 =?us-ascii?q?DUJ3rXmh0ixttRJTZICOv0xkXFKiWOHPqwnoklH0js2iwg9f+1b2Zfqz?=
 =?us-ascii?q?HrjB6Me/6tv27OZ+bS1QAabQ=3D=3D?=
Received: from mail-westeuropeazon11011046.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.46])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Sep 2026 08:52:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acsj8xAsVRBzc3MtyrPJHTTWg+NsRqqw/DfYOYnPtB1HfDyLPDLu+j0cYRigldNJWPIyvrzWojbTkLftDvcmRE6DDwXwF2X90U/NKznRSTYcy9uLByZDwZRJ2es4LDHk5JGragz1XntcBLYhRM2k/M5tkCIXCB2CvNkysk+couT2H8vAjg23DScOuiD7JH4SE2Uih/01ELbAldQ3hRXAmap192IzSOr3TU/ZURH1ZJpM+lB4I7+wtruPiyKIf+4Lg9f0IU8dIJJZaZJUF6mPj4jLlK7fqjcjsqpRGOOO53vrevszg+9pN7BP8c94qE4k5jX8IRtTIPCkDesh+cKa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7LpHo7FgWR6AnIFsY4bp4lJA0O3pD+9ttnksDslBsc=;
 b=ZcvRW7dWcnIA9u4GoKuVBe1lj/m2PExLagpvgOqbyJgkSJ+l4DKbkyocoeeNU/G2wDBcwUgxEUQjqTiS9L+pYVoL7K0nG9fFSUseOaHYnn4cxB5k1ArqvfB/hK1foxxUa3OVCJfKebTY3sGJ+wIC44auboLPxF2X0q3kke1q2vd+lCy6KiiSN6E7SA8PMOCFubO1lXWAlyrjL9mXFmpdJ7P6jMOvLers5PCBT6obPUW+QhHtRfq3q5EplEweqXIIuNxpzoR3SSx0Rm1z+KuAa+HG3B6opPQQ5AeCMMU+l/zoSdrqvCtZeNboQLXBR+mX+yH3KbSqaGVPw/P1aRy59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS1PR07MB8592.eurprd07.prod.outlook.com (2603:10a6:20b:473::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 06:51:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 06:51:57 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdRcLu3SSC7ASZok6f9eLE7VV49bbYn9wA
Date: Mon, 21 Sep 2026 06:51:57 +0000
Message-ID: <287990529392c887cb53369260b08b728694a9bd.camel@bull.com>
References: <20260916100442.1034043-1-zhenzhong.duan@intel.com>
 <20260916100442.1034043-7-zhenzhong.duan@intel.com>
In-Reply-To: <20260916100442.1034043-7-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS1PR07MB8592:EE_
x-ms-office365-filtering-correlation-id: 4b055253-105c-4713-cad3-08df17acd433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 9XXIWcb04WfZxl1khn6mxcqEh5dT1jMwvEGMTl8hMvAux/qOo75vGn9L7hy9PiUiBrX4lOjQfBAhOMNXAnnnUcVLWcPKbH1hYNO8HoP7UCsP+4ieVQvcRxL06JEBBG3PLW35pn0d2Qrr51kb/qDobvjSMK8CjHNKJCHNIV97/jRTgFfLLi3vR+MHSwdRiLHsIdIpjPl9CoheYy9EU1WdqDQIrUzSJyIZYUg/A0g9rEGoS0xM3NI4Q8wiuG+ydHKgQGzLAt/+pyhhObGCfQTvcRkB60CAl9khaZ3msJRnvWMcloWUWmxug2+WrEyMzyeHoi4xF5PDAH2F01P+/zsF2YURpX9TullDl2M2evNfyKTb+AMSQgmFb1gzwH1m2Vj8u2Cix1oHCiI8hsLl9vY3yLaVl1H9fIyliUf3LNOzAJOKKSX7X3eegq4TU4nzngZnPibU9yYLV2FyrVclSuQJTk2/LXWSXDeCaxEmeQuXMIOVO8uHslmHUVuzQix5qelxiTrtLXFB/DDsYG0QvgKG4Y5aRjkH9dO+K+e6iwLFV3tysrpFIzhY6PeGp10f/BBF+kFLJ2osGmMDyaurUpOmNG1kYnr5IXh/8STS7v9Ofn4ezdPPkQ6TWGN6kDNCSiu71sMZW4jcbpI835iyKQ2YG1T5yVa2wV8JxwOfHCSmeW7lRcRyVa/vUpWJIiQCGgY5yqlnxymF47grbwM2WRC+HE/Ag/HCPSWYWbbJscQ85yY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNJTEpxMXhGR0NPcitLdjVvQXRJRTNlOUZVYzRNZFlSL2IwZTFLaUN5VzR0?=
 =?utf-8?B?RVpDU3J4S2RtQVBDRzJYZzlFVTRvS0hCQ2lna0w5ZU1GWmJJRHd5UVNsVXph?=
 =?utf-8?B?OFpmUk12VDY0dHMyMWIyTlR3QkxUWWN6NTBTVWlaR3Mya2VLa0VoVWk4ZlN1?=
 =?utf-8?B?K0xwZlBUR1BWR0JkZWc5a2FBZWdDRmlOcmNUSTlVTytUNHY0UGpUbkpiWEFl?=
 =?utf-8?B?WFpmZnJ3UXBNNUdnU1FqVzFOZGpubEluc29UNnFMWURkZFpqTGtUZzlIcUlr?=
 =?utf-8?B?TlNRcENEM1FKNHRFRmlKMzFBcHRnbDhTaXo1YThiUVpJdnpkSHlod3NQKzdW?=
 =?utf-8?B?dC9NNzlWcHRwNnZtT215SkNFbExwK3kvSXZ1MS9hNUo5OXR2b0xvdlBab3RH?=
 =?utf-8?B?QS9nQ1NNckZZelhzQzVXWG4zTUJERmpLM0RQbmdPTDNtRVJjaG9jY2RrL1VM?=
 =?utf-8?B?S0pJWnM4YkZkYmRGcjhmZTUwVzA5Z3hSOGM1dEN3ZEQ2WUc0SzNSSURXZDFj?=
 =?utf-8?B?V3R5V1A3U2J6UE9rMFB6VVp3Y3M2YTRvVEVpaTY3MEZvL1VSSVFidk5rdmF0?=
 =?utf-8?B?ZENnL1JZdmx0Q0oxS0d3RVlkWFh2cndJemhjc01xSjltUnBxSWhNV3VOSUdw?=
 =?utf-8?B?RzAzSGt1OVNuKzhjYnhROElYRUJTN3k0RUJsdm9HQ0xRZnMvTGkwdlIrY2JG?=
 =?utf-8?B?N05Ha0F2Tnp6clY3RzRLNGtRV2lZRENBRmZKZG1TZ0NuUXJHajRqclJuMjZa?=
 =?utf-8?B?WlMzY1I4ejJ6bVFuQk5VNGthaUdPbk9KbFVFaFM5V0ord0w2b2ZGRmF4Y3VX?=
 =?utf-8?B?YUFHSGZ5dFI3MjBxZFdYU0QvQkRNVmphMkI3d1NXVlhZUEdpVi81aUorZ2pU?=
 =?utf-8?B?OC94OWJ1K0wyVEM2bXN1emVKdlpvY1B5TjY4Z0lQNVRJVTJuRnZiTmhMbEVx?=
 =?utf-8?B?alEwbWRwMEV1YlFyaE0zbGI1U3VRbWFadXZPb3lwbzhGR1Y4aytKa3VRZWZp?=
 =?utf-8?B?SHRQRDU0c0J6MkZGYk84T2F6bHJuQU9wK3FaN2dQelhJejBtUnE2Sklocml5?=
 =?utf-8?B?N1ZvTCtESndINlE5dHpFZXdkbFBMK2U5NHJtMlNiOGN0MWQwWGxtRlJiVUlN?=
 =?utf-8?B?dE9lTW5yaHAxUGJYOHAwdnZqYW1MOG5YcG0yRWJSWWRrS2JQRmd2RDlYS2JT?=
 =?utf-8?B?Mjh1U3RDczNlV3JwUE1LMGo3SncrNEphbHJreG42TVl1VzdLWjA5NFBrSXp1?=
 =?utf-8?B?bzYyK05OSHh2M3ZiUWlJWFJsQm9WdWl3MUVYTnI2RThDOStBZVZ6RjJYdGNj?=
 =?utf-8?B?WEpSZUcxMG9URzMrUjJRU1Y0VjVuTGU1R3lLYVdqeDZFYUlrQTNaM0JDbVhm?=
 =?utf-8?B?NEJRcCswQm5VZXUwSWFGaXNoTjR5bVJuMWZJOWZRU0dBQ091TTNLNmJYOU9z?=
 =?utf-8?B?cnJzdklhNUt3VWQzVkZYanN0bEVlK3grTkxvbnhmRjNDKy9kTm9xZjYxUEYv?=
 =?utf-8?B?RkU3ZWtadTF4cUZSSFpudEd3dFkzK2ZlTlZRWlg4dWZWZXhJb0pPckRzMU9H?=
 =?utf-8?B?b2ptQUxJc3RBYjdRcGpQRUYraGN6SFlGUFUwUlphZmhyeHVLdURGV095c25X?=
 =?utf-8?B?TUsrbzdtVE9rdUwxQnpIaXhSMGhXVWloMWR5dzVpSHhkZHpQQ1ZYZEZJN3c0?=
 =?utf-8?B?UGRJcTE4b2k2eFF0anF4SjU3bVg2ZEVQWHp1MmhmeUpkeDFrYVdRMml4Tklz?=
 =?utf-8?B?N2VGSGFSbDEwSzFWa0dNYldxUHVNUmpMTW93L2RmTkhUNXE3UHlzSzBZY055?=
 =?utf-8?B?eE1kTmg3UVZVVUw4Z2tnTkhORGlDcVFsMlgvVVZKNHRsTGFyWVE1WFduVEdh?=
 =?utf-8?B?WHZrWTJTdG15N25lTUxUN1RaV0NPOEhSYjg5NW5MRGd0azl1ZXBrcHhCZnJP?=
 =?utf-8?B?ZzRvOUVvekZrNldXamlJek1mcktjWFprdFJqcXZVTkZxdm1YZU5UU0dnOEJF?=
 =?utf-8?B?NzZVdDdyN28vaE9IV3haUFM0RFJLblVISEFJa1gwYXZzRU80WGVRNlI5TDJx?=
 =?utf-8?B?N0tGT01XMk1ENHhHYlFvOVppWit1QW5ZWlZLZjdhNzdVUDJGMDdDMSt1UURo?=
 =?utf-8?B?U2N4M2hoSTllWDVSbHFicUVWemVxMDhjVGxkUTFPMGZvUVpTUUwzMi9RYTVa?=
 =?utf-8?B?RnpEeWt2OS9CS2lMV3FsS2k3cHRVOVJsR0pNeFhBa0J0NFFnNzFqVmViYUpz?=
 =?utf-8?B?OURnR0lqWU5GTm4wMmpVSXhBbEoyUGxmUVZXYm5odUNyMURWb05ZQnVtdXBG?=
 =?utf-8?B?d0toVExIK3RRemNYb2w2ZDlmUlRDdEo0RVJRcDRUSlJnejdLU0FGZ0JQcVE2?=
 =?utf-8?Q?gUHypKhnI1j3IFPyxXpadSM7nXLSiaivyK6P1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C10FB06BD68341902F72299C45B1FC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fs8vFzHBGXQPcDGwD7iHtU1pkzYKcxfmucYSzUXOTIpg6hxt02ihFml+QZ1PEDVtK2XhibK0ictpRq5HAHSvYpGCrWrvbQLQwIpDseFbzzQFcuw4NbYsGJT1DqT4nCCFe0zPUcmfQqd+fsA60BrdWA0lxKezyiXsUFVPAgCNiCGiIHTp9lw7hZol60EYSQgXVoY5BDxStrUwxWxwZPnd1rUiqfjDoWBk4UkLC0bewNLpCkAI2OjByt2qY32F32fLHLplNA67dqZBjLwfBi4rc4KrmigwZvxm2pUSdYgtriUJHZeD1KZxCDHYQdfJVwtwvzkF838NFCw29sKxTQuJ3g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b055253-105c-4713-cad3-08df17acd433
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 06:51:57.1382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9SOKNjm9YRdR+v+GlfEosSu/d83Z4e6KxrwqPtV0/PfEWEr8E3Dn0v+7Htb7ZJ50UJ1GkFQSVtocLKyFw9vazjCFSJrGiEjj636u2gHIZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8592
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
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

DQpPbiBXZWQsIDIwMjYtMDktMTYgYXQgMTg6MDQgKzA4MDAsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gV2hlbiBhIHBhc2lk
IGVudHJ5IGJlY29tZXMgaW52YWxpZCwgd2UgbmVlZCB0byByZWxlYXNlIGFsbCByZXNvdXJjZXMg
IA0KPiBhbGxvY2F0ZWQgZm9yIHRoYXQgZW50cnkgaW5jbHVkaW5nIEZBVUxUUSBvYmplY3QgYW5k
IGZhdWx0X2ZkLg0KPiANCj4gV2UgY2FsbCBxZW11X3NldF9mZF9oYW5kbGVyKCkgdG8gZGV0YWNo
IGZhdWx0X2ZkJ3MgaW9fcmVhZCBoYW5kbGVyIGFuZCAgDQo+IHdha2VzIHVwIG1haW4gdGhyZWFk
IGZyb20gcG9sbCgpLCBidXQgdGhlcmUgY291bGQgc3RpbGwgYmUgYSBzbWFsbCAgDQo+IHdpbmRv
dyB3ZSBjYWxsIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZhdWx0X2lkKSBiZWZvcmUgcG9sbCgp
IGV4aXQgIA0KPiBhbmQgcmVsZWFzZSBmYXVsdF9pZCBmaWxlIHJlZmVyZW5jZS4gSW4gdGhpcyBy
YXJlIGNhc2UsIEZBVUxUUSBvYmplY3QgIA0KPiBmcmVlIHJldHVybiAtRUJVU1kgYmVjYXVzZSBv
cGVuZWQgZmF1bHRfaWQgZmlsZSBrZWVwcyByZWZlcmVuY2Ugb2YgIA0KPiBGQVVMVFEgb2JqZWN0
Lg0KPiANCj4gVGVhcmRvd24gRkFVTFRRIHJlc291cmNlcyBpbiBib3R0b20gaGFsZiB0byBlbnN1
cmUgcG9sbCgpIGhhcyByZWxlYXNlZCAgDQo+IGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLg0KPiAN
Cj4gU3VnZ2VzdGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxbc2tvbG90aHVtdGhvQG52aWRpYS5j
b21dKG1haWx0bzpza29sb3RodW10aG9AbnZpZGlhLmNvbSk+ICANCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPFt6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20pPiAgDQo+IFRlc3RlZC1ieTogWHVkb25nIEhhbyA8W3h1ZG9uZy5o
YW9AaW50ZWwuY29tXShtYWlsdG86eHVkb25nLmhhb0BpbnRlbC5jb20pPiAgDQo+IC0tLSAgDQo+
IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLSAgDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICANCj4gaW5kZXggY2QyMjczMTVk
YS4uYzNmM2M3NDQ4MiAxMDA2NDQgIA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmMgIA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIA0KPiBAQCAtMjY4LDE3
ICsyNjgsNTEgQEAgZnJlZV9mYXVsdHE6ICANCj4gwqDCoMKgwqAgcmV0dXJuIGZhbHNlOyAgDQo+
IMKgfQ0KPiANCj4gK3R5cGVkZWYgc3RydWN0IElPTU1VRmF1bHRRdWV1ZSB7ICANCj4gK8KgwqDC
oCBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsgIA0KPiArwqDCoMKgIHVpbnQzMl90IGlkOyAgDQo+
ICvCoMKgwqAgaW50IGZkOyAgDQo+ICvCoMKgwqAgUUxJU1RfSEVBRCgsIFZURFBSUUVudHJ5KSB2
dGRfcHJxX2xpc3Q7ICANCj4gK30gSU9NTVVGYXVsdFF1ZXVlOyAgDQo+ICsgIA0KPiArc3RhdGlj
IHZvaWQgZmF1bHRxX3RlYXJkb3duX2JoKHZvaWQgKm9wYXF1ZSkgIA0KPiAreyAgDQo+ICvCoMKg
wqAgSU9NTVVGYXVsdFF1ZXVlICpmcSA9IG9wYXF1ZTsgIA0KPiArwqDCoMKgIFZURFBSUUVudHJ5
ICpwcnFlLCAqbmV4dDsgIA0KPiArICANCj4gK8KgwqDCoCBRTElTVF9GT1JFQUNIX1NBRkUocHJx
ZSwgJmZxLT52dGRfcHJxX2xpc3QsIG5leHQsIG5leHQpIHsgIA0KPiArwqDCoMKgwqDCoMKgwqAg
UUxJU1RfUkVNT1ZFKHBycWUsIG5leHQpOyAgDQo+ICvCoMKgwqDCoMKgwqDCoCBnX2ZyZWUocHJx
ZSk7ICANCj4gK8KgwqDCoCB9ICANCj4gKyAgDQo+ICvCoMKgwqAgcWVtdV9zZXRfZmRfaGFuZGxl
cihmcS0+ZmQsIE5VTEwsIE5VTEwsIE5VTEwpOyAgDQo+ICvCoMKgwqAgY2xvc2UoZnEtPmZkKTsg
IA0KPiArwqDCoMKgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZxLT5pb21tdWZkLCBmcS0+aWQp
OyAgDQo+ICsgIA0KPiArwqDCoMKgIGdfZnJlZShmcSk7ICANCj4gK30gIA0KPiArICANCj4gwqBz
dGF0aWMgdm9pZCB2dGRfZGVzdHJveV9vbGRfZnNfZmF1bHRxKFZUREFjY2VsUEFTSURDYWNoZUVu
dHJ5ICp2dGRfcGNlKSAgDQo+IMKgeyAgDQo+ICvCoMKgwqAgSG9zdElPTU1VRGV2aWNlSU9NTVVG
RCAqaWRldiA9ICANCj4gK8KgwqDCoMKgwqDCoMKgIEhPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQo
dnRkX3BjZS0+dnRkX2hpb2QtPmhpb2QpOyAgDQo+ICvCoMKgwqAgSU9NTVVGYXVsdFF1ZXVlICpm
cTsgIA0KPiArICANCj4gwqDCoMKgwqAgaWYgKHZ0ZF9wY2UtPmZhdWx0X2ZkIDwgMCkgeyAgDQo+
IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOyAgDQo+IMKgwqDCoMKgIH0NCj4gDQo+IC3CoMKgwqAg
cWVtdV9zZXRfZmRfaGFuZGxlcih2dGRfcGNlLT5mYXVsdF9mZCwgTlVMTCwgTlVMTCwgTlVMTCk7
ICANCj4gLcKgwqDCoCB2dGRfZGVzdHJveV9mc19mYXVsdHEodnRkX3BjZS0+dnRkX2hpb2QsIHZ0
ZF9wY2UtPmZhdWx0X2lkLCAgDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2dGRfcGNlLT5mYXVsdF9mZCk7ICANCj4gK8KgwqDCoCBmcSA9IGdf
bWFsbG9jKHNpemVvZihJT01NVUZhdWx0UXVldWUpKTsgIA0KDQpzaXplb2YoKmZxKQ0KDQo+ICvC
oMKgwqAgZnEtPmlvbW11ZmQgPSBpZGV2LT5pb21tdWZkOyAgDQo+ICvCoMKgwqAgZnEtPmZkID0g
dnRkX3BjZS0+ZmF1bHRfZmQ7ICANCj4gK8KgwqDCoCBmcS0+aWQgPSB2dGRfcGNlLT5mYXVsdF9p
ZDsgIA0KPiDCoMKgwqDCoCB2dGRfcGNlLT5mYXVsdF9pZCA9IDA7ICANCj4gwqDCoMKgwqAgdnRk
X3BjZS0+ZmF1bHRfZmQgPSAtMTsgIA0KPiArwqDCoMKgIGZxLT52dGRfcHJxX2xpc3QubGhfZmly
c3QgPSB2dGRfcGNlLT52dGRfcHJxX2xpc3QubGhfZmlyc3Q7ICANCj4gK8KgwqDCoCBRTElTVF9J
TklUKCZ2dGRfcGNlLT52dGRfcHJxX2xpc3QpOyAgDQoNCmFyZSB3ZSBzdXJlIHRoYXQgdnRkX3Bj
ZS0+dnRkX3BycV9saXN0IGlzIG5vdCB1cGRhdGVkIGJ5IGFub3RoZXIgdGhyZWFkIGNvbmN1cnJl
bnRseSBhdCB0aGlzIHBvaW50Pw0KDQo+ICsgIA0KPiArwqDCoMKgIGFpb19iaF9zY2hlZHVsZV9v
bmVzaG90KGlvaGFuZGxlcl9nZXRfYWlvX2NvbnRleHQoKSwgIA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0cV90ZWFyZG93bl9i
aCwgZnEpOyAgDQo+IMKgfQ0KPiANCj4gwqBzdGF0aWMgdm9pZCB2dGRfc2V0dXBfZnNfZmF1bHRx
KFZUREFjY2VsUEFTSURDYWNoZUVudHJ5ICp2dGRfcGNlLCAgDQo+IC0tICANCj4gMi41Mi4wDQo+
IA==

