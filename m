Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FD5CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EQ-0003Nr-VO; Wed, 15 Oct 2025 09:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EM-0003M9-Fw; Wed, 15 Oct 2025 09:07:50 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EG-0000mj-6Z; Wed, 15 Oct 2025 09:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu4zqZyy6+dmYbizxjzvWjmEFKjsE8B/n9XnVteLEeGbJJEbzuOixOfrJ2XVH1biAf4SrbUMrwCDCvN9dJ2xWn6dv+sO/0xYuRyWBumK9PZX6L+TAZQ2zJsc+Kwm2tNa1BjI22Miv4IG42os0XmD94jGxuzTpDyBSdDlHmvPMxRxSOVD1UMmZZH9K1si9VqS5+Wb/iL/i929y+DLzWKfHGdfxhwruDipvBnLvtinzqT5LX5xXYm6k+HCgPT5wO1+mJ1v1oLz3nZQIJHaV0E7+jszPs0XFy/NMpiPAikiaYfA/MBZiLn8j9b1JIw4u7Nvt3GVXttyYHzPV4bdrdyaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=QaSOvoygp+J2ahykrf2QjuLP2tmy0mP6OkpfFXTppYqLKPw/IExokBVUwVtzSBDdn0IOcddonIvWlesGSR73W/5OY6GXZj4D9YbyO/Rxo8RWbVqgfxZk6UfW6uUqV9x3ySUQ/xHB+At/4vxSWr5reZeSScEhctzRO59d/AKdfS1m1Chgs4y5R6x79VrqVjRNarvKlVmVqUQEESFpwOTj7rw399nwYxhScpYxT/HHqr2oHBsoQ7MLyiEVRlz90rJe3znuZ+eWjVPAMkkKFSp/eTpVXRx4WLf9bRC+X+vHmorvByQI0+c14MEQfZ5mg3OmoRBoma86tfUVkiPGAFSG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=Gfn2zCneymj1ThRf5PM4od+ayKFWf3JsXi5kWrhDOwDxsJ3Xfja3yY4JaI1DmvtETQ2XG32pdrrnDTKtpfsHcOxSBsFd0kBsBIDRvYrY7Gy7+niULt4z/bwCD7kicJ+jilS3RI+HAI9867gmNg1s2z8AC/d7hy+XC+rgEtdi5XPldG4cq3A1VI534AXQ6fvahiu3+xF1c5c+jRFQG02s9djrA2iGU3eLqHni3//vKSLMTnVgNjJKQVsiiJZ5PH0DmvsObknW9wBu9uYmrqIdor8V2ZEjMGegsm+NWDxY4aqw5FtydbHiq+9imTiQafoHABmFzCBSrQtiw4Y1OtDbvQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:06 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v12 07/13] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v12 07/13] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcPdSb1sfHA919GkaM7RPw1tBbMg==
Date: Wed, 15 Oct 2025 13:07:06 +0000
Message-ID: <20251015130657.571756-8-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: d7d4fe51-e9cb-450a-fde1-08de0bebbdce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UcUGhQ+impn+Bu4Diz+eJcVUS4B1FC6fyVTY2nmacN8IarcMioq8V6SGKI?=
 =?iso-8859-1?Q?fBcW9wnUZRcQdO2lZ4w9J8uCvx3M4X5KIZawoavnVfjDszThN2+3ivU6HB?=
 =?iso-8859-1?Q?aROtwgemjJJlbUOJ33WhgtvGYMuiPWbE8X5eFI1fAqMm5uWL0q8fG35cQl?=
 =?iso-8859-1?Q?Mkjbb+LTkhUoE8fE0hUR8yDA3bFdntTQxhxJJL0aYO857Ixx0PteBK+Z9M?=
 =?iso-8859-1?Q?MjgRqXl86AznzqrMfttPJWFCpjKUSQeNbRvpT0GD+SepLvQvn+48rdmSu3?=
 =?iso-8859-1?Q?2Q/J5/UgRHfKSxPTq4fHBzj+RVH/16+zB02cZXA4mVVfkcU6dQGUDs49Hy?=
 =?iso-8859-1?Q?KhWWYVLNJ4Nv34Aicu+kmSos/e90KdX7AGGMgp5/CUGViNBwn7kr07qIEt?=
 =?iso-8859-1?Q?gqKi0ymHZBpy+mgvSJET7QsppTOAyX3WWbmDK6ujJdqwvsFRVdwiK5A3Jz?=
 =?iso-8859-1?Q?16t0n4bHl9Itxt51PustO1mSM7kCDh6b97ZFGDQh/agK02xM+r1LdJg21R?=
 =?iso-8859-1?Q?2LViZ05SstrfZ9oZxKl/d7esZzVS6kGTd1JT2SRFsnOdlOj2rBr7aL7rBf?=
 =?iso-8859-1?Q?ZgGXm/2XmcBX6t9GNdOlDAIOV1Za0ng7EfKk55EwDYkRjzoZmGCvwCzzcB?=
 =?iso-8859-1?Q?Doo4CoyfwBnsJfVl/twy1kA3R5r9jYEjbleZQUc+Cki2fg1R2YN7eJirES?=
 =?iso-8859-1?Q?zjQw/rAX0N2Ppvi9G4EIMaX+1eYPrrGcjhFq/l1B0XaYqg29M10tDRNegb?=
 =?iso-8859-1?Q?33SP9fMwfxqBnLTFqYVevGvxxMmNXJenvDeMmOoKW6AYq/2pbxb/IMf7jy?=
 =?iso-8859-1?Q?h9ypmt88MEGyHxtgt6ticUDJs1nIE8uns6pdSbMB+V9ma5Rbp2ecWFIHZz?=
 =?iso-8859-1?Q?ysGa+R/oYlcxwYJwcPSeMK8j2j4cpkTUp6l+U19///9yNTG9hgny2wogLO?=
 =?iso-8859-1?Q?JdQo32KyRzrNO25DdvXol4kN6nRDbjE/jy3Tlb5wWTiAqKcD7QTJDzjWWa?=
 =?iso-8859-1?Q?tQ4gNoOnXft2OSwPMY3bgtp4XaDqSA05nZlB0xlzewowo+JSzK8HFHFpP8?=
 =?iso-8859-1?Q?Q90oJTuYeXnfEDxK5Q6HjscxQ+529IV9VRSnFid9s1dbezYonFzICFKfyT?=
 =?iso-8859-1?Q?8IZqw+xmtGKCLmWY0wKBa0V9+TaTigRP9D9FzeHl3VjQuVgZzN5ZoUcPHY?=
 =?iso-8859-1?Q?STEx4awNMNHEpcKXTHPApzX5zr6Zdj8Yag6NxrgNSMmdc/lNoObYsacsZ7?=
 =?iso-8859-1?Q?qskiEeExdJ2obpAPuDyg4Ud7FZP1gOWrc1bonpfhu7+85dNISq4f8rdpeJ?=
 =?iso-8859-1?Q?/0qBlGGU04hOR9kLHMsGd51+MS9TiAWGXpxPQzkpj+CGsLRO0a1u9ywtLL?=
 =?iso-8859-1?Q?F+0k5RafkKmjMARZsRt3YIW+y3+26FS8o4FOskSLkaNxhRaFI8JEy23Vou?=
 =?iso-8859-1?Q?cWPWRdfkkvNxLZA5ARyNVLyegQA7XXa5reuc+WMdKAPEybyqlmEpSVOlmd?=
 =?iso-8859-1?Q?cIFdfpKwPK8OYs+QLaun9gBF/GxziXLnCDpxyIin7M4ps9JIUDMT8CTxf0?=
 =?iso-8859-1?Q?J4YoPRnkW9ahDS3G7f87XG6zSjUa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e27hQXd5tEJD0CD2HnPsHyWx7aFtLa/v93ROp7FxOUF1eiePt6JP+GO2Jn?=
 =?iso-8859-1?Q?B9T+1FoStJoY5HbgAXGbxAzdaeKrVolmQI4T2oahI+BJC0UfPKBy5vsUol?=
 =?iso-8859-1?Q?Gh4HWQMHsf6X/qamKo2gEt+oqL9KXJwm83V41gvyYkY1zmva0k5T1tP5A2?=
 =?iso-8859-1?Q?uAtKJ77zvgkWUm/hxL8bP4womx/NhWIkVwJGLjjOscJfLW1tUud882IlaN?=
 =?iso-8859-1?Q?tNCr10YZhrMCDK6DK8Owc7LZzXXXj0WQA0K1Wm2v6T00eviVMzp/sUjXHF?=
 =?iso-8859-1?Q?3xWlyIyRVEC08v6AAgfCLFKZgEQlZ2rBE1tKHPLHS8q63hbuUzBMgUjzK7?=
 =?iso-8859-1?Q?DvIwGMHHHfXhY+8Of5aJE58r+3+R2AE7fhgZfaFGe7WKu/1jQ1QS8/RX5a?=
 =?iso-8859-1?Q?B2ekGFMCCmwQLBDXHTZDG2CUbM3k1EkImTZ2HWuOfHxxhd2hMmyt75yBXe?=
 =?iso-8859-1?Q?K7fhHyELO1o4MnaWRdeTrjS9I8XfqQyTqIqg+mk1niXDX66N3gl01VZoZA?=
 =?iso-8859-1?Q?wRHxJOnnZRzWXBBQVp++ZhP34lfBHkQkaeIzRHCDqh3JZH/3Z7JMVEJT3j?=
 =?iso-8859-1?Q?M/WjtuL14BMiuhjjtkHw7/fHOFm7qSxzH+ifmQ4BCoizFSK9ADmi/RdOat?=
 =?iso-8859-1?Q?RYcadWQwwW0FwZQJfLoQDg8dZna+iA30rRzwk0P4gmGq5gUQItsBJQiLxS?=
 =?iso-8859-1?Q?dF5iItzUuL4i92rGyI4B57ovSrQz0c7kgN41RzjZpTSiDAIzWF1I4AsRfq?=
 =?iso-8859-1?Q?tjg+7lsoiPUcNBfkJ/8dxxyuO+dACyE7CeKh+Z+a+CkecThhSLrrrWod04?=
 =?iso-8859-1?Q?yADXZ+QPglPd6tp0t3hD+OZhuPTR0EcLrEQtxXPul6bQNCQOlKR1mOHWdc?=
 =?iso-8859-1?Q?/Jlx9ckPNTD8izahqgVZnDt90gKQyNorGvbivckrrIxxAsHZFWkwfLqC+w?=
 =?iso-8859-1?Q?do8VEqn0Kc3ekiRPZWBHR4LcbAd5Y0IAdLPyZPviuci0XzkQNWV/K/3+vg?=
 =?iso-8859-1?Q?+k2YqOPuqYt+f9syMvlkGT5daXKncCv7aZk/CN/nRRWDmABb+eu+sc4EwX?=
 =?iso-8859-1?Q?1FmPE4x+EXFBji7QMBR1MQzRlCuprzKZukCjw85Wdrjo5lRcds/SzLjkwu?=
 =?iso-8859-1?Q?K3XYxdyQzw62JI+WnIx2XG88ihF3LZoesEC+mxHrNvZ/c90zhu0YRvsJmW?=
 =?iso-8859-1?Q?6va2Rqhju/9vpq/Qm15NHt4iNRQVn/8dZQj+KUg9P3O0nySxYnqxjZMO9p?=
 =?iso-8859-1?Q?V7FeXPX3WR48tjNRwa+fpi4J6a650aak7OmwLcU4JterZT+cAAd6oiycxH?=
 =?iso-8859-1?Q?s0B842C4vBMJ1zGzFmBASgt2EHL9KDy3wQjIasLI5m8vtntk4ltGn640aq?=
 =?iso-8859-1?Q?+eTYHO5qUKq42mIiXG269gX1zBDhUf/jxtC7McbQikU89BI4DDaSB6SLNW?=
 =?iso-8859-1?Q?t+pMpn48+Qww67JYWqXo1dVlfTrl0toCYT62p+/Avg0RLAxy54GVKMBTgz?=
 =?iso-8859-1?Q?0I558tA44WPQNSoU+rs9ZyHsm98XulHsqGi/kLJgNPUGdL6rEQKM9Nz0xP?=
 =?iso-8859-1?Q?r6mCjW9m7sWAwOIYaHm1t6W7rJUBoztw5pE2o9QJzFvX+dc9+yltbOt0+s?=
 =?iso-8859-1?Q?LvExEnesGuD8f3fh2JU5MVeQYhbp6nb2v6AvX+OcfcQH0YGnBaN2ssUzIY?=
 =?iso-8859-1?Q?8SmVKuh+AyyeIrcxlUI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d4fe51-e9cb-450a-fde1-08de0bebbdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:06.0338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Hgku4DcKh0qM85wyhmLdptHZMoPyGZuCnyld1695mVeb6J1GN2D3HLGxhEnMMLrBqzjzIlcIlxe9DWI3oMw3PIemGByn5M+9stmohVmRbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fda450683..c09ce9fc62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3299,6 +3301,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

