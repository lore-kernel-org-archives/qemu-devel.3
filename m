Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7243ECD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbk5-0001D9-Ji; Wed, 20 May 2026 03:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPbk3-0001Cr-Pc; Wed, 20 May 2026 03:53:23 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPbk2-0002Hs-3N; Wed, 20 May 2026 03:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTOaDGCdhv6Jvpfc0dfcu/mL6TiYfoo/aYlK1+yFFqkiLW569AKzJ9pKUwlSBNv5kbljXshjrpx9mGYEXrC6eNocObBmtdEbNXncLdCgf16mbDGVeJGdY8O+P2+suQ1nR0ZNruow91lg2L3uAvZsu489BpchCyt7FrBEzzgmHTHfPnK6n3gbjDDuhhTiiD+yqIcLhAN9FGTfWIs08FMsIksWH7svu0fmgV/parIsdOX2jEsWsUQCVKCRdbfmp1uF+unABYJIccDMAqwHlPrJRl27WZmncf3u+9ZRT+DUvNSd7PhwbolPDlcwhsOJ0e+9zNTVt5KsluNHDmBQsoMm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byiNKpj3/wx2WqazKGwJAiMLEz6x6jv5Vgx/6IHQ5RI=;
 b=mfBIEXH4Ph7WS+pQGsDG6a8PhZwuawYan6ifMKh+Eg61SUfcIc1iZ/az9/roC73sTNvqf4gxrKaSKe68OKse0J9Hzv7boxWEO1OYKGRApE9796+kRUN16NGGMXAiabxI0wTVYQFQdv1mbhGV7XF4iW09Wn7DzFSLvNo3ZCXaW2/xexztLftsS14R9pUysQSfHbvfxdTaBO2x9kB62inj8xtUZRqPvbGrbALvK1n6zIi/sVfhoxgwWOaPmZgmYhfVJOUbRrIzE/EcKi12WHaUqTdGJt6VqqGgBp6TIRaT3O2X92Hgo/eXqdSIkeXMRemxReVG3Jys7MTgSW7uO8I+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byiNKpj3/wx2WqazKGwJAiMLEz6x6jv5Vgx/6IHQ5RI=;
 b=atjNBjnc7VRb1u7qFebsjN5eqBSDvyt0V7IRV+O/TAzxb//J/QXWiU0JF3Y3yvGKxLhtwkYz4BTAhm2FJaWnuRm3TPbV506luDYsEHGpXYOFtARs/H6LStajX7h4EQ4fYtcAZIJv7HzBPflOuinA8VULyVAYrSDOcVdTBLXYUzo8cZ4z1nusGboGtiY1dhRjZ93ceWrXCyVRCd6IHQvK+3S46Qebnn6gS89fSl2O8xOkanOSlEVRfm0xZwsRg+bYdvXivGrhpE69JAeDnxqryn2p4rsgcQZeRm8cXrh9MdZYA1GF4pDwDTsfd/E4t3nwkXTJTNRoJCOeDkQh8QzBBA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:53:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:53:13 +0000
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
Thread-Index: AQHc53vNIJgS7n+sDkKqpewZRLBJ9bYWa5CAgAAgiyA=
Date: Wed, 20 May 2026 07:53:13 +0000
Message-ID: <CH3PR12MB7548E399CF726D3730D39734AB012@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-17-skolothumtho@nvidia.com>
 <79d27d57-ee18-4c2b-a2f2-6d14c593202f@redhat.com>
In-Reply-To: <79d27d57-ee18-4c2b-a2f2-6d14c593202f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CYYPR12MB8870:EE_
x-ms-office365-filtering-correlation-id: e6872926-fbd9-4c6c-afaf-08deb644d807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|4143699003|18002099003|22082099003|56012099003|11063799006;
x-microsoft-antispam-message-info: rZACvJA98AuVeUsn7ZJ2ML7QirOucEfSCPTv2fiYrLU6URSQNyKzsZ9IrxhcI6jqccFYH7f8U/t3mAel/GlknIrKeUm+ri5tgSYDYi+qOxrTWQlBexdu+kpXdu0+zi9y9wtDb9J7ULVELYkV0lxeX5gRhTwBiYBhE8VH/vt12rlqh/5WVtQTOtwohUqdHmh608cAADfgd8SnB71cbb+SBGxxbMssWJh8hHeGQzyZOM4JV51F6/VHnzGswNDwIu/0LF4IHAHbH3pDhBU6c/6cETF+g2O7T/A7RB/l8+UuZCh6iCfhe6EvaTFu/W/veNuh0yw7dRHv6VmnxE2fMERo77ZNKWWZDx1G77szl/YhiYkp1JB1XI7+zb+qhhpnbBS2RFrJTmQ0KywcYjwQ3vwE338q1DxA43Za6FL+SIDM3Ar57+H4MfAIIp4fi2NZ0lnnwxl8RGVKqG88leaD9M2bUiWi7b8bYtxSnQa2fPG+5ZcRokuWVxyVBVd6G/7HgUY9a8qIDLZFN5p2+sl4oFdSMNavLIT2nL/hdzqBQK56mfvTat4JPuJaHta4of7LL7HJBuDZOJRH3v0ru7bgVHZnhqI/g9euywBqrwZV43vEgk01P9hc/5sRo9r0585a7q7GZN31F2IPyisDhEHQILDIt3+XbVM3RsN2x0NsX5tKGCmsLIZVvn20jm0SI5L9s0d9P+q2whV7PXeROuna8lQEnLlfyTz8fs6YVoarXLRgKHMX7ueFdDgxoN3WYNKDmqnW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHM4eUJwdCt2dWQzRFc3R3BUOHV2SkJWbXVLSjQ1MzFOOEMza3lyQWZVZU9p?=
 =?utf-8?B?alhNb25UdHFUb20vVndYOTRVdTVCbVRjRnhVZFJRNkdLWFJKY3cxdTRrVFcr?=
 =?utf-8?B?S082c1R0NjFMRGthR1pXc3AyRU9jT0RSaW92Q1FQaHJnVTZ2ZlhEQ3MvV1px?=
 =?utf-8?B?Z1BkOXhWMlhnaSt6ZVBtS1ozRncwUXFKUHN6YlpRc1ZsTnp1OXYzZTFDSUhk?=
 =?utf-8?B?K1dRSHBwbm5kdjN1SFNiMW5VMWxLeXdPK2habDF6QyswRFFUVjBmUHljZUFU?=
 =?utf-8?B?WlEzeHFUZWNlS3ROUXZMb0dpK0swK01MRVlySk8rcE1ISlJvVGlOZkhEWWZk?=
 =?utf-8?B?QllDbzFUM05GdDVReTVPeko0UllWcERtMGZlT1d5SFYrc21lTVJUUlN2ellj?=
 =?utf-8?B?MHUybnY3U0NrbGx4cVVmM29nSVZ2RDhiL2NJQXczaGFUOEg5U3UrTGJGZzJX?=
 =?utf-8?B?RHhCQXBPMzhXYnpaeFFTWXVjeHNlbkU5aEZFVGZ4cHZPbUk2T0xIby9QcHVT?=
 =?utf-8?B?ZnV0MkVOd3ZRY2k5RlJzQXU1SHNuVis5YkxQTTh5cUhhaVRIRENzc3BoYTda?=
 =?utf-8?B?eFNPRVNERjdFbXNpVys4cmVFL3VOS2hWQlRiVm9aNGFFNVo1c0ROK3VNRStT?=
 =?utf-8?B?SnpwMEpnV1gxWW1tbkVsSnNUZjZPcTAxMHQwUi9Sdlp0UC9EZEkxYnVWS2ht?=
 =?utf-8?B?VXN0SlFBUFBIL2Z2Z3NhTkRzcXp2eDdiTjllK1YwMm42VXhTZlNJM1daL3JO?=
 =?utf-8?B?OTU5LzRVMCsxTEJaeGsreTY2WTRBNkZ0V0pzaEVEUTRYOWw1b0xKWFZMWjdP?=
 =?utf-8?B?dlR5Q29vSkVSS2p5a2M0SDR4QnVYU05Gd3NBQ3FpWXNISlhGUWZUNkVHKzNQ?=
 =?utf-8?B?K1NLMkFrNzZZcG1SY0NGQWhodjV1aEM5cXNidDg4UU1nVlRmRmJHZjRYWkJO?=
 =?utf-8?B?Y1NNQ1VlLzNNM3N5YnBSZlRDQnJ6c0lUSTc4Q1U2QWNOcWZtUzJFUEZqS2tr?=
 =?utf-8?B?V1NsV2lSVjhMOVJaSlNCUmNJVnRuK2M1ZDcxU0Q3TG5GWkkvdENReDdwWUV0?=
 =?utf-8?B?eFpObG1HTE5ST2tBdmFDZjhMYlJvZkIxWW40VTVMS2JaUlNOb0VKMmxoNE8z?=
 =?utf-8?B?STU4Q1RJUmN5SGt4ZTJZYnM4LzNlYzZQb01ZTkdtdGhHZ1pZSk4vc1Q0SFlP?=
 =?utf-8?B?R2JxeG9wU05Pb3d3R0NQRm5JbmhhQ1dSRDJWa3RYMFo4aFZSeHhKWDNSaDA5?=
 =?utf-8?B?M3ZwRktQQ0hQcG5Ka21lMll3Q3ZWbUwrZTYzWFNjTTVRbVFXbnJLVmRTbzFv?=
 =?utf-8?B?UkplaU96ZWdvMWZDVnA4NGRRZmYyS011cDRDRWltSW4rUjIyc1MyRUw1VzY1?=
 =?utf-8?B?NDZHK3hPWkRXcHE3ZHUwYmRjVVE3YVBZT0c3WEcvWXVGMG4yY0lLbVFOYmFY?=
 =?utf-8?B?MTV1cXdjUDlrcnplR1lscGhGV0UxNlRsaHZlTHQ1c2VnRmxOUjhzRzhqUjE0?=
 =?utf-8?B?TzRwZEdKSkprSnIyVk5uaENjaVRVTWN0Y0tieXVTeUdkbVpxZWVralFiUmlI?=
 =?utf-8?B?TmFRQVB3aVc0dzlHNkRGYW5wNWN4Q1d0aEsvWVY3cDNDcWVUSkpReHVJS0lP?=
 =?utf-8?B?VENFMDlscTdPS2hjUnZwUGpKdjJDRS9NcXVBR0xVUkkxbjltUEJRM3BWb3J4?=
 =?utf-8?B?TXNUQ3FWTE1SWEdVbUxSM2djZVZuMmZqdTNrNG1EVDY4QjM1KzV0ckIreURs?=
 =?utf-8?B?dnpFdklYeGNGRjk4ZnJCOHB2cVhrcWdvdllmMjhxcDJvRmZzWlJETHpIaStj?=
 =?utf-8?B?d0x1QU8rZHdyRVhPQ0ZLK2Z1dTZwSjNVZnFGUzVVSjVnUndTdjQwcTJ6cXNh?=
 =?utf-8?B?QWF2SUZnZVk2UXd4elZucWx5MDFSNmpPVUdxdDNJOUpRUXBYR1czOXFmaitG?=
 =?utf-8?B?eTRMUGdLS2ZkbVhENUtUYUorZ3Q5M0M0V3ZxajdaK2tFL2FpL1VQWDBZNlhK?=
 =?utf-8?B?Mm5aWkxUK3lsb3FxMEpaSlpLNHdQcGtKV0FjdnBZdndSb21sN1JQQVNYVExF?=
 =?utf-8?B?SE1WK0dyS0FUcVcvVzltUXBuTjhKTnVTbEUzeFVabWhXbWNXZmphbVBXNzlQ?=
 =?utf-8?B?VnFKU2o3VXlBeXlvQ2xRMGpDaEtrQW5oYzZiUVI4WUxqNjVWb0dqRWR5ZHhX?=
 =?utf-8?B?OFpkOE9PbjNnSjV1UDM5RkpRd214d0puekdZREtJOGFSeEQ0cE9qWk9DdnlS?=
 =?utf-8?B?RUphMURWY3dYMFNRSkVlQXErTk5lSjhaeVo0cXBFT05mMFhneDlQSytxTWxr?=
 =?utf-8?B?ekZ6NDZuUXE2YUx3NkdTMmI4VmlTMjFId3Jia0ZGVjhXV040Z2podz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6872926-fbd9-4c6c-afaf-08deb644d807
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:53:13.1405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waMdf8sA2trmtssG/qNWFgwNDpMN7fpA7kz0C/d+iNzpM7wu+Zd+MwtLH1bCLg8J+YYUNGv3B068ZWtcb8+6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwNjo1Ng0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNi8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBFbXVsYXRlIFZDTURRDQo+IHJlZ2lzdGVyIHdyaXRlcw0KWy4uLl0g
DQo+ID4gK3RlZ3JhMjQxX2NtZHF2X3dyaXRlX3ZjbWRxX3BhZ2UwKGludCBpbmRleCwgdWludDY0
X3Qgb2Zmc2V0MCwgdWludDY0X3QNCj4gdmFsKSAidmNtZHFbJWRdIHBhZ2UwIG9mZnNldDA6IDB4
JSJQUkl4NjQiIHZhbDogMHglIlBSSXg2NA0KPiA+ICt0ZWdyYTI0MV9jbWRxdl93cml0ZV92Y21k
cV9wYWdlMShpbnQgaW5kZXgsIHVpbnQ2NF90IG9mZnNldDAsIHVpbnQ2NF90DQo+IHZhbCkgInZj
bWRxWyVkXSBwYWdlMSBvZmZzZXQwOiAweCUiUFJJeDY0IiB2YWw6IDB4JSJQUkl4NjQNCj4gYWN0
dWFsbHkgd291bGQgaXQgYmUgcG9zc2libGUgdG8gaW1wcm92ZSB0aGUgdHJhY2UgcG9pbnRzIGJ5
IGFkZGluZyB0aGUNCj4gaW5mbyBhYm91dCB3aGV0aGVyIHRoZSBWSSBvciB0aGUgZ2xvYmFsIHBh
Z2UgaXMgYWNjZXNzZWQuIFRoaXMgd291bGQNCj4gYWxsb3cgdG8gZGlzY3JpbWluYXRlIGJvdGgu
IFNhbWUgZm9yIHJlYWQNCg0KT2suIFdpbGwgYWRkIGZvciB2Ni4NCg0KVGhhbmtzLA0KU2hhbWVl
cg0K

