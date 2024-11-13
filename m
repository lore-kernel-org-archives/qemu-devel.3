Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43317D41C27
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBAWP-0001Mf-SD; Wed, 13 Nov 2024 05:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tBAWN-0001MS-NQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:22:47 -0500
Received: from mail-me3aus01olkn2082a.outbound.protection.outlook.com
 ([2a01:111:f403:2818::82a]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tBAWM-0001fj-7h
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:22:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0ukGSL20keqCB/2SlP9P4ItAESOfBDKlDGoh6bk/WwUcBTUKkaQBZNngDV3seEsYn0jvKMgfDITbTWGAE+kHBqEZl/VKvg0nD4ieKVM95Fjx42ay1m6pfaykjfnAqyhXeQpd0/h/ckamhi0jIgERs1qO2TpFVJVwQVes6FkfKoQFCeZNQgMlI2gNwdtIdAFhLbWt/CqFR30Hlgz8NZ1ueFxfFFdQrcynpekBOipay9TDvkjzK4epm2mWB38qg5tL3Z66zGniiwMNfLbIFa27Q5HCbpk6URZAipbwMQt3BOcRAyxC9tttXieRbeocNbLwcbq8tELjJj4ILck/S8M2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jD+Inb5q/rvxLxpU/9ric8tNLsGYn0vdKISOXQFQGg=;
 b=wp1nr0Y0S8xj0KuA4XbS9AOFu0/zosKl0ave0remVWQ6Y6tckV0CYPXyFHG+O1h88p+hjWImwmF+NAabxfPTW2R6WMfunpmHjzYGMVDWfMlsESHf/P67R8TQYrb57pc1aPv9d97DDf0WeZqdHuHyq8Ofsby/wYSvnmKLr3R2xJ+Un06sgGb39TsbW/fvxJSA/VUIpbeKZiHp3mDGMtrZStQo2XArejywZ3TgY8QtUtk20+Gr83iBOv5x0A0tXLa3fLil/gaYbU8GeM0HH881o61ce9OPfQH1b4pjcSoqvYd7pxGUveOcScsAXLrmbpWiUeT/NhM7n9FXJ8rGWjXbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jD+Inb5q/rvxLxpU/9ric8tNLsGYn0vdKISOXQFQGg=;
 b=Kd5nZEgI3yyCeJncq06SiYA0rqNEjM0PiH37USeaeLFeNN+vCb/oHCcSA9noZDd0NFMGSxmiD4IQlol6TAL1tlwHfpjYIJhYu+OSHfwTagI8VI/pe4mkAFg+Julxau3H5CJWIsJE6jnn+4IhhL6uJJJ7wWCU4V3dRqkvQVFOcISHUIRmbzWzL4VhINjz0WgnEpqz7UmE275tgHnyoJwC2fhuKCvp042+RO5gzMhhAVlVDuXNBCPA+g1x7Vdf125lbC2FX6fs1P6JFRbFUQltSNqRTJvpzmG3wasqmb4Rb2aBeqcS2Qk9oz5egsVSetXKC/xW9LCiJifS5/BXmwaKSA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY7P300MB0259.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:23a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 10:22:37 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 10:22:37 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-9-pbonzini@redhat.com>
 <ME0P300MB1040EF4DBFD69EC355D1A708955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <6e0f3ee4-0e79-4d26-8ffc-10c893ee8614@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 08/11] rust: build: establish a baseline of lints
 across all crates
Date: Wed, 13 Nov 2024 18:13:59 +0800
In-reply-to: <6e0f3ee4-0e79-4d26-8ffc-10c893ee8614@redhat.com>
Message-ID: <SY0P300MB10267B420D8C8BAAF80A4E99955A2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87v7wre8m6.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY7P300MB0259:EE_
X-MS-Office365-Filtering-Correlation-Id: e22ae155-ba19-4c86-e9c1-08dd03cd17e8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|8060799006|19110799003|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jPFs8DWaJk/NREbX6orjjZXGMaWvdcrBmsCUCx7HLXBCJWLcPHPcPYOlKfoh?=
 =?us-ascii?Q?4VnOduail25nb1oSi2Q83+f88mD7peeVaqYL2Yme/dj9SazV0i9tEIS2AmcI?=
 =?us-ascii?Q?W7hkne1n69ifB9/1mML9UVNXrPfuEREdygARPvp9UQ/E5pc7AFWO8Pfmxo+0?=
 =?us-ascii?Q?8DD+m8+qmlJ2z5svh9/28+RLBAZ1vmHO9LbihBXwBk/iRERVf7g0eRBd0p03?=
 =?us-ascii?Q?nT5ieyhzX5Wi/b3W6DeFalD3j2mrzJmk96MsjdCnTbCExUEfpjLjsWn903Vt?=
 =?us-ascii?Q?dFJasyi4PenZqKD8GL3k+tQ4Cu78RkNoOjsisSAwGBeXVu50+ZbKsYLQBgM3?=
 =?us-ascii?Q?QTB3xfjAx7KvSh+u/J8Q3OiNPlSqkBcESq3/4cmFXOKMvrL+1LMuQfIRRjGE?=
 =?us-ascii?Q?Bz2gdU1sNedgg35VCVmcuLlKPCUD3btqIM+VZUZSrsaJFAyuPPyherwnzMAx?=
 =?us-ascii?Q?9AYH2yeZR6Et4agi4SGRKmQzCPp9KfQ5UItG4vEu69mCKyXncBlvp770nwPm?=
 =?us-ascii?Q?bO2oV2TLja/9NBTWhCyzErgPC4YOOkOr/Th3TS07Xe+qyuMIg13TJW4RFGk4?=
 =?us-ascii?Q?EYP0qeCJDC0Ol78SnlwDEjbaMrFs+JFB4enF6uB2w2bJtr+6vxeSDbOUbbZg?=
 =?us-ascii?Q?XhyBZwZxbkQo2faGRmCE3biWdhmQJjFrh5AfpVAeTeYJm97guprUY02AZRpC?=
 =?us-ascii?Q?+EcZlFLYpDWFqvyv9nLmRb1Q5qFr1909xYxip90Z3GQLmYzriDI2yx8kdhJx?=
 =?us-ascii?Q?LLQbzB4nhdekgE8waxaYmpcnEJzY2augcf09LDgJE9zsyObGSxl0eIombAyu?=
 =?us-ascii?Q?DIYe5DRuEFF9DJ9/QTO4qlT7fwDTu/1TApXcUfIfF8hg25Nkn1S6EEWk6Ts/?=
 =?us-ascii?Q?CENrUAIHIoAWh0vuiXqIxthDQO48LA71X6mYbM3H8GxoL0gBydE/fam28PQy?=
 =?us-ascii?Q?z7vmeXvmv8Ba4UiedQ+C5pmWF/uXzbNsjdBGOKcdRVFss5xCoaQJigXGELK6?=
 =?us-ascii?Q?EUp4GrG9rKQc+/0Er3JorTmxu60PSiMfEyWN1UG91n/w81c=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtKfAVngD4w4X2SckyVaedib9SaSFDi0ekuH127ZoflM9tmWAdkiFaLChExv?=
 =?us-ascii?Q?Vp3D9sBZTUJ9xlJsxklWhqjgtKaPN5rbrl4EOU9B67k4U0f8LXsee7IqtZpx?=
 =?us-ascii?Q?kz0dplu0MNz04U0KBfKsdP1vsJ66HOhbMD9xurz7rDqrVUJz2etK/B0hFDU9?=
 =?us-ascii?Q?be4U60w7WCqIiay+Fu37Rd5xxW6Lh5lMDlCmTBry9mdKjpxpe9nEcqtcWVDZ?=
 =?us-ascii?Q?R2wIXMnjyGvqAVf79sLsJBwbibEOb+al3p+nUbGZRtAJ1xtWLZ5WZOK+cEaR?=
 =?us-ascii?Q?E/UnPYU2Zd8LOwV+mxjnb4MfkH9BBDMMRThT10GQkYV4ADL4K9TUqppyNadS?=
 =?us-ascii?Q?eG4RhGIAwZE/5DkmRmnbxRIzgh6BsFCE84jXr4Fuc3IASa0MqbScMyGSkC+K?=
 =?us-ascii?Q?LI2VAFw8MP2JoYdylzu9nvIDB47NdVbQ8jXRG1FwjKnapG3esJQ73UPfSrWW?=
 =?us-ascii?Q?UW3Bz2F90cKrT7GuLx7Sxco4ZvUWzZ8wBihvc6k9FvFRevlVsn2UysWKyAQE?=
 =?us-ascii?Q?6Pkm/ZhWZp5PzUXRQuifqsqAVrfKKfafRgnPxDtoSzkse+mlkiuEqPxSwLU+?=
 =?us-ascii?Q?FgHMBNA+fvH+LLNxIcawyGrhAzR1DS3EjQRKqyRLYBaVVwFzhxhn2p/fZB9I?=
 =?us-ascii?Q?H2CLoXlJS4rcSZNKQ78sFjKUDj6R8UMDatiqZXLlCJnOGC2QU3FMI/j8p6Jl?=
 =?us-ascii?Q?TMKd9dGakX+vYEHqfrwj7a2/ynjPUO5TQ17w5yjLhPNhECmArQzTITSOamH3?=
 =?us-ascii?Q?wprnpd8wBqczeFHvu3Sf1ubm/Vux4EJqCbmNfcxejYL/qnxsIo34hEN+nxb5?=
 =?us-ascii?Q?UabieBdhxk013z04lSiu0xosraTNz4SSKUmY5MtYnIAKYJFjPWTkIpM7iST2?=
 =?us-ascii?Q?+QhQ1ua/5uYyTC36LfI4GZcmtLgpWrPuKvnNzlOXV5dQiZw+TSLMTrNcDSb2?=
 =?us-ascii?Q?oEYz3BE6R5OVtHYsAv+7J/KfkHx3ygdK67IPU/07/XAfJpBjT3PQv838VSFs?=
 =?us-ascii?Q?5IuqIga/wnsV03J/gBDXaPZ6315XpH2K5uuZ2BfUaBzZ5Ga0SknP1Vn2qL6w?=
 =?us-ascii?Q?wqZAf4xO98YBlelvcvrKI6LDHp4QoBdf3LoW/Wg9ar0VDxLVNwXtrmZbzNsM?=
 =?us-ascii?Q?SzWiHojH0rnsI7xDR61gylExujclR/btv+Uha3mhxMPaisUTk3wZP9Bt7ZBW?=
 =?us-ascii?Q?hap1K9nUOv928w58UrHJ+OOeVDLd+NeveGuGjPauQ0ol9PmO7dAo4BRWL88?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e22ae155-ba19-4c86-e9c1-08dd03cd17e8
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 10:22:36.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0259
Received-SPF: pass client-ip=2a01:111:f403:2818::82a;
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

> On 11/13/24 08:14, Junjie Mao wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> Many lints that default to allow can be helpful in detecting bugs or
>>> keeping the code style homogeneous.  Add them liberally, though perhaps
>>> not as liberally as in hw/char/pl011/src/lib.rs.  In particular, enabling
>>> entire groups can be problematic because of bitrot when new links are
>>> added in the future.
>>>
>>> For Clippy, this is actually a feature that is only present in Cargo
>>> 1.74.0 but, since we are not using Cargo to *build* QEMU, only developers
>>> will need a new-enough cargo and only to run tools such as clippy.
>>> The requirement does not apply to distros that are building QEMU.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   rust/Cargo.toml               | 66 +++++++++++++++++++++++++++++++++++
>>>   rust/hw/char/pl011/src/lib.rs | 18 ++--------
>>>   rust/qemu-api/src/bindings.rs |  6 ++--
>>>   3 files changed, 71 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
>>> index 1ff8f5c2781..43cca33a8d8 100644
>>> --- a/rust/Cargo.toml
>>> +++ b/rust/Cargo.toml
>>> @@ -19,3 +19,69 @@ unknown_lints = "allow"
>>>
>>>   # Prohibit code that is forbidden in Rust 2024
>>>   unsafe_op_in_unsafe_fn = "deny"
>>> +
>> [snip]
>>> +
>>> +# nice to have, but cannot be enabled yet
>>> +#wildcard_imports = "deny"
>>> +
>>> +# these may have false positives
>>> +#option_if_let_else = "deny"
>>> +cognitive_complexity = "deny"
>> Just to confirm, CC <= 25 is to be enforced for all methods, right?
>
> I wanted an opinion on that.  option_if_let_else has been more of a pain than a
> benefit, sometimes it suggests code that is worse or does not even compile.
>
> So far I've never had any cognitive_complexity error show up, but pl011 used it
> so I have kept it in Cargo.toml.  If we start having too many #[allow()] for
> cognitive_complexity we can remove it; for many of the others, instead, we might
> even change deny to forbid.

Agree. The most common case I have seen with a high CC is a long
switch/match statement, which should not be too many. For the time being
it should be a useful hint for complexity control.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

>
> Paolo

--
Best Regards
Junjie Mao

