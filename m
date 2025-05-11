Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63785C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6uo-0006Tr-76; Sun, 11 May 2025 09:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE6ul-0006T2-QE
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:40:23 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE6uk-0002Gi-6E
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:40:23 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e733e25bfc7so3437149276.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746970820; x=1747575620; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tQYCAYnSnMLVlXmM6Q3dpe1j9yqTGHdnD9s/TU+XfR0=;
 b=HotpwRbW36NuNVSfGe1axXApmQ3iOu8AoY9Ot4r1LdfUBkBfH3KGXmdpxipYCUouqc
 YorHR+XQHffhN5C2b+Ki/pZ0Sk7AEjUjwTNfJDWpgQEZuebUOn+C/jSh3K1+gefsYymm
 v7OAyZ2M6kWhGfmazhEdW1izdTeRRxlxxbBi0CDg2aBlkstY/AuU/e6yHVmQF508u8XR
 VIFPFgRZ7cJmz0dIAxb1QO250jpNAIR/8HvokOckm3/dc1mab/keZaM68MtkAxlyQkkd
 xNJESAkkjsWMB0lU7OCTm2ehwXkeYbEXlXlKOteQc0G/SLtd9S1PSNYdTbElnVzsB8am
 8kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746970820; x=1747575620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQYCAYnSnMLVlXmM6Q3dpe1j9yqTGHdnD9s/TU+XfR0=;
 b=sRE9BQNv7GgvMWVUvLJ/8GHDUpDHMtuNrKdrYSKNtstKwkM9aQntV/YeYlRi5ulHiC
 BntCCW6RGiZGu3Pz23EnnE7HPM0u79ptiG8crKuG97DPcRe4mOSVVxmgwr3FWO+p8vfX
 rIoUEjzrvbu+3kDUZZRu3o0VNHV1Tq4I+Ko5KMNE4fAPRLUO0sPDcYVuYskr3s3aAGOg
 2WLQK9HemGLMdVpHN40dgyTguSav6uH1d4Vw1xzW/m5qOtJwpc2uXbbZqd6QRofm/lPM
 Dn3cemglR1pqfqxxlBVx4JeLXtPxMD1UXtTf7iKdP3qukEBsr9Ur1ML9hclfCUofNYK3
 05Ag==
X-Gm-Message-State: AOJu0YxCU/TwJ0YAolCGewquvUM1RvJKOlMBtyILjifH8GlOvFtv21Ls
 z399gL0rmZjRKxqgizgksK0/jFPVhHPJQrc1Yae3pcc2ZrPkwvp4gQmKJhEHoxeDB0fq1tnxCbr
 ivvRJ6ypiv2/mj9emGj9MX/ECv/kXJcYJHCptdA==
X-Gm-Gg: ASbGncvuuVi937iy3mynCac/Q82a1X6oMLS1EdW07c3I9otURIt+GTolE+mcTiXyt5T
 i46ZHDomTVnTGFSMVVz1eWRHVGZWVyFVP3BHWnv1FVdfMSVU/ZlVb2XD2CZ7dTiaWpN8uOvB71U
 bmZDG7L7KSeQnGdMYnHrHHC7WOu/OMhUQV4A==
X-Google-Smtp-Source: AGHT+IE0KyLbfrS2S6y6k0L5Sv5Y/BL7XPKyq9u/1NkOPd9IMbHcYOljv/+I7+C94CfPc8CC+GuYQ3cEH7yDPqKhrqM=
X-Received: by 2002:a05:6902:2503:b0:e78:f4df:8441 with SMTP id
 3f1490d57ef6-e78fd9be186mr13405339276.0.1746970820155; Sun, 11 May 2025
 06:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 May 2025 14:40:09 +0100
X-Gm-Features: AX0GCFthFJShMwduZaRe8unlmupmQOaRCZ993P7xtVVqY51NCVV1-mxoKOxg2B0
Message-ID: <CAFEAcA_NgJw=eu+M5WJty0gsq240b8gK3-ZcJ1znwYZz5WC=wA@mail.gmail.com>
Subject: Re: [PATCH v7 00/49] single-binary: compile target/arm twice
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, anjo@rev.ng, 
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Thu, 8 May 2025 at 00:42, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> More work toward single-binary.
>
> Some files have external dependencies for the single-binary:
> - target/arm/gdbstub.c: gdbhelpers
> - target/arm/arm-qmp-cmds.c: qapi
> - target/arm/tcg/translate*: need deep cleanup in include/tcg
> - target/arm/tcg/cpu*: need TargetInfo implemented for arm/aarch64
> - target/arm/tcg/*-helper*: need deeper split between aarch64 and arm code
> They will not be ported in this series.
>
> Built on {linux, windows, macos} x {x86_64, aarch64}
> Fully tested on linux x {x86_64, aarch64}
>
> Series is now tested and fully reviewed. Thanks for pulling it.

Do you/Philippe have a plan for how you want this to go into
the tree? I know Philippe has been taking a lot of the
single-binary related patches. Let me know if you want me
to pick it up via target-arm.

-- PMM

