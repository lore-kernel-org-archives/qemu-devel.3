Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C06606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+uzuvCc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN01y-0005hw-6u; Fri, 30 Oct 2026 23:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN01w-0005hg-EB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:45:20 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xN01u-0004SZ-PY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:45:20 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3acc7a0b558so327341fa.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793418316; cv=none;
 d=google.com; s=arc-20260327;
 b=gqAcEJLl48bXE+86YOmy13iM376pTTS3WY12Z2SUMt79C+TK74xD6lGMvqtxEZAFKT
 Hen8oJL3K4/o2wXSjE0JKkvM2flz9VUa4oYrBTEA7fbJ73DphdM7GvotgA2Gk/9J0J6j
 1zwUmru4EvJrYwizE2U4A7/QY9yzBUTYC8+odfuZMIuiMYeXllujydL3dhDGE+IYDYl/
 /A+ZKTc/QYAxFnY/n7/4isgoT8tUuCN+lCHQIYC9qGxcawvwTNZVrWziIPgWjum0fCZH
 6ZJo1oJX36ZybjJa9R3LUI2p126OJsXqfJ3XjXlxspujocSNpaXcTjnNgLXoby33Gi/Z
 JdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F6FUAHfJNmgj4HE3XgmNkbOFq5v92Yzc1jQXHXzlNXw=;
 fh=4SkwuoYsohTajnS9ThUOqh8nRYX1V8duGt1952VKGEc=;
 b=ia6sF9ayX67XPEVLqF3qiDkMbeGYK72F/4yldkAo0XclBpDDtJzqS1FRCMMjnsH9RR
 AwKKyCDi6YkHkVxkIuiZSa1wUARCY4OWZpRkK25CIaw6lU3MPnMRwzappyKxA0ehZtjP
 nq7KyFZWb5qEVMUv/b5W7YAPg0Trui1fWnSQrlKhqQ0LHgDaPY9qRW20450On1++2Hid
 BHA/XteavqcCnf1vw8JQM0lIXopYhZtBCZAxyJGx2uZSoJZkNCn5lqh7QPlazsfl4ncL
 9NNJmrz7PpOcj9qP4+caNbG+YOJoT64bheVLmATSqKftAtCDYeznLJCWbl8olUtOirj9
 B7Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793418316; x=1794023116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F6FUAHfJNmgj4HE3XgmNkbOFq5v92Yzc1jQXHXzlNXw=;
 b=w+uzuvCc5OcwSqxpUyFBoMxC2hX9TLh2lABMfwWjbGxl5Jj7VXMsWSk48gW7H7OQRQ
 S2Qy6MpBRfyrrtV8zz3K5fJvKFE2evvs+Ex8mrwl/kIznNc5G+x2a/ioorD8hurHQCo4
 s5KTARR8DbIJeMAHI6aD4h2WbAzdb9j05F33A9/ctC+Py+RHPMLcaxEqlyKRvIXRbjsZ
 dEg/oF4R1LuI1yP+cadAVSK72m+QsM08Wx5mey8Nmv6ug++OaEId4yr9hg/7hex02b6P
 EuJBTna/rsBb7GUxMi55+4H16Ca29kOqjUCqG6Irtqzqa71B3jd6525ji7yts6fQH9xp
 NlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793418316; x=1794023116;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F6FUAHfJNmgj4HE3XgmNkbOFq5v92Yzc1jQXHXzlNXw=;
 b=Rf7U1sj6oV06e3LIcoyykTtx1X0Xe2ApuH8Uoa9eITXOjqRPJolCpBC/YrW2pVMHg2
 j4u4OoxGJt6giZmwF0zj4lJ8IhanhXHT9Mnznuu2yTHr00ADHvK2vi7np0DQx2D2c3q3
 Pu2gNLr+SbJvqBnsp72lxXS7z5575gZa0eAsbxrf9NkPBMaUUA/6YdVqT/G+79Y4Hb1R
 Qm968WQuNXHNA3Npcy5pM7h/2/xz229PaKLS2t5IRjtzuOKzhRfiwKDnmT9/26w3LABI
 88SSLilWMgbiSJSX7TCwUxAq9bYhGZtvaKjHue/e7rtncEkXHLLweQ3FyySQYOsxzVCk
 KxfQ==
X-Gm-Message-State: AFq9FYJS5H/UNuPqgVSLclXhqZHNa8rlHxbheQDZidevcVYh+xhrXHKE
 oDymteUjdCZBJ9In4Mu9wHO6L/YPPCN7/DIULK3Ie0tiM90xoeBcRkOGuoiFcjZzuydKqR+yIsI
 VBc16sgoq5ao6IGLoMaMTreQ2eob4AWR/paXKBLk=
X-Gm-Gg: AYBFou1WmosS7M79RZk45tymKkWqy2N+V7+mHL2LLI8rcxNi+TCyn8O3/7fBPTUDqBp
 TEZLCEGEU8GpCHWZSpHQO8+MJiAmE/et3v4YnDatpZNwpiSUNJiYVIK3ZAyI4cXQeaY3Ub+dQMB
 oWPATbq5hcAuc71M6vkXuP0MKm6CjrEy/iDNybj2nuwtLaWOJtEFbM1EKf8BpU8YZO4pWaORxLE
 1WEmQ53Om5EdPSNrw/CZQq6Af+ffIqQRVNG+YvZtp3SnEsqB0oG8cLxtFUTJ0RvS3YRfI7LAR7L
 04A/MyYvrsj8Udt2tYLPnYEiti7q1/7wt3fzks8GomqHXvat8TSBbRZUxo2KmwNU/+MIGjMacsz
 sey/bK0C42P/vWaskGrDSEX0b5YlHuoS3HFHheBooo2A5ivwYPLBUHANQw22V7e7g16H/Ub54nr
 l6mzVi5GlPpJUWCxnwlwYE7vHDWU1sqp3ijOf7sCVcqIiTj+0ShY8E
X-Received: by 2002:a05:651c:4216:b0:3ac:418f:332 with SMTP id
 38308e7fff4ca-3acb7b269cbmr7750271fa.23.1793418316403; Fri, 30 Oct 2026
 20:45:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030185551.193092-1-richard.henderson@linaro.org>
 <20261030185551.193092-8-richard.henderson@linaro.org>
In-Reply-To: <20261030185551.193092-8-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 23:45:04 -0400
X-Gm-Features: AclHuK9KgbdD-rWSy79f3jPLOgVtXR0ccdqFV-HBp7-IxQlp6E9lpMAPDlwmCJ8
Message-ID: <CAEdQ38HXrausXZonjOk-zZvM5MFMSmygMVV42ApGCY3zZdd5QQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/14] accel/tcg: add CF_NO_GOTO_JC, set while a
 breakpoint is present
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:56=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Both already run either on the CPU's own thread or with it stopped, or re=
ach
> another CPU exactly as cpu_single_step() does, which is where the previou=
s
> patch put the same kind of update.

"The previous patch" doesn't apply anymore after the split. That was
my wording, sorry.

> In system mode gdb inserts breakpoints with the vCPUs stopped, so there i=
s no
> window at all.

True for gdb, but not for BP_CPU breakpoints. On ppc64, spr_write_ciabr()
inserts one from the running vCPU and doesn't end the TB, so old blocks
keep probing each other until the next return to the main loop. That's
the same window as goto_tb, so I don't think it needs code, but the
message should say so.

> +    /* The first breakpoint takes the CPU off the inline dispatch path. =
*/

The CF_DERIVED comment and the one above tcg_update_cflags() in
include/system/tcg.h still only list single-step, one-insn-per-tb and
nochain. Both need breakpoints added.

