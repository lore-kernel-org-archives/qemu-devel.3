Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7CCE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8m-0002OQ-Ec; Wed, 04 Feb 2026 03:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8l-0002Nm-3V; Wed, 04 Feb 2026 03:21:35 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8j-0003VZ-Kz; Wed, 04 Feb 2026 03:21:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bujGd7hPQ0gYNUIp0Pq44tXNbt1P/8KFB//4k63k6vXHv1BXZt/lKmjb+JuMDexlQtuuT9/Jv5afC4w8OOvJ8mwSPrXEDkhg57dzQq+zLSRXcogXPTBzxNZqd7iicKBSVHQjnmzO/Hy7B9093iB7yy4Qcpo4jBu8aMFewLHD5ZH+clLXI3T3LpDR8sp3uJRUT5WEVnMCyivFzw+kxGUbhC2cbNc2BJtIaYpiQBe455fFKT3NRzLVMVoz/1q0+4OeEtUzhPI0fIhnlLkSfmZynCQyarTh3BvW+Skb+TjqfaxKzUJBLde2X92p80+lwCE46Vg9HdKWeY6WAFSPRGXKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/MCjKq2WfUFhkLNlluC4LeTUxt227UqkGo1OYBeyJE=;
 b=gkS90L2HLFmln11W46gNWGzzs/pmw9TSaof+NVx1D7QsiefR4zdUy+44SeHw2fDvFI6gl0EOBI8HNHP0tdKD6JBY28x4rhqEvgkSkwf1Mro1p+tkZGJZEYaXQ/ZTh89b4TK/BhtJP6TBvUO0S3Z6Cm6uy1MTfRIucp+Vs/neE7ZEPLS59JFwVGByKHMZggW6Rek/RE1uwFXxgtEoj4Gs2VHXxVsMX9jtSXnJuk/qeci//AC6mJWsHczMBbsWCOlIhd+GqP12nASLDh7gOH2b6Usp5d4O9e/ydO4WJwzajSum92rorTVUDLoYoJgaMXGoKx1wzy6Itwl0mtY+6mOiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/MCjKq2WfUFhkLNlluC4LeTUxt227UqkGo1OYBeyJE=;
 b=qbUj95pqM733aCvGegie5zH0D/Lvxo97J/kh3Mpi3D0i//mPUKcS/l9eX2HTv38agiJDV800xFCHKtwQlBZHTsh+smMJK3FuM/jq2efGyLUshgkbIqWntqndVxOZiavRCAfNUk2r+LWI4/cV7p2w4SbJboOunIKIQ6TuxotEm/3XH0y/HSwKUysj+ElVZw644kr0z0LZW/Fh8OiQ2SxvsJWbPA/ILusB/ZxcXglvimBON1Flo78B1M7h/ti7m75ST3ZhBr14ZbOLqpr9kyj1PDDhdQQkCi89RKaOw8gugEs6ZxPDQ5qCXb0nZvGV0XGZEYYtVrmDDm0NONTayngGmg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:24 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:24 +0000
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
Subject: [PATCH v7 07/22] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
Thread-Topic: [PATCH v7 07/22] hw/arm/aspeed: Attach LTPI controller to
 AST1700 model
Thread-Index: AQHcla9ARhJ97lSoxEuMsOC4NjNZxg==
Date: Wed, 4 Feb 2026 08:21:24 +0000
Message-ID: <20260204082113.3955407-8-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e9c49d0c-c9c7-4f35-b39d-08de63c6628f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xr6J5hghMbEN29RH3bfG1/k0NpQGz7VKm5ApkzqbxQDVSRII4R3ceiXR3b?=
 =?iso-8859-1?Q?r/f143Umi+BftTuWKb45rMF1wm7iR+BkCFjU2xXGqn0yxjiU9pq7JbJ/57?=
 =?iso-8859-1?Q?BtGgw8GfftXZX4OWXBMc/PPSo3DFYqz6mRv5oJs3rf5hRuTuXZV9289P1y?=
 =?iso-8859-1?Q?oARlmzk3Ju1MtUc1j1tZg5G6wrgBk57oLlZ/wQJ3uN+rd6D/KRjJJXj23m?=
 =?iso-8859-1?Q?McloWeHltOJZPiB/7QTObKMLtezvJK2zPyFW9pqFhpfRGjlmwYaL34znsx?=
 =?iso-8859-1?Q?pHkHjrHl4W0YRyPfPMdt/eDPYzqJX2f8cDX2Pp9WavKc7k1TlS0IwmrkwL?=
 =?iso-8859-1?Q?jsi0kkLlFYVQpZo8cBdxSuvlYPzGOtAmtnCwa1CNTRBIbQMm/DlapfXaYG?=
 =?iso-8859-1?Q?PNTeANNab0Qv9copCVXGSO/MhoYuIxKi3LExsI1PWWNtdsAsnkoROBQdl6?=
 =?iso-8859-1?Q?xzJMevef/ueXjlthVhS0WjrClX6lYSZKvGrH73zc4VqkgShBVZLcWBa6ID?=
 =?iso-8859-1?Q?BkowtyfMtU2qSnCvHhejfQSJSyWesUY/FFu4aUFNa2zN9mlDWDm5E4kKnG?=
 =?iso-8859-1?Q?bGcrnR8hKJTz+GxOWAby70mzFIt7DXp2IUC3QHwykHdJw8VvzsvWhYXLwi?=
 =?iso-8859-1?Q?/5j8nLhaAUS39hiozErdHVA/ZP89L9Nb+GZCnyt8uuT44m5k6r+y3GohS3?=
 =?iso-8859-1?Q?3bHu2Zz+Z3zQ+6P/+/8oHdeV3e++k7AiESgpvt8jEi4TKkXgd5olV4tOjI?=
 =?iso-8859-1?Q?LJkj0Qn8KZb1qhZlTiziCf9fse1wsirUhAEem1UGLVOf7MyMLK7pFS0IXM?=
 =?iso-8859-1?Q?t8jL1O/bH7q0p+Qg9Mg3PJtViLLAMQtFY/MimZvlbgIbbCPYG69F2VQMpr?=
 =?iso-8859-1?Q?CQ8DFsp/kkCJmKJ1vJitPmDUlkaGUphLIhBjSeRJgx8HB4cYBtncjTPale?=
 =?iso-8859-1?Q?cIir9B8CKNo1h2xWJWWH41Cv3AHys3XLaUp2P8k3/rWU4JULqdDJi5gLSw?=
 =?iso-8859-1?Q?wBVpFGEDlVyxNJJzy4YiB8g/WXHoV0Ct9aZIJdeMXmcjJIAyggWk41CoS9?=
 =?iso-8859-1?Q?tG+RcBlfR0L86Cbz5c8yl4ubN/5EiBf+MtF28P3D5nxGeUErS6cgn15FWK?=
 =?iso-8859-1?Q?fQXxtMLZAUH8Su5NWvPKmdW9gjVkrJPeU3tVrdBDf3M657Ycz/4H2kqg8Q?=
 =?iso-8859-1?Q?6F6rIA8MlDqwL6SluZ1f8XZqfafUdH9w7PjpWBkQs8ndhszdFCF0XM7FbH?=
 =?iso-8859-1?Q?JaB6eyOgZEhDgd02Am3G0ikllsGtfMzR+iCYf0ems96PcMYWVdAse8PQFF?=
 =?iso-8859-1?Q?FkrG0Fstr3k8zhBnUVi341SMpoTrfRwoxdjlzVwgMJEoK0Yqsem3LSGYyJ?=
 =?iso-8859-1?Q?le0ZJ5NW4sb+FYmhm1M6vbxz91+zLiPlqgXkdLYsYaX9nBLRsVWAumSCm5?=
 =?iso-8859-1?Q?zZJ70s037Zm+7ggQvAC+1FXAlq6hYovkEp/AE6c1tPR9c0xaT7IUc6DTgZ?=
 =?iso-8859-1?Q?tuHREPnD+eVxVB4EMLJW9h+aD8nXziIhmO2GjnlqC+r7sVzCtJs1wInaGj?=
 =?iso-8859-1?Q?cv39dtIcnb+f6rpMFhcdRRVQCVWdV2KskmapO+sI4F7KRzLVYZDIAcS7yv?=
 =?iso-8859-1?Q?+cPzeYoNGDnJPQ4yPqFZMiOWc5n5BytuOsmGyLW5wUMXqxEQRUdeaNfy8B?=
 =?iso-8859-1?Q?Jc8N59i3ysoY8/nVB+s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DhEeSvL37N/ASi2kM/PYzdazP4fSOSCK3TNNdKeevSQe2QMVMPOtpylNKK?=
 =?iso-8859-1?Q?XTrAohKQhyXqGLnLvBOMYWBJdOhPaatVnBtSlOCnR6ocrcwi0IskpTIcrd?=
 =?iso-8859-1?Q?Ie+3ChDb/wJr0t+5S2q9q3KTdyGfwlMp4j9Jj+FDhUc7ZTy6TBdhlzqoSO?=
 =?iso-8859-1?Q?dB4obocxz8YTkS8I18ynXT1erJvCa36p6jCEwjKOcE2cWs0gSyYun1On3L?=
 =?iso-8859-1?Q?wjWRYaxqq88GXvn7UCcessTZEHY3ikI95MmOwZEkfuU5jL33vOPoQjJl9k?=
 =?iso-8859-1?Q?W0WM0OuwHflF0n6VlFJpqXkVZ6VZWx9i6dET9LHv1d+GwSkFTNEIZM1PAs?=
 =?iso-8859-1?Q?1uHTIfgdaFqeieLazDViXJnBOckWBQJe8dKjOpvXbUgoJXT+R0uYDO9ftd?=
 =?iso-8859-1?Q?3a1cD9x6nm3CRO/ZRX+6Y3UZbsvZONDtIlk4oqAeUnmk1wT0JGL80FbAj+?=
 =?iso-8859-1?Q?Mua5eh1nR66fMy/0ogkzsAcUMEtR/wl8bodQvV0b5nfYXI6AlMQKm8zcQ2?=
 =?iso-8859-1?Q?cVNzfrtQdJEx0hNGuI38VedqGl4FoEtuJyOL7LDHVO0A96UoIA9L+w4BD+?=
 =?iso-8859-1?Q?4pLq9nlRl3+u6nxNUClF2t3AGQ2UqI8mceNh2pC5k9uFSKnB/2HHiQ+md7?=
 =?iso-8859-1?Q?DYy6FewutF9MP4JlGRbGIGagL0jKOEXh7BCGcCnoLuToP2Ck6Vz+E7frV1?=
 =?iso-8859-1?Q?ZY+QQerK3H+tb7CHe5OY+sJ9Vr6mJAX9QGk23wLaQyc3Ed5ZMrOwEI7Cy8?=
 =?iso-8859-1?Q?EVSM5t9/BwJVXF8z8Pr1lN8jk50sRy9pZsbbj9oJfWoX/BIAH+XEjpNqgi?=
 =?iso-8859-1?Q?kFxOqLbNLTp6TCg1iOtQeG4FPuRhBg8wLkJ+y6BLooNl98vfPATPNABA4F?=
 =?iso-8859-1?Q?e2OdeJI1eQiOaEae1wY9kjJ8/dHhBXd2/pRIfbp5Z8N9IT5ACkCQyZOkC1?=
 =?iso-8859-1?Q?Nz0IbM/w4DplDwjntj/nFYd7u1FsVohZ9B/CCgJ3g4r0b6kQ3bvD2gS0gd?=
 =?iso-8859-1?Q?At8tBPVrCJiWOxIbQPm80ozy0VrU/PE0xGaG0RXUyvxGfz42o0CcIBAWI7?=
 =?iso-8859-1?Q?FSHPYRMeZzie/nXR70XOKJ6D8cXhfzFjdhix9CwAfnrWLKE++ZWTxaCKsp?=
 =?iso-8859-1?Q?Pp4YuD1ZLWmfXwOw8kYhl83ta4sj0A/S3FtbxTqZ9TWK7/MzYOyxoyktu4?=
 =?iso-8859-1?Q?rsjtLxblehRn1YiPk6AiLpgG9KyIiGxCRZPDS9bJTfZALPlAE9F6gIFwq9?=
 =?iso-8859-1?Q?tHrkPY030aE3sxiSRFwRMUtzSt+s4zSg6W8CSyvSNAmQ7gti1l9+ihO9XQ?=
 =?iso-8859-1?Q?PPMkZKSCJG95XFQ8gpPaBNXUBKtUsdET8sDkYQGta0yKQBH82ntJu497Pe?=
 =?iso-8859-1?Q?mJUpxu3QHN6mxJ7uzxNdUksY/WyK1GeHv/O8XsB5Tq49jgim5AZS5QZiRM?=
 =?iso-8859-1?Q?oLz4DA5ehoLntqjiS1jg/LYdB+99wfkvyP1zaFMuHfs4UICHpQ78P2WGUM?=
 =?iso-8859-1?Q?figjqz90nS0GwlKXoEl6p/dAlx/zH4qsAwHWhKdXZ1+gBusYjSPDxjYdyP?=
 =?iso-8859-1?Q?WSfIdKcrnNNogqg4i8xtvHXPlhZnPjawXBGitWRiQIvWxXltjdwuC3BJhU?=
 =?iso-8859-1?Q?PE6Y8X3KtJ4gL8bF3bYN6lBTUBaN6X2RLQc6MYW8if9KNxSWXhxex+o9lX?=
 =?iso-8859-1?Q?9IA2nedIQwqcMdH34ndX/Cl08ITT4iSk8xfMLNk3/o4ZtVhdw7zElMy/6z?=
 =?iso-8859-1?Q?VxnQYGhXnhjCR+3ECcaaE+qBGms2QWkkJmh3OlZt/oAsPLyICFCuiidYn1?=
 =?iso-8859-1?Q?4cmXdpXPJQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c49d0c-c9c7-4f35-b39d-08de63c6628f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:24.1095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAFUWgnDCDU3J0LulAcdOy3K9XEKlZXK1So33bzZzmhAFxHkgvRsNT099goYECxvlz8L/aiBB47L2VOHCyMqFTTfCIu9MXGNS2ubeJwhDLk=
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

Connect the LTPI controller to the AST1700 model by mapping its MMIO=0A=
region.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  3 +++=0A=
 hw/arm/aspeed_ast1700.c         | 28 ++++++++++++++++++++++++++++=0A=
 2 files changed, 31 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 378dcb437a..addea3ab1f 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -9,6 +9,7 @@=0A=
 #define ASPEED_AST1700_H=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
+#include "hw/misc/aspeed_ltpi.h"=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
 =0A=
@@ -18,6 +19,8 @@ struct AspeedAST1700SoCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion iomem;=0A=
+=0A=
+    AspeedLTPIState ltpi;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index dd38b819b8..e4c8565d3f 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -13,6 +13,14 @@=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 =0A=
+enum {=0A=
+    ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
+};=0A=
+=0A=
+static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
+    [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
+};=0A=
+=0A=
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);=0A=
@@ -22,6 +30,25 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,=0A=
                        AST2700_SOC_LTPI_SIZE);=0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
+=0A=
+    /* LTPI controller */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_C=
TRL],=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0=
));=0A=
+}=0A=
+=0A=
+static void aspeed_ast1700_instance_init(Object *obj)=0A=
+{=0A=
+    AspeedAST1700SoCState *s =3D ASPEED_AST1700(obj);=0A=
+=0A=
+    /* LTPI controller */=0A=
+    object_initialize_child(obj, "ltpi-ctrl",=0A=
+                            &s->ltpi, TYPE_ASPEED_LTPI);=0A=
+=0A=
+    return;=0A=
 }=0A=
 =0A=
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data=
)=0A=
@@ -36,6 +63,7 @@ static const TypeInfo aspeed_ast1700_info =3D {=0A=
     .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
     .instance_size =3D sizeof(AspeedAST1700SoCState),=0A=
     .class_init    =3D aspeed_ast1700_class_init,=0A=
+    .instance_init =3D aspeed_ast1700_instance_init,=0A=
 };=0A=
 =0A=
 static void aspeed_ast1700_register_types(void)=0A=
-- =0A=
2.43.0=0A=

