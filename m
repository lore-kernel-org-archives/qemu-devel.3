Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32D606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=iHlZfWGk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjVD-00040H-Ui; Tue, 24 Nov 2026 00:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUp-0003rs-TT; Tue, 24 Nov 2026 00:55:16 -0500
Received: from mail-japaneastazon11023140.outbound.protection.outlook.com
 ([52.101.127.140] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUk-0001Lo-1o; Tue, 24 Nov 2026 00:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4SThVSBPfOsNJ0rNk4LYPughgLRgH3EWvPsGsEz03i0FaxJH9pJ29ofrksjKndCpmji+HQ35GnqK2hZOu5kq0ehnviZJhj+0PSIV2C6PIwXVsrzoAA9ggsq2g34fCcb3Ms4IF8fF477+rh/QXl4WPy0sG55MLvCUeYhXLfMl62b1IxH82Oo4jhcxdOeXh4kU9o7/CZxypc8Ovv56jecKb5bUlfpTPTQpKiyLXSHdd9vGu9jRM8IO6lE9GJ7QzuKaIcBHuDL17DWnF2qT72ymuaj+qeXfU1FtMTx2/Tx6vUxLfH3xmiQwcu1OIKmz57vfIgu8oNsQu0WG991PiPUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLNP/cyqxcVp6OFMmqPtffxvVJTH89MPbnbOeT7OHQQ=;
 b=gaAJVxi4USx6jrnyJ4WVOthlBOv7wBArwv0tI/rXxKfcDlUaPyT2Ln8UAAIFSff8iIaIzpzDV+NeqlyV4FRFNvjimwaXPlF7yIshKGHmB7x2E1g0lv5i6KvC2JpP1z3ubrQv0NvC5Y8PfYo2tNTMv9BkMCaDZN4KA74DW+kM6GBgRS7gpesa2OYhgvuDXORC6Sn0YjVsqxuwUO3MX1wgZzubBv8qtA2760u/W+xgPYL65SPjv6G9m1Ra2fHetJwkr3eKeTCjtOBxuQBYlbAlCrkhccIuxYUfC1iE015+SKL6CEzZmzYNKHyk+Jjy5JifvJWFhUqwqTeaT4ruhMymVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLNP/cyqxcVp6OFMmqPtffxvVJTH89MPbnbOeT7OHQQ=;
 b=iHlZfWGkK823EtEQGnt+w1VzKGvBhTpv/x0EQL3wOYXvSNP9rA9iKz1ivsyRe5ChyyhGkqVuP7FqwoPZ76ZeOzrZFE/4vj8lFt81nJbBRoh6GMSkod6BgR8BiNKexGotq1UQw8O7VmV8W7xiSBMnvDyTwpZy+/GNv0O5zzBNfdAAwOsQyTqMi7C2OOKlVhOR53L5zq7NkoIYVVWcLuu+xBlVXcMw/RUUMa1pw2EtrbOFgH2JTCmO1q5dQGloP/ROUlV8+tVisopM/D2vuW3qavDIlDJR9wkfaXZqTsRjDcR7jDgmesIBNcLymL/0+I7ObuhgP/lVvbe8pbDNk0+sXQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB8194.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:57 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 06/11] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v7 06/11] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
Thread-Index: AQHde9fqTydymAUh/0iSRXZQ5EnBHg==
Date: Tue, 24 Nov 2026 05:51:57 +0000
Message-ID: <20261124055150.1328856-7-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB8194:EE_
x-ms-publictraffictype: Email
client-request-id: b33a8b73-a760-481a-b451-b8ad8227edd7
request-id: 36ecd63f-f7ae-454e-882e-08df49ef0d1e
x-ms-office365-filtering-correlation-id: 36ecd63f-f7ae-454e-882e-08df49ef0d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|56012099006|5023799004|261022105027099003|261021123027099003|261021135927099003|261022115727099003|261021133027099003|261026130827099003|261028144727099003|261022075727099003|261022113327099003|261021121427099003|261021130227099003|261026140227099003|261026135527099003|261026121527099003|261102123227099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: BUSojI0FxCVV+VxG+rAo4VxQbkLULnIMafn/eGCrGxL+aL9FkMDFC1OFCLN43l3e2a32ceCKsFD99RNHskBZTwgaCn9q57TJX+/UzrnUI4xPpAhqm4tebR5VmtR+FzQqEY3c2GDGCmxAh9J3mvO37S87pGUFbRypJJKUICVQ2WNGQL+IDmEzKEMfcDYPAPCCNiYwXEYL/RqHCQVGU0JEZBj9WwYxVaJTfPUn1sob5UsWUDcZhtAvRpk77LxXjR3LHn4C/kPvaeyW11HMq+7PdxonG+rPpumrGKKqWfO7yIQqEI3AvAWNBLs7yDaYbN4lwUuKzhYsRPVfEmIcxcag5NxTmd8ZR7suec8Gnrqiz9lHKjb3ddqYn/5JY2auPmamzdD1o6YZjHHD1lfKVMVcUyTOJjjbbotCuzWzMLg3IXRwKvDoYGYwqwvEDSq7rviAbZWPVvwMjRRBz/FOYiWTIi/NH8GoYUeG2uQhiB/0I+7TdnIJakJg3OLQkVWD4GrUTFM2M9zlPMCnwbCHUKOUgyROW1h5MdTC1wgC8phCu2WMh5fF+sy8GZAx8teJgaer8RlwO9I2wXcjAqTnP67bNH4qRbObHB+o33au4/zgDKXjCag6+LMz0u8ZPkBegFqjWPOtnn2bGxiCmk3T2zEfrKWh4+32d5k4jP9oH4Z2cIff3QpV92Z52yN1nQKJ9uiOXTab/Txfgj4RObysKOT2oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(56012099006)(5023799004)(261022105027099003)(261021123027099003)(261021135927099003)(261022115727099003)(261021133027099003)(261026130827099003)(261028144727099003)(261022075727099003)(261022113327099003)(261021121427099003)(261021130227099003)(261026140227099003)(261026135527099003)(261026121527099003)(261102123227099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P58CS9qT167SkM2NGFn/ZICRLPJfYPqzxeVV1v5GKA8EyLeGPZEeLu0f3O?=
 =?iso-8859-1?Q?bLbwEDcAdACgyJvMKEgfxKC1Hr9r+5Bis8KTflC6f1y/CkziFJ3tRf8Cer?=
 =?iso-8859-1?Q?79xQz+IWepIXOcGvLoDFCcEOsJ5C2KrIFRXh+Ipiz6A2SNWIr0zOsY2ZVn?=
 =?iso-8859-1?Q?dUb3n6MTKNvMQrbtgPv8NSQLcPyClszLR1JGQGx7OH89qqMViWjCehwIQw?=
 =?iso-8859-1?Q?zGaL+Uyf3IJyptiz5ltfBxhz9NkIV7hHczcO6jeFtkeQpnVFgfuYnEGYZw?=
 =?iso-8859-1?Q?Q9tWzHoBWnYKNJG4FMSv8CqRymZpoq2oF5B3WE4fN38JhxJUAExygbD1IV?=
 =?iso-8859-1?Q?692V/y3bg6YXYuUYxCp1FUVSAd5lBAF8hAJH1WP7vflIAs3uqgDC5OCJhn?=
 =?iso-8859-1?Q?ahUEUfbnEmbB26VJvCJXLvOUvx03ZzYDLGuZKGBdLPSB9v666ahCgkn7B0?=
 =?iso-8859-1?Q?ho8OcfFhIe9BRsSDoj5jTLyy60UgQW3shNIFzmwNNtfSq3Qki6jsBXqv9A?=
 =?iso-8859-1?Q?/VYHSAQpWtPf9Z/VK4DKMaq9scanJ7lLdBalxmIlXdYKkwXOxl+1XkhR+r?=
 =?iso-8859-1?Q?C8x2IhQazvUyQ+VKUP0jBrqkJKaNcZRN7ek5i3eN5kNCdZcz0yAhUT4oIW?=
 =?iso-8859-1?Q?OPdSoGz0SCV3PjBOFh5zZo1jVfnciExrK3EUSiJskZAmkV63RPl9mId1vB?=
 =?iso-8859-1?Q?dbDxGsPv++bKrvVPOldXYfQy3Xp/Tir+/G1mmWDjHWYZPoP/7jo0cCICm2?=
 =?iso-8859-1?Q?mgvd7auapjP/Cnt/60M0oSo5Kwv859vKYf+Orooxy9IkfpPXqnkoVtKNbz?=
 =?iso-8859-1?Q?4EIR0Plj9pwskZZRVY8Qa9OKCDy/zSvgIV4+XiOOl0V9AqK5WBJe+xv/KH?=
 =?iso-8859-1?Q?exuYrRB+HZKSdaTmoh1zTuLez2s+1osKNwoq7X3eFSDVpaF44TPH/AFN3k?=
 =?iso-8859-1?Q?hQiW1tilooE3sXa+FC4aAAquud2MJOwvLyMHL2kUAzZbEfeyQIDvT7ixOC?=
 =?iso-8859-1?Q?ZYAJbStJ4rjgCqGp2LAfMfm9UqzRFWyLFzD51VpXjhajHkMPjf2lpXoOuC?=
 =?iso-8859-1?Q?WDnkH/WCqnz6Tq2aXyIekdLCQRjlsFJ09tdUpVesY/dPOlVayG4wXkr9o9?=
 =?iso-8859-1?Q?SqBL58ZpS1SKxW+iTdhUsjMLDXSQx8XTr2CTOsF5G4jQlIlVoGzhdliSvA?=
 =?iso-8859-1?Q?Tk6XsCe8RBIFqyRx+gygHQGTN7xdZqDNjuqY/+22ORfhtLUtuCEPRezmu8?=
 =?iso-8859-1?Q?ziUHf2uEZDgvhGjp/5hOSDgbIPPnMOujK3Y/GYKLhrGZrzLBarXnSLD/PS?=
 =?iso-8859-1?Q?5XK/qHXNdY6Ghu+L8f5A7Ts9aM2VwQVBDP0F4aZegnR29blZ29SpheSzgk?=
 =?iso-8859-1?Q?FuhsUc9KJKbzbsyMMm10cjriAA3b0fh8R6pSJ1wZGGD59A0KJxT2/k+mPu?=
 =?iso-8859-1?Q?+ZyBxZlZnSC+Nmhb9qAOIHI2+TmuVwy5NG9YSOsjpmBZDATKD7bj7KPZ11?=
 =?iso-8859-1?Q?J/iniUbXSDtPA9XHfoegAG9VRVDKFqMqDtW0IKeNI6Y7+gDcYb5FwVqDmg?=
 =?iso-8859-1?Q?9/V+BsudLMu9z3Gfdt1lmbvxyZ9oQvRBnk/d5zp/rFhSE9ss1LSVDwVCKC?=
 =?iso-8859-1?Q?u8aMPtJTPtZ/ryrhYu75get3laUqLyN9BO93A9FLtAL+uiRdB+70mm4vsq?=
 =?iso-8859-1?Q?6mnV0McrXfNQaUMx13RdXom+T/IlGGFPuw6Tiy+pmjo1Wt3dBnkS1mbynl?=
 =?iso-8859-1?Q?giwNLilkrlq+iVBzvTmT03TWA8cx/e+ClfKQ+xDmbaPRXOxilBnOTP0k68?=
 =?iso-8859-1?Q?AoPTLH1vyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ecd63f-f7ae-454e-882e-08df49ef0d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:57.5363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLuI3pRqGTnAjq00EEPCwy/uph/fl8R0qtDyTNXHiUBDmmFl3bhnmTYcMreW/Zx7Ntr1TT5Bj7u52lBDm0uJQju1qpv3djO8cisxIyisaIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8194
Received-SPF: pass client-ip=52.101.127.140;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch implements SSP reset and power control logic in the SCU for AST2=
700.=0A=
It introduces support for the following behavior:=0A=
=0A=
1. SSP Reset Trigger (via SCU 0x200):=0A=
   - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL=
_1.=0A=
=0A=
2. SSP Reset State and Source Hold (via SCU 0x120):=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding SSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the SSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
   - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_C=
TRL_0 to release=0A=
     the hold and power on SSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x204):=0A=
   - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_R=
ST_CLR_1,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. SSP Power Control Logic:=0A=
   - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and =
invokes=0A=
     `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).=
=0A=
   - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, a=
lso asserts=0A=
     RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.=0A=
=0A=
6. Register Initialization and Definitions:=0A=
   - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (=
0x200),=0A=
     and SYS_RST_CLR_1 (0x204).=0A=
   - Updates the reset values for these registers during SCU initialization=
.=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
This patch enables proper modeling of SSP lifecycle management across reset=
,=0A=
hold, and power-on states for the AST2700 SoC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 109 +++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 109 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index f31545a126..b687f9d44d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -147,6 +148,17 @@=0A=
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)=0A=
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)=0A=
 =0A=
+/* SSP TSP */=0A=
+#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
+#define AST2700_SSP_TSP_RST             BIT(1)=0A=
+#define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
+#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
+#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
+#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
+#define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+=0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
 #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)=0A=
@@ -858,6 +870,35 @@ static void aspeed_2600_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2600_scu_ops;=0A=
 }=0A=
 =0A=
+static void handle_2700_ssp_tsp_on(struct AspeedSCUState *s, int cpuid,=0A=
+                                   int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val &=3D ~AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {=0A=
+        val &=3D ~AST2700_SSP_TSP_RST_RB;=0A=
+        arm_set_cpu_on_and_reset(cpuid);=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
+static void handle_2700_ssp_tsp_off(struct AspeedSCUState *s, int cpuid,=
=0A=
+                                    int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val |=3D AST2700_SSP_TSP_RST_RB;=0A=
+    val |=3D AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (val & AST2700_SSP_TSP_RST) {=0A=
+        val |=3D AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+    }=0A=
+    arm_set_cpu_off(cpuid);=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -878,10 +919,14 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque,=
 hwaddr offset,=0A=
 static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,=0A=
                                      uint64_t data64, unsigned size)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
+    uint32_t active;=0A=
+    uint32_t oldval;=0A=
+    int cpuid;=0A=
 =0A=
     if (reg >=3D ASPEED_AST2700_SCU_NR_REGS) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -893,6 +938,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
     trace_aspeed_ast2700_scu_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCU_SSP_CTRL_0:=0A=
+        cpuid =3D a->ssp_cpuid;=0A=
+        if (cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[reg];=0A=
+        data &=3D 0xff;=0A=
+        active =3D oldval ^ data;=0A=
+=0A=
+        /*=0A=
+         * If reset bit is being released (1 -> 0) and no other reset sour=
ce=0A=
+         * is active, clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST=
)) {=0A=
+            s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+            if ((oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * If ENABLE bit is newly set and reset state is ready,=0A=
+         * clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_ENABLE) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&=0A=
+            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+        }=0A=
+=0A=
+        /* Auto-clear the ENABLE bit (one-shot behavior) */=0A=
+        data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
+        s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        if (data & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_1];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -920,6 +1022,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700=
_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
+    [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -939,12 +1043,17 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
 =0A=
 static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(obj);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+=0A=
+    if (a->ssp_cpuid >=3D 0) {=0A=
+        arm_set_cpu_off(a->ssp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_instance_init(Object *obj)=0A=
-- =0A=
2.53.0=0A=

