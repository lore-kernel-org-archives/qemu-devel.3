Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65748E94625
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdjA-0007n9-Mi; Mon, 09 Feb 2026 21:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj9-0007mr-Cg; Mon, 09 Feb 2026 21:43:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpdj7-000297-QG; Mon, 09 Feb 2026 21:43:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T13zaaBjhiaAgG01QHWuAfT7HSlun+5BlYj5nqeeBuinSaIQX3xtuyYJ3OSrZHzSuVahkCmEUgrH29LXWPpOejUMCU9O6m9OhNYUEvNldN2+YGh2h7E+esP3f2jOFtGb2DOWFJ5lOlE1qlca5+PSTve8fU/RuFmIyIM19UJqa3RdNn+Dd5LHcBlCR/duzliRov3M5ny1LteioKCZUy1xUzE8h6x2gGVMXcs4Xxd1Scwj+2OO0qY8Y1+6ux4D9XFPmDujYLtD7KS9PetzMSE94I3wdMw0bR+BIEjTbLQFz1GEwQ0hfL+YGAYNdy8t98jE/sgh5xrlKz65fmoc/DRQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maa5TNK4qKtDl1z+j0jg8KeSJFq55agfZjuLNgia/wI=;
 b=Tn/8SHnFlxb0Ai03JNtzDrVuOQuM6Ds4GqO3BL6F5wyMf3DMpSO4x2GDf9pnPknkic/Bv4hBP12UQbt/jNpF1wdIiR0zX3R4RTSFmfGkPwqiPdfTo3GUMd6E/wgAxbNYOgQzyuOg5EV2O60J208ZNZR05jyRLLGhL28ARg4o+xlMSNlm86+eQhxx8Kx1EEan2Nl35SyTtZnMA3joPWW2X6s4Vczv3/3pOw3ZV04mp7g9WolZYKUjerkch18uVZ7jSoZGTFZKaIIKNUV7v3L/qEV2Kq9r2OVsNeIpcd4+h+uTnqDeIat9ysYyVmVlNvpT9zA05Gns6C3j8MLSAwMhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maa5TNK4qKtDl1z+j0jg8KeSJFq55agfZjuLNgia/wI=;
 b=Xn8651tsJV7t3n2KDBUmVUmbfSnyxGoSsgjgsPogn0FR16CyjIBRghPSCRMLldxqImb3XcxPwMJlYqWy3aVp7qa4OLDKS60gnDdIRS4swoDzCwYLQbMQ8CE9vUd9OoTI2zaE9d2cuLvAoikn0PR0KXGIC/aSzhONfLDcEXxRnR5IoN1Asvs7RL9DbMbtxd8MtJan//UJ3PTGZUAwzAG1CsBJhKk0R0w4L8fS1cQJoDCnUgqXwpsi7bU19OWjU5zPTGctMOkyzKXGIj0uDh2TQ0ocVJ82sg7aX8orX3PgPNOWa4ljf7Kc/UID7yuj8WriATerujMag6aYg9MrVqcgxg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB7118.apcprd06.prod.outlook.com (2603:1096:405:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 02:43:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:43:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 2/2] hw/i2c/aspeed_i2c: Increase I2C device register size
 to 0xA0
Thread-Topic: [PATCH v2 2/2] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Index: AQHcmjcM+drWFlMzskyoP3tfU71CLQ==
Date: Tue, 10 Feb 2026 02:43:33 +0000
Message-ID: <20260210024331.3984696-3-jamin_lin@aspeedtech.com>
References: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB7118:EE_
x-ms-office365-filtering-correlation-id: d003062e-4df1-4516-da2a-08de684e2f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0i5Qaew45/nTiNTJVsWKK6RZvyujN/FMdv7QFs6lOapVwSqCkFUcKz8JiS?=
 =?iso-8859-1?Q?eG9YffWQVpRAArXUm/gEqZTOWkQjoLerOv38n+mr8h1/vMfmCU6ModbsTe?=
 =?iso-8859-1?Q?z1LUJyNlmOevbzW0g6Q3Aw38O3WxDuTfUEzgPcChAv5TQrUKiGkGWdsl6Q?=
 =?iso-8859-1?Q?mZWb9UHteL7VzuOJ6lLiRtW2Xa0XTsH4RN3IPCf7nAF7LOwQi8z/rxGMFK?=
 =?iso-8859-1?Q?l+I2VTLbEzjyf3SZjeXKpcUVfrZ3PxxktxPUHB5dbpO5KFLccOMW1c87yO?=
 =?iso-8859-1?Q?LGlk0M9CXAOGBy9zD1I5+o/j3W/wiVxvAcDu3awZn/yqKYjpqcJTjXz9dp?=
 =?iso-8859-1?Q?SUXsjxrkwsltiYTRI2hFzqCGJSQaon3SyEcjQW+Uhh8KG9ufGATNe5m12J?=
 =?iso-8859-1?Q?JOHXDiyimOOpkrAM+TAo+MdXeUVdfDZjgn9maXNCsaq4nSXacaBMSbSfMf?=
 =?iso-8859-1?Q?b1QAOEUYezgAFetgrp+81lsnoafwk49j83uyT4NEMRZVg11mZKoQoEwhu/?=
 =?iso-8859-1?Q?H4JaDUoigXmzToFLOJDL6Boj768YAce7IpxkclRKTVAPF9z91sd7C0yqJs?=
 =?iso-8859-1?Q?/vV95kzWpV2mWdv8OhSZXivV5/tsil7cArzs0ScLVBese6YohgNlTs9PoE?=
 =?iso-8859-1?Q?oYuK69f9awiTglJnKcs/8EzT+V5BOpRyi/XZwD5inZSgoyAE7zfLuoS/LK?=
 =?iso-8859-1?Q?PsuX1XaobRJfTT1GTG5MIyy8kyP1MoT1rq1ZQQG6zuOEvw3V5AwM2b6Ldz?=
 =?iso-8859-1?Q?2j5JrKJkhQFRX2Xw0UzIbC+xURycYwZKqi48sMCX9jZ34FJsfVmY7UBXIl?=
 =?iso-8859-1?Q?MYr1EvnIY2kGc4I8eJD8Gkhka7Y3LgLF2j7klg5a8F4iB/YLY7lp0oRetZ?=
 =?iso-8859-1?Q?U7dw8AMpZqdzzdueVKQoGnwyNWaVl5GNKKCtkVzzft6GK1mn++0LoodMA4?=
 =?iso-8859-1?Q?HnP0FfHUr0bRmL0a7FheWg/iCevLf9fjfKN0OYzJPv6MMOpoEqnlXeZkOG?=
 =?iso-8859-1?Q?KJ0x9tYw3OGPBhO4Y+mBagzkBESpyS110RqJOWWZhbSMyhTQ2ucUaNZfuo?=
 =?iso-8859-1?Q?5xYg/JcJzLgt5jv03VcR5CApI/aZmS2BEyDc9iBKNmRBZCC7lzb9vlTVV6?=
 =?iso-8859-1?Q?LcURasN/YACweu3ragOhnuJra3uoN7d+1EeTejrYFJwMj0Wf5z795rgdom?=
 =?iso-8859-1?Q?W0wAYK0p8m35YsEzqXNDoq+9Q9K5DAocNMB3uGZbMl76KSNIIaZQxOq0eK?=
 =?iso-8859-1?Q?IkSBi4YQ2IC5pi2nEXyJ0ykvopYMe3G+zdqxCgvRSngTBvK4CcNt+SkXO1?=
 =?iso-8859-1?Q?7HphGTO4WVaL0v5ZeKniq2dKdaS+CeQGFlhiZcFu6JUBEKd8UUteNi197t?=
 =?iso-8859-1?Q?wAUDkBzrScHbQakFCy+aIRGFSKfX2hzw+No3AeK76/CMGWPzz14mQAvz51?=
 =?iso-8859-1?Q?pS72BO0OlG/lh4sBeh/u5sO9pSC7Opyb8lUjEHI2HqUZGui2uDpURseY3j?=
 =?iso-8859-1?Q?rFLAeb9kU1ruQm8ma4G2MUO4LbVyq/FVn/agh2d5BU/qQG5gL5ez1rlr4l?=
 =?iso-8859-1?Q?97bkddj6ZjASwzDbQ4EANsoTxCaGEYtzOIRdfLO6yGBqJ9V8mKWl11A1TJ?=
 =?iso-8859-1?Q?3VgOv3fVn4wBOy51RQLi8DjHiCusD87GUC475j8TafwSXH6joNdZEbj5wP?=
 =?iso-8859-1?Q?NClM3oIdQpDLeuMM8Nk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D+gGCmuHNPFy24SaqWQt05O4X23b+V2k+VN+/esvION5DPLw1TipGDhXhI?=
 =?iso-8859-1?Q?HfKFdT2jELMkyJYVPpFj46gBRgEvLWPBX5hXn5scaAVrs+vkmr+o4xkj8a?=
 =?iso-8859-1?Q?3BExFgdiVT/YuqrkLNKavqxn+xC/xtb43MZhdyjonRgMyoosWwDoRVdMKi?=
 =?iso-8859-1?Q?keVFEKwwe4+wLAszdTsPXRovnWVBUfqCDGfrWQTxDBgQtfN+ixBSS3UZZc?=
 =?iso-8859-1?Q?ag/dMjRm7N0KIhxd9IomTknkOOz10lIjeMYPfMHVW2e4FeHe0YX9CEO29G?=
 =?iso-8859-1?Q?FbcfVhRnKuF4WSvhjnwKnVUZvYYsDSuB2Ei8Qa60eQfswQULQMfQJPxRUn?=
 =?iso-8859-1?Q?TTSkws1D3UFkjjx54cYDKw+ugdtV4XqEHNbQBC8vwqIsaF5q/wrLW2sUFx?=
 =?iso-8859-1?Q?f2N5C/XIk1AmvLdPcC/tBWyXY5yuCvIab2pFyWCt77UrokU3usxEVusc93?=
 =?iso-8859-1?Q?K8qkV3hzw1YmvtZhxscxYiNsfaB3szQ6ooGhS/9PRg8q2pdTSDYRzy6rce?=
 =?iso-8859-1?Q?kHVUpi1QlTnygvdQ97tLFSxcgu6WXcFUlHe9IdBMvxZQ9GJiudex4+a9TU?=
 =?iso-8859-1?Q?vNEgzmh5CAr32XVbocJ2HBShu79MpuQqnts7YD5kfKA9i/agSfeMcj7/Pz?=
 =?iso-8859-1?Q?BmWXq6vUaAw4NrP38cORQJQHikd162P9kmGexv6hBwrAh6r2TE2LTddyK8?=
 =?iso-8859-1?Q?4LwKYTSpwQARw2WsE5OPau84BWag+euIxeCLuBYY3g+pVyJ8zI8IPNnv5C?=
 =?iso-8859-1?Q?LG1DU/6QqMSI8W3X4RhHRPsunbOLhZrVSfxETORSjq/yNTRMqVEVRN3kMT?=
 =?iso-8859-1?Q?Gj1QQZgltbIB7jPoGhbAzHgHQNC+0rXsusPgtAdPZ3Bmu8QK+kNViCNi00?=
 =?iso-8859-1?Q?xFiqiB3UKeDtQC438KG9a/S1Ks3t1qxYSN0X9rPDRWJRjJG47eG1pI0nJg?=
 =?iso-8859-1?Q?KGRoa/YKU/gVGpAzqEl4xhupGKgOYIhjcbiJxOKekplL+D3O42aiTYuOhi?=
 =?iso-8859-1?Q?65EKyAADhClf1goN0rzPJGwvBlZWhkDAE0trPftx39PYSzIOs936bQvOnt?=
 =?iso-8859-1?Q?NW55LoPUvdqvvPdqdRLgaQS5DFlxcFIPnuCUVkLcoXmLWppt7l4Q6AGNd3?=
 =?iso-8859-1?Q?+qd9lgOrQr9ZXwyeYPIaWdQ95SiBiJiVZmw9e0Bpv8LspekyEY5sXRAMDu?=
 =?iso-8859-1?Q?ESze0SnXnJTqUrYteHzkITzaMnOXcbTmrPd9xeGhRHoSAGUg9AkZbaCCn7?=
 =?iso-8859-1?Q?6AYgSQC3L2rhgO/eKt5Fm19xCZGAbhGGL1sqqNgLr11MpC+PH+X1hfR5Zo?=
 =?iso-8859-1?Q?82oL1dvPmh1h0AX6lPbctYqsDVgk1U9/mlCdF2Y1CGxEVGaoc/a9UweqLw?=
 =?iso-8859-1?Q?Ji3u60ug7pHQGmoihD7hke8x97PohlmTiM7sWH9AwvZlcQaOJGQCoYqG9u?=
 =?iso-8859-1?Q?+mo4tN1wuvREEQJPy1KMp841LkBZt2V5PgrnRxxRFJbnLj+wxds0kWUXnQ?=
 =?iso-8859-1?Q?V5ZlBzXwTXqtxw5rBu55ic6yGpCYRKsPQdFYt8bNjcZMLvGl4Ekka6u1xU?=
 =?iso-8859-1?Q?MNjGLLmDhUIadXj88C3IoWf6eEhLn3rTZDzXywCCy3lgSxr+bjP9eMLb2V?=
 =?iso-8859-1?Q?czRvsh5lIm+kRt6+2XKI1TPa2OUlcQ4BBQhpquWzSJyv3QhJMcnwDy5Atq?=
 =?iso-8859-1?Q?JQ2QLRQBnq8zLis8O0b7ABtEDqU4+Wgm6lRbLL9t6a+NIXQNd/G69t2hby?=
 =?iso-8859-1?Q?9K0QbsfLrIly0Pg035TChaWzkljqZPcPFaQHBHofTtSUmpWLrDX4grZ6Ef?=
 =?iso-8859-1?Q?NMzN3wtJbw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d003062e-4df1-4516-da2a-08de684e2f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:43:33.9815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liMyEmG0EQOBG9BeKj6zWlfdfe0b27X+aOV5BR1c18ucuDCGw3D/GBai6+9JhoteyPiQ76wOBULjzMY/594A/fsNeWHW1aK+a1yxj6fFvj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7118
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

According to the AST2700 A1 datasheet, the register space for each I2C=0A=
device instance has been expanded from 0x80 bytes to 0xA0 bytes.=0A=
=0A=
Update the AST2700 I2C controller configuration to reflect the new=0A=
register layout by increasing the per-device register size to 0xA0=0A=
and adjusting the register gap size accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Fixes: 4f53de2f103d6dfb5ad0498995d91a9694f40dd2 ("hw/arm/aspeed_ast27x0: Re=
move ast2700-a0 SOC")=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  2 +-=0A=
 hw/i2c/aspeed_i2c.c         | 36 ++++++++++++++++++------------------=0A=
 2 files changed, 19 insertions(+), 19 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 1ba0112cef..53a9dba71b 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -36,7 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
-#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)=0A=
+#define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
 #define A_I2CD_M_RX_CMD         BIT(3)=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 741c7a7297..122bfdd63d 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1205,37 +1205,37 @@ static void aspeed_i2c_instance_init(Object *obj)=
=0A=
  *=0A=
  * Address Definitions (AST2700)=0A=
  *   0x000 ... 0x0FF: Global Register=0A=
- *   0x100 ... 0x17F: Device 0=0A=
+ *   0x100 ... 0x19F: Device 0=0A=
  *   0x1A0 ... 0x1BF: Device 0 buffer=0A=
- *   0x200 ... 0x27F: Device 1=0A=
+ *   0x200 ... 0x29F: Device 1=0A=
  *   0x2A0 ... 0x2BF: Device 1 buffer=0A=
- *   0x300 ... 0x37F: Device 2=0A=
+ *   0x300 ... 0x39F: Device 2=0A=
  *   0x3A0 ... 0x3BF: Device 2 buffer=0A=
- *   0x400 ... 0x47F: Device 3=0A=
+ *   0x400 ... 0x49F: Device 3=0A=
  *   0x4A0 ... 0x4BF: Device 3 buffer=0A=
- *   0x500 ... 0x57F: Device 4=0A=
+ *   0x500 ... 0x59F: Device 4=0A=
  *   0x5A0 ... 0x5BF: Device 4 buffer=0A=
- *   0x600 ... 0x67F: Device 5=0A=
+ *   0x600 ... 0x69F: Device 5=0A=
  *   0x6A0 ... 0x6BF: Device 5 buffer=0A=
- *   0x700 ... 0x77F: Device 6=0A=
+ *   0x700 ... 0x79F: Device 6=0A=
  *   0x7A0 ... 0x7BF: Device 6 buffer=0A=
- *   0x800 ... 0x87F: Device 7=0A=
+ *   0x800 ... 0x89F: Device 7=0A=
  *   0x8A0 ... 0x8BF: Device 7 buffer=0A=
- *   0x900 ... 0x97F: Device 8=0A=
+ *   0x900 ... 0x99F: Device 8=0A=
  *   0x9A0 ... 0x9BF: Device 8 buffer=0A=
- *   0xA00 ... 0xA7F: Device 9=0A=
+ *   0xA00 ... 0xA9F: Device 9=0A=
  *   0xAA0 ... 0xABF: Device 9 buffer=0A=
- *   0xB00 ... 0xB7F: Device 10=0A=
+ *   0xB00 ... 0xB9F: Device 10=0A=
  *   0xBA0 ... 0xBBF: Device 10 buffer=0A=
- *   0xC00 ... 0xC7F: Device 11=0A=
+ *   0xC00 ... 0xC9F: Device 11=0A=
  *   0xCA0 ... 0xCBF: Device 11 buffer=0A=
- *   0xD00 ... 0xD7F: Device 12=0A=
+ *   0xD00 ... 0xD9F: Device 12=0A=
  *   0xDA0 ... 0xDBF: Device 12 buffer=0A=
- *   0xE00 ... 0xE7F: Device 13=0A=
+ *   0xE00 ... 0xE9F: Device 13=0A=
  *   0xEA0 ... 0xEBF: Device 13 buffer=0A=
- *   0xF00 ... 0xF7F: Device 14=0A=
+ *   0xF00 ... 0xF9F: Device 14=0A=
  *   0xFA0 ... 0xFBF: Device 14 buffer=0A=
- *   0x1000 ... 0x107F: Device 15=0A=
+ *   0x1000 ... 0x109F: Device 15=0A=
  *   0x10A0 ... 0x10BF: Device 15 buffer=0A=
  */=0A=
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)=0A=
@@ -1658,8 +1658,8 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     dc->desc =3D "ASPEED 2700 I2C Controller";=0A=
 =0A=
     aic->num_busses =3D 16;=0A=
-    aic->reg_size =3D 0x80;=0A=
-    aic->reg_gap_size =3D 0x80;=0A=
+    aic->reg_size =3D 0xa0;=0A=
+    aic->reg_gap_size =3D 0x60;=0A=
     aic->gap =3D -1; /* no gap */=0A=
     aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
     aic->pool_size =3D 0x20;=0A=
-- =0A=
2.43.0=0A=

