Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C112FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4aBz-0002OT-PA; Fri, 03 Oct 2025 03:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4aBv-0002Nw-As; Fri, 03 Oct 2025 03:26:59 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v4aBj-00034J-P2; Fri, 03 Oct 2025 03:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tng3Li+IyUAYwVuYE6+rF/nfWplE0/xzmCy7QOtkJL3u7oJlb6JVSqgDwAgvxKsmHTmHNekUG94MfW6W9iMvH+K+muhR6C5fnVC5SGPxxFbJVILr0Bf9sVVlSN967rapdQP00iQyCgjrTkfl3KNZaA0OlNKpvROMeVdn1Mldjkmj3j1oX6A4fEEVtog4XxdEp4F8VF36SAqMm8ySM8e/L+hKQNpv6LRGo7ODz/SOtigl3bD5sfMddQvNQu8a1rCHc4uLspuGXXjNo3dPfmtqrqntXGBpT3EpzUsceJretWxfVYbQnXzvkc4gULBH42VR44JYmMq9fdlVsP60JP7Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZumOEKiN1WX9v2YzpVfm+PTzsVmVQn/doGCJ1LoEC6Q=;
 b=RDDa8nf1Wl8/oWPLO9YUNty+wa4Xko1hvWcKc/dA8GZe7CpRLhLLdfGcYO3uG1J/ZUm0WHJH8YB1OiDQ09b3EeeVeAnhePSR7tBR5gOH8gJ17IImlmk6pZlDdJUaTvsU9dpe5jqe1KbqyKJTq3HtGuhuoyLU2tIxl+Ja0l9fxJpu+oRDwJUPPDrm/CN7VY/EtyVs7spnj0i/E6j5OW9ZBbhTXRZKxlpg6H7PWYchrmLfmc5wMCFUlq5izpIfCaIjgEETDhDqjPREe9MDx3mASFZv+Gru3cJCi+f7lXrY7J/FmLVOXF5rIm5/OmUFImDIeU2t4G9dU8uaAmKvj96vNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZumOEKiN1WX9v2YzpVfm+PTzsVmVQn/doGCJ1LoEC6Q=;
 b=nF7AMEn78cQ0Lj+hgqYLNH0+aLVZCAjqmsuOHzfE3rCJqnx8mc60BXCDt7OoLO2AcR8cNfwdKI8V+je0kssqLKyt7hQB8dGwGuODnT5MBmB9Xvv6ayofevN+5mBv9KSIY/MXUWO3YKhn2RiidQz6AggAUu+fhCA8HYlXAKhEMmq/wesZgUB1MRZLYELMSV1T+/vENcVJWBYn/S2jCd1XvGQRBJiuXvZ/nAynCDOjoQvrUETJBLbBX2S+GSaJ6BrV8sGPH2CKvod3JxDQU0M/0n5Xla/dSCQdNPtDdJqYFE9+2m9i0oq/4kS4pinpNZQujWz+CUViEpTsoac1TDLlQg==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by PUZPR06MB5475.apcprd06.prod.outlook.com (2603:1096:301:101::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 07:26:28 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%7]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 07:26:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
Thread-Topic: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
Thread-Index: AQHcMp8g54nINpzYqE6uaT6XYHM/HbSs5c4AgAAAZ5CAABPKAIADDdvQ
Date: Fri, 3 Oct 2025 07:26:28 +0000
Message-ID: <SEYPR06MB5037A213859BC94E6D082756FCE4A@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20251001064625.1058680-1-jamin_lin@aspeedtech.com>
 <20251001064625.1058680-4-jamin_lin@aspeedtech.com>
 <3e2c8210-9e99-438b-aa9b-13479d59f6c9@kaod.org>
 <SI2PR06MB504112C0F9FC1130B4C3D50EFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <bd37b890-1bed-4862-9df7-cca0ea9fa2d2@kaod.org>
In-Reply-To: <bd37b890-1bed-4862-9df7-cca0ea9fa2d2@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|PUZPR06MB5475:EE_
x-ms-office365-filtering-correlation-id: 8cabb809-03e8-47bf-5c11-08de024e2aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K0d0WUxRR1Z6RzkzVVJnQ0V1cEVEVmM5aWxyejFwL2U0T0RvZ1VkSnNnTjJU?=
 =?utf-8?B?bnBwaEhkalI1bXZJSVg4Z3F2aFBTbnZGd1JsbHZkMUF5NUNZL2VEd1huRlFD?=
 =?utf-8?B?Y2lmaXdHV0RRbnpnbnZqa1Zac1BCZXRTTHQyeWFBRTFNOFFkT21INDhiaFlr?=
 =?utf-8?B?Z1NvSG4xTzZjQjlseC9la0RNTytsRmlGOXhaay8ycFBQMGF5VjhHYzRENHE2?=
 =?utf-8?B?T09hR3hSOHE0bVVKUXdXRTBrbi9rSTM3cVRCOWJqalJHT1BYVFdkbDlaSkFi?=
 =?utf-8?B?VUdJQWdROWRHVXY5QWxPVnNIeFNnVThFeWFFMUtnR0N1RlIzUTQ3L01iWWIv?=
 =?utf-8?B?RHk3ejFkY0YwZ2hiY216b3lkVTNON1dnWkRZdlA0QUlXbUJGQUpRakJzKzli?=
 =?utf-8?B?K3lkbzZTdkNxd21qUjlUeDl3cWR2NlcrSWpqTzk5bUhYQ2E0WDR5MzJqbDhL?=
 =?utf-8?B?NTE0U1R0SVpPcTFkZTQ5bGdCVDFJUzMrRkNRdkhEWjltYUx4K2swMkJCWjc0?=
 =?utf-8?B?OUxzL1k5SURLTURQTWtyRGhUcXFaeWJkU08wY0ZEZUUvWVQvd1dpUUhhV1Z4?=
 =?utf-8?B?bDhCMWowTFdRVW9oaFlNUk5Ud2J1VEorWU0xN0lqaGxrc3BZclArY2EzZ05o?=
 =?utf-8?B?RkRzd2VTKzRKSVJFODM1dElTRGNWTS9nSmtMVVgwKzRsMThQL3kzOVltU0pq?=
 =?utf-8?B?T1liYlZPTlVSWVFxOWZTa0F5MmUvb20wZWZZSkVhbWJNWkJyNnpOaGJZbmVT?=
 =?utf-8?B?OXNzSkJrNWdGU1VUWlA4NDdMVEcyWFRrNmFRMVZkZjdKbFBzbCtZd3A0VkVk?=
 =?utf-8?B?YzgxYjMzcXF6OFR2a1dvUU0yUWh6eVJERUJJSWtBczU1aFpoc3l2dUVHQ2M0?=
 =?utf-8?B?WnRIS0YyWHJRNGhCYlBDV0JFK2JONVdSZVVTMXBrc3VMRk41U0JSejlZR083?=
 =?utf-8?B?dmZRbm5aV0tsTDM2dHNBTG9JQi9nT3VGSnpzMFlWZnhjN3VlN3R5T1RPbG5H?=
 =?utf-8?B?MHNadVprUi90TW4rUjl6TC9lekg2a2QzTlJuQ25jS283bEJla1I0OHNkMXYr?=
 =?utf-8?B?UmRvZnA2TVhZQVpNZUlsTHRnZFMrUWNIemdrQWVERkRTT2N5QWFhRGI5dFo5?=
 =?utf-8?B?MUNsODVrNlMyMVZpa1hZVFRFcW0wTS9QbHUzMmdac1VnSnZJdHFOMGRpaDg5?=
 =?utf-8?B?MzNLUTBicUxXbDRVd0ZVSnl5UTBIcEdVdFE3YjhLYVZSejdobmFpNG1KQ3cv?=
 =?utf-8?B?M2FFRlZTSTMwc2o5ZnBoTExRcFh2RTRPdEh3NTl1ZVNoNDlvK2N3YzZQNEFn?=
 =?utf-8?B?cmhKRDFkVjhKZDg4L290Q1dpT3lRQ1F0OWhTRXBEcGJURzBjempGbTNLVDJB?=
 =?utf-8?B?S3NGLzJMWGNiWmdCVU53ZURqZ3h1QklBSUUrR3FlSWNhb3JXTDY1R1R6TXhD?=
 =?utf-8?B?TXFzRzdubjRwUHFFdUdhTW40WDJmZUVmYnRyMjhZVXQwMjY4RkpJckpWZzVX?=
 =?utf-8?B?eGp2dFpxdzZZZDN4WkxGL0JsRnc5aVdrMGxxVmYxU1ZMWFY2ck1NYlBpcURH?=
 =?utf-8?B?blF5bVpaWG5GbXlSQ2Z3YlFsOXEycVBFYmtkRHRtd0E4a0JySEIwbSsxaVNP?=
 =?utf-8?B?ZkJaTHJmanM0aFZ3YWR3UnpSczZJeVhEZXlWcUcvckszQk0zeFdZVGVFRE5M?=
 =?utf-8?B?ampmeG4vaGVQa2ZlQVRqTVVSV00vczZ6MWw4Sks0WUF1VmZaVTJ5N1AzcEZ4?=
 =?utf-8?B?SC9kbzFaa1JycUg3djlrUXZGaE5wZCtPMS9FbkViZnJmT0tOc3FoWTNZZTVL?=
 =?utf-8?B?eUhDRm01VUN3NFNQT3NXRG1XdFRPa012Qk5BN3E4TVFJcjZ3c0J3UCtwQWZN?=
 =?utf-8?B?eUtKTUVmeHpIQmNpS0RuTHlOT1ROUTA1NVlDRHNXekhPdVZIRTVKR0tXUWVh?=
 =?utf-8?B?Qis1VlNucEVRUU5pTnY1cGpxb0tYbVNNRWl2VUNobjBvT2RPSU05K3lsZ0h1?=
 =?utf-8?B?dTBLSzZxV1M0dVF5dE12UVpJaXZSZWhBdGhPTTllRlhTN0dsU2FnUEMvQ2FI?=
 =?utf-8?Q?NUP8IU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck55eDErL0UzYU92TkhlNVlNZ29CRDJzVTdoczhWT2I5MGFQQVhPSGoyNmtJ?=
 =?utf-8?B?ZFVTZG9YZmVJSm9KWEhvMUtTd3g0NVl2bEI3cGVlMEluaWNKNVBTdjNHOWcy?=
 =?utf-8?B?Q3dvdVZ6VzgwYktIem5TUWw2T0o3T0xFUFQyaTdkNWxxcGw3M1plZzZNTExz?=
 =?utf-8?B?RFVNREZ1anhGZDlTcU1wcVBsSDFrT0tCSFZQZHQ1bk1VRloyMHJUd215eGtX?=
 =?utf-8?B?RUxFZVNEWnRoZEtHN2dNazFBMW1QUGdzd3Q3SmRCUkFBYlp6dllNK0dweFJ5?=
 =?utf-8?B?b3NjL2lWSGdMSm9LR2dUdEVRb2txVTFpdTArdUtSalhxTXhkUHV1WmY5UC9w?=
 =?utf-8?B?VjJCbUo3UlN0VzVCUEtKY1E5c1FQYXpadWRzbTBnR2hranRuSWdzbzI3VHdR?=
 =?utf-8?B?cDZxd3h1TFdSTFpLZU5NREpDRGlMeW5nUk1saXpVN1A5WlpwdWhoQXREVWRk?=
 =?utf-8?B?UjJyMzNGeEx6dFFlZTBSbEVOc3I0alQrWlpqVDJnQnd3SUR3WFg4a29iWUd6?=
 =?utf-8?B?TThCZVFFV0Qwd3JqZjU0Y0dPWWduMzRMSU5panNsOWIrRit3L1dsNTczd053?=
 =?utf-8?B?TS8zNUlQZDVHYVJOMGloVjIyQlZ5dEhPaU41RVVOK3RIM1IyNXJyVFpSY3Z1?=
 =?utf-8?B?N2E0SjEyVlRoTTdFdUhLR0diNjJnRVBHbEFqVGJSV2RkL0lkVC9ZMVhNMGp6?=
 =?utf-8?B?WXF5TFNqM3J0NThPMHJBeHRNSkVtaXpZZkZxa29HSDI1eEVGQTkzbHFSemxp?=
 =?utf-8?B?VXJlUWM5R3VRNTF1YkdGZlpnaXRKUTI3UndhSUNkYzhVVUZUb0RVWmdSZElU?=
 =?utf-8?B?OXFiMnNYS3hDZXZnRVc3MWkxNDFmby9FRWdHcTcwMjNuMytYTGdMV1gzQUNR?=
 =?utf-8?B?SldXWkJzQVVVcStTVU8vWTYrME16RXUzZVUwT3hxNnhNMHdmUXI2M2cxSnFQ?=
 =?utf-8?B?RXJUNVczc2I3cUVCKzM5bnRXTnVrVjhiMk5lYVRVSmR3VHBjbjhEWkNvZXRH?=
 =?utf-8?B?NFdaRUNOQk56Y2ZBcHZSMGtBREZaOXJvWkdlZnJiQldoUDBLMnVKcEF3ajRp?=
 =?utf-8?B?SzRWeXFTMGpCKy9tV3hUZy8xM1I0WW1Sa0R4SHA5Si83MGE5T1QzZm8wVCts?=
 =?utf-8?B?QkF2ajZWNVBPQjg3KzNDSXErTFNWcFpxM2d2aExOUUtMNXpSMEV4RUthN0xN?=
 =?utf-8?B?NjN4dmlFaFBJZENQVkxJeGwzMHM3M0JCb1lkNHMwOTkzTlhIcDU4VGtqU3lT?=
 =?utf-8?B?aDhWQmltbDVkZUFvOEczY25DMFBEWjJXKzRVQ0RVMjhEM0E3WmVKYkJxOFFL?=
 =?utf-8?B?c0hxdCtzc2hpRnNwdFFaR3FTK080VGprYjVoRzRaZ204TnBjMU5FZUc5OWRp?=
 =?utf-8?B?SHpsMVVBWGY3WWc1d3M4ZUpJbFZqUktyZmYzYUJoV2RkM1pBVEZoYUFNcytw?=
 =?utf-8?B?NlIzMSs2QzRXbThmYSt2ZmVpL0VQWjBBZFlaQU9YTklKd01YSGdCSVVSbXZB?=
 =?utf-8?B?ZVc0Z3duRno4RmVWSnlCWGM5TS83Y0tPRG9RSHcrM0MzSlYwdFVnMENSMzdR?=
 =?utf-8?B?dWl3RWh2YlA1V0VwM2kzaVBzYkxoMW4vSHJEbk9PbTByUU10STM0ajROY2Vv?=
 =?utf-8?B?QkdOTTRMN0t2TWpMN2pMMXhENkFRWGVBRlhzUWR1TXJLNW1WTTFqbVpYUlkr?=
 =?utf-8?B?UFNQZE1VQUxUTWlxaklZU0I5US9LdDBQTzNQd1BqSnE0Mkl1T29uanVmVUtC?=
 =?utf-8?B?d2hOL1dRYWtFSHd3aURFNmF4K05qdy90WWVkUkt6dHIrd0MyeTJNMmR3V0Mv?=
 =?utf-8?B?dWp6TjVLVk1EK3FxMWVKVlpzNGRrQ2I3RWhlSGxQRnZZc1hqUTZKRzRlTjJ0?=
 =?utf-8?B?SUVZamJ0ei9FWkJZVkxuMmlnVVJsNWFEZzZYaEhSUWlRaVNERTBEMnB2Zm54?=
 =?utf-8?B?RDVxUVFkam93LytXOG5zQ0xHV1NLU2Z4Z2c1bWxTZnZrdXZPVzFpVnZ4ejNJ?=
 =?utf-8?B?VHFhZE1OcEIwSHRYK2NxN3RVS0FDN1dBV0RqZGFYbFd3dXpvb1lrRHhsZ3ov?=
 =?utf-8?B?cFRRRUljeEZnVG1SaXNZcUZ0Z0xoTEZDK0c1MWNhbkI2N2JmU29BZ2VCaW0x?=
 =?utf-8?Q?Xk6zyUXbecjJgeFVZ2KJuEt63?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cabb809-03e8-47bf-5c11-08de024e2aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 07:26:28.3619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgeuyYr0kjfBnucoc9Vyt26XdVtXx18etOp/S2IIOVQ9zmTtnjfKqYzhtpfq4zxEdyb6izWex43jyAwrjoqHMyQmCnvXBGqTGP2huyRUnok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5475
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy8zXSB0ZXN0cy9mdW5jdGlv
bmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjOg0KPiBBZGQgdmJvb3Ryb20gdGVzdA0K
PiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiA+PiBDb3VsZCB3ZSB1cGRhdGUgYWxsIHRlc3RzIHRv
IHVzZSB0aGUgbGF0ZXN0IFNESyB2MDkuMDggWzFdIHdoaWNoIHdhcw0KPiByZWxlYXNlZCA/DQo+
ID4+DQo+ID4NCj4gPiBJ4oCZbGwgdXBkYXRlIEFTVDI1MDAgYW5kIEFTVDI2MDAgdG8gU0RLIHYw
OS4wOCBhZnRlciB0aGUgcmVsZWFzZS4NCj4gPg0KPiA+IEZvciBBU1QyNzAwLCB0aGVyZSBhcmUg
YSBmZXcgaXNzdWVzIHdlIHNob3VsZCBkaXNjdXNzLg0KPiA+IDEuIEFTVDI3MDAgKGFzdDI3MDBm
Yykg4oCTIFNESyB2MDkuMDggc3VwcG9ydCBUaGUgYXN0MjcwMGZjIG1hY2hpbmUNCj4gPiBjdXJy
ZW50bHkgd29ya3Mgb25seSB3aXRoIFNESyB2MDkuMDYuICB2MDkuMDcgYW5kIHYwOS4wOCAtLT4g
V2lsbCBlbmNvdW50ZXINCj4gYm9vdCBjcmFzaC4NCj4gPiBUbyBtb3ZlIHRvIHYwOS4wOCwgSSBu
ZWVkIHRoZSBwYXRjaCBzZXJpZXMoQ29udHJvbCBDb3Byb2Nlc3NvciBSZXNldC4uLi4pLg0KPiBJ
4oCZbSByZXdvcmtpbmcgaXQgc28gaXQgY2FuIGJlIGFjY2VwdGVkIHVwc3RyZWFtLg0KPiA+IFRo
aXMgcmVmYWN0b3IgaW50cm9kdWNlcyBBc3BlZWRCYXNlIGFuZCBBc3BlZWRDb3Byb2Nlc3NvciBj
bGFzc2VzIGFuZCB3aWxsDQo+IHJlcXVpcmUgc3Vic3RhbnRpYWwgY2hhbmdlcyBhY3Jvc3MgdGhl
IGNvZGViYXNlKEl0IHdpbGwgbmVlZCBhIGxvdCBvZiBjaGFuZ2VzKS4NCj4gPg0KPiA+IDIuIFN0
YXJ0aW5nIHdpdGggU0RLIHYwOS4wNywgb3VyIFNESyBubyBsb25nZXIgcHJvZHVjZXMgInUtYm9v
dC1ub2R0Yi5iaW4iLg0KPiA+IEFzIGEgcmVzdWx0LCB0aGUgbWFudWFsIGRldmljZSBsb2FkZXIg
dGVzdHMgb25seSB3b3JrIHdpdGggdjA5LjA2ICgtZGV2aWNlDQo+IGxvYWRlcixhZGRyPTB4NDAw
MDAwMDAwLGZpbGU9dS1ib290LW5vZHRiLmJpbixmb3JjZS1yYXc9b24pIC4NCj4gPiBQcm9wb3Nh
bDogZHJvcCB0aGUgbWFudWFsIGRldmljZSBsb2FkZXIgdGVzdHMgYW5kIGtlZXAgb25seSB0aGUN
Cj4gdmJvb3Ryb20tYmFzZWQgdGVzdCBjYXNlcyBnb2luZyBmb3J3YXJkLg0KPiA+DQo+ID4gQ291
bGQgeW91IHBsZWFzZSBnaXZlIG1lIGFueSBzdWdnZXN0aW9uPw0KPiANCj4gSSBzdWdnZXN0IHVw
ZGF0aW5nIHRlc3RzIHdpdGggU0RLIHYwOS4wOCBmb3IgYWxsIHN1cHBvcnRlZCBtYWNoaW5lcy4N
Cj4gVGhlIGNvbW1pdCBsb2cgc2hvdWxkIG1lbnRpb24gd2hpY2gsIGFuZCBicmllZmx5IHdoeSwg
bWFjaGluZXMgYXJlIGtlcHQgdG8NCj4gdGhlIHByZXZpb3VzIHJlbGVhc2VzLg0KPiANCj4gVGhl
biwgdGhlIHNlcmllcyByZWZhY3RvcmluZyB0aGUgQXNwZWVkQ29wcm9jZXNzb3IgbW9kZWxzIGNh
biB1cGRhdGUgdGhlDQo+IFNESyB0byB2MDkuMDggb25jZSBpdCBpcyByZWFkeS4NCj4gDQoNClRo
aXMgcGF0Y2ggc2VyaWVzIHdpbGwgbm90IGJlIHJlc2VudCBhbmQgd2lsbCByZW1haW4gcGVuZGlu
ZyB1bnRpbCB0aGUgQXNwZWVkQ29wcm9jZXNzb3IgbW9kZWxzIHBhdGNoIHNlcmllcyBpcyBhY2Nl
cHRlZC4NCg0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0K

