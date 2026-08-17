Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E518C5DF6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvqHw-0004X5-Ou; Mon, 17 Aug 2026 01:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHu-0004Wp-5m
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:34 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHs-0004hN-HJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuTXy8hby4AYV4QiqnY52MK6OxphVTn3wVXueL1Sm69JxI6aUMD4n1aULKGEhDtVK43Dh7GKoWkXjcMoP2Iw5L9coXEl516O3aAUYravm67Wr9djrIp78y+QNEo6Gz2HjqY1FqOwXooXKdqDZCryjxXJg0cc2xsE7gGlnIuy7cpfoHRRnRP5t6tBIY77dzFEu4O7d5MPukXJCqLEbjht27HQhzYM+nZ1GxFVr3i4OiF6kBTfuBEN4ZkZUeXM1Ychx/x4vBtdc1zqzplEERLI8zHR3IHjnHi+sBbg49KZR4xS/FcFDmC6tv1XJH2OV12h57quMTlH8EmXP4quKHlnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqaOSv8APDmD76zyY37DuQv6k8/L00ykrKomk2zzV08=;
 b=xLuX99fhSQc4jl+tebP5fC5wrKPgeDE8VukzeWmImVZ8jBAjWp2xKkW6piceJ1yseyKa2iXSqrc3sGxe2Y5+t4Hpolg88w0PXup4WqDAX4O7D4x03SaHCxsHyViQ5hdx2N9lIDUw6ogPUxbp7drtgu4nzO3zPUfOTDSNmwTkmInyP49ajNuSDkW9RqrjKohWNoCcH+m7ZmNRug+QMZFaQrdfSxhuQBM9Qjh8+zwjZdoqhca7diwWoVAMRMN6neG4RIgPh8QVPnj3MxW7L7xCEKj1Gu3TW8zJFTuK/xz3YuGgsLLVXVzBgphNVTgcTaRhUHZN9jBvm0WXE3WbAmJQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqaOSv8APDmD76zyY37DuQv6k8/L00ykrKomk2zzV08=;
 b=OfJpldZGgC8wZZHqJ0euS6k4D+meZtMT6OqDJ/kqeIjCQeSplNBRV1DQr0+CsHCW4TSNBwqfm1K1ihWeHCWsm1ut4kCDaZQxGI3SseN3yPXhHIGNqpQJqrmhjpwiq5Uvf2VsMsqXCxt3+fYuptXx/7nnipAVPuwrmKbzp0SF6ng3DJi2pIbgB4MtnDqWFbV6DfWxpvr31vLeC3ToIr9LskVeMGISOkshDjrIpxRZhbBchhq2jWv36WIS7CoZKjpEfdNAjkF847p++Uqt2cJycW7n1Oqw1UoGbXDWXKLWTFSIrzEiZSOGOwy0PCiV+i7w/hN8yKDrfsJ5pmsTJtlv0g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8880.apcprd06.prod.outlook.com (2603:1096:405:3c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:53:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:53:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "clg@kaod.org" <clg@kaod.org>, "clg@redhat.com"
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 2/3] hw/usb/hcd-ehci: Make get_dwords() return bool
Thread-Topic: [PATCH v3 2/3] hw/usb/hcd-ehci: Make get_dwords() return bool
Thread-Index: AQHdLgy2mE9HtWpWl0CbusN9qOdK6A==
Date: Mon, 17 Aug 2026 05:53:22 +0000
Message-ID: <20260817055318.3826428-3-jamin_lin@aspeedtech.com>
References: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8880:EE_
x-ms-office365-filtering-correlation-id: e8b242f8-5dbc-4e4b-b2c3-08defc23d8bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: 6Y5p+LAA4V1NRp/gNZ4T8wdubR0Y4fDfAHN+4qfQ1+a+6qEAPtU7hBNFJKiDwXoqTdUUvPlFSOifS2QyApqyF6ApcZTENFirXEhUnkrBUc03FQdfHdBdKfzevFVJcJeyTmf07tkCJMHfkiJ4fVJeLMIZ2hFI76AyiQwR+Xe0On11x2gxtQ5j405WOP/zETBa6d09wAGEiobOkbTgIB63RIDhK8GL78nl/rCd7IjwbPBdb3bpM/sJuuM9i1hVWe7Li9gexc826r/hoQ3iSy8fm+4YPDXujd2I8CPJ8HDEGacy9YXCZtFYJveo9AzTfcF1E4J+Cf9WS3RanmfiOGZIQZ5tocERc9wNUIMANX/FNUXi3l5cSmAhH/OpjwdNvlxJ96iM0zholvF3IpxLDhxbozWiGxdKO+lV+n/RzKGSIK5b7mfI8IkjE7p6oETHm6eV5OyXTSLMcDQj4xDDLHJH59wemhm6Lle43drXCE+E+z+ydBrsvvKiIiy7GVqxcvhbHXmEuxs3XpiPCdw6P59y/4zxQv34IwHY6yb25JVZp2L0ODy+pzzB7ORd9RP0TLZqMv9WdTlFpyrGikw5ZrvN1QwcRjjlCa0mTa/ar/laj9t6ncRFdcoT8GMQLgbG7a0itfMbxtASe310PdJVemZ4+oq2inc4Fwod5xEZc1nGzb3QM+vwiccTYdKsBDHVsn6O6IL05568oA6zw5VZpMA+p+PbRCbyLyZGt8Kxd/cx6EY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VxX4BB7pgBVQB6Thg01+YiucgENm5DkK+dFsn/6lNQza+B2BOQxlXH+vUa?=
 =?iso-8859-1?Q?P8PZ2P2E7PTyboRBAanwoEDsy/n1BUTL35ENc62eqsQGQz48s/RTi1wKQU?=
 =?iso-8859-1?Q?G+WU70vxBodKdOryRfvCQdvj8eKkdYsgBNZUzTmzZ8th7B3zvpbxNbhx/u?=
 =?iso-8859-1?Q?Bp9yyOCc+fX1OIcw775uinfd+vjBblbPSzrSSSPk/Qt2dkGMbSgw3GFb7u?=
 =?iso-8859-1?Q?AvzZfQlcgABc0aJiKFRm+/327TlZhzWDwk+3MDuZAWUEmfl+7aGD0Xh3e/?=
 =?iso-8859-1?Q?J3HcdmQQ2lvWWQUhQIZpck/4qlEVt3X9lpInndF318pyOwEeQmZ2M1lhCW?=
 =?iso-8859-1?Q?lZZjVvMp2vuLJ69jhu70xKXYVnmrNQRHKLU/EvNs2Egt/s0wJSxrlQv45n?=
 =?iso-8859-1?Q?QKb+2jP0pXIHDF7MURXj9m2dUc2lGpyaygobJjoIY1PpdKP+B0VG8IZFu6?=
 =?iso-8859-1?Q?lWFz5TmGmtiaVxIhhB4pY8JMdV2olP8ZaTSBsxOXhheB0QVYsIe1Unqki/?=
 =?iso-8859-1?Q?WnG1NVRc5jiY5F58PU9HIbV42uxPn12izzskZN3eEmgoqYgUmjcO116yhJ?=
 =?iso-8859-1?Q?PEe9eC9jAx/hG/m0GbO1mRlUL1wzKwMFYzh6M6pRhhQdbpzO+57RACOnoE?=
 =?iso-8859-1?Q?KxVjJ0GbE/ZYXQNEcd3cPd3J8vBesRuYnRnVB15SuAYyj0qxJm6HLYIF2J?=
 =?iso-8859-1?Q?fZuQv/yemPVFEbssaw18tyya9H3idMpv0LZ/itk6KCo1Z/GcNNhIZ2TWzk?=
 =?iso-8859-1?Q?8xT5mi5mYoX8l3YHL5iI3DNSTR5MPKT5C8hcu/TwDk86u9nOIbS84YP1+L?=
 =?iso-8859-1?Q?3Y6xdA++xa4CBsQFz8INFv56mpxS+4nCwgMUxizk3AH9Vp1ewAQGoTF6Oh?=
 =?iso-8859-1?Q?XrdLpirn+fWMex0GH7c+NUSvo1OYyaSspuIDBNkNQT6k0ZhXVBI26CVjWL?=
 =?iso-8859-1?Q?VzzjTLXDNuH8t35TWMXL1IL0K/NQKb4nlm0fJAfLTw+ndexlQzRoXZ60Cv?=
 =?iso-8859-1?Q?10hXcwc5Wivilvt7OGgwEQXMz274lKmGAx6YSD6wEe2mEAS4G4VQ/czUi9?=
 =?iso-8859-1?Q?Acbe3lyn9NRiGwxiSZaSQ+vIb6oNYIgiHbqeiTHLGc/BsuFEJj+TBzzWx0?=
 =?iso-8859-1?Q?+sWGKNDoNdfjl919qn0PrwzstIeZGVgW2RJbWHuy1lUrf6Eamvr5gXWHDR?=
 =?iso-8859-1?Q?SMgm7fhbnH8zEwU9fBA6np3CnqnYiJpknKCcoCCBJUYD6prF20XmYB78hr?=
 =?iso-8859-1?Q?5N8pRirr/bOJFJGWWTDxbY6e5gwiVfYmvr83C3cIQBmYs0vVOtPtF1QMNe?=
 =?iso-8859-1?Q?MA4+zguvTCjFXXCV8nZr1J6sRRNnYnoaiZuZLqCiMYlG8hbQ5o4GzPemsa?=
 =?iso-8859-1?Q?YcgBrtcThwyh0owXpm0VOY2fkud054gtlcpHnGER3jy7eYi2VOsq5B5PAk?=
 =?iso-8859-1?Q?29wl6MlOmgGTo6uI2fimWyQNAPgQ+eEbsf/7mDOlf1s2bTTzPnF6NPzOe1?=
 =?iso-8859-1?Q?v3Wq3xWMcRx6ThkaaPkPlt9vj4wiaU5CIpmcPnQdKP5zNv5Jizq0cWN5Wx?=
 =?iso-8859-1?Q?OFJB2ZkJKs/NHkAM5ShfdNxaGr3wyaWZXw4kqbqkPMfU+QZuwx2FxwRQxd?=
 =?iso-8859-1?Q?KyEdVOFUhs05mvzx6/PPdaYdD6owIxNpMDO5s5RulCtESNjCpLx+evOEli?=
 =?iso-8859-1?Q?gs0lyma1QTL6+MtnEbtpQ7RlFGBjHy73K857pYdO9fORgw1WYExoTSAO7l?=
 =?iso-8859-1?Q?lAtVPWHUZgjyppCfmIT7XLgDUaXB1JmVXgfxKPjkTt+fwLkaJ42yucuVhm?=
 =?iso-8859-1?Q?+/iNrPfEUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b242f8-5dbc-4e4b-b2c3-08defc23d8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:53:22.3394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7TK4bF8OXSrzCciOVJc39Ajb1W7oqpXCXV3iv2qHR//T97+SJNJmuuZQ50kvYl7UgiH1t5rMrxJYve7MLLlJnHZewOpoYE1O8oMhZ1a7oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8880
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

get_dwords() returns the number of dwords it read, but every caller only=0A=
tests it for failure and none of them uses the count. Return a plain=0A=
bool instead, which matches how the function is actually used.=0A=
=0A=
Suggested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 44 ++++++++++++++++++++++----------------------=0A=
 1 file changed, 22 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index ecf98c4e19..5187ecc7e4 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -416,8 +416,8 @@ static inline bool ehci_periodic_enabled(EHCIState *s)=
=0A=
 }=0A=
 =0A=
 /* Get an array of dwords from main memory */=0A=
-static inline int get_dwords(EHCIState *ehci, uint64_t addr,=0A=
-                             uint32_t *buf, int num)=0A=
+static inline bool get_dwords(EHCIState *ehci, uint64_t addr,=0A=
+                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
 =0A=
@@ -427,12 +427,12 @@ static inline int get_dwords(EHCIState *ehci, uint64_=
t addr,=0A=
             ehci_raise_irq(ehci, USBSTS_HSE);=0A=
             ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
             trace_usb_ehci_dma_error();=0A=
-            return -1;=0A=
+            return false;=0A=
         }=0A=
         *buf =3D le32_to_cpu(*buf);=0A=
     }=0A=
 =0A=
-    return num;=0A=
+    return true;=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
@@ -1598,8 +1598,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     /*  Find the head of the list (4.9.1.1) */=0A=
     memset(&qh, 0, sizeof(qh));=0A=
     for (i =3D 0; i < MAX_QH; i++) {=0A=
-        if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
-                       ehci_qh_dwords(ehci)) < 0) {=0A=
+        if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
+                        ehci_qh_dwords(ehci))) {=0A=
             return 0;=0A=
         }=0A=
         ehci_trace_qh(NULL, NLPTR_GET(entry), &qh);=0A=
@@ -1701,8 +1701,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     memset(&qh, 0, sizeof(qh));=0A=
-    if (get_dwords(ehci, NLPTR_GET(q->qhaddr),=0A=
-                   (uint32_t *) &qh, ehci_qh_dwords(ehci)) < 0) {=0A=
+    if (!get_dwords(ehci, NLPTR_GET(q->qhaddr),=0A=
+                    (uint32_t *) &qh, ehci_qh_dwords(ehci))) {=0A=
         q =3D NULL;=0A=
         goto out;=0A=
     }=0A=
@@ -1779,8 +1779,8 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
     entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
     memset(&itd, 0, sizeof(itd));=0A=
-    if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
-                   ehci_itd_dwords(ehci)) < 0) {=0A=
+    if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
+                    ehci_itd_dwords(ehci))) {=0A=
         return -1;=0A=
     }=0A=
     ehci_trace_itd(ehci, entry, &itd);=0A=
@@ -1805,8 +1805,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
     assert(!async);=0A=
     entry =3D ehci_get_fetch_addr(ehci, async);=0A=
 =0A=
-    if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,=0A=
-                   sizeof(EHCIsitd) >> 2) < 0) {=0A=
+    if (!get_dwords(ehci, NLPTR_GET(entry), (uint32_t *)&sitd,=0A=
+                    sizeof(EHCIsitd) >> 2)) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_sitd(ehci, entry, &sitd);=0A=
@@ -1866,18 +1866,18 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     uint64_t addr;=0A=
 =0A=
     addr =3D NLPTR_GET(q->qtdaddr);=0A=
-    if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {=0A=
+    if (!get_dwords(q->ehci, addr +  8, &qtd.token,   1)) {=0A=
         return 0;=0A=
     }=0A=
     barrier();=0A=
     memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));=0A=
-    if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||=0A=
-        get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||=0A=
-        get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
-                   ARRAY_SIZE(qtd.bufptr)) < 0 ||=0A=
+    if (!get_dwords(q->ehci, addr +  0, &qtd.next,    1) ||=0A=
+        !get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) ||=0A=
+        !get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
+                    ARRAY_SIZE(qtd.bufptr)) ||=0A=
         (q->ehci->caps_64bit_addr &&=0A=
-         get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),=0A=
-                    qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)) < 0)) {=0A=
+         !get_dwords(q->ehci, addr + offsetof(EHCIqtd, bufptr_hi),=0A=
+                     qtd.bufptr_hi, ARRAY_SIZE(qtd.bufptr_hi)))) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);=0A=
@@ -1969,8 +1969,8 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
             }=0A=
         }=0A=
         memset(qtd.bufptr_hi, 0, sizeof(qtd.bufptr_hi));=0A=
-        if (get_dwords(q->ehci, NLPTR_GET(qtdaddr),=0A=
-                       (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0) {=
=0A=
+        if (!get_dwords(q->ehci, NLPTR_GET(qtdaddr),=0A=
+                        (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci))) {=0A=
             return -1;=0A=
         }=0A=
         ehci_trace_qtd(q, NLPTR_GET(qtdaddr), &qtd);=0A=
@@ -2290,7 +2290,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
         list64 =3D ehci_get_desc_addr(ehci, list);=0A=
-        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
+        if (!get_dwords(ehci, list64, &entry, 1)) {=0A=
             break;=0A=
         }=0A=
         entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
-- =0A=
2.53.0=0A=

