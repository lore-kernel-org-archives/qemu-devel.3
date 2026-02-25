Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F64FFCEE81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCmS-0000hB-Ht; Wed, 25 Feb 2026 06:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vvCmC-0000T1-7M
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:59 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vvCm7-0003jX-BC
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hYCPg1Ylk9AECOASmHIRA6nBfytJGJ7iWXrWdTMRHSY=; b=bo5RrHAQSLBaxXs
 ZyrkdpCTwWbBkOrf+wKVJYxVZ3XbwZOLTffgbuMLnB6SvP90pjpOGXuGqCZTQB7JXKAXmp1Qf1wb+
 lQavWQIP7gVvf+xopQ7mD1qGokXxXhlgaPhl22YHObtMvI3DnK8yJQWpwahKDx/tlw4vpAsFK/eZT
 8Q=;
Date: Wed, 25 Feb 2026 12:13:26 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v6 7/7] Drop TARGET_PHYS_ADDR_SPACE_BITS
Message-ID: <aZ7ZQ3J8RSJKBxRL@hive.localdomain>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
 <20260218-phys_addr-v6-7-a603bf363218@rev.ng>
 <07184078-fd62-438d-ae60-47c71ba46fbe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07184078-fd62-438d-ae60-47c71ba46fbe@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/02/26, Philippe Mathieu-Daudé wrote:
> Hi Anton,
> 
> On 18/2/26 18:21, Anton Johansson wrote:
> > The macro is no longer in use and can safely be dropped.
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   include/exec/cpu-defs.h       | 3 ---
> >   include/exec/poison.h         | 2 --
> >   target/alpha/cpu-param.h      | 3 ---
> >   target/arm/cpu-param.h        | 2 --
> >   target/avr/cpu-param.h        | 1 -
> >   target/hexagon/cpu-param.h    | 1 -
> >   target/hppa/cpu-param.h       | 3 ---
> >   target/i386/cpu-param.h       | 2 --
> >   target/loongarch/cpu-param.h  | 1 -
> >   target/m68k/cpu-param.h       | 1 -
> >   target/microblaze/cpu-param.h | 2 --
> >   target/mips/cpu-param.h       | 2 --
> >   target/or1k/cpu-param.h       | 1 -
> >   target/ppc/cpu-param.h        | 7 -------
> >   target/riscv/cpu-param.h      | 2 --
> >   target/rx/cpu-param.h         | 1 -
> >   target/s390x/cpu-param.h      | 1 -
> >   target/sh4/cpu-param.h        | 1 -
> >   target/sparc/cpu-param.h      | 2 --
> >   target/tricore/cpu-param.h    | 1 -
> >   target/xtensa/cpu-param.h     | 1 -
> >   21 files changed, 40 deletions(-)
> 
> 
> > diff --git a/include/exec/poison.h b/include/exec/poison.h
> > index 21eed4c54f..ffb34faf28 100644
> > --- a/include/exec/poison.h
> > +++ b/include/exec/poison.h
> > @@ -43,8 +43,6 @@
> >   #pragma GCC poison TARGET_FMT_ld
> >   #pragma GCC poison TARGET_FMT_lu
> > -#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
> 
> I'll keep this line for now: it might be useful for rebased forks,
> helping them to notice they need to update their cpu-param.h (we
> can always remove it later).

Make sense, no worries!:)

