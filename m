Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB983E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8w-0002V4-OJ; Wed, 04 Feb 2026 03:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8u-0002TE-BE; Wed, 04 Feb 2026 03:21:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8s-0003UH-O1; Wed, 04 Feb 2026 03:21:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcEou+fQFnVCzmSenuQrzfLUwcIWljZ2t6SJEZC8R7hBapHi+zINz9UpgyOQU9Ig200sYnmDolNFfSTRzbDhYG04zA+/30nyqdBKGbbz8393EAcKexv4BLAN+VSDYlRp3Da7AGJSQn0cxTu3ke+pTP8nr5CwoO2Uau/XO38mfjtd6NvOg/txsFqKxH5WIXa0mGiBFIv9QnXVIQD0CcVpt3vywFqATJAqj/SJhktYdZPW0iJI7RzDkhhMgu8jbaRxDWo4T/2OclUknJWc7tFZY6+vQ8YOmpNVIdJRWLSAR3clluhaYeLLM/EYS2ERgIhwqRXLqGKUTyy7MRi4CQe+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SHisvAwaHMPYzuiE0jFYe6ncyc2PfyIyKOmpyQW73E=;
 b=mXCaMJjIrIE3IyDa7w2H1m/te0Z8NfSlBgo4+IjFkDWdk1KsRlqJvSnBpXymPIupRjNEgkWybzEpD+7ZnnBQYD1IWx26210UI5thFFAazldnjDxlewPoyZQtMJTYg6Xf4haHZlGHeJ1CDIGnVRGS3kAKyXDc2iJ6qnPrI++RaW6Fnwbcm8CLv3K7hMohgGqFDymoKOhn2wNJCdlr1xHA1D/y72grPYS8R5xoLnd+GNlIPnLzyC7+xXBPR5Az0xk0bq4LmnHQhCpTGFFpoBXvUBb8/IhMasjjR+FYn3+Jl4lX3s5TRDHp2FqG9llWVMjmTJDORDJfCFigyoc218T0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SHisvAwaHMPYzuiE0jFYe6ncyc2PfyIyKOmpyQW73E=;
 b=TYCmW0o4OMEhYlHg0gT6DTm9czioHUPS4WwQdHOE3mYM/QOYdPG9bek/FH1zPkeporaMd8BvFrlmhS2D18InAoIcE85Mx5gJCYSqP2jpDY7ga2nziSc9CraW2+5UHuRqPLW5CTqOrz3YChRtuDcDSQr8K9H+M0TEPQ6kkqNN/iw/NMABXQ/xeAYNOolWyb3s3uyUwVmA4B2pcJsMscr68P6J8pyQlVrHEaf/geLjCuezT6BYR8PQajjHXWO0rD9FVwY8jMJ9avgxtSPrlF3NNCBr98z+XscSTle9pdnYRgfdI3e6/BvViVDf/REqyxnO4R8N1yJsLop1dBNWYoYfCw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:33 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:33 +0000
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
Subject: [PATCH v7 13/22] hw/arm/aspeed: Attach GPIO device to AST1700 model
Thread-Topic: [PATCH v7 13/22] hw/arm/aspeed: Attach GPIO device to AST1700
 model
Thread-Index: AQHcla9Fl9WNNfq9jkS8aD7R1v+Cyg==
Date: Wed, 4 Feb 2026 08:21:33 +0000
Message-ID: <20260204082113.3955407-14-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 48a88659-0ac2-43b6-f22c-08de63c66823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P9Cxko0kYhlyWq66IXIVePqh1txbTmAmvm7mCWFFayO0sALtKPgcO5lP/Q?=
 =?iso-8859-1?Q?/iGoad0OUewbCTMN6g+6Yt84mAtmjUQBbzlHNOmez9N2F6sTOtixZg274V?=
 =?iso-8859-1?Q?EtZmKeci7Lk6ORfCuHPayfr3z7rO/MaRb1uiJzZtCH/cdkIUaUz37dIHiG?=
 =?iso-8859-1?Q?ZSlPI2wcRjaDk7VNKaUE9D2NbybOuSOVZOMLxteLIaCWBnKOQ7rBxbHPK+?=
 =?iso-8859-1?Q?GgmJTC9Qq1g/dsIle/mlrjkOMa0RCVlS7JwE5kPtfVClekMaZGA25ueATm?=
 =?iso-8859-1?Q?K1LDpHVpYPpBRH8TOziJk4MBDdoKfvRodpkuBYnK9urgGlyeXmmwrXHhgc?=
 =?iso-8859-1?Q?68VKdXGQ2lritFLs9kcrZ35myzbMZKfknh/mIKkoxfMkB0xKaC2HD8tQI4?=
 =?iso-8859-1?Q?AZZZixGixiQA7h7E45P/iouOd+h4gx7+WiOyto0N6x9mlmCoeAIicp/FrL?=
 =?iso-8859-1?Q?33j34kS2LDgWL/EqW/6xEj6PWgt49086V90kJqWuTCOJ1ANLOKtT6kEgls?=
 =?iso-8859-1?Q?halW2aGkih/o8rOku6LrZZcjAd6suPUcYRYCZ6j0d7s5Molur65uyG0Yu0?=
 =?iso-8859-1?Q?olwrSfGazdAdy+n6s9Dq7HZh+Hg/Oc66kz9e54xpGtiS1Zkj1Ixn7O30yd?=
 =?iso-8859-1?Q?QH6tUH938qEi25srscJsdNd5fBC4XW3oyol0lEGUMNj980wdKN6oFzygVh?=
 =?iso-8859-1?Q?aTQN/DlnazrBz5G8TdI0S1doYUU1ximdXqt2tTOOGeMMdCQd/+3o84kU9S?=
 =?iso-8859-1?Q?seHF+GpMZ2KMo8veQl1sQdAfNnyJJpITPMIoaxSUu/85u+Ssv7w06fBO/u?=
 =?iso-8859-1?Q?vvcTYs6EuPXkwwusRrkVcPIaHJinpfAxpU4ASFDNjxDMsNCYjXaxk5GizU?=
 =?iso-8859-1?Q?Fzpcsu3u5T7Do0sljRoPLaQl5nLk/B/WjqQupOos3mxQaRJvIavVye7hgz?=
 =?iso-8859-1?Q?5nw41f1mhazoNAaqC00Sf6i3btSukC/WlYPeietTM6SvOAwjixdsuitoCZ?=
 =?iso-8859-1?Q?gxjj4Q5gMQXd0RyV2cwT2IqOPcM95vZBC0KT+RS5ZOkXIkr/VdFq445/PR?=
 =?iso-8859-1?Q?yOmHFiPIz0gWV8mFmgRvVclsAKI4oLJMIQrT4ZvoJebB3tzrAy+KnVwZjT?=
 =?iso-8859-1?Q?f03bvhPIBCJdD+C21307o+4UDMyL3CQv8uIvKEjnrfVBexnm6rcuOqILxc?=
 =?iso-8859-1?Q?QdxS//rDR5TRyLhEOTnSz3JYek4pV6REKGH2i6OMar01CL1fhMT+gF/YjD?=
 =?iso-8859-1?Q?Gwy8Wr8YKZiI0odlG11WBrBoSeV9+rV36buiqCQ21jjtSREoPdcUXSoLP5?=
 =?iso-8859-1?Q?cjnkDVGnpT/XuGF7w3OUKXBj6E5QYRA3Ce1im9HIc5yj22+y8edI0MpcZS?=
 =?iso-8859-1?Q?wqVq75bwLFOgIddsr2WkH2Nzx9koKCg2qJwhLMV+nBWaPq2GXVp83s0w8v?=
 =?iso-8859-1?Q?2Fe5ECRgAoNKoFaqoiw5pAxEsNxVdo8H0v6G7TfTkjwJc2GcKojaiAf2HQ?=
 =?iso-8859-1?Q?lW7rQ07clM6kZcyO0QOUjCwKFkPB8EnnU+PF60AiNBYpD9ZtCZRhIK+9pk?=
 =?iso-8859-1?Q?v02da474oY0dOwqYqUkOLpiWseFYSTDRrCxKIBHJyQHcZXDJXs8U3o8UtO?=
 =?iso-8859-1?Q?fFwSLRGiE7sNuOwuzbColS8rPbIaaBIvnqRIlbDcL/5XpkacM11o5NM7X4?=
 =?iso-8859-1?Q?3TslcGQWKrOJHOPgXvA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TdC2wFR6lKsqyKq/2PMtOrqXZt9tzXnHUFnIxmdasN821tyiLGjE08r6G9?=
 =?iso-8859-1?Q?YIP/gWlThvD//kzh1s5jdApuTKqVCUCj7Fu4Ug1jyTEnXUZBUAyp/TzEV9?=
 =?iso-8859-1?Q?dbrRkJ2gLISft+hQkadl09/x4dGLmO/59oH+SshpAaOn2B5F25yqzLOEkq?=
 =?iso-8859-1?Q?oRoAOHVlxcuJcXnm4/FhzzxwFX4Ao50vE0ty2ZFVHVt/EVuhonfvhgezYf?=
 =?iso-8859-1?Q?FrbFrRO+MRhlV5mjRR3IbAEyI4ZkdXJEQmsO4jHCszY3ocVIGgE9wUeluT?=
 =?iso-8859-1?Q?21aer4XtdeE+KNuEodqTsU0UoifCUx8f14Q4SlcK7fyS6xjoy19BQvugde?=
 =?iso-8859-1?Q?CEodgdoup+hhYieiNZ/zTDkaXzZ/r4I9Qdh3bemyRr70QkKlGXdqVYoIWL?=
 =?iso-8859-1?Q?rr2jxRY0DFsgabkviVeO7Mg2rGazLVXDqzHlr8hmSGLlRqZPYH9yEpCwyR?=
 =?iso-8859-1?Q?qtsw6nW04xeh0UOwWt1n7TbNuH6oMUyZVbBQS5h1FDNoYvkRVOCzUGl6zp?=
 =?iso-8859-1?Q?fuQVfLhR4LMovqVy34TD/YlpurMJ1SfuZmjXvqb53/JfDsiJ80j3kzf+bS?=
 =?iso-8859-1?Q?qmYSHx3UhysPDv6O2fC8Mr9MKYjObCg94xUj3QF1Jynfnh01GOQOhs4qmk?=
 =?iso-8859-1?Q?WZpdVDfgAJJjsR01Iknbt36ZkoSG+RuYBzkC3aDLiafKVYKtrEILqlqxap?=
 =?iso-8859-1?Q?eRmUF9pQb68aHIfAhHwGD+oZCXFNOFvbIbxcFHAe41n/b2p/J06KJ+SVuW?=
 =?iso-8859-1?Q?2Z9xFhmXoo0fi0p4MhWwiQ8DA/xm9GuQYtYOXny+P7FVHw215SdDJJMRMc?=
 =?iso-8859-1?Q?z9ndXgVFFW1M6QW0Wk99oQRsfOJpiwaQpmri0kj2X3KpB5zlMEe0EHKESf?=
 =?iso-8859-1?Q?zxNYbEHKtOlguWbqdx+N1F6GKB4ltHKhwxXBnhswzxD05NW8EmZt19d89P?=
 =?iso-8859-1?Q?+fqvtDZA1L1zebqlCLwq+7DwBc16t3w+tCh8oJB5tUQ+9SrmAz0mJ2J821?=
 =?iso-8859-1?Q?D46UUkGycE6f4ApBnFgRuRq+U6nHynLYlnWba7npCn3Ec9CFcGtV7QWvey?=
 =?iso-8859-1?Q?MVcJen1Q8Kxj3zXtl8aHIL3VIb8KzBmA53JQqg7yb7jH6vH5ER8tZmJ215?=
 =?iso-8859-1?Q?uO+xj5CZLG0KGQ58aba+G2mMDLs/KA7z/8FvDt3iIojVJiFn+rCzeIAvhh?=
 =?iso-8859-1?Q?5irfogodi3pCne2dzD+Q54cSd8cuiILxte/REFtaaViA/DhXUz4pb9iM+B?=
 =?iso-8859-1?Q?xzGwpwXgbWPF4iR/qHrVi8NiyAM1TU7Uyf/gF0aH3j8ICvg4TAnu1yjZx2?=
 =?iso-8859-1?Q?eQfU/Y/JsffjTKQ/1cQFBJqWADYo3fQy/z7FE4TEwac0AqUr3KZXhoYWn1?=
 =?iso-8859-1?Q?+D364PjwJpWNZLSgZBea4uCeMsBaL4Q1bQuycPYjig62JO0EO3AC8K/+jD?=
 =?iso-8859-1?Q?nCYfiWJfboXT8Azr6+kgr4x4XI3aiEUMzOQizUg04AvoVyxGrMpkd4GOkv?=
 =?iso-8859-1?Q?CeB3ZOjtyDKKZp32DuSJmEegY76vTf/C0WdYqdjDQoXFNccsnQdQi0Pjl2?=
 =?iso-8859-1?Q?6pvGYc/qBboe1tFjay7qPCdYNwQxSy70zpnf0JEHZ/n7QjHId/PxpxDdJ/?=
 =?iso-8859-1?Q?W7+rybQdCEHJEZA23Sva6BsxuPLZ4mSLaeIiPjl0IYqp7Ot3ElvdXJK+Yr?=
 =?iso-8859-1?Q?m7w9u32480FaEy+5dha3akWJVGvyheG9mDhxY4bBmtzmKdVVU5+fwJkN/m?=
 =?iso-8859-1?Q?JNR0gJPVhI3JlPcwG8JPR6z6SmtdnBNGKmkKCgzvR6Ah5j02OF8niWt5KL?=
 =?iso-8859-1?Q?x0ZP/euWVA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a88659-0ac2-43b6-f22c-08de63c66823
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:33.4619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAQBL8JQPt/9N4H0MlP+BTiPVIhNsPQ38se1DEt29D1xLeCJLNXNnZH/y+pXp83nfoK2JPtYaeYFol7r3ibYlQfWpH5MhT3xDnjBkr6fpic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
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

Connect the GPIO controller to the AST1700 model by mapping its MMIO=0A=
region and wiring its interrupt line.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 14 ++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  4 ++++=0A=
 3 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 65f1497a2d..63cfcb4c24 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -11,6 +11,7 @@=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/misc/aspeed_scu.h"=0A=
 #include "hw/adc/aspeed_adc.h"=0A=
+#include "hw/gpio/aspeed_gpio.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
@@ -33,6 +34,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
     AspeedSCUState scu;=0A=
+    AspeedGPIOState gpio;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 49a242f3de..7efce450f6 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -21,6 +21,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_SCU,=0A=
+    ASPEED_AST1700_DEV_GPIO,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
     ASPEED_AST1700_DEV_SPI0_MEM,=0A=
@@ -31,6 +32,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
+    [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
@@ -103,6 +105,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0)=
);=0A=
 =0A=
+    /* GPIO */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],=
=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0=
));=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -132,6 +142,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-scu", &s->scu,=0A=
                             TYPE_ASPEED_2700_SCU);=0A=
 =0A=
+    /* GPIO */=0A=
+    object_initialize_child(obj, "ioexp-gpio", &s->gpio,=0A=
+                            "aspeed.gpio-ast2700");=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index cda841e103..cd4028fcd4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1053,6 +1053,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)=0A=
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].adc), 0,=0A=
                            aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC));=
=0A=
 =0A=
+        /* GPIO */=0A=
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,=0A=
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO))=
;=0A=
+=0A=
     }=0A=
 =0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
-- =0A=
2.43.0=0A=

