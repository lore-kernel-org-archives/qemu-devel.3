Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56231D58E4D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtvo-0005rN-0p; Sun, 01 Mar 2026 22:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvk-0005qy-R9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:48 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvj-00008k-EM
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUOyF119OYni7hPQPcUrid0QMs2Po8yMOFhazG1jisCiePWhYqV7zn4bor1tbDWiT77NvzEbYQ8wvrF5rTr4iDLhoaM9UkpoQCWFNXVTBKaxrZL2JLdyGpDFeQcp+BS8G8D3ecKnofyblDrIGDDWEEj8u4MHPYPTnKnfv3dSc4pyDj/I03EdWsy2sxo4TNUyLCTFXrYMZqUXBw9zCX/hIxUnAYyZZAc/YQr8HVA0oLv3Db2LGwLWu8PNsKiMZNvcZcK+zTKlYunmnJCsf1R//ugL3YB5DWl66cGFSntjuj2WpIvizwZnHyi5pYhC+Qc/8cLpFl2tBmo7l/YxJ9ZcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvEJGeOvlf2VS3EdrA9TayxlYmmfvYAFY34/RXZCbzE=;
 b=xH93NFV6olIvu293A8eBDyw7u85T4Zjkc4ZCtwf7q9rdQTBP4vs3TUmJi7ZjQE7X8qWaxNTyp038KoO9bz6JhstLlUxo8gPY73XFhi3DGPJI05z2k0UBkduUmBczUK1K1PH3w5TH7HMiI2h0qZvOPWFlmL1kbicU3Zn4xGqsiU6hFBn23bDu2mJ1slz6AxQD/zFbpTQc4ejbNiWK/DSBbCKpkFO8O0x4RY/j/0m7LgDCjRflBOUTr/W5RFnZNd2KZb2AkNPAh3jojZgecQnK6+I4Mu71EgB2T35guJbexxu+0LzIWgSyr4KbgHFYEtBe+x88o6WQcMLuY8fdDSep7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvEJGeOvlf2VS3EdrA9TayxlYmmfvYAFY34/RXZCbzE=;
 b=bC9fSaM30dzj/RU/EDXP09mMo1mfUliKh0KKUMWEf1AOv/PKvp+4lnPDyATh6q6xr0+qMreSka7e2EhhsmRUknHbhm6GZw0V1Da8j2ga+Oax1MCNApGU3mEjqt2Azn79ELS8gIIgzWgMbrsFw4UGm3Tt0m5rC3NmogLgeKaAp7nmjSO90ij9BKXUZvSjkK8plQ+oMQFweETHLhmtAZhsHhgQ5R2vITpllSs95nycg80CmpplEt1nqITVMaB8TGrBK/llD4rY/b0Wn9+a1mwD9KQmvw4SUJdvj3OHkQnVHcbnTUzbG5uODi+ecW+PmsrI/NdDXqmFThvHC/uYDXhcoQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:26:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:26:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "jithu.joseph@oss.qualcomm.com" <jithu.joseph@oss.qualcomm.com>,
 "clg@kaod.org" <clg@kaod.org>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/4] hw/i3c/mock-i3c-target: Simplify GETMRL byte
 extraction logic
Thread-Topic: [PATCH v1 4/4] hw/i3c/mock-i3c-target: Simplify GETMRL byte
 extraction logic
Thread-Index: AQHcqfRfKoShnH+haEGXVD3kCfcONA==
Date: Mon, 2 Mar 2026 03:26:35 +0000
Message-ID: <20260302032626.1974743-5-jamin_lin@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6791:EE_
x-ms-office365-filtering-correlation-id: fa538ae7-cc80-4e0c-d369-08de780b81f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: YCIvSIXkLZNc/JlrDUp38GKnokYGZyB3LYbLmSip693ldkrMG/OnNgmwGkZ+S61X4vS5ghGrNkTBq7g06XuOBJSAha3jzXk7t6y9tpiKItmxtTafVH0DVnHmS3YfqH6zhYWcISz4UMZpkIkAOiEoYmxIx4QzzvLiMLywJOdMfi70Lf8LJoBFF0lfXaiJaRR05NH83Zwt+zvPVLL8etu4T4ffgSneGwBucwGzAbwZlO8TN1FnLgTsGJI6RGej+I2aA8lWalB6RR0YrnuKpDzgQDuYizeeH/VnwCFsMxio7J5Ox6WBUyXr7XfHm45gGEumrhAJ6smLWaGr/AjwgX8+RUYNwOQiSu2hf7qYeIGhktBEZLCmHLiyYontB8duiKq4RVYjgi9nSMOprC+ZxvHaOTNl5w2TSb6zltVqwYIzzdd4sFVWmlP389iluHNdZWJx/WtNGuoLsb+yDjFlFM+wH8g3TXByhRIblpZv7RyxIUT0INIp6SmdfyJMbX0IUJ/3q+r3d7JX2cs30jnJXIhN5xh4zYqGQiBVdMlPAM1R56aqfuVjZS6Yd+eEF9puJYdq3NFJF4I954Aa1QHUfUxCuODL43ycymrFmBnnOcq9cmVTkNGuQvWPd7XGyaurWzJfU8NVZNr6IpHw3iisvoLO0a4Q7MEtOpXNedUimV9PvuaocjPxvRVwawqsOtUOkliy4z85LbbBR5plcp+Vdu7OwEa+YXa16SwrplbL0CxyeEVDhx9FGwDH2MxaAgIwKzMUQJ5gGzJUUDEF5T2QolHHcHZDd4fl8c/XQBW7H6pUNG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3JNZaq+b2yEKbepk4pBdjZEbMHzZCyVWa5AHMoGisscpKlripqU76QaT2rI+?=
 =?us-ascii?Q?paw3uNj7/24oxFmCaSD2kK817YS+MsJYyMHLKY7e76aLs6BPHQhjmvEUVfmK?=
 =?us-ascii?Q?HUcOpxT/7AzDBuNAYDnZdmMPIRbmLBbyrT1Y0Erh2AO8G5rvJAqcIj3SO0ot?=
 =?us-ascii?Q?OpuBRCeacaLYLygh3Pc/8xzLhFnfXECL3+YGBMpM0bZGse40BS9nTC1I7fCq?=
 =?us-ascii?Q?oSDlBol/Hwh6gr+S6RwxBRfqTg9NdMjv36lOJ54SX37Km1k0wudg67X1277v?=
 =?us-ascii?Q?+MYihIXUQOv681KUJKEaAtjh1T39VppD/x0a01OOuKRn4kSFZRssJ54FGpwe?=
 =?us-ascii?Q?IjKW/d86yJcYN1CMy3De5ssCx7yn00d/E/0QgqSQQFsUVXCGnHUEOqG1wpcs?=
 =?us-ascii?Q?+PHwfJyxJ1edpZbNLPm0FCmH7L46Ex4E0WeTIY4663BM6TZmaM6KCwgTDu36?=
 =?us-ascii?Q?vhxMaNRt9KRKnobHXy0XusoUTmGjVSFYVSmmLxSXt+jrL/dUIIWcVMdBwEmO?=
 =?us-ascii?Q?YzkBIFUfvaqamEA0sAkgHrdWpNRbehN92K/cDPEezbE+oPdcIPVUw4xTB1M0?=
 =?us-ascii?Q?XIHmTkOd/rSgTjiH72BDIlLZD6Sa6/cww0pMr8Wq1TXlazx0eT5k+yMFU9CI?=
 =?us-ascii?Q?zyg+G31Y48d14MoT4jN3lnIUTiU62O+CA4KsP0m8/9gZYnPM3MDB9SXxPeBs?=
 =?us-ascii?Q?pAdtjo5vXn8qZM9tytFmE0EgKr8LdND/KvJcaeRBnKFPDpvxEPlk0kMvGG+i?=
 =?us-ascii?Q?36yiXQ62RRVze1PcW1rqeWhDSIvlkYFROkmenE8WODuJzbvEK/D5Sh8br2u2?=
 =?us-ascii?Q?8/2IC4gefuKS2+MZLPI//hED2XDNhaSsU2a4bQeV1m2Jblyf5Sp1wfKi5yWW?=
 =?us-ascii?Q?d0HItC/U71WUAyow7Nq+VnqxwY5uT1XLUg9SQetkiFucjvU5QBFYohkZmeS4?=
 =?us-ascii?Q?LlxKmqH1/y1i9gJZh7427tKlirKFFzdE1sfggb6pOWlGz1Mcieb+dNL7WZr5?=
 =?us-ascii?Q?p4tEdxrDhDdhnUzJIqPGg2Sgepc3vgwjMM4PleKcdwKNfZ8OPrSx57AuSHh+?=
 =?us-ascii?Q?NIqvGttWXcPT6Gx5+4aUQkcneJDHugxhDTG3SJ5kd+288QdJ4lJJR7EuEyls?=
 =?us-ascii?Q?OGi06YgQXZMSgS4Jd6x0KB2uuO0FQFnVfXrYgNX5gExRlLMUkF/c2nPwanZa?=
 =?us-ascii?Q?mEfrArm6zIsOP39050fFSCFgMRwYGrNjKUHvv6+3bTJfmzCgl3Uq4lxyyPak?=
 =?us-ascii?Q?wtXYkmADpUVSDHfYqOBnfThimMtkgYIJ0Y/+0w8wPgxRc4aNkX6Y5AOJ7FVY?=
 =?us-ascii?Q?2GXWPAHOH+7yFK2PRRSN2LvepoCZWpSWA0FVlZckxTxw08WNzya9LqpJ2YL1?=
 =?us-ascii?Q?axsi/oBhQFZLX4DE4wePWlp6llFDtj2P7qmM1Kmi5dli76WwEcoYUzPDIdmK?=
 =?us-ascii?Q?ShlbfC+2wbO4rZ6UHiLUQczJNbB4Lo2gBt2QwKqomBI2sZ9/LSVEk1nQ4uN2?=
 =?us-ascii?Q?WZRdJbD9I+Ao02A7A/fI5kfml1YkfTYgIEdxbA6d50sI4V8GKgU3TiE4rJqI?=
 =?us-ascii?Q?i3PBmkNIzYCwRDc/UjjaDcjAoFvORVyHh87wvgbHdiq4vn5K11eRf0ubUWp2?=
 =?us-ascii?Q?kziVBlHuY0hh5Hrh0tu64lW/kCk+D8Yf/EaSGz4elaRHrdfQbryOenoR6eJ4?=
 =?us-ascii?Q?LtMuPyHFXdgmTf1OtJ2mB4QUJaG85XByvG2FcHn6WVLaLaknBdLKz/vel6Pc?=
 =?us-ascii?Q?06mKqLDkNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa538ae7-cc80-4e0c-d369-08de780b81f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:26:35.3516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIKNx37EV3kC7Wsnl60RycIY0Ih2wCN0EKHuSddHqcyhINN+sMHfKMAT+GWTsKXAFIaHyNG7MFL3bF9j00D0ESdVBKZK0KgXU3v+sKzymgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

The GETMRL handling logic extracted MSB/LSB bytes from=0A=
s->cfg.buf_size using a mask-and-shift expression:=0A=
=0A=
  (buf_size & (0xff00 >> (offset * 8))) >>=0A=
  (8 - (offset * 8))=0A=
=0A=
While functionally correct, the expression is difficult to read=0A=
and obscures the intent, which is simply to return a 16-bit value=0A=
in MSB-first order.=0A=
=0A=
Replace the mask/shift formula with explicit MSB/LSB extraction:=0A=
=0A=
  offset =3D=3D 0 -> buf_size >> 8=0A=
  offset =3D=3D 1 -> buf_size & 0xff=0A=
=0A=
This makes the code clearer and easier to review without altering=0A=
behavior or data ordering.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/mock-i3c-target.c | 9 ++++++---=0A=
 1 file changed, 6 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
index 5c913ee49b..845c173427 100644=0A=
--- a/hw/i3c/mock-i3c-target.c=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -145,9 +145,12 @@ static int mock_i3c_target_handle_ccc_read(I3CTarget *=
i3c, uint8_t *data,=0A=
             if (s->ccc_byte_offset >=3D 2) {=0A=
                 break;=0A=
             }=0A=
-            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
-                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
-                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D (uint8_t)(s->cfg.buf_size >> =
8);=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D (uint8_t)s->cfg.buf_size;=0A=
+            }=0A=
+=0A=
             s->ccc_byte_offset++;=0A=
             *num_read =3D num_to_read;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

