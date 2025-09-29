Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A837ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G6O-0005Zr-Eg; Mon, 29 Sep 2025 11:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v3G6G-0005KX-Ej
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:41 -0400
Received: from mail-westeuropeazolkn19013087.outbound.protection.outlook.com
 ([52.103.33.87] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v3G67-0008W9-VU
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJEpzT+XMgMrAkMHTM8bNAHOJG5E9mK/Nuh69FsLf/tA8MolH+XcZu3BBKXRFE5YE7YR8XndNy9YFjOUqAo10LKgz7H3D1+ZIYeA6c+EsfgeNzt2QI28/XtsEYsieHYtFMQtJnkDOIy7AeTppG5QByciSLx7ZqgDU+AhInXqRp82UglkKEKjixrofXU6HC+ziCrB1AXVsk7Mv2rjDaYNtOgn8ZxIJBUpuoRTcn1jIEOWRNhpu3d3AUDpCvumldNh0n1rob3tedxjaIjhfOfNSY8c+vh1CFhcn56jKwGBbEKKt65RvDEzU4VdaIhqiXbl7ojwIPSCgv39Dc70IwahGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjVlU3KdpnZ5Sdp3VQYm6kck6kpW5d/LvJ+iNWU1YZY=;
 b=V5yKwTWX1aeDPW5mI83lJ3oyOV4tx5gnPUyCfJ1Ex2xKUXspJSrYDvPDVz37DQG4FeiA72xpho7AhwXEO/t1Ws8YDD0mc5bH3lWyp+SOfdHVRwjIruhmJVExqdnBZ8L5aNhWbYXiACxw53vhTsLjvXpJH97s0lafirkoKmhu879SzeqWV8cNxhbp2q4AbOFWHyi8Y3tQLYDRNfYAw8hLW0YPPo0o/aUuoq6M+7N/qbdovsx5nWXqYWXBIESLEkohc3jJmzjzvHFsHsYsS1ME8ORjtfkaLesICyS1jc3V2yZ60BQ7QsAD2WGCqW+gZS+GhErMxm3rlE4kReBDEm+5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjVlU3KdpnZ5Sdp3VQYm6kck6kpW5d/LvJ+iNWU1YZY=;
 b=VS2hA4cOWpoyN/pK39JB2g5kvkr3avIUKcBSWrCZMwli9QXu6g2FagAdlOvLbbSMhMcF5v/yQMINX0dgSuYseBUpo6Y1h0CXKA9YLMzn2pqAoKlZT+uDS0t7G0W4e86lqO5LG4l4sefZ33gZ6TptKUB0/ZhsjH/LbNRQA5exKCRHIfTcTIPTLgZGg+8cwFyJ0u4CPy7Vac5s79pHwBiFLDMXu3uHOHdC3Ucaw6TKgFRsKOwbmwAqkiMLgF2Hwy7ph1YxA6g1nzuLOcH7Ge4lI4CtIy8laeVk37tV2eTc08XcwGuncaptSeO3/5i4Es0OiJOp6js0sve/Mt37nx3gDQ==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by AM9P195MB1284.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 15:42:24 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:42:24 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] ui/spice: Fix abort on macOS
Thread-Topic: [PATCH v2] ui/spice: Fix abort on macOS
Thread-Index: AQHcMVemgZZ6bIZg40y1tjudHUjBmg==
Date: Mon, 29 Sep 2025 15:42:24 +0000
Message-ID: <C87205B9-DD8F-4E53-AB5B-C8BF82EF1D16@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|AM9P195MB1284:EE_
x-ms-office365-filtering-correlation-id: d0714b20-9231-48ed-9da5-08ddff6ec907
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|8062599012|8060799015|31061999003|461199028|12121999013|15080799012|41001999006|40105399003|51005399003|440099028|39105399003|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?PtFcX5EYWdN4lBKTmkAWLECq5nVGekCTzxYLQmVTtlSLJ5LRWklWPFIf10EZ?=
 =?us-ascii?Q?fa8Oq37XBOYDgszFp9n8gXcTPOh+PxTxf71xPzJUWujru1aibfEqMW0mqEhu?=
 =?us-ascii?Q?CvTNJwCtmKGqUVTJxRME/BJA/YrSg0UlcbLvmmZHO0nFqMFSEQHw90WbTxg3?=
 =?us-ascii?Q?IeR0M361gZLVOBRc9R2rL0CNRTI/PyVMwyvJzAnafSskvUXQ24QNOLyW9mXl?=
 =?us-ascii?Q?mHzaeBM6BKgwXBzuzo0G6Cc1SgNi1nVAN47qAm9MjGP1S/Vmd75CbjoTaTh7?=
 =?us-ascii?Q?rkD2iosMGBIxr8zn7jFPCI8pUR5rRXJsdnhaK1Ur77BhSU7WDNXCEWFMkFG0?=
 =?us-ascii?Q?WCywCa1cFQuAOuY/wndCViHVuE1MklDlXZR+6msaerjo5eWB3p0aPLsOv3v+?=
 =?us-ascii?Q?XpJoSbxVrOiiG2wtbNgTf+u/xInKswlfegNo5pAXyvokwYu9zVPAAnB+E5C7?=
 =?us-ascii?Q?ZYC6ner79Bp+aUFu7cWaKu//3WyfCyGR8wFaLJJsEa+h9Thj015aGmdRDMAp?=
 =?us-ascii?Q?clR2v+gwMOcVUm/1nOSPSIbBNz3/QwDAjT2U5gZ9Udi2as8DgOT0XUQmsKNI?=
 =?us-ascii?Q?RUq9bAbmV5pWW3LBbaVfKbp/7Eb7BRXL2SjxiuUQkjTEcuPwhkfv0Oi/UUZb?=
 =?us-ascii?Q?4XBKgyCkve9ttmdKmSFJUdT+2XO99YY84Ma3x2gsbxq3nTCuK4GrqAmhKy1V?=
 =?us-ascii?Q?zCbcEkCFRsQDaquOADhxaEwwKc+N0dS/cII334yZSAfomYnDMfUlNU7HiZte?=
 =?us-ascii?Q?rNZTYAu+feZvlyXxHvkMfPQv4njsjnBQBiHTK+ObamsXO6YvsD9xM9wffjrC?=
 =?us-ascii?Q?Raqjq1C3WFH6aV1ZHl/G5NhzrWLVm0TFjEOs52rJde+F9Lv5ogZOztQyWAJp?=
 =?us-ascii?Q?JV2awk3HixIdr0OtWGH7JRhthgShzMX8O+6mHFLl8y37SC66Khcr1bspp3g6?=
 =?us-ascii?Q?jorGe+/Syg+Hk3zqEOjGtpYKGfoYguRlcm1hA6qug3/6euIR886sY9f/DMO0?=
 =?us-ascii?Q?jrOA8lICqezj2FCoGMAWCquhdY7e3mDaixzpK8Yq0EOPt4GijMqmh0cL4Vy1?=
 =?us-ascii?Q?lvGf8fd8YWpRzfvSuTF0RteaBC8qSBEu2b0fiBUnjBS3aTtlZHRIc0FSHTZ/?=
 =?us-ascii?Q?2B9Vue5rjE+XOT50ji3CGRfy9jvWMny4judJiYmmtumy6rS/wmDQPTsv2SCw?=
 =?us-ascii?Q?55YgxIRulqMu/7jO//3JkChYuS/pUe3xwF8m0QzCckmJIE04rjTDSg1aH+9S?=
 =?us-ascii?Q?i/+Sh8Jw3B4oVgPNVv9VSAQR8itkxySEOcqYvtE2JUD9HbOFsrYfWFGG1x3o?=
 =?us-ascii?Q?04k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+s6s6EDkeUt2ngs5dbLkNHQrWt5oIcvNSWtUC3/+WdquT08K+RtPWpniBL0?=
 =?us-ascii?Q?DgI2rj1XFqmxN0+cyCQOKrVPkBlr55HHx0a9eklqwCYXQdkXOznjinaUlbDo?=
 =?us-ascii?Q?Guq8hHBQTGl8Nk/oiIgfOm+q5ZzxI4Ar15BuE4AcO2cSTZYCV88P71Fdizq6?=
 =?us-ascii?Q?3KOUDtnBsFrWN25GgbrEm7YW3kunVyih3mdkg84tal+Vr1yasSfK+2qjb8JZ?=
 =?us-ascii?Q?T7bwFB/rCoPbvhvfuEjEp6Gdebchb6mw1HnbUM7hc3f3auQGII1ML/MR289g?=
 =?us-ascii?Q?iIfSAIRBAwAbp+R5xwS/NZ+EErHRMZwuHrgIoCckTNFdURrzku7G3fvyx9mV?=
 =?us-ascii?Q?gaGbaD1TaKpjR6QeAZQRRx8tTUduIVD5F1Z5y+fLsxipLX1b5uSwIzMUcgIg?=
 =?us-ascii?Q?/cQjbFHqtIVlsRIgkLQ6gSO+EM2WsbMNDdogAUJgPx+hKoaX7j9SPjj5rs7u?=
 =?us-ascii?Q?oWA44xcXWAt2d1WyA3ccQlT9aYY3oxFwKtHlKPccUraQK97gUlserK361m2p?=
 =?us-ascii?Q?QJO5faIq0/0PrlOLuMheiAslY9fjil4H+GTvMnzbeHMuURHYBNXD4c+aTdkD?=
 =?us-ascii?Q?kPq2f9zOnfJQ6Z99FdN8kR4ILlGJHv9Zb9CNzrJ29ErBrX2+8317SONJjhC7?=
 =?us-ascii?Q?6i9ewdy+0TK5mEjPoGGUVqrTwTzYY8j+npD1/lOeYjULciDiAFRiBiRLQM3y?=
 =?us-ascii?Q?wsbzZacfezuHVi3Y7TgrWTQzBUkTGcI1SwHW8jBuiLEku6jM7k2TaGTIP7XP?=
 =?us-ascii?Q?nGa0wPensYzI8N6R4A4l0ThFcQ/FIWgRDHC0IxTfhXnAkgYtRpXdRQQBUDkp?=
 =?us-ascii?Q?4PDT/6uifGvcoi/xsDKxnZiLh1OwJbvv3o6gloyMpgeWXyjv2OwBHOFchw6w?=
 =?us-ascii?Q?vM5H126uh+z4dmYnOQvxKQjm/s5RStzagnd5WNKXLtfhH4rTkbtbjjb0JGM/?=
 =?us-ascii?Q?0tkVUXcuQMwD+hSAp90UvK3BgQDBnurG7QP5L54OTjS6ZciB0uVKhClBCA7l?=
 =?us-ascii?Q?miC5yzDGthLsXzZAlBwiDy8RAKW8koul3sk0XxzSU71CJNSAf5QHYY7QHlj7?=
 =?us-ascii?Q?A3eWAPxUPUltD2Dda4HvrAn60pl4sC6gN0FjVHjEUXaZsVgZEDRt7Sscdxmy?=
 =?us-ascii?Q?8uwR8NiKe8adVGDilQRobbQdwK35qVvr9KUp5/2/ogqpoGNQEQ1AoMnUO6Qg?=
 =?us-ascii?Q?XUmXCt8ACmEnx/PSBZsI39pZfJNrxvsKTxBrfWkYtgkhu16rRrEJkFD/t5VR?=
 =?us-ascii?Q?rEjE4AnmmQOxMyo9I9tTmpo5oFBYNtZ7aBwmiU5xYB2GncMmRv2OFpMa03Yo?=
 =?us-ascii?Q?Zzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BF6935FFC7E8947A874D7645833C869@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d0714b20-9231-48ed-9da5-08ddff6ec907
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 15:42:24.0637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1284
Received-SPF: pass client-ip=52.103.33.87; envelope-from=mohd.akram@outlook.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The check is faulty because the thread variable was assigned in the main
thread while the main loop runs in a different thread on macOS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3070
Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
---
 ui/spice-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5992f9d..2645e96 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -50,8 +50,6 @@ static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
=20
-static QemuThread me;
-
 struct SpiceTimer {
     QEMUTimer *timer;
 };
@@ -222,7 +220,7 @@ static void channel_event(int event, SpiceChannelEventI=
nfo *info)
      * thread and grab the BQL if so before calling qemu
      * functions.
      */
-    bool need_lock =3D !qemu_thread_is_self(&me);
+    bool need_lock =3D !bql_locked();
     if (need_lock) {
         bql_lock();
     }
@@ -675,8 +673,6 @@ static void qemu_spice_init(void)
     spice_wan_compression_t wan_compr;
     bool seamless_migration;
=20
-    qemu_thread_get_self(&me);
-
     if (!opts) {
         return;
     }
--=20
2.51.0


