Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D31C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suQ-00063y-Rk; Sun, 30 Aug 2026 23:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suN-00063D-Ol; Sun, 30 Aug 2026 23:42:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suL-0006yh-Bq; Sun, 30 Aug 2026 23:42:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxahlUdw86ufVITsO2QYfLZqf8N3sbnlNBZjmj5CsJcPo00c3L2Le5U6u4cJJYS5V5TQmSLfo30zDsx2IOl1xGMZUFbODaaZHIaEI7MWEP3HxV68MV23Plsmmoe0/GnGRO3+1nE+b64yZkx58yzWGIxC19NBQjVHfMbtzkO93gii81MX+POzgIxVqlmRjKBEBo9NAwWBbxjF4owSqewtMfsgVrNTuLYekDkFRj4mAxip+ClKyXSIEQcBzJEqlPD+eWOut8BxL1urfTOB/cnhzz+O5n3vM5Lups+ydM0MelHsFiQ2VQbtFjlLW+dKeGm7nPe+cFGi385GfsHN8ch3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXTzSjav51ldaH+azyGsL1znoHAWJ51+4jEw0KfdRmM=;
 b=yLQxq/hN31SSagvzTNfnhVDs8znDmKkknzzzx4vpOdXPa4S7gUOnKoMH+TljCqqU+SdmxZXEvfF6k7k5aWW3GMGp4GIzovTWDjkxkbhW76iUr1iebcKdrNDKvhwtfThPVYQZfEen1iEW8N24M0iPyX05zB+ZXSiKqbSPexhq81LgYvxDi4F1Iik2GfwuhfIazyXgmYP1dYlulghRP/s65SINtRBDM1afpZjkmjtF6yj2gPHbS0ecmt2oAzpI3TlmV52jfoc34nsV892vNatUHWn3tYOzrk26uucgA9EeKuHi6/wh0CWNuvD/lTZdFYivSInkAORqQGYP5avHwVZbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXTzSjav51ldaH+azyGsL1znoHAWJ51+4jEw0KfdRmM=;
 b=IZAdhAMaikB0Ia2J9ezSGYJ4lJgsCkyTPfYGpFM5059D1PmbSjkp2bYUjGAzsBr5Uz1LH1dnBxUSGhttDapnFpfZFtC4Giz+vP/EQM36s/LBtTy+Ce5Q2beR1k3UcYaiu79y1s6o1cirTdsQnpMy7SQtFxza7DAzO/Tj0CvWGMVu7kuskQD+wYX+Lv6sGvzbBe8L8V0nyY68wA6YjvaRWQWqn7y28+ZmUfrJMICK/s5JwwFROpBkXD+5UdFx7Bzw81mjK3f4AEpv1ZQINR8MJ8lwuXcMTSaeQ/11Y6NvzGDrunc5cvXACAECNfj25zVqyx1l4xBmQx3pgbioE/oLtQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6164.apcprd06.prod.outlook.com (2603:1096:820:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:41:55 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:41:54 +0000
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
Subject: [PATCH v3 0/9] Add ECDSA akcipher support and the ASPEED SBC ECDSA
 engine for AST10x0
Thread-Topic: [PATCH v3 0/9] Add ECDSA akcipher support and the ASPEED SBC
 ECDSA engine for AST10x0
Thread-Index: AQHdOPqqrnc1Ze9E1kOEdeJ8dIaY0w==
Date: Mon, 31 Aug 2026 03:41:54 +0000
Message-ID: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6164:EE_
x-ms-office365-filtering-correlation-id: 54c304aa-b97c-4a40-d1d6-08df0711cd40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|6133799003|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: vYdsbVGudD99Cfi+PQtz6JvClhi0qhO2P6stVlMUR1shSL+Qi+zsWg6HZvFwo/3ihDeD7rMOSNhG6aNAV3nsdlvxKWMzBPouFIE5XLOFmrFCNc1p/spM3Zk5mz4fnVlXF4jfaeoACcDuchyxb6bKjbEsYIjaZEwGaoOhTdmHwCQRu0TaIo7WzxHVj0+SW0gaoM92Qj7lduDk29fMHUvDadlT7wejMRPBg7LlCjHdqdn3avjf0RLYuIGeG9ttVPykeqqMb9C/EkYzYpF+xAJai3/r99ZYjYZRh08oLTZ+gHbTviKpnFUKaXKbkkRrUL2hCiZUPDivPwWrsERZCgt5Ll9STjTlXZRnEkA5gdxRiYyFj44381DZv5Ao/CuLavxqIzE+EYE4BE/AsBflcVgVPOdxZK++kE43kRVbU43+B8znXfXzpSnm+lnUnY4uuN1SYI05mawypMxptH+QvklrSUfLt2TapayiKXHOPKa4TrBmEIhOx3VOAHigvhgkIMkPq1mB3R15V/1iFEijO4mrYTxaREORX1PBj5EVg/RaoFUrz1D0xZsSXPATVr99YvSrPUPe1S557k7kW59htYYPAnx6mFP2+B/fWN39EUQOslw97E1cIzCIyipgIANwoRO70ghiQCmQEHrVfXCKe8+yJSXuVJuq26YeyxPi68Bnv1lD1bwPuVqWVZ7nVzORMsTwmVrmchAHvQQIpg7cSvUqZIFuQyQe/iTmtbfGkOz8hGZ3i7g5/oXjgwCsqoZmPdN3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GYaJmQA8qlVAV8xJUko2o9J2c27NLDs7dQcMbH7b5jeyXbD0miQKigmOwR?=
 =?iso-8859-1?Q?pKZb/3hl4lplQC9yIMHkt1ZQTUeknwmIWQWKEVlLnivlZ3+jTWjlxGMiET?=
 =?iso-8859-1?Q?7rQM1DVfiX/8L8Cs9lNUXWy6oVDiFEJftN5eis9m2C6qGTowJqJOg0IJD6?=
 =?iso-8859-1?Q?EkKW8chXRh3g8MRMszdnp0hKeAJS6SQbAWZCSK/qBvIMrhtJVvSv0AHlu1?=
 =?iso-8859-1?Q?B0Ms/nrzsCB+kSEwMBocCUr4qu2klRqYQx3II6t3VWyBDXSxAH0JxH7goi?=
 =?iso-8859-1?Q?0WAy2943bDGlXuAo3280hUjrYudrTwpD2kkHRVnuVjTo37jzrk0ytKhDfZ?=
 =?iso-8859-1?Q?sOanNwa6HRd80kpSf8QDOml6u9Kb6ZOHafyoGTF9KEJe3iAyAkMfiQX/j0?=
 =?iso-8859-1?Q?cSSTFpQgyB3veRb/qOYnbvUHvnR3AptzSCJTgm8pBcgSw/qQ9X3KwPvMnl?=
 =?iso-8859-1?Q?k1WGVcgmbtNnE3hIwsXhN5UoyLRO3+EsypYAhLdC75Z/DcR88wflcRiqD2?=
 =?iso-8859-1?Q?UjHzG9kmlGHK8KO24n5g8THsrKFsXfFq0lOteJ5Mt/luh39a7xZbRqrsLJ?=
 =?iso-8859-1?Q?DVSkYD9InTLOuKmc8QD1NM8/63oIE14haBa2ihVd7bViBEGxYQPnq9nkxs?=
 =?iso-8859-1?Q?L91NyZeyq4fRDohtocs8IiCgrneiBy4ggI9/MSZb++GS8a4LHEwalIar13?=
 =?iso-8859-1?Q?N7XBsr9yNhRvR8gOuh5DDTQlVeSYinpyL8BFAVw6/r8PMYw6aiesa2gZE6?=
 =?iso-8859-1?Q?XIl2wwJQpncfklKwCNh07pXVmLjZ5N4fGe8WfTQW2axhK2/FnnFq3oavzu?=
 =?iso-8859-1?Q?04o83HtvK2bzn2CKT0s7GUJaf+IHVduZnMNKwNwWLppKI7I5JJ6ufkyI2h?=
 =?iso-8859-1?Q?y7O/KVE8Wyo5NPeEbM5u5vobaP6jRSwwwqtjVVgtWYw3P9OLORNhR6sTsh?=
 =?iso-8859-1?Q?3itOZZmXGohlp394rLkJpfRZE/sZD1dLoxBWrixxxvSrzfa7qYDvoiYb0Q?=
 =?iso-8859-1?Q?Ao00WS0UjoQff+/8JeOX1RvzgDHrVNZwgJeHLf3T4KBoIMbsQgEVSKTTgJ?=
 =?iso-8859-1?Q?eFjytlhTl69zUooRwYRGTQW2o740AEoRu2fG3PROCUtB6D/HRFiVPQFhLn?=
 =?iso-8859-1?Q?2X9c6LmwFnVxA18YOqVv4A8w0Y1X8sWK7v2v5qN9Xc370b7J/b4yY8z/dh?=
 =?iso-8859-1?Q?rQ20Iq4eOQDGAJ5t/T3UPQzFlpooCj6ItzdYJC3PqA2jMaU/p8XaIaFEMa?=
 =?iso-8859-1?Q?tHNIodNpBoCSQFdZ7GnpYzBaQv+pUUhR/23VI4/YdKw0AvQYkOemmLipnw?=
 =?iso-8859-1?Q?2003CdkKLf0Bx9v8R6kVJLcxTIV/vIK7GWqmmStfcujnqVcs4ckInO1ioF?=
 =?iso-8859-1?Q?BOXbKetQ+lkVpJZah9tNIXpGv+hUlrCm4gl8N18ssFEHP+gpMklOYwllNn?=
 =?iso-8859-1?Q?8/hrKhpRw+eILoEhXWdHmL3SMf2X+r0rHnku1FVktIRgkP+CGkWYYlaX7A?=
 =?iso-8859-1?Q?t35YBndMdu8LuU3KoHpD69eXOOmg3NjcZH3YXBBmHo67wLexQgAhYOmEn3?=
 =?iso-8859-1?Q?3Zto5IShDrnlhQ7OUCUYE8H5UxX1/2HyDrk9h6dYkwT2lDVgCYg4mbss6H?=
 =?iso-8859-1?Q?a2N7Y7xYxJe1OTqaxPgEWJtWGnN11iwFnws6SwrdNGx8C1+YQr/pdvgjvU?=
 =?iso-8859-1?Q?XXEK9x+0+dWPDV9Pn2of+hH9n/5guIAi3S8gKLnAZmi8e+TnsSrKltS8D5?=
 =?iso-8859-1?Q?PN5oPEfuwLrLOXK9DI6ePfpchCNV06IPYXv2HNgX+GyQdfdvG/PAn3x1XL?=
 =?iso-8859-1?Q?a/mUqvEs1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4cKBfQL9wpNcQxBO42xYLBvxxRoWO1w1in6dD9/YWsj0JVtdkGixJbMD82MtZ6+PxKqpNCD8hRREIjzMDnM/nTMua4FVB7dZFQVFx/sFbVZuiYX2LMZPch9Ga9IEn5T4KrHjal+AI3KjHMMDuRnM0Zu3GJmd1oXSDvfQ3RYktOCNjwKT3zSDOLjH4X/h3YA1/w3/wyLDxPXQlYfAVkU9kkK3+xMaQmwB4w+Lo4YOP3hMaNP6Siu3sjlrsUhBAiuaeuj7ylgS2oyOwIsGBV2PXjUyoqecb5muMySnb9Kw98TGSD/yKEnqmPevUEuQDH3ujMzS1M7TvTwk8gMSfwYgFA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c304aa-b97c-4a40-d1d6-08df0711cd40
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:41:54.9269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3uEqf79fHuWZkRa01YB1U9LT31rX1/LwP1HONtXBlNtDeCQx8uRxZdpvS1YikOxlO9VUgUeMqYQi5grCqW0zxKvxziKi4kbf52hTTL7qEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6164
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

This series depends on:=0A=
=0A=
 1. [v3,0/4] Add ASPEED ACRY RSA model for the AST2600=0A=
    https://patchwork.kernel.org/project/qemu-devel/cover/20260831024450.27=
178-1-jamin_lin@aspeedtech.com/=0A=
=0A=
This series adds ECDSA to the QEMU crypto akcipher framework and models the=
=0A=
ASPEED AST10x0 secure boot controller (SBC) ECDSA engine on top of it.=0A=
=0A=
The crypto side adds ECDSA sign/verify for prime256v1 (NIST P-256) and=0A=
secp384r1 (NIST P-384) in both the gcrypt and nettle backends, using the ra=
w=0A=
big-endian form (public key Qx || Qy, private key scalar d, signature r || =
s)=0A=
with a pre-computed digest as input.=0A=
=0A=
Both the AST2600 and the AST1030/AST1060 have a Secure Boot Controller (SBC=
)=0A=
that supports RSA and ECDSA verification, but only the AST1030/AST1060 have=
 an=0A=
ECDSA verify engine, so this series models ECDSA only. RSA verification is =
used=0A=
solely to verify the AST2600 SPL in ROM CODE, which ASPEED does not release=
,=0A=
so it is very unlikely to be used by end users.=0A=
=0A=
v1:=0A=
 1. Add ECDSA akcipher support with gcrypt backend=0A=
 2. Add ECDSA akcipher support with nettle backend=0A=
 3. Add ECDSA sign/verify unit tests=0A=
 4. Support the ECDSA verify command for AST10x0=0A=
 5. Add ASPEED SBC ECDSA engine qtest=0A=
=0A=
v2:=0A=
 1. Wrap the SEC SRAM in a container mapped at offset 0 so the device=0A=
    addresses it by relative offset (drop the "sram-base" property)=0A=
 2. Add a patch removing the obsolete unimplemented SBC mapping=0A=
 3. Add Qtest to ast1060-evb machine.=0A=
 4. Rename R_ECDSA_CMD to R_SEC_TRIGGER, since the register=0A=
    triggers both the RSA and ECDSA engines.=0A=
=0A=
v3:=0A=
 1. fix typo=0A=
 2. Replace g_printerr with g_test_skip=0A=
=0A=
Jamin Lin (9):=0A=
  qapi/crypto: Add ECDSA algorithm and curve id=0A=
  crypto/akcipher: Support ECDSA sign/verify with gcrypt=0A=
  crypto/akcipher: Support ECDSA sign/verify with nettle=0A=
  hw/arm/aspeed_ast10x0: Remove obsolete unimplemented SBC mapping=0A=
  tests/crypto: Add ECDSA sign/verify tests=0A=
  hw/misc/aspeed_sbc: Support the ECDSA verify command=0A=
  hw/misc/aspeed_sbc: Increase register space to 0x1000=0A=
  hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model=0A=
  tests/qtest: Add ASPEED SBC ECDSA engine test=0A=
=0A=
 qapi/crypto.json                  |  33 ++-=0A=
 include/hw/misc/aspeed_sbc.h      |   6 +-=0A=
 hw/arm/aspeed_ast10x0.c           |  14 +-=0A=
 hw/misc/aspeed_sbc.c              | 158 +++++++++++++-=0A=
 tests/qtest/aspeed-sbc-test.c     | 194 ++++++++++++++++++=0A=
 tests/unit/test-crypto-akcipher.c | 236 +++++++++++++++++++++=0A=
 crypto/akcipher-gcrypt.c.inc      | 328 +++++++++++++++++++++++++++++-=0A=
 crypto/akcipher-nettle.c.inc      | 267 ++++++++++++++++++++++++=0A=
 hw/misc/trace-events              |   2 +=0A=
 tests/qtest/meson.build           |   2 +=0A=
 10 files changed, 1225 insertions(+), 15 deletions(-)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

