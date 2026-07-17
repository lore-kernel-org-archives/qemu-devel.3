Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51861C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDB-0000Wf-RB; Fri, 17 Jul 2026 04:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeCy-0000VR-O6; Fri, 17 Jul 2026 04:46:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeCw-0003vC-6u; Fri, 17 Jul 2026 04:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYZnWhHWuPwN6tbON4a7f9FW/sO60FV3MqX7H39b2MXHlWcYlJKWDWtbNOgMEW4NAv1HHivtIoNSjdQuU8h2Mf64qPvpUEz5eewhYSJ7beSEZkw4PgDpclIp5jIYKf2T2QCFaKkWTg5IBcbiOAk/R9fnFuvVfeYu0lOS5HZO8UMvLwwJtcGlg8gYkvZ7+IHpmMFHBxxpl4an7KmtVBMptwO7a9w8KaGYeNMGCbZa4H+L7JsIggI02Us8PNQXD3qJTV/1HL1SH+ZyeMxdwVOamGnnA+sZdf0tXVCLyyjbpSmPbR62WY0lEydL6bu7e+ZheIBxyKuBj8Tbi5KTU3/yqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhHwybn7PlXpWTHtVYcPfa0rhdqm8TTVgUR7w46nsPI=;
 b=kNXWkIBCYQp33SfrturagWZZuDx2Bo4++v8QSXKDthlV44pFsh6oxdW80t08+DqbRRjx6uCbnr6lgI8KOi99qxmntNgYjA8f6GsjcrwJn11K0z6RJNSU9gWdRInXdGcAte7ZyoBcKRJRNpE4D0oolBYKTqi0T9LhW3HmgzX1Wtrw0BbQvYaS9CGyIxuqPisqFE5rzPvmSa6MfbFrRScCFb9wIiCw/o7sb3T54OhjbF5RurxENLLuls90W00XK1tI9rMZiF5ca5uCaBGNh8iQ16L1VYrFIBKhh9l6H2lHbhqD55jjAVL/hVBFgUWlIhLA9FnViaMh+yQS5Tl+pXoZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhHwybn7PlXpWTHtVYcPfa0rhdqm8TTVgUR7w46nsPI=;
 b=pSGCRDSK1IwcoH3u02Q6lO1AqpMB0rV5b/6jiXtOqEJr2+2ov+v0nCx7C385ma3O35NfV0Cq292CmM4xGVo9Yr5toaw7TiF31r2SCszSAMRhPSlI0ZVY609VA1ISu7vVUo9MeUwnQnONqIDhsLv8CynpLR+1bjzRccr8Lmv4q29/G2ncrpm/Y5CXlkeSBgCSVw0baTvnknjh6iSzCezGY4k6MaCFJY+7gGClkq4rKKLzyoGALnTCIwDXOSQ9u3XpoRx4/UXdnCRiUm8Dkihs5YpiNRUafTH2MO88ccuQx4tSWuOKAIaXjbzSOcV+j2CRKLxeerk9jtgLb+IM8VGKBg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/9] Refactor AST2700 SCU preparation for coprocessors
Thread-Topic: [PATCH v4 0/9] Refactor AST2700 SCU preparation for coprocessors
Thread-Index: AQHdFcixLf/F9+26+kyz0aXwiP2VYw==
Date: Fri, 17 Jul 2026 08:46:00 +0000
Message-ID: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: fd4771ed-cd82-44b8-bad5-08dee3dfd3db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|18002099003|38070700021|6133799003|56012099006|10067099003;
x-microsoft-antispam-message-info: OMtLckkrzrcv5PcIprP8bybOZzI0DV5eLNmCum2zDIwwSV+5++F7Vs7XuESCh8AoPZmYhQjuRMkxhVXgiS+sEuxXsRkE3hXoeuGgZ6lDDxEZyF2D6Kmo1JGdO/OVpHlGL6CgHfogbhk2kbmvYBA+lE2zu0sO2lybbT+odrAzvFqwlZcj/R4fzTErVjs+1yuX/mK2FjYDykCUS6bO1inganvJzLsSZDepvi9i+mSQmaQf3+ntW80w+zcEdcUF+JAtBlwvBnOEFr62bsNHIFd1cuILEpZVR/mc37SBdQMkRL8S2M19MovIOZIb22DV/Sls4UWYDKfiBCi1NdWmsr3zxt97eD24l/HfUQSJ3gerTUYtcG4CY8sH5E5CF+fjuGurVcv/n1JF0y0fGog9CKKEkb+W+4eLh91T9HxVS/SscYsE8qllFVui0B3abFw/EdV8uGYFzRVtaDr2yPj9v8OnJh7hg7sNUSLt3ondlIDR1cR+g7P9yjk3ZkFVjzS05sSyG8PaxIIGbLuIYYYAFCugngRa/NiVDYQ1YmR3tPmTpSsa1f3WzyV7c4zPdud/wSki57Gfnr8VYuZpz8qhWOq+Ig2zTBRj/OkZw0rMWrG06pVY1XPfbMoMx/01xwe0FRos7whuIzhWNNvxhkERvPQdt9XaqSxw4Si4/8x6n80ZpfbPLXeLm3NM6AMtfqLGtXisLPbhZJvoDKrMi37+KokY4ZyeaHMkyz6uYJI2B/tV1qcqDPn/ymHNjz7MmIbe8ewp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(18002099003)(38070700021)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xGWj6aJT+5QRac2adZWalQ2lQr4kgsd2skatAtLhPN+UOY2Ayfv0ezeVoA?=
 =?iso-8859-1?Q?VdMtJZFIS7R1jPH4+cRT1Dwnd4mnk3x+IwQ+5MvcIiDVln18ThIDqkKzDs?=
 =?iso-8859-1?Q?sGjpsicrAbTVr6MNJmnyxuFSJgFOzodwu/h/WYQ6IKePT2K2sWZJQHLE6H?=
 =?iso-8859-1?Q?KDPdb3Jy+RvxyAQWvRHVvypfzJ6hhUoCVEgZ+e4b/d5BRKrj3GQtloFMBj?=
 =?iso-8859-1?Q?EgQX+ySRkQsRZxr7WlOUaQVQIgndWZ/HPBlN02MQM/U4UI+q++3BtWxSE7?=
 =?iso-8859-1?Q?zcR+KZ3u07SPQvZTQuRarey4Ff6Hu/6JVCNBKYokDf3fk0gxbmWeZCtwVI?=
 =?iso-8859-1?Q?b/bGVr7I8o8S2jA7UCljP0iSEgt4H1ikb0FSfTSIiqXbgT3JANuZ7QAcTX?=
 =?iso-8859-1?Q?r5HwW4HHBi3fnro+96oMYzxKf4dxDLJ21E1nYz2tIrfDqVjWj6W11hT+xN?=
 =?iso-8859-1?Q?BJTdVfJ23laxAaPauVxUFDGbF4IU2Q5YeotHBUr14c7SYpHl8pZHZsamGn?=
 =?iso-8859-1?Q?gQxa8lphnV+9l/dsZn0hJY1cZ8bcXcS40fiauHUPH8/DYz0FNl/zq8SOIo?=
 =?iso-8859-1?Q?Z+TpRi6ox5wnerOgsKSuqr2XbtreLptrjfMRcknXL7VmL7wVgsWdTjYzO3?=
 =?iso-8859-1?Q?G4VhnWvKHdyVfgEWOAdxEYxZ4k2phKhsS2/X7p8NoTj7GKxbKAYW0GORH9?=
 =?iso-8859-1?Q?GD/NkGKfQk+kfh9JwKp8EpTtFDhlObD8SnbjW6wXkorZjqisxN41oBeZwF?=
 =?iso-8859-1?Q?LF7O1teQC+TUo+GWqjiNHDXZkYHgpFtipLQXPkx5lXIZqplZySMmbu+fz9?=
 =?iso-8859-1?Q?Hn6UiIrEQahgbAy/vXE/L8Sm8epGxHnJo/O8eAgHqJNjm6vKxHYlLegwNM?=
 =?iso-8859-1?Q?JmwWY4QL1jto//E2DV/Wg3FE2QYlPwXUlM4rZYXKbsexOhCHwfglv3tmTJ?=
 =?iso-8859-1?Q?ekz/ZeDqsnSzw25W6WdxlyPvftbmL3NnvnLqlCJdFewfMfaTXxLgnLXWjW?=
 =?iso-8859-1?Q?B6d2CuuxqpIWf+5wPlo4jV+lmRaU98c858nF3qSzQCV65yVjLAqhLXhU6h?=
 =?iso-8859-1?Q?qNRFMNem3Vr8+ylUD7SgI0EdDT3r6pA6bXV2YENHavzVtTImq7By3fR2gp?=
 =?iso-8859-1?Q?YQ5YpdDiD8CKyx7gAxpfuUlZb4csQmJNgljYrb3LydnBOkSssm9YuwBdkI?=
 =?iso-8859-1?Q?2woo+1Wn1TVAh08lga71LfAENTPJuBCg/IeVUmGXVev4nZarrLMUmVlyKF?=
 =?iso-8859-1?Q?AjcbYT8EBCwAJZ568AdwbEQSmlQmBE4uwYl8MVN8ctFToi0Zb+qUD/pIcj?=
 =?iso-8859-1?Q?jkvhkNxr23if4/ZpYv+tzcDcCCzGdQ2xmQprYW9WckKLMAZp/o/VQrrjjf?=
 =?iso-8859-1?Q?D0b9PLsXd+/oB4YE+o8wvrZ6fsJOEnsEe2TRt0/NPXmUE7/tvK1lc8t6fq?=
 =?iso-8859-1?Q?1ok8eURRomzYvjN17csAX8LMZguIcXTIcBBrcUnIfodlPTIyigpo56fUR5?=
 =?iso-8859-1?Q?fxJ3sHI41ob8Z9Go+3ML9nOdGg22HrlC6lCogeQpYThRpQaM7eNjIe05WY?=
 =?iso-8859-1?Q?hCXcpcDvo7W0+WBzzqktsNRYHsyn9zM3e2L4cfeh+hkOCMalhU+Ir7WC6Y?=
 =?iso-8859-1?Q?MCxmWhQa9Ke2/qyshKGpvdzlA2XqefmXOTddD2hQVhp35sNqg5edmDmAhz?=
 =?iso-8859-1?Q?gIFSVQBtX3FiV6aZTl0EellBPPpf143D4OnPftBhw7h0Fdcl3TL3vBWz/u?=
 =?iso-8859-1?Q?iSddLk7SlPfPB29MwapBacAsbOwet13bEW6thVXUJfbvsRbRD2rjxCvKyg?=
 =?iso-8859-1?Q?ddOeQRCr6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b16E2VWcLjbnLPgSxuBSM9Ly4XgY/dTyWkBhEiQ1qf+VNVKCvklldRMLuUlv55HoQt2dhBP+JqPbrf3FQSftWcG7VEmvE3GDPmHVhCAGdzdpiEuhIHXi9eYWYU6MMPmq2A3iIhQjWZWZz/u5avvdbExoxeg0QzAqsz9GQtf/KSJTvfHFVkd8ByDGy909oqOqdrxobeD/gdbPxj/DeaCDk8sJygjRYFzgIdJfUrAIxmEQmWgULxyJSbntPFwH6oaMzZ3J12enHrigmhgd+3HxPooo0fFCgvRaGMYzdgAIEofLPTWViM1KUEsKAY7ZAE0CEsYj+nw7655Roq0V5Ex1VA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4771ed-cd82-44b8-bad5-08dee3dfd3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:00.4613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QU9961MbzYMZdiuBy14MRWaTnhBuicqBk2oT8NHkhQPG+7aAIhtRBRxOCm5AZjb9sopI7MrZHp7c5SCI6PQgXzLdPL0PUX7HIyFod5wP97I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The original AST2700 FC support series [1] is fairly large, making it=0A=
difficult to review all changes together.=0A=
=0A=
To help speed up the review process, this series extracts the SCU/FMC-relat=
ed=0A=
refactoring into a standalone prerequisite series.=0A=
=0A=
This series depends on https://github.com/legoater/qemu.git at aspeed-next =
branch.=0A=
=0A=
v1:=0A=
Compared with the original series, the SCU preparation patch has been=0A=
split into three smaller patches:=0A=
=0A=
Introduce Aspeed2700SCUState.=0A=
Convert AST1700/AST27x0 users to the new SCU subclass.=0A=
Move the SCU link property into the AST27x0-specific coprocessor=0A=
implementation.=0A=
=0A=
In addition, the SCUIO reset handling has been separated into an=0A=
independent patch.=0A=
=0A=
This series contains no functional changes. It is purely a refactoring=0A=
to isolate AST2700-specific SCU support from the generic implementation=0A=
and prepare for the subsequent AST2700 FC support.=0A=
=0A=
v2:=0A=
 1. Pass realized PSP SoC to SSP/TSP initialization=0A=
 2. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 3. Share FMC controller with SSP and TSP=0A=
 4. Add Data FIFO-based flash access support for=0A=
=0A=
v3:=0A=
  1. Add Data FIFO mode test=0A=
  2. Clarify SCU/SCUIO/FMC fields are shared with PSP SoC to AST2700=0A=
  3. Bump vmstate version after ASPEED_SMC_R_MAX increase=0A=
=0A=
v4:=0A=
  1. Fix to apply patch failure=0A=
=0A=
Supersedes the following patches from the original FC support series [1]:=
=0A=
=0A=
Patch 1:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-2-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 2:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-3-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 4:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-12-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 15:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-16-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 18:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-19-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch =0A=
[1] Original AST2700 FC support series:=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Jamin Lin (9):=0A=
  hw/misc/aspeed_scu: Introduce Aspeed2700SCUState=0A=
  hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users=0A=
  hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors=0A=
  hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO=0A=
  hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization=0A=
  hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP=0A=
  hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
  hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for=0A=
    AST2700=0A=
  tests/qtest/ast2700-smc-test: Add Data FIFO mode test=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |   2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |  16 +++-=0A=
 include/hw/arm/aspeed_soc.h         |   1 +=0A=
 include/hw/misc/aspeed_scu.h        |   5 ++=0A=
 include/hw/ssi/aspeed_smc.h         |   3 +-=0A=
 tests/qtest/aspeed-smc-utils.h      |   4 +=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  38 ++++++---=0A=
 hw/arm/aspeed_ast27x0-ssp.c         |  56 ++++++++++---=0A=
 hw/arm/aspeed_ast27x0-tsp.c         |  56 ++++++++++---=0A=
 hw/arm/aspeed_ast27x0.c             |  16 ++--=0A=
 hw/arm/aspeed_coprocessor_common.c  |   2 -=0A=
 hw/misc/aspeed_scu.c                |  20 ++++-=0A=
 hw/ssi/aspeed_smc.c                 | 117 +++++++++++++++++++++++++---=0A=
 tests/qtest/aspeed-smc-utils.c      | 102 ++++++++++++++++++++++++=0A=
 tests/qtest/ast2700-smc-test.c      |   4 +=0A=
 15 files changed, 384 insertions(+), 58 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

