Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D5CAC597
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 02:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyLn7-0002e6-Ui; Mon, 15 Sep 2025 22:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyLn4-0002bs-Bc; Mon, 15 Sep 2025 22:51:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyLn0-0001Kd-5E; Mon, 15 Sep 2025 22:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE5mCbQg1mskzoBR8f5RX+y8jo84HFrRxQsQmeqdpBmjoZFdeAriNJ+1u3JF8e8PyH8AjweLIrAZWoh3xjMAUdPWXxbsgPiuVoGHkpKYKDddmXPgOpXZSD3WSJt5JIcayXnsXDd+hheWXPrWiW0IB+pS/1SG978YmjTI19b+4mwVdBQd//B/r1S7cvpmFfNBDa6nkanmtjzeJCCblvltrV9aFmFUSd2ZhGbaw3CdJ04KvSkyXVEGacGRdSMieloStvKX/u9CuE7lFDf6D081LP3K4pzh8lCMx91KFTmTO9sajHmPJuaQtKngEhPS686Ulcg8mIRtqR0LZMCY6WUvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbk0O3dpmWZFIOrKUQ4rAKr18DWcS9dMq6GpjnYuQds=;
 b=SkQFptpMaTLrjN9/PWf5fe741lFpTb22DgALG28qTfASMSzKPxdioiUtvWlMHEdJArjgWgfXJKiMkCAfGbNFNONATcsougNK2D0dvc4XaDNT1tbC05VmEcomfa5CBZCDUUpPDOg3snXsxAbnMdAeKSAjZ3E1JX7R6cL6Z9Z76sSe1xy6qK4cpiFedMlyo4wVK7LOGAqW288qLyzdxN21GLZmiBGWkBkropiuc8cq/iWUUFBjPeUuNoI2sJkXe8fLwJFC+0XERcxm/VSJqsfb32Bo0CMOYSjLaj5WCs1PQK5hmU/WLI631CzfJ+zhw3xhvnHldohtRuT3BLNajhoXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbk0O3dpmWZFIOrKUQ4rAKr18DWcS9dMq6GpjnYuQds=;
 b=iv1lMzqIfTKbmIi7S6azjyZTxV+XIHAU+hbiziy4wo8+k7LKTHnGYG04lF/zz/j1RlCeMmuK6HsnRG6q5BD8E+Vj5VCcV5eAXxloZOcer2ZpJL3TqACp3sXoFPOfK2L5Kgl8qUHOIf/mX7WQ4GaH1dm6y1RdhC9BSE9dkTwhwvK4OceV6sE23vrHbrTgNuwiM51b7R1Lv9BKW2DdAfkS9E9hVfme6Dxbq6fEsniBoZ20pikwSexpEDe/bDtpuQM40ALx6odJkzBVwbT639XgJlbqsrlAcVGkmxf1xN5q3eJW+A4bURorzv1e5ssUaGO7V3YyiJBR5Juhax2SqniWRA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6748.apcprd06.prod.outlook.com (2603:1096:400:464::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 02:51:19 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 02:51:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v2 05/14] hw/pci-host/aspeed: Add AST2600 PCIe Root
 Port and make address configurable
Thread-Topic: [SPAM] [PATCH v2 05/14] hw/pci-host/aspeed: Add AST2600 PCIe
 Root Port and make address configurable
Thread-Index: AQHcIu0wvL9En7YYXUuuygbB2pMW8LSUfOEAgACmmiA=
Date: Tue, 16 Sep 2025 02:51:18 +0000
Message-ID: <SI2PR06MB50411ADD84A07224A223B932FC14A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-6-jamin_lin@aspeedtech.com>
 <db7c52d5-d6f0-4478-b6b7-9c45517f0e21@kaod.org>
In-Reply-To: <db7c52d5-d6f0-4478-b6b7-9c45517f0e21@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6748:EE_
x-ms-office365-filtering-correlation-id: 2cfb360d-1106-4b1c-6563-08ddf4cbe96f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?MnRQbmdudGdjeGRYcTVhWG1MZXVteVI0Z1lMc3IwL0dnMmRPSlZuSWVqV3Y0?=
 =?utf-8?B?ZDZ5Z1FCdmhJeTBJeHpjM1hXK3hTTjIycCtTN3JzVVpuRVFJY3psQ0tTRUhB?=
 =?utf-8?B?Y2R4SzJzNXJwdlV1Y0o1V2c2dVhUNHhDZjVUM2ZBczV3SHRMNDhyWjA4end1?=
 =?utf-8?B?SDNoZGJKanlzVEFLdEtrZlFhZkRaTU94SnB6eGN5djJyR3ZaZC9SY1RScWcy?=
 =?utf-8?B?WllLMXdjSWx0TjQ0azhNckFYNEZ0WTFBTnFJbXVyTVl6ZnRZc0pOcnZFNjFY?=
 =?utf-8?B?T2pIdVRvOUtVRDNjNXVLK3VuRWhwTUw0ZWRmZGlEaU9SQWhXandRTGRFWGxY?=
 =?utf-8?B?Ky9pKzk4K1FCZDZWRzFqZ1o3RTI3emUySnRKcnp6ekhuaVgwbDI5dFRaWDVz?=
 =?utf-8?B?SWlCM2cyRG5MeHM3SjEzeVQxVGlrWWFtbURtWGt0MElySVNPMy9NTk1XaTgw?=
 =?utf-8?B?cjNYSi9zeXkydkRFbDBrMC9kU3l0TlZDNWI4WXVJN3hoU3k3dGhFTmZsSUt1?=
 =?utf-8?B?TzBWQW1pMVB2SFo3UGdRV01rQ3k0UUgvRXVZdDhyRGpsQjNKUEJvOXVqOUJw?=
 =?utf-8?B?L3pVY3lFTXhXTFQ4dkw2YUh0cUNrSzF6NjNEaGpvdXMzSHkyd2pReHFnTEtC?=
 =?utf-8?B?Yk1MSlduTlg5d3FnbGJBK3JvOWdhVjJydkk4QmtQc2tseW02NS82WXFhYXky?=
 =?utf-8?B?Yk1JeU5hcEsyV3VWSmY0bUhuZmdFWHY4QWhxSUNyQ0ZkRUt6ank1ZkRtYjlj?=
 =?utf-8?B?eTBMcUtTOW5rYjJ1a2Q5cXBCc3BPaDZyWjR0UXFJYkxkbFQ5dGJBcnBpbkhM?=
 =?utf-8?B?azBxcVNocW1wMmQrM0RPNmpKRTkwS3hNcVBWN2g0TE1ZMHc4T0psQjZjSFc2?=
 =?utf-8?B?aGdNc0t5RE5oTzlTUUlTT016b3JnVGNZMXNjS083emRGUFVEM3p5NkoxQnR5?=
 =?utf-8?B?dS9uUzRkUkVyc0lLSEpMU3FvN3dDSGlCbkh2VlUzV0s5eGhabzFkcmJPODJo?=
 =?utf-8?B?c3htS0FMWGpOQ3BZVXhyelpWQkRXZGxyRURDdGU4WS9YT2ppcnZSSU5NaGlz?=
 =?utf-8?B?MWtNMi9GeFZaTGVxZ01QOE9pNWlzcGc5cWdIWDNsUkJZbDJpb1Z6WTcrS2Fo?=
 =?utf-8?B?YmQxNHRHakZaR0NkUkNGZEMyOTRCTENuWWovUWl0Uzlya1ZwOTUyYjdzNzFx?=
 =?utf-8?B?eXNYSnhYdnFGbmZmTDJmaE1rN2Jza1hibjZMdG8vK210dWQrYy9ubVFraFQ3?=
 =?utf-8?B?YTFHNndUYmRhVmxocVNaRk9SRjN2ZFk1TUlYSXM3a2s2RGlkSjU3Q01oK2tT?=
 =?utf-8?B?ZDZXaWVqdTcvRnZMME1IQ0ZPQWwrUnh0MTgzanNPSjkxWjBnVDlSdkdsbVBJ?=
 =?utf-8?B?Z3J0aXhONElBSU1qdTBEaTA5TVFlaHRLZm1kNklBTmhzNDBqMElTd0VZVGZm?=
 =?utf-8?B?UFJKdFpGUk9VV2RkdG1INlRBdkpEZklZL0g2a2dqditpSVZ1Uit4Z085TFQ4?=
 =?utf-8?B?czF1SWV6dU1SZU8wc29ZblNOalBybmxMRFZLTVNsc0NSMWY2bDBJZzhIVEVW?=
 =?utf-8?B?dVZWdUpoQkpwS3dha2d2WC9sN0JDZ3FRUTA1U2pFb0dJZkdZMlNlMzRaeUVK?=
 =?utf-8?B?aXhibVFhNzlWRlg3d1d6Y2J6TUNCNW5pZVJaTksyQlEvQW1zSW8zRGhGbHNI?=
 =?utf-8?B?VDRUYXJIVXRxTjRjVDVSYUQveHJtQzhBa0E5ZDg5T3I3a1gvU0tib2s5dWo1?=
 =?utf-8?B?dEFuelN1NGJJeXJWcGZPSnQwOFRYRDVCK1J2NVNldXBWNy9LMWt4RzlKSE4r?=
 =?utf-8?B?UG8zSmpJeHNDTTY2L2wvWmxXbS9vT2tCblk5QXJYaE1qMU9iNlFtZzVLeXdz?=
 =?utf-8?B?N2czd3lCU1BmSXVGbW53djBiN29zdTdDeUFZVTM4L1pCNm9zRjdMbGVIMFNH?=
 =?utf-8?B?bTFpZUJnSTlUWUE2MnJzQkk3L1ZRMWdhb1pGUmlONWh0MmFtdS8vcGRhM2lZ?=
 =?utf-8?B?VWlBaVBqTXpvcXdBWWlHQncwb25ieWkrYWFIMzJVR1p5RDc0cC9vWE5HL3FH?=
 =?utf-8?B?WmJETHhZcmdBejNXQmh2Q0tEU05sclRIcW1oUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Smp2RTRoeWZZQ3hoOU41UXRLbVYzaDhXMURyWEFJQWVRaEpWWkF3SHBtcUVM?=
 =?utf-8?B?QlpqbWVEdkhQamdEeDI3NEZLV2V2b2hVUktpQjBDdGpFYndRVElSa2orVDA4?=
 =?utf-8?B?QjE4b0VOazczdVNOenIyNEFLQmJtKzVXMjRkY1R5RE1IcHhGZXl1amZta0dM?=
 =?utf-8?B?M3JnMU5rUHlJSGJyaVZhd2ZMWTAwUE43SUlEWmpTVm1LVTA2Nko0LzFoK3Bo?=
 =?utf-8?B?ODN3V0V5Rm5FSWk4OGUwWTVpRkNSWkR2d3VDcDJRS2lVMDBMRHVQb2tTTnNK?=
 =?utf-8?B?RkVhU00vaVU0bE5WTVdXbjJOV0F4eElOalBnNkE3K0UySUJGT1R6U1FsUHlu?=
 =?utf-8?B?N21ERWlneFRJSTRHb3UrVjhPNW0zeVpaN0Z3YTU0c2hjczc5MU5tUXkwVWJC?=
 =?utf-8?B?RHUyeHAvdzFKMUUzTkRKS2k2TXBvRkE4UnoxZ1NHUzRqT2RjMXpLaUZsaVFI?=
 =?utf-8?B?L2FtYW16bEdWaDBXUksyVS9CbkQyZXBqOXVtL2Q2NWpySTRmRHlRRUhqKzVv?=
 =?utf-8?B?a0d1MmpqNWxmVjhZZ3J2ZTBrQkNJcE14VG44YjJsYzZHZ0xJbjNzWEM2eGlV?=
 =?utf-8?B?YXkwVDBhRHkvRVlvRU8zVllCTFJDN2lYdnp0ZEVJUnJGSE1LZ1ZJL3BBRGNm?=
 =?utf-8?B?OVpUZmlFSmhPa0R6d2ZqSUE4NWp3QzZudHpmT3FtMFo2TTRpR3ZxZlExWkM2?=
 =?utf-8?B?VjRZbmd1NG4rK3RxT3diN1VaMUN3TTd0VlpxUzZManFCTjZwamc1WTBVaVRq?=
 =?utf-8?B?alo2R2hITkhXM2hFeC9OTndrOUxQUTdNc1JmRmRjbElZcFR5Z2p5NXN5VVA2?=
 =?utf-8?B?MnlCd0lMMHgwWjZiOVBmZzZUd1J0TjdiODlYNEV4bGU3MWhYVkkvYkhMWklR?=
 =?utf-8?B?UHoxeXNodDlnYkJOTCt5WHFYZzJObUVpRXVxRVBCVXdKVVo2MjRQSXd3eGhm?=
 =?utf-8?B?bUdZaHUwWm1ITEcwQW1qc29JN1BBWUxRNTd0NnQ0UkpvcjV4RHloYVNKd1or?=
 =?utf-8?B?a1pRS3E2MjB3VWFGUWlPZTJqcWk1b1RYRExXN0MrV1Z3QXBMeVhJUHhRVmhu?=
 =?utf-8?B?amY3MWp1RWFISmhpOW1IdXlHbzFmenE2Nm1pbERXcUtPNU1SN2ZXc3JSczRC?=
 =?utf-8?B?OW4rb0RKMFBxZjdIeTZveU4wcnFqNU5CTXAyWGo5YWszZkpSMU5CRGhXdVQy?=
 =?utf-8?B?elZXbFRjWGM1ZDRnUVBacGFSU2tLZk55S2lkYUxUd1JTaXp1cmtnOEd4N3Nj?=
 =?utf-8?B?M0pvcm5RWi9rQSs5dCs1M05OZ09pb0M0dEtyMGVFY0c1dzVtVUJrVWE1aW05?=
 =?utf-8?B?NDhKcnphaW1qdDJ0YlRsM0hWY2RVaHhjOGFST3RXempycGc2QkVtZFcvNFdY?=
 =?utf-8?B?MGsyNWhtRDE5dThVOU5vV3JOeGFaODRJdXpsWThwTHFoVHhKMi9BaFVubGcw?=
 =?utf-8?B?ZUMyaUZjaVlleWdHaWFyOEVIemtCbmxmQSs5d1RJS2Z3NEhER2E2V3FVU2FQ?=
 =?utf-8?B?Vk1DT01oWlN4d1FZR2FGYTZxcU8zcmRpVGc4NzViQW81RGxHVkk2MmdyYzUy?=
 =?utf-8?B?blRVdkVkTmw5VDZ5VlFpYWxxMFRGNnJFVmpmWjhOVFN0cndNRkJ3V2R6RmNy?=
 =?utf-8?B?MU9QNGNDRW1SVUJJcnkvWC9rSlFZdmtJajVOZjFXWVRFQUFGZzFVUHc3Ymcr?=
 =?utf-8?B?RFd4ODJaQnlRaVc0TUpFRkpQa2ZmM05QM0s5QVI3bktRaW9KcXJMYnpKK2M0?=
 =?utf-8?B?aVpXTVIxT3hoOGNiYkpjNTFmejBXRFFJcGJFWVFQYWJXeVNWNXhBYlg3NTFy?=
 =?utf-8?B?Y1YxU1VZRThDa2FrK3pxK0hqcHJjMFVMM3FNM1VDcVpFV3hRd3I5cmtpbERl?=
 =?utf-8?B?Y1lZdmJyUkduMlo4d1hkZVIwSUdBVUI2U0JSZzFYOFdjdUFYVUFuSEQ1NExa?=
 =?utf-8?B?Ty9kZjJveHJlWHo3MWxsVEovTmlSMWtWZEdUa2NZenBmK3BLaUVuL2ZheUVk?=
 =?utf-8?B?OGFXcjcrU2xmWmtNa1pkM2h0T1BnQUFwZkN6OWFIeXYvSzNUejFBZ1F4RUpr?=
 =?utf-8?B?TkVMOGNOcmdlUlJ3TFF4SEtTSkEvNWFZZ1lySDhmYjA4QlNzbXZlR1JFYTBi?=
 =?utf-8?Q?tTZ4+0TMLD3PkQhp0CcY82fo1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfb360d-1106-4b1c-6563-08ddf4cbe96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:51:18.7746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8io6xmN7cuIPbRqksSI7vf3kaX2M0VSHBg7YkY0/vfKHJq3TaRZOgu5g9ujxblvtc9uF7AVESTb1nmGfn6KNqb0hHeid16Wk2PCNuDTv+KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6748
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYyIDA1LzE0XSBody9w
Y2ktaG9zdC9hc3BlZWQ6IEFkZCBBU1QyNjAwIFBDSWUNCj4gUm9vdCBQb3J0IGFuZCBtYWtlIGFk
ZHJlc3MgY29uZmlndXJhYmxlDQo+IA0KPiBPbiA5LzExLzI1IDA5OjI0LCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4gSW50cm9kdWNlIGFuIEFTUEVFRCBQQ0llIFJvb3QgUG9ydCBhbmQgd2lyZSBpdCB1
bmRlciB0aGUgUkMuIFRoZSByb290DQo+ID4gcG9ydCBpcyBtb2RlbGVkIGFzIFRZUEVfQVNQRUVE
X1BDSUVfUk9PVF9QT1JUIChzdWJjbGFzcyBvZg0KPiBUWVBFX1BDSUVfUk9PVF9QT1JUKS4NCj4g
Pg0KPiA+IEtleSBjaGFuZ2VzOg0KPiA+IC0gQWRkIFRZUEVfQVNQRUVEX1BDSUVfUk9PVF9QT1JU
IChQQ0lFU2xvdC1iYXNlZCkgd2l0aCB2ZW5kb3IvZGV2aWNlDQo+IElEcw0KPiA+ICAgIGFuZCBB
RVIgY2FwYWJpbGl0eSBvZmZzZXQuDQo+ID4gLSBFeHRlbmQgQXNwZWVkUENJRVJjU3RhdGUgdG8g
ZW1iZWQgYSByb290X3BvcnQgaW5zdGFuY2UgYW5kIGENCj4gPiAgICBjb25maWd1cmFibGUgcnBf
YWRkci4NCj4gPiAtIEFkZCAicnAtYWRkciIgcHJvcGVydHkgdG8gdGhlIFJDIHRvIHBsYWNlIHRo
ZSByb290IHBvcnQgYXQgYSBzcGVjaWZpYw0KPiA+ICAgIGRldmZuIG9uIHRoZSByb290IGJ1cy4N
Cj4gPiAtIFNldCB0aGUgcm9vdCBwb3J0J3MgImNoYXNzaXMiIHByb3BlcnR5IHRvIGVuc3VyZSBh
IHVuaXF1ZSBjaGFzc2lzIHBlciBSQy4NCj4gPiAtIEV4dGVuZCBBc3BlZWRQQ0lFQ2ZnQ2xhc3Mg
d2l0aCByY19ycF9hZGRyIGRlZmF1bHRpbmcgdG8gUENJX0RFVkZOKDgsMCkuDQo+ID4NCj4gPiBS
YXRpb25hbGU6DQo+ID4gLSBBU1QyNjAwIHBsYWNlcyB0aGUgcm9vdCBwb3J0IGF0IDgwOjA4LjAg
KGJ1cyAweDgwLCBkZXYgOCwgZm4gMCkuDQo+ID4gLSBBU1QyNzAwIG11c3QgcGxhY2UgdGhlIHJv
b3QgcG9ydCBhdCAwMDowMC4wLCBhbmQgaXQgc3VwcG9ydHMgdGhyZWUgUkNzLg0KPiA+ICAgIEVh
Y2ggcm9vdCBwb3J0IG11c3QgdGhlcmVmb3JlIGJlIHVuaXF1ZWx5IGlkZW50aWZpYWJsZTsgdXNl
cyB0aGUNCj4gPiAgICBQQ0llICJjaGFzc2lzIiBJRCBmb3IgdGhhdC4NCj4gPiAtIFByb3ZpZGlu
ZyBhIGNvbmZpZ3VyYWJsZSAicnAtYWRkciIgbGV0cyBwbGF0Zm9ybXMgc2VsZWN0IHRoZSBjb3Jy
ZWN0DQo+ID4gICAgZGV2Zm4gcGVyIFNvQyBmYW1pbHksIHdoaWxlIHRoZSAiY2hhc3NpcyIgcHJv
cGVydHkgZW5zdXJlcyB1bmlxdWVuZXNzDQo+ID4gICAgYWNyb3NzIG11bHRpcGxlIFJDIGluc3Rh
bmNlcyBvbiBBU1QyNzAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L3BjaS1ob3N0
L2FzcGVlZF9wY2llLmggfCAxMSArKysrKysrDQo+ID4gICBody9wY2ktaG9zdC9hc3BlZWRfcGNp
ZS5jICAgICAgICAgfCA0OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmgNCj4gPiBiL2luY2x1ZGUvaHcvcGNp
LWhvc3QvYXNwZWVkX3BjaWUuaA0KPiA+IGluZGV4IGU3YzIzMWU4NDcuLjQwMjZkNWI0YzUgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5oDQo+ID4gKysr
IGIvaW5jbHVkZS9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5oDQo+ID4gQEAgLTIyLDYgKzIyLDcg
QEANCj4gPiAgICNpbmNsdWRlICJody9zeXNidXMuaCINCj4gPiAgICNpbmNsdWRlICJody9wY2kv
cGNpX2JyaWRnZS5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2llX2hvc3QuaCINCj4gPiAr
I2luY2x1ZGUgImh3L3BjaS9wY2llX3BvcnQuaCINCj4gPiAgICNpbmNsdWRlICJxb20vb2JqZWN0
LmgiDQo+ID4NCj4gPiAgIHR5cGVkZWYgc3RydWN0IEFzcGVlZFBDSUVDZmdUeERlc2MgeyBAQCAt
NDIsNiArNDMsMTMgQEAgdHlwZWRlZg0KPiA+IHN0cnVjdCBBc3BlZWRQQ0lFUmVnTWFwIHsNCj4g
PiAgICAgICBBc3BlZWRQQ0lFUmNSZWdzIHJjOw0KPiA+ICAgfSBBc3BlZWRQQ0lFUmVnTWFwOw0K
PiA+DQo+ID4gKyNkZWZpbmUgVFlQRV9BU1BFRURfUENJRV9ST09UX1BPUlQgImFzcGVlZC5wY2ll
LXJvb3QtcG9ydCINCj4gPiArT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQXNwZWVkUENJRVJv
b3RQb3J0U3RhdGUsDQo+ID4gK0FTUEVFRF9QQ0lFX1JPT1RfUE9SVCkNCj4gPiArDQo+ID4gK3R5
cGVkZWYgc3RydWN0IEFzcGVlZFBDSUVSb290UG9ydFN0YXRlIHsNCj4gPiArICAgIFBDSUVTbG90
IHBhcmVudF9vYmo7DQo+ID4gK30gQXNwZWVkUENJRVJvb3RQb3J0U3RhdGU7DQo+ID4gKw0KPiA+
ICAgI2RlZmluZSBUWVBFX0FTUEVFRF9QQ0lFX1JPT1RfREVWSUNFICJhc3BlZWQucGNpZS1yb290
LWRldmljZSINCj4gPiAgIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFzcGVlZFBDSUVSb290
RGV2aWNlU3RhdGUsDQo+ID4gQVNQRUVEX1BDSUVfUk9PVF9ERVZJQ0UpOw0KPiA+DQo+ID4gQEAg
LTYwLDEyICs2OCwxNCBAQCBzdHJ1Y3QgQXNwZWVkUENJRVJjU3RhdGUgew0KPiA+ICAgICAgIE1l
bW9yeVJlZ2lvbiBtbWlvOw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBpbzsNCj4gPg0KPiA+ICsg
ICAgdWludDMyX3QgcnBfYWRkcjsNCj4gPiAgICAgICB1aW50MzJfdCBidXNfbnI7DQo+ID4gICAg
ICAgY2hhciBuYW1lWzE2XTsNCj4gPiAgICAgICBib29sIGhhc19yZDsNCj4gPiAgICAgICBxZW11
X2lycSBpcnE7DQo+ID4NCj4gPiAgICAgICBBc3BlZWRQQ0lFUm9vdERldmljZVN0YXRlIHJvb3Rf
ZGV2aWNlOw0KPiA+ICsgICAgQXNwZWVkUENJRVJvb3RQb3J0U3RhdGUgcm9vdF9wb3J0Ow0KPiA+
ICAgfTsNCj4gPg0KPiA+ICAgLyogQnJpZGdlIGJldHdlZW4gQUhCIGJ1cyBhbmQgUENJZSBSQy4g
Ki8gQEAgLTg4LDYgKzk4LDcgQEAgc3RydWN0DQo+ID4gQXNwZWVkUENJRUNmZ0NsYXNzIHsNCj4g
PiAgICAgICBjb25zdCBBc3BlZWRQQ0lFUmVnTWFwICpyZWdfbWFwOw0KPiA+ICAgICAgIGNvbnN0
IE1lbW9yeVJlZ2lvbk9wcyAqcmVnX29wczsNCj4gPg0KPiA+ICsgICAgdWludDMyX3QgcmNfcnBf
YWRkcjsNCj4gPiAgICAgICB1aW50NjRfdCByY19idXNfbnI7DQo+ID4gICAgICAgdWludDY0X3Qg
bnJfcmVnczsNCj4gPiAgICAgICBib29sIHJjX2hhc19yZDsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
cGNpLWhvc3QvYXNwZWVkX3BjaWUuYyBiL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMNCj4gPiBp
bmRleCBmYTg4NTRmZTdhLi4zZjA0ZjBkMzc5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3BjaS1ob3N0
L2FzcGVlZF9wY2llLmMNCj4gPiArKysgYi9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jDQo+ID4g
QEAgLTIzLDYgKzIzLDcgQEANCj4gPiAgICNpbmNsdWRlICJody9yZWdpc3RlcmZpZWxkcy5oIg0K
PiA+ICAgI2luY2x1ZGUgImh3L2lycS5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfaG9z
dC5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvcGNpL3BjaWVfcG9ydC5oIg0KPiA+ICAgI2luY2x1ZGUg
Imh3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvcGNpL21zaS5o
Ig0KPiA+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4gQEAgLTY1LDYgKzY2LDMyIEBAIHN0YXRp
YyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfcGNpZV9yb290X2RldmljZV9pbmZvID0NCj4gew0KPiA+
ICAgICAgIH0sDQo+ID4gICB9Ow0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIFBDSWUgUm9vdCBQb3J0
DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX3BjaWVfcm9vdF9wb3J0
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKSB7DQo+ID4gKyAgICBQ
Q0lEZXZpY2VDbGFzcyAqayA9IFBDSV9ERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KPiA+ICsgICAgRGV2
aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiArICAgIFBDSUVSb290UG9y
dENsYXNzICpycGMgPSBQQ0lFX1JPT1RfUE9SVF9DTEFTUyhrbGFzcyk7DQo+ID4gKw0KPiA+ICsg
ICAgZGMtPmRlc2MgPSAiQVNQRUVEIFBDSWUgUm9vdCBQb3J0IjsNCj4gPiArICAgIGstPnZlbmRv
cl9pZCA9IFBDSV9WRU5ET1JfSURfQVNQRUVEOw0KPiA+ICsgICAgay0+ZGV2aWNlX2lkID0gMHgx
MTUwOw0KPiA+ICsgICAgZGMtPnVzZXJfY3JlYXRhYmxlID0gdHJ1ZTsNCj4gPiArDQo+ID4gKyAg
ICBycGMtPmFlcl9vZmZzZXQgPSAweDEwMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IFR5cGVJbmZvIGFzcGVlZF9wY2llX3Jvb3RfcG9ydF9pbmZvID0gew0KPiA+ICsgICAgLm5h
bWUgPSBUWVBFX0FTUEVFRF9QQ0lFX1JPT1RfUE9SVCwNCj4gPiArICAgIC5wYXJlbnQgPSBUWVBF
X1BDSUVfUk9PVF9QT1JULA0KPiA+ICsgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoQXNwZWVk
UENJRVJvb3RQb3J0U3RhdGUpLA0KPiA+ICsgICAgLmNsYXNzX2luaXQgPSBhc3BlZWRfcGNpZV9y
b290X3BvcnRfY2xhc3NfaW5pdCwgfTsNCj4gPiArDQo+ID4gICAvKg0KPiA+ICAgICogUENJZSBS
b290IENvbXBsZXggKFJDKQ0KPiA+ICAgICovDQo+ID4gQEAgLTE0NCw2ICsxNzEsMTEgQEAgc3Rh
dGljIHZvaWQgYXNwZWVkX3BjaWVfcmNfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0KPiAqZGV2LCBFcnJv
ciAqKmVycnApDQo+ID4gICAgICAgICAgIHFkZXZfcHJvcF9zZXRfYml0KERFVklDRSgmcmMtPnJv
b3RfZGV2aWNlKSwgIm11bHRpZnVuY3Rpb24iLA0KPiBmYWxzZSk7DQo+ID4gICAgICAgICAgIHFk
ZXZfcmVhbGl6ZShERVZJQ0UoJnJjLT5yb290X2RldmljZSksIEJVUyhwY2ktPmJ1cyksDQo+ICZl
cnJvcl9mYXRhbCk7DQo+ID4gICAgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qIHNldHVwIHJvb3Qg
cG9ydCAqLw0KPiA+ICsgICAgcWRldl9wcm9wX3NldF9pbnQzMihERVZJQ0UoJnJjLT5yb290X3Bv
cnQpLCAiYWRkciIsIHJjLT5ycF9hZGRyKTsNCj4gPiArICAgIHFkZXZfcHJvcF9zZXRfdWludDE2
KERFVklDRSgmcmMtPnJvb3RfcG9ydCksICJjaGFzc2lzIiwgY2ZnLT5pZCk7DQo+ID4gKyAgICBx
ZGV2X3JlYWxpemUoREVWSUNFKCZyYy0+cm9vdF9wb3J0KSwgQlVTKHBjaS0+YnVzKSwNCj4gPiAr
ICZlcnJvcl9mYXRhbCk7DQo+IA0KPiBlcnJwID8NCj4gDQoNCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZml4IGl0Lg0KDQpKYW1pbg0KDQo+IEMuDQo+IA0K
PiANCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IGNoYXIgKmFzcGVlZF9wY2llX3Jj
X3Jvb3RfYnVzX3BhdGgoUENJSG9zdFN0YXRlDQo+ID4gKmhvc3RfYnJpZGdlLCBAQCAtMTU4LDkg
KzE5MCwxOSBAQCBzdGF0aWMgY29uc3QgY2hhcg0KPiAqYXNwZWVkX3BjaWVfcmNfcm9vdF9idXNf
cGF0aChQQ0lIb3N0U3RhdGUgKmhvc3RfYnJpZGdlLA0KPiA+ICAgICAgIHJldHVybiByYy0+bmFt
ZTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19pbnN0YW5j
ZV9pbml0KE9iamVjdCAqb2JqKSB7DQo+ID4gKyAgICBBc3BlZWRQQ0lFUmNTdGF0ZSAqcmMgPSBB
U1BFRURfUENJRV9SQyhvYmopOw0KPiA+ICsgICAgQXNwZWVkUENJRVJvb3RQb3J0U3RhdGUgKnJv
b3RfcG9ydCA9ICZyYy0+cm9vdF9wb3J0Ow0KPiA+ICsNCj4gPiArICAgIG9iamVjdF9pbml0aWFs
aXplX2NoaWxkKG9iaiwgInJvb3RfcG9ydCIsIHJvb3RfcG9ydCwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFRZUEVfQVNQRUVEX1BDSUVfUk9PVF9QT1JUKTsgfQ0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSBhc3BlZWRfcGNpZV9yY19wcm9wc1tdID0gew0KPiA+
ICAgICAgIERFRklORV9QUk9QX1VJTlQzMigiYnVzLW5yIiwgQXNwZWVkUENJRVJjU3RhdGUsIGJ1
c19uciwgMCksDQo+ID4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiaGFzLXJkIiwgQXNwZWVkUENJ
RVJjU3RhdGUsIGhhc19yZCwgMCksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoInJwLWFk
ZHIiLCBBc3BlZWRQQ0lFUmNTdGF0ZSwgcnBfYWRkciwgMCksDQo+ID4gICB9Ow0KPiA+DQo+ID4g
ICBzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZA0KPiA+ICpkYXRhKSBAQCAtMTgzLDYgKzIyNSw3IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBhc3BlZWRfcGNpZV9yY19pbmZvID0gew0KPiA+ICAgICAgIC5uYW1lID0gVFlQ
RV9BU1BFRURfUENJRV9SQywNCj4gPiAgICAgICAucGFyZW50ID0gVFlQRV9QQ0lFX0hPU1RfQlJJ
REdFLA0KPiA+ICAgICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEFzcGVlZFBDSUVSY1N0YXRl
KSwNCj4gPiArICAgIC5pbnN0YW5jZV9pbml0ID0gYXNwZWVkX3BjaWVfcmNfaW5zdGFuY2VfaW5p
dCwNCj4gPiAgICAgICAuY2xhc3NfaW5pdCA9IGFzcGVlZF9wY2llX3JjX2NsYXNzX2luaXQsDQo+
ID4gICB9Ow0KPiA+DQo+ID4gQEAgLTQ1Niw2ICs0OTksOSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRf
cGNpZV9jZmdfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0KPiAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4g
ICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmcy0+cmMpLCAiaGFzLXJkIiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcGMtPnJjX2hhc19yZCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiA+ICsgICAgb2Jq
ZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5yYyksICJycC1hZGRyIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFwYy0+cmNfcnBfYWRkciwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gICAgICAgaWYgKCFzeXNidXNf
cmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+cmMpLCBlcnJwKSkgew0KPiA+ICAgICAgICAgICBy
ZXR1cm47DQo+ID4gICAgICAgfQ0KPiA+IEBAIC00ODksNiArNTM1LDcgQEAgc3RhdGljIHZvaWQg
YXNwZWVkX3BjaWVfY2ZnX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gKmtsYXNzLCBjb25zdCB2
b2lkICpkYXRhKQ0KPiA+ICAgICAgIGFwYy0+bnJfcmVncyA9IDB4MTAwID4+IDI7DQo+ID4gICAg
ICAgYXBjLT5yY19idXNfbnIgPSAweDgwOw0KPiA+ICAgICAgIGFwYy0+cmNfaGFzX3JkID0gdHJ1
ZTsNCj4gPiArICAgIGFwYy0+cmNfcnBfYWRkciA9IFBDSV9ERVZGTig4LCAwKTsNCj4gPiAgIH0N
Cj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9wY2llX2NmZ19pbmZvID0g
eyBAQCAtNjI3LDYgKzY3NCw3IEBADQo+ID4gc3RhdGljIHZvaWQgYXNwZWVkX3BjaWVfcmVnaXN0
ZXJfdHlwZXModm9pZCkNCj4gPiAgIHsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygm
YXNwZWVkX3BjaWVfcmNfaW5mbyk7DQo+ID4gICAgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFz
cGVlZF9wY2llX3Jvb3RfZGV2aWNlX2luZm8pOw0KPiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0
aWMoJmFzcGVlZF9wY2llX3Jvb3RfcG9ydF9pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVy
X3N0YXRpYygmYXNwZWVkX3BjaWVfY2ZnX2luZm8pOw0KPiA+ICAgICAgIHR5cGVfcmVnaXN0ZXJf
c3RhdGljKCZhc3BlZWRfcGNpZV9waHlfaW5mbyk7DQo+ID4gICB9DQoNCg==

