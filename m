Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DAEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdWkq-0006mo-QP; Mon, 12 Aug 2024 11:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdWko-0006lf-Iy
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:14:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdWkm-0006a9-Um
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:14:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so5808125a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723475673; x=1724080473; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nn9J60puewudqRteyMm2kWG4TdMdGZoLctn107c2Iqg=;
 b=bYtdmhqhxOttTuesY7+jhQYhTF8EVxc7sWRFt5OGl/OklG1PzUsZcQP9oCifTgqnwX
 zO2bP51lQ+BRs8lncBKPLiE2+fvoHhEJoNuOMCoGgQftFa1oyMjpEscZn9kpLsLq/ZuG
 zAzV7VX26ke7BVHxwz0pS0SpyJTpqGyuoeZfA7XMHnxfok8GskkCDA/sfg34VuSjCsDO
 kGYZLAVnj9uh1PFIADBGD8f+HYVNqKwR+L1qqgePve1PMPFI1Tz5kbsW+tiQapXjmwMm
 queiLiVuxQyreoi0fgKT8KVAjSlPgWwm9BZM8k4M+diw7qlKkoLFu5Bf7U+VLsRQqQO4
 QMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723475673; x=1724080473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nn9J60puewudqRteyMm2kWG4TdMdGZoLctn107c2Iqg=;
 b=Bo2t3ReHEuBk2rdXYu/xzQ52Xk3LgbacaFM36wY19zrHIbNowfbhOwpb8gltFGiT/b
 uPXoPqhVxyrEHORTi33F2AyfS8FBuqJuG42pZJsU/NEOY2/vlCGyd8bfndhoA8gxgQjT
 R1zqtBk5USfyUpn8q2XdOepPYJPnIYSn1waMIxVdkSVvMDAhTKrFsfBKC6EYXcnSuBCN
 L98xQdP7Po/meA6ZXT8FUNTWvvalLhLLVUR2JOCFIsUkKEpY+0Jh/KHqUrZBPnI/xKEC
 hZmRMNKVmkyKd0NSJ8f8OHwH75+DBB6xPTlDxbtxkAqoW3YWXmYsJCKAggRPI9EtXrU6
 CVgw==
X-Gm-Message-State: AOJu0YwYG6dvojMGGr/NhKkZMvx4EuJwp1nQbx7/pVyUyiRCWrGADVOb
 Q4vBMc/3FepFML+STO6FXFp2fSnSi0zIi5MzM2DeJf3Ghhmwhkr+pOK8St7xVccZftmM7TVl4ne
 8G2YvEhGdgZB917zo6muOf+xmovKBGNctKQkHBg==
X-Google-Smtp-Source: AGHT+IGkKMeK/yeOxgxDhipMi7wV7HsiFZrSeswobOEApEYYO2dkX3oqlxpwEKSq3z5UD5wbBqFVsaQZF/iRm6SweXQ=
X-Received: by 2002:a05:6402:354a:b0:5a3:b866:eae0 with SMTP id
 4fb4d7f45d1cf-5bd44c7c314mr487154a12.32.1723475673220; Mon, 12 Aug 2024
 08:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240717060903.205098-1-richard.henderson@linaro.org>
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 16:14:21 +0100
Message-ID: <CAFEAcA8vJxUUHWA_nUF-810fDhYyPggtc=HGFdp0QUa5segB=A@mail.gmail.com>
Subject: Re: [PATCH 00/17] target/arm: AdvSIMD decodetree conversion, part 4
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 17 Jul 2024 at 07:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Flush before the queue gets too big.
> Also, there's a bug fix in patch 14.
>
> r~
>
> Richard Henderson (17):
>   target/arm: Use tcg_gen_extract2_i64 for EXT
>   target/arm: Convert EXT to decodetree
>   target/arm: Convert TBL, TBX to decodetree
>   target/arm: Convert UZP, TRN, ZIP to decodetree
>   target/arm: Simplify do_reduction_op
>   target/arm: Convert ADDV, *ADDLV, *MAXV, *MINV to decodetree
>   target/arm: Convert FMAXNMV, FMINNMV, FMAXV, FMINV to decodetree
>   target/arm: Convert FMOVI (scalar, immediate) to decodetree
>   target/arm: Convert MOVI, FMOV, ORR, BIC (vector immediate) to
>     decodetree
>   target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
>   target/arm: Fix whitespace near gen_srshr64_i64
>   target/arm: Convert handle_vec_simd_shri to decodetree
>   target/arm: Convet handle_vec_simd_shli to decodetree
>   target/arm: Clear high SVE elements in handle_vec_simd_wshli
>   target/arm: Use {,s}extract in handle_vec_simd_wshli
>   target/arm: Convert SSHLL, USHLL to decodetree
>   target/arm: Push tcg_rnd into handle_shri_with_rndacc

Other than the need-to-avoid-shift-by-negative nits in
patches 12 and 13, whole series

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

