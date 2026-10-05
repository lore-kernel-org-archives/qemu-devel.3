Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F43CCA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 02:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDY4N-0001xb-Oi; Sun, 04 Oct 2026 22:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4K-0001wQ-96; Sun, 04 Oct 2026 22:04:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4I-00016h-Nv; Sun, 04 Oct 2026 22:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAjj4+0RnXQ4remLSahEwQ7ol6K5OBOct0bElzWtSqPgMs8AuiHThpMiYk3VW4rA6ZEKE46VR/I4PtfY83ywGplE2CGN0bhBaQcUvthDoS1LqzSUNepshchPDMHzmi4KqyqcCgKHs3pbPrYYTDCtl4IFECJPnJVZQeFz3MCzEZvKWvXP5GUWTaFP9p7PsaLCM24iITd10jzH/aChND4lJ5CjODAdF2S82SkJGQAJ1q6f6QCpRBjeSOZv/gw+5Jv3mQ9U5juiWRf3usPuAqzFXahn/mt1H/UbmDIH+sRLSikUY5x5hlXKQDQIEwjIenFs5VN6K0SEMkvAs8Fwt+BmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmcj9Y+VADji082wH9ZVtcpSafYFpP6eVlpCKGARxKs=;
 b=IzD2WGrCqlsYkRoXkO8PHuASUD88Dqb+Punjfz2GkyZY47J2SiVTfkPkaY7w47APPTtcizW4LP4H2k1QdvUH6B8Tsor0Ta2b2DLIwb4E+dqsmE11ZMeeldRFySJdXUmaaksGXfN4z90jyxLAzTadZifnpmy9nZ4Rpwq+10TlJObnQFYUmbyoTWkQjbn86g3cQwUY5Hr2xpm0C6+5xJB9Agl16XwEaWhzPvjnt/9jk88L83CLAVYQyedo3T45Jj2yqjx6z7xD5WkoG76Y284XVUKwanZeEMqPEQTrudhqNCQ+tXDwqX+7zlvq974nMHe9IGrRRyVwLJ048OcZUmRxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmcj9Y+VADji082wH9ZVtcpSafYFpP6eVlpCKGARxKs=;
 b=UvWOIC28RvFlUtez6IgAVSgFxOK4DIK79mYC3hPqkao8SgbGYLEMbApI/TqTTkWGsw2u9CkTDAiWqz9z7J7U/qS6dQzHVk+SFo9LOYM5JJ7hXliDyJDKX+xVLG9MktRaBeKzjqMIT7rGK9G+VLr5R2h5/fWhDICXzIiMyej0CsKLX4rRjqx3F/tNxvkzQX4Ex4L7G60ZCnkOchPOnM9F+bRg7nq8W2JjqstrPGHG+Mp8NHWDeJG+wcaJjbzZ2QQa9+IzbgwtcXuzKOphEShiYioBWK9ZNT6123Bb8qnx6v0TikEFP4M1qHf0QtLAUdEc+frThnJta5dppBPmcpZgyg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5833.apcprd06.prod.outlook.com (2603:1096:400:32d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 02:04:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 02:04:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/2] tests/functional/aarch64/test_aspeed_ast2700a2: Add
 I2C test for IO expander 1
Thread-Topic: [PATCH v2 2/2] tests/functional/aarch64/test_aspeed_ast2700a2:
 Add I2C test for IO expander 1
Thread-Index: AQHdVG3bh+3BL0UVrkWO+sWewEnZhQ==
Date: Mon, 5 Oct 2026 02:04:30 +0000
Message-ID: <20261005020428.3496039-3-jamin_lin@aspeedtech.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5833:EE_
x-ms-office365-filtering-correlation-id: 3867eaab-4573-4e61-cbca-08df2284fe7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: ln5bm2e78qSTzjR/N0jDBhvUGbw98yRE+r5zPmDb5KQXaYrSN+LJ3lryu1A2/ffhPhdsLtPoV/XesO1Rv2mpn0/PQWY77EW7k4PhHUXUT/MnBLZg1btSubEXOAvvmktf8TxNWRRvSk17rqoKj6eY6EN2N3aaHMN3esquVT61CnY+/htSapdTGO63NJZmMYIjFbM+2IwvQR3CCVKaYI82txaJIveYz8zcUvx5KRnrNI0WZ/VyitA/YP2Fx8kWhocuIMtUCubu8EpNnt4UhN5WOowA6nvbCelaGGqW3NAsNOg0ZRXrl3D03W8X9K+jvnL2+vX2cnq4m1YhPxhdvxrxM9xVGbTWfm4lVUL+ZpJcDV3gHip//17rXFrdiRoD9Dju5KLkBqk5lU4FlvwPTtnOuyrbk8ab6OkbX0zGjlpn7DWnduIhprWXY4FRf3fPSAeBZcETm81p59/Qr2FKET29fW7oTf8jdNGiQ5nL4AU3uOQgU6t9bO9K69jVUjpYIvCsT71NAovPI02hTTv9Tvq5hJlUTv7gKBvqpppUKdBfWBQbArFIqj30+7g8aCJn6jhQ9r3n7RQMpwi7eX6vOERFBD3DRozVfI+tGTvzqQulRD+K2LdIxK/LkWJ/AQO/Uv3Z0beS9EkMHH0E19tSdv7s8HqGrAol+2Y9Pwf1vbhpRww25mUz7E2OxuSC3XH86fX5CrNWPqHeinLudNNamj5kb3WRFHxUtEfIxgIUHBg6Ikg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VoCeGu+b88YYUX6Evu8OQIqhfcHJmLx6UpIykVoYfZa47DFQpMY148Oxsa?=
 =?iso-8859-1?Q?XSjJ5VqvlOJEVDUqAp3Li7Hlh8LPY3HDzq575kwJRP8Stqiof13GWqrZyj?=
 =?iso-8859-1?Q?K0hPU62Wys2DhJwOyI1bkoCf8Fow4lBTGRl79LvzQbEyVL6YJtShVX6g1E?=
 =?iso-8859-1?Q?kKSZpm5QpQM4msD00WJgCd0bCyegUl9Wyze1cGV5JGACQ30ck4x9CuwtcC?=
 =?iso-8859-1?Q?718ssFJ9KT/DRJfRVfeN/rus0oMXjEvTn1DAJNL9XkD5P5CE4ZFbSMSgrH?=
 =?iso-8859-1?Q?2BZ0f7OXNBAhAL1sEFxnZesyDeLSq+dsAE/qFFGrHYsZWyDm89DigMX1Rt?=
 =?iso-8859-1?Q?5Z5zqG2hCfR54Z8yND3+k8fviAx1PNGYoKzJp+9jlmtzDNaqOVWpz3lv8/?=
 =?iso-8859-1?Q?/E6GWZNl7ngU+KtcB6gJdr8vEXSIvsHp2vTjHN6pbQMe3tTwzyZ6wGzgqJ?=
 =?iso-8859-1?Q?xVGiv3FtvaF82Qs11gEvdpGTOrMAIWWbJ8vlSu1IOEZ+d3haVtqiVMssVO?=
 =?iso-8859-1?Q?kjFvj4ezUFFDMKMvC+f0u3/sdYmHZS99DRieKVJknurgHx5mUEqGcs45VV?=
 =?iso-8859-1?Q?alyw0uwexduy9cSU4aZ3EcTB7ZzdpX4+EtdRdvNNoRz59aKSoP6kqQp81+?=
 =?iso-8859-1?Q?FLIwZ0nmVtIRx2OFpdX7dEpF7bUi2zgAXiRT3ii4GMr1ZQV/kRhRBEmB95?=
 =?iso-8859-1?Q?4KiyUFE/QtqOwJmDk0pv3/x0EUZC7xrkRyo+uHnFhIsAveGowePgcGQ8M2?=
 =?iso-8859-1?Q?MQJXRahxQLGu1vSeGcHGLn1A1YyYrxuSnOLumPikY5Qv4OjS+b5DsOiZo8?=
 =?iso-8859-1?Q?roOgiHBE0deqWyVFQOTO3F2UYOo5wedZ530a/VqA8yUI82JCIPb79JqkQp?=
 =?iso-8859-1?Q?MWJTZ/oUoZmg4t22/D05yi0F8KWLc5GYq7V+dD9ByrzRWdkEXcr5fkW8At?=
 =?iso-8859-1?Q?zEUf9cC6F8d/mIAKuWW0M+Y8SLJqWZBe6pjXmSdj6SA3e2VGMqt9B3vuMc?=
 =?iso-8859-1?Q?mjFHnsP3knUmSoq8aKbZ24KZtzXLwXKPKX9l/JybobPgKiOjnn63orsxt9?=
 =?iso-8859-1?Q?BnXxn16yLBUvoD/xLdYUsG4N5q7yC5+bWN1HoR/EudGE5Yd2it5X7X8jpn?=
 =?iso-8859-1?Q?KQ+LNje40VCOEu+0XHa4j+XtwAWvncwZyYQvQvt/47NwRIBUAdRVaTNpNN?=
 =?iso-8859-1?Q?22X5EJiCY9cSPPgDtQEXO7AbjgjmnHRwZl5mvOUbWVlU6ZfDfuOcxDQUpA?=
 =?iso-8859-1?Q?BJIziq3wKRfDgwRU9i4ikKIN/m2Wl1N+UlIxB5KdWIS33rPdcZVOy1cxVE?=
 =?iso-8859-1?Q?/zhF/tzmrYd+6kKpS/W4yWKgwKRaI+YKLjxfH3I5ggLL1o3Mxh0wXW22TG?=
 =?iso-8859-1?Q?epR4j/F7x+ncoBclV2aJayIkniPr3n3QkyPp5stDTAYqnzZ0KTVVkQiJYx?=
 =?iso-8859-1?Q?VuZO7lcWeVYmlxJi+Ht0Di+Gy3gCNx0FYCrBUHXqJz+r0Xo1IQQrxd5Pom?=
 =?iso-8859-1?Q?6HvGUGxpWKhdCKh+fVzfvsqwnRnc08qKzE96hu+WtFTBNFBBqV6DkF5HAy?=
 =?iso-8859-1?Q?acPH69KK156IpLWNMIGvhYh7Hvu0XPbfEjZxlFadSX51WYt0kblTsiaYTs?=
 =?iso-8859-1?Q?zQ/LPnBcmjbTevB6oXGxYGjO62cxoQKlK/rhFx94RgfQUzjvZ/SNolJnjO?=
 =?iso-8859-1?Q?O7wRCTzwc1y9Q5jtJdoHkN8TklMyOoBUuo2iAB+GooyU/EXej8tcGAdMe4?=
 =?iso-8859-1?Q?1LQQ1Ptmgc6Oye/Jm2anjbfa0b7OHpQYYzJ1VttN+l4tb0CUQC+GR0YlIw?=
 =?iso-8859-1?Q?iwxFIdZlmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: omsOblvd8SorEkd3UYhGPh36kPB/ZtUPTNFcGgni86mQ0/Au8LjEfsymoNqC56TEJGX/GGsmRkYZXvvh38SK9TRpvmXP31rNXsX/T2GL8e50sJ2TI2iT6tcjVvBqK0t773CRUQx53JE5DZZHlRFnAPiW0dl6FJLhx+m0GuPpPGLedlXOfl0u0hBgQVcj0oShdQKR62aKYrhazts9VdDNIK9ap2EkGa7b8ShFL75diJ2Ihp0zBh0AJBg2hlXdutG/wku/Wh9SyOesJkyFCOVVsLBktxRarVGP8LBFHXhZX/v/k16RjwNtPJmbQBnivbkc4ia+VKMBTWcb+Sdzlg7K4Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3867eaab-4573-4e61-cbca-08df2284fe7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 02:04:30.9910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neL4TRZ6lyaX4Nuo0Gv/2GZd/lW6Z+bw9bm0ZvEnrJmOUhXfVX1f/0Eeu0Txf+Cu3gbvQkmA9rkbJtJr3iP9ExPUvlGfprD7eYHY+4/uy7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5833
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The IO expander test only checks the I2C bus of IO expander 0. The I2C=0A=
buses of IO expander 1 are not tested, so a wrong interrupt wiring for=0A=
IO expander 1 can not be detected.=0A=
=0A=
Add a TMP105 device on the first I2C bus of IO expander 1 and check that=0A=
it can be read from firmware.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index 01c7c4fdbe..74ef93fc0d 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -196,10 +196,13 @@ def test_aarch64_ast2700a2_evb_ioexp_v11_03(self):=0A=
         self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp1.0,address=3D0x4d,id=3Dtmp-te=
st-32')=0A=
         self.start_ast2700_test('ast2700-dcscm-image', 8)=0A=
         self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
         self.do_ast2700_i2c_test(8)=0A=
         self.do_ast2700_i2c_test(16)=0A=
+        self.do_ast2700_i2c_test(32)=0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
     QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=

