Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F47C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmSZ-00017P-Nd; Tue, 13 Aug 2024 04:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdmSK-00012O-42
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:00:37 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdmSH-0001iB-9E
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723536033; x=1755072033;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t7Y2KXXYqGMW9CgPqN8OyS8q1qLFhshXbM94aFezy3c=;
 b=MQKUy9iuFXQfbrz/G3yJM3FaJpvADwgLDhi99NZxIAOAjni44tesk3MR
 PVQNhgO1SQ6HN5SQgArg4UG0Pc3zmkX3+hSE1kRNFg2SCwo1Jhc7e2+9+
 tqgzHS9ft4HoLV87cGZ4WuRtQy3CKtBu/tD9O6zPHeLk4eOM/HrWlj4Uv
 A2Q6pzpV6ym2V8kgIXwdZfPxEEgQcle8lBspr9ic65hMCGX3bYxexgpwW
 IJpip3eOfIbAPtN5SHiA9Emga0lTQOT+HgIGJrRGZiZKFqnfmXivty/Ze
 i31APeghHrTN9jRlNRqiNeq5KNHrDQH83CLm/W1fArl0EKHO2iGLBvhXj g==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18470313"
X-MGA-submission: =?us-ascii?q?MDGNGsFSqBaV82dh82c8cj1lncFAy57Nl/Qr4+?=
 =?us-ascii?q?MUoOZgHt5TeSEZnxTKamT61cn+wHJ8q5a4kwPPEusRhC9v/b4e2L2q1O?=
 =?us-ascii?q?ZEuxySb7JSrx9uSf6KsGtFNsTUWQ8I6U0KtafiI+EK09w9gVrcoCdmij?=
 =?us-ascii?q?h/07zdc/+TR/CbYyrbxbR2DA=3D=3D?=
Received: from mail-vi1eur05lp2169.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 10:00:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M41k0yDVSKeNJVPZk7avpCbP0Vb5Xv+zY2wY/hSs6s/19yeVF3NJgwkF1f0SZhwo8qmIbFXd94daTyKv3stW1jf8TjHkhbR1hmLIaOBJILHqQ1h5kIUMMPlRieYEvfbfHvcH4P6Jlxq32C7G1Snzecn4x87tjPaXyM8dQa6gt5xPnWzJoVefssKs8WXdN63lf+PHyhefilOHnCBEh3fnPK2AVDShqdKpvab3r5tvXlEPxh47d9DifhxF75RowC8exPbCT5EXeMevtydtpOozRCnqODQDkGNg/6CVY2gpJqidYGtjqIMltX6tiG/htsGxScg3C8xKaoPgJL8GKw9qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7Y2KXXYqGMW9CgPqN8OyS8q1qLFhshXbM94aFezy3c=;
 b=gphZYxtEaY4ejU3N7AWIR2nGeDcLVYQEtnf53wlRw+euJKg4O/iTB/pkp39JkNb7VQrXLSZhdRt4ylvELP6/elF4BhTpliCSsk+QHhfgIE4nnvt24yCjVisRMX1K6zZr7bTGBFqN/fylgqlbQjHOPsAempYeNBtNkZfFmX9BOP3j0aLH2r8F+LLxzsAxRSTrLu+NYUWSietYK5EqXLDpIKuhrjuJLIQdKIjCmUWdlmRJgr9TK4gVT+wBFrTsRjaVZmeeJ+DeeSXn5BHHWMc4DFATawrDzRLTEX+59OBpzYh7zcN7IarEPrL2l4J9+f3kbL03v7AD+nv/JspLLRhfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7Y2KXXYqGMW9CgPqN8OyS8q1qLFhshXbM94aFezy3c=;
 b=kl94T+pQXKghdKoZYJYpSLSR25gGQrhP9lxJqE43of7ak6nBoidrDDD9I5W1N7K+FEEab2HH9aVYTsrs0WGc9TDuTT/yWeE3ID/JsT8Xpk5Y2fNPWrVhhaVOnOLsih0JntziPqSjZ2EJcjd6NKMuJMCumP45KlIxlN6WcFVk0y/OaBvd4HqfGr6pZuXudwfHPeybmGgS4GZGLgiDNKpXuoCFMwxUow+WeyinkBSLnZkq/aHCU5P4HGo1nizhSYcNSFgLN78uy5cflDXU5b2EZQoQ1XrRQjXn3Hf8JdovOx8pqT4FNElVGOFL3JGjS2Pp8u1N15EZJLQe5y6bj7oHNQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV1PR07MB10144.eurprd07.prod.outlook.com (2603:10a6:150:210::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 08:00:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 08:00:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
Thread-Topic: [PATCH v2 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
Thread-Index: AQHa7VUXrJBDnUog0kG7JS4k/q6dIbIk0vWA
Date: Tue, 13 Aug 2024 08:00:21 +0000
Message-ID: <6ecf7b78-fb47-47ea-944c-f94e889e7427@eviden.com>
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
 <20240813074410.2571369-3-zhenzhong.duan@intel.com>
In-Reply-To: <20240813074410.2571369-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV1PR07MB10144:EE_
x-ms-office365-filtering-correlation-id: 05fbf2e0-d2eb-4b42-37c5-08dcbb6dfb1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OWk1Yy8zWmtIM2V3Y3U0dlQrdnVhTndKR2loMUNGQmlQb0RQM0ZEaitVU2Zl?=
 =?utf-8?B?d1BweVZETERjS0RNcnN6YnZLR0NvZ3ZxS09rWFZpTHVVM2VvS1ZmMXRkTlEz?=
 =?utf-8?B?c3hMR1UreE5ITUtaOE52amJ5WUl3NXIvZ1hCVDVqOWdNRml2ZW83KzcxbnBD?=
 =?utf-8?B?V2tQM1BtN1gwYWFkdmtMbFo5eU9HL1piTkJ0QXNYMnNTT1EwM1l1cENSUFc3?=
 =?utf-8?B?SmNla05jd0NZNlVJRi9vTFl1Q1VFR0FQczFOWE1JcSthc29QaUp6eHNiYkIv?=
 =?utf-8?B?Ynh1dWNWeDl3bGk2bEU5MVJucUJWc2w2Wm1VS2NjQVY4MmxDZHJzbHhjZWJx?=
 =?utf-8?B?Ulp1YW92V0l2M3VaeWJMbnJCK2pzZGlJeWJaZTVqNzExbmEwM2tzUzNwU1RG?=
 =?utf-8?B?YU1mbmtVN3lwOU5PU3l2YU90QWtKUHFNNC9lRGJFQzVvT3NkUHM0Vmx1aW52?=
 =?utf-8?B?dG92V01NYXVMSzU0ZTcrWVBxWHNUTFVoUEVNdEVjbEhocURiYjFtd3lTWGxl?=
 =?utf-8?B?c3dnTWJVWDk1YUVnajJxZFhoQkZMZ2VUUThOOXMvT2FraHBSdkpuZ1I1dFpK?=
 =?utf-8?B?VTFsaXNveE1lMU1qTU5TVFU2UHJtdXg4M1JYQjFnakg5Tkd5aUhnTTVjWmUw?=
 =?utf-8?B?UHBnS3h1SEtLQzRiMVgrLzY5NXMzaG9zeWpIKzZTSkhING9TRGt4S1oxKzB4?=
 =?utf-8?B?VXMvTWFqOWRVODNubzlPb1dQSFJTRHBWSjd2bFMxMUdLUkpLZXBOV2R5MWo2?=
 =?utf-8?B?ZUdGZnFmL29zT3VyR29hcjNLS3pFblNSZzRZVWR4Q0JXQnk5UWRBeFVRdmVU?=
 =?utf-8?B?VVZMbm5COE42YTBZNjB2bzR6eEd3YTRDdEhMcC92eGFidUxHOUVTY2IrUEZL?=
 =?utf-8?B?WndWYmxnK2Q1L2k4VWxSTXhrSkllYkZvQXYrb0tobDFBeU1hdXlESGhrRGd0?=
 =?utf-8?B?cFdyM09pS2xLV0JKQjlicWFPcGpLcDVvZWczUDhaeTRsWCttL3AyVmZidS9z?=
 =?utf-8?B?cEhoWlprMHFVOWFsM0luWTd1Nm9kR001UjlWRysrOHVHUU1PdTVOOHo1Rkxr?=
 =?utf-8?B?U2tCbUU3OEZkb0xDUEd3OWpTYXJzR2srVU1YUmlXSGFmeDVJS3I2MVU5Nk1V?=
 =?utf-8?B?d282cHFSSG0zb1BjK0IybGlLUzN5aGtMUng2VVh5N1c4d3AvUGhoMDdsTEty?=
 =?utf-8?B?YTA0a3BZcUNESjBla3RGcWZmVGdXNVVNbUEra0FBc0VyQ3Nxb2dRZnlHTmw5?=
 =?utf-8?B?eUh0YXo1VkVZTG5ybE9La1JQank2enRGWkp1UHVpalpQN2NjYlZ6Y0dBcVM1?=
 =?utf-8?B?SGtvWkZITkdpeFNwZ2NDdmxqa1V6Mi9yc1Y0OFlyZmlQWHlBSjZzekRtaUk5?=
 =?utf-8?B?clpHYlRrOFFWL1NMank5RXBIUmI1MkFKU0p0Ny9RN0NrS1dmTVdERENXNCtq?=
 =?utf-8?B?Q3dJc1lCcTBHRjhqUEMzUGQzR2czK3kzaW9CMHBxamZnVWN1UDZRZGRmNjM1?=
 =?utf-8?B?b2J2U2lHeHVXU1VTWUtzSTBBWGhQNnZTaVlJc0pxdVFmS3BNdFZqSWpsOHpH?=
 =?utf-8?B?ZjRhMEhNdkdydlFWQU45eXpmQzBRdHlaVnBMWmtrY0hPdC80ajNCSktSNzNK?=
 =?utf-8?B?OWNUa2ZtbWhta3RGTXBqMFAzYi9nNCtQSUJtK3MyYXVmdDlkcHdwSS80Z3ZF?=
 =?utf-8?B?b2hjL0o5cERSTFZaWkRzOHVha0Q5alFSVlNsVDZBb2c5YUdWd2RkWUVJbzZ3?=
 =?utf-8?B?bmJVemFZdE56Uk1ySFptQTZ0WWFiVzQyQjdtOERIZGFuUC9xVHBlNkJRRUI3?=
 =?utf-8?Q?KJ91LH14wq5eGobgrtRXu5WpxT1ygMwAj26+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djRNYUtOQ0p0N1IvR0VHamk4dG5ISy80Z2xYY1FPQ3hOR0lJb3JVRWVKbUll?=
 =?utf-8?B?Tm9PckVlWDhwT1hKdTNyMXY4NnBJbm1Ya2xsRFl1RkRwWjlBa0VMdVh3b1B0?=
 =?utf-8?B?NytVd1U1cmpVMTY2eEtVTzNuNU5JN2tnYWZHWjhJc05hUEJaaFBhMWwvRE1h?=
 =?utf-8?B?dThISU1iNmpmYnVvMU9XWVIvMVBiMzZURzJKek5WSEM4VU9oMFhSNVhFUnZa?=
 =?utf-8?B?VnFRclNUelk5bmxjWjBybFVLY2NReks0UDl1Mi9PRmRQR0xUM1RBWWlxM0Y1?=
 =?utf-8?B?SUJXZVVlOTBOcE5yYm04UTJ3L3RNRWtxTXJZUHdlTDQ1Wk9LNVg4bUFpR1o2?=
 =?utf-8?B?QUhKTU5QLzFOc2dBUldPYlVEazI3RFVkWmt2SnFKZ280K2UrWDdMRmpaRlpE?=
 =?utf-8?B?djloMzBVZXFhT0pwRHdRa2FZZDdIUFIzOE0wbVo5Skx1N0dRcDIxNkdiSGtG?=
 =?utf-8?B?WWR2bmFGQ2JPZy9kd1BMVVJ2VGVwT1FoenNHWkcxSzN5UnBaTWIzNmFuQ0NJ?=
 =?utf-8?B?OHhxZUx1Z1N2VnQwbEZsWFdxWm9PUHFFUkl1YnVJdGx2STNrd0Z3RGNvbU96?=
 =?utf-8?B?cDM0bi8rR1FEUXlCTEZ5QWtST1E5Q2lTbkdwcGJpZ2pGdVJ5Z2cyTGVsVEdN?=
 =?utf-8?B?SWlhb3ZJNnE1M0tNTGtqeWNxTWRTNU5hWVF3TnhvYnpiUWp3d2s4MVNDNzYv?=
 =?utf-8?B?UFJxUEh6bzZvK0VPOGpZTGNXL1JtZ1REUjRtMTVqVTA5WjlKemZuaXlqSFNs?=
 =?utf-8?B?NkxZL29WeUtib0FycFNFeXJxVkRuNUU1SDRmSzk5MENoUmo2RXhLb2tFMFBr?=
 =?utf-8?B?M1hWbnh0V3hXZ0tmaUwrY1huVjhNUlI5TW1vYm5PUEx0TWx3NTlLWmlaUTRx?=
 =?utf-8?B?SXJNSiswNFZWdkU0WjdES1UxYWFwYzdkVWNsc3lpQ21YME5sakg1clgxVHlS?=
 =?utf-8?B?aEVkcjlHOURPY0dtY1dSOStGL2FhU1djMDFFeXVuQ1ZlOThhUzQwRVlXYkxW?=
 =?utf-8?B?clNBYjZOVEVaRnkybXJBQlFybldubUVFZG8zejFIWFB6V0IvQWVpNkQ4MGEw?=
 =?utf-8?B?QnY2dlVlaW1rVUs4Tk40SlZ1dU1kWVpRZE12Y2oxcGREY01VZE9Ea1lvNmlW?=
 =?utf-8?B?S2xnUXJzajBTRk1memZEazRMZ3V6SlJ3TmlKWmZRWjJTTDFFWGNhRU9UeXIv?=
 =?utf-8?B?RmhLUG5YL3lvSmllaTY1WFhRdEF1SUU0OUhGaVhUWVNOb1Zwcm9Pd1JzU3lT?=
 =?utf-8?B?SUhXWExGSUpUbkpmekd5aEp5b0F6SW1oTm5zY3FPSDJjRlNzM21BeStmWnMz?=
 =?utf-8?B?YVk5Q2hpWlQ1eFBla0tLZWJGcCtwVm04RndPMXhzbDEvL1RQMXA5TWg4RTFv?=
 =?utf-8?B?QkF2dkd3RnBmMk04aXI0MzBIaEFaSlVTNjdrV3kva2lPcVlkUXdaRmpSVzVS?=
 =?utf-8?B?OW1ObXR5Q0dNbmVSdUVkUmN6bGprc1FsNEt0U1hUY25VRm9TbUdOaVgwS0ls?=
 =?utf-8?B?N3BjQU0rbEt3NkF5Zm5yZy9VVmU2d0g3UzE2Nmlsd1Vocmc1a1ZjYmp0TjQ4?=
 =?utf-8?B?bStYRWswVzdqcUVvUXpVT2MyTGpmK3Zka1h6dG9lOWZaQXRRTWUyZUhQa05j?=
 =?utf-8?B?c3VpY1lJV2xpb210YVFhQTI3ZzdFUENoT2dBUzZIYVg3aUJIMTA3NkludGY0?=
 =?utf-8?B?aStoRzUvR2RwMkJid0sxTEJlc1hOYm0vcnR1OFQ3bm9jNjVGeERIdEs5WGhz?=
 =?utf-8?B?djBOdFN0VkhGYWQ0ZEE4VFhXbWowWEVqbElVRSthNS92WmxOdVFXM1BkSGJL?=
 =?utf-8?B?bGRNRS9MOHFNVGVzbnJjSjNSUFoyMnVJVjFNUkFiK2xqL1Z5cTdlS2tqMlA3?=
 =?utf-8?B?aUtWYzlPWEZaNzRqcklIdWZYekZjbFdpRTlRY0xtckhMbWRIN2NRVlRmWmwx?=
 =?utf-8?B?Y2FubDVtOUd0TFplR3B3K3djWlEzVVVSZGVqTnZya1lsNlArb3NWZ1drQm5v?=
 =?utf-8?B?aVprQThzclN0MWd2WGl6dTVqY2xKdE8wMXR1YVhIajl6clBxYlhZR0VPTWlt?=
 =?utf-8?B?UXNiYktOUnpEQ2ZrSWlpT0dwb1NkZDFma2VLQ2I1dDlzOGlRNVAyeFFwMVh5?=
 =?utf-8?B?bWpQYW1xNkdLeFlhdUIwUmtoWUNqbU02WjFYRlR5ZUNtTHBwRHNCNU90Z1dq?=
 =?utf-8?Q?tGfV+MTC/6ePm0c+8/bX3s8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5B72967B980C469ACDF71CFEA24F14@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fbf2e0-d2eb-4b42-37c5-08dcbb6dfb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 08:00:21.8202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDukAplcW5+TmN2Ki4fSWJ26Ot0blw01fEY4f+JnvvSAjIEAM7IW+L/lhJdgk6izqg90TlPiAZbsM3l9+DDpOcrNeMHYZLdIfRBcKWvdEkFyLOxLmbop+UJ+VVJL6nSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB10144
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNClN1cGVyIHJlYWN0aXZlIQ0KDQpNYXliZSB3ZSBjYW4gY29udGludWUg
YWxvbmcgdGhpcyBwYXRoIGFmdGVyIHRoZSBoYW5kbGVycyBhcmUgaW1wbGVtZW50ZWQuDQpJdCB3
b3VsZCBiZSBncmVhdCB0byBtYWtlIHN1cmUgd2UgZG9uJ3QgcHJvY2VzcyBQQVNJRCByZWxhdGVk
IGRlc2NyaXB0b3JzIHdoZW4gbm90IGluIHNjYWxhYmxlIG1vZGUuDQpXaGF0IGFyZSB5b3VyIHRo
b3VnaHRzPw0KDQpUaGFua3MNCj5jbWQNCg0KDQoNCk9uIDEzLzA4LzIwMjQgMDk6NDQsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4g
YXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+
IEluIHZ0ZF9wcm9jZXNzX2ludl9kZXNjKCksIFZURF9JTlZfREVTQ19QQyBhbmQgVlREX0lOVl9E
RVNDX1BJT1RMQiBhcmUNCj4gYnlwYXNzZWQgd2l0aG91dCBzY2FsYWJsZSBtb2RlIGNoZWNrLiBU
aGVzZSB0d28gdHlwZXMgYXJlIG5vdCB2YWxpZA0KPiBpbiBsZWdhY3kgbW9kZSBhbmQgd2Ugc2hv
dWxkIHJlcG9ydCBlcnJvci4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMjIgKysrKysr
KysrKystLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCA2OGNiNzJhNDgxLi45MGNkNGU1MDQ0IDEw
MDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+IEBAIC0yNzYzLDE3ICsyNzYzLDYgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nl
c3NfaW52X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiAgICAgICAgICAgfQ0KPiAgICAgICAg
ICAgYnJlYWs7DQo+DQo+IC0gICAgLyoNCj4gLSAgICAgKiBUT0RPOiB0aGUgZW50aXR5IG9mIGJl
bG93IHR3byBjYXNlcyB3aWxsIGJlIGltcGxlbWVudGVkIGluIGZ1dHVyZSBzZXJpZXMuDQo+IC0g
ICAgICogVG8gbWFrZSBndWVzdCAod2hpY2ggaW50ZWdyYXRlcyBzY2FsYWJsZSBtb2RlIHN1cHBv
cnQgcGF0Y2ggc2V0IGluDQo+IC0gICAgICogaW9tbXUgZHJpdmVyKSB3b3JrLCBqdXN0IHJldHVy
biB0cnVlIGlzIGVub3VnaCBzbyBmYXIuDQo+IC0gICAgICovDQo+IC0gICAgY2FzZSBWVERfSU5W
X0RFU0NfUEM6DQo+IC0gICAgICAgIGJyZWFrOw0KPiAtDQo+IC0gICAgY2FzZSBWVERfSU5WX0RF
U0NfUElPVExCOg0KPiAtICAgICAgICBicmVhazsNCj4gLQ0KPiAgICAgICBjYXNlIFZURF9JTlZf
REVTQ19XQUlUOg0KPiAgICAgICAgICAgdHJhY2VfdnRkX2ludl9kZXNjKCJ3YWl0IiwgaW52X2Rl
c2MuaGksIGludl9kZXNjLmxvKTsNCj4gICAgICAgICAgIGlmICghdnRkX3Byb2Nlc3Nfd2FpdF9k
ZXNjKHMsICZpbnZfZGVzYykpIHsNCj4gQEAgLTI3OTUsNiArMjc4NCwxNyBAQCBzdGF0aWMgYm9v
bCB2dGRfcHJvY2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgICAgICB9
DQo+ICAgICAgICAgICBicmVhazsNCj4NCj4gKyAgICAvKg0KPiArICAgICAqIFRPRE86IHRoZSBl
bnRpdHkgb2YgYmVsb3cgdHdvIGNhc2VzIHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4gZnV0dXJlIHNl
cmllcy4NCj4gKyAgICAgKiBUbyBtYWtlIGd1ZXN0ICh3aGljaCBpbnRlZ3JhdGVzIHNjYWxhYmxl
IG1vZGUgc3VwcG9ydCBwYXRjaCBzZXQgaW4NCj4gKyAgICAgKiBpb21tdSBkcml2ZXIpIHdvcmss
IGp1c3QgcmV0dXJuIHRydWUgaXMgZW5vdWdoIHNvIGZhci4NCj4gKyAgICAgKi8NCj4gKyAgICBj
YXNlIFZURF9JTlZfREVTQ19QQzoNCj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9UTEI6DQo+
ICsgICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+ICsgICAgICAgICAgICBicmVhazsN
Cj4gKyAgICAgICAgfQ0KPiArICAgIC8qIGZhbGx0aHJvdWdoICovDQo+ICAgICAgIGRlZmF1bHQ6
DQo+ICAgICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgaW52IGRlc2M6IGhp
PSUiUFJJeDY0IiwgbG89JSJQUkl4NjQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICIg
KHVua25vd24gdHlwZSkiLCBfX2Z1bmNfXywgaW52X2Rlc2MuaGksDQo+IC0tDQo+IDIuMzQuMQ0K
Pg0KPg0K

