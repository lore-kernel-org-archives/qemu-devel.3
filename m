Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5131C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHqZ-0001ZZ-H5; Thu, 23 May 2024 19:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHqW-0001YC-CN; Thu, 23 May 2024 19:27:40 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHqU-0001cd-GG; Thu, 23 May 2024 19:27:40 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681919f89f2so252465a12.1; 
 Thu, 23 May 2024 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716506856; x=1717111656; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OYbhwqjz8pW1dz54VSOIdlLzXg2gMVeFGgIy78z4wc=;
 b=d28YYiUQR0t7NQZ9eegITtTPQAEhgz9Y/tNPFZL1tR/0o9NSqjHD7H/ZZLyXiVOP25
 Ahxf7b6OsNjQNKHgVqEWLzWOWcMCQ+LgTAjltnp33EUAyBsVnRw3/ibcxdD5A+B4mKun
 ovi9tMgQ6uNvmvnczdgeLkMPrAlUYStHiGLwqX6Ktg3gaF+49ernoG2B7zvuUMd0ZT5S
 5EmbO/60ksbVxFBftyRBxO8HMxVCUftbO5o8pa5Ho34sw31H31iPRQqDIntlNTXUTzCx
 8ipLxgEBPx8S2Z5hVTOvkr2Rl2ddfB1DvwbCGsBDarTfAk4APAMiLqYJ5E9U4DQ9/mod
 V+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716506856; x=1717111656;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5OYbhwqjz8pW1dz54VSOIdlLzXg2gMVeFGgIy78z4wc=;
 b=XQJ8GUijtj/umNRvV9avx/Mahhi8NNtJ8jvKeuKdN7sXAWgFC7KhkOTnRU4xqkaGed
 r/QQBi6jazNSRBXAslX17xfBqWZ5TYRaSiQ4NY9mMDK9JOMf5MyZOnsCt42A3P2gdvlg
 LRMp33p/whKkWRgz1fMrNo8Q/r4OI1q3L2Lt7p7D3DKKWJGL2NkpJ2aDe2N6KnHUjHnC
 vI3paMfiQc4O7XLFhUIXAWKPd9rbgibIWI2TF9k572vyBkBihtMSGyAkgiD1tM1cNSSK
 8ZreUF2OX73CSoBDiDaY9z0I5dLoZwqUEf0gEEvqP5RMiVFGutjfEFRGjvgesNr1Ttp0
 QWwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd2NYWmeDGHpTa8Wf8/YWIHaloJTk84bbWmmGLv6F8Mm9Sb7HVMoLT9C+wt859Tf9wfzdR0Pf0qvoyjB/Z2rNIHenQr14+JyE/BfMEcM40j/U9GhF5PIJ64BQ=
X-Gm-Message-State: AOJu0Yx9HVr1N/L7SA8SD1xxscPJL/6ICTMCcpqqJdzOxuYsCtCm38ga
 ccPqG4v2BBAVUnENP+AFk/NQY0KXa2Hx/ZFi7cZsRt9Qe7oAZtkb
X-Google-Smtp-Source: AGHT+IHrgDHgru9tLDSGF0iSxFhUwsBmjQuR5X/bcbhYfVn41MJaYFRwRiiekY4gJ2dKTIJADceO5w==
X-Received: by 2002:a17:90a:a00b:b0:2b1:50:cad4 with SMTP id
 98e67ed59e1d1-2bf5e84a5d6mr691462a91.1.1716506856207; 
 Thu, 23 May 2024 16:27:36 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf699abed8sm37358a91.1.2024.05.23.16.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 16:27:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 09:27:29 +1000
Message-Id: <D1HEW8JJFC0I.3CUC58PW2DTFB@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/2] target/ppc: Fix PMU instruction counting
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240522040411.90655-1-npiggin@gmail.com>
 <39f33a5d-a9fd-4469-ad6d-ca0fe844f571@linaro.org>
In-Reply-To: <39f33a5d-a9fd-4469-ad6d-ca0fe844f571@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 23, 2024 at 8:46 AM AEST, Richard Henderson wrote:
> On 5/21/24 21:04, Nicholas Piggin wrote:
> > The crux of the problem being that dynamic exits from a TB would
> > not count instructions previously executed in the TB. I don't
> > know how important it is for PMU to count instructions exactly,
> > however for instruction replay this can lead to different counts
> > for the same execution (e.g., because TBs can be different sized)
> > and that blows up reverse debugging.
> >=20
> > I posted something on this out before, but missed a few things
> > (most notably faulting memory access). And found that forcing 1
> > insn per TB seems to be the only feasible way to do this.
> >=20
> > Sorry to ping you on this again Richard, it's not urgent but
> > you're the guru with this stuff and I'm hesitant to change it
> > without a better opinion ... Simple band aid for the meanwhile
> > could be leave it as is but just disable counting if
> > record/replay is in use.
>
> When we unwind, we know how many insns remain in the tb.
> With icount, we adjust cpu->neg.icount_decr.u16.low.
>
> My suggestion is to change restore_state_to_opc to pass in either the raw=
 insns_left, or=20
> the inverse: tb->icount - insns_left.
>
> That'll be a trivial mechanical change for the signature of the hook, fir=
st.

That gives me a better place to start looking.

Thanks,
Nick

