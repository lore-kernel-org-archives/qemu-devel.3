Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FA606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Lgu3YcDi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVE-00041N-Uv; Tue, 24 Nov 2026 00:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjV9-0003wo-TQ; Tue, 24 Nov 2026 00:55:37 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjV8-00031Y-2p; Tue, 24 Nov 2026 00:55:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjK6a6SUf6XVxDOi6yeQOHrn0jfDSO9rNo8eqEMWGiRwO0oTFuumEqazwmHR3XxVmhFuoLldq/DVNboczTd4U0xSPAua9ZwsZLFyv+LOZXIX2JLitw7mUVc7BNLSbgtIpAL0KbvGfLFNFd3DVhr6oqDQzvx3ttiPbi5TQGNUwJjjLrN1cMsA3wkxDJEtn4B4D09CS+ngGisBAjMYlPoeaKrMJVpWl2AH9bLaeyJIJ5PEo8N5kwneIpmzNmvdfkUfJlY5jRCEuJzPLYIDBZVE3EMAsd5imaMLR3+d6N/8fHKDwx5c+IqoPmXZIyPnYy3bbPg8bKZk9PzhEtKagQq5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCfyihpI2GKlOrBTZSKRmSwx+qZCB1Bmew/g4mnNa6s=;
 b=DCaHjCEM72FBmQOsXrjEbGdumOLJ4fgKoa7o6WwSV9BEC0CfRTosRmmcIFdWw1UKQpGGgbSIppZoalgeO6U3gVSbRy34snM4+PGzPtoAZzUHpHiaICWNVxg5Tu9LWK31P28C879f8nFpX4OhAR613f5DhX4i2eb+wBgs5NMPD0dz1FDU3PaaDpoUy7y1TV81k+bqqCFV9m6KLA4TDxhqK6LPf1KZnvlZQ8PUNcnuN8sEXOPkxlghMPrrBdJKj5JhRUYVMOK9PUsos+t3FGoZqOrTYQrFWzrCZFTwMgMROxjkZ5A6AVnh81x92IUPvZ2JVLMtJtMylhOYTzflyHgzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCfyihpI2GKlOrBTZSKRmSwx+qZCB1Bmew/g4mnNa6s=;
 b=Lgu3YcDiYnlDA/QbPdo1y8Inmiyc6/1U3x+FBtUKD2LAtMcfrzTpuEJU2tMl5r+FWJ5mqysRAsOqGcNhA9NYn0UKekZ+IR/PFU+6PtbMzMVVuwjaOXqEv5KFkWDHUeFGgRR9/kQwucuZtM/amLzUFx5rDGdt1rc5gs6/9CNg5fXR0jgiTbgKgzGZu3cjLHxjR8mpDVTlo95/des4ff2GV3AxRggECC70RYl21gJzLjAMO6YJXzbCeJaBXcTYQZj8IfDVEJV+JT6FVO1Ke3wiF5UM8J+KD1I2pOoTzFx2J0N3ZdEeFpw+cSxlFjYJa30DrYPPCRKGizRVW36LM1aXZg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYSPR06MB6526.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:52:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:52:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 11/11] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Thread-Topic: [PATCH v7 11/11] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Thread-Index: AQHde9fuV+9CTL27jUGQ5b92z1TMpw==
Date: Tue, 24 Nov 2026 05:52:03 +0000
Message-ID: <20261124055150.1328856-12-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYSPR06MB6526:EE_
x-ms-publictraffictype: Email
client-request-id: bba6390c-8662-4d38-8ec2-5aac718d2866
request-id: 216143eb-55a1-45f8-58ab-08df49ef124b
x-ms-office365-filtering-correlation-id: 216143eb-55a1-45f8-58ab-08df49ef124b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|261026121527099003|56012099006|261021121427099003|261022115727099003|261026140227099003|261021123027099003|261028144727099003|261022105027099003|261102123227099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: VEasf1IF0pFeyjgFH0jTa0IaTGnaacmugZaiVTv+whGYILMudfjxFuRepEFdr2Kf9pmxdqSfy8aQGbAJJBIKhFCuN9f6tYTJTShyXTQeJBmBJxm0RO1gufmDWFjKjaUWb1/t4GUaT3OZi3W1lyHxHHXBmdvbxpl5eczZT86C9/uxqEXVqWpcsbEuj3gOsYF5Fz8ytKgqWZMIyeoxyU7tzs3PerGtbGgF4BLOGioWKxoyqzEehxDro/lZxH/xPwtsiVEc8tql3hCB1Jk4g0jpb3U12Vnp4q6fiqJ6JnVuvvIoiUkoY1qXDv/KBUEVNdUTyzv9VtxqaOC1Y4gNmJT1aMNauCWjdvMsep/Y92O7n3dnjhIcFA00rj2C1aO6fEidHXl5sjbsJHAQ6kETGSjDWFvOfkPryVhetq5ntGq8+cbJ3jyl84q+G8mqnRI+P+3zIWMCIVhtDn6fhB/+73yVTwaFciOyoMg7c9WjfrTtjpblS9e8Vg45SmJ6BCUdd6W9d6JKHGrdqTVf6lAE1ehxofZL10cPHnMQ24o9M3G0BQ81P9lFKwc4ehde1HCCC5/BRYDkjtwJ3CXmmy6AJng7kn8M06gtxBOUdqhCQArtRe2WkDqu6oZKF/GGfY8ne6yQR0BlBzOH9eedC/5JkHjWZhVyI7DwbTajsvG5Sg8W44r5+gAXiKGDJX19aQVVIJi4BW3axX5c+zVkMzdv+MMHsC/2/R4hPVBFnXRCJ5uzNfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(261026121527099003)(56012099006)(261021121427099003)(261022115727099003)(261026140227099003)(261021123027099003)(261028144727099003)(261022105027099003)(261102123227099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?33PF8agDPgVaArwqXyk6of4QOg5k5d31Dz+QqjlhPNWRC46hWwkVmbOj6x?=
 =?iso-8859-1?Q?cbeOkXkHqxsYFNAhGyzpCyr1TzSit1abujtV18EfKuRNrDaO0NAB48jX6s?=
 =?iso-8859-1?Q?dn88CuRnxbNtrTkw0G5+C5b4fmLVnjvhrKAkRWZx2Jv7PQ8HGYiFOCz5q8?=
 =?iso-8859-1?Q?qIHCtYeH2H21g8TyTlbvcu3Iua9eSedU0iuz+gfTqSgOmQjfxNFx1DqKUJ?=
 =?iso-8859-1?Q?31QxnQWh3zPQ3nX5cnYrydumF+KM7WmYFfvFLkEovJ81rR1IxNGB+ALpii?=
 =?iso-8859-1?Q?QtYhk/ee/CylJ4q6yMuBXPXcgMrcRnfo4cQz29SNmDYNY91z+IH3NpH+9I?=
 =?iso-8859-1?Q?cN9iVU1ZQ+/c/8PewYl6h87z3QxazVT/4gYAz3ElvREbvDfEL3okmgUeqO?=
 =?iso-8859-1?Q?CF/T/D6niaPZ50B7qQ1uJpk2+cb0AMqD+Zn/kDSsteCCLzitpRk3ExeMV3?=
 =?iso-8859-1?Q?DUi1qTzb/6Yt1KV5nfZ4XZtgLkyBpLupSiZ5viQtLCzCTmVcpTgSZ0p/s4?=
 =?iso-8859-1?Q?UIgVFX2/lhRlQimjaYzXVGRJfU8jzQkvH76SALPp2z+P8Db/xK+UjPOcSd?=
 =?iso-8859-1?Q?3y8fYsTi0GArR8rtkVNiZWoX/xBE4adz8J9thOZAVYSlTn/rc/v1ESybdn?=
 =?iso-8859-1?Q?iGz7PFPcGRrNuneH0NyNjM7J0mYrUdf5qVenUOxWxSkhaL3Uoki/6dnItw?=
 =?iso-8859-1?Q?LkCt4oeg2/fJOnC0NQYe2rW5bzHg5JKRsGAxd7mPSSP6sqlZsVHKcp7Vtd?=
 =?iso-8859-1?Q?MefH+jJyEhmRypHB2nJ943g4Sc8dPR1IPtZfWgjo/W2vZ2apNAt58BkXXn?=
 =?iso-8859-1?Q?uLsbk9twffH3JRif5ahdkQkY8XBVr79r8Kt8slSFREzQPlCxe5fkWm2jHq?=
 =?iso-8859-1?Q?JlD1/fAO7AiJA9eEZvRGpWXIbaOB0WcPBhGuZofuLT5Hyi7yeFZt5WGHnr?=
 =?iso-8859-1?Q?ZvnjXC8sFX2vVVPsFbUYgoR4nBxKvhYE7wI1pbYVyzhu9F0wqRh3nUeL9L?=
 =?iso-8859-1?Q?MNlvaCXwdAEHt11AkskQxeDl/NIES3IrNF4rtfV9Z8AdwgI9f3LzTVbsqf?=
 =?iso-8859-1?Q?N7Ba32X7KE+zjLNsHKG3Skr1ZtDuUrqP8s86MKiPRFyx6CSThpyJJdDaoR?=
 =?iso-8859-1?Q?ybkPbDSbp1UTvpDwUQmuVr/h+vqcTXTQi2h1mKxD2eOBo7RjjLEuQTdmdW?=
 =?iso-8859-1?Q?tCPnE1NQcXkJDV+BQg3GGE9EO6pIZiceq0RtGFCZeQ/ZmLwaEPMybBJQ+s?=
 =?iso-8859-1?Q?XUbjydk0ZDx8vz0KofCACTRyk/TQr59RlZIbUoTjR7c+n18VRfmSWjU+Hq?=
 =?iso-8859-1?Q?kGtxeZQ4NBDwzQQXHEYyUGtnKmYRT/vP7PVxrQs/BDNzAph3moAYxdtz8Z?=
 =?iso-8859-1?Q?0rY1/6Ra45nAdvKkRrdyq5/MLYXfFO0LZruCCbVfdpjaOmwZDCvCQBuVXm?=
 =?iso-8859-1?Q?r/ytzHIsg14/NGFNuVZ6SGAj9/t6LxnwaLK5fHFiSI2XlhQPa4NL+l1BKu?=
 =?iso-8859-1?Q?DulpBqUOE4ZO+cA0oLOAzNhAJ2z/+SfEGB1GM6myC1efw9Wi/ZeVhXaYLQ?=
 =?iso-8859-1?Q?TSH0cba8QcvqKffxNpPRfzIzFqRARyFudunse8wEjIfn8xvRyFdF2H1w5j?=
 =?iso-8859-1?Q?fL4JKI2hrNBu6Gq4/oRJ8AJp9fpwMFzxVgdawCJ885cFZAO7aU9p3zgiTr?=
 =?iso-8859-1?Q?MkY/M5ffd5hMntu7httJi+p8Lc2e5bC+EmHVkyIp4lZ0Tr6llHJ2Fl7ihl?=
 =?iso-8859-1?Q?B/xd6aST4mUy7a1G7g/E6DJuhY1JgurcAOjgFyDENtAfKAN4JhSxYT/Nwd?=
 =?iso-8859-1?Q?x3mRLdaFkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216143eb-55a1-45f8-58ab-08df49ef124b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:52:03.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjYR5X5tisqumOHwY2uPlkIqbDaj3E5Bcx4RzjMuBjyVCI8rrh+rHMGLDOKqrRXvkCGj+lbJgvuyKO/e4+2IK1EV5ILrmvjtHUArNzMoItE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6526
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 42 +++++++++++++++++++++++++++++++-------=0A=
 1 file changed, 35 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2e23123cc6..093bf7c163 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -388,18 +388,25 @@ Booting the ast2700fc machine=0A=
 AST2700 features four Cortex-A35 primary processors and two Cortex-M4 copr=
ocessors.=0A=
 **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary p=
rocessors,=0A=
 **ast2700fc** machine extends **ast2700-evb** by adding support for the tw=
o Cortex-M4 coprocessors.=0A=
+There are two methods to boot the ast2700fc machine.=0A=
+=0A=
+Manual boot using ``-device loader``:=0A=
+=0A=
+In this approach, users manually load firmware and assign entry points via=
 QEMU loader devices.=0A=
+By default, the PSP begins execution at address ``0x430000000``, the load =
address of the bl31=0A=
+firmware. The SSP and TSP start in the powered-off state and must be expli=
citly enabled by the=0A=
+PSP through writes to SCU registers.=0A=
 =0A=
 Steps to boot the AST2700fc machine:=0A=
 =0A=
-1. Ensure you have the following AST2700A1 binaries available in a directo=
ry=0A=
+1. Ensure you have the following AST2700 binaries available in a directory=
=0A=
 =0A=
- * u-boot-nodtb.bin=0A=
- * u-boot.dtb=0A=
+ * u-boot.bin=0A=
  * bl31.bin=0A=
  * optee/tee-raw.bin=0A=
  * image-bmc=0A=
- * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)=0A=
- * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)=0A=
+ * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)=0A=
+ * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)=0A=
 =0A=
 2. Execute the following command to start ``ast2700fc`` machine:=0A=
 =0A=
@@ -409,6 +416,8 @@ Steps to boot the AST2700fc machine:=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
        -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42C000000,file=3D${IMGDIR}/z=
ephyr-aspeed-ssp.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42E000000,file=3D${IMGDIR}/z=
ephyr-aspeed-tsp.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -416,12 +425,31 @@ Steps to boot the AST2700fc machine:=0A=
        -device loader,cpu-num=3D2,addr=3D0x430000000 \=0A=
        -device loader,cpu-num=3D3,addr=3D0x430000000 \=0A=
        -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-ssp.elf,cpu-num=3D4 \=
=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-tsp.elf,cpu-num=3D5 \=
=0A=
        -serial pty -serial pty -serial pty \=0A=
        -snapshot \=0A=
        -S -nographic=0A=
 =0A=
+Boot using a virtual boot ROM (-bios):=0A=
+=0A=
+In this method, the virtual boot ROM (vbootrom) handles the full initializ=
ation sequence.=0A=
+It starts the PSP, which then enables the SSP and TSP by programming the a=
ppropriate SCU=0A=
+registers, following the hardware behavior.=0A=
+=0A=
+Execute the following command to start ``ast2700fc`` machine:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  IMGDIR=3Dast2700-default=0A=
+=0A=
+  $ qemu-system-aarch64 -M ast2700fc \=0A=
+      -bios ast27x0_bootrom.bin \=0A=
+      -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
+      -serial pty -serial pty -serial pty \=0A=
+      -snapshot \=0A=
+      -S -nographic=0A=
+=0A=
+Serial Console Redirection:=0A=
+=0A=
 After launching QEMU, serial devices will be automatically redirected.=0A=
 Example output:=0A=
 =0A=
-- =0A=
2.53.0=0A=

