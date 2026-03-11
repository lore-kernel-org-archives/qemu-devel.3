Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CC4FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w099d-00063Y-UK; Tue, 10 Mar 2026 22:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w099b-00062a-3I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:18:31 -0400
Received: from mail-japaneastazon11023127.outbound.protection.outlook.com
 ([52.101.127.127] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w099Z-0000nD-3U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYt7jeE2SVB+y0rTeBiMVtsJgBiXWSvUPpPLnxNzeEJ8CHeYV7Uh1CcBhEdb/JsGM/LNt7CB6vGZEyvl0VNCT7TR21rFxlAxhgFPwwOfoS3FwPaA0tdd1LKZ2unZIsUta1ogpE3G1jp/j30ZII/wFm4gGhCJMN9hFTnaTJD9Ez4KMfYlrdQf5vRM/lkKa6gMEQ7d9+G45OsnnjFaD+TH2P7rlRbKTzBFqP4pDFRMwWf0FCFPcyAQfGtkGGApKZ/pVKxJ9Q5lIBzhZohKz5ZUKzMThAPFh4jEhKIfHBsTVJkZ4dAxpflCKBdL0VKY5XIlWVMp61WeFmG/Aky4o9KwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=123jYLVxoTnmAJpjhuS5Rccd3GCZdPg6ywh3k++69Zo=;
 b=inK8h85nttzmrRRYNXFjK3CfSV4BPUeIL0nOQ+fJNsKhyblGj+t7ugYZICLFwXTwrlyFceCPwidr0AzZ5BAMpzAa6vzEnOqVcPl8MvI36wVWTrY1FW1umoKo2Z+GDmlcll4jxINJVGpRiWyum5XGHsaLDm7NFA3234qZBKMZsCn1P0l0vm88oG9UUytrpFqpNXsc2yX2t0XoyHwJc0K+6TxvdHZzkVUgFA18MzYuG6oIadICfI9GgDORKwD+KtK5A6z7WqEpO34PM7dZQBPgQW3dU6ZIjeeS5KlB/cGh2i+OqbOxX4Ey9VHaREdcYhaIOBE8kK1wwg06SaFqNJKGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=123jYLVxoTnmAJpjhuS5Rccd3GCZdPg6ywh3k++69Zo=;
 b=DgSA7uM6tAzdsSBaF0LKxaUyrtPSo+TTw2sRdlb0uzwNzVI31cb6EEgNSWoCQdnEoVFpe++nf7ZEnpmtAHMUERqXNzpqzby7F1CxC+pZvxS9R4aLNF72wfdNlKFCDV9Ew6yGyoPRytjQtPjYPSM7t2DevX8iciLsLUjNvY4KqzbB7cezEf7eIko9KsSiwrBisRV9Y65tezWuAEXSCoq0+3xQFMLj5eyYlrEGyt7xUgEjWhu3jOsA6MmnsrQRMKJYIQxfYLA9oVC2KaDToiqKrAM2DWXLpiylXNLBbCFhIFBYGmdrQ1DPNjz7Iljo0wleGjbbQkYY28GyqJ5jC+aIVg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6873.apcprd06.prod.outlook.com (2603:1096:101:18e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:13:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:13:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Nabih Estefan <nabihestefan@google.com>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1] hw/i3c/dw-i3c: Fix uninitialized data use in short transfer
Thread-Topic: [PATCH v1] hw/i3c/dw-i3c: Fix uninitialized data use in short
 transfer
Thread-Index: AQHcsPyhgpaQzU12H0escCbAtDQeyA==
Date: Wed, 11 Mar 2026 02:13:20 +0000
Message-ID: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6873:EE_
x-ms-office365-filtering-correlation-id: 76dd6a60-03ee-422d-7f64-08de7f13c3eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: K1eERmO+TsoBe6UmQ4v/9/MjACnFr5x4iwlgH/tRdkDHd2w/JyL6xf6XRkQWX3L4yRcqLNVO889ymjahAnRlfOrwIuxd1iFIEIUkIHjg8zaNHl7vKnX0ZOMt/Ylw72paj9N9hL527cTOBfx8qv/14zFRoD/xahWdoEe30alIe4xmj2gpMW0SLhpvxuws/3fAUsNS6TLuVX+TxQvrYm9SEB5T9PxY1xE22n68nQeBM+zzpmjR/RquW6iUJTfksMh3g/ViGzOPlz40DQjRJbUtROnAy+Mo7LszzN2vWSqs+tmyvBiuOT93Lxa0r/w+W91AaYXG6DJZOMsrS/Nfv4j9DjQdCWe65Fa1FItBtObuZJy/PLto46lQAB9HzhbkYnlg6vVDSBtTBrTTjvNoZcjExwlZF5CP5+HJ6xUng23nncJN40WmD6BYki7+Cty2Kc/fZeYW2Locz51+bTbDDgrQ4t2fj2C89TQIuzBaAgOG9ldZfbBwM/CSfFxQkEYqst9e+EDQtTpVzMSBARJs5NgdY8TdRaZeT1eeUSWj/QfHsza4LjqAmZd9JjUAGFpIH0+sMK+tsUSdPPWuFq68u9YRjEjc4hvnha9XX1qtojJSBeWPhj28VT5KqBiZMFFplDvyHTzwqoZ7iwT3yhJ5DOvfID4GheZJZVHnrEPCx0SwMxJ1OMUxnts42m/emNRzix7oC30FTUsY7x3g6wWpYBwMGjkDFMAacuLwKGcys8FW5YuyAMibTvFdNMyXL3SFoFzzQoVrrnWtJDAV5wIqaqQjZ2mW78M6f2Epz4icCNoitUg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HoJvMTXz6r0ZGPK0NeuK+qIu/rYS3PpbkdUdlpWdP9YDMYWujBtbmFTwsh?=
 =?iso-8859-1?Q?Vmy/GHZ+oPVa54JxpMih7wOwYQEHUJftafUMSYR76LycZVl+D0TSZ1S/02?=
 =?iso-8859-1?Q?mx9xub9BFObz8v0Uyo35o1PkrR0jns758eybO+yjTQ9WiD4IA5oxsTjpB5?=
 =?iso-8859-1?Q?pn+VDBeBi6PVcfWDlqdWXT9q17Hy3+JDhaHuO0how0CcDLoWWMetAepZGZ?=
 =?iso-8859-1?Q?Sp0+Y0po29XNSSOFLiWuExY9UcxJdTQwcr2+jsJYrFB7mkD6194E3ZLDB7?=
 =?iso-8859-1?Q?6FXBXapKGcSJklKg5p5Rx6e9mOYrhSl3XwbAmo+QmPLl2gEVp2p+yCN9NX?=
 =?iso-8859-1?Q?70Ko2wbt0SvtVeClsjq1u9b8igT3lsT7O7tyf3XfpPHoUKSKii7351B6bt?=
 =?iso-8859-1?Q?KOZNMLPPnTgMuMDSK7I8JQdwgQbpH8kA6QpG4TzGTzLaqNzkchJcaSEgv1?=
 =?iso-8859-1?Q?LGNRMcJi+WlMGrKIRMV/ucSccMOQtJ5Co6dwcduA4nWhpdRH4GtGp5K+Fh?=
 =?iso-8859-1?Q?5yMBWX1K4yJehA+YN7AlOafNO6gl5AY0sk3FKsqniUycLO5fIafCaL6dj9?=
 =?iso-8859-1?Q?TFSPMWWOvBgNt4K9cbqSENja23hKpK4WWHet3vKw/jKgvDoCi9D98Cpl1E?=
 =?iso-8859-1?Q?PGkSwDFBeYNtjGV3pdeDVnJoENsM9D6ruCB7585jS6HiVHxqOfCvt308Jk?=
 =?iso-8859-1?Q?x6cnm4rWGUcmurJc+GB9ufHf7yXIHrgjjy57dQUZlomYnizZ9NDZVT2rrH?=
 =?iso-8859-1?Q?f2FukI45ksxAJm5Kf3cMdmZXwVh0khdfkv2XEgTdXWZ8nKSbNpp8sXTSdw?=
 =?iso-8859-1?Q?+jVYzZdB/cGBvDC7AuVEkiCbbEERoxxpHsUKZaRFHB8r4ASuM6c+XeylVq?=
 =?iso-8859-1?Q?s7a1ZgjMXNw9tXDrovIzmwKdaX72xnx2sl2T91wT/xSorC7nRA8KuT3fnn?=
 =?iso-8859-1?Q?mdcNJfZcK0fjr7Y6iZnVs4V/vYmgde/aLr202rCqW/4v3X3xapmEBEX7XW?=
 =?iso-8859-1?Q?dwkhGNomY1C8J2E0H2gfcmuS+YGDr3ChSZOjH946gr8hLeEbOD1Fo+xISQ?=
 =?iso-8859-1?Q?LaSK3TEG2771XvXWRLCMVRsRtglQwtBwNY1IUR+WlQQ2HnBlPrvxFEvnDj?=
 =?iso-8859-1?Q?g8Q87pnD5CC07fWQ13yT/PPGa6oVfN76sxHTY+JEK03KAgDVYcn5pAkspy?=
 =?iso-8859-1?Q?fQKUwuXiBLAfNXA7xWO0Z1pfrnOeNpmfI33YPrS/sNv1zRnFV1iJwSFLEY?=
 =?iso-8859-1?Q?d1UKMOk/tnyDkhE5YYzvD67Kt80bHcbBDxO4rMrwzZzoMx8paf2GdE8EzA?=
 =?iso-8859-1?Q?ewgGCTxmkmp0b17PKrJym2mzG2PeI51pfJbGHp1e285B8i9/lUhkXI8WsD?=
 =?iso-8859-1?Q?CrJB8F1l8hFTggIeHmAxeCOcAEgWcF6KTMGc8X887bQqm03yghygVrl4K+?=
 =?iso-8859-1?Q?+kp1PGOP5r6MOGztmuUYCpXW17R3LcQNc+Phk5ASezKvBxJ1Erth6vUDeo?=
 =?iso-8859-1?Q?7Ke3yrWT2Et24PMrPdl+3c8jlYP7B7avfdlmniOt02oM6G5j/BfQdFuoHX?=
 =?iso-8859-1?Q?5yt9rnm9tyGTeCq9D0jY7pEbiR8NTVuEKl5xMm9iBF+ErCeNeoQYoay1Hd?=
 =?iso-8859-1?Q?dQGAHSVyC0SkCMs6rtFxwOa5pYqCDZ7pupHmaLCW7Mw26ZtgaoajU/kmK2?=
 =?iso-8859-1?Q?7ASY3XGGVtNonEklB33ODBQQXxceTw9fVbcQQrui2Ui6Q8onjvEfqbZQKs?=
 =?iso-8859-1?Q?ux5V4Df4r9L34umS7V8Mq0DQLOBE0ARm95UrrpTQ+yjA/pxbWa7DzSI+rz?=
 =?iso-8859-1?Q?dfTlB3LmKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd6a60-03ee-422d-7f64-08de7f13c3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 02:13:20.1039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGGWCOpJVR5y5UdqJNNJIeeDMlgud/k3eONHWOaX1A8Y52v0gT+gi/9an38eM8Hiy+C5CjtnJENox7mVZ/HokBvAUoSRcNsRMXespOyGVLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6873
Received-SPF: pass client-ip=52.101.127.127;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Coverity reports that dw_i3c_short_transfer() may pass an=0A=
uninitialized buffer to dw_i3c_send().=0A=
=0A=
The immediate cause is the use of `data[len] +=3D arg.byte0`, which=0A=
reads from an uninitialized element of the buffer. Replace this with=0A=
a simple assignment.=0A=
=0A=
Additionally, avoid calling dw_i3c_send() when the constructed payload=0A=
length is zero. In that case the transfer has no data phase, so the=0A=
controller can transition to the idle state directly.=0A=
=0A=
This resolves the Coverity UNINIT warning and clarifies the handling=0A=
of zero-length short transfers.=0A=
=0A=
Resolves: Coverity CID 1645555=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 14 ++++++++++----=0A=
 1 file changed, 10 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 3d8b95a14c..aa6c27c8de 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -1211,7 +1211,7 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTran=
sferCmd cmd,=0A=
          * ignored.=0A=
          */=0A=
         if (cmd.dbp) {=0A=
-            data[len] +=3D arg.byte0;=0A=
+            data[len] =3D arg.byte0;=0A=
             len++;=0A=
         }=0A=
     }=0A=
@@ -1226,10 +1226,16 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTr=
ansferCmd cmd,=0A=
         len++;=0A=
     }=0A=
 =0A=
-    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {=0A=
-        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+    if (len > 0) {=0A=
+        if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+        } else {=0A=
+            /* Only go to an idle state on a successful transfer. */=0A=
+            ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                             DW_I3C_TRANSFER_STATE_IDLE);=0A=
+        }=0A=
     } else {=0A=
-        /* Only go to an idle state on a successful transfer. */=0A=
+        /* No payload bytes for this short transfer. */=0A=
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
                          DW_I3C_TRANSFER_STATE_IDLE);=0A=
     }=0A=
-- =0A=
2.43.0=0A=

