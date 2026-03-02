Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ABDD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEn-0000M3-6p; Mon, 02 Mar 2026 04:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEh-0000Ja-99; Mon, 02 Mar 2026 04:06:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEf-0005XC-HL; Mon, 02 Mar 2026 04:06:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEHeZli3gOx1Ub8aix6WcQ6stUqDi7wt5NHAWRxA4c7iXIS+JtMwAcb3OCNcXosmTOhwalR3hmjcosv2OHA2kre3Oa7j5aLLFGJy+XvwVuCaBfL7YnuxgcqTRRK0Pv1ALJ4wQwH1CRFkzV/Rdr2lkl/BKDwXAGzUI2jrDa7AbsFwtxrBUvJWrmVispUUlnoneWHCIfDqssjEVPjeVnocR0lXd6lnqYrtUSWzVNEcXHliI8nps5GCtwcwRT7Ypz2q1Pac439NiLLkDMgy28iIEe+6/MJfHzp2J0D1bTfBXaA0X4wcYskkCk1V6IG4Wuqa7r2pya29qxPaFnQwbnmMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAQUjBS26j7cTRY6lEjyWiTM68fcueOkJ9SFtRRgSmU=;
 b=I6z0MsvzT3fM6S7up+9Ot/YdsgVY7IJKFbB6izgM0q/ksCiAOnKP+wpTvtabAm5oguVwLOgjSWyq2tPRl6KkIwYzMWWaXsKd1F08U8MuQmsqlgzc9OywFPv7TxHcRfOdN0YaFEoE8HAAg5t0yn0IJr35AiNKM8Oy2o0gYSgHW8bmgLLp0IUemAqJfifo80dCXAyr0ZM/rQSe41RXHVo/7gasoiN3c2EejggwVYUco+8a99OB09bTe7TR4meJkqdqM8XTPJ5rh/NYFfvfJo5Q31/smlbT9lo0a7LkERu7g5olDL6wlY96EwrIfuei/mBntpTN5n3OInChmXDROEq5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAQUjBS26j7cTRY6lEjyWiTM68fcueOkJ9SFtRRgSmU=;
 b=PW4MSL9aR6zJqXH1SeHdzqkDKT2dspvrnZRi2Ff8ZvcPojjNJzm9ax+uZJ9+bEHcthwqBXcyaOitVsqKvUAtknmJHpjg1GL4SST7cV+BNI0xKI9oVBNgI5i5HPQxP2iq7U9/ZguFcaXNMkCAGAz1QPBDMd48nDHLm9FvpvmAL/wBubiude80XjHX/UbYBct3KJDHw2SC1fZ4jvJNfyt/tPFZcOaYoiH8C23Bw3m2x7GPvLfa8gLWGFLtwxKCI3IiksndBCSKvZNK0qbtyTJmYuWKAUK4Iaus3ZSSBEwB95tt1pqmaLHAefhizGoZ6my8g/vxW1GtNCSjVupLZ4dnuA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 02/10] tests/functional/arm/test_aspeed_ast1060: Update
 test aspeed-zephyr-project v03.05
Thread-Topic: [PATCH v1 02/10] tests/functional/arm/test_aspeed_ast1060:
 Update test aspeed-zephyr-project v03.05
Thread-Index: AQHcqiPaZ6QckhNN+UidpiIvLD+DnA==
Date: Mon, 2 Mar 2026 09:06:28 +0000
Message-ID: <20260302090624.987922-3-jamin_lin@aspeedtech.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: 384ac731-910c-4c56-a4ca-08de783afd65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: wj8eTmDlVclMKWnb57JS3z0kjGC8bQPsEHAppL9uxlFaeZfLQGhjxbti/7Osl85VSPOk1fGV5BFWwz5Hr/JyU7T9MGKAzsdAFUprlYLmtWJSn4UmFAAchE0W5XNdl5zP3kpScN6F0efXe+EECcjg6wkk+YPc8bduTAUsDF3nvJ0bqx6vedXAjYnFjQPAKNFDeDf9SwYwwqePvpgTW1aQcy5PulazS+3r/JCub1ITChvLX6Xzl/6pLblbeFzoAZ/MYEDAezlba+SVcpoAJYuTXwGSaccOj9z1ZSoUuQPHgYneXQlOz/qoaqsl8RoK82EQilY9a5JlsJUfq2H/oWLVnNWpaBMm4WgmrvwnGNNe9iJXRZCRW5uKtISXVG918SrsddDLt8zSDRXbm2UtiP0RwyBrlcxB5h/NwPhB4yPEZ7dnch3j6SMRZz+B7GmOTbqk6jYAnrvwbkrSGnZHOBrrkW1yjctd3Pi+yW6QEO+XARDWndVxvzjmUid+xHBqTFAfSoZJBw6nN/c7bcU8FX8LOSOsIAur9PQojwDysuAbtQIF3yCBA79RSV0aiRHAarXZMOsuzxVJb3vRUIoEuhj3j40kpVH4+Ok1FX0g/kOyCWop0r6MnZqmmsKNHi4L+3Yj+t+NTfMku0we5iA8hvWqaAXNi/b7BOeC3F261ejUJrKb0RCcDIvcjmcjty8dx0yYZOEFEvYqRCKT3Gpy8sjCK1xfWoPUobaYGfsgV7SMYr9eNv2riLK77j2bQ5GeYGfWLC7BcfYZVTLjK8+UP7tm2OCp6dT+yFl1VaXDV1J5Jyo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T1u7Tf6BLpH/SCVBtoYa8jsST0IfC31OVRGJEYMAlCzVlEf1imS/aVt2yz?=
 =?iso-8859-1?Q?f1YBkmjMeNc+pan+JoPQnCJWwY2GoahU4wfIr8EaSWZrX6SYYZIyfIPeB+?=
 =?iso-8859-1?Q?7meZBD26f9urbklB3K5rxePjAz/fBBShN+KlpR42T7qPhVgffQmanzZx6d?=
 =?iso-8859-1?Q?5FYvSvjxa6Wshe3rOTro/o13dKFi+UPQFuT29dYsB4wHwN5qLHsBKXzUnh?=
 =?iso-8859-1?Q?+tFjGSn+kXGizpLcWq1ACr6ScYaZnXLLlqqRbLwQ3y8jgjbsWm4TOyRCnt?=
 =?iso-8859-1?Q?uWfj4i7ShJiCPEMiXPun05ujWSQwJeyZZL7LLk0dh2t/SGzD0qKn+0A68c?=
 =?iso-8859-1?Q?I838XwaHn/mFU5zgZI7l/SrZv4FxCJBKugtKL7k4yOj21j7Gzgsfb6o12q?=
 =?iso-8859-1?Q?R6TGCR1mnprnnI6P1yai8O/paPeuqWgxkHIilbG+NZ0GEWQTVQ6gCVRIfu?=
 =?iso-8859-1?Q?KgLeG52HS2Pk6VqWdIXkXRbiWkSfNeEsS90JdzMtPH68kV4uAe85bmRkU4?=
 =?iso-8859-1?Q?1YUIlYhe0PGuDAjrweYkmu6IJaVxSbjlvdcB67yJ0/unU7WdNUeN12FGZD?=
 =?iso-8859-1?Q?OCOXsN+uSwgbeK1hrcVArtneGG1yp8IR6odPcyx1wo9iroanMxtOvmLmdq?=
 =?iso-8859-1?Q?ENyhIEqmsar2kG2Ug1SH2LDslr1GCYpX6uR89gecqpcUNefhj46z7ohKv/?=
 =?iso-8859-1?Q?27PMMeJX7OjQ84KnwLnLVCotZ3SwswCb0XCoViYl6fxKlBistO941Jg9d4?=
 =?iso-8859-1?Q?G8i4hmZ6zqH39Z8jNVHBLFH0US34lk0g33ZRgVz6YO7IIuR4wxKtrft7bQ?=
 =?iso-8859-1?Q?y8r+ohjhmpN75QKRu6/rODRVQdpesE+6TYWuP1L1BFL1SyqEjV7wGQtWkp?=
 =?iso-8859-1?Q?9izOWknJS93QJaByW9NBybalezCSjXfoBevm4TO2pSlfDtfIv+7cMywx9U?=
 =?iso-8859-1?Q?8zEHvFsJMVYV4GELLBsAyG6uTEg+X6NIxabqNuPSABhPBE7kbgERSzPUk6?=
 =?iso-8859-1?Q?s8tNc7QN2SNoJ2Sa+oSrzjiuKjUQ5pRjxMTMxl5RlJ0ElqfKbYD6xJQqRD?=
 =?iso-8859-1?Q?ukSwBxRDvqaCQqDMdC5jFkOLcajFjXD7k1BFs8G0KFYEr8LdCVWTCjAQOi?=
 =?iso-8859-1?Q?neC7kRK8QUUfANdV8P2mxXha+qSW36Yt6Qx3AOF9/MAdRpu3zxGYFr2KoV?=
 =?iso-8859-1?Q?eJQiPi7ZBoF90EzPoPip/S9ForAuf+qAD4eAGbumegeu6WH/qa17lk6mXz?=
 =?iso-8859-1?Q?2R+YeiMVBOoo7QpJ4qxxMa4or1zoWJGFYMc7x1n84tbHaQKQJ7B+I04DSZ?=
 =?iso-8859-1?Q?Ivr8RvPgDAs7BWJbcvtLdeSLLH9staibmZqRTfRkQq2CfU3IIF91UerP2h?=
 =?iso-8859-1?Q?0ECRO+KDgc/nIXSY7HW5QFZuSoenNL66fUMV9pcmH4zv/r4v6l2jvaO1Lz?=
 =?iso-8859-1?Q?dCqVz3j7oVFXDJ7gLGJR/0M8sgzklbVOSgliKv30AaLx2OkGjG8mltlHys?=
 =?iso-8859-1?Q?CKXwdoftw4zjhPuKvLcs4Grv3zmIFIjpkU0kn4JPlUVNigm/iEq7Tq14Sr?=
 =?iso-8859-1?Q?iUfb1h+0eMhTrOP3tp6MSRodPeJ8XmK9bCFAaofsBYi3n8Aa8kR78vYXpr?=
 =?iso-8859-1?Q?aEXVcgz+7oBzEOdOgFx6QvB44p1PTOzI9afyBX4oZl/gs0C6RYBRJIFf8N?=
 =?iso-8859-1?Q?H8oFawdGus3jS4EQjnWSh65fpZpRuRsrvBjhpHXUZrGvJUWFiDVnQecpkB?=
 =?iso-8859-1?Q?n+bJ+snT3ruMXNgDcIETcYIZKCWq40tRVEACp2nH3wSE4LHyhDmYE5Q9Be?=
 =?iso-8859-1?Q?/8GpLtyGbA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384ac731-910c-4c56-a4ca-08de783afd65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:28.7671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAFSb5OwQULi6GvAuaGoAfZuLXYknu0vx7PS7hrp/KtUYExyQuVcBiruDcb/OTwuyVkSP//sCbCGIVnGdmb9buqbUzyG6w2CbZsf1/sRoFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1060.py | 14 +++++++-------=0A=
 1 file changed, 7 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional=
/arm/test_aspeed_ast1060.py=0A=
index eccb4252d8..833cfb8272 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1060.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1060.py=0A=
@@ -11,18 +11,18 @@=0A=
 =0A=
 =0A=
 class AST1060Machine(AspeedTest):=0A=
-    ASSET_ASPEED_AST1060_PROT_3_04 =3D Asset(=0A=
+    ASSET_ASPEED_AST1060_PROT_3_05 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/aspeed-zephyr-project/releases/download/v03.04'=0A=
-         '/ast1060_prot_v03.04.tgz'),=0A=
-         'c0319df55f5b7a547efefc5a6ba374b881223d5fe1a776bfdd36f97fd1f31d50=
')=0A=
+         '/aspeed-zephyr-project/releases/download/v03.05'=0A=
+         '/ast1060_prot_v03.05.tgz'),=0A=
+         '63b36d7420290726ca80477de254474b7cb79539a42819bb1fe2665d598dadb5=
')=0A=
 =0A=
-    def test_arm_ast1060_prot_3_04(self):=0A=
+    def test_arm_ast1060_prot_3_05(self):=0A=
         self.set_machine('ast1060-evb')=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ASPEED_AST1060_PROT_3_04, member=3Dkernel_name)=0A=
+            self.ASSET_ASPEED_AST1060_PROT_3_05, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -35,7 +35,7 @@ def test_arm_ast1060_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1060-evb")=0A=
 =0A=
         kernel_name =3D "ast1060_prot/zephyr.bin"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_04,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ASPEED_AST1060_PRO=
T_3_05,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

