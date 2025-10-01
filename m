Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923D7CCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tT8-0004Ti-E5; Wed, 01 Oct 2025 05:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSi-0004MT-U7; Wed, 01 Oct 2025 05:49:29 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSZ-0004uf-34; Wed, 01 Oct 2025 05:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUH8qVYFIxpvZ1PZ+YxYpWTKoy1y/2I0sFwMzQrzsWzjQbccsuSAtpV34vSaYK6ufAIYXNn6PTMLYMnXQpR1AJzpAUHmy1NCmfeevIotXpSltQ8q6TYOhOVc93O2J+oqCOh4Dzu2VswJ+hZSUr6/s0Vs5bXi8jJ83XwUD7BjvyDY0M9zXBL37EqE9bibJzKoWcU/+pFJTIFdG90z0XG1grULoyzaiqi/tQmhkQ3fAngYbr65DoPc6PRccvDLx9LbnEQ33NWEM5++WTCvKcvChzlETupLw/kJ5HqpA7FRO8QsBG5rRejiZk+rWnvZdSz09dZsk8rvd429eeRkpYU73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=ytmAHXfgI70jr1RdZhaPnIqQBU7jRHZX4QRlnl5JMCDxkGJHkGDse3g/X5fbiwUOp1FbAMEizkqvBzl4qQ6OiQxXiawHVYyTxb90DIyc1NX0Tv43qx3EC7dxuzpb+B4vIUwcequ2Xh2YDMFOJveC3yY4SYxcb91C7/KGwNp0NDKgRx0IX+rwDPskAd1Nz9p9EU1QGoZk5NCsU8RdqIEVjoE8RI5KQTs8KntvM6Aumi/mckW4cxbpORkh1pKhjYJSynxy++mW7vrvxpM9dhXdwx/fRZG/7auq0rkhkZsBtE+dnmLK+1SdnmiBG85ChfGsiWFCb+1ynQJRgCbnKxZqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=B/n+jwZZ7VMBuE2F7u8Y8deJY9Rjku8MorOYXnBNqoWzGnw4Vnxcs3oJUcb7bYSafb5/LQDXG4j4xviqYHV3rZygjo6D5rslWyLZCKnKTqlY1ahgrBtv2toqIpIZ6uVO53kVnSXKVrNhxkH+BZW3s9L8fRyLohVOjBKdkRR4zE4jkXrj0coELCRas0Hmso7b70+eE0OZfHqthJuJoUBO8P7msHoU8Y3uL9TQaNXBVJ4ozI8qbrxnsUOEHRmmKW9fNpNC3/yjKHQQesjEoLtrOzsoesSiSuCye63MLiZ/6YrzsLu1jB9JyD1Tdrse3j6BWzQjRXetD/2CPIpVoNcMYA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:09 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v9 01/13] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v9 01/13] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcMriiwwOZhbSjJU6ZMDctF26CvA==
Date: Wed, 1 Oct 2025 09:49:09 +0000
Message-ID: <20251001094859.2030290-2-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: d6db2651-32bb-43ea-42e6-08de00cfc501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I/JbB0ZDG28JuiInvZmntHsohuWAjVdkdbABQzp89f6m80D9/jMLaGCxQ6?=
 =?iso-8859-1?Q?mzdVCocWJeLBuI8+vlWskvlQf7JzkxnRqCl65SybFT16DErN2eX+XEXzzo?=
 =?iso-8859-1?Q?fBaEG6CgKNdnOtfAsA9MvrzDVavLuVriKEnVfFwk7apWftRvjq43VvgkSW?=
 =?iso-8859-1?Q?cAACt9M/h8PiA4NK4SXfOAa23CbPEamjLnPIe+9pqaOeqqBQtAUaFbGZJG?=
 =?iso-8859-1?Q?KPMnt0/CnGrgC2YHRtKA4uvuKd6Xj6cUFtexxblfiLkfwaxLHGxRdW9y1a?=
 =?iso-8859-1?Q?vD0fOilZqs1PniV7vgrQIDuNiU2mdAaNzxYFTTI/aLy+V+kFkNy5s0jpd5?=
 =?iso-8859-1?Q?t04S6yGNWp9XhpkqU2qdVya2UNh0PC9l0Vqa969091LtV4lnsws+kbcTcq?=
 =?iso-8859-1?Q?90kFx+OU8lvj9mwz8QnW+L3TKrqVbfeq1u+WUn7zyz9nEQvVEji75zoSTk?=
 =?iso-8859-1?Q?UbIsBPNmljLrBph5BQCKxEEBZSm9/oMMMc3m/0lqNZbN1tIyUeIwK3bfMr?=
 =?iso-8859-1?Q?W7K8y8Dx7sLveIi2AF1uxz0m6jhPznJCqeKDP8GSdEeJ1hokgtnoeC/7jS?=
 =?iso-8859-1?Q?A4VKKtqbXMwNvquHxh7QEJ+Z+1vgvowD4/GHxaQlImbkSYvnr9BN771hhY?=
 =?iso-8859-1?Q?dcbD6rOY5fZZMCWNcZjo/DGq5dmLdY7ED6cZeICH5nEhp0yWRnovrcrmL4?=
 =?iso-8859-1?Q?0q+tOKLPvEYuSnn9j4lgALOQm6mHfDjbxYAXMl+v+a6zFBKM31fWgCb+rR?=
 =?iso-8859-1?Q?thJXLeLZblEfLH59VIure+JL3q9FT8ik63WGN9uc/Vl4vyJl2xagHVmNjv?=
 =?iso-8859-1?Q?Db6PnYgX7XAWOR3dzXktcmpZK6amwPXTlG+Eb9PsneodOKZLN61MDNb7Ze?=
 =?iso-8859-1?Q?ZFcMgbnKzRv9M73SfEN8dh1ztnxvpjfcoUoCpu9yyodZkFyaDSZTZQsJe5?=
 =?iso-8859-1?Q?04KkLJFdUpDY2m6zi0oglEv1Af+wU11+Sjv2qVknoKQHU9DsJHK+4YDz6o?=
 =?iso-8859-1?Q?5cMokomOjw91L3qOpILAkPwQN2iBz9siSmZtIOXEESxVpR7ig6wkK2aKrA?=
 =?iso-8859-1?Q?ARu5135UNU+BB/3IhqHh+AY6WffTNWkqqVrMDHXTFS6lj34i1svjUI3HAp?=
 =?iso-8859-1?Q?Fw6G3xpIPJc1xy6/yEoT4DJo49yi5HyemZRn04zGu/8FEUQm2dosgQlpm5?=
 =?iso-8859-1?Q?QaA43rKo/OlIb3HjDgornuXoTbJ+x+ntgsTwLbNvRkKCBofdSi/S1PrjDD?=
 =?iso-8859-1?Q?AfaH1REC5LchP7UJ30MFSaZyx4plGx2N1aUUPDLz3TWE/SWik+uPa+uo1/?=
 =?iso-8859-1?Q?SyWpuu95SckN6FSFf5zwShyxnM45Yo1iyxc18LwBdB1vQezB4hjV2gwHDD?=
 =?iso-8859-1?Q?6tWev25eiy7FgzJw+ZkpsoOFo4rPb1bX9wKOs5fvfMOKbO46N2TtBKMW02?=
 =?iso-8859-1?Q?ndnRxzVkdlKZDqOhUqQ01Z3LFvsztmKQDHMEcYl72htClPb1EWo2Ywd8GN?=
 =?iso-8859-1?Q?zNUPan9ZNxtLQ3sCD8rrbGnLzGltLaxs1tIbZoVvCxJ3cnC8JivUwACoKv?=
 =?iso-8859-1?Q?W0jPzOsi1mg5X+wAc42QsBLot8Lv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nOGDEJKLP1vKR8c8YbVFTKm4Tae6lMUvaxTSj1ygPmYlB0GgrdJ3PZEcM6?=
 =?iso-8859-1?Q?NaqlGc6XHN10+30IOZxdv3uQRH7DzrRamYChDdrc/It+oXNodylPU9swdu?=
 =?iso-8859-1?Q?ygbMMJWfB5DW1k/7YeLtrw4qp0cGm791v/nmJvwKpHqI8FnVXsJ/TSQEk5?=
 =?iso-8859-1?Q?Ni8m9p9QgmssDuJR7p7nCRxcumUzh0AUAGZnthyhctmx71+KTitmQZZwl8?=
 =?iso-8859-1?Q?Wabu/nyprIipy/Cr1ZpYk5rsSWXYLV/u32CUBnBg7qM9utrHN+2PfcQ1D2?=
 =?iso-8859-1?Q?DRR5klb53XW9uDhNFPs3atB+K7Q5iGhLfXHEOIX1uVabxnhfArYDhnjGUL?=
 =?iso-8859-1?Q?TBCKD2Nd24K8GpZgtzwv3+ZD27By7ugcg/cunjWw57A+atsy+s2fp0YXjF?=
 =?iso-8859-1?Q?nzAScLKGUVB3i5oD81LCwofR0W5fdMG4hj1KCqvzUHCfDHqFnqrfltv21u?=
 =?iso-8859-1?Q?oHSYDE2sZfAewprfPz65DOFI4eocPwMaHUHI7NwHY4NMRAriGeL7Z01FfI?=
 =?iso-8859-1?Q?+dd4JdGNOWvkVPsGV75MfL3aC5TwFXSLtWHRi7YPgclXtr5PpWI3LHm4Wx?=
 =?iso-8859-1?Q?0tQyNr6yF6vlArtyUOAIQI1vM+L+akRhsOkfN2yBFddV9bhnfx0oCMH42E?=
 =?iso-8859-1?Q?XAvH4ishmuoETxaTQLu42fZkCrCNnvGLD6xKj1iZ87tBMih9o2Hv+RrSgN?=
 =?iso-8859-1?Q?p9XTIGLgwSLX/94R5rTWyrD5yrLnYrfUDxtDFKStxQmaoWboA24r3RxwI3?=
 =?iso-8859-1?Q?fQAbkNFGRWzjbjQU+rt5YTzqv1Q0g/Xetrvrf5GrFxCLAsaffVGawoOuUD?=
 =?iso-8859-1?Q?/BqyLymC+g3da+XYKhdnwGgTwMwwETYiLZNgsCT6kADH8YBDYjlNmIyDNw?=
 =?iso-8859-1?Q?bCVUnwDXjcmQ7hztFORc0Sxy33/AIgFu+XCEFDuEfNyXhYhey7ImTSeQZ0?=
 =?iso-8859-1?Q?cRA54OocUwSKQAcHQ2y76f79GEi939U5MetPRhdM+TrOrJvItREsWmw+/P?=
 =?iso-8859-1?Q?bw3YO/IpBtXHcBuH4dNL1zx+Cj3L/QXnA8uJwA3kyp14EGsAXkGP+bKZp7?=
 =?iso-8859-1?Q?Cs8nVvzB58W12oTqr9iN8LyBtRnulRW/jEj1qBQnlcHjJ2uh470L6O/02q?=
 =?iso-8859-1?Q?iOIw3mTz2a7LDUvRxlG1hE2R4nhNFqgzw3LlNQEWhHt9wtiuzCmpWvmVQP?=
 =?iso-8859-1?Q?hjLfhSTeU64uNLJU/PszzEiRby+RaXc+Wx7hEYEBkE0Opt0jsLvmqHegTC?=
 =?iso-8859-1?Q?oC/C7L6DLwt0oBk8wZiPeE8K9S25p9IE+rfJOEXjYqmKxal/pwzsmMp6Kz?=
 =?iso-8859-1?Q?5iH06uZ3+bMwn2FRAwJ0BllnT8UQBlvwD1m6tDcXy9HcvmGunERGJUK45K?=
 =?iso-8859-1?Q?1zZ2bPMo2I7R8+lioBDAmeAD6WIpupXL/4sZU2ZOxh90cxKgDQpNMJYZ95?=
 =?iso-8859-1?Q?Dwvk9ZaDmT7YjW/GPHxEimZZe4+AsP0Bd6H5ng1o1Kd50OE5rcp/GHH1sH?=
 =?iso-8859-1?Q?OUqtnTOczQnOdfbFpAe+kBMQgnd9g69ZCiz7/g5Dij2YgZKpljSE9U2c0X?=
 =?iso-8859-1?Q?ja7dW3Bm5V84NMOHIibQlmvsJyPAviiBGfLJtZ7FwiuvU37qVrXnIYSdDK?=
 =?iso-8859-1?Q?GyK5F/ulFNZm4XU0reWQU5NoX1J0qglgSboDdSKBMIEPMgG8g6u+Ypuhk/?=
 =?iso-8859-1?Q?yzchosAwo0B1oHZXJVk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6db2651-32bb-43ea-42e6-08de00cfc501
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:09.6236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s35CSTaPcwrPCUDXaf9GP5bbgAP+Sk7tM1YWyHsomIPZaTBJWZncGk4dpNQqAF4qq9d0JeRoEYOnFv7K2l+qBL6YeCILZVQT/VMnkpdaDNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

