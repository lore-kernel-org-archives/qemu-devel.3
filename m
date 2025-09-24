Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IbT-0000vt-Qw; Wed, 24 Sep 2025 02:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IbP-0000tO-Gq; Wed, 24 Sep 2025 02:03:45 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IbH-0001Pg-2m; Wed, 24 Sep 2025 02:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgugU7Cyt9d+/njZbRaLwjgtMOwhl6YX5nK+LYwRRr5iQzQRtJBYbsU5ssHCTc/vg1zk3FZCLSkhOQKEGDxlVKs9OLmUfo+6IbR2GepPYlNbcqCsGJ7dXXOVkXGjxQ+lmxkKE3c4HhrnVPDYxHK8YzM81gs869lJEMpJlmqHUNuS2NbTy17Mk3bKBgJkg08J6z/xHdGzMFkpPH+7/0gyD2O6NJAgZdSFrJDQjRxng/mjf2FXKcsv5n6SBCwPqV+RBkODufh99hqx5mWc01O82FXBlKfUBwLCA/FJms6H+DGNmCJZCd888fhivA3f9Qk95l8SqR17GKUYfhC1UJw4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDbqAwO6jKuJjhGuNn6HOc9HPYn4WBtrwAokzDarHcQ=;
 b=oj5WCnVrwfpasr48wlJ0LqUwlk3T7JA57yWBtarBrDaDuuVvVEumzgn1wlqEhLzhZk1SCqSMiyEg5xjdnN/qNNUjChxprDdevHC1XwIH6GQdpQsAnKGgCRECNOIoxH9BM9xKO948gq6dFVfKDp6csfFcagk3AhxFgBo3jPeoPoYvfmch8LSkrjL0Fr4WRFi9kIPlChCyklYNzTKj+ydcz7QwxMEmC30p+j88Smmwo2yQyii0K+kI5g3dLZaWIr8FSyw6SS6eG/7gMHAjq83ZT0vdUgra4nzlIxV2oHxGpqkB94Y/pWirUKTLpYSTtNjfOSqnZ4SE0VNxBgKEsuotig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDbqAwO6jKuJjhGuNn6HOc9HPYn4WBtrwAokzDarHcQ=;
 b=BaUHWTj2IeeFL8mOoh+ZjgXrWvnb2qH1xa9apOjDvLYpNEgbdti8c5hjmr1zM/B57vrrybsyCEXldu+Up+kAxt5ZN8nJ496Y5VndaDu+j5BcXCbfF50tN+9kZZPglxRX4q9v52emqAe9onD6vnQExxqlwH/QPk4MFZhrcP7G7kPMBEP4ENtuce139sFrWX8mBAaS4ofURG5NApZ3lPrKGAGpbROacv7Ypn+IutsVz1UnoW0PKjscB1ayD8goCIVJy14G/Iav99qW9N4n2dUelwJRyqhjHHrFS4foKQk/+EXsfjr19QFJhl7VCrYJ1hw64nKDU6vbjmBBawsoP31HPA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB7033.apcprd06.prod.outlook.com (2603:1096:820:11a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Wed, 24 Sep 2025 06:03:26 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Wed, 24 Sep 2025
 06:03:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP and
 ensure correct device realization order
Thread-Topic: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP
 and ensure correct device realization order
Thread-Index: AQHb9sykX4ZS+8HKlE6CthFW598H6LR/1CqAgCED8pCAADYQAIABNKFg
Date: Wed, 24 Sep 2025 06:03:25 +0000
Message-ID: <SI2PR06MB504175E8604D90397E631042FC1CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
 <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
In-Reply-To: <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB7033:EE_
x-ms-office365-filtering-correlation-id: 846e0b5b-18f8-41d5-442e-08ddfb301356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?dWhtR2s5OXBTRnNQM3B0ekFyaWErWTZ6Q0VuSUVreGNGUkRHVXhpdHZqWkl6?=
 =?utf-8?B?WGJQcGdpSk1MTUJKUjdhVFdOMlZXZ1pveW5kR0NWWlFkT1lWZlBSZVJ0ck5K?=
 =?utf-8?B?RlVXcS9RR09qd1h3L0tDeTgzeG1WLzY2K3l4SnA2NGN4cGJ4ZVljemtRWUcw?=
 =?utf-8?B?cmkwOEJLT3JxNkVnZWdNNERHdkhwcmc0MkdLTGVNMDZkY3UxZmtKUGQxMXIx?=
 =?utf-8?B?R3BEbHd2Y3FtVU83TldtVzErQithbzBTTE9tUHdKV1dEdU5UYXlLZUlDUlVO?=
 =?utf-8?B?VmhNaUNyWmZheFlZeXBvKytJMzcwc2JlVHZRNW5iOVRKaDQvQjFDM2dqN3JG?=
 =?utf-8?B?VktDU3dMcS8zMWdiY2dQbnp5SjYyZnpqQUd2dEpZVWdjNUtGVGVkN2M0NVlH?=
 =?utf-8?B?S2hmWTBBdUdwNTg4dkd2VWxpUHJWYnBSMVl0VmdhditPa1JFeXNVd2J5YjhC?=
 =?utf-8?B?YjFzeHFXdWVMK2tPUW5wQ25IQ1JvMGhNVzRudGtFeWdLem1YWmVMR0pHbVNn?=
 =?utf-8?B?a3dUUlJ1WmlXaXh0eW9pYjVpa1NCVDg4ek91R2N4YjJHVDVrWElMQVZndko0?=
 =?utf-8?B?aEVvZVk2Z2J2SXFZWTRJaDBuV2F6UDliN3hodkoraVRqVzdtREZrS0YzMTZn?=
 =?utf-8?B?V1M3Qnh2OGhlWCtHUjJRTzFKV2UxaVg5MmVON0tDZ1VWc1JpYmlXRy9yTFJp?=
 =?utf-8?B?bXRvWGxmYjB2aytqZWVPTnhWUFVFUkQ0bk5ueWh5T0Q3eXFJSktheWRYY3Fi?=
 =?utf-8?B?SUZZaFRNVklCbW1KWFFNNkhIMGpobXo3L3Qxd3ZMVWUyTS9FZk9RTHZBOHFp?=
 =?utf-8?B?MjhVRks5ZXgzV0V2ak9ZTmhHMG9KSkpIR1NIY096eEROc29sb1doQ0ZONFVZ?=
 =?utf-8?B?NC9HOWZGSE1mV2hkLzRXTHZoU21ETFgvemNSbEYySnZjekZBNStMaXk1YUFp?=
 =?utf-8?B?eGxUbndGc1NJaEl4c0tPVVh6a3BGeWpUWEo2eThJZ1ZLNjMxbFptTlE4dHEz?=
 =?utf-8?B?c1R0S0FCQVhyTUczWFJNZ00weThzTURLbnFWeTlTdFB1MlJiWG1uUm5LSW1O?=
 =?utf-8?B?MFB6SzZ1Um1sTE5mc2ZRbWFRMitNaDl3b1RkaG55NURNZjFBVWd5enoxdUh1?=
 =?utf-8?B?NldxMzQ0TGZQYk1XV2JFOWtWOTRud0VOVHVwWmRnN2Fhakx2THkxQnBxbjV4?=
 =?utf-8?B?Wm1qUGw1OVhKWlorUnFWOHFwMlAxUHAzT0Y4QThDY21RT1J4S1VzTStWYlA2?=
 =?utf-8?B?M1dBOXY4TWlRcmZYTm9keEw4aXRNakE2VnErSGl2S0Z1eTVRMCtSMVQ0VFhm?=
 =?utf-8?B?VllqMTY5ZXFXZ2dyNWNodzZiNUdHTHBEMm9kcENSMjZRRGxqNE01eGd2RVBM?=
 =?utf-8?B?MlVjcTdFZFVadEtzZzArV2lnWXkzMDNmeG1tK3JiMjJZME9YcWVVdWtCM01q?=
 =?utf-8?B?dG81cWluNTdySWNiOWVaODBsNWtCQTJLNWYzeDUvQnY5R1k0ZUt1VUxaT0M5?=
 =?utf-8?B?ZXJFYUlRV2l4RlRhRW1UYlFVSmwrTnNoMlgyWXFYY2Iyc3lxdHpBYiszenpD?=
 =?utf-8?B?SjRmeGUrNjVZUGRoYmtmTVp0SXVSV0lKODA5NnM0dWsvVjUvOUxzUFBKVE9y?=
 =?utf-8?B?U0dNVnJPS3ZjY2JxTmJvSFMydnh5UFhKVXdIbGRZZzlNYmpCRzJRTmNGUG12?=
 =?utf-8?B?MUp2YzNSeDBhL25uaUY0ZXA1bGFOSnUvMkw1OVJVZlpyUkRMa0I2WkRnOEdq?=
 =?utf-8?B?SU5UUXM0U1gyaUtBT0RuRUs2WHRsdjc5ZXBvUEZyNkphb2ZqVFpBbExCVm1n?=
 =?utf-8?B?aFpGbkkxcVFxcjd3NUZkSHdrUWZ3YWYwbkVpQisvQjhvNnhSQUhCSkU2QmVy?=
 =?utf-8?B?TGk1UUx1TWRHUVFxNHRSOXl2QmJGWEN2RXcrZndzMkIxUk9qQ3pHTHFRdHFM?=
 =?utf-8?B?NGtRNi9nVE5XbzE2WXJGVkNlZVVLRVJMamR5bWFWV1VpUHJGYlVwOElOZGxt?=
 =?utf-8?B?djczUXc1aWs0aXBTN0Z4UDRmVEhZOWkxOGg5STRhQzgzNmg3SndLMGI2bzdw?=
 =?utf-8?Q?MSgHQS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dStxOExmaGR3d3dhNjJqVk5Uc21rSEFSSGN6cFFGWEc2Tk1iYnFtd2NBTERo?=
 =?utf-8?B?Z2UyWWwzRmtWRVoyRHZMWmtzdFRNeUFQTENpRE5KQ2VKNUFZWXJJNCt3RUs5?=
 =?utf-8?B?WjhFeWtEUnZ6L3Jrc1VRSXZOWnhNcjRTWHVKdkJLU1k0c09WaUhqb2NNT0V6?=
 =?utf-8?B?bDJQbCttZFZ2dlpKNFliZkpaZlpDOURpUUNvS25Xb2Z3aEwvYXZCMWpuTnVr?=
 =?utf-8?B?YlBQSTlBMys0N0lmUUJtL3FpSGRuUlZpZzVrQzFucmxzWktXSTNvSFc0Qm1z?=
 =?utf-8?B?RmwrZ0JGbS9sNDVua1JJM2R5TWIzSXJVaGxJMmthNHk3UHV6eGZIVWVRWUFP?=
 =?utf-8?B?TFpQL0RRUVgwRVVNUzFEZ1pxR3I0TEd2emgxbXJYWnEwMHA1WFFLeUx2R2sz?=
 =?utf-8?B?bTlwY3NLOWk1UG1VdzBldCt2UHdDdk5JRVNqU01qaGRCV1ppOXgzcmtSTUpB?=
 =?utf-8?B?M0RScHoyMkErMFdMUUxVTHVZaGp1bXFlaTBhZ3A4aGN3b3pQdjFTWVBGZWNH?=
 =?utf-8?B?R1lUcmxvcXd1aGZtZFcwdFE5NFZVMVd4VlducURsajYyajhNMHI3MnE0cTNC?=
 =?utf-8?B?R0RIcGhNa2lvKzJxOTlua1VDRXJiMC9BUXpWbnhYcjVvUzhqN1lOVEN1aGc1?=
 =?utf-8?B?Z0l5THZZUWJYY3ZMWVZ6bUlhTXdacjVzNWN2M2p0VnY3bTNzL2ZtaVpBOHRm?=
 =?utf-8?B?ZmloQmdaU2RPbVVxRWhmNVNvcWhnUEVkNWJKYlRyNVdPUFFveU9Wb1Fhampp?=
 =?utf-8?B?ZkErbjBMQlBzV2l4TmtUNlhnbTc4U0oydmVHQnQvV3BTSmt1Vmw5V20yN0tt?=
 =?utf-8?B?cUdBMXAwbjE5bUFvdGUwLzhjWUc1M0hNMXk4WVpyaVRXVWptL2hEc3ZYK3RN?=
 =?utf-8?B?T3A0cUViQmVNYjJBQUQ4dkpOMnZjZHJyZVNGVWYzS3RidkI5MlM2SWl0RUtk?=
 =?utf-8?B?aGNrK0xITHpoMFcxZkFSczlYL1VPdXpEYm9Uc3ZXWnVaZUlXSXlNaE9rWGdG?=
 =?utf-8?B?bzdJOU1KekRjRHRENTh1S3dNMk02dFF1SDRDK3lNQzZ5Q0pzWFFkMU9hUzFo?=
 =?utf-8?B?bEYzUU5qU3M4TTBvdU9WdFN2YnJVQzk4a0RldWhicUtXSGZVSzFSWVhndSs2?=
 =?utf-8?B?OE5uUTZjbU5yZU5RdHBxWDlLeTR0VEtDMDJLSzRnTHFISDhaUFhxejM3eDIv?=
 =?utf-8?B?YmpkZUcxSjdVbE9YcUV3blVSai8vWEgrcUlyMllKRTdNSWQ2NVFGTXNWQVpQ?=
 =?utf-8?B?WngySVFZSWgrWnA0NFh4YkJ0Q3FwMFVPVDNoS3ZVa2dZelEwV3MxRjg1RGNF?=
 =?utf-8?B?dU9PaDBxY050cGkvNFNWMzRFR0lRYlljV3E1bUp4bktrWEpqZDI5aXlJM2Zy?=
 =?utf-8?B?WndxSDUvVHYxWm5iTjE0TEk2WWxFcHZCY1A1R2ZwMHBRc056amVtTzl2ekpG?=
 =?utf-8?B?RkhEdXN4dy9PZTRUS3hJNWxSK0JEeHdZL0VDRzBOR3lyZGtUYS9hdVR5dEhs?=
 =?utf-8?B?TEFaN2k0Z1g4RlloSmh1RGZveWpSY1FCbVRidFg3ZWlNUEtZaXUvRTZXbURZ?=
 =?utf-8?B?cXRpbis3NE9ZcnBSQ1pJamxLV3R0eVN1VytRazVWMEhwdWxxTm9qdWxEYzIr?=
 =?utf-8?B?UEN4SDZlb001S1VEajhmOTNOWjg3THpFL0dMQmlHcGxKaVpQd3pBc3F6RitN?=
 =?utf-8?B?aEU5UTk4TFovUm4ycDIzSW8zYU44NkVpUGdHd3Vqbk1qNlh2bkQ4Y3h0MVhM?=
 =?utf-8?B?eDNvdXVHOFR5YzU2WHIvaFlDSmJYb21PTUJzRTlKQ0paNlZ5VXlqZkYyUi9m?=
 =?utf-8?B?NTVrYUNXYmJuSUh1M0poYXR1d0p6LzVBNjdQY2wxZ1lldDh4WnFBYitGM0U2?=
 =?utf-8?B?RHU5YXJiWmtjTmVEVzBuTEFVK2xSOElyNVBNVDM5MVhyeGpYZTRhZ3lrNjFr?=
 =?utf-8?B?MmJoeTRPTmxZVDBJN0g1M2pvTURjcWZXdXMvbU1jalgzZ2hBbDd3aWVFVmQ2?=
 =?utf-8?B?Y1JqTE1iVFJITHRvbkxJUC9Vc1ZFTEh1SkxUZVBtZHFjd3dWd204R0I5MDUz?=
 =?utf-8?B?a2RjR2VtNjYwVkgyVGZwU2t6bkE1VEw2ZnE1WkVGY2llUkMyTzZuM3BKckhy?=
 =?utf-8?Q?vu7ZxSq0U/reC0Fiuoe9Rt5SL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e0b5b-18f8-41d5-442e-08ddfb301356
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 06:03:25.7434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3Hok88yMDrDW63ZGL6X1xZtj1mu6GhfQqOuRzdkX2v1Gs2Dxk3SCCtiGxt4JW5ygL3+fKRH9pilH2Rfd4pzdQMYm2Y1VnU7GDw7TUJ0bc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7033
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA4LzIxXSBody9h
cm0vYXN0Mjd4MDogQWRkIFNDVSBhbGlhcyBmb3IgU1NQDQo+IGFuZCBlbnN1cmUgY29ycmVjdCBk
ZXZpY2UgcmVhbGl6YXRpb24gb3JkZXINCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gT24gOS8y
My8yNSAxMDozMSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIEPDqWRyaWMNCj4gPg0KPiA+PiBT
dWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MSAwOC8yMV0gaHcvYXJtL2FzdDI3eDA6IEFkZCBT
Q1UgYWxpYXMNCj4gPj4gZm9yIFNTUCBhbmQgZW5zdXJlIGNvcnJlY3QgZGV2aWNlIHJlYWxpemF0
aW9uIG9yZGVyDQo+ID4+DQo+ID4+IE9uIDcvMTcvMjUgMDU6NDAsIEphbWluIExpbiB3cm90ZToN
Cj4gPj4+IEFTVDI3MDAgaGFzIGEgc2luZ2xlIFNDVSBoYXJkd2FyZSBibG9jaywgbWVtb3J5LW1h
cHBlZCBhdA0KPiA+Pj4gMHgxMkMwMjAwMOKAkzB4MTJDMDNGRkYgZnJvbSB0aGUgcGVyc3BlY3Rp
dmUgb2YgdGhlIG1haW4gQ0EzNQ0KPiA+Pj4gcHJvY2Vzc29yIChQU1ApLiBUaGUgU1NQIGNvcHJv
Y2Vzc29yIGFjY2Vzc2VzIHRoaXMgc2FtZSBTQ1UgYmxvY2sgYXQNCj4gPj4+IGEgZGlmZmVyZW50
DQo+ID4+IGFkZHJlc3M6IDB4NzJDMDIwMDDigJMweDcyQzAzRkZGLg0KPiA+Pj4NCj4gPj4+IFRv
IHN1cHBvcnQgdGhpcyBzaGFyZWQgU0NVIG1vZGVsLCB0aGlzIGNvbW1pdCBpbnRyb2R1Y2VzDQo+
ID4+PiAic3NwLnNjdV9tcl9hbGlhcyIsIGEgIk1lbW9yeVJlZ2lvbiIgYWxpYXMgb2YgdGhlIG9y
aWdpbmFsIFNDVQ0KPiA+Pj4gcmVnaW9uICgicy0+c2N1LmlvbWVtIikuIFRoZSBhbGlhcyBpcyBy
ZWFsaXplZCBkdXJpbmcgU1NQIFNvQyBzZXR1cA0KPiA+Pj4gYW5kIG1hcHBlZCBpbnRvDQo+ID4+
IHRoZSBTU1AncyBTb0MgbWVtb3J5IG1hcC4NCj4gPj4+DQo+ID4+PiBBZGRpdGlvbmFsbHksIGJl
Y2F1c2UgdGhlIFNDVSBtdXN0IGJlIHJlYWxpemVkIGJlZm9yZSB0aGUgU1NQIGNhbg0KPiA+Pj4g
Y3JlYXRlIGFuIGFsaWFzIHRvIGl0LCB0aGUgZGV2aWNlIHJlYWxpemF0aW9uIG9yZGVyIGlzIGV4
cGxpY2l0bHkgbWFuYWdlZDoNCj4gPj4+ICJhc3BlZWRfc29jX2FzdDI3MDBfc3NwX3JlYWxpemUo
KSIgaXMgaW52b2tlZCBhZnRlciB0aGUgU0NVIGlzIGluaXRpYWxpemVkLg0KPiA+Pj4NCj4gPj4+
IFRoaXMgZW5zdXJlcyB0aGF0IFBTUCBhbmQgU1NQIGFjY2VzcyBhIGNvbnNpc3RlbnQgU0NVIHN0
YXRlLCBhcw0KPiA+Pj4gZXhwZWN0ZWQgYnkNCj4gPj4gaGFyZHdhcmUuDQo+ID4+DQo+ID4+IFRo
ZSBTQ1UgbW9kZWwgb2YgdGhlIG1haW4gU29DIGNvdWxkIGJlIHBhc3NlZCBhcyBhIGxpbmsgdG8g
dGhlDQo+ID4+IGNvcHJvY2Vzc29yIG1vZGVscywgbGlrZSBkb25lIGZvciB0aGUgdGltZXIgbW9k
ZWwuIEJ1dCB0aGUgcHJvYmxlbSBpcw0KPiBlbHNld2hlcmUuDQo+ID4+IEkgdGhpbmsgd2UgbmVl
ZCB0byByZXdvcmsgdGhlIGNvcHJvY2Vzc29yIG1vZGVscy4NCj4gPj4NCj4gPj4gQ3VycmVudGx5
LCBBc3BlZWQyN3gwVFNQU29DU3RhdGUgYW5kIEFzcGVlZDI3eDBTU1BTb0NTdGF0ZSBpbmhlcml0
DQo+ID4+IGZyb20gQXNwZWVkU29DU3RhdGUgYW5kIGxvb2tpbmcgYXQgdGhlIGFzcGVlZF9zb2Nf
YXN0Mjd4MHt0LHN9c3BfaW5pdA0KPiA+PiBoYW5kbGVycywgaXQgc2VlbXMgY2xlYXIgdGhhdCBB
c3BlZWRTb0NTdGF0ZSBoYXMgdG9vIG11Y2ggc3RhdGUuIFdlDQo+ID4+IG5lZWQgYSBzaW1wbGlm
aWVkIHZlcnNpb24gb2YgQXNwZWVkU29DU3RhdGUgZm9yIHRoZSBjb3Byb2Nlc3NvcnMuDQo+ID4+
DQo+ID4+IFBsZWFzZSByZXRoaW5rIHRoZSBwcm9wb3NhbCB3aXRoIHRoYXQgaW4gbWluZC4NCj4g
Pj4NCj4gPiBUaGlzIHJld29yayBpcyBxdWl0ZSBsYXJnZS4gVG8gbWFrZSByZXZpZXcgZWFzaWVy
IGFuZCBhdm9pZCBhbiBvdmVyc2l6ZWQNCj4gc2VyaWVzLCBJIHBsYW4gdG8gc3BsaXQgaXQgaW50
byAzIHNlcGFyYXRlIHBhdGNoIHNlcmllczoNCj4gPg0KPiA+IFNlcmllcyBBDQo+ID4gMS4gTW92
ZSB0aGUgYm9vdCBST00gaGVscGVyIGZyb20gYXNwZWVkLmMgdG8gYXNwZWVkX3NvY19jb21tb24u
YyBhbmQNCj4gZGVjbGFyZSBpdCBpbiBhc3BlZWRfc29jLmgsIHNvIGFsbCBBU1BFRUQgYm9hcmRz
IGNhbiByZXVzZSBpdC4NCj4gPiAyLiBTdXBwb3J0IHZib290cm9tIHdpdGggY29wcm9jZXNzb3Iu
DQo+IA0KPiBUaGlzIHNob3VsZCBiZSBxdWlja2x5IG1lcmdlZC4NCj4gDQo+ID4NCj4gPiBTZXJp
ZXMgQg0KPiA+IDMuIE1pZ3JhdGUgYWxsIEFTUEVFRCBjb3Byb2Nlc3NvcnMgKGUuZy4gU1NQL1RT
UCkgdG8gYSBjb21tb24NCj4gQXNwZWVkQ29wcm9jZXNzb3JTdGF0ZS4NCj4gDQo+IElzICdBc3Bl
ZWRDb3Byb2Nlc3NvclN0YXRlJyBhIG5ldyBtb2RlbCBzdHJ1Y3R1cmUgbWluaW1pemluZyB0aGUg
bnVtYmVyIG9mDQo+IHN1YiBjb250cm9sbGVycyA/IGlmIHNvLCBsb29rcyBnb29kLiBDb3VsZCBi
ZSBtZXJnZWQgZmFpcmx5IHF1aWNrbHkuDQo+IA0KDQpZZXMsIEkgYW0gcGxhbm5pbmcgdG8gdXNl
IHRoZSBuZXcgQXNwZWVkQ29wcm9jZXNzb3JTdGF0ZSBpbnN0ZWFkIG9mIEFzcGVlZFNvQ1N0YXRl
IGZvciBTU1AgYW5kIFRTUC4NCnN0cnVjdCBBc3BlZWQyN3gwU1NQU29DU3RhdGUgew0KICAgIEFz
cGVlZFNvQ1N0YXRlIHBhcmVudDsgIC0tLS0tLS0+IENoYW5nZSB0byBBc3BlZWRDb3Byb2Nlc3Nv
clN0YXRlDQogICAgQXNwZWVkSU5UQ1N0YXRlIGludGNbMl07DQogICAgVW5pbXBsZW1lbnRlZERl
dmljZVN0YXRlIGlwY1syXTsNCiAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgc2N1aW87DQoN
CiAgICBBUk12N01TdGF0ZSBhcm12N207DQp9Ow0KDQpzdHJ1Y3QgQXNwZWVkMjd4MFRTUFNvQ1N0
YXRlIHsNCiAgICBBc3BlZWRTb0NTdGF0ZSBwYXJlbnQ7ICAtLS0tLS0tPiBDaGFuZ2UgdG8gQXNw
ZWVkQ29wcm9jZXNzb3JTdGF0ZQ0KICAgIEFzcGVlZElOVENTdGF0ZSBpbnRjWzJdOw0KICAgIFVu
aW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBpcGNbMl07DQogICAgVW5pbXBsZW1lbnRlZERldmljZVN0
YXRlIHNjdWlvOw0KDQogICAgQVJNdjdNU3RhdGUgYXJtdjdtOw0KfTsNClRoaXMgY2hhbmdlIGNv
bnNvbGlkYXRlcyBTU1AgYW5kIFRTUCB1bmRlciBhIGNvbW1vbiBjb3Byb2Nlc3NvciBtb2RlbCwg
DQpyZWR1Y2luZyBkdXBsaWNhdGlvbiBhbmQgYWxpZ25pbmcgdGhlbSB3aXRoIHRoZSBuZXcgQXNw
ZWVkQ29wcm9jZXNzb3JTdGF0ZSBhYnN0cmFjdGlvbi4NCg0KVGhhbmtzLUphbWluDQoNCj4gPiBT
ZXJpZXMgQw0KPiA+IDQuIEludHJvZHVjZSBhbiBGQyBTb0MgY2xhc3MuDQo+ID4gNS4gUmVmYWN0
b3IgU1NQL1RTUCB0byBzaGFyZSBjb21tb24gY29udHJvbGxlcnMgKGUuZy4gU1JBTS9TQ1UpIHdp
dGggUFNQLg0KPiA+IDYuIEdhdGUgU1NQL1RTUCBDUFUgcG93ZXIgdmlhIHRoZSBTQ1UNCj4gDQo+
IE9LIFRoYXQncyB0aGUgbG9uZyB0ZXJtIGdvYWwuIExldCdzIHBsYW4gaXQgZm9yIFFFTVUgMTAu
Mi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

