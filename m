Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B41EF55434
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OK-0003Xd-A1; Tue, 24 Feb 2026 21:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OI-0003WX-Oi; Tue, 24 Feb 2026 21:12:42 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OH-0000HF-Cw; Tue, 24 Feb 2026 21:12:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsCryF1w+4YSbXdKAP9x++qDt+5QMx+H8OmwqB/YxeHTACFZ0bjNREKhQmwoxOUbvCJ6W0KdHyeqMdl1iznQ4B8WWLAlBPhJ1rUd66k5i0Qf+cGD+QJ6cqgslkvUznqhJu0q69dJmyk+uUKk5TD8LbFhcoLRiQYiPZmJxWfa+soyyoPhwX73EVEjkiHH756CvBPvx0PfFIgk4QjugKk7T+IZBwg+EjpYAJ5BHffkU6g+6KUhIZ21//b4bc9hGPJMfDgW6OQ6LMBucY0H49x6cR1UVqTcX7dKPGNwfqVYGnm+2OGuCeO9p5yZqjjxh7RxCp6Wu4niTc0qsuipH4YuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=TU/Qg/OOQ7a922rMdFGC1AzLBZGBuW4I/+d2aJt5PhWPCAckXTyoqu0Of+4IhjYUMlECVSX7INcCrwTMnvA9HByQJ3gNBtUKUDNvq4cq2BuTYefkVDReJnEFnxTe5NTx57PRLWpjG8S/tdYUHa56myTnRjbXNacncvSqHCixtHrN8+oLs81LNm1iVt8yUqOmMf44eTkCnvICbnZupOtTHiOCm/kdbVIQT1v2EINXCLgK9sLxuMkuHNRF+NJmFFwPHhLrPYDJXBZknZU5It0CMPuZDvHKoGWachVhZf1Pn05KvFlykkuVmn1WChzcg1Gvm3GIgivlH0CtmLU7HxVujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=ewFEXJjYXKs2ZWsJBup0CXmm/G5bgQYtIdZJ1FL18Jz9ENxBXUkYWcQt9jQPUtdyybt3nTxSfeX/lRH1qHOmFy9YRevzJbppobn4IroRoPd+rTMaGe0JDtKkhTaVRVdGsF2N9oXxpXGlgWLSpUDzU6F55F7S4ASMmnJGxYKiAGr5pDCRmjBWx2on0cZmY7k88+kdA7D4LVoIwGax0Ql7A0gHk7mcP/DenALuNhBjYPVK3t2M11TzqyC94QAFVwXhEfx6+p9djIWA5gDu3lpPj9tC0D68TOKaAadD65BdM2gT9VW5hql0EyDDoQm8afWSS2D1rEgviIr2GNBb0gsoqg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 17/22] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH v7 17/22] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHcpfwyzbkrF692YU+kiupVN+CsMA==
Date: Wed, 25 Feb 2026 02:12:31 +0000
Message-ID: <20260225021158.1586584-18-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: 48b6d5b0-f07c-477c-20bd-08de7413550f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2bFC7H1SPlv+UDh+w/DMRoryZJ3AbtoxYCrbAN0IVGZip4DfGUl/154Lcp?=
 =?iso-8859-1?Q?eq84Ydykfm1gWD9tD0IygVNHrp1O+35lTqywJcR7C3IEV6WG5496PkET2U?=
 =?iso-8859-1?Q?obzt5hTxDcP9azWjnod1VkZYet8y+kaEGfA/Cz58aDd+mdInc+DJNmJztW?=
 =?iso-8859-1?Q?WUP2jirJTcHUZx5lvtHJFeHfxZ5iXuLrfXOAeNlnz5/JfD4bYOL8CPGmJD?=
 =?iso-8859-1?Q?CJIpCuob4oBtjlrfrcTt73XpWuMOzAaWKR+/BRxZxdP0QILuXlfupfsKTy?=
 =?iso-8859-1?Q?UFv4fs/JQDfXZmKQuYJItIVIy8Zl9Qva1vSgTmb1Iu1dMN6j2YB6K1DjkG?=
 =?iso-8859-1?Q?TWkerH5zNhjMAFttzSki73N7ZDHV0Lfqw44CSXC3sUjrKcqnjIBRC1D5dD?=
 =?iso-8859-1?Q?1XvN2zyGMnENot2ejWVisMS8V5qjMV6NjtzfsThRv6oed9ick/6TNcbv68?=
 =?iso-8859-1?Q?qL5isyR7tG8Bk+qeZQZuQZ/zyG4wOkwrOW3HGMYbvnG+337iUOp5o2QyYK?=
 =?iso-8859-1?Q?q/rNEaygYM3Lu02oo+oJTaMY+IncnrlSQqREmTcSmXC4wCN6mYpw4L6TEY?=
 =?iso-8859-1?Q?IzkbxftzgMEU64iCkQt3KMWr6SrviXdAxWB3sGgm0hXgcZTtm3P6IO0xQx?=
 =?iso-8859-1?Q?lQAicEvDQPG5Wa1idKMcebLCVDr+05ZR432WI5up/R0bPQ41v4vntKgecO?=
 =?iso-8859-1?Q?gBpcS4sb36rrDmWTdhVnb+evkeXhHK7ob8pfq3WQgmI0b8Jez0zKzlhhea?=
 =?iso-8859-1?Q?Yt5GWpYJ6puTisdEH/+iLwNdLPYWwsda+5I4pgC7z3k5b5m76IF0FmJoF9?=
 =?iso-8859-1?Q?VXaf45dkK+m1CEgPxiGmZRQluvhQ7JtUKi0Wt2bAGFSJ7zjNcKGt22DEeM?=
 =?iso-8859-1?Q?xgvPZV6Q+zpXA2aT5VNK1H55gmEaMy3n9xBPG/bBscuOUZFk++zeNzuYeL?=
 =?iso-8859-1?Q?bVD1UF/e9E204bSacvvJ62qSMCAGFxBwY2iFFIJk0kygFCB8RE0CClh1ee?=
 =?iso-8859-1?Q?lJUYDyky52EAF6hGE7g11EE8gfMaI9pZail4Put1g2vxrmCG5JHL3TfdLa?=
 =?iso-8859-1?Q?2XJo9ov/EPAnXmyK/elrQN9t5XlHmvuyZ/mExY3aQcZUzjp4o1ygrH/E8q?=
 =?iso-8859-1?Q?f2D192sPsxRHTxIpkFavuTAtNdY7boRuspi8SmRyPdSW9+0ewUKR3rDylt?=
 =?iso-8859-1?Q?VlECNFV0rX2mlLd4WBhJINMHy24h6JobyMNmkkpzs+4lLwxxYT0SuTa8Iv?=
 =?iso-8859-1?Q?IclLt45fdZGt0d9AZBJdVLxD6RpxqaFRUo4ORKGxErw7qDx1lQ+LlQ156p?=
 =?iso-8859-1?Q?tRMJX50h8+f80HELqzVcgyLHv/Hk6e9cSek75oMB4P+rtTcHjDTj7T6Kib?=
 =?iso-8859-1?Q?AT+NifBQfLG5705BfAOJ6eNWY2x395xRmgK6HtJ21vAlpdY72R79kf98G7?=
 =?iso-8859-1?Q?M45HAADFwKUJLQh9mhbD1XdCHNlDoM9tOsbpIdxKCOyjISwVuRR1P0XhTK?=
 =?iso-8859-1?Q?ujYX6cw2rpUM9/Wt7pQ1KIxAyU8FH88X0AUlh0r2gzLliZcw0FFoqwjUbM?=
 =?iso-8859-1?Q?Gz4dxOgDtOumGrXo3YzYhMwtpL2ztddLluJ2e8QAKmUF86WyGQ8iVR1HCv?=
 =?iso-8859-1?Q?SJc7zbuMwpWb1zJJExzgFJxgeUTHS/tXMyxEHkDJdj1PLR260p/tEExpN8?=
 =?iso-8859-1?Q?DgA2fqDHk3yqyR3KuKr2czKf3d8bnMenhK4Rf/ut?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FcATL5KrwkTdvf7sg3dxyjw88mepLgtWfO8jUehTHfKYwvE2Zr7OJSa+Zq?=
 =?iso-8859-1?Q?OOKeNlv9VAECEtgbsF+e8lky681ur48dxtsANu0PlLPcjP+r7OPeI/LqzE?=
 =?iso-8859-1?Q?w03NnUvh+IyovKsUm39vsJcKY4gacg5aEGRUOwj32J2RftOwktbmNuBn0N?=
 =?iso-8859-1?Q?qDZlj1dimu6XNKB6E3TfzeRJxl/XY4tFYNrEvrNKuJIF/+o9iSYm02CuUR?=
 =?iso-8859-1?Q?Eku1BnmS8Jgk9gWsb7S+q+JI2nttZ5IOtymTGiuZpBRVDhbwwV9elvSwt4?=
 =?iso-8859-1?Q?d2XRX9oG3ZbhZHL9X5/njSD0gl7rQwvLiz5hRYZvQtkn00NccbY47NNdXe?=
 =?iso-8859-1?Q?6SF/IbjtVi5zYrF/xFKFiadil+ceskE81qqoFTMdSvpkmLSlKR8aE0N5+h?=
 =?iso-8859-1?Q?T9P2ob9sJGJkcsgB9cCL+LXFuNDlzh1xFyJPqCjnHLZGm/laR9WKQPVSX+?=
 =?iso-8859-1?Q?hTIburPJMFz9Gm/b0Y6+WuC8PAIHU6pvwVtBXzAKPNszuJ1p0EYeK71Z3F?=
 =?iso-8859-1?Q?FQNHWoGo/yZ2sJeuFit79h3LdVgljYNxeQuMeyEGuHrN5nA9KaTeCU1K4P?=
 =?iso-8859-1?Q?oym4g1/sCq27pf8GaxlONY66+ubeq8s3IX0fhlGQQy/LkBkHSZHqWSmNCQ?=
 =?iso-8859-1?Q?XS7XefIdLm923qZL94n438BM0+YlnsIOhszgeGwxdW+A86TnH8ctRX5jR8?=
 =?iso-8859-1?Q?s8Obxs6KBPtTuhqLrEp9NZg4reiIvlzjD5h9+wyDmvKAGEowTfKr/fQrkM?=
 =?iso-8859-1?Q?kk2EmBIxo2HwbFPnHWOZSloixai10StaW76IZfz43bw+3HVB7PWPCTof/p?=
 =?iso-8859-1?Q?jtfXKrE4mMEWtWXi8FfvzKkQc97G3o5eg2bVeZnrxsG0wim9NKFaNyWR/T?=
 =?iso-8859-1?Q?KdnDApHW0BIEzeN+hkkqagw+A80L/sDwTcZMvwQLznmxBUCRcxUS/GQGsz?=
 =?iso-8859-1?Q?bcCXe21WBzO5hZvHcMkOPEXT6VYy87IbqAwwgpvUjQ8MI+JMJxBad+BJOq?=
 =?iso-8859-1?Q?0ihpBmovIV4sy/4onQR44g6+jW2JPLYgn5afE0BDgTLIlNi2ItA09jN7ZM?=
 =?iso-8859-1?Q?ZQvChlEUW6SSan12xmHG1dOitz+VA3afflRPxH2iO+0dRjRhBPTSvERc6a?=
 =?iso-8859-1?Q?comq02wnJyU+EZd0eu5IyFuYTE98L/X25GYc9igpyb8FAUFdEL0icRdbNA?=
 =?iso-8859-1?Q?+hUUv4K/scIkqVKfp6Urm2Lmt/DxZ0BEtpw3M9IudYRwOsAXetwyabqEKG?=
 =?iso-8859-1?Q?I/mC16s8EjSFMY5Z2j+wGmN+YtHjVVdus6w3MDTt44pfbWbaBF3RnQzlZm?=
 =?iso-8859-1?Q?qQolPo+YcsIfqrgc/55Waj+yo9gU/nle8oZcjDqluh2QexiL5q/kYTPn/h?=
 =?iso-8859-1?Q?+lFyZBuORSjvCcqat1/rL9Ua8da5qHfQ1/D7f7wfeTvzCTA8/B1VfZG9DY?=
 =?iso-8859-1?Q?bUJf4ijbAmqUkLTuASepIooTY1zD7v4cQsVa/seyvNHYxqwrdkOWNg6NAm?=
 =?iso-8859-1?Q?zDCUwK3rE+BBqJnBmb3AR4lY/g/cM4QM3lpy7EEktBJzXB5vckdM6b2t0w?=
 =?iso-8859-1?Q?/Ma1PM2ByQKNWxPrYQw7wgJ8SkTdS6ioNR47lv5J+EwRmB2fIzteOloOX7?=
 =?iso-8859-1?Q?0AEwJpyc6L0etVWPIbYsyqu9rop3tZdWRMVKPVYBrEZ/HhKrFRQVcY1lcr?=
 =?iso-8859-1?Q?Sal9thXCMI2sEDEoy2HG/ZiG0uuqpgW/24PALA1dKmGBcpq53bXb5nO1HE?=
 =?iso-8859-1?Q?kOAqvi4TgoYpJqPVj20YjJRDK0y93Kmc4TGhyD7W1ZQs323ubKni6TKZ5U?=
 =?iso-8859-1?Q?vTQ2liOXyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6d5b0-f07c-477c-20bd-08de7413550f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:31.2887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMwv76/UqjEtEmJuMqvSb4tNWUnTKE/hyH6PBMS403ldl8f+t1R9f4msB7Nc5KiuwE95rfGZ2LpYOw0c8gzk1l1TzY+OnYg97r532J2ejHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW=0A=
I3C[n] -> bus object, so make a nice wrapper for people to use.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 3 +++=0A=
 hw/i3c/aspeed_i3c.c         | 9 +++++++++=0A=
 2 files changed, 12 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index b8827d31d7..42c9eedd85 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -31,4 +31,7 @@ struct AspeedI3CState {=0A=
     DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
     uint8_t id;=0A=
 };=0A=
+=0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);=0A=
+=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 2700c5f4cd..bac8c55bb0 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops =3D {=0A=
     }=0A=
 };=0A=
 =0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)=0A=
+{=0A=
+    if (bus_num < ARRAY_SIZE(s->devices)) {=0A=
+        return s->devices[bus_num].bus;=0A=
+    }=0A=
+    /* Developer error, fail fast. */=0A=
+    g_assert_not_reached();=0A=
+}=0A=
+=0A=
 static void aspeed_i3c_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
-- =0A=
2.43.0=0A=

