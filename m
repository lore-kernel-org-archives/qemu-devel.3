Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470DDC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLIy-0001ds-Ko; Thu, 17 Jul 2025 05:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4x-0006UK-L2; Thu, 17 Jul 2025 05:39:05 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4s-0002Pg-L6; Thu, 17 Jul 2025 05:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoiLnStgZu1hzj1Of56/YJ/+je/n5fj2y07xPn4OkZF86kB9zPFIQadSh2eYHmsWyP6V220dMu4HwXeh8CIhfVoXA+HagAbLMSsGmWT+PIU9SxzDt4fGJFf41LAo1jkPvB4ZZk8jjmCnm+rOIG0jrYSNcjfohocMTyyoizsIh6/7syMJgc0I0IX0CW0yzZzOwVwWnO+mwcz3FA1yWV4UEIKtyl2+sdoKJq6GGXRZ0Xp3HkcwAR6PVjdeuhx++T1ju0msP81vPf0Yc29Jh2EFJHBb4rvkbm4ha3zgvgsKgIynPvooyyRmYhyX7ey2ZdaNfP/wbCaXW+RhgM8caBZYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtsCnvftb9wllnqb2mPZsL5RZbrmQEM+KYTp/gPdncU=;
 b=jZVkj34A/6tck5K3siUa4keWc7JOtzP2Ftj93obi4AxwYx1YEfkbC/x4Iyi+3xNFRZhAFecLEyAtksm7kexYpxH+oOTj/6LAAWenBpIGB8/2GCdnID3P0Phh2hWI2U89M3n6oMlIeMuC6krwmgID3yNXZayGnWUBiSMOOqXgmkN4gNWPlysTVL6sSpjfxHE3oot7FtCJ7MmSKzi6Q4CHphhZJX6Ggc41kUnrQvBN0fTYKTrairjYSkpSdNiJQCKDT45U2U86PkkgQFRu9w6QeLdbiswwKTiE6bVwmRHaaLXla02whkmbTqQzHAu/P7RUWTZR3JuU3piYES1JblugEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtsCnvftb9wllnqb2mPZsL5RZbrmQEM+KYTp/gPdncU=;
 b=Fi7aTpdp2Uh3IuKUvkLqwxpRhGkgeWaB58Y34xl+FnYob+W9W5e6p7KBH33of98CbIsM/Ug3avQhHb5WCx/4qO1ZfRCvuJdvlis4JRdGjo4/sR/+GvU6ipml5mh6u4jRBf97c7KcxkhW5ToOEZJi8AmLkfWsKPbbaw40UlZAVv4SfXiTd18qYujVckrxL7gIFb0SD9iNpBBhuPP9HKl9/7C7hGHQIgBH6Wg2XUfavoF6oUjjHODjy6uap4dyykZHFzcrzJO9Mswqu6/PIKhAXSvB/1mNBcGqyt3UY5bvpxM4lSzpvpYiMS97UspWFbQ8ywlHvgO8n/8wH7ktNS8C3w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:46 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:46 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 06/14] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v6 06/14] target/riscv: Add mips.pref instruction
Thread-Index: AQHb9v6WPc6bCl3reEGpKQbWUCrgtQ==
Date: Thu, 17 Jul 2025 09:38:43 +0000
Message-ID: <20250717093833.402237-7-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: 10df3eea-8f26-4be5-e1d7-08ddc515b9f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?od0welB/QhV4aqvy2jcParTPmMXn/2zCGigucSdp26kslT5SPhMfvJm6x6?=
 =?iso-8859-1?Q?jLTniwLOwqmnn4fGNW5zSDWd++mXObs11W+ik+lUlWaC+6aoPV7LXL2cS9?=
 =?iso-8859-1?Q?afvIPvd2T7Apy0vvcli5Jmd9FNy/snzZ/MloIOtSatJYPyjnOgyEzBEZix?=
 =?iso-8859-1?Q?q71lcJzelr7fY4n25CXTVRiPhaiRsi/EVpV1EquYZAAXUsnrbrvhRbmPzi?=
 =?iso-8859-1?Q?hIBMYoEwu+lAAI/YEjALtn4iwT98syzUZFAEbGAaqFAEhqCoGWnR+Q+rCT?=
 =?iso-8859-1?Q?lc8z3CzeYEAnqxQFTiqIbdR/14C9ChEmJ+EoOCt4teUs/u35b/2rOLQhJA?=
 =?iso-8859-1?Q?Le4EY0fPrN1/TkSdGSS6MPvCW+Ep5jU+1kZ+gsFz6zabtY26eTrwDw+VMK?=
 =?iso-8859-1?Q?nWgRYZwxyaF6izoRgsQv3vyNGxdMynv+yh3ZGdaIruBMLD20Dx6uwoAtB3?=
 =?iso-8859-1?Q?NzP+40oMehx4nKxCY3aDywtZrlA4hq10Aa5yRrjBevsgEfetQUDnLu4zoE?=
 =?iso-8859-1?Q?LGOx48ILfvUvnwAyxkHXZPVmlWXbiEAGclnQsQc3BJcQUcGVjU2lrnsr7q?=
 =?iso-8859-1?Q?85ka7nCz+XeJqoEl/ZsDFjCYDUQZqtNwAAT0pJUk2RHU6kZgDvfVbEYhoA?=
 =?iso-8859-1?Q?/4312YTYVFqmPrSLV0bl+zHbM8xvE5DAIezkre7cuHEb1DpWcNKrAblDIw?=
 =?iso-8859-1?Q?dHaUhJT4iQZxogwO6csEk5PxyB0vKmJ0r9XnPmixwYIZDArUEaaxkpaykX?=
 =?iso-8859-1?Q?esryNqAT4DDFowBAhRMXDEq1FfPvWXbxpJSM67CFdiroZXSyfwkVxuPcig?=
 =?iso-8859-1?Q?fQuOwhhrPuMh4qAP5V1rj166J1IoF5LSbhcdzWQArpJV31WrlkFBUyS3cP?=
 =?iso-8859-1?Q?OPhAQs5MIp8grr2wQvvShYFGufSNSQhbRShJt70LOYNlPf00EghrLQ+We+?=
 =?iso-8859-1?Q?7ZE/c9x3TM/6s/fAWyQPorfPw2x9Kej6y9H8OqWL1OpkiEqYDuc16p8AdK?=
 =?iso-8859-1?Q?41YmRw9JAA4Ak7fiPcNTcG/11PONIjOSS8AAGGG3lIdvHFDDSz/k/g3GF/?=
 =?iso-8859-1?Q?nOthAl4bxaOLyriJ64C+yLMFYCF97w5ntRn8/9YiCB4v0tVcMLuNkv20aV?=
 =?iso-8859-1?Q?w+OgGPE/jI1Rvk/p1AhHc26dbssw6VO9Kshc1hKdqJ4joNDhjWePSDmMO8?=
 =?iso-8859-1?Q?gQOPhpbR+RGY61XXtvcuZhl1COZpZa+eAyWCfT2lMBNY9kZ3S+gsO89FL3?=
 =?iso-8859-1?Q?XsHFZ6AFFjegrlxktcovE39Auf49/9HR0Y4qQ23g7526XIIW1jNGkfzWFb?=
 =?iso-8859-1?Q?0PtLWxlo4Qn7OvZmGYvKQc+cdmQaYHzhSZCbVzqg7YdV9uuKMPVLWzoHmi?=
 =?iso-8859-1?Q?9VCvDKB1RAGBfswVFVaYgUOgx8LbL3cTqOGZY+Ad0OCPZqwfTcM6hKzHoV?=
 =?iso-8859-1?Q?15r3tM9jPqSjzM/qE3gVDZ6r9fnVyuOmjaGeNqkd7XQVmGdNO/TSbcKz22?=
 =?iso-8859-1?Q?d8SWduQChnu5foP2t4PaXXU+ctrowxYbz6sPqNrrasxYkv83H+NgP7+0VX?=
 =?iso-8859-1?Q?8tgN8zc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oAiCLGtx7zze0znVJaX5OOxv9J5bhrjdiIuC1131z13lovS4JNqZ0ldM3o?=
 =?iso-8859-1?Q?JMZSfV3QxaZmI6cqV9P5B40jA2cANrLGsD9O5+JZhzYYnpLFYN0a0FeIo1?=
 =?iso-8859-1?Q?IpO/J1OhIBUM3cERjRfhxWOP6P6eGJfw4S7HLWU9JFlecXmXdzeRUI9SQB?=
 =?iso-8859-1?Q?nUaylWzkg6gATXD4lQJcoIDuxb8RrqMWmT7QPJ/SvugYUOF2dIGo1GaVld?=
 =?iso-8859-1?Q?dI37fIt2xP3BFkQ8ddEKTEUXNFiyb3gho+CU+DEZhGYsU1cbLCFXWuV/Qw?=
 =?iso-8859-1?Q?CKboGLPHK1Cp9IZiGHl+l2N2+Yl7xXdpoWc0mu4NIkp8UX8UZAdHBToRq9?=
 =?iso-8859-1?Q?d0aulxG6O/6j4TFRiEUCh5qw+sIiq4lsf7zdaEeujEdRZBRSKwyM3mr3By?=
 =?iso-8859-1?Q?RDb2X0yTyb4jBWuAhKaRZQlKju7m11zBS0Kc6YBAWQB5bz0Sh3t3g98FsL?=
 =?iso-8859-1?Q?GUmRh6J+q1L7oE6eIWkykrWKwsqThgMF93gD5qFMzKZLsOQO5EqCyjnHe3?=
 =?iso-8859-1?Q?0TQu3Kb2nezsQrBVICCWEn8xFgb+mKL30VKh0hxQSD/GGf7hzr5W3q6dGR?=
 =?iso-8859-1?Q?3pGsAWFPCLXwrtXQTvq0M4GTw1NYAYG0lhacJRSXPcAkk52JIdhHgWk/5r?=
 =?iso-8859-1?Q?BCI/R3m3IGuS5V2//beX0tNifuQ1dcsViikEnc0j99omE9b3JaHdPB1zLH?=
 =?iso-8859-1?Q?GLfqHprNYCvhxbUTpD2dCQW9zWi/k88bV5UP6XPpVckMzB7Z5lNZKaAP5k?=
 =?iso-8859-1?Q?lZnWDuNcU8rrKsDDlEzc3XNA8zfUJha+RZF1pMRzdDumlt11+8dNFZvnCa?=
 =?iso-8859-1?Q?E465/bmOXbin365VbZLQLEfqWHSRE9xjHfj+FD30XMflV9DtGKBn9cpjvT?=
 =?iso-8859-1?Q?WDx9R8mLt9c65IhzOmX5OpIZV7I3EukCnH68Jx9ZVztZPeHsKGS5k2Ljfi?=
 =?iso-8859-1?Q?J1762ZZVjezswAzE/+YTGp36B1ZSldDOpsAEnADYDDjJ9cQbg5oLeWzx8c?=
 =?iso-8859-1?Q?RU7e+XnZiVyISXSFaffRPNiO2vWfuw7K0Zf9hTLgz0oGHxfsOnRV26dfrM?=
 =?iso-8859-1?Q?edBZi6JBIjD74XWEWrAJsra6KO3g62vWlDZXQi9TvrfdP09XyNTN49nAy/?=
 =?iso-8859-1?Q?Ku/uRsJRCXQJiLBY7B2xh4IbugVk24QMYrdb7M/boBwYHt5vnQTltf1Gi6?=
 =?iso-8859-1?Q?kzq2jTDoiGnYXmDu72qpm4j/Qm4rVWfs2vNW0VeCZMv5M5yR8y8GHmL77Z?=
 =?iso-8859-1?Q?ICmi4ariCHReUVKQ/BDblaXxUExKWZDlDQyM45dT1Dp6ypyIImx5VFi0WB?=
 =?iso-8859-1?Q?weE7K42KTunhxmpHLK5XUh8zRuoPXaCd/GZK02ecqxlNPySX9DLIAVj0yB?=
 =?iso-8859-1?Q?OsJUIjO41FG3kwWLOh4GOiuf7uI0CUBJxUWkQGb4jmCXtKr2R7jusWGwrZ?=
 =?iso-8859-1?Q?0OV8Fr8c5tEHQ7Tw2/uhML3KheRxKmP8W1qg2aJrBnAuy80A3tIC+By6GJ?=
 =?iso-8859-1?Q?4PYp1iFHSGuNEN12/jDBA1OxfDOSfVtbvwubIRFRnAe+0eDmZwO90AjdQ2?=
 =?iso-8859-1?Q?pVc0Ra+o0vOack3YmnO2wLZkKaEgzvozkWWYPIuGUV+odpFQ7wxPAYsI8j?=
 =?iso-8859-1?Q?U+tzvDOL9gflkI9oVhsE0zGJfDR4/CJ28r/kIRJZ+Aa7YJvr2FKiqqbL3f?=
 =?iso-8859-1?Q?lPAobNP9JTYwhEYM9fU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df3eea-8f26-4be5-e1d7-08ddc515b9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:43.7552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etvEHNWf94LmVVxRAj4Z/HLsd7Zdazap3+0zFxOycB+RW1V9GeGZYQGQSz7lxZnYiXXgcrDiDAkIN+SkJTjL4Ah0QOKoN2odab/8nRgR4LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
index 52828846c6..d280648b55 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -243,6 +243,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1374,6 +1375,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3193,6 +3195,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index f5aeacc6fd..620c59cc28 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
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
@@ -42,3 +48,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
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

