Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18508C4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNu-0003K8-HU; Tue, 14 Jul 2026 23:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNp-0003GH-TX; Tue, 14 Jul 2026 23:34:06 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNo-0000oW-5g; Tue, 14 Jul 2026 23:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyIymPUYcK5Io0dUAntwO4rM4jdJgEl+upxqEl2+JsNSpHjWkFFu9GfbSXgu5wTy8XKYyy7gDtC7fRaoVIOG50bfjJu8GuPLTSEPT7CF8ErL0EWf/Nz8xnIYPKskOEDgPBIWhXQoc8kmTQzjiZ7g0OdZcm0JJi6AldBQqux51robs0or4L0Uy2TxtBHf8uN7kpw2zg2uD/YNTWFarwZ5GFYtl4AA6OEk/Y6sipB54YeWC+BiowbK4aIWNbWzefxzFCwzkg7p5SA+zWTxbZT/yJ/lseK+/uSiRcIi3uSIs4EeAEEFVEaWY+yrmTEIlq5Xoyna6xx7syTo4yFobo95Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrgQVuI5r/0ma6rd0EwL7CGOekauvzxtaf+fIEctj1A=;
 b=QXMj1W0TxKK7yWS2fBSkMIcCwcwkaVxDO1NNQhbii4bAVWp9kRKJTis+1i7GBdcvfD+RiEWJyI6UYMfVD0QKsTKn/Z3cREr/jyZkCiPnhGPuKYpVkmQ51gR+mEynMKwJEl5YYENT1JUMII8k40p4lmLqRWnFWFcPh//Q2GrJ8FJrH7ElIv3alJiNlPLihb6F2foHudK+sm0zG9GU+zBrL5UvheuqClQvf2WgTdhcNYBx82N1odwzmPW0bSAITaVZ9D+HQoJ/qspb2IaAr44nHDGvl/OQ0St6dIJRlF/DaUnRTj3dh/jYycCVfCCCykxtDnCa+PAeG2nZw0g5AIeDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrgQVuI5r/0ma6rd0EwL7CGOekauvzxtaf+fIEctj1A=;
 b=Q71jR2BhZoMr47VoGDrLbXMlcNGPI1acIn9teznqHFigDWuEevoW6CCipr+4wbzyXwUMh+6pw2sNS+N38AIBuz7ceFkm4a3j1kWCQUPt0ksRhEcQuX4E/Jc0BkhH0mNoAkCN8A0O+/oqtv1cYLjrvmjxqGDThRnNypF5adndUYd130W9fI8gIrivkHW5uts7EVPV+QCb+BUN7pt/k0K3qOrCEYkK0NjpGv8oOPIKZTKkYcfusmOHrLBnw/Sqj5SLiV++HG7REyEAIJ7L19eACtUkWKSz9zuXIJvQ6Ks4LKtOVL6f0oR6qWl9J8fbrNMDiTVNbVV1OQg6WcFoFxCRww==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:36 +0000
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
Subject: [PATCH v2 14/17] hw/misc/aspeed_hace: Support the AES-GCM mode for
 the crypto command
Thread-Topic: [PATCH v2 14/17] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
Thread-Index: AQHdFAq3ogjjqORDv0CAHW8aY++84g==
Date: Wed, 15 Jul 2026 03:33:35 +0000
Message-ID: <20260715033311.1648424-15-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: 396b0958-de8f-470e-effc-08dee221da8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: NlExKVSqWIgrU11xnBlfIrrG5DnmVTNx00Gix8zVO2LkOTZRB6+E3p1x9RdF3p7FJ2gxxTSyniQYly79hwuFPgWX+SDbHNzIX3zkYQ2zdPLvrICEbodyiKEgHWythXuM8G/p+Jxe1L55kXoUOR8W72+XUpDFtCn7qp+6Zt7qBODGaDTRdsCtFQZ8SIUu8a5wTUk4lwZNQfcuOoQFAUNfbfgXRBdjGRDb56LH7SR0TjxhnCg0XPfb8ennun2jV3hfk0vlJQVwGJLUnhXeS5ZUmIbogE87UcEgwHvAbyN5VjHv363kqO9mSU+gq1voafSOoi9cOcukxpKl+iEh0f1iKjm83gfGa1CE4Ysp8CVnN08op020UR3o2LllYDM+j9dB3CJW+dNcNHcolZ6/PrnCb4Rc5QIpEg9Y8YP25egBf5o1CuIaT6c0tU/5wthwzdBNupANyPQtFIsGc2n6t4eOY5zpJka7iXbs54RoTufacRx0FqHInBFt7oFTaRru8yghACFzhyNuxL9gfgVyMnQoh8EtUQ2q48N/UPuD+k32ug5n2OBChFjCn0jAk6TgmWg18WkgyEPXlgSOHr65vV9RiT6C5orQWGFBtvnpR3AqBp0isEWbwZAgM/EhQ8GahqZ1msQQ5nmkgzWmU1cOIlAB9YYnbnyCYMayExUHwV8NUho8yyWtl/oAvKc3q2hVRhuGn1O8F/Tz32wmRQ6vLUXTn8Xi9tlikhFGHC8Wn9G4gsZcIgU3P6PZNzGvXq+cnIef
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QzjQ7q31xlwljAoqKN3GZlF8TxuVE2fBrk6TlvwTHI3+m24AADM8bXECxi?=
 =?iso-8859-1?Q?G5NGcW9itQ38k92wIOhePjFTRQ6nB759odlSFlOs+VDQVSWBYuIGC7lVkA?=
 =?iso-8859-1?Q?JWxPCVXCJfvXv4WlguAHbq9uRKxULeiT22L4JCc/uBNA4BKoDamDWdGQXw?=
 =?iso-8859-1?Q?UsvTsYCZmhLMqbL42UGiBcxSa35rJxCWP8I1F0DIKXIJCloCoyNGIAxLq3?=
 =?iso-8859-1?Q?Xa9zDOymSzNWO2nU0vvW0MVeUpog4+9PqiKbTtPEW9NvwFTZcKIpZq7saR?=
 =?iso-8859-1?Q?9CXlG8uGcPdrprJeQipUkmEhCnczVyizNo999jWodu5Jfkn88ZnEA4WRNP?=
 =?iso-8859-1?Q?ErMqWZKhA2n4GQGgP1J3TnbgAtXTvHHAKCxCeMmDz+zGgLveXjhAqiR6Xe?=
 =?iso-8859-1?Q?uqfrsaXvrDO6+Axe8gJs4F5YzagaVfxpQHMZMh9T4tzZ6ttoKxrMtuMyj+?=
 =?iso-8859-1?Q?+wQ67GOfPjzwrmEluxSqHrUyGZSq/OcQ5eWKEv2JcCjnTfbEKEfIlWmjXf?=
 =?iso-8859-1?Q?uLfrl0puw0uqPMJV7M7sU3cx72cOxn6e7Wp44tmHLtLb6k9C/DfCmcUQOf?=
 =?iso-8859-1?Q?1Y5i6gMoUoQdWVCT+/b7SdPZ2cvZbcTWN2dmjKPqMhoxOHu4FbPjtCkuWF?=
 =?iso-8859-1?Q?GtJhRhxwN/a67/zL2p9Tz2ZlK5DUWVMnQi8W1jXiYGuHrkrKQnhis8B7ju?=
 =?iso-8859-1?Q?c99cpDc3w9A5j3LEMZIGGSGCelJ2jAbxlZ3QMnfOnkXaD9E7xJ8EBUxxg1?=
 =?iso-8859-1?Q?5MU88nRYQCv5M6afwXtb2FTpNie2fkKFD72NTXkwH3o/pIkWVgX1iphw/7?=
 =?iso-8859-1?Q?K+ltkGcZmm25b0mzYojr7rE2oBt8Qn9RAoEo9GbTcjApcK7g/2WYNa46tp?=
 =?iso-8859-1?Q?aMPZiUcGcX4jazlkSU8ajUhZoNkHxpQ+YlkBdgSDMuv920YiQNoeuNclQ3?=
 =?iso-8859-1?Q?iiEUQyiF9om2XbgUyASW0BBdY6NX1DtJhTjs68X3eK7Gbb/1vlwS1wrP3n?=
 =?iso-8859-1?Q?K4G0/t2bCEStBC+g9GQYDvl0RjdXytSDj+F8fry7PL9o2QtUrr+k3FOx9s?=
 =?iso-8859-1?Q?URXVhEMLFIIl7IzhoZLQ5Roj6Eo+S225yKabcPIN6PsIfT3WHpkPzvA0px?=
 =?iso-8859-1?Q?Br5iuZfROBQyYkUm6MBNIlYYPJ896MSMOTdm/Dm67FRzDGRMumeZSXZSsZ?=
 =?iso-8859-1?Q?oKYWZXGfO5e/LsL1se3mJ1UG75M120B+QRJYubkG0oya46zYtObkjZajdR?=
 =?iso-8859-1?Q?J63Hc0REDwl6o/jjYJa3B/WTk2+1WBTljp5IhBA7eWgwNDJPmlLjKlIApH?=
 =?iso-8859-1?Q?gBRhxshsVQ7HshqoUZUrIz6wIjzLDXP0fyQwGX1v8Ic1xoc+1/ZTITRvdo?=
 =?iso-8859-1?Q?6RmDD8Vl+w0T1A9cygIY5/2Z9YFK8wW2SxX2nN5pk8FQXhxis9KoRwo7Xu?=
 =?iso-8859-1?Q?BQolYzMzOQJbCsywnWa73/O3/VlgyDRI2dxCQTBh3m4/yQZuT1e6eJGSfl?=
 =?iso-8859-1?Q?jrz39pU1vFEQC3XHlQhvBxvm4clWZCAWDzN6T26SAlXvVNBZKHQL/DzAP+?=
 =?iso-8859-1?Q?Ugx2IiXegRLt8/gSwj6KohsiIlMnfakQ67YRwyOF5L0cYkO4ILKnW6wbuK?=
 =?iso-8859-1?Q?Gikebm3Sqx5lv3Pk6DfWUsEgwdmc+E8gwgHPajDr7znCGMELRCZCTlC9u6?=
 =?iso-8859-1?Q?OTwkSU4U/5qr0I/C4z9YOSo6wjrMt/BUeJLoIV20ybSOhZgzEdqTQxU49g?=
 =?iso-8859-1?Q?6pV84ojhiyZmsF3Bu7fKgTEWWrSZjHAhAsisUesJCKesqUZL51gg8PTIb2?=
 =?iso-8859-1?Q?fdkO08q1lw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lyUSiIEmN+oy5PAS1Aj4ljbZPZFe0n0F+yFhPRsiaeP7JU7n7dA5fWmQ2R8SNmMAvMiMItvCId56qXPDFGfd39TGyPS+5DQ8kpnHBrMU9eFaQyf5NRd2GQhb1MZGGploRtqVoZPO6K8AWT1ft8jKXdZ1iDESgSOMu3cujnQMK+KDTgq+UXoeJDcVeXG4HScqlhFT29pc/hnlsVx9u1OohCZ60fVcjb0D9idGe/+Wgi+Fsty8BXxwSWCPJWbdxBkHiwnmnlFjqDi+9CcgqrXL2zkAE0cCWe12DZMcgy9s9bjYx7pTXQJ+brqX/MLueFpBIOrJXxnBD3dcD3T+Sz4pMw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396b0958-de8f-470e-effc-08dee221da8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:36.0284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI6xW98AaONx0KVlWfw75uMIAzVE3EjNFacCHWUN2igFMGEjRsX2CDaB89F0zoH9Wv82Wf+2Cjr3TAcJc5jOpH0bbcXvStsu3fsQi4hn/LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

Implement the AES-GCM mode (HACE10[6:4] =3D 0b101) used by the AST2700=0A=
crypto engine: decode the GCM selection, read the 96-bit IV from the=0A=
context buffer, operate on the exact data length (GCM handles a partial=0A=
final block itself), and write the 128-bit authentication tag to the tag=0A=
buffer (HACE18/HACE8C). The hardware GCM path is only used without=0A=
associated data (the driver falls back to software otherwise), so AAD is=0A=
not modelled and a non-zero HACE14 is reported as unimplemented.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 ++++++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 62 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index a807cc1422..927759b48f 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -31,6 +31,9 @@=0A=
 /* HACE0C[27:0] holds the crypto data length */=0A=
 #define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
 #define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* AES-GCM associated data length (HACE14) and tag write buffer (HACE18) *=
/=0A=
+#define R_CRYPT_GCM_ADD_LEN (0x14 / 4)=0A=
+#define R_CRYPT_GCM_TAG     (0x18 / 4)=0A=
 /* Crypto engine command register (HACE10) bits */=0A=
 #define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
 #define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
@@ -43,6 +46,7 @@=0A=
 #define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
 #define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
 #define  CRYPT_CMD_CTR              (0x4 << 4)=0A=
+#define  CRYPT_CMD_GCM              (0x5 << 4)=0A=
 /* AES key length HACE10[3:2] */=0A=
 #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
 #define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
@@ -58,10 +62,15 @@=0A=
 #define CRYPT_CTX_KEY_OFFSET        0x10=0A=
 #define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
+/* AES-GCM uses a 96-bit IV and a 128-bit authentication tag */=0A=
+#define CRYPT_GCM_IV_LEN            12=0A=
+#define CRYPT_GCM_TAG_LEN          16=0A=
+=0A=
 /* AST2700 64-bit DMA high address registers for the crypto command */=0A=
 #define R_CRYPT_SRC_HI      (0x80 / 4)=0A=
 #define R_CRYPT_DEST_HI     (0x84 / 4)=0A=
 #define R_CRYPT_CONTEXT_HI  (0x88 / 4)=0A=
+#define R_CRYPT_GCM_TAG_HI  (0x8c / 4)=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -598,6 +607,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCiphe=
rAlgo *alg,=0A=
     case CRYPT_CMD_CTR:=0A=
         *mode =3D QCRYPTO_CIPHER_MODE_CTR;=0A=
         break;=0A=
+    case CRYPT_CMD_GCM:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_GCM;=0A=
+        break;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -691,11 +703,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s, in=
t reg, int reg_hi)=0A=
 }=0A=
 =0A=
 /*=0A=
- * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
- * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
- * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come fr=
om=0A=
- * the context buffer (HACE08). For CBC the resulting chaining IV is writt=
en=0A=
- * back to the context buffer so the driver can continue the chain.=0A=
+ * Perform an AES/DES/3DES ECB/CBC/CTR or AES-GCM operation. The source an=
d=0A=
+ * destination are either single contiguous buffers (direct access mode) o=
r=0A=
+ * scatter-gather lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the=
=0A=
+ * IV/key come from the context buffer (HACE08). For CBC and CTR the resul=
ting=0A=
+ * chaining state is written back to the context buffer so the driver can=
=0A=
+ * continue; for GCM the authentication tag is written to the tag buffer.=
=0A=
  */=0A=
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
 {=0A=
@@ -705,6 +718,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
     g_autofree uint8_t *src_buf =3D NULL;=0A=
     g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t tag[CRYPT_GCM_TAG_LEN];=0A=
     uint8_t ctx[CRYPT_CTX_SIZE];=0A=
     Error *local_err =3D NULL;=0A=
     QCryptoCipherMode mode;=0A=
@@ -713,10 +727,13 @@ static void do_crypt_operation(AspeedHACEState *s, ui=
nt32_t cmd)=0A=
     uint64_t ctx_addr;=0A=
     uint64_t src_addr;=0A=
     uint64_t dst_addr;=0A=
+    uint64_t tag_addr;=0A=
+    uint32_t aad_len;=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t buf_len;=0A=
     size_t keylen;=0A=
+    size_t ivlen;=0A=
     bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
@@ -736,6 +753,20 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         return;=0A=
     }=0A=
 =0A=
+    /* GCM uses a 96-bit IV; the block modes use a full-block IV. */=0A=
+    ivlen =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ? CRYPT_GCM_IV_LEN : b=
locklen;=0A=
+=0A=
+    /*=0A=
+     * The hardware GCM path is only exercised without associated data (th=
e=0A=
+     * driver falls back to software when there is any), so AAD is not mod=
elled.=0A=
+     */=0A=
+    aad_len =3D s->regs[R_CRYPT_GCM_ADD_LEN] & CRYPT_DATA_LEN_MASK;=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM && aad_len !=3D 0) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: GCM associated data is not implemented\n", __fu=
nc__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* Fetch the IV and key from the context buffer in DRAM. */=0A=
     ctx_addr =3D crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);=
=0A=
     if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
@@ -760,7 +791,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     }=0A=
 =0A=
     if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
-        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, ivlen,=0A=
                              &local_err) < 0) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
                       __func__, error_get_pretty(local_err));=0A=
@@ -771,9 +802,11 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
     /*=0A=
      * Round the working buffers up to a whole block. Block modes are alre=
ady=0A=
      * block-aligned; the stream-like CTR mode may leave a partial final b=
lock=0A=
-     * that the engine still processes a full block at a time.=0A=
+     * that the engine still processes a full block at a time. GCM handles=
 a=0A=
+     * partial final block itself, so it operates on the exact length.=0A=
      */=0A=
-    buf_len =3D QEMU_ALIGN_UP(len, blocklen);=0A=
+    buf_len =3D (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) ?=0A=
+              len : QEMU_ALIGN_UP(len, blocklen);=0A=
     src_buf =3D g_malloc0(buf_len);=0A=
     dst_buf =3D g_malloc0(buf_len);=0A=
 =0A=
@@ -857,6 +890,24 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
                           "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
                           __func__, ctx_addr + iv_offset);=0A=
         }=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        /*=0A=
+         * GCM authenticates the message and writes the resulting tag to t=
he=0A=
+         * dedicated tag buffer (HACE18/HACE8C).=0A=
+         */=0A=
+        if (qcrypto_cipher_gettag(cipher, tag, sizeof(tag), &local_err) < =
0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher gettag fail=
ed: "=0A=
+                          "%s\n", __func__, error_get_pretty(local_err));=
=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+        tag_addr =3D crypt_get_addr(s, R_CRYPT_GCM_TAG, R_CRYPT_GCM_TAG_HI=
);=0A=
+        if (address_space_write(&s->dram_as, tag_addr, MEMTXATTRS_UNSPECIF=
IED,=0A=
+                                tag, sizeof(tag))) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write tag, addr=3D0x%" HWADDR_PRI=
x "\n",=0A=
+                          __func__, tag_addr);=0A=
+        }=0A=
     }=0A=
 }=0A=
 =0A=
@@ -987,6 +1038,9 @@ static void aspeed_hace_write(void *opaque, hwaddr add=
r, uint64_t data,=0A=
     case R_CRYPT_CONTEXT_HI:=0A=
         data &=3D ahc->key_hi_mask;=0A=
         break;=0A=
+    case R_CRYPT_GCM_TAG_HI:=0A=
+        data &=3D ahc->dest_hi_mask;=0A=
+        break;=0A=
     default:=0A=
         break;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

