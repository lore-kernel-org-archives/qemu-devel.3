Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E91C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXZt-0005kV-DL; Tue, 14 Jul 2026 03:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZr-0005kJ-Pe; Tue, 14 Jul 2026 03:29:15 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZp-0006VZ-4D; Tue, 14 Jul 2026 03:29:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+6yUNTtpSWDbe2NsDyYs93BK2Z0zYDkSwwYWOnzZry8HWUHVE0zJ7BEy5kVWnpjuWGo4FYeYd8xq/1bNhhjtPteiwCVXsk1IYnpOiYgYTk8oUeqHz2E/Ai8sap9WvIiCMdy0Avz5z6ugvhiMSS9TncLKe8PthJYs7H6Q1F8BMbkakNZ1MASc21EFVMz7o/YAM0GHHl4MzKoWtz/0nM1Z0fvb1annMuAgJl+xKUlrGLwl2kTJwZk3UnpOUvVbNUg+3UvY6LGHkYLiYNanv/LNBTBi2nLtgRsO62lA9Af2j8E7s+ItMBlFwBjFyuiKZ//PDqvq9vRJ9e2VpLh7UvNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRIUuU5mK0diXYjVfpZi6d8tdVrWSDfrH6uMuOuuEGQ=;
 b=ctsi33Enm7+Xcf8kIseTrHHJIwfyGSXU2BX+bkFOSW0U3D5WT+BrNWBcmtYBUJ5zqtvSqcxqOHI/KkVBFs5eyKNqdPmkPjj0lVxy9bWZ3e3SsjR53+NrtjuSYVs4Hw5uVVXYl+8wogGLjT9KwKGwizQPPKyPvCK2NUR/5IkKhqoW34/g9LWzzojHzyxPvB2Rn5/btLwVBm8OW0CBhFbJaId9EsXxv/XflNjR6rgK0GLPo+vDiABeQtnGT4DB6sPwfw4Jl63d4stZGIhTaxRWqPLqFakEVUjXNIn3gVAdV60LEZn+JHoZOkj+7iRroDf6+bQhR8ErcXR1T4wsMrQ8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRIUuU5mK0diXYjVfpZi6d8tdVrWSDfrH6uMuOuuEGQ=;
 b=ffpalQlArtDWVd6m12brJ4KCoob09jdLC0LIpl3ZikUlxHne9qCbiBuaD72YLPDpVZ30uxqC0uqXIBjzZ6HNGaz6ZFekIA0OQGnkMVQlQrOAjpzFtG3iEAYtufNBYn/3oUBjrDgEQMVrscTHM/6OyvcVnUDJxY2Qf1RbwU/mSdklEGI5iBwcsm/YAz0CQ0OPIYP3lt6L4fAxzMgOJTeHP29+GJXTFZD+enazcqHCf8DpVeB/ca1NTZcSx0TjHs2u/Dml/iRFb3X2qZkAHdhDqXvXUTL6XX3G3WWaEglp8p7+Gi9bDPrtdedpnnkBhLw32X57Rfi1NhIiImji3j/qbw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/15] Support the ASPEED HACE crypto command
Thread-Topic: [PATCH v1 00/15] Support the ASPEED HACE crypto command
Thread-Index: AQHdE2Jw/NUkot8x906QVxLfH0dy3g==
Date: Tue, 14 Jul 2026 07:29:01 +0000
Message-ID: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: 95717e3b-722a-4bfe-ed93-08dee179937e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|56012099006;
x-microsoft-antispam-message-info: EX2qdm+GZS3ecrysB//FbnhIbq2nymSKH0Ah4DpSyfbKXoz1tN1Lw/6HtLYDWVTq+QScZfz5EOlmTKtvphVttZTJV3i98FgvBZSp+SSH9ksXo68nZYhD/syZ3sa07/k4uh9CC8rtbby18CSSAkgWvC6cb15zHKUOCR0F7ik7/41t5HtjofTYcH79h/XUQ2Rb5ktcGcvrWlcJwQTuTKvrH1LyMULjAvSShQjOar24jntaPCLztregX3F/N3qvldnwm+VGntInDp4lrNcC9A16ZC0i3MojpZlfeTiv26DYPZybkBCwnAnTrwVSgNn2asqsb1k14fEeUr/5pB9aRC+uw8j4s5YgdcUzY3z/0ukoOrz8CIwfT9m5IDJIKSecudrC+rf8u8fVNbcTi/AxsBFlWDdIlrIrIzvhjA0frwsthsH+EKFsgo4AN3L6DMwTy+vbvDXhmYaFpNxkIQYKkVCTSYkaQl3CxHfLlDU89l8A+ofkKvY85lnS3/t48fO3pSEes0px0gLiqmBh7nhxdv/zsk1c5ckvjsdOsgm1ASI1BjKVDjUoq+oYVCCnitmMuQng4KfAHH95ofn0m6SiD+X2KHQ5stQ4NYlt4qHXU026gcem5+0PqBjBVYY3jK7lhUOwj83w5dOGz+4sD8TXmzS5UyrOJS9rC4zmkPYmTJ651CsFeBpa/CPXSKvGdWEmTjHXRfnZSeqf6+L+OUja3k/q7Z5YAbC0yuRCnVyU9m2prd1v2KfGXdG1F1CmO04t7ShK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aOwAtwHuBAvWXqFuW4/N+rNllDpOi51iN67+sdFY9OW3pv5Km3VUaxUsaa?=
 =?iso-8859-1?Q?e0WQT2Vy1uDLFb93wIdqw6oQ6JjMkpqsqwGBlDuqMTIBuniA3FcgdFGku+?=
 =?iso-8859-1?Q?y46bbmqAGqo/FsGGAp2LTXnsJG9xAZ9Nq5s67XUqNOFdX8ykLtg/x6NrWs?=
 =?iso-8859-1?Q?qGJ8M8RV5hj0wnAw2yJFLcE2k2InOBbCM1+YaiRiiTPRx2CD16fnCupSd+?=
 =?iso-8859-1?Q?B+V2U/8N5g9r4DRhgYme6tJif7y5pfune7AVNu1y2UnNZZqCv68sa5UoL7?=
 =?iso-8859-1?Q?BlIjRRljecVsVWQsx1d6NAABNysFrcWbjDk54/GHOyuIiA9Cki8VU/QQeZ?=
 =?iso-8859-1?Q?J3LLHrB4Im4CJoYBhcoiplINgEw/hDOheE37f9TcARjWL8t8o41QWNCIx7?=
 =?iso-8859-1?Q?C1Hp17u29IQ4fM9iOb2oCE33nxXrncfNMoT6d1quvsWbbHcB1sAx77rE3J?=
 =?iso-8859-1?Q?f8r2wyH9v/mhzqg1f5EtGAiZvO9LloKvXaxMNHAKt/mq46s/xI/dL+WSYm?=
 =?iso-8859-1?Q?b/PP763wVhhGQNfyYq1snQIXFI2tvjJQ2CXtsGtwwdp3qgzkPRP5tujQ3b?=
 =?iso-8859-1?Q?qJgvX+btqxH4esdzJWbFaozcOsd1PIoj0xkdxSTkolqq5J6Y9l+9O4sFWs?=
 =?iso-8859-1?Q?KUZHLWJRbpYd1Ls+Q4TuNP9eLKS9KgKj9fA/w+R3G5jisGzmIo0OkkKNtu?=
 =?iso-8859-1?Q?26gx22WoakGEWJu7PYeVY0kzUzVFblCWG86JF5By6eYM7CvBApfTcuwBqB?=
 =?iso-8859-1?Q?LVyryM26+IedLbU4Ykqw16btaFEQy1D8KIJBuxPHqLbhQJoWs6mH23aXLU?=
 =?iso-8859-1?Q?p08ZoandK7sFVSGpgYWQXanIhIUnsfHvfK4TnpFzZ3dJv+2zujAfLNSIRR?=
 =?iso-8859-1?Q?4K01WTKwufo5LLwYh5BPNk25iNHuadAXekpnFtK3xlE6MnCSUYxfXAmhTj?=
 =?iso-8859-1?Q?vLKuqztQAEk2qcuCDO0usKPqdagf3/xu96jukkxyHQtDJzz25XazZOybyp?=
 =?iso-8859-1?Q?NQis+qsiNwLV6nL0vEZ4pqN1tAW2PZcqePtgdTehQjrPPEHEngAEd2Fb1V?=
 =?iso-8859-1?Q?8WB7zbqjn/PgLJ3KUvejA6SC0JxYtqDRURGPvJ7XhxAxUbxKwbQlDBCWg+?=
 =?iso-8859-1?Q?gO2hakAsygdkRZ9D5UgMtzBvTJsbFKQZPvhA6sy5szRQ1hK9Te8iZ1CpSO?=
 =?iso-8859-1?Q?ws1jUKZIhPLuuHzP7+1mck6IeFIX6xgTasPLsa6Heg4DO8cejmgkqoQr8c?=
 =?iso-8859-1?Q?8v/lkVfK7iSUD334FFDVMK3rDsLMPxrEcEOQuSi7pX0TwqxPd07nv0vQz9?=
 =?iso-8859-1?Q?jpdW4LBG4nxX4UVo0LY/VFht5LJpZPKbcZ2bEA62qIJFwn+rICG89Aa6jU?=
 =?iso-8859-1?Q?AY4XLW7jfcq1v+eGBOcomm/4OVtRwuOoLfw2g5zEOf10GvULfNyzNtSfel?=
 =?iso-8859-1?Q?gGxBtAY51D4q/uSx71yOLeynFhVdOLWztBOMZxzJLV34WkmL+BPtoAdFgp?=
 =?iso-8859-1?Q?kKxejzgubsj+2OUVS0ZFk4NlaAib8JPcj06SJ6Qt8LGuu7WItY/vCxmjFx?=
 =?iso-8859-1?Q?QDTIgQHdkIJPjERWAoGTj4NeINGTQR6cHRuHzfvwbvB76iONWHtAZBR1Td?=
 =?iso-8859-1?Q?D10BqJHzQlCedgoE8EcNAetAIidr5ejde/Ny/77rUxLK9vF4WMrtQAhOog?=
 =?iso-8859-1?Q?5iliWdIhJoKSYZufTtm2rJqZKwUygad+tIehKWbHS1tPVM/oyBXveGzn6k?=
 =?iso-8859-1?Q?RxW/YlJitXBB8z/P4l8Bnsk/Iw1BC678oue1vEgDDCtouOcYADAA+vcTfU?=
 =?iso-8859-1?Q?tDq4p+UKmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nT4xgxVCuIM8pCYzRSGMZukG9V2NP6L8D3KakuPvGPkx20Np02LCuGtUUmBbZh3uBzrYqoShm0X/6yn8o+9wIs7HSHPLVwNpV7iveg2aZGazGCNnpErawaxVfbzyOwY1rrpi+UZq6bsFBeTtuyXFIMblV6EHnMz6SLZOrITaZsEXn0BfawY0OmiO8q+t1EQ6uJngYlWlb3G77G9X/6OcHZ5+JcK7tJYXGEQ5LjUSuB3gGoX5MgnZRmhBD6gml9jT+GxB7vNKM7LxeOScPTJczFCOi1gRn2/afNjP0CR3IfbiziHLLLsRRo9Lhlf4U/L8Pvpc7OSZhG58eCRA+8v8Sw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95717e3b-722a-4bfe-ed93-08dee179937e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:01.4655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmEONOWr1DUqbbN4an0OdpdmKJmdIVAqMzxfTgdRAVGd+Os1eSG5VJ/+w6AaEOtWphCZUbOg0zocHkb5dnOOax/M8NZQiDu2tNjUwu1/ObM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ASPEED HACE model only emulated the hash command; the crypto (cipher)=
=0A=
command was stubbed out. On the AST2700 the kernel runs the crypto driver=
=0A=
self-tests at boot, so without crypto emulation booting floods the log=0A=
with failures:=0A=
=0A=
  root@ast2700-default:~# dmesg | grep "self"=0A=
[    6.078446] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.079295] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.089924] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.090629] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.100134] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.100416] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.100576] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.101411] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.152954] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.153701] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.180101] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.180747] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.206437] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.206910] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.215313] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.215698] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.227173] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.228027] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.276878] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
[    6.277541] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
=0A=
This series implements the HACE crypto command: AES/DES/3DES in ECB/CBC/CTR=
=0A=
over direct and scatter-gather DMA, and AES-GCM with 64-bit DMA on the=0A=
AST2700. It also adds GCM to the qcrypto cipher API (gcrypt backend) that=
=0A=
the AST2700 path needs, plus qtest and unit-test coverage.=0A=
=0A=
With crypto emulated the self-tests pass, the warnings above disappear, and=
=0A=
the temporary 'cryptomgr.notests=3D1' boot workaround in the AST2700=0A=
functional tests is dropped.=0A=
=0A=
v1:=0A=
  1. Support the crypto command in direct access mode=0A=
  2. Support scatter-gather mode for the crypto command=0A=
  3. Support the AES-GCM mode for the crypto command=0A=
  4. Support 64-bit DMA for the crypto command=0A=
  5. Test the crypto command=0A=
  6. Drop the AST2700 crypto self-test/model workaround=0A=
  =0A=
Jamin Lin (15):=0A=
  hw/misc/aspeed_hace: Support the crypto command in direct access mode=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2500=0A=
  hw/misc/aspeed_hace: Support scatter-gather mode for the crypto=0A=
    command=0A=
  hw/misc/aspeed_hace: Support the CTR mode for the crypto command=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2600=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST1030=0A=
  crypto/cipher: Add GCM to QCryptoCipherMode=0A=
  crypto/cipher: Add setaad/gettag for AEAD modes=0A=
  crypto/cipher-gcrypt: Implement AES-GCM=0A=
  tests/unit/test-crypto-cipher: Test AES-GCM mode=0A=
  hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command=0A=
  hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command=0A=
  hw/misc/aspeed_hace: Enable the crypto command on the AST2700=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2700=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Drop the AST2700 crypto=0A=
    self-test workaround=0A=
=0A=
 qapi/crypto.json                              |   4 +-=0A=
 crypto/cipherpriv.h                           |   8 +=0A=
 include/crypto/cipher.h                       |  36 +=0A=
 include/hw/misc/aspeed_hace.h                 |   1 -=0A=
 tests/qtest/aspeed-hace-utils.h               |  20 +=0A=
 crypto/cipher.c                               |  32 +=0A=
 hw/misc/aspeed_hace.c                         | 454 +++++++++++-=0A=
 tests/qtest/aspeed-hace-utils.c               | 662 ++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c                |  18 +=0A=
 tests/qtest/ast2700-hace-test.c               |   9 +=0A=
 tests/unit/test-crypto-cipher.c               | 240 +++++++=0A=
 crypto/cipher-gcrypt.c.inc                    | 101 +++=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   5 -=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   5 -=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |   5 -=0A=
 15 files changed, 1563 insertions(+), 37 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

