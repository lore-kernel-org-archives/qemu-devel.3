Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5961DCEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB99-0004uY-J1; Tue, 08 Oct 2024 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB94-0004mJ-HM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:25:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB93-0000o3-3f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:25:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c881aa669fso6924739a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397499; x=1729002299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5YRc+xLkBL7rEj4z4bMMDdrYWfvach9L5dpn/9o3g/Q=;
 b=be482UKOkXrzV2YYocFaiexNZqCiUrUWUf6v+8zhBcnkFK/tvCMQpdzpnoHGNuZFCx
 XlxMwfiuV1BtsxO7jvPjU4twIgyCBG9zeuTe/ejQKmcfql5dXfg67h1af94WtK0F9tKx
 Iyx6ixctohp7WbAVoNIYOPRODESFHnQSMFxnxfdqRcX7PkzpyEOogTAdb6Pz91ttXfhx
 RHWAAxTMgjQEY4hwL7zG/UFJRL7mHnxm/xiWySeuEwiz3ghxz0Cx2OPCrOxZz64WBkvA
 moMy3xQMhw5LuDjoCUfQ4T66iYYB2r+pEqe47oMPiCC/lv/10LyePmxuJl5M+lFu6mQQ
 7yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397499; x=1729002299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YRc+xLkBL7rEj4z4bMMDdrYWfvach9L5dpn/9o3g/Q=;
 b=WBblSnaSCYyBvyrOiTZ4eBiG8veuDLemr82sWennJ0dICQv7cEA86Oq+k2UcxmjZv8
 l9u3Q9wJxzSI+jnJpaxbWw+afkKTw0r7f1djkUmHjm+T+R5nET0XwbLvdkOCBzLqc/L1
 go0E61YKxQLaCL/nKLyET5mQVQlrQVp/1J/PWIE7J1gtvZnSnPx1Fw33KZj22Up1LHFk
 CAEf9XM5iofdPXGBEBfRpHhR2VdfZquwoqc2/2vaWJyiVNpiVpxTR1wKnuWBkBJ14BJw
 6fd3S1U9L16FU0ruDQLKQhecWzc5fbn4FT6VJGmtOZ3R8eNyc8p3X+HDMMQHMKVaX5V3
 uW7A==
X-Gm-Message-State: AOJu0Yza+W8q0yHCdEQijJ6diHgIUG6Jv89HggiWkfLzTTpF6DLPULRQ
 Zi5RFmTtEaexH5arXuT73x9aBtJDj+iTzIhB6cVYpBvytKTtBH6Vpiez2YKlsh3jROCg9/INern
 xsBVlqRaGl2lV4lj9LUKsPFmeNlQODpc13k1v3A==
X-Google-Smtp-Source: AGHT+IErA76QiWFcH7UPLGvZv64Oin3x3QAEdAW4jnjp4KbXcniSCMz1atP2hbElJp8KX19MhLFWdH+zy50EfDXYxhU=
X-Received: by 2002:a05:6402:401a:b0:5c8:861c:28c with SMTP id
 4fb4d7f45d1cf-5c8d2e736e2mr14027403a12.23.1728397499480; Tue, 08 Oct 2024
 07:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-18-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:24:47 +0100
Message-ID: <CAFEAcA-P-LWKKGr5iTJ+zLkRbY_jG674-tz8TLxagjmPYJjNqA@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] target/arm: Pass MemOp through
 get_phys_addr_twostage
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass memop through get_phys_addr_twostage with its
> recursion with get_phys_addr_nogpc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

