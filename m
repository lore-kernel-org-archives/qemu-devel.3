Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B07E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e4-0003Pn-Jt; Mon, 02 Feb 2026 20:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dr-0003My-Ei; Mon, 02 Feb 2026 20:55:49 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5do-0007rl-Fu; Mon, 02 Feb 2026 20:55:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6T9owPh9b4VVWZb9cKj7qJ4tIO3t/kEr+Rq4tRVWrIwrZq2kW/HSmFApoYv+UK95HBp6rIWPVVpWf3CDju/9FxJoLjO2lC4cYFeLB7ntd2oLFE/1sFwKpdpfC8ywLBUWFfronlaeutY5xCck5ts+IKt0mLGaCrxnjfeSphZyWDp21Lt6UBq1cbpEaEsxog8ZStxyLdO06/2VgEyDLFufaEVI3yH4vqx5UB+Ye0NfU9GchdUDYBgBNGqt7sJ8jiGD7qTS3gYvOb+7R0DTVHN1+3zLioVmGJhy6Cnl+uOhYdd0AHUDds0i4hpO1G0GUdld42QLLVnoji0a9JIglgtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2bn3kb5AsBaUA8sUSrGRiOTfpk1UMP3IpqXzhO/z4c=;
 b=aclhaHA5kDTO7nl9iD7wrRRgw4+ZRjrsHCETQwuaJKOjYEkXZvxbf+6egxYqr2kVRkIeiMBNBCtR027abbGwR94WY8rCdEYbmm4GjXCEVE10/axxOCsP7oh1TA+VYDit7LS+dPDQMzqtgfSP0LysFJl0UVp0W4x0lGCcrbmqY1g7WWU4YjnxjPr83Sjm34YXGRCcT2HRWMnOYQarG1P/7keB9hxtg++5BhoFQX9yYTNvJL6+ymm3lbDrqlp/m7jgkHD5NQKn5d2BODoLVUq1wS3gjnx5iC91NqSJdSOFRy44bW1zSmMn1N7C9ZhUmuUzwAtu4bU3OJC62ahJYjCsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2bn3kb5AsBaUA8sUSrGRiOTfpk1UMP3IpqXzhO/z4c=;
 b=MqdZF6vDtMcsytUpmdBvGBKA/Nx31XVtnBYXaxIG0Z334P+GJQer2dlsl1+snv/ILLPY501PHtvv/nU59ExqiruISIZskqdOC0N+THv7nUXWiHRGAo5D7GmUwevLTUKIOzC5H11mN+wAXz5TI+q7MjDzeiVtrwYpMTi0YNteIoenDAHPy7H3nBGKiR5F0UXC3WvwnXFoC0jUar+wakfN9YqCJtRy7AvfdxP/iGsEZfGEe54FUbr0knFtu9R+twFBS7FSuhDdKjPa3OgG4ZSV/LR3qT7Z0ijFCMEV5Owgy5I9RwAMDwiUnRfwDwmJPcUnbc5qOxqaooyvV0I3C1NxeQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 4/8] hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect
 address
Thread-Topic: [PATCH v2 4/8] hw/i2c/aspeed_i2c: Fix DMA moving data into
 incorrect address
Thread-Index: AQHclLAu/DjHnmJp1kqRDF/3APHKdg==
Date: Tue, 3 Feb 2026 01:55:33 +0000
Message-ID: <TYPPR06MB8206B8720FBC5ED9056DD561FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: e1557235-a291-4ebc-0698-08de62c75176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eNEW23kVkfTIGh8GwsWMKHf0DJQTA0AWN89FNIsLPP51uRZlsWxZ+rrSfntN?=
 =?us-ascii?Q?RT7WkHKb4yn0fhf/j91OfwYNcflUVK+qSGAWojnUtJYkmNtfKUUHRQ8H98r9?=
 =?us-ascii?Q?olQgWSKZ7x97y88s4aQrj6EDC20xQ7hgaXQ4XQBpMy8oU/MSUG4WJJbsFszX?=
 =?us-ascii?Q?bDl5XvhRVJYZU3HMzO/P/DnEfBQkc5wRrV6exgr4gLkZWhED693xHSzvJMCj?=
 =?us-ascii?Q?R8MpeOBQyBrDE1wHl9osWmLc6fZpPzjFbISMJwNYCx5xVVZo9ORTwqqMJ5Gz?=
 =?us-ascii?Q?1dT19rW3/uCTjYd3wUkaGXBbAB2gA9vJIux+1OFE5FGMQ4ifs0QltyTpcyH8?=
 =?us-ascii?Q?41efzpwVVxmBqogzCYtgYMnVjgME3NQn7H/gmzXidrQtSgp3iI0LDMSFUDh8?=
 =?us-ascii?Q?hJZV2At8jYoI5rdnGgx/S6T3GeRpRUD4MrsO2ybsRfguKce0AXBJHr9sLa0l?=
 =?us-ascii?Q?FKh9o7U4heXeJ6xkA1jGHsWyswcN5XgB00qOJiN0LhDOEX9TJcIv4yUCXFJw?=
 =?us-ascii?Q?ABP3tIbCYHaUAFxXhIkEA1FD+NuMEdW0Xj4e/MtQg7zqC6THFwIXyqGca75D?=
 =?us-ascii?Q?xt37CF5oeymQVajO4i350bH8jnKdibSKgLp0th96B8O8DUsg76eYa2ITsvwp?=
 =?us-ascii?Q?kOqTkTRETaamwLn6bJbcRxA5P3QtjvHR0KqwTEqJUhfsX603lC1PAd2U0L09?=
 =?us-ascii?Q?RN/p3142Nz940kx4Gx39teWxn5d1ppmQj4nlJagBbdBQE5MgGGzHu6ZX9VI4?=
 =?us-ascii?Q?uJfYiyJ8u9l58dHZe6fOe3KJmKz5IPqcEaM313H1E/O6YGEEkQ4Sl6A66GKe?=
 =?us-ascii?Q?c2q/fgf5hcpPVhq35XAVLyM0fgIxv4nwudLRfOdCU/IAbKVSqoYE6MKa4uCK?=
 =?us-ascii?Q?AXqyB7u1DL9I2LJg/j29pawWR7kfnGq8lGPqRoMfFcmX0SAhmH6FwZUd8238?=
 =?us-ascii?Q?JV1QQngYD3Mfd7fFVCYqpp20UWXHoNHEXRoAV9CCXyBNrDgHOzyimCOgyn4B?=
 =?us-ascii?Q?VP+NxzOyPaBOyleQG5IYkHugUkQ0qTwNFeIntnRreFzq7lsurF41rAnhdbE3?=
 =?us-ascii?Q?5hr946D4xPoW6YQ/mDtZj2sDmDfKnDmmtQ4+p2u2by2phcSqz2uVi0vBUwMm?=
 =?us-ascii?Q?ChkQdQm8LLHaE9antrwN70u8w/+7qqjpRmVglm3DX7pnb39cS/cNkfZHskTY?=
 =?us-ascii?Q?2Exb8J9jceVE44isscSEKCNblWbihosyyYp4Oki/OXha8DJ74PSjoB/dWsQV?=
 =?us-ascii?Q?wIeDncpPzo2WjB7qi9r7hue04qf/Y4zXbreTtXWOC/VWbFtl36MPK2MWtK+Q?=
 =?us-ascii?Q?yIrRcIx7AJsgE/zL2NniitnzXbQZ6zAcHAM6qGI2J0pniOUb1y2CFQxwj/SJ?=
 =?us-ascii?Q?JN5MMGWO2pcD8LgTRmK/IkwXc5qW2pBNxSy94NP4Ne7mvsF1nIeYDMhsfNhW?=
 =?us-ascii?Q?9/qAn5yjz+cCy9gafj2H3HJQuUnWrYDQtyyb0zlqDBC/kVxKmiodRMmdbDLH?=
 =?us-ascii?Q?I8x7uK/TnM3UCyyM1z2KgTAw8SfZhMkdtPov5bGexo9xfMUsnTBO++XBGjYb?=
 =?us-ascii?Q?l4A85kk/yoamhZVz9KBoV3fhk33D+2s5ePwlCadfioTYWlYWGyhf/x130Y1c?=
 =?us-ascii?Q?7m0Lb7MXyQft2Q5QrlyH5TM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KO+4nWQ0aghAFLPcLf4pwcQ8laY4M2s1a/YPxbBZIu1wDMqZhOn5+ao/WmtF?=
 =?us-ascii?Q?I2vzQ4LYs8jAIIowHmOmsNUjXIS+Nq9NJdqqYht8cPkqqHrAGC2YJwDCghkQ?=
 =?us-ascii?Q?eoCijv0JORid+7Hn+ELDM0+9u2JRVSC7Hhz2cJjx/+X0e31pUaBtfWUy9o+A?=
 =?us-ascii?Q?R9xQF9o2Eg/mv5QVNJDr27otM35DBWIlV3d6vgpDcD9eFypHhILeNdjyq7Sy?=
 =?us-ascii?Q?Kv04OxjtBhQLaKKcipceg7fVdN8XSRwaVKbbElW+1+RNgBX9EKF3PqML7CuE?=
 =?us-ascii?Q?7j4Dc1qc/SFgdymdnbm6xxm3ED6rNYSzdpSUnYt+IcPHBJsfglwFyixbdgsA?=
 =?us-ascii?Q?I7GvXaPWWrnefnF4Q6eZLkghjoVEb3sW8J0qrpS6CKbfGsIC/t6A1MI4dR4F?=
 =?us-ascii?Q?S9/rJF/3tjC3Moi07PCatuo8VoXbx6D3BY9RLZliwOZDZg+ayNILiUGg5BxG?=
 =?us-ascii?Q?0b58B1FEc//0VFnaVSBLq6SwWk02yMXXKQ/ioK1Y6xK2hXum+9HC3vl8DtwW?=
 =?us-ascii?Q?hMhVhwD2GNAvledtDcCeAA+AXshlvmYW3GXtOWcuQvfaeS7xVz+aO3ADcd7L?=
 =?us-ascii?Q?dIjsqmByx5nB3ZvHgvcgJZD4O10CGUvMHaxkqzPzGGzIs4cjgBa2EAeVQ3gT?=
 =?us-ascii?Q?FIglMggEDXr9Z+CLEO0U6gNGQeAPBO8appYrTLLmKmJWTWVJL1iiY4J/gytq?=
 =?us-ascii?Q?fX450EmzeB1HUTDBVtL0AU6hjRKGWvI59vO3GZcJqRvQbqzn6YY6Cp0Ktmis?=
 =?us-ascii?Q?pY6C4fsgSogBKiwNfjozC2lOt2yhocrTm/xiM2hhAyhPPerl4cwbAv2BZQEt?=
 =?us-ascii?Q?N/u06qDiWwkANV/KsvWtrlpHcMYMO674AjAajwT5/dBNww01i+imgguJG9rW?=
 =?us-ascii?Q?46c10Wljd8QqpPrTLGNxDEm7YrSKeqg7og6TBwy3e+pp7XdERLW0w+JWvI9O?=
 =?us-ascii?Q?AnhVN9OC4x5apkYHgoakyQY19+nf6bs9wTFDXxajCxqSiUy705CgQAt7h9lP?=
 =?us-ascii?Q?CYCt3E9GiIS77qsZaX0yR7imo0W1jTzdouUBpPEFS533DEMh3wxwiO2NvXNB?=
 =?us-ascii?Q?bVMu5doQMbY3x37wfD2qNrrYYgTkDW+sDLs88AkyU7sdBsCLpDkUU32+WCKm?=
 =?us-ascii?Q?8LFaSlbDPyLJ0z6V930S6NDG5QRvLpE+5F9pL150ximfb79rN9H9wn0YF8Wk?=
 =?us-ascii?Q?wxlsXnFnD87DtzuHt75/IKcVz78yYauoutUuLu24cR3cHUYk6Lfikfn2Ek2s?=
 =?us-ascii?Q?Ky3uDBX5Jl1+KQMlFlEO9y+/epALSjoN+kFqn6tHFEoLIfvFCiJTehYkV2by?=
 =?us-ascii?Q?drtZadB6juI1PE9BKkvPAiEUP9Qisd7rP25kgHI5bGUCNlJJbJOtKHCNa7Kj?=
 =?us-ascii?Q?PcbN1w4OtBz8Xq11+kuU7Y3gIR7eZeekiu/J/lQkWHHXGgutTSYBZhrC6CvU?=
 =?us-ascii?Q?SWG4KoeHfNbSggyEH/ekZr7t4DZToQ14ifhMPvbgT4POrOqEit0xKArV+lop?=
 =?us-ascii?Q?fA/4s9rMCeq+4igTgYm+51/RH8cXp/VFhIdqHobMc3iXpxGFidEE9GIv4sh9?=
 =?us-ascii?Q?oRdkPHNpQS9O2dYKIiMOL6EHWtxR675BQc8VWrlpX308sQ0J9Sxd8g6erFY/?=
 =?us-ascii?Q?HuOKIQ9d8bJUT7dnprI2vFc0fLO7hlnH1KSNQ+DlzHb0OqLt0meVk54/yjs6?=
 =?us-ascii?Q?SMBjSgcGfmJNMTGt5LFivM/JQfzM7hr/XCAaNKwR6VbI/BkOevtFv/oAQpzy?=
 =?us-ascii?Q?ZKais1BTew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1557235-a291-4ebc-0698-08de62c75176
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:33.6795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOYt6XVZNL4BzLnrxqIsvhwj/bE502qIA9jnqAozg+qBYyc692YWHS5wl4fc1VBSUBE5LGI6suMzMQRC+xV0zg3g/2hlVkCPRiQg5ZYrWc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
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

In the previous design, the I2C model updated dma_dram_offset only when=0A=
firmware programmed the RX/TX DMA buffer address registers. The firmware=0A=
used to rewrite these registers before issuing each DMA command.=0A=
=0A=
The firmware driver behavior has changed to program the DMA address=0A=
registers only once during I2C initialization. As a result, the I2C model=
=0A=
no longer refreshes dma_dram_offset, causing DMA to move data into an=0A=
incorrect DRAM address.=0A=
=0A=
Fix this by introducing helper functions to update dma_dram_offset from=0A=
the DMA address registers, and invoke them right before handling TX/RX=0A=
DMA operations. This guarantees DMA always uses the correct buffer=0A=
address even if the registers are programmed only once.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Fixes: c400c38854017eeccda63115814eba4c3ef2b51f ("hw/i2c/aspeed: Introduce =
a new dma_dram_offset attribute in AspeedI2Cbus")=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 87 +++++++++++++++++++++++++++++++--------------=0A=
 1 file changed, 61 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 1ee73a8f5e..fb3d6a5600 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -116,8 +116,6 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
             value =3D -1;=0A=
             break;=0A=
         }=0A=
-=0A=
-        value =3D extract64(bus->dma_dram_offset, 0, 32);=0A=
         break;=0A=
     case A_I2CD_DMA_LEN:=0A=
         if (!aic->has_dma) {=0A=
@@ -221,6 +219,64 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)=
=0A=
     return SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_CMD, TX_STATE);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The AST2700 support the maximum DRAM size is 8 GB.=0A=
+ * The DRAM offset range is from 0x0_0000_0000 to=0A=
+ * 0x1_FFFF_FFFF and it is enough to use bits [33:0]=0A=
+ * saving the dram offset.=0A=
+ * Therefore, save the high part physical address bit[1:0]=0A=
+ * of Tx/Rx buffer address as dma_dram_offset bit[33:32].=0A=
+ */=0A=
+static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t value;=0A=
+=0A=
+    assert(aic->has_dma);=0A=
+=0A=
+    if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
+        value =3D bus->regs[R_I2CM_DMA_TX_ADDR];=0A=
+        bus->dma_dram_offset =3D=0A=
+            deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
+        if (!aic->has_dma64) {=0A=
+            value =3D bus->regs[R_I2CM_DMA_TX_ADDR_HI];=0A=
+            bus->dma_dram_offset =3D=0A=
+                deposit64(bus->dma_dram_offset, 32, 32,=0A=
+                          extract32(value, 0, 2));=0A=
+        }=0A=
+    } else {=0A=
+        value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
+        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                                         value & 0x3ffffffc);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2CBus *bus)=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t value;=0A=
+=0A=
+    assert(aic->has_dma);=0A=
+=0A=
+    if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
+        value =3D bus->regs[R_I2CM_DMA_RX_ADDR];=0A=
+        bus->dma_dram_offset =3D=0A=
+            deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
+        if (!aic->has_dma64) {=0A=
+            value =3D bus->regs[R_I2CM_DMA_RX_ADDR_HI];=0A=
+            bus->dma_dram_offset =3D=0A=
+                deposit64(bus->dma_dram_offset, 32, 32,=0A=
+                          extract32(value, 0, 2));=0A=
+        }=0A=
+    } else {=0A=
+        value =3D bus->regs[R_I2CD_DMA_ADDR];=0A=
+        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
+                                         value & 0x3ffffffc);=0A=
+    }=0A=
+}=0A=
+=0A=
 static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)=0A=
 {=0A=
     MemTxResult result;=0A=
@@ -270,6 +326,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)=0A=
         if (aspeed_i2c_is_new_mode(bus->controller)) {=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);=0A=
         }=0A=
+        aspeed_i2c_set_tx_dma_dram_offset(bus);=0A=
         while (bus->regs[reg_dma_len]) {=0A=
             uint8_t data;=0A=
             ret =3D aspeed_i2c_dma_read(bus, &data);=0A=
@@ -335,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);=0A=
         }=0A=
 =0A=
+        aspeed_i2c_set_rx_dma_dram_offset(bus);=0A=
         while (bus->regs[reg_dma_len]) {=0A=
             MemTxResult result;=0A=
 =0A=
@@ -401,6 +459,7 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)=
=0A=
     } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {=
=0A=
         uint8_t data;=0A=
 =0A=
+        aspeed_i2c_set_tx_dma_dram_offset(bus);=0A=
         aspeed_i2c_dma_read(bus, &data);=0A=
         return data;=0A=
     } else {=0A=
@@ -657,16 +716,10 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bu=
s, hwaddr offset,=0A=
     case A_I2CM_DMA_TX_ADDR:=0A=
         bus->regs[R_I2CM_DMA_TX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_TX_AD=
DR,=0A=
                                                    ADDR);=0A=
-        bus->dma_dram_offset =3D=0A=
-            deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
         break;=0A=
     case A_I2CM_DMA_RX_ADDR:=0A=
         bus->regs[R_I2CM_DMA_RX_ADDR] =3D FIELD_EX32(value, I2CM_DMA_RX_AD=
DR,=0A=
                                                    ADDR);=0A=
-        bus->dma_dram_offset =3D=0A=
-            deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                      FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
         break;=0A=
     case A_I2CM_DMA_LEN:=0A=
         w1t =3D FIELD_EX32(value, I2CM_DMA_LEN, RX_BUF_LEN_W1T) ||=0A=
@@ -748,15 +801,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus=
, hwaddr offset,=0A=
         qemu_log_mask(LOG_UNIMP, "%s: Slave mode DMA TX is not implemented=
\n",=0A=
                       __func__);=0A=
         break;=0A=
-=0A=
-    /*=0A=
-     * The AST2700 support the maximum DRAM size is 8 GB.=0A=
-     * The DRAM offset range is from 0x0_0000_0000 to=0A=
-     * 0x1_FFFF_FFFF and it is enough to use bits [33:0]=0A=
-     * saving the dram offset.=0A=
-     * Therefore, save the high part physical address bit[1:0]=0A=
-     * of Tx/Rx buffer address as dma_dram_offset bit[33:32].=0A=
-     */=0A=
     case A_I2CM_DMA_TX_ADDR_HI:=0A=
         if (!aic->has_dma64) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",=
=0A=
@@ -766,8 +810,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CM_DMA_TX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CM_DMA_TX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     case A_I2CM_DMA_RX_ADDR_HI:=0A=
         if (!aic->has_dma64) {=0A=
@@ -778,8 +820,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CM_DMA_RX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CM_DMA_RX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     case A_I2CS_DMA_TX_ADDR_HI:=0A=
         qemu_log_mask(LOG_UNIMP,=0A=
@@ -795,8 +835,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
         bus->regs[R_I2CS_DMA_RX_ADDR_HI] =3D FIELD_EX32(value,=0A=
                                                       I2CS_DMA_RX_ADDR_HI,=
=0A=
                                                       ADDR_HI);=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 32, 32,=
=0A=
-                                         extract32(value, 0, 2));=0A=
         break;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\=
n",=0A=
@@ -887,9 +925,6 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus,=
 hwaddr offset,=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func=
__);=0A=
             break;=0A=
         }=0A=
-=0A=
-        bus->dma_dram_offset =3D deposit64(bus->dma_dram_offset, 0, 32,=0A=
-                                         value & 0x3ffffffc);=0A=
         break;=0A=
 =0A=
     case A_I2CD_DMA_LEN:=0A=
-- =0A=
2.43.0=0A=

