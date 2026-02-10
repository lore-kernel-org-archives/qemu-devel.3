Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8A0EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlt-0001TE-3i; Tue, 10 Feb 2026 04:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlh-0001B8-8z; Tue, 10 Feb 2026 04:10:49 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjle-0004kR-A9; Tue, 10 Feb 2026 04:10:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIoeU9rm1QlVZU20FuF1WQYyLoAsJtDEE5N0M+qZeiCCnF1FRaXwlfwJSfrvScd52azgOIg0xwNRg8Fu8Qp9S4KaiYK59beuRCIEF1i9Wqzh/1+rUzuF39nXHzzrb4r5jyCaFLmSad5CHe+OXssOFQrlhJkCRiNfdBaFTSPK7XnnQ8FV4YelVHGXn2NPlujEFY65iJpyCdEhxoTI3LcHeX8QR2mJoy/s1xktAOv94XFGs4fuuwfuwzFNBjrcL8EX9TNJdzJqPWxmp9drL2Itw1BT89l0L8uHhHtw5hINsXQfk1d6D5DgJ8rAk05ItMOPhXEU4HoDo+bUWUMufgGslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoPzQTejXFTqYoC2Du+97jQIn228t1ReBuQeEWAjZR0=;
 b=JrU1+67iDg5x/9jvRBpCSqoD0kTXCKBs63BR02ROy8g87axAD+iZxcwKtd2tBsQq9kwyc/jgiDNNtt+F3UNEPGPDCcLZWDgF3VEuNq9RJwYFFhXR1junLP9s/xz6VRj7ulibCKWO/ZlVT5SYDAaQxVBgVWPGyQIoyWQ9LkatCaIobVmHGD0PR5/4Dt1eYvA2wuy+wq2Plv8fRaZ4nGEdQwLM/lDwzm9rULffVl6FJazbOg24PC9864rzT3FdbK3PXUlSLdv9BWKCq11h4biNAf39f9sby8P/NqP8mBSyz4r9Vzuzr+sXT3ta31/wI+U07Czjq/iKKha0vy9cFwD8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoPzQTejXFTqYoC2Du+97jQIn228t1ReBuQeEWAjZR0=;
 b=GehnXZ8y3BgCkyZP1L1/XWFQPsvdLCevgkzgr7ZO5YfJDHk9+QCT1kfpm1BGRW45XvDyXlWYKB0yplY+YHDSWQpD9Y2YJxR19l9HJhSLO5NkFYYBZWpQ2dz3GXg3cJkScWoW7PGpL2sbltvVxEENG6Hct1YlY6OjuGA5cj67+OQstgtYXa/waHarhzsAyCxulqRB/PrMi4n2IlHm762XCpbv7otngWPrFAERrU393dhROuMp1j7OPdCkPFlSfhlXnrxoPa1DriFBDh1yNpURbaHbPcfdcwBT87U1kEoGM+/bj4+nVqRMovYh5COJ6HWlXKtQ6iH+2R9pW/ZbvvmqnQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:25 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v5 04/21] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Topic: [PATCH v5 04/21] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Index: AQHcmm0XrZJrXW4x6UKBgjzAoO9OEQ==
Date: Tue, 10 Feb 2026 09:10:25 +0000
Message-ID: <20260210091018.1553489-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d4cb56db-a406-404a-d1a8-08de68843a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xPumY522OReKHvwZq4LrDY3971+G3VBJz/EM1KhpuNE1YzVijkCHUwRWB9?=
 =?iso-8859-1?Q?D95DqISHy1H45g8IyqVP+TSt+gmUfEV16U0RM5joeVUL4fT+OUPPVL5B7e?=
 =?iso-8859-1?Q?JGWD/Z5xW8l/ymgRqa7/+z9VAJezBEnyGJbKCVkt20h1SmbVX+4CemgIc6?=
 =?iso-8859-1?Q?GsQvXavnCvVqyfXoke/KPga5CQJfT82ZrrTICtEdmv16Gtg9JauinMOXQ9?=
 =?iso-8859-1?Q?0FHAQzmdcELseq+wuPVn+y6PwKcCF9aM4Xws3gBvPlKy7y0z44vdX3mG9y?=
 =?iso-8859-1?Q?2usT995xHWYM4aq4ihLqqbRlh4ctXDHRhmENk39Ptef7Ren1DhTO2esQm7?=
 =?iso-8859-1?Q?H/UrYTt5pm3ya3R4CtrqP8wqK54WUyUeAMdr3L4DdR1GGlElJvrOPjCLZs?=
 =?iso-8859-1?Q?/ik86GhJe++xWrXWvPxELkglHiRDeNHZgQThUS4cpSZwxPbNRLPKwQcL5J?=
 =?iso-8859-1?Q?ruplTiyMhT2nAjlR6h7RMXm3cJ5s4tzqYPPUInSk7CMU8FUtjwyiefeBKz?=
 =?iso-8859-1?Q?CCv50OPGyjFURx6KjsrxRBqyIj4rYEkid7wF3E+N1KPnWCIMzVdymeHeem?=
 =?iso-8859-1?Q?9h2mB+ODE6JYWc2vs4NatapWrPYAXrXpPvBIAaKdv/jIXPkhdL3AtbLxN9?=
 =?iso-8859-1?Q?llZoUrnIqmN6rhN6+hNSPEPZhPagRZ8SaSmVRAjr92wLAT/YrVG3bhW9HG?=
 =?iso-8859-1?Q?oIvnLL/8ZhQ472hP0dV/21NkwLhaizxDP6mnwMu7PXLBVvZ6mGmqnkZpTJ?=
 =?iso-8859-1?Q?QW0KyMB4rIDOtSHLIoO91rcv5N2RUKvVplyile6WEcn39VmAl/V3mvuK/H?=
 =?iso-8859-1?Q?yXnG7TR+FsYOQQ3xRcPfxtE3Gnopia/UHyOrCx8FyUZ7Dvz5NiQM8bIczR?=
 =?iso-8859-1?Q?PVOeelcT2JBncBHyrtISGmaJWsCLdivJ68S98hFawUV1N+zThIfzrPWnel?=
 =?iso-8859-1?Q?GdINdPDco4PAAdYGhDlgYi6eXZJTbaQA7tt06NV1A0MiD0TWQ/g92HCl/x?=
 =?iso-8859-1?Q?NeDy62bnu1LemKUyGe/XoPLHyGsTogQxG3ONmppP9cY2XvhqzIyAZ/W4r5?=
 =?iso-8859-1?Q?Z5YrkhOQwuAy9Uik6rl1+wsBbkibnhcNHsJlzbQImcf51kYMl+q0X56ibh?=
 =?iso-8859-1?Q?6rhGoDHftzkOhS9kdywKwvht0Gk1R/eawW4SK9h44pEzCenmgOBu+1EK4r?=
 =?iso-8859-1?Q?sBU6+Mu34zrVEofI14KW9ToaENHmJm1c9nBAph3X9XK++uuVlbPjBSJ0T4?=
 =?iso-8859-1?Q?0TxFZjYFp+yWfVp8ao4muRVmwcUqQf02ccSgf8CjSAYWfzePFec0J/z2hS?=
 =?iso-8859-1?Q?K5SxLfGBJKtqVOBOAu5l430lvVatzFDlMr3ursdyBSZFvzXiAAzP7wErRH?=
 =?iso-8859-1?Q?WraPUeU0lADPzYfvHvMQjGWovTyXgmZ/OceNoyI2G384jjPjjRxLxdBVN+?=
 =?iso-8859-1?Q?E67/ct5VUgPcTY5U08n2KFk8KBZpm4a9aRgml4dSk4Yj14ajb0DSXpgWQb?=
 =?iso-8859-1?Q?ETjipacERn9yjkP/68KVZjxHU0oHkk78t15a+3Dp/QnEDD25x+xKeLGHOt?=
 =?iso-8859-1?Q?W5wFL7jVa1aSFBJEw429Rkb9MGy2JHF5ERKwEmH/jYECE0Gh75BhyKJ0L9?=
 =?iso-8859-1?Q?XiO8L5WaaDcL/jktbJ+NgqbfDTiuTp3zcSuZZDJDFvdEJXYQ3PS9xxxbJe?=
 =?iso-8859-1?Q?MGb0vncneFicQzCU/BI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oLukuEtxkokd7vp/6QnfQOf03lyH4htoKXafAwUTfdR6uPNb8oq1b5gjTx?=
 =?iso-8859-1?Q?t44fa0PuaDZAmrrHOD8/JLiUwrtdZGmY9OfnnSUyLYS+cS0M2AbsHoh6e/?=
 =?iso-8859-1?Q?4ah+3MFczUt3KSYM67qwQ1s1ea4A4MhQ9G10BLBE5HyQR0sQDhuaciPpmL?=
 =?iso-8859-1?Q?71Q5uhZWwboPQSbvKJMODhqHKoxHYdEM7ecDv6C99y305huk7Z2jls21Jc?=
 =?iso-8859-1?Q?v/aPeaS1//P4If/rud9PWRTKN5EtzqFcBV54fBPQU1JHA/HxlJod8kOPI2?=
 =?iso-8859-1?Q?9KWNwnHAm8FK/DHIJgyMWeWjVWQpDrPOTu398Oi3++X/w40KFJHshK3OXB?=
 =?iso-8859-1?Q?7fE6hqAqJLJNg9OfPNpSCCdwFPYwYMMC+7HPF8gKQPQc75+uwIRsIxxjyh?=
 =?iso-8859-1?Q?+HFkGS3QRYLJjD4oehktIIQvkXCpaL5B2xmegUInA82Ix4Kj483lCJSE1s?=
 =?iso-8859-1?Q?heKY2zksKaZbsKRLxPMHCW8MaqPCM5sQ+J3cokx5BcK12FqXgu786nsJOn?=
 =?iso-8859-1?Q?GnjQFUFSGZGqp9TQG7rjl1dXeh1xKHeYd6YkQP+8upvdBFgwCpEW+cwwNs?=
 =?iso-8859-1?Q?/no9SAPMKNkhU6at6irDmXGjlOGPSVcAl2+jl4lipQN3aGBT58pdtZonB4?=
 =?iso-8859-1?Q?rrMbF49y4xUVWlSbRrJhWhOvjp8fwongIJ6hilvvXNp36sxxdoa4qICQl6?=
 =?iso-8859-1?Q?uMUuq9/IRLkZl2WAK7Fp6ocLmUfx0phLRXpnbVqGPKOLxGQrCXfq2bFII8?=
 =?iso-8859-1?Q?UIMndr1C+vV9vC8Z7NzSWWL5xw9OlHsamprsZWAx8b8zfoervURm9FVu7J?=
 =?iso-8859-1?Q?6n87h4bRaxy3eDM8esa0CPAHgACIMkFmNSP/8p/OwkNAPv1w6bKG55P71F?=
 =?iso-8859-1?Q?piRygpEiWvZDztaLCUsn7fOmKfkh7wD71Myw1KQ4G1m0S0SxQPxo3XuDNQ?=
 =?iso-8859-1?Q?V0LAo9zZvHyBeY+rW/AtqKLqj+djQtOyieUani8gbjv/42Qm0lw8vjkX1f?=
 =?iso-8859-1?Q?4wlf//djdacGFOO87ecrZGi/2aLibSdDlqYw+yl4++OPcpVix2CKob7PHN?=
 =?iso-8859-1?Q?+9zebEq1rSVVXC4pmlqKIaFsggj9vbgL7kuP6WI/emHmy+yurHxo/SpZ4z?=
 =?iso-8859-1?Q?KJejKi9G0neqQWY076rOZP9VRKteU2k2N2WXyhn+nWBzy73BEzkNiK6xNG?=
 =?iso-8859-1?Q?OWciCH37kwfw7gp1xMAqn71h55ElsbDF4vfC07s28IfDdBWb9kQdA1A45O?=
 =?iso-8859-1?Q?1Lc3qDoCQlQDxSuRFLRJrSfEuIDfNw30fwYPFo+6QoQdr5OcYoTmfbdi/Q?=
 =?iso-8859-1?Q?IepdlQ0E/8i3y34IsyvdxmvlzmadvFNylkujvkBoit3Y731pMsDMiWXeXH?=
 =?iso-8859-1?Q?S4KHRQuoqMbUw0l7dSEukrdXQp9Dpu1CJSR+cXoG5GIAxFiQUQ7wAPsazX?=
 =?iso-8859-1?Q?k0VASA+1eIl0oQjUMw8679BNYUHaY2k+bjHI7OXAXL9yMmIKCPRH76RmiM?=
 =?iso-8859-1?Q?Wk2AyvIANmiHSg95873SzYMJDsTonTL2Qd4ZanyTavvpoum/jrT1UTV8W7?=
 =?iso-8859-1?Q?GG/doro2MMZFXvQuset2EnIGHhVpkOMQNG9BUROS54NnTCm3m1SWjQxT0S?=
 =?iso-8859-1?Q?12IE0hvJBMKmQzPQha1tpwA01V2/5g1kw5RaLALEfwNiaHVu1YT4M+rQBV?=
 =?iso-8859-1?Q?fWFJ0lGIlWcPzaCjF60LEd3lkZFGen9wzDquP+tnSKDM/OJ/9BZR0r2m3o?=
 =?iso-8859-1?Q?hL8qbJn5516o1K5NCzOmmhHqTcC6P4Dw9znTKwKyjzPO/4ajD+jPWoIt2J?=
 =?iso-8859-1?Q?iX7X9tCvPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cb56db-a406-404a-d1a8-08de68843a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:25.7435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THcIAyNfAqNCdeFj3+/RRWBIrq/h6we3ew8tPpVbwgXOHQu30rr0mv8jgPSVRqlMCFp32Rqi/yTgYe94kNtaFEujllIQ5z+OnIWzdYn8cis=
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages=0A=
6 DW I3C controllers.=0A=
=0A=
To help reflect this better and to make it easier for other SoCs to use=0A=
the DW I3C model, we'll split out the DW portion from the Aspeed=0A=
portion.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |  17 +--=0A=
 include/hw/i3c/dw-i3c.h     |  33 ++++++=0A=
 hw/i3c/aspeed_i3c.c         | 181 +-------------------------------=0A=
 hw/i3c/dw-i3c.c             | 202 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/i3c/Kconfig              |   3 +=0A=
 hw/i3c/meson.build          |   1 +=0A=
 hw/i3c/trace-events         |   6 +-=0A=
 8 files changed, 250 insertions(+), 194 deletions(-)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index bd0ffc84ea..ade5c42d39 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -10,27 +10,15 @@=0A=
 #ifndef ASPEED_I3C_H=0A=
 #define ASPEED_I3C_H=0A=
 =0A=
+#include "hw/i3c/dw-i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_ASPEED_I3C "aspeed.i3c"=0A=
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"=0A=
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)=0A=
 =0A=
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)=0A=
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-struct AspeedI3CDevice {=0A=
-    SysBusDevice parent_obj;=0A=
-=0A=
-    MemoryRegion mr;=0A=
-    qemu_irq irq;=0A=
-=0A=
-    uint8_t id;=0A=
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-};=0A=
-=0A=
 struct AspeedI3CState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -39,6 +27,7 @@ struct AspeedI3CState {=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
+    uint8_t id;=0A=
 };=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
new file mode 100644=0A=
index 0000000000..7143e8ca7a=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -0,0 +1,33 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef DW_I3C_H=0A=
+#define DW_I3C_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_DW_I3C "dw.i3c"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
+=0A=
+#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+=0A=
+struct DWI3C {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion mr;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint8_t id;=0A=
+    uint32_t regs[DW_I3C_NR_REGS];=0A=
+};=0A=
+=0A=
+/* Extern for other controllers that use DesignWare I3C. */=0A=
+extern const VMStateDescription vmstate_dw_i3c;=0A=
+=0A=
+#endif /* DW_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index e7cdfbfdbd..647074d181 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
     FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
 =0A=
-/* I3C Device Registers */=0A=
-REG32(DEVICE_CTRL,                  0x00)=0A=
-REG32(DEVICE_ADDR,                  0x04)=0A=
-REG32(HW_CAPABILITY,                0x08)=0A=
-REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
-REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
-REG32(RX_TX_DATA_PORT,              0x14)=0A=
-REG32(IBI_QUEUE_STATUS,             0x18)=0A=
-REG32(IBI_QUEUE_DATA,               0x18)=0A=
-REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
-REG32(IBI_QUEUE_CTRL,               0x24)=0A=
-REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
-REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
-REG32(RESET_CTRL,                   0x34)=0A=
-REG32(SLV_EVENT_CTRL,               0x38)=0A=
-REG32(INTR_STATUS,                  0x3c)=0A=
-REG32(INTR_STATUS_EN,               0x40)=0A=
-REG32(INTR_SIGNAL_EN,               0x44)=0A=
-REG32(INTR_FORCE,                   0x48)=0A=
-REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
-REG32(PRESENT_STATE,                0x54)=0A=
-REG32(CCC_DEVICE_STATUS,            0x58)=0A=
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
-REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
-REG32(SLV_PID_VALUE,                0x74)=0A=
-REG32(SLV_CHAR_CTRL,                0x78)=0A=
-REG32(SLV_MAX_LEN,                  0x7c)=0A=
-REG32(MAX_READ_TURNAROUND,          0x80)=0A=
-REG32(MAX_DATA_SPEED,               0x84)=0A=
-REG32(SLV_DEBUG_STATUS,             0x88)=0A=
-REG32(SLV_INTR_REQ,                 0x8c)=0A=
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
-REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
-REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
-REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
-REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
-REG32(BUS_FREE_TIMING,              0xd4)=0A=
-REG32(BUS_IDLE_TIMING,              0xd8)=0A=
-REG32(I3C_VER_ID,                   0xe0)=0A=
-REG32(I3C_VER_TYPE,                 0xe4)=0A=
-REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
-REG32(SLAVE_CONFIG,                 0xec)=0A=
-=0A=
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS]=
 =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
-    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
-    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
-    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
-    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
-    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
-    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
-};=0A=
-=0A=
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,=0A=
-                                       unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-    uint64_t value;=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_COMMAND_QUEUE_PORT:=0A=
-        value =3D 0;=0A=
-        break;=0A=
-    default:=0A=
-        value =3D s->regs[addr];=0A=
-        break;=0A=
-    }=0A=
-=0A=
-    trace_aspeed_i3c_device_read(s->id, offset, value);=0A=
-=0A=
-    return value;=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,=0A=
-                                    uint64_t value, unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-=0A=
-    trace_aspeed_i3c_device_write(s->id, offset, value);=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_HW_CAPABILITY:=0A=
-    case R_RESPONSE_QUEUE_PORT:=0A=
-    case R_IBI_QUEUE_DATA:=0A=
-    case R_QUEUE_STATUS_LEVEL:=0A=
-    case R_PRESENT_STATE:=0A=
-    case R_CCC_DEVICE_STATUS:=0A=
-    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
-    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
-    case R_SLV_CHAR_CTRL:=0A=
-    case R_SLV_MAX_LEN:=0A=
-    case R_MAX_READ_TURNAROUND:=0A=
-    case R_I3C_VER_ID:=0A=
-    case R_I3C_VER_TYPE:=0A=
-    case R_EXTENDED_CAPABILITY:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
-                      "] =3D 0x%08" PRIx64 "\n",=0A=
-                      __func__, offset, value);=0A=
-        break;=0A=
-    case R_RX_TX_DATA_PORT:=0A=
-        break;=0A=
-    case R_RESET_CTRL:=0A=
-        break;=0A=
-    default:=0A=
-        s->regs[addr] =3D value;=0A=
-        break;=0A=
-    }=0A=
-}=0A=
-=0A=
-static const VMStateDescription aspeed_i3c_device_vmstate =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
-    .fields =3D (const VMStateField[]){=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_R=
EGS),=0A=
-        VMSTATE_END_OF_LIST(),=0A=
-    }=0A=
-};=0A=
-=0A=
-static const MemoryRegionOps aspeed_i3c_device_ops =3D {=0A=
-    .read =3D aspeed_i3c_device_read,=0A=
-    .write =3D aspeed_i3c_device_write,=0A=
-    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_reset(DeviceState *dev)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-=0A=
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d"=
,=0A=
-                                            s->id);=0A=
-=0A=
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
-=0A=
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,=0A=
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);=0A=
-}=0A=
-=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)=0A=
 =0A=
     for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; ++i) {=0A=
         object_initialize_child(obj, "device[*]", &s->devices[i],=0A=
-                TYPE_ASPEED_I3C_DEVICE);=0A=
+                TYPE_DW_I3C);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -323,20 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error=
 **errp)=0A=
 =0A=
 }=0A=
 =0A=
-static const Property aspeed_i3c_device_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *d=
ata)=0A=
-{=0A=
-    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
-=0A=
-    dc->desc =3D "Aspeed I3C Device";=0A=
-    dc->realize =3D aspeed_i3c_device_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);=0A=
-    device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
-}=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -344,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c =3D =
{=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),=0A=
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICE=
S, 1,=0A=
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),=
=0A=
+                             vmstate_dw_i3c, DWI3C),=0A=
         VMSTATE_END_OF_LIST(),=0A=
     }=0A=
 };=0A=
@@ -367,12 +198,6 @@ static const TypeInfo aspeed_i3c_types[] =3D {=0A=
         .instance_size =3D sizeof(AspeedI3CState),=0A=
         .class_init =3D aspeed_i3c_class_init,=0A=
     },=0A=
-    {=0A=
-        .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-        .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-        .class_init =3D aspeed_i3c_device_class_init,=0A=
-    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_i3c_types)=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
new file mode 100644=0A=
index 0000000000..6cadc59191=0A=
--- /dev/null=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -0,0 +1,202 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/dw-i3c.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(DEVICE_CTRL,                  0x00)=0A=
+REG32(DEVICE_ADDR,                  0x04)=0A=
+REG32(HW_CAPABILITY,                0x08)=0A=
+REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+REG32(RX_TX_DATA_PORT,              0x14)=0A=
+REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+REG32(IBI_QUEUE_DATA,               0x18)=0A=
+REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
+REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
+REG32(RESET_CTRL,                   0x34)=0A=
+REG32(SLV_EVENT_CTRL,               0x38)=0A=
+REG32(INTR_STATUS,                  0x3c)=0A=
+REG32(INTR_STATUS_EN,               0x40)=0A=
+REG32(INTR_SIGNAL_EN,               0x44)=0A=
+REG32(INTR_FORCE,                   0x48)=0A=
+REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+REG32(PRESENT_STATE,                0x54)=0A=
+REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
+REG32(SLV_PID_VALUE,                0x74)=0A=
+REG32(SLV_CHAR_CTRL,                0x78)=0A=
+REG32(SLV_MAX_LEN,                  0x7c)=0A=
+REG32(MAX_READ_TURNAROUND,          0x80)=0A=
+REG32(MAX_DATA_SPEED,               0x84)=0A=
+REG32(SLV_DEBUG_STATUS,             0x88)=0A=
+REG32(SLV_INTR_REQ,                 0x8c)=0A=
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
+REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
+REG32(BUS_FREE_TIMING,              0xd4)=0A=
+REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+REG32(I3C_VER_ID,                   0xe0)=0A=
+REG32(I3C_VER_TYPE,                 0xe4)=0A=
+REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
+REG32(SLAVE_CONFIG,                 0xec)=0A=
+=0A=
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
+    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+};=0A=
+=0A=
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+    uint64_t value;=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        value =3D 0;=0A=
+        break;=0A=
+    default:=0A=
+        value =3D s->regs[addr];=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_read(s->id, offset, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
+                         unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+=0A=
+    trace_dw_i3c_write(s->id, offset, value);=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_HW_CAPABILITY:=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+    case R_QUEUE_STATUS_LEVEL:=0A=
+    case R_PRESENT_STATE:=0A=
+    case R_CCC_DEVICE_STATUS:=0A=
+    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
+    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
+    case R_SLV_CHAR_CTRL:=0A=
+    case R_SLV_MAX_LEN:=0A=
+    case R_MAX_READ_TURNAROUND:=0A=
+    case R_I3C_VER_ID:=0A=
+    case R_I3C_VER_TYPE:=0A=
+    case R_EXTENDED_CAPABILITY:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
+                      "] =3D 0x%08" PRIx64 "\n",=0A=
+                      __func__, offset, value);=0A=
+        break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        break;=0A=
+    case R_RESET_CTRL:=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[addr] =3D value;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+const VMStateDescription vmstate_dw_i3c =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]){=0A=
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),=0A=
+        VMSTATE_END_OF_LIST(),=0A=
+    }=0A=
+};=0A=
+=0A=
+static const MemoryRegionOps dw_i3c_ops =3D {=0A=
+    .read =3D dw_i3c_read,=0A=
+    .write =3D dw_i3c_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
+static void dw_i3c_reset_enter(Object *obj, ResetType type)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(obj);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+=0A=
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
+                          DW_I3C_NR_REGS << 2);=0A=
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+}=0A=
+=0A=
+static const Property dw_i3c_properties[] =3D {=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+};=0A=
+=0A=
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    rc->phases.enter =3D dw_i3c_reset_enter;=0A=
+=0A=
+    dc->desc =3D "DesignWare I3C Controller";=0A=
+    dc->realize =3D dw_i3c_realize;=0A=
+    dc->vmsd =3D &vmstate_dw_i3c;=0A=
+    device_class_set_props(dc, dw_i3c_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo dw_i3c_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_DW_I3C,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(DWI3C),=0A=
+        .class_init =3D dw_i3c_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(dw_i3c_types)=0A=
+=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 8344b9769f..d545ecd712 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -546,6 +546,7 @@ config ASPEED_SOC=0A=
     select FTGMAC100=0A=
     select I2C=0A=
     select I3C=0A=
+    select DW_I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index e07fe445c6..ecec77d6fc 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -1,2 +1,5 @@=0A=
 config I3C=0A=
     bool=0A=
+=0A=
+config DW_I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index fb127613fe..83d75e7d5c 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,4 +1,5 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index cdf7cb07f6..2d944387db 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -3,8 +3,10 @@=0A=
 # aspeed_i3c.c=0A=
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# dw-i3c,c=0A=
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=

