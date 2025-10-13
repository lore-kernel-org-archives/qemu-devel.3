Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086F8CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8J1c-0000wD-BQ; Mon, 13 Oct 2025 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8J1a-0000vp-69
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:55:42 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8J1W-0000fI-Td
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:55:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6360397e8c7so4366129d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760363736; x=1760968536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DftGonkAzHtlkmvYZhjlN937hlcBu0rWVkqrG9vBxcM=;
 b=EPb0oHdbccMJHlMZ6Y0LNJE+EW8KymHp1W1WeSykKwM3XgDDF9gUqF0f/PjOvzGLMG
 VAi1YhQhue8GP30d03Yiyhh4kYDZQjYyVpJixqEOaD6C5DUr2jb22yP5BUD00W3pKoQX
 prHvC9id2SDE3796amzA5EypzmFgNqHBFJClVyx7jjLJEIxojDpcFl1kodv0ZarqptKw
 fF/Yi7Cu1GXU/yIQztoDMXnXy47SWIiFGSlbvelxEjUJddX7OY5FOgywnwqCilEB4eUs
 MHVawo69usskHh2C36sp+jI7dZpWBbav43/DXo7FR8szA0ft/8m4jqmr6178LrTHwkYq
 k2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363736; x=1760968536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DftGonkAzHtlkmvYZhjlN937hlcBu0rWVkqrG9vBxcM=;
 b=KRIF9CjYc+BdiOBJFqe1uEITa9EhEQCmaQA86UzGPqvajxIktyBZCY310+xD5ROP8t
 Ca/lsvamA1FojlOv0XCXQ/MVw7HaF1tuiEcAE0fPTA2+FxlXPRPJEH4NmsR+pKIDW/Jg
 /oRdPoDYcEVEB3GYxgq1XP3NoQqUr7+FoLbRo+/EL/PF/05z38D23qYY9ADRvt+VKQ37
 bA1HRD4Ui9W5HO96ELE0yEiVWTJ5fDZ5MR9nwVbd1zVuVUTnRdI5szxAjDFZ907HuVdk
 OoSIGLJ+k3KZn8xvz2wmrcm+FxNyR+qNQD1u22SI7+0EXja6ziWqN9vGRKe1GE87SMUt
 lDUQ==
X-Gm-Message-State: AOJu0YxTlOxb29AMok1+BsV/thryzGn5RgFu0AJDj55avMYjRqqioZzk
 X3yi+kqc/aWrW6sC6NC7SFnadMTPKosXLihZrWylMA2IiukA55qHHS6NtJg3g+cG24pLPBxUl0D
 YS/sJj8BZa2lnFG7B/EwOLgbFzG2PUWBZMbFHWPOZHlHGvKlxWt1h
X-Gm-Gg: ASbGncs8F2tiNJeEXlrWrDxBxuaej99G1DyXuKdnNtNv3UaC/9JILcqMXyYHpiXRD26
 dBoI5t6LJYJ3tInkqnZHPEOoCu/8dVpyz+zxotQQR8by47Lrdikiq9gbLKxEib3wszyltvW7Kwi
 hXoQUMEhqZ85Epwl6E0BD/E5wvTTSqkMag6eyS0IPWnGo2SYL0bZ15D+7ZqKVhl19vT71ObcJQ7
 mmy6ER+0CpcOIstFJ2liCfXdhHMdn0jrw7i8DuOhO2qTj9fGpG2
X-Google-Smtp-Source: AGHT+IExt6YzVA8tW7MxPPEZLZCAw4fPg5Ot4Jo5VoItpi6EqSLHKlCkn3+4oLXNEHw2sOP9EVseTRwz967598lWxeY=
X-Received: by 2002:a53:c70f:0:b0:636:875:62ff with SMTP id
 956f58d0204a3-63ccb8fdca7mr14534494d50.35.1760363735513; Mon, 13 Oct 2025
 06:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-3-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:55:24 +0100
X-Gm-Features: AS18NWATUfE0kArlrrB_tsoUi5A_GVowUT2hboqI9sraW6OaFQBfyYueteHq32o
Message-ID: <CAFEAcA8_cotLWg6GTc+TFRJCPwVDG1743TRcXmH+LLJPEpSbRg@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/arm: Implement MAIR2_ELx and AMAIR2_ELx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 10 Oct 2025 at 21:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Enable the SCR.AIEn bit in scr_write, and test it in aien_access.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h |  2 ++
>  target/arm/cpu.h    |  5 +++-
>  target/arm/helper.c | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 1 deletion(-)

I think we also need to set SCR_AIEN in arm_emulate_firmware_reset()
for the "have_el3" case.

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

