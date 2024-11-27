Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE199D609CE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFa7-0002gt-60; Wed, 27 Nov 2024 05:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tGFa5-0002gZ-8b; Wed, 27 Nov 2024 05:47:37 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tGFa2-0005tv-OS; Wed, 27 Nov 2024 05:47:37 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cfcf4df87aso8346326a12.1; 
 Wed, 27 Nov 2024 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732704452; x=1733309252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqWWSR38pm9XZuf9l9gVDfbprOIXXiabbYo3rYiYBaA=;
 b=hTmeLWfad6RmkfIqjxIWYiJbEOVn4KEo8lfbe9PmXuWOTGLIex+V/qpDPPTxgvHAkL
 dnGCYf6bslxwMUuqRPQBUNY3LuFE15YBNVaplqJzvLknAuwnygSsrcokRnXca8IR0nl1
 gegDjrnbYpI1qyynV3mmY+YYkE888sQHA4pa/EXdwhuOcWjaGLPGAWJIJdZlAS0jNIwF
 yXGbyGPdpjhDzXXA2ZPZfruzxeXjiBqQOX2Qs9k4HvkxaLBDyixOSIo1Z/wMcgufBNwS
 cbro3CVv8j5qo3LazY4L9E9q2kReaiOnnAtFNz7/R0VX0a1v7vhzrhAm/MsPTkFk44zu
 GjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732704452; x=1733309252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqWWSR38pm9XZuf9l9gVDfbprOIXXiabbYo3rYiYBaA=;
 b=bUfhctSZl37UvudhzxsZ73OLsjolJFwbkoyKMARM6sPnzoNI4U9lm7xQxfOfN6aV6b
 l8OmKDIYxqWuvl+n01CRMtRrQQ6b7CwnJ1WafD21fUVFun5yGN+GTQG1vttIRw6y8C11
 2oUp2oJY9QY7WnnFf3xw/J/h9P17XivEU3+d2MIIxmXEG5RKDgLmi3bRCPG1X7ktJX4j
 +Cdufq04B9c64ZhqeDgZEXB7ck3gT4xLxjw1K5kPbhQdj5SoyeiZxqxFL0brkOq8qgfX
 7KUzGqlE5QbuAgmEaDFYO/hEsuM8dJR4bJm2FWEWwTl451xdAHkNJKwOyc+jrjbTwCgQ
 AXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4xQv01sldgTEV3LI4Dgbfv810w6SDOdiMgrB2PDvnuuDoFtDXEEVg3Yj8SbVPyHgjpSo1OYVf598=@nongnu.org
X-Gm-Message-State: AOJu0Yzrg33D+X0tI4i4+bkiBVy6PJG15UQAdKzTFBuenV/X8hGKNODU
 rzBdKCoMjLmDyOOiJ6ux+nlucNp8O15hSPwXUCgrQnTR2m+2VLgrw6eB0jcR4s8Op1s7k5uEOtM
 sgQduIDb3i/I7MeQ5u/SuUcZgoFY=
X-Gm-Gg: ASbGncvPHKwCz8hNlT8BECNp/9zTVfR2XJvvMIwxDmxZdUxO8Fe95t0b4VV7RXcim77
 8KQGFydcNuOcJf6crgwJh0fmU3WjWqA==
X-Google-Smtp-Source: AGHT+IE6QX+JE6qXGAJ/nKVAqqs2Ak++yumdU9G5LKLwGmLpQCnxbiBFBqElTNma+Ra6jVT2DDicuB7wOl2VpwxBk10=
X-Received: by 2002:a05:6402:3481:b0:5cf:bb9e:cca7 with SMTP id
 4fb4d7f45d1cf-5d080c5d07fmr2451701a12.28.1732704452037; Wed, 27 Nov 2024
 02:47:32 -0800 (PST)
MIME-Version: 1.0
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
In-Reply-To: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 Nov 2024 05:47:19 -0500
Message-ID: <CAJSP0QVGP9RQ57V-+2Lo2Se0x0O1KuENT24HzOn2X3A3vmn73A@mail.gmail.com>
Subject: Re: Rust in QEMU roadmap
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, 26 Nov 2024 at 13:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Tracing/logging
> '''''''''''''''
>
> Tracepoints and logging are not supported yet, and no one has started working
> on it.
>
> For tracing, it's not clear to me how much C code can be reused and how
> much Rust code can be automatically generated.  This would be a valid
> Outreachy or Summer of Code project, as it has a limited need for unsafe
> code and a well-defined scope.
>
> A pure-Rust implementation would be interesting, but note that the usage
> of printf-style %-based field formatting is pervasive in the tracing
> subsystem.

The purpose of QEMU's tracing subsystem is to support cross-platform
tracing. Instead of making QEMU code depend on a specific tracer (like
DTrace or LTTng UST) that may not be available across platforms, the
tracing subsystem generates tracer-specific C code for trace events at
compile time. The most straightforward way to expose this to Rust is
to add C functions that invoke each trace event and then call those C
functions from Rust. Tracing is designed to be lightweight and this
approach results in more overhead than in native C tracing though.

A pure Rust solution would be nice, but I'm not sure how to reconcile
that with the purpose of the tracing subsystem, which is to support
the various tracers native to QEMU's host platforms. They are geared
towards C and use low-level techniques to generate low overhead
tracing code.

About format strings, QEMU tracing is not about format strings.
Otherwise logging would just be used instead. Trace event definitions
contain a format string so that tracers that offer human-readable
formatting can use that string. Actual tracing is not about string
formatting though, it's about typed calls to <trace-event>(<arg1>,
<arg2>, ...) where those typed arguments can be captured efficiently
by the tracer (e.g. stored as binary records). Depending on the
tracer, the format string might never be used, be used in a
post-processing step during offline trace file analysis, or at runtime
(like logging).

That's what QEMU's tracing subsystem is today. But it's a low activity
subsystem where things can be changed with less disruption to users
than in most other subsystems. I think it would be nice to look at
what native Rust tracing has to offer ad reconsider some of the
requirements that shaped QEMU's C tracing subsystem. Maybe we can take
a more modern approach.

>
> Logging is a small component of QEMU and it's a good opportunity to define
> a coding style for C code translated to Rust, e.g. how to name enums and
> functions.  My only request is to allow using the same syntax as format!()
> for logging code!
>
> Summary:
>
> * Simple, low priority.
>
> * Anybody wants a small project to learn Rust FFI?

