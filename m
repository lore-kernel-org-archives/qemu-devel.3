Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E9606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=URlj+Gwt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=uxRDWakK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=IWGYz5X+A50hBBqhIB3/pXYwW+JOrOFw+RQ4kYRLyvA=; b=URlj+GwtTvcrC3cLD6fT
	oAfO383muf4vhzxcKwDPZXvppVKxu/8yOKoCXHym1Gc0xCPpTChDxDAKzpLWqb/A3UXocQXEd8Ssf
	ABDAl+bB9ypeugW61lAeovxMbB7AazkYdugEXSTuRyEQdD3N3c0fVuuyRYhzOSF5MkEmjYBeHgpk0
	IQRxkTCR+xiMrc/IniWLWB98dIx3r3kJb/UsZ1acfq6a6FS5H7JStDIIMsTUADxGk18ozWYXgMH2l
	07KBISLEG/F13FjvYOY1MJCUM0TBtYCq7xC/54VVphSPMhkha3v9pD+r2Ff4sjb5CmSCX+JZOqF2A
	8zg0C4LFmUuFMA==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtjn-0001KO-EI; Fri, 27 Nov 2026 06:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtjl-0001I7-LQ; Fri, 27 Nov 2026 06:03:29 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtjk-0002RF-56; Fri, 27 Nov 2026 06:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IWGYz5X+A50hBBqhIB3/pXYwW+JOrOFw+RQ4kYRLyvA=; b=uxRDWakKdIre4Gy
 7aHQhVkGNhNwfV5mtFrZmVXqZb+X6TKjHRJyeP6INUEjKHgJZXOO2Fdelf4i+knVPD7/OMWsSQQW9
 z4yTWujbznmn1zV/jeQZaudawngY4PsO5B/bAe6Bk5UQb1mVjSnSXXx7r3orVlBm4ssD7Neu9H4F6
 bU=;
Date: Fri, 27 Nov 2026 12:09:51 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 04/24] target/arm: Update TB flags split comment for
 64-bit tb->flags
Message-ID: <awlk-bkO9MeBjGf1@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-5-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-5-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags is now 64-bit, but AArch64 needs
> TBFLAG_ANY (15 bits) plus TBFLAG_A64 (51 bits), so the split
> with tb->cs_base is still required.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/arm/cpu.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5ee9ebf352fb..59e44b76a08a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2484,8 +2484,9 @@ static inline bool arm_sctlr_b(const CPUARMState *env)
>  uint64_t arm_sctlr(CPUARMState *env, int el);
>  
>  /*
> - * We have more than 32-bits worth of state per TB, so we split the data
> - * between tb->flags and tb->cs_base, which is otherwise unused for ARM.
> + * We have more than 64-bits worth of state per TB (AArch64 needs
> + * TBFLAG_ANY (15 bits) plus TBFLAG_A64 (51 bits)), so we split the data
> + * between tb->flags and tb->cs_base.
>   * We collect these two parts in CPUARMTBFlags where they are named
>   * flags and flags2 respectively.
>   *
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

