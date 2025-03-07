Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90D4C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXuK-0007LN-Gq; Fri, 07 Mar 2025 08:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqXu9-0007KN-1G
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:38:22 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqXu6-0004O2-LF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:38:19 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e6182c6d52aso1297106276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741354697; x=1741959497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw5sUSnklijdo29CgiK62N1n84MNDZ3JoG6l3xvNkUs=;
 b=Md9SEzd2YSvtbg7svE3Z8mzmtAjRnwJizU55mTuvIQLXu9CJxaFFufnUXVb/c4u7Wb
 sv87IFAJB3GKDUVBWTt+mtqpdasqDNjHJeptauK+kK9KwLDMDHTG1RmlfO3w5ry4mS/G
 fhawqvsNwD0yAVoIMElV9jSaDY3bX0VCSrCJNwTlmH+iJ7kWObDaQNoHCYp5UE339u+S
 13d8MVQ9bueazGYZhPCITmx9JDRRtB7UWcgic1Cne4QxFX/VNFCD1bPaxBDKh2f9I0sb
 DgE3RviAB2vBYS4FDknGRiFHeggNGJEoesmYRawPrjC95/6+VwcAledMkovD04AMrxS1
 kzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741354697; x=1741959497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cw5sUSnklijdo29CgiK62N1n84MNDZ3JoG6l3xvNkUs=;
 b=su2meKKHoaullBGjmUDv8KoCs6OGji9CV5r9obntQK1CR1JHL3ESyvaUjGDIO2MUje
 WErDbTBiaaoNqFsOjKaKFtqyya26AZEm8cx7LqdQdBRvqkn/cT81c2wt9kiOjFNJD+YP
 Rh06Ulwnl4VT7iVD3KzLZ43zxoJE31tsNxe0mlDTdTAisNaliohRWQIyVHENZBIxnnqS
 X8JJFfEVwZDUAUlpK0XDcq4ReROQGEBuARlXdFde1Kyy922HeLoYiO5grMZPZ2fax8vM
 4LosOKkgAQAdzGmhcZZEeKbDRQYVwZAPz6GIqiakRp0uw+r5Ar7yQL277T2pSrqiEKen
 3LkQ==
X-Gm-Message-State: AOJu0YynEMsSeTVRoTnXjqKuM0Kps131JUtzFdZwWfe3mPj925foogar
 /FiOHLWJLjwqFMx0tWRAANBK4oa5icmY6agGCD/+3kKrDtrEsQAwpoAmFkmrpNpsX72Zce2p2Ja
 IMQyR1AeNOKeWXOixw4QS/JMBsxa5wj29X/4ZnvcnZRWZhK1P
X-Gm-Gg: ASbGncsxBKubQG0okRwU0WzY2ZskYnjx7ehvv36O7/nVepcG6Ib3CHFgQ+VndZ9RMVS
 B2sh76ivEvv3k+yBPRCvlkx+SLzEDHl0eA+hjqEM1tfep43r2OG7OSjcInwbTluSDCwo7NXJIjg
 0TklMACwUtgeweXkAg4Lq+FcWMJY4=
X-Google-Smtp-Source: AGHT+IGs1jI1Ybyc+35mMJ4xP1lEXtKZbNvE9GvZIqtMLRtoJpy9RJnIFOJnXno119rlo02O/AxMvIgUn/FxJ6Ev00A=
X-Received: by 2002:a05:6902:1a4a:b0:e48:7efe:57b0 with SMTP id
 3f1490d57ef6-e635c1dcd07mr4234571276.47.1741354696984; Fri, 07 Mar 2025
 05:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-5-keithp@keithp.com>
In-Reply-To: <20250218212103.2024039-5-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 13:38:05 +0000
X-Gm-Features: AQ5f1Jp9ir4sy9kabwEDsR7eSJm-Su2jqvHCrOY7hmZ-9yCl-b_qsB0U2rC_vK8
Message-ID: <CAFEAcA_5tnaXvGXXp17=LKNkr6+BWcaEBpLj3YxJ8-np1hSAcg@mail.gmail.com>
Subject: Re: [PATCH 4/4] rx: Support loading of ELF files too
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 18 Feb 2025 at 21:23, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The existing loader supports raw binary blobs with the entry point
> defined as the start of the blob. Add support for loading ELF files by
> first checking if the provided filename has a valid ELF header,
> falling back to the existing loader code when that fails.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>

Ths code does what it intends to, and I'm not saying we should
definitely *not* have it. I do think it's worth considering whether
we need it, given that you can already load an ELF image via the
generic loader (-device loader).

-kernel is a very "do what I mean" option that differs from target to
target, but what it's ideally supposed to mean is "this is a Linux
kernel, boot it like a Linux kernel". Some of our targets also
overload it to additionally have the behaviour "but if it's an ELF
file, load it as an ELF file, not like a kernel" (notably at least
arm M-profile). But I think that's something I'd consider a mistake
in retrospect, which we can't change now for backwards compatibility
reasons. (In particular it means we can't have "-kernel kernel.elf"
mean "this is a Linux kernel which is an ELF file and it wants
all the usual CPU setup that Linux's booting requirements mandate".)

So for target/rx, I guess what I'm saying is that if Linux
kernels for this architecture really are usually floating around
as ELF files then we should support that, but if this is just
"some users would like a way to load an ELF file, start at the
ELF entry point, and do no other setup of the CPU or system before
running code" then it might be better to instead point those
users at the generic loader (which does exactly that job
and does the same thing on all target architectures),
rather than adding a second mechanism for doing that.

thanks
-- PMM

