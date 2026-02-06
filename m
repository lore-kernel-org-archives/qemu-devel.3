Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9180ECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOb-0001Q5-E7; Thu, 05 Feb 2026 22:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNx-0000SS-HM; Thu, 05 Feb 2026 22:19:58 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNu-0008F6-2w; Thu, 05 Feb 2026 22:19:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhTPhkAsw31TFJsxtkYyBscktWuIYeEQwtj2g5XZd1m0otwMrErysv3NrYAiwm9jYYq5J9sdwkzSGjb8SU4+9BrgoubMUO5Rrs+JcbrA/ccYm+xLNQ+sdI90tvL+RNq24Ks0ikjjxI4SBHcF0AOTBBzaX/aCGQowEtXW6ydgzxiSCSakeTzuP33NsPfNYL4QBH1Mmn2CcJj8MoHLiQY+HKmS4u6t1798SRC7lh8M1HBrmtyICbhUlxacSqmHF/lvREbo1sDQ5W6RPwcli6MJpRHBSi1BuolYecCOReloDWHqlogPmaPNqywntjUwESnDz+G+zGFCfWZQla58fSzZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko54ZD1wGT4K9hMUr1g5EB/X5U1Zy590R0Pu0m3KvQk=;
 b=q1E4Yhv5yYsPF6rbOS1tYVbEYIEJQ0F2YVJffvU6WKp6k8cnNqz1lhfeZY+F9DeVyzyooM9zcuUqJymPEuTQM/beR5Yp0tBHmCygXNmfxpM/joyI72p/EDObQqKw3kfuj7uC8UDi9XN1rRogrhWfCU/F/Vu+iVWbtJ6bIui2enMzacQ0HGutntGGnLkweK3fuevuIaVdIYY5Rgg1SIcaC50dOAKTY4eTxU30Im5Z9H8DGcSF20ltb52IRB6hm0Mb+MRyIRCPE6RNFj0FNr0SlY/7XmHC4KV4Io7og4pWHAXM3i8PkbzcKe/fwKV61jbY4dsJdufRD02H/a3PCt1bug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko54ZD1wGT4K9hMUr1g5EB/X5U1Zy590R0Pu0m3KvQk=;
 b=rcpucahS0Unug1481h5UHYVvgfxPM6H3AK17pWbsiFkZxPB/AD/YSQKWQmqgO+wPDgEBXTO+OCmHPdUe9T3p8I0gk9IpQZkd7iTCS/eC4BIaLA3ze7bWOcbWyukzSqlCcC4FK20wmaMvBt2Zp9G2ZnEEHrIiplYBp+/KaN7XuNIV+BY34VUYB2MrF3AuWmxhMgep6OJufb3B6jg+RecxbrsZmsEjQ08Rz/U/LvxIAeWzFyKkwhgmw7wekVeNLv8xtpWiOrGUUhpEsxDYfGhS/qzvSW9NIorOq9WRntQBa2a9E288rEhi/TlN0qCWWu/GqcC+PxHY6QLtHU89/JP18Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:36 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:36 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 06/20] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH v3 06/20] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHclxdrPfKiDH62hEaQsT4l5czx1g==
Date: Fri, 6 Feb 2026 03:19:36 +0000
Message-ID: <20260206031926.3227848-7-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 69a759fc-e158-4d82-cd8f-08de652e8e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?oj2owgpYayyqzNeGezzX0PQe0B5FsjGwF5KmMP6XMDKTXqma5Rdfx+PHHp?=
 =?iso-8859-1?Q?bISLka9ZndJCkflLOntrmXsPojhYOwc9xeH+xq9brdIvXVPCyezO2TQ/yH?=
 =?iso-8859-1?Q?N4UFH/67ScahkynRBZgj3kSkfoJEAS/TnjfMnG3roPF0JEsRzI60zgVpI2?=
 =?iso-8859-1?Q?dvTkMmsPOQxXCziM7TK0Pk+OSTXQrFGvqlhhj4vO5Ixshse65KqYSMwce3?=
 =?iso-8859-1?Q?vknLeNbNc+UHydnzGnl0I/Z1MOLecHzBbxZ5AXow21n17LdMu+Ybg+Jlxp?=
 =?iso-8859-1?Q?hxxJ5l92RimSwj5J6bx25SCwS5OL3ndZRl1hsl/LL0IGHdvFO0HkrW+nvr?=
 =?iso-8859-1?Q?uk9QTKVgSqW129nnc1RB0lawXjcqGjPhagx2XSkBhdYRV6mpZCipaYbWWq?=
 =?iso-8859-1?Q?DNdLp33SLuiOsIrCz7lO/KfZxX6FwCESYGPTtIJipMJs4ew+KujwnqkRdl?=
 =?iso-8859-1?Q?txIziNYbnod5BccazGX8qMAFeqrZZPCkR3IMQRM5KDe8J5ntIFvPHaPZgt?=
 =?iso-8859-1?Q?9pAS6ue1HH3TQXlcs3+NuHqn5SIOOpskPJI90DJi3YivUeIxoQQ2PNP5d7?=
 =?iso-8859-1?Q?r1vR7uq+o3Ter7GD4igDvUpPfAsJGHQP9rdiCCWzh/AXZbjAvVGTIZsDP7?=
 =?iso-8859-1?Q?wKKhBV51G+BADjT5ufa0nLbKGP3Of16VHmTOu+5Rl5dKogMKuVIWNZe67y?=
 =?iso-8859-1?Q?/BqycLbQV0HjNal75GXny4HliKV/MDbHsNk7pAYkt219yroo48aEawDJph?=
 =?iso-8859-1?Q?yoKmqM4ck2AdozoUs2KhQywVVnylWDdYHIfB3gaa0dm8xj9ocnGiSQsu3m?=
 =?iso-8859-1?Q?3mzBFXQZpQyjgV4ky+WVk3/YMpTDGpuEcoVNtOK2sJ5anRVamhhoxFRvbQ?=
 =?iso-8859-1?Q?C7N93eyDS6tzDRiQKM13mDeTOxMLReqSc8ndo7O1eS3t1UeXzVZ8OjDqk4?=
 =?iso-8859-1?Q?N+2Ly8MrNboTyj89kyECf60sO4YXsZ1WgZD3OuIwb5PgBwO/0f5VvzYsdn?=
 =?iso-8859-1?Q?dJ1p522TN2U7lycEAhnGciCW51mIfifZgDfxU0lumL0Lw7ckgupSfByfB/?=
 =?iso-8859-1?Q?7r9S+QkiWtk9wVbt+1YWotQf7WknTbMEkyy3RXIUcK/boHh12y1CaF0Mcu?=
 =?iso-8859-1?Q?gGJimNcINisNMjh27kwHAvwS3ZuVZ6rQpNCboAFA5TE/tUM1CVbJIBWPKr?=
 =?iso-8859-1?Q?qGvens2zdM8JVnlXZpYHs6KA6YMqW07LQk3UiDOFw4Ncv/JWALAkMDB3sT?=
 =?iso-8859-1?Q?76l1UiUHm5POA0X6HYR+UOFuHlfMH2ftAwr71+ME3E6TNO6VyJ+P2VSWlP?=
 =?iso-8859-1?Q?sgiuucLNFUKaeeslSpKUYJvhTn701Ct51LOf2qUd9VdOr4wZAD6IDJxam7?=
 =?iso-8859-1?Q?Aj748I56QWm0y93b38xsvf1qu+GmFz0+LzEMvdQonMKxrZS1+JODGli7Yb?=
 =?iso-8859-1?Q?78olYw9O/OwvpCmnldCTvH2+c/vHwJ1gpze7xFUdaY4qM5KetNcJu77Drd?=
 =?iso-8859-1?Q?8CY+nA6c5hMMgJxH1kTZSiBaO5rg1qbj20Z64rtDWjBEUBx7fmRhoqD/0v?=
 =?iso-8859-1?Q?dOSuZIsZ87j/DYz8DJSHTaRof85j/0yEflb+enrsPgiqMIFLCx7RGAd5R6?=
 =?iso-8859-1?Q?khB0cCmu95kPyf8OLJNLB1XzPzJK0B3PgVasA3xu7Wl6zKEp6btteJwkyx?=
 =?iso-8859-1?Q?XZaNgHX1BcYfiOQlMhAOr9VWPVHpBUfjB5eO+mMf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gwRIK1qOTp6Ss33j+hHybV8xiX5xQDqagqT7pucdQXm998rBdbd5e7omWW?=
 =?iso-8859-1?Q?9ctLPE9r5zLEQ+VaNz915w+ZF2nM7B2VMQaEZwsKHc4kprtW37YS2YXiSi?=
 =?iso-8859-1?Q?nBGw02qdhidclnunhxtdmC+5nI4N8DOFOz1R6J8WD4uFFn0lQfe0eWXlM2?=
 =?iso-8859-1?Q?XUXtokkEF/O/PO1q+67ZmJEj3FbEPPE3f+QDhLZHE8DOvE9j3yOClevgBD?=
 =?iso-8859-1?Q?GLUAy06HqJIJyBUbWzE3NxIaO1Js6avHpZPrOvbYNufjgUWcrNKYLt6LBt?=
 =?iso-8859-1?Q?Lah80pwcy1RlK3n9zGTLu1BttVDprzn8x9z11lRqVTH8FRadN/GJ4vhfsH?=
 =?iso-8859-1?Q?Hqqy2t7F4VGNHZkIQgzeUaQK8g0QHi17Ek0zdyGIZHlXmxCTTyq8KW15k/?=
 =?iso-8859-1?Q?nlmOG8q1C0l7bt1vO9hO3MrNXSmpBaeVxLMO1E3o3eG64wItiUxWLjovVm?=
 =?iso-8859-1?Q?imFvABpt14nDydtMbiRbzSLLWVaiDW/9uHUaEyK7EfvfmSZWgt4HOglxr6?=
 =?iso-8859-1?Q?vFVzbdByeXlCuqesVjpxwBolHPbxUIbWYxhaG42M7ak7CCnIaXSsAxFvGL?=
 =?iso-8859-1?Q?ZYI9LwRGgw8VYfoshFRrteKkPVxB/05TSIqbzygEUnPHI+WuTiyeeRUiM+?=
 =?iso-8859-1?Q?DrmkdMRHMhxuqKAhryOHMyZTs85IIt9p4hT7C0Qa3XZf7hxque2fk7/ieN?=
 =?iso-8859-1?Q?bS3qImudp6k4twqdiWRUba38peKtaYDMEHkDHkF+p+1btJ3UiWM4D0Kj1s?=
 =?iso-8859-1?Q?/i4nYV2iqv98OP5STbvvlwJUhrqsIDdIJ2o0xXP2VxwodeMN18BQYQAhTr?=
 =?iso-8859-1?Q?Tgv5WX1zy3wq3FT8pzx+nbMyU3Ca8DbhE6Rg6lWoY9MF/EaG9sXVsLBHu7?=
 =?iso-8859-1?Q?6+egX6uIuzqiZLVevZ7h/DbxK/5AESEdWlhb9k5nso51R+4aOqWnmoecS0?=
 =?iso-8859-1?Q?8XNQoEjIXKIQnyflukuF/zz+n6VitIHZScvucwEJXH3hvlyQduO4IizBBI?=
 =?iso-8859-1?Q?Qq/3nQIfXYiy5uMa/Oj1ukdpkgZOBKcTGvhIPYZbpqVVE02TkGx+ZGwA20?=
 =?iso-8859-1?Q?RwgY7JCOFeldxWeNAQ0BNbZ7q5zhe6dUKjjkpWfX36419pcsrYtQss42WC?=
 =?iso-8859-1?Q?L5p5XMJGaIadyyYyX3n6VyPBe7pgsA2Yce4saTQtWV1oUPe0fbfCpP4Uhy?=
 =?iso-8859-1?Q?+79gHkaeIvZGNp5ZokIL1IDq7gkGYQtVDw+6NZH4r/spGErKjm2oPLN489?=
 =?iso-8859-1?Q?i/wRhJeb/XYaW14fXYF2OcvOdnh6MCwq+bZiN/IrKkz6xiAuUxaMVtjdcw?=
 =?iso-8859-1?Q?4y0//RxpB4NuoCGEuvUe4chOQIFSXXfyRM8mdODEzuFTs6t/om/ql9YHUd?=
 =?iso-8859-1?Q?QymrR9mAfkyvsR9LspCT+r4rOS8rNzLcPxGQs8a/Eiieic9WxcZuH4yh2w?=
 =?iso-8859-1?Q?dOMRkdBQQGUBPxmFHwQYL/UuVxUqRkztv5utN/BmKKXG83awkmO9rATDXU?=
 =?iso-8859-1?Q?mKVTt/omdF2g2ZWW28PI+2RgYA30VRpnsRo2wQAsF8DjUk+lQsLv/givNx?=
 =?iso-8859-1?Q?/fks8gJt6eTPKdpzAg0YyC4UidJITQJaVqidxMT0540oEGJRzsASoxTeY1?=
 =?iso-8859-1?Q?UNJyxcGJYi7ufd8+65GEhQ4zEKLgiwc5eHJ4GyZq6W7T2EpH9CTCApTHZ3?=
 =?iso-8859-1?Q?PzPRsLv2/wQVZfK5LBvOeqMwQHVxe4mV8cmnMiUnh8abjU3dL2S4y6bI9z?=
 =?iso-8859-1?Q?J1N91vLmKkQ35sCQB/Go64U/eHGDIhQwAcoTcr4LJXI7HD8WkSY/4O0hqO?=
 =?iso-8859-1?Q?XHSETeDOLA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a759fc-e158-4d82-cd8f-08de652e8e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:36.3268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmOiMV3xg15RCwapYMdRcqhwN0zE2HyuYi1eFwuHw7TZwN7TlJ+2q7ppjwsLT/xH0bw2hubHqt1jU1lRyZNb0BBNTIMEvWyQUBjpH1Ux+rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Adds reset values for the new registers added.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-=0A=
 1 file changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 2f04c69320..7bb33c7a9e 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    /* Target mode is not supported, don't advertise it for now. */=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00b9,=0A=
     [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0x01010100,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0x0000000b,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0x00000002,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0x00000010,=0A=
+    [R_PRESENT_STATE]               =3D 0x00000003,=0A=
     [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
     [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
     [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
     [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0x00010000,=0A=
     [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
     [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0x0000003f,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0x000a0010,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0x000a000a,=0A=
+    [R_SCL_I2C_FM_TIMING]           =3D 0x00100010,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0x00100010,=0A=
+    [R_SCL_EXT_LCNT_TIMING]         =3D 0x20202020,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x00300000,=0A=
+    [R_BUS_FREE_TIMING]             =3D 0x00200020,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0x00000020,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0x00000239,=0A=
+    [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
-- =0A=
2.43.0=0A=

