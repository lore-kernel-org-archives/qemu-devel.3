Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926FECA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqrty-0000PH-Uh; Tue, 26 Aug 2025 07:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqrtt-0000OV-95
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:31:41 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqrtn-0000p9-9f
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:31:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71e6f84b77eso44240117b3.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756207889; x=1756812689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3QEBiTncBG9GLH1t5GZvb433DxKyLMey6N06rP630Y=;
 b=jtsLXhWQr7hA5Ine70y59pQuVy+/C7/cIYfiWoRh4HF9RjpJdhRA9SsVmllR9Cq212
 xNx2n0T2AghAkY8wHnwZo/QZ4GiDjCzkLa2lR386umqmGtclkZWu00MJo+3zg7OKnuJF
 XZAU+YV9psK9CTTye6RsEk8qOmmml1380wbSBiPtQaLO7c7qNG57OUyr0Swu//Rpbgnm
 fDY6B+7hEXYwyu0zaDgfZPt5qDIEvpkTfUJBsXhEvsAEA6tdO2AqD4fUTXRyPxT5biBo
 xiTORVTextehVKFccnNey2eBXvFevN3TJlK11Cp34V+3P8wylqL6G1DBf8owDwHwVTQo
 nhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756207889; x=1756812689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3QEBiTncBG9GLH1t5GZvb433DxKyLMey6N06rP630Y=;
 b=N67sYovYoRr/iQXnxjwwioX1vkW2eWUp8NpsI9/b5jz2dGZedBQ2UtogWproM9EdVe
 06ZgE+iRcij29HT5bI5pXR1WikR4ugBYtSfXldaHlrhS5RKz+LROfFAXTZNUCjCprgaj
 Q2WBegtrp5C0avDaWbSaWmYeZ4iIITEEwuxSLl4VtgyulLzZ22VW7xpsXk9/eGis7yFO
 I9PXvAXUoc4UZwoBPdIQWS/de1w9XugrEAdP8DCwBrjVm05cR281TGXo+dO9rd5SXzF8
 Pqlnm8ENkFihoEQgsXHb2uTMsYVoTqyEIgQ3n77RhD4P0rEBFsw+X29gb3E7JBafWT6e
 XSRA==
X-Gm-Message-State: AOJu0YzGFWCH9EJjWQvaY+OYBWRj3EwfPb4UzffJbnMncbo1OhXxZLYC
 XT99ypGi2TqaP5lMzNmXqU7PpPJXauDCkO2RT33aVe8b5ZWU9lDSJm8vr8Q8ZPKVgTZ0zjRLgC4
 IgwyZ+HBkSJVTSRPluuhMko6c5ElqQ8zBCXgd2E3b7Q==
X-Gm-Gg: ASbGnct2yRd89BKpNNMqmD0Aa932RNrc4CDrAjdPWXFXvBeYX2L4aKkEXwixwKc9rim
 aGD0eZl+A4rRT1pbw7cZjgkTj+twyM9Ez52f8lILc4Pcfz4hDWP9HKFeSOeiQv1dIye2azb/s2e
 fe+saiQry1sz85DWD23Bo/vCE6f8rGLXItNsiyiWYmvVfK7TCluvPhO6e1cQKhUgXeC8YuZYUNT
 HqH3qfD
X-Google-Smtp-Source: AGHT+IFayNTtX64M/BYtICL99c8dFsoO98KfzJOqxscsYmV4f/fV3Qmf3eBFlTJ9s+Kd7LA9cF2iK/cz4xAxgUpLatU=
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc2e with SMTP id
 00721157ae682-7200c20e228mr79285917b3.31.1756207889418; Tue, 26 Aug 2025
 04:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 12:31:17 +0100
X-Gm-Features: Ac12FXwvZaUnUZ-x0CF1DF3-mIoP9-PSfNfCQ4FYPPkQL5irQ-SBPta4-3gSbvw
Message-ID: <CAFEAcA-9UrCN2EFsJCSEx1y8CU8D9C_rGCjEuH02yvq3PkA_+Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] target/arm: Implement FEAT_LSE128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 15 Aug 2025 at 13:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This extension has instructions for atomic 128-bit swap, fetch-and,
> and fetch-or.  This is fairly easy to implement with existing host
> support for 128-bit compare-and-swap.
>
> Unlike for 64-bit operations, I did not implement the multitude of
> atomic fetch-op and op-fetch functions.  Those can wait until there
> is a need for them.
>
>
> r~
>
>
> Richard Henderson (7):
>   qemu/atomic: Finish renaming atomic128-cas.h headers
>   qemu/atomic: Add atomic16 primitives for xchg, fetch_and, fetch_or
>   accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg, fetch_and, fetch_or
>   tcg: Add tcg_gen_atomic_{xchg,fetch_and,fetch_or}_i128
>   target/arm: Rename isar_feature_aa64_atomics
>   target/arm: Implement FEAT_LSE128
>   target/arm: Enable FEAT_LSE128 for -cpu max



Applied to target-arm.next for 10.2, thanks.

-- PMM

