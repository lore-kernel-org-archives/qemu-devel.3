Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A84F5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OH-0003VG-BU; Tue, 24 Feb 2026 21:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OE-0003SK-9n; Tue, 24 Feb 2026 21:12:38 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OA-0000HF-Bp; Tue, 24 Feb 2026 21:12:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL5xY6wgZXCJhsW5qNWgqsfDUUyq3uLy++FdcPCsx4WQ7Zd/lUyy6udavwMtdwm5PRv61geuans91gfRCB66K3XjiVptiah9yjaRohyzNm1j9AHvm0PNp3iBGSFecVfpWtcu098+GkmsNz/SHGN5lbCRxYwk5VZEwKLhHt8yZQrLX92yZsLhLpBzSHxMCnsVW8784rs+dPWhEcX40So5wzLhetutUQMzZVf3f/ldiED5DgFjZI+C9oK4vmoFXUfYRXWXYzUArNoEt0I2kuXSiALeCshDBNTTTbs9X0AThAU++9eKdinI7HVJz03GXrnYYNBb/z4764+EF8v8dtohCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=WSucu/XC6mVuJMb7nWjoxctZV49ws8kLokxgoMsGnMoTCTmLIvgWnBFvm2yLg0uJenWX/grU5TU4uq1c6WHpOcOd6f1SRtZbmmXvToE/2PwLuDSJbAaoN3QSzu1ESJpKgu0Uy2oY51XARwm3WisIl/l0Gpf8AOWhyWiwYsqGKFDULO3Msg1Lqa1jExMF1qQ1jM6L3IFr+Fb/RQ3RNm31bQ5FvTMOTU5d8e1W6fBEz5TPwsS8kTtyMFA8xM+XTI72HG/EunbFjNLpjsqvaDDEGoLb1K2aFTNLEa2amEJMbm1TTfYd4cL/Vx0xTFX1EjwRTaXZpL1a/vFTPYtVEStNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMRK8DTRI7QK4ZNtlJyDluUy4WDOWPJtdL0ZWv3Ab4Q=;
 b=QuLhiZoRewu5/ydm/5pVc5hll6V2Sd4OFtZt8Wcd9kDluFUOyVsDftMnMQ3x3d5OBd0VFwXEuoyf7vPmswKPCarFDzRjDqxCag22jq7I36wp3y3oS0EEMaAqMKSEuOZV1MLTO0HTmuGDx8df/DLOv2YT0/QlKzlupHr3tYQPMU3+ZYYshINXBsa4+5KBTbPnPQYRAbX3zEFA20NVvfbEeZJ+KoOAiI3UAOiVpzuXYos8Et5GL441eHN6IywjZs4OHjW/2Y+nbBo0RlgmXEQj75OMyYstaTp2ol84wkfP/92TzDmjx00ZTDBlSift5tgnqGMMHaUeSiEbaj4uRGCBmg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:25 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v7 14/22] hw/i3c/dw-i3c: Add IBI handling
Thread-Topic: [PATCH v7 14/22] hw/i3c/dw-i3c: Add IBI handling
Thread-Index: AQHcpfwvBeHk+haxDEquot7dSw2swA==
Date: Wed, 25 Feb 2026 02:12:25 +0000
Message-ID: <20260225021158.1586584-15-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: 48ed5882-7e71-457b-eeae-08de741351d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AZFXWgKVMnJK+7bgo77+8yq/xXwTcbgyv9795RA9TcR8rZ5QsWIFazavLw?=
 =?iso-8859-1?Q?hporSUa1vcMWEk1YOy+Y+6cgWisQPLMNxhjV7qaZpFYGNBHkQvTlxCHKaT?=
 =?iso-8859-1?Q?DffK29YwKUxNskFVZPmFd8/CXUiyZzJcgc7UMJKvEfCYElyt98NMGPLBbv?=
 =?iso-8859-1?Q?23UwNXGVPlzKUAvFHp3YlAVm5eijN9NVK4CufXwi7L5yheAzUD1UvjjoRu?=
 =?iso-8859-1?Q?sd1RDWZSlv+XDZWsAV83ljup4fuFWUS1Iuf0/mzDRrO+XfNusepFSmJHDf?=
 =?iso-8859-1?Q?7SSwH4vpe10oTxwPRHrYXtmNAzMRi4/XED/o+kEy/fPloAl82cECjyKWwb?=
 =?iso-8859-1?Q?jVyYqHZJxYXVh4JFq6Ah+cteBi4g+8epS4lH/SJnoUA8Us8yJnOtoYJvnr?=
 =?iso-8859-1?Q?kWWM5ZF/y7cV3HMsfsbyWYno/WOwM0oE3YmjHeK1f2wsTCzB2HJIkhtUEs?=
 =?iso-8859-1?Q?eyq/5J1f0DEttGYDJxrrw4DZqTfSmZIamvJQIjE+sNO6SeQHdBiukNMYM1?=
 =?iso-8859-1?Q?SQ+OII9MoTxIoANfqCQzIBoZXJjJ8/+wEodBZPgzkdDHK9ZxXO+O/QQgDh?=
 =?iso-8859-1?Q?KVS/BP/QrAgZCC+Q7F5I6PEAQFU08/fpj8XA6vwEjKAvNE3nvWhf0VNv+a?=
 =?iso-8859-1?Q?U1R4FOQI0SgY7jIlg7aY3ZYLGWenQ6WfsEKwdSdsrUjZdl/7YaitQvMAG8?=
 =?iso-8859-1?Q?Z8HJI44l1yjKUIVJqrsEWf7fV+hPJmyOBxw1f6vIERenWfiQkUj2ZMY5t5?=
 =?iso-8859-1?Q?PcQEkLas42EHvyZbwUCkbV2nofUL5MI7Gk7HxTPZ9nOkwiNLT+4OIY1X97?=
 =?iso-8859-1?Q?XXVpgBPauLIHK3tsOcuROPlF/ZxwYTmUYZcGdHIoQQJG/iBP1p/rNJGwV6?=
 =?iso-8859-1?Q?wFiDciZ7WM5Z/89mUupDb6yi5oyRHNfTtvsZ1lh8O0xZ6Jqk6EvsdasVr5?=
 =?iso-8859-1?Q?/UEw0h70SSc2z9jdMgpUK7H2hNetNolJAMvFOqklDSklagyfgonj52bGZc?=
 =?iso-8859-1?Q?NiREDje3Kz8zFsr3SnYMiVOBSNGNlLEzOe8WnicxLUnL3SOLOEMW3QRuGs?=
 =?iso-8859-1?Q?Nn4nSonL8CBHJ/kmAfHAIXkLLlPyqWLoJ4PSoMwAlZpcSGV476wuBhTCHT?=
 =?iso-8859-1?Q?n9Gkt8W4Go6j2obvaRsQJZfzDRyhkxYKKZhqJOPpAbdXTJ7iJsMt8fGxyh?=
 =?iso-8859-1?Q?Op/SOrc98S0SPcl1479PeBpwXGS0XNoMPPTns0gFMbJ2WcudVpk32EhIRm?=
 =?iso-8859-1?Q?G1YuMyXyiZ4RcoRvsdzWcsO+y4Mn0q0cEfTlE+OsXURXFH6xyIT9bbjyYK?=
 =?iso-8859-1?Q?EfSoLDNWIvl5xWyNkju6uFVT/F7Mb+/A4l++cVO+cZjc2b1P4wQGXADcIK?=
 =?iso-8859-1?Q?0tIWIl8020lT3OxoO99YAZc25BRGv1FSkppQ7+oQ5NCLkZtrbpMPXVIXPG?=
 =?iso-8859-1?Q?4x71didea1Y5OpDF3JgcA5sM7vgkTIMIFm9cLezzilco/dCwYP8MyT428/?=
 =?iso-8859-1?Q?byAAwXTm/rWccFRRTJGeWAFF07d2IvDIxtUbG5uzOxqKUx2N5+UjrChl2q?=
 =?iso-8859-1?Q?sxuzNHDS7BxcbGGlgAF/J9Mcq/EvCVxdDQiGhLUWuewi5TapmitLhIZV0a?=
 =?iso-8859-1?Q?Z/T9SbcYdEjy5CYyZ89e626G9qd8ucfKBidCKL/5JPhM2zuopP6tCJ0bdl?=
 =?iso-8859-1?Q?yduHz5dC7PQ2HDnsVKzJQWZALfKS3lisfJqA+5vD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q9gnP5iFADmpOjYr2HEi0aB/R4rb6eP8tFyjd05Q5p/ArqHrQxqyOJgUlW?=
 =?iso-8859-1?Q?EF8PjkUkXfhe9toP6Nb1bLe9/NToHlw/RXiuMMKFi9MY4W6YI6M3+jk1vi?=
 =?iso-8859-1?Q?KcIsV07SxusjOExYw8+0/4S8+6xgTQWpgKoU2KLzpFTdxnkyh5cXr6NZLz?=
 =?iso-8859-1?Q?9gnNN9H1eSPpmPoDBa9epW5s0L9tEA551ACOC7mnJyQsnNtRS9TtQa1PDC?=
 =?iso-8859-1?Q?PMzy0tTj0uISwvP8czHb4vTtJcVZeZhBpEzEWMALshq8oJzuiR64m0hDW/?=
 =?iso-8859-1?Q?rzB/FFBEHPr9nCGfdkHlNoTFBzYh8B2vx9Qv8z1BCno6bxduqNcALE5hqU?=
 =?iso-8859-1?Q?FxY8ggOy/N7CCGTyf/RvitY43QH+oOONPmu/P1EwLzkLYS9wEweO0ffGGp?=
 =?iso-8859-1?Q?+GWtwVPTW0S7FEE1Xat7jbyza4YkWB1QtSTdTu2EBDuS093tNhNIUVb5Hb?=
 =?iso-8859-1?Q?zpveV5lahGXfGP8SjAN32rn0KiuGzw+xO+9ZJ5PC5yqgubbi3DJ0NM9DWi?=
 =?iso-8859-1?Q?YqBMMZXiksNBlS6/xNcrYttzsOLzsPQ/lTCdjD0oMb6EFNQKHDPbxHXn3L?=
 =?iso-8859-1?Q?Ok8B++ilhuz8A+2hR5kfbbSrv75H8xWW8FhLpARGh/ijk3BjghCPwRnbJA?=
 =?iso-8859-1?Q?V34ZCILlzznLoUaPnCX6gzP3hyamWXLJFkRrjuYZUjHHuYqjZFEl4yOBYn?=
 =?iso-8859-1?Q?nZsP5xqZfhMMHq3sB4ZHFo1qIa+zoyZTQ6V/fzEX3NicGssNomWQcqJOYy?=
 =?iso-8859-1?Q?MOiDWc1yiA7dT7o0/fAWNtJU5T2ge/PjIXteSQMLn+CdBBA9su1BN5mkKw?=
 =?iso-8859-1?Q?QHg29CweUHiBRhhclETtm1BI6El04okRNeRxjopq5K4oO2RiA7OOQ9eWGG?=
 =?iso-8859-1?Q?AvntasEJpy9i/2WB5V6Tirs6gc5sGN2iimeR1UguWS/5wDW8xMt1lvku0Q?=
 =?iso-8859-1?Q?4xMtZ04aPpvc+Sd3cjLLEzE5TQq01CD+bL2PQIViU60EbHXcunTHE/mcE6?=
 =?iso-8859-1?Q?MUqXx2z7iVrR8KgWycyXmZqeSd1ebByfotiaDl3fq376Wk/U32UWZin///?=
 =?iso-8859-1?Q?WlZZ4qknhuu9fIh5jjkwuj/sh+cFAI+3mAUrNpb4wBzL/yW1qxSv0ssVNy?=
 =?iso-8859-1?Q?FlSk5LrPlxYx95TsOUZAtYcbdkhZI9Rnonk2U5yXuAuSdn+XcYP1ZjnFkZ?=
 =?iso-8859-1?Q?KEcEx31sg/THtYzefJDoLlWBMSey2c8QwzCrDicniHJ++AQ3Le8jb3wrem?=
 =?iso-8859-1?Q?XDg/zRbxd7CHZh1fcihXgLMAzNZvXKY0ghqsUplDtkOxPrxm9bfpnltePl?=
 =?iso-8859-1?Q?j0v07BRj8ZAAdKXT6fSZl6nx+a12VeChaHed/37iFfoabngiY9DpiRttur?=
 =?iso-8859-1?Q?mvpDoqiuP5YlxsRZtpGEXYu5XHNxbdTWMvnvc0TtwePjYOTLcIoxYqajmt?=
 =?iso-8859-1?Q?HqT5zU21NiHTKMgGFzFhfmALsZMAG6VzJg5G5j21gEeSsPDYXUQQ2aAx5Z?=
 =?iso-8859-1?Q?i5k2DA20NqB8NdV8+AQH4YT2tL+XM5oDpDusdr1nOUTiJW9rHHK9Wa+77M?=
 =?iso-8859-1?Q?amSMKZ4bkrFxQHDq3QwPHCiuhZl7HaPBTsIW3ynw24DsUkGJfU2K0e/jmN?=
 =?iso-8859-1?Q?B9vC4CfPqIDlXzkc1EnPl88Td7rg50V3HnNRjWez44VJFUtOWnXluP0rUM?=
 =?iso-8859-1?Q?MWSDQ9X12v1518NSVWrHmGfjKyozkb0TMWPZ0fvhA0d5pHzeJzhoRsoe8C?=
 =?iso-8859-1?Q?Ext/Nse+jaTLcoHo2aDN3j29CEQ211/JE5HyZ5AVfm7RJXsUlAdTpn5Zt9?=
 =?iso-8859-1?Q?c86Xs32oCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ed5882-7e71-457b-eeae-08de741351d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:25.8652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qLYQbEekuWRRinW2owXchqWDpHAC1eb9hYSiJOYJYnFpuiBjhgDoacNztydmJ6NpvOD7JNCzOgIPyreqxCbfC+PJMWC53PA9iNt5Y+JnIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

