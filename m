Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A25D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 06:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3r7V-0006KW-2d; Thu, 24 Oct 2024 02:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3r72-00067R-GB; Thu, 24 Oct 2024 02:14:29 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3r70-0000aU-B0; Thu, 24 Oct 2024 02:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRPcklqRSpIfX6xyf7CUdib8mZajKcOYpf8VFdP3x8EjAcuGDIF5IufFVIZSR7HbRIsrD0Xfs1le5AhrVwQnbVqLbpSDL5ByRIx5c23QDLsCuCSvI5k9MGxMzTUtTEdgy7dmSKwP+K/k58Gt8gpJoS3n+WTz6A35Xx6aYhmWmSAjr2hfQ3sSf/TIrtf2sxMzK6cGAjvfJE/C34C+lMUTusMI/ekYCzuYOdGaQAGDjBg0SDaO9XyDXPawfdONypp0zlz81MTRLZUlQkYlojUuyIf+8vK9fxoiS9IW6OiZOQYV8YaRyNV9YBSYMt+zGrigQwOHhbhk0jNtHraO70Pbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCX2SxVpl920cU7YssGwjlUhMwWLQ7zLa8zqfLG3ifI=;
 b=X4FL8YjjspXWJ8OpGO0rPgoCXaxyr50eZxhaR4JcfiJ3WUuXqjV3xbdsM34D5puKb039mWoywA64GwI+q3VCr0SCgq8T6TvGgu6hucRU2ItJeYo0vM2Q4Lr0oGgtuEG9t/4Wb4YPLJbBiTISAetox+9FBpeZoSjOxDiEq6V1LY7fZ8VRrNYqExxDGavLe42GlBLQq/CxZfbMcEmHNiUSWB6KmfI4MQuqmcPsFYzGsZycNk9jI4uukcGuPpojf7+qpo0p1VEUp/r5uCY1lkILvUFM+dVs4CzOBr/jv5DbOlBc9fJ/QTPtbXhBRNQXV0iSr1quPCFV3E7vVn1R6L7GZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX2SxVpl920cU7YssGwjlUhMwWLQ7zLa8zqfLG3ifI=;
 b=bNeJCuRxZuffNHxbjkv1t/rH6dp2yMgsNRJBhTmh2dh2nZI4T8Mofls9FpHA2uMZcdxTn+Yd8HUbdD2dkfF5AG9uiGe9BUlcgrsRU9CP5zojgx5bH54HIuaFImnWDQ67gUcRTtT5uhTbhUsFR6jst8itHMzOHGtc6JpOPD3zHvyX+H+pD890hNY/8EUCKzl11Uw1TH99sox0ZUN4QCQBGf7Fp444D5LKulMbJOfYIC5/uB5cN5n2m/SeBkMev8Omt5HWhJCwD6fLYjTaZHJipr+0NnJJFfE8AR5LLDfcZ/VafL2yFAX9crEHrFZn7BNAp5u7SXxvmMi2Shm+UIpaBw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6833.apcprd06.prod.outlook.com (2603:1096:990:42::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Thu, 24 Oct 2024 06:14:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 06:14:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Topic: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Index: AQHbJGaQVsUKUjWOB0e3PeDsyHwdArKVbkWAgAAArRA=
Date: Thu, 24 Oct 2024 06:14:10 +0000
Message-ID: <SI2PR06MB50419A139B7233B352CD1E31FC4E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <9fe3e1cd-6aed-473f-9193-8541a202b7a0@kaod.org>
In-Reply-To: <9fe3e1cd-6aed-473f-9193-8541a202b7a0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6833:EE_
x-ms-office365-filtering-correlation-id: 81e96136-bc51-4fcd-8aaf-08dcf3f3134c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?NmRnL1IxSUV0UlYrc2RXdjhrRm9DZ2FFUmwvbDBWaThSZG5LS2VQUmFsRWpx?=
 =?utf-8?B?aEJnK2RpWVllaVBqSHZFOWowNitMa1U5cU1COWk4aUcwQWJiWEdnTXBDUEto?=
 =?utf-8?B?Y3cwRmw2WHg0TFdISFViM1BwdUVlZXBHSzBTem0yTEVwQytoOVlNYUxtakor?=
 =?utf-8?B?YVcvcVZRVjdxT09VcDk3RTQyN1N5NHhvSTc3MXBVd0gvNFNCWFB1aUtsTWY1?=
 =?utf-8?B?c0F0ek9Hbk5TZkJZdThpSGNSRDRDMkQ3UGdMSjRSSjd2SkdtM1pTanRWd0xZ?=
 =?utf-8?B?VTZCS3U4TkVLSVk3bGZwZDYzVVlrMG5HSDFnU0gzb3BCMVY5bFQyV3NLbVpp?=
 =?utf-8?B?V2ZzdjNoenhBQ3pOVlBpanBoeldyc2d4TjY1VGtBT1FrSVU5RWxpQ1F6TGxj?=
 =?utf-8?B?RUh2RWxyanQzbnA3TlprcnBEUE9CaHZLbXdHWnl5VGdHRWtiV1RMdUQ5cVV5?=
 =?utf-8?B?a0RKcDJ2K2V5dStuZW9LUzhDVW5mckFUakxpUXhIeVRPRVc4SEQ5dEg2Ujly?=
 =?utf-8?B?OVhKRFpLZ1A5WkoyRWpVY0kvUlZMYndqejM2T2x2RXIvU2JtYjQwZ3hveU9h?=
 =?utf-8?B?NUplZVg5L1UyUk94blF2V25DYkFIWXZoTEJUSFE3KzJxUlNEaDh6L2t1MjNl?=
 =?utf-8?B?WmNTNTFCN05JRGM0MlFaVWE4ZFE3L0N1MDhqcisySDBGTHBxbmZXdnpoOTMz?=
 =?utf-8?B?YnpjUWc4OHNveGhWbWJnQ3Y0enBoakp2WU84ZjhNTE8vYWF3T28rcEVDZUZm?=
 =?utf-8?B?SmFta09kaWVGVGFSSkhQM0dnalpqcWZDUk9aK3JwN3ljY0dVbCs1UnhhUStK?=
 =?utf-8?B?MTRrejlsZDJHM3dFOC92REVXMjFWbDlKdUZuZERrYmhWNFpMaUdQRVJTYnlS?=
 =?utf-8?B?dG5DQlpwQlAzcWZma1g3UUJQSklEZE11bDBwakNVSVZRMHZBRkMxOFFRU2xI?=
 =?utf-8?B?ZGN1Sm01cHF4S3E5OGppM0QwVXZNcTc4aFU3bDVzcVRLYmpQK1QwUVo2SUhM?=
 =?utf-8?B?TzBvM0hGMDc5RitodnY2aGU5TU50MnpiUkpQdnpWVXVpUURucTVYVitlcHp6?=
 =?utf-8?B?UXhWWC9SZVBHMTJGSGM5UTAzNG0yblZzeUhpRXQ2WHIzcWRRNGdUOU1PYXhy?=
 =?utf-8?B?YnhPclBiazRVK3cwMzNqUTZCY0RtTWhiWmlXaXowVFV0SzJQK3FxT0xBcDRv?=
 =?utf-8?B?dDl3bGI2c0xvNmE1TzZVeGlZeFBNVXJmQTBWYVhna01jR3FSU0ZXMWJNTG41?=
 =?utf-8?B?eGtkdHFkR0Y0TmJOT0NWczRFc0F3KzNYUklSU2FGL1dQWmkxbUx3dWRyd2FR?=
 =?utf-8?B?MGd5R1ZKTXBvVTRQYmcwRXNMbUs0cFQ4dkVzQXFuZFBRYWxKZ2U5N0tiMzlQ?=
 =?utf-8?B?OUF1NkUxRWV0OU8yWHU1aDh5Y2xQUStoakU5aFpEamJyTkNGSFo0aGNOV2Nw?=
 =?utf-8?B?US9mVHl2YmlIZmIwUnk1UTlDa1Axbnl1MkZJWjJoL3dQTEQ3eSt4dkh5TWtq?=
 =?utf-8?B?UVRKSEhjNnZ6c0R5NEtSRE1PUksweW1CTzNkenErWW9YN2krdElnVkVQdjJ5?=
 =?utf-8?B?cVFWUW1MV3Y3NDVTb2RRZGNlTFhybTNQZ20yUi9VY0lZd0FlODMydEFSQ2VS?=
 =?utf-8?B?RjdMOEUxUzFGOVRSaGVmWk1KWXUySlZPanByWXNRSlhMdmUybVF0KzFFWlNr?=
 =?utf-8?B?T2xVWUlyTzkvbzRVOVkxSzAySlJybGdwYlJWWmY1NE9XVG8xak9JTU9lR1ZG?=
 =?utf-8?B?VGJYVkdWbk9ZeC9TZjVmekMwNzdUVElzR3lWcVlhUlhNdHBZdHV4R0pkWG5R?=
 =?utf-8?B?WUx6U1g0WTZOclZicGVkQk5TbWRydmpuTVV6d0I4cWlvS0paMVpZcWRIU0p5?=
 =?utf-8?Q?yoRpuWwOcG64G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmNPRTVmTW1TT0dZTS9TOEZuaXJGR05sdnphdVNSYUZGQjMybFFKa0s2RnhQ?=
 =?utf-8?B?VmQrUVJJMU5uL2NTSFJIYitOYUgzaUVhcS9CWWIvUVlVckh1NDdGNnpRME9k?=
 =?utf-8?B?b0E5T0psbk1NeHVvMDZWNis2bW1YTmRJVE1FUXdGVHU1QXRRM1N3NEk1UTFp?=
 =?utf-8?B?a1VyNGYxeU5UTzZ0TVBJV3dBVmxhMDY2bE0rektmMHpIZUxraTJnSWQrV3dY?=
 =?utf-8?B?am9KVGNTamJKQ1FVOVc1eXR6N0gwZktTREliNXkrV1ROSlVXcWxzQnp0VVRu?=
 =?utf-8?B?cEVXbW1pN2oxblNWN1huZ1R0ZDlwTjJwTDArY25UNjhQUDlUdnlZNlVQS092?=
 =?utf-8?B?eWt6dmU4WENRZDk3VXd4WXNWMzBRMUljUXFvM0RtNjgyS3dlSFhOSDdzbWN5?=
 =?utf-8?B?Vm1LWTRYNkU2eEcvSmFGWmNtclFQSkhHNmZSSTg0SFNSMXdiQUtyeHpKdEJv?=
 =?utf-8?B?RFJQYVZ5UGhUdmJQSnZQeXcrK1N3Wk82M29zaXdaYmh2WGlxdVU1WExFZW9H?=
 =?utf-8?B?S0NET1hUbGlzOE1LODkxamNaUXpIdVAwZXFBbkFYajRtb1U2TEpRb05zY3ha?=
 =?utf-8?B?ayt3eEFIVk5SWFpVeXcwU0tMNXNBTE9Wb2ZiNVlwSnBZcXp4MGRRV3VBU3FU?=
 =?utf-8?B?NmlFYjFiNjQwUXRGTDM3c1RHT0E1T2lwZkQwTE1kWUFITzRnNkZpNlUyMTJL?=
 =?utf-8?B?MnlLUlZkV012UjBBZVlGKzJDTVpJbFBpSVBaTDB1c2NiWXBaTDY2OURwRWpn?=
 =?utf-8?B?bWt3YmZ0dDEydzdTMjNWdjNJcHBiVFZXNGlFc2xBVStzTzVDQ1FwU1dnc3hG?=
 =?utf-8?B?a0VMQXBLODMweW8vb3lnb05LSXVsRGpROXU0VE0rTnRGRG11YXBxRHlZSFRK?=
 =?utf-8?B?Vk4zV25WbWhzZ2kzWUNud1paaEZqMnpRaGR0Y0VYcnh3cUVyYTF6dzU1Zzcw?=
 =?utf-8?B?OGNTVnJyRGNMcjlQS3ZkRy8yakVJb0pWYVp1MTJjSmNub3hhUnYrOVduN1lk?=
 =?utf-8?B?UFRLZ0xoR3pQKzBHT0tieGFFVXptUU1lRDY1UEx1RHkwamlUSGQyLzQ0Vklo?=
 =?utf-8?B?SWJ2SHlGam1XOVlGczE0Y01pU0VZTzhaUWZ3L25NUy9iVW8zRDdvMHJlN3RX?=
 =?utf-8?B?Uy80ZURlbHZiVks5ZTFWeEVJSHFuaHJEQjZHNExYL1BabktBem1OYUV6RndK?=
 =?utf-8?B?dmRoSUwrZ1ZzTmRCMmhZVzBsbjZ3MXhwYlkwdHRsMTMyVGJpb2swa1BzeVp0?=
 =?utf-8?B?UkJDS05kUmw5Rnl1WjhyY1JnRzd4ZWhRcTFndlBZZWNPdU50SzdpNEg0ckNN?=
 =?utf-8?B?enU4TUJoWmJiSjVKNXlDYTArc1BSUnNCUll6R1pZUlowY0hrVzJVTTZYQjUr?=
 =?utf-8?B?TVM1dS9oRFlMbzZFcURTbGdhTjNJMnhlMzV0YUt2Y0pTWDJ0SStRQzZzYlZh?=
 =?utf-8?B?Q1ljLzJvMUxEMkVydUZsejRQdE80djJkS2tzd1FOcEhqSStsRnF3S3FBeWpp?=
 =?utf-8?B?QkR5OXJrWWxpU3B2eG5zSFpZc0w5WEhremQyaVJhNis0bHpkSUNIZWM3ekoz?=
 =?utf-8?B?SlRxMnAzQ2pzL2M0Qndxd2RrQmtDdWYzbTlRbjFLMDBIa21WR2tnYkEwZFR3?=
 =?utf-8?B?bjZ6U3oxUzVsNHp5QXN2WmVIL0YwNGtTYUs4MWdua2VGQ2ZndTc3V013Q1Fm?=
 =?utf-8?B?TnlscE83OHVwSWNxbldyOU5RVjhMaURVdWJiRHdmSStDWi9tUjYwazQ2Y245?=
 =?utf-8?B?WE95bUVCVUFGeCtpNGx0b01XZUUwY2FNbGtBY2NwaFo4UmoyQ0tPU2hhcENB?=
 =?utf-8?B?NDkzcm5xK2FaMFFOSytwellTV0M4UHliVEpvd3VmTlg5QUI0ZGljY001Y1h3?=
 =?utf-8?B?cUxrL3k4YmRJcmxQN0t4MmhXbkQvTDdlZHZTZzlsL3hNbXVteGgyei96R2VJ?=
 =?utf-8?B?R0dnb2kzR0FVNVgzWXB3dTIxVVQySkRhVXZ2Y1pqKzc0MHQrVk1vZWJQb3Jk?=
 =?utf-8?B?bGtZdW95dFJudkoycWFGWWJKZUlQcjNmMUpLRkp3R1l2NTZlSVVjejJJck1G?=
 =?utf-8?B?b2cwb21XOTNIVC9lK2lyYlBnc2l2VDZPTk9qd05PMnpDK2NzWHhkdm8yK3hk?=
 =?utf-8?Q?ZGUHgd6uFKhOnzdS41TENWyRP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e96136-bc51-4fcd-8aaf-08dcf3f3134c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 06:14:10.5880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AmSQTbsgHTBF48A+KIvDtsn7Zv1Qed+UIXkdoJlul4sXnc97PYX0M6OQP9U/nsooZ11GWKdMUEVyloWqLfUw9/vF4KjPrOW6Wrc1/Iq7X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6833
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDAvMThdIEZpeCB3cml0ZSBp
bmNvcnJlY3QgZGF0YSBpbnRvIGZsYXNoIGluIHVzZXIgbW9kZQ0KPiANCj4gSGVsbG8gSmFtaW4s
DQo+IA0KPiBPbiAxMC8yMi8yNCAxMTo0MCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IGNoYW5nZSBm
cm9tIHYxOg0KPiA+ICAgMS4gRml4IHdyaXRlIGluY29ycmVjdCBkYXRhIGludG8gZmxhc2ggaW4g
dXNlciBtb2RlLg0KPiA+ICAgMi4gUmVmYWN0b3IgYXNwZWVkIHNtYyBxdGVzdCB0ZXN0Y2FzZXMg
dG8gc3VwcG9ydCBBU1QyNjAwLCBBU1QyNTAwDQo+ID4gYW5kIEFTVDEwMzAuDQo+ID4gICAzLiBB
ZGQgYXN0MjcwMCBzbWMgcXRlc3QgdGVzdGNhc2UgdG8gc3VwcG9ydCBBU1QyNzAwLg0KPiA+DQo+
ID4gY2hhbmdlIGZyb20gdjI6DQo+ID4gMS4gSW50cm9kdWNlIGEgbmV3IGFzcGVlZC1zbWMtdXRp
bHMuYyB0byBwbGFjZSBjb21tb24gdGVzdGNhc2VzLg0KPiA+IDIuIEZpeCBoYXJkY29kZSBhdHRh
Y2ggZmxhc2ggbW9kZWwgb2Ygc3BpIGNvbnRyb2xsZXJzIDMuIEFkZCByZXZpZXdlcnMNCj4gPiBz
dWdnZXN0aW9uIGFuZCBmaXggcmV2aWV3IGlzc3VlLg0KPiBJIGhhdmUgYXBwbGllZCAxLTYsOCB0
byBhc3BlZWQtbmV4dCBhbmQgc2hvdWxkIHNlbmQgYSBQUiB3aXRoIHRoZW0uIEkga2VwdCB0aGUN
Cj4gdGVzdCBleHRlbnNpb25zIGZvciBsYXRlciwgdG8gdGFrZSBhIGNsb3NlciBhIGxvb2sgYW5k
IGFsc28gYmVjYXVzZSBJIHdpbGwgYmUgb24NCj4gUFRPIG5leHQgd2Vlay4gVGVzdHMgY2FuIGJl
IG1lcmdlZCBpbiB0aGUgbmV4dCBQUiBpZiB3ZSBoYXZlIHRpbWUgaW4gdGhpcyBjeWNsZQ0KPiBv
ciBpbiBRRU1VIDEwLjAuDQo+IA0KR290IGl0IGFuZCB0aGFua3MgZm9yIGhlbHAuDQpKYW1pbg0K
PiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

