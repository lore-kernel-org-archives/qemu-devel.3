Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E16C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUWSZ-0001y0-KQ; Wed, 25 Jun 2025 16:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWSX-0001xZ-EQ
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:11:05 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWST-0004lk-7J
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqR2MAdv9ocseGXM82puHwr++yOAuD7gDbc/19OMkWXqPjMTuHDWzEoAC6IURI6g8f8fV5PAsG20IOV1QqdZ+jt5W8gTLvP6CLZb84OM3JCteBUCoTVol6m1isxb1xo6DqyUZgYiAsbnzN6Vjf9upb8GWV1397JMmxgGQlZu6bEQxcS66MdSWO2rNLUEDYs/CNUqnALc6x8SqF9tLCJ9HadBQa3DeGmI4he+j/GCFv5/OdvcJuolIgE70ARxBqEomW4HWrT/tDnjOQ/WnJvMyJOAwQCW+0jBaBRMQZKGL2ibnb1IOlkD5cg2LbADVeDZbz0aJX9s8aIlTVHpUoehYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNHMOv94m5GhrMELtva2rjZtMW9Mxm8gydeEgpIN6R8=;
 b=jIgWUDb3LGSmNaTfFZ08vNZQjTnBHjot5CCEDlKboG9q6sPjk5FcqkRF/cNd3DCoVT7dG958WMpXEvNPZGjeUcSA5XsmIxXU1D2GSpv9BieeLfvRWju3ao+2f3AiYy9d+TmpPFprr6A0S8Zh3b3TC6eyem9TtJ9AJ1ZXEBPEEHWAVX4YhtnEyOZWsIUpaMpMzrpzLuKaM4qtBmja9FwyU8WfCDo49/8TknAtfrfzbHZjGGA+a27zo4lMNiLSoN/aoXqlf5mYGCiOOLv6gOoAgJPCZaAY3unkKdtyPlXLJUT2cY2rSZlLcWaUXX8cyao7txlIGMGDD0wXH4KKU+/xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNHMOv94m5GhrMELtva2rjZtMW9Mxm8gydeEgpIN6R8=;
 b=e5IUaqP5xqQLR0kaxFIs1oqUpkE8dKsHWoMs4wDYrpq8lzpZJCh6wFYmrH2IXyLInuiTwOuDaxUYT12m8RZ4ItaLoHar4MHD2Yn16YOAO3nzhavLFaaIJWMN8I7h8617c+AuT1JcJ3UQxRM4ip8Hy2Odd+EeeFjy100LRi021YfWLsDxNixj5k1rhzGBd6r8JcQfwlcpP6ZKI42aW6YP4n6KI19prklq/Do6iiuf+XyOzCnW80PW5/dri0r+MbHnjG1lXpGy8Kk/FTtyRcfI+gFz/f8Klb4mVpap23MZZdKqxqHttPlIN9/GloLUe+jaHlcSuFNnIvhB7vy3F/u61A==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AM7PR09MB3687.eurprd09.prod.outlook.com (2603:10a6:20b:109::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 20:10:29 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 20:10:29 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v6 1/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v6 1/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5g0yLd2/xpGLrkCpawdONbmDlw==
Date: Wed, 25 Jun 2025 20:10:28 +0000
Message-ID: <20250625201005.1480421-3-aleksandar.rakic@htecgroup.com>
References: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AM7PR09MB3687:EE_
x-ms-office365-filtering-correlation-id: c09e64c7-c6ad-4044-7463-08ddb42454c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8jWKoKNArm3u3/J0sqtBfkbsaeENxCDLetlMNugX8uP4Xuh2Vdc6A1iJxW?=
 =?iso-8859-1?Q?sVKpSaCrZ+m9Ik0OgdystTUIzd60b2zQ7QaYVzO0lXY6jPJy+GU8GSkGBN?=
 =?iso-8859-1?Q?u6cRNodpwS+NGXbExVnE/dF/0XbATozyvxvvcXWVhTmgDOVsqfYhFbAWJe?=
 =?iso-8859-1?Q?zbB3Bdx6qERI/ig4pgxMI7eGJ829vbXSjtdVwJmNAeZjD5FMD1p8ueQ4Ve?=
 =?iso-8859-1?Q?QRDPBNHIqMkW1kaH49ps0X5Y+njEboFkFEVELWeiJR3nAN3fg9ydtP46Ou?=
 =?iso-8859-1?Q?YbgWPAoXD/0uYIJ5aw6THKpp7OmwdDRH0k6k3Rz9eoYaQWbHewklW2NC/u?=
 =?iso-8859-1?Q?Zed11cEZrjYLIpfAzbFDge/lQH9mQvr0vUn1QmCtw63oz6cKXcILin0MTQ?=
 =?iso-8859-1?Q?/97+O0yJGLokvFzH3kbZQCA7cDvy4tBZEAbta+GMhaB/uOuHLqrJWIFKBL?=
 =?iso-8859-1?Q?JvSjWu9WMhT+/08679imLdRppwQ6djQRIEcftoeV8bRl4TPhcE3su7IbSi?=
 =?iso-8859-1?Q?2qdwoeLLwvlHdSCMQTCAaHUPegoaHjhmQUIOD6LCLP/A1h30lULnwWqUnl?=
 =?iso-8859-1?Q?jTPqHgWozAn3MkKBAhowZFqEeIA8K3VtvZC63wDKGWC9fVr7K4ct+WSi7D?=
 =?iso-8859-1?Q?tIZR2Ul/cIFSfvAHm9eOQsbMqvHEv7v24gXDFnEjVI28XZ9MK5dIBXYDDc?=
 =?iso-8859-1?Q?N02ShsTuDU2SSjxwqrmfNWI9g50xJ4HGagrvcTQbcaEyftUtXR2l+jsR7k?=
 =?iso-8859-1?Q?OMXS+Xx+MpA6xUXNrQVoa5qnIgu/6OBe6TOU7edzQbeiBZkUjr8AJTlrd7?=
 =?iso-8859-1?Q?imh75y6zKKNGvn2d1g6mOy2FN25EyHHQRbzMZf/sw1Q06wqESlJPBRjNHJ?=
 =?iso-8859-1?Q?9V4BFGUDU9xuWLDmImFw3eCOFo9aH8F/q+Bi93fTx3LrRxz35eiPYu6c96?=
 =?iso-8859-1?Q?gQgFmJsFLArJ8geiO+I+Mkzszd2TnqrzQjJYudWzh8UEERv8D5B4yCyvE/?=
 =?iso-8859-1?Q?EuuPhKUWRolJEwUnP9caqhrH+7ytXQudkDNHpdEYA0jaQhURr8gK/hxBrd?=
 =?iso-8859-1?Q?fJczkCRbFw88Bo7Upgf0sE9sQU/Rqo6mE+J84iQV5NPIPjHBtvkmfJ9SC8?=
 =?iso-8859-1?Q?QD5OJ4svOwD/Ivx+36lnR8Wv+GsS0xKTlJJBtLsIAi6Yy/oDMr+rIBrTD8?=
 =?iso-8859-1?Q?QVRbG3ueQHWX54K0AHPYvoRpCt80mLdSit3XbBGjqVaFcwWOpG/J7r5DRJ?=
 =?iso-8859-1?Q?LN49Cs1WqyYz+9zEUfqPQslylwEr/FgprA7pH7pBoFPbf7NQfETGony3qT?=
 =?iso-8859-1?Q?0XmSNTZMDTpDDDR919ef/CWf6DgZkNZdL2KzRngYiNUM7+cMLt4bdHetvY?=
 =?iso-8859-1?Q?a5xfINNCfTpo3PScsVxW8B68hv6yTZ0+5cXUsz+rrHzm5tzLrgTYVrBskZ?=
 =?iso-8859-1?Q?gOvLd6Pwb5MFaldpllM8JslMccVUjkB+ybbhSyEk+txyQdjI6HPSjCWUkq?=
 =?iso-8859-1?Q?JfBZ+lfGapmXFk5jpbi69uxxYfyg6QxbpsX4g5oLEhOQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?twzvyU+UjKpqqdkO7ul6vHRSF7EBcE1uYXClXmiE92ZP0+gHU4pbiaIXau?=
 =?iso-8859-1?Q?5zwWOYNYCLMHmzLaVua2SDeLsHwLhx5yRkewcUU5D2htaMbitDoyP+wdoH?=
 =?iso-8859-1?Q?TM7XSet0fPhMh7uPClTjy4tGMwJvuFBRtQURR8DHxDEz4J8IdcvTcLJqUN?=
 =?iso-8859-1?Q?fS4P8yDS3Y8EmqpGjA4QkmOYaNbsQpqfTAPu4ecES6umUbK/KCwO8JjtFr?=
 =?iso-8859-1?Q?ySkbPMutbWsQ2zciaEowiuzh0ariQB7z0rZQrLbV2QuTwDEo74rIgGPE4V?=
 =?iso-8859-1?Q?v9rywO4P205m+wPlbwiA8jYy02M6jWZXm8yM172ComiREh0qOOes0OQtpQ?=
 =?iso-8859-1?Q?c+/Go93zWBkFiVkZxFR4kSbPIH0JPQsi+oNsuh2PpGnEKx6iac6RANtS+S?=
 =?iso-8859-1?Q?3sZ0Df4rZ34iFgMqFbdzEU4tS33O8laZWuJ6NhdygxmPXIX+EUE5RdXoIr?=
 =?iso-8859-1?Q?B77zwdAo/C93V7azzvqGVU4MU28Vk3vycPZXttXFaOHhhJcM2BctsOUDfq?=
 =?iso-8859-1?Q?hq1VQTHdU8x2Y1imhtm4xT5+G3u8w7MZPRhAvEkKYIYxWmkufeyM32ionS?=
 =?iso-8859-1?Q?OfiItJ0ZBbKN2wo+p7KOWVdEKdpS6cdeKjxCsSvAILAW11k/LS3mbVnEEL?=
 =?iso-8859-1?Q?MzvT5HkBE8U/8nxXMVmcZM+EPL0ykOQEpWwAxaE9wo9UC22ifzdc68SLLz?=
 =?iso-8859-1?Q?YZm1bPFUv3dtSeycz8Y/stJK2cbX9FBNXMyq/XWUpic+bNt4mni3WUW8d6?=
 =?iso-8859-1?Q?yjLCUjfHyGWvAM1kdOMlc2ETeejsUOq4WsiWBKJWSeMGTtk30C9UTLoOSP?=
 =?iso-8859-1?Q?vcQ0dQogLPs8uxDPJ0rquCDGTNWzI0xhsQTnpQHW1imAK6mnzv1I9mjCnB?=
 =?iso-8859-1?Q?oBW2uwOxP43ukinxJ+vvYndUNWqGHaAGzs9SHTfDaec3hsruxDL3lBOi5P?=
 =?iso-8859-1?Q?oxM7CrkqD84NqiU9+UJ8AV+4UTXbIIGmOEMAh9QX7ors67rt09yIoOkWF+?=
 =?iso-8859-1?Q?V3AfUnIqDv32Ua4ol4tVUCLnJ7YbyYFRS5Bpj3Rspu+p9l+3+COf4ZRPPF?=
 =?iso-8859-1?Q?fJmMF6Mx67/hGV539dUOI0KkM2ph9IA5oPGwY0ZtBCcR2g9l+uv003z9DH?=
 =?iso-8859-1?Q?0KWqCpjCLChKqCo483HnHwg9DIi50OdhY/g0RLLxMTSnFNxQg4AzgO/kTy?=
 =?iso-8859-1?Q?LqOP4mNgHVKjBHTeTg1m1rlW2+lg+1SO5zB+1Xa/PHns9ziWdYUbokS5VN?=
 =?iso-8859-1?Q?pwfGvHkwHrBx85ws0HZ3RCio0/UWhMzsLBBAutm5dlclOnWear0H4bu7Vo?=
 =?iso-8859-1?Q?Ret8ITRKPAzKZG9x2sEYI/vqyZYvutS2qjnEZg36k3+Lrn22bA2FGJ6kan?=
 =?iso-8859-1?Q?C60Vq8oriuv8FKC0Ws9PkJNBhiqYRbY9DVVaLkz6egMMuQqapMZWIC+hF7?=
 =?iso-8859-1?Q?mUGZR+9/FEJULFkR/x4HPPr7cLZx+5eJlycejje4lTj9DDkTNQTiuzK0fk?=
 =?iso-8859-1?Q?0JEEYZTpEtBM32Gos3nVmubw8SCUH3cwq6Y/vu5TwJzDJ5Tu34RzdmwzWF?=
 =?iso-8859-1?Q?D3QkCdPLksM+eC6DWdQDBFDvrbu8tLNMJE8LmUZA/jt49koaimN6eyXz2P?=
 =?iso-8859-1?Q?P5UNVivNa6H5vM8qyJwUGlzRAai/mF1oCYeg3ofKi+8mn1073vDQJWD6mO?=
 =?iso-8859-1?Q?XkTGJOGdYsIWK7aocnw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09e64c7-c6ad-4044-7463-08ddb42454c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 20:10:28.9900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD6r7xYa2MphLxt2kQ9NEl8EPnu5RA834tPuSxyzzdsd24qM+Bt4YW5Y8gYa1MfjRYQyNeGxWMDyMPWSrJlmFLEN/5C7dPhjcZ4bbU+/b7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3687
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
Reuse zlib crc32() and Linux crc32c().

Enable CRC for mips64r6.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
---
 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/helper.h                          |   2 +
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 ++++
 target/mips/tcg/translate.c                   |  37 +++++
 target/mips/tcg/translate.h                   |   1 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 16 files changed, 1287 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 922fc39138..d93b9d341a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -756,8 +756,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
@@ -796,8 +797,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 7e40041828..b6cd53c853 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
=20
+DEF_HELPER_3(crc32, tl, tl, tl, i32)
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
=20
 /* microMIPS functions */
diff --git a/target/mips/meson.build b/target/mips/meson.build
index 247979a2cf..abf0ce3e8b 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -7,6 +7,7 @@ mips_ss.add(files(
   'gdbstub.c',
   'msa.c',
 ))
+mips_ss.add(zlib)
=20
 if have_system
   subdir('system')
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index b906d10204..63fa3b0078 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -24,6 +24,8 @@
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
+#include "qemu/crc32c.h"
+#include <zlib.h>
=20
 static inline target_ulong bitswap(target_ulong v)
 {
@@ -142,6 +144,31 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shi=
ft, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
=20
+/* these crc32 functions are based on target/arm/helper-a64.c */
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
+}
+
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
+}
+
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
     /*
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 8658315f93..1892bad296 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -402,6 +402,7 @@ enum {
     OPC_LWE            =3D 0x2F | OPC_SPECIAL3,
=20
     /* R6 */
+    OPC_CRC32          =3D 0x0F | OPC_SPECIAL3,
     R6_OPC_PREF        =3D 0x35 | OPC_SPECIAL3,
     R6_OPC_CACHE       =3D 0x25 | OPC_SPECIAL3,
     R6_OPC_LL          =3D 0x36 | OPC_SPECIAL3,
@@ -13449,6 +13450,30 @@ static void decode_opc_special2_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     }
 }
=20
+static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+                      int crc32c)
+{
+    TCGv t0;
+    TCGv t1;
+    TCGv_i32 tsz =3D tcg_constant_i32(1 << sz);
+    if (rd =3D=3D 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    t0 =3D tcg_temp_new();
+    t1 =3D tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    gen_load_gpr(t1, rs);
+
+    if (crc32c) {
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
+    } else {
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
+    }
+
+}
+
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -13463,6 +13488,17 @@ static void decode_opc_special3_r6(CPUMIPSState *e=
nv, DisasContext *ctx)
=20
     op1 =3D MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
+    case OPC_CRC32:
+        if (unlikely(!ctx->crcp) ||
+            unlikely((extract32(ctx->opcode, 6, 2) =3D=3D 3) &&
+                     (!(ctx->hflags & MIPS_HFLAG_64))) ||
+            unlikely((extract32(ctx->opcode, 8, 3) >=3D 2))) {
+            gen_reserved_instruction(ctx);
+        }
+        gen_crc32(ctx, rt, rs, rt,
+                  extract32(ctx->opcode, 6, 2),
+                  extract32(ctx->opcode, 8, 3));
+        break;
     case R6_OPC_PREF:
         if (rt >=3D 24) {
             /* hint codes 24-31 are reserved and signal RI */
@@ -15095,6 +15131,7 @@ static void mips_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
     ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;
+    ctx->crcp =3D (env->CP0_Config5 >> CP0C5_CRCP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx =3D MIPS_HFLAG_UM;
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d183..64175f2060 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -51,6 +51,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool mi;
     int gi;
+    bool crcp;
 } DisasContext;
=20
 #define DISAS_STOP       DISAS_TARGET_0
diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/in=
clude/wrappers_mips64r6.h
index d1e5edb632..31f8054d5e 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -23,6 +23,8 @@
 #ifndef WRAPPERS_MIPS64R6_H
 #define WRAPPERS_MIPS64R6_H
=20
+#include <string.h>
+
=20
 #define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
 static inline void do_mips64r6_##suffix(const void *input,             \
@@ -80,4 +82,37 @@ DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
=20
=20
+#define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(const void *input1,            \
+                                        const void *input2,            \
+                                        void *output)                  \
+{                                                                      \
+    if (strncmp(#mnemonic, "crc32", 5) =3D=3D 0)                          =
 \
+        __asm__ volatile (                                             \
+           ".set crc\n\t"                                              \
+        );                                                             \
+                                                                       \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      "ld $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t2, $t1, $t2\n\t"                                   \
+      "sd $t2, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RT__RS_RT(CRC32B, crc32b)
+DO_MIPS64R6__RT__RS_RT(CRC32H, crc32h)
+DO_MIPS64R6__RT__RS_RT(CRC32W, crc32w)
+DO_MIPS64R6__RT__RS_RT(CRC32D, crc32d)
+
+DO_MIPS64R6__RT__RS_RT(CRC32CB, crc32cb)
+DO_MIPS64R6__RT__RS_RT(CRC32CH, crc32ch)
+DO_MIPS64R6__RT__RS_RT(CRC32CW, crc32cw)
+DO_MIPS64R6__RT__RS_RT(CRC32CD, crc32cd)
+
+
+
 #endif
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips=
/user/isa/mips64r6/crc/Makefile
new file mode 100644
index 0000000000..3601cb0cd0
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
@@ -0,0 +1,42 @@
+#
+#  Test program for MIPS64R6 CRC32 instructions
+#
+#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+#
+#  SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+ifndef PREFIX
+  $(error "PREFIX not set, please export GNU Toolchain install directory."=
)
+endif
+
+ifndef SYSROOT
+  $(error "SYSROOT not set, please export GNU Toolchain system root direct=
ory.")
+endif
+
+SIM =3D ../../../../../../../build/qemu-mips64
+SIM_FLAGS =3D -L $(SYSROOT)
+
+CC      =3D  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
+
+TESTCASES  =3D test_mips64r6_crc32b.tst
+TESTCASES +=3D test_mips64r6_crc32h.tst
+TESTCASES +=3D test_mips64r6_crc32w.tst
+TESTCASES +=3D test_mips64r6_crc32d.tst
+TESTCASES +=3D test_mips64r6_crc32cb.tst
+TESTCASES +=3D test_mips64r6_crc32ch.tst
+TESTCASES +=3D test_mips64r6_crc32cw.tst
+TESTCASES +=3D test_mips64r6_crc32cd.tst
+
+all: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+            echo $(SIM) $(SIM_FLAGS) ./$$case; \
+            $(SIM) $(SIM_FLAGS) ./$$case; \
+            echo $(RM) -rf ./$$case; \
+            $(RM) -rf ./$$case; \
+	done
+
+%.tst: %.c
+	$(CC) $< -o $@
+
+
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
new file mode 100644
index 0000000000..bb1f3f6924
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32B
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0x000000002d02ef8dULL,
+        0x000000001bab0fd1ULL,
+        0x0000000036561fa3ULL,
+        0xffffffffbf1caddaULL,
+        0xffffffff92e1bda8ULL,
+        0x00000000278c7949ULL,
+        0x000000000a71693bULL,
+        0x000000002dfd1072ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000036a9e05cULL,
+        0x000000001b54f02eULL,
+        0xffffffff921e4257ULL,
+        0xffffffffbfe35225ULL,
+        0x000000000a8e96c4ULL,
+        0x00000000277386b6ULL,
+        0x000000001bfe5a84ULL,                    /*  16  */
+        0x0000000036034af6ULL,
+        0x0000000000aaaaaaULL,
+        0x000000002d57bad8ULL,
+        0xffffffffa41d08a1ULL,
+        0xffffffff89e018d3ULL,
+        0x000000003c8ddc32ULL,
+        0x000000001170cc40ULL,
+        0x0000000036fcb509ULL,                    /*  24  */
+        0x000000001b01a57bULL,
+        0x000000002da84527ULL,
+        0x0000000000555555ULL,
+        0xffffffff891fe72cULL,
+        0xffffffffa4e2f75eULL,
+        0x00000000118f33bfULL,
+        0x000000003c7223cdULL,
+        0xffffffffbf2f9ee9ULL,                    /*  32  */
+        0xffffffff92d28e9bULL,
+        0xffffffffa47b6ec7ULL,
+        0xffffffff89867eb5ULL,
+        0x0000000000ccccccULL,
+        0x000000002d31dcbeULL,
+        0xffffffff985c185fULL,
+        0xffffffffb5a1082dULL,
+        0xffffffff922d7164ULL,                    /*  40  */
+        0xffffffffbfd06116ULL,
+        0xffffffff8979814aULL,
+        0xffffffffa4849138ULL,
+        0x000000002dce2341ULL,
+        0x0000000000333333ULL,
+        0xffffffffb55ef7d2ULL,
+        0xffffffff98a3e7a0ULL,
+        0x0000000027fdbe55ULL,                    /*  48  */
+        0x000000000a00ae27ULL,
+        0x000000003ca94e7bULL,
+        0x0000000011545e09ULL,
+        0xffffffff981eec70ULL,
+        0xffffffffb5e3fc02ULL,
+        0x00000000008e38e3ULL,
+        0x000000002d732891ULL,
+        0x000000000aff51d8ULL,                    /*  56  */
+        0x00000000270241aaULL,
+        0x0000000011aba1f6ULL,
+        0x000000003c56b184ULL,
+        0xffffffffb51c03fdULL,
+        0xffffffff98e1138fULL,
+        0x000000002d8cd76eULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0x00000000784a5a65ULL,
+        0xffffffff9bdd0d3bULL,
+        0xffffffffe7e61ce5ULL,
+        0x00000000782fabf7ULL,
+        0x00000000004d93c7ULL,
+        0xffffffffe3dac499ULL,
+        0xffffffff9fe1d547ULL,
+        0xffffffff9b4ca0e5ULL,                    /*  72  */
+        0xffffffffe32e98d5ULL,
+        0x0000000000b9cf8bULL,
+        0x000000007c82de55ULL,
+        0xffffffffe7904f52ULL,
+        0xffffffff9ff27762ULL,
+        0x000000007c65203cULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
new file mode 100644
index 0000000000..1439d44bf2
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CB
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CB";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0xffffffffad7d5351ULL,
+        0x00000000647e6465ULL,
+        0xffffffffc9fcc8cbULL,
+        0x00000000237f7689ULL,
+        0xffffffff8efdda27ULL,
+        0xffffffff837defedULL,
+        0x000000002eff4343ULL,
+        0xffffffffad82acaeULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffffc9033734ULL,
+        0x0000000064819b9aULL,
+        0xffffffff8e0225d8ULL,
+        0x0000000023808976ULL,
+        0x000000002e00bcbcULL,
+        0xffffffff83821012ULL,
+        0x00000000642b3130ULL,                    /*  16  */
+        0xffffffffc9a99d9eULL,
+        0x0000000000aaaaaaULL,
+        0xffffffffad280604ULL,
+        0x0000000047abb846ULL,
+        0xffffffffea2914e8ULL,
+        0xffffffffe7a92122ULL,
+        0x000000004a2b8d8cULL,
+        0xffffffffc9566261ULL,                    /*  24  */
+        0x0000000064d4cecfULL,
+        0xffffffffadd7f9fbULL,
+        0x0000000000555555ULL,
+        0xffffffffead6eb17ULL,
+        0x00000000475447b9ULL,
+        0x000000004ad47273ULL,
+        0xffffffffe756deddULL,
+        0x00000000234c45baULL,                    /*  32  */
+        0xffffffff8ecee914ULL,
+        0x0000000047cdde20ULL,
+        0xffffffffea4f728eULL,
+        0x0000000000ccccccULL,
+        0xffffffffad4e6062ULL,
+        0xffffffffa0ce55a8ULL,
+        0x000000000d4cf906ULL,
+        0xffffffff8e3116ebULL,                    /*  40  */
+        0x0000000023b3ba45ULL,
+        0xffffffffeab08d71ULL,
+        0x00000000473221dfULL,
+        0xffffffffadb19f9dULL,
+        0x0000000000333333ULL,
+        0x000000000db306f9ULL,
+        0xffffffffa031aa57ULL,
+        0xffffffff830c28f1ULL,                    /*  48  */
+        0x000000002e8e845fULL,
+        0xffffffffe78db36bULL,
+        0x000000004a0f1fc5ULL,
+        0xffffffffa08ca187ULL,
+        0x000000000d0e0d29ULL,
+        0x00000000008e38e3ULL,
+        0xffffffffad0c944dULL,
+        0x000000002e717ba0ULL,                    /*  56  */
+        0xffffffff83f3d70eULL,
+        0x000000004af0e03aULL,
+        0xffffffffe7724c94ULL,
+        0x000000000df1f2d6ULL,
+        0xffffffffa0735e78ULL,
+        0xffffffffadf36bb2ULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0xffffffffcbefd6b4ULL,
+        0xffffffffc334e94fULL,
+        0xffffffffac268ec5ULL,
+        0xffffffffcb8a2726ULL,
+        0x00000000004d93c7ULL,
+        0x000000000896ac3cULL,
+        0x000000006784cbb6ULL,
+        0xffffffffc3a54491ULL,                    /*  72  */
+        0x000000000862f070ULL,
+        0x0000000000b9cf8bULL,
+        0x000000006faba801ULL,
+        0xffffffffac50dd72ULL,
+        0x0000000067976993ULL,
+        0x000000006f4c5668ULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
new file mode 100644
index 0000000000..bf258e0696
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CD
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CD";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffb798b438ULL,                    /*   0  */
+        0xffffffffc44ff94dULL,
+        0xffffffff992a70ebULL,
+        0xffffffffeafd3d9eULL,
+        0x000000005152da26ULL,
+        0x0000000022859753ULL,
+        0x0000000015cb6d32ULL,
+        0x00000000661c2047ULL,
+        0x0000000073d74d75ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005d6589a6ULL,
+        0x000000002eb2c4d3ULL,
+        0xffffffff951d236bULL,
+        0xffffffffe6ca6e1eULL,
+        0xffffffffd184947fULL,
+        0xffffffffa253d90aULL,
+        0x0000000008f9ceacULL,                    /*  16  */
+        0x000000007b2e83d9ULL,
+        0x00000000264b0a7fULL,
+        0x00000000559c470aULL,
+        0xffffffffee33a0b2ULL,
+        0xffffffff9de4edc7ULL,
+        0xffffffffaaaa17a6ULL,
+        0xffffffffd97d5ad3ULL,
+        0xffffffffccb637e1ULL,                    /*  24  */
+        0xffffffffbf617a94ULL,
+        0xffffffffe204f332ULL,
+        0xffffffff91d3be47ULL,
+        0x000000002a7c59ffULL,
+        0x0000000059ab148aULL,
+        0x000000006ee5eeebULL,
+        0x000000001d32a39eULL,
+        0x0000000021e3b01bULL,                    /*  32  */
+        0x000000005234fd6eULL,
+        0x000000000f5174c8ULL,
+        0x000000007c8639bdULL,
+        0xffffffffc729de05ULL,
+        0xffffffffb4fe9370ULL,
+        0xffffffff83b06911ULL,
+        0xfffffffff0672464ULL,
+        0xffffffffe5ac4956ULL,                    /*  40  */
+        0xffffffff967b0423ULL,
+        0xffffffffcb1e8d85ULL,
+        0xffffffffb8c9c0f0ULL,
+        0x0000000003662748ULL,
+        0x0000000070b16a3dULL,
+        0x0000000047ff905cULL,
+        0x000000003428dd29ULL,
+        0xffffffffb89d59a6ULL,                    /*  48  */
+        0xffffffffcb4a14d3ULL,
+        0xffffffff962f9d75ULL,
+        0xffffffffe5f8d000ULL,
+        0x000000005e5737b8ULL,
+        0x000000002d807acdULL,
+        0x000000001ace80acULL,
+        0x000000006919cdd9ULL,
+        0x000000007cd2a0ebULL,                    /*  56  */
+        0x000000000f05ed9eULL,
+        0x0000000052606438ULL,
+        0x0000000021b7294dULL,
+        0xffffffff9a18cef5ULL,
+        0xffffffffe9cf8380ULL,
+        0xffffffffde8179e1ULL,
+        0xffffffffad563494ULL,
+        0x000000003a358bb3ULL,                    /*  64  */
+        0xffffffff975446ebULL,
+        0x0000000041d37ad6ULL,
+        0x000000004be84fe1ULL,
+        0xffffffff9671b1b3ULL,
+        0x000000003b107cebULL,
+        0xffffffffed9740d6ULL,
+        0xffffffffe7ac75e1ULL,
+        0xffffffffa1489696ULL,                    /*  72  */
+        0x000000000c295bceULL,
+        0xffffffffdaae67f3ULL,
+        0xffffffffd09552c4ULL,
+        0x0000000042bd7071ULL,
+        0xffffffffefdcbd29ULL,
+        0x00000000395b8114ULL,
+        0x000000003360b423ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
new file mode 100644
index 0000000000..0e7b67732e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CH
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0x000000000e9e77d2ULL,
+        0xfffffffff92eaa4bULL,
+        0xfffffffff7b02266ULL,
+        0x00000000571acc93ULL,
+        0x00000000598444beULL,
+        0xfffffffff1e6ca77ULL,
+        0xffffffffff78425aULL,
+        0x000000000e9e882dULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xfffffffff7b0dd99ULL,
+        0xfffffffff92e55b4ULL,
+        0x000000005984bb41ULL,
+        0x00000000571a336cULL,
+        0xffffffffff78bda5ULL,
+        0xfffffffff1e63588ULL,
+        0xfffffffff92eff1eULL,                    /*  16  */
+        0xfffffffff7b07733ULL,
+        0x000000000000aaaaULL,
+        0x000000000e9e2287ULL,
+        0xffffffffae34cc72ULL,
+        0xffffffffa0aa445fULL,
+        0x0000000008c8ca96ULL,
+        0x00000000065642bbULL,
+        0xfffffffff7b088ccULL,                    /*  24  */
+        0xfffffffff92e00e1ULL,
+        0x000000000e9edd78ULL,
+        0x0000000000005555ULL,
+        0xffffffffa0aabba0ULL,
+        0xffffffffae34338dULL,
+        0x000000000656bd44ULL,
+        0x0000000008c83569ULL,
+        0x00000000571affa0ULL,                    /*  32  */
+        0x000000005984778dULL,
+        0xffffffffae34aa14ULL,
+        0xffffffffa0aa2239ULL,
+        0x000000000000ccccULL,
+        0x000000000e9e44e1ULL,
+        0xffffffffa6fcca28ULL,
+        0xffffffffa8624205ULL,
+        0x0000000059848872ULL,                    /*  40  */
+        0x00000000571a005fULL,
+        0xffffffffa0aaddc6ULL,
+        0xffffffffae3455ebULL,
+        0x000000000e9ebb1eULL,
+        0x0000000000003333ULL,
+        0xffffffffa862bdfaULL,
+        0xffffffffa6fc35d7ULL,
+        0xfffffffff1e6bbb0ULL,                    /*  48  */
+        0xffffffffff78339dULL,
+        0x0000000008c8ee04ULL,
+        0x0000000006566629ULL,
+        0xffffffffa6fc88dcULL,
+        0xffffffffa86200f1ULL,
+        0x0000000000008e38ULL,
+        0x000000000e9e0615ULL,
+        0xffffffffff78cc62ULL,                    /*  56  */
+        0xfffffffff1e6444fULL,
+        0x00000000065699d6ULL,
+        0x0000000008c811fbULL,
+        0xffffffffa862ff0eULL,
+        0xffffffffa6fc7723ULL,
+        0x000000000e9ef9eaULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x000000001190c4cfULL,
+        0x000000007b7fdbbeULL,
+        0xffffffff9204da99ULL,
+        0x000000001190a13eULL,
+        0x0000000000004d93ULL,
+        0x000000006aef52e2ULL,
+        0xffffffff839453c5ULL,
+        0x000000007b7f4a13ULL,                    /*  72  */
+        0x000000006aefa6beULL,
+        0x000000000000b9cfULL,
+        0xffffffffe97bb8e8ULL,
+        0xffffffff9204accaULL,
+        0xffffffff83944067ULL,
+        0xffffffffe97b5f16ULL,
+        0x0000000000005e31ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
new file mode 100644
index 0000000000..f7110b3a0a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CW
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CW";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffb798b438ULL,
+        0xffffffff91d3be47ULL,
+        0x00000000264b0a7fULL,
+        0x0000000070b16a3dULL,
+        0xffffffffc729de05ULL,
+        0x0000000063c5950aULL,
+        0xffffffffd45d2132ULL,
+        0xffffffffb798b438ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x00000000264b0a7fULL,
+        0xffffffff91d3be47ULL,
+        0xffffffffc729de05ULL,
+        0x0000000070b16a3dULL,
+        0xffffffffd45d2132ULL,
+        0x0000000063c5950aULL,
+        0xffffffff91d3be47ULL,                    /*  16  */
+        0x00000000264b0a7fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x00000000264b0a7fULL,                    /*  24  */
+        0xffffffff91d3be47ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0x0000000070b16a3dULL,                    /*  32  */
+        0xffffffffc729de05ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0xffffffffc729de05ULL,                    /*  40  */
+        0x0000000070b16a3dULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0x0000000063c5950aULL,                    /*  48  */
+        0xffffffffd45d2132ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffd45d2132ULL,                    /*  56  */
+        0x0000000063c5950aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffffea0755b2ULL,
+        0x0000000008b188e6ULL,
+        0xffffffffff3cc8d9ULL,
+        0xffffffffea0755b2ULL,
+        0x0000000000000000ULL,
+        0xffffffffe2b6dd54ULL,
+        0x00000000153b9d6bULL,
+        0x0000000008b188e6ULL,                    /*  72  */
+        0xffffffffe2b6dd54ULL,
+        0x0000000000000000ULL,
+        0xfffffffff78d403fULL,
+        0xffffffffff3cc8d9ULL,
+        0x00000000153b9d6bULL,
+        0xfffffffff78d403fULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
new file mode 100644
index 0000000000..e391be803f
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32D
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffdebb20e3ULL,                    /*   0  */
+        0x0000000044660075ULL,
+        0x000000001e20c2aeULL,
+        0xffffffff84fde238ULL,
+        0x00000000281d7ce7ULL,
+        0xffffffffb2c05c71ULL,
+        0xffffffffd660a024ULL,
+        0x000000004cbd80b2ULL,
+        0xffffffff9add2096ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005a46c2dbULL,
+        0xffffffffc09be24dULL,
+        0x000000006c7b7c92ULL,
+        0xfffffffff6a65c04ULL,
+        0xffffffff9206a051ULL,
+        0x0000000008db80c7ULL,
+        0x000000005449dd0fULL,                    /*  16  */
+        0xffffffffce94fd99ULL,
+        0xffffffff94d23f42ULL,
+        0x000000000e0f1fd4ULL,
+        0xffffffffa2ef810bULL,
+        0x000000003832a19dULL,
+        0x000000005c925dc8ULL,
+        0xffffffffc64f7d5eULL,
+        0x00000000102fdd7aULL,                    /*  24  */
+        0xffffffff8af2fdecULL,
+        0xffffffffd0b43f37ULL,
+        0x000000004a691fa1ULL,
+        0xffffffffe689817eULL,
+        0x000000007c54a1e8ULL,
+        0x0000000018f45dbdULL,
+        0xffffffff82297d2bULL,
+        0xffffffffa7157447ULL,                    /*  32  */
+        0x000000003dc854d1ULL,
+        0x00000000678e960aULL,
+        0xfffffffffd53b69cULL,
+        0x0000000051b32843ULL,
+        0xffffffffcb6e08d5ULL,
+        0xffffffffafcef480ULL,
+        0x000000003513d416ULL,
+        0xffffffffe3737432ULL,                    /*  40  */
+        0x0000000079ae54a4ULL,
+        0x0000000023e8967fULL,
+        0xffffffffb935b6e9ULL,
+        0x0000000015d52836ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffeba8f4f5ULL,
+        0x000000007175d463ULL,
+        0x000000007a6adc3eULL,                    /*  48  */
+        0xffffffffe0b7fca8ULL,
+        0xffffffffbaf13e73ULL,
+        0x00000000202c1ee5ULL,
+        0xffffffff8ccc803aULL,
+        0x000000001611a0acULL,
+        0x0000000072b15cf9ULL,
+        0xffffffffe86c7c6fULL,
+        0x000000003e0cdc4bULL,                    /*  56  */
+        0xffffffffa4d1fcddULL,
+        0xfffffffffe973e06ULL,
+        0x00000000644a1e90ULL,
+        0xffffffffc8aa804fULL,
+        0x000000005277a0d9ULL,
+        0x0000000036d75c8cULL,
+        0xffffffffac0a7c1aULL,
+        0xffffffffed857593ULL,                    /*  64  */
+        0xffffffffe0b6f95fULL,
+        0x00000000253b462cULL,
+        0xffffffffe15579b9ULL,
+        0x0000000074897c83ULL,
+        0x0000000079baf04fULL,
+        0xffffffffbc374f3cULL,
+        0x00000000785970a9ULL,
+        0xffffffffa6bae0a9ULL,                    /*  72  */
+        0xffffffffab896c65ULL,
+        0x000000006e04d316ULL,
+        0xffffffffaa6aec83ULL,
+        0x000000005ae171feULL,
+        0x0000000057d2fd32ULL,
+        0xffffffff925f4241ULL,
+        0x0000000056317dd4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
new file mode 100644
index 0000000000..100f02c7dd
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0xffffffffbe2612ffULL,
+        0xffffffffdccda6c0ULL,
+        0x0000000062eb4bc0ULL,
+        0x000000004bbbc8eaULL,
+        0xfffffffff59d25eaULL,
+        0x0000000022259ac0ULL,
+        0xffffffff9c0377c0ULL,
+        0xffffffffbe26ed00ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000062ebb43fULL,
+        0xffffffffdccd593fULL,
+        0xfffffffff59dda15ULL,
+        0x000000004bbb3715ULL,
+        0xffffffff9c03883fULL,
+        0x000000002225653fULL,
+        0xffffffffdccdf395ULL,                    /*  16  */
+        0x0000000062eb1e95ULL,
+        0x000000000000aaaaULL,
+        0xffffffffbe2647aaULL,
+        0xffffffff9776c480ULL,
+        0x0000000029502980ULL,
+        0xfffffffffee896aaULL,
+        0x0000000040ce7baaULL,
+        0x0000000062ebe16aULL,                    /*  24  */
+        0xffffffffdccd0c6aULL,
+        0xffffffffbe26b855ULL,
+        0x0000000000005555ULL,
+        0x000000002950d67fULL,
+        0xffffffff97763b7fULL,
+        0x0000000040ce8455ULL,
+        0xfffffffffee86955ULL,
+        0x000000004bbbfbd9ULL,                    /*  32  */
+        0xfffffffff59d16d9ULL,
+        0xffffffff9776a2e6ULL,
+        0x0000000029504fe6ULL,
+        0x000000000000ccccULL,
+        0xffffffffbe2621ccULL,
+        0x00000000699e9ee6ULL,
+        0xffffffffd7b873e6ULL,
+        0xfffffffff59de926ULL,                    /*  40  */
+        0x000000004bbb0426ULL,
+        0x000000002950b019ULL,
+        0xffffffff97765d19ULL,
+        0xffffffffbe26de33ULL,
+        0x0000000000003333ULL,
+        0xffffffffd7b88c19ULL,
+        0x00000000699e6119ULL,
+        0x000000002225eb07ULL,                    /*  48  */
+        0xffffffff9c030607ULL,
+        0xfffffffffee8b238ULL,
+        0x0000000040ce5f38ULL,
+        0x00000000699edc12ULL,
+        0xffffffffd7b83112ULL,
+        0x0000000000008e38ULL,
+        0xffffffffbe266338ULL,
+        0xffffffff9c03f9f8ULL,                    /*  56  */
+        0x00000000222514f8ULL,
+        0x0000000040cea0c7ULL,
+        0xfffffffffee84dc7ULL,
+        0xffffffffd7b8ceedULL,
+        0x00000000699e23edULL,
+        0xffffffffbe269cc7ULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x0000000026a17af6ULL,
+        0xffffffffaa919152ULL,
+        0xffffffffcb865590ULL,
+        0x0000000026a11f07ULL,
+        0x0000000000004d93ULL,
+        0xffffffff8c30a637ULL,
+        0xffffffffed2762f5ULL,
+        0xffffffffaa9100ffULL,                    /*  72  */
+        0xffffffff8c30526bULL,
+        0x000000000000b9cfULL,
+        0x0000000061177d0dULL,
+        0xffffffffcb8623c3ULL,
+        0xffffffffed277157ULL,
+        0x0000000061179af3ULL,
+        0x0000000000005e31ULL
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
new file mode 100644
index 0000000000..b4f5f4bbee
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffdebb20e3ULL,
+        0x000000004a691fa1ULL,
+        0xffffffff94d23f42ULL,
+        0xffffffff8f0808a0ULL,
+        0x0000000051b32843ULL,
+        0x0000000065069dceULL,
+        0xffffffffbbbdbd2dULL,
+        0xffffffffdebb20e3ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffff94d23f42ULL,
+        0x000000004a691fa1ULL,
+        0x0000000051b32843ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffbbbdbd2dULL,
+        0x0000000065069dceULL,
+        0x000000004a691fa1ULL,                    /*  16  */
+        0xffffffff94d23f42ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffff94d23f42ULL,                    /*  24  */
+        0x000000004a691fa1ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0xffffffff8f0808a0ULL,                    /*  32  */
+        0x0000000051b32843ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000051b32843ULL,                    /*  40  */
+        0xffffffff8f0808a0ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0x0000000065069dceULL,                    /*  48  */
+        0xffffffffbbbdbd2dULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffbbbdbd2dULL,                    /*  56  */
+        0x0000000065069dceULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffff90485967ULL,
+        0x000000006dfb974aULL,
+        0x00000000083e4538ULL,
+        0xffffffff90485967ULL,
+        0x0000000000000000ULL,
+        0xfffffffffdb3ce2dULL,
+        0xffffffff98761c5fULL,
+        0x000000006dfb974aULL,                    /*  72  */
+        0xfffffffffdb3ce2dULL,
+        0x0000000000000000ULL,
+        0x0000000065c5d272ULL,
+        0x00000000083e4538ULL,
+        0xffffffff98761c5fULL,
+        0x0000000065c5d272ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
--=20
2.34.1

