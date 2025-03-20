Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D846C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 16:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvIOH-0006E2-98; Thu, 20 Mar 2025 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvIMG-00051Z-HM
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:03:12 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvIME-0003Ti-2i
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:03:00 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e64165ae78cso733989276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742486576; x=1743091376; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+Sf9DL7K6o+3a/CLwhMlF23h8gEkovuxLF/f3YhuR4=;
 b=SmfDgrFD4TFzEqUOYz/LijT+mdmhUFdbA2t8YY3g/jXUT3mRYomlXrOu2yzmG8y61S
 N/8WOELP0V/7nUHIqB//EttTJeM70zkKOi7nCR56VugPv0fnfth9ufXsVvCxZ4a2tj5J
 Eh8e1m3A8IxbVoaeRaPojYbECGzJ/MNIm79aSCg5CkOZC1WAB1ossYkDguxACgo3fORo
 HSH3ZNaWvq75W4x/i4P0lCqdVScUxESUu5pP6U1/haz/rHaS7j91zb0Kpn0jGBRe0+I4
 O8JYmE3W1KNrcdFYrhxfixCclpj7K1m6ODT+Yxfwxad3f/+fdA0ThzT53VfzunONeNXp
 c4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742486576; x=1743091376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+Sf9DL7K6o+3a/CLwhMlF23h8gEkovuxLF/f3YhuR4=;
 b=EGFtV8gtb23cxL2bB36Yv+AQnppLoYBW8lVdnk4KJSASxmxZPtQs/TwJ5qdZOVEQsC
 faUUSe/SD+cNEN1YdqN5XJFjQBqvXk1B3co6bWqQUX0HbxQAFG/LKY6hiCb7+G0K69iD
 bbjTUUV613EOXT7NEwxEE9XCIYTrdI6JCZOxGd9ZiqCZRnt11tqYnwKpr0fITyea9aQh
 7qj3yxC9da5iEIdE98nVMnglFT8q02ER9eNFgHWCTbrACzJGQedBvZ0KbWJgD7agCzFZ
 xT8EbMlxTVeqwBALF+W3NcEk07ByHQWs4aEOR412kI34QATktqEGXdEkaM5UkVeC5Fi+
 TnXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOt0sWmb9cKV687akvQp7pLszMB+gIWgKOGtkDR7bNRabqcGBlIKFZeuyi60dX5e0qT0fkMDPoWczg@nongnu.org
X-Gm-Message-State: AOJu0YysFc03K14da/JsMdQu2KfXx2ksYdIf661RQVybkXrPxzSnDJGf
 xb4FFY7VsAWRJx8K5eN/fKo5p5tHfM4m8XiDZzrbML+okJ/LXWEXx1cU5/3qp1S88mr99bbtlx3
 RpwZrbqapbabK7ObpDM4Z5uMDphpvIYnDtiGbqw==
X-Gm-Gg: ASbGncvQzbRUviY02y3aNI17hWcbyroHJeuKvNyIQ6o2X/BbPUA0NywVxdY96MPzSGX
 bJy5WYARypm4XGb4MpA1+/fdKz2Wuudc8NvCFw0jIls2VJlX3v6u7q+aYnCisuT6jd2DVC8/YGF
 2NkveWCocpA8APEGVqL5De66AVYv4=
X-Google-Smtp-Source: AGHT+IHOGJxL74hU+ZOWRasmt8OgxZU29Z0iCJhpLbFMOceqkftW1cuXMsXuyvXGaXnAMglHSE9s8x8OySGSm6bHavs=
X-Received: by 2002:a05:6902:a83:b0:e63:d10e:edae with SMTP id
 3f1490d57ef6-e6691fcc667mr4844297276.9.1742486550621; Thu, 20 Mar 2025
 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
 <20250320133248.1679485-4-peter.maydell@linaro.org>
 <Z9w4Gttv8QeBRKfZ@intel.com>
In-Reply-To: <Z9w4Gttv8QeBRKfZ@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Mar 2025 16:02:18 +0000
X-Gm-Features: AQ5f1JosCL3C1qhXgcxEF8zsqSxe893cvDN9OzDYbgh3vZyZOvh4FvKcapkpXjc
Message-ID: <CAFEAcA_BQOtzugW31ke=sit1mKnvxieGC_GXLOG4=MK_O2mKqw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: pl011: Check size of state struct at compile
 time
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 20 Mar 2025 at 15:25, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> > -use std::{ffi::CStr, ptr::addr_of_mut};
> > +use std::{ffi::CStr, mem, ptr::addr_of_mut};
>
> maybe mem::size_of (since there're 2 use cases :-))?
>
> >
> >  use qemu_api::{
> > +    bindings,
> >      chardev::{CharBackend, Chardev, Event},
> > +    static_assert,
>
> This one looks like it breaks the alphabetical ordering (this nit can be
> checked and fixed by "cargo +nightly fmt" under rust directory, which is
> like checkpatch.pl).

Yep; I put it here because I started with Paolo's v1 patch
which called the macro "const_assert", and then when v2
changed the macro name I forgot to move it later in the use {}.

> >      impl_vmstate_forward,
> >      irq::{IRQState, InterruptSource},
> >      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
> > @@ -124,6 +126,12 @@ pub struct PL011State {
> >      pub migrate_clock: bool,
> >  }
> >
> > +// Some C users of this device embed its state struct into their own
> > +// structs, so the size of the Rust version must not be any larger
> > +// than the size of the C one. If this assert triggers you need to
> > +// expand the padding_for_rust[] array in the C PL011State struct.
> > +static_assert!(mem::size_of::<PL011State>() <= mem::size_of::<bindings::PL011State>());
> > +
>
> maybe use qemu_api::bindings::PL011State directly? Because bindings
> contains native C structures/functions and their use should not be
> encouraged, I think it's better to 'hide' bindings (not list it at the
> beginning of the file).

Yeah, I wasn't sure what our preferred style approach is here
regarding what we "use" and what we just directly reference
(and the same in the other direction for mem::size_of vs
size_of). Is there a "normal" pattern to follow here ?

Speaking of size_of, I noticed that Rust provides both
core::mem::size_of and std::mem::size_of, and in rust/ at
the moment we have uses of both. What's the difference?

thanks
-- PMM

