Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B883CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5bP-0001YR-PF; Thu, 21 May 2026 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wQ5bN-0001XV-OL; Thu, 21 May 2026 11:46:26 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wQ5bL-0006Fm-Gv; Thu, 21 May 2026 11:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXrw7NWv6lD1o0lcxoA34xj+XdYD9fulBWiKMXygMcC0/RsODZkSSaRc3eRfWPuEgwLHaJEKfKf5aTQFTWpfAgGP91dgwo6X5OnMk7Ua22069fi7AWtHuC8Dq9VF3jJLrdZZh4OH9TiGg8cKD/jRJvgKdB21Gy5jTxe5rsr8osjume9DHRF7QB3JxMLGpWhUWGCK8i27SQvIPWjjosZKVR7Hc/F8JGbryPsuiRo9ArwbbyeJuJOytrxwPW1lwHR1bwktYmQPNkqGNBqzejxGoqh6U9BN09qa6U2Iy8/a32Tu6l7Qh0jggIpHgsuomUO0Ad5UwkeXPUlPnqfBQuVgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gkLL1tKkiNX5eNWnrCOF4I/5nCUY0ifu5MUnPcqYTc=;
 b=c8xQBJ6vzJHdh9mrIMpeOBAxbmCTTY3e0vB0dssVZd7vhNGMZ6CCTuSbhunjFgpxRbO5CX8Wgz2KtBouakjTOQqh17XRBgpK/zpoW8k0DdgywADRfOvVIMX9YVqorlhu7JkhAVCE0OO7adshakzk2TZbzXgKdhd1EFexI7cZtq8nwHejPHkOVUMLzhwVdMnkrteb2xLyrCDDVIUUwlz8NYEB73+xUcW23rjQxnirSvultF0chwO+B6WPt9hSDxJPcRvxOzkGppHS6bmaigc8j6tP4o/legE3hSV6JbwUQGv7aXCiPAiz8FbL74iT0P4SxvGUnt1JllWyF53+6CbXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gkLL1tKkiNX5eNWnrCOF4I/5nCUY0ifu5MUnPcqYTc=;
 b=RNaUoKRgxuBjquSZIWEgDS3JIbEoFhac3j1L4MVScNVUjijPnK+AOxwTzw9ycq7DrEEsJW2RSLgzxB7Hh7Zv0QlH3l+weYoeGkvuqd3nlcYjlLdNX/t3pqbhiDrlf+IYCAZfELeB2V4rIrtvSvy39KCN5eyTqe5F1Qq1QodZe3Ox+g+fr5Jvi6Ys3LBkt0oH3Nys4wLHbGoPUEJZnZl4Vx3zdNCux7Ov8R58y3Xz2piDxtMEe9hIv6/uz2XUk30iqzSt/R//YF9QhPGEF4qQh6TnHAu+dsVIxEGC3dw0vfLYOdYCfly0Xoce9phkLOWTx1y4u641XCtmrue6pW8jIw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:46:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 15:46:08 +0000
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
Subject: RE: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHc53vX8b5hQLEz8Ei+yyPG8IlkFrYYf/mAgAAU0JA=
Date: Thu, 21 May 2026 15:46:07 +0000
Message-ID: <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-21-skolothumtho@nvidia.com>
 <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
In-Reply-To: <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CYXPR12MB9443:EE_
x-ms-office365-filtering-correlation-id: 7cb98d5e-086e-428d-18ca-08deb750132d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003|11063799006|3023799007|4143699003|6133799003;
x-microsoft-antispam-message-info: Fai/QqfvbzhSdShGERiMwTUvE53kLRrcBtuP3lOjkbd2NMY1zC5bdKPfFcnXc9b7sYv3dTbUtxTpGaJdWweikiGU0N5lRwAfGH76OHUUiW4HN7jMRIu0ftB6Wa6nXr7GtE3Lgzei+zvjMEQq7SxMHU5uOtFslynhNiANTCN4mPQ0HBJjR0huCjgOEu/LqVM3axDBuPyxAoGqZt7IbgjNnQ4i9HvDlPDLo/G9istq+qZCXJffGXewO79vll050cHihUAcAMTVy70Ez32zLk0lHpptmNlUKRgafZPQNZ5zlnifXC8KUc/q8c10hNwQsBquF8WV1aOdr1QWd6wK5+OG9sM/DBv21n9ams6PYtDj0StIJn5BSnKg6yL5sDBYxsCPdw9ZAsKompPL6mlx56LL+kBiYv1AKu9BoS5+lIxeHK//xn1XBRJmei8tkpK86FWf9vMZObhA7u0FeZa7ChD/B2eYltRCJgh2+dYEt+rRtsclR2M4QznatjlwL7nxWWoax3T1hBhTR40rOxDudgeXw9E5ESNHqEsWfkGsbAQ797EgOun8wDPdV179pumz1UBiVHfyUox4lJDDjH0j2QIiessDzByiJ3w2nEV8dCJZ3EdKoOClA6y1D5FkniLbO01vSemtzyfGEnhKJHst1dEIepAD5/2647KC3zyo8jtWdcVTL8llnFD8eFiLLiLvTEpj/VQmxma51Rl254Hs5qSPn7LQ3p6SznfKAW0P+NOCnlMPGftTonkJe3VYwpZrMnfS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(11063799006)(3023799007)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTFGZTNZcTZ6QlRSTGpudVBGdGFPNmpXd0xINXhNekVMUHhrckJjWktndmJo?=
 =?utf-8?B?TnAyM1hYRms2cE9kaDRqdFRKdnVoVG45NUlZLzVaMWJNc2pPY1hXMHFSMHNj?=
 =?utf-8?B?Q291dGJoMCtiUjV5WWM5SitEbDhpdUlrdGFlemdUL09BS3BwZld3eENQM3pU?=
 =?utf-8?B?dFVKaWNCYnVCa0lXQkJCb3ZrcXRKUE5JZmk4T3J6WnE2VXFKZVVLOWxJeGc1?=
 =?utf-8?B?TDRiU3J3YWtERWNuZTRTbWJBVHNSaTYrRnJMZ1JlSTZnR2g1NGdlV3ZSRmNa?=
 =?utf-8?B?OW5lWTN2bXd1MlFhdHdkS25rRzdUZTJvZGNQVHgxVDY1NlAvbkd6Z1N2aXZh?=
 =?utf-8?B?dkx2LzV4Z0g1eEdESDhZdTZ0bUgzemFhejBCdksrNjUzM20yMTlYVEFNNHp3?=
 =?utf-8?B?RTFCRVNHK29raXpxSFp6Ykl6WnEwRTdlUW9iSUJXZXB1N3I1bkdFREdab3Nt?=
 =?utf-8?B?dGt4OXI5eDZrR1YvZURZWGdEQnRXZGtqaVNTb0xLd0FXcFZRa1QzUXFwSWd1?=
 =?utf-8?B?OVd0a21lN2xIMkkyUFZEc3BkNWlMbk1iUWdOem1wRWFSMzdMWVFTMFBkNkVB?=
 =?utf-8?B?eUxnbE42K2JNNEpRMi9OWVBhTG8zMUNXTGttWHY5OVBtTWtKOFFIRVRxVEN5?=
 =?utf-8?B?U0tUU0ZMUTZaakdxWnBIWnU5RDIzRnJOMWVYR0pLaW9JYktFR1J5bSsrNCtQ?=
 =?utf-8?B?WlJnbUpreG9rWnFsbzBWekFBMEFPME5TcG1vcTNLQ28yM3FnZkpQOXFrZ3hB?=
 =?utf-8?B?UmFIQnhDaHVCK2RlSHdZSnBXcVltT2ZuYVd3REx0UTBvT0c1WlNKZnl3NmFN?=
 =?utf-8?B?MlI0aWErcFBObzVyTHNwUjgrSUpMbWdVYnArYkwxaTc1cDVQTytKTWdzUVBX?=
 =?utf-8?B?YzNQRnMremYzRzFiWEtLOXFyTm50WktueWtJaWxmK2VXamlob1RRSWlVd29M?=
 =?utf-8?B?ZEhMU0J3MzhVM2tYS05TVnJxUnJqN01hZzBGMGl6T3Urd1ZxZ3QyOXY5cGU2?=
 =?utf-8?B?a2dSemR1NXNaK2FSdWJvcm5mVlUvZGovb3Y5bnhXaTVpOFB5VU5NOFptakVx?=
 =?utf-8?B?b2Q4NE43dDRDMUw4ajVubWFJdFdtbFRaK01ta0tMZ0x3YXpzWU90VDBHUEp3?=
 =?utf-8?B?dUNsbk13eitkeitIeWh3dTQ2RG93ZzdvbXB0WTBZYm5hOXBaQlpuL2pGMFlr?=
 =?utf-8?B?VFcwNUIzdjljbkRCZE9EYXRVNzNGeEJHYkQ1ZTBaVEN1TnFUR0FEWkI5T3dT?=
 =?utf-8?B?cEhXWTg5RWNXNG5aZXVtL0ZYR29oQndHZVFqaldQcUJranhlL0FyRzBwY2pF?=
 =?utf-8?B?QlVvcElWaXlwZnhKNVF6T3NoWmNPQmJtZktpaHVJSmt3cFpHSncrbEFWMXpR?=
 =?utf-8?B?dzJuRndjMFNSeWVGcmNJYVhGMmpCakVabGhFN3NGZnVtdDJLZC9qUTkvZEp4?=
 =?utf-8?B?aVI4ZjI4UWswTWdmcXM3MjJ2Z1o4NlNLSkhvYmF6MzBzL0w5dFEwOGNUekVw?=
 =?utf-8?B?SlgxczZSc09qZ2lxWUE1cDhBWVByQkcvdFFiamtSTlZ2VWFNMmJrdmw2NU9t?=
 =?utf-8?B?Y2lSUHlTYkxEcXBmNUM2aExVSmdVTkMxaEFNUEszVDlWZ29UTmhxTE4wSm52?=
 =?utf-8?B?bG5uTlphcHRZOXFUMmZrcnZidUVkZVk0d0JJUHhuWnMwbmpxSVJPYVpDdUZm?=
 =?utf-8?B?MmVlYUliZXFnTklIMkN0QXVxYkxoK3pKMjVoQUt3OTJLRkFlRnFBZmJEc3RV?=
 =?utf-8?B?YXhkYnhTWVZiWTZTUHZkMlBqZWoxK1lNSUl4QUxpbEZlTW04YUoxR0JSL2F6?=
 =?utf-8?B?elRoOGdBdi9XelN2VGlCMkFCVDliRm1rVmNrNDJ6bWhIYUVYMFVnQTRkWXdt?=
 =?utf-8?B?NWpTR08zTEsvR1k0YmhHT0Y2MkdFZStZbWJYUCtNQXZmL1QrNGZ3SWt1cU9G?=
 =?utf-8?B?Q1BIV3FxV3g3K3lkWmRjemloRTFIVnd6UUFSQTlHL00wVjlYMnpXdm9rWlI2?=
 =?utf-8?B?OEx3ak5WU3haWWM2MWgybzFlMTI5eCtYTWVpbk1rWkM2OGhodzFRQmxLaUt4?=
 =?utf-8?B?QXIwRlRVQXg4MjlQQWIrN2pWaEttcUNHU3pNcWZyVXZtM3Y4aGg0S2tBZkZx?=
 =?utf-8?B?S3NvOW5jWHNWVmVhc2xJNnA2dmRvYjRKcGNYNCtXUks0VUlzRmUrRFZzQ3hl?=
 =?utf-8?B?OUZhbVJDNEVUeUlPTHBhMTZ4TGNnME9ReXBuaFFvVTFPWTM0K010VTBRdkhn?=
 =?utf-8?B?dTR2aDJ6VWxrckwxRllLTHBMUS84SHFPblQwbDlDZG1VNlJmV0VaMjlkaEZC?=
 =?utf-8?B?TTB4UG9GVi9vdFFkczgrSmJkZjFlZXlqNHQvaEpXd2RtajJ6Q0t2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb98d5e-086e-428d-18ca-08deb750132d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 15:46:07.9660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CB78hVcWxAWM1opGtkKqfcrFJSbyrEiARVQI7Zb//T8zaGM+XSEg2waW5OWh+B+0tUIbw7gp5Jc08k45/RJw3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDIxIE1heSAyMDI2IDE0OjQxDQo+
IFRvOiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFl
bXUtDQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5p
Y29saW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4g
PGphbkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlh
LmNvbT47IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIwLzMy
XSBody9hcm0vdGVncmEyNDEtY21kcXY6IFVzZSBtbWFwJ2QgVklOVEYNCj4gcGFnZTAgYXMgVkNN
RFEgYmFja2luZw0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlu
a3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNS8xOS8y
NiAxMjozNiBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgdGVncmEy
NDFfY21kcXZfdmludGZfcHRyKCkgdG8gcm91dGUgVkNNRFEgUGFnZTAgcmVnaXN0ZXINCj4gPiBh
Y2Nlc3NlcyB0aHJvdWdoIHRoZSBtbWFwJ2QgVklOVEYgcGFnZTAgYmFja2luZyBvbmNlIGEgaGFy
ZHdhcmUNCj4gPiBxdWV1ZSBoYXMgYmVlbiBhbGxvY2F0ZWQuDQo+ID4NCj4gPiBUaGVyZSBhcmUg
dHdvIFFFTVUgdHJhcHBlZCBNTUlPIGFwZXJ0dXJlcyBmb3IgVkNNRFEgUGFnZTAgcmVnaXN0ZXJz
Og0KPiA+DQo+ID4gICAtIERpcmVjdCBWQ01EUSBQYWdlMCBhcGVydHVyZSAob2Zmc2V0IDB4MTAw
MDApDQo+ID4gICAtIFZJTlRGIFBhZ2UwIChvZmZzZXQgMHgzMDAwMCkNCj4gPg0KPiA+IFRoZXNl
IGFyZSBoYXJkd2FyZSBhbGlhc2VzOiB0aGV5IGFkZHJlc3MgdGhlIHNhbWUgdW5kZXJseWluZw0K
PiA+IHJlZ2lzdGVycy4gQSBzdWJzZXF1ZW50IHBhdGNoIG1hcHMgdGhlIFZJTlRGIGFwZXJ0dXJl
IGFzIGENCj4gPiBndWVzdC1kaXJlY3QgUkFNIHJlZ2lvbjsgaW4gdGhpcyBwYXRjaCBib3RoIHJl
bWFpbiBRRU1VLXRyYXBwZWQuDQo+ID4NCj4gPiBWQ01EUSBQYWdlMCBhY2Nlc3NlcyBvcGVyYXRl
IGluIG9uZSBvZiB0d28gbXV0dWFsbHkgZXhjbHVzaXZlIG1vZGVzLA0KPiA+IGRlcGVuZGluZyBv
biB3aGV0aGVyIGEgaGFyZHdhcmUgcXVldWUgKElPTU1VX0hXX1FVRVVFX0FMTE9DKQ0KPiBoYXMN
Cj4gPiBiZWVuIGFsbG9jYXRlZCBmb3IgdGhlIFZDTURROg0KPiA+DQo+ID4gICBQcmUtYWxsb2M6
ICB2aW50Zl9wdHIgaXMgTlVMTC4gQm90aCBhcGVydHVyZXMgdXNlIFFFTVUncyByZWdpc3Rlcg0K
PiBkbyB5b3UgbWVhbiB2aW50Zl9wYWdlMCBpbnN0ZWFkIG9mIHZpbnRmX3B0ci4NCj4gDQo+IHZp
bnRmX3BhZ2UwIGlzIHNldCBvbiBtbWFwLCByaWdodD8gYW5kIG5vdCBvbiBod3F1ZXVlX2FsbG9j
DQoNClllYWguIEkgYWN0dWFsbHkgbWVhbnQgdGhlIHB0ciByZXR1cm5lZCBieSB0ZWdyYTI0MV9j
bWRxdl92aW50Zl9wdHIoKQ0KDQo+IEJlc2lkZXMgcHJlL3Bvc3QtYWxsb2Mgc291bmRzIGEgYml0
IGNvbmZ1c2luZyB0byBtZSBzaW5jZSBpdCBjYW4gbWVhbg0KPiBxdWV1ZV9hbGxvYyBvciBtbWFw
Lg0KPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHZpbnRmX3BhZ2UwIGNhbiBiZSBzZXQgd2hp
bGUgaHdxdWV1ZV9hbGxvYyBoYXMNCj4gbm90IGJlZW4gZG9uZSB5ZXQgYW5kIGNvbnZlcnNlbHks
IGhlbmNlIHRoZSBkb3VibGUgY2hlY2sgYmVsb3c6DQoNClRoZSAiYWxsb2MiIGlzIGluIHJlZmVy
ZW5jZSB0byBhIHZjbWRxIGlzICJhbGxvY2F0ZWQiIHRvIGEgdmludGYuIEkgdGhpbmsgc3BlYw0K
aGFzIHRoYXQgdXNhZ2UuDQoNCkFueXdheSwgSSB3aWxsIG1ha2UgaXQgY2xlYXIuDQoNCj4gDQo+
ICsgICAgaWYgKCFjbWRxdi0+dmNtZHFbaW5kZXhdIHx8ICFjbWRxdi0+dmludGZfcGFnZTApIHsN
Cj4gDQo+IA0KPiA+ICAgICAgICAgICAgICAgY2FjaGUuIEhhcmR3YXJlIGlzIG5vdCB5ZXQgZW5n
YWdlZC4NCj4gPg0KPiA+ICAgUG9zdC1hbGxvYzogdmludGZfcHRyIGlzIHZhbGlkLiBCb3RoIFFF
TVUgdHJhcHBlZCBhcGVydHVyZXMgYWNjZXNzDQo+ID4gICAgICAgICAgICAgICByZWdpc3RlcnMg
ZGlyZWN0bHkgdmlhIHRoZSBtbWFwJ2QgdmludGZfcGFnZTAgcG9pbnRlciwNCj4gPiAgICAgICAg
ICAgICAgIGJ5cGFzc2luZyB0aGUgY2FjaGUuIEhhcmR3YXJlIGlzIHRoZSBzaW5nbGUgc291cmNl
IG9mDQo+ID4gICAgICAgICAgICAgICB0cnV0aC4NCj4gPg0KPiA+IFRoZSBwcmUtdG8tcG9zdC1h
bGxvYyB0cmFuc2l0aW9uIGlzIHRyaWdnZXJlZCBieSB0aGUgSU9NTVVGRCBoYXJkd2FyZQ0KPiBz
byBoZXJlIHlvdSBtZWFuIGFsbG9jIGlzIGh3IHF1ZXVlIGFsbG9jDQo+ID4gcXVldWUgYWxsb2Nh
dGlvbi4gVGhlIHRlZ3JhMjQxX2NtZHF2X3N5bmNfdmNtZHEoKSBjb3BpZXMgYW55IHByZS1hbGxv
Yw0KPiA+IGNhY2hlZCB3cml0ZXMgKENPTlNfSU5EWCwgUFJPRF9JTkRYLCBDT05GSUcsIEdFUlJP
Uk4pIGludG8gdGhlDQo+IG1tYXAnZA0KPiA+IHBhZ2Ugc28gdGhlIGd1ZXN0J3MgdmlldyBzdXJ2
aXZlcyB0aGUgdHJhbnNpdGlvbi4NCj4gPg0KPiA+IENNRFFWIGFjY2VsZXJhdGlvbiBvbmx5IGJl
Y29tZXMgYWN0aXZlIG9uY2UgdGhlIGd1ZXN0IGVuYWJsZXMgVklOVEYNCj4gPiBhbmQgdGhlIGNv
cnJlc3BvbmRpbmcgSFcgUVVFVUUgaXMgYWxsb2NhdGVkIHRocm91Z2ggSU9NTVVGRC4gVW50aWwN
Cj4gPiB0aGVuLCBhbGwgVkNNRFEgYWNjZXNzZXMgYXJlIHNlcnZlZCBmcm9tIHRoZSBlbXVsYXRl
ZCByZWdpc3RlciBjYWNoZQ0KPiA+IHdpdGggbm8gcmVhbCBoYXJkd2FyZSBjb21tYW5kIHByb2Nl
c3NpbmcuIFRoaXMgbWF0Y2hlcyB0aGUgQ01EUVYNCj4gPiBoYXJkd2FyZSBzcGVjaWZpY2F0aW9u
OiBpZiB0aGUgbG9naWNhbCBDTURRIGluZGV4IGRvZXMgbm90IG1hcCB0byBhbnkNCj4gPiBhbGxv
Y2F0ZWQgVmlydHVhbCBDTURRLCAidGhlIGFjY2VzcyBpcyBkcm9wcGVkIHdpdGggbm8gRmF1bHQv
SW50ZXJydXB0Ii4NCj4gDQo+IEkgc3RpbGwgZG9lcyBub3QgcmVhbHkgdW5kZXJzdGFuZCB3aGF0
IHdvdWxkIGJlIHRoZSBwcm9ibGVtIG9mIGRpcmVjdGx5DQo+IG1hcHBpbmcgdGhlIGRpcmVjdCBj
bWRxdiBwYWdlMCB0b28gLSBJIHVuZGVyc3RhbmQgdGhhdCB0aGVvcmV0aWNhbGx5IHRoZQ0KPiBk
aXJlY3QgdmlldyBpcyBsYXJnZXIgdGhhbiB0aGUgVklOVEYgb25lIHRob3VnaCAtLiBJIHN0aWxs
IHRoaW5rIGENCj4gcHJvcGVyIGV4cGxhbmF0aW9uIGlzIG1pc3NlZCBpbiB0aGlzIHBhdGNoIG9m
IDIyLzMyDQo+IA0KPiBBc3N1bWluZyB0aGUgZ3Vlc3QgdHJpZXMgdG8gc2V0IHVwIHNvbWUgdW5t
YXBwZWQgdmNtZHFzIGluIHRoZSBkaXJlY3QNCj4gY21kcXYgcGFnZSBhbmQgdGhpcyBldmVudHVh
bGx5IGVuZHMgdXAgd3JpdGluZyBpbnRvIHRoZSBWSU5URiB2aWV3LCB3aGF0DQo+IHdvdWxkIGhh
cHBlbiBhbmQgaW4gd2hpY2ggdGVybXMgZG9lcyBpdCB2aW9sYXRlIHRoZSBzcGVjPw0KDQpPay4g
TGV0IG1lIHRyeSB0byBleHBsYWluIG15IHVuZGVyc3RhbmRpbmcuDQoNClRoaXMgaXMgbXkgcmF0
aW9uYWxlIGFmdGVyIHJlYWRpbmcgTmljb2xpbidzIGV4cGxhbmF0aW9uIGhlcmUgb24gdGhlDQpS
RkMgd2hlcmUgd2UgaGFkIGJvdGggZGlyZWN0IGFwZXJ0dXJlIGFuZCB2aW50ZiBwYWdlIDAgbWFw
cGVkIHRvIEd1ZXN0IC4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvYVhrVHpS
TTY5NW9UV0ZhREBBc3VyYWRhLU52aWRpYS8NCg0KQ29uc2lkZXIgdGhlIGV4YW1wbGU6IA0KDQpR
RU1VIGFkdmVydGlzZXMgMiBWQ01EUXMgKENNRFFWX05VTV9DTURRX0xPRzI9MSkuDQpHdWVzdCBh
bGxvY2F0ZXMgdmNtZHEwIG9ubHksIGxlYXZlcyB2Y21kcTEgdW5hbGxvY2F0ZWQsIHRoZW4gb24g
dGhlDQpkaXJlY3QgYXBlcnR1cmUgZm9yIHZjbWRxMToNCg0KICB3cml0ZSAweDEwIC0+ICBBX1ZD
TURRMV9QUk9EX0lORFgNCiAgcmVhZCAgICAgQV9WQ01EUTFfUFJPRF9JTkRYDQoNCklmIHdlIGFs
aWFzZWQgdGhlIGRpcmVjdCBhcGVydHVyZSB0byB0aGUgVklOVEYgbW1hcCwgdGhlIHdyaXRlDQp3
b3VsZCBwaHlzaWNhbGx5IGhpdCBWSU5URiBQYWdlIDAgaW4gSFcgYXQgYW4gdW5tYXBwZWQgbG9n
aWNhbA0Kc2xvdC4gQW5kIHRoZSBzcGVjIHNheXMocC4xNzIpOg0KDQoiIElmIG5vIFZpcnR1YWwg
Q01EUSBpcyBtYXBwZWQgdG8gdGhlIEd1ZXN0LCBvciBpZiB0aGUgbG9naWNhbCBDTURRIGluZGV4
IGluIA0KdGhlIFZpcnR1YWwgSW50ZXJmYWNlIGJlaW5nIGFjY2Vzc2VkIGJ5IHRoZSBzb2Z0d2Fy
ZSBkb2VzIG5vdCBtYXAgdG8gYW55IFZpcnR1YWwNCkNNRFEsIHRoZSBhY2Nlc3MgaXMgZHJvcHBl
ZCB3aXRoIG5vIEZhdWx0L0ludGVycnVwdC4iDQoNClNvIGV2ZW4gdGhvdWdoIGd1ZXN0IGlzIHVz
aW5nIHRoZSBkaXJlY3QgYXBlcnR1cmUsIGluIHR1cm4gaXQgZW5kcyB1cA0KYWNjZXNzaW5nIHRo
ZSBjb3JyZXNwb25kaW5nIHZpbmYgcGFnZTAgYW5kIHdvbid0IHNlZSB3aGF0ZXZlciBpdCB3cm90
ZS4NCg0KSSB0aGluayB0aGlzIGNvbnRyYWRpY3RzIHNwZWMgcC4xNzYgd2hlcmUgaXQgc2F5czoN
Cg0KIldoaWxlIHRoZSBzb2Z0d2FyZSBjYW4gcHJvZ3JhbSB0aGUgVmlydHVhbCBDTURRKHMpIGRp
cmVjdGx5IHVzaW5nIHRoZQ0KZGlyZWN0IFZDTURRIGFwZXJ0dXJlIChhbmQgbm90IHRocm91Z2gg
dGhlIFZpcnR1YWwgSW50ZXJmYWNlKSwgaXQgaXMNCnJlcXVpcmVkIHRoYXQgdGhlIFZDTURRIGJl
IGFsbG9jYXRlZCB0byBhIFZpcnR1YWwgIEludGVyZmFjZSBiZWZvcmUgaXQNCmlzIHVzZWQgdG8g
c2VuZCBjb21tYW5kcyB0byB0aGUgU01NVS4iDQoNClNvIHRoZSBzcGVjIGFsbG93cyByZWdpc3Rl
ciBwcm9ncmFtbWluZyB0aHJvdWdoIHRoZSBkaXJlY3QgYXBlcnR1cmUNCndpdGhvdXQgcmVxdWly
aW5nIHRoZSBWQ01EUSB0byBiZSBhbGxvY2F0ZWQgZmlyc3QuDQoNCkBOaWNvbGluOiBkaWQgSSB1
bmRlcnN0YW5kIHlvdXIgZWFybGllciByZWFzb25pbmcgY29ycmVjdGx5IGhlcmU/DQoNClRoYW5r
cywNClNoYW1lZXINCg==

