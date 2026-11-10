Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=F8esRFqv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgIc-00017W-O6; Tue, 10 Nov 2026 02:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIa-0000zw-Ae; Tue, 10 Nov 2026 02:29:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgIX-0005Y6-Oo; Tue, 10 Nov 2026 02:29:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDJh0U4Zc0XIXJrMJ0D8ligwoAYofDmV1vhQXpSjovNVk/Tn4dU4n6XpnA2U450YZfBzX1DZecSEtPo2g7hOVm+wVM6zGRuWvDBQaokgnf6Fd2oKgtWiW6GTORSD/IownLFfzuoKun8y00PD+E5gNrAQHJCLXPjz6oSlZVTgjo9xVdRqlc2UxndR04nsOSlNvBMlHsip8tnUBIxjJ4+gdTpyA9lU9vFQsEF8IfBSaBqmO65N0VSgw8sA34LffSJHldld+EU7QQN1zb4v4c5AQLExA8mgQgksJ7R/PkGv5X9sF4iwP6KLs08zW/TuNRh34aLPnGaYwZhT+ZIAkOAaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=totdeulXCdOy28OmzmfRrO/hlcQTq5BzAS3bOnxw/ts=;
 b=VF5N0kyfvVcKX9oKFd78xAzLk9LM9Hp7N/t3+XPd4tE09x/IQ8Sk6C6Ey67PG0XDVYWpxgAlrV5WTHH9gKX6kpZQYI/cicyeIe2MyBPj2vuy168QiBzbrLZoz4JUiC0tonVKschNTt939GPTGmrW4eX7bbxQwsDSFKw7HrveWUWaKA7QSMLDKtrNm9hQtc09NhQBiduMlXUBt6yHCCk6cO8HV+gv5mOlZKk229aQQX/QHzVJHWOha8xTPNdrFpADMXjv3zskF9qlAc0g5o8tRXB0NLIS8V5gxJvbwsibSomrs94DXZYnsljb1Lg4ik5f4PiGlTyrgBvb0uWc+/vJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=totdeulXCdOy28OmzmfRrO/hlcQTq5BzAS3bOnxw/ts=;
 b=F8esRFqv06pTVuBzjWTDVSIqjcE2pRt7F1Py3MMMIFRKpC8uWXYUAtJJnBsbQjNweYVM5FInXnJMH7yZVrRMfNtWk/9t4PK3QwK3bi0ld4a9eds8V5gSrImmMtDESkyixeXfhSM7+2D92Vly9gwhiOq6jJW5cmHnD1CLK322p60BYbpbxGV0rDlCSYdHgFIsvvUFOKabLuar8WIPiR5yEyHINhmlJd5UiSMh/D4uvncQqdPsz1chEVFn8IaTeGUwL3x4cBN2GjjcLu076RnULjBNomTdbbMm5c/5WREtJZ7isZOtlH3DoQ9WrnAU+TPcAziNxr1ApHGe3g+eUmPIxg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PS1PPFE8625B3B1.apcprd06.prod.outlook.com (2603:1096:308::26b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 07:28:42 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v9 16/19] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v9 16/19] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdcOUc8mJV/QxhtEST2xF3yaXbzg==
Date: Tue, 10 Nov 2026 07:28:42 +0000
Message-ID: <20261110072818.2883349-17-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PS1PPFE8625B3B1:EE_
x-ms-office365-filtering-correlation-id: c43e7b88-2b8e-4f73-3221-08df3efc3f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009221227099003|261009223027099003|261028144727099003|261102123227099003|261021133027099003|261026135527099003|261026121527099003|261026140227099003|261021135927099003|261021121427099003|261021123027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261022105027099003|261026130827099003|5023799004|56012099006|6133799003|10067099003|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: 2D8IqqS/QNlNOD+J3jWJxQoyim/6N9W6RPWjMPRSdMLSYuTiYnWlW5DWlIN2OJGmxOupX5tl0wOAW+CSTRsLBuwgraE2rmlC5pi+Le1epIXvfbEwKghEtE884dQWinhzHEZovQoLzxCsSzzJGBYPwfNtZjQhMUwtpkLvYIwUAfWMlogKFg4nED/HW7PVHyhZ61b8GfoBaZkAc2oPv09ozTRlzFL4bnXBg2XxvF/VmbcbCtawAUi6AaPXDRkFXcCOxH6PpeeydjyqzTu2qndVwCUpsduwYW346XwnJliJVQOD4sXOICSNvMUA2+R+NNt0vrLbFrZRWcip36A1UU4CWCuQQg7HpKWlbNDbVC9a0EK1qTNGw8MH6elAc0bNLQxM8T1DE/yewm9jyRkD0Ue4pR3jidrVx+j85tNzI9kg48eyn5IjctyThwcf0381wRUs5B6GT0csXGpgmAP1JEdW0UKwzYtEhBi5lIiTSHEdpqurvtdL6w4NWoRajcIMi26sqjN+VROXwhkD98p0OzvkzRad2uvPNYIcNzuntEMqpSg8MpoCPnftrmSg9HMS0VS0oG6zEIr9sRLZMO8v+GgRZpo2dhqTT6PyRK7G2sZs8O/YCIr9dkNf3TlnkDCvOMZoEwvfhOwwzYHe597qoQ7tFLwKsqE971oRBZcp/iahnVzv+xV/UhcdXQUg59CHKNWcHhYeeZRr78OrrmFAAz8g/EvYZrkV822dYex7+1Ql+SyNa276XLhKeMEf+KJxxFxU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009221227099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021133027099003)(261026135527099003)(261026121527099003)(261026140227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026130827099003)(5023799004)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pzfE9tt8Rkz0O38A6FIUBkgqOcwgMzilTPnzEQwbiMcp3glEX0AoNwYxfO?=
 =?iso-8859-1?Q?QmyVvyiUahp9mxa//vJRtlM3oW92CtHvTx4ZUi+DoL7Lw9mMrI9i+5qKlf?=
 =?iso-8859-1?Q?xwEGphY4TZG6TaYfHQF4ch23HY+yI1vdkf6olo+7G2y3e/o+L2/6Mvk3C4?=
 =?iso-8859-1?Q?M8EX6OBO2gcg8ieIfaWiYKVMCI3Brd9wHyA9Rmhr/zExO7nxeVBtWCckNc?=
 =?iso-8859-1?Q?DX8mu+U9UORS8wkGCBpMTjyJ4bVX8Aeoenco79dVDA4YmfdALJIXfHS9L/?=
 =?iso-8859-1?Q?bg754JlXNVcV5jA+bHJuUCpcmqbdLQFmy3bfRklUNekEw2oQkRQCY2gj99?=
 =?iso-8859-1?Q?EtKHL4hiqO9HmwAHFkEbIP/EcSnYhspdidr0qM1Nf41bbuKR/jECg7onw9?=
 =?iso-8859-1?Q?TNkD8Ihkkks/qgC7U0doQSW+rjCR2nJlnMwjv81d893rCl1Bj41OetPrba?=
 =?iso-8859-1?Q?Wfd2b8PXJZLBjKhrme7J8ICX/1TSWdIJFCU+jhd8Udqvsf90OMX9drH4CB?=
 =?iso-8859-1?Q?IdxxCC63Mubt3ytH2N7ongKI3a8BRH08jk/t4osW7eRLsvQ8UUrKZP1tLl?=
 =?iso-8859-1?Q?oXXLp/v7P30aM1gnkvO5URLx4+esizQDen47hJO9Z1qdDrUUIX52XWSZ21?=
 =?iso-8859-1?Q?bziwntdZY0+xTRQtcXWd3reQDUe6hWy2aeNSa7iOJOGrQp846de9dspGtV?=
 =?iso-8859-1?Q?LMtyrw5bz/4xEbdNWyULrJzQ1Uia/lNEnp8AIuKxgW+fIojSGo2Q3v9UXY?=
 =?iso-8859-1?Q?LYorqqF72Iv7stG7gXPINug90yrqYM0lxAseGb0iZL2eYIja4n6WEoQn3V?=
 =?iso-8859-1?Q?Y4+wtGpMXByjD4B47EO+LOVyjxQNy/W/bUmmyPX9Y3uG+V7y5EWl2qFpZS?=
 =?iso-8859-1?Q?CytHMGMJb/JhJRsxYxU+ZhtSOtFoz2jOL6T+Ls2ZfTUmT6Wtx7ce/gwEuR?=
 =?iso-8859-1?Q?q5V9UZBUla9YJflV6vMbpA30ZMrBTQdFSYobs0nPDGp4exp2zxXi94I9iV?=
 =?iso-8859-1?Q?EvoQ6fpQaUMo5IQzNy+M2tBpMmst9WB5P+AzrjF8QBfzGPp0+aWlbNsp+k?=
 =?iso-8859-1?Q?ePqiO2P4MAKQV1qvlK+GKygOWmTiIH5Sz/sx5KMdilxey2cpMnSJdhD1Xn?=
 =?iso-8859-1?Q?QNw6uiEJu06EuLYDKlETj99BlkQdGLHOndi4xKy4nRq/TJN5BvrOwJYQg/?=
 =?iso-8859-1?Q?YYFrldwpS+9FHRo7/Ng8RJdeJJ0DBRwJiEbNHl0yS2LMr2vmoVV1PxXK8U?=
 =?iso-8859-1?Q?UdAzR2LZ9F3CNgwtv9ZIbSUAKrlnlHaf0w+WombDo5a30RCAqjlwyw1g+T?=
 =?iso-8859-1?Q?ckoqijXv65WTlo+cJ/0MJDR8qIBwX62mnFP29rboRFoZPLaZi5hFo4XSYe?=
 =?iso-8859-1?Q?IHfmwtkqKuV30bmgneVteugacws1lqibaB8PhFV0ajhveKjtHK9/U0iFCX?=
 =?iso-8859-1?Q?52n3d9N3abVuycPeESBNnzVGw5+ExY1KtAOqo9XMPaIyirdgsvEDf18T9P?=
 =?iso-8859-1?Q?t7q8e5fjIKMq2cagD9wvahuhzzbWdApeIgHy6P5+ryWoKrFR0rfL9ARUZB?=
 =?iso-8859-1?Q?rK1DdpTT2k25X+9mD++F2OVmombyB+rfA/RNVCKIA3irt+f69EVPUjW69X?=
 =?iso-8859-1?Q?5Nbn5T2wArJdsnfA0Th7ZvLFA1MjB+Jfhl9OD6Q7hgppcp59fuqY9FoMSH?=
 =?iso-8859-1?Q?izcPRtmCVrBTGT0yDVxX8EDcJxG2Lmn1vDkJPoGp4tKdc+VLnM1CKuUUJX?=
 =?iso-8859-1?Q?z7GE/yXMJZybSmdBCNVWxk/N+U+6ebwc4DpqU8VKGA3xYTtXX5pS7i2jXi?=
 =?iso-8859-1?Q?takrPEh0qA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RNcommyIEFCnD14uaEps1pYQoIdwdWHUVEVaG1HIU0Y468m2gTZT8GdjrGR90ozx6ElM2GEArx30OLb4fS4ZQLTcWmRdZrMnNSmZ0Iel1gqC1SHMSKoM7EfRgECjoShhcz7OoTwAM+WTjO59ak5BCWlwoIiXxj5+KnXo1hUWOinQoH46cpYLaxtP/2S7VMCFObzDvKJoXXv7Eqjb1MbIR8YAJzA1/Ri6AudCIQU8mQgJb5nCYQlflD5IpGHvCtG0Kk4K3GbIQc6/RjesOmqFGl0wD9JDNbK61zofGxFHjQBwhx4I4EWrrTG8OPGRayghQe9tJeEn79Y8yfw3Nr4F9w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43e7b88-2b8e-4f73-3221-08df3efc3f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:42.4838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfJFdb2PqU15o6LylUEKylYWllWOGfMlxigQGEgjcf/ql/CFaVv/qcpM1NcpVZIxE8sb5I/54hY0jgnY32aaZu3D8ovWJ5/WqgVwmJ9xzw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE8625B3B1
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Send bulk and interrupt packets to the device and return the result to=0A=
the host. Each one is a request and an answer, so they reuse the packet=0A=
tracking and the NAK handling added for control transfers.=0A=
=0A=
A bulk request carries a 32 bit length, so the host can ask us to=0A=
allocate up to 4 GB. Refuse a request that big. Do not answer it with=0A=
fewer bytes instead: the host counts the bytes it gets back, and it=0A=
resets the device when some are missing.=0A=
=0A=
Advertise usb_redir_cap_32bits_bulk_length. We already read and write=0A=
the high half of the length, but without the capability redirect.c=0A=
asserts when its own guest asks for a transfer larger than 64KiB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>=0A=
Tested-by: Junjie Cao <junjie.cao@linux.dev>=0A=
---=0A=
 hw/usb/redirect-server.c | 240 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 245 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 914697fdea..dce92eb263 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -117,6 +117,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_S=
ERVER)=0A=
  */=0A=
 #define USBREDIR_SERVER_RETRY_MS 1000=0A=
 =0A=
+/*=0A=
+ * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
+ * This is the largest transfer accepted.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
+=0A=
 /*=0A=
  * The steps to read the descriptors, in order:=0A=
  *=0A=
@@ -145,6 +151,8 @@ typedef enum {=0A=
 typedef enum {=0A=
     USBREDIR_SERVER_CTRL,=0A=
     USBREDIR_SERVER_DESCRIPTOR,=0A=
+    USBREDIR_SERVER_BULK,=0A=
+    USBREDIR_SERVER_INTERRUPT,=0A=
 } USBRedirServerPktType;=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
@@ -168,7 +176,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Kept for the usbredir response. */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -1105,6 +1115,67 @@ static void usbredir_server_ctrl_complete(USBRedirSe=
rver *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_reply(USBRedirServer *s, uint64_t id,=0A=
+    const struct usb_redir_bulk_packet_header *hdr, uint8_t status,=0A=
+    uint8_t *data, int actual)=0A=
+{=0A=
+    struct usb_redir_bulk_packet_header resp =3D *hdr;=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int data_len =3D is_in ? actual : 0;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    /* Both directions report how much the device moved. */=0A=
+    resp.length =3D actual;=0A=
+    resp.length_high =3D actual >> 16;=0A=
+=0A=
+    usbredirparser_send_bulk_packet(s->parser, id, &resp,=0A=
+                                    data_len > 0 ? data : NULL, data_len);=
=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_bulk_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+=0A=
+    trace_usbredir_server_bulk_complete(rp->redir_id, rp->bulk_hdr.endpoin=
t,=0A=
+                                        status, actual);=0A=
+    usbredir_server_bulk_reply(s, rp->redir_id, &rp->bulk_hdr, status,=0A=
+                               rp->data, actual);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_reply(USBRedirServer *s, uint64_t id=
,=0A=
+    const struct usb_redir_interrupt_packet_header *hdr, uint8_t status,=
=0A=
+    uint8_t *data, int actual)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D *hdr;=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int data_len =3D is_in ? actual : 0;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    /* Both directions report how much the device moved. */=0A=
+    resp.length =3D actual;=0A=
+=0A=
+    usbredirparser_send_interrupt_packet(s->parser, id, &resp,=0A=
+                                         data_len > 0 ? data : NULL,=0A=
+                                         data_len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_complete(USBRedirServer *s,=0A=
+                                               USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+=0A=
+    trace_usbredir_server_interrupt_complete(rp->redir_id,=0A=
+                                             rp->intr_hdr.endpoint,=0A=
+                                             status, actual);=0A=
+    usbredir_server_interrupt_reply(s, rp->redir_id, &rp->intr_hdr, status=
,=0A=
+                                    rp->data, actual);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -1196,6 +1267,12 @@ static void usbredir_server_packet_complete(USBPort =
*port, USBPacket *p)=0A=
     case USBREDIR_SERVER_CTRL:=0A=
         usbredir_server_ctrl_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        usbredir_server_bulk_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        usbredir_server_interrupt_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -1601,6 +1678,121 @@ static void usbredir_server_get_alt_setting(void *p=
riv, uint64_t id,=0A=
                                USBREDIR_SERVER_REPLY_ALT);=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_bulk_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    uint32_t len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_BULK);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_BULK,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)=0A=
+                : (uint32_t)data_len;=0A=
+=0A=
+    /*=0A=
+     * Too big. Tell the host the transfer failed.=0A=
+     * Do not send back less data instead. The host would see the=0A=
+     * missing bytes as an error and reset the device.=0A=
+     */=0A=
+    if (len > USBREDIR_SERVER_MAX_BULK) {=0A=
+        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, usb_redir_inval, NULL, 0);=
=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_BULK;=0A=
+    rp->bulk_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_bulk(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The host sends an interrupt_packet. It is a request: interrupt OUT=0A=
+ * data to write, or a single IN request to answer.=0A=
+ */=0A=
+static void usbredir_server_interrupt_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_interrupt_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    int len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_INT);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_INT,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_interrupt_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? hdr->length : data_len;=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_INTERRUPT;=0A=
+    rp->intr_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_interrupt(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -1624,6 +1816,24 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
+    struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
+{=0A=
+    /* We do not advertise bulk streams. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_start_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_start_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_stop_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
 static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
@@ -1664,7 +1874,9 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL:=0A=
@@ -1674,6 +1886,21 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
         usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
                                            &ctrl, NULL, 0);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        bulk =3D rp->bulk_hdr;=0A=
+        bulk.status =3D usb_redir_cancelled;=0A=
+        bulk.length_high =3D 0;=0A=
+        bulk.length =3D 0;=0A=
+        usbredirparser_send_bulk_packet(s->parser, rp->redir_id,=0A=
+                                        &bulk, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        intr =3D rp->intr_hdr;=0A=
+        intr.status =3D usb_redir_cancelled;=0A=
+        intr.length =3D 0;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, rp->redir_id,=0A=
+                                             &intr, NULL, 0);=0A=
+        break;=0A=
     default:=0A=
         return;=0A=
     }=0A=
@@ -1726,6 +1953,8 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
     s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->bulk_packet_func =3D usbredir_server_bulk_packet;=0A=
+    s->parser->interrupt_packet_func =3D usbredir_server_interrupt_packet;=
=0A=
     s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
@@ -1737,12 +1966,21 @@ static void usbredir_server_create_parser(USBRedirS=
erver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
+    s->parser->start_bulk_receiving_func =3D=0A=
+        usbredir_server_start_bulk_receiving;=0A=
+    s->parser->stop_bulk_receiving_func =3D=0A=
+        usbredir_server_stop_bulk_receiving;=0A=
 =0A=
-    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    /*=0A=
+     * Capabilities: 64-bit IDs, connect_device_version, ep_info sizes=0A=
+     * and 32-bit bulk lengths.=0A=
+     */=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_32bits_bulk_length);=
=0A=
 =0A=
     /*=0A=
      * In USB the host is the side that starts every transfer; a device=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 549f5f6e23..fe73ef6698 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -424,3 +424,9 @@ usbredir_server_nak_park(uint64_t id, int ep) "id %" PR=
Iu64 " ep %d"=0A=
 usbredir_server_nak_retry(uint64_t id, int ep) "id %" PRIu64 " ep %d"=0A=
 usbredir_server_ctrl_complete(uint64_t id, int status, int actual) "id %" =
PRIu64 " status %d actual %d"=0A=
 usbredir_server_ctrl_refused(uint64_t id, int status) "id %" PRIu64 " stat=
us %d"=0A=
+usbredir_server_bulk(uint64_t id, uint8_t ep, size_t len) "id %" PRIu64 " =
ep 0x%02x len %zu"=0A=
+usbredir_server_bulk_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
+usbredir_server_refused(uint64_t id, uint8_t ep, int status, uint8_t want,=
 uint8_t got) "id %" PRIu64 " ep 0x%02x status %d, wanted type %u, it is %u=
"=0A=
+usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
+usbredir_server_interrupt_complete(uint64_t id, uint8_t ep, int status, in=
t actual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

