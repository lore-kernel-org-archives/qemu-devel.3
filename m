Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1087E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8w-0002Ux-Gz; Wed, 04 Feb 2026 03:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8u-0002TD-BA; Wed, 04 Feb 2026 03:21:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8s-0003VZ-Om; Wed, 04 Feb 2026 03:21:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVGQwuksJ0Wji0oexYJWDxDl7bltPBJPvc29QJD7NEFoCR/V47dLfFFf043lw5fk0OusuF2+9PWzkJ0xCpiF8u4a/ocBYT/Ufa9zQYk4ScobVsGc+xOFFPHpo2O/L0ie8MHAbP+lQDNp0MALyYLMUyIILaBjas1aSc7w+RGtXMfGrZTBk+Xyk/fwgNfP+81qXYzhTQeLCmXtS60GEEeokjJPOiRgjNnBDgK/VtPwP7b6lz4OrO2aKFwDcSHGmxOYnLpu2fyeKs8soeByjZj4l4YfiOzmFa4TG7dWC7wRy/0vm1roCEGGP4KvwvuohFKVW/4Ltu8k0uvl+1lLvi6zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytz3zfLW7V8rItJly51VPj1XRWkJSY2A81UYK728EJM=;
 b=qjs9fmmxiEVsrBMaX11LS5kpJrMz4kBn1d0FU2XT4THj//8Js581lMFojmKMtwoPFr7B22kXnO/Xl1PbYXMN0dGD+JFigQWV10kCB2GB0Xhs3VapM4SID3QbzDq9HM4C4sJtAGWG8JPjAeC73VAs1G1IoMUXIbP35pQwfC3oZF1GJDvp3f22IPLRAnly1ISZ9mSSxNzufGJXlLr80OyosWLqQ7j9rk12qMtH1laHPbeGi4PTSVHh57ap2il8XJhkPMwI5no9BZY3043kDQGrjWHJRK7s3c4P5fIi613N+uBOzE+b5TGp4y1BoKMhFBGQCUq8eFS1e2qLJ87w9nmoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytz3zfLW7V8rItJly51VPj1XRWkJSY2A81UYK728EJM=;
 b=MsKoDXAXsMHoV7+/cEBkR8WeWOxABGIM/yglIwBafEhWyw2/hywiH5V7OdfybYCIgqk3GXQNaesmiP2VK4kKYgC4H7x8xyyD3ASQHLeH7xZTQHgQLExzxohfzF8QQgRBx2z6A071Pzp522OAUN5QNbRK0g8tfCsMBqVS8q2sx/Nl9z/IWzNyh+UYEbZKb6G3rMuPaYaphzG+Rw1Pbh39nSDNsPQRlOcvTVLDZC7C2yPqnCsN+W+1xQIrCTdok/l11InnWuwyfRCIBnNP6v5k+aTauv5vt3DYI5gM5WRrySQXdGJJowb3BNaEaQfDQeJyuu+fDwENUElz5qM2UGa9IQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:32 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:31 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 12/22] hw/arm/aspeed: Attach SCU device to AST1700 model
Thread-Topic: [PATCH v7 12/22] hw/arm/aspeed: Attach SCU device to AST1700
 model
Thread-Index: AQHcla9E5BXMWeURokmaKL2dF9XElw==
Date: Wed, 4 Feb 2026 08:21:31 +0000
Message-ID: <20260204082113.3955407-13-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 14cb1e5f-bea5-41ee-c552-08de63c66732
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GUoNn6ekfnzqvjlc83P6MC5eLJFDsx1fh7wpbzNWi0cYlYU7gYB/HJ2/O4?=
 =?iso-8859-1?Q?0UZcqSH8vQEru98r89F6Kvk5bSgqOGtan3TIZv+y3LU0o5hwVTDld36f+U?=
 =?iso-8859-1?Q?u5dGmvQdjgQgFsoL0eC50kJE7VWMtz67SosJuOC3MBI4DZHXQx4WZjYL5O?=
 =?iso-8859-1?Q?wcndb05B0U8GJRDYmzg8NZWk6Inov4YS0F0udSkQoDvbaw6XqpC4u7we4c?=
 =?iso-8859-1?Q?e/xdyaYlgEDxNk4u+SjTFX3KANgAUnw/QN0PzLc8ZDoMOSFcDZlOvWomiK?=
 =?iso-8859-1?Q?n4mYltjycCxHJRQlvnGuxTw9SWjWI5d45xwd3kOV5JHzURAv/oTQelXxw0?=
 =?iso-8859-1?Q?+iyEKrmrrln8iJQnDF5T+qephXe8JxuDkAwuphPToXaVAOAOmyHL7vFSV0?=
 =?iso-8859-1?Q?jLuxbVt4KIO6a1pBfvE5kDjDWTiRJoCACe//AnzZl5l/nD5tN9t9xKky3j?=
 =?iso-8859-1?Q?SM6SaI4foHTp5lTNEdGUQUTcD4eOml3kbobgucIrIqm3NgjAnzx+7YWkuJ?=
 =?iso-8859-1?Q?794aHxiAGWDdAWSF7sOHYZyi/73RW2peucu+q7ubm0vpYQOKEeNQaCKBGG?=
 =?iso-8859-1?Q?erluUGFpMwhEcxfGMI8+HSj1oQRecIzJ+kd067htu+w4sBaY6l0qKYMkwl?=
 =?iso-8859-1?Q?WWZ7IFaIZzZl0zGG/r6LgxciPmdK3Dryx6gGFUWo9FklXutMUy4qWUBCGO?=
 =?iso-8859-1?Q?wEJR0pR2omrDgeFucQuC0peHnA+0wNL+r7/S4K66EKCr6gEIGoY9B93N7/?=
 =?iso-8859-1?Q?2TAj9dFsoEGFhyjgXzXlyp0wfuw+MxMcJCNXlwUloK83j/KAeSfO7BWa3R?=
 =?iso-8859-1?Q?QPYqQcJv1V4ib4nRwKJfhN11GxKdkFlnXrRKVGpqmnDLWPraJvFOekPHvt?=
 =?iso-8859-1?Q?84uBwsNailMCWe2hjm9BueQmnnB8gT+Yg0V/RuqT2Q/y5zxetEP689X0Pu?=
 =?iso-8859-1?Q?hquOmIHPVZMqNpuHJG1ELeqLh8bDHOLK6Faqrs58vft+uqWG5c6YYpEyVL?=
 =?iso-8859-1?Q?feIWmDpibS8EsM1ua2zD64csOtOxLcr6FCp06ufRDHxWmxg6bY51a4fZXa?=
 =?iso-8859-1?Q?0SOueTdy0YmzP5ZPsMXC036jou03E95fv6t/fvHxpgakEUK9pViyyLCWEW?=
 =?iso-8859-1?Q?aNE0Q3V243/iehIDRXJlTqpfeXSTvsftfjkofdtCYxyg1/08gbkJ70UQV+?=
 =?iso-8859-1?Q?2EFagAAKho+t29B303Z+iexSHKVAl5cW+vyDqGOacW1AU3tiO2kUyHSyHS?=
 =?iso-8859-1?Q?fVwDbQcbcLLAYg2cnsf1V+eE58HNWxM1vR58rtwP9YfHGhuL7j9jMHiQt/?=
 =?iso-8859-1?Q?5VR0q+bO7NXEkLkNz5kNTW+BHKAeHpZFu02rERwpdPaVDbZ6qAoSOKhEFk?=
 =?iso-8859-1?Q?f4Z5nNUz7NiCdx7ZjmO9t2YmplI5GjN2KAxhMnCEApkcMwHuCdDZrhhpPG?=
 =?iso-8859-1?Q?cbWbQiTrMCcg65Kp0zpJBYQXb+Vl1JRBIjByEoePK42Mi0SEs1Q3yB1DEh?=
 =?iso-8859-1?Q?EQnrq9oQziaCby4jcpU00Q0pMKUyWVgnYIb1u/XVCtfSMS/mlAnI0cDbVl?=
 =?iso-8859-1?Q?CaFzu6ia/bWvJtTOJXsv7BdLQRZDs+iBNxJha+8sxZtVXTrIWjjjz47E1O?=
 =?iso-8859-1?Q?KPa2wuat2dW2NuitL+5ZKorNbByCX/+DthE51s4gjkweEYOW+tY/klJBk5?=
 =?iso-8859-1?Q?Qmt5Gfo7LHplk0UtjV0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n/dD+ecPbbElirE1F71C4CnOdWe2R5dWjjwHfjNRL+hkCCnvpjk7TFt/uj?=
 =?iso-8859-1?Q?iLXcvJ/BFU2Apsd4wF3WKfjmrSnFSG1ORneEWHwFNCUcqgjVbQ4rh/SW6Y?=
 =?iso-8859-1?Q?e7HrAfI8oVD7WPt0+E0XS8ZP8FrtoIiqrSTSe8O0tmyeXvpMFqRh3uNE7Z?=
 =?iso-8859-1?Q?ty34bne7RJTTx0bSTt/rBlqu0WCQxAd/HgjYfljGRliqgU1iJHailHXivb?=
 =?iso-8859-1?Q?mvwU+qM+YDRMQ73AeBk72tCC4gFp/aenm4rmsw5DICWub9WvOmBdJLjG6k?=
 =?iso-8859-1?Q?Z3gLPCLewS8L7uyuhjBhf9AakVTmCUE6W/qrM0CRTwkPcAoISv/iwfpBHw?=
 =?iso-8859-1?Q?5rsEQz+f0UMEWaMmisy/ys2x8OHxbedQ6SjPMHrynYDjRD0Oy9imw98c18?=
 =?iso-8859-1?Q?P1rR/OgxwzqyfdjP7uYMsnkZ8KyOr9gkBC9noIJA37vqM6pYDKluh1qSAY?=
 =?iso-8859-1?Q?WfpQXNwWKz68foGKx7k3Uc9FCqVJjqvRS5yFR3L138lit65aNok0AtHyb6?=
 =?iso-8859-1?Q?ycWnpZxv5fgkTlYOf7AGEbN3McVZqEMqBEqGwWQijCsYc/GwTEBvTViZX8?=
 =?iso-8859-1?Q?1J37MpkkahI1A500wAba4C/Xp/RSKnEciQaKghWw3sxqGB8SGFMM7tPucK?=
 =?iso-8859-1?Q?Cu7wpY+ZlUX0lXhkwEdKo5Dhw3rxdl/r5TO6uuDk3D2fLgQeeqrxfrKwp8?=
 =?iso-8859-1?Q?Kd2vMbraMric3phbuVIAYR+vn0/bgnijZ4r6kM1AxdXSr+IoVRdSRz9Ptp?=
 =?iso-8859-1?Q?2HdQaO9XcmhyKy7RLphtjFEEdhKLLvNKZlErmVyKwJAvKOjnMjLjf308aM?=
 =?iso-8859-1?Q?g2xOTpGq4S1HXVebL4Cl5bgR937/CtTG9Up50zqFRd/7WSu28kS0UiiyGJ?=
 =?iso-8859-1?Q?3Npjs0mSeeduFPRQMIFr+iFaWGPd+Kx2S6LpFshPgolK9+QaPNpVNaFg9q?=
 =?iso-8859-1?Q?k1PfdFhixERewJhwAXuRZ6ija725rHLI+/Sj+koCpHRj+pTHihuH4Isdgg?=
 =?iso-8859-1?Q?azNx6kbaot84KznhtVPAWia7mFS9HduRkFsDzFHCwCKqeUQk7jltFcVci1?=
 =?iso-8859-1?Q?jZw2bEtloRD7iZ8QvAPGYc421VzVkGzaQP0QlZ7YyKeRB8v1NJQJcRvf1g?=
 =?iso-8859-1?Q?6EPRxcBEkwEFwCs0U1RHHOzetr/tJEKYCyEToWuyT1KWOjaH/SqLVZjhph?=
 =?iso-8859-1?Q?wTSjSmPJdQGWwKxeMWBOFu1LY7rFCuwMuFwtQUokqqqC2oNtGrHiYkDSeg?=
 =?iso-8859-1?Q?IdLpbi5cV7tTUMab2LWhNRnhYLqtrboYu5+Jn/mrsZ0JEO4sJWdT4kdAx4?=
 =?iso-8859-1?Q?FIUt0VYraemibz0oVvV0n7tHS1CZtd6Q4ekg58bMtFmkNEyv4/Z9pNEwSV?=
 =?iso-8859-1?Q?YxgHvQraYqR+U7tvqT8av75aOY4NbR0WcDdTClJsAOwA5R6YaMxxsLjNMr?=
 =?iso-8859-1?Q?LjCgWZ86+Yb5XmsRpzq4j89rwqWxLF/UZVXwfUWUJBAlggd9P+qIrQmOKi?=
 =?iso-8859-1?Q?j2oonFj2Nxh6OHlO3lvOfXzaVe1k9qClVL8/4yq36oXprIX728xjnwcHxA?=
 =?iso-8859-1?Q?EamOlLC470xXT2w+TnQqA4EPYuvtiy9zDBN6s3Pv0ykeikou1tD8BgyvVG?=
 =?iso-8859-1?Q?p2KhpHmRoWS5Xr7kyOZ4TCq8ksgMrBxH7Pu9x0L1lBkGmnKaVMaRg6FbkH?=
 =?iso-8859-1?Q?LbrLKX7hAwCjOeiYLxnYon1SYHq/RFh82+jFRYUzgoW9MaM9iTzLmhwKlO?=
 =?iso-8859-1?Q?RygdSC2BT7Ki4Z/80GUitfr4ZAet/iPaMwW7n7NuM7VHXc+Zgt6Y5RReLg?=
 =?iso-8859-1?Q?4wDVwzR7Iw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb1e5f-bea5-41ee-c552-08de63c66732
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:31.9203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Kw3XhhGMEMpRCA0sdH3nHQ3PvCaALvUIMbOoZjvgw+3N2SN7+CJTYx1CLFKgjVYVGICr7929oiq0ZoURR4Ynas1a7x3Rn1MsMOAPS8I36k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Connect the SCU device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  2 ++=0A=
 3 files changed, 22 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 441655cee7..65f1497a2d 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -9,6 +9,7 @@=0A=
 #define ASPEED_AST1700_H=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
+#include "hw/misc/aspeed_scu.h"=0A=
 #include "hw/adc/aspeed_adc.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
@@ -24,12 +25,14 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion iomem;=0A=
     MemoryRegion *dram_mr;=0A=
     uint8_t board_idx;=0A=
+    uint32_t silicon_rev;=0A=
 =0A=
     AspeedLTPIState ltpi;=0A=
     SerialMM uart;=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
+    AspeedSCUState scu;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 17577ebb5a..49a242f3de 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -20,6 +20,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
+    ASPEED_AST1700_DEV_SCU,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
@@ -29,6 +30,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
+    [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
@@ -91,6 +93,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0)=
);=0A=
 =0A=
+    /* SCU */=0A=
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+                         s->silicon_rev);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -116,6 +128,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-adc", &s->adc,=0A=
                             "aspeed.adc-ast2700");=0A=
 =0A=
+    /* SCU */=0A=
+    object_initialize_child(obj, "ioexp-scu", &s->scu,=0A=
+                            TYPE_ASPEED_2700_SCU);=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
@@ -125,6 +141,7 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
 =0A=
 static const Property aspeed_ast1700_props[] =3D {=0A=
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),=
=0A=
+    DEFINE_PROP_UINT32("silicon-rev", AspeedAST1700SoCState, silicon_rev, =
0),=0A=
     DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 5086d4c51e..cda841e103 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -508,6 +508,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
         /* AST1700 IOEXP */=0A=
         object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],=0A=
                                 TYPE_ASPEED_AST1700);=0A=
+        qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",=0A=
+                             sc->silicon_rev);=0A=
     }=0A=
 =0A=
     object_initialize_child(obj, "dpmcu", &s->dpmcu,=0A=
-- =0A=
2.43.0=0A=

