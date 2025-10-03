Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85046CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJZ-0003oY-IK; Fri, 03 Oct 2025 06:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJV-0003o7-VS; Fri, 03 Oct 2025 06:47:02 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dJL-0007NV-9X; Fri, 03 Oct 2025 06:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmnbQ0nXn8qHPUyKnR7UpGBrU1V+EJ33n0VTpp2yIoVjl6RNxQHCNlJs+8dEa0MFgTlWGwwWdfnbNeeqNZ9tjOhOUNGG6GjyNhoQtWCyjv7up5LHqUGzcjoCvuqTFNOe8rmh/M0Ttl8qnhMPzpHtowKspCtc6lMIbZKFOswxYE9JkbMFGh5tkFOWBK0sgd1+tyDrXbgVcewfhx2k05sTZaF15D7yXKTeoVsx8LUAwdFfadiuucBY7u4U2mtm0t4W71ACTzhi35+/aMGL8lsyq92Buwk6aszamC0R3eSpRJvK/AZcqSDDsJeOP1AKeDJoz3t2GtKsFFZW1ZSD5NFt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=FmAmMwghlN+kIvb9A+4+Oep7zPuPXWzAEUJG3puk+ZgEpuCYkaIn2NPpuoRhpeQy6az8VxtHeAO7ubUUKK18bKRIoF9ZBrwmRZTFyVqBdpyknK50hk5k++Y4c+wyLC/6V4UG2w47NO2un/sddm+WQb5/HQXhS+wLNp1skWDj9niwOieKW5Xl7BMlkhjP4lUHwq/gASsEQfraAdqNAaGB3TwbBsY+xdUkOcCwR08BM75keBfgKAZXqsdKWlg5RqA3D83QDuJTf6YbpHmeykKYfr9ZkXbxnqz5U4O1IPiBX2j8NbPnqzZkxYJFizSHZtCoc+ndiD2AsAP6leOJGoHdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=SycKwgCqH82XI4nudqS6vLwMdOVA+ubSY3lSciS2QJaWwhn/fv4UEc4MuOa+ZoEqYARyVYDXO8TQ+XUO6qrgt6zHhZXR4FV+Ky+Pi2j6kEhOzQ6BP1Jkl+JJwq6t9/jX1ClalAFpxD7DjLVFIN82hECjbB5nQ5cN3ttRsWmxUKOoEfLtJ2RFBb00z4X5rXJGvJCStqJTanxHveEvOFRIgcwXNdPKrEMHlUf1W28RSZNLEA6kEC9bjY4GZOzxzDIKNXlmuzCbK30Yy1mRySVf5wnnyyUmYiwFhdoBD8mJ+wAjCezhAx9MpqpOQsWaeCU53kTJOXFX123PlA5jZ9vrYA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v10 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcNFLRuTadANf8akmIBURPJ5rshw==
Date: Fri, 3 Oct 2025 10:45:22 +0000
Message-ID: <20251003104443.51501-9-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 79dca689-f93f-4f15-060b-08de0269f431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jbEvZ8PU3lvEB3DvthWxYQPUzCaHUB1r/PgNF2ShyWqAr3gUeEe81U124d?=
 =?iso-8859-1?Q?xi+kRrtlV/KbYqz6iCo2b/fVqPYQKEO3hnm+HvXm1MieS+I0UfanZ4pza7?=
 =?iso-8859-1?Q?K0IAoNWbsYhAj0W3CGtqt4V93mYuMwWYUXaMEa0ev8Olm3MAHObz2DsUUy?=
 =?iso-8859-1?Q?kfaDW2qIQegf7ZAZsB9bECbCKutsQrPCaJmxzq/WrY/tamQKjtQEwnnefD?=
 =?iso-8859-1?Q?nCRE0Gtgpb9Py4rahQTTJsYzdoTiybZ1c3GiMxYbghuTC6FM8i/Evj2UB5?=
 =?iso-8859-1?Q?5Lo3Qj+aiar5gUgDIsmcvQrVYI72QY1H0ZMxudC8KY9ZR1NdHUNXp/Bth2?=
 =?iso-8859-1?Q?Bwy2WR5yUjybRTW8/I46OS3AxkZSyCaYZLS309yCoaWBwsBdnHva1uzQzj?=
 =?iso-8859-1?Q?Hamq+bqRXlffyRy+NRMmvcy3xEwCEno2KJVFE2HwQbBiVg/UUvC1WtnZHv?=
 =?iso-8859-1?Q?at2HSu21JApHlaWmAsBWJl4GOLhCfsifo74MzhtUjCTBCGJt6IQyajUcMP?=
 =?iso-8859-1?Q?3uQDSFXzp7uiwTOqb7mvxDZbGjn3978jkKOzKK9g0BLjOC/6NFfPJGrxqP?=
 =?iso-8859-1?Q?GZDkkL8ZfgDVrRwebQoka9W5kXoAvCPP0CdteIJRuPoUCxP7exmGPA+DKL?=
 =?iso-8859-1?Q?GD0W+CdhCpwIf/GKqtlQ2fmdn4aNQuY880/27iUlHfX9njjCYFdiuFaMTp?=
 =?iso-8859-1?Q?aM+k4W5PunVeJsgUGRsA1fgGXQj4TlMMjlGSJgSO725LpBvzuElOkcF5ut?=
 =?iso-8859-1?Q?qN9Fz5QDUohXzMsD8kJTfXma0zf4mRR/8CmqDDDnFBhfL2zqPF7rK/M8kT?=
 =?iso-8859-1?Q?JkW5Kisb1GlOL0S6XfgjiQa4U6Qfx3+WdqeWQQCdn77wKq5hF9EH05Autb?=
 =?iso-8859-1?Q?UiEbZ91ADFOoxbZH4jbmnIy+KfIMM/9VG1pTngz/3ORA3IRIrWsb2zN9Nr?=
 =?iso-8859-1?Q?Vh/Hb3WavnY3CgTMy/tfGs6+ju2Bp75W15kxb6gwiOP1OboVBcyiLo009p?=
 =?iso-8859-1?Q?tpH+LP8jYUCt5SX4yuiHdKdwRA9GE6S/rCpl9ArhxtNE8ExTpckgUjzJ+z?=
 =?iso-8859-1?Q?ESFkYpHvfGWCfhJ5mF9ce/wRO8qn0gqZddZjwlw24ta9qThzwHUVBMMxLg?=
 =?iso-8859-1?Q?SgMytUDLSzjve6UK4cf+Efwe5+GZ+39rawNBPgE76z733XFyOx0saxvS23?=
 =?iso-8859-1?Q?wHct8QT2GzT9DdeiIS0Gala5yd3jHWzQcJY23Z90hJXIdu/4X7QRJftlFY?=
 =?iso-8859-1?Q?j7rKoRt2v02kRlb5i6j5z6tyDdvl1kPkRcGMkJIML7oUKvVLwXlQetuEtE?=
 =?iso-8859-1?Q?l27Eynw7qh0wQrVi91MTa8tjnWkfEYcqkrAtAoPwbIlN3loNhoZDXVMgd+?=
 =?iso-8859-1?Q?YBRnzgx1ObC/N3PQugpVTtKfVFcS+eDgx98lTVbjuNyjJo6q5S2afwUtRE?=
 =?iso-8859-1?Q?44xgACYaz0cfr4KSguV7oxq+mikzjhhrjg/nMPTJ/z5e1Cy13fNnToqa2T?=
 =?iso-8859-1?Q?Z/e3gUwsoCgQ3WM5EGt2ZUEeX+3CVcrrWMmjTvY+paqA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mq70YHojx0z88Eg9LCaTWoF2Hw2d5bGoywiykxpaDGquDzlNIxeky2KiN6?=
 =?iso-8859-1?Q?rPnCY2S7AYBnewOLYcOWIXH+iKF0A8rIgDr/CxAPQvHhM6kecY9rJ3s1VZ?=
 =?iso-8859-1?Q?ump/59GbyLKZ3guRLS/1BfPIsG+anStcPa20FlcBu+lyfTyYvI0g7Yxkcl?=
 =?iso-8859-1?Q?Qz7tN8NhCANofvthQfHdSaRFalCTeIM1mVK/25az7EPrxjLOhCCPnmWJh7?=
 =?iso-8859-1?Q?mljPX8tAesn8APdLyLYVnCLKj7fl+p1intHzvVevJa2vqPQsgSYT2AwXfC?=
 =?iso-8859-1?Q?LYSoQEKQYIPs2xI7aqBxwcoIXKSV0LUm3BI6cryx/IahWbcZZLn88dnVn/?=
 =?iso-8859-1?Q?ibMUpX0y3mSNyPCYRTCCDMea23tvbVxUfFWCJ700m7kPLHlPQ6IBhYg3kw?=
 =?iso-8859-1?Q?ZJP9AmLT8TWh9/j7zUU64TcxnoY8roHMFOEc6oNzv4syuraxvkeGKBgSFI?=
 =?iso-8859-1?Q?slSziv/cNfhFoQD+7Tfx/1jnazNY2oumiKz1EN/2Gn3rrNAQ4mCfqEHirp?=
 =?iso-8859-1?Q?dJFcALObo/47K8qOA+d04CnzyZKvKgGGwPhzF7CeDJmq2BsQGzu5qJvIHd?=
 =?iso-8859-1?Q?mynjNTJ7ZLVNmE6KcCHg1iW7WHsLssB29u/oZxkn4tIEtiauwCXCtbMQiV?=
 =?iso-8859-1?Q?Tt+KwUHaC8DwaHgyVWVjUQoQwdQCIB4vkTEW7vspPaoIFsqfGZajD3M61w?=
 =?iso-8859-1?Q?+rdbn2q60FG9/gKYCA60ISu6src7C8MXt3Eg4IiXn412xL9lsFgz5ipcbO?=
 =?iso-8859-1?Q?eoC9/q9Ifj+XVvaRU7v+EIJu3OsOkbOvYxNPrVWUVu9IYELfZxCLxxvaaM?=
 =?iso-8859-1?Q?dmlmf9tbG9prTmwvXyIvNM5e1vq0Y6KJbSWy8fZcQMpXfPnMNJAgFJYzYI?=
 =?iso-8859-1?Q?q5qN1GK5hOAgtx44ZJoE8mxZtRkjmmgyS1oimq96WBcsqTL1X966trFU2H?=
 =?iso-8859-1?Q?NdTjO7+ktTiIUX+aRabiKUqPjhyTmu4GGoy8Hil0JqB0IDd3PndQO260rv?=
 =?iso-8859-1?Q?ZEkRuThMimU7S3Lf9+/MtgByZ6UZAE1wcI3ruNjz91SAFGi/K2gfgU/MRC?=
 =?iso-8859-1?Q?qb09q8EiI+BbOl/0QQUayG6k5iMquloAb7lHUUmAZ5y8bO3eWRAqaREe4S?=
 =?iso-8859-1?Q?kIic3Rp3b6/1pRxRSi5vqLtw99dijJRHQSwecqMUJqU43+8gn5NDl+CK6R?=
 =?iso-8859-1?Q?I2vxbDGHUGUP0avIOaLA/pHTuJbPmmLtJFNPy9mPfSrEe/ykdLRy98AXpR?=
 =?iso-8859-1?Q?4JLzmDQxz/IhT/cMH2PzvpSjodx2hyzEntLPssqst9R3afPNkj4R1KeNCj?=
 =?iso-8859-1?Q?ZcoxwQVehuMuHawKUf44/6F7pcMsrtvsqGI4B1wE5jTZNjLMGnlt3YIDT2?=
 =?iso-8859-1?Q?9dS326lsbzL4vCINgZ7PpOiPgbpJBjhQzIFSYqFwqe8n8XQlkC4JVFm2SZ?=
 =?iso-8859-1?Q?9VRkpxJsRvgyIBsT5LsRu009n6rfYahk0jOBW88fGipsPMlB8lKNPUDhW+?=
 =?iso-8859-1?Q?ysjlqnf8sZp+n+fLX2oTqouasyrvQaMzQWAocLrj4mWnVNM3NiGZ+iAQFz?=
 =?iso-8859-1?Q?cZqdPWnXXMDWjmh4SVxGC/ZRhkDFV6pQ85JQdbwIzOeSJylJGV1Aa6ec5R?=
 =?iso-8859-1?Q?NHJ7hD27kenaDebNeCk48z76ili0vggV3TLhbvQJhAFKQV+KNKa2f9rn1Z?=
 =?iso-8859-1?Q?J5BFfuLpj6ozIS44wf8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dca689-f93f-4f15-060b-08de0269f431
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:22.4420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A0Ruzfoos+oAaySXl9+slOgcR+Ebt8lVN8de1f/ZIxguMVz594h+8SUwfXScHmRpNRt9OKkDqFY7rqVuZ8iZzNfYF9eTF6ONCUlDaQXn54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
--=20
2.34.1

