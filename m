Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE9CF94CD8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 06:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFRXx-0001Qn-R9; Wed, 22 Apr 2026 02:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFRXf-0001Nm-PW; Wed, 22 Apr 2026 02:58:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFRXd-0001xV-6t; Wed, 22 Apr 2026 02:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbfE+VCxUHsJdEU24/buEQ/RZn9Jq46yi5jTncWLYNcjwl4Skr3L5+UPrSlNS1oEtJxqfcvxKKL3U2Ik0Y9TIGhojFK6JdkX6BAauhABqvNQRpeFX7KhvAsDlBD+VkvTUifvO3y89n04YKeKqVHBiqsnAS6e4vMlocJwO1mXkl2ZM8O4LXubmbWLjcFJU8d3zJPg9Ny1JD6m5U5uUeHOwBw++H0p/uoQOt+lLc7rtzXbwXFr/Cc11YIv0OUfahUbnWLF2uRgT0i/AhowZBm6VJWjMO9To6xTF9XOefNui4uVmPVJf/7uhStcnfWaXDxUh0ZBXtAG/IKoNwO+rC9x/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj3xfCAJPRbVBZNufv2loGtb1eu11qWRBdbJUdTEKHA=;
 b=rSN1P5/oNzmBxyJUaHgjdJCUT8LWOd7Z39qNZ5XhH6lzugF++GichDp46P4t+PQoy1F3bhmTtF8bZNbNRoPdbkJPbJjTScHLd0l2SqKytb3ne9Z5LUIxa/Bc1aSpvtmsUAmcxIK+up+Aac3McHNbmcpLNLERpNHkk1Xg1OcOxyVMnccuxeBxXufdg4TpzTUkwLwI3pIGddJDWoIHiKhXs6rFYyfhvFd8ymi4YKRzwTeQIUEV77/OC33Yhk+52CwFOorPVkcBvepTeLmpzIuiDsBJ6Qq0nBYG5EkVK3u3aGEB/QcMxjXKe6RNSqiIj8msxbgu+xgvsCR86Ez0NEaptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj3xfCAJPRbVBZNufv2loGtb1eu11qWRBdbJUdTEKHA=;
 b=A2sZkPNsOqRrBUhN8gbZD7bl+epY8E4uuiImAowawx1jY7xnM+VeZkR7zzd4hcZT/QmFSPqxved8PFLB3awSiiA8ALR4y7SKLhFyJT0PCdX8Ixs9Po/7k4PWMCtPxtkHtL19vL377lmnCfnqoayHmoZQc2AlFTSweryLfv0WmgI93vDEWlUfrZJ9QvF81aAvMVlBSnVDHKBFAfzG0KbE/tdkpiDMdw5exn1M5imbjfpJ4LGIVGprH3Tee8vYfTwAfIXCsr3oFxK6MZUvay9StHgU6Bqa9/5OJphRs+SxKztD0P1RXkJ/mYevD+x32XVkdn9ZPB5S3/zPcCRNPqG5tw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB6853.apcprd06.prod.outlook.com (2603:1096:405:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Wed, 22 Apr
 2026 06:58:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 06:58:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHczUNUCGCAr2wNUUqlxwuOt/36CrXi0Q2AgAAGdwCABJoRoIAAHPGAgAMgrZA=
Date: Wed, 22 Apr 2026 06:58:23 +0000
Message-ID: <TYPPR06MB8206AD232DDC788EF2F1D707FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
 <04a8d8d9-f605-4bd3-8468-0e2840ae8311@kaod.org>
 <20ee6c39-d0ff-4e07-95e6-5aeb86dc0916@linaro.org>
 <TYPPR06MB8206A19AD70BA0FAD7F68B15FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <8ae66243-d55d-4d7b-bcab-dbdcd680aaf7@kaod.org>
In-Reply-To: <8ae66243-d55d-4d7b-bcab-dbdcd680aaf7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB6853:EE_
x-ms-office365-filtering-correlation-id: bd68eda8-c93f-4d21-2b13-08dea03c8bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: gg224SVlXJ7g7psA6htSk3B+QYIcekVJmTkjPWkQsNqUwBj/pKM+4I4e8RQQ4eudENBn1ALA3LBkoLwZDgv59qgIZCQavU4s5wwVJg/9uoKTqdGUD+wvMKZVDqhF7I0L446BnwXoOcToNBgOsTSYDkxbqaRa3QQabdIZ+FGUX6ATzm8QlCzQ5BfzJStiQEMZ3Sr4qjbxh80S3lVpi38p0emvvAkuBh0bmzIdo0T7PepTVG3k+TpOxSwWljWQSqTKDMU9vN0RwjtGSb5dqLIOV1iBZHoD2Sj9xfLnAiu/oPUdICMFv4n1Vd3l4OKKYQVyVsvmstG5sV+YYRsxgGJWLRpBXV9BDyhAz1kId6++OkEkPsGljMgu5157yU0ujGBPnviYJ/2qFhGaEQ0Fm7qx0isJoR+wF90izAI+2JTCPMGsKB73hAJR1o3g72rcRz4efcfjb9jG8xuBV2wvNtjy53LmBWPlMiHenCOP3qtDGyKIp28fSzK6+LFwKTglPE2JRmXb614GV9EkIEG9H1DcbVTRcEcQUiXh6E/AycznV+xPCdjMSLVEF4toHPgKdiPQ4eOXvzixhs6GeEegzNpB7fVIK6tgWxb+/SSz1uA0Z8hs3AGg+rjUPktmRnhiFMRyCYebDkE8B0oSS3lBe/2sKx1mh+DkwK7QH+Wh/3ocPVxyrw0kJ+I0xIiD8UCO1WtSh5fAZbBvemm5teaDzVraTblX6JO5Dcx+YO3uckWkQgeGj0k+lHJh84AhET1rWul0XOMaw6QvoIsB/k/neYqACL8adY1T3hyvOMvtLiCuN9sR4z8+0wVspgDTDYuejF/K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJza3loQmh5MEpLWkZvQjBDMFZ6Vk9SMENmdGZYMTZ5RXRnL29XY0g4bkk1?=
 =?utf-8?B?V0V3eTRPNjlNdWRTYW5tdmNVS0tCcXEvVUY3NmtTamRaUGxvN1ZLWEN6SHQr?=
 =?utf-8?B?eHRtbUxkSnJLWkV0b04vbGMvcWlJcFJ1bWNNUFlkb1BsZ0hjOTlEUUlNSVVG?=
 =?utf-8?B?QmNleGJkMDliVGlvWlNtMnVqbmRxSDBDN3BiTkxSZlNrTUJ6a3Bhc1pheStV?=
 =?utf-8?B?WXZkMUxNc3YvTldrbm9JUWFqeW93emxhUzZqbjUyTWpsNW85N0lqR3YxODJB?=
 =?utf-8?B?UnJFVlRkT2RwTHhLQk55SG56ZWY2anc5TVlYYnZUa3pVT0c4aW5IaVZrL01X?=
 =?utf-8?B?YytURTBJWkFLVytBSy9Mb1J2bFpJRTMrdUZueVJMdjBNMVIvM3ZRZFpBbDVT?=
 =?utf-8?B?WmZ0Wk1jVzdDL2IybzFKMmp4c0pDcWZlZmozZ1J3Ymlvdld6UlNDa1Z1UGRB?=
 =?utf-8?B?bEZTWHBYWk54aGQ5cCtaNVdqbTdyaE9rSURyNWI1TmNLZ0c4ZjJKRVVsTlZF?=
 =?utf-8?B?amVkeXlKdG5pY0hTUDZWTmdmd0xmLzJmYnl2aVFFWGw3K1dhTlVaQTlIMHhs?=
 =?utf-8?B?UHI0NXlPSnRsUEZKU2V2RG5hekJubXBJa0NXMndNZnJKbHAzWnd2Zkx4QUxV?=
 =?utf-8?B?YUJjNHRsVVM2MUZKZlRzU3hYdVdlVGpsTjRBcytnR1hIY1JKNjBUS0ZRL3RY?=
 =?utf-8?B?N2tseDd4R0dtZlI5TUdaQnVlTm1VVElWNDZiRm9uWmJRSnJHRWtBY0pKU0d4?=
 =?utf-8?B?ZkI3YXBRZldvcDhZUS9lM0RSaDZFUURPNXQrY0F6Uko2SW93djNCWUFCU2ZQ?=
 =?utf-8?B?cG9zVEI5eDJxS2lvYU40UzNnOXpaMGJWeWI3ZnVrcitSYUV2clJOTmpZcENl?=
 =?utf-8?B?RGhNWnBLZWxRVE0rVkxCUlc0eFM2Ny9ESlM2QTV3RDFnMFdManNGSGtBVUNN?=
 =?utf-8?B?c0xHVEFCQk1hRlpNNEM3bUF2WDdoMWxWclZtME54SW1qZ3ZJeTl0MWpjTHpO?=
 =?utf-8?B?d1VSQnhaNkRWRzVnN3dvUmszbXhmbzJFZEFzL3R0WVNDWThVK08zaXRPc21o?=
 =?utf-8?B?K2I0T2pHOUZzY3B0NEhNZThkaWpQTmVqRW9JZVZxTGxRZEYvekFlV3lRQzc3?=
 =?utf-8?B?VWkzRlcwTlZsVDZBR1NmRitVNGp6enZOOFpGWWtBRFcrdk8yZXRIaVMwV3N6?=
 =?utf-8?B?djBmNlBDd085Qlp2UFBPOXk4ZGZZNUpBMEJ4ajlTdzZXZGFtaWxaS3hBUWh1?=
 =?utf-8?B?NktFZHAzK3RGRTEycFpla25vWVlWRDNqTkhya3dpc1VWSmNwQ3V6L2FLSWZ2?=
 =?utf-8?B?Z2xqajRJNGNtUDlLaGRLY3REa09FWEQ5UjB1eGdkbnFjQzNWYTVOM3hSdXdz?=
 =?utf-8?B?ZmU4TmxrbjNTSytBVkJCYm10dG9xWjNKa2t6T3ZLSUh3V2ZzMGRBZlE3ekV0?=
 =?utf-8?B?NlRlMXhYWXIvbk9qZXpLZjZNY0FHdGs1aXpwSDNLSHZFTTBiRXh4dnpHR3Mr?=
 =?utf-8?B?WHpDM3JLanBjSWFTUHBJUU4yK3VmQlVBdUszVnlJNTBjOW1lZEQzZHlMK2pO?=
 =?utf-8?B?eERxM2xYREl1Kzdyb2czMUhKNWo2b0dYVHdsdEJwblVVcFpVRkZjOVlWRGhW?=
 =?utf-8?B?RVZnU1ZzVkVrN0RKOTFTZ1orejVDVDVMNXRSM21IamVyMnlrdWFMWFdZTEpQ?=
 =?utf-8?B?dGg2SVdzZG04Y05XelJpSjAxM1huSXRGZU8xVjF4K3V3RTdDc2dmQXAzN1ZZ?=
 =?utf-8?B?RkwySUtyQ1pOcmFOdE1GT2VlK0l6cUMreXFjK2tSMTBEVGV4eWI3aHVqckNm?=
 =?utf-8?B?Nm5ia1ZEdW1icXhjU3NpK1A5NXBZU2pJTVM5RS9qNVRpZ0J5SlJRS3ViVHVF?=
 =?utf-8?B?UXRZQ3htSWd6L1VDQlIwQ25BMHlvWWdJQnZnazNPOFpUTnBzSFY5N2VHUlAv?=
 =?utf-8?B?azQ0ZmtRM2FSdzRaQXU4anpjVmxRWmZYSmJkcTVZaHFCVEYyenBBYTdtRWUx?=
 =?utf-8?B?Y3F4NUFxYW5vb3dJN0xWcmswRVdOWkRQcVVOdFJKK2k3YWFEVHFCKzg3cGxJ?=
 =?utf-8?B?czZLV2RIYW5jNUIyMzRvTGkrY21nMndDbFBxL0hVNUlqTkFOY1ZyMDZibEkr?=
 =?utf-8?B?NnlsMHRjclBmOTFxNElxdHJFNkVvK3J2ZXlKcWI3alVGUFdTait4Q24rekZN?=
 =?utf-8?B?blBnRnVSZnZsU0ZVV1FBdEthdTVXblNaSDQ3ak1PdWFKbUhDY2JPb2p6YVg0?=
 =?utf-8?B?Nk5mem16MXZrbkExVVlUeVpublJyMmk4dzJ2L1FUYmtDRXN3OU5WYUR3ZEJF?=
 =?utf-8?B?UytZdVZZb0lnbjFKSCtIUmR6RzlZL2lHTUY0MllyNGZuUmlveCtzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PNYhT1d+b4Y7o0N7mAt5wYK2ORDt+THfLayrEciDtHKVuy3xwpDW63lvUdkxYXMw5ZS5keV6ZBGR8e7B23+gu20RG/f0alnXF6ae4xYDAB+MJnpJT1CGbL+2qO/CCyL087RZqzmR5IwKmv7VD1yA4Qtv58/s6Hf5/Y3o/ew31rM6GIDoGUZYmf1RQg2ywUXMYC3uAbUmhLLJTHLkCGsXd6vEev+9m99zRG34+/WuJ4xsv1rgtBWqCY5jiilDZKi8Peawfos5cTIRBWMBmhaEeTF+f1IqtwL+rTjzxPqEVAKVy989Cd+kmysb8E5ZrYDju6GGShIDnxoGuovhigA0VQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd68eda8-c93f-4d21-2b13-08dea03c8bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 06:58:23.4633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6cMACMSz3U4OR/lwICfPNUdrEYvO/E2GJ3NmsAqkLu88Ei2KvShJkHeZ5iSfdpo95awgJCmMRy1N4WRaC9W2sI989iLgGZZTPowic3Cs18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6853
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

SGkgQ8OpZHJpYywgDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxMy8xN10gaHcvdXNiL2hj
ZC1laGNpOiBBZGQgZGVzY3JpcHRvciBhZGRyZXNzIG9mZnNldA0KPiBwcm9wZXJ0eQ0KPiA+DQo+
ID4gSSB0cmllZCB0byBhZGRyZXNzIHRoaXMgYnkgaW50cm9kdWNpbmcgYSBuZXcgcHJvcGVydHk6
DQo+ID4gYXNwZWVkLWFzdDI3MDAtd29ya2Fyb3VuZC4NCj4gDQo+IFRoaXMgaXMgbm90IHNwZWNp
ZmljIHRvIEFTVDI3MDAuDQo+IA0KPiBJIHRoaW5rIGEgZm9yY2VkIGRlZmF1bHQgdmFsdWUgZm9y
IENUUkxEU1NFR01FTlQgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZS4NCj4gUGVyaGFwcyAiY3Ry
bGRzc2VnbWVudC1kZWZhdWx0IiwgYXMgYSB1aW50MzJfdCwgd2hpY2ggZGVmYXVsdHMgdG8gMHgw
IGFuZA0KPiB3aGVuIHRoZSBhc3QyNzAwIFNvQyBpcyByZWFsaXplZCwgc2V0IHRvIEJJVCgyKS4N
Cj4gDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIGFuZCByZXZpZXcuDQpXaWxsIGRvDQo+IA0K
PiA+DQo+ID4gKyAgICAgICAgaWYgKHMtPmFzcGVlZF9hc3QyNzAwX3dvcmthcm91bmQpIHsNCj4g
PiArICAgICAgICAgICAgdmFsIHw9IEJJVCgyKTsNCj4gPiArICAgICAgICB9DQo+IA0KPiBXaXRo
IHRoZSBwcm9wb3NhbCBhYm92ZSwgdGhpcyB3b3VsZCBiZSBjaGFuZ2VkIHRvIDoNCj4gDQo+IAl2
YWwgfD0gcy0+Y3RybGRzc2VnbWVudF9kZWZhdWx0Ow0KPiANCldpbGwgZG8NCj4gPiAgICAgICAg
ICAgYnJlYWs7DQo+ID4gICAgICAgY2FzZSBBU1lOQ0xJU1RBRERSOg0KPiA+ICAgICAgICAgICBp
ZiAoZWhjaV9hc3luY19lbmFibGVkKHMpKSB7IEBAIC0yNTgyLDYgKzI1ODUsOSBAQCB2b2lkDQo+
ID4gdXNiX2VoY2lfcmVhbGl6ZShFSENJU3RhdGUgKnMsIERldmljZVN0YXRlICpkZXYsIEVycm9y
ICoqZXJycCkNCj4gPiAgICAgICB9DQo+ID4gICAgICAgaWYgKHMtPmNhcHNfNjRiaXRfYWRkcikg
ew0KPiA+ICAgICAgICAgICBzLT5jYXBzWzB4MDhdIHw9IEJJVCgwKTsNCj4gPiArICAgICAgICBp
ZiAocy0+YXNwZWVkX2FzdDI3MDBfd29ya2Fyb3VuZCkgew0KPiA+ICsgICAgICAgICAgICBzLT5j
dHJsZHNzZWdtZW50IHw9IEJJVCgyKTsNCj4gDQo+IFNob3VsZG4ndCB0aGVzZSBhc3NpZ25tZW50
cyBiZSBpbiB0aGUgcmVzZXQgaGFuZGxlcnMgPw0KPiANCg0KWWVzLCB3aXRoIGFib3ZlIHNvbHV0
aW9uLCB3ZSBkbyBub3QgbmVlZCBpdCBpbiB0aGUgcmVzZXQgaGFuZGxlcnMuDQpXaWxsIHJlbW92
ZSBpdC4NCkFwcHJlY2lhdGUgeW91ciBraW5kbHkgc3VwcG9ydCBhbmQgaGVscC4NCg0KSmFtaW4N
Cj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+ICsgICAgICAgIH0NCj4gPiAgICAgICB9
DQoNCg==

