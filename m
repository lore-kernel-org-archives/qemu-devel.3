Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767DFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbPN-0001sV-Qc; Tue, 28 Apr 2026 01:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHbNg-0001ZC-Oo; Tue, 28 Apr 2026 01:53:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHbNd-0002G9-KE; Tue, 28 Apr 2026 01:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxHKz1aqOow73/ndwk9Ewd5IAg2BkZ8bq+u0Nl8AA5MdsT9oN/jAcF10/PLHcW7Q0RDTOdUvGf99fCi8PPC9721zba64GeaA13nvbSeWpx5gvxasSGr1yonf2Y+yt+7LeYP2Ke7s8Y9r5yPfK35FMB6Y2FNSWLIvaLX9cojft3azug1w0CZs+tT9xHdmjSehak+F/KnjG2NcWkPmKTrk5RTlMD6GAWJqAzGfYVo6DtsAf9b2qNB2zWjAVa/Fj7BOc700YIXaskBoFPaFNtcDIJDs5cQu8Wik3ZRy8pI1D53GqEo+SujvhHy1PozlGvDepCJ5k0y94/Sr2FOtbP4LHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8qblrHi+XZYcgcuozYGykKoHPUFypGVq5jG5uqnmjA=;
 b=Zg7yrj0AeqFQGnL/4MWPDZkKeoQCURJaY8iI0u9LFToeD7djyNaGf19HNHW/k+mZQXrdHQaHsBkTIpJAX/wVROlzUORouJydZWTlZth/B6PBD3tCYn5Ik9juDqbwl20DiPXnNwKqN2203d7ZOhQdgyN/TDJ1h7k/a/yFcq7GXYULVDBwe5c0KuC7KCwWWhYvoL4wz6qEl8HhHlXkmTvINAkYVD2QYdTEUzNoqOJnKGOaduh9UQeOk58Ci0zuQJvRwZlpB7sBVHoPlBiYzr7SzJxGfvaE+pPGR4YOGZ2qZXNqBDZZ3sAOrxiAQZZPvrcIX4w7kCy93SdodmYBO9LP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8qblrHi+XZYcgcuozYGykKoHPUFypGVq5jG5uqnmjA=;
 b=L6QKbt1CT7qlTiHJQnx2uDSdiQG2claByzS0su0O6V2gvHcV7CtpwoFAnIbekarA490A891blNdUVaNDHjtm0dWkqn5Eh6mw8x+xTbi1mKAx333AB5BVtHL+Med60S0TynEU0CmyS3OAP/v7ougBjAAW+ooYNkZxnT97VC4WvNw169xat3f/K0Wd0HJAPZ4uAhOv0UTp6dUJEhhckHxukv4XJLD6+MGnaDNxBT9GMnax+0ZSqIqiVJTlfVxJIVjnsHaM55/BEgwiLoyiaJueVympU62n9mtML64Q+1mOMJmbUrxFFM43dihoY69f2RlLSHJynZX23b84NATyNA/4Tg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6073.apcprd06.prod.outlook.com (2603:1096:400:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Tue, 28 Apr
 2026 05:52:56 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 05:52:56 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP write
 operations
Thread-Topic: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
Thread-Index: AQHc1tNDVtPV7xe+NUODvFad+2Zigg==
Date: Tue, 28 Apr 2026 05:52:56 +0000
Message-ID: <20260428055254.76581-2-kane_chen@aspeedtech.com>
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260428055254.76581-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6073:EE_
x-ms-office365-filtering-correlation-id: 67ee702a-eb21-47c8-b80c-08dea4ea658f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 9R/VPb0hjeOIoa58H2DoJupVMZGNWcAT7w6u9hDToxmkNr41gdyBQgdMAiRp3CZjDAwi4FaaZr1wwG9q5/z+LoDNOkOf9D7GUtf2mrpeJoBMjm1ORmwpH2CqQqDs6k2YntWstp8xZaJIwG/MEwYQ+94sEhyVA4+eACTVDPJzk+mAA7nDkpk9vku7fS6vLT7Fx7sKRPoa4x6qIaCjvRxKkAtUYujFAVEuSvBiGBTrGN9k0X6dLn/zIhL9bAauwaMrowF0PFdHmF3uTORqGuuXAAlQgTWitp45b0ADmfh3XpaRU4lz+KqC0XNPdcgf18mJmYh5F/1kPYLp8sWu3GGhCfatsehaiybp5JcQ2u144Bmt6ATwZo2zvfj/FpVtgN7t4wEqQXhnoCSlekRB8eLg4HzrXYFViFfj+bkjEr7yXbZYmSgDbmCJLCWirKhMYiBz969PgtGT88mev0RYs0lKUf5dv76s98pynePywy9cHXiX4rUS2YRJ+LBafbKpJ4gsuqPRSKYR1hzWHQySrUlVnPfhrE0ug9CIX0SuoVC1ZdX8GcWu1D+M7202V8Sgr1SxgF9U9nSK1QWuXnqxpPLybK7kJ0PpdHLuCbC280ieNU3KlattJNbTrFuIjrqBH41+ENm5T7lJAAttUbk6O6XqdJ7ME9XNSN3HLvnl1UYesgy4x7pjSEXlAT/HXno7m88gT+Cukx6rBatGSbKFcs2SaubZm1Re8SjIo64Jss+ew8PKJmxLRTYhbWxirERsm0ReKG1ShH3ff39bjTGhXwbGloCqNaAKvvE/VTlG3+D9aZo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KGgke/tJsMdkC/3glT1QY/+TBeU5dXKWY1WM91CClSW5g0lSpYCGCk0HdO?=
 =?iso-8859-1?Q?FOs0yX6STpVx2G/YDlqjS5pNJSX30m0Dt/3lnxdd2Ivq42EShYG9fnV3B9?=
 =?iso-8859-1?Q?OtpVgn3N0k1W5JmwrhBThBNIo9tmsEVQNR1akzOzE4UWFcdJKhSg5yVjoD?=
 =?iso-8859-1?Q?Ms6ZJk8uzgEDfKzT9tSpCjsC1JQpnscIVdk8eFDa5FQQuDvWmIdh+QP5uF?=
 =?iso-8859-1?Q?LrBMtyapaqYb/S92ERl+o/thpwm9hI7k2n0hSYtkLTynNAefz5e0hNd/W1?=
 =?iso-8859-1?Q?33eY6cjGxHNkWa4RLGjcUc2RNB0wLtDjuOQbn6s9MAI2/2JaWTq0GgRlD/?=
 =?iso-8859-1?Q?hp6FEt8p5xBc7PYIV/vvmrbE7lzwfb3vWJw9Y+00J6bjk/cppLBHG7ho5N?=
 =?iso-8859-1?Q?I08lK0FESF+GqYnYZ4aJ2Caxg3Ditlpgie3pjA4fVnuna0AKE8DDw+jkUA?=
 =?iso-8859-1?Q?0ynlkXW/YdSVnfn+0cuw4+uPPW8aYisC/J757KTbLaOEbJ+arwN6aMeeJ3?=
 =?iso-8859-1?Q?NPcjb1+lF2WY7W0Ae+OUm61gaCE4o1eTcKEz6PBS1YMmHcjBX4MPxKPKvT?=
 =?iso-8859-1?Q?MuZ6LUuKQFuQodadFJPi6UYlvWv3VFBO9+J4hh5GWOi8Dx4qhBrwU3ZvF1?=
 =?iso-8859-1?Q?oDgt/xjeT7zXU2GEhPK3/9b7sX/1ycFhbyd6JwN+3RNDMY1wuQZIMakeXx?=
 =?iso-8859-1?Q?nZgS3AGSxVkYdcGEOQQmDGSlaEXIgYXPKd535VUfcdneVZuDba3lLJW41R?=
 =?iso-8859-1?Q?wPhobQG6AyOatFxHd/Xzgnd35yyZU6Fr37+W2fS+UOTI02x7ie8qVmOwuo?=
 =?iso-8859-1?Q?goEEUttW4FglZbmB9pnZuvP0XqR4+Lni0NGY3QnVtH/fNWzOfeB6bfO+9Z?=
 =?iso-8859-1?Q?fNNZylZDauX2RLQQlOW3e5cVjdk/gBdfaPNpZ2ne5PNGHcW7lwaaW0bD53?=
 =?iso-8859-1?Q?qyRTViN3jMJXhL4bGC/ji0ol8NyJDmjysbwpWS+OhhiJuFnh9OuYLWxqVI?=
 =?iso-8859-1?Q?l7PJZJct6Du1wDxfjTo1m8qagyGiKMq1/3VsQ//p9NjcB6SmoYMdu6ObpK?=
 =?iso-8859-1?Q?hDK0UuD9wZKecoSiqOcG+aYpM/Iw13w7tD5tEqmLrQUHOxr5QzLTid6+G1?=
 =?iso-8859-1?Q?bZW8CBWqfARHVw/2xgSHUWWGyNbsxwZhDLqy5TNC/raJGYzEMBA/p7JCHz?=
 =?iso-8859-1?Q?zhqi7bwTI9IopTD24VzTSYUO1Qc+U1DiR7BpAYq8sA+8yq9vBaNntAfB2J?=
 =?iso-8859-1?Q?THRscRaDjmPNxlhSj/zEF6ZVWjVc3fVG+nZNQrPZVN5Q+pWGJJFqwxvtrw?=
 =?iso-8859-1?Q?Ajsc61S6t7HVtTqmUhmq+9/OqrqY+MOCRmw/cObxBvvx4sDCBdkWN7++ji?=
 =?iso-8859-1?Q?wavRnUpaevuvfO8tIj0bFUukH0xLTVKyEgIIBj+q35NJ+t0pqvogqBALnv?=
 =?iso-8859-1?Q?PMpEeh61PFgmvEpOGo8FcWKTG6iXovNZd1uWeUUd9ul0OUPjQu4PStz0eC?=
 =?iso-8859-1?Q?oz5rfH2VO41ebNwQAr7qVNN8KOhr8QBm+YjNvQ7z56izta9VIqWIj7PnrT?=
 =?iso-8859-1?Q?QJ8vaZxFL+HDarFtnoH/77cdBhVaSP3FoZtKX5ozq6Hl8Vv5K/cXG8aQ46?=
 =?iso-8859-1?Q?3bgzuFF63dDCJiZZKG8/W3sWR6YUv6h1Q+2EuqIwQtElyCTPVlph1AzkEF?=
 =?iso-8859-1?Q?muN79Z1xpB8B0liQU7sYXcsrPsHJLbbYsHb0mcxpiJVwdQm0+a4PG6Edv7?=
 =?iso-8859-1?Q?hbpVaHRtiG0Vzaxk13mDIg0sezaBphexH5MkcNpjMMqNq1hySoYttbQP0I?=
 =?iso-8859-1?Q?h0oVM/bHcA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UgmDgvGGQ69AJjEWFijBNH7gNwrmGYw3FU0va4FZZ5K/9Kh3jHjpe7UUtf7Quq4yate+zdFEkwgFVbLw4F/hClmwvqF+l/DM6el5i7WhOgedA/Ksj45ZD9fOJvEhg9KW9BRgPSw6NdWWf2MSB5rRJjhWO9FIF4xBVOJQmcVktDBgS77QULLS8w2Q/2ooH3RTNYEH5UT7HKGces+6kTT/4CWhJXyHFySMBhgDpsOCo5UuDj8XrK4Zd63Ig6uk+cAnJAg7PvX7Q6gSeW0FC8Ev3CbgP1QohwqP5pWZNN6RKQync4Uh6mVWmKWTk0hJwbwJKdQEQsZFUcEyGeoTf66yOg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ee702a-eb21-47c8-b80c-08dea4ea658f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 05:52:56.6367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kch+5CpIF9NAPqTDxB54lWqyURlS8CqnKXT65aRWVIYtZHARDy0snWjLY/OVDs+0/KbwIXQFdUZo5UhFa3vY5iXLCfJzf2wRM40cXIdZRN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6073
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

There is a mismatch between the Aspeed OTP model and the Aspeed SBC=0A=
model in how the guest-provided address is handled.=0A=
aspeed_sbc_otp_prog() passes a word-indexed address directly=0A=
to address_space_write() without converting it to a byte offset,=0A=
whereas aspeed_otp_write() expects a byte offset and applies an=0A=
additional shift (otp_addr << 2). This double-shift confusion means=0A=
that an out-of-range word address can lead to a write beyond the=0A=
allocated storage.=0A=
=0A=
Fix this by adding bounds checking on the word offset before=0A=
converting to byte offset and passing to address_space_write().=0A=
This matches the existing bounds check in aspeed_sbc_otp_read().=0A=
=0A=
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Cc: qemu-stable@nongnu.org=0A=
Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model")=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436=0A=
Reported-by: Peter Maydell <peter.maydell@linaro.org>=0A=
Signed-off-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sbc.c  | 14 +++++++++++---=0A=
 hw/nvram/aspeed_otp.c | 13 ++++++-------=0A=
 2 files changed, 17 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 065e822e70..8b74dca13c 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,=0A=
     MemTxResult ret;=0A=
     AspeedOTPState *otp =3D &s->otp;=0A=
     uint32_t value =3D s->regs[R_CAMP1];=0A=
+    uint32_t otp_offset =3D otp_addr << 2;=0A=
 =0A=
-    ret =3D address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED=
,=0A=
-                        &value, sizeof(value));=0A=
+    if (otp_addr >=3D OTP_TOTAL_DWORD_COUNT) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "Invalid OTP addr 0x%x\n",=0A=
+                      otp_addr);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    ret =3D address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFI=
ED,=0A=
+                              &value, sizeof(value));=0A=
     if (ret !=3D MEMTX_OK) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "Failed to write OTP memory, addr =3D %x\n",=0A=
-                      otp_addr);=0A=
+                      otp_offset);=0A=
         return false;=0A=
     }=0A=
 =0A=
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c=0A=
index a60289000c..1a9d3841b8 100644=0A=
--- a/hw/nvram/aspeed_otp.c=0A=
+++ b/hw/nvram/aspeed_otp.c=0A=
@@ -57,12 +57,12 @@ static bool valid_program_data(uint32_t otp_addr,=0A=
     return has_programmable_bits !=3D 0;=0A=
 }=0A=
 =0A=
-static bool program_otpmem_data(void *opaque, uint32_t otp_addr,=0A=
+static bool program_otpmem_data(void *opaque, hwaddr otp_offset,=0A=
                              uint32_t prog_bit, uint32_t *value)=0A=
 {=0A=
     AspeedOTPState *s =3D opaque;=0A=
+    uint32_t otp_addr =3D otp_offset >> 2;=0A=
     bool is_odd =3D otp_addr & 1;=0A=
-    uint32_t otp_offset =3D otp_addr << 2;=0A=
 =0A=
     memcpy(value, s->storage + otp_offset, sizeof(uint32_t));=0A=
 =0A=
@@ -79,26 +79,25 @@ static bool program_otpmem_data(void *opaque, uint32_t =
otp_addr,=0A=
     return true;=0A=
 }=0A=
 =0A=
-static void aspeed_otp_write(void *opaque, hwaddr otp_addr,=0A=
+static void aspeed_otp_write(void *opaque, hwaddr otp_offset,=0A=
                                 uint64_t val, unsigned size)=0A=
 {=0A=
     AspeedOTPState *s =3D opaque;=0A=
-    uint32_t otp_offset, value;=0A=
+    uint32_t value;=0A=
 =0A=
-    if (!program_otpmem_data(s, otp_addr, val, &value)) {=0A=
+    if (!program_otpmem_data(s, otp_offset, val, &value)) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to program data, value =3D %x, bit =3D %=
"PRIx64"\n",=0A=
                       __func__, value, val);=0A=
         return;=0A=
     }=0A=
 =0A=
-    otp_offset =3D otp_addr << 2;=0A=
     memcpy(s->storage + otp_offset, &value, size);=0A=
 =0A=
     if (s->blk) {=0A=
         if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                          "%s: Failed to write %x to %x\n",=0A=
+                          "%s: Failed to write %x to %"HWADDR_PRIx"\n",=0A=
                           __func__, value, otp_offset);=0A=
 =0A=
             return;=0A=
-- =0A=
2.43.0=0A=

