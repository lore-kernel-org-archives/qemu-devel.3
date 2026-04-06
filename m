Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11A9F46C4E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mD4-0005a4-OU; Mon, 06 Apr 2026 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD0-0005Uv-SF; Mon, 06 Apr 2026 11:49:51 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mCy-00021U-RU; Mon, 06 Apr 2026 11:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+axGXUeKWPwldl53WfNwcxdCbmEFf1xnGH1RFAwstQOycJIrebFhrluDFl6jkmwnHtYC+gSkMzu27ebMPKBmCQTZOOyfeoz20cmnldQpKlzcmuRWKU1JYqOdDBM25nLaz1Ex/yRSvMq7OnQX1SvhyQL9S9mFElQ25ZSYKCtWN5yOArV2xWZb1KV+t2Dyd5lN0Xcx/Gx/zZDr+uxHG1Qbf7k6AKfyvzhq4sI0XMoUDxqRLLnZqZimykPgNL7pgK9u/Q428Di9ZuZexiiHtxLB3XEsS2RDHzH3dutbh8Jv6uHD0UnjTNgdOyGhgLAeaCMlr8FQnVS9aQVqc8qB4Z3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVzeAQgbNcTCN2rAOS4YgOjyXCHcfr+CNWjkMHHQHy8=;
 b=No8t6aBFjUC3zrlSg14VYFhB8abQy+B2Hkm6ZVRVrSc0xBk2TDA3ywQpUiiy6blO70TBJdZuGER35MnYAFR4+Wr8idw8yWnIm/RVWRzlf9jROs3pjs7ZfzrtmCCIRLmNU1B3liDdybag46j8Zx5JifPbZ7YVtHdRy4x2gV+6STcFE7K1IhTGRSW2u0u0pb9yHuJCmYcqxdhjYloIiF+QYuXy4f5NHTJ16Yl5Y99UDuu4TP+7lElDJD8fb+stTghVQj0VGjzHiM0yhC4cL9eIPjfPdkM579mYFdCYcIbqcXV6jhzIEWVoUfFXjutwcqZskM/uhwY/yyK7FDVpkodG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVzeAQgbNcTCN2rAOS4YgOjyXCHcfr+CNWjkMHHQHy8=;
 b=ehyADqDrgt65rfThJRzWIODGl7tDiwrl9DRV1oJuoQED1s0kWsigZB7DzZwfSz2SMvFEVrcwQ57M8MEC6Ojhc0v1M9Xs8xYejNHIc2GGC08eZzKJEW1AKzXT9yYMFR5rYOtObRzOquMJa1iAyK27ZhUGV1vLglXi7d7r1tGSAdvNoFZOYmxAvuI6uWxtWhsvMtVpuGYib05xqW+tS18GFaAuPOdZFHM+zzTX3ZscDUM0Ek5MrMuyo7PgnxC8JOpjd94jJI/kgQGLZ+CKmMeoKg+GTVxa7aEY1UiVDazKJXViX1UlR4aCyi7K1Mnxei3XQOskK4qqSrKcO6cBZ088eg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:42 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:42 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Thread-Index: AQHcxdz7upla7z38V0m76mmMu7gfvw==
Date: Mon, 6 Apr 2026 15:49:41 +0000
Message-ID: <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: 424218c8-1c47-4e73-e387-08de93f41e59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: /k4IgLBN/f55PbSv3D2azmJjQcg8G1T8wzfCONwBauxytLGb7Mm/fmxGBV2a5F0swbQBi3I19FSg/CuajuR1rfibe59XzhirJgMNZ1ugObfR8PUL7UdOmcH8G7tK6589Z07RVcdw2GdVh9WIsmDwU2VXcZs9Fyuz0KnxPnJd31L+sflVCtpaAW9UQ0qK9353FoZUPceF0d9uOrVl7PvRLAcf0jMu6I/xWw+7nt1YvXBOidOJIep+Vl4wHJeP+g+y0iUpL4/Sd/wDQMIiIaztLIFAjrs3vVy2MeLOYNOJaMt6Gwh4UFx6sDObVJZyvLcah9KaieGY8AntIUhY5E67I2yqGOnvzfNFKzyoUwt1PiNKzRlqFxH93OQfbscqCmUcYbJS7zI+bpT2BdWGpRjQp8me7RxqJ0cCnmSxrS+wCxf3nS8LfwqopYpzJi3/ShyHdG49jmgdMRIMXTgt/oQrOoGPba+c9mSK4yciL1VpX4CL5/Ku/qyv7ZgC71STTtORG8D57XzaK5lM3nU4/3Z76OfNtlRFmIM4XTNf1cBqGRPnXKFEA+4qXaDVPu0cjGv7Rjyppt0RU1qbBImIZHzkQLJGQXSu2u69iG5rCkbDnAyqrViIb50RDNNHtFG0alRF02LlQ+M+D0UbRMWSPjts4aktZKAMbo5Jd19keJRtUSvShcynmJ+LyLKc7i1GgPWJBgXiT2pgev2Nep5IKrCG4Dozyvlpw8Y7gkEVLolRs6XPTi/MQRERSwSyM61ZnqvcG0vkGCLDXNp+fVCALHuXH/gjkiOqVjo84XoAwXnoEig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?72uTg6gLu2IVH0Gk6MEHTCjA9k4c7HtdwuVF2FttyEa6qzsecj+/j1uIHw?=
 =?iso-8859-1?Q?xFVQFkmSBg9QySXs2IXl89ANIjXw0l8Uvec+MxMezeUWrQakEdOiY/Rs+2?=
 =?iso-8859-1?Q?zoTeXIqQa4AnJq/MSDou3N1Cczb4P6mD6bg3Zgs/GtX9nELVMHvXKE+Q+a?=
 =?iso-8859-1?Q?0V/wYgsSpEyE5CudZyF7LYXFfus9QYivzA+p2ufMEYY4m6OE7usZ6zPW5D?=
 =?iso-8859-1?Q?cTqPVXnqHi7+jcaO0DjiIpXqHfreZXlwVRRyqmTL+WhuEkaYAbG0Tma9Ri?=
 =?iso-8859-1?Q?ZZdFUAL7lJmzgZEuTN43RmU8q7FghywpTprSlX/kJO2rI/iFYbmS9znFth?=
 =?iso-8859-1?Q?Up/yGRt2U3TmwYUnrE+PYtkps0//CLZuowhnXNFqfFPtvxUi+OLyOf/y/Q?=
 =?iso-8859-1?Q?TYRRM8s2outAF+sSYrKUvQNTce5kRQDzeP/GzhFrj+jLPYngWup8P8sVUL?=
 =?iso-8859-1?Q?rSRVpdDLwl8GAKWJL0/Kc4/kCuWQSw7cr/jQIXVJ9AMfK4h2dcK91x30hZ?=
 =?iso-8859-1?Q?tFld5M/h3DR4WearN/qNvuMfUMip9sskwtlU+zY8/iq5drNCPZpFKtGNj7?=
 =?iso-8859-1?Q?qxqpbk6LptLuwYH/8thhKtkBe6U//pFY4fIIsqrYFHP9I79LC9QIfW2SFM?=
 =?iso-8859-1?Q?XM3Tl1OyThT/QFSVomOXA2Bh3xsYxvmbhaOf+iS8y46F7EBF0MF4uKY4hW?=
 =?iso-8859-1?Q?1JH4ep1Zfrh63cn94mJ3tY4t/5iqd72xilyUo7QjqZYuVWZRk1fKvA98Id?=
 =?iso-8859-1?Q?+Jkw9M/iJMXGFrqK7sdOr92e3nL+mu0NCJMo5iYEYRGxBYVj2BMqm0e/7q?=
 =?iso-8859-1?Q?uA2oCI3mxiW1iGp8R6B/5qzt/WwCCZu+3jswdm00tWzGj7by9yOpambd3f?=
 =?iso-8859-1?Q?fo47MVt9b3wOn02NCIV38AEDFBBlFuwr8zJ4B0xe5+PZ9RJP9ngmxbRQRY?=
 =?iso-8859-1?Q?OU1/VnRtJdi+6Zqx0/Inv6/lTkRKiX3DHNVVD/xslqyK0q6fc6ICNTmdlI?=
 =?iso-8859-1?Q?BgGyixe9IMhgrVJNAF8nlWgeyLnb6jCSB/RPzx+XRdNLHinvH3snS7gBv2?=
 =?iso-8859-1?Q?2ij/x2vmbsZ42GqcnRGABAPWhrqn3nbC+WSmOuPEOu4nOADWTAFU6Su60+?=
 =?iso-8859-1?Q?7wGZBXsj6Pahq93wl9xwi7M41pfKM59HO9aTzXuZNqF09lTYsSIv9Ze7U5?=
 =?iso-8859-1?Q?nkw7W6qRilV/goV5Qy1UIsoPi9ZAv7pMvfrtRCLRXOZ6lMuC3T7UVaS6s/?=
 =?iso-8859-1?Q?XaRHMGI8poHvwatb4kpYTho96N41CDza9fEDzu2sMS/3AOQqL1pemypJQe?=
 =?iso-8859-1?Q?V1TbNPKruOy5DU8jbfun3IMDgTRxLkAaTf8E7NAvSQ6bLwYaTLTDUXiveF?=
 =?iso-8859-1?Q?dfBeYoBzhmKYd2xmveMtrZq768PoFxaaU/gMkt1yjJ/OMXJrvhYJYi/UdQ?=
 =?iso-8859-1?Q?Zrex+JWqd5/KGZwXx7y7D7iihfTzQAyS4FFdwdO8TpBxm2ah7uHuOAFiKc?=
 =?iso-8859-1?Q?L2bp30O1aCJ7Kn4SZGuyFrka2dgX29CVmd5t7GwSBSZXUTdfNhbNXJSeH9?=
 =?iso-8859-1?Q?R/GmkrUQO/IDflQoexoT40yTrpVUz1yazpQT+coMOKB24loi9KomUCnbCJ?=
 =?iso-8859-1?Q?ZszL6gR3FhRlZWKYVF46GjQ/OZmiBNpgViM8NvfVliUmXkmdNKap2TIygt?=
 =?iso-8859-1?Q?QjHWsUkXM1+G3yNCk6mM202+hjBq4XstokYdFs4il8EuXns5FRHLhljBX1?=
 =?iso-8859-1?Q?UFBxeKsRSMaaMkGY4gUayqxLs2BsbETVbuTuC6OLsbePhPI7m2P7XSeZIu?=
 =?iso-8859-1?Q?BD/uMi5Cq9HtCNrH0GdpJA5Wf7ZN28IY3I1BQQlTnl50W82N2LVV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424218c8-1c47-4e73-e387-08de93f41e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:41.7239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5Jh4Heuw+Kg8bggIWEm2rfHkfzo7kpB7xo7FMb6k6v/7/ousLJF7Y+iujji8TJ9qy21ZSiagO7ecgzz9dCa8w8zdGX6UESnEEks6VG2SFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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

Add a "big-endian" boolean property to the RISC-V CPU configuration,
defaulting to false (little-endian). This property allows machine
models to configure individual HARTs for big-endian data operation.

The RISC-V ISA supports big-endian data accesses via the mstatus
SBE/MBE/UBE bits, while instructions remain always little-endian.
This property provides the configuration interface; subsequent
patches will connect it to the CPU state and translation logic.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..4537305dfe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {
=20
 static const Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
=20
     {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
     {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 70ec650abf..51436daabf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
=20
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
--=20
2.34.1

