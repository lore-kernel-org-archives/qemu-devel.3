Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FDCDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 19:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suGlo-0003tC-5k; Fri, 27 Sep 2024 15:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1suGll-0003sc-TJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 15:36:49 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1suGlW-0001qX-LW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 15:36:49 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e04b7b3c6dso1280748b6e.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727465793; x=1728070593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGxUslVb/JD7odAm9wNpYa0ugEjNTxHtH2g+q40DFlM=;
 b=PqQhTon8lz1OEl9fm1QEwbfJBwsfO/VallwjpQCstovPt06o2FJvHYFdhv/zeOzwdV
 zmty21JRRa1XpD5nccKQML+gvHve2ufRTBzmz4YuZ6u+0/BSZaqyCb/DVNSNzJid1SCz
 NdzhSbPOvsGWW5DAprGRm2ZOGzNAVUwYll5tv199osAlUs7eIvXd8bJzj++vTW2wa4sY
 egBOlWSI0/ErNu1RjNG3j87G1r3L2IA9f0ipHoqJfDF+9WijuJyYfdz83paclioPtnSu
 72y9kxs7//Jc0d9Z8BneRMaFVbdC3hPtCWc7BzIVWiOOWI0myxmozKW5cpI8d39eMj+d
 rMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727465793; x=1728070593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGxUslVb/JD7odAm9wNpYa0ugEjNTxHtH2g+q40DFlM=;
 b=Kc+KFh2wGsi4U+G+l2TKzC09v+nA/47RgRX2QaHLbtMzJtAR3lk00G8qMfaJvPHadW
 3J31s7Pys7Zw7FgzemFk3KJHpe8UorP+C9xGl24eRE4qNXU85wXycIM4sWapOpARru+a
 9AHBQBtbmS3EJifEln21NeaxWawQ9byd6BsBUDmOJbRX/ibDIdO5+N+cJd+8c618KLXH
 nPHoIAtBXywyD4o63wpDeU2nMOuSFlPD+Rk70TLsNibPIhQmcsUpWSLNApSt8ayyfzID
 25/yhd3wUVqKXV1YL+EKRH2R18Fmr55VAbJkcXhFKKjr4ltz/jJFF85bnsYCffmxPnJf
 vv6A==
X-Gm-Message-State: AOJu0Yx53eyLRc483JCetrjWtb3gnFoGVOVqpbkRs4zjT65HE0BQIGK2
 jgQqEX6pQZYaCLF3YVryQ+mRn6voRibSNjjEXPD7lnnJHMq0d/FawbI6ScWE5CJ3QkXLb4vETh6
 526LtelG0fOtpYF4zo9xPWvEioAw=
X-Google-Smtp-Source: AGHT+IHJqjBaRrBQe1XNaIbEsyZNNTN0mceA2psHxx4GqZtRKzEuTIdJqtovXaOX8jpM67pR0nny1pyquj9J3+0DBY8=
X-Received: by 2002:a05:6808:3091:b0:3e0:4546:49a1 with SMTP id
 5614622812f47-3e3939dd089mr2658247b6e.35.1727465793097; Fri, 27 Sep 2024
 12:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
In-Reply-To: <20240701145853.1394967-4-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 27 Sep 2024 15:36:21 -0400
Message-ID: <CAJSP0QU3iT9REzdciVZBhRWLtQXtoabJ9Jb=S9Maun1cDb+WFw@mail.gmail.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 1 Jul 2024 at 11:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> +/// A type for which there is a canonical representation as a C datum.
> +pub trait CloneToForeign {
> +    /// The representation of `Self` as a C datum.  Typically a
> +    /// `struct`, though there are exceptions for example `c_char`
> +    /// for strings, since C strings are of `char *` type).
> +    type Foreign;
> +
> +    /// Free the C datum pointed to by `p`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `p` must be `NULL` or point to valid data.
> +    unsafe fn free_foreign(p: *mut Self::Foreign);
> +
> +    /// Convert a native Rust object to a foreign C struct, copying
> +    /// everything pointed to by `self` (same as `to_glib_full` in `glib-rs`)
> +    fn clone_to_foreign(&self) -> OwnedPointer<Self>;

I expected the return type to be OwnedPointer<Self::Foreign>. Is this a typo?

Also, why is the return type OwnedPointer<T> instead of just T? I
guess it's common to want a heap-allocated value here so you decided
to hard-code OwnedPointer<>, but I'm not sure.

