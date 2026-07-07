Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C2BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgy04-0000zC-2J; Tue, 07 Jul 2026 01:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgxzy-0000hL-T4; Tue, 07 Jul 2026 01:05:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgxzw-0004dn-N7; Tue, 07 Jul 2026 01:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBBIzgD2GyFtdGLXl77Co0Wj0BG2mRfqjCeR9cdHbgZzb50Vl8XcG9DQ96rqJiO0XEgpqelWDhDCvQglB0yLLO5DXtEdJ0QuiWbGFwbYqILrErWOStgVjkd5Ka9KbJ+WzwRWdCc4324kOVLG/TZvhC54gyX1m5kb8LewhkLrXj5NGEPK4rP+DwG+qs8OnCNXqwt6jz29pcV4cGI0xKXqHxtLeK/YdrPrNogDfSmSQu+7rqpUV6q6xQ4Y1ZhrAzv682zmeZKU5lFOHxHOILI4W0/J6g1stJWwUh9qlxrpsyAxANtJA45I15pBYwF9Pxfrk6tNIy72n0N6lyLY/BbAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drc3njokalu601GhTD8dM+mRqeCteuCt4jCEdDDl7e8=;
 b=AZ/WMqy4BRIxDayvhFNcn97PBVdItE2lfeDdgf+OU0ClF6XSJberN82YLbKwPz51pRVMoPehURj+DGKAvtbN3vWskmnUy1QWZxW1VuHPGmN/eFz6CioX9afOC6eK+JVte1jn/KT9I0xhLRuNZueLAaFf8HoNLTtk2R13ot0Je/24dO1NagI5/Is3hMeDpObmABrv5AApK46HEpwDPZserRKOb2oi6rp1Xxjiu9GMpsBDuu1tM1bbJf0Z6fKgWWPrgJTPzm0GQvPE6KfOiWe3sTbidXABtXaO9aHL15yqrqzOEdLkoHig/fbaczQrZsF2zKeSI4BLBl9MPRT9/V05kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drc3njokalu601GhTD8dM+mRqeCteuCt4jCEdDDl7e8=;
 b=EA/jCrrA8j8Vmj1j3CU7qS7qH59jOuxu4HFgWiOC4Zasq2rWhgWb3ECRL76JHCdgBCdMzfOhBCce5swq+DUoY4nnKSR7Jymewjlw11swf6pBOLquIz2BHQ4xmpDOgK6lTCpy1QBZ2TdnrJ2VdJJiu9e+1ztP2OUvGeT3p2tZpnRiu7QYauGDLWuwBJMxm9olqwMAP8ARyPJXALSs2nyQJzSsIq5p9hYmF19fxgHs6Ql7bDGk+z9uc3Yv49u3KGN+up6ts7pLW1LByxYq7jfAUJHFc6Q7m/shHKT7DflBWlA4amnkbIecCf8UJ77etGRZyyY1GHYF+rs3XBHrqBbpPA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6259.apcprd06.prod.outlook.com (2603:1096:820:d9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 05:05:23 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 05:05:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 0/4] Refactor AST2700 SCU preparation for coprocessors
Thread-Topic: [PATCH v1 0/4] Refactor AST2700 SCU preparation for coprocessors
Thread-Index: AQHdDSPTNeWdLxD24kereOpLPDH1v7Zhge7A
Date: Tue, 7 Jul 2026 05:05:23 +0000
Message-ID: <TYZPR06MB498047BCB404D559805C79C7FCF02@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6259:EE_
x-ms-office365-filtering-correlation-id: f567b463-d62b-49ba-7be9-08dedbe559db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|13003099007|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 8iQ8Y2JnwY0habKrWiDY2AIgQO32tlUG7TEm5y+10fc2rXcxTGiYfAu0eS3cnu/IjNWyRhVPwnoqOHekCpr9TnuxZbTtApk1TGFHFsJ01GNmx11zswcG1Ja9OXxM4yFRkd1JRLnDq6+nN/e22lCYKKLs3TLSgrzBmbn6ri11iT/VltgHz6ShQhchT1idostcdvWFLwQdhJbU/Ei03QhBcHA5PzHa+3CWMCgnlxL3SbQXrnKqb41+HsKl0FOJbugyObqYgv06LbF7EgazSlpPV8d2cUgGqoDU51kX/aeENQlwRTy/n4UiP6exLrcIGLJjkLHip72AHSRXgbVLuRBV7uQ9oc4FXWxrsdu08YLKQuZK99nnaVlgYLKQYPK3frhLOawB3bHM2iUPDDt1OdW12/JrhYcmJQ51EEgSCCpypMupz4uOCRvdQttk96oDfoTQ4vlWloIJY5oS4U5e6Ro7fUYN0ZCVBjUeYloJ3Ek5nAAJhzI+QDdGTnGlWml4RzyPrqiVV70/O8dXfTWCJl6wrHfl5uroKaG/YPUYkGxwx03OWeuXbChZhMo5ueGIKVoRQAZzlW2sQGZqhYit47jLDeu2G8xIrofmUImk3qhXx7jCwWnqzgXJ2BPFJaXa0afGYKcMaL8QODFB6ARkNhO4h+ysGPJXuAnIPiRGq7iEk1SLYVHLh5AkbYcCNvUBfz47pKRyqmB6AyBhdoqAghryjhu4CBBfhg+1TD0yOV3pgvQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(13003099007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VGTWEMXCx97MaWcbnWmHzdLpvRcpAxtKwSK29vw52tuFmsV3SCISYp0lrs?=
 =?iso-8859-1?Q?WH1RGOJ9/pSLPWEZ2z7GdvsBE4OycZ+GdMiLKaIw4pCaMjOovh/2hcpVg9?=
 =?iso-8859-1?Q?X2qwTuiM4WOxRKZKSCbM++MrK/6y/zUV2f/eyj/PhpAtoUGKsHPZz5TEtA?=
 =?iso-8859-1?Q?lAyyiwB8BEA1bDm8kHQ/fqP1uRbUOgTF7otKf0FXnMu5AfBKfHBJ7Ij6f/?=
 =?iso-8859-1?Q?i6eYxoHZZvZ0Tn6ol/zBvHBLG5MojP+4wjFWWReZ7RDi0MKvI4aA2cB0zu?=
 =?iso-8859-1?Q?fh+ezjYBVJbuTH/0tI3vV5jixE5dpajnzxhQbc7JcPmyoedaxGCqRidGa7?=
 =?iso-8859-1?Q?1N3i0WTr824h92GWbjzdkBb6h1DH9bXfR2Y91NredTiJkK+7hvsflTEc79?=
 =?iso-8859-1?Q?EHD2qFy8nr89MyyP362aF0HZkkIjlbU6BljX9GznUcWLhwgPBXDxe56BCm?=
 =?iso-8859-1?Q?M/aDA5LNSoIG+E8DJF+4YASDa5WV1kQw/Cck7WOI8pniPNwQpcMnE1+8MB?=
 =?iso-8859-1?Q?GzncsK/Yw4QVcfoFH4V6ngMFEqf2eARFUNI6apwYtygakWB6qdYLtVVL6e?=
 =?iso-8859-1?Q?W+T2pHjaKrPY8UN9otENhPjKfoc9IGVGQYDAkkemjZq5R/AhMKtFQG8pfR?=
 =?iso-8859-1?Q?m0t18BYcuMRgVu7ZdlOEqEXlVnQkGq1k4RrUPKTSX9Gaml6SfZnMukj9+Q?=
 =?iso-8859-1?Q?ZPHfE5cOTyg1qb3ttLV3La+8ZrxvxPoSZo60gMZbqmloS6B6GV/vokn/Qj?=
 =?iso-8859-1?Q?dKQTNc6Esevp11igcXOHKyy/QjGI3EgLwpcretXIa36VJxlvNxiNJO5rX9?=
 =?iso-8859-1?Q?ar+IBDVFS9/SknmaVzbEs9Ixhr8BoMdRYTTu4k4L7ueGJSmW2b1ZmS8WHi?=
 =?iso-8859-1?Q?6Ost4PsQm4mng9YajXO2MGSk6OnVAIatbNLuPiVaAEg2Nf8fLte73NrCOo?=
 =?iso-8859-1?Q?prN0au/sFxsJBdJm5XU5oCt65odCZjBy7zQX6EpDOrq4pK8JuxauuoIsjd?=
 =?iso-8859-1?Q?5T0Via0DT/f2yD/l40mUHHklbGeg7N+3F/MqOsJYAyDkFLCVo8GJ+MPVr8?=
 =?iso-8859-1?Q?LCktJ8Sj2uIBBskaPj7UC6mevPdK9auFOyFvwx6rWabjSrMjCJfGRUQmUn?=
 =?iso-8859-1?Q?WhgYrEl/GB6RooN5WQoEneFJAi524qzhuTRrnfQ2X815zstx7P6QlLbL0B?=
 =?iso-8859-1?Q?njDEGNU3EBqkQDtBhcciTmdu59gK4Qp9cjxpp2TZl+XoTAsMBpZTfrPnGl?=
 =?iso-8859-1?Q?2cjeRTtLjt9XTqmKgWIu5tVff2lt9hu8dCLObykn+jFldqdFL+MKCIAvka?=
 =?iso-8859-1?Q?G/SfXHssLVfh2BH3pKN9TuHSjR11dzZgFKT0jx59ZFwTzklv6EA1I9G6eg?=
 =?iso-8859-1?Q?2Pq1+QqCycsMBfsFeSJchF2vVrsedIKBBVRUZftE45pb+WuxNj9U4AjBZf?=
 =?iso-8859-1?Q?za5F7YJ18iJ9BNbplPw6Y+bSnW/O+0qGtJxgfsieDj2OqwRZkCtsZErZQs?=
 =?iso-8859-1?Q?tcfIOzX36Pyprc5FqeVRrEqvw209xHutsOT/oOYGFKnwTa45tEUcXigXYM?=
 =?iso-8859-1?Q?2FOf29ZN4b2GlcnVxXjxFDL8g6/SvOdjOhhoI1dsrgaQadKJAoUf7ZKhAN?=
 =?iso-8859-1?Q?X66rO7wJb6HzehB8p6iB4QxzYq9Ac+wFdEYFJfJ9AMMOGNLXtNiBh1Ui0V?=
 =?iso-8859-1?Q?KnwUmBiqjK3/1KpZAtEbupqfQUvkuKdX1woAZeDotfzOrxsAoEEWWmD2cq?=
 =?iso-8859-1?Q?fuotd4BpNa+BHr577qeLHy7KmibKv2V7KoNiGxJY+sP6tCb34sRPekP4w4?=
 =?iso-8859-1?Q?qnQly+341Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cJ6DOrSOIikt2BRovixM6C9AKguEOGnXHdxlSynN3BTJPG1o9kHiJSKNYSv98P1SMHbGQs/uAk6i4zUaVecWgmkXHzJPXc24KhYO+tIHt4gG3Elet1dCw2Zkso1CeQ+5WbGnQtL09DNj5RaNO/kPMy15ZvQzQ8YO3X3xBUOlKidMCdKVjcK8fUwseb0IU0tmU4J/1dqGP8MfQ8EeyeNGeAmPW6Dox8j8TS/epXkkQ03A3esA242OHsBmwLyV/JSgtAKJcFGE76RXDqlA3AXwL5eU/JR0o+4dpCCUJxrTpmHRldlqQ2BqYGXM1z92IS4DJoAcg5aJL5DcVy1fudepzA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f567b463-d62b-49ba-7be9-08dedbe559db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 05:05:23.4136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsai4yY1nV6a3JGQy2bF4QNFyxavlV+e8LXXJtJydEFIPDgWNa/9JETZs7Ks3oo8oOTd7YNZ93AfuOOB/zFpw5IuYJzeAEc/uoEME19OGsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6259
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Sorry

I will resend v2 due to split [1] Original AST2700 FC support series

> Subject: [PATCH v1 0/4] Refactor AST2700 SCU preparation for coprocessors
>=20
> The original AST2700 FC support series [1] is fairly large, making it dif=
ficult to
> review all changes together.
>=20
> To help speed up the review process, this series extracts the SCU-related
> refactoring into a standalone prerequisite series.
>=20
> Compared with the original series, the SCU preparation patch has been spl=
it
> into three smaller patches:
>=20
> Introduce Aspeed2700SCUState.
> Convert AST1700/AST27x0 users to the new SCU subclass.
> Move the SCU link property into the AST27x0-specific coprocessor
> implementation.
>=20
> In addition, the SCUIO reset handling has been separated into an independ=
ent
> patch.
>=20
> This series contains no functional changes. It is purely a refactoring to=
 isolate
> AST2700-specific SCU support from the generic implementation and prepare
> for the subsequent AST2700 FC support.
>=20
> This series depends on:
>=20
> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260706052701.114
> 1740-1-jamin_lin@aspeedtech.com/
>=20
> Supersedes the following patches from the original FC support series [1]:
>=20
> Patch 1:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20260417032837.266
> 4122-2-jamin_lin@aspeedtech.com/
>=20
> Patch 2:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20260417032837.266
> 4122-3-jamin_lin@aspeedtech.com/
>=20
> [1] Original AST2700 FC support series:
> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260417032837.266
> 4122-1-jamin_lin@aspeedtech.com/
>=20
> Jamin Lin (4):
>   hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
>   hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
>   hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors
>   hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>=20
>  include/hw/arm/aspeed_ast1700.h     |  2 +-
>  include/hw/arm/aspeed_coprocessor.h |  5 +++--
>  include/hw/arm/aspeed_soc.h         |  1 +
>  include/hw/misc/aspeed_scu.h        |  5 +++++
>  hw/arm/aspeed_ast27x0-fc.c          |  4 ++--
>  hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++----
>  hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++----
>  hw/arm/aspeed_ast27x0.c             | 16 ++++++++--------
>  hw/arm/aspeed_coprocessor_common.c  |  2 --
>  hw/misc/aspeed_scu.c                | 20 ++++++++++++++++++--
>  10 files changed, 68 insertions(+), 25 deletions(-)
>=20
> --
> 2.43.0

