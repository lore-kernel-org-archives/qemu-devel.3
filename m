Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388D3C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 10:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2SX7-0001eq-P0; Wed, 09 Apr 2025 06:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2SX4-0001eY-2o; Wed, 09 Apr 2025 06:19:46 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u2SX0-0001cl-Qg; Wed, 09 Apr 2025 06:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpmPBidTwin8oUHT7EfGdsBYGSj4jb/ojZLM/cJ1INZ/78Lon8nnHn8XF4bfnkuwhsGZH9QwvcE58zVvhvpCE341Hgp2788faMOf58BddnNhPtcoFZHuQXRY4WQM+qGpgz/4F1+8OEPtBbXSCYCFcyZhVdn9o5Y/IViMg/knCjY2bwJpzMo7XVnIr7E7oSv4o9wSkCtoRFr7A8Yyb5V7HFnt0eX5lcEqCmGU8PlM133xIYWP329RPhN9/hRbemDoH2YemT9UTq+sb3oqoYgog1x19Wz/o1Lj8DeXG8h1HN+z2gLApTqWsrFX+ManN8DGS9957+HKRWQ6vIxKZ3cWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foyAnVA/J38tuBpykTfcqcxZ21sdRs2a691zH+QMxq4=;
 b=a+9ew5aVY4ToVzFvejKB5BTSVjAzUqodB3U50448P7l85ICUH2MYLhx2i6+1n6o+p2c0OEwDuCSfGskttUM1VKHOXJfzVEtGPpaZ5Y6yEe6dhztdw2B4G3zge/ltQHGtDYOeX0JWaH4NmHrxbJdKUYkAgKenSDBxbX8u+FjoFTw0acW/0iAHKgQTlpmSyX9GkEcGyrM2i85q7jpqzsLWLrOAoaCL9IKsEADQhwlux1J10jIsnqSI7F2QLDwUnJoVl4QawqUBgfG0Am367CEqqrYA72YBKuuEeasRjHMjZ2yiNEO8OjvpijFWqvOTkpbp9HkGKEmey346a74o9YKM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foyAnVA/J38tuBpykTfcqcxZ21sdRs2a691zH+QMxq4=;
 b=ZMDM9pRREYcHtJRS0W8pPqJ/1NA/4jEIFL+EgSrDfPuR9JPgdOBJq/WA6NoPYyT8VPkPIp8b0tt+H/OcIsP+Vg6fuRvJRPuOYl+NNyTJiZikJNd00bAx4asZf+iCZLFXth3byfsoYI298r8MblqBdIpTvfTnjsjS8c0UQH2/d2MzCYwjba9hU3Frl9yauvh+vCIbW5sN4+TKBQ/ZycvEfpyJNT+d8txQngYfbpNIWdZAbekC5pOCQq2uDe9G/RkWoT1vIqj2aFUExeqG+K8yCs4g0bpST84RIA+XLr7SeFq6a/5hmVfn1mBzsOYbr2tecUTvwfY0WQDkKvYl6/sBwg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Wed, 9 Apr 2025 10:19:30 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8606.028; Wed, 9 Apr 2025
 10:19:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Topic: [PATCH v2] hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when
 I2CM_DMA_TX/RX_ADDR set first
Thread-Index: AQHbqF/AxGlF3OLqIUu6xvdrbqhw7LObC2tAgAATXYCAAADOIA==
Date: Wed, 9 Apr 2025 10:19:29 +0000
Message-ID: <SI2PR06MB50418E5147D60FDD90A052D8FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250408082504.3060742-1-jamin_lin@aspeedtech.com>
 <SI2PR06MB50412DDB7CEE6844C1E5B953FCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <7512f3d5-d90e-449e-ab0c-4e82d32eb361@kaod.org>
In-Reply-To: <7512f3d5-d90e-449e-ab0c-4e82d32eb361@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY1PPFE340CD3DF:EE_
x-ms-office365-filtering-correlation-id: 7b200d61-9ccd-4a9f-968c-08dd775003b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SHREd1U2blRKMjZ0OHpGS2JOcnZLNDZhMlpua3NBZG5VYkxKZTd3QUljNlcz?=
 =?utf-8?B?S2lFYVQvMWtYUlkydlVVVjhuS3FBMWFXdW4rUmRia2piNEdrYWlVWUs0b01F?=
 =?utf-8?B?K2NqenpMNDJONDZjNzBXNlV6WkVLTzJ0VG5kSytCV0sySHFQRGpPK2c5OWRG?=
 =?utf-8?B?SDgyMmFuSktLdUlFR21IaGVld3hPYVNjcWF4dlpIdlBFalp6dzNOQ25yUHBr?=
 =?utf-8?B?T0dqVWZYWWtJcnBWaWJINnV4aFBFa0VpcTBSMWMzdFdVeWZnaEExSzhkUnY1?=
 =?utf-8?B?SCtFUzFBR0RnQUJNZVo3R3lvSkFVSUZ0T3Fmdk5UOXlwUHZmS1RZY1NXTGlS?=
 =?utf-8?B?WU5lT3o2YlQ0Qk5QWXZFZ3czRUdVQWljT05kZ3R1RDNkd1lkdkJNWndEMFRK?=
 =?utf-8?B?Y09TcFVCZTVaZFhRbXp4b2llMHcrOE16aTcxR1E4NkwyN2tUdUFqOUlCUXFS?=
 =?utf-8?B?dnNvUXJKbVA1Z0o1V1JFOTBVMWwvY0lTM3pwWU1OMTRLcTdjT1ZoOG9iUDVu?=
 =?utf-8?B?Y2p1RVJjWCtJYUdwdjNDRkltYkxWWGFMSTF4dGdvdlh0N0wzSElOYW9qTEZn?=
 =?utf-8?B?dkp5YUFmaGh3TUg2ZmZJcnQ0dDB0RzlXaEc4ejIyVDF2cFFFS3kwSk91QzJZ?=
 =?utf-8?B?QmNZVUY2MXk4VGdmSHBtUnNEYjRoSitCUUlyTklDdGI3MjJDc1lFeUtjSVpp?=
 =?utf-8?B?S0lZcHVBWWdWRzl4YWx2dEpwdm1oVGo0TlRQY0VMTVVqYU5WYnVqWFpEdkRK?=
 =?utf-8?B?cUQzb2xFN1VPSFllSGc4NHNBVEo0aXhiOE5MNG9ZNjFyZXM5TjVrbGh2Nldx?=
 =?utf-8?B?cXN0ZVdkTnVydXdRZnBEZnl6Z3laYjBsSGdmajRha0lua2tMQytBWStvaE9C?=
 =?utf-8?B?Q3UzUmZUTkZKdVNWK2NFWVdvWDczQ0FzRVc2M2hHVTlneDVzeUVHOUV0RnJn?=
 =?utf-8?B?U295UGtKMXIyOHNCQVlpcDdjQzRJbStTRUpJdmlkUFRoc2RrbzhaZUZlQ0xw?=
 =?utf-8?B?aDIzbUJuVmVJUmlMbzdsOEo0VHYxYjdRVmI0QVhjaTlEZURUQ1pzU0M0Y2NY?=
 =?utf-8?B?Vi8wQUhWb2RqVGljdVFab3dLa1h3TkFxWVFHQUMrN3JtZmFWVENtWmJURFdi?=
 =?utf-8?B?bitmTXpsaklER2JmL1AzaWJ6dW5GbzBKMU0yNW93RzkvWEwzR0t3OTAwVUhj?=
 =?utf-8?B?d2JTbXpSeWR3MG5VMHhzQ2Y4dGlkYWdFRWRkQjNOYmRIanlYNHU2dlR3MVFF?=
 =?utf-8?B?VzkyR3BreENha1UvdE9FS3lnM1VIOVppTUFlK0c5a1JjZnJBN1g1Yk1MeTNH?=
 =?utf-8?B?NndqQmZ3bENmcUpreFBGMUh0ZXR3VndqL09mczRKTTV2eDdDck1iRFNrUnhk?=
 =?utf-8?B?ellodENSRFIrbXh5U0k3d3M2azg1TUJ3YU5kRVZmbmEwWFFMQ3ZMQXpBR1kx?=
 =?utf-8?B?M1dVVkx4VHdkM1ZxK0pQU09PdzRTL0phQ3JBbmI5ak1vM0s4NEZZQjZHZnRF?=
 =?utf-8?B?akJ1QUpBSi92cmt6SzdEaU41OW9ZMzJ1YzR1Nit6K09FSlVMcXNHOVdId0Fz?=
 =?utf-8?B?a3Y1cHNQWUdIMmdTMnBtei9nYk1mNG8zS1VpeTVlbnExb3MzUVRtQk04dHdS?=
 =?utf-8?B?Y3BxWmQvN1liMzFhSnVyWHZkaWdqSzZNOWE0ZnplQXpXNjFuR2N4SWVZWGVK?=
 =?utf-8?B?anFHV0ZvdTJHbnBSOUFMenRxNi9ET1pIbERQYTloUzA1eEY2MTFLQ0xIblJV?=
 =?utf-8?B?RGhPRkVMQVErb0k3VUpGYXErZktnU3h5NkNKM2RRQjMxQWNMN3J3SUJjWkhM?=
 =?utf-8?B?aktFR2FCTVI4NXhNZFdsR00xZURWTisxZjFJV3JlN3JQSEZrd0pPcXRTczUw?=
 =?utf-8?B?YngwWS9GcHczbE1xT1l5TlVQcXFjMXFrRzJMWnY1TG9mSXJzZFUwMHhiNUM4?=
 =?utf-8?Q?h64nL9VGVeHlGaBxkULqFFS1Fcw4c9XV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGt6aE5sMk45LzhLdytCU2pEY1dZakNkMDNUZ0I4YjZFb1czb0t4SXJGcE1x?=
 =?utf-8?B?bEFuWjBPT2ExRi9sUjYycmdTZ01oRWxrcXhhdTRFT1JvRjZFUmEzNTRITWlm?=
 =?utf-8?B?STZpSmU1azhGMjNxdWdMb0dQTk9vM1kwVXpvbm5aUVVQY2JOb2MwV2l5NWJk?=
 =?utf-8?B?aWpRem0yRkJMN2FGVHdaWGYrZExONDY4VFNzdGg4ZE1OVkNiUFJUQXExVDZB?=
 =?utf-8?B?cmI5bmFoUzAveVFBanBDWnpSdTZ1bUo2MmRrbkJyYzNYK0hzM3oxMTNMRmR0?=
 =?utf-8?B?ekVqUjZ5ZFVyZWxwTm83UEluMUUxUzZrbm42Z3pxYU1yYlIzQWlXUmNYN3M3?=
 =?utf-8?B?enVva3RiaXRWZVhhNTdxbFdYRGFLeFJOQ2M2Q0prWWs1M2lZaGw4ME13eGM5?=
 =?utf-8?B?cWVmR0dzc0dGeVloKzR4aEFUcERPdS8rMmYrR290bkd4ZnBLRGFuQW5xa20z?=
 =?utf-8?B?RXpucXJ1bmpuN3FhUzVXNkR2Ry95elA0djA2Uy85Y0EyeHVNbk1tTTFUektP?=
 =?utf-8?B?b2dQRTdRMnpraE94d3RKbGxlWXdjaXE5MkxYMERaNW9BR1g4WS9kMzI2NzJN?=
 =?utf-8?B?bFFuZ3I4RnFBeWtrdWxTUk1TMGhJR2dsM3J5Z0hNVVBxbTcycTFFUHMreXhM?=
 =?utf-8?B?NUZHWjN6UVNaZ1hCelN0Z3BsMkwyRm9Pc0FiS0hvcFlRZG5iSTREaFVYOXJo?=
 =?utf-8?B?YVVHbGxydUhnTDM0MzdZMGpSZVFkZWdPdGQ0NnhZcFRnWHpOa2prWkNEUFNz?=
 =?utf-8?B?UWVySmpKOVJHeU9mVUw1Yk56ZUtPQWdNb0RiOGZHUWxkd1lySi8yUUl3QXBH?=
 =?utf-8?B?bjFaaU1VWFdpelgvVGxnWncwOWVuandRQ290TVE1WTR2WXFzL29YYVBiYkxw?=
 =?utf-8?B?bnNNWVIzaWJGQ1BnVzUydjAxYnMxS2ZiSTZRZXJWRXY5OTZkVGdadFpjMVhq?=
 =?utf-8?B?Y1htRkc1QmhoeXZ1SnZUdFJOMjdmSW9uaWR3dXpmdmR0NTc1ajR5ZWdINURN?=
 =?utf-8?B?VjZpWkQzYmxBbTBsTmtwbFhzTmtuRnh3SVUyaktNWDhidWN5ckhPQ0l6cmpn?=
 =?utf-8?B?UHpQeHYzcEVVUUpTN3JaWTIxUFhhbG5NNHJ0L3lCRDJxQ2xscDdrZ0QwdkVx?=
 =?utf-8?B?VlRGM1MrbHhKUnpDaG90RXJCWXpud1g3Z1NmR0FwZWs4UmtLdy8xNTY1VGdS?=
 =?utf-8?B?dXdMcEdlakxHNm4ySVRWU2k1TjVjc0VBK2szenhEUDFxbXdXaVdUVEh5R1Fj?=
 =?utf-8?B?SVFyT3l0WlJLeTFKbTV4WGVtc0pUZDJhWUFKVjlxU0ZZN2p2NUM1RWJadDlu?=
 =?utf-8?B?WHZ4VWV4NDI2ZTRPSE1URE1yUWMzc3NJRmdUVXFvM0g0M2JnMEdVT2V0Q1pL?=
 =?utf-8?B?UGVYdlNRQ1NnRTBzQUZkR3hwR2xqQVpZb1Iwd1ZmK245ZkMvaDkvczZQSjIy?=
 =?utf-8?B?ZHRQdWNXYitldjhRZXF5a25sOHRybUFpTHhGa0RLNTZ0WWJmT2k1ZGZ4THl2?=
 =?utf-8?B?S2tFU0RPSmVTMkJHci9tUUlZMnBjdmUrOXh0dWozWmdISjltWEpmb3M5cHR0?=
 =?utf-8?B?NVJKT0w0NkR1a3lSS2lBc1h1Um1vRDFmVFJCamViUExuVzR3VEYzd2lGY1Iv?=
 =?utf-8?B?Wkx2c2hIYWZlbm8zdjNXd1J3M2E0am1UT3M0Wk1zOWlwOERXNkk4ZXQyekVY?=
 =?utf-8?B?SzRsbzI3V1pNelluUWwwSTA5M05mN0JSWUVjNExJMEgveFI2ODl2ZHlRVGdh?=
 =?utf-8?B?VThrYngxK0JSTDhBc2JIOUt2eUxkYXdaWStsT3p3VnVjbEZyQnFacVN5Y0Zn?=
 =?utf-8?B?bmR0d2FZcFlWNEFrR0k3RzBuTEcwbGZVdVZwWFpiZVZ3bXBjTkxYV0E2N3NI?=
 =?utf-8?B?eGl1b1dCbkIzK2phNkE3cmZBMWI5MnJiMURYSDAvc1I4UVQ1SDZQRzZQakkw?=
 =?utf-8?B?dEorU2xGUGprQ2U2UWlCQ0xibUs0Sk1zWE1JemErYkZNVEFDTHgxcE1PaVJl?=
 =?utf-8?B?Yll2NVlTL1N2RWk0aTY4QVM0VDhVVVJzcGNYS2E5Z3VwUmhuV1FUZldDMERX?=
 =?utf-8?B?VCtEZTVPNTA5OHpERUVyRUZiQ0tCQ2J4U0lYWmxlallhU01JMkF5dTEyeUhG?=
 =?utf-8?Q?3ttcnSywZps4e73SFekczg82m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b200d61-9ccd-4a9f-968c-08dd775003b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 10:19:29.9502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUeHzFsNyf9pEVkSx2L1C1sWrygHmz6EAURv3oaYXOIJ1PxIif478BwNsqvroZLak/b1Gbwx/IzPZjKBqNjVlRyA3fcGZAuez5ekBmAHRek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBody9pMmMvYXNwZWVkOiBG
aXggd3JvbmcgSTJDQ19ETUFfTEVOIHdoZW4NCj4gSTJDTV9ETUFfVFgvUlhfQUREUiBzZXQgZmly
c3QNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gNC85LzI1IDExOjEwLCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gSGkgQ2VkcmljLA0KPiA+DQo+ID4gQWZ0ZXIgZGlzY3Vzc2luZyB3aXRoIHRoZSBJMkMg
aGFyZHdhcmUgZGVzaWduZXJzLCB3ZSBjb25maXJtZWQgdGhhdCB0aGUgSTJjDQo+IGRlc2lnbiBp
biBBU1QyNjAwIGFuZCBBU1QyNzAwIEExIGlzIHRoZSBzYW1lLg0KPiA+IFRoZSBkYXRhc2hlZXQg
d2lsbCBiZSB1cGRhdGVkIGFjY29yZGluZ2x5IGZvciBBU1QyNzAwLg0KPiA+DQo+ID4gSG93ZXZl
ciwgcGxlYXNlIG5vdGUgdGhhdCBiaXQgMTUgYW5kIGJpdCAzMSBhcmUgbm90IGF2YWlsYWJsZSBv
biBBU1QyNzAwIEEwDQo+IGFuZCBGVyBkbyBub3Qgc2V0IGVpdGhlciBiaXQgMTUgYW5kIGJpdCAz
MS4NCj4gPiBBU1QyNzAwIEEwIHdhcyBhbiBlbmdpbmVlcmluZyBzYW1wbGUgdmVyc2lvbi4gR2l2
ZW4gdGhpcywgSSBwbGFuIHRvIHJlc2VuZA0KPiB0aGUgdjMgcGF0Y2ggd2l0aCBBU1QyNzAwIEEw
IGV4cGxpY2l0bHkgbWFya2VkIGFzIHVuc3VwcG9ydGVkLg0KPiANCj4gQXJlIHlvdSBnb2luZyB0
byBpbnRyb2R1Y2UgYW4gSTJDIHByb3BlcnR5IHRvIGRpc3Rpbmd1aXNoIHRoZQ0KPiBBMCBpbXBs
ZW1lbnRhdGlvbiBmb3IgdGhlIEExID8NCj4gDQoNCk5vLiBJIHdhbnQgdGhlIEkyQyBtb2RlbCB0
byBiZSBhcyBzaW1wbGUgYXMgcG9zc2libGUsIHdpdGhvdXQgYWRkaW5nIGFueSAiIkFTVDI3MDAg
QTAiIiBzcGVjaWZpYyBjaGFuZ2VzLg0KVjEgcGF0Y2ggd29yayBmb3IgQVNUMjcwMCBBMSwgQVNU
MjYwMCwgQVNUMjUwMCwgQVNUMTAzMCwgQVNUMjUwMCwgQVNUMjQwMCBidXQgbm90IEFTVDI3MDAg
QTAuDQoNCj4gPiBJIHByZWZlciBub3QgdG8gaW50cm9kdWNlIHdvcmthcm91bmRzIHNwZWNpZmlj
YWxseSBmb3IgQVNUMjcwMCBBMCwgYXMgaXQgaXMgbm90DQo+IGEgcHJvZHVjdGlvbi1ncmFkZSBz
aWxpY29uLg0KPiANCj4gV2UgY2FuIGRlcHJlY2F0ZSB0aGUgQVNUMjcwMCBBMCBtYWNoaW5lIHRv
bywgU2VlIDU2YTM3ZWRhOTNlZCwgYW5kDQo+IGNoYW5nZSB0aGUgYXN0MjcwMC1ldmIgbWFjaGlu
ZSBhbGlhcy4NCg0KDQpXaWxsIGRvLg0KDQo+IA0KPiA+IEkgd2lsbCByZXNlbmQgdGhlIHYzIHBh
dGNoIHdpdGggdGhlIHNhbWUgY29udGVudCBhcyB2MSwgc2luY2UgdGhlIG9ubHkgaXNzdWUgaW4N
Cj4gdjEgd2FzIGEgZnVuY3Rpb25hbCB0ZXN0IGZhaWx1cmUgb24gQVNUMjcwMCBBMC4NCj4gPiBB
cG9sb2dpZXMgZm9yIHRoZSBpbmNvbnZlbmllbmNlLCBhbmQgdGhhbmsgeW91IGZvciB5b3VyIHVu
ZGVyc3RhbmRpbmcuDQo+IA0KPiBUaGF0J3Mgb2suIE5vdGhpbmcgaXMgbWVyZ2VkLiBMZXQncyBn
ZXQgaXQgcmlnaHQgZmlyc3QuDQo+IA0KDQpUaGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gVGhhbmtzLUphbWluDQo+ID4NCj4gPiAqKioqKioq
KioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioN
Cj4gPiDlhY3osqzogbLmmI46DQo+ID4g5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXl
kKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a
5LmLDQo+IOaUtuS7tuiAhe+8jOiri+S7pembu+WtkOmDteS7tumAmuefpeacrOmbu+WtkOmDteS7
tuS5i+eZvOmAgeiAhSwg5Lim6KuL56uL5Y2z5Yiq6Zmk5pys6Zu75a2Q6YO1DQo+IOS7tuWPiuWF
tumZhOS7tuWSjOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCj4g
Pg0KPiA+IERJU0NMQUlNRVI6DQo+ID4gVGhpcyBtZXNzYWdlIChhbmQgYW55IGF0dGFjaG1lbnRz
KSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVnZWQgYW5kL29yDQo+IG90aGVyIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFz
ZSBub3RpZnkNCj4gdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRl
bGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkNCj4gYXR0YWNobWVudHMgd2l0aG91dCBjb3B5aW5nIG9y
IGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuDQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDgsIDIwMjUgNDoyNSBQTQ0KPiA+
PiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz47IFBldGVyIE1heWRlbGwNCj4g
Pj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNw
ZWVkdGVjaC5jb20+Ow0KPiA+PiBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBBbmRyZXcg
SmVmZmVyeQ0KPiA+PiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5
IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gPj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1A
bm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+ID4+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+DQo+ID4+IENjOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IFRyb3kgTGVlDQo+ID4+IDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4gU3Vi
amVjdDogW1BBVENIIHYyXSBody9pMmMvYXNwZWVkOiBGaXggd3JvbmcgSTJDQ19ETUFfTEVOIHdo
ZW4NCj4gPj4gSTJDTV9ETUFfVFgvUlhfQUREUiBzZXQgZmlyc3QNCj4gPj4NCj4gPj4gSW4gdGhl
IHByZXZpb3VzIGRlc2lnbiwgdGhlIEkyQyBtb2RlbCB3b3VsZCB1cGRhdGUgSTJDQ19ETUFfTEVO
DQo+ID4+ICgweDU0KSBiYXNlZCBvbiB0aGUgdmFsdWUgb2YgSTJDTV9ETUFfTEVOICgweDFDKSB3
aGVuIHRoZSBmaXJtd2FyZQ0KPiA+PiBzZXQgZWl0aGVyIEkyQ01fRE1BX1RYX0FERFINCj4gPj4g
KDB4MzApIG9yIEkyQ01fRE1BX1JYX0FERFIgKDB4MzQpLiBIb3dldmVyLCB0aGlzIG9ubHkgd29y
a2VkDQo+ID4+IGNvcnJlY3RseSBpZiB0aGUgZmlybXdhcmUgc2V0IEkyQ01fRE1BX0xFTiBiZWZv
cmUgc2V0dGluZw0KPiA+PiBJMkNNX0RNQV9UWF9BRERSIG9yIEkyQ01fRE1BX1JYX0FERFIuDQo+
ID4+DQo+ID4+IElmIHRoZSBmaXJtd2FyZSBpbnN0ZWFkIHNldCBJMkNNX0RNQV9UWF9BRERSIG9y
IEkyQ01fRE1BX1JYX0FERFINCj4gPj4gYmVmb3JlIHNldHRpbmcgSTJDTV9ETUFfTEVOLCB0aGUg
dmFsdWUgd3JpdHRlbiB0byBJMkNDX0RNQV9MRU4gd291bGQNCj4gPj4gYmUgaW5jb3JyZWN0Lg0K
PiA+Pg0KPiA+PiBJZGVhbGx5LCB0aGlzIGlzc3VlIHNob3VsZCBiZSByZXNvbHZlZCBieSB1cGRh
dGluZyB0aGUgbW9kZWwgdG8gc2V0DQo+ID4+IEkyQ0NfRE1BX0xFTiAoMHg1NCkgd2hlbiB0aGUg
ZmlybXdhcmUgd3JpdGVzIHRvIHRoZSBJMkNNX0RNQV9MRU4NCj4gPj4gKDB4MUMpIHJlZ2lzdGVy
LCBpbnN0ZWFkIG9mIHdoZW4gaXQgd3JpdGVzIHRvIEkyQ01fRE1BX1RYX0FERFIgKDB4MzApDQo+
ID4+IG9yIEkyQ01fRE1BX1JYX0FERFIgKDB4MzQpLg0KPiA+Pg0KPiA+PiBPcmlnaW5hbGx5LCB0
aGUgZGVzaWduIG9mIEkyQ01fRE1BX0xFTiAoMHgxQykgaW5jbHVkZWQgYnVmZmVyIGxlbmd0aA0K
PiA+PiB3cml0ZS1lbmFibGUgYml0cyBmb3IgdGhlIGN1cnJlbnQgY29tbWFuZDoNCj4gPj4gQml0
IDMxIGVuYWJsZWQgdGhlIFJYIGJ1ZmZlciBsZW5ndGggdXBkYXRlIEJpdCAxNSBlbmFibGVkIHRo
ZSBUWA0KPiA+PiBidWZmZXIgbGVuZ3RoIHVwZGF0ZQ0KPiA+Pg0KPiA+PiBJbiBvdGhlciB3b3Jk
cywgd2hlbiB0aGUgZmlybXdhcmUgc2V0IGVpdGhlciBiaXQgMzEgb3IgYml0IDE1LCB0aGUNCj4g
Pj4gSTJDIG1vZGVsIGNvdWxkIHNhZmVseSB1cGRhdGUgSTJDQ19ETUFfTEVOICgweDU0KSB3aXRo
IHRoZSB2YWx1ZSBpbg0KPiA+PiBJMkNNX0RNQV9MRU4gKDB4MUMpLg0KPiA+Pg0KPiA+PiBIb3dl
dmVyLCBzdGFydGluZyB3aXRoIHRoZSBBU1QyNzAwLCB0aGUgZGVzaWduIG9mIHRoZSBJMkNNX0RN
QV9MRU4NCj4gPj4gKDB4MUMpIHJlZ2lzdGVyIHdhcyBjaGFuZ2VkLiBUaGUgd3JpdGUtZW5hYmxl
IGJpdHMgKGJpdCAzMSBhbmQgYml0DQo+ID4+IDE1KSB3ZXJlIHJlbW92ZWQsIG1lYW5pbmcgdGhl
cmUgaXMgbm8gbG9uZ2VyIGFuIGV4cGxpY2l0IGluZGljYXRpb24NCj4gPj4gb2Ygd2hldGhlciB0
aGUgZmlybXdhcmUgaW50ZW5kcyB0byB1cGRhdGUgdGhlIFRYIG9yIFJYIGxlbmd0aC4NCj4gPj4N
Cj4gPj4gQXMgYSByZXN1bHQsIG9uIEFTVDI3MDAgYW5kIG5ld2VyIFNvQ3MsIHRoZSBtb2RlbCBj
YW5ub3QgcmVsaWFibHkNCj4gPj4gZGV0ZXJtaW5lIHdoZXRoZXIgYSB3cml0ZSB0byBJMkNNX0RN
QV9MRU4gd2FzIG1lYW50IGZvciBUWCBvciBSWC4NCj4gPj4gVGhpcyBhbWJpZ3VpdHkgaXMgZXNw
ZWNpYWxseSBwcm9ibGVtYXRpYyB3aGVuIHRoZSB2YWx1ZSB3cml0dGVuIGlzIDAsDQo+ID4+IHdo
aWNoIGFjdHVhbGx5IGNvcnJlc3BvbmRzIHRvIGEgRE1BIGxlbmd0aCBvZiAxLg0KPiA+Pg0KPiA+
PiBUbyBlbnN1cmUgY29uc2lzdGVudCBiZWhhdmlvciBhY3Jvc3MgYWxsIFNvQ3MsIHRoZSBtb2Rl
bCBub3cgdXBkYXRlcw0KPiA+PiBJMkNDX0RNQV9MRU4gd2hlbiBJMkNNX0NNRCAoMHgxOCkgaXMg
d3JpdHRlbiwgYXMgdGhpcyBpcyB0aGUgZmluYWwNCj4gPj4gY29tbWFuZCB0aGF0IGluaXRpYXRl
cyBhIFRYIG9yIFJYIHRyYW5zZmVyIGFuZCByZWZsZWN0cyB0aGUNCj4gPj4gZmlybXdhcmXigJlz
IGludGVudCBtb3JlIGNsZWFybHkuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+PiBGaXhlczogYmEyY2NjZCAoYXNwZWVk
OiBpMmM6IEFkZCBuZXcgbW9kZSBzdXBwb3J0KQ0KPiA+PiAtLS0NCj4gPj4gICBody9pMmMvYXNw
ZWVkX2kyYy5jIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9ody9pMmMvYXNwZWVkX2kyYy5jIGIvaHcvaTJjL2FzcGVlZF9pMmMuYyBpbmRleA0KPiA+PiBh
OGZiYjlmNDRhLi5jNjU5MDk5ZTlhIDEwMDY0NA0KPiA+PiAtLS0gYS9ody9pMmMvYXNwZWVkX2ky
Yy5jDQo+ID4+ICsrKyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPj4gQEAgLTYzNCw2ICs2MzQs
MjAgQEAgc3RhdGljIHZvaWQNCj4gPj4gYXNwZWVkX2kyY19idXNfbmV3X3dyaXRlKEFzcGVlZEky
Q0J1cw0KPiA+PiAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiA+PiAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+PiAgICAgICAgICAgfQ0KPiA+Pg0KPiA+PiArICAgICAgICAvKiBIYW5kbGUgRE1BIGxl
bmd0aCAqLw0KPiA+PiArICAgICAgICBpZiAoU0hBUkVEX0ZJRUxEX0VYMzIodmFsdWUsIFRYX0RN
QV9FTikgJiYNCj4gPj4gKyAgICAgICAgICAgIFNIQVJFRF9GSUVMRF9FWDMyKHZhbHVlLCBNX1RY
X0NNRCkpIHsNCj4gPj4gKyAgICAgICAgICAgIGJ1cy0+cmVnc1tSX0kyQ0NfRE1BX0xFTl0gPQ0K
PiBBUlJBWV9GSUVMRF9FWDMyKGJ1cy0+cmVncywNCj4gPj4gKw0KPiA+PiBJMkNNX0RNQV9MRU4s
DQo+ID4+ICsNCj4gPj4gVFhfQlVGX0xFTikgKyAxOw0KPiA+PiArICAgICAgICB9DQo+ID4+ICsg
ICAgICAgIGlmIChTSEFSRURfRklFTERfRVgzMih2YWx1ZSwgUlhfRE1BX0VOKSAmJg0KPiA+PiAr
ICAgICAgICAgICAgU0hBUkVEX0ZJRUxEX0VYMzIodmFsdWUsIE1fUlhfQ01EKSkgew0KPiA+PiAr
ICAgICAgICAgICAgYnVzLT5yZWdzW1JfSTJDQ19ETUFfTEVOXSA9DQo+IEFSUkFZX0ZJRUxEX0VY
MzIoYnVzLT5yZWdzLA0KPiA+PiArDQo+ID4+IEkyQ01fRE1BX0xFTiwNCj4gPj4gKw0KPiA+PiBS
WF9CVUZfTEVOKSArIDE7DQo+ID4+ICsgICAgICAgIH0NCj4gPj4gKw0KPiA+PiAgICAgICAgICAg
aWYgKGJ1cy0+cmVnc1tSX0kyQ01fSU5UUl9TVFNdICYgMHhmZmZmMDAwMCkgew0KPiA+PiAgICAg
ICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAiJXM6IFBhY2tldCBtb2RlIGlzIG5v
dA0KPiA+PiBpbXBsZW1lbnRlZFxuIiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF9fZnVuY19fKTsgQEAgLTY1Niw4ICs2NzAsNiBAQCBzdGF0aWMNCj4gPj4gdm9pZCBhc3BlZWRf
aTJjX2J1c19uZXdfd3JpdGUoQXNwZWVkSTJDQnVzDQo+ID4+ICpidXMsIGh3YWRkciBvZmZzZXQs
DQo+ID4+ICAgICAgICAgICBidXMtPmRtYV9kcmFtX29mZnNldCA9DQo+ID4+ICAgICAgICAgICAg
ICAgZGVwb3NpdDY0KGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0LCAwLCAzMiwNCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgRklFTERfRVgzMih2YWx1ZSwgSTJDTV9ETUFfVFhfQUREUiwNCj4gQURE
UikpOw0KPiA+PiAtICAgICAgICBidXMtPnJlZ3NbUl9JMkNDX0RNQV9MRU5dID0gQVJSQVlfRklF
TERfRVgzMihidXMtPnJlZ3MsDQo+ID4+IEkyQ01fRE1BX0xFTiwNCj4gPj4gLQ0KPiBUWF9CVUZf
TEVOKQ0KPiA+PiArIDE7DQo+ID4+ICAgICAgICAgICBicmVhazsNCj4gPj4gICAgICAgY2FzZSBB
X0kyQ01fRE1BX1JYX0FERFI6DQo+ID4+ICAgICAgICAgICBidXMtPnJlZ3NbUl9JMkNNX0RNQV9S
WF9BRERSXSA9IEZJRUxEX0VYMzIodmFsdWUsDQo+ID4+IEkyQ01fRE1BX1JYX0FERFIsIEBAIC02
NjUsOCArNjc3LDYgQEAgc3RhdGljIHZvaWQNCj4gPj4gYXNwZWVkX2kyY19idXNfbmV3X3dyaXRl
KEFzcGVlZEkyQ0J1cyAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiA+PiAgICAgICAgICAgYnVzLT5k
bWFfZHJhbV9vZmZzZXQgPQ0KPiA+PiAgICAgICAgICAgICAgIGRlcG9zaXQ2NChidXMtPmRtYV9k
cmFtX29mZnNldCwgMCwgMzIsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIEZJRUxEX0VY
MzIodmFsdWUsIEkyQ01fRE1BX1JYX0FERFIsDQo+IEFERFIpKTsNCj4gPj4gLSAgICAgICAgYnVz
LT5yZWdzW1JfSTJDQ19ETUFfTEVOXSA9IEFSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0KPiA+
PiBJMkNNX0RNQV9MRU4sDQo+ID4+IC0NCj4gUlhfQlVGX0xFTikNCj4gPj4gKyAxOw0KPiA+PiAg
ICAgICAgICAgYnJlYWs7DQo+ID4+ICAgICAgIGNhc2UgQV9JMkNNX0RNQV9MRU46DQo+ID4+ICAg
ICAgICAgICB3MXQgPSBGSUVMRF9FWDMyKHZhbHVlLCBJMkNNX0RNQV9MRU4sIFJYX0JVRl9MRU5f
VzFUKQ0KPiB8fA0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPg0KDQo=

