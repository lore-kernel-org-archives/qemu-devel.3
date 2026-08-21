Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A43C5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoG-0000yK-K8; Thu, 20 Aug 2026 23:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoF-0000y8-2C; Thu, 20 Aug 2026 23:20:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoC-0004BJ-J7; Thu, 20 Aug 2026 23:20:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq4tVGsq5EnfflFJ7Ds3nVqnsB1dhEz45tryTrWl+meC6pkh7DNeZwBa8KyZMtBWTvvCmCR1DryHiEaUkjTCbY+1/KLpeeu/c9ObuEZw6Kf9rsyz7EHdMVoExlHuwkEb8J8HSt2ruMiOozNakzJlJuJFbw5iA0npxSA15u3FCnIGRbYsYYnPgWxlyrP93Fga5F6O10/QLY0vupI2iafKxmCHqwJDkYi/KYhU9tExsciA/wDsiI+PAcmldL6U27XXIdGX9etCZWRrFsCBo9TRgdJuf9wdVvQnTwTAcbwIlOdqEdoP80FRMHSnMFSxQr3TmbQm2ZL6F+/EH+PhLY+sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNUcPiqDG+dJR2VX9uuC/bpK5VczrFmwEF+7yBDASpk=;
 b=klojxDSwJ07ts6jtF+JBGui/Ws0fguV9A6znVHwltvh1zeGZjltusan7kC1nTf+uFr+6FsZedCVWXnHDjGOHcTXTMC2vPHBApcypsStXQT7v1u9UDnxvwCaAEp/XJ2AsnTmKttsgjehFOfEgOkPZna9JQhM9aknl75qSoMit7Qw9CEbw/AkCTf0p51itSviv/oqIqJ062KYlfSYNnokLaHE/lFpsGqHOxu/yeV6laF0r9rFJOyyecEtcSB2OieqZjGQIF2V9WH15AfzyYlgC0AE9Kcm9FcDe9GnxMlAaDkwJJvJIdvo40kgzUlquVy2GR+iPWUNhBbBeuSaU6lh9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNUcPiqDG+dJR2VX9uuC/bpK5VczrFmwEF+7yBDASpk=;
 b=S3DlEIRxkrcoUFdUJplUj05IHWvCZdfT4kLnAVjGPVhFkdzK/sMVsKcqMEKAnlowCGVEcfBWb0OAOaQG/CLrWbdU2oJ/UjQvmNBfeeKOvsUpOVkUgUlWl0/Jb///Y7Tmb9kzoZtw8eo+GdKJyK1L43Sc+ENo5he51bY6aJdwr/DD7gg89r80R3LL12MzLY/wPGI6j+DTIBbF9q6u9TiZ5r4bSR4AZSkHQM7ykPpYdNERBIYjQx0hTDoo7HRCnCxAoRfOqeo63ehNpGWWIlIi4rNFGX7PVM9I6RYyewMmUO0smUp/F+7YVgJGwrLhqxFWn56nRlFL99LpOESuPocnHg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:37 +0000
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
Subject: [PATCH v2 0/9] Add ECDSA akcipher support and the ASPEED SBC ECDSA
 engine for AST10x0
Thread-Topic: [PATCH v2 0/9] Add ECDSA akcipher support and the ASPEED SBC
 ECDSA engine for AST10x0
Thread-Index: AQHdMRwJaTuZNfcV60iMfoOMvWfE3w==
Date: Fri, 21 Aug 2026 03:20:37 +0000
Message-ID: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: 2ecc7330-921a-487b-94d3-08deff332b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|18002099003;
x-microsoft-antispam-message-info: YdvyML7LTl8IDgeyEgAbyjK3iNzYlRH1hNspD77wSnHhoQ0V8nmwbLoJhr5FWajcI7hl/qXLeoi1VpyhmukziVm1hQdFduGuKCVDPHoXO8GZE0FQeVmLn44fgDbmB9EHV3uJlNOTkRrVD+VBVV8oSJt1boXQm1GcZ0PLnkkfW3FIRU/Bml9zI+JYKR6rANTwTnAs4MDwvgt3iAmJUQtQ4RE9+eYeHuEyGMEjEinKyAUOpEmlzsUX1gfSDMX3m3PhkRTsUYY5zfNSh9ic+65+Pi6/SO0j67PUmOIuupY2OR0CgnVAXvZWLyB+ODU8VUbGRFJFZH0fMtmE3HiqRfgM1erGDvoaedbCwL1w//2uQJpJJj7mmjqVU6Sb9GRIJ6c+VH9im2pIB+0YnM64Oi7P1kGyK+JrisOvtBUP+1FgvbZY/5+QfmoGzcEOujmAphDGFDWryf15xW5LmO731nijqseMtb7UXiggkQHpfBcGtpgFZtKJxMeR+kOlR6lPve7qM/zO/blJWg1IrsQGw6LXMFaTN0obyQesf1cImWdbYBtr/TYtX5s7H0eK51iSvT7qzn1P5OiIwZcbnGILwfrDHdtls1UXVipLlLU4hiBitSxiNXunMFBHFshM22RCGwMkVYFdO2H7VwXJREcMopoaGw7gOBTno+QTjsyEeTiZUznh6+GHbjpASWBWZXkzI+OFvqXzF1fX2GCrMDv/gG5RZcm+3pBAOePTR4eYqo9gysThzLu1efoJB9iQp91DpWT3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lhTm7bhQoQVaj5RqI+7BC3tQZvZ6Ad7+mNH7NO/YamIPNaAaU61zA8ukTE?=
 =?iso-8859-1?Q?0mtKbXU/FqGiUqHRLdanRUggwgnUS2knHkvNbkkn0IQcXV6CKO+G4IaSde?=
 =?iso-8859-1?Q?NrQzwVk948g1VM45gNE5deqf66nXjizFel92euQkqiJM21GUDf7ix4mD6h?=
 =?iso-8859-1?Q?UQgzJnGK5w8Ov+I4rPoY0PXnqJ4YPOov9o7mZbFLgvghdLhb1Xqn3odglr?=
 =?iso-8859-1?Q?7cXDbogZvcmeobRPTu3DGLWc1scKKpC6iYJpkys30QcY5I2S9tdsD8YwLU?=
 =?iso-8859-1?Q?2UTXUq+J640CTN2j3FztwtY6mb+oOzYARS+OPeqq+dZGsg0hkhPZrjm3vx?=
 =?iso-8859-1?Q?HgBahj1WHXyBvrE7N5+XSYeBtNCVjhBHCzwSKqPpdiAhelShDMX+/ZByxd?=
 =?iso-8859-1?Q?zflDxGakh/OYJ947BGCdMgY1Mv/dkLeGPrwhtUhU2Hfn+fEqbyHRMoMxlg?=
 =?iso-8859-1?Q?a8hNCyDa9dONT5eJYT4tCIcyNd0wQ7IZpOpfVWV/U1F4BNUyvgd2MwQtkq?=
 =?iso-8859-1?Q?SCvH1PWbn1H6X0Sb5MZXoueI40jsMTkE49mPeP9I6yu0kFsHngdTwtscdJ?=
 =?iso-8859-1?Q?Ma85tNeQ3SgZJ6lxfR7kI+pTDom4pru5QgKmUCg9i9uXljJCiZfAEVfZmz?=
 =?iso-8859-1?Q?sa8K1wYTUwtCYPpqltCJsX8edJspM/M9TfzHNTq41t5uEz9wB5LmdKDdt8?=
 =?iso-8859-1?Q?HgLCfxk93y1/+/Az3HcXM1agdLBM4t8TD4yns/rS4jzQ/EyY1IJeNR7l1P?=
 =?iso-8859-1?Q?XTA8+u/IPbmWTh1yJcDDxPjGhmV+A1sOadEqOJ/kFNiv9saTLR739YX+pB?=
 =?iso-8859-1?Q?1cd61QTpfSed9Mo0GfKhc7B1IsiVDpNt+FFnAXqS6xefB+A6A/pX/Q2QiM?=
 =?iso-8859-1?Q?6oFCzlVhTF8GeKBNqFqlgdBqkO704gNhAvt6KxsKEb9cCBua+t4R15alBb?=
 =?iso-8859-1?Q?ilreXCtUZaYphq92hxJT1/I6ecTjq4Ca8Nvz8Fzic5Ms6CRCweHw2K66Fl?=
 =?iso-8859-1?Q?WwUiZDFFL2tGnJjaYNYQlaX/ReTJ6tuqjKC/xnTSpMgiVmRPRkTKsDD5QS?=
 =?iso-8859-1?Q?9qtx1RaEhJIOvb8bwTW/bqjUgaC8GcVf04ASDOSfWIJMO9cjq1k+Z+qmOS?=
 =?iso-8859-1?Q?d4GhIo8hprIy9WbNa29sxXCsA3D/cQT6esJirSQD1mhRPEkxPe1CLV9lIx?=
 =?iso-8859-1?Q?HEMP/ZQoEOy4gJfsMw9ioMJgCNQ6jno95bww9Qk+B61ZA5VxyCidSm+zgZ?=
 =?iso-8859-1?Q?6Hqsh5lwwDXNtpPId4kDRJh2lyHwovb2NWsO6EnJJ4w/JVd8mWJcsEADmx?=
 =?iso-8859-1?Q?SRmtgtv3G+lmmnRll5UO7Y8yTCqABgYIKfxti2nzvjD8qy9vdx4UeyeevL?=
 =?iso-8859-1?Q?xT7oQfiuxmXhF8wqdJeHNnO6/1qu7ZCf9XbcvIPMnicR5808lu9I2n4INH?=
 =?iso-8859-1?Q?ZhOQWZHQOzx9v8WsENOcIE4DnTfO0LPna1izicmnZrjCK/QrtSfQWnSeoh?=
 =?iso-8859-1?Q?VVRlO8nn/78vRa/m0B5PD9nUztuVZx9WZA6q7NLQGV9IXn4Q0iYS4Tehq+?=
 =?iso-8859-1?Q?DM3ZL0+s1yzo+UMbEKAtsk0pD6JXUGEMHbRy9FnmMLu008TX9tzH8BiOoi?=
 =?iso-8859-1?Q?9mldv3GxKqXddLSWCffFzeLno2YCiNPuvwNp/yLXGQF9DKnmI6z1JruwF1?=
 =?iso-8859-1?Q?PKsIvNhZdmlx3VKaCnbKOf1L4PIMMMbGMN2X35/qWeO1TFV4GFMUq5PYop?=
 =?iso-8859-1?Q?WNTbWEwTyQzVFG3jUoqoQ1ldRLvRMya+kf7sMOcT94qmCIsLv8jhAsQtvp?=
 =?iso-8859-1?Q?P+O5LZYYiQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UGpu3HwOU09jS21XNOMbeXmlym4nE0jXozF/nRaGtXXO6seifI0Xucs+rTLYL2MVHlsNRAESWcl06ZRo9VPXkPt97zHsr7sKLl9xQvLJFFKyY8w8RR+aQvYmfYkLawZnUmk2e4n36jaj1yWxvllDmImI7ET5CB3KbNrbGXZT3/doUKgl0JmM1bgg32IngjNHfSLArzJSxl24zzBSsEWwbyrdQ+C6NimjVb2C3S1TGguzQYRH5u4SQz6Zqaj9t5g0R7eN6PCNvRhMGx88lhUCxPg3VOwiQ5EUAO47denBv3GYjmr0TdwwlgxmGKcqHTSbhJr8P+oq4LZ3PcsHK5Lz0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecc7330-921a-487b-94d3-08deff332b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:37.3068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YnKIeDagWS6ar60ctgzxs8b7iM7/KS7+0UKjwvpjcURxvwCTFsQh6YLoDREwXb3PIC1jUcksguMlPQAaGMc5AhaDMB0eQ3FMPjXmJ5df+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

This series depends on:=0A=
=0A=
 1. [v2,0/4] Add ASPEED ACRY RSA model for the AST2600=0A=
    https://patchwork.kernel.org/project/qemu-devel/cover/20260820081206.33=
53463-1-jamin_lin@aspeedtech.com/=0A=
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
 tests/qtest/aspeed-sbc-test.c     | 193 ++++++++++++++++++=0A=
 tests/unit/test-crypto-akcipher.c | 236 +++++++++++++++++++++=0A=
 crypto/akcipher-gcrypt.c.inc      | 328 +++++++++++++++++++++++++++++-=0A=
 crypto/akcipher-nettle.c.inc      | 267 ++++++++++++++++++++++++=0A=
 hw/misc/trace-events              |   2 +=0A=
 tests/qtest/meson.build           |   2 +=0A=
 10 files changed, 1224 insertions(+), 15 deletions(-)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

