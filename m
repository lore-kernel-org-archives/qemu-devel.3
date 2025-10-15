Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6228CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91IG-0000TD-Fn; Wed, 15 Oct 2025 09:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v91IA-0000HG-IP
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:11:46 -0400
Received: from mail-francesouthazolkn190110001.outbound.protection.outlook.com
 ([2a01:111:f403:d207::1] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v91Hz-0001Z7-Gq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkfLj6djqUpSd5giT8ht5zt1lNwAZhgzY1VWDRb3paJiRpSkuHXpKKdUvM/ZesOcZhCggsBWL22ChRxDBLYKEFCacvNTz76GAMO/G8qT1YuFO7s3tbQ7M+YzLMeI6W3Qvg4dUCUjBoqKjN//+d5Y9SgaCyykmzGHexCw2R/lZkpbP0AGO26TJJoGcdYfYfNSBQwJoLC2UntUu6dZnq9wBvjzNL0X9IQENSlMnmk4K5Gd4g+rxqDLGilB8a4qR78fELz4qq+BbBMC2jt0GZy/dkRDxoaEMSfAQb6kjCI+C8T9O6jIi7q4sNmmk5xLz4bA/mQRkVkgpeUhrCblQP+NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/IZSWJf0h0BEvGWuQLV67QSX6vYyybsakCvQC0nofw=;
 b=eQ/vjhQvi4HAHaNv7XsMGbwoA6Xq7HijA5uEXrom23/0kfcUlRNtHMrapZH2idT9Ub61nAHnIwxk5kX7Ew5vJc+opWGTPx8q0L+dBQx+kfbRnIFe1T1I5QgEHWDL0IGrbmXZnnkub4Hd+qyVFeaMSm/VlPmMgo/JPU6Kb1kJVHg3PyJCZ8XN5CZyPTqBjN+CS+2XxnwEp12NzG87OgUCeuLkc+Oo5l+tjrzWy3y33n+JwZ3xnxsML7hJ3rY7gXx+Conu7uLd5wkxk3ncisTVYBu02s4t4YC2l3KS79O5JoVA8rJk1tJC/kvslMNKp8Hk/Oy2LfKTuJHkZLwwrts3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/IZSWJf0h0BEvGWuQLV67QSX6vYyybsakCvQC0nofw=;
 b=bu51jo6EwB3EP9RwKO6e0EPuZRnJE8G0FPOpZeA8BTf8A8Vyetm53a2Ybw+f/x9VtVYkXNXStmNGUYcf7pQFNiOgyXauhlP0xvlOPAaIBOGCOV5j+KB8DmRyuO4y2vJDDpzEnCJTYFh5OCYpKYT+H7XxvxpDDjigucjTFBr7cehVlf4K6oI6JenS2s43/LpNtbQTftK46siglMogLkQqUilLC8e8q5zLZ03KJGVXG+BrPBCkljkg2zrj0AuG8q0LmbIGyiWiBfaGbMEMoN8Muysr+faEh+/NAXMtIjvBr0xBxPQflvk+I/WKU/rJPE/+CLtAfREE6rTTtuseGvLrAQ==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by PAXP195MB1215.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 13:11:11 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9182.017; Wed, 15 Oct 2025
 13:11:11 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] file-posix: Fix seeking compressed files on macOS
Thread-Topic: [PATCH v2] file-posix: Fix seeking compressed files on macOS
Thread-Index: AQHcPdUtdJopakJppk27+DkXsXZ8Kg==
Date: Wed, 15 Oct 2025 13:11:11 +0000
Message-ID: <6B1AA32F-A327-4F91-9560-6845D9F94120@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|PAXP195MB1215:EE_
x-ms-office365-filtering-correlation-id: ca2a3cc7-07bf-44ab-27b3-08de0bec5023
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|41001999006|12121999013|15080799012|461199028|31061999003|8062599012|8060799015|51005399003|39105399003|40105399003|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?xj6Kz1nEn10jePzQcbX1v583qmXpb1l6WV2L2v/Kcq0YapFS1qrf9hLRHkpQ?=
 =?us-ascii?Q?+kIWZQ7aL5nqWeRHhXuNZoagyvMgOmxIpn3dgw5/rdW023RHO8IPT4EdD84+?=
 =?us-ascii?Q?eUhp8xczumDDKP7YiJSRabvaONfzDeGVcHakOrWOtNh2pQ8+/r+0WqU58nIp?=
 =?us-ascii?Q?LGTCN5Vqawd5QuP7THQ0+o8G62q0Ta5RgzVKwZHx9x3En0WvAxFYYUA+cgJ/?=
 =?us-ascii?Q?KV5ZujSx27QOFclxAE95dFprkqPhkuhYptyfuo1+dqe8zPLAQa/p8TqVOcJB?=
 =?us-ascii?Q?geGD6oiXH+yYXOPFbUvcoGnwxJ/NGop+1yCjzZUPJhVrzJc4m/q9fjJnXAJI?=
 =?us-ascii?Q?84nlvhvu5MXD09ELs+1HW4n33G3owSj/D83iP31o/aZuXrV8ZVyFA8skmShf?=
 =?us-ascii?Q?bToBhXZuqm2sjbJH/Z8aklS9Nm+fJtZYgdX6a81jJwlHcqwl3BGKX0zhe5XU?=
 =?us-ascii?Q?IGbkk12zSVtkfGh5UQD4072eGbnMZ3IPBqaC19pPBJDncl47KXEtXX3/k8f7?=
 =?us-ascii?Q?9ZgKpbRXIIWQ/WLcfsFy6KoEgW00oRiBe6opVfORon9q+EMVXekcqs/X9AHj?=
 =?us-ascii?Q?WeO1wPZu694ihBRYmNE/ZUIdnKCiFgwu4S7UOBHSxakeMRhitV04vdeJEbWf?=
 =?us-ascii?Q?wm57A6ymMXxP+VqI26kofY3CHVq6eRWtj5ANnGJJO4qcmSqNGK/cKBj2sSAq?=
 =?us-ascii?Q?hhNrErn7xbcmUSIKk5QNzUvS/01s/bQaf/p7KAqrPSbD7XPqlKtXU3Kuhz90?=
 =?us-ascii?Q?JQBDNs0Lzi/xdsqEytgaT1N2PjopunK3bT/1hbXh+5DWccl2kbPRD6rMpK62?=
 =?us-ascii?Q?wm3Y8kspHVyjRJ+OULCshl5GVmrJzgSnfZ1aPo8ecZyy3u/7FaDdQDSm60np?=
 =?us-ascii?Q?wASDrbkB4tpA9G/y06GoodO+pl0oS4YJn0GfTRXazAQnYT11ziUx25sG2I56?=
 =?us-ascii?Q?TUBGMP/1UZOd5wMzjwUHdpWLF6PY1VusTFn5lBH5wyPcgaOSu8PdNhd4H5iq?=
 =?us-ascii?Q?jNNUkmUso/D3Mqwy1CSq4AIquN4gOfqQAd2Vspa5Ssr/yYiKgi80tR3j+Bi9?=
 =?us-ascii?Q?jwCAvBhrBac5MXRsHIQyymbO7NRaBE/92OPAMTyverJADfQco08A2f31sRKJ?=
 =?us-ascii?Q?er/EaGq9bMJ92ZHVdZvR350MSQ5u9UMaqTqcGkKkmBop7UOzaC2TvMw/ImfP?=
 =?us-ascii?Q?ia/KOb27CEkzltKblRAOPMvGs7plC8EiAd/9FDmrKWX8wrStjwyxesJBC6hO?=
 =?us-ascii?Q?K/npEvgaGo4Iu76/rmfPQo0UL57K6pdNRMTK/N/azGdVe0YDLNzzOeiNtvFQ?=
 =?us-ascii?Q?PeMJ9dW/5rDYdOOzC5cg0mYVQqXR469LLFAA3b4DVtXP1lrJ9a7tVAKp+stL?=
 =?us-ascii?Q?RHWWyfc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SAblfxZ9pj53EoGBA/Ye6Luq9N88lbie+lENMFVfIuXT9jkVBpkNIR8bnGlD?=
 =?us-ascii?Q?XH09K+eJ3iGI4CdWuEcz6dSpLBFgxzWHbe5JtjcnWrPvrIOibmQioLeBXS13?=
 =?us-ascii?Q?+UblW/yQ7GMzc/KFPmS6b7xnx7agATGiJV/lla++PO7eER670/IU4BwQ8yUm?=
 =?us-ascii?Q?45YJahmW76PVtDKwCHPy26kqbetOTKaYTnJQ/OT4y+dxdHgB7JIDv6+em9EN?=
 =?us-ascii?Q?6bH+PZ/AvYZZfoBC16ixm0eSA65UMgPU0YFY+knVsHI8g5vjqPFkcrEm9MkP?=
 =?us-ascii?Q?0W4j1B+0R/edmP3dOp+lV4Hyc5lcygs+YIq+7OcRbge04l4OEjoMrg7A8k4j?=
 =?us-ascii?Q?QSkaN06bnu1nu62qoH8OW050EJR3GNtoT5rdTotAsQ2LN5exbLDP7EG1ArHt?=
 =?us-ascii?Q?ovh2GdJGgzorUS9Xo0zJoSmqIZLT8SeNKlbP5INXZ3Lq108fUfNKGvUkzgEV?=
 =?us-ascii?Q?ZTzxbuNujKAyB/HXkFEhrWFDHmVpghvoBjNfNarwsbLfq+oiT+zOsE+0lXpV?=
 =?us-ascii?Q?qTpuHrf4hl1n/zgy6diisBrXah8APGf0+eIhzcwbvHMxXJjWxmTXscZtTqFt?=
 =?us-ascii?Q?pQrWddhEFM5q7M8GouPfBp0FXN3qc3ubFpM1v2BcdHEaM1Gqk/cqgk4dcH67?=
 =?us-ascii?Q?hesv+AtNS9xB0u8oYyuB3GcKhHZ/8OxVnZXVhIbwAiG+QxHkgMizrXdPLil7?=
 =?us-ascii?Q?yEZanIi71Fe6pbC0XwyIqVyMFIEoeJ53lFaOGAbe5dEuLl7QiFpAWWFQ4ysS?=
 =?us-ascii?Q?oVyN2MYsFTLEb2iBZiTDURQo65vQzeTJtfYQ6FrNbnLAXNGsiGTGoZwb93fl?=
 =?us-ascii?Q?Kyo68lDxEVw29Dxby6UITWtH/wmmwBU2eM4HVlfvw3u9/OU7ZJGHuSspSkb4?=
 =?us-ascii?Q?ldcZnZnuNWyRmw+7HIP3wfKJj97cEDQwYaxoRVOfAC3c6TUKdDENwhdUb4Bk?=
 =?us-ascii?Q?QK/gUmPhhFnz5T4EBCEQkABZ8+fsazfnMMVPHs2oGYEdJsfDMlrhx1xYXNMs?=
 =?us-ascii?Q?n656WjHmRAMaa8FuePFsgxoU65F6QghCFXuQ2i22y/IIjnqbCzxtRLZK4PI/?=
 =?us-ascii?Q?LAKDetcdMmYfIJpSrYtI9v2KSEpbgd7b5wdT+cApahBnq68jtn/iStQnTbh8?=
 =?us-ascii?Q?mlr+JdOo0crd6jPZlpc+mifQ0Q7OY9aYoQ3QzYiRH6oEQoGqRJX6bvjz2DkY?=
 =?us-ascii?Q?bRRNO/WWW3iYXdjNtgxL7eJo7BXqNROCAt52a+kYt7ycpLf1kKLbOkNGkqBk?=
 =?us-ascii?Q?67DFEo8M95rNnh7ssMi0CO8wz6R1tSfonU2zrqjuBPXNnPvGW9Rxuh6YWHie?=
 =?us-ascii?Q?6t0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8F8CDBFFA1F6843A02DE27D5F5B5CBA@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2a3cc7-07bf-44ab-27b3-08de0bec5023
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:11:11.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1215
Received-SPF: pass client-ip=2a01:111:f403:d207::1;
 envelope-from=mohd.akram@outlook.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

An lseek with SEEK_DATA or SEEK_HOLE on a compressed file can fail with
ENXIO, which resulted in data not being read.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3124
Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
---
 block/file-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674c..7a3f66e59 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3203,6 +3203,19 @@ static int find_allocation(BlockDriverState *bs, off=
_t start,
      */
     offs =3D lseek(s->fd, start, SEEK_DATA);
     if (offs < 0) {
+#ifdef __APPLE__
+        /* On macOS, this error does not always mean that there is no data=
.
+         * Check if we can get the trailing hole, which should be guarante=
ed.
+         * If that fails, then SEEK_DATA/SEEK_HOLE won't work for this fil=
e. */
+        if (errno =3D=3D ENXIO) {
+            if (start < raw_getlength(bs) &&
+                lseek(s->fd, start, SEEK_HOLE) < 0 &&
+                errno =3D=3D ENXIO) {
+                return -ENOTSUP;
+            }
+            return -ENXIO;
+        }
+#endif
         return -errno;          /* D3 or D4 */
     }
=20
--=20
2.51.0


