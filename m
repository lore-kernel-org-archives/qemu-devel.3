Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C69C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0ZN-0001zI-TE; Tue, 25 Jun 2024 03:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sM0ZM-0001yT-9X; Tue, 25 Jun 2024 03:26:24 -0400
Received: from mail-psaapc01on2071e.outbound.protection.outlook.com
 ([2a01:111:f400:feae::71e]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sM0ZK-0002DT-II; Tue, 25 Jun 2024 03:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwJotty4Tr51AVkX8QBfdKx6KXwo0JK8vE2ZS0NX4zFiPeyZVWOZd++rZX2psj2pGAdhKMvc7V2vkw+P/jdEwoamMU2LGiCCk6sds1pmgYTfCWihYmRk1F4dE4R3zF85cT7M2yb0PTngim6xqiyW1wQjyNQoOsiCKjagtv66UjjtU4eUF11r8o5esbBJXKrqN//Q+Bko4EnMHQlAgOucJZxQTjouuQtSnK4r19zbNgC9iIhvwYAQc80HfIUg4dsY7TuNS80AP3zGlOIrO4qsnDVXgT64arOj4VpEf8AiLw2/YxHxGI74FVkXso2hQVS5X/zHfN07MNYxXG3t4Rs6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOFH7Z9O1oR/JAyAnakrCcZV73FQPVY5fiDa2LoVNaA=;
 b=MHANSNBhyfyxC9GjGCwPrVmfJFvazgrBpvb5Af+C+eB242CCnKe13AZvyvp7As9+ccV8CSza2fMrH0sy6N0o7iiDskuOuN9+pHS1z6260kCQAD58+2AUlFui8dwdR/+NmdVxkT5tQzggLnywbllWkIEoBTimC0FAuZNMJgOUVPsmyKk/UtRK+E8szzrnEo7BnSUpP19uFh+N5Dir5yymgRIrMb/SxZgcJp905C7Nt3tYbJ93lPLfl3Y08uBd2YyAdOSSE/+7N09/uZWEgIu8aMGH1jQWk+9fFAioSTdqjWrCPpyhfnYUA0eUSD8kkVuVNxU1vz3ydfr/lr35YvBO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOFH7Z9O1oR/JAyAnakrCcZV73FQPVY5fiDa2LoVNaA=;
 b=e9lpslaPBMkO6NcPVkOjhsxrUIAzZEwC+gqWXtaOCWWFI1p52MVVDJRabQscXazFdD2jjSF9AU8LykFrexMUox6wMQ9xen9G2oQz5fjSBwS382DcjcST7Lihbe60VlVnaqRnLZjXdYISMAb89Bj3GIeLecViNjcJ6T47QJ+WQSv0iDdSIrsvSwfqJBruLQ2pDTegB6bg5q6EH0bMZEvkNPMzJg11Wp4c0QJCp9ShNbHZZfjkeXEjeBxA6jf5W4ajERtFDj35BiFtmknpmA7C0qXLOwi0I/F6CVbFtVnXUzklkkv1JjNRocWaSsaRVq2dUcIZmAU1jQLNf90QkPcEog==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6835.apcprd06.prod.outlook.com (2603:1096:990:4d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 07:26:14 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:26:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 0/2] Fix coverity issues for AST2700
Thread-Topic: [PATCH v3 0/2] Fix coverity issues for AST2700
Thread-Index: AQHaxs5iDI1Qg+SaBk2v+NMM+okf67HYEzuAgAAA9aA=
Date: Tue, 25 Jun 2024 07:26:14 +0000
Message-ID: <SI2PR06MB5041E6DA2575769E07C2B58EFCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240625070741.2852946-1-jamin_lin@aspeedtech.com>
 <5bf32b3a-fe8f-4ec6-8133-4851d28eb90f@kaod.org>
In-Reply-To: <5bf32b3a-fe8f-4ec6-8133-4851d28eb90f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6835:EE_
x-ms-office365-filtering-correlation-id: 72a9f53e-8d4d-4479-36ec-08dc94e81857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?dW9vcUxFVFFmTGxFVG1DL2puNnZCLzNpN2t1cEc5Zzh3L3dpdG9uQ2x3OFVW?=
 =?utf-8?B?ZHRVUVJXTFVCTFprQ243eHI5NXZXRDRWcUY2YWRmN1BTQUFaOVZ3V3dvcEtr?=
 =?utf-8?B?dGZiREM5Szk3U3RmTlpoaFhzWlBpNGtRYmdVbUJaa1BFczZEQkd0Ync3R09C?=
 =?utf-8?B?NnNMODdVUXBrSGg5eVZtTHRtdXc3dFRrWmtyaERFWHNSQ2hOd2RvUXE5Nk9W?=
 =?utf-8?B?RzhPejZnRG9NZS8vd1FYcUtZT1pZSmdwQUJTbVJZYmhWUzRXOVVOY3F1K3Rj?=
 =?utf-8?B?dEdVWjh5RHhFcXBwbXVLN3ZOODh5WW5NNVFlMnZXQmN6OWc4ckJ3a0hHakp1?=
 =?utf-8?B?WHdJZlA3Zmc1RUM5a0RwcnFrWW41TmFyNzRldXBXN1J0cHhGald1RDFjenpF?=
 =?utf-8?B?WHVaNzVZRVk0QzBHUS81VHFvbGljUXZhN05ETXJBNU4zRUZleFZwYWVDVkZ0?=
 =?utf-8?B?UDFtQzRFZWMzOUdwQ0VydTl2R1c3ZHNvckR6dC9hREI4UG9kbEt6bm1nUHd0?=
 =?utf-8?B?N25WeS9nMEh3ajFmeHVpSXlaVU5YRWpUWTc5bktLcGFXdDE4UVRwOW5rcXcy?=
 =?utf-8?B?UU02d3lsYVB5QkZHWitjRGZtTWVrQVd4M1NkZFV3WnJDblVpdWRTTHV5Y3g0?=
 =?utf-8?B?ZHVvNkxkUVRxU1VPM3l3Q0NSY1YvWVNZcFpBZmNjTEUyQVdwclRIK3hvWlNP?=
 =?utf-8?B?b3NoUGRNUVpyM2pTejB6UExiK1I0RXd4Z05sd012elFKbVAxTlk3TFNBRTZN?=
 =?utf-8?B?NUVadFdVMzQzN3I0NmFJVkw5TDR4ZVYrZWM0T0pOT09WZDh0OEluQXlFZDBr?=
 =?utf-8?B?NzdYODJha1VyZEZEbGZyNkNQVkRMN3RTcDRNUG43aEJCc3o4bmgyYXFSRG5U?=
 =?utf-8?B?L2F6ZENPUG5Bek42czl6S0IyQTdaait5NEtDVVJyUmlxSmo5VjN1T2U3N3B2?=
 =?utf-8?B?RGdnck1HTVExTzV0eFNQR1hxVCtXTzNzK0NJelRINkptcVI2VmtuN0QvU3Rt?=
 =?utf-8?B?cWpJcjgxMS92d2J5VFF6eHJRZ0RNRHc1d1hzMHRMcm9Qd3Q3WnhVc1l5eXJR?=
 =?utf-8?B?NXVvTTdyV3Z1L2tFWDBZdnFnZUZOOUlhQVZrakxXN1paYVZaWWt0Z3N0RkNI?=
 =?utf-8?B?V2tiYkFhTWZxUnQ5MHFSOC8zQVJybGNldzFCQzdYd1YwdTdMYmFlQzF3djN1?=
 =?utf-8?B?eUxmL2J6c1lwd2RJTnFWaWZ5N2lGSGdqditCNlBsc2hSamJQOCtMNEllbmw2?=
 =?utf-8?B?NmV2TUNOZ1ZpMEphMUp3MkVYcVFtdUFCb1NhSytRcmFseUJpQlNjbjRkOGxW?=
 =?utf-8?B?b0p6dFZTdVcxQjZoTlVESmFJUnp2Mng2SmgvYzNMNFdydlVZNXNKQmo3UzNK?=
 =?utf-8?B?RGF2SlljWnQvRVpiZGttOTdXdDhvS2FCL01hbHVpMG9FZHArN1YxVGtTbUw1?=
 =?utf-8?B?TUtIQXJNeC9hM0FFU04zN2JPNDdZdUp1Vmp4dnMvYjJjWm5BbWo1TUQwdjdM?=
 =?utf-8?B?VlEzd1BhQVd1MldVdDBIN2w1YUtVdktYRm5TaFBCa2lPb010dCtRR2JHaGxT?=
 =?utf-8?B?NEE2NnVuWmx4cHkyR2VUWmpneFhTdVBWZFRXYldCSDh6RE5xRmlXNjFhSG5X?=
 =?utf-8?B?KzBPSzB3SmdGd2NTWmphQnpmL1FGMDlOR1hrWjVvRXo4SmJPdWFjZVFnM2JJ?=
 =?utf-8?B?V2QrT0NNVXpHNW4xNHFLYjkzaVBoUWZyVlVwWllQZDAyMHY3eEl1YTFDa0dw?=
 =?utf-8?Q?K4oYR5J7tAQi/WNt98LYRK7IQ57dyIIudLXG2I3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ZWZDdFUDRLd2Q1cmU1Y3B4MzVLUXQraE9OV0UwODlZNG02UW4ydllGejJV?=
 =?utf-8?B?LzBvOFZTckl5cUZCY3k3MlNUaEZMdU0xcnluZ3VqS2lEOVVHbWJoTkRBSEE2?=
 =?utf-8?B?OUloeXlmRU44Z2xiM1FLOVE3czJBVzJPaGxTSHVDM0c0VVBOc2V4cGRZb0tT?=
 =?utf-8?B?c0RhMWxETW5IYVR2TmYvT09pS1FVV2x3QXNvQVkwejhNM2F5RlJRUjFXOGRZ?=
 =?utf-8?B?bnFpTUNNK29keUNCSlA3MzIyZzFPSno1eXNHSjBaUlY2WjBwOC9HZno4L1RW?=
 =?utf-8?B?M0UrbHo1SGZMdHBaWU1iWlp3ekpZMFhDdkRqYjB4OUh4MWJQaFNzZXh4eFBU?=
 =?utf-8?B?MFZrN3JHNkdMMC92VHBYcUkvaFprR3U1ZWVuWWJvMTVveGk2RlphOVVJQWVm?=
 =?utf-8?B?NmQxOGo4RUpNSjhndkhpd09xeXpvRHU4cTV3UWNYQ3JvVzlpUE9NdVE1a2Q0?=
 =?utf-8?B?TFp6SnBUQkYwSDVISGdySFJrWjJNUVphTzArWGN3UE1CMGlBZFBoZFF4eWtx?=
 =?utf-8?B?alVhNUpVdGl6MlNObjMyUGp3NWFrUStqRFYwMTgzV3VmYlhSMGhFY2FqVVZK?=
 =?utf-8?B?Z0dMdTVoK0psMlB2U3ZXclNrUjZpcFlRVVJpdVRPbmxnWmpNVTh2S1ovaGZQ?=
 =?utf-8?B?aml4WEM2V1I4dTUyMjRsOU1VY2s4WU0yaGhtakpPZDhCUzZTdFBSaE1VMSsw?=
 =?utf-8?B?emQxcHNML1I0K0d5NU41ZTBnazdkRG5ldGFZN1lYSktvdUtlMzhIWE5FRzU2?=
 =?utf-8?B?MU1YQzR2bUI3S0xyZkgzNnFmcnZLZ2k1d2J3VW9uV1M0TTFhdjZmVHhNdkk4?=
 =?utf-8?B?cFA0ZE5ERG9DUmlhVTFnUnY1NVRVcmVidXg0a20zQ2YwUGxwUVhlMXhMMEJq?=
 =?utf-8?B?bU53bldNU3NRMXkzNlJzQjFpbVVodmo3akdFc29wWGZES0EwTFZWZ2NrOSty?=
 =?utf-8?B?NDlJYmtDZW5DdmUzY1pFSEpDYk13N2Z2TDVGcUM2QTlna3FtRDNmd2xudHEr?=
 =?utf-8?B?dGZhd3VsN0pBQmx5THBHODlsUExid2ZraTRmTk5PNU5YeUlwRjJsR3BXYXVI?=
 =?utf-8?B?TFZoMUwyZDd5QVkxOC9wd2liUU5jMjZ3RGhLZzlxZWsvZlpwaWFzMjBaMzM4?=
 =?utf-8?B?cW5XZFhCd2xKaEFwK3NxT1hURm5Ma3dpcGlyVkwzQ1FNSFVhakhUTlpBS2Nx?=
 =?utf-8?B?Z0p6eHVjcVRmbXdmaWtWckw2VEQvdHJDa1k0UzBLLzFuUFNPNC9zalJXMnBQ?=
 =?utf-8?B?SS9jKzRqUnd1RzRtQUdmVUdQT3U1citreWxYbUszNVV6dUhGWmpDMlBqOUFZ?=
 =?utf-8?B?MExBejZ4R1RTZndrV2p1c0UrZVFuUWdDZkRnYzJlWUNOdGUwRUF3TDVBVy9a?=
 =?utf-8?B?Z3NJWFNVNmRJaWtkNVdld1NIT2tPTmlVWU1HRjdMYnUyQjc0eUloUEVaN0ta?=
 =?utf-8?B?QnRYL3lzRGFrTmhZQ3YwMzJwTFlUaGNxSWNzNDBpUGhnQW03NXpjUzczR0dR?=
 =?utf-8?B?UjlObnVGNEZEd1hzTTdyNXk3ODc3TnF3aHpQaXhiRnJoTGMyZSsycTV0OWpL?=
 =?utf-8?B?OUZObnpQZXFPK0dGbTlVQVpnbFBleTlWeEx1RlZXODdHODJJSWhXaWFXQjhF?=
 =?utf-8?B?bzFpUVNqV21COFFBUWUzRGFpWEpjNVF0aStLUzFQc0krUmN2REdNWkR3RlZi?=
 =?utf-8?B?ZS82MjBSbUtEdXRBaHUzT1hNVE80RkFKU3NUWVdUNXVtSHVsRzd1eXUzMFc4?=
 =?utf-8?B?SDZSM25jdTF6dXVtMUI3d0dOQTBqWDdUTUs5YzJGblFLMnJGYVdJNFc2Mk1r?=
 =?utf-8?B?am1pcWQvejhPRklZeEZDUjFZSmxha2NpZDRjNSt1S2ttTzV6RU5nWVpWVTg2?=
 =?utf-8?B?ZW8wOXJjZ2o1WGpEYjA2blZtNWJaRzFYaS9HTXJlZi9TYlRHOHF2bVZXRW04?=
 =?utf-8?B?a0w1MWJNMHJENk0vL1BoK0JWd0wwRjZnbEpLS1RjVmlhRUhLUjJYcDlWM2pB?=
 =?utf-8?B?ejkyMWUwU0hxSHFXMkdleEQ0Q2Rac2xhUzM2djVHVkFiN0dQdXZlVEJWSG1o?=
 =?utf-8?B?RXZFNnBWS2ZUWTNNQUwvOEh1Q1dzSy9TekNTQ0hiOFozYzRETGNQdm5Lci93?=
 =?utf-8?Q?Mpsre/KE5uPm7jmIASArLm3Om?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a9f53e-8d4d-4479-36ec-08dc94e81857
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:26:14.1069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1yY3xcqOdBBLi2mpuGD7TNPrmgg1uRO/dQe2Jt64CoOus4K2l1no80s4xIc0l4qrlG3junNM4Gv6JlXx9TeRLowV7/QTBUx4xreriDqhbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6835
Received-SPF: pass client-ip=2a01:111:f400:feae::71e;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDI1LCAy
MDI0IDM6MjIgUE0NCj4gVG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8
c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNv
bT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiBKb2Vs
IFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11
LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzJdIEZpeCBjb3Zl
cml0eSBpc3N1ZXMgZm9yIEFTVDI3MDANCj4gDQo+IEhlbGxvIEphbWluDQo+IA0KPiBPbiA2LzI1
LzI0IDk6MDcgQU0sIEphbWluIExpbiB3cm90ZToNCj4gPiBjaGFuZ2UgZnJvbSB2MToNCj4gPiBh
c3BlZWQvc29jOiBjb3Zlcml0eSBkZWZlY3Q6IERJVklERV9CWV9aRVJPDQo+ID4gYXNwZWVkL3Nk
bWM6IGNvdmVyaXR5IGRlZmVjdDogQ29udHJvbCBmbG93IGlzc3VlcyAoREVBRENPREUpDQo+ID4N
Cj4gPiBjaGFuZ2UgZnJvbSB2MjoNCj4gPiBhZGQgbW9yZSBjb21taXQgbG9nIGZyb20gcmV2aWV3
ZXIgc3VnZ2VzdGlvbiwgQ8OpZHJpYy4NCj4gPg0KPiA+IGNoYW5nZSBmcm9tIHYzOg0KPiA+IHJl
cGxhY2UgcWVtdV9sb2dfbWFzayB3aXRoIGFzc2VydCBkcmFtIHNpemUgMC4NCj4gPg0KPiA+IEph
bWluIExpbiAoMik6DQo+ID4gICAgYXNwZWVkL3NvYzogRml4IHBvc3NpYmxlIGRpdmlkZSBieSB6
ZXJvDQo+ID4gICAgYXNwZWVkL3NkbWM6IFJlbW92ZSBleHRyYSBSX01BSU5fU1RBVFVTIGNhc2UN
Cj4gPg0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgfCAyICsrDQo+ID4gICBody9taXNj
L2FzcGVlZF9zZG1jLmMgICB8IDEgLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiANCj4gTEdUTS4NCj4gDQo+IENvdWxkIHlvdSBw
bGVhc2UgcmV2aWV3IDoNCj4gDQpEb25lLg0KVGhhbmtzLUphbWluDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDA2MjUwNjU4MzkuNDg1MDM0LTEtY2xnQHJlZGhhdC5j
bw0KPiBtL1QvI3UNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

