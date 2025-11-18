Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8DACEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXe-00089R-W4; Tue, 18 Nov 2025 03:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXd-000872-Hb; Tue, 18 Nov 2025 03:58:25 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXb-0003Vy-NA; Tue, 18 Nov 2025 03:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn27eQez9s+nonNMKUV6di2tghYZ+2g6yrs8liOpp9Rpa36fV8XgFYJ4cROAP0IuDh2yCPFG4qvE8t4dMXIdAixGl7mOSXcnX9eju2Yk7ztStBKrh8QK5tGlY1e13/m+8hc3mlt0laY05YaXJ0ZJHGtHT+U+/RwToJlX1OaIgvH+3PUEsK/C0UQvOExwihiFZ/iB9njUt6dHIOTXvMlsF3yNdBdXUsuYJOSrIF5bOy7+TiFu7ctzNKNuBLgQVrXVoA52BFJ8ij1Ei/YVd20UFbKfFFUydgp9nmdvYM83dADzhwp+Vft+Qb9WuCrJxQ6WdUcd8ZP1TKq763vxL2fbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=wwgcjTAYd3fJjnC2DV7JSkVciSpG/6j18VHutbTpwZvXSh0e7Kys4utK4zvYRxIm7JY6+vG4fHTXdgZAsFYbzadwQ67xGmJJkkfGhWRGfxwvU/zh+EcGeN/SW2lO82XHRK6LJUewZT4MMoAM73+WHGfb6xjoE9lyAkTgO/TiPBf4hsGLw4xW2VkG3wIXmFDcGlpMQJXyF0QQi6u3NIZTss6k+i+sSJOxmwSwKyu2VFkcDRzNXmieQoJVUjuNIMVHuNglJVdJnrdljEohR+Isp2JFryR1Cb802fWNMtMPRqrEfAw3ApLcUWrTh1pgytaMnuYdoJyXyN9rrWG2uaILTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=asxfW+nqeydbec587pElZRm3bMnf0Gg5CPxOUZZqFujE9eA/07iwnuPFO9keTe8byVlihUXvTwsDx74RyFgP3Ht6SU6xoPFUuwsoqcHoLlc9f/RgZkkJsXpvKjZqizDd5BPcfdAS22BQd2PU+ggkqHJ1d49xfuVpzYi/rjz7M911kelZCD9VsIl2XgRAj5PjrPXVG/jMQadKXOox396cI/SXkP4fTHFGIUEL4+p6pKn8PbwJX6jKs26Mdrb3IcsHUN4X5AgGK7Tu6phDhTargJzz2gmTM+hJ+ldRhqqcyw2tVlZEbzpLrBTh7jeqAf/qSv20OG3d/Lfd6BMnRSY0+A==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:07 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v14 06/14] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v14 06/14] target/riscv: Add mips.pref instruction
Thread-Index: AQHcWGl1Vp+V/JjyCUe1AvXm50jMEg==
Date: Tue, 18 Nov 2025 08:58:07 +0000
Message-ID: <20251118085758.3996513-7-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: f76763a6-8666-43ca-add8-08de268097d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4T6Tp/6at6mx7ychkOxoKhXvYvZ6pvd28pL2ZK/x3+19+/eGme+VKZM24/?=
 =?iso-8859-1?Q?bllgumbJ+DX9dWzraBVEyQsvyOtlpL4rMAaAb2Bb+q/TcMMwZf1rjN40K0?=
 =?iso-8859-1?Q?OspzfFPKKi3ikwg4qnZC2SGFl/6KMQB50ooLexhembf7gmuSqGxOZPBuER?=
 =?iso-8859-1?Q?ifgoKL9af3kI+sEt7w+lLy6AdXXDFptmaIXgcUOFtSONl+0Ks9cUIb5Psc?=
 =?iso-8859-1?Q?BNY+MNcF6SR94jkwnttaPxfTxsJCV7LFxDNTNx7kym1ro8f1OID0gci9nH?=
 =?iso-8859-1?Q?ofup7dVouImrmHQjLfXh7ak4r0jH88GnWlFmUGkHtdnZL3izCB4dlV8Sm2?=
 =?iso-8859-1?Q?L8mjc3DXziGx9GvZuHSL40LfnS806fm1mxuJdX7yXo+hWw+NqmBkS/Acba?=
 =?iso-8859-1?Q?ysNgyC+XdWINCBxEC1B98+qq1jTzvhuYq6EYcIL2js+sqM6atbeMGrQeQH?=
 =?iso-8859-1?Q?jas/HCJJfFnQNXSfIBbhxaYc8KQ6QnqE89Dhki72kM4fyw+1tP4Ub3nCAw?=
 =?iso-8859-1?Q?p/Nbkhk8867dnUFT3T8LL4hFsHYkIE3un7fGrmCZfz32ENLIGFQDjxXP7L?=
 =?iso-8859-1?Q?yiRQWOwTeXeCNSU8+gMU8VhrTGrXqJLCZ4NknHjOlEb3kGjI9gKO+BCK7o?=
 =?iso-8859-1?Q?6GImhUj5oJ8BU8kOIeuvzcmpF9wuaAsNV5sJPoXbI4peo0EWCJR8MWOTMe?=
 =?iso-8859-1?Q?zSsXkXqBSr1Wu9ZNhEsCmewRxJLnrB60nCXad3umtgxw3KzXNxebACnjI4?=
 =?iso-8859-1?Q?vqsGWhoSLDWCkLWhf8sdctsLG3Xe005JLMmrWTI5UyMCmOdE8cZUgby1Fm?=
 =?iso-8859-1?Q?ihPWfP8wvUeSmJyUGBb8GB2PtWyrozL7tFYN7bV6aFg8wQ+SZIJYYW3hVe?=
 =?iso-8859-1?Q?WdFg5UAg7tUalgX4YZSmWAZX0folKe0S+Bx43d0JXlRWTwiEMXyE5chF47?=
 =?iso-8859-1?Q?aUbotANbwAOtehKowse8Cp7W1qonQwAc4KHoWjKXEnvloZGovL47FG846A?=
 =?iso-8859-1?Q?WCbGhlFjTDLUekdWTrO4DLRA286mmSml07OkMUJfvNkYo6BiFcMFrAu8oq?=
 =?iso-8859-1?Q?YWXm4QmSMV/32QeNQpMRwH593FmH8/zZ4J1a6VfcEN90BKm9oVnNLzcOdQ?=
 =?iso-8859-1?Q?kWGJ/4pwbgGli3NtzbaGEP5SeeXZK2ljdm+c3MovyfZRFPAXR+3ECFQWJD?=
 =?iso-8859-1?Q?4jMTdeTPaHItXCvZQTvB9gLupm4ZQJcrxgPn+YOgV5h4jbzj4iTrRfG9hj?=
 =?iso-8859-1?Q?Ul8nkR1mFAFEBTmcAnWPYKDmJC9HX+N/L8XK9G8qogXt0hik0QfEHOx/yf?=
 =?iso-8859-1?Q?N3KZGp7X3s5Sdr1Mp6tR3WiQLIaclfRte5j76JGekDSftTbqUjsOje1R9B?=
 =?iso-8859-1?Q?eGM8GaVAgP7774R9wK2xePIbUIIHDDEhDdsspP0qISSLzmn3eHmAJKy7bZ?=
 =?iso-8859-1?Q?Mwy8ffDVBlwlfufKpqJbnVr/j90iRp1W5jm5hUUSGze4DWYsRaWKZROD6w?=
 =?iso-8859-1?Q?+o8Qh4JVEVdsb0omo5B2yV7UeBb1sUlF8qxh1G4ouV+VpjN62hYOc6/YY6?=
 =?iso-8859-1?Q?tbbKTH8Wg+gyX/ge9niKOuXzkSBZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nW/yCcPzvGoVJUE794OHWgY6X7ZjqgUYw++uaBmNTt7wmUIywb9MUYE0XC?=
 =?iso-8859-1?Q?92EEfoK4AE1vmGtu0cqHewj+KZClLPTG4tw6z0JnKNar4aiSm5GY9nU4Qt?=
 =?iso-8859-1?Q?ewq62x6M5wHOn6FjvuCWMJMqJZLI+kA0wC9SH3DIHn/LEyTjG5X1I5kD0B?=
 =?iso-8859-1?Q?7gFPSQKP8nV2A3ddcRC37ULJ/giwFZ7nouMq+lD8y0+l64pnM44LM3pyaH?=
 =?iso-8859-1?Q?p3EPs+BthPZIzD69+7CG28bTFdrVspTOqY9B2SDum2OXJ7bzAgST52uFH2?=
 =?iso-8859-1?Q?WRscWoC3Zz+knB4c5wR+fP/JTPbghQgt/LlgflndxsqM9TZnNgmmw7M3Oe?=
 =?iso-8859-1?Q?hl4bt75xCG4qjjkHKbjGkP3IxhYoIwIwUTtxLSzwMpS8tN4oc+AyvyqHQG?=
 =?iso-8859-1?Q?ozVzZYIiMXKLRRCdJUJnUp9wMYDFU+lccOYqxEZLym6iLcuERXjqMvRD+r?=
 =?iso-8859-1?Q?GaxTGc2yh6hWikVHdQ770gVMuyuYy62ypzr71B8yUWBt+tMLPWYoDg0E15?=
 =?iso-8859-1?Q?NU8lufhxPqDUPUv6tvyHppEzN+vmn6H4fDKEkybLny6M+hkS7KDNBtPWCB?=
 =?iso-8859-1?Q?Ze5scGWsulG1Mn7Frsbh1sCsLYmhbyUnNip3RjITCAAO0FucF9Sh13Dz6P?=
 =?iso-8859-1?Q?gi82SiXr/2GKRtmyp1Si1glGgVRQWbJe7uWf6IsRBRPU7pXMGZ3jH3ab8p?=
 =?iso-8859-1?Q?GwILpV5/W/uPmP76yxFKI41RMSDK9kGdXjpmGBieXX2ONoeRjQbhNxnz7E?=
 =?iso-8859-1?Q?Hlt/MCC0SMYUnHik8QgSG11oqqenP4BJG7Go9eSjDKRfDKkuk/0X56WjBu?=
 =?iso-8859-1?Q?rACQR9q2XDzs+08FeA4/jCu0IcgS9Oss6TosRK2QV1a1ubwMF+X3g89RKg?=
 =?iso-8859-1?Q?L5BV1Mbb3xcI4U6zuV6P2f63fjDivd2b/fgg3zDGdWkgozajUGVUFXwCl9?=
 =?iso-8859-1?Q?H232ycWpSBaV4w8G126jmHDUgXJvZ4YyQQifua5jkOmsVE78SDpPRuiy+G?=
 =?iso-8859-1?Q?+oJdbLkjpPoItiIJYmQmf4HpljEcYZk3gHlljXXc40O6+RqqUf3SZxbvCE?=
 =?iso-8859-1?Q?jmIx+D4m5u36c3Nt8fDYgF2RFfuBq3ybtZmfc4j7PjRFRB2P0LwIoV+aNq?=
 =?iso-8859-1?Q?Z8MeKoKfLtoHlHFrSEtQ4ucszoDWDHjCvf34vztKt0Z989J69ReU2HNIMX?=
 =?iso-8859-1?Q?I/aYz6FbsZ1Y4ipgZqKdrGnUbHkPyHYzMr33isxNVSDeWlptvV2NWsvYhd?=
 =?iso-8859-1?Q?aX+palwa5i258hzb4YPBE2A79PfkblC/JaxWEPMjUm3xKuTbmWWWP4m/6K?=
 =?iso-8859-1?Q?PedWgLsrmdp0xJuPx8Wwym9hs7Ts5xORJdJQkGvSe3wL/G4bqfKRgYzJ0/?=
 =?iso-8859-1?Q?3WvxiG6Ap/xk0rl+5AK7xNSxgCVd5vK9yujtcVrGJqTcFiOIPwb9CnFi5R?=
 =?iso-8859-1?Q?lfwEOTy1M5N2/KJl+rAmLmXy+SrsxqAzRtc7tghlLZvXMAO5HOVVoChbJk?=
 =?iso-8859-1?Q?iwvhdSpnXrwgKiXqxShbYGDlCNfVqLgB1d6TyGZuv1UUFYO06OtnzNkdbC?=
 =?iso-8859-1?Q?yhPYcsZrHebvLYQplwR5JHsioWJnpu4UP02WL61yDm6tPNWj8kFNhzUNCy?=
 =?iso-8859-1?Q?v2LCnfKACshIFz9HrdQJ6iOGDVl6JPtcGlAdJXYzonyWzu7rcuUMClkd7r?=
 =?iso-8859-1?Q?J9/ITgDxP2cEeCJP48s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76763a6-8666-43ca-add8-08de268097d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:07.7573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIhNkcJdpwpvQQmbr06LHlff/Io3pGf37uMCwP6e/AElsW7AY/IuHLJaZW17Kod9B/gzRwCNFLibZkShBMtmHuGjpqltfFrQ59Mugv2fM5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 87cb367676..9fda450683 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

