Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F2D0E6E0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pZh-0001dV-Jf; Mon, 21 Oct 2024 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pZg-0001d0-9Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:23:44 -0400
Received: from mail-me3aus01olkn2082f.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82f]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pZe-0000Z6-Pg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLYtAabdbqU7VhKl/o/UMZyG8VjNotADt1S7KLzTFWJoaXYn4PL7J4YpTZg6UGJjcVcFUuLu5Ss+LX7sXSJ1XrbcvwO2KVUyGiotjh3qkDV5jBvsb35d9ELHBfl12dNMmirUKEGzWqJKxpbUXejejFSq8uGqsAc/AuVwZdOCtGZ1QiAq4jK8X53ua1kIMKWwsRvwbsSjt0pJQJOkBGdPm+qOX6l6ifVSjicncLccM22svXWCvOdei/hg9w7VcEHUXP+N6Sek1ZXBF3Ase0Un+qVPhjDOiye8PncVL++4CI1UsuiOR8chVppH4vaZyDjTebGwwJ9YPO/CNzoqUhr3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiyOUQlLstM4OULquOsPAE+gWW9Z/lXo5woUbll+vmk=;
 b=ozpTT9sG1zop4l8rq+BSCbWH6qUnq4468mBUcC3NJJDNGFmKB7ZTzpDNwUTRw8pWqBlrj/O8HaGN9e0F4fCqrRvT288TMK1BUxXu/z1+XukiTuW28+4NGm+1BS1goKwbRf6/radq5TFNAdUerNClABcCLU4L5UhjnojewLRzRBDWgvLGqwdsjKLx83NqzsE4Aw/4EDi7uT0rqrVk0M24EElDCYfYA526gxuYi15fefXy3FbL/uEwGs75LzWYaLoifOQrgqeGR7cvIAp85pkggS6hvj7SfxjaPV9HlmcFSYdrb91AWrpBSp69Ng496okatJ7sIi1+t0WgqPdvjdqiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiyOUQlLstM4OULquOsPAE+gWW9Z/lXo5woUbll+vmk=;
 b=Rw1USBhErghModYkSdoVioXWkrgnIldYia516UfWS06oNlSufr7e4bjmUNukoAAU5GvBLkiEpQb54XSZvjq/H5N1tWAvA5mzQpr1CVVe2HK2jHW7zKN1+V7ADrU4/QUxl1h8CiQOzmewLBqcStF2IWA1q/qtUK5rGCCdn6PsPHFQeZfjBldn+ZysbVizrmCMk7crArz99DvMJGxlxB6i/pRIwVblDc2i/DVmN8K7j3Nz5YTIQf2cG1RcAf93fvN8Qao4xz1005++S4uWU4DfHZb3vI+8t4ntj9kzB9LK+v6NqgrtLUCMmqFPLbHRsjOkUtEMjkP4GlXu9OFMApNLZA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0641.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:285::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:23:37 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:23:37 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-8-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 07/13] rust: modernize #[derive(Object)] for ELF platforms
Date: Mon, 21 Oct 2024 18:23:14 +0800
In-reply-to: <20241018144306.954716-8-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026DEEDBF3647B82CA9125495432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87y12hsqjk.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0641:EE_
X-MS-Office365-Filtering-Correlation-Id: d905fe47-87c5-4337-ed46-08dcf1ba6c0f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|19110799003|461199028|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: xlqRdrAgWovneMBPnStq1iUVtqNKPn4tCsdJT48zdDC7C8G1ZF2+DywpSqYHjy8kXh4AtGFQ5rp9uTf9h6nUiN3mMFsd+beQQiDSrYEv1KdLBU3t9lfehF91RpAhRDX5PkKw29r0VUhXToaGTsh1r2qiRFdv0DB04JL+XFg6zEFNE0BtKklMOt30mvJNNTw4vTHxO7yPACcFIsLSOf5M6JsXh18eXp/MAt0TyExqDv4mwqRmj8tSeorPopUcuj45yw57qFktytyFHrRnkCRED7vM86kE9FXBqAYwv4g5aVzxsvPRGlddnuN9Xsn3NsnlJNV/oymGgsLLZg/5ETgPQMvBl1XNbM+0HlgCPEPBuRMzRaAGAcn/5Yor3XhKmYfPKxD81v9deJ8oFaZOU6k598Ps8G36owayhC9b4HSdkjFdG+NwLa0/MpUxparHohiEJUu+TlSBnvifUNxZ4lk8t/CjLsDBwPp10yfIhZBg3CmUgnaFiRF0YMGf1CvDCET4PV577m3dbAQAcR39O+Z1ayNedcL0lIONZNKV0zIuBlDoYL3dvFgyh6ijhV7bCeQkxMdXekqYxPMAeRAxe+3tDPLQ95DwSkmi05/aiqohhkFhjAnJkp/vBifpwA3O1dGWHN03NpTWhkSX3GR+a55KvVLaPbDCwuaG5PfImAc+DASzdUgLu7TZ1UrcHdGySPz/IlAQi1eYKf24GOTIFXUE6eJLoLlLxKMwNgyKvqMoFYc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGRGaSmDrZjTTWE9aKlOL1n7QWeg21DJGTSqfMtfchgfDZKQvAJT9ZCQbbbu?=
 =?us-ascii?Q?vrY/A7QdLK+CwQHRnGTtl3FHEogGFiwjgpk3E/nsYVyRnE+yixuaVI8hXurN?=
 =?us-ascii?Q?h7PQL0BndbbA8t19J6IwHpjy9S7+Xaf+esO2BN000A4qJGCG4FU1Wq4qV9ZJ?=
 =?us-ascii?Q?JX6agh5Oh6WSZUjg+8m7xtsF1ScilP65exnSTVNPXiX6zXXL8UZqeGExrecB?=
 =?us-ascii?Q?QVU7eYddYXm3xXwRMHt4e8qZGcBI0+jSWbF8s6wuqgcQOJrSdr8AO6ignEKJ?=
 =?us-ascii?Q?h3dqW40vPB6L3zVZGA+U6ZFtyZjjivAEPzJwYhwbwNC2vVQ1g3Ki4FL1gnBZ?=
 =?us-ascii?Q?vF3i8XYLShzlwIAdy1bH9HfcdkxTT2/MhmJtRy6IJRQYutg3+y0XHkTV3CMA?=
 =?us-ascii?Q?MmNRNrYr29upEj/Hhm0PuJR1SnRJoOdDCnG3qKXEh+X6pstXtW7g5VsLPS+F?=
 =?us-ascii?Q?1zttjL/LJyzqoUXmT1tg/HwGBJ5pOYQmpQlvFKt7Y+6758KiFdETx/5op8QU?=
 =?us-ascii?Q?MQSbvt/LqWfFuVMrFINWsm1KaFtPshksg3E9sMRZiZzizprxEz9Tlj2CEKBH?=
 =?us-ascii?Q?NB/KtXK551CU599uZwmf5grEaaAsmjoXVVSZA0vldt3c1v84R9QJ/imPe3sb?=
 =?us-ascii?Q?Xb7VxTTMA+DMRlLNELmnk71+hyUfcUtGP+Zcbjv7RZZ3ng/H6xr2H+p0UIif?=
 =?us-ascii?Q?oSO9KBgVe3VlFOz4TMtm3NslVfJ7jsJg3ZXMgPita808ZF33g+w/3bPzmBTV?=
 =?us-ascii?Q?BbiG+lhtkHgZhAtgJCuWHVUNlVKvO0DBlAGysdPkrHU8n+sf4Mnga/1e1mUx?=
 =?us-ascii?Q?TW/0ktQW0wa/EByvOnVYnIj9gYhOb6DI9NzNamkexKsywEOrzt70U99wsT4j?=
 =?us-ascii?Q?f+Bu/x8b4w3fov/quSpU2cQa97AlajQnWyle/UCyt5trTeb7OkwMsbEoMDMt?=
 =?us-ascii?Q?aDqOi2K3c8IlLW4RPdCaSFu/S5T4CtIqblKFhBSfsuZrOB7WvqVvkd4JDhkD?=
 =?us-ascii?Q?VL/0CIQwRau8v8MhNVnzRU0cSjRlYXk5merQVmS+lC/9SlI1rAH8VC3sYWbN?=
 =?us-ascii?Q?TXNfLi1wrcpTw4UudA4LtgaxqlCw7egEFduIh0Z64eEvBG4HImCB3l2LEmz+?=
 =?us-ascii?Q?HrYhDjRYNbihG6JH9Qo3wmIMx3jyHobvgcG8wWTPfjJfOhPlPy+LR1npWOZS?=
 =?us-ascii?Q?12ATowMGSP8tpG8C4jDJgtcxcsfIoXjFQQ4AZd8cZ1UiehechCo5oGLy0pA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d905fe47-87c5-4337-ed46-08dcf1ba6c0f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:23:36.0557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0641
Received-SPF: pass client-ip=2a01:111:f403:2818::82f;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Some newer ABI implementations do not provide .ctors; and while
> some linkers rewrite .ctors into .init_array, not all of them do.
> Use the newer .init_array ABI, which works more reliably, and
> apply it to all non-Apple, non-Windows platforms.
>
> This is similar to how the ctor crate operates; without this change,
> "#[derive(Object)]" does not work on Fedora 41.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

