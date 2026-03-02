Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DABD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEm-0000LW-Nj; Mon, 02 Mar 2026 04:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEd-0000IE-QB; Mon, 02 Mar 2026 04:06:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEc-0005WZ-9z; Mon, 02 Mar 2026 04:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMKokAKHwhvTexIX9oEKsEiujuaT+8hEyuma6kgTBUUY7Q7RJ/GrMo/7rAYnO/X2bYL8lkaM8jRV1aIdr511WCLBB6HGTVXcCaJuWnCEr143L/1+8BuYV2zwvHHXAM/psJTPof7vfEv1e+rE0vk+BWxE57pYGhwJeEJWnMujRgqILi7bYzV5CMLQsAe25hBtTCABqYt90BGAHdNwqu6ica27mE3GwdhAlxqACFU/JmxqoS4NMFDkGSl+tLFntJJkAZ6bcGJ1pRPwja3HVwq9+O/uVsYf2mWi4yqffJMXrvTrfQKRKvlB3u7m9ebz8D6iIyFBZ1g/XAIlLq6GK8/P5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycYRALu1JH6hsy+4RlhIofVAvgmnbgCvNWCI8voFiuA=;
 b=SD03n1ys0jB4210SqH6AUsVG/GUG++aGQPPnWQQZpjn9HhhoeWZhuHWPYYDLoTBENVLuBfHQQEO+6mvyIeeAoJ6pLl+8teBXAYeyU/Mg8UfwooRlw77VuKpGa+Z3HG06TTBKCKgJEcOQIe/k1miHXW2aWth76NpdKjO9PSdn7sTxlbloACnxmSXFCdqGn6Hl4wX6hOgIHAwDgK/7ehv+CCAgEzAM6kG7YL2Gt0PvIdvDx39AbQawmAOWCzd0FCrfoWf7iPnikmGxDM5DmqDe7gt8cI/hlcHyUb6LX9b0aaUC1wH3ug2YkjBfwmJiuOkXmEHAqtZXUGOQxGW3FyfbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycYRALu1JH6hsy+4RlhIofVAvgmnbgCvNWCI8voFiuA=;
 b=c2Nz/ufR4WOOOq7dpba2w+boQByIh2LOSt+BOgRgq75YDKr9a1TUJDN5RN/welSqY7/vZdpqYeygCuGcgHi9ouyxIDDt916UT9x0+Q04Pv4SCQZVoAhZqFZYXPU0Wpk/WpMrpCXwRSyu19mgYyVX8ArLM982PQTuvxHQTAnVPhs9FBp7EHTSPk2GAlk0+aEYnA9r5oK2ZZHI5mC+woNhwrXlblrd4KuoRRuu5IUPL3VrMqeFyAhxT0xjk7OK2ZSjCebxunyhIHk2vxgOVJDVY67IqaZbPOXR0AVV1d3RsISjnqOCDey07KHmhzYAo47tQJZfoBhutVzc7geSwjS/tw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 01/10] tests/functional/arm/test_aspeed_ast1030: Update
 test ASPEED Zephyr SDK v03.06
Thread-Topic: [PATCH v1 01/10] tests/functional/arm/test_aspeed_ast1030:
 Update test ASPEED Zephyr SDK v03.06
Thread-Index: AQHcqiPaT3TQn7IjTkKbvop069/+kA==
Date: Mon, 2 Mar 2026 09:06:27 +0000
Message-ID: <20260302090624.987922-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 7442f7e9-279e-4f18-fa8c-08de783afc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: svYaPsWKinjSvqtdWTytvas8FrGp4u5cqdHbv2J+cGvDICk8z/rBeMh9lLr6CwNLTMyapTdNMGEy1QaLLD9Wj+BXirHTuEuaaenbq5q4bJpblqhauS5DaClUIMsGsjU1gXkBeCVO9G+TqY2UuhNqy+kED51EYrFP74d3x+PE1q9V+qmLIqiaJaIKNoeRjMigNCd5DW3xk0YeWWvT6JYDnl/PUWYtz/yn1S+BoUZkWGyvFtDIDuIzLQ7sNFHzukwI0dng6BmIc8HW/0QsTmUnei7CrusU9oYKOb4kLwE++p3eHVzrGwGqDGNWUENNK41D3E0Qjog2OktCaALUaFxLbfP3CRaD4HoIH2MmFnM36XolTcn19wUHQW3JX4p9k5EHzvf/NeYZfNIt01BgdYIzMuFtZ7EwWoEe1wc1ABhXUXEmg8QZB96YsxJi1EEABoAJJ3wGIxc9zqDfKTVPkP2OT07zWsbmj1PqmyVzu8BeOd3iOl/7FIbokYpkIFk2ZgzauB/oAQBJA0P8srDqclB8XznjstVj/2ujxXMwtvyv96RFWxVfNWYexs4MVwUVuoRTNpmG0dWt4tCqu2Tdv+dIUXXg/wnpDxAn1LwO3UJPh6uYNe4H5P/wRYNrEe92nIM0xpVi6psYkADWp5O2iCIhmf1aq98MjMpOd3l3piBKC3vty9vsD9GYO7xiNFNsNHFeHiwYYzqIdOZ8dgm6Z8ahRKaE7G0C17Zd/Zq3H+lHtlFvlmY2cSmNWyPyfvxOLY1dK9yt8Yny9P1odBPv3n97sGzgjpE21/ErR1ZV75B0vVI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+P4LvDkm4eQp5PYh9bz4lE5UYQ8ubBdsZEQGeJbFDCYWii1Q9vqwUVI0+4?=
 =?iso-8859-1?Q?YsDey7vMCSfqXDDPLsBt/xnDhjFYOeEEiTATu/J8mRpvbSpAuz0VFkGt47?=
 =?iso-8859-1?Q?+zP+5v2syVJG446ODuZesD90TswJNGhoZI+1JvoloSP04pW6KlB4BHF/Rb?=
 =?iso-8859-1?Q?vohAznQp4NDTexRYjLLKN/D0e7D/WHYB0tpfi7a8VaLLXqlO2mNtEKBSme?=
 =?iso-8859-1?Q?Fq+hw1O+fDw+/2tSJIFEvb4d3ELVaCsoG3jOdJwG4yCrGr7jF7+PyVwFKA?=
 =?iso-8859-1?Q?uu4L2OluvjLw0GIrQfMI43ItUF+LEsJEOsifRtTUrE8uCB3U0lWY3f9+3V?=
 =?iso-8859-1?Q?UxjhtjYadAvLA5olgKpaLkNGDsxj53kYFGUHr3iAL0qJFIONbKdasyYkLY?=
 =?iso-8859-1?Q?fM6iXnN0AzicJ0/wo/jpvyc0OpadKAVauhT2XAF77MEttPSVT5iLpqGAOe?=
 =?iso-8859-1?Q?xVlA1MWFdhtgxAwypW6A8fht6ykRNlOdt46JyED7+GoLI+V707XC9Z27Db?=
 =?iso-8859-1?Q?I97SlvLwkrkNrG7p6Z8nU+yi0AA0QB583RIeEl44sw70boxWyLAmR/voht?=
 =?iso-8859-1?Q?k30g+/WcwF8acQ1QZHKVJ11N3cyNhoYPjix4YUD7IgnW4PDj69tjO/k3QM?=
 =?iso-8859-1?Q?uzScqdgzWeKiJYihBk6OfBueiS8ZMQ2FsvffoLu7RyhjiIZ95y5pgyTvcK?=
 =?iso-8859-1?Q?cvXvk0+k0J+TVvYTiW4KdeOFdTurkmUhAJSdT+qg/o6uAswh6tsOOHNtML?=
 =?iso-8859-1?Q?Ciy1d9xM6KBjbg3skAWCCUeB/bFD4ig+RtsOruQo9iaaK+DA/CirX0f95M?=
 =?iso-8859-1?Q?3wRzHQrni4kTUnvm690pOJ7ChHNzyuD2e5dVIwQ8mzeU/FU/Xvf7J/RjI0?=
 =?iso-8859-1?Q?A8FAlZk1mKr8na5MQyeR61825cJY1vih9RBIFjM+dgSnYKA2j8GMUUolUr?=
 =?iso-8859-1?Q?klBkG53U3zJo3f500TGAaNGPKqi1A36mduW4fAJ7dsGoZYO0j376gcDxNh?=
 =?iso-8859-1?Q?QPhn9m69BuszBbN0UM6dE9bsnyK1E4u26z/wJhjxfIyyGI0daUmNDL5JBp?=
 =?iso-8859-1?Q?8DDL/L8KEZtoRmwCN/A8yJJGO7wBw4wx3Hd7XY6UsY1inXAdtpKSFeU8TI?=
 =?iso-8859-1?Q?BekcAUr4C5+z1ZqzLf3anlAGUzG6kb2mjn47m17BqYZJC6Xgq0nVRtQ2K+?=
 =?iso-8859-1?Q?lRsI2kpyfK3PImqAPrXjLj1T1dhf6NBhZwc89FMaDhAf/GWVcY7cJQRJ/0?=
 =?iso-8859-1?Q?iEgD2UIYVqn5Tk6fhlrJ2Dw8RFlT62tXchOk+8koA+HRjMythuISgNIZN9?=
 =?iso-8859-1?Q?NUoiOidvqhf74Kk2v/kkrOCneTfgE4V384JnROo91+Na46w7cCk1c8R4uQ?=
 =?iso-8859-1?Q?//k/1P9kYPn4KJ6AL1B+P/B59NDlFbHwcsOsJLjIjo2p+sorUI5x0sq47K?=
 =?iso-8859-1?Q?g+CdZ/gWtJSWY4Sip1NM/IwwqqIa1tPKSTcTIctEZL7W6OctbNnm2khcWL?=
 =?iso-8859-1?Q?MXHkRAK0R/J98zZsbqyJt6Xu9NEVignv9W4sfX25dhyqKVXsxd3FW1wjie?=
 =?iso-8859-1?Q?txbUU7jhzGOW9T8MdiNxl1/NoHZIJe8yKsJJ9Bwt9yPyDl3gxMi2W29wIU?=
 =?iso-8859-1?Q?pUPUK9mWAHcKcjKi3n78rzdXHJMOcOvJv9dgONfjGd4MVT4siN+bJJ73kf?=
 =?iso-8859-1?Q?Qp3D9bcOb7DeGZxzHhW7WZY5fIQHikVcCi1FNehpbRXYXgvt+CyBU5yWQz?=
 =?iso-8859-1?Q?BVH9Dv0TT6YCTXcsrHqveup8k7b7tl11PayenlcJZ124hJRQSGTsEVKeov?=
 =?iso-8859-1?Q?+iPIEwWp6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442f7e9-279e-4f18-fa8c-08de783afc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:27.4609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pys823anslaFv5XdsqJyDUwy/BFNEsKdWZvvtIs40PcMC3uGRneUhKImT4HcfqH+kOibZD6yXP+G2w0kVWefI+mZ4YYLhVRm6EENTy5EUUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1030.py | 12 ++++++------=0A=
 1 file changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 0defa7c38e..03fee55b5f 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1030.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1030.py=0A=
@@ -12,17 +12,17 @@=0A=
 =0A=
 class AST1030Machine(AspeedTest):=0A=
 =0A=
-    ASSET_ZEPHYR_3_05 =3D Asset(=0A=
+    ASSET_ZEPHYR_3_06 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/zephyr/releases/download/v00.03.05/ast1030-evb-demo.zip'),=0A=
-         '057528d343490b1fbb5a721e91084b4f04fec60dc114bd65e724554f9c217f4b=
')=0A=
+         '/zephyr/releases/download/v00.03.06/ast1030-evb-demo.zip'),=0A=
+         '056f37fcd9f165308cedca3a08f2bed37ed40c0a1402c4fa515613b80a369f38=
')=0A=
 =0A=
-    def test_arm_ast1030_zephyros_3_05(self):=0A=
+    def test_arm_ast1030_zephyros_3_06(self):=0A=
         self.set_machine('ast1030-evb')=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ZEPHYR_3_05, member=3Dkernel_name)=0A=
+            self.ASSET_ZEPHYR_3_06, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -72,7 +72,7 @@ def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_05,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_06,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

