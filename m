Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E84CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESX-0001la-PF; Thu, 15 Oct 2026 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESU-0001jg-KO; Thu, 15 Oct 2026 01:56:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHEST-0003Cs-3w; Thu, 15 Oct 2026 01:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhKnxP6YLGKfDX1eN20/cWhQQF9UQ+hha6CPX1CRZr/ZDYFjkdkv4CymVFPR0dxiM28dzdtyKzHvbHzr9wpH2wR09m/3YUFbBLSZm8eZaSNA6SnR7wewzae4aJKYoRZt7YGGtKw8bQpo91XkhhEbgzEPdzO12AuX6Y8oMN4XdegKzib8nq1kUMpQdiv5ObkRu2TFDveIFR9cu2uemL9S0OiH7dJ+ERmXjyZBCK6Fl/dXUX2u43dkmpwrJz8+Vn5e1o1iYXerKiEI3xlQ4SwYUirXRa2ecfIPrQfDWmey4HqzceabUqhFMysH8Xj+BiJePw8dPQkkcE/IsasSu5uA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYJDZ7gK/D9WcCW9rhczK+VHbhP0V3qozQjMQoCsACc=;
 b=Lo+9sWXUNW3+AQl1kDGxyQTwkmSTrnasjLkbFwCRBaqQ1xz8pCb/rjEbiIZGWX15wcbkGqFEPPmtENeuwnUh+xrqBcRYMLPwAOt9ZRyaxZOcpYLXs2J371DeZQ5FdFRAUsrn5dhE5dbwsHdATZXt7eWu1KrJR+OiO163fKbF0b7nYPKMRPytnOxLHrwewkazeGJtMY9+qwRGWX4mn2S/XNds3BY/gLReoNs9VqMB5CobMMAeo63fV8kp7OUXGG/vn6jHoJCrBscztal/50jWgsKTQ3HoSqxtYxoMZ9L8hfoTZiXuNwP6d0im6KbQsgMI1sSsuw0eKoSpy7uexUaZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYJDZ7gK/D9WcCW9rhczK+VHbhP0V3qozQjMQoCsACc=;
 b=bvapOTMO3a1kh1Ek4da7ajTI2fmiX4OF8PZ8NXotLqGnRzwjjEbsoHH7zAnL4+O8s/w4W4R28N0CA0NQt3//GWdaNieBmYD6MOWC4qiHBAOmGSmYfu18/0ehSD2jpRI/jrgodx7eJey54SKawa0Ze9x4bRTw6cDCIi0Qf2pkUE/O+GOiFUEzyIZt3zhwbIq/keA94TyOqi+g/BdvsY9Il1tJV115iREssPwwwQQCOdqG53kFk76mS5ETVT7t2kauHQevmtcOystPAT8Xcgl0eyrzq+hptZ3W6wFG+lYa5Yn8bWbRxzEyQKmXiaukOnJrU2qIwrxnrx5XL2I8IAO5JQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB5820.apcprd06.prod.outlook.com (2603:1096:301:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 05:56:45 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/14] hw/ssi/aspeed_smc: Fix AST2700 segment end address
 decoding
Thread-Topic: [PATCH v1 01/14] hw/ssi/aspeed_smc: Fix AST2700 segment end
 address decoding
Thread-Index: AQHdXGn1I+GLxGB7t0ivTTYc6lEc3Q==
Date: Thu, 15 Oct 2026 05:56:44 +0000
Message-ID: <20261015055642.106204-2-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB5820:EE_
x-ms-office365-filtering-correlation-id: 1504ad80-1366-487a-725b-08df2a8117ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|22082099003|10067099003|18002099003|38070700021|261009223027099003|921020|56012099006;
x-microsoft-antispam-message-info: R6cDCCZukl8srO3kzlvWBJPDR6RcPiDtLEtqSadHod75pB2dMeQXbVt9BEnTWaiwpYZAo/ld89yUB36LZ9LIn3So9s+nU8ztrC+Bb95HMTK76DbEW1uLrDdXPggU2Aul1fLFHVce6RykXH39qcHKcMFtNmL+VqzcDyyXEzPUtto9CqDKvKvq8XJoiQrY7/vVmKwRBvMLIXA+mENt0bBKJCjYQzMUNSjyrQjqf9d7+VyXjgvD4mbUyZ5KDhPMBtUK5/hQT2+pcAKkZfKZJj0XJaahvXL1IIUO5vqaVbWm+2reRZQTCGgs77OlzVpSn7fv6qejiDR8MChOChMwsBBz3c7iSxzH0zW/r3SDCRVNztDVRpmgjddyN32+KQQQCOQynFU4yxlBVmgO1zKA9Umv7YppnTKRI3S9Em3y8oYHDrDugCcMykXjz8fRL1ayuVRt7OJeoYQrBe4mirfQrbicUhmKECj747qpGdMWLmyhji+fw626fofE9eb7inQOg6K8SW7FCfIaXfoTYdFh/LsxDY3CE6bSkQtCbDgSOUr2Ut43Zdt8X/pPMGX+777CByfoEpPzvCwAyGhOt1qoMhf615rV8GCVneG4ckMo7QlWczMenKr0kUfq9uBlURJzxHECm+8UJZV/5B5hSkX+LZee1fnWixes4KEMNF6K18GGxkig6YWf4pQWJfcy5WRSC7sl9Jn2smCiH9GpkCjmDFj5P2JrMz6iA/FXBidnurkqolreZV/AwSbQlzFIQCdHsevr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(38070700021)(261009223027099003)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?alvGni34HD2NrX+++tc++QChO+Wr0VXfiCBZpfG3R88A1LwrO/V0oPhgN6?=
 =?iso-8859-1?Q?7WvoiwqlcHPdVKNWuwY3XJnjZHcFlHbZ62O7clFVFfimyF/HGyhZqEJ8PA?=
 =?iso-8859-1?Q?LoS4+mgAjJ5WoCBPA5QSFFnDirKvm1A0XYJZacK6MMdH70aoxFONSiUXi0?=
 =?iso-8859-1?Q?wBi9R4Ws+vi9F456UX4827MZ2nJTiNWpAurM4GuGbEabszqSW1yiOtcd9F?=
 =?iso-8859-1?Q?1XvhihcNNAKdtONhA/YvoV20pjCVjHI7QZL8FBLMDqB0nZ481xo0MF7OlT?=
 =?iso-8859-1?Q?pDWyigjYQvCQnf/Pafk8faRSTjQ0h0RG1XPMWE3Oeg8CT3GTO0dZGG4bQ6?=
 =?iso-8859-1?Q?urVJiuhAQarcE3nQVXbMnlzu/9MO+8/HxxlHCC0wmN/vWu7ux5WMS32YtN?=
 =?iso-8859-1?Q?FNGwaiJlfCINQZ3tr4WR9TzGu31BTcGL2QtpvKk4bKAYztNhruWm5oGeeJ?=
 =?iso-8859-1?Q?9oc2XgDYUoOYwL/CtpQR7X9wnp42nqYHNY3IgvA6seQnmK2hldilfjxt14?=
 =?iso-8859-1?Q?Er6oGwODVGDLIGi6RIVa6DgYxOL4YRz8zVWbfcS1mL8tF+xNnxtg2kjW8F?=
 =?iso-8859-1?Q?FB8yuo1WgT5uX0pzt+JWwNSv47MNPZJoAgFcvWJyr6dHrHCNzFNmbrd3NL?=
 =?iso-8859-1?Q?RpAPQZj5axwNfzjChPL51Jj907/lS4cY9/VwxpKiOlENPc0CAom6Vl7kiu?=
 =?iso-8859-1?Q?rLjGEScL6DaYQn2lbAHt4pR3Qex0YHzUFjTsbOKcSmbbQgk2v0MGkfni/i?=
 =?iso-8859-1?Q?SQemwNFih9rT0jx0G0Yt65J756uQU3onxLtyYRHn+aipbSg3RiS3j5fwMH?=
 =?iso-8859-1?Q?6U/PNjHFKhWzn6eOri9T39A3H1BY0sBsxdDIRi6Y/YJpDMN5cbCaQyu01K?=
 =?iso-8859-1?Q?/dH8upjfqo3FzvDZCA1u3AK1Mtg5D2D171yyNb2lvj8VjKsGSTSh6JfHlu?=
 =?iso-8859-1?Q?73hDysHLLURqrlmW+tz1+hcQp084p5a6/iPXbqbtxm2Y6lWmn/ZwXS+u/R?=
 =?iso-8859-1?Q?K8h4Pssee2jo2QC2WiSxGEIV1RfmroBFBSvrHL0Gyir9d6c/xg3QUm6XDB?=
 =?iso-8859-1?Q?d04ZFPAmG1QWuz5urB3BfVCA5xWO+1TsWkp8OegvwsNhNM4N5HBw7utsVG?=
 =?iso-8859-1?Q?151ux7LNXEWmuf7MC8VNrOH7KehU4ES+zVzV5qMkzm2IBPFirB0tz4xwQo?=
 =?iso-8859-1?Q?i2vUyDVsrZYidlbQpa3taC2qth8Iwv9c1Ck7BlBmUrDlO87TN75Iz8lhf8?=
 =?iso-8859-1?Q?cmjpLD7b1prhnZ/KGiQm/AUINVmXt3hXLWABpTVQ/67jD51Z113agUaz64?=
 =?iso-8859-1?Q?Yaa3k7CPmREX8W3zeGzz8MkRM2Giyh6dfABUA1br5EKeji3kCh5/dOeLe+?=
 =?iso-8859-1?Q?5a0s94Zgln8GFB5QE4hw321vPBTVCJCxWqC5GKsP1/NDxhv57ua3iE/gmS?=
 =?iso-8859-1?Q?lOo0x2x5df4fc1Qt/s0Rloh1wBDL98l4SHY7uYmUT4INwSx2qjP1eIpV/g?=
 =?iso-8859-1?Q?TN8j3PlelUT7x/SBAjM4sEou3L9aQ8XlYT5RgKCVkLA3BMo6knM2Mt9BAJ?=
 =?iso-8859-1?Q?UHz5HZ1hgWR1+776barlmSDYqvsZ1OyFRtUqf/Jy1z14GoF7pBorNwS5tR?=
 =?iso-8859-1?Q?auo7TGiU59dAksO90K6HQXRRh0RkgkjUzYIkHaeuSzJG/uCwOZLKq76Bja?=
 =?iso-8859-1?Q?JC6Qwb00Ap0rgg0Mx/GwfilR0Uh5thGWYIQSYPjp4C8tRzlCB8FJl2hslP?=
 =?iso-8859-1?Q?S1o3Iwtkys8hjced9LZqQTkTWBAuDd0yB5Gqs2lsFH9Gnk3UQwuAOvYA6L?=
 =?iso-8859-1?Q?XhvBQ+uOxg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TPWZvasRujeQKUX19dbo7Z32wwtaEDLzQohkoSHoDJACRTUzhZeYjnR8hYKQ1mF8qWR6XgGJsNAU4v7uqXLwGYve/3wLWv2l2yp/a300ZT+2W/IfNSJboP9cGvVKaBlX60nNUrQ/ZvmkTAXsywVnWAdJKcg4rybcXrvKEQaBW7RKw79Oh9Ao3cczYfvAzDaIeTySGlEe4ug8NojAglHfa+bR67iVjGecaDeXeEBl6y1GMognYPsUte6CbQEl6wuCNqwpGYkySeNEer2bWiht0VTbSarwBf3oUF/+XlBfPv770AMKITuJOFByugR7aZ369dgxi+to/dqXXQY4oRbShw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1504ad80-1366-487a-725b-08df2a8117ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:44.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5/MniQXLX4xuvXiIv+GRHORstX9fuHx3AJq7drQpxQHYt0ApxCTjblyH7SJHBQmrpml+fIick4LE/jXX10yumwnEVHc26EJ0gogigVlIe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5820
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

The AST2700 Address Decoding Range Registers (SPI030 - SPI03C) define=0A=
the end address as an exclusive upper bound, with a unit of 64KB:=0A=
=0A=
  StartAdr <=3D CEx < EndAdr=0A=
=0A=
When the start address equals the end address, the decoding is=0A=
disabled.=0A=
=0A=
However, aspeed_2700_smc_segment_to_reg() and=0A=
aspeed_2700_smc_reg_to_segment() treat the end address as inclusive.=0A=
=0A=
The end offset is programmed as (addr + size - 1) and an extra 64KB is=0A=
added back when decoding it. As a result, every segment is 64KB larger=0A=
than the range defined by the register and overlaps the next chip=0A=
select.=0A=
=0A=
The issue can be reproduced by booting an AST2700 ASPEED SDK image=0A=
with "-d guest_errors", which reports a lot of segment overlap errors=0A=
such as:=0A=
=0A=
  aspeed_smc_flash_set_segment: new segment for CS0 is not aligned :=0A=
    [ 0x100000000 - 0x108010000 ]=0A=
  aspeed_smc_flash_overlap: new segment CS1 [ 0x108000000 - 0x110010000 ]=
=0A=
    overlaps with CS0 [ 0x100000000 - 0x108010000 ]=0A=
=0A=
Fix the segment helpers to use an exclusive end address, so that the=0A=
decoded segments match the definition in the AST2700 datasheet.=0A=
=0A=
Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/ssi/aspeed_smc.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index bf596f7b2d..10ea9e5aa0 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -1823,7 +1823,7 @@ static uint32_t aspeed_2700_smc_segment_to_reg(const =
AspeedSMCState *s,=0A=
     }=0A=
 =0A=
     reg |=3D (seg->addr & AST2700_SEG_ADDR_MASK) >> 16; /* start offset */=
=0A=
-    reg |=3D (seg->addr + seg->size - 1) & AST2700_SEG_ADDR_MASK; /* end o=
ffset */=0A=
+    reg |=3D (seg->addr + seg->size) & AST2700_SEG_ADDR_MASK; /* end offse=
t */=0A=
     return reg;=0A=
 }=0A=
 =0A=
@@ -1836,7 +1836,7 @@ static void aspeed_2700_smc_reg_to_segment(const Aspe=
edSMCState *s,=0A=
 =0A=
     if (reg) {=0A=
         seg->addr =3D asc->flash_window_base + start_offset;=0A=
-        seg->size =3D end_offset + (64 * KiB) - start_offset;=0A=
+        seg->size =3D end_offset - start_offset;=0A=
     } else {=0A=
         seg->addr =3D asc->flash_window_base;=0A=
         seg->size =3D 0;=0A=
-- =0A=
2.53.0=0A=

