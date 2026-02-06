Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E588DECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOf-0001rc-Lg; Thu, 05 Feb 2026 22:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCOG-0000d5-28; Thu, 05 Feb 2026 22:20:19 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCOA-0008VR-CV; Thu, 05 Feb 2026 22:20:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgUQKpY2gFtTFeJ88It3VfKNXpl1nrWXazCoHJEnplQQEA3W9nWDjLUxbnwLQIs/HCKznPrEsZHdmv4Bqd5t/nPvGkV6eK+/icH2cBc+f17aB6NrXEFKrzuS9yJlnh2LRZKCRUhP/eqZuINGDPaXrh0RsPv32Mt9GzVzEi9sUgic4U7QM3vuoN+rZZHzOALNB37D4Ed3cgcnHaKXqqfAexX6U2hV6L0XEnkWcXHW39tmQOcai7GikQF1xO1fhuVRVPU9Bf/4f+zEEds7k+AetLSuwOsn9LhdWEQyTfBC4CXxIVVgUdfFMbTIiW1tTNcIpPbf+mmCb8/NGMR4qWfD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=IQ8p3wDJMKEP8jlkCoPrsuTK8Wor7Sg6+PW/rUq7nOQV5IIK7NcOeRRoff+guWAi0cg3SRUD5Bf+kUSlWZeozEb5nIlTT+0JJ46bXiBMAC6Jqa9EevYainvUAo8eJTJxsfeHrC4X+txMH4iVwstqfSOh56/tJVB6ad7DTw7VfF/FJbylYTJPcloTonGVCTEdE1/zrF+aa6s8CA0TrHZWt/N3t3r/fDy0PvYNiIrwgWxrNXO9IgBhGRaoRaCSHG4CVwEtODWXk9K/xZoqGbglFwWj9zamIqzMQ+WJnF06Upney75iDAt5A81ZBTuXpajfbel85rJZUfqs5o3P/VLj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/POID4vn3hJIrgGxh2Q0TxFbvEOWqfR6BvcMHnLlHNY=;
 b=nbfixumYasbi8uCDou6DNVL1tK7BleVUx9f+S8o1Ju7ViMuD+TbkmAER41EN8HSbSltonjv/IqnIZ5WdxWoj6T2nHGjxGNFgtV5BBsP8NfZZddWqtcunEriVOXYHoB66tav5eNU1mgYbxhDkio1IffS/qmFG4s+TIovQ3epgTYEdwPnnsPSpIEWOhX2Y+ZsrGQR+dNB9+LEBfK1gHzS+gGBXynhoSLKxkfhOW3rAFuZ9fVatLyVtAFGi/P/sWlXB2Q9rw45l7hyXd7MhcyFrOztR1RDjq/Q/WnyZwgI+fYzaCb7qa1W4lRM0cm7kYSe1eQNBNnM64gfqzwEBkFxu6Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:56 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 20/20] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 i3c functional test
Thread-Topic: [PATCH v3 20/20] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add i3c functional test
Thread-Index: AQHclxd3R1mpPmKciUuxRSxqVknyNQ==
Date: Fri, 6 Feb 2026 03:19:56 +0000
Message-ID: <20260206031926.3227848-21-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: 1b4debd0-4c65-40ba-4bb7-08de652e9a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6fuQRWH6pWIjb0NEQhn4CLxjOo4SuQD09SxuHWjvSv0Kn9+hM/XuDVohU1?=
 =?iso-8859-1?Q?laiojA7ZFxwgRfVW4rS1sf1UO5F/Pr6bA4KDK01NTOfYr2YJKkZcDLQ6GL?=
 =?iso-8859-1?Q?JKzSYV0OUTdmJgdSNso57OEWmFT0UMtp+0cxAP7H0wxIcdZXn2dl5VjSeJ?=
 =?iso-8859-1?Q?D+01XhyW6HlxtREpqAXkug/LnJIzeopWVKE+m0GiwIFtDlDZa9cBfCiiLf?=
 =?iso-8859-1?Q?wskM/hSg7kWlqpHImBV49mixZmIrnrWAJ3czN+wEMAxmk+idw1sOzfbKmB?=
 =?iso-8859-1?Q?txHtkiS5T/qY9jO4pxUH/sVSIcpc0Y99InIgUhBLgjrXzd45y+atns/Vvr?=
 =?iso-8859-1?Q?TaVgFlVFnrbM9sy6g2AL9yLBWCQOZK80125TlwPNIYEk/LD5uUgdszxcDz?=
 =?iso-8859-1?Q?It67nYsYA4L9uz5BJYFEe40u8pmDlzvyYERO9N/oabvP0swa/BueRk4I7A?=
 =?iso-8859-1?Q?0fQwxE/tTc0JoRbaDBCvDDJosNMvGtleK4PdMaur+hHqnT0JCbV1HL8uO5?=
 =?iso-8859-1?Q?cRiZzMY7UGI4wCJzDNkUht/3fv3s7qpCjXB2glfGonJrUaGgDZml7L6gCy?=
 =?iso-8859-1?Q?CdlpWwwW9fD++TNqfJFt8v3suN8/SOfuKI+Vm8EhwzlTlmRDWWz/bchZZD?=
 =?iso-8859-1?Q?EJR2//vnEVxR0gdSRGqqB2hZ+xdJqXguH+nucN/VZzH4a8b/H5gCg0ZHn6?=
 =?iso-8859-1?Q?B//MqysXOhPoR49jTwO/A1ZD44QkCbzVMr+fRzoLss2/N+FKlu61od0cGw?=
 =?iso-8859-1?Q?OxW+JDe55V3DPT4GaErgqSG222lxLI3xazfm+QUK0wO1tktjWKKdAG6blI?=
 =?iso-8859-1?Q?qachpWMj7LI2+HgPrsU4yxlU0YhwnBlzhLZJekvzS/uWi9wkxgVQNCV8MA?=
 =?iso-8859-1?Q?g8r1Y1uiDnHrhd1jniuLZTx6q5yJDaJJ5BGbt4gfSNBlkNbSjOjoo6ozPn?=
 =?iso-8859-1?Q?ZJWYl17I6wTohqexUDYeYUj8PmL0kn1IVJB7FLCgOJV0dd4eegNKiLBDvl?=
 =?iso-8859-1?Q?XiXvIo/no4uAuZfe44vJ/JPkCF+EvYrXt4KESqsf/rS8I/98pB0cUH8nf7?=
 =?iso-8859-1?Q?lqexJISamAoFedfLjDSvQQcjUaWw3CEPUGKSk2uc4EhiHneb3CrZ0Wv72r?=
 =?iso-8859-1?Q?UsO0e4vumv0v6R+uObCBEhTIWgiDShCMXtZIXZvPpeYLnISdCdxrFwo2tS?=
 =?iso-8859-1?Q?RTy2NHwamVYmfqIyBidbR9723Anrhcc0LfFPWJWYtoZPsO7gTSNZlNLkqg?=
 =?iso-8859-1?Q?4UY1W62qQa0zXVzsuw+TrJfG+fsdfTlS/xvFJl6K2ORqVb0O+tq1EfDZ29?=
 =?iso-8859-1?Q?V3cVBEnncV1hM1TyqAdcewmrjh+ICX7kQ5lz+loFD+3/YnllJIL+X72rEY?=
 =?iso-8859-1?Q?VTFW+NWt+vtpkQehy7DmnNuZOv6wtfNG6A/+937aHzy5ay/ahyFQfSEo0W?=
 =?iso-8859-1?Q?99zA9+UBYSRSLmioUitb0pewFIqhVW3CL20ByIOJRxJr5az7EWcrOlGoqK?=
 =?iso-8859-1?Q?tII3kymZMRFu9QzyfhU8oYNxpKWfb3mpFsqhQEXz+vd2F2nQdlezvCDX/p?=
 =?iso-8859-1?Q?ETtEx31v3oHyjOmjx+kWbf/XXTrk9AQSsNfrX7MU2LXRCwOs/RYhsZvDvU?=
 =?iso-8859-1?Q?VDrjNAEaKMC5RlNB5OPR7ICJc9QMqvG44Cp/ydPwH6uUL+srGRT3ak9NtU?=
 =?iso-8859-1?Q?Ak5sANsmfz9U3tnwoqtwR0y+fLlZPSgi8gFbdfO2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VIA1EdhEYNM0dieKHisuBiKBOcxAFR2FL+jJ0J/150Ajl4R+SnnIDJKE6n?=
 =?iso-8859-1?Q?7sBPS+rio1xKqguVzqvFA/EVqiv5W8wgtDJXHiYUvu9kQfn+ArqRuZ4Z3K?=
 =?iso-8859-1?Q?xFXOfJgeOhc7r8OWu53dHGRGBS0fDtSCXtdGEPn14fQ9jd2BGh3FedGUra?=
 =?iso-8859-1?Q?tdeOOP4u0/kQXubkdWxnIkbgRJOlqgYQll9Kaw+orrgGV2iR70WsY4OPZN?=
 =?iso-8859-1?Q?W0aQfzkhuxogiek831ElKMySdnJi+6/9R/VDtpLR4dyh67vIdP/W8JPcBM?=
 =?iso-8859-1?Q?WkBy3k60B9cMQkeZqGJhVwJr1DtauaYrFLzEw0a54xoxMn4eb4ZgI0X7Zg?=
 =?iso-8859-1?Q?OOd/e991MZijrTMyPNM69oZw+/J+Du48qx2ov7xLnQi4EevzedkYzU2PAN?=
 =?iso-8859-1?Q?SXzDTBPGphb4DNP4HlyuGGcfFkwFOp+HG5AtBMv96ZUrPHPWnW20/h0UfH?=
 =?iso-8859-1?Q?x0YOM89dHk7nYyuDoOzvSy6J2IK7yk9kH/6NAbU2xuBtbkY1IUeJJVuSuy?=
 =?iso-8859-1?Q?7VmdNLB9e0nUKzoN6wRX3jDRxoUM9vo/NPXTM7/z9o0ANqutWK5F57ZyEF?=
 =?iso-8859-1?Q?Z6nIwSB+4F8NFmhaLxXeOU2xp8CUmbAZJ+Ozp+2TzirKsfmhWxtBlzB+SQ?=
 =?iso-8859-1?Q?bQ4awgEVn7+XENu5Q4Vii+Y0Mpq4tE2HZTMpx8WibW7Co4DWm9Nc6NF1sb?=
 =?iso-8859-1?Q?OuX8mI+jJPLbVQ0TREZJcx47pIDxnZR7hTpEQLMZfTOI0P21+txCu0rEZM?=
 =?iso-8859-1?Q?ks5DCuOy89rHmk2FONheQoOKjj/cgV0+ce+QoU/OVfhLaeA4eu3aOz6JdQ?=
 =?iso-8859-1?Q?+4LEYUk1wDcIjfw5eGLHOjATqHPSehutZGWvonC+em+lekSdACj2Bib/kR?=
 =?iso-8859-1?Q?0+yyTI8UHvlhF0F1sEnjGnF7s8kq5oIs5d2dKOrlgxH8ZU1t4NYUyFz3Gf?=
 =?iso-8859-1?Q?Jo587GggAw2sO+DTXKyCaMKCf/3nyK1QExDIqg/xOQPeWvOx9yilSL0J5U?=
 =?iso-8859-1?Q?+KtbXwRZ4pruqPIeYDN6gOM5w8aHwNvhe+GgE38pKyVXpg6cYveoVjW04P?=
 =?iso-8859-1?Q?a1aDgFXjxTuwslM8ZGUZO/UAhsOWjzl1qliBlv3bYy9TLHdRUWe9FO31zt?=
 =?iso-8859-1?Q?EWIFku0UcCQ8VBuXlaL2aK6K0lPlqjlDn+gf2n6y25FQrKeEXy1t6Nlbt/?=
 =?iso-8859-1?Q?crOxL28Y3G/gp6PXvAkDrJuDupU//3ZBebzjePCs4d8tkuIcuW4zkpNEHN?=
 =?iso-8859-1?Q?vkcySaDsUmJSuHTJ4WSk7SmSmc5CHRoCjgmdJYhSHjdIrlp2f5qZx/M0md?=
 =?iso-8859-1?Q?H2UOdF6tY0sE/F0lMCOfoh5/IO159RStnsjo6Sbfy7I38AlfOmxGyqFixa?=
 =?iso-8859-1?Q?OoJx6nCGd5jMeS4e+gRqitrdCTrGbOqw7wCKpPTNQFMCIp7tptO/EIQj4c?=
 =?iso-8859-1?Q?sjinoPJn8Y3BKCtH7pzIEY/2QIu9iL91gsa0izYzHnp3hLxof0Efc3aTUS?=
 =?iso-8859-1?Q?YSmGhDdiwTUlQ4mecCfcIp+dcJJZREfNdLIU+w26XcGpye8xqVRvvnZz44?=
 =?iso-8859-1?Q?phqC2GOL+OsdjTFvCFPXgj+vwUQNybo859TUe/+tyNuvWnDo+VLa2P6wbd?=
 =?iso-8859-1?Q?VEIr9hC+oA+sM9MBhQuqWQTeiEGFxlK4GhgJTUviDV7bSAyyvIrNiMEE6k?=
 =?iso-8859-1?Q?lGxVKkz6zBOiNtRyDWZ4KHcvAaKzKbTXg4Nh3NHqyNJnLr/yCGdrfDaXGz?=
 =?iso-8859-1?Q?mk8F9+6/RDYOlTE4H0VMF46UFolWet28djX/AxdDr/SIXaJl1ptDASHHbX?=
 =?iso-8859-1?Q?AvtTjmF9yA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4debd0-4c65-40ba-4bb7-08de652e9a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:56.3366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnxoYCTSEyyNIkkydY+N/74ax443DaLWu3vFsxOANBSdbCsauFZaImHybVhfb0K7N3Mi1ufmMCoUvYl2tCkrDkAsotKpvZ+QsfxGKObl/mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 6236aeb11c..3485feaf2c 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):=0A=
             'ip addr show dev eth4',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2600_i3c_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'=0A=
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',=0A=
+            'Success on message 0')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):=0A=
             'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.0')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device',=0A=
+            'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default", "image-bmc"))=0A=
 =0A=
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
+        self.do_ast2600_i3c_test()=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
-- =0A=
2.43.0=0A=

