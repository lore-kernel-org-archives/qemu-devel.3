Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE4ACEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB82-0003Fi-4P; Tue, 08 Oct 2024 10:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB7q-0003C9-QP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:23:50 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB7o-0000gs-Ng
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:23:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so236994a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397422; x=1729002222; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kOWE2cAoIjDm9f/FqGa6G6t3ssB5Lz0udY0SFSrSxWI=;
 b=ApHDfOwJ92L0NOdaRpA3iytV0gcEbOEBrfmI8K+5XAUybLqV6qsniZgmL725cBiSiD
 BaWg5F0W3AsxWxPAMibTytmMLk3/TJ/r13boZ3Iwv8jE4L6MicrRo6igc4T74+os7bq7
 pg8KW3NRJbjJuclh6/qNBM6OMYHiK6DgxqsVu2L6+ulgVsfsqOE8ELyIrTCgvnwo0OI7
 uq2ky1gmW41AAC517e1VJX6NACgeB/dOCdSfInsJl6ABRB9BNYwepvxf0HL+Todm9Vd3
 Ckf9BxVq3piANPMvrDvBKtmyv+N6mlt6lJfukgSao2cs6Unq2GlLtr1LMAYwYv6Fk0pO
 k9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397422; x=1729002222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOWE2cAoIjDm9f/FqGa6G6t3ssB5Lz0udY0SFSrSxWI=;
 b=KyGFfFVuj/mulLGF+ZLcEua8upiFuTqaPepURrgfxDbxTOb1FbtCO6wk0Xm9+8VGGo
 KCJ4oF/uD5opQvhVL5hW04RnobhjX0JsYUHvnWUyXP1jvsnGJOIpb2ffYvzuuO6s9f0F
 35w55ovxqS703wv0gKWLhZF5yhiiadKtcG8POoV6RJ29Y/jCpWnn8KW3W3YQBNDtGjdW
 8w2mSlF0hmMwm1FtqN048hR90uv+Xr6yhMrrT+L49Gl6D+0cXDSNcAMImdeHoz/6Ojtt
 qFq+pebchxy89LMGJZdzLhQOr4yG62lNiIpXB3yAo4kKo4/e14YwHvd4wkwBlriO9jIw
 f1tQ==
X-Gm-Message-State: AOJu0Yw/XTYNBL1JigUQ40WP0bfqsKfa2IlnWnsHKDBAF90VResqG+pt
 /e5v4aQYzBSYA5ACTtn1pmV6+FTgicIJYcQ6jNB2LbGtQtcIIdoKgok2kuI/Ssb1zFrzT+NbcLV
 Kjt5eXsRkX7GVu4Of7hr8ncFm1X7CKNpBh/s+uQ==
X-Google-Smtp-Source: AGHT+IE63NtOVMmF0vUbrtvnDhrwqy+4rBGeEL1dE3L0XoRqeekOTPKAuBVShJkbWSmwl9/McI6rGCEphCweGhdISKU=
X-Received: by 2002:a05:6402:2713:b0:5c2:5f31:8888 with SMTP id
 4fb4d7f45d1cf-5c905d4f723mr3483800a12.15.1728397422269; Tue, 08 Oct 2024
 07:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-22-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:23:31 +0100
Message-ID: <CAFEAcA8dWB63M-x5KwuEH1xdoRdC367HOF2BOvUHrp0TSO38Ow@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] target/arm: Fix alignment fault priority in
 get_phys_addr_lpae
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that we have the MemOp for the access, we can order
> the alignment fault caused by memory type before the
> permission fault for the page.
>
> For subsequent page hits, permission and stage 2 checks
> are known to pass, and so the TLB_CHECK_ALIGNED fault
> raised in generic code is not mis-ordered.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

