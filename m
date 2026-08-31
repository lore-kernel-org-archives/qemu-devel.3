Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F7FC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0umY-0006Mv-3p; Mon, 31 Aug 2026 01:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0umW-0006MS-K8; Mon, 31 Aug 2026 01:42:08 -0400
Received: from mail-japanwestazon11022122.outbound.protection.outlook.com
 ([40.107.75.122] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0umV-0001Fl-7f; Mon, 31 Aug 2026 01:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR7vmsmzdCCvWAk/K/sKek7UHvjz4sPPPjCgkLrUsgAX6lVcbPixaP2U2G3c24T567/53W2QnFdgV2Z22xoKLJkijvGD82hT+zSL98E356tQ8lBDgS3TvmLBFw47tzW8kixrAnpe/jRo0OyvVAygmy2Pzbm6PulrS6a2E/TAjZ3CW5P+amwdcJh1A0sZaCpRwe1IWPZzeg40H3Il41+j3T0JZULwfYvDs3YGeuuuXNrI+cHW+7ZJjK7W1ZNKq8n7SQIhfHg0YjiyUcvindIfkKMNlrjfazECbopCkBKeGNHLAEI1FBl/CNd6Q8OLM2KWZX23E6y2l6vYv7eB7wKzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwH4/PHTwnCQh52spbEQ7Nwk2eGmSqOK9pP4ISxHRfw=;
 b=OUFA+90nu9icpmR0UhE9S0dNM6wBhEATCDmRHyTP4DY04bs9t2EhJIFMD2ueEQreVw91E31/J4dvUXiJkCde00nyZDE0c3ahx6aTtOCkI42NMtRCxBmCPa0EtBj5JuX5Ro+3032/2RwKUetfj/l4PW/BJxHs9K/s+QtwW0Ldp+ec7jBLlJhrrFEd6XGc7542syDirZq0fcmZLcEhHyWIZY8EuhfilbPAk/J+XiGKN4FkVkQH+5aHipgT25W06UR+eYjGAnE4PcPkbEhGfVHoc5xyWegDtCH/uTPIjv4AzDp7zUzFVmGGq2ZwdiuDpiN8ZysqgmfIYV6WvOZ9mVwVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwH4/PHTwnCQh52spbEQ7Nwk2eGmSqOK9pP4ISxHRfw=;
 b=bRHbWqS/RaTKuWjUue50m2shNIPIqRWUbhcrPyxkuPpMhTSYhP24rJVKpisBZo1ygfIpTofMt3Q9xB0rekvFIYp0H4R5SVj2hpK5hRW4kWDyUVy7rKlqMYVeeN3zwZGQ14pcV/1w3DB/0HVAwMlYq9Ds27sez3A6Ye7Gbfc5legeHNLEEIR22wrmLoMCYzJdV8EW7ESHevjbqyePwC9HljA7ZPhdZWp/E0NXQLJE+UqZ/F2JkL2QeU6XYDNFaiEwiHyK+RlQgtAIYOEvUs+dkB86rvNmM2Jm812qtOn5bAqCtk7IjbX7Pr41GehtO+GoOJZTvp5PbU3tcieoNhd2gQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUXPR06MB8654.apcprd06.prod.outlook.com (2603:1096:d10:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:36:59 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:36:59 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/2] hw/misc/aspeed_sbc: Fix ABR and secure boot state
 reporting
Thread-Topic: [PATCH v1 0/2] hw/misc/aspeed_sbc: Fix ABR and secure boot state
 reporting
Thread-Index: AQHdOQq9/R0jZV18Akai2f8RyjRuSA==
Date: Mon, 31 Aug 2026 05:36:59 +0000
Message-ID: <20260831053658.462203-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUXPR06MB8654:EE_
x-ms-office365-filtering-correlation-id: ad425e36-b836-4332-4024-08df0721e080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: yfy2mgA7SzLg2jyzmpj2SUgJhHldRw4cSXf/rW3wpwIfM/07DMvTFYzUynFoAmV4lh0ISEwtBuYPy1QdJ/EOq7F19WZgZ+BoIjObStIAyqa0bqpnKFFsqgrQiTA4nov5GutR2cTX8YynxILm4zb794RBqqEpMDsMjYCiHmHgiUiJCUyCwoGfX0xlrl/6Iyy2xmzgV1z6SPpVUUcPbhX98aKv/x0c//CgvL/MKJE38bC1K3zH51ulH1nOcDDNdqFcYY0eHe2YSZA7U17jr8Y75xQcLAAH6w2u+fZkuf4x1F2R1coNR9Ykc59+TW+3cJmlEI9d/D809Ev9x1r1XAtXkVinrSIU1rWZTaSXJfwbHwX4SWNLwk+a7X32Mr2dl6IPrveTxAjZjtfbbpa66gFuJZBdG7y0GjdIp3xKAVXhbusPsXdUtnC9T2VaSNgJTXB52dm9QRlNTv3nNCZiGjmt7TdfZ95DyClj0f4KzAyhxZQbUvzW+JYrvBgL1sVKUtgRMp6VeEQzQmlWimHAvho7nmrU9z+1NewEX5PIOKuzP0GEDJ3a+5BLpEY+G6+t60S7A6jnvxjVu7JCjrIYtMWqljcwqGQ1VGqZGMgZAWb8G/AECHB9uu4lkC6GzwAdhFM5+KPEAhyoTbrIvESGMsLjATmxR+sUG6AhSydWi8cTDq79VBeWPi81UYYVUZPjzqotcvdgNMZMLVWUaHdgEg4OyBfrzPczamh0v3FBfp4SyXs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sM3oXVCZyWiBSW8eKz/kh/XuiJ6DDnaZmexEZNAhq7mlq6ggTS1Jnf0nRn?=
 =?iso-8859-1?Q?zcbGwpE3VaYkLn3cnU7GRpCbgOxJZz4LGsNUNFtRn3W+Bc8zB3L7u7wGzY?=
 =?iso-8859-1?Q?INdtYN7hCkAFrqdzNuqaO5zbzo7Vw6netZVKaJmvvcLavQ0DLqtDG+qrFU?=
 =?iso-8859-1?Q?usFmZPe/U4lmrK0Wa49CGrgkoosWauC/w+6YmJhFaVJIOVphi4Ut/yoW0K?=
 =?iso-8859-1?Q?C7UeF4rApUKCRdvn2ICGfOgj4DVMe/XSDcWaLaN5mJQS70NBOV3lxL5Tcl?=
 =?iso-8859-1?Q?W4Q55HDUSOFyfWtMYZ70cGVBTtsc/2lWtESyJIqDR5z/vBNVjIQTNQ8fGz?=
 =?iso-8859-1?Q?fAqHnNutHLVI/LF9TMUyJ3K8zrXL2+SzNFzXTOxtJMxFXz/pj42zqhFdqO?=
 =?iso-8859-1?Q?SA2k/Yb10g0zgrrnAT0GzJij7aNF4iIFff276gDj+U+FmtLBzh1QusHMHm?=
 =?iso-8859-1?Q?TN4OWSfStZxeaVyRFcDZznKNPUfHyjd5R8tqHLiR4hL1GpbMjUQhOLS1so?=
 =?iso-8859-1?Q?M5rTcJBHMwP6g3Jq7jBFOpAtlat+dzDx87ztZEGdpo4jWHEr+vxXt0uY5d?=
 =?iso-8859-1?Q?2aufDsRL7f5lT4prASJqtG6X+cYbeqzg7npDNyNJLFQsra7MVmgVtUIVyC?=
 =?iso-8859-1?Q?7Gt+WGGt0MF45nS5Zd6VvvelKHcNFf8iAVQgaeqRTTIbJzrvcZ/zPKCn10?=
 =?iso-8859-1?Q?PKEgySBsAKMUuRJD7uGVnLlf0UbmztAHdKqLJzOASJ7pyCK0YoIJ9ANxum?=
 =?iso-8859-1?Q?MnuGfj6hv0K71w1z8VpDcxOLTVYXxShCd7cucUUOrK45U5Pa+6h2Ap+X/z?=
 =?iso-8859-1?Q?dydevjuKGQJC4G1sT8pIJNC72fS4UhhdqWlqzj6x8EahEvffEh9/IrQlyw?=
 =?iso-8859-1?Q?C2VNUxZaHUZ7A2OmaCV/ueq6L1IYSNy2jOZeHlsygMmezThDW6njaNSoIO?=
 =?iso-8859-1?Q?LTz7XjdnZTN3nvcH4VLzZIaXL7B4qiaw+rUxFS6M3gNEz8NvLhjfgblEBa?=
 =?iso-8859-1?Q?HUyYaANA9Jzi43KG1NHhvC8WeAjJ8N4amdpZgf+mvJeH23XDAhkvpy2sOS?=
 =?iso-8859-1?Q?TjlOzOdgx50aa4v+yZrlRgC04mRKO1+t92MeJH1jSX8jnmHi6MgfTlJjrM?=
 =?iso-8859-1?Q?zDHJt9VdOG5uvZtcqxw1KHOtM+eWiMdz6zviQU8pNtE/HuBZBDHvEkZtsP?=
 =?iso-8859-1?Q?yFL4v3BoPrUBVZ39LSAkVLl+HvIADH8P92ZI3Q2WTwBLRdOe2xZoHYHsW6?=
 =?iso-8859-1?Q?a3BANvIb3OnsKLIZxtd/9djfd9YnXGFMTe8J/yB95KNle6Ve5lWLu4zt8p?=
 =?iso-8859-1?Q?Wu4/Dc7ETGpohDrWNb9ZnIu86pKX3ZR0xHnUTnliZVMALHB0pGVCGCTp2u?=
 =?iso-8859-1?Q?q5wjIttXMVbfNsmbsH1Y5sKRuYEnV6BRE699Y/oigwUAYuM7tRyAqYrcph?=
 =?iso-8859-1?Q?rlV67vNcVEaZzn9HG3aOOfoynEVVYangXHBjWNRjGqgOvgtGGyC1GToS0w?=
 =?iso-8859-1?Q?CFyOQ3mbVdOs47g3hHebV3FX2dAvUt6+fcEJw6KzRS4fSFHGM7+mhuEsg0?=
 =?iso-8859-1?Q?mN0WJgbuBdAngN1RItg8vWYDkUDiEB0OjqtnJuIXIMVm2AQFfGv+5AOQDY?=
 =?iso-8859-1?Q?tLocBxZ3xVCWvqS1mcAs6tT8a/f/y7pIOFBg11ofWUNwPx7g+LxkYTgIlw?=
 =?iso-8859-1?Q?pijFhvtOgNQHemrBl4nKVvVaSvD8E+9+cIR4puMY8VN3STtiN+4elkTIJu?=
 =?iso-8859-1?Q?EoAIZkPaAd8E/fcDOod0PU/ZCWz5Ck+gqMY3gebLtJpGxQ65fP8PdNnzkH?=
 =?iso-8859-1?Q?21MXRY2+Hw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FmyW9KDJJxF7ITse8fsx1EcSuP7ZUw944J/OVilOmWU8usCD5eTOSXLaNbWSOm1Elr6js1aF+4yJrLCug1NanGVMsF1zgQQJle2c4Rap4HC8sxuKQL/YSQll7bFPMfiUJ4X7mpiB7tKWYAa1B4yq1l/s0QMksAJsm8PQ5t+Cn9+wXHZIB09yQso2aRAX14Jbj+BSwhUQhX8n1dV2qROUdp0HkQblNH7RC8UkkRcZHieATM4kndH5ryTMZ5fgSO3y+j0I7s4z2f/wsOXs0wG6Q64xXeRf71ekQVyHynSbWwTZCnUgNWsn+e1wHuijS+cyvEH5Mant0N3J79E5H/y4ZQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad425e36-b836-4332-4024-08df0721e080
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:36:59.1680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFb8UVITVaOXVerBlyHx7mGytyT7DhdAST9ZbdZaFEj+4JOAYzh3mgtI+zpGCY4nvVv4JGcrSr+rsVR5wvBaFbMk5pXKLOS0s9sLETuoQ1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8654
Received-SPF: pass client-ip=40.107.75.122;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

The ASPEED Secure Boot Controller (SBC) model currently derives its=0A=
eMMC ABR (Alternate Boot Recovery) and secure boot enable bits from=0A=
fixed "emmc-abr"/"signing-settings" machine properties. The logic=0A=
that reflects these properties into R_STATUS is broken, so neither=0A=
bit can ever actually be reported as enabled, and for secure boot=0A=
this also leaves R_STATUS and R_QSR inconsistent with each other.=0A=
=0A=
This series replaces both properties with logic that derives the ABR=0A=
and secure boot state directly from the relevant OTP configuration=0A=
straps, matching how the real hardware determines these settings.=0A=
=0A=
Any feedback or suggestions are appreciated!=0A=
=0A=
Kane-Chen-AS (2):=0A=
  hw/misc/aspeed_sbc: Derive ABR state from OTP config straps=0A=
  hw/misc/aspeed_sbc: Derive secure boot state from OTP config straps=0A=
=0A=
 include/hw/misc/aspeed_sbc.h |  3 --=0A=
 hw/misc/aspeed_sbc.c         | 69 +++++++++++++++++++++++++++++-------=0A=
 2 files changed, 56 insertions(+), 16 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

