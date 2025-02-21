Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AF5C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4g-0004cw-5o; Fri, 21 Feb 2025 03:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4e-0004cH-U0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:53 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4d-0005ko-1P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125271; x=1771661271;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KHmNcLQuspPA0tQxBlqqLb1prhzBBBLWPp+69jOVVMM=;
 b=c5lqeDybkziVXB/I3UmCmZvTIuFZTLq9G3rmmaccRYZbNcbodwH3IJUq
 +l03qijnq8k0WZneq81eJia8yqspTkEsUfuhgoaP/wJXGH0/zbc8VW65r
 Dg0sOmk/cLqlZpBvgNEBj2nt6isowzfcyTFdEnLAxf4c/G//8HxY/2jD8
 /Y9DraOzrWAbyW0Hf0besEX86FSgVGuVCcD5M6Q6YzSRRD/qYQDKI4T7A
 9tf9FTcFrQRdrYoB2/VzWEruqXs+dGJd6C8u2qHRiE0ITDics/Vun1cRC
 bSNPjxTiWa+CIi5gokInWeFqfZUbZ0uiNXdA3jN1x/9zZKDX3H2ah6cwl g==;
X-CSE-ConnectionGUID: qso0zA+OQKuyZuqL2ktcdQ==
X-CSE-MsgGUID: RCREXZtIRWK8DlF5G6za+Q==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31394149"
X-MGA-submission: =?us-ascii?q?MDHA47w/AYhVxtld6njpZh5njzKU0rDEjVX4aQ?=
 =?us-ascii?q?/HHoeKPxqK7t4TdKvcvu8ekLWWzoiUHk8+CIpbRFW1qkr5sq9bqT1z5f?=
 =?us-ascii?q?fa+AExpJHpEGcJmtzO099RuLfXt6wCi+vFueirYxhEzCkRukSoAOYuY+?=
 =?us-ascii?q?aG+FrmXY+cyKsL42QaMo98ww=3D=3D?=
Received: from mail-vi1eur05lp2170.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.170])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:49 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOA+y09ZwSa3sKm6wrdUdCVrengJCAkzKqDfw/IF5w0beIzyJpsCjKvLDD7wNPyCqGNykP7L1qQjjff1Fj9EjSRSuiY+KK7vvm4oxKSmez1YPbsnIhDfKmmpx5M9D7MAo0pAXKXRgxzgaCSc4SN2aT2fJykkdX0ezX02ZvjH7e/1kcpoEu1QFIoWFereuO5f+Jmj99yqYtMxY+ltabw+8U++RU89IhxXfKZCH/UyZzjwiCoNBT2Iiz8t0bBUtZYU8TUifLmZNgL82OGKtvTI27WDDuq9Qskl/fZlTtsBoxpHvNYeXs/+BpTbG7w5XBDhHli9b7o9zuGYIIO3uyenCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+ubVhNTRgk5dT7AxWnjpgCltzcIrfiIgdWhE8OQaus=;
 b=a26NSut1d52WuWtNqIfRyioNu6Utx5APAMOa9UbHfiSpI+G2tMBHIVEtVhsxsSmAo7vWfFxOZnIQMMiAm0eHZBGFPJLFXKemmSpHVxmq16Sj4T8OLlvxl7HTSmC10YqPg9qgpBX4a1jvJb7F9G5D6unbkOap6e3lClR1uHSG3pfHA3cX0km2LEdQzm1SPG05Cp70ILD0wjUuW4M0tfktebzEkdu8UfRksFGTAoOkpAWLHXf5SoddrNgKdWkVh31JhV82ektz6l4V961HVxOjxAA1+V5iJibRfe0kW2x22v75VFNnlZASVgPxQbgy5g+B1cJuTKiIvrP+TafS76Fy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ubVhNTRgk5dT7AxWnjpgCltzcIrfiIgdWhE8OQaus=;
 b=ILOWf/3khkEhoqATVU1meWgJhdJLSYwyslbvAV8XnEdJlveMoU6kU/PsUQiAmLrYi3nSwDQ69S4SMZBx+49aF2FIh0SmB2PGWuRAjGY3BgRuDzkd+lU7UoDvuOefiAkFsAbtX5esoy3Bx/REDGsVIlDwuC8QGNwOmZbGqjKiMH2TSC5+vHZ29FN9VZv5zwStuKJshu/y2f0bicuH27VYobDEAVp/nnxhE0lH2NBUGyo+9FTsNlcU0YF9QyBQkZlZnSYwCe+XY+VqDmehQSvAxlT38b8TqIydRngwjZBR1eBPWtxCb8CsNZ/I8RYZlJ4hC/1oTIeJs8QDPQSkWL54bw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6459.eurprd07.prod.outlook.com (2603:10a6:10:142::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 08:07:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 19/19] intel_iommu: Add support for ATS
Thread-Topic: [PATCH v3 19/19] intel_iommu: Add support for ATS
Thread-Index: AQHbhDev8G8UVR0uVECvb25nxR+40Q==
Date: Fri, 21 Feb 2025 08:07:44 +0000
Message-ID: <20250221080331.186285-20-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6459:EE_
x-ms-office365-filtering-correlation-id: 69ffb061-887b-403e-2d97-08dd524ed23d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?elngJkPjZgvKvFe+AlC7oFqW0DeE9TGEujveCHzPylBB6iOl9syVDymcQX?=
 =?iso-8859-1?Q?C1vOp2lxLNsvy54Npv6Ns8TAR+WN+Ry+DS4vNLWvi1gpv59H48m3bEobvY?=
 =?iso-8859-1?Q?YuLYWSldDdgfA85GwlMZmlxl7TAASTlyHC5634yZmk8oYKnIgKCVke1u/F?=
 =?iso-8859-1?Q?g+VJLGQTBSLY47OfUqyg/FcUo4xZ6aXeQ1RyJIPUl5iBaXAxn1MRDd0iR6?=
 =?iso-8859-1?Q?L1lfzN0vAlNoEHXrDDSDXtT9HZ+6H0nx9hucE8kXP0Og9dPAr1WfLi15gL?=
 =?iso-8859-1?Q?kMX3Y+YgjqJu6WIAqUMTpN4osI6xYkZZbro/nQFcwI07ZtJepeLNNwXR0u?=
 =?iso-8859-1?Q?2kYK2Lid5Q0QCZ8MRz3htiP9zb4fUBzSiwUCHdby+FhwySnMuG++Qu0ibi?=
 =?iso-8859-1?Q?Yfs+AxvIyqxhYPyaz+BvgfJKnvlCbZhibA/+7f4C5W0jtThEfu29ixmPen?=
 =?iso-8859-1?Q?ePYAyW+nPkQB/K92I9xZhtEJ7hzH91tbWRYTWgW2DbQ2h/Ous6yGRkyctV?=
 =?iso-8859-1?Q?jkKCdxie1qCvOwsntCC70Mfe8M47v7NHUdVpRkiOnCYV7NGZNL3qp1mRAv?=
 =?iso-8859-1?Q?QDD2m/Gk2rYeI0hgs//QRNTYNXHmdmd3PhLAmb2lTQAOk+Fhz1FZwD5uAp?=
 =?iso-8859-1?Q?w2laP0982SUSaJ694ekO8dux6nehym1rOvPMmqeOw50Y6DQcliOceXQHqS?=
 =?iso-8859-1?Q?YELrSzz6onPUNUZ0NjMzWPJ8gzWY7u7TFhwN60ZiBg8x6iFXqzCm3NRm3O?=
 =?iso-8859-1?Q?BpzIUiXG2eMrGSW2upJ2iTWTKus6K6vFf1cc/u9yM1+qDIHNAmxGF+88fM?=
 =?iso-8859-1?Q?BWuLIV26zYr5HGA73rGYstYGjloCaYm874heRDqJ5cJQ1dl/JHcE7o+T4f?=
 =?iso-8859-1?Q?b38xDC15LDDyXtGOIYZSPDwTRiGmG22k+V7vjSpLraNosy3wlP1GraKt48?=
 =?iso-8859-1?Q?YRo49jgPSSQTT2pbH0SEgMmLcZm7HnVP94AnW71Tf/euJo1pu2DZ58rAnf?=
 =?iso-8859-1?Q?G4La2kB81Eew334zL1o9sgZXZZnjHsq2sy6ABTUC02hUEbsQjZ/ety84Fz?=
 =?iso-8859-1?Q?okG9qP/GdEDbI1RWbQMLd2N8jPn2miTNFRso5Aaeqo7AU9fgWuE+Y+2bqu?=
 =?iso-8859-1?Q?alBtEG5FxVuE/ZOh1WYXzZpPHA/ZX3+rXg0uUsTFi18/necBnS3IZHcnx3?=
 =?iso-8859-1?Q?X5UIJHVkJksYNniNx1Ec0e875oQ4COrAjO1dnc0h2y6cACvT+LtrpZuHcw?=
 =?iso-8859-1?Q?uB4GbadsEiUSw4YiRPr2Y9j/EtXHsWnl4JNY0nTjB/wabU5NwIcIRHOZ89?=
 =?iso-8859-1?Q?3Lzqa02fhqQSr0Mi/IfjKFuEVJEketlg3+t/QR64l7QFYeyhGwyuk0l01x?=
 =?iso-8859-1?Q?PrjvcMp0Las/TKQuRdQ7Eb0t+4KmngPWCny08KxNrCpXcnEUojB2tEu1zL?=
 =?iso-8859-1?Q?sIoml/i62AY3+z7FrHCc/LyW/F2HToB/9RkD8KF3lWC7GN+7kiHqj1S+EC?=
 =?iso-8859-1?Q?qs6dumsczXdsO/XQ6r1M0v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JUUmdRD+gv/nJKWQxU5iP74p+CPZI1P1XweYmdvof8rAori2E3u0m/1aBi?=
 =?iso-8859-1?Q?KEYzg6JG3Grr09H5UT5yCLaGlWlAlexUXUgTrI4U3yKDxD4NwsQNPMubCG?=
 =?iso-8859-1?Q?4lZqmYy5tP9mChTr38v1GmY2TJqefjjgkAOu1v3UOUSv2Mtm87b57b5ibc?=
 =?iso-8859-1?Q?lzDrjxAZ/q6cw+RO6aPUEKGcOcUkO3RULW149/QaHeyd/vA1Cum7E6Igy7?=
 =?iso-8859-1?Q?gzvfjeG6Oj8BKPLjleHx4PIMkY289W/FBQh4rL3KIMEtpcygTcbFjEVOG5?=
 =?iso-8859-1?Q?Al7Dgac4dsu8Vt5PezxDUisTBondC03CWlmvVaDCoueIeSE3TN3Ue9QZav?=
 =?iso-8859-1?Q?9p+RkjJDKQowgmA7wqyJ5m/qGAY+JIPedZK7iT2wsW6vavkVJYNr5QUJ7f?=
 =?iso-8859-1?Q?TcoxzjcoXab2XdBr4J/N1vMSb/QLQvx4uSH/yvkExl164pPVtO/z0IWo5Y?=
 =?iso-8859-1?Q?ZNoBKIFtxyEKkzESKdYXQ8IenDVZyDedehVvUQoYvEFOj65KpyLF3h7Uhs?=
 =?iso-8859-1?Q?SFMO1UWo9gX68NsGu7SB2DJgBqBnyLhIg3imDlraBvyQlDqA8VpDA7Sro5?=
 =?iso-8859-1?Q?rOc9IJ+/nKEWiOLgVRniQl5ViPlOOMtGbZRPIHeu7jpRxHcHz2RkBsDpXw?=
 =?iso-8859-1?Q?ciBa9Y/QdNT01L9nZFyvcjfH1AhprWGEJKgpPo8Rn0Cb9zRJasEuhRiTH+?=
 =?iso-8859-1?Q?/Dksi3+73fCvHjH07soZno+Rnko8BlM4t68J7opuDI5pnhOqxRMbT1UhRo?=
 =?iso-8859-1?Q?eE2kNyXtPp4xAN4hUiaHL4NDim/+jtm1B5pIWnn7GptvFZWyoMZD+3fzvj?=
 =?iso-8859-1?Q?fchVWcriAOVX74fv1Y0qNO5VOfEggro1kGMe0YG02U+LnYkzmJ7XVYct0/?=
 =?iso-8859-1?Q?55A2Gvvxtk2DWhGqtvNn2LOEykQ3HmHyDhkgh8VR65Th+GSXgibMe0L23D?=
 =?iso-8859-1?Q?D/DVisVuoakk+O4Z0Al11luIyx3tuEwxdlZ9ocMj8Mi/3M/IU8acn/KIl1?=
 =?iso-8859-1?Q?aSHU9bEfwF8WadehHrCH2WOvQrkLEbrtAM+J7C7ht4NTb4zP8ik7hUtEzL?=
 =?iso-8859-1?Q?QNhuYSPUARnWt49tVU3Kd2C+tPNJXwEtXEesajho+1/Uv8LxSYeEWY+GcP?=
 =?iso-8859-1?Q?n+5W7dnPWiB16BwoA29tbBgMFDDIeFEqIgvTuDVFGKhSPGIBieciyBWFts?=
 =?iso-8859-1?Q?5ZYXiacklmSW7pXNfCSHu9t7dJ6T3LznoN5lDhTAxAAIfHpax6/5qjaEw4?=
 =?iso-8859-1?Q?r/3AVdeXibuyDcrBC0gPRSiUzM4ncHaJj0MtA0lkHVHu627rIMz5e8u/aM?=
 =?iso-8859-1?Q?0jc48dPfMHtgQPKKleJGsQ/c/TWd7KzqE5xI7/TIT+ZOw4cHfc9kFkXDa7?=
 =?iso-8859-1?Q?IJ1gDWFzXZJjiomd9v03Juer3zy4HZ9Uh49g+YtVlRGVMZnDzxJjwzW/l7?=
 =?iso-8859-1?Q?/DKmcVYtkvT/NmSi6mx8IkS2LBa0Y6p7NOolcC+KSoG3vZyWYcc/m5wfx3?=
 =?iso-8859-1?Q?8pGXpJGTGsPF5Hrc6bZuUMHwk5IbGi4MoW+ApURF2G02tpuZaNjmaYc8hL?=
 =?iso-8859-1?Q?9AuSN9ZiwM1a9x/4g7NFQGUvMB5fErhMFgrnHTqSZaVs2r5RAATVVXMxyQ?=
 =?iso-8859-1?Q?b05msOhkfksE5DG4YKWRpD6tU7hK+DTnotMMkK43eTDh+GiysFeza1QH04?=
 =?iso-8859-1?Q?xdRdsAtMhQn/UUr8/Qs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ffb061-887b-403e-2d97-08dd524ed23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:44.4584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2OHS2zPcC1p+pGLICnYJHMIFbdSAyY3ToQIjvFuVvX5QvoaSsybXtp7wGxWcDmWKSBZLshM+rp0hQe7Uz7wRWvnpwc4vHR4CWOL2oQ/Qy2tsSLHJf5vs+7fhkY5xhpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6459
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  1 +
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9daf8025cc..2b1c733d86 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4159,12 +4159,10 @@ static void vtd_report_ir_illegal_access(VTDAddress=
Space *vtd_as,
     bool is_fpd_set =3D false;
     VTDContextEntry ce;
=20
-    assert(vtd_as->pasid !=3D PCI_NO_PASID);
-
     /* Try out best to fetch FPD, we can't do anything more */
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) =3D=3D 0) {
         is_fpd_set =3D ce.lo & VTD_CONTEXT_ENTRY_FPD;
-        if (!is_fpd_set && s->root_scalable) {
+        if (!is_fpd_set && s->root_scalable && vtd_as->pasid !=3D PCI_NO_P=
ASID) {
             vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
         }
     }
@@ -4738,6 +4736,74 @@ static IOMMUMemoryRegion *vtd_get_memory_region_pasi=
d(PCIBus *bus,
     return &vtd_as->iommu;
 }
=20
+static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flags,
+                                                int iommu_idx)
+{
+    IOMMUTLBEntry entry;
+    VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iommu=
);
+
+    if (vtd_is_interrupt_addr(addr)) {
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        entry.target_as =3D &address_space_memory;
+        entry.iova =3D 0;
+        entry.translated_addr =3D 0;
+        entry.addr_mask =3D ~VTD_PAGE_MASK_4K;
+        entry.perm =3D IOMMU_NONE;
+        entry.pasid =3D PCI_NO_PASID;
+    } else {
+        entry =3D vtd_iommu_translate(iommu, addr, flags, iommu_idx);
+    }
+
+    return entry;
+}
+
+static ssize_t vtd_iommu_ats_request_translation(IOMMUMemoryRegion *iommu,
+                                                 bool priv_req, bool exec_=
req,
+                                                 hwaddr addr, size_t lengt=
h,
+                                                 bool no_write,
+                                                 IOMMUTLBEntry *result,
+                                                 size_t result_length,
+                                                 uint32_t *err_count)
+{
+    IOMMUAccessFlags flags =3D IOMMU_ACCESS_FLAG_FULL(true, !no_write, exe=
c_req,
+                                                    priv_req, false, false=
);
+    ssize_t res_index =3D 0;
+    hwaddr target_address =3D addr + length;
+    IOMMUTLBEntry entry;
+
+    *err_count =3D 0;
+
+    while ((addr < target_address) && (res_index < result_length)) {
+        entry =3D vtd_iommu_ats_do_translate(iommu, addr, flags, 0);
+        if (!IOMMU_TLB_ENTRY_TRANSLATION_ERROR(&entry)) { /* Translation d=
one */
+            /*
+             * 4.1.2 : Global Mapping (G) : Remapping hardware provides a =
value
+             * of 0 in this field
+             */
+            entry.perm &=3D ~IOMMU_GLOBAL;
+        } else {
+            *err_count +=3D 1;
+        }
+        result[res_index] =3D entry;
+        res_index +=3D 1;
+        addr =3D (addr & (~entry.addr_mask)) + (entry.addr_mask + 1);
+    }
+
+    /* Buffer too small */
+    if (addr < target_address) {
+        return -ENOMEM;
+    }
+
+    return res_index;
+}
+
+static uint64_t vtd_get_min_page_size(IOMMUMemoryRegion *iommu)
+{
+    return VTD_PAGE_SIZE;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
     .get_memory_region_pasid =3D vtd_get_memory_region_pasid,
@@ -4913,6 +4979,8 @@ static void vtd_iommu_memory_region_class_init(Object=
Class *klass,
     imrc->translate =3D vtd_iommu_translate;
     imrc->notify_flag_changed =3D vtd_iommu_notify_flag_changed;
     imrc->replay =3D vtd_iommu_replay;
+    imrc->iommu_ats_request_translation =3D vtd_iommu_ats_request_translat=
ion;
+    imrc->get_min_page_size =3D vtd_get_min_page_size;
 }
=20
 static const TypeInfo vtd_iommu_memory_region_info =3D {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 238f1f443f..7e2071cd4d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_PSS                (19ULL << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
--=20
2.48.1

