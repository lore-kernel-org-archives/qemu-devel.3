Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5C1CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbiUN-0003b9-PK; Mon, 22 Jun 2026 13:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wbiUL-0003ai-UV; Mon, 22 Jun 2026 13:31:13 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wbiUJ-0003Mu-Ck; Mon, 22 Jun 2026 13:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1782149471; x=1813685471;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ak/JiYsj3HCNPbHBUxkA1mBbhO7TFlAZUETNW9veTXI=;
 b=o9RUQr8tovPwQKBvlje3Fr/aKbNjHk6H6qRC2EiPK+OWNyNBWjSgiGR+
 qMuoRW7pRmKhdT35sDaGA3fzvtsGV3psBZHxSMrjR27N8bTZBv72xNnRE
 wuykmIOG7ZQpKoFRYWkf/EmXmNJXZcRbpyFC+9TIerjLblgqEFtfhHnxm
 /YeK8BiRPnlcvHI7dQ5E2bIZjQ7Ce9XpN+4v8/+zVTin1tZi6KtArQA13
 PGzhsywiHoVJHS9pbm8WvQi4Dg/4BGrnd0jb/5PIh35wEoqq46l5iE9yo
 H9H6a2ZXelkrcuCanWRsIw4RF72bQ74Wb27ja3n87q2Y520uyEVCzokLu g==;
X-CSE-ConnectionGUID: IM/gpvljQ6+fix4CGgTcmg==
X-CSE-MsgGUID: jPY5aqgtRGeBmIzqH80u9w==
IronPort-SDR: 6a397159_fIcAuYHvmB/TXjP2Px2mkxCupQsh7xIo9V0kEIpcxSUFqQG
 KXPRqw9m0hXOZ9IIHfU658KDEfVJNAJp7zuZKBQ==
X-IronPort-AV: E=Sophos;i="6.24,219,1774306800"; d="scan'208";a="48273816"
X-MGA-submission: =?us-ascii?q?MDFDmfTu6hwWBFiCbVnLA2XjdQqTmvADy6qHWX?=
 =?us-ascii?q?Q4xMvxZ95MJXbKWdN8swO4VDmpq2T7ailiNvSxwOP4b3Ba2JOcO6hLM2?=
 =?us-ascii?q?pn/p/1d/IgH6jbgwRTLgJW7pyonFsDshF3CthEsGvE/Y8/ktfcfVAd5o?=
 =?us-ascii?q?VcYHSqPhXWRfiMxXvRU5CYUw=3D=3D?=
Received: from mail-francesouthazon11011016.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.16])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 22 Jun 2026 19:31:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnTNFveVkheZU0ISSzwgOUrqOuFv3tEJnpijcnye96WuBG/2h+19YjLpC2AiUSzNRwgU2J6n70TOrcFvpeIslSPl6uIUmMzLD+HKro7+9YqQ1egcCj9Z2A5M2DHgebM9C/9QTwlE4tQQrNzhPNpsfzxTzjuuLMexD3vzIJWCB/CRU0bqyLA/W5D4t4QxP5OEcvWzgnUdM5CfBgbwOgjEEHedbZnmUxCnGGOI3ioVQWyfazE/koaDQl7j2m68+/uRiiMRuC/z7jepvpxoUNz7lNeNG/yGzzvpt3gz5BLhg09WBJ7AH3ELQAs1uxmD/UAOgy6RfD5nKzxr/2dDsylBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak/JiYsj3HCNPbHBUxkA1mBbhO7TFlAZUETNW9veTXI=;
 b=V7Ke8dbZSFTPAf+PCeXIyvtob6CuytIXImoJJBMWa3jvoGiQry0K2ZkCoa3bDAvbugxOeOCDqe/7zQC89CGTraLb5xLteKLr6Qe33jNsgx3njzmvUSo1uUFU9YgANf8+/+9RjrXD/mmrTN2nn1lg3QUhUDtUhSP3oAQn4a8Y9HZ7kqc2+X/T63YxECZ2vdhvESz5/F0FkfGDsMdpM1AbY9oTBycF6JqYjw0/p+cyvuf8WO8dFt1HgqsOQIvaW5tmBcafXfUuebS/NkJnfVq0do9lh+vQkOaJIQZ2+A9v6/G1XsYSVVNS4CmD20VRbZcHvV1wTrptU9tpJLH/vdG0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS1PR07MB8456.eurprd07.prod.outlook.com (2603:10a6:20b:4dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 17:31:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:31:01 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: no92 <leo@managarm.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Topic: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Thread-Index: AQHdAmNwkAevjAAd6025+Uh17c2vRbZK1QKA
Date: Mon, 22 Jun 2026 17:31:01 +0000
Message-ID: <0b93c0b06c39f7dc6faa7ab21f57034081df83dd.camel@bull.com>
References: <20260622162138.1045170-1-leo@managarm.org>
In-Reply-To: <20260622162138.1045170-1-leo@managarm.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS1PR07MB8456:EE_
x-ms-office365-filtering-correlation-id: ba543d3f-96f0-4f76-e103-08ded08407df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: vcfESOEL9D//wSkGPowz5uLaMzuan5H5mH7i7AdUjrRln9mu6+qceF9q8vIXTgH0il/LnHa3gczaQ/ih6Oi2hgmAVv5D1W1YLwPEZd5zhSoBZs1yujjB/J0eyCx6IxMz14/NVOzKd+g9tl/eKHwzpIAQ5DxvoXCgfus264Tuk3nxXEcK1mn8orIsQLu2mqhCJUkZTWR/NY7YlQe32oyS2on/AltJvMFV+vhAE1dpjTy7emuqU2KOev2jIPV/2/H/1KZd1dEnM5559p5/PLzCjTSwzJ9tFMabJVKZh4VmGvwfXagwtAgA8vih/YvssKKGmTtfLvwobeMrXaDHGqAKp08syKppUC4Q+IkZbBnwHTU1q5dNv+zI3bSHIarhbh3jF57IKK9oKJ8UMPnGc8cuyvrXDrRQ5k5khwdw6sw/sSzjnQZAIycPySO5RqBOT1DzFiCCxI33wioHguhoJroleBfTj1S1E43MYe5hGaEeufCAol96SG+ZJ50ppk0Chd7riY08e/tHFR6TXGO36uKJ5XvYU9WVgc72INfEg7cn89rc48klvvdF1oWWjPddWQ6ze91nZyosV5YZoF26fsJAZu8bdnwfLUmFEfB6k2jjQqoe16qS9g77AQpB5oFmJGbpWssMeCFzvDEMfRejeud3YZLUcvXatuewW03FlGuWJME=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtDbDNPY0E4RWtPdTZtWnBwZWhDVDN3MUtodnFMVGR3bG1ER2szTHRtaUtt?=
 =?utf-8?B?YnVSbi9pbUVHdmNFNjhnVlJJNTgvVS9Nc25qYkRjMkVWSEZFOHVPRXBsMm9V?=
 =?utf-8?B?V1htQjRGTXBxb3padnExNnpNZVRsbkh6SHV4MXBPbDJpNWRkNHBXTksvSita?=
 =?utf-8?B?Sko5OU5tLzNjSzhkLzIzK3ZmM3d6NktUMkVoUDRoZG54dHBxOHlyMjB1ZmJM?=
 =?utf-8?B?REcrMFhNRXVJa0hOSnRXbVBBV0oxcVlmRy8yNm1CdC9GREVGTzVHR2gydlZP?=
 =?utf-8?B?VHZIQzBuU0pkS1FzZUxPelRpN2poclZlYkYrNldwdmhZQlFscnFKV1lEaW53?=
 =?utf-8?B?aDAyRGVGM2Y3N0pkbzVmclNxZVFZOHE4bXBlWEdIcFF2bUh6aGk5dnorMUFL?=
 =?utf-8?B?VkJBNlZpS3g2YllSRC9KVVJlYUtLVVdKVUdkbFJFVGhJTWFtTkZyTngvbE9q?=
 =?utf-8?B?b093Y09mTVY0NmhQSjd0ZURIZTFvUHRxZlJHUHVuczhlVUZtZXdkMmFnaSsz?=
 =?utf-8?B?bkxyZUN4ZXhkQ2h2eEpCelZ1bVlRL01EcWZFcUtZYko1WkZaL1RyZDd3U3lY?=
 =?utf-8?B?d2FVL1U2dUNrVHFhR2d0MWNwNk9UWTNPeFVyTzJtRHQvRG1kNU4rNVZKVzZH?=
 =?utf-8?B?WkhOZGVEODJJSnhuTFBENEZ6RE5TSld3SmxsSGI2K2c0U040Q0M0Y1FBS1dX?=
 =?utf-8?B?MU5LZXIvMk5NMnRXcW0wVTdyTWg4M0tFbVY5dzBBYXcra0ZtSkdFeVQyTkN6?=
 =?utf-8?B?MGZhQmtlZ3lSZitOM2JQc3NZd1BnSFltYlR1S0RLdEhNTk5neHhzZURsQnhp?=
 =?utf-8?B?VlZkM095dVVXUXRoaThGTit3UHlxSEl3ekRyaFB6OHpYZkpSMFZKUjNHRDVH?=
 =?utf-8?B?Tm00eGl1VmJMY20vZG5DS1J2Y2VGdVRYUGNoT05RNjh1QXBSSmhUTkl2U2pw?=
 =?utf-8?B?aWMwanVPMDZoK2phc1NBTlBOVG50QzhZbEY5b2RxVUw4NGEvTHpvTzMwWDkw?=
 =?utf-8?B?aFRZYjdDSG9vR3IrbTIrSE5mZGRlQ2EyckE5bWRvUUxlTHVWanBpY1pvbHpz?=
 =?utf-8?B?V0NFNXVjY1ZxeXFMU0xGV29KUm0wKy9MTFBaU2c1RTNzM2FLS2xaV0JIMnp3?=
 =?utf-8?B?a2ZZNVJrcWVjUDFMTnJZRVlrdTA3Y0ZVckl5b0NuZW43MncwVzlzQWhuYlRI?=
 =?utf-8?B?UVdGNXFmc1NlTDF6MWYrcFNSMDhjQUZxaHhBeWZ1ZFJpWENtSHBneUJXc3hl?=
 =?utf-8?B?Vm5FekhzKzkwNUhoeS9uRFNpQ0cwa0ZJL216OXV2QnAvOXNQMDZxdzdJU29Y?=
 =?utf-8?B?RVB0cHNkN0dwOE5RSEJYYkZxSmk4dkhwRW9ENVhMNllCQlJOT3NtWVY1OXBl?=
 =?utf-8?B?aU1nbjY4Sk1KalpXWjRKbTBvc2o1VFpKOUFqaHA0SDQyY3FXaG5iUnZQZ293?=
 =?utf-8?B?ZHozK3NqYnFWWnpPcU1kNXpKcEpQRFg5bnEwNEUvZlVXZFlOVHVHbFUvU3Vu?=
 =?utf-8?B?TG1BOGswVU5jb3NaTzNxb01JMWJ2VG9vc3U3WnRhUlQvQUhtQ3U1ZmJiOEUv?=
 =?utf-8?B?NExqamZad3BZSVNvTEdJKzU5T1Vzdm1id21TOXVhandjRE9CZ3dwSmF6Ukps?=
 =?utf-8?B?UGIyQ1NCSEc4cXZHb3hjWnA2Zk10S0tNZG4zOVAxUDJwZ0pvMWJKYUJJdlly?=
 =?utf-8?B?NFNtNDBCUVZjY1lpb2twTE5IUVBtc3RpazRGdWk4OUFHcWkyZjU3ZE9kanpy?=
 =?utf-8?B?WVNCNjFiVGFHaTZXZUlha0k5dGk0aXYwVERXNzVWNFY0cTZBODBrVXExc1ZG?=
 =?utf-8?B?eFdPRlpkWW1xdVJ4NFNmN1lsQ0R4UlczKzRjR2RMWFJ6TldKRkxNMkJrZVNy?=
 =?utf-8?B?bGpaT2tmb1drVktRaWovcC80TjV3NWJHekJ3NVlQb0ZVQ001VFVyMzd1aVpz?=
 =?utf-8?B?ZmRRZXh4TzhBZ2NERzI3RjNpUjNvaVJPbVJQMjRRc0o2OFB5QzI4QzFvUXBP?=
 =?utf-8?B?emRRRE9qb29sWDQxNVN6cHk0M1N0ODQ3WGxlQlJxaUdCa0JUcUI1M3dXUHgw?=
 =?utf-8?B?UFFTeGFkdU5FQmM0NEEwS2c3Y1hRbUs4MUk0OGxOeDBLbFJsUkpBczlUanBi?=
 =?utf-8?B?U2hhMEY2UVdXa2xGUEZFQU5ubk9KaFBJdXhiK25GNDBKNVBCeFg2anlVTHpM?=
 =?utf-8?B?TjQ0NUduTGlBTG1mdHdEMGlhcGV6d0NoYlhNVDVNVlYyTjFkL2hXdUxDWWw2?=
 =?utf-8?B?Y1FNbEhmZEt5U1B6dllBQnRTOHcrekJvT0VKT2dmTisrN1UvbnRpT092R2RU?=
 =?utf-8?B?VHpTdVNUQVJIUnFtVGo0MHRSMS92Vy96Q2dYcDZsY2U2bzVsa0Z5YnZrcExG?=
 =?utf-8?Q?AjHvHg0pInURQqMJ0NL7Z3aHXBO5Y6PaSvm0T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D7B684EAD6FAB4E8ECFD14089C95DF5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QkC+QCROSyYtBmfvHxNLqqt30c1ULviCCszMhwYa3zfPVsMBOrE8C65qPIvnH38eSEtOg/T/Hp2eyJK3vBBsauAO2HhtOkf9MMFvmbADw+yRw7X5sJGp298vTYm0diYq2K7MZfxtmagCVWQNtXOUnnN1F3qnMmsNFrM9wLyIPfQOS/KL9cd0MblJmGTH7fX3JtFGPV4C7isrtpD3QbsrZf5bwwsY//XN76pt47fiKz7NogEg6hefJknBIw324JvATux7Z0vjqHRu4d0+cXhEVGyoFikc4HztvRRjYLn5/beCh+L9HTZVe/I9Uu83NrZC4J3oadO+2gW7zULuHJ7vZA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba543d3f-96f0-4f76-e103-08ded08407df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 17:31:01.9386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPDz2rp94XboyHPR3EVacvFGn1K82hK7Ngfh+ZZgjYE6yLaOecxAqzZVTIHL8Vrx4YoenscsnwAG4y20QJHIikVUHKyc+6w3Ep0K3nZCZ8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8456
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

SGksDQoNCkkgdGhpbmsgSSBoYXZlIHNlZW4gdGhpcyBwYXRjaCBhdCBsZWFzdCB0d2ljZSBpbiB0
aGUgbGlzdCBvLk8NCg0KSXQgc2VlbXMgaXQgaGFzIG5vdCBiZWVuIG1lcmdlZCBpbnRvIG1hc3Rl
ciB5ZXQgKEBNaWNoYWVsLCBkbyB5b3Ugd2FudCBtZSB0byBzZW5kIGEgcmViYXNlZCB2ZXJzaW9u
PykuDQoNCmh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9DQUZGRTJhdnJIREtaZDVtN2ozRTN4NT1G
PXB6bi0zYzl2ekdXUDMrOS1BVlB3UW5nN3dAbWFpbC5nbWFpbC5jb20vDQoNClRoYW5rcyBmb3Ig
dGhlIGVmZm9ydCB0aG91Z2ggOykgIA0KDQpjbWQNCg0KDQpPbiBNb24sIDIwMjYtMDYtMjIgYXQg
MTg6MjEgKzAyMDAsIG5vOTIgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBu
b3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29t
ZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2VzIGluIGM3YjJlMjJiZDk1NywgdGhlIGBwdGAgYml0
IHdhcyBzZXQgaW4gdGhlICh3cm9uZykgIA0KPiBjYXBhYmlsaXR5IHJlZ2lzdGVyLCBpbnN0ZWFk
IG9mIHRoZSAoY29ycmVjdCkgZXh0ZW5kZWQgY2FwYWJpbGl0eSAgDQo+IHJlZ2lzdGVyLg0KPiAN
Cj4gRml4ZXM6IGM3YjJlMjJiZDk1NzEwZTQwNGMzOTNlOWY1NjNjZmU3NDA0MjIwYzEgKCJody9p
Mzg2L3g4Ni1pb21tdTogUmVtb3ZlIFg4NklPTU1VU3RhdGU6OnB0X3N1cHBvcnRlZCBmaWVsZCIp
ICANCj4gU2lnbmVkLW9mZi1ieTogbm85MiA8W2xlb0BtYW5hZ2FybS5vcmddKG1haWx0bzpsZW9A
bWFuYWdhcm0ub3JnKT4gIA0KPiAtLS0gIA0KPiDCoGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDQg
KystLSAgDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMgIA0KPiBpbmRleCA3NDRjZGZkMmU2Li5kMWFmN2EzMTM1IDEwMDY0NCAgDQo+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyAgDQo+IEBAIC00OTg4LDcgKzQ5ODgsNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQo
SW50ZWxJT01NVVN0YXRlICpzKSAgDQo+IMKgeyAgDQo+IMKgwqDCoMKgIFg4NklPTU1VU3RhdGUg
Kng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7DQo+IA0KPiAtwqDCoMKgIHMtPmNhcCA9
IFZURF9DQVBfRlJPIHwgVlREX0NBUF9ORlIgfCBWVERfQ0FQX05EIHwgVlREX0VDQVBfUFQgfCAg
DQo+ICvCoMKgwqAgcy0+Y2FwID0gVlREX0NBUF9GUk8gfCBWVERfQ0FQX05GUiB8IFZURF9DQVBf
TkQgfCAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURF9DQVBfTUFNViB8IFZURF9D
QVBfUFNJIHwgVlREX0NBUF9TU0xQUyB8IFZURF9DQVBfRFJBSU4gfCAgDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFZURF9DQVBfRVNSVFBTIHwgVlREX0NBUF9NR0FXKHMtPmF3X2JpdHMp
OyAgDQo+IMKgwqDCoMKgIGlmICh4ODZfaW9tbXUtPmRtYV90cmFuc2xhdGlvbikgeyAgDQo+IEBA
IC00OTk5LDcgKzQ5OTksNyBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0
YXRlICpzKSAgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+
Y2FwIHw9IFZURF9DQVBfU0FHQVdfNDhiaXQ7ICANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0gIA0KPiDCoMKgwqDCoCB9ICANCj4gLcKgwqDCoCBzLT5lY2FwID0gVlREX0VDQVBfUUkgfCBW
VERfRUNBUF9JUk87ICANCj4gK8KgwqDCoCBzLT5lY2FwID0gVlREX0VDQVBfUUkgfCBWVERfRUNB
UF9JUk8gfCBWVERfRUNBUF9QVDsNCj4gDQo+IMKgwqDCoMKgIGlmICh4ODZfaW9tbXVfaXJfc3Vw
cG9ydGVkKHg4Nl9pb21tdSkpIHsgIA0KPiDCoMKgwqDCoMKgwqDCoMKgIHMtPmVjYXAgfD0gVlRE
X0VDQVBfSVIgfCBWVERfRUNBUF9NSE1WOyAgDQo+IC0tICANCj4gMi41NC4wDQo+IA==

