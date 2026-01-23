Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD6D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 23:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjQdO-0004PY-Ut; Fri, 23 Jan 2026 18:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjQdI-0004Dm-QU; Fri, 23 Jan 2026 18:32:04 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vjQdH-0004UZ-1N; Fri, 23 Jan 2026 18:32:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQEzRcW3Wp8tEmi7No8pl2kEbDq+khmMpnCAVfeVeDhPwMIqCX5qNrdZPFJeSTSQLTWy0F70AyRN3N4FBvV06Wfg7nSo6KwEY8VSahpkcwqCP9W33AdAOB2io3ICXoDQKGvDMOO4+C7Zi/qYNSk2xSYogyb5FLj8GwX4SSm2g+Cm3Kladb09q+c/uTIM+4gg40MsxO1GJbfXA8v4oU7gE+c3QAMSzDxcREGpEB/Po53lIhoSlaWKNwqvS5P66UTPvhSZEoA+KHD7m2rl1PgAwue4pHMAHmt56d8GGOM3osYgZ8L/oyuwPc1wUlR61hbmcIkQt11kOTMyqlqzunGkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D85fDB2Y2S26VX5l3gLiWmm1w6WV2gGSG/mSiQRYECY=;
 b=CLA0O60N2QVaSuS9aHAV+4tAsd8nc8x8fAEMqfeWohGUC6HnhmCoV62eppb0W9gQNHrni8B3j1/1x1YaDHrqbIkCpUgqXPwS669gXlKkJK+AeUqzjiTgGdbhYeZdy3CPZSj8Mr1sYWbKaJmr/ZUaVwpdlH5FuMtMNrofs8o2G6sbDO92zj0DhU0nj9lq/rzBW4KilPYvQ3TcPZl5e84TSffm0GQnSocd1GgEVdgcjX4HPjkQf9QFyFs5a70e0ExOQ6LQuAs4X7YrGQWluYgRDTIEfYpZfifnJhQmDVZOzfFO3erqO+UrJe41AuNYtl97paxWkiB0qUOvP/D/sP0r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D85fDB2Y2S26VX5l3gLiWmm1w6WV2gGSG/mSiQRYECY=;
 b=bX6+c5CU9OQyyv4BdKEhmzEkW91X9PZc9gpWCndJuAzSgq9x5nZYXC9vH8iEFmNJLK2BvbCF5jbsWWF9kBLeJEOS+d0WwRB57V1529aXrGkG7VYMnRwON+x6HhI4TyDp0GOhz7RQFcy8lYk7htQ+REN7fdeiyyPbUIyqHxI2hssNOl7M4TtYFujrnqotLbfPOj43a3jAl8EgJ8muxJmJXKhXYtND2PP+KgnaXKMZVL3AbcBhJ0UHQtU82nBgClgWjdglnVmxdCd/XLOnwC0jUJnMi+liNNTzuKCM2hph+ZcVFujcd/+Zz7F4UVXEc2MjZTemoi+buCapUw5sS6EmAw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 23:31:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 23:31:57 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Eric Auger
 <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin
 Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHciv8RXDVv9+SEiEKA20nh1wOeY7VfZT0AgAA/SYCAAAStgIAAAURAgAAzGICAAAaFgIAABVUAgAARidCAAAXzgIAADu6ggABUuEA=
Date: Fri, 23 Jan 2026 23:31:57 +0000
Message-ID: <CH3PR12MB7548A6F9D8DAF260920B5D1CAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
 <CH3PR12MB75482DA817149816D5CD485EAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_w=+RHygwsSQVvE6XU44d6+hgKy=bqdD08aBM5_xyn=Q@mail.gmail.com>
 <CH3PR12MB75481DCD5A4A890617429C55AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA-jxKnmD=8A8b5Rur0F1+_5w+JHY2yjkZQvD4wbhMwvkw@mail.gmail.com>
 <CH3PR12MB754823CAB18042F434709A58AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB754823CAB18042F434709A58AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB7246:EE_
x-ms-office365-filtering-correlation-id: 21501642-d9c7-46e0-1afd-08de5ad7996d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WUtuRmJKYUNNVGZKVHhHdG1lbWNDTDM5RVhxdjNYZmVpTy9LalhrdHVlZTly?=
 =?utf-8?B?TVEyRGs5eTZZbmhvZk9XVnpXUk9XaWFUZGJzMzhzbGVWK0lwYWFTc2hzUitx?=
 =?utf-8?B?Vk9XZEJsc1k5QmNRUXlsWWs4OG1Iamh1T1pwT1c3YTBqU0poWStVZ3plNTF6?=
 =?utf-8?B?Qldma1haTTQrdXdFUUtHZGxGTkdhd0Z0LzlJT1ljK0pkMVg4ZGdqcWxiN0Zn?=
 =?utf-8?B?RjYwRG0xMkNDdU94ZjFjbVhIVk5tNjVTQkgrcGV0aUxDdHFQdldQbWtIZHRm?=
 =?utf-8?B?ODBtQjZ6VnJrMlBzSkh1SjVJdkxhL3pBNDdDY0NjS2IxVXlHTVZoQzY1STJG?=
 =?utf-8?B?cldCZG9EcDM3cVNCa1NOb0sxaWFjMHQzOVAwY0dGeTdKR1NqdC9UeGJzTURz?=
 =?utf-8?B?VHM0Ym5nQVZ3K1JpcC80TmpoeGFxWnJ5dWE0aWdUUUxnR1k5ZnlpZHlRTWxh?=
 =?utf-8?B?aXQzUlhVWHVBR0FwQ0pZRS9mRkxGRnZrTEtQSXZ2Y0dOc0c5Wm5Ub2lhc1NH?=
 =?utf-8?B?VTNmdUJEZ2pqbGJlL3J4KzAvSDNaL1c3TkZZQXZYQysrTjltWmxSc1VNaHl2?=
 =?utf-8?B?WnpXSkEyanQ0SFFnTDlxM2NtcE4vVTBydDRmTVBoY0FuN0pJSGpJQmRYZVZX?=
 =?utf-8?B?WkQxMHRZWFFBYnpETjhrM1pkUmQ2YjdmaldKZTM1cXdZTXpDajJpVlg2UmY4?=
 =?utf-8?B?QTZkZFFQazQ4bUQxc2krYWhNcEZuSjlCM1JjMlkzV2FnVlNtWmxVV2dobTRp?=
 =?utf-8?B?SlprUU02RFliSTF2QjRRYWc3NFpmalI3NlBCRTNwcVJBQTBKTEhsMjF3Q1hi?=
 =?utf-8?B?YW5MZzh5UjQ4NkRIdHpXRzk3QWg3cXB6dTdXQzg4dXJpZTFUdXlOdXJnUHNN?=
 =?utf-8?B?VVJuSWZLeUJ2dHQ0czZDOURkTmZQT0VuVGlNVm9yclhNNUFUcWJaY2FQY2tx?=
 =?utf-8?B?czBtZG90eXRQNkprL0ZISUlHTFJqampkdUFPR2x1Y3MxcjJtaFVpeXNFZ2RZ?=
 =?utf-8?B?T0paQnFuN3MwdVNIaFQxSndGMXdoNlBCTGpwS2NuQ1lpSk5hYXpKejI0YnJF?=
 =?utf-8?B?cVZHSHRVOWJRbTZIQVhhdWxjMjViN2pSUzd3UmVIK3hTcWR3Y3NPaVZ5Wk50?=
 =?utf-8?B?Y3dYRjQ3UCthU3pwZDhHK2NRU0xWT2wxaVpZMGhSTjkzdWdPVG0vdXFMbGYx?=
 =?utf-8?B?bTFrR3lBQWsybE9XWWxsRzg3VWVNdFJDb09KdXhLVmlJQmR1c1c3RDV1S01M?=
 =?utf-8?B?Ymg4ZEhMclNYczVJdEZKa3NpZXI2VU13QWJkRUgzcnUrY1ZwQi95ZnkxUyth?=
 =?utf-8?B?L3BST2VnTXpibnJtcEtwNnJCU09tUnVnT0hPL3N0Q0lvVmZJeXV5K0pEYUJE?=
 =?utf-8?B?cllqNG9rVmdwMU1uTEQvZkZkWndnaUFRTU1BdDR0VkhxTUJhNWlIeEEzYUlO?=
 =?utf-8?B?Z0g1YkxEeDkweHo5MEZLcUN0NFY2cm5ZMm9JSE9lK05iZVdPalcyK3BXUU5x?=
 =?utf-8?B?Q2VIa1R3L1l5Rjhwc0ozZHhvOHNIdEdYQWd0eFQzRWdUbmJldFdJU094VGNE?=
 =?utf-8?B?a3kwbFdyS3NuSEdJYVlJQkJhWWRaekJ2YWt3anJncHdZMHg4ajNYNWRxZmRV?=
 =?utf-8?B?MXoybEEzQjYya0ZpK3FXRWNBRzRDdzZFRkJGQlg1VkI1c281SUVFMis3bU1v?=
 =?utf-8?B?QWl6MTdsNkhQR25aT2ROSUYrbVRMWjhFb0U4bWJFR0t2NU1sMzQxVXhvOWpr?=
 =?utf-8?B?dWFqS2VUMSt2L1d4K2hYMHhlNEwxRjg2Z3BheWtwNnYybENKb3pYS0FrZTBk?=
 =?utf-8?B?SmVncSs2c092WktUd0NRRkowclk5TFBOZyswdTdiYVZmbHhCRHdNc01uMEZJ?=
 =?utf-8?B?MnpOS01QVG1NbDdNWExyKy9YQ1RlWkRRV2dTTlhvNkJNSW5yeU5nRXRaV1hV?=
 =?utf-8?B?RXdsTFZBb2xaN2NyVGZSUlhGelFtWEhzc25uelVYdUVMR05zK1QyWE1DaHB5?=
 =?utf-8?B?cTNqN2w4aEExd29yY3pIaHIwdjZsa1Q2dnIzV0IzT1duU0ozdDJGZTZrVlly?=
 =?utf-8?B?SkFudGlSNWp0bWtZeDZxUDEzVndTTXBZQmZ5UGtkYWZpWDg4OHI1VVphWTJx?=
 =?utf-8?B?bVJXZFlXN2owQXJ3eU9uNlJTS2RuYWJPQS95NjgxdHd2KzhzWHpEdVdZR2JH?=
 =?utf-8?Q?SYpE8JoL9YKjjTcZOxICaTE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUQvdWNNV2o1djgzeVZscVNNZVprN1Z4enovb2ZnbStvang0dmMxMVBVc0Zw?=
 =?utf-8?B?K1JFak9kL2tHOWJ3YkpFNkZqTEFINzJtc3RYeVdUZjJ3QzJocDF3elJDSFZO?=
 =?utf-8?B?cFhPMjBkRmtoUS9zTTYzTnY3U3czZS92N2dCUGdsTE1uY01zd25aS3g0S3pU?=
 =?utf-8?B?dFd1N2hxSWVkRjd3TmlGVUUzSENEU3V4RS9TYXNDa09MM25NaVVKY2gyVXlJ?=
 =?utf-8?B?NytTUFFnRWIzZ1hRNm9LZVJSd2FzRUpuTlE1SmI3ajY3cWo2MnZRK2s5enB6?=
 =?utf-8?B?bWw0ZVNzRzFjd25zSUlFWHR5Q0FLK09vR0poZ2p3OTkvOG1pNExxN0VtWkZG?=
 =?utf-8?B?b2hIcm1sUXJYNGZCMHh5NkpYVGs2SnpKSVVwdXhaMkhQVFplOUZJQWtxTWVL?=
 =?utf-8?B?YlRxZWZwNkVSVnhiWDFmS3ZENnJKSEdCeTdiNDhmUnFkVWFuR3JzSjlobkNG?=
 =?utf-8?B?OGF2Y2RDSzNrNjd4L2IrY29VQUM5NWQzTDQxS1lQdHR5K1cxSEFBTEJ2UHhT?=
 =?utf-8?B?TmFjMHBFd3dwSnNsSU11dnRpaW8zV08zbHQ2VEhxWmZEaW1sTkVsTmdBOE5I?=
 =?utf-8?B?RjI0WmR0eUJyNDB0ZG8wZkM5ZGpLZ2xHb3B6WmdxR1pLTTZncmNmaHlCWDUr?=
 =?utf-8?B?aVZvUXNoSWpwM2xMcEl4Vm8xcGl5Tm1mRklvazh6RDB3L0I5VklOTGt3S1kr?=
 =?utf-8?B?ZCtiN3lmbCttTHloZVkxRVc0WXd0RmR4M1FHQ1ozWjFVRUhJMDVLQ3JubEdp?=
 =?utf-8?B?UWhHYnp1dFBiKzJ4WnNmNjFPVHBQSjJhaHc0ZzdYekozUzNlNDRkUEU5NG9K?=
 =?utf-8?B?NUNUVVRPWmdoWWl0c3VhcjQ2cENwOG81U0VLN3cyeDh1RWxRK0RJRm5KRzRZ?=
 =?utf-8?B?NDgyZEhSWXQ0a3kvSkpxTklnSU9lekxWYlZQOUxjYXZHOTAycmN1ZzU2NWV4?=
 =?utf-8?B?bm1STEc3TVdQZktFejBlQzU2VnpReUM1M21zN0hIMWRIK2swbnNqVkxjUWox?=
 =?utf-8?B?b0tib3FXUHluU0daMkpXUlZpeFZKZUEzZG5EV0UzaUVpWlN4SnpkSkJvdjRR?=
 =?utf-8?B?SmczMjRkSHhhZWZIVlQ1bVJXeUtyN0lOd0JvWFJDT3I4RzUyaFFLVjQ3Nisr?=
 =?utf-8?B?WUtXUldvcTBsTjFjRCttaC92a3ZDam9YWFVoYjlZTDR5dUc0UkJWNm15U3dM?=
 =?utf-8?B?cjlJOFpFaEJZTUhWWWFWY2JFNDF0MmthYk16YlhhdjYrTnlYd01PVjNxMkJv?=
 =?utf-8?B?dCtLWUhaWXB5MXBoajJTaWY4U0NqVWpSWm1ya2M1WHdIQm9lcmgzZVBxYWtl?=
 =?utf-8?B?MGtVdUk4K1FtcmtHbGZmZzF3M210UG04cHBoNFpCdEtSZ2dWQmRCZ2thQStF?=
 =?utf-8?B?LzhhRTRmeW9WUnZiVEUrdllpR2orL3hweTFnbDV2Nit5cFBqMTdsNkNCQjhH?=
 =?utf-8?B?MGJQekFvM21oOG9PeWYwLy90dExxd3lCRzFiK3BmMFc4SVpZbXBpeWEvTDNE?=
 =?utf-8?B?VC82MTVTWVB4VkhKV3ZENlI0ZFk0WUJBWnpWN3R6dEFPMlg1Y01vekU2Sjkx?=
 =?utf-8?B?YkxrVnRsaWxKdTdBajNnUll1SU1uOVlJOE5zMzlYdnBmbDBIUXVSU0JoZk41?=
 =?utf-8?B?bGpXdjRMd0YxYkpYckJQZTV0Uzk2QzJMSUpVTGJ1Rjd0cmxtM2hWSVo1WEIx?=
 =?utf-8?B?dHhKaUkzWXkyQ2lGb3JVUTFpZ1FOVzVYSzl1Zlh4dWwxL1JCL0FxVVNwN2dr?=
 =?utf-8?B?N2dTbS92a0NLZGJ4RTJ0NDBDSlNDTmk5V3pGYzNOeDc3UFBaYlFaOWFDZlVR?=
 =?utf-8?B?cm91NnU1S3BsWkVhQ0QvTHJKT0svenZSZmVJbWN3S2ZvYUNTbWl3RG02KzMv?=
 =?utf-8?B?WHZFanpjWWc3UTJMZVRNWFhMT3A1MG4raTEvaTVhSUdld2VBM3VlOG91dGx4?=
 =?utf-8?B?VWQ2dU1MMVE1c0YvOTJoNktqaHZDdnVSK2dQa0o5YWt6RmxUeVZzTkE4Unpu?=
 =?utf-8?B?R3VOYkhBVnlsdFNFQWwwNVZiLzdkZXhjY2hmc1N0bzFxOUhRcWdCUEFaSEhq?=
 =?utf-8?B?YklJSnk4eHd0TTgvSFdZZC9mcTZrUVp5N0MyQjN4Z1pJRlJVa3BwcUJYMS9C?=
 =?utf-8?B?YUhCNEEwSlBsaE1UYmtHNk5LUFlSNGhWanNydVhzRlV2WmFpdUF1SUhsWXhy?=
 =?utf-8?B?U2p6ODhmRFFRbjJCS0F1MFRFbE9zVzdUajlBb0RYaWhqY0RzSm9KZ1B0aUNx?=
 =?utf-8?B?aWY1bDJLSU5LTm5NMDJHbFhENDkvRlFrV1lDMW1zYTF3RnZNWDRlUytqakVB?=
 =?utf-8?B?Zm4zMUdMU1oweHlUdmRSaEV5NzFXbmhxSGtueUdyRVBZSkpwR1NDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21501642-d9c7-46e0-1afd-08de5ad7996d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 23:31:57.1025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5G5bALWoIcSCmpGy1DIkrgQF9ZQ5BGYIHbiUHQuIFdoXPiwyLOFsSrHa67CBgi/YU9yL8qn8CftK77/Wt0XLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlciBLb2xvdGh1
bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFNlbnQ6IDIzIEphbnVhcnkgMjAyNiAxODoy
Mw0KPiBUbzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBDYzog
Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgRXJpYyBBdWdl
cg0KPiA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsNCj4gYWxleEBzaGF6Ym90Lm9yZzsgTmF0
aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8bW9jaHNAbnZpZGlh
LmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBq
aWFuZ2t1bmt1bkBodWF3ZWkuY29tOyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gemhlbnpo
b25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUN
Cj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjggMDAvMzddIGh3
L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVhdGFibGUNCj4gYWNjZWxlcmF0ZWQg
U01NVXYzDQo+IA0KPiANCiANCj4gVGhhbmtzIFBldGVyLCBhbmQgYXBwcmVjaWF0ZSB0aGUgcGF0
aWVuY2UgYW5kIHBvaW50ZXJzLg0KDQpPay4gSSBtYW5nZWQgdG8gdHJpZ2dlciB0aGUgQ0kgam9i
cy4NCiANCj4gSSBkZWxldGVkIHRoZSBlYXJsaWVyIGZvcmtzIGFuZCBjcmVhdGVkIGEgZnJlc2gg
b25lIGRpcmVjdGx5DQo+IGZyb20gdXBzdHJlYW0gUUVNVS4gSSBjbG9uZWQgaXQgbG9jYWxseSBh
bmQgY3JlYXRlZCBhIGJyYW5jaA0KPiB3aXRoIHRoZSBhY2NlbCBwYXRjaGVzLCBhbmQ6DQo+IA0K
PiBnaXQgcHVzaCAtbyBjaS52YXJpYWJsZT0iUUVNVV9DST0yIiBvcmlnaW4gbWFzdGVyLXNtbXV2
My1hY2NlbC12OA0KPiANCj4gSSB0cmllZCBRRU1VX0NJPTEgYXMgd2VsbC4NCj4gDQo+IEhvd2V2
ZXIsIEnigJltIHN0aWxsIG5vdCBzZWVpbmcgYW55IENJIGpvYnMgb3IgcGlwZWxpbmVzIHNob3cg
dXAuDQo+IEkgbWF5IGJlIG1pc3Npbmcgc29tZXRoaW5nIG9idmlvdXMgaGVyZSBhbmQgd2lsbCBo
YXZlIGFub3RoZXINCj4gbG9vayBvdmVyIHRoZSB3ZWVrZW5kIGlmIHBvc3NpYmxlLg0KDQpJIHdh
cyBtaXNzaW5nIHRoZToNCg0KU2V0dGluZ3MgLS0+IENJL0NEIC0tPiBSdW5uZXJzIC0tPiBWYXJp
YWJsZXMgLS0+IE1pbmltdW0gcm9sZSB0byB1c2UNCnBpcGVsaW5lIHZhcmlhYmxlcw0KDQpUaGUg
YWJvdmUgd2FzIHNldCB0byBOb25lLiBDaGFuZ2luZyBpdCB0byAiT3duZXIiIGZpeGVkIHRoZSBp
c3N1ZQ0KYW5kIENJIHN0YXJ0ZWQgd29ya2luZy4NCg0KQW5kIHRvIGNvcHkgdGhlIC90bXAvYW1s
LSogZmlsZSwgY2hhbmdlZDoNCg0KZGlmZiAtLWdpdCBhLy5naXRsYWItY2kuZC9idWlsZHRlc3Qu
eW1sIGIvLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55bWwNCmluZGV4IGU5YjViMDVlNmUuLjczYzVl
MzZlYzMgMTAwNjQ0DQotLS0gYS8uZ2l0bGFiLWNpLmQvYnVpbGR0ZXN0LnltbA0KKysrIGIvLmdp
dGxhYi1jaS5kL2J1aWxkdGVzdC55bWwNCkBAIC0yODgsNiArMjg4LDE0IEBAIGNoZWNrLXN5c3Rl
bS1vcGVuc3VzZToNCiAgIHZhcmlhYmxlczoNCiAgICAgSU1BR0U6IG9wZW5zdXNlLWxlYXANCiAg
ICAgTUFLRV9DSEVDS19BUkdTOiBjaGVjaw0KKyAgYWZ0ZXJfc2NyaXB0Og0KKyAgICAtIG1rZGly
IC1wIGFtbC1kZWJ1Zy1maWxlcw0KKyAgICAtIGNwIC90bXAvYW1sLSogYW1sLWRlYnVnLWZpbGVz
LyB8fCB0cnVlDQorICBhcnRpZmFjdHM6DQorICAgIHdoZW46IGFsd2F5cw0KKyAgICBwYXRoczoN
CisgICAgICAtIGFtbC1kZWJ1Zy1maWxlcy8NCisgICAgZXhwaXJlX2luOiAyIGRheXMNCg0KVGhl
IGdlbmVyYXRlZCBJT1JUIGFuZCB0aGUgSU9SVC5pdHNfb2ZmIHJlZmVyZW5jZSB3ZXJlIGluZGVl
ZCANCmRpZmZlcmVudCwgd2l0aCBBVFMgYW5kIFJNUiBwcmVzZW50LiBJdCBzaG91bGRu4oCZdCBo
YXZlIGVpdGhlciBvZg0KdGhvc2UgYXMgaXQgaXMgdXNpbmcgdGhlIGxlZ2FjeS1zbW11djMuDQoN
ClRoZSBpc3N1ZSB3YXMgbm90IGluaXRpYWxpc2luZyB0aGUgQWNwaUlvcnRTTU1VdjNEZXYgc2Rl
diBpbg0KdmlydC1hY3BpLWJ1aWxkLmMuDQoNCldpdGggdGhlIGJlbG93IGZpeCwNCg0KZGlmZiAt
LWdpdCBhL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYyBiL2h3L2FybS92aXJ0LWFjcGktYnVpbGQu
Yw0KaW5kZXggNjBkOGZkYTc1NS4uOTEyNmFhZTM0NiAxMDA2NDQNCi0tLSBhL2h3L2FybS92aXJ0
LWFjcGktYnVpbGQuYw0KKysrIGIvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jDQpAQCAtMzU2LDcg
KzM1Niw3IEBAIHR5cGVkZWYgc3RydWN0IEFjcGlJb3J0U01NVXYzRGV2IHsNCiBzdGF0aWMgaW50
IHBvcHVsYXRlX3NtbXV2M19sZWdhY3lfZGV2KEdBcnJheSAqc2Rldl9ibG9iKQ0KIHsNCiAgICAg
VmlydE1hY2hpbmVTdGF0ZSAqdm1zID0gVklSVF9NQUNISU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7
DQotICAgIEFjcGlJb3J0U01NVXYzRGV2IHNkZXY7DQorICAgIEFjcGlJb3J0U01NVXYzRGV2IHNk
ZXYgPSB7IDAgfTsNCg0KICAgICBzZGV2LnJjX3NtbXVfaWRtYXBzID0gZ19hcnJheV9uZXcoZmFs
c2UsIHRydWUsIHNpemVvZihBY3BpSW9ydElkTWFwcGluZykpOw0KICAgICBvYmplY3RfY2hpbGRf
Zm9yZWFjaF9yZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksIGlvcnRfaG9zdF9icmlkZ2VzLA0K
QEAgLTM5MSw3ICszOTEsNyBAQCBzdGF0aWMgaW50IGlvcnRfc21tdXYzX2RldmljZXMoT2JqZWN0
ICpvYmosIHZvaWQgKm9wYXF1ZSkNCiAgICAgR0FycmF5ICpzZGV2X2Jsb2IgPSBvcGFxdWU7DQog
ICAgIEFjcGlJb3J0SWRNYXBwaW5nIGlkbWFwOw0KICAgICBQbGF0Zm9ybUJ1c0RldmljZSAqcGJ1
czsNCi0gICAgQWNwaUlvcnRTTU1VdjNEZXYgc2RldjsNCisgICAgQWNwaUlvcnRTTU1VdjNEZXYg
c2RldiA9IHsgMCB9Ow0KICAgICBpbnQgbWluX2J1cywgbWF4X2J1czsNCiAgICAgU3lzQnVzRGV2
aWNlICpzYmRldjsNCiAgICAgUENJQnVzICpidXM7DQoNClRoZSBDSSB0ZXN0IGlzIG5vdyBzdWNj
ZXNzZnVsLg0KLi4uDQogIDEvNDU3IHFlbXU6cXRlc3QrcXRlc3QteDg2XzY0IC8gcXRlc3QteDg2
XzY0L2Jpb3MtdGFibGVzLXRlc3QgICAgICAgICAgICAgIE9LICAgICAgICAgICAgICA4My4zOHMg
ICA1NSBzdWJ0ZXN0cyBwYXNzZWQNCiAgMi80NTcgcWVtdTpxdGVzdCtxdGVzdC1hYXJjaDY0IC8g
cXRlc3QtYWFyY2g2NC9iaW9zLXRhYmxlcy10ZXN0ICAgICAgICAgICAgT0sgICAgICAgICAgICAg
IDg5LjcxcyAgIDE0IHN1YnRlc3RzIHBhc3NlZA0KICAzLzQ1NyBxZW11OnF0ZXN0K3F0ZXN0LXMz
OTB4IC8gcXRlc3QtczM5MHgvcW9tLXRlc3QgICAgICAgICAgICAgICAgICAgICAgICBPSyAgICAg
ICAgICAgICAgIDAuOTBzICAgMyBzdWJ0ZXN0cyBwYXNzZWQNCi4uLg0KDQpJIHdpbGwgcmVzcGlu
IHRoaXMgYXMgdjkuDQoNClRoYW5rcywNClNoYW1lZXINCg0KDQoNCg0K

