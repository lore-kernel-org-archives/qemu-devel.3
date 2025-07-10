Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59709C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZwzd-00070v-Qc; Thu, 10 Jul 2025 15:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZwzV-0006yY-5E
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:31:33 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZwzT-0001xP-6P
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:31:32 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710bbd7a9e2so14230557b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752175889; x=1752780689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U+CVoHFDG09GyMpm6YXkqKO/4WQ7emjQmymhG7B5z3Y=;
 b=TJJwUvi8wcvd9zaP/XfEdmu9hCB4rZg6cl8DAAbnvHhKTFvU3fUvJCIWPblyvkv18G
 cHeecgARXDy0qbNu87GMzRwTWsQ6hH1DA4CKB8xacFDB/pUNT9MYeNBFdo97u+529Vqq
 ak8fL0VNH+1IhYibp8s5g2I/3NfYNybLgD/DLqGzN+R3APLUrhUTUk/wn4ebp9qZItLg
 3zSdwvoAVEr07C2uewaQty4BhdWifu7hiArvYOPJ/EPPgeqZsjyoRsVb21oMlvHeTQT0
 1Kqo2dZZ3kn0qcxk9ZuM83toxrzSlsDCEF92W/RvXo36yPYHWRHvvA2ebgT4nM2a2126
 rtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752175889; x=1752780689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+CVoHFDG09GyMpm6YXkqKO/4WQ7emjQmymhG7B5z3Y=;
 b=FV1gidX78VvPocxjtrPb6l9A+EhgFR1YyTY6iEPqgEKeE97XsO9O1ZPMA60wDzSVlO
 TWY+AmMc7w5trB3pbmrAHNSy9XQ77df4/IhAOqmiJjH06M54sy9NC5XfIsQZYKFOcQ0q
 4QXI5Zu5IzHyBz+tiRHRPqhmI/LyUzzWn8toAC/gOPSZA7w8wWDNlM06fIpJ9CIVUPZM
 5qfsoZoYAcKTtX+0wKR6kMa4dAqSEe2TERIg/ZUjT6Pc0m8te44ogd7jThh4teN9KwGl
 EL94LZWDnWaQ2pbiAinw0Q036rNT7bvJ28TZF/m6aIommFrTl2L6MVMY+3/ICe+D6opx
 rY2A==
X-Gm-Message-State: AOJu0YyLjYPa4FtVIcfGJfjiIJoGutMhttSVojiThDI6F3IhdtYeHqcn
 JzchlWinuP4NRSjgTRnVd6rmpR6TaVx2EpGjP6fWNneLzqedtnBaN8zEimcZta4JI3G+twX1uue
 qKt317Nvds1AmnnIG3n7HHXdqvXU7He4r2vJJ6z+o/EBmaD23/PXY
X-Gm-Gg: ASbGncvfK+JjsmHOfpAz35rafilrYM5M7y0AtG5PsUmrMukPTKpOEiSh51eTukddoe/
 BeJLKw/XwMjRc9I9pqeewCtGFYs2UjmZ1J4moY7H9pbsMf2241SH4pGSpMuozU3gjvfklCYdmM6
 skuBPEwzVerfC2DmwwJxKRXUIV04+0ygr3hRQ1k25nNjuq
X-Google-Smtp-Source: AGHT+IHR0JB9e922jN+Lz2I7W8+/j0XfmvvsWKAkQQs4MB9tKthPS1ttnmii024y9ogmDKawzcTxBdVPM02JJLPHQ6Q=
X-Received: by 2002:a05:690c:6e88:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-717d78b2f33mr6261297b3.11.1752175889654; Thu, 10 Jul 2025
 12:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
 <20250710170707.1299926-3-peter.maydell@linaro.org>
In-Reply-To: <20250710170707.1299926-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 20:31:15 +0100
X-Gm-Features: Ac12FXwPiJgqRP0TfKbItnrdf3mzQ_lnF8Nu5h9jibhJVqkgd1tVqG2NC92iJLI
Message-ID: <CAFEAcA9y3GNTr5o2LPMH=jgnABSgLC7MBxo58aacmTTxScHGig@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user/gen-vdso: Don't write off the end of buf[]
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 10 Jul 2025 at 18:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In gen-vdso we load in a file and assume it's a valid ELF file.  In
> particular we assume it's big enough to be able to read the ELF
> information in e_ident in the ELF header.
>
> Add a check that the total file length is at least big enough for all
> the e_ident bytes, which is good enough for the code in gen-vdso.c.
> This will catch the most obvious possible bad input file (truncated)
> and allow us to run the sanity checks like "not actually an ELF file"
> without potentially crashing.
>
> The code in elf32_process() and elf64_process() still makes
> assumptions about the file being well-formed, but this is OK because
> we only run it on the vdso binaries that we create ourselves in the
> build process by running the compiler.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Hardening all of elf*_process() seems like overkill, but this is
> an easy check to add.

Subject line should say "read off the end", of course.

-- PMM

