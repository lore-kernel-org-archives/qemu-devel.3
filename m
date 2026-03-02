Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A598D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEw-0000UE-Mh; Mon, 02 Mar 2026 04:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEo-0000MT-9e; Mon, 02 Mar 2026 04:06:50 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEm-0005XC-R3; Mon, 02 Mar 2026 04:06:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB9DbwpoG/S7o5sbz1Q2a8HM8Y1s2GG/VLp65UzMjHTzL6H4gQNmgVl7TkxL9jsmD/y74WYrEPK4j/HxJEKZOa5nz0J0CA2/TLQ3Bx+f5UWU2syEBwA82CMXnJMlfrsrdfB91eBUJtHX45co4tY3ToSXcUSrDFXqj1Y91sVhdOXAIO28LsBYBp/eoIWlbIR7SRjiwRumMFGVJG3VZR2CL+fYsjrHOd3EYcig3JSQ2jTFxr5AqrnM0UE3XmNr1eLnMfVbO4BMgOKr3zvj2yddGKrogNhlGikFE8NmJdkkJHf2495xXHIMT9Opjg/1WBxlzV6HHcCC/sMWRwb9VP7SVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj7n3mwCZdFYVYI0K/gOh6vWizvzZoOmQBZTL3W+vlQ=;
 b=W7wZ5iEn5kkbwORYgL2X5Wvy+twRMkorkjaTid+/r9hzRd38DO9GAh3CSfeUJ6czqG1OzNG9gc+FrV5wV8DQC41tRYT8dPYRJ5rHp6nZbi5vpN0JfcErnwQZ5h7Ma4Bc35X0Naa2aRKDL3lXQJ1+ofq8HUJMXl2h7q5OQrTFNDED5bEYwtxHbp1iL6qBmooqKiejcs9S/u9LONQsfPyEZXbG0G6LTSULvsdWzMbSaac7A087G6Qre9bLzCCKkcWB4332AKl6GK3qz3AGC54wQj0Eg1zX79MyXhLu6cU+sBAtOTk/OwVhar6dIMVy+PTYM1YCWPvFKjVClYrIy8oE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj7n3mwCZdFYVYI0K/gOh6vWizvzZoOmQBZTL3W+vlQ=;
 b=bA8LHTGf1RTPcfoIv/mcTXqCajgljQAme1pTE7urjLvnVX58+TWVL3ZWbDGbFqpKoy2ZA6E8JRuakOouShN011nOokkRmvtB08JQYSEPkY/4Xkv/0Gc+fv082q/xfdTsQyXn8ouDOTLTLjI6ONRB0iY8BJpayYUUGOfacxTQN4j4SFtwYuwK4RyU3dssP05mwbh9/c0ykLdeldRlC0xyXar9jIs7jV7Se50VGD09qKsMHtnSEf3ncEJRqLVxG77wNoomYM51a3wU1tVHmMWJzSihomgbcxvp0Gdz0b98pEy77DnLM+Bec4i2h1AJElMdt0+PitigmgZ4vcY0SkD+UA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 07/10] tests/functional/arm/test_aspeed_ast2600_sdk_515:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 07/10]
 tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqiPeHvxB2Vn680mm0I0DgCYbdw==
Date: Mon, 2 Mar 2026 09:06:35 +0000
Message-ID: <20260302090624.987922-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6dc41556-d302-4f53-0a17-08de783b0123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: vRgO1rxskXa0KiK5gJg7V2TKBUR0LUxtuLgB7ee+X4fjlsnclTfXsswRAMSuVkPAsRIaxnbb9Pyt0afIYSH3tywY0cGkY6q6k3ivzIQVgZcklGuOZFb7kqH20cwlKo+pYTB8UifJMkEhAW2Q+BcRlYjYLqJha4cXfZS2APdPxGMkGkcVnfxGV9gpKHSb3hZzfyC0BUBeSaCokuEcLzZeCFDrDIkEF0ttE9H/h5XDJbaVMfvHCYmbjxTGfZ3JdYpN32/JLlgsl6HmJaTmx8mleKo5gbPh+tDSFifvwkdG/YHpjmdbJcn7XSe6VgTr8xDSUltY7+YytbxsoYAMmF/oQE5Jsss8yyQvoe9Kwy2asb9U9XajJdqaHwYkxk6VMQK3r8Ict3lKoARJSZn1cU6YIHES8G9357xN4K259FZvWa9dy+lnx75ekt/L1EbgKYzqSiW1Dzw3KBqqxVOKYmpqhvIiiFJ6YTCuwi103UWiYuYL8VAcZ5MiiXK0Uc/3BMYh3p/fhiZlddajm1tf8oZuw44isYdVxxwGJ+66shQnT9p9TmO1Z18qeoxw4JqpvjCZeV4MJNneCyKj7nkLJPDxEYkoG3VzfSrgh6HL4ivd7CxheViD4qn1urIO4UpV2hZ4R3xQQNPU4FyzLxFTHPr6Kvtg7p66kiacDZRQL3nZjdlDDhjpZsC9ppHYr8ND+9W7hHFiCyT9if1IfKk2/t61hMLRNIjbWVBgz8aUzkmrNXmXZWVcr97KEHdxf0HGLizu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sXgZ/95LP65Ip6fEs/aMKmwp4Ktyj+lb42ELPIFlyLdUK7Vmql7pI0eFJe?=
 =?iso-8859-1?Q?zjJ/ZgIlKluqfcYMOKbqZd8qRH4i3YVRPOABksTnyrk3Qd58IwiDBUR5uJ?=
 =?iso-8859-1?Q?+23XLFgEi7tMSjfpNsuFjHBHS1yROUFCRc9Z9yalakJQD0jUzrWqR+UOGb?=
 =?iso-8859-1?Q?vD/WqznNvvDgvI75mL5k58k1fh8GcJdXdIHLZjJBHlTDPQTP/njt/2gt6O?=
 =?iso-8859-1?Q?LqiAV28ii86V5RgVcESoSS0OUhLny7POpUHicWahaiSGzuyEmLs4ThsBaQ?=
 =?iso-8859-1?Q?8wAY818Exc/lrLUnAxCxa1Y+GeoxtZ1exqTC3rx29/xrrIVhCY7htTXet1?=
 =?iso-8859-1?Q?q8AS+Dg3OldNRAioX6fYGP2mpy1X68KtdvoLnXDDjlgVH4QfyoeCSJ+TfA?=
 =?iso-8859-1?Q?05j0SfMhNUoaE9W0hQUdLB3Xt90FcIX1lK+/RgFRQE1HWv1cza/YoxhMPC?=
 =?iso-8859-1?Q?5XYfg3tEIymL6tdPsv9OC+vjMfHNKKWBfClKd8O4yQbECC0Rk+nM+fgKWu?=
 =?iso-8859-1?Q?jjFTljWZE2RBhBLM/fCqQifa+J4J7PvkM7XfUtuU3UPRdsDx3Myr/+LOKw?=
 =?iso-8859-1?Q?F8dUKXlyV8d/BmFzF1zXcN9JdH509zVsQYmQZscdfX4in8/fHtngCH78jj?=
 =?iso-8859-1?Q?EBj2H1wjnCHok/dBmwT3rOiHwaz0RmARbfVMA9sd5D7s53tG+Z6P0aUlfu?=
 =?iso-8859-1?Q?kI8psEHxO6OdDS6c/kmFKOqnY7iZHpq9nkxUomEGJpx7yVfi1Eq/bG03Zp?=
 =?iso-8859-1?Q?EdGD0nHtVfpfa/LVTaS6unbTXUUeMEbTUQOnhFD1NtKyYRxGYyQDgl4P1l?=
 =?iso-8859-1?Q?FKjsYGNzVuOFRQOvIS5rFJYkKv2Bo8pt98mWwZWILdqeimXKyFWi7hkiIx?=
 =?iso-8859-1?Q?mzg47cgOCGYANfic9tP2rVfjLHwezcNXyvuaNDK5gAhOArbNbcaRm8S2f4?=
 =?iso-8859-1?Q?0PmhttHT9U5AVC8TcNhWX4U4man8F2W3BeBb+SLzl60E63ifUtZMgNv+xY?=
 =?iso-8859-1?Q?JXJuOnO1sshWPeLfmbhqHCm3s2xeITFJqGsH2Djj9ms4W3pNubFLFBBNas?=
 =?iso-8859-1?Q?+tOse6QHRPOesXr4I2BUhFnlxSu6BjFslTBu5hl6UqE6g8AHg7UGk257ED?=
 =?iso-8859-1?Q?xqpnc+RsCbZ3ZyTGTN4FqY2lw06+4gw9IGgti29td3PkgWNmFU4xUQRDCV?=
 =?iso-8859-1?Q?yQKDnnfZC7N01aYZPy6JKko2H1pvChys/Th/gWFQRDE7S0MzJ8nor+QEWY?=
 =?iso-8859-1?Q?dM/L9Yv7ZmRity86zb2X5XwKmjO1ucnXt8gIRvE3IwnchaykQJd2ZNZdJ7?=
 =?iso-8859-1?Q?WX5/C/dZxr6cSb1e21QwGtSsDFiNLzbSAzJKSlhoRDSGT/0lrhMf7EJb9t?=
 =?iso-8859-1?Q?BIKfX2e+BIwG+b3cARYyg9Xm6KzisHVbSFC8cMjNMzf2ig/u1vUTLFcg8s?=
 =?iso-8859-1?Q?Hwu/GcN3b8erJ4HjTOxpc2JNlgYBMK4Oz4yHdkOmenmyA0L+hB1wUPs8Vv?=
 =?iso-8859-1?Q?dH1ssj9oqvqdsiFo28Y46mOD+PFSQxu3a+QP0+SPvg7F3jT37n8HlqK4Ng?=
 =?iso-8859-1?Q?BE8s22Xy3/uDkcmJrigzVRXeEznvNfhsFMS3+uURjWikjeAIuyyHLALd/V?=
 =?iso-8859-1?Q?ZS/x44dhKmIMLoU38uZWzr8xKn/wrP65IT2aoWcduAM5sRVWKA6YIl6Q8Z?=
 =?iso-8859-1?Q?FjnvK229ksw2/ugxdo8r4Z7uwyxAaotABEcSHib1UpzX+mwvKClLzT+0Pm?=
 =?iso-8859-1?Q?ZR/XQGeuFI+vBCIZ0fyqrl+A1KFKa8J2bY/j2Rgx9yK08feEvcTDdZGzJu?=
 =?iso-8859-1?Q?yszHQfchfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc41556-d302-4f53-0a17-08de783b0123
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:35.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tn+Qa3HuNnUCKZiN5y0feTzfzw1DlL1fqtV00zkloqXcEDgytsDdLOfBRfvttVcE7pwhL7r+7AXU9zUBwaCZbSDD+lJ7q7ZCkY0sPq+CaVQ=
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
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_515.py=0A=
index f48da301d5..ec043e7d61 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
@@ -10,17 +10,17 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1100_AST2600_515 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
0/ast2600-default-515-obmc.tar.gz',=0A=
-        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6'=
)=0A=
+    ASSET_SDK_V1101_AST2600_515 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-515-image.tar.gz',=0A=
+        'f3ccf1c08db71cf891637fc73131b80b2c0c0e005c06d5dcae0cf74fc458b43c'=
)=0A=
 =0A=
     def test_arm_ast2600_evb_sdk_515(self):=0A=
         self.set_machine('ast2600-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600_515)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600_515)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default-515", "image-bmc"))=0A=
+            self.scratch_file("ast2600-default-515-image", "image-bmc"))=
=0A=
 =0A=
         self.wait_for_console_pattern('ast2600-default-515 login:')=0A=
 =0A=
-- =0A=
2.43.0=0A=

