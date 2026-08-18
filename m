Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45BC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCx8-0002NY-P8; Tue, 18 Aug 2026 02:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwCx6-0002NH-Jr; Tue, 18 Aug 2026 02:05:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwCx3-0008NO-N1; Tue, 18 Aug 2026 02:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1+svMYLaIg54Y9yurWr+ZBGdXtRGL0AzFiVZmv7bFyzJ5SzA/9Vm49XPizoh74tptIvCeOXdVlwSxJ9GLtVFuvmesthnaPFpPoJtViT7AjUm5bOGJcgVqQqX/jFL19by5InWAtC917G4bua/8ydGLcu+UVJA7AvOBGiw//rRrEryqn7+1gogb3KEmBJiaV3BLgx0Sk+/Q1von3Ey04yhFGWM9sG3X/cPM5HbqwYSUCuZc/M36UXqK5uFBPVK4UOqLStzMFvDCWRIXxKSXASYVQnoS6plT6xFUahYK6/AjHZn/mVTQUhgt3XnJYpjGPFQPUz0qpk/vK5cQiNdRGZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf0Q7Q/deB+GYtnFe61MrTx88UvPL5DfOgCZDsyL5Ck=;
 b=szMq/HVMGy/3+pp5lMyI8yxtnC9nI2K+xV8vIab7VLTZ0H2CJygc4m/ycMC7Ho/FJhkUjTqC45JAk8vJTk4PGV2zp71eWjpfB1YtdsT/JWZbQIqXDB/c1AmJEOWeGRzNqW/TnLMOHJGD2GWob3gWfQGsDzGHaILpLIjwZ5mTtRmnYnKGO8ibt7tqXxyWdiyC29BOCIJVtzoJX18FFB+456pLgez/GIqZ46zFzQqSshJv37YZlsGb4/HQHnGaRwWdEdG8CaPsSv15Z4NNgEXk4puLKeK6zAcDfKeE+LMf05JIVEdt5vIxUkvvO8oIONcLwCkzur+p7xMa828MuRG+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf0Q7Q/deB+GYtnFe61MrTx88UvPL5DfOgCZDsyL5Ck=;
 b=rLyvD7Pqr9Rdcorm4QQ4u+WOqko7w9xrAPH3m8cHpDdyN0UPSI6kdcX+xK5vQwXxTE6yZiUzGSJXs/x1W5tEt2Vg7ThVxvNk1sN1JmiSgwIvEORsC4yOo0dk3Hx64NxQpJpzhdKgWy2h1S9SGesnW398KLVEEkWInFJMFI5HRuarKH/Czw8qSGohEv702b8c0VzCnyJBQviCNvrsLI1WHuWdVSGnR7rV5yjeGn+BGAyplT/9wcpYCk+AwA81Th4A9T2ttlA4SzzBhod0FKHWjABNCyZZ6cmuT73AoVYibTI+EEA4MnT0s08Q3TU3I8ZvfJrLyr9+ZIB3L/kpdWLlkw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5590.apcprd06.prod.outlook.com (2603:1096:101:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:05:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:05:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Joel Stanley
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
Thread-Topic: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
Thread-Index: AQHdLrMRat2TJUrCjkmjy6zhdQRJNrajUTvg
Date: Tue, 18 Aug 2026 06:05:21 +0000
Message-ID: <TYZPR06MB49807501A1E666F8F5FD1BC8FCA62@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
In-Reply-To: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5590:EE_
x-ms-office365-filtering-correlation-id: 99dba265-1b7b-412f-45a0-08defceeb023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: B4d3XhYv30PTyNV58EFfcnCarUI3dLoVK9eYcnOdBrv4OBKs+WRqcjQa9t8u8s20bcryeShesqDIJduo7jlg0Cu+kp6XL3ZIgemfk1PdujNghCA9ItmhmgltNMHzDvL4E/IaEqiF25V6zUXLZK/FuNwrevFPLx4xnUz/JFpxBHGkMkP7IzUEkJ+itiv81HPokXSlijffysyQHHM2k/FD4yT6dJPqO5iGvl2TV/6TP+ZI1mkDHBdRidhglCUuTT/9oJH66z4SdG4vJ+sbvFxBS7cZ97NJk+AuRAO1xI2ef6vA7GpuxVPfANVrQRlHYfbTa1vu1l3aMhrbD6A4hc2tYRN84r5QbVPZM1SHnQe1HhjlMR4jzroWBwN5PN7NDQ5hCGpgeyHlcOnKn8wDC/LF52uJi+YSUHX74UCZ+rhkQkn6Oju+301hHhp3u7FuitiyPx3Ipg1APAuCLjMWSUpRqeBlHkvkQDwwaTUgVuCHwmIHp4XxqGXnUuAPFYkrxIzx0q49ERPq1fVj0syvG8m/aBp+OjmdqM2JKKHg9YAtc1OgEWlcHt7r8vWlMlgcvM47z++naVUjKXPUNs7lYEqHytMjtPQSk/fms6jwYzhI8uts23LRzFwx6yZUa5dFER+xp8dB8KVfT6TV5uT3BxkCbNbs7szsjv1hQNlpYDI8g1h/uxx6lbI34enOsRMPHz1jXtKGBL3MM8sJB+QKocLnV40tyl5HJthxUqI0IhyW92Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWJvRUhzbFJZVDhpZjRTNFV4TE9oUUlVR20ydGtjTFNkejNQOFl2V0lkYmpo?=
 =?utf-8?B?OXdzNVNYU3preHBrMVMxTVRBTWtzZlhEb2JmaVFlejllMklBRmpDdjF1Vloy?=
 =?utf-8?B?WGhPSWNTd0w1cTZER1N4VmsvK2YrYnBGcEFYbFlmU1NWekxuQzZQeFNmRE03?=
 =?utf-8?B?OW84eWNZNytvMVVhKzJTYXJKRlZ4djErYnlQM0NLSlM2ZWpzR1VTRlFXODVr?=
 =?utf-8?B?R0dydmVvYktRbVVJRUlTK2c0TjR6UDRETEYwL3EwT0pLNmdZWkdNTXZOWHRi?=
 =?utf-8?B?Q29ZL2FoMHcrSzI4Ull3V0pIL25ZNmpqaHEzSC9meHEwaTFmSVJjZGp6NDJj?=
 =?utf-8?B?cU0xdU1VK0x0azFsK0lSZG9DS1NXaHNETHJzNHFaa2lUdDZycnNhSm01Qlo1?=
 =?utf-8?B?TGMvdHFzVHV5amI5Y3FFelV3VzRZbHhzeVlmVDhzYnlFSHpFYys5cWp4ZU5s?=
 =?utf-8?B?REhqVjdyaGZES1NVekpMNVZNN0lIckI2N091U1hNVjhsVVlUNTRzVGFuSkk3?=
 =?utf-8?B?aUpncFRPSUVrWldoVDU1WEFReVVDUU5NT3VLRGFFR1NHdWh1bEhVcHIvNjRN?=
 =?utf-8?B?bFZWMVBnUDdlSC9XLzdEYUxXUGNpb3pqdXFUMUdJR0pQSTU1WUxDelBST2Zi?=
 =?utf-8?B?NUtYQ2NVV3RwYnltSEREWkFwNVRTNkdwSGNzdm1Sb1N2bTcyZGxiU3E0NVhC?=
 =?utf-8?B?S0s0QW1Tc1ZwelR0cE5CS3l1bzgya3J0YzlYQWhOazNFVmZhZktmdE80aGs3?=
 =?utf-8?B?ekh3UzZuOFhQQXJySU5uOEplUlQ2eXRoWTVxN05KL0I0TkZuUlVkNUh4cWVQ?=
 =?utf-8?B?RmhmVWdCZnFxN2lLTGdjZjN2NW5zR1ltYjZZZllMNFRocmpZdEJVMEN6b29z?=
 =?utf-8?B?OThMRW55VlFhdTBVSTljdG8xeWEvTHI3aUlPZHVPcVBmc2VFMjYydUdyL3Ra?=
 =?utf-8?B?MEZhSlNYS2NuM1FLanVReHA3UXhHa0dkbmgwZFFGVXF4QzB6dGhlVnhWSnNK?=
 =?utf-8?B?UFYzS0c2OTQrUmRrZ1dBLzlNYm5nbWtKNzN4L05xSzBubHVYenhBSHhpMkJm?=
 =?utf-8?B?TzZNOEdXaE14bkREL214OVhKNnFGZmlJYlBmZUpFNjAxSlVidDlNeUQ1a0xN?=
 =?utf-8?B?YVJQWG5mMEphNFVPM0laS3F5alVvelpTck1GL0U0NWpFbW0rMUNSZVQ1SXlO?=
 =?utf-8?B?WDQ2TkFPNW15aWxkTndtQzNod3JvaEhTWWtLbWRjQjFLdlFNYlB1VEN6NTVH?=
 =?utf-8?B?TkpyZXlVMmIzWEFRS3JOK0RtWWsvcUlUSlhraE15T1FQYTRCQ1ZDS0tISU5K?=
 =?utf-8?B?Y0FKb2VoV0Y0WW5nb1NFUm1RMldyU3lkeDRBMUJ6Z1VkNDB0aGE0eEFycDFv?=
 =?utf-8?B?Vit1QXRRNGUwMXgxeTZNS2p2bTNxdk9IVC90MkdvVm12QnYyTTRsMzZwRXB4?=
 =?utf-8?B?dDAwSW9vRXYzSG1JYVJYcWJjTElUSkhFZk9sN2FTem9qS2x0Zzg3TGwvbC9x?=
 =?utf-8?B?NkdjWGdualRjSFI5TFBNUUdHL2VidTZKL2VtU1dSb0NLZ2JsVGhvYm5JZUJG?=
 =?utf-8?B?SzZxLzFVS0hFb1phMGkwNFhla24ra3BxQ2crNzloODVKYzM2eUxWbFVJYW9O?=
 =?utf-8?B?aWY2ZmNDdGJ2ZEl6cjJmbmN2L0dhQkU4dmdRcHFkTkg5TE9uNjdYNW9HVGxF?=
 =?utf-8?B?L3RSblVvQ2VMY0JRQlFWSWR5YUxneE5adlBReXBzM0hRU05JTlRLT3JqbTRH?=
 =?utf-8?B?Z0g5d2ZUQjlOclF5VEpaeWgwY3hPM2g1NDlidW92VlIzRVNubUYwWm9rUmYy?=
 =?utf-8?B?ZGJWT3NJN0xWRTlMc0JCQVZzWWdFUXpzU002d2VJR3RzaThkTmZRYWNSSGpW?=
 =?utf-8?B?cFNkQWJwZnVKbUZ6V0h0bnhoSkxXazJlQXRiWG1lSEJKbkJsTWpKd3VWSmRn?=
 =?utf-8?B?QXFJZS9ZR3BFcDByd0dhY0FRM2FrMkNQaENjaW5CWUkrS0NqMjRXeitFRlZV?=
 =?utf-8?B?UkhQSzB6aHNYZWxHbjN4RWoyR3Byc25NaTZaYzdvMjFwQ0c4ekhFKzFFMFhp?=
 =?utf-8?B?LzNYdWh5UGRaekx5aHUvVTFXYXlTWHZrMStSRVRLeVVoRGpQL25OZGkvdi91?=
 =?utf-8?B?cWRONXVpOUJ3RzVUYnhST3JxbTV0QWpvY0pTZ2ZtdnovTmhsazQyWklWWHly?=
 =?utf-8?B?VjRhMC9FVzJZdUFwVERCMEVuZ25TOFc3ZjE0TG1rTzB6S1NiOUx4d09iQVJm?=
 =?utf-8?B?eTFRZ3ZnUk50aGtLc3dvMWRseDI3WkFVbzZmRnByQnJVMGJBN3ppcERKb3ZU?=
 =?utf-8?B?cHRWOGlRR0dhM2Q3Wm01ODBaMFBDbHFFd21VQlBPQk9MN25oSDJiQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fnzncRYiofSR55sZCRNgwh3VYak4arq0D6aYaksIVAkmODL8yPgrDj+toF6nVHCZbrLRr9YsrURjhTGNaifWcmElZfBmF9Qk17RbZV3uHgJaEctuHGrDHOwMZHjWHPksW2iEcO+bx+Dgn58vu1fmxs/teHcDCfLD23uWAxY70eVdpcu1naEeCuwWRb4hA/KteIiq0gA2V2TP+b2rwzhlKug6qlyqORuOcJOf+iz4xWGwidJKOnztP2XJqS8sLcDitODnrptYVUnmx7UoFtFAL2KSeqqg1nYm02uRD7Nj//jNfaUZKGzWXpaEVaFq+7af3/O5yBJLhT3RCaWGn7H0Ig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dba265-1b7b-412f-45a0-08defceeb023
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 06:05:22.0596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0Imqgl0wUHZzfzEu1rL6wo40SD7pmEXDtEcY4DWbvb6WCkruBZrU306548drIqJhsen27iQVNK0IArJLEnGWO86SN9DED0JX2n19wGyUDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5590
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGh3L21pc2MvYXNwZWVkX3NjdTogU2V0IGJvdGggQVNUMjYwMCBw
cm90ZWN0aW9uIGtleQ0KPiByZWdpc3RlcnMgb24gcmVzZXQNCj4gDQo+IEN1cnJlbnRseSwgYm9v
dGluZyBMaW51eCBvbiB0aGUgYXN0MjYwMC1ldmIgbWFjaGluZSB2aWEgLWtlcm5lbCByZXN1bHRz
IGluIGEgbG90DQo+IG9mIHdhcm5pbmdzIGFib3V0IGZhaWxpbmcgdG8gYXBwbHkgcGlubXV4IGNv
bmZpZ3VyYXRpb24gd2hlbiBiaW5kaW5nIGRyaXZlcnM6DQo+IA0KPiAgICAgWyAgICA3LjMzOTMw
N11bICAgIFQxXSBDcmVhdGluZyA1IE1URCBwYXJ0aXRpb25zIG9uICJibWMiOg0KPiAgICAgWyAg
ICA3LjM0MDQwMl1bICAgIFQxXSAweDAwMDAwMDAwMDAwMC0weDAwMDAwMDBlMDAwMCA6ICJ1LWJv
b3QiDQo+ICAgICBbICAgIDcuNTEzNzU1XVsgICAgVDFdIDB4MDAwMDAwMGUwMDAwLTB4MDAwMDAw
MTAwMDAwIDoNCj4gInUtYm9vdC1lbnYiDQo+ICAgICBbICAgIDcuNjY0MjE5XVsgICAgVDFdIDB4
MDAwMDAwMTAwMDAwLTB4MDAwMDAwYTAwMDAwIDogImtlcm5lbCINCj4gICAgIFsgICAgNy44MjY5
NzRdWyAgICBUMV0gMHgwMDAwMDBhMDAwMDAtMHgwMDAwMDJhMDAwMDAgOiAicm9mcyINCj4gICAg
IFsgICAgOC4wMjY2NjZdWyAgICBUMV0gMHgwMDAwMDJhMDAwMDAtMHgwMDAwMDQwMDAwMDAgOiAi
cndmcyINCj4gICAgIFsgICAgOC4yMDE2MTJdWyAgICBUMV0gc3BpLWFzcGVlZC1zbWMgMWU2MzAw
MDAuc3BpOiBlcnJvciAtRVBFUk06DQo+IEVycm9yIGFwcGx5aW5nIHNldHRpbmcsIHJldmVyc2Ug
dGhpbmdzIGJhY2sNCj4gICAgIFsgICAgOC4zNzA4MzVdWyAgICBUMV0gc3BpLWFzcGVlZC1zbWMg
MWU2MzAwMDAuc3BpOiBDYWxpYnJhdGlvbiBhcmVhDQo+IHRvbyB1bmlmb3JtLCB1c2luZyBsb3cg
c3BlZWQNCj4gICAgIFsgICAgOC4zNzExMzFdWyAgICBUMV0gc3BpLWFzcGVlZC1zbWMgMWU2MzAw
MDAuc3BpOiBGb3JjZSB0byBkdHMNCj4gY29uZmlndXJhdGlvbiAxMDAwMDBrSHouDQo+ICAgICBb
ICAgIDguMzcxNTAwXVsgICAgVDFdIHNwaS1hc3BlZWQtc21jIDFlNjMwMDAwLnNwaTogQ0UwIHJl
YWQNCj4gYnVzd2lkdGg6NCBbMHg0MDZjMDc0MV0NCj4gICAgIFsgICAgOC43NjY3OTddWyAgICBU
MV0gbWRpby1hc3BlZWQgMWU2NTAwMDAubWRpbzogZXJyb3IgLUVQRVJNOg0KPiBFcnJvciBhcHBs
eWluZyBzZXR0aW5nLCByZXZlcnNlIHRoaW5ncyBiYWNrDQo+ICAgICBbICAgIDguOTA2MDA4XVsg
ICAgVDFdIG1kaW8tYXNwZWVkIDFlNjUwMDA4Lm1kaW86IGVycm9yIC1FUEVSTToNCj4gRXJyb3Ig
YXBwbHlpbmcgc2V0dGluZywgcmV2ZXJzZSB0aGluZ3MgYmFjaw0KPiAgICAgWyAgICA5LjAzOTI0
MF1bICAgIFQxXSBtZGlvLWFzcGVlZCAxZTY1MDAxMC5tZGlvOiBlcnJvciAtRVBFUk06DQo+IEVy
cm9yIGFwcGx5aW5nIHNldHRpbmcsIHJldmVyc2UgdGhpbmdzIGJhY2sNCj4gICAgIFsgICAgOS4x
NDc5NDJdWyAgICBUMV0gbWRpby1hc3BlZWQgMWU2NTAwMTgubWRpbzogZXJyb3IgLUVQRVJNOg0K
PiBFcnJvciBhcHBseWluZyBzZXR0aW5nLCByZXZlcnNlIHRoaW5ncyBiYWNrDQo+IA0KPiBUaGUg
cGlubXV4IGNvbmZpZ3VyYXRpb24gZmFpbHMgYmVjYXVzZSB0aGUgU0NVIGlzIG5vdCB1bmxvY2tl
ZC4NCj4gDQo+IFNldCBib3RoIFNDVSBwcm90ZWN0aW9uIGtleXMgZm9yIHRoZSBBU1QyNjAwLiBG
dXJ0aGVyLCBzZXQgdGhlbSBzdWNoIHRoYXQgdGhleQ0KPiBiZWhhdmUgYWNjb3JkYW5jZSB3aXRo
IHRoZSByZWFkIHZhbHVlIGRvY3VtZW50ZWQgYnkgdGhlIGRhdGFzaGVldC4gVGhlIG5ldw0KPiBh
cnJhbmdlbWVudCBub3cgdXBob2xkcyB0aGUgY29tbWVudCBpbiBody9hcm0vYXNwZWVkLmMgcmVn
YXJkaW5nIHBhc3NpbmcNCj4gLWtlcm5lbCBvbiB0aGUgcWVtdSBjb21tYW5kLWxpbmUuDQo+IA0K
PiAgICAgWyAgICA3LjU2ODE3MF1bICAgIFQxXSBDcmVhdGluZyA1IE1URCBwYXJ0aXRpb25zIG9u
ICJibWMiOg0KPiAgICAgWyAgICA3LjU2OTMzMF1bICAgIFQxXSAweDAwMDAwMDAwMDAwMC0weDAw
MDAwMDBlMDAwMCA6ICJ1LWJvb3QiDQo+ICAgICBbICAgIDcuNzQwMzcyXVsgICAgVDFdIDB4MDAw
MDAwMGUwMDAwLTB4MDAwMDAwMTAwMDAwIDoNCj4gInUtYm9vdC1lbnYiDQo+ICAgICBbICAgIDcu
ODgzNTcwXVsgICAgVDFdIDB4MDAwMDAwMTAwMDAwLTB4MDAwMDAwYTAwMDAwIDogImtlcm5lbCIN
Cj4gICAgIFsgICAgOC4wNDEwMDRdWyAgICBUMV0gMHgwMDAwMDBhMDAwMDAtMHgwMDAwMDJhMDAw
MDAgOiAicm9mcyINCj4gICAgIFsgICAgOC4xOTY4MjRdWyAgICBUMV0gMHgwMDAwMDJhMDAwMDAt
MHgwMDAwMDQwMDAwMDAgOiAicndmcyINCj4gICAgIFsgICAgOC41NDcwMzddWyAgICBUMV0gc3Bp
LWFzcGVlZC1zbWMgMWU2MzAwMDAuc3BpOiBDYWxpYnJhdGlvbiBhcmVhDQo+IHRvbyB1bmlmb3Jt
LCB1c2luZyBsb3cgc3BlZWQNCj4gICAgIFsgICAgOC41NDczMjBdWyAgICBUMV0gc3BpLWFzcGVl
ZC1zbWMgMWU2MzAwMDAuc3BpOiBGb3JjZSB0byBkdHMNCj4gY29uZmlndXJhdGlvbiAxMDAwMDBr
SHouDQo+ICAgICBbICAgIDguNTQ3NjQyXVsgICAgVDFdIHNwaS1hc3BlZWQtc21jIDFlNjMwMDAw
LnNwaTogQ0UwIHJlYWQNCj4gYnVzd2lkdGg6NCBbMHg0MDZjMDc0MV0NCj4gICAgIFsgICAgOS40
OTQyMzVdWyAgICBUMV0gZnRnbWFjMTAwIDFlNjYwMDAwLmV0aGVybmV0OiBSZWFkIE1BQw0KPiBh
ZGRyZXNzIDUyOjU0OjAwOjEyOjM0OjU2IGZyb20gY2hpcA0KPiAgICAgWyAgICA5LjUzMTE4Nl1b
ICAgIFQxXSBSVEw4MjExRSBHaWdhYml0IEV0aGVybmV0IDFlNjUwMDAwLm1kaW8tMTowMDoNCj4g
YXR0YWNoZWQgUEhZIGRyaXZlciAobWlpX2J1czpwaHlfYWRkcj0xZTY1MDAwMC5tZGlvLTE6MDAs
DQo+IA0KPiBGaXhlczogZTA5Y2YzNjMyMWY2ICgiaHc6IGFzcGVlZF9zY3U6IEFkZCBBU1QyNjAw
IHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVj
b25zdHJ1Y3QuY29tLmF1Pg0KPiAtLS0NCj4gSSByYW4gaW50byB0aGlzIGlzc3VlIHdoaWxlIGlt
cHJvdmluZyB0ZXN0IGNvdmVyYWdlIGluIG15IHBhdGNoIHJldmlldyBwcm9jZXNzLg0KPiAtLS0N
Cj4gIGh3L21pc2MvYXNwZWVkX3NjdS5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL2Fz
cGVlZF9zY3UuYyBiL2h3L21pc2MvYXNwZWVkX3NjdS5jIGluZGV4DQo+IGNhOTNjMzY5OWQ4MS4u
MWUzZGI2ZDAzZjkxIDEwMDY0NA0KPiAtLS0gYS9ody9taXNjL2FzcGVlZF9zY3UuYw0KPiArKysg
Yi9ody9taXNjL2FzcGVlZF9zY3UuYw0KPiBAQCAtODIxLDcgKzgyMSw4IEBAIHN0YXRpYyB2b2lk
IGFzcGVlZF9hc3QyNjAwX3NjdV9yZXNldF9ob2xkKE9iamVjdA0KPiAqb2JqLCBSZXNldFR5cGUg
dHlwZSkNCj4gICAgICBzLT5yZWdzW0FTVDI2MDBfU0lMSUNPTl9SRVYyXSA9IHMtPnNpbGljb25f
cmV2Ow0KPiAgICAgIHMtPnJlZ3NbQVNUMjYwMF9IV19TVFJBUDFdID0gcy0+aHdfc3RyYXAxOw0K
PiAgICAgIHMtPnJlZ3NbQVNUMjYwMF9IV19TVFJBUDJdID0gcy0+aHdfc3RyYXAyOw0KPiAtICAg
IHMtPnJlZ3NbUFJPVF9LRVldID0gcy0+aHdfcHJvdF9rZXk7DQo+ICsgICAgcy0+cmVnc1tBU1Qy
NjAwX1BST1RfS0VZXSA9IHMtPmh3X3Byb3Rfa2V5ID09DQo+IEFTUEVFRF9TQ1VfUFJPVF9LRVk7
DQo+ICsgICAgcy0+cmVnc1tBU1QyNjAwX1BST1RfS0VZMl0gPSBzLT5od19wcm90X2tleSA9PQ0K
PiBBU1BFRURfU0NVX1BST1RfS0VZOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIGFzcGVlZF8y
NjAwX3NjdV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkN
Cj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogOTY5NmJmNWRjNWE1YmYwYjRhOWQwNWI2Y2RmZTVm
MTM5OTBmOTdhYQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwODE4LWRldi1hc3QyNjAwLWh3LXByb3Qta2V5
LXJlc2V0LWU2OGViOWY0OWVlOQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbmRyZXcg
SmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pg0KDQpSZXZpZXdlZC1ieTogSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQoNCg==

