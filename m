Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A39C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5UV-0005iB-Ui; Tue, 25 Jun 2024 08:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5UU-0005hQ-Cb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:41:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5US-0002eV-LE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:41:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7241b2fe79so341006166b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319299; x=1719924099; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=an578M1o0anMqg3zDMMjG/0T37Slq+ZkcPhwGoD8HFE=;
 b=WUN6sEifSJrdHGAYRKxunO/5AkTFeP0NHWFy58gMwfnUioFV3BEAbmRN9Q3BlbE8Ba
 BI+ZHFg+J1YLL/Yx/HZJsJvCgRVbPpv9TWaMF7Xy5w6vn1V3tcbvjCjmrrm1Zhdyb0Bf
 iaKs4684Qiif7e9/5Y6NX+NTMh+GZnzg2hFACRI6gt81kfpSbYNgAe5v6NGs8iyFCyY6
 D4nl1l/YJIBBGC2cPguxd1P9km1JUA4RR0S4Ocg0geaoxdQhD3zv55ibBm3fWc64LcBl
 2W8HfwvcHcbFHbMbfu5M+qM6fjJe+xLdPl8J0MJ90cUE0743Q5IPtUPFAloscH4eHn15
 XLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319299; x=1719924099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=an578M1o0anMqg3zDMMjG/0T37Slq+ZkcPhwGoD8HFE=;
 b=k41HxRUy8Oo8JaVRac5rWHlead2JmYIcbhu2yK0o9F2I9lFYS+cVAcOA4uAUtSicA4
 ygvpN9Ukem1QgbSE/COj1FThs4A/R/fb5JB6QQIBvSryg9Bnvq74BL7bPlby0nM1QAzR
 4vQaZ7P0uaWs/W4iwnExblEx8mj/sxOh1luAN/PeCEwUYcoDnTMidTiIJTRXzfSvq+Xz
 9rYJHZ5o9S969RJoYO2BWoZAdEya2KK8i/YvG2l2mhfaD50tCidOG5iOqDnT0E6oz4N/
 qd/DUqby8DjBd//Eqk4RO3L/Zu1qj80zsc8GnytfvaJy/QTXUkmOVKP+/DaHMW+Hzcim
 YH7A==
X-Gm-Message-State: AOJu0YwUCz0IkmhXIg/lcT4uH6WD6oXd31B/kSnriQ3h8nYwWajHkvv6
 IWD30fZIdLBaKY48ppGd3JTV7iBbM+I89VDL9D26W/7SsPzuiY6NJ9rPZVZeQ12xf/E2xuGLaFA
 /gGSm2xU9XeM+aYyjP25oxtDOYbGhyPzm0aB1zw==
X-Google-Smtp-Source: AGHT+IF/L39JgGaH5eeXC5p3PjTidwJix+TneYxyo1tw50huB5oAv+J4Vxw4wLZBs6I/5PiJc1E5hCaxbCbYuDE8/+Q=
X-Received: by 2002:a17:907:100a:b0:a6f:77bb:1719 with SMTP id
 a640c23a62f3a-a7242cdb14dmr509963366b.47.1719319299141; Tue, 25 Jun 2024
 05:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-14-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:41:27 +0100
Message-ID: <CAFEAcA9aij1SbdEQkR9=UhJO2uz1u90881FwC8KHLYuLFto5AQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] target/arm: Delete dead code from disas_simd_indexed
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The last insns in this block, MLA and MLS, were converted
> with f80701cb44d, and this code should have been removed then.

"MLA, MLS, SQDMULH, SQRDMULH, were converted with f80701cb44d
and f80701cb44d33", I think, since there's still code for
all four of those insns that we're deleting here ?


> -            switch (16 * u + opcode) {
> -            case 0x10: /* MLA */
> -            case 0x14: /* MLS */
> -            {
> -                static NeonGenTwoOpFn * const fns[2][2] = {
> -                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
> -                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
> -                };
> -                NeonGenTwoOpFn *genfn;
> -                bool is_sub = opcode == 0x4;
> -
> -                if (size == 1) {
> -                    gen_helper_neon_mul_u16(tcg_res, tcg_op, tcg_idx);
> -                } else {
> -                    tcg_gen_mul_i32(tcg_res, tcg_op, tcg_idx);
> -                }
> -                if (opcode == 0x8) {
> -                    break;
> -                }
> -                read_vec_element_i32(s, tcg_op, rd, pass, MO_32);
> -                genfn = fns[size - 1][is_sub];
> -                genfn(tcg_res, tcg_op, tcg_res);
> -                break;
> -            }
> -            case 0x0c: /* SQDMULH */
> -                if (size == 1) {
> -                    gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
> -                                               tcg_op, tcg_idx);
> -                } else {
> -                    gen_helper_neon_qdmulh_s32(tcg_res, tcg_env,
> -                                               tcg_op, tcg_idx);
> -                }
> -                break;
> -            case 0x0d: /* SQRDMULH */
> -                if (size == 1) {
> -                    gen_helper_neon_qrdmulh_s16(tcg_res, tcg_env,
> -                                                tcg_op, tcg_idx);
> -                } else {
> -                    gen_helper_neon_qrdmulh_s32(tcg_res, tcg_env,
> -                                                tcg_op, tcg_idx);
> -                }
> -                break;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

