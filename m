Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A54606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=U1mQ/uh5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtTx-0005MJ-Ut; Tue, 27 Oct 2026 22:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSk-0004Rz-4a; Tue, 27 Oct 2026 22:32:27 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSi-00082z-2Q; Tue, 27 Oct 2026 22:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdYLH0n9z612S2B6vzRJVEvz0cdPmUi6KPowxoCvjikXeXXwgMQHxdV6V0tKCZDe+u7P9vfuJIKM5/W4v7tUDJXSLIjXNrt3vd1HC3VckwjlAVsz4iAhsSpIPRcDhF9oOj7KQFDNqmZe4vOBMePvzN1dgBmZtCW7socuBbPGsm7L0lwdjaFftE2/XN+K0SKrdZ8C50yCzz72oZg4OPYBMl/xz76V62fQhSLx5toOm3DhBq2nfiXdhC7CGEXsIiu4dze/iuTBr6EGqboddQuybDtZJbp+yIbtL67K3GjA0LHVDXrQas6gpy38Akb9jEsEuZA7flxGnSzPqUHd6sNQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIsWFyKkkB+zF4juebxgWX4rKJ+n95K+Vbe7ssL/Wnk=;
 b=KVxSFwYTRuq18MhMHOoojW6QlhoFxhGuKnHhFWpO8jj23JlI5E3hPF0kwexQOzXxrw4xjZcRu6T/KRFUa8vsZPW9PdesC0qeKm0q6OfdToy+p9fbKFguf9xlIEZvQ2Dhapl/y0OCMsUa+k+IslYI9XpQkPQovwD8Ra213GYzRHWPanrV5YHAtiMtSRJNQR0SwmPmC7fmWb9XiErRqPkXfbVg/u/10xdfkBNX8bSQA5YBzN0d8PkCtFRfjUnkmT08KJDbRFDg3TTEKnie6xCvBegvIORLiEQcADVuxIBF5jvzDoYimdc7rQHuQWSjkIVhukwxp3HiMS2poG5J9UmDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIsWFyKkkB+zF4juebxgWX4rKJ+n95K+Vbe7ssL/Wnk=;
 b=U1mQ/uh5iFClIc37GUpfZdmwI3f/QvvDD5fQOXKm9E2KIsJFyH7sVVxOIMDzJD41QsmcKPB7gqy7sedpRfPCxHfSHmOHrMCzxM3PDl+oLJUhF3P4ppkICiT7pQDl5Nw03GyuzwQF1bcAMIn3j6HKDh8DtaL5XBkxmOgmIKbxO0te7jT+KzylSGfeP/y1vbRbmrFnvvtlFWG2RKp5Xaj//ZsuXLMI4E//SigN8VLQoehuGCTRmmFcdL7/wQ9XoFKAnLlaOoAcIK5SC12Dh6O7iKj83hRx8ivuxL4KpM53qfRMvuqOVDy4G9O73IFjQieGXCkj2NgVoNY8zQ7tA7dKYA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 11/13] hw/arm/aspeed_ast1040: Add Caliptra as an
 unimplemented device
Thread-Topic: [PATCH v2 11/13] hw/arm/aspeed_ast1040: Add Caliptra as an
 unimplemented device
Thread-Index: AQHdZoSGG+7F6jds40CVbrDDQNcEDw==
Date: Wed, 28 Oct 2026 02:32:06 +0000
Message-ID: <20261028023154.48395-12-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: b20e4ccd-f284-4dbc-472b-08df349ba8cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009221227099003|261009223027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: e0h/YekXSyWYCR0d/sPgGehX0wUmMyWG7pE6pqsRWuvju3HxUbJaICHP51sLveFwoOT++1ZBekJ8t845XU6a54DrIOWYIlVox+CavYY14+vlVcLFBMWyQI2oyDyEKnxn+fUERIIcbxKj5abTnvpmB3eMWdnKqdq7ZS4eSwAGIvB1O0Rm7hC1GIy7c8q32zmaplgjab7f6WwFat245bXRyMCIJ8SN6WShY1ydIg/IzjjD1RuzJQee7UohZOwiCjDtFnfr0bjokRM4S6I/6fKlyX/U3IjjRbvQsREJqEJBCxMuNySdFoV+xkgsnnc07Agh+iGXtW3QMArzGX3yXeskkpT+BhpDe2lELYRGEaR7emLvG1x5LfWstBwT0bty0/LcT/8PasoZrXDm2hMhBzbSI8+e/XG4fPKRaT7FXlcfV+kj+WYvWU/iAkxaHZcmyIQ7rm4ZD74v43gBlawZPLrMd1ZnVsA9aRFygtVs0dz1IOsvOvsiNdH9ZEOI8CcyF3DHtaUlmJYxh/jO98ulwTzTdQGhZjKDzNZIbWs8JBYVwaoHI1rzGRVCu9Gi08QT0B0xhnG5iEtGzrYqXk2oEH7DswSkdJvULA19V3pvzLsuErrkK6gDN1i4oJbAEbimkMDGcq7u+YTaZheFqEjwzuDkPK8OavWqkoBA1OEhVAic8rbO+6GUCsevQ0AlC4EsIXy0zGHHdVTjjeY/wTYuwDDsfhwSkph73vv3Y3wYqYShFAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U+AThDQC88WcsU3JnlLEtLOt7teJIZvs7cznFiUEXaoIfHySXAHise5tgJ?=
 =?iso-8859-1?Q?7jSe3v1/S6pd9y31RMIbCf/cG51jMqsO4xd9Y+sY9ZEqkdHiefmZ8MX+bm?=
 =?iso-8859-1?Q?E8WrtcyoWhbyMcQb+gtreQUevrQ0XFQYTN1amLOe2q7lX5eNMTwB/W5a0S?=
 =?iso-8859-1?Q?ItndvUpz1E3ovZjQfrqf6bfR7UxjSTDH8jjRI7FdNZbljB+orcM29qOnOS?=
 =?iso-8859-1?Q?665b4y2V//Pd4+2xqByQ4jb80Xq1LobinlAmML9zloNrRjTXbW+ltrjmk0?=
 =?iso-8859-1?Q?1jCkKJEv7pLIj0euaAiG0O4p74PRWNaHc/jxCmYL/I37SJRjm/8HnW9DW3?=
 =?iso-8859-1?Q?df6U+CqFmIa7Ey1+ivrc1aW8GwcFRMlq33A1vgtaBD4hXcelhUwoWuKy3p?=
 =?iso-8859-1?Q?xMyVY2fEo741mZOJ745e59207nsG8e0WRxbwYKmX6nqXoHhX0lXJqSRJO+?=
 =?iso-8859-1?Q?JqspUHGOy10U1ETDwvB8sQPOdPQhyORfjBWQL9dyMK8iCm23YbmtFAfSBS?=
 =?iso-8859-1?Q?iKoqc205AIzQGXaGyVBKk+WmilHm73T6lxfKHV8MlbzOpnY3BUVsoEV4hh?=
 =?iso-8859-1?Q?Jc+V7EzjEuUnWS6KLa5ajsLuei0jrK46tCv+o8E33/UhG9c+m26g/RzPlX?=
 =?iso-8859-1?Q?oEvMwBS69xAWmziA21dgYuHjcL+rZKZKtiFZrbbhQ57aarKWoEnnqLyver?=
 =?iso-8859-1?Q?hDO8igh1Qe05Kc/mPZC2gyXzcwNDMx/J4qkAUEgcz4RfN8oDoFCe2Or7Uk?=
 =?iso-8859-1?Q?+go8La2vf09H+N7e40HTpp1BJFCJxw3FnWIW8AU8jAn68O9ko5PlzvG651?=
 =?iso-8859-1?Q?lu0mebxPUSFaCkf8iAgvfvD1XrEacG0pBZqqTWlpqsmLQMCoHrhMEQylgk?=
 =?iso-8859-1?Q?ZEA77Ax0gYAU5f0ukIcsOIBVosfvvlGWDoZbA8Spz5BVZkYdwdwxohzzCZ?=
 =?iso-8859-1?Q?unWIOhs0nb3ACAPINVdKQnFtEtKhrCZw3f67WftJh61c5efzuWCE3aHJW9?=
 =?iso-8859-1?Q?wOx6rf4K8Ok1LPWdDrC0I5s/CriyhkJyNE1gW8WD8zfAXkFXK3JKFBlYvc?=
 =?iso-8859-1?Q?PY56gPkYORo3VfMX0wd5Snjyw7vGRwVxE+0jiNzfJ5Ab9eXZzo2DhopmjT?=
 =?iso-8859-1?Q?uC/BHpGoZ8ToltTgv9hZhHUW0Ktr69JLfq8F1REPgKgCK/Lnw8r4GQzRkS?=
 =?iso-8859-1?Q?bbQP5InSlke1B9w10shwx+b9JH7ltmCEJLGQZwyD3LCg2FQ4Mg5lYM/0p7?=
 =?iso-8859-1?Q?NzhJO3MmwD2bxudBkJ5ktz+u1r6o/DgPuW+obiBrPRwe2dZVH8k+iLnfSB?=
 =?iso-8859-1?Q?qnFB8e4dcFr2cDFRKa4Na0Nl1uLMnKLmgXGLHlWKCCSFtqhbphM4aP+av1?=
 =?iso-8859-1?Q?MgGcGtb8c50I8aJ4rYFzEtjJjNZUlZJXLHiSid6CXiLLx8HRGrI99Y/GpU?=
 =?iso-8859-1?Q?lBhVUXxEwFcVgMBCKOEZHaMhBBF0sAZCk3CxTf7aFwjt23IMfuOFW72q8u?=
 =?iso-8859-1?Q?ZkJH8eLpihj1grXQCsWFaL4O7ARMbOX31IvA2HXhLJ9F+U9AS/PMcM5pBo?=
 =?iso-8859-1?Q?I/6zS8SP/QOoCK8zCjq8Q+v2syQksxO/+Wukr5v3N7JDa2t9Lbfs1vEE4P?=
 =?iso-8859-1?Q?IDa4x9mfKPQP0QxEYaTlHFAlPen/AkZztPGXQZHukGQLLKF0kAa1qLOll0?=
 =?iso-8859-1?Q?9ghwupPp/T2XCiKwL3ppKOdx0GlbQbe9L3aLsNZ+oCPfkH+bvaC/b1+4PF?=
 =?iso-8859-1?Q?S2q0yaV/a0LpOIWrNryK64TY4N1eWdm1pKUKwYcsA+xQxtPPaj2Rv3pBBU?=
 =?iso-8859-1?Q?/1NlDErTrA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e4ccd-f284-4dbc-472b-08df349ba8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:06.4590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmdXrCGNP9xbUFl/VYXqqDqNKSElju8PvgYkm/uOiz4yPgWT1ZYksi9aMngFpzNEPcJunGQCvS98B/YGqL2hUDG23r9bB6wy7Q30znq2fJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AST1040 provides a Caliptra Wrapper at 0x74200000 with=0A=
a size of 1MB, but it is not modeled yet.=0A=
=0A=
Add the Caliptra register region as an unimplemented device to reflect the=
=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 5f6aa1503a..74a1097bd7 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -93,6 +93,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
     { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },=0A=
+    { "caliptra", "aspeed.caliptra", 0x74200000, 0x100000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

