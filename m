Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C35C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBZo-0001Li-Ed; Thu, 22 Aug 2024 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shBZm-0001JF-KW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:26:22 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shBZk-0008SS-P8
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:26:22 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso12883121fa.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724347578; x=1724952378; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDWawPDdPDYlDTUwOxFNErxvQ5kYimgSyNrrZhVxbbA=;
 b=rbt7eVw6SlgR3jf3z1YOBAi0tSwCqh77WPUpEzlV3d6UtfQz3XGVNhqYfxNS3UyNck
 /Iyaz5PP9LpIMqFmpoTTiCUMOwqRcUmQRHPgAoivK27h7C6SgKqc4VkjKfKonCPJfpfO
 KlxlIY9r/rbJEIq6n7zsQc5m2zR9IBVYccc/+NaEIuyE3uarWsPybmgZfWDQlqZrz3Y1
 n0bsKaBZJOHt+lriMjrGukTxD50vqg4ZvIzUj5jwHO1tJQPlKgSBNZQ5R06jI5reaedE
 VKmlpKK3CfIhWbDFv++2K0D6N1onbgiMHphVuu9pD0oXMhmxP1mDTqsD1+0hfJZzXaL2
 5WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724347578; x=1724952378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDWawPDdPDYlDTUwOxFNErxvQ5kYimgSyNrrZhVxbbA=;
 b=pjIIVeOun9wlLG6fG4cFeWpHebFn4rhiCFlTL8nScVnQNRMBfDbeQcYyiRuzCBCwUP
 LZUT0IoWCTb2gGab+OSIB6xpuCkDHHyevtF7yFrZ4ZsHcsQVmqvzK8mddoVgR8qEQ0oM
 AMFg7xoJzLW3VqRN7fS8yFR+VoV1Uex58mSA4O2Cm5k/CWxgG6MYFsh4hizjfYlOxVrZ
 HpSQfz5ovqFrcUz4tydH7HIuPcglBNwDH0NwsnUDz8fn4/KlQ4GoASnSzBy4C8Z8vUKb
 f7yqCpoOFmPOkTpNK26hSZARS9AzuTu70iMTKqFR7EkRd57EyPMQ/xx4bhjBVQJ6wNz0
 gtnA==
X-Gm-Message-State: AOJu0YygFN/vhSc4n59cxQmYKzaXlnnqBINBo2T9Q6Hcxvvf2DAk6z5F
 CiYzA238dZ4vhD1/d0kNuqU1iOBRVixaPMJa3K4ERP9MZ59SgDiDD7yXDQ1UPhDHDjjZNoli1XJ
 JmZJzgjtTSK/YFW869UshZYcVukZKzmv0nLWsYQ==
X-Google-Smtp-Source: AGHT+IH8GLjzFscLNJAMsoz4/dlcda/GuVFLV89b8iegWHYKCtDGYGCysAHQ0TjcQ9Lp7BkC3PyP06KBYKS+WJ4L4DM=
X-Received: by 2002:a2e:96cd:0:b0:2ef:226e:e150 with SMTP id
 38308e7fff4ca-2f405eefe58mr15954911fa.32.1724347577838; Thu, 22 Aug 2024
 10:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGMt57fehAuo7jLURogTVPtRosEWZ_hC+5yb5+hCBumJxjAbnw@mail.gmail.com>
In-Reply-To: <CAGMt57fehAuo7jLURogTVPtRosEWZ_hC+5yb5+hCBumJxjAbnw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 18:26:06 +0100
Message-ID: <CAFEAcA-1ErdvcBB75tpE4MEx2Wh0ZjukURvo=ff+Qr5w7PbhMg@mail.gmail.com>
Subject: Re: [PATCH v2] target/ppc: Fix migration of CPUs with TLB_EMB TLB type
To: Arman Nabiev <nabiev.arman13@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Thu, 22 Aug 2024 at 17:57, Arman Nabiev <nabiev.arman13@gmail.com> wrote:
>
> From: Arman Nabiev <nabiev.arman13@gmail.com>
>
> In vmstate_tlbemb a cut-and-paste error meant we gave
> this vmstate subsection the same "cpu/tlb6xx" name as
> the vmstate_tlb6xx subsection. This breaks migration load
> for any CPU using the TLB_EMB CPU type, because when we
> see the "tlb6xx" name in the incoming data we try to
> interpret it as a vmstate_tlb6xx subsection, which it
> isn't the right format for:
>
>  $ qemu-system-ppc -drive
>  if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
>  -monitor stdio -M bamboo
>  QEMU 9.0.92 monitor - type 'help' for more information
>  (qemu) savevm foo
>  (qemu) loadvm foo
>  Missing section footer for cpu
>  Error: Error -22 while loading VM state
>
> Correct the incorrect vmstate section name. Since migration
> for these CPU types was completely broken before, we don't
> need to care that this is a migration compatibility break.
>
> This affects the PPC 405, 440, 460 and e200 CPU families.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Arman Nabiev <nabiev.arman13@gmail.com>
> ---
>  target/ppc/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 731dd8df35..d433fd45fc 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -621,7 +621,7 @@ static bool tlbemb_needed(void *opaque)
>  }
>
>  static const VMStateDescription vmstate_tlbemb = {
> -    .name = "cpu/tlb6xx",
> +    .name = "cpu/tlbemb",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = tlbemb_needed,

Thanks for resending this -- looks good to me now.
I've added the ppc maintainers on CC so they can pick it up.

-- PMM

