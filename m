Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDFE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8t-0002Sn-VL; Wed, 04 Feb 2026 03:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8p-0002RA-Rk; Wed, 04 Feb 2026 03:21:39 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8o-0003VZ-BV; Wed, 04 Feb 2026 03:21:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYlaP/laHgEFM6o5CGSzT3LXe+AmO8B9WRuu5h/DkL9LH0qO5FYr2VwmJrGEuWp1N74Z2C6zkejswJ2WOnohoy0Srp+zm6FNwdF7T+4TOeLPKDSmkq+pXL8SOGXBJShq+lNhTyrfK/0BEN+BqBbbJZpQEG7fmqHRrs2Jsh2rcsqk4bTI1y8mCfX+qXI979h+R1THH3Kf8VQH0oJtDGtqNSYlNvEl6GTFZdiClGZMWPomq5Nl2JkNrEKJ+D3wp7tv2ENp/IQ5VNLSD+KrJA9L6t3GWRkEZz8kQqfBKkbTEwb4CyG+EhE/rNN13/xOLWNXwOpyLn7xd8tt0yFSTzWeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOiun+yau3ET0PQyINXjy/NOAqoZPYlzpfOwG1+kgH8=;
 b=Fu27Tat3dLWbzu5rnahERF4WWrdVNW9dUP0ZaNkCOH4OrMw2Ksv6wG7V9L+zUICeEsJDz6xVuORc4pa+KB5Mjg0Ky6HFyesgpq3u3EKzxePcO7yctBGwGJzJEQCvggqbKrx8+M7/WPllVeoi9+14c5XxFBypNIWYeLrYoiXo/023AX+DWuW3P9FRku8gLpZR/zW+D74bP8n8BoQOqsjhz35XVDWaJ8/UiaG0wrf0OQvhmjS76B6S3Iu/g4lHJKJmxPNzLGaLxgnzA1nl+UYv9ryAhhZ2PIz0jtURk7L0VkcpZsCjMCq1yqHXuAjw1Nm0Vo8m+7kfYdz4yqyU9SnBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOiun+yau3ET0PQyINXjy/NOAqoZPYlzpfOwG1+kgH8=;
 b=Uwzn9jcBTIK/puvloo7yCEcoE0hFtUHitiB0qVi+3ZjlDv3yo+G3PfLlk0ynPxh6hrlkOo/79btrCq02ZXUie8KsrojMin5iZg0QHh6qlNJJCwBD878HCQ7fWMYV3HBxEfYzxA9ohlb8SwNZupl31NXs2WkOKAKpHd04E1u9yr9j8FZ6Rda8zjYvaghu5C0mK1iWJE9ss3yD3k6HSqvwVBh3u/7xHL3MXQ4Gf96i/kQhDi+OttEqHQO9UKLKdaj7NXKNkYKYUSqsmBIZLIAYP8PqHGQewahTUo3OVIRrQ8rlC/+H7eQXq/IeUyUqZcGXlK0i2zHuQXtVGpN0BeoEcA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:28 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:28 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 10/22] hw/arm/aspeed: Attach SPI device to AST1700 model
Thread-Topic: [PATCH v7 10/22] hw/arm/aspeed: Attach SPI device to AST1700
 model
Thread-Index: AQHcla9CNGH1nhuYwEmYi2DaE7WPWQ==
Date: Wed, 4 Feb 2026 08:21:28 +0000
Message-ID: <20260204082113.3955407-11-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: eb0fafac-c156-4be0-8169-08de63c66553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?5HEHQVKV3P6ojDi8Yr06SA4JLwscqzSJ7SGTuuOIv40gTYZTl5LBtVoE9y?=
 =?iso-8859-1?Q?gcYp7gYOnGWZH60eH1MeTwa5ZD26+Bm6cvqbq9VWPbpdXYVuc8gT+5+O8P?=
 =?iso-8859-1?Q?Ui1fhq2GNSwV9sRzLMwUvNww1SWfwkgd4nBauoEn7ozofMFWUKURplCyM3?=
 =?iso-8859-1?Q?LUHRJXKJ3ZU6yFnxx7sb+OgOh6YJRn7ve6gOlAgfzPqckUItI5kPBzY39W?=
 =?iso-8859-1?Q?FlytyJS2WjVrenzdcWNAUAe1LEQMk+uhBLUhhoWiGleeifkB8sdaml6DCB?=
 =?iso-8859-1?Q?YugKs2fZDzAehySgiwFKuh1Irtg46P1yzZFhFiq2+9D6CaLjG1ptxPuqea?=
 =?iso-8859-1?Q?BeXB7IrMQJXbp/Yaq2VUXZsbTndxTWmRIB9YvoN0+VQfhlBujwBqqUtZCn?=
 =?iso-8859-1?Q?VgolXRn6LDu15E1oOQ3JhERnDck7DkPqWvPYZidTrb32zyW8YYbkusO7LD?=
 =?iso-8859-1?Q?4eyph4YQUcbKZdPCCYPviIxsKMk+ebm/vY9GlEUTEbWBJ14v66viGZfVQN?=
 =?iso-8859-1?Q?ARzj08IGVsSmexcvDf2cdQnzSYvy6QWbMpVSSHJVyKo7ZXCcl56O8BsF2/?=
 =?iso-8859-1?Q?RAAHnq5jClKRMAPRMH13omanEE3UXySx7NFG43znBli89Bs3mYRAitQjFa?=
 =?iso-8859-1?Q?cYXl8zgPJpjXI2Oh4tMtKJDtR+BY3evXeB7J0L1LaMu2MoWNWR/hWvGOjG?=
 =?iso-8859-1?Q?rO+IuL1dP07z8aHOIMvpt+GkwYcYi3aVSo+BmguS/OlDUna33PXRuP7xz9?=
 =?iso-8859-1?Q?m/+Faxv3N1l5eLQ25mdupI3eTfbiGR6GWlbBqW5a9Vp80oTThqh2j1Mm/v?=
 =?iso-8859-1?Q?nPZATGO1/n/bRusLcxaiciW+ADiahzMUdXBFIbC6oCxAqrw2ogd7iUPuNW?=
 =?iso-8859-1?Q?zS0gWJmAS9dYr08LbZJqc5nJDnn+UiCcX/Asa9ZW7PlyF75YXis7x0qO//?=
 =?iso-8859-1?Q?f9O34ort3H6P6QWpZi0pP/5ujNma7Q9Va/aWKqlxNprfa+9oamApVvkxk5?=
 =?iso-8859-1?Q?8aErCT48FkXdQ/IZ7uWgsg/Go2AH40YkoNSZSt2ReSh85jUh5TKif3sGrx?=
 =?iso-8859-1?Q?8ZqPhrlMD2DdI2d2xHSU60YnL1z3bp63UPR1kyVeXU7kC4NZiGb4iG7Pxk?=
 =?iso-8859-1?Q?3WeSMXmr7szSTgr9hZNGmdPt79BE3+SMHezQhr/ZacRGkvtk/iUFl2iHzU?=
 =?iso-8859-1?Q?vFnoRLR2fjvLZTrpCeu9FrfvDRdHUzgmDn7SuMZwJzytPzGzv0rpjZRXza?=
 =?iso-8859-1?Q?v0Hc21JIcs2MEW5PePypayfuyYRuehZcKvK7boDBMiuN+yEHqi7T+oQ/aZ?=
 =?iso-8859-1?Q?WHUSNQfiTbsaHR8vXeihMPDx3tnOQnLqHRvkmJHBJWdf8NyY99ShEy5fF0?=
 =?iso-8859-1?Q?6RKDwFABO0iinHKUkSRfeBQ4+sHXYopYg03lx1AW3cHamD7FQ0VZmG1MF5?=
 =?iso-8859-1?Q?5nKNx9nOolUEcQMa2q0SM/wClbLOqmH8o3LH0TIHfjEL8kYlsiWuW9dOB7?=
 =?iso-8859-1?Q?pWzmNT2bgY1ONMQc3K8a/CUQR5jWXF7TnGUu7Ee7E+cypDp8PQyRHbGeqQ?=
 =?iso-8859-1?Q?VvdFd/suLrSk7eRZkLGLMTfuQQ+B43gmQCPllDVallWw4O/deq/jmphGuH?=
 =?iso-8859-1?Q?XzfwwYp+tCmlrttduQyxq4FtQM9/XBU46RC5OqXsbS3kwXxLANlTV6HdEC?=
 =?iso-8859-1?Q?JlApnYgsuiKvPQqJE+s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4l3CFsiU4xvmlPFOUW/iKlWrGXKPvNSF+e5sMm2Cmx3MTti6R0hQaKVdPR?=
 =?iso-8859-1?Q?SQCmED2Q4A6Oewx9tSW0NftG/tjsicf7KSdzm/zfDVcLcpvkpwKY8vZ2Rf?=
 =?iso-8859-1?Q?VHth1OAEx7O1C3euu7AL0SIzMmkQDj8vKTcuUXbpy5Oi5JxUnknxUh7lcR?=
 =?iso-8859-1?Q?VTI/ehGbCLwjkWRE7qMrYZZtSPdmERVrq8cogEIaMaHU0+VQXo9WNxZTAp?=
 =?iso-8859-1?Q?72bcoTElD6GDSD3w3MZdIW+CKiwW+N/VXcVTifirFnKAKwq2TEkE4n28QX?=
 =?iso-8859-1?Q?t8Iokc+Z972Xdtx+oPW6WgJOzxxa/qdVVZjU1nHCdVuP9JxVND7AteQxmY?=
 =?iso-8859-1?Q?8LjJPEqQu4kQxJXlJjenOgFTnbScLvGopwpewqXLW/5CRUBCx95IxX1s/7?=
 =?iso-8859-1?Q?CAqsLaDYoZhVDiQLAiU1ZjW1neBxqfaQr/rxWqtVUdAR1L+c0qw8jVg4Bb?=
 =?iso-8859-1?Q?+5ZyBw9WQpW3Vqc8ibZ5bWHxXKzLp6T5BhpyldxbkfGTh+xRi+8bhSnhkp?=
 =?iso-8859-1?Q?ke64/jnIv/rLVlkRCpiBdhXST0bhxVe5286qVIjsIWe7GM52YpeSolIIQq?=
 =?iso-8859-1?Q?yQs7y1A5UH7vmiWWsjSDx2CZ4DuMFIQ4LcTv/ET+UWC4szmwSnPk2eaMuU?=
 =?iso-8859-1?Q?xy+D61QYDcp8ZSco6i7RX0Xjd7LREatpKbwZyRHh3894MLuEKmnwoDZMTm?=
 =?iso-8859-1?Q?m5XpturWg9bI0kIs+MExvvommPbgt+NYrMbplc2Xt950tBGruwYlgmSZTZ?=
 =?iso-8859-1?Q?6FMXh9e5CfVJla954GGfh0e7PjbaHj0wDh5bnrvQKNx2N5rc5bDjNDLW8c?=
 =?iso-8859-1?Q?Lez6yUUMHxxYg1Y1DfYoTDUyp+AbDalH0ymeHOBfmu4ZkH/FRAUL2stkeX?=
 =?iso-8859-1?Q?y3nix7XHl6nE1Wx65Kbb0T/IAlb4UMyYfXTx5FB8rJvk7t2uquK8d9jNzZ?=
 =?iso-8859-1?Q?Y3fyRXRRJ8gj5jbOJRMZ1ZFHVG8dtSUFqS8HtFaWNySXHkwKnbQyYF8vTN?=
 =?iso-8859-1?Q?U3sfufwNYejIvEfSDZJjwOLw3s+Tsd8wBjdPYt4yBRV0w7tBY630dW6ZZi?=
 =?iso-8859-1?Q?/qrE6OUfz+2v4XYQYL+fKXjl9KWx13wdRroDEzDTqiVpgqK8+1o/nPtYqh?=
 =?iso-8859-1?Q?GpdElbIsSpj45A2RJX/wECRmN2xe/Ed+gtQEhALuPFy5RTTPpFNYFT5la+?=
 =?iso-8859-1?Q?IKScSUZ8brZq9JPOLyuC8J9hG47RyiN1HOwoQPglQ6a0ympdctV8JLFkKs?=
 =?iso-8859-1?Q?wvvwyOem8f5sV+C1J04GWFxGueP3YzvjRgK5LjtKB7R8PLweYOggLo3eDU?=
 =?iso-8859-1?Q?hP5LHMD3jCKxXnObPC5DhBxn0vfGAtvf0QPVwaX3u4pp7NPyh33fL8bDpb?=
 =?iso-8859-1?Q?6tDXiXqhvy+r6UPn+CUyw6vbGMpLj1fOXWdOBFDerfab5xTmf/kw6MKk5K?=
 =?iso-8859-1?Q?RZvWCC8XDUiaqHtEUw6DFpze4/DKLnFK26TJ57TI6JTFIoyay7P8ZrvD+8?=
 =?iso-8859-1?Q?Qg14jJwD7PMifcSLqK9UIcg6/RaXvgwks9soeT6RLFgceKE3zFIC/fNeeH?=
 =?iso-8859-1?Q?/8Tj5fJkbCR+AHQ8W82OQl32DJRjqxtKcCfvGbP1az5USo4flGmGdDJ8gO?=
 =?iso-8859-1?Q?lmxKyrlFvIc69ltllr/FjSlOxGpAbfr4Ix+rXFwQzJX7srXr/XAv1GDEew?=
 =?iso-8859-1?Q?4sLSNu0PpwZXTXoEsCCSsi9+Mlh1P8V0/uCUPafUKScy/kyW/x2ricWKi+?=
 =?iso-8859-1?Q?yfoSWpAAdvmG6YGR/eiajI+/Bqjzz9zKejTNZWgTLgqVjFrXNIC7zs8gTm?=
 =?iso-8859-1?Q?Wm8+g5dNmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0fafac-c156-4be0-8169-08de63c66553
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:28.7274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNY9hy+gTytv1660q9DoF5DdUJEyI/NtIXEE4gIeAAld/VIAmyhaCyEa+kQdcPSwc1+Pj8n+d4ljxXP0ZsygV45jPUAKBqLxTYiKrH5Vzlc=
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

Connect the SPI device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 hw/arm/aspeed_ast1700.c         | 30 ++++++++++++++++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  2 ++=0A=
 3 files changed, 35 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index a981bff3b2..89562eb64f 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -10,6 +10,7 @@=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
+#include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
@@ -20,11 +21,13 @@ struct AspeedAST1700SoCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion iomem;=0A=
+    MemoryRegion *dram_mr;=0A=
     uint8_t board_idx;=0A=
 =0A=
     AspeedLTPIState ltpi;=0A=
     SerialMM uart;=0A=
     MemoryRegion sram;=0A=
+    AspeedSMCState spi;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index fd5db3268e..97990688f8 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "hw/core/boards.h"=0A=
 #include "qom/object.h"=0A=
+#include "qapi/error.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
 =0A=
@@ -16,15 +17,19 @@=0A=
 #define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
 =0A=
 enum {=0A=
+    ASPEED_AST1700_DEV_SPI0,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
+    ASPEED_AST1700_DEV_SPI0_MEM,=0A=
 };=0A=
 =0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
+    [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
+    [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
 };=0A=
 =0A=
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
@@ -33,6 +38,11 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
     char dev_name[32];=0A=
 =0A=
+    if (!s->dram_mr) {=0A=
+        error_setg(errp, TYPE_ASPEED_AST1700 ": 'dram' link not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* Occupy memory space for all controllers in AST1700 */=0A=
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,=0A=
                        AST2700_SOC_LTPI_SIZE);=0A=
@@ -57,6 +67,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12=
],=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0=
));=0A=
 =0A=
+    /* SPI */=0A=
+    object_property_set_link(OBJECT(&s->spi), "dram",=0A=
+                             OBJECT(s->dram_mr), errp);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 0)=
);=0A=
+=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_M=
EM],=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1)=
);=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -74,6 +98,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=0A=
     object_initialize_child(obj, "uart", &s->uart,=0A=
                             TYPE_SERIAL_MM);=0A=
 =0A=
+    /* SPI */=0A=
+    object_initialize_child(obj, "ioexp-spi", &s->spi,=0A=
+                            "aspeed.spi0-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
@@ -83,6 +111,8 @@ static void aspeed_ast1700_instance_init(Object *obj)=0A=
 =0A=
 static const Property aspeed_ast1700_props[] =3D {=0A=
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),=
=0A=
+    DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data=
)=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 6a144742ea..2fc50af8b4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1024,6 +1024,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
     /* IO Expander */=0A=
     for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);=0A=
+        object_property_set_link(OBJECT(&s->ioexp[i]), "dram",=0A=
+                                 OBJECT(s->dram_mr), &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

