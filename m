Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A3DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 21:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v04kQ-000329-Sl; Sat, 20 Sep 2025 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v04ck-0001bq-2u; Sat, 20 Sep 2025 16:56:02 -0400
Received: from mail-vi1eur05olkn20826.outbound.protection.outlook.com
 ([2a01:111:f403:2e13::826]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v04cg-0000oM-F6; Sat, 20 Sep 2025 16:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixPWYkYIQJgY1gfYfbYc8fnlea5S4yFQnUhk/dpLnL6jv0lTIeh7H8pTq6We+2crAjerXcZ8KTv2XVgmwUymEalTWF8uuY7oYeaMBxEoFzNWXMt7iTlvNQjmQG5yGzaXZlwKabhDcpXBZwcJxftZoDFiApsw3fb4EikR5g6nDrSwBJrB45UiXl2KrAJfPtidoyHBIyh6gybTrFpLTJrzntPHRdbNoyQG5VbzEkNZ/igNPMRVUffg39AiWv3EIUV+LnX1ocdf+b3rFYDSbDt+ELm6yLkkclKSBOFXWrRjDn1EszSXDymQ1g4CDsq4YXePVjUX8Jse+f1V7jQMmfDrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C50+YBAca4uj7mjCMI3YXyQMp5e4tnkeCUwNIPLyjKI=;
 b=MkVL3PdXAkRqej0n+saOu6DDVLkR4TbCHft3YqTF9a3St0bGoJwJdGTUk1dz0tlh7eBurGZYEYEBPPoykV41/T09lrVXybNHaWSFZYK6lEaoB75WQWkhvF2imkFyJ1RiHZDPFz73nYwbzzeg89l+FmV4szhwW9EU8SY0dvcYMeVE17s5DDYxaquJxFefXe0FGrj6buLVM0v6af28/PdCzhtwP5jUIRKh+OlhuWpZooq1za0eSz4ZZN9xXpdPmogBHiL0lgWO/MZj0VUxvVidrMQPNZUypsYsfjk9kYZFIvQuiItYoqtpK5Rhre5rqH2XJzdNaFxAAmOkMfIurcY0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C50+YBAca4uj7mjCMI3YXyQMp5e4tnkeCUwNIPLyjKI=;
 b=qXBOKywvhr0rNshyCVWXTvl0nNr/fUg3NITh9GLl1/iFKoyPYjU00yMzYCJrzNOXLsC+y4KL3rMVZVjUvOhOR6l2jAeiAbuf7W34i5GHxyx2QalgmQKS2dm3Olr1Zt/rTrBpgvMtbkaqpx5SgJklDIz6j2EOOY8rpOKcTJuS/nxXUtO5uMoZlJmkT5q3/9R3iDohEg0GY81iwD9dMbfIx/IruwanId7d/bd7lh8R9W/4TsgYvZInmhxcPS9xjNlvBF32LzE6cUc5fo/zI2iK1INWZi5/S20kAEUEcLFVs18gmqYUM2O16CvR17fFMjAQ/NbyZ7r4MzcuYpMR2EIfEQ==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by VI6PPFF2B97355F.EURP195.PROD.OUTLOOK.COM (2603:10a6:808:1::12a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sat, 20 Sep
 2025 20:55:53 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9137.017; Sat, 20 Sep 2025
 20:55:53 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH] ui/spice: Fix abort on SPICE client connect
Thread-Topic: [PATCH] ui/spice: Fix abort on SPICE client connect
Thread-Index: AQHcKnD0sTCpeqXnxUygP65JBgo1dA==
Date: Sat, 20 Sep 2025 20:55:53 +0000
Message-ID: <A759ECC2-6B53-4B3E-A005-7D06BA403FCB@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|VI6PPFF2B97355F:EE_
x-ms-office365-filtering-correlation-id: 5253937a-6249-48e1-125f-08ddf8881699
x-microsoft-antispam: BCL:0;
 ARA:14566002|8060799015|19110799012|8062599012|31061999003|15080799012|461199028|39105399003|40105399003|51005399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?RoXRwdq2A9w1+kRvMYX4pwZkKEvnI1SNBWMQcI17nMAEKMvVghFsHKktdZ7I?=
 =?us-ascii?Q?FKHoGIyz+m+zzvZV0SBM/dR7cbEeVMnfUUHMx+oikhUNTxWdPWB3l4k1Rte/?=
 =?us-ascii?Q?OdEWCTk31jw8XtbE7SlabeCIBgz68Kjwye845hqB8jqUDLtzpGfCfNAiOPb2?=
 =?us-ascii?Q?wAMtWAV5ELqhrcVYm+82D+P7ICDaYbUuAe1YvFrGSumgwU8vVnQyd2vFju0X?=
 =?us-ascii?Q?hezqC7mk6/vmcgTi8bcd4kQoj2gZz+jDH0sCjZv5g+ZFxEQtD/2h5/glaZg/?=
 =?us-ascii?Q?sW6iDR+cbHLk4z4cmw1I2fKMaz0IGPJh9Xza00ZursQt8msehTI3b0tAAZ8i?=
 =?us-ascii?Q?c6G56E+d8MNygFaGp8OSCcQHs5Ujxr2SXExc4BLknOZF+LX2wMNfvTy6txcy?=
 =?us-ascii?Q?GjEav3awjONtRzVCMuKTFwIkKpht4nBXreVbcXXgPG18nUsXjK7xHeahs/Oc?=
 =?us-ascii?Q?XNcGRwZN5LTLRcFXOpRq0p1IWyWCIPrj6HTYwGLDMfBFFSiT6g2WScgPViZt?=
 =?us-ascii?Q?mZWH16qDGT8AXCdhcrAt/YS87PzL+9qJvl5ZQH9HOc61b4WnPVPXinJWzPB1?=
 =?us-ascii?Q?0qCVoM2Jq7hRVsJEWZccujjqxrSxGb5Aba/4Ztt24+hJCKbkarnDaoNWSNXq?=
 =?us-ascii?Q?EDMfJ0MNawcRwSUmGkj03CZsg34NVppv80EXHj0W8eqBg65Dw2ZhPxk1R9eS?=
 =?us-ascii?Q?wbwLmbEmrvsb+3FBc0Jr+7KnSJEKAVufHuqGIcO4dNUbjlWzokehzvcY+j9C?=
 =?us-ascii?Q?XOSqwhXwozKPDxvx/qhiIPpkIM/5Yg87tNxoH4Y2RJ1byQ/BCyO0Su0ws4n1?=
 =?us-ascii?Q?G7QJvC8FLNGuOxLQu7l0figuKLdQRiNDqFBGZGdp7+ODBtiRrUXiTsfv92eV?=
 =?us-ascii?Q?MpR5GmWRTNUVm1aW5+X8qghV3J3d41Wk3hc0M+r3WkwrXs30XMmMH+fyoykD?=
 =?us-ascii?Q?4jMaKQaEqM0IsQK2G5lWWpuT6mJ+jcJNMjBJAF+VESzOG6pE/r+Tm0VCafZz?=
 =?us-ascii?Q?vmGdShIQcDIMBMh66SJ+1plyKSy0DVcPzsn5+m5d9OsY+ZSs4xp1hNirzRjT?=
 =?us-ascii?Q?6cKhsZoAOe9TdKFYGWsRBaFhfDTZ8MPFwRKnfVVoB5y0am5vSpb8EXefYrpO?=
 =?us-ascii?Q?lFa2fTNXcFF+xvhALmI/rlivrqaMIa44Eme4Qnh1cQF4Voby5lBD2AvQEnJg?=
 =?us-ascii?Q?uo+SNtkuy54QoF3VgLmALprqAzA0lEshbazKRg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/wKylZ5HhmsktGwMrlP20d8CSOnarp9IVFCPYf1vo51O3fSw6dVJyPzaxNS0?=
 =?us-ascii?Q?2Mj2VR6O1JmZeNBSrnE4psKB5ZpiCNDHrl8kEy2ADwXg/80Prh8AyXEdZqoI?=
 =?us-ascii?Q?+tiW1FPfiuLju2TKZVN1lOHSRm9cpny9oKnWLItrfdYDb5XSKrrMYRkJuRTX?=
 =?us-ascii?Q?uA5Y/7LVUEo0XVYMAUZP99yJ3Kfdl1q5x3uhBVRU9hmQE4TvjxMy+NVHjJ3i?=
 =?us-ascii?Q?rbHyqZWeol85gpFEQbuU/M3EvvW5w5dEKNgUKf19vLeTOsUz9eEsnUNs2Z/g?=
 =?us-ascii?Q?JqBpTcF2NeD1UrWKcifpBSx9X579ZxkGLceUcLZPbrUFoegIYEZ50Rcteife?=
 =?us-ascii?Q?HOI4mBBB10VoM6J+Pc6B8vjtvmc+MwanXBi2ZYNXjRN6t4VE7p6zKLYX+2Bn?=
 =?us-ascii?Q?2FptciWv/AmYzxdZx6U3D6OXjID1uHIaVtA9M+0N/qpzFNixUPvM22VC8Vda?=
 =?us-ascii?Q?iIMjqte+vYSDu8WXRtcu0NlopSMFcRX4HirIO0hFKa03K06GeR0L1S368Xlf?=
 =?us-ascii?Q?giYEyehttEMVTZR5oL4Wp0u3NOsvaYhGwSPmSjgZ1hOdt7cLsIL+dDTRMgW3?=
 =?us-ascii?Q?XRZzTEYZW30O2Nic0IT5scqiVvQMAr9TrewGWH5IAS2IMwFiH1RH0GOY7UKI?=
 =?us-ascii?Q?nQoMk+pbadlPfKtVEmzIaJGQBfWEnJ3DyFyPDZ6zIS6ydpLb71o1WGhSNApT?=
 =?us-ascii?Q?5hyOAcq6WVVrZcQBaVHaqu+w4ghop3M/yyjAopc3FnPhTr2leCO983OethmD?=
 =?us-ascii?Q?7GaL9keeqc1g9QMwurNWHRObSydjYpyUpEhojhVX74NDF5y84ood9ziCDdes?=
 =?us-ascii?Q?X1WBg01pTDV9+7o6xsmW/lvMGp0A3s3oaFlPfqooEUV3/KcvuvIfVUaG6RGy?=
 =?us-ascii?Q?15U0nMAQwafJ1HXYUkNYcGjfZIeEpc6MSIOTTVPk/sVSR5IKAryXgkm0znrT?=
 =?us-ascii?Q?RDuFpFsQmd2PS1RtR8Snj21nJdFuL9U9oCfhl3b92Nmas6Q+ImT5JSGhLzB3?=
 =?us-ascii?Q?eK/KC0rO1nhl4+iLhPhIHrYivAWVADFbO48UXR2lg0R06QTWWWVNyZLpLCZB?=
 =?us-ascii?Q?leCxoTG8N/RBroIj3vG0m+xo9dVCsoqSERqh0aH6lLYrZ9fJVYrtECog3I7p?=
 =?us-ascii?Q?hBB7bHJKFeFR2y4xLqey4mom0sQxSvaDaRYHrZKpaiIYcG+2wKT2bnJNsDrs?=
 =?us-ascii?Q?+drrWdKU069eCnS1azr4zxeNhwJpulqCN3VBVD4VpDg4KlfjAU9l6qTY4pk?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6980DC5B5712FB4790C66D7C16069D9C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5253937a-6249-48e1-125f-08ddf8881699
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2025 20:55:53.4431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFF2B97355F
Received-SPF: pass client-ip=2a01:111:f403:2e13::826;
 envelope-from=mohd.akram@outlook.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 20 Sep 2025 17:03:56 -0400
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

The BQL is already locked by the main loop, so avoid locking again
unless needed to not trigger an assertion failure.

Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
---
 ui/spice-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5992f9d..31c31f2 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -222,7 +222,7 @@ static void channel_event(int event, SpiceChannelEventI=
nfo *info)
      * thread and grab the BQL if so before calling qemu
      * functions.
      */
-    bool need_lock =3D !qemu_thread_is_self(&me);
+    bool need_lock =3D !bql_locked();
     if (need_lock) {
         bql_lock();
     }
--=20
2.51.0


