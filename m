Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742B8C79FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4TWp-0001yl-TY; Wed, 09 Sep 2026 21:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TWm-0001xk-DM; Wed, 09 Sep 2026 21:24:36 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TWk-0000wR-5d; Wed, 09 Sep 2026 21:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXwHlYeWDWWSfSD2BZcOytYySm2Qx3M+BjPB+Fq3zNXRaL1lXxbmSMHTdzteBbyZyMg31rue+IE4V1G0Ymsotih3WSs9KD2Ril0spct8qCKnEjILv96lNFs+qtYA8srsrbTe7T4YoQ1C+B6n2sl3nuAKVLQE7wl3GB2GgeFscYSpMZctQVSG4OYPYGu0Wf+UsFTVt7oV8FixR8dc9TivLXtq0ybRDoJCcGwqjaNvy6LCioSHGP351HT7UzjBMrR4ndLqMqE/7CUna7XmcXUzlkzFUVvf07x0mZ8gnVUTXDb+jgKr0Kdiy74hSfBoVMlS2G0a3i+zNNj0D/XQ+bCHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx/Y6RuhK6TTpxPaJY+gHEobJWxN2cMPCO0Db9rbdFk=;
 b=cxtSlD5sqvPfJSDT9Cl1O3oSRi8398gzxx7S2JTv/4JICHN6JdWU02gWGOAe8kG6VPNxNz5/26Iv+b9g777XBpCFvPko8ZMHCnhgr3LObLQZePGBAXhbi24oiiiHMgkYDDopSeYZclk7Z1EyqF1i9W2uVRW3exEzgwVhM/Ibd0+QL8utn/i0iHQN8BGZd6pI9Iikn6eGUEWnW8WH02ldl27+m/g7nd9LqiSabIhehi/isv57w5FUCiEEMv3xnN2tTSeKrRZhscG2X/ZN0Lqit678JITDm9YT4fsW1glF36qAUcJ/WIC9L2SHk1BGBQk9sVl3QPUtQiE4tUHms0isDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx/Y6RuhK6TTpxPaJY+gHEobJWxN2cMPCO0Db9rbdFk=;
 b=UfmEPGLHVXENvE3E3GoRG6fjrGgHVxlfclDyMl/WGPsEENb7AaYPTitH9cMwpa94KjVnwNw7ubSXzHj2E3o2fPfGdjjWk5IPnBSm7My7XxB4HtQPhBbFJyoouwzvIdvvOYrnsaM0QWaTWWIIbxkC01sGmYnrGFnLoYJy1A3EOAjdmD9rGJ1AfC7+ZLDSyPua5gW+xrRJaqn927OxLptrCpT6COtUntUslriph+sjPURIBXFS2q7xeIaJNCjtsRPkr7wrA/EWTlFY2/JhIex7UtCxsyodrvTy6WRfP8UpEVILY8/LBWdQRnW8sOQFGnaNCdTdA+0Dk/aIarewVOv/AA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6255.apcprd06.prod.outlook.com (2603:1096:101:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 01:24:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:24:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] tests/qtest/aspeed-acry: Allocate SRAM buffers on the heap
Thread-Topic: [PATCH v1] tests/qtest/aspeed-acry: Allocate SRAM buffers on the
 heap
Thread-Index: AQHdQMMczpcTcm5yiEaLyQhlWl4pSg==
Date: Thu, 10 Sep 2026 01:24:24 +0000
Message-ID: <20260910012422.4065857-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6255:EE_
x-ms-office365-filtering-correlation-id: 026c6534-2ca5-48f2-678f-08df0eda3f84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: dKdIxCDQYUnJYrg7tT+vAPXop3eMWTcxUPty3RC7XjPPh6zwI7sSbYHoWdd16WojlqF5/SBCf7dM5J9TiR6tJmOWz6GxnrmhCTG1UQ8YW5zluwNaQC1/xsaw5eiLHAxuBGodU4qiyhUJlmQY5IcnyCjFm2o7503P1jh8zoOvtz+FPEcsK5An8RhQG1cPvgCH2KfJHeiukagHum+OejDcx3vzcnRu/V5GFXyTngmE8sJ9U7mbtuHVf503LAIlmJoDgpvKro3QXxE/oacrDA3j/ISQM37h2kC5g/yG67cOj5ns0xuysBoyy5Qr53mYUdx9B7VzLoywUJhvwsSepvgAm73hGQ/DhS9n95Ab5848e2Ey4iMV6+SiENxvRlndCNWrV6l/cA0nJMlARwvE8/w693cfUteeRzyAb5S0o+MEj5kEkYzCGACCMCcEu7Bqz6NAXnl7+aMdyfoEzKNTa8vURPbNQSvvfZvEW/PD52ZKMB/9lInkZ55BQcNPA6mV2HjgrDpYW67VjOPPoGAEkuBtGxjZD2L7vJ0AWxioJv3NcwfPp0gXQC7tYI6BTYf55qr+qA3zsNfLMB/EAUgqdXATvRK5O6FUyDdykH+NXhBw2RRmBSMI/Q5rduGeMNkeyhuvWxXSbvRV81nDPT3qDwDXXm7vaRI/z1taE3IE9zohtoynDdHMC3ZY3ujIGm6NenLdknXCciCVuXi144lqaadPMCuFEXXyAPPQYKd2A/5qwJVQUDBZ6Po+w1TU9lauJ9nO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KttLsKQRXw+VybPrZTwx51unbf3YEeTzW359Hkdod1M05h8zOwJ743t3X6?=
 =?iso-8859-1?Q?bDiyxu4iavTO99ghmWj+XJLAg3C02EAVWnppDAh736mQLDQlAaWe4aeIT4?=
 =?iso-8859-1?Q?jhGp8mG4wRfZdi6XICArEbMkBAV5MEZa7s0XhQ7mLYUk+UsWvek8a1GGX0?=
 =?iso-8859-1?Q?+86BJp/1+1C195tRsLvY2BA9p2EhctxLoZ7L7x9w4uWLRtF4YUVUJYgFAL?=
 =?iso-8859-1?Q?o5MgGFMpSoHaZt2xUZUzH+wxZt3FecOXASh5aSRxydKyfS/fYKUjlYpyl9?=
 =?iso-8859-1?Q?Mc82vJRlbceh/OxNWEdiJJQryOTyVp+i7CIGdXHcQeyP9JAsHXFvox9oLu?=
 =?iso-8859-1?Q?+GRUKgW4N3dYmmO0f9dk90jcPNtJ7K9WPUpgJAxbvR4Z1dyWhaWML2txqg?=
 =?iso-8859-1?Q?+4NEjcImbm+tckgTT4MoCrrVnIda9M8r1qAxhZiqSlqO4VGFYVT9XJT4/l?=
 =?iso-8859-1?Q?ISk7SNt2yb+LmzctUj1i3jHe9ew+TvxJ7FYlROyd5R6twozI3GbU27N91y?=
 =?iso-8859-1?Q?jNH8s+loRDIhnxee6SQ2UF0l5tD4ca6WxEoDbjyxuinsmyKah4N6ix6g93?=
 =?iso-8859-1?Q?/vFb9WRiWdfE7oPFRHt3DsUkV3w0lHBwQ8b0ve64ax46sLTDPibg0GWnSr?=
 =?iso-8859-1?Q?Nijf22gPWhCZ2hZJmenfCns/jQZlfa8eqfw93H+YGht15bkcNMy6KWV6P3?=
 =?iso-8859-1?Q?kpmiqqupMPIBA3C0YQ3NoFjgkVH03wXQZ5nOeoxfLIa+p2GraDkMVr9Dhf?=
 =?iso-8859-1?Q?ZA+Fv5VgixJGxGRgqnRyNfyVvIwhs7oMW4DOedubO0xZZf+wVjBC/j6w28?=
 =?iso-8859-1?Q?+lEFH/QPcGwUR6H4bvEvrpZb9soZlhU2UsgPCMb+DPxQrnT5ahD/CS4zcZ?=
 =?iso-8859-1?Q?oPuOyUeZliy2Z/V5Z/Yk1v4B1AS4seWz0cOk3Y28kGAJ8Ap85og4skmOoa?=
 =?iso-8859-1?Q?MDUln1bfq7TnB5HN+3z0pnh+wgD53oOfcXL4wAc44sA6h0kJhvs7KGhOs6?=
 =?iso-8859-1?Q?MNaydSu6ZtgJxFi6oLddqadCAV8ngYeZclqfQEI/O7PP699VO5eNca7eLB?=
 =?iso-8859-1?Q?IPRL/AnhdXUe6LDmYQcoq924WDCLBH7oks/l7aMsZZq3jKdeIKlEQK+WVX?=
 =?iso-8859-1?Q?Duej7uG3sjN+DjS/DYm5sE4JaIhCDSDz0VpV7Qcrj16KAKn+sDR0vnjBN5?=
 =?iso-8859-1?Q?piUUSr17mcwL3i3PV62jtHfj9+guWco4lulTG1g80vPw+ywgxCT+696HFl?=
 =?iso-8859-1?Q?IG/wjQbO09jC5M5lSawnpPZ6oq7xHlEqICk86pKMvpXDyvMp8NHz8dKonJ?=
 =?iso-8859-1?Q?hoC1T+kY2UYvPN9OXwobHkbih6LPwJnaKHyv1yssPLKQf6ZwPMHFen7/Dc?=
 =?iso-8859-1?Q?b9OpE7HVZa2ZeGcoEDfJHVNwVEdVXlh7bI9Bhcl39/jkFfXmUm3h6c2Epw?=
 =?iso-8859-1?Q?fxOHT4G1YXHPgp29OMKt/2SY3DfD97JuGNVLje/zVIv2UyscIiR47lZm27?=
 =?iso-8859-1?Q?OqSrYGiKo2QHlYcbKON0KUUDBbmwnW/HTq4wfSqHj8JHH+09X8s/JZhfUw?=
 =?iso-8859-1?Q?WXq+9UerMsH8C0twa3WvMnKNyiV/03OePvG/48iPigLW0l5TKKMYtMDWxS?=
 =?iso-8859-1?Q?GXok54XCW46ozQ1vk+xcEHXCvDpmCGfHeSw6C0gjUAnBFFbB6OnFitvl3G?=
 =?iso-8859-1?Q?uStG+WPqfHWdmHhZUfsd4knq/3RvZLQ7wUyPYSQiRACDtUy7z1QA+bH7E3?=
 =?iso-8859-1?Q?ls2QLeQ3CqsGjo4L1A1GEHwfWhawBp392+79QGvpYm5wvwil7hYnuGBU8F?=
 =?iso-8859-1?Q?g6zZnszJKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DWKRiRjn/mbIPLNeLAnialJJPbjUnnnVxsJ0ePWKR/W53mkZvfG1AvYLbECdx2rj0+hKdASf1OhUtTPQpSQ2lI8F5PLIWyqJ4Tm+mkG8BXnNysmft4e5apZV0D69ju7CpDlIyS1CEt8jmZbOtTMbWWEqoT/DSAdZn7gFryLSYMBUf0GC3hTSMwQgmqhomBIZebMCMcrxbvIqEFtIE3Xzy3AYfEUcA0o6jiR5BXgt1FRxG7o4sXCuc3RHKeKUOg6Q3zGgzexn+IcsvE1OUrBBgy+6qT+X2wTqQLqKcwEwkVGpOddlsekdEj7a64W30/+sEJ/A7RtqFtLYP87/EmHb4g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c6534-2ca5-48f2-678f-08df0eda3f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:24:24.0576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhEKGBuE5o5MPFcff6qnzlCzK3TIAGE66mRj4Hx5XLAlGU3cdo5spQuBKsPT5FIMPFSTNI6tLQXzyKbBsTc8PYgVgzQRJYAkeVzkKRGi7v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6255
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ACRY RSA qtest allocates two ACRY_SRAM_SIZE buffers on the=0A=
stack. Since each buffer is nearly 9 KiB, this unnecessarily increases=0A=
the stack usage of test_modexp_rsa() and may cause unexpected failures=0A=
on environments with a limited stack size.=0A=
=0A=
This reduces the stack usage while preserving the existing test=0A=
behavior.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-acry-test.c | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-acry-test.c b/tests/qtest/aspeed-acry-test.=
c=0A=
index ec348c2206..51048d697c 100644=0A=
--- a/tests/qtest/aspeed-acry-test.c=0A=
+++ b/tests/qtest/aspeed-acry-test.c=0A=
@@ -327,8 +327,8 @@ static void test_modexp_rsa(const void *opaque)=0A=
         .alg =3D QCRYPTO_AK_CIPHER_ALGO_RSA,=0A=
         .u.rsa.padding_alg =3D QCRYPTO_RSA_PADDING_ALGO_RAW,=0A=
     };=0A=
-    uint8_t dram_buf[ACRY_SRAM_SIZE] =3D { 0 };=0A=
-    uint8_t sram_buf[ACRY_SRAM_SIZE] =3D { 0 };=0A=
+    g_autofree uint8_t *dram_buf =3D g_malloc0(ACRY_SRAM_SIZE);=0A=
+    g_autofree uint8_t *sram_buf =3D g_malloc0(ACRY_SRAM_SIZE);=0A=
     uint8_t result[ACRY_MAX_BYTES] =3D { 0 };=0A=
     QTestState *qts;=0A=
 =0A=
@@ -345,7 +345,7 @@ static void test_modexp_rsa(const void *opaque)=0A=
     put_bignum_be_bytes(dram_buf, ACRY_MOD_OFFSET, t->n, t->n_len);=0A=
     put_bignum_be_bytes(dram_buf, ACRY_DATA_OFFSET, t->m, t->m_len);=0A=
 =0A=
-    qtest_memwrite(qts, c->dram_addr, dram_buf, sizeof(dram_buf));=0A=
+    qtest_memwrite(qts, c->dram_addr, dram_buf, ACRY_SRAM_SIZE);=0A=
 =0A=
     qtest_writel(qts, c->acry_addr + ACRY_DMA_CMD, ACRY_DMA_CMD_DMEM_AHB);=
=0A=
     qtest_writel(qts, c->acry_addr + ACRY_DMA_SRC, c->dram_addr);=0A=
@@ -362,7 +362,7 @@ static void test_modexp_rsa(const void *opaque)=0A=
     g_assert_cmphex(qtest_readl(qts, c->acry_addr + ACRY_STATUS), =3D=3D,=
=0A=
                     ACRY_STATUS_RSA_DONE);=0A=
 =0A=
-    qtest_memread(qts, c->sram_addr, sram_buf, sizeof(sram_buf));=0A=
+    qtest_memread(qts, c->sram_addr, sram_buf, ACRY_SRAM_SIZE);=0A=
     get_bignum_be_bytes(sram_buf, ACRY_DATA_OFFSET, result, t->c_len);=0A=
     g_assert_cmpmem(result, t->c_len, t->c, t->c_len);=0A=
 =0A=
-- =0A=
2.43.0=0A=

