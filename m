Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4C5C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbrt-0003Ov-9v; Mon, 06 Jul 2026 01:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbrc-0003J2-V1; Mon, 06 Jul 2026 01:27:30 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgbra-0007PL-J8; Mon, 06 Jul 2026 01:27:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3I8ivgjYrq7ejw3eWmdx7vJ8qi/0RIxol2euFitquTIcyafBun2pD9TU9/oG+4TkaPrWUVjbWHx/TQxarp57oFlknvQsd6VFarcbil80/8HmE6+BfpP7BF+GJ8s6yx2tLWtHOxzB0sQ7XXTzI7fXGW5Iyrl26kmblxjWrZX/X29rYHWzi+eh/klvLMUGtwwXDedSVSVllSOBpPgVy5XFp0JLZHhoWQKdXbwh4zbP0Zcgyhy8ecY4gG471USBuNtWGnHiNiUVaKy4n0nunWecLv9ISACSI0MxTcL55zwlppWxVfQCJMF+gz14yM11UWtFec5FAfqC9b7uphVlXqy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcQV6aop/tqT1znMnZYQaG4h/6Ekn6Q02SU8Shy3U6U=;
 b=kzc8feqyR8uSzq+cQEbU/VSm36iTB/V9xZR255a2O/gLUByYNyOEaw+0hIyEGhqC0xsEcIjcwNSvWbmUnpicVSjkV0oxRbS/JmJMsEEYfQQZhZJ5gv6BpFZCAREpfHG/nczYqTgLY6jDNmLrJIojYvep7BNHbMf6u6clDtbMTxPnys+3t5xq1/An0E0SDsm121bHnsBVPHEZBCDEzuTAWiT2LfFdxHhUv+yN9ccP57GiSGRTw0JpqWNaJXgwGWlhhDATYM5YNjbdXJT9STkO2Eby5FGBSyRCzfL8wsWD6qSIBd52T9gTjC8FosalEdc92eKauvW88G58ij4yab0Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcQV6aop/tqT1znMnZYQaG4h/6Ekn6Q02SU8Shy3U6U=;
 b=EUCa4GbRsQAzccVGy4CiYy9mIOn6pyLWbcFxmm01/tTCUgU82x4DC7fJf36ykFOAySAC/2Zh9JI35RCUrZzZ8Ps5ysXs3tkxIRdoYctJ2TSAUQUDrBHdRd8q7qox5UueCUIctGgqrkj4l0fextMDrGh8t89zZm68FiMh7wc6OTJJWBMfsWUH6YWeWXYWE4evoYPGuuw4Vzcu+wj0CubSHeUeMudesP+BVFUigBoXn7rJfm2LthvpUDS1+ma1HjXYF4qmG2SJJIDuPepdKgbjS/F2sVo3G82Xh1d/j4B+fAFI9yCoxJ+OylT5h5hG3ZXP0FRXcQMGTqJK3FhxnaQh4g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 05:27:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 05:27:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 5/5] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v2 5/5] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Index: AQHdDQgXL1VYQ9GDeU66s5a/uEfL4A==
Date: Mon, 6 Jul 2026 05:27:09 +0000
Message-ID: <20260706052701.1141740-6-jamin_lin@aspeedtech.com>
References: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706052701.1141740-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: 6a963ca7-73e5-4f14-9d8d-08dedb1f39f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: jjKj2UHlYCq+3B+jomXtzzsEhROaBOFV5EtmU9loLQMQJ8zTd5WmEtGHqiCV2+o53TGyRw2XHI1NSAIuDIN2viaTeIR7X1uTaqHY1rhb6rJOA3yi6qT9/PLS+Im2fURR/jkRJ4xUipYWieqyGPI5GmqgkrU8daOfU5KBpEIEdW7ry5OrEIwWBW5FX5CuMfjOWZlI4YiXF+ET41SNKWtjZ2GhfRxqq97AVAiT50Uq6Te0se+U2az45xH0YEpm/PnfJu3Z9E95FBdr4g+OmFgv+t/TcHt/UmchodAvtuLjiXBAtI3uoQbRX1zJenEt3CnonQwkY42/IIpr3CQtehy7VXlUCw9jm4suEozcoqKZzPbnhE+YE3BCBaCq4TxrCASpTZuLkGYwbJYqU5q5AtdONbWob1cdAvROkUTyOEpjBW7mdzNhqszlFvf0KOagKSc+hWq4XEGxrPUuBRV6BRasCti4WMT43vBLskuOKWPlPR6FdPTYREzB4Qq7n1T9pHNgdnEBtU4k23bua2W+tb6kPZ58XaiZNSGw+xHEugJvscVa/fWiZWUmtfF9EUr6dvtpKenVXL1/P2OzirLSwCrJ/TbLprm68eeezhx03FoYAMjjxI5kR/N91AdekdOY79+CB9BjvU5Tq0xLBKIpD2UN/HvYSIMtqCx49kwRG7pwPMdEHFx82X97wM6nJCwjB36A1GScAKl8mccfnAhK44IV3KXqx4I0AMv7mS1ABgirZs4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RcZIuB6m7H5XC8tT4Llc4/xB0/nYn9sXcItF4MIjWbcLS556hEBZv8YB7G?=
 =?iso-8859-1?Q?OSK3KyQcVvXf/deVTmAjTvXrATNp3OHQTL/EqdFaLHXguL+3Filg9o1cYv?=
 =?iso-8859-1?Q?CQz31JycT66KwfMJ4EAHiTKTTeVd3O7kRtGjo0rXMEFberg9spAImcDpYO?=
 =?iso-8859-1?Q?uVAPhcclcGXxZhocn8tiF1292prPdLqCWbxpACiY+xRCseRtkjvglChEJP?=
 =?iso-8859-1?Q?f9c36B2fLtPSg9bk9bickUsTG6OgGorf8n/ykBvMQ1qep2y22yD6sjY0jN?=
 =?iso-8859-1?Q?kaZxuPTvoTLoqc1PFaCHmDn19sssss+jCyojeLUBzD5+/bMqAI+03pVRFC?=
 =?iso-8859-1?Q?wrOYeUqssV2T3MdTJe2UXRAq+RvEUk1+etqtskhyGXVCE/QzNK6wlSkJiV?=
 =?iso-8859-1?Q?aVTsELA7RB827awGW7lDSLx/E780sihYtIAQrMqI5P3QMMghNWRKA3TKR1?=
 =?iso-8859-1?Q?wpdcnLfZpjQcX5JWJaccMNhuN53BQaFm+OdepH77neLQt/ECGp098EOx9L?=
 =?iso-8859-1?Q?ika7gYrk3j/OZBWY3N50qngWsq/SNIUFIzdJf6ENGrSD9wXNcGs35bRfx5?=
 =?iso-8859-1?Q?rjiCOyZROPjRPZ+UxJluwzifppwDr0z0kAdH2dGyPgzPoyWIxuv/6fRjo1?=
 =?iso-8859-1?Q?VlADaoeMn8p6rj2RRIj1dUrrpIY01nxkBGyqXbbXhw/72hPWojpxwMSeqJ?=
 =?iso-8859-1?Q?F+z79oMLNh4B4aSzcM60idb1Wd/7GnOsDzklkF862go1a92ZuvX9Y/knbf?=
 =?iso-8859-1?Q?6k2zI06f5v4QkF4jq+gp8TKA35UZT+EpiZSpJFz7prGeM+GSKzje2WcUTS?=
 =?iso-8859-1?Q?2PVqNySkxqid/tV3ceTdZ0q2J512fR4eMEoQnoAeVtdyYkXH3MRc0HivXz?=
 =?iso-8859-1?Q?ExIKk7e+o/vHKBRjlw2ThMhUnPrRJ0zsYTNqgCnZye+RfEdbbGho6Dgv7W?=
 =?iso-8859-1?Q?T+KaURLWjYHTuF6c/giQu0cCrc3iKcFtJaRbY/PteNVc8VTnsqFWPAiX5p?=
 =?iso-8859-1?Q?ki+KeTzGk+gyec5SQnaTZ7KsuSpu2rPjoAvq3j/x+k4PPuLsqXB9J/EW8d?=
 =?iso-8859-1?Q?yFunsEqSnc4vdl3xhMTwdqGxc/S/rj4qz/lXaxQtd3Wew8JST7kgwe3u6h?=
 =?iso-8859-1?Q?sxFV5scj/n6oY2V1J3o98UTrOtgpH9aK3m88EvlC9f6ED40ZB48sKgzpC+?=
 =?iso-8859-1?Q?Bq3kOwDbIRY0HdclgQLdUBGTlf0OIoihBOlhQiVzlId9RY2ciTNjj6prjP?=
 =?iso-8859-1?Q?IdZHoZDHs07V6QFku4PoJ7oj+7Zv3qM+JlINfqFX+4Q/+Q2xZcblMhZuhN?=
 =?iso-8859-1?Q?Wu5XGkrTfRKQrIb4kSablpyBtAFdcoYW6et6E8baWv09RXuNkJ6OfxXcCY?=
 =?iso-8859-1?Q?6I8wsKRWXgG4RCrEvvrI4c7oGB3zuz9qT7KrRzr6Uas+XigKS+NTnkIkTE?=
 =?iso-8859-1?Q?8s4qT0k8HJqGNK59AxYVP/ioU5hm2DWYAV1f6rNZdvx1fU/nNoL/qBQ6E5?=
 =?iso-8859-1?Q?Y+tOJQ04i9ki6Y8tVHUAvo73EodeQFXTVwh21GpZf6NOrbQ34eHEKZgcs6?=
 =?iso-8859-1?Q?Xf8/rQ1zRQQDNrIooJVDynHcpNNwc74f93HWKrHo9GYpDVN1shfHmYwzU9?=
 =?iso-8859-1?Q?5ol4F8N4ahYw3skdJtUkYHBTjGh12NDjD7YpMBVYECe0jAqqZRdGIoEimA?=
 =?iso-8859-1?Q?9VRmVUzVKIzhDY2RtIggTWMoj9s+dt+bKB5IVWVpDlaMJPpzyKmHHx3Gx9?=
 =?iso-8859-1?Q?D9S0hnia/arNScS33bBYfyOurES5pjplbZjTMzQf5Y80yd2VICtP4VvLoU?=
 =?iso-8859-1?Q?Dv5DGV+LiA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R4Wwiz+8e0CAGbDhn8G3qpY1n0fIYFtBXkIzOL/Q1l5n2SpXtwQotQBJvDZVPakhfujbHHyW7FHEik49MedrXXf/GGKFlLT9lHXDJDKfGyn/u/qDsc4yGGO3986bbOYwvt6vm2WkuthEuhHF+vAdixgqWctn7CKR7cnD2vB7d51A2bJ7RVFmTmIQsbVspVXS5tWtUK0UlY/Egk46Fcc1qZ8iC4PNxBcOEAc+YC/kQys8yTjjDwB/CkoKT415e/1pRdtxWEr4ke/vknXvjsB9/DJg2HLSj4OPuXRPM18w/hFAYs+tSwtbOp1GTc/awdr8AhnfNO5ZaVpyUFPiv/iKtQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a963ca7-73e5-4f14-9d8d-08dedb1f39f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 05:27:09.5995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nAXRhEMkGKc2tbySTSqiIR63wZKzx/UaFW0rrjtkN4BYgUZ7h8MJdK8Tn4tZg4GK5e+KY2g5cqL9VIvmHdy3f1U3PzOzNMtUCJ2W+OMZT8=
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

The AST2700 SSP/TSP firmware accesses OTP MMIO regions that=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the OTP and maps them to=0A=
their corresponding physical addresses in the SSP/TSP address space.=0A=
These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 1 +=0A=
 include/hw/arm/aspeed_soc.h         | 1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++=0A=
 4 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 700cbfb4bb..ac58a5f424 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -49,6 +49,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
+    UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 };=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index a0d2432620..41dc04e293 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -297,6 +297,7 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
     ASPEED_DEV_PRIC0,=0A=
     ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e35c0c9a5a..68a8ab26f7 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -29,6 +29,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -147,6 +148,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -267,6 +270,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index fdc279cbf6..b8a4f7c91d 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -29,6 +29,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -147,6 +148,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -267,6 +270,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

