Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23235C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNi-0005dE-OG; Mon, 23 Jun 2025 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeNW-0005VW-FJ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:19 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeNT-0000hz-Fm
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:16 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711a3dda147so40516827b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674374; x=1751279174; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CoT3gs9CJqB/ctj7GRLf+HqsnyCEoZN4ehnmn/9xULQ=;
 b=kyMGJv8r7TGoDLYnJTjIFK1GckezJxBiyGcSULRjlfppAAtFnRYF6qk6GAN7B5yeNh
 ne+NVbpEH7mQrNvsnrPNAM0CYNz6vcmVUtKRqdPRDUJfu7idoBPRStCXfZNfdPPEdqxX
 azOdMF10R/pSoAPLv/tE6hA6cWJlOFvoHRvcjrX3xTUop0vnxptm5J62/dN+QNUwYVer
 9OzTn9NJyXdMSpKVudUYPcQX0IKRLc5PJDgfL2ZCD5+r1ZHn8AGUCuFwwf+LNlJhe+jV
 BBBaX4HkkG86J8/xEqKpfA471ai4xoYMlYM+RK+SpIPkCkyDF6dg4vrf377T1+lvs8IT
 fNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674374; x=1751279174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CoT3gs9CJqB/ctj7GRLf+HqsnyCEoZN4ehnmn/9xULQ=;
 b=R1XzDdv6ja+rXzqHg784osepGmpPKLa8BabCpJ9t92aiZzryjGHZb4gvYDw9GwLYjw
 umOIfMX5VCOrLsvNfzyitAMUIrgfMEPVwTi+hztvD96xjz8H8dLA1MBekSSZe7MuYJvn
 s9ILTNlG9auOk5BNfBp8EseycQlmL1OCQst9Q0yxdattZaKz6cbuzHhXhbunRJvmwju6
 U2TVoJJhrIsYDzZWWS9lZ7HsFy//4ouc7l+YISw4gxCNYq7CTOdPwh1darrshZzThuF/
 qfG1lEr45AyQfrEooclF6BUjW1Nr7mUuUADsrCq4lTfaCyqQWOUUOxb3UYownGvT3gbO
 WOKA==
X-Gm-Message-State: AOJu0YxpJkd1Ckn3NV7pUkVX2b++T1/mQXwY5ChjKR8BCKpUDX0ACiw7
 Zr/IhuHoanH1GbGjJZEyguUAt/Hpb4FAQV82rr7T1+o8ckVMyqbCUvUMXgOT+iSnBuZTK4hZ0DF
 erlCKqWGcvAphZMT5FUYtwOw8AVnJh6Kvt6S064zBFA==
X-Gm-Gg: ASbGnctOqf53w56p/dZV8ifVPDHMMYqcMXnLAlpZKWttl8GfiTUiKquCO56uZuGXuYR
 +Jb9BXL8LH2OzHdZLOF9VuZpQItPe6czorfMfQ1y7lLGfivyrtq36OW2G601cWqdTpKoRPZIeS7
 k/Ge+AWSrNbPNSaa8v25donvvKsKqUmidNYkG0B5MqMWxn
X-Google-Smtp-Source: AGHT+IGJSWBSjPJNHPnEekNSg+942bSYSoRPzQR477MOqXq9IWLEdn3Z3ndbphI219jyOIxQN0AqRcVAuW5B0HcAxls=
X-Received: by 2002:a05:690c:7489:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-712c64f9296mr172879807b3.24.1750674374423; Mon, 23 Jun 2025
 03:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-12-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:26:03 +0100
X-Gm-Features: AX0GCFt3RiShMyzCG1Vo5JxaDEftJT8VK4L0RQps4zrxD_zVS1nzK6ypXpizG9c
Message-ID: <CAFEAcA_3+AuLZUmTncQieiEZBbfh4gHjsxrG9tgN=ag=nKs3vQ@mail.gmail.com>
Subject: Re: [PATCH v2 011/101] target/arm: Remove CPUARMState.vfp.scratch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The last use of this field was removed in b2fc7be972b9.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 302c24e232..15b47a5bfc 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -668,9 +668,6 @@ typedef struct CPUArchState {
>
>          uint32_t xregs[16];
>
> -        /* Scratch space for aa32 neon expansion.  */
> -        uint32_t scratch[8];
> -
>          /* There are a number of distinct float control structures. */
>          float_status fp_status[FPST_COUNT];
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

