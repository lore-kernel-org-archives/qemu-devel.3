Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C8DC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OWO-0005Lk-7k; Tue, 21 May 2024 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OWM-0005Kx-03
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:23:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OWK-0008VL-6W
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:23:09 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-573061776e8so8742649a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294186; x=1716898986; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q7fiJhhXww+FJgd39GDUtcCfdsk7ZM3c4QyHhDGWztE=;
 b=Rko/JGwNkc36zoQddsXTP9TJHE+4CY4P4cQrUtqUCVgiR7Yi99ePwdlhncJIXQ6OJt
 u7FAmGeXVW+YUdHFd2a/4X+Btw05d0UnooG8ASzdIlCYyvwmMShoJ0GT3u401uZeaSiG
 1sc8JRI0m6p2BPlP3XsIVcNhmAHc8IO8hNEccbojxjtw0g+ISNXCOB0KTXJN38RzIm4S
 D8oeP9LFADh1FxaDDuBFFlsalCHggb5FPmIOIhwsqGnvwUfhB4z1yAw8ch6MJaPhxs5M
 n0qxyOepxyBTsEQ37WJgntb1mHtOlQX00QmX58vyUp7887VUP4hq3AHzMyX/d2FdRPaG
 b5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294186; x=1716898986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7fiJhhXww+FJgd39GDUtcCfdsk7ZM3c4QyHhDGWztE=;
 b=PYVQRohpBvG++6aAqs0Z1QukDCu5v1BGH/YbIlIRybFlyuwYREjcv9h+HogEAN5J7K
 esFvyv9O6k76/lonriOKcJ+wHvmBju9AYDerwKHM+71G4pgslNn/7qnkFoqvAMPsCP1W
 7alYKERvJ/MHRG9nzjz7at3xtQ/ku8rqpdTjGcmLpfWhEwFT/9WrAgdThsA/YJFSQNAZ
 8o6eg49Q9zqjUdSuEaFoGzMFVTIZNGjn46SURt1qk4yNF+Uqb5JVnp6gZswSsl8HkU10
 2K1Ue6P+i3K4dvqsc4UawHHcSEpgBEt9PIfFi1dEC7Rebhpri+v4HNA/USySJ4S5BnXl
 12Zw==
X-Gm-Message-State: AOJu0YyEb0FVhSvoRXkaZBE/OUJTSKRRoIvJF2jytE2vkrKVlZO+sv2T
 1dJbADU39TWKK+mOVrq6LteE6diSjbGNStUYWuN/+EAeoDTkEIycovBLUuIDgj2mo3EBKGCydCz
 b2ZT5nKgttnmt9GfMysz5TsPx98qenETuqzQE7Qtj2+B1woZj
X-Google-Smtp-Source: AGHT+IHb0Q/2Ce9Nju/XZxhh5YfPSYmsvO+17gNibXSv2s/Rposds9EPMBmE1WYexqy1CgsHq3Cx4yM0VF58mQzoTYE=
X-Received: by 2002:a50:cdd6:0:b0:574:ecfd:8306 with SMTP id
 4fb4d7f45d1cf-574ecfd8f4amr12762089a12.25.1716294186438; Tue, 21 May 2024
 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-7-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:22:55 +0100
Message-ID: <CAFEAcA-u-yNmQqPgGSbEy4=7ihf7JjAJgGa1OG28B-ux0jBLpQ@mail.gmail.com>
Subject: Re: [PATCH 06/17] ppc64: Clean register values in reginfo_init
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Smash the stack and thread pointers to deadbeef, as is common
> for the other architectures.  This allows us to drop these
> special cases within reginfo_is_eq and reginfo_dump_mismatch.
>
> Do not copy the unused special registers that are packed into gregs[].
> Most of these are related to system instructions and thus are not
> manipulable via the user-mode instructions targeted by RISU.  LNK and
> CTR are not initialized by risugen, and since in general we cannot
> test branches with risugen these can be ignored.  This leaves only
> XER and CCR as the only special registers to be copied.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

