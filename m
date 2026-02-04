Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A60E83EE4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8y-000603-E5; Wed, 04 Feb 2026 02:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZG-0004bh-Io; Wed, 04 Feb 2026 01:40:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZE-0004IG-T9; Wed, 04 Feb 2026 01:40:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boMldIcS24x5KnNit/Hqtp4V6aG2KaWEBeU2gQqUcX5NV5wQ09eA3zUs3ztOSZY1YfcFns7ilUqA57HkzDZFcwuqsqhgxSL+l8vOs+600/+H2SNaDZ43Rp8HD74yBzwAXnCa1Phx3g0URMnzzEfnQNV8Rgd4imdy6GuWr0bL7G5QKvhTlwk4kluCfZJ5IrsdXpxN/8gvAPTDWjE5z9SSxQBzEhFtn8TA/HWaha4N0VKcxuFECensCt+28yXJYTosvq2hyUIPjEfpUdNexPeS2HDCSaiQsr3Q32xzNzlFsZwetA0sAplpDb2Uhre2pyx686Fr7J0GOvIyEgaZzfFyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOiun+yau3ET0PQyINXjy/NOAqoZPYlzpfOwG1+kgH8=;
 b=dDbJ8JuTD84pnbwKmntQXqEh61UETgRbuLT9YCa7sFuzjTGAMuO7IMVV9Y7ucbhdR+fdGmY44/0sbQcXOMB1UE2FwIFaKTKBtDHB6Ha8+gQzj+HbWzOcuqNGzquy9FOCtV7+ik8YeDLI/2zmJzU3I8UDtwCa6+hmdfNVzYYRYRMK8TrsY13qYaM4L7f5rfwFV/s/GSpgrwpXKHWS77mStWu5gHv0ld7NMCmmhJkRVVJIojYshHorMlVT5hryeSB80c1m8gM1GTR68bE0CUiU/XRB2WugOA02KhbiOAtFpmd9trJCBZLWmC/QiiMmmEFQhGFc29LAaQ4Lhnpzd9+Ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOiun+yau3ET0PQyINXjy/NOAqoZPYlzpfOwG1+kgH8=;
 b=nMnRVElGtuhMOPv0V1cmDu6U2L3h4kyaDxz3NygPKQ9X3N6/y1Zu7TEfPqqThvN5YrwGIqQhZ93tl+1felEOAf5N4JAjCB+hdF0O/TMxwbyH/f/JhTqIfob/Aq00J5WjyFradLrda/Nhv2RxOF9IRFPYggto97OW3WSOxADtVMMrRLOPkz93dBQDWfJ4cCoM3E41Hd13rDy9EOtl7F62ae0aQPrz7pOWR4S/Phs2NW6VcC3al0bYIrisyTBSI8ejUfcS7XOxDcdHS9nSAtwYmmSwLpaMd35c36kNUgeCIVfNe3y4djPI7odNc1fAZNGTMl0sAiVuxoX/S80gehrPaw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:31 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 10/22] hw/arm/aspeed: Attach SPI device to AST1700 model
Thread-Topic: [PATCH v6 10/22] hw/arm/aspeed: Attach SPI device to AST1700
 model
Thread-Index: AQHclaEopI6ih2LnFk+5BuVUFf0iHg==
Date: Wed, 4 Feb 2026 06:40:31 +0000
Message-ID: <20260204064016.3515639-11-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: d414de0c-f8a5-4a4f-3496-08de63b84afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?n5r8BZVRldO4fhWtpVzyZ33bZNxQ15JJLd9TMvAV410ach7vk6mceqDz/Q?=
 =?iso-8859-1?Q?ajSWFmuIPF5YO6K58Su7keEIVcmzapK1rtyXj/kF2z4/hGnds5w8MIfxpY?=
 =?iso-8859-1?Q?pSRZ1rrJ+dRw/LvhSJa2+nSIuItU8MSD7mNR7Y2o7T57JzgHe2lg4qC/Gd?=
 =?iso-8859-1?Q?gq2OOHSuvaeE9vqcynS5SJ/ypOO4m3Eh487OLkxeRjmnCN2t7W8fGHjf7f?=
 =?iso-8859-1?Q?/D87NNa6MxSy5PBQOspSALH4wBuub/4u8gBUvqcsVWqAu0msCxKn5wBTuw?=
 =?iso-8859-1?Q?FMdAnG7DfCEtlf+isLhMsgzV4NuTLYulSHoAwgIFzSRIjsDoBNJdsYql3s?=
 =?iso-8859-1?Q?5/kS3qojCoAv3COwfTJdHlgek5/z8apxF/PizmtBLEkySxTfvVr//t2o8o?=
 =?iso-8859-1?Q?0HFp/tQZCkn0CgcpquA2eWFyQJrQ4PJbrha4zaKwCwe0mXaKBos01MHBO2?=
 =?iso-8859-1?Q?TNlRepAtJ/1+veal1CbJxNDqsJu5GM5fj/S5PChbNC5tebZwfQocWa+D7n?=
 =?iso-8859-1?Q?/y0fuVhHceTub41V8LgtSCdj4LtSfGw1MdQVXFNS2H1xXh4qB7Lovb247/?=
 =?iso-8859-1?Q?UTJxjiYG0pYSBzK8l9rMOPpfzxhSTdncGpy9WlA0SCL8W6BY4viIqRHjMT?=
 =?iso-8859-1?Q?8OEwT47ic18AVaYmOMQdakD+L2RCrPwmWe2c4M573Z9vrF+fSsmGV9eDMp?=
 =?iso-8859-1?Q?6lvvAeMW7VK7LjbAKju1lwXX8E6Em75r6N/WNmMSZ6Fgn3k7jvo/ZGdcls?=
 =?iso-8859-1?Q?0yzjBvbe/WFO3z00ofK8t8cfCBya+/Ux/RQ9gDLCS3CJcf4R+/L0JBFTLC?=
 =?iso-8859-1?Q?Eg81szqzFa/Nd1/2fqaXJrvsH53d4n6TiNzIkwSSHPnsZrtmJkBzAi0jen?=
 =?iso-8859-1?Q?UdyQZ8zDejC8kI97N+kCh2IeOlbifKyrovTXgqYGFw2lvBNnkqztSvJWa2?=
 =?iso-8859-1?Q?kI9MwTtlpybZPDWVOMeVzxxqabW4vvlNmd1yC9Jpd3JHE1oq4NNiM2GYYQ?=
 =?iso-8859-1?Q?C4ugNIOzw+FGBZYMxN4Teinbqp8B2nDhIH9iD1GxH5vEK7osA7yDZ6A+lR?=
 =?iso-8859-1?Q?aPapt8ccvCgU8WC/cn2Tv31nr8qKC9QYWgy3pCNGvhhtZbWAF0civTXQF/?=
 =?iso-8859-1?Q?LiLxdrN1bIVF9AhUkHEqU267sVCKLjfjdO7W3yOU/RajwnuMIjVlVZilMN?=
 =?iso-8859-1?Q?grW2p7lQUOy64w1SoprRKmxyYVdTLntwQCkh2fONkcY9GDkW3nNM1pVito?=
 =?iso-8859-1?Q?tHTk7bxNL4pfBYGhdIWr4GQpqJLi0/dbB3fcqwqSRkbuN/DPLWGIPsURG2?=
 =?iso-8859-1?Q?7sU5qMKDQmF6q+VCs9T27iYNPfuD67+5u5Ueb4h6xdx3Kl/nhBpFhzCsAZ?=
 =?iso-8859-1?Q?V3p90fxNeb3Grez2hTGZbaFxhTQKP0XuWnSKaKhPKzffWEGoJoHUldtPCu?=
 =?iso-8859-1?Q?OkvIJhZll2EH7VvzSiL7gD2HzNnoCoc9oc2J/gEHqhoenVm3kePZjZQTal?=
 =?iso-8859-1?Q?pvitg6SwNELZxMsols7hQEaixNId7pI4ExqzqmHRz3ijWTT7WelUjpHAZM?=
 =?iso-8859-1?Q?b2SW7Cc9+Rv+od3vjoLm0foydp6dxkHG4oMrWo8KPHmO4AwLD1mdjkWhX2?=
 =?iso-8859-1?Q?iWvTD/ew6hcZ/WIeFoUvBJztk8BBYSYMiyix1h8t7Rwo6cSDBllcNersNM?=
 =?iso-8859-1?Q?6Jpn/wGiM56Q9zb4iQM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OCZNcvOMlHtEMkbJAR35+aSQENWWwcy8IWgRTtBAPVRjIUymdAp0n/h+Fe?=
 =?iso-8859-1?Q?vgwgnevMhyYJv3BIoMcUl8zC0qqfQYs+NbVEE45hWExawEdo0MSD5/dNxm?=
 =?iso-8859-1?Q?iuw+dB8a7pyYQvtH6x8yYszFLPpyPJRvGhpMLRT73yavVQc0iA0KFuCIXV?=
 =?iso-8859-1?Q?5iYQPmkU95H0ZYOS4y7xUq2Hh7fXk8qkygZn6GwMg/TgClwbP2r/O4hANl?=
 =?iso-8859-1?Q?2oDtt8CU5vXY5SQ94g9xBEYxywb4KQhmOOzWLPu8j/b9lVgRUUI6fJqIW2?=
 =?iso-8859-1?Q?35yJPvLk7zfPmoL3zbQcxqx/1yAxYdmXctLf3Tt6Qx+H7NrnH3Qk4xKACf?=
 =?iso-8859-1?Q?J4tLQNvaaeMKjzUgRpdUSKPyRSJsXKd+htDm/WrldNRfNIPvhn/i7A4f2k?=
 =?iso-8859-1?Q?AkJ7DG7nUipZ3K9rx4HE4wg1ov09Opqiv2NqzO0Ev6BTzXGteIklZPOK7d?=
 =?iso-8859-1?Q?sLPrMXe/vLgzs0xUp3CTHTaQuR2gygPBW3PsQWup3boB26jdmYAoYNx7OO?=
 =?iso-8859-1?Q?ltiYwznKHWPGrbenrQRy443YK/q7YjZTvNRHGmjNL7JsBOed4gJcLhcOUz?=
 =?iso-8859-1?Q?dKLt6APa3FaoLOecnLahlTxag09g07+xPVUmpaXhD5Dd3bWECVcGIL3lt3?=
 =?iso-8859-1?Q?7ACpCIa03NYsJWbLk8I7gzJxIlqFOcNSvn4An+Y7YEGliu7zLoMhSw9wrm?=
 =?iso-8859-1?Q?lK81LmDfHzuwrU0XXbdeaZ8qhm6U96+0LaLmzyEDBZH4Opd3oRB7HBIxr4?=
 =?iso-8859-1?Q?4TSolXv4zhBS3u4mpRvmx0eEpqliNksNxFjn/9E73oLw3yed2jQkBAlohc?=
 =?iso-8859-1?Q?IbVmAft4XyisADfqZkJDzlw8jSyP3cUb1/nnn+Rh0uQiHfDxk8T0aAq02J?=
 =?iso-8859-1?Q?GpTtB2koguepKaE1OiJGnD7qJ4DRwRkUsa5bNUspsq3QURfKfeW+AMjBKw?=
 =?iso-8859-1?Q?CIKu9EQRfW71vS7/mMPVaVkYQ0hege/Z/Gq581VJX6DghBuKeEyXFS8xaA?=
 =?iso-8859-1?Q?HD/ltjwRAwOmzfylvvsSwo/TK47zZJPU43b42+cXkjkwJHN2Zxkb8YzKCe?=
 =?iso-8859-1?Q?hUENa1awgDFxYlpW0T7FATmhSs42RlFVTqwKTLgKZVWkXJ3a/Dr1usPpL7?=
 =?iso-8859-1?Q?RYEWIGHTQcxOxyQqTbW5QPkNlZEeHSlVrxc/T5DQpUbMW2Umd3Z/FL5UFt?=
 =?iso-8859-1?Q?XNZfISQt2u9O2W7vFXYttGGMAZii9i/LM13+ICfPjkfffUB2Q3h8+SoejX?=
 =?iso-8859-1?Q?wff+fPp+qwLnBQvllVYk77QLHY7pCD05JoFrK2voh1dp+R3PQXnn6VwUrP?=
 =?iso-8859-1?Q?6ZR+8ZHDTmUAYAMobdcpGw5ri1T1y2Q0s39t+FY5G72FEuAfX0/Ore+g7/?=
 =?iso-8859-1?Q?PSZFt79DLQ5B01K0J4U/Vhsq6IWFcQZiV6MtXxyB50cBqp7HXLgmxBfZNa?=
 =?iso-8859-1?Q?oMeIolaYFAYcDYOjBHErSJ58fheKf0hgZ9ShR3Mq64mZ5XnrchfWiqmjJH?=
 =?iso-8859-1?Q?sleV2sv5agpRkc5/LGL/xBm/JDs9Cb9ihGTPq/xiT7e7KxT3rIk4CcmIIC?=
 =?iso-8859-1?Q?1gzRnjIfs6s3CFKvSI+IjAOGHPMrmPZZ4BGcsoKUNEEo0ZUulibe/IwFX3?=
 =?iso-8859-1?Q?ypRHu/dG+864nNW6pwRDAGnvnsXTr3tgOCiIrQ/5N6ERxLUJlJ9w6l8UHi?=
 =?iso-8859-1?Q?Qc05o0s3NXtwqg/8P+LaSWSOFyjRynRPzLadIFUIpRsKpigu48quaJs1zc?=
 =?iso-8859-1?Q?YD4LKD/xXKLRJFhHhQMalblaePBrj8HmIpf9N40vn5LO9s7CAOQartlJ7n?=
 =?iso-8859-1?Q?iKegSDRrRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d414de0c-f8a5-4a4f-3496-08de63b84afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:31.5595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47nXq99NV1m8VZctx6tYOQXXxze3UQwINVCSPbzwj4CYB70zl1oycRArohQERfeHVMxy/1nsNTXA+7k8ZzFUUptYt/LFTy3nQ7Vu6/vAqXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:21 -0500
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

Connect the SPI device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 hw/arm/aspeed_ast1700.c         | 30 ++++++++++++++++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  2 ++=0A=
 3 files changed, 35 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index a981bff3b2..89562eb64f 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -10,6 +10,7 @@=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
+#include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
@@ -20,11 +21,13 @@ struct AspeedAST1700SoCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion iomem;=0A=
+    MemoryRegion *dram_mr;=0A=
     uint8_t board_idx;=0A=
 =0A=
     AspeedLTPIState ltpi;=0A=
     SerialMM uart;=0A=
     MemoryRegion sram;=0A=
+    AspeedSMCState spi;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index fd5db3268e..97990688f8 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "hw/core/boards.h"=0A=
 #include "qom/object.h"=0A=
+#include "qapi/error.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
 =0A=
@@ -16,15 +17,19 @@=0A=
 #define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
 =0A=
 enum {=0A=
+    ASPEED_AST1700_DEV_SPI0,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
+    ASPEED_AST1700_DEV_SPI0_MEM,=0A=
 };=0A=
 =0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
+    [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
+    [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
 };=0A=
 =0A=
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
@@ -33,6 +38,11 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
     char dev_name[32];=0A=
 =0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_AST1700 ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* Occupy memory space for all controllers in AST1700 */=0A=
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,=0A=
                        AST2700_SOC_LTPI_SIZE);=0A=
@@ -57,6 +67,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12=
],=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0=
));=0A=
 =0A=
+    /* SPI */=0A=
+    object_property_set_link(OBJECT(&s->spi), "dram",=0A=
+                             OBJECT(s->dram_mr), errp);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 0)=
);=0A=
+=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_M=
EM],=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -74,6 +98,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=0A=
     object_initialize_child(obj, "uart", &s->uart,=0A=
                             TYPE_SERIAL_MM);=0A=
 =0A=
+    /* SPI */=0A=
+    object_initialize_child(obj, "ioexp-spi", &s->spi,=0A=
+                            "aspeed.spi0-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
@@ -83,6 +111,8 @@ static void aspeed_ast1700_instance_init(Object *obj)=0A=
 =0A=
 static const Property aspeed_ast1700_props[] =3D {=0A=
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),=
=0A=
+    DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data=
)=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 6a144742ea..2fc50af8b4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1024,6 +1024,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
     /* IO Expander */=0A=
     for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);=0A=
+        object_property_set_link(OBJECT(&s->ioexp[i]), "dram",=0A=
+                                 OBJECT(s->dram_mr), &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

