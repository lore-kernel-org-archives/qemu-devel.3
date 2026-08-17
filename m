Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE1C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvnE7-0002IT-9B; Sun, 16 Aug 2026 22:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnDz-0002Hd-Q6
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:37:20 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnDy-0007CH-6d
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTkWrjQpCRh8AE3cQzkGX7FCFJAiRNZcZTJmNqShLO9DyzZhykRGUU2B3rltutRKlP5tfAp9gmwfEKciwpKuEBPeLGnfZIGhdhWukqqMjRGZ4AGcTAZXNUb4EjOi0YuJ0YbAImbD2EKsh2XG6mdHLB0iNAEPGjo4Un5vmGR/LXwORwTPHOyUTs+YJe712ZZrbgRHh1cR1mN/zr220uZUNYVsCEPu+IRU8iZQLkdOq9Qmg2KD+kHlRSKgO0sCovTpYoLNDmbdaYn9qc0XbvWY6xev62UHdQVqEfW7x5LrROsq4TMyGilYJ+fExqwaI+jzVuv1cD/S5PKAbOz+WJ7wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq50S7TqGbJ34EErK+8FBrQB5VYVgqdtcWYLm2/3iVs=;
 b=sA/Gd96wuwQF6kKI9h+lVRxUj6OwDaNcQWAaIy8PTlEGEJj+gOsoYSeHIXv2eAj06kUQVdk6BjcMB4fEkbIhoEHTiwW1J4kbkZVa+z6dAn4ULQtwB3/Ihi0OBamGg9GlkkRge/BBl/KpDTVdkFqhoqrPHLEyP3XRduY9By1gbWU0Lu4V3JFR9qNArcq1NmNh3edhAubgb0g1eJhNTUan93eAetBftPKRJE1G8xCBgtJdJcLB7nL/qTGTI+1jU5rJx+mlsl9qvsjlQQ9O9TVjKN7m0dJLufunMHOYiStFgz6pZuHFtRzn8F+0phdgNbyQJaxSV1rX2w0thUoFqJPAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq50S7TqGbJ34EErK+8FBrQB5VYVgqdtcWYLm2/3iVs=;
 b=i/728x3gb0Y6GOlTPje8D4cbUvvAm3/z66uBDY3ysx6vbWlkzSidKYEnSoJlMci+vGAMwH682lQlLlOvk98wEnK+woLlErJSuH3X+oYuqRI7jIoJzzX81POXgYPuQ2XTBD0lA32hbIugB5qTpXy8eBdfOInmjPhsTWgc0whWzTH2DbEOiIDYn0kO46zsL1h0/xMynFqIxMfjXx8uCxeDYtczKjsI7Q8Wss/xhMK1t4ygeFsS4KH3WqxRVdijom42ynzNg4MmWxQw9XxJN84R33OxCZ7q9/A5G/fKzxsCIMQiVYUmpWfPK7pS6JP6VcBSybPyNb99j8uFybeZIj6nyw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6591.apcprd06.prod.outlook.com (2603:1096:820:f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:36:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:36:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@redhat.com" <clg@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "philmd@mailo.com" <philmd@mailo.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/2] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Topic: [PATCH v2 2/2] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Index: AQHdLfE7QS49U63b40eQy3mrFdSRpQ==
Date: Mon, 17 Aug 2026 02:36:40 +0000
Message-ID: <20260817023637.3082135-3-jamin_lin@aspeedtech.com>
References: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6591:EE_
x-ms-office365-filtering-correlation-id: 2c320382-d0e7-4d30-f170-08defc085e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|18002099003|22082099003|56012099006|10067099003;
x-microsoft-antispam-message-info: FnA+3Z1sAwMmdqI+ThluNp4KtGBVeAK8j8syJWay5OQbfZSFTso3KMVkOg8sK6qe7ukM6LgRBTdbKzt+NepGTtRIJ73oZ4W6GjRmCyPKJ8U818rN1PU7K3G/Gd8yr9x92t9yBjGEgwLzDEFFLEf1KCErD2/Bt1ODFCd7etKQTpEE3h5vVc49u9otm01X6uUyKWuCnsxZrxWbF1QkJ95DRuOEIgo/Wje3LGg23/XU5VeEYlZHBGI45HCJoYGgN5O8Nnlb8Yp8HqAfk0RgkrtUCNCOtT3o3BxxmqDMkenROId84HFbJAoDhQ2wdB6k8VGqPj7bK+qG7o4t2OtRNrNDE5DLvHrtdaGTT4IJNFxAzcKBhD+fD5Hj/vbBPTDdZ4OXlGbwsh8w235E052oIb2m7y70SVfbRCX0iHJD+Hqiv9HBRXutinXAxa39xlgIdmS2DinkoFmrjurGJ3Twu9w5QlEyxa4XhOycbUxu6OQxTxLN/QXb82tB7JXZ+wwnHWr+u1iZfUFjFPT90Bk4+EH1q+9W610ySMStzf3pBBeLJABKTHVwNBx6D9wUL4FbtAHMfJdJnRI6hkSY42F9eIspyZfKaW/DxYbUr4vZR4+gQ1JV8h1m8oJWDuFOXv3TCUuTnxdpI/+/dj/Z9LyzhwgWvtfvJmSOf3yAy5WW4rSsUMeg8qE/6NxaDsmJqaKBu4Tp+m6aO+kCPsv5YJdRkkss5eIhpXME89uGmP/rs8K6LoQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7OAUszpRNshbNIVQIprL3jAqnYaxk5glGTpdjekiBaa0WIQB2X3oEsVYpik?=
 =?us-ascii?Q?6jR9A9saaV0891l35tO9Ol6IJ7+KP9u9+vv9uTvoDbap1pj/RAvABZa5oYPz?=
 =?us-ascii?Q?MoGBpNWpVcr35Dm7JAtBQLTHvsmpfFhhJ6pZSSw5MGcxrM+cfONB52m9BYR9?=
 =?us-ascii?Q?jbqygdvjyOL8TLYfgd5GJKqWz5+8mvwPzH+H18Iehik1iFd1fbmQ/8Qq8nge?=
 =?us-ascii?Q?eWLVsYYheMoNo6izbGuIuJn5zbNOR0DtEGSOkEBNNTh4cfMbd2v1Mczb+16D?=
 =?us-ascii?Q?P5KGwlRH3MIvSrafLnvfHl7fllT60R941WPyogs6YD1ZCfTLKg7y3zWjy3vd?=
 =?us-ascii?Q?9W6bPI/lWiqWpQrVXc0gQ48m0e4YV7HeNXNwYEjquQim/MyxB7wrxI++8Z2I?=
 =?us-ascii?Q?nAgnSuB5HVO/noqOF+hNhgYNfzuaNFlubEd3eeHPv4B0I1SIqutyK7FlkFIQ?=
 =?us-ascii?Q?Ppm4DD6der+qDAGfGLM3oRtm44FrCfzFsXquBgoHOti3jUJALaq6IigBpk3N?=
 =?us-ascii?Q?O5s/0r7rAevSOgsjRO1aDSgZ+rDroVFHqPnaZBe9e0AyzKgcBFibnd3hn+8l?=
 =?us-ascii?Q?qIvjjxZSBHV3I1XnHdAum1vo57Wg/Kopk/h/Nnj+LKprNzchk6209xhk0C5F?=
 =?us-ascii?Q?y/F4AfbLmbXFAbDXpeI2T4IU25jWyVGor33yc0JW9bfg7ZoOJFDfAkI75H1D?=
 =?us-ascii?Q?Lux/uWfWB90lH34FclipO20c7s5BYrQCQfXODSEUrvgPyzD21KoqYlBdFk9N?=
 =?us-ascii?Q?+rtP3WPM3PIyvABL6ligXCJ/k8xWlWUoEHQ0C4M2IZUx4CMJahlD2hrWu4oY?=
 =?us-ascii?Q?ocyEtReRCKlmxquw15xtdKTiPT9zIuNzjHkQrEzaDwN5PY0QV/u7uSFb6/Vd?=
 =?us-ascii?Q?I5KNZz9L7JE+wmkqIRnEy/JvLosaJK+kKy8my4LYaGTdwbqMHPGyq39mjpPd?=
 =?us-ascii?Q?qBvdHph8eEvvXKSeWArLU+vz5x/sjTuFiJdP2EH2571p00crROQxxgB/TdKL?=
 =?us-ascii?Q?rmK05m5+H+F21Tfyetbk2uJr95gzigBE+MCdt7pHVsdDaQb7aT+zzthREnel?=
 =?us-ascii?Q?G4uAoV1WXC31DaaZdlMBZtS/cH3NZFslzUIiLhhDbyZDnRXA9UU507ocrchE?=
 =?us-ascii?Q?1PoqSZvlL+Bk9UziacOiv2VIzTqV+gdBrjiEgeUqVfgMRrPgzCiTDAWDIeoZ?=
 =?us-ascii?Q?/9wDehCpa4tDzkro789oWazxqHyGau/3oa5KzZxSuwe/DwX/TguitVGNHlsR?=
 =?us-ascii?Q?9qym/SSUOk9o6jhPzTRoUtw8aNEFygC3QSSoTLgF4uRRvu4DVJ6X7/Z0BtXv?=
 =?us-ascii?Q?quua15qoszwndNxu6QLbxxEMD4sFClZQGMOvxawBusTGenBMYJgc8pJPko2C?=
 =?us-ascii?Q?Sx2o9eSPwRQEGu5D3JWMWBgCj5cMZ5EjdID1/YVuwg8FyfNf8gPB76CvJG1p?=
 =?us-ascii?Q?3SOpA78O60KyBR0LanJcGhKhHyV7uqlKAz/zhS69pObpOpwSyEEaJamAknGN?=
 =?us-ascii?Q?62rzfnQNUrvI9Trw2RLgfRkTkUt81917YydznK0G7QPheIBDQxN/A/LZPM3y?=
 =?us-ascii?Q?nB0mKc8doQ+lPs+lbgQrJ1bsnWd1h2kYKcIaRs8lQnyrJrk57NpSTK7rFPzK?=
 =?us-ascii?Q?ZgAiTu9W1TZcJgbFq/gxIvaBjg8fx1JwLytyCcUfbq2/ZuFm1SILzTsVyeg+?=
 =?us-ascii?Q?yb/bHC5IReOd+jR76pHqtsDoqpK5pGrmAinytZIlJx7V7nVtHeur8kPZcM3q?=
 =?us-ascii?Q?JDieORYXRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c320382-d0e7-4d30-f170-08defc085e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 02:36:40.2758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlKK0tPn2/spFe6m7VhwRqf4kdjXZOwrZtc094Js9Gh/vQOtxkfWvYdHKmPkiU1ScjBZl3Se+/wkZXrMOlDCrBX3jOpGBIo/6t/HiJZZumw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6591
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

get_dwords() and put_dwords() return -1 when ehci->as is NULL, but that=0A=
can no longer happen. The sysbus variants set it in instance_init=0A=
(ehci_sysbus_init()), the PCI variant sets it in realize=0A=
(usb_ehci_pci_realize()), and usb_ehci_pci_write_config() only switches=0A=
between the bus master address space and address_space_memory.=0A=
=0A=
Meanwhile the results of dma_memory_read() and dma_memory_write() are=0A=
ignored, so a failed guest memory access is silently treated as success.=0A=
=0A=
Drop the dead NULL test and check the MemTxResult of each access=0A=
instead, so that the existing -1 error path reports real DMA errors:=0A=
raise USBSTS_HSE, clear USBCMD_RUNSTOP and stop processing the=0A=
descriptor, as the NULL path used to do. All 11 get_dwords() callers=0A=
already check the return value.=0A=
=0A=
put_dwords() now returns void: none of its four callers (ehci_flush_qh(),=
=0A=
ehci_state_fetchitd() and twice in ehci_state_writeback()) looks at the=0A=
status.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 38 ++++++++++++++++----------------------=0A=
 1 file changed, 16 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index d43951975a..daab5783bc 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -421,16 +421,14 @@ static inline int get_dwords(EHCIState *ehci, uint64_=
t addr,=0A=
 {=0A=
     int i;=0A=
 =0A=
-    if (!ehci->as) {=0A=
-        ehci_raise_irq(ehci, USBSTS_HSE);=0A=
-        ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
-        trace_usb_ehci_dma_error();=0A=
-        return -1;=0A=
-    }=0A=
-=0A=
     for (i =3D 0; i < num; i++, buf++, addr +=3D sizeof(*buf)) {=0A=
-        dma_memory_read(ehci->as, addr, buf, sizeof(*buf),=0A=
-                        MEMTXATTRS_UNSPECIFIED);=0A=
+        if (dma_memory_read(ehci->as, addr, buf, sizeof(*buf),=0A=
+                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {=0A=
+            ehci_raise_irq(ehci, USBSTS_HSE);=0A=
+            ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
+            trace_usb_ehci_dma_error();=0A=
+            return -1;=0A=
+        }=0A=
         *buf =3D le32_to_cpu(*buf);=0A=
     }=0A=
 =0A=
@@ -438,25 +436,21 @@ static inline int get_dwords(EHCIState *ehci, uint64_=
t addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
-                             uint32_t *buf, int num)=0A=
+static inline void put_dwords(EHCIState *ehci, uint64_t addr,=0A=
+                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
 =0A=
-    if (!ehci->as) {=0A=
-        ehci_raise_irq(ehci, USBSTS_HSE);=0A=
-        ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
-        trace_usb_ehci_dma_error();=0A=
-        return -1;=0A=
-    }=0A=
-=0A=
     for (i =3D 0; i < num; i++, buf++, addr +=3D sizeof(*buf)) {=0A=
         uint32_t tmp =3D cpu_to_le32(*buf);=0A=
-        dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp),=0A=
-                         MEMTXATTRS_UNSPECIFIED);=0A=
+        if (dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp),=0A=
+                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {=0A=
+            ehci_raise_irq(ehci, USBSTS_HSE);=0A=
+            ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
+            trace_usb_ehci_dma_error();=0A=
+            return;=0A=
+        }=0A=
     }=0A=
-=0A=
-    return num;=0A=
 }=0A=
 =0A=
 static int ehci_get_pid(EHCIqtd *qtd)=0A=
-- =0A=
2.53.0=0A=

