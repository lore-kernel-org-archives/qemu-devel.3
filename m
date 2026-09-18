Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EFAC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SU3-0006he-Lj; Fri, 18 Sep 2026 02:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7STw-0006h0-MU; Fri, 18 Sep 2026 02:54:02 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7STu-0002rT-Pg; Fri, 18 Sep 2026 02:54:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDePmqlnV6gITbZVa/U+WDxZW/Vb5AAPwrOpJqQW7rzlLLe6o+B7hI1Esd8ZLwtHdjJn7qVBSDQPGvLrMvDeu5itwGIzza6uV4w0z3pEfy0nelt4RpdpA8m3yTJ4UdhqeaonYKBpk7QWSkUD7wU4A+jSSAicSuPY85roKa//fvgxQVd6h36t36z7+yOeA0kR4+oHbj79p5/1f5bGPW36zstQN6yy02HYvpSGpR11XUMVMNoMUR/Qllccd/dyrST+E18BMbQBXkQ/+HN+7f5jV5gkioXoI9QpeDauuHUNkqM+DRDWI2FcWkI/F3ZdNXH+S9NcQ9CErMl/m17YseJjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azWTqEL5Q5XxCSGSpFVD101q2sY8UHWjZByPF/A4Zk4=;
 b=cZL+8IraYiYYnPb0rpdVobursD5iVgGYcr1YU4Gu+5fYRMoLXpMdlkOEFXSC4eNZWFkc+6WAmKQ2g8msIoFoCVoeBiENifbPs5Ido5Rud9PJh/2wINxquV8e73toxuNOW5Aemm1gERRAldr4cQlKN0XuJrHsOFQrwVzEY4AYieBP69O0JoEGaLsQ/9ECkT2ARj2Ysw39iFRAN5HfSaJfly9Zk8Hka8rj6OgfKQlK56CnQ9E4Ld6XwFO+fh1UrwjOrg5VlrGG27ifVI4PxVWIwQnkFFzZCvlG0hXSw7dsq7JDJ5NcZMbC8uUsO0WmB8XaqpeaMKQL+DDxb09BsfC/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azWTqEL5Q5XxCSGSpFVD101q2sY8UHWjZByPF/A4Zk4=;
 b=BkDC1o04JlPOwD5nSLnrKsD6TP8Im8spxBiSq6eAktwTQl+Z5bbeJqnNITztZnTK+PoyMIpW/vsa2YFGQVHR013XD8AtfGOh+TNEHulFnRAe6liw1kA4mpUnXjOKRLIm2PH4Foc1g3K7NCCo0OUyQmaTdsXAH9ulADbinVnk9VPpUhWT0LanYc7H+9nVOirjd2yNWvL7qPSz5T/p5TxaScFVuVLnUZG9c6ZBjBR8Y1xoMUK1G65URMGWFAifsMJiKz4ls/4qu/lLpgX/S09IILuxS8ebu72bSqTUh/1QOl0LFJGwWkoTZTc24G0nXQdqHTWrtxh2n0VvcFl2+c5nEw==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by SEZPR06MB8814.apcprd06.prod.outlook.com (2603:1096:101:33d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:53:48 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:53:48 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 0/3] hw/misc/aspeed_sbc: Fix ABR and secure boot state
 reporting
Thread-Topic: [PATCH v2 0/3] hw/misc/aspeed_sbc: Fix ABR and secure boot state
 reporting
Thread-Index: AQHdRzp0Q4coc0LIb0yF9y/CPeMsYA==
Date: Fri, 18 Sep 2026 06:53:47 +0000
Message-ID: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|SEZPR06MB8814:EE_
x-ms-office365-filtering-correlation-id: 6bcb2d14-54f4-4f33-30ec-08df15519709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: HGyiiKRqdsCofwARIHSTvaNtZdveZI8d7Um10tl6Iyl7v5hBgQ3wZPomxpTd+vCEnIYxFOmdrIDWfGzU/YTRcQnZ23p9bDL+MXrNP1HLuSe+W8y70o6i4koHtPdIzycz2Rbv5+z571VUlRm2kXbBu14LWS7Kgk5bTkJ/FTvlLeEFL73HQWc8AWAYFNmtnQny/fJOlCKQldANeJq+IPUvAU4CalIIFA8EGrVXXz83GOsj0tW7P4HfZb+eWxZRI9NCZMk2QTKfBEgVHVhVGjgeVj4cJOk0ZO1rMGnREpzJVYEmokni0Ng8TTTMQyEQVYgOkzMtnGT3uTb/4N/blAECiiKckOHCxXygdFZt2Efjp0CTgUBfGnl3XZnLzSTH1EuDr4+ejKgiHaqa8m09yr+6XUIgugWK90tKFa1IseFuqaz+XlaweApc0c41cJa41Lf8ABEKj9VsyI/e0MMIxPF76ApPMN+cHJ/Up7XIMBFcQp6FB4fvm9LxXakCzTl1hsVFRYzL8OmoOZmm/mL3rG1G8KYpLQVZutLmRkzhQ6HFPvSJcjqpmjRIdyViJcW3Nt9iun4t3iPKlL56Yyouqzg90l8LXvvegVktuCtArOG8QfhG/CJ0ODh799OjiRIDka0Un+hWqUZ8Sj0kNDtDgNvGrYhk2Mt3hCnoy9li9q+ONZTrCWY/rMO4gphFCduVPGeS64s/q/jrY+NBXcP6y7yfrIqccFdXGvWRU5TCP7IO3Ew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kWOq8nsbqP0fbgJq1jmDMNx1VP3S1UGpg6J/NZSDVo9+DjxsbSyHCwSJ+U?=
 =?iso-8859-1?Q?IPe2zfTTZmDZla4j+LGfY0ISz+cD4iUKZal3GEy2JvzIIBBs/qfST1hJW6?=
 =?iso-8859-1?Q?D0s0Nb5b2kbFnA21LlOlx9vdcwP4RE0WJ/D6hSXU48bUzXKMHMceQYt7kC?=
 =?iso-8859-1?Q?aJ4XgU6L4zOZn65h4LiRMowE7I3fyznVR7GTuqNwT51QJ+xoGEITYn+Dz4?=
 =?iso-8859-1?Q?DrvoWlFrCI9tsrxucX4sbKyJiV5SCJcSQAycP8nTG654SYiwqtDmL+8Rwf?=
 =?iso-8859-1?Q?XoR43sd0FZhmgMFOZd0HB06+/MWbxraybWPm9st6oG85y8aGMgVNdr4yQ+?=
 =?iso-8859-1?Q?yto60lexaCXiGyJDmP2D8zULwll2xOHP3kOHVF2urF7koKXu1a+U0htHXH?=
 =?iso-8859-1?Q?FeIMsNvM1EdmgnIbK3F9uvPtiWG1OXYuIP4mebRGFpQbvP0TqFeHLKDe74?=
 =?iso-8859-1?Q?gUV87tXZ+XHZ2qsswdp/3U/dN+OENAmP9JIkSE42Kq5QBvDIsOlXRwXioN?=
 =?iso-8859-1?Q?MqhVYo1d8gIJUukZruo2bxNyx8THZp2pumJJq24qvRw35ttnN4+yQmCpUP?=
 =?iso-8859-1?Q?4qq3ofKz9rX3OUW70KCs0Wg9RvtPx45UuKdSyFOx5X5CynFDVV2i03FUXQ?=
 =?iso-8859-1?Q?H5pROZe5iiWgkvcLYHxmVbRIXEJiCOobcZ4IG4wIM7lzqw5dqx/OvjuJF0?=
 =?iso-8859-1?Q?gE2WZlkVFKh3F6aCW96fFYTiVpEMX+pD9FbUPWZsryX/HByaSbo5yD3RJl?=
 =?iso-8859-1?Q?PxUwfaXuFkJMY0mGptcdG/m+v36Bc7/sCY7mv4iyk5QnOIkFyeggQp/0iP?=
 =?iso-8859-1?Q?HAKbzu2tEtF001ztuRnaESlvNp3P/zvScVO93kNJnUu31VGs0qBSfj0iaA?=
 =?iso-8859-1?Q?Wp0oeZg6dKT7H1KFsuERKdGm2oC+Ra1ZMKXagxg84hwPzb+F/2AFLmIuot?=
 =?iso-8859-1?Q?+973p2W6gUn6CuwktApRDKLd15DZjvzR6Vpypn7T8pTpo7RnZ16Qonx4Kp?=
 =?iso-8859-1?Q?bp3uiUHCCQobli5htw4BP1Fq2GTdTZaTYGCjhAmzYG08cp+DGuOy/bodqh?=
 =?iso-8859-1?Q?x1PqKF6LvMt5dW/gOdicC0+u/T8Z9LBtNSgKnEDxi22mxiKtQc//7ilm4/?=
 =?iso-8859-1?Q?94+6hZwD8EJ2gEpnzco4VrPobmtiYfXJKidZCS4iJ0llBXp18sv7FX/10N?=
 =?iso-8859-1?Q?dg0WnnSctUojxhqN9eNdCqmv23N/GlwbqwASLRrnRZ5e/+hrRzPlbYHhAk?=
 =?iso-8859-1?Q?gMmERLs+rkYy74ceacOCVDb4sxZBazhK1niJ9gn27rfJ1cnL7oYSBi9Xv/?=
 =?iso-8859-1?Q?VRYU0mwKEe9D2Y0d1Lpd+9WXvNGGbiT+KDGR5jlQQ09dD8qU+lsUPyvdo/?=
 =?iso-8859-1?Q?3vtf9n0QPWFqyJex2FpwjmTIt7JRzotNqTuG+iRhwyPbCuBFVaFmlgdFn8?=
 =?iso-8859-1?Q?FeIqFMwIQFW0OC8VHEr+mM4hZADEPCDjPvSPnQk4UpoVC9T+/HIrGsV8dJ?=
 =?iso-8859-1?Q?k0llqDgt8j7SRvs6jFgRUteqFsTXbECubRrvk+J8GHYDLaPnlri34HfeV0?=
 =?iso-8859-1?Q?mCXhdRIbjmIr+ZoJ+UrD143yTwSFeFJwTXUDva2hSPcQAd2MIxP2lUmHgz?=
 =?iso-8859-1?Q?1LN2bVeJJppYo3v9i3tzsH6DwD/DRruLg+/jXHiYx6iXBRMJJFxyqPx3xn?=
 =?iso-8859-1?Q?DswG/misTKVLgLqcbaiAF3R5lG482G83paFVp97CIcTNrPJYkadh8+mpph?=
 =?iso-8859-1?Q?WY4+dLMLFPEgujAci5q+yjt3zVuyrl1OKbLsi4ZzizCh+7AqGOyHBtQwjd?=
 =?iso-8859-1?Q?+DelO/9C1g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XK8EDiE+TAv1G4RUxBbV9xkBZuxdZMkQESpBi4qVQ9qPy8tQniC3f7+pIcXR/8DyahkwIiLN9pUy4hRp0MlsAi/Hjm2Z0m+w70Kz2WSo5wbmQyMCUznO53pjqaEifusleUSz9X5i1oEvMpp6Gcnkoofk3CseXcaqiwpQY74Q3qjF3pIL5hb+96ADMQqyOWBByOSef4TvF4Q/ph4Z17BT4tun/KlMjik+aOdKu6lnDr0GmiyU6WbVvNcJINkhroWUTjphtne4OpRaTSAJn0b2NpwGqxum24L6DrTCJCFoA2bgRenH26QYhpQCm5UwuPGs6LmOH7W3rrTm8ELD5MKSdw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcb2d14-54f4-4f33-30ec-08df15519709
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:53:48.0240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQb9EJGfuc5y1l/7QfsvhKTs7GRa87CRdlze10Jc83rd+3jQoDRXsTs7uBIomYgo7Dj/WFg6+cJjg/O+elgnCSbYabvLvbnIzoah+j/8nE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8814
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

The ABR and secure boot states are currently controlled by the=0A=
"emmc-abr" and "signing-settings" machine properties.=0A=
=0A=
On real hardware, these states are determined by the OTP configuration=0A=
and reflected in the SBC status registers. This series updates the=0A=
model to derive the ABR and secure boot states from OTP instead, and=0A=
removes the corresponding machine properties.=0A=
=0A=
The series also consolidates the OTP layout definitions and adds=0A=
helpers for reading OTP configuration and strap settings.=0A=
=0A=
Any feedback or suggestions are appreciated!=0A=
=0A=
Kane=0A=
---=0A=
=0A=
ChangeLog=0A=
---------=0A=
v2:=0A=
- Move OTP layout definitions to aspeed_otp.h=0A=
- Add helpers for reading OTP configuration and strap settings=0A=
- Derive ABR and secure boot states using the new OTP helpers=0A=
=0A=
v1:=0A=
- Initial version=0A=
=0A=
---=0A=
=0A=
Kane-Chen-AS (3):=0A=
  hw/nvram/aspeed_otp, hw/misc/aspeed_sbc: Consolidate OTP layout=0A=
    definitions=0A=
  hw/misc/aspeed_sbc: Derive ABR state from OTP config straps=0A=
  hw/misc/aspeed_sbc: Derive secure boot state from OTP config=0A=
=0A=
 include/hw/misc/aspeed_sbc.h  |  3 --=0A=
 include/hw/nvram/aspeed_otp.h | 32 ++++++++++++=0A=
 hw/misc/aspeed_sbc.c          | 97 +++++++++++++++++------------------=0A=
 hw/nvram/aspeed_otp.c         | 63 +++++++++++++++++++++++=0A=
 4 files changed, 143 insertions(+), 52 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

