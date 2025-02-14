Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963C8C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tizeA-0001Mp-Gi; Fri, 14 Feb 2025 12:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tize1-0001Lw-GO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:31 -0500
Received: from mail-am7eur03on2072b.outbound.protection.outlook.com
 ([2a01:111:f403:260e::72b]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizdx-0005Gi-JX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV1AkS48LEnI7mZlLGc5ZOGfLVEHn4Kx0JK6SJG2kuZYiCGz4P6xRHQKdCKeuIkhzf03KhT2E32AINhc4S49PgPhgSR4gKGi8vpP1dSz1UwlDYs1phrMJ3WNy3BvFitoKKgrHYCY/UW9VFTk5GrbBkkiCZ8JrvBDV2eVeeFykmrAIMubvOxaNxUZiu0dnhAlhfdRo02JI3TqrER+V1RBa8noBKhDjw4syT3Tfdopp526jwKT/e0hSPOMyRZtveGcUSz15rPPdozJM1ud5lqntzqShJXHtYxYHeK+b8HXJDC7nx52xIVApvcK3Mg2rwkypFnNLL2vBe7k2MGc6XnJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h+HLz8wLJ75mUnulh9yDjdvRrCuCzXbJlCtqWuCWkE=;
 b=AhIVVmt2CVVxw+jqJi1+T2L0GdqAHynXoPV3jKQQN07xhO+pXaRp7C22chSOuo78pKJKVkTf/f2yb0MLzql3LLL92xv5CQdUqmBlUDEOhGgbTLt6JIXMVQ0lG4Dvb+LfcBVisX1fZEkPlXfzri9l3Qy9RP26VWSmZTB7eS5c1vMgXMbZP/3HE2B0GKRVtKvaVlUqXpEVm9feK5DswtYVa861gxOvnLBrq9+TQy5cZKyfT4d7rHMNjMPhWBasu2Rh/l8ffo9EtZxPgvXsIk3cJlfIofpF6LYKeXh/7JBdAQP20BaJ8smzC/gP1Dso1O9bfXkI0VdpP/X9zFbx7ewjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h+HLz8wLJ75mUnulh9yDjdvRrCuCzXbJlCtqWuCWkE=;
 b=iD/1KTZ7l6SoHu/4hXs4opy5q0Skiy1kIvebcQOH1Zfv6EYXIsyE6zRMxOaWGCW8Uh08swlvsI1cQTvt3sxpB42ZGgvsVtzCiuBJojRNOUxCZmqXiP6e6LIexwvjf9ynd1TSt+yHgCJ2rbIlYYji2VbheVjDucRQcMOmnxiG1XCBziYgA/2nSs1rfoLNHIFpNf4v62lTI6HIwMY3mTzZo0Yy+h0am0v3sgm/Y2VnAi8WDTI0o28Dh/M9zTBWehBB2H7E4cwf+jR1NlfQKCGt9biF6ia60u7aSIVObruFc/0vAallP1EhQkC6Ho7OF4PZX8GR7gDoYidY3o49J6A4Fg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PR3PR09MB4329.eurprd09.prod.outlook.com (2603:10a6:102:3c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 17:37:47 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:37:47 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Subject: [PATCH v4 3/3] target/mips: Enable MSA ASE using a CLI flag
Thread-Topic: [PATCH v4 3/3] target/mips: Enable MSA ASE using a CLI flag
Thread-Index: AQHbfwcpy+xBSuMOjkuTAxsblrR2yQ==
Date: Fri, 14 Feb 2025 17:37:47 +0000
Message-ID: <20250214173702.2308488-5-aleksandar.rakic@htecgroup.com>
References: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PR3PR09MB4329:EE_
x-ms-office365-filtering-correlation-id: 67706647-4f3d-452a-e64b-08dd4d1e4c2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MEmIWXe+n+H1G7uKeJT/FQqTFMjyDwhjCHanjMSiES4YUE4tUItQmosxPw?=
 =?iso-8859-1?Q?hC+h+x/A/p10D/mkPTyTuwIHfGvUgl0slG0J8g4W4ixtueYh1aJkKfiwOw?=
 =?iso-8859-1?Q?59rvvm15GCdAzyHhsns2CsTYVEsOrVPflh3Rc1wYl3N2DPJYeYmL36Ya5I?=
 =?iso-8859-1?Q?mMYXUnMSusvNXRxp/QXbLHjMGPllDP59yhkmctux41LKXHxVrIhUB6JKcG?=
 =?iso-8859-1?Q?nZmCbLPWUnAlG3qzcYis94WvJDtyX9EPVTg5qSKOq2oH6rwehBPhjXhqbx?=
 =?iso-8859-1?Q?Ug91h11KNq4ftF0V5bOSMX1uv62qpDJ2PQ7whSCKbj9tWVU4bA35DnPOn0?=
 =?iso-8859-1?Q?RDRSbltDqcIaSQkQJPUR92UVzf3tuu0bPUso4cvEnfezdMKlolpLmyUOvK?=
 =?iso-8859-1?Q?3HCdCWFLZEB7HddNNLX2A2v/P8avTiqSmJTIr2yVCetVicwc5qSTCCRyRg?=
 =?iso-8859-1?Q?xsQDs9mynUYfK3jXsYKHteRDtb/i+o2jm+vISE6zJsyeTQTcXq+rVRA+z8?=
 =?iso-8859-1?Q?0eTIXEwuzxoAC/FkLtHwzFmRaHEM3ESLRdanIRDX1dUrv+cheLHYWDXUIC?=
 =?iso-8859-1?Q?sQUG1F3uURkjVlKkTmifJFsX8QYZpZUA0FOzAsTIUlQnfxIKHCADdUYDF1?=
 =?iso-8859-1?Q?keB9ZZMm8LXFQ48/mfrrbwiie6Z68UdWJsYpK0zuU2iUSCm8hPtX2H40vP?=
 =?iso-8859-1?Q?R2Gq8WYA774b4Sklq1frO3eoqNlZmF45YNKjXW1Lxmh8v/UBsoS0ZyOZM4?=
 =?iso-8859-1?Q?4ykUtESJe/RvBgDASazmp2BZmlXNQNvOikCx6e8WG+SyHZb3dWF/h2EWmy?=
 =?iso-8859-1?Q?0zGr6vUYHmGSb5jjWxZR643c9rvAFN21HXon76ZP3GcfXQNx8wp3g+lvdd?=
 =?iso-8859-1?Q?MPmy21O9mKAdvmW7okSzY/sPZ/D4qiD7dLeQDKUpF0hIl/iJHAa/ZEiwv2?=
 =?iso-8859-1?Q?9JjSftVIW79+PK+nBgy6YU38un1HxdkQ68Y8NNI+PUPBIt2/fFcm2vCKZo?=
 =?iso-8859-1?Q?VZHOOxqxw5ZfPQtIVTx17fU8xf3PekNlsKynsVX9uhCc4rN5d9lPLpseOf?=
 =?iso-8859-1?Q?oYTCpx4wUCRJx+MFQ8orRoe+26Sr/tAKsycDmtvRvp3TMdh2Bw84Cj4/EW?=
 =?iso-8859-1?Q?sxNn1KU4L7pFJGZQowbfUrlpoCLV/DcWSNLCMTBhuseTSsSGNAoo2SEBpb?=
 =?iso-8859-1?Q?jBOuTJsjHjnC5QMxQ+mmr+orE2t0lV2k/K0DclvhqZA3xR1WIScEeqxt4S?=
 =?iso-8859-1?Q?V1mXL4CdZJwmsiu2QP5niBRGtwY+ryUwD1QviQtnlXxN4YFCJfnQzmkQBA?=
 =?iso-8859-1?Q?HY7u/AQCrdhsIRMH0IBFWzZgIAs4iHkDRPWW169XONHyUu8W7ye9K1qod1?=
 =?iso-8859-1?Q?aHHWLoGCDbho/EmZhlkzqOUa2J6FvbdLJ5sYcCbV02tE7WEVANTcUOtgfu?=
 =?iso-8859-1?Q?11M/hzmh1y25Xnm17r2Wx3nzn318PqBdp7Yt0HNeDv5Cmrbr/CmvFHKEr5?=
 =?iso-8859-1?Q?c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4oW+7GgTujqwXFgdFoTtVZrwuuQLR8KmeAHzRigIbldldi8/I3GTqpizq1?=
 =?iso-8859-1?Q?zcgP5nsxUFrmgC4aKcguZkgWEfaJHiS11YM4XzRgnkdgiNuLzl1detIXhO?=
 =?iso-8859-1?Q?6/z3ZeMDqKKu7AI/mrOziMeoeGPNA3Z330CPc4+SVH6PHgdH5rO4igZgvK?=
 =?iso-8859-1?Q?i/5v1sKSar67UkbTUShAEy9tcUt6Eg9OlD5u9lZIzSePvJ4Wl5IEKXW61F?=
 =?iso-8859-1?Q?lBo0MG6UHsMvG60l3nDQvksMguFojJcibIlizWjDiJ4pNqOdTZKGKmp3p3?=
 =?iso-8859-1?Q?ake3UWijE6CbZhLrWGBVkBpSdaLu7qdwxXv8DjY7eNA8JI6qaL4loyT+md?=
 =?iso-8859-1?Q?Pdke4lxUOFNKDN6oed/9xivZzw40Zu6/ujLYyMRICoRAUHRKgNMPzKTWuW?=
 =?iso-8859-1?Q?5T2OCfOMZXxJYbc39LAo+1bgUTdRmvcfyhh3O3pDs6zztJJ4M8ARDvsE9s?=
 =?iso-8859-1?Q?fkRg8RAHgNDM8dHUtdqcTi7iwfo5xf0RtJdYYZ5pS4kahBtkfAQYHJv5a5?=
 =?iso-8859-1?Q?UtiK6oMu7A5UIF+JuVu/9vvD/BsImbs5wnMjv55P0wv8SBTJN692XHqn+n?=
 =?iso-8859-1?Q?PALDGmORTbM6IU5kyRVNK1oXVrWMTknhbPb5hmxBlJNJ5KTwqwnRYoFfiW?=
 =?iso-8859-1?Q?W2xtCe8i2Rjz8riJy2vMbNL6PNoS5H82riazP+YYG7MSYM2thniiKCctDX?=
 =?iso-8859-1?Q?MXT6joHoGls3ohEXAVtHn2r7yaYirZgsqY+E9v5NjlHTulUIIX6OnBfIfN?=
 =?iso-8859-1?Q?GRpQhBIwMpgJ58QhQNS/EPDtvF1fgZJKzLC0pTDfs0yiJUy7i0tENJs3vu?=
 =?iso-8859-1?Q?HU9JjeGpMctQ902LKSsQsTWBOqKzlNxYwGE42+nqCw+pWhEw93fzASNptS?=
 =?iso-8859-1?Q?mFP5n9s1PmdEhxYBq00unZuVI7aZb1VhfJ2QzA9Ziz0zUddz0eaw++l+a4?=
 =?iso-8859-1?Q?1/PLhJGBmZ0X+01iTYxF82cbbyJIiN6hNoV9NFdXxjHcqfmSGshjqT6PO0?=
 =?iso-8859-1?Q?7Sf380FjlalQ1q2Y5OGBWGGHpanYUDWBzfSmMg70ljI9EvbvnqqjEZ5KwY?=
 =?iso-8859-1?Q?WSb2agFWz4oZad6GmkN2rRdJ7THdBU708teGG83TIQiMgKft8R9DkyNOPw?=
 =?iso-8859-1?Q?duT4LT2UQS4DtuRin2RfMvv8q1CBiZHUWwN6O2g/td3kxArzVp+MzDRgcz?=
 =?iso-8859-1?Q?utT3miXWzrmhhDkALaWQZ3qYgHJM1WtQVh402gCn5CLZumMbnf07BsHsId?=
 =?iso-8859-1?Q?QczzUwRlOHpNbvBtwp54WUs/ZKr1spwf+DbrWFtqOJQU9d1I/lYltEPnJi?=
 =?iso-8859-1?Q?uWEtJzu1WJDgqCmujPNtpwUAaycosYsWakgZcUmZh9U+5PxiTXbDM+c3XW?=
 =?iso-8859-1?Q?Fjam/wc0K692aU3tYZvmXBT3ms62k6Jp72RqVkA+HzXTPNHlnqGKMWvw1J?=
 =?iso-8859-1?Q?wbubBPaN3ZpV8Bw3BjLpIzi0dDir9PLgIV+EdRDeh6vJFH+LrTLiOdTmNF?=
 =?iso-8859-1?Q?wj+Ziy6ISvXlJSO3vUgf1FyxwsyJcz23ZGqNvxziEBQtuKldO5g6bNtjuy?=
 =?iso-8859-1?Q?wAUMzfMI0e3hytm0oGy9cmmKHeACtjZcHFXhfdKSB6dWfyu9xqY8SEDzGz?=
 =?iso-8859-1?Q?LWw9i+lJ4m5Lg9Rx0jvXpW6nW9HyC5pqnkm1h+umz1GJaduk62vEQ5xAbx?=
 =?iso-8859-1?Q?mQuW+IEFLpyhdQJgsx8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67706647-4f3d-452a-e64b-08dd4d1e4c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:37:47.8207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TYTx78uJa2JJaBbbeVxhv9SCUuGL+pWsid1L6bKJo0VfH1g2C/sDDrQum3fjQlVeyqD3ceS4uSw3znwJhaIsWRBjffze5bGAZ/2LFyrzHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4329
Received-SPF: pass client-ip=2a01:111:f403:260e::72b;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Enable MSA ASE using a CLI flag -cpu <cpu>,msa=3Don.

Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 target/mips/cpu.c      | 16 ++++++++++++++++
 target/mips/cpu.h      |  1 +
 target/mips/internal.h |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..8e12d303de 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -494,8 +494,24 @@ static void mips_cpu_realizefn(DeviceState *dev, Error=
 **errp)
     mcc->parent_realize(dev, errp);
 }
=20
+static bool mips_get_msa_on(Object *obj, Error **errp)
+{
+    MIPSCPU *cpu =3D MIPS_CPU(obj);
+    CPUMIPSState *env =3D &cpu->env;
+    return env->msa_on;
+}
+
+static void mips_set_msa_on(Object *obj, bool value, Error **errp)
+{
+    MIPSCPU *cpu =3D MIPS_CPU(obj);
+    CPUMIPSState *env =3D &cpu->env;
+    env->msa_on =3D value;
+}
+
 static void mips_cpu_initfn(Object *obj)
 {
+    object_property_add_bool(obj, "msa", mips_get_msa_on, mips_set_msa_on)=
;
+    object_property_set_bool(obj, "msa", false, NULL);
     MIPSCPU *cpu =3D MIPS_CPU(obj);
     CPUMIPSState *env =3D &cpu->env;
     MIPSCPUClass *mcc =3D MIPS_CPU_GET_CLASS(obj);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b..3e636535c6 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1191,6 +1191,7 @@ typedef struct CPUArchState {
     QEMUTimer *timer; /* Internal timer */
     Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
+    bool msa_on; /* Enable MSA using a CLI flag -cpu ...,msa=3Don/off */
 } CPUMIPSState;
=20
 /**
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 91c786cff8..bbe2acffe2 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -399,7 +399,7 @@ static inline void compute_hflags(CPUMIPSState *env)
         }
     }
     if (ase_msa_available(env)) {
-        if (env->CP0_Config5 & (1 << CP0C5_MSAEn)) {
+        if ((env->CP0_Config5 & (1 << CP0C5_MSAEn)) || (env->msa_on)) {
             env->hflags |=3D MIPS_HFLAG_MSA;
         }
     }
--=20
2.34.1

