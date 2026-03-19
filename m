Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB11075272
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38Kj-00086E-9Z; Thu, 19 Mar 2026 04:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w38Kf-00082d-Uz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:02:18 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w38Kd-0005d2-J6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773907335; x=1805443335;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=f5kytsJfurH/L9AHt1shuQy1c5fpqsRoTHzie75U7j0=;
 b=iCORz5zGmTQKkVABu16o7I6R4uPsno9T+jZvcQVxNdCXfGOfjcvh8mJn
 I0KEM+2GuFGIq6Wbc0Rsf5wY0ZHOzLcapN5CeJkTWzxikgD8pYopsS1EM
 Odsb4BFvyEtqcZhcDnH70zGLY56YpTPqbHFTTkIpO5klpjk7ax/O+HYDY
 1AhhlkR9uaP+0JB8KqeodpnmKrubf3N3lZ8Jl3RwRVhNrNAFxFjrvMdPL
 zWMJOcEzeZNQrjiNrAAzM6KomyZBMB9nKxDICEogNPjIR4uq7617vEW/W
 WxI68xjdAT3z92K7vW1pijQchriJYs/N+nO+OkM/FHIFJVHU+o13Two91 w==;
X-CSE-ConnectionGUID: TPjp00OtRCanMTbTbhzH/g==
X-CSE-MsgGUID: 5pW8cWsoR/agDc1n4srWBg==
IronPort-SDR: 69bbad82_5jvW1qiRjyTu89fK3TEIU6OhV10CwtY0L9Kb4WkdGRAtrJb
 qJvotZRTT54OT6fF5PG7f3AKczY31TdG+whd5Xw==
X-IronPort-AV: E=Sophos;i="6.23,129,1770591600"; d="scan'208";a="47094404"
X-MGA-submission: =?us-ascii?q?MDHOSzQPkTMLkKRvs153eZCrVgyLSRsr9yDNhC?=
 =?us-ascii?q?2rIYAmtKOycV+/MXVeHxuJQJEMwFjNKT+N+ulbs/bO/LEy70vDayWbdb?=
 =?us-ascii?q?U0Msdasl18L3XRZA/ovG6CTHILpt/3Fw6N6zkI0K/SvftpUywa2uMaXN?=
 =?us-ascii?q?Q0auJeI8+oVcN3Nrr2/IBICg=3D=3D?=
Received: from mail-westeuropeazon11010051.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.51])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Mar 2026 09:02:09 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA5mf7TqjRao00yAWb9VBj2xFrgPgkl3AsIR4lYZRqy0mHyijBmkql8fbt5o3NgxD2NnfD5P3ns62pjueYG0vPuhEWpxnAnLqBRUp8GDrGyqZOwxRj7IPRFRME/bwrV47KbT8ATptzmO2hkiOgdRp0vAgRzgmcF/i/AryfCZ/02JQWYbQZsXNz+wNgMbZ5J7AhtfzjsssgXdtJbV1rfgC50DnEGo3Cr88DG36SK/yNA/AAskik0S4Cisw8Ccosni4ULkfuAFrydqbHhYfb4Kl+C2jjl6hrVxe0ucSEceU4sdnvtpERZstG+A2RlbHmBvjLUaoxluZDbJLTgp+eIyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5kytsJfurH/L9AHt1shuQy1c5fpqsRoTHzie75U7j0=;
 b=Oecf8ANdXxyWOYKOT1TAZRI4KzZ31mlF4d9uv3UhsS8w4UwUqlZXNeWyPwSTJu1Di6WbbSoCpftbCdgBp/GfSWaOpoAw/DfJcNj6jQ+wHf9VPwQVL32AHX1oXSlq02j+BwsG8zaG3ZJsghACjiJrS8VuXqIjutS5Ru90Yrf1KgZ3M4SH8RCJc4V2fCsBAENDnTID1Z7bp3ZnG5MfOXDtYzP39ZFCV2CFlgGdLH95PvQMqJEBmFe3e38PddHtdF6SmimCZu8SAp1NrnmGjndMu3/dx/VhcOGQ/SSMpWeOzpHccUYPhWnJjKGhVczLLmuBxtM/8W8HUBSknkcd7zPBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB12076.eurprd07.prod.outlook.com (2603:10a6:102:568::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:02:07 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:02:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
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
Subject: Re: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRucl+8w3w8Tvkaf2W6HYfy4KrW1kwGA
Date: Thu, 19 Mar 2026 08:02:07 +0000
Message-ID: <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
In-Reply-To: <20260306034409.184873-12-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB12076:EE_
x-ms-office365-filtering-correlation-id: 5329c794-3bf4-4629-21a8-08de858dd0cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: utryFEKnNFjHgZKe9l0YObxYxhj1chvglTXDZRDZPy3o9V3EbZzAYYz51JN9TRukH3UJKKeSs87SPhHOUGGua3S0uCrJB1/w+V3h5Edfzkt2u+HYbbDFIIrgIGbothfRlIUNgFQA0XpVvWu8cMl0LvpNdXMxF0aA2MCDchl64lT4B3WfIq66twfbMZvOR2jhWieVOd5Z8Fd6Yoo+6MQjwxvRFkgBqIeoGzrdLgdDoIzsN8e4sIQ8Rss81J7S4q9nRDciXbq0lc1NzbqqKGM7MsSMOnYx7HaQaw1C9XTW/9VY2kuz/OlecUf8WsqJM90oCez66AoDfsWCfvzBU2TcItB3/ablOjBqfr++Xc9oC+Q5ythXc5VI7aHYfpD63MzPd8+qID0gAKmCRos1LAf+wOHhg28uBECJvhJWgZZlk2F4FnM5L7kVwxPmrAXi0oQGlumRc4ZI1nbYrwLs8K//mxDEgDpnapV2hY8SBHbftaLGHyTGBGQ7MyFh/jmAahajN2QaekQR6fQdbuQochmPSB/RNuo/8/o470R4PinA5tcomwfkVxJ4uo/ufYv8Gsyqb8ZpgzQbyQr/zMbKH6U4TvDe2vh5LwRnNv3T1B64qO/7B720jfCgWnXU10crvyKrFuwEjKDlNhbnLJiQ1VAISiMzUAH54Eh0cTSz8SuevC8YWNtnoJE3DJ1EFn0Fak7NodhhI2fMDYReGcyIQz2gkkT+4baP53nmwH/MxB4My+oVFhLnlLauUN1tWvY5HSe1iW8klq7B4sh4oWhhJjgFT6vjXbCAcftvgFHLNLH4oio=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNBeWdUWDhaYjBOTng5TjlnaERKT09DcTRNbVBDRmhNL2FscTVRSEFXV25N?=
 =?utf-8?B?SU8rcWZWUklnRUVYNGhoTDd5WDJXZ2JtL2RFOSt0SDJzSGpkZzdsRnp3bDFz?=
 =?utf-8?B?Z1lWamQ0ZFlVcS90WmJIUmxjTVJDd1djek50MTZJYjhGWjRoaEhteWMwdDJ2?=
 =?utf-8?B?TTlsOUZvd2FOOEQ2YU9jY3dNbWdhV0Jmblp4THVvTGswRUh0YzE1OVpONWJM?=
 =?utf-8?B?VzZpWldOb1l5aDFQQ3dlMUhMYUlnaVhBQkt3SnYrbGNoMjRIdkR3NjZrWEpw?=
 =?utf-8?B?MGxPeTVtZEhtaDNkSE9RRXl0OHFNQ1B1ajJrb24zQm1uZTlCMnlZdm01eCtN?=
 =?utf-8?B?TzdrRFBpQ2t4T2FWaktjeUk5czZWeTJLNHF4ckFhRVJwdGcvTFZhM3QvOUY1?=
 =?utf-8?B?dGVOcE1CTTFrMHE4bFZBMEVoV0krR2NtYUhRNk56dEF6YWwzd0xubFdGcHRS?=
 =?utf-8?B?WkNtS2tGWWttYzlQejZNZkE2c2FVeXV4b1JFcGU3WkU3dVJqZWFkV0RmQnhL?=
 =?utf-8?B?RUlqUW9OZHJBc3VuL3RMY3dOdS9GWk1EUmc5YXZvYm0vRGVMeDhOR2hNN2sv?=
 =?utf-8?B?QjJMQzc0dFdOL1JtcVRLRTYvajBWOE1sMnZRRVB1aXE4SHBUVDhKSFptM0xn?=
 =?utf-8?B?b013T2U2eGUxYkpJUWFXaldhT1FBQ3h0RUtkeFBYN2VCWjZEL0w0MXNURmtR?=
 =?utf-8?B?NkU5MHVtRERvTEpGNTRKZlJhMi8wL29mS3N2Ly9YYmxRUlpMbnJkRkdTMFNW?=
 =?utf-8?B?eXlqZmtHaFljNlBRMTU5VVZyajRTTlZjdE5KekpmU3doc05BOGo0eDNaZXI2?=
 =?utf-8?B?RHNRT2VqR3NveW83S2svekZKNG9qckdvOWpYU2VKUjRNVEZoMkswMDVtdHFi?=
 =?utf-8?B?OHlscnZxeVpxZE5jMXQwRHdMTkE1anRqcG1UVWY4QVlwRE5ZMzZzcG9WTEJm?=
 =?utf-8?B?NmhaMmQxVHpCblBYSlUyNytpeDJjdU1PWVFYZUpXMHN4N050UzVqMGx5d1RT?=
 =?utf-8?B?OHRyUlhlYWVSa3VsMEw3VVl1OEMzTit1YWtXS1lMem1od0lXTFBYWTQ2Sno2?=
 =?utf-8?B?ZXQzcmc0WG9ObHJMSE5FUFhwUVUzQSt2QVNPL1J0YUZ4VDdVZThJM0NnZDJ2?=
 =?utf-8?B?ZDVMd0pkMVYrYVk0OFhaSkdLTlNYNGxodWk3TGk1TWVMdlhGelZISFZ6ZUFK?=
 =?utf-8?B?Ky83SW4xb1BROThXcHpUYW1OT0tDemhEVGZ1T2pvdXVPS1lRNFUzME5OS29y?=
 =?utf-8?B?cVZ6MVZlbkI2bnhoVzRmMlZvWjlacUpvYkg5eFFtdExMMHh6RVRUc2M2TXRj?=
 =?utf-8?B?UkxzN0sxK2VaY0JGSjJUSFNwalZuR2llZTNFTmJIMVoxT0NoaS9sT0dlcGpV?=
 =?utf-8?B?dWdXcXhRYkx2ZXlkbGNGcU1ZOE9TeG5qa000SHVYOTA1RmNMWGJPdW1qak5O?=
 =?utf-8?B?STZnZVpGVWk5d0g0elZ5b1lmMFRCK1FxQVkwMlJ4aXE1L2swTkZ0OVpEaDVH?=
 =?utf-8?B?ancveS9ydWNvUXU3WXNBSUlXSkFnKzQyaXllUi9TcEk2Vmx5Q21hRzlJTGpH?=
 =?utf-8?B?OGZLMForWWswbGxYZXE3aEg5cTM1V3VTaWh0cC9tTTlKbzVjazRreVc1QVBj?=
 =?utf-8?B?aXZXV3V1U21PMGtpM2c3VDdXdUdTeitaQ0tBNXJNa2dra0cyb2h2VmRhaWJL?=
 =?utf-8?B?SmxjZ1QyVGJSQkw1ZHI5azZ1SVhzWUYwUG50YlBXZC9yN3ZvN1NTTVZKMUtM?=
 =?utf-8?B?ZXA5NisxUWI0eU80SzdxMXVubTlkSmE0WWVUcEt6TWFJbys5cFBlLzZVTWRP?=
 =?utf-8?B?TkNIWWZRR3FIWFdnTTNnR0ZoM3RKQy9tTXVpdEhjblV0REM0ZDRuckZoWDRG?=
 =?utf-8?B?bGg5dTZHQllHK29MbVlJMWxoQ0JzTzhDN0UycHRXL1phQWtKM3prazFsRzBz?=
 =?utf-8?B?N21VMlVtVkUrb1QwR3l5MHROdzVqTlg4RXV6aU44cmlmcjBveUlOaEJ6WUgy?=
 =?utf-8?B?KzRNVkFWSTJWY09HWVNvU1NFd1VVNkI5bDlCcWNCZTlEeFFIaTJaRmNWUHF3?=
 =?utf-8?B?dC83OFYyWnVqczJ5TTVIN1RnK0dPOEk4M0FxZ25Jb1BhVFdjNEJyemFNaHJh?=
 =?utf-8?B?OGpPdm5HMWJpNkJwNmhaZnlOaWd5WERER2hSOC9Cc3VVTlgxVEkvNGU2Tkph?=
 =?utf-8?B?SmpFZndzazNSSUJudWR0VXZqTytubWF5TkpPTVBYbDVtN1B6eW04MWRRNVpI?=
 =?utf-8?B?eFpMVlBma2RCOWJOaE1qVTBiREtONEVRU05kNHpnUG9jNllBU0JxNDhtQkF5?=
 =?utf-8?B?cnBmcmhIZDBtWDlHOW9ZSmZsZ0RINEhHaVNVSVBoVVlLM3prSVlzeDNJMW53?=
 =?utf-8?Q?mgMzJYGxnKCsf33QyISQb/9fbaeih2ZroHEfY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E9B65F2127CC4D8D8B3E893EAFFDC8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vgl2lCGTC5veyVASFNMWR4N2YH0FVedK455dt9z0d9/6kgFXT1Cb/JqBHLpFhuWDRCfvSh6AHtQjDR59IDOnHT4EasbE2K0FVtSF/v/WXzy4v+qKOKNYndz88SkLWgGLcWuVojOWrEJSZYA5PXrKLnIgGm9ltcWZWHh3kC66Z4hHLPlZwJmqtgTJvoS+UsMkRVeQUAdVwsB1xH/zIDYIbEIJ46tgrBrNIrZqBljbTtM2+z/NC4Mi7pXx/U7k4nhRqFhvykD5QyBZ+mMl0Zca0behX0xJ+50mo4WZCnPSZDhX/dkVvo8hlCGvyiiEvywXIfDaH+/YxgsGqfXCpIflGA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5329c794-3bf4-4629-21a8-08de858dd0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:02:07.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6k/A/EJ3EnRnGRaC5yn4dzVaxXDpxhBaSosEKeBFiVrkjWER5qWFrpHlPLSI8WzQriU19iUjsQHf14JM1HlF5LdlrOHoqCMuhs89hS4oYoIFzXSudB/J/eJw4OHUS6mn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB12076
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

dnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUgY2FuIGJlIGNhbGxlZCBmcm9tIHZ0ZF9wcmlfcGVy
Zm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1cyB3ZSBjYW4g
Y2FsbCB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsIHVubG9ja2VkLiBJcyB0aGVyZSBh
IHJpc2sgaW4gY2FzZSBvZiBjb25jdXJyZW50IGhvdCBwbHVnZ2luZyBvZiBhbm90aGVyIGRldmlj
ZT8KCmNtZAoKT24gVGh1LCAyMDI2LTAzLTA1IGF0IDIyOjQ0IC0wNTAwLCBaaGVuemhvbmcgRHVh
biB3cm90ZToKPiBJbiBvcmRlciB0byBzdXBwb3J0IFBBU0lELCB3ZSBoYXZlIHN3aXRjaGVkIGZy
b20gbG9vcGluZyB2dGRfYXMgdG8gdnRkX2hpb2QsICAKPiB2dGRfaGlvZCByZXByZXNlbnRzIGhv
c3QgcGFzc3Rocm91Z2ggZGV2aWNlIGFuZCBuZXZlciBkZWZlcmVuY2VkIHdpdGhvdXQgQlFMLiAg
Cj4gU28gd2UgZG9uJ3QgbmVlZCBleHRyYSBpb21tdSBsb2NrIHRvIHByb3RlY3QgaXQuCj4gCj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPFt6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21d
KG1haWx0bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pPiAgCj4gLS0tICAKPiDCoGh3L2kzODYv
aW50ZWxfaW9tbXVfYWNjZWwuaCB8IDE0ICsrKysrKystLS0tLS0tICAKPiDCoGh3L2kzODYvaW50
ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoCB8wqAgNyArKysrLS0tICAKPiDCoGh3L2kzODYvaW50ZWxf
aW9tbXVfYWNjZWwuYyB8wqAgNiArKystLS0gIAo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9hY2NlbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oICAKPiBpbmRleCAx
YWU0NmQ5MjUwLi4zZjFiMTAwMmI4IDEwMDY0NCAgCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9hY2NlbC5oICAKPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggIAo+IEBAIC0y
NCw5ICsyNCw5IEBAIHR5cGVkZWYgc3RydWN0IFZUREFDQ0VMUEFTSURDYWNoZUVudHJ5IHsgIAo+
IMKgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJ
T01NVURldmljZSAqdnRkX2hpb2QsICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yICoqZXJycCk7ICAKPiDCoFZUREhvc3RJT01NVURl
dmljZSAqdnRkX2ZpbmRfaGlvZF9pb21tdWZkKFZUREFkZHJlc3NTcGFjZSAqYXMpOyAgCj4gLXZv
aWQgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzLCB1
aW50MTZfdCBkb21haW5faWQsICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcGFzaWQs
IGh3YWRkciBhZGRyLCAgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IG5wYWdlcywgYm9v
bCBpaCk7ICAKPiArdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsKEludGVsSU9N
TVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lkLCAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50
MzJfdCBwYXNpZCwgaHdhZGRyIGFkZHIsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IG5w
YWdlcywgYm9vbCBpaCk7ICAKPiDCoHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfYWNjZWwoSW50
ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJRENhY2hlSW5mbyAqcGNfaW5mbyk7ICAKPiDCoHZvaWQg
dnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcyk7ICAKPiDCoHZv
aWQgdnRkX2lvbW11X29wc191cGRhdGVfYWNjZWwoUENJSU9NTVVPcHMgKm9wcyk7ICAKPiBAQCAt
NTEsMTAgKzUxLDEwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcHJvcGFnYXRlX2d1ZXN0X3Bh
c2lkKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCAgCj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7ICAK
PiDCoH0gIAo+IMKgICAKPiAtc3RhdGljIGlubGluZSB2b2lkIHZ0ZF9mbHVzaF9ob3N0X3Bpb3Rs
Yl9hbGxfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcywgIAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDE2X3QgZG9tYWluX2lkLCAgCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwYXNpZCwg
aHdhZGRyIGFkZHIsICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVpbnQ2NF90IG5wYWdlcywgYm9vbCBpaCkgIAo+ICtzdGF0aWMgaW5saW5lIHZvaWQg
dnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsICAKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBkb21h
aW5faWQsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBwYXNpZCwgaHdhZGRyIGFkZHIsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpICAKPiDCoHsgIAo+
IMKgfSAgCj4gwqAgIAo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMgIAo+IGluZGV4IGVkZDJiOGYwY2MuLjNlYTViOTJiMzQgMTAwNjQ0
ICAKPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMgIAo+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyAgCj4gQEAgLTMwMTEsMTEgKzMwMTEsMTEgQEAgc3RhdGljIHZvaWQgdnRkX3Bpb3Rs
Yl9wYXNpZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywgIAo+IMKgwqDCoMKgIGluZm8u
ZG9tYWluX2lkID0gZG9tYWluX2lkOyAgCj4gwqDCoMKgwqAgaW5mby5wYXNpZCA9IHBhc2lkOyAg
Cj4gwqAgIAo+ICvCoMKgwqAgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9hY2NlbChzLCBkb21h
aW5faWQsIHBhc2lkLCAwLCAodWludDY0X3QpLTEsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhbHNl
KTsgIAo+IMKgwqDCoMKgIHZ0ZF9pb21tdV9sb2NrKHMpOyAgCj4gwqDCoMKgwqAgZ19oYXNoX3Rh
YmxlX2ZvcmVhY2hfcmVtb3ZlKHMtPmlvdGxiLCB2dGRfaGFzaF9yZW1vdmVfYnlfcGFzaWQsICAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZpbmZvKTsgIAo+IC3CoMKgwqAgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9s
b2NrZWQocywgZG9tYWluX2lkLCBwYXNpZCwgMCwgKHVpbnQ2NF90KS0xLCAgCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmYWxzZSk7ICAKPiDCoMKgwqDCoCB2dGRfaW9tbXVfdW5sb2NrKHMpOyAgCj4gwqAg
IAo+IMKgwqDCoMKgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZp
ZXJzLCBuZXh0KSB7ICAKPiBAQCAtMzA0NSwxMCArMzA0NSwxMSBAQCBzdGF0aWMgdm9pZCB2dGRf
cGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFp
bl9pZCwgIAo+IMKgwqDCoMKgIGluZm8uYWRkciA9IGFkZHI7ICAKPiDCoMKgwqDCoCBpbmZvLm1h
c2sgPSB+KCgxIDw8IGFtKSAtIDEpOyAgCj4gwqAgIAo+ICvCoMKgwqAgdnRkX2ZsdXNoX2hvc3Rf
cGlvdGxiX2FsbF9hY2NlbChzLCBkb21haW5faWQsIHBhc2lkLCBhZGRyLCAxIDw8IGFtLCBpaCk7
ICAKPiArICAKPiDCoMKgwqDCoCB2dGRfaW9tbXVfbG9jayhzKTsgIAo+IMKgwqDCoMKgIGdfaGFz
aF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnRkX2hhc2hfcmVt
b3ZlX2J5X3BhZ2VfcGlvdGxiLCAmaW5mbyk7ICAKPiAtwqDCoMKgIHZ0ZF9mbHVzaF9ob3N0X3Bp
b3RsYl9hbGxfbG9ja2VkKHMsIGRvbWFpbl9pZCwgcGFzaWQsIGFkZHIsIDEgPDwgYW0sIGloKTsg
IAo+IMKgwqDCoMKgIHZ0ZF9pb21tdV91bmxvY2socyk7ICAKPiDCoCAgCj4gwqDCoMKgwqAgdnRk
X2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnkocywgZG9tYWluX2lkLCBhZGRyLCBhbSwgcGFz
aWQpOyAgCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgCj4gaW5kZXggZDdjMWZmNmI3NC4uYWNiMWIxZTIzOCAx
MDA2NDQgIAo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgCj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICAKPiBAQCAtMjMxLDkgKzIzMSw5IEBAIHN0YXRpYyB2
b2lkIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYihWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSAqdnRkX3Bj
ZSwgIAo+IMKgwqDCoMKgIH0gIAo+IMKgfSAgCj4gwqAgIAo+IC12b2lkIHZ0ZF9mbHVzaF9ob3N0
X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lk
LCAgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkLCBod2FkZHIgYWRkciwgIAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpICAKPiArdm9pZCB2
dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2
X3QgZG9tYWluX2lkLCAgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwYXNpZCwgaHdhZGRy
IGFkZHIsICAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IG5wYWdlcywgYm9vbCBpaCkgIAo+
IMKgeyAgCj4gwqDCoMKgwqAgc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxX2ludmFsaWRhdGUgY2Fj
aGVfaW5mbyA9IHsgMCB9OyAgCj4gwqDCoMKgwqAgVlREUElPVExCSW52SW5mbyBwaW90bGJfaW5m
bzsK

