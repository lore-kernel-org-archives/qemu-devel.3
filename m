Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A91F55434
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4O3-0003OG-UM; Tue, 24 Feb 2026 21:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O0-0003KI-4U; Tue, 24 Feb 2026 21:12:25 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Ny-0008Ty-K8; Tue, 24 Feb 2026 21:12:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEq8tJOXNc+SiNWwSqTH/hUat8h6MD5Xgmw4ct9WJrtTfdrmsJ0vqc7BDEuoyKMRLJXXQPkIQZ/TT7u1PpfhDQA874GSJRbYHg/1Xztwt8bGTq/2D4jwNcGo++WSqtwyE7iqb3IKGmTxZSfl+uBGCcxmS2ogJGp8yRVxdK0HzMVQbb6kZZFlJgX0Okn8IlUKhDh5LHcFWjenNi6w20Gnns2037o7pgcI/grQMueC1tpHmLHtNo0gcPx5Dag3HPTK7yHtIqFAq0yBdJCsGQK6g0SeSMuoFIsEOH+GwBCdX3EA5MgKpp43wWb3wHaev7vKVvdtSkpWL8OprZ+lAHjJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=PD6S5aKrZaQ0lyE4AQjly8EQq3JYlnPuVQna0ra3i9unOo8b0a7h7T2fuwpYPQRZZdWyNmVMbRdTyelRWqDDOj+PVaGeYentvbFQrdH3b/dvX7iq/6TK8swqvcB/8jnF60KgiGqBQ5dLEnWJZb02QHp7oc6eAY3nAsNapzR+0dCzuvgdTVE3JR/n7gvm+7yoMV/lZtHb0/urufAA8RxWWRcBFMQTsBTlo4s9OwomE+4iF5GlK5Elny+xG5ur5EQmrfRzJpKcfWf2YuF64tadCiya4VAbDaxlXVM9RE3PTB0Ox7Pk+vWG896zTcz0mcR1L9RUVEVhl+MfoifKsdnx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=Vl0+imKqwJzKzWdrqVa8sdnIhafSWMpvIhQEIPxAT8Cj/lpaGrbvnE4wLPDXcvVUMZO7YuvQNYYjWeoyR+WJuvcsJQXsk4CZwsyED/a4dgf8UETSy92fYJxGVgc5NSsZfRM74255p5K5EqQA+mwBRtKBflxS4bnpquFj8jwSrBY6mhoKZKFB54t9xD9HDg0WgqXM7whqqpOLkZk6M7NFh2FQqf6xVBLDMjRQ9XAbiWaXO2m2xSG14XCA5tVjutGLcT0nDaAMHaJ3Ld4Rswuy2cA5IsbyjU9+bARuLUYf7mt8R0DNXlUxgR8sa4noP8jaV4u6PNq/VyN4OfqjGQge/w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:10 +0000
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
 Venture <venture@google.com>
Subject: [PATCH v7 06/22] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH v7 06/22] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHcpfwmbejtM6vi5ECGIhPIg4h0pA==
Date: Wed, 25 Feb 2026 02:12:10 +0000
Message-ID: <20260225021158.1586584-7-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: 3e2ff889-c1bc-4152-b269-08de74134899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vpFXrkfgh5Fmvi42IC9VT+Gl3szPPIm2m4P/RBbt0lKIwl5T9oB+wvq+sw?=
 =?iso-8859-1?Q?MpcBBUcgAWhVmkkOtfSoFtcASSgPDzldALhgtn9TBKLoqc7V7EtwKE5Vqz?=
 =?iso-8859-1?Q?dl8Iny+4oPhqi2piFvPAwLfvDmFr28CrtyfO69SbW5F1CDRXdAI7w6DXOb?=
 =?iso-8859-1?Q?YryOphxMHO2W+N0WqGCmrTNOhKWcXSmS2BbLDG8WhGIgk52uFX/cGcO5Yl?=
 =?iso-8859-1?Q?i2q6wFHieBEQcIH+9Vv/7f9ii1p+ZsyPiHFsXgiEm47msTHxbvtTtH8O+b?=
 =?iso-8859-1?Q?N9NVDBPeOLIhmZVqbfvc4TbuHh4vPyqLnToahhCGWXOh7ILb3cNBKvpsL1?=
 =?iso-8859-1?Q?sIZ5T3zAuiia1p2Ynx6f5b4NaFsX8nJ5rC2grw0/eyZbT+BBQMqAKah0GP?=
 =?iso-8859-1?Q?NuzzLOSuPrVkeobB9G4Z3ZTcynHXQHCtDHMzKNFDR2uGQDAHuDppOP3v54?=
 =?iso-8859-1?Q?0VU6NOPHnzRnaS5IeLJYnI6VNMDOhvWnz4NLdTJhUrDrZztnIElbk2BSx0?=
 =?iso-8859-1?Q?Pi3KFjBWKd73HwSFGdffBSgsj/YUVcVaOwN5GeGQELpt9qofSoarCg6AGx?=
 =?iso-8859-1?Q?ElfHhPiN/QeIKcnynalwoD/+217SMRkfYRLYLMRqUA8+bwkS3394k8uy1Y?=
 =?iso-8859-1?Q?JdN+sx3HY99QsulGaXzLwXwzYl7DgHELGR9EZtVnH70nBcQqpBGtGqg5Vs?=
 =?iso-8859-1?Q?cj/JlXyHDfIX1S3V69IAG0CUV2JECBLYfhofYCCN9/6LGhjkuCQ3DMoJyA?=
 =?iso-8859-1?Q?F+zmsb7FklQhianleB4C8qCp6EWiluXyl7YyTOqvY8Z+SAO8Mea4kKF+F5?=
 =?iso-8859-1?Q?Wh7j82Sp/Uh4d2q1yeMds8mb45fCEpO7XV2zNdKOmssqz2D//XM8nq8VFe?=
 =?iso-8859-1?Q?zrXsKtDzxapSThSGZXoDvPRkEsVWPdGRekxCxiBtf5VrkzoZnZrumk+DqM?=
 =?iso-8859-1?Q?iAzNa2tnO2l0CdfVBC7GCvgR8X5X38Sn5+ReIk886Ikc6y8Nhpf9Azhvml?=
 =?iso-8859-1?Q?jSQ4AFmsT3wer4pkzLmEq5ATUu6dKrmaxwwD0i0tu2zTFDjQPz+ASA6U+y?=
 =?iso-8859-1?Q?qD7BiioaclErlVM+4opMTCaQsukxGtiehywjI0VhlFx0D6j54uxU/cdABx?=
 =?iso-8859-1?Q?K06JfP98f1LoeKoqQP0ixb8MX/MHQFXASqBzuBurFFjLBUfRF9gK4l5iP/?=
 =?iso-8859-1?Q?SQu8+0UQmBDrZZrynNadAzgfp2z25Q2PT9hJVfaXcLqpDBnWDHpWqLXkQo?=
 =?iso-8859-1?Q?M7JVKiSptNMbBOnBn1YLnOdXkOKTeriH+TITgmaQlVCw+5rkvDyn76lSX1?=
 =?iso-8859-1?Q?cNw7BAiS0DMNTMioQTCKHrwb+RkrTsdKD8E6sfQbP90d2ENGb6SbrQ2VOQ?=
 =?iso-8859-1?Q?EIyd/c0B8LPJUBMgCleq4yTBGS228g36DoVJ9InNcKKodw5ZYTR9jvnpXC?=
 =?iso-8859-1?Q?8VQ+EOZkfAQ4CEZEaL6fliBICGCASmNR27ecEpRCp+WTxVPc4AAvQ9yA2r?=
 =?iso-8859-1?Q?Qm17x7ph7qlk4tDIDIFs6fUUuntI9ZGksU2JV5vw6mO5JmUaHtjGeWGUaU?=
 =?iso-8859-1?Q?MXJQBcWTPCOMLQ5SSnIC4pLkHMN/+yV90uzuDrB7eJiKtuUmBApG2eVbS6?=
 =?iso-8859-1?Q?FgfkzlvG2APSJzgcFQDaTGxzkKY8ER/or2PTHMv+QVVmV9WsBle8dmFTV/?=
 =?iso-8859-1?Q?MyEt1UQ2DrNuwEHjno7rT2Y8ERlE/lhMRDL4PvEM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e+Y9J7muSx12/HScv0MCxmCAyksY2c4WVFDg7Ef+cLFGq4FRPD9qhiGE48?=
 =?iso-8859-1?Q?CnknxqetEUdKnLMW76IyGmBnQGvaudRtIcsVg/F+73jo7S0vzvA7oatzbz?=
 =?iso-8859-1?Q?vEp1TpzwlYhf6iFHnJsr10eM/XdWAO7UHO73c85MGTcms1AovXzAV0IDhw?=
 =?iso-8859-1?Q?IVIsteIWS26yeOTYXBnExWY8rDOeSCLIVgAxp5uwIXVis78FEPGx0ezsmR?=
 =?iso-8859-1?Q?hxzSFdwevgRkhsd7qI+HeeAy1OgbnPXxDC4jy+g9kp3CdKjKJ6zY5DQeUU?=
 =?iso-8859-1?Q?Id72uO/7SuCYUxTNcrdnOVlSJPgWWKdbJwS/agHivKVKFUwYt0HJDamRcO?=
 =?iso-8859-1?Q?66bIuxxEN5CaQWpKfZbPbFWhUW0SGdHufyZKQKRvOZndYGkUUUrAUBAFoV?=
 =?iso-8859-1?Q?C7MAbW/Cm5d2H9hXWF+RvZkfmaA9OKqeJbKjnZ6HxVxgk5SK+UydTJEDzy?=
 =?iso-8859-1?Q?TJeagm4REEK+2r/lyfJuXBLpC7X76JxGMpuxqfw3J18Im2r6Qjfn3yUYGL?=
 =?iso-8859-1?Q?osEC/ZoMwQeEOJINn58tJW8c4/Rz9rKDJTYEsoPgzja9UUDyoKAd6aTS4o?=
 =?iso-8859-1?Q?96uYogGPSQE0nVfCbQqbAptO6EdG7Z2UHzF0a3wO6+ARKHOXEstSJRK3rZ?=
 =?iso-8859-1?Q?2wIx0ycrv3mbWkzu52c67qMstr3z3Wfen8jnOAtq6IfO/9aeO7lmZGpbC4?=
 =?iso-8859-1?Q?jeiGJHaB+grncFZ/DOM4TMA0+4fRegcKdl295+p6B2IHQsptMWZBifjU2P?=
 =?iso-8859-1?Q?YQZAiXUD9tzys1RGvySzHeT3WCarAhvox/nLKZUmlbVqJlyuTZmgSWYjst?=
 =?iso-8859-1?Q?+Rxh74TqMFu3cbqNO4GQQP6Nb8Di6Qkpevm2Mc8j8kYlVhlb3hKJB86atY?=
 =?iso-8859-1?Q?jaX6l6K2IwKiXWme+zDbqjbIla3vTnfFrldG8ouNmB5THI9Gc3g0mR62fX?=
 =?iso-8859-1?Q?Sxvt5WIwWNF6iFRBzzIKCLxtYIBhOPnyK+Y7bxXtWyNsgdkudrfKcbYLhs?=
 =?iso-8859-1?Q?fK7HGef5LYCH+fgh0vjPbywRi4qPgAAjggvTjDHSMuJHhcLQJnZrpUiZ0w?=
 =?iso-8859-1?Q?67cNbvFGNy1hgGnbUkeVsLvCivPPEOcLVuIxrGIUTy1zeavg1ohhFeulXd?=
 =?iso-8859-1?Q?Jt1xcBrZKEWm6FR+kAnYUYoEEu9Ou0Td5FZ7QXAv6vb8gy5Sfoo5TeNTL3?=
 =?iso-8859-1?Q?67slD4ZfqZGe733GX4qEtHsi0GzOHDpxi54rXJX14QMbw8pfAC4hNdzZTF?=
 =?iso-8859-1?Q?6iL7S6Zm22S4UFDYPrdOyXPN+7z/CKP+qwPgeD571fdH0cniE4EwfDOltr?=
 =?iso-8859-1?Q?ytexC1gnpDqQLSgoA9x+PZXQ73huqp0R4DOxOVYIzHwb03Ruu4ByrbN/6s?=
 =?iso-8859-1?Q?dS9ivx/gAuQnbn74LMPbO2MvVRG3hNQ4GsSFO8lUvMnLS09qRI94tX4uNL?=
 =?iso-8859-1?Q?thSIJ/g4b1osrKUqvZITZQ6r7oxhUeWRgbIN/eYtNuVahOFP/eMuS9fzQz?=
 =?iso-8859-1?Q?yRq78pR+76DqPMfZHI4hbnxcshwF001jMU6Q0EUM0qclcBQtUu9dLazSKA?=
 =?iso-8859-1?Q?Ey8qb+rnERmzkVrHeCixO1W6I5TwL5sfWk8BWBiPKJVo5CANpmnBRZU2Vb?=
 =?iso-8859-1?Q?OE/EpHRq5kiMcMNlttZtsXDprBsoqczbeWC42w4cbvV8ez83EB1CG1ZlZR?=
 =?iso-8859-1?Q?Ly9maM954beWBtGLxdoMYE+aJUifQswosh1Jac8iM1PfPmBf3UXGxXs/rA?=
 =?iso-8859-1?Q?HNqGoyrQy1DgWC1CZ2VKFjeobQ2RE4XQgYu1bTDpcNwICrV/5Lnqx0oPow?=
 =?iso-8859-1?Q?2Jx9Jxpmfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2ff889-c1bc-4152-b269-08de74134899
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:10.4142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuSbT20ssjsoiv4FumBDge9tb28JHn7HNCsYgA+glujeDivoXsK1HVJKUY3b1DJH8E4UejnZK2lNnw7NXU6srqrjfE563WlwghfwL4EhwCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 647074d181..a215700288 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -21,28 +21,58 @@=0A=
 /* I3C Controller Registers */=0A=
 REG32(I3C1_REG0, 0x10)=0A=
 REG32(I3C1_REG1, 0x14)=0A=
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C1_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C1_REG1, SA,            8,  7)=0A=
+    FIELD(I3C1_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C1_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C2_REG0, 0x20)=0A=
 REG32(I3C2_REG1, 0x24)=0A=
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C2_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C2_REG1, SA,            8,  7)=0A=
+    FIELD(I3C2_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C2_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C3_REG0, 0x30)=0A=
 REG32(I3C3_REG1, 0x34)=0A=
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C3_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C3_REG1, SA,            8,  7)=0A=
+    FIELD(I3C3_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C3_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C4_REG0, 0x40)=0A=
 REG32(I3C4_REG1, 0x44)=0A=
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C4_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C4_REG1, SA,            8,  7)=0A=
+    FIELD(I3C4_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C4_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C5_REG0, 0x50)=0A=
 REG32(I3C5_REG1, 0x54)=0A=
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C5_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C5_REG1, SA,            8,  7)=0A=
+    FIELD(I3C5_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C5_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C6_REG0, 0x60)=0A=
 REG32(I3C6_REG1, 0x64)=0A=
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C6_REG1, SA,            8,  7)=0A=
+    FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
-- =0A=
2.43.0=0A=

