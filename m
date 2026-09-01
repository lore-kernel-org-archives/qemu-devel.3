Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E257BC624A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1EU6-0006Jr-DP; Mon, 31 Aug 2026 22:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1EU5-0006JY-56; Mon, 31 Aug 2026 22:44:25 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1EU2-0003Kq-9C; Mon, 31 Aug 2026 22:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1v/7HrMFXcMZgY7KIRSTJAGzj3mBnDQ6Wy6rKEOKv6Lh0Su+hZlKKP9SRJXuAsXr/02EdFpvzMSx3ex4sSAMywCA31PIwRif8Fl+3MZKtmDANak2KW9+O531azdnlLpfIe/RBVpRhOq3P2zlWoe4kUHLKYtCTQE6KD0NGECgAUDngxy32HsEMs0bN1VeUfJSbSLeBR+caleXKz/kguO/tUDlVN+hvgct50bI3B43qkIFwgDZVw5UpuP5DQ8z5Y0MNYB6ey95CCf+G5A3fdbwR97exvvsZetWRcIGOiLmqcti22vuqvZHontVAPXmSlhuZMM+qOjMjqKVqabXKiPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp/w82jFrUCgFrw+r5XjaSCOJHZNlACpQuvKlgNQF4Q=;
 b=yeRHoTJw3lhFFb8z10KQNlyDvMh8NDgs6dL4AUtW327PlxCxYeoio/aUoulbQG2VyYXJiOMhoMth0uKgnZemVEmm6TxyLa9fwrCrhyKRr7yk43kJ6WaaPy8+lfOqkzlGXlGjlrkvnVnoiWRFz8ByKb9PoYrNWjlDRn8ETJOJBlWN0gZuQXzfoDqqTsp1xslRt99OxXgc/L0KlhoznbpZ+WGCzbIWzD/V1v0u6gpirzggxz4dguTv13NuMInFJbkRWkgwCG+vGIUxkBNmuffai2SMmjErpY6vrqyDUVkdxljeMd8zuF0aE4dcItsxCLIQSRlMXJEcIe+Z13aOcr89DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp/w82jFrUCgFrw+r5XjaSCOJHZNlACpQuvKlgNQF4Q=;
 b=BYlEr22BlWGYG/oLEODhgT3YChUfe6UAsQK+SzoQhiBxWzvF0ov1rnjbmUQgQieYtONQoJehohq4kjWZdBR535wuQf8ldrAQsLO8SVptIdkRXe1/aBLGD/L/pMgfhQyl2i8GmeHa1K068l0Aoi6K9I49QQY1lENkyWJxu4bCY5L2WnKHSrHutSa/ujj+ZRisfBTYEnJW8+nqeGRyJqyM+bOamW50cF3qap2mDBq/6dakN8aMpSYjoFc8O0YDF/y+67STMxwCMArfNCDk5NiVQRhz78ZgGuu5ef6KEp9f966YT58HtMMv6F+U3MToXoJ8nu6cgx+Wjm6lILmpC3s2lQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI4PR06MB8448.apcprd06.prod.outlook.com (2603:1096:4:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:44:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:44:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Topic: [PATCH v4 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Index: AQHdObvBEVGKEHcSKEunCfqFgQDgsA==
Date: Tue, 1 Sep 2026 02:44:05 +0000
Message-ID: <20260901024400.3488429-4-jamin_lin@aspeedtech.com>
References: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI4PR06MB8448:EE_
x-ms-office365-filtering-correlation-id: 6a7a0aeb-7916-49af-6f9d-08df07d2e3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|6133799003|10067099003|5023799004|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info: /tMFMlP/iBiZ7N/jGf/9RV2UFvqktDVID6tIFKDA4hB7liKze9aNRyky4SWWecR7VF4R6yucjWmXvht57FkRqQpq1ZTmgmHjhz4MqGrbRiiZSh0gjiI/7Ktr8eaeBIwZ6S3gUldqjUndkv6EDT3MES2IMZy+K6iPk0QhKinjmeqb2PXgLZSX6X6HStBTdrDbWxu9KX1chVDf5niP6QqGUR9bIJ9Zs+x11qYWFmFTPFaEtPyjUb0Q+g9JNO7et80EOZg1sjRxG2U3o8QzZ1DYCkoUVlpIXejWY9lBhaQkAIsvafjfpoNGOM5sUqm/P+loB+TjWbFQKA2v668GjdSAn4NaelZJ9oOMtW8845QDO3wfawvyOyJHcTBMP1gI6GEPg2jWEAraTA4XLM6e1swTjYiFgbBUWAAjWtj3EGLlrujoLiIYG0+eU4/bR8RHAo5A6bHT7lEH/7zUnQPfo9SgmMrkYH03Ky6/msb6Tb6wUCp+WpZyTCptMPZlBEnD34wQCHOIV90ATsnMkTTbNaTX9m6LoPkxrMg7saao0tUGYMc4oyJI5ytZkoSDMMVrdRxfguo9t85BJYX4pCQUGymLfFku8vh4A5yo1hafSR6OK752YWCCR5aO3xZqy++PLxcBzvRmtVpSctgK6jk8gLj1qnmaHm9lyiDnMTzN0Guywwzjnrm002beYaN+5jYGPIAmJWLWFM1GumuJHtWEecUasoQNPGZcCYTRfvvHIPHgPNjNI6Mzo/wGHcoci2zz9YeO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(6133799003)(10067099003)(5023799004)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vh4vfjfq56dtiNzAqLLxzqNIfjwrigoCDxchmTXMIpIQ88nWGXcGIdbKQA?=
 =?iso-8859-1?Q?6b5sQhzNk6Y10xEaoSkdj8/sOluphCMYCW6Emag7GTQ5PDNCzBbZcHJBgJ?=
 =?iso-8859-1?Q?TlKOfiRjr7/beCovSUeRybjUjWyeq+7qMqV8TWm0TBb2WRYMBwstiksz+W?=
 =?iso-8859-1?Q?z7VlFp8fJA+9JOuGGyf4R0albd37I1CLzsVb+oDC42DMZIg6KCXHPAsPG5?=
 =?iso-8859-1?Q?uCWnvezSVe9QU1U42bLELQGKKmI1gnfoMC+JgtI6QvYSik0onKmjrvalun?=
 =?iso-8859-1?Q?SiLsZ7disursYxDbkELBU2TArQRrk7ff1IucYv4oribPsamm541rbkVOZf?=
 =?iso-8859-1?Q?FocX2yLuWyPZBV+V/adqXRO9xA5HfdIaHTa8hlE3mvqdcpIHXeN8AT6tkB?=
 =?iso-8859-1?Q?33aEKkZjAJfXqSgoiQNjdo4nBOnVYxSSij/CIYZpoHvYZEueUFt02NHUGc?=
 =?iso-8859-1?Q?xiOU7/7pKnN6gVA4zPEIPRLd0JO5LfyiKqe/H0iVBaYDjA/nbaQFFeLBYp?=
 =?iso-8859-1?Q?yTXFs4TEGInbhlr7tYsnuw1epaeuko+TWnEIltCnx2Kuv4+6DwoMPvF/Op?=
 =?iso-8859-1?Q?lUXHxUiYHtwfDfyUI0jxnooHRHBSCFMMtp7rfeLBiB5Xnyy2MhZJ+yPcLi?=
 =?iso-8859-1?Q?9ybkQNHR1olECKmQ+D73n9FERxQOh2FdGshM3NcHuZJnfG2fJoz54AHOh8?=
 =?iso-8859-1?Q?JTO4s9XVYcAYCvVQ9JK+xH2+BIGpV8pmiuGrZiXooq1OP0SKG0+mCRrPeh?=
 =?iso-8859-1?Q?LfYyQeVhhSKKH0hC3i8fDg/o0zCTHiC20wkAnpl5KotEGPj8UC53mOihtK?=
 =?iso-8859-1?Q?sMURQDUea5G6UlRRlxN9G6KgYG8+bSl2mQC4HqXgN60B12gmuojpv1dxDB?=
 =?iso-8859-1?Q?JL6okfcHyhp4o8mWvp1FgBBalcbhM9HecwoQjzNwGlI1KuiLyLyrs9UBWe?=
 =?iso-8859-1?Q?jHNwRRO+MVq0e3OqoWowwjYd4qldjXWcdydWgvLLor/Nmrb+w3G5av1Zdk?=
 =?iso-8859-1?Q?W/wH6+KDpSldYOB120lxRpG1vnCF0CJRJs6D2xzALZCxysTcx9teGCroQA?=
 =?iso-8859-1?Q?k5T+5dWGNu0NzL3dvsovVmy1jyL/ns7ub2lQoH6UYs7v0G3qDdAVZLfspr?=
 =?iso-8859-1?Q?/jT5QgR49xOIpIp84IDU4ZgkjUgtfeq3n1Sl9xUq//uHns6Pfruim1Ke43?=
 =?iso-8859-1?Q?2gPdo6HwnH6nLfj1QUK4fCnU3UN48moVcmJpH9kNaQPNGjsq3qYqQZgiQI?=
 =?iso-8859-1?Q?XJzCemBahXruX80GMZktlmpX/7Okrzcp7ZogcG8MwVHnzj29x49BjUc/A0?=
 =?iso-8859-1?Q?ZyM/U6sE2SBxcCbkk2gx5yJkdbeK7vmc9xrj44tvNyN5339cpxaJUoNyou?=
 =?iso-8859-1?Q?R9aTf77YMvCmZhDYEgsJu2GI5q9voYP5OCuwApzsryi8rKmzrqwwn9Ld/D?=
 =?iso-8859-1?Q?M/G+wDMN0aFoUJvLgYFUEXFvUlCXhbXFAqJwapfAIV4V5VJlwfK7Jb51Wg?=
 =?iso-8859-1?Q?A50nbsOOeZZ6kgRhfWIfPKTSvAiWIko5EV0I1fJDsvxwBBMOVCD/TdSbEo?=
 =?iso-8859-1?Q?03YmnVfcKNuh8DU+f2Me2xU0XrrgBadcHZD5zCSuZhX0CJXUUFk1vkpMDC?=
 =?iso-8859-1?Q?sYZV8y+Q32DIqI9hADXxUmgQ+Av2C+vQUBJM5N2r1n9C37Q+CXhnCWbPCz?=
 =?iso-8859-1?Q?hXB9w1g6AjqdvViokvChzZIz4byhHQlCr1v27yJlDW65mfyzPahN7l5WP0?=
 =?iso-8859-1?Q?O9mfjzGLR/bh4zC+mZ2J1UlpUb0sA/OEpKMAsXnEB9q+9l3dRjVzsG/fnZ?=
 =?iso-8859-1?Q?lLgtl8gD3g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r2v3nZB/CCrWY4OiFyC0eJioFcFJg4TfHuit6IQNI3TLWXXvguXZ4C9t0OFGpqWx3Yt2RNeZc3xuSOxP0a1HouTBXSHy45PrF3zToUeLlPEbJsDk1Bn1WJDk3nQdxaJrPYTZ6teueVMetCc+5vj3uznBF7wxcp6iJAYDMCa6xdkot7JdNHFIbW4564r1PQFWdLan6G12ySVfkkaoURsc9Z3HXpOX7R7ZIcCd2LFpx5RnKNoLPwAe6lL+fAytvdglATPdGTWvd3t4OCpb+sq6z5e6RMFh3SC2ctYhfBvKeXd9BHZyNT1E28xtsdHo2YFLcv6Nx2dbF/t/z4ZAQ+W0PQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7a0aeb-7916-49af-6f9d-08df07d2e3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 02:44:05.3556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeD2oMcVGk1+Ovv9iBPRIim3Rt8OZ7TSfWBwqY1ldyPoZfsCFhb99v20wpve/DqtI5YoUkhnqew+ulC662Uw4oqGiZo5rPht1fHpfyZhMBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8448
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

Add the bulk data plane for the four programmable endpoints. The gadget=0A=
driver queues IN data through the descriptor-list DMA ring and arms OUT=0A=
buffers through the single-stage DMA registers; host bulk transactions=0A=
are served from / delivered into those.=0A=
=0A=
The DMA mode is taken from EP_DMA_CTRL.DESC_OP_EN: IN endpoints use the=0A=
descriptor-list ring, OUT endpoints use single-stage buffers.=0A=
=0A=
A transfer larger than one host packet is served across several polls,=0A=
with the host packet parked (USB_RET_ASYNC) until the gadget queues (IN)=0A=
or arms (OUT) more data, then completed from the matching DMA kick.=0A=
=0A=
With this the gadget data endpoints work, e.g. a mass-storage gadget can=0A=
be enumerated and read/written end to end.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   8 +=0A=
 hw/usb/aspeed-udc.c         | 457 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   4 +=0A=
 3 files changed, 464 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index ab9d016c61..7701c1aa34 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -42,6 +42,14 @@ typedef struct AspeedUDCEP {=0A=
     MemoryRegion mr;=0A=
     uint32_t regs[ASPEED_UDC_EP_NR_REGS];=0A=
     int index;=0A=
+=0A=
+    /*=0A=
+     * host packet parked until the guest gadget driver queues (IN) or=0A=
+     * arms (OUT) data=0A=
+     */=0A=
+    USBPacket *pkt;=0A=
+    /* bytes of the current IN descriptor already served */=0A=
+    uint32_t desc_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 70a2296062..a6eaf6f97b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -72,12 +72,37 @@ REG32(EP_DMA_CTRL, 0x04)=0A=
     FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
     FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
 REG32(EP_DMA_BUFF, 0x08)=0A=
+    FIELD(EP_DMA_BUFF, BASE_ADDR,           0, 31)=0A=
 REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
 =0A=
-#define ASPEED_UDC_EP0_MAXPKT      64=0A=
+#define ASPEED_UDC_EP0_MAXPKT   64=0A=
+#define ASPEED_UDC_EP_MAXPKT    1024=0A=
+=0A=
+/* DMA descriptor ring (256-stage mode) and descriptor data limits */=0A=
+#define ASPEED_UDC_DESCS_COUNT  256=0A=
+#define ASPEED_UDC_DESC_MAX_LEN 4096=0A=
+=0A=
+/* DMA processing-status idle codes */=0A=
+#define EP_DMA_CTRL_STS_RX_IDLE 0x0=0A=
+#define EP_DMA_CTRL_STS_TX_IDLE 0x8=0A=
+=0A=
+/* DMA descriptor (DES1) fields, in guest memory */=0A=
+#define ASPEED_EP_DESC1_IN_LEN(ctrl)   ((ctrl) & 0x1fff)=0A=
+/* interrupt-on-completion */=0A=
+#define ASPEED_EP_DESC1_INTR           BIT(31)=0A=
+=0A=
+/* Result of moving a host data packet through an endpoint's DMA */=0A=
+typedef enum {=0A=
+    /* whole packet transferred */=0A=
+    ASPEED_UDC_XFER_DONE,=0A=
+    /* not finished, keep parked */=0A=
+    ASPEED_UDC_XFER_MORE,=0A=
+    /* DMA failed */=0A=
+    ASPEED_UDC_XFER_ERROR,=0A=
+} AspeedUDCXferResult;=0A=
 =0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
@@ -97,6 +122,14 @@ static void aspeed_udc_raise_isr(AspeedUDCState *s, uin=
t32_t mask)=0A=
     aspeed_udc_update_irq(s);=0A=
 }=0A=
 =0A=
+static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    trace_aspeed_udc_ep_ack(ep);=0A=
+    s->regs[R_UDC_EP_ACK_ISR] |=3D BIT(ep);=0A=
+    s->regs[R_UDC_ISR] |=3D R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
 /*=0A=
  * System bus device: MMIO register interface (guest gadget-driver facing)=
=0A=
  */=0A=
@@ -330,6 +363,288 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
+ * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
+ */=0A=
+static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s, int ep, uint32_t =
addr,=0A=
+                                      uint32_t len, USBPacket *p)=0A=
+{=0A=
+    uint8_t buf[ASPEED_UDC_EP_MAXPKT];=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t seg;=0A=
+=0A=
+    while (copied < len) {=0A=
+        seg =3D MIN(len - copied, sizeof(buf));=0A=
+        if (address_space_read(&s->dram_as, addr + copied,=0A=
+                               MEMTXATTRS_UNSPECIFIED, buf, seg) !=3D MEMT=
X_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d IN data DMA read failed\n", __func__,=
=0A=
+                          ep);=0A=
+            return false;=0A=
+        }=0A=
+        usb_packet_copy(p, buf, seg);=0A=
+        copied +=3D seg;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN transfer: send data to the host by filling its IN packet from the=0A=
+ * buffers the guest gadget driver queued in the descriptor ring (from the=
=0A=
+ * read pointer to the write pointer).=0A=
+ *=0A=
+ * One host packet can be bigger than one descriptor's buffer, so we copy =
from=0A=
+ * several descriptors in a row until the packet is full or the ring is em=
pty.=0A=
+ * If a descriptor is too big for the space left in the packet, we copy on=
ly=0A=
+ * part of it now and copy the rest on the next call; desc_off remembers h=
ow=0A=
+ * far we got. We move the read pointer to the next descriptor only after =
a=0A=
+ * descriptor is fully copied, so the guest gadget driver can read the poi=
nter=0A=
+ * and see how much was sent.=0A=
+ *=0A=
+ * This function raises the endpoint ACK by itself when the ring becomes e=
mpty=0A=
+ * or when a descriptor asks for an interrupt.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep=
,=0A=
+                                                 USBPacket *p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t desc_base =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t desc_addr;=0A=
+    uint32_t remaining;=0A=
+    uint32_t desc_ctrl;=0A=
+    uint32_t pkt_space;=0A=
+    /* des_0: data buffer base address, des_1: control/status */=0A=
+    uint32_t desc[2];=0A=
+    uint32_t offset;=0A=
+    uint32_t chunk;=0A=
+    uint32_t dlen;=0A=
+    bool done =3D false;=0A=
+    bool ack =3D false;=0A=
+=0A=
+    if (mps =3D=3D 0) {=0A=
+        /* a MAX_PKT field of 0 means the maximum packet size */=0A=
+        mps =3D ASPEED_UDC_EP_MAXPKT;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);=0A=
+=0A=
+    /* walk the queued descriptors, filling the packet */=0A=
+    while (rptr !=3D wptr) {=0A=
+        if (address_space_read(&s->dram_as, desc_base + rptr * sizeof(desc=
),=0A=
+                               MEMTXATTRS_UNSPECIFIED, desc,=0A=
+                               sizeof(desc)) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d descriptor DMA read failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        desc_addr =3D le32_to_cpu(desc[0]) & R_EP_DMA_BUFF_BASE_ADDR_MASK;=
=0A=
+        desc_ctrl =3D le32_to_cpu(desc[1]);=0A=
+        dlen =3D ASPEED_EP_DESC1_IN_LEN(desc_ctrl);=0A=
+        offset =3D e->desc_off;=0A=
+        /* how much to copy: min(descriptor bytes left, packet space left)=
 */=0A=
+        remaining =3D dlen > offset ? dlen - offset : 0;=0A=
+        pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                    pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+        chunk =3D MIN(remaining, pkt_space);=0A=
+=0A=
+        if (!aspeed_udc_ep_copy_to_pkt(s, ep, desc_addr + offset, chunk, p=
)) {=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        e->desc_off +=3D chunk;=0A=
+=0A=
+        if (e->desc_off < dlen) {=0A=
+            /*=0A=
+             * The packet ran out of space in the middle of this descripto=
r,=0A=
+             * so only part of it was copied. Stop here, and leave the rea=
d=0A=
+             * pointer on this descriptor: the next call resumes copying t=
he=0A=
+             * rest (desc_off remembers how far we got).=0A=
+             */=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * This descriptor was copied in full. Advance the read pointer to=
 the=0A=
+         * next descriptor and reset desc_off so it starts from the beginn=
ing.=0A=
+         */=0A=
+        rptr =3D (rptr + 1) % ASPEED_UDC_DESCS_COUNT;=0A=
+        e->desc_off =3D 0;=0A=
+        if (desc_ctrl & ASPEED_EP_DESC1_INTR) {=0A=
+            ack =3D true;=0A=
+        }=0A=
+        /*=0A=
+         * This descriptor is shorter than the max packet size, i.e. a sho=
rt=0A=
+         * (or zero-length) packet. In USB that marks the end of the trans=
fer,=0A=
+         * so stop here.=0A=
+         */=0A=
+        if (dlen < mps) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+        /*=0A=
+         * The packet is now completely full, so the host has received all=
 the=0A=
+         * data it asked for. Stop here.=0A=
+         */=0A=
+        if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       RPTR, rptr);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    /* The guest gadget driver completes its request when the ring drains =
*/=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        ack =3D true;=0A=
+    }=0A=
+    if (ack) {=0A=
+        aspeed_udc_raise_ep_ack(s, ep);=0A=
+    }=0A=
+=0A=
+    return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
+ * buffer the guest gadget driver set up (single-stage mode).=0A=
+ *=0A=
+ * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
+ * bytes per call, continuing from where the last call stopped=0A=
+ * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
+ * copied.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int e=
p,=0A=
+                                                  USBPacket *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
+    uint32_t remaining =3D p->iov.size - (uint32_t)p->actual_length;=0A=
+    uint32_t data_buf_addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(remaining, chunk);=0A=
+    uint8_t buf[ASPEED_UDC_DESC_MAX_LEN];=0A=
+=0A=
+    if (data_buf_addr && len) {=0A=
+        len =3D MIN(len, sizeof(buf));=0A=
+        usb_packet_copy(p, buf, len);=0A=
+        if (address_space_write(&s->dram_as, data_buf_addr,=0A=
+                                MEMTXATTRS_UNSPECIFIED, buf,=0A=
+                                len) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep %d OUT data DMA write failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, PKT_SIZE, len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    if ((uint32_t)p->actual_length >=3D p->iov.size) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    return ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to tell us it queued =
more=0A=
+ * IN data to send to the host. If a host IN request is already waiting=0A=
+ * (parked because there was no data before), send the data now and finish=
 it.=0A=
+ * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
+ * the next kick.=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
+    uint32_t new_rptr =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
+    uint32_t new_wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /*=0A=
+     * A normal kick only sets the write pointer and leaves the read-point=
er=0A=
+     * field 0 (the read pointer is ours to advance). The guest resets the=
 ring=0A=
+     * by writing a read pointer that is non-zero and equal to the write=
=0A=
+     * pointer.=0A=
+     *=0A=
+     * We check non-zero as well as equal: on a normal kick whose write po=
inter=0A=
+     * just wrapped back to 0, both fields would be 0, so an "equal" test =
alone=0A=
+     * would look like a reset by mistake.=0A=
+     */=0A=
+    if (new_rptr !=3D 0 && new_rptr =3D=3D new_wptr) {=0A=
+        cur_rptr =3D new_rptr;=0A=
+        e->desc_off =3D 0;=0A=
+    }=0A=
+    /* store the guest's write, but keep our own read pointer */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);=
=0A=
+=0A=
+    /* nothing to do unless an IN packet is waiting and the ring has data =
*/=0A=
+    if (!p || cur_rptr =3D=3D new_wptr) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
+ * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
+ * buffer before), copy its data into the buffer now and finish it. If the=
=0A=
+ * packet has more data than fits, keep it parked and wait for the next bu=
ffer.=0A=
+ */=0A=
+static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* nothing to do unless an OUT packet is waiting and a buffer is ready=
 */=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
@@ -346,10 +661,31 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
                                 unsigned size)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
+    AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
 =0A=
-    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
-    e->regs[reg] =3D data;=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_EP_DMA_BUFF:=0A=
+        e->regs[reg] =3D val & R_EP_DMA_BUFF_BASE_ADDR_MASK;=0A=
+        break;=0A=
+    case R_EP_DMA_STS:=0A=
+        val &=3D 0x77ffffff;=0A=
+        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
+            /* IN, descriptor-list mode */=0A=
+            aspeed_udc_ep_in_kick(s, e->index, val);=0A=
+        } else {=0A=
+            /* OUT, single-stage mode */=0A=
+            e->regs[reg] =3D val;=0A=
+            aspeed_udc_ep_out_kick(s, e->index);=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        e->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
@@ -375,6 +711,8 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
+        s->ep[i].pkt =3D NULL;=0A=
+        s->ep[i].desc_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -468,6 +806,95 @@ static void aspeed_udc_class_init(ObjectClass *klass, =
const void *data)=0A=
  * through the MMIO register interface above.=0A=
  */=0A=
 =0A=
+static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)=
=0A=
+{=0A=
+    uint32_t cfg;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        cfg =3D s->ep[i].regs[R_EP_CONFIG];=0A=
+=0A=
+        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||=0A=
+            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        if (FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) =3D=3D is_out) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        /*=0A=
+         * No IN data is queued yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. A NAK would make the host retry slowly.=0A=
+         * aspeed_udc_ep_in_kick() serves and completes this packet later,=
=0A=
+         * once the guest gadget driver queues descriptors.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully sent yet: save the packet, wait for more descriptors =
*/=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_out(AspeedUDCState *s, int ep, USBPacket *p=
)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+=0A=
+    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),=0A=
+                                 FIELD_EX32(sts, EP_DMA_STS, PKT_SIZE),=0A=
+                                 p->iov.size);=0A=
+    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {=0A=
+        /*=0A=
+         * No OUT buffer is ready yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. Writing now could use an old buffer address and=
=0A=
+         * lose the data (for example a mass-storage CBW). A NAK would mak=
e=0A=
+         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this=
=0A=
+         * packet later, once the guest gadget driver sets up a buffer.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully received yet: save the packet, wait for the next buff=
er */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_udc_gadget_handle_reset(USBDevice *udev)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
@@ -531,17 +958,37 @@ static void aspeed_udc_gadget_handle_control(USBDevic=
e *udev, USBPacket *p,=0A=
 =0A=
 static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
-    /* Programmable endpoint (bulk) transfers are added in a later patch. =
*/=0A=
-    p->status =3D USB_RET_STALL;=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    bool is_out =3D (p->pid =3D=3D USB_TOKEN_OUT);=0A=
+    int ep =3D aspeed_udc_find_ep(s, p->ep->nr, is_out);=0A=
+=0A=
+    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",=0A=
+                                 p->iov.size, ep);=0A=
+    if (ep < 0) {=0A=
+        p->status =3D USB_RET_STALL;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (is_out) {=0A=
+        aspeed_udc_ep_data_out(s, ep, p);=0A=
+    } else {=0A=
+        aspeed_udc_ep_data_in(s, ep, p);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    int i;=0A=
 =0A=
     if (s->ep0_packet =3D=3D p) {=0A=
         s->ep0_packet =3D NULL;=0A=
     }=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        if (s->ep[i].pkt =3D=3D p) {=0A=
+            s->ep[i].pkt =3D NULL;=0A=
+        }=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 098c3d6179..80ead23358 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -389,3 +389,7 @@ aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"=0A=
 aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t i=
ndex, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bReques=
t 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"=0A=
 aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val =
0x%x, dir_in %d, off %u"=0A=
 aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"=0A=
+aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_id=
x) "ep_nr %d, %s, iov %u, ep_idx %d"=0A=
+aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
+aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
+aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
-- =0A=
2.53.0=0A=

