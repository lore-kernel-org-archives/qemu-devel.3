Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D94CD6E62
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjT-00039L-Mz; Sun, 31 May 2026 22:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjS-00038e-8u; Sun, 31 May 2026 22:50:26 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjQ-0002Y8-KD; Sun, 31 May 2026 22:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1rDc5cf3gpC49QMaG7di1+QNDVbCftLXcQi5QvoN1nI8a5lRWfwv26e3RWKyZ3Ty1wua+Z/kF3jvM7eKYpYf69/Oz1L0teaPiq6FBffGeQcpG7Awvu16kxvflnkr4lOBM82H2Wg6SqbgpEwVB2ymHhmo+LNclI8VzKsVTOXMO9G7SVwC/THPnv69gKvhaYyJQO6LbgrjgrmLlpCXNLX9OAtUz51E5Kx8+Ql1NVcpF2cC/KYmsWry6Tp50ppx6JnN7o/aDllcsxW0yagNQxPqqzbh2BHVbXmWs6SIWQyNCS5crL3MACczEuqyQoN247IkPx6hD+hhnW+g2SV3nhxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zburnr8OaIDEW7+lcYDri23dUOWKaJOC5IsB4gUVAoY=;
 b=dXp7+LhJDqkW00Zde8soDXsmfzPTsWHJNH21Ptci3n2e4coTT2uhfDxX/JgcqsG8DcQAWtCNyazsCqUunrlRfOXiTUKo04rVwy7bs+eb5LUsx1zLv5MeUj3zgx+ey2tCvIOEnFHZsQsphzXvVzP/leu/NU/WrrV20Mxd+BpQPPm9IUfXcJGSaWEWaCTM7b3J8jruzK5EETAEC7T5IJwtNkDka6vizjYS+lG1qi3pYpYCc9ainL1Gn2seSAHK/GAQqb9lTOFfl7j+kZknmZfWalz0G1fBTQM38Avz0Yu4r7kuOC5r/Vx7HpgzxHstBh2S3RjKFGX0cqDUN4V5e3I8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zburnr8OaIDEW7+lcYDri23dUOWKaJOC5IsB4gUVAoY=;
 b=N9PhCQBvPESPd3AHAGP01d29dfHL+p7BQNbtHVvPAiVS752G+tieqkcHUF6VnQQXUZU6ewK24dl2MPjmy8qgllU4dC4LyF2R06LBNL8aVFhXKkLcUl+4OJ9BOogSY8AYcO82M2kyI231S6+x9OLLEqw9Hf/+ulIt9XxUBc5T+x48LkohI9VFycTvbXcENA5W/xjQO9I07SBFqO4Nmx8ofGk03/aG7bVgxWFyb2KT8nMZS1+xsMdUjYDU6PjR7lFeuva0euyh51k1H+Pey0zhp4MRYAqYzOO2wq84MRYZZZ+H/NfvvIcAEnzLARKIIfYho4de4bAO/aB83HilcKeT+Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 05/24] hw/misc/aspeed_sbc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 05/24] hw/misc/aspeed_sbc: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFbFXiS5+zLiEuhImfTx2HKDQ==
Date: Mon, 1 Jun 2026 02:50:08 +0000
Message-ID: <20260601024959.2347639-6-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 4ea2f38a-1293-47bf-b91e-08debf887e3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: sUJtKjn1Xsw/fIWWTUj2JmRKytnfZwxt/IiGjZSQxFjoaJGRtOldfOo8Z2YxJwSTS4ovuqDcowuRJB12wUqLGLmUAVN443OZWsC6+5q9A8sId2vd1r/dg/dgSAJfhoCElI9F8bhxz7+jxtW+OeSOzsg6jLZ/9Tt8jpvd0ufogRljv6xP/V3Z6QAckT+s6qVKNl/PVitLshcnMh3cr4Gj7pVHoZAFrqkdzjP+Cr8Jp8AKASXdn0LBIGEuC+y9uk3K6pGruiqOYRqUhLxl06kdPQBJqgKybJtNdOa78fhd0b74DQxcPwloAPV9+y4Rr86hso4GST8ZkUsYImxAHfiQjTlp6a0FhH1pr714UtCmUacOo/qSmnCZMmCSKNMqRsP7iKUxBoQii7L3ny/WNexW3i40z2RIueBeKHxe3Sfqqp7KciPm3zH8xRav9RUIUQF8VjaogOtcyQxWwPqxtjhtfaBASnOsejuUOUZqtsPpna/d8XYdMbCb3lLofu92e5jjsBRjipQDPhqcjF8QeYbiWnyECnnqbc83WCidll9bb0Zk6MpzkkQHxBjOC2meCJpex+UPNkhYv0add9PL5vLTqFRNFoUodlPQ8uXBh08nGA/6JjKTv9wmLuJkPj109Pt59xcPBuSHISNyFpmBLJGG17ewGltcbT7IX43VpPMtgc/GX90C/nPBx5gYthc5uKS1mhKtVhgeJFla0rYn+8528//EQc051W8mWpsViAAmlS0xAcrsG2OfmIjtqDOtv3czVPHScHq+N3yK92aRAuSybQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/ig98lME2+ApLJTk6OU9+7AvoVd6D4ClExjwFi8VebTOfgW3L6Aj0midTj?=
 =?iso-8859-1?Q?j/GIF/N/07IXxPadK1iCA12wjr3icW+Ze6FHBnXpeoSqo9nt3ORguONRTJ?=
 =?iso-8859-1?Q?zd4A03JRTuOv9pqBXCo9jiValW1Z3X1Oai6YOiViZepgGmfveT4WnJnlY6?=
 =?iso-8859-1?Q?a00qAb0ISCgOMiVnXhMeHqTny9JMP+duNuU5lUW5eiqm2RwNwbZr8sraoJ?=
 =?iso-8859-1?Q?of+ZXmRRXhfFEe72r1CyKR0DiG9Is1RCLu7EQGFBu+S8ju1fT7A4C7N1sA?=
 =?iso-8859-1?Q?gOMqb8KqgrXKEi9Mi4oiI7k3g0ThH8nJiSqZ6Kumrjk0c6dnh5cU5eNU3C?=
 =?iso-8859-1?Q?9ipK9mQh1oc1HqYaZTuIorZUYkxzDYgWwIdZLMsrjuxlh9uJGyvAFy10V9?=
 =?iso-8859-1?Q?jFf/0rKJhCnrtq+kTs/62zszue7V2ekizpL5nUMPghZAdlAU1WuJg8KoR1?=
 =?iso-8859-1?Q?H7uXwSWJhKNI/rly2k0FaoKJIVn9cm/3ZqgcxcHwquDBMkENuTP6chMwoL?=
 =?iso-8859-1?Q?JqYTIIL9j63YBPWgK3rifLuj8j+iSpamo19lfQP9fA8fM+i876edsYjQrW?=
 =?iso-8859-1?Q?mI2YUJM7b4CkAtbIywrJp+WwAvxMbbvCAAxOtSIpzDhgY65X0s4qCFa5OM?=
 =?iso-8859-1?Q?9PkFr0D3lTpPpN5qondZj2E5KqAFI0ZMCgvJDW5+Y/OYzvSSndrlgLt42s?=
 =?iso-8859-1?Q?IBARGoM3AJqgzOBJCBRicXmZDXsn56/b3VVQeegWb0u1SYVH6bhnJ5jEUc?=
 =?iso-8859-1?Q?ZLaGfLbFo/9G+gSOBHEwOSwIgRyFAhGdQEntD42anFS67+ZyFsPHjTowJN?=
 =?iso-8859-1?Q?SFdelIsWlXbL0D/5SUGYQ/hwM6YZPk+GOEErbG5FIo2CrS7MVVCQJNXyL7?=
 =?iso-8859-1?Q?sLWLjccaHszpXKkoycVyDho6NIXVZkThSU466X63XiorXbBJ0qVgCZXSPo?=
 =?iso-8859-1?Q?mZUQlQx0UM1f/RMNKmw/bPGlnkTYtzN8C/qzAyZWbyB0BbQIQ+BcvzNuvT?=
 =?iso-8859-1?Q?4W1ytZtm7Z5SlL8qMRhlC1+lvaOXtXAtEr6CHVX111phYasiufUMhVCugl?=
 =?iso-8859-1?Q?88emsp9QxpMAjUPfQm26lshrAmiRLu9O700m6Bx+if3ptEN7QJnBKgw9ww?=
 =?iso-8859-1?Q?eiEP5sJ1Cw2szHp8anILT2AEN3/zBELLOJ9f8VUbb7AY/HMjy40DnH1aTO?=
 =?iso-8859-1?Q?Ccshx1xh+9voW/1MdKYemNV94BPTV6cCHfuvIl5ExUlp50RjItn6Cvq8Bz?=
 =?iso-8859-1?Q?ac/h0bdxvVSlI5c5VedoBEBRJMVFksJiDZnhX/cgGiHUAm/nRsGVnPBlhJ?=
 =?iso-8859-1?Q?6Pa0bCxDqs8rC9dMmJ7q9CSPllk2NNHmo8By1nI1n4yo4yKxlZPBR+FWZS?=
 =?iso-8859-1?Q?ym5dznl2MKIRJc6JXLp3vSUomkrHDM4YgbTNdnlvxXc1JvFUuRseoTkEVw?=
 =?iso-8859-1?Q?AvqbqhKUjAzehPBSnR6gu8RGxdbf84nrsuFLyNY2UMvrfd1v1njgr+PO49?=
 =?iso-8859-1?Q?iULalJyueojOqSiHdv5/cGFauubXV8AvcHuPx0eGw6Tbpa1dd6JAwBS6ny?=
 =?iso-8859-1?Q?GNXr3LYcbg4r0y+G38Y/wuy3JUsk2o2cLbSXvVn9v7QqHXk9iHIioMf6C3?=
 =?iso-8859-1?Q?yY26LJ28h5hm9JPQ7g1Q+YSl6DlqQyGV/lKDPt3Clbh0e4vda79a/gpPgW?=
 =?iso-8859-1?Q?FdQNQ9zqeh53YKojBz2uEeDuC7gP9he0N0v+sKhGD5jIFAJNj3u/Ya+Q/w?=
 =?iso-8859-1?Q?0DPOLrD7F7T+AtYWbsV122MaI3pA5GmWOqG42/XepZHTMhizRP2BNuobuX?=
 =?iso-8859-1?Q?/LxshaYzQg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fUOeQxIzH1tVMsnegFh/dmnvAcdZlYR2ePLJm3Y0hls7uS7QNzwRsTixEg3++t/Av+AqIflJhG+TXLDU5XemWQ+8YNhvFoBtgeRHoTAuHRoKAFZ38grUgJp1rq2iAN8PK7LX6S7ZWAIqunMuSG46iWbOeGafbVuXf/J4nSwVYsbCVtxLJseIcMdMKb0kbBhHqHEtF8K5Yulvy3v3d8DUMPCcO3cLiy14SrToyc4Q3yquycDToMpBNO8eC+fr1wiOe+Af57UpCYaNcc2yk5DIN3HrDLXUMGjj13kCGzSInt/mNi9ohcCcVlXhfEtp914PRFUtC6KsYu6rrZUg2CTxUg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea2f38a-1293-47bf-b91e-08debf887e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:08.7353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +j3+Zc9KeDXK5JtyPBSIqX3lvIapicTPMJ9y+j7zyizSJ2GivkePVnrvV2NOrf+D42OxxoHu5B5cySsk3NtEXWYqrdwKdA00fplEHbeJWCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 3 standalone TypeInfo variables (aspeed_2600_sbc_info,=0A=
aspeed_ast10x0_sbc_info, aspeed_sbc_info) directly into the=0A=
'aspeed_sbc_types[]' array, removing the need for separate=0A=
declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sbc.c | 46 +++++++++++++++++++-------------------------=0A=
 1 file changed, 20 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 6125d2f134..1dfcf14e5b 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -338,14 +338,6 @@ static void aspeed_sbc_class_init(ObjectClass *klass, =
const void *data)=0A=
     device_class_set_props(dc, aspeed_sbc_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_sbc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_SBC,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedSBCState),=0A=
-    .instance_init =3D aspeed_sbc_instance_init,=0A=
-    .class_init =3D aspeed_sbc_class_init,=0A=
-    .class_size =3D sizeof(AspeedSBCClass)=0A=
-};=0A=
 =0A=
 static void aspeed_ast2600_sbc_class_init(ObjectClass *klass, const void *=
data)=0A=
 {=0A=
@@ -356,12 +348,6 @@ static void aspeed_ast2600_sbc_class_init(ObjectClass =
*klass, const void *data)=0A=
     sc->has_otp =3D true;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast2600_sbc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST2600_SBC,=0A=
-    .parent =3D TYPE_ASPEED_SBC,=0A=
-    .class_init =3D aspeed_ast2600_sbc_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *=
data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -371,17 +357,25 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass=
 *klass, const void *data)=0A=
     sc->has_otp =3D true;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast10x0_sbc_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST10X0_SBC,=0A=
-    .parent =3D TYPE_ASPEED_SBC,=0A=
-    .class_init =3D aspeed_ast10x0_sbc_class_init,=0A=
+static const TypeInfo aspeed_sbc_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_SBC,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedSBCState),=0A=
+        .instance_init =3D aspeed_sbc_instance_init,=0A=
+        .class_init =3D aspeed_sbc_class_init,=0A=
+        .class_size =3D sizeof(AspeedSBCClass),=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST10X0_SBC,=0A=
+        .parent =3D TYPE_ASPEED_SBC,=0A=
+        .class_init =3D aspeed_ast10x0_sbc_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST2600_SBC,=0A=
+        .parent =3D TYPE_ASPEED_SBC,=0A=
+        .class_init =3D aspeed_ast2600_sbc_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_sbc_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_ast2600_sbc_info);=0A=
-    type_register_static(&aspeed_ast10x0_sbc_info);=0A=
-    type_register_static(&aspeed_sbc_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_sbc_register_types);=0A=
+DEFINE_TYPES(aspeed_sbc_types)=0A=
-- =0A=
2.43.0=0A=

