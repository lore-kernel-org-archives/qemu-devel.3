Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFC9EFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLZ-0002NW-17; Tue, 24 Feb 2026 01:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLU-0002Js-Oi; Tue, 24 Feb 2026 01:56:36 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLS-0005Lc-53; Tue, 24 Feb 2026 01:56:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIrIN3YpFsKGF9w0UgBaZzWt2yfwt0Nt8gc7TNgjNUMge1t58mfS9YdD907eElF830iSuuEkvBOQ2p5Ze+CUsQtYVnou5r+mGu4EtEl5ryc8HF12BMeSNf4Cmjaj4XSOmHk5O1QbjqL/mmrieWTSwxI0biFsu7te++64HHf0p32FQ0MN53Xz9At509m39gXGmXwDPtGN1zYyBsxokRrlk++myIhR0J5ta5zFxr+hprLDnuU3dBMby3nsBbH4ZQIN/0CVNsWGev4Nutwrgzek93iRX20CxDxmLHKO0Dvk/pvXAXyvbLsQWjBN+2bYVZ3oA/nWI0G5KQtCwhQT514Swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJN2DxV6emGfvwifwTHf2a9x7ynAuuwY/ZimtnSTUsI=;
 b=kwciUrPpivm5bP3YOzwZg6BkXwxT10XRIultX5t9IYWOJEvHPTsW7ZislrZYRhK8/O24I5Q/uWVEMMnLCg+O0t3t3B+OH6Nyr0UxoWkBRXQtDyphgEFqIvVWvQUcAJDByqDofNBRJkPolzREFulEDWHgj2cmRCyCn76FeY6lMUZSD9DRG2PNAOA4QliZJduelDSRpyq2PrFRt5sKiDdGDz4FS4ArzVmnwOPJTlkyz9wFJOSNMqfc0g2l+dnNSPnQiJX7Mx32EdMLVOmmlV/Vs/EXHk5Dqjut2DITnG1EGbbsIw/+FcIyWagDtueeiHQSyFDNHPzD/jzlDM5wKm7Syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJN2DxV6emGfvwifwTHf2a9x7ynAuuwY/ZimtnSTUsI=;
 b=SJBKn07ih1gSCDJegWTyVBTTPvb/cgv7142WeYX9+ccTGj5XReqFRL7Jg/QPdJRzmodRIcX4TVwIyoa3QplXnbt+CLA6zRzuqR6K0uKg2czvMvIeDfN9FUf+g4qV6OSvY0jqibUwS9PfIzWe3SMNZrGm/E0+bk1leC2bu4Aw4uc7y66RdBgjpv/r7dxSUrIXPRc5orb++cTTzH91epfAqxI22Ocq8pYaCpz1kuZ5WVd+Wyxlu6BfhqUOgea5WV7MWAomcK3XUFYtamGpqx34qgOG/LujLwAAyXvTNCZSF2DJH84eK8vVwn99R2VH6tOffMV+oFOBEpkLV4ViQOiUfw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:15 +0000
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
Subject: [PATCH v3 13/15] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Thread-Topic: [PATCH v3 13/15] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHcpVqra1q8Jao2sEmkBPdk6Ph9OQ==
Date: Tue, 24 Feb 2026 06:56:15 +0000
Message-ID: <20260224065556.3847942-14-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 35d6ab66-e42c-4d3a-9256-08de7371cdd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GGQQNuMfCaF/I5leSxK6qTFaQJI+uEgD3diQrEdJtNj1ZxuLhx7tOa9U2h?=
 =?iso-8859-1?Q?FTmMF+bz10Ai3hBhq6KPyRaF+6UFLJcgqMh1fe95IgTPbgvu7iEZTwpXK9?=
 =?iso-8859-1?Q?9EsmL+KgRuuif1wFzwb2CvFxYKXezw6TWS2xWrHHv4uQWymT3S1RCbtrQI?=
 =?iso-8859-1?Q?LaNzRU7af7n+OtMoM00ZHPHzwpS2nYlySYaguze7KYgmq8hA41b9Fe21Dp?=
 =?iso-8859-1?Q?MDOcL/R93Pv476huRvE3T8jXll7BXIJz+SKiesyufoDjxN3SI3PFKtnlAd?=
 =?iso-8859-1?Q?x6+EwdDF5NkD9UX/g/mIFMU54iorg242WQcqmqRQ6L60+zcLERRGW7GjAU?=
 =?iso-8859-1?Q?67F+bWtZz5C5G9TJQ/SgyaQm6Rq3pRMT0Jo198EGdhI7s7PluzU8UtXUVC?=
 =?iso-8859-1?Q?FvzDZaHOecaKPdtsjccHZr7MS4YKpcQJ66D3AmRx0nEAHirrj9WZIgLBvz?=
 =?iso-8859-1?Q?71b60hmxhVlDSOF9jJs6KuY8MYxFAOJ68MCjiWcs8tO6Gc1OplyYimszCi?=
 =?iso-8859-1?Q?4E8EkZsGHo/v7kbHY48I52tnwa7fh0opK11EhqlFCFusUEw4agCTfqFMKv?=
 =?iso-8859-1?Q?G6qCKRZtO0c9bloqZx7kxpbx+4JXeFdquwKbRwipSIBxTfW0jxADEhpOLs?=
 =?iso-8859-1?Q?OE3RSBoXRygCrDfOEw+ThKY09ngczKuB5Ewtkja2d8FIzzmqgdaWD+QU6/?=
 =?iso-8859-1?Q?5UC7BD4+chBFDc0rTGQBQFdgPlCRf0kZgeJ5F6Th9C7m+/4vowAw5IGe7o?=
 =?iso-8859-1?Q?S4t4rV3+A+ql0etVsoFI0F2jrlaf8iixlzmVjD0Sz5zs1Wvdf7sLqKKCDg?=
 =?iso-8859-1?Q?Gk9UZ2fyL8em1idnt4XVMEtqL5ZcGfq+zrjsv71P1TGdd74kvYBK/xpYJU?=
 =?iso-8859-1?Q?lOIF2CSfMCOTfGT+Mq3SHytkixxoTDNZfPFIMQQcg+wnW+Y2jjVGepMosY?=
 =?iso-8859-1?Q?foijseGLS0irAQpR2mqCuwKFtdgUhuthohwxyKdXfi8Y78LyvxWcyOctq+?=
 =?iso-8859-1?Q?ZYhtj99XmdLgR0cSKcPjWLqRfsW63I6LoRWE40+WTyR7FZrhFnJAUUEJnz?=
 =?iso-8859-1?Q?DZuBxmsvfazXDByugOalcX8nV9htgEGDGNYa8rT+u9R9TtK/OYJZk9lCzm?=
 =?iso-8859-1?Q?f1NX1tY8VAycFjotpJb0Y7vHAByJZDfH3dxlZMhw/rUCQUC/6MoJB/z5EF?=
 =?iso-8859-1?Q?24hOH7XtJC49D6YbX/zFOjHaDw8WaVMsB4RDCo/vJCsr3sS8aduG/GVBlU?=
 =?iso-8859-1?Q?ajkbCBK1KvnYSPf9CMPs7OjkscGVGv5LLPwySS6RC+nZaDgQGX/jnkPD1M?=
 =?iso-8859-1?Q?hmhET7KrOCLpy7zFIZQCrMyyWDAFhyQWn7PBBqhwbT1JslsJ/0rqM/HCxE?=
 =?iso-8859-1?Q?8DBQgqVbMdUwKc48AxZOwfHffcRT/S7+hA/KgEIuoFrVuPKfWaU2EaXzun?=
 =?iso-8859-1?Q?20dDlBWU6mVdF8cgCpzHzzXMjZgUaegbyB98dudzIoa/o+FI/UVqrYNd0u?=
 =?iso-8859-1?Q?fBQ9aPm7ne1xJu8t/6WCVcJe9M8516VLbOxr5v5TzpE7kxk2D9z3C9r5Xx?=
 =?iso-8859-1?Q?Vi2RmFJzHevgg7ygbrXmTILRrqk6iMMnZmVG11Bu8oUMyWvm7XPchpoPVH?=
 =?iso-8859-1?Q?f0gT2SEc/C2qoTiIuoD2TZStz/BWPX9POsBJlnTc5Sv14mWJ79ajOh/+L4?=
 =?iso-8859-1?Q?5xsTgO0Wbdu9KGqS8VXK8XlMPeS5G8FyHUE9p6Pt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cN0eFJ2Xv0iisngb3D8nX86ZPEio+fIt5/kYgOpdHKrK0hL58yCy8h+gd4?=
 =?iso-8859-1?Q?6yypZC8/pvek68jMBaULg4YciiuzYMTxqxtvmytLUjN00ca+fuMaP97EoV?=
 =?iso-8859-1?Q?pLq0c83TCDcunTfO0LTSeWDZzMQjf6Zdy/T8Kw/72OE5X/FL0Cqo1NEmhz?=
 =?iso-8859-1?Q?ylsET3bydpKVyN/8huO1dxPua+LKG1y24G37Sw+dcxvsJnXorfphrwul+7?=
 =?iso-8859-1?Q?/wW1TXgPyToaz1jXzsmeFkja6ftn8xRjD28EzdnXiLE+SxH871nEetJHcV?=
 =?iso-8859-1?Q?YRZ2Z4BusQwWOY4g3f9PSvJlkYb/O/wPR5P2IXKxVJJA/pxl1S/AqC1m8T?=
 =?iso-8859-1?Q?PGIcXWydTM7V9adt2Qo3l2/mgQ+c+eaUV/Hq3y77AblcX6PYZeG5qe+OcP?=
 =?iso-8859-1?Q?2vSX9IVt0hGxsfBHBOV0da/68gYxDAfHQsOxuHLbOWJa3QwDXAiv4F7n8C?=
 =?iso-8859-1?Q?qtcEdKtgGts7aXxtvRchLRfZG9ikUB3EgJxbZ1kq9az0bqYZUhy4Lx75CS?=
 =?iso-8859-1?Q?lBZ1nsw1SXLDHgvYGsTFajG1RWoVH+fT4duzNSwHJZIAF5H5ThSmJq3xF0?=
 =?iso-8859-1?Q?r5xamkiOobxvHbFz6GQU3HpIcmQIuLAWvpvGKelgtn/M9RQGF0MOMLHXP3?=
 =?iso-8859-1?Q?DEfVwmJuDENJCVFt+sXnKMKZWj0dJtUFZmqYzYhiW3aI2/vNjU+trrUi2F?=
 =?iso-8859-1?Q?DK4kbsJrJBwzp0uL3xgkWEPdBia1+4bRVWe8fXUm/9+/CjpBGTr7715LDS?=
 =?iso-8859-1?Q?ArGjtGLVP05SpfBpHEe+mfpQOXgZjucE4rIpzFnU6TKPSU+vX9YxW5iIZ8?=
 =?iso-8859-1?Q?pu26cqy19DhvMgE2cAPWFpg6an+qeDoaGM++WIm19v8kE+ErK+0WHypS+p?=
 =?iso-8859-1?Q?rZhYa5s5YoLNFQyIhfcEeYPM2ecNpWqF+lzfU6uYIh62byoFa5qZGD2MXy?=
 =?iso-8859-1?Q?PECpZIfh/D7mgArF4dyC/BFg+CT1rntTxxO1o6MP042iPYaNeHKH5tcg/i?=
 =?iso-8859-1?Q?wVEvyta/xdGe34pefogt3t4NTCE9MX3pzplkcy66wKSu7aXah9SEdWsrSe?=
 =?iso-8859-1?Q?qZgXbR1xqkI+Gjx1SkQnyF98wkhF0zSayVkt3Z7skNb3t++gge9GLK6GsS?=
 =?iso-8859-1?Q?RjCW0+tK6wbloR1igNr/aqSbRVx6dhyfzfoSG0LiXcRiD6785oeR0LKQGp?=
 =?iso-8859-1?Q?PImzu8EUMmkymaUQFzHNOB6CaZ2UVE80J4XaYRVFxXs3C81yP1sjJeypVl?=
 =?iso-8859-1?Q?LEZvyhDOck1hk5kTbQxGQz/X3CGAKjWy/h6fUJ1K97aDMPQwm5PL1rJn2Y?=
 =?iso-8859-1?Q?BRgrSDN+gwk+WPNsVPs0VQWzPInC20Yu6ytVViDU8gpTpcRiK9XItzw6we?=
 =?iso-8859-1?Q?w7DIPrUqwYR06MjOgC89+4GNURpDZEkccL4m83CYM0argKzidCh4i6vHC0?=
 =?iso-8859-1?Q?9O46kLZLbPU+GTxJsavSrhStqjS5ZUk955oT6EM2qqezfbY+VfkveKU9Om?=
 =?iso-8859-1?Q?kC7DqKrXvGgyAKetZBB5pruMvyeBPd2//x8S4vwZcPKrH2Tv0OdxaQaz+i?=
 =?iso-8859-1?Q?S9HVKTa2u8ugP+mVgAkfSJxSvsYRoeTEPQqPUUHBsqH8Qu9NIjlq1UELn4?=
 =?iso-8859-1?Q?vQ/nR9+ujttInxfREddKGHZCCxZNAfPmo8Q2Q2alFaSb+XI6TNN0VXYm1Q?=
 =?iso-8859-1?Q?eYRLOQCBdIY52qrwdNlXWw2bE4AqLmXTLJANtX/MXzdpXvmvmciufP/7t3?=
 =?iso-8859-1?Q?Y88JipU7ergH/moPPPp3qUOYbpwzdtL6o4dKkWnNy7jpaBvO3qc8t5miv1?=
 =?iso-8859-1?Q?h3LtDVvaJQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d6ab66-e42c-4d3a-9256-08de7371cdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:15.4883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5YW5JHBdfcVJ8/iChSOdG9e0n1m6u+k9SLZ65A8ZaQPuiQA9EkHeiZyvd5en3IFRBM70y4F55DZtYA1ZGWIiP+/ygSe9ABmTP4MiRxLoMc=
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

AST2700 supports a Data FIFO mode where flash accesses can be performed=0A=
directly through Data FIFO MMIO offsets. The Data FIFO start offset=0A=
increments by one for every 16MB of flash address space, allowing the=0A=
chip select (CS) to be decoded from the Data FIFO offset.=0A=
=0A=
This change adds Data FIFO support to the Aspeed SMC model and introduces=
=0A=
a class callback to translate Data FIFO offsets into CS indices. For=0A=
AST2700, the Data FIFO offset is matched against the segment start address=
=0A=
of each CS to determine the target flash device.=0A=
=0A=
The SMC register region size (nregs) is also extended dynamically=0A=
based on the number of supported chip selects to cover all possible=0A=
Data FIFO regions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/ssi/aspeed_smc.h |   3 +-=0A=
 hw/ssi/aspeed_smc.c         | 111 +++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 105 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h=0A=
index 76831422c6..640efade94 100644=0A=
--- a/include/hw/ssi/aspeed_smc.h=0A=
+++ b/include/hw/ssi/aspeed_smc.h=0A=
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {=0A=
 #define TYPE_ASPEED_SMC "aspeed.smc"=0A=
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)=0A=
 =0A=
-#define ASPEED_SMC_R_MAX        (0x100 / 4)=0A=
+#define ASPEED_SMC_R_MAX        (0x300 / 4)=0A=
 #define ASPEED_SMC_CS_MAX       5=0A=
 =0A=
 struct AspeedSMCState {=0A=
@@ -116,6 +116,7 @@ struct AspeedSMCClass {=0A=
                            AspeedSegments *seg);=0A=
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);=0A=
     int (*addr_width)(const AspeedSMCState *s);=0A=
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset=
);=0A=
     const MemoryRegionOps *reg_ops;=0A=
 };=0A=
 =0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index b9d5ecba29..ed6cedabcb 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -163,6 +163,9 @@=0A=
 /* Read Timing Compensation Register */=0A=
 #define R_TIMINGS         (0x94 / 4)=0A=
 =0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO       (0x200 / 4)=0A=
+=0A=
 /* SPI controller registers and bits (AST2400) */=0A=
 #define R_SPI_CONF        (0x00 / 4)=0A=
 #define   SPI_CONF_ENABLE_W0   0=0A=
@@ -212,6 +215,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[]=
;=0A=
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2=0A=
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4=0A=
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08=0A=
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10=0A=
 =0A=
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)=0A=
 {=0A=
@@ -228,6 +232,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSM=
CClass *asc)=0A=
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);=0A=
 }=0A=
 =0A=
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)=0A=
+{=0A=
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);=0A=
+}=0A=
+=0A=
 #define aspeed_smc_error(fmt, ...)                                      \=
=0A=
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS=
__)=0A=
 =0A=
@@ -758,6 +767,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr ad=
dr, unsigned int size)=0A=
 {=0A=
     AspeedSMCState *s =3D ASPEED_SMC(opaque);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(opaque);=0A=
+    int cs;=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -783,6 +793,18 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr a=
ddr, unsigned int size)=0A=
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);=0A=
 =0A=
         return s->regs[addr];=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, size);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return -1;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1156,6 +1178,17 @@ static void aspeed_smc_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&=0A=
                addr =3D=3D R_DMA_DRAM_ADDR_HIGH) {=0A=
         s->regs[addr] =3D DMA_DRAM_ADDR_HIGH(value);=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        int cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size);=
=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1989,6 +2022,39 @@ static void aspeed_2700_smc_reg_to_segment(const Asp=
eedSMCState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Convert a data fifo offset to a chip select (CS).=0A=
+ *=0A=
+ * Data fifo access starts at 0x200. The data fifo offset index is=0A=
+ * calculated by subtracting the data fifo base offset from the MMIO addre=
ss.=0A=
+ *=0A=
+ * The data fifo offset index increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * The CS is determined by matching the data fifo offset index against the=
=0A=
+ * segment start address of each CS.=0A=
+ *=0A=
+ * Returns the CS index on success, or -1 if the offset is invalid.=0A=
+ */=0A=
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,=
=0A=
+                                                  uint32_t offset)=0A=
+{=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
+    uint32_t start_offset;=0A=
+    uint32_t fifo_offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < asc->cs_num_max; i++) {=0A=
+        start_offset =3D (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;=0A=
+        fifo_offset =3D start_offset / 0x1000000;=0A=
+        if (fifo_offset =3D=3D offset - (R_DATA_FIFO << 2)) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -2023,6 +2089,27 @@ static const AspeedSegments aspeed_2700_fmc_segments=
[] =3D {=0A=
     { 0x0, 0 }, /* disabled */=0A=
 };=0A=
 =0A=
+/*=0A=
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0=
x200.=0A=
+ *=0A=
+ * The data fifo start offset increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:=
=0A=
+ *   256MB / 16MB =3D 0x10 offset steps per CS.=0A=
+ *=0A=
+ * Data fifo start offset for CSn:=0A=
+ *   0x200 + (n * 0x10)=0A=
+ *=0A=
+ * Examples:=0A=
+ *   CS0: 0x200=0A=
+ *   CS1: 0x210=0A=
+ *   CS2: 0x220=0A=
+ *   CS3: 0x230=0A=
+ *=0A=
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)=0A=
+ * to cover all possible data fifo regions.=0A=
+ */=0A=
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -2042,14 +2129,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->flash_window_base =3D 0x100000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2083,14 +2172,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x180000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2123,14 +2214,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x200000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2163,14 +2256,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x280000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

