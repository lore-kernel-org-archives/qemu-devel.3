Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A382C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yC-00088y-PU; Mon, 02 Jun 2025 09:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y9-000860-LM; Mon, 02 Jun 2025 09:12:49 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y7-0002Ae-Rs; Mon, 02 Jun 2025 09:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2HEke0Os85cs9FhDSIlX7OwhAQZsyxeKbC3IcTOBofptrhRqeVNHba9hVRFUEo9iwj4Qm9xHiGfu9A9Bea6oKVVGxVD60xuxrmlmceTymfW5deCYItfyBdNIxckiKnxS7vCOK05Uh6gUvYGLLBV/KEaN4yMRfp4XhXFcmyv0DsDkJ8yEkBwERXllegaPMnfrNkgjVB7FRYEvL6E2Mm2JN5WwamtP72YdaJ8K09ekOh5ZgZwgPQH2HgnWXVIou6Opn5pju42Q+nfVakigPqhnoybVVhP2xV7jZmDKOhoKefIQ3OeZgqOFIx9JWmopYpqmHzaQmSFclmHqKtU/ZNJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tabji0/jM8I/TyTayS4qR8gbvMQxQwNf66naX/IJfQ=;
 b=fzrEQip2Abqxlvv6MN7XnrWZiM09fsbY4JAj2txoUAHvm+G0Dr+9jQnODf3Re63dYgPDlPH85jSot/hS4OasnjEMTN+92eQ6ka08ODH4p4MS/qxcMHXFHy5tWLMNDhQPLJV83OMVRoTDkMuPS1MOGss5SOQBx8WbJviSXLXgtFh3owoxkphV0skTY6DvWl7+goVuz69G37idSLCoq0BS0jtSaMcFrCs7RjIzxWRr/tYxaEBrPNO1/mK5ygNoMN1geLJnGwjyZtUM8ezY8rg4fq7+s/nKq1uOx2oeizZpT5nxd43RjXetPo7w3InfXUQakArWgh2HjMtKkYtNKN7Big==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tabji0/jM8I/TyTayS4qR8gbvMQxQwNf66naX/IJfQ=;
 b=lWpa8l5n20WRSxpdCA9SXwjqn+IUd55jGSKmW9N2R4jzYUAACKxZR+YLqr+Oik1lGTep/roArSA2z8sUX2v5CgYYLekR35THQXMCicPUsYCes75XGxio3NC1Wl+CflwRWvFI7vgVt5wtEMs3bjvc50Fn2BUykSe2zhB0h528kSae5EfaO+QFP7PioSyW0stH1En26e9WBA13vR/psHqlWg9u+slMR0P6tvoBNf7I/SthsED240aF+S9ws0fPpvb6LLJ6o6zB7/Abo+nme71jkEf/j3QE9xG1iwlUuIY5almgHwrq0acxukkoUFxW06gKlvnqxrr4TbK36/TjFiAjag==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:36 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:36 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v2 3/9] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb08AB0AGZl8+GykOQE9DkCQGBYw==
Date: Mon, 2 Jun 2025 13:12:35 +0000
Message-ID: <20250602131226.1137281-4-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: 210c5a51-df66-4efb-3ff8-08dda1d7249b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aKbeX1p+0N28TzB+UFLUa/GL4QWm5ltoPtyWi6vkCDQ5pqIhAvTFwOesG9?=
 =?iso-8859-1?Q?lTT6YCSO3BEAnlJ4PYS2zO8UvwIpfmuBcLKIiAh+EX5J0NTrx94x3o+o8v?=
 =?iso-8859-1?Q?9o1+tMOR/yTa+nUwW6RWH1VfiNtBe3kTTtCjIY8XzzCZ3xzwxusFo+QrVY?=
 =?iso-8859-1?Q?uqlihpTBjzXJv4mDX9Fvus/0aY+vu/8hoIxh9q5WtT8outrscaSKNAPFsn?=
 =?iso-8859-1?Q?JsEtDfr/j47JI2IwvoHWpbdf+LSczhZliYow7YMJAb1/mMBgbUYDofQyvP?=
 =?iso-8859-1?Q?te2zDRpcWLbEoSCVcFuRMHoRxZ4Z2JUk4v53wboWTV7gNLYTnAgN4Kz827?=
 =?iso-8859-1?Q?GvcC8LaSyjDGbab26cZVQ1OAyeKUQWe9BHTUiUAxaVM+Xrs2oN7jyG9zwQ?=
 =?iso-8859-1?Q?nNBLxtB78j1ARfADA4j2ZBTLtwD0JWMcGCvJbspl+/0Z4Hv5jL8OAOEhMd?=
 =?iso-8859-1?Q?dqKyCyF/EPVEY6luK10yA+Sc8hCaIlFQ0PbEdD6Qux285dX/2b1j5WDMsY?=
 =?iso-8859-1?Q?UqEDKpopHy94qTQ1CrFQCub/Ko7YGAkNiUgqJn3gZlmRFCWCNnwBNEp3Lm?=
 =?iso-8859-1?Q?7FxBO5QtfJDV2S/1Kz+C+H02pIxukVR9niH+ZRsLtQH/2rNMxf666t8kiQ?=
 =?iso-8859-1?Q?ZXCgLBa9GZADIz5Jg0Zc7hfYqTPLHXTENyjHYu9ZQRUKMzbKoP8NsQ2hXz?=
 =?iso-8859-1?Q?a2Txpc8ouYNVigGyuHVH+v4E9V8KGqaKz5cV37RVftVLMuuGJcx1SrCSHA?=
 =?iso-8859-1?Q?PWoH4yj11tDSCLLLUjvEuKMLC24Mokdlfem1ArajmG88JewabktyH6V9b7?=
 =?iso-8859-1?Q?Att99pJPhk02paTCfAn4q3cuBSzPgbh+pLPEFbMwTUYzMjOkgZjTaF2PoJ?=
 =?iso-8859-1?Q?QfE03O7sURLDqyGj0zmMuUWA3xkJl/nUbHLVZeUYSgDghY1MhsGvW1rRw9?=
 =?iso-8859-1?Q?4f2zXkgD77f1FvHIFi3xfmn2yrb04TLo/Gjugy53thWIJSqZtkKI6uMSkn?=
 =?iso-8859-1?Q?jC7k+OcjD7rK2+ndfm+Ho4CXRu3mQeKzvLL0CmtYc/CA8otXklKiFwCfxb?=
 =?iso-8859-1?Q?0ITdTSwiKLkmpA8O1kXUvi86sHn8gq9PQH2dkdzgZLxw/PJYeXTMF6ix27?=
 =?iso-8859-1?Q?Ja6HY6PsSZ0UOktJg1UyDFxrQd6mAJdMy+DFlKpec6taVwAcu/oPlc8lkE?=
 =?iso-8859-1?Q?t6g83wvfQCLuIoxTKJbVdrBb/v+7IHzNFyFMkFKeflq9ITcOufKuuMwjrq?=
 =?iso-8859-1?Q?F7BuzXbOXtPHckl8gKwuOrDzDFXSjCKdQW7IP88RxDAgD3YbQYyJ1X5V+G?=
 =?iso-8859-1?Q?+h/kOc1UfviRFvm9+ZQj9I+Q8CcYzKl5WaOcuBwn+ObNRZEBissp0thLNW?=
 =?iso-8859-1?Q?3S1m+1nSXQlCmWkbgbxgpQTaReaiuaYIrsWsO4NWNyzWHZV/EyacC3ioh7?=
 =?iso-8859-1?Q?8ArqDt/Wao00X0lbZIWNXVTAltfsdVPTIMuQMP4MSzEzmlUpxC3aS4cNkn?=
 =?iso-8859-1?Q?6ykjN0DweXsjD/hY+254yVJ7k+CYST+Rr3E0IIxb2ReEpHRGN1Z03i5uRV?=
 =?iso-8859-1?Q?N1XfEVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mjlxAM+Jdpns5EjcPbrhxY4tehk9hCgqnaGlsz7zT5mPiSXsY2ttOqt14u?=
 =?iso-8859-1?Q?hspWsQOkzIZI7jB2LRmlJUVm7YLFYUwcG+En04nptuheTe8EQWKOiponrK?=
 =?iso-8859-1?Q?D7pAsswAjqHUni17XH0vaSWPiD+S3AYV35nHFD2lGfJW1dOr53dK4u4tNT?=
 =?iso-8859-1?Q?wmcNeKRhqLAvDBa53QhZ8U+os9oRG1/AOLtHPc1OQ/MEoV8gdI5AVCst14?=
 =?iso-8859-1?Q?2H6yukB9N982+hfv28t3YGGor0TDcDupUlZR0IujVyjEeFLbcAHKRu9heu?=
 =?iso-8859-1?Q?GtlOgCTcQVzUphUilI6RVgbyzwYiqdHYWS0nhoX432M3vsE9wEt9kGW3Xv?=
 =?iso-8859-1?Q?/YyN5vELNUf02gkW8otmmB5iG87fH63gGfIZqO2JKkGnpHoRLqGU/X9m7Z?=
 =?iso-8859-1?Q?uFwSLYHTUIe9ngorhL/frn2Zl7Vk0S+Bf3BIG9muWpwVxjOOFujwEJE2fs?=
 =?iso-8859-1?Q?dfAulSKoAbJ8FZCBFzUxJyzwZRrD4kaLdKw5KpBICeDStx5ls5/QHYJf3J?=
 =?iso-8859-1?Q?1eXVlwqoPp5CJCao6xMp9ziG1B0TwbzAB/TRboyGI11PBjHrw/6xrrtn8P?=
 =?iso-8859-1?Q?Ry9A8XUDxYXOiohao8sRFsQclaz+0MaGy3IO9mHGU4RG9HGBcfL0lp6/1m?=
 =?iso-8859-1?Q?itFsRI2FAt5SYN9XHEG5mlc5mwqco7ayj8N6hO6XQrFWFrOleVRWyXNxYO?=
 =?iso-8859-1?Q?yqj2VpgbfbCsDy4ksu/sSeZNw3OR44udCjaJX2EDNsujRmuUML3xAjdVo8?=
 =?iso-8859-1?Q?cSw9SchDQC5YcLuIIeymowkhC+tlT43Ip1hZ0lyizbCZXaJBWdMsXSodbR?=
 =?iso-8859-1?Q?gZJKMKwVnUSwT+UHIIRpvMoC6piDvXBHgokxesVcAZkwYE9yyKtHh4kGpt?=
 =?iso-8859-1?Q?SpBcoo6ADlbK1pXqoBHGUePOX+XnlS4WYirgtRytvmzok4l+tYhFsf8j8d?=
 =?iso-8859-1?Q?8le5HaRCEeE805SCtQjAH1rSc11NaQtbQaTiQqftU0AVDRystCN5XhH9tH?=
 =?iso-8859-1?Q?KYUG72qK9Q95IYKFN2Gi2my76varwA3Dq9ahoDE6DBV8ZLDf0am2Q8NG86?=
 =?iso-8859-1?Q?2Loku+Egu7OAFCapXWbFGRKHb15cXb/xnmpdAPGYVhQDwNZggL7Yv3TDsA?=
 =?iso-8859-1?Q?FepUeWNb20q0Ppmbflat8SZ+/pOKf4EAid+KbB5XgS/TY/V3vqur9+wgy8?=
 =?iso-8859-1?Q?3dfUuDrdEpJl5gmoDhHp6bwcBFSfR+ZJL7WZJ4dIubDiuonv03zg57Evnw?=
 =?iso-8859-1?Q?5Q79/B3RIdjftRAPlNL0dMpFW2jztJBYxuwDtZS21Jq0OzXKZD8Bq4I62o?=
 =?iso-8859-1?Q?FjctKlodtPIIluIYOwUfOIFVjHw4aWmPVuLol8xKTL8SYnsK0rGZDH+g7l?=
 =?iso-8859-1?Q?Om3gmPfoAuXp1Xsf9X8lZCqJGS8VIH3V9/bQpHPf4p3qIGNsf60u4IHGv+?=
 =?iso-8859-1?Q?6AjoiWDvKBABbr0Gv9osQ4r8EdGnoDO68F5vL6t9IRSNJCw4Lnl6ZVvEgH?=
 =?iso-8859-1?Q?qp/XnB1ZIvaatYa2CsyBeIPLNUz1pO+ad851Y/Msv8BgmaMtZI/6QvxxBJ?=
 =?iso-8859-1?Q?o38ZWYrd6Yc7v4cgnHybz6Bo+Be0Fw6xcVSDt3ffNmQFQbt3bQzcIlFLNf?=
 =?iso-8859-1?Q?NorhfIq+GHD8f+c0ZR8TFFT9aER94oP0bkDaiYQAf13aOO/D2DiLAH5ccg?=
 =?iso-8859-1?Q?Wsx/21dgEglvXFDz+Dk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210c5a51-df66-4efb-3ff8-08dda1d7249b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:35.5811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7FWutR+5Y5Ez4LFYjNTOzCAe34Oqex9sb0QhsRJM2KQNqBwK6HsVcnGYIaG++CzFMV5UaX9VYh4BVRtv7Qh9XgcYTxa4klC9iX6kDyLVz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Introduce MIPS P8700 CPU and set reset vector to 0x1fc00000.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..1e62b96094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..519d2345b8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3167,6 +3167,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV39,
     ),
=20
+    // NOTE: When specifying CPU, specify `resetvec` as:
+    //   -cpu mips-p8700,resetvec=3D0x1fc00000
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
--=20
2.34.1

