Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D2EC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSrF-0005bI-1e; Mon, 29 Jul 2024 12:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSrC-0005Vl-Li
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:04:18 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSr9-0008QA-RU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:04:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so5405902a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722269054; x=1722873854; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m3pdyl7Suqil01UkgpZERGKDZbVS/MAqqLsFE230CZk=;
 b=AzeJvYPmTa9Os1QJk2uEMmOfudozKfUBBA6GXqf4/Dk7QnO30CZPORPzWxJRQ9DN8t
 3iFN2ZiyuwNR6eEMKfM/ATr4VF+ilRj5uLggNw4DTlGqcqZJdNRPGzaasaLZ8wnfTavI
 UZkLSwPk+GHFLAVHjUh9n2+FOgFe0mX/xqrhpC8xvS01IAKajXPtS25orXoWOpToPmHh
 D+9e3+UrWkadYfqmdtytXyqk2DFa67FjYggYEG1avAi0jyyUGFuNCQTlMJf+JB+xuJLA
 CmDMwQlWUKF6l0NON3AcGfJjUE6in1YfSMR/XUVQaPtn0vuuX3UoBOMZh4BCcYXuh7Fp
 BNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269054; x=1722873854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3pdyl7Suqil01UkgpZERGKDZbVS/MAqqLsFE230CZk=;
 b=qIkq+Zk/LfxSNlhhJ714BI3YX58TXG2L4cdak6zRxkVRFYxj3jGVTVIO3VvLatLs+i
 vZts4sKWVqoKqrwG65lMjp7uqV5e3IzoTPafnE0S+1SzunADfPjVjkl2SiuV/VRizf10
 NEVlpa78/MXC5r10DRfzB8IzsgKX7B3u1EAihO1BOkkvW2gEeXrNpp8VoHtt0N21otJp
 bSlCUzHE1hMnqK7CqcXqdONinoS4QxknhvhlU3OCvcHNcJrvsKzr/GsHrF7bbWBU1r73
 r0y4q+RWdQO01aKekttonqQe1Xkh754S7sADh9lA9PQ3NzKSKB04jDCBL9xjq7y7C+sl
 74FA==
X-Gm-Message-State: AOJu0YzpDXoMit5A5EQ+80XMhY9NEb7xy5cSKgJm+lhxilc3Z3yfhFtV
 aI0YNwN4sbDuetb4EzPdXlmleAi2KljVqzub3Tj5teBC2OQTQCM9BhMRGw2T0+EPEOZRjB78jzy
 CTTTZ+Gvnk61x+qJGXg+Qj7q/DzJLx0jz6WbTZwsCNSe6gH1T
X-Google-Smtp-Source: AGHT+IEvjiOT+x3sgpKd4duYwbofrcS7LAqJHyHFw6V/JrYUi+Ci7WxnoIvyZ7ItyGGkekmpH6nmNLiIT8juhuhNX34=
X-Received: by 2002:a50:d694:0:b0:5af:be6c:647d with SMTP id
 4fb4d7f45d1cf-5b021d22188mr6174285a12.24.1722269054113; Mon, 29 Jul 2024
 09:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240723170513.1676453-1-peter.maydell@linaro.org>
In-Reply-To: <20240723170513.1676453-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 17:04:03 +0100
Message-ID: <CAFEAcA8bs5OsHjcxnCvq7WOi6sT4khQSnZ0_VaVh1-waW=SmAQ@mail.gmail.com>
Subject: Re: [PATCH] system/physmem: Where we assume we have a RAM MR,
 assert it
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 23 Jul 2024 at 18:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the functions invalidate_and_set_dirty() and
> cpu_physical_memory_snapshot_and_clear_dirty(), we assume that we
> are dealing with RAM memory regions. In this case we know that
> memory_region_get_ram_addr() will succeed. Assert this before we
> use the returned ram_addr_t in arithmetic.
>
> This makes Coverity happier about these functions: it otherwise
> complains that we might have an arithmetic overflow that stems
> from the possible -1 return from memory_region_get_ram_addr().
>
> Resolves: Coverity CID 1547629, 1547715
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> --

I'm doing a target-arm pullreq so I'll take this patch
through that, unless you'd prefer otherwise.

thanks
-- PMM

