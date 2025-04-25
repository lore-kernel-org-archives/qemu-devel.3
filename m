Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B604C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jft-0004FF-NO; Fri, 25 Apr 2025 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl6-0001ex-5k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:20 -0400
Received: from mail-am7eur03on20716.outbound.protection.outlook.com
 ([2a01:111:f403:260e::716]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1u8Hl3-0001PG-U9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:02:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubpaArqygFVL9PnpFR0cYR7HiZpmTcROnu99/pGsVLlc1vhdz1KSX3V2Hu0Io/4OWgwXW3WrUpPM0b3YqIG2gjtxWvlFzjuZY5/46lWbHamyk/k7um3K/pZfHhav1Tf8g37bBa3TL+8t1sHj3M57SjwX0MJgCbZmBukPPeRZbvYifNZRHW8q1ia9wsA4Hmj9k5yM4NXrIqAziIK/j8DNypTuqkw/DSoxIsSeLF5ncNfb2bDECS0fzNan9KjD0+2SDT2OoNk3MoxNwhL0fbr8XJx3PmvrWUraZnSufaM3YC4rkbX8MUDDKOG1xqL9srVcl5tYEW2dkH0whJpbFuin7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HshIQ0tYJGlIvCo+Wnnb2m7qo5fLFiPMbgS1khl9fmk=;
 b=Q7QziZwymqs/a1Ztz+gfk4InbofgCncoC2KGIQ+zvha64xeb9fLsHWOW7CogMgaL3Sp4+SThm9Pe6beJPOrdjCMiDxtqk54Oh44RSrzkU9n00Uo01IRkEFVqYNlG20KvOaoSItL4Y8VS3PKUHZnmZyn/KLyp8bkvl1baJ0alYscvgiU/7VbJebqF+wcuM7HrTacU7mDd7YCTFJjrAbE7X6yVS9fHk3D4oJ1Kpia6h5cz7vzpARlT5unGPHeVWRM+gQgpFyDHPoaiPcaMTNO/kZSHPJxxl9FtBoIiqdGeV4ZYThtHdRhuOOrVUTr7uoTUtslEsWhyB6nSbRSoxI+HBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HshIQ0tYJGlIvCo+Wnnb2m7qo5fLFiPMbgS1khl9fmk=;
 b=e8S4UEjvM+Ikn19foOWisjz8WLrRuuF9/iqVFd61UkFX0Jp+dPZnj+HYAzYyR3kI0uXfPqQXIPfnw2qdO3Wv1LweXaFuVKaKsFXbBUH2k2zYJqfTfaNbKz/5GcOAqxjHB/XFBBjg+6ZzBHZxpEYwb6vjwjTnEe2IDAcBs+BxJqB0RDutvFUUZiI9AMIxtj4tLYqTz5uEqChLtn+eVkGExBC8pt6EAZSyTpwqskUuh5e0HLGnsB2nUC1OUOFln5vUvSP2bzRk895F7P0dOvxFw7C/ZAydL33TmHBGCaOkYURWQDg/8kswkGUdRtMN2mdigHueRqHyf3xVuzxL/q1xaQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM7PR09MB3976.eurprd09.prod.outlook.com (2603:10a6:20b:114::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 12:01:43 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:01:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Chao-ying Fu <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 1/9] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH 1/9] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Index: AQHbtdnP2srbK2C7mE2AaCNqkm9QSA==
Date: Fri, 25 Apr 2025 12:01:43 +0000
Message-ID: <20250425115912.912889-2-djordje.todorovic@htecgroup.com>
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM7PR09MB3976:EE_
x-ms-office365-filtering-correlation-id: af81e350-bfb2-4bb5-ace5-08dd83f0f24e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?M4LAUXNJRlpFb45DN5diWe7tpXQfxa1CXhkXN+s7TNPUauZfVrwcvtuKh2?=
 =?iso-8859-1?Q?5+qkPSfBQY0VXYPm9dpPFLdZuQ6FJmfwM3KvrBicakURfLh3IMynNV5SkV?=
 =?iso-8859-1?Q?ZDybNFYiX/EZdRdFMVapbgdzEfR4EUBzcVfeXpdnFx/aCnshOpSWf1UsnB?=
 =?iso-8859-1?Q?4IjIEwSeZju+cw16BfuTjxxWUZ/mEZyJ0HQ0VpdHaADFiiadN4zB7NlLze?=
 =?iso-8859-1?Q?+2OmkkYEy7dlH/qRM4EqZb25ny5v/w0Vk4kgy5a/HR6J7qNocQwaCaEs+S?=
 =?iso-8859-1?Q?CLx4euUxTKESXTrfV1T609x+vJLjbGoo+JpEG+XAl1uNcslKQ/JFv61w0i?=
 =?iso-8859-1?Q?+AqONhMN7kvr9ZKY7vC7XJS1HuHI1FkPiJCZacsVOovv+mkIdowCyAH8gI?=
 =?iso-8859-1?Q?9c/c2Co0JixHVu3446/YkPUrmWxxjLjcysQeYe2iV5NhogPhNrXJYnPFa7?=
 =?iso-8859-1?Q?RvyYRMCaSLf4EKX2Jt8J5OA8tvv+i78AbCg0zfOLz9xcmmZ/qEjSpSUM8d?=
 =?iso-8859-1?Q?3POAYR57Hscg6/xvUvPFR22CcLRZFlJvdJ+N/sKLCH/Bn0YrTUFjSN0ic/?=
 =?iso-8859-1?Q?tUMAqVk/Y1/2CpOTVsVFRox+0xUcBtCqbVh0S5EDRplkOMxOtPbF6fdu5A?=
 =?iso-8859-1?Q?4ls/O8i9hujuPNxS8Nc7WqwVgIic3BkUuotjHtksoDop1n7v3s7pyWKP2I?=
 =?iso-8859-1?Q?sdKgHkDpjFMEkeqstb4W6E8QjAIgIbGdSzO62NLevjksOGxqcJFOOcwHWr?=
 =?iso-8859-1?Q?cHS0yGpwdXuFPhN5Vsv1DgTV1RZ4tLYSW6SjdKk+haSHkwG6xd9AiuWKuM?=
 =?iso-8859-1?Q?iTvG9zktasYyr56ZUq/HDKEjVLB8Rj5RGbcMzdFIcOJX3/MnQPKEFtnP/N?=
 =?iso-8859-1?Q?8qR4w483Nti7ZGurU7+9o47smy9kIDWM4RaLYuhcksl56DSLC4/flki4l+?=
 =?iso-8859-1?Q?N4Gsr01gjcdL4Hkkrkh5r8MCRvrO2eudPBp3gtdqhSPNrcdYh7fkc9eM/C?=
 =?iso-8859-1?Q?44iEQtUwna1MBF+lv/YVo8rB9P02IH4PXKFMhZehWJ24iN5FCNqzBBvBzI?=
 =?iso-8859-1?Q?ZgpSZm/cOyGKUihKxAyLVnD2qJeYRWFFm4sIbJ8nEE7FktbaeSZXVeH9Pb?=
 =?iso-8859-1?Q?TZZPRpcVGp0LSkwcaqEmH3CvC/eEF1e/oxVQYQtjvSY3aQmgTUyBb8zrft?=
 =?iso-8859-1?Q?E/lozDibhNU2WSYP5KLYniDX6FDeEKvZaTMAZ4rkp17WE0mpX7DfuLXp/5?=
 =?iso-8859-1?Q?gVLUzGn2ec56CwQb5dFwrr7WH/wObUIIfU2jPC/N/g/lEAg2MP7F7p8rfX?=
 =?iso-8859-1?Q?ItqLGM7Q2NWIgMTPbYE+IBKCIfRWkMTCCPYwbhQSnb0OAThLe3jbrubFiG?=
 =?iso-8859-1?Q?/tUqFRyQ1nlcXtbTrf4sELYZ+FwtRA9Py+UUkB5p9WvUxCWUFxtYVSLY8k?=
 =?iso-8859-1?Q?sD0HooVNJPJnNJAKtHjQwurabvuLVlWF7KG2nmAnuRYp6xPz565jYT8VY2?=
 =?iso-8859-1?Q?qG4fHK8tudgGX38+kw0QYuM0Jm4ZkohiTiYhKvrjSouFOQhPPidv5jN24i?=
 =?iso-8859-1?Q?PZha0z0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AtQ09Rw1OP5yGlCVrbf4IgTN0c2hjLJBTkgaJCoesO41Usm2fT/6fV4AjS?=
 =?iso-8859-1?Q?KXVMaKd5/tIDuO/JZwK3zLmblEa3aj5zsF2V7w9dzFZXFlo8VNhQ5C+ZOY?=
 =?iso-8859-1?Q?92wlAUsJtMaoypUvRYhiOXZglkbzOL11gF4W7/2G9uNVMectYC0r5gBMbs?=
 =?iso-8859-1?Q?A4JItHqa/JmGrOPg+JSbd07rUquGbT9iaMGPwtuFTJkInp1JHPGXQ4vAEl?=
 =?iso-8859-1?Q?Zzr9KrmY+PIsiV6sR0pvySndopnwNEx78+V+T4csKygFlL97BmmzTvk88B?=
 =?iso-8859-1?Q?pYZRSM+xVgg9sIQ+F3o8dz0PCWGqNUHlPIejbVA+7TPWnmGh9OBY975wWX?=
 =?iso-8859-1?Q?eFkrpHuXv/mJd+tC48Yiv+O9GM0taonabjcZ0ilMb8lf04LkNQX9c2c1zv?=
 =?iso-8859-1?Q?W9omaPJ+I4S4G5MF5RM7V4678f0CfSoQscQfI6OLsN2Qn4pRvCl2vtZvcg?=
 =?iso-8859-1?Q?H2L8rC4Ulw2hPYx5aDmARcLk3wPSjp3xBnsbgfroAsTIRH7styMkZD6+Td?=
 =?iso-8859-1?Q?aG0pelxVdkUbrpWwTBeVsCYSAB8xqlPJ88z/NPXjMQCEgdGW5X6fjWtwCS?=
 =?iso-8859-1?Q?sqS33+5/gIvDQnZaMsNU/tZJflFtJWDAw0M54II9JHZrOuGpGgg0rd/1zW?=
 =?iso-8859-1?Q?VDIOxN9BDoGpfF9GslPmn69fPvMaTBAk3RmeqU47VEyej9J/TrzSm75Aw0?=
 =?iso-8859-1?Q?Ve3IAi3eMi1bdfa/YLOQv+773JavLZQIPXYM9UHCypPtnLyXUaGTcCv/Un?=
 =?iso-8859-1?Q?I61VOlKI+qdnRdixKoD6xVqiF+6ZVdLpFIGL8C/bL0ukQ4jkXV8XMoOHko?=
 =?iso-8859-1?Q?vVDwquHyL57+spc4P57b7dkoyn2cgzHJCbGyKBSnZsS8Prg9n/ggAPWV3F?=
 =?iso-8859-1?Q?6nKEL8aBpkN1pYSzoLkGPKEFuiG7MGVlsU8H8ViAnLJNiQls2WJk7Ah5uf?=
 =?iso-8859-1?Q?uVIGiDByV/e23sxhfgmtRbtTAyHm32bie/8EzkmQZvPs3bDm6X4WWltVFc?=
 =?iso-8859-1?Q?jHmFpWQdzekuUhawG0HXw0xU4xumcVrwRG/S9yHakQLOse3YVwHJexsI+u?=
 =?iso-8859-1?Q?sk7Wc62+EOKzIIAMt3VbLt3y9X5nAcVjQ4dD24IoKUxA9obAQ1dKZ9p/iz?=
 =?iso-8859-1?Q?Q2XjQNTCoDMCHCWvABIV06J+1JHNwOIHtXSzrOe5xE3RP9+vRokOLpsZVo?=
 =?iso-8859-1?Q?eoTCBN572Foe/0NjxdWkNbYBVfn5nFuwza4Juads4/0oT57jwyUTOxBD95?=
 =?iso-8859-1?Q?hU53ybBn4tRyRZfxtK9Dp3T/+42gFhpWE4ngzI5r0Kj5mOJGB9DkdFb4WD?=
 =?iso-8859-1?Q?qM/2hm0Nz/xqiEQkooY+u2sJBaBvhNSwZU+j4C7bSkhxLiC3vyjEujanZ0?=
 =?iso-8859-1?Q?gYVWQqC/7T841FTRTRKKz8BsXaKDQARz4eRmZsnQI4pQUfzmydlHlitbWL?=
 =?iso-8859-1?Q?43q5gUqk8SaCyghDEhGq/QNeVC5GALqKErIBcZWLt3aS9fbSBwmPA7/iKn?=
 =?iso-8859-1?Q?UASUFf6+OIQXnhA2B7PhOD+m8sluJwFbYNEE5QQTb8TlT7ZtOAaPoXFjxO?=
 =?iso-8859-1?Q?kmOnWFI8RGF6IIOcwRRKJAfLUPrA8e21kVB2fPmWzKbYmazd0F2ZvyPHil?=
 =?iso-8859-1?Q?FpnAZJpLoKZoKnm5Tg4vsY1oTv/fqxcSF3WXGt99u6wPr3iD3xt3mkO/5J?=
 =?iso-8859-1?Q?UZyxAy4DoKGd6jjRO90=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af81e350-bfb2-4bb5-ace5-08dd83f0f24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:01:43.6797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbhOCauHuqnNzFfW70k0Ig1bwvzvCneT9DcoHOwuPSmLuoOF+HCTZMMOHOKLemqg6Aep37hH5OLq9/JYVWNF/eaeJyRlEtw0W+7zTfhmtyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3976
Received-SPF: pass client-ip=2a01:111:f403:260e::716;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

This is needed for riscv based CPUs by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 24 ++++++++++++++++++++++--
 hw/intc/riscv_aplic.c  |  9 ++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index db374a7c2d..403a889bf4 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -131,6 +131,8 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, =
hwaddr addr,
         size_t hartid =3D mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL)
+            return 0;
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -174,6 +176,8 @@ static void riscv_aclint_mtimer_write(void *opaque, hwa=
ddr addr,
         size_t hartid =3D mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL)
+            return;
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -233,6 +237,8 @@ static void riscv_aclint_mtimer_write(void *opaque, hwa=
ddr addr,
         /* Check if timer interrupt is triggered for each hart. */
         for (i =3D 0; i < mtimer->num_harts; i++) {
             CPUState *cpu =3D cpu_by_arch_id(mtimer->hartid_base + i);
+            if (cpu =3D=3D NULL)
+                continue;
             CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
             if (!env) {
                 continue;
@@ -292,7 +298,10 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(s->hartid_base + i);
+        if (temp =3D=3D NULL)
+            continue;
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -373,6 +382,8 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hw=
addr size,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL)
+            continue;
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         riscv_aclint_mtimer_callback *cb =3D
@@ -408,6 +419,8 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwa=
ddr addr,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL)
+            return 0;
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -431,6 +444,8 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr=
 addr, uint64_t value,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL)
+           return;
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -481,7 +496,10 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (temp =3D=3D NULL)
+            continue;
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +563,8 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint3=
2_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL)
+            continue;
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 5964cde7e0..be30579028 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,10 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL)
+                  continue;
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1077,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
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

