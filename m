Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DBBC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40t7-0001jV-AW; Mon, 06 May 2024 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40t6-0001jL-7m
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:08:24 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s40t4-0008NG-Dt
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:08:23 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so1155244a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715011701; x=1715616501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KnWtSa0i3KIC22jrc/RFjA9eGqWmEwUzgIqunk9UqpM=;
 b=Ix5Ob9p4DMc90Y3ehnO9KoZDVgOk5MJ6mAKA8xIlJk/ELFanKX/jqg1WOV0EGCjxHA
 kDVdtxqgPCQ8Zi7RoFjhI1OpLJbpqYpGNBEjZaSg5luJBLKpiEqj30136/lQM1EZ7mWn
 OdnMsYBIT4wh1TmUM5TPTGh+6KpV9XCvHCAeNj9tLE5vdlalRtVUk+XqP5FFnfLW4K0+
 oo1Dnv9nIDqQyQQ8K8WUX3r6jGrKUTpWtaJ6TQCsSoy/Wzo0lZbAGAMuX2Ko86HIg+6y
 2QalrJ4YjIoWqsyUECeF7h/FhEDPyrYHAvWPuVUCTW9FksjZbeE2wGFPDukbB2ksF2fO
 5ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715011701; x=1715616501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnWtSa0i3KIC22jrc/RFjA9eGqWmEwUzgIqunk9UqpM=;
 b=gPdJJniW6fuH7TVOh9e9ifc8c5dQo/KOAdYijUoUKJqgIxlCcCCyEvSawjc7XT17Np
 bScxk81b907E/ShhtrjKweQRgEParmio/HUap1eFz3+Q9C1Xp6x19jlmKoSpXHvSXu6Z
 4vfbtneAHW+nbsqRAFwWeoxBM8pNznnS3Pqdrncz9RdK2Q+40N3dQeE3wM28bnnhRFcM
 jYPPgMZmG6y7Gr8AOCNzLcZHRQ5jbS34qaNpJ9sB4DBnEZJbWN6ib5o82AKUSPIdxjxW
 iv64gpzEYe/vDGYGDJbOByccYOFOwWeWJ1PIvChYXilCTdxN3BqXByhjBhk46fF28HpX
 kHVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL46tRSW4ArE2vjc/0BP3jCGgON/zOZeQ4E9nrAgtXYYN72FW4CwRsqU7MLxXBHwAB0vau6vuH9oxuypMkRzS0X5ro1qc=
X-Gm-Message-State: AOJu0YxkXw+vFz0mejbyhsjGV9oUynPSbriWbvdF/ZdGFXSwgugcuOum
 PaU6E1fx8SDtTAp0hzGOh8PvX8Zj14zcJ29un+MRbhwdrN+XSafzHQP5GPHrK16L3WIykr2UU8f
 J
X-Google-Smtp-Source: AGHT+IGM3F3kMjkZDOFqr+HNQ+Cay5HkdMbM54j4jOoOpHIe7sZ5MfImDnimPpvb1WiKF1q7pPBDeQ==
X-Received: by 2002:a17:90a:fb41:b0:2b4:33cd:172c with SMTP id
 iq1-20020a17090afb4100b002b433cd172cmr7681256pjb.48.1715011700571; 
 Mon, 06 May 2024 09:08:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fv2-20020a17090b0e8200b002b30ed21a96sm8241497pjb.11.2024.05.06.09.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:08:20 -0700 (PDT)
Message-ID: <e1019e1e-3678-4882-9cfb-f4747d80b9a3@linaro.org>
Date: Mon, 6 May 2024 09:07:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/25] target/i386: cleanup cc_op changes for
 REP/REPZ/REPNZ
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> gen_update_cc_op must be called before control flow splits.  Do it
> where the jump on ECX!=0 is translated.
> 
> On the other hand, remove the call before gen_jcc1, which takes care of
> it already, and explain why REPZ/REPNZ need not use CC_OP_DYNAMIC---the
> translation block ends before any control-flow-dependent cc_op could
> be observed.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 3f1d2858fc9..6b766f5dd3f 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1242,11 +1242,15 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
>   }
>   
>   /* XXX: does not work with gdbstub "ice" single step - not a
> -   serious problem */
> +   serious problem.  The caller can jump to the returned label
> +   to stop the REP but, if the flags have changed, it has to call
> +   gen_update_cc_op before doing so.  */
>   static TCGLabel *gen_jz_ecx_string(DisasContext *s)
>   {
>       TCGLabel *l1 = gen_new_label();
>       TCGLabel *l2 = gen_new_label();
> +
> +    gen_update_cc_op(s);
>       gen_op_jnz_ecx(s, l1);
>       gen_set_label(l2);
>       gen_jmp_rel_csize(s, 0, 1);
> @@ -1342,7 +1346,6 @@ static void gen_repz(DisasContext *s, MemOp ot,
>                        void (*fn)(DisasContext *s, MemOp ot))
>   {
>       TCGLabel *l2;
> -    gen_update_cc_op(s);
>       l2 = gen_jz_ecx_string(s);
>       fn(s, ot);
>       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);

Ok.


> @@ -1364,11 +1367,13 @@ static void gen_repz2(DisasContext *s, MemOp ot, int nz,
>                         void (*fn)(DisasContext *s, MemOp ot))
>   {
>       TCGLabel *l2;
> -    gen_update_cc_op(s);
>       l2 = gen_jz_ecx_string(s);
> +    /*
> +     * Only one iteration is done at a time, so there is
> +     * no control flow junction here and cc_op is never dynamic.
> +     */
>       fn(s, ot);
>       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
> -    gen_update_cc_op(s);
>       gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
>       if (s->repz_opt) {
>           gen_op_jz_ecx(s, l2);

Ok, but only because gen_jcc1 does the gen_update_cc_op.  The comment is neither correct 
nor necessary.

The reason to write cc_op before branches instead of junctions is to avoid having *two* 
writes of cc_op on either side of the branch.


r~

