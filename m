Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A831C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH25o-0000dh-0X; Mon, 19 May 2025 11:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH25m-0000YY-BG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:07:50 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH25k-0002q6-8J
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:07:50 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-708ac7dfc19so41820947b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747667266; x=1748272066; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gXOesR3SEtU8F0M84hJr3NYCDfVUGyS9aJHZrCKHhc=;
 b=UNz4pOR+zHr9x+g5pijbgJvd64adNrOzRyED+b4lT0wegPXwKBnAn98d7LzXdaylk1
 Ta7AkFodTw+TFQbCuAxlbOxCeqqZy2wYKUqhAhHtDvkN9fISlcTUk2DuXCnlt3UdGml8
 cnFug8GDyrKV9rBIPGBx5UhH9eCHUrPAhZep7l9foQCm0iHso4fn3irWUZzRXgcbk/IC
 wSg5UGT6WQPR53o0N3FQ+4niF4Z89Jxzke8rOY457SwHFylWjG2YFEZCEFslEXbmcC8j
 bVT7XnHicwp1S9PO4Fdkle+3ErDr57yhjDU/KlMmQaarUSQ79ReoNZyhSEnBPui3ZM1H
 Tz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747667266; x=1748272066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gXOesR3SEtU8F0M84hJr3NYCDfVUGyS9aJHZrCKHhc=;
 b=Cyb6G4fWCGn31l2AfZl8e8Od5tOvo8KIgRv86GF2JGWRUTR5t9b7YB4+GI/NdJiXlz
 N61OBiQXLNKKiMo6jvUUb6s7dhYL7DMBrtjlxD/9tCIdX5+kdLHQe4/poJLoBK/wsznp
 7Y5VVp3ak4/dDLnlFSdKfkPYupcRXaX/mO8r/s0U/3bnEWswroC5ypXy74+yMKvs3KyH
 tip8NRjmzXZex1xuJ9qVKZLUcy2Qh9jjXZO8sexh47PKZBNpkpDKYZ1vjaYMdIe5VseC
 TE6wItVL6lz/DrpJ++31glSyEq3J5RBQdxa4nLjKiH1A5GmXighJ34+lacwy044iPuGJ
 mjIA==
X-Gm-Message-State: AOJu0Yznmh0jwuuvgv3u/J7aQJT4gMNdkqPcHUr0yexTwzB1tNlFbz5o
 YRQhkPH+9SW3r3CtdJJQB3EImIV3t/lZCg9UxSKQ7QOt5iyDTbjPTcFkPr1LXrkNxLSgyMuDdEX
 CkLvAJ9V8ffPcLfqwkn05oDRAugZcvZW6up+97b0B7w==
X-Gm-Gg: ASbGncvsNvjPqUQTnlMZ7erSSYyyIBLxnXY9Q+EYPEEuamSL3OTAdqXE0voo8N6WB8N
 N2y6K6Lwc1FTwKtgaHN98I2rvd3YE2Z9iBWjhkS/brQ3R1PBYyRNsUwHJgbplab5L21WBdJ9yu1
 hKUIz9xtrCslkPPwKwxErcQ2PdQWkVrHtaMA==
X-Google-Smtp-Source: AGHT+IF4UsKvwriPiBsIgFIaM7sRVvlNfHXsvSmaqMDQgndCoaVydVQEN1J4Xf0rjK4Zc3XviBD1Kc4pu5rXpjKSUcw=
X-Received: by 2002:a05:690c:650e:b0:709:191c:d7ee with SMTP id
 00721157ae682-70ca79efe46mr181951707b3.17.1747667266087; Mon, 19 May 2025
 08:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
In-Reply-To: <20230116223637.3512814-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 16:07:34 +0100
X-Gm-Features: AX0GCFuK1V0kvDMuXtEgJwzazuOzM28zbz6xL_xMq_eUtpdRcS2NoD5K8trUqpU
Message-ID: <CAFEAcA905fCuyqLR9UK5Tz5tNkFAS07epcKzVOgbNXpbd75F0Q@mail.gmail.com>
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 16 Jan 2023 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Add ability to dump /tmp/perf-<pid>.map and jit-<pid>.dump.
> The first one allows the perf tool to map samples to each individual
> translation block. The second one adds the ability to resolve symbol
> names, line numbers and inspect JITed code.
>
> Example of use:
>
>     perf record qemu-x86_64 -perfmap ./a.out
>     perf report
>
> or
>
>     perf record -k 1 qemu-x86_64 -jitdump ./a.out
>     DEBUGINFOD_URLS=3D perf inject -j -i perf.data -o perf.data.jitted
>     perf report -i perf.data.jitted
>
> Co-developed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Co-developed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230112152013.125680-4-iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Apparently this doesn't build with current head-of-trunk clang:
https://gitlab.com/qemu-project/qemu/-/issues/2970

> +struct debug_entry {
> +    uint64_t addr;
> +    int lineno;
> +    int discrim;
> +    const char name[];
> +};

> +struct jr_code_debug_info {
> +    struct jr_prefix p;
> +
> +    uint64_t code_addr;
> +    uint64_t nr_entry;
> +    struct debug_entry entries[];
> +};

> +/* Write a JIT_CODE_DEBUG_INFO jitdump entry. */
> +static void write_jr_code_debug_info(const void *start,
> +                                     const struct debuginfo_query *q,
> +                                     size_t icount)
> +{
> +    struct jr_code_debug_info rec;
> +    struct debug_entry ent;


../tcg/perf.c:250:24: error: default initialization of an object of
type 'struct debug_entry' with const member leaves the object
uninitialized [-Werror,-Wdefault-const-init-field-unsafe]
  250 |     struct debug_entry ent;
      |                        ^
../tcg/perf.c:157:16: note: member 'name' declared 'const' here
  157 |     const char name[];
      |                ^

I don't understand what's going on with this flexible-array
name[] field: we never access it, and I don't see how we
can sensibly have an array of debug_entry structs in
jr_code_debug_info if the size of a debug_entry is variable.
I also don't see why we've declared it 'const'.

Anybody want to take a look at this?

thanks
-- PMM

