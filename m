Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0960ECA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 00:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBi6O-0003FK-3C; Tue, 29 Sep 2026 20:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBi6K-0003F4-JI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 20:23:14 -0400
Received: from mail-lr2-x2a.google.com ([2a00:1450:4864:38::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBi6G-0001ww-WA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 20:23:11 -0400
Received: by mail-lr2-x2a.google.com with SMTP id
 38308e7fff4ca-3a773960275so322321fa.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 17:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790727787; cv=none;
 d=google.com; s=arc-20260327;
 b=C38+jIIbWOq2KP0aCHLBqTmVK+3diDCGwKYyKoj5KSY3j0MxqKhL6LM2mGMY2y50Kf
 yR3MLlLgaqq6cASCxzKpIpFahL/j8ks6qFrHyN+v3aCgImsBQTzI8I/y+SfKXeY4A7Hs
 x3Mh0snZwvu5lor3E7lKW+xNUhHp0FVMq/2tzr8mXLyiZCLFtd0nLQQm5LBPvpaSZ8mk
 zoyXLKxZgAMeJSlEpZ+AWj4X1llgyTYoeRyygjZTN+hGwvgWAzOK7Q2u1X1Qd2wiZ8nI
 zjMhkePke3x26LyY0AJ2LZfHidVjS6A4ZUPKaldD/WQ68hfJFZDQStLDlTYPFRqQ7MB0
 QOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ooZ05ymYZrqD7Xj+YIkU43vbqeK94mI/vcQW4zclojs=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=hifpRvd7Tt8HPhGI5JXxksG+j6qNAUt/G115QNXINscV6sjnNB8ezr6Z1XZuo/eTxc
 g5yEAaH4ABUdE9eI/NyTpg/zhAEkgcAziunm5a1h7uqCpKMbkLsso1i8Z7UJ/papTYxG
 DbJvI+WTIOnjY8HIAis+fuqq2LDti/uMUFBpj4sO0d08pkYRPhiCK0E3/xgbx9hw1CKC
 gm34oU0Jdh2GL7PXCKnZue7i757obONQng2Dh6z1321Nj5bRr612tHtH5oEr2S64T3pb
 eoxSaqteKOCMuDzp0QpGICwr+PCSWTEe/gRMGluTuVHqH6WGpgYin4YxFcUtXNJce8Md
 w4Jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790727787; x=1791332587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ooZ05ymYZrqD7Xj+YIkU43vbqeK94mI/vcQW4zclojs=;
 b=EPu5gLaweUCU/KblVJSa4Jd0pwAQiYX7WcRF06dCw8Do5P5dPMwGji0a1Xi4H8SG+e
 zS+vJNDK8FPM2/1TqM/FOFrys/+gpVGlrKWQS0rPpGZ+08O7emlfOT/CbysUuTwjrgxM
 y3p7EcDvQSYj+i6kwGmcFisYgrNUX2wEBrWqrkCM6ALEWt4DwzpyMOxKp5dhEfNuMZnG
 xmna/iGzE++4jHMaBpNSJJ3GHbfu3mw6dbWLLRPARorm/DB7dCAqPq6yRXOq047Ky5Cj
 +SSRv741ApeaPWAfasWeZeTotuBAjJOnqrK0arTQBTe4naFAuQ9b/LZ0c9adBVg2UtD5
 Da6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790727787; x=1791332587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ooZ05ymYZrqD7Xj+YIkU43vbqeK94mI/vcQW4zclojs=;
 b=Xasq3dKyAoD0wvE2aDrHhVjz/NKow2lNfwxeSyWor0uqa5uvsmPtys27Jvbykpvk8B
 McEb9uVvL1BiM5L/M8Lk/Gignxc2bsQ7T9NtdL/4+GpfP9hd+MDemMWolsPbV/F2UZZa
 7u7ngqqHRZBsCfCmQEFwejNLS3MmtdIqAtwrOUz7o3AiVBszxMCS0Ui2U/OrpYkCtn7z
 ZtFjQ0E+fb7NZmw2t1AyP5r+4V/grFj9PF/VOdiGgBDOSwIgv5KkS9f9EYwp15JaZ+az
 IXCmhxbG1EHQGWyCEG4G8vaT2uifr5FiomRItLYZje9ZhVAKP+A1yiW6BWyCxHmWLp42
 Y72w==
X-Gm-Message-State: AFq9FYKRLn5LgsiTlJvt7uXDoHGwAWo//ZCELblUqcbqY5C2PTbNiPKM
 rK+b+23u/XKD3yrfvG6WBbEwnb52JpfyU7f6auxLNHrYklorUMn1CPzzM2GfEHHnlxixgakAzTM
 Z9xgIEi66BzPjANt6/be4hrNe1ydbjIAq6g==
X-Gm-Gg: AYBFou1K3QvmZGb5A2iUxpd+yLiezh6V62ZkFMJFYiCmz+mdTYhrOUlrTJ7B7LkKgO8
 Wwt554v5p9lYpiMpEEIZCfN5TzqOl5g8RsCu9ymTXLz5qIv5zrCqpq2088KWKCGKLLo4HuA4eku
 dt+WEnAhAiHPuyjbruwGbFmF2Kf4L8wCFYZhhewfx70lKNlvTj0MBnC8Qz901m9E+E+LtLjohFt
 ibH6K21+7awsbGGlJTGPo/y0h8ptFLfb8DA0NITRsC/CK9Frf6up/nJbab1RybNbMGw9zVSqqH5
 /UAgXhZmv83VLmmWb1Mf3iV5kbYYESsWelJR8BqgZfM3KghdGrkxEf1KRfP8DKWzfImZaNlSXKS
 pQewwz0NWneo68EKzYb0XIaHK
X-Received: by 2002:a05:651c:15c4:20b0:3a6:52ff:39b9 with SMTP id
 38308e7fff4ca-3a771781555mr1546211fa.5.1790727786762; Tue, 29 Sep 2026
 17:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-101-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-101-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 20:22:54 -0400
X-Gm-Features: AclHuK-3-2CpqtlNk8Aslz6A1TqFmUicfa7UxHR4-dNqk9vVk2H_cEx9lqmia_s
Message-ID: <CAEdQ38HyXejuF4CqDJGKGdhE18n+xs2OiAaOZEF+Yt+Y9Ljh5A@mail.gmail.com>
Subject: Re: [PATCH v5 100/101] tcg: Generic expansion of remaining atomic
 operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::2a;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x2a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Sep 27, 2026 at 5:08=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are done in bulk because of existing macro magic.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  80 +-------------
>  include/tcg/tcg-op-mem.h     |   2 +-
>  include/tcg/tcg-op-def.h.inc |  20 ++++
>  tcg/tcg-op-ldst.c            | 206 +++++++++++++----------------------
>  4 files changed, 102 insertions(+), 206 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 9864674f1c2..bc96c02aaea 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -181,89 +181,15 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, =
tcg_target_long offset);
>  void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>  void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGTy=
pe);
>
> -/* Atomic ops */
> -
>  void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                       TCGv_i128, TCGArg, MemOp, TCGType);
>  void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                          TCGv_i128, TCGArg, MemOp, TCGTyp=
e);
> -
> -void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                 TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                 TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_xchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
> +void tcg_gen_atomic_xchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                    TCGArg, MemOp, TCGType);
> -
> -void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_add_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_and_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_and_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_or_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                     TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_or_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                     TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_xor_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_xor_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_smin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> +void tcg_gen_atomic_fetch_and_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                         TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_smin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_umin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_umin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_smax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_smax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_umax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_umax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -
> -void tcg_gen_atomic_add_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_add_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_and_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_and_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_or_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                     TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_or_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                     TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_xor_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_xor_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                      TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_smin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_smin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_umin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_umin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_smax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_smax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
> -                                       TCGArg, MemOp, TCGType);
> -
> -void tcg_gen_atomic_fetch_and_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
> -                                       TCGArg, MemOp, TCGType);
> -void tcg_gen_atomic_fetch_or_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
> +void tcg_gen_atomic_fetch_or_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
>                                        TCGArg, MemOp, TCGType);
>
>  /* Vector ops */
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> index 935860f1442..6533704082e 100644
> --- a/include/tcg/tcg-op-mem.h
> +++ b/include/tcg/tcg-op-mem.h
> @@ -67,7 +67,7 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, =
MemOp m)
>  #define DEF_ATOMIC2(N, S)                                               =
\
>      QEMU_ARG_NONNULL static inline void                                 =
\
>      N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       =
\
> -    { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
> +    { N##_chk_##S(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
>
>  #define DEF_ATOMIC3(N, S)                                               =
\
>      QEMU_ARG_NONNULL static inline void                                 =
\
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index e0ffd0da678..e694f0e38c4 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -88,3 +88,23 @@ DEF3(xori, TCGV, TCGV, TINT)
>
>  DEF7(atomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, =
TCGType)
>  DEF7(nonatomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemO=
p, TCGType)
> +
> +DEF6(atomic_xchg_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
> +
> +DEF6(atomic_fetch_add_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> +DEF6(atomic_fetch_and_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> +DEF6(atomic_fetch_or_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGTy=
pe)
> +DEF6(atomic_fetch_smax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_fetch_smin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_fetch_umax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_fetch_umin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_fetch_xor_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> +
> +DEF6(atomic_add_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> +DEF6(atomic_and_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> +DEF6(atomic_or_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGTy=
pe)
> +DEF6(atomic_smax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_smin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_umax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_umin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCG=
Type)
> +DEF6(atomic_xor_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGT=
ype)
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index b3143f6311b..77679634cbf 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -877,113 +877,92 @@ void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128 ret=
v, TCGTemp *addr,
>      tcg_gen_atomic_cmpxchg_int_i128(retv, addr, cmpv, newv, idx, memop);
>  }
>
> -static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 va=
l,
> -                                TCGArg idx, MemOp memop, bool new_val,
> -                                void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32=
))
> +static void do_nonatomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
> +                            TCGTemp *val, unsigned idx, MemOp memop,
> +                            bool new_val,
> +                            void (*gen)(TCGType, TCGTemp *,
> +                                        TCGTemp *, TCGTemp *))
>  {
> -    TCGv_i32 t1 =3D tcg_temp_ebb_new_i32();
> -    TCGv_i32 t2 =3D tcg_temp_ebb_new_i32();
> +    g_autoptr(TCGTemp) t1 =3D tcg_temp_new_ebb(type);
> +    g_autoptr(TCGTemp) t2 =3D tcg_temp_new_ebb(type);
>
> -    memop =3D tcg_canonicalize_memop(memop, 0, 0);
> +    memop =3D tcg_canonicalize_memop(memop, type !=3D TCG_TYPE_I32, 0);
>
> -    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memo=
p);
> -    tcg_gen_ext_i32(t2, val, memop);
> -    gen(t2, t1, t2);
> -    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memo=
p);
> +    tcg_gen_qemu_ld_int(type, t1, addr, idx, memop);
> +    tcg_gen_ext(type, t2, val, memop);
> +    gen(type, t2, t1, t2);
> +    tcg_gen_qemu_st_int(type, t2, addr, idx, memop);
>
> -    tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
> -    tcg_temp_free_i32(t1);
> -    tcg_temp_free_i32(t2);
> +    tcg_gen_ext(type, ret, (new_val ? t2 : t1), memop);
>  }
>
> -static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
> -                             TCGArg idx, MemOp memop, void * const table=
[])
> +static void do_atomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
> +                         TCGTemp *val, unsigned idx, MemOp memop,
> +                         void * const table[])
>  {
> -    gen_atomic_op_i32 gen;
> -    TCGv_i64 a64;
> +    TCGv_i64 a64 =3D maybe_extend_addr64(addr);
>      MemOpIdx oi;
>
> -    memop =3D tcg_canonicalize_memop(memop, 0, 0);
> -
> -    gen =3D table[memop & (MO_SIZE | MO_BSWAP)];
> -    tcg_debug_assert(gen !=3D NULL);
> -
> -    oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> -    a64 =3D maybe_extend_addr64(addr);
> -    gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
> -    maybe_free_addr64(a64);
> -
> -    if (memop & MO_SIGN) {
> -        tcg_gen_ext_i32(ret, ret, memop);
> -    }
> -}
> -
> -static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 va=
l,
> -                                TCGArg idx, MemOp memop, bool new_val,
> -                                void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64=
))
> -{
> -    TCGv_i64 t1 =3D tcg_temp_ebb_new_i64();
> -    TCGv_i64 t2 =3D tcg_temp_ebb_new_i64();
> -
> -    memop =3D tcg_canonicalize_memop(memop, 1, 0);
> -
> -    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memo=
p);
> -    tcg_gen_ext_i64(t2, val, memop);
> -    gen(t2, t1, t2);
> -    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memo=
p);
> -
> -    tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
> -    tcg_temp_free_i64(t1);
> -    tcg_temp_free_i64(t2);
> -}
> -
> -static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
> -                             TCGArg idx, MemOp memop, void * const table=
[])
> -{
> -    memop =3D tcg_canonicalize_memop(memop, 1, 0);
> -
>      if ((memop & MO_SIZE) =3D=3D MO_64) {
>          gen_atomic_op_i64 gen =3D table[memop & (MO_SIZE | MO_BSWAP)];
> +        tcg_debug_assert(gen !=3D NULL);
> +        tcg_debug_assert(type =3D=3D TCG_TYPE_I64);
>
> -        if (gen) {
> -            MemOpIdx oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> -            TCGv_i64 a64 =3D maybe_extend_addr64(addr);
> -            gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
> -            maybe_free_addr64(a64);
> -            return;
> +        memop =3D tcg_canonicalize_memop(memop, 1, 0);
> +        oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> +
> +        gen(temp_tcgv_i64(ret), tcg_env, a64,
> +            temp_tcgv_i64(val), tcg_constant_i32(oi));
> +    } else {
> +        g_autoptr(TCGTemp) v32 =3D NULL;
> +        g_autoptr(TCGTemp) r32 =3D NULL;
> +        TCGTemp *ret_orig =3D ret;
> +
> +        gen_atomic_op_i32 gen =3D table[memop & (MO_SIZE | MO_BSWAP)];
> +        tcg_debug_assert(gen !=3D NULL);
> +
> +        if (type =3D=3D TCG_TYPE_I64) {
> +            v32 =3D tcg_temp_new_ebb(TCG_TYPE_I32);
> +            r32 =3D tcg_temp_new_ebb(TCG_TYPE_I32);
> +
> +            tcg_gen_extrl(v32, val);
> +            val =3D v32;
> +            ret =3D r32;
>          }
>
> -        gen_helper_exit_atomic(tcg_env);
> -        /* Produce a result, so that we have a well-formed opcode stream
> -           with respect to uses of the result in the (dead) code followi=
ng.  */
> -        tcg_gen_movi_i64(ret, 0);
> -    } else {
> -        TCGv_i32 v32 =3D tcg_temp_ebb_new_i32();
> -        TCGv_i32 r32 =3D tcg_temp_ebb_new_i32();
> +        memop =3D tcg_canonicalize_memop(memop, 0, 0);
> +        oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
>
> -        tcg_gen_extrl_i64_i32(v32, val);
> -        do_atomic_op_i32(r32, addr, v32, idx, memop & ~MO_SIGN, table);
> -        tcg_temp_free_i32(v32);
> -
> -        tcg_gen_extu_i32_i64(ret, r32);
> -        tcg_temp_free_i32(r32);
> +        gen(temp_tcgv_i32(ret), tcg_env, a64,
> +            temp_tcgv_i32(val), tcg_constant_i32(oi));
>
>          if (memop & MO_SIGN) {
> -            tcg_gen_ext_i64(ret, ret, memop);
> +            tcg_gen_ext(TCG_TYPE_I32, ret, ret, memop);
> +        }
> +        if (ret !=3D ret_orig) {
> +            if (memop & MO_SIGN) {
> +                tcg_gen_exts(ret_orig, ret);

Same two comments from 099/101 apply to this patch.

