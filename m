Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E0E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8y-0002W0-BT; Wed, 04 Feb 2026 03:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8x-0002Va-7c; Wed, 04 Feb 2026 03:21:47 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8v-0003VZ-AP; Wed, 04 Feb 2026 03:21:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZm/6/nM1ECcQn3du1nbeRH5Kb/VfhT2SKy1LqaRQsAwepZnLVTM9OejhloWpr+lLTWqgahff3ObR7Qin6jH24nfLK70VA7qrYH9v8G1kdkvdNDevRIARehN5BpWTKd/i/eVDQHy/ASLX4yYUmc9bZa+gBvHeitd2U9M/o5eJtQYTfUNhB1wzMRXPLYVl/5+IMBBmjYeH7s5lk1J9io1nSfnxnZI2MH4opoLxMu4E8dDL18v/SPDN9yIf9UbgZJM0dsQ7TTjy/OEd/UaggyHayRszhrDvrcn5AFi1ULBvOS0O8W38MAo5eBK6I0fsZ6wGXcG80qUQ+nTm3sfJZVy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUuyQj7CgEaYV6lW7Ep0a5FhpLn566KSVyJ1Wf/gfQQ=;
 b=MhhG/9QNRvAhNEvUTtUU+YSHtVKyTOqFIvPxmTExLW+OGhCdwG67PcRmteTqBAKsCDLywW/roU6colzK8xkE/OiTxizyrA544tmqK0IMZfhkE8lmXqwXi+ROW7Qq/NTS/K2zQXXNy59kj2xCeBFmzF7IJX95DAbemgukZDV87rCUbP13Vvl7Wua73fLMFIJPJgTF8b19VjdsGm76/GzGV5vjrocQs3N9jsL749hfaFyQv0UPklzwwTyQQk3Q/FYeo/g33MNUaNHn3B8oBBPvVrh+pPJqffGUsKwMPZ8phDiuEzZzD+gY6lgbVaJ28wzYt2uzanB9lc/RU0eb+R19tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUuyQj7CgEaYV6lW7Ep0a5FhpLn566KSVyJ1Wf/gfQQ=;
 b=R+saiQNQb8r2ZJBtIYJUia/9hZwDgzXLYngp85cGk97+pL5GC5AVAtz1X3tpiQSuOnYhyzhBGEIaS7dst4qLnUxkfKksUSjlreuA/k8LVVuAD4dJ1bAYhoIX5s4fQZM5tYHfmYlZglDWJM96qM8nbIEFoymo6sJHUuRNGbrUSdJkl0B135zm3QG7K8yFZDCHV0uB86gYreJ1L/Y82WacPWVLxOREdgc5MjrEX4JbJqFjjLXfReijFsUeM0qcdML6RSlwEvcAjZqR4s5eTma/dYiwhBPnJsUm/tdzahjAP01wemjMhTkzYSSVZOooybcUkAcWm8C0cGnR1ewHtzMgwg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:36 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:36 +0000
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
Subject: [PATCH v7 15/22] hw/arm/aspeed: Attach WDT device to AST1700 model
Thread-Topic: [PATCH v7 15/22] hw/arm/aspeed: Attach WDT device to AST1700
 model
Thread-Index: AQHcla9Hjjd1YGm+jEah6tRv79tkAQ==
Date: Wed, 4 Feb 2026 08:21:36 +0000
Message-ID: <20260204082113.3955407-16-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e65e3612-f59f-4c4f-44fe-08de63c669fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LL5hrmBE9TYJAeg+qOt5hzyrWOJ8UxaIslPXvEWj95K3eVugZdarUD9hbw?=
 =?iso-8859-1?Q?tkuCSx1UsnsSLf8cbwo6g+tJxOP1qTP8cIJJx1iEvefCrFo4nCbTqpEbzf?=
 =?iso-8859-1?Q?0Cd5n3R/6WrkPDAuvRMR9S7isGqIjjSxkzD7B9D2CjBKHmwx2e4SZCUQCS?=
 =?iso-8859-1?Q?PnRJNzvrXPtW749TQk8hXIQP1TQaX2kRvE/4dxl2lwymlvrK7ATklfxum6?=
 =?iso-8859-1?Q?uF68GWcldI9NYccE3EqaTUdKobdwt0TqgihHvHuxvlwbi6bKpy7JIYF9fR?=
 =?iso-8859-1?Q?/8tBu9Byx1Jnif4zfLv2Im7RMDfGRvQldjlOlb9xkS0PJYhV7/q1WFkzsn?=
 =?iso-8859-1?Q?jSSF/Hu7iHE1UeQaZuijYi030PPHgV6Pnc0uIYZ+L2pzZXMm12obw8WYNt?=
 =?iso-8859-1?Q?SzRc4G5QJODvfteTYu9g04SiKNlPJRX1lygAqD1WyP8byiZeP6hMQvjyRr?=
 =?iso-8859-1?Q?aepuTwacrFlYtKLtqAOnZuyUcnNhyq4qXnk/gfZARkBzws0Y8Dzj2QHOTE?=
 =?iso-8859-1?Q?plRIY+Rfm6Nuwu734hRL6EL1RiMbToO7l+LlmeHcDUTX3esvnEp9qQkurf?=
 =?iso-8859-1?Q?ElMoWJfOgRhsPBpoGF2KoBhGw5mfXP2HOHW+0hqECdWdNtnKXYDho+bFJp?=
 =?iso-8859-1?Q?aD1Z6rdFPPqec5VDILGE1P2gCLiZtA1kKemKpzJCNcKQqm63DXr1szV9J/?=
 =?iso-8859-1?Q?RpH/GUzrRxEo+FUfhnJEDO2fr4y3v4GuT0410nmz7QISUC4GmyZ89h2Uii?=
 =?iso-8859-1?Q?ugwAeARGKykvSmU/U9CKvrHWTX9V0G467SakDvuGutZoc5KEBZMP0DnmK9?=
 =?iso-8859-1?Q?BuqNKUMBV15Vmjb3ZcLzTUzu09PkiAYvnNbc9N70vcZdepUBcPxLdCHppX?=
 =?iso-8859-1?Q?x8xdy1Nr6fDOoueSfZR3etSKaa03gtyHyV5Yz4QVc5aEp/EnCMCclzRC4c?=
 =?iso-8859-1?Q?RWSq2RDlquIDprHqMqjlNRI/U5OCtekIxilCQd+rEvunUsBPZXx5v9Mo3L?=
 =?iso-8859-1?Q?1PdtdpNQ5OeKykNYyvatfz8JsNXfSb+ytY8zEbYIiIKlg6t2UQkTbZmZQr?=
 =?iso-8859-1?Q?+Vf5xtYD1R5Q1UhcnR3YpDWZo2ZBOfOA/afwZWlqGStiXJMOGX2MiHuV0h?=
 =?iso-8859-1?Q?uBuOYi6+Q2Vk3+yX2rrwJDYVVHHvThBK3Uqk6uqdkehCm+qvRXAYUfZUT/?=
 =?iso-8859-1?Q?cnA2fCZ0fXtwzzhbq3cg6agN+bRGB6iOwhTZJAdBwOmwRYCBCjhtRu5D7/?=
 =?iso-8859-1?Q?+WqGZ9p8iWRK+ewq2tcoLZn7dWVUsH3E/XjGAd95tQpKKej1ubdt3JR4Gi?=
 =?iso-8859-1?Q?xnqgCOFNhZYlX67UHElWep8PrzedlS5+MbcWU8FG5xiMDO5MIrrbzXW7Na?=
 =?iso-8859-1?Q?gCWs1omO5Yl7jeRSX9sEYJw4Um7YkBYVQLnr4EDP3AiZW1tieYU+bjD+U+?=
 =?iso-8859-1?Q?DboIJW8dUXy4PZafI1JVOe4+hL1K42y68qUfpFVT2nJnq0W1/fU9kxROCI?=
 =?iso-8859-1?Q?ge7zqPz0ZNXbDdrHObAWxtyOGlz67WwH/7F6W4OqDgK/ruP/j/V47Ad/Tm?=
 =?iso-8859-1?Q?XwNna2P/41/16mYqfsYumXHk9RLh+iek5bLVZsSKmCjiVn5tOi7/w5RfHU?=
 =?iso-8859-1?Q?YbdpEJbnWrdDOa+BFgdoI4TObpiIvaISFLvGdrjHA29VG2vHb6/eqDbhRW?=
 =?iso-8859-1?Q?N58L4Q7h87nQwGn5kUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N0k/reTgs0umbT3CKohJpTs8PGtuguH1G3vDk3a4508/H21T4mucDie0cc?=
 =?iso-8859-1?Q?U8ofO35H2HGb3XocFFGLPtnOh5akZ8QADj8wawYBwk5uM/oox7cmTVnP0I?=
 =?iso-8859-1?Q?Ncvgij2VDn5f/1DDpyLCFWh0Z4kp5VEAbEqOVxy0XiJ9tzYrioNICTBarO?=
 =?iso-8859-1?Q?z5TxO/tU69GYLR7fXssKJwynCttLyMdLUi69eYRuRlrUR7Er3j6oluwT21?=
 =?iso-8859-1?Q?YDJ4CZNwwuBD27Bas10tsH2e1/4uHk9sBpRCclpjt1ug/AbG2NJxakaO7A?=
 =?iso-8859-1?Q?zxusr6m+g/+ORGeaWp3KyM5tmTftqPI5uL4Zh8j4kfW05kitsilBZfoCeK?=
 =?iso-8859-1?Q?4dazlC3sUMP40ZQGpTULMQAgtKjrJx98RQtWY2Uy1Sk9XrEDyIKBzS2dZh?=
 =?iso-8859-1?Q?IuQQtCfeHTdTpCWdzUsiYY3+MilP2SA9tnfb/Pb/3C9RWIH3CVnzNZutNg?=
 =?iso-8859-1?Q?2yguf18DIHmaLZ6a0wzHVx7ioCaH3vcl1nM1BoPxnVVBCFOmshTDn9smDb?=
 =?iso-8859-1?Q?8Q9Ffto1xhPeq7RHU/rlAFNt+D31WtwTI5fcZilkEcoYa2QVWwDJJXgNNL?=
 =?iso-8859-1?Q?9L3zJZpCrV6Tq5iMPILIsV1aUAmqfpajpEJixzdg2BFG9O7/75UT5lyQ++?=
 =?iso-8859-1?Q?A7jzSAAbEt7dAeA4yHu8q+IpN48PA3vBF60wzgQYh1lIhJAGaxvIQ2/nnw?=
 =?iso-8859-1?Q?0CD1ASudDl1Kycnp5NLuCo/YNic5v0JckknS9eRPSAQN7oIWeTgO+x7+Kd?=
 =?iso-8859-1?Q?P+My/H926a1WaF5r95C+6roCxqqw9IdpzTPPoZWpAS3iISfoRxZ+4nA3OP?=
 =?iso-8859-1?Q?kpebrniOJBtjh8JeQZOywH1dPON2wmHzUE5ND5rT51oQf1sL8LOrTAf6ZE?=
 =?iso-8859-1?Q?BYju/qCVpAZmoL3mNVrj/2y0186XGgea11f+WSYjnysV8+c2bvOWNNBRUA?=
 =?iso-8859-1?Q?0/XgExiBxCVBVhEl/pJCTKDwWeI+RErL5Swp/FL1t9Fy0iRqHvUdsIcgOc?=
 =?iso-8859-1?Q?a80X8r44aB0WXo1ZNoTrtYSRT/Fjw0tpOQN8NqQQTc8qOCJDp+GWma/QxG?=
 =?iso-8859-1?Q?xN6W2a0NftLwm4LKZfCOtGyAGLlmqBmk1NbhIeGsj2bFvjquNKzXphvOy1?=
 =?iso-8859-1?Q?CC3/I4zDlUgaiJl3P1ztHtoB+ogm1tVXnVNEa2VsafbMGJ3swWTHdFRVx1?=
 =?iso-8859-1?Q?U/vkfXsUVYLtb1aBi/T2pdWY5zcJH8A5smvkaldnttk3pM2AIm/vnOTA3Z?=
 =?iso-8859-1?Q?3jl2vEvqA70wu5Snski72nRjxLDQelnX8wXRYj2saPAP+rvWle844QEK8d?=
 =?iso-8859-1?Q?sRHPvYisNrWc753EUvD58iSKjOGzl2JIC9m1anJRcgC3D29/Z1M1qpw4Ab?=
 =?iso-8859-1?Q?3gd3UI9MABZVXUDY6ViytTAV6Q/4cGvw97uYDA+qdJMEJiyY2GZcVt14W8?=
 =?iso-8859-1?Q?Ka04jOhjdA1ia3HexYMXjAiqHxOcHIeCJT/Z8XYxIQpTQSgKIyonGYRk58?=
 =?iso-8859-1?Q?mVyQC6hdWomlpt5fBJzd/0VdrA6u65RkdrvOqf42yGnCTG7Ib09OaQ7Px3?=
 =?iso-8859-1?Q?s1uFFXiBmXvNZ54XL10pk9iBPAReAGvU0X2ufWpIzsL1gg20eDe6eBbXig?=
 =?iso-8859-1?Q?eF0KOdTPBqKXeR6UB/VxbZMkOE5M2jEqkCfL+VBFaNjiXbr8OFhQVpJjsr?=
 =?iso-8859-1?Q?C3nJrK4UfoU0n+pu9SrClyBZbx8WrmA6wyFQ19jApXv992qrxBypLqLj/c?=
 =?iso-8859-1?Q?Bupre6fFr3kYOwjKv0K7iMfGMbewt3ta5RZTKOiYjHBmZuYJjRmnljSdzh?=
 =?iso-8859-1?Q?ZvuMQoywwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65e3612-f59f-4c4f-44fe-08de63c669fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:36.5688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYaYVpfFMTG4VARsb+WgkK89fzg9Se8Gd1n1TMYoeC+6f3KS3xR2gXxKaaU+eM5M9CIt07nbR8c6Zomqv6lnt46u36v+4i/93rW4BMm+67k=
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

Connect the WDT device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  4 ++++=0A=
 hw/arm/aspeed_ast1700.c         | 24 ++++++++++++++++++++++++=0A=
 2 files changed, 28 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 1005ce6364..ee0c47d173 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -15,8 +15,11 @@=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
+#include "hw/watchdog/wdt_aspeed.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
 =0A=
+#define AST1700_WDT_NUM              9=0A=
+=0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
 =0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)=0A=
@@ -37,6 +40,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedSCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedI2CState i2c;=0A=
+    AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index e264b2200b..59954eca99 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -25,6 +25,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_I2C,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
+    ASPEED_AST1700_DEV_WDT,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
 };=0A=
 =0A=
@@ -37,6 +38,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
+    [ASPEED_AST1700_DEV_WDT]       =3D  0x00C37000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
 };=0A=
 =0A=
@@ -135,6 +137,22 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
     memory_region_add_subregion(&s->iomem,=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_C=
TRL],=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0=
));=0A=
+    /* WDT */=0A=
+    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
+        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
+        hwaddr wdt_offset =3D aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_=
WDT] +=0A=
+                            i * awc->iosize;=0A=
+=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+                                 errp);=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        memory_region_add_subregion(&s->iomem,=0A=
+                        wdt_offset,=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]),=
 0));=0A=
+    }=0A=
+=0A=
 }=0A=
 =0A=
 static void aspeed_ast1700_instance_init(Object *obj)=0A=
@@ -169,6 +187,12 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
 =0A=
+    /* WDT */=0A=
+    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
+        object_initialize_child(obj, "ioexp-wdt[*]",=0A=
+                                &s->wdt[i], "aspeed.wdt-ast2700");=0A=
+    }=0A=
+=0A=
     return;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

