Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE8BF99C86
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEhUM-0004Mv-Ms; Mon, 20 Apr 2026 01:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEhUD-0004M9-KV; Mon, 20 Apr 2026 01:47:58 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEhUA-0003hg-HW; Mon, 20 Apr 2026 01:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLk2SjMuoJiLaeNf6QxkjZnRnOTY+dTnJDmi0Iq6n/9DrOs5B75iOi7Mop+R48fW0JgcsnGNWoCIOJZT3l4IVqo/KOt1HYqosKc8FzJgaCnvmkNunHOfOac2Zh1VIBW9S3pbyJ4EpuKB+5hijnYgDRCa52q1AaTs5yMtma4xs/hfqkpy7uwQQwBwh/uR2rwkpXXwRktlE1cK2bmSk9ox9fT8Rgj3GTUmHR0Mz+vzOzciPtBW8AmSUz1/QxamyXahytcH8XdkxEmBQ0ziSeSo/jSfdkURRnWwwloLCd52fgc4CPsF741jKHsqQKKnAvR24MBtQvlu0FzC4jJ2BMD3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2gvO58Xx6X8OUBZGag8XTtnaY2HvzTY78Y7SUxwvSE=;
 b=aSKBkmCLY1k2CddMwBJ06g8vopXJFkWiyxukhLTv+KaCSmTTJ67DxzRr8BB7BquFChMcPoRBkGzzMgwqXYmc8mrJFUkSWaH5RAjGNRb/eTY/qeAkr3+nORmkQ0SeK193yDBFpL9mIuGwYJF1g/7LH28BDoNQz7HAYRw4yEjDXqS5QVZrS3io2ordjlJvLnek5BEvUhRvr49Cg445ON7HcQp/xlfHvn9OjsEDpPnsgUyNm2EvNB73M4NVPaRSKYs70qSyLJBgv8LK1GqhCC+P06WfFrd9Fgi0XraWNfJ7lDmUxA9uWWbvyi3IV5ZWUFCGb+spHjy3aXGSa2iD0saR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2gvO58Xx6X8OUBZGag8XTtnaY2HvzTY78Y7SUxwvSE=;
 b=EDXB4N8oT1BWewxgY54pO1dbMHYgzJzLLXiX2Z4qkJdp1RQGrgp2xPOCnGkbM4rtTMWjJyPQUe2Ji+7pnKr8hZmvZx0/W2sk8rknEnUKJFUpV3w0p10FfXGjyaVMOmQNtkg3XmkN+Fnf+ibQ2T+GhxOwzBMz2FwobXeh6iqYWYnLeP6nT5b1QOAFVpr83EcfhPDFHmVqgLt2GdaX6BMmfVkXaTj9CFNVnkvrLtZmOGwfTJVlcCCMW1BriC9QCbYXE/b51crg20NAQ8Kxy5juO6N+yyvOq7ByVDA7eCxPZRuD+B2+Fx9ZqVjxEaruf+Gdgk+719bd5AVQWNf7n+Cmdg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5738.apcprd06.prod.outlook.com (2603:1096:101:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:47:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:47:46 +0000
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
Subject: RE: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v3 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHczUNUCGCAr2wNUUqlxwuOt/36CrXi0Q2AgAAGdwCABJoRoA==
Date: Mon, 20 Apr 2026 05:47:45 +0000
Message-ID: <TYPPR06MB8206A19AD70BA0FAD7F68B15FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
 <04a8d8d9-f605-4bd3-8468-0e2840ae8311@kaod.org>
 <20ee6c39-d0ff-4e07-95e6-5aeb86dc0916@linaro.org>
In-Reply-To: <20ee6c39-d0ff-4e07-95e6-5aeb86dc0916@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5738:EE_
x-ms-office365-filtering-correlation-id: 0887703c-5f04-4d89-d26c-08de9ea0591e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: mZhrg+3hf9Fz2CpDMlNA/vEV7rN7DBXmqKbco5w09MZqHvIa29n1DBD+LL7hUrk0WbOWVyUWkC2HIkzJg550TpDVBwg08/jh/HFRVuBg1O9SXC+nI3cVAc2XkCUvit90kFTeeOenHx0fAokJsvOVQyEsHaBbJghqcqjGGDJ7mWmx49EJF3Xbx2SXylLC2DilwrciqSOmeQbUlYrSzQtV0FR8Ddo9iEwOI8ST8TDcNNxVvwa6T8dmnobfgaf6c3joWbpTajPvhsOd91ak9m5n1ylVqIXgYjt3cTrL9Li5XXD+LbmutabJlwEi+L4GWASkbrPoF98h6DFmVsmC2r+0wIOIoD8N7WgKqBxm7bDJUmwwyypvY+n1Yh9wtcASKZ2FF7ePhcxIwA+yuwPkoLIqW1UpLRcQac5r81xJfvVtud/pC8u2A/r+RoyZYcsXHEaZBSI2EIhFWHWRWX/uV5++iClnaqcJui3iCddjYT2QJIX1WAMjYCGMjzqRV9msNR7owjkLH5I6b3o4kkWWUCcqKPMLnkf5Nd/C5t2LoWOs+L/SDxKMMS0h2MfSv45/8FOT0Rbijo4K3l83k74dmV0DKcDRxIRax1XZ5OW+3ltOVbBep8o/ccQhNKj9PEwRV783+BbPQOxWZ8Ql8j0Jct8zLVu2hGvAP5aM0UlJK4+de1rpdCNDRgBOlibl6HzmSiTV37LsUMURAN2OrbYQpS+MfBX4qLESzMOKs4z6T6RxRSFhPJJ+hvyTAdsNxTUW+f3dFRXcAcuoQmGkIEPgri4pmV7FVJV3RNHVMOE/3+NrhXWBd346Xo9dWv6zAR3R2lrr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2thZ3VMcHRkTDZkWTczc25HcDhrRCs0YitqRUhtQkhNZk5BK29QR2hUNW1k?=
 =?utf-8?B?d083NlpMUVBTVHVMcUNINkdRckYyZW1mNlYxcjBRTXVaN0JnR3kvSm5TdVYw?=
 =?utf-8?B?emRKSE9KaVR5d3I3WGM5R0FGa2pYWHRUQytuQjM4SzlTeWF0c1czWGlETFRW?=
 =?utf-8?B?Y3IvZ1ovZWY1cG9MT3MrRHNiOVg5bUFRRmE4cHZ0ZmtUSzIxbDZxa01xK1lO?=
 =?utf-8?B?UGdXeEFLc0dFQ3pKeWRoOXhVbnJQQnA2bW12SDFzaVZyKzFCY05PV0dKaDNz?=
 =?utf-8?B?MDFPU05yRDhLNkdBS3ljdXhMdUQ1YllxODRVRS8wV0VKOVUwTXJTRUNDY1hu?=
 =?utf-8?B?ZXRwRS9yTG95R1QzOFZkNy9FMENFdmh1NzBmeGxYNXFUSzJsMXowRkJoWXg4?=
 =?utf-8?B?TWN6dFJZWkUxV1Voc01Sa3dUUkhXc3ZEVWppZWRTWm5rS0FKRU1OUUxhSWVm?=
 =?utf-8?B?T3FBZzBTVTNKMWRHZHd0MnRFWTRUT0lLbm5rS1l4aGZTbXJDZHRkQVB5SGZa?=
 =?utf-8?B?ek9WQUN2Qjg4bUoyTEpDWjQ5U1ZHY3FYdC8zdTV4aFlLcFFkajVlN0pFeWc4?=
 =?utf-8?B?aGdldU9CZzBOdGVZNmdWdEtEMURHMzZwU3FmLytrMXlpMGpnYnRpOGI2Wkky?=
 =?utf-8?B?YlVWR0JuWFFTeVVncnVPemxkVU1tQXhiUXJXbVhJTUhNd0dLU0pyOVZKM3lL?=
 =?utf-8?B?b3FGcGN6RXRHL1lOWWkxeUpMVFJHT3cxcFlZRlNjbXhUODZtcjgwUHJMNllu?=
 =?utf-8?B?Y2d3Q3MwOXRBNVdzd2FsWE9VVHNZRDNFRHVoVjh3cWRrNnF3Y2tqNFJ2dlFo?=
 =?utf-8?B?ZlMwU3lxeW1MbmVsakdlWmZGWWMzT0JaUFdCaXk4b25nQ3BMaDY3VEs3WFA3?=
 =?utf-8?B?bDBnaWsvby9PcDlCQ0ZROFMvb2lxWXRrRENBY3dGZlVkOTBrdjdkMGNTT1JI?=
 =?utf-8?B?SktDYnpMamM4MVByc3N0bVlxNzJ1MGk5enZaaUV2bisyR2UrM1lnNWRBS3ho?=
 =?utf-8?B?aUdJaXUvTGE0d09PQW90K3lla09KRXBja2JTWTU2UzFYSmtPMkNlOFN2WEFZ?=
 =?utf-8?B?VDlNcCtSMnBHQW1VZTRHZ2RwbjdSQWowd01hK05leHltd2JrZ05ZMzVUZXRh?=
 =?utf-8?B?a0lsSDhyOW05amZuKytKa0Z4ZDNYNnNkb0RMckF3MWlCKy9PWStOYkJ6bXRa?=
 =?utf-8?B?dGZBSStvSG5ZZDh6WWU3ejQ2Y2JxWlhXRWZXb1hETE5KL0tLMXZOZ3ZNWG5y?=
 =?utf-8?B?ckcxcktXNzE2SkFmUkhudldDcWVJOXZHcnlDeENhcGJEM0x5ZFpkREVlM21J?=
 =?utf-8?B?Y3p4ZnZRK0EvNEVpejVjbkJqOXh0RzU0ejhLZVJ4QUtCR2xyNHltZ0dQRE45?=
 =?utf-8?B?U203ZTNlWFUvcXJQZlc3L3IrcDlpNUMyRjc4cG94QzlrSWNub1E5SWprTXVC?=
 =?utf-8?B?dVRyN2I5WkpWd3pJVUZOV2JRTE9rRTMrcEtIT1l1Wmx1ckZpV1NwUlM2RUNN?=
 =?utf-8?B?NkVVS2RSUTNBNEt3dkhIb1M1b1ZDa0Jkd0RKcHJJendlYjhIVVVDbUVwdjZi?=
 =?utf-8?B?RVFzaEFrdW9NaElLT2ZHMjBEbDgvSWovS2FxTnVEZ2JaUm9uM0pxdmdGMER3?=
 =?utf-8?B?bVNzWHUxdEJuQXFwRERPZkpoL0svRFBtNlNZU09EeVcxSEhlK0V0cERrMFE1?=
 =?utf-8?B?WXQrZzNXZ3RaaEkwTWtwbXVBWkl6WjZFQXNnMmNBbUw4dzdvdWQvZTczdlZU?=
 =?utf-8?B?YnhyRDIydTVrNFpXOTBIN2F3ZEdvQ1Q3cWdhYVVwdXh2djhLNC94UkIwRmV1?=
 =?utf-8?B?LzN3TXZGUXpueTNWRXduaUZwbE9od3VEQUZKNFIwazJDTEc0TFk2cG9hVjBZ?=
 =?utf-8?B?TkJiOWJQKzFxcnRUUlJINWdYdnJTZXVmTUpFaFVZREdZVDhXRmtSZlNHMDZW?=
 =?utf-8?B?Snkza2FsWVpSMWJmemVrMk1Da1BuTWMzM2o4bnlQY1ZnSDJ0dzk1YnRnZ2Fl?=
 =?utf-8?B?ZDlhMEtLUS9nc0hUYXFWTS9FdmwrZVhmSnNTRUw1RkZGUjRBMTZCc3VVYmwv?=
 =?utf-8?B?NDM0WkpHbFRvZzFrZEtSdUM5SUxobDIyY1hEWmdCU1k0TFFLWDQrQXg1RGpQ?=
 =?utf-8?B?a0RTU2dPaGE0d3J3cFFud1FhSmgzbUdzVHZWekNUZUJxRk1oU1oyOHBWOU1L?=
 =?utf-8?B?Q2Vtb285d3lTTHJBRXNwRzZjR2tYc1MxVGxIUXpjc2l1VlZuelNVb280Uy90?=
 =?utf-8?B?QXNmb2MvZkkyQUgvT0FmY1U1TGJRTjB6L0J4bDVZQ2J2YXZTVzlUMFdzeExU?=
 =?utf-8?B?QStMUkZwdkozcHF6eU4zWTZoTCtvWlB2QnhJT2pvWnlYdmNVMVlOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mkx+fBn4l89othd9Ct57EScQnTDMdSZdj6BMx5AAWCAbObEV2AlBu9xM2ppOzr03qx6JviJyuvhDKyY2azv0w12mnXdbi9zBCrPVUfNby/KIun4bH/YZ9w8cSjcy9DeCrFuCsxYqwXM9uC0vIZiU+9lM3t0nTypEnEENOEp7W9qgIYa0ayHdvbFovKOo6hx7EfMYDadNuIfDn/SCowOGietXWR0xrWntpMhefck2JmQKCgzAWvIu3M7FRGLOrlcmZawzQ1yqoVoVgD9q7oBeWrp3u4Lg5iRcnQ2TRH7tb8xTZs9+31dMow0UvtJoBzbsTbk2DLyAdljCTNgbIBS52w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0887703c-5f04-4d89-d26c-08de9ea0591e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 05:47:45.9753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfobisBtUzXQNbaZrdWxp9CBIDejHoGzVbk8AoVxCHGl0qJiCxDR87hrwP17bwNvGm6b1lEDOLzQFY98tSkwaPIqjTk7QEeuPwkm8EuVPyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5738
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

SGkgUGhpbGlwcGUsIEPDqWRyaWMNCg0KPiA+PiAtwqDCoMKgIHJldHVybiBlaGNpX2dldF9idWZf
YWRkcihzLCBzLT5jdHJsZHNzZWdtZW50LCBsb3csIFVJTlQzMl9NQVgpOw0KPiA+PiArwqDCoMKg
IHVpbnQ2NF90IGFkZHI7DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCBhZGRyID0gZWhjaV9nZXRfYnVm
X2FkZHIocywgcy0+Y3RybGRzc2VnbWVudCwgbG93LCBVSU5UMzJfTUFYKTsNCj4gPj4gK8KgwqDC
oCBhZGRyICs9IHMtPmRlc2NyaXB0b3JfYWRkcl9vZmZzZXQ7DQo+ID4NCj4gPg0KPiA+IEluc3Rl
YWQsIGNhbiB3ZSBmb3JjZSBhIGRlZmF1bHQgdmFsdWUgZm9yIGN0cmxkc3NlZ21lbnQgd2hlbg0K
PiA+IGNhcHNfNjRiaXRfYWRkciBpcyBzZXQgPw0KPiA+DQo+ID4gSSBhbSBzdGlsbCB0cnlpbmcg
dG8gZGlnZXN0IDoNCj4gPg0KPiA+ICDCoCBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRl
dmVsLw0KPiA+DQo+IFRZUFBSMDZNQjgyMDZDNzQ2MUUwMDRDNEZGMDdCOEU5MkZDMjQyQFRZUFBS
MDZNQjgyMDYuYXBjcHJkMDYuDQo+IHByb2Qub3V0DQo+ID4gbG9vay5jb20vDQo+IA0KPiBTYW1l
IGhlcmUsIGJ1dCBzaW5jZSBpdCBkb2Vzbid0IGJyZWFrIGFuZCBJIGRvbid0IGhhdmUgbXVjaCBt
b3JlIHRpbWUgdG8NCj4gZGVkaWNhdGUgdG8gdGhpcyBJIGVuZGVkIHRoaW5raW5nICJnb29kIGVu
b3VnaCBmb3Igbm93LCBjb3VsZCBiZSBpbXByb3ZlZA0KPiBsYXRlciIsIHNvIG5vIG9iamVjdGlv
biBvbiBteSBzaWRlLg0KPiANCj4gPg0KPiA+IFdlIGhhdmUgdGltZSBsZXQncyB0YWtlIGEgbW9t
ZW50IHRvIHRoaW5rIGFib3V0IHRoZSB3b3JrYXJvdW5kLg0KPiANCj4gVGhlbiBrZWVwIG1lIGlu
IHRoZSBsb29wIQ0KDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgdGhlIHN1Z2dlc3Rpb24u
DQoNCkkgdHJpZWQgdG8gYWRkcmVzcyB0aGlzIGJ5IGludHJvZHVjaW5nIGEgbmV3IHByb3BlcnR5
Og0KYXNwZWVkLWFzdDI3MDAtd29ya2Fyb3VuZC4NCg0KV2hlbiB0aGlzIHByb3BlcnR5IGlzIGVu
YWJsZWQ6DQoNCjEuIFdlIGZvcmNlIGJpdCAyIG9mIHRoZSBDVFJMRFNTRUdNRU5UIHJlZ2lzdGVy
IHRvIDEgZHVyaW5nIGluaXRpYWxpemF0aW9uICh3aGVuIGNhcHNfNjRiaXRfYWRkciBpcyBzZXQp
Lg0KMi4gQWRkaXRpb25hbGx5LCBpZiBmaXJtd2FyZSB3cml0ZXMgdG8gdGhlIENUUkxEU1NFR01F
TlQgcmVnaXN0ZXIsIHdlIGFsc28gZW5zdXJlIHRoYXQgYml0IDIgcmVtYWlucyBzZXQuDQoNClRo
aXMga2VlcHMgdGhlIGJlaGF2aW9yIGNvbnRhaW5lZCB0byBBU1QyNzAwLXNwZWNpZmljIHVzYWdl
IGFuZCBhdm9pZHMgaW1wYWN0aW5nIG90aGVyIHBsYXRmb3Jtcy4NCkxldCBtZSBrbm93IGlmIHlv
dSB0aGluayB0aGlzIGFwcHJvYWNoIG1ha2VzIHNlbnNlLCBvciBpZiB5b3UnZCBwcmVmZXIgYSBk
aWZmZXJlbnQgZGlyZWN0aW9uLg0KDQpKYW1pbg0KDQpkaWZmIC0tZ2l0IGEvaHcvdXNiL2hjZC1l
aGNpLmggYi9ody91c2IvaGNkLWVoY2kuaA0KaW5kZXggYWY4YzA4MGM2MC4uMGE1OGRjYTY2OCAx
MDA2NDQNCi0tLSBhL2h3L3VzYi9oY2QtZWhjaS5oDQorKysgYi9ody91c2IvaGNkLWVoY2kuaA0K
QEAgLTI2Myw2ICsyNjMsNyBAQCBzdHJ1Y3QgRUhDSVN0YXRlIHsNCiAgICAgLyogcHJvcGVydGll
cyAqLw0KICAgICB1aW50MzJfdCBtYXhmcmFtZXM7DQogICAgIGJvb2wgY2Fwc182NGJpdF9hZGRy
Ow0KKyAgICBib29sIGFzcGVlZF9hc3QyNzAwX3dvcmthcm91bmQ7DQoNCiAgICAgLyoNCiAgICAg
ICogIEVIQ0kgc3BlYyB2ZXJzaW9uIDEuMCBTZWN0aW9uIDIuMw0KZGlmZiAtLWdpdCBhL2h3L2Fy
bS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCmluZGV4IDRhMWY3
Y2FkNzMuLjgzMTE0YmFlOTAgMTAwNjQ0DQotLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0K
KysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCkBAIC04NTgsNiArODU4LDkgQEAgc3RhdGlj
IHZvaWQgYXNwZWVkX3NvY19hc3QyNzAwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKQ0KICAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPmVoY2lzX251bTsgaSsrKSB7DQogICAg
ICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKCZzLT5laGNpW2ldKSwgImNhcHMt
NjRiaXQtYWRkciIsIHRydWUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVy
cm9yX2Fib3J0KTsNCisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMt
PmVoY2lbaV0pLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQtYXN0
MjcwMC13b3JrYXJvdW5kIiwgdHJ1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmZXJyb3JfYWJvcnQpOw0KICAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RF
VklDRSgmcy0+ZWhjaVtpXSksIGVycnApKSB7DQogICAgICAgICAgICAgcmV0dXJuOw0KICAgICAg
ICAgfQ0KZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QtZWhjaS1zeXNidXMuYyBiL2h3L3VzYi9oY2Qt
ZWhjaS1zeXNidXMuYw0KaW5kZXggNjEyMTVlOWYzZC4uMDFmNzJhNWExZSAxMDA2NDQNCi0tLSBh
L2h3L3VzYi9oY2QtZWhjaS1zeXNidXMuYw0KKysrIGIvaHcvdXNiL2hjZC1laGNpLXN5c2J1cy5j
DQpAQCAtMzYsNiArMzYsOSBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgZWhjaV9zeXNidXNfcHJv
cGVydGllc1tdID0gew0KICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKSwNCiAgICAgREVGSU5F
X1BST1BfQk9PTCgiY2Fwcy02NGJpdC1hZGRyIiwgRUhDSVN5c0J1c1N0YXRlLCBlaGNpLmNhcHNf
NjRiaXRfYWRkciwNCiAgICAgICAgICAgICAgICAgICAgICBmYWxzZSksDQorICAgIERFRklORV9Q
Uk9QX0JPT0woImFzcGVlZC1hc3QyNzAwLXdvcmthcm91bmQiLCBFSENJU3lzQnVzU3RhdGUsDQor
ICAgICAgICAgICAgICAgICAgICAgZWhjaS5hc3BlZWRfYXN0MjcwMF93b3JrYXJvdW5kLA0KKyAg
ICAgICAgICAgICAgICAgICAgIGZhbHNlKSwNCiB9Ow0KDQogc3RhdGljIHZvaWQgdXNiX2VoY2lf
c3lzYnVzX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KZGlmZiAtLWdp
dCBhL2h3L3VzYi9oY2QtZWhjaS5jIGIvaHcvdXNiL2hjZC1laGNpLmMNCmluZGV4IDdmOTBmZDEx
OWQuLjQwM2Q3ZTg0YTcgMTAwNjQ0DQotLS0gYS9ody91c2IvaGNkLWVoY2kuYw0KKysrIGIvaHcv
dXNiL2hjZC1laGNpLmMNCkBAIC0xMTMzLDYgKzExMzMsOSBAQCBzdGF0aWMgdm9pZCBlaGNpX29w
cmVnX3dyaXRlKHZvaWQgKnB0ciwgaHdhZGRyIGFkZHIsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAiICAgICAgNjQtYml0IGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBpcyBkaXNhYmxlZFxuIik7
DQogICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICAgfQ0KKyAgICAgICAgaWYgKHMtPmFzcGVl
ZF9hc3QyNzAwX3dvcmthcm91bmQpIHsNCisgICAgICAgICAgICB2YWwgfD0gQklUKDIpOw0KKyAg
ICAgICAgfQ0KICAgICAgICAgYnJlYWs7DQogICAgIGNhc2UgQVNZTkNMSVNUQUREUjoNCiAgICAg
ICAgIGlmIChlaGNpX2FzeW5jX2VuYWJsZWQocykpIHsNCkBAIC0yNTgyLDYgKzI1ODUsOSBAQCB2
b2lkIHVzYl9laGNpX3JlYWxpemUoRUhDSVN0YXRlICpzLCBEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApDQogICAgIH0NCiAgICAgaWYgKHMtPmNhcHNfNjRiaXRfYWRkcikgew0KICAgICAg
ICAgcy0+Y2Fwc1sweDA4XSB8PSBCSVQoMCk7DQorICAgICAgICBpZiAocy0+YXNwZWVkX2FzdDI3
MDBfd29ya2Fyb3VuZCkgew0KKyAgICAgICAgICAgIHMtPmN0cmxkc3NlZ21lbnQgfD0gQklUKDIp
Ow0KKyAgICAgICAgfQ0KICAgICB9DQo=

