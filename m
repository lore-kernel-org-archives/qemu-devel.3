Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A754C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGE-0003Y1-SD; Thu, 17 Jul 2025 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL54-0006gK-Vm; Thu, 17 Jul 2025 05:39:11 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4y-0002Pg-89; Thu, 17 Jul 2025 05:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjuRg/pssfHNTnEMl8hqX4KjKLvVJTrSpQuMIMe3FM5nIsvuLm+NCbMkIabSu7Tk6yrGocWfSK+ffB2P1YexOaulh86z5mrtZjx9R1EWalTyrtiXdWJLCXycfV6evHO4BSUIApMD0qr0E+IP6lncftAJj9oGcbxlusBv/ocXJLXbuJj4up6CkALbutbaHLYxKoEy3g0cNWY8mvsgqXAjXuHiVjC/2ZJr8+4RSsBvDjn+j7fOWWDFw3CDcCAIRi2YLFlpBUMvDUag54NBHPmnsWLmep1E07Cw74rNIKd4+mkRHxRW5pv/NU/MfNhWSs6GqxVKqCyIS/qLnnT2J/iKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Astp7rw2zGshIk1wdHPURdYuMQ08p0eduRZww9BSg=;
 b=iXBpNc+geqSB3wQiaVk8/fAzTr3mgSKD6YHsRCQqm8ypA1uNCJyI4IPHq6zXxXhrOGexlAblEPrF3Dqu3n0gdX1ZkcaSzSpKDCR+MfsD0Hef6DwxotLQFBnnw0lMfB1sDOICktJisetllJBEv/d0L9oJX1Q668k+/5pz+X0gTBm5EnD/z6F4jZFXtTlreTFJ8vQgKQGQvMaHEaIQJjTCAujZNCIOD4gLFp19ZQwdD1c6hUvIisy1Dh7Lsv0HMtOzX5alUaKtaF0RGClUjpku01THbLfH0xxMUVhRVmx4oNvCXJbEP+sR8p1+k9VNmZkPVy0JPPN5xzLNvlcWMi8KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Astp7rw2zGshIk1wdHPURdYuMQ08p0eduRZww9BSg=;
 b=FA6bWQkwFx7Wf8cAUSugaQX15GCmQP/BW/fpG5I5gXdySlbDwtJ6XTSP1TH1+BfAG/xrRzhIMRaYvqB0X+MvxxlogZELeYkhm6eY2Lu/ueFWQSqaH81wdYEYQ1pSxrvls0Tqrq++9+SZboNtfz7QCaP+Cd0Un0BHNJ/kMps8Hqn47e5zrLVdQYbHT1BT5vEf+ONoOnno/UOnhdCqk2pBTF4HrW1A1FViMDw9gm1ablBOc/jUKG7Ne02VujGdXiywEjzlFizQObRpgDWcSuGY7FMm119tGDbf0GdXLmuvpU1aNxJXSjZSiei2bvrrVYtLzRguSqRRdVlm37+/puVLhw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:48 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:48 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v6 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHb9v6WU85HvH3vNUi8eMWBOkV/+A==
Date: Thu, 17 Jul 2025 09:38:44 +0000
Message-ID: <20250717093833.402237-10-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: 56bc88fe-f3c6-496c-e2f7-08ddc515bb85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c5nYh3+1eRc8bhmspu/zmgWdu7W1doezhjh8Au84m+KcmddpCgGfZnV5zR?=
 =?iso-8859-1?Q?+7eVGAON/s2rwGacXHJqQma/Exfs+w2TnZVJKAbexhmt08zzmqOnhF+fC7?=
 =?iso-8859-1?Q?dabCAvUIcBwFAY5PgAVxRu9bXus/0xcAbayFolMFjFIGFtyYSgQHH1cGLE?=
 =?iso-8859-1?Q?P2bts8NgWWMmpgFiyMkv5oRG1hH+5pNM098T1CCQ2YknY2aDUG8qsI5XC9?=
 =?iso-8859-1?Q?OziS+SMN1DbeP9wXlN8bAff86rOwOpVQjNFZTpZPGngXH4aw/3ffRc+QBM?=
 =?iso-8859-1?Q?qnNLyu+zIJIsJIKB2rU/Khj43sbTIoQj7+SxJWP/abBHELhteNGy/8wxGQ?=
 =?iso-8859-1?Q?67UDY0ssXoCegAmfChq7AT7GkGJOIZ6I/senUWFiVBfMY5P9Y+bfA8wGeA?=
 =?iso-8859-1?Q?jI3qibKpoYshBNd3NycRrOkRHpz7Hn3d6MGuRYpfvSDqKQstZhdKdpPOzG?=
 =?iso-8859-1?Q?58nqvCGxFTjcwDilOCS120bEwv94UMTRNL6qMe/rHcbKgfGwQ37A1g0PbE?=
 =?iso-8859-1?Q?nAkrm3OAIntSq60lkIlFnhPmgu9Tubkf2uZDstELFYHGT7Qc3uRnhWjwDr?=
 =?iso-8859-1?Q?eeV9DxMI4/hx1/UVbZBXgzcRt48Tay5p+ze/wBt+0NTjZI28/2AbnBPHiu?=
 =?iso-8859-1?Q?P8lgYc30730agZMJlyHX88jsOPBblw6ps1nfh6dVLi6LxpodsY3mcp5jYT?=
 =?iso-8859-1?Q?+bQPk3haXbHq8QiBaWXCKtzaH3TpAWn/TdkLd9RZHqsEo/nAqBCRxbBcdT?=
 =?iso-8859-1?Q?WrCNximsqTOS7W3pjoBcStBGVo808yIUd+7UoPjkJGK/1lWaVV5wJTH8zL?=
 =?iso-8859-1?Q?iq6R6iUNGVX6uguitnmFBfGINHl/7sm2HIC+H5qw2cSh4zAhJ8CovtV1xK?=
 =?iso-8859-1?Q?BdrWrHOgzlcDlTCoT8xFPeDYGGpC4XhTkx463S/Oi9CX4G4WXqhziR+OOU?=
 =?iso-8859-1?Q?rCqUDrom03XVACQ9VYCfgGjUx34vrw06TRK7KeMsj6fQHK4Wqs0JYxAMeg?=
 =?iso-8859-1?Q?IrSIqWbtPvaheuOLiXbOXPfD9LxrUUZAWx/LAd9wcaTUPvh9BUKTS0GTSk?=
 =?iso-8859-1?Q?ezlE2GluDMxQ7EOBeoH2rdDSfYgrVpYKJKxyyzBots7rNRCRmpfiRTGNpv?=
 =?iso-8859-1?Q?HxCU9XMDlUO3qwCEI7lJ1qHgPx3GV+zBBrWqkOZb13ZONVnh+uOEo4Xad4?=
 =?iso-8859-1?Q?wq8ZZ7Fg22Ahs3z5xFSTZy6BHvZ3+3e2suLqXDulcRXHMSilZvb1MoVN2C?=
 =?iso-8859-1?Q?6Rr50aOvJOIN2ZMQDNtWdvSmyUvKLur8X9Vx/g97ckJo0bOyVHpbBBpdPJ?=
 =?iso-8859-1?Q?gODWH+8RJnGwBlROrWXWEmLycxW8NfRYCU+nIWTb1bDZvGU49aDIyI5ido?=
 =?iso-8859-1?Q?PF9zTFmAZzZp6vEdEZMTSDIS/DpjvIwlNIImkOBI/Kox/Njmr+rSqYMKAl?=
 =?iso-8859-1?Q?VVf9LX7xvMA0rcrUPhfLJfUbxG/PQyNR75Lzky7g4m4Ix3UucGdFjGeZH2?=
 =?iso-8859-1?Q?y6/XPkGXgy2pbuy+GvQow1KXLu8YiJ85EevKBE8Pz1VN9Jlsn7e8xAJvbY?=
 =?iso-8859-1?Q?q7bdmeg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yZI25y0o5pgi6p+93ajV+2cAmd/7e2OPflYTQBhwZIa29lUzV+kCp9djXL?=
 =?iso-8859-1?Q?UWnBiR2jmxB0hXSm5XMPhYnlj2XhaN8mWGLDfp/UInjm1sofH0uLZoyAhX?=
 =?iso-8859-1?Q?qKlPUKV1j6M4vLC1MUSBxeRXN2pultFtPSjFccL45notR+Frkyci/w6jOx?=
 =?iso-8859-1?Q?/OToeh4D1qbrEKNuimVdgO8OUVbax8ER7H2EkmD7DS9HagDzfAESK5vPvS?=
 =?iso-8859-1?Q?AzSfBiWip5FPUCTdcN2rFiO0cVw8looF9uHC5MBnE203Dza+4K7q3Wzzc8?=
 =?iso-8859-1?Q?SVHOCV61npzmkMozgo9Eh09ZrA0FxbKG0Zoi5NUF/Gx0qt46oDF/pxZRJh?=
 =?iso-8859-1?Q?OXrP6OwJph9uTtE6Cw7NJ4xMXa5FhxGm9UZRFQuBAmiHd+aDkAAiVixSLM?=
 =?iso-8859-1?Q?hlz2xZMZNz4O6Q/R8YR2BA3veNJwqWLynGNvMpDmmzTGTuYGWpQBhNHTAg?=
 =?iso-8859-1?Q?RLYMX3yF5JkjMhOgcLZUVFaXBIyks0yaeBMTUXRS4HZXVoEiwjb53QFA73?=
 =?iso-8859-1?Q?D84yvDZZuVZVoBh6QSKAcQ2URU+eo1t86MLsfK4JfPVobIyOxk6iJXG9uI?=
 =?iso-8859-1?Q?CrQwHu8UmoTJFtos1BHu2mKVZg3EBCNzpAIFr6VUo2oGJSfiI81PwZNijt?=
 =?iso-8859-1?Q?G/5O4CotPX88PBBBe/QiX1nB9Jnxv8OQnFwSbAMAlkvtoLKdr5LwDADwAJ?=
 =?iso-8859-1?Q?cuVBbd8fLYlUm5N0prAiouKfil5w0lKoRS2yHsgVIPbtjGPgldcyRMGhKW?=
 =?iso-8859-1?Q?9A8HHPy/2FpBUHVHd9l909UUwgcvlW6Q7VPRRexTQr6ecWRSIRQSAu91O5?=
 =?iso-8859-1?Q?lOthi7oS1tVKj0ThptcNP3cPSd+uyqvs4b0X9gY+omsBfsC9+zhWnp0ZJZ?=
 =?iso-8859-1?Q?t2f2g8rwLpZ9sCy0d96G+bcryq0coTM+ySHygX8NyKoV41cmoesV4V98jC?=
 =?iso-8859-1?Q?DTPMarrohFTVsEBmgWmGCgStMrGeCo7rXqDOjc6qHBV3ebOqCcPp4j1duq?=
 =?iso-8859-1?Q?EZEkQp98XlBOojay75lY5HV9mt7GvapcOFxy6Jwv8/os0+Ku1OJQ5ryipf?=
 =?iso-8859-1?Q?dypxp0l8PLZSmWj4dv7WBBXXkKu4h2P14dQU7nEtRp/VAApLEgsPto2Pw7?=
 =?iso-8859-1?Q?2iogy486Y2zK0yinQVMy360u+AfPV51aGUzFiR0rPGJJ5GxgwTU8wCSBE2?=
 =?iso-8859-1?Q?Qtidwn1NUmh1PoC2PWXs+AkXZ0sNFMA5XX3Rrbj1VzHogQzZarzGQUU3Ou?=
 =?iso-8859-1?Q?OHYXNuUIZzwGcBm1JFmaZKZxpO42XryBSZVMh1yxeMTG6Yen2rh33N7r5p?=
 =?iso-8859-1?Q?eX9kyis3J8FU8HmRftH5I9LBrffwneIdBuSoQmTzz0Bop88ksb9TrCfExz?=
 =?iso-8859-1?Q?tRkeaGIawOnTvqc18SZ4KNbe8GBjayDxgvGXtwz+en4KyGUGmnq5brFb2e?=
 =?iso-8859-1?Q?mu83P6BQHErbL5YFJeFFG/tYmUVpT0Evqp69k7TAQxbkmPnuYg5v18PJil?=
 =?iso-8859-1?Q?uYd6VFKhoG3P+zM4okMk3EGqR+WTGq5i2ASL3ZpiBqarDpeIdoShh12Hhr?=
 =?iso-8859-1?Q?rbJL6lgENA3iPM+A8BeGDWV9y/rlU5fblZhHCuyPQ3x9QpBA/0Ky1DgDxl?=
 =?iso-8859-1?Q?wT/tA8KMSdcI0a9n452+TbUGIEBRb8G3Tzs9febRy80XXJua/T+PytQrlJ?=
 =?iso-8859-1?Q?+my8AuTN6K58yM05ReU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bc88fe-f3c6-496c-e2f7-08ddc515bb85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:44.8937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raN5fGccU9jRUW1encx8TXShLLGPLUGJr/Sn/13X9qf0l+FrMBvOWaHtLz2uyoH2ZY5gHXOb2BzOLFLWNCK0HG9rzEfe2IdCzQP0v+F5Wko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/misc/Kconfig             |   5 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 239 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  73 +++++++++++
 4 files changed, 318 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e3fce37c01..fe166e08bc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -112,11 +112,16 @@ config RISCV_CMGCR
     bool
     default n
=20
+config RISCV_CPC
+    bool
+    default n
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_CMGCR
+    select RISCV_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 29c573f7ae..8a4d0c3ee1 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -154,6 +154,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+specific_ss.add(when: 'CONFIG_RISCV_CPC', if_true: files('riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..424562d7be
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,239 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    if (cpc->num_vp =3D=3D 64) {
+        return 0xffffffffffffffff;
+    }
+    return (1ULL << cpc->num_vp) - 1;
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vp_running |=3D 1ULL << i;
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)
+{
+    int i;
+
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        CPUState *cs =3D cpc->cpus[i];
+        uint64_t mask =3D 1ULL << i;
+        if (mask & vp_run & ~cpc->vp_running) {
+            /*
+             * To avoid racing with a CPU we are just kicking off.
+             * We do the final bit of preparation for the work in
+             * the target CPUs context.
+             */
+            async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                                  RUN_ON_CPU_HOST_PTR(cpc));
+        }
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vp_stop)
+{
+    int i;
+
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        CPUState *cs =3D cpc->cpus[i];
+        uint64_t mask =3D 1ULL << i;
+        if (mask & vp_stop & cpc->vp_running) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            cpc->vp_running &=3D ~mask;
+        }
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_=
REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE=
_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CO=
RE_REG_STRIDE) {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    if (s->vp_start_running > cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp =
=3D %d",
+                   s->vp_running, s->num_vp);
+        return;
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vp_running =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vp_start_running);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vp_running, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vp-start-running", RISCVCPCState, vp_start_running=
, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..013d95fcc2
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,73 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t vp_start_running; /* VPs running from restart */
+
+    MemoryRegion mr;
+    uint64_t vp_running; /* Indicates which VPs are in the run state */
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

