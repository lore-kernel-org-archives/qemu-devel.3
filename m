Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB5BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNa-0003p5-Nc; Thu, 02 May 2024 11:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNY-0003oY-LM
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:48 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNW-0005yW-Rr
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663786; x=1746199786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qP+9tZP//WCtxDabgIyOzTMK4HBwNewfd490piBaCjs=;
 b=nfLq1AJcQNg3UWKQVdFlIXAFMlRHX6f2sKhfxlgJcp++ofbQ4tmV8Kmc
 q5LvCRw/fPy1i5ux2vDMv0dhNajEhYYaEw9nrL8VNkgFibSivTI5nX5JW
 sl81DxHNnjz6MOlzplucFEYA+tYTeti0dZBQfJKyrZCM2+bNt9cfZOuXN
 7HPh2V2LYF4hqeBikpsZswFqhQEUQeMMCB3RLfYnkiXz+QAYe5O1oHE1I
 O+YUzMbPslH4rvI4EqCvFh69t6Rq0RVgZoLS4XZ5DUOSQ1WiedE/YjMvi
 BapAEy0siEP8e+erbhUYS0/lfL0sxqN3RdljxPZDLqTDWzBP4O2RLbtRf A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785883"
X-MGA-submission: =?us-ascii?q?MDElbVK/SWpq38mKELSxBuXCPdlgBkTbGZIAu4?=
 =?us-ascii?q?NGsWnWcLMYG7tkSj7QCECNj4BOCwzwVgT7qjz62ALT1fM5wL/mIwXOvP?=
 =?us-ascii?q?rBB/kwpgASBOdYhviKQ1kXPOS+iGTkfFSJWub8J6WZSP3HKckQBFmmQ0?=
 =?us-ascii?q?D5qL6EbmSZhupleL/tDnqdxw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG5K9to4zjg5nkhwSoKCrotTNmHkWn5EGjXSYUG4FNoO87g6YnjIfnclmnVNEAtLQTcCqZ3Npj60hmWjA37ma+QnS1PyNRT3z6nkWi4BkeX4lCfY9w8Ry6daNGI8L64X1NMGFw7PyMHwU0YYxglIlSF8mCtOHw6eT6V5fo1ePtG0NxFUZQb2l2Tuv2724yYman3BK2A3hmZX86Lfr89Uawqfp570hNXx0QOBSA7NcjnY3fJsZ9IKPw3MxKUv99bJoE24S/VEDw18WyQLFjALObCQcZsbYOVT9vmkc9oQ45CHcyl1uB9MqGyh+YgLqRp4cXwyZV04qhki66Pt0oqfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP+9tZP//WCtxDabgIyOzTMK4HBwNewfd490piBaCjs=;
 b=F38yPPrsJ+6dpl8/p4FYQqPFwiS27/6Swm5tt+DqT6ArNEBWzDRLFlMSiUAceQUh2rbdeaM9grfvsvPt9R4cu7a3ewY9MakoGXNZxwHRZYZ60wTjYdbasZFZRDfxtBcRV7V/O01Kf83RT0X+ei2mMKhz7hQ6/GH8MtZuoF9n1+EPVMKnIw4CBq1du/J+xMtKS/7AFZ29efw+HcK7TavssF8DSIEYLP0yC8ljUBYa+MvDBlPpz7lHCjss6qU0e49RyCjMXKXfFHdpOb4G7vMExGejTGUApRCbRUnbk8GAVypYzjf8BYIe3gVIdoerPbbz/ry1ztj7D41W30f0uCVmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 10/24] intel_iommu: declare supported PASID size
Thread-Topic: [PATCH ats_vtd v1 10/24] intel_iommu: declare supported PASID
 size
Thread-Index: AQHanKV/VyD4Uc59nUWVMdk2G0UyEg==
Date: Thu, 2 May 2024 15:29:18 +0000
Message-ID: <20240502152810.187492-11-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 042051e8-1158-4358-b3c7-08dc6abca25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dmYyQ3dhc3M2YzE5c1o4Y2Z1WXV2TXRuYzhEOGdiM1FqVWNlN3hHNnIxWERS?=
 =?utf-8?B?ZllMSHl0U2NwcGszdnd5dTRoNGlWWkF1Y2x3K0h5SDI4VE00bk1QTUdvbkN4?=
 =?utf-8?B?cm5vdG1McjdOYWFGemxjcU1IY2x6TmhlL2lJVXFJZ2RLcmJpdDZqT3d3eEpy?=
 =?utf-8?B?QUlNL0hOUmdMTlAyQi9ndENYbTVSeGp1dnVQTkhGN2RjQlQ4NXJwWkJOblpP?=
 =?utf-8?B?YWs4VUhtNnNwWDhDMkxFTUtsZ3F3Q2RTVDVvUlRrQTMzeFJGbk1uZis2WkNi?=
 =?utf-8?B?akpSaG5HaS9Sd1ExREJpTXY5UUk1WUQzVS9pWFc4cFIyVnVCQzZQREUwQzU0?=
 =?utf-8?B?VURlUGxHSWJKWlROLzUwUVVSa1E5aDJGTEpSRjFwTGNhU3RTYzl2QmtVZ29Z?=
 =?utf-8?B?N1pyL3NXY0gxaDJyRXRLMUp5UngzalZxN1V5MSs0TXd6aWRUVnNSdUVVZldC?=
 =?utf-8?B?eUUxQklBNDFmTUJORlpmbE5DR2tPTFRyUGJwU0V3WGYzQVFlR0M3Vzl0aW54?=
 =?utf-8?B?alN2RU1MVnk5TEhTeFF0SUxxQkJBRG9hbHpWMUtjd2w1QXNsUGdDVUtmZ2xw?=
 =?utf-8?B?VzVPd2hoTlNwMDRDUEVyV3B3MGtEeXZucXZQekV2TS9GRUl0M1o0K3N6L1JS?=
 =?utf-8?B?MnhzcXdYa25IeWlzOFlQLzdmNTA5YURqTVcxNVdlZGMvVkJ1UktpS2JETE5w?=
 =?utf-8?B?WXpYYXBSaVVxbnVtUWZxaTFKQ0ovSVlkNUw0VnkrYXBvUGkyV3lsRHo4cndx?=
 =?utf-8?B?dmc0N2RCOUxsQTltbllZbURId01ORnhiZXBqZ2lOSFRNRm9HNWJKc0JQWmJN?=
 =?utf-8?B?aW5yT3lVWlozZ1Y0U0xvSy9pUWhkak9PeUxUNlRrTkplV3NnRFd6RkhqcTZB?=
 =?utf-8?B?NVQ2Rm53NnpuNEcvVGdGdGpONGFFNHFXOHBQeTlCN2gyd0hKSUszcVA5ODQv?=
 =?utf-8?B?amRybzF1cnJ2d0dVVVFobmhlVUdWVWRlcVV5SURxdTg3UmdlZGxjNDIvMStj?=
 =?utf-8?B?UndkVldaTEtCUER1RVZIOVIralA1d0d5ZVR4NmkwaklMVHN3Z0NqT1dZSDFW?=
 =?utf-8?B?LzdSVHF2ZXl3MXdOSW8wcVliYTBFbWpwYkI3NDNxVVMzS3hIVkFXZ09rM0lM?=
 =?utf-8?B?Z0tjWXBOZFlVb3FMa2paSHJveVdoUVdzMGU0cG5wMG5uRUNtcldSQTFZZk84?=
 =?utf-8?B?VkFCMFhpWGp6Q0tEcXpOQks3Z3JhWFQxcmJUSm4wZEQ1bWxMd3Rua0RWMFZn?=
 =?utf-8?B?T3J3RnN4dUs3WTBJNDZJb1N1WEVwVW90QzhOSzhLb3VVcTlNVUFBc095aHNG?=
 =?utf-8?B?WTIvVUlITXMwdnhGaXd0dE1vcmZnT29VS2xzdlI5SzU4blFNVG5lbHcwM3JT?=
 =?utf-8?B?d2NydHFLcFJzbFVSVXErTlV0aER0MmhHQkNoUGNodFpwTEtWR2VFQVppQXVl?=
 =?utf-8?B?MFY0N1hrREVvYXJVdTNzN2trZjQzT1kxOEgyOWFyWDhIRDM4bUovU01kUzU3?=
 =?utf-8?B?MzduZjhCWWxvbitiaitYeDYybkI4N2JvQ0J1OFlValgxU3lXWGpvQjM1a0tD?=
 =?utf-8?B?dmlvMnBkYjVXd3dmQ3h5am40ZUZRQzZzQlk4Z05aRGtidVg0MXlWYmxkZlN1?=
 =?utf-8?B?cVNPOVdNTTdMdEZobnJFZXh2R0pRWWNhVHE0WVhwTmlvZ1Z4TWlTdWQ0TGg4?=
 =?utf-8?B?OFFrMU5KdDY3SmpabjhoKzlFd3NwZW9IZU4zRnJDZnZxYVByOXNZZ3AwaW83?=
 =?utf-8?B?dXF3L2Zrc2x2VlZSeWJsaXVkd0RVbjR5bGQ1YXdNNmNQU3dEL2dNdjRyaUVI?=
 =?utf-8?B?T1JvTVlpN1J3NHd1Q0doQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUVSc2xOTCsvU1JmSjV1MTRFTlZHWWo3b1JiQ01xTFdsK2JvU0hHYUkrSjJ2?=
 =?utf-8?B?d2Mxd3FNbi9KMWNSTlNKczUzYXQ0bXRvMnA0d1U0VTlRUkRSUzdHM0JHVXM0?=
 =?utf-8?B?SlhOblg3YXg5U29TcGV2RUM0V25ta2xtU3VJZ0dVV0FSUXdUbDBlcHVMNjkv?=
 =?utf-8?B?T2pCN0haaGFTbm1yV1ZoZHRjMFZPS25CSmM3YnBBbHRFS0srWTFmWmNiOG0w?=
 =?utf-8?B?ZlBkbi9OUnRXNmVNR0JmRDlyNEg2UDRIOUhLMmhtU3l2OE82dUY1bjhJZEMy?=
 =?utf-8?B?Q24ydkswQlJLQmZTcWo0bTRjb1hralFxR1A5M2dCK1hvZXF1QW1KRnMzYW9X?=
 =?utf-8?B?RlNHdnFYSG1zTnRId2ZGZ0Y0Vy82ZzdVcHRnUzNOMkZ0T3I2enpuOVNicXgr?=
 =?utf-8?B?K0trVWlJN1FUMGgxamVUYjFKVDJsQUhvaUdqd2ZIWDlYTnFBODlISzliNGZa?=
 =?utf-8?B?QzN6RHlWTEJLeGVXaUZmYmh4cXpPRW9rMFF5WVN1NEowUFEzR1JXQTlqbG1I?=
 =?utf-8?B?OTI1dTFKS2ZWVDB2Z3ZaSlk4Z1M1WTVOWVNEcnFJRWFHZ0tBVDFhanl6aEpB?=
 =?utf-8?B?TWxydHc5YjVvVk5RQ0RPVlN3ZnM2RTh4QkZkYlQrUkNyRzRBTG5CWGxuVjJL?=
 =?utf-8?B?U3RTUkw5TFdtaXpLSlptRVdtNlRiQ0xhV1pVVjRTQ2hoYWJpVWVVMkdwVHU3?=
 =?utf-8?B?c1YxZVNUaWxsTHYvM0RvcW5VRjRwcHhFVWEwSkFNM2dTRVk5UzRDV2RBVlht?=
 =?utf-8?B?MjltWUpDakRSV1pRQ0JmLy9jZHZobmN6Y2ZPRnBHd0JwZ0VXZUJqOThTNk1M?=
 =?utf-8?B?ek9pY1dTUmMrN3FvMnZVelNiak9vVTNFOENiN1hPcnZLL1Iwa2k3cDR4SDZz?=
 =?utf-8?B?dk9ZWVl6WGpkNm1OWUVFdVhYMDdmVjAvTGtGNjB3T2k4TzA5T0pDTDVxcTZD?=
 =?utf-8?B?Z0R5UU1TelczV0svRGhyOHk1VDdpbVFMRXJNdHd1R3BLd29TR204YkpUM3NS?=
 =?utf-8?B?TFc3U09MMnF0VDc2L25EVDdnTGdwanErTjJVanNFcVdwSGNTdmM4eDlrSjVY?=
 =?utf-8?B?T1M0V1k2bmVQK3pKTEwyRkRaZjdYT3lQb3FObEFmQXM5VTBmV2llYzFGYWhZ?=
 =?utf-8?B?T1F5emlISndDS005dkt0NTNwTm5iWGJ0aDhCcUo0bms4bmpnUDBtTi92ekNx?=
 =?utf-8?B?K0hEaFRtTDBCYmd6RW5qRE90WFRpSlJSRktKS3dtTVF1VkpXVk13cVRwWmx6?=
 =?utf-8?B?STJlOUZRRVRURXMxR0JGczBHelBxUTZ3ODh0ODhhelU5TjNlWTZQL2s0Z0Q3?=
 =?utf-8?B?UUQrQ3Fta0NQSHdBSjh0N3hFazBnaW1lZFdUM3F6NFVPMmU1MEVKTklwanNs?=
 =?utf-8?B?VEM4SnJFNUJHNnc3L213cnc2bGFBMzgwQkZHT2E5YTZNL21OQXBxeFhodjFN?=
 =?utf-8?B?bExqRHNQVmV3VHVHUXFaNjZ1Q1duRk5veHpINkdvcnJaZ0p2T1NwSWNLWlZa?=
 =?utf-8?B?LzcwUFVrVFFSVkJGU1JaWEl3SlJxUFFENmFySmdZQUZpdjBXZExxdmJnc3RE?=
 =?utf-8?B?c3doSExzcDV0NytER215WjZ5VGV3b3dXR0cvQUExcjBYNW5sT25FUFBVM0ds?=
 =?utf-8?B?b2pTQVZwVGlVUDRNUTNWUVFocmJVbUFaYVZId2RNZXB5Q0syRWt1OUg2NUtO?=
 =?utf-8?B?aC93bFdiZ1NjL1BOY1FuR0EwMkZabUhpOE5ieDRJaFFuTXhOSE1sQXZBVFEz?=
 =?utf-8?B?NGttTHVjWlNmUUVDbXN6VzhpQ2NMMEFmamw1TlB2SHB1Q1VEQnUweHU3Z1B5?=
 =?utf-8?B?ZEJoQnVNcnhobkx3SnhkSThySDhnNmZvWDNLMk95S2NxWWFJckpGRllkWEt6?=
 =?utf-8?B?MzJwMXB5Y3IxWmZiaHdTc1VKNTF3WWFLRFBlRnpCQnBLaEdEM3JLRTJvM1V6?=
 =?utf-8?B?SFJiVWYwYjlhVGZhYzRvRTZkeWRnMDJ2ZmVsZlNvalloQ1NmSmthaG5ObXB0?=
 =?utf-8?B?T2FvYk5RSUM4dFlIU0pPa1FkeUN2ZDJkYXNIY05ObzM2Yk1BYmJBNHB5OUt3?=
 =?utf-8?B?eGUwN0wrWnIycy9jSkRxYzFwWWtOVzIrZTRZdFFENFdtVk9yV09JbG5FWmJr?=
 =?utf-8?B?c3lyekhUaUMzd1pLaFREWXRTREhNV251cnBkaTZGS1V4N2NaRUhYd1UxcElI?=
 =?utf-8?Q?y/P0s/UD97rmustIy4lFklE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35F96B762E76A742AEFC4261F3672783@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042051e8-1158-4358-b3c7-08dc6abca25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:18.9660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUeqIxn8s0ZYT0TjZw7+Amgh54sJE8TS0ALsd9CP41OyNM8ZzEvugorMwaiM+RzVLtlELuDQQ1uc13009PI+aCu8/pJyx1bz07vwUs0s4iQBaJfmmGYweNFvcqpVjsDu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAy
ICstDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMSArDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYzQ3NWEzNTRh
MC4uOThjNGE3MGZlMCAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTgyMiw3ICs1ODIyLDcgQEAgc3RhdGljIHZvaWQg
dnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCiAgICAgfQ0KIA0KICAgICBpZiAocy0+
cGFzaWQpIHsNCi0gICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfUEFTSUQ7DQorICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEIHwgVlREX0VDQVBfUFNTOw0KICAgICB9DQogfQ0KIA0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggMTQ4NzlkM2E1OC4uZDYzZmYwNDlhNyAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtMTkzLDYgKzE5Myw3IEBADQogI2RlZmluZSBWVERfRUNB
UF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZpbmUgVlREX0VDQVBfTkVT
VCAgICAgICAgICAgICAgICgxVUxMIDw8IDI2KQ0KICNkZWZpbmUgVlREX0VDQVBfU1JTICAgICAg
ICAgICAgICAgICgxVUxMIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0VDQVBfUFNTICAgICAgICAgICAg
ICAgICgxOVVMTCA8PCAzNSkNCiAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAo
MVVMTCA8PCA0MCkNCiAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8
PCA0MykNCiAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NikN
Ci0tIA0KMi40NC4wDQo=

