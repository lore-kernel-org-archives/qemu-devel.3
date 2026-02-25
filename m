Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25310F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0k-000458-LI; Wed, 25 Feb 2026 05:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0e-000423-A9; Wed, 25 Feb 2026 05:20:48 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0c-0002uZ-Ke; Wed, 25 Feb 2026 05:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiMtX3uzVS6kewXrjwdQb8LOjg7CWvG9IVnFf8BGuJnnEz3hdySG1fL+8o3ZoQMP3+LlTlb+j4f5I3eysajXVMh1XiJHe5fgrrOiyzalXT96jqs6LbemBB7ekLzcbbBi5cc/zKrfzfsiw+EKy9iitDSjoOvZMbGG+2ZcyMwGwZGYeA2XZz8C96dL72YNzJvRjSbVGX5BDI/E3Mq9KcETSaWkLKxw2S+1yt7OGZzFTAVkWilPHtaaaRWXjQQifeQ57B2SMt1fohDiYnk7OxXjf0Vk+pdDU/Hf5HrPYv//odD2KAaL+nxtI07Kj80AbkhQ0yB9YgrgQO3PT5/354CIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QxRGgrj/2fl/coYz+aDvabD+4l8051WyMChjwe6yds=;
 b=jTG313bKGPOrX8SKDMeySbrscRp7EttQect/6WZ9itzl4DTGN3J2FWBbzSnODsRo3qkihdTqhdoyDWESqYQ7RogLMLkY1SP6qE8Qt95eGeN6WMy1ZgPIJwO+NgnlgeCcWhHNNrypzMGG9Syio/Fn3FEm42wvMJ0wcmMcxxqSKO1he/w+m9JC5S4PQr+qtLClYIsm2R+Q1mddT16hJ0P9KzEWQ05jnyuT10jhRUaYjQ5wZpPfmBzoDin3v+lrsU9wbzI+R4aQkOy68dNevBaH7SQF6Nz4wYkrgl+XytZbz+semkLFDOz139iqa6XbAOMvb/Ze48N0nbqdYPKCIxKdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QxRGgrj/2fl/coYz+aDvabD+4l8051WyMChjwe6yds=;
 b=KLU09Cj4B+jP0OF/M6674WuA/jHVu+3Knb9clQfcdd8wexxwqWagcCX6LYLaPe/6dy2zTyrVziMkK2OEDAeRd/7MuePd/fnRcw6Iwwk/Lu5JVlh5KLcJ6MFn4GETwOpb+HSOmzRwLaQ/2YcRXUWPtt81niAQh4U0u/i2duG9tYXyR8iXjo6qJ25juvKL7lLj6ccF57rmLm/zGsu4QcPDbi4zndQK8pkLwhi2RQuRcFSDh5qBFn9RPYYJjjxMeVMSYJHHxLLMH3W/ICxhl//95OsCF/DjLKnr0iALiSqjCoWtpX2ssvIXWI7KSVnrjzKriNMPU0fKLhSpAM/y9I4WBg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:29 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:29 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 06/16] hw/riscv: Ensure proper ELF endian expectation
Thread-Topic: [PATCH v2 06/16] hw/riscv: Ensure proper ELF endian expectation
Thread-Index: AQHcpkBcn2mXOkHEMEub9epk8FLfOg==
Date: Wed, 25 Feb 2026 10:20:26 +0000
Message-ID: <20260225102016.200654-7-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: 3abbe95b-73a5-4229-3a38-08de74578032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: mpb3ozlUsF3Cyi3UAvEFoSkuTpK8DSNQqAcoRcaesltzIHLwcZhpozxB0FrEhzme2s4i32a0r5giXXGl5rasj44Wba1K6Fk6FmiOjEev+HdRHQYvfE/CXeR0aeRTE73PHSOFyqJBlLdkbxqoennjhPcxuMTeLkyYOfyS1JVjNzLUAVxEjVi+r4DUS1919RoFwzw9bZ00+fMVlIPzjBUmSaSIVra6sf+2ktZ3vI7wM+zmdpcXBzM8uciX6Y9kai3u2mC1gKEdEXwgGf7lKLGv7wQFm1PdXLzdBmfiREebIntGvu4vYhcaD4rgYEYEv72wnAAhyApqKNK/BBxIkr+2XBNNCwpGFMxMsu8SoZIMMgJhz4l5abB+mZF/+Bhww8n79gvDDMFERte7IzfCqiimY7hPO2yLP4r2NKXuz1xgPPwA1lR+1O+NDtp0pitRpf74j9T/JHb9HpzxBWfg3DL9C9u/QJhzaRVrZiwqenLyv4bFTmaEqYtN9CrQE6modMQYgaOilPLJF3tVYAivXfZVwS4pks8XkD9O8qGsyOn0c9oSFsSC1F4tqwhVo1aqd+EoTTqNy8WkfbSXSXy9cISY5aVyEo01866+Lm3dorkSwxjF+KFsf+a0CLiJLN//it/iF8sOJfY33XHqrdpELQNmQ6BToo71P8630rOByfFaRCOpJKV+nKlpxeBeSH68BnKskNpOG4dD+oTX60e/vqEHd24vCS/dVtfF+lHHbCGzJBTkffPBfola41qVQC3ZFZ2OOSlkTwHFZ0jCfVqVwR2wt+BE8a/c83pxwKifg49YsR0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XHm0ZKfQexUj++DtFEf2zrtLT4xj6mC7S63xRKO4sXZbcFAskiaWkKSkMc?=
 =?iso-8859-1?Q?Gd5u1BmikhLYCVWB9oxR5kMqNR1N+MPviK02I2B8qwj17KbWH3XUxtrN+2?=
 =?iso-8859-1?Q?9ur+4aWRfPAlkXssb8mybmlJvtHe7ITFNUjLnqq6doGrzv85BXDswJt9hd?=
 =?iso-8859-1?Q?eB8qx6pi5J7QNhxwjtQERvnb8OViNRcaRD46YA5AyVlEbzFPHOWeDmigDg?=
 =?iso-8859-1?Q?VgBNtZpVrK3Mg5Z+ZbQmlES0yHxUNfKNvNXcADrp14dHkOU3KvEcV0zc4j?=
 =?iso-8859-1?Q?2qjbfnDedOrbgwIH6ZNo2DESWO/QvBxVQqfhNxc1PU/eqb6ABitGnItr/b?=
 =?iso-8859-1?Q?c9cC8VKJpiJu9igl7kr8AjxghgXkiotlp/991zenelW+1n+I91i848wwgm?=
 =?iso-8859-1?Q?EPgNNgq585Al9/6gahlWQpYkmBILpeDcKW1WBlXeAtbPa+zRvp9omAS7J7?=
 =?iso-8859-1?Q?ZcP3kFIe42g6krZd/nZuaYZF6JJY1M/ebdrzIESSZbrPUcL/b79I6prfdI?=
 =?iso-8859-1?Q?rZxl2rpoaTYJ2LTPZbrRMIP2Y6+7yf3wUoQgo+Cz+C0bQeBFHtwXrDMEY3?=
 =?iso-8859-1?Q?/lhWM/XSGj/otQQXMWfr8x3DnCk28VkZo7ovhjViU8mLDy0Ah9/5MRR94x?=
 =?iso-8859-1?Q?/JCa4jxq7XnXFyD3ScHvTnR6XAxy2nb1F9/GZbjJPX/fdkuqEsjR4I4W7n?=
 =?iso-8859-1?Q?nA9cqZtYooWWZ5BJJeHlVzILlja0zQ+Lbo27Cf3+QFHuoKFK2/L5gYrjpa?=
 =?iso-8859-1?Q?e8I/6tCdQbWlGyQ8tmSG1hJq+6gVJYB8fJ9jTrQRDkNMe5weRHJl4D6DiZ?=
 =?iso-8859-1?Q?JodeDHFGEA80wzqjVR/vvMO+g3+LoozD5E3aUwsJCncX2VsU4/xaNiqEm7?=
 =?iso-8859-1?Q?oagnmbdsW5aVLQP73dCdOmR91ItIcU/2UAb0KOZlB1N3W1HJS0Ya2V1rMr?=
 =?iso-8859-1?Q?jY/T3R6wZd3ZrISmMtdyfJKKITuY5+USZ/KcjDrJT5DMYlPUTay9MsnkpJ?=
 =?iso-8859-1?Q?qmfei/ox6Jb+W3umBthnImHYcX0Gxvkw3CAXp/a3ULCU+dMp+nmByWKdVy?=
 =?iso-8859-1?Q?ZRZCWzUu/gMfr6+ZGwnO9CU9S2M5eOVIlrTv7a8pI8aJr2531nhfM84Ran?=
 =?iso-8859-1?Q?xl/nlNOR0A/DETLAlXPxGTHOtrto1NmnMrUz575y5NZgXkKQrwLyw6Aau/?=
 =?iso-8859-1?Q?nj7AOPtn5k8rc3bEAhAYg5j9NqgO7g2IoABD+XAtpWv0wOTH88Iytr3re7?=
 =?iso-8859-1?Q?C1EHJxUPbioj6dHVf6zXrZctTtnSDxQ7l48qiuMRXJqWvK8YUW7cZ8lM/8?=
 =?iso-8859-1?Q?xTnuEJhX/01MAXVAr7I/ixkkyYqJFlIJS7vvK46I/poYS0W1mk7ctOtnuz?=
 =?iso-8859-1?Q?aHVuKmw7+Xkxdv9S47pCHeqnir9hIXdjn+p9/7PkNTkjde2okf3qejHpie?=
 =?iso-8859-1?Q?mCYmZPADYMV5KC7R8eL7uFtwNHTCCfAOmLLkkGaYlSPe9//V7240CxPnJX?=
 =?iso-8859-1?Q?u8iJuUgcXFI/tJTlV72Zdv3rs+J9UCiQQF79TroiDC8MnXTOFW4nTW8XU2?=
 =?iso-8859-1?Q?9DFsjn9HW1wgmiRyz9M3y3wKMGHyLxoZJ+6tdl/PNT5oBO74JKVnrLCRrb?=
 =?iso-8859-1?Q?SodevGulLyH+euyBrvLUkGateV3i4sNHlHm7ZmoMIhshtiv4mJ0ShHHdAM?=
 =?iso-8859-1?Q?G6Cf/ChH3AXrSFPWFPZNUWh07ARUhAlpLZoW8sSz8GmsEhE6naEVp8u+J+?=
 =?iso-8859-1?Q?Igk0un2gw9LFCTjv1udNq5Aa4NpQbjE6+rhiKZ8zfBdE/24zcpk3bx2MN7?=
 =?iso-8859-1?Q?v3xVie3ejjyR2XxGHjhLxBmWwSANoLN7k8l/mdiQ34Lp4dXb8HQl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abbe95b-73a5-4229-3a38-08de74578032
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:26.9226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sZhZ8SWpDBIJ9yzBTqU4Y38wekqmPTGlsNhb39u8Jj6sl9DBz4J15ximraIkko61BASWBOwtnO/kp7B4enELING5prwN9A7iA9aUo8Axp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
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

load_elf_ram_sym has a `big_endian` paramater that notifies
it if the loaded elf file is expected to be LE or BE. This
paramater needs to be set based on target endianess to ensure
proper elf loading.
---
 hw/riscv/boot.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index dc9f8a7327..6dab521a6b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -166,7 +166,8 @@ hwaddr riscv_load_firmware(const char *firmware_filenam=
e,
=20
     if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
                          &firmware_entry, NULL, &firmware_end, NULL,
-                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
+                         TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         *firmware_load_addr =3D firmware_entry;
         return firmware_end;
     }
@@ -248,8 +249,9 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NU=
LL,
                                    &info->image_low_addr, &info->image_hig=
h_addr,
-                                   NULL, ELFDATA2LSB, EM_RISCV,
-                                   1, 0, NULL, true, sym_cb);
+                                   NULL,
+                                   TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDA=
TA2LSB,
+                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size =3D kernel_size;
         goto out;
--=20
2.34.1

