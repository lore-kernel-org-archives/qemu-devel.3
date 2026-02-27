Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0389FFD5307
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsYK-00027f-Nd; Fri, 27 Feb 2026 02:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvsYD-00027G-3C
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:46:18 -0500
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvsY9-0007qp-QC
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:46:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkUtJI0hJMoAwSe4+3sn/PaCiak4WgucdrpueX5EVcp40hDjOhjkSCoSCRdhnNfP6v7uqFZuwcxkMUBz9gvppdQg0Ds8W5F7FonUSO88uwD2rdhh0Ku6FgwSxXvR7/7aryDpqZxm+w3G2mv+tq39zZaato0oHetBsIWZrSx+AQV1Rz20UiQRlvWtiYzakfoRmbBGKWMqoymmAK9qSYfsrdN9MT5ZzwfHEg0E8DazrBEYFR8fLlZp676cjTzefdk+xyywJ9tshKmpBGbqYnoFC9jkV7g4Yis6q2xrsnmPBh/GLLFqDII7y6mh1y5HAq6qJ0smRVeSTKnOe6dRPLSV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz840ywGDmN8FwMmPl3ke9EOlADxNu1mOeFUppSc0mE=;
 b=Q8tJQn3i0oySBtLg2EumDym5yvFrfW9uMLNA0wWGGYj4UOHsn748az3IeU+FBjnfUb561T5sqx6isMqzNOTxNELqakIsNurftSGhPOeuOCT3MDnAiNFDvspc9GL4W3XokevIP+tuJs+AA2/xJzXZ1Hc0ycovAbXca8Ze9LyKeHaj2YV1oOzioBIL9/44PFMFjBAhLeenzPD8Wtse89AZMOofwV5X4/AwYNY0eGS4fb0zr/PWAoFRtWd3fcJFpLKn8MetrFDMW1oALDq9CdOTHztImSEHIrmR81w2CWJ7y2Lpn0w3R8udKu2kFN1nqrEBgdbGW/Md3cB5ijxjw2kp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz840ywGDmN8FwMmPl3ke9EOlADxNu1mOeFUppSc0mE=;
 b=F95EkmKV6qiCZIPhJpnbKIKVN/nfjGWujpdWnu0TBfoSBcrQKa2sHzlo1E0DfsH0WuRIytAxDfTeZvnQYZ705hrQmN3AZXbgtwtcFs2MJxvSqxDRBU9bmpm/AWIJXF4APEnweg/36jZv1FdFo2CxOHGAXQrnsrqbYQY7yBQ1mo4kNtCewNDYnsJFu7C8DyYal2VfofyK9TKBe1G5veB696XjSxrCTe0jmlGT44xxfkXFAkzzlekFsxWBGw03ALhnJdf0TlhW0khHYQJglKK8cKYXgOop1kKu5jISSLPTqjplYUqH+q4FE17+6tX33zj+DpP5IODpGI0Nuouv/U24RA==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by TYWPR01MB7282.jpnprd01.prod.outlook.com
 (2603:1096:400:c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 07:45:38 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 07:45:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@kernel.org" <david@kernel.org>,
 "gourry@gourry.net" <gourry@gourry.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>, "nifan.cxl@gmail.com"
 <nifan.cxl@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "ppbonzini@redhat.com"
 <ppbonzini@redhat.com>, "venkataravis@micron.com" <venkataravis@micron.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v6 2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter on
 whether interleaved paths are accepted
Thread-Topic: [PATCH v6 2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter
 on whether interleaved paths are accepted
Thread-Index: AQHcpzOjI8jVXw0YS02cM+IgasAP+bWWK7iA
Date: Fri, 27 Feb 2026 07:45:38 +0000
Message-ID: <ae9a4eb5-b42f-4109-a7d9-d5328dbae999@fujitsu.com>
References: <20260226152034.1523-1-alireza.sanaee@huawei.com>
 <20260226152034.1523-3-alireza.sanaee@huawei.com>
In-Reply-To: <20260226152034.1523-3-alireza.sanaee@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|TYWPR01MB7282:EE_
x-ms-office365-filtering-correlation-id: ac44561d-04b4-45c7-f419-08de75d432f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700021|1580799027; 
x-microsoft-antispam-message-info: 6WZNVGCBUhK+LzB+EPVPwowdCO6xrRRBWnd0jzL9SqKX8eAM8P2bPKeCuceBkDdSbsjYRkGlFUVve9uiXHC7XdGrTxlYr2u39o2OOm2DZFkHkuS1bNrjds2fgKLcFCIv6DDXjT+NoxL/sfXrIAB4/VobVCRbdro00Nx2tDExnnMgnAMoxhPnHLYCyrYysqLgEg7EBlhyo8aMwcA9yWJVhMeOX59rqmRzlu+XUDYCNEuS9SHCFJUEbq0yIHD2oMFA2+DQ18ux0+dSTESQPHaUCXPXJfsWsqPH19EwNmDISFuMFoKMpWLVlof4ZRWsGcaOLx3F313JUb/4BDZnHk5TDGeISgqoCWjDEbWugcWx6riiUK/DQRm6x5Q7914KH+VsITeRKFhcBb1Hz0A2rsJknLfVWxIxI4WqPPgWW2QI6048zDSKx2J1koZMcM3zWaq+JJsU1SHO39dKaOPQaEOuNFkRoKuJhzqCYYgc0AVAYMP/O6MpEAnFlm0zsS6IioJcS9PUMpbYdQnjS2K8/HzuA1EB4dNYjtd7cKkw7YlDvqV2z0JoO+bZdO1xMDiIUm7//3VZ120LqpYCXVMxstn90lfHJ/Z94518XifCmwMwt9wq2xBjaWv51/1fHiGOutWP6t/I0tC6FNWSwYntQDprPgv8hcMzuZoUrZFHx/PUxhsVnV6s/Viv/3VDGvuZmKiaPGzfOumjlp5dj8px4gInjCpmMmyjbo9zqstyfYBcZCc3822RKRHGY14b+CifOy+Uj1wX9edS9p1wRrJKzBZ6asAodTWenQ+eAiYuE9WuqcN4Kbw1wM5Uh/LBASOMwMdc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjU4UmtLU0toemlra25kS0J2KzQ5WGxLZSttbmFPS2xjMStUajBqbVc5dTBu?=
 =?utf-8?B?Y0xIUlZkMUI5d1J1cXZuYXdZQVU2d3FWMjdxZ0ZxcnpOUWQ5ckQ1Tm8xOGpl?=
 =?utf-8?B?azl1UWVGS1V5OEZxNEFtSzdnbnViNTdmR2ZYbG5Zck4xVnVVQTBpTzY0Q2dH?=
 =?utf-8?B?N2VZMmtHQVVURkFtTGFPcFNESWV6eEhSalZKNTVqYTVidlI4TEM3cmVEMmJC?=
 =?utf-8?B?S1ZQMkR5aFFSUCtIYk15RGJ3NU5ha3R5Zmp0dDJTUmsxc29saSsrZWRzWWFC?=
 =?utf-8?B?cW9HSlVqY0dyWUp1dWY1SHZoNGQ3Q1pkVERBMkFqcWJCTlhJUlVUVnYzK0hi?=
 =?utf-8?B?R0FqeWRWS0dvSHUzaHZ2eXY2ZEZoejZSN2wzdFBoa1AwMGpBYXV2dXNoVEJF?=
 =?utf-8?B?WWtRMHA3RDB2ekRKKzlqbjVUS2pYZzJJRVB5bjdPbDBXMTUrR252Z1lBSW1x?=
 =?utf-8?B?NVlQa3dwK0NQTDJPTnhHemFVRVl6UjZtVWNLQ3A0WUlDY053ZzB6c0trcjZR?=
 =?utf-8?B?d2RMWmREUmdvMDdSRERrT1dETE1abmdydmxTRytScmV5TVBTUGxDL2tRM0Jw?=
 =?utf-8?B?NWMxVE1YbnhCVUNIR3ZUTURwcmJUeFczbEYySnVaNE8rN1NSSCt0bXNxbXJN?=
 =?utf-8?B?OU1xbU84V0kzM05mUkRSQW1LWUtQZTBVNEwwYVZacnZyRDJDb1VwaDUwVTlM?=
 =?utf-8?B?bDgveCs5V2VOdWFVamNEZ3pjQUpCVUFJQm9QR3hXcmFlMTJ6cU5INzlmRDdQ?=
 =?utf-8?B?Skw1cmtOd3c5elZ1dWNWMWRpczZLU1ZGcTVlaEZIalFhbVB5cisyTUxuVEt5?=
 =?utf-8?B?RHhqakFQN2lhbVhYcXhtZExyMGxtdjBzYXpETW15RmJWcVJ0MlFnV0EwcmNo?=
 =?utf-8?B?NnFNc1ZIMlZBdUZhemVzRW9ML3ZWUkQ3bHBqQ1pFZHBiTVFhQWZyL1UvUFhq?=
 =?utf-8?B?c1lLcXU1dU5OYmhpTEpydmJwTmJRb3FObjZ4cDdueDE5TC9TK3BPTjFjbHdO?=
 =?utf-8?B?b2lXYm1tWDI0Q0cvcUFhNHAwT3pmY2VjUHpyUmt4YzVGeVZ1OXRWYTIrajBX?=
 =?utf-8?B?NDFkSVB6SnBicWY2NzJxbUtrcVh6Qk5oanc1UkxSdnltaHVxREJBeXRqblpu?=
 =?utf-8?B?enM2UVhEL0VMaGRZN2JSNEdxMG85bFFqYlo5YUxQa29OTU5jSGtWTGwrVTkr?=
 =?utf-8?B?UDRjQy9mdmpIaG9xUXdueWZyc2wwSlFvQTFzZWhoOVU3VEJrYkhXb1pxRktD?=
 =?utf-8?B?T2krRjRMWTFoV2VoaTByZFhWODBMRXNVTFRid0tXUWU2bllQUWdXb2lSTEVW?=
 =?utf-8?B?S3hieGVlSkpTMlBiZHI2VDVya3FSekRMZUthcHhNb0JsdDNrMlBtK00wMDFQ?=
 =?utf-8?B?NzBFZjB2emd1c1FnbW5rY3NSNGVJdzZhUXFhM3RaY05SZFU0bUFDcnVMZndI?=
 =?utf-8?B?YVF3VzMzZFB6NStUQ0d3bjJRSkpRVjJSa3BLNy9MczUyek9FRHM4WFdJakhX?=
 =?utf-8?B?S0N3bFpSa3YyRGY0WVM4Zis1YWJpbUo0enNCZSs5T3hONUxDcXptNzg2MHpZ?=
 =?utf-8?B?cVZsUnczVGtsd3RZREJPckxZUFNldWhLMmJyZXYweHArbVpDU2dnempkbk55?=
 =?utf-8?B?d3RoVStQUytESFdJREFuUVFWWm5NTHBxbytxVVExN04xTTFiQmIzdGVaRURR?=
 =?utf-8?B?cWI3alpCeFlXcTRBMS9ZOUR3ZDlqWTAyK1pLS081SFJmMVFXNEFDWkltTW5N?=
 =?utf-8?B?aVQvTWxROVFmck8zWm45L1RsWS9NVFNVLzRtbHorcUVGdHJ0YXFVc1V6a1dZ?=
 =?utf-8?B?VFdaRlhTRGxzVUpvUHg1RHBGdlVWZWdJQ1NBRCsxSGpsVEttcTFZekNTRXZY?=
 =?utf-8?B?bXpGZXRIMEpTNHA3UFp6UXhsTHJJQ21TUmhwV1N5eHh6NmdLZk9uMGdDeitz?=
 =?utf-8?B?ZmpLb1pIb0orKzF1Zk43RkNrVVJKcmN6QkxiMTJTczZwTFJ6dWNHQVozZHJv?=
 =?utf-8?B?TDdNejRhQklmcEswVzFKcVdNUHRzamQwd09FTi9HNk5yWjRuZVppWmQ1enp4?=
 =?utf-8?B?dlk5R2hvVGNyc1N5cWZDcVpQbXJvRnA4Um9IRVhEZlBkT2dmVEUxVCtLT1N3?=
 =?utf-8?B?dUlIT3NNRE1ucFA4NGRrU2FudWJiNk9MeDJQNkJvRnc3VE40V3Z1U3JLWG80?=
 =?utf-8?B?eVdLbldEL3hRMTcvTllkNW1GM0JGd3ZMZ0lwalF3WUZWN2FjOWc3TGJFalFF?=
 =?utf-8?B?bWFoZ09Wd1AzTXpod0FHa2p3dmlKcURSS0xHMzY3dTN3M3g2ZjhPU211ZW1O?=
 =?utf-8?B?VDNCRzB2SHlmSDg2UkZNWHZ5L0dUZDRTYSswcHhPYWRYdi9ZRFZ4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2888F9146CD3054BB02F1DB5E0F6C72F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac44561d-04b4-45c7-f419-08de75d432f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 07:45:38.1586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ4WaLDmXRal6hqQJ5Ml9vDjP38RSt+LCjD5lFFvOUn4/fFb1sGdNRHJmFe6q+QIBeGYBnb1Jwt/dhQCbp++1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7282
Received-SPF: pass client-ip=2a01:111:f403:c405::2;
 envelope-from=lizhijian@fujitsu.com;
 helo=TYVP286CU001.outbound.protection.outlook.com
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

DQoNCk9uIDI2LzAyLzIwMjYgMjM6MjAsIEFsaXJlemEgU2FuYWVlIHdyb3RlOg0KPiBFeHRlbmQg
Y3hsX2NmbXdzX2ZpbmRfZGV2aWNlKCkgd2l0aCBhIHBhcmFtZXRlciB0aGF0IGZpbHRlcnMgb24g
d2hldGhlciB0aGUNCj4gYWRkcmVzcyBsaWVzIGluIGFuIGludGVybGVhdmVkIHJhbmdlLiBGb3Ig
bm93IGFsbCBjYWxsZXJzIGFjY2VwdA0KPiBpbnRlcmxlYXZlIGNvbmZpZ3VyYXRpb25zIHNvIG5v
IGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsaXJlemEgU2FuYWVl
IDxhbGlyZXphLnNhbmFlZUBodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K

