Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35386E6F07E
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 02:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t73gs-0003wC-Bg; Fri, 01 Nov 2024 22:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t73gq-0003v7-Ha
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 22:16:36 -0400
Received: from mail-sy4aus01olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:2819::801]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t73gn-0003Cd-6g
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 22:16:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBgWK6bbTEuPAp5BMFbyGfzjXrypB8Bnza5ZTAi1YQ0Ib4L9ERjxpuQ9OKJrzl93wUmjaNiVK7Qgt1XHmbcOS7WolwVtyhk9LueP0JGIW4Zq+P+6EHTMxYInQ5OLR9+c5PBD1hktY5X0WS9/Lzujjz1qK1xUg3xfq8SYPirafTwLiEMMLGzbgC/R/Xn+vj6YbsjJ6+xieOoBDGJ281mwEEHSIFwqKvqABTuuLAWufycnim26BkpHfFom7lpODaprroz3bOz+vI0+HmmKxF/nvPeuCEoLu88lPd2jrsCQLj2LBclAmplH6t6mijplFusGryLUrYCPcL3KRAKsFa9i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRfroyAcBePnIw4cL88yYIALX+bWAehXbT1tmYOYAGw=;
 b=Aaw7lrbtWqUtkKTkzteC6PNMaP+WrK6D/RUD4GGBHP14+z31vZ/+IWUE6r0WY2gTPnI2KC9/nEEsVAXFE/9ddyCrVIDNXDhXCbkzkqcOJZNMV+R4BQv2rM4hFdr6bR54s8Hnsakuh83TwRcSbRbXW/R4m5aGVMxMDmycVJxj3FgStmyd9ENQMqqrqRuI0FjnJuTTY1hCYlM5DqHoQhqB0nxdeOX6UeoQjK4Z172XBUrKAQiJT0BRDJxTN0NEEO3rXlATu/6m3OZ4P3HBO4u5lVdvDTcRYMLqbpneWASO7RZjmKgqV6wv83ZXxvX32brHQh/9qIbNPUZDQD+ma0WIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRfroyAcBePnIw4cL88yYIALX+bWAehXbT1tmYOYAGw=;
 b=audLxMmhnjjJJuPSdinY5K/sn1YuAIe8y4uv3ENtNDlShjxYIkRzjdRHhmo8TXyjvCveMBP8boij61jQ1spkafiZlkvin/C8342bFl6YVqbWK/ygsgcxN7oqhR3Kc7TgXiiHZz7hTsAez9RMjb+u7u3/C8cp3qZk4FrbSwCHq6rmXEimnsbO5aNXeVRVEFWV0WasntBMp+WyeXg7Hk00DzB4n9mlrjV2jtmWTvaOphJUz99Q+ZkHHsV7gvB60uY+kPQ8rQQYKDueMGJ03CqFMQJH3fu17vJHcVL5xxxy9Jtqg5rqmZsnkLJZNIW4w2+S3nRnlYtAGnoB65/af0jBmg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0082.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:235::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sat, 2 Nov
 2024 02:16:26 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 02:16:26 +0000
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-14-pbonzini@redhat.com>
 <ME0P300MB1040C0B24C8ED1775CB0673795562@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZKK4UYgox3sYfOG8a9fCS+h9ouLCwydgq1TQfEoc4t9Q@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, "P.
 Berrange, Daniel" <berrange@redhat.com>
Subject: Re: [PATCH 13/23] rust: synchronize dependencies between
 subprojects and Cargo.lock
Date: Sat, 02 Nov 2024 10:13:14 +0800
In-reply-to: <CABgObfZKK4UYgox3sYfOG8a9fCS+h9ouLCwydgq1TQfEoc4t9Q@mail.gmail.com>
Message-ID: <SY0P300MB10267044462C3F203879922895572@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87y1221its.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0082:EE_
X-MS-Office365-Filtering-Correlation-Id: 940c6850-66dc-4ac3-eee8-08dcfae45a83
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|8060799006|15080799006|19110799003|461199028|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vj+61P9bPPgtq3lxJXpu1Wxok9t7meqd9yj4Lyz4TfNkpxipva1WWgAXf7/N?=
 =?us-ascii?Q?KyO/ighvpcAUGu4ZTNccqUAVj21lOSuqVJ42KnGip1d4bz+JxWH6cufkCMc/?=
 =?us-ascii?Q?UJ5TL/SttpFjnpABB2KcQEGS31g3vIYJVi13MCzxEC+Caoc099XivDbNlhsR?=
 =?us-ascii?Q?WBAiAWV4ax317Pa7hChClTX7XoQXt6nft9Nfx8no5/0y1HwYE519UIg+OeYn?=
 =?us-ascii?Q?hXFA42t7GjaJY9cvE+99WOn7AqATRuBpZPgKdufljjRsrhV85ktjlsnjxRLa?=
 =?us-ascii?Q?EvHqWppzffgEEAiV5b6ha85QTWCQamZKNWIpatygafDfWJq4HhB5qccIkSg3?=
 =?us-ascii?Q?YrhcEUSUitk2M5BDHyDjS25MkGU5pTjgveh9T7Dk514Xv/MlZ+/nvA9lJLIh?=
 =?us-ascii?Q?f14Ot92MlPXRTose1lX4R5yulVBPhm5s9cS0aXVByGLGP6ghPpg5ShfavWur?=
 =?us-ascii?Q?RHxQkxZX4rtjE1gKE3QPuLBh2OmG1tpTh1/qLoapMQaP+tygNJ3afQFyy7hw?=
 =?us-ascii?Q?KPGCIZ90PZ9trBfLD3QbxDB4BRp5CGgtb+q7VY5ncfHZ2cNQgSH7LMlnsSm0?=
 =?us-ascii?Q?YiNw8Z1FBCSmfgHKPqLpOqPCH5M6SX9+jYNRC2PrCnYF+OjIF18dL3pcSYJd?=
 =?us-ascii?Q?Q3MombjPsP1VrsplOjhUXW8gQ+Hwb2bKZ+f/UmLUv41wsIVXbAT00SpakKLu?=
 =?us-ascii?Q?AIOprw5DZFvAZOwk3Q5YuLOedcsA4/r6tNnpS2h5rEQan/naDR3eQCrLiwGu?=
 =?us-ascii?Q?4A95xjH64UnDRZPG3wHKk7IwRsQyr8Fa4gOnR8VLDR76Z2vJUAxca/3yjs6k?=
 =?us-ascii?Q?lT9ytK2xznROPepQugW0oO/KgST0/VDHk29I63f0vIfr5TZ4M2nck+3uDvSG?=
 =?us-ascii?Q?4NVwWjTSAOyrTylNt58oW9FeG3h1sru+rXTTMZmuGwRNTY9NkjB4abIUTT55?=
 =?us-ascii?Q?w52j24ZJwKJrccWES4yhhfILZnT8OsC0NdmTI0vyvQsQioixjxOgvU648NDO?=
 =?us-ascii?Q?PsRsnejhs/+7jy8dmgXa/S5nMbIbaT/nj2BjQp9JYF9Ay7A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjAx2RvCZelwRdpahHfwJBFhwHFfucwVOwZFW0BQ+OHSila/v9VlAfQCU5Dk?=
 =?us-ascii?Q?zrw1lO35hmIKFJVOTxpNquWbqn0OCeKTVa84CNCzp2chX2IIV09o9ceQkaq9?=
 =?us-ascii?Q?WOo2T+2pVTBREp+GUZjmYOC25LP93nlDhMZwZzIWvK9brm5GsVhgm5vLnTZ8?=
 =?us-ascii?Q?vWXAQQb+Z+rfhHnE6SycWGfNc0PsR/7wo+CxmFww0iAgVMPVLwN4uvz0ec5Q?=
 =?us-ascii?Q?HccUrgqoYJm7+1vQ/aiicu0NkcTpbDfs4cky9ajBvOt6a8SLxMiXJH99uesz?=
 =?us-ascii?Q?Ac2aH0G59ER5+8ZNEN/6eUzE6+IT0rWzS+cV0fNISp8Eqw03/9ahkfsqowzv?=
 =?us-ascii?Q?fFJTo19wroW07Bhn8991XnHLjoB1cctUfOCiYK4rBsj1Kbr2tJyPxsd4yXl9?=
 =?us-ascii?Q?vDRrOdnrhN/pdcYkHwmOYioAh7lnoDQB8qEBKBVZOnxjHImktgItdA2KRN8a?=
 =?us-ascii?Q?bnxhX+cxHSrtEWkWrBjALGoPuisz6gmpVt+eLL5PGtlbDmAb2TrYwRmlhZp4?=
 =?us-ascii?Q?9EgfgGO8CXBj9rkFdJuJaNnx4QH+dfoVRN/n26lXrkS9Fw0SNAZHTa/WjwX6?=
 =?us-ascii?Q?uH87L/ZrilCdITgcmYJPObva/tZKS+I1yAPxjWYoMNIZbHBl4Cv8jZQ7Dx4g?=
 =?us-ascii?Q?0S3VB0fC9eiSLsCVARc5+rUo3hPAPVYWsRMdaWIqUf57Bpmw1sJvDHnyW2+W?=
 =?us-ascii?Q?CAahwBj1TIxt826t2TGMRc2x8n4yrF6HaC9EID9lF5gl3wIsWJ7ytfAft2z0?=
 =?us-ascii?Q?HmIBF/R1n3NGjhWrXgZlQfRS2JZMsKJsnqFv8qAvgH/AT64YiRM0a1cUs8GA?=
 =?us-ascii?Q?FgBU2jL0KAhDHR6iUWqjXgiOhDUegg49zPtYsUR6iMNHO2PEETVvG8E18U+c?=
 =?us-ascii?Q?ueWZofeDu13K1k6SJEvOTZRTh7spFdth9lsJ0CJ+BR1zZWCXq+XQSjYtK6wz?=
 =?us-ascii?Q?Cr0pB36+VtN+IbRFTxhPsGLSIyCNeaN2irRJWcP9jhRgjtwmoYsvK8ITo2cP?=
 =?us-ascii?Q?ZfZ/RPBeyj77yuAyAeO648ZLapLE40aEQCD6DhxhdpImSk1rRKpG8x56BINf?=
 =?us-ascii?Q?iPmFoBJbMy+fH5WP5Rywdm+yz8cpgx17itChKYmdLi7oP3POGwzWiuAEAYJs?=
 =?us-ascii?Q?+V00ocbx8Df914IMAxO3Kfu5wcxHB3drMAwiEonk1E4r5oHDOEjZ1RRwEM4a?=
 =?us-ascii?Q?f6au4uK5Gb9orgf27IqYIeWXglLKGJ4Qj0mQpz7D56hrHUeBV4x2H06ySKY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c6850-66dc-4ac3-eee8-08dcfae45a83
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 02:16:25.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0082
Received-SPF: pass client-ip=2a01:111:f403:2819::801;
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

> Il ven 1 nov 2024, 11:21 Junjie Mao <junjie.mao@hotmail.com> ha scritto:
>
>  How about specifying also the exact version in Cargo.toml, e.g.:
>
>   [dependencies]
>  -proc-macro2 = "1"
>  -quote = "1"
>  -syn = { version = "2", features = ["extra-traits"] }
>  +proc-macro2 = "=1.0.84"
>  +quote = "=1.0.36"
>  +syn = { version = "=2.0.66", features = ["extra-traits"] }
>
>  Unfortunately, versions of nested dependencies, such as either and
>  unicode-ident, may still have newer patch versions after a lockfile
>  regeneration. That can be worked around by turning nested dependencies
>  to direct ones with fixed version constraints, but looks quite ugly.
>
> Yeah, that's the reason why I didn't do it... Since we don't have any security-sensitive dependencies, changes to the lock files are going to be rare and it's easier to just look at them more closely.

Got your point. Thanks for the clarification!

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

