Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89946C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdQU-00065J-TM; Thu, 12 Jun 2025 04:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdQP-00064Y-MK
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:36:41 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uPdQN-0005Vy-Ob
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1749717400; x=1781253400;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=CLkcXHFmFGGCp/Nm58K19uLDh1AV4gI4yN4MK/UIHJc=;
 b=hL2BH8wToqw5SlfSC7Xygo3CyZQUKwlT+vrY3WXvQGif+33UyWQLq5ro
 oEhO34IQ0e0QJKF/08kArXrGNxRVn5KzCLVAq9tXkW/9MX//GGhsEro6/
 TM0gzcWJzTx8hMPV6LMZUxV7NTwULzdD3e5egnu87GnC0JB17lFIP9YXw
 m7yUpdvOemhTcDOF/wXGJt7T91vMRf1l8HQ+0Qo0+meYZOxcJxHJ7sSpl
 08Jzwn8hrQsH6i2qo7DAYZj7dNnG0EwjnfoGG+ru86Q5pCqXq+1GJHq+W
 dRyF13asK2UOmu36t1G9Nr0h+g0lYWX2bmFgadFOR+NVXtMycMC2RgRSi w==;
X-CSE-ConnectionGUID: grtdwtZlQXqZ+yYRkBoswA==
X-CSE-MsgGUID: ajt8zfd2Sku70vi5M+P5vw==
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; d="scan'208";a="38607712"
X-MGA-submission: =?us-ascii?q?MDGf/BmddYIX/3ngETl7idGAjkTisZgYrY1LD3?=
 =?us-ascii?q?04ToqXuKsih31YTwFwtQJW26mkiluv0dqTohuG+X5kWp7yiLJZYbd+rm?=
 =?us-ascii?q?MflHY9xqNm++nlwm6fIG80bZFIxgkijqzjFVhdsmToeT3yHXvC57OHZt?=
 =?us-ascii?q?IXhouy4X+aGK2Rny/s2+apxw=3D=3D?=
Received: from mail-northeuropeazon11010011.outbound.protection.outlook.com
 (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.11])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Jun 2025 10:36:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkZpzm60pMSsr73QmKffb9HcPdL0H0X4+crmJAaf7RkReu/N7/mNLHpPI29GoNYxQd0pSUJQyrBS4JgL9hZH1NQM/oayecGFJDDJ9UTV5ONf5BO0ZojlWQwHe/w2aVU5Dr3edy1yn161AasImjfaweQ4ow0kgaTgi9D9fvkKmxR7yRxerXzdEwqGUsWhh7rT+v7sz4CHZSeSZ70rVPK7dd3ExUJvrz7mLXUI+MRsBJCJpQ5WKxj7cb3ug8VRShOYnH0k21Cv6ZGhCZJejStnzgPrHtts6KROyCa83iAp12DK7XB2jYZjZycBoeSKIb/wUng9lMWxsTI8WmMgONBm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLkcXHFmFGGCp/Nm58K19uLDh1AV4gI4yN4MK/UIHJc=;
 b=Y2TTMYrg7jpPaKotosPT3SO0r9mZ1fgLiIjR2HPzH5RGzY0cMQNEHcJ42gQorhaJeffuz4ZCByIL4UKQSf6xnOhe4fbLrzIyY2ZfE6sB/lKoTqACt1X67j9ypWNENGYJmHFLMy24L9M4x4OzBbr2zyghgMmowErrj6fxKyMoOk6hzCixvV2UwWWLcvSbftI9dUNjEWbq2THEAaRLKqJDqwMUmTQ42rp8qC1hOp1Ogjai4SmuZF2J0SoifGVWLfUEvJbt0yiBY5XgfhXWdCyHlFdflVfqoD0wqL5DWKbFpJ1O6R+7AgBoj5yOasQGvswDjaJXyPyUG43jH2syCnXZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLkcXHFmFGGCp/Nm58K19uLDh1AV4gI4yN4MK/UIHJc=;
 b=VgH2wD20EQqkuM76Mf64Dm3mRjFKFZuMvb2nX+/vXUlZd0eMaukMxDQVhcyDURuVHMu2kmGGPKxmsgX3WIAcW6fpZLB+sG7qs0OcLImKcMSGd+PPuD3BrsiJPa0wYQZ7Y5cFc6L84ZksDAZLXatn1FQDFZtPPpTl7nLqfoyua7sHLslHTfGKcR9PqrOVcrsFNitEU49z47JbBY/kBH/st7fNVaJZlkfFf01mpIzBYDlVRQb69vyNdPk3V7k+0rKnE6MqFPU3fMsFIoJ4193sp9XZ6ivE6dEcpyTQ3o+z/eNfhVMOmp7D15VtE5zYsPuMKCQskn89KvbkD7V/WkbQCA==
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 (2603:10a6:800:190::13) by OSKPR07MB10301.eurprd07.prod.outlook.com
 (2603:10a6:e10:98::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Thu, 12 Jun
 2025 08:36:34 +0000
Received: from VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e]) by VI1PR0701MB6847.eurprd07.prod.outlook.com
 ([fe80::5a47:474b:4132:d07e%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:36:34 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
Thread-Topic: [PATCH v3 0/7] amd_iommu: Fixes to align with AMDVi specification
Thread-Index: AQHb0NBab3jZgp2PAE2l6IujWhFXkLP/SI8A
Date: Thu, 12 Jun 2025 08:36:34 +0000
Message-ID: <af1423ff-24ad-4a4c-8a42-eec5fe77a66c@eviden.com>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0701MB6847:EE_|OSKPR07MB10301:EE_
x-ms-office365-filtering-correlation-id: 18ec514e-e6d0-45b2-22ca-08dda98c3d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlZ6cUVUZWtpRTc0RE0yR3p6LzZFVmNPSWkvdzlWRlA2TzRueldsTHlRK3BN?=
 =?utf-8?B?K09BK0czQmpCWmdnU0ZnS0NEbi92bkJuN3FQZ3JNN3E0UW8xZGJSK3F1Nkdw?=
 =?utf-8?B?bEdkN2VIUVUxRDBqME5QTlFrN292YlRVNmYxKzdEdnRDeDI4eW5tTkMwZC9x?=
 =?utf-8?B?ZFc3L1dJNEZGQThhU0lqM0ZPOW1QV1JaY3cvR0RYai8wYkp0RGlRVU5ZMkVm?=
 =?utf-8?B?ZjF1L3BhazFCWmtJdFZxemFjd3Z1TGxqeE16dUFxbnRjdUN4cFdYSEYwamRr?=
 =?utf-8?B?djlhZkRrSjJ2RlBLd3drdlk3NDJRN2tNOUl5Y2VzMTgrOEFVMVFsOXdLVDAr?=
 =?utf-8?B?NWlYU3pBQ0ZNY3RBUFRDSlRBYkxjZVN4OENYRWFNRUJFTHVPL1RST2ZhcEI5?=
 =?utf-8?B?OFR1MzZuQlFqc3YzVlAwaVk3cmUrQlk1NDIyRVZpdldVNGVEVDk0cmhuMHNF?=
 =?utf-8?B?dE5zL3hYMy9iaU11dXlyRGpGN3ZoekJBTjg1RWhQMlFBMmZYSmRiL3d1K0FS?=
 =?utf-8?B?ZWZZMGUrb1BIWGV6QlhiWWF1cGFIQ3VqMmtwSHJud3M1cmhpU2JHclloWFdj?=
 =?utf-8?B?YTcvUkkxWjZQRW1oQUpTalBrRFczQ0psWWF5Zjh1V25pb1pLZ1UwdnkwRllO?=
 =?utf-8?B?Qkp0Zkl1SVhNbnpac2ZIbVlzZjVlWnYzMEl5TllUeWhsSjhuSEl5bFJ4RU4x?=
 =?utf-8?B?b2JLajlGUWRmS0ovc2RsV3dRV0Q0Q0JTbmZkZDladnBsVDY0WkdKSTZ0UVVB?=
 =?utf-8?B?RGdqTFlvZFRhRHdJSjV5OTY2blZ0aXplUytjOFBDTFRja3ZEaForck02ekRi?=
 =?utf-8?B?UUdWTUVSVXdsQ1BHbk05YVVFZkxERVAwYllkR29OMmt2WVJuYTF3Y2x5WThK?=
 =?utf-8?B?SjE4L3JyZDU5STlHTCtMb2FuaFJvY01SNnlQS203emNudHZCczRSbkxDQWUz?=
 =?utf-8?B?QWZhVXJMaitVTnh3RkpYTzlkNWhkTXY4LzVqUHVEakRjczhRL0J4Qm9NYUJS?=
 =?utf-8?B?aWtzbUpueTdGMWVDLzdVTWhmcXdtTXB2eVIvWStxcHJsc0NhMWpkenp3SElp?=
 =?utf-8?B?b1NodXJOMElTc0p2TjdLa3lGQjE0bUl5STVpemJHY3dVQUNqUGlsaC9scG5q?=
 =?utf-8?B?Q1JKVnNlT0ZEZWRHd2prSGYrL245citmUjRhYjdZT2QrbjF5YlZRR2lidE1Y?=
 =?utf-8?B?VFF5Z0JBUUVCWm9EemIveVRodHNjNkp5Snh1dDRpaWRtQy8wN2ZRVk9ONUZw?=
 =?utf-8?B?cGVSaVM5eDdxN2FoVGdRN05ocG51SlNBYnR2cWVZMHVJazVKZU5vNkc0akV0?=
 =?utf-8?B?SVYwNVUzK2kyZ295QTdweEYvOS9EV1JpTnRLdXdGVU9pTHF0L1pFVlF0ckpZ?=
 =?utf-8?B?VkpqS3ErTHhQOUR2ODRWUEQ2eVhLYURTd1dSaFdXQjBGTThDZS9zaGJ6YTc2?=
 =?utf-8?B?L3VZcnpWN3NqcXBqVVNKNC85Wm9YTFZ1QVE0V2pTRk9YV2wzQk5ZNjl3cWNF?=
 =?utf-8?B?U3hob3NXUEQwdVdKbzBWNjVUcks5bFFVY2xMNXZyYnRINGtrRzhiSXVRenhz?=
 =?utf-8?B?bFExUlhPT3FHTDRRZm02aE9vWEwvSytINkd3L2lvME9McnVTcU8wSXdBNGFl?=
 =?utf-8?B?YmEwaFVoOW54VWZOMEw2dGhzK2pFT0hDbTQ5ajAvWHpRSTRsMzBnemp5K3pJ?=
 =?utf-8?B?ZnJ1YWNLWlNKcWpsRnBsT1NYWDBab25QbmtITGtXSVczL0xMbnVTRndGNE9M?=
 =?utf-8?B?VkVUanJNTkswQ0kvd1ZMNFpnU3JlYnk1ZXN0Y3AxcmJweGl3M1FPblJ3U1pz?=
 =?utf-8?B?aitKODhsUnVldkZTODNncGhBb0VINEZpL01HZ2tmSkdIWHE5L3V4VFNUVmR1?=
 =?utf-8?B?S214SXRvSWpNc3MrZ0p4TmU1YjhPMHgzK21FWUJEVVpxU2gxb0FBS0ZNeE9W?=
 =?utf-8?B?TmZicVNNNDFsYy96U1QrcDFwTzlwNHNVVEpvL29qVENycHB0UVhLZnpkcTlq?=
 =?utf-8?Q?mPfAMFOThX7r0eX9tr72OANnjFJ4PY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0701MB6847.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlMyemtPQzlyemkrS2FiMWlDRW1LOXNvcjlZOWpDQkxhaGk4anhua2YyVEFU?=
 =?utf-8?B?anFGL3l4ZStpdnZmNjhObHZWNzNSeVNPNG1XdjBuUEFabzNJSmNmbTJnOVoz?=
 =?utf-8?B?UFlwRWY4NDR4bEJBOVVlVThpRkZHbWFHbE1TeVIxNERNakJqT1BaRnpMbTYy?=
 =?utf-8?B?cFNmeS9Fb0txSHV4dGpFTXhWYmNYeTQzejMvTkZjZWNpc2ZZb0tLZDIwdU9H?=
 =?utf-8?B?TURwVUdpUlhhc2RUTUFpQWxMYW5TU2E3OUcweDk3ODFPSjRCS0lOMG1WNzFI?=
 =?utf-8?B?M3d0V3pUcXpRdXpRcmZqSG5RWmxLQXFad3VFQll1SHJhSkZtZXhIRFhVclN0?=
 =?utf-8?B?WUMzWGd4SndmQjRLS3ZoeTdNNUY1bkJqemR5ZWRxVVFkL3BXL2lHYmF6NjZU?=
 =?utf-8?B?bnlUT3ZUYkUwekZ6Mys5TVh3VDNFcUdGUFlqMi9xbC96SDc1bGQvbitqK2o1?=
 =?utf-8?B?U3dLOUM3YW1UQlpLSk0wNzN0czZSNkZ0Um15c3hxVURFSTlwSHFxeE0yamdG?=
 =?utf-8?B?azM3ejM0WVU5cEYyc1F2VVNvNi9JRU5LNjVZWTBpRXc3Y3RhaVFrTTRqdFh4?=
 =?utf-8?B?VE5jNXlVcUIzeElpU080bmY5V0w1Y1VPVWxvOEE4MFNVem5NMXByOWcwQzc3?=
 =?utf-8?B?VGVQSWhlZE5xQTNkR0MzV2E3RWlVSytZbUU1YmNXQWJHS1g5a0xQK21GQTdZ?=
 =?utf-8?B?UTBjamE0cXJDMmQ1MldZMjR4YWpMYmJPbW9FaDBWSGR6WlBQdm9rVzVsTWp1?=
 =?utf-8?B?OFZwUnBLdi9KVzRIWXRhaXA3Sm1hMkM5bkd2Tlc2Lys0bzJweWVrTnM4WUJD?=
 =?utf-8?B?Z2xLY1NwdXhYQTdRZ0JSNlk2Ri8zaXYzYzJubUM2UHExV01QdXFjSlEyVmFD?=
 =?utf-8?B?YnZpTUM4bW5Ta2Jvd2RuRDIyd3Y3bWpxM0d4NDZhRERXOHB4eGI0NjAraXNN?=
 =?utf-8?B?Z0k2WGNoV3dFbFdyWGEvSmpDRlFzQk16NXoxei80UXFHbVVmcFQ3V1dsSVRF?=
 =?utf-8?B?bWZQQklqNVdwdW9OL0VDU2x5NWdpNk16L2VFdE9SdmFjSVJtZGVtd29qNlo4?=
 =?utf-8?B?YXdYVlRUMWpnVmY5YWJzV0RIaHZ2OGpQU1ZpalFRQWx4UnRDVnF0N1BsRU5U?=
 =?utf-8?B?TGVMQTNpajRhd3ZpbW9GU0Z1ZDI1Ny9pSUFmdFMwK2VoKzJMQnFrNTZRNXYx?=
 =?utf-8?B?anMvbmZqV09XQ1VXRmovTFF4N01PSloxclowU3U2Smlva3BmRUtjUzIzVkRY?=
 =?utf-8?B?aHc3VUNvU2FhYVk0Q2h4NFBxeUZoM2hQZXhNVU0rODJ1RUZjOVNnMy9MaFo0?=
 =?utf-8?B?eXl5WjBtLzB1dzBDT0ZaTzc4b3Y1MTNjZnNvTm4vZVMvbEFjamprdi9QZmI5?=
 =?utf-8?B?M28vZS93aURhbW8rYk9PRndwWngranF2cUV5OGoxUS9jNEEySDhYbUozZXNO?=
 =?utf-8?B?bm45NFM1WE42aGpTZXpxNlF3VlJwcWlYWVF0WVNwWEVmVXZnY3ZLNTh5Q0h1?=
 =?utf-8?B?Vzc2ZG9QbDlRUUh6OGFjN3R3dXdJaHhITnpoR1gxQ0dEWTNWNjdBSlM1VCsw?=
 =?utf-8?B?Y1ZoQWFTTHN6MkRHQXNEWi9CQkR0YkFBTGJiT094MUdNMzdGK2dMcTN2dW5R?=
 =?utf-8?B?bEFaV0FROXM2d2FDTlNlNTBiTUs4azJsZnhzZnVLOUZoWVJrVzQ0RkNkSVhs?=
 =?utf-8?B?TkdCT01JZlkvcjVHZGcvRGZjRXNqOFZHSnV0ZDFKa1lPc2dLK3k3QmxMR2RH?=
 =?utf-8?B?b1JXZW05QjRaenpudDEwNGlvVnNqUHJZOUZEbmpVRUZEV0gvNFRobEFLYm0r?=
 =?utf-8?B?eDRnaThhakNrMlZ2NWN5MytJRlpUbWZzT2t5NzQwS3hFc0xuY211Rysza0p5?=
 =?utf-8?B?UnZjZi9JaXMzWlpWU1NjQ3lVTytTWFlRWFdMdHdqSlM0RHI3YThGbXBWYkxz?=
 =?utf-8?B?aTBEYnpJbmhiZC9vd3IxbHJJM3h5Q2o5c216MnN2L1BlWUJqY0djWFNFbS8z?=
 =?utf-8?B?SGRBZjd3UmxiYVBKZFp4SFdQQ1NqZnUzdnY0S3J0bUovUUR6R2p0NzZ3WTcw?=
 =?utf-8?B?RWJ0T2xJZVFuVXBIZWx1aWREb2JscnhqcXE4N0QzbXE4MzhndnQrTlVMNXlT?=
 =?utf-8?B?UEpydEZqenBIWGk1Tis2T3FMZHZielYwaGl0S3NQS3BDQU41VHVXZ2FUa3hu?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFC348E75CA8FF4CBF060E5819FB7780@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB6847.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ec514e-e6d0-45b2-22ca-08dda98c3d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:36:34.6728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvgzFHt+WIEQN9+9x5IvyGuVQdnvCD0/TmLqR9tUJdx+YyDIOfz4JYDT0MERcH3K+TMp5XHg8z+KuFAkraGbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10301
Received-SPF: pass client-ip=80.78.11.83; envelope-from=ethan.milon@eviden.com;
 helo=smarthost2.eviden.com
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

SGksDQoNCklzIHRoaXMgc2VyaWVzIHRoZSByaWdodCBwbGFjZSB0byBpbmNsdWRlIHRoZSBmb2xs
b3dpbmcgbWlub3IgZml4Pw0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9hbWRfaW9tbXUuYyBiL2h3
L2kzODYvYW1kX2lvbW11LmMNCmluZGV4IDA3NzVjLi4xOGQzMGUxIDEwMDY0NA0KLS0tIGEvaHcv
aTM4Ni9hbWRfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9hbWRfaW9tbXUuYw0KQEAgLTE0MCw3ICsx
NDAsNyBAQCBzdGF0aWMgdm9pZCBhbWR2aV93cml0ZXEoQU1EVklTdGF0ZSAqcywgaHdhZGRyIGFk
ZHIsDQp1aW50NjRfdCB2YWwpDQogew0KICAgICB1aW50NjRfdCByb21hc2sgPSBsZHFfbGVfcCgm
cy0+cm9tYXNrW2FkZHJdKTsNCiAgICAgdWludDY0X3QgdzFjbWFzayA9IGxkcV9sZV9wKCZzLT53
MWNtYXNrW2FkZHJdKTsNCi0gICAgdWludDMyX3Qgb2xkdmFsID0gbGRxX2xlX3AoJnMtPm1taW9y
W2FkZHJdKTsNCisgICAgdWludDY0X3Qgb2xkdmFsID0gbGRxX2xlX3AoJnMtPm1taW9yW2FkZHJd
KTsNCiAgICAgc3RxX2xlX3AoJnMtPm1taW9yW2FkZHJdLA0KICAgICAgICAgICAgICgob2xkdmFs
ICYgcm9tYXNrKSB8ICh2YWwgJiB+cm9tYXNrKSkgJiB+KHZhbCAmIHcxY21hc2spKTsNCiB9DQoN
ClRoaXMgY29ycmVjdHMgdGhlIHR5cGUgb2Ygb2xkdmFsIHRvIG1hdGNoIHRoZSByZXR1cm4gdHlw
ZSBvZiBsZHFfbGVfcCgpLg0KDQpUaGFua3MsDQpFdGhhbg0KDQpPbiA1LzI5LzI1IDk6MzAgUE0s
IEFsZWphbmRybyBKaW1lbmV6IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8g
bm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNv
bWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gVGhlIG1haW4gcmVhc29uIGZvciBzZW5kaW5nIHRoaXMgbmV3IHJldmlzaW9u
IHNvIHNvb24gaXMgdGhhdCB2MiBpbmNsdWRlZCBhDQo+IGR1cGxpY2F0ZWQgW1BBVENIIDUvN10u
IEkgZml4ZWQgYSB0eXBvIGluIHRoZSBjb21taXQgc3ViamVjdCBhbmQgbWlzc2VkDQo+IHJlbW92
aW5nIHRoZSBvbGQgcGF0Y2guIEFwb2xvZ2llcyBmb3IgdGhlIG1pc3Rha2UuDQo+IA0KPiBBZGRp
dGlvbmFsIGNoYW5nZXMgaW4gdjM6DQo+IC0gRml4ZWQgdHlwbyBvbiBbUEFUQ0ggMS83XSBzdWJq
ZWN0IGxpbmUgKHMvTWlzY2VsbGFub3VzL01pc2NlbGxhbmVvdXMvKS4NCj4gLSBBZGRlZCAnRml4
ZXM6JyB0YWcgdG8gW1BBVENIIDUvN10uDQo+IC0gQWRkZWQgVmFzYW50J3MgUi1iIHRvIHBhdGNo
ZXMgNCw1LDcuDQo+IA0KPiBUaGFuayB5b3UsDQo+IEFsZWphbmRybw0KPiANCj4gdjI6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTA1MjgyMjE3MjUuMzU1NDA0MC0x
LWFsZWphbmRyby5qLmppbWVuZXpAb3JhY2xlLmNvbS8NCj4gDQo+IHYxOg0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNTAzMTExNTI0NDYuNDUwODYtMS1hbGVqYW5kcm8uai5qaW1l
bmV6QG9yYWNsZS5jb20vDQo+IA0KPiANCj4gQWxlamFuZHJvIEppbWVuZXogKDcpOg0KPiAgIGFt
ZF9pb21tdTogRml4IE1pc2NlbGxhbmVvdXMgSW5mb3JtYXRpb24gUmVnaXN0ZXIgMCBvZmZzZXRz
DQo+ICAgYW1kX2lvbW11OiBGaXggRGV2aWNlIElEIGRlY29kaW5nIGZvciBJTlZBTElEQVRFX0lP
VExCX1BBR0VTIGNvbW1hbmQNCj4gICBhbWRfaW9tbXU6IFVwZGF0ZSBiaXRtYXNrcyByZXByZXNl
bnRpbmcgRFRFIHJlc2VydmVkIGZpZWxkcw0KPiAgIGFtZF9pb21tdTogRml4IG1hc2tzIGZvciB2
YXJpb3VzIElPTU1VIE1NSU8gUmVnaXN0ZXJzDQo+ICAgYW1kX2lvbW11OiBGaXggbWFzayB0byBy
ZXRyaWV2ZSBJbnRlcnJ1cHQgVGFibGUgUm9vdCBQb2ludGVyIGZyb20gRFRFDQo+ICAgYW1kX2lv
bW11OiBGaXggdGhlIGNhbGN1bGF0aW9uIGZvciBEZXZpY2UgVGFibGUgc2l6ZQ0KPiAgIGFtZF9p
b21tdTogUmVtb3ZlIGR1cGxpY2F0ZWQgZGVmaW5pdGlvbnMNCj4gDQo+ICBody9pMzg2L2FtZF9p
b21tdS5jIHwgMTUgKysrKysrLS0tLS0tDQo+ICBody9pMzg2L2FtZF9pb21tdS5oIHwgNTkgKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2Ut
Y29tbWl0OiA4MGRiOTNiMmI4OGY5YjNlZDg5MjdhZTdhYzc0Y2EzMGU2NDNhODNlDQo+IC0tDQo+
IDIuNDMuNQ0KPiANCj4gDQo=

