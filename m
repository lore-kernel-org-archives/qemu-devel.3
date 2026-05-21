Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D0CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzzQ-0006G8-2J; Thu, 21 May 2026 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPzzN-0006FP-Lh; Thu, 21 May 2026 05:46:49 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPzzL-0001zt-8p; Thu, 21 May 2026 05:46:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOmI7HdMMKsseGrbxxcDfSaEE5bG0rchJqhVkRl/InoUSZrER1MbBLH9UthKSqj+OA+PVxiBVqv3g4kuDaLENz5A5VUlTkSduSuVM/g81MWGtSx06tZW4br+Xgd0jwZ8EcpHIyJosOvh9PUhPJCN6ewL6/Y8bkiRpxdEO4y6OR03MMnOQKzWk50IGF7AIVZiJ9qtiUY+NnW/VwvBwicj5Nu6COmk0HQoqdu3mXTd7hTZGGIzhHGWKb6BQ29TZ9xhMwIao7i6ACXuz+u+na+Pm8b84Shcs6uKWC/ZvdHgg1PED//BtwRl5DgKTzvLL+YL31XKqep4ISGJJ1ce9l4fRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7R56JDcS0emm4WD7PdKxVpcRqFIGRllpoBRkU7ouus=;
 b=h49AWE3o1/iZONKCIClvmWM6c86GGcFrS2DHm1Biu1v4neVWE8ammjmad+3rRdTnAAQ0XITFTH7jxGab5FRQlQWSQfcp+u5jtGucDgMTaKg6s22BxUsm7VKgEy2TKDm/lKiTs0Y//DvB4sLRQ+zl0liA2ixOTvtmss2I/HutbVYjIKyndfXa4D19+z6fOJMRefki9ipLF74JWCN/rhxT/QsHqNyY8mVifpXH5Ud9Kk93szQ/AfxyXhbA1ZykEhRErNkoOWDIKbdLxQN7iyFhLkvfWOW5pmGxmtTVYelk1X32zy08QMLgxy6fTGsamKuFcypG/+D7ZfhPOp0pOWHWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7R56JDcS0emm4WD7PdKxVpcRqFIGRllpoBRkU7ouus=;
 b=IAgmqliCzWbLj83gsKGwZ+g+tkCnWnqrR+fYHQwwJPyOllFL/e1c6UKL+kK3RspR+XFgNS98istpKq8yLcfDXsJqGoZwk3izJe7rgQwM0b1AQQRKeJDavxeuSGIU2x8Cj9T15jbh/w8dndD5A+114u0xPjYnVjIEUe7KkvzZ+8Ssl5LjfDFXKIXPUlnxFd0mHnwh62dofm62mvBIvqNXtyVtGA9LH1cpU9wqdiggVNl0YYPAv0TredWHWAEaby3+27pwnuWV1v4eV1N0ZW6Ykc33TOO7WG4g7uYivhSilFwPIEpn9sYYeQ/y5rr+xm2ZDMEr+kP2vvz7kt9ltUd/zQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:46:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:46:40 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex@shazbot.org"
 <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v5 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
Thread-Topic: [PATCH v5 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
Thread-Index: AQHc53vA7cuN+dC5qUiPYNuslWkVpbYYJdmAgAAYBiA=
Date: Thu, 21 May 2026 09:46:40 +0000
Message-ID: <CH3PR12MB75489202DF9ABAC1F2A0A34CAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-12-skolothumtho@nvidia.com>
 <4a2e8fe9-b20a-421d-adaf-8d8cbb270c44@redhat.com>
In-Reply-To: <4a2e8fe9-b20a-421d-adaf-8d8cbb270c44@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS0PR12MB8072:EE_
x-ms-office365-filtering-correlation-id: f7122a65-20d9-4eb2-b445-08deb71ddc19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099003|18002099003|22082099003|4143699003|6133799003|38070700021;
x-microsoft-antispam-message-info: ZTwN7oo3WaSJQAZDaQfxGKz3YDexcEdxeSdo2csPRlZg3OjI1W5a3XscZQiD4VADP7v73H+zuwoBsQyLSia3cEtARGK981EPOH2HYpSxrTqgqzjkYXbQegkukI9BK73QUrZCH1x4HmC6k7DRBr54WSB36oidDR6dhLjtO6Ftcg/CEjjpO/hxeFC+bH/AJY3n7r/tS031hYi6n1P9JTiB1E5T9q35LEhIX7nngS4BlJO5DSqToLmefafPnlxdzONXyHaNgtvUDOpAIHaQ8I1TqE7NClYQBUxxt5qmaw2/yhThjcKU90NnhbtPt456Fwha+LgAVmBrD4ZeDwv6FPyKXDfOAsE+MNfyboXFWYyqYR3KwJ9UA1h4qrx9SmSf6Vc1efbY/pvh2LYvUdv4WrDvLOXvF+T43XYcAHHavo/TS+MmBcfvsMQHLKpVcQ37ynzh4OeQYG+VFaQPuvwZhINQVGoNXi9UbxcP+zmGSNoSri6ioCORQnE/b4JggFQecECxEbioPvqpF/oiZokN9Mso7nLuvZGOTkUasVWUh3OIN7144+I+XuLs/izWTkkHiWM/38ydfCNn6AX3o+HhvvUaN4AezNtmZI+oMc6ctB/J93YSC0j0lsAPhqdeTkaKpyoeGl6MVP2tXiKnO0Mok3wyj8unOnIOhckz+OfY0YAT5ZRwqxzsZoR+Wpn4GNNIce7ehpzZwQ9AWtKI2hjIUimpUQd+SvB02gk7/Wec5FjMgBQnTI+cE6GrReBp1YiVLdwy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3NGWXlXV0tBTHRjVnY3MzhiQkREeE9sMnRMSDZDTy8rbnpONHk1YjNVWWM2?=
 =?utf-8?B?M3NCeFA1Uy8wSm16cmtPNUszTnQ0T25zbGpIYXpuQmIyWnVtcWNtQS9ZSWdE?=
 =?utf-8?B?RUZvcTZPcFZjQ2poQkJIajl1QWdnNXNBSmNzTCtBc3dlMytBczgvOWVGdU9w?=
 =?utf-8?B?aDduQ1kvamhORnJlbEFuWSt5VVhmSi81YXVYbmFYZVBDcFJEYWRDTXY2V0Rp?=
 =?utf-8?B?QXlvRFczM2lDN0lzUjRMekVSQW9qUkZHL2dXdnVGano4a2xTYnQzM2JlZ3Q3?=
 =?utf-8?B?UnlyUVYwT1dFd00wdXVkd0lCSjY1aWJkZU5pZVVwaUJiRER0aUsyc2Z4TnhO?=
 =?utf-8?B?clZwQlJ2bDFHYzI1anBGZzhtclpaeUQ0ODFVVEg3R3J1eHZZOUhmcEUwRVpO?=
 =?utf-8?B?Qmw2d2ZmSHN3VzBldmNRNDJFSzJEZW9UU1Zhb1BDRzc5UG1scnpuZlBQNzBx?=
 =?utf-8?B?ckl2aWt1T05DU1FPL0F1d2dLb2I3OHdWKzRVbnJYbWVLTU1uR29FeTR0M3p4?=
 =?utf-8?B?RVNnRlFmOXdBSXZpeTRhWW14NVgvaXBGOVRjTVA3VUdvNk14YlJhdmZkL3Jr?=
 =?utf-8?B?UDdjMXRnMXdyZStkbmwra1lXYU92MVFIcWRPRTVncmJlM05lQWE1ZkMwVE5V?=
 =?utf-8?B?MGZyenU4NFlhdm10V09uTHFNMUdUaHRzZzFjUlZNUlhlM3FFclZWY0FoWEFN?=
 =?utf-8?B?dHFkblN6Z2pKUElpTVVrOGRYZzJwczRQK0NKSVB4aThxZHJmUHUxWitIL0p0?=
 =?utf-8?B?QXY2b2hBUW1QdkZod1RtL1QwUjR0UlJTSFFuL0x3V0ZIaEdsTzJmN1hyNzlj?=
 =?utf-8?B?UEZkS3FmTmVnbEk1YStQdGQ1RXNZaTVBVElTR1BXRWpMZTIrU2VUVTFLVnNi?=
 =?utf-8?B?M1JRUVBidUNqNjlmTDRvdmRTcGNOMUVFbkQwSmpVb0VYRVgrOS9pRjQyT0VY?=
 =?utf-8?B?U0g3V1V5bmpDc25wZXZHK0tuaDNvcGtMTTVtN29rMDB0ZGpwcTFnb0c0elBS?=
 =?utf-8?B?SEU0Z1BpWnREdFlCTXJtemZuZlB3NEZWaHVoR1RBd2NkOU5oRzFqVmtxSmRB?=
 =?utf-8?B?ZjZ0ZmdRcUVkUmUxR0Z2MDFLVDFsRUwwbEViWGwrYVF1MndXaWZIL2V3NFYz?=
 =?utf-8?B?UlRQeSt6dlIzYXh6aUNsN1Bma2YrWFkyOXI5WFd1MUh5TUdBeFBJdWhBdUg4?=
 =?utf-8?B?QS9xWVl2dGRZWFNjWlJaSElNT0ZSRGhsNklUbEpEMk05TkxkRmhlL1IwWFFG?=
 =?utf-8?B?ZGYyTU94Z0VJaGpHR1NPQ3FoWTlEdm00ZjVNNVhMZjZpYTN4ZWx6Y2VMOTNp?=
 =?utf-8?B?Yy9rQlNMMGhYVm11YXJwcXAwZEJKVENzYWlHa21JY0QxMFpySmoxT1hYUGhT?=
 =?utf-8?B?dW9DTGZYRFJPTWtONGpRUWNyZDRlbkdyK3hqR24zL2hnQW5uRnpCaTZXVlJj?=
 =?utf-8?B?cXYvelErZ2psQ1ZIOXR1djZjUGV6VCtoYXkrOTdoU2ZhTGdmc2haSnVnZm9v?=
 =?utf-8?B?eGRSNFFjS1ZJbEorbXZRZzU2WGx5NG5TNjllTHl0ZGUxYmdncUVEajNaR0F1?=
 =?utf-8?B?QlpKMGNta3V0WGFYNjBQazVrV3RoOStKS3ZkdFg4Q3N6R3pJNllVZmxVempK?=
 =?utf-8?B?a0wranIyamY3b0FkQ2FISzhWKzBIbnBkM0I3bElkYjhuSDhEMlJWM0RFUXZl?=
 =?utf-8?B?aHRkTS9RMXJwVTZINmhIaml4VXM3aGp5NDR1L0VTYWxUYmc5bTdOL05mUWNt?=
 =?utf-8?B?cVpVY08rRndoRzhVVkJjUG9hQk16aW5GQUxEdjNZdTNJV3dyZW5Qc0l6d0NN?=
 =?utf-8?B?b2h6R0x4Z21BRnhsRXlZbXRJa3pNUWRNYm1ZSmFLREErTDBRWW4yL1RmbTBD?=
 =?utf-8?B?OTR6Tm81ZjVqUllHVlhLdWRxaS8xcjV2V0t6R0FmbkNmdU9vV2FhOUFhOFNy?=
 =?utf-8?B?ODFYSnBkTzJzWXMvMFd4T2Q1RnFBdU53VFpXejJMcld4MEJYWmhKR1FYc0NZ?=
 =?utf-8?B?MXNPY2g2b09mV1gxNVlCNVgxTkxnaWlqSmtvRjI5Z2RjQTg5TFdXbi9KbWVW?=
 =?utf-8?B?ekI5cGRDb0NuVlZ3ZlhTaFBaVW1OVjUvOVN1ZEZnNmo1S3oralhWeWlmTWNJ?=
 =?utf-8?B?WVpRRmUyOU5XZnVsYUFRbDFrWTVWS3ZtK1pHczNIZG1wa0dRYUlxOS9henZu?=
 =?utf-8?B?SFI5bWdTSUZRT3pyanFGOVMybzJidS81bGJoS2tzN25yajNTMm12bk9KenZO?=
 =?utf-8?B?RUFaek1EbEp2VnlQbEJMWUhWYlZERTFEazNwalhGNG9jL3ZodG04ZkE4VWlT?=
 =?utf-8?B?dlkyNTRNRllzbDQ2bWFDNk5FNFR3MDBlZ3BveHRMbDkyaXBHNnBOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7122a65-20d9-4eb2-b445-08deb71ddc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:46:40.7470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhiHUlpTljuFukPad/jyOewIZct51maojS0yDOAns1hnM+RW2ND4I3wjyczUvDuIa+6SH6LI/q/VvVP+6MleGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIxIE1heSAyMDI2IDA5OjE5
DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47
IHFlbXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBhbGV4QHNoYXpi
b3Qub3JnOw0KPiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hl
biA8bmF0aGFuY0BudmlkaWEuY29tPjsNCj4gTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsg
SmlhbmRpIEFuIDxqYW5AbnZpZGlhLmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+OyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtq
YWp1QG52aWRpYS5jb20+OyBwaHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NSAxMS8zMl0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2OiBJbXBsZW1lbnQgQ01EUVYNCj4gaW5p
dA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0
YWNobWVudHMNCj4gDQo+IA0KPiBIZWxsbyBTaGFtZWVyLA0KPiANCj4gT24gNS8xOS8yNiAxMjoz
NiwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29s
aW5jQG52aWRpYS5jb20+DQo+ID4NCj4gPiBUZWdyYTI0MSBDTURRViBleHRlbmRzIFNNTVV2MyB3
aXRoIHN1cHBvcnQgZm9yIHZpcnR1YWwgY29tbWFuZA0KPiBxdWV1ZXMNCj4gPiAoVkNNRFFzKSBl
eHBvc2VkIHZpYSBhIENNRFFWIE1NSU8gcmVnaW9uLiBUaGUgQ01EUVYgTU1JTyBzcGFjZSBpcw0K
PiA+IHNwbGl0IGludG8gNjRLQiBwYWdlczoNCj4gPg0KPiA+IDB4MDAwMDAgIChDTURRLVYgQ29u
ZmlnIHBhZ2UpDQo+ID4gMHgxMDAwMCAgKENNRFEtViBDTURRIFBhZ2UwKQ0KPiA+IDB4MjAwMDAg
IChDTURRLVYgQ01EUSBQYWdlMSkNCj4gPiAweDMwMDAwICAoVmlydHVhbCBJbnRlcmZhY2UgUGFn
ZTApDQo+ID4gMHg0MDAwMCAgKFZpcnR1YWwgSW50ZXJmYWNlIFBhZ2UxKQ0KPiA+DQo+ID4gVGhp
cyBwYXRjaCB3aXJlcyB1cCB0aGUgVGVncmEyNDEgQ01EUVYgaW5pdCBjYWxsYmFjayBhbmQgYWxs
b2NhdGVzDQo+ID4gdmVuZG9yLXNwZWNpZmljIENNRFFWIHN0YXRlLiBUaGUgc3RhdGUgcG9pbnRl
ciBpcyBzdG9yZWQgaW4NCj4gPiBTTU1VdjNBY2NlbFN0YXRlIGZvciB1c2UgYnkgc3Vic2VxdWVu
dCBDTURRViBvcGVyYXRpb25zLg0KPiA+DQo+ID4gVGhlIENNRFFWIE1NSU8gcmVnaW9uIGFuZCBh
IGRlZGljYXRlZCBJUlEgbGluZSBhcmUgcmVnaXN0ZXJlZCB3aXRoIHRoZQ0KPiA+IFNNTVV2MyBk
ZXZpY2UuIFRoZSBNTUlPIHJlYWQvd3JpdGUgaGFuZGxlcnMgYXJlIGN1cnJlbnRseSBzdHVicyBh
bmQNCj4gPiB3aWxsIGJlIGltcGxlbWVudGVkIGluIGxhdGVyIHBhdGNoZXMuDQo+ID4NCj4gPiBU
aGUgQ01EUVYgaW50ZXJydXB0IGlzIGVkZ2UtdHJpZ2dlcmVkIGFuZCBpbmRpY2F0ZXMgVkNNRFEg
b3IgVklOVEYNCj4gPiBlcnJvciBjb25kaXRpb25zLiBUaGlzIHBhdGNoIG9ubHkgcmVnaXN0ZXJz
IHRoZSBJUlEgbGluZS4gSW50ZXJydXB0DQo+ID4gZ2VuZXJhdGlvbiBhbmQgcHJvcGFnYXRpb24g
dG8gdGhlIGd1ZXN0IHdpbGwgYmUgYWRkZWQgaW4gYSBzdWJzZXF1ZW50DQo+ID4gcGF0Y2guDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0Bu
dmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3NtbXV2My1hY2NlbC5oICAgfCAgMSAr
DQo+ID4gICBody9hcm0vdGVncmEyNDEtY21kcXYuaCB8IDE4ICsrKysrKysrKysrKysrKysrKw0K
PiA+ICAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgfCAzOA0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMt
YWNjZWwuaCBiL2h3L2FybS9zbW11djMtYWNjZWwuaCBpbmRleA0KPiA+IGY4MmE3MTEyZDguLjQ5
YzEwNTM1Y2YgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQo+ID4gKysr
IGIvaHcvYXJtL3NtbXV2My1hY2NlbC5oDQo+ID4gQEAgLTYyLDYgKzYyLDcgQEAgdHlwZWRlZiBz
dHJ1Y3QgU01NVXYzQWNjZWxTdGF0ZSB7DQo+ID4gICAgICAgYm9vbCBhdXRvX21vZGU7DQo+ID4g
ICAgICAgYm9vbCBhdXRvX2ZpbmFsaXNlZDsNCj4gPiAgICAgICBjb25zdCBTTU1VdjNBY2NlbENt
ZHF2T3BzICpjbWRxdl9vcHM7DQo+ID4gKyAgICB2b2lkICpjbWRxdjsgIC8qIHZlbmRvciBzcGVj
aWZpYyBDTURRViBzdGF0ZSAqLw0KPiA+ICAgfSBTTU1VdjNBY2NlbFN0YXRlOw0KPiA+DQo+ID4g
ICB0eXBlZGVmIHN0cnVjdCBTTU1VUzFId3B0IHsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3Rl
Z3JhMjQxLWNtZHF2LmggYi9ody9hcm0vdGVncmEyNDEtY21kcXYuaCBpbmRleA0KPiA+IDM4Yzhi
MjdiNGQuLjAzMGY1NzU4ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
LmgNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+IEBAIC0xNCw2ICsxNCwy
NCBAQA0KPiA+ICAgI2RlZmluZSBDTURRVl9OVU1fQ01EUV9MT0cyICAgICAgIDENCj4gPiAgICNk
ZWZpbmUgQ01EUVZfTlVNX1NJRF9QRVJfVklfTE9HMiA0DQo+ID4NCj4gPiArLyoNCj4gPiArICog
VGVncmEyNDEgQ01EUVYgTU1JTyBsYXlvdXQgKDY0S0IgcGFnZXMpDQo+ID4gKyAqDQo+ID4gKyAq
IDB4MDAwMDAgIChDTURRLVYgQ29uZmlnIHBhZ2UpDQo+ID4gKyAqIDB4MTAwMDAgIChDTURRLVYg
Q01EUSBQYWdlMCkNCj4gPiArICogMHgyMDAwMCAgKENNRFEtViBDTURRIFBhZ2UxKQ0KPiA+ICsg
KiAweDMwMDAwICAoVmlydHVhbCBJbnRlcmZhY2UgUGFnZTApDQo+ID4gKyAqIDB4NDAwMDAgIChW
aXJ0dWFsIEludGVyZmFjZSBQYWdlMSkgICovICNkZWZpbmUNCj4gPiArVEVHUkEyNDFfQ01EUVZf
SU9fTEVOIDB4NTAwMDANCj4gPiArDQo+ID4gK3R5cGVkZWYgc3RydWN0IFRlZ3JhMjQxQ01EUVYg
ew0KPiA+ICsgICAgc3RydWN0IGlvbW11X3Zpb21tdV90ZWdyYTI0MV9jbWRxdiBjbWRxdl9kYXRh
Ow0KPiANCj4gVGhpcyB3b24ndCBidWlsZCBvbiBXaW5kb3dzLg0KDQpPb3BzLi5JIGRpZCB0aGF0
IGFnYWluIS4gV2lsbCBmaXggaXQgaW4gdjYuDQoNClRoYW5rcywNClNoYW1lZXINCg==

