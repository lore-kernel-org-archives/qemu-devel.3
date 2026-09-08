Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F08C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tID-0000Jl-3J; Tue, 08 Sep 2026 06:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIB-0000ED-Eq; Tue, 08 Sep 2026 06:43:07 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI9-0006bO-3E; Tue, 08 Sep 2026 06:43:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfWMfhGQQyW3HGYM03GSX8eWc3RRXc27ryyyX2//P3R7qvOXLbMm5zZBqzyTza1+7JGsoPq+t3Ea7PpAw2s64N9qobTpVRs1mzK7XY0r3tX5/ABQZ1BwysfQCMdNVZ1k/3Xmay3RY8zxYRh8Z2RynTmqXiEQktdGTgYdW5sJf0hJqhzwvaoMQlbJ1YYmKw5I3f/HZbkOTFZKbQ05bP3G7rdfZhfp3xTFmXXxx/uXeabAf/4Kly74Q7aSWqL9aRK1q0o9ogsOeXHZA8bUo/ksYjfux692yG/mXIKHUf1dC2yGKalzfx+ZHW9oBLWDduoKMgwFVsJ09y/+0DkoAQl+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjGoCma/9MC7D9iMaG42uXF+m7bDu5Dmk8Amcu2UWvE=;
 b=tgx3hHB8i/qzBgUV0f9KSm+gItlNelnK0ybfskNIZ5jduWIe1TQcXDDP7l/PEbS1BGAemVcXW9jOYM82OfrnYtP6ry47mi/nIDeFQaVOaulf99lsMo6+Mwxlz92nDY4Y8hTi7uNjue4Ol9q5AHXwpUDasOlMpJMXrhRlwqTpYxCFBx/2gwoksyP6J5ewMKv0ETIis7eYYhDBs+JbGzHRwWCWjbqP4Bvw8Pu8TwGbFNzJNMPAOWZpSP+wASuu6GVwub6AH2VDc+Sxd9JCJrHjU1CID6y63YQekFRf7Me3h7cO/pUyQkzCCPqNy63OQTHLCt3ptKtKNjzOMJ2OVqdzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjGoCma/9MC7D9iMaG42uXF+m7bDu5Dmk8Amcu2UWvE=;
 b=jLSRX859ARyiJaHSs4GhUFAKxW8fDERewTDfKvtyQCVYuzVU8OuZrROarwxp+CSJzc3Hg5RTUL0M10rhiLVPMXu9X14y83CQqubWxns3b9fszEGlfHGBuNQcaW9pxJ/XXkeRCF1OInqgAvydaKCPk8qFw5dhTyxksdHqvIeucSavYcd1M5l9eyyxDMHb/yPT3w0+5mKCWv1Whp3HoHW/jyO7UaqDgjyruBjiNJV3a6vTFFfJgaBSFc/7qK27X3sw3MsY2hiTnotGfXQ1Xc1j67BH7BLx3pPYhD4z0FXU6u8DrEcSnYGTPpkm7aqAfmy+qVyU678U+T/pQSeQ9uwVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:56 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 25/32] hw/block: m25p80: Add GigaDevice GD25Q128 flash
Date: Tue,  8 Sep 2026 18:41:34 +0800
Message-ID: <20260908104159.1621764-26-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4a1893-1e8d-4585-1dad-08df0d95f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rXWRAKqet/7p2yZ55nl/sRgVji6i9e2+SymSTdqfXmc9V9yBbzyRefskKbH3QoTp+YWLaVBuhPyWmrFZttIWP9CVFKCRCnU9MSV8Iqg1jIMx5oa6XlaiNH0xFVRpmHX2fWhvKG/I6tZtwqKcBpfI8Nko8l9PyCdlvnUd8Qr3/bmSoItSmrkcr7mOob2+TYhEfhKGaREqi0xudXt5yhwO1gcEdO75nazFSyrkdQaJ9Tsqx1nnSAIW3Kutu1WbPsyrOaX7zl9cwyGjOT+WZaYv9LsvQ6AWri41Kl8tOd6gSqP/b+btnZJQbKSG4tjNo+zL+YvzAx1OAAIub+kIlcmalAiqXEIMkGMXygtDfFZYVNeXQ8w1HKTgRM/dED+01Foh2rMPPkpO1IULEU97ZiDtfmojzQNR/+LkxwmVUdw5+0NGwdomVt8bsMtfW9Igh6P+iZIxGx8m7ngXQr1M0H2ePnaK7K5QZaWIfLuofoy2PlJ8LHobq7voyGsO9TacFLAKq0nXQDTjQfyn2c8Xmld6W2OIQNIhzZjGWNkBOUbFe/Kv8E8M08T3Pi2RfTevkOJCa85szKKkg67JsTM3xrD+mXuM/4/0CC0Hlsn5itWGbm4MqUq8D/GY7cQwFuZmpQCD5HERdWpJGKBF/uchcQi/wzSJNWjLxdkEY/i7lw3UCRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGXRNSK1EHiKxQXH7TJ4Ja8Cal76fRed1evq7tHhxaZ37/Dy8b5uBJnm0w+0?=
 =?us-ascii?Q?5v36t7kA6zYgeFTs8DGkJDdsgMcO9t0nfwTHdQXfRxdyzPhAEgMB9iGNGeRx?=
 =?us-ascii?Q?ORPjxsHsiAB5+EzCuqLjLhttTsLMz3jbo1HJKyvOFNwogbJfR1CrnafkBV3K?=
 =?us-ascii?Q?Lc69uN7lAxMezXxWxmZDe1/AgfJGWNYXHhHshL6/xmb0INX7/d3mOUMVZeVl?=
 =?us-ascii?Q?9Pq+7uyqjAQrnsmXrBKnyvTQZIxSZjBaowQw1iek1LfoJkv7sjulie+zbX8O?=
 =?us-ascii?Q?T/mAx1KH3ttg6+juo6lAFZ2FnD1LT4VUwhCqbIy0Rz8pujSnMRl96obsUPfJ?=
 =?us-ascii?Q?oD4atyg9dH+gGp/+P/p6yNx4v19CHihIGr2yECLPtx2wuVkVDdAdb0As0dno?=
 =?us-ascii?Q?ysXjJf4oS0R3eVnB7LOuvDZiBumiRiGlnTcyRk9C7AjPMAN6D59WyS2ZTaZA?=
 =?us-ascii?Q?N4gd41ehy3rPI0AcCQv0xfBcCPKS0hy/XGvmNj060A1+6RPZr+fgoNL6nCi0?=
 =?us-ascii?Q?yOWyZYtMrjVFzUNr05msybta4kolNVPgN2rKAVpmP0iuNuNWQWK18BlQnWTl?=
 =?us-ascii?Q?i6c590dE+gmhL+/XmCAsyaOhPiQyHCdlXGAxgVsUpf3O1aD+mO/4Tmu8qoOe?=
 =?us-ascii?Q?7tKlr1amnXyUI3tUwgTndCGZENpzgpbVWsa+8fFgVk9BzIk29K8MN/PkfyZc?=
 =?us-ascii?Q?dvJbZKpRMgM5x1t7WZwD8b+N6yafLCPOYUq2heZ8+SQVs1sIfhLWfFgCfhAi?=
 =?us-ascii?Q?DAHbtKAiuvSYTUbQ7HZJgV1hkUSlKWC+VhLqcXuzhCy4BfHy5TbUxFbrBcf3?=
 =?us-ascii?Q?LBu8m/aO9QYWJTgkD+hmZq1lNb0lSIZ0kbSYWHKv9jtlRvMcFfb2XXsNzQsf?=
 =?us-ascii?Q?qDyk2XxW0/qVczcZr2YXgs6fQWo0+9SZZQrWuX8XE82mqpxtjFwzRWrusnrj?=
 =?us-ascii?Q?ukpfkaeY4Acj2UOH4cX28v+HNzRbEufHb8CXcSUAJhkxj3QqECkC4kbkCOzW?=
 =?us-ascii?Q?SV4EaNzKqWUb2pNTzLAjZYqOyR2sSaeuyFQ2/BHJoXEou6oud+DHQ3L7+Yl7?=
 =?us-ascii?Q?CsNijbliaXh/t+ePNkNHZgcT4kRzktIP4A7QJwHGR4yLPncKrhKLzu5zYe4c?=
 =?us-ascii?Q?XQFH4PHJzTZ49vXgwOwRIUlOUrpjt21PVJffLV1codnZvQxcfW8hc4rkAIG5?=
 =?us-ascii?Q?6l0KQKBZArokjNLhN9KH8tJNU5dEFN9yKaI8GG0gD8DPgO7GCCPxGiEYmuyH?=
 =?us-ascii?Q?pHxMtZerpxALZGRT/Owdmd8OkntS7qeuLK6pfdq9NuUEOyDdO4W3V6KZ8SS6?=
 =?us-ascii?Q?/L9cto+HccoZTnXAfRwQw8u/SEQnPfC0DQO5BIY/7gCnz4RHyc8H7YrYvgDL?=
 =?us-ascii?Q?Vdmh+I08FyzoR3hqBq55gSyL6SyjKr0mZFLXIP3volk9AUKQL0PoL+GvR1v2?=
 =?us-ascii?Q?HJShx+8F5vo986hZ0DWAZwJ/x60d+4iX3FhoSOHyNzHy+aVksccFiRsDVwWv?=
 =?us-ascii?Q?5tAeXWQ6oHtVJtHoQMqCFUc5IJPqZIVVdTvjvf+NUa+AUV3JSBZCi03pJPOA?=
 =?us-ascii?Q?FkK1mIzLBxvVtUfVe52xUT7vN0gXT/JnCVrfXg5EAy8bMxLZO7rVh2DDjgdv?=
 =?us-ascii?Q?hB106JHqjc/H3oJdj0i7j07bUYpdjXKNnGYSK9GnYygjX/ZodW9lxUYGxMQM?=
 =?us-ascii?Q?DVz9g29pfoEhB9vnN/YJomFhx576n4Sbepps3nGPdvzIAC/KoEEhog/rf3EY?=
 =?us-ascii?Q?KB2sV3B7urKOspG+gKrTrXsnJjAuvjE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4a1893-1e8d-4585-1dad-08df0d95f176
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:56.3488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wywuyjvc+o82eYWzBzxf4i8UpeWxnWXzzQbMMXFtC14Ti/B3eJiWXkRHqEQi1CSReMEsVF2jIzfKogV47buFqkmABEJnoE6rI61+R4RzgJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Add the 128-Mbit GigaDevice GD25Q128 SPI NOR flash with JEDEC ID
0xc84018, 64 KiB sectors, and 4 KiB erase support.

The Phytium E2000Q COMe board uses this device for its QSPI boot flash.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/block/m25p80.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 545e0b5728..60a9b1f8d5 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -207,6 +207,7 @@ static const FlashPartInfo known_devices[] = {
     /* GigaDevice */
     { INFO("gd25q32",     0xc84016,      0,  64 << 10,  64, ER_4K) },
     { INFO("gd25q64",     0xc84017,      0,  64 << 10, 128, ER_4K) },
+    { INFO("gd25q128",    0xc84018,      0,  64 << 10, 256, ER_4K) },
 
     /* Intel/Numonyx -- xxxs33b */
     { INFO("160s33b",     0x898911,      0,  64 << 10,  32, 0) },
-- 
2.53.0


