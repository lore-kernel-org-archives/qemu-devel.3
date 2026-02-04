Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E25E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY92-0002YE-3a; Wed, 04 Feb 2026 03:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8z-0002WV-UZ; Wed, 04 Feb 2026 03:21:49 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8y-0003UH-9a; Wed, 04 Feb 2026 03:21:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3bjVvQJk3pudcBZFeG2/ofmT+cBUbGQ8lMrH5hw2Jbw+Puk5IR3UKoW9J5v+8ewDzq2pvQ5LmCxB7NJB8Kw4KmKHK0njmEo3C8P4uobNYmDw0z0xCAvnTMRshcsOkuna6k/bzkjMPF1LftCJx1ZWrbInDXkFIrdCyCiwTtGV6QCkE3Z6dcIc2U8YjL7tAs7775xJctHDcn8OBmK/eQ+NQW92znd1ptvDxN9Bg8VTl5Ju2126j6JlBjjT0URoa5Kx7djY4jhkpZ2gpq/KKo+FV5KlBlh8vPOEggDqMgdXaR8JRuxOUSyGgIGAlteJv1qaKQ1beLkz0VbwcUo3ZiQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSLJx/iWoVLuSsQtl0bdxhRh+yc2S9nVPI9yxzEbwIU=;
 b=QQ9kVSW3fa1E+rolM4jzGfxBOtXERopPz3RslKxpUU9ibDQS2weqLOzqWEwoGa3DcevDvKbai2ZKYCe81kUE4m8NVvoa4b6JuRxAxkdYxN6l4OPYZzXE8niRRlI5QZR9EDvlby+w5HJq4L2JI95E6xD2bBoTpZkzoGf9VbwHqcLJvBFn2IFrSXWtDtmQDoAFM351Ul+ejplwIolyprjbCpvjU0SqGJPDxsz9t6s4LsU2+n2Ibgt9r0IZDPJlEzioZBd4s8rk3SncDCcDGavX5WjuXilBV2GfbdMOMkm9OIc7XTKrpQpOrPrVh4RXr5+kF18nYTIIqM5fjdZgCXb/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSLJx/iWoVLuSsQtl0bdxhRh+yc2S9nVPI9yxzEbwIU=;
 b=KkxPkQfSGu/Zoua4Kfce5CgHK0SlpcxQuWToh9CWYBppfziBF9PiJhDi14ul12yKG7M9GhXE6HvEMZJ/R5KKk+Pe8YZXLzymGMXT+3ZcslDqKApNYTbvpP5CAyKqfY6t0Cg4z68tOHS/0eN/ldtbi9nthjerRhxKLfOre6ljSjWYPi5Wk7xr6MJUjn8crf1vm6Z1a0ih3tgJ0j3YNRVkgmszDCDMFLaxr7QDWEB5PQ5GGOLxeyByJrG5g3jiOigFOpu0GwHQhVlVwQf3QtMlDTqPBLyMp2Wb3z35HpYF8zOlBGt2MqNj2TMLJxpAHW+j6yrVaKOPI6EbJUT3N2WH4Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:39 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:39 +0000
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
Subject: [PATCH v7 17/22] hw/arm/aspeed: Attach SGPIOM device to AST1700 model
Thread-Topic: [PATCH v7 17/22] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Index: AQHcla9JDM+JzzBgiU6+RSOI0Eh9fA==
Date: Wed, 4 Feb 2026 08:21:39 +0000
Message-ID: <20260204082113.3955407-18-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 33bb9095-f82d-43d0-fad7-08de63c66bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F5H8fcB4HvA/W4LfmOgziKZEQRJK6tQfh5IcmIGQ1HMRtlfzGB/ZMNiHP/?=
 =?iso-8859-1?Q?esU5ND0E7HoT+ZA1USqPOKR82KPE2dgPgi6JWP5CW12CBrx7jHS9YNYsNi?=
 =?iso-8859-1?Q?F6oXua/f+Xql56oM+WF7PeLUrF+/YghY16XF003j1VIOiti4Tgo0cmKkFs?=
 =?iso-8859-1?Q?/KUc8OwxQlwebEt4AsOkrCya80egcWysXavad6D0eHVx053bB0aJOlLKDu?=
 =?iso-8859-1?Q?ZwSSeb6BiVRC/zL0oAPGZK/BdUCoy7ul4NxLjb11VEVrWj/DWPPuS4zikM?=
 =?iso-8859-1?Q?z8eGA3U2QyDV6JagXq9YDuaTFvuODKzo/kcOrfK3BI7BMOFTqBik2YhTry?=
 =?iso-8859-1?Q?jVd7ujNVrmxvciJFSEKY+UH3Z1S7TvxEH/JEbb1jH7Pzoeql8KhqRDiMrx?=
 =?iso-8859-1?Q?jLe0aWdRKTeq73Q9Ydt1kizwPfwE2ptrnN56W4pHcYrhnWGy/+2QYUfXiK?=
 =?iso-8859-1?Q?LUUpMaBKprzW+9G/uUGwab4XshipoKD3lKiI6OSq+Jj/ZuGgLzV36NtBT6?=
 =?iso-8859-1?Q?CgGqgXHZEs7/ylxAy5bHTZZ5bWfufOR0onG0fkfMLaNW8UqcCDDy9L3oay?=
 =?iso-8859-1?Q?dpAczf3FMVQKEJlvzu1O9WRDLyeRKdhpw1vv6cEUI6cD1bnHzb3QpYFlz2?=
 =?iso-8859-1?Q?r3DUfLnk8CmRyakKKxo6MBof6jaaT2PNKJYSLJvUbIqep77iywd8jivBIS?=
 =?iso-8859-1?Q?QBY4DQRA8hVc1FeIg5Ys8J7SqUQiZlUFXDJU49aBT+NKTzWqbKBctL358o?=
 =?iso-8859-1?Q?DlQe3GmmYQCTL/ixzv40iy4p2VhvoGvvFgQioGB4QJ+K5+Z29vwc1extX9?=
 =?iso-8859-1?Q?fDmZnZhwWBHytLGnaehBxiuBIQSNs7ITh05njLKlLfAE8b1MbpUWSUhGS5?=
 =?iso-8859-1?Q?nqeIhSxO5RFvYrH9Vh4VPfdMWo2Ywm9DooJL7wA4qvFZayUz4i/szpBUOS?=
 =?iso-8859-1?Q?8JP5I/MYt5tPm8E/5IWb9GhcVV7xZPE4HXYlYj7M7Ermis30eFzZYk5M9b?=
 =?iso-8859-1?Q?88TrHXoZIulEYnJW7YpU3QTqlv5GBsrXQ/0SWi2DiRTcJ0rtYiGOVotlPh?=
 =?iso-8859-1?Q?4yZblJueo8Lvf2Z6OxQVptwnJPyv1R4U1MIiiLDMbe71aOYmjQRltCvX0B?=
 =?iso-8859-1?Q?JWw8XQ2i/1VkRLUeXVxgwKzfD/gG3DxsHgSCqGLpu+mhS5VrtTgP4yIQ14?=
 =?iso-8859-1?Q?2KRH+1EOdNmsekM0EMkdxrRwlnJFX3OehW8C01eX89lNhwhkWkVD9nyfkH?=
 =?iso-8859-1?Q?Ek6dkECfWczpopu7ByeOE5Y3Uux7UquMotimxfmN2+hGGC7mE56NLlbb2g?=
 =?iso-8859-1?Q?GdOxN5MCRn3mTL2YMerOyyZB7MZDB0PNbEucJr4N50OOqxlRG0Op1vn6iQ?=
 =?iso-8859-1?Q?3oShawQS4/3Id5CmbztXxu/6+jG+RW4lIPl0PpgmOcqg7dreloZD5e6Ukg?=
 =?iso-8859-1?Q?JN0xEtFTuY6dx/JYOFpKrkGMhabnmm4qPeRKXz2tje/nnwfWHJ53596HHM?=
 =?iso-8859-1?Q?vPjNnvdaIiyAedu3CzUXVp/uY2ZqenlyYKr7ZABpfO559E2SdtPQxp5yUA?=
 =?iso-8859-1?Q?6DQAuoSL7dlCxrw4VkOzzTYCsNpb3RUWpcFO2b34LqlVDQ8Hr7sdgoHOVO?=
 =?iso-8859-1?Q?jjf8djuV1OEAv23rHYQA845dU2y97A3YM9UjcJHbmQ92512hm9u9UyKXuA?=
 =?iso-8859-1?Q?8PgThW9xU4SHg++tJyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EOaHci3asXJR/Fm3cjSlLKWII6lTmUyFfVbBe5+nLXGT1Id6gXVub+cpdD?=
 =?iso-8859-1?Q?VYTelOn4ha7d16aybnwChDkTQ/Mi34vQTLgClPqwXa5Ls805+1qMfssw3P?=
 =?iso-8859-1?Q?P06pAHAFqV+prpmjs2OHm3LoRYO42pLOn1wy8ixIglICX81Ecck/GkNuO/?=
 =?iso-8859-1?Q?oVI75wMHaYKrDeUYmpdqCVzZ4V4Lir7bbN3S4ldocjnOG0hrQoWjgK5xpg?=
 =?iso-8859-1?Q?B88bit+TfVkGSaGoC6F3FlqhwkAQJLJfMWGPtAC4Djv72n/l9ReOJEWdGS?=
 =?iso-8859-1?Q?iYn6UPDnxailR50Sa3WU61gCtQ9ClE8s8ieHgHhVOt84dFY+OCLvHOOe/M?=
 =?iso-8859-1?Q?xeZ+MQbbCH0gtzZFO82L+irs84AgmpYXJSxT7Hh5/O6VfNg1EY/q7CAmf+?=
 =?iso-8859-1?Q?n4iMoM3Cg3Vhh2Q2vFbqndXAqxeE2vcFEkthn8gTC5zpWHb8YFpW9iIIGc?=
 =?iso-8859-1?Q?0iIa7dg/DChWUveSBrIluCcDNk4qJ86Z807+y3W1DfkqvIa9pvLxLBkjfK?=
 =?iso-8859-1?Q?3jtgEETnyrlwUCBMjyQeFIcBe4xz5So4mwg+H00+RQqlGWI6LaEjbau6L9?=
 =?iso-8859-1?Q?Wl8AjHPU0rVJzHbwPpgncNEN7qpDjyuCopGLU3ErH/T/oAsHcSyA40WHae?=
 =?iso-8859-1?Q?j9NlVgKeUrFP1e4FCTUPc396B35zFw9WtGI0Ou3/CZchfbVHZkYM5iq+d6?=
 =?iso-8859-1?Q?YfT45yaYs0IpyzGqeR4SfCj5OPMLYHY2RC+9tq+JF6bShnbHo9hW18WNHD?=
 =?iso-8859-1?Q?mEZriJU6/FePtMBmSzBDkNFawW8LVkwCPScRBl2A8pyWK9jor7q1qKK5yZ?=
 =?iso-8859-1?Q?GZ+3FQ5RplQXXlpqiOwdndp/4QZsPnN6NPnx5NMq1st+5mZP7irFKKjsRh?=
 =?iso-8859-1?Q?LvGLz0SClKNXQs7RRWqDDE1v7bUw8XWD8UKefTuepRcshwvTF4NF6WpESD?=
 =?iso-8859-1?Q?b++Fot+OYely8eKnpL4uc3U6ga9PnqWiAZ5sfarGdH2gS+FHeh67r/oH4U?=
 =?iso-8859-1?Q?1yUgWSsHUowgj6fp5KoqyNa+13gBe/iRNM/rR151RWeknJqwI763TmX316?=
 =?iso-8859-1?Q?Y4/15xQ8VDka68GEzDW/kvzh4w3BxNkYZEgNKSAYqdPLknYfzIDzKM8i10?=
 =?iso-8859-1?Q?B2gXmCTL9bw+nVY37jxEIRSjCEZD+gCjfUA3DLmiAEYfZLQllMnRaxLuUL?=
 =?iso-8859-1?Q?penuVl4ny3MXCmV6zgWilO22kYp3hmVBENldcoQwBiK+H0ywdXbtvvEbTb?=
 =?iso-8859-1?Q?OGZz4rAsJcu6jHncGsbsgxikYeO4B8A2u+ezrMcD27rA6r/f7OnEQBC5Al?=
 =?iso-8859-1?Q?XDR35fy+k0ldClHA/STErqsJqjniyyOl8C0YXv4vhH6UlevV5geJ0pMMoz?=
 =?iso-8859-1?Q?KCIcbFsaAAqF1PKi3TQSkuXAlpcXIWPmQBuLnWG8jPqciCFiur2vMTDAv7?=
 =?iso-8859-1?Q?UTExFrkO5XzYqgcx7wwtgc7geI4dgKS47Qq/TpDKFfzLLJm5JDRJkf+XAd?=
 =?iso-8859-1?Q?dNNRhlzCaHdEoBkSYqCPaHSXffnc//ckn+ht6YFZZQa5SLIFfPtBnXW13Z?=
 =?iso-8859-1?Q?drQpUIyuCGO78z3IeLVSuu5FX35FJF6WNELJi2SeDctIvC528AhaB3DSCe?=
 =?iso-8859-1?Q?C+rx1X3zo62BWi7nwtdwXG5zijKA4USMMmbk36K39U1vlbZH9RcIEPHioz?=
 =?iso-8859-1?Q?68wEWmA/zPFUXd5bZrTsvanQR5OES/6SxrQuoasYR4fsE0lL2cYa0F9prM?=
 =?iso-8859-1?Q?5KcbGwW3fBqYbwqGB26uiabPQIAPCeUUcGSYUrQDSB4rcLy2/gUdLhvjiQ?=
 =?iso-8859-1?Q?qvP/1KyBhw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bb9095-f82d-43d0-fad7-08de63c66bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:39.5757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nuje/C02Jkdhzsb3e+oBVRw7UyT3Iw0xNKxu09TpXk/kyTB0A0Nlsys+wOaMd16XPPKweMei6DNh0CtKw5dnTv+reEoqgJdtZKzhkZ2uXik=
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

Connect the SGPIOM device to AST1700 model.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 hw/arm/aspeed_ast1700.c         | 21 +++++++++++++++++++++=0A=
 2 files changed, 24 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 8db513a38c..b5cb0a9010 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -12,6 +12,7 @@=0A=
 #include "hw/misc/aspeed_scu.h"=0A=
 #include "hw/adc/aspeed_adc.h"=0A=
 #include "hw/gpio/aspeed_gpio.h"=0A=
+#include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
 #include "hw/misc/aspeed_pwm.h"=0A=
@@ -19,6 +20,7 @@=0A=
 #include "hw/watchdog/wdt_aspeed.h"=0A=
 #include "hw/char/serial-mm.h"=0A=
 =0A=
+#define AST1700_SGPIO_NUM            2=0A=
 #define AST1700_WDT_NUM              9=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
@@ -40,6 +42,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedADCState adc;=0A=
     AspeedSCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
+    AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
     AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index c0b288a0fc..174186964e 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -23,6 +23,8 @@ enum {=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
     ASPEED_AST1700_DEV_SCU,=0A=
     ASPEED_AST1700_DEV_GPIO,=0A=
+    ASPEED_AST1700_DEV_SGPIOM0,=0A=
+    ASPEED_AST1700_DEV_SGPIOM1,=0A=
     ASPEED_AST1700_DEV_I2C,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
@@ -37,6 +39,8 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
     [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
+    [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,=0A=
+    [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,=0A=
     [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
@@ -147,6 +151,17 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
     memory_region_add_subregion(&s->iomem,=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_C=
TRL],=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0=
));=0A=
+=0A=
+    /* SGPIOM */=0A=
+    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
+            return;=0A=
+        }=0A=
+        memory_region_add_subregion(&s->iomem,=0A=
+                    aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SGPIOM0 + =
i],=0A=
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom[i]), =
0));=0A=
+    }=0A=
+=0A=
     /* WDT */=0A=
     for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
@@ -200,6 +215,12 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
 =0A=
+    /* SGPIOM */=0A=
+    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
+        object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom[i],=0A=
+                                "aspeed.sgpio-ast2700");=0A=
+    }=0A=
+=0A=
     /* WDT */=0A=
     for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
         object_initialize_child(obj, "ioexp-wdt[*]",=0A=
-- =0A=
2.43.0=0A=

