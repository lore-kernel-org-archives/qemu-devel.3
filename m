Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFABFCDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAzB-0005SZ-3h; Fri, 27 Sep 2024 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9vp-00058y-VO
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:18:46 -0400
Received: from mail-vi1eur05on20731.outbound.protection.outlook.com
 ([2a01:111:f403:2613::731]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9vn-0002Gs-E7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOnHFH4dJtekNiaY0+UuRoMUx/ScVmMYVbd1QP8i9AT6G4dXoyh0joaswlJku2jjq/lw9KnUYUKConh5mbUo7IjWuGJ8934Vp+AP6cRpCsyxVNFxg7/9PjwmXAcSXuOSIh+u5wA7LZfJtL/iO/QIVaNjrRT1Eg9F19n9zL0QtU3NnpzywxB+sVHYo/luXqSFUfw+zdWrFeuOizV/2RGWsYMvv5P2LNnkpxs10Sr1AnsQ2POs2jQoAkMw+l9kx4ZBgMWHcjDkSG0VZqVYtDNPzdnrcZu0yU07zAMGSjkufka4bhnnSwMXgm1BuDqrlfZJGSXUBPxweN9mutFO4i2kWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awGE/t854GsOV2vvkjr/OArVze6+l7g4LzSztEJ0NtA=;
 b=tQ5nFli15dLfxRNXoZbL35xRVk57ybh2gY2YoS7yxZ7jBnMIXJYRg1so6A8L9aboRy65OXLCeqM8DibsoDw5l0fyR5H1GRxG5mMJXtwfEOgOcuNI44wPyOlk9OdgGlO9Zr+GbGbA6zO9TGCC6Mowqjj5j6E/uW9Cp07jUIgecosL31EIPmhM4KmeMvw1sIh161ktfC/FB/o0MeWYcIM3y5uH43u5gv3aaahkxL3S6XkR3SXWx6qqUdG5tShPqKwYIfE6Q++FGzTHdDIP/ezcKBaTEnLercnGwsVMmrEjocwx90qdvEw3UKVUQI0PMWn1fdsXOz/pavONmNARW3EMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awGE/t854GsOV2vvkjr/OArVze6+l7g4LzSztEJ0NtA=;
 b=osNmc0iPNlrv6fsFI5ff2v43sTmCNEWEofMd1wdwJcPSAbRPJMFlI81Cu5WdIxnZGSUlMUMlj4kkIO1fQNy3rJw5Xwp4irWiSRImgezJ0ck//WQvXm7S/gBhduCLDPrU8Bi6AoEvO2eEqjtix0RPnqe2ay0XRrSUbO8yxrdBtKHdTrk5RFCZcE0urZ4bupWz3/X8WZf0QJZLZwxL3ICSNjNd0NiU9/yr36MpMO/2zVYmNVq9gB47xCmp9YtgFfHTTqOE1v/jKYeIXrWPL6bW+Zzlz9ogNk8WfFl/hs/d3rJIu6+WV8Sh1iCsDUJ0yuBo/r31vGAIvf76ICYsqv/Mwg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by GV1PR09MB6956.eurprd09.prod.outlook.com (2603:10a6:150:1af::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 12:18:36 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:18:36 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 8/8] target/mips: Enable MSA ASE for mips64R2-generic
Thread-Topic: [PATCH 8/8] target/mips: Enable MSA ASE for mips64R2-generic
Thread-Index: AQHbENb+/5bGNESAkUKWDt6/cb5iyA==
Date: Fri, 27 Sep 2024 12:18:36 +0000
Message-ID: <PA4PR09MB486474840468F3EBB3F74F2F846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|GV1PR09MB6956:EE_
x-ms-office365-filtering-correlation-id: bd8f1422-8237-4c81-4cec-08dcdeee830a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?385l/q6sbd2jAfibJKm/mVH3Wx17NSP523qiQRjS3N82UWAHcrt0wQfbNF?=
 =?iso-8859-1?Q?0B8IJKme3wYIOCNSqEcDyIKcJPT7V1YipNrFhH3pUL38/EV5b4yh/27ikx?=
 =?iso-8859-1?Q?wT0jq38sPM9PN7IqNaFZFh6mZyzXgKIbMwEligAapZRWCOQhBbJDvV9wFT?=
 =?iso-8859-1?Q?3OSv5zpISmghqAyi4pXfvBVptBObh4zCVvnTxqpqqH0+IIfM/C/umxZW43?=
 =?iso-8859-1?Q?NwthkVpBXmZNjqtigjzvoU3diIM73hJLEI/DKsXfoerFNsohaOVw8Gozfv?=
 =?iso-8859-1?Q?X008CPUkC7DzDRtsxGRE5HUhJvI6Sr11AyRtUg6luFxlZ8Wvg6cg7ZCD7q?=
 =?iso-8859-1?Q?aNyhVcwhIWyMxP7F3iHOwLnar6rW+EnAx91VI7XIrXqjaFwSku+OVyP/A1?=
 =?iso-8859-1?Q?YQ1llcgGJ291fqCo4ivjx/kjULCWrvtSJx6erm2Gyl+i5Kc8fUYgxM82QM?=
 =?iso-8859-1?Q?ALp4PatlFBphIzKm/enZvADauJGU0qJ9Nf+CdkxkNyOL0ZjEpgNfv0MjX6?=
 =?iso-8859-1?Q?8GYHR9OXVLByPD2pl+W5+lKmmz2TYlzjHv/A1pjNfDt54WWpXg5Ms0Y+yR?=
 =?iso-8859-1?Q?nXmiH/X3fG25pbtNvaoRFzO5WFUBAYUzQxBpu4yp9A5gXLgsqOHRWbD2cl?=
 =?iso-8859-1?Q?ymOSFHlqYB+mLiMEUENn832sTzSUgVbPp99j86kYRlGwJOrkFJ+JTaHWTQ?=
 =?iso-8859-1?Q?wNwnsFhhuqBFeiQcZSmLv2oFfUDPK7WScppof4LkFU2kFO9uGQwDQjOGH6?=
 =?iso-8859-1?Q?FjTA+pyE029zBCVjBYI6oB68y2vNGGGQqyr6gWQmoK1ugp0SFhiYyRyi/b?=
 =?iso-8859-1?Q?I4qJSeWEdtHzuvtWrsJINLHskW/9YP9lbxKH2X3ZaCeM0h8GvJGL7v2t08?=
 =?iso-8859-1?Q?vJ3UW0wj0dUa9J2Pm2QLtdG6WoCsj11E8nIpL52b3vqt5mWbm0W+DrnLIH?=
 =?iso-8859-1?Q?Ld7Zv8LifTAqlEKvaHh1HguposmRrEpdmCHC/kEAVqL/GhB7E0PL1o5cvk?=
 =?iso-8859-1?Q?E9I4oehc//1H6oPHbzKJODsHmmEMhWT+7i6vz2lsxuk943sXRpFj0PDh0E?=
 =?iso-8859-1?Q?BxboZkiHoHSQDCUsZrvtqaJzDiolxags6u/bbcRlmDvBFZlAuUN5TOAuru?=
 =?iso-8859-1?Q?yzdklBtdWzFM7RuQyk2bfglIn1HCFHnGRs6P9JFJiIlatSXn+zpgcMwvU+?=
 =?iso-8859-1?Q?3QPUSpx8dv6j0yEWPl6fvpdqFo0XAHZrX8vu2p7rOfFO7SrMylfy9rh49H?=
 =?iso-8859-1?Q?hhsSH7JjzzV40FDp25cZsKhe/o7AT0vOH19UjfuylF2O/aLUu/zJ3mtRrv?=
 =?iso-8859-1?Q?fHsGuV3Htpoj5EKqwzZbuI+ky+4xx3E2cNUpZSG8ZZ4avGZqruCakMNK5k?=
 =?iso-8859-1?Q?8nPpiG5W+ciU3D5P6Nnwrh0DJWVUabVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7+tYj5bVSKBecASwQoCs/RKTaMKwFj8DPqpC9VMH1ULaIDbk51HCleyYms?=
 =?iso-8859-1?Q?wpeeDJM2co5ZB4NUW+CuLhrq3IP9ssT/rHkGbmSUlM9sq2rUxjfSuZY9XZ?=
 =?iso-8859-1?Q?4YAvQJgwF7fN50QfIER3geXqomoRlbcymPAWOFGAYt1XscC1YvEwHKv4qI?=
 =?iso-8859-1?Q?wZjDt7pAJmXVbAKqOTucWSr0v09jUBsNMROMidRMyAgxeVDvko44QqzQgG?=
 =?iso-8859-1?Q?k22LQdsgBGC+f+8rxVQsKi6DutUndrKDnfO2PpEw/Ksc1M4HXqtcec+u2z?=
 =?iso-8859-1?Q?HvmoYRkcPl8bCjxSSUXnb0wCzOYZikcA5rpGkmMShpAIxax4chn5u0iqgx?=
 =?iso-8859-1?Q?rNbuE1j8spjPEEBMsgLknLYB4TtiB75lqviCl2j7HsTznCDQpjd/zclM0Q?=
 =?iso-8859-1?Q?uMsTK84TnYLQ9Uz86+l5mg9TrCIcxhABodYCa+mb9L18fBTNwIq5THRrLQ?=
 =?iso-8859-1?Q?YnVcJUvEv5acIF/170+iUUvm7TEx44JvpTfzTZJb2v+QQNAztLo4qkn3bT?=
 =?iso-8859-1?Q?fELeaQY6Tl9xl8DVC2zukMtjcKOjEDvOg20u8K+Xf77fo32LyyLobf4Bep?=
 =?iso-8859-1?Q?/cc7592XPA1FcTgkEANxbMguWJBMdLCcoDF9CXx841m4/t6rZUlERr6/CN?=
 =?iso-8859-1?Q?FfY+9++ysdWjTsWlktBv1mmWJxNBs0dtd3Jt+axkT3UNDGshtUBIXTZkmu?=
 =?iso-8859-1?Q?zOtjC+Mym+rUjD5CUYdcexZmemATM+tb1zITUbeW+kpQccXvFiOc2Kemat?=
 =?iso-8859-1?Q?b4fMCtWinMRwUIIKGyezhTrHqUQ/7xpbNey+6/IdxJsHneqA47wPTeOZmS?=
 =?iso-8859-1?Q?gZa3w14CwXZAvX/GNmpdWOzFv0WVU+SbwEhX3VoJpnp17iivu89Ee1exzh?=
 =?iso-8859-1?Q?2jsbvGRU+6bc4YZbq+gFli9T5r1F0ZwkRIgGqdAb3N7nmuQWG7VOxGNZG0?=
 =?iso-8859-1?Q?S5OGSPUIcQ2Pq9Gw3mZzX8MLQLrvT26JhjJMXnI6xQI+uLOdbsfHjDxXrB?=
 =?iso-8859-1?Q?guzPOUcNt+K/uRQMLLyfetDkeXbX82N4h4lav/nG8qlP4Qo0CYCte+zGfU?=
 =?iso-8859-1?Q?+KIy78Ic9ylqT/Ci3nfRpd/8F1dpLLAwRtGbiBAovxyWq1LCMUlaN4X2KY?=
 =?iso-8859-1?Q?EaL4LBtoJkgtDqFaZtKMwsn0SVMYmbd9yZijf24eUTIUKdc/9Vb8DkqJKM?=
 =?iso-8859-1?Q?5Nco3bb5ZKT7Coc9NvbO1UlQ6l+xwI2R3gjH4wBzpVNdvplT0OmBfkLuv2?=
 =?iso-8859-1?Q?Ta6sJ4sOSC+WMTjjKNIDPdn9D2i5PLHiR2/5OB0MOS9EE4gc8JE7zM0bGK?=
 =?iso-8859-1?Q?8KCyjqqIH0IXWwWo59/9dZdffPgSGsuFcsUwB9tXUnf+ZVI9blQ52fuUDm?=
 =?iso-8859-1?Q?jsmP7Vw/fXs0uP+xRWx7XxNdI/R1tQgh0OBuxfr8XAy/uZ77gRdGysqwf/?=
 =?iso-8859-1?Q?MDOp7/8bWaDxFbNIz5hIAPJdHByh6CMnX48x7ptoH0sdyaMd6lOP75iLco?=
 =?iso-8859-1?Q?QTatDBfDJmuYm1LvA/PXbbyOputQUMoF9pQfQEZs5I6hRcLBr9apisrSoj?=
 =?iso-8859-1?Q?jt316PflN7F0pwfVqhVAdKfc9ecpB37VbHOJhsfhPK/l85LFVepH2FT4QD?=
 =?iso-8859-1?Q?4Sl2KP9gjWOPd3IY9ep40RiqwzV27itihyiPf9axi80QCMvj5Z2Y2mvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8f1422-8237-4c81-4cec-08dcdeee830a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:18:36.1282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwMe7A2MV6AuhRjAuWp5FkH6FXI1dW9/NpkQSmNmaYjFp5DGnm5JRm629j+1j8nDugLBi6tIq+cnra25mjYvtHlb8LDh3ggpx3+oaHkN4n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB6956
Received-SPF: pass client-ip=2a01:111:f403:2613::731;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:49 -0400
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

Enable MSA ASE for mips64R2-generic CPU.=0A=
=0A=
Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f=0A=
from  https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index 19e2abac82..2b707cc5a7 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -678,7 +678,9 @@ const mips_def_t mips_defs[] =3D=0A=
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA)=
 |=0A=
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP)=
,=0A=
         .CP0_Config2 =3D MIPS_CONFIG2,=0A=
-        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA),=0A=
+        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA) |=0A=
+                       (1 << CP0C3_VInt) | (1 << CP0C3_MSAP),=0A=
+        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn),=0A=
         .CP0_LLAddr_rw_bitmask =3D 0,=0A=
         .CP0_LLAddr_shift =3D 0,=0A=
         .SYNCI_Step =3D 32,=0A=
-- =0A=
2.34.1=0A=

