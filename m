Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC4EB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEdp-0003Vu-7O; Mon, 02 Mar 2026 20:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdn-0003VJ-Ru
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdm-0002EW-Fd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWp/h576C+rBChI+HOvARVWdpPhNzgwkUBWJt3LRzBg8VrN9JfvGXTVjOQJr9/nTjYpWArc/7ayI1skSwgacGlyPijM5CDxHkjUNGjrvv06xQox1CNFCiXFM4mRd2YWEfZL8yHF/LgsZf6PG240ha/Ri0TUw442EAq4GrpWDhIkLHxprK34Z4IVUIXEfdcD5uO9UzYU6F3AUjhSzaoMdr4YvpfNYZhoRuV7n3c6O77NEeIhGK2NLr+NuGlLFXRCPxcWj9qHr4Nqm+dh79BZEHxxnodsM+ZOBCXnCA7lONz05gARooqGUsfkmb/78wexW2kOWOjwseVlA8IbbQq61mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZXKZjP+hG9XQtVr1vvmgB/3u2Ai6OttUMu4KB68yKk=;
 b=N5Tl9ueyg5vZIjtMKZGmdL8/iNMrDEriuPuM1IDr5uMimwAphiss3voNF8NAi8jQ77WMdlQozMt8TCvC8iV5PF4sxEtX/kwVhXBAgw+JC8LgFoVHHi4ZtbmREz+LRSVuf//7fuwFQwdJ5s83x+cmLYl7ZOo52lVpx5+Pgs33+JW6FbU+8T1oLcD/+ILm0h+YzfhMLJThf8cLnDowMFXA3TGi+3JaN8E1rVkBoxTjo2/mm2TBuGoMSG3JN1wFN+WQmIZ3+Hy55JBqfZWab0wAlrZqj0CLKqMsJzZ/LnJG/nxi8AzQPzndKttdcDSGsPr9VlU0ds1xdSIMkr2nzMbR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZXKZjP+hG9XQtVr1vvmgB/3u2Ai6OttUMu4KB68yKk=;
 b=UtowPmnqILuDR8/hOzOwKNtZ9DVClKtcDMAHXbDBrzBhvxRISPWYBRvbgAFEyDQz3T7P3FbaRBgfJ8lANRkf9fZfdabj/EnXssI+XlG0Z8qjDvxcH0nCAdewNaRwpEaeZ1Ihij9TUAtG+A8CxiTaI3DzjUJ2jZzQnjjWuOIOJF5j4CkBsl4C75zyxQyc/4YLdeiGZLSDzNAWFEkw4IrLFyzchQByzihKUVlt9lmz+gGqmJhQIEWX1gAZy6Q8djTB7zOn06NYEZA2FwRwU19UYWx/4H2UJCCabUj1IO+7x755NWAtiq+mEdvxdbW2HP1RZk9M3tG6o+0cZgmWWLJBtA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:33:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:33:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "jithu.joseph@oss.qualcomm.com"
 <jithu.joseph@oss.qualcomm.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v2 4/4] hw/i3c/mock-i3c-target: Simplify GETMRL byte
 extraction logic
Thread-Topic: [PATCH v2 4/4] hw/i3c/mock-i3c-target: Simplify GETMRL byte
 extraction logic
Thread-Index: AQHcqq29IgsU4JsGwU24jBozQSIIFg==
Date: Tue, 3 Mar 2026 01:33:29 +0000
Message-ID: <20260303013322.1297499-5-jamin_lin@aspeedtech.com>
References: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: 2bd007e9-7eed-464f-bb3a-08de78c4dfec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 20ZKPebvjQHeoPg471wjdTIyy4cOCERPVp9w5DONr5vRHgV/xPcVPJeg1EILq1cphPsxhE+FL+E4Q9RS7clL6p/R6Zr2owUBcNpybqkAjideXBT3hbXfHkgiJVqvO2a1xJGkkeBvqHDR6aob7RboDJmyI/WCwTOf1bKBwBSqXqF10A8YtASUbxU1H2us/6OWmmn5LhowDDbisLQxcsKF367g9K+N1jRJkc5ADv0TVkb0dkCr44qswWnVUrwUd3N/eyPrCN0+6KZvhtufnVdNQCi5JmN6nLRjn+f2CmoU9uxKyl/6VqEciSDzcqHkPHM1JvLFQ8FyvvZES9vAcFDfeGE5zc60NJRwnj2gth8/endALNOcJEJDHILethmYcEMuchmjnP8VeyQrftuJuj13mfOUQ47vpaorzLdwlAJjsQCPHjrz1geDB0bU9JGJ9892ItwsyQnrR0GgrHzTBnhycfv8DslpEm6kGw/WE6VryR5jqxjyIDu285aPwShDRSknny5FUx2C0ixN00O44jTp23Kq3E/gWg4EWyg25WdpDavssx8oeXEmIGucDx+Vxjya6DsbS+DqqCaEWNgAM6K5kp8414w6yelQA5hNgb0CBnFOTWk0MUh2Ilq5IgGX8bB8UHqUpC30YdiLZSJdsUY9l54GP/qQc2lWtMlNo8g9ApeGnLht7PY1lDT8kYgf/LzNhCElywDJp6ajvO4hasFRNFjSF/8ZgGuzA/ehGs8D1s/csjlEND2tO0BknhEdRhJp1CoNX0pX1tGYhPdgbcvqJFnPjup52B+YQYo4iSEeg2o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IhdO3ddmWUoRyiWAKJYEBZs4tnBQMWTxtlJ5hhyOSSEy9JRj2M51YTdt4wH7?=
 =?us-ascii?Q?WFKG2I7nGjCdNQ7bQOxL0VzgUW97EW31mQ37qTTZhhvDoFwpUC93ufICQLWT?=
 =?us-ascii?Q?vcY/v4YlztnfczNtnnCHfNwoSPriL/UFIcucQohHYgQq0/dQEuafQ+3P7taH?=
 =?us-ascii?Q?6D+XadRoK0Ldyj0SO5YOYCNlGvXZX+bTH17ypeoUSCvCwFBFwsCxaCEo/kJZ?=
 =?us-ascii?Q?9wukB1wn5Eww4Qj8HVI/+rf8Oj5gEIJCEE1I761+VNOrNJ97q7eQu2lbYWz+?=
 =?us-ascii?Q?2uYY6onGoXvnMPapNKtideGrr0hRoXdJfdhxAlIYIWeTeUyGTHBvZJsij3uQ?=
 =?us-ascii?Q?mx189BQX+LAlcKjbhGQRE9lDUQ90boa2yUtN5doJ7N4mpIeqt2bkXjUsI30M?=
 =?us-ascii?Q?pUZeX0iMenKXeHt1RlLWwe4waHkSSuoJmsGJIeUa7KAvtf0UeFgQ9SIDiI5j?=
 =?us-ascii?Q?gW5wrPNTAolN26KBFQ4xttNzPBBuplrGpi8x/zJEPNfQLwvtMyXoEn/OFv1h?=
 =?us-ascii?Q?OcZB+gcicD5a58gULJWIYkfpi9X93ICwUrBWDH1M3bk/GCExzIc1FdIc2512?=
 =?us-ascii?Q?5f/2dclCt8THHEdYk6Eho0B3td277xlF01RuUuFm283ZbpCZjushMVDwr4Gk?=
 =?us-ascii?Q?jlemeth7mLaN45lMQGdpLzAZsEj8tJ5m38U5WciH0u//F5eau4aS6LCAn1vt?=
 =?us-ascii?Q?qkL5LptzS1BtYCJmwoK9m2OCuhpbOUiZqmPGMP1of3jKmhq9CvNZGMHpU9rS?=
 =?us-ascii?Q?u8IdqAQdDAV3qMeQPCiqBQy/kDTJt7OvYJodOVMm7b3qWDZCbBOkYFjVQ5q3?=
 =?us-ascii?Q?CQGMFpUS5D1S9cv9C6XsubVIgviS+LYcqfKjGeJCWiwwxLgrZ47NdJQfcfkR?=
 =?us-ascii?Q?f6xQoT5chqrbU8k3E9Q/bdsF+CkwoucuBQwDVpySjWj7A9NS5KeQwCed3J8F?=
 =?us-ascii?Q?QeNesldhJ+x7E0doOs4qoyilJlhN1KBhLAsk+FDqCc0irbilkHZbuGiIIR4O?=
 =?us-ascii?Q?w5L8b6Mt/PO6eYuINNDTC0+FEjTkU4h5jTkgMZE2r0RvowftV86wnkFuLEWx?=
 =?us-ascii?Q?4yQdUXnaF0OuhGYmLd1+Hs0tapR++f7qkx8w2Xd8K0ErLfiMXuOINbh0GBAR?=
 =?us-ascii?Q?GJAsLAmPL9O9dNezX0o6mEMo0Pzxo9/oiHCPrgPYWSvCZlQzB9FaMih7Vv1+?=
 =?us-ascii?Q?unXcv/kpwmKxktlC4TJzFee/YtT1GMx/p9ToS/nkROtgnzZPiV+8C4AfURD3?=
 =?us-ascii?Q?5vDStThIqcyGY0mKQSH0cvuidYOehNiMTvz3yp+91oBv5Ig+JoxRKpJBzXP0?=
 =?us-ascii?Q?PYpTa7zcFwsathHgdLFuEMi74LBOT5gqLYeX+uobyiF83KC8oV/Fbyjk3lMB?=
 =?us-ascii?Q?dD6SWxW1mR2ha992yWFbaejtEXFM1PoRRwTZzmsk71U1KWtRqLiRT/J3A/4Y?=
 =?us-ascii?Q?2GMX0nO3zrlwtn8VXc+kF17aM5Cb6n+yex5Csqsqhe24nm+K5IzjM1qlrtan?=
 =?us-ascii?Q?ucZrc74SNChj08AxZVwPW46v1qgDVOGNgw54YB2SqzYSnpZs2ej7CZ18G8Do?=
 =?us-ascii?Q?QUHH9zCDb9Dc9QWB6zpU2z1qmIf8TFbOm83lC0WzjlVQ1usnXoHfg6x25CbQ?=
 =?us-ascii?Q?R54rytSdVlKX89B+Po8uqMrqbkTzIZJrSx1+bwdGnNf9rVhORFMJNEBuPpZ3?=
 =?us-ascii?Q?ej3yHRKDAC/y6VaOJORWCB0xhe3xtkhc+FNsLQWDvNrt3gyPZCGQj+D84InC?=
 =?us-ascii?Q?y3UvhUir4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd007e9-7eed-464f-bb3a-08de78c4dfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:33:29.8727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8ypOyJxZ7eC/aS1bHF8dYr/Qq1mkQ5Bu5u3+c9aEpdLMIZdY+0xz0XXtG19OzWJPE0bXBdpldBST64bgzTJoFEcf9CHVlDF/TrxbNqnJqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973
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

The GETMRL handling logic extracted MSB/LSB bytes from=0A=
s->cfg.buf_size using a mask-and-shift expression:=0A=
=0A=
  (buf_size & (0xff00 >> (offset * 8))) >>=0A=
  (8 - (offset * 8))=0A=
=0A=
While functionally correct, the expression is difficult to read=0A=
and obscures the intent, which is simply to return a 16-bit value=0A=
in MSB-first order.=0A=
=0A=
Replace the mask/shift formula with explicit MSB/LSB extraction:=0A=
=0A=
  offset =3D=3D 0 -> buf_size >> 8=0A=
  offset =3D=3D 1 -> buf_size & 0xff=0A=
=0A=
This makes the code clearer and easier to review without altering=0A=
behavior or data ordering.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>=0A=
---=0A=
 hw/i3c/mock-i3c-target.c | 9 ++++++---=0A=
 1 file changed, 6 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
index b99709a08b..1ae2cf9e1d 100644=0A=
--- a/hw/i3c/mock-i3c-target.c=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -146,9 +146,12 @@ static int mock_i3c_target_handle_ccc_read(I3CTarget *=
i3c, uint8_t *data,=0A=
             if (s->ccc_byte_offset >=3D 2) {=0A=
                 break;=0A=
             }=0A=
-            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
-                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
-                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D (uint8_t)(s->cfg.buf_size >> =
8);=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D (uint8_t)s->cfg.buf_size;=0A=
+            }=0A=
+=0A=
             s->ccc_byte_offset++;=0A=
             *num_read =3D num_to_read;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

