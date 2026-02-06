Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6738EEB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETf-0003WI-Ga; Fri, 06 Feb 2026 00:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETe-0003Ve-24; Fri, 06 Feb 2026 00:33:58 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETc-0007WD-LJ; Fri, 06 Feb 2026 00:33:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PX3evTLT7QlmF1iiND6GG1FvXveZlSqIhcNVSnMphhVCR7w7CDoZ6Sve5hN0nmzIFDJ1fQpVH7CvU6HpsYvqYmIH9QbaA9lYcv2O7dghKSCLHLK9xr2Ku3f/ATqm6esMgKYJBNGaCBZ2MQH/oA4SApZyLOyWy8FTGR7u1zeWseviMATEsWsgDXkgqTgIcNpRRSiiSN/afxbwxVxA2vvr2WwZB/MrfDtPm3aIDjCEwh6XfiAFK81e+YmNkpCSZNZ6g/vAsZprRCL8jIrMz9hHmYzw0szzkF6X7u0KTBBEIlsOMxaiPgS79NYKzUuY47Lg1gulBDO/WpLuQJbSR/27qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feId2OVSQ0fwk59Qenz//DAY6gJkL94qPqGwoNnf45E=;
 b=VHdtOHMqaqn5T5wuk3CrfCWNz1CJOW3Rvrk0qllWGddS7rApcw1Huosa6HflCqQD5Q4L+x39dyqeF7Sw9J0LH13yIBPiCeTRRBBinHPVW5BoYpsAiarMI0IgVJNq1qfvOzmnY4Kz+Kz1NHHwGOVDhmjuSyWCGM+MU+XAjPDym56xqlBY6eE1rhqChpYv197hLR+D4EoIiff13N/dhWdUomfx4vboF6ZapJ/8MJODQ9DX0ZkVKiS2zrInzaurdKOg8XZd4+JfQRxaXa9JP3S33UaCCRSz2Oa1PqEQXqEPJSNAaQCQBdF9QF/hNykol5sfmaNuRtA7D/bIz4PUkyFJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feId2OVSQ0fwk59Qenz//DAY6gJkL94qPqGwoNnf45E=;
 b=PrTrUNMszLT8DCGf6NA+tuIf4Dklc0arXszusPIa5tU3vzCIOkzy7mk7YbrBgXyioUAwnY3LVn+p0T9YreRKZek7TApw2xoCtQiG1W7cEr5MHLrwan/9HYXwcnYG9gbv+REHhpvlmGVBR5IPonWher2BEK9b+nSuVORDsFWUR9pgHxTOsMfSow9G7IDsXI8Qw6PTNtlKnLcCtF0rzfIMQ5zOy7UUBz+C1orLfjQrRdErngG7wTbcQU8EZrbqpmx9fhc8UkUJ4qnRaqyjVaQ3uuih5+BTGmk12kAyGgpTT2SK15WQDsNtXJT/2CHofpaj5BqdNMEivnXQrxzK0gfsrw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 05/10] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
Thread-Topic: [PATCH v1 05/10] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC
 support
Thread-Index: AQHclyorpy3YLROiqEGBwycpLgpmHw==
Date: Fri, 6 Feb 2026 05:33:48 +0000
Message-ID: <20260206053340.3716041-7-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: d65aee9d-6be3-4c5a-60b1-08de65414dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?veUohgM9ZQFl8XC6jYIBkVYb890pgKh0HUO832Oheda3kdCCe7+hXXyb6/?=
 =?iso-8859-1?Q?/2nMMDAIEMp80A7BfaRe6VtSo190M9KIN0I6t+rWCnsBCoPVvttLu3Ou/Q?=
 =?iso-8859-1?Q?84NJw9M/uJXNidWDCyO+EltTstZ9wNpkZn5sBgi288CzkodxvO5/mVeD8G?=
 =?iso-8859-1?Q?Dcd/qEB6UGtTl/4GeCqojBE08Nydw7rMpAqBPfwL6ztm7lBTkuzqj7KA6S?=
 =?iso-8859-1?Q?MroO06Jq7d54joR5KjfMiVJZSajh76epgG1iPmSfamJsCR5akzHcbXjJye?=
 =?iso-8859-1?Q?xLZfJAMs2WkC53wAVSoe/XTddc3+qiZjnYwxFMRjtak/1U97YK5sE9Ngxj?=
 =?iso-8859-1?Q?v4RuvTu/JbTa2gN6Hhd7VcHNn7NaWmcWYYzAeePD+ICmMenRrtNf5x3U26?=
 =?iso-8859-1?Q?nz3dPcyGIavk7uB+ePdOn2jN3bj/Fiy/x3fINgMvAgbewqoiib5D21Pd9o?=
 =?iso-8859-1?Q?n7jOTGLjV2xGK81qdl9EhrvVuUdySvX+fNCh4k9kqWlrFxCMFDnIhjBBvt?=
 =?iso-8859-1?Q?h9x7XEJAJOWvutKyGBMDlH1ZqpYDqnj8SGei6bEwBNL6V/xaviCi+8i/4o?=
 =?iso-8859-1?Q?b7XS9MANmc3QBdOWtW3dwEXDWHVKkFDC2bdNfXupJCkyFJGTLUAhOTxuaH?=
 =?iso-8859-1?Q?UDkPENUSrH6IhEfUZ7OmVyXyoWfsbpELD0Ec5SaEb7KTMgvg5cligbN1pt?=
 =?iso-8859-1?Q?9QNJ0IiQRYwsAsAu5z2kAFkjLUzsTOuURsFDVbpqY0DLO1lm/rSY+O73kq?=
 =?iso-8859-1?Q?jM5FDKfMmL2x6ZDMBc2AqGTN6FOT9zLTsjc/jxgn4+rBQkIa/txRnznFsH?=
 =?iso-8859-1?Q?60xWCkyW+YTZXM1ja0ox0f7o6e3TcywY5l+e+zNbLhaJv4PJnLfMBFXXaW?=
 =?iso-8859-1?Q?5wPyyDAlRotHcURD/xRVbJXt3elzYMRhNhCmvkZu9wM904lxEXLYASLdDq?=
 =?iso-8859-1?Q?wNh7GDiOrqPm1lhxdYX7BCXbrNUd3xhp5R89Xhoar+KjHWumt1YswiSkPk?=
 =?iso-8859-1?Q?rJdqfhG0uMmFByTIdefE1kT6N9OnmewV0SvhUjPfNrIo/qr/8OmZRzrHPc?=
 =?iso-8859-1?Q?NIDvPMPNfx3con8/Q86BF1zrU1jFA9WARjfnt35JFcR2Ick8RILQKHVmjs?=
 =?iso-8859-1?Q?CGlsXIJLdVIUf+rvZ4wFpVxk7d+zP4wn4xNl345zE5IfGFAl5uoOhUFM/y?=
 =?iso-8859-1?Q?ljdHg80ZUGPlj41wNPW7yA1EBXPdp+Q6BdFpqaaeTiOzGRkJ5QcPhZvmLP?=
 =?iso-8859-1?Q?Q3wvuqHjrze3NqlzpvATOBEmRN51wDq3Vs5+R1gVl4VWTAvXR0nv7aHXA1?=
 =?iso-8859-1?Q?+Uc59DtG1fpujcV0Abm+qLnGiOoa0JeoteuFpCLRl0AlIpfhIB5yexqaji?=
 =?iso-8859-1?Q?zT+VD4AAHOzLNcOjcb7PN9vyAPbUH1uF+sy+9jZApO5wXZvlMPvVzIOFZm?=
 =?iso-8859-1?Q?pa0H7YCBcwGqRPHEU2WB5Qn9Wa4TaQ6xLXitTbb79SI7Jz9sAQiW+9H7Tf?=
 =?iso-8859-1?Q?3dKh/KjOwvrQoR+jU/zBEMWuneBTz5ewh9JNG8/yIhdP8Ih2BDuI9eXS91?=
 =?iso-8859-1?Q?vMXJYpL6wXY0hHBdHqnKiogyxv53wff83w4drU2CO2HMELoJLQ+RZ66PNG?=
 =?iso-8859-1?Q?92HolhokEBI9InCUyvSgR782AH/A5Bk19aqekeu/RQ8PEepKKXFAun1pQL?=
 =?iso-8859-1?Q?a3wtJsIw7zRuVOcWArvI5GSN32vvNtMHDhcgIMif?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yT18vvXsa8T4ygBCfIYrS8BC9DBynz6kmW2IKEqIYLpTz1x8xmcozPDjwE?=
 =?iso-8859-1?Q?dzSDh49fV29wduYrgy99Te1j0XKevaiIhjCJ1OmokBZ3dS10yfgmIB7Zsu?=
 =?iso-8859-1?Q?9M7plIn+8PP9/639pmP0ei045Px1kRaXbr/6+9lDjkIBea2X0APgLuaaRJ?=
 =?iso-8859-1?Q?fk3XLwNx8yirG5mjIOUg/e/4kjTYhUp03JGZORbqJf1bSVbYzNnv6uiCQl?=
 =?iso-8859-1?Q?fpesJ5gtIULy5OUEUm+3jCxFCbde6d+ldCWxD0fF+++MiOixwpyHdBMP9Z?=
 =?iso-8859-1?Q?G/vSRkm6hVMKrqUUsponjoA9qIcRvBgB6DncDLzaX1pbcGB+Q/yLl0r5hL?=
 =?iso-8859-1?Q?jxabz1CklBAZvL6a7v93Ny3K5XjRb06OrW1gs5xqcrZSUkHdBUx5QWOwUA?=
 =?iso-8859-1?Q?FpWAuKiIPhxH+AFfMe1i4ssLpisDLjUREljWNCJ6bLmMRp3IXhgVTYPv4Z?=
 =?iso-8859-1?Q?uhDHJRxuzqRckl1y1R3m8vI+v6mqB9GOQdqEaQTzH4NzYe4Uk4RfDVsG91?=
 =?iso-8859-1?Q?6A2qj64pq9u4X1hbZ9CdLCgD+nvtzXjadBj8qWIs2vt4z97wQUzyPiivOH?=
 =?iso-8859-1?Q?swK8jVBvWmzObBJQADGce6g7uHXQNMiED91XJjNUz4sXvd69KRlH7gU9cW?=
 =?iso-8859-1?Q?fMvan49CPxA39+0gwK+McqqCZ01DfjZrD0v2Wo58Q/qLxC7bxC7xsKjYaL?=
 =?iso-8859-1?Q?ga02ONDM1nGva8WCTc+3mQ4Q4wYZWF0pZcMOfkcH3+E2ZWDyYj9W6JQMXl?=
 =?iso-8859-1?Q?Hu7OW6OPQznsZ72jav7Wnw0ELOxg+7RX1CxXcbDheAEuZG2dIDpdtADTez?=
 =?iso-8859-1?Q?PQLuoiLsSzPYdhfe1srkcViGUaVgG+a0YpATaqswWkM9BXiajvMbzSz2WG?=
 =?iso-8859-1?Q?Z9wUvGBj2YjScnIfb8xUIj6NOOKZ4HIZovnZ5Xx6w6tdcCmTr0ttOeh9ce?=
 =?iso-8859-1?Q?nl0IYADfSy1Qkt6CU0MAJfbR5MnaF+fltng7kNTScuHIchIbhyr6Q+93hB?=
 =?iso-8859-1?Q?Y9wcyJv5TvgesZNtbxYa3h/HyrkldzAtvbM2BLhw3tLlB33YInb+E+WiIj?=
 =?iso-8859-1?Q?Ut9KfM0WCvTh4Iak9aNWzeNeiy4RNuaMEmTjGdA233X+eXE27u+v2vS2fL?=
 =?iso-8859-1?Q?z3vJlSIZqvzmf2lvmxK+qjiwT2gKUU50XpSZYd1v/O6DVSiM/5v9svYU56?=
 =?iso-8859-1?Q?volSEBqkCoXkbm9TMUM/M7+fkFkpgiX8dws3Bt3YFi/UkoR55v9EU//ysY?=
 =?iso-8859-1?Q?XCnYXMDk2kpyQSCK5Oo1W4L1bUM1pJ2MfefUQTmAbAM5gWDIbhEIor+PqP?=
 =?iso-8859-1?Q?hvxQHMADLT08rOqIx53vduRHVrkkfLB5invuc9p7kce14mKDxIjALkJqB5?=
 =?iso-8859-1?Q?bXIznDUrLRPBCJHI6dwrUM2uVF1vGRkG8a1/ZJqFm3byN+xTzNHsv7oL1K?=
 =?iso-8859-1?Q?1JwmN2aJz9LSAs0UHJZJv6v4k6adf5b5hY7zKWFcNKwwi1kx0vSgYY/NCw?=
 =?iso-8859-1?Q?4naxl6Iki3cseyIV5aQJYfBbAxNcS3e7pkufEortt3P/EmqzcmyWPJYNaq?=
 =?iso-8859-1?Q?AkR1f7+vymY/82kkLenkX6VWb+KbVLi0ix4ovn7g+Wb+vJCwtazBoO5tGh?=
 =?iso-8859-1?Q?gBEWw3JFdMHEGetVvhTNx3L7qFTeSwNx18ErwUi4Hw/msjr/DOoAMMyn7J?=
 =?iso-8859-1?Q?17CcBaOkcfO5CFfOJXKdWAOVVHhVgkHL2CYAaOfVEJGCxdr77XvhwTBuD1?=
 =?iso-8859-1?Q?jvo8w8iYQvdcdkA2sqwFsIvMXmaxnh5axt7t1xSNxqljJtHhGrxwIhtysN?=
 =?iso-8859-1?Q?0H+nhyLICg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65aee9d-6be3-4c5a-60b1-08de65414dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:48.8595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUpEDJgbd6IyrARDx4k+vCh9cPrsw+6OdYwoFF7ArtrODSoqhMHcd981Q0ToTidNB7R4yWUnYmXXJMWnjrQn3PHKx55kFOtoJfCWvypapEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
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

Introduce a new AST2700 A2 SoC variant by adding a dedicated class=0A=
initialization function.=0A=
=0A=
This commit sets the A2 silicon revision and defines its SoC=0A=
capabilities, including CPU type, SRAM size, peripheral counts, and=0A=
CPU topology, while reusing the existing IRQ and memory maps.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 36 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 61790ea1cc..87dcb82e1b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1166,6 +1166,36 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCl=
ass *oc, const void *data)=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *d=
ata)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-a35"),=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(oc);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize      =3D aspeed_soc_ast2700_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev  =3D AST2700_A2_SILICON_REV;=0A=
+    sc->sram_size    =3D 0x20000;=0A=
+    sc->pcie_num     =3D 3;=0A=
+    sc->spis_num     =3D 3;=0A=
+    sc->sgpio_num    =3D 2;=0A=
+    sc->ehcis_num    =3D 4;=0A=
+    sc->wdts_num     =3D 8;=0A=
+    sc->macs_num     =3D 3;=0A=
+    sc->uarts_num    =3D 13;=0A=
+    sc->num_cpus     =3D 4;=0A=
+    sc->ioexp_num    =3D 2;=0A=
+    sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
+    sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_soc_ast27x0_types[] =3D {=0A=
     {=0A=
         .name           =3D TYPE_ASPEED27X0_SOC,=0A=
@@ -1179,6 +1209,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] =3D=
 {=0A=
         .instance_init  =3D aspeed_soc_ast2700_init,=0A=
         .class_init     =3D aspeed_soc_ast2700a1_class_init,=0A=
     },=0A=
+    {=0A=
+        .name           =3D "ast2700-a2",=0A=
+        .parent         =3D TYPE_ASPEED27X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast2700_init,=0A=
+        .class_init     =3D aspeed_soc_ast2700a2_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_soc_ast27x0_types)=0A=
-- =0A=
2.43.0=0A=

