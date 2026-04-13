Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82997E9381D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9z4-0003Mt-JB; Mon, 13 Apr 2026 01:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wC9z2-0003Mh-5y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:37:16 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wC9yy-0008TA-RF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 01:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1776058633; x=1807594633;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GfK32NM4/ZFjTVvDgxkJ/1va9oSj/0EJT1DBiR4cb7g=;
 b=pDmFiD7Ss5zwmwAFdMf5+qn5WkflCvnVV8abN00EzgBcuM70XNvyT82z
 e0Z09CjjQFLmRYTD6h18HGfdX5Ljgx0grc4zr0OSYkbEVaWRTV5Lntt88
 uxe8adifuVk+Pt4L1EV76nbb5gcF8ziXLwf+8SDkcvk1QefcF8nVY6fnE
 Nqp7d+z8o5NzeVtHryQhZs0gScoABV0vp0vkxihMiHWhX1osntdO5TBjB
 QQmlfvowCt/2eORkPGVIUKdpILdX1XU74AqCSaDhmmqLa0cUasNGXsEF1
 wj8TX7lIHl6tPz0We0s27MlRC9aOzs080Eq25zJxocaYyZkRTQf36ozpD A==;
X-CSE-ConnectionGUID: pyeNHom8QlOy2Z1DfGENEQ==
X-CSE-MsgGUID: ArMvNRJCQCqatD/Bf3Dy/Q==
IronPort-SDR: 69dc8103_4zKePmhk7yytX839J9r4P67FjrP8iY+gCEnZEufoxUH11ph
 MaN/GoP0Z0ObI8qocVX+D73HBDBQ104+3C1gDHA==
X-IronPort-AV: E=Sophos;i="6.23,176,1770591600"; d="scan'208";a="47491037"
X-MGA-submission: =?us-ascii?q?MDG/WkpyILc3LmaApwzwqAz6HxAmB+klzEzGam?=
 =?us-ascii?q?Z4JHaN8GYNqMgKiUPQmosFzG9fM56DYqDb+IALXKYqNb+t3MDSIs5S4r?=
 =?us-ascii?q?q/eOs6SJcZ+xCb4DSZJBjOs2IURf61Qwan5PM5p1Iwm0m/Be7pVPk/0k?=
 =?us-ascii?q?vLfzPEDdN8QPMmK3T0fDjPTQ=3D=3D?=
Received: from mail-norwayeastazon11013002.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.107.159.2])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Apr 2026 07:37:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzp+eMmm9qP0QDG9g8Rix+TOSgSJNFjFxgzQzBSWuE5S6VK1kCxoYDUIZXX7gJknO4ZzKEDqAfMgXDcjuGDLCvANrapreZflRZleRuE/qQxyyP7Gu4rRQ60G+LbfhFU8ivYztnaT2VaeMseZJgHw97mMwAPFLZY+bxreHpVd/+0q0GlfU4nW/fBPPs8tcspj5zpfdv8MkThbtxmT0KYB/flM6978oEXKtnbYZn6Mt2IDKIfOZfU6qgf6wPTc8zFiIifFWslv8CyUY7QnuODjIPfUk2/aR1bPLaHTfcbqVvdu/nERhMASFDhCoVnse57AlwRBKNy3EnD3eYjVfN3oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfK32NM4/ZFjTVvDgxkJ/1va9oSj/0EJT1DBiR4cb7g=;
 b=UMa3oiBtypRZj2QCg+NwzghAt7BJV9UfNtlroGgyQIYt18xQwv9LJJVn+/oGmlvV0nHtd3jDIdn5d4XTRcAb/6Q0Ak4N8EXNnKRs4Bkw0hTZnpVIPhXS4I9JWUconLKCUVftpGvbXitvt+B3h0TBYzewKoatejVxy15dWL3YtxT3IgDQGSuXc7DCKkDoqUE+oEbhVn+5RhNPZIcGaKA95XgQoP9/3R9i4CVpIcZm/h9b9jRN6u/JwDGsKKkmOcGaxBbxF/UUCgrX6yEVcGJ6gT7PhMfTAQ6RoeGVtKNLgg52XwUtANfnGMnj/wKDl+e13VZhx7b1YlVGX//4U5n4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB11661.eurprd07.prod.outlook.com (2603:10a6:150:304::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:36:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:36:59 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "xudong.hao@intel.com" <xudong.hao@intel.com>
Subject: Re: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHcwx3TPg4rZOcxq0yOJM8k8Tl4SbXciK+A
Date: Mon, 13 Apr 2026 05:36:59 +0000
Message-ID: <ed6326ee98963e263a9bb90d7351c85c4b34562c.camel@bull.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-8-zhenzhong.duan@intel.com>
In-Reply-To: <20260403035541.18355-8-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB11661:EE_
x-ms-office365-filtering-correlation-id: 8bf4c272-c060-41ff-c982-08de991eae98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 3fGpSTeXN7XQOfGBwH99I6srZ72A6VxL074a0m/E1gzS2GkLXOp6g2047CU3lyPsX295qn/F9NyWifSfGI56ziNZS0mNZThRgVP9whHpEJ8kVTXVubQ14+4JR9abexTDqtgNT++BZSQrpXbgOO5T8luvUeXWPwjAqVNaomQvQtE7lEfx4kq01/RXXkAwvWHJPFeoK45qfFK2pu/pxazYtlniI6B9Mep8macshKmQ7+qzTE/cQ9EViAmubFs0Piw3r40RF1WLtGlqqUENCECijOv+iRGOQV55ZvTQwO/IUf+/u0m+V7RZawtFOcxfqLvrsrq3NhGMNw/Dc5MsBXkkt0lhoCyGASnDKgrkUtJyEcEV1YF7RQHRgsRffGRxZJDM7RvGDjCADUkSNjafAF22c2cLBG+N5iNhlbmWZyRpO0SkXQGyI2IRH1KnANOaalbmtbNm1JiUU5Y4egwXyzIUEH0Hh+waxQ/mozFJrxNGVMK+EWc75v5/rUujqfcbL2WiH/3lSHFLsC5TgZXt/epdpv1NytcRsEGGqVWN6hDm7BTHx9nYLTwrE+SYyast7kqY9bOsnFN4pISjhrLzjECBfNhC0lzzxCkYkzgyQrNMBNGvMQi5P924tNVbSU+FhHy0jyCaiU4qkxfaO50lcUOWXtFBTNp3afij3/AKSnxVuyDaq5/GDypSHfghhui5U1N2F1n9pdrrcPf5gMoMmvlwl39aG7L9jsBeqE8CLAfRASWw1GLaX9J5/++GARwn35u16eteRcDKhMNvpqlkmkUPVfr345QVVTsi6ClAGbr1s2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEloK3d3R0EyS2MrdnAzL20vY2JjS1BLc0hCRHdrNFpKWTY1MkVFMUsrT3d0?=
 =?utf-8?B?VFBDZnBCM1hCUlkzZ0hQWHFrWWtlb3NjR2JPY2liblJHcmpBeE55NGlOL3ow?=
 =?utf-8?B?SVBEdmpTVEp5M2Q1OGZpTVF2YmNlQzhKZXF1UmZRdElTdW1ia0tzV3phMjE2?=
 =?utf-8?B?SXk3WGpJQVB1NjhZR01vaUFQbEk0Y1kxZm15ZG5Pd1pUbkNxc0pmalpKN2lP?=
 =?utf-8?B?TDNZNm5icTFoNGdsU2MyRXJQWTJnVHpONTByU2x6UUZ4R3FZcW5UdlVpeWxn?=
 =?utf-8?B?TEJpQVd4M3d1OUgyRmloMlc2Znd5TnJOTmRtSVQxUCtKVkhmRHM3VmJ0T05q?=
 =?utf-8?B?QkJtM1lmWlgvTzhQcEUwcWljRGEzUURrV1NYblNEMUhwcU1xNitod0NjWlFF?=
 =?utf-8?B?Y1h4RW0vYjRXYlVqeFZhdlFIcVdNY3p1WUdrWjYyL2RML2RYZmpuWnZMdFJR?=
 =?utf-8?B?WmpsdzJwbkJlMnFxazhlZ0pzbTZseVNvUTdjUGdjMFZBMUZQR05tNndJdG5J?=
 =?utf-8?B?b1psNDNhcHlTcFR6UzRsUFBzMFFRZ0czajZBMW8xV2hWa3BDZm9RVWdnVFBl?=
 =?utf-8?B?b084d0FiSVA3N3NxbDcvRmlidzU1VmorcFJXSEtxQ3RRSlFuaFFLUm1Xd3ly?=
 =?utf-8?B?RUZRa0NVZ1pwZXFnMVRmOXFUTndqam55am4xbmRHeTYyNktXbWtJRXJ2VlJQ?=
 =?utf-8?B?KzNYVTU5bm9jNkJFeHRuUm9idlhrcUN5VkxlbkNqREIwVDVaR3RGSGs5Ynpm?=
 =?utf-8?B?UndLeEQrUWFEQkNCQlJ2UkRnd1dMYk9FSVBxSUlkNzUxTjJoTStsbUlsWGJH?=
 =?utf-8?B?RTZvbXE3NTV5U3dVOGc2bEhVVjFvV2RRaEtqOEQyQWUxNitaTk5nNXkwRmdJ?=
 =?utf-8?B?N1piM211L2lCdVdBSFVWZmFVMkp3c2toNHJFQTcySHVTdzQyVHRENXVpQlJu?=
 =?utf-8?B?THBOY2VwTFhpMFZva010eUVFUWZoSHVlSk1kUnA4bmFPbFJTemJOalBjeUdT?=
 =?utf-8?B?dXkzWjJBZ1lWUlJ2cDRsS3pGR0orbU05amJuaGkzOFVRMFVaL1kwcXN5bS9z?=
 =?utf-8?B?S21HQjgxREJyKzNPM1pTUUR1Y3pyc3FvNjdGeFh1QnRGS2lmS21rTE4xZThV?=
 =?utf-8?B?ekp3MzhCSHI0UTFTSUVmMHN3OW5NYnh3emZ1T3hNZWllMHk0d2RkcU9YanRa?=
 =?utf-8?B?ejdmOS9oS0tQWHVzbm9EZEpleGRPbnJaVEZaN2hUVGhmczlFb3crOTA3V0NB?=
 =?utf-8?B?ODM0WGdvaWpBSzBkR24zck93ZlduVjhXNDAzQUJXNTZxcTdpOTZDRXlaWGY3?=
 =?utf-8?B?RHlkbThtYTllY0ZHV1hhekRrMWRmT1RYMTY4L3Q1OWM1dmJnYmNxVE9xSmMz?=
 =?utf-8?B?eEVMVTdGdGo2a0ZGTEM2ZUlmc2FsNmlWbklSeGg0NXJXUksvWVEyMjMwbDZz?=
 =?utf-8?B?ZEcvcEFwWE1NblJleWRWd3hGYnU5b1ZnZ1pMT1RKaitSdDZ6L3Z0aTRyQVZL?=
 =?utf-8?B?VGpxRS9yNS9XWEphbGlWVVZVUFBPd1pkM28wWEtxSUx2a1lIZ2svK2djUEM3?=
 =?utf-8?B?UTRRV3paOHhkbDR3QmV0Nmp2TGd6SVhOQ3NxZ0VhUlB1dmpHOHNLMUt6aFpp?=
 =?utf-8?B?QkMyQlBnOWIrQ1h6bm96d1NCMHVxTmJNNk1PcUlFOE05b3p3WFNJTnRMSk1F?=
 =?utf-8?B?UnpOMzEyTWlOM0o1d3JXNytYSFo5KzhLd0l1Ty92WFJ3VDJGcituWWFxVVhY?=
 =?utf-8?B?dzJHVlQ2cUxpYjJXUldZMXU0Mm54OWo0VHlOam90cGRPMVEvbDBUdWVNZWtQ?=
 =?utf-8?B?LzJ3TW5DaFZ6K1hKY1NSNEZKRUJEZ0paa00yOTJWRWNVbnNWTmJqdFREVERR?=
 =?utf-8?B?TnBMSThmZG5jSkF6clV6enBRdEhrTWkzMUNQQ3lZZmI0TWdtYWtjY002eVhB?=
 =?utf-8?B?eC9jMnJ6clZNTSs4Q21oZFFWQnRpMGdld29abFZwMzRvWDVwT25FN0l4ZTl6?=
 =?utf-8?B?ZXZjZ3N4YmNzNTd2SUFaOWlIQXFScXJNemFSSHZOcmM4NVBxL1JmVFhyci9W?=
 =?utf-8?B?UkY3bmRKMHdVbVFLTkhyRFhLYnZybXc2aStpb1o3eU0zcU5lM2pFZGpQSDJT?=
 =?utf-8?B?Z1lsL3IxVEtrMzRmZGtlSWQrekxMdkkzRmI5bUZWMWxkcENzTkhqMW5OdlhF?=
 =?utf-8?B?Nm1FQmhiS3pLdEhjbzhhTWxFVWc5VjhKOGNla2dKRjNsOGpaZU9KaGtMYUo3?=
 =?utf-8?B?RTVQeFIrQ3owN2s3TDVRUFZPRmVQRFFLZklpMyt4NU5xU2xYOGZyM1JRWWRr?=
 =?utf-8?B?OW0wYjhJUll0dWpPZGxsdVhuS3UwUVJiemppQkREMjk2bEx5RnhWWFpEWjFz?=
 =?utf-8?Q?1KMPembTv+leAmsadstqXn6iH3lMN2Fn31xau?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EC3CE4D9ADFAC4192BCEC3C47B6C60D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: axazFJ9K66qddld905NnTHT3T4n3+665KPQJ04iHGR0JTlOXzKbSXosB8x02LKWGwZFxdsT2FwmQ1vFchKT+9uQqSQaMagcTlHStGaIWFCuVEpxztS1SF0+kphLnNAolSu0XTqmy9VMG7nJWaWhRrVxAhscQpHXaEMSNinradIlJ4OvxPKflAG5R6aYNLSwM4LQcDkiiFtQa4wDCjNuBSJWWvR+TF511c9ZZ+IyEb7xF7vcPJoR54z0CiddHSiB/X/JZAAazzmZpanzInUX4WFhe2ZncddWn9dTvW9ZogH/A1XPiHKlVtDRSap3JwbHpRSXeCRXlw3Uj+qxZ5h2iIA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf4c272-c060-41ff-c982-08de991eae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:36:59.0226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lu/sSHfJshvSEzOXD+qFMK3UGciTmfxF2Z3nSyIiRVPV2N1r0fEPnIfVb4b3jxPyOvaC20mZ6Uvab3Ls4VIPaFMZ6E+S4RwijVaP5mou8Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11661
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgWmhlbnpob25nLAoKQ291bGQgeW91IGp1c3QgY2xhcmlmeSBob3cgdGhpcyBpbnRlcnJhY3Rz
IHdpdGggUENJX05PX1BBU0lEPwoKTm8gc3VyZSBJIHVuZGVyc3RhbmQgcHJvcGVybHkgOi8KCk9u
IFRodSwgMjAyNi0wNC0wMiBhdCAyMzo1NSAtMDQwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6Cj4g
SW4gcHJldmlvdXMgcGF0Y2ggd2UgaW50cm9kdWNlZCBhIGdsb2JhbCBtYWNybyBJT01NVV9OT19Q
QVNJRCgwKSBmb3IgIAo+IFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIHRoaXMgbWFrZXMgdGhlIGxv
Y2FsIG1hY3JvIFBBU0lEXzAgcmVkdW5kYW50LiAgCj4gRGVsZXRlIGl0IGFuZCB1c2UgSU9NTVVf
Tk9fUEFTSUQgaW5zdGVhZC4KPiAKPiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8W3lpLmwubGl1QGlu
dGVsLmNvbV0obWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+ICAKPiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbSk+ICAKPiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8gPFt4dWRvbmcuaGFv
QGludGVsLmNvbV0obWFpbHRvOnh1ZG9uZy5oYW9AaW50ZWwuY29tKT4gIAo+IC0tLSAgCj4gwqBo
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfMKgIDEgLSAgCj4gwqBody9pMzg2L2ludGVs
X2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysrKystLS0tLS0tLS0gIAo+IMKg
aHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHzCoCAyICstICAKPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCAgCj4gaW5kZXggYzdlMTA3ZmU4Ny4uMDE0MTMxNmY4MyAxMDA2NDQgIAo+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgCj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oICAKPiBAQCAtNjE1LDcgKzYxNSw2IEBAIHR5cGVkZWYgc3RydWN0
IFZURFJvb3RFbnRyeSBWVERSb290RW50cnk7ICAKPiDCoCNkZWZpbmUgVlREX0NUWF9FTlRSWV9M
RUdBQ1lfU0laRcKgwqDCoMKgIDE2ICAKPiDCoCNkZWZpbmUgVlREX0NUWF9FTlRSWV9TQ0FMQUJM
RV9TSVpFwqDCoCAzMiAgCj4gwqAgIAo+IC0jZGVmaW5lIFBBU0lEXzDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwICAKPiDCoCNkZWZpbmUg
VlREX1NNX0NPTlRFWFRfRU5UUllfUlNWRF9WQUwwKGF3KcKgICgweDFlMFVMTCB8IH5WVERfSEFX
X01BU0soYXcpKSAgCj4gwqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMcKg
wqDCoMKgwqAgMHhmZmZmZmZmZmZmZTAwMDAwVUxMICAKPiDCoCNkZWZpbmUgVlREX1NNX0NPTlRF
WFRfRU5UUllfUFJFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwVUxMICAKPiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAKPiBpbmRl
eCBhYTY3Yzg5ZTczLi4zYjhkM2E5NmQyIDEwMDY0NCAgCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAKPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgIAo+IEBAIC05NDEsNyArOTQx
LDcgQEAgaW50IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLCBWVERD
b250ZXh0RW50cnkgKmNlLCAgCj4gwqDCoMKgwqAgZG1hX2FkZHJfdCBwYXNpZF9kaXJfYmFzZTsg
IAo+IMKgICAKPiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7ICAKPiAtwqDC
oMKgwqDCoMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAgCj4gK8KgwqDCoMKgwqDCoMKgIHBhc2lkID0g
SU9NTVVfTk9fUEFTSUQ7ICAKPiDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFz
ZSA9IFZURF9DRV9HRVRfUEFTSURfRElSX1RBQkxFKGNlKTsgIAo+IMKgwqDCoMKgIHJldHVybiB2
dGRfZ2V0X3BlX2Zyb21fcGFzaWRfdGFibGUocywgcGFzaWRfZGlyX2Jhc2UsIHBhc2lkLCBwZSk7
ICAKPiBAQCAtOTU4LDcgKzk1OCw3IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dldF9wYXNpZF9mcGQo
SW50ZWxJT01NVVN0YXRlICpzLCAgCj4gwqDCoMKgwqAgVlREUEFTSURFbnRyeSBwZTsgIAo+IMKg
ICAKPiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05PX1BBU0lEKSB7ICAKPiAtwqDCoMKgwqDC
oMKgwqAgcGFzaWQgPSBQQVNJRF8wOyAgCj4gK8KgwqDCoMKgwqDCoMKgIHBhc2lkID0gSU9NTVVf
Tk9fUEFTSUQ7ICAKPiDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCBwYXNpZF9kaXJfYmFzZSA9IFZU
RF9DRV9HRVRfUEFTSURfRElSX1RBQkxFKGNlKTsgIAo+IMKgICAKPiBAQCAtMTUwMSw5ICsxNTAx
LDkgQEAgc3RhdGljIGludCB2dGRfY2VfcGFzaWRfMF9jaGVjayhJbnRlbElPTU1VU3RhdGUgKnMs
IFZURENvbnRleHRFbnRyeSAqY2UpICAKPiDCoCAgCj4gwqDCoMKgwqAgLyogIAo+IMKgwqDCoMKg
wqAgKiBNYWtlIHN1cmUgaW4gU2NhbGFibGUgTW9kZSwgYSBwcmVzZW50IGNvbnRleHQgZW50cnkg
IAo+IC3CoMKgwqDCoCAqIGhhcyB2YWxpZCBwYXNpZCBlbnRyeSBzZXR0aW5nIGF0IFBBU0lEXzAu
ICAKPiArwqDCoMKgwqAgKiBoYXMgdmFsaWQgcGFzaWQgZW50cnkgc2V0dGluZyBhdCBJT01NVV9O
T19QQVNJRC4gIAo+IMKgwqDCoMKgwqAgKi8gIAo+IC3CoMKgwqAgcmV0dXJuIHZ0ZF9jZV9nZXRf
cGFzaWRfZW50cnkocywgY2UsICZwZSwgUEFTSURfMCk7ICAKPiArwqDCoMKgIHJldHVybiB2dGRf
Y2VfZ2V0X3Bhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIElPTU1VX05PX1BBU0lEKTsgIAo+IMKgfSAg
Cj4gwqAgIAo+IMKgLyogTWFwIGEgZGV2aWNlIHRvIGl0cyBjb3JyZXNwb25kaW5nIGRvbWFpbiAo
Y29udGV4dC1lbnRyeSkgKi8gIAo+IEBAIC0xNTY0LDcgKzE1NjQsNyBAQCBpbnQgdnRkX2Rldl90
b19jb250ZXh0X2VudHJ5KEludGVsSU9NTVVTdGF0ZSAqcywgdWludDhfdCBidXNfbnVtLCAgCj4g
wqDCoMKgwqDCoMKgwqDCoCB9ICAKPiDCoMKgwqDCoCB9IGVsc2UgeyAgCj4gwqDCoMKgwqDCoMKg
wqDCoCAvKiAgCj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcg
b2YgcGFzaWQgc2V0dGluZyBvZiBQQVNJRF8wICAKPiArwqDCoMKgwqDCoMKgwqDCoCAqIENoZWNr
IGlmIHRoZSBwcm9ncmFtbWluZyBvZiBwYXNpZCBzZXR0aW5nIG9mIElPTU1VX05PX1BBU0lEICAK
PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyB2YWxpZCwgYW5kIHRodXMgYXZvaWRzIHRvIGNoZWNr
IHBhc2lkIGVudHJ5IGZldGNoaW5nICAKPiDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXN1bHQgaW4g
ZnV0dXJlIGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLiAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgICov
ICAKPiBAQCAtMjEyMiw3ICsyMTIyLDcgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5z
bGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsICAKPiDCoMKgwqDCoCB2
dGRfaW9tbXVfbG9jayhzKTsgIAo+IMKgICAKPiDCoMKgwqDCoCBpZiAocGFzaWQgPT0gUENJX05P
X1BBU0lEICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsgIAo+IC3CoMKgwqDCoMKgwqDCoCBwYXNpZCA9
IFBBU0lEXzA7ICAKPiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJT01NVV9OT19QQVNJRDsgIAo+
IMKgwqDCoMKgIH0gIAo+IMKgICAKPiDCoMKgwqDCoCAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZyb20g
SU9UTEIgKi8gIAo+IEBAIC0yNTA4LDEwICsyNTA4LDEwIEBAIHN0YXRpYyB2b2lkIHZ0ZF9pb3Rs
Yl9wYWdlX2ludmFsaWRhdGVfbm90aWZ5KEludGVsSU9NTVVTdGF0ZSAqcywgIAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogSW4gbGVnYWN5IG1vZGUsIHZ0ZF9hcy0+cGFzaWQgPT0gcGFz
aWQgaXMgYWx3YXlzIHRydWUuICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEluIHNj
YWxhYmxlIG1vZGUsIGZvciB2dGQgYWRkcmVzcyBzcGFjZSBiYWNraW5nIGEgUENJICAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRldmljZSB3aXRob3V0IHBhc2lkLCBuZWVkcyB0byBj
b21wYXJlIHBhc2lkIHdpdGggIAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBQQVNJRF8w
IG9mIHRoaXMgZGV2aWNlLiAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIElPTU1VX05P
X1BBU0lEIG9mIHRoaXMgZGV2aWNlLiAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8g
IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoISh2dGRfYXMtPnBhc2lkID09IHBhc2lk
IHx8ICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodnRkX2FzLT5wYXNp
ZCA9PSBQQ0lfTk9fUEFTSUQgJiYgcGFzaWQgPT0gUEFTSURfMCkpKSB7ICAKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodnRkX2FzLT5wYXNpZCA9PSBQQ0lfTk9fUEFTSUQg
JiYgcGFzaWQgPT0gSU9NTVVfTk9fUEFTSUQpKSkgeyAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29udGludWU7ICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSAgCj4g
wqAgIAo+IEBAIC0zMDIyLDcgKzMwMjIsNyBAQCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lk
X2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCAgCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IXZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksICAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYgIAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2
dGRfYXMtPnBhc2lkKSkgeyAgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2dGRfYXMt
PnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSBQQVNJRF8wKSAmJiAgCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKCh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBw
YXNpZCAhPSBJT01NVV9OT19QQVNJRCkgJiYgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOyAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gIAo+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVs
X2lvbW11X2FjY2VsLmMgIAo+IGluZGV4IGJkMTIzNmMwNzAuLjg5NDBkMjQwYTEgMTAwNjQ0ICAK
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgIAo+ICsrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfYWNjZWwuYyAgCj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMgdm9pZCB2dGRf
Zmx1c2hfaG9zdF9waW90bGJfbG9ja2VkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsICAK
PiDCoCAgCj4gwqDCoMKgwqAgZGlkID0gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgmcGNfZW50cnkt
PnBhc2lkX2VudHJ5KTsgIAo+IMKgICAKPiAtwqDCoMKgIGlmIChwaW90bGJfaW5mby0+ZG9tYWlu
X2lkID09IGRpZCAmJiBwaW90bGJfaW5mby0+cGFzaWQgPT0gUEFTSURfMCkgeyAgCj4gK8KgwqDC
oCBpZiAocGlvdGxiX2luZm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lk
ID09IElPTU1VX05PX1BBU0lEKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgIEhvc3RJT01NVURldmlj
ZUlPTU1VRkQgKmhpb2RpID0gIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIT1NUX0lPTU1V
X0RFVklDRV9JT01NVUZEKHZ0ZF9oaW9kLT5oaW9kKTsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgZW50cnlfbnVtID0gMTsgLyogT25seSBpbXBsZW1lbnQgb25lIHJlcXVlc3QgZm9yIHNp
bXBsaWNpdHkgKi8K

