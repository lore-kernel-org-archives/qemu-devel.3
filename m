Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D831E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO5-0004gc-8k; Mon, 09 Feb 2026 04:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO3-0004fp-H9; Mon, 09 Feb 2026 04:16:55 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO2-0007IQ-1p; Mon, 09 Feb 2026 04:16:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLi2hd1/EvJ9dGiprWNZPB2ZBVesT7tqd2VQHqVlOuDQNCw9SNv0elNbQaIV31amcu71vUzvOLHCyZdrx24Zxy9JZJ8I63HdyGjGqoOe+Z5/2993fP2ITtjh9DHmf3ZaWKNX5CE4jd0ULMzaVHsjvv6+ig3A7zflfcvvml9jdfHyjPHQlEfCHZaO7271p/lJjb/G2CEbYoR4HdSQxOlVdiDJ0K9JnH134GGMq71NCrNwiQ8ievel2PVPoshgP41w1hhqpXI2w20UyGzuuk/w7IRYlbqdMVZXN6UZMixjb9INXqkLs6l44wGUlavrlQ/7q+X47woMUsEp/F7OkOyl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rPIgrRMAiWfOBIiOtHINGzQxTiHr6+LVFGPQxU7fHI=;
 b=BVwQi+gqZ0Mku4ue3rUdC6ytUfqEQvDR7o8dPoDj127wXMll+1AxhQlJ7apNuWl3jNUunoKiaeX/9NieIJrbtiDy9gDDNCdFwLVkvm2YR1v4WXiSGQIpmFX0EuKdNXNNEcUigA7DLhMLeFtye2ahAHY/W7RGNUfcDZuq4TeEtE0Ilr3UwHaAKs9mtqxv8JMqirvbEtIoJGwG0CVD846k0f8Aws8f2DOW05EZZNf3jdOfWTinMLF/y3eRJ0EvESv8kBU+xuu25FlfG3d4xrWnrarXPMFafPR4bIb7S+jsIC4zRAvt4UTn1byDQ2kq0UdT4bREUxefopJ2kyXT6VAqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rPIgrRMAiWfOBIiOtHINGzQxTiHr6+LVFGPQxU7fHI=;
 b=W+Zs1Z8Rz3oB5LqDxzsforH4cVjqzdYOSM0xf9tmYRsw8MsqeZHrvjmrJIVuifQvahT/e9N9bf9PIF/GAUWvGqqCxqh8c4nePgizu8tPAr9BKbyu5HndmRuQoiqNn0dpzowPOVlkqAdAZllyhlrZaXD6p34AP+GhlmHD4RbhVS738X7PxYsKxy9ItNLbgX9mbuj4xxvKgWYKVG7a7jngoXkRlC6VgFZonKDPIQNJbgl54WebxxPjluAP8PUk/cz4Zq6qtap+zdRiXIzHjL310zQtwUIbuho1g0UklR7s4//A5eJqjSbzhm+JZb0zwq2KkodiPWU7ymNQBp3j3zJxEw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:45 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v4 10/20] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Topic: [PATCH v4 10/20] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Index: AQHcmaTPdi1auETzYEeV2cwgcNz4cw==
Date: Mon, 9 Feb 2026 09:16:45 +0000
Message-ID: <20260209091629.823457-11-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: 3eb58cf2-c6e9-4c24-f167-08de67bbf234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4A9AuWY+qzT8QpeYTNMazZnOpqn9U+TdzP941zZURpQ369cAPOmQHBTC+4?=
 =?iso-8859-1?Q?6e1aXfYTUFAG66x9gq7QD4bczla9fCothPu7FFRl5q4ZvztJtwsROWVcqw?=
 =?iso-8859-1?Q?vgiWEkMTTd7R7BOCPyuMuDa3aopqnaPK76U+YTgmEhiugvVI9vDH0YJBrq?=
 =?iso-8859-1?Q?4zh0rB7/aECuaagnZtDJsSneXOjGFVYpju6l7BPt0WgV13YR7F8dvDeFSM?=
 =?iso-8859-1?Q?yyuNPNryx9SfU0H8bSk8ldi377WS/bvoVyZVdJJLewBa8VYZsTMvVMc5xg?=
 =?iso-8859-1?Q?6ZB3/BGUcym2m/ZXyHR9dw0Ul3BymbVXOjvvJfmio+qICF4C1LIn7LJ4aL?=
 =?iso-8859-1?Q?9PmXppO3NA60mMaex3CBHO8bkO1R65WZ4AYqlO7QkWtAEYAX/lFgLKHAac?=
 =?iso-8859-1?Q?rBEwpxQ84KYfCnmnkzBKHfky9o/vWgbrn01Q7dlnNFdC40YlMzS1YvSl8M?=
 =?iso-8859-1?Q?NGTW26fd8e77UDk/yvTYkRcIqBjLDEK1aFMP9+jJ2pclnYPUuEm5dXjdU9?=
 =?iso-8859-1?Q?zTh4no/ylX1m0wyr8Eo3C2H+W7aRa9oCK0oEQhk0EFoim+fgJX/mxN+Kqc?=
 =?iso-8859-1?Q?by7kYRUlMc/9GqD2IiIrqiZ/tHomvmlqDF+7yOzAaprM6jLl6fEdrHchvu?=
 =?iso-8859-1?Q?T15Tr9LSHiILf7AwkAjzF6LRT+Ln0CVNHFAnQlQ0Z4UPmAUr4OINTBsgz9?=
 =?iso-8859-1?Q?URfa+3XqxV8ETUEbBuYj1k3myzVjNzClzJOhdEHAQ5oQ7ZIDpkIUxSVkSF?=
 =?iso-8859-1?Q?dejr6BAKLiQRs5g5NWsPTSBuf3+RKfrJM9xUREzy0UvNLmnO/IYn8X9kT2?=
 =?iso-8859-1?Q?5JKjX2n7zYQ9K58CqMQvX5jC+Ex7UqMV2mYDROewbkjo3ihorEdF85Xwto?=
 =?iso-8859-1?Q?iv3XyUuq0xOWhUnHmwHV80zmGe3+ICCQXFvGuPA7JZVh9qHU3CdfyCwzzc?=
 =?iso-8859-1?Q?K8R9BMTpkK5JR6JvQGJCQ3OyWVKGl9AgAx7irHYmaV4qppEYIL9z1Hbath?=
 =?iso-8859-1?Q?Monk3qRRWfQcbUg0zBu56S2uWs7Dib0OqJFuzP4a1qc+eLeY5V/vQ+MNTw?=
 =?iso-8859-1?Q?CWUF7PJ3zfpK/c2kd/iFPx6TtskAj/MmBAlcnVVPRZD6caI7LMk8/5bogE?=
 =?iso-8859-1?Q?X84kM7ya75pAOIyCfMwqMLGGtfs/brlBL4hJOmycJ658K2ihYwEQsvrXyd?=
 =?iso-8859-1?Q?jDexmmNF8cnAuu1tnaIWHOCFXk2+8iR7DyKaB+i/qoH8KmhgOMQhloikby?=
 =?iso-8859-1?Q?5Xr3KkK0A8LPvtGnpRbSk1tWcBVST/z3URA9vtUQsdL2fjlOTZsRHdtItr?=
 =?iso-8859-1?Q?gbtn0U1P92kWh9I2WvKZs3kRMUXf5QsifRd2usnph0pObKKuPNX99KfNwh?=
 =?iso-8859-1?Q?xOK7DLgv4v2iWjl4IxCjpFtIuNk7unjznOdxWDj15IlyQjEMkBrbo2UZOE?=
 =?iso-8859-1?Q?2PXceTk+Dyk0rFw1ujAMqKnXAWLA6rWSfHDRU/mwRrkncXosamyHZzjl1S?=
 =?iso-8859-1?Q?AyfShe6XEBMe4DDRTmm0k0PSRbCQzPkQPUG0F58PpD/8WZGfZN3rtYhd2s?=
 =?iso-8859-1?Q?5HlhgnXOSdtpATQ8yg/c/ULHGFdD1GbiSoFBwtZSWBoUa5b7YUbXoRZTKb?=
 =?iso-8859-1?Q?v2s4gsGxjgueMq4b8sAvu/qIQ72xOyb/Ujt95lDSgoZM9RFda28+mJMCDL?=
 =?iso-8859-1?Q?JL3xjWWVhd2sx1N8yQsntioA3RGsROZ/jj9oEsOd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qq0qk54eCTpuc22qd5eTqrqjLXyQjUdbfUUa4Dx11XrjRBCD+/DiPHvkxr?=
 =?iso-8859-1?Q?YVEd/Y2ws1bteIUUa3AVIFSDubq6QXv55uar6AVuK6b3tG5e1Z1xAkqR1C?=
 =?iso-8859-1?Q?iTdq33bcx8LT2K+T1uWIAkdq7vgHK6pRWpyS8hJNdqjuevkGFrJkDM0nwW?=
 =?iso-8859-1?Q?2jMgNcKiqN/U29vzEeRk79WsZYev3IFYOWeCTB4k4Q4SdBAuf9N1sMcvkU?=
 =?iso-8859-1?Q?y4wpE1ZpghTf5wXV758X4fmgr1Ft5Uq/1ciL1AqiF+5yCfT2+jfQsAnZUT?=
 =?iso-8859-1?Q?pHHCJ99xPkGd/xqWvJe5bOHfzgb/+Q7IdcgEboDlF05hjFBMqpUkzlOaax?=
 =?iso-8859-1?Q?VXovxxXtk9HMGoI8tjaVxgVXaxtiPdk7fShmeVcCcTCACelX0gaXOwytHt?=
 =?iso-8859-1?Q?kSFDgMPOU+0IxnW7bBBtDSiq9KW0jpIoHIzUOs+7rzkc8XYy3q82r1618u?=
 =?iso-8859-1?Q?Q5IYxnc5Na8b5WTGfoly7n1KlFime6nTozftHWvuJySvJdTTnxcC3HKGUU?=
 =?iso-8859-1?Q?W8Y0NWJTl51Jo+AIaAMXpUCoyx+EUKgmz3jpJmJXpsGJGmgoplXqCFtBaq?=
 =?iso-8859-1?Q?7wb8MIk6kdx2x/7XbNbhE/IpH3BW+Jb+3AYkKL3vSbv3uGJIaonylj8LTH?=
 =?iso-8859-1?Q?Pfqw7fB5gnWgV3/hUvys8PQveUi5bU+8TbKP+rB+uzFXokmR3KxCl9qGgO?=
 =?iso-8859-1?Q?QIRVS82opXLLypRrf7g5GeKZoeQnhQdRw/DE/WgD7nNWMWHPh5/4Q+C3Ug?=
 =?iso-8859-1?Q?Q0BGvUXHWzFZmX0IeOggt3gsxmEayuc1TS4jiuYUq8/6+nse1nGBHrqjkB?=
 =?iso-8859-1?Q?VD3wu7k0VmXl9BZbMKGlRxeyyByf191b7KqAxxywJmY0eoMhbvKiHSiZ+X?=
 =?iso-8859-1?Q?qD+KxD0MGjHyEloFCOq7myamxTYavNYMl0t0JJjRStk5IQtieHetAi+y4x?=
 =?iso-8859-1?Q?s/HD+fhI2PuIh/rEF1PGUPULcnosxtt5yyRxoHyuxJb+Jum2a+PttYSKtE?=
 =?iso-8859-1?Q?uy5aJSxwcmTICdhEki8PpWWuPdPskJALteoq6+IUoVQc8/kmjFTyrkZOXI?=
 =?iso-8859-1?Q?i90PBbDmJ7MulFssjj1wodVGBn/rE4seU4Tcymt1c0BEUoSi6Zxsq4zkdo?=
 =?iso-8859-1?Q?pMrl58QFasnYFWmCJ9os5bxtLHGdrUX9qXEud8Y95ckL3XGq24KUyOfUqp?=
 =?iso-8859-1?Q?oq/VEWzK+2aY6aBmk++ctosJahxfxpUFLdCJ2mt21gqg8OXdIxJ0QgZV91?=
 =?iso-8859-1?Q?qG6tJbl0RjTeEtH+TP8NIjWNcuGTtFRtu+6efEjfsqL01WshxcKctkn1wd?=
 =?iso-8859-1?Q?DUYO6Qajs5+ofQDr8xvZIwQdVoPHZ8zWzBYbzZ8bKkOaCyQTx2DYT3NG5F?=
 =?iso-8859-1?Q?0DymdWHFajRftp+DHN2axWTKaX8aamsiaZEZc34Y2HxUXHNWzMxMt01T8k?=
 =?iso-8859-1?Q?orXk2sYSR2mKSKvzWkpiQgJjIlW5v8Zma50pDZ957+gt0JLVlwSwBCZtZX?=
 =?iso-8859-1?Q?DYweewyzlrp43zuDabMe+Od7wHoeT2oN3XqgYAWx9xTuzaAb/gODWCiIfY?=
 =?iso-8859-1?Q?tKm6a7ZmfCeOsU5u5YfYC6MQEtFr9B5RZoSZX7tCbZkDG35AuYWHe4/fFs?=
 =?iso-8859-1?Q?GQpcRQmyegR3CWL0zxfmIp98h6UPrrpsoQOFSBfZP13DqxjC0TlakZg2FR?=
 =?iso-8859-1?Q?i2NtMWOEFnN6/A86eyZcLSZ0sLy6l8QJzjKjG4DIvXC66D2iXyFx1CIH6D?=
 =?iso-8859-1?Q?/ylGkgs9WXXz1gbvHfDSqAnMzHqT/K9q6XwpJNUsmUecagXVFfFD990FSV?=
 =?iso-8859-1?Q?6kPhvDl0Uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb58cf2-c6e9-4c24-f167-08de67bbf234
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:45.2748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nH9CHHrVOIwQ4BE3kOuRbDhqlbQbk3N6YGPE0bzaydSMicj7Qfuf4EfGioRB+eJEw65GCTPtfWPlMkqFfZzuQAhM9lq9mHLOy32E7UMYBTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

The registers are only 32 bits wide, so we should cast the 64-bit value=0A=
passed in to only be 32 bits wide.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index e20244de2c..9dc71aa3d8 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -363,10 +363,11 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
     uint32_t addr =3D offset >> 2;=0A=
+    uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
-    value &=3D ~dw_i3c_ro[addr];=0A=
+    val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
@@ -392,7 +393,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
     default:=0A=
-        s->regs[addr] =3D value;=0A=
+        s->regs[addr] =3D val32;=0A=
         break;=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

