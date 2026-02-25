Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B77EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB9o-0008DS-HX; Wed, 25 Feb 2026 04:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvB9k-000897-Fg; Wed, 25 Feb 2026 04:26:08 -0500
Received: from mail-southcentralusazon11011063.outbound.protection.outlook.com
 ([40.93.194.63] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvB9h-0004Dc-G1; Wed, 25 Feb 2026 04:26:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXIbW2ZhFcqWB/zNjW6XYP0WpyvuAxoW6ZtbcrW5woZEgVP0QAdh95QcOfYwy/1f30PTUYKuB1Isfrv7HGNfJfGCP5bjpdymcP6TU6mAeHp2L+sg72U3+WIw1j/aVJJtpToOXhYod3ktl5xboUdyF7fwzxsb1xd+mlhOr5rvQ+Um8LjaadmZUSvBim9s36CuAepRLOgsPyiRE9XcsiJm+qSg3ixp07xdvw8bHUBFjs1DjHVPMDm+FgLabek+NAnvYiYPpdgZvJO6iemKKRLkq0j6AhHr+/bw2eMYJ5f/qZyXXqfyCYlYJTlifpNTLLiAD2yH3waCu+VJjMIIiFwKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItHPhNLVKLteEB6W0T3sw7LqECLHPTvFFpHRJ7GY+uY=;
 b=XCUucGFuXa+hoAi4hbp23gjVoMiW6bIdgDNCe1bbLs1qItr/ixFvfBNjZ7q8YaqPRWHP4TJkS33T6786DX1SKHZTFz1O92IsFVhJAwlBwJycBTXpOZGLsUJPWpcT7CGQJDWUqo2os5aCTNZnKgguNNBaVQbgfyrnmi5AtYYxFlLBtHIH3kr/AWK2ueFbpIa03yvlO4pj2oWtXwCBIO9uzEpUpDxZQAls6d/QPB1lZt2Vnp1wZxMmh+dX3nUI9Z5Rv46EHoKMdyiJQEeUKjkC8fi0EH+XQG4pwAQ+mTXXAHkmW0G0nLZ1/tIILNTHl2ceP1GNtbCl87wx7A5G6dmxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItHPhNLVKLteEB6W0T3sw7LqECLHPTvFFpHRJ7GY+uY=;
 b=gpkRez/Bo3U9QIusLjuIewuDhMXPpFO8Yc+Z2IzP4WDD6aY5vQrqrBDUKFK8YoDRyTjrwwtdcPVt3jctUgiW04XPgsuNzbKwv9kKnhRAigvjlMz79HSR0HIYMJIeLZXuWsnaSSzJSs3xN2i2KE6pmtvRP00YMjYmMNbfscNrsUVdQqBaQXoih9dYfmcQa1KGo4626KqLlwaKk5cRfw1OU1/fw+YXkAdBIl0V9EjMMFZKaYoDfq96uF4daB+b0a3iT32qdc0ckG8Gwg/2pF2CLKBGz3Ojymy6EI9qYG7qZQoDKgK4XQ6h5O+EbfpknwgSX5ekNhuyLMKyK+4MwMVOFA==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:20:58 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:20:58 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH 1/3] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/
 header
Thread-Topic: [PATCH 1/3] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/
 header
Thread-Index: AQHcpgU+kGQYmh8qRkaEtAnpnuyx7rWTFufQ
Date: Wed, 25 Feb 2026 09:20:58 +0000
Message-ID: <IA0PR12MB7555FC2C448B36354AF4FD6BAB75A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260225031658.32095-1-philmd@linaro.org>
 <20260225031658.32095-2-philmd@linaro.org>
In-Reply-To: <20260225031658.32095-2-philmd@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DM6PR12MB4297:EE_
x-ms-office365-filtering-correlation-id: c85c361b-4adf-445c-fc03-08de744f2fac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: s47Gdvsv/AK17cjQpBXWUfSeBtU2Zk3npd2/bqgIwsIG8WkdsigJfFabln+0PIv6VttbeoDS//65TP0mud1wmgvJSoWGv8tQhsmSmk26p3QlBR5lSYgSYHpz6ZiZQQw68rXdSROtdGVyZ3dLdndMOD8CHvDE/IemmDlBYd7hPC7ZBIYxNHiAaZH/SrjRIXAbE4Qe9lgrKAVJ+cKgz90WeNMog8oJNFmNl9ZL0Hpx97A1q+4yHegRwMThjWKlQBX75QaXnTv9VsOxc3uTnW2lasfRImhxf9y/X+BiXZ3A+phggU8Y8dwmTjrsxl8EVVK4/g7myTaIAiHhGDGzp8gtAkBI+UlDc4VslWYHZj4+RN6n/zNpcdr4bbOy1qLiO9H55l24iji5TTUlq3YkRvipTPcyznCgFH7c8faHMx4tmIWL/eNkm7RNBcZ6br16SKLEcVLUEieuhWoEp4UnShtjBckbpESTZoGr/kuLaeTKads3nnfYBDT86LBJmsiA3I21q+ET+htYObdJ4tZ+CEpUJXpxD1He5cslGahuyr4rNp4GJmGfb4zkNSf5lRs9PJf9X31FhRrTEDHnk5R9M+g7Ud+1LstWDCk6uW1FJck0HN6O1UCP+jT1m07TTQqdEHxWkX2eGwBzrYAd2tsYPkOyIru11M44Ju5GOYwkLiWXb7WEQ5Z9yhTPfY7ol/nUi+fTwK3IsH7XL9Cy2udGiC3WCUhJVgIu2GLWHWgWa46kI8Zl6ahZnvbb/vwBy9oZyyCzByXC+2nSa7ncuXeDu7UNyf/RU3AIusdtR4Q9xg3lxew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUZwRUVzS3JMOFZXSFRqTGdiUys4TEhER0VHdU5hajQxdTJjR0pBTUZ0cFUw?=
 =?utf-8?B?MldXSnE1MDNKMjlOOTg1elNHWDdTaVp2RUQ3WmIyWWZvK1FzZVZyOVllYmFq?=
 =?utf-8?B?R1hxNDhZbU1pbG4xOTdMWWlNT0kvOVNUR2NKdmNad2prTUJ2eHJQZnlqcUlV?=
 =?utf-8?B?TVZVUEFMaGtKSzZDYmdWMWFobW5DRzBVTVRHbFhPcGtvQWpPaXNIbTNYOVA4?=
 =?utf-8?B?VUJUamJsWlk5NVlYSXhCNGNENzhQNXJlZW5aTmJTQjZKOGpHY2VlVFpSd2do?=
 =?utf-8?B?YndrYm1qM0dDNjEvVGVqUlZMMVFLUENWWlJvdGFnUVVUMVYzUHoyTStPL1Br?=
 =?utf-8?B?MmVucEhHUzQwaXh1LzFjWFpBcTVzeldlOXd5S2poYVhCcXV1Q3ZuNmsyWjUw?=
 =?utf-8?B?WnlWeTZDcUVwSEpiQ05JV256RlRNVGRxejBVK3h3dmQvWDQwNmxya2JKWFd6?=
 =?utf-8?B?eFpjRzN2VEpXMkEzUi8vUlFVUXFOdXlyZnZKZnVod0xKbXJWc3UxMDdkdVYv?=
 =?utf-8?B?MXpLSDd1Ums4U05DdWdza2U3cjZDVFNXUWpZK09teEtQK3JubnRDMXphcEVw?=
 =?utf-8?B?eDlYUGY3L2IwZXdVSHIza0hvWjM2Q3Y0dnU1S2pjOFZUTlJwTWpiQ20xZk9k?=
 =?utf-8?B?Tmhsb3gxU0FSN2gzb0hkaXVuOHVRN3FKaGNBSWNtazUxWXdhdFlnVVNFNHhU?=
 =?utf-8?B?aExwVjZZWkZhZ0dPeGdGcWp0ekRuTFhDNk8yOVAvcWdEM0NrUUhrU1l4RFpr?=
 =?utf-8?B?MjlCTVZmbmpybi9wNGY5eUpNZEVoRzg4YWRIb3ZEMmZMajNGeGViYkp5TXRK?=
 =?utf-8?B?WW1mWDc0bmpzZWtPV1pwYjgyeFNmVnBFMk1tTmQ3dTI3YXQxMG81bzY0SHVt?=
 =?utf-8?B?QWkxNDF4b0RkVHRZS3dvUzlzUFhvbjhGOUhwbGtwSkhtbjNjdXNDeEc4OHFZ?=
 =?utf-8?B?Sk5hN0RnVjYxSHR5N2hEUklkblNlSWd0bnc2SGZ0RVRsUTI2VVBOUFltM2FJ?=
 =?utf-8?B?TFI2dWRJUjJSR3hzVWYyRm5qRlhzbDFtKzJEampTM2FpVjRLYlZrU2E0T0Jv?=
 =?utf-8?B?S0plYXBqNmhLVjJlRnZ2dW0weXhzUGZQbVZmZ3hiM3VOOGMzWHhBdEpaSWVS?=
 =?utf-8?B?cFhkOXNwSmRqS2I0QXFoSkNHMUtTWkVqZXJRa0RNTnFhSUtjUTBWcjBJOUk1?=
 =?utf-8?B?UkNNYzlSZkx3OFp1TTRKYmpNRHppOTZrbytJMXNsSENEZDFoTS9jYWN4UTA4?=
 =?utf-8?B?OGM1cWdWN29IWUJvcUlLYm11dHVwSFF6YmZtYnRWSnBadE05cmtEdE5qSktZ?=
 =?utf-8?B?cjV2Q3F1R1RnUGRoTmlOeDhITXY0UW4rWTg2Vm5QdDdZSFMzdlJvWHJFREZi?=
 =?utf-8?B?YWltNGF0bVJJUy9jSEpZOHdkUGJScnZseXU3Zjc5cnkyWVpRK2lwK29aclNt?=
 =?utf-8?B?c0VrVEgyN2NIdVlXc3ZQOWFOb3FWZ3YzelExRlhiTW1oZlJ4blZ1ampNQkx6?=
 =?utf-8?B?NExSVFF1MVpNMnBySS83cHhFaGh6bjZjcSs4TFF1NUt1a2tzdFVXeEJJaS8z?=
 =?utf-8?B?SGRKRFlKMGlqcnQ3Q205cXVaSFVyRkp5eTZwWWErUVZZNnhUcFBmK3piMW03?=
 =?utf-8?B?UUFxVEVCMzZscTRRUC9BaFVoL2JYMFNvTmd0NXVJbjl5dWkwL0ZuakxDLzVr?=
 =?utf-8?B?VE05TS9PSWxlU25KU3gvS0c1QTZldDhNZVdzVmM0ODcrK2FFcENRNG9pTFE4?=
 =?utf-8?B?Q05KMWdDZkx0ekV5djlQSTZmS2g0VmtPV0t6T0ZWVENFTVMyOUxLR0FYYlp0?=
 =?utf-8?B?bHRlczArNmE1VS9lSEM1VUJURUNGSExFMFZjU0QxcDdiQTBmcWV2KzljdlVW?=
 =?utf-8?B?SEJJMEttZE5iWC9JVTY0Rm9tdTRZYlNaNmI4dUxBUEhPNlhTSk00V1ZldzZx?=
 =?utf-8?B?a2dkMk9VeW0wUzE5V3liTFJsclVMZ3hoM0NGMWdjRVlCMU9CcXA3Y2FjbGZJ?=
 =?utf-8?B?TGNnZkQxd2M0TlpjNklrZlgvNXNJbDEreG1BRlZMdzBZUm14VlJsbnN0VHNw?=
 =?utf-8?B?S3dXZG9wYS9nTEdhc0lsVlJQd2hDUzZhRlE0STRsRkZPOVliSGE0NEJ0cEJI?=
 =?utf-8?B?RmlXK3pxYTJINmthUnhCTWhHVE9aQmI0YUVPd0NBbWJabC9OamprcHMvY2VC?=
 =?utf-8?B?dFk3MFFUTU1HL3NrN3ZuV3lYQ0pqZXhNcnA4QkRTb29RMTVKVFRKN0YrQlR3?=
 =?utf-8?B?WDVsYkdVdzRnS3lvZDA4dWJEanZMU2Z0M2lmRENIOW53dUo5RG5PU3lhUjh2?=
 =?utf-8?B?bGZPait6UDJGQmwvcGpmYjZXTmY1cUVQNlpnR2ZtSk9VOXVuT1UrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85c361b-4adf-445c-fc03-08de744f2fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 09:20:58.3801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: la+7bEdCmvt/w6pVKkw0Lhb7dskwpOJaR51XViUO4TcfDHO7XPwU2T+zqZISc1KffSrDDfj3w14y/cGMKxsU1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Received-SPF: permerror client-ip=40.93.194.63;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyNSBGZWJydWFyeSAyMDI2IDAz
OjE3DQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+OyBUaG9tYXMgSHV0aA0KPiA8dGh1dGhAcmVkaGF0LmNvbT47IHFl
bXUtczM5MHhAbm9uZ251Lm9yZzsgUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPjsgU2hhbWVlciBLb2xvdGh1bSBUaG9kaQ0KPiA8c2tvbG90aHVtdGhvQG52
aWRpYS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBQaGlsaXBwZSBNYXRoaWV1LQ0KPiBEYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgRXJpYw0KPiBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMS8zXSBody9hcm0vc21tdXYzOiBBdm9pZCBpbmNsdWRpbmcgQ09ORklHX0RFVklD
RVMgaW4NCj4gaHcvIGhlYWRlcg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9w
ZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBCeSBpbmxpbmluaW5nIHRoZSBz
dHVicyB3ZSBjYW4gYXZvaWQgdGhlIHVzZSBvZiB0YXJnZXQtc3BlY2lmaWMNCj4gQ09ORklHX0RF
VklDRVMgaW5jbHVkZSBpbiBhIGh3LyBoZWFkZXIsIGFsbG93aW5nIHRvIGJ1aWxkIHRoZQ0KPiBz
b3VyY2UgZmlsZXMgaW5jbHVkaW5nIGl0IGFzIGNvbW1vbiBvYmplY3RzLg0KDQpUaGFua3MuDQoN
Ckhvd2V2ZXIsIHNtbXV2My5jIGN1cnJlbnRseSBoYXMgYToNCiNpZm5kZWYgQ09ORklHX0FSTV9T
TU1VVjNfQUNDRUwNCmluIHNtbXVfdmFsaWRhdGVfcHJvcGVydHkoKS4NCg0Kd2hpY2ggbGVhZHMg
dG8gdGhlIGJ1aWxkIGZhaWx1cmUgYmVsb3c6DQoNClszMC8xOTVdIENvbXBpbGluZyBDIG9iamVj
dCBsaWJzeXN0ZW1fYXJtLmEucC9od19hcm1fc21tdXYzLmMubw0KRkFJTEVEOiBsaWJzeXN0ZW1f
YXJtLmEucC9od19hcm1fc21tdXYzLmMubw0KLi4uDQoNCi4uL2h3L2FybS9zbW11djMuYzogSW4g
ZnVuY3Rpb24g4oCYc21tdV92YWxpZGF0ZV9wcm9wZXJ0eeKAmToNCi4uL2h3L2FybS9zbW11djMu
YzoxOTM5Ojk6IGVycm9yOiBhdHRlbXB0IHRvIHVzZSBwb2lzb25lZCAiQ09ORklHX0FSTV9TTU1V
VjNfQUNDRUwiDQogMTkzOSB8ICNpZm5kZWYgQ09ORklHX0FSTV9TTU1VVjNfQUNDRUwNCiAgICAg
IHwgICAgICAgICBeDQoNCk9uZSB3YXkgdG8gZml4IHRoaXMgaXMgdG8gcmVtb3ZlIHRoZSBDT05G
SUdfIGNoZWNrIGZyb20gc21tdXYzLmMNCmFuZCByZWx5IG9uIHRoZSBzdHViIGltcGxlbWVudGF0
aW9uIGZvciBzbW11djNfYWNjZWxfaW5pdCAoKSBpbnN0ZWFkOg0KDQpkaWZmIC0tZ2l0IGEvaHcv
YXJtL3NtbXV2My1hY2NlbC5oIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQppbmRleCA3ZTQ4ZDE1
NTVkLi5hMjI0MDE3YzZjIDEwMDY0NA0KLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQorKysg
Yi9ody9hcm0vc21tdXYzLWFjY2VsLmgNCkBAIC0zOSw3ICszOSw3IEBAIHR5cGVkZWYgc3RydWN0
IFNNTVV2M0FjY2VsRGV2aWNlIHsNCiAgICAgU01NVXYzQWNjZWxTdGF0ZSAqc19hY2NlbDsNCiB9
IFNNTVV2M0FjY2VsRGV2aWNlOw0KDQotdm9pZCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0
ZSAqcyk7DQorYm9vbCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKipl
cnJwKTsNCiBib29sIHNtbXV2M19hY2NlbF9pbnN0YWxsX3N0ZShTTU1VdjNTdGF0ZSAqcywgU01N
VURldmljZSAqc2RldiwgaW50IHNpZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApOw0KIGJvb2wgc21tdXYzX2FjY2VsX2luc3RhbGxfc3RlX3JhbmdlKFNNTVV2
M1N0YXRlICpzLCBTTU1VU0lEUmFuZ2UgKnJhbmdlLA0KZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11
djMtYWNjZWwtc3R1YnMuYyBiL2h3L2FybS9zbW11djMtYWNjZWwtc3R1YnMuYw0KaW5kZXggYjY0
ZjFlNGQ5My4uYzA4Y2FhNmZhNCAxMDA2NDQNCi0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwtc3R1
YnMuYw0KKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC1zdHVicy5jDQpAQCAtOCw4ICs4LDEwIEBA
DQogI2luY2x1ZGUgImh3L2FybS9zbW11djMuaCINCiAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My1h
Y2NlbC5oIg0KDQotdm9pZCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAqcykNCitib29s
IHNtbXV2M19hY2NlbF9pbml0KFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApDQogew0KKyAg
ICBlcnJvcl9zZXRnKGVycnAsICJhY2NlbD1vbiBzdXBwb3J0IG5vdCBjb21waWxlZCBpbiIpOw0K
KyAgICByZXR1cm4gZmFsc2U7DQogfQ0KDQogYm9vbCBzbW11djNfYWNjZWxfaW5zdGFsbF9zdGUo
U01NVXYzU3RhdGUgKnMsIFNNTVVEZXZpY2UgKnNkZXYsIGludCBzaWQsDQpkaWZmIC0tZ2l0IGEv
aHcvYXJtL3NtbXV2My1hY2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQppbmRleCBmNWNk
NGRmMzM2Li5lZDY0N2M0NWI4IDEwMDY0NA0KLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQor
KysgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCkBAIC03NTgsMTEgKzc1OCwxMiBAQCBzdGF0aWMg
dm9pZCBzbW11djNfYWNjZWxfYXNfaW5pdChTTU1VdjNTdGF0ZSAqcykNCiAgICAgYWRkcmVzc19z
cGFjZV9pbml0KHNoYXJlZF9hc19zeXNtZW0sICZyb290LCAic21tdXYzLWFjY2VsLWFzLXN5c21l
bSIpOw0KIH0NCg0KLXZvaWQgc21tdXYzX2FjY2VsX2luaXQoU01NVXYzU3RhdGUgKnMpDQorYm9v
bCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KIHsNCiAg
ICAgU01NVVN0YXRlICpicyA9IEFSTV9TTU1VKHMpOw0KDQogICAgIHMtPnNfYWNjZWwgPSBnX25l
dzAoU01NVXYzQWNjZWxTdGF0ZSwgMSk7DQogICAgIGJzLT5pb21tdV9vcHMgPSAmc21tdXYzX2Fj
Y2VsX29wczsNCiAgICAgc21tdXYzX2FjY2VsX2FzX2luaXQocyk7DQorICAgIHJldHVybiB0cnVl
Ow0KIH0NCmRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLmMgYi9ody9hcm0vc21tdXYzLmMNCmlu
ZGV4IGMwOGQ1OGM1NzkuLjhjNTE1NTRjMzkgMTAwNjQ0DQotLS0gYS9ody9hcm0vc21tdXYzLmMN
CisrKyBiL2h3L2FybS9zbW11djMuYw0KQEAgLTE5MzYsMTMgKzE5MzYsNiBAQCBzdGF0aWMgdm9p
ZCBzbW11X3Jlc2V0X2V4aXQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0KDQogc3RhdGlj
IGJvb2wgc21tdV92YWxpZGF0ZV9wcm9wZXJ0eShTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJw
KQ0KIHsNCi0jaWZuZGVmIENPTkZJR19BUk1fU01NVVYzX0FDQ0VMDQotICAgIGlmIChzLT5hY2Nl
bCkgew0KLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiYWNjZWw9b24gc3VwcG9ydCBub3QgY29t
cGlsZWQgaW4iKTsNCi0gICAgICAgIHJldHVybiBmYWxzZTsNCi0gICAgfQ0KLSNlbmRpZg0KLQ0K
ICAgICBpZiAoIXMtPmFjY2VsKSB7DQogICAgICAgICBpZiAoIXMtPnJpbCkgew0KICAgICAgICAg
ICAgIGVycm9yX3NldGcoZXJycCwgInJpbCBjYW4gb25seSBiZSBkaXNhYmxlZCBpZiBhY2NlbD1v
biIpOw0KQEAgLTE5OTYsNyArMTk4OSw5IEBAIHN0YXRpYyB2b2lkIHNtbXVfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZCwgRXJyb3IgKiplcnJwKQ0KICAgICB9DQoNCiAgICAgaWYgKHMtPmFjY2VsKSB7
DQotICAgICAgICBzbW11djNfYWNjZWxfaW5pdChzKTsNCisgICAgICAgIGlmICghc21tdXYzX2Fj
Y2VsX2luaXQocywgZXJycCkpIHsNCisgICAgICAgICAgICByZXR1cm47DQorICAgICAgICB9DQog
ICAgICAgICBlcnJvcl9zZXRnKCZzLT5taWdyYXRpb25fYmxvY2tlciwgIk1pZ3JhdGlvbiBub3Qg
c3VwcG9ydGVkIHdpdGggU01NVXYzICINCiAgICAgICAgICAgICAgICAgICAgImFjY2VsZXJhdG9y
IG1vZGUgZW5hYmxlZCIpOw0KICAgICAgICAgaWYgKG1pZ3JhdGVfYWRkX2Jsb2NrZXIoJnMtPm1p
Z3JhdGlvbl9ibG9ja2VyLCBlcnJwKSA8IDApIHsNCg0KVGhhbmtzLA0KU2hhbWVlcg0K

