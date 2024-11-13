Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43339D41C0C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 07:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB7iy-0005qS-Sx; Wed, 13 Nov 2024 02:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7iw-0005pu-No
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:23:34 -0500
Received: from mail-sy4aus01olkn2082f.outbound.protection.outlook.com
 ([2a01:111:f403:2819::82f]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tB7iv-0006Rg-BL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 02:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIJVUapM/LTXhmeDYqclJiifTMtVxWt+F95JhIwx9gKATRpzCLOQtgC6aBf1UsLRVr1t9ka6ZLsVhGJ/tgj6nxZMkOdqihqw1pm1g0GCaG1RbQXWE/QBFk0XGqIvzOtsfkgOB+Td0qdlnKPvrApEMPejBvboJ7S1Hz+EfJk28wSTLm9fFJu+y+z6TjwS9FlBzsNgd78T2OFOEe0c915FOr1XDLmTPrVtvWNSvds2/Dn/hvW3rjeBFy/lasHlCiBJ1w+ADO7yf+JeLgHfWstafxMK/+poHoqAMNyVTn+y2d+CZGkwKxArPuQT/MWNMXrGQaTFdqYIBIMNuOVHyifblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHyWeFNLO0A4Dr+/RwcPQFD3RQiUClReko98wNwEQ7Q=;
 b=Aae+L6RX23zi80ysK9rewmTY/0d+ieSBOoGFLB4IOYjB0Lu9ZDtKKqY0IwkttDdHAGVovq5tw5pxoZHPhRnYUgcdrP7caxcZ/N4XHTjUbYwMQDlePfD2WF6ocbXUBfNUnxZ4tnipZL9RCBlr6egY8PzMy3hr5cb0/eLziCl+LJX/ojoPEMPZ/tJ1axS4jnCa1P+yt5VMpGh9pnV5/nCiPdFdpwKULS9ewrKtoea3tDaMfQ9vCE2SXwdyDr/bkOnbAR+dzwZGtD2xSave7KILxGP3xmn2cEKsDF6Uuc6GL0ibxTdPuJkfVGiH0UO+ZheihK3a6UZXIWITcCQq/38Flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHyWeFNLO0A4Dr+/RwcPQFD3RQiUClReko98wNwEQ7Q=;
 b=JqP8Bg+XjM+jtTPcuI2rYZQMWCKa3Kt86+kTGMyjDlp9EceZSLMbGbaO9RLPeEqK5wdPLNDspPX3mhI9Nz3E/bHkwCnI/MThjgaQtdBaelCzsdSGwrfflS+WAYBoyVrDgtybq/1Q7wBzO+okJuG6pqknx6Ajs2vA088BWRJ/KFw25ssT3iF+iNvdV+5Z11kCi4WuQBtOkvU9xCm/QLzJKfyVZwTkwjYARdgfvIsuBnhtXjIkP0a5LjxeIYz2Te2Vxr95YleRUkBN6nmTOOtRlwSmTQl1iOYgOGohwQ51aNPOrrKLd49vCZO33Q/Zumn2fS/l8iEugZogeCARkgVQHg==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 07:23:28 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:23:27 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-11-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 10/11] rust: fix doc test syntax
Date: Wed, 13 Nov 2024 15:22:10 +0800
In-reply-to: <20241108180139.117112-11-pbonzini@redhat.com>
Message-ID: <ME0P300MB1040EF31C84E7257E1A9C6EF955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87zfm3egwq.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|ME0P300MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 731444a3-03d6-4284-5910-08dd03b41156
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|5072599009|19110799003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsNVdNkBGWlgb6UB3X5zkUD/3EbtYi6jzdZgVYNZPeCHa63kInf6ASnM0kE2?=
 =?us-ascii?Q?BeK5shfeLy3uzw42wSS/uI2G0FEtULT+Z97Nam7YF7tz3GdAjRwei1zWF6LV?=
 =?us-ascii?Q?8PX6vPGfRLPhEfZiSObJAtTGR/okDX9P8TIDSp4xGVWN63UhY9RMco1NX6p6?=
 =?us-ascii?Q?NxCSw8uUikYjpOulJnn6YCB+8j45Wu0dmSuZkJZ8ECqHyOs5+py8WnzM3Vib?=
 =?us-ascii?Q?RYiXxRhcRGWnI3Of2CvUbHZH8Hw8QRxs5DlovGceQs6sCj1GHoIYS4Jb6ZGF?=
 =?us-ascii?Q?ihHX4Pcuv2Sf0wd9DszyrQI5WgUgRi47bq52GrMnIv5KmZBDwiAjsyL4svyE?=
 =?us-ascii?Q?exZTtuJbTqMkTzxjh0+ayE479l3ZRGW4DxzL5feVfrE9+6vu/5oRdP8UIHHI?=
 =?us-ascii?Q?QEdhebe2YEP0CI+wvcKWHzqW8fEdbaKGwdTtFd+md01+e/j+o4+iuMeOiabg?=
 =?us-ascii?Q?j16KRAaDGl6aITmWXcrxmmM2tJsvYiY+fUoq6owx75AtR/1miKGO32m3YWhM?=
 =?us-ascii?Q?vAgOZaC7YNWmYDLnbsEZRf3eKaAMppRKLC1S4rxO+uvA2EH2sYzw5iOqbIp0?=
 =?us-ascii?Q?g+TXSl84gUWSk02ClLMVL2ALMhZRbQyrMDH3s5EI4hzr/9qtwpXqAl5I+CHp?=
 =?us-ascii?Q?QWrEuj6IDxVkWeM1hcmP8h3U2REaG+3fLFPr+qtR/aNGtmJtiAWVSQuqcJ/e?=
 =?us-ascii?Q?Jf2O1/d3HElVw+EACsYVdkXAjg6mO2rN7JBjUXubNMujsM2rm4amAf/r6KHY?=
 =?us-ascii?Q?oPimWBpcIEKIgaWd6jHWBdXepRIBL818p3ffyLhEKvljJLp14DvcuEan8nGr?=
 =?us-ascii?Q?r+iTIX/drBHHR7dJ8NF0CdGECmsiJVhAXRUzIsg05ucISErO3gJ6rWFO8R0j?=
 =?us-ascii?Q?7WeE5MWOuqv5+CxRzzzyUiXARB8hYVFhltODTGpnsbH9KKjRzYrBN3bwizpt?=
 =?us-ascii?Q?8d23eWAPNe+BErGOWNv+fhQLtXT+FI10GJIK1Pom0/oaUHd7o5LTgrNcP3pO?=
 =?us-ascii?Q?mwuNVJfQ6jlBubS1rSGR/aO/GrQpYweI95Yws5dzWNcLn/c=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWB6mefIoEnw1ESE8jFuGF5eLIJaw3y4t2L/qHhDT5OhT4e8VHTBmLe3X6/t?=
 =?us-ascii?Q?VGaGO4TGLc+TP4Aw6cix3ARskAmguLs8NBfBX7wwCEb8SrTgTbggAnUepZM8?=
 =?us-ascii?Q?pmvAAQlmIkFoQTrtAAlCg33Htpv41xY4AGP+uKQTWmyGErtxLcT7bOo3L4Tu?=
 =?us-ascii?Q?8Be707eoGc4VvnQtU0fUsapc4qU3a36mIeEEYyiW3zLSpHepe9Z5NgxZg2O6?=
 =?us-ascii?Q?CVttpgsqq/0eGv3jAzqcz3rg7e4VCNBvs7UzvgGuN/Ufn8ooaz1pBHnqGGgA?=
 =?us-ascii?Q?ZCa82tZuDzUuXiJM9wXTiR7vqmn8bydjQxWdIe0kbUtJbPFWWZBvuCTmczOc?=
 =?us-ascii?Q?C3YFgNU1kpiGdYRlIKwmMvBzblFOgllZITkkorAgnUIhq/lvYsvQGcf8JznL?=
 =?us-ascii?Q?653+eN01y0u78nzBxGhzGuA5x4wg4rtCl/heJEb4VP57EE0mYsKjSNx3Fubn?=
 =?us-ascii?Q?hMEJt9N0t9GTbGdbd6XVjKGw64kBR2qDeJhjW6MbkZf5XfqrbhmuxAdSIZAr?=
 =?us-ascii?Q?cM0w9auWL5E3i1cgnWdKUODD5XKPBj3/wQkJeVMZdQYJU9IYXx5BXI7IMbS+?=
 =?us-ascii?Q?NDDlUFQYPGtonGy8uvJCsoDm1IZ9bXBg5lfbureIxAj2p23QN856u5so5qQd?=
 =?us-ascii?Q?Zc2aW99PXtq7wmgTQy+VwZ74jHivchDs8Cd4cbxb6p+DU8o0VqcmhZUO8Pu+?=
 =?us-ascii?Q?uIbldzvwB71NQlPyQbOCcT7dQhiGz1NApHUTeurO9vNhkG/tVCa+g47NNAnQ?=
 =?us-ascii?Q?1FNENmZY+RwB5jOnzPlKxPZuo0yXschnDjaJ0tz1XTufyJq9rjRExLj8aLSb?=
 =?us-ascii?Q?apbtQTYPqw9nWYER3qkMjQ74l26TVtLSJ/SobH37wIWV4p9KJLdAGuwuig10?=
 =?us-ascii?Q?6JS8AAfuwY/SW/gxMLX5LjMQYlxoXe75eg7YqWVaSHUCtv2zesfGIMHMjnSW?=
 =?us-ascii?Q?3YRedSUuOGwZ4cT7R+6v8z2ZoI0N6mtyb7QEA2PT7Amu82Guy4MDC/6KrnVh?=
 =?us-ascii?Q?TnWylCKpjmlRsEHLG4fZ6uL0Py9R3tpU1SSN0djvaqO50V2W0rGr6NhBgJKs?=
 =?us-ascii?Q?UYopO9+7vTi1ZBwYLZVsw9iqeZe/2I8ltiKQV+w/faigdMhs8kl2HKp6f/vA?=
 =?us-ascii?Q?TbR98KD6RjcRl391M8M+dcktrw+jsm6yJVBborzM8k/TKUGmaOcsYNmKKltZ?=
 =?us-ascii?Q?H/LsqofnbYsfAAA/mODdUNjpwcaVf6FrEK7p0GThZPAEEFxut2+UKB31JVc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 731444a3-03d6-4284-5910-08dd03b41156
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:23:27.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1309
Received-SPF: pass client-ip=2a01:111:f403:2819::82f;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
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

> Allow "cargo test --doc" to pass.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

