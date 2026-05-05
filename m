Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF5CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAge-0006Uu-Rb; Tue, 05 May 2026 03:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKAgd-0006UP-At; Tue, 05 May 2026 03:59:23 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKAgb-0006pU-Ca; Tue, 05 May 2026 03:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bynDZSlo8QCcaHvgu+jbTjrikVx+26WG//ujVZOP1CWcKUdScpCBICeYqtPoWNO357BILP256wTxUfMpNd/+0mXx91Wvb9yucJyp43UpWSW5S3VEJVpTqjYq/ZNxEiuKYV8y0FnhcSKPgdh6IPV8LKcfus6yfK7H/vrCRMLTQxn8nDgYOC2F12IZM7PaVm4W6FkeThURz1vTx39Z3A64nesFFi4zGg5a+88ALSoCLHSzDHfji2cyxOQkVoO2cljIrSOe1+eYZlSARHFOsdHu/oVIRzeRu1ClGN7RG2I4gSHwasUybY6us9hkf8mgVQW/jH7gwgzpi2WgzaImPKGLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBumK/V8+xkTf3o4vbGrmUDUG2FbOFq8E/3TthgRszM=;
 b=H/aMnGnBrDp4QYdFCIYmPvI38Nc6/ZlT0stqCd9ccOOrZQo0dbqNPQ5gIECSCKcX6uBD2SzM4mvoN1Aja3eJcxHZ4Vv8ijRNK+L8oVAn4nrSYUcGiptETeru9g4l/QAS/w59V1Wx1VOZVW/gsMjSfJ/xrGX6Q7Sf6nQ1A/CkpgVTZB2AZE5jz0IQwjMxBANVKgvKZ76Z1khTpq9RFMbNSDecs/xCDn018yOo6RdRvGKwH4KY2nASfKwixV2K/CfP0gjF9akgFLz/dYkmNje8WL4q1qguRaj78PXJgbOoK785kY4xlFXCTMcBgCFL5wLcShSiL/zltAiuSOD2YzhFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBumK/V8+xkTf3o4vbGrmUDUG2FbOFq8E/3TthgRszM=;
 b=hCARXHScGl8OGbDnVmsL/TXJFrfvw9R7Fiu4e7rlcAr5Zhxc9S7KFgcRcwDhA7cGOpAwab2+YP7KlxzJ07U+ZSIvmZ3BUx0GevCpp+jtR69PHd8f98rWdm1MvFg3ut3dY7zwWi5wd7bRw1Qquumag1EXOwxjWCshQaBB/9rN50C8obkhpg5MGrOu2HiRro09AZI6eYeVUcxjzcovlQjPHkem7b9mhh4OK1vSRrbuWzCMIxylj9LtXBAb9pPxS8IcFdL7d730+XYjkjeZ0gqQixqaYjbVtHYtkxE5F4UtA+W3Q7fYC2De116MZYr3ZwcEl/hDk1CfS39Lz8cOL7b7EA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:59:14 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:59:14 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v2 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Thread-Topic: [PATCH v2 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Thread-Index: AQHc0pi5yB156JjTxU6Z/JymncwRc7X+B6+AgAEbGsA=
Date: Tue, 5 May 2026 07:59:14 +0000
Message-ID: <CH3PR12MB754856D3DB7C0DC18EA2224AAB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <9ed5337c-abaf-4f5b-b17e-04dc87165ffa@redhat.com>
In-Reply-To: <9ed5337c-abaf-4f5b-b17e-04dc87165ffa@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8884:EE_
x-ms-office365-filtering-correlation-id: 07866c86-1a88-4086-c234-08deaa7c3329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: WIvsrkng8swEhNYIZcnMb6fdI7x134GJLb+Ua8T9es4jomqo+9PUk+/O9p7lBlRQD32nn3ESX2C9FVvBlQOGAtkUEAWGm3sj6DBOvh3kMTJaDS8IAe1oHMw9JUrff8JrzA73hibVvXcz119m7cJZzU4BFw7YO5sn8eAwl5pda/HXWFYyouIt3sszpHfqM9/WC41L7POOrjkDsVlLpPmdr05E63pobeKCEV23TKEk3HJfACMAkFCp4fv4KEf6a5uzmXFt/0FHDfQt/8n4YEuNHnGK/IEH+qzP+sCtBNFq9D35EHNouUeye72hx/oAu/AMO0yG6JAk0Cj4VPUEkCg5nHMzWiu1AHBvgDfsjTT5d0ekmiz1FtVvV8qP9lRkRSlBQuTCMq8r8fv6+mLOmLQ5bEryLVXthQB8OAM7wfBjiUG8V8/uWyJpkPWge+uCEeTcKaA8LyxmhMQ9zlCJhxz09HO92Wwtdrd7V5qvmu2sYyqEsTa6W0xFW0SrBnGBKjt3gaYmQkWhVY8OmgZwuBn8/vbEBIxPwoCWXm0bzR6w9kOxwPQwIeG8rRYZ+mqZDxI2/kDeIxJs92XfQTTmfJY16X0oS53FBs4hRYJ97C4GcNJUas/A4DYPmdKAjPy7GJ3aT/vmFc8a5zy12I0YM8XQ8JCAPojTHV+35zSs1k1m1mF5uqJa5ktSUI73BrQbIPX7sYtj1rMQPWIiSTLBBApaYmZSWiF6RTqX9/0XQn7HIeOYUjw0uCIUrijIjtmpD4+0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnZjNVBMV0dxaUF6amlWc1VjaGNhYUJWWGVYbEpQNGlqZ1hnZDQ0YUxRWnEy?=
 =?utf-8?B?ZkU2TUtvaUtpUWg3SHkyS1VrOGFmbUMzSjd1NmpCVzhxaElCNENJZ2tqS1A0?=
 =?utf-8?B?VTROVXdSckFTcVZpb1NZcXNidE1ZY2NCM0RMd2VyMFdwamErUkZlWXI0dmxt?=
 =?utf-8?B?WlJYWDhZQnhwTk91UkZtRzI3RUVhVlhEMDFxdk15cVlpRkhFME9NVnBqVE1y?=
 =?utf-8?B?QUVVRnJYSzlLVDBoM3BwRjQvUFA0RkNod2FCZjdYNVNLUW5Kd1VqMUVtNXdh?=
 =?utf-8?B?aUYrQitHUStWc0s5eFJOUTcxMlFUcUpvaktZUGRQRFArM01sLytFVTNXNG5t?=
 =?utf-8?B?K1JWTm41ZGN1eUt6WHcwR2cydjhSUFc5TEx2M1lGbTlCV3lZZlp6NG12VENt?=
 =?utf-8?B?R2NDYitUa29jZ1lMVzFFYk1YTWV5cmNvZkN2eC9wYWpNVjZqd1lSVnB5UG5G?=
 =?utf-8?B?MzRsejFjTFVpdnBmNkd4Q2oyUTJ3ZXp3ald4cVU1VStaK3RTYUdOUFh2Ulg1?=
 =?utf-8?B?aDRXZlJnRFhEUDI3bklXTUVrL2x4bHA3V0FNT3JMSjZiOWpsblgxandjcDJx?=
 =?utf-8?B?cEdETStVcWE4ckk3bDh0bHR5OWhyQmMvZmgvTW9hYWRudWZhT2w4SmZJT0Mz?=
 =?utf-8?B?UlpFbFl6OVpVb2ZTV3dvdUVJSDdza3FqN2pGT2F4aWp5UjVMWVQ2RUFIN0g1?=
 =?utf-8?B?QU4zQWExTHQwaEh3cUt1M1dQZDZqNTJ1T0FDSTNwbVBobHZkTHVIRFU4WE1I?=
 =?utf-8?B?NitUNXg4UTF3d3h6N1hxMDdSUUpOUVhtMzNlek8xeEZxY0dZQXNNaDNXeThi?=
 =?utf-8?B?VUpaSWZvYkRQZlBYMDlZTFRxenQ0RlVJNHJOeVNGakZIMXpEUUlOdUE2UnFx?=
 =?utf-8?B?RVJCVTVVdzEvNVFpbGNOVG1ieVJhemE2UktKZTliSTlmTjJkZDhqcm04U1Na?=
 =?utf-8?B?ckRQMzdGL1cvQyt6SkkxSUVMVlpLM05xSHVUZkpocUgzSFNwTkw3NitmNVZR?=
 =?utf-8?B?TDFsVjYydmxFVmNOc1Fya01XSmVDaEczMW9pZDRRZ3IzamRuUm50SStjOGRz?=
 =?utf-8?B?WUhtZ0dNQ3NtL3RxNGtEMmRkaEtZZi9xcEN6QnhUMHUvQWhqZlJuNWp6cFFQ?=
 =?utf-8?B?MHVHemlzVE84Ry9TMHVIRERxMEFuaHNRUUhVR1ZGaFVUczc2N0ZNdjlYWWFy?=
 =?utf-8?B?Y1NnYUFoL1RmamhNWlk2OHBMRjBCWHEzclVWTWU5VVN6RHlCdmpMMHQ1T0V5?=
 =?utf-8?B?OHB5SjBpMDBtdEV1MXFkY0IvNHp5ZnUyZjM4NHZ1UUxTRzYwczFMQWFrcDVw?=
 =?utf-8?B?ejJzbUdScmw3ZktOS0pPbTNGdkFGQ0xKa2JPeHgzMkRXemM0MkozNzFGZmxJ?=
 =?utf-8?B?cmlvRWpaT1dnWjRYRHRzOUNQQnRvMDFraGtkWVc5dGg1SmdSM3QwY2xLbzRV?=
 =?utf-8?B?RS9SSmlvNVhTTDZKeHkrajd4WkJlalI4ZGxVRk9ScWxnOVlIOXlRTjdwcEFT?=
 =?utf-8?B?SVROcEVqZGgyZHpqWWxBWVRGbGI1REJtaFVqeC9JSEdlMEErY01VK01wZVFa?=
 =?utf-8?B?OWMzZDdrb0lVakM4MHdrV2FmRGtsazdSS2MrL3FiR0xKc0c0L1RNZGZtZE1i?=
 =?utf-8?B?UWZvWEFkRXRiMHdHTm1BZ1pTL3oxcjl5Q0FmaHExODVabjFBZSs3Y2crMXhY?=
 =?utf-8?B?aDFMVUlDRy9paFRvd295V0pCaldKZWJ6L0ovM0d0SktWWmZxQ2hzaDJvYlFD?=
 =?utf-8?B?bHdXQXlpa01LYnhiTnZYN3BUYmo0Ym1CdDY3Q20xakRYUTVZcU9mZkxQeTRu?=
 =?utf-8?B?dlh2K0UzUDJNZVpERU5UQUVFY2FjeXA0LzlLL3IrZmMyMmpreWVFM2pFZm5G?=
 =?utf-8?B?dHhkRVVxTzJPdHBXM3VOcG1sajFlNE9xOHhsSUJHMUx3UFZrR3BYaFF1M1BY?=
 =?utf-8?B?azljZS9tZldHOFU4L2crenlXcDl0Q3Jud0JFbEwwQjNvZnpqZEg3Nnkzbzhz?=
 =?utf-8?B?YVNQcDVKQnVVc3NScXpzaEZ0U2RXcTVHaTE3T2wrYnRZNVNOM0J0Y0t2WnRB?=
 =?utf-8?B?SnFFemVybVM4NEt5OVp0VWZ5ZU5hWkVJaGNQeWtmczhHR0NydlFRTzZ3WHRp?=
 =?utf-8?B?ejEwdVo1a25SRWd2QUdEbDlPS0tJNUx4YUFXa1dYZUU0dUJmZWhyN1ArNTVE?=
 =?utf-8?B?VTVCbkZmY3ZUVWpGY2dWbWdFUUYydXBPUTNEWkNjL2dCRVlJaWNiR2d6RDFF?=
 =?utf-8?B?ZU4yT0dDTGFTTUpZYVJoZkQ1bVNVM0NieHY5UW83NjVJaWIwbk1ZTnVoS3gw?=
 =?utf-8?B?bmZmWCtuckhHRTlJV2xlbTZzZXVKM1hNa0lha2x3eHN3aGxSUDlodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07866c86-1a88-4086-c234-08deaa7c3329
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 07:59:14.3010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFjVvLiMKevTA66GfBnSaj5fJeFPeYgYYT4aaAuD0A21DpliOq+qvepWfDVaP2lrpGBiuYhnYLy1HaghJ2qTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IE1heSAyMDI2IDE1OjU4
DQo+IFRvOiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgcWVtdS1hcm1Abm9uZ251
Lm9yZzsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogRXJpYyBBdWdlciA8ZXJpYy5h
dWdlckByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPjsgTWFyY2VsIEFwZmVsYmF1bQ0KPiA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+OyBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiA8cGhpbG1kQGxpbmFyby5vcmc+OyBZYW5hbiBXYW5n
IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgWmhhbyBMaXUNCj4gPHpoYW8xLmxpdUBpbnRlbC5j
b20+OyBTaGFtZWVyIEtvbG90aHVtIFRob2RpDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47
IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IE5pY29saW4gQ2hlbg0KPiA8bmljb2xpbmNA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIGh3L2FybS9zbW11djMt
YWNjZWw6IFJlc29sdmUgQVVUTyBwcm9wZXJ0aWVzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhlbGxvIE5h
dGhhbiwNCj4gDQo+IE9uIDQvMjIvMjYgMjI6NDMsIE5hdGhhbiBDaGVuIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyBzdXBwb3J0IGZvciByZXNvbHZpbmcg
J2F1dG8nIGZvciBhcm0tc21tdXYzDQo+ID4gYWNjZWxlcmF0ZWQgbW9kZSdzIEFUUywgUklMLCBT
U0lEU0laRSwgYW5kIE9BUyBmZWF0dXJlIHByb3BlcnRpZXMNCj4gPiBiYXNlZCBvbiBob3N0IElP
TU1VIGNhcGFiaWxpdGllcy4gVGhpcyBpcyBkZXBlbmRlbnQgb24gdGhlIHNlcmllcyBbMF0NCj4g
PiBmb3IgY2hhbmdpbmcgdGhlc2UgcHJvcGVydHkgdHlwZXMgdG8gYWNjZXB0ICdhdXRvJyB2YWx1
ZXMuDQo+ID4NCj4gPiBBY2NlbGVyYXRlZCBTTU1VdjMgQWRkcmVzcyBUcmFuc2xhdGlvbiBTZXJ2
aWNlcyBzdXBwb3J0IGlzIGRlcml2ZWQNCj4gPiBmcm9tIElEUjAsIFJhbmdlIEludmFsaWRhdGlv
biBzdXBwb3J0IGlzIGRlcml2ZWQgZnJvbSBJRFIzLCBTdWJzdHJlYW0NCj4gPiBJRCBzaXplIGlz
IGRlcml2ZWQgZnJvbSBJRFIxLCBhbmQgb3V0cHV0IGFkZHJlc3Mgc3BhY2UgaXMgZGVyaXZlZCBm
cm9tDQo+ID4gSURSNS4NCj4gPg0KPiA+IFRoZSBkZWZhdWx0IHZhbHVlcyBhcmUgc2V0IHRvICdh
dXRvJyBmb3IgYWxsIHByb3BlcnRpZXMuIElmIGFjY2VsPW9mZg0KPiA+IGFuZCB0aGUgdmFsdWVz
IGFyZSBzZXQgdG8gJ2F1dG8nIG9yIGFyZSBvbWl0dGVkIGFuZCByZXNvbHZlIHRvICdhdXRvJywN
Cj4gPiB0aGUgZGVmYXVsdCBwcm9wZXJ0eSB2YWx1ZXMgZGVmaW5lZCBpbiBzbW11djNfaW5pdF9p
ZF9yZWdzKCkgZm9yIE9BUw0KPiA+IGFuZCBSSUwgd2lsbCByZW1haW4gdW5jaGFuZ2VkLCB3aGls
ZSBTU0lEU0laRSBhbmQgQVRTIHZhbHVlcyB3aWxsDQo+ID4gcmVtYWluIGluaXRpYWxpemVkIGF0
IDAuDQo+ID4NCj4gPiBBIGNvbXBsZXRlIGJyYW5jaCBjYW4gYmUgZm91bmQgaGVyZToNCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vTmF0aGFuQ2hlbk5WSURJQS9xZW11L3RyZWUvc21tdXYzLWFjY2Vs
LWF1dG8tDQo+IHJlc29sdg0KPiA+IGUtdjINCj4gPg0KPiA+IFBsZWFzZSB0YWtlIGEgbG9vayBh
bmQgbGV0IG1lIGtub3cgeW91ciBmZWVkYmFjay4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBOYXRo
YW4NCj4gPg0KPiA+IFswXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtYXJtLzIw
MjYwMzIzMTgyNDU0LjE0MTYxMTAtMS0NCj4gbmF0aGFuY0BudmlkDQo+ID4gaWEuY29tLw0KPiA+
DQo+ID4gRXhhbXBsZSB1c2FnZToNCj4gPiBxZW11LXN5c3RlbS1hYXJjaDY0IFwNCj4gPiAgICAt
b2JqZWN0IGlvbW11ZmQsaWQ9aW9tbXVmZDAgXA0KPiA+ICAgIC1tYWNoaW5lIHZpcnQsYWNjZWw9
a3ZtLGdpYy12ZXJzaW9uPTMscmFzPW9uLGhpZ2htZW0tbW1pby1zaXplPTRUIFwNCj4gPiAgICAt
Y3B1IGhvc3QgLXNtcCBjcHVzPTQgLW0gc2l6ZT0xNkcgLW5vZ3JhcGhpYyBcDQo+ID4gICAgLW9i
amVjdCBtZW1vcnktYmFja2VuZC1yYW0sc2l6ZT0xNkcsaWQ9bTAgXA0KPiA+ICAgIC1udW1hIG5v
ZGUsbWVtZGV2PW0wLGNwdXM9MC0zLG5vZGVpZD0wIFwNCj4gPiAgICAtbnVtYSBub2RlLG5vZGVp
ZD0xIC1udW1hIG5vZGUsbm9kZWlkPTIgLW51bWEgbm9kZSxub2RlaWQ9MyAtDQo+IG51bWEgbm9k
ZSxub2RlaWQ9NCBcDQo+ID4gICAgLW51bWEgbm9kZSxub2RlaWQ9NSAtbnVtYSBub2RlLG5vZGVp
ZD02IC1udW1hIG5vZGUsbm9kZWlkPTcgLQ0KPiBudW1hIG5vZGUsbm9kZWlkPTggXA0KPiA+ICAg
IC1kZXZpY2UgcHhiLXBjaWUsaWQ9cGNpZS4xLGJ1c19ucj0xLGJ1cz1wY2llLjAsbnVtYV9ub2Rl
PTAgXA0KPiA+ICAgIC1kZXZpY2UgYXJtLXNtbXV2MyxwcmltYXJ5LQ0KPiBidXM9cGNpZS4xLGlk
PXNtbXV2My4xLGFjY2VsPW9uLGF0cz1hdXRvLHNzaWRzaXplPWF1dG8scmlsPWF1dG8sb2FzPWF1
dG8gXA0KPiA+ICAgIC1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpZS5wb3J0MSxidXM9cGNp
ZS4xLGNoYXNzaXM9MSxpby1yZXNlcnZlPTAgXA0KPiA+ICAgIC1kZXZpY2UgdmZpby1wY2ktDQo+
IG5vaG90cGx1Zyxob3N0PTAwMDk6MDY6MDAuMCxidXM9cGNpZS5wb3J0MSxyb21iYXI9MCxpZD1k
ZXYwLGlvbW11ZmQ9aQ0KPiBvbW11ZmQwLGF0cz1hdXRvIFwNCj4gPiAgICAtb2JqZWN0IGFjcGkt
Z2VuZXJpYy1pbml0aWF0b3IsaWQ9Z2kwLHBjaS1kZXY9ZGV2MCxub2RlPTEgXA0KPiA+ICAgIC1v
YmplY3QgYWNwaS1nZW5lcmljLWluaXRpYXRvcixpZD1naTEscGNpLWRldj1kZXYwLG5vZGU9MiBc
DQo+ID4gICAgLW9iamVjdCBhY3BpLWdlbmVyaWMtaW5pdGlhdG9yLGlkPWdpMixwY2ktZGV2PWRl
djAsbm9kZT0zIFwNCj4gPiAgICAtb2JqZWN0IGFjcGktZ2VuZXJpYy1pbml0aWF0b3IsaWQ9Z2kz
LHBjaS1kZXY9ZGV2MCxub2RlPTQgXA0KPiA+ICAgIC1vYmplY3QgYWNwaS1nZW5lcmljLWluaXRp
YXRvcixpZD1naTQscGNpLWRldj1kZXYwLG5vZGU9NSBcDQo+ID4gICAgLW9iamVjdCBhY3BpLWdl
bmVyaWMtaW5pdGlhdG9yLGlkPWdpNSxwY2ktZGV2PWRldjAsbm9kZT02IFwNCj4gPiAgICAtb2Jq
ZWN0IGFjcGktZ2VuZXJpYy1pbml0aWF0b3IsaWQ9Z2k2LHBjaS1kZXY9ZGV2MCxub2RlPTcgXA0K
PiA+ICAgIC1vYmplY3QgYWNwaS1nZW5lcmljLWluaXRpYXRvcixpZD1naTcscGNpLWRldj1kZXYw
LG5vZGU9OCBcDQo+ID4gICAgLWJpb3MgL3Vzci9zaGFyZS9BQVZNRi9BQVZNRl9DT0RFLmZkIFwN
Cj4gPiAgICAtZGV2aWNlIG52bWUsZHJpdmU9bnZtZTAsc2VyaWFsPWRlYWRiZWFmMSxidXM9cGNp
ZS4wIFwNCj4gPiAgICAtZHJpdmUNCj4gZmlsZT0vdmFyL2xpYi9saWJ2aXJ0L2ltYWdlcy9ndWVz
dC5xY293MixpbmRleD0wLG1lZGlhPWRpc2ssZm9ybWF0PXFjb3cyLGlmDQo+ID1ub25lLGlkPW52
bWUwIFwNCj4gPiAgICAtZGV2aWNlIGUxMDAwLHJvbWZpbGU9L3Vzci9sb2NhbC9zaGFyZS9xZW11
L2VmaS0NCj4gZTEwMDAucm9tLG5ldGRldj1uZXQwLGJ1cz1wY2llLjAgXA0KPiA+ICAgIC1uZXRk
ZXYgdXNlcixpZD1uZXQwLGhvc3Rmd2Q9dGNwOjo1NTU4LToyMixob3N0ZndkPXRjcDo6NTU4Ni06
NTU4Ng0KPiA+DQo+ID4gVGVzdGluZzoNCj4gPiBCYXNpYyBzYW5pdHkgdGVzdGluZyB3YXMgcGVy
Zm9ybWVkIG9uIGFuIE5WSURJQSBHcmFjZSBwbGF0Zm9ybSB3aXRoDQo+ID4gR1BVIGRldmljZSBh
c3NpZ25tZW50IGFuZCBydW5uaW5nIENVREEgdGVzdCBhcHBzIG9uIHRoZSBndWVzdC4NCj4gPiBP
YnNlcnZlZCB0aGUgZmVhdHVyZSBwcm9wZXJ0aWVzIGJlaW5nIHNldCBiYXNlZCBvbiBob3N0IElP
TU1VDQo+IGNhcGFiaWxpdGllcy4NCj4gPiBWZXJpZmllZCB0aGF0IHRoZSBWTSBib290IHdpbGwg
ZmFpbCB3aXRob3V0IGEgY29sZC1wbHVnZ2VkIGRldmljZSwgYW5kDQo+ID4gdGhhdCBhIGhvdC1w
bHVnZ2VkIGRldmljZSByZS11c2VzIHRoZSByZXNvbHZlZCB2YWx1ZXMgZnJvbSB0aGUgaW5pdGlh
bA0KPiA+IGNvbGQtcGx1Zy4gQWRkaXRpb25hbCB0ZXN0aW5nIGFuZCBmZWVkYmFjayBhcmUgd2Vs
Y29tZS4NCj4gDQo+IEl0IGlzIGhlbHBmdWwgdG8gaGF2ZSBhIGNoYW5nZWxvZyBiZXR3ZWVuIGRp
ZmZlcmVudCB2ZXJzaW9ucyBvZiB0aGUgc2FtZSBzZXJpZXMNCj4gb2YgcGF0Y2hlcy4NCj4gDQo+
IFNvLCB0aGUgbGludXggaGVhZGVycyBhbmQgdmZpbyB1cGRhdGUgYXJlIG5vdCByZXF1aXJlZCBh
bnltb3JlID8NCg0KSnVzdCBqdW1waW5nIGluIGFzIE5hdGhhbiBpcyBvbiBQVE8uDQoNCk15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgTGludXggaGVhZGVycyBhbmQgVkZJTyB1cGRhdGVzIGFy
ZSBub3QNCmluY2x1ZGVkIGluIHRoaXMgc2VyaWVzIGJlY2F1c2UsIGJhc2VkIG9uIHByZXZpb3Vz
IGZlZWRiYWNrLCB0aGUNCkFUUyByZWxhdGVkIFZGSU8gY2hhbmdlcyB3aWxsIGJlIHNlbnQgYXMg
YW4gaW5kZXBlbmRlbnQgc2VyaWVzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

