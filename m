Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E96BC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjZG-00085l-OO; Wed, 07 Aug 2024 12:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbjZA-000817-Bk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:31:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbjZ3-0004cC-K4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:31:10 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b5b67d0024so2743488a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723048262; x=1723653062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yC1fVLP0m6q2Ty/806ArxrDiB9rB67kSGOHKekXBjBI=;
 b=BbXlzIU34955nXoVQBCcPfGvf1rIYF0BIfbYKiR53Ynjddi3yY2Q8ddy8st5hWvAoO
 Z4c5V333r0qjEambI0gr3VnJzau1DNR8VBbdZ4mgY61lvNOFlwc3o1RPeYcRd+yaCSeD
 /uqxLbpcyNJJhTcDApruVbDsDKFdIL5Cl9m7MRx9WTsvGsdB9uXGoAsb5q2JWGbNXINH
 3UnvW5bBMMjE9HaY9/gdMJSYcLMa5gd+7tnKzsdBjaafRoZPcZ9ycMnHjI4WqioQky9v
 cXFtLajfR5PsNYHvWVkWMB9BG3y5xxM9KUqJk4zDLBcLP5djn3FSETrlU90QdY1jTtez
 QQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723048262; x=1723653062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yC1fVLP0m6q2Ty/806ArxrDiB9rB67kSGOHKekXBjBI=;
 b=vlLspoSdVvrNsmgYbRlsiSR+jrzHa76bx5+aAQ1y0LDX4J71g4S2AvUCdF3PDs3e57
 ZoVIz5/cn4D/7hl9toreMmbBBSnqkXKckg74XJFnhjp7d/ZADSUc31sbubNpl0vwVRBA
 srvOVK2hiVu8jzLgeXgbrW/n8b2k6yhir8rVmbnK6QlRZvDED8MJMfedSLKD0U+gKQV4
 934pbQaAh4q+0TL5ABN0kiI/M0RWRDAMzEYrUSxRAeJatgf2WYsW0vB05rEe0LP4dq5u
 U2DJCVujGoogo2NfKEa4I6XAtQA8JraJOfg0YLt35//R7rTyLgXCtKTNFaUQN+0Q3UYv
 xdjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz93Ch/j4kS4W0jEQ3qzHHQfwxvmwV1G1xfLDU9GFKVYbnL99w8RPDpylTxUbVtqtsnNwT1pXY96UmeYMSEd+ePfaS8mU=
X-Gm-Message-State: AOJu0Yx7mA1h2pO1ssuWkiEjMj5SXOAaRclFNqaLT/jH1gW22CPxgnS3
 xn79fhE1ul7eTGS+tYISxEtXZwmnZpvNN3Ct7cZAZNzRFN7iwzHBjVybTRU+5thADXjmlqqLmcu
 N8QiRUK/HdvVvST1+4WwSYg94Hkt6opTrnsBgTQ==
X-Google-Smtp-Source: AGHT+IGycXmV1WsgErxIFrVpotA4D3gX5LZxM81oeU11rGDf1K7FuZFFwj9k/j4bRN6U1/Xl3ulwNx60JKdUaw9ReRQ=
X-Received: by 2002:a50:eac1:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5b7f0bd6f5cmr13001299a12.0.1723048261852; Wed, 07 Aug 2024
 09:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
 <87o764yce3.fsf@pond.sub.org>
 <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org>
 <87h6bwwpu4.fsf@pond.sub.org>
In-Reply-To: <87h6bwwpu4.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2024 17:30:50 +0100
Message-ID: <CAFEAcA_2pJA47K72qJQX9bc8sBcA+0wJGaf3KAaYJaRurjQD7w@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 7 Aug 2024 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
> Having to manually include a configuration header like CONFIG_DEVICES
> wherever you use configuration symbols strikes me as unadvisable when
> uses include checking for definedness, such as #ifdef: silent miscompile
> when you forget to include.
>
> This is why Autoconf wants you to include config.h first in any .c: it
> makes #ifdef & friends safe.
>
> qemu/osdep.h does include some configuration headers:
>
>     #include "config-host.h"
>     #ifdef COMPILING_PER_TARGET
>     #include CONFIG_TARGET
>     #else
>     #include "exec/poison.h"
>     #endif
>
> Why not CONFIG_DEVICES?

The stuff in CONFIG_DEVICES is target-specific, so wanting
to include it should be rare (currently we include it in
only about 25 files). Any file that includes it has to be
a compile-per-target file, and generally we'd rather avoid that.
Plus it's a bit odd to need to change code based on whether
some other device was configured into the system, so I think
that's something worth restricting to only files that effectively
opt in to it.

thanks
-- PMM

