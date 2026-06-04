Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6645CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4Ln-0000T9-L6; Thu, 04 Jun 2026 05:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV4Lm-0000Sx-MD; Thu, 04 Jun 2026 05:26:54 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wV4Lk-0001Ua-Nt; Thu, 04 Jun 2026 05:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkPb3HQ1YyPMOX12k4nxXbanapLosSL9kvK+neTwTTl8frqvmw670wTwS1l2Z54Ycp28ZMUYp5r0yPBKLfliPHCgZUZDTu5sOdPZCsrCNHA/PFJdyl+hbUUReAN9YAFD3gpfbqKdAnL+eO1ZmziFPR9I5BzQu+xC5T9sewAR9VwFJk3H9Cjqk72EhnLgriWqeB7z7e4EmP8AdHhDra0OyG1HVoayYOnp3FQFhIcHGsrjQvtZJaX0zaUiCBVQUHiIzoCVx2JQaNmcCaKiv/BnBPWt76/5tFNJTfFW7cvqscqHqyB0hUoolVCOiySQICYA7uHAPpMD1/0nGZRIOksV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMKKTjq3yWtQDTfpsqfWfXs4sHONtqTPt/k9GoqCL4=;
 b=JiVbKVGEwiaEljR445mv6cFJ1LjNvuplq2vCWmgoOxUcMVMD5+0Tde+7bB7BHQtRN6JLA5j+CYOOtbuIvDrP5rVV9hRy+rJ8o63vPovGINdMdYtiwPALuLra2UWIfqru/RYgq9V1jkXOMQZ5Pqk/mvOB2dXXVMIhRVDWCyE3CT+jv5w5BJvvFunPjwi8zwbb3VM5KUbgcmZMCAxLVvOkpk0JuZPVLAOOV4NuCL197yf3lx0Ofk4nYJIu2y/RcoU4tnu2KtkyO4ZeMeUfWGspgDqnYqOq5w7u1h9V36C/Wws1FXuGiOhUB+ftQFZ0kO7mdkWl45et2KEDVYKhKHidFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cMKKTjq3yWtQDTfpsqfWfXs4sHONtqTPt/k9GoqCL4=;
 b=NAeRur9SYYQ6Jdbo9gZCxUoh/f+PLj8QXzI5ee907sul7F/V9zXreYH8EVkQZAKySpjdrmVWe5wQ7HuB4E0r1hef4p3w1wcfLRzrBOzJEcFgL6pfx5H66AAtOB3gS7UsCtrNGc4F7xiExrj275gUL96ZKRAD5dq2pC5G5IZnu23oA0FQyCJ8p/0s8l1Wu66wXRrtusBFCkfD85Sb51TGoLbgcdU1ncuwXcAkQB2l25uKQ5EBaIgq11QMSfyCP2Q2br6JKmKuKmmMtlyhOrTTg7QDZ1h/ClE1N4rPKtOSzBxtwwSnE61LfrUJmOd9EsqufMztBcII3VfgJIhY+ubDVw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 09:26:43 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:26:43 +0000
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
Subject: RE: [PATCH v6 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v6 17/31] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHc8by06ppMG7NvokarMS98R2yOobYuHd4AgAABb7A=
Date: Thu, 4 Jun 2026 09:26:42 +0000
Message-ID: <CH3PR12MB75482617D7EC570D8D4F0AFFAB102@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-18-skolothumtho@nvidia.com>
 <1a9b7bf7-cb1f-4826-a225-3346ba0debcb@redhat.com>
In-Reply-To: <1a9b7bf7-cb1f-4826-a225-3346ba0debcb@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL1PR12MB5923:EE_
x-ms-office365-filtering-correlation-id: 947d15e9-2516-4574-ee94-08dec21b63ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 3rbCuB3EeSXr11Je0iOHvRHvRpxKyfGsyr6QItpf6jUO9e7hWwndgoJOEZrkdq7krW5+TXW6tgK8GpFeDILjTOfDWVLEQ3kHIg4g/PWaFPkFGU6E1AZQ2eiVm4tAzoURM4+dfM2T9I/XOA0bTdMYdwi5F1wr2XBvifVkLKnA+wTeXNUkInuRPbzSQRSPF79nm9KStfBLSWtUt2GeYvu8XN8tz75k9s0zlqeOCZPG/G5ng6sy9t2CCLwJ1BiiVN3BDJBuywJ1kdaEvuUieifBs3o0A+31+UUa1v+PZ9a4lU24pQ5OXqeI4RVqlOMozj0ZqSclQx7mZWiPZ6yo3lEPJC/d00o1S/i69GDXZHycclo8QQvIaI8fPUPtEcN8BizowqjjG3hQAT8feOrLB2vGaSGiddY75ErirDmljUJWnAX0Cc9Vp3sSXh1Tt95FirRNY36dTSLawImu8u3fR+2mPc9jtns0WdauSQlt9dgFQmMI4heYGnW2sTz8IaBLS0O5OObMq9jrCirdzTP3kXQRnrf9ONuRRMziKlhs2yS+F9Zb/mYchHlhTO4S3DRSffL1YsS+vLApQ+zAR/WSYTziPOJ29VVbL62eeUwP2zHTdbngMzLMi9hegyqlH+NByQJRSK6E8rXDfxdKA0TO80cjh2RP6E0n9eYp8ai+rRcwgT6sbbRWP8kqvyC8qBmO5RL6l1EHwi2idjSq0n+A75RNMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVJyMitVUEdibzdDMEt4MkNjWmhYNk9DREQwZyswMkhSc2dMM0FrVDNrWlFJ?=
 =?utf-8?B?YWtwOTM1VWV5eWpyNUhsZnNsNjNFWmlwWldFdnIwcml4ZUxPTi9vUENKbmE4?=
 =?utf-8?B?T2pReHJibTI5MERaT1VoOUN1OE8wVUNBc2V0dWptaE41UWl1V1BDMytnbjRM?=
 =?utf-8?B?ODlyRVpWc205RWJZMG1NNFM3OWkySWVEd3I1WXlHZlNqREtlUHBRb1UxcEtt?=
 =?utf-8?B?WUFkY3Z3TTJOY1o3ZGpvdStwMXBFcFRDcW5jUFY3QnljcEV0VTlYZU92YlZz?=
 =?utf-8?B?VVdESmhpczFZQ3VpV1pPRFk2MkFZdExkWjBDQnNPK2l1cjRtV2NkUjJiNGtr?=
 =?utf-8?B?bFFwc1FhT0RuOERXeUVuUlowckZqTHdEWlZ4OHBwMXlXeHgycmV5aHB3TW5G?=
 =?utf-8?B?U0RkMXNINFhiWWQ3MnJ3Qm5TTGowUkpBK3dMN0ZDMlhZN21TRFR3OVg2eVNR?=
 =?utf-8?B?KytSSFVpajZZSDVTMWQ5ak4wTWZnbnFJblJiUzJKVnJzQW81Nk9tM0xPQmhH?=
 =?utf-8?B?NStGaG1xZG01djJ3WExPTTlzWXpqVnRBUFo5RVU3NktmRUduS09HSkQ1QWdO?=
 =?utf-8?B?MzdLenVFeTBIRjgwQjRiSHc5T3I3UTQ1ZjJtcHpUVFVqcjVIdnVPMHcvQkwz?=
 =?utf-8?B?aHo3ZkF1am1OSGx1ODVMWUZER2E2ZnRKUSttaytCZHRiMUdhazJhelVjcG9J?=
 =?utf-8?B?WjI3L1NGSERobXl5TUlIODZXRDE0RUhjSjJDSTJKOGZVbjF4SUczMVpreDIw?=
 =?utf-8?B?NjMxekFYYzBZVVBwTEZhbVBRa3RielJkSG40WTJubzVpU21TVzkxcXQvQW5B?=
 =?utf-8?B?bWtVM2lFdTE0SHNYL1BRcTFwL05CZzJRd3llOFg4QitaUTBZZytnUzhPYXZw?=
 =?utf-8?B?cUJoS3Z2N1N3MTZOOThIU20rV05YN2cyWjhYTEVGTE00M3pZNjhQaTFiRHdo?=
 =?utf-8?B?c09oeVp6djlHcml6U1BGRnllUEVsNzJ6dzIzNEpKeEJqNyt2OVIxTWJDTFBv?=
 =?utf-8?B?NlVoVzY3M3NBSDJYTWUvbHBuVWdvU1RCcjBydUxwTFhwTXNzYWxmdHBaNmVT?=
 =?utf-8?B?cGxwMjNqZS95ZFkxTGlicldYL1NnbFU4VVRTVnBRUmtiOWJQUldFaU5uSFZk?=
 =?utf-8?B?WU5CbEpRQnY5Yzk0QVp1ZFB3TUZyaWNybFh6UVZwcHBSTXNBVmE5OU9Wd0t0?=
 =?utf-8?B?ajN2a3NlS3BNQ3pJVjlqU0liQzduaTcxZE5rbmIzSldSd0lRQ1hqTGFaZGVa?=
 =?utf-8?B?OHBVUURnQmtSc3BQLytZNTlucFJIUmRHV3UrRUFLUGcwanFvMS91TlFIUDNN?=
 =?utf-8?B?Nys5RlQ4SXFod0ZDN1M0V3RqeWlEOWphRkJnd0txSkhTbkltMzZmSDhNREhS?=
 =?utf-8?B?eVBHN3pqR3JIZzBNdzNlNktEajNRQy9vZnhRVVVFQ3kxbCtJMVRUWG5zZkJk?=
 =?utf-8?B?LzVwRGxuZW9tQzZMeWcyUnpWbWV5SWprOFRmNUJHRUFBem1KTE5TMkFOeEpZ?=
 =?utf-8?B?UzdacHhqbVJGckFtOHR3R2RUMFBibjdHRmwrYmtlRmZHQlR4aDhmWEdZT09E?=
 =?utf-8?B?c2VFRlVHc3lJa2FZSGV2eklqWDR5ZXV1WFRIMnZaSFhzWkYrV0lCRU81SHBm?=
 =?utf-8?B?dklSVmgwV1dRSHI1dHlqSGtBOG9nRnlTcUZTQWs3SjlGYUJyWnF2U05tSmhP?=
 =?utf-8?B?S3FpVGgwdnB6QzZneFBvMUU5NUJQZkZvODEwMndKU3d6UHJnQWFPQ3E2SmF4?=
 =?utf-8?B?WlZpRVl0RllLays5dnVtTS9kcjY2T3VWSC9pSHNUS0hIVFlrUTR5TTNCMUhZ?=
 =?utf-8?B?WTA1RHplei9NT3BIVzVpT0E1K0FNYi9lVit3VDJuUVhsek1DclY1dkx3TFg3?=
 =?utf-8?B?SXYxLzRlVDVHeFN6OW1nQkNKYmd0cHhMUkkrQ1JremI5blJmT2hWYXJtOFdl?=
 =?utf-8?B?MjhjVEtERnQzL1lyeFZnTWQ5ZG9TWUtGbnEzTXIxWFJJc1FjN3RXc0NLTUIv?=
 =?utf-8?B?ZTRDa2x2SDdxeTVrcnFNc0VhSU9PeW9JS2MvMEo3VXJESjVBY3d4bm14NTdk?=
 =?utf-8?B?VlRrR1lKODJiTytDNDRUYjcveTJvTzQzTHFCMlNUVXFUbWQwZ3JndEs0QUpw?=
 =?utf-8?B?ck54WnI3UUlZOTAxNy9wdWhrajMvNFZUUytVdFkrRVBtVlhZQ2hpb1p6eGdx?=
 =?utf-8?B?NEVhcXA1b256Zms5OGowVGx2K0Nya2xLSXZhK1NkZ3ExaVhjR2FBTUYxNGxi?=
 =?utf-8?B?R0hyQk92MCs5djFJNGl4MVJ6bE82N1ZydUY5NS9iWlUzK2hpb29LS3F4Nzh5?=
 =?utf-8?B?MTJaNHlIczFhK1c1ZndldXd0UCs3MTNQbFBVWDBTSmVEY2lqSC9NZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947d15e9-2516-4574-ee94-08dec21b63ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 09:26:42.9222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NrJo67Fmy/cVhemrlQCOf9p463kt9lJ33003DACro7LdGB15S2i4vMsKhGby7eZMmnyv9sWVYcJrI9kS4lAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IEp1bmUgMjAyNiAxMDowMQ0K
PiBUbzogU2hhbWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBx
ZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBO
aWNvbGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFu
Y0BudmlkaWEuY29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFu
IDxqYW5AbnZpZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRp
YS5jb20+OyBwaHJkaW5hQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAxNy8z
MV0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2OiBtbWFwIFZJTlRGIFBhZ2UwDQo+IGZvciBDTURRVg0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNi8xLzI2IDE6NDIgUE0sIFNo
YW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPg0KPiA+DQo+ID4gVGhlIGtlcm5lbCBjdXJyZW50bHkgZXhwb3NlcyBhIHNpbmds
ZSBWSU5URiBwZXIgZW11bGF0ZWQgU01NVXYzDQo+ID4gaW5zdGFuY2UuIElPTU1VX1ZJT01NVV9B
TExPQyByZXR1cm5zIGFuIG1tYXAgb2Zmc2V0IGZvciB0aGUgaG9zdA0KPiA+IFZJTlRGIFBhZ2Uw
IGFsbG9jYXRlZCBmb3IgdGhpcyBTTU1VLiBIb3dldmVyLCBWQ01EUXMgb25seSBiZWNvbWUNCj4g
PiBib3VuZCB0byB0aGF0IFZJTlRGIGFmdGVyIElPTU1VX0hXX1FVRVVFX0FMTE9DLCBzbyB1bnRp
bCB0aGVuIHRoZQ0KPiA+IG1hcHBlZCBQYWdlMCBkb2VzIG5vdCBiYWNrIGFueSByZWFsIFZDTURR
IHN0YXRlLg0KPiA+DQo+ID4gV2hlbiBWSU5URiBpcyBlbmFibGVkLCBtbWFwIHRoZSBrZXJuZWwt
cHJvdmlkZWQgUGFnZTAgcmVnaW9uIGFuZCBzZXQNCj4gPiBTVEFUVVMuRU5BQkxFX09LIG9ubHkg
aWYgdGhlIG1tYXAgc3VjY2VlZHM7IHVubWFwIGl0IHdoZW4gVklOVEYgaXMNCj4gPiBkaXNhYmxl
ZC4gVGhpcyBwcmVwYXJlcyB0aGUgVklOVEYgbWFwcGluZyBpbiBhZHZhbmNlIG9mIHN1YnNlcXVl
bnQNCj4gPiBwYXRjaGVzIHRoYXQgYWRkIFZDTURRIGFsbG9jYXRpb24gYW5kIHRoZSBndWVzdCBN
TUlPIGluc3RhbGwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29s
aW5jQG52aWRpYS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxz
a29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90
aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3Jh
MjQxLWNtZHF2LmggfCAgMyArKysNCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgfCA1MA0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmggYi9ody9hcm0vdGVncmEyNDEtY21kcXYu
aA0KPiA+IGluZGV4IGFkN2ZiODcyNWYuLmM0ZDMyN2E5YTUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
YXJtL3RlZ3JhMjQxLWNtZHF2LmgNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuaA0K
PiA+IEBAIC0zNyw2ICszNyw4IEBADQo+ID4gICNkZWZpbmUgQ01EUVZfVklOVEZfUEFHRTFfQkFT
RSAgMHg0MDAwMA0KPiA+ICAjZGVmaW5lIENNRFFWX1ZDTURRX1NUUklERSAgICAgIDB4ODANCj4g
Pg0KPiA+ICsjZGVmaW5lIFZJTlRGX1BBR0VfU0laRSAweDEwMDAwDQo+ID4gKw0KPiA+ICBzdHJ1
Y3QgaW9tbXVfdmlvbW11X3RlZ3JhMjQxX2NtZHF2Ow0KPiA+DQo+ID4gIHR5cGVkZWYgc3RydWN0
IFRlZ3JhMjQxQ01EUVYgew0KPiA+IEBAIC00NSw2ICs0Nyw3IEBAIHR5cGVkZWYgc3RydWN0IFRl
Z3JhMjQxQ01EUVYgew0KPiA+ICAgICAgTWVtb3J5UmVnaW9uIG1taW9fY21kcXY7DQo+ID4gICAg
ICBxZW11X2lycSBpcnE7DQo+ID4gICAgICBJT01NVUZEVmV2ZW50cSAqdmV2ZW50cTsNCj4gPiAr
ICAgIHZvaWQgKnZpbnRmX3BhZ2UwOw0KPiA+DQo+ID4gICAgICAvKiBDTURRLVYgQ29uZmlnIHBh
Z2UgcmVnaXN0ZXIgY2FjaGUgKi8NCj4gPiAgICAgIHVpbnQzMl90IGNvbmZpZzsNCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYu
Yw0KPiA+IGluZGV4IDNjYjFiNDU1NzUuLmE1MmUxNTM1MDEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
YXJtL3RlZ3JhMjQxLWNtZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0K
PiA+IEBAIC05LDYgKzksOCBAQA0KPiA+DQo+ID4gICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
ID4gICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBv
cnQuaCINCj4gPiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gPg0KPiA+ICAjaW5jbHVkZSAi
aHcvYXJtL3NtbXV2My5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My1jb21tb24uaCIN
Cj4gPiBAQCAtMjE4LDggKzIyMCw0MiBAQCBzdGF0aWMgdm9pZA0KPiB0ZWdyYTI0MV9jbWRxdl93
cml0ZV92Y21kcV9wYWdlMV82NChUZWdyYTI0MUNNRFFWICpjbWRxdiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldDAsIHZhbHVlKTsNCj4gPiAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sDQo+ID4gK3RlZ3JhMjQxX2NtZHF2X211bm1hcF92aW50
Zl9wYWdlMChUZWdyYTI0MUNNRFFWICpjbWRxdiwgRXJyb3INCj4gKiplcnJwKQ0KPiA+ICt7DQo+
ID4gKyAgICBpZiAoIWNtZHF2LT52aW50Zl9wYWdlMCkgew0KPiA+ICsgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmIChtdW5tYXAoY21kcXYtPnZpbnRm
X3BhZ2UwLCBWSU5URl9QQUdFX1NJWkUpIDwgMCkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQgdG8gdW5tYXAgVklOVEYgcGFnZTAiKTsNCj4gPiAr
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4gKyAgICBjbWRxdi0+dmludGZf
cGFnZTAgPSBOVUxMOw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyBib29sIHRlZ3JhMjQxX2NtZHF2X21tYXBfdmludGZfcGFnZTAoVGVncmEyNDFDTURR
Vg0KPiAqY21kcXYsIEVycm9yICoqZXJycCkNCj4gPiArew0KPiA+ICsgICAgSU9NTVVGRFZpb21t
dSAqdmlvbW11ID0gY21kcXYtPnNfYWNjZWwtPnZpb21tdTsNCj4gPiArDQo+ID4gKyAgICBpZiAo
Y21kcXYtPnZpbnRmX3BhZ2UwKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfdmlvbW11X21tYXAodmlv
bW11LT5pb21tdWZkLCB2aW9tbXUtDQo+ID52aW9tbXVfaWQsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWSU5URl9QQUdFX1NJWkUsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjbWRxdi0+Y21kcXZfZGF0YS0+b3V0X3ZpbnRmX21t
YXBfb2Zmc2V0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNt
ZHF2LT52aW50Zl9wYWdlMCwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyB2b2lkIHRlZ3JhMjQxX2NtZHF2X2NvbmZpZ192aW50Zl93cml0ZShUZWdyYTI0
MUNNRFFWICpjbWRxdiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIG9mZnNldCwgdWludDY0
X3QgdmFsdWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApDQo+ID4gIHsNCj4gPiAgICAgIGludCBpOw0KPiA+DQo+ID4gQEAg
LTIzNCw4ICsyNzAsMTEgQEAgc3RhdGljIHZvaWQNCj4gdGVncmEyNDFfY21kcXZfY29uZmlnX3Zp
bnRmX3dyaXRlKFRlZ3JhMjQxQ01EUVYgKmNtZHF2LA0KPiA+DQo+ID4gICAgICAgICAgY21kcXYt
PnZpbnRmX2NvbmZpZyA9IHZhbHVlOw0KPiA+ICAgICAgICAgIGlmICh2YWx1ZSAmIFJfVklOVEYw
X0NPTkZJR19FTkFCTEVfTUFTSykgew0KPiA+IC0gICAgICAgICAgICBjbWRxdi0+dmludGZfc3Rh
dHVzIHw9IFJfVklOVEYwX1NUQVRVU19FTkFCTEVfT0tfTUFTSzsNCj4gPiArICAgICAgICAgICAg
aWYgKHRlZ3JhMjQxX2NtZHF2X21tYXBfdmludGZfcGFnZTAoY21kcXYsIGVycnApKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICBjbWRxdi0+dmludGZfc3RhdHVzIHw9IFJfVklOVEYwX1NUQVRVU19F
TkFCTEVfT0tfTUFTSzsNCj4gPiArICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgIH0gZWxzZSB7
DQo+ID4gKyAgICAgICAgICAgIHRlZ3JhMjQxX2NtZHF2X211bm1hcF92aW50Zl9wYWdlMChjbWRx
diwgZXJycCk7DQo+IHRoZSBtdW5tYXAgaXMgb25seSBkb25lIHVwb24gZ3Vlc3QgYWN0aW9uIGlu
IHRoaXMgcGF0Y2guIExhdGVyIG9uLCBpdCBpcw0KPiBhbHNvIGRvbmUgb24gcmVzZXQgKGluIHNt
bXV2M19hY2NlbF9yZXNldCBjYWxsZWQgb24gc21tdV9yZXNldF9leGl0DQo+IGNhbGxlZCBpbiBl
eGl0IHBoYXNlKS4gU28gSSB0aGluayB3ZSBhcmUgZ29vZCBvdmVyYWxsIGJ1dCBpdCBpcyBhIGJp
dA0KPiBhbm5veWluZyB0byBsZWF2ZSBpdCBkb25lIG9ubHkgdXBvbiBndWVzdCBhY3Rpb24gaW4g
dGhpcyBwYXRjaC4gV2hhdCBkbw0KPiB5b3UgdGhpbms/DQoNClRob3VnaCBJIGRpZG7igJl0IHJl
YWxseSBnZXQgdGhlIGNvbmNlcm4gaGVyZSwgdGhlcmUgaXMgYSBzdWdnZXN0aW9uIHRvDQptb3Zl
IHRoZSBtbWFwIGp1c3QgYWZ0ZXIgSU9NTVVfVklPTU1VX0FMTE9DIGFzIGl0IGRvZXNuJ3QNCm5l
ZWQgdG8gYmUgdGllZCB0byBWSU5URiBlbmFibGUuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNjA2MDExMTQyMjEuNDU3OTk1LTEtc2tvbG90aHVtdGhvQG52aWRpYS5j
b20vVC8jbTk3MjI0N2E0NjUyYjA5ZTNkODZkZWY5MjFkOWE4NTUxYjc2MjAzNDENCg0KSWYgd2Ug
ZG8gdGhhdCBpdCB3aWxsIGtlZXAgbWFwcGVkIHVudGlsIFZJT01NVSBpcyBhbGl2ZS4gDQpEb2Vz
IHRoYXQgYWRkcmVzcyB0aGUgY29uY2VybiBhYm92ZT8NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoN
Cg0KDQo=

