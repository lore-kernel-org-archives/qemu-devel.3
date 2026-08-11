Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4CBC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYc-0007TT-AW; Tue, 11 Aug 2026 02:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYb-0007Sg-Bc; Tue, 11 Aug 2026 02:01:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYZ-0002gH-Tm; Tue, 11 Aug 2026 02:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWYwoeHmnMn3ICiU8DJ4/kuHKWw+sqNkKkGguney9okKFKsAR2vuaoyMm+1PMbCbG5WC77HKaNDbCA9aNRgl/ICsdyz5d9//esomMgr9xKyBBIDqynXHWje9iA4bbwe1O+WgVDIAB/LbyhT+B52QAYKDmhBn1xXxGyrQvi8Lz9ajcIK+XlgixNVjW2Q+mZGyPUV/fzBruuLKQ5MLiRtjzreEfXxOZkN+4uOvs3frSivsGOcVkP0nlG3S6rz+57foAUPcQT/uuj4aCHFMb81YOzYyXTs84DgLLGOFF8LzPcuN+xl+Y2/ksDkFgeD7rj2pNUEttzRdkmz9MFQa4K5DlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPwzI3YgecUViRPDJiCHvoKa5fgTwqTzHtaDSQYw2L8=;
 b=Fm8SNRAPdorkkelRONi3aXJoAfEiC39B2Fo/tfa2JPZfsaZdUaddmrVLOO2eAlFb1ubS0ohELBj6NWpL2Yf4HOe6tyy5Cb/werd1ZgJ7gsLvnTawoJuv6Euwe4hymo1fDIu1+SOKCws6VEc99AxhBIP0F6Tlh7VGslZE9SPn4zXdkxC1+9s8oIqH3Fqpd0ng97mYkEZVfJppa8FdDiMYXtQj9Zj3J419M6NS/Sv3Iqw/WvOBaYPZhUDticeGGr4PrHTCRN4aAD+K/wZ/tDGsjHDwJOj4fhTOQUtEKdxTotcNWdfZ4lbufWV5dAdHOS0van051FT/8v35kkgTQs9sig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPwzI3YgecUViRPDJiCHvoKa5fgTwqTzHtaDSQYw2L8=;
 b=FovqLOwJJBbzdGs70KozEQu1bCD0lmnR1BkMUjL7VHk9nTUieY5JJw+9oaeN4AhQKXYxU6ri/Az05wPEy846lnSx8zbPwygQukvOH8i+XVwqmFY7PeYCkFS/dLQBAoDFEjR8FewF6bzBnNozhA1c97ghSYRLgDQZrQ07xGtauj04zwxLWpIvfWP6cxeogRK2P5S+mU9TgmyFhIThk9Ujb0kr/lsyTAMm4hDN2Rpe1d8gYUwtGQFRkYs0Y24f2M6COwEoXRBh6PyrlD0W59stH8ob+AB0BjHyuPnSUsCn3moM/iz09OS3GSU1NT4JX6378T3E6K80pk5ypBokqTbowQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 15/16] hw/misc/aspeed_hace: Enable the crypto command on
 the AST2700
Thread-Topic: [PATCH v4 15/16] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Index: AQHdKVbeBOfr8iPl4Ea4BoNiA3L0hw==
Date: Tue, 11 Aug 2026 06:01:36 +0000
Message-ID: <20260811060115.1849266-16-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5419:EE_
x-ms-office365-filtering-correlation-id: 5de64c81-8e71-4b4a-eac7-08def76e00f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|38070700021|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: mo9++Yl+Co0IyMbo7+zKRu+mcuZlYv0GXsPwpoCTF7ARvRuqcIKLnFR6owG/YCHMu/0NCa9oxpLJSZwc0s5DAlJ3LKgrhKWOnGsGU2p4C5ua/FHnCfFHjs2Y8SBhn+CqfQ2u6SymZRKSRpWIl7kmdkHxfeWQ6fsiPBoXCg6x/VAfBu24+uN5LI75EjGiJfQowWp1t/87dvTc+KlSUMwrqujPhIqBMiHXCVX5p7rCn+pyoLqqAEN2wNdPMSg1tROCowX1d5FwTfXFUQyFHeOfL+Oj8amgva0H3+zDYCDIQ9qhVJrOIXquAya7rFD+g1J7WQ3Q2NX2DmTvl2tFC8Icda5ZQSh4sa/ExvdCkC++pqM36G502s+z+VYVcYjpjXmL6g1iZphTE4DIbBUcdVQzKPTkWtV/GRv56Pk6iF7+K2XSHZ6Lwaz/7Eyq+pZ6mew652Er61WKEYKxEfaA7sh1Z+YjdiBOKIWflhFe9+v/LtzKiEBr5NcjJ9LOT9kWCfe3uijaOS6zH4OCXLIJ2RrFoq82S29STgZ68js8Ov65NwXxF80EKyXEKGVYQEb3MLZUdkrOsQuJKS/iQkL7wxKWK8iN9I+/UBKXZgyL1mIBDtha0Lu5g2buTD/X3GjhAUHtT13+Mv/epalqcW1E5pfqEuLTw2BOZ/WRUqjY8Wt2Md/nraxsk/AfcHp1QwYPBwOEucfBkkPhmgeckXf+nU9DJ6EFr7kEkpKDBz/Met2DGmkMDOCIlBfYQX1PCBa3fdVS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(38070700021)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PYeXuTpH6fOeGVWs1hNlBFuJMa2WlRcMGPvuUNsK/x+NPAci8y+E0noXIi?=
 =?iso-8859-1?Q?UIui2xwUxc7TCTTsOvVd9hPHzffxon7dQ8BcrvyESt0g6ka6MSHUD+ZzIH?=
 =?iso-8859-1?Q?7TggVZGzzzwan93NRmy/a8GNYQHurkkZcFPV0SrtxWA1GIEag5Ssynu9N6?=
 =?iso-8859-1?Q?1bklEgvER0zxVMEBwX+4i3Kf/6PfqoPitZth1WC7smzp/Kl9Swud6LhAXI?=
 =?iso-8859-1?Q?zafSQS0O3pojKTC/fc/7y8vW4s0tn2MYLFoSNh1QmkAr9INB9bR5fDJlNk?=
 =?iso-8859-1?Q?+SdnlQ4y9VDgygHAjCTGyTdhoq7Q9eZfVqBnHTTd2XELuu6i9Bf+P5WJzD?=
 =?iso-8859-1?Q?jpRz37ffefl4zKH9kaGnh96bzpqEXYHqECITS02CgHxUvV+BZnFeqND/KI?=
 =?iso-8859-1?Q?m/fjGiHr5MUCAKdMB5egA2PWMmCoQ5YHybsR5rxtiT/nomAxjYNyZhKYK+?=
 =?iso-8859-1?Q?9jgo3fjm8mNrQIG0yRbUUd8LQiG9hesNQV/3FL0tGxTbw9SYbDw+6Bb88p?=
 =?iso-8859-1?Q?Swyy7IHxhFNP0fQuGrZwrzI7FGai1eIGAHzjufi8Aiwfxv8UduVZpeWn9v?=
 =?iso-8859-1?Q?WNfO6SUy/WT7KLei1iZtl89kCQEpArQ5HxQ5iNlfB8MfyoxAlgaOPxm7pr?=
 =?iso-8859-1?Q?HqEP85YMjLHE1DoFihdhEZPQGf2A+fsrDCfljxggZ0up+fWqUc5rLeI2O5?=
 =?iso-8859-1?Q?IGIAKUmSVH7AusT3m/aP2wkJHCZJejWCAjXfIG529c+M8fqqYpOCQgYgoa?=
 =?iso-8859-1?Q?bVZFh0D7i+5Fj7Ft0VB3X8555v753fQQxYEN+nCKaJSjxBeILG0ZyYehFD?=
 =?iso-8859-1?Q?C9pEULn2IBD7Bsh5o8PMzcu20YRJuEVZbjKYvpKWP8dOudCSE/W+CDzRQc?=
 =?iso-8859-1?Q?3NKzc3umBbHLasDNl8DAJJicqtfkNrtYMigL2mCAmj0VXO792gZCrODnKd?=
 =?iso-8859-1?Q?kEWsepnw7hqvrelm7okiX3mQhT2qgXAmZPDnWMK//6I08NxqNOEUYw4l30?=
 =?iso-8859-1?Q?QODkrO1Y3/zcH+xi7DY+tM3HEsEmu6wXnV2x4ZFWst4H87NyNH63cOsOMC?=
 =?iso-8859-1?Q?b9IZ7L00Hl6NOgJFVfvuOTeFgQ5Xbhr/9zUwwN0uietEghpH3vENAsqM7g?=
 =?iso-8859-1?Q?U2r0uyE7FWYK0rYt0Mf13Pft4/ot8xAnVMH37JRRAWy+UWnB8REZENngEZ?=
 =?iso-8859-1?Q?88GEytMvqNbZNZMc5ksns5V0RLyJB7W2HrIDUwbphrzoQO5EJM8LbAcYIp?=
 =?iso-8859-1?Q?n/amTex0YptvzJovnDgchunewRsh914n3WqOMy5FBzjlm/X3KHd2mBMlmi?=
 =?iso-8859-1?Q?+GuVAHdWXBULv04CM1793nlQyNRRq6SZ4IrvS581ams+09NEAMegyf5hcB?=
 =?iso-8859-1?Q?TqcRO3pP3rRzK6l0U8AwKlsG+oEBVDgPhRrUvKx5qks4wzEXBj+/GBCYqM?=
 =?iso-8859-1?Q?4zeyvfGLAQSrhENB2VJWIZCrzsROF53nl2z6wCp5sKJ7pMZdqjIW2XWVFL?=
 =?iso-8859-1?Q?uaTMma6KQ8obHPC7xtQ1RaHCeoZvQVv0iuFLQx9Q9rl/+nTnwZkXyxwM32?=
 =?iso-8859-1?Q?klYxIKBHKRuK9GfQeJ30fNHNjjMo5JFowEGEDFHVDj8gBi+FG2+99ChXtT?=
 =?iso-8859-1?Q?tG4vhh87EgLTGUzGhnGblvtsGpyOqWPqYTwi7MBNgPwT4XpipfvqNtoa3c?=
 =?iso-8859-1?Q?BHU5uzrO1g7gZdtcflWXtcCWHijOb1UkXsgbXq1UyLe9KfccvdOA0aXWT7?=
 =?iso-8859-1?Q?80VP8Az/3Fx6/i2ymGZ3fjyxOUBO1iAeQ9mOk5X+GYnAb2XHrCTnpjU+pU?=
 =?iso-8859-1?Q?qzMeIimUMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TvSzIuS4LbkkL/t+JgsPyMvZL0OxbwRHX00+ygdWK/PkVPmoi9UWcCAJ9k/DYqi3PW9mdmxYFN7hgB3hzxjdYWFvd1StNBHBbIbfLAfPm+BMCNJu83qNUkZvk5CHR/LDhnuSJ/P0zr/vnDmLgETUebcgpFZXyNDx48wTzJ0DCpV+e84rzYszPJXfYxmcr/BeXj0W2WBXbnEPZFgVFAioCE9nrYsF45SxvfGAYZ0/YR5RWhac1fpt1gdVBJ6jVvC3ygwetC35OObhta2Ch13A4ooWcn3Dj/CfnEy4IP4w8gl4d+OxSMWGm0cgWGsD/mym4icJTCmMkn0UnQqzFdOBJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de64c81-8e71-4b4a-eac7-08def76e00f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:36.7161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJYKQ00czqf0Oc1nvNbuMENZwm57Z4glNDiqtNge8GdWu6yQ3bXnMTAvFz9vOHn+xd2jO59Mf9My/aK9qubOS9jba1gXehR+jLzxc+UYpuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
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

With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place,=0A=
the AST2700 crypto engine is now fully modelled. Drop its temporary=0A=
interrupt-only workaround so the crypto command runs for real, like the=0A=
other HACE variants.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_hace.h |  1 -=0A=
 hw/misc/aspeed_hace.c         | 15 +--------------=0A=
 2 files changed, 1 insertion(+), 15 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h=
=0A=
index b5416b0cb5..9b0e7683fa 100644=0A=
--- a/include/hw/misc/aspeed_hace.h=0A=
+++ b/include/hw/misc/aspeed_hace.h=0A=
@@ -49,7 +49,6 @@ struct AspeedHACEClass {=0A=
     uint32_t key_mask;=0A=
     uint32_t hash_mask;=0A=
     uint64_t nr_regs;=0A=
-    bool raise_crypt_interrupt_workaround;=0A=
     uint32_t src_hi_mask;=0A=
     uint32_t dest_hi_mask;=0A=
     uint32_t key_hi_mask;=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 23dacc9be8..8de05a9d98 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -1005,14 +1005,7 @@ static void aspeed_hace_write(void *opaque, hwaddr a=
ddr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        /*=0A=
-         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
-         * added later; until then it keeps the temporary workaround of on=
ly=0A=
-         * raising the completion interrupt without running the command.=
=0A=
-         */=0A=
-        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
-            do_crypt_operation(s, data);=0A=
-        }=0A=
+        do_crypt_operation(s, data);=0A=
 =0A=
         /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
         s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
@@ -1214,12 +1207,6 @@ static void aspeed_ast2700_hace_class_init(ObjectCla=
ss *klass, const void *data)=0A=
     ahc->dest_hi_mask =3D 0x00000003;=0A=
     ahc->key_hi_mask =3D 0x00000003;=0A=
 =0A=
-    /*=0A=
-     * Currently, it does not support the CRYPT command. Instead, it only=
=0A=
-     * sends an interrupt to notify the firmware that the crypt command=0A=
-     * has completed. It is a temporary workaround.=0A=
-     */=0A=
-    ahc->raise_crypt_interrupt_workaround =3D true;=0A=
     ahc->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

