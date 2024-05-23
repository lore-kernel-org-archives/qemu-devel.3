Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AEAC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA92q-00085P-Es; Thu, 23 May 2024 10:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA92g-00082T-SP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:03:41 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA92e-0001YT-Co
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:03:38 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57822392a0dso4278542a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473014; x=1717077814; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ4p/IdpVSDAywB99uv0SYLDetzwphTEmICYtwVmE+g=;
 b=eGCcV6pP4ymT+iE5blxKrO6+Y2ZG72267G6mJ82PNS5BiQytMXtH0nn3+sCDUzbZK8
 DGGaytHKa08JW/UGXBHZSqMyg6OayFqQpGmeb5lzcKig9EYl+gThZNsLZWNS+ViN3FKv
 sS0xP01L5oJ4C/DMjWagCnLcjZ+RLekbCZxSNkN2dqHufrIRNfZc3cCz9bkTWdcOs6IN
 1wGLWnSjSKQlg3oQYlonIiBgWqPMmLANzK1pB4RRRDzFDzSySgA4brdMBzR0MFIA7JBC
 IkXqX4VjRderIXYipeDfSQjSdB1Up3WtBAk5mhVmPgaVa8rSFDiGArYNaF9lRQqOsmSg
 BWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473014; x=1717077814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQ4p/IdpVSDAywB99uv0SYLDetzwphTEmICYtwVmE+g=;
 b=VLxznozB82T9JzHa28WIX7Z7XD2jrnLhv+N719czhg5/ghRnaVbGtbpq9V8eemTk1m
 6eYhzEAMtBM+UopL/gylrzddAVB75vGttUvACw0kxVwfX0Y2rOb0MdxlCiUDLnlKXe7I
 iWNTXyqiaaaqjkroSv8tDA2Dyai0J8QIZBHDVxgI0sIbemXebanU5WM/Guo5jUGr4/Ma
 AhG9c6cBqUXi2+deUYiirAfFe6BufddzFIYJqyum1MtmoiJ33z4g+pLsD1dGvzaiBWLn
 zsObHDsL2qk2/c/kvNECHf/4s/t9E5k32kO/WL2bcvhxFMgU4IEKEg0d1ZqvjZU5LMmm
 zr/g==
X-Gm-Message-State: AOJu0YzELiWld8QHkFt3YRqLV/NLScBZPNteEcI8PcwwdUzBggP3B9p7
 7mIC8C14ddLwbOW+MxBl8NAXb5S1U8wvVb3SWwv4//Rm+DP+wiZf7sO6ihcXMCDHXgwHzHoucqD
 L/EPL5IccbDBGhKW6fwgkDPeV+62VauJoSMIM7Q==
X-Google-Smtp-Source: AGHT+IHLeikkh86q2dTeo6CwddBVagU3U2DKaLVtnN83Fsz41qjp3/RRVHIuL+CKXDAqPpxXMMYzHfPaDSBDGeUr4ZE=
X-Received: by 2002:a05:6402:5155:b0:578:3abd:cb82 with SMTP id
 4fb4d7f45d1cf-5783abdd0b3mr2033486a12.25.1716473014579; Thu, 23 May 2024
 07:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-28-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:03:23 +0100
Message-ID: <CAFEAcA_fYSHFbX0F5_bcxaHD19uou1o1Ekoceou6zEKYkVSqGg@mail.gmail.com>
Subject: Re: [PATCH 27/57] target/arm: Use gvec for neon pmax, pmin
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 6 May 2024 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-neon.c | 78 ++-------------------------------
>  1 file changed, 4 insertions(+), 74 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

