Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26858CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXk-0008CU-BV; Tue, 18 Nov 2025 03:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXj-0008CA-H7; Tue, 18 Nov 2025 03:58:31 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXh-0003VY-CT; Tue, 18 Nov 2025 03:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkk7jC8prAGsDrESTx8DQJ35tAlo6t4m2tTYFpUvJwX1fpjctH060KpK9MkPknx6ncpodJRZN3Xe3lhrovINMSDHyJrwzkxHCeGAvJ9FQhdbfkZvI/ps6BA5g4Sa2Uo8gTGuu0APD094XB61p9R/w85aeR2z3lWIQ2XfJHFvJuUyMuMjgwLENqvBTxLipnaD80/s+4pOaR3iW1oDg+cDjqDivL6CKADBaelw5P+vNK93ZNJBybOo7U1oYIRJHvruwqQ8WsJK/x9FpGAojQGQnle1jq3u1QOOUIZlgYUNhfqmSMmAz5kdrr924G7z5yONwqhQVryWIHkqdT0k/HrTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=g0z76zTQjHxqbjU0Cr6GR8s/mEK3J0f/MGdElbNfudj3aapjjevgt2tRmXUZ67bsVW51cYMWHogovLdEsYDjc6FnxuWlVKqLkAuWLpCZ5LhKGVwG6rsqJiKWBgriqHIiTg85YKjhj3NGNfVLb7tEe8A4cTxYdz0yKl6JiQ8LxdF+g52khwKG/gXX4f0tnQkKd0vlkEhwOmPYjDmD9H/wm1JN0Q7yprB0dZmyDLKn/OJ4MkWHoPfK3F9v8AMcIOo0bBc5Gf93ZP52f0npiMK0DLMWZ2zOIwV+VL7l1an7YcwFDtUIAvNfenLjai25KBp/anCauo0lhvVeJC1KYx/QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=RafegcqBSlZBxDPLYs3hB2T4Igek9/uwSs9k4wrRcw0Zm7GZq5RWh8rl3XzBkZARKe58Sc+sInWBO0d+Poh6dS9xbxrAZ4tf2OBXtTZLYFyLh3NCHFTTdo4sQgraKldH6Jv5vtuH9lJzyT/uD6vBJNsoTxjCFEVmLDDUifPU/f+8WZkmbm/w3GOfug8hTyv+1xOANGrzlSCUF8XYYPQE2024Qy7Dk7QDbaD6pUNrV4NC1Va+BLx5wQypakuNTz0aoPgmVr90M4s4u6iFTcXBqf0Blg+Cel6C7ETbKwFoOiu0Py55nN4xY3SmuS1TnpJER81jKDniYiwCnjBI82LC9A==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:09 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v14 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v14 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcWGl2yI3XEdqoFEWwO8OUzpBxGQ==
Date: Tue, 18 Nov 2025 08:58:08 +0000
Message-ID: <20251118085758.3996513-10-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: e119ca6e-ef76-49c4-8731-08de2680988d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DFP7IFii026Hm01hzljcPAGrtHimrUq26iI26L3VsZR4SN49eXcaqm0BGE?=
 =?iso-8859-1?Q?GP0tj1C7jt0K85cTLuwtXfBEoyblhmNEfFfy6yI4Mpv8Z4S4jULhai0W6o?=
 =?iso-8859-1?Q?8UyjoN1/b2jNCrL+pbL1GXgiwKg+fvlBgih1z+Eg12snAIvUdqWM9Ti0Ib?=
 =?iso-8859-1?Q?1WZbhXGje+8JGu+5a8jdk50Slngs365NhDInoVjiwOTJa74x3xf1+U/K27?=
 =?iso-8859-1?Q?wpgouwz/nA8pv13hj6VJPZliG3Nbb5pZ/ldQGQa3KgzMk01n2xygJVuXA9?=
 =?iso-8859-1?Q?2UYydmDnRV8EavqAUihkGiMcpmOa0E3v1YmaXvOa6cy1gBIPKW6iImwpCT?=
 =?iso-8859-1?Q?ziOFkqdYE32pVg/Na/Y5MJgmmp9iaPR1m+r1/L0jzB3FGuXnGnM8/8FeUC?=
 =?iso-8859-1?Q?EuRcTaSyte4UF4kT6akrhmA3hSS4VqIG2/si1Qr5OPAyz35qYCCRstM4mB?=
 =?iso-8859-1?Q?CZrHks+JvjbHQA/mknfhc6TFG0UmhQCa8btPZ39ZxKNVDrGEKEjTEKVUVZ?=
 =?iso-8859-1?Q?r3mc5K1YVWqlzP1B2ZTlZSX9iyEh+pHZkfmqDMUNYP11jdknXzWr6ZLjpe?=
 =?iso-8859-1?Q?iCNw0G+3u2UrYoIqY2ie3ZjeBkoq6qySnswwOHlLfCBXYh3FIHIGs5jiLf?=
 =?iso-8859-1?Q?n+0vrZTXQ22sd0QcNcQQwaTv+8nsjYHMyxp6zz0dcX1BTkdW7phzFVkZ7m?=
 =?iso-8859-1?Q?TF0djTsCi0lkB9pTRMBRVYDx+o7VpqrVj59ePXeL7/h4ELoofrb+bxQwbl?=
 =?iso-8859-1?Q?raSwLPOXlBO4VZeCOPjaHCNHBfNMn9Nn7GNEhY9O0A1NPaAV7Qy7xO5x2f?=
 =?iso-8859-1?Q?9TLLA43tglFKX7Mb1Yr1sX3bncT8z0aUvAo07L9k5ewCoHyUfZyib7J9RZ?=
 =?iso-8859-1?Q?0uOI0JugRzjeuc7SUfNpWFS3e+5XyL2WZJcAAVmF9wVjhqKn3ysXVxwHtu?=
 =?iso-8859-1?Q?Sx+PsrXKWmr7Fmkjbfic4eIdtolEkOvr8+DieLdr9NMop3lF2y5vrsUeff?=
 =?iso-8859-1?Q?kyTkX3BYCx6t3Ef5m1cLxyCtyhUG+Cku0Ppj+05ya8X/CMGsJpkQunI5Ww?=
 =?iso-8859-1?Q?OKUSMycjiB3Si101EKIYwAGjguvtoZiUhx5hszNPFFUy0jTosJC+V0+8H3?=
 =?iso-8859-1?Q?dKLyiB27GZCMgZA3kAQLYMz1MYl9aq+dicMJyeCxw8430bVInKc10XgkrF?=
 =?iso-8859-1?Q?wcSGS5S6tlY7gsaBA2qc5v3TPriqOrSUsOglwTNsAJb7++jZ1dTKeAN5RH?=
 =?iso-8859-1?Q?3Ivdmv/kUdJ2C4ShFolihnupIJH0ic2XiBbsfrsNwzH5tLlCVCpOY6TLkD?=
 =?iso-8859-1?Q?hlJDuvR/A7XhQ5rM03dAeQGoEkdjCCUzjUeyiB3o8DdkkWyWHDhAQPqvkc?=
 =?iso-8859-1?Q?Xefh9ZNi6e5T4TMGp38zbNxeLat9HMw4+QVR4zvY30AsbG+VZhy+Rhmj5M?=
 =?iso-8859-1?Q?NpJSYV6/MOOPhBtn/G0N95pL0dYJ8a3iACcBIwx4XPLJhPT9O5jVaPm0wH?=
 =?iso-8859-1?Q?EU7E4NC72Jg9Vy37Xfd1PTdk0+wj7K8xUlZHueVKFuel5qfZLlVf3srRIx?=
 =?iso-8859-1?Q?Bj3VVkvU6IFU96QSf+AJpUWp3X8e?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZrxPmSTgDplXcNJyeNGN7zSU2DxBv7JT1/7jF8PQ8qy1YI2nQmWEd7mh/+?=
 =?iso-8859-1?Q?wX6UCynHLc9MSGRmJdupknPcdvcqRXQHBDuD3+5So7AWNE+Yp1nfH2/5B1?=
 =?iso-8859-1?Q?fOWlJ342OxPSw9WZ0MDSTjIz+6vrrd0ileMw1mBVE9XKrWffu0usZ8yVl6?=
 =?iso-8859-1?Q?4C4azfXeZVtUJIobPRKaCJU762FdzA0PlASFlFmYtTMkenioOKZ2Gy4Ssh?=
 =?iso-8859-1?Q?8h2uhZNbbxjzKo8Dr+IKvq2OtWRzFk9gZunFVWiEoUJwcmGl3THljiTcaQ?=
 =?iso-8859-1?Q?7Th/V5k+BRZmPFyZtoUM5nVIA0p5oG9rBYUl8A0WyNLbAG39h9HXJWiW5N?=
 =?iso-8859-1?Q?wEpj7jKPhjBKslIBLqLbDxInzguWBCCftoXMYOl1WQJmxvqzhs8T8SJwbY?=
 =?iso-8859-1?Q?z+ELsm7pDPArnpl5OEGDT+E6Ukk5j7LfiuowEXvp1n8e/6b5Mbipm62quV?=
 =?iso-8859-1?Q?xOXYV1WOurzvfbNlO3q3qKxPNHgxgADd39tJphSstBMHQ0uiWQXy4HwUSi?=
 =?iso-8859-1?Q?Y3x10pdwYm+YzJN2BNUof0KR8JRsf1z6jGonK8qrjrYGLIVX3GP6AhT+uV?=
 =?iso-8859-1?Q?qKEj/9KCdONg6vi52kOJy1NyZ4E0kZu0K+OS7g22vQsz3SqgK2oJNZ7Jx2?=
 =?iso-8859-1?Q?foQHHFesVBp04GoXbta4EBwF53XUnQs4ICDGh38eV5MJMfJ1QdMYA2pO90?=
 =?iso-8859-1?Q?ul308UGbSlWynIeCFQxC7opRhPGEPVLZ7SmsFMwu+yHpOmFqkfNwc8TT+6?=
 =?iso-8859-1?Q?PQXI/3uvNwdOcFoOus9cX3q3c4RE2Z7KouPBA3a1oMFCKUjsxnnokTMOOG?=
 =?iso-8859-1?Q?zs2sloy8EwtJDM/l455dTkbmgsXnownE7s7cT6TGH/uLTqtJWwcjr01yPl?=
 =?iso-8859-1?Q?RMz09JKmaD8Jw5uV+nDBpec8SLXVR8EUNbSQ9U2HNPE0yUMfzvz8j0dXNJ?=
 =?iso-8859-1?Q?/300ApuWC4R0/63VPopeeqSnB+s+q/muTiuvcj0uYe6aHFWWfcxDoQ6yV+?=
 =?iso-8859-1?Q?OEjTX6h3lExMcqFSKYU8Ug0ubF3t4RiekahS6ub6Z/UiNzkmkQ4E5VQ0ON?=
 =?iso-8859-1?Q?oAJyipuZAOVBT0YmngBi0kFu+mdBSVHKUtx9wu2wG1BbRfCZt8UEruZBJC?=
 =?iso-8859-1?Q?Y+MeY3Yz0xcsX9F7GY8PoEakzL4d322VPJiGWp/Ntd80Q/qRMwJ7PbpSO/?=
 =?iso-8859-1?Q?K8cCVTqVlgo8r9re/lA5Q4JGSNG7NW0A1F7gckek3A5nyvn8BJCWBwuR+H?=
 =?iso-8859-1?Q?COEH2mvUhVGYhEPubJ9t0SW7qmYItyO5Bwm30PYvy0KjXrb+47QUe7sN70?=
 =?iso-8859-1?Q?6nSOjJq3E3B6AL1zSYWWdmVBOIjCfJgMcynAsWAFv1GfkN9erIKUyjwiOi?=
 =?iso-8859-1?Q?vWDgXA14A6BgRaHI/QY8L/EaZQbXpMQeriUxYF6S8mzvToCaYYTz2q3aOb?=
 =?iso-8859-1?Q?7m5pPSf8tteRZihTX1UQc5Hxeh56exUYCLS2+KPNHHGkFFUaoLo1TrW0tz?=
 =?iso-8859-1?Q?DN4K2/esBqNdkGa33/7Rd3mGt+jAUwx/HewtsFJNFYJAg6CAENINbzglgN?=
 =?iso-8859-1?Q?XcEcP8auH4SPnXk5M1ecSv8q8lFKDoYdWQ29JlFQIfqb0v2wEAXoAJMiuR?=
 =?iso-8859-1?Q?cq53uogNxCV+v7wcxiD8YissHq8PAjlOCjBUhnRJefD5EScQsDc7q9hRdg?=
 =?iso-8859-1?Q?000BFlgXV4hPYWtmTUA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e119ca6e-ef76-49c4-8731-08de2680988d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:08.9943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOJC01dUwmz+RICNkXUtJRCroUPfuH19RwB357gQhbbA2CykZY3/tUTx+9AbwY/Z+8JijTwFPHh7VEp8cI31/rhdiChaAmrg52ucOxx8QJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
index 222efb12fb..2b308ec9b0 100644
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

