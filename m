Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A1BEBFD03
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCB9q-0000Es-Fa; Mon, 13 Apr 2026 02:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCB9n-0000Ef-SC; Mon, 13 Apr 2026 02:52:28 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCB9k-0004fj-Co; Mon, 13 Apr 2026 02:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjaGnc1ELCB04fKQ2EfgnReed0SHwE5OS6zqDhFpxTlgD2+T0FQlHEm/6k1wEDicn1kBi3HbD3b/5WzuXOcv/ryoFS/r9+iDmI9JoKwfCBTHBOxoi5f/oxF5WezEl43tR5iLDg4EbdVyJrIC33OxIqw3uOsEmo8ztTtc40PfmzZpPflUlQ7A35kkpb5FHfDrvjAo8lr2FOcnAmIH+224ddXKVQ4fIJA7W4XAUnCWPA83f5vVOSzqEpD0Mbc2xDplebhahBPqqcmSurBe44V16PdXADKBAhSwnmRZjBREFcfdXcxMKgoc9UP6okTzGl47/slXzHsCCA7MD1H2DZkV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTN1SLwRyETjKGgXJP1ui6+ejTCr0LtRbfOdFpQdivE=;
 b=pn84DcRsrGzhZ1DoGdTsOu8eqxMJQ0047EXAaKediv3MpyM1Y8PPTUn9SoGgRbBZMNz26ZVOCxU2Jn7ol8XvIHEgqmQcwrLLFXVxsGtlXSuuVvZAA7MkcFXk15AXNm3+ehWvJgvN5qh+ljlz/Q+kWK+JSbaiKoZuhNUVIkyjUcKWL1Xvs0PM+sDgR37HVPtQYH2rVUeyfeyMnzvWqYq6164dozHN9rBb4rYtujxKUGu+ABjqddxdlEwg9FZaAd0i0pWFBUA8KgjTXHxybcDEpK0/uWmgMdAeQgbijLO57kE1kBkRV6fi4wmvEv9ZxJjfBqQfsg3kSoQSw9scD395iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTN1SLwRyETjKGgXJP1ui6+ejTCr0LtRbfOdFpQdivE=;
 b=hgcZbcTIH6vOsSaBIoBHIvNot4WDubWzVQ7HgHH+UVa3nXAyDtOvDlL+x4JSm664jrVTyZI4X1vlEHwZ4A2eCTfjCowM/GOubY3Z7Y3bgHpn97Ge8+69AycuqvfHccMdJ1n5eHPOljyIWKghSX5fgwtaGavXI1o5ev4uSH2J9jStz0tEd6iRtVmGmKPfzbv5njwAEqgBQrVZ8KWF6/d0SAtIlLbTJAKtSgJD4OGBmMB+n01kX522Jp04BoQmW2IvGY1nlM3WDJxJSKbEiEzbx9UxbEzv+sATELJajZlX+3sIkI10H4o/iNiqwIHfyuVd2UjPEeeiZ2U1THs6wRCiRQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 06:52:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:52:17 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHcpw4RCbTPqX85HUillxSq8Ev4K7WpcF+AgDNiu3A=
Date: Mon, 13 Apr 2026 06:52:16 +0000
Message-ID: <CH3PR12MB75480F31CCCF15142514109CAB242@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-18-skolothumtho@nvidia.com>
 <e5764435-fba0-43d6-8402-4f0b74bada88@redhat.com>
In-Reply-To: <e5764435-fba0-43d6-8402-4f0b74bada88@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB8776:EE_
x-ms-office365-filtering-correlation-id: 20e329e7-9542-4f64-c872-08de99293383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: OAMNdG3FWfp6dMiE//52gyrO12Ley6g7fET9lZQTWphuOPIxlmN2ZoEKCs+mSF2AnyigGV/PH47ndmQ41xptyT2vBFpua9RZfCgddxo8PfTlO71cTCULYYJaUVm+g0pvf8peRKMMFcU+c08lhNyYcOQNtnUUfXXQuMQJ9wspQ+6alVp67SgX2qxSOHLZ6/HFp67yZh7ZFe7QjXL8vZvo2dGOAGDRx5XODMyP4C9oMsHM2XzJxyaBHw2fYrhPvSlxwvztg/ZMObyQs0jBAnbGn0Enyp6uygi3jmqpjoGSCt49KKTj+tJQiNYRNR+Un9dbB5wP2W5zzZovEhsryJyTEP5jvTgCUwpZWoFPiJi5SaBRLpK2mlMSm8F5tilGir/F9+R/hFHskxrlH9WfBwK0rQQSudvLR8TA9/emno5CBYCdl9L/8Ju+kx26SrIZfGYUo9Y7G2iUKcrcIdIS5YD2mob6GuAmIMCjEbFVC/aFGQWzQ3A6pbzYZ4Lbmsz6Ld8c51aWItRP1Ugxo0RvCPAP2egyQXdUWAPmIvERC3JgwutWejCTdZzjd5C0BjntpZD4YzXNOUw3fVH+a+fopU7yMq+nNTXoHaRV3Zt2yhY7yJ5CDTlEruzwaeP9p3cSeDKmDQLPpwRTwW3VfrDC9SF6d1tnC0VZ2u7Y9Ew5pUSTOdz7N7N8UyXC1JjuTck9S9RFjEfjBGgW79nIGRDeGXhwC7sBGnybUl6rEiJgwmc2Btdhdtshhq4e1w73YYuUSAANE9X8zHvuUXprp+GmNoD7fphvOVsW6klTvqbFBzBuvdk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGE4Sm5CRm5tRVZNcE83QUI3Sk1lamdsZXBkenJsa3prRUcyOGIyeFpRWmp1?=
 =?utf-8?B?V0JsR1U2SWNzckFwSC9oS3JuYXNqS3NJNmZ3aVhRNklFemc1ZGdSYWdEbVpp?=
 =?utf-8?B?STlhVHdiOEhvd3lxNDliRnNkQWIzd3BJN1RrMG1XK01UQ2lOc21CYmpwTytz?=
 =?utf-8?B?WUNVcWVNUnpoN2loRUxyV3hRRVZHUXRobHFvdlpybTdlaXJVbXBDcGVoNE9o?=
 =?utf-8?B?clg3eUVDcVd1bnoxRnpTVEp2Y2VpRFI0Z2twdG85L2Z5NllkR1U4U2pVckht?=
 =?utf-8?B?RzRLRDZNSHRtY1lVK3lXQmhNSlE0RnpsZTVnSGlPcDcyNWJxb2xUNXpjWnYx?=
 =?utf-8?B?dXhSclptMlFDMXQxaWFjNGZLSUU1cHNIaHBoUWF4UGVXMWZCSzZBcFVnMk5F?=
 =?utf-8?B?UHVqM0pNc2xuUnRUbXFKcGtqQ1p2QnQvd1lBOHlQbUlmYkxYRUMrQ0k0cDkv?=
 =?utf-8?B?ZDZFQXhVT2RFQ1AyVWduU3BPZDJvZlhmbHJQd3BhbGZLWUREaklPZlNoMWwr?=
 =?utf-8?B?ZkNMTlUycENiVzBycmc0Y1k4dnBmelhzeitTQVZnZ0R5VzdqaEZaamQvb25v?=
 =?utf-8?B?WTI5Sm0zRjdvOFBWQTc2Y0dBcVZTVXkzTW5FVG1hc3RmNzh3RTdFZ3NaRlJP?=
 =?utf-8?B?R2IwWHZ5bjltVk83WUhZZnRiam1EcWs3aGZlSFlOeVh6bFVBTGtoMEFUQzgx?=
 =?utf-8?B?anVVN1VkQS83UjAvaGNudk4xd0w3V0tkREVNY01qeXFVN2oxM1M1TmVQVlBj?=
 =?utf-8?B?TFhaUmFGQlRZcjMyTm5SU2JKNG96L2VtcEE0Z1d1UEliTmcraHdVQkV3aU8v?=
 =?utf-8?B?WUVseXJmU2JyUVpscTVOTEs2VngxTUdRSkU0VmRMY1d4cUR0c2JmMlpOS1o5?=
 =?utf-8?B?TVdBNGcyN2padmgzWlVmVDYyRDlFQWN4NlFUNUNhVER4empwVTJ3NUtYMWt4?=
 =?utf-8?B?QUc2MWJHNE0rWGd4S2N3bi82ak53dGlVaGdGbCttbVZlNVVWcmh2Sys3RDB2?=
 =?utf-8?B?S2JJVGRSS3BSYmIyWFQ4ZDcwNzhaSEVUUVg0K2tsSG9wUkRXeGU0ZTdnWi9t?=
 =?utf-8?B?SVFjZHgreHlKOTVta1NtN0FEeFlTbXlFMXdEVFhSREQ1RUlUVEMrVUVsa1V5?=
 =?utf-8?B?SkZENnpRWDBUTUpHU1FBZXNzZzljVUF2THBLK2x4cGFhR2ZCYzVRWkZiYy8v?=
 =?utf-8?B?djVBMGRKSUVULy9MYUs3alN1TUNzVjVyYkhERDB6em0zWVhuRGswTVhzSzBa?=
 =?utf-8?B?YzdTV05wVnRhV0t1WVd1Y1c5N01zOWlsYm91OCs4VVdKVzRiaHFkNzlIb1px?=
 =?utf-8?B?ZzNUc1hJWnJ5bnNyWCt0ajJESjhMME9MYm9UbStPaHUrc0VJV2gzNi9rNzk3?=
 =?utf-8?B?SDJXNG4wZVRLcWFueHFDRloxKy9Sb3h6dzdGcTFKRVNoanU5M2tlcmFZdEti?=
 =?utf-8?B?TDBFSWZPWTRxdmM3RDViT2VaeFZPVjlJR2o5UkFKRkRjbnZzQjBXNGhDOVlG?=
 =?utf-8?B?QkpWek1vRm5FczVKaTBQZ25WYnBIeG1wNFNtSFo2UlBOcUxtNGhleUtpZW05?=
 =?utf-8?B?Y0s3NG5PS3htbXdPVi90ckZTUFhRejNHaGdrR2VNME5wK2FYb2R3UE93ckFC?=
 =?utf-8?B?aVZGUzg3YU1oOGlMVkwxMVlXVjlOU01NeXQ1L0JVTDRWbG5Xdy9wVzFFandS?=
 =?utf-8?B?RldlMDNQWVl2S3FrQjhUQjJJV3Z6NHJQOFcwK2NGYmg0ZlhNbUcyVkczWTln?=
 =?utf-8?B?QXJPbDFBOTZ0cDZqclg1UUx3aGY0SzBmWG90WGxHSGwwellyZXFJaEVHUTZC?=
 =?utf-8?B?b0JmT1JvVjVkK29UNTdERGZNMFpmRW54cjFoRDJYOElpWFFyeHFnV1ZQMkFh?=
 =?utf-8?B?RXo4Z0ZVaTFuaW4raFd5WDNwbG5jbDZzb2tOeVcyUGNHZkIwRzhocFV0bWlp?=
 =?utf-8?B?RC81Z3pTaU1XUVlqeXMvdDkrQyt5Wnc3TW9aTlFCTjhVclZyT1NzWGxPNnhu?=
 =?utf-8?B?U2x3U1hudHFLanZFWFJHWU0rcStnY0ZNYzJVZWVud0dRdVM0UkdPZTJ1TjIr?=
 =?utf-8?B?VFA5OTVHVGNZMmk1VmJ4ZERpRU4yOGRyc3JGZXNOWGl5ZlZCTnFiZ05kL1JF?=
 =?utf-8?B?YytXNUJ4cEw2ZzRPYUFWSm1XNUFJQlJKN1dvd2Z0TjlRQXpzVmNvRmVNbE40?=
 =?utf-8?B?bnBpN3M5ODdMVkRzcFhwRGFaK3E0b2p4Z0xLWDlsbTBVOUFHTDdJVE5QZWZu?=
 =?utf-8?B?aWVmMkcrZ0todXBaTzQvMG1wUnhDZmVPRVo1bHk3KzA3QVR6MFY3MUliakpQ?=
 =?utf-8?B?d2F5dkxCUzlNOWdkNVQxYTd4Q2IxRHN5M2pzK1YwWEk1OThvMWtGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e329e7-9542-4f64-c872-08de99293383
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:52:16.9536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ef37TvtO9sJy8j/OVTSxjw3e/1ShB0qyS/xd0cI21lPgE0pe02S/w4qcegmF4yhWGs7FpCyMu9chbhSG/P5Ydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDExIE1hcmNoIDIwMjYgMTM6NTkN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsg
Tmljb2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuIENoZW4gPG5hdGhh
bmNAbnZpZGlhLmNvbT47IE1hdHQNCj4gT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBB
biA8amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsg
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsg
emhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlk
aWEuY29tPjsgcGhyZGluYUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTcv
MzJdIGh3L2FybS90ZWdyYTI0MS1jbWRxdjogbW1hcCBWSU5URiBQYWdlMA0KPiBmb3IgQ01EUVYN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gT24gMi8yNi8yNiAxMTo1MCBBTSwgU2hhbWVlciBLb2xvdGh1bSB3
cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4N
Cj4gPiBHbG9iYWwgVkNNRFEgcGFnZXMgcHJvdmlkZSBhIFZNIHdpZGUgdmlldyBvZiBhbGwgVkNN
RFFzLCB3aGlsZSB0aGUNCj4gPiBWSU5URiBwYWdlcyBleHBvc2UgYSBsb2dpY2FsIHZpZXcgbG9j
YWwgdG8gYSBnaXZlbiBWSU5URi4gQWx0aG91Z2ggcmVhbA0KPiA+IGhhcmR3YXJlIG1heSBzdXBw
b3J0IG11bHRpcGxlIFZJTlRGcywgdGhlIGtlcm5lbCBjdXJyZW50bHkgZXhwb3NlcyBhDQo+ID4g
c2luZ2xlIFZJTlRGIHBlciBWTS4NCj4gPg0KPiA+IFRoZSBrZXJuZWwgcHJvdmlkZXMgYW4gbW1h
cCBvZmZzZXQgZm9yIHRoZSBWSU5URiBQYWdlMCByZWdpb24gZHVyaW5nDQo+ID4gdklPTU1VIGFs
bG9jYXRpb24uIEhvd2V2ZXIsIHRoZSBsb2dpY2FsLXRvLXBoeXNpY2FsIGFzc29jaWF0aW9uIGJl
dHdlZW4NCj4gPiBWQ01EUXMgYW5kIGEgVklOVEYgaXMgb25seSBlc3RhYmxpc2hlZCBhZnRlciBI
V19RVUVVRSBhbGxvY2F0aW9uLiBQcmlvcg0KPiA+IHRvIHRoYXQsIHRoZSBtYXBwZWQgUGFnZTAg
ZG9lcyBub3QgYmFjayBhbnkgcmVhbCBWQ01EUSBzdGF0ZS4NCj4gPg0KPiA+IFdoZW4gVklOVEYg
aXMgZW5hYmxlZCwgbW1hcCB0aGUga2VybmVsIHByb3ZpZGVkIFBhZ2UwIHJlZ2lvbiBhbmQNCj4g
PiB1bm1hcCBpdCB3aGVuIFZJTlRGIGlzIGRpc2FibGVkLiBUaGlzIHByZXBhcmVzIHRoZSBWSU5U
RiBtYXBwaW5nDQo+ID4gaW4gYWR2YW5jZSBvZiBzdWJzZXF1ZW50IHBhdGNoZXMgdGhhdCBhZGQg
VkNNRFEgYWxsb2NhdGlvbiBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIg
S29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0v
dGVncmEyNDEtY21kcXYuaCB8ICAzICsrKw0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYuYyB8
IDQ0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuaCBiL2h3L2FybS90ZWdyYTI0MS1j
bWRxdi5oDQo+ID4gaW5kZXggZDM3OWI4ODYwYy4uM2NlOWY1MzlhZSAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRx
di5oDQo+ID4gQEAgLTE4LDYgKzE4LDggQEANCj4gPiAgI2RlZmluZSBURUdSQTI0MV9DTURRVl9N
QVhfQ01EUSAgICAgICAgICAgICgxVSA8PA0KPiBURUdSQTI0MV9DTURRVl9OVU1fQ01EUV9MT0cy
KQ0KPiA+ICAjZGVmaW5lIFRFR1JBMjQxX0NNRFFWX05VTV9TSURfUEVSX1ZNX0xPRzIgNA0KPiA+
DQo+ID4gKyNkZWZpbmUgVklOVEZfUEFHRV9TSVpFIDB4MTAwMDANCj4gPiArDQo+ID4gIC8qDQo+
ID4gICAqIFRlZ3JhMjQxIENNRFFWIE1NSU8gbGF5b3V0ICg2NEtCIHBhZ2VzKQ0KPiA+ICAgKg0K
PiA+IEBAIC0zNCw2ICszNiw3IEBAIHR5cGVkZWYgc3RydWN0IFRlZ3JhMjQxQ01EUVYgew0KPiA+
ICAgICAgU01NVXYzQWNjZWxTdGF0ZSAqc19hY2NlbDsNCj4gPiAgICAgIE1lbW9yeVJlZ2lvbiBt
bWlvX2NtZHF2Ow0KPiA+ICAgICAgcWVtdV9pcnEgaXJxOw0KPiA+ICsgICAgdm9pZCAqdmludGZf
cGFnZTA7DQo+ID4NCj4gPiAgICAgIC8qIFJlZ2lzdGVyIENhY2hlICovDQo+ID4gICAgICB1aW50
MzJfdCBjb25maWc7DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jIGIv
aHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBpbmRleCBlMWYxNTYyYzQ0Li5hMzc2N2E4NWEz
IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gKysrIGIvaHcv
YXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBAQCAtMTUxLDYgKzE1MSwzOSBAQCBzdGF0aWMgdWlu
dDY0X3QgdGVncmEyNDFfY21kcXZfcmVhZCh2b2lkDQo+ICpvcGFxdWUsIGh3YWRkciBvZmZzZXQs
IHVuc2lnbmVkIHNpemUpDQo+ID4gICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9v
bA0KPiA+ICt0ZWdyYTI0MV9jbWRxdl9tdW5tYXBfdmludGZfcGFnZTAoVGVncmEyNDFDTURRViAq
Y21kcXYsIEVycm9yDQo+ICoqZXJycCkNCj4gPiArew0KPiA+ICsgICAgaWYgKCFjbWRxdi0+dmlu
dGZfcGFnZTApIHsNCj4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gKyAgICBpZiAobXVubWFwKGNtZHF2LT52aW50Zl9wYWdlMCwgVklOVEZfUEFHRV9TSVpF
KSA8IDApIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiRmFp
bGVkIHRvIHVubWFwIFZJTlRGIHBhZ2UwIik7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiA+ICsgICAgfQ0KPiA+ICsgICAgY21kcXYtPnZpbnRmX3BhZ2UwID0gTlVMTDsNCj4gPiArICAg
IHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgYm9vbCB0ZWdyYTI0MV9j
bWRxdl9tbWFwX3ZpbnRmX3BhZ2UwKFRlZ3JhMjQxQ01EUVYgKmNtZHF2LA0KPiBFcnJvciAqKmVy
cnApDQo+ID4gK3sNCj4gPiArICAgIElPTU1VRkRWaW9tbXUgKnZpb21tdSA9IGNtZHF2LT5zX2Fj
Y2VsLT52aW9tbXU7DQo+ID4gKw0KPiA+ICsgICAgaWYgKGNtZHF2LT52aW50Zl9wYWdlMCkgew0K
PiA+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlm
ICghaW9tbXVmZF9iYWNrZW5kX3Zpb21tdV9tbWFwKHZpb21tdS0+aW9tbXVmZCwgdmlvbW11LQ0K
PiA+dmlvbW11X2lkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VklOVEZfUEFHRV9TSVpFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY21kcXYtPmNtZHF2X2RhdGEub3V0X3ZpbnRmX21tYXBfb2Zmc2V0LA0KPiBJZiBJIGFtIG5v
dCB3cm9uZyB0aGUgbW1hcF9vZmZzZXQgaXMgb25seSBhdmFpbGFibGUgYWZ0ZXINCj4gaW9tbXVm
ZF9iYWNrZW5kX2FsbG9jX2h3X3F1ZXVlKCkuIFNvIEkgd291bGQgc3VnZ2VzdCB0byBmaXJzdCBp
bnRyb2R1Y2UNCj4gdGhlIHBhdGNoIHRoYXQgZG9lcyB0aGUgaW9tbXVmZF9iYWNrZW5kX2FsbG9j
X2h3X3F1ZXVlIChpZS4gMTkvMzIpIGFuZA0KPiB0aGVuIHRoaXMgb25lDQoNCg0KICBUaGUgb3V0
X3ZpbnRmX21tYXBfb2Zmc2V0IGlzIGFjdHVhbGx5IHBvcHVsYXRlZCBkdXJpbmcgSU9NTVVfVklP
TU1VX0FMTE9DICh2aWENCiAgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX3Zpb21tdSgpKSwgbm90IElP
TU1VX0hXX1FVRVVFX0FMTE9DLiBJdCBpcyBzdG9yZWQgaW4NCiAgY21kcXYtPmNtZHF2X2RhdGEu
b3V0X3ZpbnRmX21tYXBfb2Zmc2V0IGF0IHZpb21tdSBhbGxvY2F0aW9uIHRpbWUgYW5kIGlzIHRo
ZXJlZm9yZQ0KICBhbHJlYWR5IGF2YWlsYWJsZS4gaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3X3F1
ZXVlKCkgb25seSByZXR1cm5zIHRoZSBod19xdWV1ZV9pZCwNCiBub3QgdGhlIG1tYXAgb2Zmc2V0
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

