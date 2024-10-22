Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322F5D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34nH-0005ND-R9; Mon, 21 Oct 2024 22:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34nG-0005N5-Rq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:38:46 -0400
Received: from mail-sy4aus01olkn2082a.outbound.protection.outlook.com
 ([2a01:111:f403:2819::82a]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t34nF-0003nD-Dx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKOro7f9iVuYpKAzQeHC3L9N3U9rcEZo+9AdldxBsC3v2oQDPK+5iN9UJCcD48b5b0N8jiuJfbggl5JQ4q/zxuOk7pbUdlWHt/hHDVLnc+4NpLS1Egy1FQcp+0ZYYm978W20hIEwV8ih7TdIWJXn9iY6+DscpveKFUa/34ODk2RvaxwDRkPNJAZf9eWcPiLKim8u88+dUT87/Gik7B1MeW2sVpU4FVSg52naU3WJV4Rs4UEz2ccIr0eQrJc4UFYJ3/nGTXlKUgicBf+QGSMdWUu0ooX/AFpoAVw9iAJ+FI1SmECEVecGOFR5dmJHijZVzp9cFbRxu70BmHS5LDIwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5FPZtbJYFbq9bu7s4xw5HH3SrB9Rz0F/ncGSX7O7Dw=;
 b=NJXaZ88D3GsqKM1CVixt+kJPuITycwDWcH6RnX3+5e1U4rgarEyZEowENT+yndrnOJwVvuZFlZTcu1CqfbPhOvJj7nq/MVO9PaqU+7EEy6gQ9qN3SZnE5xJXC6JDw72tUjUs2drHYpumdN9hWEqWXdWf2gUbs854Lx+Ja7yfQJBwLKjZ+ynVwY6FjLH41M0t7U95o7T0tADTeJS0HcBPWJDObIyypoUfbmBsbe7RLQxrWm0+aS8gCFyoBRdMlVlyzoPGare9YFlFGYwuJwAEdPM8LDn6CF2PfKID8ov8pbmESHjxLlrcml9kSAr554Grj3/1Pazym0QmK9U8PqgmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5FPZtbJYFbq9bu7s4xw5HH3SrB9Rz0F/ncGSX7O7Dw=;
 b=ZLPMdrd3idgUkbgaz3dzxyxKOV7EwuuUH63lvd2y/Rnt7J15a2OERsqwpDbcebul9LUFNsdkdLJzTU2TKO1Lkp35qLjEmhBlV+agA4NeEUPU4A0Z38Lo5KgOyPKwtWtBm5iu3rMX7ZBp+MRE/7SGEX8Gsp65XJXLENqg1tAuBZqdzSgawQQeR53uinbkrfenUSHV8nt/QgXc4DVlbk/AJqMFr89pegxwRS56iAKHFNJB/Eg5Lm06fgU+HD65C8cbFli4GKTOtIy6W8Mq9Ud4i5DsMLfZWvSJoCw7bMOw17JCWJx3CiJ3Ro/CCS5ti2VJlykvUONG6BPrMCPpy90+3A==
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
 by SY3PPF947566139.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::4a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 02:38:38 +0000
Received: from ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166]) by ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:6e2b:b854:7166%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 02:38:38 +0000
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-5-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 04/13] rust: do not use --no-size_t-is-usize
Date: Tue, 22 Oct 2024 10:38:09 +0800
In-reply-to: <20241021163538.136941-5-pbonzini@redhat.com>
Message-ID: <ME0P300MB10402B8EBF79571A4BA194FD954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:231::14)
X-Microsoft-Original-Message-ID: <877ca0svyz.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB1040:EE_|SY3PPF947566139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b90d5e7-dab2-4e5c-6153-08dcf242a1f3
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799003|5072599009|8060799006|461199028|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: ZMQp1T6LEbyEqKXHo8eVzcZmsOOijC4wT1gTjVWUeBTjjRgVIaYt70loPUIfNgWD+Zi0r7usl5SNZI/cPIm9/hL/Sp0flNBmXxX46Jspd1HfdrNqCWkLVAjx8FicvTPa/0ygZ6/PK5FyXJGcxInJ4Ni99FwlOKdrMvUe3x5+EjnblenMy0NeOtbxrjS787zTr8FgR1UdxdfggLt3Kuei2VsqKd+xGTLtpkqYuFzAR19N5jKjOFPWU8mPhQN4889/TmDkTD2vjjsrS0m3zXzZZnVxzPbtfnX9Cnqwj7NapTC7ElpRwY99hAJCs+bNSidmz20GBY/1yyTFqhjNQksGk+Z8IeXuYKxNQf9wHjlEii62Y60bERsEJgmvqCK+q2q1ahNwtOubMktOn2swVTSbrS3UU/3ER1HUODAJxRzc/kAvvcZjA2ZyVZi33qzqguwS8qK2UDX2Vu3UQr4WB6vLnIKxi31CHHp666+uUWG51W5kv97FHWXhXD/aK1zAoOS1BEKedeAJ4e7kdMEy5q86MUNA6OQxRVCGduQj3KOt3cL7+pCTy2kWrJRS5OH8C4IsUUjqA+8dm6qugoIb8BFA5tPHt4e40jPAwP0S0yMSNlpSzjr9Q6RIfd1A2Kra/XhCq6s3eTGQx+Puj/+tysJAvfqBjhlbdSkHE5/wO8pX3o9pGNIONLR5cyWsHv3iX1E1rWILp71M0kHDbs80RNSdQZloSkeJR13KzhKs2C59Ks0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRKvCf9370BuPK8FPr2YgtccmOB6DHn4NsI3rTuoF1+61C0j6e29D7TzMPud?=
 =?us-ascii?Q?cWvX9cEBm43lvw7gXGJ6q/ZXO2F4QEVV7G94ZkE2RBsMd2Cs3MMFSu1aHWA3?=
 =?us-ascii?Q?FFvxWL4TN0PAf/icjvUryqH/2GubKXG60rLNbAAaGf+PHLOxsilqUfSVtFYM?=
 =?us-ascii?Q?Gky1Esw/IpjGFmZ1Z+iywAXhEibnlLjEeabBku0oIALN2f5aI9agdeeZqkOu?=
 =?us-ascii?Q?vngPC334jB1Uq+GtuwaB6S4GrVFANy4bvRk5DbHt+NqsJuEiatFr+ztO+Dpz?=
 =?us-ascii?Q?iBhTJXE/p4o8G3+kf79llIK45ao2MZqFbA7aPcvlWyaX4nN+mMsEc4O1Fsxn?=
 =?us-ascii?Q?zQ4u9RpsVkPR7pPqwjVf9Hy92Vsbp0rdKOSwC7j5YDIRQD3zmK3tRHPAioxj?=
 =?us-ascii?Q?oiJvE6Gl5YQpz9Vl5u3y44tJHm2HJwmU2qIBmAzLCeb2c/PJt4FfVt7EDzlL?=
 =?us-ascii?Q?HhlHj/rXiTjmKWwVWEZN6KXnYMdY4tH0iVH0D+aG2KHgWORao+g2qdlhPVWK?=
 =?us-ascii?Q?yf1a5JCMa7b55GsUFXZp0FEBOdKf9DZMC/Mrm1mKn7qe/zykfAldb0V4BDYv?=
 =?us-ascii?Q?qQZ/uc+0mNqM6Upl72RXq9ya+BPejab1ZhcD2ufa1fvH6TRlKy2DAzLUM5p3?=
 =?us-ascii?Q?WyF2i7llqWOjPCpXH9p1LvD6+TxFCv1TFiFC13DBxtTba+WZytOhl/yGRr2O?=
 =?us-ascii?Q?EpH2NCqsDgZQUY8nSuIN3vSiBRVV4VDjA5arTui9748o37Wxu5dcWOrwXXgE?=
 =?us-ascii?Q?dWr5Fkz/+XNtpt00OaaQIzSgVkqJnNYzVTJZzNqAHL4Yu23rrep9t6J5wZRM?=
 =?us-ascii?Q?Fgg7UJIvArLyeln9c9G1Lg1fp23sVcQC80SfxihqmnWhnmGyBvMRXE7adS3R?=
 =?us-ascii?Q?nkudTGju+k/uRIcHOsXLy95uvSX+97pBbDJ94hoTdwz41ymLxy/rzRm7+Upq?=
 =?us-ascii?Q?Qr1AJ/tkoNfvdLbaXBrdZn6M7Azjy5YOboXYdpm7JoPRHpRalzSPRZQD4rfo?=
 =?us-ascii?Q?mhXaNv5mt128SOSwIKxWnI2xcCqtSBzLRbvPPu9fMZ5FJd9DBOZVe79APNEA?=
 =?us-ascii?Q?MzjU2jUhzmfev1kdnPe03g4iYSYOWa9gDDJbqzUL92LpdVIUUJDFrONRLjee?=
 =?us-ascii?Q?bb2XE6cCZtlxJ4g5M9l2W2/xN5dcIRu61U6nOh9LIAy+GYmFp/yYBlP8/bhp?=
 =?us-ascii?Q?8o24EimRZKWPm69EAp7wngOGrZLgq8go1Jjn6nv9gaCfFHnVZbt+ySdVwBI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b90d5e7-dab2-4e5c-6153-08dcf242a1f3
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:38:38.0640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF947566139
Received-SPF: pass client-ip=2a01:111:f403:2819::82a;
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

> This not necessary and makes it harder to write code that

This *is* not ...

> is portable between 32- and 64-bit systems: it adds extra casts even
> though size_of, align_of or offset_of already return the right type.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

