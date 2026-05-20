Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D28CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf29-0004NN-0P; Wed, 20 May 2026 07:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPexH-00026N-UL; Wed, 20 May 2026 07:20:18 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPexE-0001OG-6L; Wed, 20 May 2026 07:19:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV1F4It9hTI8+qavPvzu/zLR+UJ5asZU/5Ehxtp2Pllp5U0m9MW1HDbVaebL6PSB84tYGZcs2zfziXJQPmCMKiL1umgzrXaCP7RLpP9y8Mm6pXywvQkC6eKhS/PkRS+SP0Eydc6bvE7FoqFzaCE0XhKW0oSZuxU1aKG5Bsf8CEHXqD+aS5b6DUybLKqXKgdNkpd1+3uotUtMc/Dso5txRU+UbQ/h07aYP3OgdbNfrjvezzSxVhRdV9PUR/ChXJdpqxOZm/E0VTCBv57QLhueGW14bX3NrVU7JLXAKt3u/TwraYaVK8QNbUlLOadei/bTClmyuj4HIQnZpvsnoGpHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtP3F6EKZ6i1rBEzGvYAj2g22kzrD53ZHiiBRZwAejA=;
 b=ZR/uqbCkqbVodwQu+smZNBntn3jElwSdfD5CVtF92u2MbkJAEIyH+e1fu9nf5Tt54xf/u5j5gXjw1mUkogGEb6r9uPOq/namwV7Dwu25UpyKRn6cWGZHY1hzNVXJxUOxuKIdcVJJvID+ezOHu/f/EY2HNgjDPPO5tvY8cZlw+JbIWpiVTUKSdCHA04HHEVKBd3vZDJM+KgX5CfHf+aqcrCYQDYC+HLDCYc3rPBj/AFzQjt/QOeT/tDTikK5FjVCSPc1xKsxL5ug16GUqM+XUD1PAuwwbG5WMMmOc37XCHMxVkqS+O4zEBWinScjO389HXLY87UQmZEJFMVv8annILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtP3F6EKZ6i1rBEzGvYAj2g22kzrD53ZHiiBRZwAejA=;
 b=cm1iwvvHSvLvvla81K8pSIpcOVHJwv5DRJCziA0IXj8D/sx05RvzF9DkDF+78TBI7CHFOwc7RWyxX2iijvV8Uv76GN7t6dglJ/2tRJXjA6QXqczNGlRT2wR99B4UbX2fqtki8160IG5dIM3WjFaYPxPbZ8YTJelexTl/gfqlNJ0h3BuCkAZv1nLg5JeNK/CpLuvvMQ5rWFDWx9I/4uP9yaQRBqIiYuTqMGz0zTWDbigQh8OFe9C+BfklgMvLKzoPoBnvqPFOLFfF9tn50OaKjgc0KeXMwp0RVyXf2bcmnTx+LwU7Bif1HyFZ9NO958/l4+fxEmKoHpWp4ZEay0TvdQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 09:54:20 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:54:20 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Topic: [PATCH v5 16/32] hw/arm/tegra241-cmdqv: Emulate VCMDQ register
 writes
Thread-Index: AQHc53vNIJgS7n+sDkKqpewZRLBJ9bYWjJMAgAARkyA=
Date: Wed, 20 May 2026 09:54:19 +0000
Message-ID: <CH3PR12MB7548A230C9165D12CDD2EEF2AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-17-skolothumtho@nvidia.com>
 <73b4f204-41d5-4997-8d02-5fc9ba3d0c67@redhat.com>
In-Reply-To: <73b4f204-41d5-4997-8d02-5fc9ba3d0c67@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4231:EE_
x-ms-office365-filtering-correlation-id: 4139f8c3-f526-4782-0a93-08deb655c36d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|56012099003|22082099003|18002099003|38070700021|11063799006|4143699003|5023799004;
x-microsoft-antispam-message-info: QXgM0wNZGNC3SHv0ru2lLn6DUl6YEwlmjkUBC0wXfX63D3rcixgKao3+n53PC+/RKchGPG8kZ0WGfkD8Aqp9+SgqAKA9TsW1GJ0o/Jn4UikVlf4W72v6TND9/3eiH4dHo61qKMBI1jxoa4BwpSa3clpvXx40V59JjoSf7HwlFnPXnnc/F9LJG9196ZVT8hmJ621+5hKNs9la1fn3T+Lp1+mknzGe3CmkOGKY6fmzfbkfWc3v/f1ZB7k9C4tQkCeIcmurtdPvMRT0QZcJPuRhPVmCBPs+84+S2hFRLYauTUkKJlBIW5wVOH+q2nCIv1ylncDGjaJjf7wYLRzR9Z/WEvbiIrDQnySSbr05GQNxPWtD+AyqfKdDjgyQTQmQsDKhsiJYhjf1Z83kUj5bRg5TsBzsw5P8F+AwPaUn2pJjK4xe14gxfbkdB945VD2iLzXh7AcZUkvS3oLiWIXIIgLaudqZX2voX0Uvgt6Yik1Jx0/l5wbm49cCXi09r8mIq27NciJxfD5kdmkVnROf7rD79w+jV5ze4/trj8uCeIq6q5Bik0vhxKRx1vFmDWcOtm9S33OPDfpaAmsc+zJrZIw2Q2jBC0w6+LYNM3VYPvqqwB7BI6pbrjMbjVtkf+OtSeSGlU38yesh2h3XtBVb2nUVrmA9ODhQA6XRzR0KqT8am+fg6fkr7V9WPGqxEh4MqvtpNoWRQ5jXu0w4/G5M24qrMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(56012099003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amJXTjVxbmU1T2NRTnpZZEV3cWgraHBSSG1VTWNVM0dMS1NnVFdURzhvWXNi?=
 =?utf-8?B?QkljTjd5bFNHa0pSdG5LYVpYL09qUTQzTDhja0N5YTVod3d6YnNzVk1FbFdq?=
 =?utf-8?B?VDJkSmhOditLdUc2ZjVRN0xxZ0l4OVNYYmFqZHJjZE13c0NiNm5XSFBwRENN?=
 =?utf-8?B?U2FYTmtTRHFrdXYvQi9XUEVxWnMzZlpzcnBFR2MwNFU3a0hva2R3aXcreHpo?=
 =?utf-8?B?YmtjSHZ3aVc0TWQvWHJnNzQ4ZUNYbmNOTkw5S0IxL2k1MmduT3RPNVpHR3Fm?=
 =?utf-8?B?NkcrMEI1NTBYdEM3N2V2blM0eGxBOEQ4ekxaK3VCQi8ydmRxeGQyWWQ3MFVH?=
 =?utf-8?B?Rk1UN0xEeExUbDhJMUVYN29aZlRWT2sycjhUQ2FPQjJGZFRMaVAyTWNDOXlm?=
 =?utf-8?B?N3MrMDJGcG9GUk1ReGdrMW9DZkVGR1FVNExWeEdIMDBXcVYwSWd5dE9BN0hu?=
 =?utf-8?B?R3Y5L1dLZEZ5cTN5aHRCakVrTGpIcUtoUm8yMjZMSVphTXZIV2F0VGZhWWxT?=
 =?utf-8?B?SU1aaTZZQ0xKYzBIZUJVYTdUUGFDeVlNMnl1K1F6K3NIUTkrendyczVQbGZw?=
 =?utf-8?B?M1NvL2MvTEFlVlNVVXJ6V2xKRVBYNEFNYkhMMzBXdDRwQlNhMzRJdnpRMmdH?=
 =?utf-8?B?NXIxRFFsY3JmNVZFTVRCaENJd1Z0VU1GSnlkTmJLNmRGdnNWU2YzWXkrSUlh?=
 =?utf-8?B?M0VtWWZjdVdCR0NXZ2pDMFNWWHlWanVZY3Z1Ni9mZm9PaVNuSC9rSGVmNUtL?=
 =?utf-8?B?SkVsdURjQk4zRFhsVlgxNFZ1R24wbVE5TjJ2N3N3MW4rNTNIK1pDQzdtL09C?=
 =?utf-8?B?ZGd4M1p0UUZBTXNJTnZvaThqZGdreVo2VWs5ZWVvaXlJY1M1RENqMDU0Mlpr?=
 =?utf-8?B?bno5N0dITmZBS0JnbFMrcG1aT09yOXNUZkM3OEJmeW9zVU9CMjZMcFhLTmRQ?=
 =?utf-8?B?aWUrQy90NXVYc08rSVUxOHpONjViVU1VNXlDdzVRclE4VWdoUnIvS2YwRDZE?=
 =?utf-8?B?RW9LOVNGS2ZBWnpmZ2o5YjVuSVA3MlFXMXJ6OXJYZFk3dGpvSXpvV2JLYnFU?=
 =?utf-8?B?NFdRVjRSUVNodkllWWk5S0R6QU9XRjJxQ0U1Rm5ja3pDbzJDZGpnOXBSM0Z2?=
 =?utf-8?B?MFRsNXFxejgwZ3N2bWljNldOWGhlZDZrYWNrOFdURy9SWGlBVXBLMEo4MW1j?=
 =?utf-8?B?VG1wUVJDdjROdTU5YnNUVC80WXpsMGM5NE8zK1BDZzIzUnNNMUtleTVCbzY0?=
 =?utf-8?B?OWFkaXlZTWs0Y3JXdjZISlRQZ0JEWHJFT3NvTGZSUTRuU3RMRC9Ha21rclFk?=
 =?utf-8?B?STc3UHhQZ3MvWTVlaVFudDFzbXZyTVhHUGdVemo4RlB3T2JoejFhYWRsbkxr?=
 =?utf-8?B?akhtZHowbHRqdmZzTUdoWllTV3gvcjErRTdKTXlZeGpKSmZIYXRLSC9jOXFS?=
 =?utf-8?B?bE15TS9Ia3Z4cFBWdDZ0djFBbFZjeG4rM2RnYkV5K2NMQkUxbUNoaGxVd2Qr?=
 =?utf-8?B?U1ovRXpEbG5xdGIrOWxSVlVjVnovK2ZBT0wrYmVncjY2Q1FZT0lwWkRISDJO?=
 =?utf-8?B?aE5UclcrbnZpTEplRVJEdk1mOHVTRzAyU0tsZ3ZwWCsrcm9CZ0ZqdVAybFhu?=
 =?utf-8?B?MHh4YmdueTdKWWJ6Zjh5UTlEbnd2V0RlWnh0Z25ZelNVeFM1Rzcyb0VJNlpI?=
 =?utf-8?B?SHZDUnFHNmlvd3I4UzBhSVAvaGw5cVpiQnMwYlpBd2pyVmRmWVNXcVAyZzM5?=
 =?utf-8?B?MS9nNVIvcy9sV05sdmxZakk4SzNORVUwS3Rhanl0NVFBeEJkSk1LRlhKb1Jj?=
 =?utf-8?B?UGFQc1o2cjYwRllVUzdaMGx2NWhHU0RoOUZkcHJqYzRrT25hOFZHS05yOURn?=
 =?utf-8?B?NTcrazB3ZGN5bXVWOTh2VExlY3ZUK3JHRlNvVDBJaDFHajFNb0FhUWtZQjEv?=
 =?utf-8?B?UkszZzV0M3pYeUY5WFRIOUlLSGdOM2dLR0xxOFNWMEtlYnNHU0svU2xsTktr?=
 =?utf-8?B?dU9nVVpUS1NPT3FweVB5VGd3NVJ1WGxUR010K3FUN0I2ZWpqb2NaM3hhUlA1?=
 =?utf-8?B?QTZCOWo5Z04vWFpNcVRmcDk3NlQzbGxmNWhqbmprRmZFMVBiamIyTm9TMzgw?=
 =?utf-8?B?YlFWUzNVVXlzek5PeGVxaWY4c2ZGWDFaQmVndlk5SDhkUytEQzBLbEVIVWU1?=
 =?utf-8?B?TStuVk50ay9XVExJYjdpNTljd3NBS2d3a2N1eXJiYTlXZHBFZFZYVUZrM1VM?=
 =?utf-8?B?ZHI0Z0R1K2dkYTlQTGJFcjl3Z0NLT3BQdm4ra2UxaG1NZENjd0ZWQ1I3WmEv?=
 =?utf-8?B?UWxCSmh3RXlOSFZZbldnY0h5TmRpdTlSWkMzSlltTmRDYW1DSUViUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4139f8c3-f526-4782-0a93-08deb655c36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 09:54:19.9904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIsxVDOzR5xCatn+ZsHXjCmp229u29dKkVV85LnIqMn2TnqgbCmIMxD+ETWUuHt9WFwpFfPL62qI6if0XFUSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwODo1NA0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNi8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBFbXVsYXRlIFZDTURRDQo+IHJlZ2lzdGVyIHdyaXRlcw0KPiANCj4g
RXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMN
Cj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNS8xOS8yNiAxMjozNiBQTSwgU2hhbWVl
ciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQo+ID4NCj4gPiBUaGlzIGlzIHRoZSB3cml0ZSBzaWRlIGNvdW50ZXJwYXJ0IG9mIHRo
ZSBWQ01EUSByZWFkIGVtdWxhdGlvbi4gQWRkDQo+ID4gd3JpdGUgaGFuZGxpbmcgZm9yIGJvdGgg
dGhlIGRpcmVjdCBWQ01EUSBhcGVydHVyZSBhbmQgdGhlIFZJTlRGDQo+ID4gbG9naWNhbCBhcGVy
dHVyZSB1c2luZyB0aGUgc2FtZSBpbmRleCBkZWNvZGluZyBhbmQgVklOVEYtdG8tVkNNRFENCj4g
PiB0cmFuc2xhdGlvbiBsb2dpYyBhcyB0aGUgcmVhZCBwYXRoLg0KPiA+DQo+ID4gVklOVEYgYXBl
cnR1cmUgd3JpdGVzIGFyZSB0cmFuc2xhdGVkIHRvIHRoZWlyIGRpcmVjdC1hcGVydHVyZQ0KPiA+
IGVxdWl2YWxlbnQgYW5kIHVwZGF0ZSB0aGUgc2FtZSBjYWNoZWQgc3RhdGUuIFBhZ2UgMSByZWdp
c3RlcnMNCj4gPiAoQkFTRSwgQ09OU19JTkRYX0JBU0UpIGFsd2F5cyB1cGRhdGUgdGhlIGNhY2hl
LiBPbmNlDQo+ID4gSU9NTVVfSFdfUVVFVUVfQUxMT0MgYW5kIHZpb21tdV9tbWFwIGFyZSB3aXJl
ZCB1cCBpbiBhDQo+IHN1YnNlcXVlbnQNCj4gPiBwYXRjaCwgUGFnZSAwIHJlZ2lzdGVyIHdyaXRl
cyB3aWxsIGJlIGZvcndhcmRlZCB0byB0aGUgaGFyZHdhcmUtDQo+ID4gYmFja2VkIG1tYXAnZCBw
YWdlLg0KPiA+DQo+ID4gSWdub3JlIFZDTURRIEJBU0Ugd3JpdGVzIGlmIHRoZSBWQ01EUSBpcyBh
bHJlYWR5IGVuYWJsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVt
IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtv
bG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3Rl
Z3JhMjQxLWNtZHF2LmMgfCAxNjQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPiA+ICBody9hcm0vdHJhY2UtZXZlbnRzICAgICB8ICAgMiArDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTY0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21k
cXYuYw0KPiA+IGluZGV4IGY4NTkxMjZhZDYuLjVkMmQ5ZDJlMjYgMTAwNjQ0DQo+ID4gLS0tIGEv
aHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYu
Yw0KPiA+IEBAIC0xNiw2ICsxNiwxNiBAQA0KPiA+ICAjaW5jbHVkZSAidGVncmEyNDEtY21kcXYu
aCINCj4gPiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4NCj4gPiArLyoNCj4gPiArICogUmV0dXJu
cyB0cnVlIGlmIHRoZSBwZXItVkNNRFEgQ01EUV9FTl9PSyBiaXQgaXMgc2V0Lg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGJvb2wgdGVncmEyNDFfdmNtZHFfZW5hYmxlZChUZWdyYTI0MUNNRFFWICpj
bWRxdiwgaW50IGluZGV4KQ0KPiA+ICt7DQo+ID4gKyAgICB1aW50MzJfdCBzdGF0dXMgPSBjbWRx
di0+dmNtZHFfc3RhdHVzW2luZGV4XTsNCj4gPiArDQo+ID4gKyAgICByZXR1cm4gc3RhdHVzICYg
Ul9WQ01EUTBfU1RBVFVTX0NNRFFfRU5fT0tfTUFTSzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoN
Cj4gPiAgICogUmVhZCBhIFZDTURRIFBhZ2UgMCByZWdpc3RlciAoY29udHJvbC9zdGF0dXMpIHVz
aW5nIFZDTURRMF8qIG9mZnNldHMuDQo+ID4gICAqDQo+ID4gQEAgLTExNiw2ICsxMjYsMTA4IEBA
IHN0YXRpYyB1aW50NjRfdA0KPiB0ZWdyYTI0MV9jbWRxdl9jb25maWdfdmludGZfcmVhZChUZWdy
YTI0MUNNRFFWICpjbWRxdiwNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4g
KyAqIFdyaXRlIGEgVkNNRFEgUGFnZSAwIHJlZ2lzdGVyIChjb250cm9sL3N0YXR1cykgdXNpbmcg
VkNNRFEwXyogb2Zmc2V0cy4NCj4gPiArICoNCj4gPiArICogVGhlIGNhbGxlciBub3JtYWxpemVz
IHRoZSBNTUlPIG9mZnNldCBzdWNoIHRoYXQgQG9mZnNldDAgYWx3YXlzIHJlZmVycw0KPiA+ICsg
KiB0byBhIFZDTURRMF8qIHJlZ2lzdGVyLCB3aGlsZSBAaW5kZXggc2VsZWN0cyB0aGUgVkNNRFEg
aW5zdGFuY2UuDQo+ID4gKyAqDQo+ID4gKyAqIFBhZ2UgMCByZWdpc3RlcnMgYXJlIGFsbCAzMi1i
aXQ7IHRoaXMgaGVscGVyIGlzIG9ubHkgY2FsbGVkIGZvciA0LWJ5dGUNCj4gPiArICogd3JpdGVz
Lg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfd3JpdGVfdmNtZHFf
cGFnZTAoVGVncmEyNDFDTURRVg0KPiAqY21kcXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBvZmZzZXQwLCBpbnQgaW5kZXgsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZh
bHVlKQ0KPiA+ICt7DQo+ID4gKyAgICBzd2l0Y2ggKG9mZnNldDApIHsNCj4gPiArICAgIGNhc2Ug
QV9WQ01EUTBfQ09OU19JTkRYOg0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9jb25zX2luZHhb
aW5kZXhdID0gdmFsdWU7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICBjYXNlIEFfVkNN
RFEwX1BST0RfSU5EWDoNCj4gPiArICAgICAgICBjbWRxdi0+dmNtZHFfcHJvZF9pbmR4W2luZGV4
XSA9IHZhbHVlOw0KPiBzbyB0aGVyZSBpcyBubyBjbWQgY29uc3VtcHRpb24gdHJpZ2dlcmVkIGJ5
IGFuIGluY3JlbWVudCBvZiB0aGUgcHJvZHVjZXINCj4gaW5kZXggYXMgb3Bwb3NlZCB0byBzdGQg
c21tdSBlbXVsYXRpb24uIFRoaXMgc2hhbGwgYXQgbGVhc3QgYmUgZXhwbGFpbmVkDQo+IGluIHRo
ZSBjb21taXQgbXNnIGFuZCBtYXliZSBpbiB0aGUgY29kZSwgKyB0aGUganVzdGlmaWNhdGlvbi4g
SXQgaXMgYQ0KPiBiaXQgc3RyYW5nZSB0byBlbXVsYXRlIHRoZSBNTUlPIGFjY2Vzc2VzIHdoaWxl
IG5vdCBkb2luZyBhbnl0aGluZw0KPiBmdW5jdGlvbmFsIG91dCBvZiB0aGVtLg0KDQpUaGVyZSBp
cyBpbmRlZWQgYSBkaWZmZXJlbmNlIGhlcmUgdy5yLnQuIHN0ZCBTTU1VIGVtdWxhdGlvbi4gQ01E
UVYNCmlzIGEgaGFyZHdhcmUtYWNjZWxlcmF0ZWQgZmVhdHVyZSwgYW5kICAgdGhlcmUgaXNuJ3Qg
bXVjaCB2YWx1ZSBpbiBlbXVsYXRpbmcNCnRoZSBxdWV1ZSBmdW5jdGlvbmFsaXR5IHdpdGhvdXQg
dGhlIEhXIGJhY2tpbmcuDQoNCkZyb20gU3BlYywgcC4xNzY6DQoNCiJXaGlsZSB0aGUgc29mdHdh
cmUgY2FuIHByb2dyYW0gdGhlIFZpcnR1YWwgQ01EUShzKSBkaXJlY3RseSB1c2luZyB0aGUgZGly
ZWN0DQpWQ01EUSBhcGVydHVyZSAgKGFuZCBub3QgdGhyb3VnaCB0aGUgVmlydHVhbCBJbnRlcmZh
Y2UpLCBpdCBpcyByZXF1aXJlZCB0aGF0IHRoZQ0KVkNNRFEgYmUgYWxsb2NhdGVkIHRvIGEgVmly
dHVhbCBJbnRlcmZhY2UgYmVmb3JlIGl0IGlzIHVzZWQgdG8gc2VuZCBjb21tYW5kcw0KdG8gdGhl
IFNNTVUiDQoNClNvIG5vIGFjdHVhbCBjb21tYW5kIHByb2Nlc3NpbmcgY2FuIGhhcHBlbiB1bnRp
bCB0aGUgVkNNRFEgaXMgYWxsb2NhdGVkIHRvDQphIFZpcnR1YWwgSW50ZXJmYWNlLiBVbnRpbCB0
aGVuLCByZWFkcy93cml0ZXMgb25seSB1cGRhdGUgdGhlIHJlZ2lzdGVyIGNhY2hlLg0KDQpJIHdp
bGwgbWFrZSB0aGlzIGNsZWFyIGluIHRoZSBjb21taXQgbG9nLg0KDQo+ID4gKyAgICAgICAgYnJl
YWs7DQo+ID4gKyAgICBjYXNlIEFfVkNNRFEwX0NPTkZJRzoNCj4gPiArICAgICAgICBpZiAodmFs
dWUgJiBSX1ZDTURRMF9DT05GSUdfQ01EUV9FTl9NQVNLKSB7DQo+ID4gKyAgICAgICAgICAgIGNt
ZHF2LT52Y21kcV9zdGF0dXNbaW5kZXhdIHw9DQo+IFJfVkNNRFEwX1NUQVRVU19DTURRX0VOX09L
X01BU0s7DQo+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgY21kcXYtPnZj
bWRxX3N0YXR1c1tpbmRleF0gJj0NCj4gflJfVkNNRFEwX1NUQVRVU19DTURRX0VOX09LX01BU0s7
DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9jb25maWdbaW5kZXhd
ID0gdmFsdWU7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICBjYXNlIEFfVkNNRFEwX0dF
UlJPUk46DQo+ID4gKyAgICAgICAgY21kcXYtPnZjbWRxX2dlcnJvcm5baW5kZXhdID0gdmFsdWU7
DQo+IHNob3VsZG4ndCBpdCBkbyBzb21ldGhpbmcgZnVuY3Rpb25hbCBiZXNpZGVzIHN0b3Jpbmcg
dGhlIHZhbHVlDQo+IG9uIHN0ZCBTTU1VIHdlIHJlc3VtZSBjb25zdW1pbmcgY21kcy4gaW50ZXJh
Y3Rpb24gd2l0aCBpbnRlcnJ1cHRzLA0KPiBDT05TX0lORFg/DQoNClNhbWUgcmF0aW9uYWxlIGFz
IGFib3ZlLiBJbiB0aGUgcHJlLWFsbG9jYXRpb24gc3RhdGUgdGhlcmUgaXMgbm8gcmVhbCBxdWV1
ZQ0KZnVuY3Rpb24gdG8gZHJpdmUsIHNvIHRoZXJlIGlzIG5vdGhpbmcgZnVuY3Rpb25hbCBmb3Ig
UUVNVSB0byBkbyBvbiBhIEdFUlJPUk4NCndyaXRlLg0KDQo+ID4gKyAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIiVzIHVuaGFuZGxlZCB3cml0ZSBhY2Nlc3MgYXQg
MHglIiBQUkl4NjQgIlxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBv
ZmZzZXQwKTsNCj4gPiArICAgIH0NCj4gPiArICAgIHRyYWNlX3RlZ3JhMjQxX2NtZHF2X3dyaXRl
X3ZjbWRxX3BhZ2UwKGluZGV4LCBvZmZzZXQwLCB2YWx1ZSk7DQo+ID4gK30NCj4gPiArDQo+ID4g
Ky8qDQo+ID4gKyAqIFdyaXRlIGEgVkNNRFEgUGFnZSAxIHJlZ2lzdGVyIChiYXNlIC8gRFJBTSBh
ZGRyZXNzKSAtIDQtYnl0ZSBhY2Nlc3MuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCB0ZWdy
YTI0MV9jbWRxdl93cml0ZV92Y21kcV9wYWdlMShUZWdyYTI0MUNNRFFWDQo+ICpjbWRxdiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIG9m
ZnNldDAsIGludCBpbmRleCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgdmFsdWUpDQo+ID4gK3sNCj4gPiArICAgIHN3aXRjaCAob2Zm
c2V0MCkgew0KPiA+ICsgICAgY2FzZSBBX1ZDTURRMF9CQVNFX0w6DQo+ID4gKyAgICAgICAgaWYg
KHRlZ3JhMjQxX3ZjbWRxX2VuYWJsZWQoY21kcXYsIGluZGV4KSkgew0KPiA+ICsgICAgICAgICAg
ICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9iYXNl
W2luZGV4XSA9DQo+ID4gKyAgICAgICAgICAgIGRlcG9zaXQ2NChjbWRxdi0+dmNtZHFfYmFzZVtp
bmRleF0sIDAsIDMyLCB2YWx1ZSk7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gKyAgICBjYXNl
IEFfVkNNRFEwX0JBU0VfSDoNCj4gPiArICAgICAgICBpZiAodGVncmEyNDFfdmNtZHFfZW5hYmxl
ZChjbWRxdiwgaW5kZXgpKSB7DQo+IHdoZXJlIGlzIGl0IGRvY3VtZW50ZWQgaW4gdGhlIHNwZWM/
IEkgZG9uJ3Qgc2VlIHRoaXMgcmVzdHJpY3Rpb24gaW4gdGhlDQo+IHJlZyBkb2MuIFRoZW4gIkVu
YWJsaW5nIHRoZSB2aXJ0dWFsIENNRFEiIHBhcmFncmFwaCBkZXNjcmliZXMgYSBzdGQNCj4gc2V0
dXAgYnV0IGRvZXMgbm90IHNheSAtIGFmYWljcy0gdGhhdCBpdCBzaG91bGQgYmUgaWdub3JlZCAt
DQo+IHdvcnRoIGNvbW1lbnRpbmcNCg0KUmlnaHQuIEkgZG9u4oCZdCB0aGluayBpdCBpcyBleHBs
aWNpdGx5IHRoZXJlIGluIHRoZSBzcGVjLg0KDQpIb3dldmVyLCBOaWNvbGluIG1lbnRpb25lZCBh
Ym91dCBzdWNoIGEgcmVzdHJpY3Rpb24gZHVyaW5nIHY0IGRpc2N1c3Npb246DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsL2FmdUYrc0p0RUFwV2lzcCtAbnZpZGlhLmNvbS8NCg0K
QUZBSUNTLCBpdCBsb29rcyBsaWtlIGFuIGltcGxpZWQgYXNzdW1wdGlvbiBiYXNlZCBvbiB0aGUg
IkVuYWJsaW5nIHRoZSB2aXJ0dWFsDQpDTURRIiBzZXF1ZW5jZSBvciBJIG1pc3NlZCBpdC4NCg0K
SSB3aWxsIGRvdWJsZSBjaGVjay4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

