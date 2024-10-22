Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A09D1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CeQ-0006QS-Bv; Tue, 22 Oct 2024 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3CeE-0006Pq-Sd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:02:02 -0400
Received: from mail-sy4aus01olkn20821.outbound.protection.outlook.com
 ([2a01:111:f403:2819::821]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t3CeA-0002oF-T2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkzzrIXYN2vR6S4viIjUWQVZbASg0l/kAN0lknFHm5uk3C33o6I1+2RVRHUmNy1Twvheyx4EtRIL3lf6TmW4Sz0NW7mQhLwM8A7AFzE5cvmJCaoFXd22O81X5NI6+RTrg30TjUYu0Dqu/6qeUwKDbIGqkG1LOj8Bt9uj3dT8JxKFaEniwnMRBaMkNfI9Calqw/GkiCjCJx4OYRy9B+/i4S0CzG7/MPDBCSh2ZRtv1KbcOKqVZt9fM+GXXzar/LaRyyVL1eCrYCXGJr2jJ9cWTKx7XtsznxEbAhhIa3Dec/BXJQlZH+v9zBPYNLzKG1FxsEy5S1sz371nDKSSPNkbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J98VIzpuqyO3G/cwZ5/gdfr/4vU8ZAXhcJH/eATC1NU=;
 b=y3WTuX633key6OfwXXsz6aPZvOohMJOZ1kSISN6csx+L3mXtE9fHjuUpKYFTavP/IrWy6ClE+ibc52JschOE2guSxTHObjAMNKTHuwqqUKRGQz0sX2hHqDqxOafof5YizPpvYew5wrO2VejRg71uXJoZZtHpzGoLE5lgbmvZi7hCW5PBgDw5pfBEtupfVTEtTmwD7uUqD8uObZZuOc9XRMlFc7Ut8eVliujhANX6bYUvihmFihStgQma985W1Vkc66nS5uomLa9R59OHyBNPzmkQsyfBCUtUTljuDcB4RtXtr/AgmFyTi07jIK3oOqGC8WGp5TmCKP8ftNWttijeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J98VIzpuqyO3G/cwZ5/gdfr/4vU8ZAXhcJH/eATC1NU=;
 b=TP21yZbQxURlCID/EM5hxFWDzzw7FfOOvutQA5MthjIdTOitXGwM07ZZW5zvuatWN8/WyxHjT2hl6Gz78qtVccFptbS55UCWuwgLNosIcnxDmgVPtpRmQq6T1q5PfnfJSbkCLURmbnh14hmLJHXsRm7NxLOHVMdMrqfEL2YH2wPwl+3rGIj8KN5KXKQ6GsaeSeVd2wy5ORe9zw7/Oo31KXqAoO15+zKU9O0UuTceQL6wAxVItgsuBhSjmbRrQWNJaYTLMi5fga7OmXQgmqDNs5uGVmCMo29+jc0NQ3gOcKn3T8Kju3Bj+h2T5+Yg9e6JcWOQsnc/gYvQVb3nFmcApA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0570.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:291::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 11:01:48 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 11:01:48 +0000
References: <SY0P300MB10265AA07B530BB674A6D1C6954C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2] rust: introduce alternative implementation of
 offset_of!
Date: Tue, 22 Oct 2024 19:01:05 +0800
In-reply-to: <SY0P300MB10265AA07B530BB674A6D1C6954C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Message-ID: <SY0P300MB1026F26F12D738293EA92421954C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87plnsqu3z.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0570:EE_
X-MS-Office365-Filtering-Correlation-Id: 029c5f59-ad7b-4903-440b-08dcf288ecaf
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|8060799006|7092599003|461199028|15080799006|3412199025|440099028|4302099013|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kvY0Isb+Ft207zVM41W6HJCxjsMMbgNONTuqZsbCtFHN04j/qu/jowAu/AGK?=
 =?us-ascii?Q?HGbQbT8bbZxtiQhGbSF7kDOgJkbUN1BYKsfn4zxTWGzV+iO7NPl3sWaz+SLH?=
 =?us-ascii?Q?tbBfaug5UNKKKNLdQxts6uuzeMYHQRdaNJyToK7An/G/5w6uB4cxH5tnKPDE?=
 =?us-ascii?Q?za2zzC04VjZv1e4MSuZK41DaUD5Q3OqELC6Nq3vchJfhEJZCH1GKc0fiAXgd?=
 =?us-ascii?Q?FU2/QLE9fH/RHsJcIXS/9yYyyU+V1rygk9LDHn6TtBILI7/U8sUDmjBRTXXk?=
 =?us-ascii?Q?GH6NpGMDpXuP3hxJ+u6zf7HAa5Cg4Te9EPd8FeiCnuKIbHffjUBN5MbSRFF/?=
 =?us-ascii?Q?mJ0piGiHcjsYmHYJjO2rUBtbMHVYtocSZs4TlKXyajMbmvlKD5WWZzr0wk1p?=
 =?us-ascii?Q?NIHySHHV1jei8iacJFkdiLdpLZG/+ACccXWvdZDni2nDDGVv/WBDtlLcIE1z?=
 =?us-ascii?Q?mzHtEpn2PicX5NGoKf0AHvMdx27bQcvAe0ldTR3z6AGOzd1DoZ6xG4/vJhE2?=
 =?us-ascii?Q?7Abq3fi/YKWtzRR2LM060PtX6t6o/ikB9/1iqXdkbHuY6beJnUgug0ee4Rg0?=
 =?us-ascii?Q?tqs47VDksG77Ea4QzP170bCeKK058pGkLrAV099q7YKU9yfDQbMfZ6/kWmgz?=
 =?us-ascii?Q?oletXaHRRYGqmaf4L//6wv7igb9Rq5mg3ZbNYJDtSIXj6iYwifPXFKyZAuoc?=
 =?us-ascii?Q?leb9Zu8+MTBJQ0pr+tfXBnw1VtHATCeQ2+bOkvKhXYxhlsfYp/SVb567HVFY?=
 =?us-ascii?Q?lIhEhM54ygrK4pyYrkAf2kldf2nYc/WPsUJ8gGdNVO5v5a/7K52UNlg29Zkd?=
 =?us-ascii?Q?BjTNXdG3QtuRasuTzA9+Tfq1bCD+Vl+zubZbeFYVkaKKVi2sJ6nAhFa5pK39?=
 =?us-ascii?Q?571+eMfWWmGyfrJaGb39wBumD5Me4o44lxTEIUtaBGv2usS4bYTGc5e9ZKD0?=
 =?us-ascii?Q?nn/vbP/q3iNJJymfvnTPrg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3OkZYdWBqmjrSEBq4CRv9Dmf1HScPWNXcNVeRp08SkZ9G4/OLyfDxa+Jw6zZ?=
 =?us-ascii?Q?teB3hLUFuucfb5xHiYMoxUKAQLJ5S/ZMq4Vp7C+7IVcf3ol/Rwl9QVvNaoV7?=
 =?us-ascii?Q?KUs9EEw4ivcT4U93ZUAd6IFlTKnXHiTFZrUJ/SioT2w2LfK0L4w7bXaK1XK2?=
 =?us-ascii?Q?4hzys59lecwBErEGnmINxLgydq5pBX/29CQO0HT+XOPlFiG4R9pYBWBLhsY7?=
 =?us-ascii?Q?zgqffvhCNmS1LH3hKTAW3MampLavL7sN2E4M7JUedifleCnbJcUuPfdS4Q5t?=
 =?us-ascii?Q?6OG3e70IOvaa9X1GQDHZ49W4EgtTkCE4NJfKaJ8s3792/n31d9azN1auKMdM?=
 =?us-ascii?Q?mQ2P7m480kWZsyfrhhmBDhI/csWJNy9nxTtuGEoIhc93aBZkcoLbgL3eschG?=
 =?us-ascii?Q?ST9+x3riod4AgtgrGFS0kADS78ifIIP11wTrhtKqGHzSUx+PeiaN9jeITt0v?=
 =?us-ascii?Q?dBHo05UFAOnQpl3Mq7U6klfiVI69i0GN0DUJxxPyiWB0lscbFS5Ok+zmvljU?=
 =?us-ascii?Q?xLCLvqh61y7A/1ElR8Z7c0KeQKa8ZiI2kwgdkt0DzJvpuCYvqA1OoJ5Eaa0I?=
 =?us-ascii?Q?uw4zlAQLYKmzrSbGJc5gw60e2gLij+p6Iwz6ebzS8KB+uK0xmrkfLg/iIrq1?=
 =?us-ascii?Q?PsAMfoCgwPCdasRpAqe/slcB7F55YvPUJe9HOgeB1LVvDTGs9BA29ZSNIS+/?=
 =?us-ascii?Q?hSAR5qE4F5hEetWz/jphKJi/nXFfBhsJwiPv1jQchMpe9nabH/FUiDcp6lQI?=
 =?us-ascii?Q?CDzLx+YVAmcWwtYj47cRS2jHFpZhLMRNQouhkcZNxogfWS8Aj06YvkGSgF88?=
 =?us-ascii?Q?UFKG4RbGEjfnaIKNrR7NZE4qIwQ8V4RwRKBCJCzX1PFR3bt4mChi8z+we3PM?=
 =?us-ascii?Q?WxYPDMTPuacm1uZc0ysryeCWXX8zXwyPia3mn9lERGmCJo5C/YxhVW69jFKY?=
 =?us-ascii?Q?QkOZel5voOpZ+4YIZ0kGwbACPumGjal5x9cbr73TOrOSEf3pm+kS40LuQHCp?=
 =?us-ascii?Q?jl54inrf4fgJW46Zx1fKBra60dgR/qcfBaFciiUEPYJIeuYWG92KNA/jQKTY?=
 =?us-ascii?Q?RDyhBNGeb+w27uIDL/PgNSW0A9u5cv1pUmGUqpQzHSqFsT3DfWqkdrkcM0YD?=
 =?us-ascii?Q?lOmU8rhD6Gf8o3CLVCS57HjLMiiju3FfygveNgfiYfdxAx/A3VIqJNA8rLw6?=
 =?us-ascii?Q?i589aRtVq4a78d5T1vhsvWM5UgX8y5AU6bq59wm/d88+t0Nq0zxL1UJxi1o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c5f59-ad7b-4903-440b-08dcf288ecaf
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 11:01:48.1865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0570
Received-SPF: pass client-ip=2a01:111:f403:2819::821;
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


Junjie Mao <junjie.mao@hotmail.com> writes:

> offset_of! was stabilized in Rust 1.77.0. Use an alternative implemenation
> that was found on the Rust forums, and whose author agreed to license as
> MIT for use in QEMU.
>
> The alternative allows only one level of field access, but apart from this
> can be used just by replacing core::mem::offset_of! with
> qemu_api::offset_of!.
>
> Using offset_of! prior Rust 1.77.0 requires the structure to have the
> derive(qemu_api_macros::Offsets) attribute.
>
> Base on Paolo's fix series [1].
>
> Make sure to remove subprojects/syn-2.0.66 if there is an existing
> build. An additional feature cfg is added to
> packagefiles/syn-2-rs/meson.build, which requires meson to re-checkout the
> subproject.
>
> TODO:
>
> 1. For each type of error detected in the proc macro:
>     a. Determine the proper span in the error reports.
>     b. Add tests.
>
> v1 -> v2:
>
> * Rebase to [1].
> * The proc macro now generates a call to the with_offsets! macro rule
>   instead of generating everything by itself.
> * Use quote_spanned! when reporting errors in the proc macro.
> * Add qemu-api-macro as a dependency of qemu-api for cargo expand.
>
> [1] https://lore.kernel.org/qemu-devel/20241021163538.136941-1-pbonzini@redhat.com
>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>

Just noticed Paolo has a refreshed version in his v2 series.

Kindly ignore this patch.

--
Best Regards
Junjie Mao

