Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6FDEDF161
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 13:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtOu-0000fw-A7; Fri, 13 Feb 2026 08:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqtOq-0000ea-CP; Fri, 13 Feb 2026 08:40:00 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqtOo-0008Qm-J0; Fri, 13 Feb 2026 08:40:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFGMo67tPGllT9YC9AnFaXYuuU9CfOSJBTC5lSqhwxMF1oTYwlOswG6eomENvyVAjlNdgU6V5v7WR5q7Q6NiPsg7+APOA0N6IzN+HX9cJb9S6wjGu8s1TzoKt+isbPZLHVFDCGMo8EtmHHn46QOBb3MXj1utd7vqXELfO+K5Evq8sz9t5FrDT1YNXEwAMqtpgwtJ+J9M3JKzcYvCt/zApz1gjRnCkhWXsgPWMC3s35okiMK3UkTNPZPEsVItf9wg/QTDm9z4bvGo++qEEbgbMPC9FYR1obwEkBEN7U6F/TcWrP/gublPMHtAOJYlIxke1wBioIysUl7Nb8KKa0UfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPMsmAa+1ZDVBwVdEOJ7xYGKE7ICvXn7rn94eO4S8x0=;
 b=dGdgrJ+res86NNCZPGBuoyrlp6FvIPVhSc7cOiF5xO05oTwdRUF+yygCJzBYcBugNCKzJnnxYi8NfBSdQbycA74KYrY5mTZvn4Jx6c4u1V7V55tUQHFA9UfOLqcgl9D3N1ox3VXucO7rm2mH3LCEk2sX4vjSKB+uytkqjOTbVk7mmedQKPZ4geW5OHAs/YEK+KXRYhpk9kVphKHp5qpfumg9QfZ2Q3YKzbq8XCsWbUauXyTnTjy2lkeipTrq8K6rCLYWo4LHLzghwCRAsUxWZ09YOqWsYbFm/HUT86GN9wLM8ZqmBKnu6SDemFMJs2RwHyVdJrJHqxUBbJE0yFqpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPMsmAa+1ZDVBwVdEOJ7xYGKE7ICvXn7rn94eO4S8x0=;
 b=RdAHFNXkzIlcyqX1nr2W0iRziH7EaM7IKd+E23HpR2MPyRZiXExSSShwrgS8Gp7MQx+xkgVrfJJta00hILD7LoSYQ8Pfu/+7PJZ/eOtA5t0thMPYE9A8jwRhl7kThbMdOkg09HA1cICFtXtsGwS7etcG/ZV4yfljM0pBsP+CRr8i6G4QqEZkGAG6M6rJi5yv3f7so1LsPIqK2PmF5tTUw1Uv8vSv5/t/Xn2KQRRXp/ygr5sxnuO9X1/9IGrJrsZ3nNnxl5lpDEa9DY0sS0vVLV1OKy6k308TqVaJQLMM02BgvKB3QX6+qIeCkYc6lh6oOdCvbVTSHQlFky+/8nr+zQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 13:39:51 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:39:50 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Pavel Hrdina <phrdina@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Thread-Topic: [PATCH v2 24/24] hw/arm/smmuv3: Add tegra241-cmdqv property for
 SMMUv3 device
Thread-Index: AQHcl3gJCmC8WMsFdk+suSF07EYAZLWAkEiAgAAbMAA=
Date: Fri, 13 Feb 2026 13:39:50 +0000
Message-ID: <IA0PR12MB7555AD8A591B65CE1F0081ADAB61A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-25-skolothumtho@nvidia.com>
 <aY8RIXzUVqcTiCkd@antique-laptop>
In-Reply-To: <aY8RIXzUVqcTiCkd@antique-laptop>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS7PR12MB5718:EE_
x-ms-office365-filtering-correlation-id: 83d2b19b-afa2-4026-1ee6-08de6b055cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UC90ZmpEQUg3MXFCNVpxZUJBN1RxR01uM1lveUxPQnJkSmY3dW92ZGJJUXBv?=
 =?utf-8?B?and6NTNQMCt3M2FlVHBSZTZXaElxc2FiTmViMURydmZaZTB2NHpLV2JBMC85?=
 =?utf-8?B?WlJKdVV2NWdBUGpaU0lDQ2FIWGNMcGY4OWRpaHNabGd6b1FLME8ydG93dlFy?=
 =?utf-8?B?ZGhockx6R3ZhL25ZWjRCdGU4MEZNOXpuTHRlRk0zcS8vWWZYK0szbUpXUWhn?=
 =?utf-8?B?a0R1VmgwSHcvUGtpT2RpTGNSM0ZuZG9HRkswQnFVRlg0MTc4K24wSDhZcjBK?=
 =?utf-8?B?SDVHckFzYXpmeUx2djQ4VXdaN2ZhMTEwa3BpSDd1bEw2eUF4RnhUNktvSmIy?=
 =?utf-8?B?Vlkzc2lHMzBOMlgvRmRqamhhUmVhYmZqTmJSSS8za040QmQ5QlFKb1hLVFBy?=
 =?utf-8?B?Wk5ZKzNmS3JTV3dwUDF1VW0ydUpmcEowUUErU09paElHK3FURlYzWllWNSt0?=
 =?utf-8?B?azFQS1dXYkZEZ3N5N3ZFS2ttRjZqTjlvQ29LT0ZyZGFBK25MVlh3ZlMvOHlj?=
 =?utf-8?B?RkM1Mm5kbzg4UWZRdnpScDBPSjdFSmZteFMySDQxSWdYUUZvb0JLaDQyVUkv?=
 =?utf-8?B?UjJXU1FPNm9RT1lmZkFBcDBORXdRbmQ2aVBmNHozRHE1bUFXeVBickdmVllz?=
 =?utf-8?B?RnlLN1dRWkdPVytlcFhUNmJHbkdFQ0xjOWZlVUY2dGFKRjJQTnFuYnZaODhE?=
 =?utf-8?B?YXpJQTFXNUtjVW1XWFljSTBVQ2pidEtVQWNmRUVGUithTGpjc1cvQUUxWE8x?=
 =?utf-8?B?STdibW9SeW1KVzNnRkhBSlBPZXN1RnhBelpBUVJrYzRndHJockJZaDFYSWRv?=
 =?utf-8?B?MDNQckt3SmNiWVlzSFllVTVSNGszUkpjVXg2M1FwbERpN0YveWdwU24wZE9D?=
 =?utf-8?B?cTBwUHh3RjJKT0FDc1QyK2RxcEJsY1hxUUNDcUY1OWZFV1pJcyt5V1Z2MTcw?=
 =?utf-8?B?dDJpdGkvcHlKeVVEeG9wdFdJbkxZcVBKYzdCU1M0ZWlOSHJmV05VWnNjZkNG?=
 =?utf-8?B?OE1vTXVTb2haTjhQN2pVaWN5enF2VjZENWMyOGdPdDFCOVZIcStYWkswT3pK?=
 =?utf-8?B?WEhjRG5hTjhvNWY5dHVwblVsejdlSDNYZTJuUzVuaFd6YWJCT0NOTFRSV2d5?=
 =?utf-8?B?UytWWTZkVlBmaXlNTlA1eHVYdGFmNmd1T3RSSm9FUXlFWnFkeUN3UDRHWFpy?=
 =?utf-8?B?TWhvV1FhSG9NZ3J5eHFKbjUzRUJ1MWJKVWZGVkhTcHZkbmFOK2JEK0JwcFhp?=
 =?utf-8?B?Qk1GeGNRMzh0YmkwcSsxMUVwTVhtVGxGRDI0aGQ1Q0Y3SVpTdGJ1NjgyS2gz?=
 =?utf-8?B?WStoYS9NVHVSVmRwK29zcDllNDRobStEQ3JGUDVQYjdhUS8rUU9IUCtVdmZN?=
 =?utf-8?B?ekgxOEJnN0I2dVdSbUpYTXE0SlNjTUVkTWxGMVUzbndkTVN2SjNlTzVjdXhY?=
 =?utf-8?B?dkhqRVVtQWZNdGtzY1NXeDhMTFNzZ0t5UDNzQy8yWmx4T25keFFZZlVBRGM0?=
 =?utf-8?B?c1VJczhFYXNOQXdLOE5iMmE3VU10aEwya0xmTXZQWEx6VUhlandmUzZuMm1n?=
 =?utf-8?B?KzhjUTlzb3E1Wk1DTEJWbGFBZWVjcjlxai9LYitmbm9VaEV0VzhxYWZHVUYy?=
 =?utf-8?B?eDF6M3lJNUFDbWdJeWNQL0VCSmQzanpDUDh6eHN5UGRodlVSSXN3RkczVDQ0?=
 =?utf-8?B?RTA5bHk4ZForTWw5a2h2T0x0QllkeEFWQ3hDVUNGWWh3ejJoZCszbXE0dUc5?=
 =?utf-8?B?SGZ0MGJNaWg3M094NlozRnJ2Z2YzRnBFWUM0SEFtQ3VFQnJ4eHBWMk5IRExn?=
 =?utf-8?B?V2phNzNmK2F6NkpHTlkza0UwaW1aZ3V5ZWN4Sjh3UXBOWkZNWDlPT0MzWjlL?=
 =?utf-8?B?RmQzZjhaaDVDLzNXU1NVUGUxMit6VGxJZFFBQnVaemUzSG9xUFUwU1h0U0Va?=
 =?utf-8?B?d1hnbUc3b0dxRTNsNzU4bCtHRWYrSXJFR3l5QVpEK1hFc3F6UjJUaVcrOUN0?=
 =?utf-8?B?bFQwUnNvd2J1d05XSUtNamZVTy91RitWNUNXV2hMMklyMVVTMDhJUTRobHhU?=
 =?utf-8?B?OUw1ZDRSVWVkYXRobHhWTFUxMUhMQ25JZUJkRUwzd2lqb2VXWEQxSFVrbll0?=
 =?utf-8?B?QUtEckV2MUNVSWMzeTJQQjhwbUdpTlpGanBGc2N2Uk52bWtMem56aUhGTEV1?=
 =?utf-8?Q?cEE9DXee4tjaspXC3Qgwc3o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui9IeXQ2YWs5QXRDcWxiVlFnSjMzWnQwbTNHWmp4OHNBOWhxckh5bzJabDJL?=
 =?utf-8?B?RE4vMEJwN3lub0tYSTdGWkhQWTM5RExxblViUmRQLytVNktCZlNDc200TlVh?=
 =?utf-8?B?Y3RIR1d6Q2tMb29QVDNRR2FuNnpVVG8zcG9XcVEwTll4cmR5dU9tTjJJTDBS?=
 =?utf-8?B?TE9hYUJOUjBCMjJOcTE3Uy9EK2p5WkZENHUwSXQ3SDVHdXM1MDVDT2pvU1h4?=
 =?utf-8?B?dW9vRHJkMkVRSVVjQkY5ODZabUpPK2xEU0FjZHBQVXRUL243Y0VCb1RkWXJs?=
 =?utf-8?B?Ti9tdmpITmUrSFpqazBvc2wxd09FVm5qVjZuaXFIMWYxeG9leUUvcG1ISktp?=
 =?utf-8?B?OVhRTXNHaDJVYVl4cm1OQ2hMQldyY1E3SXU0TmE0YXdaekFBSW9XdHdEWVpK?=
 =?utf-8?B?T0h2cTY2aUtyT0FOWkIrZjdFOWhDZjZiajhva0g1cWNlRFcxU2I0WFp3aFlO?=
 =?utf-8?B?U3R0RlRrUEVHdGg5ZHIzZTdlYXh1dEgwM3FGcG9PUmwwNXAxRzVCTTVPU25t?=
 =?utf-8?B?V2t1TkhIMG96M0diTmJCVU9IR1ZEY0VOUm1oMFc4bTc4SVg4b281S0pEYms4?=
 =?utf-8?B?S1FBeDdmRnY3bWhGa1ZHOG1NbFJYTGZ6R2tVZGN2UmZIQkwyYUFZWkdTQnNT?=
 =?utf-8?B?TFdOVVduOXNtL1hKZVMzN2t5NEtsWU5vTmxDeTdidHpXanVka1ZkVmtCdVpZ?=
 =?utf-8?B?L0FoV2NTSUtjSDdzRUdrdDByVnpUQTA5Y3JwQlFSWEF4S3dWMUp2a29PSGcx?=
 =?utf-8?B?Z3ZiOVRHejU0d0R1N3JTVjNMUzhpZ3E1ejErS01MUmx3YzFFR0dEckhwV1Bm?=
 =?utf-8?B?UG1vWWw1aU84RGRqODdNZlN4ZXBCQmVYOExXMTVqbWszcU0rZWk3T3hza3Fj?=
 =?utf-8?B?dEw3a2wyQ2xQazBCbWpscTJnY0JQNFk1WWFKQURPbzdHNTdmckJNWnpTdy9E?=
 =?utf-8?B?dGhtK0drQ1VOa3Z0aEFDSmovZGI0NFdaN1R6NjFseGtLTHovUWFnNU1pVmRy?=
 =?utf-8?B?WFZUcVJEYzk4QmJCZWNzdS9DeGpUQlZiVTBlaUVnWUFQRHBxYWIwTnI4NFM5?=
 =?utf-8?B?SW1SOEpvRExsZWk2TEZOWWg5V2U0N3JmbThIQzZIS1NnOTV2aldYeWlWRUMy?=
 =?utf-8?B?Q2VXdEZKbi80Q0JHL084TkNSNmk2NExEdFhWOWxvcEkxdHV5enNvNlRiVm9x?=
 =?utf-8?B?UC83NW83VDlmUEwzdHY2dU9uTENudElCREFyQ29oYVM3dC85Z29nRmZRRnFQ?=
 =?utf-8?B?TlRvOEp0a0l6YXViQ0U1YVpHQlNObmNLTXlxcTFrTVNKSWtyMzVXSVdKTUhj?=
 =?utf-8?B?eVpJN09VWVR3MmduS3grMkZFMmdVdVRYZ3hlMlIxU1FHT2g4M2NpUGNWU0to?=
 =?utf-8?B?a1JuVmNYalRHTld0ZkJyb3k2ZHJnVFUzcHZvai8zYlBreFdCMmlsWWMxRFor?=
 =?utf-8?B?VW5pZlNxMWxPanUrSnhYUERrSlg4QW9aVFpPLzJkS2RoV0pRM09NN3Y4Tkk1?=
 =?utf-8?B?OWJTUzRzVnE5ZEt5Wlh3R2pnRmt5NWUrNTZrTUxEbGY0NDN2TzNncFFwWVUy?=
 =?utf-8?B?T2JWd0EzbGVKQ0FCN29CNGhaSTF5RFJtVTA4YW11K21xYzBqRjZqMG1DeTVS?=
 =?utf-8?B?TDZjdzFHWUIydklPZk9YUXZDTDVCNVZ0REpUazZRdkhSK05rTzJtajFTQm5z?=
 =?utf-8?B?QkRSWmd4R3UzMzFKdmtCQU5yM2dxZTV1VGpHMmgrRUU3dm56UzNuVTZHWEVT?=
 =?utf-8?B?VlJuSlB3VzcwYVVFZWxPMjlLZUFDc0dsQmI1SU1YR2ZBT0Y4ZkJIdVZ5MEN1?=
 =?utf-8?B?N0svaEZsVEQwZG5LTm9sQWlETnNsUWhsd0dFeklLSTY2OVR1TmMyZ2w2SFUv?=
 =?utf-8?B?Q2NMdDJIVWZsY2NQR3Y3Um5RSkJZbGhqY1pQYVAwWkl3Nm01RHIrbGx5R0J5?=
 =?utf-8?B?WkpLS0pPeGg0S081OERHcTRGYkZlSm42cVRldnk4RmhQQlg1M25pdEdCMHZD?=
 =?utf-8?B?a3ZVYlRJNHBjaWJ3Mmd6MitJZVBiYUdHbUVIY2F2NkxwUzNIRXhkVzlWS0Z5?=
 =?utf-8?B?bDJ6SW8wUFhvMGhZOHBZRVVRak50VDRISFBUeXd0ZS9zNlpZMGxvNmtZbzRJ?=
 =?utf-8?B?YVJsOGlvdHRjSkhzMGhwRm02SHJIZWpPRUpZYzNxRFdTa1lSb2JQSzl1aGlF?=
 =?utf-8?B?OHpXMmd6cjNnR1lzajU5WDU5S0NXd1QvaU5zb1ZNbmU0eGE3aDlHUHhBbGVI?=
 =?utf-8?B?M2RzamdHci9BMTZrNGF5ZzErdGZOZ2QrRmNheFNUR2NMRzB0dTM0SUF3QmlG?=
 =?utf-8?B?ZjNOYW1qY3NnUjNCMjN4aFd3b1ZqcHpWQ0NzeTFmR2xDS3k1NUh0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d2b19b-afa2-4026-1ee6-08de6b055cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 13:39:50.8460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lz2EWsHUUAh2wfyCEIKNlgOa207J+Ozkw3hS3r5LepMGYixSQNXosY8oBgbyiNqAx4PHPgG2ylFv1ziN15W3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgSHJkaW5hIDxw
aHJkaW5hQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDEzIEZlYnJ1YXJ5IDIwMjYgMTE6NTUNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzog
cWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2Vy
QHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207DQo+
IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5h
dGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+OyBKaWFuZGkgQW4NCj4gPGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlIDxq
Z2dAbnZpZGlhLmNvbT47DQo+IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsgemhhbmdmZWku
Z2FvQGxpbmFyby5vcmc7DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQg
SmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyNC8yNF0g
aHcvYXJtL3NtbXV2MzogQWRkIHRlZ3JhMjQxLWNtZHF2DQo+IHByb3BlcnR5IGZvciBTTU1VdjMg
ZGV2aWNlDQo+IA0KPiBPbiBGcmksIEZlYiAwNiwgMjAyNiBhdCAwMjo0ODoyM1BNICswMDAwLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEludHJvZHVjZSBhIOKAnHRlZ3JhMjQxLWNtZHF2
4oCdIHByb3BlcnR5IHRvIGVuYWJsZSBUZWdyYTI0MSBDTURRVg0KPiA+IHN1cHBvcnQuIFRoaXMg
aXMgb25seSBlbmFibGVkIGZvciBhY2NlbGVyYXRlZCBTTU1VdjMgZGV2aWNlcy4NCj4gDQo+IEhp
LCBkbyB3ZSBleHBlY3QgdGhhdCBpbiB0aGUgZnV0dXJlIHRoZXJlIHdpbGwgYmUgc29tZSBvdGhl
ciBvcHRpb24NCj4gbmFtZWQgYHtuZXdwbGF0Zm9ybX0tY21kcXZgPw0KPiANCj4gSSdtIGFza2lu
ZyBtYWlubHkgZnJvbSBsaWJ2aXJ0IFBvViB3aGVyZSBjdXJyZW50IFJGQyBwYXRjaCBleHBvcnRz
IHRoaXMNCj4gb3B0aW9uIG9ubHkgYXMgYGNtZHF2YC4NCg0KWWVzLCB3aXRoIHRoZSBjdXJyZW50
IGRlc2lnbiBlYWNoIGltcGxlbWVudGF0aW9uIHdvdWxkIGV4cG9zZSBpdHMgb3duDQp4eHgtY21k
cXYgcHJvcGVydHkuDQoNCkhvd2V2ZXIsIHBsZWFzZSBzZWUgdGhlIGRpc2N1c3Npb246DQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NIM1BSMTJNQjc1NDg0QTE1MEQ2RENEOUQz
QzNDNjZGM0FCNjBBQENIM1BSMTJNQjc1NDgubmFtcHJkMTIucHJvZC5vdXRsb29rLmNvbS8NCg0K
SSBhbSBsb29raW5nIGludG8gd2hldGhlciB3ZSBjYW4gaW5zdGVhZCBoYXZlIGEgc2luZ2xlIGNt
ZHF2IHByb3BlcnR5DQphbmQgcHJvYmUgdGhlIGtlcm5lbCB0byBkZXRlcm1pbmUgdGhlIHNwZWNp
ZmljIGltcGxlbWVudGF0aW9uIHR5cGUuDQoNClRoYW5rcywNClNoYW1lZXINCg==

