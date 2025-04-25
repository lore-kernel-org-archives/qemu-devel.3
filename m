Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EF4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfo-0004AL-G5; Fri, 25 Apr 2025 10:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hks-0001Yd-3j
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:08 -0400
Received: from mail-vi1eur05on20702.outbound.protection.outlook.com
 ([2a01:111:f403:2613::702]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hkk-0001Mx-7U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6XLPYqPSU7gX9ZtdbQDZuqEkcfv4dZ/KzfeT848+8aRGHdz5lGochquvBhm97d1UbezdySZHYQPNbQltm2lptM3BKWkN8x0TSuJAxNL95GkqK2PrpfIyB8EoX5vIDdZwVNLqN6d1fmGsNh+dMlo2ATbQjYjc+QJ0E6/Nc7JCtHXJecN//pzh5DitPPhp+j4XaKMOi6XvHA1bWcNFGhc890PJu51BW/MGWmyX0cxRNTLb+JF18IMfZpTb7rSWqy/21k8xGZ1JSdfaIWmFJoisC87kMlM8ZOL8t59+CQ3sByr6aCDigt5CEG2Yo9dLsaPC11HV2c1L+f40uUS+Klm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V4O4WN/pT8iiTow6Qns/QnNvSIk7Bhp3OjNIubybs0=;
 b=E0ocr5nn8NE5F1VyN8so8X5FkhyCfaap6c5OspP5fDkt/5YPQeQwzrL4Bb1byhSG34z8ycEj0Yy/50X++MgNBXUE/Iqz2hnRbds36C5BO9Qec2VK1tzkj6Nbesxi3AHcn/Tr/AfjMAvDonLaWpfISUuGgQqW0wZv7/t3zyWAQfYj7H05YUENNYxnHrxK0Ifzrd3MuN9OpdPVX9Fh027PoW7OQvbzl1oAtlOszU3sg0LbehSfls9S+mb9t5WsePyJar3surxr1U3rKZMPreJP/YyrntZNuri+OFqoA6z2eWzRKrMGjGS843opz5Shz4RWjogWGXucyPjM1TmFTSf5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V4O4WN/pT8iiTow6Qns/QnNvSIk7Bhp3OjNIubybs0=;
 b=UIzXWVaV4D+k6F5GmmzAHEAoQ6Y1Og0IqOfBHBUk9rIEjct2wvc6itVofLnTl/1CQGefzwpwYjTQ95/4Rvf+A1oHdx8XbMOl22pg7ivkTyW9Zd2lJnEl13kBb6z96RnUgmI1BCTivjL4xIW6LbHXslvGq+x06v/VF+ijjfomksLFPKvBtM2y9BEs6lNeaCcCHaQ8Lj8NNQWT/mVZuIx15tcFOpb4+I3gXQCNEA5wKoPy/qZZOCQFM+/vCaD0voOHN4nFQEUrZDP42PHT5PjZpRArasK2sfbej2Dd8ReiPzV1isVHSOgFbLYCsnoMN4DOinFEt8Jy83azmyv0556IuQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3713.eurprd09.prod.outlook.com (2603:10a6:208:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 12:01:45 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:45 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 4/9] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH 4/9] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHbtdnQQWvOtPWWmUG80QbPYVn3xQ==
Date: Fri, 25 Apr 2025 12:01:44 +0000
Message-ID: <20250425115912.912889-5-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3713:EE_
x-ms-office365-filtering-correlation-id: 69f1847a-9087-40fb-e36d-08dd83f0f30c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BLqXvNaNdlbdZtmsk1U8O/ai+zkS+xBhxEyvhzKoz743sFcxs0O5crJsE9?=
 =?iso-8859-1?Q?H+33/aDC71uiKP8XlasKSihjAXlnEH/OI5R3quDPI80no150u5BdCd/s81?=
 =?iso-8859-1?Q?R8XfGNeJORZmuVVuYFpt/w7XIH7XPZk5fjDZJIbgE0XsZ1nZh5LQX360/o?=
 =?iso-8859-1?Q?3AZiHy2x1shFIE/K3mPZDacGMMTsDDnbMepnU5VbuUElB1Yxx6JB2Qh+zx?=
 =?iso-8859-1?Q?XUg4255c9dJTD069SdUqDFlKYnvC5p7NiyiRMNAm+E5mN9mycrlQhYGMB4?=
 =?iso-8859-1?Q?dlqCikbZd/EuTG3qnjOYvRCYOVZhS8deXk6loRdila/abJwR+cZdGWeA55?=
 =?iso-8859-1?Q?Gj8yKlM9zaDuR5/GczOwK1foJOzYzRs6DMXC9XKWnQRXb7sldXy9Bh8Uls?=
 =?iso-8859-1?Q?5HR1W79fP66EcEpK6VSKbTZvS+9jO9AkgPFib/k4zDHOYgcNrwwKgJpeX2?=
 =?iso-8859-1?Q?QIneQ6Q39ifxzUIFrU5XHnXtBc5qEZFj462Dr6OgE8wjRlvCfxmLmWCnXn?=
 =?iso-8859-1?Q?45F1l1J2OyDz5Q4ux/jDn/FpAJbfnHagTY6VZQTtgSLqYZznTqqsWcEdaf?=
 =?iso-8859-1?Q?Yze3rI+Q2QeN/8RtHlnc+pFWaQUo0y0OJM7YsWrkzpcj9okvX8+IJ+yZAK?=
 =?iso-8859-1?Q?Aon40kGpVv2WlZfuRAo4jb8sXYOEDzuM4SY7nn77I++b+ZKtOG3j0nhLl2?=
 =?iso-8859-1?Q?lBpU6uJALtD09FG50PTI7Ad6oFXoYOkq3lpoDyTUd0aE0dgFynEmESJEBt?=
 =?iso-8859-1?Q?3LM0mfayVU20QMc1O0LdKew8IKYeddd3yfgt2i/B1PS7tI4kVHOWRA07UK?=
 =?iso-8859-1?Q?tjNpQMlYDpt22ZWCTWTSu1Up3ljvGOz2q7mLQHv02Z5JArZbJU6EFmrznF?=
 =?iso-8859-1?Q?vqDJPxU/nZrCOhA2/3BQH0k5u1w0hiYpclEPH+nw3wsSSmZUN7aldr6lRb?=
 =?iso-8859-1?Q?mxiNWjaog0Gdrs5TN0TFZFmhkcf/6eBiJ8Jb493KT03uqcVSPmQvErWaNc?=
 =?iso-8859-1?Q?qzPYWLHw0pha8KTI95Za+xlFPgNQv0faoCva1iKByUEST4Ze/itkG/Y+o/?=
 =?iso-8859-1?Q?XpHcgpN0aGB3OIegNBO+TVfwMKRdz2nx9ieBgJkcTZalI+2UYx/eWS1quM?=
 =?iso-8859-1?Q?LawagNZxQpLOBDCTkXXmhmueX2cQg8i8Ze60clT8A8vVYTZQ1hn2nBxCry?=
 =?iso-8859-1?Q?ohPs5nQFWZulY+d+NoCRL4REb3qsh7FOIm3lBLHB0mu9R38/EfpppZHeZE?=
 =?iso-8859-1?Q?/LNVovM1tgwEz4/NZCnauvlmDfk/1akZ3pPY2qa2zadOm7DE6V13e+MQDk?=
 =?iso-8859-1?Q?5PDMesVlmj8Dkr9x9N7mEVCJkXB236DlHzzRH8NNz1O5jQsKbjqlC8ortj?=
 =?iso-8859-1?Q?7H4YI9V8m/IVJiyF+R8fg8sfqnvVM+cwR+DhfPVIg9fameviDR72TN36TM?=
 =?iso-8859-1?Q?q1h2xjo26Ub0UNjOnHeB2P50CKd+t1OCLEcFi9wqaDYyD1YIy7STb2G/aa?=
 =?iso-8859-1?Q?poatySCw8cKRtvbIHGsWE+l/pu2ZTkDtgHM9TGY694592M7RRrSxH7xnjF?=
 =?iso-8859-1?Q?mSdV3zk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0qdrSlD4qu1VcU95NYI6bWZXYmk2eTuHFpCG3Ewj06SoMJuLk3GQGhy1kj?=
 =?iso-8859-1?Q?9Nrxh08JAoNIwrMb2yha74mnLD71wQfbTY5LwH7AZyfZLDaJw2g/03KX6e?=
 =?iso-8859-1?Q?AYt6a8n59EciFs8P6seuW6+jPyQDz3HWzN5zbFD42Ms698V0lq/oT5bBmN?=
 =?iso-8859-1?Q?dwDFwFjzMs6Y5Eg90NZcKePaFNiySmsx4pvUqPm4/eLe5PQy5yXTqC9I/m?=
 =?iso-8859-1?Q?JR3D1IRVcjYmddodnK4vCkKJphNi41JV3paaFrudKcZIsHjTIyys0WV30F?=
 =?iso-8859-1?Q?E2naYBh+b02BcCs7TypNK261tq0XwJmzPNgu4vP00yxJ1984ue6hkA50gp?=
 =?iso-8859-1?Q?HKabZdcuoJbbVW8LwkhjiusZIULGOJ/uYYky/HDc0hYEjoB93qRp5Z4ErX?=
 =?iso-8859-1?Q?E1En0xUb6pLiuYioiXdiNal/aP4Fxfkpecw4cUNhv9rL1bC7ki2GWZRk6m?=
 =?iso-8859-1?Q?SV6kQAUHrtn/KjbIyngmVFo6xPqP35k8NqWCevI/CWGx4FYMhn77q2wU0I?=
 =?iso-8859-1?Q?sJi38p2qVCX5LpbnrS9R09tOTKCwWP+gBxP/GFWB+2jmMmBkI4XXvl3Mlh?=
 =?iso-8859-1?Q?kxXaZ9j4eCHNWsNlhGLvfaC6r3xhT7AN6h3kbN00HylztlcU/gNQ0i8qQX?=
 =?iso-8859-1?Q?ThR4IpiyCP45FNu74RkZs4hayQU/vkGsKybAVKoipg48s3lcSK1o240PNT?=
 =?iso-8859-1?Q?iNi0jS/ZA7w0wHqDjsN8+AHYlCmZrJj18YZbZqZN4BSKw5IY/vrhG4ZV/u?=
 =?iso-8859-1?Q?V9H/2DzD5LFBsiX7YQMd73dNGd/BbtQpY7U3T4T1WFcjqK89KsGXdROls2?=
 =?iso-8859-1?Q?W7fOydESn0mE+IuqbKQxr80rw029tL3nhERaYJ98U1VKsTzEOPgE3cAIeg?=
 =?iso-8859-1?Q?2g0eFFfi84jiPfXSyt6ODODQuiEh+QOYhHIWQGtSdTR+4KjvvCiWnKEB/Y?=
 =?iso-8859-1?Q?ihYl5m3BSTW58zqZQtB6UXbizr1iNEEpEUmCwxs9zNID9he/RjZ9JKOKdy?=
 =?iso-8859-1?Q?KR7DUhuTkSuDS1VNv5y+M+m6Ep3gTNk6gbANjXyEK3tUoGuW8WmS2RQKE1?=
 =?iso-8859-1?Q?tI4lkBL9EXlO8ofiohcFPFK0Z5eNJ3EFvw7ZI3EHAgnSysJxx6RB7P4v2J?=
 =?iso-8859-1?Q?jFRQrnyv2RoKfTm3yrdkKJxlLeADnNZD5sDM1xhY03oqFlyMU6D+uy/7Jq?=
 =?iso-8859-1?Q?sQUZW0tejGxlEtXHrIOfXrdBemZ+D8GtdjYb+mr1gCsGYwHZk0JUdwqU8K?=
 =?iso-8859-1?Q?7WJyJHrduCSrXn8jgSYX2O44Za6gFQ4AN7Ig3zT6HoL8/AeCVhuLBd74NT?=
 =?iso-8859-1?Q?NhdwE1Kb8QNsGRKJYB8Qy07nZI9FXJORMpOaiiFcUFGIUX/YaMkl/7xI1i?=
 =?iso-8859-1?Q?L8cNSaQu3etfcOzzbx1Wl90JikoZrsOAdcDvQlsZw+yEtkOGaditvnYgvC?=
 =?iso-8859-1?Q?nuc/3Gb+d5Ih46oCxePFHCQ/DbWMQUIVbPINNXGSS4wwSdNayi2d4u2i4f?=
 =?iso-8859-1?Q?etcfCpvX7Fkg64hqNd1ruJO2lRUpc5PChEgx+uyWj+cJuudV02wabTBuT4?=
 =?iso-8859-1?Q?vywlovzA9ds4fvIXVSWpv76ICzVIPBy9MfI/fkSqidTSz8ydZ4pYpHEv4u?=
 =?iso-8859-1?Q?qk6MYWSuwINhIRWapE2cGmWvyseX6DUaGsdZ8C19ffDeF5UG2SMsDJwu0P?=
 =?iso-8859-1?Q?KGuuBQoNvsDlLbfrJcU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f1847a-9087-40fb-e36d-08dd83f0f30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:44.7780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5VTgLiyfc7iqOl+loMK28svXqNkJQHbJyfd77LLNfy8kFpRlAuwqX0+1tuughLQaa2kdSHYx/2gBPb+3u3B7ZRMvW4i+BcQMEhC3qTJx+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3713
Received-SPF: pass client-ip=2a01:111:f403:2613::702;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   1 +
 target/riscv/cpu.h       |   7 ++
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 226 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 029e2c7929..d22c1baf09 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -530,6 +530,7 @@ static void rv64_mips_p8700_cpu_init(Object *obj)
     env->priv_ver =3D PRIV_VERSION_1_12_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV48);
+    mips_register_custom_csrs(cpu);
 #endif
=20
     /* inherited from parent obj via riscv_cpu_init() */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6d0acbce80..f403a743b2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -500,6 +500,10 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    uint64_t mipstvec; /* MIPS tvec register */
+    uint64_t mipsconfig[12]; /* MIPS config register */
+    uint64_t mipspmacfg[15]; /* MIPS pmacfg register */
 };
=20
 /*
@@ -944,5 +948,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* Implemented in th_csr.c */
 void th_register_custom_csrs(RISCVCPU *cpu);
=20
+/* Implemented in mips_csr.c */
+void mips_register_custom_csrs(RISCVCPU *cpu);
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..b655798cb4
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,226 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mipstvec(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val =3D env->mipstvec;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mipstvec(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mipstvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mipsconfig(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    *val =3D env->mipsconfig[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mipsconfig(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    env->mipsconfig[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mipspmacfg(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    *val =3D env->mipspmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mipspmacfg(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    env->mipspmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+typedef struct {
+    int csrno;
+    riscv_csr_operations csr_ops;
+} riscv_csr;
+
+static riscv_csr mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+};
+
+void mips_register_custom_csrs(RISCVCPU *cpu)
+{
+    for (size_t i =3D 0; i < ARRAY_SIZE(mips_csr_list); i++) {
+        int csrno =3D mips_csr_list[i].csrno;
+        riscv_csr_operations *csr_ops =3D &mips_csr_list[i].csr_ops;
+        riscv_set_csr_ops(csrno, csr_ops);
+    }
+}
--=20
2.34.1

