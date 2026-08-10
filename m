Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCFCC5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNvw-0000aK-N9; Mon, 10 Aug 2026 07:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtNvt-0000Zc-9m
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 07:12:41 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wtNvr-0005s7-Bi
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1786360359; x=1817896359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ESidhN3hYEZbkFSjXKTXCR9k1WcG6/0Vp/0EZoPR06g=;
 b=QoSgz0JphWKNaYI2GCrKOFmSiMpgCI94ZcFZ2CYI92HUtI8a/gxKf2iR
 0QChRA1U5eNoO2HBpybQiXaN5BJDLMj751CO6mKh8/pJEmKgDsbt0RT+c
 hf2VuO+dTDhPSzy91gmi4VCz0VLnpE5QmkHT+fskHPs/wVDs17LyDtHPe
 A2KP8DfmL/jWGLuWB4DRvReOYF3AEZUnVuHqanK0c/Sr+HvgLEbFioK++
 JnlOfA22ZLpSbsYeEL8L4ad2/GY5xJ94OPmeUtwQCcmzvoJpSnzMp+Wod
 +fSN91z4PlauklZW3ryNVwDdC0MtL/WPWa3+N9lqZHH+a/f9qovHTK2Iu g==;
X-CSE-ConnectionGUID: 38KDd20pRqCPKXmQ7zRatQ==
X-CSE-MsgGUID: hFIEfXGtTrKIme8ZR5RpMA==
IronPort-SDR: 6a79b220_lM9hadlPlTRB6zLF9F+YivXtB7vaqxxFdjZr6ySW/r8EeZc
 rq1bEhBqop3XusfW2wGPtBwqhuXqZTaXS5+c8xw==
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; d="scan'208";a="48578541"
X-MGA-submission: =?us-ascii?q?MDEc1c8GFCa/PUJEP5ptEkcrjgJ9SNdIp9xrka?=
 =?us-ascii?q?eIHbUTsyJeh4mztWRKljtKANwoyWwFM5v94SfXAFmEwd8sIAxt0gQDxd?=
 =?us-ascii?q?v4wNikuBUom/KvpPGifRd7qijuKjoQ8rdkd3DNKnHxozSCcPT7TZlnTY?=
 =?us-ascii?q?J3a40z8n0UtOJkwH+Wtm9uxQ=3D=3D?=
Received: from mail-westeuropeazon11011038.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.38])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Aug 2026 13:12:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0RbGulPYslIXThkQnueFqxv7UCoM4LaElfojYPKZm7Du3M2P5nm8HtMbQXkqV05Qibn3qkSYMMXunOOCMlwVHRjADHHGPJ8s5YGB9fdtMP6F1UO5wFFpYiIoabSNUGG5vS32AHZMKdtiZGkKGZFN7+dTKsLoW3RvYLflGXu32gNXx7IbJjYtXQ50+OUsZNXhYti91d3g+BTLU5dmzxxeIxPqBM7jyQaRrhMot8TmM8Rd59CLoQ1u/kubICoJAyeuUUhbsZMyRVsZfF8cLmg/YQWSTMKXDIioG2QSPDjgDJkoIZgd5tOi2RimitOlOQYUOAMcUO0S8Zv3xf4/BbwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESidhN3hYEZbkFSjXKTXCR9k1WcG6/0Vp/0EZoPR06g=;
 b=Q0vCvRgLNxGX6wZhFrTRo3VGJxKcHColOEU5cg20JEfVIEwLA7uuAuxHYtzqyPiZuI1JiEbucMHWCXxephimHdOR9AjYTJ8RPQCksLYASxQyjnio+U7kEjBEbOdA4k7ApTng4JCg3EKLnWoAcESVzIFYGEKBIuPlM+VSuWKtAKYRMqtceRAWwHqTYW1pFBEi3dbHS3DcVKFHaSPBG/r0RSPUEyN9fnEe91+wUeZOmaIZlTGpW24uXxo91sMF17wozllpBGNN3q0ec2NcfnZGkieoFColgOPV/fW8VbAFeKYhM7tNa3vHazkDYt28lhZW9srR5udWtzTtriCZ2FAE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB11365.eurprd07.prod.outlook.com (2603:10a6:102:554::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 10 Aug
 2026 11:12:29 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0315.008; Mon, 10 Aug 2026
 11:12:29 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaknO6gra3UQkST2flmIiB+OLaUUwKAgALN34CAAAZzAA==
Date: Mon, 10 Aug 2026 11:12:29 +0000
Message-ID: <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB11365:EE_
x-ms-office365-filtering-correlation-id: 1f93ab91-32cd-478a-5dab-08def6d0445b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: eJGkCNIlM5oq+BHIgDHFy5m/QXRO9Ss7CeB3j6YnsJVKwCxnJ8l2mw7Qtp0XqO/bs6iHABpUXUOD6wiOtBgwxTs2Kb7BGG5L7l+FCwxrNja42P5nQB0HB6tiLoo4ciCIaRfOCMsuZ9Iw6SxqwDYF39IkmpFU5bmxJ9FcMzL47hSjyxZ75MlbSowvYLaQ2qYmAOPVI8p+DWpsgOfLmLgQA9UNHtF6rRpl5Lj+sr17mHMd+tEPnM+WIpLZJnDqKgLVocR9ld5QOp9bI1naMXl4Bz3ROfitujxK5cfI3OiiKF18zljgOGYvP1CWzdo4Bf2q2xhRCSTl3Qf7TNoak0nrLY9OSVAVN8KuyvCZzoqBmtEjdyW0hFakLglzMgxu6v6hlaaDCkNHjcBy6FUtl5w4m1Ft1lMTu3fRIKWJrivHBkhbrJpPSxoWA1t3lnAMaNwfvAg+fs2bIrsTh/73UW0CliTV8sbEyJrG6cetLRDePKoSOBx62iMGcPq/VpA9XEeKW3h09q9Iupof01MT+m+a8OAn2iYyMXso9LBHCZKI2cJqsGvdtJicJLW1IxWtKRoTdmHNkUmBQTvGKzTGIwDqMkhnEuqWtIje3wDXpgN403lnhYpvc0uz7G3sAOZJemWL4pSQiSYPURf9PJ9KSW08vNT60ZX6Qb+Q7TjKhPVGl0x6SffyS7ovpU7tgj+5urufvcIAsU3WIfmJrhHN7cmR4eHOxSKvpiXJPZzuvMny4AA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVk1R2xaUUJ6aDJUR3VOSnFBY1E1bjBSc0VYN0NHeU9ha0lHTVpFUXJmVlZv?=
 =?utf-8?B?ZFlxVDdYbGtiMVNvK0J3QzQ2Rk5sTDJBVnJiVU9RK2luWGNobndNSzFpRWpW?=
 =?utf-8?B?a3p3b3ZxUVRnRHpXOGpqcXZ0OVB4am5UNGJBYjJwYkY3ZXF5MlcyNVI2S0JO?=
 =?utf-8?B?RUxnbFVsLytMWmFUbDU2UXRjYWY0YnZKTDVyVWNuRitmVjFKaU1nYzJPTjNM?=
 =?utf-8?B?TE5aVXB6aWNPdzhndFYxNHFtS2dkN2dDc2R1VkltekxOazd4UXFSallVZ3lU?=
 =?utf-8?B?aDNHM1IwZ1RaNjN0cE1JQUJIRXNRYW9nbXkwTHFyRzFyMlB4bkl6dk5sVmp6?=
 =?utf-8?B?ZDNkWnJ2NUxwL2JUT3kzeXZjY21MckwwYkRmdUxiNUpEaFVVMHZMNC9RdlNv?=
 =?utf-8?B?TFEyVEo3alM2OGYwMVRPdjJ1QjV4QitpRHVPSUZZT2lHeEpZT2xNZjZiMWxn?=
 =?utf-8?B?UGV2TTRjYWNVTlU1Ry9XZXcrbVFBQnZMK3dLYUtZSWNiZ051b01LSXhlRXR6?=
 =?utf-8?B?UGZqLzlNVUpSK21HRUZkSUNHUFF3d2ZhcHVxS0t1anJOVitya2tlb25uNGhq?=
 =?utf-8?B?blZvMzVPcjRzSVZuUElPZTNBM0Q2M0dGdGZueEluYzJlUFh4MndWa2FWeHk2?=
 =?utf-8?B?SS83S0JtK1JQT0wrNEorbWtYeHlpd0xMSXlPT2RZSkV6dGlzQjNZZzNoUU12?=
 =?utf-8?B?VlhQdnU1THNkeVZZZ3I5SE42SWE2MHpVZXFMdi9odEZsZU8zME4rS05lS3p1?=
 =?utf-8?B?OWRVUTJ0SUd0Z0krS1FwKzVyeEljNTZOSThKT2ZBOFQxTkFXWXIwTkxubFZN?=
 =?utf-8?B?cERSVFAvQTZlWlVIeXFtR1JndDhVMXF0NWo4ZHNydnA3U09hVHlDNU04OFJ0?=
 =?utf-8?B?SXdMcFBhS3pNMzU2cWtudFRZYllLemJTaXpUY01rZFZCbFhydTRVMFF3SEV1?=
 =?utf-8?B?cDNWSm5jaHR0TWFjVFAwdXJsa3VZM0o3ZTkrS3R5TGUrbTljSjVLcEJyNDJR?=
 =?utf-8?B?NFI1Ni9wK2Y3V0I3Tmcwd3hJcU5KRGovck1VNEFleS9sbVNkYnVLNFlUck1O?=
 =?utf-8?B?cm9KQVdSZlBXL2ZGWU9UT2d0TWFqOC9OYWVKcjhPVENkaHdxclJkRkw0K1hz?=
 =?utf-8?B?dnNNUTRFYzhVRXFLL3ZIaW5rUjFYYjdLcDdYajh1NEFhc2xCZlpBM0RNaUMw?=
 =?utf-8?B?V1ptbEc2TUdTZzUxeC85MVFSRnNPbWJic1hEZ2hxMFpSTGVEeW5aSjRrVm9F?=
 =?utf-8?B?SGsrak1OSCtOTG14L2t2VktFRWhQby95dEcybWRaU3ZoenRKODl2NzBuTjRI?=
 =?utf-8?B?dm5MM3hTNDZVUHloR3pVRkhjV3RmMnU1VVZYTldaRklZNGx1UkQvYVMxaEln?=
 =?utf-8?B?S0F0dzM5VjFSVE11dTMrc2o2ZS9SdzVrTGs3MFZmazBjMURwem9YUENmWUFT?=
 =?utf-8?B?VXNtOHBQeTVCWGk3TkREa2ViU2ZJR2dtbGR4Y0J4dXZteXVJZ1BCZURmWVpt?=
 =?utf-8?B?WjkxOUYvMm9VT0VOOS9PdFBXaldHelU0WjNINVBLMjlabUhaMTJXclluaGtM?=
 =?utf-8?B?T1NDSXVRSHp5STlONUVmZ2VEbEJmZlZuOXJHWm80cDdyblhkdi9idzc2UFhr?=
 =?utf-8?B?TUNJVWdCOGZoMWt5QXRRblBqTkV3T1ZzTjNWTzcvNHc0QWplVmRnaGt0bmFw?=
 =?utf-8?B?REtsYkZlS3FMaXBQalh0VTM1QTFKMFh1dVVpR3d4cC9OUzB5R3VpeDc3ZnhM?=
 =?utf-8?B?ck5jVTlMdUw5UkZ5UnNldHc2NWxqbEo5NzBRQTFMeFVTM2RLbDJJUkFnZnlo?=
 =?utf-8?B?T3BaQnlNWU1lcmwyQno4TW84V2c1QnZRK0k2N2dYQUxqdUlaNVVRcDlZajE1?=
 =?utf-8?B?Ykg3dUFlWVJNclNlQThWZ3k2SXpGdG9sNnZGSGhDR3hLUVFicVNoa3pCM3VK?=
 =?utf-8?B?eWVLbGQvU3VsN1hTVTNzbzdFUVkvSXpPNnJ3MnVkaHVrQW1GU1ZqbkZoUXpP?=
 =?utf-8?B?ZENhMmgyRjFZQk5wVTRDY3FlOVhyMlQzWC9JSXpRdWRsQms5Z3dzVG92VGM3?=
 =?utf-8?B?RkJsNTFsdEJaeENkRUFGL24vQ3dWUldweWw4SGVZbHp4N1FCWng3UWtwZ005?=
 =?utf-8?B?OXgrL2YxcEp5YzVWSzI4NDNtNkl6MUJjQ1RPZWhhVkFXd3paRFZ4dVQ1ZDYw?=
 =?utf-8?B?UWlzdU5SV0lCYUhoMXZUQmRlTlZUZTlSQnFVQzY0a1c4TFp1TnBTbVR0TTBj?=
 =?utf-8?B?U3V1N3N0V3hWNk0xZnI2OUxXdzhXbG0xRmF4WUx2Z2Rka0ZtK0grd09hTTFL?=
 =?utf-8?B?SXB5V01sK3FWVXVQbFNNSnZtMjY4YjZCZ0hiaXNueFNGeWFZcS9ZSnNveGgx?=
 =?utf-8?Q?0Zt9dBCZuypjjGZxv5Dg7lu2z48WRfyNYvYny?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57A37BF35BA73E42A8061E113CADE6C0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YrDAZ/bm5WYACaMv9pvRGLks7q+dm/7Ie+Nxc3Y/TUiIOJUNXwHVyS5OwYkVkDn7yg10LlJBfkrcbq/H9exLjMf9ErxfJUenfYDdAHKfTAQn+OFQtxZ6YFv+sboVxnu1KtDHzqC5/YK0HUQIn8z0AtRNgEaRab+VqFIzefWsiEJMJf13ZfLjs9pKIIaliSEMUe7OhKJO0NJqwvJWEIqIvTjACZmsMt5u7fD/TkWlIPg+ZR/k7WVe94sNgjhDEnJubRztfLC9demZZE/dEt5XYDQLN2/CSIpP7rIEbFrYgtNnLJcpgoV8r1GSIJUOUmVqc8jLKZcRdA5VaUZwS3xYbg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f93ab91-32cd-478a-5dab-08def6d0445b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 11:12:29.3424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WMyvka/8XMJ0+fk7PSRnUNTsoaqMHo9uvdrOHAPK+mw9G3G11nUJWlAcp6GG4S49jzhTSDZ3v/9gAW9v0gy8xOGvDsXw8f2u0O7JGG0fBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11365
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiBNb24sIDIwMjYtMDgtMTAgYXQgMTA6NDkgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9y
IGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEhpIENsZW1lbnQs
DQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENsw6lt
ZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0
bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZvciBwYXNzdGhyb3Vn
aA0KPiA+IGRldmljZQ0KPiA+IA0KPiA+IEhpIFpoZW56aG9uZywNCj4gPiANCj4gPiBJIHdpbGwg
cmVhZCB0aGlzIHNlcmllcyBlYXJseSBuZXh0IHdlZWsuDQo+ID4gdGhhbmtzIGZvciB0aGUgcmVz
cGluIQ0KPiA+IA0KPiA+IGJ0dywgcmVsYXRlZCB0byB0aGlzIHdvcms6IGhhdmUgZXZlciBzZWVu
DQo+ID4gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHMgcmV0dXJuaW5nIDQ3IHdoZXJlYXMNCj4gPiB0
aGUgaW9tbXUgc3VwcG9ydHMgNDg/IFRoaXMgbGVhZHMgdGhlIGZvbGxvd2luZw0KPiA+IGF3IHRl
c3QgdG8gZmFpbDoNCj4gPiANCj4gPiBgYGANCj4gPiByZXQgPSBoaW9kYy0+Z2V0X2NhcChoaW9k
LCBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUywgZXJycCk7DQo+ID4gaWYgKHJldCA8IDAp
IHsNCj4gPiDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiB9DQo+ID4gaWYgKHMtPmF3X2JpdHMgPiBy
ZXQpIHsNCj4gPiDCoMKgIGVycm9yX3NldGcoZXJycCwgImF3LWJpdHMgJWQgPiBob3N0IGF3LWJp
dHMgJWQiLCBzLT5hd19iaXRzLCByZXQpOw0KPiA+IMKgwqAgcmV0dXJuIGZhbHNlOw0KPiA+IH0N
Cj4gPiBgYGANCj4gPiANCj4gPiBJIGdvdCB0aGlzIHdoZW4gdHJ5aW5nIHRvIG5lc3QgVk1zLg0K
PiANCj4gDQo+IEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVjZSwgd2hhdCBkZXZpY2UgZGlkIHlvdSBw
YXNzdGhyb3VnaD8NCg0KSSB1c2VkIGVkdSBmb3IgdGVzdGluZy4gIA0KQW4gSSBoYWQgYXctYml0
cz00OCBvbiBib3RoIHZtcy4gIA0KDQo+IA0KPiBUaGFua3MgIA0KPiBaaGVuemhvbmc=

