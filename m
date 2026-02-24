Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FD9EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6X-0001nQ-SJ; Tue, 24 Feb 2026 00:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6L-0001jI-0E; Tue, 24 Feb 2026 00:36:53 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6J-0001J8-G4; Tue, 24 Feb 2026 00:36:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIBOJSWVadnd/9jVlnvJjcZp84uFyQF+/NfD177NjZqamkIoSfV2nYdF1ec1WABHrrXLt75E+CUBLYVlQA9FUWGRUC5+l30VAjZUM1FSYOgubaXIK9OFqeRkFmxH8HKXXJ9LflkmWnFRzpxtPvrsI8uLhQT7+GdHP6j7gWTgIg96MjwK+OacBaQUDGJNg7Xp9fzuAq2haRyADqCCbwRp/WzRmZ0Vbo3gWAg06UlIp3hSSknsxQFkHcmDYM/FJFsLVJFT3GyBeXCq/gA9HgElKNphgBAjv9e6ryghAmam9qj+qXg4xMPLfLKx7YULcFgZZjGPF3ds4Uj2rAWR8mVh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=JEVCWmlZ5qnA9BDPLZU131qaIbyiiNrqAtKZtUqcpd/7ijxlpUpnobf/4wfTPlDzNKIyUZw1ILnx9idGTLfoeLDF81hebEhWE87h0NL5y0NKyenh5fwypGUFHAfUwEbzZ5tEeeFBoucoP9kuhVavwq8lVHzL0g2jqLvopUHRumzfF9G/GvYajc8XqEryqktPv00iT4x4IAZuobway+SqgPVBqe6HTw8EuYT35x93UJiSQANzDQBkD8joIwsO5DQznGu77PBvieAZG6sIZ8HlXhoR4WE9mWePP8sIsECAJlgcopvvnV6olCGC9GPt+w+g6Jva0OhJXBorpxG6ogFVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmVF+Hu280YwIRW2Y2PU2OYpm86SrAuPXXf0GR+tRTo=;
 b=VHhaRKHCk+UuRgtMpkWdN2/i5o4e5j0OzVvxrVHDHWgKJisA0x/LlKqw4jVGV23jr+MrVFE7Ynqvv3OrzTimBBFlak9ec+kqEsSRvMOkyNyu+VCNe7n3Hc+bZDOJeRriNCFJ8BmmvuwMgn3JAuNG8SUb6NU8ifG74BnCEA4ifeOkxoa3caO8JsZTqgnLG7aGSD8e4m/9iHVzrNER02/V6z/o9JBEaOlY4aYobig/fx8dv10sNIG+S4ViwlRybJP/c1b4nTr0uTEvnQaEXlnYdAEwUhXAtSlk2ndoc7COBBUt1dcqyuzl1OSGeyEqR5xakFqxKtvOXtzZC3bW6AfWEw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Titus
 Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v6 15/22] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH v6 15/22] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHcpU+KDvgUYf//5UuLBBDJ0G/gng==
Date: Tue, 24 Feb 2026 05:36:35 +0000
Message-ID: <20260224053613.589102-16-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 7a66c28b-cdc0-40c9-b88d-08de7366ad0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dLkH54hihA4HonPvPLs/r2hAhxtx1+xtKSDvNh3Gr8E5IuS3ak0ubtDkHR?=
 =?iso-8859-1?Q?y6TOtJy1kEVfKF44NXPeVTLbd3XUp0372A1kzdxiTJf/Rim8a7BWfANyAA?=
 =?iso-8859-1?Q?oeOeR6tE36c5N9lXJifPzpFt3TwrOxPg3mO8QAdpRrC6XUprNDVlj/GkfJ?=
 =?iso-8859-1?Q?DFMJqo3COZCZNmDGbMztLxTCxeeSXNYSFnUQIpZ5GMCh9Iia3i0eAharMz?=
 =?iso-8859-1?Q?+a8GgKDJv0l3fHni66EUs99S++7Y2rJ7eVmf7nZjB9YRvGQ4qbEixOLHWm?=
 =?iso-8859-1?Q?BAC3TagMgojiw73i1zljl3z8jrQJQ47W9EInOXhDab8Adg1FWNWdCsjMe3?=
 =?iso-8859-1?Q?FXTlRLWhNJZ/26+YUfAHyylx2fIi3d1raXj+p07B9k2y++uZc1cNc0w4j6?=
 =?iso-8859-1?Q?dXJp84hZmEsrv0mgNZl491z1LTKvR/mMiDU6yvRrRcQTr9mw4DTdGgi9oP?=
 =?iso-8859-1?Q?tGqNjkcCg5VuqUzdupApPOj0QaglRiNHyv7/PXi/mlMwd7B/60lgTxCbH0?=
 =?iso-8859-1?Q?gLZ69IaH6UPzxUlTd92I1rW4aRuTGQkHOwvKP0qHzU+sT8Bxqgya5x1tlJ?=
 =?iso-8859-1?Q?Ip+BYZD9QulsXayc2Ff8n3bCTK7ptdMyJdaMbAATlpYLB8MVJ01TUBJgTi?=
 =?iso-8859-1?Q?NJQEvCaYICeNjhTZE0EcqpipsXIe34QfOflfjSK7ZobTU88+8XROvzsy8l?=
 =?iso-8859-1?Q?8mNPt6d4bK0cWGoRVAFS9SVEgySsQ1FMBqHJrNEm3EOst0aYcfFH+i8JCT?=
 =?iso-8859-1?Q?ralD1Fkv92oa9WFXpxHBrBpLtotypb+QnKz1DkBCwQT05HM9P++swbh7xC?=
 =?iso-8859-1?Q?A/Oel/gxMAzQzWFBPGuhK42XYWxqavnoxdrcI57wpgo1DoKvL3PrjEpkO9?=
 =?iso-8859-1?Q?wmDpQUz4cUGj/7+xyMDqrj3QA4iPIiERMszjaAxlWt7V0ewWQxOWJp5aoQ?=
 =?iso-8859-1?Q?7enkTB8qhmkzbbeZNuU8EZ2Z1wyX9PGYV4ycdPaWlrAuZPZRu6QlsmS4vW?=
 =?iso-8859-1?Q?ghK4XWvkIw4imAT7xA+KisDAbxaUgm7h5oXHS1PGQmIuvkYXa8ju9CEZjJ?=
 =?iso-8859-1?Q?BfmxsjzQCbApZJp2YeTXi0xT19lnZv/6u1B+8aKimGZPs4F2FD9Iho8sEg?=
 =?iso-8859-1?Q?TmpvbMdLF7JkGrxb4HnntlNwlGrHt9lQI7/IcULkpFY8G0m3XqnaRW99En?=
 =?iso-8859-1?Q?URZrZ2ljlz5znYIJXDNsXB8JlqQJ8tJoNGwff7+lVqf3bhq1sv3BNlB3vz?=
 =?iso-8859-1?Q?kuQZyX72wRoWhEEEbSBM+mBnBsthscuxMKXvzm3hIx5XjyNs4IxtWxweUG?=
 =?iso-8859-1?Q?4sv/PIdrlR002l+/n+f86AKKTIUsg22ea0Sp8wIgS6kMOJDRLFaUQjEUD4?=
 =?iso-8859-1?Q?gncJs8nOC79wSj5omQulSDRgsCTGmzKEqGoMxTlmoL8HJAGsCotUUy2iX0?=
 =?iso-8859-1?Q?F3kyqQID9rA27R90B8gt0e2dN/t6PxIm803wsFcp0DvbSViNcC3SIEN35n?=
 =?iso-8859-1?Q?F5U3HQwhL2Svom/yM/yOiQ8LDWjbZUMh2IYnCOgRpAIsoVIk927Aeek+0s?=
 =?iso-8859-1?Q?SyAcmkPQ79PePzuA5UydDnDUiTquvlctUykmw7NJlb0ZzIK6M9Ylp5GAmu?=
 =?iso-8859-1?Q?pkI8vNosoV1Vuxh9y9+uf9zeRdwBWEmKNIwFZ8lMgPScbQtlf9LKDgK9Gt?=
 =?iso-8859-1?Q?1PF4Wszpi1Cq0XtiOauxdYRDYTB2sguF3D3vdDL+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v05dNESvE4hhqz7VFqUiTfcf4u2Jx6j3ESRSLQR6yX+FBjCn+uixQtw/RP?=
 =?iso-8859-1?Q?HY9pFVnRUVYhXUONGKH7fHfXi4XImdnKC59SwCIemZ7kAfjFs+LVXFEXYa?=
 =?iso-8859-1?Q?j06c/IpUD/hR2GXVtmEsxh7kpgW/vxYtrAire7b1YBtOFm15N8LcX0P9Q1?=
 =?iso-8859-1?Q?Ggc6MNnouJKX/HUACiS7+IfDq6j6Ff/CebtbgsHaK/uYbc7qLdQ8cVLRqD?=
 =?iso-8859-1?Q?svCkW3mVmV4IKBp6aHPm6U9rUU8MTYZfKNdtmoqtXyP244WGb9dHGTXa2f?=
 =?iso-8859-1?Q?lIs2DL0mUlRq4Pl8pFYgSLWw3y8StxJh4fsze0aDNaqKUjyuWNh+LdDx7p?=
 =?iso-8859-1?Q?STB9ugB8aaEv0PCfs1nR2rs1ftGAFAdljrP9aXuQh7GsCC6C5MT7CV7bQ9?=
 =?iso-8859-1?Q?gL3oNPnJcfUVzLgtGxqT6dqpJoaoqc8zZohp0dtkXzfHKuKdF5Q3uwbeNN?=
 =?iso-8859-1?Q?ZZM+ddmiRtpuhx07hSGh6jR8TVdDxLWjfX7sYba9L8tEmAmRtPgfNZmmav?=
 =?iso-8859-1?Q?A29xrg8ryEWT118OSpAjQ4x6UQfyfJvEP6CYZFZTOaKqANB8IVvMIj+kLA?=
 =?iso-8859-1?Q?lWhQyL2PFs/pALlNvMBxYxgcw51AMk2D+1o2NFk8LWRw3Jb3sKbSMjcRgr?=
 =?iso-8859-1?Q?A/KKWh4skf5CyQwX9gd1Wo2JOkL/uDh0I+HRZfyfLlAQ9zlSbUkRLbvG/D?=
 =?iso-8859-1?Q?5Z+qJD58Jj9eJ2ZIUDJl1vOmBS+AJshPj2tx1KGv8XDVNPwi3V3Aeiy3Pk?=
 =?iso-8859-1?Q?pwDlDOjzd/ZBa4p8YReBM7P4rOVnd/tzZGtvYzGHNBTcoD42QUFtE3cNNi?=
 =?iso-8859-1?Q?2v21xjYGzky5hUbgfXPaDuIHoxVaLn5PoTZSM54ZwSooanQ8n8xohPt13P?=
 =?iso-8859-1?Q?KORYKv/Nwn5ZOY/fbk3K9z00hi0E9bdxvqmttKcN27h4kQXZS5NepZKJbN?=
 =?iso-8859-1?Q?es6vcgX+b0r5oq2eB+BthoZJnAO/LYBn3YW0icWcdAXahQiyummRIv/adJ?=
 =?iso-8859-1?Q?B97UgeNJFgDkPGVBvFfDBeSJXKpWDNRMsHwuWgzIgHI1AJkHAbantS1NF4?=
 =?iso-8859-1?Q?rx7+c71f8uYJTz9a6nRwH/3x0SrL1iLeY/uNMXYE2LOgsrrPvwttX5DBQd?=
 =?iso-8859-1?Q?pUAOpmBnZCFZayEQRHFLlmSKdH32l15VqZ6I8PgGW1cX6Kqm590jG8YiQl?=
 =?iso-8859-1?Q?b21ejjTH1WXK07LJKHkYohBJ+lRqKzhry9gLgH4W1eD4uHansfbg3qBiEs?=
 =?iso-8859-1?Q?VGZ3dZH5G0e3vnFMTvf2m61N2NgkKBd1s5eiFaW4GX4IJMeOpmkCbz46x1?=
 =?iso-8859-1?Q?EMV2VYFItuijONgyFA7wMF/YDCrlsfsiRYbL6DjWUglzFEMsbSzcn0pfuC?=
 =?iso-8859-1?Q?lXuOmsYRNjYcIX5teAEBvCSQgXzKpviYEGvDgH6VKI5VydSV4QbE6/mc9I?=
 =?iso-8859-1?Q?N9ejVOeobeMAo8q05o2e2yx1LGMv0X3VMR0f3aqx0BjLWN0yHNSczY0C0C?=
 =?iso-8859-1?Q?qO8fPG3oFJAdc+V0sRqZFw9F6OsoIUB6s1VelKLFmBlKkB+B+SudgK8lvv?=
 =?iso-8859-1?Q?Dce0rRYrrpk7uJdcDNaEGCrWVGg5IAYsFcs2VTKGM6CX0uLm8wtla46fSQ?=
 =?iso-8859-1?Q?59H3SknBmE506vs51OrZqyvu8Edk0eBiRe+8xBwpAxgGgm4WJXmPWdPH6p?=
 =?iso-8859-1?Q?CbY1vZKrxFo+AeR0rOZpUTSWHDLIPOQen5OWJe6U8COboy4HZ1fsvcN5a5?=
 =?iso-8859-1?Q?+D/iR6RmdrOxgGjVlaypZXYeTklL1kGMRLDsAM58Ib6s9/Bb8IHYWOLF47?=
 =?iso-8859-1?Q?QYalPTKx6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66c28b-cdc0-40c9-b88d-08de7366ad0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:35.9927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdKHMdwH2zNVsKOMCjkLmbi7vh4aFk9JU4J9ZGPFLcjgIWpIhGcJkXtRUSIsncPmcNAjhlrw1VQS9V3vlQnPVQKlzi/U3jlAg6+AbJ2C9gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Adds functionality to the CTRL register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 35 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 832fcf326a..b6ec0d9579 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s);=0A=
+=0A=
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
 {=0A=
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uin=
t8_t *data,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /*=0A=
+     * If the user is setting I3C_RESUME, the controller was halted.=0A=
+     * Try and resume execution and leave the bit cleared.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);=0A=
+    }=0A=
+    /*=0A=
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP i=
s=0A=
+     * sent.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/true);=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    /* Update present state. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+=0A=
+    s->regs[R_DEVICE_CTRL] =3D val;=0A=
+}=0A=
+=0A=
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
 {=0A=
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       "] =3D 0x%08" PRIx64 "\n",=0A=
                       __func__, offset, value);=0A=
         break;=0A=
+    case R_DEVICE_CTRL:=0A=
+        dw_i3c_ctrl_w(s, val32);=0A=
+        break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
         dw_i3c_push_tx(s, val32);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

