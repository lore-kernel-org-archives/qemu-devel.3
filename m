Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 10:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvDJX-0006Ab-8S; Thu, 20 Mar 2025 06:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvDJW-0006AS-0q
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 06:39:50 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvDJU-00016o-4E
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 06:39:49 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e64405b3b9aso431016276.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742467187; x=1743071987; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ds/ip6uMVbY3W1rFozS0PIZhGwDPVq6bfYjSuk8v2fU=;
 b=zf3dbh7u3BIXt3By11OAXV625Aq9gNo5LqUi3Yxs7wwhp51I7VAoviT5HCup7v8UUZ
 p1qIaOiZDJkrRqEQD499gv9VP9AI2omwdKDM/azARHDYYDyAlWYkNQbQP9Dpuh+wbvZD
 6GNYLq6EFXCdt6/qIprsITrT2M7vKzphtZWO2cUqDOvX8MXB3gZ89ryiVOO6nh9pDdoI
 gggPNq8XQ8zsD/j+VrA+8nVsIGp5dlFXkjpP4KadoC9nzN8X2doIEEPanKQC3MnSXFKw
 QfCmgE+n8Ap6s+8hVs1pNzm+Kh/4pLOR3il5FD1NcCakZ1Q2elNOPMHn6lU5f62TEBxw
 bUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742467187; x=1743071987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ds/ip6uMVbY3W1rFozS0PIZhGwDPVq6bfYjSuk8v2fU=;
 b=IGpFSQG/36vwX/q9dzCHiXAnW0VQ8RLZ6JAZlVM2HDO1JYctcsNn27Kl4MoaAehrIY
 CVeYxvYKdnTEcBgeasAoXM9lUnx8E6fRCMkWU5+VwcpSGCk93R6nf8wfcKkxsHgoADPS
 R7U9hvMgQ7oYzccAy5NaaA7RdOPLZYZ9gmoma7gIr7KFut3aeyNAEvaDuzyjHO++qmJY
 vRfDH0hnv2wwVH4ZeWuajTx10tJ+CiDXNq+nLYdyU7k8rGgiq7EX5AGZSmybFn6EP+e0
 mWUx2j+PtJW9G67bvJtEA195thSYzT6QzMGoDrKDWlgJKvow2XncOP+UpJ6nYeYF83+0
 qQPw==
X-Gm-Message-State: AOJu0YzsD2QhKfDHYeHTugxKwltbl78A15RqW8Le3s2s9TRBJ0C9MOtl
 yqFLfvceJkQ63mTLvsIRYqb5gORhYwdd1GOQhwR4VBqovOKBFAxRs8VXoj396d9qJNOFVa+ZAZ6
 FZl9qC3EuiHgZnqdX+x2/mrBnx+cx1HaPu6cwdg==
X-Gm-Gg: ASbGncvXm4csUCcqBC10aLJfRDb1Y22/jaT2M1BUCk4i1+QP/O3ozSFT21mIqJinfgA
 55OgJcN31IFKMimPOtjGP8j55+icE6oKrrfeRJTSIypjOwM6MfrUtsXh6OmjTdAUWAy053CYxdA
 W38YZ7sm+szhqx4oixnjk+op9cyMg=
X-Google-Smtp-Source: AGHT+IFhMLr4WuBBLgXRVpuaCu/3NPxDgQK5Ads3ct/q4nME5QUolsHMjNs72nSnKP1NTJ/c/BtqDgOCiAwtunhi7ts=
X-Received: by 2002:a05:6902:2684:b0:e60:b025:1a9d with SMTP id
 3f1490d57ef6-e667b3a1ac0mr7435390276.1.1742467186581; Thu, 20 Mar 2025
 03:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250309103120.1116448-1-pbonzini@redhat.com>
 <20250309103120.1116448-20-pbonzini@redhat.com>
 <CAFEAcA_orQ2Na9+MWnbyScNjQsDQBKB=s3c8D86FUE=q_1Mkaw@mail.gmail.com>
 <88766804-2004-476f-a437-c161cc04ab2a@redhat.com>
In-Reply-To: <88766804-2004-476f-a437-c161cc04ab2a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Mar 2025 10:39:35 +0000
X-Gm-Features: AQ5f1JrVvQjYwQn0axp_QhVyp2_iSJ4QfcSvgbXtlbtdKZvMrWXWVvQDq5Fi-xY
Message-ID: <CAFEAcA_kWGe2hxUAFefVvtrXykXFWFgXtXqZP-FjxFShX6ztFA@mail.gmail.com>
Subject: Re: [PULL 19/25] rust: pl011: switch to safe chardev operation
To: Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, 19 Mar 2025 at 20:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/19/25 20:25, Peter Maydell wrote:
> > Hi -- this commit seems to have broken use of the PL011 in
> > boards/SoCs that directly embed it in their state structs, so
> > "qemu-system-arm -M raspi2b -display none" now asserts on startup.
> >
> > The Rust PL011's state struct size is now larger than the
> > C state struct size, so it trips the assert in the QOM code
> > that we didn't try to initialize a type into less memory than
> > it needs.

> The reason why it changes is that it switches the imported symbol from
> bindings::CharBackend (the C struct) to chardev::CharBackend which has
> two extra values in it (a count and some debugging info to provide
> better backtraces on error).  It is guaranteed to _start_ with a
> bindings::CharBackend, which is helpful for the qdev property, but it's
> bigger.
>
> I don't think there's a good fix other than not using an embedded PL011,
> since you probably would not have that option available when using a
> device without a Rust equivalent.

(do you mean "without a C equivalent" there?)

Hmm. The embedded-struct approach to devices is extremely common,
especially in more recent QEMU C code. Generally those users of
an embedded struct don't actually poke around inside the struct,
so we don't need to have the Rust code match the C layout, but
we do at least need the size to be no bigger than the C version.
(There are some exceptions for some devices, not including the PL011,
where people do poke around inside the struct of a device they've
created...)

There has been discussion that we ought to move (back!) to a
"users of the device just get a pointer to it and the struct
is opaque to them" design pattern -- command line generation
and wiring up of machines would also make that a more natural
approach -- but that's a long term process we'd need to plan
and go through.

I had some ideas a long time ago for making "code outside the
C device implementation touched a field in the device struct"
be a compile error using attribute("deprecated") hidden via macros,
so we could resurrect that as a way to confirm that nobody is
trying to do dubious things before we do a C-to-rust conversion
of a device model.

For the moment, I guess the expedient thing to do would be to add
an extra 16 bytes of padding to the C PL011State struct ?

thanks
-- PMM

