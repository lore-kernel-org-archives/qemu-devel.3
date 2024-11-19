Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C50D591D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 06:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDI8r-0007NG-QO; Tue, 19 Nov 2024 01:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tDI8q-0007Mu-LO
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 01:55:16 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tDI8n-0003qs-Nb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 01:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1731999314; x=1763535314;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZoJbqdKzTFvuYQsXoKSLgAiRvYIrtiEC+T63Lz8+RTg=;
 b=k6XwBXruo0TEcxpvNpqFNPU5FZB0Esx6kFjqR906iuaR1TsS+yVTxL5B
 wpJXPJV0Tvn4G14S+AmpzNnOBtQzX2pMSj2alNnkTGTsiRcGe6U99UNzS
 C+VGHjt9Kj1b7xjRHCgYSpNrevOt8FaxRMzJORzB6pLXFzKTY0SZWOu9/
 z+E54GYfoAJNcl9S5C29VVOaMbCxVGN1/l9EJCOCkfY5HRGxRVwCkz1Rd
 vPcso7dBeGisiQ+MWBL5blOTUIaC06NIRrowj63itgPuhuanwuyPj0gIG
 TjXdJStoTPmNjJLXVZ65jkcFxgtuwvCJ0JoBJpx3CFxflaFsUlqiJKxWC Q==;
X-IronPort-AV: E=Sophos;i="6.12,165,1728943200"; d="scan'208";a="24933663"
X-MGA-submission: =?us-ascii?q?MDEPCfZAiGC5nTgCdCtkclPOBLh/Q5wygidy22?=
 =?us-ascii?q?oheEhuD9ty3ZU9RliSt1HQ7F66mYDHid7mKuOxy0ebdVJsQW2OGYJW/n?=
 =?us-ascii?q?RzjDIOL6vFMpu/me+6Sx63B46sF+j5OJZ9SlWqkwo3uac8yWUIO48WgC?=
 =?us-ascii?q?9s3LTl8+Q6ftPD1iZenaaN6g=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2024 07:54:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFbLJMIRgbv/67Es+0OSYGTE2H67KVI5GvMSf7yiNu7RqEFo9kMQvGjUvn9V4k6vDHpsoNw6y0GQRvoWoz4WmWKmZ/dlaPMfYtW4zZF4tsza8yOhz+YuBSjyEG0FMgYYSFlu5OPxI5oqfbqjAmwhVf+AZEpce8tJSlnAfBkz2t+8yjog1lmFabosY6erq7w7KXSGEnuP93iC7hTYElaMm9b+2YIk7DPSP18LKU6KJFq+W/FeCzjc3Gn7FSjFHfxuPKPoo8IJI8pWO+0NXoJPm28tQsYQ6OWyYVwCLUNrVBHuysGkA1jr26g6Uh19+nC43IUnYFYGZ1uy4KqOkq8roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoJbqdKzTFvuYQsXoKSLgAiRvYIrtiEC+T63Lz8+RTg=;
 b=IzV8XnYCFIYpyqyq6UC67W/Ya7QCnOF+Xj24rNEvDhb218XOQZ4XTdm7hmPWKD6BjCnk+F9OxHU+FRd1pgaaXXprY5WT2L7g+zcCSpVQC4JrMe1msQ76DkFMdMpPhZIcud8om0hL4WFE6XYfUd3ogk1nJbG2B/gVHuDsvk7tK1epo6bBaoP5N0ZNEHIj+PC5OlN4fiG2Jqx6x2cUWsUOpsNw3Ks/RtTfnbvX1pbxj2Nt0YjfVXMysizur64uffwsRTyUm8pWpcTcqAXHORdp7GbSdDiq7CyTL2MmBq3cQXuX2X9xChVjtpqCiQs3IKy+3byLkPIDzahMDtNLC68ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoJbqdKzTFvuYQsXoKSLgAiRvYIrtiEC+T63Lz8+RTg=;
 b=pmLHb6ZulDSpBO21OOuHBuH1Scn9KSFoU+4Mz7V3Hz8GxhUwkkCfI3LHJbhyhjxLXngzzXCSHOoJFWZPgbANBtZNtlcT8BoGBl6FlkJYtDb084ySJhGHxyeLBog3O8tw30JfiCHklQhLpsZr/gvHdTngl9O4N5jPTf1IxNc6n5DRh/BTw8iWvafwRiz7Jie3Ttz6x/0yIePDxLIacLZBSvRcNDOBd3Er9dR7bt7EnYo+Vc4qzf9VbdFdCzk0RATLJwHJyZe/lz9zZG5v+nDVoWFP1r32+n+k/a2BpiJPFrUtANrhHvKb2bjQjnI+/dbl7eFqqxVJUB9v3JPVKBnjmA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7319.eurprd07.prod.outlook.com (2603:10a6:20b:25b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 06:54:33 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:54:33 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBU5r5oNBkqzVUqCcHjZN6/EL7K+N5YA
Date: Tue, 19 Nov 2024 06:54:33 +0000
Message-ID: <3dfc784a-4397-4dd2-9d1f-26549fa09226@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-19-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7319:EE_
x-ms-office365-filtering-correlation-id: a64be150-a2a9-4e8e-a22c-08dd0867060e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MldZYjV0RFpVOWx6NzBjU2tld01PcW9xQ293TVBtRWZYQnVUdnJ3cjZEa0Na?=
 =?utf-8?B?WGlwdUtwdHJJWkwzVC96aHk3cm5VeGl5cXV3Y2lEQlV6NEUvYXdEd21uK2FK?=
 =?utf-8?B?OWFSemQ1d3VEalduZnZSZkJyU2FQSlhVSklPVEErTkVvUlZqN01tSkhSVVJW?=
 =?utf-8?B?clFjdS9BanY5c2p2RnVNOEg0VEVFd0pDNzBma0RLRXp1d2JqbjJ6cGVQMklN?=
 =?utf-8?B?Z2VtaytEc3ZWcnVUa0U1QTRWMzVTam5pbzd0UnV6Q1B1Mk9iUDYrbkx3WWZQ?=
 =?utf-8?B?SlM4VWY5MmdlUjg2V2kxRFQ2K25LYTFCaHBaUXY4ZDZXeEk4N0oyeEgrT1cy?=
 =?utf-8?B?MVhpZXBBc2FHVVIzWnIxQlIwQm81ODBjK2gzM09uUzI5Zzlua0JGN3oyTXpF?=
 =?utf-8?B?OTZxSExnMk41ckhEUnA4QnNsMXlEeGlRTUI1RWRGOUZrcXpQeUtycklYbW1M?=
 =?utf-8?B?bTFBdWxRVmY0ODVnWTRoOURFZitGSlR1UUNjb04vdXFvOW9zN3FZUy95ZUJ2?=
 =?utf-8?B?b0lSVDRDSWRYcWxjTFZ0NUhuTzBnYnNoOTlITVZzMEkxR0xFak8rdFI4MFN0?=
 =?utf-8?B?RlM0NUdnMVNkbk9BNWRRK0NqVVhpM2s2Uy9sYm5xVXlYeEwzMElaRnZpZm5I?=
 =?utf-8?B?dDBWU3E4TWNaL016S3FadG9iOHR0eGJsQmtYV09GWlBoai9oTXQ5S2VGaTJl?=
 =?utf-8?B?N05GRDZVWmFuSXI2MmdGNW9QOUNoQ1crOFd2cFhNRGR4NUxJN3Ftb01obWZm?=
 =?utf-8?B?QkFEbWdLa0M1aHF1dmJVYTJkT3NQbkFsZm9lVk1RckhwU3d3cHFWT0EyTUVO?=
 =?utf-8?B?OXBhMExvQkJ0WFBkc0l5UXJwdnpzMG5KT3JmYXFHRDhEbWZ3VnIydDFKVmVT?=
 =?utf-8?B?c1NBNVAwb2FpM1g5clhVRURYUm1iTjJGY3pmYXJuaHk0cEozcisyaVJ2dUZC?=
 =?utf-8?B?Qy9udUhMbjZYZ1ArNTR3QTViUG0xc0xnRjI1Y3hEbzdWWkdrNzBCSWpDSGIr?=
 =?utf-8?B?YThmY2ZFOUY2MG5aMGxLbGtCb1ZRRFRvVmhlQ0hPeEdHSWhJY2xxSkxBY1Z4?=
 =?utf-8?B?V2UvRGtoUXVPRnJ2TTF3T0h4eXdDbS9CM1R5UnNVa0N5ZEpyWTIwWWo2N29w?=
 =?utf-8?B?dk1TRzZrbFo3cXhVUHJWRCtkVTlEWFpUYyswUlF5NlVlb2lKL1Y2c3RYWTFT?=
 =?utf-8?B?dm16TENnSEMyazFSSmdob1kzYWFsa3hyeE5hU3dycEk5L3A5cStHZXNhUWx4?=
 =?utf-8?B?RW5XWW5mRWtVWGRudDFySGMyVFNPQU9xWndDbEdGNjdnbWVUZzFacjBqRzBN?=
 =?utf-8?B?S3E4SVVxMGUxSFhoZDZ1RGRKaWk2ckJSanZ4Wm1wQTlsYk1ORytMYUZieEp0?=
 =?utf-8?B?b1VLdW1TYVhzWHQzSUJYUmxsOGsybWVNcDRBZmJlc1M0SzVlanRacEE3U1Fw?=
 =?utf-8?B?MU4wbnRMaTFFRnJrdmNyYUptRTdBQmozaWpRalN5R0JaTnFXMW45T283dEVU?=
 =?utf-8?B?ZjFYdyt0RkdKMU01SDJsL0ErY2NTc3NCV2NxeG9mMWtqMUQvM3BnaGFaaHpi?=
 =?utf-8?B?UHAyMFlCdnZTSnh4MDR4RVUwaWdlRStsSWtTUWlZUGlCcHIvOE03eUhDUUt3?=
 =?utf-8?B?NTBaMFczSllsVnhyTHZOajg0Unc4eUpVVWttK2xXajZoWUJ0MktFZjNTR0VP?=
 =?utf-8?B?REZDOUdZSklMZDJuKzIybTg2RDJFY3hyb21CM3laZ29NcVh6a3NZWFdKWTNH?=
 =?utf-8?B?QnYxZHRnK2l4WTk4eXp0NjhNS2kySDd1Vk5WQk5hRkhnVzYzT2d0blRXMDI5?=
 =?utf-8?Q?6xapr8ZT7hVJJEwy0ThQqSKVcuKFZREGYckkI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTRBYmRTbUJkVTUwcXJvc3VoRXdEZ1BUR3hvWm5wdTVLTndheUZPRGlvL3JC?=
 =?utf-8?B?ZURVTm82MTJNd2I2QXhEQzMwK2Q5SDc3SEVOWFRTTE9yT1l3SE9PV21MRW1K?=
 =?utf-8?B?eTVrVHNVSWcvbk5tTTRBZEh3TGRUZFVUSnlKOGdzT1ByZDBtUWoraUNBSFdj?=
 =?utf-8?B?Nk4xd2JKcWVUUC92ZFNQaENpOWphOTYzdlp6M0tJQnp3M3FmNU8yQVczSUJE?=
 =?utf-8?B?SUpBOWpkQjRpN0pocWlNY0s0REhLeW9Fc2RXQXhwZDV6NWwwalJjTExIYWk0?=
 =?utf-8?B?bTNVN1VkYndCV3BsOVNWZEJnTVpkeXRRM0NYNzRGeDBVRmE2MXViUUQ3Z0VG?=
 =?utf-8?B?eUU2K3VRRGlMdG1halJkNVYyN29hUWgwMUh0V3NxTU9lMnM3a2lLV3ZLWVlT?=
 =?utf-8?B?aFAzTmVKWFRxN0RuQVd3RUptTDRGZk1xL1VRaTVBQS9mOE8raHJQclo5QWRY?=
 =?utf-8?B?a1RXWkRTMmtJM0ZrSmIzQzl3UmpZanBIUEtDcFFkMllkM0dOd1dERkJvb1Q5?=
 =?utf-8?B?OVljbEMzZXQ1UXo0c0Z1cTB3c3pqbXZNYXF1RVV0WTlrUVBMcGdaRUhwZzJw?=
 =?utf-8?B?SGFLWUFqQWFzQjRrMlYybndlc1NkWGZlL3RlMDZsdnB3UmhvRmE0aWF6YVJR?=
 =?utf-8?B?ekZtUzdpMWV0WHJ1ekYzd1crSXNTS285dkgrdFV2VXQrMDdzeDRKekc1RUdK?=
 =?utf-8?B?VDArOFAwbFdwaFJtc3NIMlhHZUhJRG0yVXJQbTdwV3ZjM1lybk9Da2Q1ZWpS?=
 =?utf-8?B?T0hhSk9MQXhSMmVKQU8zcklHRWIxNEFxcmc5Vm9vN2lXWVFjNWVoUDlLQ3NX?=
 =?utf-8?B?aXZEOHVZOVpYaHNFSGZvaUNDSytHbFgvdlE1a3V1aFliUm54bGtXRFJpeWxB?=
 =?utf-8?B?bUFvakZFOVpBZWZobEx0RmtuWXZDK2xyaFZ0NE85cVFTc1FjbnFFZkVMeXVv?=
 =?utf-8?B?Y3U1NzdYNHhDSWpwNldMRUZwZ2NRbDYxVGRkeWFRYyszMW8zY3FFTlNLUXdW?=
 =?utf-8?B?bWRhQW5LbDlhVVJCY0RhZFZFSUxxeC9SS05ENm4rWjlVVjNZZFBYMkhoeFVO?=
 =?utf-8?B?Q1d0dnNVOHYzbWJOU3FkSThkR3QwbmdhVFhDNytkUzVudEpESWFpa3g3MHE5?=
 =?utf-8?B?ck1HcnhmWWg3cEFBY2JLWnBKMVY4ZTNyMmZzb1dXUXJTMWMyTmlOdXZDMWZX?=
 =?utf-8?B?RG84cnZjblROL2Z6cFFHWmllT2FMNGx0RS9JZzV2MmhMaExJVURDK1RQa0pF?=
 =?utf-8?B?YXhmY2t6RXEzOSttQVRKblYvWi9FdEVQbVVBSk9MdW5jY0NvRXlUNmxXb3NC?=
 =?utf-8?B?VUs4WTJyMFhNb1RuT0VWYzZSVlQ2ZHBZRVdqVDhwdG5NQm81VFdLK3JZd1Jp?=
 =?utf-8?B?WDhsclJkOHh4L2prb3lZeUxNL2dzYWhUZVkyTHB6R3IvblRhMFJXYUNQbHcw?=
 =?utf-8?B?NHQxK3FzekZGbk9WMkFnZnJzcURxbkJ6N09KWFlWbDU0cDFGcitZajFCK1hG?=
 =?utf-8?B?SkRpZGIra0RiQkdTdnZnS0F1cnBqbDdBTUtXQVAyNGdsMFJzd0N1NzJVQ1dO?=
 =?utf-8?B?OHhqZ2FLeVRlMjlSSXhXemI3U05nb1VqMnBUblljMzhCNjlma1dFREo2RzR4?=
 =?utf-8?B?NVFyYUlLZ2tDQ3l5NFB3QkVWV040NnNrRnZGa0t0b1ZEa09PK0FFZzMxS2E2?=
 =?utf-8?B?MTZRNHlINnl5ZTI0RTFsSUtqYXZXUEJVUm9aMERzVVQ0RGVOMzRpWDFSb1B1?=
 =?utf-8?B?NXJQNzBCUUUvcG9Fa09WVGJIdTB2ZjFVa0ZsMVVzS0ZSaWM5M2VoRDhZQVBJ?=
 =?utf-8?B?aFlyOE1RN05kRG9kU1BvcGMzWUZmTnNtdlRoZUhPOTZURkhhZTEwdGV4OTNy?=
 =?utf-8?B?dFZsWnRYVFR6bzd5NjkxTEtpQzV2ejA2aDh5andremQ1TVVNTkYrOXBaTStP?=
 =?utf-8?B?Qy9IeFhPb0Y5ekxxTjk3dUtiUlBuTEQyZXEvY2p6UlBseWpZS3RoOEVVSDlh?=
 =?utf-8?B?VWwxaklzUTE0dDY5MWtLWm5BU2JrcWxxR2l1QnAvWlpoV2RaWTBZVHljc0dn?=
 =?utf-8?B?c3NQdUUzUE1DbnNXb3RqYjFtUkxMK0FrdDdveW9LNGtzWHQwMDZEV0tNam03?=
 =?utf-8?B?dFppTHBya0doWkl4b2NmZTBFU0hBazRLc0s4enNnUERPMVR3UGlaZG5iMEdN?=
 =?utf-8?Q?MaSCd0h3EY3Z7cihkURjS3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527A473309D3CF4CB794153A4AF02009@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64be150-a2a9-4e8e-a22c-08dd0867060e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 06:54:33.2710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCX/pISvxjp1ILTBTUtf1d/m3RoLg1wDt4i37j95LwMzlYXtB8IDQwVwv1+M7RMlcW2XXA+pkEkS6Ea6NGugp0lGPirQqJX0zb9r6VxnMo1hm0nsbSTmveNkIkpXkVQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7319
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

SGkgemhlbnpob25nLA0KSnVzdCBvbmUgY29tbWVudCBidXQgeW91IGNhbiBhZGQgUmV2aWV3ZWQt
Ynk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5j
b20+DQoNCg0KT24gMTEvMTEvMjAyNCAwOTozNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENh
dXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBs
aW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gSW50ZWwgVlQtZCAzLjAgaW50cm9k
dWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YgY2FwYWJpbGl0aWVzDQo+
IHJlbGF0ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBhcmUgbXVs
dGlwbGUgY29tYmluYXRpb25zLg0KPg0KPiBUaGlzIHZJT01NVSBpbXBsZW1lbnRhdGlvbiB3YW50
cyB0byBzaW1wbGlmeSBpdCB3aXRoIGEgbmV3IHByb3BlcnR5ICJ4LWZsdHMiLg0KPiBXaGVuIGVu
YWJsZWQgaW4gc2NhbGFibGUgbW9kZSwgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gYWxzbyBrbm93
biBhcyBzY2FsYWJsZQ0KPiBtb2Rlcm4gbW9kZSBpcyBzdXBwb3J0ZWQuIFdoZW4gZW5hYmxlZCBp
biBsZWdhY3kgbW9kZSwgdGhyb3cgb3V0IGVycm9yLg0KPg0KPiBXaXRoIHNjYWxhYmxlIG1vZGVy
biBtb2RlIGV4cG9zZWQgdG8gdXNlciwgYWxzbyBhY2N1cmF0ZSB0aGUgcGFzaWQgZW50cnkNCj4g
Y2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5p
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
ICAyICsrDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMjggKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBpbmRleCAyYzk3
N2FhN2RhLi5lOGIyMTFlOGIwIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IEBAIC0x
OTUsNiArMTk1LDcgQEANCj4gICAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAo
MVVMTCA8PCA0MCkNCj4gICAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVM
TCA8PCA0MykNCj4gICAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAgICAgICAgICAoMVVMTCA8
PCA0NikNCj4gKyNkZWZpbmUgVlREX0VDQVBfRkxUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ3
KQ0KPg0KPiAgIC8qIENBUF9SRUcgKi8NCj4gICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+
IEBAIC0yMTEsNiArMjEyLDcgQEANCj4gICAjZGVmaW5lIFZURF9DQVBfU0xMUFMgICAgICAgICAg
ICAgICAoKDFVTEwgPDwgMzQpIHwgKDFVTEwgPDwgMzUpKQ0KPiAgICNkZWZpbmUgVlREX0NBUF9E
UkFJTl9XUklURSAgICAgICAgICgxVUxMIDw8IDU0KQ0KPiAgICNkZWZpbmUgVlREX0NBUF9EUkFJ
Tl9SRUFEICAgICAgICAgICgxVUxMIDw8IDU1KQ0KPiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAg
ICAgICAgICAgICAgKDFVTEwgPDwgNTYpDQo+ICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOICAgICAg
ICAgICAgICAgKFZURF9DQVBfRFJBSU5fUkVBRCB8IFZURF9DQVBfRFJBSU5fV1JJVEUpDQo+ICAg
I2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNykNCj4gICAjZGVm
aW5lIFZURF9QQVNJRF9JRF9TSElGVCAgICAgICAgICAyMA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IGluZGV4IGI5MjE3OTNj
M2EuLmE3YTgxYWViZWUgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gQEAgLTgwMywxNiArODAzLDE4IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCB2dGRfaXNfZmxfbGV2ZWxfc3VwcG9ydGVkKEludGVsSU9NTVVTdGF0ZSAq
cywgdWludDMyX3QgbGV2ZWwpDQo+ICAgfQ0KPg0KPiAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNr
IHBhc3NlZCwgb3RoZXJ3aXNlIGZhbHNlICovDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgdnRkX3Bl
X3R5cGVfY2hlY2soWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11LA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPiArc3RhdGljIGlubGlu
ZSBib29sIHZ0ZF9wZV90eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRy
eSAqcGUpDQo+ICAgew0KPiAgICAgICBzd2l0Y2ggKFZURF9QRV9HRVRfVFlQRShwZSkpIHsNCj4g
LSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ6DQo+IC0gICAgICAgIHJldHVybiB0cnVl
Ow0KPiAtICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KPiAtICAgICAgICByZXR1cm4g
eDg2X2lvbW11LT5wdF9zdXBwb3J0ZWQ7DQo+ICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X0ZMVDoNCj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9GTFRTKTsNCj4g
KyAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ6DQo+ICsgICAgICAgIHJldHVybiAhIShz
LT5lY2FwICYgVlREX0VDQVBfU0xUUyk7DQo+ICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X05FU1RFRDoNCj4gKyAgICAgICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFibGUgdHlw
ZSB5ZXQgKi8NCj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIGNhc2UgVlREX1NNX1BB
U0lEX0VOVFJZX1BUOg0KPiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX1BU
KTsNCj4gICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgIC8qIFVua25vd24gdHlwZSAqLw0KPiAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiBAQCAtODYxLDcgKzg2Myw2IEBAIHN0YXRpYyBpbnQg
dnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAg
ICAgdWludDhfdCBwZ3R0Ow0KPiAgICAgICB1aW50MzJfdCBpbmRleDsNCj4gICAgICAgZG1hX2Fk
ZHJfdCBlbnRyeV9zaXplOw0KPiAtICAgIFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9J
T01NVV9ERVZJQ0Uocyk7DQo+DQo+ICAgICAgIGluZGV4ID0gVlREX1BBU0lEX1RBQkxFX0lOREVY
KHBhc2lkKTsNCj4gICAgICAgZW50cnlfc2l6ZSA9IFZURF9QQVNJRF9FTlRSWV9TSVpFOw0KPiBA
QCAtODc1LDcgKzg3Niw3IEBAIHN0YXRpYyBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3Rh
YmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAgICAgfQ0KPg0KPiAgICAgICAvKiBEbyB0cmFu
c2xhdGlvbiB0eXBlIGNoZWNrICovDQo+IC0gICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayh4ODZf
aW9tbXUsIHBlKSkgew0KPiArICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2socywgcGUpKSB7DQo+
ICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+ICAgICAg
IH0NCj4NCj4gQEAgLTM4MjcsNiArMzgyOCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVy
dGllc1tdID0gew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BRERSRVNTX1dJ
RFRIKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01N
VVN0YXRlLCBjYWNoaW5nX21vZGUsIEZBTFNFKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgi
eC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLCBGQUxTRSks
DQo+ICsgICAgREVGSU5FX1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01NVVN0YXRlLCBzY2Fs
YWJsZV9tb2Rlcm4sIEZBTFNFKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgic25vb3AtY29u
dHJvbCIsIEludGVsSU9NTVVTdGF0ZSwgc25vb3BfY29udHJvbCwgZmFsc2UpLA0KPiAgICAgICBE
RUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lkLCBm
YWxzZSksDQo+ICAgICAgIERFRklORV9QUk9QX0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVT
dGF0ZSwgZG1hX2RyYWluLCB0cnVlKSwNCj4gQEAgLTQ1NTgsNyArNDU2MCwxMCBAQCBzdGF0aWMg
dm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPiAgICAgICB9DQo+DQo+ICAg
ICAgIC8qIFRPRE86IHJlYWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3aGljaCBjYXAg
dG8gYmUgZXhwb3NlZC4gKi8NCj4gLSAgICBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPiArICAg
IGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNB
UF9TTVRTIHwgVlREX0VDQVBfRkxUUzsNCj4gKyAgICAgICAgcy0+Y2FwIHw9IFZURF9DQVBfRlMx
R1A7DQo+ICsgICAgfSBlbHNlIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+ICAgICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0K
PiAgICAgICB9DQo+DQo+IEBAIC00NzM3LDYgKzQ3NDIsMTEgQEAgc3RhdGljIGJvb2wgdnRkX2Rl
Y2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAg
ICB9DQo+ICAgICAgIH0NCj4NCj4gKyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGUgJiYgcy0+c2Nh
bGFibGVfbW9kZXJuKSB7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkxlZ2FjeSBtb2Rl
OiBub3Qgc3VwcG9ydCB4LWZsdHM9b24iKTsNClRoZSBlcnJvciBtZXNzYWdlIHNob3VsZCBiZSAi
eC1mbHRzPW9uIG5vdCBzdXBwb3J0ZWQgaW4gbGVnYWN5IG1vZGUiIG9yIA0KZXZlbiAieC1mbHRz
IGlzIG9ubHkgYXZhaWxhYmxlIGluIHNjYWxhYmxlIG1vZGUiIGFzIHRoZXJlIGlzIG5vIEZMVCBp
biANCmxlZ2FjeSBtb2RlDQo+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICB9DQo+ICsN
Cj4gICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4gJiYgcy0+YXdfYml0cyAhPSBWVERfSE9T
VF9BV18zOUJJVCAmJg0KPiAgICAgICAgICAgcy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJ
VCkgew0KPiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXMgbW9kZTogc3VwcG9ydGVkIHZh
bHVlcyBmb3IgYXctYml0cyBhcmU6ICVkLCAlZCIsDQo+IC0tDQo+IDIuMzQuMQ0KPg0K

