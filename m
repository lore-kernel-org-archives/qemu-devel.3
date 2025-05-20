Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0EBC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFf-00016Q-JY; Tue, 20 May 2025 03:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFd-00015m-To
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:01 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFb-00025k-TG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725540; x=1779261540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kfJFL92ja612s8S1MW1A5MAlOH9/9xQxGIQwpcJjr8w=;
 b=xQ8TkI+CI/hvP07bhAwtHvopn+I+H4s8YCB3g1RvBqAjLsTTEyWYUtEk
 Q6YiDT0qfZJbRDv3trqgyM5Cw9mfWrWsUGlFnNbiO8Ft685CwuEXLg6B8
 Vv6iMEFf9EcolIH/TYWbwnexiMwLkIzh5NIb04+2KFi9fkQlKwobqmYJA
 IxrzlcYSotrwSRb3evw9M3Zw8TBnPaKNb5aY9cczV100h/EP3nRkZOVje
 ly4KdcfenQ352QQNfgrm9GMEOJmozluGSXmKluSLkCag0y+Z2p9s2y7or
 gVC8w8ebKHKia1hlUlc1gWjy1/KHTRExBcQWen6IAlJDOzIrvI+9dhJ4P w==;
X-CSE-ConnectionGUID: 4QQK3FnlT7G0fffTvCCqpw==
X-CSE-MsgGUID: PZWqDjOhSU6IwUJ3haDelA==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37197185"
X-MGA-submission: =?us-ascii?q?MDHzk8vZ+VKbe+KWl+qYkFouT9QGrT45uuRUDD?=
 =?us-ascii?q?DjxFOkr0CxF+0jiPkloht85PlhvzLe31wpWOTMJbpFY1N4EIK6fcvEPe?=
 =?us-ascii?q?OeViBVt/P/c4kW4KmVh/EUi99bEYGz+r66yT17OkPzWwdSL2vxMmINVD?=
 =?us-ascii?q?WUKfNTIvN1/6Q+q/dkLHZeNA=3D=3D?=
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([40.107.21.44])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:18:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKcJEaHTwoLhctiXAodxmCxBgtURD40bKKU3u6oku5r9+3bGzyDQASyXdllu7pOGdQQylWlIT2Qgn+Cs/mgVT0Gh633+t6K9R+OEF2ua7AwcC10Q567iFDDVZJZjTisc5wbZvxf4THjGiS+co7uxOD/zbv6aiLUUiv5V1xYkaQIYFLElw0qwRabbWOY/41Xs8gwdgrPFoBm/RI92I1F6idh/o3Y+4+FA8Jbt3NH/Hb+hAgVaQSD6zCbJ2AuZtx7SUY7FglTCKw2kFOyuQILo9E6oPbGsCoc2WJcoW4yUeOzv5xbaBapYLn+VnRdhYaWu+8fnyCOxOFfafdu3emF2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/yj2Ghuil6B22yNfi7Lvun2Sw4Pd0QSaygLFPwBLGM=;
 b=C+0isAuuQbeRN5pgsY3229RV2u+uSjAZWCBGw9/fP6YCWbB3dBeTV6CubQySYA6V53KQj14HztePeeogRriPwV0T9AUW3pKDfB2g68jlt48LAUa9QK6jowUKZTCAFEp+FgPmM9aaQFGLS8L8ajHT4gHhc1ccCHoZ+junjTE1e04FzZp+2+7VNGm+UiOVHV+s7m3ixObMCcj+exn+34rcKfLBGLlrYX2T1AhgY5CCBWsYzs1CeggBVLI3/yCnAglCUYnoA5dLxty31mtD03Numg7DHFIrzzYBdrSyDP2z9IFntrU1ZqYWJIcJDFBAtmzl1UPM3P5bj2C2YP6gBJMFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/yj2Ghuil6B22yNfi7Lvun2Sw4Pd0QSaygLFPwBLGM=;
 b=JqqP83Wo+YXKh4es8Nyl1eqBvJB+mp9XsYrEo4NJGDs5J4+QkPqfaoGdKM8FMdV+qbWoPvNgH0aL0s43ynjZxKDj0U01HRlvMfoifidbkQBQ+waUiH+VWG3AHoLMqdhPp1y2sVGIPle2jTpUDFyYopvvgdooF7GsJAM1nZbNc3YRLPrIFF1WWCYk79AM11lqBFf231K+uga8mNopTAIft2LtAMq0yqroFVXd3MhD4D+txZfArFIT00/MVL69Dd3tTrnY2W9IbHqu2TgF96zl49DDb8z/eGEci+U4AaEx25bU+bCiuI1nPzbdZcgVbXqF8jEhPNeIDGCT79Lo9bwdow==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10037.eurprd07.prod.outlook.com (2603:10a6:10:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:18:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 03/11] pcie: Helper function to check if ATS is enabled
Thread-Topic: [PATCH 03/11] pcie: Helper function to check if ATS is enabled
Thread-Index: AQHbyVdwNT7CuEiFF0OmlUpCKCqsuw==
Date: Tue, 20 May 2025 07:18:52 +0000
Message-ID: <20250520071823.764266-4-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10037:EE_
x-ms-office365-filtering-correlation-id: 82dff09e-d7fc-441e-7523-08dd976e9336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?u+yAc9qo3TYx84GklPXL7Fatuke9fFvaPoQJ8FNqdw4m/cnHT2GXYjd+P5?=
 =?iso-8859-1?Q?J5lytHDbXJD8ilNcTNpjBSBIqVmGYHZ3mj16rTj0SyQTjFq24+NR1piNH1?=
 =?iso-8859-1?Q?62nsQ5tfehiPRKSSxr6p5AmaG2UYO50JjUDeOLYmA3wjKhe4GacbI/Jipl?=
 =?iso-8859-1?Q?C80qfLqcEx1OsG2suntIlrvzswKlO+XdOdV+0TkcBHeFSCtrFl0AoBmPE3?=
 =?iso-8859-1?Q?ULiiUv+mS/9USHu/YMaSfmXV4+tBpGli8u7IrADj9REvUui+WiozIqJtkd?=
 =?iso-8859-1?Q?4rNg/xLkcTLZAgXbSuKg0qxVub7UAYiATO4K9jBndKJ0tvTBcCYSsaYGDQ?=
 =?iso-8859-1?Q?Fm09kiDo/NqBkYCJodSe9T5wnpMqqHqpva5rX9UI+SRdF72djrLkd4DpcL?=
 =?iso-8859-1?Q?0NmWcP+ay1GJ6Y7nh2dcGoP2W3XXzdpXGJ85jvdmwZDod8NEgA79VXidbg?=
 =?iso-8859-1?Q?x2SPoFB00Gy3wybDIL/EGwGIdh3RVlqORhvwAY0Ah65GwaEmNBGkw5vvzP?=
 =?iso-8859-1?Q?Nq6QEr8D8K0udCavd9V94pEQqtdoUuDlpix5JSJYHyhb0tcjMnf9rXQ634?=
 =?iso-8859-1?Q?KL6Ut8R16PVHrgov3Ydp7Ct3+VLu5lLPz7ZC+4lpT5xIdJ4uQQxCqJhGpA?=
 =?iso-8859-1?Q?ZY5odhhPQ4lBq+Xs2nLrdAgO7tyNQKRg1YMGBIrYaPl08kbmYpozo6puOT?=
 =?iso-8859-1?Q?G7ZcNrdwZibZL+iPgs3mI4lVAKopIGIuWgFg9YiH89H3SzfgVPsLR8MqtT?=
 =?iso-8859-1?Q?ZPJeRkKy9ApuqjlFReav11DcOzYAmNhzSUaI8Cux3TX7lfR1hgTEVtWAiV?=
 =?iso-8859-1?Q?rL/r+nZLnpD4fOY3JN/W280Oe95m9/lJnAg4JVseJkt0PN8M86zbdhgnzL?=
 =?iso-8859-1?Q?S60RX02/vkmc+jMbsWGXG7ObbZ71rC4NeDwgkOlGL0f2pvlftkrZcMOsIO?=
 =?iso-8859-1?Q?Kyn6MrI2EmqEuTLFqKmBWk6tr7OnUVXdUKiJuuxQEvWAGX8tqVxAY1wgEs?=
 =?iso-8859-1?Q?J4oZ6/GRFjQ/qec7b5H8lQHeV+NsVmOXxS9twVMVIoQMlwZm1UrpaW7+eu?=
 =?iso-8859-1?Q?kHIxB22jVXni/RHQPqjqEaXqr8wcZb7Sx7wV7TqH3P6bW+uijWF5r3T0Ic?=
 =?iso-8859-1?Q?O1sEsPHaPSRBrWjN7sTLqMhM6I+urSILJgLPOn+UgJIGPUBPiAafTXIp3t?=
 =?iso-8859-1?Q?m9esj06209M446WbVp4R8OHlC0u625se11rrfuwexSVqV5Np1g45JAfEwI?=
 =?iso-8859-1?Q?rWPu9DU5iMBv4qVfhmGobk67fT0Z59Yl0pE4QTQEY7i7snEo5x1a1/l8Fq?=
 =?iso-8859-1?Q?WjWpqo+DeM+DxVpmHrSThTbtprNKU8L2DiKChd/VzoBvzvw60qXYtg29zT?=
 =?iso-8859-1?Q?AFdMSs7I5fulpxfB48HeyFpspPQDrrcLXxdO8vb2VXM21uJ3B2MpKTuYgV?=
 =?iso-8859-1?Q?jXxil68CGzfFOFS70HZXkFsGmkPFQWFUspv0e2XYli8hdOWBOYtfp394zR?=
 =?iso-8859-1?Q?BwAvnr+qukv7SDFiVRC0Bihy9IOxvd9P9NONMVnulKNwxfxdiCZvNmf9Y/?=
 =?iso-8859-1?Q?w+Sx2XY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4c8Fx5eV63skNn6l5qN/0ImGLCsHxpUCVu9vI9m1pPI4K85YjjDJJZmNvO?=
 =?iso-8859-1?Q?rdjnPOlRsTDBBRwI+cDAvZenQmbhusx6KlwqvODbpPoM0akAcQzDBR/7s5?=
 =?iso-8859-1?Q?shoCjkI5A4fiMdRAs/RyTSTdIXcc+WqMT7w0wVZfyXx26Z9VSRt5moReCr?=
 =?iso-8859-1?Q?9QkkKiixqmpqznYSQialEyHt9mPNHyQXmkcBxZdGC+GRJy3aUEWBioR+mB?=
 =?iso-8859-1?Q?1PJXcIGvFc8wNHf4fCU+q/lFKeqwmsMuDeDzmpR7tMXVUPENrhzJqz3bQH?=
 =?iso-8859-1?Q?fSGgkGUrDBVstWB5xTXVikudw25230oE781YjdMhcqhILcGCD1WB3kfjWL?=
 =?iso-8859-1?Q?mlROtMwOEi9Dtgprmy3jp89cwUi76HVOe1lbGsOBPFBF1lmJSxO6cKk17p?=
 =?iso-8859-1?Q?1wvvN3u2MeawlbGmSofnHTMSqvzgWJ6kBs8Kp9Okdl2PTDrLNEJ6x32XP4?=
 =?iso-8859-1?Q?ENDMEz2y8s7rlyXLZkOA6j88YoJAjppBAC2EF0xmoZoDYEwV152SOCR14d?=
 =?iso-8859-1?Q?/UpirdFZncFmEHaGam4hENO8YY98RGKh4zUHrzbIwqUgrECPfkD6tmQn/M?=
 =?iso-8859-1?Q?KHDq/wDKEfpkMKfvoijUVxfp0P/xMctH4IpmVv+qT6dBT+3hebLtsF2rVB?=
 =?iso-8859-1?Q?zYks3BKwC+m7+R06nRRxUrgx7D0J/tpBflNQ5uwxJ3BHZAnV5mcs8SyeGQ?=
 =?iso-8859-1?Q?HXPDl5QojIctCmyabsgo+afplYpHr5JtjNkNN3Fy9XzM8WgJCB2KJmzBIC?=
 =?iso-8859-1?Q?L6bThZ/2Jiwf9MwEZEEZmOC/aSFgsg/xbCLM8Lz2CQELDe4WBE8wa6E/cK?=
 =?iso-8859-1?Q?Nr5SvgMhUVry1nFPLdLxt39oVb+AohjXlv6lr3wp08zycvd4BRn/L71L2x?=
 =?iso-8859-1?Q?ye4YOOzNSa5PNuk+EGw3w5z5qUt3cr1r5JxVC6lh2rOtxhyimHbtGiDMwv?=
 =?iso-8859-1?Q?XyZL/PivhuJ+W2aNf/HK2NzlRjn4HMs3uYvrlACvCyXEv0rYFU0FhO3csk?=
 =?iso-8859-1?Q?xzvcLQnnhWM3xAEi141W91jDzE0tlitQuABbSsN56TQiEDgeuXZ3zQMt6W?=
 =?iso-8859-1?Q?TE7fqa5c8+9Ec8+PyjRIVe4UfKrYJmETk9ZoqkF7+NmD9E25TPQdKfl/I+?=
 =?iso-8859-1?Q?HqmU5uMF7QuqvDuWHUQrFrrjFsVJr6Qq81Wl5vn9zIsJXXe6hL2tiWmrf4?=
 =?iso-8859-1?Q?Ysv3ZDsXcVDN5G00cNykDc8wO6yEj4IECoGQ5FXcvk8nSdoknQ7DxXxE3W?=
 =?iso-8859-1?Q?YjISt2jq3/FbSXxeNKco6o5wAy2j9R9Wyr/mXWtWl9S+bENm4IdwS7GM3R?=
 =?iso-8859-1?Q?VEwt2uf/eYefXY7WN70OhVeH/wOCHF9yMy1WucNzUTZ8g99auWjF4OJDyH?=
 =?iso-8859-1?Q?Cide4rJLm7TQ8cIpYps6j8myQmrWFgzF1avHZo8PvpSK9D7yWtUNvNKEMr?=
 =?iso-8859-1?Q?A9O/9eI6DSWD+0/B84bDRZp+IYwnFpPxavikmfFpdBG5DJPupS+1+/KEP/?=
 =?iso-8859-1?Q?XJkqandreCBrkDR81L+/w3AJHRQjXqXPj8mv6QJOrfkv/TlUk86zewEZ6d?=
 =?iso-8859-1?Q?5UF0maQVJd2yC+Fo83p8TXdGTbc+k5cmsV3ciMuONKtbcgxAILcjlDJMBL?=
 =?iso-8859-1?Q?Z7wSZ443N4KA5pEukW8ZA9Nnvz9gh6HaRcs/FSTBI/iM7/FLExB1QCChAX?=
 =?iso-8859-1?Q?QHpoykkCURVNq0jcRf4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dff09e-d7fc-441e-7523-08dd976e9336
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:52.8298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vY6afMKUyVmB+IN9mKDE+uLeJ4T7CBzA3yWtRKTYOAc8s1QFuPL7FHNhzbjcKfGjvlVbEQy2J4KB7XqlzW0tBmaGicqYCzKaaNRQgs2I06XEehA8+yHzuF+bPv5q28D3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10037
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

ats_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index db9756d861..36de709801 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1248,3 +1248,12 @@ bool pcie_pasid_enabled(const PCIDevice *dev)
     return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
                 PCI_PASID_CTRL_ENABLE) !=3D 0;
 }
+
+bool pcie_ats_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.ats_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.ats_cap + PCI_ATS_CTRL) &
+                PCI_ATS_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index dff98ff2c6..497d0bc2d2 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -156,4 +156,5 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, u=
int8_t pasid_width,
                      bool exec_perm, bool priv_mod);
=20
 bool pcie_pasid_enabled(const PCIDevice *dev);
+bool pcie_ats_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.49.0

