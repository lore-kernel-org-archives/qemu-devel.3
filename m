Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0A9F433D6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeEz-00037T-Iy; Fri, 17 Apr 2026 04:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDeEw-00037D-VW; Fri, 17 Apr 2026 04:07:50 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDeEu-000518-Fd; Fri, 17 Apr 2026 04:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqoEeAR13PhYFutan3eNg7zHvnDBWoCuf/y/TvmB5qXihWU0zPbuYioXrnYYwy9E5n5PjMLX9AagaQWsC2ZavIaVKeGVy7QzYF9W8WdPXf47g2pvaz9WvPdLMHFmZ6mgepE4k6znknFYpNTUPdazVszAuzoXTho2Ix+EkGMtyYLUlDrr2lRgTmLAzl3QErNkxwsOAE08lzyIKBbauu1Sl/r9YZUPFhxk7X4l2olcSOBnnEE1+CAP8U6faTE0R6VHgsvSTkZvr+wRYfTZapequ95mT2MZR6+4vD1lWG4qDKj2/DheMab07+Otayq8IKm0SNSGFQ0kl/ztbkGHA9Azlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md8p12LcR/iRPFIS5Ou/61W5NXAcgtLL9GU0Qoud5ks=;
 b=pS9477lwDBk2Va2AmMvopgtsNvcR64XBeREmNMT4kBoXu3qlFEj+f6LFD/enAimQwHzwnxKJGyjZxNTLKzINCA15vg4AUE3Wi58xhohZTSpTz88n1iKb3StfaHBfIIWEODcLWBYtKgxNNdrJPyWLhr8wxfvAP+PFinEtyqEHFiFkeHV+mIgbEkakhhleKwJAb12fJOEYpYPqSFHgR7ajTbSeKug/VZKSsvOMkmNMj5QjwnMt0z5BPPviuRR4KIiuMsWG3s3AJI6yoLiBSM5WGwiLeEOPUfxmZHaAdmK/R5ikvGm9h317aCbQALg4s7kGF6Gt37ukcQC8dCLqfRdaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md8p12LcR/iRPFIS5Ou/61W5NXAcgtLL9GU0Qoud5ks=;
 b=bqDa3yGaHSsGNgiUm5JL4/0GEg02I54SYbGQ3qI/KTM7BNiRCVGv8MeOPY2nBvG7fHk6pMIwnmKLgsmDbxlYyvCIEr/wxZQr5Hbja72xUYJpl2weFlNHIDQIOpbcmeeOC+Xgvpr0cNgvyJn9K3c6I13m0g0LTLAxnwzHWjc1i6DVibowijeUclRnBPXHHXDxyIqHpRsWamEp+IWgCeri68VIZox8UBYlt4PQRypjKGC1DnhtK3FlmXSh2SG5IbM9SnY4m2o72PtBB7GJJs+l+N7wE6ZvJsgyo+4ZKwXVJDurXTgUdxQK7SlvUmd7qmHfsSgFZGweG+5fJ1SM7cct0Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB6920.apcprd06.prod.outlook.com (2603:1096:990:6b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 08:07:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:07:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Topic: [PATCH v3 08/17] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHczUNMTNflNW37RU+bzbw6mVnqirXizb0AgAAaDVA=
Date: Fri, 17 Apr 2026 08:07:39 +0000
Message-ID: <TYPPR06MB8206F5EF61DF01F21E8F3AE2FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-9-jamin_lin@aspeedtech.com>
 <e025f46e-8cee-451e-a25b-0d59fe6b2e15@linaro.org>
In-Reply-To: <e025f46e-8cee-451e-a25b-0d59fe6b2e15@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB6920:EE_
x-ms-office365-filtering-correlation-id: c9bf4968-286c-4ff5-1137-08de9c5864c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OHSNXFjKd6PV9Z8DjW+XkPMvt5hXGSapbejz9OnnOkFBgOWf3nQ/nZB1rX3eiriOHfd9syN+8OJbZDeY3PmD+8/Fe92Fz47gjU/yrYcK/ohmIAt90kxbop14L8yFxtxJ8JOqXSAjBDsiESV3axoTxVxT+dnnPhmbSwvQVRw1SIXQosZBqrg3pMDhHvSgX7NA7zrv7x2f7SefGlCBRlkRrixP7uxrpsApi3ndHrSOo/0pn7gAGQkHGX5TfLA8EaAIpbJFcwMRGhYB1di3b32Lm6n+I6vi83CGiTTNnlihnWZX/Ts1u1i9wl3Bk5LJW0fWyu4+Zxtn1bBX9eU/s03YwjdpV0srFim9VOpzHshjdduY1RO4A4kom5aXbsOv7vanM4bDP1Dt3A+bNTeez7dcj1WQZ8yFI+h+iAq/xXhr9VyZIx9kijU01Yd1K0iOnrYnMUfnoigDjuapdAUXp6a71tRC+Vg2YyxPZFdKslkex17Zt1xBQg35Cw4uRps2JO5k1vJD8fCeB1bC06dJVEJIc4bMzA+6C8nxlEMo6HxmGclkPTSdbbZEw9YLSOZ+RHTI1O18GdQxD3QqC/oCgR2pVPfc5mATUS9NMPN/NimiHTaghPMhU0oV2eAqozFxfuAIvW2a2LA1LHIzl6kME3atDRycLdbOHW/w9NARXyQhTWUDD26PzhR5iDbUnYAAlbm2uaXo0KgekcxCjiYmWRCwPK1oia+SNX2dtFjwWF9qKrZvO35ZqUd6mhToVyoJD2YAeNScYm6KZyhb3f5qJYhXixwy1q8ah3eDteQNw7ufdv/raxA9GxFOctxJCulNTksc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGM1S3pLaklXVjlmRkRJYVQvNDNlWlRINEU2cXlSZTg4THhzK2cxeVRiUG94?=
 =?utf-8?B?aUtqV1BlbTdaUTNTMVVvdW9saSs4UVNTN1JIL3BHMFQ3dnY4LzZrbmN0VnZy?=
 =?utf-8?B?V3hNaHgyQkZrcUxDOVFWWStzOVEya2NnQ3ZMUmJKMGc5cWh3UVd2VHo1bG03?=
 =?utf-8?B?KzE2N1RHWDVPcklKTXdPVFZkS0M1UTBPcUhiM3cwSDhVS2hIS0VmaVJwMVQ4?=
 =?utf-8?B?U1FSM0tpRnVaMVBHbURMTHdBcU1qUGJ1MjhUakIveVdJZGdtSHJRaDB3REFy?=
 =?utf-8?B?L2tscThaRUl3RXpYVW40MEFYOUtUcTRFQmUyUnhtRVFGcDhMTGhCNythUUdk?=
 =?utf-8?B?NVVVYklxY2t5SHRtelVnMjJWS2J5Q3kwd3dvK1pyeWRDb3BqWHdicnNIMWM4?=
 =?utf-8?B?S25VeURPTmtoVHk5Q1FYc3RVQVVmaXJxQS9yRTFPZklIU0pDakNVTmg5YTBU?=
 =?utf-8?B?aUZ0MlFxSis4cHlOYmZlbHlKbGhoUmJOV2xETFJkZ1ZCaVFXSVpyTGFDRUw5?=
 =?utf-8?B?UHJHdjBLTFhrN0JxK3lkWituQWxYVlcvdGNwV2ZDY0djc0NHS054aTlOYXVV?=
 =?utf-8?B?S0M3K2FXb1psSllha0grYTg5UmZqYk5UV1VJVC82bDlEeklkT3pUVGNTelRF?=
 =?utf-8?B?d0ZUclhxWWt6dXE4QU5ZamdVR0lEeGtLbG1xbXp1UTl0WFJscTFDK1lKWlhV?=
 =?utf-8?B?RDJWK2NRRWUwTEpvNTB5cGpMT2pyMURjMmtOOGxsYi9Mb21JaGg5NHBweXlT?=
 =?utf-8?B?MXZHWHZuUnBmUFRlY2FINlpzTU8zZ1lHMU1vdEdGbzlkQ0hTNnhmNkxvZUJ4?=
 =?utf-8?B?ZzlpWERBRDhXQmQwbTF4Q1dkN1d4Z1dYdUxzNUw1NURnVHBwWXlRbDgxZTdi?=
 =?utf-8?B?T3QrYXlxcGlIMHRnKzl6SDh0Y2RWM09vMkZJcTdnUGtVaVF1MFlyaFNqTFI1?=
 =?utf-8?B?NnJoL2NVMVZqVWtTb0FzR2wvMnNudTBPQmJ1ZkYrRDQxZ0R1V2lxUHAwRWpm?=
 =?utf-8?B?bEt5UDVsNlVGK1dabm5wbjJHdXl2bkFNdHhJMUkzZ3NwZFcvcERCbU9NM1pR?=
 =?utf-8?B?TnUwR1Y0SnBlSmNncDRpbmVvVms2cmdIOXVRam9nWEpKemhxUjFuK29jRDVV?=
 =?utf-8?B?OS9jaW5pS0dvN0V5MSsxakR1aVlxaElCelJBUnJSNFY1cWc2dGJaMUhSb1Vu?=
 =?utf-8?B?UFVGU3RwTmtOUmhxVmMreGU2YWtDWGJNWTZ6cDB2OG54UWFuMGhiYzUyRHN2?=
 =?utf-8?B?dzJ1UXRJQ0VNa0tqQ1J6cDU1NEIxUHBYU2h5aVhEd3BPSEYwc2ZWWW40NnRQ?=
 =?utf-8?B?Q29Bc3ZvUG12bnpFTkVsRksvZkw3aFN3aHg1T0VudDNuaU9UVzlXVE1GVjU5?=
 =?utf-8?B?bHRhVlFnbFMxTEFkUkgvUDErd3I1RFowQ1ExZ2xZdER4Um9ncHJBeHl2dGxi?=
 =?utf-8?B?TEtMUHlGeHZBeTlPL093bi9kTUw5VzBWMkNJMVdmc2FqRHN4ZHpaSGIxRjZT?=
 =?utf-8?B?enF3bmtmTnFPV2cyZDRnOVorVkJHRXc5RW1GYkIxWHRYQkxxYW5Ra3FMSHN2?=
 =?utf-8?B?VHBYQVhQbXpkd2FVajRKdE5BWHR4QmpIUVRYakI4eWhXU09qNXNCTlJkNkti?=
 =?utf-8?B?MktBbHVLQVJETVphWVYwT20rbHQ1Z2gvTzR4bG91dTB4dzExZzV0bGgvMXNK?=
 =?utf-8?B?M2JVbjN1V1dQOTUzYmJ0NEZWZXpWVE1qWDNKUDRZMlRhU3VWUkFQVVlwdFFJ?=
 =?utf-8?B?NFQ1RVNNaS93dG1iYmxVRDVQQXZPY29KUmJ2SHJOeDdEeHdKZ1hhdWp5cFFM?=
 =?utf-8?B?NFdCR3VPT1JBLzhaWWRKcjJzMkc3WUY4SEdYbnczUXRsN2c3NWtyMEVuZHIr?=
 =?utf-8?B?cnkzQ3BQanZYZXhCdWFKNWh6WDkwT2pydnErVzJXbm5ESjl0eXNIVGtwNUxC?=
 =?utf-8?B?Y0RZWEluTUVDNUJGc0dkZHFEV1IyVWZRTy9kYmg5TVNQeTlhdmZQdjRHTWV4?=
 =?utf-8?B?c0hpbDRTenNMeDl3MGpsR3VCTDdiWDR6WWdLQjhMRm9yY0hXcVNBYnNCV0pn?=
 =?utf-8?B?N0UzUkx3eWpEYlBLN3pRQ0lCNkJnWCtuZDhhVURiTURiY0daVjNJUzJ6RCs0?=
 =?utf-8?B?aEg4WG5nQWJPU1hGamdLMm9sVmMycDF4UVY5a3hwNGZSTDZRNElobkI3UU5S?=
 =?utf-8?B?KzVOM29FUkZtSjJyeW43eUl1bVgvZElyL1VHaUw4NWVOVTRNRWw3aGZqRWww?=
 =?utf-8?B?YTlDZTBFeHpYVStuTkNySUs3NE1tTEFDUXNWa0F3MVJpN3hVNnlwVWR5QVgy?=
 =?utf-8?B?RncyS2VSaDZsdDhHMytZbWhDWWRWUVk3NU8yVktjMG1sVkJvRnljUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BnEO2Z+7QgmWg7uOT4ICeFpIB5f/YzHx3/PWiQpxES2TMKUF5zfY9SNaZf+CWahQOOs/fCE/opnP/PC6X7MDIqZ6F8AcWH6MnKYDuwQ8lRL+KJoMcT7ceywFV+fe+/Kukn9XzjlaTAGf+rVZsOwFqzg4th8idqAAsx9qQBtyOw2nQ/uv2L5k9xNl62WSBWhQPGIH0CgO+xVDBCJcKMlpg6VKSBI2eScQd5IGNLjTUYgvq6XZM8SRo23xNHEjkOrP8OPHtOJ7BC5U7Ay9PcpMUlBbgy6PNWlcVzzS7OZF1wxBRMekz41L3+U5Ias3Bu4TBEFsccYSPCa/9bJP5m9XBQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bf4968-286c-4ff5-1137-08de9c5864c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 08:07:39.4553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nVBzbA0ppww8b8BF/0vcbDKgPy1EFPZZzIKrC3Ncy+AwwZJJEb/BtLRNg3m8TJ8q26gs+/U62OigmL323ZJPTaBPjopRt0vdshYNQPQPL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6920
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwOC8xN10gaHcvdXNiL2hj
ZC1laGNpOiBSZWplY3QgQ1RSTERTU0VHTUVOVA0KPiB3cml0ZXMgd2l0aG91dCA2NC1iaXQgY2Fw
YWJpbGl0eQ0KPiANCj4gT24gMTYvNC8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRo
ZSBFSENJIENUUkxEU1NFR01FTlQgcmVnaXN0ZXIgcHJvdmlkZXMgdGhlIHVwcGVyIDMyIGJpdHMg
WzYzOjMyXQ0KPiA+IHVzZWQgdG8gZm9ybSA2NC1iaXQgYWRkcmVzc2VzIGZvciBFSENJIGNvbnRy
b2wgZGF0YSBzdHJ1Y3R1cmVzLiBQZXINCj4gPiBFSENJIDEuMCBzcGVjIHNlY3Rpb24gMi4zLjUs
IHdoZW4gdGhlIEhDQ1BBUkFNUyA2NC1iaXQgQWRkcmVzc2luZw0KPiA+IENhcGFiaWxpdHkgYml0
IGlzIHplcm8sIENUUkxEU1NFR01FTlQgaXMgbm90IHVzZWQ6IHNvZnR3YXJlIGNhbm5vdA0KPiA+
IHdyaXRlIGl0IGFuZCByZWFkcyBtdXN0IHJldHVybiB6ZXJvLg0KPiA+DQo+ID4gQWRkIGEgY2Fw
YWJpbGl0eSBjaGVjayBpbiB0aGUgb3BlcmF0aW9uYWwgcmVnaXN0ZXIgd3JpdGUgaGFuZGxlciBh
bmQNCj4gPiByZWplY3QgZ3Vlc3Qgd3JpdGVzIHRvIENUUkxEU1NFR01FTlQgd2hlbiA2NC1iaXQg
YWRkcmVzc2luZyBpcyBub3QNCj4gPiBlbmFibGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody91
c2IvaGNkLWVoY2kuYyB8IDkgKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hj
ZC1laGNpLmMgYi9ody91c2IvaGNkLWVoY2kuYyBpbmRleA0KPiA+IDY0MDk0NTcxODYuLmI5ZTQy
NTFkNjIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdXNiL2hjZC1laGNpLmMNCj4gPiArKysgYi9ody91
c2IvaGNkLWVoY2kuYw0KPiA+IEBAIC0xMTA4LDcgKzExMDgsMTQgQEAgc3RhdGljIHZvaWQgZWhj
aV9vcHJlZ193cml0ZSh2b2lkICpwdHIsIGh3YWRkcg0KPiBhZGRyLA0KPiA+ICAgICAgICAgICAg
ICAgICAiICAgICAgaXMgZW5hYmxlZCBhbmQgSEMgaXMgZW5hYmxlZFxuIik7DQo+ID4gICAgICAg
ICAgIH0NCj4gPiAgICAgICAgICAgYnJlYWs7DQo+ID4gLQ0KPiA+ICsgICAgY2FzZSBDVFJMRFNT
RUdNRU5UOg0KPiA+ICsgICAgICAgIGlmICghcy0+Y2Fwc182NGJpdF9hZGRyKSB7DQo+ID4gKyAg
ICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICJlaGNpOiB3cml0ZSB0byBDVFJMRFNTRUdNRU5UIHdoaWxlICINCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAiICAgICAgNjQtYml0IGFkZHJlc3NpbmcgY2Fw
YWJpbGl0eSBpcw0KPiBkaXNhYmxlZFxuIik7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4g
PiArICAgICAgICB9DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+IA0KPiBJJ2Qgc3F1YXNoIHdpdGgg
cHJldmlvdXMuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwg
ZG8uDQpKYW1pbg0K

