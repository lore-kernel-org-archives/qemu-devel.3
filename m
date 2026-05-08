Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA72CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLPH-0002Nd-Uz; Fri, 08 May 2026 09:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLLPF-0002Mv-K7; Fri, 08 May 2026 09:38:17 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wLLPD-0006yn-3m; Fri, 08 May 2026 09:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhxF+BVGjFyDdGVhPTvxeII08usETo1SqcQMVPnkxtBP3CmP8Qij3IjPFlGn5oMt2Rl4sEHW7Dn4WomiwA/bAcxMPRLPFw3Pyp+B0YyzYVgcIwx98guxDGi7lg0wNAj6bWyhB0Mj0l7gvnjqvJoS7U0Z1INxsN1SdSi9t5QRK0RqkyaVr8TptCIcMbm2XpSU0RmduYboK6OVDwARH4tOtdYaks+AlUUtNepmw7YuYtkMmAC+bVf1oAuXIr3w1K6iUNYkIwn4I6T/RVdX6rFino0RYPR44WWyZxuE3cXvTKDZW6rsQdCwfHxENWxfQmHPK/X87Jnva4kLDnEj63nPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sdge7g74UmTuRaPIuT7ovemDR3TQrUJFtqHhukY2uWU=;
 b=hP695/flVv01ZNOGNbXvat6Q5OtMHv1cISxdHEn1w8y4n5pvRbSiFq1MC+1s3UrOrEnO1MH7Av10deAR5WB5fOMd88yJMNwt8k4nRp9QO9FX+hCYPVzlE3w6v8IIC6jbRszKX8rndQFitXN87RBzM51HZFFkGUGLALpPujEJU1r/k7Tur6TeAVdjczHS1FsQ0HcNsgpM08RrE5T+b+vBGyhF56YVf7vcGQcCoGZw8DXKIn8QID6jXzdRfhaxsawvkFjdxOrMkS9hZrHFMefDrr9cxA3Xu76TEi1jThlEzUCxbpkaaosS+5L+1OqIwKs7e8ceUQ3UPMSMvMivthyUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdge7g74UmTuRaPIuT7ovemDR3TQrUJFtqHhukY2uWU=;
 b=r2htlpIOJIyDnrM5sROQq+maF8z3g+7aXHeEcMW6mCbW/GHTyIPgsa+/v9/41rbPz7RONQuU7YYzdCGTHiMPa7bm6CfXanu/PSSyUUuMhwh3ifHLXSB3vfcsS/pd54lA8D6ShsaIFnGC66PeGcTk42CSTycson4eS3huxNwEBMoj5GTHEf8rQtoA9rCzSmrEa1ojiP+yxG7RoeBZNLZnx235Pfy6Yqudhrzkkgla7mxRk4Vi563dGW+37vNJLY30ugQ5cRirwvttGmb4+AC24SdplDkq+zTPra+qLwSenSfox1eEsrYgbRxL1zGqmI3MldFiBUkZBfJQx3HtEnME/g==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by BN7PPF915F74166.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 13:38:05 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:38:02 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Thread-Topic: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size based
 on backend page size
Thread-Index: AQHczMbKDzvmu+ObBESPXEBQHyDSxLYC8wEAgAFQTaA=
Date: Fri, 8 May 2026 13:38:02 +0000
Message-ID: <IA0PR12MB75555AF6ED6EF19543546F04AB3D2@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-27-skolothumtho@nvidia.com>
 <e7a172be-41b4-40c8-8b1b-2814450d110a@redhat.com>
In-Reply-To: <e7a172be-41b4-40c8-8b1b-2814450d110a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|BN7PPF915F74166:EE_
x-ms-office365-filtering-correlation-id: dd53318b-9ceb-4e97-19a1-08dead070706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: UHec7hj1AqLUwAWfUZjeVVB97+ZeV5UV+pEj0EZrqYw5fxl7tSJawS/QvXZtmJrOlzyF1+ipRxh43SHHg5vngrNGDUrHmic6BVYG/lB/FM4iMJWdYInbrOlW22oRXMhN112jw41CIypo6rZVpMqYI0+ksAjK+/91yP4i5os5Sfm5DyWeXGnlksFfl8ix0R+TCwJQVHjPyjMBWQIILkeG5rLaxzph8GBFMGq5Ls47c7sRDRzog+7if5Xin4Z8qE5MS3KD4NJSxbJevyc65Ww9mtsOer7YsEkXaUPGQjBgWoybh0HdCBU+wYAD7u5H9KQBE42qAZLZt6U4J6tM830wJfj1C4NyLZa+n64nsxxQMarJ2hBH+SdUhr9TLMWtxGlUsTs5k9hBAP1JhkMkCtL2AIXrySQKeBo+xbJQ/58lEtKEuIv4PCVZqDctiP8CUc9qkBvzzPOirIiWPTmlIlbdIxN2vFNSN/bRnGQbzpb61NNfup4cWbKr8AFnu6QxAFB+YHwFPVdwDknrb6oFrB8sT6lSKtMH2PJ91aauyTmtp+7rJAu1+meQJtzrHT2gklkVKQn5e70NXG4atfPTW0fplG0Q4ZRKiit6ktrKf6CgY7TlKf7ONRoCoFCoeGtN/p8UiU3/9Hv2lPDOrewjKCy0cL6+sfdCzX1OFOWmeVFls0jv3b14KPe1YRFJTDbck3iE9t/KXtYFPyLmkekilHLfwfiZ1PQ1/yI/Rth+WtZ1euSEwDCv15T/lARIFzYV1ntW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FVN3hYdHBFV0lXalFDbW1DK1NDUm5JTDFwYVFlVmlyNkNPaWQwZDFhc3Jx?=
 =?utf-8?B?VFJmSnhoRmtpcmkrK0IrYUtFbkpRWjF0SElJa1U4WlJrQnZJVlorYjNyVXdo?=
 =?utf-8?B?bzVPTU1qMDZFbS9XdXlJR3ZZd2tmWFVsSGpnN2U1QkRMbFFJU1ViOGJNanpN?=
 =?utf-8?B?OUhLRmFMV0lJRUtMWUx6MytVa2Fvd2VFU2F2MXFZTkc1VDNmTUwvZ0VHaTds?=
 =?utf-8?B?TjBXTm0rSGV6QzlZZlYzcFBEQnJJM2ZvdnEzWEtrYWgwMEFuTHVqNWZBTFNt?=
 =?utf-8?B?eUdlUDFxTU45Vk1WRmpmVDQxUHNVenpiY29LMXlJelJIY3ZrQXRlMGNIS241?=
 =?utf-8?B?MjdpVCtONmJkL1R1Y3FJSVpkY0x5ZzBVSW9saGw4b0g2ZjlZb0pzVERRUVNr?=
 =?utf-8?B?TFhjTUFFaEN0bVRvVlBRQXNFR21BVGRzNzM0SmdtZW9WbDN3aDN0SkM0VGNy?=
 =?utf-8?B?bGd2RFFFYkx6RkRhUGk1SWFTNEx6azl1VTRkRGxGNE94TjF6TGtTWTFTeGRq?=
 =?utf-8?B?SkVGYUw3UnZ1WUV0bWdNSDg4QThzR3B3Q3liNUtPZVBGaHI2dGFUbU05dmVy?=
 =?utf-8?B?M09kVTFXUzN2Z0ZzbzA0YnVVSytHYklWTzhqekEvdm5CWnh0V3NPM0dEcUpr?=
 =?utf-8?B?MXFUNnFwanNaOFdlenQ5cE1DNlQ3KzRQSHlFKzZqbG40S0N4M0dCOW5kSXI5?=
 =?utf-8?B?SGtIN3lUU2c2ZHYxWWxFNDJzV1VmM0RjRTBuTVFkOHZFZlQ0UGM3UTJ5ZUJw?=
 =?utf-8?B?WnlkR3pKSVNRUUNLekVEc1VIMmJBTmZERTJGZldYZEoyUktYc29UcnJ4NnZR?=
 =?utf-8?B?cnhYQ0J6aTNsU3FzNHBjNmk5TFJNQmZvM3Fhd3R6QjdOZFFPdkNxVG9hdnho?=
 =?utf-8?B?dXhJTVIrRUNybUJ2NWRsUTNpZ3Z4bjRVQnQxZTE3UmI2TjNkMFRVbkw5MEF5?=
 =?utf-8?B?L1kwOFVkeFpLOFFKWjAvM1A2UjBhbCtZWFdvcXo1ZnJnVlBGZmVMYzc2T1BK?=
 =?utf-8?B?U1cyNVJiR2F1cTcrTkNuUmdSYS9ZdHFRdFRVMlR6SjlKTERSTGZMQWFyc1J1?=
 =?utf-8?B?TzNDZEI4Q1E3Z3VGcVo3ZVZLekEvRmdJaERHbXRTRC85OGdlb2k3Zjk2cThl?=
 =?utf-8?B?M3V6ZFZ2bUxodnRUSTViZzBqUmFLeFJLTzV2a1Ztbm91aFV1YktxWTJ5bnR5?=
 =?utf-8?B?akcvM2lubVBOUktIZXl1ZnVaVEQxMEw5MENFRmU1SHlITjdyZlY2TmNhbCtn?=
 =?utf-8?B?NGlHWE5UMlBQaTY4K3RUKzVtWk5EelZpaFJ5amlsLzNUb29tLzdlaFFqelZZ?=
 =?utf-8?B?eS82RWhIQk1TVnRRSHdjUTFPQ3BiNHFGV1F1b2cyc0FLOWpPZUhhRk5meHBo?=
 =?utf-8?B?QzBlL1h3NmZpN3VVZVBvemcvdERsUUFvL3dXZ3ZMUWdLTW1pZGoyOUp5ZDd6?=
 =?utf-8?B?L2tKSWtldWpoMkdNOUFVdnlZcUZ4cjZWb05wbEdrTzhzeWVKbTRYQUEyYXZF?=
 =?utf-8?B?UzBYYmFPeWUxMkJRbURvdDc5OFZlZDRBdTg3cy8wN1Qxc0JwbGpSdmN3QTZY?=
 =?utf-8?B?QkZNUXNzTFZHVGVjTHlaWTdmK28zYTNUcVVKbzcvOUJnK3dVOSsxQ3hwTTR5?=
 =?utf-8?B?L1doRUZWWWNoYVJzdjl3U1RNZTB5NU5XdmZEcVBqWGo2VnE4VUVyUStSRDZi?=
 =?utf-8?B?ZDNEVWlNS0h3SUI1VWxkVXRnR0FlUWNIYXJBVmpodDVGUTFMaFRWUHVXak92?=
 =?utf-8?B?Sjl6Qnp4V0w2Sk0zWENFQUNuT0piWkVqWU9FdlpwN3V1emFUTkc0TzdBR2Iv?=
 =?utf-8?B?VngwYk1wMFpkVHNmV0tCTkIzdHZOMmVIa2dLOXVFRjBnWHJ1eU9zZWQvYUQy?=
 =?utf-8?B?MlpRWGw1SXUzZzc1dEJHaXFvK2tPcUxDc25RaWdCdGFiN2xubjIxaUVyM3Jr?=
 =?utf-8?B?cVlDT21oVVpxSFQ4S0xBbXRwbzF2MWgzTzhtTkVQMm5Jd05ZMnNkZmV5QTFW?=
 =?utf-8?B?ZktNYjlmKy8zNXlWeW5WQnkxQVhLKzBzbDFIQVRBQkkwdGMxdS90ckRaSFlF?=
 =?utf-8?B?K3IzcGQxaENRQTBKVXZsUC9zczY5amxmVWttMDc3QjdtekVyWkFUbE9PY0o4?=
 =?utf-8?B?cWd5YkRpQnFabDRKTGFwTVY5MmQvakQxZDlRZ1hkbE93L0xSZGNvSzY5Q1lj?=
 =?utf-8?B?WmdmWHI0aFlzRGRlMmo2WXJhRHBobGF4dWhmY2NSYWhsaDJYQ1gxeStud0pz?=
 =?utf-8?B?T1pLRnUvUzFQTHl3Tk1SakdRa3huak1EV1pxM0o3eFhFWUdnbzdSbU5hWFlY?=
 =?utf-8?B?c1Zqb0pTV1k0V2FSTjRJcU5NOWY3S3d5eGdkbmZmaXN4enI3VUJyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd53318b-9ceb-4e97-19a1-08dead070706
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 13:38:02.7073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KfTZRVw1DyZz2+gCmnpAijKJGBzCsrIacibOue6vwiEAEZPqD/afkk+PvKqFGx0Lt5vuTUonnBBhxqQcBYm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNyBNYXkgMjAyNiAxODoyNA0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb207DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWth
bnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47DQo+IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDI2LzMxXSBody9hcm0vdGVncmEyNDEtY21kcXY6IExpbWl0IHF1
ZXVlIHNpemUNCj4gYmFzZWQgb24gYmFja2VuZCBwYWdlIHNpemUNCj4gDQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
SGkgU2hhbWVlciwNCj4gDQo+IE9uIDQvMTUvMjYgMTI6NTUgUE0sIFNoYW1lZXIgS29sb3RodW0g
d3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+
DQo+ID4gQ01EUVYgSFcgcmVhZHMgZ3Vlc3QgcXVldWUgbWVtb3J5IGluIGl0cyBob3N0IHBoeXNp
Y2FsIGFkZHJlc3Mgc2V0dXAgdmlhDQo+ID4gSU9NTVVGRC4gVGhpcyByZXF1aXJlcyB0aGUgZ3Vl
c3QgcXVldWUgbWVtb3J5IGlzIG5vdCBvbmx5IGNvbnRpZ3VvdXMgaW4NCj4gPiBndWVzdCBQQSBz
cGFjZSBidXQgYWxzbyBpbiBob3N0IFBBIHNwYWNlLiBXaXRoIFRlZ3JhMjQxIENNRFFWIGVuYWJs
ZWQsDQo+IHdlDQo+ID4gbXVzdCBvbmx5IGFkdmVydGlzZSBhIENNRFFTIHRoYXQgdGhlIGhvc3Qg
Y2FuIHNhZmVseSBiYWNrIHdpdGggcGh5c2ljYWxseQ0KPiBzL2EgQ01EUVMvIGEgY29tbWFuZCBx
dWV1ZSBzaXplIChDTURRUykNCj4gPiBjb250aWd1b3VzIG1lbW9yeS4gQWxsb3dpbmcgYSBxdWV1
ZSBsYXJnZXIgdGhhbiB0aGUgaG9zdCBwYWdlIHNpemUgY291bGQNCj4gYSBxdWV1ZSBzaXplDQo+
ID4gY2F1c2UgdGhlIGhhcmR3YXJlIHRvIERNQSBhY3Jvc3MgcGFnZSBib3VuZGFyaWVzLCBsZWFk
aW5nIHRvIGZhdWx0cy4NCj4gPg0KPiA+IFdhbGsgdGhlIFJBTUJsb2NrIGxpc3QgdG8gZmluZCB0
aGUgc21hbGxlc3QgbWVtb3J5LWJhY2tlbmQgcGFnZSBzaXplLCB0aGVuDQo+ID4gbGltaXQgSURS
MS5DTURRUyBzbyB0aGUgZ3Vlc3QgY2Fubm90IGNvbmZpZ3VyZSBhIGNvbW1hbmQgcXVldWUgdGhh
dA0KPiBleGNlZWRzDQo+IHdoYXQgaXMgdGhlIG1pbmltYWwgQ01EUVMgcmVxdWlyZWQ/DQoNCkFG
QUlDUywgc3BlYyBkb2Vzbid0IHNwZWNpZnkgYSBtaW5pbXVtLiBCdXQgaW4gcHJhY3RpY2FsIHRl
cm1zIEkgdGhpbmssDQppdCB3aWxsIGJlIDRLIHBhZ2Ugc2l6ZShDTURRUz04KS4NCg0KPiA+IHRo
YXQgY29udGlndW91cyBiYWNraW5nLiBGYWxsIGJhY2sgdG8gdGhlIHJlYWwgaG9zdCBwYWdlIHNp
emUgaWYgbm8NCj4gPiBtZW1vcnktYmFja2VuZCBSQU0gYmxvY2tzIGFyZSBmb3VuZC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNv
bT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgfCA0MQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NDEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS90ZWdyYTI0MS1j
bWRxdi5jIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBpbmRleCBhZjY4YWRkMmYwLi4y
ODcwODg2NzgzIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4g
KysrIGIvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiBAQCAtMTQsNiArMTQsOSBAQA0KPiA+
ICAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvY29yZS9pcnEu
aCINCj4gPiAgI2luY2x1ZGUgInNtbXV2My1hY2NlbC5oIg0KPiA+ICsjaW5jbHVkZSAic21tdXYz
LWludGVybmFsLmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vcmFtYmxvY2suaCINCj4gPiArI2lu
Y2x1ZGUgInN5c3RlbS9yYW1saXN0LmgiDQo+ID4gICNpbmNsdWRlICJ0ZWdyYTI0MS1jbWRxdi5o
Ig0KPiA+ICAjaW5jbHVkZSAidHJhY2UuaCINCj4gPg0KPiA+IEBAIC02NDYsOSArNjQ5LDM4IEBA
IGZyZWVfdmlvbW11Og0KPiA+ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICB9DQo+ID4NCj4gPiAr
c3RhdGljIHNpemVfdCB0ZWdyYTI0MV9jbWRxdl9taW5fcmFtX3BhZ2VzaXplKHZvaWQpDQo+IHNo
b3VsZG4ndCB3ZSBwdXQgdGhhdCByYXRoZXIgaW4gc3lzdGVtL3BoeXNtZW0uYw0KPiB0aGVyZSB3
ZSBhbHNvIGhhdmUgcWVtdV9yYW1fcGFnZXNpemVfbGFyZ2VzdCgpIGZvciBpbnN0YW5jZQ0KDQpD
b3VsZCBkby4gQnV0IHdlIG1heSBoYXZlIHRvIHJlbmFtZSBpdCBkaWZmZXJlbnRseSBjb21wYXJl
ZCB0byANCnFlbXVfcmFtX3BhZ2VzaXplX2xhcmdlc3QoKSBhcyB3ZSBhcmUgY2hlY2tpbmcgdGhl
IHNpemUgYW1vbmcNCm1lbW9yeS1iYWNrZW5kIFJBTSBvbmx5Lg0KDQpNYXkgYmUgcWVtdV9yYW1f
YmFja2VuZF9wYWdlc2l6ZV9taW4oKSA/DQoNClRoYW5rcywNClNoYW1lZXINCg==

