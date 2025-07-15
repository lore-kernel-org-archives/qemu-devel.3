Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B0CC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYuq-0005K5-DN; Tue, 15 Jul 2025 02:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubYtW-0004K2-Bf
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:12:07 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ubYtS-0003ap-DK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1752559918; x=1784095918;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3ZJnUDOmDqV87wRnu2gWaUaHXHA5f53gNjkzhcXGasI=;
 b=WC/0EghMq8vBOVu/153i7sKMBqDG8hTlp7v0wYeqDa0gd9mrFZ34BQyc
 8YnxnAlpHfBbX5PZAeZX7Dcvh9WzDAjvHFRE3L8HMr0bA40rREwExchVp
 lSTp5eJ04uVm/lBy6YRBfzUlt1DEu8wko8GjZ7FLjppHACrOwu0KFbCs9
 GjoAcDpn+ERdyTmXaSNyrJcQEGGIkN9iE9VlB8t5tptQvNxAqGX8qdDXx
 wX5n9dcy3ONTBeRXVT3r6nBZ6NIG29VB5J2evpZvWeu9SwHFQEgzgjciU
 SP2PUXOLekO6Z/0HUiyjUIc/44ScVQue/gr27QZ59cPyutKJPnPMXdsjZ Q==;
X-CSE-ConnectionGUID: zAMIo/ORRIWHbDw7ZF4Aqg==
X-CSE-MsgGUID: NzIkuJMNTDSOBgbADI5NzA==
X-IronPort-AV: E=Sophos;i="6.16,313,1744063200"; d="scan'208";a="40339369"
X-MGA-submission: =?us-ascii?q?MDF1g+kXum+HPk+o86xb/EcU96uOoLmE15K83E?=
 =?us-ascii?q?CbHKKol6OxeeS62VL1X4o6J1nY3C+nQE9mLe7cP8Bj+0jMtUj24ICSeY?=
 =?us-ascii?q?Krt8mVMOXSiEEnNNiDSRcL0k01fEgsU9I//tmPrDBDxwcou6PIhyyQX2?=
 =?us-ascii?q?HE8Jr9k2zR+T+T05Ucuu/kZw=3D=3D?=
Received: from mail-westeuropeazon11010058.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.58])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Jul 2025 08:11:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQPjZ3HvcqWZ+O1KYDpr8pajHNIxRK21X3DVWhkZPkrJM9+YmDqNPS2c+bYNuAjCYz7HF8Tf1WOKdVXwbFyMBCge3unu6fFnzwWBk3ryte1xfrUgCLiUzrLA9poWHN11EC2ELy3VhQ+ng8E5RMV6J0G3fm9IKIDvank8Rz8K6YVNPo373SWIwyMj0jIJed1Nn6ySBTQsRVF0XoURO6EXux6qHRD4sFpuhtUcTwwp+TfKs7VgHnXqL7i2K9THJppTFtZYFFksjdYDFbWEhScxe7xxGgBIqxDR0Is2PAjvNZu/BDVE9KoRhBKrvYSEE54cI7gqOBJsvWwhyXMhsAa5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZJnUDOmDqV87wRnu2gWaUaHXHA5f53gNjkzhcXGasI=;
 b=QXy9LaWlARsBHB/OyUpcHgN4oSB4t9riRdf6edDlxctW4kvmWI8Lkj2tFORaF9PpeqJH40PqPUADsrJ4wZTlaT3a/1cpz3Avx+YBDcJpsGhaukKAN0UgiuZ2WGw45cKlTa/9xWtysaqG80yXAMxFmQP6nDyQys0YxzGDhYb3FSbXHchO7DW1ixJm8YkgdoE6m2mUHDXyt+Ojbr0cTGBsERnWdJ75qs9Ofish82EQmmodyO6bfywZz99WrjCuXBXcuGiUq/HAaJz8Bi75GEMYmaW969kpB/tn+BOcJ19fKimxdxE5ak+941VOT9MtqfODyA0NhPqvuF2n9K6KcmVtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZJnUDOmDqV87wRnu2gWaUaHXHA5f53gNjkzhcXGasI=;
 b=g05Isz6hXB3QonAlFvD0wwace1pisf/LvYxcmSE3uhy09XH+6z2LC+V1wv7L/GXcywk2LLDDob+7yb0i0iGZHsBePM+LcIIZBsD+xcw8eCEx+QsHm3EWwQXDAkbVKAP64rpGtgcSp//KWzTCCNTLyvLrztG7HVR6+SmKELxr++bIifIiD/zCkGCoL1mv82vlYwSj+utP6bFf3rqd6kqFwgmSjir5BtRzg5Ic0UqdmMKSRbep7Rnf5i6+HcfVR7QQsPBA9pdKGr40J/kawL/uXQsYduWUMamb41ZQQ3Q/s//6q20how0KlJ95D8GMMkHZzfXGAlRgNlcclyYNQL2JFA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7832.eurprd07.prod.outlook.com (2603:10a6:20b:353::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 06:11:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 06:11:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Konstantin Belousov <kib@kib.kiev.ua>, David Woodhouse
 <dwmw2@infradead.org>
CC: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 "jhb@freebsd.org"
 <jhb@freebsd.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Topic: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Index: AQHb9JVtonfMGrKluUCpVZOjgLqK0LQxrd+AgAAlOQCAAE5sgIAAk+0A
Date: Tue, 15 Jul 2025 06:11:51 +0000
Message-ID: <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
In-Reply-To: <aHV0-wDJImAjRPPp@kib.kiev.ua>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7832:EE_
x-ms-office365-filtering-correlation-id: dbf93689-eb47-43f4-0947-08ddc3667d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QmVzUjJmTkJFcERTdDZTUmFud1Y5U3d4R0ZGOHRWSWVCWVdSc3BTNXZZRWww?=
 =?utf-8?B?TWc5VFdxTWRudERXOXNnYk9IZzBKeHA2czM5MSs0S3pkSFArcDZBY2pwd2Qv?=
 =?utf-8?B?MlBUM0NEVXk5WVIyRFErU09UYm55bVJPbURSRnI2MGpjYnVRcmdhdjFSYzQ0?=
 =?utf-8?B?ZGZ0OWVkWXBqcHRCWEhLMlNRVUFkdHdPL3hDU1VRcXpRSUtocG5CWGVuNEhO?=
 =?utf-8?B?bjVSOG8rK1hHMHBMTDkwUGtQMXhrVlNCVGhtTkpBcTZocW9jT25mOWgzUHdl?=
 =?utf-8?B?QmFZL2RZaWR6UVRKcE0rVXVpM0NhdTRmcm5WeG9zODZuY3VRWWllYUdLdDRo?=
 =?utf-8?B?c05wNE9BdnAyUHZFMlp2aHN2RFNjRStrZW1BNWJXQU5SdEZmSnNSRlRaQmhP?=
 =?utf-8?B?ZmU5eWM5Q2VlSzRLVHo4cHhUV3pTSG42TEJrRUtzd2pucFRoa2J6S05oVU9G?=
 =?utf-8?B?Qk9kREl3L3ZzOEY3bGJ1aTJkUWJoQ3M5dVljekZuSkZtOE9HSDJORVVsWURu?=
 =?utf-8?B?L1lnTFpSMnBwU0hQUWxHeENoTEx2bDNzUlptRjJjcFFjMWI4TTdiY05zR0pU?=
 =?utf-8?B?b3B1MmFuaXJxTmVyS0Z6K3JxSVZlMmNEZ2Mzbk9FSWIyOWdzekZqSWNGZ08w?=
 =?utf-8?B?Vzd3NnFYRWc3NDArMEtoSjVFQ2pVSXBzSkxMTEVtUnFtR1RSbDUyTXFoSklm?=
 =?utf-8?B?Zi9pUjlQQ3g3YVZlZzZNWHMvNmNwTGszRWFmOHhNTjZuZmxmTU9oMlJMdHBY?=
 =?utf-8?B?UmV4amtwWnl6dnRSRlg1WGdnUUIrRWxIQ0hDcFhLNmJGNlFPZGNGMXQyQ1R3?=
 =?utf-8?B?UStPTXEvTENkZ3Q2Sk9qVkFWNEJYZmV0U1FkaDlPemFBRGsvQzR4Z3BJOGJk?=
 =?utf-8?B?MUZTQlhRYU1IcDZJYkpCZjZuR3oxYk1ud3U0K2hZaE1oOXNzWW96Tm54NnAx?=
 =?utf-8?B?S1JaTzBBVGl6V05kUUk0bWQ5ZG9OdVhnaTRINnN3bFp3T2VmT0hlTnNFTXhw?=
 =?utf-8?B?cnltdHREV0ZSYWZpSVdnQWFPemNWTko1WjdRYmV4M3dIeGF4OStUU1RxZWJp?=
 =?utf-8?B?SkJDaUovM2E1VGNQL3VlVlRsVXpMMms3dlkrWUhIZ3RQQTg4VC8yYlI2UjI5?=
 =?utf-8?B?VXJ2OWVpMXJ1SjNEZTVaQ3JYMlBRWmRoTnZuei9ySGh3NEhDd0hzZU5wNlFP?=
 =?utf-8?B?aEJYUDVvMWw2dVdmSGQ2M01QSlZjaVZaT1ZQY1pZeFJ6K2p5WGErMVltMi9N?=
 =?utf-8?B?aG1wb3dJNzE1aldFT3p4UDJyeUVvbS9NNGRHdGpYSmVYVFRVbDdzSkl5bXJT?=
 =?utf-8?B?RDFWVmUyUDdvR3BLQzNIdXM1dGFPTkFudlFrREZ5aGUyWVBZTE9NdHJNNnM1?=
 =?utf-8?B?NGtCaXJMNEdTdWI0V1pHa3l2QVFZZWV2d2l2b1RiRVVxRmxhb3ZXTEtoamg1?=
 =?utf-8?B?aTJKbkpJcS9tbFk0bmNxSzVSTzN5WHJuQzF6Vkd5K0JPcitUU0hySS8zSHNK?=
 =?utf-8?B?UVkvdm5NNXBoQk1WSGlZd1Y4aFBaQjRnNFA0U1RnYUltWXhBS1ZLMFBHY0U5?=
 =?utf-8?B?SitsVStHZWFsdHhxRUdKV2s0ZXAyaVY2Z3VCOXdlSnRnL0xwWUdoaityS1Js?=
 =?utf-8?B?QU5FTXVSUEJYeUVwZUNLcVdzbXRBMFM2WXdEOUN3enVrcENrdnc5aml0VTRV?=
 =?utf-8?B?V2dBZkhWRks3dE1ZTUZwRm5ibnNNR0V0VFZ6czZPekRyZnEyNnRReUR0ZXpt?=
 =?utf-8?B?OHVqY2pQeGdra204RGt3em1MS2VzYUpRcElIQUxON0hwOFlpTlFhZkJqaUJ2?=
 =?utf-8?B?WW00azB4a3Y3dmZsdHoraWNvb25SL3N5cFE1M2VxdE9Wa0F6di9ZUVZIcVYv?=
 =?utf-8?B?UDREWFptWFdJQzU1WjdOa1ZKalBmTW9qOEJqcjZiS3pIdEp0MWJoT1V0bEdG?=
 =?utf-8?B?ODVWN3B0N0xLWWgwamtSbnlMYjdGanRzRklaZjBIaS9kRVd0eGdJai91VGxt?=
 =?utf-8?B?RFo0OEc3Sk9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzlNM20wNStDTWsvSHdsOWlPTlEraTlFRE9IMklJWlI2SThLUm5ZU2hlUHVZ?=
 =?utf-8?B?TVdEaDNuRDdWS3pBQUVTMnU4cXdMdGRPeWI4UWpoUmtrelBxRzUyWXlCN2d0?=
 =?utf-8?B?YkgwWGhXc1BsWmV3NzZkejdyTnNpb1VJNnEvSWpVNXFVd3pSVEV3QkZUQjBM?=
 =?utf-8?B?V2h2RWwzeWFQWWNyZEZjMUxOWWppbyt3OGtMUE5ZL2VramR4eDhZa2l5eHQ1?=
 =?utf-8?B?MHM5Qm9saGx3SlRJZXJsSXpnM2pMSWRKWU1BSEJuR2RhTEI5UFVTZmdCOXgz?=
 =?utf-8?B?c21ndkU1YkFJVEVHNzkwRDllTHNMTFhvN2VlOTc1NVJ1S2hVSi82MjNjSUs1?=
 =?utf-8?B?dVBHUkNsRzlDVVF5Nlh6TlVtV3JXS1FWS0dNTmZWV0swSjNpcmUrSE1FQm5F?=
 =?utf-8?B?ZUJ5QzVrbjRsTmx5RjFYM0FWNnpyYStEUTN2TmFHaGNBQzJ3ckdxUHJ4czg3?=
 =?utf-8?B?ZFhqUjA1dzRBZU1IQWhFV3UyTmhFRjZIeFhnV3RJK0kxTlJJRmNDcHB3YWhj?=
 =?utf-8?B?MTJXMnVFMjdoZ1pvUWFHMldnZ3RDYXhXcjAzRlc2ckFoWWhzditMcFZ4cFlE?=
 =?utf-8?B?U21jU3EvMFZVVTJaeG53bXgrRmFjQWZJR2ZsYkZITWxxMWhUZkpzbE9weDNT?=
 =?utf-8?B?aGp5S1FtUWs4RVRRRm9VNWlrZVlEcnJ6MEpHVjFMUHkwdVNkcW1iN2pLUDFO?=
 =?utf-8?B?WEExakZSYXNMeWZscFZkNER5S2g4QWtTcEYyVVc4QmphN29nTVk0b2VORUpw?=
 =?utf-8?B?cnYyKzdkSDRxS0IvNVhSRWphZzROTXFPUTY3MW11Y2dVTHk4YldiSHQxUGly?=
 =?utf-8?B?cGpsb1BaSEFWS0JNSU9KcHIyV0REV0J3MTNwOVdVVjNVQTl3emkvSjhiS3pv?=
 =?utf-8?B?Rnl2bTV6STlUaTBNVk5XNklXSTBZYnN0aDBoU1hmYmx0ZEMzYnpUU285dVBi?=
 =?utf-8?B?SFUrOThtQnFnSEJNMDRwZC9ML1NiZXJTckR5OSsyMTFKZE52RmJ6SSswZ1R5?=
 =?utf-8?B?RWNTTjdFbTIrMmtjK0FSVGg5Yk01RkdYNEpvREdQT1I4aGttWTBoTzROZGZF?=
 =?utf-8?B?UVNNTVd6RjZvWG9kT291c2VFOXlVQzF4TVJBbjdiRDdvWGlEYmxsTFVnMkNv?=
 =?utf-8?B?bWlPcUFzejNXa0xuZlhoUTZZZTM1dWlWb1pXSXphdlBBQ2pPdWQ1bjU2VFFQ?=
 =?utf-8?B?L0ZObUJVZnRXMGRMb2lLYnRib0xuemJ2c2lCdC9vL1RmL0pnY1ZkdjZ3dzgx?=
 =?utf-8?B?L3J2djQzOHJCcVlYK2lJOXNGeVliVGZBYW9UalZUaDhhRjl2U2tDZVViSXU3?=
 =?utf-8?B?RlpjY2JiZWxKd0ZIVi9MTndpNGJoTnJVa3U1NGRydWQ2OVJPaWIxZFg4d1Vi?=
 =?utf-8?B?b1NDU2p6QjNOeU1rQXBZSXJxSXBIWFlyeUNtbE9iN1dMTU5aVnJyUEFGV3c3?=
 =?utf-8?B?OTA3dUkzQ2ZaUWV6c0w5aFpPd3RjNmRBS0FQL2lkUktZNDlGclp1N3FvZTVN?=
 =?utf-8?B?M0QxaFliQVRIZFdtWnVhYklnMmlyRmFwb2xGV1d1TzdEaExvdWFBRSs2U2Rl?=
 =?utf-8?B?aDBnVnBuZko3SmRLcEIrNWttV1ZLU2FnN2RHcDlXaFBhVnZxOXN4MkV1bjlY?=
 =?utf-8?B?RENETGh6K0V1WUM2U0NyT1AyQUx2d2JzZDJVVjNFUUsrQVFlVm9xYllkNkR0?=
 =?utf-8?B?VitoNzNUOUNldWhnNmxFU3c3RDRTOTIxSHN2TVhxL05oajlEaDNuZEZncWpq?=
 =?utf-8?B?VmthUm80cUljTDRVUlBGcHRXWlBjdVJrNnA4MG40MHhCd1BHdGxUcm83S2tt?=
 =?utf-8?B?aHlBb3ZJcXVYMkRzMEtvSS9keHh2U283blQ0SElEK0E4NHJjQ1JBbSt0dHRR?=
 =?utf-8?B?ZCtPRENqNXUyRVZhMHpWdHIyZ0plTFVKeWhoaXg4WDRCelZTY0RlcnhOVWtK?=
 =?utf-8?B?d1k1azMxdG16UFNYKzNkNnFZNis0TUtxaW5ETzNhOEFlSjRyejBQSHRKTXR1?=
 =?utf-8?B?b09DeGIrbFZEaU85ZUpTeXc1R2x3YkR0ZFora3o4UXZPYmp1N3paRmRpSVdY?=
 =?utf-8?B?QkdjeDVMd01ITzA3RkZjdi8ySUNwdWtwWW5abHBORnl6WHVST1IxRVgzVGx2?=
 =?utf-8?B?R2VLTVB6TkhQalZOb0dwRXUwZzc5bk9LZ2NEcTFtUkR2YkdSYjY4NUhUVmdq?=
 =?utf-8?Q?OHcEdPbw9keo838qDJ3RX+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43572BE1A2B8954ABE79A56F6E7588C1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf93689-eb47-43f4-0947-08ddc3667d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:11:51.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7CH/WB/BRxnLiS2kW0Ww0U7+Z3kzpKz8oCk2TunFtAXey82mZZA2rEoMfmrXyIkjddjeLhWogY7VZcLMf3FVjrpBkJfa6H8pYWhxRC4TPqQT8Yc6xrAlhIaJE75h4Gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7832
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

DQoNCk9uIDE0LzA3LzIwMjUgMTE6MjIgcG0sIEtvbnN0YW50aW4gQmVsb3Vzb3Ygd3JvdGU6DQo+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBNb24sIEp1bCAxNCwg
MjAyNSBhdCAwNTo0MToyMlBNICswMTAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+PiBPbiAx
NCBKdWx5IDIwMjUgMTU6Mjg6MDkgR01UKzAxOjAwLCBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNv
bT4gd3JvdGU6DQo+Pj4gSGkgRGF2aWQsDQo+Pj4NCj4+PiBPbiAyMDI1LzcvMTQgMTY6MDAsIERh
dmlkIFdvb2Rob3VzZSB3cm90ZToNCj4+Pj4gRnJvbTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFt
YXpvbi5jby51az4NCj4+Pj4NCj4+Pj4gRnJlZUJTRCBkb2VzIGJvdGgsIGFuZCB0aGlzIGFwcGVh
cnMgdG8gYmUgcGVyZmVjdGx5IHZhbGlkLiBUaGUgVlQtZA0KPj4+PiBzcGVjIGV2ZW4gdGFsa3Mg
YWJvdXQgdGhlIG9yZGVyaW5nICh0aGUgc3RhdHVzIHdyaXRlIHNob3VsZCBiZSBkb25lDQo+Pj4+
IGZpcnN0LCB1bnN1cnByaXNpbmdseSkuDQoNCkFyZSB5b3UgdGFsa2luZyBhYm91dCB0aGUgb3Jk
ZXJpbmcgY29uc3RyYWludCBtZW50aW9uZWQgaW4gYnVsbGV0IA0KIlBhZ2UtcmVxdWVzdCBEcmFp
biAoUEQpIj8NCg0KPj4+DQo+Pj4gaW50ZXJlc3RpbmcuIEhhdmUgeW91IHRyaWVkIHNldHRpbmcg
Ym90aCBmbGFncyBvbiBiYXJlbWV0YWwgYW5kIHRoZSBodw0KPj4+IGdpdmVzIHlvdSBib3RoIHRo
ZSBzdGF0dXMgY29kZSBhbmQgYW4gaW50ZXJydXB0Pw0KPj4NCj4+IEkgc2VlIG5vIHJlYXNvbiB3
aHkgaXQgc2hvdWxkbid0LiBUaGUgc3BlYyAowqc2LjUuMi44KSBnaXZlcyBubyB0aGF0IHRoZSBJ
RiBhbmQgU1cgYml0cyBzaG91bGQgYmUgbXV0dWFsbHkgZXhjbHVzaXZlIGFuZCBldmVuIHRhbGtz
IGFib3V0IG9yZGVyaW5nOg0KPj4NCj4+IFNlY3Rpb24gNi41LjIuMTEgZGVzY3JpYmVzIHF1ZXVl
ZCBpbnZhbGlkYXRpb24gb3JkZXJpbmcgY29uc2lkZXJhdGlvbnMuIEhhcmR3YXJlIGNvbXBsZXRl
cyBhbg0KPj4gaW52YWxpZGF0aW9uIHdhaXQgY29tbWFuZCBhcyBmb2xsb3dzOg0KPj4g4oCiIElm
IGEgc3RhdHVzIHdyaXRlIGlzIHNwZWNpZmllZCBpbiB0aGUgd2FpdCBkZXNjcmlwdG9yIChTVz0x
KSwgaGFyZHdhcmUgcGVyZm9ybXMgYSBjb2hlcmVudCB3cml0ZSBvZg0KPj4gdGhlIHN0YXR1cyBk
YXRhIHRvIHRoZSBzdGF0dXMgYWRkcmVzcy4NCj4+IOKAoiBJZiBhbiBpbnRlcnJ1cHQgaXMgcmVx
dWVzdGVkIGluIHRoZSB3YWl0IGRlc2NyaXB0b3IgKElGPTEpLCBoYXJkd2FyZSBzZXRzIHRoZSBJ
V0MgZmllbGQgaW4gdGhlDQo+PiBJbnZhbGlkYXRpb24gQ29tcGxldGlvbiBTdGF0dXMgUmVnaXN0
ZXIuIEFuIGludmFsaWRhdGlvbiBjb21wbGV0aW9uIGludGVycnVwdCBtYXkgYmUgZ2VuZXJhdGVk
IGFzDQo+PiBkZXNjcmliZWQgaW4gdGhlIGZvbGxvd2luZyBzZWN0aW9uDQo+Pg0KPiANCj4gWWVz
LCBhbmQgdGhlIEZyZWVCU0QgRE1BUiBjb2RlIHVzZXMgdGhhdCwgYW5kIHJlbGllcyBvbiB0aGF0
LCBhcyB3YXMNCj4gbWVudGlvbmVkIGVhcmxpZXIgaW4gdGhlIG1haWwgdGhyZWFkLg0KPiANCj4+
DQo+Pg0KPj4+IEkgdGhpbmsgdGhpcyAiaWYgYnJhbmNoIiBjYW4gYmUgbW92ZWQganVzdCBhZnRl
ciB0aGUgaW52X2Rlc2Mgbm9uLXplcm8NCj4+PiByZXNlcnZlZCBiaXQgY2hlY2tpbmcuIEhlbmNl
IHlvdSBkb24ndCBuZWVkIGEgcmV0IGF0IGFsbC4gOikNCj4+DQo+PiBXZSB3YW50IHRvIHJldHVy
biBmYWxzZSBpZiB0aGUgbWVtb3J5IHdyaXRlIGZhaWxzLCBhbmQgdGhlIGludGVycnVwdCBoYXMg
dG8gaGFwcGVuIGFmdGVyd2FyZHMuDQoNClBlciBzcGVjOiAiSGFyZHdhcmUgYmVoYXZpb3IgaXMg
dW5kZWZpbmVkIGlmIHRoZSBTdGF0dXMgQWRkcmVzcyANCnNwZWNpZmllZCBpcyBub3QgYW4gYWRk
cmVzcyByb3V0ZS1hYmxlIHRvIG1lbW9yeSINCg0KRG8gd2Ugd2FudCB0byB0cmlnZ2VyIHRoZSBp
bnRlcnJ1cHQgZXZlbiB3aGVuIHRoZSBETUEgZmFpbHM/DQoNCj4+DQo+Pj4gYnR3LiBJJ20NCj4+
PiBhbHNvIGFza2luZyBpZiBWVC1kIHNwZWMgYWxsb3dzIGl0IG9yIG5vdC4gU28gbGV0J3Mgd2Fp
dCBmb3IgYSB3aGlsZS4uDQoNClRoYW5rcyBZaQ0KDQo+Pg0KPj4gT2suDQo+Pg0KPj4NCg==

