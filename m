Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78DC624D5
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 02:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1aWH-0003Ny-Cl; Tue, 01 Sep 2026 22:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1aWF-0003Mb-3z; Tue, 01 Sep 2026 22:16:07 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1aWC-0007bI-Oq; Tue, 01 Sep 2026 22:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFXMm7LZE+LCMIWXzDHF0psrWlOuqZJ2koIxWXIo/9mFVwoMytzJfGXJ777vuNssyoM3XKMcXcyAK4uKCwL8gLxVdTuEZS1aWunA2ixbNo5aVmQgbwN9DJVZARp492UXsRlKsR5S/S/a3/HtRzS5sHLmKgLgLYJlnWU5+uQFtd8mWegOomC016ls+VBrdThVEJpywQDVwsnbZF5bbsgkOythvnq9DTfMcVxx4de825IATCOdzgwiFnTeha2uwHRv8diJBxHuEAGx/U+UQuhf2IdyvE5tYJxMbQPte3clT/RUDmQzwcbogUoooDxBNfI4sKxWOruRAAt1iokkzlFfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjXgjVpdN+FUzSjdjIokViJKjfvXfGOX6gSsoEPF9wY=;
 b=X6PcQcJ74306H3VG6Hpg71cnIhMn9QHl8o6aLL6JANLTqvipRfwo85TMr9xlT1ubJue4f5+lViGGiSIZDn7GCYt6zIkPWAWVgUWgtKTAMFhJzv4jR9BGwC1ycMGh6aE4bcHczC3srVnCVWLt224bqEeRhh83ZSIB8U5XRoDY+usicQvhJpygCjjceWV4fY/Xc4THx89o4cW1NKsNR7OYJfnU0Rez7ce7Vw1zPmksl88PtlrNNZdFX8xVk74nSC8MeNtFwQNV3aRX8K9P4TBsNwpIR4YT+d5a/y0X9ZeSFbIagvb6pZAvn0q0gsxq9aZLUAwq+9C6u7qSWzRViVv8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjXgjVpdN+FUzSjdjIokViJKjfvXfGOX6gSsoEPF9wY=;
 b=Vc8FcD0UGRTb/QFjhNHN6lN5hnVhTAOZ60y+CelzETbibxBUjkYp97YuIwuVbwhbp3abPq27obTIXGRQ2FXifUFVaRoEfOUSqa2LiCg1QKOoNRB6rrEe10iBP4TU0EZx9d8cdMQQbiqgOTwCF3YRpyFdhtcJDhvS6vj4KP4mx35xIBIn8LEvFUhSD7oYCqmCcqV8U0CD4ULxLB90PLJ8X5jTCgBcKTJ3AyodNNIXPEl+q7csluIETqUScG8xc4r4QtMtA55BHp81K1EEwm9S7+qnDjq2Sq8ygf9xZ7M26+DE2kzdF4m6S6+AahU+qBm8/HSL66/ylIAED99JqUTk5A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5782.apcprd06.prod.outlook.com (2603:1096:400:26a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:15:44 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:15:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Thread-Topic: [PATCH v5 1/4] hw/usb/aspeed-udc: Add ASPEED UDC device
 controller
Thread-Index: AQHdOoD1nKf0Ktqey02zyYXzNrzEIw==
Date: Wed, 2 Sep 2026 02:15:44 +0000
Message-ID: <20260902021542.3194812-2-jamin_lin@aspeedtech.com>
References: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260902021542.3194812-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5782:EE_
x-ms-office365-filtering-correlation-id: e39bb7e2-18e2-4f2a-b2ba-08df0898186b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|3023799007|10067099003|56012099006|921020|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: /R9grVezfwJIWAh6jdLNr6Y0WAORIBmd2DbOkd3orzL7j/n/FmJdZj+H5WjuGFhXpQPA3VlXGY2ahOVWEIJMrVCXxA+MOsP0A3qEHCLLOgrZ3ZqmvFTNGl0fGRG5wYPbBJiCtaFI9JPB0mjr9GyDspv/kL79q8YW0NnUoUDGKDR3jRXsuKtY0G5a27XGfoBLEu8IjazANVl0XnKCQr2kc0aEVw+LqkYYVdq06rU3c5FRcMkRnIMUGUGeitd3J407pVKeXeScW3v0ArmMuRj/UqYKCaPpAyYAgEMFP50sH1P21QZaIBqQ7m+h1dr5opXOxG7aPd0rI4jKriQqr8MBDpyI+24ZcgLNDrrAoTQFpRiS2jW+eeCrm05PFITuI3yTd+E6n1Xi4QsCZnBHKuiVssB8Ff0PWDKDe8GONfNqoHxGD7gcFqu94GGPSCBeUxEsXO4bzEZA8ubFtOhvdLLVyfARr/lxujdo5PqoVklYGYWQ2il1hKAeEqGPsRdgdo2M6Tsjr1HOdZ6MulY34HUWv8aAN7EHkRvj0mZfYTyo0zQKgHgH9xPJoRZP63b1bIL7aHGgcfpkE7TsYsbkHTWu5CNxkDpvjtcO+KmcTsbcW6PuLV465VIpaZ05RTz6G5PqkdmwQSD+2W5sAyj4IPyitEklexUN6wp6JUVgDdXLTnz6k/w9W1LNoGaU654F5BWXSG2YeEk2Zfi1FGrXJZDE8KItHejp32GawmqJreLJ4gz/hiqGE3PPjnWVhy9k9e4F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(921020)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jQ/WIE6BJX25qXcbArMygJ+hoXahXuB0UfdGrwaM136TY83eGbnGbBKVs9?=
 =?iso-8859-1?Q?IT7LsOFtweqWEAliwEKxqGis6oOjmaJAflmP3TZ+V00GbJBGJe0i9RNGCk?=
 =?iso-8859-1?Q?w4M07whI7X42V6edhuJNbYEapLRcZFKwn7AXIjSHOUmha2eNvJXW+O5JQp?=
 =?iso-8859-1?Q?quhBrKJHX0BR2D2vPa7qpo6GkmQpafF/IHIM1CckfuuI2bJfz4zpZy4EKM?=
 =?iso-8859-1?Q?7k6QkCC5nYZNTHPP/FZ6KFbkWXGTIynMCbDA+SvO2zmwZG4xucthYPea5q?=
 =?iso-8859-1?Q?dJAYlJP53IyuT689LKeKeXe0SriqKQX+0g586CLxSFwII1qOdmpf4hlt4a?=
 =?iso-8859-1?Q?8u3fchx0O8FSKE1NOJ2OXnfeo+FRsiX92tU3nnXs7IkNqfxK9a0SYUbQUQ?=
 =?iso-8859-1?Q?l3YoM1086JhNII+95Y7TsPdTEQ4DGwfDaKWc9qWUr4ocepF6cSM1qnbq0V?=
 =?iso-8859-1?Q?2j1RIKClizAyV3jg3MLgt4l6LwGryFLQFI4Jujjm/r+awdlMZuAVZOjOgi?=
 =?iso-8859-1?Q?595FYy9/oPcgTSHG3+ymJAWLD4a34EOOw9irDaBQAXafly1iZb9zmtJ7XA?=
 =?iso-8859-1?Q?qrFJ1Fjr6+ge2GL4Tl61fINa1LiMCT4RlT2mYdL37v7COiYWHzlhv1U5Uk?=
 =?iso-8859-1?Q?xJCO8o7tPUezR+VIFiZZuxKZy5DoXG6J75b/CHug86xgLLscxKtKJPkOsR?=
 =?iso-8859-1?Q?0UBAqDweXXIBrHMbzxwRMrpvGPE3azhOi1V/s/EYL/uHcFgnjsefjXTsz2?=
 =?iso-8859-1?Q?KSiAPWiuRuMWmJTPwAnoAEZyquNSrhZa0cOkoTgjj9//AsfqiO2Gbx/kVb?=
 =?iso-8859-1?Q?mgMQvv9MsNYa7M7t3sFDcjOMEaLcNXVqNK9/MH+ms1ulUEMfjIn0+332XX?=
 =?iso-8859-1?Q?nA0Bo4okFwkkIdlAdWGXCbl4KpNySxOtv3LJQ+0fL4OfmcUdJCLrhUqU/Y?=
 =?iso-8859-1?Q?IZFneB7CAWMNeRFPl0MndcPxEbsqhmtWQcRR05F0UNwJrLs7BPUfZzcrXj?=
 =?iso-8859-1?Q?34Lyvg1Y30MFnvPwzbGBC/xD2oeHhZ7ETLUDzyH0LW1ZT59qBM5tagHyzB?=
 =?iso-8859-1?Q?7rB8UUHoohA3iouRJ4PkyKonD1D9nlU523oeL3K0j+kz+z8h5yk1LJIqN3?=
 =?iso-8859-1?Q?YP5fN+E6l+ZZczIEXOKkRVsMlVrqKLkTwMFefjHeyLoPM704McPYqiYXny?=
 =?iso-8859-1?Q?gru+KAnHp2NCFVNifJsgOHhb4hZGGOmaQuhKNSgb1Rurmon+HgUOFd6/WX?=
 =?iso-8859-1?Q?EDOoE3JEAsKJc3kn/zL0wy5AkyKK2dZL9IopwQC6134J/lTAuijMsWWtMX?=
 =?iso-8859-1?Q?osbe1I95fSl/+2ETvz+lwEhizLw7XUsKpGRM3GmGtS18N0l1oR/7NshALY?=
 =?iso-8859-1?Q?brvs+OrRiwSx4pA8AU9Q74br1EoAzjYqAMH+PZKq/xE/S7ksjoMA8K9oNl?=
 =?iso-8859-1?Q?0eyblB69QIdjBRWarYvQ5SGIaB99Vkm3TTynyqgEZkFgJjZs1PFJ7ivrrW?=
 =?iso-8859-1?Q?rGlBvtZG9tibFNwg8nEnhMm6ip2z/1uLweptcyXJptL/Byr/RnxuvUU/KR?=
 =?iso-8859-1?Q?7AL/h8AgahcEfj3D4FjlzCH76VqxkTyQmYrbJ6Da0ihoY/SeXSxT/l1kGo?=
 =?iso-8859-1?Q?jt8K0mKRgEIUrrBdfXE06p3ArbVqriW0AindpolfF/dfzG/ic+wPkrXaPW?=
 =?iso-8859-1?Q?DGMsnBmx4H/Psh77d/ica5bR+hJErfskO9Wnhise5ejDJyE0OzSac3ABd9?=
 =?iso-8859-1?Q?doFow7DFXYJJJntgbmNK75rHO/1WsTUz+rNnNiZ6DIz8u4hzitsmRvQWms?=
 =?iso-8859-1?Q?1GiH6TO2vw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: z85DHMeFtoJ1FvXBeGlPPsT4hQO7nrFjiZCi7aAXV5Oa+1LC9TQnstRV7SRIvCq2ltyj6X4m+xdGOsetJeXaRFBt7OPMLBQVl6ZD42CT5qttgmY/LEv6YUAVvHXx3Iy2AQPpknMZU15kZxxZKNnstAgkpzlXULZPyIXZr1GRuIo9HCjc8ddz0V/vYCsI94fEpTA6ccNIuFl3OxnZJdw2oSpKH0aGuV5ya2W2RXcpum2/H+fSrRlamAxMVj5OI6OsAYK2GRZk1kgzpHQdiijVAWn5qmCOsebDD6P/boTctk912zgrUu40XXyCTBFhtGsymd9+4Gv3JbU0bgzvQH1TUw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39bb7e2-18e2-4f2a-b2ba-08df0898186b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 02:15:44.1869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6rZ1rryzEEFEVMxF8xNbUMhuLoI3bZnZSWDxqW+Nbf0fGQrc8Wn/W838FVyxh6rfhj6Ff9w0PzKiAfDyytltL5pfY0SOirVHkMdkmvLIoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5782
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

The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one=0A=
control endpoint and four programmable endpoints.=0A=
=0A=
Add the controller as a sysbus (system) device: the MMIO register map=0A=
described with the registerfields macros, the interrupt line and the=0A=
soft reset. This is only the register/system side.=0A=
=0A=
Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).=
=0A=
It is not the gadget USB device (TYPE_ASPEED_UDC_GADGET) that a host=0A=
controller enumerates, which is added in the next patch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |  49 ++++++++=0A=
 hw/usb/aspeed-udc.c         | 236 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/usb/Kconfig              |   3 +=0A=
 hw/usb/meson.build          |   1 +=0A=
 hw/usb/trace-events         |   7 ++=0A=
 6 files changed, 297 insertions(+)=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
new file mode 100644=0A=
index 0000000000..58fed5f9a2=0A=
--- /dev/null=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -0,0 +1,49 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_USB_ASPEED_UDC_H=0A=
+#define HW_USB_ASPEED_UDC_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_ASPEED_UDC "aspeed.udc"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=0A=
+=0A=
+/*=0A=
+ * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
+ * per programmable endpoint from 0x200.=0A=
+ */=0A=
+#define ASPEED_UDC_MEM_SIZE     0x300=0A=
+#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)=0A=
+#define ASPEED_UDC_EP_REG_BASE  0x200=0A=
+#define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)=0A=
+=0A=
+/*=0A=
+ * EP0 (control) is served through the root registers (UDC_EP0_*), so only=
=0A=
+ * the 4 programmable endpoints get their own register bank / ep[] entry.=
=0A=
+ */=0A=
+#define ASPEED_UDC_NUM_EP   4=0A=
+=0A=
+typedef struct AspeedUDCEP {=0A=
+    MemoryRegion mr;=0A=
+    uint32_t regs[ASPEED_UDC_EP_NR_REGS];=0A=
+    int index;=0A=
+} AspeedUDCEP;=0A=
+=0A=
+struct AspeedUDCState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion udc_container;=0A=
+    MemoryRegion root_mr;=0A=
+    uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
+    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
+    qemu_irq irq;=0A=
+};=0A=
+=0A=
+#endif /* HW_USB_ASPEED_UDC_H */=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
new file mode 100644=0A=
index 0000000000..cd773e979b=0A=
--- /dev/null=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -0,0 +1,236 @@=0A=
+/*=0A=
+ * ASPEED USB Device Controller (UDC)=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Models the ASPEED USB Device Controller (UDC). It implements one contro=
l=0A=
+ * endpoint (EP0) and 4 programmable endpoints.=0A=
+ *=0A=
+ * This file is the system-bus side of the controller: the MMIO register m=
ap,=0A=
+ * the interrupt and the soft reset. The gadget USB device presented to a =
host=0A=
+ * controller (and the endpoint data path) is added on top of this.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "qemu/module.h"=0A=
+#include "trace.h"=0A=
+=0A=
+/* Root / Global registers (offset from the controller base) */=0A=
+REG32(UDC_FUNC_CTRL, 0x00)=0A=
+    FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)=0A=
+REG32(UDC_IER, 0x08)=0A=
+REG32(UDC_ISR, 0x0C)=0A=
+    FIELD(UDC_ISR, EP_POOL_ACK,            16, 1)=0A=
+    FIELD(UDC_ISR, BUS_RESET,               6, 1)=0A=
+    FIELD(UDC_ISR, EP0_IN_ACK,              3, 1)=0A=
+    FIELD(UDC_ISR, EP0_OUT_ACK,             1, 1)=0A=
+    FIELD(UDC_ISR, EP0_SETUP,               0, 1)=0A=
+REG32(UDC_EP_ACK_IER, 0x10)=0A=
+REG32(UDC_EP_NAK_IER, 0x14)=0A=
+REG32(UDC_EP_ACK_ISR, 0x18)=0A=
+REG32(UDC_EP_NAK_ISR, 0x1C)=0A=
+REG32(UDC_DEV_RESET, 0x20)=0A=
+    FIELD(UDC_DEV_RESET, EP_POOL,           9, 1)=0A=
+    FIELD(UDC_DEV_RESET, DMA,               8, 1)=0A=
+    FIELD(UDC_DEV_RESET, ROOT,              0, 1)=0A=
+REG32(UDC_STS, 0x24)=0A=
+    FIELD(UDC_STS, HIGHSPEED,              27, 1)=0A=
+REG32(UDC_EP0_CTRL, 0x30)=0A=
+    FIELD(UDC_EP0_CTRL, RX_LEN,            16, 7)=0A=
+    FIELD(UDC_EP0_CTRL, TX_LEN,             8, 7)=0A=
+    FIELD(UDC_EP0_CTRL, RX_RDY,             2, 1)=0A=
+    FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)=0A=
+    FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
+REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
+/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
+REG32(UDC_SETUP0, 0x80)=0A=
+REG32(UDC_SETUP1, 0x84)=0A=
+=0A=
+/* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
+REG32(EP_CONFIG, 0x00)=0A=
+    FIELD(EP_CONFIG, MAX_PKT,              16, 10)=0A=
+    FIELD(EP_CONFIG, EP_NUM,                8, 4)=0A=
+    FIELD(EP_CONFIG, DIR_OUT,               4, 1)=0A=
+    FIELD(EP_CONFIG, ENABLE,                0, 1)=0A=
+REG32(EP_DMA_CTRL, 0x04)=0A=
+    FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
+    FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
+REG32(EP_DMA_BUFF, 0x08)=0A=
+REG32(EP_DMA_STS, 0x0C)=0A=
+    FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)=0A=
+    FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
+    FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
+=0A=
+static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
+{=0A=
+    bool level;=0A=
+=0A=
+    level =3D (s->regs[R_UDC_ISR] & s->regs[R_UDC_IER]) ||=0A=
+            (s->regs[R_UDC_EP_ACK_ISR] & s->regs[R_UDC_EP_ACK_IER]) ||=0A=
+            (s->regs[R_UDC_EP_NAK_ISR] & s->regs[R_UDC_EP_NAK_IER]);=0A=
+=0A=
+    trace_aspeed_udc_irq(s->regs[R_UDC_ISR], s->regs[R_UDC_IER], level);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size=
)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val;=0A=
+=0A=
+    val =3D s->regs[reg];=0A=
+    trace_aspeed_udc_read(offset, val);=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,=
=0A=
+                             unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
+=0A=
+    trace_aspeed_udc_write(offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_UDC_IER:=0A=
+    case R_UDC_EP_ACK_IER:=0A=
+    case R_UDC_EP_NAK_IER:=0A=
+        s->regs[reg] =3D val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    case R_UDC_ISR:=0A=
+    case R_UDC_EP_ACK_ISR:=0A=
+    case R_UDC_EP_NAK_ISR:=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
+    .read =3D aspeed_udc_read,=0A=
+    .write =3D aspeed_udc_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val;=0A=
+=0A=
+    val =3D e->regs[reg];=0A=
+    trace_aspeed_udc_ep_read(e->index, offset, val);=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data=
,=0A=
+                                unsigned size)=0A=
+{=0A=
+    AspeedUDCEP *e =3D opaque;=0A=
+    uint32_t reg =3D offset >> 2;=0A=
+=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
+    e->regs[reg] =3D data;=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
+    .read =3D aspeed_udc_ep_read,=0A=
+    .write =3D aspeed_udc_ep_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+    .impl =3D {=0A=
+        .min_access_size =3D 4,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
+static void aspeed_udc_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(obj);=0A=
+    int i;=0A=
+=0A=
+    memset(s->regs, 0, sizeof(s->regs));=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
+    }=0A=
+=0A=
+    /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
+    s->regs[R_UDC_DEV_RESET] =3D (R_UDC_DEV_RESET_ROOT_MASK |=0A=
+                                R_UDC_DEV_RESET_DMA_MASK |=0A=
+                                R_UDC_DEV_RESET_EP_POOL_MASK);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(dev);=0A=
+    int i;=0A=
+=0A=
+    memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,=0A=
+                       ASPEED_UDC_MEM_SIZE);=0A=
+    memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,=0A=
+                          TYPE_ASPEED_UDC ".root",=0A=
+                          ASPEED_UDC_ROOT_NR_REGS << 2);=0A=
+    memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);=0A=
+=0A=
+    /* Each programmable endpoint has its own register bank */=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
+=0A=
+        s->ep[i].index =3D i;=0A=
+        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,=
=0A=
+                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2)=
;=0A=
+        memory_region_add_subregion(&s->udc_container,=0A=
+                                    ASPEED_UDC_EP_REG_BASE +=0A=
+                                    i * (ASPEED_UDC_EP_NR_REGS << 2),=0A=
+                                    &s->ep[i].mr);=0A=
+    }=0A=
+=0A=
+    sysbus_init_mmio(sbd, &s->udc_container);=0A=
+    sysbus_init_irq(sbd, &s->irq);=0A=
+}=0A=
+=0A=
+static void aspeed_udc_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED USB Device Controller";=0A=
+    dc->realize =3D aspeed_udc_realize;=0A=
+    rc->phases.hold =3D aspeed_udc_reset_hold;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_udc_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_UDC,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedUDCState),=0A=
+        .class_init    =3D aspeed_udc_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(aspeed_udc_types)=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 260d2f0751..146ed1a0be 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -536,6 +536,7 @@ config ASPEED_SOC=0A=
     imply GENERIC_LOADER=0A=
     imply PCI_DEVICES=0A=
     imply E1000E_PCI_EXPRESS=0A=
+    select ASPEED_UDC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig=0A=
index de95686720..e4df15fe7c 100644=0A=
--- a/hw/usb/Kconfig=0A=
+++ b/hw/usb/Kconfig=0A=
@@ -146,3 +146,6 @@ config XLNX_USB_SUBSYS=0A=
 config USB_CHIPIDEA=0A=
     bool=0A=
     select USB_EHCI_SYSBUS=0A=
+=0A=
+config ASPEED_UDC=0A=
+    bool=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index ba55c28ef6..d4ba60a91c 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -27,6 +27,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files=
('hcd-xhci-nec.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))=0A=
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))=
=0A=
+system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))=
=0A=
 =0A=
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))=
=0A=
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c=
'))=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 67249d69c2..ed05304520 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -377,3 +377,10 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_l=
en) "ep %d len %d"=0A=
 canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"=0A=
 canokey_realize(void)=0A=
 canokey_unrealize(void)=0A=
+=0A=
+# aspeed-udc.c=0A=
+aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " val=
ue 0x%x"=0A=
+aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
+aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
+aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
+aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x,=
 level %d"=0A=
-- =0A=
2.53.0=0A=

