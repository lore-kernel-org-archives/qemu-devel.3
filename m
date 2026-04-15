Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0479F419A6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD07a-0004EN-HT; Wed, 15 Apr 2026 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD07Y-0004E4-Ps; Wed, 15 Apr 2026 09:17:32 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wD07W-0001UT-W9; Wed, 15 Apr 2026 09:17:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcCpDol+5x5DTJmnawpiWzlBM+Tt53r1d9HYPtGpwOEq2bohnnMZw/WDXtupP8yg+3k6x2lA7XtVfhl5GT9OStUUuSb7sHl0zC30X9cNRnQYPWJ725yvo46ZEqy1ZvardyLPXVM/mzF1Pt5VmXQtfve1BdOM1nwyP4dpuNS5XIpjC5tNXyPcIZ7hDbU+UrBcF4ptVPwcbiUoldY3MxbtHpaSqY7abV1NCNXqZVHtTmbBMlaXVyy9vQVdAGWItoSRGt1w5TFRxdp2rtt7fjiRhoJKH13mmkCGQVoUhmDzPmizG9nzdPkFQDPw/hDWJpSPyOiQMsP+e4GHN9e5OKrNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+DtOK5xtld+zPdNnBhWADto3iql5Ef7PLztOGdq//E=;
 b=g4o/hf/HMsurDCeQFIJW6rfiSPYeUJfH1e7eLCj71krYxqcuFleXQG9wmgVfUEUl4Vce6FPc4ZxB8YdH999qLYoPNfVXMcVN4gafj6Ewk8nnmZnTFLQ7n52wJu9nMWUaFeAJgRdpy5vL0PdKTKmpRnC0IGR2F3JUBpw77pxXt/R1kkju9EiSYay5HP8fRuIe/pYNI1jGGNVB2Vny3Fphx1YHCR1LKVjpwK0MsvULS9J6VxroMWSfyMgZ1RbgEQnCxtwGo7OXlp950RmzMw18ob0Cot5fkP+1v0Razh5RBM9G/ccHM3t2dSA8s8pJxuqqytwh9tY6WMI3ddNwDIhzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+DtOK5xtld+zPdNnBhWADto3iql5Ef7PLztOGdq//E=;
 b=V2MW3y4jct4MYedU6PcwpRpjtw1Eq/AsYmv2kf15FSBGljH+rGHRIHRiwhNX4Apob7shrCK8d6lJuQZ58t305uhB1yyQ2We1bSR3RCgA/eyLcXQCKM4ddSJYtidD+SuNfPB/+yxh2YOgFx3kalEKXbNupcM5Tq7w6RCTzqe/91AobMmG6v2eKwLia4UMeSb7dFoQdBmsp9eZ83izuhY44Q0KywB5ccDiU+QuDnJ2WzfzTBgV8qchm6wywUQcVUnRkHVSlpR4aN/+ldNJuUnlD3nSzNaC1LBBhWl8htVn8q+DGHUooRLFshNw1x7XwQ4AK/oCnX1RVFyMTjna7T/xIA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 13:17:25 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:17:24 +0000
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
Subject: RE: [PATCH v3 16/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register writes
Thread-Topic: [PATCH v3 16/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register writes
Thread-Index: AQHcpw4Qs2QkAWT1/kKqhZarqomm9bWpaNwAgDbX/ZA=
Date: Wed, 15 Apr 2026 13:17:24 +0000
Message-ID: <CH3PR12MB75483DAF4626B9B961C32F74AB222@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-17-skolothumtho@nvidia.com>
 <812bf464-7e21-447a-a377-9119bcc4b37f@redhat.com>
In-Reply-To: <812bf464-7e21-447a-a377-9119bcc4b37f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SAWPR12MB999140:EE_
x-ms-office365-filtering-correlation-id: 9422a8b1-5f58-4d4d-5ebb-08de9af15569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: jwhRhLm/jlm65lcHijMr5h8CI5mcgwBmZ+zXZkJy+o50RPmSZaiGQue4GQf2lh3+mMd6OYb80iA2Y9WGvXTCad6bM+W/1y25w5qPRMaJqRmCRJOVxkaqr4mPyujP3Ptp968MHiTjcQrX4nQfKQhnIUM+DNKdRB68czioWnlrfUJaoyBKDHMmoeTzGwyME6w0alnyC1NJIQfEcUOPGraefY/6deseSGVfUPyqtUp8GqwB3r/giiy/IRVi2UqQI661+0ozu6sFtoYHUD8qoegpWwEOsNRI+9PMTT0Hv02B4+iDUmG7XcXdltJ+vJki2R/+Bdhfksrumnfd79x5iC5rUceouZHZrH0hK2ODAofIql/Li1fWQ7tpl0MMEkn8L09svrUhFBXiQ7+FbNQsobXLW8zH6yU2shs1+277cSDd8k9Nxf7jD8Iw6UAXO9mf7Jebg1qhDl72eM099bPgvivSSqv3dYq1IRjf/3WY1tJZLxgIcTWb9O7MWqed1jcv9d00lq+c6xK8AP7sDts2ea9pA6JP/XZ3u4pnHwNQAgNQISk1Fe6zRzg170z9l/+0vkfaZ6J1gixm/KFLRQ6zhdht/y9yKDzpu5FS4GMrEMII6nw20paJjgGPggqgX9xxbHXlu2Hm5bs6tl37P3jN3J6qsgUYfrma42fu2riQDEk8BPzhTkkSSo48DJHzMyyolg9zN47icQCmaBvm6nIuXtDPLJN2YhxDvxzGsKUC3MAwEOmO8UhgUvrCx6FXfYKG1Z4X2Jsm9hcVpm6zouslP64hIyDg4F4Gco5LT0MgSvPuxAY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnY1Y3l0aGE0dXdaL3NVcmlUa0pncUYvUHNhTGE5L3pkcFZFRXdPUEMxeDJH?=
 =?utf-8?B?a1o3cCs3RHBHOXNWZUpqOEhtU3BnUUpEdE5VSUU1dmQ1bnlucmR1b29PVWcy?=
 =?utf-8?B?VURUN0Q0Tko3dTArS3NQUW5IMEtXRnU5T2pSaHJaTXJSQzhIKy85bnAzbzBC?=
 =?utf-8?B?UU5PVGpnQ0dUb3k2eTRSbWNhZ2NQSUQ5SngvRzRZV0IzSDVRcnZ3THM3bWFZ?=
 =?utf-8?B?cmEzM29mWkxhSmF4N2MvNjJQWTV4K2NTUkVuTDk5bWxLWTNES1dIYzVpMitr?=
 =?utf-8?B?S1Zod1BCa01WWis5K0c5bUNwYmo5VGJyOFYvTTNkRXczL05zbVQzK0lxNmlY?=
 =?utf-8?B?WHFVaWZrS0RiaUNnYjkyV1pCMDlaOXBnSHBFdE85NTU4TkpwVzBkM25rdGN0?=
 =?utf-8?B?QzFYNWVscW54bGlSNzlqWG5qUS9tazhoVWVacGRVeFRwbm5hdkhwUjU0bGJC?=
 =?utf-8?B?WUJhaEtKTkFXK1VuYjVreEJGM0laOXc4UWsxaEE3Y0pveVZmMXQrRHhyUnFo?=
 =?utf-8?B?VkxzcGFpdWFZKzUwcS9LU0dGbUI4MXZGY3BOOGlrZCs4TVVaNDNDRXM3bUUw?=
 =?utf-8?B?LzI5UndJakswU1E2WkxkV2F5dFlBRHJvQUdRcCtCQ3dvb0lob3p6dkI0L1BZ?=
 =?utf-8?B?aTVTbHRTVFpLSHQydVB2ZEdDS3Jqc0NTM0VUOVVuUHhrU3Bsd3M1ZVl0blZK?=
 =?utf-8?B?R29JWW1IWXFjMk5rRnBBbGJwN01ENE5obHNnUGhSM2JCdkUyaUVyWG1CSmRl?=
 =?utf-8?B?d2ZBVVNYczlvaDJLajV4L0dNVEk0cmQvUi9USGxmVThnWmZNU2NrYm5CSElP?=
 =?utf-8?B?djBUN3J4S05jNExwWjhKLzRDclUxMTRyNUVzb0NZRjlFeEdiVFJSczB2UFF0?=
 =?utf-8?B?L2VtRU1XS21SdjJhdUVPMHEwZmFIMzQ0YzdNVUR3OW94aGlRNW4yaVNPNzB0?=
 =?utf-8?B?N2c4U0l4U0tRN0JkT25HZC9Ia2V6bDVXaDJDUm43dnNtMW5KeDdVZ3lDdHE3?=
 =?utf-8?B?T00wSGNEZXJ6L3VkREtLbEtTZFEvdVYxbmlYSnRNSzU2eS9rUlNoSkpkbDVF?=
 =?utf-8?B?aTdad2RrdWFHbjhHTnovODVjV1B5SlBxeExDZm5OeGwwVXRBZXVDQTM3SVpa?=
 =?utf-8?B?TDhOeGlGMUIzOFBaNzRsTnB2a3RqWUlIcGNxVXlENm1QYU1tT2RSOS9TVFly?=
 =?utf-8?B?cDBNR3hzRXJ3WVVwaWIyVlkzZmdURW5NQWZjU1kxbXQxR05KMzlsRHErOEJQ?=
 =?utf-8?B?aUZiNlBaem1hQndzUDgwU2F4NWJKWFhEaVEvb1lJbnlGWi9qeDczbTBSSTFp?=
 =?utf-8?B?bjJhNVpKNEdYWEg1S3BLVkFrNzdnZGg4dllabExWODQxWCtJWUNSQkQ2WjY4?=
 =?utf-8?B?TWJ6cjE2V0pwb004MzgwbHJWNGx2VmRZd1ZMdERocHNkVUtlZVVyOGNUWkFa?=
 =?utf-8?B?Q1hKZ0paY1Nod0EreTRVL0FQeFFjZW84bmRlcGY0SkpKNWZmMlgvakdzamNi?=
 =?utf-8?B?VjJnLzh3am54dWQrOWhkMTNwTjdONjFveEtGSTVoS2dGUFlyWXNldEE3VnBz?=
 =?utf-8?B?c0Y0d2F1Mm5Pd0JXcWFVUWFYcDhTWGQzRG9sQ2pvRlB3Y2ZFNVVhOWRSMHFF?=
 =?utf-8?B?K1JPRjZpajhJaWVYVit5eVZQdlBmWHJaRkJVdy9ZWHFiUmE1eVJ5WVpkeHMx?=
 =?utf-8?B?SU9La09EMm9FdWxGa2E2eFM0Y1RTOWttSGp1NHhwWjFsS0RQS0FXUEhibzJP?=
 =?utf-8?B?d0VqNHVUUWlaSzVtcDdvYUNCdHJaNXB3UkNEaTdwMHl5NFF3Vy9zbHNrN1Js?=
 =?utf-8?B?RnBBWWE4SHVNemtMVnAzQnhOMW5jNHU5S2I2aEkveFhvQ0NGTldSNmJNWS9U?=
 =?utf-8?B?WElCY1RlUVpRS2ZXa0pyU3I0NUpRbldBUS9kQmo4WDJKN0NGUXM2MnZvV21n?=
 =?utf-8?B?TkNHNlN2bzFrUERJdTZKNDZTSXN4WHNUWEc0RnNkc0hxZzhFcjNMRXVGVjkw?=
 =?utf-8?B?Uk1KYkw2ZzJ6ckl3UjFUMEpFZVA0dm9BeXh5NFZIL3BQcHh1L2swaTYySm50?=
 =?utf-8?B?Y2sybmhpdUJQRVBLM3ExUXU0RHE5dzRWb1FQbXNEb3FUbHZaSHF5bWlRNk5F?=
 =?utf-8?B?OWh5WWcwK2tuaEJINklLb2p2T3lHMkhhRjJKS20vZTZIZS9tb0UwWFZSVkxp?=
 =?utf-8?B?WDMvcHpWcVBjTUJUaDBXQlVWYmZzcGtzRDZTYUVMalJReXhoemt2TTNvb2VO?=
 =?utf-8?B?ZzllL0tuYmtwdThmTEU0MllQMkh4ZVU2dGc3dTNGN2NPYlhseloxNzhrR0pm?=
 =?utf-8?B?WHE4TVh0SWJPcmQ3dVVFN0dmUXNZK240WWxuUFhtVjBGaWNLYlJqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9422a8b1-5f58-4d4d-5ebb-08de9af15569
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 13:17:24.3858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxVxWDK38TuZI/+0a1VaLFg9dZIDSIwm9SklZyl+S0KJIqQPm1K9RadOasHmJsAUxdKDRdKxKA7EoRG4O+EOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDExIE1hcmNoIDIwMjYgMTM6MzIN
Cj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsg
Tmljb2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0aGFuIENoZW4gPG5hdGhh
bmNAbnZpZGlhLmNvbT47IE1hdHQNCj4gT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IEppYW5kaSBB
biA8amFuQG52aWRpYS5jb20+OyBKYXNvbiBHdW50aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsg
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsg
emhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlk
aWEuY29tPjsgcGhyZGluYUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTYv
MzJdIGh3L2FybS90ZWdyYTI0MS1jbWRxdjogRW11bGF0ZSBnbG9iYWwgYW5kDQo+IFZJTlRGIFZD
TURRIHJlZ2lzdGVyIHdyaXRlcw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9w
ZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAyLzI2LzI2IDExOjUwIEFN
LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xp
bmNAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIHdyaXRlIHNpZGUgY291bnRlcnBh
cnQgb2YgdGhlIFZDTURRIHJlYWQgZW11bGF0aW9uLg0KPiA+DQo+ID4gQWRkIHdyaXRlIGhhbmRs
aW5nIGZvciBnbG9iYWwgVkNNRFEgYW5kIFZJX1ZDTURRIHJlZ2lzdGVyIHdpbmRvd3MuDQo+ID4g
UGVyLVZDTURRIGFjY2Vzc2VzIGFyZSBkZWNvZGVkIGludG8gYSBWQ01EUSBpbmRleCBhbmQgbm9y
bWFsaXplZCB0bw0KPiA+IFZDTURRMF8qIG9mZnNldHMsIHJldXNpbmcgdGhlIHNhbWUgbGF5b3V0
IGFzc3VtcHRpb25zIGFzIHRoZSByZWFkIHBhdGguDQo+ID4NCj4gPiBWSV9WQ01EUSByZWdpc3Rl
cnMgYXJlIHRyZWF0ZWQgYXMgYSBsb2dpY2FsIGFsaWFzIG9mIHRoZSBnbG9iYWwgVkNNRFENCj4g
PiByZWdpc3RlcnMgYW5kIHNoYXJlIHRoZSBzYW1lIGRlY29kaW5nIGxvZ2ljLg0KPiA+DQo+ID4g
V3JpdGVzIGFyZSBiYWNrZWQgYnkgY2FjaGVkIHJlZ2lzdGVyIHN0YXRlIG9ubHk7IG5vIGhhcmR3
YXJlIHF1ZXVlDQo+ID4gbWFwcGluZyBpcyBwZXJmb3JtZWQgeWV0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0t
LQ0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYuYyB8IDgzDQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgzIGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBi
L2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jIGluZGV4DQo+ID4gZDJlNjkzOGU0NC4uZTFmMTU2MmM0
NCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+ICsrKyBiL2h3
L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gQEAgLTE1MSw2ICsxNTEsNzAgQEAgc3RhdGljIHVp
bnQ2NF90IHRlZ3JhMjQxX2NtZHF2X3JlYWQodm9pZA0KPiAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0
LCB1bnNpZ25lZCBzaXplKQ0KPiA+ICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiArLyoNCj4gPiAr
ICogV3JpdGUgYSBWQ01EUSByZWdpc3RlciB1c2luZyBWQ01EUTBfKiBvZmZzZXRzLg0KPiA+ICsg
Kg0KPiA+ICsgKiBUaGUgY2FsbGVyIG5vcm1hbGl6ZXMgdGhlIE1NSU8gb2Zmc2V0IHN1Y2ggdGhh
dCBAb2Zmc2V0MCBhbHdheXMNCj4gPiArcmVmZXJzDQo+ID4gKyAqIHRvIGEgVkNNRFEwXyogcmVn
aXN0ZXIsIHdoaWxlIEBpbmRleCBzZWxlY3RzIHRoZSBWQ01EUSBpbnN0YW5jZS4NCj4gPiArICov
DQo+ID4gK3N0YXRpYyB2b2lkDQo+ID4gK3RlZ3JhMjQxX2NtZHF2X3dyaXRlX3ZjbWRxKFRlZ3Jh
MjQxQ01EUVYgKmNtZHF2LCBod2FkZHIgb2Zmc2V0MCwNCj4gaW50IGluZGV4LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWx1ZSwgdW5zaWduZWQgc2l6ZSkgew0K
PiA+ICsgICAgc3dpdGNoIChvZmZzZXQwKSB7DQo+ID4gKyAgICBjYXNlIEFfVkNNRFEwX0NPTlNf
SU5EWDoNCj4gPiArICAgICAgICBjbWRxdi0+dmNtZHFfY29uc19pbmR4W2luZGV4XSA9IHZhbHVl
Ow0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIGNhc2UgQV9WQ01EUTBfUFJPRF9JTkRY
Og0KPiA+ICsgICAgICAgIGNtZHF2LT52Y21kcV9wcm9kX2luZHhbaW5kZXhdID0gKHVpbnQzMl90
KXZhbHVlOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIGNhc2UgQV9WQ01EUTBfQ09O
RklHOg0KPiA+ICsgICAgICAgIGlmICh2YWx1ZSAmIFJfVkNNRFEwX0NPTkZJR19DTURRX0VOX01B
U0spIHsNCj4gPiArICAgICAgICAgICAgY21kcXYtPnZjbWRxX3N0YXR1c1tpbmRleF0gfD0NCj4g
Ul9WQ01EUTBfU1RBVFVTX0NNRFFfRU5fT0tfTUFTSzsNCj4gPiArICAgICAgICB9IGVsc2Ugew0K
PiA+ICsgICAgICAgICAgICBjbWRxdi0+dmNtZHFfc3RhdHVzW2luZGV4XSAmPQ0KPiB+Ul9WQ01E
UTBfU1RBVFVTX0NNRFFfRU5fT0tfTUFTSzsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAgICAg
Y21kcXYtPnZjbWRxX2NvbmZpZ1tpbmRleF0gPSAodWludDMyX3QpdmFsdWU7DQo+ID4gKyAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgY2FzZSBBX1ZDTURRMF9HRVJST1JOOg0KPiA+ICsgICAgICAg
IGNtZHF2LT52Y21kcV9nZXJyb3JuW2luZGV4XSA9ICh1aW50MzJfdCl2YWx1ZTsNCj4gPiArICAg
ICAgICByZXR1cm47DQo+ID4gKyAgICBjYXNlIEFfVkNNRFEwX0JBU0VfTDoNCj4gPiArICAgICAg
ICBpZiAoc2l6ZSA9PSA4KSB7DQo+ID4gKyAgICAgICAgICAgIGNtZHF2LT52Y21kcV9iYXNlW2lu
ZGV4XSA9IHZhbHVlOw0KPiA+ICsgICAgICAgIH0gZWxzZSBpZiAoc2l6ZSA9PSA0KSB7DQo+ID4g
KyAgICAgICAgICAgIGNtZHF2LT52Y21kcV9iYXNlW2luZGV4XSA9DQo+ID4gKyAgICAgICAgICAg
ICAgICAoY21kcXYtPnZjbWRxX2Jhc2VbaW5kZXhdICYgMHhmZmZmZmZmZjAwMDAwMDAwVUxMKSB8
DQo+ID4gKyAgICAgICAgICAgICAgICAodmFsdWUgJiAweGZmZmZmZmZmVUxMKTsNCj4gPiArICAg
ICAgICB9DQo+IElmIHdlIGNvbXBhcmUgdG8gc21tdXYzIHN0ZCBjb21tYW5kIHF1ZXVlIEFQSSwg
d2UgbWlzcyBzb21lIGNoZWNrcy4NCj4gU2VlDQo+IHNtbXVfd3JpdGVsKCkNCj4gICAgICAgICBp
ZiAoIXNtbXVfY21kcV9iYXNlX3dyaXRhYmxlKHMsIHJlZ19zZWNfc2lkKSkgeyBmb3IgQ09OUw0K
PiAgICAgICAgIGlmICghc21tdV9jbWRxX2Rpc2FibGVkX3N0YWJsZShzLCByZWdfc2VjX3NpZCkp
IHsNCj4gDQo+IEluIHRoZSBzcGVjIEkgaGF2ZSBhY2Nlc3MgdG8gSSBmYWlsZWQgdG8gZmluZCBh
bnkgZGV0YWlscyBhYm91dCBlcXVpdmFsZW50DQo+IHJlc3RyaWN0aW9ucw0KPiANCj4gQ2FuIHlv
dSBjaGVjayBpZiB0aG9zZSB3cml0ZSBhY2Nlc3NlcyBhcmUgYWx3YXlzIGFsbG93ZWQ/DQoNCkkg
Y291bGRuJ3QgZmluZCBhbnkgZXhwbGljaXQgcmVzdHJpY3Rpb24gaW4gdGhlIHNwZWMgZWl0aGVy
LiBUaGUgc3BlYw0KZGV0YWlscyB0aGUgIkVuYWJsaW5nIHRoZSBWaXJ0dWFsIENNRFEiIHNlcXVl
bmNlIGFzOg0KDQogICAgLSBQcm9ncmFtIHRoZSBWSVJUX0NNRFFfQkFTRSByZWdpc3Rlcg0KICAg
IC0gSW5pdGlhbGl6ZSBDTURRXyByZWdpc3RlcnMNCiAgICAtIFByb2dyYW0gdGhlIFZJUlRfQ01E
UV9DT05GSUcgdG8gZW5hYmxlIHRoZSBDTURRDQoNCkZyb20gdGhpcywgbG9va3MgbGlrZSwgdGhl
IGV4cGVjdGVkIGJlaGF2aW91ciBpcyB0aGF0IEJBU0UgaXMNCnByb2dyYW1tZWQgb25seSB3aGVu
IHRoZSBWQ01EUSBpcyBpbiBhIGRpc2FibGVkIHN0YXRlLiANCg0KV2UgY2FuIGFkZCBhIGRlZmVu
c2l2ZSBjaGVjayBieSByZWFkaW5nIFZDTURRX0NPTkZJRyBkaXJlY3RseSBmcm9tDQp2aW50Zl9w
dHIgYmVmb3JlIGFsbG93aW5nIGEgQkFTRSB3cml0ZS4gSWYgQ01EUV9FTiBpcyBzZXQsIHdlIHJl
amVjdA0KdGhlIHdyaXRlLiBUaGlzIHdpbGwgZW5zdXJlIEd1ZXN0IGhhcyBkaXNhYmxlZCB0aGUg
VkNNRFEgYmVmb3JlDQpyZXByb2dyYW1taW5nIEJBU0UgcmVnaXN0ZXIuDQoNCkZvciB2NCh0aGF0
IEkganVzdCBzZW5kIG91dCksIHRoaXMgcGFydCBpcyB1bmNoYW5nZWQuIElmIHJlcXVpcmVkLA0K
d2UgY2FuIGFkZCB0aGUgYWJvdmUgY2hlY2sgaW4gdGhlIG5leHQgcmVzcGluLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQo=

