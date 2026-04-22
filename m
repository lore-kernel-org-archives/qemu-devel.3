Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5CEF94CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 05:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFPhn-0000kF-Mu; Wed, 22 Apr 2026 01:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFPhj-0000jM-Po; Wed, 22 Apr 2026 01:00:51 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFPhh-0007yn-Cy; Wed, 22 Apr 2026 01:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9nQ3qdwv6dpV0gMCoAeg42GAD4akb6gJgSX2+z+d/qghIW693ghZCYMkwHAAcVWoOI4PX4/fMeJUMdjl48xA6HoJFeC1JIgHdFDOcpHgDjzKCo7B/szbtuloCqtLXTfqFm3EO2ea8PdPwFYIR9YoiCr/Pv3z/zo5KAGv9ocwPhMNgbZOCDhMFRsHVEcsYvAs1nxQOmixkKn4ff+mT6oowlVTvn4BFoh6eWbMzxGFLrjQoObpSG70atB5B4a6wgILuoD2e6ckFp/MwvBDuajzrHXnCHEeN1BYr9nde+xWpOkhhIRoQ5iLga53uRk9Q60x4MfryPdnSj8antTesozTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq5u8f8+bnnO3zjbYTGkNIjtejsCdXQ97D3EFCXoze0=;
 b=YKIYHRIaLmEGB3ol1O244Qea2MWLJuB+M7zffWHTBkjKcgkN1t+fQvnMV6Lo/QWHEYASUsp+nAakD6g5DWQfwSfb+GUHjwdhbF+w29xvQlv5OE3z07D5myH5NgZn+E+NVIsENK36uNIzadiJUyZrFKt6AbuoJhM0OZ2TJIkGPuHDFvvUd0zHPWHLbUO+kn/2kXvTV/7AVpar66x/cjb+UilnR3nMVTsYIl4cA+nuwbRbHvkTnUS5Fj72hh5TvB0o9euqb3waoAnXMuOayvRSgDhmpRceJY2IL9S5lfakKQxJKgw4b/x1XFLGzDsufZnMXDUGc76d0qQFWfOtu5tbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5u8f8+bnnO3zjbYTGkNIjtejsCdXQ97D3EFCXoze0=;
 b=gZgAikxWCU/cRg6ncsTDfJbV6UrRJgQQGmeXpa0n0As/Jpsc7Su2eAwKBv4fiq2H6iHJYefDLpSHDYbQ7iFbBQHTXJjx0m0vynJirwLXDHODes65TSJ+0YM0NWFIQmcKpcJqPBDvsmiI97d9HOVZ/lpVklkfpvNI+FOq2KDcJt6ilu9SsJl9OB657O4tFBVG4j8kHpcjsoQfiICRRcmLM56ZAZGCqOe5rqsSqKza3Bl0gbhQXXbrCmIP8x+N8/JF5AIvFT7g63+Ibu1wlVMb129HsjL05kSNFRV/4tpXpia8RfNQr/HyzYt9mG6bj65rdW4FADnvGF3e0ryQXJiDvw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5739.apcprd06.prod.outlook.com (2603:1096:101:ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 05:00:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 05:00:36 +0000
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
Thread-Index: AQHczUNUCGCAr2wNUUqlxwuOt/36CrXiyumAgAfDc5A=
Date: Wed, 22 Apr 2026 05:00:36 +0000
Message-ID: <TYPPR06MB82062ED0603F0A8507BE3F89FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-14-jamin_lin@aspeedtech.com>
 <6b535f08-8ee8-4227-9dfb-3d4914d825bf@linaro.org>
In-Reply-To: <6b535f08-8ee8-4227-9dfb-3d4914d825bf@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5739:EE_
x-ms-office365-filtering-correlation-id: 9165b809-9a52-455d-9d3d-08dea02c178d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CLSYebkVaa6WOYXABLJw+u6nGeHCubyPMkhOp1SyMDapPLuBaWxwzC7auljWnC0q+amrU//H6HDKbfH194OUNV1p/iUog+JW7yBQ4+0J2F3ukGz9fcNommbA2xUZm9SlTyz7YX4lEQ2kObn3Zb7s7bfsuLYl4isQADPZsM1bsMSJyttqewp3Mf6Uiba4E4WUZpWbuSZzuUwc/em8cULt71TQYulbOYUOoSh89CP2YInLfnJodPCRRqQIQwxoDslfk0hRnqdKk39KcmrIVUvF662yp1xukteMFRhTLLY5S0ubZge8253yZZyeSnHHh/heqqztsWI+Dtc4aGxBgg9OoFuQN6ZNzCFvuouq9nEElE9Vzuk5AoAY4mIkVdeEBFo64Fz7viwD3OlEKKzVVWv9h43K1B8vqSYsFM5ZbO95hoaT99r9O5c/wRckWyYfN19yneRjFCG8PGyU9qyblOy1PBAipvK8lHt3wmEXWYknyR1B8ReqhEz59dARXEmhbjsQ0pM/OkD+7oniMeVYfNFeoQIWjayWqqUs8xBR16Ay+0deTXf36OXMBjJq8wcl4wih6iOAGp4ERu5Vx364aWGbDdYW1VUfXZaAwcLWfbX4z+Ay9+lZ81V1Si20vfFWaHvvFdleIekEJXrwZJImMwPw5vogn/OcEUlyATtA7bShDn50De6OiwiQU1qU/Fa/9h+Lrn+jT7EwH80kZMA8kLH/PzF4PFuMC9tv11vSyhNjEXPtB+vLBKEO5CAyEyX+TB5donmQYKjpdfmHvIHK1a/b0s+uQy3Z1soGhbfLpKfWcyj8yvx7vYWWtXPMaEN9xoui
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWRkbThOZGFrM1NsR0s4Ty9Ud2NPNU9jWTRTdkxibEl5ZWxVejJnYWZMZTRj?=
 =?utf-8?B?U3gwSnRBOXp3ZW53Ly9YVm02SEtQOWZuZjlTQkljME93SW9RVmU3WmxFWWhI?=
 =?utf-8?B?VUhsN0NPZWMxb2syRDFCYmJ6T2djRnlBUVBreVdacmR0Tm1ZMnRrbUlrWFdK?=
 =?utf-8?B?dkk0bnJBZmFGNkdNMWdZS1ZObUdKVXBvNXpqaHlORXVoZjlHdEk2WkFjRnhM?=
 =?utf-8?B?UUs2L0o4Y3N4bGxNSmN6ZEo1clFuQlhjSFdJd0VTYlJvZm4xcHdXRW9iOWs3?=
 =?utf-8?B?YnRwdVJpSWNJUmVxZk1PcHdKb3dzYXFJbVFzMlRmdTZnekxicTUzNWlnb04y?=
 =?utf-8?B?M1NzR2k2ZmhiNC9wVVhvZjdQSDFnTUpNWGdBV2Q3YkpwVjlGOTRFekFNVk1l?=
 =?utf-8?B?dXo2VnVzN3hHQU1FOEZXczFDd0JGZnlYdlpoMEord1JXZWFULzh1SVgwQjNk?=
 =?utf-8?B?M0dKZld1ZzFScU8zWGpNYVVpSDVjQTlkTHhBaFpPSytNWjUwWklXRzVNOFRS?=
 =?utf-8?B?Sk1EWnRyNlE3UjBHdnozZWlEdTVRL0MvMDhocjR0aU5RdzVtWXlkbTBpeGZM?=
 =?utf-8?B?eWZLdTg1YWlPbGZrN2dJWmxSdCs5ZmhKTkNML3V0b1VBSCtKdC9LVWYwTDQ1?=
 =?utf-8?B?T0hSMEFqQnlBQm5zUmhvb2RFemxUNExIaThianpqbzQ0Y2NGbFBRVXZkeUVV?=
 =?utf-8?B?UHBxSk9EeG53V2hxdXM4SXo0eTFUcGtIY1lQQVgyZzV6NEZxQXlBalFMOThy?=
 =?utf-8?B?ZzhZOWd4NTJwR3RPblV6Q09HVW5xUUdCQTJqSVFwZExNL1kxeFVtQjRCdGN3?=
 =?utf-8?B?MGZKaDI4VHFpUzhwNTRmS0hIdG85UjFZT0kya1BvNk9NclBHbXZJVFl1NVls?=
 =?utf-8?B?YTFiNW83YUQrTG1CSFJtRjVITUJldDZ2Y2FPOGhGR05OYmJnVjlhWWpXRlk3?=
 =?utf-8?B?cVRESzRCZUcxWUNOSmNGNDN3SStzVTVsUFR5bE4xelhMaHB2ajRSWFVvRmlP?=
 =?utf-8?B?SW03SHZGS25PUmVoa1JkT1d3OWxYSGZVMVM4UHVJU1FGbENDOFhJOFB1K2Vt?=
 =?utf-8?B?ZzJKaUd5YlhoS0ZBMmJtbStOWEhQekdTTnBiM2RTTzIwTW1BbE80M2FVZER3?=
 =?utf-8?B?MW8zUXVmK0J0cFpINmQrNE1IbjdoSEczcFhDeTdIcExlMDR6R21kc3dlYWR5?=
 =?utf-8?B?Rkkxa2g0K3dWVmlxd0R2bXdkaTJEekMvcUFSYkhVcTdhM21TUCt3NEcvNUV5?=
 =?utf-8?B?cGxtMHBNOFJqejF0NCt3eVM1VGVOKzU4NE9SbGZVT3hEcks2R1ZpcU5KV2RO?=
 =?utf-8?B?ZVBLZ0Vielg0bU9TcE1SZkJnN3JGbWJnTy9wZ01zQ2xvRFRtcUs4SUQwMnRp?=
 =?utf-8?B?N3p6a3RMeGRNZ0NuRENuOURlM2k5VGpTYjdLZnNoUHAxREpBQ3lDWU5OdmJC?=
 =?utf-8?B?OVN1aFdDYVhFRzd4bFVTbExjOFZRVW9qdVBHY1dFdi9KejJIR1lVMDI0QjVZ?=
 =?utf-8?B?K2NUSkZyUFZSNUdBMUZGem5RTjMzREIxSXZKZXlnVlZLYU1TNjVOcnQ0VVZl?=
 =?utf-8?B?dEtiZ3pueVMwVHFtSWtldllkM3pCN0kwVWNuM2cwYllSNE0vYytDRml5a2ln?=
 =?utf-8?B?TWdkSStNc0NWblVzaFg4a1poYjJ5RzRCTDdTZXlCK3pKMHcyZVdCR0pDeThv?=
 =?utf-8?B?bjRBd0N6QmdBZ3c5M2J0TW1ubWsxOFBuY3BMOHAvS2hRaUl5Z0pKWHVaS0lp?=
 =?utf-8?B?Q3ZnclQzWlJMbGRWdUx2Tk5HcmJUUURSWVI3RkJuUU43dHQwWGE2aXNXc0ZF?=
 =?utf-8?B?U3BrVzd2UlNaRWFMbEV1ZTh0TmFlWUZhNzVSMVc0WVlJNFRJVzhjL3g4aG1h?=
 =?utf-8?B?d0txeDQwRUNPc1VkUTExbWZHYXhoOHI4d3RLNjFBekRKZi9yQ2U1WHcrekxJ?=
 =?utf-8?B?dDBsNnkvT3I2OGZzSGxSNlFqeUZkUTNjRG1kOEM0SzhrSzFkY3RRd3NjZE5F?=
 =?utf-8?B?QUx1YkFteFpCRWRKaEt0bURZaE5UdTljdEFsVGg5NkNIbVUwbmZNUEJoOTcz?=
 =?utf-8?B?SUNVa2dtbEhlU0lxZGNSTDl5TmR5WkN3OUE1NFlZYWJLTC9VNkhlZzUvSmda?=
 =?utf-8?B?TEZBcEZVdG1lUWJQc3BZRFpOUWVhdGkwREZlTnpXNVVyU2VvOUlVTUN2dzRP?=
 =?utf-8?B?ZWRhL0Yvbmx4dk1kNjY3eS9UeUs0enp1ZkllMU5oNFdWWDdOQWc3UE51aE5v?=
 =?utf-8?B?b1AxNGlTaXRWdnU5dzllUDFDMVVkcGp2SzNTc1FLMlR4djNxK0d1aE55em45?=
 =?utf-8?B?YVYxWVpXSmlYOEs5N0NHVzBGYmQ2cDNodVQxazV0K1U0T2E1emJvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XIeGRwXgmxUJ68b9Yal6PTW52WH320QecBsRHRgG+x+AzCAch1UP99rGwo0P+rFdSAdfZC982wfFmXvW6H4XvYmlGK1mMJJsItRUQzG+vERBUNTFdn29eNGKwp6mdLqqnD55QHgP/lOE4y/PpysTJMrtaB+AdBQizbS2TsPvEVd0EachYP0jacdcA6nbtSzCAFXR0/Z37tDnlPvMkOwl3SoMTvJ8taQUYzQq5PoQh974ADPPWEBCeBbqXh8d7quEV6Ygq4gxV42jJtd7hZ34GtQDl8OCTn0UNYcsj6AuAWSIl7fFHRtBpu9vbdMq5NvaOu8MGYs7Wjp93xyJWajw2w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9165b809-9a52-455d-9d3d-08dea02c178d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 05:00:36.6461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8gdSnsGpKm9HEo+R2Eri0nyMuLkEqV44zyzWp6Jom/AlYBWlQJJ6nN9VmXwc67saWA+fANEjtCpe5jGJUPPg3dHM8zVCtxAp09KHxd3NaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5739
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxMy8xN10gaHcvdXNiL2hj
ZC1laGNpOiBBZGQgZGVzY3JpcHRvciBhZGRyZXNzIG9mZnNldA0KPiBwcm9wZXJ0eQ0KPiANCj4g
T24gMTYvNC8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFdoZW4gNjQtYml0IGFkZHJl
c3NpbmcgaXMgc3VwcG9ydGVkLCB0aGUgTGludXggRUhDSSBkcml2ZXIgcHJvZ3JhbXMNCj4gPiB0
aGUgc2VnbWVudCByZWdpc3RlciB0byB6ZXJvLiBTZWUgZWhjaV9ydW4gZnVuY3Rpb246DQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvdXNi
L2hvc3QvZWhjaS1oYw0KPiA+IGQuYw0KPiA+DQo+ID4gVGhlIGRyaXZlciBjb21tZW50IGFsc28g
bm90ZXMgdGhhdCBkZXNjcmlwdG9yIHN0cnVjdHVyZXMgYWxsb2NhdGVkDQo+ID4gZnJvbSB0aGUg
RE1BIHBvb2wgdXNlIHNlZ21lbnQgemVybyBzZW1hbnRpY3MuDQo+ID4NCj4gPiBEZXNjcmlwdG9y
IG1lbW9yeSBpcyBhbGxvY2F0ZWQgdXNpbmcgdGhlIERNQSBBUEkuIFRoZSBwbGF0Zm9ybSBkcml2
ZXINCj4gPiBjb25maWd1cmVzIGEgNjQtYml0IERNQSBtYXNrIHNvIG1lbW9yeSBjYW4gYmUgYWxs
b2NhdGVkIGFib3ZlIDRHQi4NCj4gPiBTZWUgZWhjaV9wbGF0Zm9ybV9wcm9iZSBmdW5jdGlvbjoN
Cj4gPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVy
cy91c2IvaG9zdC9laGNpLXBsDQo+ID4gYXRmb3JtLmMNCj4gPg0KPiA+IE9uIEFTVDI3MDAgcGxh
dGZvcm1zLCBzeXN0ZW0gRFJBTSBpcyBtYXBwZWQgYWJvdmUgNEdCIGF0DQo+IDB4NDAwMDAwMDAw
Lg0KPiA+IEFzIGEgcmVzdWx0LCBkZXNjcmlwdG9yIGFkZHJlc3NlcyBjb25zdHJ1Y3RlZCBkaXJl
Y3RseSBmcm9tIHRoZSBndWVzdA0KPiA+IEVIQ0kgcmVnaXN0ZXJzIGRvIG5vdCBtYXRjaCB0aGUg
YWN0dWFsIHN5c3RlbSBhZGRyZXNzIHVzZWQgYnkgdGhlDQo+ID4gY29udHJvbGxlciB3aGVuIGZl
dGNoaW5nIHF1ZXVlIGhlYWRzIChRSCkgYW5kIHF1ZXVlIGVsZW1lbnQgdHJhbnNmZXINCj4gPiBk
ZXNjcmlwdG9ycyAocVREKS4NCj4gPg0KPiA+IEludHJvZHVjZSBhIGRlc2NyaXB0b3ItYWRkci1v
ZmZzZXQgcHJvcGVydHkgc28gcGxhdGZvcm1zIGNhbiBwcm92aWRlDQo+ID4gYW4gYWRkcmVzcyBv
ZmZzZXQgYXBwbGllZCB3aGVuIGNvbnN0cnVjdGluZyBkZXNjcmlwdG9yIGFkZHJlc3Nlcy4gVGhp
cw0KPiA+IGFsbG93cyBzeXN0ZW1zIHdoZXJlIERSQU0gcmVzaWRlcyBhYm92ZSA0R0IgdG8gY29y
cmVjdGx5IGFjY2VzcyBFSENJDQo+ID4gZGVzY3JpcHRvcnMgd2hpbGUga2VlcGluZyB0aGUgZGVm
YXVsdCBiZWhhdmlvciB1bmNoYW5nZWQgZm9yIGV4aXN0aW5nDQo+ID4gbWFjaGluZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGh3L3VzYi9oY2QtZWhjaS5oICAgICAgICB8IDEgKw0KPiA+ICAgaHcv
dXNiL2hjZC1laGNpLXBjaS5jICAgIHwgMiArKw0KPiA+ICAgaHcvdXNiL2hjZC1laGNpLXN5c2J1
cy5jIHwgMiArKw0KPiA+ICAgaHcvdXNiL2hjZC1laGNpLmMgICAgICAgIHwgNyArKysrKystDQo+
ID4gICA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody91c2IvaGNkLWVoY2kuaCBiL2h3L3VzYi9oY2QtZWhjaS5o
IGluZGV4DQo+ID4gNjQwNmY1MzZlOC4uMDVkOGRiNGE1ZCAxMDA2NDQNCj4gPiAtLS0gYS9ody91
c2IvaGNkLWVoY2kuaA0KPiA+ICsrKyBiL2h3L3VzYi9oY2QtZWhjaS5oDQo+ID4gQEAgLTI2NCw2
ICsyNjQsNyBAQCBzdHJ1Y3QgRUhDSVN0YXRlIHsNCj4gPiAgICAgICAvKiBwcm9wZXJ0aWVzICov
DQo+ID4gICAgICAgdWludDMyX3QgbWF4ZnJhbWVzOw0KPiA+ICAgICAgIGJvb2wgY2Fwc182NGJp
dF9hZGRyOw0KPiA+ICsgICAgdWludDY0X3QgZGVzY3JpcHRvcl9hZGRyX29mZnNldDsNCj4gDQo+
IEkgbm90ZSBPSENJIHVzZXMgImRtYV9hZGRyX3QgZG1hX29mZnNldDsiIGhlcmUuDQo+IA0KPiA+
DQo+ID4gICAgICAgLyoNCj4gPiAgICAgICAgKiAgRUhDSSBzcGVjIHZlcnNpb24gMS4wIFNlY3Rp
b24gMi4zIGRpZmYgLS1naXQNCj4gPiBhL2h3L3VzYi9oY2QtZWhjaS1wY2kuYyBiL2h3L3VzYi9o
Y2QtZWhjaS1wY2kuYyBpbmRleA0KPiA+IDJlYTg1NDlkYjkuLjExNWQwNWVkZTAgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvdXNiL2hjZC1laGNpLXBjaS5jDQo+ID4gKysrIGIvaHcvdXNiL2hjZC1laGNp
LXBjaS5jDQo+ID4gQEAgLTEzOSw2ICsxMzksOCBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgZWhj
aV9wY2lfcHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgIERFRklORV9QUk9QX1VJTlQzMigibWF4
ZnJhbWVzIiwgRUhDSVBDSVN0YXRlLCBlaGNpLm1heGZyYW1lcywNCj4gMTI4KSwNCj4gPiAgICAg
ICBERUZJTkVfUFJPUF9CT09MKCJjYXBzLTY0Yml0LWFkZHIiLCBFSENJUENJU3RhdGUsDQo+IGVo
Y2kuY2Fwc182NGJpdF9hZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgZmFsc2UpLA0K
PiA+ICsgICAgREVGSU5FX1BST1BfVUlOVDY0KCJkZXNjcmlwdG9yLWFkZHItb2Zmc2V0IiwgRUhD
SVBDSVN0YXRlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVoY2kuZGVzY3JpcHRvcl9h
ZGRyX29mZnNldCwgMCksDQo+ID4gICB9Ow0KPiANCj4gSSBub3RlIE9IQ0kgdXNlcyBERUZJTkVf
UFJPUF9ETUFBRERSKCkgaGVyZS4gU2luZ2xlIHVzZSwgbWF5YmUgYmV0dGVyDQo+IHJlbW92ZSBp
dCBhbmQgc3RpY2sgdG8gdWludDY0X3QgYXMgeW91IHVzZS4NCj4gDQpUaGFua3MgZm9yIHRoZSBz
dWdnZXN0aW9uIGFuZCByZXZpZXcuDQoNCkJhc2VkIG9uIEPDqWRyaWPigJlzIGZlZWRiYWNrLCBJ
IHdpbGwgdXBkYXRlIHRoZSBjdHJsZHNzZWdtZW50LWRlZmF1bHQgcHJvcGVydHkgdG8gdXNlIGEg
dWludDMyX3QgdHlwZS4NCg0KPiANCj4gQ291bGQgd2UgaGF2ZSBhIERFRklORV9FSENJX0NPTU1P
Tl9QUk9QRVJUSUVTKCkgbWFjcm8gZm9yIGNvbW1vbg0KPiBlbnRyaWVzIGluc3RlYWQsIHN1Y2gg
REVGSU5FX1NESENJX0NPTU1PTl9QUk9QRVJUSUVTKCk/DQo+DQoNCldpbGwgZG8NCg0KVGhhbmtz
LA0KSmFtaW4NCiANCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2
bXN0YXRlX2VoY2lfcGNpID0geyBkaWZmIC0tZ2l0DQo+ID4gYS9ody91c2IvaGNkLWVoY2ktc3lz
YnVzLmMgYi9ody91c2IvaGNkLWVoY2ktc3lzYnVzLmMgaW5kZXgNCj4gPiA2MTIxNWU5ZjNkLi5k
ZjEzOGZiMzM5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS1zeXNidXMuYw0KPiA+
ICsrKyBiL2h3L3VzYi9oY2QtZWhjaS1zeXNidXMuYw0KPiA+IEBAIC0zNiw2ICszNiw4IEBAIHN0
YXRpYyBjb25zdCBQcm9wZXJ0eSBlaGNpX3N5c2J1c19wcm9wZXJ0aWVzW10gPSB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICBmYWxzZSksDQo+ID4gICAgICAgREVGSU5FX1BST1BfQk9PTCgi
Y2Fwcy02NGJpdC1hZGRyIiwgRUhDSVN5c0J1c1N0YXRlLA0KPiBlaGNpLmNhcHNfNjRiaXRfYWRk
ciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKSwNCj4gPiArICAgIERFRklORV9Q
Uk9QX1VJTlQ2NCgiZGVzY3JpcHRvci1hZGRyLW9mZnNldCIsIEVIQ0lTeXNCdXNTdGF0ZSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBlaGNpLmRlc2NyaXB0b3JfYWRkcl9vZmZzZXQsIDAp
LA0KPiA+ICAgfTsNCj4gDQoNCg==

