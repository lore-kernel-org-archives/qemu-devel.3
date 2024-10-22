Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB0D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3452-00071y-22; Mon, 21 Oct 2024 21:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3450-00071o-GR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:53:02 -0400
Received: from mail-me3aus01olkn2082e.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82e]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t344y-0007uM-SY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:53:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO94gAWypdRzQXG4vqQCk+0qkzDohblhhYXaF4sHPVK6fYeyp2CPfcSjCY28aY6Phw2G6SNVVeMWcWTHNfTriKC1AOvjKf060z6j3Pe86dv5kxwxOxFlcS1yVmYnCeE75gCKlJ1dUA/f3Wy3mjPxkffShL84xdueTs6KbIScHXKsinTKQDlm6mrDJPLVYH05XUHzTk/kXkxCbtaRVD8Eo2Eu+9PjjZ30sZtTEDOBIyYBApbOyJS/z+xHmOs6Ms1n0HcSWKaR1wx6fl6JkdBFZ28gXj78qoFF1+2I7Rp9rkx9PuhsJg+nwvcDuOfjgSNT8WhxUWALjkVeqIfQSlFGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anRszzhgPX0h8rO61QTjuXrsjhOErTBRw9o562Z/rGY=;
 b=bz7L5XuX6NXZ48C2SBs5FVt/jgiuz1dxp2mIobZQcMKcFKCzpLxgU93C9N4epGt6nxYU88Ss2dn3w7kYh9VNz4wASAeELxuAuI0fk70aFA5SY5MDl3qYr3SJNjwB6Mc3x4+PdPhLWn3jpQYeGi+RSmcHRYLT4upSXTAY7DGUJg+dn8U8+bgJYaHsBp8WkhdH1y1X8PZK3HtC+DVjdl0rQlnEoFGF6ljTjYkvqtX4U55A8rBTuJGpN7SgZ8xVrb35bIRFpD7Ae5qmcE1eb2HHedP1S/bWxEXmMROYwY1jWwCvbxULd7RwjL3KUKC624zRx8EupyHxMzClVQU3eEOFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anRszzhgPX0h8rO61QTjuXrsjhOErTBRw9o562Z/rGY=;
 b=kFgYxsD/oNkG3GJtwc3Y7Ww3+rn/1Jdj+VIH2eJm4IMfXPatAaxLWMd0JXV3+MEKTGPZBOga+q1NzUSu9nhCkfCqpGbg0+sWOXiPqsjVCIyc+EOFf99pHwSDI3uOIgyBnneCQDIxveemv5oC3WX5prNotKkw4+46ImYkn24n9mkz6gugqjvO56MlzELnDN3wZ4e+9SzF4FYVSLxxr6l1yMciZKLeJjwxvVToq9dQLxh29dApHls3vvmqgvoyrV6Rg1/GO1Z67Iv2CIjmLazFGBMXDsG0FNBjSZivARAXv2OgoyIGAsPjO44K21wSSpHfF1oSdIIbQh0tHoX/6ZQfAQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB1417.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Tue, 22 Oct
 2024 01:52:55 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 01:52:54 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-8-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 07/13] rust: build integration test for the qemu_api
 crate
Date: Tue, 22 Oct 2024 09:52:28 +0800
In-reply-to: <20241021163538.136941-8-pbonzini@redhat.com>
Message-ID: <SY0P300MB10264D468FEE3ABA9E2351D4954C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87r088sy38.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB1417:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1bf8fc-2b39-46e4-433f-08dcf23c3ee4
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799006|7092599003|19110799003|5072599009|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: aceZgBjaATxwx03URT5ZVAI4VF5wrbVeDY15AVdMkeHm9Rv/4McfQGECSVGNQ7SS62kbpAta3lyp/ImJmGe3q0PoxzJLUxa5gelbwDGSWVtK4APf3JMzn81IKwsQyVRkwsPhIk+aNV+zrfSAUDm5m36RjQCFgXMVw59IFmjZ95J/UhL8jgLaX5GuNjl5wSxSOBgqDmsTtjcMBeUEJZpHqpDjJFA7+4VykJp5EQpRvv0yjh9I2h2WVVNlCKHFepim2D2fvYNFXg7vRNGPFvSlqRNLF1usZyYSMD/RlmfIFLLg0AKwi3+b7l0rdhsQlB4rWnFqLbq3U/hwERYfaDWZHrWCFh43hnMYMtLhLFjJcHt94jDwb1X50TXmYSRbRGeWTSIUMCL1TFD7hlUmidShVKY7MWgVIXwCAj37L4w63/AjqCZZs5xJlOOuWrywP4mlN4pPHY2msnfdR+pLPmCvJMxuXsMyblHvSbcSCg4wkKHt0OutnTKqRAW04/qDkX3U0dxaQJqzAm98btsM2qx0kE5LJUm2wa/kH0rND4jS3mYshfQ3OpkSkSQSJCnPE2UNbKK73FPcdoRLk+iB03RY5oPNeixQDGP+mYP6GwgM4EoBGNLyp6o6Jxx829v8QUOB96IzvP0TUsQOJPadU7xW+ia15kht0Rxe4R7whh2H8brmYUmmpMYnwTP71S+xwEpm40E7ARg42uKYzX6+335vVkZADoaz2da2DNUlN1nr4TY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x5xUwuUfIHs88bcHSRrvRMBXqXw9+v+Ppw3RPDAKbjX156Bhckp1FCsnA7ti?=
 =?us-ascii?Q?IJVHhQpg9I+VSHkhrcjZyTPPjKiqIAPgSVPCJVQ8IM9x2smnT29d51mgQi1J?=
 =?us-ascii?Q?KSUj3WVWx5upYP2kL9JDqCw3CSTZbVzvYXvLiMIguNGxf9OlKzfPybp78Q9p?=
 =?us-ascii?Q?XqYwBK3f6a5RwQ9N6iIjz7rAOTZjC3wSzN6VbyPni38AL36ZZmd5P4DgNagH?=
 =?us-ascii?Q?SgiDQgJanJAHlnVpswUH12LqbidJ7gCA7RRIt0pCS70vS6Tro/6cSChIzv6j?=
 =?us-ascii?Q?dZIdclBW+tDvIXaK+0nj3+0tbwex2hGmUyKVHR4TgbEln3ks3XtXJaMcsW3I?=
 =?us-ascii?Q?MG9Flipi/skUZ4F9C467TgOCix+aPiUhF3W/d4fqkL6haWrTaOEZ3nczaSpQ?=
 =?us-ascii?Q?VYwpJzH3m0pnwO/oGN9qV6/jhsA453dNRLhbxfbpTO9njHPF+CMjXq1xXby7?=
 =?us-ascii?Q?evn51bjpG0dTMSJJeGFm6t5d2+8grR7zOPy2RP7+IuUc0Qh0JHv8ctp1lFVs?=
 =?us-ascii?Q?P1eTEyq0bokiypRi317bFfeYqx1ooPtPfv6WDdvb/iiC0mkOxPxeAptKrOZg?=
 =?us-ascii?Q?aZMro39b7hBEOfWaX3qy2h2tiF2zHg6FTVcoybA5evd8hC33MTjexqZa8/n3?=
 =?us-ascii?Q?5dOonSiYamDiGqxpDl7Jn/6L2fR/agri4eWmVAL21wcjhjc1CCB2TDg7Zt8M?=
 =?us-ascii?Q?699Ku5/zms5vo0MsQ1EZewkmOb8gEdB7TM2ILGgGRo5R4zChKO3RpkFj59jO?=
 =?us-ascii?Q?YooW29J/b8P1FfoH12X3r2/BzhO3cDpUBT7dkVX4Uc23I167ncLlAvNfSCNC?=
 =?us-ascii?Q?Jcne+i2NitiohtYPu6yBedm26jCL3UBE2oqaGn88E+hE200DCOdWBqRL60+x?=
 =?us-ascii?Q?ryLLHjxiyzf7ZNkTBxcEMj7NfRE86icI9DNVqkSXtxPBf84WogSX5SEDUgy4?=
 =?us-ascii?Q?5SvTuKJX7+CCL9dugwHVaCp5g74JXNu/j7g7FcvqhMZyiMOLETlQlYmC//zx?=
 =?us-ascii?Q?89cU2k8okVWiri5nDo7y6WB0j0ClcwkerktTcjOpmZiYgw9gAyAVjha4JRJV?=
 =?us-ascii?Q?9tiRGCWmV69pDL8SorXpDy6RD2rcVFYGhdIpEtWFYgtqGsnXQ84YhLIWMpSJ?=
 =?us-ascii?Q?2xduM6rVBVsSwkyxuSwtFGx3EijyfuxfNw2oN54VSRbhBcUfVGaeeVcRrXaI?=
 =?us-ascii?Q?EeaLrV2ZL6iQqm0oWwOfaMkXsNWr/CRFmfH0E/PHsy0GQpuVxGEE7yrcuHU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1bf8fc-2b39-46e4-433f-08dcf23c3ee4
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 01:52:54.9002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1417
Received-SPF: pass client-ip=2a01:111:f403:2818::82e;
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

> Adjust the integration test to compile with a subset of QEMU object
> files, and make it actually create an object of the class it defines.
>
> Follow the Rust filesystem conventions, where tests go in tests/ if
> they use the library in the same way any other code would.
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

