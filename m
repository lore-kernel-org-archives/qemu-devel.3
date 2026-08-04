Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB2AC5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrANv-0004st-19; Tue, 04 Aug 2026 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANk-0004qa-9w; Tue, 04 Aug 2026 04:20:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANi-0007MM-DQ; Tue, 04 Aug 2026 04:20:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFmOYzQrA6OR/gJRrUp87x8zkGInse2XtkemJLzMi/rZjpHPVz1oQf/1Kmd0zrV92jNUZAg45CQ+ja5Lf+Sp2kVpzcCZnT+Fw8AhJjstvMtpubLWyrSARG+awrnw62TDPBEV2FnNHDrYK8LjUOMIDCV5FcG5iYWS4NCc+S6u26icEFPxlqr9CrXi9qF97xUq8J7YT7TMOqkVSKA/nlen0PvG6HSi+yHDAwODfu5TItYTgLKFf4RhNBIqs+UxgtnA0FlCc/7dtdiaMjFiFgh6DRZT4/algTexaNSWqckUoQnHXu57LG067L4GtrwhOsDZeibmspUKfcM5fTGtWNIqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeLs8Ljb62kdnNzZL5Kchrmd9Al8a4vv69YlciAMDjU=;
 b=EE9AyL+++nnzXrIkHWhc1H7I2OLUisC8/0BsWmwEd7nsYyqCetLQK7GuHZwC8DAC4gAO2m6OnaXF/qHlP/5ZboYKpexEcloJht3QIMaWsiWDJvHn3SWOo1LtpqMQ3US1o8MiQDKOOp6KaOaDYA7WGnZqDqyB5v3ysTrFZ4+M9qtBQyVPoXTcsD2VsngICXLaTFx/OWyWtGsHjEeP2tWZB/AHuyPxDyJYApvxvySIIFY+hPt/LoFFHOBivAsmV7HEIrOaxWbnhJ41fpt6akpdYzdT5BOWyMqErExJ38bJyMagned8MNEq/8R337SJ0buT8n1BOIMndfv9FjEQGZfreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeLs8Ljb62kdnNzZL5Kchrmd9Al8a4vv69YlciAMDjU=;
 b=QNo+dUhp+epCAykUrISIctuzU9GdYYPNJhY/+2Sj151f48XE5bj3DEF3LzkPuJZX3eBTr8q7NYBMvmOOfGryFw7HIn5EumZlIqutzjdaQAvjFDs2ZklLnq+yJYQ+27L0+hYfVG9gcLcbk/KVKEc52OXMOGAq0Em8kla2wyWakvshtM3JxEyqVoxu5xNwd63h00NhX0C8pR/Uphrs6Xw7vhAx8QuxA89MAcnFgHmCbhaeftJtzDd4Zzo8+DI7D8XnLuN8fbriMMMnrQmHK7or7oyExl7BDC+CCXxHTBXLRZ7pKafx73JwGUNRE2U/nUx1nZdTGTnf4B8Sj7POJqc15w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6961.apcprd06.prod.outlook.com (2603:1096:820:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/8] tests/functional/aarch64/test_aspeed_ast2700a1: Update
 ASPEED SDK v11.03
Thread-Topic: [PATCH v1 3/8] tests/functional/aarch64/test_aspeed_ast2700a1:
 Update ASPEED SDK v11.03
Thread-Index: AQHdI+oK0uJho8B+PEG76jDdoSzlbw==
Date: Tue, 4 Aug 2026 08:20:00 +0000
Message-ID: <20260804081955.1563537-4-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6961:EE_
x-ms-office365-filtering-correlation-id: 8fa3f039-422d-43f3-7c83-08def2012d5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: WtrS14J75BQifkDrh2LWfYfHpxck/O4888tdDEC0SGnoILdDsQTiG0/So7yoKEL5EU+EJ90NZkOJrpTKQxNfou/m46wHfCGn2YvYR8oqF/zcaeooRyNWq9/hUGSa29sGphQZ18gAQ7+GfaWyi14M3Zyt6HteBC4iu6ix2wwRMxGRORkqmlMd3UCL6bDDqYmvMPmziuay498zK8H4QvF3fJWqNlnKV6WksIus6YiUcnzpEFT6pnJyvCsp81M5kMqMTyMPyBP7P6CVRMUrfeN9u65us8l8/WKWK56XZ2gMbovDIy73cwA8koKr0NHmLdhdofVNk2Fk/ZWqWA2OLm5aLt75LZs7Z58wP/4ZS965JbbYyVARsF25/YBDw7JPMJ8ytvkn8+EjXuu+HRW/EKWA7IVTb2b/lmV4MBE98UM6nm9Lp9sRFLNk6fX8on1hSQ6e8rh9GeC1yEay7Z4oJKZyr/WTIrv4wBvxoPxRCrgqS6jH7E/W0K309iza3vAOJKrFM5TK25tnA5+cfSQzRNccIdNMCO0IryCbZV2D68R5iMrVjp6AKx0gFHW51MGF2WzuJijdWpUX+T+NQ1cJUGaKYhGLFjuk/R0argRS4xA2IT2cIwFe+28v16VOIXtvnquZQxQY0/x+o2kVc+2eUmuRXAfOcK1WCWqKH8zIwfCcB3M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RKP8nuFDtl8U1dJu6gfpTyx5G24V2z6+vY2PxgM0OsFAzZdk1DcKGD/9lL?=
 =?iso-8859-1?Q?982GaDdMmDdBP0CcDtLcnx8hGlOvs9cMSQwxbVc2hurhddUdvx3QGgufUt?=
 =?iso-8859-1?Q?r5MglVKVxJ/oI0j47nUcmkPR8yRDGAmU9l+TH2FenaWLDglw+C9WemhfM/?=
 =?iso-8859-1?Q?ASyVjm64l9r1HX7PBQXajdTz62I4s3gPxU5Q94zxe4cvqieNBSz+cw+jUJ?=
 =?iso-8859-1?Q?Z7BkVvqGD0yotu9Yw3IjqxJ0npgQnLINyEVh4EtXb5UGHCpDVJtr3iwxUy?=
 =?iso-8859-1?Q?s4S/70j2XvBgGCgHRGmMYqWaFSfugToxnPHhXO8JZ89/g2yJBstoybSna8?=
 =?iso-8859-1?Q?Qc9gqKlFL9iGTVUjJqCW8SpM+gI5GIACUvfBMFRDBaKA1eVz+Dg4nQ9zX1?=
 =?iso-8859-1?Q?ufr44DCjxbgRbHoYYEGydCUrlykosFqiEPJE8ek7FgzhotdZxGYM2WhwI7?=
 =?iso-8859-1?Q?traJ+gEyZEUwNc/nazm28UoKD9WHXXBoeDv8/yP9eohdE9Es+B473dLX1B?=
 =?iso-8859-1?Q?aNTLqKj3AYZRHgPuKzFeUk095I2/0x7GPQ/0KwTrYX3/1GbzZLY8INYCLl?=
 =?iso-8859-1?Q?InVsyE9bIfDTkMfyMAJkBjZzbIFeqoc/eokVODedpUHKi2BlklMMslziMf?=
 =?iso-8859-1?Q?aWBUbXM1XhC3mCxjy+Onm99HoBJQbJxmi4zRVQSG5C8M7NTlvWz8zaUWrC?=
 =?iso-8859-1?Q?LhVXNlbkUDeoKV5sWLkdOyuoB7nnD7lNUIz2BXaJK1v9QziWE/PsQzTI7e?=
 =?iso-8859-1?Q?CPVEnX28b6ipqB5UaE/W+HcpG4vuiBi8UD5pJOsMtUaOv1SDOj1EuQXDWY?=
 =?iso-8859-1?Q?3f/iMuxqkWU7V0b+px+TLFlTFsR0qOjkjFDQF4nHjVxOJSfLvQn09mF7Ms?=
 =?iso-8859-1?Q?CjrAtjPcCmIMTNyDhD7KLd+VyA2g15mF+RRBQtJG/BBltfegkDT/bdzt9E?=
 =?iso-8859-1?Q?slXscp3AoIZbDIv+R+/7alowEW+YF2sFHSvmK0dxwe3vX3DuR6OJd1RtyT?=
 =?iso-8859-1?Q?2o+KM2Nq4uuE+0NyDKwv/LGiW0BDHnEj5ddIWjPRnNKKsJma1ulLrmSWDO?=
 =?iso-8859-1?Q?afETYk9Y35asYziHC/cKB60HwP1BigwaS3xo6qwxpO4TkRib+fyxbHS5lB?=
 =?iso-8859-1?Q?+HYYY+io9eHu6QGLxgjD+IPWWkk+/5SfUT7ZkgUnHfiutNp7n4jV6fD9lm?=
 =?iso-8859-1?Q?aena66INfoiumKDozOCMIm6foWNEiJ4j9aC6NQGgVDPegFR0lUbiQW0QVu?=
 =?iso-8859-1?Q?K2yqmIgz31g0klqXquGbYL88oxW3EcDsneTXG1dWc3OqbVUZCa468UE6KC?=
 =?iso-8859-1?Q?+CzZtZfLoEQlgs8U2S/IdgwmLv5NGgTNi+NFdTS0fSPBjPdqxsj/ydzOeR?=
 =?iso-8859-1?Q?iufP8LE7AqVS2xep2okyOT7UyZvWYkCkas11anL5dNgGfzGoyNiZyiqTPa?=
 =?iso-8859-1?Q?8Vq1zKnQ69W6Aypv6KDeC39sbr93xFmnAaMNXNJ4uI/Eis+7Qr0utSobwr?=
 =?iso-8859-1?Q?80EAih0njGS2OwMLQKx+2e2zq7ciW5g72Ccs8wK8IQhSHHy+NMVs6SaL/6?=
 =?iso-8859-1?Q?bjoL65b2PX9cNfcWzid1Q9CPdFSVXym1FlBZUPUcqYotDGOlKB4wC7OoNT?=
 =?iso-8859-1?Q?uslx4KwOtJZo1UMzXffupJpX7Q08dguvUz++1UBxbFHqW3HgcedT31vEdi?=
 =?iso-8859-1?Q?DpkVrBR6EgTgqjotsek62Bcd1Wb9ujEIn77xfZOSRdxIdHJjSe+niHmhrP?=
 =?iso-8859-1?Q?P6JSTXG6/7+WcEZPC8cecR7tvOU8BQFMVCzysMl7xZ3aVKGrpJCy/K47fP?=
 =?iso-8859-1?Q?ElCOPpo6MA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CElcdBRxcQar77IJ18TCBmYcTPVmo8KKCQNi1hJAFCxJYUnDVL9JPcNu3DmSiheUSPbfN58DyfP7clQ+9sue2dg34/nCclDO3EY5SK3CJ3Z3+Rg+hp66fwnJhGcFBwivHSs8kFv6EyKDgacxqryVXLPD8yMtaeNPu5GMPiFmaiOjiDBAn4jYdvWie+VXPZEUWpesKg1/LojF8jp8rjMSeY8ecJDwdtrBlD5yhzcy6WuaZdjxh827O29O/n4MIFK4zEnjS8tRz8UGPZ7oTn8bO0Y8czup/WJdePGImVs/iq0m/Z5LISFH5Zi/M9jQdPZZQdk2chgKsXz7oCEgBkzNvw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa3f039-422d-43f3-7c83-08def2012d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:00.2950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgqXG81POjvNUK0dYoLUd6dlC/vi4hquxw+3cQRJ4nqcZK6Gc3xCaqO52c+PMNCHMHsjkgiJG+Ih0EOkSl1Gy0X3wcVw+miGUFWUsqOTfaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6961
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700a1.py          | 27 ++++++++++---------=0A=
 1 file changed, 14 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index ddddd2d47a..adc8af30dc 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -85,13 +85,13 @@ def verify_openbmc_boot_and_login(self, name, enable_pc=
ie=3DTrue):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V1101_AST2700A1 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-image.tar.gz',=0A=
-            '859808828531a51931aad3b4e70b28143eebb3cde1838ba7d8e7a2b844c8a=
1ab')=0A=
+    ASSET_SDK_V1103_AST2700A1 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-a1-image.tar.gz',=0A=
+            '540961dc380709d852e957c5817cd7ee0dbb0a66f3aa17413eac7b67518af=
bfe')=0A=
 =0A=
-    ASSET_SDK_V1101_AST2700A1_DCSCM =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-a1-dcscm-image.tar.gz',=0A=
-            '4654eabad75da3fd33635cd6d29b7635181daefee7294b68feb124b9d4c24=
116')=0A=
+    ASSET_SDK_V1103_AST2700A1_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.03/ast2700-a1-dcscm-image.tar.gz',=0A=
+            '5f7c139330fcefa6025bc7565a20fd5ea42cacebf810d56dc9a76b07cf69b=
3e1')=0A=
 =0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
@@ -127,7 +127,8 @@ def start_ast2700_test(self, name, bus_id):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
-                'file': self.scratch_file(name, 'bl31.bin')=0A=
+                'file': self.scratch_file(name, 'trusted-firmware-a',=0A=
+                                          'bl31.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
@@ -154,11 +155,11 @@ def start_ast2700_test_vbootrom(self, name, bus_id):=
=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'), bus_id)=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_v11_03(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.start_ast2700_test('ast2700-a1-image', 1)=0A=
@@ -166,22 +167,22 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_03(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.start_ast2700_test_vbootrom('ast2700-a1-image', 1)=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_ioexp_v11_01(self):=0A=
+    def test_aarch64_ast2700a1_evb_ioexp_v11_03(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2700A1_DCSCM)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2700A1_DCSCM)=0A=
         self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')=0A=
         self.vm.add_args('-device',=0A=
                          'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
-- =0A=
2.43.0=0A=

