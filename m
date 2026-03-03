Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC4E67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQH-000525-5B; Tue, 03 Mar 2026 01:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQB-0004zY-6f; Tue, 03 Mar 2026 01:39:55 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ9-0005qP-EL; Tue, 03 Mar 2026 01:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgVfvl+VNATATa7jKxaoGZWGhsIhlLSMAYUipiL08QR/SdPJOV90ucGTadbmyfYKnWTuIodVKd6aVD7X3+LLna9uFjcFYwJV2RViwJz0WS61ShLpnBTiLkhrFf21Q96oUaFb7hksny0sUo2wu50sQPc0bDCF8u/JmX5v/kgG5nXI/KI4x4B+vqdzZBO1dBqYDvBv5nuNznNFfeLmQ/Sa1z7hGpncR9cig4+hTzIvRZCBAgSPlhikGi+bxUtqhCRjfUPmGV2D4PIdYkTA225lGLQ0PrYL5syyXpLVSEBFEmSkSMBQL1txbtzzAf+s+KhQWE6IkfnyoJphLNOL0QKvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj7n3mwCZdFYVYI0K/gOh6vWizvzZoOmQBZTL3W+vlQ=;
 b=v5QAgbVH4iCk65Q9K3HvXQyEUofNC8qQEAVkbdzSPnyK1Ihsb1LUfJqBlMxKFk/9iUv941R8AQUTR3EGE8WzqthNdPuHJ5mZObarnmrIsNNFL7ktJZg3NXGdEboGI2zq1MNnNUGNSj4ZEmRsHv96nyQ2VrAWvwMp3568+B+mN47DWzdKy/p9nvrbty+A4Ui5pa0i3hnXSHM++LvnMZrrvhgUV+O83r2KZ1ZsxK70YRfAV889lyNrWEe0QjWGVn8+JgRKUo+YycOrtjD1sdyhChMQfNTHf8dkVhOsJn1iJB2Y6nklO0tELooUrMudSnWEUXjSeARQD3XAsCprYSMq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj7n3mwCZdFYVYI0K/gOh6vWizvzZoOmQBZTL3W+vlQ=;
 b=PiA3gnF8MU8eoiHE1+E2YylVAIPkpXkw9vz8dgtWV68uCZ8/hiKKuP19kkdP00BQ0XzZN7UW6Q+6st67no40qoi1o05t9ZyeftR8ZMkIqrkwNV3LMU2Qa3mTtwxYVjJie30dKrpMYIzcgcEloEcc0Cx358J14Myqwr91bZs96FdM4lOm67xHFtPHhpqU2ZWJwfNApj8Lnh1l448K/LBBDwJ4rzxfgZ6GK7YvQN35++kuGm99p1tWI+udew+RiqnMsABlOI2WRVfkT0nMmirSUvEc3oUhHdfk+gUX/I23XXLTatOaYq06H8T0Tuov2Oe/zxFo5okDQKxbm62V+upmFw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 07/10] tests/functional/arm/test_aspeed_ast2600_sdk_515:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 07/10]
 tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqtiEeGT4aEUx30uq0OApvRIl3A==
Date: Tue, 3 Mar 2026 06:39:42 +0000
Message-ID: <20260303063930.2878300-8-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 3a1dc941-a102-46f1-d3a3-08de78efa6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: qnx3Lh1QPSJlsdkXrnGoxylFwFjDqFDxXPmzKxaELotWd5qJONW/BfJwMZDzHRVVwDuh61W4eYQUnAindDhq0Lr+Mhm2PtpJhz4xYWKXx4yho3sIhd/OIFT+IBd7/i/gW59bSZg+vz9XaCbIkJJRn2QpeD+LCtix811bRlpnjGlRnyYK+rD/3NyzhCy+lpw4zpf6iV30yNVOsKm1ogp2eV2oC0QCTWcthhH91dAkkwy0NVcRZBJbDoNgVA68LAdcKiPrOTzR/70DsobWi8266h4ZkG+h8/HsDsEr/J4SWUJzpJo63+proi2yS88hMysOm+/o0C00fNC5d/ss7FvfknuVrYu/Kq/M4dHIL8kXJ27OzJTatO0LhNoqNiw4ihyEDYvCbCpvgdvacpHVUXozGjTHNL+ngo++s8mWoF188KaLr6XBH2clvnJ0ZtHUZKk9d1WFGv6LSwFT6aTCWdGnOC45BoGR00UYPD6pEM5HSoVuZJvHSUSNqT1U9C3mFnlPLj21CRNQ1yLzaCwQlHeof7+O6Sztj5qw7Q+cA7zTpadSK39QdsmerT1H3S9jpsar0OhGnXswDr7e8Mqz6Gt0KnIAp1a28nDJZqpkiU0Pl1NO55GRzqkVYwNZUF3NAvO9bR0QEA57QDVX98+hAmh5bCdGvnWwo748AU7+JjYHgBSq46loot9cupiH2xltvrSwAxWQo2/bcmEGzDUttubb+BICMx1QgnmQoDYkTdtJuHxiPgDbFHe24whTY5ADLf+L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VYjRJfz2SYWiFUQXFXraLeerdsPUxMgAi36i2MNyY823LW0BszsD5hif6h?=
 =?iso-8859-1?Q?w1tIK7QyT8/XEs94mdx+qzjII3XyH+DBjoEmZhq09xWquYMa25PYYWITND?=
 =?iso-8859-1?Q?7ZjIWI7MHBTgbe0RmiqAv01cttCN9Nw4tBK8RCTVkjysELvRhNBQrc8Msl?=
 =?iso-8859-1?Q?kb1zDkmt6v1DdQu7b2V4YHyRByCzklsYlSaRhjSDLoQoADxrjNkCuyk3eD?=
 =?iso-8859-1?Q?ccIs/qB0+YXz9aKjmGSOsRCENkhC4PgZPjpVTjck/NCccbhVPOk8BMiCpA?=
 =?iso-8859-1?Q?roV2tdHZFqQRWjasMSvV5FWCfsb42hyYqpFeX7NaRyq0Ser0JC+K95jize?=
 =?iso-8859-1?Q?yZMJXTCi0HLniOriPUjkG9VTGGcCL4It2c3SbK2HYUQ9rN/2gpgrL3Gp/p?=
 =?iso-8859-1?Q?e4XYvSkSdFP9d4UjlN6p+tTMfEpEa+QlzDYkCr3lGCcMeFU9qYvrptFzCd?=
 =?iso-8859-1?Q?++aoMbG+jg+8myss/TY3gsVvDhARID9heEzlTT3K6bkW6NMGF53k02VmrD?=
 =?iso-8859-1?Q?RWS5B9TnA/4d2wz7gCMrj3MeMpg25SnHbcTo6ZRUerExk1LKMbQMJHTh5m?=
 =?iso-8859-1?Q?+lPEqtxkX5zHo4p7wnQmFNUG3XW/Evv7eBD5s7iDq1aHBU2w7GIIQFcLP8?=
 =?iso-8859-1?Q?K15dqogAZeuUDq+H16VS7m6wfAyvQBHjchuVGq6ln9lH1sYskdDvYxJJ9d?=
 =?iso-8859-1?Q?i2egqiflzDPPIGoKjRJzE4IkDbEf9JvAMmAmEI5qGxu6lCeUL68/Rf+Zr8?=
 =?iso-8859-1?Q?uE9o+0IDcaVWkJqYrNxwJgf815nyGQ860waIceICA+CVTF1d1oV3Cwmgjw?=
 =?iso-8859-1?Q?OAiKC5QNz1elvkmwTeEi1nNKvl9o+ux8vIzK5j4Cw9eiHf9ZAcP8/wY+A4?=
 =?iso-8859-1?Q?dr+7J6/QpOCgPUtvGFo/AZIzGeFMxYzrEbUVsviEWEomtHArFFzcoDmgtu?=
 =?iso-8859-1?Q?ssrIs46z8O8xYL/dWvBoad+I7fJbEZCuMyhOejeaCfXPfkiBFze6CUXzi1?=
 =?iso-8859-1?Q?gJBG/v6TPW/Q9k2hJ/Vox8/FIONR1kmRQ4Tdjh6WIxPXlH/yighuwbjvsb?=
 =?iso-8859-1?Q?mO7vpk9Pp9CXOTZ2fVWG82xKS+WSvzJ4FO28CxRh41rOt9uhm/BDI4Oq1W?=
 =?iso-8859-1?Q?qb5OaSnbplHtB9M4bl69sw9wM/UQaZI2Y3gTz47zIaQdASizxel+tCXAx1?=
 =?iso-8859-1?Q?u46jqBW/uCDP1srwvWgBM1B8uh3/ZKFI/1fX5OOEtqtoNGFv9DXGb9wOmn?=
 =?iso-8859-1?Q?bf3zCtgzNDbxi/tqzvHv5C12AnKU/CWxcJVj3yBw9fNmScCezjMzz6lJrv?=
 =?iso-8859-1?Q?p/PClSfk6Jv0EJz7P2OBoH3u1Y1ESr6nfUBtnu813zHNnRh5ggnI4Gi2He?=
 =?iso-8859-1?Q?4aIbvM2ChhCia8zzH20AIQMGU35CGm9kzmn5cWOubpiS4T/kMoWFJrhnHZ?=
 =?iso-8859-1?Q?KGPwCG1D2GMbLGxobb17qvDVHdEHRYKWSVtdd5wJeMjzvJPrautlRn0uMO?=
 =?iso-8859-1?Q?y/iq9/Zfl/bCU3sdJDyxvR+Ila2bloh7SuKTHOg5o0Bc/EdTzEEJKaf4j3?=
 =?iso-8859-1?Q?r6mrVr0a4R5318BXHb+ZToWpowLvklBsDuDMkIUSFy6G/1BLdqvjWPGSJn?=
 =?iso-8859-1?Q?eYSe4Mtaw8KOlWQ2G627MP8EmwhAR1EWIA4Rd9m+kUyYZQ/x3Ukmxhdw7U?=
 =?iso-8859-1?Q?L4r0cQm0FXTHCWroSKLAFdnDYt5n/PeF2e9PhoveHPl4lkWVjrhe5fJCEp?=
 =?iso-8859-1?Q?6jVwjklEQ/XOCy+7x0lfM4E2XmxFs+5VW1rRf01NoWYgJf0eOqkzIAafMG?=
 =?iso-8859-1?Q?1/4uq/hfJg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1dc941-a102-46f1-d3a3-08de78efa6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:42.4386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTRCRitS6N/GIQjMzyqUST39c9t4IP+aL7IAP45aUJYFdixzRggB8W8BBwc8ZF8nuPiQX2PD8kBZRZfx3sJXyOB8OlFajsyfnSXKY4KAf8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk_515.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_515.py=0A=
index f48da301d5..ec043e7d61 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_515.py=0A=
@@ -10,17 +10,17 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1100_AST2600_515 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
0/ast2600-default-515-obmc.tar.gz',=0A=
-        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6'=
)=0A=
+    ASSET_SDK_V1101_AST2600_515 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-515-image.tar.gz',=0A=
+        'f3ccf1c08db71cf891637fc73131b80b2c0c0e005c06d5dcae0cf74fc458b43c'=
)=0A=
 =0A=
     def test_arm_ast2600_evb_sdk_515(self):=0A=
         self.set_machine('ast2600-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600_515)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600_515)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default-515", "image-bmc"))=0A=
+            self.scratch_file("ast2600-default-515-image", "image-bmc"))=
=0A=
 =0A=
         self.wait_for_console_pattern('ast2600-default-515 login:')=0A=
 =0A=
-- =0A=
2.43.0=0A=

