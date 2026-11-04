Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF67606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=mMbX+/Cm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeIk-0000YM-Aq; Wed, 04 Nov 2026 11:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xOeIi-0000Y6-6K; Wed, 04 Nov 2026 11:57:28 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xOeIf-0002IV-2v; Wed, 04 Nov 2026 11:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=S2Adz4DuKHdvXgFEj5O7hmtGklRu6hR5/KezOFZG0Hc=; b=mMbX+/CmaE4GVYi
 KtmZC4ZIrajRD1sDW2GoagLXw1u0CqnLqhSVJPCBNUp4o4lgDui1ccBXqYwZSSLTnByhs+cW9RdMq
 q4b/JwCatMTghshqHZ504HkXzvcoIJY2p/hm/vTqJlSbvlJrUW8MVed0ZZkJBm1LVEedr7/s/fqRy
 VM=;
Date: Wed, 4 Nov 2026 18:02:50 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com, 
 milesg@linux.ibm.com, qemu-stable@nongnu.org, Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] target/ppc: Fix pmu_count_insns test in
 gen_lookup_and_goto_ptr
Message-ID: <autk1tEzWZ25WfA7@hive.localdomain>
References: <20261104163854.87398-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104163854.87398-1-richard.henderson@linaro.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04/11/26, Richard Henderson wrote:
> CF_NO_GOTO_PTR is in cflags, not flags.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 46d396bde98 ("target/ppc: enable PMU instruction count")
> Reported-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 467b8f3d4e..dfd09b66ff 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
>           * tcg_gen_lookup_and_goto_ptr will exit the TB if
>           * CF_NO_GOTO_PTR is set. Count insns now.
>           */
> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
> +        if (ctx->base.tb->cflags & CF_NO_GOTO_PTR) {
>              pmu_count_insns(ctx);
>          }
>  
> -- 
> 2.53.0
> 
> 

There is another such check in 

  static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
  {
      [...]

      case DISAS_CHAIN:
          /*
           * tcg_gen_lookup_and_goto_ptr will exit the TB if
           * CF_NO_GOTO_PTR is set. Count insns now.
           */
          if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
              pmu_count_insns(ctx);
          }
  
          tcg_gen_lookup_and_goto_ptr();
          break;
	
      [...]
  }

with that one fixed as well

Reviewed-by: Anton Johansson <anjo@rev.ng>

