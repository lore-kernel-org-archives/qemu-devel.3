Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1B6CD6E61
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKh9-0001uO-E8; Tue, 02 Jun 2026 04:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUKh3-0001tL-9B; Tue, 02 Jun 2026 04:41:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUKgz-00037C-U6; Tue, 02 Jun 2026 04:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=romeTRr3lNuRMv1377M1Kq5v0MRTQZZPp9oIl6TXKLxUa4nirr6feAiBSz7HlsZU4ubrX0U+iqxW+NL4jfKZzqY/UCGwe9Dkt4g+FIghCyZ8YK/evpzCk4JmBx67alHo9Ya7vi9h7fCGKIJKzI4c2983LjDEWCLO6LDjGXMfL8KSdw2idnpwB/If9oQ9q4xdVU5dan/mzyFLuQGWsh555D3CP01XetQGb7Bfzf5I4BK2sUlEYTdMedCcomMm+TcNlvhCVK/aCNLk7Rx3qcN3oSHvXRU0FV+Cysmg76R6QsFx7ZdWX9acm15syIOrbtI1l7N6UGDqo4rD7hK0/DoUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVF+t42ivqWwfD2k32kODsy6vzOmXjUd/o0sROgeUcU=;
 b=AqH0Hs8bGOlGCV788dkagbaqmXt5/5dO8zoXsH+VrMuAOOvBYFf9lKZN8UE7o89ovgegGhnc8pabJpZd+NyVtzBCuSK+KlPPLkDMhBqYzCT3NK1sR7mBxjBjtU+N102DaKToVgMiAE8M0Ujdqrz4bZOuOwx/yf95GB0VmPnoq2tf2QmI3f0gzKwQ9uHjc6Fot0b+8TO0UKKwbKEiBOR2gZC6Hz0POpayVTbBrMQeoVz6GB3UWVT9qm9+qO3Xk/TcAZ8DwLGLYUeSAxshSCBZhLdQFcQSu5rltY28jMjKfuU846F1gkK1Qovq2jSd5qsQwlVpNGoU1iW1Ut1G9QbJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVF+t42ivqWwfD2k32kODsy6vzOmXjUd/o0sROgeUcU=;
 b=nncUCCDPhulEGwAYdCroY6EIqIE/3bDVhbMKCtm5xAz//o8yAuMGEHWNV2UO6SuKZ4WR/1yO+67RZO9nbPQrDzwo4Dql4cJQpok8bw3TDYHFjrszIs447fM64SE960ErWVlkdwdhP26CZ6FN61vtsN33tiyhZocF/YXxSC1ugS1EGGD33Al+b07Cwgu6uf7FiHF5UwI5v1iVsSTYem+RKLwZtAOPatl/jFLj3fAzNoTeIbDVDIWZ+OmjLpS8mgRTVEK99z26zKibx1HAFUqspoY9U/BVr4L+jBwzhB85ZK3qxHdE0KvpPLXKiXwNpwsfabglZEVkYxtgCnIwyjGAXQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF06C2A6398.apcprd06.prod.outlook.com (2603:1096:108:1::7c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 08:41:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 08:41:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Topic: [PATCH v2 08/10] hw/arm/aspeed_ast1040: Introduce I2C support
Thread-Index: AQHc8lCqXQYkF7vSPUq9WdALtqsNs7Yqzu2AgAAikRA=
Date: Tue, 2 Jun 2026 08:41:37 +0000
Message-ID: <TYZPR06MB49800F9BE2C9B92422F44592FC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
 <20260602052827.1535299-9-jamin_lin@aspeedtech.com>
 <554cdfc3-13b0-48c9-83e0-b5e43461f7f7@kaod.org>
In-Reply-To: <554cdfc3-13b0-48c9-83e0-b5e43461f7f7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF06C2A6398:EE_
x-ms-office365-filtering-correlation-id: fa4d477f-077d-4686-771f-08dec082c275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info: 8VJTWj5KhwzjGSdAQcXNkp6nf9QLtSNAUtU5FSU/HtBMdyzT32o6DdhxxOQMV0ZZ6J1nTRpGqqEQlhJ1lfyWKFZcQYDrJgkzX6eGQBgPRljmQ8sxvyMjXXQjiE4Ljq3A+VoOQ8Cmz3GKAQcn2UqKCfNSQLBiIc9C9MMyVT3zmNU1t4wNpqIbAa8L/uUi+v2K9Aj2WdLer8XLXQmH2TArF3O1d51Jhl4wfYqRA7kSA9XXHi69KjbfPLXYOEl0YWec//z9XB/HGw4zwPTOtA4xBhW4LoXn0XyulNa69PBjogKAbrHsf9e/fXqmCL+/s15e+EKimgWMGCs5rurLC/dPviPEcs7dQFXdb1iUyjgyHP7nM1qYGWEa63SaG/DyZ6mdD2IkNjk4YzIUhDsiUizAzcrEXHpcRr0M3dhF0LS8q1HJIvN1L1Bv2QskU3v4tD2Untq+GgYtdUD7MzL3+TAPuo7RG2yV+PuLT34GR8KCld1zfTozv+WmruxlYH1H02KR3r7IyYFBRJSq95SnXt6P46WErl1uqBXfzHRtCsLHzWqGgaG3DJInilFmoLFH39/WOKHJnQ+hoEH5P/NSXnCXttQLyljJuZm9C89dNzlxoqFFv7TDU2+Awk5f109yqHKSc8Y92a++wQhGQp8U6l3NbspdUfh939E9ZUConsw5ZJQV07TiAhKsEDaPjTEHrNu81d3h1EX/Ku4IDweKd7ju4OMH9MoB2Xn9jtGhnoTKfuSNaHM424TrneCAThESKB4r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEpBd1Q3aXZJVlUxNjZ5SE8wSWE2b0diSTYzb2EySVJzVUJTL0tNNXVTM3RF?=
 =?utf-8?B?eXJpMjV6Q2xPeXBpcGhCcEUvaDRpYnRNWDloeVM0amszOEhTdGE4MUdiWm1W?=
 =?utf-8?B?dGJmQXJqODhVRitJajVrc292Q1VkdWtUcUx1ZEVkU2phVlB3QlU0SHl1M1hO?=
 =?utf-8?B?Z0Y4b2FhcU5zb2E0aytwd3AybjZnWmRURHNWQXFUOG5MbHpUTkxIWDlrdStK?=
 =?utf-8?B?c3prclpVRm1wMUdoeXY2OU92dDd6c0hnOHkvdW1qWTlyNUhINEVTb2FIV2tY?=
 =?utf-8?B?eERVQlA1aUx1NUwvWkhCc25zSkN2YjNKK2ViTFRTMlExeXBnODgzZ2pIeHJr?=
 =?utf-8?B?cmNaOW9mVlJCUWpBbksrZk5nQk5aTXRzSjFGclBIZlBIRGNlQjFONFl3c05j?=
 =?utf-8?B?WVh5N0xYaHVNQThOU1lYNXhEVzdHMXR6RzQwVjZXWElTaU4veUw5U0lLNHNo?=
 =?utf-8?B?dWdwWGNTL3BhTE1JRm8vOFAzazNTWlV2eWZ0bFFSMzJ3ZHpUd2w0d2JUVTdK?=
 =?utf-8?B?V0F3d0liVTJGQkNnemZ4eEF2UUZ6KzgxMXRGR2hlcldmalJsbVU2REJYQVV6?=
 =?utf-8?B?U0g2elhwMDI1WVFIUGVwb1h1Ym9TNUl1dlFIaVJzK2Q2RmhvREw5ZXFqdmRw?=
 =?utf-8?B?RFZmNURwOHFIM2s3dnZVS1dKT2hpcnVoL0VSY0Q5eTBVM05QMmVIM3lJaC9E?=
 =?utf-8?B?R3VLY3FqZUs1VkJSYzhLMDRtVzFxR0FoRFphZlhuUWNTdTlaSkVEdlY0MFpP?=
 =?utf-8?B?ci9PNWd1RWNQMEZ3NmdMQ012UHpNM1lYZ0swWW16VTE1R2VadTFhQzRoRFFl?=
 =?utf-8?B?WHY2QnFsNjJ0cExtMmZPTFdWeU5PWnVPTHBUaTgvOXZlaldFcU9hSGhUY3Nn?=
 =?utf-8?B?MG9jaEJOWjBkejBrVURWRnAybklrTUFoM3F2TDh4RjUwak93aVpOdm5OZGxR?=
 =?utf-8?B?T3JLd2hjMnppVytUakpVQmVQRWRrWGNJaG01Q3BUUG5wazJ4OGc2elZUOE1a?=
 =?utf-8?B?R2UrbmEwRkNQSlRQN24xV1Y1b21rYWlyRTRiMHJaS1NqOUt3endYZXB1aGxj?=
 =?utf-8?B?S1dneDFzYWdQbzdLbzh6MndweHVrQmRCYXA3b1Zyd1lFOHJBWThic0dEcjh5?=
 =?utf-8?B?emV3MjRub1hSdXA5K3R0N0J4ZXdoMFZHcU9LT1JHK09VVkszS1EwN0VZQ3k5?=
 =?utf-8?B?M3ZVYjF2U3VmT2Y5TW5HKzJYV2FacVplTUwram5mOWNlOTNIaitnbnNjVm1C?=
 =?utf-8?B?UnpxYUp1Q2JrVk9DT1R1MkpCYXhtSWhIdlhEc2JJdXB5cGZ2SkVHby9ENU9l?=
 =?utf-8?B?ME9WNEsySjNiV2lHazZyM2k4MWxSbmJiV25UZmtKeGY4MkkrV0Rvb2hFbVp3?=
 =?utf-8?B?aDZXNFVZWUROQmxSYmVndEVadFMzdXRHSktxRGpTaFg0YlRUeXB0QklUYnRG?=
 =?utf-8?B?dkYyZ1hjeFVtWXRoZzRQRkZYL2VPZlFEOEt3YVRaNm9YTTdQNWljb0x3cTIr?=
 =?utf-8?B?ckJsOVVQTGFIanAvcXgvQ1p5dG1vc2NzR3NuNTNsQW9EYXB4c2JTaWt0UUZu?=
 =?utf-8?B?MGlWWHlMR1l3ODR4d29DQWc4cHgwaE44dU5jaUswNU5IekpMOFc3WUorTEVU?=
 =?utf-8?B?OENoVVFXWlovd1RoYWpjcFk5SmxreHdQejdnUVJrZ3o0Z1NvSThrZEVqblVn?=
 =?utf-8?B?d3JSdUVSUEdDNnJ0S3lwVHM0VHRDWlhtUS9iTW8yejB2Z1o5Y1pSUEJiaVNX?=
 =?utf-8?B?UEhEQXgwTE1sbjVxVEQ0SHNUZU5lRnhGdGhCUmQ5dXZKdFZQbk9Gdk1Jb2Rv?=
 =?utf-8?B?azdnOUxDcmQ5WGsyek1jSzc3RlEyMDhnbGk5V1RteHR0bVRxOHBQZmlnbXVP?=
 =?utf-8?B?Tm91S1lYZnowZFBkZDd4aTd0NEN0NWdzTFNXamJUd0hQU2FjN2J4MFVKVFlo?=
 =?utf-8?B?d0czV1plb24xRGtqYVhVYzdlZ1k2ZjJuUjZLYWRURE13eFBOQVZMaWZzZXhi?=
 =?utf-8?B?U1BNOThZNUpsS1dRWHN0RlU0Y0lSNDFhVkhmYlZnWVo0cU9uNjU3OGQ4Z2Fn?=
 =?utf-8?B?UmFlSFE5cmp0WjNud3FKNEoxeU9zRHBJSFI5Mk52S3dqSi9rV0tZeHY2MnU2?=
 =?utf-8?B?LytVUzArSS84VTdRNGszdHJFTDFEWDhpeHFmU3c1MlRySU91UkN2b3NSV3Ry?=
 =?utf-8?B?czVmVENXSHo3M21UUlZNT1o5V2ZDSnNJU0VudzlmNlVwdFhRelovWEtmSDJ6?=
 =?utf-8?B?aEFydC9hOUVhR0FpSVVhWjlVekNzWDJ1SStpNjVVVThCS0xhQUFFeTMrOUN1?=
 =?utf-8?B?eFFpRWtiZFNLaEpmRjRseHVGWGJ5YUpLdmpYTUhvZU9NekpRczZGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F6gIJck08tf1kbUhf4/jlFVtshIb3EGgL63PGfmmbZgPs9mDQndoHc7Eosydo7vHAC0QfdXmW756sw+asQyseTcEw57n6OW3LAnEeLtB5XvFVS8raRlDlr9r38jRJuOeU/tyYnTc5AB6gdMfgt3JUKfMfw0w/siaEzjyqrF3Q7H/RooAlZr+IXD1aiImdk60sx4rSDiGpLDk2AygUOadLl3YboAKYSKkdIcx1v/oOxXXzSiSefUcdPmjw7LDbeY9tuKZvhNSh0HQ/fFyh7ATQ40N7KQSw+LH3f2XYqWsqvapj0XDneGVQfXk2pVQzbycWRR8ZDYGqne10nbHtOyREw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4d477f-077d-4686-771f-08dec082c275
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 08:41:37.3770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmoVCb6xn0Tto3TX+ToGCPFcpHLVBsa5epK0cEuM/WqEiOhn41psAAadqKe4ODgjtxdvlIfLmGUHwvYV41UKWTFrkHRlE2J+o0jTunqq56s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF06C2A6398
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA4LzEwXSBody9hcm0vYXNw
ZWVkX2FzdDEwNDA6IEludHJvZHVjZSBJMkMgc3VwcG9ydA0KPiANCj4gT24gNi8yLzI2IDA3OjI4
LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW50cm9kdWNlIEkyQyBjb250cm9sbGVyIHN1cHBvcnQg
Zm9yIHRoZSBBU1QxMDQwIFNvQyBtb2RlbC4NCj4gPg0KPiA+IFRoZSBJMkMgbW9kZWwgdHlwZSBp
cyBzZWxlY3RlZCBmcm9tIHRoZSBTb0MgdHlwZSBuYW1lLCBhbGxvd2luZyB0aGUNCj4gPiBBU1Qx
MDQwIFNvQyB0byB1c2UgdGhlIGNvcnJlc3BvbmRpbmcgYXNwZWVkLmkyYy1hc3QxMDQwIG1vZGVs
Lg0KPiA+DQo+ID4gVGhlIEkyQyBjb250cm9sbGVyIGlzIG1hcHBlZCBhdCAweDc0QzBGMDAwIGFu
ZCB1c2VzIElSUXMNCj4gPiA2NCAtIDc3LCB3aXRoIG9uZSBJUlEgYXNzaWduZWQgcGVyIEkyQyBi
dXMuDQo+IA0KPiA2NCAtIDc5LiBUaGUgaXJxbWFwIGFycmF5IG5lZWRzIGEgY2hhbmdlIHRvby4N
Cj4gDQoNClNvcnJ5LCB0aGF0J3MgbXkgbWlzdGFrZS4NCkFmdGVyIGNoZWNraW5nIHRoZSBBU1Qx
MDQwIGRhdGFzaGVldCwgSSBjb25maXJtZWQgdGhhdCB0aGUgQVNUMTA0MCBJMkMgY29udHJvbGxl
ciBzdXBwb3J0cyAxNCBidXNlcy4NClRoZXJlZm9yZSwgdGhlIElSUSByYW5nZSBzaG91bGQgaW5k
ZWVkIGJlIDY0IC0gNzcsIHdpdGggb25lIElSUSBhc3NpZ25lZCB0byBlYWNoIGJ1cy4NCg0KSSds
bCB1cGRhdGUgdGhlIHBhdGNoIGFjY29yZGluZ2x5IGFuZCBzZXQgdGhlIEkyQyBidXMgY291bnQg
dG8gMTQgKGRldmljZXMgMCAtIDEzKS4NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9xZW11LWRldmVsL3BhdGNoLzIwMjYwNjAyMDUyODI3LjE1MzUyOTktOC1qYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20vDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4NCg0KSmFtaW4NCj4g
Pg0KPiA+IFRoZSBjb250cm9sbGVyIERSQU0gbGluayBpcyBjb25uZWN0ZWQgdG8gU1JBTTEgKEh5
cGVyUkFNKSBmb3IgRE1BDQo+ID4gc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJt
L2FzcGVlZF9hc3QxMDQwLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3Bl
ZWRfYXN0MTA0MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwLmMgaW5kZXgNCj4gPiA3NzIxMWNl
MWYzLi42ZDFjYjliMTAyIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0MTA0MC5j
DQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QxMDQwLmMNCj4gPiBAQCAtMTE3LDYgKzExNyw3
IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MTA0MF9pbml0KE9iamVjdCAqb2JqKQ0KPiA+
ICAgICAgICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJzZ3Bpb1sqXSIsICZzLT5z
Z3Bpb21baV0sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQu
c2dwaW8tYXN0MjcwMCIpOw0KPiA+ICAgICAgIH0NCj4gPiArICAgIG9iamVjdF9pbml0aWFsaXpl
X2NoaWxkKG9iaiwgImkyYyIsICZzLT5pMmMsDQo+ID4gKyBUWVBFX0FTUEVFRF8xMDQwX0kyQyk7
DQo+ID4NCj4gPiAgICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJwd20iLCAmcy0+
cHdtLA0KPiBUWVBFX1VOSU1QTEVNRU5URURfREVWSUNFKTsNCj4gPiAgICAgICBvYmplY3RfaW5p
dGlhbGl6ZV9jaGlsZChvYmosICJlc3BpIiwgJnMtPmVzcGksDQo+ID4gVFlQRV9VTklNUExFTUVO
VEVEX0RFVklDRSk7IEBAIC0yMzMsNiArMjM0LDIxIEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9z
b2NfYXN0MTA0MF9yZWFsaXplKERldmljZVN0YXRlICpkZXZfc29jLCBFcnJvciAqKmVycnApDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGFzcGVlZF9zb2NfYXN0MTA0MF9nZXRfaXJxKHMs
DQo+IEFTUEVFRF9ERVZfU0dQSU9NMCArIGkpKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAg
IC8qIEkyQyAqLw0KPiA+ICsgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVCgmcy0+
aTJjKSwgImRyYW0iLA0KPiBPQkpFQ1QoJnMtPnNyYW1bMV0pLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gKyAgICBpZiAoIXN5c2J1c19yZWFs
aXplKFNZU19CVVNfREVWSUNFKCZzLT5pMmMpLCBlcnJwKSkgew0KPiA+ICsgICAgICAgIHJldHVy
bjsNCj4gPiArICAgIH0NCj4gPiArICAgIGFzcGVlZF9tbWlvX21hcChzLT5tZW1vcnksIFNZU19C
VVNfREVWSUNFKCZzLT5pMmMpLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHNjLT5tZW1t
YXBbQVNQRUVEX0RFVl9JMkNdKTsNCj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCBBU1BFRURfSTJD
X0dFVF9DTEFTUygmcy0+aTJjKS0+bnVtX2J1c3NlczsgaSsrKSB7DQo+ID4gKyAgICAgICAgcWVt
dV9pcnEgaXJxID0gcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJmEtPmFybXY3bSksDQo+ID4gKw0K
PiBzYy0+aXJxbWFwW0FTUEVFRF9ERVZfSTJDXSArIGkpOw0KPiA+ICsgICAgICAgIC8qIFRoZSBB
U1QxMDQwIEkyQyBjb250cm9sbGVyIGhhcyBvbmUgSVJRIHBlciBidXMuICovDQo+ID4gKyAgICAg
ICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZzLT5pMmMuYnVzc2VzW2ldKSwg
MCwgaXJxKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICAgLyogVW5pbXBsZW1lbnRlZCBw
ZXJpcGhlcmFscyAqLw0KPiA+ICAgICAgIGFzcGVlZF9tbWlvX21hcF91bmltcGxlbWVudGVkKHMt
Pm1lbW9yeSwNCj4gU1lTX0JVU19ERVZJQ0UoJnMtPnB3bSksDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImFzcGVlZC5wd20iLA0KDQo=

