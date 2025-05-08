Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCDBC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD4VB-0001sB-Su; Thu, 08 May 2025 12:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uD4V7-0001nv-Cr
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:53:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uD4V1-0003Mo-JA
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:53:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so236658166b.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746723207; x=1747328007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBNybP+TcZ5rdW6x2MUvnW2KjssjQu7JnqBve6N5cww=;
 b=StsBUOwCqkhlI1TOK55nExPGZdXYwvW9Zpxlp/3q/41LuZAUPa4xjE0MtBAWKUuy32
 SuVLhiMo1Wc5YOQmfdG+F0uS65DsAV6/kBzdmkVi0we//m2cYnz3pQbXuARQP1mQnuCK
 WXyo+4P+FKKowgr3s5S/EHLh44TaVZzeLW/Jn+OnNHHGAvW7OK8eh4GOWLjT8yPW+Qaw
 q5JlQQMwuErOAQAer6f1hYOwm1q8KEABKaE6zvfQezi0/Ii83Rb0F89x1j6vFFTNiQvw
 8mMe+amEUPtP1nn9vnawYnpfOprHnblRuzCIFaSp/qKHg2JaihcZOkgfU29lz5sXjEj7
 SuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746723207; x=1747328007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBNybP+TcZ5rdW6x2MUvnW2KjssjQu7JnqBve6N5cww=;
 b=SCa1WP4VWPuzToFIelvR7YtxYtmk2Ut7FavlFLLO3+29t0kuqAKHB/vg6TyFtbIDvH
 SzGeBUioIWqD24RKYgSxbBs0IHrpq4FP2ZNjUAbps5bLOIpPXAbIxz6uI3LjiZA2thjl
 C1BHfBSUvVGMhO5BQSV04WTHccdiPeixwSewMmDQy5QdwPSs/4EZmlSjamRlhHyZjS13
 5IjrcPvHMTj6edpdNckmVl6C19hbpoQrOc1gvjgdqt2mlLgxjov5XK/EZ45taY0gIQ8v
 XIoOIlDzI75/j6CoWYn8mi4jT7rUAu6wl++seszd0IoEs+VEGMLmzc/vZMT4t2fi9xrQ
 t0QA==
X-Gm-Message-State: AOJu0YwUC8ykiiQ7P6ICpuJhZ/ybsXQBDOa+AAZiYwu1hkgj0J/Fxow4
 fw6A2BCMuE3cCGbckDmp6sUm80GtNjevY8rxIVWESlVxneOYbhXY8aBO+CjnMcEHjONNNKjRfTt
 jJo6CnKJw7Lj8k/hU6ukoQEM3fD0=
X-Gm-Gg: ASbGncuSk7eqavcM5R70j2MnhulKpJ64wx9vEaLnLt7giiFb2z6RfFwq06KNNiVq6jB
 bAD/q6j4G4iKISiGarWI8+bPw7hNTHN2r9fv1tO6+mxeTm2hq8ZtUYjr+5NBjyoMM2xqI3Wow98
 zp8kVVfYd26uMlL57ok6ux
X-Google-Smtp-Source: AGHT+IGereiiTcVsxTEHYP9jnVfMvNeS4gWtviq6T/k57GgyozEZaxmfGoXxaAtGEZU8wRU492pIq672K+guhVjN0eI=
X-Received: by 2002:a17:906:4796:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ad218f22586mr44795466b.23.1746723206703; Thu, 08 May 2025
 09:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
 <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
In-Reply-To: <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 May 2025 12:53:14 -0400
X-Gm-Features: ATxdqUGsWdwfoCcbv8VNXeQDGFQC6O81i62GU7I9xjYErnhp46wICkqAfQKPo8o
Message-ID: <CAJSP0QUw+oaJeQcb05Cia5iKPXy-HDoezgs3NKj1j3BXkWUjWA@mail.gmail.com>
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
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

On Thu, May 8, 2025 at 12:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 5/8/25 16:26, Stefan Hajnoczi wrote:
> > On Tue, May 6, 2025 at 11:30=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> >>
> >> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d=
2eab8:
> >>
> >>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qem=
u into staging (2025-05-05 11:26:59 -0400)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >>
> >> for you to fetch changes up to e6b9b79c3076777b791f72ebdbc9d37ad8005fe=
9:
> >>
> >>    gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)
> >>
> >> ----------------------------------------------------------------
> >> * ci: enable RISC-V cross jobs
> >> * rust: bump minimum supported version to 1.77
> >> * rust: enable uninlined_format_args lint
> >> * initial Emscripten support
> >> * small fixes
> >
> > I'm not sure why, but the following CI failure seems to be caused by
> > this pull request:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9974291215#L4684
> >
> > Please take a look, thanks!
>
> It is a transient failure; it reproduces 30% of the time with
>
>     meson test --repeat 100 func-hppa-hppa_seabios
>
> even without the pull request (commit
> a9e0c9c0f14e19d23443ac24c8080b4708d2eab8).
>
> Before finding this I had already sent the first half (which should be
> safe since it's all Rust code that isn't compiled on that runner---and
> for hppa targets in general), but if you still have the merge commit
> perhaps you can push it?

I will add the pull request to staging again and keep repeating the
test until it passes. Thank you for looking into it!

Stefan

