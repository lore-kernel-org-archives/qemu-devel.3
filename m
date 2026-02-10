Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40D4EA3F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1U-0003DN-BL; Tue, 10 Feb 2026 00:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1K-00037q-N0; Tue, 10 Feb 2026 00:10:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1H-0000GO-Tg; Tue, 10 Feb 2026 00:10:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0oXf+NcWyfeiRheS4zzxdsY8gHoIY7OlNmz6BjtK3BUgX7jLfmOrPNXh0RFqTTL6o9nxp2LUPIoaDHaykZbJlyid+xP2l2f94MJVXlXIFb5lWUHrddTF/OJLnuQgo/TD79NzceCwhAcbwQgjaO6awlnikZPitQDVoENkoq8dqTInQ0G1lMQbOwpiizFshnIxYelg0/rBA7PhMFwrCe3E3Fv4quKixqn1PoRcZKjk0XHu+OAD926Y1metJ6qyOtomxZGFwy4JaL92rqCeeSD0OnThbCEmi+vsDW3LRP6bZm/EI+oyH+Cz7sqtyRqDcnWjSOP0H5KJkgyAMaKXeoWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlAXv064gcfDzrGFyEif9PGbNQIbhwZv8kNNbLemSbI=;
 b=dKjY47fERzed967UF1InYzIrsrq7zZdo80WpsqB/gRmiMN9BcAH6IhnlQ1g6wSzmH9fo3+YcumgDQYUucRSqfAf+i+OP6K4bcIiu2AYSroesnJAQehRISs+fTGaPyDeFMfJRthZeVHg0DuNDAD2JgxRCWMXtC7mSMnoK8ZyATiRkSGFxKYvjkm16b4nUNPprJhS4ObYtph9llqn350Ss9oQ6fQUnfM68R0YHDzxKMffJ3M8/ozPp6T3CjcyE+hkhESzbhR+pEwYetqDh0ZwsXzpP0gJscOakttwwtLyMEM/eoeydR46kQa5fUZH9Jht2gchkDIw5o1zWCkCujjC4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlAXv064gcfDzrGFyEif9PGbNQIbhwZv8kNNbLemSbI=;
 b=o4HAQOsEYLt+fbkh5rKzZpYFw8yp1gPCjfELxko117lxGKOveb5DeALb1zcyBC9qli5EM748vZZqq2mfHx9zPh7aPnYNYHublq3pxOYjRfrqNW/ObmOtpLklhfeHjxD0ie3GDvefBHAksvaeUA4I+d4DwAPN9DW2Fp5GVaON61fonaquOJiILLkGqWzl8BXOSdg9VSxFY/7GL1H5dWiD3X7yY/2PaFYkF0iIQeWkiUj/T+otgBN1FZRiRvIgBUljIbJbM2pxMMdMEczCwygcirvjg04vJNVq8B3idnL8xTwEs0viTRcy91HoybvqG+XJj5ElRj1/J84QgUqB2EVEcg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:10:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 02/11] hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions
Thread-Topic: [PATCH v2 02/11] hw/misc/aspeed_scu: Add AST2700 A2 silicon
 revisions
Thread-Index: AQHcmkuI7en9ov5iqEGxuubiak6LxQ==
Date: Tue, 10 Feb 2026 05:10:11 +0000
Message-ID: <20260210051008.355149-3-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: e1774b47-1eaf-4d05-e585-08de6862ab09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TROPS7Xgu4bPUCfRlk1QKPL8kYuoHyX/8JuaigXjii+spm+U7KTppz/7c1?=
 =?iso-8859-1?Q?a4tdZW4dhEDQkQ8G839M2NK6I93IhIi89nEOY7lAGAj3/YuO3UsHW5UK0Z?=
 =?iso-8859-1?Q?QjxEZQ05n/6UjjCtxfUF++Xe0SBrTTN/3mRQ7zBIUcFdDBYYkzJg3lEseg?=
 =?iso-8859-1?Q?95FKysaqBdhCS5Of2lVgnqEKuwGzz2EgQzqVpF//q3LIXl0MLxmNC6+z6h?=
 =?iso-8859-1?Q?5kA33ZEv5RGdmFVC607SG2sN68SEu9xlkbnyugwNTJhC+4gRgvyYIaHk/3?=
 =?iso-8859-1?Q?8EcUr10QBFESBhfkM+IAyrsVfGtB/Ej8Xwi1/Uk2YG4aFjN6XIqHknrVZU?=
 =?iso-8859-1?Q?5exQXy6w4OFP+PMzJI+kvnWyhzSzTZyX5zRMAxesql3uiyy3Z3ECsCu4kT?=
 =?iso-8859-1?Q?TAxXOgcMHyYZO368quZG++MYRKbTgZOQXphDQgDxc/BKltnkLSvALarc5h?=
 =?iso-8859-1?Q?PBzWQt6pbSwRVww4lcn/txdD2SV7ISFctFJqW7JAkVTAhPP6NxmNLLVSXz?=
 =?iso-8859-1?Q?NR5lX0Dw1a9yaYrd8Jn9wmWDxJtvLhOnjhnfytrC+5DjgplKyBmMoZb/Id?=
 =?iso-8859-1?Q?RXQ9onCNBru4dtVtlorU5VUYexVkcLwsiefGaDGRxAH155H3D6i7+1TnWf?=
 =?iso-8859-1?Q?eG5q/oGG97WQhvFV3k771jw25R3Jrq5HtyJGeIIHLJ7HgmFMNEoV32lao+?=
 =?iso-8859-1?Q?fjLAsPPLO8JaL7CIB5JApICiPOM7L2Ig8wc/L8Fatxqc5AiOaJHlL7Q0a1?=
 =?iso-8859-1?Q?TJ1hn1J4MMA3uP1u9bR8PHHZX7xF+Qx9fgUT9A4CHT/bNT5yRgDDRRK3gO?=
 =?iso-8859-1?Q?1in7F0TvVa2/tFAwaUWmV80makLuyYVmCM4kY1mCom6bDalBNykTpQHihJ?=
 =?iso-8859-1?Q?RTtViFVhuPxm+4RZQvVVvyWsun0tRthN+jAhYbrH2oAf1NvqgargoGTra+?=
 =?iso-8859-1?Q?ViNZCFxEKDC8MHVi2XICd5BbmnSAn+3lHlWhkjH3fzNC5rdrSb5XGYOLf3?=
 =?iso-8859-1?Q?yhesTIs5G2/s00ZAzctRdH2jZ5b6WArH2UvjUIyqYSefsK5aoRuMEXdGMr?=
 =?iso-8859-1?Q?8+zXzIu70nPOH3Qz8C2nKqApx/0KU+DEyk2PpsZV3+MGUk3SyV8BlHwxHL?=
 =?iso-8859-1?Q?8b1xjw+abG/1c9FKuEN4oGu6xrVKKCjVcFKzZ6QDBT39vA47WwJQfEH4p+?=
 =?iso-8859-1?Q?b2h+KP5pg8nq4wj8nvlnBl0Zltdsfpy4ELcfndf/nXfuSpzBmVMI43mPdI?=
 =?iso-8859-1?Q?o9CPCzghlTIoN4s3f7CqPf37olU5/0t5Mgne8WgurwXqYxU2pN67cux8fF?=
 =?iso-8859-1?Q?HwKXjoVgFvveNF1Tc8+OqdE7hpeYvV7SbAeYNGsu9Xh98ZSTBBabLWqfGV?=
 =?iso-8859-1?Q?d8Dy0yJB/rgEQS4cmIkjtIJfQxRXl0KTRDkhUCnn7lpkSe9JccolV4ORZH?=
 =?iso-8859-1?Q?8CdFCwQjG61fAjNUqE022okqp7srFttvhsg0M/dIZqcwIQ2wtw4tV78rAh?=
 =?iso-8859-1?Q?/QKHmE/21Qfz2krtELoNmsma6+rO3sXYoRuJiqaFAUArntefCBDy4St0V4?=
 =?iso-8859-1?Q?WC3lfHKjp0Jfj70TeZ9qB3s49k5CWGrj4odVP8Bvg9qvDIj7xULv4bBg4n?=
 =?iso-8859-1?Q?DJsSfbWAuVOexQPfdbKuUV+i2OsjAMmxLeNiCuN9XH2qJVuRa3LN+T3k33?=
 =?iso-8859-1?Q?zSAoN3mfqw6KiARfvpCRoVfyjP6LIi4P37OiW4XC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EY3/173lVXG/OubaSelvd1hk5IsP9D2iRGF3xsiiPqWQqigyqfKwkW4VN6?=
 =?iso-8859-1?Q?lnnycaQd5xOzsOsgn7SYNZ2F6G3UsikuD/oMXUbELhx7bjFIGvnJGcR4fW?=
 =?iso-8859-1?Q?BO6XicT5e7y7wVAyxOrbU/U/fk8F5prTA+sg6n2qVioiSV0F+qNbuwAhgd?=
 =?iso-8859-1?Q?AFD2gHG5PH3cQpcbSKdxM/6cAy1tUSDrMAQ3V4qu322FBLtz8J7h1dk4Mu?=
 =?iso-8859-1?Q?wrPAu6LPJcr6/yAccX50ybwrwkFJvS+AhAYYeTrrDls50SRkwf7uCOQO+5?=
 =?iso-8859-1?Q?1y6+/ahhsw/qgs+ITNomIr5WOzPnIAbaMQRcGQNl+3WZ4+RYYOUbzI4puD?=
 =?iso-8859-1?Q?zoFcslEaIh3xcoUZo6LdVx/CG0JRxDOjHhudjoOiWrKLS/AJs7lNx8TEok?=
 =?iso-8859-1?Q?PGfYVKpzY8bWiqlMOyIRTBiYdXu/sncfTCY9oWwQRazoOKRe/JW4y4rUY2?=
 =?iso-8859-1?Q?NgUrvxJRyNr4XrSsmsyGrZR+n1X2cgK3Gh3yb1tJy5nMH8u1RDVN2pHkV6?=
 =?iso-8859-1?Q?QX8dswjEtP4LUaR8NT7D59ieaumozpqEJv5l8UjANMlsQCeJ1erqxsAYMi?=
 =?iso-8859-1?Q?rvKQSGPtSYfzfmG8sqXlPSaDfydpVFQ40IaSiBf4K8L+Mp1OSwDdR0pkv4?=
 =?iso-8859-1?Q?ouR11k6aK04WOL4f6B6bAG0/ZsREE5TOURzwwRFvlWYP+2dZdCVdPdAg41?=
 =?iso-8859-1?Q?1N+OWXBokGQlR8fBVwVbxYAIgDekfI/vAU7lcijFksm9hgpRNBpUfTn063?=
 =?iso-8859-1?Q?U5Qe6wMgpwi7pzy05YKcamGK4URmlh6QQgkt5hUjPE9iszHGsa4f7bb3uD?=
 =?iso-8859-1?Q?YszSLkNOEvDzDaJLao5/lal85IxGtlJjFcechzE5k1dt9dinz0+/fyQct8?=
 =?iso-8859-1?Q?fAOrpfzliMFLGP7x05uJRCLgj2UVfanMiZ4MM31XZb7/M91ykWuKyds7+e?=
 =?iso-8859-1?Q?HOcyDXxYd4+vIo1bthY1Xa9lvbCpsm8uF5YMY+6Xr6f6TRSaA32WC45/fT?=
 =?iso-8859-1?Q?GIs1JEQae6Yg0sVRwFjOi9ax9jWCUdBJNbtPsCiU1yVK6JGf1c+gGkPyZZ?=
 =?iso-8859-1?Q?XpeiN2+mHt0/OC1ypkdwYfWdho0zOipmQA016kEQg9WLji4tWEVGeu4zyF?=
 =?iso-8859-1?Q?3MEwt7Yu/g7ukqjva4ruWocuQiTxkI52ZLQHO9/5xmLAgSiiOZG6Qxr6/s?=
 =?iso-8859-1?Q?NsJ4SV57+PRoW7Zxf2b31Mz8SwjVeQbvUu943zeLGSpnguW7SL6B5g/e8F?=
 =?iso-8859-1?Q?UVINNPzQyJcrFSs/1dSuiWWtWcHVEwjTS9GE4kyHQXLkOqsvWboNQXIHgL?=
 =?iso-8859-1?Q?siJC77aMCiHDuupCGb9Xf4V0fJay6Zx0Oxh1CF8R0yoBiIuiJIBhpfQ2xl?=
 =?iso-8859-1?Q?9Y42ADrnBov1G8HgM22hyRKK+D1wIUro+SBQjiRrsH6fcdq/+/0BoUgMWd?=
 =?iso-8859-1?Q?jzCfcqHU5ZO8TSXailbe2uZq8oSgSI1ped9rE8o+7tlOvdT+LaAYSa1wH7?=
 =?iso-8859-1?Q?HAZ7xFE/XEikA+H+yuGxObNAdC6iDLikSFDgenHTVAIWMpf6NlE8nYoqho?=
 =?iso-8859-1?Q?DppRjliTLvYzOfeALkMF4EsEu7anfWEvqfl0/aZt5J2j+3zVeLh5f+xzAe?=
 =?iso-8859-1?Q?zeeWbqBR4VsXAxvwauXanndymjgNi2OVCS3BOM++a0LYERZjXSd32trHkp?=
 =?iso-8859-1?Q?MhLdrxvYX8pafy2ensPlcSF3Gbkdd1X6KR5mMKUUWJHp1ElzwEt8Y2Eeqp?=
 =?iso-8859-1?Q?qAmqgE2F7p7SdkkRRnvTfyn2vIC0v+4EnYeGVDWvo7usYxc6KVvDSe/d35?=
 =?iso-8859-1?Q?5ms1jLCa+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1774b47-1eaf-4d05-e585-08de6862ab09
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:11.8709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK1ElqhwX66E9eKqZis9tRdnU5AmgZ1kLCG9dE4NOHXI0wLpJmCEa9+NPXSTHY10AB72E8D590gCdAveohzBFKlG1/OyDDw22YrbQg8Kdo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add silicon revision definitions for AST2700 A2, and include=0A=
them in the list of supported Aspeed silicon revisions.=0A=
=0A=
This allows newer AST27x0 A2 silicon to be correctly identified via=0A=
the SCU silicon revision register.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 313a79f2f7..d003955428 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -47,6 +47,7 @@ struct AspeedSCUState {=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
+#define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 0edf9c1b16..e4160356e4 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -561,6 +561,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
+    AST2700_A2_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

