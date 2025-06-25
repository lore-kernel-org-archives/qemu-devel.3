Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE105C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxS-00073C-Fh; Wed, 25 Jun 2025 10:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxQ-00072F-NB; Wed, 25 Jun 2025 10:18:36 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxN-00048d-R4; Wed, 25 Jun 2025 10:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uedP8Gdw6xsBTpJ8mHTf87FvYls1gq0taIMRzAo/oYATbjpxjWQwOQ9e5Koj4xZdyDVumIlCfzncnC2JjU8TTHoP+eDtUDKfRzDkoW+8cKWTZE4mzlSQCm+sO+octThh8ALnul849sMfa5h8HLhQEAFtq9dIXOPTUo9wLPxI2ArrWjkiZDEEJZ9/tG8agUxALWV/al3qFVoTGu+VD/Qp0Q9YZorWb/KNj1YrSjxzwDt2FnQwSDCsQLOH8jFLETsTRtCcRDoMUQOwJOIViO2BFlofETyMu8w1TgeVX/dOf/MvekkcBcLm7SfdkIREmVmJSeuG3E3sjxCtfYRStiH9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfh7Se1kARZecDtF6euTzhAMseWsm4JOPeYbznroIoU=;
 b=pWKBh/X1HdrtR2+pa0LvXAziuQYnfVhdLTi3u3GZXkEY/S+ThQLIav+t/IVAIlSKjEJjOMfQV+apnRF0boGscZpvauXycnW7NwPBdpSKRihNnk3AjuKwa7LK3JDtMjlusXx2u9q9x+vKA2Kqu6cREIchMY1NvuqKlgCtRmjF30LyBXKJxV8pSk+K+Tm58wzq2QjFb9lK+bRCV5iG/dUjKzkYSBfI1LQGAQO92AZaRiUmqxDb8sAO3gc0Qsgf+IUr/zCo4scKJ/Ne3kbT7eIYcNBDr1H12UcVPyEAkZrUy/spj2D+v/Uzzkgsw5D1enBN4kGg1f0UBbkolYem2pH5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfh7Se1kARZecDtF6euTzhAMseWsm4JOPeYbznroIoU=;
 b=K2Bk1ocVcLqb/T+SrPP+Mf8UJkbipifVK+bP1bqvHFYiO/jCHGCEvXl/smJUJblIuZbGmkyr2Df2JNO5NxaLTTXDsLZ8VhVnBHj4ZLKrjLmos/I2OW82qp9rIzdLk9xd36gnlQXUHBSOgU08VeW9MoURr9J1WDBzSCy+GKwwDD0r82lUWvZa/ETzpnZ/pvZMivm6gXkSkdjN+ybglH0zZYNBxk0pY34UIiT/dPuE+KRbIMrmgAQn5yZjQo8uPqPfCZAk37sG8xtJeZTxJ3qRQtP2NzbMwYNY47WgfE6OHVJhUAOVtvRoA3F9P2bX79cD9CtZ2j53ooN2YKVYZhFrtQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 06/11] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v4 06/11] target/riscv: Add mips.pref instruction
Thread-Index: AQHb5dwAyGhLgleYfUeNIKHxBfXY0w==
Date: Wed, 25 Jun 2025 14:18:19 +0000
Message-ID: <20250625141732.59084-7-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: b7e7bed5-c727-4aca-045b-08ddb3f322db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tVFuyQohyhdylYqRbIw/TK3pHKvt6kJuo+byO48xaSjSTNYju6GKs2g95p?=
 =?iso-8859-1?Q?1wrITFwfaftgtf1gfpOxUHcId5axzIvfI07c68XSiSlX3S7Lo8oDXt45dE?=
 =?iso-8859-1?Q?zpejCMbFx+j7/FSwOV0cN3nh7OR7zJuWb7isHyfFiHGE4Ynqk/ENu9HPQN?=
 =?iso-8859-1?Q?CJv1HEhfPgBWLzlrEfx6QN5PfxHAEYFO8XLIE02ZF8uuKq7d9iMf1AxaFz?=
 =?iso-8859-1?Q?E2sp1dCik/5g2BGV20fYIapFse+7IGyLO/mqaYuafNtZNGzJ6grhY+gq5B?=
 =?iso-8859-1?Q?pZZGElzhBL34TAQvzPbWMGZ1mrgSNhxg4pDiSEkE/0A9Kgrj2bI16AfMbE?=
 =?iso-8859-1?Q?NuFLR6pYpmWJXSV1g4Fo5H6ASi9jEQtZqTiFip+cf/UWcnoWhI3rje5aeg?=
 =?iso-8859-1?Q?u+mjenm31QF9T4uUeyO11Nqb0CDsKIFfiOrop1WpTBjtkHvFItpjvck3YN?=
 =?iso-8859-1?Q?S063gMWuARrQIgV33lNr2Ap+d8zL39mpyia5UXe1aQ92x0usKjPz9+2Tzh?=
 =?iso-8859-1?Q?CyRLMghXihwPf9SBJe1o8nhoY8xEf4kZX6TXdueZ/OYXnpMtgX7AotTW4K?=
 =?iso-8859-1?Q?tFr2IL4y1NeUBsiGqb4V6EKU0FugGrfIf458XQPhICOKHMlFx1c+c3TZnM?=
 =?iso-8859-1?Q?G0MLT7lcpDBbN/VEBmw238R+jaGOs/ozmUXqDIpTOdxxO7QfEpFhZeE7eL?=
 =?iso-8859-1?Q?AxXtLTbAm/6bZUn/ov1tB8N4ieQshYockikBAyEss/awIinHv2nXjjXZG6?=
 =?iso-8859-1?Q?HfHHTsvNG4bJsi9iVsIy9qU2YlWOTb/oEj57wR7++Sj9tNK/bpRGfq7aLb?=
 =?iso-8859-1?Q?TqmxLPYgEDsrMrUX9ylI+pfTD70o16/95CRJJXZpTeBG0lT87KWtWLu5YB?=
 =?iso-8859-1?Q?Yny2Ydw6P9/MrNm+DFpzti2nu/fOt7Skh7gyXeQZECE/X1qX0ygYWD6b+R?=
 =?iso-8859-1?Q?e/32oKAhSC043XJz7buMo9hQ4SJ12/wTUbH4ENqlydy5LtjZ1jVxalVWEw?=
 =?iso-8859-1?Q?IDZ56HAI83TfrWcw72uSzt5gzHzGc4jfkYHArVMMofM7r3gNjwCBYmOeLP?=
 =?iso-8859-1?Q?59vlP2N5giIAcmGFOaTNfGXd+WnCGKWJpZzhoztnNAVoqYOUfxtIC67EqR?=
 =?iso-8859-1?Q?NXMxpkqPtIT+rWYsEwKdaIcwDMUSdBOXe2YelLZUZpLN7VFhV3+J9HJBUL?=
 =?iso-8859-1?Q?WILh9FbXACUNGQYGw1EnWXf5Zj1eFXwiMrLkHtYLcvN/FEL/oORdKrQcFl?=
 =?iso-8859-1?Q?cV0Z/V+E97YR+VN2dS1I8G9uo/CDV5OZqzwJsMmb6zqOcVIILR/Ndwf6r1?=
 =?iso-8859-1?Q?KytMK3EAZk4L5cITqqVHraKqlgxQp2L97QB6VJmIi7wXkGHeFyohvF6B7S?=
 =?iso-8859-1?Q?AxluvJxedPPNjfyU9ZLhaJgZ60A3rUJ3dA2OLgAZ850puEDFOlKSkhzLlw?=
 =?iso-8859-1?Q?SuIwgjFNtXa8v0huNuclVk+xsi+mLBux1iBUA+q/Ruy/FsxbEEfPbKcPOk?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rEMAqIw4LY4CX0fXbQdn8y5MbLVePN/wiSbWOzvyuVscPHfHi+LU3t9Hbl?=
 =?iso-8859-1?Q?nOMmKTr1XGyqqDrZHNp+TF6QTzPcjjQP1vz5zxlEDpacoBLDJD3DWzL3jl?=
 =?iso-8859-1?Q?liPWiqu3wJPN899CbN1l/SaSYVAkNa9F28/3+6H0bb7YByiJ1yitxRdyP7?=
 =?iso-8859-1?Q?ri6VGrBT1hYhhEzlnt7EYufafWF2I77Tiam6e67h72nH6sNaM+8z2avmE8?=
 =?iso-8859-1?Q?zM1SR3JZXbc+zZbBp3lYe8sWsmjAGD3ZuHpXVKNsz1XltwvGGiT18Ln2qH?=
 =?iso-8859-1?Q?qReLcPqKv4R0IL0Ho+QXheovKGuTpKZsttSJ572kOOpwEv1ENGyQtGcLg+?=
 =?iso-8859-1?Q?yLsTciBoa8/LVKkGgsqPlDWQHwhvPRF7ff1qHmveeejfEqZrEHxYOjyQTA?=
 =?iso-8859-1?Q?x/rPgT+BYbs1QeBkXP7lu7vjSW6NFIpYOEogs4iU9giEIbGZHiMtil73PA?=
 =?iso-8859-1?Q?rTI6tcUPmnnPYhJcZx21M4omQ6ny9ebPFqcK8oMPqYzAoOXw1InIdDGEe5?=
 =?iso-8859-1?Q?nD24kFjTBbA44Lyji4eFd+DnYeE9389/wxV25AUxa8s21tOc+8oA9uiI1y?=
 =?iso-8859-1?Q?Gf+VlJtk4GWha/h9U56XXXoBKuS39Dj98k85GH9F6OarVMrY0lxAWEB27O?=
 =?iso-8859-1?Q?tk7U2bZH2I0xDt/K8uu5JCn7rhTSbOjQwsLCX0KOhVz/cSr11W/04aw5NJ?=
 =?iso-8859-1?Q?72qxkAeambROjbPwQhRTj1povjd5DdT2pyoQx8H2Pvf/IBgRAlv3OAxLb8?=
 =?iso-8859-1?Q?/hM18BgI8lmi+15XXyZwo35+F3YYsWSARPM487ElN/CVJvs9R8yK5awxXb?=
 =?iso-8859-1?Q?p8UYOeOobXbWsVk/GXT0vaTCFtmZMbEHuTB+TaRc/8499rjeB6CsiZzMGO?=
 =?iso-8859-1?Q?jQxMYv5UMRbqpP0E7LQhl742F7DDBJ6UWAiYDm5w4OrEgD5tirK3cKHm2m?=
 =?iso-8859-1?Q?Iyo4Q5McqWQaMZijaPvacdY4PjfKb82QVRmDeM+JSa1NQduIs/9q+QcCdE?=
 =?iso-8859-1?Q?lwJnrHXW3Fl4ptXiX8R5jFH9Zj4fFelOkDQACpKsORh5vNwSbm0v/zezXP?=
 =?iso-8859-1?Q?4leHmLlNQ4A/HnJOFw1F8nIkHyf2rlPKKs/VP6F8RVDVJFAin3D+elk20n?=
 =?iso-8859-1?Q?wOUXlIZwiUpGaeV6tEO49897JPNpd3nEVGsZRuNiTjZ/punLLWaeuSgn7f?=
 =?iso-8859-1?Q?W3kOEuX3Wyl9p1K0Fkz3v5JC6XIyAl1V+GazVM1MrLoLbt9ElBiGupN7vD?=
 =?iso-8859-1?Q?vZ80vookuRSvhOo43DeXpSgznDgoCL+7ylV/25GJS+kyla8fQcW+qWit/1?=
 =?iso-8859-1?Q?o3X5GgfNibdbissEK7WLS2Dvf5nifSbjHjdXtXk3m3KqITElnsxbW6lB78?=
 =?iso-8859-1?Q?lUZ//74PBUQiCvOTYN9Ld2lK8djJJTmHaOWgJWMbeIJHqh5r5xBJPRV1IJ?=
 =?iso-8859-1?Q?B4ax1YuikRj47zP+fD33x7tPK3eE9Cjo0Sc89Exi00NOgdxFGyQqHQBb8z?=
 =?iso-8859-1?Q?KD1IMaz/d1WKZk/XUjSyAye0+8N56+E6wxLNewXdwArYzw3PoWzZNbUR0n?=
 =?iso-8859-1?Q?Uij2CZlAA28tKaB8JT2p3+BdmFfudTuQOt5vAcnJay2O1L47UffzLEKK+K?=
 =?iso-8859-1?Q?5ysVgJVlOW6FWoY4Ef286voUSRIhdweSQbXANQ8xEKKNqiNjKUj+pNxLvo?=
 =?iso-8859-1?Q?ZL38cPkaBgHaw/0/F00=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e7bed5-c727-4aca-045b-08ddb3f322db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:19.9259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /p+cHrGNU4E1xfeLgfdZj0sto678Xgt/G+HSCgHckEi1Q3xr6xFtJ0jLgyokQGJv2hNf4gOSqsobX1ofEipLqV+ScBDCIFbwuIyV4eRhT/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d48fd4df4e..1e5194fd06 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1361,6 +1362,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3180,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..9734963035 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,6 +22,7 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
+
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index baedf0c466..9ee0a099bb 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 269b1082a6..6555a6062a 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -19,6 +19,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -40,3 +46,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index cb334fa4bd..697bf26c26 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

