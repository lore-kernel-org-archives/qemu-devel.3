Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BD606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ffWLUONG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULmA-00081w-0P; Fri, 20 Nov 2026 05:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ar.semenov@outlook.com>)
 id 1xULm6-00081c-No; Fri, 20 Nov 2026 05:23:22 -0500
Received: from mail-centralusazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d107::] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ar.semenov@outlook.com>)
 id 1xULm4-0004Ow-QP; Fri, 20 Nov 2026 05:23:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViesNpH3qeZv0ymKg47rLFRE+RjGHMezVd3KTzbZ0kVFNZu86rjDhxo6Awz2tUozP3w6yCMUeHt+QgB8qxcMJXgJPQtsa0XBtcMq69QaR0/rymUbGxBiSD++0o/UCXISUMXpdo0wiPXnuAf8JZ/YB99Sh4Ut7GMVdMFwgztvHOY2LpAlfDLOPUbg5SEMW8x6PwtQEpALDq7AvSGstwbXiG1/TnlHYKZDRkrqFIjXkEzis+WTTahHTGgJBIRyVJ+ONkZyXwdfVSnKHj6FUN2O4WOH9pd/WH36THg9N2I2KJXCy1DC+ARBrz+n5OtbWjxByGzbLkCx2dnX3jr0Ykclcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeKBt0qtNMI4PKvUNlqSwNulDRDqKOhyvmY6osIvP6k=;
 b=nArwKpvIj7hVW5k45SH/woeJjkBVGB/bP8p1Gin94xfP+DRNW5iINBdIxS5idfT7w6zI2kBWaW28tm53LeWzyxrrNaJ5ovULW+r5E6atkjmpw2CnSvaK6YBOocL0KH1HLo/9a+YvGmVUb6AAmx33xBFWggqT+fwo8Rtbp7Y69ixe2mPbkdEgwUadDqST6Dz90D0jOOdWkZ3O2mRjL3dCtjY6HVLS4UVo4IzFD+E7mz2/HYGrwvYno0cVxbMi3WqPcouWbq2gO0xTT1j5VbnKcD3C+NPgONp7g16ifl6rrqwwvgFKASmSpuWOHotCnEpxz89WhYlygIbPJIcxKkANjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeKBt0qtNMI4PKvUNlqSwNulDRDqKOhyvmY6osIvP6k=;
 b=ffWLUONGMp1NmFIWGWtpzfnLddr5j9l4xIP2CbA273wb5a0a4hXSoC8lSEwLDjuMwM+PpqjgoX9SyHA+sO16VeIs+rsSflyTLcnmcTYAEdIt8Is8ZnLB5obZT+e64QdsiwYDK+yRRfbDLBy9bQebyEgXuSBr0xeHtQ+KMAZe5HM8ORzIraeNNi1T/lvOJsDTb70bE0qX3bVjGB/m20wCEL1ExdkHmOvXLriFBkpuajifjsjSnK+2Ya7uSetiIppZ5NhlpbpQK4uw2mAz+v8J+0cV9bb8rZvLGIZgsQ2NNx8XwhTInYjOmgnFYgZ6GtgIMAgLuiAboKQya5qX7TnSVg==
Received: from CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:18:15 +0000
Received: from CH3PR11MB7346.namprd11.prod.outlook.com
 ([fe80::89d:2e3f:86f3:48e4]) by CH3PR11MB7346.namprd11.prod.outlook.com
 ([fe80::89d:2e3f:86f3:48e4%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:18:15 +0000
From: Arseniy Semenov <ar.semenov@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, "cosmos.xu@synclite.com"
 <cosmos.xu@synclite.com>, "qemu-security@nongnu.org"
 <qemu-security@nongnu.org>, "antikostya2@gmail.com" <antikostya2@gmail.com>
Subject: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Topic: [PATCH v2] target/riscv: add support for the hcontext CSR
Thread-Index: AQHdeNhQhsWmOXAAGkCGT+xcUTJTxQ==
Date: Fri, 20 Nov 2026 10:18:14 +0000
Message-ID: <335b83ef-aec7-4345-a95c-6eb669d48a66@outlook.com>
References: <>
In-Reply-To: <>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: CH3PR11MB7346.namprd11.prod.outlook.com
 (15.21.0639.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7346:EE_|PH3PPF6E8D29981:EE_
x-ms-office365-filtering-correlation-id: 264b3049-588b-4f82-e1f4-08df46ef96c3
x-microsoft-antispam: BCL:0;
 ARA:14566002|4140399003|8062599012|19110799012|15030799006|51005399006|8060799015|2604031031799003|15080799012|36102599003|31061999003|22091999003|24121999003|12121999013|6050399003|41001999006|40105399003|26121999007|3430499035|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?70eJ2vREV42RBgrbKXocFb0nuYZpEtNW4CIOdOugrj+bSCPs/K4QcRQ2e1?=
 =?iso-8859-1?Q?xJDwq4bqRJu/ban+SMzHDZ5ZMi4gp6Lymu9b8Kok39GlzgXbteCwSsYhTJ?=
 =?iso-8859-1?Q?T0vqmu/od1KikSoXUu56AscSgv52bZ1QDpob8MO4NnMDxCIPDsMevzwfH7?=
 =?iso-8859-1?Q?H8CAOK40u8A00ShJBTJTjVPhlETzvhO470hxA0h1zq1+caH3fMTP549FqY?=
 =?iso-8859-1?Q?CDL4O0mOL58xhAfkDaK8MiybVol0NWEYz+syzKjJ234dPCj9Khbe4FNriH?=
 =?iso-8859-1?Q?3GNVIaT995oPIqYr4P8OKlNeBE1QdPG5CI54ALHpBQWWGgnBs/q8KN8c4q?=
 =?iso-8859-1?Q?Q3QDshwkZNpOwBil9mTHPyqmAtuEkuj0E6IYPYPIeJCRo/s2jishE5GtQ+?=
 =?iso-8859-1?Q?EEAGbwNJS4OS9SqwDOjt3Xx6kAUhQHUG1RJS3fC+DaQiJBBVeVXQ8EBVQu?=
 =?iso-8859-1?Q?m04TDvwGwAwGNCpHIBkHxcckgGRiWi9cSNKZv1S4Bh4xcggFSZQHKDP6cq?=
 =?iso-8859-1?Q?OcYkhVybgv07MBJKsqLU1BAJzTeujS0Sf3Nve73+r24tV5s4e0ngooYvZI?=
 =?iso-8859-1?Q?Wc0zsvcKAv/MyhvAzC4tKz+WaqZIftfI7x5ne5n9IuU9A8Xiby/QnV30ND?=
 =?iso-8859-1?Q?ZR9Bvkh63xEh+qjpTYEu2GC8yi4dGfgJttIrSRG9S6Bt1o60uRFXFtxeTX?=
 =?iso-8859-1?Q?MINhGT4lJWiX35R7kCIdxEK4ECg/L9fLRjBvVHVuHO17sGLU+aDXCR6hLm?=
 =?iso-8859-1?Q?BWW3ctY+p5WW/ik/elS/ogMNddW5QbqfOnqCU2dDrUHv5DCo4xdjOqrG/B?=
 =?iso-8859-1?Q?ChCUleo9zvCshLqcvkhiuqZeo2JpC5hOCWAm3cDrfpjMmzoTsFh+kNGMOB?=
 =?iso-8859-1?Q?XOgjpXYfEqJGW67TjTUPEl84UpbHhStLFlTwBA+oTivffww39dtFwEgLlx?=
 =?iso-8859-1?Q?9iJf28jlKmgUgstNS6qEzwK1JdoxdODruCfMps862rdHf+P6sGI7nxpVRH?=
 =?iso-8859-1?Q?+NOKrVSLSjHyn25kNfbbKZepPxJaW4lUOMbbrde9jTlwooAyoR6gUY7vP/?=
 =?iso-8859-1?Q?kuITYkUhEnOXnSultchRHcUbMKtfrF8um0I5F/0ZsyVJf3hoB+phm1JyJC?=
 =?iso-8859-1?Q?uzoOHHDhfJih65YvX2RHuAAtRYL5gnp8BMzx/hAeZweWsVSaSCwa+hBg89?=
 =?iso-8859-1?Q?R1wzt6Uro/spsnNZj9Q2hvC+6Z0GJpF9ZOs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HqrRFMoNhFxuGeRqymsYXY+FbTgWVs5EfDtPqG1P7w73/XHZwuxoT7SA2/?=
 =?iso-8859-1?Q?SblopJNXPJI186dNlS9AgKM2m+djrkaG99DPZiugKabjUpeF9J2vWiln8V?=
 =?iso-8859-1?Q?ds2ZFUozukVTQIX9WkXdnhB1kDsHG2iU51IuHmGfLQu7Vtg+jQcUKjJd7B?=
 =?iso-8859-1?Q?4RXM1qxYYhDdY8eTu+2ioxZxfPJmxOSDuO4k3SUqQH5rhTPRsI34juVzOu?=
 =?iso-8859-1?Q?d6G0YvHAxVqrR9weZBhplymUjICeH5SGZb/w1zKTDHmrzM4mzsFHQ0Qxov?=
 =?iso-8859-1?Q?YTGyaUTby9rsa5Arz6nBIeMdHI4UTDmLqndNj6TPYO9JBgDe0d9jC/nRDM?=
 =?iso-8859-1?Q?/UjEfqFOEoyLYaADLKtL7D/GFMfD0iPV+WEHawe6+COsIActvdT6MnFZME?=
 =?iso-8859-1?Q?m0p2ekmPMPSVe/3o2TdU12fuDlUL8r9JyGXa5ISFHRIZTS2X6jFBcxuZ2d?=
 =?iso-8859-1?Q?h38wkv2S2RmhfRT4nzEcGiLnEOGR4SrpPuRI6elyxTWKy0JoUm0XwHrD90?=
 =?iso-8859-1?Q?zrXEgdTPoJuIFES1PcPRZb6z7tFye0DGcF77FNVthxWH+Li2fYsFoAC6yc?=
 =?iso-8859-1?Q?l95D0VrVScFr0SZDaP1h2GBxa6bsJQCu6vUVx121TiElUdCJUkUc9xm9Oz?=
 =?iso-8859-1?Q?ryGT/dkglGz5VQDjjoaH129xh2qTpy2KlXGWNdvIF0qDM2ybrlIJZqSAQj?=
 =?iso-8859-1?Q?uqmmfnpVszqB5lAE8cj2+xKlG7xDTnmFkRLwDryFudJTAQ/Tnr/4UYZ5Db?=
 =?iso-8859-1?Q?5Z3/t7NXT9Bnwzy06rvXkN+7BuMMvU/7sB7jtJ+CdSeADYh3mO4Z3B7LBu?=
 =?iso-8859-1?Q?AXrsi89hRqTX9rTxcMI3JsyoNF4TX1Hz37JT3+IikDrD89cDW7Ilg4cU9f?=
 =?iso-8859-1?Q?sIf6n1S9uPa+Dik3nUPUny8AYbS/XTUz31E70kiUe2tH6OfjEOatSQIbar?=
 =?iso-8859-1?Q?rNwlAA6R7vWVgKJnoyO7IAbWYO+73LwSHhc5eQ9/oYRgwDTpmmh0ab3S5B?=
 =?iso-8859-1?Q?VM9WMyDhWd7+PNYCAOeZKbcOMxxWcLzgufyuUTb9RtwF9yAtsKIXpU8fiK?=
 =?iso-8859-1?Q?zrKkvp4/S4gr/qRNFM321v7pjNMrNYVpq/FcIF7kATx6GW7bCI6vmd5NkY?=
 =?iso-8859-1?Q?RiTvAYDI7V1YL29d0gjnIPGRLPc+q0aKYK41nTtzJwbdgr2m8MIGFy9x8l?=
 =?iso-8859-1?Q?LndCPRG18ENMKble04IWE+IxLLdaav0yMqL/Gghs1gcdDfwscGFOFYhP9S?=
 =?iso-8859-1?Q?/DE9HAp61GMx6OogtN602doniFADv3LJs3h3Ba1oysVQoSIQYSmiNyvmeE?=
 =?iso-8859-1?Q?G0ARXLfv96td+afDcl8vaR0TwVDc9bdAsq9FOhhMYeLJhmOZPaN5MFdE1N?=
 =?iso-8859-1?Q?WRDdk2YAJ+QCXdJlhDmUHT2wJNouuK04FvV8TQESc6/zAOUZvr398=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <48687595232E084FAA043052CBD44374@sct-15-20-9412-4-msonline-outlook-a6b68.templateTenant>
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7346.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 264b3049-588b-4f82-e1f4-08df46ef96c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 10:18:15.0160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
Received-SPF: pass client-ip=2a01:111:f403:d107::;
 envelope-from=ar.semenov@outlook.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: "b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com"
 <b8da8748-a668-4481-b483-66f333a0614b@oss.qualcomm.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=0A=
Implement the hcontext register described in=0A=
"The RISC-V Debug Specification" Version 1.0. The hcontext CSR is=0A=
accessible from H and M mode, gated by the Smstateen HSCONTXT bit.=0A=
=0A=
Changes from v1:=0A=
- The Smstateen HSCONTXT check is now only applied when the access is=0A=
   made from HS-mode, as required by the Sdtrig spec.=0A=
=0A=
Signed-off-by: Arseniy Semenov <ar.semenov@outlook.com>=0A=
---=0A=
This series adds emulation support for the hypervisor context (hcontext)=0A=
register, as specified in "The RISC-V Debug Specification" Version 1.0.=0A=
=0A=
The hcontext CSR (0x6a8) is a read/write register accessible from H and M=
=0A=
mode, whose value is derived from the mcontext register.  Accesses are=0A=
gated behind the Smstateen HSCONTXT enable bit and writes are masked to=0A=
the xlen-dependent width defined by the spec.=0A=
=0A=
No behaviour change occurs when the H extension is not enabled.=0A=
---=0A=
   diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h=0A=
   index 3579789a1f..bfa10afca8 100644=0A=
   --- a/target/riscv/cpu_bits.h=0A=
   +++ b/target/riscv/cpu_bits.h=0A=
   @@ -456,6 +456,7 @@=0A=
    #define CSR_MNSTATUS        0x744=0A=
    =0A=
    /* Debug/Trace Registers (shared with Debug Mode) */=0A=
   +#define CSR_HCONTEXT        0x6a8=0A=
    #define CSR_TSELECT         0x7a0=0A=
    #define CSR_TDATA1          0x7a1=0A=
    #define CSR_TDATA2          0x7a2=0A=
   diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c=0A=
   index 063590f56a..e817b8383e 100644=0A=
   --- a/target/riscv/tcg/csr.c=0A=
   +++ b/target/riscv/tcg/csr.c=0A=
   @@ -814,6 +814,16 @@ static RISCVException debug(CPURISCVState *env, int=
 csrno)=0A=
        return RISCV_EXCP_ILLEGAL_INST;=0A=
    }=0A=
    =0A=
   +static RISCVException hmode_debug(CPURISCVState *env, int csrno)=0A=
   +{=0A=
   +    if (riscv_has_ext(env, RVH) &&=0A=
   +        (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig)) =
{=0A=
   +        return RISCV_EXCP_NONE;=0A=
   +    }=0A=
   +=0A=
   +    return RISCV_EXCP_ILLEGAL_INST;=0A=
   +}=0A=
   +=0A=
    static RISCVException rnmi(CPURISCVState *env, int csrno)=0A=
    {=0A=
        RISCVCPU *cpu =3D env_archcpu(env);=0A=
   @@ -5703,6 +5713,52 @@ static RISCVException write_mcontext(CPURISCVStat=
e *env, int csrno,=0A=
        return RISCV_EXCP_NONE;=0A=
    }=0A=
    =0A=
   +/*=0A=
   + * Returns true if we are in HS-mode, the only mode where the=0A=
   + * Smstateen HSCONTXT bit gates access to the hcontext CSR.  M-mode=0A=
   + * and Debug mode must have access regardless of Smstateen.=0A=
   + */=0A=
   +static bool hmode_hcontext_smstateen(CPURISCVState *env)=0A=
   +{=0A=
   +    return riscv_has_ext(env, RVH) && env->priv =3D=3D PRV_S &&=0A=
   +           !env->virt_enabled;=0A=
   +}=0A=
   +=0A=
   +static RISCVException read_hcontext(CPURISCVState *env, int csrno,=0A=
   +                                    target_ulong *val)=0A=
   +{=0A=
   +    RISCVException ret;=0A=
   +=0A=
   +    if (hmode_hcontext_smstateen(env)) {=0A=
   +        ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);=0A=
   +        if (ret !=3D RISCV_EXCP_NONE) {=0A=
   +            return ret;=0A=
   +        }=0A=
   +    }=0A=
   +=0A=
   +    *val =3D env->mcontext;=0A=
   +=0A=
   +    return RISCV_EXCP_NONE;=0A=
   +}=0A=
   +=0A=
   +static RISCVException write_hcontext(CPURISCVState *env, int csrno,=0A=
   +                                     target_ulong val, uintptr_t ra)=0A=
   +{=0A=
   +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;=0A=
   +    target_ulong mask =3D rv32 ? MCONTEXT32_HCONTEXT : MCONTEXT64_HCONT=
EXT;=0A=
   +=0A=
   +    if (hmode_hcontext_smstateen(env)) {=0A=
   +        RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCO=
NTXT);=0A=
   +        if (ret !=3D RISCV_EXCP_NONE) {=0A=
   +            return ret;=0A=
   +        }=0A=
   +    }=0A=
   +=0A=
   +    env->mcontext =3D val & mask;=0A=
   +=0A=
   +    return RISCV_EXCP_NONE;=0A=
   +}=0A=
   +=0A=
    static RISCVException read_mnscratch(CPURISCVState *env, int csrno,=0A=
                                         target_ulong *val)=0A=
    {=0A=
   @@ -6620,6 +6676,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {=
=0A=
        [CSR_TDATA3]    =3D  { "tdata3",   debug, read_tdata,    write_tdat=
a    },=0A=
        [CSR_TINFO]     =3D  { "tinfo",    debug, read_tinfo,    write_igno=
re   },=0A=
        [CSR_MCONTEXT]  =3D  { "mcontext", debug, read_mcontext, write_mcon=
text },=0A=
   +    [CSR_HCONTEXT]  =3D  { "hcontext", hmode_debug,=0A=
   +                         read_hcontext, write_hcontext },=0A=
    #if !defined(CONFIG_USER_ONLY)=0A=
        [CSR_DCSR]      =3D  { "dcsr",      sdext, read_dcsr,     write_dcs=
r },=0A=
        [CSR_DPC]       =3D  { "dpc",       sdext, read_dpc,      write_dpc=
 },=0A=
---=0A=
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414=0A=
change-id: 20261019-hcontext-e8e8f54989a4=0A=
=0A=
Best regards,=0A=
--=0A=
Arseniy Semenov <ar.semenov@outlook.com>=0A=

