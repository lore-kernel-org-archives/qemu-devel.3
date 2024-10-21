Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32815D0E6E8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pjx-0003Td-R9; Mon, 21 Oct 2024 06:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pjw-0003TE-3R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:34:20 -0400
Received: from mail-sy4aus01olkn20828.outbound.protection.outlook.com
 ([2a01:111:f403:2819::828]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pju-00025t-DM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdB/OBiK7vuB8VwEwgC5+sTYAHkXh8kQ/vz73PYcmAe03UqBKGu3EQub+GKaHusfXWLDAhMlrK5DrT4VcOy7CfK6UZfhyHKrxwEcu//MEr6gbFdTHiRkXgDya7l8XdiEqkWvROpIcTK96xWt6Y+iqQhqm3e6e79xkp/B1DJWZ+DuaoFqI5noNl1tg65qYCZxSNq+Bt7Cm644K1gPLqF1jT3Fr3Rfu2ed1ocEzURCJSlOeGv8Y6sUWjiUkqgmyIoGsEsCf8hacrqrDyoNojfqtHXmhM+Jtn1sxUzL8jeIb3CbtnOxKH3sWpQIpFK0yRIBe0DkQhi+fahongj5udQxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOYc1GRjNvnCIeUT7Pg9qcOmcixEQGjU9uBs35jRuGw=;
 b=Dl/302uXs77yZus5E11okh1J6MgB2Eo5GvC/lGXcD4SU/1OU2Bn3yhDgI/HBylqu7+Jwq+5SRbC5YDAfxVMcGOQiNm6tIX6Sx2cwrm0ZYZ2GkJ1+iHLvzpec3wf1tNsHuvw9x3c/hhy3JqrYeYPwAcQeGXz0rHAhrWWENZExcavIS643sVwwb7bzitHC9ogFu4I/FOb+/Jw56EBbpNGFd6+w1NJlDXwTa7p+8k3lz/LShGKsEX6VD6+0QURE9uMSy5JdlZSTbKT27RutReCgjAXqEr44tSQjv0AP+wlebXWD2D+dHL0dFjqjmiSpQ5lBB0MFS1BhWnfbq02ff8eyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOYc1GRjNvnCIeUT7Pg9qcOmcixEQGjU9uBs35jRuGw=;
 b=u5D14psm7uVryLbcES/lYZ09gRLPxVxuHdX7aSueWKFv8gunumFP8fklEN2pqKEmlUTsyE1SUaz3eJbMCwAj1brLW2bCTozV3jrFnv2Hvm7oLWosA0v2lMs3klD0E4lfv6muQ00oTEzTIaysOyPo/2/15iPxhoWuOXlg5mb1Izvryg40+fjCG5IZiA85OjVv1iNeGeJoutRohhX5YWv3Z5AmbvXrxUZwBMid+jsYFXOZmkL52DkTy0oZAdZY7m8M+ccuERFJhVdOVBHOoV65lvWpmxOKI6aslYhqCN2S5ATTMJoUoRP0+ptfFisJ7hrzwAZnhD88Nf/K844pVbY2Kg==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0749.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:34:12 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:34:12 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
Date: Mon, 21 Oct 2024 18:28:26 +0800
In-reply-to: <20241018144306.954716-9-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026A61776DE7025EC7B9F1C95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ttd5sq1w.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0749:EE_
X-MS-Office365-Filtering-Correlation-Id: b16dff7a-7f9c-4c89-106d-08dcf1bbe75d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|19110799003|8060799006|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: wStYBcMvMY2A8FuNGbA5Go/rbFO67Nvm/VB74LNnHc7322wYC0mH+opb0aih9zfgleF8ZncaGzfPQHFoRrjJcztICvP7sarE0EBmNYJFQyFbjRZsWjRspI+DNiTJkqKEuYbrJO5dS09zM1m4OjxDYAEuEFEdP4F3kk6aqFIDiqbBlOIxqPiQV+85ACIxJH+LtCLamFhwXIbNMPu42pg54njKZ5pBcK7H17+9/w+FO2wRzZSL8/KoZnZ9WjuKcAkTSsHz3udhmW4XUQNpYUFt3oK09THfH/OmZzYknhXDl4QJQVgt6JZfTV4HKqZOFD1twTDkJLBxT/a++DE0afClbSzcIJHkSIqBbHQ2o4GWUubDlMFGkzK2JkNbiYCT97Ln1mcKx+DoVRLJ2cJTId34foyiCSN2TsxCkx2CnW3zBIYSBkammMqOoXd2Q7eo9Cz2ZtRn6W1OMPk6HHK/yzY0LZTz7X6CS5LBy7+lCMX0PmLOnJFKj/45ngwx3SdCtfvGB9yWz6KnHeUmPnUqaM5UIX9vKop7lMlJiIP3OaA9Nd/LSYc34JeVTxogb3tYImhlWI/xGo3vYzImD+FWKnUVDRfMinP6fK8Vvz4+CExQeZieisEyBGKEcY/TW8L+xa1XYbXXN4CNPgXLpzcZP0Q75mXkN+WecqcFYfxhpsAn3uWjL6m2ii1o8N+Gs6ZJd+nCd2CUWD6WC/eMFyFebaXbWnO7aXY9Gkb/7wCZ5s4kiKo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGTBZqa2ywhQeDOfF88jd9D7S/iUGNcZ9uBRIxt0nT83dUTQWc/z1fqKiqUa?=
 =?us-ascii?Q?IL6P0QKukNc4uKQ3OF66jrkW05+VCk87RsJWMUlHrc8SJyZFQhgPxjMJr4PO?=
 =?us-ascii?Q?ND466SM4AKY6gnXJ3ihA4RaIQmY2JGOF5O7sv6NDvQBznjUGptLzDvZlXaLz?=
 =?us-ascii?Q?AOpDuNwlPY4ASpwyWsoJA9zEA8MJlL1H5XgMADM6NfpDor9gvJOXLz12WUBy?=
 =?us-ascii?Q?TMqsI2LtYXIVLCt/Dlb4MEhsLwIKnmF6F5077QRanbq14nxnL6StBdeR8b3m?=
 =?us-ascii?Q?BQS+OIdZeduLCsqKCWUPvj+GsKk34YgXzO1lu5VQ61yzYjVqZbx2QI+W1pNJ?=
 =?us-ascii?Q?njsN4aWZZd6f/nNZUb6/9fEDcHO2BLagY14kXkqx2V6I3mjtq0KrW4VxDon3?=
 =?us-ascii?Q?F0J5PECNfRpZdKbhHfi2qsYBd9pdQXBIhuiHsXBRQ713/JkAXaBtZDhTg2F1?=
 =?us-ascii?Q?GB5kEa353ZpFFCEoTnus3Pzp4/EY9CrSR8jEc7obJpQNxcihsiIl8wwz/g+G?=
 =?us-ascii?Q?VbV/RK+W7X6/oizMbRmmJVDilHNFAXhlZQRAfydpUWoJGcFxC1lShujtv09D?=
 =?us-ascii?Q?W0xsvQzslpF7bxwOpam7jPx0LjRQkqXt6gy0RhDN1jMizELyhoXKxi8g2nYs?=
 =?us-ascii?Q?DStPYzrQWinxNVhAtSGRAdMcPDuXcSwCIx7O4pk0fbSNgE8yRPUbk5Hvksec?=
 =?us-ascii?Q?P8W/9bPM0mSoMYcB54GJCdkGGEW90S/nr/qjmHm2JINdc2EgSMVigcewZ8pr?=
 =?us-ascii?Q?LKpe9Jy1IYqVplbn6RncLJ2e8rC2s90RKdaRt+7D7XlKy33VupUJe6hmARig?=
 =?us-ascii?Q?Gzplcwl5d7Uhmcw3L9PdILiHeNDdnrR301p6aMoVajOWLnuoSRJIi08A+ZYf?=
 =?us-ascii?Q?PIRYdSdjdzOvbUwiX/51kK7ptA/XyHKAHCfVX4lAYVKxAA02vfX6qKw/b5Q/?=
 =?us-ascii?Q?hf4Qy5jpegvlVsTQWvGccbCU6cKPMIDJRY6t8UcBS15kiImq2vUJdaaCDpe8?=
 =?us-ascii?Q?4pqft1s6eV/zceDMVFLeULcS3QwF5NHolJL6B1vJqua5CzKe+xu74K5mo3mW?=
 =?us-ascii?Q?C3p4R0h98Fe0rRqUHsdkTyYmDaXFfdqXjJ3DCiftoBtJk6Z/wikWunbNV289?=
 =?us-ascii?Q?pCt9Pgk01GmyOezkuXgjhkGrZLmANcy/BBD47u6oPpMq6UNyoW2GC/t0dM+7?=
 =?us-ascii?Q?6WZKmkTD8H6YkcQYQbapY4i5dDXAPz+wVVNEt5LEGjMZHYSgbG3h/h+HnO0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b16dff7a-7f9c-4c89-106d-08dcf1bbe75d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:34:12.4186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0749
Received-SPF: pass client-ip=2a01:111:f403:2819::828;
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

> Adjust the integration test to compile with a subset of QEMU object
> files, and make it actually create an object of the class it defines.
>
> Follow the Rust filesystem conventions, where tests go in tests/ if
> they use the library in the same way any other code would.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

A few minor comments on cosmetic below.

> ---
>  meson.build                  | 10 ++++-
>  rust/qemu-api/meson.build    | 20 +++++++--
>  rust/qemu-api/src/tests.rs   | 49 ----------------------
>  rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 104 insertions(+), 53 deletions(-)
>  delete mode 100644 rust/qemu-api/src/tests.rs
>  create mode 100644 rust/qemu-api/tests/tests.rs
>
<snip>
> diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
> new file mode 100644
> index 00000000000..57bab62772d
> --- /dev/null
> +++ b/rust/qemu-api/tests/tests.rs
> @@ -0,0 +1,78 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::ffi::CStr;
> +
> +use qemu_api::{
> +    bindings::*, declare_properties, define_property,
> +    definitions::Class,
> +    definitions::ObjectImpl,
> +    device_class_init, vm_state_description,

Cargo fmt (with the current rust/rustfmt.toml) formats those lines in a
different way, and ...

> +};
> +
<snip>
> +    impl ObjectImpl for DummyState {
> +        type Class = DummyClass;
> +        const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
> +        const TYPE_NAME: &'static CStr = c"dummy";
> +        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_DEVICE);
> +        const ABSTRACT: bool = false;
> +        const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
> +        const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
> +        const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
> +    }
> +
> +    impl Class for DummyClass {
> +        const CLASS_INIT: Option<
> +            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
> +            > = Some(dummy_class_init);

... ditto. Shall we tweak the formats here or adjust the rustfmt
settings later?

--
Best Regards
Junjie Mao

