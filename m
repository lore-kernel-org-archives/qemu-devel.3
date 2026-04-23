Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B461FAD40E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSL-0007Uo-6r; Thu, 23 Apr 2026 01:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSJ-0007TT-Ex; Thu, 23 Apr 2026 01:18:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSH-0003DU-In; Thu, 23 Apr 2026 01:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s74rHniUq4YVNp7MZ0fTBfkHg0RQtrZNZmR11oGFKC3iZLDlK8oZAMl7yWSCs/APanbwTssNIo4n9zMi9NKriESSyLAPJakDtUaLkVNYIIxjokL11G+prEDCBGi0nX63Lrcci/6hQlgstCOKnAuZJvmiVlxsZp6rJ4QqQgA9e/xLD4h6KnN3jEnpDAQWm3WQ4+dFhvcGSKLfLWc72+cLLjbaWz9Xt0iVRelILXpsAY+s4JnejANdllmTJ1HT3zrKIxT2SrjNi9gki+n8vIzJT3sFE56iqvQMOz4YtdxNvm3cNnBEHdsN+FgTA5bTDLnpdUxxrx/Wst3HGOXaJIt6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIY1fG4h3zp2izRpjJocKSCoNpoYrGe5n8/GcTDKgfA=;
 b=eulrvtWwS+9Hg3DFhQv5p6IM7XKLRPmYECwTyY8TAx6PJ+S8My2feZMGj4xhZyjTjGl60FdwVLQi03CaaGvzpG/ovQ2e0iXLKgGL8YiqznPljbGwmUFRssd2Z6yPVD2oufDmwkwx6v6R8FUewP57npcaN7MANnnb5PVaP4bR1qNHdvHPJDoSDQwAkcdegOOCm6pIkCxH/zDi56bDTKNSnXk4zLvKnK+7lpnVvq6uxpj/lR3DJxdxP1bJuREJnjgkqJbcLys4FA8kqKOu4Hxku1MGhQE3XQYq1YvCsLiPHKgZ+x/1EIqFQlKpE/0Qd106/hu6Zucm7jkxLs6xjGSG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIY1fG4h3zp2izRpjJocKSCoNpoYrGe5n8/GcTDKgfA=;
 b=ahHTQJTLgGjvfJqW2bdghl9molVrYjzdMG6G5cqWCpZ7w2D7ELXymBIYe+QjpZ18Hxa/sirxxAFXpQnGN1cNVy6doGRc8D+n1MI6MefMP22whv7E9pL0ox47tnM5Mi5Bk4UpKMFpIdS8ICaJBHhKr+8cbBlI5uxFXDBe/YtQro7dxJtkzr1KhdL8g5xV5n1z+jh1LPvL/grvxvmQ1aKVnEC8BJYxb7Ep70jJ5D8LvyZYDr6DF1hIZEK0hJYiZAhMHfPKU75BEHR0118o5OsGrbf4Wx0WBsic9S6BAmluGa+d5DvIcVeVYN8eAF5Y1JQdfC09+no6vYVPg8KWfCw6Pw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:13 +0000
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
Subject: [PATCH v4 06/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Thread-Topic: [PATCH v4 06/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs
 with trace events
Thread-Index: AQHc0uCVz4VnYYr8ekyfkX/uN+EXRg==
Date: Thu, 23 Apr 2026 05:18:13 +0000
Message-ID: <20260423051804.362095-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 06c8b5da-f33a-4a01-e52e-08dea0f7b7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ZqYcfAxVgyc0m4uFP1u7qkE7Wgc2b0QWxPzYRr1nxVBL+8BUnfKh63fziL4C9WAQMJTQnPv7boLuSEmFWE4J7qZ0QC97HV53nv4p7P1wV1AZh/hYvO0xM3IXneF9UmFXXE6Lc2S4EFxX2TP0eTCR/887qPkeYS+3PP3hBgF8oMoC2JHDGvoLlFbF1S2U1y1ZPt+jFJIh9k61nvoOyXnQEnbaeifmAgmN3TauMT/gamh6VzwUsxHSviYiw3/TL8R78b4W7FL+61U+vet6rck6Q6W/zoja/jiTimcJ//buDJYVoTbQST4pKhgOEUohbmzd5/XtOdCLct8G6T8Q5dYbxrFZnX0ohauPmXZpQJw3gItKfh1WfUtL7/Bup0uY4ITw29S1hF+VtB0/dRoLdenG5LnmRkT+eVEIMgvRa3+NLBd02hMtSPUfxZn+yv8WG8TdLRfWnOVipXEBYZOjRqNcdA5GhUVaxwA8YIVUsI3zSkd2jkAp1Xhjw8fXEWWYmZMIcGClNwMa7QfHMLZs78a4p0oV3tNyZjHx12ptxDWC8jCTBSUJztgwKQf6PdP5KmRYQa/PUhDsG5Dx0g4m79WT86aS0XUC7AftQLEi74IhzUBS0KAVtckXIxopvGiSqYk9rBURzOJ2zjIDtjQTvtIoSZGB1upwDG1WIALr9UmTyUq7S1xQLHRyNcWlFM9eh7FjWyryUUREA2r69GLRwIkt5oAH0wvJla/aZXLUTSoQ0ARBVTbd0zJfYvKJ8gEuRU+ffqhiTmwPpP3g1I8fVlrzBF16GZQtly4oXgg+LQ/k0tg5++euQm8ZQrQnpR0u/vXD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BzTNDIoRRwINK8RaRgZ7jP211K6AbehH6s199LpFcA7TpfjfUXq203RE1m?=
 =?iso-8859-1?Q?adhSsyCMSIMKbzCkkhL9Ipa5qEcSHzg37OIbXDhtvFVSk1M4usUEuxSOmE?=
 =?iso-8859-1?Q?PWrLB3PiyHV5h3cv1y0s5brl4FGeFpnRhkQxb8CQv5pjCCtOj5ZN3N5exF?=
 =?iso-8859-1?Q?saCbmPLbnFK8DXcdN9LNF7jahlyEJvNMIFCoOYtqQag7b+sx2czim9HgwR?=
 =?iso-8859-1?Q?sGMdJ6W5VaXywztcu+ZMUv/xzUxKAOzGuZMm+nEi/10n0z/UWJtXarJ3Z+?=
 =?iso-8859-1?Q?0UfMl6mQGuSCLkl/JF0LrehgE0l0RyGz2vEBJaL7rh1Q94l1wJVX0uECYj?=
 =?iso-8859-1?Q?RHqo5Zgtg0h2jV6Od9YLI1dDAnKaxnqKaKUlZsgdv09LUkKq+ItcxBUxBY?=
 =?iso-8859-1?Q?gmD8hYiM07NOxmE/EH6/+5rZxq8PJDHBqU+GwAsJinhWMn2PqxMyVaAdeN?=
 =?iso-8859-1?Q?J8AxtLPcevUjdQ7q2WdNsWcdTgiE/5/JQMxtiYuwv30zmnK0/i/jM2Pc2S?=
 =?iso-8859-1?Q?IRZHNrOwwkdQRAfaXJ/az7mbd9RL7emWV8WWtqy7DWyaURRvAVUsQRem2X?=
 =?iso-8859-1?Q?VYQFW5AAtEnFd71/Gi0xgVs77nxUluwvPX9XZ49nZYJhvv+xCzRseCBoov?=
 =?iso-8859-1?Q?JHNphKnititNsYj6HI8g2i5UHyCa7b6YgGKZTh996Y1soRh0M3YVlO7STN?=
 =?iso-8859-1?Q?2VVbLtAKm6J+8qPnwBw8dkz2O3vz1GW01iDbJgCkE35m1JT84nxiTfFn47?=
 =?iso-8859-1?Q?Un1PHhQfhNHO5vt6qvAj13Ojehr8m6S78KYxRwz3ZFfIi5jajQO9i5wZ8x?=
 =?iso-8859-1?Q?6A1YC7qOqHI3RL5/zYExUpoSHXV0Z87ZMU0YlaZ+Uqai0/QKssHv/C/i7K?=
 =?iso-8859-1?Q?6ibk5mUF1vW4IczsMnVj5hvnZEZC11sy4GCmSn45A+67bOeDfZTRUfOU/M?=
 =?iso-8859-1?Q?9fP6pB+50HNbGX/+A8h+IHthjtmTvMnWOiASVkVfqJCCj9KHlcuc1zXzMy?=
 =?iso-8859-1?Q?4Wtaj5R6iyRwY9Yz9xD9IZlemmR7NvhSHMITswl3aULEc4pt3iwlogfSlM?=
 =?iso-8859-1?Q?N29TVHPHLO1k+QBhc5rFecy9dUegY1Z9Fxz7A97OlkTlbsgzei7nGXiycB?=
 =?iso-8859-1?Q?1QqFV/vRQPM7jIPdaVeAx2+U05DHeFVZk5uzFgUeu3N/7rqWbSj1t/zRqA?=
 =?iso-8859-1?Q?eqNxpiaxTsnR5uwFulTFJcFKTpNXgcBOvJDVkaasH/+HeSGli1caXWtSz3?=
 =?iso-8859-1?Q?aYT8214rcymVhJzIYG2sPoDFMjJKHQMT7upQzCaFGAVzcvo+K0AoWKGdC4?=
 =?iso-8859-1?Q?qvucw0EqubTJFPMrmRg18HNPRR7guC7dG2TAOxLCSMadtWFEqw5/fDbuVx?=
 =?iso-8859-1?Q?/h0xA7kETE//bjpfmIhybhTeWs5nU0wWw3JRz9TWR9z9/ncrOsHtEnKrCn?=
 =?iso-8859-1?Q?23cPzJ+/sOil/OgWEd5eDLnk2iDJiSh2J4cqnb4o97jTLP2RfJ1oZkd3Xi?=
 =?iso-8859-1?Q?ulgmBss+GI0bkxDgFVmEZKLOupf/iKQewdI6j2a9/Lnbe8KQQTz5k9T/lr?=
 =?iso-8859-1?Q?vG0hpP2zsUDJy7mfs+yE9jP8SyW7sNtzEGhMd63m9Q+jCu7ifJxpkiEC7A?=
 =?iso-8859-1?Q?2PKDSLez1pa9piZivAiuf8fqPdDJhM+GXK9pImfCoVrGQM6YffJ90ITDID?=
 =?iso-8859-1?Q?AWRbTbOm1YDn/dwtj9A7UD2UMw9mLN3pxeUQL59JK0AIT1BpcmXyYkjKg0?=
 =?iso-8859-1?Q?yzn7Aw1rYGBkLC0Jnu6E+v9o7fYvQ0NuMncClsHFwYZVMTDogA9zYimiyt?=
 =?iso-8859-1?Q?W8UtIJs3wQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gJoY3g5SVn+MHArdz9cLvz1cfKXax9kmVx4c8nPrQPD4Z/D+OUbqe4BCgUaBoN7C+6oYlpO/grvQ92GPwCAeC4wzz1KjY4tyfEakQLVEm+BwYnsV7aTfwk2o0F+ppeW7IMFsUDcZk9idvDaZZXXmJtKbIHTRUXsNH6k2gQYFFsmUvZ2qZfBEA3mC4crfwRJdbfutCiRVf/3kBk3gdFZE9hsyzDhHNKKhUU1cp7gbkpQHuKW5Xoa15Bi2ab81jL24DKrc7FKHLgvBFhJQUgV8cuBnInifR5vjMK6biMh8b+KCuD5xzhLGNS83srOw2gjvixY+cVKRaYA6grB1fRPTqg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c8b5da-f33a-4a01-e52e-08dea0f7b7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:13.1975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kov3Z+n/7jP8pT+yU2IAKI2LhX0VULbwyIcEFNeNQpnuz0ud6bpU+YJWDfpcOBas5G0jBIWFkeIk+Haa6xO9+qc1LyQ3EZAJzJq4H+Mk0c=
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
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
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
index 8acaedeaa9..28a60e4c1a 100644=0A=
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
@@ -1677,24 +1675,22 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehc=
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
@@ -2161,7 +2157,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         /* make sure guest has acknowledged the doorbell interrupt */=0A=
         /* TO-DO: is this really needed? */=0A=
         if (ehci->usbsts & USBSTS_IAA) {=0A=
-            DPRINTF("IAA status bit still set.\n");=0A=
+            trace_usb_ehci_log("IAA status bit still set.");=0A=
             break;=0A=
         }=0A=
 =0A=
@@ -2226,9 +2222,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
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
@@ -2294,8 +2288,7 @@ static void ehci_work_bh(void *opaque)=0A=
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

