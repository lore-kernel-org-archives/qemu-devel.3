Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=eeq5LI0N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=kWyUOQ4U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=GPVouLGevLSWxqLjw8NiOPwOwcncssKQsT+NsrjFUoI=; b=eeq5LI0N0WL0eiSK+4ct
	s8DW9CN1tHZcW+MFkd+SZTUedBU8Ws8I82tqe9vtPboCiDKGVBmxUgyk2TOhBh+W+0/Q3Fziq6vti
	6eK9wsVgMfD1GAvbBzjuHEeVhZyvD5XuIywrfUOKL0fW1FQFYs86WhvcUmj8lZk7j+e3a+mhaTsvl
	90W+XNpnoXWwI0eYjA8dpjKnYBxafOhlaXJ0/BFjqxT40mP+9cWD17baZAHJB4+HufxCheJhJI3vO
	3PV9ujtuNBwSzQ2MxrDc489oG9HVYUUSqxQ7rzsZwSjMaI0AMXhxUHhbVFuP9+IJw1sANLjCZWzVf
	aw/Ao5dG4tNggA==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtqy-0002xn-0D; Fri, 27 Nov 2026 06:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtqw-0002uQ-88; Fri, 27 Nov 2026 06:10:54 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtqu-0003en-PR; Fri, 27 Nov 2026 06:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=GPVouLGevLSWxqLjw8NiOPwOwcncssKQsT+NsrjFUoI=; b=kWyUOQ4U6I6k5gM
 QuopY2iHZlgUGFRzMfTqc6EVdE//cIMKw3cgaVSUcYp/TpZaBgyzALwzJIx5MFEahkgA+e36b0RO7
 xqZD2sVXIIdlo//miC+/fudDOagkBj7VEiON0OGLuNfeo+TEZWdsHfcCB26aVjrQsplAcoquwoN22
 VU=;
Date: Fri, 27 Nov 2026 12:17:12 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 12/24] target/microblaze: Use 64-bit TB flags
Message-ID: <awlmnoGFV3Pj-0r4@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-13-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-13-philmd@oss.qualcomm.com>
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
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/microblaze/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 8b219afb5dd4..4c869f77f5c0 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -68,8 +68,8 @@ typedef struct DisasContext {
>  
>      /* Decoder.  */
>      uint32_t ext_imm;
> -    unsigned int tb_flags;
> -    unsigned int tb_flags_to_set;
> +    uint64_t tb_flags;
> +    uint64_t tb_flags_to_set;
>      int mem_index;
>  
>      /* Condition under which to jump, including NEVER and ALWAYS. */
> @@ -1668,7 +1668,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>          /*
>           * Finish any return-from branch.
>           */
> -        uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
> +        uint64_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
>          if (unlikely(rt_ibe != 0)) {
>              dc->tb_flags &= ~(DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
>              if (rt_ibe & DRTI_FLAG) {
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

