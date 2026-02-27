Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD177FD5307
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsc3-0002dA-Kh; Fri, 27 Feb 2026 02:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvsc0-0002d2-63
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:50:12 -0500
Received: from mail-japanwestazon11010048.outbound.protection.outlook.com
 ([52.101.228.48] helo=OS0P286CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvsbx-00080z-QH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:50:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grw3IkkCD+TylVGKj1ruZTyVQAHKgHrSFEo0P4HD+kf7NclxPMGHuYbnCB3+Sy7pnPPG65KzwaGQ+xy9rLnH6QQNk+Az5P1ac5EMJRTa8tK/9EZ5JcfABgqTcPswCXkFkEB0dBo92hXAuIUDXbiMFvR320j2VwccO6WMeZoRO25bFIGi+9XPnRqLuBg2I82Advvlu+wQy3vKYoSIZE/oPy5E3ivStVq2JhCd6k870itMZP3ZovyA0/U4l8iBkRiO7hICf3TopeC68pEowm+tMhgv/3yiQVFtl5IL3ofGqFMzU+IUWMOwtud7oO0bokMVn4yrPi6x6+KtQEHk92Ea6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcSY8uW7b5/1Kbjrfm0gUHLs4KUUbhiv4cle021zcXI=;
 b=A9i+5f+5sKDuC9xl3bDlNVBRaAv/9JgOOwdcCoeNpsXc+DTj8n1/wS+KpQDrESI2da7SbmLcYoWjakbCcI7OVu5o/AvP8MewLClEharWpyoUrbVcWsSimdsVgdJmdv9Eq6DlUo1oFK+rFPUxbm7Jv5lQYKk2cVw5bGnrUHEbsuXvqm65punQBYqIGm3MGzgAhOUnLoE3JRRwCEOI/cr1/rwMIDucaIAvNwiPSrYGwwq8U7hs/PcaQBelM5EnJ716A/wPyaafi+JQVYrLh3jqVtNWC234BoSm9BCXh7TFnZFQEDlP/cS7YKzZ8vXlsSPEhQMSq3UaEV3jm5lNtW3a8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcSY8uW7b5/1Kbjrfm0gUHLs4KUUbhiv4cle021zcXI=;
 b=SsI77w97YtzoyR/ayA1qnrNFz+YPp9jjpjr63FOjxrwrKpI2rd6T3VKwOLnw4LplZyfOoESo2krzO6qHM4k9VrfQrO5e8MJkTrGXGYEq+fj4XmDRp+SH4yJfsZnMEpeGU3pmfO4XTa7YSqAjughuxbidiG84ARXtZ/9nY6mUG/djZdrUjVjJ543p8JPVn7VuymnmXI64LvJpOm7CJ1/veeWP4hgD3e9vWSOpxPfk2i5rrThRmUdanRS7EN5PWFX+Eb6qV3278lB1uLGiswoZvnEKTPvgoO6+Bymx0zwNh8+H99xDpfSBAPAZytWmJ5cAfgV7TymaB/K3mJNzD/Sezw==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by TYWPR01MB7282.jpnprd01.prod.outlook.com
 (2603:1096:400:c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 07:45:00 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 07:45:00 +0000
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
Subject: Re: [PATCH v6 1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather
 than offset in window.
Thread-Topic: [PATCH v6 1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather
 than offset in window.
Thread-Index: AQHcpzOPDWmOi8ZMfk+zo1jCsb8/dbWWK4kA
Date: Fri, 27 Feb 2026 07:44:59 +0000
Message-ID: <66825df5-e193-4d96-87ba-52b4fd2e0b45@fujitsu.com>
References: <20260226152034.1523-1-alireza.sanaee@huawei.com>
 <20260226152034.1523-2-alireza.sanaee@huawei.com>
In-Reply-To: <20260226152034.1523-2-alireza.sanaee@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|TYWPR01MB7282:EE_
x-ms-office365-filtering-correlation-id: 2da96c41-1dcf-4257-c8e0-08de75d41c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700021|1580799027; 
x-microsoft-antispam-message-info: tk8demBE1NlCqp7tyaGksQnfcHtYEuicIOxuCX59XK3D+3sKRy1In2G2tX5qWl/B2eufoI4Ult4ySKHxWIbFINj91MDa8r1zYp3MHCDFDHYA+2HpywgcA+vkPAgo55GaJM404lAn0kupzJpNQvhG66EsGQPA+2UNk97Vfu1LXY4DtcO4SzeanUt7QSU6zkbNIX2B4fB4CEggE8zY990j2S3QAk+n7qN7wzNcCnf9YfwD7gq0Hr+pAW/WjRM9XGWBU0hHN4BS8D4Kls/4WI75O48UyaWV5TpJiQke0i72EGfWBsLFSl8wfvl/DB0Qw7gZfeo0vY8i0C3TtyzmJC+OftGHUDGNt6J3GDGwrzERB5Uxs7j6zn0zkjsVlYnqs0m3FP9gGiU+hfIOx3V5YWW/w/aDpGbrKGLmJBQURh+GFSYLVnY0Jx2D8dwVObMnXjK/6JpRxslS78VkWrpLUZjw8NLQw0eDlM0+blmAUAIi/odPpFpn55Ts9p4Dx2cI229+vDmciXnr8I3d1ecQBdh2j05A5gO9SlIDir6GbpGbm4JBag62l3Ui+lsazQTWynYLDUYu3uFaiVDRKKnD7U45ZgeVRo3jKFo62IH1Dzw85I6ljqghJEpGfXlM6Nx5JKF5IqmhvMkhO857i83pxOzIBlOnRdIySFdKWxIVaJUw5EtvDPrGZXtADO+iHY+FR+g6MJT5RY5g7JwUPmu2gHKEVLYtUDL7Vr/fOGY7puV60WKNb4tyl/AIQ9UMdKcIH9gtsjOMZB2vLf7hTz/sEQN5oy82YN//fJjYPOe7Z4r2QEA02VIbpLOTBnxE8tT8eoNy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzFhZ0hwakZ3cnVRdk5wZERvWVJRZ0l6TUdXZ2dKTGl3OUpJTDdESDd3K1B2?=
 =?utf-8?B?c2hoTmhTVzdDdkYwNVF2SDBZWW5POFlsUDI5MHJjTldqcDFlQTBXRUhrdHhw?=
 =?utf-8?B?cG9NNE1mckQ2bmlnWUZncUJRSHdBaHdoeXVCb0gwUVhlNC8zNUZFQ1k0dUVX?=
 =?utf-8?B?WSt0VDl3WXE1RHhqMEpBU1ZDL0lvUE14OWRPMjBRdUJZT0lhVnVITDVWZVRE?=
 =?utf-8?B?RzdxVFRpa21DUHZOZFlIcjdER2M1MEU2RmZoZzFqMXNZaXNOUmZWQm9xMVlR?=
 =?utf-8?B?OUdaYXY3bkEvUWdkTU92UzhsSmhhN2FSSjh2MHVmcFFnL2lDbFI2NHFpWnZK?=
 =?utf-8?B?YVZreXNMWFdyRnVEc1cxN0tVODNvaWdEZk0zL0tjNlRnaGpmQ2tlMUFMWlpT?=
 =?utf-8?B?WWE4Wm9xM0lHUlFkcGN0b3Q4c295M00wb01EVTlkcVJhOVVZRTExSHVwcnk2?=
 =?utf-8?B?UDh1cXkyUmExZjVuUUViZG1Rc0oweVdLbEQ0K3RCczFIN1BVazByTm1yM250?=
 =?utf-8?B?NTRxd1BYanBTK2RHMHlPOWJBbmx1dDh5T2orSEtmVUcrUG5yeVZwUzZkQ0hZ?=
 =?utf-8?B?S240Zjk1K2s5dHptRkN6K3ZvdU9vOE5BcmxraENGRXU0K25KK0NqUE1FMjlu?=
 =?utf-8?B?alU0aThZaVQwbVBzWDVtcVFZODlnOStHUlp4NEp1Y3hBaWhSTXRtNXl4UmhC?=
 =?utf-8?B?Tlh0VWQ1eVVTZ1h3dHBIYWJDNkhjcm4yMGVqTHlUVVY1QjQwMWF4Umx6THhT?=
 =?utf-8?B?TDRhZkt3YmJ4R0J0K2RWaVpkbHBScjJMOW9UejBtYU0yczIzdmFmb1NVMDhD?=
 =?utf-8?B?RDByV0t2L1pFRzRYQXAyRm4vMWtHTEFpNFJLNmpyNFRFMTBkdDcrUG1HNHpB?=
 =?utf-8?B?ckdEZ0tHakhIaVQyVm1nZ0pSclQyUE9WUE9hQk45dHR1MmZsNlJpV3JxOXU1?=
 =?utf-8?B?dFpQR1o3SWxmMU9mUmtIelZvMHhMZC9mZkhVaXZHMiswZWN5YkNzejhucVUx?=
 =?utf-8?B?VmpZcVlYaExRZm9EYTh3VlpKZElZalBJYkpnbmJmZjNDamdSZC9VTGZqaXVJ?=
 =?utf-8?B?a2l4OTVJTDNrZkkzek9VSitZdEhuWVlrdGtqWXlxY0V4elBZZ3JHZWhJTlVh?=
 =?utf-8?B?S1Ayc0d6VjBoUnV5YmErM1JzU0hLSDJKVDRlak1WUFJnbTBUdG56NUJLV2Jp?=
 =?utf-8?B?Y01rSGtQd0phZE40YWszNmpLdUJJaTNBWWZkdWVhKzB5Zjg4cDZHaWNvODBY?=
 =?utf-8?B?RmR4eGU1S0g0M29zWHI2cktNSEg2NE5VaDB5UGtWc042a3hibTM4b1B0L0VR?=
 =?utf-8?B?QmF6L3dCa2MzSFFsY2V2eW5ROTdGdjBwRCtKWjdWeGY2b1pRR3RxYWhnbkNE?=
 =?utf-8?B?bGd3YTJPUFRRSWkxeEttTWNZUnBmeGpFRENDRjdCd2R3amdWSmdObmphZ0lV?=
 =?utf-8?B?a2xIMWNpR1NUYkdQZEVMY2ZTamtWWVg2d3lSUXp6NE9OemNJQVVJWVl1UnM0?=
 =?utf-8?B?RzFReHN6bXhFZW1HL0dVVW5TTUZ0OFMzZVZiNVZucE1JM2RzUitPM04vL2xZ?=
 =?utf-8?B?ZGZnams2OVhhVllDYW1uLzVoQWUrRjNRMHdvZFhweWlxUlAxZXNrejdLcncv?=
 =?utf-8?B?UnB5QnBVZzB6bDluODIwdXQxdE1aOCtSYU9SU0VuekRQYjRENWZ2c2hZNEpN?=
 =?utf-8?B?bTRkZWN3NVlvUktiNmNXN0NidzFETzBkSFBWS1Uwek1GZ2dvRi9LdU1EZWh4?=
 =?utf-8?B?L2ZscHZPWHkyZTc2R1p4YklUMndQMVk4Vk5CeFFMeU9FMFFwdkdQTW1oTW9m?=
 =?utf-8?B?ZXdLYndQVkhCUkZwOEU3SkxxQ1dpd3lDUEZjYkluZkNQM1RyV0c3cXJqZnp1?=
 =?utf-8?B?VFk2Um1uMjJrS3ZhYU9tcEpLTTJRRUZmUFdzSVJkeFIzMlA0aTNuUUU4eUJy?=
 =?utf-8?B?U3ZhYkFmUExVQkdKSXpacURIVVo2dVhMMXNCckR5NFc2NCtYUEgrVG5sQXJ0?=
 =?utf-8?B?ZHc2SGo2V0h2M2ZTVmM1c09xaUw0Yk01ZnRPYTJoUEtqQS91UW5zZzg1S09i?=
 =?utf-8?B?d1RyeTMyUVNkMjhudGtRTEJReXhQQS8vVjd4TXFEcnh6YVlCbWJVNlUxd3Ax?=
 =?utf-8?B?dVMzMGtyS1BUMHpldEVLQ25sOExraFdRR3UxbEFQTGozM1ZSZVdyRXdiNlk4?=
 =?utf-8?B?QWxRTDhTamwzY0lYKzhodXVsVXdrZ2VJaUhRTEMzVlF1cklzdnRJS1RDSnJx?=
 =?utf-8?B?RlFNYUlvTW1SaVZmVGM4VkhpNWFXV0szYTJsOTg4TUhOTFdDVjFpT3QyaEYx?=
 =?utf-8?B?WGJoaG9sRnN2akF0WlBid0dWN080aGxWMGVGZDcyZGs5QTlyYmVuZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BFBEA4B9A7A7A46819939F8669E2BA6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da96c41-1dcf-4257-c8e0-08de75d41c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 07:44:59.7316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkxEcDXs7U5MRvGR3GqIOC0IdAN/M8Qypp4iMpa/peYUJLchz+A+2eb9UwVWT1UsvjaUFNxZslnPn0BCM/K5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7282
Received-SPF: pass client-ip=52.101.228.48; envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU011.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCk9uIDI2LzAyLzIwMjYgMjM6MjAsIEFsaXJlemEgU2FuYWVlIHdyb3RlOg0KPiBUaGlzIGZ1
bmN0aW9uIHdpbGwgc2hvcnRseSBiZSB1c2VkIHRvIGhlbHAgZmluZCBpZiB0aGVyZSBpcyBhIHJv
dXRlIHRvIGENCj4gZGV2aWNlLCBzZXJ2aW5nIGFuIEhQQSwgdW5kZXIgYSBwYXJ0aWN1bGFyIGZp
eGVkIG1lbW9yeSB3aW5kb3cuIFJhdGhlciB0aGFuDQo+IGhhdmluZyB0aGF0IG5ldyB1c2UgY2Fz
ZSBzdWJ0cmFjdCB0aGUgYmFzZSBhZGRyZXNzIGluIHRoZSBjYWxsZXIsIG9ubHkgdG8NCj4gYWRk
IGl0IGFnYWluIGluIGN4bF9jZm13c19maW5kX2RldmljZSgpLCBwdXNoIHRoZSByZXNwb25zaWJp
bGl0eSBmb3INCj4gY2FsY3VsYXRpbmcgdGhlIEhQQSB0byB0aGUgY2FsbGVyLg0KPiANCj4gVGhp
cyBhbHNvIHJlZHVjZXMgdGhlIGluY29uc2lzdGVuY3kgaW4gdGhlIG1lYW5pbmcgb2YgdGhlIGh3
YWRkciBhZGRyDQo+IHBhcmFtZXRlciBiZXR3ZWVuIHRoaXMgZnVuY3Rpb24gYW5kIHRoZSBjYWxs
cyBtYWRlIHdpdGhpbiBpdCB0aGF0IGFjY2Vzcw0KPiB0aGUgSERNIGRlY29kZXJzIHRoYXQgb3Bl
cmF0aW5nIG9uIEhQQS4NCj4gDQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsaXJlemEgU2FuYWVl
IDxhbGlyZXphLnNhbmFlZUBodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K

