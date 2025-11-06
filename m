Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48AECCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH0y4-0005si-JM; Thu, 06 Nov 2025 09:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vH0y2-0005sT-VF; Thu, 06 Nov 2025 09:28:03 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vH0y0-0004YX-T7; Thu, 06 Nov 2025 09:28:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrMBM3m/Lj/xSOKtwXDgYCvVlOHG1oWF5F1wcrZpgukpOMgB/zEN3x8D+Mg1lL6lqktiUaTkCcRJn6FDPwLSY3n9phZSkQKtThwSO4evSpqexeo4De3dYALD3d6qEQgkgNOPlrRZiwS3Y8+8jkJY9uHzXUcQXn4bTjDQmezH5X8494+UU+u5lvgWsxcgokjKWdTYaJgbNN2obUsr9rTw2dzNA0EkmhHvcVSuFBz6ohAa1ObU2grolkGp07yzdbgKfR37Add9oALYplbsG/LwnnQzoLBHkBdfyR3DZ6sBTM4vQpxFhIq6d6UKP/DjGPMSXPchOnDyDjS6nl0ep+69ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx0LMP/Gngcdg77DOVW7GrRYj3DzuV1kOnx0V9W/Scs=;
 b=AOglmSsvkFxT8SO6t8mRSCbLi4q+ak3a6TD3zBHTgJRAJXp3H5vHpTzcqlLa6Eg7Fnigkk7LOFMnP6NZFaz+fucMZDhbL7e7t94A/obJG1rc+04bkgYabdqibVouxMFu27DwBEEh5RK+Lv54KZ7PEvjjkHT53qo3g8NPN5+fBjj5dWU2Sd435PqNpgJ0W+hiFgHWRrzQtEoE5dI3X9+DVemU/j/atUZMsVJ8Td2VI+MYz5xH5q4pLG04P/Jd9rBLqS5WEEzRQ1E1qLlZZbLzYMZD6E0LaSWzpqzanAMw/TWguTeg4De643b0QEojLXGRpAldLiEiyoi1gLW2RujF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx0LMP/Gngcdg77DOVW7GrRYj3DzuV1kOnx0V9W/Scs=;
 b=DyR3b5tQxCr+g7lfQmksIvqEFfIkkrQ6LLXkPV5ylTx0sOrXl27Hjd4L1qINy/c6xytOkhl0VB32nH8qv5CtR7Yi6uyXEq4szmgSStRRqD4qRV5jXZZyOuuSp7HtFOgbP8pOcoYvWowS/G2p2+WrlDK8mwwm/ICquhMJ5En3t/izWHe+7urukaPUAcI3H/1ZilyLuPbPhHxcpaoMkaj1SP8u0TkfyZYtnz0kCRuybTcZbi4KxmgpeWWub7zflng7bRD65JYY3GcKjRMhosStWLq9jzGnVQGdABxRm2vh0QM9Kp+XV3q7ZnQdXqmToEaMy3UuM76noM1Fe+yvKU06LA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:27:52 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:27:52 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Thread-Topic: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Thread-Index: AQHcTyUGApqpy0IT2km0lyVPSEwimrTlsilg
Date: Thu, 6 Nov 2025 14:27:52 +0000
Message-ID: <CH3PR12MB7548610D1BE66DA63CFE788EABC2A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-32-skolothumtho@nvidia.com>
 <1be3383e-843f-49b8-a246-59375c42aaae@redhat.com>
In-Reply-To: <1be3383e-843f-49b8-a246-59375c42aaae@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB7986:EE_
x-ms-office365-filtering-correlation-id: 5c740a09-ed2b-4d6e-87fb-08de1d40ab4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UGFPcjFPa3phZ2dzbTJQeEl0RmppTzVZak1XV3dlUzNzNmhNNHdVbk5yK2Q0?=
 =?utf-8?B?VXNMaE9hL1RncHhFU2dYMUtsYUpyUlNuaUlLUkVPeU1zMDNvdDl4R0JEbXY2?=
 =?utf-8?B?ZHB4VmplOVE1amZCYk1VU3dlUHZzODh1bHkrdkVVKzZaeXo0NW1TWFBxem5S?=
 =?utf-8?B?NVhnUVJTZ0VieWw2OW9XVW5DczJ5ajlMdFA5MVpTMlhScG9PTHEyL1Z0N2Ns?=
 =?utf-8?B?Y1IxSEsxT0w4dy96YzBwU3dZZStRUDNpaFgxaU1Rb1ZGdWYrUVV5OUlCZGd4?=
 =?utf-8?B?aDF1VUJxb2hSc0p1cjJuV2Y5UkdUTWU2N09DVnBVL1hPMjhyT1N4Vlh3Mndp?=
 =?utf-8?B?NTV2amFOS1lUd1BjWFpHaTlReFJWb0NnN3IwL25rSzVMd2xrNExETE5rcHQw?=
 =?utf-8?B?N1luN2xrYVFScGpMRHpQdVRueFk3eWpvN3I0R0k3Y1pNZlZjUnk5UHlyRThp?=
 =?utf-8?B?SC96WFJwbDBrOHIzK0RrcXBQR0cySmdxemsrbEFYRVNoWE5JYnJZWmczREJU?=
 =?utf-8?B?TEtlME1hT3p1Z3gveVg2VGNpSDZmUTA3MXhkWlNzdUJvaFpWNWt0SWpjZVFk?=
 =?utf-8?B?NXhySmFVMkM2b3FRSVBzKzBCM2JoUlJLRVZNK2FHWkZNUlZxUlJIZ01YOWF0?=
 =?utf-8?B?N3hqbk9NUWYybW51YjVVWndDaGJlUkFqd0UyMXd2azBKSDY5SXdWd2ZWL2tr?=
 =?utf-8?B?KzNZYm52OWNYN0c1NDBJTGxvdk5VVVlheFBTaGlkZjBjRVR0S1NNeUhjSmk4?=
 =?utf-8?B?NGJMTHhMSzFkc0FKY3VZeE5TLzZWL0dzekNoZUxOUDh0TDkrZUhteE9xRm9p?=
 =?utf-8?B?N09qUVNQeDFUbDYvc3BndFBYV0NQTmdSMmxDcnU2OFprYTdyRjd1QVNjbE03?=
 =?utf-8?B?SUZyOWhtSFludVQ1a0hKaHZyWlFIdjhNKzRWZzRzNU9uOWg3VGJhZVlMRC9u?=
 =?utf-8?B?bWw0Q2hKQkZ2UmRhclpJaHFHV0llM2xTOHJKSCtRN1ZEdWZjbHBRWUtUVGpz?=
 =?utf-8?B?QlRJa0R0MXIzMTY5SzZqVyt1VmFBS0I2SFROR0dpeFlIWDB0WjFpRlFsaWZ2?=
 =?utf-8?B?cTkwN2tRaTFjU2N0bTJpZXRwdFRZcWdqTUZsbjBUUTViODBTcVZTL0IyaXpJ?=
 =?utf-8?B?V3pKM3JoQ3hkVFlUaFdmbi95QjVCRlhVVkxBRDJFZjBzUlYzMDVweWZDaUx4?=
 =?utf-8?B?enJhUkJrQUFUZXZkTXpKclgvQnpoN09mNkZxZ0dyblFQcDFSTExaWmZFZUdu?=
 =?utf-8?B?Mk56Z0hTVnZXVXpOMHpxQ2JKQ210RUMxblRsZGFrOHV5QWJxTzJGaDg3K1Zj?=
 =?utf-8?B?b2FRS2NpWEw5S1Rla3JKcS92d3RYbDlZbVZGV28zaFRxQnhwa2M2ZVg3dUVP?=
 =?utf-8?B?NTFRcWlObW0rR0JEZVpSbHNYSC9MQ2NDc2tkVWd6RHhoUENwOEkzMTdrNzE2?=
 =?utf-8?B?VVRBazc5QVJpSEJubjgrWEJaRDFLWnk0MC9uRUlGYTdTd2o4Uzdob3g0ZzJp?=
 =?utf-8?B?N2ZLTjZuakFIazdrUFhtektGeDhtcXp3Q1JORG5kSlZqdU0wdDh2T3dMWGUz?=
 =?utf-8?B?MXJIelVGSXBuclhDQWh3MFFpdFZYNzNnZklTc3FqVlMrNTl6MEF3VXJTZE82?=
 =?utf-8?B?cDdpZ2g0TEhZdm9TVmVKZ0xSeC9JZzI4M0lyOGYzMXRJVTdGRE1SODRWcmln?=
 =?utf-8?B?S3NiSG1maHNCa0ZjU3lJTlFTZzkySkFmNGhwMm1ORG9TRFZYeE1oNHJoQWtD?=
 =?utf-8?B?d2xpaWtyQ2t3YUd4NGt2d095aEt3elBYTTJrcFJBL1orOTcwVDBseVBKRlNH?=
 =?utf-8?B?cnlMN2hVTEtDQ1ZMMkdrM0wxL2JVSlE0N1dKSGhZK29kU1hGL2hpUEpMVFpr?=
 =?utf-8?B?ZGVsb0lhVDdhb1d0ZHpqdmQ5TXd0SHYwMkdieHhTOXlZckV4bzV0SDJEZnRs?=
 =?utf-8?B?bGpHTkNDRlJCa0N6eXlxcHZzTFc2aGpkMkEzVnFoNXJOWlAzb3pWVmpDZ3Nk?=
 =?utf-8?B?ajJtTEd2MllCN1pWSmJ4aERheGMrZXFQMTJRVTByK3RQVmZRWCtyem1KMDhy?=
 =?utf-8?Q?oY6ykT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1BlTzF6N25HLzRWTWxkdGVCSVIwbEhISUoxenlKdjVJY05DNjFiWFJHNkJq?=
 =?utf-8?B?SXBvQlVmR242UDArU0F1TFJrQW9nQjNWbUJWQjkrZkpEeFM1OTVLOWwxMFhm?=
 =?utf-8?B?bEF5WHd6UXZHcUhRWFJPSGhEMkdoelQ3YjEya1NXenJUMTNDVnJEbjRVaDIz?=
 =?utf-8?B?elhUejRSMXY5enEybnVnZHBqSDNnS29xOU1KdG9xTFpoNW9xZ014TG9hL1o5?=
 =?utf-8?B?c2swdHI2SXN5SlUveGhLUksvSFJsaS9kSU03RkZLMXJ2am1tTjMxT2pUdHhG?=
 =?utf-8?B?eUE5ckh0Q3VpMVJQQm1Ga1Y3Z0Z3S0ptMXhvVjlyL3hGcGoyWTU5NFNGUzB1?=
 =?utf-8?B?M3NES2xBT0I0RVlhYVVjMXBTNk9LZGNzek5JRDFUNHlyZzF2QURFVEJDU3da?=
 =?utf-8?B?UHNrRTJMdW1TK1ZDc3ZhdlROdWZzblhjYVpaZGwwL210Tmx0bld2eFd4Qyta?=
 =?utf-8?B?WEdFR1E3UVlQbXhNOHRBMWhMWTFXM200YWRiL3drK1RGaUdvT3RzYnlNUlZw?=
 =?utf-8?B?OEJ2cWNHaW1TcDBBVXVXcWZNWC9LbVpreW1HSE9kN2Jsb2N4QTZXbXAyMFIx?=
 =?utf-8?B?aVVRZ3JKclBLakFPVDlKZkdPRy84WUFkNWpDT1RpbFlPcnVUYlBxSnRZZ3pr?=
 =?utf-8?B?ZURjYys5UkpCNFpTa1ZoeGQzN3d4WWtqM2JYek4vZk82anIzaW9YbVRIc2h1?=
 =?utf-8?B?Z0dBd3daSnQ4WjFlTWE5KzZCQ25TREp4MEFZdGN2emVxaENWaDFwSTRPVWd4?=
 =?utf-8?B?WWtiU1hURGRrVEtFUE5YMzJxQmlMRUI0bXFQbHNnYUpJc0VZMndZeEpWWHhV?=
 =?utf-8?B?Qk9RMFhaMUUzOW01RWZ4Y2ZQU2tmclRTeEhRVERMUThlMmtXSHdaRXNSRmIr?=
 =?utf-8?B?UVNDbEZiWFd1VTFSVSs0MHNpbExDOUpjRFl3Y2RYZ29Fa0hTSUtJMGxwRDR6?=
 =?utf-8?B?L3gxdzZGTUo4TDFYRVE4NkxoRGswdTZmbnBkY3E3N0RpWUVnalB2dFRzbmY1?=
 =?utf-8?B?dy9HSytFUGY3cVczUnJ5cVlXTkdESEtOaWxNNVIzQ3orVGZOanBZWTQ2eFNH?=
 =?utf-8?B?Y3dVS2ZTTGlISG84emFNaU9iMXU0T2wwazZMSExrellsV2MwY0taR3JOS0JN?=
 =?utf-8?B?N3JSVXZoZEdmYWJWbUpVc0ExZGhxU3dUZW0zdm5VbExkajFGMTVscXI0a0JU?=
 =?utf-8?B?bEtFWjlrVi9Yc2VDVk9SdWhWcDRacGVWVTdMSGVEODlIbGJzS1ZGekFTeHVV?=
 =?utf-8?B?WTZNTHdCMjRoWUc3VnR0QWxMSUsyK2o0YnRPMitGNFEzM0pYcHBEdzJYeDYz?=
 =?utf-8?B?Y1liOG43MGdvYTZzdVREYS8vQnRZN3BXdDBjc1RFalNjbC9OZy9lajlhMjUv?=
 =?utf-8?B?MEZ6UVBsWU9GSDF0R0pJdS95MkRCNmdwdksvYWh6VGZZa0N4c3p4RVRPTC9l?=
 =?utf-8?B?Q0s0WnZlQXVnclpGam1Bby9pMEpVRERMK2ZMY3NIY3FEalA3UEtmdWdKdnd2?=
 =?utf-8?B?WVU3M2JwRnB6TUhqVU5EYnJGNzRjNUFhcUN2SDF4SGF4UUpkMjBGOVJkYkZm?=
 =?utf-8?B?Y0VlMi92ZndYR0QzLytZekNYTUNlMmFWdERnTk16U3krWEhTQmUvMWdNMndh?=
 =?utf-8?B?SEg0T0N2bG1qSjJLbkxwUTZLSjB3Q1ErdmYrbFpML2YwRkFhK3RRTlVKTHVE?=
 =?utf-8?B?RVgwUWFMVXl6L1M0eUpMeC9EblFEOWV5dHk2NVVMVDVva3dxYjVUOE5KZUdt?=
 =?utf-8?B?aE93M1o0SG03V1BHOTFubXplWTBTK2ZEemNMbnJ1bnNRMUZIUERha1pMNHVm?=
 =?utf-8?B?S2Fabm9vZzcxQjFKcmljOHB3cFU0dWp6NnU1RzhaV2JVTnhwU016YU9DMkx6?=
 =?utf-8?B?czFlcU9Wd3JqWkNBcyt1cy8wS0JZcGVJYXZOcUM5eUNDc1pVN0tlbFhsRmg0?=
 =?utf-8?B?NjY2Ukt4STdwK2hBRE92ZnI3b1cxaUZPUElRckd1Q2dXZjdiRUtRSERqT2Qr?=
 =?utf-8?B?Um5weDRIMXdCK2REKzJoR25rbkxwb1hyVmxBN3g5UDRHRjkxZ2ZwUFE3d2Fi?=
 =?utf-8?B?R2RlNDd6Q0p6T09YbURKTzdmckx2RnpPNEpRR3Y5ZDdTUGJ3b2dBWWJYcEVt?=
 =?utf-8?Q?H6M01mAqU0uIAtzau5mvGG2fL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c740a09-ed2b-4d6e-87fb-08de1d40ab4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 14:27:52.1997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6KpQfHMQa1GdMVIldCmjiWYcFHZShmT/ovw19ksuAJWkEf9nMvp/oF66210h/3vrSxQa18crqbUwYhmpzsvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNiBOb3ZlbWJlciAyMDI1IDEzOjU2DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBo
aXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAzMS8zMl0gdmZpbzogU3ludGhl
c2l6ZSB2UEFTSUQgY2FwYWJpbGl0eSB0byBWTQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVy
LA0KPiBPbiAxMC8zMS8yNSAxMTo1MCBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBG
cm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPg0KPiA+IElmIHVzZXIgd2FudHMg
dG8gZXhwb3NlIFBBU0lEIGNhcGFiaWxpdHkgaW4gdklPTU1VLCB0aGVuIFZGSU8gd291bGQgYWxz
bw0KPiBuZWVkIHRvIHJlcG9ydD8NCj4gPiByZXBvcnQgdGhlIFBBU0lEIGNhcCBmb3IgdGhpcyBk
ZXZpY2UgaWYgdGhlIHVuZGVybHlpbmcgaGFyZHdhcmUgc3VwcG9ydHMNCj4gPiBpdCBhcyB3ZWxs
Lg0KPiA+DQo+ID4gQXMgYSBzdGFydCwgdGhpcyBjaG9vc2VzIHRvIHB1dCB0aGUgdlBBU0lEIGNh
cCBpbiB0aGUgbGFzdCA4IGJ5dGVzIG9mIHRoZQ0KPiA+IHZjb25maWcgc3BhY2UuIFRoaXMgaXMg
YSBjaG9pY2UgaW4gdGhlIGdvb2QgaG9wZSBvZiBubyBjb25mbGljdCB3aXRoIGFueQ0KPiA+IGV4
aXN0aW5nIGNhcCBvciBoaWRkZW4gcmVnaXN0ZXJzLiBGb3IgdGhlIGRldmljZXMgdGhhdCBoYXMg
aGlkZGVuIHJlZ2lzdGVycywNCj4gPiB1c2VyIHNob3VsZCBmaWd1cmUgb3V0IGEgcHJvcGVyIG9m
ZnNldCBmb3IgdGhlIHZQQVNJRCBjYXAuIFRoaXMgbWF5IHJlcXVpcmUNCj4gPiBhbiBvcHRpb24g
Zm9yIHVzZXIgdG8gY29uZmlnIGl0LiBIZXJlIHdlIGxlYXZlIGl0IGFzIGEgZnV0dXJlIGV4dGVu
c2lvbi4NCj4gPiBUaGVyZSBhcmUgbW9yZSBkaXNjdXNzaW9ucyBvbiB0aGUgbWVjaGFuaXNtIG9m
IGZpbmRpbmcgdGhlIHByb3BlciBvZmZzZXQuDQo+ID4NCj4gPg0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9rdm0vQk45UFIxMU1CNTI3NjMxODk2OUEyMTJBRDA2NDlDN0JFOEMNCj4gQkUyQEJO
OVBSMTFNQjUyNzYubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8NCj4gPg0KPiA+IFNpbmNlIHdl
IGFkZCBhIGNoZWNrIHRvIGVuc3VyZSB0aGUgdklPTU1VIHN1cHBvcnRzIFBBU0lELCBvbmx5IGRl
dmljZXMNCj4gPiB1bmRlciB0aG9zZSB2SU9NTVVzIGNhbiBzeW50aGVzaXplIHRoZSB2UEFTSUQg
Y2FwYWJpbGl0eS4gVGhpcyBnaXZlcw0KPiA+IHVzZXJzIGNvbnRyb2wgb3ZlciB3aGljaCBkZXZp
Y2VzIGV4cG9zZSB2UEFTSUQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90
aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L3ZmaW8vcGNpLmMgICAgICB8IDM3
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9ody9p
b21tdS5oIHwgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPiA+IGlu
ZGV4IDA2YjA2YWZjMmIuLjIwNTRlYWM4OTcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9wY2ku
Yw0KPiA+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4gPiBAQCAtMjQsNiArMjQsNyBAQA0KPiA+ICAj
aW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgImh3L2h3LmgiDQo+ID4g
KyNpbmNsdWRlICJody9pb21tdS5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvcGNpL21zaS5oIg0KPiA+
ICAjaW5jbHVkZSAiaHcvcGNpL21zaXguaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJp
ZGdlLmgiDQo+ID4gQEAgLTI1MDAsNyArMjUwMSwxMiBAQCBzdGF0aWMgaW50IHZmaW9fc2V0dXBf
cmViYXJfZWNhcChWRklPUENJRGV2aWNlDQo+ICp2ZGV2LCB1aW50MTZfdCBwb3MpDQo+ID4NCj4g
PiAgc3RhdGljIHZvaWQgdmZpb19hZGRfZXh0X2NhcChWRklPUENJRGV2aWNlICp2ZGV2KQ0KPiA+
ICB7DQo+ID4gKyAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2QgPSB2ZGV2LT52YmFzZWRldi5oaW9k
Ow0KPiA+ICsgICAgSG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2RjID0NCj4gSE9TVF9JT01NVV9E
RVZJQ0VfR0VUX0NMQVNTKGhpb2QpOw0KPiA+ICAgICAgUENJRGV2aWNlICpwZGV2ID0gUENJX0RF
VklDRSh2ZGV2KTsNCj4gPiArICAgIHVpbnQ2NF90IG1heF9wYXNpZF9sb2cyID0gMDsNCj4gPiAr
ICAgIGJvb2wgcGFzaWRfY2FwX2FkZGVkID0gZmFsc2U7DQo+ID4gKyAgICB1aW50NjRfdCBod19j
YXBzOw0KPiA+ICAgICAgdWludDMyX3QgaGVhZGVyOw0KPiA+ICAgICAgdWludDE2X3QgY2FwX2lk
LCBuZXh0LCBzaXplOw0KPiA+ICAgICAgdWludDhfdCBjYXBfdmVyOw0KPiA+IEBAIC0yNTc4LDEy
ICsyNTg0LDQzIEBAIHN0YXRpYyB2b2lkIHZmaW9fYWRkX2V4dF9jYXAoVkZJT1BDSURldmljZQ0K
PiAqdmRldikNCj4gPiAgICAgICAgICAgICAgICAgIHBjaWVfYWRkX2NhcGFiaWxpdHkocGRldiwg
Y2FwX2lkLCBjYXBfdmVyLCBuZXh0LCBzaXplKTsNCj4gPiAgICAgICAgICAgICAgfQ0KPiA+ICAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICBjYXNlIFBDSV9FWFRfQ0FQX0lEX1BBU0lE
Og0KPiA+ICsgICAgICAgICAgICAgcGFzaWRfY2FwX2FkZGVkID0gdHJ1ZTsNCj4gPiArICAgICAg
ICAgICAgIC8qIGZhbGx0aHJvdWdoICovDQo+ID4gICAgICAgICAgZGVmYXVsdDoNCj4gPiAgICAg
ICAgICAgICAgcGNpZV9hZGRfY2FwYWJpbGl0eShwZGV2LCBjYXBfaWQsIGNhcF92ZXIsIG5leHQs
IHNpemUpOw0KPiA+ICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gKyNpZmRl
ZiBDT05GSUdfSU9NTVVGRA0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIEFsdGhvdWdoIHdlIGNo
ZWNrIGZvciBQQ0lfRVhUX0NBUF9JRF9QQVNJRCBhYm92ZSwgdGhlIExpbnV4IFZGSU8NCj4gPiAr
ICAgICAqIGZyYW1ld29yayBjdXJyZW50bHkgaGlkZXMgdGhpcyBjYXBhYmlsaXR5LiBUcnkgdG8g
cmV0cmlldmUgaXQNCj4gPiArICAgICAqIHRocm91Z2ggYWx0ZXJuYXRpdmUga2VybmVsIGludGVy
ZmFjZXMgKGUuZy4gSU9NTVVGRCBBUElzKS4NCj4gSSBkb24ndCBjYXRjaCB0aGlzIHNlbnRlbmNl
IC4gV2hlbiBhcmUgeW91IHN1cHBvc2VkIHRvIHJlYWQgYWJvdmUNCj4gUENJX0VYVF9DQVBfSURf
UEFTSUQgY2FwIGlkIHRoZW4/DQoNClRoYXTigJlzIHRvIG1ha2UgaXQgZnV0dXJlIHByb29mIGlu
IGNhc2UgVkZJTyByZWxheGVzIHRoYXQuICBJZiB0aGF0IGhhcHBlbnMNCnRoZSBjb2RlIGFib3Zl
IGJ5IGRlZmF1bHQsIHdpbGwgYWRkIHRoZSBDQVAgYW5kIHdlIG1heSBlbmQgd2l0aCBhDQpkdXBs
aWNhdGUgYXQgYmVsb3cgb2Zmc2V0Lg0KDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGlmICghcGFz
aWRfY2FwX2FkZGVkICYmIGhpb2RjLT5nZXRfY2FwKSB7DQo+ID4gKyAgICAgICAgaGlvZGMtPmdl
dF9jYXAoaGlvZCwgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0dFTkVSSUNfSFcsDQo+ICZod19jYXBz
LCBOVUxMKTsNCj4gPiArICAgICAgICBoaW9kYy0+Z2V0X2NhcChoaW9kLCBIT1NUX0lPTU1VX0RF
VklDRV9DQVBfTUFYX1BBU0lEX0xPRzIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJm1h
eF9wYXNpZF9sb2cyLCBOVUxMKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+
ICsgICAgICogSWYgc3VwcG9ydGVkLCBhZGRzIHRoZSBQQVNJRCBjYXBhYmlsaXR5IGluIHRoZSBl
bmQgb2YgdGhlIFBDSWUgY29uZmlnDQo+ID4gKyAgICAgKiBzcGFjZS4gVE9ETzogQWRkIG9wdGlv
biBmb3IgZW5hYmxpbmcgcGFzaWQgYXQgYSBzYWZlIG9mZnNldC4NCj4gPiArICAgICAqLw0KPiA+
ICsgICAgaWYgKG1heF9wYXNpZF9sb2cyICYmIChwY2lfZGV2aWNlX2dldF92aW9tbXVfZmxhZ3Mo
cGRldikgJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBWSU9NTVVfRkxBR19QQVNJ
RF9TVVBQT1JURUQpKSB7DQo+ID4gKyAgICAgICAgYm9vbCBleGVjX3Blcm0gPSAoaHdfY2FwcyAm
IElPTU1VX0hXX0NBUF9QQ0lfUEFTSURfRVhFQykgPw0KPiB0cnVlIDogZmFsc2U7DQo+IGNhbid0
IHlvdSBkaXJlY3Qgc2V0IGV4ZWNfcGVybSA9IChod19jYXBzICYNCj4gSU9NTVVfSFdfQ0FQX1BD
SV9QQVNJRF9FWEVDKTsNCg0KVHJ1ZSDwn5iKDQoNClRoYW5rcywNClNoYW1lZXINCg==

