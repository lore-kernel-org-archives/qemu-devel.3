Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652ED1712C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34lp-0004Z9-B2; Mon, 21 Oct 2024 22:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34ln-0004Yo-7x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:37:15 -0400
Received: from mail-me3aus01olkn20805.outbound.protection.outlook.com
 ([2a01:111:f403:2818::805]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34lm-0003kd-0k
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGkygEd0qTfuZhQN6ejWX3J9ELUDUzp1FCNawsjGvIG3FDb4h054OlFDjSrA/Tbm2iRr6PbP0SQHnlM+qqzHG872kzEEJA01m46Nq5DrKcDqE4ZM6PFhx/U+/ei3sbQQQ0la4F1FJPbVPZfSf55IDi4jfYxfb6HjDbsXU2Atgqpo0da0+vlYhv/IJjmN7RwghJiL856QERxTqZCGyWVeIcPjGsAOZ2MpJsQJtJsC4lTV8RGKc9B4BHvK6Sjruql+MHdBlAEKHZp/9JbcMEajSfPQe8uty3/tlTZLtejGmSI6ZZdFgfDMLbcQop8ieagC4QDFt/b1YV6WvqJXD4g1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpP4HYAN0HjtWUYcYFBCfApKZxpC1I/YWuPbgmdR+0o=;
 b=yyuwFEcaZQnRcnIaEwjD4DAzrki22on8sh+PiBUG5V84AifuVq9M6wlWdPC/NtlZq1XV1wjOYG33DVUI9odavuB+NYFeXW1JS9UXGTPZs9kdxxuuiMJdaQnrVTWSBbUG+6Bb288CQ/bi5ybg9fCAOHO3RygBPHBBTrVHJG+ReauWdRgytc3h/EjYH6H7SaECdJbGOhCYihc5F++YM9vhKtqEIprAqziqC65F1DyK6yB+jWOPFRmEdaIOhbhkdQO6mBVjqaNH4mpcTij0IQtA2Qu4Xr2urOIG2mTugEx9Yhp8LPoKTKQphsWLmuLGTzEVL3JF/6Yzc7E6DapYHgesmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpP4HYAN0HjtWUYcYFBCfApKZxpC1I/YWuPbgmdR+0o=;
 b=I8RsPqXfZnDbtG4pamCgb0gyFcfZ3sTDwJL5ihbCSTPB+2zeqjaEEhrD5oMaME0v3Phws9Sex+qxM6rh9MLN5dFRBjdaeFkBNsyjMou8wdM2Uot7yL71YdE/5qskLqZLqAeoxa+X8BjkRGu6MfXJncCfROfsnDUjlge7qErqvnitfrAgIeJIHAJvl7CMyGZr7B/n4WnGhZqLxIAGTGoRu10TrXma0hZEqXGKD7WRsTznpvGjgPAc6FI8dGP7sMrNokQG4r5a97FkwDZABvl2v1GAoxqy4PB2vtjF253W88gDacKQMtUOpCoRaecFjXFVRiEB72cE5ELUlJssL0omuw==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY3PPF947566139.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::4a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 02:37:02 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 02:37:02 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-4-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 03/13] meson: pass rustc_args when building all crates
Date: Tue, 22 Oct 2024 10:35:32 +0800
In-reply-to: <20241021163538.136941-4-pbonzini@redhat.com>
Message-ID: <ME0P300MB104040B27788B33C0ECE60F3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <87bjzcsw1p.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY3PPF947566139:EE_
X-MS-Office365-Filtering-Correlation-Id: 97279746-6619-469d-512d-08dcf24268d9
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|8060799006|461199028|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: m1NPcdKW1pGxb+QDEwgMM3Cs6LHHJgbBY7ivYzaRqVbr534sFBA21Qdl56yGAxigFYZn/7cDHxkDGlQ0w3iH80B71OxNGnSH5iOcZb6palAe7NzFMU9jJsSjNFmj9wgZroKEWQz/Trj5x+Y+G6Oz7AiFY3kfE/nVfEtcYatbOOQek33hJQmHxSVLajeCTKmC4Qkj1MPg4U1hqLbWUYhGQ66/o4jp87o3jMi5moNqgBoczIIadcuUx/vPV1yQwvW8rw5tJV8rRAnlwLjSAvG7u4xoxphp1v6XZKHBSXIp5jyg/GNDskDyonqJ/vlEY65JdzSLlo9N6bsd1IZ4DEzsoZWYoEM7X0tWUD7I1/57p9EmznnoKiA9LnJBwuoxkAHOoAm1r/J/UZh+Qnn7rj6QRV9mmLqq/d2lHUCBhqfC9kzz+gn2J4gm5VCcxEMk/RrkN+ltAX1Sgve5J15S5G7ATFtBny0Ig+N8O6uB0UeCNGWce9xIXc9f5BpkHc3PS3GGtD8PnPLOU95BylM/aVlu4haGcghfoIDrsKxUTBDWOu/jERzw7spMJz6cN93U0x6Y5e8tpCAHlErEQ1AxEfY6yA5n7Oik/neF3dA2dNB1B4tgSbVFuwdu7wxGT/xgJ5P6Nt1Trk3QS6oEnwCqegLMNGzOBxc7vFGuy+zVAFijBRtyfGRAZr5GQ1W/v3qVjI+nLFv0aXAPyaTcIZyrjiSr97NLnQBpk9dYIov5VwyrN5k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJhjkPaqbMQCvfgz9Ys7c2CVq3qumGlhU5GLHkSUjiP39NMGAa7PHsCLDOvL?=
 =?us-ascii?Q?+nKv3jNHUx+nxeddKZX2T7nfPG7ue3xMzwKSD7wgMLPzU1LgxPE0VLKtbLWN?=
 =?us-ascii?Q?lSzfqb0U6W14sBQ/6PU+f79pzhwMxZaUdNLxemNJuj9aEJ/ulxaYykp/FPn7?=
 =?us-ascii?Q?6cQfiAguOsrKVQ2kx2V01DUAzhJAxM2Xgji59MH1BRFEa2MHy55sEGLZYrYr?=
 =?us-ascii?Q?iTROhxPyaQ4KwJvwOimX0J6moFvAlO2hhO/eg/FcTzZhZPUfj9qGBXXIm492?=
 =?us-ascii?Q?2zYdU5JfMUVwdMgXetxHmQeiv+S/x27OeyYEHgDGSlOAe9pjcX6W0iYjrbye?=
 =?us-ascii?Q?5ivHipMg3HtLzB+fhbb6n4CJlXjkIWiMjGXcUEDnmd4EOfSc29oIgrsk6aLV?=
 =?us-ascii?Q?abZFvqZIGeu5YC0HX68AcZKnq5iB7xFfeTDOwWAl1F66KhCKpD3FA+uDKuLZ?=
 =?us-ascii?Q?FRkJNweN73fehYNIchF2Rg7tMrT/AvARSXdkro+08AZP+tYeyFuMxW2THdjv?=
 =?us-ascii?Q?nXZBslGnoz2dS+mKfrpTdlP1WZNFIZbeQ2B/yIz06xhWfkm9RCemM0Lw5+/X?=
 =?us-ascii?Q?09d7XfyQEyv0u3B7Z7cvoNhgHSA8aDmfgA1aoI5q/xhuLoQajDU2FUwrbQBd?=
 =?us-ascii?Q?1LdM8x7XDgM9nCsY5jL2XwSBq5ryeEPuGhWn9acrwNfVu69V7gLO9gC+84J/?=
 =?us-ascii?Q?rJl7j0bgUVeWS33LUv5kEInN0bFGIxiRdFC9q8cxO2SQH38gl4C+kPupaoRy?=
 =?us-ascii?Q?EUCl3WpSHOd4ACtL+vaCLG2jSccaZraaMqtOYSmiiOJ17LeIRKxR9Qnce8tO?=
 =?us-ascii?Q?ZOxrvk8ZNF3it5ZdrcmVQf3JwLQTZ8S+7kiXLSIxGHvcM0dCf36QeNjr+GH+?=
 =?us-ascii?Q?o7agYgn5ZRho7twiPpkhJy464+M/sJnp1TNXd1sGF9Ee3GT+r+1jKWVozj10?=
 =?us-ascii?Q?CUwL/tAl/uOQRB7SWMDN26VWraiHtu6z7REiq//kf4d2Z4t3C4g92qKbSxVo?=
 =?us-ascii?Q?Tj5Jzzau0z7szx5dl9UN7SmE8zhxa3KAac2c3bfiQ59C3AAcyPOpcEqZolaL?=
 =?us-ascii?Q?LT4RpLo0hE2QVtXFLiFRMLYpgLcyN3MZTDA7jPw0tZUHcvKUgJvGmxL2JNeE?=
 =?us-ascii?Q?QjCTnZLE1uwHXNvRPBSl9dxGIdHWiG9B0vAEUWN3aCl/Y8SOdI1ph1YO+DGR?=
 =?us-ascii?Q?+X68w3qh97e496juaD+HBflq4ZI+e/SMcsoJnJlAsePWFAkBxFgoImeb3/k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 97279746-6619-469d-512d-08dcf24268d9
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:37:02.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF947566139
Received-SPF: pass client-ip=2a01:111:f403:2818::805;
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

> rustc_args is needed to smooth the difference in warnings between the various
> versions of rustc.  Always include those arguments.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

