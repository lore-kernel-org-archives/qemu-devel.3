Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB5CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfcy-0006FS-RN; Tue, 16 Jul 2024 06:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTfcw-00067F-Ua
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:41:46 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTfct-0002OL-VI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:41:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-595850e7e11so6620189a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721126502; x=1721731302; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bas79QvDru3mMJDiRopDMAKb/1pJyJD7IsqAeatLL8E=;
 b=NLmTjMLKURFqnSmISdTCCjdYQkJQXEur3kcXRsBWv6yvO3uvnBpbRY2MzRgQkwOmHc
 dvodwWVcTZ20ftA9c0hCXBwB6XRrKZWUjX6gw9EKoSWmdjSNov7Em/8Zm6LezEVu5sGx
 y4kAocxAd7O52RlAzkYiwMDY3gBF3G6FY+wZ1QFSxuzxxm57iANjLwnA3ETshJLJ+7J7
 l8kQ3X0UIFOO/aGyMpISXZ8GMyZAIVTEyQzh3I/EBG6n1mJTPMWiFOrk+4ndIPuoUbej
 xD7uh05SIlaKinAt7fkpHaGLTFoxyKc+IlUPjwo8/tRbrVnUwUw0KTtRTwDPu/F3xvvn
 SntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721126502; x=1721731302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bas79QvDru3mMJDiRopDMAKb/1pJyJD7IsqAeatLL8E=;
 b=kxpandLGT+1Wi1kaHj7eFekH78t1pLeYofLGwc4tuSEArObjItzKnsATBDlWg24Lzt
 3KzV3pYX83OWUMndhSOsUivgPlWxT48lXEcOkzthTYqXMU41XuLE8wbYjcDXer/qfIGQ
 6d+qZSGKIzt9GehhDJyYNB234BSdelN54koLp//iFT9OCQxxBRHgCxf2C6hZNAR1saza
 fT3Dj/eCBIrDnxm3jXVX2b2wbkHu4sT1Jcj6+VQVBHn7RvlTXmS5IRGqC92jIlhyS4Dw
 wU6P0QcfJj94PlCGI1VHF3mNMBsK1+VBbI4a7JgkBLg+uuB5Em+GxUyT/J1newvXVJy2
 7y2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZr4Rs188aCM6U8YCIWy/QNbYlcJ9jZZIukWUHSwVENBAA1t3+910o1j8wKiGpa7w9A8PlXg21tl2pA1rqJZQCnlGy91E=
X-Gm-Message-State: AOJu0Ywis4G0g71BDG0PoaSVqdpQgvVgox6xqUAmufBPvX9GUI89wagD
 2Dsdj5YeSELCgdVjlLaqTG7rHJ0vOZyG7eJO0t76PWC2E1gfbvpho9mxADWUbRqH7Bs3ienOh5z
 6m4ep5oi4VUvPdlf4MRqC2h9WbzLmojgEkiK9Lw==
X-Google-Smtp-Source: AGHT+IHQh6j/XEX0CUYrUP6VFRtAZACnm0USBUrXFCYkyDKHLnKbJiZJkVcfhmVN94iLc7MDV9Nh5lzB+uaNWVURoQo=
X-Received: by 2002:a50:8ad7:0:b0:58f:4420:8126 with SMTP id
 4fb4d7f45d1cf-59eeec34696mr1020458a12.20.1721126502118; Tue, 16 Jul 2024
 03:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240714-arm-v1-1-c045bad45e48@daynix.com>
In-Reply-To: <20240714-arm-v1-1-c045bad45e48@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 11:41:31 +0100
Message-ID: <CAFEAcA9_x1BUnip+cB0kKqaUSrLY6hiubCjQ9D4-pSXM1ytVJA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Free GDB command data
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 14 Jul 2024 at 11:43, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/gdbstub.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index c3a9b5eb1ed2..03f77362efc1 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -477,11 +477,11 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
>
>  void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>  {
> -    GArray *query_table =
> +    g_autoptr(GArray) query_table =
>          g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> -    GArray *set_table =
> +    g_autoptr(GArray) set_table =
>          g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
> -    GString *qsupported_features = g_string_new(NULL);
> +    g_autoptr(GString) qsupported_features = g_string_new(NULL);
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>      #ifdef TARGET_AARCH64
> @@ -495,6 +495,7 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>          gdb_extend_query_table(&g_array_index(query_table,
>                                                GdbCmdParseEntry, 0),
>                                                query_table->len);
> +        g_array_free(g_steal_pointer(&query_table), FALSE);
>      }
>
>      /* Set arch-specific handlers for 'Q' commands. */
> @@ -502,11 +503,13 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
>          gdb_extend_set_table(&g_array_index(set_table,
>                               GdbCmdParseEntry, 0),
>                               set_table->len);
> +        g_array_free(g_steal_pointer(&set_table), FALSE);
>      }
>
>      /* Set arch-specific qSupported feature. */
>      if (qsupported_features->len) {
>          gdb_extend_qsupported_features(qsupported_features->str);
> +        g_string_free(g_steal_pointer(&qsupported_features), FALSE);
>      }
>  }

I don't think this is the right approach to this leak (which
Coverity also complained about):

https://lore.kernel.org/qemu-devel/CAFEAcA8YJwWtQxdOe2wmH7i0jvjU=UV92oeB6vUzT1GrQhRsTQ@mail.gmail.com/

I think the underlying problem is that the gdb_extend_query_table
and gdb_extend_set_table functions have a weird API where they
retain pointers to a chunk of the contents of the GArray but
they don't get passed the actual GArray. My take is that it
would be better to make the API to those functions more natural
(either "take the whole GArray and take ownership of it" or
else "copy the info they need and the caller retains ownership
of both the GArray and its contents").

Also, there is a second leak here if you have more than one
CPU -- when the second CPU calls gdb_extend_query_table() etc,
the function will leak the first CPU's data. Having the function
API be clearly either "always takes ownership" or "never takes
ownership" would make it easier to fix this leak too.

thanks
-- PMM

