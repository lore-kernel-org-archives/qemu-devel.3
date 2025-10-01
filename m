Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FD9CCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTb-0004nn-VC; Wed, 01 Oct 2025 05:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTP-0004bs-CH; Wed, 01 Oct 2025 05:50:11 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTA-0004yS-AF; Wed, 01 Oct 2025 05:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha2uFK/zEPiUETPCVocQGNtfQEi1WdKq0jgTqABxv3S0wNrYMeWN9PGKSw0IjYpoNUSnji1Q+yn0x0Kd86zqclSWJqV+linCrAAQ10fWAJXCv0xyXY1PYRypdKWPkejBbPC4+iRrjxgOdTGYF7FIR5bOB2X/BVeuwsrzUlVQNVz4ItyIyoOicbXY0bYoUopXFwWdUloSD5Q+aJLHeFbUBDCBtAVsEDjYuH2EyyPWzyMMxRc1clo/+Y5Wd+9HrdcRG+cuoanWd1cfEbdL2+14h5rrnY4zH62MZmawtvFG8HrNGw/yPzv+9/v/uapQbfeNddQukSnyT44uU6gs0ANqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=vKw2CwEzx1a9QO2Bi9/h4bbvYrRUEKkHbhYxxvi0eWJWNS/AwukwiqNhoAU3JiWzD+60K2QwQlIPJdlNb1mxTy90sFFPdBfeUnsscQ4FYSzvZ7eyUSsL+LGNc3zJ8StldwpN1Tb/xnRwlHECVg1RKDjVTsTYHuejJtyXFf6is+WoB4G5ZWpHy9ZPGfBYoFRtyj0piY0esLSZcHcBvW6B5ty9SBC6yAcdasvmEFA1yUR+NHmmgJAHohJr20671r9iLe6UpUvrdAWEFmVtQmaj5sHYm/UhALFFf0gYJOjnMkfsFe1PPR2vD7I2shGGSLg3ffP4bPTQj8f6Mv/mU3Gz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnALfnlm/Vpkyi1mSgG82l415+049KVo4AON3Xp0OwA=;
 b=BtUAmJQhwBaf4zFVW9mDBeYWIHtSClxKsOvFtm250Y+aoNvBsUgZgCdqEo1ECuu4IP2c73G2ApVGFN6jiyM5J+swTY0TXvinCn9UoaBlplMKv0hSYYYosUVdb/RkW93aysulSoNOiFOCoeWH/bOSuXYoziW5x9/JO0RrULw7xD/+K9xCEtN8fyNyemGfctJk8EVRd7evgvnmK3kJqFZBk1ucZELsb61nlZMZhOP9oB+RYYc7XOByEkYLbK5bfXw6AV2WizKvdEjtiw/tMDl1tyVqoonvbQGY8Sze+0V8v+ebRfLa8W3Scel/T45/oPpkCtqvd7tvO+1f7rMpbjnQvQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:14 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v9 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcMril1dupJ+8t4Eiq/PRDEDQImw==
Date: Wed, 1 Oct 2025 09:49:13 +0000
Message-ID: <20251001094859.2030290-13-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 7a49f6da-73e6-454b-725c-08de00cfc7ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wVA+C62M8VQ082Q9aYSDAqgYrfOva2ko3s2MUaFGq1jlVqHehhdQh53uOm?=
 =?iso-8859-1?Q?XozouY/0tNlzX4q4quwMXj3hh7OW1/Jc50gxmUzrV00KwN8/mwVRPNWGhy?=
 =?iso-8859-1?Q?A1ZK6ckKt1uD3FYhX5LWhYKkdUrgJhtjDOfxynruL1ChJQR1IfTQCVNtiK?=
 =?iso-8859-1?Q?0oSyKY2Ogl36Wr3PfmnCZhJ4/98mNR1z3F2IODMOzRzLNRxtOwgqaLvw4z?=
 =?iso-8859-1?Q?hTXCQ1xuQVIf9HXfCoEX2n1RrBjwns3HO2cC0kgh7eECUEQkR+skTIXnlt?=
 =?iso-8859-1?Q?IM9bMm5oXprreqDw7eunJQK0Qm6xRPhihyHHBSHbyqmBsIdjHk9Zqp/i0M?=
 =?iso-8859-1?Q?BIXX18FDKsAdJRSWtMan942hQ7zdXcxVJSCzTiOBY+sllRnSuV2G8Rfj/y?=
 =?iso-8859-1?Q?ENmVQH5WimrDXEbCrLeLMdLgbc7d64nW3Zmo1+x795zggmauA+9xoAIUlG?=
 =?iso-8859-1?Q?W+pykMuuRmvvtIaaaBOVCC3O6eqyBgC6CtRZAv1TIsQ3LdsrDDkSrthuxc?=
 =?iso-8859-1?Q?NKmRf6mxah/9tgXyQQDyCsKRMW2NuzcKdBC/OxIjnDFuSJzrCtwWF+4C7O?=
 =?iso-8859-1?Q?4tagRe5Vbau8FN5pXncSJutkmt0ruK7V1xefNzFckeVeaJ4ApahygSPh70?=
 =?iso-8859-1?Q?Mxvk+7xF+6RjIEez8AvbZVhEjOWaRqdtEHdshckxUKd+hoIYBkXctJMcPD?=
 =?iso-8859-1?Q?Tby8BSZe/N5LdRkGwCalRvZoz9/5ucjlB7WljSPv6isR0bruXVlgZ9PawH?=
 =?iso-8859-1?Q?mFrmwPtGHVK7/0b/JuS8XURJjxnxyKgrV24VtEcF7R3eR2GUFtq4ghElGH?=
 =?iso-8859-1?Q?yxt0TXy99NniRMFdCxf2y/TeIHhchC6NhQXtlUl/cJRMZy6XtV1lkhnDY2?=
 =?iso-8859-1?Q?6b8G+mQdTrcuXs51Bvtm/bYAolzMPbzD3hkYn0JBTJB5MuSSfXQ4R2py/C?=
 =?iso-8859-1?Q?oADtm3Y+7zOd3cIARt5M5G4Q8rWnl9v6BDvjP28X83ykFaMpPaqEJorMLE?=
 =?iso-8859-1?Q?gcZUIj2qCWshKfc7GnmRlAGucdfRufe4Tpp6QrTflgxI1ZrjgfmjXfmqZq?=
 =?iso-8859-1?Q?Ik6NQhfyxNdeM9VcgHVjdEgOEXlSupOv83W6b0ysFnyxKZ4cPw/BfJc9EX?=
 =?iso-8859-1?Q?RPKsnxKyvVZztnHmg7ePZU3QvrNwmNFVrjrZQ9mvQBlRRCEs/Drx5Qm5SH?=
 =?iso-8859-1?Q?s2TSopStHmL93vlDPHVCaP+Bq9meWQupCeCynK51+g1yinIjQQwJ+Pr3J/?=
 =?iso-8859-1?Q?EQCp0wBqipK30nqgtmi0uUHh0SXeNk9FmQkIp4XOEl2DO5lk5zRzqLDTWT?=
 =?iso-8859-1?Q?wOlZJY9o+FDA9O3gb7yocM3rYRliizTTa3v9DRAvAYy5cGXzyrKW80WKew?=
 =?iso-8859-1?Q?zT45vi8Vyq07UcTRHWLhckqeoZ7ekJj1fN3DKc0zN9rVjOxn78GpDsDw0q?=
 =?iso-8859-1?Q?dBM8HysMK1WBgKd6JNxxixPeTPaWK2oU2gnSloEQ50r97k0pksDNTGcMAJ?=
 =?iso-8859-1?Q?bk6pxLgdSwxKLY4U9eNgqTWReiOhI8HbzwqgzP/jfvwN0RuNSYdPCPR0Tt?=
 =?iso-8859-1?Q?TQXAjoEYnMVs79a06Tdv+negHYfc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gex3GA83K5wmD6iFt9fTtlYjaSkCV1srbCDXUWmhNdgFxVCz+4hFTPOm+N?=
 =?iso-8859-1?Q?V7rIe7sKPEg3NmBkPiL3gLMpQY0JshrFCJ8OSh2ajlr7DEA4rLE0C+/Vpt?=
 =?iso-8859-1?Q?hDJ1TqER87NQU0YSw5/sz9VsVO0pipSZ/uHcj2hI/o5CFUKw1EPYZvsaR6?=
 =?iso-8859-1?Q?2v6iyE3CtxuxzCNW5nl05Ws85d6LsLeuRMO8nltxL4L1eRPZka9Hv1hRR5?=
 =?iso-8859-1?Q?Le+NbjnoqVVyIEIN0DJfEXxgJ5rfuBUWZxX4+EA7kw3MZikRtqMZ7Yqztp?=
 =?iso-8859-1?Q?zKyAxszH94bdfvRltlpqTXuT75TIR5r/twXSJ693ZxAQQSojyUnBu3/7ji?=
 =?iso-8859-1?Q?OTawcmrIhln3koXu/7DuOkjDC1wqeGTZKyPB+9uK/r8WUz2sh6Xc0G6CIw?=
 =?iso-8859-1?Q?fd6o7Kg/cGw9P24v5Z28CmVn4r2Zu14YkidaatEiodp73ifWT+0/TrsL8n?=
 =?iso-8859-1?Q?7YUGzNdHkI2+XgXqya+rglQBwaVVFUQEBWTSo1vc5A1kzLuxaQvSzDYCyv?=
 =?iso-8859-1?Q?mLClsCZ/5ON/INLxEw9WQfpdBjhNjgyIO3WGJGHr5E1aSzP7rOm75ESwzV?=
 =?iso-8859-1?Q?Q878pRClIU8qaMDEeXqWYc6J7lrP/35WKMlyegPH/w6H6bKXVvuFWKCLOO?=
 =?iso-8859-1?Q?9SfzsgWw0B/jVMVczy480QkIfExV6z2Av14ENbKX+WhOAXwOt0XVEtG1OP?=
 =?iso-8859-1?Q?NO/qCCCF6+2LArEMxHSya3KXp9/uB+i7LOeAFpGf/q2FNkOj/B5MS+/uBP?=
 =?iso-8859-1?Q?gvgbc0MsJtx8sjSuw3X7UKyMRLYK0qhzMyyoQxNSBel+GmVj1TyI2Zxunz?=
 =?iso-8859-1?Q?O7MbX3BCRoWaYqFoLnCSUykEVV53+6d+bswM5NL6G9uspuhmLrkJBebRBO?=
 =?iso-8859-1?Q?fxHmsB5IQckeQa9kbDhvmIY6Um77yuJmMXEgmYNwdRxkXIuYb6lb3EQczF?=
 =?iso-8859-1?Q?Yhudvrd8uX4mrI16iIYTHCgAFCgxKgMZfhLuEn/NeIMm/DUooZ7hXVMPFW?=
 =?iso-8859-1?Q?ucQvSpnw3R1pm+YcNlLRfvR4n8tva9gSQsqIluXVo8u3h3TnpT68KLkDEL?=
 =?iso-8859-1?Q?UqWn80juCt5U85y2bbT9MdalnD3XhT5NjPtJfhC/Q1JGs7KP1QgdebDPPA?=
 =?iso-8859-1?Q?6li28bL+RTG9CCVRrbBqVTd6jJuP6uHNk6D7+MZjIq/2y1bPwORNfOzPpa?=
 =?iso-8859-1?Q?c51n/ghn9lOMSpCnlla5wZSLP1BwsF0N5dYW3Q9mFKf5WOuu/DK57ZhhCN?=
 =?iso-8859-1?Q?LnkIE64Q6i/JHAt6CDN4MEKmZMqBoRz6rLMU+4miMuqEF6x/OPv+G/3YlJ?=
 =?iso-8859-1?Q?eYDoh6rYLCmqFzHCiXtwmBs0I8sbgc6ns9LswetpCYH2TITyx59MFTvQs/?=
 =?iso-8859-1?Q?ClwZ6ifsOA1K94WM0CaseqW5GRJ+VtQ63i60whBpmTSrQdPVRNaUqcoOVi?=
 =?iso-8859-1?Q?18P5aAnPrq+NjG/uOPX45JjZbZd2aDfARjy+bncseJZirb81WZtX72VAHC?=
 =?iso-8859-1?Q?EjqBw2KvpWRHT37DmF/qk/ZU6FW5rrFtOKKVeYhTxZDby+p2kVtHlwD71A?=
 =?iso-8859-1?Q?mNLsBCpxH7nEpTG8HODPjqjvfJjjdRyQR/hb43p9VdLPPtM8bXTllWsY3M?=
 =?iso-8859-1?Q?gjiar2qpwmh7H3yNPh4lCHvzRc+aNv5wdLrgsXDvokkVFskkxRPAFuZ0D/?=
 =?iso-8859-1?Q?VQ3HSNA1+Ssc5IdTBvk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a49f6da-73e6-454b-725c-08de00cfc7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:13.9648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcPH4mpibItYpFv0E2zUSujxpfZInvfk3pvm7ARZgi81ZEcHXDVbKBycPGDHM0Ef6fT21StnkOrXOaQCoyLmA8UOBUvfO+w35006rwaaYmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index f7c4bd0f85..46b7f1a3d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -425,6 +425,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

