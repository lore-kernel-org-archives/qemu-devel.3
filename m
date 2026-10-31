Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWwVM7K3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN03x-00065m-GH; Fri, 30 Oct 2026 23:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN03w-00065e-18
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:47:24 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN03u-0004Vh-Cs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:47:23 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3a9e87ba696so10517141fa.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418440; cv=none;
 d=google.com; s=arc-20260327;
 b=c3qWLexaRlns2Y+tg45AIkOn8piyt09AfTkE97rkqFdUiVfDjyFbBL22TB3v2Ckj2k
 PHTfPaJM+1qoEAnQ3jY2Hh3Cufj7eHVxMlqBJhNXSs3CgGsJuHoUdFcBR3P64ASOx/+V
 vm8+XgthSqizN6I97KU3WJ2eeCYsu6nAsabQY0eOSpZgoAFgS1asTlDMDYbJUdD0aPPn
 v/gxG8RHaEPtZQa0Ai3Q7hbWzXP5tNtnWzKAqUQEWnDHSXcguGZrtHiS3XokuH8AkaZE
 WlmnFubeXpZuF/dZAtmHZO0TQiX2NVyIh/NYIEyIQQ7kdC30gP3F5+gWgYh58UbxUFO1
 Pbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FnXm10rtDzRvyNRirsY3bL1FmAg6/9/rARD30hM8gR8=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=RgMBU1IKY8/ATDikfBV6OJ/GN3qTMzA35XwU+3d/oayMFVbe6soZz2CpW4+G+UfJT9
 T2ji3QRXELlMlOOK/p68cKzygEMIkRvMSLGVAC/h+FJjZuuUVOW7W/ikYhqPlG2awWZG
 GIW54EfhfXfAekO8Pi58Qc3Lksb3ZM49CtHxPgzcEw/foE5L5qU+7d12OeYCFSrlQ8EY
 J2Ls2UWyuquW7oUMKXvaMnHY2F5OT6LbQVEQ4NSL/GMbw1gdy58Yg6/x7FSZ70UFgjSr
 A+Ycpx8r2ORHM8EUJ8e4HoAYktgqgvDDZks8JXc564cUg1HKqwVCD52yv2Y5NsCuS8h7
 5GYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418440; x=1794023240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FnXm10rtDzRvyNRirsY3bL1FmAg6/9/rARD30hM8gR8=;
 b=FWwVM7K3E0XxkR1QX2QhlM47v9jAElzZB1aQUbNOMRuzvCMuWDrtb0N2z5bTmFBsmY
 xpENve5XZ6+2an/n7yXQI2pIp9QTC5+xZ4lZyVgS3yPU/rJbXb5FWQAbo4GS7B2zzpLW
 XWt3WBFbAtjooi7yj+hK+i5xN5OYoZwJ3zgu49qSDkK+aLterWekrZP2DGvoLo3omRyv
 XJxWm/D6EC7Fp1RsbnKI4mS4dDDnvAJaSU/rkayY0ayJ+W1YFvrbMPP+fCc7ROes4g9s
 jkCGMxc1VnUNM6UpOnwoC39Cfqp8VAEb2zRV3KHT4k84yUc/MPNFfGB8/zijqPIlqJXg
 VPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418440; x=1794023240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FnXm10rtDzRvyNRirsY3bL1FmAg6/9/rARD30hM8gR8=;
 b=CZuILNFTi0y0WxHWce2tHKNruVeT5+89Z0zovf/TpVGF44uebL7RnGEsDArIr44DMS
 Ua5A2hoxBadTQ0dCAvJ4mOLrQ4ONZMUtOLj7A8fXWkPC3WGUEI5sgfCStKDo7zP5Dxqm
 yfHieZYK1oNSV3VzQoSdl7fnKkSO8eoJPNQs7xD/ZiQRJsoFOofwvTNno9+K/9kAQnil
 UG0rWtiPtSSir8vnVZm+5zA0oAHHih1x4hJscO0Yz0nmoHnukQhZuQjy++AuLrTnBent
 Fzq/YDg8/jNr/rfU0MHT4heMtSShN+q5WQurwdV+Y3/5eZXo0FJ0jJLYMvTuPJupcZXH
 8PzQ==
X-Gm-Message-State: AFq9FYIS9W9wm+CiHNcv5aquJnzD8zLv31arH5S00Q/500+/LDsJUMI/
 TlC+QP7IewNssKrUdz0l/wUdGs2N+Poio+4MiTFfZ//VgUvnv+RAY/UJiLneujh6HIbWzju+NrB
 AS27Qxf6A1rMvMeH9dqZpVyqLOe5saE8=
X-Gm-Gg: AYBFou265QszL8WmD4MIP8JPBPk1ALtGacIJErtFzrigYF7/dJ6+7eSezXox4CxZ2pA
 qLf7rptV709nEIS0P9cLA0yn+tyISimnEb3/QXlbOo0v5t40LuJ3WbF3vW0c7CopazbQahqfsGY
 UkSM3Roim1auDTbPvGxPDT//ia5cC1uVSQk84JS/FtCq1uuP86LD86jz8CNiZtTq6VOVZSovLjz
 Bin9aSiEOIlUiHjnR7c+s/w9ZFSTxOpr301rl8QJmA1n7t2ylwR6Ba3jx1KpexuK9ftj1oEeLpe
 y0a6a2tiRH5v6Rvmyo2A3wo8Yi3Te8BhKkaGzSNIqd992NcrCfRVrh6Rpnnf/tGNC9EDy7IOmay
 /n5VbmHwKOUJkUaot6cdSnxnHJiCyHcm74R8RVcJ+eZtW4XV3msuV8OhsXKpCi6+PjA1aJD4SdN
 dlpCzvTqMTw28j2Ia/eqqSi9MvVr1W4A9w6gU1CtCMKyJ3q2Cvird1
X-Received: by 2002:a2e:b88b:0:b0:3a7:6d4a:1c9f with SMTP id
 38308e7fff4ca-3acb7aacdebmr9710401fa.15.1793418440276; Fri, 30 Oct 2026
 20:47:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-10-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-10-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:47:07 -0400
X-Gm-Features: AclHuK9BwbWludaNZiYPYtzDPpoFQwg5JDiSKjm-uQTzKOZx27TBVyX9zL4_TTI
Message-ID: <CAEdQ38HhRhnCf2k=rvwVz7g9fNNYo_vHgwf060wZFUZyNDLyuw@mail.gmail.com>
Subject: Re: [PATCH v7 09/14] tcg: Probe the TB jump cache inline instead of
 calling a helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> +    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_JC) {
> +        tcg_gen_lookup_and_goto_ptr();
> +    } else {
> +        plugin_gen_disable_mem_helpers();
> +        gen_jc_probe(pc, cs_base, flags);
> +    }

This drops the CF_NO_GOTO_PTR check for migrated targets. Both the hit
path and the slow path in gen_jc_probe() end in goto_ptr, and
tcg_update_cflags() sets CF_NO_GOTO_PTR for gdb single-step without
CF_NO_GOTO_JC. cpu_exec_step_atomic() sets both, so only single-step is
exposed.

The result is that stepping over a branch doesn't stop if the
destination is already in the jump cache. With qemu-alpha -g, on a
200-iteration bsr/ret loop, one 's' packet on the bne ran the remaining
199 iterations. Patch 8 steps it correctly.

Honoring both flags fixes it, and the step trace then matches patch 8:

    if (tcg_ctx->gen_tb->cflags & (CF_NO_GOTO_JC | CF_NO_GOTO_PTR)) {

Second problem: a probe hit skips the log_cpu_exec() call in
helper_lookup_tb_ptr(), so -d exec and -d cpu lose every inline
dispatch. Same loop, counting Trace lines:

    -d exec            205 at patch 8, 6 at patch 14
    -d exec,nochain    602 at patch 8, 5 at patch 14

The second one hurts most, since nochain exists so that those logs show
every TB. Taking the logging case off the inline path restores both
counts:

    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints) ||
                 qemu_loglevel_mask(CPU_LOG_TB_CPU | CPU_LOG_EXEC))) {
        cflags |=3D CF_NO_GOTO_JC;
    }

The monitor path already calls tcg_update_all_cflags() after changing
the log mask, so it stays correct. The comment there only mentions
CPU_LOG_TB_NOCHAIN and would want updating.

The commit message needs a pass too, and most of this is mine:

 - "What is left is one_insn_per_tb and -d nochain; see below." There's
   nothing below. one_insn_per_tb is fine as it is, and the logging case
   is the part that needed covering.
 - "the flags, cflags and cs_base ... are constants at translation
   time" is no longer true of cs_base with goto_jc3.
 - The last paragraph calls a backend opcode "a separate series", but
   it's patches 10-13.

