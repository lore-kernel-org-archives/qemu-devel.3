Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E111C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIHK-0006Bw-4v; Thu, 20 Jun 2024 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1sKIHI-0006Au-56; Thu, 20 Jun 2024 09:56:40 -0400
Received: from mail-mr2fra01on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:261c::71e]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1sKIHF-0000P0-N4; Thu, 20 Jun 2024 09:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3gIStZP6Z/FtHbjiBzwQITD1oD2f9vnDLHYoQcRafsKSmh3dRWtFYerMN43FSXD0G+p42yR3c6JR4/4xJUuVuyGDxrD9hiTdZdHXCMsPx1so7jbBvU+XSVDt7DEQoSYEWgP+NHgRB16WdbRDI7+YBZjybKt1HbyLk3qvWghXqkMGRGDYMvumPeCcJlN+e4xDGWbN9W9jQoaCYrWpjT2rGZFPe3q6eyDyf74QfAZwUGo7fy3loCwTrQj0OoWdSVhifVRIagSwqQEtboHmad5k7dIvDeL2Gv6qLt2ALR8gE5JJh3wSdD/dyCn6u3W2iRBmm/6wRFacTOckCYPZimUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1lZcl/gDUqkIcQwI/aZn9i4MJ7sM0Pm/6tfGqp2Yac=;
 b=LL9m2fKyQHIdLhBV0KDCtTJuPYjd+jMLiczwYolhlncZeT7oRGNR2EOuGhxlaugTw9B+b9+sFU/xHHq9xOGR/QeVekZMt8mGhuuPs0C/2dBLEaTE0fWQNZ6LXdTK+FRBgO+/p3sIh25OmZKs9CO82GsY5Uj494gQIwLMLZBTj3c5YeS9kIMkDfcPzw7qnq4vzVaxwWrb6XqRCnvlOI3eYITdmI4wJgIumQYRmfBH08vX6X1gawH7vg4NKTbz9LpAN/dg3aYC0RJGmlVYO6luvlILfxFplPaZlQanmU6NXCKw2DEOim6Ha6Dm3Nq1OAVf9339kda+QcRz/ptvAD/H9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1lZcl/gDUqkIcQwI/aZn9i4MJ7sM0Pm/6tfGqp2Yac=;
 b=I5LPCT+dL4LJ/gAIETw2xEssva/n9rEnzwAaOVbb9HsFBVNhEnuHckFtOGb0wWAwz7GqAx59KZwXaniKIld04wdNNHsNoedirgR9+U5rFy4ql3t5EtnfFmqOsubQgIfH3WTVFk6vGZ0nHZ5maUgw3nazcmYiBU0+K5dZqqEF+gDsaMBv/g5gfIPaIIsMUvH9hLXeBlK2IcUdV/0ArzdlIVyIOTwH0OaMc9p+y4C6hKf33/Ur/49MV4nL4DdcTTijVz7KtUWqvAf+xAOm74CeC6JU/Rl5tCaQ1kRw6pjwwPhBNNCGzMl9SiEh5XReSn6zFg6NnuRUr269X5c22mLI5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR1P264MB1780.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:56:29 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%3]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:56:29 +0000
Date: Thu, 20 Jun 2024 15:56:27 +0200
From: Florian Lugou <florian.lugou@provenrun.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
Message-ID: <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wkhh2lw2zz6gxvkw"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0433.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::13) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR1P264MB1780:EE_
X-MS-Office365-Filtering-Correlation-Id: 2549cfed-e59e-4bec-e56d-08dc9130c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?biV6cnkju0uklr0I8XQWx8Uk/6V7NdC/3My3pQyymtZtDoUworKWx3xHLO+u?=
 =?us-ascii?Q?58O5camrYG5+psmkuvfJ4GGjE2c21GJBHm6YYqzsQe0JrajzKFS67GurJCMI?=
 =?us-ascii?Q?tRwqckm3+ckn8eMdKmZAZavfH1WV/bb+2ynMKVOTy8nzhANlQfdQD1iqFIVI?=
 =?us-ascii?Q?ZvbKOYOTY6yTMwYCfBBPYsklqZlzq9PCUHXPosoFnALcBsdQ/sZVY4kqQqFk?=
 =?us-ascii?Q?BsATN7KZi/wsunX1FehTpu6Z16ThD5cwAj3iOFQjzPj+cIvtFhyx9o2Z0i4A?=
 =?us-ascii?Q?N3cqFUmM7wAs39Vq/dKq73AkKwPzHtk3VC6+VeA0ugkrMJsUgixdICoGwvlO?=
 =?us-ascii?Q?DKebH9ZD19Gc5jW4yRJ8/4bn0SMHdkDRzdBNDCYsItry3HizgKFn64xz0XMN?=
 =?us-ascii?Q?X4l35GWvvBznZC1foooWNhBfaKnsUAEMU4TfhEXkKEmujWDv+jnRpw44p4N3?=
 =?us-ascii?Q?lb9BG2qA2rP3JUDK4gTfQghPUu+yG7TpTVyu5aoUqGoB5SbOZhrYY8IUmkT5?=
 =?us-ascii?Q?aJMD0Ka9BVsapQA3B35t4uvNrIL2soNsXsNyiPCkwgzjlIL2E0pn/uliYP0e?=
 =?us-ascii?Q?R5cB6ad+5+EbqMI3FRVseqHsT9E2TJwcIMy6bfPtIygfKwwP0Qq96W5kyg0V?=
 =?us-ascii?Q?QeP9VoZYBfwRDrnLotf5/NtGRPvffVWU2UtxrVW/ybBvNIO/vk3Dd8s1tChi?=
 =?us-ascii?Q?s0Lvh/9Arwr07oMPKI8rFY0/wsmuRwmFjXNpeJ2jojCGy1Azo8oWjD7wiuU9?=
 =?us-ascii?Q?cVXR5VYC4h4ozy8xmZ66Tmzj603Xf1nxLQxVXvm0JMt5FRuKZue8s5c7TYp0?=
 =?us-ascii?Q?p3w/R1ap6+Vc6vwyi+3BCAJ2FQjqbWEyKk4bXXBG5WEs73czssxXe1dT5iMJ?=
 =?us-ascii?Q?kk5hMiJT0r50vckCtoIp8uP1jSY6md1Wz1vYwRwE6nJ3GtSRF0gd5MIQe3jI?=
 =?us-ascii?Q?bsYj41gW73oNnadyQzVMNJu6t47b976g3JafP1fOD8cyo+EhGPBFSI2Oj90v?=
 =?us-ascii?Q?kO8Oaw3TSrcY82JML01GaKsYzmGap60vTvBZgoULW1ce4MPQnI70dytg/spj?=
 =?us-ascii?Q?Cvf7IOxPJp5YvERstzsIDGH1iIpVxccIZWilJl1AXreyPc0UgF8J03rPFslZ?=
 =?us-ascii?Q?xcDa+6yGQSGEnO2qEkuvyYEt2XL9UAZw+RhbeD11fKyT1p2FMT5CcV+z5z1f?=
 =?us-ascii?Q?XdC4m46+EWGBu7U7euWSCjB0+IsWxAU63STq8Z5BLUWQ/MWBjJrQd+JPatUl?=
 =?us-ascii?Q?7W7jEm8YGV0770R+tuve71G1Tu6icHaKueLpWrc96DkR/coVD9nMuNz4TWSS?=
 =?us-ascii?Q?vFPXpnNOJKrtNciWEf41suCB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVwfG/rbS7BaBsuWPZkH9IzaYhTFeqQhe8g2rWnz6fvegbsOestMJqY1jy/y?=
 =?us-ascii?Q?OxLaX/JMFNC3jwA5v92ICnEEh8G36WZ8IGQgIsSaun+cPUHercE6UZW9X/mA?=
 =?us-ascii?Q?Sw6jKYREDll4EQpbL37OSRF4WZJ/gWG/WbScP+7M3tti1jV3Y6+3TBGDCKe1?=
 =?us-ascii?Q?e8olMRk0dKLWpX2CLsZeTo2bELdbZpq5/K730ol3XqaLQUDbPaL2oCQHXXra?=
 =?us-ascii?Q?kBP3hwODDLMT0FKKkcQJpXYn/Zkpse626xRO0QFmZHh/87mksz5jEgsiYqhN?=
 =?us-ascii?Q?BeBkuLCK4HFz2jjaCleFwA21nSqW6APB5JrP3bRot7e7ZXpDkX0BDKcHBujh?=
 =?us-ascii?Q?cS+q/X5QEmXp5jLBxHzbpZFnGorZqymoj5uB6ms2RoU4jd1lzCsiIDuowKtD?=
 =?us-ascii?Q?qX56oqwbnXLN5OlcA9At1gXxdx/Sr418Gn9m2QHr0rd6tcjUkW+aBHg84dER?=
 =?us-ascii?Q?9KZo3TAX6AjcdC67ZUR0CIsAfFu2dSgCmnzJlrMVfDMYiGRFPOc+EaHK1cbR?=
 =?us-ascii?Q?uLVioRhut/lKafDCQwtCSErT6QGlbC/xbBDkU5et9Klq38bufShOqAAWdDKk?=
 =?us-ascii?Q?y92TzqE69VyJ8jyjzvdBBE0vu0I1w0EcgVXbLF4eE/jbzlGsqg9JGmIPgT5L?=
 =?us-ascii?Q?7kwKQNVqcepYOuoy1LSAVlYwEOXTiDnD8dxUOorf0IJkkfDmT2QQyOH+jeVi?=
 =?us-ascii?Q?kKb1ukj7ob2S7ovd3j7EuwNC9/YWrVt444XB8WqaBxP+1sjy+xbuDLMskPug?=
 =?us-ascii?Q?i30KirlRlM3HvMNfIUutJmh8W7OwuAo4qT1BCc3tShyMvewQXFaX8BEyx83H?=
 =?us-ascii?Q?5osXAvgH/v7v/L/i5B2RIG5ANYmFrvF9c9Yaf/6kvG3xBdyg+gjaNYKMrZat?=
 =?us-ascii?Q?eqjck+oZyzVYE7qr1vrC2jpYHelT2gucNmPngFqsFKEFkYfxLnO6IeNhqa+2?=
 =?us-ascii?Q?jNhLgzcVCQVekU0APD77d/o5Kmzad0QuPCW4ceqBklAlP5IaGYkWCv5ZruLT?=
 =?us-ascii?Q?/Qxs8xQAJKWRHnXlwukWaROEsSrSxNM/swAdxniRRAfhN2ocgepBw2iZb3F3?=
 =?us-ascii?Q?ONMhZYYTqVvi0oI+z6Kxezy3M7NvGplQDy0FQMtFcvEkWj1pg0wTlymjK3h3?=
 =?us-ascii?Q?gfEApM0GdMdg/G0TR53imGQ60QAkdo8XpumWFJWV3mXXfXTdL+kq6/6KPhzg?=
 =?us-ascii?Q?2LLUXHNg2LuX089+Y8qiH6oxFCOVUXcpktJltk8/K4fAwiN7KVxyZ+fLeaho?=
 =?us-ascii?Q?qtM+AluAzo68Mrq6wTiZfsmobmN4m/c6WDA1tmhmoADOizvFwv6sRjY4yuhU?=
 =?us-ascii?Q?VSNv8/brtk2ik51wDp9rKL2YzP6XGVnbvwU0w7Ublp3Gv9oSF3IiiiyGZpDZ?=
 =?us-ascii?Q?x6ESu+bxIAw2xkdv8t23UizgD8TR3wpBaEz6NENwbs12UNsni1zr9dIYlk7B?=
 =?us-ascii?Q?s1q2ZX6k00Rbj9QiNAelB5Kz+wXweHiD3amtKqDEPnvQ0z7wjnmEsj8bCvu6?=
 =?us-ascii?Q?4EQu9/xF2yudd81xIDNiPm1O/0FdX9ugLoa1VjxpEBuPu5CbDv8MbgPVNuhU?=
 =?us-ascii?Q?FOgzFI6trCW9WGCDMkUsoS0/dwh0X/tpCODEEPBS0mM+uoy/cUAVFqzVCqlX?=
 =?us-ascii?Q?Eh3c38GguMnR5Si490to9qqVXyK6z7elcU296Yaesde2txw4+79SI/EX2spG?=
 =?us-ascii?Q?fzyg4A=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2549cfed-e59e-4bec-e56d-08dc9130c8c1
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:56:29.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo/hWAjE2tTYVOV/+GmW4R+maIKLLOZ/uxjQ5xCIHJq473Ivq8FsAM/qUqY5UaP2OEctTpSZQ7g+Blfemw1BVE/tsDkbODYjpYJZK/HPdmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1780
Received-SPF: pass client-ip=2a01:111:f403:261c::71e;
 envelope-from=florian.lugou@provenrun.com;
 helo=FRA01-MR2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--wkhh2lw2zz6gxvkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:43:17AM +0100, Peter Maydell wrote:
> On Sat, 15 Jun 2024 at 19:56, Florian Lugou <florian.lugou@provenrun.com>=
 wrote:
> >
> > CNTHCTL_EL2 based masking of timer interrupts was introduced in
> > f6fc36deef6abcee406211f3e2f11ff894b87fa4. This masking was however
> > effective no matter whether EL2 was enabled in the current security
> > state or not, contrary to arm specification.
> >
> > Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> > ---
> >  target/arm/helper.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index ce31957235..60e2344c68 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -2684,7 +2684,8 @@ static void gt_update_irq(ARMCPU *cpu, int timeri=
dx)
> >       * If bit CNTHCTL_EL2.CNT[VP]MASK is set, it overrides IMASK.
> >       * It is RES0 in Secure and NonSecure state.
> >       */
> > -    if ((ss =3D=3D ARMSS_Root || ss =3D=3D ARMSS_Realm) &&
> > +    if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
> > +        (ss =3D=3D ARMSS_Root || ss =3D=3D ARMSS_Realm) &&
>=20
> When the architecture says "is EL2 enabled in the current security state"
> it doesn't mean "is HCR_EL2.E2H set?", it means "is this either NonSecure=
/Realm
> or else is SCR_EL2.EEL2 set?". Compare the pseudocode EL2Enabled()
> and QEMU's arm_is_el2_enabled() and arm_is_el2_enabled_secstate() functio=
ns.
> This doesn't mean much in Root state, and for Realm state EL2 is always
> enabled (assuming it is implemented).
>=20
> For this timer check, we're doing I think the same thing as the
> pseudocode AArch64.CheckTimerConditions(), which does:
>=20
>   if (IsFeatureImplemented(FEAT_RME) && ss IN {SS_Root, SS_Realm} &&
>       CNTHCTL_EL2.CNTPMASK =3D=3D '1') then
>      imask =3D '1';
>=20
> so I'm inclined to say that our current implementation in QEMU is correct.

Indeed. I got confused with the specification, my apologies.

I am facing an issue with QEMU freezing waiting for a timer interrupt when
running with -icount shift=3D0,sleep=3Doff. Bissection has shown that the i=
ssue
appeared with f6fc36deef6abcee406211f3e2f11ff894b87fa4.

Further testing suggests that the issue may come from gt_recalc_timer. Call=
ing
gt_update_irq before timer_mod (as it was done before f6fc36deef6a) rather =
than
at the end of the function solves the issue. Is it possible that timer_mod
relies on cpu->gt_timer_outputs, which has not been modified at this point =
to
reflect the timer triggering?

>=20
> >          ((timeridx =3D=3D GTIMER_VIRT && (cnthctl & R_CNTHCTL_CNTVMASK=
_MASK)) ||
> >           (timeridx =3D=3D GTIMER_PHYS && (cnthctl & R_CNTHCTL_CNTPMASK=
_MASK)))) {
> >          irqstate =3D 0;
> > --
>=20
> thanks
> -- PMM

Best,

--=20
Florian

--wkhh2lw2zz6gxvkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEi2flTDU77YujoiPS7SlcI6rHG90FAmZ0NQoACgkQ7SlcI6rH
G92QrQgAwF/soEXZaZV14MtXJuX4DxIe+fN9+lEnuPDgH0I+/DJLkIomzqHGdO1f
a8QqPzMM4rX5FxRrMAMbgtCV7U2WgisWbVhAt3AJ7fNyjl1zUNJ/Uq07Oj9tj3RW
3/4qqfRvcW8160BbpjWzI8xaQ/k35gNsuSdoXergTdOPZ7ZgsiwgErxKUkW1iGjr
ygqsukdabgdX6Hkt3mfHsbDj8+ozpIGfbUvsRlpRZh1wJh6vcsGR6j5Cly05zcrt
F2hrVvF6C+or1APuHcISNy0HdayhIfCWr/yIcjTiFz1/ar/z1nhoGe/bVn8SAiv5
uC1J1Sk35NBFJGLLpuY4DI6CgsN52Q==
=VwW9
-----END PGP SIGNATURE-----

--wkhh2lw2zz6gxvkw--

