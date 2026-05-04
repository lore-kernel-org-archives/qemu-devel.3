Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A952CD3424
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRb-0001Xw-8r; Sun, 03 May 2026 22:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRT-0001WD-U6; Sun, 03 May 2026 22:53:55 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRR-000403-RH; Sun, 03 May 2026 22:53:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTxb9NWgndVGtE+b3jJ7bL9sgJulxjh4cyu7Bw1zWimCBVVp+aZLm7vz/OF7atbhM3bdQ4lPE520LNmVHuYnOMGyb12+lX4X28/I2wSPIPDNc2SoJ4VhKeKVgJKsJmiXC3I/JtOLM5sre7SvXJpvyezU0oz7NlTeeeUsqqlEYdyojQu9BEcDz6hmLuzTbNRLwPKW5Nfsru87zUN+ypTu9/AkLDN1c9A7MUo+cijwsL/3Oq3fNB/T+G8EtGXm3veyyd1ReFptVtCtOuYyajOCLtQx3Qj4po00JhwmNJseCQ1/kdwkbPEZ/Gz1G9elWZcBgdA0V/z82wfNwId+50DM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WSgMOQpGNOHC2DBPlWhfJj0J3VxElXrHXPibtMafH8=;
 b=HxYfzUeKDVwNQlot8IgMNYnT/Ow/Lo+48fpyXhc+2JfEF/O886vNBUd9A6AE60GmDm+1N7G61bO8k5GKVWILYoDuHbJxbKqN3BpbI7H8SFcVojzvOQa1jCbcVUZo9kbmEsw1P2RIOj33rwib8vUxBuihtXMgb2Ng7SgLp46gb5OsTV3aFlL2ZmWv8peRC/a7UJZX26xZ2gFdmpGsQtdpNiJU86+3eJxlgszK0f+qGmJE0r5Kz1QzAdPde0HvPFCyKnqM7D7krp6BrGw2H/NB+mG+F4J335RyihJpWHaEF76yAge+ASFS01or3RWdhotlQoFBP2K7EkdydIdto3o4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WSgMOQpGNOHC2DBPlWhfJj0J3VxElXrHXPibtMafH8=;
 b=O8KBV53pR0k3CzubmYWwCnveh8ECIg0zhfbLVMqD0ERSTwSQwZZn33lSrTDvg178Wd5bEpY+Pbk2vwcCp8h+sQDb3Mycz/5wwUz4UkNf/H/rOjrKjuCOieGICwrX2Veu6uoUQl0cZ7R/ExIh93ASppJZqkpD94FnHz3NkfXRIVDss7BQekm3c1Xx8DamOOlEiUsRwQPXNXRO2qXr04eKCIg6rhhzhfjV0LYNj7oLHt7HyCNmJ2h77K2WWerFA1z3I6uHLTV43MOK0octz/B+Oktpwzlsm1OfihcIvmwdYGhA5QHK1bLiUV6vIef/CIDbqN2oiAQQb17GZjxIihbu3w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8442.apcprd06.prod.outlook.com (2603:1096:604:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v6 04/11] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v6 04/11] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHc23E6EmTdcjXkvkO41MSGG3nK9w==
Date: Mon, 4 May 2026 02:53:47 +0000
Message-ID: <20260504025342.1452605-5-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8442:EE_
x-ms-office365-filtering-correlation-id: 8cfafa79-5921-4cce-40b5-08dea9885d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: e0rb+msLajPqv5UJu4U4YONqGH2uxe7clAiEF+aGVuqxDjJaEnlJ/5kHhyCL2M/RE3N0zxfZJVtGC8INTMCRljUCp5jWs+cf2Y0wHFcmxBDguowWOCxh1dE319m0U/4A+haKDw8UFyZRPWSIHgPXjuosKH9ynLb54+pa/1uqu8dlvco75EeJC8IRcMFNkryYiJEJWjQit50Cv49oXJ72vqwK2q89DKnDA06HLyVF24SWRpqymnpVmlN88Qk21kHqCnaK6Vt+Uvky6YAr2CpLOx4EAdFxxLpWReu3wuHfsFj3wRdOMISpu9oW07lq7OdKpnPEdZ7PZZzNUIgT+7TZVVKwVK2KS0abLrC8NoSQt60qSOhkrGPXqFjm/0bzzjshlSkAL4LUqnkN39vDdMspuAS2oxwI7SxGbx5OxsC9vAvSv9L38kzAK/jA3k8XkTgBSPJMqzeVTBxocs50pv0P/fsilhuM/VXrT6w37T7dvXgt30QVoYlFyc1hIffGA32/RLK4NgEL6Hh/e35b/1lc8yN7ByAwGtO0jSHBr4ICnYuv7OIPvFbB9EP7sYGFsisHpPFAq5pxyC6eyg0Qz+iD1VwO6LdquJsHn+T0r5LRtUoIZaZs8DJbzASDzdcC2y2O3zQ2l4xm3n+9CakDtu2SSIqoW9JFE+R5HwoQEv8FSLzd8nsEDWtesdWIC6U0DwX3paj0BQINJ8Hu9Eo+UqAUHAY0Pc5JW0p8Y6O0hYH38QSivzv5tkIDbUpxkEJUpgQvfp7NdMrqtVRy7Qo+flCKAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NIjmf02MF259Yyvy24ihpiti2Jm9YEKPTXkWgr8so/BicubMVQtBzbN8HA?=
 =?iso-8859-1?Q?Qtcxb9imeki7unmHU4QF845ZyItK3f2buPCGXBYDGuMzrtZYbMNABlys1Z?=
 =?iso-8859-1?Q?aBMlpYafE47JAyOCbbs4U/siUanNrQo3r/1YqjRaTcAmwymsG55NoRvw+V?=
 =?iso-8859-1?Q?G6zAaB3x8o8QWgC6QCGJQiuQmqmHDxXUWr6xEWvVhP5MlXDHurMMtxtBr1?=
 =?iso-8859-1?Q?sAPlbkJbdKW3jjAZAByZM4s6I4i+PPF2JHSSabs0hntECabTZoH0h1/ml+?=
 =?iso-8859-1?Q?Uwdfb8RTPAej4qnwyNQXyf7aA4LJJcGhEbsVDddF6mqI42JwSRLmnFLEOh?=
 =?iso-8859-1?Q?OLuD/ClgNvIKm59SYvjYajoGP0i/e9r429tRRn4HxmwXNiG4EvcjGuLyYy?=
 =?iso-8859-1?Q?cRKESQtzH/x3kKeveFQknEcTqLe7lS9yrGDkmb3QZJoDaVr7RfhokL0Ea9?=
 =?iso-8859-1?Q?CirD9YCKCNjJ55aRidCJmAPdCwiYjN1BBjEzoDWx6vVAIU/W0jyzOj4XK5?=
 =?iso-8859-1?Q?2JM0Uy17Y5ijuoHDXiWVtINoKzFiZaJXLqMT9DlUDND2kHofwyWtrUeKVW?=
 =?iso-8859-1?Q?yfF6pkYosv6rKy9C5eGvvF+XgirrBde5oJkD2S+DhdhG/jmFOB33UFouQu?=
 =?iso-8859-1?Q?LutvBmQ/NsU/5iMO+6//RDnCQsirYfgEK6ye3J0v5wA/2PAGfbMWqWlpSs?=
 =?iso-8859-1?Q?zTy1it67SjP2ezRPhE7e7kVPBAysZqY7g1X0TXQ0Lsg1v+mn/AJjsYiFzC?=
 =?iso-8859-1?Q?OCHz84+w5irZlD46UCAxqNvs8EJS791q2TJ1Frd+UGAvj4aYHLy41EwAJU?=
 =?iso-8859-1?Q?DME6I6kKBnA0M1a4mSDhEM9LPKPNuiqbSY/6Vc7qm35zJhknRn7OMw838l?=
 =?iso-8859-1?Q?cNFFXgJ2AuiN/qXcS/DDRXaKrkS397A9vQcjEp9lPckWTtQfFfWoc4pEbz?=
 =?iso-8859-1?Q?0iSBE/kHPt8uMfnciIIjIqkIZWaOIWMpzL20qp3Y+s/8gzxIkvJj19IQmC?=
 =?iso-8859-1?Q?avVkQj3oxYcqS1lMRZ7Sp/5dVRSJ7ILYn9o+eW7mpjvzBZQf3pgtrLb/hV?=
 =?iso-8859-1?Q?eoNuu1kLiDihbhBFkAs8BamVolFrrJNwBmCz17KwArBlQab7Ai5Z2IMsTz?=
 =?iso-8859-1?Q?eS9UStGhEwy6DPitoDkglvEu/C+kfkAOrcZOhlRY+lvmRAbnRMbSpFjR6b?=
 =?iso-8859-1?Q?PwYTIUAczCIQwRK7j/f4ogHUWwFgEmkPbsLQfwjZFDK9WNmijfrMRPSw3s?=
 =?iso-8859-1?Q?0jiMlAcitUGwcJf/wwzksFBZKDCxr/t31Pfnp1/Pc3I0CVSi9FrAbiJ8+I?=
 =?iso-8859-1?Q?n2P5Wr2p4sgp2pM/BT7hHGqH0DFlbWLg7/d8psP+oI/mM3SNXvs6/qZ5XM?=
 =?iso-8859-1?Q?3TESszoKGIdZouYWrgnQOAZAKGYvl0r0aiU47f6OXD+Ts8MiusvTJreep0?=
 =?iso-8859-1?Q?b3K3cTZk5zFtCWTQPZ4wNNKfjoHnNc3h8V32SneDlfnltxWxaiAobZcLU/?=
 =?iso-8859-1?Q?PObjjKVJ8ZVGIJfeIPrX58+4SyVvay+IVoQ5HQwpTi3ePZKQVyQf6jt+1d?=
 =?iso-8859-1?Q?5XQhm6Y5TRuqo9HhKHJmgwI8BbBE537DIvsaQp8tBNcyHD2UZmGKpu0nLN?=
 =?iso-8859-1?Q?ckxyiL1vckhIWXEBvki0Duyx65MBO12N+2v50xizLyzpqzXcuW539hCKMF?=
 =?iso-8859-1?Q?d1hSAGpZkCK37LAq9XSu+YQdC5bLNDy/26kHDFF4fuLP6ahI3Z108GSaSv?=
 =?iso-8859-1?Q?PbYEVSkaXP4SRhTz9TCrFdcFI7vBaePaCq8PWWoUwOcacePNjQqc2Zq9m9?=
 =?iso-8859-1?Q?5fHyCq8YsQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lNolUV+kX5Yl+4F06PdDwkktcqy1dM/JIZJsa09PaQmoQnGXTlZ2knia3BwO9P2YFcEEJ8W90rZSUzX5ukr9OuwILdmT9rrD5GSUsvMXc9kM9Bl7SNr1GoABjqZ9UKCa4mRde8+ifn0C98KaM5cnDJq1fTmgZRHi/Gtprxc0EMEKe9b50L5pduPJLeV7fjeQPNe1vaNvnwdLwZJZIIaK1c0UbRAXa4YLUATaKJwnADWGkmabTW5KnOSs71AqCUx/XKBpW+BvEY3nilCLTRs+T05/1AMX7CxL1lNoOeHisLk2bvTqNC8JEBEOopESXb9glFLSeSWkiLFK3C6ObbPhPg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfafa79-5921-4cce-40b5-08dea9885d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:47.8075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 254b1S1eXTuLOujV4F3YA9JmJL9pzw6N+LGOn5gQpNty+p5eIOFeqhmriErYPEvJQ6eRjjqMrH8wwMeNNqULnGE3YCVorLR8K6pnMKNU/Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8442
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
EHCI 64-bit buffer pointer fields are defined in Appendix B as=0A=
split 32-bit low/high parts located at separate offsets, rather=0A=
than a single contiguous 64-bit field. Therefore, the buffer=0A=
pointers cannot be represented as uint64_t bufptr[5] without=0A=
violating the descriptor layout defined by the specification.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Note: Similar split 64-bit buffer pointer handling is required for=0A=
qTD, iTD and siTD descriptors, which will be addressed in follow-up=0A=
changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 ++++=0A=
 hw/usb/hcd-ehci.c   | 47 ++++++++++++++++++++++++++++++++++-----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 41 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f1f2fde578..3428839ec6 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
+#define EHCI_QH_OVERLAY_COUNT 12=0A=
+=0A=
 /*=0A=
  * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
@@ -194,6 +197,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 enum async_state {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 7166a93fd2..e770f0a7fa 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -147,6 +147,23 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(const EHCIState *s, uint32_t hi,=0A=
+                                  uint32_t lo, uint32_t lo_mask)=0A=
+{=0A=
+    uint64_t addr =3D lo & lo_mask;=0A=
+=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr =3D deposit64(addr, 32, 32, hi);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(const EHCIState *s, uint32_t lo)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, lo, UINT32_MAX);=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +457,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1538,7 +1555,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1566,8 +1585,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1693,7 +1712,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1876,10 +1895,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2205,6 +2226,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2229,12 +2252,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,=0A=
+                                              list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 8c90688bb3..67249d69c2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""=0A=
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t en=
try) "frame=3D%d, list=3D0x%" PRIx64 ", entry=3D0x%" PRIx64=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
-- =0A=
2.43.0=0A=

