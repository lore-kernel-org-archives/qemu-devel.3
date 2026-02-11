Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB28EB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq2hR-0005tf-Sq; Wed, 11 Feb 2026 00:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vq2hO-0005t5-JG; Wed, 11 Feb 2026 00:23:38 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vq2hL-00057N-Tn; Wed, 11 Feb 2026 00:23:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCNPIs00fgmqVSqSLOXii8hjrV+7XTtzyLya4K2yu9kCZbVL0V7B0snxldxVpG2oqYmwXvKskKwZr+vaz/DagEkUo42LzeUNjCOMjuZbxNaE0XkragxiSKAtx+24Gf62zJyCsy4JtuB1kH1C0T2aIaaqqp94ht0n4AgGLk46U6M1TIlEN2iTjGE+WvU8Cvg2PgXBoaEt6KftiAPz/0Smk815o70qPnuhjYU+23m4MZ7UfwLsCE1cfTeSpuopUG2pqYqYMt9wchURNIrSV9oTZtwHm0S+JRZLhyxQ73vk7+m5WtCW59w2lvwR1iCHg3WRTKAG6TjqcCddiyccF97iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y+Yb4bIpldp7ujMqqzftl6g1hOWqk0jfqC3rdWZnWw=;
 b=WVcVcxvBGjM+U2BYDfelecLfNhD/vtieiUzJnOnhCzYQsZACz+KkfQcjGuY09l/Q3i13NdHQljE7OvdLwwIooBdCE4zZ4CgIS/4tHJcVqzzqzilRvSF3Sigvr52WPDzi3LELnZJxmc+MRZP/Rh6nHKUa/1lP3cvJnGVlzSkHjMg3RjBycX3wWXsWO/9KK6Ycmyru4uGpFmJ0E94KDTFAl00reRbYI+Ho7B9itPBqh29BJftp1MzCEncTyeQN88pItAGYe5WxAGFuJv/Ifg/YGh99G9mw1aFTrsWHokbGr1aJKqFdCqohxei+9CBYgbszF4xg3760PfTQWYiVKg1iCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y+Yb4bIpldp7ujMqqzftl6g1hOWqk0jfqC3rdWZnWw=;
 b=omQZD3Y8FufgzQpVHdIxnQ285a89jSCfZi1RQ/afLuhVJvtlgaWel2cLTtJmRgMLMLvGFBkS6hriz9gg8KXGvwik7TKErPHdrktlybJKXrM03Y6WAFAf8KYoeFjfWatScajcHOhiXukTz3gyTLgMt+v/yt9NzXTP4VLFa1iTbj3cUKvxUuxFTTkVODxqLzKAnmw8WN551jJ/D5ZFxMFN6myIKuaubWmMC3qrQUoNLkLmm0yISjUEcCRKcvEHVHybrSK9Pxty7gwbo9t03fLOK9hBgVPwivA5mnQbvB951ghbGqj4L4xiGRnjs49R5v4i3DjMoMWDxEyV4EWsscbTOA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY1PPFDE013D005.apcprd06.prod.outlook.com (2603:1096:408::92b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 05:23:27 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 05:23:27 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 0/1] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Thread-Topic: [PATCH v3 0/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
Thread-Index: AQHcmxaNELzCn8M9hkOWpMpkNLiuzw==
Date: Wed, 11 Feb 2026 05:23:27 +0000
Message-ID: <20260211052326.430475-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY1PPFDE013D005:EE_
x-ms-office365-filtering-correlation-id: 15f93bfe-9bb1-420b-cfd8-08de692daf94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QkNXYZylhFXhBN9MtOwoZylOaahVtg323nPCYflvxetYKB3t8AOaM9amAw?=
 =?iso-8859-1?Q?EyUcbvWcYdVdOEzlT9a3un8NO91WhzSbkOdRxd3Yfn/P1bS4iyxwhvVlLA?=
 =?iso-8859-1?Q?MDdlswkmh1p6PDqDw9IOnlAuNS30Q1Tnq0uaDTQ78gW+bSlFRIJa7P6yRs?=
 =?iso-8859-1?Q?K32Zry6tFQ9a79JdD/rkSU2+rXPd70LOWgIEq+wDck/WF2XA+rRVqBQlcP?=
 =?iso-8859-1?Q?NMOqBUyBdV8TBPwiWcSQNlpczEY7du3hSE4rPGcHZnDC8+sQOaF6iU7Sq5?=
 =?iso-8859-1?Q?8uJih4v5VyAks3ZahFGTPjkbL+QZz2tMriCsangVLzBCjqhAZU7q55xoJC?=
 =?iso-8859-1?Q?DrABOFKhz+Dmgsv8R+zod9OL6j1uhkW5ojYLJPhV4ekCwzQRLtMFohfKdr?=
 =?iso-8859-1?Q?6sEODzkCnUQnmIheJp+662ILHaUwzOppPIiMPmJYwehgu60Znsuk5qtLes?=
 =?iso-8859-1?Q?xoiLb8kJchamXUMGuZy6fmUkh/n4rFdP3rDiwsqQslgZBRa4X9nXitJ+Uw?=
 =?iso-8859-1?Q?HZxn71ooawseAEKLF5ShVBVeR2lbOJTRuBg866Bp8YWjroOo4PrvXET1vQ?=
 =?iso-8859-1?Q?82hey/R21Yh6TCk5Q7Dde/412f5DOxoEGSbXzA0p5Cq0u0E8qfAd9Ki9hB?=
 =?iso-8859-1?Q?6BN8MILjF6akya395mHntkVUkTfKY0JjZfev2HfiKuNiXBCsQJ6Hl7mNuP?=
 =?iso-8859-1?Q?kGi0Xair9E80ZlOqOpnBKX9u3Wadj7ZacvYlRv49SqLpKipmd+2DtTx3wP?=
 =?iso-8859-1?Q?FyIiqdfPRXqZ3h8rmU88bkGDHs/IrDqbddI8s6MKvXHnSButi/+AWFnDOG?=
 =?iso-8859-1?Q?MtmaBmIZxTVALIi9X1SBy3Nm1lPIBIjtbyf39wqOAVKvMYadcoraxwWHrP?=
 =?iso-8859-1?Q?B1mAgbV2RBc0Yao5AW5jDsbTcdV1ktBYjOD4dnvWK35kgzgVQ5CI4xLq59?=
 =?iso-8859-1?Q?H0mf2boqgty1THPT3ZduNm72TEBL0T8jMj7nkkmSmRYxKh/zQi0At/rToh?=
 =?iso-8859-1?Q?vgw7z34Vs1lHDaT39arOHXEto69a1R8v1DHnVzc2PrKPhx10cBbkhCiN/y?=
 =?iso-8859-1?Q?AHBT3EIpurO1sEpGnIr37A9is7ANJZ8vA2ROgzTwfOsQr65zcWKyNsaSe9?=
 =?iso-8859-1?Q?tJL6f0ER8l+nme+zFlxjCJLpd5VNzQtb4QUw/nKq6ji9qM2xGMGRhVj6QP?=
 =?iso-8859-1?Q?+MPLIiCx2LI8vvhbHnpasI0NfktSEhG0npSCXh/B7y9DXwAp8LgyGvn6Kh?=
 =?iso-8859-1?Q?yaLzSNGO4Rnqnh06WD0lNFWk4oCjIb+/EgKPaa/B6dVZTpr+TCF4EA5wxt?=
 =?iso-8859-1?Q?gTbezldyex9DLbBEByTifFClSEpKjUT4FPfXNHqcFz0GP3d7LXGY7rLjas?=
 =?iso-8859-1?Q?crmgwju16IYJJKx04kErfrY6iA2roH+xb6LqOgPAbDCEJadNw2ZoTR4idO?=
 =?iso-8859-1?Q?pFkUc4mqsFg/dYN7hxdTJqvuFHs+bPsH0VsJ+1qx2q9KSoWLZUaMtOw7eJ?=
 =?iso-8859-1?Q?p8csU2u7HyfeDzR1q0oBx7KI/O/dZEvVMAn6k0i/wkQAMP5dNZCgbstsfs?=
 =?iso-8859-1?Q?qFsNqznh2QhNjMM0SFg6YegDuWSg7Hs90MGaMQjOLvi/EXm9NC4v73lKVJ?=
 =?iso-8859-1?Q?SUiUD3rubGHODezPY0pXPcmd2fzaQwX++lnFVYRVxvUKyZ3T+eQvtpSd5D?=
 =?iso-8859-1?Q?+6GzxC8oLpbyOwLdxWg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ROp5ixTLC4/RqBMkXtmZ6MS8RgYYWgsfapujMn0SHEDhFeQQ4I7vJEA5Ka?=
 =?iso-8859-1?Q?nGCQvQ5iDCxbvKNdzN8+TWo1+/MS7X0ZY7EIkZmu6V4xdG4PUe7IvY53Jr?=
 =?iso-8859-1?Q?gsgOBnhwWTJW6/0bNbtIFf4lawBsSkHKBSlJ9DLK447q2qQ93Cerl9AfDL?=
 =?iso-8859-1?Q?gbEWXYuZgH3D9IRciXxGaO8kzlcBAL4VVzBWvjnlTKwyImXadbxvQtXxas?=
 =?iso-8859-1?Q?5YJS1Jlzr3okVbmeE5Pw/m3mceJ2NMhertflRVLzJRVjG/lrxwxsoLNZib?=
 =?iso-8859-1?Q?3wwbKjs8B6OYP9wzvycl3stLcUm+QFmwjhbL1ERud1HvkIn+I1yjgbCDEh?=
 =?iso-8859-1?Q?gdv9gKGrWJBgFKIwXa8QKxmd78mY6lw/oL8BM+4YEG5n90SwWe/n/R87Gn?=
 =?iso-8859-1?Q?UwNtvEmoOvZxpiu5VfnWHuR6VLvDegbiRaEsrYr6wQISXp27PcTUTbWwbz?=
 =?iso-8859-1?Q?r9rlPNEABYq54twZcSkILH0kwgJyx/6gRQcMCemOmgHz9UbsIhTzaNy7xR?=
 =?iso-8859-1?Q?rkd0Qr0N7VeL+zvUaHuCjGv/56DX2ikzjlJVlNC7w+Keb8pwsWvDWkcBMq?=
 =?iso-8859-1?Q?5PGMOOULhYzkbYQmDbKQpVMo3cZXHzLzXINacwVsGqIy2ZFenR7TzaFjBh?=
 =?iso-8859-1?Q?QznTEcZdq7AveyF8z8uzWkOdjVXDj4HJKoizjYlmyU+M6NEV8AfHvIJPD4?=
 =?iso-8859-1?Q?v5T/ZapZf4/QXJrJWAfkPp82aM69QE3FMZ5BMWWJumz5z7uC+WdjiIO7kH?=
 =?iso-8859-1?Q?h4YLecA0MdTFH2ire+JAdXwnJq4BilMnXV/u5wsKPenJARV4D3RL7wA+vt?=
 =?iso-8859-1?Q?Ycce0Wgb+76M5XB6KnCdWHaK4YsumaFXPL9fuH6Dea4VBKHPQmj0SImMcW?=
 =?iso-8859-1?Q?hKkzWTiJuBpa0BTkg84JvWCD9rntUlfTq0N4UArsWULfKPJIrsgYbk+HCY?=
 =?iso-8859-1?Q?/ng087PyOOddpwxJud2jlXWKocq71kkmoWKW5/eEAUfNekXTVHoYXPt/vG?=
 =?iso-8859-1?Q?tl3TcG4E69Hb2GCbTdy7qgRG5tJixoAYdI+HkQ0xOsgV4Mc0eDB01SiVir?=
 =?iso-8859-1?Q?tEDq8dBrf2FXLmCtRZr6ESVA5iSzAmld9P2Yp9o+bc8QiBj1TVRiiP0+Mm?=
 =?iso-8859-1?Q?rNxi7LY5244soa9QbKS98vRh3zDRRLcjhHT+ZKrs5zgfn51w1RBddFZHcw?=
 =?iso-8859-1?Q?SH3uPVUMfT1tD4GENEtVkxxgWKCQCjYHF5X0FBy1vLShVpnhYw3n8nDVoS?=
 =?iso-8859-1?Q?leKk5vsBUDIaEOJg63BRw6LeKSq6TtvImSY6ma9JU84jaBg9biwjpL6spb?=
 =?iso-8859-1?Q?VyzMkScHfamc6hD0A4SMrhc4B96WPRVWpM4JJ+d2d0idl3SX6sbREJoRT3?=
 =?iso-8859-1?Q?gYrB0fw3s18Qc7z5/7HJm9w8yce5BPnE/bUSkCz08nw1K5so7d6cE7fILW?=
 =?iso-8859-1?Q?1j9fx6tvc6rTCqxNxv6iVU5Xc5jvYRL6eGe9i8F2/Ow4Q59BqhU0FM1yjj?=
 =?iso-8859-1?Q?erY3oYimiipbHKUWelkeikItoixpFWmbQ6wEO6A0oaf0+E93+Lz5QpWG83?=
 =?iso-8859-1?Q?FHQh1eHHPjAOLCSQVug7ohOmsulp+FaMrr12r/7CNaEizopSA8sbviqZCs?=
 =?iso-8859-1?Q?a2ZuNMI0UWytFEvA05pTbFJAgi4qRSc9tBTZJI/wkXwvOQ3JwL+FNQ+c9g?=
 =?iso-8859-1?Q?uuOGIPczNWP0KSQ1UwfLYD1PJU20RQXwzRnz0nGUdpoe5QFTKoeFboHjMR?=
 =?iso-8859-1?Q?B5vkSSj2OBJFqDq5Gp2X3CkvN/VA864+97frB2ctLTLGo8bp6N5zXj/HE4?=
 =?iso-8859-1?Q?RwSNCpqjgg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f93bfe-9bb1-420b-cfd8-08de692daf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 05:23:27.3005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekGItIuNWs5a4yediGM66+5nEvxRbLfCmtzfXrSfegDcJzMmmP/TaCXSZ/8MHeOFD1e7Oqf6j8jTVXYu202ZT54aholjLUUZ85/3kC0lfng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFDE013D005
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Hi all,=0A=
=0A=
This series enhances the AST2600 OTP functional test by introducing=0A=
cross-stage verification. While the previous test focused on basic=0A=
system boot-up, this update ensures OTP data persistence and=0A=
correctness through various execution environments (U-Boot and Linux).=0A=
=0A=
The updated test logic implements the following flow:=0A=
1. Boot into U-Boot and modify OTP strap settings via CLI.=0A=
2. Boot into Linux to verify the consistency of these settings.=0A=
3. Trigger a reboot to ensure that OTP configurations persist back =0A=
   into the U-Boot stage.=0A=
=0A=
Note: This series is based on the aspeed-next branch.=0A=
=0A=
Any feedback or suggestions are appreciated.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
---=0A=
Changlog:=0A=
v3: Restore missing blank line and move require_netdev() to the top=0A=
    of the test function.=0A=
=0A=
v2: Change title for grouping the patch=0A=
=0A=
v1: Initial version=0A=
---=0A=
=0A=
Kane-Chen-AS (1):=0A=
  tests/functional/arm/aspeed_ast2600: Enhance OTP test with functional=0A=
    validation=0A=
=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 3 deletions(-)=0A=
=0A=
-- =0A=
2.51.0=0A=

