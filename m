Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF320CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeU-0003jL-Se; Wed, 24 Sep 2025 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeF-0003fc-1R; Wed, 24 Sep 2025 05:18:53 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le8-0002yg-Ks; Wed, 24 Sep 2025 05:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0WqRqog3APBaWtP9jxUyzgVNdNjjumNV2N7TkDBPhQYL0qTIsjGLnNr/b5fAXZbH6e0LKqWABUAUSalCPCIjuLqkrIFNSxhMw8X+ITqnpWAu9B4ANDxYrdBNVCXyeo6qt7KWHN/6oT0oBj/VKL5pDbL4fCI18okcWPNJKvs/UQiM77tr18suHYJvTsqE5edOyKTXWVpLmAI6rMXcZn2c4Tb1ZJFVTR44yIYsuChM3Us5szsVgApa1wgOp2FoTch9ghpE6E74bpVPrU32pHOQ+QS3z7WNM02KxgyCGqZ1w4Su0TE+VGj5HGHyG1iES7wYj8Lhd/0mPRhVRHHDW/uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYZN9PaM4iRBHsti5KqZjYGrABk6hx9huoM0TLPH644=;
 b=dd4Da06HoG/Pxv15aItl9Q+kombMflfOBfg1yL3GhbpArAS74KSShqPYI1WK/XhfgpO0TTW1KjBIzg2czyZMS4+m1xTknh5tM3ZGbTuieWJLN6L1+n/t+xvf/ZsK9He5p497XNCgdTSE5iNz8M3Fsdq8KVa+HU1lW0pnwIjBa9X1tsFQs7ORw8ZloBNy6uCcGvRegbgAwv4vDgaET0tziMEIOEhsVXVADByY3il01soqR9m/gxWftIsV77ms+eDgfnZB00AQa7HTOSZKEZ4PZOtz56TpEyYaRLR/9fyXeHSAqS8MlADDR4wTvAMJ89AIyOH9c8PpMuKkTjLHTWAHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYZN9PaM4iRBHsti5KqZjYGrABk6hx9huoM0TLPH644=;
 b=KP4PrgXCgcdEfDw7d3IcIyKUO3lffCRVYVSf9Bev5ouBK8j4CUompbSGrGrbr4zlwwImHlgQOKbrz38EDKMOToM8G7kEkGdVMRPvEasnjOZj6uDTFR7I8eTmbBzPSVbt9ktm8dy31Wq2KCb2muVHU4hs/ZFUvTSfWaW0ZnqbPXfuG7CV2Jf0XpZp6YnswVns7Plmb+8PMjMPg0CBJ+CL6r9YnWXgi6inBivL2ScCfhbvm3iBQIhhWxfj8EfTs+n2wiKnydjAH69iSPza9MYiM5fYL+JLg7rYRgpjNTWf0qJ1WjZNZ37509SSkMo6UVLiuWZ3BFdwWhFvGwyCyO5tdA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 06/14] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v8 06/14] target/riscv: Add mips.pref instruction
Thread-Index: AQHcLTQo8VdT08KXYkOLNhB/TfR/uw==
Date: Wed, 24 Sep 2025 09:18:15 +0000
Message-ID: <20250924091746.1882125-7-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: e98e1c08-5206-486d-8746-08ddfb4b4cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CDpd1XCA5kTXFiooYKcf67MBiq9zD7aHlQ7wgcjTZnuk7D/mWbCeJrkhMk?=
 =?iso-8859-1?Q?hNqFhDgSQo52mswRjGrNmUrlLY6BYGOiwVqzHQ07yKJqIom+1V9aGZyQ1B?=
 =?iso-8859-1?Q?C0FV5PvwFFYghJs1qgac+F4/sVnOwxlnKDFyRzrxj7sRfo8D1o0tFi2wo6?=
 =?iso-8859-1?Q?lFzMhFzHG6IXr/P4sMk3yHtjksNYskt+uSdnaTwWgNoVYDVt8Hb4RDiRWY?=
 =?iso-8859-1?Q?L7FZ6IcnIum3papkzneCzRFWUWHtqrOnVdwrnc/hlfRZyCa/mvzXI+9F63?=
 =?iso-8859-1?Q?VD4Xo9MpnLyNnKT+cfVQgWSGvDjkaUA3bfAI1P+8a7hozPY8tpAtwAy5w0?=
 =?iso-8859-1?Q?tLGxEctR2mOCexFWUfPM94mLIyZlPLuxrxNaSPJRVGmXvcsoy5jPet2+vw?=
 =?iso-8859-1?Q?BD49UP60UD3Hc+PvRrVmhX1gSac49tB7TwHRU+W+jjpUz2RCuV4UFfjo3I?=
 =?iso-8859-1?Q?uHd3xHfsfPcPXg+mAyMPtVYvACrLYa3Dg4VDb8K+Qu5GyO0a8XKLF6VMaQ?=
 =?iso-8859-1?Q?EiQ/+kcZdXlOceKT5XqoQs5we/I4lohnjSvcRg7SF9oIU5V5iAGIbEjkzF?=
 =?iso-8859-1?Q?XWYENKe30tvow80oKpIrLyGHSdZ1XiK7/IXbuyjc9NSWkIP0gAaljup9pU?=
 =?iso-8859-1?Q?57i7eC2yhLhApzJOe5SfKHHLfSYCx+W8wF4Ka5uZ3QLakWkOnQyJ74F+4W?=
 =?iso-8859-1?Q?69R6ga/76NJX2V1t62Zwge/Y5KyF/zRDIQ0P6lfhpv988JCDjXoRrLPdup?=
 =?iso-8859-1?Q?azMcoQEF3kI1o4ijp8doK6VL/+2BGZgW70rpouhZA/W9fqAJKoIaAYjmxT?=
 =?iso-8859-1?Q?R2uE+3YOsy5nTNHy2ZT/XNB6DVHgIzJCpqAU95NQqn6wSfoHOVOW6ekWWO?=
 =?iso-8859-1?Q?uXwLuQDzRsD4BWlQ/RClBCn4h/iUs9kPqtNECNcLs6yK890AaVTIDYqtBz?=
 =?iso-8859-1?Q?dV8n7PKjan9FpKa6kr4lRVimdIVkRZFoZbT8QEsBZMkXUnOcSsBQoItmOO?=
 =?iso-8859-1?Q?wZOdMR0l3cszcHcQiK+3Xcg9KHo4IKVvd0kHuMzGl4IO9YCzb9K29BBpkX?=
 =?iso-8859-1?Q?oc8OLhSsDmByJ5twGdQStc2lBbvGAxIfQz6oZjYg5RxwjS5rQ+f5mywkB7?=
 =?iso-8859-1?Q?fTRMDjcAlRBcIwT50CgBFMtzzrTYYMtnp1Rxo4BZnDr8DkA+7PhrtZ29iG?=
 =?iso-8859-1?Q?ZAvSyJlveRF2MvQAkTWdMY3mv59s7ZTao6OHgjqoiB7vFUEsrgtm9H+DFR?=
 =?iso-8859-1?Q?rU57n4oLw+kOVht4bpanmRrMEtARKSDYl47PcoIysSGTPUuoz44mVOYQ87?=
 =?iso-8859-1?Q?uCQrc5Vr64Km2LciLCJwlwliwnMSjd5STD0JYv96bg3bWF/MdurIJhVB4b?=
 =?iso-8859-1?Q?8F0hwG4gcSLqG4eeloBxtyNR886vaj/DwHcsrIBy+ehP3mDmQ/NFb53/cs?=
 =?iso-8859-1?Q?N+y2YUSF998+zTDMJv+cpGNLAKFLCqvaRR1QTAcLaKTzDy2hDdMBLJnBw7?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6awP6zmlcdhlV2q0vL6d5Eq/pv1ZJNvnF74/H3CZlniodzqMmlyS7DoSjA?=
 =?iso-8859-1?Q?296TOuYUvoVhMw1C2ExPFLlqFk5H40Mpbd4kukdzYUbKFmJhTebMcBTG8q?=
 =?iso-8859-1?Q?PcMwpLLKjqsmskzMOKqBJcMMTYCylhDw7Hzpvh5JDLrz9OvtZhZAKsFeiB?=
 =?iso-8859-1?Q?nd+Ip5+eF2YnWZ8UFuA094QbKlv9/C9mgATrmSDIkzGmREwdm1IqTFvqIl?=
 =?iso-8859-1?Q?moBGsrEOG3NT3p/1sBcBo4Uf5SgPE6B+O2YCLcxcQv32ITAVWC3aT/lWwS?=
 =?iso-8859-1?Q?xRzWPZkcO0FvANiZzC8FdyTs9w1+BZ11m6vGc9aQmXh5kj0XORAjJ+nn6W?=
 =?iso-8859-1?Q?pjkkyVhvR8+uIoM+Z7qaandLyv6askLhOn5cFb+2k/uZLnzoKoGrcYDJdF?=
 =?iso-8859-1?Q?DaJnPZ0fyl8DmyM8TrVMRRQk3ys4W5H5KyndtEZwD/PfQoTAbhUnIWXpCF?=
 =?iso-8859-1?Q?2u7Ku6BAYTHuWsU4j4FEHBuJUbG8v8B70N7IzbmbXaTkgezlyBagljNe0G?=
 =?iso-8859-1?Q?kXa0DjaY/VXCiVU0Jbi9gwfhoKw8GEy2bsksUkZWNO3ufpzJUvDufYW4mY?=
 =?iso-8859-1?Q?q5Tdb0TPgxCxZCjx//VS6Dq8wkhGKoBPX7vIIqY4ExmPw1FcbN9cDvBiGg?=
 =?iso-8859-1?Q?Oxndhq+1t+wqzCPF3R1FpXUWb0sNPlw0YSwPDOidzQSJjS+ywmcSd6OF9Q?=
 =?iso-8859-1?Q?6wuP2MshuuaYXh+G7uMjWDNH/drWDEA0rie0Z04jd5KbISGgps82QSxWpw?=
 =?iso-8859-1?Q?iHbjftxwCHueal8dwqXz6gFNuv1Ssd4JtD87WzaY4w7LlGpY+WDhVgsktm?=
 =?iso-8859-1?Q?JsPZf42GPSCucL+A1GfOyjeqk+MFabMJcqPTsXCJ981vAXEZn6tUk7cl8k?=
 =?iso-8859-1?Q?/e2IDL0apQyPVmoRQI+gaWZMKI3QEh07pHiKB24T4olgP56KzdZ6X8UE+4?=
 =?iso-8859-1?Q?pwG7obIkQ2bKupiC2Z/P40Slqn5DdnYtHn9pZ1U3IQGVquTldkF/7AgzX5?=
 =?iso-8859-1?Q?Ea4dvUDsN3mLrLHuyMm3dPFjP55iDyvO6Meai6mkpnBz2SyWmogv6PlNd3?=
 =?iso-8859-1?Q?S1Dibiu+MV3j6MO0mYQ0rZLBI1eBnFbBPoKqVS+WzkDEb7O8USmBNPz5y0?=
 =?iso-8859-1?Q?wpFJK7QjQvzxUu2yGM7maniNHuDM+Q4G7lZlrUetC7T3xTbO7UpXEk319L?=
 =?iso-8859-1?Q?5abFggM9wl/xU5dg+pPaR4S87e3uKHtUOD8yI2MEh1DffgF5sDux552tQG?=
 =?iso-8859-1?Q?k7dImxkusyK51SV3tcAQK89hBLdy4YzUA9WQGoB1yXMO6C+0uAFYvE++aD?=
 =?iso-8859-1?Q?SNMH8yyTg1AzRnaqo5Jk7Sb0XuNm/PtgJmdE1I7AKI2DBIGR+F/SPRz0kz?=
 =?iso-8859-1?Q?elgfLl439kKRCRbll4AMg07tLvTQdbsJuGLb1IZYoP30iL7dT5skduzpjh?=
 =?iso-8859-1?Q?sMwfrK0B9DpqjzhS7ll7R6C/AKzIsjbJVdIwGUJfwVZUcCuy/m/LiFbO7S?=
 =?iso-8859-1?Q?nq+gapiFGe4zdjTM2+QvR6NWiXI1aMz3vMnBfucVbqOmoExOYkV3VR2wbD?=
 =?iso-8859-1?Q?ivceRvJzt8HBecqWkckp8jIfrfXv+b2dNULkPo05BqLw9KL5y+1IxDj2+F?=
 =?iso-8859-1?Q?fbgonLqWsXHUNx3csk9lm1Hsmmb2dEgCgvt80dbSLLtKWyHxFocqvrEJhw?=
 =?iso-8859-1?Q?El54xPh6xIzvsFQNvy0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98e1c08-5206-486d-8746-08ddfb4b4cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:15.3831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WlQGSYjoiB/AKjn6KPJJOQMaNrkuLdtF3Emh6CgQy942F6iMNepAFQxYX5HWEEW62pYtR++fEzhvc6qliFxdlznoaPm7cZ45qnnRjT35Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 77fbf67776..87f9eb7ac4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1380,6 +1381,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
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
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 045034ae32..95b8238081 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
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
@@ -30,3 +36,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
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
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

