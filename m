Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D382CEFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLZ-0002Nc-Ft; Tue, 24 Feb 2026 01:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLV-0002KT-Vy; Tue, 24 Feb 2026 01:56:38 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLT-0005Ll-Ht; Tue, 24 Feb 2026 01:56:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgnRuyD39J8xYlAAndaVssSnfbEZgURQauMlUoH6jog1n9wy8JZf8JlZzoA9+MoUq6ezE9iQ55in/FT9twphfEOByqRGaURG5YceOXvuTbzcPBIQDkMSa+tp2tZeEoAJSaOp99GT+glycyqiGEuuV9/V2TEyc22tuRjcTpD5a25qXY84yORymzokziTunz21rRoYH8lXwSd3aFilb8OPfCymmLqo08IENGCncZtb2IjKdyO4CTCtya8MZ/0cZJIrlYtcpgCz6H7ntQi/jByAjQBtxUvBGiBpQG5tCx27Gq+yiNb/T9y6IopJUbL2GpJHuUhYn2Ky8tRDBcCKyUMQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqaBL0HL+JAd+SOAycglOfwhMy3PC1QxcpdpqetNRNg=;
 b=ZJ/GSRHffja2tl1ZI9ySSV7FZk25BwwwH9FJ9P1+8xtrwC7pqqgs/epT6i+uHhv6OyQr0np6+VuGKrig8rJ7M9gLmEDnn1R87qH2YsOWkrnqWOtbxOLYefhXY6ltDkSkq5Wm25QmkgfUUUwiVBQnHQfwAhV9uZ0fsjTOPaUTNPho7LFP497cWX71WTsNJ1ITLRUnJzS8wdpLS1Ig5buhUMF3riFCfWzPHMcay/iLcvsEUqiKrpU3CRfLlWX7ALkORjnctMWGUMellEFuXaaDRe+c6+AZ4TxzGjJOwwud6T7FMhMyi1VoPdU6j3aPmmkFZsy45EUfOE43OFXMxRvzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqaBL0HL+JAd+SOAycglOfwhMy3PC1QxcpdpqetNRNg=;
 b=ceG/bFUtoeTqoTsWNDH4wNxa7a2U0GLyzr2GCIZEROyFF7KmxDFIj1//qUCC3jQSEoYBClyuKgpvIostdGDkjBDfpvqFphYZyxphHpPBLalIf05o8V7th+wMGuNhHqtqdnF7ZGrbb2XUuW1DEgjZcv0onf2le3ENN1WVvgve0pvoquW+lo+b1JwRpO5EHaFZ1BLvPP9yHQIJPu06/oIi5Tm4/mLnM2NnZMRuNByFoXVwoNyx5Jgu6d4caaWYpOxMtHAgrVC4aGbytLNJvBOKXDi38/7lgMEi/5BGesp3kf6pSwKTEqhpC3IxvM/pfJMZIvwVJQtYHq+UnDKUJP843Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:16 +0000
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
Subject: [PATCH v3 14/15] tests/functional/aarch64/test_aspeed_ast2700fc: Boot
 SSP/TSP via PSP and load binaries from DRAM
Thread-Topic: [PATCH v3 14/15] tests/functional/aarch64/test_aspeed_ast2700fc:
 Boot SSP/TSP via PSP and load binaries from DRAM
Thread-Index: AQHcpVqs4nJ25EF9bkax9h3bgQKspA==
Date: Tue, 24 Feb 2026 06:56:16 +0000
Message-ID: <20260224065556.3847942-15-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ebc05eb3-0082-4044-ca7b-08de7371ce97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?J1j+VbmlhbJyWh6rQ5167ZK1a6rO6zsgBLAf+Oe5ArleHdf602wqnIZsxX?=
 =?iso-8859-1?Q?GjpP/GXsr+Dhle9oZH2FU2wS/8ADX7ozCrBd6r7Q4T+CTtotlLb85Ee2mJ?=
 =?iso-8859-1?Q?R9m8NPD67Etsn0OLtE29fohcSKLYFO1AXtQqgUu+K2UaT5oEuk3V56EoYt?=
 =?iso-8859-1?Q?9jw+Clv62LnOeWDwmTEUWa2Y3lohYYxsHtpgrf55a4N/BB48BDAMzPtua2?=
 =?iso-8859-1?Q?gwb0HdNdG4Qjib89bZHhQzkjNsSDymnoVmPeF+yMMK/MC8G5TuWMoTBdXT?=
 =?iso-8859-1?Q?fyqbAJR4gJBfNZMhcV80/PP5XiZdzhzqCvAli73m1qRKY6UXRI3pjC7JzH?=
 =?iso-8859-1?Q?BPkhp8OAaSX68p190dBGNN9MhjUNkdqGE7laoewmY+idvl5/ruBe69ydvX?=
 =?iso-8859-1?Q?rv3LyXzV2+Ad2rL4gfvAyHOd2QG3mZMBwdsO3WBVrbKZkE+7EyBZNWLXbg?=
 =?iso-8859-1?Q?lxu1bT/dAkC4XumOie2BcNYduxRKVVcuLgTta+zMgssY9OP7fDfBf2u9vs?=
 =?iso-8859-1?Q?vvGZvjKrVUFGPXJbC5hzO9Z7T1MfbtefGhJbu5sJ3+vZbxzEZy2a6maKWJ?=
 =?iso-8859-1?Q?Upo8J9Caowmi2GqaS48lzxnuXSsdtwU4nEEBbpNnVJSerEHeMsOUJpjjM8?=
 =?iso-8859-1?Q?sssIQdBfZcvDC6o5XOetxd9kY7/LPd6tDmkRHhdvtf2vvqu5rugZ18Q+db?=
 =?iso-8859-1?Q?eV+i4uQOWAny2RbvM84vslioe9TqsFHDJNoq9g0+Vp0vjbn3bL6VkXgD3c?=
 =?iso-8859-1?Q?/JhEgA799eGZdyQuCo/V9wt/20GUkzYiBTvJ8PuzOIIIoqxoZGVksCqdj0?=
 =?iso-8859-1?Q?M3Lp0QXP/dVofKdtYOQK/SN6t1dkYQ/TlwYiUi8hevHWjdG+qNTCCoZ5JV?=
 =?iso-8859-1?Q?g6p1xNNkFPmrHzwwZzadbKY9un77RjLYuTHnLE7MKveHs4tmvl0N/l8frz?=
 =?iso-8859-1?Q?yqHBbxbMw8/SkKCFCe+/lL1fwuH1/8u1qnfVSFdB0GZP70TzdWl/Vr8FfW?=
 =?iso-8859-1?Q?52DTv8logEZpKoIGgD+ieixtvt4gvhv6Oi5GSq2WnxstG+SrhLbEfhA/5x?=
 =?iso-8859-1?Q?RPgI3qUbOyyiwxRqc5/GDpROTOk6zPB+aEIQvG4dUnpgKF/XXoN/ZP3JiD?=
 =?iso-8859-1?Q?G7v5V4R4xVH+FDTK7CtWHw8UnxlWLhdMkuFq3b1Bp30RHmcOzQONCU+/Rw?=
 =?iso-8859-1?Q?XdeJwVJlIxl3nmH/CbcEwKXqcdpCmu5oSjfrVnzrCPA7m5elxomtiNjH7c?=
 =?iso-8859-1?Q?pBvaeQ1Ta1roxup9M1GlIYINJhLW2n+UWxdeeRXX0cgHt3zZlh8izFi1oi?=
 =?iso-8859-1?Q?jr8AG0wGKqlsV6LAGFBndQx93g0d4emHFEp6v2xeoEP8wO16iuSbM/VzC8?=
 =?iso-8859-1?Q?FUk9aFjOj98lZabgLo+4lMP0oAILMIzi5+gR+/Rz+VePE/fFt07Y4T0aBq?=
 =?iso-8859-1?Q?om2t2txw9YzeyekvoTijLYRpuUj7Js3dtUlYbzuBEOiQxb8c0jRRPjOqnb?=
 =?iso-8859-1?Q?/JOGyHKJOkQcOvkECVErKbZ9HEWFxyG4ioIh97DzcWdUU/pFnyFDi1Furc?=
 =?iso-8859-1?Q?dMYuBv+vLf0iyEOt1wgMZVwNP78lIYJMIMOO4PvEUNcmo6dTJBl0YVQh6J?=
 =?iso-8859-1?Q?YYmIbBBq9v+daHwJwR8OjBGiQEkpSJTkvSEfGa5DhXwCQQtjBEV/Gc8Q?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7142099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jeFj98RsQVYeIGgiCLxKHmtbZyoBEVO7SNCOiKyzTOXidq/AiAYuhDMFDt?=
 =?iso-8859-1?Q?2QGbHx3Dm0K1oGpo9DYTfW8Jro8Ozfi6MmtzUvlmmwDPSNz5Zhqfl1dOMe?=
 =?iso-8859-1?Q?zIP04jIjjSsmxdHJ1iMuJIWB/dEWHsXZVcn1PPkTMHUX+iiwGyTiJCZk+J?=
 =?iso-8859-1?Q?9iY7cs3Z82uQFHUF32gaAhKFZtDAih0hDo2NmkFMTffqXJ/0tWL8qB2K+v?=
 =?iso-8859-1?Q?P14Dk3uA/9Ere1wFv9nQOv/e4A2IatredHlRPdXLszQWRLVbloj8PDpCcn?=
 =?iso-8859-1?Q?54w6gTcUsvnM1+BCuuOcImsHkUPV5rq8qC25s6AVLJzPgFVbRuXErHoXz+?=
 =?iso-8859-1?Q?twK5nazmmhLpmYIRfADceqCFpEGEr8lS8R5EX3FFAF4H7RanWlPKYhsV9x?=
 =?iso-8859-1?Q?vDwJq6zpkwYL7SJtCOuTX1mGpqwabtrga6gfHiwFH6UtAzhoT9LLSWLenK?=
 =?iso-8859-1?Q?tpLmESjzfqGD9eAEUaYuGcJ8B3+K9M4K+JWlRLLnBHGRhUf6BG2JxaNkAQ?=
 =?iso-8859-1?Q?SHptiwSlbLRwzFpRg/NsbyKQd4CW9aEeCPmnYfr3Q+RDfgR+CFJX9EOOwh?=
 =?iso-8859-1?Q?MtKQa2QIK4NBk4QkBVwuLeSYQ2dzy/IjM8JCcaxCK4PlXBfMsPpxhp/kKQ?=
 =?iso-8859-1?Q?fxo3EKULhM0NaJr/iPob43yggJtofOiuc0A1cOUW/9+iv8kIvs8azPuhfr?=
 =?iso-8859-1?Q?PsrJlGPpkkJOIvHwIFfpbKKBKsnzzXHHl7ebkBl0T8jSgDGXvZEblBVEtV?=
 =?iso-8859-1?Q?omZ+Rn+X58uT4pcZ4PEzbKkHD7iTmGMs1Lol6RuFotSlJrvzYINcFQazox?=
 =?iso-8859-1?Q?bRyyRZR9N2TmgyBCBTdqDCeRl0WXAR4yEeVAugZ9Oefh6pwhY28bjBs9PF?=
 =?iso-8859-1?Q?TtFNhSdIFkD1EwyvZEX9xiSHKjeMfE9TxK/NPMwUHO3cKFfD3JdO+JBS6w?=
 =?iso-8859-1?Q?shiPRDXD+ndZFeeS4YMER+H2r8VM5lHgqrrF4WkZHROTBe7P7qnJxpmQpx?=
 =?iso-8859-1?Q?LiwiH9ymbSnF6a9Rpcyv5IxLxvDtUs9Hp/WrqUALKgJrLK62OVaUQ1nAI/?=
 =?iso-8859-1?Q?Mg+r2ggVQFWgQYBLKlsCaoZ6fUFp6N7/Bx6hbSxidL1rTTTEkDhALzy2jQ?=
 =?iso-8859-1?Q?5D5XlF2Jq7V8LAXCvpmSCU5UJgDMTzSAVrmpmB9Au2oBBr1OwM4DQ94GdX?=
 =?iso-8859-1?Q?+kM8IsBdtqUIgZzrnmRJqySFDMBvenmjB2i+CoJwhJdfBPXDequIh+vGtT?=
 =?iso-8859-1?Q?VHOIF1blt2yO1DUUox/a4v4OMQaovBRbnWXutYjjcqZDqTmGjQ1Tw1wihG?=
 =?iso-8859-1?Q?qMtIP8FqhGD7qC9Q1/ftZkhb6PX1G/lVf3FycotdWRt+kzgug+oHPWKriB?=
 =?iso-8859-1?Q?IItdCrxUbFrMuKOI265g4HaN5mBmZcyN3VOK9xNXwa/4W8ZGvuQ9ssQQRk?=
 =?iso-8859-1?Q?cZbuiqBCJ0u2IfPtVnbpRZA+sGUGT7jCvNTywhzVidF1bIjdWaLt5Nm6QI?=
 =?iso-8859-1?Q?3W0/hhaTU8QgZHUviyn1+fDV2qmgNFSEdrX/sY7XfogLTLMsuWD5+5wayN?=
 =?iso-8859-1?Q?JenGZY8trnNJkj0cAEZmAclyLrD+qIBgHfe9XkWKhtZCCHklBuAU2diUyq?=
 =?iso-8859-1?Q?Y1S7hEp6bNhdXLh2PhZ5IeqiDJrQCptkNmV5kYx3qxMOWGYu0XVFKBKsom?=
 =?iso-8859-1?Q?2lay2L52VVoz3eRajVBdLuadF/X46ZdhGfPhDSXQ4dH7cPXx2PIBYTnNJm?=
 =?iso-8859-1?Q?YhCh3ugjgcVZJfWLYjbjphXCknW4h2/pXwNxvDgVS18YAWywyBUqDSxTLZ?=
 =?iso-8859-1?Q?fcaYmlCZZQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc05eb3-0082-4044-ca7b-08de7371ce97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:16.7484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgmAmGG26RglAJ+TuU46CQmhxTt6Suqn7K7RYrs5JzIGpLgNM38mCEYQgCg7C79E/TzLipmqRCE0At5tWNF/A/ToZBJMmCoJpydFoz0eSpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SSP and TSP now boot in a powered-off state by default. Enabling them requi=
res=0A=
the PSP (Cortex-A35) to explicitly set SCU control registers at runtime. Th=
is=0A=
behavior aligns with real hardware.=0A=
=0A=
Update the AST2700 FC functional test to reflect this behavior by enabling=
=0A=
SSP and TSP from the U-Boot shell before booting OpenBMC. The test now=0A=
programs the required SCU registers, saves the environment, and boots the=
=0A=
system so that SSP and TSP are powered on when the PSP starts.=0A=
=0A=
Additionally, switch SSP and TSP loading from ELF-based CPU loaders to=0A=
binary images loaded into PSP DRAM at fixed addresses, and remove the use=
=0A=
of snapshot mode.=0A=
=0A=
Changes include:=0A=
- Add enable_ast2700_ssp_tsp() to configure SCU registers via U-Boot=0A=
- Remove snapshot option from QEMU command line=0A=
- Load SSP binary at DRAM address 0x42C000000=0A=
- Load TSP binary at DRAM address 0x42E000000=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 34 ++++++++++---------=0A=
 1 file changed, 18 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 51ee8bc787..3b68f37b63 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -23,13 +23,17 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
-                         '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+                         '-net', 'nic', '-net', 'user')=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
+    def enable_ast2700_ssp_tsp(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootcmd "mw 12c02204 40000000; mw 12c02120 1; '=0A=
+            'mw 12c02224 00000200; mw 12c02160 1; run bootspi"', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'saveenv', 'OK')=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
-        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -43,6 +47,9 @@ def enable_ast2700_pcie2(self):=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        self.enable_ast2700_ssp_tsp()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
@@ -50,17 +57,6 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    def load_ast2700fc_coprocessor(self, name):=0A=
-        load_elf_list =3D {=0A=
-            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),=0A=
-            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')=0A=
-        }=0A=
-=0A=
-        for cpu_num, key in enumerate(load_elf_list, start=3D4):=0A=
-            file =3D load_elf_list[key]=0A=
-            self.vm.add_args('-device',=0A=
-                             f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
-=0A=
     ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
             'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
@@ -118,6 +114,14 @@ def start_ast2700fc_test(self, name):=0A=
                 'addr': '0x400000000',=0A=
                 'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
+            {=0A=
+                'addr': '0x42C000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-ssp.bin')=
=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x42E000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-tsp.bin')=
=0A=
+            },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
                 'file': self.scratch_file(name, 'bl31.bin')=0A=
@@ -138,13 +142,11 @@ def start_ast2700fc_test(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,addr=3D0x430000000,cpu-num=3D{i}')=
=0A=
 =0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
     def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-- =0A=
2.43.0=0A=

