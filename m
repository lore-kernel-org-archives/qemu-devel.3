Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0BCCD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoy3-0000l0-Fc; Tue, 26 May 2026 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRoy0-0000hE-0q; Tue, 26 May 2026 06:24:56 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRoxx-0006cB-VY; Tue, 26 May 2026 06:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqp7yH7koO2S3bzgguYJE0IONMLxTp8MetUPpWTBUAYmnQe6wJdzSWvuZ3TG55vDuxOa+gSWQeA1BBt3m4bXL35Nsn51QuQ0K5nAtbowfCwL2tGTn+r4rr/Q59pkFVlimYyLl/8H1LN7sAknu4O+TsjVV4ps8xmYmV4h0vFyx1TSf+49rPZuTkrB89+0HdAFvn6UIwSAbOpn3/DTuqzsddtqV3pjMDbGMrEmnnJqdyYCusk8ec9yAg45zqbWOZnlGtUL/Z2Ci++nXiNOpbaFHRGCQsJFmB/iNKPHs+ItL1UfiK908GpsdnkZDF+1H3TTgWdmprhhp4SbfUZr/0t1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK7zPgZrpG3Ix2qeSwkxRcW7Q02IY2Y3DJCNCS4thvo=;
 b=me2wisoqgL9ljkhHiQ+ylzQe2DagG3kqPFf3YZVbLfPUPHiw20uTM8PkwbNna3x7BpROlDDob8PQR+ZZKET6HFTnAaPgE/YQeA2DhLXdxj3ZuUg2qMyasnIpjHZWEx0TMgloBWvuNdXL/nong+BLIXYy0ZVAKsnL6pkU6KxEqUsFRA+Klj8qhk3xy+e2bNbgQ5Pz/snQnYq1pd96Qvs084q7s0+ex1pla9NYv/a9BvaDGALpIU56ttU3txZknmwwarSYzay1h0HD+f+27gOThxP1p8kxhwFlKteNs/c9J3zpI4H/pXXPBnUpVxxbXBkSb6CeBRhJqGc+xyFy9oXxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK7zPgZrpG3Ix2qeSwkxRcW7Q02IY2Y3DJCNCS4thvo=;
 b=o3YyU+eBdVMeoL8GSW/8KACx8F2UL0okbcbYaEfLBGksSvkSl1qG3ekInmxHS7UFVSoxHqKTb3LGLCuuUl5OFQILwdFEt6lsL2cNmIKU9svetEebPJ4q7hHhr2qNWYpqPHAJcpRUPo8oCf02YfLdMtlCWK+lV3SRHmJPuXK9WdvF4NUS5baszbyXXrU6xm9KwDcFHzUCQKXuQ06Ka1i0aZ2nEF4eLq/kawnCupV78X/3TJj590GSmhLsdkwg6fL+RN/U4W1AZI7mdJMO0oCBFM1AX7q2Kl4UOlV6Exgm8fmEEQbxcNE+papTTVM3a88Lw4IBQdZk/NLgUXY61m+SCA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 10:24:47 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 10:24:47 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
Subject: RE: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Thread-Topic: [PATCH v5 19/32] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once
 configured
Thread-Index: AQHc53vTwyvnVGB0aUmjQj/zxQN4xLYYOb8AgAAIa+CAADn0gIAAjcwAgAb8vQCAABtW4A==
Date: Tue, 26 May 2026 10:24:46 +0000
Message-ID: <CH3PR12MB75483876FED87775450277C9AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-20-skolothumtho@nvidia.com>
 <166c5efb-0fa3-49f6-a1e7-faec85a6ec44@redhat.com>
 <CH3PR12MB7548314422301EA66803DD40AB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <69ec35de-1f7c-40ae-9ea5-3727c047c590@redhat.com>
 <ag9/KMztV/pb7lA0@Asurada-Nvidia>
 <e3af7e21-f5cd-47fa-85f3-d8744b529246@redhat.com>
In-Reply-To: <e3af7e21-f5cd-47fa-85f3-d8744b529246@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB7592:EE_
x-ms-office365-filtering-correlation-id: eb129913-e690-4cb4-0097-08debb1102e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|11063799006|18002099003|56012099003|10063799003|4143699003;
x-microsoft-antispam-message-info: bttt6dI4eoJuv0zMb5woMygUDX0/Y8zvR0iUo8A+zwvmIZBaI35jRdx4pS+n3ZA2Rxro6QNE2gA+veYL83WKH2Cn8r4IntFXRdl78bi5yfBZ8HekHRYjdK9P5lnsmlvbsfqJNBFtL9qNmU4JFm7Lfd7GjmRJTyug/wsscyx5/iKarYF/vUUmqZxeRXqX27ZKZd+lVBUKBUJpLnEtshhuhU5r8nJzj2U4Z9xC3Jao3piCMAp0JVBQxFLRl+QGhveJpwvSB9k4Ba+88Vo9BxrPpFDD56ezccAs2M8rPmGqU66zakyl2V52I5dPEUk7p3bzL0x24UTYrSTAOlvfKYhlOXxIRTfXuTFhAs3E5yVdKfufbGaO32nOlHbMQObEIUB5iJZcsLxjeDZPqO+OSdD5Mfhmd5VULE5xqd19SD5ZuOrXsU29MJEE9YMAAQx3KKMnXQgXs/gsAlxhn3C56boLOSfNbFHmb2QJDSCOohZCTDNiOqpnIy6lQtb2qSk8uIefZN5v7ZwXRo7Hf20NiKw+5ECEDmIMowIgNqRLWUJdA1Wx/qBKtqtJ+oDwuw11LqlZ+iDcpVjtwkqdQOVPsga+CcDO3jd09BadC1I2PGp7K+FJky0km4n/rrACfAMszDpBnPp2NxmaK0JbzhMuBRGhNWNDQHNz/lPmCODQ6WuoU519rSO2lGgsLsvcNCCcQL8v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(11063799006)(18002099003)(56012099003)(10063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NaVUZacDJFWkxQYTUzS2FTWjBuNU41OHFiMzdHYVpvazBuWWNJUzg2VGtE?=
 =?utf-8?B?RjdkYWZNOEY3MTcwOHdnR0RUcjhraEZ3ZnU0YVNwOXpWRXVCNUc1d0JtVG42?=
 =?utf-8?B?MlpLMlNteFhZYTlDSktNQVpkdm15QzJ5Z1RPWXFENUMvNFJZaVdoWnZQV0xj?=
 =?utf-8?B?Zm9UK3IzOHhscGIrZ3hZNVNnNVdseUd4MVFicFd0YzdFOWdLQVZwUFNwT1lq?=
 =?utf-8?B?ZFJhMDVyQ0UxelZ4aDg1RGJXd1V6Ti9kbHJEOHpiUFViVmJ1VjhITDJOQ0Ix?=
 =?utf-8?B?OWFnbkREaGhGRithcnVZa01GS2hmZXp4UC9oNk1UQng1TDhDM2RnS1EvYTZq?=
 =?utf-8?B?M3hFWEhncENuSVAzcnk0QzlaaGZkMUUzZlhhOWFoR3RKQ0daamhONlVmVm1p?=
 =?utf-8?B?QjhmbjdpZkhja3A3SVBmQitXTG1UcGpJL1lTMW14cW9QOXpyREVzL29hZWtk?=
 =?utf-8?B?L2xsSkpmOHhNcjBkK09KM1lMcU5HZEhvSlRnZnlMM0lZMFVHdWx1VWlZQTFZ?=
 =?utf-8?B?YVNQZ0RtazlJdjdUVWNIRHlMUHRybzVTSmRPTmtJOEZrck1TYTM1ZnR5c3Jr?=
 =?utf-8?B?bHZQeldFU2owMDdjZXJxRjZZU1ZtanZCQmlObDI0Rm53QmVPRi9vNVhQT2tk?=
 =?utf-8?B?K0dodWRsZ3VBMjZPNi8vZFgrZTErVVBrK0x6MkxMdktwOFJ3TFQxeGZLc2l5?=
 =?utf-8?B?SXNOMnQ3ZUhvZkVKMGF4NTV3eVNLSnB4NzZ3djZhVDFJd0ZJMFZKMjJ6cUt1?=
 =?utf-8?B?Y0tyTng0U2U1MXZBeTJreit3MmRZdjNsdFpYaVE0VjhzcVFnMjdsSTdiKzJl?=
 =?utf-8?B?ellESnJoSWJER2RwTDJ1aEdaYTFaNFNtb054NDhscjloaE03NngxVjExOWFI?=
 =?utf-8?B?RGhsVC9WalZGY0haMDN2bVo5NHlLL1JsRXZXcmFhK0sxZmhHN2NPcnRSb3RR?=
 =?utf-8?B?Vml6OThWOGt5aE1XOXhON0NiV0VDMjcrT21tekllaEM1RW84N2V4Z0tmbUNW?=
 =?utf-8?B?S0lheHdLUk1WUnVTZHo2Z1RRVUR2YlRpVmpIa1ZJTFdia3pYLytlZ3pEWFpZ?=
 =?utf-8?B?a1g0VTA5QTFKdlB3WVkrZUtVVC9IRUlZQTY4K0xNUkVSZXJhUHIxK2MxeWJy?=
 =?utf-8?B?Y2RKbkt3RG1BQ2V1VUJPQWU0OGNRM29yN0JRZ1JLelVnWGI5WXd2UGVRSEVv?=
 =?utf-8?B?eGl5VC9XVXhkK00rdUtaQkVEbEdMaXZGaVowNGgwMCtCUjhJYXBmaGdybTNm?=
 =?utf-8?B?NmliZXZvbWU4TFM1allHQnZobjR0QzlJdnd4R2EvSFZ5VkJMOFJmSHdOdnNW?=
 =?utf-8?B?bmZtd0pBc3ZTc3VNSHV5L0t2NCtyY0M4WGdwR3RFcDRwbFdHdXR1M25Sbklw?=
 =?utf-8?B?eWpzY1d5UWNOWUZiVGh2cll0akprWW1ZNi9TQ0dLb2xIWmFhRUtvZnFjbXlo?=
 =?utf-8?B?REtzdCtSSVRDZ1FrZ0ZGV05sUjM2ZStBcXVEVloveGRvc2NsQTQ2TU5ta0JG?=
 =?utf-8?B?aWkrcVJqYzFJdDJNd0hqK0VRRTRyRzRFZURLUkc3QTRPYTY4UHI0eWJaZUpI?=
 =?utf-8?B?R0ZUK0hKa2N2Uk9lTU1hdnlSOWhSK3hyS0VxaUxWRUtXbHc0OGRBdEFzUG9G?=
 =?utf-8?B?eFVkL21idmZ4TUZ5eS8xb0g0eW5rV2pVTEZuZkh6ci9ZY1U2YjJOOHc2TUNO?=
 =?utf-8?B?VjVJSjNzLzJ1T1RkR2NwemU4WkZGZXliTmMvYTdPRThQUHN1YVIxMEozMzNn?=
 =?utf-8?B?Z211djVYbVl1dUdST3RkT213N0ZyTXJ6dkplNmNyZDV1RWpRYUZWT1ZHeHJC?=
 =?utf-8?B?M3piSUdKOFFIM2dnMDFVSXM1aUJVejhCcXdCVFltZjk1dVJoRENYdHRPcno4?=
 =?utf-8?B?VW9wUkhmWG90MEhKbk5VN2ZNTEZlbnpiZTFaaG5vMmhudHJrcFl1bGRiYkZR?=
 =?utf-8?B?K0FSSE9rTEd6cmpFa01JdzFoM01sUlFwaGRmR2Z1RElQd0dSMkxOTmp4dG1E?=
 =?utf-8?B?djBXUmZQN0w1RlRLcDU0ZTBXWFlhSnMvdWVpWXlqR3RPcE5zU0JBQUl4UnFx?=
 =?utf-8?B?TjNGTDluby9YLy9YZnhaMUxvVWdTTnM2ZUY5NGpmU3F4RnEvenNGcFh3WnFG?=
 =?utf-8?B?RWxCYisyT041aUVNeEdUTjdwejB2amw4cmt4WFc4VDdwaG81ZGQ5ZFJ6TFhK?=
 =?utf-8?B?eUx2UGU0bmJzbjFLYmZBSTJEWHk3RmwzQXZuUm9SZUNSdkZMdGMrVndXY29N?=
 =?utf-8?B?ZU9zYWNyQUdXMGI1bzMzNFM4WGg1K283eDZ1ODdwWngzbEs5SUlpeVZuazJ4?=
 =?utf-8?B?djA3em5MSTZoSTFOenJ6T2V4cDhoZ2tGUXA0TzRNYUYvQXhwMmZCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb129913-e690-4cb4-0097-08debb1102e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 10:24:46.9731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jz+eyZSsQS/j8OrZTbGLuwt1ucPwEf/hNdbUPVRKw1zqFNN28NIml44Q0LUgMKiRG87IMdPFkn8YZTeq/6gydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAwOTozNw0KPiBUbzogTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBDYzogU2hhbWVlciBLb2xvdGh1bSBU
aG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+IGNsZ0By
ZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsNCj4gTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxOS8zMl0gaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2OiBBbGxvY2F0ZSBIVw0KPiBWQ01EUXMgb25jZSBjb25maWd1cmVkDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IEhpIE5pY29saW4sDQo+IA0KPiBPbiA1LzIxLzI2IDExOjU0IFBNLCBO
aWNvbGluIENoZW4gd3JvdGU6DQo+ID4gT24gVGh1LCBNYXkgMjEsIDIwMjYgYXQgMDM6Mjc6MTdQ
TSArMDIwMCwgRXJpYyBBdWdlciB3cm90ZToNCj4gPj4gT24gNS8yMS8yNiAyOjI2IFBNLCBTaGFt
ZWVyIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+Pj4+PiArICAgIC8qIElnbm9yZSBhbnkgaW52
YWxpZCBhZGRyZXNzLiBUaGlzIG1heSBjb21lIGFzIHBhcnQgb2YgcmVzZXQgZXRjLiAqLw0KPiA+
Pj4+PiArICAgIGlmICghYWRkcmVzc19zcGFjZV9yYW5nZV9pc19yYW0oJmFkZHJlc3Nfc3BhY2Vf
bWVtb3J5LCBhZGRyLA0KPiBzaXplKSkgew0KPiA+Pj4+IHdoeSBkbyB5b3UgbmVlZCB0byB0ZXN0
IHRoZSB3aG9sZSByYW5nZSBhbmQgbm90IG9ubHkgdGhlIHN0YXJ0IGFkZHJlc3NhDQo+ID4+PiBU
aGF0IHdhcyB0byBtYWtlIGl0IG1vcmUgZGVmZW5zaXZlIGJhc2VkIG9uIHY0IGRpc2N1c3Npb24g
aGVyZToNCj4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvYWZ0JTJGRFRG
THFRbnVmeldsQG52aWRpYS5jb20vDQo+ID4+Pg0KPiA+Pj4gUGxlYXNlIGxldCBtZSBrbm93IGlm
IHRoZXJlIGlzIGEgYmV0dGVyIHdheS4NCj4gPj4gV2VsbCBpdCBpcyB1bmNsZWFyIHRvIG1lLiBZ
b3Ugd2FudCB0byBtYWtlIHN1cmUgdGhlIEdQQSB3YXMgZnVsbHkgc2V0DQo+ID4+IHRocm91Z2gg
dGhlIEggYW5kIEwgcmVncy4gVG8gbWUgdGhhdCdzIGVub3VnaC4gQXMgZmFyIGFzIEkgdW5kZXJz
dGFuZA0KPiA+PiBOaWNvbGluJ3MgcmVwbHksIHRoZSBrZXJuZWwgY2hlY2tzIHRoZSByZXN0LiBC
dXQgcGxlYXNlIHN5bmMgd2l0aCBKYXNvbg0KPiA+PiBvciBOaWNvbGluDQo+ID4gWWVzLiBLZXJu
ZWwgY2hlY2tzIGlmIHRoZSByYW5nZSBpcyBpbiB0aGUgc3RhZ2UtMiBwYWdlIHRhYmxlLCBpLmUu
LA0KPiA+IG1hcHBlZCBHUEFzLiBPbmUgY2F2ZWF0OiBtYXBwZWQgR1BBIGRvZXNuJ3QgZ3VhcmFu
dGVlIGl0J3MgaXNfcmFtLg0KPiA+DQo+ID4gU28sIHdoYXQgaWYgdGhlIEdQQSBpcyBpbiB0aGUg
SU8gc3BhY2UgKFBDSSBCQVIpIG9yIHJlc2VydmVkIHNwYWNlDQo+ID4gKGZpcm13YXJlKT8NCg0K
TG9va2luZyBhdCBvdXIgaGVscGVyIGFkZHJlc3Nfc3BhY2VfcmFuZ2VfaXNfcmFtKCksIGl0IGlz
bid0IGZvb2xwcm9vZg0KZm9yIHRoZSBhYm92ZSBjYXNlcy4gRm9yIHRoZSBQQ0kgQkFSIGNhc2Ug
d2UgY291bGQgYWRkOg0KDQogICAgaWYgKCFtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikgfHwgbWVt
b3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKG1yKSkgew0KICAgICAgICByZXR1cm4gZmFsc2U7DQog
ICAgfQ0KDQpCdXQgSSdtIG5vdCBzdXJlIGhvdyB0byB0YWNrbGUgdGhlIHJlc2VydmVkIHNwYWNl
cy4gRm9yIGZpcm13YXJlIFJPTQ0Kd2UgY291bGQgYWRkIGEgbWVtb3J5X3JlZ2lvbl9pc19yb20o
KSBjaGVjaywgYnV0IHRoZSBvdGhlcnMgd2lsbA0Kc3RpbGwgbG9vayBsaWtlIG5vcm1hbCBSQU0s
IHNvIHRoZXkncmUgaGFyZCB0byBkZXRlY3QgYXQgdGhpcyBsYXllci4NCg0KPiA+DQo+ID4gQUZB
SUssIGtlcm5lbCBkb2Vzbid0IGhhdmUgYSB3YXkgdG8ga25vdy4gU28sIGl0J3MgVk1NJ3Mgam9i
IHRvIGRvDQo+ID4gc28uDQo+IHdvdWxkIGl0IGplb3BhcmRpemUgdGhlIGhvc3QgaW50ZWdyaXR5
IG9yIHdvdWxkIGl0IGp1c3QgYnJlYWsgdGhlDQo+IG1pc2JlaGF2aW5nIGd1ZXN0LiBJZiB0aGUg
bGF0ZXN0IEkgYW0gbm90IHN1cmUgdGhpcyBpcyBjcml0aWNhbCB0bw0KPiBjaGVjay4gV2UgYXJl
IG5vdCBjaGVja2luZyBlaXRoZXIgd2l0aCByZWd1bGFyIFNNTVUgY21kIHF1ZXVlcw0KDQpJIHRo
aW5rIGl0IHdvdWxkIGp1c3QgYmUgdGhlIGd1ZXN0IHNob290aW5nIGl0c2VsZiBpbiB0aGUgZm9v
dC4gQ2FuJ3QgdGhpbmsNCm9mIGEgaG9zdCBzZWN1cml0eS9pbnRlZ3JpdHkgaXNzdWUgaGVyZS4g
U28gd2UgY291bGQgZHJvcCB0aGUgY2hlY2sgaWYNCnRoYXQncyBwcmVmZXJyZWQuDQoNClRoYW5r
cywNClNoYW1lZXINCg==

