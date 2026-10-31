Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C1606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etGl8paV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN06y-0007Cl-Sq; Fri, 30 Oct 2026 23:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN06v-0007Cc-4h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:50:29 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN06t-0004nU-K8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:50:28 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3ac99992373so10761721fa.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418625; cv=none;
 d=google.com; s=arc-20260327;
 b=ml2uDWKH+a03vGlzHjnxq8k6cou1pOrQ32PJu1W0KiV9s+Yf7mPriOEIyt6gcQpBNr
 0EeL8+IEhdvWfemsDtvjUU2sWQDaar7ZM5Rywx8fcjsIp5dYxb9bMERDQN/nS5XinGdo
 n4uiO5AEM7IRkYB9YQWaorOYkUCQDUI9dBQv1moolTbZhvbUFbDKqpOngNiV5swYoH77
 Oy4wi2Jhscr87difI26oI/blo0CU61LR8d+bE5yeCA/ol//bT811gtzNu7reOXe61iMC
 O4h6eo1CUUXn6f1VrQj+DiJvULeNy3FwZHpPdbGstM5ESJOXGnDWFkmOd1Cou54U66ys
 fNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jl2RQSGZWl7rIO6ZA4znwjvFtWW84huFaZlcr+jcEAk=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=gu5dF4wyM9l2yXICEgBhbvkbcLq46qVzaW7vDMbehsBPm/jqKLWwts2XGXjHTOkCUJ
 ePmrwVhqb68a4zbmGKtFVatEaVPJXTDir45p5KyiGMQhXfmCkEQaOwi6UZbMutMXfrta
 eaAT1ZbQSnI2I5evjOet3ewxZpmgckaeXQs48HuywxK0gXPUABI9mSR7nqhVUBQwt4GW
 LX/6cfJ3XyT4gJ/r9jB1wLDnBDcNbPOF3n10LREfNCCTznzeJhFyTIdvZagpoiy3ml0f
 l+dUHgNc/+yJ/klfg78wb57BQrigQb+Dd4lMoWWn4Th034cLX0zpmM+umF4YyN142Qkj
 8hXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418625; x=1794023425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jl2RQSGZWl7rIO6ZA4znwjvFtWW84huFaZlcr+jcEAk=;
 b=etGl8paVXGg6ca+SzhGxwnzC4inYUBgYit9zIa57CXE5z3f1DIN1DWrY2F4JKoK5kh
 W387yC2Qovchy0Dr5bKdMawnuFEzw4BqllLVIX2DWzp/atMBG6PfbrTcH0M56RvDq0Dq
 C6alJ94dc+35h1UUJbffDTSe+AdiMPX6lUs6IHDQDfl4ViQlPZ1nF+QPNzNeQCx7cwXb
 zdiSTs3P7umc21tUuADP+mkjxRN4UCy/4+xdvDJaGV61xV3UULHhVAVc3MZOIF6T7i7g
 gzydgto0m8ZHYRCfsHlETVUX0iToecNGylDtm5I4Gqp5w/2tKqjF6MdKoPzQRw8JVKav
 SNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418625; x=1794023425;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jl2RQSGZWl7rIO6ZA4znwjvFtWW84huFaZlcr+jcEAk=;
 b=1JM6UXJTay1JgQUjBpTdPv4gNF5+48oTGTaxptTYK6EG6AzoP6tJaGQv9HAwXZl9E5
 vo3Ty/hFYQ2Orqz6o9DBPqlvzrSAZdx2i/qP+Y+IVDhO3APNoN9CTyCTrbK7XbYH4i2Q
 HkSjfKtGtscABCzPPOmQN4GWzMpwzbd2X+dS2zTgdSmJUK/HQJZlaXvJM754fFPZnrNf
 9wFw9dYyLWz9dYYlJ/4rSEcPJx+I9e3cHv7qXraq26CrjmRizZwPwS5Kg4rcXtzcU/Va
 iBc8BfMR4VTaHYuA+osr+lGlVinjs3FfyxgOt9NG/0MhQDpQ8s6Etbs7am/B7/kRvyZj
 cyRQ==
X-Gm-Message-State: AFq9FYLxrrjqXQEOzEu7ftSlL7W13nEA+kxsaCZKKRueoofVfRC+L32J
 3yKk6MGjta+kHn6jbJ77F5cc78wFtCLQBOhXEzryFku1p1LZiayCi7jLCLaYRo5GHBd9mUkt9NT
 8N8cixc4sF4A3GjyESCHEFFYJuYCFlur3FoO71Lc=
X-Gm-Gg: AYBFou1TAcTI5spCaTpBgXI3LsoDqb6TrgkF7CVG8CwnxnMjXTx0z8xxbsrXaeXR6J0
 cbITtIjhMG+BnoMhf2DV1PiJEJISOtNCL0ai3daGPHzXL4vT6B7UpYWu+Ih40cxuLWdDd6d/jUn
 s3dE9GWpuxsJK2P19uI+7bicYc175+o6EN8nsXVFZmZpsrKczbcgqBLkVeiMTRkimiNxkVAYbEM
 OxVAgcQy2vvyvBwGIjCtTtKNvZIls508Hxn5dd1ig5QwtvJLBJOVkm8JwfxD6YVFBJFE7Uv9ufg
 wwcgc3saLc1DA+sdoZa/oRcQFit7vwJwIPGg1p+1ApT1i2WnKbz4uWwe7daE+TdYpWgmXU45FKy
 1Db/DhiFJhTH86L6AWYw+Tmayxxa9TZieV1sjR8vDm04yx8zISg3XRW9bpQp6KLqHuvo855vTqp
 EbE8osYEEXUO/pX60W7vyVw9zxmhmRQ6vZpKnyrbV5GuoyZj6bGA2N
X-Received: by 2002:a2e:a988:0:b0:3aa:fa3e:21bd with SMTP id
 38308e7fff4ca-3acb7aac86bmr9689871fa.12.1793418624636; Fri, 30 Oct 2026
 20:50:24 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-14-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-14-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:50:08 -0400
X-Gm-Features: AclHuK8HQlfA6P6nDcpF68zY0pscvIQ_Xa59uVkOZig3W16AzLIIV9z-x5FQziM
Message-ID: <CAEdQ38Gq-d-j0F6yuzaDq5xbe+WJTjjOtv8mayKZj1UamiCL-A@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] tcg/s390x: Implement INDEX_op_goto_jc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x232.google.com
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
> +     * block so r2 may now be clobbered, and the input ptr * is dead

Stray '*'?

> +        if (ref =3D=3D *tb_slot) {
> +            tcg_out_insn(s, RIL, CGRL, reg, tcg_pcrel_diff(s, tb_slot) >=
> 1);

A question that also covers x86_64 and aarch64: this comparand is read
at run time from the current TB, and tb_phys_invalidate__locked() sets
CF_INVALID in that same word before it clears the jump cache entry. A
constant could never match an invalid destination. With the live word,
an invalidated block can match an invalidated destination until
tb_jmp_cache_inval_tb() runs.

I think that's harmless, since a TB already running at that point
carries the same race, but it does differ from what tb_lookup()
promises. Worth a comment if you agree.

