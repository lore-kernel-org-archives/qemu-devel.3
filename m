Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E381C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqX5-0002dF-43; Thu, 27 Jun 2024 10:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMqX2-0002Pr-55
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:55:28 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMqX0-0007ZV-9N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:55:27 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d1d614049so2068679a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719500122; x=1720104922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VfZrO24J1ywPn2M+YNZ4MZv1e6mCkcevNQGBQQTbeEg=;
 b=efbdMaPVfrFWD9FyQ4+15/tC9tCyCfk5x20Meh0N2AENOFehi2v7ueE5tRuw2wJyEh
 3ckmewxXnMMJZEHyvMgCHlmMR2+OqvpA7jnF1iLWuzpawd7Ph6kafTsR4cBOqUYWR9dc
 ih45Oelw/KpPmWvdZCL8P2B7ZHsaWY1/a+W/j52TztOSPAXBffgZ5HQVaO4xBYcFpXag
 ouXRmqBCbP1ySZj9NakZmpuLk58m5L6rrkLGiwjwTCtYAU19Tgh/yhkZD21+/tlI2Ykt
 VaKmOHkMQv3zuBiiAPtaYrCzEG2tUsLwD2CV82qyD4qo/+xb7ZnSZq7znte9q4+hBVPH
 zEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500122; x=1720104922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfZrO24J1ywPn2M+YNZ4MZv1e6mCkcevNQGBQQTbeEg=;
 b=hJxwndx1ilaxvZHDHp8JoCW4mVI4DNo57FPjeq1gNdwYK7gf2hpPn6c7bT/lkOotyM
 I/JLRRBcVLEPlGxBiNbHMEHS4FHwRYZHXKq3cHnO2DQV5wKYY1ekusVQuvg7R12e/L+Y
 Zihx+Fe2f/NSrZZtSwW0Qlj0nkpk+BYNSwT3JzyFDvCb+X3awSPkdv/tntwkkKvrZGcR
 2opXvZB1fs45JKXiNJbTRKIjDB+JUtGmAgBXGuT9/IPNHQJOdF3YJJHXx33f6MSoKty+
 XiXi9/0UkOqNL1pjRDdpLguJQ9Txsv0qkvNPxDJfir/K4Y4WMCPz5fldwGSscHVLAx6t
 V6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCty2qeF2irUtFLhShWPGTzCrkXj/l2QGE5dHyToWbRC3+bWo/0SYE+sUA0L7BaN82jZ6brxBJy44B0d+akZx2qpTJjm0=
X-Gm-Message-State: AOJu0Yw8NEAmachy2V910x2pPc4LHqpafhUL+Y9QWz/4lyTRRhOQR9Fz
 iAMCl4juI37Kf3kNduneGlFNfRPpyryUxn8TBSCJJO/TeOUWVU7PDB84rwn4BuZYMY0sR1A50rY
 T+pG2PKGtp3TWEblqDqokJnKbaUHMh0r4UGdKhQ==
X-Google-Smtp-Source: AGHT+IEcr/wG5HaM9W2p0PTYMVQPLhqeAf3k+QGQPxmFlG7+ngmDACS/89T9me9mwUMFhkKVqpENL9AbRAdrqKmShrk=
X-Received: by 2002:a50:c30f:0:b0:57c:a422:677b with SMTP id
 4fb4d7f45d1cf-57d4bd537fbmr11491502a12.8.1719500122133; Thu, 27 Jun 2024
 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de> <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
In-Reply-To: <mvmmsn6lawv.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jun 2024 15:55:10 +0100
Message-ID: <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 27 Jun 2024 at 15:27, Andreas Schwab <schwab@suse.de> wrote:
> Perhaps you should refrain from attacking the volunteers that report
> bugs.

I think the tone of your previous email was extremely
terse and didn't actually answer the question, which is
quite easy to misinterpret as hostility.

We're all trying to achieve the same thing here, and the underlying
problem is that we can't reproduce the fault you're seeing.
So to help us with that, you need to provide more precise
instructions on exactly how we can get the result you see,
or else provide the answers to the questions we're asking
to try to get more diagnostic information.

For instance, this might help:
 * how exactly did you build the binary (what source, what
   compiler version, what OS, etc)
 * a repro built binary
 * exact QEMU command line

Clearly something is different between your setup and
Richard's and Warner's, so we need more detail to narrow
down what that is. Warner's questions are trying to find
out more about what's going on.

thanks
-- PMM

