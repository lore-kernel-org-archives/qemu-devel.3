Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1658BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGa9-0007R0-IW; Thu, 03 Jul 2025 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZg-0007HB-5B
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZb-0000Rg-0a
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:49:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71101668dedso79661247b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536182; x=1752140982; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=774daLD4EuUx7EjQ7j7tn33lXFslNY/Nw6XQxoMeuF0=;
 b=ZIS2cdqerDziKB+HTG4yadx7CsvXcwfih5nZVlhuBbSaDGc+y5Wr+1t6BkBktyTNaC
 1UUdQP4WSdLNHGnJw4t9uZ/AGv3cWdZ3ExLz30cUBkVAm1o+g8QOihjebtJ0xgig7bQJ
 ivG1EuYgnGRODJH8mVMTR1BliCm/XCfc+ma8JgaFDz+mG1xjn4u24z87ClBLMsDfw+dL
 a2XB5nuBuwws9Rlk9fRMLUZHV1xpSBrDoCRSV8XONEcLCVz2BF1JEebw2K5AD75AwuVf
 NUWeG11cNeJVlUswYQZO1y8+YSl0E4ptcbmYqYAtbiXzTAix5RnB8g9QB9+EGLQLjmwj
 ksiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536182; x=1752140982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=774daLD4EuUx7EjQ7j7tn33lXFslNY/Nw6XQxoMeuF0=;
 b=gUQm72dprYlwwXN7UCN8IRRWGCyEpjj9cWWr3UXDiJYwPtVlIlYzzI6RkvL9Fy5d+c
 Ws5AmyH4PCSIcyQWaJfcFL+PLOTCXe2gNtWn7WFm6Cf1lsigLNaNcGVLZ4Eob3/cCnOY
 5lDZKjLnY3LbVFIJ8ZozTSZOB1gbh3qxawHXwOeT78LF9FjLAOj1A0Of4kmSwb8DYJN7
 ZqeqY4J2mhtYcMB4GahLoo2+x52Ls5EdD+fXcsDgHtBKQYFB9XNy4uLs79jRk3akM1hM
 ES6CEgYptR08mFl3d4B32ERb8IRLt6qTcXWB5oKgjc35dKEXeKExyIyzR4LacLhWfL5m
 RUhQ==
X-Gm-Message-State: AOJu0Yx1D1b3tY+ilEBNRAafXj5AmZ1lLuEEMcSdUJPzQ5GhyADuJINm
 pdqiCLxPi8xffeg4jVXw5fy3YnhIdEHOl1Ou4cfM95sIH9GDw/Og32OjVa/DAwlDTM8cOX8u+Q3
 B/JcgZ1geeU18KFiYHZRrZP+gExMG0jbD+BWdlVkeuw==
X-Gm-Gg: ASbGnctLTYWkAxB13Flu1E/MID0UcTMaP1XekQU6nKBI0UqpZN/FwbIJLMFmyALCKHg
 MzAYjs/qnrlcoIpYv/WLP3SyHtaCS12a+L1ijJCESRbb22hfGpUorQ1Qz+apmvzG1izpW6UtBA9
 jeW5+b6Jdjt5vXzA4STwA6sfshKFfHwj1ChSDXAkZlmQ+3
X-Google-Smtp-Source: AGHT+IEXqHU8NqJE0GnYcJBQNP6Z0kBQFaYhWo4xdiLTXQXwwGOVyhXRu6IakU9zy0+dPKaOZF6J2Z/XHUyjAa+H8f0=
X-Received: by 2002:a05:690c:888:b0:70c:9364:2c62 with SMTP id
 00721157ae682-7164d523ab6mr81786677b3.25.1751536181939; Thu, 03 Jul 2025
 02:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-34-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:49:30 +0100
X-Gm-Features: Ac12FXxViCj3uXkfT-RUryE6O1_jry1TeT6ke-F8AJRp28sAC__uZ0wNVBwQHIQ
Message-ID: <CAFEAcA9i9HQvLTaN2nJJPZbQQUu6c7uM1DjsVd-k7vvNCeGKkA@mail.gmail.com>
Subject: Re: [PATCH v3 33/97] target/arm: Tighten USDOT (vectors) decode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to USDOT_zzzz_4s and force size=2 during decode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

