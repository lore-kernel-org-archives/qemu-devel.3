Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C13CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKMd-0006aU-Lt; Thu, 01 Oct 2026 13:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCKMZ-0006aB-NV; Thu, 01 Oct 2026 13:14:31 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xCKMW-00064h-CF; Thu, 01 Oct 2026 13:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHoLkIvCDFBEcp6ULU2BQ73QuPYGJLoQDFAzpRTwtRXH9HP85GLgGI425kf/qAAzyB8b0+k+G0zwDx+TrfhhyVC8Odfa7RthLe5+14bQC9OeJT/MbElI7y0zaQVLwdNB+GfiSE5mpSXPi09okZ4WGTvY5pLgiJ4OSY17uC3Opi/cZIs//HPtIiuTG5kGjNESsQrYgAGu2DOoEzlw5XSFUp7dvv+GES3NpLTAg+hjeBrfqzxSbyLteQdpX0AwgLU/LU+KGXAED15v46qRy42WUnJSHJ5K5DERWRbr+Cuh60DbmEeOWcJcaZ0QavEVu5M8mDVrXqb3fVG8cgfP1sJrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVfsJD1qfgj/ilR/zu9aqtjcfD9Vw+KdPgUHrbTqvWA=;
 b=A8lZ+0tcycV/eFMfE1Rr3xXelGAIRL5AqvhoWnAE7cDCYggwCNe4Y3ox+ZIRM3c/NQXPz2v8NmtEUBJ5jWhlUJfQHE0++nL9pggZnv+6ymuS7fuZE5GZcXd/w9cDueGjPDtZsJgk4vGc61vauWU03hAclJzH6Q3heUem4M75CuUvFQljbBa05RLOYe0Mty578LIayJqb1ONLQq3nWXzv5ScrM3gq3wB87dvgSZoDilHg5vOcpSeLXm97T2/uL2phVC+GiwZI6QuZ3eagJpZjBapRvQ5XIZYUd8F2WcNJLjKnLeAMFABMhYtSxA5oKE4FezMw0siEGVBmn7p5IBRa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVfsJD1qfgj/ilR/zu9aqtjcfD9Vw+KdPgUHrbTqvWA=;
 b=DZI9dpyDJwW/ZffYerfz6aKrAxtCMs8/m1v5j/KIvo+NbSy8KGK9OvLCqFrVEmyloZFPjAXttMAQB1rCHHz/v/9UXDZLlRouzdtQ1FjbtvPdEIzmDTe4gydt+d3N2AkXtisO6c2SNtmRYfeZr6X9Zx+SoMugZikJg2xlEnC8Av/mumFKrgqGDh46pzmWLDQG4qYAw4dEbecHPvCOFnzWpVN6dDEwlmgQUuzliAaX0kESOY44/qUGPBNUp4ioQO+2gLgmykjnLMCN10E16XTFSw9kH35jiRh7r+Ia2Txu4BtpqFHmdwLCPCYbLzuwZge/HbbHJU/GpXbIFL58F3Ed/w==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 17:14:16 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 17:14:16 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>
Subject: RE: [RFC PATCH 4/7] hw/arm/smmuv3-accel: Add a helper to replay all
 STEs
Thread-Topic: [RFC PATCH 4/7] hw/arm/smmuv3-accel: Add a helper to replay all
 STEs
Thread-Index: AQHdPJgyKY6/u6P9OEmczRngWut4HrbpB8sAgAAOiYA=
Date: Thu, 1 Oct 2026 17:14:15 +0000
Message-ID: <SJ0PR12MB86144A39CF7700D320626476AB8A2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-5-skolothumtho@nvidia.com>
 <b434ecce-ef8d-495d-b650-305a3bf66f83@redhat.com>
In-Reply-To: <b434ecce-ef8d-495d-b650-305a3bf66f83@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|PH8PR12MB7304:EE_
x-ms-office365-filtering-correlation-id: f3345724-6f6b-429f-4534-08df1fdf6bfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|10067099003|4143699003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: i6ddFbepF82v1OEYy/wavNhx509Yp65fI19WAJ8fTobVjoz/xS5e4loAdwqMk3o39kCL+e1nL7W7zUNME8NcFb6nibr4XdZUQyRvULS4FRAu6b1awV4+o+JKoreQi2vBFq+igJDuTk6kMOhKIjl6i13zjsOsianNbiZApshvTN6emeQBzw2oNPJlwYNjr5Jy625yBkQ6Z0Qsj3nRkpKj3OKBxg+FOalMyhPr01XXDsguUjrp8rCuQaEimDYyYinjJgwIySF/o0nNCt3LmYqc25LfPA4lpEAhMMhvx6rkv+N3/h+1uY0PJxLNwRxMpDKLp1HEM+WumNGuNEeivL/cfYodPdik9Xi0TY5WAtCHT9NcY01vObQhT4+DN8yKWYUEfNTS8C1DNkq3nmU2ZsWJdIsQSNC9FRO5XN9k2BImIF2e9+YebgCI5G3uhcubYlnp23HjxwTljDHlBCTn2QvNzebxliadKydlzRfSBfCC/9TyzevBkgZ2qkBMNnIFQdW5unrsr/N0t7MBa13dDsWjto0r7TvNJOXTm+h1Ol+Gvc2/d3LiuTHmGfiswNs6jucrOLMCH8lhYXeQm2ugXd+RjBRmGn/FUOD55j1IaBZBsKWr7GJ+uXwt4Rg3FGMw/0PTo8khrMKtQFUUlEkx01GNx2MssZ2xr4Gx8jk3GIgSZHcg7zoLVR4+X2yam3/2ucaHdNI9DICxvaJdVJwn63cNSD0xCuAR/Hfm2aSCVJ71d/M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azR5WnhaeitxdE9DVklsd2tBQW5nRGtwY1hrM2tNUHlvbis3MThCbms2dnI3?=
 =?utf-8?B?dUhxckM5RXgwU2FnM2dEMURGTFZ4NjFFQk9XL0xzV2c4cy9mRUoxUUZ0RGN1?=
 =?utf-8?B?N2gvNjNibDZUejk5OVhqbWNNVkhnTUE5VS83LzlTZ1g1aXY0QlpBcVo2cHdk?=
 =?utf-8?B?WUpxUVBsT0FDOVJ0c3dRTitKbkl6a2xFWUEyODRKNHNJaFFSazNjWVpzeUcy?=
 =?utf-8?B?V25zc3huOCtLdHBDNVlrblhKZ0dXQkI5dzBiOFA5cmpjSWZra2xTakFjSlJE?=
 =?utf-8?B?U0dqMlg0VU9CbzcrMzVZOXN6V2g2Q0hRQ3RBMzZMWUNvM1ZWR1hNdHVBVUEv?=
 =?utf-8?B?SnZmdVdlYWwrdmx1bVE0Zk9rcDM1UWpJTnJub0dQYzVYTjg4K3Z2T3orL3dr?=
 =?utf-8?B?ZkkyK2Nrb05yRklmNXpmWU1Xa1E3RlNHbTlPMGN2d0x2Zk9oeE5IbjIyWjFz?=
 =?utf-8?B?c1FvbVhHUmE2eEtiYWJnNDlyUUE4NHVLejZSeUZWdlZPcXRxYlJQM3M2NXFn?=
 =?utf-8?B?eVZ5UzkrOWMrZm5xQlRERWNNNVN6OHpVU1BTTGFxbnczS25mc3hzbVZ1c3Nw?=
 =?utf-8?B?L0FzNmE3amNXcXFzMERYZ0w3YWJLTmpnajNxTTcyVEJ4NDRzWXpwVkJzYWhw?=
 =?utf-8?B?WjJDTjJkUXFIdWlYZjM0MERZakNScDB3TkZtUHF2UkdpNW11SmFSa3p4RzJm?=
 =?utf-8?B?R2pmTmRVcDB2TUd6WTNoRjNSenp0RWhEMzVMV2sxcEwrKzhZeWgzYk84RWFX?=
 =?utf-8?B?bTlCQzl3dmwrT2pLOTZTa1crdXp1ZlhVWWlaU1ZjNzB6elBFb2lLZEp1THUx?=
 =?utf-8?B?elZ2c3hJNTRyaHh5NEV1Q2xFL0sxeXZ3NEx0M1FOKzg0aXdMWm1UZjBPbmR6?=
 =?utf-8?B?M2RsZUdMVGtZMzltZkZ6UEJGdWdyNkhCaTFBMVNWQ2ZtaVJqRmQ0bFFZUWF5?=
 =?utf-8?B?M3pSSXNtY0ovdUdQZFBiVER2QjFwcXVyMnpSK25FWXNZWndzamV6UmdEL1Ax?=
 =?utf-8?B?Qm9XRjg1blhnd01pMEJZdmJPSDV2TnZqM0trSUJmd2FtL3dGcSthZHU0TG1q?=
 =?utf-8?B?M2lMdGUwUHBNM0REeVVFL3FWWURLeEdlc0FDS1ZjSXgxUU9HUlREckgxZEd4?=
 =?utf-8?B?K0diOUV5NWJGVFFBall1c0lNVVduR0c3UHllaUFsV2N4aXhrM1JyYU16Y1V2?=
 =?utf-8?B?K0FjaUFCa29CMktsdzd6eWFBdkRWd3R2NVZvM2tPT2dlbFlIWTlJYkM4ZEEy?=
 =?utf-8?B?NVFJZm5CaG1OdWtlRjdYZTlkVGMvaG92cDA4d0JtRmVmSzVLZkxXaVpScmNT?=
 =?utf-8?B?SnVmYnV3N3pQdXVUWWd2RGJMcTBWNy9KWW1ma280OCt2dm1GTTVxemVIdmVh?=
 =?utf-8?B?M08rOXBuV0g3UHVvQVdPb0Vwck9sdEx6U3c1WWNvaFhhVStja0poMHo5RHNE?=
 =?utf-8?B?RmhWR2tPRUI0aVU5WEJZczNJMUFHUXdGY0pBcDNlR3RtSHNjbVpmcmVhUk5Y?=
 =?utf-8?B?VzRzQ05mamQ3MkhXRXRKZldFZjRNL2FqZDVkNkNBRGJ2ZVlldnE1TFhUQ25Y?=
 =?utf-8?B?M3luaHZXa0haam1IS0tldjZvdENZUUg2d2JNUkIyZkV5K2wyblJ6TmtFMldK?=
 =?utf-8?B?MEppMlM1U2R0QWRhOG5MNUhOaXV6SHpQNzdtc3htTnMwdDZORG5sYzBoeERp?=
 =?utf-8?B?U3BuRHVWVVJDS25OY3ZqeVI5WEdhaFBKUzlKbEVHQTg5Nlc1ZndvV3gwd3Na?=
 =?utf-8?B?dFZaRFN0K1pKUVBtQ1JpYyt4MTZrajZFN1huS1NUMnBaSTNyVCs3dzBaTmg5?=
 =?utf-8?B?WGt3WVJaRmJGdXZ1YThleXl4SHZCWll6L0RDN3RQQm96TDhyWTk2ZWpHYlpS?=
 =?utf-8?B?MUQxUDQrdUpXR2JISFl5YTFCRVRtR2RXQlhjM0ozcEdKak9LaEJHdmYwNjlY?=
 =?utf-8?B?Y0c2dlBOVUZheDJSZVhzYXVXTmZTenJqMVF6UE5FNlBaOTN0UVBTNGRDWTRE?=
 =?utf-8?B?S0w0dFBwVGJ0TVRhTzFhZStWaFJPUFJMNnVOaXhxU1drSXArTGRLckh0aVRK?=
 =?utf-8?B?czhkbG9ZNkxXd1hGeFI5V2JWNjc0by9HRk01bW10SzJHT0d6eFMrOC9jZVYx?=
 =?utf-8?B?bjlUajljTFZLb1JKRzQ5YTBZeFNHTmtGaHQvVHlWM01CbXRLT1RwdTVuREI4?=
 =?utf-8?B?ejhEYWNrWGdwWHMrMklQNlZKc09yQ3R2MlBtT01hbFFhamNOWWhsNjdYNGh3?=
 =?utf-8?B?RUNUUElSUStraFk2ZjBiOE93Sm52bDllVFdqdjhkSEpBajdzYnZJOGlYTGxX?=
 =?utf-8?B?Qm1TT1NFaXU2MXpkVTZSMWVqdzFoKytpVmZjM0VTUWJyUnUzcEFqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3345724-6f6b-429f-4534-08df1fdf6bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 17:14:15.9651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brAAi5SevCwPdI0ukvZz7WB3JNvKEGZTnK11fG6Bmmnx3WqcnXT8En0xggkJPTQVWS7vQcVobS4PL+KykbT4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDAxIE9jdG9iZXIgMjAyNiAxNzox
OA0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
OyBxZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT47IE5hdGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hz
QG52aWRpYS5jb20+OyBKaWFuZGkgQW4NCj4gPGphbkBudmlkaWEuY29tPjsgamdnQHppZXBlLmNh
OyBBbmtpdCBBZ3Jhd2FsIDxhbmtpdGFAbnZpZGlhLmNvbT47IEFuaWtldA0KPiBBZ2FzaGUgPGFu
aWtldGFAbnZpZGlhLmNvbT47IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1
bkBodWF3ZWkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDQvN10gaHcvYXJtL3NtbXV2
My1hY2NlbDogQWRkIGEgaGVscGVyIHRvIHJlcGxheQ0KPiBhbGwgU1RFcw0KPiANCj4gRXh0ZXJu
YWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+
IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gOS80LzI2IDg6MDUgUE0sIFNoYW1lZXIgS29sb3Ro
dW0gd3JvdGU6DQo+ID4gQWRkIHNtbXV2M19hY2NlbF9yZXBsYXlfc3RlcygpLiBJdCB3YWxrcyB0
aGUgZ3Vlc3Qgc3RyZWFtIHRhYmxlIGFuZCBjYWxscw0KPiA+IHNtbXV2M19hY2NlbF9pbnN0YWxs
X3N0ZSgpIGZvciBldmVyeSBkZXZpY2UgYmVoaW5kIGFuIGFjY2VsZXJhdGVkDQo+IFNNTVV2MywN
Cj4gPiB3aGljaCByZWJ1aWxkcyB0aGUgdkRFVklDRSBhbmQgdGhlIG5lc3RlZCBIV1BULiBUaGUg
aW5jb21pbmcgbWlncmF0aW9uDQo+IHBhdGgNCj4gPiB1c2VzIHRoaXMgaW5zdGVhZCBvZiB0cmFu
c2ZlcnJpbmcgcGVyIGRldmljZSBob3N0IHN0YXRlLCBhbGwgb2Ygd2hpY2ggY2FuDQo+ID4gYmUg
ZGVyaXZlZCBmcm9tIGd1ZXN0IFJBTSBvbmNlIHN0cnRhYl9iYXNlIGFuZCBDUjAgYXJlIHJlc3Rv
cmVkLg0KPiA+DQo+ID4gTm8gY2FsbGVyIHlldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBo
dy9hcm0vc21tdXYzLWFjY2VsLmggICAgICAgfCAgMSArDQo+ID4gIGh3L2FybS9zbW11djMtYWNj
ZWwtc3R1YnMuYyB8ICA1ICsrKysrDQo+ID4gIGh3L2FybS9zbW11djMtYWNjZWwuYyAgICAgICB8
IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCA0MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5oIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQo+ID4gaW5kZXggYTkxZDE4OGQ2MS4u
MjQ4MjhiYTlhYiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmgNCj4gPiAr
KysgYi9ody9hcm0vc21tdXYzLWFjY2VsLmgNCj4gPiBAQCAtOTIsNiArOTIsNyBAQCBib29sIHNt
bXV2M19hY2NlbF9pbnN0YWxsX3N0ZShTTU1VdjNTdGF0ZSAqcywNCj4gU01NVURldmljZSAqc2Rl
diwgaW50IHNpZCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKTsNCj4gPiAgYm9vbCBzbW11djNfYWNjZWxfaW5zdGFsbF9zdGVfcmFuZ2UoU01NVXYzU3Rh
dGUgKnMsIFNNTVVTSURSYW5nZQ0KPiAqcmFuZ2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+ID4gK2Jvb2wgc21tdXYzX2FjY2VsX3Jl
cGxheV9zdGVzKFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApOw0KPiA+ICBib29sIHNtbXV2
M19hY2NlbF9hdHRhY2hfZ2JwYV9od3B0KFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApOw0K
PiA+ICBib29sIHNtbXV2M19hY2NlbF9pc3N1ZV9pbnZfY21kKFNNTVV2M1N0YXRlICpzLCB2b2lk
ICpjbWQsDQo+IFNNTVVEZXZpY2UgKnNkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1h
Y2NlbC1zdHVicy5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC1zdHVicy5jDQo+ID4gaW5kZXggYjU3
YjVjMDFlNy4uMDUxNDkxNWU0NSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2Vs
LXN0dWJzLmMNCj4gPiArKysgYi9ody9hcm0vc21tdXYzLWFjY2VsLXN0dWJzLmMNCj4gPiBAQCAt
MjgsNiArMjgsMTEgQEAgYm9vbCBzbW11djNfYWNjZWxfaW5zdGFsbF9zdGVfcmFuZ2UoU01NVXYz
U3RhdGUNCj4gKnMsIFNNTVVTSURSYW5nZSAqcmFuZ2UsDQo+ID4gICAgICByZXR1cm4gdHJ1ZTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gK2Jvb2wgc21tdXYzX2FjY2VsX3JlcGxheV9zdGVzKFNNTVV2M1N0
YXRlICpzLCBFcnJvciAqKmVycnApDQo+ID4gK3sNCj4gPiArICAgIHJldHVybiB0cnVlOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICBib29sIHNtbXV2M19hY2NlbF9hdHRhY2hfZ2JwYV9od3B0KFNNTVV2
M1N0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ID4gIHsNCj4gPiAgICAgIHJldHVybiB0cnVlOw0K
PiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFj
Y2VsLmMNCj4gPiBpbmRleCAyODdlYTkxZmJlLi42Njc4ZTQ5ZjZlIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0K
PiA+IEBAIC00MDcsNiArNDA3LDQwIEBAIGJvb2wNCj4gc21tdXYzX2FjY2VsX2luc3RhbGxfc3Rl
X3JhbmdlKFNNTVV2M1N0YXRlICpzLCBTTU1VU0lEUmFuZ2UgKnJhbmdlLA0KPiA+ICAgICAgcmV0
dXJuIGFsbF9vazsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIEluc3RhbGwgdGhlIFNU
RSBhZ2FpbiBmb3IgZXZlcnkgZGV2aWNlIGJlaGluZCB0aGlzIGFjY2VsZXJhdGVkIFNNTVV2MywN
Cj4gYnkNCj4gPiArICogcmVhZGluZyB0aGUgZ3Vlc3Qgc3RyZWFtIHRhYmxlIG9uY2UgbW9yZS4g
U3RvcHMgYXQgdGhlIGZpcnN0IGZhaWx1cmUuDQo+ID4gKyAqLw0KPiA+ICtib29sIHNtbXV2M19h
Y2NlbF9yZXBsYXlfc3RlcyhTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiA+ICt7DQo+
ID4gKyAgICBFUlJQX0dVQVJEKCk7DQo+ID4gKyAgICBTTU1VdjNBY2NlbFN0YXRlICphY2NlbCA9
IHMtPnNfYWNjZWw7DQo+ID4gKyAgICBTTU1VdjNBY2NlbERldmljZSAqYWNjZWxfZGV2Ow0KPiA+
ICsNCj4gPiArICAgIGlmICghYWNjZWwgfHwgIWFjY2VsLT52aW9tbXUpIHsNCj4gPiArICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBRTElTVF9GT1JFQUNI
KGFjY2VsX2RldiwgJmFjY2VsLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0KPiBXaGF0IGlmIHlvdSBo
YXZlIGRpZmZlcmVudCBkZXZpY2UgdG9wb2xvZ3kgb24gc3JjIGFuZCBkZXN0LiBJcyBpdCBkZXRl
Y3RlZD8NCg0KTm90IGJ5IHRoaXMgaGVscGVyLiBIb3dldmVyLCBJSVVDLCBWRklPIHJlZ2lzdGVy
cyBpdHMgc2F2ZXZtIGhhbmRsZXIgdW5kZXINCnRoZSBxZGV2IHBhdGgsIHNvIGEgZGV2aWNlIHRo
YXQgaXMgbm90IGF0IHRoZSBzYW1lIHBsYWNlIG9uIHRoZSBkZXN0aW5hdGlvbg0KZmFpbHMgdGhl
IGxvYWQgYXQgdGhlIHN0YXJ0IG9mIHRoZSBzdHJlYW0sIGJlZm9yZSB3ZSBnZXQgaGVyZS4NCg0K
VHJpZWQgaXQgd2l0aCB0aGUgZGV2aWNlIHVuZGVyIGEgZGlmZmVyZW50IHJvb3QgcG9ydCBvbiB0
aGUgZGVzdGluYXRpb246DQoNCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IFVua25vd24gc2VjdGlvbiBv
ciBpbnN0YW5jZSAnMDAwMDowMTowMS4wOjAwLjA6MDAuMC92ZmlvJyAwLg0KTWFrZSBzdXJlIHRo
YXQgeW91ciBjdXJyZW50IFZNIHNldHVwIG1hdGNoZXMgeW91ciBzYXZlZCBWTSBzZXR1cCwgaW5j
bHVkaW5nIGFueSBob3RwbHVnZ2VkIGRldmljZXMNCg0KQW4gZXh0cmEgZGV2aWNlIG9uIHRoZSBk
ZXN0aW5hdGlvbiBpcyBub3QgZGV0ZWN0ZWQuIFRoZSBndWVzdCBoYXMgbm8gU1RFDQpmb3IgaXQs
IHNvIHRoZSByZXBsYXkgc2tpcHMgaXQgYW5kIGl0IHN0YXlzIG9uIHRoZSBHQlBBIEhXUFQsIHNh
bWUgYXMNCmJlZm9yZSB0aGUgZ3Vlc3QgZHJpdmVyIHRvdWNoZXMgaXQuIFRoZSB1c3VhbCBydWxl
IGFwcGxpZXMsIHRoZSBjb21tYW5kDQpsaW5lcyBoYXZlIHRvIG1hdGNoLiANCg0KPiA+ICsgICAg
ICAgIHVpbnQzMl90IHNpZCA9IHNtbXVfZ2V0X3NpZCgmYWNjZWxfZGV2LT5zZGV2KTsNCj4gPiAr
ICAgICAgICBTTU1VRXZlbnRJbmZvIGV2ZW50ID0gey50eXBlID0gU01NVV9FVlRfTk9ORSwgLnNp
ZCA9IHNpZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5pbnZhbF9zdGVf
YWxsb3dlZCA9IHRydWV9Ow0KPiA+ICsgICAgICAgIFNURSBzdGU7DQo+ID4gKw0KPiA+ICsgICAg
ICAgIC8qIFNraXAgYSBkZXZpY2UgdGhlIGd1ZXN0IGhhcyBub3QgcHJvZ3JhbW1lZCAqLw0KPiA+
ICsgICAgICAgIGlmIChzbW11X2ZpbmRfc3RlKHMsIHNpZCwgJnN0ZSwgJmV2ZW50KSkgew0KPiA+
ICsgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgIGlmICghc21tdXYzX2FjY2VsX2luc3RhbGxfc3RlKHMsICZhY2NlbF9kZXYtPnNkZXYsIHNp
ZCwgZXJycCkpIHsNCj4gPiArICAgICAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAiRGV2aWNl
IDB4JXg6IEZhaWxlZCB0byBpbnN0YWxsIFNURTogIiwgc2lkKTsNCj4gbWF5YmUsIGZyb20gYSB1
c2VyIHBvaW50IG9mIHZpZXcgaXQgaXMgbm90IG9idmlvdXMgd2h5IHdlIGdldCB0aGlzIGVycm9y
DQo+IGFzIG1pZ3JhdGlvbiBsb2FkIGlzIG5vdCBtZW50aW9ubmVkLg0KDQpPaywgd2lsbCByZXdv
cmQuDQoNClRoYW5rcywNClNoYW1lZXINCg0K

