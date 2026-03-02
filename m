Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842B7D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtvi-0005pe-BR; Sun, 01 Mar 2026 22:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvd-0005p4-Oe
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:41 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvb-00008k-VJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdkNwWgV3zlWDTYT7l8WWBYbC/ejHPldLtNl5tM5piIDK0mXphlaIxyKp6x9RjlhDDDUhf+iQ1GPU5OQbIz6Zu8r2O5dxxjx8tcxkjO/E55CTXulTj0p1VEud9Au6fqXfOZqdndEa1FLBZyPzyTKc4K59llZfE2s7HZGRtbrMSJtYde+WcybdW8SUfAMO13kKupCP50SQINO18Atxw7vTES79HGcRKlckhrP83w+fiDDAk3R72ff22EphZ7+RVJ2uWq8ovTbmz+iv+D7eWYwK4w6+o08rNAJNmoImmtGsLe8z+eXput9uVrRCE7Q1XG9qNEJ89Srel5WKorUhM7HpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpT2YXlK0KnFZUNVVEL2ArRhUhDXHdBC74aSJztU0cE=;
 b=bTIfpwDijRRi46dljn/ZGJGSPw/v0aJqqpMx0PVZHluWGynqcIc2wB7PRYZuuR7vVD950wNZoFpGU6cUgiQ6zQaOJtSiUchzCZCdkcshs3P0zlrqFqYU5AU3+if+Ul8s9hHwWG2YcpLeDHMqjiFIvl35L03xCGFZU7N5AT3R54gI6yox5IFaJZlQYRlosrsx1sZPRLEP8dY2QJpIeNZI2dCWU3Hsk1dfuB3Z/5ZUH9pAoCSsUskUydLUaxcpNts8y8m8q2QjejWMOcUhqYDhpQA1pi04YzfHfRxy8UkToFGBs9X6eFQqJJICt9kBkOEWHl+UJawHzY04krZeqy15hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpT2YXlK0KnFZUNVVEL2ArRhUhDXHdBC74aSJztU0cE=;
 b=ivJgK8QpsuJuMHjy4OuIVsaCLVI5YuNz3bxRsfB288+TR0NUZii8CbxNE+vh91L54Ghh9lz0Gjkrhs0EzNc0Ys+yBm/hLQNrUaQa/izi6o7DKbMX2foP/ilRgXMlth6OjOZabKz9l1QgtnblwQcO+KM6+l1wO8t8mI7OormC72BzAclhcBeAEezoe2JrrIaksrpi/m7U49TACGlS3XnSHDEDeRpftr+4NlTds0u++u/XrZ1tneMF7lKNa3eY5L1hpnApGcRoUctr2urlEjlU9N5aFqCf5j2fpnxR/UcCRjt7uXOfi05/9yMb7b4yO99c69f5Hyz8XS+MeDdOUxPnOw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:26:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:26:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "jithu.joseph@oss.qualcomm.com" <jithu.joseph@oss.qualcomm.com>,
 "clg@kaod.org" <clg@kaod.org>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/4] hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer allocation
 alignment
Thread-Topic: [PATCH v1 1/4] hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer
 allocation alignment
Thread-Index: AQHcqfRcZwVZPRWID025fGkeQr+UQA==
Date: Mon, 2 Mar 2026 03:26:29 +0000
Message-ID: <20260302032626.1974743-2-jamin_lin@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6791:EE_
x-ms-office365-filtering-correlation-id: 85445b39-5d59-496f-675b-08de780b7e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: gR7MS2XI9WR7RgLZzG1lmrDV9qPPI5rDeIlETQAjASoVxmXXKkEwmvcTWvp18/BLVObTPNuWnhBQ9YGSW3ajSiGYBFO2tfabsk+N4bI2WXcHgU4aKQYF+6qmGgh9+lZE5jLdZAbS4Gj0Rnu1cuEFQknvKw90fEQypw+mZI+O1j9109+ZKsEh79M4bp40vy0EblsmOTUPPxepTovRbF+n4J0EeaV3nGyyky5FkitKDGAPSkrP1bNREHcX30aS3w2qzldqG2BEtfExbMIab9NCPz3E7dqB6ryuhdYU7np97KKmUEW9hGsv3OwYdA/AiXXfBGKbxAo0zPLLdyGvoImx/GMcy2Sha0gNf/5+2tv1//2DbFYN4tkOtjArmBFO2n0tsdeVTi337V7wQJb68cENCFWfau3GcXz0ojp8Y/e0Tkort/QdfT6JwDtcbOhd5AUX+P/ckt3doMnRANVsMOubd7wIGWfksPvSlSYXNBt5AroSntXfGTYDcTva9XKwHxzwwK0AqbDPaju2ZMHiiPc8+y0Lop7CoI0a+jDGDgifzZCXCOjSuOtOOBRFuWBmuCLyECRH5IZTWwibYGS8RBG90txsHdPKYKiEbZv+aP3YaaIEAtLPJ7ngrAf24RjXfXWQC6Swex78YOyn+jOtle1WEbe19/k4e2LWls4jJKVm7Et+HBEYbYrKX7hcq//ug93YajZHSCYfbaD/nMbEOLDTL/niWRe/AiyaAjMxYg3xWuYvG9TN74sEzb/mMz9WELIyy+CAYTL84vbS3mvAYSfOuPm1Wadl5TtQ3x5soMDwayo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w5x8LuNEnCbOdLpyx3PiyrSIULvN5VVqZDSM0+0IO223mgKtsTrG+QNdRDKd?=
 =?us-ascii?Q?t33hyMWr64PcKpv8SgI95gMsjobIeuHzYbzYICjAUmr6uDrEwdCnMkHBTrb3?=
 =?us-ascii?Q?RMGLiVe9l5FicSab9+dMcyg9wAGVBOqAghFfBDuGk//7j6EXzyKd0QMWi/d9?=
 =?us-ascii?Q?dBNf5LBRmAexSsmW0wiEPJ+LbAbtKnDesOBcOcb+BzamBku5Mc0KRHzstxtc?=
 =?us-ascii?Q?GCQq/nBoBTyLpjdSYKiIGQ3WUbjphP1TGMjTVbfrgFuYi0ykTsOkeYRnvdsy?=
 =?us-ascii?Q?vvLQfnwP8JToNa7vF9CQZ3ljB3pway1qDLPVNTwgJiHr0tOL/Iid+K2z1WlS?=
 =?us-ascii?Q?666Jy3sjhIwfgta36BCLFm9lpx6UyzFYczXjaAttcvhHDRoVMjZnbfBLv0UV?=
 =?us-ascii?Q?9FghFYWfaKLHMnSYymyfdbWvEqieVG9Y+PEuB7cd4UpLGK2yZ05XSKvV/kuR?=
 =?us-ascii?Q?zSxCu3PqQIiNb5HjSF3pcS6V3RCd1MptG3MUxH/KmOUqNvStAfEI/CXnqzhS?=
 =?us-ascii?Q?t0aeBEkx7HID4g3zLuqg+aT9q1GGda0Va3p1d4OOAy+ePYHLJZjlWpwVkoa8?=
 =?us-ascii?Q?QSwzRj8hGSMeuHb+zFf81gvFDRbFm8Q4kNNXceaVJ2/svcbSGIZ+e+fF1xFn?=
 =?us-ascii?Q?GLLYqDftdplq2NALgYFDPo9uPcZBzaltVWEZXpL+ifi5i5XJ6OBjQGPbok21?=
 =?us-ascii?Q?08t3A+iVFYScbOmsAUgCLeIvcE7p2PzpxuR0b5ev4ICyNxDsU5mF0b2zwFVI?=
 =?us-ascii?Q?lE3I1uYHyeMD9HKpV9RMLM3gI9zsws9JBndSXDiBdZQRAUJ3iOP4Ehay49rU?=
 =?us-ascii?Q?TjsEnlZ8HJ3hZJOdVY8px5fc9utHKj8gaPy88kwS8oc6Vl6Atvrylh2EYxSX?=
 =?us-ascii?Q?C1jXSiR5AU9BKZWffWooKyjN5k3xzZpwylexnfzaezCzfZa5mKsTdEIDwEhy?=
 =?us-ascii?Q?l6GDbktp9ZpMomB2hfodNDF2/2Dof6ZPdc+4EGxMlrKrATdFne+vtWeW/GZ0?=
 =?us-ascii?Q?CBYW0uUrz9KZBFd15ZGaxdpRctccN8z0Ij/ZxxUXxjUMJ347uZA1HbdNSuzY?=
 =?us-ascii?Q?i5BVINab4HSyzJnO5PiK5oS9fsaJ5DV7yfE1YbugVKa9GDLFkqIzxTw/xPJh?=
 =?us-ascii?Q?FqcyceJbnPVADDDYoib+jmZJLDLv51As13dKRBZUzN69U+CraVBpEjXS0g60?=
 =?us-ascii?Q?bykbgsod/vQEaHsQddgslGLm8Lsi46Qmawcj/kayS2KIJrH2GvbvSP616VKs?=
 =?us-ascii?Q?9VQjdyxM7WD+Fb5uD7PGab+A8Fdwi0fQz3wx+mZawND4xC2AY2sHsDnV6vyW?=
 =?us-ascii?Q?kI/sGsoGlfnc9X/V+EtP64Va46oKsBlFe8i+tbJM3H+FmrfyjzetIvDbMqzV?=
 =?us-ascii?Q?Z4zxSrpSCov55m5KcjHvRTgrVrfNsyGRenXYDvO7b9Ev7N7ucA6+pmsJaraR?=
 =?us-ascii?Q?3W3KuSdXMEM3RQG0R+b4ibQr1NzCmwQxk2r2uK0GTCumUfM1U4Fg4lrjHBv0?=
 =?us-ascii?Q?zP5P7A5Kq4BhSCFv/svzTeUWSbYaAMKXG04zNbXwJQqOKn+eCwpZrA4Juu27?=
 =?us-ascii?Q?lse2azgQSU/IQ//lKrtmMmh/qmbaYOLZkH4NgfFU8V4FT0uitc5Sg8Bkeikm?=
 =?us-ascii?Q?OjCruIVrq2GPuTUGGUYp0devtGjF9hNy/pcP89LLdZvGOZK79VL8apOucciV?=
 =?us-ascii?Q?z4V2t1IapFlOqnPIBKYyjgHlBRjueLZpDvInTto8D7GfosRurl2wk/HLfLzJ?=
 =?us-ascii?Q?iWWUuCirMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85445b39-5d59-496f-675b-08de780b7e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:26:29.5924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxptN1SZYYtk7WZRPPWidZWMN3dM4k348KSdW4T9wBDlQCLSupMI3ZKcldEP8cK+KKbgpr55rGcmBfyd0uVZJtdeTcuv1qdmpmp4mJXdVDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791
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

The RX temporary buffer allocation manually aligned the size using:=0A=
=0A=
    num + (4 - (num & 0x03))=0A=
=0A=
Replace this with ROUND_UP(num, 4) for better readability and=0A=
consistency with common QEMU coding style.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index d742458129..3d8b95a14c 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -1282,7 +1282,7 @@ static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, boo=
l is_i2c)=0A=
      * Allocate a temporary buffer to read data from the target.=0A=
      * Zero it and word-align it as well in case we're reading unaligned d=
ata.=0A=
      */=0A=
-    g_autofree uint8_t *data =3D g_new0(uint8_t, num + (4 - (num & 0x03)))=
;=0A=
+    g_autofree uint8_t *data =3D g_new0(uint8_t, ROUND_UP(num, 4));=0A=
     uint32_t *data32 =3D (uint32_t *)data;=0A=
     /*=0A=
      * 32-bits since the I3C API wants a 32-bit number, even though the=0A=
-- =0A=
2.43.0=0A=

