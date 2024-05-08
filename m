Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C0EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gzT-0007Ah-0I; Wed, 08 May 2024 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4gzM-00079o-Ix
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:05:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4gzG-0005yX-Gy
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:05:40 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so1001260266b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715173532; x=1715778332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vxPJKOHaknKXAeg1AOSltuDVDfUYw46bXnwKujMFP30=;
 b=JK9EKMjC4KYemC/LS7Oiz4pnB938T8ogglDo+CwpWIiyP6Y7xfIWX8w5efRCXYlBxy
 ubmxxUDZDdFriL8cKLLndFAiIDSo/HHSYi+w4IUKWqZzNk2fuizJqntvok8TPkuS632C
 pAo9J4sLccT1fEgifWzqZRU7tY47IXddgkVYeeJI1vzsT3AbFu2Z3UOrKAA0g6OIYgq0
 MoxJkA/sZFZNzAVKK2vRYJoE1bEnlqk5kEYWfisO5O000gzfH5YaGlhZrGElLLNAfvuw
 myNFgUXv4ElMo7buG2OPD8XVB5dYa78AYHoNZ4nel9vsvBtt4SaAYshrIaPjkgfhVBaX
 qfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173532; x=1715778332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vxPJKOHaknKXAeg1AOSltuDVDfUYw46bXnwKujMFP30=;
 b=to10wpBhSxejMMVNf95eo9E1YFkEI/dihXdkIqv9wiJlF7w52UQO67llueijW2xnBq
 H0oC9UtDoxgXa5e224a+jadoW4fKApkaf17Va1Ka0OI8UB7hZa2h0hLtMRU24Se8uwMU
 WLR/dQjwgK+G1uk/25hAPn5wsrsZiqXbhJrkJB37w9k/igaIaQOMYGqJgwKcr1O0de10
 T4vo/ccTzHJ6AZ1HOJ0RlMcYBEuS0WQ7zLiCrp/tkMNC0sRyglecnAl63CAUpyVjyZ+G
 gSCbwJ1qk2cK0pCmXzLO/wA5iNVRQwV+f486ReUbDfz+NKQtpMYlJjaINmh1qIsinNYr
 x+Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRYBxykivmNoPaKW4aght00M+opNsi+QyMiEnyxyIf5sTGmDRydpG4F/+gLfgMmsqur/wiqpFfSx7GJCPbvp+9bIvCC9Y=
X-Gm-Message-State: AOJu0Yx629j1oO8kI9hTOvpvjWVibSVqeFu+8IlGomzAcO1lZm4Wgv+w
 bLYwaufOxTv6Zfi7kSYDbDAxZbUp4qBnr1Ytv2/XPZSNrhNqenURTiZ2c7UpSrCb3TOLLgJ+pC7
 HtVd7K/umCiKM86jk8zDTaqK7YW4kqrHzP3wf9Q==
X-Google-Smtp-Source: AGHT+IHo7PpkrauQCcsVbD/2oQAsegFtfok0gRXuLV1CLB4ayYTCu0zpb4IGsRXrxBW1TmWKMhJlCf3fA3CGNkSODHw=
X-Received: by 2002:a50:a45d:0:b0:572:d1e1:b4b3 with SMTP id
 4fb4d7f45d1cf-5731d9ce4f1mr1796985a12.7.1715173532493; Wed, 08 May 2024
 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240507022239.3113987-1-gaosong@loongson.cn>
 <d086f072-5e0f-4cd4-a375-8d809fff8085@tls.msk.ru>
In-Reply-To: <d086f072-5e0f-4cd4-a375-8d809fff8085@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2024 14:05:21 +0100
Message-ID: <CAFEAcA9rasjARhiZXuNdLX9YJ02CAbV8+QtuM_ieoKrc+a4gUg@mail.gmail.com>
Subject: Re: [PATCH] hw/loongarch/virt: Fix memory leak
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 richard.henderson@linaro.org, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Tue, 7 May 2024 at 10:52, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 07.05.2024 05:22, Song Gao wrote:
>
> >       for (i = 1; i < nb_numa_nodes; i++) {
> >           MemoryRegion *nodemem = g_new(MemoryRegion, 1);
> > -        ramName = g_strdup_printf("loongarch.node%d.ram", i);
> > +        g_autofree char *ramName = g_strdup_printf("loongarch.node%d.ram", i);
>
> Can't this be a fixed-size buffer on stack?

No, this is a really bad idea. It's a pain to audit that the
array really doesn't get overwritten, and if the string we want
to write changes, now we have to re-count characters to decide
if we need to increase the size of the array. The memory allocation
on the heap here is a tiny overhead that we only incur at startup.
The g_autofree approach is much better.

For this version of the patch:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

