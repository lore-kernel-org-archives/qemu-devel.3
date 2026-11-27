Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB6606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=AoMC4SUr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=APlAzm/G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=A9Y8xk+XkRuYYH4afektXWPlVhgVQCkeSjPq8TyS5kc=; b=AoMC4SUrN/ODdLiCXZrZ
	vh1TyoZNm0Iq2thNKv0HOgyq5mxpQRGzec00ElHlcJWfSclrJX7LJrwLnA8C/4mjJ1ry7hryZqqGK
	S8f7KFbLO6x1cs5f1gCzMhPmUBu46IsazuhBbTqqDJ9FFWvB55C5TaM0ha/5pdKDwDMNfntrwNjWF
	ThUJSG0BU19GxZG+tCjAhdG+ZjgTpYyKMbYCo7nZXtdO4Ha+zrv+fTbFP2bIzgRNL3E3822dHDSzP
	ZdnBaaohHqvju/q4JbsP5H0wOohMyl7+Mdel8sa8KYc5OCiW3+osh0sR5L1LtGSX/4qz9wS8+Gp0D
	MojN0+3pX24vuw==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtdc-0005rW-8M; Fri, 27 Nov 2026 05:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtdZ-0005qe-RD; Fri, 27 Nov 2026 05:57:05 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtdX-0003ML-33; Fri, 27 Nov 2026 05:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=A9Y8xk+XkRuYYH4afektXWPlVhgVQCkeSjPq8TyS5kc=; b=APlAzm/G27H32AH
 vrXVwCbTZ5AUxjp5Q/AKe8DXn2h8fwqO906dyLbcWcJv1xRbdy/clbY7XjLpGnonWG3GVBUxEjrdl
 r/w7xfieXgGwpilaSP8zXK/AZ7BVeeUR2Hc0CDhS3CHj/ffqVQm8ObgO1maQq+bwpUSIeDqnHKHF8
 08=;
Date: Fri, 27 Nov 2026 12:03:25 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/24] accel/tcg: Widen TranslationBlock::flags to 64 bits
Message-ID: <awlUl2by0PPZ2K7N@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-4-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-4-philmd@oss.qualcomm.com>
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
> 32-bit host support was removed in v11.0.0 (with commit 372ec46b9f
> "meson: Reject 32-bit hosts"), so there is no reason to keep the TB
> flags 32-bit. The wider field fills the 4-byte hole between icount
> and tc, leaving sizeof(TranslationBlock) unchanged. Widen
> TCGTBCPUState::flags too.
> 
> Feed the upper 32 bits into the TB hash, and adapt format string.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  accel/tcg/tb-hash.h              | 5 +++--
>  include/accel/tcg/tb-cpu-state.h | 2 +-
>  include/exec/translation-block.h | 2 +-
>  accel/tcg/cpu-exec.c             | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
> index f7b159f04cb6..819b594618aa 100644
> --- a/accel/tcg/tb-hash.h
> +++ b/accel/tcg/tb-hash.h
> @@ -63,9 +63,10 @@ static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
>  
>  static inline
>  uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
> -                      uint32_t flags, uint64_t flags2, uint32_t cf_mask)
> +                      uint64_t flags, uint64_t flags2, uint32_t cf_mask)
>  {
> -    return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask);
> +    /* Fold the upper flag bits into the cf_mask slot. */
> +    return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask ^ (flags >> 32));
>  }

From what I can tell, while cf_mask ^ (flags >> 32) does increase the
probability for hash collisions it should still be extremely rare.
Currently the only possibility for extra collision is with the riscv ALTFMT,
BIG_ENDIAN, SDEXT_STEP fields and CF_COUNT_MASK, from what I can tell.

IMO, for the time being this wouldn't cause any real performance issues
compared to say adding an extra word to qemu_xxhash8().

Reviewed-by: Anton Johansson <anjo@rev.ng>

