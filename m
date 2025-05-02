Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED28C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAo0P-0001T5-9e; Fri, 02 May 2025 06:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo0N-0001Sx-Rw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:52:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo0K-0005e6-GY
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:52:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso11398665e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746183147; x=1746787947; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oUVzgC11QpKdPu7ROAmRYT/NvXT7iHXXqRw9BzVHRSQ=;
 b=ATHIzmLv0OBbtqdnwvsdMsncOXUfUbwlIeoLJDEAJmCXEEmUx8OOkuyBwfW6mCTd2o
 67gEM0Eyd+RKIwcngZTgEa7+MO7H+OaxlE4n88CeQq1/caPLqd3tI5Usk+OxJXJj9rB9
 H8NiZhXzc0h4RHYecQUxTT3k5DIs4pjI2I81Ur3OHjdnCCRQAZ6PK5BxNaI3lWsdZnu7
 hLqcFb8kcbcyQhtdMbOv3WNkvlHGOEEnlPoyJOt0BxUlqBoK7v5moj2O2ndOaRHqfg/w
 QLF+kc6Tg2QAT/rSkqkfURK2ptaUh6khoHWohvghfPI6xOpuXWAXxCDnzX0aWrVtBmqr
 JoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183147; x=1746787947;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUVzgC11QpKdPu7ROAmRYT/NvXT7iHXXqRw9BzVHRSQ=;
 b=BdlZGazAh3GAYaLRXajdnt35o5W+g5j4dQs+11WB8T1EhDKU3ubZqQwh3pIV1QQfVv
 H+JgXIVY0wFQBAZFfFocbctspEhT14s0vDIx9lq5HMF7+1cPiJ6fHiekVTGQQns9WNgz
 G17CxhMLdtYjpv1j/IcYE/m9hfbTwJZhsUAOIoxqHf5gG+GcawP1nM+eY/bQa+st5Vdk
 BDz8Obu4AHVBoSgLmjX8iLOHSaFQ0NtRzSnkbBEV/F4sL6WKTPNIF6nEYgcG2M8TRS9l
 ful23wIvLFibG4YBlethHvbdPyvhtHWXMimBiE8hh5AlcTlC4/TtGU8RvGPKCrYdN5DE
 R0UQ==
X-Gm-Message-State: AOJu0YxCPw5ShtXSYmx64UYnYg4LNb48fpvYfAHmMu23TlETwp84dsgr
 s2bfzr1L1Hh81z98Si1XJvEyh2GIQnY2UmtKALCjAMLQXEUMfBMLlc35/gLCirWET2yhMrWMHbF
 KOGQ=
X-Gm-Gg: ASbGncuiGcrLB10MPoZXYIRj2Y5MHYcXc33ykGobHdpiBwQvr0DGpsJzjT2JL70zo7F
 hd36lZRnca4QkPEqohQW6s1xe7EfKb8LaIL5Z5nLYpO3krwl9Qde/hwgHCDl6lPwoHGrmf+CU67
 G68Y6dDnSvwKu5i4RVceCCmtBPARd0pi5AlIr566jcw+N70+mobzvmgRMM21fgoqGYCFuoz59Wk
 kMbCBuCK3lY9Jt3hJGN49H7aXOSRhC2EKdMEtippPM+DBO/M3pobwi3o6kySd/Yw2GE0svvTiAJ
 JixYDPBOOdsuEpWlCAO05FRn/9FVFmEuqtDdZkybAECn8+YBPKziis/XVuTCPsbG4QQUkjYvbsi
 X8HHcZQ==
X-Google-Smtp-Source: AGHT+IHUfcQKuUH+f3wgigbmZlaM2HYe6JpbXOJ+GqesF5Kcs7jrRZHYy+pwIC4xS8fcZBIx0/9Psg==
X-Received: by 2002:a05:6000:1a89:b0:39c:30c9:822 with SMTP id
 ffacd0b85a97d-3a099add511mr1534614f8f.30.1746183146707; 
 Fri, 02 May 2025 03:52:26 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0b9fsm1783131f8f.4.2025.05.02.03.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:52:26 -0700 (PDT)
Date: Fri, 02 May 2025 13:47:32 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 7/9] rust: replace c_str! with c"" literals
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-8-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-8-pbonzini@redhat.com>
Message-ID: <svmrjd.2xrfuqhgty9pb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> docs/devel/rust.rst                    |  8 +---
> rust/Cargo.lock                        |  1 -
> rust/hw/char/pl011/src/device_class.rs | 11 +++--
> rust/hw/char/pl011/src/lib.rs          |  6 +--
> rust/hw/timer/hpet/src/hpet.rs         | 19 ++++----
> rust/hw/timer/hpet/src/lib.rs          |  4 +-
> rust/qemu-api/meson.build              |  1 -
> rust/qemu-api/src/c_str.rs             | 61 --------------------------
> rust/qemu-api/src/cell.rs              |  4 +-
> rust/qemu-api/src/lib.rs               |  1 -
> rust/qemu-api/src/vmstate.rs           |  2 +-
> rust/qemu-api/tests/tests.rs           |  9 ++--
> rust/qemu-api/tests/vmstate_tests.rs   | 15 +++----
> 13 files changed, 32 insertions(+), 110 deletions(-)
> delete mode 100644 rust/qemu-api/src/c_str.rs
>

<-snip->

>diff --git a/rust/Cargo.lock b/rust/Cargo.lock
>index 2ebf0a11ea4..13d580c693b 100644
>--- a/rust/Cargo.lock
>+++ b/rust/Cargo.lock
>@@ -108,7 +108,6 @@ version = "0.1.0"
> dependencies = [
>  "libc",
>  "qemu_api_macros",
>- "version_check",
> ]


This looks like it should go in the previous patch ("rust: remove 
offset_of replacement")

Otherwise,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

