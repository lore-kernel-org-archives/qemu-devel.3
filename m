Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93920FAD40F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSH-0007Rh-Eq; Thu, 23 Apr 2026 01:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSD-0007P4-L8; Thu, 23 Apr 2026 01:18:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSC-0003DU-4n; Thu, 23 Apr 2026 01:18:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgejRMg5H4+DitI02EFUPkaS7SNA8a2QysHU5gH2MdKUC989d/kCf0kfN6BTxejrwb2OADFX9XlDbxJX+M6rsNbv624H6sr+abd9P7D+VMpljCMgztDzunLxCZCUndGDNnKJmUi3BsTGMnaV712ovm+RYqERmPaNRZGkr0mWYEJ07ZQsrdyMi+/g1V3aAuMgrsh0RNnOVoPNmWy43Ep6BojNIR8O7YPfcyZcKLQc5r3LLhXqloQrKHFbLJofQW74svHKguL4k8Sh5ICRKIvLg7QBkMz42Av1qmRvGaUcgx2nDiq0N+kTOpYxUJg0f4NJIzsQJ01iKqbXkdZF3x/dTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMKQRCZFc7RPoBQ8nUjV37mdC7POgSgSdSqK+Fbow1A=;
 b=vrG12fwau2+jCjN4RVVAjY6itb7iItFkv/8GaU3zmQwRT1dwZ/pxYaZofbKYu1gkCA1GgVjr07pFLElwb06qpGFAr/T3unByPT/Fk5kvH/xErlmbe3DHI/VXgLij+QyFqIYvSFzur0P8sAjkglFB1pcKTeb7E5k+bEcFDX0FeQAyrsTLVzaVlPFqg2wOtp6fKum22b9Mzz37uMNnhLQ6xvzY0fzozPpXqMltuAjqYMZpb1kxUdj3HRFt1kiF1OYTBAiHRQLVOYN0x3m7ehTqcpfalQiZeraF3KR5PMQsSH3tW5CpsIW1GzsR5jv8937NKrK92QNDWUBe41QtEytpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMKQRCZFc7RPoBQ8nUjV37mdC7POgSgSdSqK+Fbow1A=;
 b=CH6wzL9OGlGwRHQm3dpg1XWz1W8GS+I5tpnL8X6xYNzIYCPiyEt/dCMbDmtTR7+UYttxQPZOLmVUp5wZFO3zhCGyiPhkfo+tu/h5aSdzUNWcvh63ZFR6ZsY1K/3Js+aXnK/AYfUA1Tbzwjm5TI0pokenu6IrtlVTpIf0AHGud69LChLv74IbAyzTGcwQ3iJtyAP06/ot0J0UjIv3Ny45tRwM9wSBlKj6QlCTcmtC17z/vtoRJrWXUYyka4uxmjU65zsMDO34LgJ4REUAhW8y9E0ugPKLUi/APcwjdhThMn+NmZdOvQ2geXuyR40S5BMfKdRv/JgWQkeUk/LO9VxfbA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 03/17] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v4 03/17] hw/usb/hcd-ehci.h: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHc0uCSq+C1t3IQL0SrvoLxYcxPKA==
Date: Thu, 23 Apr 2026 05:18:09 +0000
Message-ID: <20260423051804.362095-4-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 6fa7d501-69df-4bcd-824e-08dea0f7b553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ZAfBDQ1q3f1SgoubKWWK/sgKjs20MB0E2MBWmQ6wYEyCIUPOClyiBEQokCC3vVeFNtnlO6n/42cnkKG3Ba5uekLnNSGPkM8vgs8W7Zccqt/V8wrGzKyPMSJ1xaXhJKascYnsTJVpIDGLCTUkTiRozm7BEtZCkCIjNmNUREEetlcMgFgiuz+mxmI6aHZY6VkNwyYwHqKcJOTnwEofBuW14SDitJ+XOKvKNSZef/SHtWH8az7JStw4iibxrU5LJiPR+FXsQdKcfiN5oI5buINQe7AtAtKO2mYwK6WjfbuXJ/I3u25opbGDM6RjXqrXTnipKd/2qTrDUUN7J9kc6ti6XQgwsY7ekwCRvYNiOPtqPFebWqeUfHuaNOoO8RVNc4r2P1R483moSFHVBOQNNKbdL9CF7e6E4lhYZqOQWlwDT7JrqzSv/AtmpqPqrG2Jovp1FuatNbvqMGC+yTtsaL9RVwiPHZYT2PwqSVfmcX0nE5tTnAq891Ajwy+VDviq9ldlKpFDlKtK2NpBaJkEHj7HGOBGOE3Tc444qSr47E5mFCxun6e3zo/nvznjrFc2tbC6JxDWt6xRivfcrv8T6YW5SPKgTTgLlmURplIl+b4yZBLbAdOc1hcuAFNJUTOA5bDviA1aKmsOYZBxTvfowCdwE2//1S7wFzsrprntpn4eY4h2NHiDqRcwkcyxcjhNS1Kp2UuTBor21Vso+x/wNPxhJuyophsMZHvR6B3QoMlH/31yGu29suouu7OMSKwgniATIbHxv9okQIGCuvjT8vpHoBpmYy/JGoe8wn7cdgxOXT03GOjprYPUuuXdN3EUG8oU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H0IjFF2AF1PcgsQBRPn45+PFUc5n8YaS59vU2WQt8f7GROPwqO4JI91N5w?=
 =?iso-8859-1?Q?Xq1EevRhgSK+YMjeKOLXT52bde8/2Nj8rkn0H9Y+y6OlH8at88o/BCK9YI?=
 =?iso-8859-1?Q?z7l1bM3duBETpqm8ErGy31SZBNubH8ZTMbqr1xLqLHC50RNpJty5u/1FoZ?=
 =?iso-8859-1?Q?C3dEn4JzRR9xjz/L6IWDW9rN3ATwe4TASa12sfQxP6f7PWpPIax3QdjV0V?=
 =?iso-8859-1?Q?0JgaHmKpi7zkZ/FvOLIaUhKH81fajb0+RsaZHGMy60/+//3C7j4ASct/7c?=
 =?iso-8859-1?Q?o7p3dznsLxuZUCVHSI0m9a162ZCD2K/93aanZ6omzIxiGlAsU8BKtJXivC?=
 =?iso-8859-1?Q?vcpZqOwtieKJiDm8u+Ta1JxdPWAlvtDfGLSN80ToGcxSxfH5K+yAtbRSQ4?=
 =?iso-8859-1?Q?073EqEqjUSrLHHqGgcsqjzRHpojtXnCHxGqGsOIKpKgpomxktx4YlEsaVN?=
 =?iso-8859-1?Q?Uxw0Z+bGqpgzacJja5B6SSqsVp/e41SDT34atJc64opdLh1HgwvPWWJTyA?=
 =?iso-8859-1?Q?tfH3EZFc78rXaPQYDKWlFzsELPLAo9BlN+R4wV4tnT5n5cvKLhrqUgx+9L?=
 =?iso-8859-1?Q?b2oNB7hOddScRY9GAVTT4yalhVqahfdqXL/GZBnrjjNYOBGvVXrrEROpgi?=
 =?iso-8859-1?Q?UEN5v7n7/J+dNLnKyGK94P4yA3hkIzFSuxzgrfFq5WOaEojgGhashcg/2j?=
 =?iso-8859-1?Q?FlHQW2qVmUT66VSM1+sVasjaxzbDGZV7VO9U08MaRbOCgNcXGhxo9DCbKA?=
 =?iso-8859-1?Q?bsfRzDPl6M1Wsp8l7aRaEUp3euE3USBQjJWNtGSeVZCbunzPdwX73ItUdl?=
 =?iso-8859-1?Q?P9gkFocpZaKUEoM9HpnxFtXt/EhF9CQ1aSDvj/Sx85EePX43aJSuwaNcHV?=
 =?iso-8859-1?Q?U0c/H8oksftz/burt9veaGLvzqYVA4BjLnwkV8efa4Mv0LI7ssQZyGC7tZ?=
 =?iso-8859-1?Q?pG1nNCVJwQQqgMXOUYRew48bbjIsCGx7poQ7ipkDRv09JXGwbtXpekCEq4?=
 =?iso-8859-1?Q?4Nqf8MV0YR1KDoyiB2iB0FDkd8YiO6LSojxVJhyIiy1Ps9e6XKUNtGwJTJ?=
 =?iso-8859-1?Q?qBO6cXUAhbir7cvEUCqU9xVl8Rprn8vnL/jWif4TfBFEfHaMiVrveb25yh?=
 =?iso-8859-1?Q?TisfNLBMTE0iaCge/5WGAwDNrdcvyDU8ZxgQh9xxWnLbVdxOiGf5M9oSQT?=
 =?iso-8859-1?Q?mZzw2SgmzzCo35uus7fROCC5AaFdQpPX0ZOn3lqPUcuc93IfPl//zYMBr+?=
 =?iso-8859-1?Q?wNEKaCQScsB7b1XG9eS+g80emB6XkMOjCdOvKy2/hi64t0IIHVzOxHE5V0?=
 =?iso-8859-1?Q?BX6OEqKiGLoAu2YjxXj9lotIYv9I8zJIeSi5gXq+K1JQnk6SOvlHaa8Gxq?=
 =?iso-8859-1?Q?X6ArG4Wdnem8lRV+uTXouoQVYWOSwr86QMlDa3LlVRo4CfLp/uQjyAulpH?=
 =?iso-8859-1?Q?mLjgX9o9XikLZ5EoZh1DUAMFQBar/QYyrpsNexdR+ciKgQqLLoIMOS5nvz?=
 =?iso-8859-1?Q?XbT4LUFkV1JnNSblKtECEFNhle8ChEsZp91r6A5s1WQFUrKdEqqZ/WEQzl?=
 =?iso-8859-1?Q?EFN22AbSZ+tl6st5Cxedqq3QACRafl4d0VNnVj9emwDcxEbQrkHKexGP7W?=
 =?iso-8859-1?Q?+TRnu2PA3fwUDogjossiJayC/zNfqplfYxc97W/0LCbUbdl4xxhLN4LyZV?=
 =?iso-8859-1?Q?zWqQTFEoRNGdiGbjzDsPZ3GMgkKN3Sn85MHjsdSggR3oQVLkFTjksD1D2O?=
 =?iso-8859-1?Q?Pi55kHrv8/76hsf6KzC487elzFJCccNss6fp29edotW9PKhSBx+JPgxyIc?=
 =?iso-8859-1?Q?5EbywmfkGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wSG9oli4A0Ht9ID7msom0r24oI/X77/RW9ezwqmdzkLoWJLLc0HpLJIIO/6kR5e/arIlZlwUU0D2fpw67eF8B6PTjUvyberM7mQrE6tfqigDcq9bM5xCcjh8uBDZRO6k/Cim2E0Temm9CQNxKYZ/+Mr2N01iNmjDKgiqNdFm5nZTrxrFKrFptOZdBGNM923mMM/6Ahq6rCvDIMRNdIeijq+cJeIiruCAylAVgNoUGYjjtk1XCqLke5uwz+uIZxPbiVu5WCaCHa0L75IZnVjLL9bYMW5TyRdF/Mm5x0LRvcynYI0Oltp5DUncFef/87TznOcPEN92ag2sqhnkaojE/A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa7d501-69df-4bcd-824e-08dea0f7b553
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:09.2572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5AWLOW9ePNULN6ps9liVg/7mPva8Zf+9Ud7Yz5sG9zaq/kQmc9VX5CZendxCVdqdpYihqUJbLOnTctDJRxxhCooNNAwForArVTu2tUN0+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 17 +++++++++++------=0A=
 1 file changed, 11 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3aec0e047c..736407fd52 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;=0A=
 typedef struct EHCIQueue EHCIQueue;=0A=
 typedef struct EHCIState EHCIState;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.3=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.3=0A=
  */=0A=
 typedef struct EHCIitd {=0A=
     uint32_t next;=0A=
@@ -74,7 +75,8 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
 } EHCIitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.4=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.4=0A=
  */=0A=
 typedef struct EHCIsitd {=0A=
     uint32_t next;                  /* Standard next link pointer */=0A=
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {=0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
 } EHCIsitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.5=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.5=0A=
  */=0A=
 typedef struct EHCIqtd {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.6=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
 typedef struct EHCIqh {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -230,7 +234,8 @@ struct EHCIQueue {=0A=
     int async;=0A=
     int transact_ctr;=0A=
 =0A=
-    /* cached data from guest - needs to be flushed=0A=
+    /*=0A=
+     * cached data from guest - needs to be flushed=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
@@ -268,7 +273,7 @@ struct EHCIState {=0A=
      */=0A=
     uint8_t caps[CAPA_SIZE];=0A=
     union {=0A=
-        uint32_t opreg[0x44/sizeof(uint32_t)];=0A=
+        uint32_t opreg[0x44 / sizeof(uint32_t)];=0A=
         struct {=0A=
             uint32_t usbcmd;=0A=
             uint32_t usbsts;=0A=
-- =0A=
2.43.0=0A=

