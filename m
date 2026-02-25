Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC4AF357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0z-0004AR-HA; Wed, 25 Feb 2026 05:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0f-000434-9T; Wed, 25 Feb 2026 05:20:50 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0d-0002vM-PB; Wed, 25 Feb 2026 05:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvCksRD1gRTyONa1v4ravm9Y+QWmManmAR+0ShMnilj7wSrZC0Ydwe1ZYM07FA0v7iRe+BZCQFrz4MupLF85UA55whC/6rLF4pZj18GHlbatURz+Bcsf2s+P/8CkDRTOr7Y3smyq9Fl7ugtMbJJMOnlo0Rumlt3JzVXJFG5G3U1NBn1xCH4Rqo4koeXDm6zK+VWjJDY0iMY778aCzYIAfOx6LKXqs0he4GsZ+hFnrDfmPze/lFCr0n7dNnzulKkm9tg7ysNUO5gD66VKfMefe2x13uZ+adjTJ5yeeFWCYGNI3sBrXaA2wmakGgXxWRALg2ECjfUvpSftZBq7rfUD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qYcOk5RcLTBqX8AM/YGsdfZEEqdLQbnU20PvHZg2NU=;
 b=Bcr/9t88P3TYG1lKdzumFlKlBrEbGBW7ALOeZpPtPsCtkLZNuvG/tt0M+Vvc/VYkF14lakQRiPKPNZVVS/oznOJzAWe8vvmzRzRzYT9X+JvIreeVpeiKxMoKe1gnaqHlhrzAzo0Eo04ZzoGp2OrnIhPnnZU3cyiA+ewR2V1vVMhKUMVwYporzf1ychn0Sb61N71+p8q1sFeoBqIw4r4lweVdoQACElYhTwh9WNJ9ABpjnwvK9WnKyVBgszYgtNu8uwTMcsaCMgboMerm9LXheMVISezcmDL8PC4PCNQ3K4IBm1UwtCSFR3M2MAMum3U/sELobDqO6eAIVd1kNLpgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qYcOk5RcLTBqX8AM/YGsdfZEEqdLQbnU20PvHZg2NU=;
 b=VDtvk8MW5wJkcYLmGGBsx2Ud3yFQYAxQ+ySdsC/T0Nwf3zYy+CS0Hd3SCeuoM/dZO6lO/8+n64TG3CHIv3vQ48MJLHIcfaO1zpUMQg//2v4XboaiDTyuyBG6s1SYSTr0FwYe1lc8D1lD6QXumG7BvxEj0Q094/E6fjMPk0TQ/tLOg875Pb6F1WZdOlE5/T2JhQJN4rMphGArbMQztWXzmk4UouWqyHxXT2jtsBCw4laAtD8smYyUZ/wDsXevQK8STLPvdiAlvF19EnNx9FVjwQnbEneJ9lpRE833HmsZlIw9tmwcb2XXo4XaczGchTO3daSVq2OqNZxVyKCdfB0ptw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:31 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 11/16] linux-user/riscv: Disable vDSO for big-endian targets
Thread-Topic: [PATCH v2 11/16] linux-user/riscv: Disable vDSO for big-endian
 targets
Thread-Index: AQHcpkBddx7Rvk/fdEulERCJwy6abA==
Date: Wed, 25 Feb 2026 10:20:28 +0000
Message-ID: <20260225102016.200654-12-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: dced8729-5f8a-4c3e-e0d6-08de7457811f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 2cNm9N4HJRcWcmpl33QJNX5cOkJ0J+fHaqdqKKjNQ7yQjyC2ndVC+EVjLZiZEvTox+1ZxkXjMNejejaTsimK9E/pgxlt62tN5aAPCg6Ol3wBDR6sXlKY8BYBOpNP8Vm6kTFNPgz4hsrkOVIXwMraXBtlQ009AH8eO6Fgk9WwinZGL0lXRGe/bdKRBPEkTjt4qYiFr53rQBClK+Ux6J9J7E85+/TAHtq4V8dqTrNNbs8ff6MOoGVu5Dd2bT2MZFwcwEMwmXDp2qtWPtHoQ3iKZ7X1kYymhOTM+v8/X9iHNbgArxWWiGV7vRcqq0apzNbZZIcw5nmotNtXulQjPaviUx/T8OKKYI9HeX6LsfG/8cOdHguF7H/DVijfRX3wYR3f4XsTnbkFd/cz9jULY+M+8D4Sz1A8l6fUgMbG5pKQ/U1Gw0KrN8zhqApFY7fjbSXGY8viHRj9ONrBFMFmaCe1f3DNMAWn2dE9eP78bfEkEC9QApk+eotx6rZjqKcGYl/7gyTly7lcYC4CMRR3/LTM8likUPEhO5TbaYkk/vfDS8mdfXteEllD0Uw3wCmQBDz5p/BsWCtLUeEABy2MbE2gCj8ObPu1KKxp7VNzk2lIe0reXYmDQ0Tq7AZHWcvOBaitp8jgF5+gV/foO5fFVqD8v7umwqtg00UXEaGm07PChOwBTLW+RKfzX5dlUdfJFV8b2/bplUx9KeBjU1OwqTerZyrt5Avo9ZMYKW7I1yJqWEfyInp2k+GmD3tv+8Xw+3ctlcJdVhCXgh4L17khYUqAM7zr6rx8JbTVMFbO0UanqN4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SS2nMvv+/nIq9dO3rhSkAzyf8THZ9opf1hak2JejkSYgIzZaxg+BAre44B?=
 =?iso-8859-1?Q?4jiNpl0rpf77lx1K5D6zSC0D6xIxBm4DljDkTaaWdZA+/7xdER3FBAG+Mp?=
 =?iso-8859-1?Q?fw56cLKuN3sZJqL28yKAXeTru/E51O7q65vFrGlOzQ1lVF787AKHcnAJ/3?=
 =?iso-8859-1?Q?gcb1IQTaZ0vQ74ObJsb2YD7hAhGyK4rF8Su5QAi36ZGb4ZpXlGVpKOr3xa?=
 =?iso-8859-1?Q?xgK1HKW4KKfuMIH8JPvU9kjg8SYb2zBWORsZqCoMNwHJw6UrHwJwUSU5c1?=
 =?iso-8859-1?Q?qrVzN5QQX4TZJ2uiYYeVXZF4uzxvRqWAwrHB9M5l6owab0nYL7JJSj+9Xf?=
 =?iso-8859-1?Q?vCDIn5uU4GiBv52uPMVombaUH4nUSZ0UQwPsHtBCgb7mnSWkpuPf3DpNWL?=
 =?iso-8859-1?Q?VDm4rYAuNceLDTOnAUU8SiQ9VISfbuQnKG3E6c18LyH95RL1S6g2ptY3jC?=
 =?iso-8859-1?Q?8zod+dTEkTGGc2b9+Soq2SWZcj8da609Ap6dHf/Nb8G0w8E2AgWRk5aGYv?=
 =?iso-8859-1?Q?A0WnSFfqSt0EAu1qpHAZL1NlfhqT1TeVL/RcJjuMSpZcJnp2hsgAKOuiyf?=
 =?iso-8859-1?Q?/4vSpRjv8SiAK7YvewebIJKFHcyLV1hNLL0HivHkKwwHUq1K7IJagka1zV?=
 =?iso-8859-1?Q?hg6OAM74jEXJR2WQzFdaRCdVHOvujG192PnoYycbwKAXzxZiVaxNpIpaEa?=
 =?iso-8859-1?Q?KsxvTyJX/NMnTz7xp9QOg4tQ7G7u8f6YroE23nyu4/JEueQoVbQkAlt4mL?=
 =?iso-8859-1?Q?2F/OuMMQDY0hhiWMbGn1RtYKz4zj71AO3O1boi7aFqQ2tkQ0g6fEMwsO+o?=
 =?iso-8859-1?Q?4eIMJMshIsBESUAoGettJdI8yg/rMPmZmaaux4HfEvNOMcC9Vgcf/9qDkI?=
 =?iso-8859-1?Q?rba4wIvfZ5ujzJqnRr7t2oLPeRrFIu8Rx+Vrv1lPoVI7rXDTUVguAi0gcW?=
 =?iso-8859-1?Q?NZa9BSRWaRM7+9r3QdibLqsQURKcuPMpARmhrWKDhBf6jkM03VrmpiNnp2?=
 =?iso-8859-1?Q?NR++RW956kHxdMrTeVfaczOhr+mjBBXvecQSC0nmv49x6mVJXra75jJKp5?=
 =?iso-8859-1?Q?KSnP6WMTe2D8IRooiwT+02BKmC5dIo6MngNxpupWiGk5k0BHucaMGCBhNj?=
 =?iso-8859-1?Q?XzrylWESJcufiH017zR00waiTNulBto3mujen58iLSZgGxcgp41dfGAXf7?=
 =?iso-8859-1?Q?8AY5evESDskj3FUHGSH3DaSp/DE399wP0XwURbU6Hdq3hRnn207ZUecKK1?=
 =?iso-8859-1?Q?5ItVxN73tYX3zKS74HoH6ABKiILhWM6JciPIVo177fj2Umh4WTm1PflUXH?=
 =?iso-8859-1?Q?fOmnQ9O6/fgW/OMDCPHxM9EY8xj25NWjgL4ggYlgezz5rafi51g1L/fVf7?=
 =?iso-8859-1?Q?FApuIUi9QIXDIoT7+ThLT5M9WYL24SNz9m7RSGHlusSLW9jGqBRObmao6v?=
 =?iso-8859-1?Q?fKzzI1GNWooaa0Ss4MbaYPbc1MA8C971G399+WFKSN+wgXb+5L6Vx+AljS?=
 =?iso-8859-1?Q?MHEnt89dSGkg4I9U4URKCn7omp8xjdwCpRtOj47FNmXcfhJlfmGu+qK+88?=
 =?iso-8859-1?Q?d/gup7hx5jLpTsY8b8JJ7GboJUzNO9QfdlTnhgch+SmlUeTtfISpedmtOr?=
 =?iso-8859-1?Q?/4OvU8vOZWWZD5iDthbgyT/KwdyJDneHZSVI/25jM/SDuZQxdkX8WGdpVw?=
 =?iso-8859-1?Q?T/yLefthBtdu7HyEbzDO1+yjICwR3zOwKybWZShAeDM4qm5qF0zrsCE/Ar?=
 =?iso-8859-1?Q?DW/eEnPHJDA+7QZupxaaAa5CJConTAYLaq0/vwX6p91HmHSnkphvQ4gMLs?=
 =?iso-8859-1?Q?VdH5kcJ5TBvVelqg9kp05kSXhj9exrctVwJdoZGum+8mta7sG+tF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dced8729-5f8a-4c3e-e0d6-08de7457811f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:28.3800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D86MT2+55c5WFd7NTex5OkAov8ExtMp7pK5/sVsFm3jvBLMR1b2BSr9DH0F541p7UNHNc40NHnvYEMd4VJc+DGYMRqiS5+A78ppQCAJrTwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

From: djtodoro <djordje.todorovic@htecgroup.com>

---
 linux-user/riscv/target_elf.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index dbbfdf54d3..6f416ac3e2 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -12,10 +12,16 @@
=20
 #ifdef TARGET_RISCV32
 #define ELF_CLASS               ELFCLASS32
-#define VDSO_HEADER             "vdso-32.c.inc"
 #else
 #define ELF_CLASS               ELFCLASS64
-#define VDSO_HEADER             "vdso-64.c.inc"
+#endif
+
+#if !TARGET_BIG_ENDIAN
+# ifdef TARGET_RISCV32
+#  define VDSO_HEADER            "vdso-32.c.inc"
+# else
+#  define VDSO_HEADER            "vdso-64.c.inc"
+# endif
 #endif
=20
 #define HAVE_ELF_HWCAP          1
--=20
2.34.1

