Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4566BC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJD9I-0002sw-2o; Mon, 17 Jun 2024 10:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJD9F-0002sH-Ky
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:15:54 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJD9D-0002R8-DW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:15:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57c83100cb4so5026604a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718633748; x=1719238548; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X9gMVsoTJyIF3QZmp/9lmRiL6IT2n3IDCF8NgoHqquc=;
 b=uY6uU5l8EKM0brUOO4dDruI2uO5KVGMdjJXLY2kwKMuekCinNnuHMDAxBR/e5vU+xB
 O5SsUNr6A3zPfzYxb+0PKkenlSF49IJ+nOG07A+nKIENstUIvURI6uIzLHsYEGK+b+ft
 QSotcI/lLAJYifayo35pAOpjyGmJBOZZwyXJXyA4L6cFsOHr5EIS+mXkrgBJRnTkjrh4
 Mfi9u6viOknWsp15K2iHSv6O4LGUHQa0ioDPjyTVfBsdNMsguddasXdsqoJSGV1gTuoD
 wW0xAshe6BTHLLlgmbvEWp1wM4JRbVYH7dlZFdb5fCrCfCoBWlGPbaj7twsyeWqTLv29
 GwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718633748; x=1719238548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9gMVsoTJyIF3QZmp/9lmRiL6IT2n3IDCF8NgoHqquc=;
 b=KX/z5KDoOvdwm4h822MrU49ZmGGuO4+YbdqMb+fISufkrWCTE7trEZNMyi3xx8Q+Fu
 exI1EijS0SLFSwIFKjs1shG90EESUG/EU6/FGrdYX3qGdHVcw09qWKEjJ+TdVgKDxePN
 ipqCDDxUPloa7+NmdeRqczk0qEJbXa/doojEgahAjK5BgcLieBCcf2wGi25Uwguo718Z
 ZzBYRuy1Zqblt+fJqAm7VWEV4JSxWFT8Kt3acWqniVTV1YhbBIhxZTTQw8lwuAF9JtNj
 CxklaMhW42n8VwbSi0GBQtNmgJUZNRvm8V3U8T99Nh7Gh7K3L7fYyQf60e+u1PASSJQ2
 rapA==
X-Gm-Message-State: AOJu0YwA/tCDuN4y6reu90IPsPL97QgZ0BetZIrVIelWBpB3nLCKqMZ2
 MWR1B0nxB6HGNUdCEQE8fK3BwlFh0vIkC7z7KPfTIVKeejognsFu2/IJ3fEFSXRpyHZUQspEp2b
 lQfIjboWQDiJH3vOJA2yfIyIYS3P+SqmnRAKYaw==
X-Google-Smtp-Source: AGHT+IFCgwTPsxhADF8WnDUFQ3KxYB8F0Hgi8Mm6l+d4t1ih83FEuold4elfxgt0nd7BZBlU86MmsZFEQpWuaOEZhJQ=
X-Received: by 2002:a50:c307:0:b0:57c:6861:d72a with SMTP id
 4fb4d7f45d1cf-57cbd696c69mr5794592a12.4.1718633748146; Mon, 17 Jun 2024
 07:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <3ce6d142356cb061b64d71a4e39525d9d7c52b12.camel@infradead.org>
In-Reply-To: <3ce6d142356cb061b64d71a4e39525d9d7c52b12.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2024 15:15:36 +0100
Message-ID: <CAFEAcA-h=sMNBrt1763T6OcPVvWRGdfJfKXAJR-f80dJmtDDLg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/fw_cfg: Add etc/e820 to fw_cfg late
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 17 Jun 2024 at 14:46, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> In e820_add_entry() the e820_table is reallocated with g_renew() to make
> space for a new entry. However, fw_cfg_arch_create() just uses the existing
> e820_table pointer.
>
> This leads to a use-after-free if anything adds a new entry after fw_cfg
> is set up. Shift the addition of the etc/e820 file to the machine done
> notifier, and add a sanity check to ensure that e820_table isn't
> modified after the pointer gets stashed.

Given that e820_add_entry() will happily g_renew() the memory,
it seems a bit bug-prone to have e820_table be a global variable.
Maybe we should have an e820_add_fw_cfg_file() which does the

    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
                    sizeof(struct e820_entry) * e820_get_num_entries());

-- that would then let us make e820_table be file-local, and so
it's then easy to audit that all the functions that look at
e820_table check that the table has been finalized first (because
they're all in this one file).

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  hw/i386/e820_memory_layout.c | 8 ++++++++
>  hw/i386/fw_cfg.c             | 7 ++++---
>  hw/i386/microvm.c            | 5 +++--
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
> index 06970ac44a..c96515909e 100644
> --- a/hw/i386/e820_memory_layout.c
> +++ b/hw/i386/e820_memory_layout.c
> @@ -8,13 +8,20 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/bswap.h"
> +#include "qemu/error-report.h"
>  #include "e820_memory_layout.h"
>
>  static size_t e820_entries;
>  struct e820_entry *e820_table;
> +static gboolean e820_done;
>
>  int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>  {
> +    if (e820_done) {
> +        warn_report("warning: E820 modified after being consumed");
> +        return -1;
> +    }

I think this should be a fatal error (i.e. assert) -- it should
never happen, and always would be a bug in QEMU somewhere.

Currently e820_add_entry() returns the number of entries
currently present. Of the various callsites, almost all ignore
the return value. Two treat it as a "negative means error"
situation (with an error handling path that's currently dead code):
target/i386/kvm/kvm.c and target/i386/kvm/xen-emu.c.

My suggestion is that we make e820_add_entry() return void,
and remove that dead error handling path.

thanks
-- PMM

