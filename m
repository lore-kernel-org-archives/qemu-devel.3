Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04660C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsFE-0002JM-QF; Mon, 05 May 2025 05:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBsF5-0002CR-QI
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:36:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uBsF2-0002tV-8S
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:36:06 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso7772748a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437763; x=1747042563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1qpMR+Q/kjChxa6Bop8ESXoZDWcbc4HZXmKnxbYAUY=;
 b=cCjj+lLpZjfjSLsfG+HvXZ/dQeCy1N+sOmEx2Fj3w0H2VfGbGvHb+L1Undx2iVWJrb
 z/kp4Pe1gQ9LNhm/fqE0IyW1zEc7WD+xjEoadarhNpMzOym62PWaSgQ/BPc2C2KTs6y5
 f3vL3CXQ5PZMvxP4EHhcIVoRUz6QwDaRlTY5G6MNLe2F2RRFiXgN+VkqmuQetfBLbI+s
 HHcbgM8B6SwHQlTZCGkkF6hkn/+ZtFmeqB4Lq0xb80dk83hBAtZ37ASb8pa3yJpYJ6dQ
 JK2NyRjbvGly1eV6G2IzaOXUscF2FEPMnpHFCRvOhCgsegI84p9iN5NzR1tPvpPcXo0X
 XSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437763; x=1747042563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1qpMR+Q/kjChxa6Bop8ESXoZDWcbc4HZXmKnxbYAUY=;
 b=PLA1pLsN1Q3BA7XSWGMbNAGBhppywTtOJZESzcvau8zA9zMwzw3DDQOmPfE233E3Sm
 0QM2lu+v7Vr5Hr2omvl4U3y6371W8U1USZdzDl0Z/3QVMv4a/v1y9PX/+2iy6HOt94kn
 UYB1cvyx6nrqHQnhnBPd564y4GUrmlLDsxJXwDT/bMINbt6+ohIgPHzPyIJld7HvQ4ob
 AVFjGwcZuJeVe/wH9iSzGdpeiCWFq5gUgzszuPi1PshfGCRGC5hylLZSJ/uzsokGyfCo
 d3Kdcjv2rXdHnc3//qW8oqw1W5PvlFYdTm5kG6PgWPf4pwJmOXv5OlxEfK3kCY9fO4eq
 Xpyg==
X-Gm-Message-State: AOJu0YzkCx6R4lVXC9/gUFZMM0PfhZBxD2zb0XV5tEDfJ17pt2ZE0SUj
 nwlXKZY7aujL///a/hM3kWKEQyqlWFZLWqxM7kl/Kf3L440K/pVS28cgtYIJIPrvAIoYb+zAEzX
 AL+LysFlSkAPZ+xT1v+87ZKN2BnxrGAepaeC19Q==
X-Gm-Gg: ASbGncutyH5nDLDWKzpVPAnYPrBzokofofW5SmE8/WExnTQ1ncpSUU0wMa3VUYfNJRB
 4Nj9Ym1xBY3WGpEGB5D+VnTBVUxmIuc3sAOWrHwnMxrUZcuejieRFR1g11BjUSlgQ5os/hEVDAT
 UV8E/JHfpu08NafShSatjO
X-Google-Smtp-Source: AGHT+IEMgi7EPWSHAjxSPAl34WpBIE+Fmc6j6NKuVNglWMpKMoAYu81hIYNCPydbLSS0VDFfZ5SGma/K5k08ETsv4T8=
X-Received: by 2002:a05:6402:2709:b0:5f1:e466:660 with SMTP id
 4fb4d7f45d1cf-5fab056d2a8mr5077894a12.5.1746437762790; Mon, 05 May 2025
 02:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-12-pbonzini@redhat.com>
In-Reply-To: <20250505090438.24992-12-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 5 May 2025 12:35:36 +0300
X-Gm-Features: ATxdqUGmyrfYUvID5ghYaxFx8w7XGhVmPgrWLPC1ubzaHeioYKJvD6nB9LWlIdE
Message-ID: <CAAjaMXZkku0kov3ocZ8E6C9VMh-nuPt96kuyhrFCRQB84G0oxQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] docs: rust: update for newer minimum supported
 version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, May 5, 2025 at 12:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Remove leftover notes for Rust changes between 1.63.0 and 1.77.0.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

