Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F24EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 11:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu92r-0005EN-AP; Mon, 17 Mar 2025 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tu92d-0005DT-47
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:53:59 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tu92a-0007yT-Vw
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 07:53:58 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e63504bedd0so2827672276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742212434; x=1742817234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pPe/7/yUQFRB8Elsl01jkfv7Oja5Bi+E+6DbLmo998k=;
 b=bwZjc2wBo1X7q6keHAQ+1KDi7RLK+x8o0KG5SEZzKdXwdG/ScKRanUoCICYj4K49Go
 xbFLeyKxJEHDWjsUqQ/AA1RGwuy0A1ASpLTjwXxYOwq433p/OcLdgo7QJ3bGAqqfgo7F
 UmkGltjjF2KOhpGoGa3CS15SIPlv48T98b97nEgV+IPSnZmdALs/ELZiCnSUKmdbHv0/
 YXJ6qn/JWNiOtGTHbSkatlTxgv5S2tsZ6V/9o1C/3/qsfdOJ4i+tg0ihj3Qc3CJzv6EF
 TeWN3C8m1LvrTijGHyX76p/I2mGTEPjJJqk9SvPB5ZHdxEqtzZPBImBBZBcnrTEczuiq
 ecTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742212434; x=1742817234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPe/7/yUQFRB8Elsl01jkfv7Oja5Bi+E+6DbLmo998k=;
 b=Ejwu0hbS6qmAecxl4NObcXWAFpcMz61mZMDIJhV3pkohSzlTcYEXg1VhjGJ0S1VrE8
 0VPHwMqxyEKN+/FsaRCjLPHfwOBjdgqIgUUAVAFMpnDpX7cmgq++Eyric9tKOr3rObMB
 eTT7n9D+GVmAPNpsaO70H6kaHL7NX7WLmvqTWWmH6SC7/vKDR1BjuI6V8IQbRAwTcDbu
 aODC3Sz4ZU668J7IjJjjSgOn/mTiUK6Vcd8mQFAw59PdowyTaOGiG3kilRq+E4h15neD
 uO1GD2Oe71i71zgwQUY2uNfoB90GLbFsE4JSEH18QcmzoTxhof1M1e9lxNFpL7Q8EWHG
 2Q0A==
X-Gm-Message-State: AOJu0YzHLjfXH9JziLC+TnER917RdwAXjUSqjxV9qk9qdqY862+pYbzn
 fkP+knT3dJQ1+dcFya9UXozMQm+g3szhSVijwiWImKtfgLi44N1jDDFdinQh9Zhqy6V5qzcP54P
 hnNdDDM7abSb7mYH4X32jz2Z6sLpgveQK8cyadg==
X-Gm-Gg: ASbGncuimUbQaNzdJ8AqPN9xDFtIratEw+DMC1IdEEk65at9UFBwXX9zWq8XGKZvHxS
 fFzeOz837AWDhztjmix6Ux20tFKliXT9xcl2EboKUHhRVQZkbG+wA7L0ZOT5hcZ527cIZxckxsy
 9TE40X5RL2i+Ek+Y444ywjYRVXN8E=
X-Google-Smtp-Source: AGHT+IGkM90m6MNtELPBPZZPgdMV9jm4BAePYqZW8a3P7L9zfRD+b4O53LjfmATaxhaFbu5RqMseaChuWkMTqJrjCmE=
X-Received: by 2002:a05:6902:2807:b0:e5d:aeb7:6e62 with SMTP id
 3f1490d57ef6-e63f64d236emr14202391276.7.1742212432444; Mon, 17 Mar 2025
 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
In-Reply-To: <20250317-raw-v1-0-09e2dfff0e90@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Mar 2025 11:53:40 +0000
X-Gm-Features: AQ5f1Jo5nBE7BSVUIahWWqdqD8IY585B7lrGv5MupP0LJ7p1lUOZobD71SQzxls
Message-ID: <CAFEAcA9Cy_870gxNmPFykzTjXOfi0raotmA1NRpZEQKfFfB=0g@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: Flag PMCNTENCLR with ARM_CP_NO_RAW
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 17 Mar 2025 at 11:16, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Supersedes: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
> ("[PATCH v2] target/arm: Define raw write for PMU CLR registers")
>
> A normal write to PMCNTENCLR clears written bits so it is not
> appropriate for writing a raw value. This kind of situation is usually
> handled by setting a raw write function, but flag the register with
> ARM_CP_NO_RAW instead to workaround a problem with KVM.

I'm not sure there's a "problem with KVM" here -- it implements the
write to PMCNTENCLR to have the semantics the architecture specifies.

> KVM also has the same problem with PMINTENSET so add a comment to
> note that. This register is already flagged with ARM_CP_NO_RAW.

What are we trying to achieve with this patchset?
You can't write to registers from gdb, and reading PMCNTENCLR
just gives you the same value as PMCNTENSET, so you might as
well read that, which we already expose.

More generally, the gdb-stub access to system registers is
something we put in on a "this is a minimal amount of code
to provide something that more or less works" basis. If we
want it to work better (i.e. more comprehensively, possibly
with write support) then we should address that by looking at
the design of doing that more holistically, not by making
tweaks to address individual registers.

Specifically, I'm not really happy with adding explicit
ARM_CP_NO_GDB flags to everything we currently mark as
ARM_CP_NO_RAW. Either we stick with our existing
"minimal changes to produce something that works" approach,
in which case we deny gdb access to NO_RAW registers because
that's easy and most of them it won't work or doesn't make
sense. Or else we do the actual design work. That might turn
out to mean "we explicitly mark no-gdb registers rather than
overloading NO_RAW for this", or it might mean something else.
But we won't know until we actually do that design work.

(see also https://gitlab.com/qemu-project/qemu/-/issues/2760 )

thanks
-- PMM

