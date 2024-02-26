Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D62C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redmb-0003qC-Lp; Mon, 26 Feb 2024 11:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redmY-0003pX-55
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:46 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redmO-0001Gs-TU
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:24:45 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so5010086a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964675; x=1709569475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vR7946qHB7+4iUdASnofJkurKOXitHS5prg4KT9MhR8=;
 b=whve5BI92b9P/IhWji6Hw8w1VIe1gHtl1qE55vQ3sdziTlucaQUuKt5gczhbfytznm
 9V6I9Qn8vp7Mrjx2uv/aG32rZrHS+rTS5XXpwr47GKg+EzaGUJvBYpG6e9oWh7E//+QD
 w2UORVbJmcXCQ5kvcqLI+fMuyf69pJxEQxhk/XgiWHAFWTLxwR69a3lIABdMNqQq1gOH
 GA3s1GAzOKu+5MV/w+oWAIO7t63JiWzgDWvco0UIWduc9I9C3jPMzABCMw/5SjhrmF/b
 9kBQpSm8ziSVhOYmK972OGWv6mZbQPUEfryCp0LWtbT2GiPy/2Ibh/aiPbwh44vC8Jv0
 Wxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964675; x=1709569475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vR7946qHB7+4iUdASnofJkurKOXitHS5prg4KT9MhR8=;
 b=wiTSSIJCG4MAGn1K/utUJp4gcKrVBmqD7aLueuNmOSvNko4/qAPZPflNEBh4DuZxx/
 dJKhxI3FFmf4OguQt6BsXDmO1oDwLri5i4gRgGs7DlByXIWfaP/gR5bkRIzBHaMV+smQ
 bi6sTAS8pxZLfmv0VH+hcXi8z+yRjKZCRtsX7Iq1bjZ26e9QNPdBadVBQuPpXnMj1jjZ
 cjMcQISFBq4AYlDsqzN+MBiZ+6tKQB8Fls+/YyzpuhQ+E48HdQ1+96qKkcg65DfXIZTj
 ffHl7CjimrDmog9Nl5v6NM+xuxl+x3YfRw//8OUILdsewGK6WqWAYxQciH0KSDjwKvpK
 zeCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG3JTTuWDqN2+kOGvuS0n2MLMyn7FdrocpsrBnHyiJNJN3KqEgril4ijoja5m6LGOREQYqWafwzVn+EfGOyx3V6trDBtE=
X-Gm-Message-State: AOJu0YwGk7lC+EikHglMS+qyZcl3e0EYClhPLwWOyNsJysFSiNrcGR1k
 mmLd6v/Eqi/AqoxB3kjlcjRHyj56xe2vkoo6D4IaFrefydyHwpLZDG8iyzuVFl57sczMprxLFvA
 jz+8bfJdBhAL+idrcNNYB1S0U+2ThbK6+ahDFOQ==
X-Google-Smtp-Source: AGHT+IFLmAEaACI5Pg906MlhEVV9VnEOknTctfA6YQg/tu+4vgsMmJD5P47cRYzyLSpGdOUBEHkWL3X962cn+y70734=
X-Received: by 2002:aa7:c615:0:b0:564:26d9:b4ac with SMTP id
 h21-20020aa7c615000000b0056426d9b4acmr3820310edq.41.1708964675632; Mon, 26
 Feb 2024 08:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-37-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-37-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:24:24 +0000
Message-ID: <CAFEAcA_Afm-RggHNEUcniPmtKyKfJJ_Z35M_-roW8meSmz-TQQ@mail.gmail.com>
Subject: Re: [PATCH v6 36/41] Add mailbox property tests. Part 1
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:06, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.c            |   1 -
>  tests/qtest/bcm2838-mbox-property-test.c | 207 +++++++++++++++++++++++
>  tests/qtest/meson.build                  |   2 +-
>  3 files changed, 208 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/bcm2838-mbox-property-test.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

