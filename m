Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A601C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz04-0003Ay-LN; Tue, 07 Jul 2026 02:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz01-00035N-GT; Tue, 07 Jul 2026 02:09:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgz00-00083r-3U; Tue, 07 Jul 2026 02:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK6ch919D1t5G8cHUw0WO2lYswR3rhE9c74z5N8VIRi7aI4pmfP8YJpQLm3Oo903rXjiOrpF4HYqy2fuApSidPGGzRqlKktNTPXO9p7I/FbmFcqYvAqmp7VTrLM6TZtVphDuK8aQl1aRiqG9d4Kr05Dv5Z4T0elKLZ/5SQhUHnNJn+/coLFJa/QlW1UztMbKG2piSaHLPlWQf8G0v0OYSOuPSGl+KSECVqBMoIIgzIG/J4iC+IXLVmMAgZGO3S3pvyBUHy1Qs0azmwWTx7YBDWomNR/QUS51CsqUPgLyWIR2NPcmmB2ZiOzkzqK/KlJt5BqSZB0X7Ma3oMud+Q066Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SJdgXrVVKGozOG1z6Gfjf/h3vp0XYDFmNqk/PxwYlM=;
 b=Ao2tsayfYPL6OmLyOE+ex+8U8WtHMkcBJQz8namaYqnm5DFaxvASLDl8ABuJIyyswOWHXe1CKPq3XA6w+7iQn2w3e/s+PH2G94Carg/SJGX6iceje2dZdwICCOrXWTpE2PGpWIJcK4wlHgSxo83MazzReG6uPReu7mjSaxJ1+5Z9CcMqO/XkxertB+lBiScTf7XNQTCxeNloHQVD8m07sdGxYBuFUWzaTS96I26/3Hnjkier5GWtQ8ygN32HyWxE12Xoial7uyv+09vqwB0L8gtemCF8usWr6mL80gkAFxBM68wxFo1STtrnVibKBCEIGRzlAxORCPJZmF5GHLs2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SJdgXrVVKGozOG1z6Gfjf/h3vp0XYDFmNqk/PxwYlM=;
 b=B6Ncb0sWsP6PpOdgDFfHdmhuJj0korvmbKvh/oY17VMVGpQxqK0WnGU2Sjdo2HmM6Kg8VW4rEWEG8+WD6QCxdxTvE0wnYG2ywAZIFR+k80X22RCqSWnBf22s/iHrXJlSyPo0vSJ1Pw7xbcGap3CLw2nWEQWpk8T9hJKQzzGB9s6hBtUrGmTs013kL0J4TNEpwTHJCD1AnHjHi38UfptKRFkaYPSBAMrrSNY+JRmt3qTBBYM3JivGtDHwTFfrKo0aW79Y3UD06ZSzU1iOxgtTSGLkdm2gMag8MoxS0Zr56t0tk7BIdLX4H9+gb8SQj7m9qzz8m7rmbCo0MnCEqWeUqA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI3PR06MB8706.apcprd06.prod.outlook.com (2603:1096:4:2a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:09:26 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 06:09:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/8] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Thread-Topic: [PATCH v2 4/8] hw/misc/aspeed_scu: Add separate reset handler
 for AST2700 SCUIO
Thread-Index: AQHdDdcqvJkn/sUoVUaIpfKh+NY9pg==
Date: Tue, 7 Jul 2026 06:09:26 +0000
Message-ID: <20260707060919.350637-5-jamin_lin@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI3PR06MB8706:EE_
x-ms-office365-filtering-correlation-id: 63083789-976a-423c-5737-08dedbee4c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: qhSj4TCd9mg/NU+VWyGmP9DRzr8z9HAewOXzPbxkPHCZbxxVCKh3bairFQbgmQ15YAy5CU0IyjbfOAflrnGubPetgtkU6aIScilr6NnYbaknWRf2+YZ2j6oDtIOb1Harhp9FMI/uBjnF8u3dQi1qeas4OfZbJ0dTd0MwZZHBg76zFEWXCV+9H5LGpUtjr6SMckL7442sTMwetvlBK53smjRqnz3HmMqUxUXyV0+KBOE37IOtBnnqS/V+je9JfYRD5HggbuDXbwycqTHgYaTqc8vrBBWz3hpKtPLxtJGl+SohW4msL1iFm6Me+Ko89wdbvlR/w6dkyhc48a3WE32ezUfgeSMz+hMjjZvXQontYsXINAFRucu3eFyA9TQ6OZ22n59PZCbeJkjKzut2myl6uQ6Xg5VTQnXE8VJ5YLU8Vg+GXEVVlG+bs8mrrMhgv08gk0dldN8W+/+Vr3eyzm0Rs7tE/RbhoRLSoDFb5IJU1qb+trIZ6+FHCrZGluyFbEaYstKHyyOxL2wVol2hWpPY0lXMwGSy86CaXV9jcnWYYPKDLJxNAnntJmNUY02qd1fMA6w9CPJlQKCFupauh77OwrTmC37fjAui3K7O7ORVTPJ9IU8dstCtUja3NvCfyBy2jroOJQSXgF3YP1gEw3xXuNbNQWaazhI5yRgbT3rU/g1B9MZlWgkvtWH2kwLF6RB6B5WwGLS1JQEade2X/FR1jejT7EEENvPoQLhK+XmwyRDTFD22cARJbTSZKogxoTor
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NH8YqzOf58egszo/kgbLPmMMNTXnCOh6Oni40oCifi5pUFyLxb0UhXJzYe?=
 =?iso-8859-1?Q?lX+YTVvRXDDN9mpSSqpDlgwwi9Ms8u2CgOJW3+HsaXSwAq5EWLCOiZ+Jo2?=
 =?iso-8859-1?Q?Pcroe4qC0Z7CZyW4TRPeKHw3/hqLBUIrB5zNboGXxwNjs0KeAKfYKMNgx8?=
 =?iso-8859-1?Q?xF6/XTZLqw9q0adswKFZROLVpbH58+rKVGy6Ctnju1pn8AWFE8oQcXflp1?=
 =?iso-8859-1?Q?XUO5Kvx33dqI3cIHiiIydDS4B8PVSQT0kV4OkvS+mpC787OQr3+X91c72T?=
 =?iso-8859-1?Q?2bVXzH/KUWLmC870Yt+CDMrWgu/QoOfUBT5sOjwcp4sDFkxvdwTI7KZHNh?=
 =?iso-8859-1?Q?uCbyjoLhNMAWfseL+GM4/bVGWWEDmizKqmbjDM6Ev2nIBtkAxqLXBG/stH?=
 =?iso-8859-1?Q?vn23nN4SNiIDYn9K/Klzps4HAsn0RkpEFNas65Tmfqzwv7tII+2bAx3O7o?=
 =?iso-8859-1?Q?SvCvI3QSRMXyhCNykgUFC32iM1HK9V/iUx/Aa+km356iUitVM6fgVjNKMd?=
 =?iso-8859-1?Q?XSVR+sRe/IsT23Hbn2DpX0UTFgHkVb6nsV409exEG5GVBa3I+dbZBa2iLp?=
 =?iso-8859-1?Q?htkkeG8cDpJ7i7IrR0Oj8MlomeCmDXicxq+Yd26eOIURlc5jLixqfH218e?=
 =?iso-8859-1?Q?zPYDNia755wHqL8FICRjbr3IjtosiyPrIxPRMjmLyfVJTG3NVMBKA6hQc0?=
 =?iso-8859-1?Q?fJOVLzqPWx/wZ7v5Ey5/OBdIai7h3qlXijObP+6igXk0Sygr3yohRCfx9I?=
 =?iso-8859-1?Q?nymWe3GGFTNNvFu9MFV85AJcf7TdWediwLqp0SSVl8wm4xAzaCXpH7IgiK?=
 =?iso-8859-1?Q?ZPTgyqB+p5V3WwsECX7d0XDL5q3BR7o9hfg9fbBRvxshzkif61Yxf+LMRW?=
 =?iso-8859-1?Q?d8nevnqSyjyCRCFESfyq87vBvxe+zJvgYzYTwdSmFWwUuuWv/Vm8zVt/et?=
 =?iso-8859-1?Q?v5VszceeC6KuyOTsxb6a4gS2O6UiKVsYaEm0teBAiVUS5ZzWC+2L8nLEdS?=
 =?iso-8859-1?Q?b8MgHZvV2Klnrxi4liAce9fpADWQg4XypoHP0+ctIz1Li1pY32BZcfmZbk?=
 =?iso-8859-1?Q?yffxdHRZttliOOM4d5ZHnsD6mio993uImqKWB3EjyFk9z8MIbL2wH+Gao2?=
 =?iso-8859-1?Q?ES7ODr/QUflXRioSUzb0bVi9nq7AG37UanWc1PGgSEZjrfn5duhZyKkAKa?=
 =?iso-8859-1?Q?Z1I5Tri7IWIPI02v+DcvYYxnxgYCoJgpIkVg30lGEQ9mZirDdnWIQ0EODP?=
 =?iso-8859-1?Q?Uu80V9GklEVq4dG5Ggs2YYxUOZmysVbkwzUfmSFh0M1PMM7eV583Pj9DTV?=
 =?iso-8859-1?Q?OgkA/7+Dih++DT088l0TlWBB4WIvugaKu+BeQdbVrb5Eor6OpPJpcIIZ1V?=
 =?iso-8859-1?Q?WYucQdtrfvD/g63nyKJPNiBvfhrCDgU3kr74R4dkPgdBPEUYlzXSqxbNIb?=
 =?iso-8859-1?Q?zPritET3m+JIE2JAN8npv/em1X85+/cBUWr2Wk5wHKgAKdLbc0KoVeXul2?=
 =?iso-8859-1?Q?Y3CTCld7Nn9uk/OLzYw1HbihXqEA2IxWp0XRwRPSkkBv5KRnj4N2KO2ZtM?=
 =?iso-8859-1?Q?xe+i1avRuCxfm444KL4fWrMQzApJ78LPcVXX7VUDcPGUui/LPZKeTiBuBo?=
 =?iso-8859-1?Q?SHDZpHY46AdEG3XQCOOanwGOJyrdNAFqO7sbLtlJN+9SiOWZ+hfoyoj965?=
 =?iso-8859-1?Q?g8DeRwtfbVlJrFrhRFSLUcM37IsA8BDeN9SeR6uNlhrH2uOkHJLN3dStUx?=
 =?iso-8859-1?Q?m3X3UzumQ3XirXM8fMzJRK4D6aNbFUmQNuOFkiAWTBiW/6GA6/xNEoJuoh?=
 =?iso-8859-1?Q?Cup89tunFg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FeeHHz1M4SskRShDQnauOiv6H9lzB7mLJNoJF/Y8oM0MrKs6PaWm8MHNkKwKK0yHLK2JkPy6DjPlZjroiPPztpOPFEPos7tS4xwsm++ShKWt4BG0MYlk2sJ3OGZIFP4XQ8oiSXG5vDVLyOrfr3kv3y/feroAbwLTLu7qJ2Yfezh6QPlffPu9HqNPcAA2trDL+IfVhZZFdpISkgIOB1WJS3GLaeE6jT+MdfGzJNDnJtc2A+h3FmeQujOjlNfklWHWfmQC9aYuzkRdu2hCB+GLBiXJ++e1gpvlE2hNr0laoCM4YOA7fOcPJJzUf/F3J5gwI9pRhnTdXllHMB+LNa573Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63083789-976a-423c-5737-08dedbee4c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:09:26.6485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZn7th6FYY0+mx78NeR5mK+OCFqHeqUHQdX4L9go1iedZQbpEPHnUsEDa465hizfT4M7KEafy4VzP4BdiKGkAa2NzO4tv/OPOnQF0NIO2nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8706
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

Introduce a dedicated reset handler for SCUIO.=0A=
=0A=
Previously, SCU and SCUIO shared the same reset handler. This no longer=0A=
fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass=0A=
and will handle coprocessor-related control in future changes.=0A=
=0A=
Since these controls are defined in SCU (not SCUIO), SCU and SCUIO=0A=
should not share the same reset logic.=0A=
=0A=
This change gives SCUIO its own reset handler and prepares for upcoming=0A=
SCU-specific functionality.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index efe1d6315b..ca93c3699d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -1069,6 +1069,16 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AS=
T2700_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCUIO_FREQ_CNT_CTL]        =3D 0x00000080,=0A=
 };=0A=
 =0A=
+static void aspeed_ast2700_scuio_reset_hold(Object *obj, ResetType type)=
=0A=
+{=0A=
+    AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
+=0A=
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
+    s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
+    s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1076,7 +1086,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass =
*klass, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit I/O";=0A=
-    rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
+    rc->phases.hold =3D aspeed_ast2700_scuio_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets_io;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scuio_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

