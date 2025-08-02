Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30EC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIrz-0004JI-R7; Sat, 02 Aug 2025 16:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiInD-0007U2-2y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:25:26 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiInB-0003YT-Mv
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:25:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71b6703ba32so22114087b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166320; x=1754771120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/v4geytOD6cSK1xAsVP7Norw//yqnyw8AaA00gpZjcs=;
 b=txIKUAAIt+47DbtkdTQQ9l6MEG96xirXDCC3iGCRAh2TqB1e5ofKklTZOwqU7gkWoV
 3nj57fNAHodu8e9xGNohHXdmqG0OkAf0VJOVofK8xTl35Z5XO8O5BDTIzEyvYMxFwYTn
 mv6QPO39m8qhxVEq599/v6h9ZisEun+Rf183PzSZS6YIZWfyUevIkZXT9WkJfAuzbe0k
 ycpVjDbNWikjJO/uoZ9gdTF7P5oshYjQVoyB9Cb/tUnak2MrVgLgvSFwfRvsPcUUvZ8N
 0gTsGxkUW9LtgglPnMpx1QJsxn8RyBeNHTiNJDDxbsqz6zz33SNbywGEB266DC+0+15h
 0UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166320; x=1754771120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/v4geytOD6cSK1xAsVP7Norw//yqnyw8AaA00gpZjcs=;
 b=FnPNcV02B+zGfG99UBMPY93TjAluBEnt4qt5XfmXEv20BEyMY9DFSpqvCcLGYUJiiK
 AmCbobAuCSJcjsnZspNFBKBbiuvP+uECwVzgnnHWDFvUwykx7gyMANJzzguteZWAmsW4
 axAvZ7h7lxJcW/5oROv715W9cuAm6cFqOmYRzBc+vl6K7zwsRIFjglEPUZhhqCECxcEu
 Vl5Pfnz1+J9AOC7jsugM0VLP/5e4+nZIoGbFRzCtpFxcKJp+00p14seFuT5PkUjAP3xm
 T8W73xOACTgGqh5hyaFtgnKaQcQphOnSN5RzloXO3pDosZ1aOT+ubQSgq5hPAyYwB1Mp
 6YwQ==
X-Gm-Message-State: AOJu0YzTc5xasnQNjX+lWuiYTD8HfK4lCMIJqbcwNICXhIv6CvRYRJRY
 /Mv0n++S/rr30fXqmAzXB5iBKpuoj0rb6TIqNNDC37axCwrSasZzjmtGJHYmO0vKKGKBB8EcAy4
 lVfwDRci0nq2DJ9JOSSpiZ8ZLvKlHwlq/qdjIifzdkRj8XQZmdgFC
X-Gm-Gg: ASbGncv7ArGvTdFGSHbpiRct5pz3Dk17lTCRdfvNcA2kA9WaumyHqaWCQhzz/mkpN3R
 bAppr/wCsUXwZS1orfndQlcQk3ov3IYR77QJc0spP/Zv9iG4AzNTukUWDzZLth31WAC/JHhR8gF
 LZQQ/l282bgaM5W5MZMdNnGBbWreZ7akAn3ev+v1uC+SRg4io4pz+Mt7OF31oWOvrHPIFjYepaX
 3x8OGT3
X-Google-Smtp-Source: AGHT+IHQfZsJJgDf1C8saO87NN9sRgA0JV3iN5IFMWTmeh2JuWb4+kL4e04oJmZsA12+5oPslkynjruFAohyqfb9GZY=
X-Received: by 2002:a05:690c:39c:b0:71a:2961:e2c8 with SMTP id
 00721157ae682-71b7f3cafbcmr48551337b3.10.1754166320311; Sat, 02 Aug 2025
 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-66-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-66-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:25:08 +0100
X-Gm-Features: Ac12FXxu6FNBXhbPZUZvh7cJzZ6pixWdWyj5tPnkmTMfbgNvk3KdzdThA5WXUPY
Message-ID: <CAFEAcA8QRhKnjkZq1Oj+vSjwhOeTbVLoJci1JEF+W=GVuaa_mA@mail.gmail.com>
Subject: Re: [PATCH 65/89] linux-user: Move elf parameters to
 sparc/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 30 Jul 2025 at 01:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sparc/target_elf.h | 11 +++++++++++
>  linux-user/elfload.c          | 15 ---------------
>  2 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

