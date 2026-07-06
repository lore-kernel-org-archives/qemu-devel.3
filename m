Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75831C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeys-0004Q5-0K; Mon, 06 Jul 2026 04:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexh-0004H2-HH; Mon, 06 Jul 2026 04:46:03 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wgexf-0004bJ-OA; Mon, 06 Jul 2026 04:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPx6pZZnbj4sxXhl2uCjPPxDof5NBwgZLx+nEnCwVAKL0D1KKn52zYcFYKgfC3LCBYiItnzTyw7NYopy/o3+gn4+RZKzqURusT/R9BXll4DItGV4Ykxq+BhdnbPDGOeMMqMLeyYkbFpcX9k4adP6Q3K5B3N4bsRNqFNhmVT6LsUGu+d0gftqJNIhhQhMZU7OFsZLALgTsqPVIYIv02/RX38AmB3LQMFWxYU7LRO0X8MbB9hUn1TNQCqDLwCeQ9CIg8zwXqXdUkbvG8fr/tSKQvqPIocP7VFK/KOpl7pbliZVTjtQcehiF1HJkwZasOKd6JyO2rZfgPjgPoWJZ5UVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/+q68TMkR9cYYOfNcbXTlZ0YPWQiqdzMUS7bfEGuok=;
 b=rKAt0exlHJkg8z2oZpo9c+f77jGMD1O0OvAab/fSyKmutx00qhO+0iwPL7gcMvIo/YkKND4J5kpHT/4oEXwVwoXQ4dgWK/X4cruN7Zcn7d6OV5T0lEvmLK2A4+/0T5xGdoFmOZuEocVZcEtf3vT9BVMb8sxJ8+wGV+b/jx9XXtSv0JfVwqc19mSDBdDFX2/O6YiiVKHa9eweOPFCaF2b0mkYK8uBRlaJP8pE+ouerWO0QHZnPa2MK75alkc8hf2IC25621xKmReMijiadwQwWfgJRUOztlytU3bgMQHRTmYVksEYuTUty+v+pwGffVC+OQjOS5T6CYR27ggtSLh/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/+q68TMkR9cYYOfNcbXTlZ0YPWQiqdzMUS7bfEGuok=;
 b=LVEWKjVwH/ExsvxViScSlLf3uDlFER/LDs4epyhC9QoSZCysVAoQX0PUEZ2tmMF5k7unecJQ5dSI7Ph3H9XyiuubVOEy/V9NZRGIh6YgCUtOLuMxnETuq4A2wi5Rdg6xEDBwER6kURZx744cAj3fTeRmstFU7zpIX4U4f7VJxrwrAyO+TaAVCw4yCwfv/cPz2ufRPIXdacRcfiKpufWr+tlGJSoDppIVVfhSQFekBdgimGklmcZwqlkoJyfsGciJV+S9OaEi8ECdFhvPR47q3DHQ4GX4jaPHmsUYNAazOWtou5nOgmjVIYGNlelbBUBAqZIlZlFLRGDoHm4SeJicWA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 08:45:41 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 08:45:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/4] Refactor AST2700 SCU preparation for coprocessors
Thread-Topic: [PATCH v1 0/4] Refactor AST2700 SCU preparation for coprocessors
Thread-Index: AQHdDSPTNeWdLxD24kereOpLPDH1vw==
Date: Mon, 6 Jul 2026 08:45:41 +0000
Message-ID: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: c2c9e151-0184-4ad8-e4f5-08dedb3af600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|56012099006;
x-microsoft-antispam-message-info: aOnFcPVfqzIj6GaeAQFw3CaKkuMD5Q1mRCp1bWDav8rZcN/w76mK+DVD0AO+ST68N3Wd8sMFoSVBZ0vOoRxWupl4km+gcCTiLPW5J3v6Vz24aGccf5SaghdHDNKBdItyjcfM4A2VmcbpZ3JA/VP4qLL8c+GIt+XaDDeVUvYWP26iuXX59VwPUOJvjYxi7NhbyoaFZr8ZlKShp0D9rB8wZBzTquhqg7md3qRB0hTFvvfrqn1xTChAvQA5y6hcPLRJypQaQHk1ynZQrVUdJRd7VbXw700AKAPYmc9zYKDOPE18Pi9BwXZ70DTJ9nKVyjqGDP+gnO0HCRL/354G3cUueSns1416EpIw8de3f/sVzwpkiACFD9YJsItStYCGmVKkJHun9gzK/3H8BzyOs4yg3eTq0mKEnJfC5ZCXd+W+cdhh4l/2q3bxy9Lav75HzHJ3xDd4vqo6JFqwY4iI3R0xgAcYlFn0zt7FVb/BQDh4bt1RePuNqvba9t178Pa8KixJWOWJvQutuX5Ema0WmHNPZdrn4VuSEQjKE02tSURgskS3gZM3wqln0t0pdOxUK5ZlsC13lVdvdhnuwcUPV0NxBNDF/wqMgvXZUHC0iJ5AF5RDGkBu5XtJKxq5MpuyyRuH0y4GjWVZZzt5vxAnzItOeyeB9wDC6iJBvwZdljgF3AW3BOpM+aE9laAiT3F8zE7WgRVkU8aQriXn4BxUc0qgznknjtiyyccOsXKTJy+9B9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wY/rtkvYzicHwgcP1L4+VXUNFNm1DWjJ6lx50A1rTHeuNGnVgygx+JV694?=
 =?iso-8859-1?Q?b7vQtGEiwYWUzv7uuZHoV3+o95t/kGdulj/YfCyDMq4s0BG4/t/5aP34Jr?=
 =?iso-8859-1?Q?0tcud++NkH/x/GjxB28RzsA3bIsavZlWxX38F9GXvRAMDMi5jFANomGWnt?=
 =?iso-8859-1?Q?YpYSSDo2ylgNJGEaQsTO82AUKQrd/LdzWnefVt/VLyQ+V1KKdw0eK3ifkQ?=
 =?iso-8859-1?Q?PbYP7EgyeWaPXYCmgVPXR5cXt4MB74uukAaGRK8IBTMcwhlYscyOq8WCYX?=
 =?iso-8859-1?Q?XkAsUicDD71yZ+U6eCyTstOqvmIytC4nF5K3BLB5qjUsVK7HIxNstb/G9K?=
 =?iso-8859-1?Q?guqOM7ibx3g/4ZMwGp26aX8dOw2WDP5vUiFlXW/+Anxg/RGpMUIcC7WoV6?=
 =?iso-8859-1?Q?pqOwsUOZRMiO1pAC2xCefvAKpUFHxN+dRhFgQpy36tyYRCW91kk5jyhT4B?=
 =?iso-8859-1?Q?qCwhQrOzAM15ZVpY+XsM+l6L1xMeNw3l2UVrIU1FphU4RktHIvAgIACslH?=
 =?iso-8859-1?Q?G7J/hKAY8U0DrbnLLMwf51JX5v9jTcgEBhICsjtjNEJdi+HbFvt7/wU/Nz?=
 =?iso-8859-1?Q?drSMQherG1CGccHXNcONn3em6zOgRClVtkyvzLxnbi/KuUlg6InHhceFdv?=
 =?iso-8859-1?Q?kJPDT07Aj6ifOwdRgo3iIExjPr6LuQ+nG7kuH9BKYjLoFaIPZ/0eicOYRd?=
 =?iso-8859-1?Q?qmoGzD2pqNAcv+jSsFLOK7+1exfNUOMfALbKQjSYxKSaQc4veESby1LmrY?=
 =?iso-8859-1?Q?b/0Y9GEEFwvXZEnzDCBr1O/Iw8TS1j0RPJvBI1eNGU05QU5pbXZrPri1yp?=
 =?iso-8859-1?Q?y2c9LwEqkh9ygOJVtXQuN0d2wiCxlAMaSZAz/5N7SQOLc7LYqDmixAbpX3?=
 =?iso-8859-1?Q?9/ULt+bqInTT5Qfps+5inL6gF9FjBjXdmLnzHTuS+PLdmd8LjATFUisWXp?=
 =?iso-8859-1?Q?KMAWSqiS/y9Lxxgkwaf0aSS4y/yuE6UYfEVt4Xf/C0g37cITBmjp4+Sfy/?=
 =?iso-8859-1?Q?sIDgBNHNkiK283dmMKYKHmv5NzvsbGKAwe3W03eJuTRAOQOC9g4E/oy3jt?=
 =?iso-8859-1?Q?C9v659NwruJ6IeTZvsXArg3RUAK43MdnNbnWKOfQTqpA1QklOftP0XpeUS?=
 =?iso-8859-1?Q?H0Kx6d6q18JSeHFGXvRm8dYp0M4OG4a7Ro17LpFD/26Ogteh+O71GbRobo?=
 =?iso-8859-1?Q?9at3SnyRs8S5XkyAbvmDgr1+RJzwfG5hszmHbZOWf3piCmejXoou89yU8A?=
 =?iso-8859-1?Q?Z/VKb8O1nXs5EPytO4vz6wm9quHk6YdSnuBr5Wfv1LNaRLGOWHUbd80esX?=
 =?iso-8859-1?Q?TuPEnuv+9lIVY49A3CzpmTCnp64+2iyxZsuiU5d2dGbHsv0CpK/Z/t/A3J?=
 =?iso-8859-1?Q?VYKOoQMa6fKS6jU/0bDEHA6wEz/O4Z3wruShrdjeM4UvqkAoJj9ctCNnT7?=
 =?iso-8859-1?Q?3dJKTquu2VVfTgSLcjnzT4pyIwIyMFOJh6t4g7SfgqOndVMFf1nO1aCIKw?=
 =?iso-8859-1?Q?nNjH/CIog57B5AphdrxmTGLe5XQkdXxjo4MBrv5OapVkuzgkmy34xN2+j4?=
 =?iso-8859-1?Q?7Pr4GRyOaFcvQLjCkzYut2ftNU5XcCXc2nLUVmwLKHw4UCJwKLkcnt00ke?=
 =?iso-8859-1?Q?aAREhf32xeruzfUVTxSHtxg0BpMBrIcc6lFjPoKbqhJ6yac4Pcq+2Ihdvz?=
 =?iso-8859-1?Q?JroSAPR0XH7XNOS3QLL3FJqaT9akwg9/29CvWiUQ2zH5ajB7bRYrD0POUd?=
 =?iso-8859-1?Q?yyjM5tzLFUJf69nPhA5AmQijxl/NdvypKmlJDasChY6kbxVebwdZCvUNod?=
 =?iso-8859-1?Q?6O91gDFh8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IMzGKsqfNkW6cTquS3yESJWZSLyY+ECPF6plxLfIoKOh8K+9HuhZ52+671aFsoKPZ5K7q8zKllOw4MV4WnUvkNSsgSm50+kcp+xJ11DWXZIR2E/SZ5An3BveATS4ylcQJAeBXyphpzzlYjdsyQTH/wZx5mfRozEbBJri0QI2gR6mXRTV5FKNvPAylWv3z+0lbqQu3pw/OED0zPiIXjXF5joY5gyTW1MfX7jh3cP3c/5z237YexI32k4AymQbyu9wxkQuLz76rBzWzUcoO0m9lx7qi69H/zZ+xa0FzzCK83PjMpBZih7qiqKCrunhCrj1o1nv1i0l8pwHx1yx1rbk5g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9e151-0184-4ad8-e4f5-08dedb3af600
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 08:45:41.4762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jpvh65kmKn4s1nCJsselwpN7MXXvokqxNhfyKgS1bau7jHdb6GGXPwQQ1qthjI4A+klN3e4UzS4QmC9KnDtUKdEV3Rg/Jj6VJ6HI6SyCH60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The original AST2700 FC support series [1] is fairly large, making it=0A=
difficult to review all changes together.=0A=
=0A=
To help speed up the review process, this series extracts the SCU-related=
=0A=
refactoring into a standalone prerequisite series.=0A=
=0A=
Compared with the original series, the SCU preparation patch has been=0A=
split into three smaller patches:=0A=
=0A=
Introduce Aspeed2700SCUState.=0A=
Convert AST1700/AST27x0 users to the new SCU subclass.=0A=
Move the SCU link property into the AST27x0-specific coprocessor=0A=
implementation.=0A=
=0A=
In addition, the SCUIO reset handling has been separated into an=0A=
independent patch.=0A=
=0A=
This series contains no functional changes. It is purely a refactoring=0A=
to isolate AST2700-specific SCU support from the generic implementation=0A=
and prepare for the subsequent AST2700 FC support.=0A=
=0A=
This series depends on:=0A=
=0A=
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260706052701.114174=
0-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Supersedes the following patches from the original FC support series [1]:=
=0A=
=0A=
Patch 1:=0A=
https://patchwork.ozlabs.org/project/qemu-devel/patch/20260417032837.266412=
2-2-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 2:=0A=
https://patchwork.ozlabs.org/project/qemu-devel/patch/20260417032837.266412=
2-3-jamin_lin@aspeedtech.com/=0A=
=0A=
[1] Original AST2700 FC support series:=0A=
https://patchwork.ozlabs.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Jamin Lin (4):=0A=
  hw/misc/aspeed_scu: Introduce Aspeed2700SCUState=0A=
  hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users=0A=
  hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors=0A=
  hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |  2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +++--=0A=
 include/hw/arm/aspeed_soc.h         |  1 +=0A=
 include/hw/misc/aspeed_scu.h        |  5 +++++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++----=0A=
 hw/arm/aspeed_ast27x0.c             | 16 ++++++++--------=0A=
 hw/arm/aspeed_coprocessor_common.c  |  2 --=0A=
 hw/misc/aspeed_scu.c                | 20 ++++++++++++++++++--=0A=
 10 files changed, 68 insertions(+), 25 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

