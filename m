Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23E4C43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNb-0003BW-JK; Tue, 14 Jul 2026 23:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNV-00038v-Gw; Tue, 14 Jul 2026 23:33:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNU-0000rT-2g; Tue, 14 Jul 2026 23:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0BsNTPVg+rRsbulzzlYHIXGssjubJl1zY3JbCQtM501wTlxwyYL7Wyc7OdK9/SX0Bfq3I6BILoO2UT3Xn6g5OFcYKZHM3P67kgfV9p7D3Djzkfk6l3MryYpluSSuZqV2gxLMSv7A+H55qKaSclVduI7mCpC4S/WOA5HK8Bd1/FCC8bdJQPql0pYhb0MWgDPTCPAzNP3O5od77Wad0DxsF1fIi9QfY0EdTztw40mqaPgtlNFRORt5TbmBgXVKow6mYHJy/hLT57Maiq1hEpOLxdFCffdmAXvtRioidjVrlSNSWMC3D7hjBctx83FZWn2exD51DfIWZJzpstdKYZnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiBMPfR+/nA0oYRK3cGDT/Tk1KXdv8OvrXutOsxLIDA=;
 b=B6jbtKr8Gr1ZdnfEIRav8WXkBcPLAKKb432vMerpqt2w4Py5rzCNw/g+k9daYoBVQi5xCkvURPMCjbUxzwD28yxCh3C00+yWvIu8gn5loMv1TFUJNzoaSQaKQ/qacsT3OM7rynSup/WF1jx7J7Tz9KIiXHn/LZhc7R8j7kyTTr/vJ3k8Z+k43xwTMubQsCqOSflPOfi9YWxGuHHWfN4hMbM5im0vOPKwpWLSewafnz7RDqmevMKLpPVs2AUjFSRkL0BjM3nzh/VZFhqpkdIHH7QXoe2raZ9G2WwJfayBE+Ww7MDVfrrkVQyfxC5ma1PvMVKzVFGOZLNCR8aSnDiKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiBMPfR+/nA0oYRK3cGDT/Tk1KXdv8OvrXutOsxLIDA=;
 b=M6jSgesNXhmrxPWVP9t4UKMOiVqfFlU6VJ1M4SwCJs9QMQXIZ4Gjpi18cyHwJ2cwjX1YXNTCFkYyKXmHXQjlTiai1drBapTvZzwaC2AmB5P9Q6IxVtYdcrUH8KovHhC5fZHegLCX+DrwMMP6AT3CKWIyXQkr8ODtpFNRkJKDeFOED0p5yH9vtF8S4jPAQtRiCgcycW8El+hdUZwiT2TSyEZdeTP+Z3wysnewm+/FOMbMv1d8jV1I/zKFg4rMa/F51Cf/+a3y4dqG4D/bHNCzO91sSSbPm0WrPLF24QY8NYxyB3Q9swDJY0WIPgiDyEalmMUNR4wIzeMT4jWKKqC77w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8766.apcprd06.prod.outlook.com (2603:1096:405:3cd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 03:33:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 15/17] hw/misc/aspeed_hace: Enable the crypto command on
 the AST2700
Thread-Topic: [PATCH v2 15/17] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Index: AQHdFAq451sXbKwydUaGS2nMLe3TjQ==
Date: Wed, 15 Jul 2026 03:33:37 +0000
Message-ID: <20260715033311.1648424-16-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8766:EE_
x-ms-office365-filtering-correlation-id: 952367f4-a8d5-4e27-ce88-08dee221db76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: /UTAvoOZBUPFwsVKC2CWC6ZXRLhpUCBFecDmx815hYtdi7eYPt+pFvZOiOukUv8IPYjXZ6x7Haonw+nTVkLUBoA1UV7FkMvCJzekAyp44doi+/MmbCMH2LBBthygMFr4u2+EmQs6sciaQoqZ71uGnQwEMR4VD038wpwrpsoWNGiATSG3hD1lUPjhoa1CdKgsxvdmum96DHVfJc12ZsYRJbMSozQmLROEqTYo3uzZJ/uCJgBLc5OwPgS/7Y8PRFAWxHA+ZSKqxsNaYf6iOuj/IZhYeHB89s+n/6uWARwumYfZUBhpRRzssrltM0tiDI1hEsXTSY+Ryij6MxYUkDenyBtjJ8C3kC6DA+eLxkD2hNwWDPrhUttl9lAtnXzAGZ9JQMWxsobZgSk8wN8OLbxLiUMvsT4zW6vX0shPCDp9+bniohdogc9w5eF0jx4PNtCI8UPHA5PuZBaZmcteUsMSyfgdqCp1avH4rUzCp9tis9wSfXJ2RHaeH6nSbuqByFyv1MFcsESIsO8kEnqZKYfMx1QoNUR7kOkQcBe3h1mAvHlxJuUE3qafo70NnT2koOyWWXHKC01MgGsiR3vIZ42eymU91OxOy1t/K1hY517CruvVNEaLn/ooyGDu1C6/Ixd9Iqxnf6tpR9kW3Rvu4dY68PfI1kaKrRg7nvUxlmADh4cxhPdpQa5pFvZxwocT9CwtXtQqTZlgUEMTClrT6KxQt6H/V9cEXtxEKLCgLjdmwkqbsgX0DrfYfgDxM6wXsxJN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wrZdfN8X7aopWb8yG7b1Pzvqx+FcvWgR+5+sDG3t4BKGFuQ46s5s7L2CTx?=
 =?iso-8859-1?Q?14B9KT/Nv1SS3pOfo4nuGUL+uHFJTQ1WQacVchpv57vanmwEnPfqCZEMJu?=
 =?iso-8859-1?Q?cU35AQTS/5nO3lIYZ+Vu3PR5qG1KCZV1bBX/dZBnLyb5Ir9/Zg1YG4AlcM?=
 =?iso-8859-1?Q?Pn1ValqxIjtdeOFfUog9qkVx/Uy21iyMsUFu94I7ZSCNnUjsAQZUf2VNKg?=
 =?iso-8859-1?Q?d7p/lQiJKWmc8YeryGlPm/P2uUtbCMeLlcZ2OBFx99UJJKbyPh2NpK3tV5?=
 =?iso-8859-1?Q?4adAWVFNlZCsUDC9HBRXz5+09XHo8vVtph9C3fK/9esBPlkxUEInzlFSke?=
 =?iso-8859-1?Q?exYmCe30/m+8iJndoycqaEYY3PZtDd+NEE7ZwqLRRqvgDBK7yBS9Bhig+z?=
 =?iso-8859-1?Q?40eMmqyVZgj1JuOFhVUbASzP7LSLHtH/4mIlykKc++ZZ81p2kHb1Gr7SI/?=
 =?iso-8859-1?Q?Hq/PEk3gj3FZ8SARTBs6L64dM++Pkmjx1r7wUM4k16aMlNGaWTQyuPYgPb?=
 =?iso-8859-1?Q?mJNKTgx4Rri4scvfIa+yKhaxbFkUlrtO00Tj4zJyI/ScWfkSkboXPtKs2l?=
 =?iso-8859-1?Q?NzLY8dV9VNgO0K8DaMfhNuDJu68/JfKQol0H9qUzO6qUnh+mO/Ed7kbyNc?=
 =?iso-8859-1?Q?d9ufvlVIxVh7j0zMcQ1VQzcY8xHFA1xgLIS3BXwG2DflEbbG2fVpj3AKiT?=
 =?iso-8859-1?Q?EXJtX2TSGpk8Usc1SmWpJKZ0GE4FiR+F37x2O6R4snTC/wGdFVOZ25cEvF?=
 =?iso-8859-1?Q?rVsGORY4QxEmxbOdHPnmaRj1Oz3ap7s24Y3VVw++BxpQYCb9s9W5RpOz81?=
 =?iso-8859-1?Q?9CdbtJ/VMMjM0CZjKCn/Y6QLcgaYAIIMzVRMd9U+8JlS71RvwPynQ2JckX?=
 =?iso-8859-1?Q?VT3Utkxc6sGhOAEeTQDRgkDAfW566cm4UTH5zp37ngL1n8yynn9aX9bal+?=
 =?iso-8859-1?Q?iqyVt2CMqQ/gLo2jSZ6v1mpBRb6SvEDIn3fpUiIISdxh1OrB99rSPUsUUm?=
 =?iso-8859-1?Q?nMFL/4d6T6R9veMCkJuoBNMga6Ediklyat3OKCiFncBHatCCJepvcso27o?=
 =?iso-8859-1?Q?5lGjKXyK7zSYgiP2vfhJ+5rKennf5U3n9k5gt3EJFcL938zt1m8O4roVil?=
 =?iso-8859-1?Q?l46i1PsZsVQlpFSWWMn/vo2C28jwGZZ5FQVfORDaCmLNW6j+7w5pSswQCg?=
 =?iso-8859-1?Q?UQjt/AtQF4D6SpqsFjGj8Gm7fP4nujsICjDV1gy6yITivqs1vs7uWpuLQv?=
 =?iso-8859-1?Q?NFuCgjoR0PTJEVUvjwSa7vJzlxfm3qV2UGjCt4Cc9A7LDJCMZBwj09YbPK?=
 =?iso-8859-1?Q?aSNTLev5FnXkZagz8yjzObbXmIUI1BUKu7RriNmWydy8PCPSLDp/d9J0is?=
 =?iso-8859-1?Q?j+VM8pT7FnzwQyicl9cZ5mgHbV7ZqlokgqvomiCRSz6R5LQkTGayN4UcIQ?=
 =?iso-8859-1?Q?lgwcF+3Mkj4sOL161BoSw+t2Y8rDUelBL+xG+i/JRYBjvwr77y7C4I3PS7?=
 =?iso-8859-1?Q?fH7TT0BuGxU0raDkwbb4vgPmwnT6Y1O1GGuiN5uJKggox4tgoz4BKTr6da?=
 =?iso-8859-1?Q?QYW4PKhW6kVrfRNo8iKuPL7y5OHMtimu6rhF6y1LjYn8sgAeqrJAXxN0H2?=
 =?iso-8859-1?Q?JOn9IzFFeo9CnIfcHzECteha5S8UGkYOGjxFtD4D1soaT9qSjKaN344lZB?=
 =?iso-8859-1?Q?E/qor7VRejkoFtwtDzJZ+YC/bvXzFUeG7Nn7/I3uXN/3JwK6hOTyUtPWcs?=
 =?iso-8859-1?Q?2aFcQCg3sEOCbfs14WYVxreU1k30sA3nS2zBBLvnYFMLs6UaGhX1SRKzAI?=
 =?iso-8859-1?Q?phU6x8ulIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W03tP/UryxUjNuXUmK9mu0CRoG4o9ftna65fBRH6Iktyo4+k+hPETznzaW1iG7NRJ3Ui90lsZfElLB5tY1ElN3gx2hDhLAKh5lQGu3yrqj+BRfIb3FGWlziRWIUhxZ9DJE4JbcAcrFvj42Bn1Cvaah1BjmLsZJymE/fYQfPUYwPfln/2Jn1O0YZVd2Z/Tz6MYRcm/marm4edyGEQC/wORejaH1GQ4//KVBqM4J90PG9IjbnLDjZ0CYSsVL0lIKhgGSmzFYJQh2tNvETzjWeTlTgn1cUTPp4D+eWVXW5buSrf6ScfwNqqi7vr+JwnM84kIo6p9kcpdXjiLcwQYDsF3w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952367f4-a8d5-4e27-ce88-08dee221db76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:37.6588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sf3nDTCN0dvTDsxH5Fip+w0pD+V53Ricer/TWAYBLgLB0qatLBcoqS8aTTEEjUP6mGJ5LoY3teVT+ZZc8qRAgWKBj3FFJkTJomPzJcjb9is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8766
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

With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place,=0A=
the AST2700 crypto engine is now fully modelled. Drop its temporary=0A=
interrupt-only workaround so the crypto command runs for real, like the=0A=
other HACE variants.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_hace.h |  1 -=0A=
 hw/misc/aspeed_hace.c         | 15 +--------------=0A=
 2 files changed, 1 insertion(+), 15 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h=
=0A=
index b5416b0cb5..9b0e7683fa 100644=0A=
--- a/include/hw/misc/aspeed_hace.h=0A=
+++ b/include/hw/misc/aspeed_hace.h=0A=
@@ -49,7 +49,6 @@ struct AspeedHACEClass {=0A=
     uint32_t key_mask;=0A=
     uint32_t hash_mask;=0A=
     uint64_t nr_regs;=0A=
-    bool raise_crypt_interrupt_workaround;=0A=
     uint32_t src_hi_mask;=0A=
     uint32_t dest_hi_mask;=0A=
     uint32_t key_hi_mask;=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 927759b48f..90d43c0676 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -1005,14 +1005,7 @@ static void aspeed_hace_write(void *opaque, hwaddr a=
ddr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        /*=0A=
-         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
-         * added later; until then it keeps the temporary workaround of on=
ly=0A=
-         * raising the completion interrupt without running the command.=
=0A=
-         */=0A=
-        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
-            do_crypt_operation(s, data);=0A=
-        }=0A=
+        do_crypt_operation(s, data);=0A=
 =0A=
         /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
         s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
@@ -1216,12 +1209,6 @@ static void aspeed_ast2700_hace_class_init(ObjectCla=
ss *klass, const void *data)=0A=
     ahc->dest_hi_mask =3D 0x00000003;=0A=
     ahc->key_hi_mask =3D 0x00000003;=0A=
 =0A=
-    /*=0A=
-     * Currently, it does not support the CRYPT command. Instead, it only=
=0A=
-     * sends an interrupt to notify the firmware that the crypt command=0A=
-     * has completed. It is a temporary workaround.=0A=
-     */=0A=
-    ahc->raise_crypt_interrupt_workaround =3D true;=0A=
     ahc->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

