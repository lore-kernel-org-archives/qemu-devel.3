Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF8E93805
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1Pr-00043M-Eg; Sun, 12 Apr 2026 16:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wC1Po-000401-7k; Sun, 12 Apr 2026 16:28:20 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wC1Pm-0007T0-FT; Sun, 12 Apr 2026 16:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCN5545vqunWjvAO5CSap/PtGRJQ0YM2kdxpkMtDOcrbOiLw1kYNkTEY9+oyQ5L11BJE/D7pjiyaD0pnTKucU/eaWxYl+6WeejRjzCPxXwj0qiyatUP0E/QNhP2VgKyr4vaFuyYlvmtgjU0NuyrV1QclIqDUK/UtR3ww5EMnB5xZk2iLAP50gDB4uLlM+E7f41x3Nr6Q2yKTH5idh2LOAJSSDICXJWtsEyQM/8kQQARaocavRFCt46IigTz9pHlAM+yZkt4/PE9NxhLBbKEJEcmDGn8tDVedCw/vNXjrAGoYVrVZC937xHK4B7rK09NZ4Jq4RkMcnBhHmhQI/sufQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faZ2VG+ByQ997MfXCAVPef5/mkUkBOV1HnpA+LeBNGk=;
 b=gMDEHLC7H4j+2Iv6rnzkspp7+OmZ1fdl74YY421OKLA9Kft8i5l/aBf5+rudN20QiX+TAy/GuUqjk4zlkMLlcWfWqZL0/S4JmrHkkeeoJhdH1ZzSVZlpwLhtPqezWECtfWqkvOWb+10h+PWRygOA5wjOOtqHc4+qLlhqjnIDUX/PqZAsvuyQ/xyaN9TYzy+PVqIZFvx9glK/IJjCd12Foc7ZPB27dJi+gO1tTgbP6hSQWeayA3KAy0/9zUvJFlGIfDb6s9CR9yaBQ+wX/g5O3Af2PxYKKE4chcCU79/PdjKGaQzQZX8+8lCuTHe1td2Yb11ufAsxz4hU11KaLZCEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faZ2VG+ByQ997MfXCAVPef5/mkUkBOV1HnpA+LeBNGk=;
 b=Zp/Ux3Y9hqntFuO6LgrL6gAzfbGXAN0jgak2jKt2wyovTvp13CDDjW7/4S1yOzySGCI5WpsyHmrbJmaMxWS7q+xSpft7zszE7ssNgm3CjHKvKRvn/DZi6JfFOTPE6P5k9NudFY3496lo+ddX9N3whs4u7UCJKZnhoAekAfgHPQtznZBE96/nJ4IXjoteUHU2rts9ssxaSGFIj4VXGjsAmB0CfMzfm3GZdQSqspBU5DFK4ORvrfThV2DitybVM5pKa+Vfbbdr5OowwUNoX15S0yXlJHSCnq05gFHVVKF+Erniqvw4AkeO4GNqIUqSX7LWIe7pvfvruC6YwuurQma9Sw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Sun, 12 Apr
 2026 20:28:14 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 20:28:14 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH v2 2/2] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in
 hw/ header
Thread-Topic: [PATCH v2 2/2] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in
 hw/ header
Thread-Index: AQHcySS/gKVkLmsPIUqm6+CGbsWleLXb42GQ
Date: Sun, 12 Apr 2026 20:28:14 +0000
Message-ID: <CH3PR12MB75480CBCF41ECBA8BFB983CDAB272@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260410200031.18572-1-philmd@linaro.org>
 <20260410200031.18572-3-philmd@linaro.org>
In-Reply-To: <20260410200031.18572-3-philmd@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6202:EE_
x-ms-office365-filtering-correlation-id: 92c0710e-2711-4ac4-2e8d-08de98d205cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: +i1M/je1SbQB56GnJowGZgmc4h1ujtJIxIXaJyJLkrhfRp6lpMSMSu/Zzc6j48KozxZJYhJa/OAOQP+Z+0zPOofKlBG4YlXRLup+ZvcEpBXIWp51Dwcl0LAoFQNQoQKBwmJE1ySiQ3BrAukH+rTSMZC3l39lIpfHzGW9K9YFeACVS5DaLCCBuNXwrY5+Zqn17VgPBnieKB3R36JujSr3pvzPo8jPJ0xujAKvs0Otn63tiPQdpFor3CHb+NGgfKv+dv2+hUxR0c20ugX42StRr2hVrdyFL/mPPcM1dPgj7kw/EuplmzmOh29PgcM4pOGFe1ZS9alL9pWBTLAQuY/0kTs1iRmbZxjjnaCV70Wtc3XCLjGtw0v5FH3T6irk0iJbzRgdB1Bs5woLwBNlcWYGGv5TvjmcqeoqOjzz6mWxZqVSkWjxrmKBYWt7Ui3gM1M/BMjsovXNQxaQVE1AIb2rrMB3B1mPvqdT8ZaIMJ88ZnIXBTXnwJTSmg5CL4SbBfW5IPlJrneucCvnnVbhb1+QL8dgzNKJ12f3mNFR90NW9jdBciP7bFpSm8V2ItdeGqE8tkl0Qy86GaN61kme58e2vdaRQ31aclnupy5HI2z8Hw6QML/94d53BMm0iPc0+dmkYIJppBpuHjU5k72ViqHO8pJHOr1DQlwME29jLyEaWavEqrxckMTQwhiXPlnZ1InJ4wWYoGIufM2/h3n/iVI5BpYYPm/lIs5tZUNt14WI+0P02lQXLGa49PAqr829Ro6wcYRiZPJxmxrl8kqKvnhQ0v5qCL/Ws44b8+CrIhb+s5M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWdUMzlXcjhFcEVobDdOMzJtUk95OUdqZFJwVTZBTnBDanRXTXY3MEpTUzZ2?=
 =?utf-8?B?S3ovUVJrR29sTHZsczM2R3ZTKzFFMjFkV1MvRVdtcXRZZjdJYzZEMGkxMTgw?=
 =?utf-8?B?bEYrZnhYemIzYmlmWmFTbHQvazJKcHlBQkp5UE1UTkZqaWNYdHZGVnAwWEh1?=
 =?utf-8?B?bTdaZTl5T3crQzlQKzdTZlVnU1NSNzNETThBam9lYUY3OG5oYnA3K1pqWGRm?=
 =?utf-8?B?MnpLZllzYitSV296WGpaOU1rSi95S2NWa0lHcVU4ZjBFMVJ4Ri8yVWdxdjNO?=
 =?utf-8?B?R3p4czdjai9uTjdnQlVLM1N0bGovQnExUmpnV2w1Y01VVTB3Y2NoQ2Mwc1B6?=
 =?utf-8?B?OC95dmFqakxDSlJwKzd6eHdjR3d4bVNJMk8zKzBCRFg0NEZ5VlA3NVNGL0Vu?=
 =?utf-8?B?TStzUVNPaWVDblNTa2VVUlQ0aURoRWFvRW5lOEY4OVVHMHNFejFlQjBoakRJ?=
 =?utf-8?B?cm5IVUZpeUw5RTNsUjVnM0gyUVkyWE9DTnRvYkxwa21JbmJXenZ1MTYxQnky?=
 =?utf-8?B?Z1hvc2drbXNDeVBSSHljYUFJek1zanhpOXpRdzczZng4TDVGdVFJNllWTGhQ?=
 =?utf-8?B?RkdtVVNZck9HNHU1czNkQjV1L29qRUJpQlV0NElSTjF5U1lFbERyS3BIZ2l0?=
 =?utf-8?B?UVIvM1dlSGQ2Y1d1RHhZNFpHWHU2VzQzNVVkWkpkd1ppUDd1QnFBMUlNbWxD?=
 =?utf-8?B?cHBsN0pLMkFwZFMxN0tJSmlTWk9nUnlzT2tmblFSa0NraXVQNGRxUko3OVJ2?=
 =?utf-8?B?anZKODd2NXprWTU0Z09WbEdMZ2E3ekVnTlROLzJnb3dXcU85OVJtWjFZZStp?=
 =?utf-8?B?clFOUlVFSGtGRDFyNUZYUHd0QVN6c3ZGMWtsQjUrMjByTExnSk9YQzZvV1R4?=
 =?utf-8?B?OFo5UkxoSlVieDlLRUh4NndhTDlwRFJmcXNmWnhPRjU3WUFnbzh2SCsydEJH?=
 =?utf-8?B?SUlHZnNWWDdzWTlrTkFKVkpXNXRPUFYwWG9pb1paWm9vSzF5ZW5tNldZQk5C?=
 =?utf-8?B?bjdiRWdSRndrZjQ1TWR4bHp4WEhyajNWYzk5eHFVZjBBNFZmOTN0QmcvWEVW?=
 =?utf-8?B?ckE5U0ZReER6ZlJUNGFPTExjWHZSU092bktUbHdqUm9iT1JCQURxMGFwQWhV?=
 =?utf-8?B?T0Znc1c0YTNjdmh5NVVoTUJOZEpoRi9BTXovQlgzY1VqeXRvbmZSaUlWRVVj?=
 =?utf-8?B?T2Q5eDR5bXBHU1c5bmZ5YTBvNlJDMTZqQXUwMnRyZHpZK3RReERCRndLMUNQ?=
 =?utf-8?B?Z093M1dyNmRxOG9GRXFxK2E1YVhNRXpIdDNoT2dQY2s1K0ZJNVBOd2R4TzRF?=
 =?utf-8?B?Yk14bWUxSHNhMlZIM1VFRVdpMXkvREZEa2NaRVR5Y3JuVGF4QW9PaXBKa3hR?=
 =?utf-8?B?V2FJeGdyLzJJNHp5bk13Y2lZQml4OWkwZEFvbnlteEQ2SHVzTmJhVEQrQStT?=
 =?utf-8?B?Nk1vQStnT2tKK1M4VmszcWxUSkxYVENNNGdtZXF5UU83ODFLeFEzZ0JITnpL?=
 =?utf-8?B?c3ZnM0RjZE5kTUVCbUZEaXlkSFY3ZEdTTGdQN2w0NCtRSWcxZ2VFM1ZhekJM?=
 =?utf-8?B?dk0wT0Z5anBablR3dStrcTdBZ2liY2I3dGNpTHd0OFVaUDNjNnpEVlkzcUxs?=
 =?utf-8?B?ZTI0bW9hNjhCSmRLc1dBRmVlWURnRXpGT08yak5QaVNwK1plUVRvcFZ3OXc0?=
 =?utf-8?B?cm1ScHJzZXhKS3NRdXhNaUl2NlIwQkhMVVFDTkpDR3A4eW9udjgwQnE2eU9C?=
 =?utf-8?B?RVhxTmtJdXc3enJrL1huak95RC9QbFZNRCs0UEg2UXUydjl6UXJWM3VxTnJM?=
 =?utf-8?B?VzI1VzNCQkFuZ1lBTDBBR25RVkUvWWcxRVNaL0duTm1GaFYvZnIyaWRhaHVF?=
 =?utf-8?B?V05TTkJ1WnVmQ2NKWjRQZVlscTdlVGxtRjdGb21QdmQzZUhDT1VSUlg2eWsw?=
 =?utf-8?B?QmEwcVNybjZjVXhHdnA3cGtzWklkSllYNXRvQlUyQzN0UDRHZUhubVNGYXhw?=
 =?utf-8?B?aStpSVZVNlR1SnM5V3IrZUhRbjU4VU5ITUc5UHhjdjhaMGRUck5FSWs5UHdl?=
 =?utf-8?B?STl6KzJHNXRnMXA1Y1Fpck5zR2I3WW5XeTVSb3FqNFhOUFZvSlBMYkhaZXc2?=
 =?utf-8?B?WE1GNGs4ZVZ3NFI3a2JxaWdhaThhZUhjK1FYTXdaYjZBeUZZdDl6L1Z5QkpG?=
 =?utf-8?B?V01nTWV1NDhlZ3VVb0RaeldxZE0vc3F3YlFndFpUZno4YmpHUXNZS0RiWm5S?=
 =?utf-8?B?a25aNUxZaFBVVE85czFrM21qZGxYR0ZpSm8zaWFqbXRBNDRyNC9WZjN4M2tz?=
 =?utf-8?B?cURJNTE2WCtETlB1NTRmMVYwY0NVOVZMN2ppNk51Z0wwN2dpNGN3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c0710e-2711-4ac4-2e8d-08de98d205cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 20:28:14.1158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy5umLkYTYwT8I1qtu5MAA+xW2fxUZN3P7dQg+p427YiwObAcEfpyljcQGsQ2HNBP2LT4x5fb3wfjdNTKA99Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAxMCBBcHJpbCAyMDI2IDIxOjAx
DQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBQZXRlcg0KPiBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTaGFtZWVyIEtvbG90aHVtIFRob2RpDQo+IDxza29sb3Ro
dW10aG9AbnZpZGlhLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IFBo
aWxpcHBlDQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47IFRob21hcyBIdXRo
IDx0aHV0aEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8yXSBody9hcm0vc21t
dXYzOiBBdm9pZCBpbmNsdWRpbmcgQ09ORklHX0RFVklDRVMNCj4gaW4gaHcvIGhlYWRlcg0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBCeSB0dXJuaW5nIHRoZSBpbmxpbmUgZnVuY3Rpb25zIGludG8gc3R1YnMg
d2UgY2FuIGF2b2lkIHRoZQ0KPiB1c2Ugb2YgdGFyZ2V0LXNwZWNpZmljIENPTkZJR19ERVZJQ0VT
IGluY2x1ZGUgaW4gYSBody8gaGVhZGVyLA0KPiBhbGxvd2luZyB0byBidWlsZCB0aGUgc291cmNl
IGZpbGVzIGluY2x1ZGluZyBpdCBhcyBjb21tb24gb2JqZWN0cy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gUmV2aWV3
ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogU2hh
bWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQoNClRoYW5rcywNClNoYW1l
ZXINCg0KPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5oICAgICAgIHwgNDIgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICBody9hcm0vc21tdXYzLWFjY2VsLXN0dWJzLmMgfCA1Mg0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBody9hcm0vbWVzb24uYnVp
bGQgICAgICAgICAgfCAgNSArKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMo
KyksIDQ0IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9zbW11djMt
YWNjZWwtc3R1YnMuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNjZWwuaCBi
L2h3L2FybS9zbW11djMtYWNjZWwuaA0KPiBpbmRleCAxY2EyYzgwYTkzMy4uODU2NjlkMGUwMGUg
MTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuaA0KPiArKysgYi9ody9hcm0vc21t
dXYzLWFjY2VsLmgNCj4gQEAgLTE0LDcgKzE0LDYgQEANCj4gICNpZmRlZiBDT05GSUdfTElOVVgN
Cj4gICNpbmNsdWRlIDxsaW51eC9pb21tdWZkLmg+DQo+ICAjZW5kaWYNCj4gLSNpbmNsdWRlIENP
TkZJR19ERVZJQ0VTDQo+IA0KPiAgLyoNCj4gICAqIFJlcHJlc2VudHMgYW4gYWNjZWxlcmF0ZWQg
U01NVSBpbnN0YW5jZSBiYWNrZWQgYnkgYW4gaW9tbXVmZCB2SU9NTVUNCj4gb2JqZWN0Lg0KPiBA
QCAtNDEsNyArNDAsNiBAQCB0eXBlZGVmIHN0cnVjdCBTTU1VdjNBY2NlbERldmljZSB7DQo+ICAg
ICAgU01NVXYzQWNjZWxTdGF0ZSAqc19hY2NlbDsNCj4gIH0gU01NVXYzQWNjZWxEZXZpY2U7DQo+
IA0KPiAtI2lmZGVmIENPTkZJR19BUk1fU01NVVYzX0FDQ0VMDQo+ICBib29sIHNtbXV2M19hY2Nl
bF9pbml0KFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApOw0KPiAgYm9vbCBzbW11djNfYWNj
ZWxfaW5zdGFsbF9zdGUoU01NVXYzU3RhdGUgKnMsIFNNTVVEZXZpY2UgKnNkZXYsIGludA0KPiBz
aWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPiBA
QCAtNTMsNDUgKzUxLDUgQEAgYm9vbCBzbW11djNfYWNjZWxfaXNzdWVfaW52X2NtZChTTU1VdjNT
dGF0ZSAqcywNCj4gdm9pZCAqY21kLCBTTU1VRGV2aWNlICpzZGV2LA0KPiAgdm9pZCBzbW11djNf
YWNjZWxfaWRyX292ZXJyaWRlKFNNTVV2M1N0YXRlICpzKTsNCj4gIGJvb2wgc21tdXYzX2FjY2Vs
X2FsbG9jX3ZldmVudHEoU01NVXYzU3RhdGUgKnMsIEVycm9yICoqZXJycCk7DQo+ICB2b2lkIHNt
bXV2M19hY2NlbF9yZXNldChTTU1VdjNTdGF0ZSAqcyk7DQo+IC0jZWxzZQ0KPiAtI2luY2x1ZGUg
InFhcGkvZXJyb3IuaCINCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBzbW11djNfYWNjZWxfaW5pdChT
TU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiAtew0KPiAtICAgIGVycm9yX3NldGcoZXJy
cCwgImFjY2VsPW9uIHN1cHBvcnQgbm90IGNvbXBpbGVkIGluIik7DQo+IC0gICAgcmV0dXJuIGZh
bHNlOw0KPiAtfQ0KPiAtc3RhdGljIGlubGluZSBib29sDQo+IC1zbW11djNfYWNjZWxfaW5zdGFs
bF9zdGUoU01NVXYzU3RhdGUgKnMsIFNNTVVEZXZpY2UgKnNkZXYsIGludCBzaWQsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiAtew0KPiAtICAgIHJldHVybiB0
cnVlOw0KPiAtfQ0KPiAtc3RhdGljIGlubGluZSBib29sDQo+IC1zbW11djNfYWNjZWxfaW5zdGFs
bF9zdGVfcmFuZ2UoU01NVXYzU3RhdGUgKnMsIFNNTVVTSURSYW5nZSAqcmFuZ2UsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiAtew0KPiAtICAgIHJl
dHVybiB0cnVlOw0KPiAtfQ0KPiAtc3RhdGljIGlubGluZSBib29sIHNtbXV2M19hY2NlbF9hdHRh
Y2hfZ2JwYV9od3B0KFNNTVV2M1N0YXRlICpzLCBFcnJvcg0KPiAqKmVycnApDQo+IC17DQo+IC0g
ICAgcmV0dXJuIHRydWU7DQo+IC19DQo+IC1zdGF0aWMgaW5saW5lIGJvb2wNCj4gLXNtbXV2M19h
Y2NlbF9pc3N1ZV9pbnZfY21kKFNNTVV2M1N0YXRlICpzLCB2b2lkICpjbWQsIFNNTVVEZXZpY2UN
Cj4gKnNkZXYsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+
IC17DQo+IC0gICAgcmV0dXJuIHRydWU7DQo+IC19DQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgc21t
dXYzX2FjY2VsX2lkcl9vdmVycmlkZShTTU1VdjNTdGF0ZSAqcykNCj4gLXsNCj4gLX0NCj4gLXN0
YXRpYyBpbmxpbmUgYm9vbCBzbW11djNfYWNjZWxfYWxsb2NfdmV2ZW50cShTTU1VdjNTdGF0ZSAq
cywgRXJyb3INCj4gKiplcnJwKQ0KPiAtew0KPiAtICAgIHJldHVybiB0cnVlOw0KPiAtfQ0KPiAt
c3RhdGljIGlubGluZSB2b2lkIHNtbXV2M19hY2NlbF9yZXNldChTTU1VdjNTdGF0ZSAqcykNCj4g
LXsNCj4gLX0NCj4gLSNlbmRpZg0KPiANCj4gICNlbmRpZiAvKiBIV19BUk1fU01NVVYzX0FDQ0VM
X0ggKi8NCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNjZWwtc3R1YnMuYyBiL2h3L2Fy
bS9zbW11djMtYWNjZWwtc3R1YnMuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAw
MDAwMDAwMDAwMC4uNzBjZWY2Njk2NmENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9ody9hcm0v
c21tdXYzLWFjY2VsLXN0dWJzLmMNCj4gQEAgLTAsMCArMSw1MiBAQA0KPiArLyoNCj4gKyAqIFN0
dWJzIGZvciBhY2NlbGVyYXRlZCBTTU1VIGluc3RhbmNlIGJhY2tlZCBieSBhbiBpb21tdWZkIHZJ
T01NVQ0KPiBvYmplY3QuDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0K
PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gKyNpbmNsdWRlICJody9hcm0vc21tdXYzLmgi
DQo+ICsjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My1hY2NlbC5oIg0KPiArDQo+ICtib29sIHNtbXV2
M19hY2NlbF9pbml0KFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiYWNjZWw9b24gc3VwcG9ydCBub3QgY29tcGlsZWQgaW4iKTsNCj4g
KyAgICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gK2Jvb2wgc21tdXYzX2FjY2VsX2luc3Rh
bGxfc3RlKFNNTVV2M1N0YXRlICpzLCBTTU1VRGV2aWNlICpzZGV2LCBpbnQNCj4gc2lkLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiArew0KPiArICAg
IHJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+ICtib29sIHNtbXV2M19hY2NlbF9pbnN0YWxsX3N0
ZV9yYW5nZShTTU1VdjNTdGF0ZSAqcywgU01NVVNJRFJhbmdlDQo+ICpyYW5nZSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gK3sNCj4gKyAg
ICByZXR1cm4gdHJ1ZTsNCj4gK30NCj4gKw0KPiArYm9vbCBzbW11djNfYWNjZWxfYXR0YWNoX2di
cGFfaHdwdChTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiArew0KPiArICAgIHJldHVy
biB0cnVlOw0KPiArfQ0KPiArDQo+ICtib29sIHNtbXV2M19hY2NlbF9pc3N1ZV9pbnZfY21kKFNN
TVV2M1N0YXRlICpzLCB2b2lkICpjbWQsDQo+IFNNTVVEZXZpY2UgKnNkZXYsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gK3sNCj4gKyAgICByZXR1
cm4gdHJ1ZTsNCj4gK30NCj4gKw0KPiArdm9pZCBzbW11djNfYWNjZWxfaWRyX292ZXJyaWRlKFNN
TVV2M1N0YXRlICpzKQ0KPiArew0KPiArfQ0KPiArDQo+ICtib29sIHNtbXV2M19hY2NlbF9hbGxv
Y192ZXZlbnRxKFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsgICAgcmV0
dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgc21tdXYzX2FjY2VsX3Jlc2V0KFNNTVV2M1N0
YXRlICpzKQ0KPiArew0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL21lc29uLmJ1aWxkIGIv
aHcvYXJtL21lc29uLmJ1aWxkDQo+IGluZGV4IGIxODdiOTQ2ZjA0Li4zYmUxMjUyYzRmMSAxMDA2
NDQNCj4gLS0tIGEvaHcvYXJtL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L2FybS9tZXNvbi5idWls
ZA0KPiBAQCAtODQsOCArODQsOSBAQCBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FS
TVNTRScsDQo+IGlmX3RydWU6IGZpbGVzKCdhcm1zc2UuYycpKQ0KPiAgYXJtX2NvbW1vbl9zcy5h
ZGQod2hlbjogJ0NPTkZJR19GU0xfSU1YNycsIGlmX3RydWU6IGZpbGVzKCdmc2wtaW14Ny5jJywN
Cj4gJ21jaW14N2Qtc2FicmUuYycpKQ0KPiAgYXJtX2NvbW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJ
R19GU0xfSU1YOE1QJywgaWZfdHJ1ZTogZmlsZXMoJ2ZzbC0NCj4gaW14OG1wLmMnKSkNCj4gIGFy
bV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfRlNMX0lNWDhNUF9FVksnLCBpZl90cnVlOg0K
PiBmaWxlcygnaW14OG1wLWV2ay5jJykpDQo+IC1hcm1fc3MuYWRkKHdoZW46ICdDT05GSUdfQVJN
X1NNTVVWMycsIGlmX3RydWU6IGZpbGVzKCdzbW11djMuYycpKQ0KPiAtYXJtX3NzLmFkZCh3aGVu
OiAnQ09ORklHX0FSTV9TTU1VVjNfQUNDRUwnLCBpZl90cnVlOiBmaWxlcygnc21tdXYzLQ0KPiBh
Y2NlbC5jJykpDQo+ICthcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0FSTV9TTU1VVjMn
LCBpZl90cnVlOg0KPiBmaWxlcygnc21tdXYzLmMnKSkNCj4gK2FybV9jb21tb25fc3MuYWRkKHdo
ZW46ICdDT05GSUdfQVJNX1NNTVVWM19BQ0NFTCcsIGlmX3RydWU6DQo+IGZpbGVzKCdzbW11djMt
YWNjZWwuYycpKQ0KPiArc3R1Yl9zcy5hZGQoZmlsZXMoJ3NtbXV2My1hY2NlbC1zdHVicy5jJykp
DQo+ICBhcm1fY29tbW9uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0ZTTF9JTVg2VUwnLCBpZl90cnVl
OiBmaWxlcygnZnNsLQ0KPiBpbXg2dWwuYycsICdtY2lteDZ1bC1ldmsuYycpKQ0KPiAgYXJtX2Nv
bW1vbl9zcy5hZGQod2hlbjogJ0NPTkZJR19OUkY1MV9TT0MnLCBpZl90cnVlOg0KPiBmaWxlcygn
bnJmNTFfc29jLmMnKSkNCj4gIGFybV9jb21tb25fc3MuYWRkKHdoZW46ICdDT05GSUdfWEVOJywg
aWZfdHJ1ZTogZmlsZXMoDQo+IC0tDQo+IDIuNTMuMA0KDQo=

