Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E069ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDXvQ-0000hh-9j; Sun, 04 Oct 2026 21:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDXvL-0000hO-RW
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 21:55:28 -0400
Received: from mail-japaneastazon11023107.outbound.protection.outlook.com
 ([52.101.127.107] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDXvK-0000h4-9O
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 21:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJrMYKmxwGfmPyAkkCEskmrH4gPOI3yOR2mqBJzX930ImQC5os54jx5uiIyOpae/1nKJtXg7OC/PV7kKck+yAjdUQzj9umlCsgibWt7ag3yyGox2xV3tF9OGILtZzRgTt6592T9yMRoJJXTp15A+D3Yj2tBRTUC2ViBUQsPZS21EZklxblmiDUrAEJc0cJi2ccHQ6D2aOb9pTTe6iBn+zaIIEgXM3l4rU6q+rSo3eSRch7nhR+FaRFMRGmP2RCUks53ZJ0oa9zYDaJd0wlk3fpIyrd/1CV7q5AxaFvsuCIXDSwxAXrNOcX+LmZ7IBOK8VgK0XlAGaDtK/J6B5Vg2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACF/VpkB5GKDgMA9LZI+b1L7BAg+gaOrkFQqDhzaJxw=;
 b=qo+bKX69xHwF2mIVEX63MB1KlZ5uIvSYvB4/68VgPvHlaZHygJLaBclO6O70vtYYSw0qoI53ZG+8NTHC4iZrKcDais8jnY+NcOMXTWCWDLszYM2hDGusyqHEypSwJzTyBQPCok6HmfSVgbXCzazmRES51ZNN2Or4h0MKWyOjGh2tZfJeyUuYIbGm1QBh57Pwv65pwib54MTO6mB4A36RqYP77C5NstxCTZvGct2AbeY3ZIQfLwB/HKB1CgHisEewd2WaTtNqiHeC2JQq9bGYQpeXEiyKT6Ee6mvMkqJIDCaWT+2WkvyMLk5GGPUJiJbW5ooeIl6xQaqznbLkFQu5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACF/VpkB5GKDgMA9LZI+b1L7BAg+gaOrkFQqDhzaJxw=;
 b=cANe7Uig198fCVU4KBlmAutLnQWxTrx0qzgExD6uk/3UbvpeVWzxus1DdX+ztRP9Yxg6JJhWFZlxpogkQ6qoA3pY+zxefwCxQUwPTFI20rNnpqfbdtDDxYK+4lCBEGzC27+1ma6deuMotW63/WaOPRA9nk567MkzJ83B23LNTxoKqwVQHAB3Q0X6gnQhAEcp3+GOZkJ0HvzpYQLxEUPoNrVeeRlW+sEMwi+dmxOQ5AIEOBo2msDV8j4aNNUEYYQw3ZTjVxGbcYfp5pEbE1KpXBYni0bvkUHroaCZXLNjDYjCXzUHhkuuOVJONOINg1n5nFfPY5mUpafN3D5TJbL2yw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6377.apcprd06.prod.outlook.com (2603:1096:400:41c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 01:50:17 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 01:50:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Peter
 Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Thomas Huth
 <th.huth@posteo.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
Thread-Topic: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
Thread-Index: AQHdVGveNcCzyGnaMEeV50pBxdgpvw==
Date: Mon, 5 Oct 2026 01:50:16 +0000
Message-ID: <20261005015015.3466808-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6377:EE_
x-ms-office365-filtering-correlation-id: 8a4f6914-f5be-43b3-84cb-08df2283015c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: 2BGne9L8tvOlX/D9oOkPkVGpqQ8iY42e4uA8tBj1oQuFUEczl9mLUety4OVefhpTGxjgxKOcw8MRIpfIjrYAAAkeBCbqvKg/dlfBZt9h/rgEu++LJzkv3hwDYeqNbxwvXFe1R+Qf1KxmWOAOqgtzDXr60ngG4Yw6j4AtBCce56an4qJRez9nO6JRpV96vYqYqoJeJyx5EkcX4cSAzqT4QUpgGtlgB8ziOMhlD4De7VFlLMWxFOuKYZJrQdTR/tmPHcFBLvo7iaeDPUdAMDbFn2DD0sIsdTenxpM/T6n2iXbqhCHkrFLq7WjK2lmsSVp4gEoHuIULmRU04jUE2LjYwRIjnHnBx/wsAQoO4Tz54PQgAB15HXZUWKE7Kh+0CyJgIKMuMy30nlYypjTWxNVxPdcWK1NJts/sJACoGcFnJg2D6K/y9O4bmUaMVHscY8sn20zulMz9Sf7/qPGNJM/+IdS4A0cNOqrxGoQG9D49cAozp3/S8UByiBTT77desmDW/ZLG+yMzdHm/A0I+7uLSGVC3N8OxhG0FHCvwEKuCrg9McVnX3Gq5p+wVdzCz/EjWmjekEj1geNrAAj4e+kvcAyLuX7bpFWCdzlRwzYbLJdgGoBnkjVdN/o3p1ubcuo2f/fi8bIDpf8lXqmlhd7Gtghiu+UDLUAgkK+fI0MYJC5YQ/i8Xnbu60bBsDAUCYMJuaG4sVOJr4C/G+nAmT35MQktMTeuXtMooXkplHBXBdcs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?meLBBxrudcSGxl97A9gIFn0IVi5HjKOUZrUQHsfuN+11FHxz/Qv9V87duP?=
 =?iso-8859-1?Q?QRsQCjH2tHCnUojp8VoJozncoS+UPJPXcqtQI2J4c76C8vFmXBIO5Om0uE?=
 =?iso-8859-1?Q?0JVZ+GHq/+zNWcJJUskQduA+tAdOFpPxN9TcV8b0y6qvfl1FzzH7PovnG3?=
 =?iso-8859-1?Q?m9jA2Hlfj/SpiJ0dPjtViZLBiBHp3NN7Jlg7KJIxfbC/SMjLIUnGlKP074?=
 =?iso-8859-1?Q?5Cl8XHLQjZNA1uF+x+H2KhiBAdubcpPp9j/njQwaxhlkdb8bwk0X8oT8yl?=
 =?iso-8859-1?Q?9Dbjw0rLwszwFLA43fA/IYVDfHwU1s+jXrT3WvMTDDQb/ZsWepzoNJLNvW?=
 =?iso-8859-1?Q?3s7Rv3khrwiIhucZjFsX+ynqoV9EJvs5PGqFSX2SPYHPYb3OpfJCZL5zSJ?=
 =?iso-8859-1?Q?ZfXj99k7pIbEYolF9n1R59FXxT0KzWfUxd70+scFjmpoP+3rJDxf6Ic3m5?=
 =?iso-8859-1?Q?zghjr38IST+8XbL2kRMbuuupaFXbZcTeY/rPjfNRedE87w/iMmmnI9WcBI?=
 =?iso-8859-1?Q?okE/0berV1FIIPQvJT1p+1TrorGGnrN+C8wPHKGFe+wTVBHHAyQmt340et?=
 =?iso-8859-1?Q?xyhJ9lMMKu7zJaH/7RdC9JlFWaciteu1oJ9qNkF82NfjXH16i8JkLWVZ02?=
 =?iso-8859-1?Q?g2fnHZlR1P3/kQqpcew5OBmLLg22K1UbQ0JuRVWdyIWYkfM167ZwfADkmJ?=
 =?iso-8859-1?Q?DpGu5R7XetDmGGFbzU7zciC5jlbxHqVr9+Gl8gyC82PFZkVdsUCrrj2PFv?=
 =?iso-8859-1?Q?LxVzMBYUdcRkRjPuUqXJv4fZqjSb/L4SRyXI6o4VSluJ/uhF0oOZjB0617?=
 =?iso-8859-1?Q?drD9Yll3/CFNxAaEsaMJ5UgzPM1ZDD1IcUtkAOoR/SxUvUZZAfWVbciJ6g?=
 =?iso-8859-1?Q?WoPQkIDg0EvB4GMBshcghN5ntFkxmyQuFMXGyu8vCjQZchlzmecQ0f1yA9?=
 =?iso-8859-1?Q?3gQWZSFqC6WYOA+AbO3f3MF1M4zmrntE2YG0+Oxsxhz7zFsOvsZvDR5xxR?=
 =?iso-8859-1?Q?ZbhETDgZ7YQ+o54jfwfUErEodJl1MRW5KWbDjsCMSl8dykyurPaoko7301?=
 =?iso-8859-1?Q?uPdclJ7VX2ZQnc39Cv1NzP0Jl1OoC/o7c4IDQxDDZbR8/yFbreeN8Fd1ha?=
 =?iso-8859-1?Q?tAI862Pm2c2+zitgHxfyQBkMbsCrSqqMDKK5fIEBN2gHmPlTOUVXDKhpIK?=
 =?iso-8859-1?Q?FIrnpZdtZTLwplHkO2OOf/Liw3nynog2Cj3TiQct/rJkJ1G/Gora+htUP1?=
 =?iso-8859-1?Q?2IrsUfjoqPUsBd8oaNHdSS2OjmGSJdd/nMwUoMbRM273im8rKTMlvocbyy?=
 =?iso-8859-1?Q?rh4qaqY5sKc2dr2RDLZXkAq+ZMFISq5WyP7qPrYkcWJ/YYgcecxa/5smXW?=
 =?iso-8859-1?Q?+NwWRrM6MRC7pHyXBEsHSLiEBBmvjmieWJ92qAZy7CKLBKdPvf3L79RkBv?=
 =?iso-8859-1?Q?CEhCY+Yl/AFYI6v2UxPgqk+MZ5SA2TbWQwD4hQLbYIbpJedmu8kVgIbO0R?=
 =?iso-8859-1?Q?fsXwvHFLRB/8FOBePgYmvUfk1Px46OHMbdXs0hhwSX5WMKi3l+DuPTUVG0?=
 =?iso-8859-1?Q?2+nwZVVQZiGDJXuanc8lb4I3WW7QYTj/sMvh5XviUNMUk+WkYafw0YIFgI?=
 =?iso-8859-1?Q?5xgl6dl4TmpW5ZOrpwS2gQMQKUAmWdFtJiMppvBOYA1DpHdK2iYX6w4WIy?=
 =?iso-8859-1?Q?CerJUyKCWNdwmOM8i3YcMYWKEWrKBXCKMEbmI6K1rAm9QC9JDSDq762AUe?=
 =?iso-8859-1?Q?Tvi5lo3cmyfg6UV2ktS28xh4U2ral9M4fNvVag+rtfhXxya2cwaDefmiZm?=
 =?iso-8859-1?Q?aGvujH4ZUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4f6914-f5be-43b3-84cb-08df2283015c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 01:50:16.8516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20SRBTh9ef4fLeYEBGWd9PJ4olR0dO/OF5Gu+1M1nl5iOeBVIa1xexIqi5vAXwe4HOAG7z8yw4K+cez+J8rVAJaR+sOrqGXfC7qxam9T0Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6377
Received-SPF: pass client-ip=52.101.127.107;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

Update the ASPEED BMCs reviewer list to reflect the current active=0A=
reviewers.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 MAINTAINERS | 4 ----=0A=
 1 file changed, 4 deletions(-)=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 1312bbd1bd..93a23526d7 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -1265,12 +1265,8 @@ F: tests/functional/arm/test_emcraft_sf2.py=0A=
 ASPEED BMCs=0A=
 M: C=E9dric Le Goater <clg@kaod.org>=0A=
 M: Peter Maydell <peter.maydell@linaro.org>=0A=
-R: Steven Lee <steven_lee@aspeedtech.com>=0A=
-R: Troy Lee <leetroy@gmail.com>=0A=
 R: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
 R: Kane Chen <kane_chen@aspeedtech.com>=0A=
-R: Andrew Jeffery <andrew@codeconstruct.com.au>=0A=
-R: Joel Stanley <joel@jms.id.au>=0A=
 L: qemu-arm@nongnu.org=0A=
 S: Maintained=0A=
 F: hw/*/*aspeed*=0A=
-- =0A=
2.43.0=0A=

