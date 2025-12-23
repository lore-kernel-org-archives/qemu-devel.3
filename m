Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCDE6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzz-0001Yz-RQ; Tue, 23 Dec 2025 04:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzx-0001Y5-PT; Tue, 23 Dec 2025 04:48:09 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzv-00025T-Fm; Tue, 23 Dec 2025 04:48:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVGYQhm9D5R8U07TULwMh+4CRufldllUFqiMaDluTcCfc2v9xnz4noXEMnYd8sInBrONNxPhx99SJJbzdqtx0I+3nvTi8Y3YxGTG6S2U2cwZ3CN//Lg+b5bIFmfjEl00N45S1+LzHKpg1XJ6oc8mABzeePIoQg3/S12TnN6eG5ptZR45MfPGqyXsLwiZrO5M+r8c3EzU8phWGKyLGcpXX8bPysCAcBtT9Zqi/l651HsdGvfjDSzXXgcdcjscPfj/0AQRnhKSvFHd3wULE8RQSy6KftoHviKNoJ7C3LGEF+o+15ilSmXoapvlGVpbXhcvs0cgVZW+DkwISLaTinaVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpJ10eDR7uDwkeoJ0l/C14jg6f/cM+qcWz9ftkbEqI0=;
 b=TJHPDRcdoIYEC46e9YLRCMkvL4+Yb4VMv8zhPvmCCT+qCidsRW+YiqYK9uDxsag2+3H3wHhbc3VzsJ5yUIyM6+Yj/AzZhyezHZGm9zsWtJR1nCZBjqS9ApUJjK2pY5LxtNMJ/uKBr2RiPCtd62f31eOaWa/lhC1I1mpu59u32gvM8wqy0l2zSdXbfz1iwAWTL2p1j3bKJQoxxrPUbJ6DjtNiJiMQFfvMZEj+zDMWa9HMJzJCrtCDlr6wyAVgVxrGDw6qQRw+mxdxmptzkBt1L2FGbUZU0BuYagOQ+BNAwLspQIsrBpXe41T8eUwCIcNhZPLYZfC8yt2KaUN0FjUdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpJ10eDR7uDwkeoJ0l/C14jg6f/cM+qcWz9ftkbEqI0=;
 b=t+cvl1zNbtWKZtMMwEf8Z8IvI5kXqoq3zkH4MO7FgNy1Oy0/0/5oprxQ1nl6JZpaKSCVnigP+9acH+iy0lUB6+tEL3FFaiCjQZJ2mssP7qdp3t10qqAKoyX/Q92AvtgGDk6G2EEukMW2Ranxwx7X4z5Fa/blxxydltmd1AWdJLMReZZ2F4kzH+yvbXMmMzMAjhxtH/vdUxjxd9ad07PqaNrfCfAe2ccCMnsJ12Ybh4zZbMtE0TdQpwH4ENWbhXOhl7HG0ZP6FbXu7fF3mekocBMaxv8APpozzNIkPr6g48IjxzF6BqThZII76YlpG/Y5mpLJCd8BcOKA1e8Bi4em6Q==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:58 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:58 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v15 08/12] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v15 08/12] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcc/E2RUjhR9IPUkCdw9sG5Ozcjw==
Date: Tue, 23 Dec 2025 09:47:55 +0000
Message-ID: <20251223094739.1983381-9-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: 4bcc984b-1fbc-4a2b-0aea-08de42085aad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IgXIYnNKnUpup978WMDLOO6/cPYn1z3aP5h1V0W8uXa2L1m7X5yNXLOD4N?=
 =?iso-8859-1?Q?CsIluWAmdZSOHBVlCDCYgubmveT08Vo7HpUJtmBGOGrOVB01m6iTEXP4Q9?=
 =?iso-8859-1?Q?MV9IKIbUytA8B4Fb5wLemSOoZy2j8aD1ds+84WAkaB0hgOfx6cv9demKfy?=
 =?iso-8859-1?Q?lcgx4bXm5WmvDsI/ei9SwAOQZLoghY+xwmjOcoH2nhcmQuF77f8VbeNcy5?=
 =?iso-8859-1?Q?tIl6VeIX1/mtWcK3+/TnUXYO5NUWxhZ0qlpCgX79UHDOsbo/4OxgoDaK5d?=
 =?iso-8859-1?Q?Zk1lgUBfIaZo/fZn8CaYGifAmEdi4iOOFozy97rVCbOIzNtfFitNAJRT/H?=
 =?iso-8859-1?Q?5I1QXMJ6WY4vwa6PTPKRB/+m4bcD9vaYBc1GI9+P8AO5Padr9Z0wlwP9Lf?=
 =?iso-8859-1?Q?SD4PpTn8Cy282QsS1jZFpU/Po/8809ZqMeDvPHS0UKX8vto3wcG3ZQctTf?=
 =?iso-8859-1?Q?Vu6eI+m4hmImdymKXvplcO1Ae5AQUOr40Vw+K0pwW/ClMSzYFBHXqAgx+U?=
 =?iso-8859-1?Q?0jiUolrg5tQpwvzPBsyiE4YzO90Ik7zuIUw3tBy4dQSX3pER26fXyrWQP2?=
 =?iso-8859-1?Q?VTEx0lH3+AnRaNq8of3OFh+SpZlhAbqTa3NPlp3rYmP8VJK5vccmi9re4x?=
 =?iso-8859-1?Q?wC9Wm1y0gdAE8zrModAsX58OiHZmWJJ9uwtV2jArYtJpygoxlqHjT1AAYz?=
 =?iso-8859-1?Q?sNJ4hTkA4XqeAjZBc0UQeI7JXyUgu5m42jxEcerVlrhTTMmRncY+21V9qN?=
 =?iso-8859-1?Q?NlKog18mE89eim+XxE7+n7z2U7caCaMG5o8FtawfGaU2y6pilm5EjLvzHo?=
 =?iso-8859-1?Q?TIpHZquStwOPcEKaQEP5vdf5Ki2rwVU53ymTavA/SkEoRPyNMZumMIM8Ka?=
 =?iso-8859-1?Q?kVeYRtQMi/sjeocT6dxMv/5DUCOM7Cez4rjyWUqVq+SvTx2xGKXepN+X6B?=
 =?iso-8859-1?Q?SKxHeyAzYoO48ZoWRO4mWOiOXXoLc2lEwddFiYC3AP/vNcILRmQIqaHOHf?=
 =?iso-8859-1?Q?0vAgDc9Pd2NGjx0FLYEtGDJ7RF37rM9nZ7n1oDhgozboPD5HHU3oBOCUTF?=
 =?iso-8859-1?Q?VqjDX9537TLbuexvSnSz/C8mqwkiTK2Dfwvb+bzDIjjIQ5MdR0o8s0VHqV?=
 =?iso-8859-1?Q?NwMgfUCM+GFoh1gvSxNk5ZGvkH5LRWeyZZKi+sTt7XQRHnik9ffIMwcDF9?=
 =?iso-8859-1?Q?K9iq678ISYWONlQQsVQdAK+VN3YXa6AO2vZBlJ3mVyzLMDVzFNX+f7a4Mm?=
 =?iso-8859-1?Q?Gb+mw7koPxELxj46agpY9tbxerNrmfSIfiBBWxgXQHsTLEzyFu2kyUdUv7?=
 =?iso-8859-1?Q?ra8y4eCQkUfAocX7UKoMeRoqZNY9L1oPZrMR4BVNUkVwUceB87s+l7C6M5?=
 =?iso-8859-1?Q?wYaAoz+i9+opH1nkMXSvIhXp8oefwAFaqpYvvpUXrl7ZD013+CJHGXFXig?=
 =?iso-8859-1?Q?OVX8tBGicbJHJ2x8x79x+xiOWk6GXtYBEOkfA3hxr7EjnBrvfcYts99i1S?=
 =?iso-8859-1?Q?IXDYeXSV/CfGkdIRtHRoSNoLzmuB5yfg0IFXlUcwNRrUmNDtvvORyhidjd?=
 =?iso-8859-1?Q?7wFcWnfgt0SIdzV1UhiTKOye21Hv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tEt0h2DSnj9IQopDJI7fRMmmJld8Dj2ifKWtvz/TmZAx1L5VkXcARPC+AQ?=
 =?iso-8859-1?Q?wsbvn0wvtXCSFUwsXjWDdAjno8eX32S5EAs0KcQO2XDi4os9fUkUpGJYrM?=
 =?iso-8859-1?Q?rTouJ/afv6DZpYolfnk4rOAaaeIReS8ix1cVLJiNcwvHKe1sHbwMGtQKY/?=
 =?iso-8859-1?Q?0x4s+t+yqNVJ/zkJglzB2PeLqlaBIkre6LDf8h3AZFSWDS4FMfvbyI+kx4?=
 =?iso-8859-1?Q?ApdvMPdATGhA+AJtD2HDByWiVTD4FEeyvEBskXOFsW596oQMl7Po+AdtCL?=
 =?iso-8859-1?Q?vWV9BEnNVXw6V3evKTfVd/FmRIWMnAqiLtkKrhmSdOYaeaWFGlm1dK2StU?=
 =?iso-8859-1?Q?7lZx3bIF3p19Po2I1sLV2JZRfTLaC/FNtSjjZ4IDGcqUHRoKMZYwL5eg6x?=
 =?iso-8859-1?Q?EkzY84QNGzqCbBbmv4vxAMOie5bqwGDPOqC/0lgGWvXeTbEx0vE4rm8CgE?=
 =?iso-8859-1?Q?0sqVXoFO7fi1+n6Gnjqp57p0hrWJNNa9CwXeplMMfq0ZY0QU0H8BRZ/Qkb?=
 =?iso-8859-1?Q?gbwfoKtvNYh/BN8ra9GytiuHRRIydcXu8kVYJ0EggG4mwIdH3HSgmIus26?=
 =?iso-8859-1?Q?NK8SW0xghDDB9Zqmug7XBl8KcgbDcJEgqDxWAs9jeKYV6758e1iSrZWOdf?=
 =?iso-8859-1?Q?D8n8E8HHF1euv3p0th9E3a6z6KLCjcCtFmJjc7fVMwO2Iye85I7Y4vtD1p?=
 =?iso-8859-1?Q?NMFsY8tVI59QruHNAH/jC1rZT0TpKB7xNk04VeJn69sxpw416nHey/ilZt?=
 =?iso-8859-1?Q?wp9zDy6fmMtEtCUqK6DQCMXqiYh9g6ZO2wokIsTR0ORiXIoBDheXKPRKgI?=
 =?iso-8859-1?Q?LTN1C5ADl0FrC248D7NcAGrDmHl+mEyEAeOKX9Hwj5HZ0ExTBDrqpGia5X?=
 =?iso-8859-1?Q?mN/eh6rNc2ai39miGetZKq7F8SShGyynVvnDwP/FS1KrUDg1H7eRKFKJL4?=
 =?iso-8859-1?Q?/QckEfs0/OjfUKLABysv68o3a+qDJXyO+5znc3sLiO3oOm8iX6fNjw7GIn?=
 =?iso-8859-1?Q?EM5uGPOndYUTtmgW3c6NcE5vV9T8e4ImzNeA2tZGufcqNrcNa2Q6iKk9YM?=
 =?iso-8859-1?Q?MWDr4CEqYqtheDfGhMIjJdd+fHHibVlNR9clGe+ms3+V9U194/5AVO/ppx?=
 =?iso-8859-1?Q?F7FBZzHdCDuLNae/mC8LzTtvXzyZZX7uONcpqq0aKU8A5SQR79nyW6TPRv?=
 =?iso-8859-1?Q?k25ZcH6mXeKpWSJxxsHKcNqpiFbrrNeZr04IsslzSWQwtASrGeJkG1qlaW?=
 =?iso-8859-1?Q?RB8rGpZ5wOoHKQyYza/Fhp3hOjwVkjS+9beAMklIEEEV1SlLyNRTElJv5y?=
 =?iso-8859-1?Q?1L5mBhrlhSJ1ef+sYqqvdnKjemwNnlTtXYakZF/u5o+lbliGuFaxpi8/yg?=
 =?iso-8859-1?Q?Y0dahEGFX5n9xl5YMJGjHS7XPPW9LTU7NEPVqx+eWbbujevI+kn/fxdKYr?=
 =?iso-8859-1?Q?g+PhLdPznLy5BU5SEvtRrXHjB2vDlkozdU+F1W8E4f3GOCX1AadjWZ4Uy8?=
 =?iso-8859-1?Q?6D8AZD//RPOIn6BK3UHQSWg+MVDv+T3oiKlxEdDWQXtt5tucbPx/8Gxmm/?=
 =?iso-8859-1?Q?zSWydJIsjYHqQw7H5fE/hgpS7bkC4paystq043e0mY+o/a/AUYWWYGXmBf?=
 =?iso-8859-1?Q?Mf5TJlKzLW6XnYYYtMyoQw0OKLR4K9Yk0LQxb1YNcYBM1gFMkYqn41xqh8?=
 =?iso-8859-1?Q?RAlfpSZff0wa8mnuiwlZ8lp3p9Hblx3FZS0QLM0Pd3nLBKtYSeDiPOYIEC?=
 =?iso-8859-1?Q?thKM7YmESJ10heD6Ytcv5KUnpzuKJMmidVhY2WlyjP7kvVgQ2BPXQwBUUy?=
 =?iso-8859-1?Q?sT9st5VQF9xyMj7DtqA+bFn+RaHeQ3Z71f+qbNecA03YVnp7doDw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcc984b-1fbc-4a2b-0aea-08de42085aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:55.4558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJjqYFTkeHsfWG5VsyrZUTd2J0fyM0jTvVIJdX1mQWyUx11+EA4ffo8eXEDAVXDZ3xIT1E7U8GQuRXatyR5szdXPPqCGgUB+x2KS/kE7pR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 404500979c..38be72b141 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
=20
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c=
'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..344f855847
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

