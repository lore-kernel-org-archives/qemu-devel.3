Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF32F327CD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF7Rq-0006JQ-SA; Tue, 21 Apr 2026 05:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wF7Rb-0006HA-5A; Tue, 21 Apr 2026 05:31:04 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wF7RS-0006Zt-5F; Tue, 21 Apr 2026 05:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReievCBMJlc39ixz3iCpPKMYyzIlWQirOMYhbgF3rn7B3EVAJbPWJvMEz+N2r+hXImOOIaHuxBFsdc6XMeFoJH3xBueP6Mdw7pM7Gn2zoVHRcQs5xwn3hWMpbUWU29Z+yQHkhs6O50TzYRyy6qxz+ck0f0XX8jdN+rzubt1qT323zHLL99V6NiNSF1zLrf6zpWsLdCG+mSVnHFq63sVcuGGgG/UUlXLaHvS01YeATErrdDUXq7T6YRvL6CvY0kBfzHx6uRnY2l269ODpA3Vl9okUq6TExzhPggVRoyk0twjXp6q4Ls1ES1DKfNrd3c1PA8mWVlyVXvFOUe3ndg/MPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gJgg1F4NkipJyDKlRA5oW3n7Jd3X/ojOHbTkTx0LlY=;
 b=hsTl3DA85bumTrDkZPnTvMrC+M9e6o8fqyXXFzFQGljh0/zJOVkTLSxW3nmLqOOGm59PmWGSiJ3NgD6h3eYyfeBUKJguxcHbdvgI9iSxhP4R4teKG3lC49s7t2vdezja8ZPlicDpfMrZSnfUJmbaSeYE3lFXzaD2Gd5Uj6pmnByPzK9sVQN19aK+B8pCCK+fV4UWaX5hM1QCpbY9ktVdX4pPUEiGM/F9H5serPK1hDqpwG9EN31h+apqD3a1bUX2UzKdlN+YSlVmvKJF78Arzbg3CXODBEazRZV5pnFYNCWR46eP/LVWRbNBQPKFgY01Rd/IHTi/qnKfEd+GPLP+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gJgg1F4NkipJyDKlRA5oW3n7Jd3X/ojOHbTkTx0LlY=;
 b=P4HcajuMe5Md++ozec1Jibb8GAyi1uNE0EURxKh1Usa2y/632rHQucDjSivzbbIu4GYH2AtZ/VFOsYtA9JmRpOQHHM4iGG9T+FngbjDn9x/tfVFsThH23NWd1bfYLLL6FiZfTt09sPV6ltRct5jw+HH8nprY7Ed67vujLbcNwmaJoKSJFGY4ZJGqgd6IJxoY4M3b74wzd4+0hD+hn4SS4edlj3Eet0NYJJXIJIKLmde8NjyAQEdK7hc5aRssTvS9/pgUbQQCS1sGQzNgvrSj+U+RwliixEkROXPoK6OwlQKZYjqyPAmro+Mp9apVOTJcG5BNyq6ILv9hK1LLAdzLVA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:30:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 09:30:40 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Topic: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
Thread-Index: AQHcwXNEiYayflWfEUezRut3L1IVirXhzwYQgAbZA4CAALbMoA==
Date: Tue, 21 Apr 2026 09:30:40 +0000
Message-ID: <CH3PR12MB75489B88CF53FE2C8A93DD72AB2C2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-10-nathanc@nvidia.com>
 <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
 <9ab16130-a589-485d-a3fb-49b3569219d6@nvidia.com>
In-Reply-To: <9ab16130-a589-485d-a3fb-49b3569219d6@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB7624:EE_
x-ms-office365-filtering-correlation-id: 39c2b95c-4a3f-4964-f696-08de9f88a734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: FLMP1iwHeZrrwtp0Qki2BUHYVakfEmD6LHZFHQscJ0w5KuX33xyHKcSja1SNulive1U2rhEGlz/4yVPITbK7boOYQgb06CQ+xa8eVPcDUMLzP2i4Ndb+hthcPE5YUuvk2MxyifRh9adjkp2ChFJMDZnL2fXQawXSzJb7J9s3emgRCf/yalw2k5avr7HtKy8eoYmdv8RUYfviQHxKLNpMlvOHKtCu1TqqPlDbw5i8TPq1OO/HC0kAM0rpM756in5A3vnhcyquDxJI/s+RPfCoktcoq8INhvr83+PkkLcmMA8DzBF4q505W0kkQSWaK76UPa1z38QpV5SFslXM8t59XbrTfpMW9UBrzGeuZo8/aWM9YHlmEFxC7AEHJraUcRtidbDz7VJakJz6eER1fwHHxeLgQYhcAgcdUFfNJbKSeoWVAduijiLkruKSIdW2kbTsFwkQ58c2CGjYyuIfZprvwKJ4GDKo/0bfWac17LRcsbf+TG5+CLJdnYk0EuvbZdlaMD9qr/Md0ZcznAHggMwWKAVlK6yzZOHPtnPe5t9adFEbKycoJ/rNrdSHkiQgTl1fe5+HK32+SF2pw/HBfggeV63JsLyqHifCJ/n+0D3H+00Wye55fwTrT4pLrMYK/RMpv122BhpFZMWNJmk3hAfYvtqGrPjiYiQGaZAHK86/VF/dvHBiAP7YQ6RMpQECqHa0tfDAkFCV02qIWcjyq3V3S/l9k82nRmg1iVV1WyBqORausQOTlubPuUksKPpAhvyChoJ9iD5c2lWNyjOo0qDCON9x6QmQGxE3dhhUbncVvzQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5ucFhyVU5ldFZmQjZVbG9SakdZUE1ValJIWXFMdEJkZ1VwM0huQUdvUUs2?=
 =?utf-8?B?UkcyNFlVWTBJN003eUxxN1FxSklmQld0bjVqYVFUcmxTa3dzRjlQUkdoVXBY?=
 =?utf-8?B?UUVBbW1oNGxSSVkrcTJlTFMrNi9jdFNnbFBRdUlqMGxsWmRWVS82SGtEbk14?=
 =?utf-8?B?YTFnUXBtQXhtSitvU2lOd1h3dXZIaENOMmFLcmpER1dpTk83TERjLzdncUZZ?=
 =?utf-8?B?SU5zKzgrVm5PSjZoL2FqdmdKSFlhNlhZV0ZMM2N1MXJIVkYvNVFPL1ZmTzZM?=
 =?utf-8?B?V0Y3UGZWdmhIVmNiQTAzSC9UZmlUSDRZRll4aGFuV3NTSmFOZzBMd2JBSW5w?=
 =?utf-8?B?ZW54R3dQcEZtb2ZCOUdydnpSYk9XQjBXeURyR3BETDZSZ1BEdWU0TE5rdTVL?=
 =?utf-8?B?NFJKZ1h0NllZVHFBeDBkdkZhc2ordmxOeHlVbVhLS25COTdrbVZ5Q2RVczVy?=
 =?utf-8?B?WlhqaEZQS3FhZkRQOUpWazZkcGF3TkR6Sk1yYWRoZjRSSURxV055WTRIY0Ev?=
 =?utf-8?B?cGtHeGJwczRpaFhVRytGTkdTQXFmK2tmcVRmRkI5ZnFtemFzQ3FPa2ZHelRU?=
 =?utf-8?B?STZHNFFJWXJGRHExYUZPZm9LcHFEOVVWdkc1ZHlVbnlPdkQ5eTdnaURxa2Ji?=
 =?utf-8?B?ckl0NXRJM1JTaWdmaEpKTHRaa0RWSXJBRm15Z3hxWTViODRBMURzcnlsVXlV?=
 =?utf-8?B?ZFhKdER0clZrR0FmdkVPeE1TU1BPSHg2emJFQWFxOXdmcWo2WWswNG1uWG9v?=
 =?utf-8?B?NDZOdnJxUkJ6T1p1RUQ5QkMzTHM4Nkt4eFEvdVdsbjZad3VPUHl3QTVxSUpt?=
 =?utf-8?B?aXFzSWg2VnF5a0VTUGNDWE05Y1pZN1E2NkVjc1BZYzRIeHhmVlNtUCtCK1ZQ?=
 =?utf-8?B?M3N2ZUZpUFMzR3doYkFYREN2MlZiQUdhckZkTVJEaURObTU1a2pYSkZOSExI?=
 =?utf-8?B?ZEVBT3NRa1R2WHdNV29jOWU0TXFvTWl1QVpWNGVMWjl0dkN6NVZXSGFXcWV6?=
 =?utf-8?B?cUVxbFJ5Mzc4bkVhMWFBTis5bGdKYTRDU1JrU2FYUURna1VPMnlCWmlYdC9C?=
 =?utf-8?B?YjdDZ0FYZXVrc081U0t6ODJVTndkaUQ4Y3pYbW9EY0F0RW1kK3JGS0ZzWmxO?=
 =?utf-8?B?dU9kR0x1ZldXRFA5cTdlSGk2d1B4UHBER1ZtcUNtWDNVcC8zd0NTYkVTMlBl?=
 =?utf-8?B?ZEhCMkc4Qi9wamlhK1loUE8wNkpDSy9BaGFWVXFQVnBwNTJ6em4zRUFGNFhv?=
 =?utf-8?B?NFNtaHIrOHRpd3JjaHhjNFN0cStJTFRha1BjSlVRV25ZWmJIdks1d2hmOU1s?=
 =?utf-8?B?V1NTS1ZXOEt0VWs5M0RtajFvbTBPMEgwaG9rY2ZvNmU1YWd0bHdKQVdOK3ly?=
 =?utf-8?B?b3FkSlJoWHVkSlhSWjZOMEhXMmwzNWF0YXRGc0ZSeFplWC8rckRCM0FNZzVX?=
 =?utf-8?B?TDZ4NlVkK2VaYkNjZmo3VWtab2NxNVEweDR4by9jbkNKeno3akZZRDhCWWJU?=
 =?utf-8?B?b1NuMnJiZjRHZG5PeVBaY0VSVytwNTY1SDdNYS95SVBCMGNGNVUzRVpGdlh3?=
 =?utf-8?B?RkRRQktjWDNQVXYzNlFDWVNkeVJwd3FBK0c5NENqcHl6Wi8rVFhaZFpVN1R0?=
 =?utf-8?B?eDNIRlhJNEpXZlU3VUw3dklMSjNDS1ZvUXJDS2VoZTZ4K3ZLMGRBa0x5RUU2?=
 =?utf-8?B?TmFSejJBeXViMFlFK2c4V29FOGJvMlJwZXExRUh2OUxTeGZUbjEyTmpFaStX?=
 =?utf-8?B?Z21OcnYxVFVDSzhGQW9yTmEzQjBVM3hBM0hxcWdYd3lCdy9HcFR5Uk1jR2g1?=
 =?utf-8?B?bS9vRzBmbVF0RlFXc2pya3U1R1M5VFJQOGgwQlZXNzRVaUJiQjIvOHhYVm9l?=
 =?utf-8?B?U0U0VTZtaTNLZ3Frb1JiUnFVK3ZxSDIzWXVveGJkWEdvcHF1em5rVUxYRzlG?=
 =?utf-8?B?aHNqZkVKSzhDY042cGdOTXpxU3hlL0FDbFAwK0pjM3BjeEg1UzI4L3hnRUZJ?=
 =?utf-8?B?RkxUMHdkZWticnNvZnhWbnZ3R0lWTzhGSkY1ZmRqSVhzazQxcVpJSnRwakFN?=
 =?utf-8?B?eG1neTRnSk9NazI2Qm53NGZKa3ZFNnRSSzVCUXB5RVByR2lHdHg2cU05aWZw?=
 =?utf-8?B?NzBoQVpVZXNSL0s0a0ZCNWJBRm8wSXJvSmRBaVQ5UnRqd3lzSUZKa1FVQ3M3?=
 =?utf-8?B?NE02TXovcGdWU3FLWUpGNXdjbGMwT1oyUlZRRVVtRnpUaXRSYmlZNGhZYTFs?=
 =?utf-8?B?eTZTdTNzUFR0S1dHV3VzM09UdGtJZmJCSStORHp0andJWkpGTWw1ampBMVNP?=
 =?utf-8?B?TGVnRXVIaVBybzVMVU1Sb2dqNlBJMFdYNTB3WVY1MHRmRG0rTE9kQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c2b95c-4a3f-4964-f696-08de9f88a734
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 09:30:40.2526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7SESiHx+sT43XmGVeRSPvEHT5+IUgm5eFVe4U0nXe/ch2AleELYExDT3pBH2jTEWvfErDJMQFjdc1I+GcO6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoZW4gPG5h
dGhhbmNAbnZpZGlhLmNvbT4NCj4gU2VudDogMjAgQXByaWwgMjAyNiAyMzozMg0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47DQo+IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBQZXRlciBNYXlkZWxsDQo+
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBNYXJjZWwgQXBmZWxiYXVtDQo+IDxtYXJjZWwu
YXBmZWxiYXVtQGdtYWlsLmNvbT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGlsbWRA
bGluYXJvLm9yZz47IFlhbmFuIFdhbmcgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBaaGFvIExp
dQ0KPiA8emhhbzEubGl1QGludGVsLmNvbT47IEFsZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90
Lm9yZz47IEPDqWRyaWMgTGUgR29hdGVyDQo+IDxjbGdAcmVkaGF0LmNvbT47IE1hdHQgT2NocyA8
bW9jaHNAbnZpZGlhLmNvbT47IE5pY29saW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwOS8xMV0gaHcvYXJtL3NtbXV2My1hY2NlbDogSW1wbGVt
ZW50ICJhdXRvIiB2YWx1ZQ0KPiBmb3IgIm9hcyINCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBP
biA0LzE2LzIwMjYgNzowOCBBTSwgU2hhbWVlciBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBOYXRoYW4gQ2hlbjxu
YXRoYW5jQG52aWRpYS5jb20+DQo+ID4+IFNlbnQ6IDAxIEFwcmlsIDIwMjYgMDI6MDINCj4gPj4g
VG86cWVtdS1hcm1Abm9uZ251Lm9yZztxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4gQ2M6IFlp
IExpdTx5aS5sLmxpdUBpbnRlbC5jb20+OyBFcmljIEF1Z2VyPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT47DQo+ID4+IFpoZW56aG9uZyBEdWFuPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IFBldGVy
IE1heWRlbGwNCj4gPj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IE1hcmNlbCBBcGZlbGJh
dW0NCj4gPj4gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kNCj4gPj4gPHBoaWxtZEBsaW5hcm8ub3JnPjsgWWFuYW4gV2FuZzx3YW5neWFuYW41NUBo
dWF3ZWkuY29tPjsgWmhhbyBMaXUNCj4gPj4gPHpoYW8xLmxpdUBpbnRlbC5jb20+OyBBbGV4IFdp
bGxpYW1zb248YWxleEBzaGF6Ym90Lm9yZz47IEPDqWRyaWMgTGUNCj4gR29hdGVyDQo+ID4+IDxj
bGdAcmVkaGF0LmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4gVGhvZGk8c2tvbG90aHVtdGhvQG52
aWRpYS5jb20+Ow0KPiA+PiBNYXR0IE9jaHM8bW9jaHNAbnZpZGlhLmNvbT47IE5pY29saW4gQ2hl
bjxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gPj4gTmF0aGFuIENoZW48bmF0aGFuY0BudmlkaWEu
Y29tPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMDkvMTFdIGh3L2FybS9zbW11djMtYWNjZWw6IElt
cGxlbWVudCAiYXV0byIgdmFsdWUNCj4gZm9yDQo+ID4+ICJvYXMiDQo+ID4+DQo+ID4+IEZyb206
IE5hdGhhbiBDaGVuPG5hdGhhbmNAbnZpZGlhLmNvbT4NCj4gPj4NCj4gPj4gQWxsb3cgYWNjZWxl
cmF0ZWQgU01NVXYzIE9BUyBwcm9wZXJ0eSB0byBiZSBkZXJpdmVkIGZyb20gaG9zdCBJT01NVQ0K
PiA+PiBjYXBhYmlsaXRpZXMuIERlcml2ZSBob3N0IHZhbHVlcyB1c2luZyBJT01NVV9HRVRfSFdf
SU5GTywgcmV0cmlldmluZw0KPiA+PiBPQVMgZnJvbSBJRFI1Lg0KPiA+Pg0KPiA+PiBUaGlzIGtl
ZXBzIHRoZSBPQVMgdmFsdWUgYWR2ZXJ0aXNlZCBieSB0aGUgdmlydHVhbCBTTU1VIGNvbXBhdGli
bGUgd2l0aA0KPiA+PiB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBob3N0IFNNTVV2Mywgc28gdGhh
dCB0aGUgaW50ZXJtZWRpYXRlIHBoeXNpY2FsDQo+ID4+IGFkZHJlc3NlcyAoSVBBKSBjb25zdW1l
ZCBieSBob3N0IFNNTVUgZm9yIHN0YWdlLTIgdHJhbnNsYXRpb24gZG8gbm90DQo+ID4+IGV4Y2Vl
ZCB0aGUgaG9zdCdzIG1heCBzdXBwb3J0ZWQgSVBBIHNpemUuDQo+ID4+DQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IE5hdGhhbiBDaGVuPG5hdGhhbmNAbnZpZGlhLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAg
aHcvYXJtL3NtbXV2My1hY2NlbC5jIHwgOSArKysrKysrKy0NCj4gPj4gICBody9hcm0vc21tdXYz
LmMgICAgICAgfCA2ICsrKy0tLQ0KPiA+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11
djMtYWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+PiBpbmRleCAwMzM5M2ZkN2Jh
Li4xMDVmNmQyNmJmIDEwMDY0NA0KPiA+PiAtLS0gYS9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4g
Pj4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4+IEBAIC02Myw2ICs2MywxMiBAQCBz
dGF0aWMgdm9pZA0KPiA+PiBzbW11djNfYWNjZWxfYXV0b19maW5hbGlzZShTTU1VdjNTdGF0ZSAq
cywNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRklFTERfRVgzMihpbmZv
LT5pZHJbMV0sIElEUjEsIFNTSURTSVpFKSk7DQo+ID4+ICAgICAgIH0NCj4gPj4NCj4gPj4gKyAg
ICAvKiBVcGRhdGUgT0FTIGlmIGF1dG8gZnJvbSBpbmZvICovDQo+ID4+ICsgICAgaWYgKHMtPm9h
cyA9PSBPQVNfTU9ERV9BVVRPKSB7DQo+ID4+ICsgICAgICAgIHMtPmlkcls1XSA9IEZJRUxEX0RQ
MzIocy0+aWRyWzVdLCBJRFI1LCBPQVMsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRklFTERfRVgzMihpbmZvLT5pZHJbNV0sIElEUjUsIE9BUykpOw0KPiA+PiArICAgIH0N
Cj4gPj4gKw0KPiA+PiAgICAgICBhY2NlbC0+YXV0b19maW5hbGlzZWQgPSB0cnVlOw0KPiA+PiAg
IH0NCj4gPj4NCj4gPj4gQEAgLTk2Miw3ICs5NjgsOCBAQCB2b2lkIHNtbXV2M19hY2NlbF9pbml0
KFNNTVV2M1N0YXRlICpzKQ0KPiA+Pg0KPiA+PiAgICAgICBpZiAocy0+YXRzID09IE9OX09GRl9B
VVRPX0FVVE8gfHwNCj4gPj4gICAgICAgICAgIHMtPnJpbCA9PSBPTl9PRkZfQVVUT19BVVRPIHx8
DQo+ID4+IC0gICAgICAgIHMtPnNzaWRzaXplID09IFNTSURfU0laRV9NT0RFX0FVVE8pIHsNCj4g
Pj4gKyAgICAgICAgcy0+c3NpZHNpemUgPT0gU1NJRF9TSVpFX01PREVfQVVUTyB8fA0KPiA+PiAr
ICAgICAgICBzLT5vYXMgPT0gT0FTX01PREVfQVVUTykgew0KPiA+PiAgICAgICAgICAgcy0+c19h
Y2NlbC0+YXV0b19tb2RlID0gdHJ1ZTsNCj4gPj4gICAgICAgfQ0KPiA+PiAgIH0NCj4gPj4gZGlm
ZiAtLWdpdCBhL2h3L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0KPiA+PiBpbmRleCBj
YjE0YTA4YTY2Li4wYWI2ZDFlNzYyIDEwMDY0NA0KPiA+PiAtLS0gYS9ody9hcm0vc21tdXYzLmMN
Cj4gPj4gKysrIGIvaHcvYXJtL3NtbXV2My5jDQo+ID4+IEBAIC0xOTc2LDcgKzE5NzYsOCBAQCBz
dGF0aWMgYm9vbA0KPiA+PiBzbW11X3ZhbGlkYXRlX3Byb3BlcnR5KFNNTVV2M1N0YXRlICpzLCBF
cnJvciAqKmVycnApDQo+ID4+ICAgICAgIH0NCj4gPj4gICAjZW5kaWYNCj4gPj4NCj4gPj4gLSAg
ICBpZiAocy0+b2FzICE9IE9BU19NT0RFXzQ0ICYmIHMtPm9hcyAhPSBPQVNfTU9ERV80OCkgew0K
PiA+PiArICAgIGlmIChzLT5vYXMgIT0gT0FTX01PREVfNDQgJiYgcy0+b2FzICE9IE9BU19NT0RF
XzQ4ICYmDQo+ID4+ICsgICAgICAgIHMtPm9hcyAhPSBPQVNfTU9ERV9BVVRPKSB7DQo+ID4+ICAg
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJRRU1VIFNNTVV2MyBtb2RlbCBvbmx5IGltcGxlbWVu
dHMgNDQgYW5kIDQ4DQo+IGJpdCINCj4gPj4gICAgICAgICAgICAgICAgICAgICAgIk9BUzsgb3Ro
ZXIgT2FzTW9kZSB2YWx1ZXMgYXJlIG5vdCBzdXBwb3J0ZWQiKTsNCj4gPj4gICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gPiBEbyB3ZSBlbmQgdXAgbm93IGFsbG93aW5nIE9BU19NT0RFX0FVVE8g
Zm9yIG5vbi1hY2NlbCBtb2RlPw0KPiA+DQo+ID4gSSB0aGluayB3ZSBtYXkgbmVlZCB0byBhZGp1
c3QgYXMgYmVsb3c6DQo+ID4NCj4gPiAgICAgIGlmICghcy0+YWNjZWwpIHsNCj4gPiAgICAgICAg
ICAgaWYgKHMtPnJpbCA9PSBPTl9PRkZfQVVUT19PRkYpIHsNCj4gPiAgICAgICAgICAgICAgICBl
cnJvcl9zZXRnKCk7DQo+ID4gICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgICAgaWYgKHMtPmF0cyAhPSBPTl9PRkZfQVVUT19PRkYpIHsN
Cj4gPiAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKCk7DQo+ID4gICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+ICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgaWYgKHMtPm9hcyAh
PSBPQVNfTU9ERV80NCkgew0KPiA+ICAgICAgICAgICAgICAgIGVycm9yX3NldGcoKTsNCj4gPiAg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICAgICB9DQo+ID4gICAgICAg
ICAgICBpZiAocy0+c3NpZHNpemUgIT0gU1NJRF9TSVpFX01PREVfMCkgew0KPiA+ICAgICAgICAg
ICAgICAgIGVycm9yX3NldGcoKQ0KPiA+ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
PiAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICAgICAgICB9
DQo+ID4NCj4gPiBQbGVhc2UgY2hlY2suDQo+IA0KPiBXZSBkbyBhbGxvdyBwYXNzaW5nICdhdXRv
JyBpZiBhY2NlbD1vZmYsIGJ1dCBpbiB0aGF0IGNhc2UNCj4gc21tdXYzX2FjY2VsX2luaXQoKSB3
aWxsIG5vdCBnZXQgY2FsbGVkLCBzbyBhdXRvX21vZGUgPSBmYWxzZSBhbmQNCj4gc21tdXYzX2Fj
Y2VsX2F1dG9fZmluYWxpc2UoKSB3aWxsIG5vdCBjaGFuZ2UgdGhlIE9BUy4NCg0KT2suDQoNCj4g
DQo+IElmIHdlIGFkanVzdCB0aGUgY2hlY2sgbGlrZSBhYm92ZSwgdXNlcnMgd2lsbCBoYXZlIHRv
IG1hbnVhbGx5IHNldA0KPiByaWw9b24sIGF0cz1vZmYsIG9hcz00NCwgc3NpZHNpemU9MCB3aGVu
IGFjY2VsPW9mZiBiZWNhdXNlIHRoZSBkZWZhdWx0DQo+IGlzIGF1dG8uDQo+IA0KPiBXb3VsZCB5
b3UgcHJlZmVyIHdlIGRvIG9uZSBvZiB0aGUgZm9sbG93aW5nPw0KPiAxLiBBZGQgdGhlIGFkanVz
dG1lbnQgYWJvdmUuIFVzZXJzIGhhdmUgdG8gbWFudWFsbHkgc2V0IHJpbD1vbiwgYXRzPW9mZiwN
Cj4gb2FzPTQ0LCBzc2lkc2l6ZT0wIHdoZW4gYWNjZWw9b2ZmLiBQcmV2ZW50cyBzZXR0aW5nIGF1
dG8gZm9yIHRoZXNlDQo+IHByb3BlcnRpZXMgd2hlbiBhY2NlbD1vZmYuDQo+IA0KPiAyLiBBZGQg
dGhlIGFkanVzdG1lbnQgYWJvdmUsIGJ1dCBpZiBhY2NlbD1vZmYgYW5kIGF1dG8gaXMgc2V0LCBy
ZXNvbHZlDQo+IGF1dG8gdG8gcHJldmlvdXMgZGVmYXVsdHMgYmVmb3JlIHdlIHJlYWNoIHNtbXVf
dmFsaWRhdGVfcHJvcGVydHkoKS4gTm8NCj4gZnVuY3Rpb25hbCBjaGFuZ2UgZnJvbSBjdXJyZW50
IGltcGxlbWVudGF0aW9uLg0KPiANCj4gMy4gS2VlcCBjdXJyZW50IGltcGxlbWVudGF0aW9uLg0K
DQpUaGUgcHJvYmxlbSBJIGFtIHNlZWluZyBpcyB3ZSBzZXQgdGhlIGRlZmF1bHQgZm9yIHRoZXNl
IHByb3BlcnRpZXMgYXMNCl9BVVRPIGJ1dCBmb3Igbm9uLWFjY2VsIGNhc2UgdGhlIGRlZmF1bHQg
aXMgYWN0dWFsbHkgc29tZXRoaW5nIGVsc2UuDQoNCkkgYW0gZmluZSB0byBrZWVwIGl0IGFzIGl0
IGlzLCBidXQgd2UgbmVlZCB0byBjYXB0dXJlIHRoaXMgaW4gY29tbWl0DQpsb2cvY29tbWVudHMg
YW5kIHByb2JhYmx5IG5lZWQgbWVudGlvbiBpbiBxZW11LW9wdGlvbnMuaHguDQoNClRoYW5rcywN
ClNoYW1lZXINCg==

