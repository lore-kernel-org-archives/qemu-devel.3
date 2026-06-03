Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94555CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfEy-00005S-Te; Wed, 03 Jun 2026 02:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEw-000053-E3; Wed, 03 Jun 2026 02:38:10 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfEu-0008HM-65; Wed, 03 Jun 2026 02:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDDkqEvASqTefPd/05raKWURv7M98r+T+VR+q12yJ1Nr7W9TZbb7b24GCIKNzYO8vsaBPmEW3b1ewMj57Ync1SebsDTuSLsmC9zO0TR0MIPr5HFKWruWtWlfF1eeHFyTg6Ms3Rsh4cO2E9zi7eAfux24TyY1ntWqqTDeBalSML1+THuiHA+1aClt7BD46CkmW3Y6wEpreuLcUF3k6lmZ/yYh8QU4jRRx+VqH73TyFOze+0Ffg+CDCftIK5Ve1QmGhmR8nX7rCiKfSGhQK6fY1SINco0HPuWkR/6B/jYEaKnn3zQeXdwLWIoneUHrFhuVE5xQCD+Zx5clpkpqFXU5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sLEehqprXTcnbkzr86ShX7h35iG0L92kkaYL8ygnYc=;
 b=PDARCpUKZEzLFRbyEWclS6CwzEXWq6wR+yzGXR38BMz9QWl5UG6E9X9CzRwCxOlsnTxQecYzYjCYHtxe+oOGdAYrYGkzhx7OQ7cgeSq64jnfSh47jqJaTsUe1csI1r0A8PM7UCgz2mH7E0Gy+wGRQW8HQI238n4c8+tNdnj3QUn2oh3mgbJCL5azDSgMWtsdd26pddxkxQ3WzYY5vwHKQKWf9pcSIgW/GGK1ROjAOKSjUq027Ht13GjhxmIqvTuC6AevnSAT9N4SxOF/YgCkSnRnf9Bu9bUK+6hZOEM2adl/NE8rV0iPghsv1g2ANwrywyCMhux9U/HRyq8UrK1rUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sLEehqprXTcnbkzr86ShX7h35iG0L92kkaYL8ygnYc=;
 b=DnYnoNDdI4xlzGA/kW21+mOGXpOm9VNqShZ+X20OFPWv2l7eZoTV3QK72tGgXEsD5KI2vjSPZDcqHqNLnfMRvmtjVCnvmDPzYp4lG0sGNaLwwE4hu0Q3noDgy/IIoGJ5svH7dm1WA/9iootb/7RS2RVWkRt0eA5qBjTCF1e6Zne2uhMIJ4mQNyVVGEZLbj87WZjFy7yzs6c6aJTFvgiRiQh7hQ0vKD5/2gqEmxOPDfGq118LUgFbNPvLPqPJAObiMnWASnp1wjqaeWG7ZVi4M1WG7+pAB6Dw7n0LKhPj/TeZ7qTqRfcodQZSbyZkp38POkSyV91GS4zzBxBLew3oUg==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by SEYPR06MB5859.apcprd06.prod.outlook.com (2603:1096:101:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:37:58 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:37:58 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
Thread-Topic: [RESEND PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
Thread-Index: AQHc8yOEmK7Dv8IMYUO/twMijNXIgQ==
Date: Wed, 3 Jun 2026 06:37:57 +0000
Message-ID: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|SEYPR06MB5859:EE_
x-ms-office365-filtering-correlation-id: 06846c68-a807-48eb-584b-08dec13aa68e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|3023799007|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: S7YXWPof+gnPS0PgH/zeL1cJbK6BY48/x7hBQAOB4hB5JpHFvv9glbYS2U1Ws3Z1y7F9sOUyC8Go6nEGTeR/v5O2SO0RCUGIXtGXaAvqRailLca5ic8u9fATbZLvVVup2T27A0vE7Uo2mWa6eD4pJNn6+gkVW6XyhPgDVZ+I1fObPm3ynlTnI72/If5n6P7IAc8Qh3jStVA2dwMWM9Q74nnmcgmoHJCPmT8YTea/uRpfIf6wpakAv8fLg5sCbILhWR8jN0tSQSOuvYqIgdGjEzCtijP4hxI1sCJJ1ATplGEcBRPOHCNiPt2IXVagC5CYN8HcqdwK77A2zlq8FgYJE9oLbEFvzNk73ODVNh9YgFdG/vce8zSNsLQovrOkHNF/c8cUc/N8mUjWmrfe121cqXTklu3hwUW/ogdkROJoNwD5yWcYYiL2LLs0jOVnsqjVlcV/TK/H6Jwb116xgA1Q1tUvJjISgjcbc65ADxwrVXW11ML3dc/xw6ei/RUU3ihg1XVv+HMvFiQJtNsa3WZGrGqldfdqySQcC/LZWCfdxNxGPHlTQuVH2N5CBk8vycqKUP87od4Vm42mtRIssFaKu5ZdOc/WZk/ZVexRmZ2AsEq6LCAvZDLh+qlYwc8qe/dQ/P+VVaZ2s41FBM8AnNQkNkD4f3m42gAFzEEkthcUPfHP0RiMls5EsKb8TImVCNOl3pqXXmAMxAMIfCyVYk8BjMbz69XOS3uifNGuQ/XoeZzMOtKHXlHAQSjXYUU+AA9Q4XsslcVfcrsiCdLcixQGsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SbfnxZ3gpfI2UVCe5XqJsYabJsk+2zP7bw+8mQUm98IrrJ4VCcd80+b0cI?=
 =?iso-8859-1?Q?CaFnriaQhKG2mj6iJpJhaVYfXRywnYRMJL/ZiyZVh6ntaIBQVQYpQWQAql?=
 =?iso-8859-1?Q?E/PhMcGQLCfZDZfHcG0sgKUImiaKiS9zXeyRMGkZRpXFUsLbuEkmUckmU0?=
 =?iso-8859-1?Q?Up029SugVCto81NnYOLqClM2b/nWguxLfqDLeh4c1xVUDOrwsu5YPfNkJE?=
 =?iso-8859-1?Q?LDwr7+uDv8PBIN20XF0cAyvLPZUH+97COOtMztnEYUb5OWt+LyUre9PtOu?=
 =?iso-8859-1?Q?Wt6AyDrDi8ZkbJvREk4LSEv2VNnqTkBU51rXJCp/fDDtfjY0Zbm/+ZamgH?=
 =?iso-8859-1?Q?InW9pm/w6dtgTbFRVDp5WzMJw9EKPTODQzkKzzhfXWWlfD/3jFIkoEXv0Y?=
 =?iso-8859-1?Q?rtMBuFgpG4zUsEdDlzLcyks4Oa7LB0tQvYCxhLT+zk12XtuoESkLJTm25U?=
 =?iso-8859-1?Q?gdDT8CoPDQ2AJTraXqM/Qrm4/NNYv+R06mUWZfuOi3l+Vy/kqh/HgdbfHo?=
 =?iso-8859-1?Q?8fLjsbSEuY7naUdxXrmLNcCqmUEO5z0uXQAGKND764itxuoN5XJS7NuqTO?=
 =?iso-8859-1?Q?inCifBXm+41TtLBluSkm1ozul8QLLOUJmwEaU3tpuTLGYSzQIKtTkpj3eY?=
 =?iso-8859-1?Q?eDdgFNcGoeTOj+Y6R1kNHtPWCir6Hn5p4kD+0OcI9I7cVFnr1xxEhv3amv?=
 =?iso-8859-1?Q?Gs2Fdm4OqyoAYe81lqjRaKg4b5FV96n5tOGwoHGMV0ksBpxfop7dRNr/wK?=
 =?iso-8859-1?Q?JSclVNrX6FSMPuwPJ93+euxNkfC3RE4wzDVnmUR6bBHpN8PmW8iNJ6dq5E?=
 =?iso-8859-1?Q?u8tqChUryfonvVhJVRyDjiLZN1OqZpL75zID+92MucwdWO3WzD/wBWpJwM?=
 =?iso-8859-1?Q?mjX/FMBLNLEvjWS6Ee27M9HXfE5175TxXrJlSYHU1wbtLsu7MikpN8tMTE?=
 =?iso-8859-1?Q?tN1wJVylSkq6zemzq0LppZ6m2oWmyvQZwmoemVgPxvIxlQOuKmwgaVnNfY?=
 =?iso-8859-1?Q?v+dGBV2d44n5cAEDKyTWc//+cITdV1UAuOSlg5PrzRrtUUozynFYbRHhW5?=
 =?iso-8859-1?Q?EXSBxsqjIm2bV3SqUvwWFoqEGMdb2u+3u3NyBcagYP4pp1wVva0zsn8fVb?=
 =?iso-8859-1?Q?YKooGctjilQzZi4dyvflRK8NsHdukQUbDXc2qX0ltbphxN21wEmmrlvG/+?=
 =?iso-8859-1?Q?rLi2NtguHwsdjQX2tf6mPHzu4QURc8kat57ls/KpeTgiDBbbDj3QGjorEr?=
 =?iso-8859-1?Q?8rbA5RD3Kdops5Ru1pziNQSRmvu5xwocoUg2qfymrbdbZOT1KOe5fRQJ/y?=
 =?iso-8859-1?Q?9Hl4M8OSXYmDtr8FdugN6hAAizTTZsUXqKYkVRai5V9YZzvheEI4oh+7fO?=
 =?iso-8859-1?Q?mVMuQ4DTrGzyvYExZn84+dLtRvU6pwH24a/jthKEWv7l2qzaWqrVnyqh7Y?=
 =?iso-8859-1?Q?y9If5hVQJfdsziXMZgczwlqk70x4u3VySFEjiNs3t/sPsrUVBRR1VEcAV1?=
 =?iso-8859-1?Q?YqM7wqpDbXcRTyM94Tqsj5oba7g59NEN4REroMd9tPnjk1t8Vg42e9DSWA?=
 =?iso-8859-1?Q?ybCFdNdN3qBSjyrHm2LxSIzX75Ar8dhw3Zo02Fg6WWKu6RK6+RT6m7xCeo?=
 =?iso-8859-1?Q?FOBKYwvMLajny2PvcNdT4rOQ4wHpUBIBN74vIfPtoYDYFE8mBb8PBDtq2j?=
 =?iso-8859-1?Q?7cD1fcN1kA2YtzZEmNNtug8kcb9oLOsK1Bqx3mvBR6Co3gh2crUIqKheB6?=
 =?iso-8859-1?Q?J4/yaN81tdta7JHzwuUhW0FKZq4NYyPr6hpMh8Nj8lVyIer0L/yhV/g2K4?=
 =?iso-8859-1?Q?2G2QJCZfZQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MxGGhgWDZkVnCzyHImWgNG7vE7IjWDG6oxBooF1xxAAwzuqn0RF/qqf10rrBMWlzCmgruNFcVfUY0aV5ROcnIPmNPZ00n4TPgqR3wV3WzDyNMQxQyYPTBXR0kwoWinpe54wd31yk0RWnZSqu2KwCE/TAGesFIQBKrY2RNhllxDySLbnMOWZBpAacX2xe8aQrWd9e3laeceQ5e0wW23X40F74pYATZg+ra5O8nIzsj1lr83aKiUWhzmuTSCUZ4WyQg1YhwQgUmC4G45OWbkmWJiNgzqc0JOM+J4Xx7VIqMGd3BEMbCYPpirgNA2R9RUuUBWpwQTCvl/oJFJrN+FMGoA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06846c68-a807-48eb-584b-08dec13aa68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:37:57.9581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSPTKHdxNHFyCN6oAgfg78dkbQMfHhy7e7ShG3arCbSatlULCADTFFqaaUGn5mzUVW1PvFkmHNi/vbPulh2pDXdTpaAPCNhUEBiFiApl41A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5859
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=steven_lee@aspeedtech.com;
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

This series adds AST1040 Caliptra MCI mailbox support for the=0A=
ast1040-evb machine.=0A=
=0A=
AST1040 firmware accesses Caliptra through an MCI page aperture. This=0A=
series adds an AST1040 SCU model with the CPTRA page-select registers, a=0A=
mailbox frontend that exposes the Caliptra SRAM and CSR windows, and an=0A=
optional external chardev peer so a Caliptra simulator can service=0A=
EXECUTE requests.=0A=
=0A=
The SoC wiring maps the mailbox SRAM, CSR window and 4 KiB remap=0A=
aperture. The EVB machine also gets a cptra-peer option for linking the=0A=
external peer after the machine is initialized.=0A=
=0A=
The external peer backend is intended for co-simulation with an external=0A=
Caliptra model. The current bring-up backend used for manual testing is=0A=
caliptra-server:=0A=
=0A=
  https://github.com/stevenlee7189/caliptra-server/blob/main-2.x/README.md=
=0A=
=0A=
That README includes the server command line, the matching QEMU command=0A=
line, and the guest-side MFWV smoke test sequence used to validate the=0A=
MCI aperture, LOCK/CMD/DLEN/EXECUTE flow, and FirmwareVersion response.=0A=
The qtest added by this series does not depend on that repository; it=0A=
uses a socket-backed test peer to validate the QEMU-side protocol and=0A=
mailbox flow.=0A=
=0A=
Resending because some reviewers did not receive the previous email.=0A=
No changes since the prior posting.=0A=
=0A=
Patch layout:=0A=
- patches 1-2 add the AST1040 SCU model and mailbox frontend=0A=
- patch 3 adds the external chardev peer backend=0A=
- patch 4 wires the mailbox into the AST1040 SoC and EVB machine=0A=
- patches 5-6 add qtest coverage and documentation=0A=
=0A=
The qtest covers mailbox lock, execute and completion flow through a=0A=
socket-backed peer, and verifies that SCU CPTRA_PAGE_REG0 remaps the MCI=0A=
aperture between CSR and SRAM pages.=0A=
=0A=
Validation:=0A=
- scripts/checkpatch.pl --branch origin/master..HEAD=0A=
- qtest coverage for the AST1040 mailbox execute path with a=0A=
  socket-backed external peer=0A=
- manual co-simulation bring-up with caliptra-server through=0A=
  cptra-mbox-peer-extern=0A=
=0A=
Steven Lee (6):=0A=
  hw/misc/aspeed_scu: Add AST1040 SCU model=0A=
  hw/misc: Add ASPEED Caliptra mailbox frontend=0A=
  hw/misc: Add external Caliptra mailbox peer=0A=
  hw/arm/aspeed_ast1040: Wire Caliptra mailbox=0A=
  tests/qtest: Add ASPEED Caliptra mailbox test=0A=
  docs/system/arm: Document AST1040 Caliptra mailbox=0A=
=0A=
 MAINTAINERS                          |   1 +=0A=
 docs/system/arm/aspeed.rst           |  32 +++=0A=
 include/hw/arm/aspeed_soc.h          |  11 +=0A=
 include/hw/misc/aspeed_cptra_mbox.h  | 133 ++++++++++=0A=
 include/hw/misc/aspeed_scu.h         |  10 +=0A=
 hw/arm/aspeed_ast1040.c              |  60 ++++-=0A=
 hw/arm/aspeed_ast1040_evb.c          |  74 +++++-=0A=
 hw/misc/aspeed_cptra_mbox.c          | 380 +++++++++++++++++++++++++++=0A=
 hw/misc/aspeed_scu.c                 | 251 ++++++++++++++++++=0A=
 hw/misc/cptra_mbox_peer_extern.c     | 318 ++++++++++++++++++++++=0A=
 tests/qtest/aspeed_cptra_mbox-test.c | 223 ++++++++++++++++=0A=
 hw/misc/meson.build                  |   2 +=0A=
 hw/misc/trace-events                 |   6 +=0A=
 tests/qtest/meson.build              |   3 +-=0A=
 14 files changed, 1498 insertions(+), 6 deletions(-)=0A=
 create mode 100644 include/hw/misc/aspeed_cptra_mbox.h=0A=
 create mode 100644 hw/misc/aspeed_cptra_mbox.c=0A=
 create mode 100644 hw/misc/cptra_mbox_peer_extern.c=0A=
 create mode 100644 tests/qtest/aspeed_cptra_mbox-test.c=0A=
=0A=
-- =0A=
2.43.0=

