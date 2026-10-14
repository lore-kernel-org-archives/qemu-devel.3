Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D133CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3J-0006na-I5; Wed, 14 Oct 2026 00:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr33-0006dn-04; Wed, 14 Oct 2026 00:57:06 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr31-0008JJ-Ab; Wed, 14 Oct 2026 00:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efHt+Rv7c4dQSHf+IvArYq0qf5i37vB/1ol2895Ui8S8hv3N2puf5jRaDCzNH8tchGarW+7I8RbDGOZ9u6bMh7JbZngTbpKcspVvp3E0q1pWQ6O/DwewJr90nWWMnkqZ2fSVtlfRPrnhi170G9C+1i1jxHy+AiQmPSXM8q+ZHoMFkcSVigaA9A73TvhkQrDUattM7AxAl/3eUMFakLL/lKJpFVtFrKel6MaZD/+nqy/uKU8bYpt7gJxiolsGVd8naZMHQZMAaruQRu9Nj59LZAJCbMUsIqGdCK6znKpOfnFJ8E7Sig206naqEkMZrnwlWlh2ME2Ebv3GBHTCDT04cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLdRHnszXbaZmRDrJmUor+TjiQcaN3WIci7KM1et+LA=;
 b=thu5x6Vx2UF7mJ9MzXH5qFds3zWbp2ZyeSNmSy942m9w5WI2y8jofp1zOjeVNeL9b1ljMddgKrjjOKjDmrjMwJdYJbuVIVGx1mct0fJ9JLqqxjZWWreiokFcHcZYw6zrVPgFoKbll9OS5xiLNNhXMXX1pv4TkHEYc4KU+Xb04JEB0JR3HR/RkGjdilJslH2xgvlRL7hy101CfGjUTrBx9aJIF46ZOxhCemrZD+d/4V3k9605p8/5F51yJGhbkSbjQRthE+NyjoeKPwH7iaKTePIU48l/VjA6GtLaJVRXjeAK1aBDKw/MZg/TUsT6ChPnTX5FDLHSByUq9kJrs0ul5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLdRHnszXbaZmRDrJmUor+TjiQcaN3WIci7KM1et+LA=;
 b=Sy72gk0A6Qq5Zg+wv+sEZtdgtcaLht2rZLjjJajwz3LPum0NPMx0Q5xv3U+9Hjbtaa+7k0IZtp2UTJ0o3CfA5EYoo975b6HswS6fkU3C9DIHf01YOPfkR0ubUjBW/htd3d1Bd2tVanspme5WuBGE0SmMpU+vAfMoIXPQCkXGRftVCzFsjXTNtgMklPmPKpSUmeQTz7jY3/of94yCecBmxcCL4AznTvSLWzYt6HzMd2HkVldVXLx44dvaJmUwfisNw+AvvUJ35p/njjrczYmu30mkPRcTQeTHN2HRpX9hXF/6rY9N94/uEPolQa02j6P3Yz/Nynco8clVwOqdpx5oXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:45 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 09/10] docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
Date: Wed, 14 Oct 2026 12:55:59 +0800
Message-ID: <20261014045605.399684-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: af9f99f2-627f-4ebf-d4ba-08df29af8ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4mXdmCDWOSjdbolh1BWVwePVFvG7nrW06NVZ1mm2mVkwmSWi18SJfOBPc54BweE18cCXE1i9Bl9ulvwiYCmfLYmKj4Vg9UMhk6WyYUYjdMfExSEGsuIfuAgbXVsXnwIlnYulhVeRipKXAiWjzHp/qM9tOUOF7bHliwPZwGnXUHkO8cFJ/0mjpnJFYSFIzbparme9qzUKowhRpjcASpL4Tza6ZsQsufXqOfg70ndHwyeVuFcU5nJZMVaTfboSs2df3BRpXfg+oXskS2X8H5McN2t1dSEKMNBjPbtvRIzTuRwCPzUcrpmrHnx63Z3qD4ryYsvCAVMEth8UbnPbEuLoMAGCCFFZ+hkeu7va5s6NuSfgc47Oc89vBGQwSA78Y2WEenxHpT+frQBqMQqmbYxfM5ByvT118ljPZXCkV8g44pGyaanp5zm9vISfH0LRKBMnVoZ04lgynZOICK3tlW/nLUj5K+BbGtj1CGN62/Br2wibtTWg5ZRzS0FuW5Dqd14rnRy9oQoEN2YlGw4uZMKtUBWAiuSduiTvnOriypqGUT174Iw9YtcqTl7QllKxeuB4ZluB0CiWz/A4Hp00APvk5IakQ0S7mGhz4wQZ79ZYj0xsOZXujmZObJdEDj9Bzvg2IXZ1xYz2LPxgaY7RweVIR0C1UCRO1X4hGMdZVndZCEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Jw86O1x8hndrkRrHLvYU5xTLrXysda0zupRDZXNVAbjqDI5yInXG1+lZSIw?=
 =?us-ascii?Q?fV7UxxmYR9THeSUtFlK2hpAjg8Ap/Ceo/GJsdbmPpLYMevCJ9nD0NO1b1Ms/?=
 =?us-ascii?Q?Ps/9ATFt4k82oVRbWqcK2NrvUiLgAJKfXc6Uda/alsy28qG4vEceEGH7UqWk?=
 =?us-ascii?Q?F7H3xFu1v9gPXZ39wa5bqX2G2PPi6MtJ0fqC7bm78+HL49KJQRESaGKappRe?=
 =?us-ascii?Q?Cgx8Oo0CgKM25vUsFY1xa9UBXQXVBV0wRBDC6blvtP+WRtI76TgRxMv0Yq0E?=
 =?us-ascii?Q?QDm8tgTe0sgotVYt/7FoxZBCwdRfV5Hvh5y0sTAastwyDHsqi+DP8DUouTvF?=
 =?us-ascii?Q?hywKSP57/Ut8xlKJiKDp8JtQwtvNXrXvXrji8WdabXXYm5iEtwoE9OSlu1RY?=
 =?us-ascii?Q?4sDuClBq91UhC12x3O5qt62D9Xc3qQ71gAXGFFrB3terYC4LMWBwWCWnEczq?=
 =?us-ascii?Q?tT9sRfDvTPqW8kggdY2WcMVfizpS1d7z6Eglo8GrjXt45eXDnCykfegx7IVv?=
 =?us-ascii?Q?3TYU49h377Gcrot+KTwrrqUPtwsvBKwnGKN16K84WUq1JILrxBHfGohv4Rtb?=
 =?us-ascii?Q?39XO8WE43bREa1ey+9a4r/Phu0ZMiyZuHr4NDKW3YHUSk+QhyUOQ2yT1gW4J?=
 =?us-ascii?Q?FaDWmGyDNidH7PrXVD43pUstl7seR0gtwQEhC9oThCZjEf89EPk8lk7Nb90d?=
 =?us-ascii?Q?drMAzri6WW5sEN+/uvH246LuqMWAh3hcmtkvxxp+G33l9wcKPYPsMJxuekzH?=
 =?us-ascii?Q?NlaMR+tiJDQlcn3MYn3y5+aW30FxJl23Uk7dFfcxYsWhN3tYoyohdOZ6RThl?=
 =?us-ascii?Q?uRYq/OtRmpbXlb1x9ar/ehR0LogYMJDNw0yKPD/s9wiSkFePmh/YRNoQcad8?=
 =?us-ascii?Q?CIk0u7cJvg+Gm5whFSHwREW9636tGizj+jxamFG6gxfjQKBkFWh5PHDx/B13?=
 =?us-ascii?Q?WDdgK72N+ZV4S5LmYgLMHRSCyFTJwMUZzE9x+AmHPVNhOO3SIisR2OVlJxME?=
 =?us-ascii?Q?dFQZVQVu6taTFh7OBVrOJJpb56Mwo+w2qpJbikcx6fHZfJB048Vy4WcA4Gqk?=
 =?us-ascii?Q?gEgwEFdZuwPsfMnll9JIJMJp4dqizAwNytDSaHBkq63Fik5pJXFG1Bde9wcz?=
 =?us-ascii?Q?vrHUSMsGXd7zDo1z9G4eI1eSfI2zfnEpxDkUyEwNnfmUZaVBxzD4j+p83h32?=
 =?us-ascii?Q?At2GSChYRw2hSQGwVo7KAFjemdJBgDHbPvk2IFHsZ4v7QA899Q7Ulgp7Aedj?=
 =?us-ascii?Q?mvr483Gf07hNusmfWCIOsE6AKd7EGNhiVLsYaI/iV2ihUBuEoKo4h2I2efz5?=
 =?us-ascii?Q?8/I+RjjdSZTIHnEk5/69ATo1TaWVWvSIXtT/kxXPkJqgA/O7Bl3/LJjBiggD?=
 =?us-ascii?Q?icyVJQqZSt924ylyTq/BOqSUyyhI15O6i3jEA72rVMJTJKy60jbBoir/G+vK?=
 =?us-ascii?Q?JuUbi3JnOY/I9Hdwvj0gzmMUxk+bln9Q4Ogqf4t2T4LSK8ETHiptDXHJ+5LN?=
 =?us-ascii?Q?Yh9+Edoe5vZN5nX2pnyJJJGoOu4feRT1Z4PyjMurKKfrBtg4JJ4mqZoKy6E2?=
 =?us-ascii?Q?uNi2hSsmH26PpRo2vuftndAGtTC2hvYQWDIHay2rSQl4S0NEgVyivQkxmO6y?=
 =?us-ascii?Q?f9VUQplDMMh/hRoVpnWVWOAD7lKqBsvpoiVWdl9IQ69UKA50ieeIZoGE4HMu?=
 =?us-ascii?Q?cgcBtd1yEAdFeSdGxDciUEUjwntLuTRnyexbeCfrIs9Bx+HnUuiC9uSJ1+8d?=
 =?us-ascii?Q?wlNIx4+300zkNz04SMHxW1nX0NTaKbQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9f99f2-627f-4ebf-d4ba-08df29af8ba9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:45.0698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6DRGSVBakhnKp7kUsYOX/UCmQR2g96s1hg09TzOFE5uG3SIUDbU8va6yFsD7i2LmvN1OzRjTBNHigvPXho1mM0FMRTwsFIQ4bX1EeK/7sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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

Provide verified instructions for U-Boot and direct Linux boot using
Buildroot images.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- Document the RAM limits and firmware geometry rounding

 docs/system/arm/mcimx6ul-evk.rst | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
index 8871138ab3..a84b447019 100644
--- a/docs/system/arm/mcimx6ul-evk.rst
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -3,3 +3,75 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
 
 The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
 MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
+
+The minimum RAM size is 16 MiB and the maximum is 2 GiB.
+The MMDC geometry reports the largest power-of-two capacity
+not exceeding the configured RAM size to firmware. Direct Linux
+boot uses the full configured RAM size.
+
+Booting Buildroot images
+------------------------
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make imx6ulevk_defconfig
+  $ make
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+  QEMU_BUILD=/path/to/qemu/build
+
+The generated raw ``sdcard.img`` is about 84 MiB, which is not a capacity
+supported by QEMU's SD card model. Resize the image in place to 128 MiB::
+
+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard.img" 128M
+
+This modifies the Buildroot output image; rebuilding the image restores its
+original size.
+
+The SD card must be attached to USDHC2 with ``index=1``. It is consequently
+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux. The first partition contains
+the kernel and device tree, while the second partition contains the root file
+system.
+
+U-Boot boot
+~~~~~~~~~~~
+
+The machine does not model the i.MX6UL Boot ROM or its SPL loading sequence.
+Load U-Boot proper at its linked address::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -device loader,file="$IMAGES/u-boot.bin",addr=0x87800000,cpu-num=0 \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
+
+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImage``
+and ``imx6ul-14x14-evk.dtb`` from the first partition, and starts Linux with
+``/dev/mmcblk1p2`` as the root file system. A ``bad CRC`` warning while loading
+an uninitialized persistent U-Boot environment is expected; U-Boot continues
+with its compiled-in defaults.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+QEMU can load the Buildroot kernel and device tree directly. The kernel then
+mounts the second SD card partition as its root file system::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -kernel "$IMAGES/zImage" \
+      -dtb "$IMAGES/imx6ul-14x14-evk.dtb" \
+      -append "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw" \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
-- 
2.53.0


