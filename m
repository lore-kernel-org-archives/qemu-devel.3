Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D4CC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ydL-0006Ty-PY; Mon, 31 Aug 2026 05:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0ydJ-0006Tb-QC; Mon, 31 Aug 2026 05:48:54 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0ydH-00082m-Nw; Mon, 31 Aug 2026 05:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPIjHWHM/rNZHTwAaFNA42IeQanFLKILgDaTai2oLz1lQ+hVoDeeUs7ML5fHOXZvqzJXPS7tsHFrCtzufb45CXD+zW8M7692ZrhWAgMdrju1rNAQ2SnN+1eqD5GucXX1ZsHubat3jA+LXbxLWUjO2l7tjH9rA17uv8q1eOFEuYcs5Wluqzu1hpRsoEP/e63m1W1J0hMBBJWJeWVVXxFTT+uJpScROranEJoI3beAqzL36m0xbNvP4wFROgPys8UOleX11tKWVJltz+d71qB7mif32AMuMz90K9v2y52sbN5vYUU60UnRXaP0rl5UyyFPe8TVKg38s/kk/rI8JA+RLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7XAjrrPismQbdfHsoEqCxA4GXWZbBljkfqqCP9FDfw=;
 b=W3mRMiI69q7tSum2LoDvdfEqUAEEIrB08X+tPQkmFQKEXWj4c2sxh7XJqe0MWneUGcbKoHuDFxA22gBBBfkNrie4oyB7B0n1wcfb1W4JyscYXnyoxl0ue2O+Mh/M5x4VL5NBvxjTZeTYPFCGVsrbWSZxU712g5s9ZMnKW91ABKpKuOuzQi7cOzP5ymcbbGnlUHTK9xI7xYWE/VOw+OW/KcJ4egfhH0TsAhppTd4V6d3Q2nsEambuqG9+uChrfUIDEtuUnkohfXxtzxHYkNDxTPdVzuvqy1p6GZsezaT3VxxNL/SAmaSqOLJJ6ulMXMZs7s69kF9iE/QfTVV3uMfKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7XAjrrPismQbdfHsoEqCxA4GXWZbBljkfqqCP9FDfw=;
 b=kr/GILFaHGPAIUnMEl0rX+Sapez79LELhNFiGttO9GGMOgv26M+kiEMkF84kPEPQRckyiKUZM5sd0RsyExvhfFoIpu+xLZjj7xg59LYzhMNUw9eqL8oRk00JY8HTtkINtDQsrN3cyReCx7eXClekhGtTnWVzRVsaoMf4yY+2W/NK0xrF1e1jjkfbX/gsf3Qax6x+lbme/HzZXuuCbUL1tq+pfV1tyJ3WIgoLg1XRBdHs3g98cCiTgRiXY/4XNDlV8kxJHf0f4OjDJrsK4TKV+NS+BoPZeMGPqRce9qEg3KFSbSGs6lqBllRLtZa9/dChGJPv6+RMZs0dx1HZFeu16w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SG2PR06MB5130.apcprd06.prod.outlook.com (2603:1096:4:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 09:48:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 09:48:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 7/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Topic: [PATCH v3 7/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Index: AQHdOPqvyqrPi6wUq0Stxgg+Cfv1ara3zJIAgAAcxJA=
Date: Mon, 31 Aug 2026 09:48:43 +0000
Message-ID: <TYZPR06MB498081B530E49FDA03B13245FCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-8-jamin_lin@aspeedtech.com>
 <7d141b4c-8f72-4414-b2ee-316711a1a26f@kaod.org>
In-Reply-To: <7d141b4c-8f72-4414-b2ee-316711a1a26f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SG2PR06MB5130:EE_
x-ms-office365-filtering-correlation-id: 43cc85ca-8e1a-4b23-713a-08df07450b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|4143699003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: ZKh7q4O+r0CoixWCEmrZk2c+8czsKQiB8Sh8k/FdnKh1fLrTWOak4NWxyDr2rYBpJfcu4jJzgiQhrft8dYZrmGISTLwYDn1Q+aPGXtX0HH4JxLv5faXch48qdno7T2RTHtvsQmeS1g/jPT1jfnuUbnc1RR+yT3hxmEFs0ycEvGAxM0xR2cguqYUf2NmByUPw0D3hFtdILFMKkBqzEbqWm58uvO/GIE34pAi2Cv3z98UdmdjeUxiPZSiZqljYL+YPtTJlMjbTnOY+L1RTvjhhoOB0SmrKFt+M17XcfHiHXjidBD4gYwW4r/kg8vkJ1l9OU6OyYa7+V7yLybSup7oUn6yfx4HafjS9XtN+o1B1ZkCdfwX//UELY5WAbDBUQ5xkSkSfcUYPIJr9yv9ms0k+etIJzzej8ahmUjnvkg/wXsg3HZ+uCHHwwQC8LHDs+GyjsUDAlF+WvsUPVQWx9itq5Cg8DWWeD/ozC97f9raJbM0Yjsaf8l06wMXjhTJ/m5F/fGYaEM1KS7TnVCByTRJCh3bZE4ofcUsf2VRLz/2OcaF6ga82MyATw4rjLLrVyNIq+TxLfVghKGEWRQM3EyBgkMV6bm6iMnVOAnIZhzHz3bY6KLnfOYxFeZs2fBk4v98W/lybSshnzNXWjmxftckHb1cULLjDzLKz5212mF8KK+wVZaHGqvQBSnroJ9lRP7XlqxRQWaXCE9nv81vBHjvNTiXBwpfee0y8b8XP0ijdBM7msfkvHnrJQ/sgjUYsOV20
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hFbjZBSk9PbGppV0tUc2lmTUlPZ005NDBhb1FraXE4K0RzZDdnR1R0TThP?=
 =?utf-8?B?TlV1eW5qK2RYWkZIeExRaE9lU1hVVEczOUNtdzhPMEVMYWNScGFDZ1pweWdY?=
 =?utf-8?B?NlR1aEhXcU5DY1Iva1Z6ZEpRWUMyVXpVQ3BGSVNWa05PQkNQRlpGS1ByMWlm?=
 =?utf-8?B?bGQzZHk3SVpmQWFZSytvcG16dHppdmswSEVjekJ1QUdzalRYclFqbEp4TWY1?=
 =?utf-8?B?ZXh4SWxRa2VrSUNPVzZoYytTbWlDaHduelo2RVBzTVQxT21MUmcwSWtQYi9E?=
 =?utf-8?B?dnVxTEo0d0FsbjRZb3JtZm9IZXBLcm5xdVhXR1RLOEtqQXVWNC9NNTRQd0g2?=
 =?utf-8?B?QlpYdlZFWk0zLzd1ekg0MlpPdkk5T0RITVp1S2NaY1h5eGNEQ2lqclhJUkV6?=
 =?utf-8?B?MVpLRHBoV0lRdWtSSlBSUGRpV2pVS1plMTM3YjZnN3NQSTBwMUdsODRCWThn?=
 =?utf-8?B?dERtdFk1akk5bDhVWDBGTUF6dUw4SVA5bThMUkNVcHFMei93clViWU9xb0Iy?=
 =?utf-8?B?TzgyOWFkMGwxQWlNT3FJbnNUNnkvd24rSzFuZENoajNMMFpSZ0ZZclYrTHM1?=
 =?utf-8?B?VkpzRzY0eUVKRFhieHVZMnRvdDMrbnV2b3liU1dXcFJDMklIRVplamY5VXJH?=
 =?utf-8?B?S055QjlzamgxT212NU9TU2U4UzlYM2dwaVFCTFVtMW9sRGdITFcwdmc2YWJK?=
 =?utf-8?B?Z1BYaC9tSXNUYkNuVHN6UmpNa2VHQVR5eDhsYmtuQzFZVzJoYU5WMVNtVnVs?=
 =?utf-8?B?V1E3VWdLMDhsM0U0N2hpWWRtQ29lQkx0YXBjdGVlSWhvekExM2VWTklTalp5?=
 =?utf-8?B?MHl4c3BrNC9LbnQ0TzBwMlkyRUdabGZZK0FoWjNDeGVRQzc4cTBPZnc0b1Jm?=
 =?utf-8?B?YVhxclZtbTBOaXl5ZDdLYk45Z1kya3pFOWlUNTNqQkhvU0hOS0JScEdJaWFk?=
 =?utf-8?B?eW5FblU1SUM0WGhqd0pXMXBibGpoMTczS1JFTTBuc1YrVDJKTVlNMUl4cTRu?=
 =?utf-8?B?a3ZFamlYelIwaXdpTVNyZVlPRVBEdlFtd3lyNkEyeXNRMGwwWjV0VW1CUExu?=
 =?utf-8?B?ek1TMER6dlpka2haekNRQTQ4V1F0cHBPTlVBdEJVZjhVYVZZanc3QWRhZS9o?=
 =?utf-8?B?ZmN2MisraUxMNmRuQ1VNZFVHNW0yWHREcXM1RXplSlRzNGxCczJPLzJhTkxr?=
 =?utf-8?B?K0FpbjJBTG15bTFrSUtMMjNrQm5wV3A5WnIyTVhtTkpNc3dWcm1wRGJZbU0v?=
 =?utf-8?B?NFVENVUwTTI4Q3JPdk1ocGpvNVJJcG1jYm5hN3JKMDVxTHVuRDB2S0Fvdm00?=
 =?utf-8?B?TFFFdDUvcnJzaDNVUzNFM1hqdUtnc0VrM21CN0piNUREdDdSL2V3RTQwTDJx?=
 =?utf-8?B?ZUFLQjlSZ0JuL0VXRlNFcEQybDNrQkdvYnoyTDZ5YUcwUXFQbGlMVW5MVFRk?=
 =?utf-8?B?MjY4R0dubm5NUmExNjdkK1BmcHNlbzNwSE5NZ0lkMXBrWWtPK1JoV3g0UGxW?=
 =?utf-8?B?dFRiSnlnSDdybkpRQ3lsd1FJRlBCTEg1bGhnblBKQVpyWXdkem9UZENKdHlG?=
 =?utf-8?B?bU5yZ1JtQkptZnNBQno3ckE2ZjBkUm9DOTFxRklzcVQzZGFtN04yYWVDMjk1?=
 =?utf-8?B?bW1VZXZMQi9hNlVoRnI0anBMM1VlSlU3U0dVbENMZW1LTGdxSTljaDJyTTlW?=
 =?utf-8?B?QU1Oc1h0VDJoZGxVSG1GYTZrM084azFoNGlUL0gwSG1FVFcwYlRVNjNvNjd1?=
 =?utf-8?B?Wm1hOEVpWUFMSEJabkNuVGVLOThpci9vQUx4UUhDVnp1K0tXTlpFQ3UvTEV4?=
 =?utf-8?B?VHlhcVZrYk5YUkw3TG4yMDRlZnI1aG43aUkxYWlNNzVNRTV2alFTYkVpdno2?=
 =?utf-8?B?bVJ3aUhFcGdKcHFyQmZoVXJGeEdYUXltWW54cmpmL01KeE93ZG5nTkQrbWhs?=
 =?utf-8?B?bVdVdzdmNCs3VWJzaGJMNXpsd2JsY21PQVk3UEZGQWZSTFlrT2JFd2tIZUpT?=
 =?utf-8?B?MG5CbTdiSnM0YUR6N3pNSzRjRURkMENYVlNYa2NoUk9ScXppZ0JQODFSSzkz?=
 =?utf-8?B?bkYrUzNRb0EzRkFIWkdwbzJVT1ZsUmt6RGJDSE1BVmpDaXlZcktVVDRSOEgr?=
 =?utf-8?B?K0hlbTIybnVZWGUzenZ0MTlIcnBwdmw2Wmwxc2hodGZla3RRY2ZzTnJ4akdJ?=
 =?utf-8?B?eXZjMEZQZkhFNTRTZUhIcTlkNXNSZUsvZ2lnYU93aEF0clRaSVIzL1l0amlk?=
 =?utf-8?B?RmtOdk5BUS90TXpxSGpSQVdOV090UEJNZ09VSyt0TXNGNkk3UGxxUUlUY2ZM?=
 =?utf-8?B?YytTcnljNjJwVU9VazJTNkczRkdXaFVJb2R3NlVsQjNKbldRRk1zUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e5khYKMdMWY6Q2wN91alrCkxvvYHN8xtdXa0GlqNXp6RL8m8VgaFlCmoSX7xN4ABIci3H8eTPNZNo9lURlw/F5qBbRY5xvVIyaFQDkQih+llWwVYfj5TTL/qHbfP1FXxcLAbkrar+24z960jSE+NTdctW77f7yiA3mv+w4HzEJeZa6yh5P8r/6uxzRhv+ZuFiz+KvSM70mZwsduN+NKXNSAiiReHGXDlvXky1h1gtpo4lNpKCRxjRsoqgzUi3BEtlVkzwZAc8nhoSkp+llKe176zxLGxasK8o8mJj/YauznwydZ8731V72+KMwH+F5zj0OdJ/FXlACS4SQ5d28+siw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cc85ca-8e1a-4b23-713a-08df07450b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 09:48:43.4287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9iDMULaRnauMaQQJDNytKKuHa3SqSFmY+mT7psZRTV0pUuBoG6WgWSsR5mXc+4y0e1Ferb3Q+ljTOW3DbBR/rrp/A0d5lsT586k7yN0/Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5130
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

SGkgQ8OpZHJpYw0KDQoqDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNy85XSBody9taXNjL2Fz
cGVlZF9zYmM6IEluY3JlYXNlIHJlZ2lzdGVyIHNwYWNlIHRvDQo+IDB4MTAwMA0KPiANCj4gT24g
OC8zMS8yNiAwNTo0MiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBTQkMgY29udHJvbGxlciBy
ZWdpc3RlciBzcGFjZSBpcyAweDEwMDAuDQo+ID4gSW5jcmVhc2UgQVNQRUVEX1NCQ19OUl9SRUdT
IGFjY29yZGluZ2x5IHRvIGNvdmVyIHRoZSBmdWxsIHJlZ2lzdGVyDQo+ID4gc3BhY2UuDQo+ID4N
Cj4gPiBCdW1wIHRoZSBWTVN0YXRlIHZlcnNpb24gdG8gMi4NCj4gDQo+IFdoaWNoIG1lYW5zIFFF
TVUgY2Fubm90IGxvYWQgYSBtaWdyYXRpb24gc3RyZWFtIGZyb20gYW55IG9sZGVyIFFFTVUNCj4g
dmVyc2lvbi4gSnVzdCBhZGQgdGhhdCBtaWdyYXRpb24gY29tcGF0aWJpbHR5IGlzIGJyb2tlbi4N
Cj4gDQo+IFRoYXQncyBvaywgQXNwZWVkIG1hY2hpbmVzIGFyZSBub3QgaW50ZW5kZWQgZm9yIHZp
cnR1YWxpemF0aW9uIHVzZSBjYXNlLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCg0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLiBXaWxsIHVwZGF0ZSB0aGUgY29t
bWl0IGxvZyBhcyBiZWxvdy4NCg0KVGhpcyBjaGFuZ2VzIHRoZSBzaXplIG9mIHRoZSBWTVN0YXRl
IHJlZ2lzdGVyIGFycmF5IGFuZA0KdGhlcmVmb3JlIGJyZWFrcyBtaWdyYXRpb24gY29tcGF0aWJp
bGl0eSB3aXRoIG9sZGVyIFFFTVUNCnZlcnNpb25zLiBTaW1wbHkgYnVtcCB0aGUgVk1TdGF0ZSB2
ZXJzaW9uIHRvIDIsDQphcyBBc3BlZWQgbWFjaGluZXMgYXJlIG5vdCBpbnRlbmRlZCBmb3INCnZp
cnR1YWxpemF0aW9uIHVzZSBjYXNlcy4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gICBpbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NiYy5oIHwgMiArLQ0KPiA+ICAgaHcvbWlz
Yy9hc3BlZWRfc2JjLmMgICAgICAgICB8IDYgKysrLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L21pc2MvYXNwZWVkX3NiYy5oDQo+ID4gYi9pbmNsdWRlL2h3L21pc2MvYXNwZWVk
X3NiYy5oIGluZGV4IDhkM2Y5MjA3ZmMuLjc1NmM2MTIzNTYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5j
bHVkZS9ody9taXNjL2FzcGVlZF9zYmMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvbWlzYy9hc3Bl
ZWRfc2JjLmgNCj4gPiBAQCAtMTcsNyArMTcsNyBAQA0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVF
RF9BU1QxMFgwX1NCQyBUWVBFX0FTUEVFRF9TQkMgIi1hc3QxMHgwIg0KPiA+ICAgT0JKRUNUX0RF
Q0xBUkVfVFlQRShBc3BlZWRTQkNTdGF0ZSwgQXNwZWVkU0JDQ2xhc3MsIEFTUEVFRF9TQkMpDQo+
ID4NCj4gPiAtI2RlZmluZSBBU1BFRURfU0JDX05SX1JFR1MgKDB4OTNjID4+IDIpDQo+ID4gKyNk
ZWZpbmUgQVNQRUVEX1NCQ19OUl9SRUdTICgweDEwMDAgPj4gMikNCj4gPg0KPiA+ICAgI2RlZmlu
ZSBRU1JfQUVTICAgICAgICAgICAgICAgICAgICAgQklUKDI3KQ0KPiA+ICAgI2RlZmluZSBRU1Jf
UlNBMTAyNCAgICAgICAgICAgICAgICAgKDB4MCA8PCAxMikNCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
bWlzYy9hc3BlZWRfc2JjLmMgYi9ody9taXNjL2FzcGVlZF9zYmMuYyBpbmRleA0KPiA+IGFhMTY3
YmU0YzAuLjVjMTkzZDkwODYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9hc3BlZWRfc2JjLmMN
Cj4gPiArKysgYi9ody9taXNjL2FzcGVlZF9zYmMuYw0KPiA+IEBAIC00NTYsMTUgKzQ1NiwxNSBA
QCBzdGF0aWMgdm9pZCBhc3BlZWRfc2JjX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJy
b3IgKiplcnJwKQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5p
dF9pbygmcy0+aW9tZW0sIE9CSkVDVChzKSwgJmFzcGVlZF9zYmNfb3BzLA0KPiBzLA0KPiA+IC0g
ICAgICAgICAgICBUWVBFX0FTUEVFRF9TQkMsIDB4MTAwMCk7DQo+ID4gKyAgICAgICAgICAgIFRZ
UEVfQVNQRUVEX1NCQywgQVNQRUVEX1NCQ19OUl9SRUdTIDw8IDIpOw0KPiA+DQo+ID4gICAgICAg
c3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5pb21lbSk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0
YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9hc3BlZWRfc2JjID0gew0KPiA+
ICAgICAgIC5uYW1lID0gVFlQRV9BU1BFRURfU0JDLA0KPiA+IC0gICAgLnZlcnNpb25faWQgPSAx
LA0KPiA+IC0gICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsDQo+ID4gKyAgICAudmVyc2lvbl9p
ZCA9IDIsDQo+ID4gKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMiwNCj4gPiAgICAgICAuZmll
bGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7DQo+ID4gICAgICAgICAgIFZNU1RBVEVfVUlO
VDMyX0FSUkFZKHJlZ3MsIEFzcGVlZFNCQ1N0YXRlLA0KPiBBU1BFRURfU0JDX05SX1JFR1MpLA0K
PiA+ICAgICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCksDQoNCg==

