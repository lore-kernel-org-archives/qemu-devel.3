Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F38EB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq2hT-0005uB-7U; Wed, 11 Feb 2026 00:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vq2hS-0005ts-85; Wed, 11 Feb 2026 00:23:42 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vq2hQ-00057N-Mp; Wed, 11 Feb 2026 00:23:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ5KNtOuR3hMwwNW1b/YIxA9mBp64yeMYtBTP+w7uEUKPtsW3Q/MQH2fsEumQi2r/wKuEINyMu7Hn+EpdWWR2voCW2ifXmkg/7hQNlUtcxnsSuMNbEA302tFsV5cw3GZm6rLCIjHvBSVaPKP1vSrVG1JxKPqmTECRbUMkjycRCFXdbTTUHVVO4+C+EDKw22LQvtsQS2TmdBrj89U9yWxCoF4TFCDksQHCScxgIhPyQrhOZgwy1ZpuQvoN+0DljS0J3oH/Qjq1zOJKi8GEcUbBnkcCEahJfLZ/aoVe+b3vNcGdDw7QvqeoR/B5EFk0EitSkxncG39gg4hfXkNfalmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAFWA5r3AeR2Rf0Aq7wsOaxr5/qvhnT8JXN2yZjHtWA=;
 b=Hy6gN5/oc8RxY0/ESwnlTZwNG03cNmg7e/whr51sM+8SLnBvIf4FWerQz8fQNSOiVYPLmXqDiN9y0j7BpTbDTCod/xXZ78U/cOVDqGkf7un5VyYCLNFV3vYpcyxx7lrAlSqfUH/kviIgf54a+h1/ozptWlNDKzTOnWLZjq4qwWNsY0FF21JT8T/KLqeD9qRE2wan9vaomIqygW1MpwL3rwgwsJ1Zuar3yROTd+PHCWHV7ckGuw/uv0SGXeywDdWQd4PISg8DDcKXeF7K4L12SHTzZ+GrfG9MvI4WY/A+AS5NYL5kS/b1J83IftrNgeEKgOiHXc+d9CID/fIPIbkXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAFWA5r3AeR2Rf0Aq7wsOaxr5/qvhnT8JXN2yZjHtWA=;
 b=ZqCCkgBQ3ddRgA2LJwDKKw9ggKyY9KUE3JKt+Yb7sRVwYuotJvoGJGvwaeZMPwTfdfAmam+oV5kJxlawD6mzhJcPIuS6BJRrZby1oD63LJMluCmFV9oq/5y5TtuG5ZLy2Ztpb59JGpkjrCEylY1troohmxyYzYx9dbyz/df+VqPir07pCq6834wPhdvvAWuym3h6imOCr+IJUfNfB8RH2fdPLQs9JxOX5K6WwJJV398WIZRTFY9Ai3KzeWTCpY77MbuC9iSQvYxeLhrgUp0nOxn6ajBvoNrRTxz9ra8L/1xxKWRE2YUL9GVLLzE/3eeZZS/PrPSGr3K0NWhHSwd3lw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY1PPFDE013D005.apcprd06.prod.outlook.com (2603:1096:408::92b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 05:23:28 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 05:23:28 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Thread-Topic: [PATCH v3 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
Thread-Index: AQHcmxaN6ahmDe7SEESlwP6gLrYq4g==
Date: Wed, 11 Feb 2026 05:23:28 +0000
Message-ID: <20260211052326.430475-2-kane_chen@aspeedtech.com>
References: <20260211052326.430475-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260211052326.430475-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY1PPFDE013D005:EE_
x-ms-office365-filtering-correlation-id: ff86bbd4-d505-476d-7538-08de692db043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?38kwvkQHYLJnIOJq0hk0XaW/aCVKhL3n5k/QD2xWYnlnhGODy3++r1LR8E?=
 =?iso-8859-1?Q?O1h1fUJU+0D1IlxxlxrjKk0YugEKGXctaX19aev0APw2k0f4TIOv+fLpZF?=
 =?iso-8859-1?Q?iTapjMXb7SuQ1rYC98p310s/7y5LSSteR3/ATmFNf2+IlinW64qgygli/1?=
 =?iso-8859-1?Q?Sk4qyRbRjzjFPVD9VRxvWfIH3Lc+RkABG+o/rnxjgQ85Lf8nukj9Ugc8JL?=
 =?iso-8859-1?Q?EUUD329HxQVolnx+0fdRhf41QeksxnF3aop3OLljhfmToW17tOpf73Ghy2?=
 =?iso-8859-1?Q?Vm/hXYLP87ZZ3DhepGnKvEhge6qgIe0vZdeu0ZhE4LjXUXXGa6CS4qzavg?=
 =?iso-8859-1?Q?zxgkGiU162gkkr3pl8BPrKJVAnoUkixm/1Edunv/OhzdXAtTJlwc9UjZ2T?=
 =?iso-8859-1?Q?JNveM55coqPuK5qnoQnKYmKD+JVA28FEqkziav7H8gz65LeiL8p7lTamvs?=
 =?iso-8859-1?Q?oplyHMjsEDSK9KtuDQLFMnRG+W9ContUUZtRvc/HKrLPFPh4Zv/RmNvmjk?=
 =?iso-8859-1?Q?aNn7ADesKSEXd4affBKpMFPY1o3ThER1DyE53jS0lqZZxzLFUQ4kytS+PP?=
 =?iso-8859-1?Q?d5jV093uU3w5UqTSbo/AwIR1XWV0b7VOosDjLLJSOWQUJk24fmnL9jdJY9?=
 =?iso-8859-1?Q?f7bbnTczpLjThUaKqgjQE6MFM+AVuiOsKXNe8bln/ud/tKq4st15/K57Sa?=
 =?iso-8859-1?Q?T2RPGF1KwAyvsTK7R5zYStwUpomNqebnsfkYLChClhsC5BL6IMyqZEmkJn?=
 =?iso-8859-1?Q?3PkJ1/lenTS8uqM+CPRUsJJV65gDIayUWKgf7JtGqf+k14MLJ7Ib7Qgs/4?=
 =?iso-8859-1?Q?V8c5803LriCrZyex7UGV+WJmmI5fQuCuruoVX60fWM23mDWkZAf3mewLpu?=
 =?iso-8859-1?Q?XE6tGbNRSNIPgvTHxpG8B88Pke3ij0IQn6t40Rs9SrEheODcA9JKVmC8++?=
 =?iso-8859-1?Q?+S8kesI6NU+sAa6oFSuiJzvkXkXF/ALWVp8BybNyfqYqgXtox9CTme/YWt?=
 =?iso-8859-1?Q?Y2QvJ4kyby8GJG1pNAmpIgNkwstsc1oIaruksUKShk9GX//mMz+XghUYgi?=
 =?iso-8859-1?Q?RnlCrG3MolXw79Zb4JaTGDmgCdleTJ3X/S28ql833l3H42z/UsXqnltKUJ?=
 =?iso-8859-1?Q?ue3+Kwhg/MS0PG6HJyrugZqglqr/6OWqTYyu4OxHx++iSRRd4kdpJ/f567?=
 =?iso-8859-1?Q?LMDr0IMW+7h1TYc6BNOwZes9OGKP8Sc5bQIchjaoRvORXcUzdcX2pKYrkL?=
 =?iso-8859-1?Q?cNKKJMOH8YJpVspOkVD6X0WI/0uj+ZNIt/CpuagCk8sHgLVS7W4QnBto+L?=
 =?iso-8859-1?Q?dT3EVEWlUBjtRc0BXFyDO130HIPRcVZKB8lhp/k5dUDUh5MjJnvZlyGIIm?=
 =?iso-8859-1?Q?jGSGCD/YmeqAJpRhJkfeYVrxRDhfGxy6phawJMUshVNdnPxeM0g2J2cmhy?=
 =?iso-8859-1?Q?cOc3xNYwrFCJfLwvwFkv07huxmivSv48I1Q3afsZGQV0qRuRow9+QmTHeB?=
 =?iso-8859-1?Q?s84gDJYW0XWx8pE4cvYoJzyGixA5sV/0SqFY+/mBWfCoAEoIIvP9kq05vs?=
 =?iso-8859-1?Q?1zxPjb1C6gY9wbJd0fwV1CHYb7UdOXD3sMmKZozKVcAGJwQMj20ujqqBcJ?=
 =?iso-8859-1?Q?9hP5/FQeHeWAlR8QsEWJtz9AMTrXKs7iOsYzLsP7l8Z90+YpsWryVpGPLj?=
 =?iso-8859-1?Q?g+vXgMT8zD8PXBfEt00=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lbg8QZI8I+0837sE0/w9QULDUyXgI/7BcU8Tm08eyZt6b0OrEU8M8LQXCJ?=
 =?iso-8859-1?Q?QEPgKWvOR/OdKng7gzrIdaEVONkvkKvAQ1jAjR3TQhZjORQ5/sIe8xZoe2?=
 =?iso-8859-1?Q?oMRSakIw3IG9+qObW3vtN5hoU3KW/xvgkt3FVCqfam+nFviZXHrdtjhdEp?=
 =?iso-8859-1?Q?fgquh2xV6AupnaOJwBkbQ6BlH+mIATwTjwfzdOoO0sLtAvQLYX18U6w5mw?=
 =?iso-8859-1?Q?TXdEHRQ+I5ManomJzX/8soVy07Im9PoMpdT88UIdIBGO0Lyy648keiB772?=
 =?iso-8859-1?Q?4XJWKwii7BbeqpasmLt5EZZs6S2952vPrMQuDvVnv3sxT4jSAhUB28Gzfr?=
 =?iso-8859-1?Q?LGWV4chqeog9rqD97PYUPE79SlJPbEx1UhQX9DdStPxImI7cFyxzB0mXAr?=
 =?iso-8859-1?Q?Jkq8sqUzkM5gpIgmHpHGmEZ4BvRxmtF+wnobmQMiX3DIGlRj9o0HZ/opK/?=
 =?iso-8859-1?Q?Lk2cFT+DrQ/YwNprST8CcbnEbQ4fscuoPE772nT2oCSIs32iVWAsFasDft?=
 =?iso-8859-1?Q?6G3THAlHdJycA0XX11heVuvSvCjXi+IJtno877jHUR1vFMumSKHTtCfokX?=
 =?iso-8859-1?Q?VG+wmeKjtjV+7nUIwEaOPEzAQNfHw16XtZ0XqKOTSJJXYhQe5O2lGHzEHT?=
 =?iso-8859-1?Q?NeezfALtLuRXDuWQMs9DS07MwnkLkPI7xKy3xDjRaEtXwbcjv6aQ7Jg3Q2?=
 =?iso-8859-1?Q?hklb4mKmBKOjB/vZc7I2k8ToK2Rnr79QiaIjo2fS5HH6DURkOQjqB9Rge4?=
 =?iso-8859-1?Q?RK1wwB3cbwy6cLBzOgrvrfQNW08mNt2bVo2ULWdehsnx0B7iFno9lzGY1o?=
 =?iso-8859-1?Q?hKEdmdr5w1Q3su+N3sYudZNZnDFP7x/AfprDVxhEd0jTlNuxv/zgxzGXYB?=
 =?iso-8859-1?Q?xDBv2ylTS2ucoblVGOmSCU25HqSJ70bRGA+OqMzPCVuHTJcuDkmpJLJq6O?=
 =?iso-8859-1?Q?kRyV7yFfF6FzOH/YfCPhChnnzBcO/L+sinQ/ntT+MhUdbX7H+mFyUZINzm?=
 =?iso-8859-1?Q?OekrXoMlCPu42FyBhOU46OjFVGHnpKMVDN7mwM8pTNglks3rlQL6wYOyFp?=
 =?iso-8859-1?Q?8hObLosNvOCRsWZPe75sS0fLTrtYzlrrSjmHLsjEYD7dpAHyOGSe8T2sxP?=
 =?iso-8859-1?Q?eUuHN/NO1QWU/72RqqQG7M6B96J25jooB8fDw5d3zfAP/lvU+QpWmJE+fE?=
 =?iso-8859-1?Q?fdXuERq0LhqxGAcsKPT+emcdU0PFGMoQERmeYY77hKznTRAzHiiKUkO3+g?=
 =?iso-8859-1?Q?KjDyjiAbK2IfdCM6BPG1i0fIl3Dvrn3wE7wFmmO+mVB2zV5uq+VMcIfuVo?=
 =?iso-8859-1?Q?hpFnFgA66ImHFvtU84iYwX7CqVMMIB8+iHU5K6tMWPije2+LdNOnkHhufH?=
 =?iso-8859-1?Q?Z8CJzikUzsUh4nGdDzFMAQPvxth6I+UOELg6Qwwf21zXqYS7xcNCg0G11c?=
 =?iso-8859-1?Q?d+ITpviDL2m3DSaGe0NdYQnbqUmW9PMQVVeYMYAEVo61ABrJo+HlW2NhH8?=
 =?iso-8859-1?Q?msG/YlbYxhcsGzWwpAx1M5KZJh3JuF//4NKOu7saryVy52vRY2G0FpdOnd?=
 =?iso-8859-1?Q?xhnFeGrK9s6IrJkxNpUKn5HS0LuhgCEhmjSMiJbqzuWvh+mgaOaFVllUs1?=
 =?iso-8859-1?Q?f+bOHnFRCr556vpBmQRDLZyfOGODjmzDSCE6AnRiJYlxrm4ylV0xtj0XHE?=
 =?iso-8859-1?Q?eTEn6cYnGuGYm3iYZFjfl/4oxqg8BOjdUdVB8guUOvyTS2pS0aahxz1tSu?=
 =?iso-8859-1?Q?xfKpyOm+Tv0nIwCtiACOFETGRYQzA6Rsly04BdIBODJZ5NBTQIJuV4xlxh?=
 =?iso-8859-1?Q?q9YdSJwWfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff86bbd4-d505-476d-7538-08de692db043
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 05:23:28.4236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOh0QX/pgPBFSfvvEYSUGD1o799wvDXKVumXK5xYK+s32cG5Gyrmb8O/LMIL2MuhYd26Ga9oK9ZA1PwT5vO8X7gXUByztOLPjAGfEBQM1wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFDE013D005
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Improve the OTP test script by adding functional verification of OTP=0A=
strap registers. The test now validates that OTP modifications made=0A=
in U-Boot persist through the Linux boot process and survive a=0A=
subsequent reboot.=0A=
=0A=
Key changes:=0A=
- Added interactive console commands for U-Boot and Linux.=0A=
- Implemented verification for OTP register 0x30 across reboots.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index 4066532d5d..31a1c3bed6 100644=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -7,6 +7,8 @@=0A=
 from qemu_test import Asset=0A=
 from aspeed import AspeedTest=0A=
 =0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
+from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
@@ -16,6 +18,7 @@ class AST2600Machine(AspeedTest):=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
+        self.require_netdev('user')=0A=
 =0A=
         image_path =3D self.archive_extract(self.ASSET_SDK_V1100_AST2600)=
=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
@@ -25,9 +28,34 @@ def test_arm_ast2600_otp_blockdev_device(self):=0A=
             "-blockdev", f"driver=3Dfile,filename=3D{otp_img},node-name=3D=
otp",=0A=
             "-global", "aspeed-otp.drive=3Dotp",=0A=
         )=0A=
-        self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default", "image-bmc"))=0A=
-        self.wait_for_console_pattern("ast2600-default login:")=0A=
+        self.vm.add_args('-drive', 'file=3D' +=0A=
+                self.scratch_file("ast2600-default", "image-bmc") +=0A=
+                ',if=3Dmtd,format=3Draw',=0A=
+                '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+        self.vm.launch()=0A=
+=0A=
+        # Set OTP value via uboot command=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot:')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp pb strap  o 0x30 1', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self, 'boot',=0A=
+            "ast2600-default login:")=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc',=0A=
+            'root@ast2600-default:~#')=0A=
+        # Validate OTP value in BMC stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'reboot', 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.51.0=0A=

