Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311BE83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8k-0002NJ-Ns; Wed, 04 Feb 2026 03:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8i-0002MW-LM; Wed, 04 Feb 2026 03:21:32 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8h-0003UH-3K; Wed, 04 Feb 2026 03:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLO6vEPbsOSgeEQaIBCkcJbVOZXxyNHxWsBBQLEfma6zg50KPAwlP6v76K6Iqy39r8QUx4YhBi2OEBpN3gpZ4ybIFdAOn7II+2luFomRXVC16V9eAY63FDh7y9XjS0MyKetqlwoM5l1jYkEmDDc3b8EpB1/wKhwZIWASGTVEY3Ciha06IqwlULc5W9XhbW4D2PrNA2fNMCsnbaiVJ96l6dfO2jwsjauOmen3cCmHwvmHNGoDJxHHb2QD2C8u3i6fQl+K1l5puZ1NdaSWMwf7v0NqazU1SKTTswMwsakfLz4P1OVPcp1V2A/rid/Nz2bt/nWGyH9sl+x8+k6Fgt/Jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApA103DHiEVmiECmSUd9c3zcM5utaj2sK1iix+8Keas=;
 b=DJf9ypfONoRvl/Cycw5RjNhjsqaCJGdpTPE7fUonE3AmDvg7EMwB67iFeKf2cXKsR5ILivu2VZeDWLVX3hOTYND3RLWlMyWBShKJtcm6rpCDPgrPY8Ve2YBrnrSO1zT3wkDy4/gwvlYSUHVh803uq53NA5bFEVqj8pJVnkFMgxHEe6lIIzn7G9/Ymr7hyEV2Zh0QRUqBFMYNDNDVvBf0vchDunMTbYEpd8dX+bZHU5+II9okiHsFfdhYo1Ms31wnTnA4d6hgVwykZ6hilMM6f2umgDTplVdNxzLWQqOb3I3jNL3DdOOnNWjhR4R1iBgg5bKDHpNv3nAlLO0kXL0alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApA103DHiEVmiECmSUd9c3zcM5utaj2sK1iix+8Keas=;
 b=TOaZx2WntleNww7XPBnKFFH/JDjDcQYHtym6ZmPfwClKAx0qUW9s/dBQxzVhiQCykDeGHhBTN3HgcsQPDKybBEIUfX7JWWRTUUBPWuh8h9pPcx9P7E6qlTSau/xQ1THkL3tqIn1WmByp8AjWL+mCpNaUthmIPA/SmdVVb1jsY2Shgdl6K4V/O58iE/Soj3kYhRkYB2E4pa5d/fABAvrWJD2nByXHkvBffV9ZD0DwSwcZ0oSmG1VkfOMYG2nF1aMHgHxf+FXcC/DYpKOWYPpFMOpc6L+IAshmwLfyN37EzXzZ3862o49CjZRkNC5z7Cq5Cv3LcS9KyEnE7eh01TimVA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:21 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:21 +0000
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
Subject: [PATCH v7 05/22] hw/arm/aspeed: Integrate AST1700 device into AST27X0
Thread-Topic: [PATCH v7 05/22] hw/arm/aspeed: Integrate AST1700 device into
 AST27X0
Thread-Index: AQHcla8+Dop+wD/MDEizM8EUmz5k+w==
Date: Wed, 4 Feb 2026 08:21:21 +0000
Message-ID: <20260204082113.3955407-6-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: fc67e00d-11f2-40b9-09ff-08de63c660e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3MJCttYrnkF6pKka6B6/6wxJOeWN5xyhmteOh4N6LzawNxAp1JbJuXwySx?=
 =?iso-8859-1?Q?nqg0BihTTE4Sf+9YaYpIFWyO+CX+EAAD9tpywFmXmGf4M5ihX1QBJdAAp1?=
 =?iso-8859-1?Q?M5nM8ywwTcSu/XaKQfkU4V2vdM9ZAr8nUhc2/UJ1LuEnLv7NJDdE5N0kPs?=
 =?iso-8859-1?Q?9q2iKV7H7k1X2foFqhUIlykma01SyIIuT7JACOAp8byKEghxW0ruJSk0Mh?=
 =?iso-8859-1?Q?ueMqXWaNGgd+VJ5Ld1ZTTb1p5iOQOZIYeeZR738+pafxcX5zrXgHl2QI3J?=
 =?iso-8859-1?Q?q2aUulQLk0REgwrMOHFCvg2hzBKFOP4j3YVbgeyh3nBW60yn1gKI1V8ytW?=
 =?iso-8859-1?Q?zTMNV8k0xMyimqb5Fncjis0mxHtytWuu4IqmA27RZh35DJipIlCC4S/8MQ?=
 =?iso-8859-1?Q?PJDsNl7/eKhm8Cq+VMlHjWbDmGKV0C+VA3N70ngF5kXVd7MyIe+gggoe67?=
 =?iso-8859-1?Q?bWePjmsuPftX1dzfAUf5ABybygenhT7BbVF8zc1VhHRr6+297NLNHAOUGj?=
 =?iso-8859-1?Q?1o7vOsb/q5kAu75JlGkJjicu2LvoJTd7DzdojHJZyC4Hg/KuH8UYLncDj5?=
 =?iso-8859-1?Q?vo2HYhVistl+eofgwwogKirf3zLjTMNZwVbLfPYFiQWTTJnbtZ6a0SWL33?=
 =?iso-8859-1?Q?0Z7tmtwrWdwI8iURAfkBekfLg9sbstfM4pBvFfChCkLPjmUslGkPe1Anx0?=
 =?iso-8859-1?Q?EQd1otDI08uRGeL2GgXugMasS1E/FB6ehWmprSUyB/m7HaXGhWV2glOw+p?=
 =?iso-8859-1?Q?gnF+6vtJcYkn0vJRPuzVziHtTr2fLdtX0S1dooZuUSDjC6VRDK8Egz/iEH?=
 =?iso-8859-1?Q?vxLuzASjS7sddB4WrnKiexuxbUcdzuCz3qujl/mSZgHGJ5O0cgaiaT5BCE?=
 =?iso-8859-1?Q?5jaXjJvvC4WrpUewNwU/mv4u0rdM7x0DsB1RkbmD1I5nQnM2mXYCb6URbL?=
 =?iso-8859-1?Q?Ez5Bue9pwCbQ/CR+6IC2FxtDKE/UyCkPtebESmSc3SXZBVn6ZGxql5VxEt?=
 =?iso-8859-1?Q?sAZuBrgvdbC30hXjr9JihNK4jRAvam0p1f/vVif7K1we3r6LGFEEPOI/zH?=
 =?iso-8859-1?Q?NHDRdrCtKXx7DBkVGwMPB88131yJaHmeRksFwpckx59+XqQLVUyHypdhQs?=
 =?iso-8859-1?Q?irv6D5M6K8jkOeDJr1E2VHt3ejMY8oFcl9Nji+2E3IfxLdfcr8C7ermJtx?=
 =?iso-8859-1?Q?/0sVnlmMUVJxYkFR3Yk1tpvo2eL3c5/ZBjXOlLV/QipcXrfIoBPeXMOPzi?=
 =?iso-8859-1?Q?swfsbgwxPESDIZ1s2olrnQA2Fmt4DSt+O/AvIMZB8b3DIsf0qyqQfelGTO?=
 =?iso-8859-1?Q?Rs9cckpFCElTDteb5BJc3SkgjbeLROqZbOZK7iUZZ6NDvCecQPVcwm6Aa2?=
 =?iso-8859-1?Q?ArBxMuiQ6stcIy/Fi5IEkTun+/Vhcmvle/T636f0iApUBMQrWPz/7mD6NI?=
 =?iso-8859-1?Q?Ddf7yUvNP5Np8z1K6XyqV2k1jU/3jNwnGTc+Yaq+afT26BPEEKkFaWHE0H?=
 =?iso-8859-1?Q?AFLrJ+CaCR9JYkV8HGWrvGOUFc2VfwISdMsRM6kM/KZgwTjqxEyYmOtfqP?=
 =?iso-8859-1?Q?XtbIFy7MHYPXFoXYEujmFoJcqsd6xAhfRfARDY5brn45ARS/VdScv6XBak?=
 =?iso-8859-1?Q?sbLAKlEKuZjW3Wv5z6jNdNvSkoK17nFAUmJ4fDbD/L/f2BOCGWteP9x37c?=
 =?iso-8859-1?Q?2DXJodoIXXf8o3GPZoo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iEGJ9viAWaWGfH/We5l1wLDf8LX5TvPfMEbdw7XbOGp7O7gwWg3kerOSV7?=
 =?iso-8859-1?Q?a5QCWtiEDVae6SDnPdkPJRvW1s8542I/EXmMuk4UGxIB4mVOmuOUC+AmBP?=
 =?iso-8859-1?Q?dbXO1Ad+w+pD6N8ndlD8NFuxFw8khhZFry5N615kCQMbDKlRw9FXrN7Ga3?=
 =?iso-8859-1?Q?otD0DEsX5nnJvsgzo7ZPgAK4ibQBW1B33IXyXv+LFtaB3uc38U3NP7YAE1?=
 =?iso-8859-1?Q?tzTC1ddItLbToz9TWY2U15Wu87Lte1zIbzMjkdXvKHir6ukrmrDKxlwIcA?=
 =?iso-8859-1?Q?eBrjpAmcSihQCB7fKYWzNZaYAtLYW8HJ8YzFqBgOHHxN5QmfW4kRo2K1Vk?=
 =?iso-8859-1?Q?yLiZs1p4mNNSFJy69qmCYC5JOsnBjXzpI+AzXUQJ2h7W9NGCbaTEdJgvIZ?=
 =?iso-8859-1?Q?p+JbGLoc67kU4R07/ffBSTqhpiTQgF/0daYMQ0OXRRss8IMWTpBi6dYKC7?=
 =?iso-8859-1?Q?OPIaRjQA7jWir9KcpJySTlL8F5KTV63XbeOUZXVLoEiq9dXX24mur8N1Uc?=
 =?iso-8859-1?Q?1bHfvIbC+EC9GIynrTcIFYt9j2edTTZvPNZujvGys2uRcJDCRcXfSPe4x0?=
 =?iso-8859-1?Q?gc+VxIB/1N6fXl+k25luTOQMbyPk5bW4Xo2kC0YE1/4w7rESb/5cyKSPLH?=
 =?iso-8859-1?Q?OBLgbmjS3fpluRtlcM+p9khUoOzSiEvY32hF6s9GSnru5ljwuUf9SMrfo9?=
 =?iso-8859-1?Q?Kqvu395+xspFhwaX3RIPpZrXkOGL7sCz+wzOe1iSdAAHSG9F2+N2XKiK9j?=
 =?iso-8859-1?Q?gxmXjf0+UnjFiRoABoCSson871l4LbXYpooW8iM471yeWs8IRreOtvlp8g?=
 =?iso-8859-1?Q?AZkZO1+Fuz8lqbTkVcdSX/Yi91yvXZRq/SXQ3nz2vW2c3gQ/S5GXeOWSxH?=
 =?iso-8859-1?Q?LQAcPxuTHaDb295eByqAdQaHDR25nQIvSTouZjHIJW3Dlb0bt0tP4PISzT?=
 =?iso-8859-1?Q?QrmFzg9tO0hz7nN+0IacJlZLlrw8jJotzSzTGZFLOBw02dcOrSWdscm1Sa?=
 =?iso-8859-1?Q?9IqmJf2ZhVqFpWRrXQ6cNpxFMNDpE1BEoFCD0Z30Mpz/7htOQlDkonI6lr?=
 =?iso-8859-1?Q?5cBRPq3DaEJJ3fEJWf5ZLT4fQ77b5gyHqenNBJZca3wKVFMjy+my/snZK8?=
 =?iso-8859-1?Q?dAJWG5bHEzvDyVmFUehwJJvvuJ0hA5LLdj4Uj6+2WuAuvvcKTOWGJ3FXZI?=
 =?iso-8859-1?Q?8JsK5wsaaiqgYki56GHtggXNXmJntQujl+Lc7Pm/2GNWbAS2HVodJsp4Xd?=
 =?iso-8859-1?Q?BHbJlUPq+n6FsMZiOaZemWFEUVdtEDgG9BlJ0FNRf13Uu/ue/EByGEDRH9?=
 =?iso-8859-1?Q?o0onVbSQ0YEEXtQx18b1QBQdF/n3Mo3NVo/hZUK/b3LQ2ecaYxzr1sYj9B?=
 =?iso-8859-1?Q?sKnxNnBiODDIuMukk3xP1txgXxBRlHOFkYAJpMQwn7+WRStDNHpGJk9HR9?=
 =?iso-8859-1?Q?zrXgAeom+VXsbPvpl49eOOsQR8KsPeM6tLCWZd+lScZAZS8JIarH1IQ5zY?=
 =?iso-8859-1?Q?aaDNvB4A8X2CrxjWDqXMev3vX7fNN+VbdX0Nijvru4we7bgiebD3TE0in8?=
 =?iso-8859-1?Q?sNFKgEvTSOzAG+vMlBEZQvdz9bvmfd7Opo/ggP7PtHhY4F2877DGRP2Su3?=
 =?iso-8859-1?Q?og+N+SBDHv1aQBKXCnxquJkDAzWK6BGhJzHC8rIUZf8ZGu/OnrCmw2LmUI?=
 =?iso-8859-1?Q?+k2ZJ6h0uVSarSj1RDyatHOk10zg73/Kh6KZJXAYn6Hm7Z2pg4c5KeUCqQ?=
 =?iso-8859-1?Q?RcXFUVEQ4+pTWshHUTWpYmCuRWFj9g+50O/46VI244azLhRGjG0alR93gT?=
 =?iso-8859-1?Q?CF22f+T22g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc67e00d-11f2-40b9-09ff-08de63c660e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:21.2929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsG4BZFmNiLqRVsgN5jKyNFBTKQlfpRPWxZQHVUIFgzECrCXEXkItZYAffrKa934ymMH7NXE+2cU4FllzsGjVzSJ1L6u6jP3WDWa9YN8xH4=
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

Connect the AST1700 device as a child of the AST27X0 model to reflect=0A=
its role in DC-SCM 2.0 LTPI-based architectures. This patch wires=0A=
the AST1700 device into the platform without introducing functional=0A=
peripherals.=0A=
=0A=
This forms the base for LTPI expander emulation in QEMU using=0A=
AST27X0 as the host controller.=0A=
=0A=
Note: ioexp_num is set to 0 at this stage. Once all related devices=0A=
and interrupts are fully implemented, ioexp_num will be updated to=0A=
its expected value. This ensures the machine remains functional at=0A=
every commit and avoids potential compiler or build issues.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  7 +++++--=0A=
 hw/arm/aspeed_ast27x0.c     | 26 ++++++++++++++++++--------=0A=
 2 files changed, 23 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 7b08cca908..f19bab3457 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -45,6 +45,7 @@=0A=
 #include "hw/char/serial-mm.h"=0A=
 #include "hw/intc/arm_gicv3.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
+#include "hw/arm/aspeed_ast1700.h"=0A=
 =0A=
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"=0A=
 =0A=
@@ -112,10 +113,10 @@ struct AspeedSoCState {=0A=
     UnimplementedDeviceState dpmcu;=0A=
     UnimplementedDeviceState espi;=0A=
     UnimplementedDeviceState udc;=0A=
-    UnimplementedDeviceState ltpi;=0A=
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];=0A=
     AspeedAPB2OPBState fsi[2];=0A=
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];=0A=
+    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED_SOC "aspeed-soc"=0A=
@@ -178,6 +179,7 @@ struct AspeedSoCClass {=0A=
     int macs_num;=0A=
     int uarts_num;=0A=
     int uarts_base;=0A=
+    int ioexp_num;=0A=
     const int *irqmap;=0A=
     const hwaddr *memmap;=0A=
     uint32_t num_cpus;=0A=
@@ -190,7 +192,6 @@ enum {=0A=
     ASPEED_DEV_IOMEM,=0A=
     ASPEED_DEV_IOMEM0,=0A=
     ASPEED_DEV_IOMEM1,=0A=
-    ASPEED_DEV_LTPI,=0A=
     ASPEED_DEV_UART0,=0A=
     ASPEED_DEV_UART1,=0A=
     ASPEED_DEV_UART2,=0A=
@@ -285,6 +286,8 @@ enum {=0A=
     ASPEED_DEV_IPC1,=0A=
     ASPEED_DEV_LTPI_CTRL1,=0A=
     ASPEED_DEV_LTPI_CTRL2,=0A=
+    ASPEED_DEV_LTPI_IO0,=0A=
+    ASPEED_DEV_LTPI_IO1,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index bbcb6e0127..a05112e2b0 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -26,7 +26,6 @@=0A=
 #define AST2700_SOC_IO_SIZE          0x00FE0000=0A=
 #define AST2700_SOC_IOMEM_SIZE       0x01000000=0A=
 #define AST2700_SOC_DPMCU_SIZE       0x00040000=0A=
-#define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 =0A=
 static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,=0A=
@@ -91,7 +90,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {=0A=
     [ASPEED_DEV_LTPI_CTRL1] =3D  0x14C34000,=0A=
     [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,=0A=
     [ASPEED_DEV_WDT]       =3D  0x14C37000,=0A=
-    [ASPEED_DEV_LTPI]      =3D  0x30000000,=0A=
+    [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,=0A=
+    [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,=0A=
     [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,=0A=
     [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,=0A=
     [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,=0A=
@@ -498,10 +498,14 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                                 &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);=0A=
     }=0A=
 =0A=
+    for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
+        /* AST1700 IOEXP */=0A=
+        object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],=0A=
+                                TYPE_ASPEED_AST1700);=0A=
+    }=0A=
+=0A=
     object_initialize_child(obj, "dpmcu", &s->dpmcu,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "ltpi", &s->ltpi,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "iomem", &s->iomem,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "iomem0", &s->iomem0,=0A=
@@ -995,14 +999,19 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base=
);=0A=
     }=0A=
 =0A=
+    /* IO Expander */=0A=
+    for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,=0A=
+                        sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);=0A=
+    }=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),=0A=
                                   "aspeed.dpmcu",=0A=
                                   sc->memmap[ASPEED_DEV_DPMCU],=0A=
                                   AST2700_SOC_DPMCU_SIZE);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),=0A=
-                                  "aspeed.ltpi",=0A=
-                                  sc->memmap[ASPEED_DEV_LTPI],=0A=
-                                  AST2700_SOC_LTPI_SIZE);=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),=0A=
                                   "aspeed.io",=0A=
                                   sc->memmap[ASPEED_DEV_IOMEM],=0A=
@@ -1041,6 +1050,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, const void *data)=0A=
     sc->macs_num     =3D 3;=0A=
     sc->uarts_num    =3D 13;=0A=
     sc->num_cpus     =3D 4;=0A=
+    sc->ioexp_num    =3D 0;=0A=
     sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
     sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
-- =0A=
2.43.0=0A=

