Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C1AD20688
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 01:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0tIj-0001tL-EU; Tue, 15 Oct 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0tIe-0001t7-30
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 21:58:09 -0400
Received: from mail-sy4aus01olkn2011.outbound.protection.outlook.com
 ([40.92.62.11] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t0tIb-0003CH-Gu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 21:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URXyvsI7PXeBWA7waL10zB4qrYwrWduchep7+jwo8kKk45w1/ioo0e6mZUZBXLF3El8jciQ80yv5Vsz0K3ko4FBm1F4TC223dq09FxTxuORF/YVhJJiFynzDh+zu17SlZWBtn3bgyFvLG+AYr0HPVAH0cK/oc9sA6ZTlahoASyS0KdRnoRhWrIzZ7JjQeOYPM9l8c9eFjpVGswOZVu7Lypr6Npn04Jj5wKVw6VmItE6zPQS4rRnIvtqYORGoW1y4vULain4fh5mOYT5ZFF9hrT4+v9r9AksnD9xpC9/ETCqv4WTPKP/qbCF64xvp6HFCoPxb9j7quMqq72DrHW/J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQnUu0faaHIEerRqiqh/edc9zZbo0zSb5lf9DAWQULQ=;
 b=qgeAWINyTuBxJ7IjhCKxF6aDQo/8j1DMKDFkSXf/rTo02N/AnapsLby8dj9biSJw/e9lfBzLjHe9UVT2Uc1vdUJeNmd1nqtZ3RtRVUOlSOXTw+4j527QUMvA0bFxeUmZusYHS3l35Jgnehirg6pLuLE2CspzB8kTvreniMjpVSNWS65H7aqSbZSribqMWAT4iSB25QRzwPYXLka1ZIMhVevwart6V7lHCUOL8jF3vyXcMxPxKfPKTEAKFWPn1oCnE8MCysA1mH6Qxi9BqMWTQVLMhE9nmpLjBVCrUzugfn3eMBYSdueev/8nmM1SjyPh19hGGbv1lMxCqZriBurOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQnUu0faaHIEerRqiqh/edc9zZbo0zSb5lf9DAWQULQ=;
 b=H5QCsH6KFfpJl+yXhOLBIJjrKwk6pjqwEWQqXB9h6toON5L1RPqXQ3windxhUsrnWhpSTbxa48jD4FSLtflZqh6JaIjKoll7IuUn3N7nRPfnKJrgoovm+7hlScshoUZWAlcCCky6YvQldGBgZtb9KBu15j4Qg827PGryY1xB+teKXdE7IVy+1sgAwEPIHejj76V6Ce5gGc0b9loBrOVC8sv5KDGu4m04/TfG1FyiuqrlMjbBQLBTgBYVHOz765MT9/nBfU3Ye2dnqHDUX25Ej9s+pg/p0BxzMVSMXdY94xUvty1nov0dqrKhTDfqfUQvclb4P7cUE7PfAK/j7yH/ew==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY0P300MB0025.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 01:52:55 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 01:52:55 +0000
References: <20241015-rust-wrapper-stdatomic-v1-1-f22c0bd31140@linaro.org>
 <24e344f1-d6a8-40c7-a543-68251570fc58@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Alex =?utf-8?Q?B?=
 =?utf-8?Q?enn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] rust/wrapper.h: define memory_order enum
Date: Wed, 16 Oct 2024 09:48:49 +0800
In-reply-to: <24e344f1-d6a8-40c7-a543-68251570fc58@redhat.com>
Message-ID: <SY0P300MB1026AE3D9B2EFCB1B47C8BDE95462@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87iktsrez7.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY0P300MB0025:EE_
X-MS-Office365-Filtering-Correlation-Id: d313a5f4-c119-48aa-c904-08dced854101
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|15080799006|7092599003|5072599009|461199028|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: T+v2bippE/Tvo3cU6YcgVilMkS5pnleUzGg3+DMkYJbZSIbAFDO3kWMbZzZlM/0LjXcXuMMXCQhQZBJFAizHpbtni6b6IFLtQPJbztJQ0gUGMrKlB7ljQ93ZNHaZsZU1Ev3lXnME2dZN8Du3l9mu+yFP4iX/TkdSR24s+UYE44NZY85xSI2ho01Df82bFed93wrtt7uJ1mSFaI4OOggnKqLXC5P3O2WGsVo2GKQc6lftTcK+x1HWVhrqctWVQk5NsqydJpHtTVwrvdwkDJXHEZ8gB1t907W4MDgNvlDw6OqmKWpJwPt4j2w69wtFZ6QG0n6oppD0j5+LnbpKg/2IjzLNTStvOuRDTJ5tET7t0i5nVtK/ndIoIIwbajETPc9tdno09TLK1QSSDL9TJ/Ey6nyobxx5q9owPLJ0CRhTi1j4RLdKLfkSqMEH5+t10EGeYH7m7Xzt9f+Vmu6mWH4OiJe/cZJShTAHEvUrUXvsazwwKPPusuy2m3nNJBXPnGQfL/E8EekF5zCrMTQ9Y4783fIAn2PuXdVe4ZyoPeo7EjBgkaR7yFy/A5lF5Daz3uRT95ZnIUDfxo5W0edlMtuHdZ4BvHonCxJLRIymKDG8kGNGm7nD7Kr/4CZvv38VOfSkt+htC7ZvCo+oLZOR+wCREmcKNZ72SGVZK8O0PlBLZSTCFhWurBY891x8/+xqPaDk3WqE4fdSe83XtoIxQZvWTJPZz1IyuaTNIU/bEz16WvU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3SBkPn+2bEdG6zHBnHzMWtfnl4FRhjS9cMdU9+gO3TtWiBItjjLr3uFbDWz?=
 =?us-ascii?Q?1BXdoliw2UoyITn9q+MIT5SsMtObleTIz5nTvb3FSQAhLCgNgzUl+3pcNcby?=
 =?us-ascii?Q?IZWE2vGZ1RosubeLRCn3fgdn2CHBP9tjYWBQGDKOCIGY690DjUbd6WTpP6/B?=
 =?us-ascii?Q?4zQY/m6SqVCibE/pJyvbiDdEDyD7Mv/b3fcPF/rPJucUrYmDY9QAhXndZYwl?=
 =?us-ascii?Q?QpDfK1iX0pgw60+TApjbTn067LN34Z2k+JhStNMW1Hlrx4ZhUN7PoGALuX73?=
 =?us-ascii?Q?W9cz+jwTZtvwGzIc6zPwiRBDLrEik3TaX6qQjDtojVi8/pvH4Y/MBKnSEFRw?=
 =?us-ascii?Q?uTLJFReG10dVhQWtDw6+Fr33LdUlizQQelwDxGB4QxSV3qo6ousBrw46t31u?=
 =?us-ascii?Q?OyND0oD6G/NYqjBLh0sTxjo/1R0Hayc9Oone4dEwFCx9L2leUUUX0XUZB6Ei?=
 =?us-ascii?Q?aqheTPLMXNPerx8a5hQULbUnnnR+HJVdI4UCHPSddjwqJaXm52DXohCzqXBj?=
 =?us-ascii?Q?o1y/DWwf1OBtxBZi6pfS8x/mRunOOf91bD/vSvQfTwTJF1hwv1MpQOrlNCfl?=
 =?us-ascii?Q?kXxz1xrkf/Eiqx3dm4RMlhfIGCb5sIV4yRZReR7Kf1m28DbZRStH/N+Uxr1n?=
 =?us-ascii?Q?63zKzUHpGhQQL8Q/r8aA2Mi62AUjCTb0RDZfZGuQJE0UR1/yNgwykaTzlxJa?=
 =?us-ascii?Q?zCZXr0L7Pd4UthMqRvRwHm3rMYlatyF6P/PSGus7SG0ehNrEHffLgvgLmp0F?=
 =?us-ascii?Q?VyotkjFJuJXvxnXpWbn/fwR+SawSO5IpVctQ+1GDAK+GVmuy7BTYVY7/L4EG?=
 =?us-ascii?Q?yIIEyXLJ7f6URmxqUC7mHhekSoqyDdMdeVGT1JyD1nvCVRGVnAcVnWUtev9U?=
 =?us-ascii?Q?AW7kc5BlXDo9OK7iSF2GFk0o7SvjvcDAZlj2UCvLDi6Ptu97svwlNLsPKEj9?=
 =?us-ascii?Q?ZBoW/SZupuBm7nV3uhXEjABFSXOMqC6wDvHLy2gZ+w0DQkqkPZnnlgP1vmKh?=
 =?us-ascii?Q?zqP7v/H9HFgYjsxhIf6QtaikuD7rDZJRh5b+M2muRbhaAlZ1RO4Pqs0mCPiA?=
 =?us-ascii?Q?JO7Et+OvSDjb5gt5sB8ZuBfm0wV2ozxvMmKRLzmp+V79zY5gmID6CPWrDKi6?=
 =?us-ascii?Q?C5AHJKKOOh5d+CXuUjNHc+iBaeY0lpkDFAUlTea7Zs0Icf2Xrb+fBRQvajEK?=
 =?us-ascii?Q?lDO4GupUpi81+/vF1fULfHZ8+YC/JnmsdsK+CvBoAF3vU09sT9oQrDiZF7Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d313a5f4-c119-48aa-c904-08dced854101
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 01:52:55.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0025
Received-SPF: pass client-ip=40.92.62.11; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On 10/15/24 14:07, Manos Pitsidianakis wrote:
>> Add stub definition of memory_order enum in wrapper.h.
>> Creating Rust bindings from C code is done by passing the wrapper.h
>> header to `bindgen`. This fails when library dependencies that use
>> compiler headers are enabled, and the libclang that bindgen detects does
>> not match the expected clang version. So far this has only been observed
>> with the memory_order enum symbols from stdatomic.h. If we add the enum
>> definition to wrapper.h ourselves, the error does not happen.
>> Before this commit, if the mismatch happened the following error could
>> come up:
>>    /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier
>> 'memory_order_release'
>>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>>    /usr/include/liburing/barrier.h:68:9: error: use of undeclared identifier 'memory_order_relaxed'
>>    /usr/include/liburing/barrier.h:65:17: error: use of undeclared identifier 'memory_order_relaxed'
>>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>>    /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
>>    panicked at [..]/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-cli-0.70.1/main.rs:45:36:
>>    Unable to generate bindings
>> To fix this (on my system) I would have to export CLANG_PATH and
>> LIBCLANG_PATH:
>>    export CLANG_PATH=/bin/clang-17
>>    export LIBCLANG_PATH=/usr/lib/llvm-17/lib
>> With these changes applied, bindgen is successful with both the
>> environment variables set and unset.
>> Since we're not using those symbols in the bindings (they are only used
>> by dependencies) this does not affect the generated bindings in any way.
>
> That is still likely to break, depending on what changes in the future in the
> headers that clang provides.
>
> We can do this (or alternatively, limit the number of files included in
> wrapper.h; in this case trying to remove use of io_uring's headers from
> include/block/aio.h) but probably we have to leave the warning in.
>
> Paolo

I agree with Paolo's comments. It was reported that using inconsistent
versions of clang and libclang can lead to unsound bindings even they
compile. I would recommend to keep that warning till a proper
resolution, e.g. clang-sys provides consistent paths, is present.

--
Best Regards
Junjie Mao

