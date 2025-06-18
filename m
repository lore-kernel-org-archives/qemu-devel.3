Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EF5C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtY-00068B-MP; Wed, 18 Jun 2025 08:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtW-00067E-W6; Wed, 18 Jun 2025 08:27:59 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtU-0005VS-Pb; Wed, 18 Jun 2025 08:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/UxNPgwlfI1oWGWcU3JYvIjX/RLAbEb2AO0KbFArsPDeaPFbDTD/HfLxgBiVOEmG4KQxWJXI2pPF1iDfDzl9TnlQpNuIyG6bX+lrVZ3+wvRb/0ob44zqDb/AikZ2saEZIRUh8m3YGf9/68WgcYeBIMpe0n28OqbHt21SpZ7zDJZEyiYvlu/4KzuUzoIh2CD87s4USMFkuuy9wiWCLGwt/7vbg4QxhMjqJ/B4aCdFPahNkWGw5gCL6oUSPRg3ye36qPJytoTwDdcgZzqCjz/GkyyGQRfqw9MaCADnrWcyuGsvUEvS+X6fitrPJj6S+XYr+NtkE7yXNpe5OwIWMD7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qvs9QYi6vJTp7BsDmb5F8mILYBYd4xpHIjbmajQU0I=;
 b=iTMM8n9I0yfDQy5jgUuPf3dKPGdDBCftOhk7GXZukuXheazq1PPfrEsJE/OcVIEnoETWKnjeRRCTuMaNvQeUu+s3O2M/hE/VIhdgnO/XdbQPP6bAQVRO/wTPJeSeXipLlJkgt5a6rG08uXxJ1NDHV5kfhN0iYy2umP1sIARb8DYTPX+zKWyCa7CHdBkluM/sBZ8/6e7nVWCuY+4mMFzbFbsrAmQLBelXzkVvJWijg08KT17Xr3HfrDDxNlZNCUjWL15tCzU5jcRapGQ/GeNab5k8sgXQ2mjijKewm7jFNP76kWp/xIagniQYTeQB/7aXhzCy6LOtP1/D+9DBnIJkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qvs9QYi6vJTp7BsDmb5F8mILYBYd4xpHIjbmajQU0I=;
 b=coKUN19n01IZ7ebNK5hz4mzroOzslVmfL+TcJ/74WI3urkA4AuWCN6v+bOdm8mFYlQ8KCxLQkLSQrLCm5E4KVxiD20g34EPFTizJ0fDlue4nTmTiPKNyYWNC1mmfUlWuXxQCmpy7+LS5rQdKYD3qmdZq60e2Rj6yZeHH5aUTxlmV/MS1pz5728N0QD3TB+Yyf6R0LJAW6uLhZ9gq/vKa0utSsMLgTs9QiOzGs5Nf674RSk8fKNM5vVgPRvqgoHrTMPCyPjwBjwmovDcYuTSMOqdWW79hiHt+tk85OOCNfqLnQalP1T4oRtpjQTFNtPxbNGULKQNhWKyBuYB02GDxhg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB3834.eurprd09.prod.outlook.com (2603:10a6:10:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 12:27:47 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:46 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 01/10] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v3 01/10] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb4Exl3/w1TsSwEUGCtlUjQ7MSQg==
Date: Wed, 18 Jun 2025 12:27:46 +0000
Message-ID: <20250618122715.1929966-2-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB3834:EE_
x-ms-office365-filtering-correlation-id: 3e792bae-72ef-4931-2af2-08ddae638862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Vfoi4eq+LoP/R95vm50QWg9hOuZTxwALLIs+1X2bUr4xT/DDKTYT44kole?=
 =?iso-8859-1?Q?QASLcKz+gWEGhf9T+MO5RM52rLWEVNMCqIP2kgMQQ9Lw4N4TDvTPf8NXkN?=
 =?iso-8859-1?Q?gAWEfCvo5kSRIUNucvFy+nRTZO1VDdXhDA7IrFd7T3YASNr/+fGPSjmd2v?=
 =?iso-8859-1?Q?lNgJOposmF9kstVhKVJyP4Olzonz/GBp2OhVemFJCMgaWMmUCx1WoGhE3k?=
 =?iso-8859-1?Q?4B7vB9M2dLldlGo2m+SsUNNmRmMLUuUeAf0DUcEAFTsHZuZkN0SwXmqLwp?=
 =?iso-8859-1?Q?ej7ASWcCANVuDu61GvjrmHJt28rsMzt4DBu1EYt3w84lzy4Bf4/Ogk/nZW?=
 =?iso-8859-1?Q?m+gow/ybuUPEoL5N1lWZWgFxpVs2lUZzVGV+S2a2njOqqkfG6+ONAIwj7K?=
 =?iso-8859-1?Q?AM3/HLIVtA3ZAptgGBXmof6ChPyHkSQb15M5RupmrtBrXoDOPKpsq4lFV7?=
 =?iso-8859-1?Q?1zNzrAHp42H+SYD/N7hPjpf3Rl/2zTP4i0woYNy8WhPryQxWQzP2uOQLwv?=
 =?iso-8859-1?Q?D2E+IOqpLgIK1YhrxAeRXZX3WWAQ2RjFzvxnnHNlb8bMrnWcsFUScvuWw9?=
 =?iso-8859-1?Q?oCkomaBBm0zfCnGFVObrruJxOXgYM8JRiiQS27gT0ppa6BtDjNTKmx17kF?=
 =?iso-8859-1?Q?HMJfhD8UQr+CSlQhdvQTbgjkCBY0rVGhBm/XWkPCE9r4tDKKdMHyrquX1g?=
 =?iso-8859-1?Q?WMHSPEj2Jr3yQh2DerzTuVNQRqFtbCf1YpGvTOsz55NIZQPh1TKe0Mp93g?=
 =?iso-8859-1?Q?Dn5GS4bXhe1N3THpFuLO8wY9ZcnQU/ssDnkiAHVm+3c3De3+NqVxwsc901?=
 =?iso-8859-1?Q?8cn5+PWrQP/d7GXL0KLRUrBNlBL/VvKvoTyPPIRGhaymGF0d+4ZIW2cUXd?=
 =?iso-8859-1?Q?Y/TBrQeJxla7V9voCaFCPkDJJJzDTDyZkC8vhhLEkUqXr9rrl3Abb4/Sqr?=
 =?iso-8859-1?Q?4eGOKfzjPtVUgy6CjZiHJmjLD7/DCo2/2IPHIL6VlOGjpWBCoThaf4OCf9?=
 =?iso-8859-1?Q?+lRnG1UCaoCxA3A/T4NSex6kJH9nD2o2IgA+YKjrsP+ZK5uUe2PW1P+ALT?=
 =?iso-8859-1?Q?mUn3kS7REpZ+yKzrJTjgIze9LhIObkbbuxIuf58kRinTvQ7kUxNP8gqFB3?=
 =?iso-8859-1?Q?MXzrvvb+lLPTPP3c/2kGb5kdO0ubrYEQpTqN+kWiA42XLJmqAglb6hWucH?=
 =?iso-8859-1?Q?aUomyiUISqJJajTszDKl2DIswxkBrSrrqzYuSA48W7gjOoHUW07azT3k/n?=
 =?iso-8859-1?Q?WoaI4hsT9Y0G2jalPMxEZWXKT0rlnpcwa4nPA1E0QHZkWJ2iX+cG5Ahhoa?=
 =?iso-8859-1?Q?KzkczMtZUH9Ccktsfntl2nMw74hQ//QeUHq3X36aAaQ7iYMBXJCeKcb11g?=
 =?iso-8859-1?Q?7y2dV1QYffY444XrY8kWubEfqgODnHR5QxJfCST+AG9nqL62a+iePk/W1+?=
 =?iso-8859-1?Q?JqGk7CZQJu1JArH8s6Qb7ZRGTTEbe40XCDn4bIPZkvR/LbCyh8FrVoasNc?=
 =?iso-8859-1?Q?bCqhgxjxkqSHjubzyFairoivugoI6hKwuqp00Sdk3b6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E3Lu4kQT743kEezCIOyieHb+mUb+zDz5MWE1MhNNO6HGYI1C23WC9ANTNE?=
 =?iso-8859-1?Q?xAw0CfD6INzKf6iPKtj0RsoMntza8z9WpzjG9JHoTafBBdHFSJUonN6CRo?=
 =?iso-8859-1?Q?nlOnn/qzkA3I7uUeFfcFI2776dScQTUaT16Yw3+R8oPhwYHeL0saiKw1b2?=
 =?iso-8859-1?Q?7yDYUuY4i7Fv1kFsF4K5YfC9uKq69vdLeSSXre9akpM1eT3BBu/z7DPe71?=
 =?iso-8859-1?Q?dwr/3bODFlroM++78fb/G++/ICbRiSXorAVT7t/rTuNN1rbw/ZizqAXf1K?=
 =?iso-8859-1?Q?+/00CMYs/j2YWKkWMSf3fa8CN/vna0zkzgc1X7Teh1Gc6sdxkyhFp3+J2R?=
 =?iso-8859-1?Q?7B79lVHNcJRx9HJWLgORbLREBreeETScBTyHqYSNDhvcX7sWmMvuHoXU72?=
 =?iso-8859-1?Q?whvpZ5WjUIXSCMO7yn0MtatWgCSv/KNyCzPvC9zJttbTW00M8usPrS6X1I?=
 =?iso-8859-1?Q?MC8hKhBByzezG/KLV9l9TTJoLQUE0acYW/GwbDsLI3JyYP1vT7rEqu0wyh?=
 =?iso-8859-1?Q?zKLbUTBXM2DAZmOSivT7CmPG4NSI/yd4AMACOs4/dKDxeueAy3kHt2/Kl0?=
 =?iso-8859-1?Q?gq8vHBgANGstOlZcjJ1SJ2CVyopAfuBU6oKefGuy5B+6M9GMwAQG90at8R?=
 =?iso-8859-1?Q?Tru3x84OdfVP6UURfFR/n3GLZPJj4teCZRPkbvOybAwr8YpIDo+8X3gdMG?=
 =?iso-8859-1?Q?fTXIUNTnfZuImN0bgtaLhop8g/EzmjWbettdFqJcehMwi7e7077SXtfk6K?=
 =?iso-8859-1?Q?U6g4sqEO32hgBwX1m5XvE85yeJKW6riRHpfr6Pf1wyEwg/9UpAIMCjHGqr?=
 =?iso-8859-1?Q?sQQ5l0qaVyFhMWQOm8joYDZxcoxhlkxf7p+lOw/veQOIdGJgaWhUWx5/EX?=
 =?iso-8859-1?Q?f2JIb/TsfLY6TZqeJ9u7eX4BCusKrxabZlk4gylsdHOEiyZSG77rMJzUVA?=
 =?iso-8859-1?Q?9rIJq9pVDUv3xhnR9RGO8kj4RlY0XYPfLAnRClqFOmtGpI3rYj59wcxjIs?=
 =?iso-8859-1?Q?S1qQ4Et8zqoiTUILk2PLbx0OPsulSDVtWZTcnMC6SX9wkW1JdyLXZAhPCu?=
 =?iso-8859-1?Q?tVgInUTHbHb/NBXm+xVb/aVoiaNg/sBq0H41HFl4fm5IHxqYG15GTpQ8sj?=
 =?iso-8859-1?Q?EX6rOCTiWj3i4Z8BGbKLfs04oLyof+PV15T5dDyzFVeZBPIGKihsr0gW2B?=
 =?iso-8859-1?Q?YxIpwxmDmeL8Ern+YLInxpgIAzhksJ1KEIjGnZPgduHVmkSmTNZt2X5UIB?=
 =?iso-8859-1?Q?Pa9UOdqyMOzIw6U4NN2JeKqvQSyqgVO9U/e4xnWB35CnAiNIxu0tFNV7OT?=
 =?iso-8859-1?Q?p184ZIhRNWuk8PWKK/rWsm8K7H/UhW1/Abu9JxdgkcHOTj4CRcEMeqfKRA?=
 =?iso-8859-1?Q?b4x+mHB/zV+ApCY9qPbuEM8K8JsKd6w4aOERRXXmmtRq6vXmWf/LZwCF8N?=
 =?iso-8859-1?Q?w8yyvaeuigIYAXw4XQyGd6hHTLmSxHnaoQftegdtWVrnmWLBVykuwn8D8H?=
 =?iso-8859-1?Q?axuxGzq4CrkgNf40o51liRlwfje3RqravzkP8j1N0x+tNLdbhJZZYdwBHx?=
 =?iso-8859-1?Q?H0+6IeC5nHvk8lhoNz/EARwU37k4pp2Lw/N2cUWI6IcxSxGZe00aCaqXKA?=
 =?iso-8859-1?Q?6Oi4Q2+3gy/NvrpCSXcueO9toi5Nc2LWRm5CNPD13x1DfoBV97vtb5j6Xj?=
 =?iso-8859-1?Q?muiNCCc1MnHeyIYs8Lg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e792bae-72ef-4931-2af2-08ddae638862
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:46.8867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NFjUIytbn6rfER6oWQsQ+JmAkBcFt+/XbjOGlkHJoaQ1GTeIA4yqLG1Q8c7pX6Gd39Gm7wxlTgsJqu2jI99VC8NL9zrNAHNzESgqr3xDZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3834
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 27 +++++++++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 10 +++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..ef1fc57610 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -233,6 +233,9 @@ static void riscv_aclint_mtimer_write(void *opaque, hwa=
ddr addr,
         /* Check if timer interrupt is triggered for each hart. */
         for (i =3D 0; i < mtimer->num_harts; i++) {
             CPUState *cpu =3D cpu_by_arch_id(mtimer->hartid_base + i);
+            if (cpu =3D=3D NULL) {
+                continue;
+            }
             CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
             if (!env) {
                 continue;
@@ -292,7 +295,11 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(s->hartid_base + i);
+        if (temp =3D=3D NULL) {
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -373,6 +380,9 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hw=
addr size,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         riscv_aclint_mtimer_callback *cb =3D
@@ -408,6 +418,9 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwa=
ddr addr,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return 0;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -431,6 +444,9 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr=
 addr, uint64_t value,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -481,7 +497,11 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (temp =3D=3D NULL) {
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +565,9 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint3=
2_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..360a3dc117 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL)
+                    continue;
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

