Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7245BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whSjk-0001dn-W0; Wed, 08 Jul 2026 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandr.mikhalitsyn@futurfusion.io>)
 id 1whSji-0001df-5g
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:54:50 -0400
Received: from mail-westusazon11022080.outbound.protection.outlook.com
 ([52.101.43.80] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandr.mikhalitsyn@futurfusion.io>)
 id 1whSjf-0002hN-JL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 09:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unRNpfYLsm0eLRqgBta79TV+jvKSZecLjrP7LgfGn993kN/fwiLEK9YIZKINJNODeaUs4AwuWMCTn1WmNxbJzDnilc/d/+odjd7uditF7DM4i8b4ZuobVHN92UveOhHEtiLhPz+Rv2ieOla3R2nStuPLphiYoUnYh5fhohm7+WT9q47QiI6Nbdx1ezlxBW0KgC8SzQkL3n2P9JHrwcX+tFAv+nvwaAAQz/D6PzCjhnbGCCT0v3pdCT8VHojMplcdvi+wvw1PFrcKDD83lkHGUSOdncxe2GfSzbuMZD/8vsnSmXszSzBZm+ODmPzZpDnEhX5Vt6HvjuS8esQ81jo/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R16MLWdGWKdKq3nSekX8QBcOdFWxnQ/nyxcOzgVaRFw=;
 b=IVu2+/whH4RgqtC0VnyAwKUfgbst5ASPBrcAvTWPgFRM7KH2KbbeCeoRt21PMGXp9e3VN0NGTFoSJLltiYC/yRqeliFj8nMmmHrPAvhwrhNzv2OPMfbWB0q55og5LNXhECx4imaKzdQF2tBNbuw1wEhJ1wPx1XnljYRLTj6lbAZBpvTqmqdO5dgnXZc7rbR8Qk7D01Uh7XRmZJwTLsSIstcMWMUlDN5HfpGMX+RyuP74I2h9ddVwugy3Ss/JySkPZMkxb+uaX0UI01uSPOvoA9EDxcLdu3c8Tliv9b/dgLMp2NvYBIz1C1tbUTmJRC75ljS/wpkGdJJY9DfXZjCFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=futurfusion.io; dmarc=pass action=none
 header.from=futurfusion.io; dkim=pass header.d=futurfusion.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=futurfusion.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R16MLWdGWKdKq3nSekX8QBcOdFWxnQ/nyxcOzgVaRFw=;
 b=IH3npzHbCGJ+9yFA4l2TLY9qHuLo6HEoHkABIX1Ts0i4BMqGbDZwjvZ2NeogSRNa916uU31cQowGqVr8RNc0CofYZA95YsKJ9fSOiKCopRqw7+2+BCHwymxvdX/CDjchs3FGkdsivs/u3gIRXzKio/efKV/iZqrwsy3TEMfo7hj+Y/p5U/Rxc4EaTtJv69gGOiHOXXAPPz0uneBZFU5VWfOiEQNvN50k9VVrPIkTjbZVyzONiC2D9iO/kS5G9rKrHYpMYhKTKM4LVav62E0R3U2Ci+RCJEama/a+/0oxStV64KD5gG6eCyNOxpFGqWN3cHy6n7PqJ6oETQkw/rXDrA==
Received: from CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:49:37 +0000
Received: from CH3PR12MB8481.namprd12.prod.outlook.com
 ([fe80::62f6:fea6:9c81:a20e]) by CH3PR12MB8481.namprd12.prod.outlook.com
 ([fe80::62f6:fea6:9c81:a20e%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 13:49:36 +0000
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn
Thread-Topic: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn
Thread-Index: AQHdDuBfrSNDzm8xWUaQW016EHjFA7Zjo0tv
Date: Wed, 8 Jul 2026 13:49:36 +0000
Message-ID: <CH3PR12MB8481537BF413F60CDF0DA5228EFF2@CH3PR12MB8481.namprd12.prod.outlook.com>
References: <20260708134744.169452-1-alexander@mihalicyn.com>
In-Reply-To: <20260708134744.169452-1-alexander@mihalicyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=futurfusion.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8481:EE_|CH3PR12MB8210:EE_
x-ms-office365-filtering-correlation-id: 0a5a1f4c-bece-46cf-94a6-08dedcf7bfe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|4133799003|13003099007|8096899003|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: TpSziA2U9TPkjNmuVXFm/DKONYei+BkzO+Kcs1zB9zkv3A+jyZrj27Keknyl1c5xcwurSr0Yhl1+/k1RIWaIza4SAHf7e4LpEauRQbGcbFcnAATBuLQ9VrJXAcJqws/1tmYD79WgNZ5bRvhtibl3GTAazlqMZx/tQuSjZ/k0fE3HCWw9B9QmfkfH7wb86c4B4fHuY0DCSiaaTIxKG6S1Mny236Qa/sqGegdVsEljrDqcJujAXwCyG6KL5HRTRQe8Y6KbfE9SWTmRonlvphPJ6bd/mDE3DvEcygdXtAss7ygY6XfgXoWffCVUpd5/indbBlt84MEY1OKWUBqucAu76pHu0OXeQx0R+jfJZci0UHyUC6/vWeGLOMleZS8QsN8Tz9meqW9ee4F1EVtIDzsnjurMI7IP8UU4fnXKV3loqsnxMxTq8WR3c3lsiblzek8a5me0XZJqlmnbING5OEFLzhgw1l53Fbdjk7r2tuPyGxGB/fnh+MWhkMrvYUdueWeJtfN39wrMlh/TnMwCn8ug04IaL71Aj6WsEy2dlKKOBgg7cX0WelCyiU/3SNBkqKc8J4UpDSA1c4wv+gOvOXd+vxRqOmJ2gnSHn0pZSq/xP0jw2mEDzU7+MsowClWuaeWLd40EwSp3CRITYd7NXcJ6DkXX+0gpGXO/e66FzJuneBb1HW1KRF/atCuuxZTmkYXGjNzTgJ8gh2iUKjDQwjA1Vq/7b38bLOP8WbwA4W20/Ok=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(4133799003)(13003099007)(8096899003)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2zJ/o+5aWzhLocDERn7SpWcHm/SY7rqcwQzlWaFEnJ3zdvlp6L0L437Phv?=
 =?iso-8859-1?Q?onmFhy9apLQadFQVgk/kMGwZ75MAWKi7fL1c9L+7DTtZ5gjAuSSdZLmEum?=
 =?iso-8859-1?Q?y7bDYsQLlwXCLaJZ6agfq1lCRLqFscSeHEgKJaM+IZf7tKPg+AAD+yhvFg?=
 =?iso-8859-1?Q?ifoDKxqB9T2ivzkmRM6LldyVtciSN3TIUszZlQU7iOpkm9Mxt6euKeQeK2?=
 =?iso-8859-1?Q?DLPHS5ZLIOzpnj7xnBVxVnAZNxZKsQpqaY8PYE0Ny7abPnTQ/A7eAWCpLo?=
 =?iso-8859-1?Q?3XR4OIEsaJsUhiGri9WdvnbuC9NV8dUkasiSjGgO5ck+tl6pVUZpOjIeTx?=
 =?iso-8859-1?Q?vHshx0dKwNP1MflHz0xHk7kAwnzXwgPQ/wRNNQb8/6yB5yIvypDLEvTHd8?=
 =?iso-8859-1?Q?2ITsvX401BKO497yJqyPmISCRZ58w4VWU5QMERp+o9RNWksWex1djG81B9?=
 =?iso-8859-1?Q?DqRnwU0RweKv512Q+VtiW1eA0XFujOpm52Ngr8DvIxm04mXArxbbQrKMBi?=
 =?iso-8859-1?Q?oak7QPHBgMjyD55TRw3rdpRW2CU14hGCACrsTpdStiKSiekN8TPD5rTKyJ?=
 =?iso-8859-1?Q?N9n/iWYZummPj1J/jgtC5d2UxW1AMMRc5y3M/ohayOIa6EIVF8lz/WPjuf?=
 =?iso-8859-1?Q?4lw/aEf5llOCuKoYwknI40eJRl6R4Fmny4aKt+kueLtgT0N0nqVFCnOry/?=
 =?iso-8859-1?Q?T3MkvwCaQ6H4KtzV/err3z+oo2nBVnt/w5XsCbD6/52wp2Quweoksc2+4W?=
 =?iso-8859-1?Q?P3WIcBF4ccQfoLgpBeghXzOu09VD7X/FSZU6spfOcmOP0ik9wBhAzH3Lrc?=
 =?iso-8859-1?Q?3U6KdC9JACX3hOP6fnsCtb+Yixe4idquo9UEjSAR6Dpsz9iqnThdet9JgG?=
 =?iso-8859-1?Q?j7RV1Mu4WT2B/NZASJpKO/bbWBzRGgf/Kf1ARxvDfybA8VDWxlT5yfS5SU?=
 =?iso-8859-1?Q?hlsNQlgBHYasnSp0g7tLaxfNViGFmMKdvHdXtm8NC5npviRA7BgH/EAzm1?=
 =?iso-8859-1?Q?EcIZoCbOUL+LC/duyhlM6LDz0bUhT6gPBecmdL8Ajd5Z0PEzyqTpre4+sG?=
 =?iso-8859-1?Q?2aaOY7iK7kJh1zk16J5iJCzX79Pb9Wi13NBbnRZPLevR+g9hep30u8vF8q?=
 =?iso-8859-1?Q?OM+eF7La8ZS0IbfuE+lCNzzhbMXzdhENCUN3c6DhhI/Qa2QRSMaTmwNDhp?=
 =?iso-8859-1?Q?qguao+qfIvwZDDqlbBRw0GyFTBJ7bmvol3jrolodN7kBomOmwPxUthshed?=
 =?iso-8859-1?Q?FAGlIatj0H2+m7aTzvZJCO/y2HaWissih91u6lAC3smrE8BLWHRp+ZSt85?=
 =?iso-8859-1?Q?O25a5r4VM137ihsA2yAVlcrmwlWk1qnxEPzNqivkmOPMogQfC2365M2vSI?=
 =?iso-8859-1?Q?v9spIMRNNTjFqiJV85KPjuolLDsHe9f2GoA2YETYsT2Ue7pau7rEsMjsaO?=
 =?iso-8859-1?Q?5hE14HqSqHB/S2rjwWaLvn3e8fimREQvMOjzBOfeJpNHn1csgrSP0VLOZM?=
 =?iso-8859-1?Q?uLGOZy5qds49rHEsZvL5zDDJbxEfoKDOnvkcosuTLPLZdAtNoxtnJpWlK9?=
 =?iso-8859-1?Q?2uS9M6UQ6UtLyvCyAqLgOsuBMuNk1BR12LPjtpMGZzNcvYh7gGaLqbTAnW?=
 =?iso-8859-1?Q?U8xsmhfV8Ao4ZKkj+20djNh+O15xbtHuq/Qw1AFO5i8Ypk6NRVgrw7beEt?=
 =?iso-8859-1?Q?Fld+Wz1DSyTNpuF+MdsS+23yvEsYXxtx+REElnDOENGdW1ATKYCEa4wsVx?=
 =?iso-8859-1?Q?aDi1/NoPTFmJTS42Fa2miOTDsGSqVqoAwBryE3xTTPwEpSOaux1F94Q97y?=
 =?iso-8859-1?Q?7DskFfD1abiFAhNot9lked+n7LqbCs1tOdjVdyEq2K+Eo9R946MEdn26Mv?=
 =?iso-8859-1?Q?oG?=
x-ms-exchange-antispam-messagedata-1: rn6BxmZ2++//zHpoC0NFL9fXrbboItAFnW8=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8481537BF413F60CDF0DA5228EFF2CH3PR12MB8481namp_"
MIME-Version: 1.0
X-OriginatorOrg: futurfusion.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5a1f4c-bece-46cf-94a6-08dedcf7bfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 13:49:36.7715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9a572ee-9e57-46ea-b37b-b020adfd669a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al0fOwyc/tiYeDEYJdXrX+UUCEruGuPGtm1R7L6QOs5ADi6GscwJ/0rZU5pyCdDxl5NRlsb+vEZtsMjo1aq5i1wLxe8Ov8/qGng+zKF58LSPC+ecOVmQbWdkH++qh+A1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
Received-SPF: pass client-ip=52.101.43.80;
 envelope-from=aleksandr.mikhalitsyn@futurfusion.io;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--_000_CH3PR12MB8481537BF413F60CDF0DA5228EFF2CH3PR12MB8481namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ACKed from aleksandr.mikhalitsyn@futurfusion.io


________________________________
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Sent: Wednesday, July 8, 2026 15:47
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>; Aleksandr Mikhalitsyn =
<aleksandr.mikhalitsyn@futurfusion.io>; Alex Benn=E9e <alex.bennee@linaro.o=
rg>
Subject: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

I use my company's email to sign-off patches, but send them from my
personal email cause it's Gmail hosted and works much better than Outlook.

It causes some misunderstanding and inconvenience for maintainers sometimes=
 [1].
So I would like to add this email mapping to clear out all possible confusi=
on here.

Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2=
-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 .mailmap              | 1 +
 contrib/gitdm/aliases | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 593b6c2c534..0663cd7bd0e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -122,6 +122,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilne=
tz.de>
 Song Gao <17746591750@163.com> <gaosong@loongson.cn>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@fut=
urfusion.io>

 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index e26b00a71d7..f838768792a 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -33,6 +33,7 @@ malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru

 # canonical emails
 liq3ea@163.com liq3ea@gmail.com
+aleksandr.mikhalitsyn@futurfusion.io alexander@mihalicyn.com

 # some broken DCO tags
 yuval.shaia.ml.gmail.com yuval.shaia.ml@gmail.com
--
2.47.3


--_000_CH3PR12MB8481537BF413F60CDF0DA5228EFF2CH3PR12MB8481namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ACKed from aleksandr.mikhalitsyn@futurfusion.io</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Alexander Mikhalitsyn &lt;alexander@mihalicyn.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, July 8, 2026 15:47<br>
<b>To:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;Alexander Mikhalitsyn &lt;alexander@mihalicyn.com&gt;; Alek=
sandr Mikhalitsyn &lt;aleksandr.mikhalitsyn@futurfusion.io&gt;; Alex Benn=
=E9e &lt;alex.bennee@linaro.org&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] mailmap: add email mapping for Alexander Mikha=
litsyn</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">From: Alexander Mikhalitsyn &lt;aleksandr.m=
ikhalitsyn@futurfusion.io&gt;<br>
<br>
I use my company's email to sign-off patches, but send them from my<br>
personal email cause it's Gmail hosted and works much better than Outlook.<=
br>
<br>
It causes some misunderstanding and inconvenience for maintainers sometimes=
 [1].<br>
So I would like to add this email mapping to clear out all possible confusi=
on here.<br>
<br>
Link: <a href=3D"https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4w=
ucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com/" id=3D"OWAc453b9b3-9b40-b459-7=
bc0-013b84db9465" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XB=
Tby4zqf6CTA@mail.gmail.com/</a>&nbsp;[1]<br>
Signed-off-by: Alexander Mikhalitsyn &lt;aleksandr.mikhalitsyn@futurfusion.=
io&gt;<br>
---<br>
&nbsp;.mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;contrib/gitdm/aliases | 1 +<br>
&nbsp;2 files changed, 2 insertions(+)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 593b6c2c534..0663cd7bd0e 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -122,6 +122,7 @@ Stefan Weil &lt;sw@weilnetz.de&gt; Stefan Weil &lt;stef=
an@weilnetz.de&gt;<br>
&nbsp;Song Gao &lt;17746591750@163.com&gt; &lt;gaosong@loongson.cn&gt;<br>
&nbsp;Taylor Simpson &lt;ltaylorsimpson@gmail.com&gt; &lt;tsimpson@quicinc.=
com&gt;<br>
&nbsp;Yongbok Kim &lt;yongbok.kim@mips.com&gt; &lt;yongbok.kim@imgtec.com&g=
t;<br>
+Alexander Mikhalitsyn &lt;alexander@mihalicyn.com&gt; &lt;aleksandr.mikhal=
itsyn@futurfusion.io&gt;<br>
&nbsp;<br>
&nbsp;# Also list preferred name forms where people have changed their<br>
&nbsp;# git author config, or had utf8/latin1 encoding issues.<br>
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases<br>
index e26b00a71d7..f838768792a 100644<br>
--- a/contrib/gitdm/aliases<br>
+++ b/contrib/gitdm/aliases<br>
@@ -33,6 +33,7 @@ malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru=
<br>
&nbsp;<br>
&nbsp;# canonical emails<br>
&nbsp;liq3ea@163.com liq3ea@gmail.com<br>
+aleksandr.mikhalitsyn@futurfusion.io alexander@mihalicyn.com<br>
&nbsp;<br>
&nbsp;# some broken DCO tags<br>
&nbsp;yuval.shaia.ml.gmail.com yuval.shaia.ml@gmail.com<br>
--<br>
2.47.3<br>
<br>
</div>
</body>
</html>

--_000_CH3PR12MB8481537BF413F60CDF0DA5228EFF2CH3PR12MB8481namp_--

