Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B396C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 01:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWmiu-00046y-Ta; Tue, 01 Jul 2025 21:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uWmis-00046F-KO; Tue, 01 Jul 2025 21:57:18 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uWmip-0001gs-M8; Tue, 01 Jul 2025 21:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZfRZLuDc6lHUZZTkz4Zcl23lUpV/zMujkJObuxJ4Q2yZ/QayBbbAdSrpQeS9fnVDFC6+pZ+dZffFNIM2pei0D0eH6Z7Rh+SyWAUk68s6YDt2hISqklOUyHBNdfDqrbxnT4vOAJxB+PDLWFUN1aZdCtOYMYx0iOzBSYpABiAy6M5PuDGVQahTnj2hfjMMuAjKi/t2Dzj2cL2VYih8p4OFimqF4gRR9JY0f2Tc6vkG3f+ue16Gj3O/GYMMxRb7CjzhU/QkSYK/2ZYN0SqEmT1xNjwSZbsHJ8eTz1LanLIYbwBYMCCMkOzZmHl2n5CphJgeNFI+dj6CXR9ol5mGDMJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIyLTsmB1ffE/r5fnOlFk2+RqTWUY7NN4xg2QwvZZ+U=;
 b=M3JxK9/ty9ygvJWS0mtJdgmt1G8UJb/1oUfZKi0Hhb+GIQ4t6tLeqKrB/ijv+Ck49oZ1CFfM3D5uiK/AG4LM2sbPpOaqwTuDBqqxJonmiaEUepSzvKdF8FD0ABookNeNVpr0UaRidAfy0MOfgh3e4aLrlsf+lNorubMWyI+JcwuyW79FbrwkRf3z1dLQQZou+sEsSAp2NEVDOozVC7ibNhSD5jdH5s/NnKJYoacDodwq5nPOV/gYC0azeUENQlYYjHoWtFbpPc5fo/S95lv2A73oC2QFNVZZp1uyeDFwFERsCPdWQmN/D3Ae7sWal/6Ipay26WVAS815nEpEx5hOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIyLTsmB1ffE/r5fnOlFk2+RqTWUY7NN4xg2QwvZZ+U=;
 b=BdVoRVKG10yT/iXmKqwbljNYyjX0PBwQq9QMTkUS57J5CP+50HVoNIOv7kknvUYygyJ4gHt/XF4NTHk86tXjXTT6Z8wG9YJO+4frw8Q275wn9NVAcyDLoqmNUYbeK2OAkJDATwOvJwI+i0KAZ/YW1KYw2xBZ87QDbbbhAe4vWn2ir02G6zDMkjtpWw2yeOV702qLXWirhPK5HDCoDkRIaVMGiVuSFBnSPmMKM6SEyE8yy/K40db2lvgDercHiS8qIRxk+dQyP06qGNZUIvLa5z9u5QrYcz1AG1rnpsuRD5FLUZnES8GaIQAjbgnwukArl/13J2QlItxQNr+TSG2xJQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 OSQPR06MB7279.apcprd06.prod.outlook.com (2603:1096:604:294::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Wed, 2 Jul 2025 01:57:05 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 01:57:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 00/18] Support AST2700 A1
Thread-Topic: [PATCH v1 00/18] Support AST2700 A1
Thread-Index: AQHba9K4uIwzG6e2E0KIgXebc6jl4LMwjV2AgOyWFICAAeBlEA==
Date: Wed, 2 Jul 2025 01:57:04 +0000
Message-ID: <SI2PR06MB504195531936785FFA2CA4BDFC40A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <096e8152-ec19-4b2b-aa56-dd566ce7bb6d@kaod.org>
 <9534dc4d-fdf6-418d-b5f7-9bc7f03bf7ec@kaod.org>
In-Reply-To: <9534dc4d-fdf6-418d-b5f7-9bc7f03bf7ec@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|OSQPR06MB7279:EE_
x-ms-office365-filtering-correlation-id: 9e91a3e1-d541-44aa-f746-08ddb90bbead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nll2aURqSS9VYkNpZWhwYk95cE0yNXNrZ3NYVkk1dlRNUjg2Ym1MckNyZ1Ez?=
 =?utf-8?B?cnduRDdwRVZOaVprZmQ4YjJ6SVNvdmx5eUxJc2xLbFRzY0c1ZTg2WnplSUVk?=
 =?utf-8?B?U2hkRnBEOGorSXNWdTZhUnl3L3BUdDFRZ2NWbDBabFpvQ1M2Q1M5LzdHS3dF?=
 =?utf-8?B?M3dSeUJCMmRyeEJrVkpLYm0xVVlqOExGbkFYN0dVOU9LK0pFdEtnNEJXTXdq?=
 =?utf-8?B?WlFKRnFoWFpQdXRidEdqVVFWTXN0NDEzMFdTVDE0TGdmRnRMbUJwdndBNUpZ?=
 =?utf-8?B?SHVZWTVnQmRmbWFRdFdFVjhyZm9RL3FwREorNWVhTjM1eVFwY1RqVTJhZEI2?=
 =?utf-8?B?RldZTHpVL3VXZ1RuOE9OUmJJZ3Bac2pwNGNKSWJCT0VaamJUN0pMUWZ3L0tZ?=
 =?utf-8?B?aXNTTy92WGtQdFhLblB5d1FFcXVYUjdkY09iWnh2QzBidTJkV2wzeVorYjhy?=
 =?utf-8?B?cE84MXluTW1mcDNQSTYrclJ0cXgrVSt2RmdNS3pFU1BCTGxTenJNU1hIR2tm?=
 =?utf-8?B?R0RyUmo0OUJHQ1NqQjU5eXQzTXF1N0lDWDlUZ3htNHNtWFc4UEo0OVFMQmVX?=
 =?utf-8?B?UVdFb3BsUGFPTEN4R3gwVjR1U3Nud1pxaFpNeTFHcSt5REZJOXFVeE9ESlVw?=
 =?utf-8?B?Y0gwNE4zTTlMcmZjVHdXS240SncyMTB5cG42c3N2VUgyTXpHdUdmY1R2bXJw?=
 =?utf-8?B?eVR6eGZ2N0dDWWY3TTUvZHk4MmY2RWZVczBncml2aHZNVjJVQ0V6dEJ0QllU?=
 =?utf-8?B?N1A2YzdPZzFsQTQwdDE3TStwY1l1Mm1lVkhKQ1RDT3VxSFFPNTByTXlUTVc4?=
 =?utf-8?B?MzJjQWJWaXJWcXMzM3JMZmYxRTIzdmowSEVmWU9BcEE4VzE2YlpGckRsYzBt?=
 =?utf-8?B?enNScVRtd3hZdXJiWUFwVFVBSFNEcFlPcW01QzRKTEYvWUFPUytiaVhNN0pB?=
 =?utf-8?B?VjlJZWJWVXluNlRUTUNaUVBMWjFDV1lmKzBzVThXcEVweWZ1YU1GbnRhajJE?=
 =?utf-8?B?SXZHUzZUOSswWXVQK1NGV2NDNUQwWlo4L1BVK0wreG1Kb3lyN1VaKzRPQlBq?=
 =?utf-8?B?eXg0cEpjcGp6YTNWdjhVR3pyZlI2Szg3bFJhSVdnanltd21URlF5azF3Rklk?=
 =?utf-8?B?UkZZRlg0QXozQ1lwY0QxK2M0bWhKM0ZFUURMeWFHSzJGRS83eVJtdk9HMGQw?=
 =?utf-8?B?L3I5OHdDT3h5cGpxSVBHTjhNN1k3cXJ0RitKeFZyekFmNFlVOTNsV0hMNXdG?=
 =?utf-8?B?cnZnK0M3MER5NityMC9lTlJNeXRKQ3cyWlVRRkVIMFdTVWxFRG9iT1BHMlRh?=
 =?utf-8?B?SXNxdDVweStuZHVvMDVYVVZicnlocXN0SjhVQzdjdVppcndjUldmeWsvZ0M4?=
 =?utf-8?B?M0VjWHpWR0Y4bUZUNDRvRWVpWktwTUNyYTc2UGQvdkNnNFRvYzRQbDAzSmdS?=
 =?utf-8?B?WkJONjNYSnRKME8yYjJWZmxKYW54b0dvakVCTGhZMEdMYVNWZVVUVXZPR2cz?=
 =?utf-8?B?Y01Gd240NWtUbXJZN3VzczlWenh1WXBrVW5OcVk4NFh3YTFSVDhScWFMbWph?=
 =?utf-8?B?UnFvcXVoME5VL2dZRkpJdTNYT0cyWk1XUjdJdE9sdG5BWW1VYTVQUWtFaSts?=
 =?utf-8?B?Tlg5UVhqSE1EY1VpM0N4UTYyQmpKK2VJSzh5bGFrQ0pXdEo3SW9ZUVYyOWhw?=
 =?utf-8?B?b252VU0wbFBXdXE0Z29HdXduWXJaMTVFeFl0OU5BcWJ6SlcxM1FTdndXSkRO?=
 =?utf-8?B?cjZmR2VINmlvWEZhNC93aEJIbVVkb04rb1ovYmR1aFhHRkFmcFNTOVB4emZy?=
 =?utf-8?B?Mkh2NVBHbC9aUHdqOXJadFFmWEk1UUM1bzVqVnk2UlErUDA5T1BjRUxPb1Vw?=
 =?utf-8?B?VkxKU0gwdHo2RkZndnJiTDlxU3kvMG1jUjloWDRZSEFqT2hWWGkxWTFCMGpx?=
 =?utf-8?B?MzVxMTNjSzREMTI2TlFIRmhYV3JpOEduL2N6VnB5YjRheFVKS3NyRW4rYjZk?=
 =?utf-8?Q?dh5IS6H2v0r7JH76mgh1ylyNhLG84I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzZjWFB3a2JnM3pPTzZSU2hMZ2hUc2RyUHhtUy9reUZGcStzVlFEM203aXVC?=
 =?utf-8?B?TW15RjFkelVkSkNWejZBZ3dmaVI3cE9ZVDZOdjFZUWF3U2NKZUJTNHh5UExF?=
 =?utf-8?B?eXFtSXh4ZldBcjZBQzFFaUN2TGkvRUpPMDNvNWdDQ3VrNklyL1BVS2dVbzg5?=
 =?utf-8?B?N0NpNE1RRHBNMWJ1bXRkRE15dVR0a0lHdnFuOXRRNG9XK3RjZzJybFUvMTdo?=
 =?utf-8?B?V05PblVSM29rcENMUnpwL01zbGhzdWNnNVZEZ0tyalZSZEpWWWN6am5oWC9D?=
 =?utf-8?B?VXRPOS9LT2JDTTFGWUdxYlBLZTBNRlpBMDRVNjRDZlFVZjdNSkxtRnlGQ1lp?=
 =?utf-8?B?NFpzWjMxVkJGcVI1L1FCdG1JMFZyOWVtVGdjU09GYVlxNzB5VnVGU2Z1RUsy?=
 =?utf-8?B?aUJ3bjB1bTVvSmRUdTJVQnlVWloyT3BNNmFpYUk4ZXlvMklKVTAxZHRKVnBR?=
 =?utf-8?B?RXRnLzVYU1NWcTRqbW91alNXODZlYVg5eTN3YkNJSFN5NzhsampGcFRZbWxq?=
 =?utf-8?B?K2J1TTZVTjV5QzVkMGUyVDg3V05HTEhUcHJLd2F0Ky9QVjFBWVgwbFllajVz?=
 =?utf-8?B?VHlyTHFqREJqR0diUzNMOWQvdzhzSXBUbUphc2h3Y0UyYkMwcm0vYktrRkMz?=
 =?utf-8?B?dldFR205dkx2S1Yzb01vUkU5R3lEdXVuTHJsZ3QvZGlDOUNEOUd6ZFA3L1Zp?=
 =?utf-8?B?QnVZK0hIcXhST2Q4MUI0RkRDcDhCNnBVS3hnZlpDelZ4MkMvSVVtMTRqRTZI?=
 =?utf-8?B?T3NLb2RabHFqWEpZNHdLSkpma1FIWnBWbU5BTnZ3RlNUa2VwQUJMM242Q2JE?=
 =?utf-8?B?dk9JZ0ZHRjZyQVhQTkoyL3UzVFIvVmJzYlZyTlMvVXBkTFNXc1JSUWc2UTVB?=
 =?utf-8?B?ZW5rZ3RKZm1ZV0hJVk1sT0JrT1J2Z1hEcHZrRTRhNThadk1vZU1XTjR0enM2?=
 =?utf-8?B?N3NRS1lxZmVwNmpqZWlIZ1RVSDJEc2RUMzBBZnYrT29FdzRPaTRYbmZwM0pF?=
 =?utf-8?B?dVRoNU44dlVBc3doeW9HaGw0RnpuZ0JhS1Z0Z2F6YzYrYjBBQ1BtQVZOL1I3?=
 =?utf-8?B?QW5vSXNzTVIyUmY2MlIwZ3E2UWFMMHZMeW16SlN5Y0NoOGt6T0NRdGExUFlS?=
 =?utf-8?B?cXBLanJpM0tuZWJVVWZ1ZzMzdi95RUlZN2RrMlAyR2cyWmxDUFlXTFZqU0Vp?=
 =?utf-8?B?dTV5aUtVTEVmWUR0S1BndWtNSkQwckk2VmliS3JrVnF0bktyU1dYRjJKZkk2?=
 =?utf-8?B?K1RsdkFreU16ZHpxYmNkQ2hhVklPek8yazBiSmcyN3NTeVdjQ0FuNUMxWWNp?=
 =?utf-8?B?UmRzSVFQNTFGc2J5dDA2ak1GTEgvVFo1b3VXUThmN2Zyclo2MEJ0RzNMUkIz?=
 =?utf-8?B?N1hSeFp1Zk1sVlgrZmlHcWFrNUJZRjhhRnhtVSttZHZlVEM3SU1WV3FtdWp4?=
 =?utf-8?B?dG93UUR4aDJhM1YrbWI2MnVmS2NyNE4yY2hROEIyM0tESHlvWnBRei9YNzc4?=
 =?utf-8?B?bEt0RkxZQUpCWUJCTUhzQjhOY1JvdWJXSWRjS3FpV1ZiZXhBVGF6eHpPR1dh?=
 =?utf-8?B?NnNEMG1ma0F6SFBuN0dhd2hDekJ1TjRMM2ltcmFtRkdMakFnMzRHTW1TOFpR?=
 =?utf-8?B?eG9yYVl3U3YrY1d4Ykgyem5QUmhyVUV2aitMWk4yaGV1T0J3YUkzeXhwYU1h?=
 =?utf-8?B?WTlYdXZKWHQ4SzZZMnhOaXFGYkRqOStFdFVMQk5OblZEQTN5R01rbEJ3R3pk?=
 =?utf-8?B?bFpCQWdIRlNqb1NSWVNhVzJWNnZIQlNHV1ZlSkE4SXF4T1hmaUF4SS8zSE9R?=
 =?utf-8?B?em1lV081Q2FZeFNHTGptODVJd0ViSy9YNHBWU2U5WDJHVFRpbjAzQ2RuWTFD?=
 =?utf-8?B?YmxLL2tEYmZXSExmemRDU0RwK0lvTEJHTFF6VHNqYzE4SXN6OEF5ell6Rmxy?=
 =?utf-8?B?Z2NTTGNCN0wzTmNPUTZaUGdVM1NtczRuY0srZlZlTit4YU9mazJMRWNCL2hL?=
 =?utf-8?B?dFNhTWhocmJUZEdJTHp1Sm16UnhKYnduVkM2V0RyWGtCUnNuY0E5MDgzN0w0?=
 =?utf-8?B?eElpVGRoYlRVU0RLWVNrT0lib2dUK2p1SHE2K3o2aGhJaENqaSttQlFJK2lI?=
 =?utf-8?Q?Ui6bxi+Fa4ObXyCUpZrx78jgQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e91a3e1-d541-44aa-f746-08ddb90bbead
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 01:57:05.0733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/S4B+83pLLQASgD7rRIjrsfLj2NBoAoDgnT3ttKI8CG1VjzXh/OUFKAVFx8E5h9CEaDyHmdQthvP1SnySMTylka+tz0JzVJbdSX+UOyBoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7279
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDAvMThdIFN1cHBvcnQgQVNU
MjcwMCBBMQ0KPiANCj4gSGksDQo+IA0KPiBPbiAxLzMxLzI1IDA4OjM0LCBDw6lkcmljIExlIEdv
YXRlciB3cm90ZToNCj4gPiBIZWxsbyBKYW1pbiwNCj4gPg0KPiA+IE9uIDEvMjEvMjUgMDg6MDQs
IEphbWluIExpbiB3cm90ZToNCj4gPj4gdjE6DQo+ID4+IMKgIDEuIFJlZmFjdG9yIElOVEMgbW9k
ZWwgdG8gc3VwcG9ydCBib3RoIElOVEMwIGFuZCBJTlRDMS4NCj4gPj4gwqAgMi4gU3VwcG9ydCBB
U1QyNzAwIEExLg0KPiA+PiDCoCAzLiBDcmVhdGUgYXN0MjcwMGEwLWV2YiBtYWNoaW5lLg0KPiA+
PiBXaXRoIHRoZSBwYXRjaCBhcHBsaWVkLCBRRU1VIG5vdyBzdXBwb3J0cyB0d28gbWFjaGluZXMg
Zm9yIHJ1bm5pbmcNCj4gQVNUMjcwMCBTb0NzOg0KPiA+PiBhc3QyNzAwYTAtZXZiOiBEZXNpZ25l
ZCBmb3IgQVNUMjcwMCBBMA0KPiA+PiBhc3QyNzAwLWV2YjogRGVzaWduZWQgZm9yIEFTVDI3MDAg
QTENCj4gPg0KPiA+IExldCdzIGRvIHRoYXQgcHJvZ3Jlc3NpdmVseSwgcGxlYXNlIGFkZCBhIG5l
dyBhc3QyNzAwYTEtZXZiIG1hY2hpbmUNCj4gPiB0b28gYW5kIGEgbWFjaGluZSBhbGlhcyBvbiBh
c3QyNzAwYTAtZXZiLiBUaGVuIHdlIHdpbGwgY2hhbmdlIHRoZQ0KPiA+IGFsaWFzIG9uIHRoZSBu
ZXdlciBTb0MuDQo+IA0KPiANCj4gU28sIG1hY2hpbmUgJ2FzdDI3MDBhMS1ldmInIHdhcyBhZGRl
ZCBpbiBRRU1VIDEwLjAuMCA6DQo+IA0KPiAgICA0OThjNTE5ZWI3NzYgImh3L2FybS9hc3BlZWQ6
IEFkZCBNYWNoaW5lIFN1cHBvcnQgZm9yIEFTVDI3MDAgQTEiDQo+IA0KPiBhbmQgbWFjaGluZSAn
YXN0MjcwMGEwLWV2YicgaW4gUUVNVSA5LjEuMDoNCj4gDQo+ICAgIDkyNzA3OTkyMTAzZSAiYXNw
ZWVkOiBBZGQgYW4gQVNUMjcwMCBldmFsIGJvYXJkIg0KPiANCj4gYW5kLCBjdXJyZW50bHksIG1h
Y2hpbmUgJ2FzdDI3MDAtZXZiJyBpcyBhbiBhbGlhcyBvZiAnYXN0MjcwMGEwLWV2YicgOg0KPiAN
Cj4gICAgJCAuL2J1aWxkL3FlbXUtc3lzdGVtLWFhcmNoNjQgLU0gPyAgfCBncmVwIEFTVDI3MDAN
Cj4gICAgYXN0MjcwMC1ldmIgICAgICAgICAgQXNwZWVkIEFTVDI3MDAgQTAgRVZCIChDb3J0ZXgt
QTM1KSAoYWxpYXMgb2YNCj4gYXN0MjcwMGEwLWV2YikNCj4gICAgYXN0MjcwMGEwLWV2YiAgICAg
ICAgQXNwZWVkIEFTVDI3MDAgQTAgRVZCIChDb3J0ZXgtQTM1KQ0KPiAgICBhc3QyNzAwYTEtZXZi
ICAgICAgICBBc3BlZWQgQVNUMjcwMCBBMSBFVkIgKENvcnRleC1BMzUpDQo+IA0KPiBTaG91bGQg
d2Ugc3dpdGNoIHRoZSBhbGlhcyB0byBwb2ludCB0byAnYXN0MjcwMGExLWV2YicgaW4gUUVNVSAx
MC4xLjAgPw0KPiBhbmQgZGVwcmVjYXRlIHRoZSBBMCBTb0MgYW5kIG1hY2hpbmUgaWYgaXQgaXMg
bm8gbG9uZ2VyIHBsYW5uZWQgdG8gc3VwcG9ydA0KPiB0aGVtLg0KPiANCg0KU29ycnkgZm9yIHRo
ZSBsYXRlIHJlcGx5IGFuZCBkZWxheSBpbiBwcm9jZXNzaW5nIHRoaXMgdGFzay4NCknigJl2ZSBi
ZWVuIHBvc3Rwb25pbmcgdGhpcyBiZWNhdXNlIG91ciBjdXN0b21lcnMgZG8gbm90IGhhdmUgIkFT
VDI3MDAgQTEgRVZCIi4NClNpbmNlIEFTUEVFRCBTREsgaGFzIGRyb3BwZWQgc3VwcG9ydCBmb3Ig
QVNUMjcwMCBBMCBhcyBvZiB2ZXJzaW9uICJ2MDkuMDciLCBJIGJlbGlldmUgaXQncyBub3cgYXBw
cm9wcmlhdGUgdG8gcmVtb3ZlIEFTVDI3MDAgQTAgc3VwcG9ydCBpbiBRRU1VLg0KaHR0cHM6Ly9n
aXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvdGFnL3YwOS4wNw0KSW4g
YWRkaXRpb24sIEkgcGxhbiB0byBtYWtlIGFzdDI3MDAtZXZiIGFuIGFsaWFzIG9mIGFzdDI3MDBh
MS1ldmIuDQoNCkN1cnJlbnRseSwgSeKAmW0gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCB0aGUgcHJv
cGVyIHByb2NlZHVyZSB0byBkZXByZWNhdGUgYW4gZXhpc3RpbmcgbWFjaGluZSBpbiBRRU1VLCBi
dXQgdGhlIGZvbGxvd2luZyBpcyBteSBpbml0aWFsIHBsYW4gZm9yIGhhbmRsaW5nIHRoaXMgdGFz
azoNClBBVENIIDE6IFVwZGF0ZSB0aGUgYXN0MjcwMC1ldmIgYWxpYXMgdG8gcG9pbnQgdG8gYXN0
MjcwMGExLWV2YiBhbmQgcmVtb3ZlIEFTVDI3MDAgQTAgZnVuY3Rpb25hbCB0ZXN0cy4NClBBVENI
IDI6IFJlbW92ZSB0aGUgQVNUMjcwMCBBMCBTb0MgYW5kIGFzdDI3MDBhMC1ldmIgbWFjaGluZSBp
bXBsZW1lbnRhdGlvbi4NClBBVENIIDM6IChRdWVzdGlvbikgU2hvdWxkIEkgdXBkYXRlIHRoZSBk
b2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0IGZpbGUgYXMgd2VsbD8NClRoYW5rcy1KYW1pbg0KDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo=

