Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC9EA3F22
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqHp-0004A0-6Q; Tue, 10 Feb 2026 11:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpqHm-00049P-JO; Tue, 10 Feb 2026 11:08:22 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpqHj-00086w-RV; Tue, 10 Feb 2026 11:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZVwswYO8VJ4gK0IChJ/al0goU8pCnit+ifvPCiiJZZneYXxj9F6M7XHNw40cbHXJy67DHDprK0K27uC9RxqNbB9EqLOO1YxAcJ94VImnX4uFH4Qt75Rnq6CR7uJKgjz19gkjs/Ax6mwWbCEMw+iOxwBkIt0S2ur923RRPcxX59+GxzRLPPORm1XV5+MD6+s9PT/aSEcflSG2YPqG1Hwjl4Dwzevicgj/wT924cjtKVc5O7TTN2/S5lODNaA9bR7hlpQJl2vGo6JDk08B6G7DB4Zwc+bBgreljuLNvF5Ayqtopeu02xP0zdIwul5rwVipPM+kpYsIxSe/RbjQ6sfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcu8zbGo/rax9PDoKj27DNnUM9VrXMneOEnWaT2Dq40=;
 b=B00ARtPyHposJ4iOoj+A/2LK9DqiJKUuUtnwYrW1f8cKwsg4NpVA0DZDxxN59kaMBIXrp9uT2H4+EiTQ5F2+DhLuDU22IrFMHbTWpp+Lm2izz6UnJVsrzMCONeCPSacQyLSVGBzYUYrkHOvoXdKXqxv6M7DFoBELnafXyp87nRpDFvBI220XWkSMEhtOejAeGr/mFY+Do6XmgJ8o0oFmaxw3guy1GviIrcrDQ7fpnOgffWdDTwy98IekBLv1x5DfuOusMVli43c8mxgDtTab0ORkmb7v6TkQarzd9xE8OnDtTlZlrH4S94jJJXt94753AChVyqZ0Fr3z2pd+Qw6KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcu8zbGo/rax9PDoKj27DNnUM9VrXMneOEnWaT2Dq40=;
 b=FkXdP20pyKD35OsyeLA/WAJtYpIyeT8UOLzbtfGnWEosJs7w6043ZE/RxKjXuGQDh6mKYjl4MrST1XH1eRziMYTBsQWExW+aR2kiefv0Bo24qh3KIbTiJhdALIwK7Wv3gWOkB4nwFUWIkirDrNU2uVw2Hx3nRoNW+glgmFNGFKi8kvojM5OZsB6kSGm45PA+c9A/UQjgBIqX9ro989bSrywgEkSO++o3tAA3/Zu7FLWb0Cf6VVDHpv0hbgYwzp6e1we2bq6yZOEXfeKJ1lGHZdsARPRwA/m3aOz3xJe85PVEEygyiE6sJXIKKbkMJNZjkcoDdDm1CreZ188vRFgbYQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 16:08:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 16:08:12 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKCAAAa0gIAABIOQgAAG3gCAAAAr0IAMfn/AgAAUZICAAAB9EA==
Date: Tue, 10 Feb 2026 16:08:12 +0000
Message-ID: <CH3PR12MB75482D85BB6521239325DF3AAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <03282286-c99e-467b-8192-695d973ea656@redhat.com>
In-Reply-To: <03282286-c99e-467b-8192-695d973ea656@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6106:EE_
x-ms-office365-filtering-correlation-id: 0556d501-3167-4848-7cef-08de68be972c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?T1RoMUd5UFVmZUNxU3J6UHJ5OVZ4cWdUaFFRbTVBV2NYZ3phZllZVldJZy9T?=
 =?utf-8?B?bDh3VlZzMkJiSGcyTnB3TjNkeTk3RS9DanBHWTBzUFVQeWpYMXhFSUlYMFR0?=
 =?utf-8?B?UDNqMDRaV005THlpWFZtNkJMSnM2TGxwYjNmU29McEhacWVzV0loM1NPZEY3?=
 =?utf-8?B?aWYyMmZCeFIyZjNFdEwvdUp4a3NrUUNoNzc1TVNic3pkdDZOaHg4ZXI1VXh1?=
 =?utf-8?B?bm8yNUhOYzJ2M2VBazRqWE53N0Q3RGl2QjRxSi85ODBRV3FrYWpLa05zVlds?=
 =?utf-8?B?Rjg4SkJYZlRKWFJzQnFPOXBYcWUyZFNCK01xSlVvV2VQVE5ka1Y4RGx2ZWZ3?=
 =?utf-8?B?VUNkTlVuOFlidUtPTXh2K0tqczUrSjBaVlV4SnNKaG8xZ2syYUxrNXp2R21p?=
 =?utf-8?B?dEYzTVlaMEpiNzZrS2VtRnEwb3Jhbms1RjdnUTRFS2d6TmFvUS83dTNtU1Bu?=
 =?utf-8?B?RzZoNU53eGt4OTRMd09YNmV1RlVCeGd0MGhPTWNwVHFoVnZCVENRbHNEWEwy?=
 =?utf-8?B?TkRnM2RvZkpzL3JoNmVmTGhFcmdrSVVNdy9GbWdvaUlkQzF6N2ppM1cyS0R3?=
 =?utf-8?B?M0NEL0FpbTV6eGk5U2oxbzIxenBkMHhidUdoa1pxYjVuSWVxRWRYV1hLU3VH?=
 =?utf-8?B?eUtYNm53RnY0ZzBDc1h6MVR3RjE1eVVUeFFkUlp0aSt3Mk9qWkpiUFFkb0w4?=
 =?utf-8?B?Y2NQc0tqZTZ1aFpnTVZYVjdZY0NLcmQyNk1nak41MWNXMEtyVDFIR2N6dEZJ?=
 =?utf-8?B?SmlYejU0SEx0RmZGTm10RDNsU0lNQ0MrWE5teFBNUTR3c3dEb0V3QmpHdEdk?=
 =?utf-8?B?NWRIampRaFMwRndVaXRhN3c2TjhoRWpLVEgxTTdtbjI4dkhwcGtDSlYreUtR?=
 =?utf-8?B?ZHlHbVcrUkJvemkzRjR2bWJBdWxSMUUxcmpQbFpkRWUyRjlkRk90azc0dUZk?=
 =?utf-8?B?WHNrV1R4Unc1a1p2NHJSTGxUemE4UUlXKzk1QXdRdjFTeUhycFVtTzJtcUZh?=
 =?utf-8?B?Y2hhYjYydW1VUy9IT3hPNmRNS3RpYzdTUGVCdXUzdW44T2xpWFl0SDFqa0JR?=
 =?utf-8?B?aWY5dytBUGI5WVRCZTVLa2JBTGtjckE2NnBvR2ZleTNZYVlMSVN3WVlLSG5r?=
 =?utf-8?B?dG4zc2d0Zzd0T0NGWTRGRUdmK2VxbjN5LzZZK2xZKzhPVEJuY3cxYTh6a3N0?=
 =?utf-8?B?Q0o0cTJEb0p4Tk1kUDdyb3lTa3hqcDdCdVRMSUphaHNlbEZaMWlzeGUyOTVY?=
 =?utf-8?B?NmxwSERBcGtyUnpiU1QxTm8vOVVMWjRSbkNXR3Z3TXA4WE1BSEJseXdKcmJD?=
 =?utf-8?B?SkEwZkJDMXVpc2NyY1YyY3RQZEhaaGFHc3BXZ0k0a0pXVFRkZDlsc1RYalNw?=
 =?utf-8?B?VklyejcxclRoK05RYVZOamwrZDR0S29wQktldzhHelBYcjdmNEJwZXp3bmdJ?=
 =?utf-8?B?bVZmeVJrcTlzb0VlakpKc1FzRnErRytkbzkyVEZVNGc1RGRteUY4S3d3OVpR?=
 =?utf-8?B?UUovRWtEK2Q2Tm80c1F5QzV1UWEvNUhrc2FRWXBQTkhNZ0FHcHhYLzVXaU84?=
 =?utf-8?B?bXFkeVBETFR2MkFXcXBTVEFUQWxpOGJtK1VnN1NlODErOGxrS2JEclNOVlRi?=
 =?utf-8?B?OWxVbkJPVkFLRFJXV0VYMXcySXlMWG1qd1VBS1BTYVB5cXhvZGoyODdYZGto?=
 =?utf-8?B?d3pLTVM4bk12QUtkQmVpRi9ybGFRbmNaekVvMi9JRjFYZDFDS2tHcExQSWFF?=
 =?utf-8?B?SDdiM2RuWS9HeWxQODFqTTE5UEdoMU41ZmJQMVhURDVtb1JZRDlIQjlxeDBJ?=
 =?utf-8?B?amt4QmlhVmxscGdhcjZQTlNDcUFmZDNrWkUyQ0V4cU5LSFlBQ1JJN2xUdEsv?=
 =?utf-8?B?b2xPR2RhdHRRMTFJQ1BrZVZTcmxTTWVXOE0wYzJBNzdmVjJ5ZUhpU1dNZXRO?=
 =?utf-8?B?bXR6N2pOOUUvZWRQbDR0ZDNNYm1uM214Q1Ayc3RBWmR5eHVhY3FTaDZsTyty?=
 =?utf-8?B?cmxkNjA5d2V1cEhqWTY1MW9zblVpUE1NKzYrZ1ROcHpSTTB0MHdvYTdQa2hE?=
 =?utf-8?B?UFdEUlV0TTNFK0hNVy9QMGxiQTNPaWJtRWVkRDFIMG1YVkt2SHV3Q0JQMkMv?=
 =?utf-8?B?TVdRWEVmVjZFQ3Fzcjc2QWUxWU9vcGczOWltSkdCNGh2UytzMGw3cHAvNEsy?=
 =?utf-8?Q?yZoeFEYV3CGG8RwXfPWsW78=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU1lTVlpZTZrcmVnT2RuM05Mam16czJWYTJhdExGaG5uMzZWWThyMlk2YU90?=
 =?utf-8?B?SnJ6cGdFV2ZheFZDVUhNMXNLd09mL29EOW4wNDlZMkthVEdFbFF4dldmeWJR?=
 =?utf-8?B?NTlZNWpTcDNucy9MU0FZaFVlSmk2bWNtWm5uTGRHOTd2bnkxWUpKa0c4R3Z4?=
 =?utf-8?B?R3lxUFl0UEs0OUlxV1c3TTVCWjNOdnd0dWFyTExwdm1XZmI4TGVBRExzdzhL?=
 =?utf-8?B?aXo3bmRnR2ltMVFxdllncGhONTYyZGFOTENZWklYNTNTSmRDVGVOMGRtWTZN?=
 =?utf-8?B?TllveDFwLzZpUEFQOUYzdzBXRzRjMFgwdTRvRnhJbjBGMitTVStqSUUzMlhr?=
 =?utf-8?B?MWgxWjlxdkFCRlFOak9UcmZIeWZwVTdMZHRBMGNsRDFxRVNkMGg3MkpYcStM?=
 =?utf-8?B?QnhSZmsvWk40Z2xuamtlMEtOUW1NRGFZNXFHOGNucDBDaHdXY1NWN0llQlhh?=
 =?utf-8?B?QmtmRzV3Z0JmaFROTmFRREt4ZWt5dG8rbWpPU3lrTHdSd0ppZWhuUnVhUUFQ?=
 =?utf-8?B?TU95dmZXMTVnekEyY1h1YVlkNU1HUjV6bUtxVFlnZE5waXNpdWovRTNqeDdr?=
 =?utf-8?B?MThYaThQaDlBcTBKMmVGSGlra0ZLdzZiSG5lemQxR2xpL2l3Y24zb2xmUTBW?=
 =?utf-8?B?OUh6Y0Z5SDNmTlBHcFBmZCtpN3dEcHdiSlhVQ1VhVGRBWDZ0ekc5YlYydVlj?=
 =?utf-8?B?Z3RZR2E3dHFmZVVaS1Q1ckxRcExueTNOaGh0MHJWRGdiRzFCUVlNOEhvZTZK?=
 =?utf-8?B?ZUdJTmNWNlRHV0d2VnhsV3NqeUF3UXhhY2RxVGkzN0JOQUVvbktLazR5UmdX?=
 =?utf-8?B?eXN1NDdCOUh6aThncGl0Sm9sV1Z4TlFCMU4yS3k3czB1T0w1RGpoRUx3bmR1?=
 =?utf-8?B?eE9RTW54aDk2L3V6QUtlckVPeml6RmdNOGtRL0ZjTUQxL0N0SHZ0c0toQ2tG?=
 =?utf-8?B?TmtBZXRBaGozS2hhdUc5U1kvcWVvVUR3dlNpNXJLMG9SRS94SmNoNEoxRjNR?=
 =?utf-8?B?b1dMZ00vdUVZaG5ILy9jQi9WOWhWY3NLMnNPWnIrNElpdi9VcUc4RnNzTDVl?=
 =?utf-8?B?Y2lZb2o1KzkrSEtmRnNsMHAvUGxjK1pkeW9iSklUMmh0b3phYVNkWVlZaXlH?=
 =?utf-8?B?cDdWeE9obnpIKzNpQ0RNYlpaMlNyOTJzajRYSXh6WGtGYW1JdGNmY0llemF6?=
 =?utf-8?B?aTVCRUhxV0x0dUdYMnozQWlReE5zNUZBTVZESEFuWUZHZzFtcWdSNzJMUWFG?=
 =?utf-8?B?UmR5WlBBcE9yRkhydC9YK1owSERXUml2NWVVMHErMUs0RlFidVIvUzZrK2JI?=
 =?utf-8?B?UWxsc0hiYjQzUFJDVXBONVQ1K1R2M0I4K3BCY0pSRTRVV1piZDhTUXZLL1RP?=
 =?utf-8?B?ZlQ1MEtQMUM1bGJpbHdUYzJteUVsdnkrQnBaaHd1Z1lhS1JMSUZnYS9MVnN3?=
 =?utf-8?B?UjIrZE81MTdZZ0tuMGxTK2ZwKzkxV2ZIWnFoUktLejdUbmlxejcvY2todHc3?=
 =?utf-8?B?ajg5UGkvS0pIaDllcnF2NzZDNlpvL2pSQzlqSWJCd0owekNpMTIrYURvb1d0?=
 =?utf-8?B?SHNsUElhSzVFNWZacUV6QUZGcnRMMVBlNEUvUjdkVTB3Z2E0Tms1YS9QRFVN?=
 =?utf-8?B?TFo2ZUhvNzBvMzdGQ3VKU25JeDNhNmxqNHMvQXJaeTQ0MTBudWluVVJxc25I?=
 =?utf-8?B?UUhKekR6NTMwalZlcnNpZENLcm9oUkV6R2dKblkyZEFRVFNOTUwvODd4Ty9x?=
 =?utf-8?B?eU5aS3cvYW43ZzJwbEpFSklaNElQVEYwS1BsS0xlendMOXA2bW5DRzNvbjJo?=
 =?utf-8?B?Z2pWemdQcXJibUx1a0haeVJqSGFXRjVqSEx6VkR1aHdBRkc4cG5wVXNGTlA2?=
 =?utf-8?B?UTRFdUhLYlcyV2RyUWVsbVJEaEk3M2cwTUt4aU9DWVg4ejEwTUZWUmRIcWg3?=
 =?utf-8?B?U1NFajdRZ0RWd3QzdGUzOFVWUUcyemxLZjFaRXhLajhaVFVQMVBPeTJtWGRB?=
 =?utf-8?B?UTQvQ0U2RWZlV0gyUmg0RFRiTDIrc1NySjRXUXIxMVNJQjg1bXp5QjdCRk9F?=
 =?utf-8?B?TStlc2M3VmswZ2YwMjhxWW90OERjWTNxa3VoVWdYcHFSb2xDNVM4UG0wSnZ2?=
 =?utf-8?B?eVV5aTR3UTBGV0NYd1VMenRvWFg3M21wSWtnSFBOUk00V09iU0xGKzRFRC9T?=
 =?utf-8?B?QnpPamdRRmplS0ZpMjJMV3hMaGJyelhhUkxXdlBMYk9hdjE2M01VN3YvdnJH?=
 =?utf-8?B?U3d2NURaaXhGZjRlcXNxdmhramZSUysxaitzU0JpODRzRWMvamcvYndVOWwy?=
 =?utf-8?B?SXRteU9QOUl1TnRYSnNOWHZIcWRXRlg2VnRSUC9oT0phcTRpVUxxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0556d501-3167-4848-7cef-08de68be972c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 16:08:12.2127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Et0hu0lvAhmnwVMfitJvkOizaztNRHiWaAmRdL8Lu6OzvZe9eegAKgD1gAp5gGqxjNmawYYm339h5fHP3p/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDI2IDE2OjAxDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IEphc29u
IEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsNCj4gYWxleEBzaGF6Ym90Lm9yZzsg
TmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8bW9jaHNAbnZp
ZGlhLmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0K
PiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+
IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IHlpLmwu
bGl1QGludGVsLmNvbTsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2OSAzMS8zN10gaHcvYXJtL3NtbXV2My1hY2NlbDogQWRkIHBy
b3BlcnR5IHRvDQo+IHNwZWNpZnkgT0FTIGJpdHMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2Ug
Y2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkgU2hhbWVl
ciwNCj4gT24gMi8xMC8yNiA0OjEyIFBNLCBTaGFtZWVyIEtvbG90aHVtIFRob2RpIHdyb3RlOg0K
DQoNCj4gPiBUaGlzIGlzIGhvdyB0aGUgdXNhZ2Ugd291bGQgbG9vayB3aXRoIGFuIGFkZGVkICJh
dHMiIHByb3BlcnR5IG9uIHRoZQ0KPiA+IHZmaW8tcGNpIGRldmljZToNCj4gPg0KPiA+IC1kZXZp
Y2UgdmZpby1wY2ksLi4uLGF0cz1vbg0KPiA+ICAgICBpZiBBVFNfTk9UX1NVUFBPUlRFRCB0aGVu
IHJlamVjdA0KPiBIb3cgZG8geW91IGRpc3Rpbmd1aXNoIGFuIG9sZCBrZXJuZWwgd2hpY2ggaXMg
bm90IGNhcGFibGUgb2YgcmV0dXJuaW5nDQo+IHRoZSBjYXAgaW5mbyBmcm9tIGEgbmV3IGtlcm5l
bCB0aGF0IGVmZmVjdGl2ZWx5IHJldHVybnMgdGhlIGNhcGFiaWxpdHkNCj4gaXMgbm90IHN1cHBv
cnRlZC4NCg0KRm9yIG9sZCBrZXJuZWwsIEFUU19OT1RfU1VQUE9SVEVEIHdpbGwgbm90IGJlIHNl
dC4gU28gd2Uga2VlcCBBVFMgaWYNCkNBUCBpcyBwcmVzZW50IGluIHRoaXMgY2FzZS4gIEJ1dCBy
ZWplY3QgLCBpZiBuZXcga2VybmVscyByZXBvcnQNCiBBVFNfTk9UX1NVUFBPUlRFRA0KDQoNCj4g
PiAtZGV2aWNlIHZmaW8tcGNpLC4uLixhdHM9b2ZmDQo+ID4gICAgIGtlZXAgQVRTIG9mZg0KPiA+
IC1kZXZpY2UgdmZpby1wY2ksLi4uLGF0cz1hdXRvIChkZWZhdWx0KQ0KPiA+ICAgIGlmIEFUU19O
T1RfU1VQUE9SVEVELCBkaXNhYmxlIEFUUw0KPiA+ICAgICBvdGhlcndpc2UsIGVuYWJsZSBBVFMg
aWYgdGhlIFBDSWUgQVRTIGNhcGFiaWxpdHkgaXMgcHJlc2VudA0KPiANCj4gSSBhbSBub3Qgc3Vy
ZSBob3cgaXQgd29ya3Mgd2l0aCBhbiBvbGQga2VybmVsLiBhdXRvIG9yIG9uIHdvdWxkIGtlZXAN
Cj4gQVRTPW9mZiB3aGlsZSBpdCBpcyBjdXJyZW50bHkgc2V0IHRvZGF5LCBubz8NCg0KU2FtZSBh
cyBhYm92ZSwgZm9yIG9sZCBrZXJuZWwgQVRTX05PVF9TVVBQT1JURUQgaXMgbm90IHNldC4gU28N
Cmp1c3QgcmVseSBvbiBQQ0llIENBUCBwcmVzZW5jZSBqdXN0IGxpa2UgaXQgZG9lcyB0b2RheS4N
Cg0KVGhhbmtzLA0KU2hhbWVlcg0K

