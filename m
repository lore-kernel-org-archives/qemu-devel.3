Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81960D3E793
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZN4-0007tl-E2; Thu, 11 Dec 2025 00:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTZN2-0007tQ-2W; Thu, 11 Dec 2025 00:37:44 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vTZMz-0008TQ-Ie; Thu, 11 Dec 2025 00:37:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRuDxwfXlt+8Pdg14rYo7p4YFdf4564Ps87yBMHuvjJlVhHmn8/j0+3pBj5TkYc5ftmIuCRi5bNAaBaluiARVMvBqMx74Q5uzd3Odx3GuWeJ3j7owOn0B2BUh0B32F8zgBGFnACWUTWPEx95R/YL9PXrTUCaq3KIxh1MCWJo0iICmI94+aODmt39QkFpveoICRz4kdOXlKEIbREO8EwDq3i2LzlNcNA/KoQyIeEdJzRslxkBMJBbx5zdN6nVps/kTiQHD+mKl+v99nG1gsnRuiTKz/q2y0tfgpNhzldjLVNQxcIYk4InHo3qzV9YYflHZRVYRbC+HSrbettKIxO8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL8JGtKddFYCMBJlj9YLBuTKQdxQCQ8VuO2WXBX+eCU=;
 b=n38OEbw4IXPEmekZN+u7sNDHAP7g6/ypl6n+FRbrDZ2BgMsael2vUFrFQdcNjAHUGvM/4iOVESLrgxyuWN4bp5Kgv/e2aLrzupsi5xgtWqgLoCuMVFf9Vcz3ZLP/Cp1KIk3NbxtV9Z2t9zeDwB++q7ZkQb9cqqv46acBz273c7N++0KXQd2y5DX1dOxKgFV5oOrcpJ4rxI+Zpn3jvVtOkz9uiw/t6hyu/L4qo7guKzfK0EBsFqQbgOY4tARDYs/6JJ381QvsRagAjWQcO+xaDsywe950brrU7wkoGR5wDSvBeLeCw0JXa/X633hgJ2tEmf7/mVpZNJnlci6joD+pDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL8JGtKddFYCMBJlj9YLBuTKQdxQCQ8VuO2WXBX+eCU=;
 b=n4iW1Y1TYIuzgQBds5cDJP4t81u6s6I15rI1KVst/0Ifz3O6imUzCiVEtyjAhgaRKIbjGyZncIMatjJZWp3wqpv/HWQDKSrueXenS5xOmd14hWFA+vubzl/Oz6Af831/9zddshiYV0cQqBlscDVktnVSCY1Fp1C1BXmVSef181ghFhZUSus7qjILlCx/Zg9sm5XwHP7V6T5TnyJTemHktffjPoSYbXji9tH70+cAEooLBqSk5P2wXZWvuJbYbabwC0MAj7eqMEMxiHMKCdJndDSoKPWBGJu5Mmv2N8gSThap3yJBo74JZXYGCqcn4Zu8LNegcvClX0vAwCN6uNL8qQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYSPR06MB6922.apcprd06.prod.outlook.com (2603:1096:400:46e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 05:37:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:37:33 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Yubin Zou <yubinz@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nabih Estefan <nabihestefan@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v3 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Topic: [PATCH v3 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
Thread-Index: AQHcaiza/xPX6QKS7kWW6ASL1d3ETbUb6G/g
Date: Thu, 11 Dec 2025 05:37:33 +0000
Message-ID: <SI6PR06MB7631437325636B0BD07D3010F7A1A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
In-Reply-To: <20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYSPR06MB6922:EE_
x-ms-office365-filtering-correlation-id: 9b5e0134-7efb-4599-650c-08de38776214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YXZYcGZkdEY1MHdjU2lBWG1hbmFpcjgydTNyTXQza2FoRnh4aCtBQWM1bXlT?=
 =?utf-8?B?MVppMTYrdjBZdVI4aW5MclI3VUhlNnBFdE5YbFZ6bTc2Vk1NdkxHN1dmZSs1?=
 =?utf-8?B?aTRHZ3VHYWdIc21oUTR3VEV1VHkzVFJHdWk4VTBRRTU5TVBRakM0TUh0Vksw?=
 =?utf-8?B?T2hGdWRvNEdFbnRxbWIybDQ1c3d4WUJ3R08rR04xVXFqNWdYMi85TjRtQWgv?=
 =?utf-8?B?clBlbWlNbjZFbXpsbkxERHVlZVVyeEN0bGw0cEcrMnJ0dEVmbUtybStMMW1U?=
 =?utf-8?B?Tm0wVTEvR2FydVRMLzF0VmpWQXc3T3I3U3kwRFZnZ3RBeWpxWFZuRXZTTXh1?=
 =?utf-8?B?ZlNhY1lwdzBHTndzckI2YmxlNmVXaWdTTU1DZzJ5eTlaRGI0bUwxajVNWjM5?=
 =?utf-8?B?NDVZR1NZQnprZjhPS25EVHZCdXgrdm1pUzI3YXNFK3BPSXY1QmtVVTFhbDN2?=
 =?utf-8?B?VmpjZ3VxdFp6Z1dVa21mZTA2YjFZQ011MU5qQTJTZmtWQjhUV0Iza0FwbTBy?=
 =?utf-8?B?WFVIVktEVEY1UjlZU2NmZEc3QUhENERGSzdaT3FsbHIreTJ4NCt0OGdnZjhu?=
 =?utf-8?B?azdUREVlZFJtbzVvYzA3cmpXVUhzbXVCV0xMZnRrS3BvdnZGSUlkY1Q2TmR5?=
 =?utf-8?B?b082VXp5RXBwNzhsaXpQdnpZYnlUbVlFT2E1eDROYzEvUWZ4TXlGK0tFanlX?=
 =?utf-8?B?bFloM2xLU1kvbC95U3hac0VzNnphRGJ4R0tnSk9qUVZGdDdmaVVCU05RUEtR?=
 =?utf-8?B?TnZTcnR1Ym9ad1dGQWdXeFEzRnppNDVuZnZNKzY0ZktSbE5JVHo2S1BXc3k1?=
 =?utf-8?B?bnpWRzZOdUJ3NjhWa0xYQ0lmT1Z0UHE5c1l5U0xxdzRFczdBWDVHRnVjWjdK?=
 =?utf-8?B?QmZkSUZHc0VWZG91bkYzamd1Sy9OMUJxMjRqOXgvM094T1dXT2NuYk9CQXpQ?=
 =?utf-8?B?dEJydnZkcHRpTS9iTG84eFRwS3h4YUxtdWM1Ry83WDZrWUlHOE1ENVNaRFJR?=
 =?utf-8?B?Q1B2ajM0ZStqRURxQkg4TTR6ODQ5a0NkTUNzVThsM1dmUDBpQUo0em5zZjF3?=
 =?utf-8?B?YWxJbytQVStxZnpqOEZuQmRpT0dERXZaV3BrMWo1N1gwMWpTcU4rYmU2enZz?=
 =?utf-8?B?cDk1VVVqOFJTanVlN21TWWN4YmRIMkNMYkJYVVYyOG9DUjdSRkY4ajc1a0hG?=
 =?utf-8?B?YkxFeWNnMFVqclBnNVdVZVMzV0RTcnBIL1B0WUc2MFVOT1MxU3RKcVRJckph?=
 =?utf-8?B?R1RWZXhlL2doL1BqRzFqRE5CZ0FZSis4RTBuM3AvSENTVUhPNWwrOXh2SjlE?=
 =?utf-8?B?WDR6c2pxaVdZYlNFTGJvM1ZUd2g4Z1U2aENvRjl0NU5tbk9FL3IxSVpBcE9r?=
 =?utf-8?B?YnNmL21Yc0p2R0VtQWxMUzRGSUxZWG9GZ1d2bUNvaUZhRWpINlYvTWg2VWVw?=
 =?utf-8?B?L0RiTXdJMDZwS1lINnRVRE1VRE5BM3BEazducCtRUjZtZVRVOFk3Um1hbDdl?=
 =?utf-8?B?bms5cEhCOG9yNElVcXVmZ2pkYnErKy9LV0FyM2FQclZLV05BWnJPM2RFYU9Y?=
 =?utf-8?B?WU9BRDNGeWQvWUNyOUR4QVd5dWUwOGdhcDFJNEw3dEQ0a21Rd1k2cnBVQ2V0?=
 =?utf-8?B?bmh1VnhMQWpUS1lLYWdoNEFlUFllQmcxaU9WRWVCM0Z5c2JoQW9IZEJjZGJ0?=
 =?utf-8?B?RHpCWDl5Zlg1M3JsYVJDa1JQMUcvQWNSRGp0MGpXZVBVYVRHWXEwMkdQUFgy?=
 =?utf-8?B?WE5ld000aFFKd2ZLUS8raVQyQWJVT2ZtakNMTER1ZGlUR2VyT1Q2SVJ1RkpZ?=
 =?utf-8?B?ZUJENFhzNFRrUzVmSWRISHAvY0dBNGtyWERNSzNRQmFUektYZTY0U1NPZXkz?=
 =?utf-8?B?eHNJdk4rMjFwNExFUkpFNWRLZEdMTS9mUGpVcXBmZUJ1Rm1zYmxoWDd5amtF?=
 =?utf-8?B?TzczdzlyR25PSVJFNDdKM1d5NEVJMDc4RmJ5dUlSYlVtOG1uazdLY24rUUJ4?=
 =?utf-8?B?QmpRampvZnRHejdFK2dFdWNRYnM1VWIvbkdIaHRONmhKQndzRG11UGhJbi83?=
 =?utf-8?B?R1d3Zk5qYjlGcDRQL3AwMCs5UlR5VmR5ZEFNQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajUzVUI1UGJ6MjEzdFVEMGdxcU9QL1oxOUZWNGJkd2M2V01Ka3c3Y3ZwT3E3?=
 =?utf-8?B?bWJHKzlTaWRPRmJlcDl5ejJ1RWkrQkNIaGR0azlqUFA5RG9UTnVvZjUyNzFx?=
 =?utf-8?B?cEJoS2dsWnFCMEdCM3Zvem5qY3ZUKzdvN25kVHU4OFVPM1lodkZxenI5S3dO?=
 =?utf-8?B?bVovbkVpOHd3eFBmbkFMV3RTSGdJNmJ4bW96aytmOG9qYzh0Sy9IUzEzUUQw?=
 =?utf-8?B?d2VVeFBJRFlnS3k1VHlwYnlmYk1PR2I4QnRWbzl6cWhSTUtRd1RxTEI2ZW9r?=
 =?utf-8?B?Ty9mR20yaStVUmQ4c3dCVkV5VVMzQjVVbW83VXduaTBaN1lBbU1NUURYQnlq?=
 =?utf-8?B?MkJ2T3E5cDBJQ2ZNLzlUWXlMOVU0ZUFqSFlJVVVtdGRlczMrTzNGeWNNb3lD?=
 =?utf-8?B?bVg3TWM4aDRSNC83eU5aR2xaMDhENjNUMzB6LzBiTXJ4MU5SZDZaME9zNjFk?=
 =?utf-8?B?SUpwSkVhV2RsaWZ1RzA5WnJaTU56aEtyZ0Jjb0c4eC8wUGd4VWJnZk80ZTdQ?=
 =?utf-8?B?UTBXQkM0TGEzUHRXR0h1bEFJMzhWUXU1dzhMY1huNno3MW0vcXFjRDB0TmpP?=
 =?utf-8?B?eHJ3c2l2bjhueEo3bnR4c052NlRIcmNia0RJNzhQRUJBZjZwRlVodHhnbEtX?=
 =?utf-8?B?ZGY3d25kbHRrUXNtRW40SXZOcUhxbWlHWjI2dm5GUGRuRzh2dlpURTZJS204?=
 =?utf-8?B?L1Z0MDdFTHpCa1Znald6U3V6Vk00aGxTWjB6OGNuTitoVFFlTnFjZnc3dVEz?=
 =?utf-8?B?VHBaam1nQm9wWlVkWW5VYjZ4K08yN2VyZHFpWjlUSG11Y2ZxNENrWlNHY1dm?=
 =?utf-8?B?Um43WmhRbzdjRi82Z29lVTQ4UVMyNHRhSzdJSEo1Q3hOVHNqYlB6ekFNbjBQ?=
 =?utf-8?B?NXdBMDRSaTdwYUhBWlI1R1RsNVU0Z0dMOXViV29YbGNNQ0YxWlp6TEZsblQ5?=
 =?utf-8?B?aG15L3Fha3JuVCszTjl5MW9xVTVIaEs5eGRmYXAzc2pJWEQrRlNCK1BFZUNJ?=
 =?utf-8?B?QjUrVHI1eklCMnptT0FWMERZaVhOMDI1MWxWQzY4T1JsUjQ3L1ZoMEdpaEJI?=
 =?utf-8?B?R3paUVNjS2NOVU0rQ2Z6YnFZV1hBaWhZOHMzMk95VWlwcWtLYWpSdnF6NmFo?=
 =?utf-8?B?b3dUR2ZuVUNZNSt1RzR5bGlXVTVSdHJ0dzFFc1BuZmVRamxURVd1R1FuYnhV?=
 =?utf-8?B?Ni93Y0NOcFhlK3JPS05XWmlhUXBxdW1YM1FxemcxZXpvRjZaRkRleWdSNEdv?=
 =?utf-8?B?bEJCTGVHc2lzSGRZS2VTRGxETkJHbGllQWhodkJOdW9aZm4yRjhpQTB4YWU0?=
 =?utf-8?B?YjZqMUhLQnB3VTRYODAwRklpY3FFWWZjd3JkUUlVRVNTK2JTNnJZSW1nTmJo?=
 =?utf-8?B?MTNWSW4xckNUMlltNm41Q1JlWHJIMHZuVUV2cHZYb0NBRXExQTZxOU5xVFVS?=
 =?utf-8?B?L3R4dkFSSnM3c2RSeUNzc0o1b3BqbjN1ayt6elBHOU9MdkZGcHF3d2R3c2VS?=
 =?utf-8?B?QXozV25hYnBjeEpqRzB5M3dGMXcwTHZpZTBmSWtiRVZ4M2pEdFZLakxkWFRh?=
 =?utf-8?B?blBBMjZ4L29IaW5sUDMzR2o1endYZkgxQlkycjNEV0FxaWJjMURSbUFxdFdk?=
 =?utf-8?B?c2VUaFRLSmdHTm5HTCtsZ014cXdidFNiM3RMYWhjdy9mZi9HQ0RIbHJqN203?=
 =?utf-8?B?SkhnRTJhczBkUWMzaGZTeEhwY0c0dlVsdlFEbmVIVFFNSGJUSnZiU1pvTTNK?=
 =?utf-8?B?cTY5Nnc3ZXBXcHFLWlhwK0l3cnBObGJiR1V5bkUyNlZ0Y2dyei93bllEclIx?=
 =?utf-8?B?NlJuZzE2MFJMajQwVE9QV0xMbmhKREErdHNWdnhjSUNRSEZVMnJUVFIwaFdB?=
 =?utf-8?B?ZExpa25WYTFuM1BzMDgzR1hjQ29jYXpRbDY1MldxZW9tZzVreUlZVUZ0Nzd6?=
 =?utf-8?B?aTFTNmcxYU9hTWk5QzM3OUt4ekwwTEE5d1lkcVRHc3BxcWhDTWYwSkU2OWV6?=
 =?utf-8?B?WFYxZkhJQmIvM2NXbXg0aTFuZGdNMkJwQ3RGdS9KWUVzVmxCTENwdG5hYlk1?=
 =?utf-8?B?Mm5SZ2pnTUQvRkNDVWpXa0QwRU8yd240N3ZTNlZVZDgzMnhrVmxZQzNFNEg0?=
 =?utf-8?Q?v0w/1ynj8vFAs7W4Av2p6o7au?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5e0134-7efb-4599-650c-08de38776214
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 05:37:33.0824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsji4dqr5ZYJNegUQWhsNsp8KBGthX0TA4+j53KKcVDC/FhlEKCOmNC1MlA/3ZhBYDz9CMVRkDcrd13CP/NoeANXphNyzP3tCaqWYzyG+hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6922
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgWXViaW4sDQoNCkluIG15IGxvY2FsIHRlc3RpbmcsIHlvdXIgY29kZSBjaGFuZ2VzIHdvcmsg
d2VsbC4NClBsZWFzZSBhbHNvIHJldmlldyBteSBjb21tZW50cyBpbiB0aGUgb3RoZXIgZW1haWxz
Lg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgaGVscCBpbiBhZGRpbmcgdGhlIFNHUElPIG1vZHVsZS4N
Cg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFl1YmluIFpvdSA8eXViaW56QGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAxMSwgMjAyNSA3OjI5IEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBQZXRlciBNYXlkZWxsDQo+IDxw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRl
Y2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47DQo+IEZhYmlhbm8g
Um9zYXMgPGZhcm9zYXNAc3VzZS5kZT47IExhdXJlbnQgVml2aWVyIDxsdml2aWVyQHJlZGhhdC5j
b20+Ow0KPiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgS2FuZSBDaGVuDQo+
IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5A
Z29vZ2xlLmNvbT47DQo+IHFlbXUtYXJtQG5vbmdudS5vcmc7IFl1YmluIFpvdSA8eXViaW56QGdv
b2dsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAwLzZdIGh3L2dwaW8vYXNwZWVkX3NncGlv
OiBBZGQgQXNwZWVkIFNlcmlhbCBHUElPDQo+IChTR1BJTykgY29udHJvbGxlciBtb2RlbA0KPiAN
Cj4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyBhIG1vZGVsIGZvciB0aGUgQXNwZWVkIFNlcmlhbCBH
UElPIChTR1BJTykgY29udHJvbGxlciwNCj4gY29tbW9ubHkgZm91bmQgb24gQXNwZWVkIFNvQ3Mg
c3VjaCBhcyB0aGUgQVNUMjcwMC4gVGhlIFNHUElPIHBlcmlwaGVyYWwNCj4gcHJvdmlkZXMgYSBs
YXJnZSBudW1iZXIgb2YgR1BJTyBwaW5zIHRoYXQgY2FuIGJlIGNvbnRyb2xsZWQgYW5kIG1vbml0
b3JlZA0KPiBzZXJpYWxseS4NCj4gDQo+IEltcHJvdmVtZW50IHRvIFFFTVU6DQo+IFRoZXNlIHBh
dGNoZXMgZW5oYW5jZSBRRU1VJ3MgaGFyZHdhcmUgZW11bGF0aW9uIGNhcGFiaWxpdGllcyBmb3Ig
cGxhdGZvcm1zDQo+IHVzaW5nIEFzcGVlZCBTb0NzLCBwYXJ0aWN1bGFybHkgZm9yIEJNQyBzaW11
bGF0aW9ucy4gQnkgbW9kZWxpbmcgdGhlIFNHUElPDQo+IGNvbnRyb2xsZXIsIFFFTVUgY2FuIG1v
cmUgYWNjdXJhdGVseSByZXByZXNlbnQgdGhlIGhhcmR3YXJlLCBhbGxvd2luZyBmb3INCj4gYmV0
dGVyIGRldmVsb3BtZW50IGFuZCB0ZXN0aW5nIG9mIGZpcm13YXJlIGFuZCBzb2Z0d2FyZSB0aGF0
IHJlbGllcyBvbiB0aGVzZQ0KPiBHUElPcyBmb3IgdmFyaW91cyBmdW5jdGlvbnMgbGlrZSBzZW5z
b3IgbW9uaXRvcmluZywgcHJlc2VuY2UgZGV0ZWN0LCBhbmQNCj4gc3lzdGVtIGNvbnRyb2wgc2ln
bmFscy4NCj4gDQo+IEltcGFjdCAoQmVmb3JlL0FmdGVyKToNCj4gDQo+IEJlZm9yZToNCj4gUUVN
VSBsYWNrZWQgYSBtb2RlbCBmb3IgdGhlIEFzcGVlZCBTR1BJTyBjb250cm9sbGVyLiBBbnkgZ3Vl
c3Qgc29mdHdhcmUNCj4gYXR0ZW1wdGluZyB0byBpbnRlcmFjdCB3aXRoIHRoZSBTR1BJTyByZWdp
c3RlciBzcGFjZSB3b3VsZCBmaW5kIG5vIGRldmljZS4NCj4gRmlybXdhcmUgZmVhdHVyZXMgZGVw
ZW5kaW5nIG9uIFNHUElPIHBpbiBzdGF0ZXMgb3IgaW50ZXJydXB0cyBjb3VsZCBub3QgYmUNCj4g
dGVzdGVkIGluIFFFTVUuDQo+IA0KPiBBZnRlcjoNCj4gUUVNVSBlbXVsYXRlcyB0aGUgQXNwZWVk
IFNHUElPIGNvbnRyb2xsZXIgb24gc3VwcG9ydGVkIG1hY2hpbmVzIChlLmcuLA0KPiBhc3QyNzAw
LWV2YikuDQo+IC0gR3Vlc3QgZmlybXdhcmUgY2FuIGNvbmZpZ3VyZSBTR1BJTyBwaW5zLCBzZXQg
b3V0cHV0IHZhbHVlcywgYW5kIHJlYWQgaW5wdXQNCj4gICB2YWx1ZXMgdGhyb3VnaCB0aGUgbWVt
b3J5LW1hcHBlZCByZWdpc3RlcnMuDQo+IC0gRXh0ZXJuYWwgZW50aXRpZXMgKGxpa2UgdGVzdCBz
Y3JpcHRzIG9yIG90aGVyIFFFTVUgY29tcG9uZW50cykgY2FuIGludGVyYWN0DQo+ICAgd2l0aCB0
aGUgcGlucyB2aWEgUU9NIHByb3BlcnRpZXMgKGUuZy4sIHRvIHNpbXVsYXRlIGV4dGVybmFsIHNp
Z25hbCBjaGFuZ2VzKS4NCj4gICBQYXRoIGV4YW1wbGU6IC9tYWNoaW5lL3NvYy9zZ3Bpb1swXS9z
Z3BpbzANCj4gLSBUaGUgbW9kZWwgZ2VuZXJhdGVzIGludGVycnVwdHMgYmFzZWQgb24gaW5wdXQg
cGluIHRyYW5zaXRpb25zLCBhY2NvcmRpbmcgdG8NCj4gICB0aGUgY29uZmlndXJlZCBtb2RlIChs
ZXZlbC9lZGdlKSwgZW5hYmxpbmcgdGVzdGluZyBvZiBpbnRlcnJ1cHQgaGFuZGxlcnMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBpbiB2MzoNCj4gLSBGaXggY29tbWl0IG1lc3NhZ2UgdHlwbyBhbmQgYWRkcmVzcyBz
ZXZlcmFsIHJldmlldyBmZWVkYmFjayBpbg0KPiAgIGNvbW1pdCAyLzYuDQo+IC0gU3dpdGNoIHRv
IHVzZSBnX2F1dG9mcmVlIGFuZCBkcm9wIGdfZnJlZS4NCj4gLSBVc2UgIiUwM2QiIGluc3RlYWQg
b2YgIiVkIi4NCj4gLSBMaW5rIHRvIHYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjUxMjA5LWFzcGVlZC1zZ3Bpby12Mi0wLTk3NmU1ZjU3OTANCj4gYzJAZ29vZ2xl
LmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gU3BsaXQgdGhlIHYxIGludG8gc21hbGxlciBj
b21taXRzIGFuZCByZW9yZGVyIGl0IGZvciBiZXR0ZXIgcmV2aWV3Og0KPiAtIExpbmsgdG8gdjE6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTExMDYtYXNwZWVkLXNn
cGlvLXYxLTAtYjAyNjA5MzcxDQo+IDZmYUBnb29nbGUuY29tDQo+IA0KPiAtLS0NCj4gWXViaW4g
Wm91ICg2KToNCj4gICAgICAgaHcvZ3Bpby9hc3BlZWRfc2dwaW86IEFkZCBiYXNpYyBkZXZpY2Ug
bW9kZWwgZm9yIEFzcGVlZCBTR1BJTw0KPiAgICAgICBody9ncGlvL2FzcGVlZF9zZ3BpbzogQWRk
IFFPTSBwcm9wZXJ0eSBhY2Nlc3NvcnMgZm9yIFNHUElPIHBpbnMNCj4gICAgICAgaHcvZ3Bpby9h
c3BlZWRfc2dwaW86IEltcGxlbWVudCBTR1BJTyBpbnRlcnJ1cHQgaGFuZGxpbmcNCj4gICAgICAg
aHcvYXJtL2FzcGVlZF9zb2M6IFVwZGF0ZSBBc3BlZWQgU29DIHRvIHN1cHBvcnQgdHdvIFNHUElP
DQo+IGNvbnRyb2xsZXJzDQo+ICAgICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogV2lyZSBTR1BJ
TyBjb250cm9sbGVyIHRvIEFTVDI3MDAgU29DDQo+ICAgICAgIHRlc3QvcXRlc3Q6IEFkZCBVbml0
IHRlc3QgZm9yIEFzcGVlZCBTR1BJTw0KPiANCj4gIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aCAgICAgIHwgICA4ICstDQo+ICBpbmNsdWRlL2h3L2dwaW8vYXNwZWVkX3NncGlvLmggICB8ICA2
OCArKysrKysrKw0KPiAgaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMgICAgICAgICAgfCAgIDYgKy0N
Cj4gIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgIHwgIDI2ICsrKw0KPiAgaHcvZ3Bp
by9hc3BlZWRfc2dwaW8uYyAgICAgICAgICAgfCAzNDgNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICB0ZXN0cy9xdGVzdC9hc3QyNzAwLXNncGlvLXRlc3QuYyB8
IDE1MiArKysrKysrKysrKysrKysrKw0KPiAgaHcvZ3Bpby9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiAgdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgICAgICAgICAgfCAgIDEgKw0K
PiAgOCBmaWxlcyBjaGFuZ2VkLCA2MDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
LS0tDQo+IGJhc2UtY29tbWl0OiA5MTdhYzA3ZjlhZWY1NzliOTUzOGE4MWQ0NWY0NTg1MGFiYTQy
OTA2DQo+IGNoYW5nZS1pZDogMjAyNTExMDUtYXNwZWVkLXNncGlvLTFkNDlkZTZjZWE2Ng0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBZdWJpbiBab3UgPHl1YmluekBnb29nbGUuY29tPg0K
DQo=

