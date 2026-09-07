Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BF5C79FA8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWY-0002Tu-MY; Mon, 07 Sep 2026 05:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWW-0002S1-Q5; Mon, 07 Sep 2026 05:20:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWV-0001gr-56; Mon, 07 Sep 2026 05:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDSrzbK5tft1Vxma4pDK7vVbWXWgIp6IOuOKhiDakd9zW+6Q+4rgF2TyhihZzKXfP3gRiuopGbuBwlG6newKaotdF3BzuIY3wVm77p8tMDqz1W0qFj/4VLhJADqBw68sxD61koQAhi806pYmo5fJ+CKqiAnTA8rL2259iyvVTpela9aDEIoj84wr72VLerjSJVKgdV33cEW2U+pXuMuzsn+m4QCYGMvu4lL0IWL1bO1BsAlgvrdhvQ4njSMf8GTSyAuGUashCpyIDoRTGEfJuTTFvOEoyQpNRz836sWWP6I9HB7xghZg0tJCn7bUa3wM8aMML3Gb8fwg9/6z1Rn6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SBAtIQaGz4x2vdCpflA1+Ll7Z5cE24rs2iTGoXULKs=;
 b=gsydJuqADeQ+mEV4IteI3+nZkRa7ecy+A/YA6kigaxbbRPFHxRQuoGMwb+nLWctw8l3az3jOqcQM6IuqPNVJjpeB4L2iPqNUzydT1sulcsj4mmi+PQAv17NMXDm7x66cqmfqo3jNCDMWgoVQAfv2vDBWVp8MbZhLjS7frvo7EmYugvnP/eO8pnCXImq66nXPdTJChNtmpOrH7cJDtrTourPMFNP0exuBRHA474lm4uVW/IvlRlye3Wdcty/Uh80dnyt/aMqYjLWCyojR4EcxwtcJRb22GU0AjN4iw3QLxacjPwBqlGiooNwhWil+0N/lLOWf6KL/dsoxqmDtEeKKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SBAtIQaGz4x2vdCpflA1+Ll7Z5cE24rs2iTGoXULKs=;
 b=aH/YoyoYlYrcEg423WJd0Lfas7chM9cFtquNIzD+rvhzF6T+MhxBqe07FJ9XCjeZICLLho8bgECytDIZow49rEj5IxGlqzFN71b6bdC8E0K3oScraCsI7mKNw88qOvfHYO2hxWnx/ViZzCw1OuDCFElGi2KBYKdTmgqzeERN5wPqfrvy9XIsy6ZN0jGKbvBnGrgnVtzbdzNvhFjulDsoWS7JtuZBFubJD5kWN5g/ocZgjny5wLDPFy0H0Ky9a6MmFgRLISyrJz6j+oIjnNmPGjY9jwyaTOG/FrZrzfJTo6Qy6oXFOrmTpx9gprysIuIBoFmToc6g+UjeIHuSuTHuHQ==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:06 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/7] hw/display/vga: Allow a device to report vendor
 specific blanking
Thread-Topic: [PATCH v1 1/7] hw/display/vga: Allow a device to report vendor
 specific blanking
Thread-Index: AQHdPqoSBc5OBJ7UsU2kDrO96htROg==
Date: Mon, 7 Sep 2026 09:20:06 +0000
Message-ID: <20260907092004.2590015-2-jamin_lin@aspeedtech.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: e1cf974e-cca3-4701-66d9-08df0cc134de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: u7WS/99Mts671Zhix6QnsJLWEj2Nw7eVoVthY1otDJ2u0m4g/9KfYoQCG2H34ZMcxjO71sYkvGU5WNpZrWdedytgBCe2qk8EzaxVfmMdXdnpfOfa+c0LA8S7gKmA5O7Gzj3uoYiWG+TbC461sYI0NzINoEv/zqJFXdKNXMYWmFKaG4Nn0e/cUsRO+22wdaEgcQwyUGh5Ebdh7VypVS2mH13A2qSfClwlTm0GAqRDS/3xQp0pZsuIi4MKUwEMjpEMJl0j2Tb0Kdc4G8wgylHYviV+iUghByuZ9lkpbzOMVxqPgHtMY1gbNpzZSw5x71HpLjDsnzVZum5zhiJ3GfwDtXIeHt05f+7sPPwIB7Fr3C0F0bIs9/JH2oiRLaJNQ8RMeIpEvqyZe2YR6+GDXN69fJsFQxw1OX6uiOYAKTLmAuyXeqfM3jMGHH5zFBV4PVVJ6IIkCpNQ/KpXd7eRWjIbcpMk8XiZjw1u1dHpfEamOOem9sKhJW+nNCw7pFfC7WAh/5OzU2lgATyqdNcOndAbNAR3hdNNrGI4MEg+qH0IdWHRN2WXf2oaj5amD28q+0QDf5FfnSw/8+1lWSxxJ42e4vSN+SpXaOKNyveCZQX3N+rKRgJRi/w4zvgo2sM6gYzS7MkYk7bMHnJ54PAIxZwTQUIKxJXaPIHKvNFAzfdEc2a2lkAFGJBL1ShpVM3umM1+Bgi6Pd5PVo4CamKNyK34iJsk8nzXXmqmjxC1CxUjTc2FIhbhkl3drAflF6tbr7Hp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tUz/WpifMcRHKaBtap/ufWSZk8Ex+gMJMsa7AlQoIJVQilG6j36Jn/Gr7q?=
 =?iso-8859-1?Q?iUkESBrJQo9vNkzzLXt/8QtWn/GCnBWED3UCyeQIEC39h8EsNVLhTT1X64?=
 =?iso-8859-1?Q?ujI6bcJVIPQ+EKvQ749of8Rkwz614uOj1+tt2O55eWpmB6QDxQRaMej7Ja?=
 =?iso-8859-1?Q?wPMvdouGrj+Y30ELPNeVDDjuLA5r1hCRuYBUWla/VQZJA9YoG1vGaL3Udv?=
 =?iso-8859-1?Q?Tky9Bz6W0YGsfsLJ6lIdjbn6FKUF1BkMl5ZFQp8KJbqyDdviw+vWRxfQ37?=
 =?iso-8859-1?Q?6o1FicExjEpNxFOtJOUuCX80wpaISC7dUVLEMU84ZJgN9ytj5RLEC+9ii7?=
 =?iso-8859-1?Q?/h0rbDQcjnJZFuPBEF+rSaCrWJDFMdtig07WDM6vSn1RtrEpZVY2M8d2kt?=
 =?iso-8859-1?Q?j+j5UYdpotNDvlSOK9iOXyx5dls9AsiY7K0UbDws3UJCqi0t0Z8Gzz9FEJ?=
 =?iso-8859-1?Q?wBkwbegz4c+1PmXDNdoAhhNbxB/vw8RrBex6x6x81uQ7eMjCMagdRu0aG5?=
 =?iso-8859-1?Q?MdDFf80uQBE31QbN9lNhvOTqsMB9I8YGGCuJShF2cbxZkVjQsy+vwYHalr?=
 =?iso-8859-1?Q?0KEqHfZgpJMLeul2QwFVkOWNEURshz1GFd1N+B9U7dCefVN/m8f0QUl3oj?=
 =?iso-8859-1?Q?iNJWeoMiSIGvz+czTg31/p9OhkoRbjEvY60oGruCp+8hMeoH0RssfXrY8e?=
 =?iso-8859-1?Q?WfE5Q5z8ROklEiTPcseeAP6T6GAhrFPBYYckLMzXKkgWu4KaqbhNrbvZHZ?=
 =?iso-8859-1?Q?XwQqBU8Os9bWR9Wh4cBOmJFusPJMMDE9HYqDIrT+jRPYpImLPp1QNpRqJJ?=
 =?iso-8859-1?Q?46PKpWW5yr0blr6Olm0LhvUJqCQFrPGZa0cEszJ53RXhfWj5IyJanNgmaW?=
 =?iso-8859-1?Q?WLP6yZakW0KK9j8DCiZ81TibwxVH23EX4S7oPvLY0f1hAUCTiVcYbiCYq7?=
 =?iso-8859-1?Q?APQlt+cthlu5UdshpFIzX8V5W2TvSpmu671C0f6cPDRFdB/Pxg36XYuQ1P?=
 =?iso-8859-1?Q?1c9JmJJzOsicoM3FcfCtm6KknBaoN6CO+FtNeAELyZrtd+Ev7Y1oeywGGX?=
 =?iso-8859-1?Q?cVL87RoElwBqGvDyAG9y27JfJT1rGIq2AXLjKZ6L81ajNDGQjHYUyXp8kV?=
 =?iso-8859-1?Q?eUEh0/74BsO6+GumM+W2EAODAk8rFteru3s5e7++aCY0BeWzsM7B+L0u5k?=
 =?iso-8859-1?Q?M0jsQiF+AXFf8c0Fc8/LdTOggFJumEGqIDFAtz7hURMkmmrTXIyr5kWEKr?=
 =?iso-8859-1?Q?2VbLkOlqwKNgWsfsNEBXp4LYn/m6z1viKEVlvS2x5PInQMTjgS5C7sa0EX?=
 =?iso-8859-1?Q?yIaHsV0xj4Vu3JU3mWXubbdMAXiLiw8lSTmcKeoOAYOoT7F3JaDSVEr6ky?=
 =?iso-8859-1?Q?0UWYDeF3YJiXzSWiAnyzcb4zgI02X9rnENFKpYEJjeTGoovoXE9fUD8H6w?=
 =?iso-8859-1?Q?VjiBzz9TXHdMvjPvHDJH+y6ArqPAp7VRHLmXVAah3iI+aBTbQKE6NOpulT?=
 =?iso-8859-1?Q?gtw3paGaBQXp4ChJh8jItPdb+PAB+GQ1oi5bDZhTTbtdCxmqy1Q/4L2s+H?=
 =?iso-8859-1?Q?IhpOu2D82mWf57dMz/ByvakcbPHrrAEMv2gWtv/tkjWFdjczE2NzeeFbVa?=
 =?iso-8859-1?Q?1tLUDe6DQ7Yg61OaMU/G5kBe6//oEFvCV79yUq4ZWzlEbkK8Z+rbz+Jka8?=
 =?iso-8859-1?Q?4ihjlvXb2B1frUEThjTwh0k2MniS19gXp5bUhA7+d+SR13g7NTOixwX+mh?=
 =?iso-8859-1?Q?eJ+BPYE3cdFTwPA91FILm28LA9ChonNREyX363il2sW4+g8mwYKbrvsJEv?=
 =?iso-8859-1?Q?AvnBYV1EuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Domx17Q9fRmcWIbynHspbISMOYIJDuGpvscOD6ApNbYFYfNoNg5XG+rDrY3QUuIdOJ8hQ66ZJxmZLFgaqZ2hGjY27rb8h7CAScEcbeMfxo2zlYR3/JVUQ3FyFMU6qRpfY5m6rJ+xSIHOcZ0BIFn4JvKtesh3WnAHX7r8Sq633KS22n8fhpGRT2Jua+28EeAx+mChWdFznCMkdOtHzCTN4+Zkrn6Et1TfRbZlu/JI7d1Ouew9DswfM8GgmFXsRLtHaE/hYWqmWa+vKLAB036J0hlu4CvSSENiascUW47wznOI3ULsGkAAEQavAQDQngxgo5t01GNQWyZCm7jmLw1fwg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf974e-cca3-4701-66d9-08df0cc134de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:06.3969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fU829Qf+Ym6iC6WjJlHH9zQPfOG5+pRLNky42a9nw1MYktdmZ2pbDcAC+bvIi8ybFrxhTkZFWU4gocbJ3V1S3dYc3N5plt5YFEfRwZnSW/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

The common code decides that the display is blanked by looking at bit 5=0A=
of the attribute controller index register. A device which instead gates=0A=
the sync signals through vendor specific registers has no way to express=0A=
that, and keeps scanning out the last image after its CRTC was disabled.=0A=
=0A=
Add an optional is_blanked() callback for such a device to report it.=0A=
Devices which leave it unset are unaffected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/vga_int.h | 1 +=0A=
 hw/display/vga.c     | 4 ++--=0A=
 2 files changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h=0A=
index 5664317ecd..68f082acba 100644=0A=
--- a/hw/display/vga_int.h=0A=
+++ b/hw/display/vga_int.h=0A=
@@ -99,6 +99,7 @@ typedef struct VGACommonState {=0A=
     uint8_t palette[768];=0A=
     int32_t bank_offset;=0A=
     int (*get_bpp)(struct VGACommonState *s);=0A=
+    bool (*is_blanked)(struct VGACommonState *s);=0A=
     void (*get_params)(struct VGACommonState *s, VGADisplayParams *params)=
;=0A=
     void (*get_resolution)(struct VGACommonState *s,=0A=
                         int *pwidth,=0A=
diff --git a/hw/display/vga.c b/hw/display/vga.c=0A=
index da0c331486..b273244cd5 100644=0A=
--- a/hw/display/vga.c=0A=
+++ b/hw/display/vga.c=0A=
@@ -1811,7 +1811,7 @@ static bool vga_update_display(void *opaque)=0A=
         /* nothing to do */=0A=
     } else {=0A=
         full_update =3D 0;=0A=
-        if (!(s->ar_index & 0x20)) {=0A=
+        if (!(s->ar_index & 0x20) || (s->is_blanked && s->is_blanked(s))) =
{=0A=
             graphic_mode =3D GMODE_BLANK;=0A=
         } else {=0A=
             graphic_mode =3D s->gr[VGA_GFX_MISC] & VGA_GR06_GRAPHICS_MODE;=
=0A=
@@ -1929,7 +1929,7 @@ static void vga_update_text(void *opaque, uint32_t *c=
hardata)=0A=
 =0A=
     qemu_flush_coalesced_mmio_buffer();=0A=
 =0A=
-    if (!(s->ar_index & 0x20)) {=0A=
+    if (!(s->ar_index & 0x20) || (s->is_blanked && s->is_blanked(s))) {=0A=
         graphic_mode =3D GMODE_BLANK;=0A=
     } else {=0A=
         graphic_mode =3D s->gr[VGA_GFX_MISC] & VGA_GR06_GRAPHICS_MODE;=0A=
-- =0A=
2.53.0=0A=

