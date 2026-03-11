Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AB6FD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dym-0003au-W5; Wed, 11 Mar 2026 03:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dy0-00034Y-Uo; Wed, 11 Mar 2026 03:26:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxy-00052x-H3; Wed, 11 Mar 2026 03:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO5cqh9xAfSatlUPz6vF5KD9wL26rP4tp0IR6pwnImPmHRdtfDFcSOpVSomoJJG5F762almhdogpDZ94FuSChdonU2gZNPj46XiQq4uwI+h0U7Sb0/fq8ifGe4XuQmHb+Yup2hFdnSvWJKEV2W9j/G5ioIADQcellME/RyjB7UilIDTcrtWQZJIaohYgYm6ymB6QayQ0vUlWRLK0Zi2BSE2nzGMN90c01uqm4b2jbmJs06zvnJ8moy9A5F9ypU2377h629r5QeV654zxK+txVzFUsPGbgpFjZOLZQNXba8DZJxbqD7DABCQ6lHjoFerml5rJ9CVYXWW7rLFoOn83Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h85VlOVaMjPSy2KNQayuveM5e/PP8jbr44KugwkvAlE=;
 b=T0+s9RZsCMk/th13pClvehzNPoNBmOz37zzwCZtBwPnLdeqEMLzzQPYBvL3joSpZt0II60BjQQXGIi9vLzlBnPDnKYs5ZBypaWujsmn5XoEy29fcf+eR3biLRCqyYObFmV3AUG5XsINpymn/oQAkoC5QNeSz9bz3ImWe5vuf/0aW1iumSa2FSj9VqN/38QLTNXhrKSr0VQhjOqLH50wHCw2j1e3/BsGoqh3+xfg9TD4cOdQOcJpaj4pItKkTfiHCkKj7Y3uOae56Ru0u+jOc7KIwwKWl/3ve+U0yE/BI0ee1S3omYIMViF3yeKHq8L6GL0dmbfRWlEmHSmey7qztrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h85VlOVaMjPSy2KNQayuveM5e/PP8jbr44KugwkvAlE=;
 b=QczaOwwbImbi/EfG+4uOaqktAx3Q/voKwqfQ86JyYX3cOoiicQSSrWVYhqCnLhuKpMS4KVspNtBAC7Ysnp38wjZGLiTBgf4W6fY387ZR/2RENqJDEBXIIrHMqL56+iunw4oQkTgpgLIgByEKCRIAQD2ItzWJbArOYoc6/Cd7ejXUPUDUZJLd/1twn5xMXSZMr5P5visgpOggB6aadHsh0yuTLAjHBDYW2E7B+vaqjSp+hfaTeqglG7TW8tcVjtwICjuo/ak/SEiAay+La1pPsdhNRRgkNVTl8Fwz1TySNqYrnr7J76/I+O9q4sOq62IsvIjHuul6qqr+KWbcRZbSog==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 10/13] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v1 10/13] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHcsShf3pApiBV3g0Sxi09yXzc0aw==
Date: Wed, 11 Mar 2026 07:26:27 +0000
Message-ID: <20260311072614.1095587-11-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 2827f082-c78d-40f9-17b2-08de7f3f8256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: tFBupl0qQjfWfZVkH8wSjuf3gr30dE7+MPE/h72T9ujy6VetORiN0fbwN920KX5tmFjUu5qIElz/u6mUlSBaDC/xcKa7x9+A2NufM8OzOLUj95/vcVN6gsTqXR+cw8cBH2VY4+ZPvwlRhqtAZsucWjV/hFp4TrllqNZ8sOtuEcZQ3SU9rYaBDT8zwcgpuAZKSMuQR0B9Z+9CZw40u1a9izxmiDNzVkMmbVA4STlQj6sTx1T9+2L+Vm/QBounN5ZhlSOvR2ghGdu0AKSGf9qJHRSw36CvEtyj7uMchSlxIQzQabtZAuDRvjch6+JvXV+NwsufR+Pz/hYAMlyb1ZCah4M8Z2+wI3wtYskCs9qkrPAg6D9pRZgwH/7DNC9f8yUpQX3RROif3fkkIDNHvMoN8Q/rjQoIvPHU0hHHO78C7Yt3LW5IUrJkYIHRDJYwHWAnQdiXcFcoGss0qMKFBK1nW9noUirCbRxhSLLSCKgvRAFLoe5eEzBXiuU0hajNNFBtlhxqfWLx2bmzX1i8lcXWTT9i60O887XWqlSypQGOc+Gl58FJIVml1T1PVimk1B/X/BfT9xfaoGV8XoxmMSa3xS7xnz77OWJT8M8cRzJORddV//Wz5/usUXy3KyUT0CQolI7qowndK9zTcZo5Wdy7ciT487Iaxbywnkmg5E/Qvdrhq4m8q0tvJnEWoH0PEVDD2uLNUMWPwHVla7zCG7nFUJWTp0NuKjDMY44bF/vwSc6sINEcfWjjFPjINalkYyuMcvCnD7P8vRYjypnuR+MyGahFd5quwJbiJWBYE4TtGZw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H7lB2oyrHw3jaN/HRAbXgssZXWGgsNh/SRgach2AoGWKFymbYtu7yM4jUF?=
 =?iso-8859-1?Q?nZ+NmRV6cedclFk2359Be8rdM2aDnOpDovP5iM/OOaywgCo75PTDBk1AsC?=
 =?iso-8859-1?Q?TF2dc18DIQUzFIOncnvWZXNL6T+ddOxjDPZO/ZlYeZQfSp4PfJ0tWL4Nsc?=
 =?iso-8859-1?Q?t/PpjsFOTpKPRM3sxjWDjqh/HCbnT3dd4FJ1Hz0F/BgRTq+xKnRt2uRU3T?=
 =?iso-8859-1?Q?CZ9wfBuZH9W41NU06xoiMLeiSzZo517No4bU8PQqcsG1ujNvErmJlujK6X?=
 =?iso-8859-1?Q?ByXrnwbfx3viebWP70w0KAV32U+rdhlAll4d2p7GFg3C5lMeTC+Pwy9Vwd?=
 =?iso-8859-1?Q?VYAOHRCBcOjzJq03mM6YxUbOXEzgDxhd4pORf7mwaNgMm+3V9KaCHyLm3G?=
 =?iso-8859-1?Q?Ef4LTTfNH/VujvPrgd4FgpCZ4NJKW7682ykRoknBllsBHdgkeVVKz2b7GA?=
 =?iso-8859-1?Q?Mlbn7ha3zxBy/tQMCtxO0UeqflhN7zr059BZB0TXuYPa0p+wWIy4kpOHlk?=
 =?iso-8859-1?Q?pwKhTZag4w9iRN6xQOK2/8noJhYhz+8eTeb4/9KdkZoB/IKNpB2Ffjn8i9?=
 =?iso-8859-1?Q?U9uaJN0zAeHSpuq6rT9Tjj7W8yhy5EQ36yCGGVvxSRAWI0eKQyzSBwJVJx?=
 =?iso-8859-1?Q?6J3/o+f62Io9IcddG/azPY9WZEIIS3+X6tPXwDT4/xBu3xBQdiiUJnR+wc?=
 =?iso-8859-1?Q?Y3Obz2tiwKURkfylKpGLJ9INzRZWGGT1l25J3mxDpmDXwPMalndf7e1iAN?=
 =?iso-8859-1?Q?RpLPrY7XGq5WHajmyp45tFfNbkI3maH0a45GNtpNrJenAQ5yeQ8yrXn3ex?=
 =?iso-8859-1?Q?ChJCMGQ0jF7OHnrBilLIhWf1ZX34WAFlD0ELQSJaAauqYsdU2UaDMtgvA3?=
 =?iso-8859-1?Q?N6ZeYtv5FEixk9hoOrDKiHzrWCfKGCokKCgtrXAZWCj+d4Eaz981SXKDjr?=
 =?iso-8859-1?Q?taDxt+V97a70uU7mzQBfAKO+w4zihD8L4xnUMaqE3ZpmUCLVDIavI54tNu?=
 =?iso-8859-1?Q?dOsfV755Ebzw1lSIWMGsA8UXofj/JZeB/1zsK0VEJ7e0iPdkTTE7LjVARL?=
 =?iso-8859-1?Q?lPyfdA4MpSGW9eT0S6Cqeh4tBVFRcHIqp+5OOWsFIyLm8c0cRj9nsrrByq?=
 =?iso-8859-1?Q?eceB5BpgLI1eWEud+L3l8N78DIoyoEeESIGCBfxUsbFtXs3gvwi0ab0Hqd?=
 =?iso-8859-1?Q?rHDFpadn3ffgjp0RIpMxH5FI4IiwSa/hLKLfHk1aMEyR2nKjSWO338KIQP?=
 =?iso-8859-1?Q?bz2OLxzcq1Lh2FD0W8gAXr4WzPjB35vqq3H4EKO9cSt63n6mi6O3kdQKVt?=
 =?iso-8859-1?Q?PJckfU+tZEBP2JXJQU2GBcdwKUxwpAzKYhoKzUBnCA2d45H/KJGC4RdfOj?=
 =?iso-8859-1?Q?K26pQwduyCkzgy0/XzxYbhqM6z994AHoPIJDB/SNAPkRB6b5JIHrjdys2j?=
 =?iso-8859-1?Q?DtLDpbfEshFqLMuvrAxWhjcUNrttbFCJAKZ6YFYzZKtcDCzF+i65J/XGG+?=
 =?iso-8859-1?Q?4xv//qPggq9QK357fcfdItHBVVCBha4On6picURJOZxrGBRTrgd8uixtnF?=
 =?iso-8859-1?Q?2+Jo9qB+eqTJceww6xJy0khQUdEkQ5e7zvkYdj63ueYuiJXOhod5oBaiYx?=
 =?iso-8859-1?Q?26pJc1ZWeD5IiU61guw9JsU9Sdcg4MNvEp3qERSOseqGZrcE51yFHSfo3s?=
 =?iso-8859-1?Q?yg7PjRtEiGvSdLUW1T8qFbVuC6HwJ0LsyzwF0bheYrYmfp+uT7vpgPsecE?=
 =?iso-8859-1?Q?eCW4HehyQ9z+wak5Eyx7PILzBYLiaz8opwGe0W324EfITvrq4XwZUKSsDn?=
 =?iso-8859-1?Q?JDdL4SWuAw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W+ZczArRVb13MiFc/zLtw7GRV8+4C27ljWpn6+SlGrfLTSmCqiO+st2MXu/uPzhW5rzxn4Ma8mVdMfJOQAywAY7m0NlMRjOqKY6oC7UIsAIc8hqcxFtiTeaKs+SagtkTU57Dz2EooNLb8Ll7CKZsFgq81VtPMJo1SkaZPTCmD9XNWpaikDnn2E1738broxsefsQihgvYhH7PGPEtBc0NTLH+Xl/rGA/KgfDfX9dvKz7ZlMPZcNoSWx+AsndfYmRFDkb7L52KTCa3j/XIRZ6tzT/IndT50GprTuhuAFwBENppmXsK+AvVHOd8gqje963qSHHGYBwFzpKwBMXgiLoWAg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2827f082-c78d-40f9-17b2-08de7f3f8256
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:27.8632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2YnwCVtKbErea8nl54a/l6Tlhyktl3bsqiZwja2N9wh/O+TgH5ByDaCkd3iz4jZh7StjZC6PeCAhGLqPSSJS93Ba8bOnv3wv8grChquhPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for siTD buffer pointers.=0A=
Add bufptr_hi[] fields to EHCIsitd and use ehci_get_buf_addr() to=0A=
construct full 64-bit buffer addresses from bufptr[] and bufptr_hi[]=0A=
when processing split isochronous transfers. This allows buffers=0A=
above 4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 2 files changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f0cb50ba45..a11d4179cd 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -119,6 +119,7 @@ typedef struct EHCIsitd {=0A=
 #define SITD_BUFPTR_TCNT_MASK         0x00000007=0A=
 =0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
+    uint32_t bufptr_hi[2];=0A=
 } EHCIsitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index a4a45c7601..d9d1ac2d28 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1798,7 +1798,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

