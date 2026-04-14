Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B5CED7B86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhc-0003co-4E; Tue, 14 Apr 2026 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhZ-0003aA-2T; Tue, 14 Apr 2026 04:00:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhW-0005mG-Vw; Tue, 14 Apr 2026 04:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TevAsJ4Cmw8Ib8xR6XKE7rjmv0AKVI9ovGfNmmnsk9DbuKU6mJf4DoAQBYlPN/lATYnxtCcqEC1QH+MYb0IPpIzytb3K+/i++MzBxAKRTZRsoGVx6g+jz854ykeXLbEoWe+beOnP7523eEZCAV+NloARCmdgtOElLlKWl41XgOZOa47YpJCK6CnF0FYoAlHOun4g2l2L6CVs3eBp/ENYaOtVxeo0RjZWp+CPWx6YYoyTLBjxQlrwHHlAGpu8FVkFC6qK4sn0pqN3kSME2OjDnaHWrbz2zxfAvfSTnBAXq5ED1ElXA7WzfprPTSVxS83c7TLGpS0h/lkrOL4NxFSNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6usZ5mXShBCQUWpF5kXm4oFlG2iJBMpiedjEUoqbNs=;
 b=J4a+s2ci5/+BV3fehzGkfo5859lqHCXQzB3YqozBaVR2B8Y9V+oBXJ6NKzBEKU2Dws/l0Gt2cGQe9MtM61bomuN/P5wPWNK5Mby/LW7NETk8tqji/sHuugH2WynOHi0U6BIUhuqC9l5ZCq1E+zsD//W7TxDX5z9jxjBg1AjNsWDIm4GQsW701UoWpJHHPU0dVG9Tik3QQiO/lH/8gTqd+lHn1hWsyvKyVwE2/RcLK9/+Vt+aJfRidchuQtN3LurHFONVxMMNytrOvNFHEseuhdUC36AvgU9LNi2Xih3LX2+679rswP8tRGtC3t/ZflfGX3mdi8LgIrKcRlGxlBojmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6usZ5mXShBCQUWpF5kXm4oFlG2iJBMpiedjEUoqbNs=;
 b=BLGdGc/wjNGdGiThDkjw93+DlKapxRrT29y/XVuml+iCEJx8ytme2woiC/fnpH/kJ9LMWugxDY8DUdqu//ZPKMj6LvS2nBzdSb+O3fCUiaRI0wY0ymiAcbA6JIGfrTXB9x2/x9sIZh1TJNcpdLNKd//J5Jieq5OaOuTwJIs76WbQr7ijqpQANEYSNocB57qB007dbRaJoWSq7Jl1vzF+ii1g6WnZn12m+7FNJUizVqQPkTlI69RZT8m+EMtbYiScQj86P8/lrRZEjdH9z7hV3Auwafq2e2HhuduveY0lTn2+BP2RIWa8LZ3QwZ+PZLdberovgPsCeyM0GslGhvqxJg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6745.apcprd06.prod.outlook.com (2603:1096:400:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 05/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Thread-Topic: [PATCH v2 05/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs
 with trace events
Thread-Index: AQHcy+TE5hvsGeJpgkGHytOuSshyKA==
Date: Tue, 14 Apr 2026 08:00:32 +0000
Message-ID: <20260414080025.3005916-6-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6745:EE_
x-ms-office365-filtering-correlation-id: cf982349-d447-4955-227a-08de99fbe6dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: lHuwosqcuehK1AJrmnocPphK3GHzszDHlGSLbWPDeyjiI7csRi4ec7zgu+QLGPVjK+82tj5in6U5yQBS/Y16caM/T846ZRzEZoZQGRgfnPW/wknvXWuwhAYw2m5xP8pGET+T3XwjVxTrQttH4TUutjEjLadSKTNNWgHZlWB6zgDPUetGoWzM14HMd0U1Z/AslbAxi7RTawgg1xAByq1DD0onkQLI69Mb8y55iWrdQwdTl/Gp7EsdRtKPqpeefYfumWgonlxC74599mwWFY9hbAjrHIRNvyjYUG3ksKj7/j57CHVyyhpYjOrtNFo8VqSYhEwR4E/t72nWh8+oWE76jNEMfYGdQ2VlC6J/JXMf7erD2O0BJndKeItp1nqW1GiCY4t0AyrUSTEMmZYxJy9kKySRR4juGyi3IEPEzUnkOIgMwmdnQ3bJZ45ZmRXrpWbnMt5vvafLZYVrlGBtFCiu3q3s8MC86qX62Plx74DXNpa1UkfqYu7vC9q6KRNR0he2YCi6OEAnKzrlrFf+ymPXmgmgChfdkaPPfe2GEH697QBzw3pDjbSGedX8Bcb06S6jvH2y60uYMRGFcHSD1bLL52u3MLyLAkUE77J6iGfKIsHtlP9q/VLHx6+t51y+GfUx2yOJg/1M5JURNje+kITAmNsnxHzjTMraSyXJOUW6cquiEK5SZknfH+TtHAxQGkddkA7InmtI5o311bWkDa6F4/6C1a8wfGg5OKJX4xuaV4qjxc5y2BYjYhvdfxxeapeh6Vmwp0rOCRvs4sE8cfP6JKVVa3BVD0/ZM048QkOmWjQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u8F3U8lsV9S/WYjao8vu+7B+ek+2Mget0CCAPyLqRVMIPu1gMjugS9qWPw?=
 =?iso-8859-1?Q?Lprz1s/Yqo51GrCtidUqDulFFunMmaWUz5Du4+aQGnlCLarQYDzBQfgCd7?=
 =?iso-8859-1?Q?ySlX4MSkKXKTUTY5kuLyL9RV6ISaACx0Tnc2TezOg39Kc91iNY6kH2DxWQ?=
 =?iso-8859-1?Q?jvX24qZlc9ronElPKUNRPEuLMzGuMm9/+ewaNJk6Ta9uKp2xmm/TGT4ZNS?=
 =?iso-8859-1?Q?9OpkaTjGb49GHTTVENFuaA3rrJP/zMRnFvPTPRerODJ9+nqI7ytFxSfYet?=
 =?iso-8859-1?Q?7hSgz/MiCZi2pFzhCYRUlFSFJy8UJEqlRM2OPQLToAKhC+HXlkfzWADo4B?=
 =?iso-8859-1?Q?SFnk8jyqPM3vqQr8cdnXRtUjp6lW/1XLVLM2i9hXoGYL7K1yYWC4wacGy+?=
 =?iso-8859-1?Q?MprZdjDMS6h+o61AuScSKd+/G6be8e1JMSUSEfPEmPXG1XNKS7TJTTxe1C?=
 =?iso-8859-1?Q?oKbLGUAgYEWKxEwoNJ1Rdy9T8mIN60A1t8kaXkLdTu+ZQguDSSpLUBqPUl?=
 =?iso-8859-1?Q?ZBFC9q5KTWckx9go7rt6ed2S4zqwZ6NrE0Sec92+H4VzoEo0i6jzPKAnrk?=
 =?iso-8859-1?Q?2IpnIZ4Vags8Abdb8aE6VX+JQ97zXOI68XioZ8AeZU6zaklgxqOfNRcbe8?=
 =?iso-8859-1?Q?5M2UFOldSg8l8lUS+pKfwH6RcXNKSLJYj2tIM7t3hxsMcpsBuzTm/7Dqq2?=
 =?iso-8859-1?Q?oJzpZtaojJnZDM8iLIGK33qBUgmpX+4YeG6wg02seCZfaZGn6Gy7wQItrI?=
 =?iso-8859-1?Q?43MF0eHNHXvGXNUik5+cceeAH8qYuhQSBwFBxXAf3dcqUpNl0wDFgWKx2Q?=
 =?iso-8859-1?Q?k6kb4qnvidE/B9Z2AMDy8ELkd9TSQKdBBYmgtQ1/V1uCIgxOnwyFAnNAjU?=
 =?iso-8859-1?Q?B434VJ2kOuz/UWEdil3i4Y4HgJsPaGv1tc7NhVJxg5HF56Nz4jz/2nir+O?=
 =?iso-8859-1?Q?7SKt6GfeMdMlqMFwG4Xn6dmlzGqwFX0nJ9ioMi86GPNJwqdoYi96XsYE4y?=
 =?iso-8859-1?Q?m+Q3p6F8Hd9mj2xYMzvMGDxwzHmhOzUfUTMSwjKs4TpoAUdSfdh61A1n/H?=
 =?iso-8859-1?Q?xaAQoMUvnMTOuZn3NYXEvy42Mre1ElHTUaSAUmPwNYeGh13MayCQNc8t6R?=
 =?iso-8859-1?Q?/PKjNdRCYcB9pbW78dZ3VRkPuW9M1A1hTjvOp9pjCPwGUH3DuRCuF94oAo?=
 =?iso-8859-1?Q?RC3XwZTNbXfaZnYGQ/ymOiOSSpmDp/6lBfVFfx2+WaS/2fjT8xByB7pA9D?=
 =?iso-8859-1?Q?5TBjvz8rzWEPN7OUEhKUX+6GO4rmPkLD/qAS1eB78vA8XtbzZqxV14xsyD?=
 =?iso-8859-1?Q?usNqt1ztnFZ+ZH9G1/dxMfsDBnhSh0anF7SfTUaGs712gDUtdWfDaNg0/b?=
 =?iso-8859-1?Q?510QIPJ1MvtAtMOW4TuuxAlqXaevca6xuKVaPdShHdaMomdWVwbHpMRwtJ?=
 =?iso-8859-1?Q?eNfKfgs1TVcAyAvblugIhpEu1gGIppnsRqi3KVCvB6rPrI0UDnwvehEVDY?=
 =?iso-8859-1?Q?/E/V1aqNhd3nmr+qAQHSuvGf/iXyRUZGLZCm90hWm2CI/yzyYxMDK+Wysi?=
 =?iso-8859-1?Q?6kU35/mGjKIt8LmtpLss2hJpILDhoe2W2JREoKyTswKC3xtYBKDdCyJgnc?=
 =?iso-8859-1?Q?2kTWuHRLnfnYI2DohvvvyYuZXaiej5AkcNtKM9GHd7v3aKz7bZaXF7pOa4?=
 =?iso-8859-1?Q?Kdk4EYCRvLkaFoGbrGl/3uXhFP9z+6m70sErWLDoHMAcdi3jDoQG4Hi0m4?=
 =?iso-8859-1?Q?Hlb4jhYy09r8vxkyPWC8sxabi31ulhfqOCSqAPKGJCNXDzL6oZtrvtco/Z?=
 =?iso-8859-1?Q?m2R10IHoKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wAt0LZtmTK4WBjNYgluYSVRtDPKiuauCfHyy/4YAgGXlvP/nYSJFLyBn5Hoe1lUEs779HaDina/JnhXauMDcl+Fid1pqDkPlBBeW9Wj5TrEMRKSjbISfkOVMaos96/WNt73DB6xTsChFgVdwIZPFhbgDR81W+xtE/xmJE5G2/xoMjrsShCa1pmCSX62PT+9o+tdqwgc86D6+JGtv/lQT7XfI5KRXSlIw9A5wfxuRnwJnGmKyFOkeIMq6cqk3Z1XCUngy/6TLqgRXU7cSbLebHtMBijmgdJZXQd4Txxsazisr0EIDtzTN+/4L8jxDmwM3KuYkJVkNrNOg3guCIzBGwA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf982349-d447-4955-227a-08de99fbe6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:32.2014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMF2q4+TkrevANoClYuBvrLpKLeGn99DvahqoOFOhhaPwEJ9GWYvXvBepcVg7YK9MVv1dPR4Cl+6hjemrHK6tzdmRCWQF5tndo1+eNjdw+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6745
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

Replace legacy DPRINTF() debug logging in the EHCI host controller=0A=
implementation with QEMU trace events.=0A=
=0A=
The EHCI_DEBUG macro and associated DPRINTF() definitions are=0A=
removed as they are no longer needed.=0A=
=0A=
Trace events are added for:=0A=
- packet submission and completion=0A=
- queue head execution state=0A=
- periodic schedule advancement=0A=
- ITD error conditions=0A=
- port state handling=0A=
- skipped microframes=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   | 10 ---------=0A=
 hw/usb/hcd-ehci.c   | 49 +++++++++++++++++++--------------------------=0A=
 hw/usb/trace-events |  9 +++++++++=0A=
 3 files changed, 30 insertions(+), 38 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 736407fd52..4234591cb4 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -24,16 +24,6 @@=0A=
 #include "hw/pci/pci_device.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
-#ifndef EHCI_DEBUG=0A=
-#define EHCI_DEBUG   0=0A=
-#endif=0A=
-=0A=
-#if EHCI_DEBUG=0A=
-#define DPRINTF printf=0A=
-#else=0A=
-#define DPRINTF(...)=0A=
-#endif=0A=
-=0A=
 #define MMIO_SIZE        0x1000=0A=
 #define CAPA_SIZE        0x10=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index bebd137f94..d0ea4949f9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -839,7 +839,7 @@ static USBDevice *ehci_find_device(EHCIState *ehci, uin=
t8_t addr)=0A=
     for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         port =3D &ehci->ports[i];=0A=
         if (!(ehci->portsc[i] & PORTSC_PED)) {=0A=
-            DPRINTF("Port %d not enabled\n", i);=0A=
+            trace_usb_ehci_port_disable(i);=0A=
             continue;=0A=
         }=0A=
         dev =3D usb_find_device(port, addr);=0A=
@@ -1281,10 +1281,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     assert(p->async =3D=3D EHCI_ASYNC_INITIALIZED ||=0A=
            p->async =3D=3D EHCI_ASYNC_FINISHED);=0A=
 =0A=
-    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "=0A=
-            "status %d, actual_length %d\n",=0A=
-            q->qhaddr, q->qh.next, q->qtdaddr,=0A=
-            p->packet.status, p->packet.actual_length);=0A=
+    trace_usb_ehci_execute_complete(q->qhaddr, q->qh.next, q->qtdaddr,=0A=
+                                    p->packet.status, p->packet.actual_len=
gth);=0A=
 =0A=
     switch (p->packet.status) {=0A=
     case USB_RET_SUCCESS:=0A=
@@ -1327,7 +1325,7 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
     } else {=0A=
         tbytes =3D 0;=0A=
     }=0A=
-    DPRINTF("updating tbytes to %d\n", tbytes);=0A=
+    trace_usb_ehci_qh_tbytes(tbytes);=0A=
     set_field(&q->qh.token, tbytes, QTD_TOKEN_TBYTES);=0A=
 =0A=
     ehci_finish_transfer(q, p->packet.actual_length);=0A=
@@ -1392,10 +1390,9 @@ static int ehci_execute(EHCIPacket *p, const char *a=
ction)=0A=
 =0A=
     trace_usb_ehci_packet_action(p->queue, p, action);=0A=
     usb_handle_packet(p->queue->dev, &p->packet);=0A=
-    DPRINTF("submit: qh 0x%x next 0x%x qtd 0x%x pid 0x%x len %zd endp 0x%x=
 "=0A=
-            "status %d actual_length %d\n", p->queue->qhaddr, p->qtd.next,=
=0A=
-            p->qtdaddr, p->pid, p->packet.iov.size, endp, p->packet.status=
,=0A=
-            p->packet.actual_length);=0A=
+    trace_usb_ehci_packet_submit(p->queue->qhaddr, p->qtd.next, p->qtdaddr=
,=0A=
+                                 p->pid, p->packet.iov.size, endp,=0A=
+                                 p->packet.status, p->packet.actual_length=
);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -1472,7 +1469,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     usb_handle_packet(dev, &ehci->ipacket);=0A=
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);=0A=
                 } else {=0A=
-                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n"=
);=0A=
+                    trace_usb_ehci_log("ISOCH: "=0A=
+                                       "attempt to address non-iso endpoin=
t");=0A=
                     ehci->ipacket.status =3D USB_RET_NAK;=0A=
                     ehci->ipacket.actual_length =3D 0;=0A=
                 }=0A=
@@ -1675,24 +1673,22 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehc=
i, int async)=0A=
         if (ehci->usbsts & USBSTS_REC) {=0A=
             ehci_clear_usbsts(ehci, USBSTS_REC);=0A=
         } else {=0A=
-            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status re=
set"=0A=
-                       " - done processing\n", q->qhaddr);=0A=
+            trace_usb_ehci_fetchqh_reclaim_done(q->qhaddr);=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
             q =3D NULL;=0A=
             goto out;=0A=
         }=0A=
     }=0A=
 =0A=
-#if EHCI_DEBUG=0A=
-    if (q->qhaddr !=3D q->qh.next) {=0A=
-        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
-               q->qhaddr,=0A=
-               q->qh.epchar & QH_EPCHAR_H,=0A=
-               q->qh.token & QTD_TOKEN_HALT,=0A=
-               q->qh.token & QTD_TOKEN_ACTIVE,=0A=
-               q->qh.next);=0A=
+    if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
+        if (q->qhaddr !=3D q->qh.next) {=0A=
+            trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
+                                       q->qh.epchar & QH_EPCHAR_H,=0A=
+                                       q->qh.token & QTD_TOKEN_HALT,=0A=
+                                       q->qh.token & QTD_TOKEN_ACTIVE,=0A=
+                                       q->qh.next);=0A=
+        }=0A=
     }=0A=
-#endif=0A=
 =0A=
     if (q->qh.token & QTD_TOKEN_HALT) {=0A=
         ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
@@ -2154,7 +2150,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         /* make sure guest has acknowledged the doorbell interrupt */=0A=
         /* TO-DO: is this really needed? */=0A=
         if (ehci->usbsts & USBSTS_IAA) {=0A=
-            DPRINTF("IAA status bit still set.\n");=0A=
+            trace_usb_ehci_log("IAA status bit still set.");=0A=
             break;=0A=
         }=0A=
 =0A=
@@ -2221,9 +2217,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
         if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-=0A=
-        DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
-                ehci->frindex / 8, list, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
         ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
@@ -2291,8 +2285,7 @@ static void ehci_work_bh(void *opaque)=0A=
             ehci_update_frindex(ehci, skipped_uframes);=0A=
             ehci->last_run_ns +=3D UFRAME_TIMER_NS * skipped_uframes;=0A=
             uframes -=3D skipped_uframes;=0A=
-            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",=0A=
-                    skipped_uframes);=0A=
+            trace_usb_ehci_skipped_uframes(skipped_uframes);=0A=
         }=0A=
 =0A=
         for (i =3D 0; i < uframes; i++) {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index dd04f14add..0d4318dcf1 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -89,6 +89,7 @@ usb_ehci_state(const char *schedule, const char *state) "=
%s schedule %s"=0A=
 usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uin=
t32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0=
x%08x,0x%08x"=0A=
 usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int =
devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"=0A=
 usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x=
 - c %d, h %d, dtc %d, i %d"=0A=
+usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"=0A=
 usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) =
"q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"=0A=
 usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pi=
d) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"=0A=
 usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble=
, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacte=
rr %d"=0A=
@@ -100,13 +101,21 @@ usb_ehci_port_reset(uint32_t port, int enable) "reset=
 port #%d - %d"=0A=
 usb_ehci_port_suspend(uint32_t port) "port #%d"=0A=
 usb_ehci_port_wakeup(uint32_t port) "port #%d"=0A=
 usb_ehci_port_resume(uint32_t port) "port #%d"=0A=
+usb_ehci_port_disable(uint32_t port) "port #%d"=0A=
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"=0A=
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %=
s"=0A=
+usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, i=
nt pid, size_t len, int endp, int status, int actual_length) "qh=3D0x%x, ne=
xt=3D0x%x, qtd=3D0x%x, pid=3D0x%x, len=3D%zd, endp=3D0x%x, status=3D%d, act=
ual_length=3D%d"=0A=
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask=
) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"=0A=
 usb_ehci_guest_bug(const char *reason) "%s"=0A=
 usb_ehci_doorbell_ring(void) ""=0A=
 usb_ehci_doorbell_ack(void) ""=0A=
 usb_ehci_dma_error(void) ""=0A=
+usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%x, next=3D0x%x, qtdaddr=3D0x%=
x, status=3D%d, actual_length=3D%d"=0A=
+usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, recla=
mation status reset - done processing"=0A=
+usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08=
x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
+usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
 # hcd-uhci.c=0A=
 usb_uhci_reset(void) "=3D=3D=3D RESET =3D=3D=3D"=0A=
-- =0A=
2.43.0=0A=

