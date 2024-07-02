Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AABCC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRf-00081b-QS; Tue, 02 Jul 2024 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRe-00080W-IO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:50 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRS-0006UB-Vj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899559; x=1751435559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z/2aj7kxHmZQngqgXS2PutUg5PHcoFHQ+gDj2SWJzVI=;
 b=g3IY6RjBzW6p7cC9pg1Il0PzfARZQX0nhFTNwKljI2tg0tYMBhPYZGvL
 GrjeljdAoscPs5s3q1AYLZqOREYJYzq59hGT96wCyEb4latDSURpVADG8
 OXaGyuq+VjgVqfUxkgl2SU/dSvzCP8LsBSxbTQ/2KXr1bAm/upTGlvqWC
 5JfiX0HYLmDuZwlV5tyBeOBKVJ33F+GI4EBtVLidCx5Ifd3rZicPUn3Fg
 MCYBA2sgAk6432y+0vNk5L3BXf5PD3zhOei4bDJrUhrGHVHB+PRFe/MSy
 mAJzY7bVy6WHC1vev9lSfvyq6vlFrdOLa3e4hY9BFkKxcrF9enSHfNaNx Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721512"
X-MGA-submission: =?us-ascii?q?MDEa/3R0jqSTVNu+oNnuIQyu4JL0tmnsW+0eYx?=
 =?us-ascii?q?A9LvvrHprt57e98mK9WuMor8PFqDBYmW02aqFrzIZUJSQxMB/6BHO7l5?=
 =?us-ascii?q?406K863MfLe8O/WvBGyJLnkPxEwfnIeIfxkCFl2BKdY4lHs0cAv9r6PW?=
 =?us-ascii?q?41BnwH5QIjRO3LV88sWYvZ6A=3D=3D?=
Received: from mail-am6eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:33 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lITTMH1pKVLI93ihmUugU3xH0XuNs+RUIwPL21ELBJx/cjY5lN7Zo2y/4rscntciWxK3rKX5lXiPsMrK3/pJgT+xxNAuDW8NOzZQE90RUy6r9+a1nmV9xdxMEyQBtOX0JDkVNtkM7K859mvxsJltTqJ18oDZYrwr1xnwGELP0F0B8ySaY/H6fRIhSQKNeTPFAPpWuOEQ3n38uwvXQqlM2QOhyBnFOZIUkwrWJQE4+BPasyh0yGMdKukwxkHb4TL+mUDqsvhkQcIzsavNg9HSzM7xCT5+pR1m5wlckJEYieXi6i6Uex08nLm8C5zxzedRxFPC+7OtSZrskGrjg8U5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/2aj7kxHmZQngqgXS2PutUg5PHcoFHQ+gDj2SWJzVI=;
 b=ibLdZJsGVu4WGc6a2PWvy65oYOG50ylJcCruVtLqcYwGltrTuHQsLAUhrLuw7m/6prp+lHPZQ02gvmmTjW257mezaIrQrFsFo4F3CCQmk9qcD3mjZj4tD1kA/J8jZa9++KVN6z/f+i1it51kYy/8uLIIwkwxZjw7Org13Wmk3xPPCm4oQLqPT8IaOfMOmu7cajLvdmKABYRxr13apzkTmMwbGHpnzVj5HhUgag2My4Vi/TOwluvBpHbvi2KB1fh0HVj/L5Lh47KamWv62R2qTNoasHgM3RRMPKqc9lwKSeMR0ROO6uUs8TaJ2t8mNI55BN1B2w76d5+47phVvzamgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/2aj7kxHmZQngqgXS2PutUg5PHcoFHQ+gDj2SWJzVI=;
 b=kzWM7HLZRnIMf+guXcVg93+1UlX+UsSxrRsAixLxh5oSs4bxRFB/kIkL6qxgBCdDhzzKZol9fvHzmvGdoy2mh6rXHT59FqEKZqUDgmwagxFXXNx2ADr2fAuN1SAWSwjYtF0v/+cJPolCADwswv1bpYBAePQixgOCuo0XvYVOJQxBMAtp0CLu5nnLremycxttcsrNFvQSCaaLOaHt+Q1kZ7mfobmxhEI1bUAbZjxRLr+6cAgRmbGF/0z6FOfXROXhEfNq06GAAcCvAGsoo0aWK9wsB94aJ4ixeXrV+Pu0LpouYl2RInGhDLojYyy3KryaLH/Iv7SFWhCroOOMliQPfA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:32 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:32 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 02/22] intel_iommu: make types match
Thread-Topic: [PATCH ats_vtd v5 02/22] intel_iommu: make types match
Thread-Index: AQHazEQH6yt3QFkvykGEU3nY0I4A8A==
Date: Tue, 2 Jul 2024 05:52:32 +0000
Message-ID: <20240702055221.1337035-3-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 010aa57e-4704-4f45-6ecc-08dc9a5b2a77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGdna1Ywa2NKVEYyRTIydU5QL0dxTFdCTXJFbnZiODJ2VUQrZlo0bDBoeVNT?=
 =?utf-8?B?RFFzUk16Wlg0bldzbG9xWldvL3lPQy9RZjRMV2M3VkZBNWwwRFEzd3ByMHRV?=
 =?utf-8?B?RVR6YndzU0Mrc3lxazRTNmErRjNWd2VXaXFFUmRUVmk0QW5WbmRwVWpLMU1J?=
 =?utf-8?B?MVNUNE8yQWRZNWZZSmlYdjEwUmhuOHJwdEJpWTY2bjlzSm1JaXpGZG43L1Z0?=
 =?utf-8?B?V1R6SHZaT1kyNjdQSHEvYTRMSVYyS09tV1F4YTdBM2VpUjZGaGdWVTA0Z2Ex?=
 =?utf-8?B?ZVUzM2tVbDJyK0c3NGJHcjNITEx6bmhoVi9ySmVKSVRJYlJ1QzVNU1ExS1hG?=
 =?utf-8?B?NmljeWtFMWZzaUZFWGtHcDJiak4xNnRsNDdxcGZPMXlRTjM5MlgyNkVGa1Ja?=
 =?utf-8?B?djdLQjhCYmN5SmRSSnVaVnZCMEZVQWZ4RVB1dTJGRHE2OVhWTGRRZEpMNW9o?=
 =?utf-8?B?UmIxdnlEYTBXL09DM0lpNHN6TEkrYmhMcXpGeFdnejNSalhMQkxFOHpqVWJX?=
 =?utf-8?B?czVoRGtFeXZZcXZPbHczUU9wSkszYkFEbklMbnFOSDBaUFFiZ2x4K2dzektV?=
 =?utf-8?B?cnViRURVNzFsUmlOMThyb1pxc29FVStzZlU4d3QrZk9ldWhwOFZGbTBzQ2lQ?=
 =?utf-8?B?d0lmWU4xRnU3ODN1M0NrTmF0eFZDZ01IQmVsNU5kTmRQNEsxY1JTYm5EdXlh?=
 =?utf-8?B?YjgrYm1EcEoxUzQ1UUdHN3YvZ0hUTHdvNCtFc2JSNlRuSXZRdUdaMUloeGlh?=
 =?utf-8?B?NnprTDgxN0N0eTVBQzhNZXhPeWtqVjRjY2ZFR2dVSDJtNTJ4KzN6OHlOTTdD?=
 =?utf-8?B?Tit1WmNpbUM0azFQVitOOWNybnBUdlV2NVlYUWtBWDRZaVVBcHBob3IxSHlL?=
 =?utf-8?B?NTJUalFTWU5nN2ErTmQ0UnBRVUYwNXF5N29uN0VvUU5CQjN5U0xuMnJkRTNp?=
 =?utf-8?B?Wk1QLzAybWJXdDlHMmxoTkZua3lqY2tYaTUyaW9zL0h4QXErUGluaEdmVDht?=
 =?utf-8?B?UVdpaG5zeTlhUjBwb3VNejFEeVVkaTFVUTdsMHJyQkdsU0Z1Z0JJSkVkTVF4?=
 =?utf-8?B?OHhHQWF1U21KZ0cyUzE4M2JwcXBKdlpUMCtmWGM0SWl5a045TmtZN2RYcjJN?=
 =?utf-8?B?NHdqSHhCRWpKd0JYaUFpWGwrcXRDTlR0Rjc4dWZhVHhUY2x6UjZRandyMW05?=
 =?utf-8?B?Y0ROU1NiU3IrQU9VeTBrMEVaN0k1bkozd3h3U0ZGTEdpSE1uVHVVL1VpQzAx?=
 =?utf-8?B?YVJMZHRTTHo2V1Z1MXJ0SHRsRm5ha0NZUklJenFtM0hIeUtzRnhiRDhrTkNF?=
 =?utf-8?B?L1YrVkQ3VHRBVzQ4MUViTUZyZUU2T3lLY3ZIZm9rZGlUWGdtWHh5TS9wb1E3?=
 =?utf-8?B?djFtRFIrbmd1TStwd2ZvUWdCck1BblllNmhuRFhIWGlKNWVvWVcxTlhFNllk?=
 =?utf-8?B?NzByMkJ0V2RxcHRMdjF0bk1mWlhhc0JYV24yVThqYUhMa0hMcXYyMzIxSHI1?=
 =?utf-8?B?dVpkbkRJYXM2ZmxlMHM4bUZrMHFCRnNsenl0SlIrc0RCQllTNEdtTnMreVBa?=
 =?utf-8?B?R1A4WDBuOW1hS3N1dk5tZFpNTmVoU21KNlBsVWVoZjhDZjVHR0ZsUnNxVDZv?=
 =?utf-8?B?QWNHTHFiSUNvRDNVWjk3UFR6SzZqTHlyZGJ4bXJ1cE5TOEVTbFMxVmZwM29n?=
 =?utf-8?B?YjczNXdHaUZuYVVWQkJUZmJ6QUpLQyt1Y1BmS2tISE05dXdmSW5aWm53Mmxk?=
 =?utf-8?B?djdHSDlwNzMvQXY2MDBWOFVjVXdSNEMrTFBFUnRUU0ZNYU02NCtxREkzV1FH?=
 =?utf-8?B?RGdWK3VZTmhtUkpXYktuMG9pSTdNcEtNMmFwTzIwaW42WW5FU0EvZ0dIL1Yz?=
 =?utf-8?B?S1BGcHZlY3RRbXFndGlFMjFXc3pCc0M5SEliMUZsUVppaXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpmVEF3bXd0SUdveDRuTkVSUHJIdFhlVnkwWDh0Vm15MmU3dXdFV2RhL0R0?=
 =?utf-8?B?SHNIMzNTZnJubEQ1b0dhUGFQY1JScEJaaUtIRHhJSCtlWUVBbFJaNFkwV1Va?=
 =?utf-8?B?YjZLQkRGZVBYK1FCd1hQajRKMnQySys0VGpoN01BNk1LeXV0bHdCTnRXOUNs?=
 =?utf-8?B?ckhMZ1VDSHMyS3pwRW4xRmVVdXVyVEVnVDVqUDJzOWVacFA2ZEljOXd4alpz?=
 =?utf-8?B?d0hEb08wWmxqQm1KV2RicVlqNEFlNFJkWXdrenh3eGxNcTVaQ0h1elhkTTF3?=
 =?utf-8?B?UEhOL25zS09kdWFERUFUM1BZN0JieGNXT0ZEZU1NWEY3UXdGRnFyVzVxZmNF?=
 =?utf-8?B?MVZFUFNNbzJQUjRKWC9nWVlUd0hubnNaZk9sTlVybFRXR3JicVp0bkt2VzBl?=
 =?utf-8?B?VllKN2p5RGFCMmJYYjZ1UGRiQWk0WnV5Zk1vZnljaDQrb3pVNW9xUTZEZm5F?=
 =?utf-8?B?SUV0OUo5WGk5VWhxR1UwQkVPdWJndmpOVmM4TnZPdWZqQVAvUzJCeEtxdzRz?=
 =?utf-8?B?TE5Ra2N2VDRvT1dWb1ZETnJZbGhSNWtPNmMvME9QaEkxR1NYTGxpanh6ZzV0?=
 =?utf-8?B?VkFjS1VhZWhMMDl0dllsNTdSSmlQQ2tsSVlSWnQxK28zUE5DL2dpQm1HUDdT?=
 =?utf-8?B?QzNMUVFwaEJBcHVHVDBubXBmdEdENnl1QklJMjZ5VHVtRGRJNFdZazJNdWJl?=
 =?utf-8?B?NW9YRlJxZnErUFpEOEY5K054UmdhS0hKbEZGa3c3NTJRK3YreUxaaCtxSU96?=
 =?utf-8?B?TWZUUjhpd1BWN0xZTVAwdGFtSmdmN1dLTlV4SCtTcjF2d3VxWEM2Y2Q4d1RK?=
 =?utf-8?B?WjBKSnJTalArcStzaFQ3NVBuNFNmd3ZYdXF2SkhhVGVYL08yN1lISXlFVzZN?=
 =?utf-8?B?eElQcjBvOEJ4b2FWdXJ0QURyMnZ4dHBEeVNRUU56ZGpJdE5EaHg1TERpVFdI?=
 =?utf-8?B?VG1BblIybEdDZk84eS9lMmE2djlCQ1ozL2loMXFlVytIK3B1WCswTFF2cXBM?=
 =?utf-8?B?ZVl0bitOVGszTUU3M08xZVRQVWM1UGt1V1VwSCtqQ2I4TGdZa0NiS2F6L016?=
 =?utf-8?B?RkZVMnFDakdERFJJTi96bjVieCtrQmNiNW42UU1heVJOVHZMYi9ISDdZS1Nq?=
 =?utf-8?B?ZndsV3k3NkRkMUpaUE05ZTVHSnB5NXZqOG9yRGJEYTE4WXpTZW1MN0U3Z1Fi?=
 =?utf-8?B?dks0ZkdtcTIvZmlnSUV3RFd4aHBYTkNvVUVpWHFsU3lyZTdLdjNKNEJKT1JN?=
 =?utf-8?B?ZUZiZnVFSUtsNGZRdlB3SjhUaGZJMTFOYlp1enQxa3BhbHFaalc4VU5VZENU?=
 =?utf-8?B?emQ0VUtDOURkdW95OGYxY0ZaVGMyNXNheGdNY2xiQkVHZXZHcXplb0ZsU3kx?=
 =?utf-8?B?OUNTS09tOW04cWoxcW84NnprL044cjk5SkhCODhBWWR6cU93MTducmJwSlpI?=
 =?utf-8?B?bjdCQzJlYkpxZmIwL1FmZGdUVTJXZGppM0x0VVhmaDhGUy9wTWRWVGpQREZ4?=
 =?utf-8?B?MGVUZmlsWWFuU2IwL0tXOEZlSzNYdzU5aHQ3b2FpdjdQbVdkVEJ2a2RYbjdw?=
 =?utf-8?B?dE1JNW5HQzNxN1poQ3dtOVlDMXczR3l3Z3kxQU42MlB3UVI0eUc2ZGUyNVow?=
 =?utf-8?B?dGJETUVqdHVMcmtYdStYTGdsTXhaM29HamJjVDF1OG5SeEttN05aWGFEQ3cr?=
 =?utf-8?B?dUFZNUtZUjY2V0ZMV25Tb3ozUmhXL1Z6RUMzMmNsMGFqeDR5Zkh1TlNsWVZB?=
 =?utf-8?B?WUhlZWwzUHFiWG9yVmRBL2w0dUx6Q0pvR3JoNURWM0F4NU1ESkFMWHN2VFd0?=
 =?utf-8?B?OFkrNTFSdDAycTRMNUEyZnViUk1LbEl6TGtGalVrK2pzN3grNVZ5ZzRuZHJr?=
 =?utf-8?B?MnFrM0pEUm52cEJnalVkUmhhTFhmQndPQmxJSk5nN3RmQmw3eDRvc3NKSzRq?=
 =?utf-8?B?M1MvYVBpTldOeC9TMHl6bnIra29HRkVUR2VOQmxGT0RscGFLd0EwSWtHNDNM?=
 =?utf-8?B?TmkveGQvZzAwS0ZxWTZZVjVvcFFQellGNlhmaWF2UVlYZVhIcHZ6MEhwNWcw?=
 =?utf-8?B?dlM5TWhrZGtReUVhNUZvZ1BYaXlxU3FkMEJDWGdnQWhkUGF0TVZicnNCeEph?=
 =?utf-8?B?VkQrakRJVmRXNncybEdORkxpbjZvQTFLbHJFaU03TUd6QksvMlhwaUdyb2cw?=
 =?utf-8?Q?m80lBHhKzv/qVOovqKHZqrs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <923168C4B590A64787C729A3E86744AD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010aa57e-4704-4f45-6ecc-08dc9a5b2a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:32.4620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoLbBv8h16nLbnIQ/a8QDrOK4AvcGBJIp7Qf3Aj+xKEl0alQaA0FzRGc/lwi2nsQrjvRj/HlIPsyUifQoqHsMEJ0vCd6oQfcNC+9go20XE5VtV7J7n0zrrestirUbAX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSAnbGV2ZWwnIGZpZWxkIGluIHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWdu
ZWQgaW50ZWdlci4NCldlIGRvbid0IG5lZWQgdG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0
ZF9sb29rdXBfaW90bGIuDQoNClZURElPVExCUGFnZUludkluZm8ubWFzayBpcyB1c2VkIGluIGJp
bmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVu
dCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0K
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIgKy0NCiBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGMzYzBlY2NhNzEuLmM2NDc0YWU3MzUgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KQEAgLTQxNyw3ICs0MTcsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeSAqdnRkX2xvb2t1cF9p
b3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCiB7DQogICAgIHN0
cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7DQotICAg
IGludCBsZXZlbDsNCisgICAgdW5zaWduZWQgbGV2ZWw7DQogDQogICAgIGZvciAobGV2ZWwgPSBW
VERfUFRfTEVWRUw7IGxldmVsIDwgVlREX1BNTDRfTEVWRUw7IGxldmVsKyspIHsNCiAgICAgICAg
IGtleS5nZm4gPSB2dGRfZ2V0X2lvdGxiX2dmbihhZGRyLCBsZXZlbCk7DQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQppbmRleCBiMTlmMTRlZjYzLi5iZDIwNzQ2MzE4IDEwMDY0NA0KLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCkBAIC01MDYsNyArNTA2LDcgQEAgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gew0K
ICAgICB1aW50MTZfdCBkb21haW5faWQ7DQogICAgIHVpbnQzMl90IHBhc2lkOw0KICAgICB1aW50
NjRfdCBhZGRyOw0KLSAgICB1aW50OF90IG1hc2s7DQorICAgIHVpbnQ2NF90IG1hc2s7DQogfTsN
CiB0eXBlZGVmIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUludkluZm87
DQogDQotLSANCjIuNDUuMg==

