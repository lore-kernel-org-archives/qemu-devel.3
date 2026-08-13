Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F5C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuPn9-0000s4-VS; Thu, 13 Aug 2026 03:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuPn8-0000rU-SH
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:23:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuPn6-0005aj-7G
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGBaf+wOUU79TpU9sNQ8bfJH4RJ9KYdL9jg+6eeYpatfGCqt+bl9b6pq0EDk+o521EvVtV64KhpxeZ15HK5ZtCFBIepgeihYQiRhTUAg1+fg4AkdvrVde+0Cr5dkVU+UU6vtvLCtyv73jdBtEndeT/FtOh51e+ccx9QHJeEG2H6Wg5ufF3RN837/FbkbBUbVJPg0GvJTkbIi8F5nHP7jbI5ePHMI5pasKBeLQ3YzKzfX2bOW/nCcQ7yawIRv74xTTwxKHsElmH8eIfCsZo06TLketZnz7U1GzjAAGbCodGnpnia9a6j2GaXdfcZRBJLqVee/ekrEmMMGXjs/JVj9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2UcG8OA/WsCbju1OlfIos7usouwAAkZNGGyA6Coq8g=;
 b=zCismiRGec6/JfUSxmiOJJXOib1uAt8nvCvKNwn04RWMwQHBpocNh5PH4xI1RNccp5nXE5cyiLt7U1OIkQZz9GT2H2S26Zu3BLZaosT3kZJW19cJ458RVNa+SsQKRfeT4gfYMNs56Jamh2f16dorpPega26czP7Xbpq/9Z3uOziZvwPDBDfwyh0TjQw47A4AU84mfugMK3SaUIWjeae8uCorGZLjrU384r+XpO6A7kuQoiC12V5NCrmWQIJjdODInByfJIh5S+X3L5D/ThnBdqIteypw/NX27S4tZhAegI3bkXNSvQCaDCRzM6p4gmTFhoht7phn0ve9sNdPdmEe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2UcG8OA/WsCbju1OlfIos7usouwAAkZNGGyA6Coq8g=;
 b=XSn9oD/vzT7daGJsFdKIuT2O7ldEGcf2pUAKxXdDzwHCUYjWjPr3+IMSk9NWOMHuI68YlyaXZjbahynuasWvzwa9WNXmpdzAUsjZQEbSVPizc0FRVHQQjuVf60h4S0EsrF8tc9XUVOwQjuFkbPQ29j3/5FfUMZR9nDr6xmHkyv+2swruwS5Qfh8+RGDHOOs6hmBQvzeCkWJ+CPDIoSCrUnAbxkwNFPlKIdkmzM9GiSX3wyptfa5cG5SwMEVEXii3Q++JCra1ROzzEU2tz1YstlCpelNiOCg+Ie55li6cni/ihWpFHY27Pr+ARwc7/RWBeUFuGMBSO8I4AeZZZi9u7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYQPR06MB8129.apcprd06.prod.outlook.com (2603:1096:405:376::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 07:23:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 07:23:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@redhat.com" <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Thread-Topic: [PATCH v1] hw/usb/hcd-ehci: Handle get_dwords() failures in
 async writeback
Thread-Index: AQHdKvSrYy6CS2yN20qVd8jbUP7gcQ==
Date: Thu, 13 Aug 2026 07:23:42 +0000
Message-ID: <20260813072340.637657-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYQPR06MB8129:EE_
x-ms-office365-filtering-correlation-id: 1a5f260e-c3ee-4cf8-41e8-08def90bcdd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: dmBmzaiPwUL6HxiEJwtrfACRcuE8+BpOTcCuhDbLGfXzkxjhf6kX6194VKRonOULzUYQ6F77u9m71rU65mtBCs7400woa4GW9OUaPm9FrKQ0weM++RkGqEQ4wy3MqtyjWou+scFTfmxzIl+UF9p8dYKbzPhwOcPCaunaGO6XT9CASOaMHVQNjCqOJGoY79siLpIvh1q539ZuiXOT0V5/Z/og46fvL3rwhJyRy5sbM3c+Py33+4gKQyD25Q7fortKKFy5NaLVfHtbCXYwrCNsEA6VD4dVXxMLNImzFrLcHZxPxe9kFFZLlgmK09v3I4MUsZzmCUoD5ZZNpoDmzJyYQuR2ivd1I5vCBPaBLTeGCjik3Njy2L7PLWNvVEIwdtWqsXQv0OEdfyQVT8q+NUk/xlaSgxe2W1hq9UE3dmWrylgnSeBJfI2Fw8tjZt15heMo6nkWF3oC0jXUgXwrUHS+loYkCs6sC2OECAYvxlK0K6M/gbg2K0hMLKOvAL8hxBzhzCJh7NnZA4WDR4PLJ0C/NnsS0PygFEpnBwSj3Rub8wk8Ud07S3jS5Xs/f+8haP5TjyCWIJWhVNfF9YObNcf+F3+IqVa0VoV3lHLCglRyqyV3IG52p8eD/OTxAhsqbPUYPi7ZcyKRXwjQlJyZHMVOJbUd2l1rVTadB4v8Lm3iu0d1uuZz2P10JBDcjYI3Yx7ZVnZM54VBnL9lrU6IvCjh4toE46HxX9YESPVrEElDBm0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(56012099006)(10067099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e651N35GSorGov1TBrvcGTRhmQgMl2UVZRlXipJ+0vVLe81YxFXmsY6RzS?=
 =?iso-8859-1?Q?pBC5luj1L76LJyS4M7dwICzgz10BNSZ6Cv1NumFW2i3qNBuAy+Gp0v8b2h?=
 =?iso-8859-1?Q?JD//GjxrpvOjOLop/H/XdrabDrqd2FYF41deIxWdkaqncJEYZ25ddnRp1V?=
 =?iso-8859-1?Q?0TUa3nwmX2uTfKaqqE0pnK2/M8FVg7geatq04G5wnP9Tg/FZx76+PuoE1h?=
 =?iso-8859-1?Q?AqmGi6HFm/pIBdprYXV0gtUYCgtpWq0GmbuNTkb+XMLxhrcE/fWu2KLf4E?=
 =?iso-8859-1?Q?tjsmwGXfVpQy9obE7a+FKxJD7hYwrFDY+V5wWhPtqLpMv3H3PDQYqDQiJR?=
 =?iso-8859-1?Q?adZEE+5K+O5bueKBPTURhHIRn73bdXZrNgEni5ttesMqNigoUNebWiQsKf?=
 =?iso-8859-1?Q?v9i8p9HV4ze1bM8gAWrp/35NWbTebMDWNEIJL9zYba+qpG2bobgqld97ci?=
 =?iso-8859-1?Q?bhFBfT7uakm7FYWY9k0pJJxRE+RBBryaWAPjEvb0DPCVXMY0HTuzdlfZu0?=
 =?iso-8859-1?Q?sd09FPfFYuW5mp2cwWsdhpqBDt4tv+CFaGS/vo+8WSqOnf15fpjXaIkIjm?=
 =?iso-8859-1?Q?iwP5XMjuJsUs+qQOPXsApMBPpXlGnvIPXgS2A/FlsPdWFWzsMoEqfWvm6U?=
 =?iso-8859-1?Q?JwyaQkn9pt94ZJCinMJYHQlvjAin1wL+Y2jWeO/OyhhAVmFrXS7vaD8dHa?=
 =?iso-8859-1?Q?79qOAtokO5jyiO7Cct0ljVk2SLO06eXfGJOOcDZRcj3ozFzaMyHbfjUH4/?=
 =?iso-8859-1?Q?oIq1zam/8pZ4XJk+vZFxLSoQ9buZMfnrip8BRrf/JwQr2o9c9JNcXpDS6q?=
 =?iso-8859-1?Q?EhGM7NRoNfIGp7qymA/4CXht81Sqq3E6MtaLO1M8A85d+jNgE1IwMkqU3H?=
 =?iso-8859-1?Q?Ri5jAaS00PUW01ibrI/QCbz9Ayvo5NRZJiJ3c/6OlejfSovqwuEMJ2xQsz?=
 =?iso-8859-1?Q?s64+luGKlQKVzYSF2AT8cTkHLsJfPeKMId9nzMyZiJcqWF5DDHfnOBKxB6?=
 =?iso-8859-1?Q?EyS87VrcyHoQJXRbJ3CKisWS7zwwz9iVtnXObc45qoP4Z1YEtF9BNgL3k6?=
 =?iso-8859-1?Q?VxP50/IaowBBin+tEEt6j7UDpZ/V2u77Oj5W85r9WolHOO5k8yp1luoDnY?=
 =?iso-8859-1?Q?Qyx6Lox2JbtSsZUrCwAbvlhVzWNYyg53i54HgbtD7Ol/bv4XIk9b414gpt?=
 =?iso-8859-1?Q?/dkiqtIZmeWtWS+6hp0xq9pMthaJeCqfBj1qA+F8n6gBBzyR/yVB3dd2KG?=
 =?iso-8859-1?Q?eXxORO/ylNJfxEOUfbd3JmyJgZcIGfvKDm5edNyQKaZp8Ipuc0xYNoSrs+?=
 =?iso-8859-1?Q?db6AW5dqVj5mhQgg5/GX9t7E09E1D7XeJERpqrLBOKSaNS4RE8hYdW/ffq?=
 =?iso-8859-1?Q?onKUi14lCA6UU8r+RJkfZHCDNABB/Uu4T6uN8A2Ft62kQrj6yU5oBcPYMX?=
 =?iso-8859-1?Q?TL/Fjzl204Jvg98s4PbBFOSQmTxdPlig1PpXydATBmednPa3PUWf1eh9JV?=
 =?iso-8859-1?Q?pzFhK1kgZ5+T6GA408BNlF1zhbJg8eliuhuNiC5hlI5mju4wRCK6kKJJc+?=
 =?iso-8859-1?Q?kOKpIZ8PpSW2pMsuun8CBPIMKMwA9uOBuzM3ejlibMbEQ/F2WXxDlQuy0p?=
 =?iso-8859-1?Q?nO/kwCMi/LjoNYpkpYye57D/ZosVPxQBTtMfs4dGQXQPkJ+nDdyFYtirxH?=
 =?iso-8859-1?Q?XfBTvLcgZTPrTl5gi1XdtSIngxeE5cBDxEzBM398sPOBAdeiMYZNcxKUYd?=
 =?iso-8859-1?Q?ubPFMfyKzDNbrGTMLGfhh/LWgilEyO5u4GJztRF5NC+hBs5OX0psto9jJl?=
 =?iso-8859-1?Q?C9sqSBdwrQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5f260e-c3ee-4cf8-41e8-08def90bcdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 07:23:42.5844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgSVwwH8vPUobqRJvj46FOC0LOAaYFcPmh+jL2K+DrOFfHWfOJc/c2gVKRGTElRTBai7fceOPCyP0l2bc7M4ylHw6iG8Ej6xldAx9nAnSuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8129
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

Coverity reports that ehci_writeback_async_complete_packet() ignores=0A=
the return value of get_dwords() when reading the QH and qTD.=0A=
=0A=
Handle read failures in the same way as QH and qTD verification=0A=
failures by freeing the packet and returning early.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 451a918e9f..d43951975a 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -533,11 +533,11 @@ static void ehci_writeback_async_complete_packet(EHCI=
Packet *p)=0A=
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchq=
td */=0A=
     memset(&qh, 0, sizeof(qh));=0A=
     memset(&qtd, 0, sizeof(qtd));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
-               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
-               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));=0A=
-    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
+    if (get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
+                   (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) < 0 ||=0A=
+        get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
+                   (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) < 0 ||=0A=
+        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
         p->async =3D EHCI_ASYNC_INITIALIZED;=0A=
         ehci_free_packet(p);=0A=
         return;=0A=
-- =0A=
2.43.0=0A=

