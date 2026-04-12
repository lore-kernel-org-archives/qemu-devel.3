Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17F0E93800
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1PI-0003iU-4I; Sun, 12 Apr 2026 16:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wC1PG-0003hJ-Q6; Sun, 12 Apr 2026 16:27:46 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wC1PE-000791-AN; Sun, 12 Apr 2026 16:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYREi3eEl+F4C9nXKfBVdvYkR8ouB/zOjW1YA03T4YSlba70ykd9VHFvXP2jFaCrrXaM/BUfmVP7Isci6ito4wsA1XjfHASVFN31kRJVVYMJn+7+dWSIx7uvgJapYCuPmeA8ZT5K9FFMKKa7k+jWEpcV5TYRlAbcfz8H/Cs27erwH7JOJb8WKPD3O89hoZLaqdlkvJvYDQ0fcjh7PBk71MCy8kQo+5lFGDtMfA0MPPGlXYKK4jxHLKjAv0eqEPblIqECxyyGNPAaCRu0Oug+24l1VHgM3vJhzPQSjUTsXGfIWWlQRbterYrH9M0QbWmqPMrmrUKP8bUmhcugkpWWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTZilgP7eeUydVaZJ9o6gy90V7CRbW0OMM2BvXS21P4=;
 b=NhzAbIM+r2U4L7Nvp8M2vc6kUVPshfxFMBoNbnHxlvOrinSm/GQ1s7VV6wKYxel7jAoI1+aU78Do0awbT1HO1fPl/Sum5/EJUHVNCep2QYY04sCh6eNEIwEEkf83MA28Xt5cdmkDU7UIAhKXeDgGsDTnVww08syO60wkmGROldhu5HWm+J6j/t59ERDcFHumwz1d27z/ZUJpG0S7E8w+IzgclsXZZy3jplFLWBzL+K+7+l6M61vk2pz8aXa188vAdykoVfOKjGRSyYPdWQsJ0b4YDGvJsts+/kPiST9Jnj+x4QaA8NRFaXpLU1YbM9m7yYFKZ4QG4OcOwklCWBFv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTZilgP7eeUydVaZJ9o6gy90V7CRbW0OMM2BvXS21P4=;
 b=GoJhnG6N0eQ9skfgUWp4kisHJwxayst1RyCQkAsq4Xn1KwH7edw7TIOaMZeK8VZ20keFKCZEDAtwcEhDPU4skJfikBVB56+CeW309Cc/7BXxfwqaC2roQPy30IjeIR6MmVn/v3it3DQbFZLZt/ZvHj/vcOMNcJV7r2qW2cohWi+3OaHCBSwf3EQhuYDE/sa7B9AJOsZIchfvlvT/Vj1r9hPcadys5lk9NtYF2Yy5fB1C7DPtrdZttXsRek0SkePgm6MED6wUWRKI/4lzmTPMaPrtSct6Fh1y4ZEQJ8R1LZfgCm8mSQX7S/gkBnbtc2yu5ezTg3numLlk6ePbocPfsw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Sun, 12 Apr
 2026 20:27:35 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 20:27:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH v2 1/2] hw/arm/smmuv3: Have smmuv3_accel_init() take an
 Error* parameter
Thread-Topic: [PATCH v2 1/2] hw/arm/smmuv3: Have smmuv3_accel_init() take an
 Error* parameter
Thread-Index: AQHcySS6wyduehyJ5ESi660Fm/XmYLXb4wLQ
Date: Sun, 12 Apr 2026 20:27:34 +0000
Message-ID: <CH3PR12MB7548AE134B6AF1E6937B5509AB272@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260410200031.18572-1-philmd@linaro.org>
 <20260410200031.18572-2-philmd@linaro.org>
In-Reply-To: <20260410200031.18572-2-philmd@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY5PR12MB6202:EE_
x-ms-office365-filtering-correlation-id: b6aee418-4477-43dd-7250-08de98d1ee7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: /lpW7ikOMaO98qVdx//wl9s3m9m3J1OoWU65Br0yk5TqvAB+PdTBolJXdG1CPWqesU0T15l9LCAYPJ8Q9soUXO50JKNYDSLn1Rf9BU4b4Kwh7jznOhAi56PVq4GK5qI4dx062XlLQ3f+JPeVsLunIhEPxW3YiCaloyUSmBwCPmOMBKtP+gq9GNdjLgIt9vPLud1getT0V4YKDJplQ7NSyreF8Ob26oRIsTbzzW8V3Wl+dKrtVVrU3htdqJVjRKQc/C5/bgDyZnNg2d6VfBdz/bBR1I9B5s3Eat+gwqf+XNN8PMEhvBd1WJ3mRbzCaS0CuH2FgUY+KMu4wZmT4gLUu79nS14YYlgOLAi5KQCyFgRyr1Fssc8cK3BuX7wxemHxpPEuRGJ+zFzfAO3mFrhDn6jbkVfM2mIgLbE939JOFfQP5moToSyChDVb4rkbAL/nM3dRp4+DHk75UyhVWD81QYO0gO/l81D0LX2rIsfosVGPXEuxiE/VzcDiPjg58Tp8VEzybGK2nNZcuyDeK6fTSK51neY3m9SJsb/gMVlCsnWKBJ7pf2SSWlxzovsnec2CTPxs70/xiPW6OhoGXg5XnIU+S78k7NJ6SVl+UgHk4FiVvQqSUyWW0bcBO5GEPxTZpcnQotOh39DO42Z5uL1o4KqfGasmRNq3w9U/YF17gOhIcUUJX0ePY4Mz0c4dwKPIrAHtoZieqB6mPUgtX257Toc0jjb/5SBcoMXqUsQ0+nrPWdg+x1jJ0HHJJEaZygMGOW7OVyFTEoWDwEtK4PObE4f3Uwr3reX0+UH7xu1xNps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhTUE42M1I0MXEyQ1A4ODBNN3Z2bEFQRkwrbFpqUDk1OU0xeFpkcWJXVHMv?=
 =?utf-8?B?cDZwaFFyTkptNUF4bVNKYzdEcFdrYkxOdlh6Z2ZEREFuY1pHVzVzcEtQdE5U?=
 =?utf-8?B?eDl5WWJBQ1dYOW9wb3poOVVBZTJaVzhZdHhLYS9HQnZpajNwTW10eG90MnNr?=
 =?utf-8?B?WGZqT3g3UUUyMGtQVytqNE5DUXJDSHpia09Pci9kVW42MU1aNEhVVG12NzZq?=
 =?utf-8?B?Umd3T1VtbHM0T0JSMWRhV2tldEdJT1k5VkZCTzdCMkFkTWk1UFlZMXYvcEE3?=
 =?utf-8?B?WDdleHhvekdNSENaSmkyQWdSTUNyemdTa29ldVJSUms2TWk4UVNoSjVSM3lH?=
 =?utf-8?B?UXlnMitMb21vSkUvRjlvaldwOXR2ckR4emJUb2ZUMmVEcVNTTXF4WmZqeFY0?=
 =?utf-8?B?c25UN3JhL1JPMTNGeDF6NFFmQm11cWowWmhFQmJmZGloeC91aFVkMWhydDhr?=
 =?utf-8?B?SWVuZ3FGYUZaVWVkSkRXdGt0bkN5QXk4Vng4TEVON1A5emQyMUs3QXA0MUhl?=
 =?utf-8?B?Y0g4S1lCNnZGQ2UxY2xLcjNZWWRFWHV5TGxPc2QvU0Zvblp4ZHRBUzF2VCt4?=
 =?utf-8?B?ZHdvbnQ3aXd3amJzTlVpeXMrNDFmMmJSS1c5N3gzbFpJOFhSYUVtN1FDRVYv?=
 =?utf-8?B?OGxTYnB1TXV5bFRxNXlyT1JLS2ZxQ0ZaQXlwY3JZM2xRbTBBamFmZ3hYUTU0?=
 =?utf-8?B?UEl2UzIrdnlBRFFqVVhDbS9qNExjZER5cHRjd0xqYlJ3bUh2dHRBTTN6Qms2?=
 =?utf-8?B?NGkwcjRMS2swSGlUbzgyckFpRmVFOHY4U1JTakQzZlhTcko0K2ZLZ0lSUHBX?=
 =?utf-8?B?Q1U4UnhGSG1Sa3pBWHI2Y29YcVZBTUx2d250TGZvVCtwMUczYk9HUHhtWERz?=
 =?utf-8?B?SW5HdjRkZlpQbkg1VUprMkJ6UTRVZ2xQSHVTZGRqSkRWV0tzWUtFck9nRkpH?=
 =?utf-8?B?MXd0Nk91bVlrZ3V1bU4zZzFFRGJPL2xodWNOZUMyOU5oMlVwZHFpK01Ib01D?=
 =?utf-8?B?QzJrYU1hQWo2TjR2SndYU3plang0bStiakhNTnlpNTNyejc2RVhDbGxUdDJ5?=
 =?utf-8?B?U3BEQXZTV0hlMXpUajhmVDV6UGdDQWdTdnVVblJLbFM2OVlHSnVzNTd6Nldm?=
 =?utf-8?B?NGxQcCtTM2NTU0s5STA3dGNCcWlPQ2pQOUUrTjVQL2VPSmlFcWhKVlc4b01X?=
 =?utf-8?B?UjVEcURRdVRzT0tLUnhPRjNJdXhnbnZ1NExsWmJQVUZoQ00ySWhIZ0tLazc0?=
 =?utf-8?B?bWJ5Sk9qRFVWdXZMSTRYczE2MFFnLzZMRXNreWgydGVzT3NXb3pyNnRQZ0tY?=
 =?utf-8?B?blhBVjg0cnVkaSt2bHVXZ1RrUXduZWVTNXE0cDQ2TWhzRjliUUVHS2owTk5N?=
 =?utf-8?B?dm9pWU1hTW43Ym5ZR2NTeGRQdHIzVDlnbmRxaHNtUzZKcFRjbEw2OXJwbGpN?=
 =?utf-8?B?NjJoVmx3cDN1eEtGMVdZUTlqeVFXTlJSMndPSUNES1N3Y2cvRytMQ3JHYVBq?=
 =?utf-8?B?UzVlTlRQN0tYNVd2K1ZmWmtqaHl5YzBwSGh4Ym5RUzdTeFZUUWpudzBkbmRw?=
 =?utf-8?B?UmFNM2Y2aDNhRURGMWNLNDRoRGpKTnpYcmNWeVJONkZBSnlha2lzQ1R5NVE0?=
 =?utf-8?B?SDFTU3lQWnpGMXdxZEVRZTZ5cEQwSmg5SUgvTmZMREhBVFNPU1dHWWR1SXFk?=
 =?utf-8?B?Q0lMbGJBRTEvYWtnL2pvSDg3eW95dnhGSW9VVCtOeFB4VERpdzRKK3lxeTlG?=
 =?utf-8?B?YXBNM3l4RldnNFN0UEI2MlRNM2VLV1E2ZG95U21LODJUMTRHZlRzWDJFNXBj?=
 =?utf-8?B?ajB2dWFadmtQVE96bUd3STdFbzJDSU9kZXY4QzZhcXNaTnhPdzJmUWgxeTdT?=
 =?utf-8?B?WDNhMlFlcHRzUnFpU083SnBWZnFnV29DNVFSS1EreENHM2Y1ZFpQbFlqWTJF?=
 =?utf-8?B?WGt6KzVwT0NZSSs3aFV3U1A1U20xUWM5aldaaFI3WnRucDl1M3ZpUnRaS2JH?=
 =?utf-8?B?NFdGTVFXZ21URHBCdlYxVlBPVFlVZXZvMzl2dXZvMFN6Uyt6OERQNTFqV01y?=
 =?utf-8?B?MjhvdU4rUWNsVzVoS2ZpR1k4NWFuYVZ0UHhxSFI5Z0dWZUk5MXlWQ2ZuMHY4?=
 =?utf-8?B?cnNCYkFaSmdGNzA2cXYxanJlVjJWL2k5ZjgzdlorS2Z5T2lLaEhwTnREWCtn?=
 =?utf-8?B?dE12SzRlem5na1RpbC9DMWJOT0xId3YvUWlJbXFwS2F2Qk1VUnNkMElKTTNS?=
 =?utf-8?B?UGpjWHFtVVVZbDBPY3ZmQ3dHZ2o4eDB2dHdDN2hDR0puNTgyUGthdTNqbzFE?=
 =?utf-8?B?Q1Y2S09ZTFpoOVEyMTlBY1N4a2FGTno2TWkxY3EzdXV5TUNramxtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aee418-4477-43dd-7250-08de98d1ee7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 20:27:34.9601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktPx/suNdoz2ms53/f/bcAZeSImH+gEGXAmkhHabbe7MJOMkG+Q/nA5r3vUWuqbIqKKN+oRCHc9GgktptMov7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAxMCBBcHJpbCAyMDI2IDIxOjAx
DQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBQZXRlcg0KPiBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTaGFtZWVyIEtvbG90aHVtIFRob2RpDQo+IDxza29sb3Ro
dW10aG9AbnZpZGlhLmNvbT47IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT47IFBo
aWxpcHBlDQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gU3ViamVjdDog
W1BBVENIIHYyIDEvMl0gaHcvYXJtL3NtbXV2MzogSGF2ZSBzbW11djNfYWNjZWxfaW5pdCgpIHRh
a2UgYW4NCj4gRXJyb3IqIHBhcmFtZXRlcg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBCeSBnaXZpbmcgc21t
dXYzX2FjY2VsX2luaXQoKSB0aGUgYWJpbGl0eSB0byBwb3B1bGF0ZSBhbiBlcnJvciwNCj4gd2Ug
Y2FuIGZhaWwgZWFybHkgaW4gc21tdV9yZWFsaXplKCkgd2hlbiBDT05GSUdfQVJNX1NNTVVWM19B
Q0NFTA0KPiBpcyBub3QgYXZhaWxhYmxlLCBzaW1wbGlmeWluZyBzbW11X3ZhbGlkYXRlX3Byb3Bl
cnR5KCkuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xv
dGh1bXRob0BudmlkaWEuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFNoYW1lZXIgS29sb3RodW0g
VGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCg0KVGhhbmtzLA0KU2hhbWVl
cg0KDQo+ICBody9hcm0vc21tdXYzLWFjY2VsLmggfCAgNyArKysrKy0tDQo+ICBody9hcm0vc21t
dXYzLWFjY2VsLmMgfCAgMyArKy0NCj4gIGh3L2FybS9zbW11djMuYyAgICAgICB8IDExICsrKy0t
LS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNjZWwuaCBiL2h3L2FybS9z
bW11djMtYWNjZWwuaA0KPiBpbmRleCBkYmE2YzcxZGU1Mi4uMWNhMmM4MGE5MzMgMTAwNjQ0DQo+
IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuaA0KPiArKysgYi9ody9hcm0vc21tdXYzLWFjY2Vs
LmgNCj4gQEAgLTQyLDcgKzQyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgU01NVXYzQWNjZWxEZXZpY2Ug
ew0KPiAgfSBTTU1VdjNBY2NlbERldmljZTsNCj4gDQo+ICAjaWZkZWYgQ09ORklHX0FSTV9TTU1V
VjNfQUNDRUwNCj4gLXZvaWQgc21tdXYzX2FjY2VsX2luaXQoU01NVXYzU3RhdGUgKnMpOw0KPiAr
Ym9vbCBzbW11djNfYWNjZWxfaW5pdChTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKTsNCj4g
IGJvb2wgc21tdXYzX2FjY2VsX2luc3RhbGxfc3RlKFNNTVV2M1N0YXRlICpzLCBTTU1VRGV2aWNl
ICpzZGV2LCBpbnQgc2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKTsNCj4gIGJvb2wgc21tdXYzX2FjY2VsX2luc3RhbGxfc3RlX3JhbmdlKFNNTVV2M1N0
YXRlICpzLCBTTU1VU0lEUmFuZ2UNCj4gKnJhbmdlLA0KPiBAQCAtNTQsOCArNTQsMTEgQEAgdm9p
ZCBzbW11djNfYWNjZWxfaWRyX292ZXJyaWRlKFNNTVV2M1N0YXRlICpzKTsNCj4gIGJvb2wgc21t
dXYzX2FjY2VsX2FsbG9jX3ZldmVudHEoU01NVXYzU3RhdGUgKnMsIEVycm9yICoqZXJycCk7DQo+
ICB2b2lkIHNtbXV2M19hY2NlbF9yZXNldChTTU1VdjNTdGF0ZSAqcyk7DQo+ICAjZWxzZQ0KPiAt
c3RhdGljIGlubGluZSB2b2lkIHNtbXV2M19hY2NlbF9pbml0KFNNTVV2M1N0YXRlICpzKQ0KPiAr
I2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzbW11djNfYWNj
ZWxfaW5pdChTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiAgew0KPiArICAgIGVycm9y
X3NldGcoZXJycCwgImFjY2VsPW9uIHN1cHBvcnQgbm90IGNvbXBpbGVkIGluIik7DQo+ICsgICAg
cmV0dXJuIGZhbHNlOw0KPiAgfQ0KPiAgc3RhdGljIGlubGluZSBib29sDQo+ICBzbW11djNfYWNj
ZWxfaW5zdGFsbF9zdGUoU01NVXYzU3RhdGUgKnMsIFNNTVVEZXZpY2UgKnNkZXYsIGludCBzaWQs
DQo+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFj
Y2VsLmMNCj4gaW5kZXggNjVjMmY0NDg4MGEuLmFlMDMxZjFlY2NmIDEwMDY0NA0KPiAtLS0gYS9o
dy9hcm0vc21tdXYzLWFjY2VsLmMNCj4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+IEBA
IC05MTcsMTEgKzkxNywxMiBAQCBzdGF0aWMgdm9pZCBzbW11djNfYWNjZWxfYXNfaW5pdChTTU1V
djNTdGF0ZSAqcykNCj4gICAgICBhZGRyZXNzX3NwYWNlX2luaXQoc2hhcmVkX2FzX3N5c21lbSwg
JnJvb3QsICJzbW11djMtYWNjZWwtYXMtDQo+IHN5c21lbSIpOw0KPiAgfQ0KPiANCj4gLXZvaWQg
c21tdXYzX2FjY2VsX2luaXQoU01NVXYzU3RhdGUgKnMpDQo+ICtib29sIHNtbXV2M19hY2NlbF9p
bml0KFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICB7DQo+ICAgICAgU01NVVN0YXRl
ICpicyA9IEFSTV9TTU1VKHMpOw0KPiANCj4gICAgICBzLT5zX2FjY2VsID0gZ19uZXcwKFNNTVV2
M0FjY2VsU3RhdGUsIDEpOw0KPiAgICAgIGJzLT5pb21tdV9vcHMgPSAmc21tdXYzX2FjY2VsX29w
czsNCj4gICAgICBzbW11djNfYWNjZWxfYXNfaW5pdChzKTsNCj4gKyAgICByZXR1cm4gdHJ1ZTsN
Cj4gIH0NCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0K
PiBpbmRleCA1NTcwYTEzYzhhNi4uNWMyODU1YzM3NzAgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9z
bW11djMuYw0KPiArKysgYi9ody9hcm0vc21tdXYzLmMNCj4gQEAgLTE5NjUsMTMgKzE5NjUsNiBA
QCBzdGF0aWMgdm9pZCBzbW11X3Jlc2V0X2V4aXQoT2JqZWN0ICpvYmosDQo+IFJlc2V0VHlwZSB0
eXBlKQ0KPiANCj4gIHN0YXRpYyBib29sIHNtbXVfdmFsaWRhdGVfcHJvcGVydHkoU01NVXYzU3Rh
dGUgKnMsIEVycm9yICoqZXJycCkNCj4gIHsNCj4gLSNpZm5kZWYgQ09ORklHX0FSTV9TTU1VVjNf
QUNDRUwNCj4gLSAgICBpZiAocy0+YWNjZWwpIHsNCj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiYWNjZWw9b24gc3VwcG9ydCBub3QgY29tcGlsZWQgaW4iKTsNCj4gLSAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPiAtICAgIH0NCj4gLSNlbmRpZg0KPiAtDQo+ICAgICAgaWYgKHMtPmF0cyA9PSBP
Tl9PRkZfQVVUT19BVVRPKSB7DQo+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImF0cyBhdXRv
IG1vZGUgaXMgbm90IHN1cHBvcnRlZCIpOw0KPiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IEBA
IC0yMDMzLDcgKzIwMjYsOSBAQCBzdGF0aWMgdm9pZCBzbW11X3JlYWxpemUoRGV2aWNlU3RhdGUg
KmQsIEVycm9yDQo+ICoqZXJycCkNCj4gICAgICB9DQo+IA0KPiAgICAgIGlmIChzLT5hY2NlbCkg
ew0KPiAtICAgICAgICBzbW11djNfYWNjZWxfaW5pdChzKTsNCj4gKyAgICAgICAgaWYgKCFzbW11
djNfYWNjZWxfaW5pdChzLCBlcnJwKSkgew0KPiArICAgICAgICAgICAgcmV0dXJuOw0KPiArICAg
ICAgICB9DQo+ICAgICAgICAgIGVycm9yX3NldGcoJnMtPm1pZ3JhdGlvbl9ibG9ja2VyLCAiTWln
cmF0aW9uIG5vdCBzdXBwb3J0ZWQgd2l0aA0KPiBTTU1VdjMgIg0KPiAgICAgICAgICAgICAgICAg
ICAgICJhY2NlbGVyYXRvciBtb2RlIGVuYWJsZWQiKTsNCj4gICAgICAgICAgaWYgKG1pZ3JhdGVf
YWRkX2Jsb2NrZXIoJnMtPm1pZ3JhdGlvbl9ibG9ja2VyLCBlcnJwKSA8IDApIHsNCj4gLS0NCj4g
Mi41My4wDQoNCg==

