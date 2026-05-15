Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9CCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNrvg-0003z1-TS; Fri, 15 May 2026 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.zhang@nxp.com>)
 id 1wNrmh-0002fm-RO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:36:56 -0400
Received: from mail-westeuropeazon11013053.outbound.protection.outlook.com
 ([52.101.72.53] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.zhang@nxp.com>)
 id 1wNrmf-000772-RW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:36:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/FsuE2iR4A1GbKbMCv4jjXkAOgyzhTj6a7Y5nOpeOGqyO/WPs3RfJwh1Om1fC554mrr3wj12qaopoHuBS1EYRjat5tus9nyeUhrHapdFatyK+TYUDNB05oGSot8H75LDnGEhvKTsX87WY9fp8p+/+lx5IKxqf/JTRkM0YRc8tcPXIFQ8hOGjbpLtUEqiBVQl3f3BfI77Z0XDwSY7FqABx92iplCVPHsPQkv2In/7d1cwBOhR2KJpKVKjXw7vDTNkKgfXWpZP+INqPYcAbGweTjQvp65zbf7ZgWjxEmMuyha5IAzLcH6buygwpgo+I3lv+Iz76jmvtXl39c5JwLZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xXnPWDFptJyqbDUsorPuw7pyCdMVTPKIyTWtS/+r30=;
 b=QD7wob9fJdJR+AMDJRcYRkw0kEzkNRh9m2wlvPYz6m2zhHVlVbYSm6BmdQyJQTRCaAajPIH1RaNiq0lVop1DqiPXtWsJX3+RXICKNZjkKQFoFYBIB8LJXKO8oU1ECT4dFY3OWs0O5Pm1uYsaqBUgct7dIsvRxR4Eqh9WncJQczjspRc09aeJu5VJ1OBJf/38u9/tUDfSW5dPntmoMhDzoCKs/R2LF7ShEqUuNxpAI/CZHzOIIS0Awm97aOo252BsinBBclGOIE3XMTd9FtNGy2FpNGPkCIGtniwRge+C+QTtV/0oWzKb8aBpjm5mJzLkrOo0Vr8Mt9woIXJJ2QrnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xXnPWDFptJyqbDUsorPuw7pyCdMVTPKIyTWtS/+r30=;
 b=FKm3v5zqVwcYAhfSpHdko8ZLaZsn9yGTtB4+xQztU6sas9KkpoGf7wezG+Y5cU6nQLSsN3nWeAVw09YSsrEwodCw0Os9YbmknDV2LufQQI9jGdWozdVVoiy+8D6B4iEV0QM2cWk5xf2hcx6oxIvEUhyRnsxAmCnM6jCYCv3sPdqGZzgNj3jwVZIVx4v8IGGqCJk3ouo7VFdWhCp/X06RBIGIzDk5HeCyuUmX78DRwnYAmcA/IPeLFAQThYlLMw/INBS0m3dM6k8y9s8R9t/pWedmboyfyb8Vp9n/wDyABb5232XtvhLbSXz9wrKExCzwONEyi1O6KZ2CY34As/IOcw==
Received: from DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11)
 by DB9PR04MB9723.eurprd04.prod.outlook.com (2603:10a6:10:4ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 12:31:46 +0000
Received: from DU2PR04MB9018.eurprd04.prod.outlook.com
 ([fe80::c91e:9d3b:4c71:b39a]) by DU2PR04MB9018.eurprd04.prod.outlook.com
 ([fe80::c91e:9d3b:4c71:b39a%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 12:31:46 +0000
From: Ryan Zhang <ryan.zhang@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL context
Thread-Topic: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL
 context
Thread-Index: AdzkZbmsTFRM938VTq2SUPkaSraPSQ==
Date: Fri, 15 May 2026 12:31:46 +0000
Message-ID: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB9018:EE_|DB9PR04MB9723:EE_
x-ms-office365-filtering-correlation-id: 5b306608-3696-42db-df46-08deb27deda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|11063799003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: nTtrCayJjJqo1XQcqfP0VNlbgAXv+cl/F1xtsbUHNUJlZ2cJyFq6sMe64Ggx1sJtFiogp8IwLyEltqVD/z0UbKYVWEr+zArLmqyUbMDB+tC9gNDjtyC0UVn5P8aus39AK4YM3m3gxu857NM1tBEO2KvDrysCWCA49QEysJLegR2oNCnON6A43qhok6L0g7PUid1C9TxbS/rNCQcA+AZi8gScItk8US21UqS3HJ/60MdFBz20UUFdyPkY75ZFCCnBIqiKs2Jv0rpG1RWps9eFEimEoWeZvQ6bE1+Gc0Ee3K99/3gKC3TERC+GU1lGDXZR3x0Oj+dI8vRF1NQplfy44lR1EQ+8+dOv5KHalSfwSd7fUaJP0paAXsL3t4QQWmt+typVSVmhwJaxkykTJlgZayQTqK7IN9245Eue5HbnyxR2dvGWsv4RL8nI48bjgvKReDfFFZPXP0FtONPsDwx8qiWrwqrauIIvR7SQBD8jwiYUGxxX3HpOrrCaGYfZW5DaUqBvC/vnZcP+I4KAPnspxZQHP3dh94JtpJYaS4qhcPJZGKIj/ccqu9l7a756078nh9fggt1lriidx+JevwTzJYfcLTBhqOXucFSRZ7yC7bp0EAZ+1WtZGg7kQxSA0gsI9n+feSdBbgNgOj2kiQgF9DTzHXzPl5FNxlD9UJPrG6xeKJeFDpXwywMRzApxuny+t9XnVp7ERD/oYLjf3uIYrCYilIzPZR6a172fsYKx4JUVAnXXoQ0DPIQ3dJy2FE51
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB9018.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(11063799003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5iTQldO94dFJO0dmU9/hZzhkEav1SIZaJ1SVW914m/IafrwqVvyOArmEIpN?=
 =?us-ascii?Q?IGheR4XY16lSZ42RRahxeBpoqDDjTgcvTSBa1yKyQCsNgcELg2BISJbwkEg+?=
 =?us-ascii?Q?KFwgtS/QYkg/s+y70c2euhuY5vuqaBGLguzFkTXk9Dx6reYDH7g59QmQ8HqA?=
 =?us-ascii?Q?UVmTBjOyLL9Vcoglq19xEGB3EKPgkjFSNplg3EK6AKxZFVeeATEwKX8IJk97?=
 =?us-ascii?Q?e3OdFTb5kCW1Jh72i9llMcTF375lRVMrDZryBZKh0DqQ/RrRLlBKncWYmzt+?=
 =?us-ascii?Q?EfHjYgCT3QVvbp42U7VgzHc7GT1eMVuIupUee/Xn5KxZja/rzoqoWGa+OUkA?=
 =?us-ascii?Q?CT2fj7UNjTN3PvNPdG+4HqIEsdAex63gJBUopxl3TXVFaBnGg1pdFxcoftNg?=
 =?us-ascii?Q?0o11S7taKS2XdUEuokarfbzjdhzXIaUSk0jYrwyVTAuZ+iSAIBMVcoD39OIR?=
 =?us-ascii?Q?42Z9ZjocUq+pcSANpkRLWJ1aqsNmEuv9Pz/HCFolTDPpxTADD5kSr8S3RGfz?=
 =?us-ascii?Q?XbTVOWVsvwsklLHP56SvIaRFxm5WFdV0TbWwYH0lFNN5VuKYBPJSKZC8xh/b?=
 =?us-ascii?Q?WRnacutB3P9320XWAD1DALuAxaXMYSl7cwnizf+E0zWdxEBjDsZQ8ODs5ABG?=
 =?us-ascii?Q?GcAa772lm+dxayuI2g7YfUiEBRpbOX6s2Py2HLrPF2Q24nTExqCVURfex5gG?=
 =?us-ascii?Q?rqdDwlfz57ylH9Y8L2aifIp1Z3UxYCXTs+/qBlGrD8sDA8cdSF0FvKWmcMYu?=
 =?us-ascii?Q?22WW1UMSpAvzKJUg8rzE9SmiU3xxJH0hHc0TJ5NxpRN0orTsTFgthUV0DQFu?=
 =?us-ascii?Q?Khd44mm+WP8Xi5D0l2FDCCoyUT31KSDm4oZn6I1cYi9+zqZX074LN27puAth?=
 =?us-ascii?Q?/gLQ8VSCM5lOqxjAqZFjDXo8W9qzek6e1Wab6/bcPBlTcbLWgfrqEHfMJe56?=
 =?us-ascii?Q?c2aA34WaAmPfk6HSjH/PYsW1j51lwVDL8GfBsLMtCpw9S357hd5rVZYD26Hr?=
 =?us-ascii?Q?gCK7pmJ8qAeQRpIB/8/0mMCeM6d2Joldd2Lq99LrFURgy/jHRvVIEDKaYIYI?=
 =?us-ascii?Q?HlpNaq1dHZ/v2xkoQQr7tZ6Dkys3VhvA0AHjJuIjYo676mQbd880mKGlheJ+?=
 =?us-ascii?Q?rtJ18BwgyjwqbiDbss+myP1AGC+i0w+gkiDvagLrx75DOusft2p5dfSvJSUj?=
 =?us-ascii?Q?mEUnB59fsv4H3VEhutOvu87e5ynnBQDugWhLrYkdJu/TBjpkB2xQFlz/WBsY?=
 =?us-ascii?Q?2uxvfkie+75ULLuGwGQSj3dem64y4hpfijNTP84b6WHb1uPzPrZeorQA6UpN?=
 =?us-ascii?Q?2MVvjac4oZDo6Q4Zs0DVBh7uoyL49go9nlIqsX5AEzZSRfynLRYQMohJwULM?=
 =?us-ascii?Q?GZxo+uuLN9RgI9zCLuCgwaGrVEZRCdd5BtgyW4/5zvCMN/4C9DkUj6yqLnFN?=
 =?us-ascii?Q?DL3d4OClHUqp6e21U4WMV4MsM4wUGHg+Z+chrt500uEVAY7RFZh4wOR4dTin?=
 =?us-ascii?Q?LPM3F1qZwUWsSGg//jTEb8A8OadOyJQeO2ssPuJr0X+KWxQ4oPgY1CIOMnSl?=
 =?us-ascii?Q?LYOc4Iu5w4JPL8xmdWgBcSDsxCLsowHNMAUUhguYJl75iB+MQpd4o6C41i5M?=
 =?us-ascii?Q?kBvKAwboOSTxz2DgjxbLU0MSXaNos5qn9pR7X3WUBIJpJouK9GdRoyQn+lIK?=
 =?us-ascii?Q?xLC6xpGWr3SYYeG9vg9E1gCDgaOmfEJ2c5kNIAgd/SAtIPnO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9018.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b306608-3696-42db-df46-08deb27deda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 12:31:46.0930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxwHRAd1GoF3KQUDBzFnWkTQlVD3TJHhOQxTtffNc7TIdr9YSSzQp2rGfP9/v+Ib1h1Q1h8Tr4lynEVmAm0vOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9723
Received-SPF: pass client-ip=52.101.72.53; envelope-from=ryan.zhang@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 May 2026 08:45:41 -0400
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

From abfc1a95936dd832fc2ad9d64d4e3f3880c697e1 Mon Sep 17 00:00:00 2001
From: Ryan Zhang mailto:ryan.zhang@nxp.com
Date: Fri, 15 May 2026 19:21:55 +0800
Subject: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL cont=
ext

When the user selects GLES via '-display sdl,gl=3Des', we need to set
SDL_GL_CONTEXT_PROFILE_MASK to SDL_GL_CONTEXT_PROFILE_ES before
calling SDL_GL_CreateContext(). This ensures SDL_GL_LoadLibrary()
loads the correct GLES driver instead of the desktop OpenGL driver.

Fix the below issue: qemu-system-aarch64: /usr/src/debug/libepoxy
/1.5.10/src/dispatch_common.c:872: epoxy_get_proc_address: Assertion
`0 && "Couldn't find current GLX or EGL context.\n"' failed.

sdl2_gl_create_context() already sets the profile mask correctly for
ES mode, but the initial context created in sdl2_window_create() is
missing the same treatment.

Fixes:da3f7a3ab9ea0091955b58f8909dfcee01f4043e ("ui/sdl: try to instantiate=
 the matching opengl renderer")
Signed-off-by: Ryan Zhang mailto:ryan.zhang@nxp.com
---
 ui/sdl2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4fcdbd79d3..9f826afefb 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -113,6 +113,8 @@ void sdl2_window_create(struct sdl2_console *scon)

         if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
             driver =3D "opengles2";
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
         }

         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
--
2.43.0

