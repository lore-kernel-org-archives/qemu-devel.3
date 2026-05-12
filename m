Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF4CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgx3-0005in-HE; Tue, 12 May 2026 02:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgwe-0005TM-5S; Tue, 12 May 2026 02:50:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wMgwb-0005HB-Vc; Tue, 12 May 2026 02:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va5vHcSsZW/du3g9/nldVyax7M5w03qKjWTUtWy5wGwlmYtky56zf09ROazQ5E/QXhFhsqo1fRryq0rrVy3irZjK+XLfQbwxvWkWlJa8fCQVbPfyZSMOw9HVNtigke7l+nYAj6Xt+kyKTj4rdsPx5LD9u6uw3iL3obZRIg5EC6lTZC5BoqyVdP2+UafQLqOfbXI2/qN3usRp18CC9SDuyA+b9ktwx6wbz+GkNPPhdqiUshLzvisw4LhyjjMX6pgDODJVnRRgS0GfAu1kMBISO+o7LVV2RFinPwB6XUWPEIuc3yJlKoRUVmru+3Rfi/LV2JaJkJu9fkGe4lLHv96xeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9gchta8Z4HzM6nB61cI6I7PQzlQ68T7twjYyTooPrY=;
 b=YbCp0ZwZFm8SZ6aLr7u5RAWLXGcfpI6+6LpASRxAlBo0Lvc0/P6X3rPJQYPyFXrp58oDU5WAGf948clayh5vKFYu3CL10I+E4yjnyv1XA+sbKss/mbUepsm0QWgIpJTRuCRT1vYmpwKCNWvuake+oM/NGVWPeuhjU59diGhkWSkBHqwJkH1WmtENw+J/DQhcU0bQPgmoSlvZTZ7uABGByyVehNB4LxxUhxyJlGAlwpCzYjA4xyKwvI5Tk3GMrd7JSPRhl/9eB3cDnVMUA4HpAjLCn4r4F278Hk9g+vgrsYnXbxSqQss/Yq/d3PwVvpd6gWeUihDZ57cPpuAAwfGrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9gchta8Z4HzM6nB61cI6I7PQzlQ68T7twjYyTooPrY=;
 b=H3adka0+Hyq6dkOStwUcJIBTDsxKyKDAKjucWPrHleRO37jRlLKfwo514tpFJQ4G1mdbfR6vsZtq64mUVrtzrl4MpTYVxK7J6CIQvbbKO5kpzBMymiXAvD+xOa+Y+Djj7D9lyMld0zDwzymIzT5f/a8duC6t/T/ZelwyGmExgxU7NqJwwTbZ/exkSPoLgelTcR5MfRAeCeELzMov1R0P9HVWPopNUiaeM1aKGSS8Bh7NYhu2C9jU23oL8FKgWiQay++jt14z0va2Z4Dn7hDRhGDYw63Nr3v9I8yQBKpWUjNBMnEFHuIM0OpQi1n0w23ZvCpNdZ7EazGeCifhXnMQNg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB5225.apcprd06.prod.outlook.com (2603:1096:400:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:50:04 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:50:04 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 1/1] aspeed/hace: Fix mapped address may not be unmapped
 issue
Thread-Topic: [PATCH v2 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc4duP0bFjRA3QwkWY3geImkza1w==
Date: Tue, 12 May 2026 06:50:04 +0000
Message-ID: <20260512065002.1516704-2-kane_chen@aspeedtech.com>
References: <20260512065002.1516704-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260512065002.1516704-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB5225:EE_
x-ms-office365-filtering-correlation-id: efd32984-9a88-4eaa-e6b1-08deaff2b26b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ssR2u7yREYeU8Gnmqeu22FfKrAAcmXrxpzgrcZTfrwlLAWqIKukVl4PlgEmVzpOC2qfddsi9PpvmAxtjMf20HY+VjRg88kTDaoNT4pO/gZbuDZxksaOaIsgiPqYXjjfP/LIPpXZ/5dkIs0WZfyoV2wLpAeCdSMTd9/gmazevtWWPE2Ay0yjIOjCWQ9lo0r52+hyaxkPGnj2/Fvc+qSKSs/Zqy8+pOg7uto04dG9v4pEzNvHDTZggeQQcSyeZBIlm7urS2mPGl8TVHT60ZztQmV57d6Elm4XsBmUfsJeEWCrB0YrjoACaqjAF/ToXBUJfKQnX/8+2TQ7kbBRfniiZcJynPwZMC7Vokr0vcJjO5IXe+H162QVrBkhQdnLv/4YXwsUkcuKMyvViPtCPjPnoPKdom7gD+eDib8Pzj2hhBWvNkCnQnwyuaqiRaHhcPVLC+lkRRQ8FRMeIIjSlFSY/fI0flUgjNkuR4lOTQ9lSbeV8+isUzAuONwpyQUAmorqBUwBf9gyfXR4ILhihJTuKfE3tr3peCUxLxiH6oKgikgxikdRo6gZpx+D6n4yEAlQuXrJTI/n6aeF087fkGmHxW8CjPxMWa9bIsyIGcgZR/xubSLJM+msqoHzZaYh3w1rAvzqmwPjeQf2ioVqibTHldIbb7ft+MUZMbPyZTYSw01HuseejdMwWBPLGZHJdXdBeRksdsIpNvFBmTw5rOVafFeGm3/JejK7EGyzUlN85QBbIhRkOwDrP2BVIMWZQvTPf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wXbyBFNdZJFmBhq5hdg9jjyVo2JkvJakrUAq83WSxXTFEc/ePdcogbt/XK?=
 =?iso-8859-1?Q?0zcsDCtdyPKs+IamVX5myl4s183rN3RimM3DjHRmCGdNzXceUf4Xd45Plg?=
 =?iso-8859-1?Q?aPxHPQ7+oCaQf0iT+6gcDFe0ZAgSXDf0uYaJOBFJHXs+ZVbE/oaKDuwA32?=
 =?iso-8859-1?Q?rWBaIvthtyZRZF7dpgQzn9n8410h9lPIOUnaRYjx9GQpqroU04//+JHYtz?=
 =?iso-8859-1?Q?bQVvtyEf/2TUug07aCLBRESEUZQwRW5Psc+/mpOneErL/gAtiHC6PwNPx/?=
 =?iso-8859-1?Q?RNWZaYDstsa03J6Z2whqfMseresDP21L6/H5f7U2GH662xt97c+oW00eTP?=
 =?iso-8859-1?Q?C89NkRfWx0FqvD0pnNw/gLd2tJvT/dnG1rXEVlwhqlp4MWeH6uaUhETMAg?=
 =?iso-8859-1?Q?2dDoa3PwlAVkikzcF5QNTyIx/0u3XDvV8bUgHvHzbdAo7/EF53ngK9ki1G?=
 =?iso-8859-1?Q?Z0U8NcTKwXkTnXgOF2QOZphbiK8yhlT0vCsILukHYQmUdh2XiFjSOi43LQ?=
 =?iso-8859-1?Q?cj6VuERNub9gHM4t+lJsbP26tctfVBma6zmY2pm8JH6UhcUbAKBD6SAgzI?=
 =?iso-8859-1?Q?fz+J/02jfCXxTV+NwFyNKiSjrjJbRgE9rD/QjMeBuUkW2FtPJSXE4c9aWp?=
 =?iso-8859-1?Q?R+uh59FMDOx/YOjNRsz7vfgJ6faAi7SLloXCQttVt3KAZ67jdXaQ5H9gXR?=
 =?iso-8859-1?Q?rk2QXWn7nKisodb5QGP1yeNVWZDgiesK48EzSoDryQQmFhJZRgv30H/E9D?=
 =?iso-8859-1?Q?8YWNIHq1ditTJx8eQmT9dhylle3NwmwyYaXw1ZvmEe41lk3h2Tav1GXMlJ?=
 =?iso-8859-1?Q?dMvvDHxpvqw0jX/zDcJibWIxTIJt2jqBVxr3YaqufkcGL9nycedIWxJUji?=
 =?iso-8859-1?Q?5r121tqJSWfQaTTTg453jaQTzeIM2jZ8etEGBUj4CE+TEBd/UP0S0ln364?=
 =?iso-8859-1?Q?50sUALK+pIrBnk4iX3myKrPmN4ZjNHmhqETA+p0ukMMsWekiTp5eB66BnJ?=
 =?iso-8859-1?Q?wFV86FbiX3v+r0CMLZpAx0ubiKlEBn3gyykQF/i1VM+VAm+yRoH0n2nOat?=
 =?iso-8859-1?Q?cnFAAAAi6t2GK64LKbjT5R/Vi4+NmPoAaTS6C8GKfGDIPyKz1efiiBghzg?=
 =?iso-8859-1?Q?UYN2nBWooJHYm7kNlsb1Dltrws25XnDcoZytOMnCvPTloJnVdAQi+BtKfb?=
 =?iso-8859-1?Q?GFuNmJOPEOW1URFbeoJoVfQinXFzcemXBHRWg3JUsj6x7puew6UkpNybCu?=
 =?iso-8859-1?Q?s3KJxOx4CVXvpDXiKotnCZFHPCZqByaVX8Gd/LE7LomVEDZWnKkCf4psh1?=
 =?iso-8859-1?Q?aIJzahAyJInjfnp8pIV6KFIfyagVQy6W2GBt6L+/luheawlKypJx/gmQJS?=
 =?iso-8859-1?Q?LnhwDHtsp0agrPi/wojqN5h5tmuzEYKSiagXSgEE/+j3vVtk7d5736JvGd?=
 =?iso-8859-1?Q?zyFbfEf3YExT9IvXsc9KYyLrag6jNBExrh9lKbxKtPQf6dEbNv5V1C6zJ8?=
 =?iso-8859-1?Q?TYHXpObTFQs7KUgsGxOs3V99F0B6Xmk0tfyNyY3GeRyRw0ArIGjAzLBctX?=
 =?iso-8859-1?Q?DnHbTkAEJf1sMPdgfv3Hh3PFw5aHnLa3XmZboN5/uTCy1dyek7QJAgXXna?=
 =?iso-8859-1?Q?wTVpUgvrGCNKbd39Yi/2eRHSzExGIyUd6CM92VYQirOv31mkOVOZPlQnGV?=
 =?iso-8859-1?Q?es5SnJFJyau+0aANX1XzXFa6oalt4sBu/KAVQO/zR9SrqUiuslC8AlzDxP?=
 =?iso-8859-1?Q?xUFbeIDcWu1nqCg4aP/5zNklx2/Atw4kKrNA1/jrdV6/2GZ7JrrUxbyTxz?=
 =?iso-8859-1?Q?dE0pz1sxdQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a0+XUMSWiFEqkpZRLIDWMpjDBUMAoM8t5ygl7JV/24XGfbdbzn005EtRQ5v7aqPdbgSQzesd2fA+Z6F50wZ4ImaJx2ochBGAGqopyFCcGLEmqsVWoPmxsIJFfmiMZXNyU01XUfbpbPOqI64mYDucVgG72/huh/8rkvpkmyQSx0X8l8vKRK/J1X8rAoYUEYioxsZwZI4ZM5Ti/sDYDWPL6B8b7mxlJGybxWta70tA8TXENzL/lbWCyk06ixzhkpHIsclKhczM0VWvwkwmb7rTd1NRHX9XSD8AoHmtfUlAY6ZDdMSar3oJJpe7OjsGM2C9QLZtWcFRaPsyVboV3E2O/g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd32984-9a88-4eaa-e6b1-08deaff2b26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:50:04.2829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToVaXc7nz1d5ZFakQu8yGfGSCNI+iLShYO0KTVgFWTZRnDUDh1yhPoeC2garUWN+z2mWJrKM5C3F6WOYsNuZdxLeVYxsSm+dXVkU0zQ9qB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5225
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

In the do_hash_operation, the code may be returned earlier because=0A=
hash_prepare_sg_iov or hash_prepare_direct_iov may return a failure.=0A=
When this condition is happened, current code flow doesn't go through=0A=
later code segments. Finally, it causes the mapped address isn't=0A=
unmapped properly.=0A=
=0A=
This change unmaps any mapped addresses when an error occurs,=0A=
preventing a resource leak.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------=0A=
 1 file changed, 45 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 0504d61cbf..a322905cb3 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -218,8 +218,19 @@ static bool hash_accumulate_len(AspeedHACEState *s, hw=
addr plen)=0A=
     return true;=0A=
 }=0A=
 =0A=
+static void hash_iov_unmap(AspeedHACEState *s, struct iovec *iov,=0A=
+                           hwaddr *mapped_lens, int iov_count)=0A=
+{=0A=
+    for (; iov_count > 0; iov_count--) {=0A=
+        address_space_unmap(&s->dram_as, iov[iov_count - 1].iov_base,=0A=
+                            mapped_lens[iov_count - 1], false,=0A=
+                            mapped_lens[iov_count - 1]);=0A=
+    }=0A=
+}=0A=
+=0A=
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,=
=0A=
-                                   bool acc_mode, bool *acc_final_request)=
=0A=
+                                   bool acc_mode, bool *acc_final_request,=
=0A=
+                                   hwaddr *mapped_lens)=0A=
 {=0A=
     uint32_t total_msg_len;=0A=
     uint32_t pad_offset;=0A=
@@ -243,9 +254,11 @@ static int hash_prepare_direct_iov(AspeedHACEState *s,=
 struct iovec *iov,=0A=
 =0A=
     iov[0].iov_base =3D haddr;=0A=
     iov_idx =3D 1;=0A=
+    mapped_lens[0] =3D plen;=0A=
 =0A=
     if (acc_mode) {=0A=
         if (!hash_accumulate_len(s, plen)) {=0A=
+            hash_iov_unmap(s, iov, mapped_lens, 1);=0A=
             return -1;=0A=
         }=0A=
 =0A=
@@ -265,7 +278,8 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, =
struct iovec *iov,=0A=
 }=0A=
 =0A=
 static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,=0A=
-                               bool acc_mode, bool *acc_final_request)=0A=
+                               bool acc_mode, bool *acc_final_request,=0A=
+                               hwaddr *mapped_lens)=0A=
 {=0A=
     uint32_t total_msg_len;=0A=
     uint32_t pad_offset;=0A=
@@ -275,6 +289,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, stru=
ct iovec *iov,=0A=
     int iov_idx;=0A=
     hwaddr plen;=0A=
     void *haddr;=0A=
+    int iov_mapped =3D 0;=0A=
 =0A=
     src =3D hash_get_source_addr(s);=0A=
     for (iov_idx =3D 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {=0A=
@@ -282,7 +297,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, stru=
ct iovec *iov,=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
                           "%s: Failed to set end of sg list marker\n",=0A=
                           __func__);=0A=
-            return -1;=0A=
+            goto fail;=0A=
         }=0A=
 =0A=
         len =3D address_space_ldl_le(&s->dram_as, src,=0A=
@@ -307,15 +322,17 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, st=
ruct iovec *iov,=0A=
                           "%s: Unable to map address, sg_addr=3D0x%x, "=0A=
                           "plen=3D0x%" HWADDR_PRIx "\n",=0A=
                           __func__, sg_addr, plen);=0A=
-            return -1;=0A=
+            goto fail;=0A=
         }=0A=
 =0A=
         src +=3D SG_LIST_ENTRY_SIZE;=0A=
 =0A=
         iov[iov_idx].iov_base =3D haddr;=0A=
+        iov_mapped =3D iov_idx + 1;=0A=
+        mapped_lens[iov_idx] =3D plen;=0A=
         if (acc_mode) {=0A=
             if (!hash_accumulate_len(s, plen)) {=0A=
-                return -1;=0A=
+                goto fail;=0A=
             }=0A=
 =0A=
             if (has_padding(s, &iov[iov_idx], plen, &total_msg_len,=0A=
@@ -332,6 +349,10 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, str=
uct iovec *iov,=0A=
     }=0A=
 =0A=
     return iov_idx;=0A=
+=0A=
+fail:=0A=
+    hash_iov_unmap(s, iov, mapped_lens, iov_mapped);=0A=
+    return -1;=0A=
 }=0A=
 =0A=
 static uint64_t hash_get_digest_addr(AspeedHACEState *s)=0A=
@@ -350,6 +371,7 @@ static uint64_t hash_get_digest_addr(AspeedHACEState *s=
)=0A=
 static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,=0A=
                                             struct iovec *iov,=0A=
                                             int iov_idx,=0A=
+                                            hwaddr *mapped_lens,=0A=
                                             uint8_t *digest_buf,=0A=
                                             size_t digest_len)=0A=
 {=0A=
@@ -369,15 +391,12 @@ static void hash_write_digest_and_unmap_iov(AspeedHAC=
EState *s,=0A=
         hace_hexdump("digest", (char *)digest_buf, digest_len);=0A=
     }=0A=
 =0A=
-    for (; iov_idx > 0; iov_idx--) {=0A=
-        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,=0A=
-                            iov[iov_idx - 1].iov_len, false,=0A=
-                            iov[iov_idx - 1].iov_len);=0A=
-    }=0A=
+    hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
 }=0A=
 =0A=
 static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,=0A=
-                                      struct iovec *iov, int iov_idx)=0A=
+                                      struct iovec *iov, int iov_idx,=0A=
+                                      hwaddr *mapped_lens)=0A=
 {=0A=
     g_autofree uint8_t *digest_buf =3D NULL;=0A=
     Error *local_err =3D NULL;=0A=
@@ -389,15 +408,17 @@ static void hash_execute_non_acc_mode(AspeedHACEState=
 *s, int algo,=0A=
                       "%s: qcrypto hash bytesv failed : %s",=0A=
                       __func__, error_get_pretty(local_err));=0A=
         error_free(local_err);=0A=
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
         return;=0A=
     }=0A=
 =0A=
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_le=
n);=0A=
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,=0A=
+                                    digest_buf, digest_len);=0A=
 }=0A=
 =0A=
 static void hash_execute_acc_mode(AspeedHACEState *s, int algo,=0A=
                                   struct iovec *iov, int iov_idx,=0A=
-                                  bool final_request)=0A=
+                                  bool final_request, hwaddr *mapped_lens)=
=0A=
 {=0A=
     g_autofree uint8_t *digest_buf =3D NULL;=0A=
     Error *local_err =3D NULL;=0A=
@@ -411,6 +432,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, i=
nt algo,=0A=
             qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new failed : =
%s",=0A=
                           __func__, error_get_pretty(local_err));=0A=
             error_free(local_err);=0A=
+            hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
             return;=0A=
         }=0A=
     }=0A=
@@ -419,6 +441,7 @@ static void hash_execute_acc_mode(AspeedHACEState *s, i=
nt algo,=0A=
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev failed : =
%s",=0A=
                       __func__, error_get_pretty(local_err));=0A=
         error_free(local_err);=0A=
+        hash_iov_unmap(s, iov, mapped_lens, iov_idx);=0A=
         return;=0A=
     }=0A=
 =0A=
@@ -438,22 +461,25 @@ static void hash_execute_acc_mode(AspeedHACEState *s,=
 int algo,=0A=
         s->total_req_len =3D 0;=0A=
     }=0A=
 =0A=
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_le=
n);=0A=
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,=0A=
+                                    digest_buf, digest_len);=0A=
 }=0A=
 =0A=
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,=
=0A=
                               bool acc_mode)=0A=
 {=0A=
     QEMU_UNINITIALIZED struct iovec iov[ASPEED_HACE_MAX_SG];=0A=
+    hwaddr mapped_lens[ASPEED_HACE_MAX_SG] =3D { 0 };=0A=
     bool acc_final_request =3D false;=0A=
     int iov_idx =3D -1;=0A=
 =0A=
     /* Prepares the iov for hashing operations based on the selected mode =
*/=0A=
     if (sg_mode) {=0A=
-        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_reque=
st);=0A=
+        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode, &acc_final_reque=
st,=0A=
+                                      mapped_lens);=0A=
     } else {=0A=
         iov_idx =3D hash_prepare_direct_iov(s, iov, acc_mode,=0A=
-                                          &acc_final_request);=0A=
+                                          &acc_final_request, mapped_lens)=
;=0A=
     }=0A=
 =0A=
     if (iov_idx <=3D 0) {=0A=
@@ -468,9 +494,10 @@ static void do_hash_operation(AspeedHACEState *s, int =
algo, bool sg_mode,=0A=
 =0A=
     /* Executes the hash operation */=0A=
     if (acc_mode) {=0A=
-        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);=
=0A=
+        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request,=0A=
+                              mapped_lens);=0A=
     } else {=0A=
-        hash_execute_non_acc_mode(s, algo, iov, iov_idx);=0A=
+        hash_execute_non_acc_mode(s, algo, iov, iov_idx, mapped_lens);=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

