Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD425EA3F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlw-0001dQ-GG; Tue, 10 Feb 2026 04:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlu-0001Xh-K9; Tue, 10 Feb 2026 04:11:02 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlq-0004kR-LK; Tue, 10 Feb 2026 04:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAeONkMxqlDebEn4k105ZPF0dZY3twjBAi1NTRxOoDxPjrgBWeq1/D9ShkNobA9I8fTroa8FJAnQzteZYqkkWPNAIlUQE5wGUPNGg1whNsGIzqbQlxu/888gg4Fhg9rt4bwRSM4z7/ebR7lpa2MCBwv8x+zcGj/q+O+f/gMuI1gzxt9XAD1M/rhZxaxF9DLIosHPy2h1bS3eqVj2pP1d+RLkkHuDQ4dnB3ecS3JRpVAL4bj0t31DMMTHRzHBnyCQ1rzcTVkLrjKk1N0/O+AQzCSrX4G1AFP98a/NjxzV6XXB3eNr7iFe7z28xHuPaF+aZrk4S7rJKKNdwale9VO/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=MRPjtrRihjRPlMbM7zUTUXQsGqSqYAxJG7QtaZe2ojRa68Q/7atNQyQG5CZQ86xBH2Mp8u56uWOrF2OLyQoL+SPgRvjCCJ+7K/s701IvxawWJUxtj/UNQAy3ojshuG/vWuvfPQOJbH+k75+p5FB1YniqEguW3NKgQ+FWwUTkGJMsTWxOteGdSLsGPbWr9m+fjuwMGfr/1HagpPD2ggsGXfV29ZVKAPuiQ6ASfmcpJAfKmcjLoeT7QLbgYEBXEsvKLzPjI2xU5tl4k5VQmFte3z/4Em0d3eirReNC60v6TyRDT1S/zd4/LTwGMRLEvBiRQBzH/pEWFIN6F9hwJlvoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=cvY+fNAq5tqkE9buxSQNOm/TDgSCQ5lkS92Mq875x7xGQjQ9PRZyFIu4PoHp1Ky21J0Gzd+yKv0M3sTVARmLTFJ2R07NN4mAlMXucBShYEY6mR5Bz6lgGvYAzp8a/YQLp4MR2oNJzCDkCIp2GWmHQron6dl6mzsmepccF4wHevskZ6EWTNyERakXmqHnSqaZ93gG5y96PZ2dj4rbJ+tGD5W44kM7KQiNGoj1PEA3bM6lM/jeOd219mgvm8PIOZs3QlHGgFHB7nksm/Ds8Tzba/BWf5WYlL+jzwy1eGTjYc1wqfLBBbkSqil1hv+V8vBXB7EscAmPvMiVC6Fi5mn21g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v5 14/21] hw/i3c/dw-i3c: Add IBI handling
Thread-Topic: [PATCH v5 14/21] hw/i3c/dw-i3c: Add IBI handling
Thread-Index: AQHcmm0grsEBLSBYVUKaJcsJPoyGPg==
Date: Tue, 10 Feb 2026 09:10:39 +0000
Message-ID: <20260210091018.1553489-15-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 64444e17-d410-461a-212f-08de688443f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9XXWyJV7ItSEMpxpbiyh/YSfG9GM45AFab8XzZu/IHLvUChob8g2H0G43a?=
 =?iso-8859-1?Q?s/2bggZkKUtfs0ZBhsrUg/BojELd3JO0ZqsyRlB6M9xeI4XfJuNZjMcaU2?=
 =?iso-8859-1?Q?draSInqmjmWU+Trj6Qb7MfeIP2WIKrIiy9OwQuny2RBoIcHonCcBuAd6d5?=
 =?iso-8859-1?Q?EVGUR3itnvu5CBKdKkCqLkto+RCwPmipRNSr8iX44x/sadhJnPUT9nkwxG?=
 =?iso-8859-1?Q?d0NvwUeZJE+4+IWt+vGThiySk164y5cAsa6n1VUqyj7wOXxD1eWF9vPTto?=
 =?iso-8859-1?Q?jjvs4onCeJ/bERBfXf/KjW4yHcn8JQ6fNaK2zTYKsbklKTAOc8MuAdvED+?=
 =?iso-8859-1?Q?QSNbWX8GNoZ3Ke1dGp6D+wvwDoev7F9Csnhl1gW3hArd58Aw/hJQ5LE/ot?=
 =?iso-8859-1?Q?rByVLkKwNFnbf44XOh++iedgs+fpDaYzfXnbnCdGMxuvfyZb9vQo+PvMcX?=
 =?iso-8859-1?Q?cRBqzYJmJeACNtQ8SDpA+YBQelhEKbgrOs65MC0OM9E1NIlpnx10vSHevc?=
 =?iso-8859-1?Q?l4yrjcSsTWZxPdCC3Ce3lBhFYa2E+TQ7lFFT/kxYDsGQFIx7lEsyUEWPW1?=
 =?iso-8859-1?Q?oKEPUdwnD9Vkvtr6CD5GZQF8Wsu5NMa5cG7FiXBtOBq/Z3rsVqhock7liF?=
 =?iso-8859-1?Q?qTKahwh53tSzu2NDWc6QlgX3yVQRxq4Qotu/p9oWrka/fzJNDIaJtxjNKk?=
 =?iso-8859-1?Q?JpZ9A3HRe1pwMyLfZk318UKoMyBC8VcH2E4++YuMiNwLJFMyrzmeePJkjw?=
 =?iso-8859-1?Q?2l6Q4zIQCsIaLdHTnJgtiSH/oPlP7t8yUVIZZ7HxXK6lFmiMsUEQGRCjkm?=
 =?iso-8859-1?Q?c9PDefJl/TbqhFoq9teJKo2BjgggXAW5Hy5lPxmVMvz01+mql2Nokf5aAe?=
 =?iso-8859-1?Q?3+g0bdzPZt5NwDQeIcxRgXn7vyjOuaDHZy3DFiaPnXvu3Qg81j07g/o0np?=
 =?iso-8859-1?Q?zUp2ISaGvq9m0rKDsldYoY7fQ3BJ9hMjTPGQtEStV984Ga5YfDdTqHwA6j?=
 =?iso-8859-1?Q?+fuI8ZBmehmUTsQI51x4fXOJImTtlaxk8X4af5OgOUUrXgKNpEeiKwLcAM?=
 =?iso-8859-1?Q?jzCEd07YDhui21DylGd6UQg81BHfUXctMcWl5uycCk0pt6K/vhEyRUkiML?=
 =?iso-8859-1?Q?Bd5FZe1OOz/pRZ8oYGYuAPM+sTOkOW/Kx0OUKz8WM/XH1U76TT2OgmSVFa?=
 =?iso-8859-1?Q?Lfo+jFvkOX7k4UP5m8qgepLxwdD9jUZS0Ni4CJWOaueAbE5TVMzy+4Zj0u?=
 =?iso-8859-1?Q?iHr52br0IIOWrdnqicIjAd2RPlfUNpOwoyenzT6QG3XuQLyRNyimbw2gCD?=
 =?iso-8859-1?Q?hl/XQCdApdnGlr9cgqrlaEgGJps2ldhCjr7vIOODK/DkZZceEocZGYPffb?=
 =?iso-8859-1?Q?LqLxZtsiMRWtsLDeZtWqU129x3s3mVbMEhAD8nn+KGdNMHi0WdNc+6VjXy?=
 =?iso-8859-1?Q?+/AogmaH3NPWx0Z4MA73RP9Mvij6ix1K6u/qIFHV2t7WduKbJAKB4yr3jb?=
 =?iso-8859-1?Q?c8f39ClcUabYUsrkj0sO+Qx5mmJ3b35PC3Qpoz9/cjAZCsulZlUEstkYQC?=
 =?iso-8859-1?Q?wckvx3iOYu8aaqwPEFXhWq6kVdxx9+S9IZK3BrRgPxDGVJkm1KevjU5fJk?=
 =?iso-8859-1?Q?rPGpR9AoCQk/8R+BvfC7+tpcFxrAD3/VmtYsHLUnuy+wxlbu+re8ndyqH7?=
 =?iso-8859-1?Q?PEIGCWQPku5vFv2OB6HPdwpFDEHnqvHpdPAkiwxE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I3iT6A8tybSQ9JQY2tHyFIYQBf5tSrIC5r88S6jP6Zhez+9Cx4CPc9wgmQ?=
 =?iso-8859-1?Q?G22es21cMANfo57SrqejPYxO48wAcC4+OLGOvaOx9OaA8a4lbCWoeNDiMo?=
 =?iso-8859-1?Q?2+RF6W1orTbGQAQQGDOU9BWvSZu/ins4Tv8tlkGmCtn6gkqgqxaSayuK5G?=
 =?iso-8859-1?Q?t8JGy813pn03RFIe2hyVbxPgqO095GzfD05uVSfK81HWBOZW0fIFcSfi1H?=
 =?iso-8859-1?Q?Jrt4ErBsSEcKNZBl/b7vQXtKtbFUuA3MH07a0A8dPGJ1isglCQilVPXgxP?=
 =?iso-8859-1?Q?73tKag5w73GnqwbQdFHkasZpO2RDnwpmGHOExPDh66YQ6efARwjRfXICud?=
 =?iso-8859-1?Q?Zr30t7yX3dmlLy76noZrKgWaloa91EBswyDnw8sKPKngLn0qM3mYcJA9aW?=
 =?iso-8859-1?Q?wfxaiW+Z+5/3xZVPWg3h+5PqKdqT600MKJdE3r5YaohppLWwmqidHUYorJ?=
 =?iso-8859-1?Q?rwHaA3ApWN7zM2jokUEAHGCai8tofSXL/v+ognfX6YOTa2MkOMguEnbxIn?=
 =?iso-8859-1?Q?jAJYvnXLqOMs584+cl3ojEYfIPF18I4pF8uP22+MQ42bkEKyyTe4ILrEmR?=
 =?iso-8859-1?Q?8renpJ8HgltpRC1kEkUHfGH6HyqKYUES3qY3H5W7Y1fiCp02d+77hZcMde?=
 =?iso-8859-1?Q?r1sH8uY3D5AMtpzWG52vHOXDi/9THponTPrVQJcuCpI4ucGRQ+N19D1O1d?=
 =?iso-8859-1?Q?JtnLzXmeoEycqlIgl6ELHRHjsgxaBnaFrPD2eU1ScJcCS4SKQYUgSUCiXm?=
 =?iso-8859-1?Q?4PsHDfVZuycgpxT9N8UTZ9MCJRvumXGMI7klSyAddSS2+Ua+gtYaM1dBWV?=
 =?iso-8859-1?Q?mZtFzXQ+XgCGkk6X8oUB9+VqOmy5UNglc0BQ0b8EM1qVOEQ6TKKkEoEOl4?=
 =?iso-8859-1?Q?a33VhY2+D4bx15syE6kJJanvdiCZgEsK7tilvifUVi+wm4nJddF3tPS2LD?=
 =?iso-8859-1?Q?S/XeJueLOw3LE2UOjtXIQwcF8GoRS3mNPnf7/zA50vbZ5Lt29za1N5gMEg?=
 =?iso-8859-1?Q?RcjpuqkCNd/WGLBsjP7/3YuCT60Q5IYP3ELegXlH3H1/rp+HdkKoZDT/qx?=
 =?iso-8859-1?Q?f2HU6v1Z2NVBZryvWrbE85cC6nhJKc15MLiG/8AWptE+IXboJBHIb1gkVE?=
 =?iso-8859-1?Q?UYAvb1T+vXRnHlsnSSIsr6mrwJoFagSwYx8vRJB8JwwCCwziMueGsys5Os?=
 =?iso-8859-1?Q?rsDFrXKqubxzalW5sawvh+GDpiVml1/o/tKD7jXgs1+RrJE+EEWzyWHTBY?=
 =?iso-8859-1?Q?bPbwcuJYd6Ez/pwikaqB4+ysxsw03Dl3Rs+XC2TRGiXnwbwxS1M887fumr?=
 =?iso-8859-1?Q?mjG8bxjlWVDTaKBCqYPXw8vEAmTMqTDmWGvckDDoC+ZcERVECdWo9uHAht?=
 =?iso-8859-1?Q?nGTztroCGliNLIPZbH573lcNZ7OGUqlEAuhiEppdj0NTRvlgEhBjl3JLOJ?=
 =?iso-8859-1?Q?jPSm/ruTpLBvairxsCHKEBwF7lSpAEStTW2wCxzm+X0MM208TEyiXYR4uP?=
 =?iso-8859-1?Q?2xfYHyloGVlOzuR/ktOqQTe5ODP78Du6Lce9FC8RryKNkT7lS+rXmJByZU?=
 =?iso-8859-1?Q?c8UVxSrQtsOxD00XdqwPdV+t5v3pgQq+o3DfloHBWgR4PvwtDd7ox/HCHU?=
 =?iso-8859-1?Q?yN/E5qHSkK+iPoWOOCXe73lW05PCTTjA14pxVwFMBx8URHKESRH3Vv1eHc?=
 =?iso-8859-1?Q?es4LqyLR7SuE4HKP0wrbAHKHYbFcJ9DtpCJwB1KoWCR7RIwmVWQV9mOzVp?=
 =?iso-8859-1?Q?FHzKHpvxYCNbCappgJgclsILZJZCoRSlYqp7w9/nZyqLOdj7dg0l9c4eqe?=
 =?iso-8859-1?Q?z7134va9Yw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64444e17-d410-461a-212f-08de688443f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:39.9904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcDFBzxZzjKg1RE37GSKO5oM8+rE9OhzdXh7xBOMulL2P5oFyOiNn/66xXuvSxioAO50xynUU+SC/jAIvhjN6uGBVJ++FpDnbb+pw19WY94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds handling for different IBI events that the controller can receive.=0A=
This includes:=0A=
- Handling a hot-join from a target=0A=
- Handling a secondary controller on the bus requesting to be the=0A=
  primary bus controller=0A=
- Handling an interrupt request from a target.=0A=
=0A=
When receiving an IBI, the controller sets an interrupt to notify=0A=
software about what happened.=0A=
When the IBI is finished being serviced, the controller pushes the=0A=
result of the IBI and any data received from the target into the IBI=0A=
queue.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/dw-i3c.h |  27 ++++=0A=
 hw/i3c/dw-i3c.c         | 317 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events     |   2 +=0A=
 3 files changed, 346 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index c50d67cc6b..d26f60580f 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -141,6 +141,28 @@ typedef union DWI3CCmdQueueData {=0A=
     DWI3CAddrAssignCmd addr_assign_cmd;=0A=
 } DWI3CCmdQueueData;=0A=
 =0A=
+/*=0A=
+ * When we receive an IBI with data, we need to store it temporarily until=
=0A=
+ * the target is finished sending data. Then we can set the IBI queue stat=
us=0A=
+ * appropriately.=0A=
+ */=0A=
+typedef struct DWI3CIBIData {=0A=
+    /* Do we notify the user that an IBI was NACKed? */=0A=
+    bool notify_ibi_nack;=0A=
+    /* Intermediate storage of IBI_QUEUE_STATUS. */=0A=
+    uint32_t ibi_queue_status;=0A=
+    /* Temporary buffer to store IBI data from the target. */=0A=
+    Fifo8 ibi_intermediate_queue;=0A=
+    /* The address we should send a CCC_DISEC to. */=0A=
+    uint8_t disec_addr;=0A=
+    /* The byte we should send along with the CCC_DISEC. */=0A=
+    uint8_t disec_byte;=0A=
+    /* Should we send a direct DISEC CCC? (As opposed to global). */=0A=
+    bool send_direct_disec;=0A=
+    /* Was this IBI NACKed? */=0A=
+    bool ibi_nacked;=0A=
+} DWI3CIBIData;=0A=
+=0A=
 struct DWI3C {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -152,11 +174,16 @@ struct DWI3C {=0A=
     Fifo32 resp_queue;=0A=
     Fifo32 tx_queue;=0A=
     Fifo32 rx_queue;=0A=
+    Fifo32 ibi_queue;=0A=
+=0A=
+    /* Temporary storage for IBI data. */=0A=
+    DWI3CIBIData ibi_data;=0A=
 =0A=
     struct {=0A=
         uint8_t id;=0A=
         uint8_t cmd_resp_queue_capacity_bytes;=0A=
         uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t ibi_queue_capacity_bytes;=0A=
         uint8_t num_addressable_devices;=0A=
         uint16_t dev_addr_table_pointer;=0A=
         uint16_t dev_addr_table_depth;=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 2453d74a8c..832fcf326a 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,6 +19,14 @@=0A=
 #include "trace.h"=0A=
 #include "hw/core/irq.h"=0A=
 =0A=
+/*=0A=
+ * Disable event command values. sent along with a DISEC CCC to disable ce=
rtain=0A=
+ * events on targets.=0A=
+ */=0A=
+#define DISEC_HJ 0x08=0A=
+#define DISEC_CR 0x02=0A=
+#define DISEC_INT 0x01=0A=
+=0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
     FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
@@ -356,6 +364,23 @@ static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
            !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
 }=0A=
 =0A=
+static inline uint8_t dw_i3c_ibi_slice_size(DWI3C *s)=0A=
+{=0A=
+    uint8_t ibi_slice_size =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                              IBI_DATA_THLD);=0A=
+    /* The minimum supported slice size is 4 bytes. */=0A=
+    if (ibi_slice_size =3D=3D 0) {=0A=
+        ibi_slice_size =3D 1;=0A=
+    }=0A=
+    ibi_slice_size *=3D sizeof(uint32_t);=0A=
+    /* maximum supported size is 63 bytes. */=0A=
+    if (ibi_slice_size >=3D 64) {=0A=
+        ibi_slice_size =3D 63;=0A=
+    }=0A=
+=0A=
+    return ibi_slice_size;=0A=
+}=0A=
+=0A=
 static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
 {=0A=
     return regval =3D regval ? (2 << regval) : 1;=0A=
@@ -509,6 +534,266 @@ static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t =
offset)=0A=
                       DEV_DYNAMIC_ADDR);=0A=
 }=0A=
 =0A=
+static int dw_i3c_addr_table_index_from_addr(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    uint8_t table_size =3D ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POI=
NTER,=0A=
+                                          DEPTH);=0A=
+    for (uint8_t i =3D 0; i < table_size; i++) {=0A=
+        if (dw_i3c_target_addr(s, i) =3D=3D addr) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void dw_i3c_send_disec(DWI3C *s)=0A=
+{=0A=
+    uint8_t ccc =3D I3C_CCC_DISEC;=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        ccc =3D I3C_CCCD_DISEC;=0A=
+    }=0A=
+=0A=
+    dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                 /*is_i2c=3D*/false);=0A=
+    dw_i3c_send_byte(s, ccc, /*is_i2c=3D*/false);=0A=
+    if (s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_start(s, s->ibi_data.disec_addr,=0A=
+                                     /*is_recv=3D*/false, /*is_i2c=3D*/fal=
se);=0A=
+    }=0A=
+    dw_i3c_send_byte(s, s->ibi_data.disec_byte, /*is_i2c=3D*/false);=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_hj(DWI3C *s)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN=
)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    bool nack_and_disable =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                             HOT_JOIN_ACK_NACK_CTRL);=0A=
+    if (nack_and_disable) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_byte =3D DISEC_HJ;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_ctlr_req(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_R=
EQ)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, MR_REJEC=
T)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable controller role requests. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_CR;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_handle_targ_irq(DWI3C *s, uint8_t addr)=0A=
+{=0A=
+    if (ARRAY_FIELD_EX32(s->regs, IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IR=
Q)) {=0A=
+        s->ibi_data.notify_ibi_nack =3D true;=0A=
+    }=0A=
+=0A=
+    int table_offset =3D dw_i3c_addr_table_index_from_addr(s, addr);=0A=
+    /* Doesn't exist in the table, NACK it, don't DISEC. */=0A=
+    if (table_offset < 0) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    table_offset +=3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER=
,=0A=
+                                      ADDR) / sizeof(uint32_t));=0A=
+    if (FIELD_EX32(s->regs[table_offset], DEVICE_ADDR_TABLE_LOC1, SIR_REJE=
CT)) {=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                                  IBI_QUEUE_STATUS,=0A=
+                                                  IBI_STATUS, 1);=0A=
+        s->ibi_data.ibi_nacked =3D true;=0A=
+        s->ibi_data.disec_addr =3D addr;=0A=
+        /* Tell the requester to disable interrupts. */=0A=
+        s->ibi_data.disec_byte =3D DISEC_INT;=0A=
+        s->ibi_data.send_direct_disec =3D true;=0A=
+        return -1;=0A=
+    }=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_handle(I3CBus *bus, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+=0A=
+    trace_dw_i3c_ibi_handle(s->cfg.id, addr, is_recv);=0A=
+    s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_stat=
us,=0A=
+                                              IBI_QUEUE_STATUS, IBI_ID,=0A=
+                                              (addr << 1) | is_recv);=0A=
+    /* Is this a hot join request? */=0A=
+    if (addr =3D=3D I3C_HJ_ADDR) {=0A=
+        return dw_i3c_handle_hj(s);=0A=
+    }=0A=
+    /* Is secondary controller requesting access? */=0A=
+    if (!is_recv) {=0A=
+        return dw_i3c_handle_ctlr_req(s, addr);=0A=
+    }=0A=
+    /* Is this a target IRQ? */=0A=
+    if (is_recv) {=0A=
+        return dw_i3c_handle_targ_irq(s, addr);=0A=
+    }=0A=
+=0A=
+    /* At this point the IBI should have been ACKed or NACKed. */=0A=
+    g_assert_not_reached();=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_recv(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+    if (fifo8_is_full(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    fifo8_push(&s->ibi_data.ibi_intermediate_queue, data);=0A=
+    trace_dw_i3c_ibi_recv(s->cfg.id, data);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_push(DWI3C *s)=0A=
+{=0A=
+    /* Stored value is in 32-bit chunks, convert it to byte chunks. */=0A=
+    uint8_t ibi_slice_size =3D dw_i3c_ibi_slice_size(s);=0A=
+    uint8_t num_slices =3D (fifo8_num_used(&s->ibi_data.ibi_intermediate_q=
ueue) /=0A=
+                         ibi_slice_size) +=0A=
+                         ((fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue) %=0A=
+                         ibi_slice_size) ? 1 : 0);=0A=
+    uint8_t ibi_status_count =3D num_slices;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val32;=0A=
+    } ibi_data =3D {=0A=
+        .val32 =3D 0=0A=
+    };=0A=
+=0A=
+    /* The report was suppressed, do nothing. */=0A=
+    if (s->ibi_data.ibi_nacked && !s->ibi_data.notify_ibi_nack) {=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* If we don't have any slices to push, just push the status. */=0A=
+    if (num_slices =3D=3D 0) {=0A=
+        s->ibi_data.ibi_queue_status =3D=0A=
+             FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=0A=
+                        LAST_STATUS, 1);=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        ibi_status_count =3D 1;=0A=
+    }=0A=
+=0A=
+    for (uint8_t i =3D 0; i < num_slices; i++) {=0A=
+        /* If this is the last slice, set LAST_STATUS. */=0A=
+        if (fifo8_num_used(&s->ibi_data.ibi_intermediate_queue) <=0A=
+            ibi_slice_size) {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN,=0A=
+                           fifo8_num_used(&s->ibi_data.ibi_intermediate_qu=
eue));=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           LAST_STATUS, 1);=0A=
+        } else {=0A=
+            s->ibi_data.ibi_queue_status =3D=0A=
+                FIELD_DP32(s->ibi_data.ibi_queue_status, IBI_QUEUE_STATUS,=
=0A=
+                           IBI_DATA_LEN, ibi_slice_size);=0A=
+        }=0A=
+=0A=
+        /* Push the IBI status header. */=0A=
+        fifo32_push(&s->ibi_queue, s->ibi_data.ibi_queue_status);=0A=
+        /* Move each IBI byte into a 32-bit word and push it into the queu=
e. */=0A=
+        for (uint8_t j =3D 0; j < ibi_slice_size; ++j) {=0A=
+            if (fifo8_is_empty(&s->ibi_data.ibi_intermediate_queue)) {=0A=
+                break;=0A=
+            }=0A=
+=0A=
+            ibi_data.b[j & 3] =3D fifo8_pop(&s->ibi_data.ibi_intermediate_=
queue);=0A=
+            /* We have 32-bits, push it to the IBI FIFO. */=0A=
+            if ((j & 0x03) =3D=3D 0x03) {=0A=
+                fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+                ibi_data.val32 =3D 0;=0A=
+            }=0A=
+        }=0A=
+        /* If the data isn't 32-bit aligned, push the leftover bytes. */=
=0A=
+        if (ibi_slice_size & 0x03) {=0A=
+            fifo32_push(&s->ibi_queue, ibi_data.val32);=0A=
+        }=0A=
+=0A=
+        /* Clear out the data length for the next iteration. */=0A=
+        s->ibi_data.ibi_queue_status =3D FIELD_DP32(s->ibi_data.ibi_queue_=
status,=0A=
+                                         IBI_QUEUE_STATUS, IBI_DATA_LEN, 0=
);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,=0A=
+                     ibi_status_count);=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    /* State update. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+}=0A=
+=0A=
+static int dw_i3c_ibi_finish(I3CBus *bus)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(bus->parent_obj.parent);=0A=
+    bool nack_and_disable_hj =3D ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL,=0A=
+                                                HOT_JOIN_ACK_NACK_CTRL);=
=0A=
+    if (nack_and_disable_hj || s->ibi_data.send_direct_disec) {=0A=
+        dw_i3c_send_disec(s);=0A=
+    }=0A=
+    dw_i3c_ibi_queue_push(s);=0A=
+=0A=
+    /* Clear out the intermediate values. */=0A=
+    s->ibi_data.ibi_queue_status =3D 0;=0A=
+    s->ibi_data.disec_addr =3D 0;=0A=
+    s->ibi_data.disec_byte =3D 0;=0A=
+    s->ibi_data.send_direct_disec =3D false;=0A=
+    s->ibi_data.notify_ibi_nack =3D false;=0A=
+    s->ibi_data.ibi_nacked =3D false;=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -569,6 +854,25 @@ static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
     return val;=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_ibi_queue_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->ibi_queue)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->ibi_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->ibi_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         IBI_STATUS_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->ibi_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->resp_queue)) {=0A=
@@ -606,6 +910,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+        value =3D dw_i3c_ibi_queue_r(s);=0A=
+        break;=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
@@ -1345,8 +1652,16 @@ static void dw_i3c_realize(DeviceState *dev, Error *=
*errp)=0A=
     fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
     fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
     fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);=0A=
+    /* Arbitrarily large enough to not be an issue. */=0A=
+    fifo8_create(&s->ibi_data.ibi_intermediate_queue,=0A=
+                 s->cfg.ibi_queue_capacity_bytes * 8);=0A=
 =0A=
     s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(s->bus);=0A=
+    bc->ibi_handle =3D dw_i3c_ibi_handle;=0A=
+    bc->ibi_recv =3D dw_i3c_ibi_recv;=0A=
+    bc->ibi_finish =3D dw_i3c_ibi_finish;=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
@@ -1355,6 +1670,8 @@ static const Property dw_i3c_properties[] =3D {=0A=
                       cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
                       cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.ibi_queue_capacity_bytes, 0x10),=0A=
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
                       cfg.num_addressable_devices, 8),=0A=
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 044ff06a01..a262fcce39 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -9,6 +9,8 @@ dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t da=
ta) "I3C Dev[%u] read=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
+dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

