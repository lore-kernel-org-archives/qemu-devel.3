Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E368EB594D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzls-0005CS-TQ; Tue, 10 Feb 2026 21:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlc-00055j-OF; Tue, 10 Feb 2026 21:15:50 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzla-0001ez-Oc; Tue, 10 Feb 2026 21:15:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmB7h4dQXqwIbnO0DCgf8mAZnT7AkQ9uUY6pz4ruE7cQALjh4IY021yjC8mYs6M/WL6KiJrxYq12+RDYGqf0hD5Yrk/L4CoPzZyeYKBNMyGY9A8U7JYAtkDhNdjM1LBQ5YXrjC18kPucIsu0jVv/4xOPFe/WPyNdS8dpame+wIRb8rXjfAeSYmiVnLbX5/rZF8QADLadBoW8yTvvtz49SZ3eOqh2ZJEsSPsrpuQMsAmGRuM4R+nsp10ZHBnWFQ6fQRQ3asWA2NRpcl4gLJO4rJZ3BvQOshs1nGe5GSidrYBS7okWiwnBj/Pw4/xro06CgPMcyFd6rAU7JZOMlpo6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17VuWqM8unFhv6c94mRXw91jF1NIpZSFBM1SQaXFvWw=;
 b=Bi+vWLuTcSEXcS1p0bLstq3NGMebgH5calEi8miUc9LS4wAiN+a+thYKex2QM4Va2yX7dEg7wDGo1CM8UDuQwNRBjNq8pZ+nGmv8kRg24Xog1+y9wSkurQmCQGRIX8PJ7ZBA+9ofrReUKKa8wf0uR1P14W05WF85ejurF+F9E+B9jvzMO5mpbaKBzSYwEzMwg56DIPhPtDfqUSI2h+iwQWif3IWif+7KKUdCNBW4ZwW3dZDtLzb5JFRhxWCPuadIAQUh4AAp4fiyaHwKw8K/1cp+Rx+3ir3hJPuJ2SWmiQViIQLnOKw58JGrszyX1ikdXKvCtGVssohZhDKaWHg9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17VuWqM8unFhv6c94mRXw91jF1NIpZSFBM1SQaXFvWw=;
 b=XTuHRa8N4/nuKH2t9ggjrhKxsTm1Uc7ivw2Vlk8pTj4O3RNK2/bFtFj3dC5+Oaw0yty78x5N2vJeY3stbAYKKgIG1ofcGAXIhwUmFvABilARNuH1awNm/l0xcGuXEpunlXXzNoSLME7vwmmI57b39H+MwBzj3+su8P+xKomK/XCyp0Rr5e1jzTAr5mrCxjxJgc5SkZSp0gpTVtijq8bUdoDCIjxJSzM8n3jZreQjFRaV1JRoWjGeiKGn96e1qY2fxZHCihseiUWzi9dGpH7qDIC6KV0gLztJpkCBkKJrMIz51CLEYbs7qMK4TUClhLFYgkMvfuVis238hxO7TJZOMA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:37 +0000
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
Subject: [PATCH v3 08/11] tests/functional/aarch64/test_aspeed_ast2700a2: Add
 AST2700 A2 EVB functional tests
Thread-Topic: [PATCH v3 08/11] tests/functional/aarch64/test_aspeed_ast2700a2:
 Add AST2700 A2 EVB functional tests
Thread-Index: AQHcmvxPLcC0tKwqb0qhX6r7cZyVbw==
Date: Wed, 11 Feb 2026 02:15:37 +0000
Message-ID: <20260211021527.119674-9-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: 14f9c42d-97ef-410b-e66c-08de6913720a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7142099003|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fTptmr4xcf5AoGthOy4/TN1zX+/5s4GbDKuhwXRL7vVmyLdx4TZyvfJ38x?=
 =?iso-8859-1?Q?bXqD2Cl8SrgVNJWeBpae2Gk9q6v9EjckHOyFSZOp2kGCN/yDOhkskrOKTv?=
 =?iso-8859-1?Q?9LPPdvpA8cpJ2WxZ5mC4/AHrpO+UuVNNp4cPbutwxOdy6uDQMwMpTyoSL/?=
 =?iso-8859-1?Q?GA8yoGP6wNdf+iUkaJcuph6oGJ19sMx/3pxTZ9gJl7ORsXtD7NPFipiP/G?=
 =?iso-8859-1?Q?fwJCdS7lVB7UFG5Pv3j7LYbn/dcwK3ZRfZ19h+ffXmARC5JE17iftTUprY?=
 =?iso-8859-1?Q?Wyc8m+JsFod3p78wFhn3DgCwyvbnmYJOokoc3p8WRGGCcW/FWSaJoUVhL0?=
 =?iso-8859-1?Q?5blKzTF/pgHaWTmP+583w0fqhgVg/TRJfGifQXCUt3qZ4aSG8ZE5PABaHA?=
 =?iso-8859-1?Q?WqvFp3/xk2t8e0qMEalaIx9HhOflL/TTxzUWSFsBBFR108a8fWW3Bm4SjL?=
 =?iso-8859-1?Q?4Xv5rNf9bSCgDPFKcyovpxgGiVZ0XVm95ucfOUpXV3qJkovlvmBUbi5j1p?=
 =?iso-8859-1?Q?KvaUvV4JY/Z2o/V90MtgGsLPkCVMyJiLbezF1+VuXC0Vc90GIAcTXPRAi6?=
 =?iso-8859-1?Q?mALDaxHf8JM+jak6sRa51XxoNrdouMqxBZnxAqGx5DSDZVwY7QBzXjmYW7?=
 =?iso-8859-1?Q?jFW3c0naMJjssOmhAT/bGqmUb7axvPdR9c1bFz1jm81YBDTWBmPiyGO82K?=
 =?iso-8859-1?Q?w4i8uX6b6xUqEewTOF20l/r1jP1IYOY3r9EzbEnAHJvk9c3h22l2I8j7Ga?=
 =?iso-8859-1?Q?nTNurY3Ngh8A/rjca9MWLWWeCM+EcUtmP7/uXBGSjMTFf8M9GOqXVQrdD1?=
 =?iso-8859-1?Q?c5kfuEnsg7l9mx+jPvG6EF/iC4ji/1sNMO0qWyL8Sa6+sCMLmkqTwqZDhr?=
 =?iso-8859-1?Q?e/vGVHoTjNW4Uzz106SwWAYlzUVJXl5WTUeSf14jAIC78868JZfRvhT5Fb?=
 =?iso-8859-1?Q?4eDPDCyA/mEuT8dDtgOGfLbM/+lG1Ng6d812c9MqFO2rp8Z1/EOZOiEHaC?=
 =?iso-8859-1?Q?qlg5NYemXJFD590fdPPkoXOsrhNr40OOBRbjrI4O0Uv6YYmA4MbaE3r+Sh?=
 =?iso-8859-1?Q?LePRA+c8K7t7VWV4fyTBnqGoQb47lifHMNRVdst39cjAdLo8LpCYvnqhDq?=
 =?iso-8859-1?Q?NyND82lEl3dS73/LFL39NklA/We5+5Tuw3ERQ3/9Klt5IJbltVYa3BUCxo?=
 =?iso-8859-1?Q?2OpnKLKvRTjqs/V+e6kK/O2SZPz6lM+K4gCEpF5CaieUddiyOKlnAGBSN6?=
 =?iso-8859-1?Q?pxDbVo8LcwZpEffyB3rtbYmEfEc3EqtVgEorS5K12GycWUdr7ymyy8yYtU?=
 =?iso-8859-1?Q?n8YoEj3TRYX3bfUPfuzQEgw/m6wv50K85hg7W1Y8glI2viLY5tzB8gR+QL?=
 =?iso-8859-1?Q?wwOZECDsohyOax1TmqJSHyTI1oc0lxp1wVdIr4ixBAdBoLmqiYgbZibwpM?=
 =?iso-8859-1?Q?okCLRgGwSmZcDePOJn7s1TZwwyr6/QBMnFa+ThSGkhWzoUZ5jjKZqsVbec?=
 =?iso-8859-1?Q?IVLpFtMXeWGJUpzt2Q2M5souZHJYi3/GstbGDrP5HeWVzqzpv27nwqWzGr?=
 =?iso-8859-1?Q?4reezBmIuvvr4BW1/6t79B/ToF4Ig0sIvdVCdwCfQDPT6is7iZWsb3/jA6?=
 =?iso-8859-1?Q?5BXfWRB1L/9p57uuv/LxhQ149qLnQ58aZokgB/JbuiKgTuqzJHfG4nCQ?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7142099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TX2s0Hi1xlVEwrXuUcV1FodkzwfwYl6OncIc/DI7MCsnZtJR2EVyvBG+4e?=
 =?iso-8859-1?Q?heQnWACCCzAvsPOi8GYYy+F3dqer4HTLe+3+db7jf6q2kGPuEHEWURfDTr?=
 =?iso-8859-1?Q?yLQNp924HnQXI0Z8G/1iibVXRRsU7tIRG5nS/V2OiOzIe4QFq0fg4xDV7r?=
 =?iso-8859-1?Q?lozVraVxoxEMgeXe8hc2EaCQeoQ1ibGfXMbduyVLbB09+sJZyvXBnzapaU?=
 =?iso-8859-1?Q?rrVDLjFTVqb20z23Ty1alag7lozoNo/rchz+Hl8P32RQi0A8plVVQfpekl?=
 =?iso-8859-1?Q?LtrjE/xiTkVolhCibH8q8CKlv/BRZ+lYd4zHtLT7aetjMwkjnGwEXxLDTd?=
 =?iso-8859-1?Q?JyYFAA+FCpifdK96XV/NvetcKWutJHEFEyv2vtlixlerjAfcphgeJ4Eq79?=
 =?iso-8859-1?Q?GLQ5pVwVG2KGvj3Nug4aCven+wHOnjlEkZagnsEVCtU+9x2rEpZrWvFOG4?=
 =?iso-8859-1?Q?wDOSN3susVDrtW0J+a9FBo9LW5TNgXTZRbFZenUGwDwCRXsVjGmILIH1AK?=
 =?iso-8859-1?Q?4mydxIEksi5G1FEowwdhhDYqb9qP3qbJFrMsTT3K60ArXlmVXYgGngyujP?=
 =?iso-8859-1?Q?K45/z+VpmVnFXkKafoHtRzDLsTSCavLBeOyYz3ND5iJ1lBdFw7YbC8aH78?=
 =?iso-8859-1?Q?QuCslPPxGhqb35YQpBd5Y4BXIrhI47Qzplcf/0TzFbHTtXWDCUEyWyJxZH?=
 =?iso-8859-1?Q?AXpbUH29vv9mT6/QhuNs4HZIPwMHYcorU6SKKgDpATeanESHpSQumM1Elp?=
 =?iso-8859-1?Q?Yo4jbj9jYgJ2A6VE3YjsmIDP5B/yJO6QXUojPbnhJ6bYzHLMke3OOtwTmA?=
 =?iso-8859-1?Q?2SlKgornpAaKI43IlJzY8eRG4n3IrNSRGpVaooxwdciPKyxRCgrTr68ySz?=
 =?iso-8859-1?Q?cPTUBYp4hO9DJZ5dPq8BoantAHZy+JK/DEB9H5uDd8mPB9z6dl5v5968wn?=
 =?iso-8859-1?Q?i1fslrl+bWnKieq8r1/uRtjGh5yvENFVud+fmpj5gwuj7nwOJ2lNuinWNq?=
 =?iso-8859-1?Q?q5nhL+eOFnc2mKR9PApRs8gihmZAwuIZalFG+tEskC/H2fIky0/0XGpMCo?=
 =?iso-8859-1?Q?BJj19wHwL9VnjDLWpvbj9mqTYt+kmw4s5draY2yXLdUSBGxGaL5/B2vcbk?=
 =?iso-8859-1?Q?pTFom+5cvzfMrBpKqXrdHh85BW1VCP1NDztsEO3/jQQ+VJ0Wkv+dTpn+5v?=
 =?iso-8859-1?Q?IDr+Tdl8qsR6QyuB/lpxozewTnFNFZlE2IUqNlWIytK33T3vkm/gyChYmj?=
 =?iso-8859-1?Q?dWVWlH+I87c1zVr0vdlZeuy4RoDrO2z8AXcapUhtXBFkxS5zxS7crchGxd?=
 =?iso-8859-1?Q?1HEvH6gvEIEnd6kSS7loLAsILGef+kLkyBlnyY/7SMzUfmUgh5+rF+xSnE?=
 =?iso-8859-1?Q?JQ+jW5mJGvSmBDk/nblsluB3o5JXtI9BdXtGgVyZqPnq4JdJSIoAo8gqDn?=
 =?iso-8859-1?Q?DMrScOuYxx1+ziZSU0RGRlyRCLWPyPbmJZA4dFviVWr4KWJZx3/RFwf1OA?=
 =?iso-8859-1?Q?xeUII0v1vF3p2h1q5zcUCCft+okLTfF9uVW5Ue9ojlHClORHLcaj3Ltzd9?=
 =?iso-8859-1?Q?m811RtVaCcsGuu3xy0GiMCRPU903XfPYGF3ApRtbQy+zZdibdTXaQnOzDl?=
 =?iso-8859-1?Q?It748lzgDAJ/Mi5Q7vKpKdAZFEOxyRe263R20yGTa9/nXtlpoS9ugO9JWE?=
 =?iso-8859-1?Q?Oh+zmS0cuhvF461yMo6ktLDuKw2jEQO8rmt79i7swDd36muPl+Q9WDYL2v?=
 =?iso-8859-1?Q?dsL5r0+IILPgRRsTapZ4yhaVgEUyKZm2IdfDYlxyHzBnU9g/RznDTr7ytb?=
 =?iso-8859-1?Q?QeI1rxaCtA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f9c42d-97ef-410b-e66c-08de6913720a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:37.1770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwbfoyQM7oPsIi7+YyYOBvu2CTDX2R1oQ0HBBG0Y6pcPyWQfR7LQQ+AH4Uw4vZB3PJtrZJJJdCsTAlLI98Feki2x03qNAzTD7SCZ2euB4Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

Add functional coverage for the AST2700 A2 EVB machine by introducing=0A=
test cases that boot and validate an OpenBMC SDK v11.00 image on=0A=
"ast2700a2-evb".=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/meson.build          |   2 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          | 190 ++++++++++++++++++=0A=
 2 files changed, 192 insertions(+)=0A=
 create mode 100644 tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
=0A=
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch6=
4/meson.build=0A=
index b5dd674bac..49eca12058 100644=0A=
--- a/tests/functional/aarch64/meson.build=0A=
+++ b/tests/functional/aarch64/meson.build=0A=
@@ -2,6 +2,7 @@=0A=
 =0A=
 test_aarch64_timeouts =3D {=0A=
   'aspeed_ast2700a1' : 600,=0A=
+  'aspeed_ast2700a2' : 600,=0A=
   'aspeed_ast2700fc' : 600,=0A=
   'device_passthrough' : 720,=0A=
   'imx8mp_evk' : 240,=0A=
@@ -24,6 +25,7 @@ tests_aarch64_system_quick =3D [=0A=
 =0A=
 tests_aarch64_system_thorough =3D [=0A=
   'aspeed_ast2700a1',=0A=
+  'aspeed_ast2700a2',=0A=
   'aspeed_ast2700fc',=0A=
   'device_passthrough',=0A=
   'hotplug_pci',=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
new file mode 100644=0A=
index 0000000000..e527518a55=0A=
--- /dev/null=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -0,0 +1,190 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test that boots the ASPEED SoCs with firmware=0A=
+#=0A=
+# Copyright (C) 2022 ASPEED Technology Inc=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+import os=0A=
+=0A=
+from qemu_test import QemuSystemTest, Asset=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
+from qemu_test import exec_command_and_wait_for_pattern=0A=
+=0A=
+=0A=
+class AST2x00MachineSDK(QemuSystemTest):=0A=
+=0A=
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
+        self.require_netdev('user')=0A=
+        self.vm.set_console()=0A=
+        self.vm.add_args(=0A=
+            '-device',=0A=
+            f'tmp105,'=0A=
+            f'bus=3Daspeed.i2c.bus.{bus_str},'=0A=
+            f'address=3D0x4d,'=0A=
+            f'id=3Dtmp-test-{bus_str}'=0A=
+        )=0A=
+        self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
+                         '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+=0A=
+        self.vm.launch()=0A=
+=0A=
+    def verify_vbootrom_firmware_flow(self):=0A=
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')=
=0A=
+        wait_for_console_pattern(self, 'Check flash image checksum')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read abb header')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read soc manifest')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load atf image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load optee image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load uboot image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load ssp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load tsp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
+=0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
+    def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
+        wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        if enable_pcie:=0A=
+            self.enable_ast2700_pcie2()=0A=
+        wait_for_console_pattern(self, 'Linux version ')=0A=
+=0A=
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
+        self.verify_openbmc_boot_start(enable_pcie)=0A=
+=0A=
+        wait_for_console_pattern(self, f'{name} login:')=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
+=0A=
+    ASSET_SDK_V1100_AST2700A2 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
+=0A=
+    ASSET_SDK_V1100_AST2700A2_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-dcscm-obmc.tar.gz',=0A=
+            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb0=
2d0')=0A=
+=0A=
+    def do_ast2700_i2c_test(self, bus_id):=0A=
+        bus_str =3D str(bus_id)=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'echo lm75 0x4d > '=0A=
+            f'/sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',=0A=
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0=
x4d')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput',=0A=
+            '0')=0A=
+        self.vm.cmd('qom-set', path=3Df'/machine/peripheral/tmp-test-{bus_=
str}',=0A=
+                    property=3D'temperature', value=3D18000)=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_i=
nput',=0A=
+            '18000')=0A=
+=0A=
+    def do_ast2700_pcie_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lspci -s 0002:00:00.0',=0A=
+            '0002:00:00.0 PCI bridge: '=0A=
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lspci -s 0002:01:00.0',=0A=
+            '0002:01:00.0 Ethernet controller: '=0A=
+            'Intel Corporation 82574L Gigabit Network Connection')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'ip addr show dev eth2',=0A=
+            'inet 10.0.2.15/24')=0A=
+=0A=
+    def start_ast2700_test(self, name, bus_id):=0A=
+        num_cpu =3D 4=0A=
+        load_images_list =3D [=0A=
+            {=0A=
+                'addr': '0x400000000',=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x430000000',=0A=
+                'file': self.scratch_file(name, 'bl31.bin')=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x430080000',=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
+            }=0A=
+        ]=0A=
+=0A=
+        for load_image in load_images_list:=0A=
+            addr =3D load_image['addr']=0A=
+            file =3D load_image['file']=0A=
+            self.vm.add_args('-device',=0A=
+                             f'loader,force-raw=3Don,addr=3D{addr},file=3D=
{file}')=0A=
+=0A=
+        for i in range(num_cpu):=0A=
+            self.vm.add_args('-device',=0A=
+                             f'loader,addr=3D0x430000000,cpu-num=3D{i}')=
=0A=
+=0A=
+        self.vm.add_args('-smp', str(num_cpu))=0A=
+        self.do_test_aarch64_aspeed_sdk_start(=0A=
+            self.scratch_file(name, 'image-bmc'), bus_id)=0A=
+=0A=
+    def start_ast2700_test_vbootrom(self, name, bus_id):=0A=
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
+        self.do_test_aarch64_aspeed_sdk_start(=0A=
+                self.scratch_file(name, 'image-bmc'), bus_id)=0A=
+=0A=
+    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test('ast2700-default', 1)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.do_ast2700_i2c_test(1)=0A=
+        self.do_ast2700_pcie_test()=0A=
+=0A=
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)=0A=
+        self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
+        self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-default', 1)=0A=
+        self.verify_vbootrom_firmware_flow()=0A=
+        self.verify_openbmc_boot_start()=0A=
+=0A=
+    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):=0A=
+        self.set_machine('ast2700a2-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)=0A=
+        self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.start_ast2700_test('ast2700-dcscm', 8)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-dcscm', False)=0A=
+        self.do_ast2700_i2c_test(8)=0A=
+        self.do_ast2700_i2c_test(16)=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=

