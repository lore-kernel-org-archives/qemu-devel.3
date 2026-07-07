Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7032C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz0J-0003Wj-CN; Tue, 07 Jul 2026 02:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz07-0003JC-Er; Tue, 07 Jul 2026 02:09:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz05-00083r-97; Tue, 07 Jul 2026 02:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcsXxuv9bDALuipfC/Fmc3gH2EgFquWf/03kLwt1wWioRGAQKpH9jKoq6dhyYS0ehhbIUI4HnRDZHPrjz6pRwZ9BCJXpfTsrig4eatR98Q6zwSx0t2584aYFJNkB+3yI0ypwehR2pDumjkv6xntq/VGNBVCpu5tPz6EtDN0iKOeXMTbFYfBHPY5kn+3WNV6N7L86Sz+LyXDC/RSGJIyQbnsUz2a8IL6LZcdMArJ5CpKycV2/yPff/r6j1qa70mTrQN+goDgHF+/QCSWJ4+OSVwhNApKsGf6lUZLRcwCqkUXgi0s4kRf7Iix/j2bxNqhrJC3j+NJhFXc5agfdpGY12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsrHNj1tZwzRtG+E/b4+qcdnhTQa2VlyFdom9lcf1es=;
 b=yWUtwlEvl0qGwEA1JtR2bMKpyrYrLI4k2ZBnpUx+OhKn7dhGrqsL09spkCFx8Hb6FoLKdnKKgKTjhGUY3WheQ9aXzgivFWrG8hHWXRzDMSBNhc3Ch4L3hGih99ro7GHH27OsefKhflwdHqjqyWVtbA4Xga7SpMyi3Q7V4bwlw8EGYKyiZYwvbdhI+Gc5U9/lEUAmfRu18XCBalyYqKaiJ5VLyo11CNWrmzN+kml8HuvzuvziH9ysl6EltRxuZr4zf5f15HDF/mKER7rGbHLO8c/Sg5J48LQg3kZjVtrdITdcW+RgBBbQSDtm0DZgs4wfRuf2QEWuZoD/gMn86WClcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsrHNj1tZwzRtG+E/b4+qcdnhTQa2VlyFdom9lcf1es=;
 b=qiZnTOlyhZnbqZG242Q/ZKpyoIj6Doeh7KJ2yfIO0FACNAzupKyaXwtXiuH/a0ocxe4m12Gq/44gKh8U+E1qlnvJgR6NsNCCZoHSnQpFkeyjYTV389aGS5XReQ/llOM9CGp0zeaaibwDY7E32hr/gnN5BLU9FSwS5YodLoy9UsRWNsCHKNSBspI1FZIM3gKKufbXR5JznRGcHFkf03dqRunRxjXInkRekwCyrXV4+Oxq3bn4mxsp6S2eUYn2mWbc9vm3/69fBFs2z6+iBJi6jkLQZ7HEl3bxZMQsaJXKiYux74OLBCEcqAJ5+58FidVIrSuWDYS8/6pnIJanYxYsDw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Thread-Topic: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHdDdctc0cnKqefhUew9zJXrM01Cg==
Date: Tue, 7 Jul 2026 06:09:31 +0000
Message-ID: <20260707060919.350637-9-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: b6783250-4210-45d8-3887-08dedbee4fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: qJoRtc91XHVtSg71bWT6iSCK3yE49vQBzaQhciY/iTqZNTW562vvca1jgO4CHxHZtf5QTjc+Bc6ePnLqNX9TkGbr8UceBFOSdPMmjDnGbGMCte+Sr/a09FcvX59dJdIR0zfX5NbJqmgcbXqtwVbkNQG3BCGlPDWM7iTDi/4NnJxLF0GoccSkQEW1cQOjIROHorelSgCy968iPi9+d5WdsRuVWe4OcgYOmO3OiQYIxc6xVDULiBOXEDPAciedTSgoHBmn9bN/TzZ6AZ2Q5eF+C+6s93QXIlTuw1whSrvNhz5+kyPIyJQC3x5Ui23ewTs8Kak5fj6GloH79m/QRr5S9pCP/AteE5xL1be4bJs6lYunVWJYsmsXayd2RmR3nkgk2M29qoywjkFhSYchCTb2w9ZbCwlFk8+OpY064EEUvwughYM3tc3rI/ccKzbYgzO7W0nPBWwdZ2GxZK5RF6swpEVGys5muCwZQoXW2YeNYtgEzq5kqWB2RmtAwkq/ftxrpuHwlPp0CebEtX8vECWmzPBPqMffRqRD0fv98zXx0pj71ol2B2W2m3YIiaOzmWos68cfnq2ySY3rwYdwExX3Th4VK6KRHJlm9g5FcPmAEcTLjHFwaR15KeXlXc6jMyydnv/XmOaT1BDewLYNixauDxdu7K5K3APSVwfKT3jw0jMj3pNT/9l3I2kVmn3DZGEnTiAZkHQA8XtMxBGYqyXSaKeXgBT9LLbNuX3ooFWzcRA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hiV3D38QjQPuHcjl4kMuyrs042Qfl5QyzSESTU+9HRnYeO/qk7bphkTiRO?=
 =?iso-8859-1?Q?hmFzltFnCHRJloByWO1anISUwXV3beZ5k6KrkMor/YAbShL2k9UReIbhgD?=
 =?iso-8859-1?Q?XXsrV+rImloXHWZflVE2nUGbV3vf/zQw3MsJDlguCuLwjcUpmm0qYnJCDO?=
 =?iso-8859-1?Q?EiK0dAagwFI6vcxCpfdoGbUmxxdOpKXrFf1g4eilkmEbfAQtAoUDopfYem?=
 =?iso-8859-1?Q?IYpCSlIYQH/kayQIBEegByVKfrAewIo8w3O1aW8KpXfLjiS4LyfhfpKUO/?=
 =?iso-8859-1?Q?QwFQSDPa/KuJeEkoxs599Rp9+tBiungtqtdv8PEbQTPm9vdc1UfF/ETGq7?=
 =?iso-8859-1?Q?pKrod7mxGB6wvyiFTZ6TA95Qb1Lv/kOdpQh+PNMo65GdG8BKlR0B4Gudt/?=
 =?iso-8859-1?Q?ChXDO0axEIiok1sMtdA7585T702ebshX1w/sBnMxPd0sb0aCq43vSMsaXi?=
 =?iso-8859-1?Q?KGNJFeDbpRXvq4bvNl2bHDC/qZ9TIF8aLF4KOmwdghaIRWQU4IaN5XHSyJ?=
 =?iso-8859-1?Q?dnjlp+oOWffm0HWakIJ4y+Wq7Y0RNMeMDSpXAZdq8QX4N30fbNfeAW4rS9?=
 =?iso-8859-1?Q?0MeNo30Oyd6plJD3WL/huMC9JZlyIOX2le9BfTB87030QhItlQq/A3pU62?=
 =?iso-8859-1?Q?3MY9mE2HB4KOOp/TKQmcWiPCUhpUmfUfEdTdqs5iMSlmDkGA712DjWAPA3?=
 =?iso-8859-1?Q?bvtQgQ+mSXGU/IyQgT2IYE+DTYxvNx9b96wyHJ/fgINEiwHeWnwQEgRZkz?=
 =?iso-8859-1?Q?yBq5JcjmJ3sVIgvdEhSb12fHErZNtC1JjVyO23EG4ORgwU16nbGk8PVRWl?=
 =?iso-8859-1?Q?HBzOsdJpNcHBxccbKwaaYANHmwaw6uZfajW/LLK6I1k5+fmhC6Mmcew8jQ?=
 =?iso-8859-1?Q?JkNk1Ul3kj6p0dk1AJgdWpe6BbrwpVIU1Ka8XIE6Q3GG6Uo3E1sY5WgMyz?=
 =?iso-8859-1?Q?9IieKThYRAelbF+ilCm9n6EVGwFkYuefRj1+msewDffuHM0V6bYnLVLPLA?=
 =?iso-8859-1?Q?hOM6pn36snGmfo7EgjZ072KVEpFClEpxF1ORxTmg8apcW30eA0SVuHz7mf?=
 =?iso-8859-1?Q?QHsrYiBJg9uJOYZS7gZGoq0WtbCUZt6ozi0F1zcblmroAUCwngPdXiX1le?=
 =?iso-8859-1?Q?MhZ/VUT/P8fAo3uVW8HzH4mtye/y8HZBa0Q3Utv86aM+fPRJqVg+JsSHZ6?=
 =?iso-8859-1?Q?ltXNQkjCaodzRQHdx5//EZE8o9JeKnJCSuL0OM7ByEv5NmZvsQDJwPDcLj?=
 =?iso-8859-1?Q?7ZvG3jIHVapn91/f/NfJ+Zoiqaih1t0gB9+KYNOxgAfnmiXRFAjpKETgnJ?=
 =?iso-8859-1?Q?BWCAxB0OBqO+VVBsbtvRqNmnIWH7jck29noqqZ0Wa7eHsg5WJsLBgrdhus?=
 =?iso-8859-1?Q?+N2NtuaDYVJu73SB12+vjyMNNS2IT9u0FoMO4KvYi/nOdiO5ig4tU5VG31?=
 =?iso-8859-1?Q?EaVOft1Lhtrz/ycZgzR7q32sI8DvQOSJIVsgYoglVGoc3IRYfAzDPAtRE5?=
 =?iso-8859-1?Q?dKX5MOxhEbAhFZhv14CxaUWHQx+Jyj+WLdPy7mfQ4C7ItQPujTfQLJiG9Q?=
 =?iso-8859-1?Q?RGavlZuQHbAjksBxPAHdqMjpXoMQ3msYQFUWxDPmQN7FWawoY4igrTUd87?=
 =?iso-8859-1?Q?cZQJ2gJ18gRY8eNmjF77eB47IZ0wxxS1RcS/5kG5uAJWpSuVJoxWY4Zx45?=
 =?iso-8859-1?Q?4RZL/pJsxtmc8/Z2rYcsmy0ypSKFFIei2spoY1r1Vaa6PcAYf/UREewrdY?=
 =?iso-8859-1?Q?nW9pPxqOpnANSnJgFVb071Qc3vVzQoGBPhm4r0Tfiw2eUZzcBCkcXZDIL3?=
 =?iso-8859-1?Q?/jECRbFaMA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p6Ep367LLzQVlIrzAnqg2sty86GDtgk9hsa20CeRl4J4cy1Cp0bP+R+DHwc2ezxzclrhsl5nj4vbc+fZ0dty1wwIY3hY/q0gEiegvNPyJFdhixFULLzOgjChoSnzUyAV+qP9hzgJaDNbkylNZM0nCu9EvRzbeiVLqqsSMtk4I0tzmYEi6+UgF5dF3RBkwS5/4wJQLBFnNUe1qw22m+2AIqO1c0QkVZtbgRbkB3FzL12JjKSvMh/9/QlplyPQfcfy3E28KB0/QvAIdqacDSQblkg8fJr1h4CqLGLQOSk698blfx0vt/c3kfaw3MQqCSde7pXwFBXgruOktkQwA3ENoQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6783250-4210-45d8-3887-08dedbee4fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:31.9661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veHiYsQwrUR4CylWOpumucM1hPr4VkCz/oPrUOxGeUDg9+t/gwmcde31j4+dNHBN0ER5s8BATN0QFMM7dfs1kPDAcjOBJYtUbX7wVY239RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

AST2700 supports a Data FIFO mode where flash accesses can be performed=0A=
directly through Data FIFO MMIO offsets. The Data FIFO start offset=0A=
increments by one for every 16MB of flash address space, allowing the=0A=
chip select (CS) to be decoded from the Data FIFO offset.=0A=
=0A=
This change adds Data FIFO support to the Aspeed SMC model and introduces=
=0A=
a class callback to translate Data FIFO offsets into CS indices. For=0A=
AST2700, the Data FIFO offset is matched against the segment start address=
=0A=
of each CS to determine the target flash device.=0A=
=0A=
The SMC register region size (nregs) is also extended dynamically=0A=
based on the number of supported chip selects to cover all possible=0A=
Data FIFO regions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/ssi/aspeed_smc.h |   3 +-=0A=
 hw/ssi/aspeed_smc.c         | 113 +++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 107 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h=0A=
index 76831422c6..640efade94 100644=0A=
--- a/include/hw/ssi/aspeed_smc.h=0A=
+++ b/include/hw/ssi/aspeed_smc.h=0A=
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {=0A=
 #define TYPE_ASPEED_SMC "aspeed.smc"=0A=
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)=0A=
 =0A=
-#define ASPEED_SMC_R_MAX        (0x100 / 4)=0A=
+#define ASPEED_SMC_R_MAX        (0x300 / 4)=0A=
 #define ASPEED_SMC_CS_MAX       5=0A=
 =0A=
 struct AspeedSMCState {=0A=
@@ -116,6 +116,7 @@ struct AspeedSMCClass {=0A=
                            AspeedSegments *seg);=0A=
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);=0A=
     int (*addr_width)(const AspeedSMCState *s);=0A=
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset=
);=0A=
     const MemoryRegionOps *reg_ops;=0A=
 };=0A=
 =0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index d87fbd798c..c399503294 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -163,6 +163,9 @@=0A=
 /* Read Timing Compensation Register */=0A=
 #define R_TIMINGS         (0x94 / 4)=0A=
 =0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO       (0x200 / 4)=0A=
+=0A=
 /* SPI controller registers and bits (AST2400) */=0A=
 #define R_SPI_CONF        (0x00 / 4)=0A=
 #define   SPI_CONF_ENABLE_W0   0=0A=
@@ -212,6 +215,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[]=
;=0A=
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2=0A=
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4=0A=
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08=0A=
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10=0A=
 =0A=
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)=0A=
 {=0A=
@@ -228,6 +232,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSM=
CClass *asc)=0A=
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);=0A=
 }=0A=
 =0A=
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)=0A=
+{=0A=
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);=0A=
+}=0A=
+=0A=
 #define aspeed_smc_error(fmt, ...)                                      \=
=0A=
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS=
__)=0A=
 =0A=
@@ -764,6 +773,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr=
 addr, uint64_t *data,=0A=
 {=0A=
     AspeedSMCState *s =3D ASPEED_SMC(opaque);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(opaque);=0A=
+    int cs;=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -789,6 +799,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwadd=
r addr, uint64_t *data,=0A=
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);=0A=
 =0A=
         *data =3D s->regs[addr];=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, a=
ttrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1163,6 +1185,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hw=
addr addr, uint64_t data,=0A=
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&=0A=
                addr =3D=3D R_DMA_DRAM_ADDR_HIGH) {=0A=
         s->regs[addr] =3D DMA_DRAM_ADDR_HIGH(value);=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        int cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,=
=0A=
+                                          attrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1909,6 +1944,39 @@ static void aspeed_2700_smc_reg_to_segment(const Asp=
eedSMCState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Convert a data fifo offset to a chip select (CS).=0A=
+ *=0A=
+ * Data fifo access starts at 0x200. The data fifo offset index is=0A=
+ * calculated by subtracting the data fifo base offset from the MMIO addre=
ss.=0A=
+ *=0A=
+ * The data fifo offset index increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * The CS is determined by matching the data fifo offset index against the=
=0A=
+ * segment start address of each CS.=0A=
+ *=0A=
+ * Returns the CS index on success, or -1 if the offset is invalid.=0A=
+ */=0A=
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,=
=0A=
+                                                  uint32_t offset)=0A=
+{=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
+    uint32_t start_offset;=0A=
+    uint32_t fifo_offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < asc->cs_num_max; i++) {=0A=
+        start_offset =3D (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;=0A=
+        fifo_offset =3D start_offset / 0x1000000;=0A=
+        if (fifo_offset =3D=3D offset - (R_DATA_FIFO << 2)) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -1943,6 +2011,27 @@ static const AspeedSegments aspeed_2700_fmc_segments=
[] =3D {=0A=
     { 0x0, 0 }, /* disabled */=0A=
 };=0A=
 =0A=
+/*=0A=
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0=
x200.=0A=
+ *=0A=
+ * The data fifo start offset increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:=
=0A=
+ *   256MB / 16MB =3D 0x10 offset steps per CS.=0A=
+ *=0A=
+ * Data fifo start offset for CSn:=0A=
+ *   0x200 + (n * 0x10)=0A=
+ *=0A=
+ * Examples:=0A=
+ *   CS0: 0x200=0A=
+ *   CS1: 0x210=0A=
+ *   CS2: 0x220=0A=
+ *   CS3: 0x230=0A=
+ *=0A=
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)=0A=
+ * to cover all possible data fifo regions.=0A=
+ */=0A=
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1962,14 +2051,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->flash_window_base =3D 0x100000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1997,14 +2088,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x180000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2031,14 +2124,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x200000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2065,14 +2160,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x280000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

