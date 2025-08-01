Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74D0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvEC-0005Ce-Lw; Fri, 01 Aug 2025 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtcR-0001zR-C8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:32:38 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtcO-0004Js-R9
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:32:34 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71a379cecd5so14014607b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069552; x=1754674352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5jPkiWHbUPThppPl+luXkxtjyryk2G8gE/By7kD/9zk=;
 b=UW/WEqIXvTaIdGDZGfI8ZYmxHJ8mismwZEyquzRAPIPpgvv/LbQRsnhYfnyNijZKjF
 QwtQgbCxjsJDTdStpZhh+ZIvXJnqsucAFeNMe6OQ8IAYQGcHcgiZD2iMf2WVR7AHJndO
 GOBjPnD2LO/7mg+Z2zr1n21xp2L/s01kNBYYZFr7i6Q4lFGGU5yCVNnzjZImxZvf8Pwi
 aLwR5URtz24vv7Vm/PW9PyGDMPvwz+Zc9iWPniPAFLEX7SYFsHjqkL+Y3lWVbPZoyGO3
 iKgXk9FpwN7TowTrPX8P7qf6+VZ7Uhzy8876nEwuzCG9XpLhu8YxEaK8XAa/roevr/2V
 zcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069552; x=1754674352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5jPkiWHbUPThppPl+luXkxtjyryk2G8gE/By7kD/9zk=;
 b=FT6ne0oGXyQY7Iu5iiOBuRUX5090ZKN+XnenBzb74Dn/w3FQh2g+9/YIlK8tE7DxoG
 ydm3danURhqbjwkgZxHAe/dl5WTtN0G+HTLEoF7dkkwo39ZxDNfixdUlTLWeTHGLWrPw
 qdHvJ99R+hdsJoCOkdX/sIhAOEzM/PQ8WeoVwOzkoHlo6mo1tEpAlMvj50BBoEDuM5nZ
 4u90/GdcZovMImgtWqEzWsQ193r2HP8irIWdhizYYyB5uCKmEY8acofbOQCki5Bk5LeL
 zpWkq24QsqCgM1DlVRaEr+miR5xtP5Xo4mc1Yz28GxxgrQi5yydUlC3tgrMrh1dl8JTw
 4X2A==
X-Gm-Message-State: AOJu0YzIWMn5kUeOfwU5reaCl12KVEmfhwFvfH7MU6VA0GeZpKvLGAzx
 UWCAf8pPmzxaGiThDLVT9GJ1rl6JK5CBc1uZSwhhhaPMu8TnwlxWFADD2UkasoEHiTGltXrDomp
 T4Djs4ax+TLgenfWKCSPEuVPElMhU+ynzk4NwshVDGg==
X-Gm-Gg: ASbGnctJGZCcRjQnSi5iOIbNVWzjC2Xynj6p6MNV9F64mD78WdIn7PlQyTvaBSrA2JA
 9kC6ZzX4SO3bhF+a/H4Z1YREUA33XJPlvYHKgsO5Rp9SXo/wV22PLVcnYLd1xJZrOGqMxF2Lm9V
 jlBaNhpbdzGmHARmn9bDvgnWFMwp0a+3R31TM6AjLepjn90mMhXq278updBD2eaxSoYMOj7ucwP
 fSZSGCN7K9TNnJ1Ja0=
X-Google-Smtp-Source: AGHT+IF5ZAbyS+9AfGsUWBswR9J54OOvbqb3zsE83Q7bNqghN0BNP4tz+paoUkdjRSOrsBQU0ZbJ+T4ooEbFZ2P+ivM=
X-Received: by 2002:a05:690c:d8e:b0:711:406f:7735 with SMTP id
 00721157ae682-71b7ed73e4amr8466187b3.13.1754069551710; Fri, 01 Aug 2025
 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-36-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:32:20 +0100
X-Gm-Features: Ac12FXzuYU3P9BZPwVg7AkYp5Cm6w3-Q1Uo2Np8ooblyGlOZmjd0fs9EtEE-EFU
Message-ID: <CAFEAcA-gKnDDcj=t-JUDy47FVGmnPFTFpMKusEVGM8yysHzVaA@mail.gmail.com>
Subject: Re: [PATCH 35/89] linux-user/s390x: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Jul 2025 at 01:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

