Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3B0C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqa-0005J0-N8; Wed, 09 Sep 2026 21:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqV-0005Gv-Bo; Wed, 09 Sep 2026 21:45:01 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4TqT-0004BB-B5; Wed, 09 Sep 2026 21:44:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4uZZ87aDuY3bvGxZUgVvMJxohkcbAP8vAOZHU/3kKYGn1n5qtu6KYIrbKHGHVdlVX+u0QmRHGpOeLXJ63+mzMNOOjn/J8kPBxzdBHWEXeWeY/tAhUeyhPjlwN69KDxDQZKUekdoKDT7jZPtZh5UH0KBStnclmdPnTNO54igYNrv6lAoAItQsH0oOsUKK7crp97+12P8UA8nsF8SoMqnD3dkm3JYPBdCsLXa/1Q2kk08lrU05h3LL9stvG1UId6rq0hKsItXGr+MKmQM1UFPo71rRsHNSU9vaxjoR+WhS0LjROpL52btn0/SAkhz53RyeFXBDskQUoH/g+owA87EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7NUixz+79133nvpUm1BHkJtUGWBG7WDjG8ZzFZTTxA=;
 b=xtGIW8UsDGYDugQPaDSGYwuDMxls4epHFmqE/0+aw4owz+vmZ7/Nmidg/9VivWsy4A50UE1soLQOubMTXXLsMVbYNac7PBFJfH3rQ6dKnifsXIWvdrESqoTrJIACwXolRvWNjeQK7R536G9hAiT38Pk/2ouHw3olvGLq3bhqpj2rTFAERfH9bcZpkOaVv/EpTxbQrTkm9bqIgARb4RqFOS70dSU2RI4DERKZq3W3ZdjvqLzBTP+gwjV9JOzM7roWQZivW94XNnblMM/r8YsKg3yT7JFpEj9Zoma8070NydAk44hSX6S/c8krr2orz1j93d5McpQsDyI7Lj9/pqVg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7NUixz+79133nvpUm1BHkJtUGWBG7WDjG8ZzFZTTxA=;
 b=cG10VV1abcYXBjTcMMz3jboadSm1Vjqp2woODHNxtJ3stvvJSGb+gHlYuuQbxe8fI4L7NcXWPHkBgIN36BsBQevBHzMMkbwoiWEXibd4v2VKsd3AvT2rf+g2v0mzLJFRYUn3tbc9+VkHf1XqjgosZ5iRZ8dOi2TZ9TJk5/Fza1QH7cyUY3lgXYFbg2l86ACojQUW/Ksb8EvwnrqDiwQ/XhoPmpPEEkaMwByQX7mGA0eE+oIdNBYTSbI4DA5cceBo4g30/Bamq3aKrBxbeUF5oFa6HrUjNiVcFxPDGgdjVCavAthgUpFPvptUGiQ9bR9MDzIHC6O2V0NTlwic+jWntg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:49 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 1/6] hw/display/vga: Allow a device to report vendor
 specific blanking
Thread-Topic: [PATCH v2 1/6] hw/display/vga: Allow a device to report vendor
 specific blanking
Thread-Index: AQHdQMX3wMvvvmwsEEizQ1OUApl1tQ==
Date: Thu, 10 Sep 2026 01:44:49 +0000
Message-ID: <20260910014447.4110781-2-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: 3f0b7fe4-4ad2-4bdd-b9da-08df0edd19b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: aDouwmVvnFikw3ANNuO+L2FUhXeGdCc2Lhb5UGnEkCCLiZMKC7kKX1NPTG7fAM/zafdlURUZJGwU2HMDnmJIYSfRs8yhmHpQ2buX2AKPii+O3oIFi0NZ7v+lmNlOAsRbag8UwTFp9Bt7EbtjkK+opX5EggAqNkbYWO5+H4wzaBI3gdy/pLtIGLeh2IXSz8aplSyP4eKBmDxOtVtLDK40L8Vq5jco9devI24Eqd101dFRK8ALrA4sMqhGZXa1dMvHvSPZ8RyjcXCYaJhczz7FHpGON10JXCxtzZaP0T6/xt27+QJ1C6rXI7KZoiLDcm2857V+AGS2953CUKV54XqwnMGH3HqMgRH4BWTgt34YegZpmb47FQpWakD5U1+TQUtzZgHOiDzcMe1GLnx9Sa4R6lV8rRMYYi2mgOi7sy9eEEo18QhhSIQ9Lnab++u1K+Xs1B1HsdYYDLQoUPLnSLbc8Ds01Z6VaRV96EEWegf0gVsZy5OYJ+gXD8cuyWAhY/FwfwwCZIYFcOE4iQchjrwYB0HLqPRyietQPxx6B3XDbJ9krjpG9uJTFF+XUDDC1JVMVaYoNn4/tMVeda3qpktuQCWxen8N0esKT0rxUHIF+IW7tSTlB4w6m5yVdpTlZ1lFR+dynLcfk52eVYMtx5Le/uywgtN1rDNrAXbl3BdFwnPiB9i/+AMXLt4fqfRfhOSLKQdIdIH07W0tX6h3qWi7XYXLIr0XIL8O1tFKvqqF078CKLq9Ir2YyWkytgeUDNiW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jyzRJ6RXH1xX7MFPtq9+mj0bOP+m2JysjuYLeoUGfUKAbTSxZaw9egpPrA?=
 =?iso-8859-1?Q?sjU9qeyMcn77CWRkIrllogMmKWZghUJpFt60hgR4vSLHCgIBgeuoSkxSVB?=
 =?iso-8859-1?Q?tb5nRcjvp92ZUj5FPsTnoruKQanwORkGLYJJhr/KRPpBB6oRXUA3uByeMP?=
 =?iso-8859-1?Q?L8T4TTeZBkHmyQ/1uUNpn5l5YzOV3mxuIm/jua1Tp+vLlC402O/kkNRmXx?=
 =?iso-8859-1?Q?W0U16lfENtL18permHwl2PpCUDr0jY40jXxsTdwslxIXYLnQnjQtkwLVeM?=
 =?iso-8859-1?Q?+L/OQwFq66b6bbdq5qQlKaLTIPx65EvzyS5Btk0DCE2bPJ87JjWKAZKi8O?=
 =?iso-8859-1?Q?cMB9uRRSxFPZb+41gwspmjkWDmhU+g3+KTOOZMi0nzFZgvnrpr3ez98ceu?=
 =?iso-8859-1?Q?Oor5JBoFKan2LAxRMPvrrA9DtYLAa3e+78jH4riQO17LkuY/IKP3YizuSO?=
 =?iso-8859-1?Q?c0L4kcRa6NirFVdQtPqvtV2BPkr8vvEz+x6j2NDHLrFYw9QWR3TFWBoBKw?=
 =?iso-8859-1?Q?s43zXKrDqsbdp2TRLb+FJYIZZY9waDoYlMnoOhch7h/h6IJ55Vj3EZQoqP?=
 =?iso-8859-1?Q?2xc1C4IFk4z1dxOCSLCIyUk3HY4faNsteGrNVKHSyWlioJqQ/rQT4npyK9?=
 =?iso-8859-1?Q?qyccMm0tbwVQuGeuBDmdDxhYHd0tmg2TNyO3CjY7NUuo3XS6OeR78kc5cp?=
 =?iso-8859-1?Q?u+dQN4wSEl2bgI3IuBTpjUze+0rn35Q7Znc/eTmEkeqKDy7AMq9yjstiby?=
 =?iso-8859-1?Q?AxoQDUKsSqbLCk2Pjeg70o9l8nK9/qCpq1ScRDGvoMm++7X7RBPwCKoMZL?=
 =?iso-8859-1?Q?yI1QfNtWG9jykwKGwaUQ8aAfwVNK8qyjrvUJOHEnggO5Um1k4fNzHGM2Sg?=
 =?iso-8859-1?Q?1I0nxqRYofnE8FoNrEHTrhtH8ziiYE/Ur1VHQCIzLyipQhmJArI6L1hAaU?=
 =?iso-8859-1?Q?aa8L4mdAchJxGzMj4vSg/6HHXZsGA2NKw1/sHrnQVlqrpSKjAeRn8LqrAY?=
 =?iso-8859-1?Q?nBVXIlPH9IdUjxfrRTIdBs2wEEufmJpE+wpbffxGaTN+TENS+dguId+mH0?=
 =?iso-8859-1?Q?7XWnGgXylm8JpnmmzHwWqTKbcI8q8s4cEdi5gaxKGzzN0CeEtM9mSbWNRx?=
 =?iso-8859-1?Q?MY/3FjzmQyPlbmN50TepY06/ZcCcdBWSSteprI89nBOdHVJH4i509gr/Nf?=
 =?iso-8859-1?Q?jtjrkfbtS499V2zNintUSfSTAU7gBasEj13SFhAjuhtssRg9yswmnYtVbY?=
 =?iso-8859-1?Q?IeS3I1e9D0lXfKXJbvLR+RYNjNeZTt26wG/DsqNDBUR6AvhzThrnuxBo4z?=
 =?iso-8859-1?Q?83qYOPrXRB4OMdoysYxfVoZNXk85NuX6qOLuFVIsRBavN+xAlqu2+Ld+kU?=
 =?iso-8859-1?Q?TfPEqUaZWR3RUUMEJ+7MjwxBSAYlx0BCyaDTpoS47PjBvLXWDDbJdXX6Hy?=
 =?iso-8859-1?Q?aWtj3A9vGE3+Dm/rToAsJZRuw7Vsldg9ro1VHOh2COtr7VdQxu+iFQQCF2?=
 =?iso-8859-1?Q?4YlFqv/N7aFkbxdG1ifhc6lv4f0jt09RMokEMQ93fsK29Qqqb1oy22J9z4?=
 =?iso-8859-1?Q?/PMa0v7q4ngAAdu3doO+590GS+fyEmXmMky+iYdT+G2rYeuuZoZBjOPnX0?=
 =?iso-8859-1?Q?gStV5L2l93/rxKZj4tiT8qNyYNl1K7PADrxTFgQXXNivvOBqsawH2ujaPO?=
 =?iso-8859-1?Q?AQGuyNXRbo6ylNR9Zwo2BOE7WqSA/pRXV04xP48xtHHvTgYjdtLWWnf9Q+?=
 =?iso-8859-1?Q?KQON71PMignwmMtdCFwsC3NY9GmNCbecuv2sMILvZ7G7GaqSB8ZZ04RbZm?=
 =?iso-8859-1?Q?gFA+mz55vQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3GGT0UAepXpuBw7gN52qwtRxTxoVmJTl4DcVfCTD/UwR+zB49aAE2GA9KtfJ9DdHZdzp9C5L3jYrqKVPm4bRCcBH7ZSnBm7frlzEMiR5utLACB0Irn56fDqqQGWo5h4DI0w4aabsw+0KBxnzxhsYWPEy/n+mo8RQ7YjrUEMDZPe+jCj/kzjvrGo6WpjRTbdfPtooSQjCvf8qV2CgiCEHvRAGjWU0qizPoY87eyJU7O5hgXUWMPsqJSzPeptzqreYoX78kdbY0JjnZWyiAc7gz5kW1MI9rlfye4wNsl9q5jrRdiVUoQTx5+Gip+DTiIl4ZalG6VI4+dz9kqznKmteZg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b7fe4-4ad2-4bdd-b9da-08df0edd19b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:49.1709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQxjrIkykT/mTTkbtUGiq/0nNSi0MYIurJyaEjVUqNp3tXQ1PMzPO/Wh5JKQFNT8l4ifHY8DcCxGQkR9gqRZxzFQdmhkLtkPtoGNUDK3Ybg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
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
index ca69ae9815..a017ab7a99 100644=0A=
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
index cb0e28b79b..1d96308060 100644=0A=
--- a/hw/display/vga.c=0A=
+++ b/hw/display/vga.c=0A=
@@ -1814,7 +1814,7 @@ static bool vga_update_display(void *opaque)=0A=
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
@@ -1936,7 +1936,7 @@ static void vga_update_text(void *opaque, uint32_t *c=
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

