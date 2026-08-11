Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE24C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct0-0003fX-QL; Mon, 10 Aug 2026 23:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcsz-0003f8-0u; Mon, 10 Aug 2026 23:10:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcsw-0004L5-Pa; Mon, 10 Aug 2026 23:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfvUKyF5R+ubt73LeOAbAcCUXcW6rWfbAI+to4T2p9V42mwCkz74IUSmw0d17FBG1RPRhT/BIjHx4iv5f/FNSjG+6/eL5VMwI2cZC6r29Rb/slcqvLAZmHoQUbjFQ/oxOML9REyUCNFZnaDuP3/9anfJGcRjzU2vRXoDcfUmH8eeJyXc7uWBZdW2DmAmI2GD/JAgaxhxkYE5T+9Gt9MDslPnZ0kuBvMht3XRXJnUXnzcNrQ85/tv6ElIaL6wo3HTeG1ET4cB7b3W3+QqDmYz9kWofzer+2wNIurdaAR5W/SX5TOOZkZHEhHIvjkJw4ytDRSrPaz9agOotcCIzI/Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L/zjGAo/WIzcBvUvBYHIKrECqGmjOX9mXi36Hkhfac=;
 b=JFylYqB0/davlJ3ZKx/dGxG05w/jhK9jEAnwht4jiyyhIgVcIyNy/iVoTm8GHMn/Pl65jnv1/Sn03z9uE3HZJy46ywjySJHGjDVjkMFjsGaoprM+g9b0xoTMzrsE3YXPDtQpziWjDCq62XEmv9vR8Hm/vubbQU4oyKT5kQV+g7y1iq8JFxcWzKvDzxAkgWW+vZVpWL3YVwhKFaXJVmYjcY9teZKOk9lOdBvO5Uo98D+AoS897GFBXT/alWO/L0mEmme0+Brk4KSj8Yg68qGrH+DCL1TDPJBzMUU7lVUjHTexzAUTAV+ycnWkKPgVNqq4KQqQtV92vKBIm7U8dlkhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L/zjGAo/WIzcBvUvBYHIKrECqGmjOX9mXi36Hkhfac=;
 b=PhhE8rVX2rQ0CvvGUDYTnyAE8wX1kBnfYXzWB0F+H0rQeYx5bzQFQFtxIZTKnufOdfId+PnqfBNRujABAW5jUIOszefZxLNU5KSgghhM5rRZWql1OsnILS/H2kllTFBWINQCt3k05wgWBQ6X/tZg46ucRVl8g9hMC7Oz8mzcKiA8njfuoLhDn3NAe7RqMzeu9O1JVy2G224sT29C4IAiHxs9A4/gFab6zQb2Nn7KPQB5mH1GWgqedr2peMuQW9mPbK1rfgpYxRkmGMbjSPJ4ljUcYU7YB+YpVlGsEUivuOUedSr7uzAptC3xDTAE+xldR4RQwtWzv1ad7K5rPhzKOg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:28 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:28 +0000
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
Subject: [PATCH v3 01/16] hw/misc/aspeed_hace: Support the crypto command in
 direct access mode
Thread-Topic: [PATCH v3 01/16] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdKT71Ehzc788rF0OjnDE9LqcKNw==
Date: Tue, 11 Aug 2026 03:10:28 +0000
Message-ID: <20260811031025.2784489-2-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 866a3c0b-39d4-4aad-93e5-08def7561860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|3023799007|38070700021|10067099003|921020|6133799003;
x-microsoft-antispam-message-info: XGQZRA3cxZpbU1rbOqJoywFHJD3QUJkTZR0/L3p5v7OXzhIzgPSge5RUQ4CGyYCxzJDqPJ4ZYqqR1BBVFEYMWSND4ViIVW2g9EjqYMnysw3JrOwReCddYvtIkz/13Yy3bpWmo6EpxLlmYVh4O5Bj/RRZ1KaBlg1Gi+o2Jow/FCKiKdQU2giS73nN5ydgQLyC5+q/qUGJOSemIuJENnTggqcWY9+ezDXxUQhnyYvlbb+Q7yanfzRoi4GROHtYCAMPT8PsbNB/k31WgNi8qr2o+aETHB3T1bb8oUgRAFmaxsGiJ1maMxICN6Fm4f6jIMAk221JGEGkkyUjuIdRLKsowYCzou2w2A2SlvarErjjkrIzbUI2AXEpjLwqNxP7uEXKRDn7iTJukPIqa4ApPB+ObtuWXXZcvXr8HE1Sdhmv7krBSY5sfCJGjRNAVjwJXXbFbGr37uWlApgpjbSeOcwKYIkKEdhMLbineRntecjxcvu7Nrj8OPR6of8KBZ187YYmXHCZrAL62yov+pe9lectN5y3ww3mQrmVrj9C+GU8DxGuc2tS3s++PPqUKFK8yRh8LAHXhdGD/3AT7AGL8ADBMyBAFmoTDuLWhCfr1+Hrwfw9UdQHsujoWWzyVhpheDCrDHWrwu3ORJ8JYe2Dag7lATb034z5q3w/b/12GSojFekUMrPm7a/uY0d3Uuj+3N8SaaDy3d3yhptBLMmmVMQM75cVzrIlRB50HEkzPT+sjV8yHMqmrMJJ2IiGUBHZB5La
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(3023799007)(38070700021)(10067099003)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8INyAABFO/5WtZDexkGRFKQJDSx9gLHfmczc+xIZSQtOyJZmJgcl5E6JsA?=
 =?iso-8859-1?Q?mNbcp8AWfdyVFLXpyGBnJU1lul9QqHC/rUCHl+4yf4J7bRNOEAwUCGaCZA?=
 =?iso-8859-1?Q?260Bum6hpf2naCnDIHzkxT4bsiG2RAkAYdbwcnWyBw55VEScAKeJJGL9eu?=
 =?iso-8859-1?Q?GfoErRKWsO2/KiNPVqqs4lPgtYgDFVfa8W/H6GW/kkMD0bzUvSTUhLsc7H?=
 =?iso-8859-1?Q?kaZcQLg2F1nWiabTO38LXFZ5n0Jzunv9bE2b+nNRxrvCSGrsy5qT8wA+LM?=
 =?iso-8859-1?Q?q3Kn7u+yoNEF6pD/UNLUODGCa+ziCzsT4Ne2CZb8XLdyRl7VKGRRmZin5E?=
 =?iso-8859-1?Q?SJdOtc+TCsKBzytegtEa5hiXTuCScvpNpBb+kay2FHs1qz/bdC23rk85mn?=
 =?iso-8859-1?Q?ApOze3pxBgWut3CF6oI5Azp/Ovg4JdSA7CMTc0DNkFvLQTJApWjchXydSH?=
 =?iso-8859-1?Q?1kXCE5vOvoOIfUPTSdab+GbhtU8iWgIHuQJqrphlAiHbzojZMmjgmy6e3v?=
 =?iso-8859-1?Q?iAs4lOUWq7WS3XVF+wzideGaOlqbUpbBFQqFB+GWKBCDSNFzRVHg8hVUel?=
 =?iso-8859-1?Q?zgEl5azJv6kK1GEgKfsvF4hQipRkw6fDfUl1l0eKdeuJJJJLPuG7uF+thj?=
 =?iso-8859-1?Q?u4TECL6XMxEkWlUeon9r0SHMZiLvtCCoVk2iORQMSqb7QzqoLRqQe4Ulms?=
 =?iso-8859-1?Q?hF+P2IphtJC/ca49SYEtIn4kIcAM8ti81G0RxFHzdiEd4Oyoa5YQz6sUMX?=
 =?iso-8859-1?Q?La7NC2KpiDlA9oE+hMPzqVj4jK26J9Ujo/g/GGqDhb+SChbcJpAWr0csLD?=
 =?iso-8859-1?Q?I+hC3nx7TdYfgXFX9L/dIQ1o/BEZTyRRoVthI2L4cfD5hcbiBndA/eZgEQ?=
 =?iso-8859-1?Q?vzOrfQL++VGDbbKXZ5Uhbnd3qJ7rTJILPXSqFgPQIHYwQ7sGowkwvdv6oh?=
 =?iso-8859-1?Q?a/eOZv0+1tuU6SgKK4RJ2WABVaFe51SlfyNIAUwuXY5AW85mbXxIaZyaFx?=
 =?iso-8859-1?Q?YHZboMd6vw6xTndDmjqqe0IXz9FoSqEjbW2w1MCHrACpV4ot7WxfEb2Ijz?=
 =?iso-8859-1?Q?TbdyV70XDgxNvQieiYRCrY5mt2i04b5ecwOo/d0/aW3uFU9K+pi0y/Gk9a?=
 =?iso-8859-1?Q?RHnbwmM7xlwjL8TlpxvWjxrPrPZv/x+x4C0wzzTVmJLlMHawvE8jiqy4Xw?=
 =?iso-8859-1?Q?2z5JDFDmJsrMJWBIeTMXJevblPB2uOj9WNagooCVqJDsQNOf5qrFbefvJ+?=
 =?iso-8859-1?Q?pYlKStqPQEUeRf6XEK3OsseTFFb4JCdUBjTz6sIi4/gP16wddqhFLs0qNK?=
 =?iso-8859-1?Q?nOpe8+uXr6phLZzNeFOf5eEFV4h6Zy1QlKz5iufaswbGe7JLSmfZfi0lNP?=
 =?iso-8859-1?Q?H79h5qjg3zuepgQO+pBSbDp8yGfhMb7J9dKamxnIsH/kKcb0+dEcKxzua/?=
 =?iso-8859-1?Q?3fqrBi766qHR/BD6ybTIWAFvOwk+rfo/jJzucywnzKcfpexaDga/mOIqqP?=
 =?iso-8859-1?Q?jFXM3UMQFn2iT1JKYr+uGXxB3tauv0RZAH/5wt/gL5NoIInfV6wAvGoxz9?=
 =?iso-8859-1?Q?6xiFlXGIac6oOMFp6iIfEMS2k34LAZ71Qt/zzvQ10asTs7Oily9INI2Xsw?=
 =?iso-8859-1?Q?xxIuBT5tFsmQTBPhusbaVxWsBK0fdXOLnCJfAi3Tg/1eiTlmTf3I4pvE1/?=
 =?iso-8859-1?Q?rBFgc+gzYWX3wZDnVLO1qTMKLQbRgNMCM9fEdQYFtLOpKc+a89qG83SwqO?=
 =?iso-8859-1?Q?kCIc2NBIAkTGfVcIRVKUY3sIFJsZbRgWazk/Dc76GKL244Rh0/G+sfOfr2?=
 =?iso-8859-1?Q?xCI1q350vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W/mnTJMc5xPr34MKgv7ZJJ3yDFEytBowuIZPjHnkxKBcW2/8qYvz1YqsFSxNS3Al+iXogcVHLcnBWaEvmIJDrc9smdPBVCmH9P4r52M6gE9lVFOjerBw8lEtg9VTKeg9dXVMmHPI8Wir8UqHdI9tVqX7XHxPUJ5mxW5MjSEkimzYN8g3xit+exDODG2OKhsqFs/Auy8M75QfX4nRpK0ZUg62C0SYzUHwodZTxw21fkZ/l9HDXHyMkBH674ZZ5GJTyvR/JP7Wb9OsisGX5WGZDrnmWaouOUKKhTZst9iWIG0U2AT+xu4wZJOhFAuSSfD6SOEOJ3jfaEQ5jGg19wvYEQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866a3c0b-39d4-4aad-93e5-08def7561860
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:28.1402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4zmNuyy/qKFKV0ncO/S5TMGw6WRNQIS9j3LFdA6Cy7ArwhDzQwdGsdxLHlfwRw4QEBS/YTeQZT9l7N/1gcszZOib/zSrNcrTFKNZHDI9sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

The crypt command register was previously stubbed out. Implement it for=0A=
the direct access mode, where HACE00/HACE04 point directly at contiguous=0A=
source and destination buffers. AES-128/192/256, DES and 3DES are=0A=
supported in ECB and CBC modes via the qcrypto cipher API; the IV and=0A=
key are read from the context buffer (HACE08) and, for CBC, the=0A=
resulting chaining IV is written back to the context.=0A=
=0A=
The completion interrupt is now raised for every HACE variant as the=0A=
hardware does, which fixes the crypt command hang on the AST2500, AST2600=
=0A=
and AST1030. The AST2700 crypto engine still needs 64-bit DMA and=0A=
AES-GCM, which are added later, so it keeps its temporary interrupt-only=0A=
workaround until then.=0A=
=0A=
For debugging, the context, source and destination buffers are dumped=0A=
through the existing aspeed_hace_hexdump trace event (disabled by=0A=
default). CTR mode, scatter-gather mode and AES-GCM are added separately.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 283 +++++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 268 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index c61efe50c4..0f35d74137 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -18,11 +18,43 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "crypto/hash.h"=0A=
+#include "crypto/cipher.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "trace.h"=0A=
 =0A=
-#define R_CRYPT_CMD     (0x10 / 4)=0A=
+/* Crypto engine registers */=0A=
+#define R_CRYPT_SRC         (0x00 / 4)=0A=
+#define R_CRYPT_DEST        (0x04 / 4)=0A=
+#define R_CRYPT_CONTEXT     (0x08 / 4)=0A=
+#define R_CRYPT_DATA_LEN    (0x0c / 4)=0A=
+/* HACE0C[27:0] holds the crypto data length */=0A=
+#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
+#define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* Crypto engine command register (HACE10) bits */=0A=
+#define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
+#define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
+#define  CRYPT_CMD_DES_SELECT       BIT(16)=0A=
+#define  CRYPT_CMD_TRIPLE_DES       BIT(17)=0A=
+#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)=0A=
+/* Operation mode HACE10[6:4] */=0A=
+#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
+#define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
+#define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+/* AES key length HACE10[3:2] */=0A=
+#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
+#define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
+#define  CRYPT_CMD_AES192           (0x1 << 2)=0A=
+#define  CRYPT_CMD_AES128           (0x0 << 2)=0A=
+=0A=
+/*=0A=
+ * Crypto context buffer layout (HACE08). The IV is at the start of the bu=
ffer=0A=
+ * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0x1=
0.=0A=
+ */=0A=
+#define CRYPT_CTX_IV_OFFSET         0x00=0A=
+#define CRYPT_CTX_DES_IV_OFFSET     0x08=0A=
+#define CRYPT_CTX_KEY_OFFSET        0x10=0A=
+#define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -65,7 +97,6 @@=0A=
 /* Other cmd bits */=0A=
 #define  HASH_IRQ_EN                    BIT(9)=0A=
 #define  HASH_SG_EN                     BIT(18)=0A=
-#define  CRYPT_IRQ_EN                   BIT(12)=0A=
 /* Scatter-gather data list */=0A=
 #define SG_LIST_LEN_SIZE                4=0A=
 #define SG_LIST_LEN_MASK                0x0FFFFFFF=0A=
@@ -501,6 +532,216 @@ static void do_hash_operation(AspeedHACEState *s, int=
 algo, bool sg_mode,=0A=
     }=0A=
 }=0A=
 =0A=
+static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t *ke=
ylen)=0A=
+{=0A=
+    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {=0A=
+    case CRYPT_CMD_AES128:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;=0A=
+        *keylen =3D 16;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES192:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;=0A=
+        *keylen =3D 24;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES256:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;=0A=
+        *keylen =3D 32;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Decode the crypto command register into a libqcrypto algorithm/mode pai=
r=0A=
+ * and the block/IV geometry. Returns false for unsupported selections.=0A=
+ */=0A=
+static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,=0A=
+                             QCryptoCipherMode *mode, size_t *keylen,=0A=
+                             size_t *blocklen, size_t *iv_offset)=0A=
+{=0A=
+    if (cmd & CRYPT_CMD_DES_SELECT) {=0A=
+        *blocklen =3D 8;=0A=
+        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;=0A=
+        if (cmd & CRYPT_CMD_TRIPLE_DES) {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;=0A=
+            *keylen =3D 24;=0A=
+        } else {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_DES;=0A=
+            *keylen =3D 8;=0A=
+        }=0A=
+    } else {=0A=
+        *blocklen =3D 16;=0A=
+        *iv_offset =3D CRYPT_CTX_IV_OFFSET;=0A=
+        if (!crypt_aes_alg(cmd, alg, keylen)) {=0A=
+            return false;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {=0A=
+    case CRYPT_CMD_ECB:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_ECB;=0A=
+        break;=0A=
+    case CRYPT_CMD_CBC:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Direct access mode: the source/destination register (HACE00/HACE04) poi=
nts=0A=
+ * at a single contiguous buffer in DRAM. Copy @len bytes between it and t=
he=0A=
+ * bounce buffer @buf; when @to_dram is true @buf is written out, otherwis=
e it=0A=
+ * is read in. Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,=0A=
+                                 uint8_t *buf, uint32_t len, bool to_dram)=
=0A=
+{=0A=
+    return !address_space_rw(&s->dram_as, addr, MEMTXATTRS_UNSPECIFIED,=0A=
+                             buf, len, to_dram);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
+ * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
+ * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
+ * written back to the context buffer so the driver can continue the chain=
.=0A=
+ */=0A=
+static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
+{=0A=
+    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
+    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
+    g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
+    g_autofree uint8_t *src_buf =3D NULL;=0A=
+    g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t ctx[CRYPT_CTX_SIZE];=0A=
+    Error *local_err =3D NULL;=0A=
+    QCryptoCipherMode mode;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    const uint8_t *next_iv;=0A=
+    uint64_t ctx_addr;=0A=
+    uint64_t src_addr;=0A=
+    uint64_t dst_addr;=0A=
+    size_t iv_offset;=0A=
+    size_t blocklen;=0A=
+    size_t keylen;=0A=
+=0A=
+    if (len =3D=3D 0) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen, &iv_offset=
)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: Unsupported crypt command 0x%x\n", __func__, cm=
d);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!qcrypto_cipher_supports(alg, mode)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: cipher mode not supported by the crypto backend=
\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* Fetch the IV and key from the context buffer in DRAM. */=0A=
+    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           ctx, sizeof(ctx))) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read context, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                      __func__, ctx_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("context", (char *)ctx, sizeof(ctx));=0A=
+    }=0A=
+=0A=
+    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET, k=
eylen,=0A=
+                                &local_err);=0A=
+    if (cipher =3D=3D NULL) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new failed: %s\=
n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+                             &local_err) < 0) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    src_buf =3D g_malloc0(len);=0A=
+    dst_buf =3D g_malloc0(len);=0A=
+=0A=
+    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
+                      __func__, src_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("src", (char *)src_buf, len);=0A=
+    }=0A=
+=0A=
+    if (encrypt) {=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    } else {=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
+                      __func__, dst_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("dst", (char *)dst_buf, len);=0A=
+    }=0A=
+=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {=0A=
+        /*=0A=
+         * CBC chains on the last ciphertext block: the final block of the=
=0A=
+         * output when encrypting, or of the input when decrypting. Write =
it=0A=
+         * back as the IV for the next request.=0A=
+         */=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int s=
ize)=0A=
 {=0A=
     AspeedHACEState *s =3D ASPEED_HACE(opaque);=0A=
@@ -531,16 +772,22 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
                 qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            if (data & CRYPT_IRQ) {=0A=
-                data &=3D ~CRYPT_IRQ;=0A=
+        if (data & CRYPT_IRQ) {=0A=
+            data &=3D ~CRYPT_IRQ;=0A=
 =0A=
-                if (s->regs[addr] & CRYPT_IRQ) {=0A=
-                    qemu_irq_lower(s->irq);=0A=
-                }=0A=
+            if (s->regs[addr] & CRYPT_IRQ) {=0A=
+                qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
         break;=0A=
+    case R_CRYPT_SRC:=0A=
+    case R_CRYPT_DEST:=0A=
+    case R_CRYPT_CONTEXT:=0A=
+        data &=3D ahc->src_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DATA_LEN:=0A=
+        data &=3D CRYPT_DATA_LEN_MASK;=0A=
+        break;=0A=
     case R_HASH_SRC:=0A=
         data &=3D ahc->src_mask;=0A=
         break;=0A=
@@ -589,13 +836,19 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",=
=0A=
-                       __func__);=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
-            if (data & CRYPT_IRQ_EN) {=0A=
-                qemu_irq_raise(s->irq);=0A=
-            }=0A=
+        /*=0A=
+         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
+         * added later; until then it keeps the temporary workaround of on=
ly=0A=
+         * raising the completion interrupt without running the command.=
=0A=
+         */=0A=
+        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
+            do_crypt_operation(s, data);=0A=
+        }=0A=
+=0A=
+        /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
+        s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
+        if (data & CRYPT_CMD_ISR_EN) {=0A=
+            qemu_irq_raise(s->irq);=0A=
         }=0A=
         break;=0A=
     case R_HASH_SRC_HI:=0A=
-- =0A=
2.43.0=0A=

