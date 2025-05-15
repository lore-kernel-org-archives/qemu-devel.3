Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02469C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFSsL-0006IH-VA; Thu, 15 May 2025 03:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFSsI-0006G5-J0; Thu, 15 May 2025 03:19:26 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFSsE-0003D1-Si; Thu, 15 May 2025 03:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfJjAukoVcvhSlioMWdRyRpJY9rIwz1D5JfF1adUz86u3e9gUW6k3wI1upA/ElUF8oYlCFgRjkbfmy4F/kTfWrL91+6lNF/xbmaoTY9mUZkOpKlOLOFqEOtXEo7oJRUmn4xCZJg9dY6M0m6oR1NwTtDbPXiPadsnKSmT0KAetRhgJ7fWNNX1QTTiuCw2WnQGr1J1cpIea03uQn993ZbcL/0QqHAmROuoi0oSx8ju3TvO28z7CEBFauWQ0h0lF7sFxbrQMzs2C+jBGYlFudCMKqS4sqEw54FPt2N5gSrmwGL7/EIADwj8Dk875zdsDjqaoaqvda3ZbsjNqBMtHGS74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0U5crOeovAIoW+ujnnzphmZtDGX/o1gv2irbna9IS4=;
 b=Ej/ULhJdObPvjkJBsFC/WQ3Wc7OcoP+H+arYZmqfcTfSDtv//mcGHqkZs1poiKdgjrnTjBUhkamnfwojJWjsdQcshN2eUy70GI8Lv2alAIAiTFt/H4a4rG2htiOuBiXpL6G68u832AwvlRvD/jyzhJg23IHf+ATLOz3mwHeTB77GR2yatJCGu1qU9trNWu1FLAZEV8XGVTWcET+kfrIy0jzZcYw154aoQaEZlIxuSioJbpvVl3e3IuJvAYXbzNdX/KfRL/6Mny9KvpYjjni32eJVV7T8OPbr5VE82B4r53Abh5Gyod76tf+h6WYaw7pByrMkcU1vxP50NrKlVRfUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0U5crOeovAIoW+ujnnzphmZtDGX/o1gv2irbna9IS4=;
 b=IzqXF0iH5mjkmTeCK9vJeqZWWrk+6BDD6kb7EdUlPD4F8/4SReFuCujbBvw9aOImd22lWq8TELMKekL25Mi9fnNQkcmtG8xvlVgjv6bpELPxS+8dNX0L7qXrFnGev+lZU6RfGRRFiZMUB6iIKBgmLxr0eC0qw3boWnW749NLyzTmo4cqTRKUFFxieKIoBwyxIJRvYojTFQ6nte3i7T8sgrvL8r3vKHAaC0GlteTlnfJPIyUOQvr7yRcT1xmDx/z/9ecNiwnVpXHwssN5ikC1l2ljnunpmw3KhFyq8dXweNaLClsrWyM2BMjBlvCJgqnOCR4mT/A/XZ8etPHnFCKjJg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB5513.apcprd06.prod.outlook.com (2603:1096:101:b4::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Thu, 15 May 2025 07:19:12 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:19:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Topic: [PATCH v1 08/22] hw/misc/aspeed_hace: Support DMA 64 bits dram
 address.
Thread-Index: AQHbmkNXc4tSzAUgS0eQdreGXV1+FbOQEMwAgDoaPGCAAYZDAIADS7lggASaaSCAAAZoYA==
Date: Thu, 15 May 2025 07:19:11 +0000
Message-ID: <SI2PR06MB504180C9B5CDC7C5D61A0C56FC90A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-9-jamin_lin@aspeedtech.com>
 <ff5e84c5-4714-4897-90b6-40df76746443@kaod.org>
 <SI2PR06MB504194D74CCFCBB9403B7214FC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ba12c8bd-2d9e-46f1-a89e-fa3692e1098a@kaod.org>
 <SI2PR06MB5041A336D11A710AB57F057FFC97A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB5041D40F9C8FE86EAD69FA67FC90A@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041D40F9C8FE86EAD69FA67FC90A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB5513:EE_
x-ms-office365-filtering-correlation-id: a0394c72-39d7-49e7-cf1a-08dd9380ca78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Q3BIYkF0NmR3c01JU2VpWmt1QkF1TkJTOSs0cENNNS9MU3NGU0dKVW1NS3dq?=
 =?utf-8?B?dHJEVmtRamFUVGZOTVpMSjVGdlkvWFZIR1R5Zm9DYmFjMDdkZE4xMWRyVUxj?=
 =?utf-8?B?T3RsT2d5d3d3VGVyWnR2cysyNGc3THh2M2V4cUE1TVpvZnZpUnRIU3VHNFd1?=
 =?utf-8?B?VER2UG5iNmFWZm9BSTNFdWZFbFlwWWlWNHFqbVB6Ri82Q3RHODduVzVOMjhw?=
 =?utf-8?B?czRvQUgwRGl4bUtqeXpDNkp5YVM1NVlTQ3NCMC9VTlpHSXM0MlpzRXRmL3Bo?=
 =?utf-8?B?azJhNGFCbXlGV21XQUVTMzJubUtWMDZGQUtseDBmWG9lS0dWaUkrdGc1SFNx?=
 =?utf-8?B?cHdZUmVhWmFYZDBhTmE2N3pQYWYyUmRGT3JXa0hmVFd3Z1lTN2R6c1Fja1RC?=
 =?utf-8?B?ZFVvdUkyeHNaTUF0bVhORjBJYmFQQk84SDhYVUF3dG85R0tmQjBpK0xOSVFS?=
 =?utf-8?B?SUI3OWlIa01pL0Q5NWswNHMrVzZSM2xOdmFHd1d6VDhNZGwwZUNyZnBoOUZs?=
 =?utf-8?B?VFRVclRDaFJzVGM3d3pJVHpjN0FRdkpOME5yci9RcGdOWFdmVEJFQm92cEQ0?=
 =?utf-8?B?djFyZnVyazhzbTFYOXBqVXZMd2E2dWZNQnJ3UUFKazJiZ3I4Nzc1enNtK2cz?=
 =?utf-8?B?QTdQYzE2d3A4cjlkTnRpSVJuSDBVOTNxQUw3VC9XaGZaeEhYUEpoZVIybEpG?=
 =?utf-8?B?ZkFPUWhzK21ZcVlJK01OTHpvWnZNeFF0VG5Uc3RzdWtvVmhPUWJwOVhxSk1Y?=
 =?utf-8?B?bWVKdzBIbGpUaStvSHNuaTNsd1l6NnBKSlpaWHcxQ0U0ekpsQkRZYzVvTVJo?=
 =?utf-8?B?SHg5dWsrdVM3ckdtalhmNGNKekxwd0liUlRyR3hsaGtYTzdGeWxINWlYcmND?=
 =?utf-8?B?NHcvNEtkaDFlL1pHTEtpK2xLYnJubndrSnArTFhEVlZuN2xYK2lEOVk3bEV6?=
 =?utf-8?B?c25UTzRxTXBqQ3IvWDJjZndWWjNZYTlhZjhybXRNOTVncjdzWTVsYmUvK28x?=
 =?utf-8?B?cXh4cDdpdmt0alRjeC8yb2o3STVQckR6TnRacFJnM3l2U0hsZmdBTzcxSk4w?=
 =?utf-8?B?TmVmUHRUMGRFaGwyR0JJOGEwZXMzNXJCQ2h4U2NURUZJcEpWeE9HTUEvY1Rm?=
 =?utf-8?B?WXVQUHpzMzlSRm9YNnRVNGRvNnBvTGtqTWNIQVRZWWYxNUtYYkZ6dENkWlRE?=
 =?utf-8?B?RUJ0dE05UEpNZXVMZlVReHBFUzVhTHQxbjdJZ29zWWtGdk9IYzJ3bmlaNGQ4?=
 =?utf-8?B?bnJGSEN1UEhGMy9nUGJMa3hHYUEyS05jR3plTWVGOWNORFZ0RUg1Q0UzNGo3?=
 =?utf-8?B?WFBlSFV2UGJLWTE0UEw2TFZNWWZhUVBpbDNmVVlXUWFibG95cGtBSGRKOVdo?=
 =?utf-8?B?WjRDcjI4dDZic0hXdWlSMWxKV0JiMlEvSHV2VHJsN0RHbUk5WmFUZUZHdFpJ?=
 =?utf-8?B?N0JScms2RVJjWlVVRHV5eWpsMXRTUURWbE83VThzMHRrUjQyS1RnWUpaS3E3?=
 =?utf-8?B?TTVoR3JmTTVoM1gvZHdESUk5cDFtTno1UzlMMit3a0xvdUdtWTdsbkpLaTJV?=
 =?utf-8?B?cC96TDBHSzVqYUhkL1pNMXQ0Y1RUT3RUMWVzOXlpZy9FbXVEKzRRV09WczdH?=
 =?utf-8?B?VHJLOGVMazV2RHNURloveldZdk1WZzd0VmJHRmFhOFV2M2pHZ3FmNWxnQXJH?=
 =?utf-8?B?OEtNUXVTdEJFQzY3dWlKVWoxRDk5S1VrRmpJNnJMUERyUUw1cUt3TTMyTWE4?=
 =?utf-8?B?eXVmeHB1cGN5OXpBQ1JFZnlkTWszUW5kQy8yMnpqVmFWU0Z1NXNYbU1SUzdx?=
 =?utf-8?B?dzM2eE83KzM5Nzhjc2ZpLzVpOFNNOFNlcVlRd1VoSXZzcUg5T2hXbnM0d1lX?=
 =?utf-8?B?T2N3ZkRha1hhelU4dHB3YW1KaklKQ090N1JaUlRiK254aHlwK3Q4VnprTEo5?=
 =?utf-8?Q?k7AriODXNztWry1ts11wMbucSLOzXXpD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnhzUTFWYTJzZ25yTGU2N0tGYlhwRkZ1eVN4RU5mQndMS005SFpmYWluaGtS?=
 =?utf-8?B?NVk2N2hlWXVFdXpDZUFRZTBWWkpUR1RNbnc3b2F6RXlIK0RacmRGN3ZlUGVi?=
 =?utf-8?B?QzI2TDJBVHhwZTh3MGlySzlOcW9sMVhVVmRJNDc0MXJjSnNMVEt0NXluM2w0?=
 =?utf-8?B?VnNDMHFGRTR3dkdxV3VSYWlLUk03RWZtVUhLVkErdHppK3FSOWJjM3poRjZC?=
 =?utf-8?B?VjYvNXQyQUxPTnozZmpyN1FERDE4SUFoUFVZdk1OdXV1MUc2UDlPeStOOHNa?=
 =?utf-8?B?ZFpraENPVGlla05qU1JIT0ZyNW43MVpvSlZjWENnNjRJUS9CTlcyaDBXNytp?=
 =?utf-8?B?eTdNKzltaUZSTzFucWVIQlVHZUV3U3ZwZVpnZm14NmxpTjJxZFhYWDI3NG12?=
 =?utf-8?B?Z1EvT21TdzFQN051M2NEZjAvZ3ZuUS9CcGNtRXdnZzNZUkMzRFk3c1VHQ0Na?=
 =?utf-8?B?NmYzVzVuYnUyR2I2aisxd2ozRUNaSEpPdGdERENkY0FMR3d0SFR2TC9lTVY0?=
 =?utf-8?B?M0RXMTZvOG5TRVM3Qm5NU3BFTllkbVNESTJiN2hkOTdrMENmazVQZDZjbG9w?=
 =?utf-8?B?ZU03TTRrNnl6KzV3Wkp4dm02TGpVS2VJVE1ybEJ2dmhqNVpBbUtIMTErZjNO?=
 =?utf-8?B?eHhlMEg5V1hJdWRyUWE1MjJiMkRIeElKditacGdCc2FjelNYT3Azdmw5cmJW?=
 =?utf-8?B?MjFZM0dzSlhySmhYSkJQYmUyQmhLWFNNVlI2amNveXJQbld4djZ0elRSRDR0?=
 =?utf-8?B?NERFRnFseERUdndYaEM4SDFDaEtsNnlWTyt4VEF5dk53aU05bDRCOXp2T3Ey?=
 =?utf-8?B?RTVzWUttam9YTUhLMnNpcVlSbkc3VjBLL3R1V3ZoSkRRL1VUVVgxYmloR2ZV?=
 =?utf-8?B?Q2VVTEE4MzF6T0MyRFJlSlFLWWdYQW5sSHlyTFNUcE14bFkrU1E2V2VXdFNx?=
 =?utf-8?B?dXlUVmw0NUVPdjdKUllIaERadStJYmVlL3FXUnN5SU5oRzRYdVN2d2dMdG9I?=
 =?utf-8?B?Z2tCU2UyWkUzR2FMYlBXbG5rRmt3cDJOaW1YYWFJaTRYZmZWMWFLYVoyNDBV?=
 =?utf-8?B?WjFoSlo4WERLVWcycEwwc2V1cGNGY2U1alI3RVpFSXB2NHdnRXA3dGllRW9P?=
 =?utf-8?B?VG1ZNUZYWUZteU91SDhTMUNBZjhKbXpqSDIvRSs3cFpzclNUWE9FRUZpWlJF?=
 =?utf-8?B?Y1dFRHp2UzgvRWttelorNTE2QlkvQ3BhS09nN3VDWGMvY0tIV1FZTVJtcWpw?=
 =?utf-8?B?VVhVN2tBb3FyRk1IVU1ac3JrMElEVDBKbkFBUk55c0xTeElhbGhCREhXbjI0?=
 =?utf-8?B?VGNDdjkwdk16U0ZFZmVmZFlJdityMFNjY3hUNlVZWmNUWG05Q3IyVzUycXkr?=
 =?utf-8?B?ckhpUzlPUENySUZ0WVpqMzhyN2pBdWlmQndPbXRWclRHYSswRWpJMjlCM0Iy?=
 =?utf-8?B?UjIxRWFWbGdaeWc0STV5NEFnbzRHd29PL2E2ZklKaFZvQWJkeUNsV2lyN3Nq?=
 =?utf-8?B?akdwMi9xRm42WldUaDI2cE82RVVuYnEyY1o3bWFIS2JMSE9HOFhJVUp3UWdC?=
 =?utf-8?B?MWQ3d1ovYWRGWnJQa0tnTjNzMGp1MUtvOHhUUjIvQ0FkUWdQMHBVMVN2N0Rh?=
 =?utf-8?B?K3IzYUxrenliSVZYR25vMWVDeWV5WWxRUUplWXJ5V0tMNjgycGh6cEJMY1Yx?=
 =?utf-8?B?SERQZldkQkx5MTdkRitQK2xiUjUxdXdybGRUVXVyb0JXQXZrYlZnSHhrTU9i?=
 =?utf-8?B?Zk4rVWcwU3l6amdFTkdHWElUUnVWNTd0bXBDQWtOSXg2ajJZWWZrREQzb004?=
 =?utf-8?B?VHYrR2pOM0tSZktMTmNjdFZsQm80ZXpiUXdkbTUvd1V0YTk1MVlIaUlPSU1I?=
 =?utf-8?B?dzhuZS9xSktDdVNoV2QxQklBTjRjb2dlWmNROGFzNnZpSlpxUUd2VmFINUM3?=
 =?utf-8?B?OUFlVExtM3NKajhud01WR2krQ0tzWSs4NVJTUXBKbFFvSG94K1EyeDBXbXlT?=
 =?utf-8?B?MlpLRUoyblRmbE5KRnQ1MlcrNGttQzJ3Ui90Znlsc2R3N0RtZkQzNW1sMldP?=
 =?utf-8?B?ZXo1WnRldEIxMmdydjRweGRrbUxSdkhDaEc2TlJRSDhSUDNEc3dtS3NEbTFn?=
 =?utf-8?Q?dkZzRtpIWklEmiagTykeAIY5e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0394c72-39d7-49e7-cf1a-08dd9380ca78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:19:11.6866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DE6EH78o1nq3CncGZeIWjPoUkAQiq+Sihwfo7fVDCAP5JhGQYn+FYq3y4ZK3NKBLtL3V00JTHjiKJOFMR61fa/GvWsMcIve+M+dXvA7B1h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5513
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

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMDgvMjJdIGh3L21pc2MvYXNwZWVkX2hhY2U6IFN1
cHBvcnQgRE1BIDY0IGJpdHMNCj4gZHJhbSBhZGRyZXNzLg0KPiANCj4gSGkgQ8OpZHJpYw0KPiAN
Cj4gPiA+ID4NCj4gPiA+ID4+IFRoZSBTR19MSVNUX0FERFJfTUFTSyBuZWVkcyBhbiB1cGRhdGUg
dGhvdWdoLiBBRkFJQ1QsIGl0J3MgYmlnZ2VyDQo+ID4gPiA+PiBvbiBBU1QyNzAwLg0KPiA+ID4g
Pg0KPiA+ID4gPiBUaGUgdmFsdWUgb2YgU0dfTElTVF9BRERSX01BU0sgd2FzIHdyb25nIGZvciBB
U1QyNzAwLCBBU1QyNjAwIGFuZA0KPiA+ID4gQVNUMTAzMC4NCj4gPiA+ID4gVGhlIGNvcnJlY3Qg
dmFsdWUgc2hvdWxkIGJlIDB4N0ZGRkZGRjguDQo+ID4gPiA+IFdpbGwgY3JlYXRlIGEgbmV3IHBh
dGNoIHRvIGZpeCBpdC4NCj4gPiA+ID4gUGxlYXNlIHNlZSBwYXRjaCA0IGNvbW1lbnRzLg0KPiA+
ID4gPiBCeSB0aGUgd2F5LCBBU1QyNTAwIGRvIG5vdCBzdXBwb3J0IFNHIG1vZGUuDQo+ID4gPg0K
PiA+ID4gU2hvdWxkIHdlIGludHJvZHVjZSBhIGNsYXNzIGF0dHJpYnV0ZSB0aGVuID8NCj4gPiA+
DQo+ID4gQ2FuIEkgbW9kaWZ5IFNHX0xJU1RfQUREUl9NQVNLIGRpcmVjdGx5Pw0KPiA+DQo+ID4g
SW4gdGhpcyBtb2RlbCwgaGFzaF9tYXNrIGlzIHNldCB0byAweDAwMDAwM2ZmIGZvciBBU1QyNTAw
LCB3aGljaA0KPiA+IGRpc2FibGVzIHN1cHBvcnQgZm9yIFNHIG1vZGUgYW5kIFNIQTUxMjoNCj4g
PiBBcyBhIHJlc3VsdCwgdGhlIG1vZGVsIGRvZXMgbm90IGhhbmRsZSBTRyBtb2RlIGZvciBBU1Qy
NTAwLg0KPiA+DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9ibG9iL21hc3Rlci9o
dy9taXNjL2FzcGVlZF9oYWNlLmMjTDUyOQ0KPiA+IGFoYy0+aGFzaF9tYXNrID0gMHgwMDAwMDNm
ZjsgLyogTm8gU0cgb3IgU0hBNTEyIG1vZGVzICovDQo+ID4NCj4gDQo+IEkgd291bGQgbGlrZSB0
byBjb3JyZWN0IG15IHByZXZpb3VzIGludmVzdGlnYXRpb24uDQo+IA0KPiBBY2NvcmRpbmcgdG8g
dGhlIGRhdGFzaGVldCwgdGhlIHNvdXJjZSBidWZmZXIgYWRkcmVzcyBsaXN0IG11c3QgYmUgOC1i
eXRlDQo+IGFsaWduZWQuIFRoZXJlZm9yZSwgdGhlIGRlZmluaXRpb24gb2YgSEFDRTIwIHNob3Vs
ZCBiZSBhcyBmb2xsb3dzOg0KPiBCaXQgMzE6IFJlc2VydmVkIDANCj4gQml0IDMwOjMgYmFzZSBh
ZGRyZXNzIG9mIHNnIGxpc3QNCj4gQml0IDI6MCBSZXNlcnZlZCAwDQo+IA0KPiBJbiB0aGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBvZiBTRyBtb2RlLCB0aGUgImxvY2FsIHNyYyIgdmFyaWFibGUg
cmVwcmVzZW50cw0KPiB0aGUgYnVmZmVyIGFkZHJlc3MsIGFuZCBlYWNoIHNjYXR0ZXItZ2F0aGVy
IGVudHJ5IGhhcyBhIHNpemUgb2YgOCBieXRlcw0KDQpTb3JyeSB0eXBvIC0tPiB0aGUgImxvY2Fs
IHNyYyIgdmFyaWFibGUgcmVwcmVzZW50cyB0aGUgYnVmZmVyIGxpc3QgYWRkcmVzcw0KDQpidWZm
ZXIgbGlzdCBhZGRyZXNzMSBhZGRyIC0tPiA4LWJ5dGUgYWxpZ25lZCIuDQogIGxlbg0KICBidWZf
YWRkciBBIC0tPiBkbyBub3QgbmVlZCB0byBiZSA4LWJ5dGUgYWxpZ25lZC4NCmJ1ZmZlciBsaXN0
IGFkZHJlc3MyIGFkZHIgDQogIGxlbg0KICBidWZfYWRkciBCIC0tPiBkbyBub3QgbmVlZCB0byBi
ZSA4LWJ5dGUgYWxpZ25lZC4NCg0KQWRkciBBOiBEYXRhDQpBZGRyIEI6IERhdGEgDQoNClRoYW5r
cy1KYW1pbg0KDQo+IChTR19MSVNUX0VOVFJZX1NJWkUpLg0KPiBBcyBhIHJlc3VsdCwgd2Ugb25s
eSBuZWVkIHRvIGVuc3VyZSB0aGF0IHRoZSAibG9jYWwgc3JjIHZhcmlhYmxlIGl0c2VsZiBpcyA4
LWJ5dGUNCj4gYWxpZ25lZCIuDQo+IFRoZSBhY3R1YWwgYnVmZmVyIGFkZHJlc3NlcyByZWZlcmVu
Y2VkIGJ5IHRoZSBTRyBsaXN0IGVudHJpZXMgZG8gbm90IG5lZWQgdG8gYmUNCj4gOC1ieXRlIGFs
aWduZWQuDQo+IA0KPiBgYGANCj4gc3JjID0gcy0+cmVnc1tSX0hBU0hfU1JDXSArIChpICogU0df
TElTVF9FTlRSWV9TSVpFKTsgYGBgDQo+IA0KPiBXZSBvbmx5IG5lZWQgdG8gZW5zdXJlIHRoYXQg
dGhlIHN0YXJ0aW5nIHNyYyBhZGRyZXNzIGlzIGFsaWduZWQgdG8gOCBieXRlcy4NCj4gDQo+IGBg
YA0KPiAgIGxlbiA9IGFkZHJlc3Nfc3BhY2VfbGRsX2xlKCZzLT5kcmFtX2FzLCBzcmMsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJ
RUQsDQo+IE5VTEwpOw0KPiANCj4gICAgYWRkciA9IGFkZHJlc3Nfc3BhY2VfbGRsX2xlKCZzLT5k
cmFtX2FzLCBzcmMgKyBTR19MSVNUX0xFTl9TSVpFLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwNCj4gTlVMTCk7DQo+ICAg
IGFkZHIgJj0gU0dfTElTVF9BRERSX01BU0s7DQo+IGBgYA0KPiANCj4gVGhlIGxvY2FsIGFkZHIg
dmFyaWFibGUgcmVwcmVzZW50cyB0aGUgYnVmZmVyIGFkZHJlc3MgYW5kIGRvZXMgbm90IG5lZWQg
dG8gYmUNCj4gOC1ieXRlIGFsaWduZWQuDQo+IEkgdHJpZWQgcmVtb3ZpbmcgdGhpcyBsaW5lKGFk
ZHIgJj0gU0dfTElTVF9BRERSX01BU0spLCBidXQgZW5jb3VudGVyZWQgYQ0KPiBmYWlsdXJlIGlu
IHRoZSBBU1QyNjAwIHRlc3QuDQo+IFRoaXMgaXMgYmVjYXVzZSB0aGUgQVNUMjYwMCBEUkFNIGJh
c2UgYWRkcmVzcyBpcyAweDgwMDAwMDAwLCBhbmQgdGhlDQo+IG9yaWdpbmFsIGNvZGUgYXBwbGll
cyAiYWRkciAmIDB4N0ZGRkZGRkYiIHRvIGNvbnZlcnQgdGhlIGJ1ZmZlciBhZGRyZXNzIHRvIDB4
MCwNCj4gd2hpY2ggY29ycmVzcG9uZHMgdG8gdGhlICJEUkFNIG9mZnNldCAwIi4gSW4gdGhpcyBj
YXNlLCB0aGVyZSBpcyBubyBuZWVkIHRvDQo+IHBlcmZvcm0gKGFkZHIgLSAweDgwMDAwMDAwKSB0
byBjb21wdXRlIHRoZSBEUkFNIG9mZnNldCBvbiBBU1QyNjAwLg0KPiANCj4gQXMgYSByZXN1bHQs
IEkgd2lsbCBub3QgbW9kaWZ5IFNHX0xJU1RfQUREUl9NQVNLIGluIHRoaXMgcGF0Y2guDQo+IElm
IHlvdSBzdGlsbCB3aXNoIHRvIGltcHJvdmUgdGhpcyBwYXJ0LCBJIGNhbiBjcmVhdGUgYSBzZXBh
cmF0ZSBwYXRjaCBzZXJpZXMgdG8NCj4gYWRkcmVzcyBpdCwgc2luY2UgdGhlIGN1cnJlbnQgcGF0
Y2ggc2V0IGhhcyBhbHJlYWR5IGJlY29tZSBxdWl0ZSBsYXJnZSAoMjkNCj4gcGF0Y2hlcyB3aWxs
IGJlIHJlLXNlbnQgaW4gdjMpLg0KPiANCj4gVGhhbmtzLUphbWluDQo+IA0KPiA+IFRoYW5rcy1K
YW1pbg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4gPiA+IEMuDQo=

