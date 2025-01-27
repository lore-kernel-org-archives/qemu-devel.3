Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428DC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 06:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcIRf-00051I-VQ; Mon, 27 Jan 2025 01:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tcIRe-00050x-C5; Mon, 27 Jan 2025 01:18:02 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tcIRc-00018c-JZ; Mon, 27 Jan 2025 01:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737958681; x=1769494681;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZaqRxevQJn6kjwHXQU8NJ2avfOfbYzKHDBFBtpKsA4M=;
 b=SKyWK3LQO5Ay5t6ArVOGweP7uKCBChgZAk5UkP+Bq5/iWud2jXwArYcu
 Snxc6sY3NH77b4Ho4L9Zzz/AFz2dhAT0dJ+4XNr2jHLWyA3PLD58IHdk5
 YDQSN99u6GICPeCPf4cNFSPobpxiYDOrv1rKrX+ThVjT7/vikMAUm2ECn
 vxlJTDVIGI99n6KLRKphz49UjBDjk6KeqIYBOzKnHU2u+70ECH4k0JxWF
 qLrXNZzN+juTMa3+4J2PvH/39eJNr1B/L/UvxHEci5jf9S+/f9Huy4Afl
 /C7he0fB7Gb7T9sIVctPmy8Jbni0Nq9D4SdjAgLc2iMp5Zodm7eHNsdJu A==;
X-CSE-ConnectionGUID: aRcu72d3QMC5kwcFpZWyvQ==
X-CSE-MsgGUID: xravemF/R8maJeZB3sAdHQ==
X-IronPort-AV: E=Sophos;i="6.13,237,1732575600"; d="scan'208";a="29554417"
X-MGA-submission: =?us-ascii?q?MDGVbc5IGL8kXlSmMjHF56OdhIAHaoQuM2Rnoe?=
 =?us-ascii?q?nWySzj3zH8xWb3z4acH2lNOBmlGCWrPzge+6SKYfkDgeJqeamHDZlGCc?=
 =?us-ascii?q?3yppnJajj07pboFX2wHN0UOx7xrrj+C6/XxS1QJJkbMd2PsSUoyLCLYm?=
 =?us-ascii?q?1nK6VgX/NEefgBq5YVDlOA2Q=3D=3D?=
Received: from mail-northeuropeazlp17012024.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([40.93.64.24])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Jan 2025 07:17:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2sXv4FS62U6p6QLfZRvzEL5nBksSjkzqvgTol2S2mi0HluIzVIPi8+ZWowuziJN+Ut3CVboxAytBh18kat2lG8hDOI2dqxy30RacrIy9oLdxq+eRl5afrUY/cI6+NdOPS2B/QjOgKmgkrzdQ7tWMK7YfJpxGh/qMgeq+6daEXT3xM/6PL1JFsE1+JvjHc7RZjhPQisAHp87G5vjG4PSuhxP3LaH91W3r+cq7C6mqvB9gYIzxorUOIrwvXL4xpajfsQ8GdkMOhEsX6xBXH7jcWessqi/9YdOn3rzIvLywIGzOIjTliVnqpDehTBTX7qm0TPTmX4BQkgdQQOhygl/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaqRxevQJn6kjwHXQU8NJ2avfOfbYzKHDBFBtpKsA4M=;
 b=vyDd0eoLB5X2TIdYX3v7T/UfxJZZ7j8x3OUw1VVENNPLkRhp+DZHZHQTxT/LCcTUrYPq1G76oku3c9XmTmJzf5lzOJueT/dC3z0J9gn+C512pf8P9C61amz24SGTgrXQt9z7k3FPNc2I7WwEHKWrNxY5EgSABRQjnz1y4WD7ybB2kviFREQiWEfiyrv3Rb0tCEYBWDXo/CX0KFZibaPKdjEGB9kH94t4Gka+Sp3eoMaDCFQrPOy4YN+fBUBpeGw9/e0AwoOtcapU4eC1sxH5G+NWexaJVy3A1JD4WocnyFKVIq2k0KrsIGZx5FBX08SwZsFCDQzqZJxJ1LTgr293zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaqRxevQJn6kjwHXQU8NJ2avfOfbYzKHDBFBtpKsA4M=;
 b=ceXm8TrrjLh6DzOy3Spw8/dlpdrtGOnUlHnJKbpMYox7E49zmIiGkONuVlU0SvP0/atQICrx+u3v5+kYKvCkGImoViXWyjbub6X/byltD2ziFwgeSGRUT7vgxxmyv4FZ9MLE3KBL9N1x1QTWa5/Ysil7s5UQGTm6J/dijetVzaHG7/LeJSe8rD7mhAy5BhNchr+xYUl203DOx5rnHBaanAUtJU2FWKyfmtEuSIx0YoQOAsRvbqV5b0BSAZ83zckJh49E0Tq5I42V8CxxsZEzDPFfrtevwyx7s4hJ1w9VhsCFr5wi+xJDg5plBKyu9SA0nXzrX7CpRliZqPxz0nzNUg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB8792.eurprd07.prod.outlook.com (2603:10a6:102:266::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 06:17:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 06:17:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Anthony PERARD
 <anthony@xenproject.org>, Gustavo Romero <gustavo.romero@linaro.org>, Jason
 Wang <jasowang@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, Richard Henderson
 <richard.henderson@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul@xen.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: Re: [PATCH 5/9] hw/display: Have RAMFB device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Thread-Topic: [PATCH 5/9] hw/display: Have RAMFB device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Thread-Index: AQHbb1TxLwglWhJ1hUajUJgEguIvWLMqJ6iA
Date: Mon, 27 Jan 2025 06:17:55 +0000
Message-ID: <69adade0-1f55-4d20-b3e0-ee1647f7d513@eviden.com>
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-6-philmd@linaro.org>
In-Reply-To: <20250125181343.59151-6-philmd@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB8792:EE_
x-ms-office365-filtering-correlation-id: f9d54eae-06bd-4a64-f8a1-08dd3e9a5663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T09kOXNTOTJMMy9SVStmdkc2VTBXTENYcU1jSXhCYjFyaVNwRkNxQithRlAr?=
 =?utf-8?B?VmZjUWtENmFDckJvbVNScGxmMVExTlh4ay80Vi9GTlN5MlU4VFpFOXlzMFpW?=
 =?utf-8?B?aHZmSW5KTlRKME5DSFR0Y0VRRkV0VTNhV3VIeGZDSTVnNFE2eGg0RmMreDRK?=
 =?utf-8?B?TXdiNm5OdnhSWWREQit6anlFK1k4Z1d0dFFaN0xmVWppZGd6ZzZQeVBKRVJn?=
 =?utf-8?B?b2hCUzl4dU1sWEI1cUxCQ3ZnQVZSTmx6ZklDekFzbTFYVjF6eHdqbitvMWZq?=
 =?utf-8?B?ZnhZR1Z3NnVJWm94TGsrayt1VnFUYzdzYWZ1blZjMFRseXBkRmhSbXBJNHIw?=
 =?utf-8?B?ZzJmaktLY2EydDVCd1pCaGp1RFAvWGQyUmEvdkp6MVZDSThFT0FsMWFyUXNY?=
 =?utf-8?B?aXJNMld2RWoxT0o3MnhKcm1INFNoOHlYQnMyRU9aTVFQRVhYYUxoVk5Idm81?=
 =?utf-8?B?eG1zcjFTRURDNUdPZGZJMnBwSG0wY2xZaVZvV0ZwNnFUOE5EWjFMdTdJZjdL?=
 =?utf-8?B?T1l5S1YrWG1uZnJxbHJ2Zi83clJGVlFKMkVseDR3bmhQQWdGRDVsb3A4Y0Ev?=
 =?utf-8?B?S0Jpb3ozTVczMXU0SVBDQ0RGaVllRmdZcWkvTCthbE1PZnVXaHdBT1NpaEtw?=
 =?utf-8?B?SFBJZmFKTXBUK0MydzRtSmx2SHZLTTFnc1B3Q0xHN0dQTGIzL1JCQnlXdHMx?=
 =?utf-8?B?WFI2QnV4Z0UrcklsYUh5WklBNU5DSnJoSUxZSFZOcmczK1JXUlk2eFJ0RkZl?=
 =?utf-8?B?Tmw3akpqYmhkZnAvQkJrS3I5RkRBcWI2cmgzRVRuSk9BMVByYk4xYTVhUzRK?=
 =?utf-8?B?d3hDclBVSndJMlFEcU8xdjEwOG1pUU5YaGNpbktja0lxR0x3UWtjRTZKMTNl?=
 =?utf-8?B?Mnpla3lheHJwdVdFTzBzNzhDb1JCNFVITy9aTkZNYVNacS9JUEM0QnZBb1RD?=
 =?utf-8?B?WGE0VkhWNXpBOUp6QTM0NmNxVlMzd0lTWldVNGdwOUR2WFBvaGJFNUN2M2lK?=
 =?utf-8?B?YVVNR1FCQlVseUFTSWJEb3d4NmYyYlEzWGorN1UvcEx4S0Z5ZVdoRFNtazBt?=
 =?utf-8?B?dk1OckJPQUFBZ1o1ZXBzTm8xWUpTaEZseFBQZzlneXYyeU1jODY2eTVOdzBB?=
 =?utf-8?B?aExrV1Y0QzdjK25RbDNXOS9FdXhCOXRja00xMmhPYXFBUXhmR2hBNTJWbk0v?=
 =?utf-8?B?VHR0NU0rV2FrdklqalVMRlI4dDhNdlN1bWVzMGlPS3A2S2RKYXJZZ05aSzFk?=
 =?utf-8?B?b3B3ZWZVdnZjamdnTTBIUUFVLzR1R1lZNGw0dmdCb1I4ZGthMkYrcURyMzNw?=
 =?utf-8?B?ays4cURpRnppSTJrZUYrQ1kySWhFQlQyM2UveUJESlJORERkM3ZWb2pCQ1I3?=
 =?utf-8?B?a1FPWGUxNVFZZ2NCN2ZCT091VFRUMWFLd3lRQnNUMy92VWJ0Yi9ZYmtKUFVU?=
 =?utf-8?B?d1FpTmpjTWFTNjhsV3hsbU9kSkFKLzFYWDlYTHVHSEpPT081MDBiWW9PTHky?=
 =?utf-8?B?RXdrb3hCeXZtdVVWdDMydjF6QkMyUllWMVkwYm9hZzJhd1NWV1Nsa3ZlYk93?=
 =?utf-8?B?bjhQbUsrazZNVjBoL0puK2g4VnFTTXNCSU9VbDRERGhaNnBHajZqOFNCN1k2?=
 =?utf-8?B?SktFamhkRU05dW1kUC9Hb3ZYZnhEaTJ2dzRHSXpHdkk0a0ZIUU85dkc5MGlU?=
 =?utf-8?B?K01Tckd2YzBHRDBzMkxvZHRtYW43NlUyL2dKSEhvbkUreVZaRU9MK1RjSjZF?=
 =?utf-8?B?OHF3bjMzQnp3UTYrQms1ejJ1eEJJZzdoM05qTCtFZXViOWs4QjhzMDhUeW5K?=
 =?utf-8?B?c3czejFiQUZ5bm1ZVmxxKzJiRTBZeUtPbGhuclJWRmNqY0NHN0dNM1NaUmVG?=
 =?utf-8?B?SVJTRVVwNXdGSDd0MnYwcWpVc2lUeGNIODliYWVaNjNLZmI1MXZkR0U0QnJs?=
 =?utf-8?Q?TTUxRBy+zaVd0PkRMfUc1eWTY0Xz9UPQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Z3Rm50N3FsOTkxVDZUaHJmTlE0dE51L0UxdThYbVdMV1NPall2NEJmT1lJ?=
 =?utf-8?B?WmI1NEZ6Qlp6cjloWmZTSGRvOW1DYU9EZUNYaWViSU9wZEF5enU1dFFRbWJX?=
 =?utf-8?B?c0VxWTVBNkZiVjMwZzc1S1pCVEZqQWlsRk85YkRwZnFyQnpGS1lHeVdWNkQz?=
 =?utf-8?B?TUVNWWo4Wm1YWHhPdzRMN1RMNFhtRjV6V0dIcWtIL2VWRXkybTcvZmFpZHZP?=
 =?utf-8?B?QzhRTnFMcHB1MnRnbEt1MXRZbTI1RFFwZ2JLVDRWOW4zS2s0MSt2M2FxTUNY?=
 =?utf-8?B?T2JlalFGYWU3ODVsdkRndVBXbnZXYjZic3M4ZkRFT25UUm9rb1BaNm5CS095?=
 =?utf-8?B?dG9XR0JxRlkzL3F4MXY4OVBVL0hWVnFLUUhwaEEvbXpwSUU3bVVySWpjSVhp?=
 =?utf-8?B?ZWZiVWV1ZmZGclI3SVFlM3VONXlBYkNnNElXanVpQlErRTdobjEzL1FlMHRr?=
 =?utf-8?B?ZzJlb2FwV21UMU00eldHUThHbkV2MTRGUUhzVU94OGM4b1Q5amlpbDBVUDJM?=
 =?utf-8?B?TnV6S0xIR0ZXNUw1MS9QbG1SRFNROElIU2Uvb3FRMFdXcTdjdGZkZExxM2x6?=
 =?utf-8?B?Nkx5UGhDenYyK3d5QjY2VWM1aWs0dnNIT2M5RWxVZDZtcGU0MWVBWkdZOHZl?=
 =?utf-8?B?RjFmTkdXMkRMMllDUUY5SWVmZlBMY0N1TlI0R0RLc0QvL0hQbzVRNjIvRExP?=
 =?utf-8?B?enpSUURpTXdveXNtdSswVnJFYUlBV0grVTFIY2F0M3JpRDVZdjJSKzVKblAx?=
 =?utf-8?B?QldNRnAvWUFnQ3FEL0x3REI3YVBnWUhEamFmNU5RQzJRRzVaRFJUWmpzNVBt?=
 =?utf-8?B?elhPN0RyazdxbnQrckFiTHhNUXJsdkJJVnlwejUwbnFEdzUwSnFOazc5VTZm?=
 =?utf-8?B?bWUrcWVMYWFsdWNqY3REcDA5YXN1K29TSWdJVUNpeElGYXoweE5pUy9CRUQr?=
 =?utf-8?B?anE2VEt2Z0lTakJYa0c0MFZPV0FTZDZyZDhJbVNxK1pyaWRMNGZvcUh3Q1lQ?=
 =?utf-8?B?OEJodWg1c1I0SUQ3c09NWHhyRnVlUjFtYVpCNElrRUVNQ0Z4M0lzYW5GeVkw?=
 =?utf-8?B?OENpYjNMOEtHSWpNTDV4bnI5ZEgwMEhKQ2JwNHpNZE5VcUNLQnZMcGVDai9m?=
 =?utf-8?B?WUxUeWQ3Z3VPYlgrby9XNWZqUVFGazN5OXErbWpnVGxJQXJwOWNFYWt0Kzd0?=
 =?utf-8?B?UlRIcGFocWNIUi9EaW5rLzF1NGdLNEh6TXRPbHR2RVh3QkZKUzhoTDlHVXFs?=
 =?utf-8?B?Q2d4cHNrR1o2RWcyRHVrcVJBekVqWDNkUmtJcmFwUjlDWWp1M01pc3NRK0V1?=
 =?utf-8?B?WENiM0VxV1A5M3NIUkkydHVsbmxVTzVIMTN0ZWlyT1F2U1E0b2JOeFE1WE1T?=
 =?utf-8?B?ekY5bHFlK0tDMk9rVDBQUHdrbFZtRFhhalMyeldIVG5QSWhsWGhMUTdhZW9t?=
 =?utf-8?B?NDI4MGE3TmxIWks5SGRHeFkrb2ZEK1ZNVG5HUUdPSnlJemUwWml5U2ZDNks5?=
 =?utf-8?B?ekJZUFRyZThxc0F0TmdjY1Vjc3I1QXlsNzR1THBtVVVPRlArY01ybnJ0TWxw?=
 =?utf-8?B?MjA1UWVrc1NHcm5CcWRGSG9NQjZwbFZDSTNIYk1sZ0FzdDM3V3hiT0tGa0hP?=
 =?utf-8?B?NmlXRSswVy9xMTVQOUtqU0dkbStEd0JhWjgwU0JWd0hnYWRZSGY5U2VDVStK?=
 =?utf-8?B?QXVQQUNxc2hmWXoyMnBpZ3Irc2wwYlh3M0w0bm9lSkM3d0h3U0FGa3B6MFk1?=
 =?utf-8?B?UUV3aUU4VTQ5L3U5MWdGQllWc3lpcGVIdzBneFJBVk1BamhmZTNUK092NUdT?=
 =?utf-8?B?elV3aUdYblJVK0g4cSt0Q2lFUjIzZzVwSXpqcFl1bEo3VHZ6QmNNSWJJbm5W?=
 =?utf-8?B?d1BvTm5SeFUvTENjdkZzVG0vWm9tOUdNT2ovUkIrUGdTOHVpYUwyUWJZTDJw?=
 =?utf-8?B?bEsrNGp5VWt1UzV4NWJiQkVPMG8yRE9PeG5hTDVpWWpFaERuRlNqSkVvS0Iz?=
 =?utf-8?B?cXkrKzdycUdWQm1RMzZJVHNmQXpVbW5jY1dmeFd6RFh0ZHNuTzVEV3JSZGVv?=
 =?utf-8?B?d2xtU1JYclpoVDBmejBEOE9iQVcyc1lQZ0ZaMHZMV0pPUkFwWGpKWmpidmdC?=
 =?utf-8?B?SHUvRVVHeEFnME1rQnk4RllMUFg5MjhiVnZ2SzUvSi9MaXFJUGJ6M2V4djFS?=
 =?utf-8?Q?sPKESlwi/4QL0Mk4f8S16HM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <958E267CCF822D4092CC9924836844F9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d54eae-06bd-4a64-f8a1-08dd3e9a5663
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 06:17:55.1524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/P/KrmLfqbd/5yRN/+LyxsqRywbvM/euRg8QeqVVLBwYGgZ2yngnNsEKwtWeuU4qEKcxOMBjh+v/i8qbBgst/5zLxyWJZxEGlr8Rp5pmN1sVOhqieEnpAzb/9KacmLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8792
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
QGV2aWRlbi5jb20+DQoNCg0KDQoNCk9uIDI1LzAxLzIwMjUgMTk6MTMsIFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4g
YXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+
IEJlY2F1c2UgdGhlIFJBTSBGQiBkZXZpY2UgY2FuIGJlIG9wdGlvbmFsbHkgcGx1Z2dlZCBvbiB0
aGUNCj4gVFlQRV9QTEFURk9STV9CVVNfREVWSUNFLCBoYXZlIGl0IGluaGVyaXQgVFlQRV9EWU5B
TUlDX1NZU19CVVNfREVWSUNFLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L2Rpc3BsYXkvcmFtZmIt
c3RhbmRhbG9uZS5jIHwgMyArLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9kaXNwbGF5L3JhbWZiLXN0YW5k
YWxvbmUuYyBiL2h3L2Rpc3BsYXkvcmFtZmItc3RhbmRhbG9uZS5jDQo+IGluZGV4IDZjMzUwMjg5
NjVkLi4xYmUxMDZiNTdmMiAxMDA2NDQNCj4gLS0tIGEvaHcvZGlzcGxheS9yYW1mYi1zdGFuZGFs
b25lLmMNCj4gKysrIGIvaHcvZGlzcGxheS9yYW1mYi1zdGFuZGFsb25lLmMNCj4gQEAgLTcyLDEz
ICs3MiwxMiBAQCBzdGF0aWMgdm9pZCByYW1mYl9jbGFzc19pbml0Zm4oT2JqZWN0Q2xhc3MgKmts
YXNzLCB2b2lkICpkYXRhKQ0KPiAgICAgICBkYy0+dm1zZCA9ICZyYW1mYl9kZXZfdm1zdGF0ZTsN
Cj4gICAgICAgZGMtPnJlYWxpemUgPSByYW1mYl9yZWFsaXplZm47DQo+ICAgICAgIGRjLT5kZXNj
ID0gInJhbSBmcmFtZWJ1ZmZlciBzdGFuZGFsb25lIGRldmljZSI7DQo+IC0gICAgZGMtPnVzZXJf
Y3JlYXRhYmxlID0gdHJ1ZTsNCj4gICAgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgcmFt
ZmJfcHJvcGVydGllcyk7DQo+ICAgfQ0KPg0KPiAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyByYW1m
Yl9pbmZvID0gew0KPiAgICAgICAubmFtZSAgICAgICAgICA9IFRZUEVfUkFNRkJfREVWSUNFLA0K
PiAtICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9TWVNfQlVTX0RFVklDRSwNCj4gKyAgICAucGFy
ZW50ICAgICAgICA9IFRZUEVfRFlOQU1JQ19TWVNfQlVTX0RFVklDRSwNCj4gICAgICAgLmluc3Rh
bmNlX3NpemUgPSBzaXplb2YoUkFNRkJTdGFuZGFsb25lU3RhdGUpLA0KPiAgICAgICAuY2xhc3Nf
aW5pdCAgICA9IHJhbWZiX2NsYXNzX2luaXRmbiwNCj4gICB9Ow0KPiAtLQ0KPiAyLjQ3LjENCj4N
Cg==

