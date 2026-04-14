Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641A7ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhY-0003ZC-GV; Tue, 14 Apr 2026 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhW-0003Xh-2d; Tue, 14 Apr 2026 04:00:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhP-0005tv-O3; Tue, 14 Apr 2026 04:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw0gcrKW5gokvjyAwBSvmI/5nyP/9xqovaihLHmFVT+UsAAmOrF89QtZG4DwInupnAT2F0g9Rjq/rI6WU6BXb6PxFqeNGtxk1gqZr3tJKwL/p+ZrHrnduBFsNKvBuw5Y4rUQvWzvvf+VendbqJ2JgOzKs5D4rwLe7F1E2xYSv1kK7WV/HniVFg5+d/qwRggmGKT+h3X7y19IOah14TKjWGZbFAKiVnQ0VQw9oakNMaSesSWE0PtuEEF4A7UtkElL0p4yJIzy1fc94BqSLZVlkN6Rp0NL4bu0EyiEiYl/bNfreSjBExhgPHiCQkRzwgnblnKXu0wxyceIwWMlnBRJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvnFkrtpXH4axWxrpZt231+nV+QZRS1GNqSEMuOKNjM=;
 b=Rrm+EYT5RYfgCSRFm+VAt3mmUajjszS4rH5aHjujlhdPTBUEkBc5x2VAKflL2w6D+i6ke8OEIThm4IiFpxZI37gXqyzwCIGFD6Kk/UKKmGEe069acusRPlJDpY6JmYdxuzSjXEw29NbPuP/IxSXbROwNAoz6nya4wTb6A3jnCnOBWLU6Ymc76/55PaLByWf5g1us2XMJ+pUEXlRuHXIu3Ul91QWUVWH7Zf21O1ispOzVNpy7HkhD4PGJfYgwNbNhddqCVMSlqtd0jnKPYTanbBgUMUn7UNZYH38lAqlCaP4sLW697QNMwjBOk0VH4UVBRx+UgVL9pbnipwDJKetVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvnFkrtpXH4axWxrpZt231+nV+QZRS1GNqSEMuOKNjM=;
 b=BVLO10ELOHRyu64DZtR2QYB50dB86jNKUOzwysmhNFk23wac9gy1eoXOxrV+s82jXq1ADx3MEDUAUcVqFZ7zy7X7BUnpkponlDO4lgL5kswyNbNGHitXVCm9zxNT0iZqXpr4w9k5sPNmi0whxaJ+OUj4/o6jGJ52Yi2BYT8k10aw5j7WYJ6n9xRso7xzNJLTPzbKMP/IFrgP0l2KVsFYhxWKVmVS3XCwIjQgdT83JpR002jThJVquyCvrgN8Mx2nxUlCL9eRFdyrfXxO2cP/bCMHA4fq88hZ9HEQxJkIUyZTfhZmMbfhLa/gwORQWoOvKEGRdoVXO1kFpi+/Vwehcw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:37 +0000
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
Subject: [PATCH v2 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v2 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHcy+TH2pgmCK05ZUmQPzt4XoYVlA==
Date: Tue, 14 Apr 2026 08:00:36 +0000
Message-ID: <20260414080025.3005916-10-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: c3eb7b70-382e-42d4-4f48-08de99fbea02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: po4pDmxr6SpeSe9Qe3MdGrmFMxQgya9gNVq/wwRgTzvyQ9CoydNDx6wsmB6EBqg8CDD1f6WknJg4y6yxW4vd03zhVyOylY/cPvsYRiXcyLoP/RfJjqsTIhkoNihEeudtES8m+ssSLDYGKnKgaMPmavbU+tAHvwKgwV9bDLT/nRKk9c59mTMJbPNco+Rmwdq0VLKkNQPqofF6RXjQabZXGRjcRKIVFVCgYraPuSMGj9LoiQRuYa1qeB4ghQZnMNDdq/Sa/3XoSu0xShqcf5jQkI917P84cN4ZkTd5dV5jAuAiDOd22hydw2xIAOeU1MMjvnb2SHxthBXDilz/WvgjqPFJvjuNubqkAbqbySvULov/9j3If7FF4swvR0ZQ/twef48LAj/ITRy8dX+51EwYBMvXYHWs/fzAceOpvyudm4LcGjeG4SnKn94lS9tB3gDVoyuIbdmZlnSog1Ffd/+4M4/Kb6IdLyPydPRpMr1XeuF12aE6QxM7FvE/7kgflTbu6pI4KG5KR45Z3BrnRHLM/4eLib16Glq3BeJ/hFkBt0jn2MWdhM4LwNq92M+3a1undfU+47q+wDXG+ZCRki7XPtV7FqfFTRbjEdWyKNZ574AA4/14ETelg0BWCDF5spTpPu+QxbTBWfovNlbB2SfWNcdaznNZhU8A3L9FopkTNXq0RBUQFfVUuRrymm2EtdA1j6co8dy8eFEDR2auEx7TQDuToaiLFIXqLZ6rYV62QT7M1+IupuXMqom1A6K6iNGxIvDDhRuuQtSAJ2TmTwFoZOYLgFqnRUnXWg/XJ38nkxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xZ5yYmn/sO5yKn5mBX+QIFbyUBwmg+1sschNPSXO7bo2mpAfyy7B2Jsuxt?=
 =?iso-8859-1?Q?l8/DXjw+9B1AkpDm/z50adLoM2oqq+aL5qr28Hjd+f1e/XNjtCVzjivZtQ?=
 =?iso-8859-1?Q?nW0aAK2HrivGY9lXv54X2u4WipvHdZ9Ot4yQu2HbA7BiGerygaFkpdV1HZ?=
 =?iso-8859-1?Q?FTW0mv/9RGAJPt4B7zB3a08rAscfDZJCn6U1KhcqetpTS6ItMoF1P81k0f?=
 =?iso-8859-1?Q?hysdmjQcyOxuHKKANhJWFfqkPFd/rtttRZEhfBFJX/FaX+VrM4qwnJlvkH?=
 =?iso-8859-1?Q?v6n8kwTpTXIYUTPrsuHeAXWd+T69GIJXBqqKveFo/yAZp+kgYvft9B1+W3?=
 =?iso-8859-1?Q?RvfiuX/aOV3bsjjAXAc5GffrHJ5MFc6pton+SEGjn03LfAWdE+PYAWLk+T?=
 =?iso-8859-1?Q?/IQr/wdbktLaMLsP6MTIU695B6MOQ0MEMW+bakYj2xyt4bc/oljMpm1bBA?=
 =?iso-8859-1?Q?V3TZH63XidAXkX0AJiqpEOfaE5+Z5cBz+R43lcS8Zh2lBYtS9jbCOkjS0J?=
 =?iso-8859-1?Q?y9ybWyZs5wvgnZ0Z16ILgkozQQebgXadsYrBj7dWCRB7PIvpQFM81jaci9?=
 =?iso-8859-1?Q?BvxXL3xDkotoUUHFYAvAyLuoTrqRnMCHh5CSQriC13Fpl5K1Uyk6G8HE0l?=
 =?iso-8859-1?Q?Iy+/d474PFQv6qcRCGspFOmfB+l7H4vHK1D7QKU36KaEQr7K5k6EMK7Ky/?=
 =?iso-8859-1?Q?thjRoQn/tju13Y6L7ijzIY8FVFlc/KXnt5X61GAgHbgFeegdrZI7NMpr5O?=
 =?iso-8859-1?Q?5a6TbxGswr2cbxCP0ckWJ6Lru8aGT77B4tsPtWVhuwv7DWjEO2G/IA3Z6Q?=
 =?iso-8859-1?Q?RHsMVMMMj347CeDtIGigVrCkBw7HZW5pQPTkcL1aOchnkIh62UABBCOLla?=
 =?iso-8859-1?Q?sBZW8kvRbmaTAIvWeIaLQTtXGbkBl12UjQZAKxzt+OefHxf2FeiUcBYMwV?=
 =?iso-8859-1?Q?ed+nJjfHWkiZcFCoHXxlgvVwxFQsw/WvZvOMUePs9iV7Sk3k9CR++LsN0/?=
 =?iso-8859-1?Q?Vd3wbu7zC7h0e+srpP2YzH5sEpV5KCMmGz9vA82p3jXq58RwYaWzkQ0MFD?=
 =?iso-8859-1?Q?G3J6rr3f16Ykw3MJOWsuA9JEMeEt3liit1/n1sjGFrIukxUglnBI1cVhLl?=
 =?iso-8859-1?Q?SwPIkQbnrAL1Fp0DiQ6yOTTU9J33fLq/pf6op7b6zUv/B77tH2ZhNOy95G?=
 =?iso-8859-1?Q?AK3wilNjClUvtoN3S+M4Asvezt7Q4xk0HHPSI1M+FJQDLvVdZQSgZwEKA2?=
 =?iso-8859-1?Q?PC2s7IhmtS2lJ2R8tCPRDZd3EX6/5JMvc1ZL/dXns6P5fBBkYurLabLYm5?=
 =?iso-8859-1?Q?f12sEBWOUoxQxvUQObB+wwmMU1EehR1ttKUPeKmCsWLp1HkTirO13TP/3T?=
 =?iso-8859-1?Q?yFAUQzh6kbotgZwAY2EyNJ1G84pAebaeTlbSjIaJhtLW1Ww+Iyy46HxJvV?=
 =?iso-8859-1?Q?yA+11y4evU1oT3AYQ9rtBFPxb1BQk8qaxq2vYwY9ktUSu9vFQrKHOO/3mD?=
 =?iso-8859-1?Q?X8oj1UkQ3U/IyBrfckLHXTFuRQ3FIPlROdHJ3To13npznFvvvh6Q7JgWFL?=
 =?iso-8859-1?Q?Bv1L51HWt9MMz4xdoDUZiQ8iJEYuF9OLjTVQ89YgUvSm0+bjs8i1RpYFbN?=
 =?iso-8859-1?Q?mmc2LD++ZPl4UVgLyiTHT37Yrn5xDItHrposhc77Ha/fKPmdDhhYMye4cI?=
 =?iso-8859-1?Q?K54lc7/4zM9j8cVTic3XA2GSFJLCCR6CDR4msFyCodHZXzoRZp9XxiADA6?=
 =?iso-8859-1?Q?G2RFTJ5+/DP58c/d9yuGPrqDhd6c9YBD2/JENSYzGfrdaK5HTlWAUBrWiY?=
 =?iso-8859-1?Q?8yJBgNrX0g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MkqQDiB9XjrTDDVtuX/cdleu2XlDnzErKgUcppinqXzCxrXLyQ09B5sERNhrzqMxF371tNb9fCb3iDk3SxhSHQkBlItPjS/EaAL0P4iD5blBLm5Ymrh9Bd/XCJRmkjUgELVgD7Zs0vezHXMpDfgZcoaOmdUmvCizEFC8sIHIZXkxdyGp5G83IvZnCyTc2iY7RuAlMQAx6BepFJlLTJIFp4123MIK+GvQp3BL+6Y4W7igpIuQGjo9WzmGwh9tzaYCXjijEK6tolY7UKhPGAwsY2eaLnLOcMXozX27s3wH3aYCeqjfUupCVq6a/k6oghKDXy007KZ30YocTbVfgZ6uNA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eb7b70-382e-42d4-4f48-08de99fbea02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:36.9808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kulnf8EQqPTMwZxi2AzUR1QTekdC4e2squmtokYV446YQC/KDdTTnEnr737mOUs9koolettQn2h5OWNU8pyiVEYJX75d+8XJztphiPVzV/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 ++++=0A=
 hw/usb/hcd-ehci.c   | 48 ++++++++++++++++++++++++++++++++++-----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index fe4c508c32..773f376834 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
+#define EHCI_QH_OVERLAY_COUNT 12=0A=
+=0A=
 /*=0A=
  * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
@@ -194,6 +197,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 enum async_state {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 54a1a6f7f3..d1d68b0342 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -147,6 +147,24 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,=
=0A=
+                                  uint32_t mask)=0A=
+{=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D (uint64_t)(low & mask);=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr |=3D (uint64_t)hi << 32;=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +458,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1536,7 +1554,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1564,8 +1584,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1691,7 +1711,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1868,10 +1888,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2200,6 +2222,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2224,12 +2248,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,=0A=
+                                              list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 8c90688bb3..67249d69c2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""=0A=
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t en=
try) "frame=3D%d, list=3D0x%" PRIx64 ", entry=3D0x%" PRIx64=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
-- =0A=
2.43.0=0A=

