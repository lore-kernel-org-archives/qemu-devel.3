Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225EDC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfr-0004Ba-6a; Fri, 25 Apr 2025 10:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hko-0001YE-6K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:05 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hkd-0001Mc-7e
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2KhzG2UIRjvBYxP4ALJPzl8xTJXb5uDeA8pp9gvkK8WKVctXn059kunJUpBT5KMF3KAfcs79sib8JJQvJ+lfatDuQGgynQEckGeniGALSu3zvyG+zonE9wq1eazDadLHnCfXJw6nyKhT7/+NLYqC9xaSPq+bbnJX2uui+ibDYyl60T7LHP+o/zLh4g1BEK04c5xvQ2XdcS9r0eW+2cPOxuEwGleR6CoS+rfXWIotCxi4g+Zjxv8y8uUn2TZgdFdDG1rcQxRF3AUDm4Lwz75WjN338/ubBYAfbxJ/qZmlPV9hRS9wHbDENsNPkEtIsckJztWA1138PZH/ReDgBJ+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZvM2bYUn1pvZRs6bp2f/ONMZygBOqWh0oVz32v7nAU=;
 b=R1hF8axjVjjI+92AA38RzoQ4m8e2iRYsTNxrau0d2a+GcMTh6aomCSqPgwc5M7v/BHI5UhZ0RwdJsCH5BtDhtdMhfqrD2psSDaXebBUMy4ZleUsN1m7eQ1fsUn8hSHRwt0tx6nYkjWOGQyY5qBaaxJJqjRBJYyj/cwpocf0+9q8ojWXV1XrGZDN0L5rNhoe+5vyFwUktcadU4pa2xZJ+cohgnFiJQ6e3TtnjFeJDIvS6+fsAbtxRywfXssYHZQaS8Cul2rOysxney1dR7LSkBHsP5EZbX4bY/hhxiiOFvnaDaWnEIwoFKUUv9EpF6iVIvsAE1sKT5vP1/AJDDSt/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZvM2bYUn1pvZRs6bp2f/ONMZygBOqWh0oVz32v7nAU=;
 b=AMHvovVNLKDCmw95Q31U+WMEcZAf/A/QT6HncsmDwODRgzBR7qSD+HYN6b9jA9wnefm1wppqENe2kOU8htjhEVszGliK6bzsWozA7lYkfTmlrtc9LWUXooQxKWK0+TvHNJPtXf8Gf+Gp8RkO0nHW6yN9OdcagfmQkfbAHjTEvJi3prsgFbjN/z7xZaQwGkEHz3pUsYWhfyIO1hK5i9SRBm1Df/2g1sIt8NA29FrBWUp0coSpkWLHp+LQM8s+eVagc5AZTM+X2LWGyVjtqZ4xrnXdKhU8nMW/0jfdkshqTNsvrfJgBjjbyVFCdMbNwsLwa6ThJ0WxvvhbVq0YvbqSCg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB6304.eurprd09.prod.outlook.com (2603:10a6:150:e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Fri, 25 Apr
 2025 12:01:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 2/9] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH 2/9] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHbtdnQ35oqYpmjPEWW8r1TQ6bbfA==
Date: Fri, 25 Apr 2025 12:01:44 +0000
Message-ID: <20250425115912.912889-3-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB6304:EE_
x-ms-office365-filtering-correlation-id: 6dd6d8dc-9403-461e-e0f7-08dd83f0f287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Mjc8a/wd5ytq9DnAv6hbfaoHjv9zZz1LlhX8r4+FuhtD+XYRRNfenXzCut?=
 =?iso-8859-1?Q?8xvIVvGK90/Fk6zVqHk02zuyIbJka/oJmpYrjIhBEyVEXL4F5U9oH9jlsK?=
 =?iso-8859-1?Q?8isatQDa+N4cQlaQkd6GuN5lG90+5KisIOUjFYTsaEH7ZLv1AZ0OPkho2L?=
 =?iso-8859-1?Q?T0xSswXLRtbhf6XeZHcphqeFYK6GVht4UbWRq3Hz1zvCjaivAaJtYfdWNl?=
 =?iso-8859-1?Q?kJww/NapKqltlNSYAbyj/BE5SEoJjcpdrKj+BGd7tg+tp9kbjR96vHQxIA?=
 =?iso-8859-1?Q?1VX4K/VuctJAA1YXQ0+dAPMgaLNjNJ/KTmB/ckHJBa+RApgemWhp3OMEXh?=
 =?iso-8859-1?Q?Ev7F3IBtUpIAhrCSpSJtL4DEyzwIcBGv7AYHB51SrJd4YtRTB8QC6fh2pq?=
 =?iso-8859-1?Q?CurtB8uocRHBjZtarz245BjGvUJOqIi8g6tdGczUAZ1jIYZ+whSEbeF5J0?=
 =?iso-8859-1?Q?I9b5ENa/LKiHIbAda8O+LkdcGJOkmQOyeq7xAogmdmKIUe+/faF12IQ84g?=
 =?iso-8859-1?Q?sqnem09edZGcrrQx7vNhjFyxSwpcJ+PeS/i+g2Kb8E9ZCNGWwHGUpzoRdi?=
 =?iso-8859-1?Q?KN3086+oS2U3l1C1+xwgco6kk9GfPF0asyYDzQvuiXFDVJE2EwOEWcd2oF?=
 =?iso-8859-1?Q?MvUnjlQQEWYg24dfgwLhXB0FSuaklwnUbWqiL5iWdVL8zhmpO2yfUaR6iU?=
 =?iso-8859-1?Q?2Su90ENMLWkj6+sEzGa5fy+OU6Tao9pYio16v4kWkq/FF5onVNFoY+e1pF?=
 =?iso-8859-1?Q?RjoPqyOFKoo7hgP/KGEIKn1Q+ecegKXQ1s3Xq8h/+3tWDwAhuHbG8pPQec?=
 =?iso-8859-1?Q?Wz1tBelZIVvInCtzfo0y5FJFax1rAlC34jCNcnm6hcNNnGvj1Qg+LAQ/RC?=
 =?iso-8859-1?Q?j0gCyrHuExIzWWAkmuV00SfNZI7F/GDQpttPjaJY4AiAhobY14+8Erdkp+?=
 =?iso-8859-1?Q?j5A72VSBEArLj5CuSJaxgzGGLZmZmP9EIvSRjrs7w6MssvOJPaLRteoarQ?=
 =?iso-8859-1?Q?MydF73EZkirTliecrXxxX4hBTGo2T9VYdjuYyoPToqB1UaZoLEuLQavs70?=
 =?iso-8859-1?Q?u8Si6EAUa7TZ2tuiApEZ2FJElwPEY41gHy4l+nAdptnaxRcVJdzrHidYJ7?=
 =?iso-8859-1?Q?4jmgsetnr9m5Cf6rb8XE3ArzagjhaFE8Yq9RJzSy72j9tCe5kI+JWMhJ1u?=
 =?iso-8859-1?Q?Ceng4DlzKFAcFAKbMHjrRiHdpODzlVDv4ICIIN9JhK4LwEt3ViBw6mz5CS?=
 =?iso-8859-1?Q?k8bwBuTTzD6q2mhbwUnwWxOMKWWnnHrsuXgMZaI4syrfTWFnwM2p2PuHru?=
 =?iso-8859-1?Q?iXMdnrl4n8uDrzsn5d3aCpMP/r76krTy2Xz/3SBfV4B60DcwXlbkXI5Wyn?=
 =?iso-8859-1?Q?/RT5KSPxBdep/mjx4woIudKuGd0NKA+tn4xwJmav62IU7++4Bqe+WJoSmN?=
 =?iso-8859-1?Q?6m8cS08Yylumz4TvvECkG5BxFUtCGJUuPHVVxN7OkSL31ypXZBOLvj1CYX?=
 =?iso-8859-1?Q?01H6lNeIB4Zh+n3p2UBSYFrrpcxZEDeu1znascW21ZP25/h2NWBpZ0r5uQ?=
 =?iso-8859-1?Q?2cC2WCo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oUnEeoCVyO9n7zg1qmOCNHlJA/xcio2rbB66JJOvZ0se3U5CvZUV1JqaUM?=
 =?iso-8859-1?Q?nayzvFdGV/hjo9O1BYyoUhiyXbty7xQ8wvboq3CHaqzzy43Uezm9xo1Akn?=
 =?iso-8859-1?Q?LfIioupiTjy0uk+MCHd3mdu6bod/r7J9QB1A9ghz4qXqx1flQY1CKLCq51?=
 =?iso-8859-1?Q?IoDjPF/lIjnIARVL7+fHqXgmA4IS1kYnxoGC9tXHEyqQBh9vQg4pjAdM3w?=
 =?iso-8859-1?Q?z1TMhIePrNxaD7zajOGFGy7UlHs0b97TeNw3SLVQcbHZ4qfdvkzbqpYn2j?=
 =?iso-8859-1?Q?P0kpXErY72peCadHZilfGy+REOPo6sx1MnL/kK762bzf2JWKiZK4tL3zIq?=
 =?iso-8859-1?Q?9v31K88cgw95JhV834f0YW6VKPCZU/lfk1aZYXEkXjyJifzdExZMrGXSn/?=
 =?iso-8859-1?Q?+2+74pqdQcxHmAdov8y18vKKWXGcfg8Y1vg04tAxmZYE+GSRMZaBdbp665?=
 =?iso-8859-1?Q?9OuCuaKSLVthuuhNTm9T7YBRLzlY3/xgt2DVR/1VTcUiBrZdNXD8QIKDby?=
 =?iso-8859-1?Q?DTiJ+5oL4l8BfM5MOLm2lTwxyS7dPRBcVJxH6mBkbID9q254xS8EfslOjE?=
 =?iso-8859-1?Q?2ouJo3P2hjQ9Jjm3uEEsPS6+EJSXLPro5cbsChbQtRRR+vrWHHOi01KQaH?=
 =?iso-8859-1?Q?hTB7x+3ZnMkCWvrke1C13LxuqVEdZQE1N2w2N3HKs0D2OPpuvqj+CkvP8u?=
 =?iso-8859-1?Q?M9lauDHHLSOw5YLzsT1zQSKvLSFXY2xrSFWLK3tCxvDSASmFrB3Mko6sPU?=
 =?iso-8859-1?Q?EqJpTSGVBraCgYLuxQLv8ynkKpz7xGkvpS8e7Pi6bx7eNSvosJxecHfZnH?=
 =?iso-8859-1?Q?hNjZo7zYe1MDn2j2dN3uZUgck1cVrv5nmnDP49F5DjPNwGRKcGLhWnNelF?=
 =?iso-8859-1?Q?tcTUgtOnn1v2zuVM+oMo7IpJcamerBC5XS9IbjB8ZOFW7j5NpdOM2nKTTs?=
 =?iso-8859-1?Q?FFiQ1c0Wge1t/OduMBJkUly50iM0wOm+3ukDOmOTJedaoyvtZI1BLjK5JD?=
 =?iso-8859-1?Q?vheBoS2vQtbxmqQL1w0FgATpzVprGSJbp1+CEuEF7zAt3c6CiJ5umcg33J?=
 =?iso-8859-1?Q?CkwkBAcwSWw5qF6Hi9nyhpwEvit0YiWyIuwcZDWj6zsDiGamWCVOAwpZlf?=
 =?iso-8859-1?Q?pC4Bu/QehKtC2H5Nr5jyOjU8J3+sJOoIJmHTQq3rT/aILI3sBq3LHDXxJW?=
 =?iso-8859-1?Q?wyYkZF+MzsyLEocOnX3A9ov4MPPr/LP4Ya4wiNlwgT6QrBagYPXm0IW6iJ?=
 =?iso-8859-1?Q?gCIRaRzbPMNYQWjtuEegx1Ag3LMz/QMtcp9kqwzk8JBv517m6xVICcQkTI?=
 =?iso-8859-1?Q?n43wsDJrRmyek0ytcIxACkrnJImx1kf2GQY9EdrBEZAqcayEx/Rv/z7BcP?=
 =?iso-8859-1?Q?KFOL1241GaN1k+vNbiqsL5Ed7CNRB3q5dmggG5QnW5zwnIQsowsIP9px56?=
 =?iso-8859-1?Q?XTw/rZP6O5Jo2c6wDHImvOnqImFD3oTW9uXWOkFToKNHk6932SWOdPST7V?=
 =?iso-8859-1?Q?/1srcV+HiD/ADI7BH7RXkhkbhmfPRkdO7OsVxfJxZ5qfvCa8RZeZ4p5v7J?=
 =?iso-8859-1?Q?9S6mdEzxD+QJ5rc0SHwjLLuK7T6m0Bd9r1Z2KpCUAlTMIdA030xTJS+HTB?=
 =?iso-8859-1?Q?bu5/R613/bwPk6jOBQdw2SQLEzt65rKfJzUGGKNswJyTKVT/sWyKEuC3oa?=
 =?iso-8859-1?Q?eS+dOuWaRkq84s5HFjQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd6d8dc-9403-461e-e0f7-08dd83f0f287
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:44.0707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zskv8PyPktlbOYohvez8+kQc/2PXclH49PN26pBqqGzxaYuNAwOzjdoT0ltjKS/Yq0bW/ad+WlLX+vk8gs5UGARu4PPnR/9/jyZNH6ogw/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB6304
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

Add a new function, so we can change reset vector from platforms.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h       | 1 +
 target/riscv/translate.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..6d0acbce80 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -632,6 +632,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *en=
v,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+void cpu_set_exception_base(int vp_index, target_ulong address);
 #include "exec/cpu-all.h"
=20
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d6651f244f..2b8ddd184f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1433,3 +1433,11 @@ void riscv_translate_init(void)
     load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_=
val),
                              "load_val");
 }
+
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *vp =3D RISCV_CPU(qemu_get_cpu(vp_index));
+    vp->env.resetvec =3D address;
+#endif
+}
--=20
2.34.1

