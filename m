Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76CE78D73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO2-0004em-Fr; Mon, 09 Feb 2026 04:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO0-0004dG-NX; Mon, 09 Feb 2026 04:16:52 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNy-0007H3-P6; Mon, 09 Feb 2026 04:16:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhnXNSoCVRvp5DFpoTyn5rQ20/oa1fQN2JZA16pOn+Jzmyvhx5Q2hO5UyXdK5VdNkMujG7me2cpEbBy5OeG/9u0hRhSC2tCHjJLcfp48mdCCHqmpopmRzKuhmSojZbmOZ8zY9zkr6UWe/rmc+Wb93a4yOFRo2wM5WflAJkH9cZU1ZCU/n/anYpA9zPcBDUsRLGcT6VKWVjlW9K5U5iLNH/CmoQrOHn5019561qxm5HX+vZwS1GbrYZW76M95fnhm+KBAQPpMjx5hx1CVAbv4FADHMZQ0vLF/6cDC2wS0HYUQK63VhXgoRmTpSmE2gTw9cn67YlznMGJU5M0c1FCzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqtVXo4vGm809PDfJA+YrBscw9VIxdzGLmoLvOQKTT8=;
 b=uNk1O1WL4viqS3EaNqZqeJRoKI90tRlTRpKzo4iUuLpMgZMEJ58wyPp8WtBbE41HP0j1Nsfb1j7BtmiHTt5XbJDjhoA3Oz6WewOFLTh258fqlE2G13BCwZ03WjEicjPKadByDoTs/22zvZ/RJdVAcxy1PUcK8WgoTOw9pKuVNHZEcW2YD3/isuBafx/XQGzulflhs2pg6NM7b3jIFOjSFiQ/jgymCBrvoyTfe6XVF0Iu2/t3o7UdHngMNta+wdejS1ae94o26OZvUnQ3ST4sT1QcrLRN3vBvvwf/ElpZyCJOlXgeWFb7E++g4bIYRUV0lKQXmFIzq+X4cUnSGqwvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqtVXo4vGm809PDfJA+YrBscw9VIxdzGLmoLvOQKTT8=;
 b=gvePgRsYid5qPdpy7N9KPAOvXulMHNs1+mZSvKceHWGyg1Ktea1wDQyFOnWL1HeAl1UM6LeZtnSNKYEUVRKdPWo6gby0ki96TWHH2oK4Xj4b8gheUt659zDvp6leyfVGDC92WI+wL5lzhqV2qZFlhi0vx9On1toATAbPLhtR/vTqiaadEOIYl5f0KCX2pD9OB2jiadY9P53KZWEjV8hdngTYUz5ojwpZu0YVAjE9LdoGU6IYex+MUnwugQmSrtwCVpZg/WKd4KokJ7nMaiXC2R2aU6abF0BZCiDVrg2b2h+0vVkqHcYSeEDMW7yZWpzHPQnqRR/qq9i9RKktW5Lyvg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:41 +0000
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
 <venture@google.com>
Subject: [PATCH v4 07/20] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Topic: [PATCH v4 07/20] hw/i3c/aspeed_i3c: Add register RO field masks
Thread-Index: AQHcmaTMVNHzSYxTaUyWm5ZPf2H15Q==
Date: Mon, 9 Feb 2026 09:16:40 +0000
Message-ID: <20260209091629.823457-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8a9f13bb-a913-437f-0758-08de67bbefbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SG9VQcAWuPCweZUQN8XQcMWrzHTxjnqufNFe5jPFCQpKjiLZ0+epQUAwYn?=
 =?iso-8859-1?Q?xxR4hl0BHGZYG6HHdN1qy064jZPyZAGqaAW9+uAb9iFyR7rZya9D+cSC5Z?=
 =?iso-8859-1?Q?2MBIx2yrChwiCpim8/bIqt4Ij4Jh1zAwRIz+mVUbgX7MBFuoWfiKtogLMg?=
 =?iso-8859-1?Q?8MRTGtLmTLbhGuzlVlr4YWHlJyqalsh2Cv0tGCHTdByFauAlLkAAkxLCdE?=
 =?iso-8859-1?Q?umkaMGMiJ03b5kPZocRq0CTueNPs1anTMFNlZYOWXYnfADHbldjCqiYvFi?=
 =?iso-8859-1?Q?XZ521iU5LS0zf3R+sPFCAe+ZqT78Ioio8kwe6Fdt4ci7qbmGAXP+YBToY8?=
 =?iso-8859-1?Q?fkKeAwObLuMnR46W1WyFyiYBcSy6/ESfvimeNg1kWsvkOz0Kd5uHLU1gba?=
 =?iso-8859-1?Q?a8NZs54/zU2v3GM0si8yltyIm0QeRzLEkzoieTV0RFPtPNcvlRERKtxKuA?=
 =?iso-8859-1?Q?NRuq0VE1Uy3y7BfnectBzjjrUT+N3X/ffaknP4UrpYzTOejNiAfEMlJxoN?=
 =?iso-8859-1?Q?vnQ48U9TItsJdN5fVx9zAXWHH4Tgh4feuNrn0ZENsPAL9O0m4jf9ak8eZj?=
 =?iso-8859-1?Q?iz8Zas4jdDcyw0BuzLtEfU1vt5C/F75EOVTN7cDFavIJVzunRJzDAPC9SW?=
 =?iso-8859-1?Q?GMNBFyyg5O6N+95x1vSGVA3fI2DfEv35uiVxm9/24ONkqTZbaKbPvAXD0q?=
 =?iso-8859-1?Q?CVl4mR4Jtek2avbTqWQEQrHYg8X4weO5M2ityIoYZbmn2CU56/1za5Vs/Y?=
 =?iso-8859-1?Q?xgiRZMLbfUUz0my4FrW+V2vMp4u5o/TmoW8PCBJqi7uVWnUi7mj+V1A6kt?=
 =?iso-8859-1?Q?zJ8UK29ief6owdGiSw1BNGdBEOZr8vvDBfy0ds5Zl0OhXtB7m+dlWbFX0Y?=
 =?iso-8859-1?Q?sgRQ11XwAlrC3N8ewQa1X6m/sHchv/BkvQa3g8r2UJlHyoz0j0CGuyPNJc?=
 =?iso-8859-1?Q?+T0YmpL5nHEoRxef/wBEBAvSSvk4h5m3rCQVTJcQOJESMOyKHtWvvkNQ4o?=
 =?iso-8859-1?Q?O2izFIPrP4CgjhLEDns+7kkit9LD0iSVBIMMrtWAvGjneeBsdb0CAAJrUA?=
 =?iso-8859-1?Q?ajeF2/4dlXJtT91AMogeYXOkkoHQ8x32yYEuGSFTvvhZH/f6IU7KV2SJoC?=
 =?iso-8859-1?Q?bA1j7p8EEOI+hARx615P52jH29Jpb7EYE/wJ2PvHmLHoVrw7WVWt6WimAB?=
 =?iso-8859-1?Q?/2qyYt3LPpX+/nQnCE7XS7yl2CwxrvTfEtpwf5EKF/TLyNdiiBTyA0aXaG?=
 =?iso-8859-1?Q?ugtBvpqTkQXfweonSRiVUuTmItmsbZaLBmYZn/ZPwFrNQpEihzWn/8fiXR?=
 =?iso-8859-1?Q?4lVk++Gk1SSus630MG0CyQHnp3nTRvskgWCh4JR+KETlpT4aOTRwtfAiVw?=
 =?iso-8859-1?Q?SmeYOaan+QGSiB6wEVbVhG/TFNnqAhmvDZuTZaKPsfDhtjmk6Rr4Suv6CI?=
 =?iso-8859-1?Q?kL9C21k+b/MqAQuUlMi39aAssk/ILicpEXyLrOYFotf3/+lYymLUkwPpuG?=
 =?iso-8859-1?Q?CGkX3P/4qlHoUay8buz3PhVejMn81JGviV+Bi9JfTdS6LAImpV6VXmbdQC?=
 =?iso-8859-1?Q?C+rcNfE16oPsTv+f47WwMbSAOv8PS09ecD3a/gjvuDnMQ8ab8BgA6LSbrA?=
 =?iso-8859-1?Q?1fR+cI/oAH0s8IKTmRjKmrarg32IOiO2UkqqxHjr4i8rf6VyxG8oNBeY2g?=
 =?iso-8859-1?Q?chQ13i6//IMxtmLQIq/hU/NsCbm7sknoXIj7VZhg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oVjBPYBT4/+1A3VrsbbYvXIeu5ZUnp9+LA2xfGNIzR9aMt30Z8j+Boj5j0?=
 =?iso-8859-1?Q?bew1NHj1BvlrPzA/SU0fi7RWyilkoSMDdgnxMzWIa6OhxqEFmc4DfhD47F?=
 =?iso-8859-1?Q?gZhAuwBBbaBfKipm3SQ3F2G4uigUGFAlnAx3i6yfsf1JFaIP9AVHYaU2BK?=
 =?iso-8859-1?Q?FAP/s6YCqlq5dr0tgcwzA/LskJI28M6uZ2orJ6w5ez7j1obnRHDEV1uI2z?=
 =?iso-8859-1?Q?FePC/kKKuo1JDSTCQl4kPsTm6zvPxpwjOFxskmCBa4vjDzts89uDdyf5pM?=
 =?iso-8859-1?Q?Hzh6jS7iFZSpqbxjMyjTxN27omXuJs7iMDcscDniK49WmpnAvdCm4MladP?=
 =?iso-8859-1?Q?opA8DasoSb2F+cOK1dA8cPlAM3kWL/CDIpHDLba3hy/+9nJSt6CZn0uZVt?=
 =?iso-8859-1?Q?qSSYEARQQg3Ke017nTr+E6Cz+hOW2z2luyfzJ0JGH2FEnmGDJCDpHHGTcQ?=
 =?iso-8859-1?Q?2joMnvaMhWtgJRuN0+yhh58YDc/ULN0tSmbHYGI2YKzTK++z/x5QV7t9zq?=
 =?iso-8859-1?Q?HIqj/hIFxkSQxGU22yTBGNqfTsQfj/LYxs+us83BdaoYg3uXqZBXbBpUJZ?=
 =?iso-8859-1?Q?ZeH1SrRcQr0sWqiexGAzl2xhXHVchHw31kksKnQ3Lhxl0mK/yzy+hB12kY?=
 =?iso-8859-1?Q?7vpQWN5Uab6yTv4L3fwT4v0CfvB5JKwuT9TYgcb1vg3we7TGuerWQF8gkP?=
 =?iso-8859-1?Q?gH6Lxd/Xs7Xg2a8qCwq4wOile90U4ghHClt9jWtzSzwm2Lvto/HcAw3Pt5?=
 =?iso-8859-1?Q?gwS2TmHNO6/VDTq/56fSrCi0qnFbHwi9UKm57wlrAFKiWRFexHVmxDBQNj?=
 =?iso-8859-1?Q?I+472EwoB+1AvC78BcVRnqzghYvbtI6XIFECYWNdD/yQGVqpdOiOyvX4oO?=
 =?iso-8859-1?Q?UD8TvQAip1bdTbGbRYy5YF4Pjo65cCZSFBqXhwWlvdQZgir5Nrl3Mxj5PS?=
 =?iso-8859-1?Q?7J9JEI8R7LJhhPagvTeXmMXzrwJRA+Q29uFSKjPKHO2mObwv0vIhPbwH5+?=
 =?iso-8859-1?Q?3/BKA8RtAGBNK4DUC+0BN6joI+QNg5KQZwHoKn5YAMAqi+jthBwQdGXQ6x?=
 =?iso-8859-1?Q?G+ozVZdrRFmNYYWsqbysS3ksYTvqBxOhv45gQyHXYUgqAQnepT3+QQKSPu?=
 =?iso-8859-1?Q?aN9apzl7XoLndZUPPSWS3HtCF9nGBfnb+3thNxys+bNA+yVcyyRy45gOqc?=
 =?iso-8859-1?Q?yorsiMedayziHYaqyeDEhSl7z18HjhCxmVHFusJX6Xsv5VShHpe63Yi+6w?=
 =?iso-8859-1?Q?quLp0V4KHVEICaiU6RWQxNZQHNNWE802jC12A2a2ihnyMUygJXK6cE9zMP?=
 =?iso-8859-1?Q?2Dqp1YioaRvvxuRpNpCkiq+LECnffcKhJH+ul3n7XYeiyfc8UdV4UrahQC?=
 =?iso-8859-1?Q?B3bqb0xhLAYpG6+TxV7gM2PpYitwKwwxKXRtTmdRtJ3yy2gEff4TbjVQcC?=
 =?iso-8859-1?Q?VNgc5itkdAL4CmzBZ/v1C6x6M0KAHn5PXOiPiacPCnyqTty12+eSxDzTYX?=
 =?iso-8859-1?Q?Zk4K6Io3H51QIUfoKTnpg62hY7AZlSdgY4CgUQo4e1vg3fQH6USl/S2YxV?=
 =?iso-8859-1?Q?lnfhIJR8YxIT6C7BP/fHw8ErdwJIRVgoaARtQ1ktwTrr1wWfbw76LwdMnZ?=
 =?iso-8859-1?Q?/Ax84riRleH+5IBY7h0dJ2KO8xWwTLQWY54l3eD3W/3W3jr1oCetS37MJj?=
 =?iso-8859-1?Q?JbO45lrSqKIeGPzVJsQ2ISkAYicq9X+050G6u6gkIwaWAS2Kw6DJnuLnB3?=
 =?iso-8859-1?Q?dHOhjIaM8hQM0PFPkXdGKniKQocq2GRAAosfn3xk4xmLiWwF4gePGMliWA?=
 =?iso-8859-1?Q?S+bozHrntQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9f13bb-a913-437f-0758-08de67bbefbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:40.6275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+Y0OaUPwo+b9fCGfIC8dzNPVM84v6tngUL4ynvlNFcq4TJY22dedPmhnlC0sqsM9kIYgfkcwhyt0Ae07qGMpG5m50pgJkPXlqbcw98K6x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

Adds read-only register masks for the Aspeed I3C controller registers.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++=0A=
 1 file changed, 16 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index f0352aaca0..bb41493c55 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
     FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] =3D {=
=0A=
+    [R_I3C1_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C1_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C2_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C2_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C3_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C3_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C4_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C4_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C5_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C5_REG1]                   =3D 0xfff00000,=0A=
+    [R_I3C6_REG0]                   =3D 0xcc000000,=0A=
+    [R_I3C6_REG1]                   =3D 0xfff00000,=0A=
+};=0A=
+=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
+    data &=3D ~ast2600_i3c_controller_ro[addr];=0A=
     /* I3C controller register */=0A=
     switch (addr) {=0A=
     case R_I3C1_REG1:=0A=
-- =0A=
2.43.0=0A=

