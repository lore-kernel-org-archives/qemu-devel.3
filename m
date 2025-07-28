Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA71C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 07:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugIh0-00083W-4K; Mon, 28 Jul 2025 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugIUU-0005Wc-RN; Mon, 28 Jul 2025 03:41:46 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ugIUR-0004ZJ-MC; Mon, 28 Jul 2025 03:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjuSXeDYsSyqHvjcK7kcORCw/OIrZt3zh+veMYoeZ4T7UnH4GOf5utG/dMTPfl3SnBmoHM4d/adiyasRwGFCckITn63wXLJBtYFvbPrHkEkLxrYAVIRKlkiI+75tc2sgt4ElluXyQUShZGMueslsI97Zs0ewCtMJAXnI1G6PkFVvg8RK1KgswwMj37AKQMXP3MidGzROuX7smEyaclF6aVqZvW7kYQzFUgBrcwyLTA2g2y9NiCaANkYOFH0j/G/zZZW/8HgX2l4gwzOTBHztyy6g9B+4Pd3Aw5qiw3SxNoPWi6d8IZSUSYTnIuZ59jnMnzfO45qk0dO+yyShV9Vffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSCg9SpWbuyhjtkcDSEj7z+ye0BJEkQ+yO3mHzlmGq0=;
 b=X8iJyulxCEY1ISR8Kd7ksBQ3exbAATOuoAgjOL6PJmE23pZKWIcaCK8aFXS3mJ9NQwCIzvh1snxNOvOy0gfyUCkkBCDrYX0bUlzQMP3u9zhUcVoe0LDUk/eeyE/kwBY6aOSG8D54+W3hLzf2qIUjLwJaILmi4CacrTW8EwF7UCJ8o2l0pjNZXKzcJ1ptHeKHcwMToy8umB52N+5RGcYP9vkfmOhxrBr/yHfuy5xA3mwiT1RvAkJFh6LEzBRMLNXH5EKByKePVQolrh6rw3BPVrRwtTrVqeh387E1Ff+rRYnE/dajcgUunb+luBAn7IRTRQ58lnPrGgrPcosoAt05PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSCg9SpWbuyhjtkcDSEj7z+ye0BJEkQ+yO3mHzlmGq0=;
 b=e1DyOh2ad8YxPk9jPJqLca2KfsMIHxXEFK3H2Yw2+iBpmo/PR1Ky1KMJV7xgM7XKKfShI/CEPotTNfKHLJnFb1KRUkbngWIMen6aNRox6LTM/BvlblYuLVEmFepULWpyFsoFaoXrtQK0g0ScOri5geKD+X8Cpkp0MCvvuEdQo3kKXCsfRxxiwlJvHiHcvh0xV34AofvSBh9EB+8vRNmbJTi4Dz5KxoJqFgwxL3D0HSGmi5gYPoX8+jmOHAWpxNJ+Bf/PChk3rkXgBinjYflI/hBf4/6hw4FvyJ8eh+mPVF5Ij9nCKDVMJugaTlMvEVBH7sh16g5gAVJqkjdTdTQHTg==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by KL1PR0601MB5486.apcprd06.prod.outlook.com (2603:1096:820:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:41:35 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:41:35 +0000
To: Michael Tokarev <mjt@tls.msk.ru>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Hao Wu <wuhaotsh@google.com>, Havard
 Skinnemoen <hskinnemoen@google.com>
Subject: RE: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Topic: [PATCH v1 19/21] pc-bios: Update AST27x0 vBootrom with SSP/TSP
 SCU initialization support
Thread-Index: AQHb9sytNnqHTsl+Uk6K5yNks8BQkLRGchMAgAC3/gCAAAHtYIAABDKAgAAHqcA=
Date: Mon, 28 Jul 2025 07:41:35 +0000
Message-ID: <SEYPR06MB50373BF4F61F85E10DAC6E01FC5AA@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-20-jamin_lin@aspeedtech.com>
 <7e5dc89a-7b74-4a5e-8f51-55f587a4896b@tls.msk.ru>
 <364b86f6-6147-4e63-bcfa-932c39072130@kaod.org>
 <SEYPR06MB50372F288CD26111DD6E0D81FC5AA@SEYPR06MB5037.apcprd06.prod.outlook.com>
 <4e5dcd10-4f61-482f-b232-f29952294d46@tls.msk.ru>
In-Reply-To: <4e5dcd10-4f61-482f-b232-f29952294d46@tls.msk.ru>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|KL1PR0601MB5486:EE_
x-ms-office365-filtering-correlation-id: 3c1bd8b6-1213-46a3-8947-08ddcdaa2de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MUcrYzVCUmdNaWJ0TFhsR2pMQzYrcURIUUVOVlIrb0lhanI4ZFZqcmJJQkEr?=
 =?utf-8?B?eGhyQUpGVWhGM3VncFBPQUlIYlhDVEI2MzFvem9ESFR4NnlhMGpGMWtaWGha?=
 =?utf-8?B?RzYzQzNrYTlGK3VPQTY5d0VDMWttZzJBRy9mYWx1R1l3RDZvZGtkNndDUDZL?=
 =?utf-8?B?VHJWNEtZZ05oNmM0eUNwbXQwQXh0eHF1UUMrRGxCSGU2Wk1HVFlmNEpWNDBq?=
 =?utf-8?B?QUtGSyt3YUI4cGZKNXI0KzdTeEJuRm81M2xkeVIvaGw4REIzZHBITTBJRmdw?=
 =?utf-8?B?anFUYnZ2S3hTR2kxbGZKeXVndFlxTmJydFU4eHM5c0tETml3eFNSbXVjWHRG?=
 =?utf-8?B?akNPZndwZHF1ZjQ2UjNBUHNERlJGSVRkeHo4TU1sOUpuT2s5MmFzTnNvaXdH?=
 =?utf-8?B?Y0lDR283aEpUNlRBZlYrazFML2Q2V25pZ1VRcnVoUExSRThFL0FyZ1BjRVpB?=
 =?utf-8?B?VnlLeG02RHlkcUs2VTgwaGJtSmZpRDR1M05RUms2K0cvVDVnMVU5QlN1d0Ez?=
 =?utf-8?B?ckR5QmFoSklPUUk5QkRMU1BacnpxV2lReDBRemNSTC9oMS9DOFQ1SnQ2a3po?=
 =?utf-8?B?MjNINEl6Z3dpSUM4RUxrdEdNbnk2QXJROXhzem1mV3dGdUtja3lCSWZTY3Yr?=
 =?utf-8?B?MkZab2c4VmZYenZnRm9VcHEvTXFDamVQQTdyaGZKbTg1ZTQ2RG9UdVF2ejN4?=
 =?utf-8?B?TCs2NFlwYmY0WGk4NmhuY3BtcWVDZmtlS0UrVXFRWjdNM0h6Qk1pZk94Mllw?=
 =?utf-8?B?OGdvOWM5NDVxTmxjTVIreEJhS2x5cXAxd1FzRWFRR3hSYzkweU43SnNEZ0xI?=
 =?utf-8?B?Z1pySVl3RFR1akVmUzdsV3drRW9iQXRaV0VXdXBjQ2puaXNTUXE1czNNZUpr?=
 =?utf-8?B?Mm9uRTAwQjJvYlBoUkNYOEJWR3J5V1JKcnVaMUpzbGZFbkpsYXNQZ21lakgv?=
 =?utf-8?B?MnhYQ0xRMURtaThpb1NDeVo0dkNZc2xXaGxXbXRaN3BHNG1HZlpRNDRMSVBH?=
 =?utf-8?B?MzF1MDNzZ2lyam54bXcvZEZvZXNUK09ZNnVocFllaU5wb0t6N1hneWRRVW1o?=
 =?utf-8?B?OWRVVC9pbUNUSit0S2tXL0tkQnlWampUdEpSZFJVQk9PQ1Z5bkx0cXZFYktO?=
 =?utf-8?B?SjBnaXlWbjRlRi9rMHFOY1Z2Qm1VZDAwMkFUNmxNNHBIV2IzS1Q5bE1lSDdV?=
 =?utf-8?B?U2FWRFRyd3FBRUFQNlhrcHVoVWVMWnlXd0ZYWEpadU4wbmJwRmlNdWJUa2lu?=
 =?utf-8?B?dDF2cmtGYThuNzRzM1M2cmRxWXRBUE0xZXRJSzBBRFYxeWp0cjBETWpreXd0?=
 =?utf-8?B?RTg5aWhsaHBFdnBtKzdOTkVDSTRWM0RVNlNaZHRGYmtDVG8xbzdKQU12U3ly?=
 =?utf-8?B?N0RrT0dtUWx4RmprSzVrQVMwREpBSkE4L1FIYUNtNkJvRFZkTis0Vm90TTRG?=
 =?utf-8?B?VCtzNVFxQ3BmaFVZSXZZMXhYcm81VVNnb3JBYThKbkhnQzd6eWN2d1BpY1Nv?=
 =?utf-8?B?NXVUTmJiblI4d0FTVi9BRk1qelphS0NwV1JlUnFqOVp4bEpmblAvbUxldzNt?=
 =?utf-8?B?aWRJekJlVVZkN2ppdnowT3hDTWxzUkZySHpQbUdtVi9saCtOallvR1FhYnl5?=
 =?utf-8?B?RitYaEE3cGlCREdTNENlQlF4bXYxT2VYT29zUnRQT1BWRG5oVUxWd0E4Q2R6?=
 =?utf-8?B?djBZZUVMbVJCdFN0NDBnM3pCdlZzNzhjS2N6RFpUenBTNnhwdkJmZXptaFpS?=
 =?utf-8?B?TkJETmlXZVpMU09VbWZkdXBQZC8wZWI4MHgxZGllbVZzOWxlMksrUmJoMWNM?=
 =?utf-8?B?Si9rTXRjWTFXR09SNmV1d29vdlBqVTZQVU9VeVVxcm9qakk2WXA1THFEZVdH?=
 =?utf-8?B?aEZ0ZWo3T1QrbDcySE1BVlc1T0JIMS9Md1R4blc4Zk1vT3RXcU1WREpKa2Vs?=
 =?utf-8?B?VUhjSFRmeVJtTTFUbng2T2daWlRXb0ZhbU9XRmZhbUJvNWE2dElPV0s3RGI2?=
 =?utf-8?Q?G9pYb116pjIRlrPhxJP1HH6RFAgYrE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHMyaW9tOWZIUEI4MXZzQmlnWlFHK1FnYTVDQWJlTndSL0w0Ujh4OUFUREpY?=
 =?utf-8?B?bUVBdDJrZHUrWnF5OXJyTW9EL212SS9ZdVdSdW5QS282K1JCa3NSdDdmNjhP?=
 =?utf-8?B?cmI1ZDRhODVaTzFmUWVBaDdJNzNmTXZaNmVOcEFEUTBFMzZKMWhuQXlIL3lE?=
 =?utf-8?B?NGxmTmF2Y1VadmN4Tmc3aWhTZUhKRjd2RnJRWWwxelkxSXhXOHZGaDZtWlQ0?=
 =?utf-8?B?ZERoVkIzdDNVSlFnbUIzL0dueXhuMkZYZmZHQXlacWVzVjQzYlFFNUlEcEcz?=
 =?utf-8?B?bzZTUkpQbkRjUWR4WnBTN1dSMHA0VXoyRjh0Uk1RZWxGR2EzRlVwRS9wSDhv?=
 =?utf-8?B?WVdxdHZhN0lDZENud2dLcHdHUDdBVFhGdkNDYUhBN0tPcXRsSWZqZ0U4OEpN?=
 =?utf-8?B?UW5GOURIY2tpczV2NHJvUjl0aDQzRFBrQVZKMkxlSmMvN3IxQjFqUCs4NzBk?=
 =?utf-8?B?MENydTNPMHBnOEFDbzd0VFZieCtWRGhZYkFzQ09NTGs4eEZHSG1lRS9reG1m?=
 =?utf-8?B?UU96SHlsRkxEaHN6UDVxbDhUY2ZBTWRGWUQxc2gzdzRHTkN6Vzl0ckwxQjd4?=
 =?utf-8?B?WjAwVHJZZk5DQ1pTTkdDRmo4WitUUzRLSlFObXY2NmVkekFxU1RGUVA2M256?=
 =?utf-8?B?Y3pOSTllRVNMQnNxTEI4S25YQnQxUGFtSlY4OFJNV0QyakFJNmVSMjA3VWN4?=
 =?utf-8?B?TlR1R3l4NlJabTNSRE9DVHZiejBUYkxzSHg2ZEdiS05ZdFBqbzY2b1dqOGRu?=
 =?utf-8?B?Q2pOTGpCYlVZSDVudGc2MnorQzk3WnB4TXdwRGJVdFZHdzhVUjMrQ3VybzZW?=
 =?utf-8?B?SDBrMUErNVNycU5MQmVtU1EzeStaNlNMTkRHNmx4Tko3N0Y4Y2Z3aVdmdlUw?=
 =?utf-8?B?aHFUUG0vandyQ3Z4a3RaQVNVWUl6VWsxS2Z6NHpoYk5JTDJGM1BlVXlFSHND?=
 =?utf-8?B?MUNlT3BDckdRSFpBZUZpQlArS25GaGg1bWNFNWp6enJlTytpTjlremdITkdI?=
 =?utf-8?B?UzZzcERMRkcvL1FTNlp2Njdpdm52KzBEdUVFc1FQazY4ZHg4RlAvZWp2Nkcv?=
 =?utf-8?B?U3JFOThqNnM3S3VwNVE4blJUYWNtMW9xcDhlZ3VtNGJZdjN4cURKWEhEV0Z0?=
 =?utf-8?B?UFlTcFpRVjU4YWRHTFFTQm9icWJzMGhveXZseGszS2VwNks1OFNadkVGU3cx?=
 =?utf-8?B?SjRzRUpnaWlJRXI0Wnl3S2NRdGRjOVlibjgvSFI4WXBvQlJMMkhVdmV5MlR5?=
 =?utf-8?B?VUp4djJZYWlNZHhNK2JQc2cxZ01Xa0NMdTk3WVZudTIvbzVjaW1CSW9QdXND?=
 =?utf-8?B?aTUwbDJSc3ZHV3JRTjFncVpnbmJyWW9VbTY5N3FVWTM3S0xXeHpmRHhlamtt?=
 =?utf-8?B?U1k4WWhycG9aWHBnZlVDNittWjE2aTY2SS94WUpwbmQ3KzQ5akhMdjFydTVO?=
 =?utf-8?B?ZHg3RUVIMmlKMGYxMTVDYkRPOURwTm5DOXNQcWhXN0E1Q2hyUG5ZaGJvQXk0?=
 =?utf-8?B?aXBXOEtKN0F4ME42S0l5VXdNU1dSOE9RUVJZeDNoYWRwNEtOQkZBcUVpSTZT?=
 =?utf-8?B?TzlCTDN4RXo3YlJNWXhuY2JCWEtwMjRLd0R2Sk9Yd3p0Zldidk90YWFXZDZu?=
 =?utf-8?B?WUdIT0FsWmdtSVRWVWlGQ2FJRCtUVVFYVnI1UDhoc1dZenJyMWVGRkllWDhL?=
 =?utf-8?B?QnR2S1Q2TUpVdGFVV1ZReENpRG9SSnJBRW5rZGk3bzEzU2NOREk5TCtXUi8w?=
 =?utf-8?B?WCs3MTBQanlIcnUrekhuSWJFSzhiYkNTNVE5UmkyVXB3QldYYldSWGZFN3B5?=
 =?utf-8?B?VC81WHl5VWFkNGdmUmk5azFrTGsyOVI4VXUySTJlbmN2WS8vNTcySVk1aU5N?=
 =?utf-8?B?N1B5MXgrRlpPNERJR1F0YnNMWjJoQ09TOCtVdkdGU0ZkRklDbTJxdkdsZ0lq?=
 =?utf-8?B?T1dYcHFFYkFiaTd6VjlIa29ZcHBnWEhIY0pWbGVVRGM3MW1EekR3eWlZbmNJ?=
 =?utf-8?B?UldEK1VEbk9WaEprd0pabDFKeFdUT0pTMjJnZ3V6NGthOVFBNE1sNlFPQVVn?=
 =?utf-8?B?ZXZRdFZhT2xGc3dWR1ExR0hyOXVJN051Y1FWOFYzZGpMbXFtOXVKbU5XVDBk?=
 =?utf-8?Q?wRQqcAIdvrLioopgP/chsczK4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1bd8b6-1213-46a3-8947-08ddcdaa2de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 07:41:35.4653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi48Xrw9YKlCbpORP7ajHQL6s1uO0Wj8yphGHuqMDmywk3QQfKE6a9resaHYZaGiwUWFOrc8nDO0rcDoNOGLJy78VNY65YGQUGDtA2ciJWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5486
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWljaGFlbCwgQ8OpZHJpYw0KDQo+IEZyb206IE1pY2hhZWwgVG9rYXJldiA8bWp0QHRscy5t
c2sucnU+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyOCwgMjAyNSAzOjEyIFBNDQo+IFRvOiBKYW1p
biBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
a2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBT
dGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUgPGxlZXRy
b3lAZ21haWwuY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBvcGVuDQo+IGxpc3Q6QVNQRUVE
IEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVy
ZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFz
cGVlZHRlY2guY29tPjsgSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29tPjsNCj4gSGF2YXJkIFNr
aW5uZW1vZW4gPGhza2lubmVtb2VuQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEgMTkvMjFdIHBjLWJpb3M6IFVwZGF0ZSBBU1QyN3gwIHZCb290cm9tIHdpdGggU1NQL1RTUA0K
PiBTQ1UgaW5pdGlhbGl6YXRpb24gc3VwcG9ydA0KPiANCj4gT24gMjguMDcuMjAyNSAxMDowMiwg
SmFtaW4gTGluIHdyb3RlOg0KPiANCj4gPiBJdCBzZWVtcyB0aGlzIHBhdGNoIGZpeCB0aGlzIGlz
c3VlLA0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVs
L3BhdGNoLzYwN2E5NDNhNTg3MjQ4ZmINCj4gPiBlMGZmMDg5N2RlODBhZWU5OGEwOTNjYWEuMTc1
MzY1NDUxNS5naXQubWp0QHRscy5tc2sucnUvDQo+IA0KPiBZZWFoLCBJIHBvc3RlZCB0aGF0IHBh
dGNoIHllc3RlcmRheSBhZnRlciByZWFsaXppbmcgb3VyIHJvbXMvdmJvb3Ryb20NCj4gc3VibW9k
dWxlIGlzIG91dGRhdGVkLg0KPiANCj4gPiBEbyBJIG5lZWQgdG8gdXBkYXRlIHZib290cm9tL2Fz
dDI3eDAvTWFrZWZpbGU/DQo+ID4gSSBzZXQgIj89IiB0byBtYWtlIHVzZXIgYWJsZSB0byBzZXQg
dmFyaWFibGVzIGluIHRoZSBjb21tYW5kIGxpbmUuDQo+IA0KPiBUaGUgcHJvYiB3aXRoIGBDQyA/
PWAgY29uc3RydWN0IGlzIHRoYXQgQ0MgdmFyaWFibGUgaXMgYWx3YXlzIHNldCBieSBtYWtlLCBz
bw0KPiB0aGlzIGxpbmUgYmVjb21lcyB1c2VsZXNzLiAgVGhlIHF1ZXN0aW9uIG1hcmsgc2hvdWxk
IGJlIHJlbW92ZWQsIHRoYXQncyBhbGwuDQo+IA0KPiA+IDEuDQo+ID4gZXhwb3J0IENDPWFhcmNo
NjQtbGludXgtZ251LWdjYw0KPiA+IG1ha2UNCj4gPiAyLiBtYWtlIENDPWFhcmNoNjQtbGludXgt
Z251LWdjYw0KPiA+DQo+ID4gMy4gVXBkYXRlIE1ha2UgZmlsZSBhbmQgdXNlciBvbmx5IG5lZWQg
dG8gaXNzdWUgIm1ha2UiDQo+IA0KPiBTZWUgaG93IGl0J3MgZG9uZSBpbiBvdGhlciBzdWJkaXJz
IG9mIHZib290cm9tLiAgWW91IG9ubHkgbmVlZCB0byByZW1vdmUgPw0KPiBmcm9tIENDIHZhcmlh
YmxlIGFzc2lnbm1lbnQuDQo+IA0KPiBEaXN0aW5jdGlvbiBiZXR3ZWVuIDEgYW5kIDIgaXMgYG1h
a2UgLWVgIGNvbW1hbmQtbGluZSBzd2l0Y2guDQo+IA0KPiBUaGFua3MNCj4gDQpUaGFua3MgZm9y
IHlvdXIgaGVscCBhbmQgc3VwcG9ydC4NCkkgY3JlYXRlZCBhIG5ldyBwdWxsIHJlcXVlc3QgaW4g
Z29vZ2xlL3Zib290cm9tIGFuZCB3YWl0aW5nIGZvciBnb29nbGUgdGVhbSByZXZpZXcuDQpIYW8s
DQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IGl0Pw0KaHR0cHM6Ly9naXRodWIuY29t
L2dvb2dsZS92Ym9vdHJvbS9wdWxsLzEwDQoNClRoYW5rcy1KYW1pbg0KPiAvbWp0DQo=

