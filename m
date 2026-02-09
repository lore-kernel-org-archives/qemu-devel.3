Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64847E78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOF-0004mG-VZ; Mon, 09 Feb 2026 04:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOE-0004l8-Ko; Mon, 09 Feb 2026 04:17:06 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOD-0007K1-2n; Mon, 09 Feb 2026 04:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywVvzbcSBl1yRdF8ETFACy8QlzSUSufJyJ3/C9tEWE0bZpOFYlz9W/tz2ppxE5s03viNjZs3AxsKZsjYB/WZHWS/HqzHM4iefUXy6sIA9OuWsV9uEEBgqGH2qhDMX1KhKXXyq7qbm5gpkUpNZtAogaVPHJme7qjUJWc+ZdTlL/1OaW0XN4VvUOW8pHj2CCnwb7hECuqS7xu7fkgu+tju7+FJsRKucWDEy87x5SOimS5p8XJdHvM5q8FxeFgMyh38vJwrqS/BG6R5xFLFbPiOap0Qzf/sO2+9nB4VIjfXyzLj3U+3jJOqm3uS63JZKOOdKvNhAzNidg8TCdDkN3fbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DQFSDlfMFhg1AXzqdv2R1stt7DkFvVrRn/ZAewdqXA=;
 b=kBYJRt6tPlQC3o+IEU/aDr7zqW6KW3itJ61f3WQIbyohZAInuerwdmWbf1Uit7kh5pJbKYX14V6lay+PSXyfVLQoag5E9Zzmi6gquiemkdkDmPD4i5it8OEAVd/XKCmHz5tvoXCG8DpNrjriSo8zsJzipfvhXImmr8JN0Od7AvoC5EUUeaWigBUQPmBNJ3GIVzeCY3doy9hSKJPW/WFTuhQRGYkWhu9x/uWxkIaPPRT2hmAvj9H1geJBngvN0RyHPsKuAQbJTXUfJ4qc/G0UIsJO7QqrJ6JdPpVb7nMncMxyVPIN9P04Y++KWEHu5IXvyDgiGPmSwvmwYZlD0bV+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DQFSDlfMFhg1AXzqdv2R1stt7DkFvVrRn/ZAewdqXA=;
 b=o1BCYYb959Yx8DRzQ6HdW5CNEQz48hFWpL03HlDgWo/K9tXH3Ir2vOvVs+vi+FPcpFhUkxwGunwt//3UXZbgUtW7mww5jkLpk7K2HDdO2LGQJDymFFo9onqOFFnEOXdqP2CIF+sTXb05fgMOLHXm5gWlsT4X/UqJnrDsE9sYPGBmQ41C8URCrQUEPTxyzhHDYdLFpwPnKBPUcTppGLwVt2yKd2FpuzJLHROg16GSqG7OWgNNgnO+WRk3Kz9oa0xu+sqt/kPcYBwZSL8424lKA/E2aYIzlRPVyc2SrJlzXdyeQg1YuyGEC39JvepTmsQJnp7hXiAEBThLSKeBgMVWIw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:54 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v4 16/20] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH v4 16/20] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHcmaTV3rbkrnun30azPj3ZmvtexA==
Date: Mon, 9 Feb 2026 09:16:54 +0000
Message-ID: <20260209091629.823457-17-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: db8b832d-3834-435b-df9f-08de67bbf789
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/ht+EG/q5ZOtSnx98+W14m1GoEQeYeOHcqX0iHA+4ijlrfPdRcBIV8rCaH?=
 =?iso-8859-1?Q?Q3d7CyWeHUTef5xekmaBkxrBy19SbhG6JZWXaS+RyTkS2QPP8UJN815jfA?=
 =?iso-8859-1?Q?npzZmmwuYNIzD3BRkbwWvenFM9KomdjQADiWQEkns0HCzhHjbUyMmKK2yP?=
 =?iso-8859-1?Q?D1Z6CauPV1Xr6MYXeMCLVHQWdwLovoo8I6EksIX3k4Yd5D65GLuyxUyOdb?=
 =?iso-8859-1?Q?dwdnu8UMhrqjWHEiZw5s50RTLykUxKfQEq71B64O4c1yTGMEiePZ7yLLdW?=
 =?iso-8859-1?Q?XLUM+SdEduSn9xHC8mCWgIez/iD8vW12ic9PrGWP5Tx4QwJyZLozQy07xD?=
 =?iso-8859-1?Q?U3madiVVIgteWU8S52BSz4a0xNGoYN3ie6BJ/W7RoiE9BybSOOVmBKTw1i?=
 =?iso-8859-1?Q?jOb3ZXonSNi7pjrLrnIU20fPHSpj5cVuanGxQRfGcubd3vi++J0ZX45Jka?=
 =?iso-8859-1?Q?GVdzD8SJ8/b+raRpc1hx02lOqYufqDfZWJkhf+ZiOGPedhtrrEfqB79VSU?=
 =?iso-8859-1?Q?Eup8e4qu3GkS7ly+kQvBW6yDvybOUTXQCc2dw8xqs+7CMr6DtNYNhW6WBD?=
 =?iso-8859-1?Q?21VG02+TEMPiOQAPQ3YPnRgUNn6qO7DKv0r2Jbd13uw3X+V3MzLxll6xD9?=
 =?iso-8859-1?Q?VTAbF7Bl1T90cnjO5Fyl1uuyoMU2Wn0NCOMv+1TeS8nxtbFq3n4jX+015g?=
 =?iso-8859-1?Q?blbx4gxIVMq2nGiCPVqmRx5I0reqkbIkxxkuQ4sKXqCjSacAXV9OgpZtKC?=
 =?iso-8859-1?Q?dkW1XneAUsljdCamchIgF9kZIZnH9GcW64pSJXNKeuKNkpZLADDc8YyVa+?=
 =?iso-8859-1?Q?XAHBHmakJIcv9kyMk4/tYcZj7TRhu2zx9lR0Kenps2ekUd5ryFG1prFnpm?=
 =?iso-8859-1?Q?+14Bw3KgXB8eOBy9VpIAg/EyHE8Jpp2IlXBsXkGumE04YLgZX81UIIDuj1?=
 =?iso-8859-1?Q?cqxS7wo1takMD0rEIWhWzfvER3it7xwhr52i7eFNgoHQyZ0f2XKzo1Fzv3?=
 =?iso-8859-1?Q?qCpnNIsxOufz6d/IF6kFcT0dalYM31xAmAvgez7cb1yVLsG94rXv5wP4CY?=
 =?iso-8859-1?Q?x4gHIumS4EpvD+wbBSt852dUKd4v2FGlFep/vuf42aLrNRIcyto2eGLsHF?=
 =?iso-8859-1?Q?1XbcnaZqwBXml73ANnMEzXnwelIxfFd55zeEWN/f6K09gxXEce3IV+SdKd?=
 =?iso-8859-1?Q?6wyN+rVt3HgH/FGBrtfJQxxhpG3BTbONPl66iFHO51zgSmSpMCoFHM7meZ?=
 =?iso-8859-1?Q?ml5o1PdFJY6a1HYDbRnDhC/PXFto1d2E7o4PxhnViMAPD9XemJkLFGadML?=
 =?iso-8859-1?Q?W6YPjQDIebatqhTVXeB1mlx2cDVQBi3tMTIloSC1K4XViKvn19Nipc5v6J?=
 =?iso-8859-1?Q?DjHUtqMQY5yBk9DD8AVqnegugPsRyD5iObwlYVsarHibBXZrlgWZBN4dzp?=
 =?iso-8859-1?Q?kjGdC40GRw7Y+/StDbWZGlDzw7BeCs/t2MN4vWLBgFFgLdraYIBvieWGaf?=
 =?iso-8859-1?Q?c1hcTvnfJFY0eMSLfYclBUivTTePqrFnnR3PNqfIZp4+jiyV+LFrU71DJw?=
 =?iso-8859-1?Q?ELt8lKfrCkQAhnDvOLbzNEabU5e0aJRFkUIB4V6KoyJN90gGne4/59Exrv?=
 =?iso-8859-1?Q?OomNALl9IPmZVmVAEaqZafk3/vqpnzBmN2ZQcG6TKAZrv7QiZMlRB7Rtl5?=
 =?iso-8859-1?Q?L1K1NRXL86jfwfKfp3A+xULg6kff3gc8u0b6OtUN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JqiasIs5LCdssDhLC5DhHomt/uiaDnaMegLMx1vVE5eRa55ZDQWRa9XBVp?=
 =?iso-8859-1?Q?po0aTzuPaxjtPOCniuslscqHwN7Ieme/lJtXUEd4WkvJZVVapQxUMABRxv?=
 =?iso-8859-1?Q?1FeAB28hk8NCeQvhnhUE6jOubxBFZs9T6CBABSvqlWsZGgN13kT/0H2BGW?=
 =?iso-8859-1?Q?WtydGdfc9cNkZWPImR15aHU9XVDdPi8LRI2HpDuzBRIThd+I7rM3+nfoT9?=
 =?iso-8859-1?Q?bLCE2f3M7u/Pm/g7Hq8vMA7M8wj33a9/ITRTiH/wZq6L4LQMZq54wdaGlN?=
 =?iso-8859-1?Q?A0wdJpaK4DcZu7vlPH9IVUEXtP39rTUyMCa5UAkeXMeLJR6u+kr+W8axWp?=
 =?iso-8859-1?Q?PfxaT/axdaIZ/89rYaXpn7/6sJ5BRzfyG7AyHp/El8f+xhPtr95LDx0Nsc?=
 =?iso-8859-1?Q?v4bkeMqkrxT4ovTYuc83nW1Zm1P6+nWpTP1+xO7cl1Kh6BUyMZ44QtzyUA?=
 =?iso-8859-1?Q?wUt2cAwCW1jLAfRgBfGlbyUrmmZr1zDew9O5/9/Kgvdgh//HM+a9N5BuIV?=
 =?iso-8859-1?Q?soxHqyfyGS67iDls5G4qzc4zT2bOmU2pSisbjnK1ZUTSCBDuQl3y6VONuc?=
 =?iso-8859-1?Q?gHLG1vS66pyyhiIXWZIYDBf+j46QxdCi2nximux0EYRfPiqfgzTkEIHJ21?=
 =?iso-8859-1?Q?+5OijISGh3x9Y6UWWDklBECtueY/SXHEY8Y8dJ4PuA70uZCvawY4E/2Lf5?=
 =?iso-8859-1?Q?2ATcJ/WTICXZN0rDjX1HxxwXBz5jJ90lFaC2m9K2gTElZMQ486cUMK7ak8?=
 =?iso-8859-1?Q?SxglcpQJB/WV5ROf9dVJvZ3OQ0l6B+aGxT3sY8wKFH1BuTm3qV4OzxnclK?=
 =?iso-8859-1?Q?mZnfkxPpFJrwgDW/0ETt5ePnaX6RfeUE49TFDQhm4TEj9smeRwSZYAzZNt?=
 =?iso-8859-1?Q?CRBQHCy/18yeyAZhkyceobZ3ykiFTMSckwKMixaMGRplzYGM2flZC7sGuJ?=
 =?iso-8859-1?Q?6J744/LZPweuxn96iv9pR71pPs1Bad6RigNVWwzNNI+huoqUpYrJOeDrZR?=
 =?iso-8859-1?Q?yJFhpBMMH4GCf6/Ibn2Hpk1dbpwh7RT0oZRpWl+/zWCj8v/eMhf7SLJB9w?=
 =?iso-8859-1?Q?F5EZXoWc1rRN5kW81cC3YYeEkAMjEeDzBr4lT9TV1ulZCKG6S87PBlE6iA?=
 =?iso-8859-1?Q?8FLBSPHlw+Rze8DoDD3qfgs4GJUZafcmeTBXeQ7XqtpXfyfHDjw9cqHTEJ?=
 =?iso-8859-1?Q?CKWgzCEMyDMT7JFvjjRDJ7EzZ45nmrO2NUD3LzFL7TU4KT1gMfTHCI5Kff?=
 =?iso-8859-1?Q?eo9e7ccf4+PvE9pZNY3lWl9wu7suzVWB83LBBM7TinHfqNKJuwzi3YWVwE?=
 =?iso-8859-1?Q?rJlLWqQcdj9+OcBbkyIPQOzKVtVnCaDDmWRjV+qdEQCrZyyBHnjD+FGtEY?=
 =?iso-8859-1?Q?Llsg2kgqAcKlWez7aoJS6GyAt6ebRcS1x9WlZ4qMIIPCNLzDEoLjuVOyCa?=
 =?iso-8859-1?Q?vQX6IqZRp6iBySEivOFNieX48Dbp2DdI5Tk7gy88wNzvmNjpisKw8pU9TF?=
 =?iso-8859-1?Q?pkztIHhDbPhXd+cRkNlq2q2VbvFUGu8rbI354DTlLFnfQc5W7xHKR5512b?=
 =?iso-8859-1?Q?LKcNz2opk6mWJ4Lq8cHkJGY77d0SGjKMdyzQOD4CbJ1b+y5PfA1tND6HhJ?=
 =?iso-8859-1?Q?3uAE6n9p/vS4SGClCVXqf0E3AiuHBqllVFTgwLLcAtp/yRsALUKdQ//WpM?=
 =?iso-8859-1?Q?EtmW8ODvRh/t49760ODa+RDsk9eEPFcxrz6XBiWVtlTO+3kxVPdcqLtaxM?=
 =?iso-8859-1?Q?r7lXnPPz5GjsWLs+mSqtL0tdNBBW+TqQN2oE8vOdJFlViygrqv+fyiVq99?=
 =?iso-8859-1?Q?plFOoe5/kQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b832d-3834-435b-df9f-08de67bbf789
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:54.2514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DfdC5GdHopFDZTUvhS1r98AMI1+A6E52kRyjytK7Wbb+z8iKY2fqcigGGMZ/dpi2x08neItHmS+Y1pyiJMH3k8R7SvVD+Uks53CqVkN6Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW=0A=
I3C[n] -> bus object, so make a nice wrapper for people to use.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 2 ++=0A=
 hw/i3c/aspeed_i3c.c         | 9 +++++++++=0A=
 2 files changed, 11 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 436fb532b9..e4e8fda93b 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -34,3 +34,5 @@ typedef struct AspeedI3CState {=0A=
     uint8_t id;=0A=
 } AspeedI3CState;=0A=
 #endif /* ASPEED_I3C_H */=0A=
+=0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index bb41493c55..867909ebe2 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops =3D {=0A=
     }=0A=
 };=0A=
 =0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)=0A=
+{=0A=
+    if (bus_num < ARRAY_SIZE(s->devices)) {=0A=
+        return s->devices[bus_num].bus;=0A=
+    }=0A=
+    /* Developer error, fail fast. */=0A=
+    g_assert_not_reached();=0A=
+}=0A=
+=0A=
 static void aspeed_i3c_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
-- =0A=
2.43.0=0A=

