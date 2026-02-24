Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFF7EFB810
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLY-0002NQ-GI; Tue, 24 Feb 2026 01:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLQ-0002Ia-EC; Tue, 24 Feb 2026 01:56:33 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLO-0005Mp-SM; Tue, 24 Feb 2026 01:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boQcyFohwppZdNaaFpiLoPMFzOWWZGov0Ld0Y6JS9a9Nx1cuSchNmJpLTNsuCYDB+Pn4tX7zpQttTJ1cwJ81QH9XsRoKe421QMbTL2ic7/R9tNzj8MyIVBOfHPoENkyObkIXz3OMgzan/NG/giJYPOGEi4v4StpIqPkLC9gAlIfHxCLeD0xj2pVClVSYNfXoDmFYvtmqbqC/m6yRebQ1m+eqfqC6s4K11dD3p/wkAytPRMLjafq0uMOzHUpa5ih99Kf2KI6ojLHWGe7e26C9beO9z0v155yxEov8rU/JaeZYREkrhk7ciTDvU+JsKIGw00USD48AJf9eBhFeNJ7NYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=909/AA7w1pR0SLoBsBsXxVHBD2o8blPO+bKUpJbIc3A=;
 b=Q1Ec7A02GxzjjXHa5FJwaEp8ku1HoI4sfPUhVMl6QkFjJ8/jJaRCBB0dp4/EANdyZ7okqzll1ctbEe9+WiNgmelpCUXNYIxgG69sRFmXP+/EB+hbAraGpZ7GH/j6BK83AqANGK9OweH9VT/x9ev24GzkwhE97kz/ZFiPy5u/REI7/IwRqYzywvmknFe994ibdlT7L5AYeIDPJsy9dUV/NCgu6ssBjXmePC6R4LfTMNJx+7am4odzhvW+f4NRS70YR1qhVMiIozwKTKKAd8XFCNcPXYQnVD4I+P9h2hQfD1NPOQmJNi0wZ83rcLz/U031bel/ZNSX1HXbzJwgS7LitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=909/AA7w1pR0SLoBsBsXxVHBD2o8blPO+bKUpJbIc3A=;
 b=kn73IxFFcjH+PCJmTnvqPykXP3Kjdhu6YjIxIV2DseIUif1Ikak50Ht2Q7tzV2sy8zFLdtaKpOUcvjSw202CRa5xoPrZqMxikDxadqomhkRVAdN5NG1bgRCXx4mofDhXXFnKK8EMTIibxXfY1vx4+gH1dHoXM98KePrNGdiABwkIs988t1eoZeFm+kn6htyHlmkBtvh9icU19UW7sNrQ7OGo+Z97XE5g34CnIdUO6qMa4ZrMqmUQ6fGINWRg0zCvqPYkfzPsyqu2BYaZz8wX1+yLsEMR0GsCCjW/9SOIyJ7vg92+iGuG/Q4IBN+qb3vfCxYbq9QP+fLKqgxJBKalQg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 08/15] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Thread-Topic: [PATCH v3 08/15] hw/misc/aspeed_scu: Add SCU support for TSP
 SDRAM remap
Thread-Index: AQHcpVqnrvR2iiqbokyUTAmTblO+aw==
Date: Tue, 24 Feb 2026 06:56:08 +0000
Message-ID: <20260224065556.3847942-9-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 18a06473-e0dd-463c-dbbf-08de7371cac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GcUtlFzlytXVCkz45oB0MFEvT2WvmOEkEmtVkIX0/rbIaFo40ZjRyPrixI?=
 =?iso-8859-1?Q?ZSlxvoJ9uZCtHCGxGE6v4FStXEiSACWGgZxbEqimPrC2XiZ9d9VUR5OgSA?=
 =?iso-8859-1?Q?p1HuJWyQmali3TH39mfsP6TEoqGvZX/3IeSUTQVMBxUGI6L6rmOE7VKWs7?=
 =?iso-8859-1?Q?o1z3gEdVNTbEME5I/R1MZYkj/MJI66XlH0r1u+lFYf4ur/2vweAFrH9BrK?=
 =?iso-8859-1?Q?2OHROHY6GUnF2oe+2USmfU0hAvGIbd7nWwzM7IJpl54k4U90REHdp3ieC9?=
 =?iso-8859-1?Q?lymSXy1b9LOoDJK6rNHIIasqOEuIXStvnlXBVj3YnYFRZVApIi4V+5JHZx?=
 =?iso-8859-1?Q?jZuGqYrJzAJxoPpuHXDziOcMIizqtUdgW3SLTSY18fM3CYPuS3waaKJz4i?=
 =?iso-8859-1?Q?mFjnVA6QBTGG1W42RBE/KeGbCR6S6tohc0757gpjIenE/bpYl9SjbcSZ8D?=
 =?iso-8859-1?Q?X60PKp4eppyOW2DTLTaYBx8KyZGEJvsNAuhBgyOPWHSv6/nQvmNadk0XaA?=
 =?iso-8859-1?Q?qxWuNVgzxDrrRCv5BgpgH0E1i/rrcb5vmds9Ak/YF8V+sb6kn1OWU4yxDn?=
 =?iso-8859-1?Q?6p8U8JQJzsxpclchMJJxIUaHgViYjP/TJEtlymh5a+typ2mni6eXI71rof?=
 =?iso-8859-1?Q?0O0RldpnFtFjIqwKW0di3TV79fMo+bJ27D58LCmG6ZxIFay+7dbNLAKN0d?=
 =?iso-8859-1?Q?FtTdfJ6D9VgGCGW9z61v/wUQ21C2BKPRBkeARhSNhjzIcsAnZi8uJ0+HWR?=
 =?iso-8859-1?Q?uQqe4pkqBXfqvJIsoh/fNdeQL4r0jwMjQhSNoPjL1f6J12MZXanhBLorTZ?=
 =?iso-8859-1?Q?RK0WaKaTaZr7/X1H/ocBxGq9x5nSt5dUfZcgv5nhKzNEPu5mJcTA7I20N1?=
 =?iso-8859-1?Q?DbhYVMYA260qkHMW0PcKgLwMeXIFurPQI0zc37dUfWOPltibPb1j0GOnRk?=
 =?iso-8859-1?Q?HbSNMZPdeP/81Ze8mZ8CnnR/Dpjxj3uP9AjOb9EMOAyh+N/vgK/Fu1SxuD?=
 =?iso-8859-1?Q?YlOrpPaP1NEqk4VFhdHEUeFgEVnF+DNpuZPnOIYAcrYiTRGCGx21bE4GmZ?=
 =?iso-8859-1?Q?tk24tka+XbBG+t+5oKH4bRWhe2OmjS0vz931Yj2ip0xluJcdxztMXsaQ2t?=
 =?iso-8859-1?Q?m5dqTRyPyG6jpS/Lmuxm5c01eWmlCh6wmIJnCKVBYPNhOuSS67rg5MH28k?=
 =?iso-8859-1?Q?gIMBqlDSQENDCW+L5/3ELSeWILfZCA4Pg0zEF8fX8ktfV0Dgb0JGjDwf1x?=
 =?iso-8859-1?Q?0ttVS5JkybdYWRoh8gFJoj93NZBy06t0qPDWDHvVSVjiO2FvmGJzfmiDg8?=
 =?iso-8859-1?Q?pLt2IMaZZaMIrXGpEvPnr6XtqLxegnnZHEYiXIo+go55bkqg1ln55hKTgC?=
 =?iso-8859-1?Q?TFYK4eeeRRKfmfGlKDz15Fw3UUPDmdMK7NeUS1+smTANnBMuftSmbWYCOp?=
 =?iso-8859-1?Q?WQIE2NKIUBLWMNgnzvREQ8kLaOpKf7puX4FWzuaNXS1l+gVRuFKd173rvp?=
 =?iso-8859-1?Q?IUA0yQi8QsLIwwQm0UxEAF4YBl5266kHCeVNNDbMDiHqiYMlIurWJakuIV?=
 =?iso-8859-1?Q?+X9CKU3iOaF+O3vhUVnSpJef6HMpagTiuNTorN4ugNXGDXrBvyd+cO0IJh?=
 =?iso-8859-1?Q?l4PpAwb+wMhuJPhoDEvd9FoTdsNfNYhLQGocXidZgQV6YEe4hIgKkwiHly?=
 =?iso-8859-1?Q?0cxlflvsfrhKIBJG9xHCd6yfRX+W/R/MScc12WiE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yBRvYJvMNF5DRQGjdXnFKMzW3yoj3Z2mHHbFUpFyKfHSug43jiBDMBv3VS?=
 =?iso-8859-1?Q?dzWMQvvX1w02Cx0sc1Ioi5bBG4QG3K03ATfbRAfGJrvfwewUInoblV5VE+?=
 =?iso-8859-1?Q?CbuDQHWt1n/tIF65/gnYwCTearrHhWGgNZlsCrtv5gGkgOKQmQykYeo4+E?=
 =?iso-8859-1?Q?meJobwxiyxMfEX5MVOQNfMTiiSQSwpa1fu25vl7pSGjL1u/xCM2n+7dPEh?=
 =?iso-8859-1?Q?nUAs9NNAJBwaJhDc6TYT+qZndXE31Q57OV0c6VE/6fNx4vOoNHpuMO09t4?=
 =?iso-8859-1?Q?cFv/7lx8CKsIhp0oDKuNm3oj3p9d3M1qWr3NtWSDMhtAeDkB8NhZCvpoI4?=
 =?iso-8859-1?Q?lMWCAZs1Y5Xk56Np5F6jSoXul5fGxNDlD7PRNCfqvaY14AczI6PL0DsXsy?=
 =?iso-8859-1?Q?oZDDaf7A4okKP5g3LvxCLwfD9Pd+bYO824TWc45M/zZXiIhmKuMijTogum?=
 =?iso-8859-1?Q?OcfILQfyv4yDriTwZaJ22HpUIddD0eeZHenak3DcrBttuyWaCaB+21tc93?=
 =?iso-8859-1?Q?BDxN9k4PbVU/NigspXLvg6n/RtsvcQ9XBHrR8pcoO4hiJG+YeapNhgfhAh?=
 =?iso-8859-1?Q?bTAicDy946/gXsNoIhMnq6Ai5bmIrjMcGccJ7mjdubKmX+oTu9kVYygFXK?=
 =?iso-8859-1?Q?Hj0gzbVg8ZxSeGSiJBRLYLX+BFAdXasPVB9tqTMZo10PYD6qYggEvSbYmP?=
 =?iso-8859-1?Q?wbBSsG+MaKMJ4um7Y+6h3wgv3smF4q+VTer9whtjZLPSFLZLpexWAcxlya?=
 =?iso-8859-1?Q?2AqBJHz7YwvUUVITv9dLoYyCQqJ/sezWvnkKEetB+1q/N4k9n6AVpDqQxw?=
 =?iso-8859-1?Q?iVc62g5tP0YmmoMEVMSlDyPN/o2qz275WGr8KT360h52BH6EAIeQ8KnZ95?=
 =?iso-8859-1?Q?FLjj+9xw4h/gwj3jsuKRRySuwLLZ8hbPZ5HxH/nWIfmQ0Q8RfLwMvKm1Gm?=
 =?iso-8859-1?Q?0Q++hcWhCLaiIWakRGJOCbxun1+fFjY4Rr8gNVdlFEpC34fQ8Nhl3KiRfl?=
 =?iso-8859-1?Q?6ahwVpt/58kjb9BTdTpsXM2jdT7LRqMbtUKS4pXkCR/k2YwPdUy1yvcd5x?=
 =?iso-8859-1?Q?zh1M7dAoCY/4eM8uMhI3HcQuaBTFcSedc5q52mNKSygNjGICFZG/G6tC5P?=
 =?iso-8859-1?Q?YASK11T0Cid2jnldwNxcpqmi0zj5FFTo3sz2DeIkX7oO40tnH0/b6UB/be?=
 =?iso-8859-1?Q?IxNPWNccyEFTcvtlKLir+AbSkeoyBCLje0Qa1f1TXzZFogWYqKTkBEvkxi?=
 =?iso-8859-1?Q?wam64Lk2yTd5S72MYrwWq/xzvYSYXfG/wGvpHnV3utokxHngHwz1u3nBnX?=
 =?iso-8859-1?Q?SeKszlODgmeCDNpCMAtneOhFVK8Wwo93ebl91DMtZkZ4Kw1lfboTmnfef2?=
 =?iso-8859-1?Q?uNo1yRCBPIiWgx0JlkBpz0tOucAfXP+AAWXYOLsvLoWt7fyY022vIXwsSB?=
 =?iso-8859-1?Q?NCpPGTJNXtdUWOSiz67Rrr5R3iaWHUMToXnu4s2qf1rIt6FPT1HkMkxkiQ?=
 =?iso-8859-1?Q?fC9Xx0eSUGwfVZmQr0+Fg668Ty3Jt8ekaZnIrU0urFEm8h37teXHnBE0bu?=
 =?iso-8859-1?Q?YUMMOvRhVX2QkGK0KVlRIBJ6M0wpSR4JxiNuO6mHSgWD3vNLvUeokjzatl?=
 =?iso-8859-1?Q?xBfc345pHR7nRDVmRMaxISS7V6RpyPCzVW0lHdbJgQyZyX9SKlSwlLUloB?=
 =?iso-8859-1?Q?eD8cYUYCCqpXeLGUK9o73+bXPwZ3Z7WE3VK2zSSsSwidbLYkqoohbLvs9l?=
 =?iso-8859-1?Q?TQkaamTK20Jm1gH1/DVYg0BOuiDu3f3NnXdAXGVA2exDSfhvbDB0XdgcLu?=
 =?iso-8859-1?Q?b0A9y5uU+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a06473-e0dd-463c-dbbf-08de7371cac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:08.4885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8v9qTnInGmY586rhFkpr6lMIsJqmpV2AwnvEVGR0SF3o3sVzV3M3US2QS6oONmFgJ+OSNv8ytepmavRl0GmtmB7aB6x4uEiVl4IGnHF4l2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This commit adds SCU register support for TSP SDRAM remap control and runti=
me=0A=
activation. Unlike SSP, the TSP does not support configurable target addres=
s remapping=0A=
through SCU registers. It only supports setting the PSP DRAM base and size,=
 which=0A=
are then aliased into the TSP-visible SDRAM window.=0A=
=0A=
coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) t=
o TSP SDRAM=0A=
      offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_TSP_CTRL_1 and=0A=
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base=
 (alias offset)=0A=
and mapping size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        TSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000         =
       |=0A=
|   remap base                             |------>  |  - fixed target addr=
       |=0A=
|   size: 32MB    (SCU_194)                |         |                     =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 23 +++++++++++++++++++++++=0A=
 1 file changed, 23 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e806b95935..df435016ea 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -159,6 +159,8 @@=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)=0A=
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
@@ -1083,6 +1085,23 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         data &=3D 0x3fffffff;=0A=
         memory_region_set_size(mr, data);=0A=
         break;=0A=
+    case AST2700_SCU_TSP_CTRL_1:=0A=
+        mr =3D &s->dram_remap_alias[2];=0A=
+        if (s->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        break;=0A=
+    case AST2700_SCU_TSP_REMAP_SIZE_2:=0A=
+        mr =3D &s->dram_remap_alias[2];=0A=
+        if (s->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_size(mr, data);=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (s->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1160,6 +1179,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
     [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_1]        =3D 0x42E00000,=0A=
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
@@ -1200,6 +1221,8 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev=
)=0A=
 =0A=
     if (s->tsp_cpuid > 0) {=0A=
         arm_set_cpu_off(s->tsp_cpuid);=0A=
+        memory_region_set_alias_offset(&s->dram_remap_alias[2], 0x2e000000=
);=0A=
+        memory_region_set_size(&s->dram_remap_alias[2], 32 * MiB);=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

