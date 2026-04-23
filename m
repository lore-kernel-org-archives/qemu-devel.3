Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEDFFAD40E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSP-0007Yu-Mf; Thu, 23 Apr 2026 01:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSN-0007XG-Ti; Thu, 23 Apr 2026 01:18:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSM-0003JZ-8W; Thu, 23 Apr 2026 01:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxofDcK6hVZWd4l9TVlMvetFlmr7u1tuEc32e1TJ8kogNu4mfga738CSLqwwPHQI20eeR40ap/d5o6lf8HvtZ2gL8g5r1mHpgKOOWEsS8MsAsBmhkqWer2QCnaFvCHgJgsjHZ/5oc7MH/M881khWMB/b07KyRoMceLYd5wZaq2+Opx7kri51Z4/k+x9h7ERQzbB9TRwslxZWDMdJdwLDJUcJr++SrD/Y9QUKc4iRDUvpatpn5Qf0pSfXbe6Acg6heB9HLmZObHCwELd/1k3EuA1yJOfe6GmIiElehs5uOJstx3cZETd6fYcJiyWBnXVa06frQE9KeVGcCFKCTNRk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eveFVAaUFisGuhujS70jnFNAwW7AmFpatrP7xxv5VQs=;
 b=KTD4ygpY3kacQLea0DdOE3R4+kd47NSE8R21p/HTvv8ppVoBSzoWpABX2QKjFKrRca1Z5tOXWh6wLoAusCGiv3PGC0HKxHFxBmoZJXCdapDcK02Je4W+ufxqaX6IKQnt1clNzRJ28H/bmCTbOBbkMM/QkOdX+rh2uctMnleLsDDe8YmpjckxbGKxw+HvnD1zUbbwd0UNl+DbulEuGXdJ6IiRvNx2QNVwAtygDJfssjy6/UGBZQHxLKbD+9u0If27y8mnn2vwpa2QkseC0ole1zZVwoU02cn9Xag/099HPJpMZYwW5rV9FdKW+aWY3B3HycHS8FkiLqtDRzLlp1r0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eveFVAaUFisGuhujS70jnFNAwW7AmFpatrP7xxv5VQs=;
 b=ehQQlkUR5PaRdyM3OkdyITzjtt8G7bpgk3h2/9x4A94JFDz7b/yMkXR7n1W14jnH5r4HYPZ1543GXMjkhIDbxfItDwxguh9zSd9WrCI2DUdafQUNSsM1KPKidKmXld56AIge2Jpn4tJZLHUHWEGH8GyS6uo0SddeMH3IDHkVfdg6AYHaH1p1Is4TPEko/VWpzqIm5s5vdMC7lI8d+w8wKWzw4APDaIp0ioTufaLPNQsWYTZ3Ir7gTAd1SLP20lNmjJ5y4zxiqiDpa4qANPN3mhsFYzhPbXFEUyiFWk5EHFWef27ooo1YveotfSK63AP7VjMjon6Ffxdk71M7CkPzgQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8434.apcprd06.prod.outlook.com (2603:1096:d10:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 05:18:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:22 +0000
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
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 14/17] hw/usb/hcd-ehci: Add ctrldssegment-default property
Thread-Topic: [PATCH v4 14/17] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHc0uCaXuRbyxdTQ06stlVwb/096A==
Date: Thu, 23 Apr 2026 05:18:22 +0000
Message-ID: <20260423051804.362095-15-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8434:EE_
x-ms-office365-filtering-correlation-id: 095c2925-b27d-405f-f99a-08dea0f7bd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: exuxnnuFoL69wQgQlTBNgNHzcFJKl7JMklIczxKxJArMXSuDd486HHoCdGJ2hFAED+ln+19idLV4FWa5dqrNUS64HaKkEIh1B11hsjqafVZC5tEItY0/+P1l+mIWLIW+QmeKOzcOgLvkpCeUuEd+x91zZghJ7DmTEbjx4z2kw5+ycqC0jGbp4iQ/fV2tsaBfFYa7cXYaumD4CroLFf9KmpLYCxVA54t32VHGI4QbiFlFvVAdmn6BLj64Vq5/ZUY2YTxDznly2aPbhmF1PHitb7s9iG/ktMKAiFwyGvw2RSbwncgNR5Z2CRs3ggYpkvVo2nOHYec1Qp52VLXwlucvqHkQ4vAxtleaCGOeSNrrKTtGKteFAJM8uBBmw6FkkQoltKZ+gMWuvrcWeHe1iz0weBEY6mP/X6EzYQxUzuNtquUdG867foSViyO3SkWjq0pNEdGjwNYVjxCE7RleOwgKpS2Rt0akAGhgyl6optV0YK0sExdTaZBWtARDIE95+sxFw9FBq1T/62hc69X3oZJPgFv2Y9FIn7TM7KUZ6cdg3gff/NhDlYzlC1l1TG9CS4mgze5CcQem9Az5WA3CrxAO41XRY64lOwfboHRYpXz57uz+e2s+GFbBgNIrYECJ0S7sYvPqj2MNkLI2hH2lzyjTTJKBf9XYS3pt9/o0yOEpsA8CexqSTczhaqBtEhyjhNthhVgerzLqiKOtc/LRPBo2W2dzeozNZ2SEEdd9FQ4TsUcpsZh38h0xamxciPyV/2hKLcSWXqvSima+WfAuWaGpLga9KiEJI1xK1TYWFkCxAN59F3cAgm/EWgV7Rv5TpPOo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w/Zb42IR9LfFs57hd+sOHGKBT9h7ln+jUruVavMp30AoGzx2Hm1LlBLS1u?=
 =?iso-8859-1?Q?6Jvm0zXJWbj5tMIxB2m5CoPBNpYCygPhrvoTlxWkrGIVDTzg5tlfUi5mXP?=
 =?iso-8859-1?Q?IxirOg64iHppjc47xjC4OewAuikcXxg4hEzGtF23OM52lk14NCTtua35jE?=
 =?iso-8859-1?Q?8Wk48KZS/JTpYreI99LRilvosQcc/gnPuOaHMykFQCvPHXTUhW23eHriQJ?=
 =?iso-8859-1?Q?OGN+Jj7VOtFgsK2W8a0DmiFQ8tlFmQdcrnt3j6OpO5HVxYx50a41jyYA+B?=
 =?iso-8859-1?Q?3NNdyB6PRKEVWtl4Fg2RCu35uWmFl1luKF2tqzpLifHSVPa4OwhMgkS+lo?=
 =?iso-8859-1?Q?i6HEJg2A00kFFd/XU+E+Tbpb7U8DSnxOUToNfVaPimR6dwOZxr57Nu2OlM?=
 =?iso-8859-1?Q?PzXkhEa7kE4XauzDiFFYF4a3AIqXyAZFhqqhKPcSg9jYz2bqhdPVsTDfMW?=
 =?iso-8859-1?Q?VsHF95s2+3+b1CjdY9TNRCgO7o66SPlZLoCSBYZumrhXe2OH1o2Ue3GQG9?=
 =?iso-8859-1?Q?amK4C6pfICW+h4W+VqW3VwcDf+rq8TdXB0fFI/ZLpAOlJZ4owUonWttBam?=
 =?iso-8859-1?Q?XgCsjv9J5YQ3vIFr6ev2DqKgsk63Fn8bMoXcbgqCBL8f4QeQVeVCeuFDCT?=
 =?iso-8859-1?Q?vZsdPDOCUmA53azKdfcFFxlT1IOmW054lqTf+hodOMkhEpXnqItObl+mni?=
 =?iso-8859-1?Q?+UgTq6VOgGP22ovTi5jocn5Yfs+vzorhzRio4XGxxv1jsrZOaH/PX7hwm7?=
 =?iso-8859-1?Q?sQIGAsk1JsNvgHKDNsgZVtebgnaBBAEm0wgfM4k877O8+QYdRz9iRkpUr6?=
 =?iso-8859-1?Q?V/q+9DF62ZJJP8Z9W4nPCzJZtidVQB5npVHGZgzCQGKZgBppmP25fFPQ+y?=
 =?iso-8859-1?Q?HKccOrcN+D9vERBzBAv2AUNNvdO6SJIbvxv19wpsmcPaPUM54IGHKd3AEO?=
 =?iso-8859-1?Q?QHqee0KoRxPrL6yXI4evCSZoOjJhwmIr9rw0X1nppZlnmYe/VnNZ1SGGyD?=
 =?iso-8859-1?Q?6lTGXAxwV1H7sCoGCal+uxPsIvvt6VkYzNBFVyp4h91/aqMR6rQZInczKW?=
 =?iso-8859-1?Q?Jz6Hp79BIBXEu9sR2pXRASNTT9clTDkifbVGfkI4oHkEY2LLztl8Vo8KtG?=
 =?iso-8859-1?Q?Vq26B+/ENgan6Gb4mg5mAKa9mlTPKpok5iGLY2NfIDZZUe0AuCmUQ3aWTB?=
 =?iso-8859-1?Q?BJBLjXVhQDp1mvd7lCLGmn2VhX4Sau7Eny5CTzD1R3FDYU1TEtTpIKUweh?=
 =?iso-8859-1?Q?Gnn5v7eeyfYlZI6gul7hs5cWWYs9wJdikuCgekahf2sozrrsgoDBga5Sl3?=
 =?iso-8859-1?Q?UjRFJwe3pL7hEKJHHn7tMkZyKvWbvKjxACE3zuJWSMr6o+qIEu/1NZRK5F?=
 =?iso-8859-1?Q?g64kyG9uNpLqgDcHJZhKcwQ/EwZmb0UtCcRfJw8DTDkV7SXg86pTg7u6Q+?=
 =?iso-8859-1?Q?SQ9NDSCdA/9QW9Plj9cWRH2ewae0GcS3Y4NHXzDiakejsi1bsCu6vJg1Y2?=
 =?iso-8859-1?Q?DthRiNGkW2jT2IIRZ4zTq8bh/5gWfR5/MkTgRORyo9E09QT4m6vdVDeFLY?=
 =?iso-8859-1?Q?reaLQltCI2GdG07czu+Khs6wZXu8sFdTS1yaerH5+uhZfi/nFIrafWq73+?=
 =?iso-8859-1?Q?LA954Vykdo/ymXDrPd81GMlj92kRhRS+Daddw1CbRCpV6irS0r2q42Xb+s?=
 =?iso-8859-1?Q?BP0wmLiehmT9r2jZ5HuhkR7OKaRUcMlrngXDF7quvTOkBVjXRb6KkFaarn?=
 =?iso-8859-1?Q?3L2fos+ruAxae2TqglRW7tI7wbdJeBAp5Vt03ZU6NOER3Wkl/deILqCXc1?=
 =?iso-8859-1?Q?Pg8thvV4RQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WSjioN8iIP6OpWGW0Kk+oVWhFURRu3npXdCCSPm+ZZNmJrtDxMV72kJxJ3HlKYS6yectx60jnoeEh5N8itdccc3L8CCZEcunCuQdn6f+ceBa2x+VjmhaFVeDdfaMq7FCHWizg/G7UJUpq6iBzoioHFgWLod8XEdTqmx8zNRrKrG3kZNCSyrdYrSTyw+bQMotOtU/b0hNl43E/wD5gucOLbVwHomQrWQT7P1eUwkVR3SCnb1TQ4EMv1JxGjIGd9v2xXQo+BFdYMtpHTqMHjVJXjoZ9n1CVLWrmDgcl8LDNdDmDpX9KBAQAPv2O0sONxqtBUa/9x3otjBbvhf1IaxydA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095c2925-b27d-405f-f99a-08dea0f7bd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:22.5008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoE9YgsugZCeMuJt0UoJ3eUSZ2rFUbxFh/9VGxTSvZpEzDw6S9Odla7X9wNxTf34wpqoWi5kRqBZW73o/MxnBRwBK2o706SD+A90Oz8ghU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8434
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
=0A=
The default value is zero, so existing machines are not affected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 5 ++++-=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 8e6a8cdfb0..3d57e1de5f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -264,6 +264,7 @@ struct EHCIState {=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
+    uint32_t ctrldssegment_default;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -322,7 +323,9 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
                      ehci.migrate_fetch_addr_64bit, true), \=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
-                     ehci.caps_64bit_addr, false)=0A=
+                     ehci.caps_64bit_addr, false), \=0A=
+    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
+                       ehci.ctrldssegment_default, 0)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index dfeb8ef70f..e8086f0432 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1134,6 +1134,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
                           "      64-bit addressing capability is disabled\=
n");=0A=
             return;=0A=
         }=0A=
+        val |=3D s->ctrldssegment_default;=0A=
         break;=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
-- =0A=
2.43.0=0A=

